import Mathlib
import HamiltonsCubic.Results.L219GenOps
import HamiltonsCubic.Results.L219Diag

set_option linter.style.longLine false

/-!
# L219's diagonality clause in every orthonormal frame

[findings/second-order.md](../../../findings/second-order.md), Lemma L219: *$W$ is coordinate-diagonal in an orthonormal
frame $(e_1,\dots,e_n)$ exactly when its $\sigma_{e_k}$-odd part vanishes for $k=1,\dots,n-1$.* [L219Diag.lean](L219Diag.lean)
proves it in the coordinate frame (`diagonal_iff_even`, `diagonal_iff_even_but_one`). A general frame is the columns
$u_k=Ue_k$ of an orthogonal $U$, and $W$ is diagonal in it when $W=U\,D\,U^{\mathsf T}$ for a diagonal $D\in\mathcal D_n$,
that is `rotR U` of a coordinate-diagonal operator, which sends $u_i\wedge u_j$ to $w_{ij}\,u_i\wedge u_j$.

* `flip_eq_Su`, `Su_col`: the coordinate reflection is $S_{e_k}$, and $S_{Ue_k}=U S_{e_k} U^{\mathsf T}$;
* `sig_eq_rotR`, `rotR_Su_col`: $\sigma_{e_k}$ is `rotR` of the coordinate reflection, so $\sigma_{u_k}=U\sigma_{e_k}U^{\mathsf T}$;
* **`diagonal_iff_even_frame`**, **`diagonal_iff_even_but_one_frame`**: at a Weyl $W$, $W$ is diagonal in the frame
  $(u_k)$ iff $\tfrac12(W-\sigma_{u_k}W)=0$ for every $k$, iff it vanishes for every $k\ne k_0$.
-/

namespace HamiltonsCubic.L219FrameDiag

open Matrix HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.FrameLayer HamiltonsCubic.L214Op
  HamiltonsCubic.FrameOp2 HamiltonsCubic.L219Gen HamiltonsCubic.L219GenOps HamiltonsCubic.L219Op HamiltonsCubic.L219Diag
  HamiltonsCubic.Results HamiltonsCubic.L120Hess HamiltonsCubic.FamilyLayer

variable {n : ℕ}

/-- The `k`-th column of `U`, the frame vector `u_k = U e_k`, as a function (Mathlib's `Matrix.col` is a matrix). -/
def fcol (U : Matrix (Fin n) (Fin n) ℝ) (k : Fin n) : Fin n → ℝ := fun a => U a k

/-- The frame vectors are unit, so `σ_{u_k}` is L219's reflection at a unit vector, the hypothesis `hu` of
[L219Gen.lean](L219Gen.lean) and [L219GenOps.lean](L219GenOps.lean). -/
theorem fcol_unit {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) (k : Fin n) : ∑ a, fcol U k a ^ 2 = 1 := by
  have e := congrFun (congrFun hU.1 k) k
  rw [Matrix.mul_apply, Matrix.one_apply_eq] at e
  rw [← e]
  refine Finset.sum_congr rfl fun a _ => ?_
  simp [fcol, transpose_apply, sq]

/-- **The coordinate reflection is `S_{e_k}`.** -/
theorem flip_eq_Su (k : Fin n) : Results.flip k = Su (Pi.single k 1) := by
  ext i j
  simp only [Results.flip, Su, Matrix.diagonal_apply, Matrix.sub_apply, Matrix.one_apply, Matrix.smul_apply,
    Matrix.vecMulVec_apply, Pi.single_apply, smul_eq_mul]
  by_cases hij : i = j
  · subst hij; by_cases hik : i = k <;> simp [hik]; norm_num
  · simp [hij]
    by_cases hik : i = k <;> by_cases hjk : j = k <;> simp [hik, hjk]
    exact hij (hik.trans hjk.symm)

/-- **`S_{U e_k} = U S_{e_k} Uᵀ`.** -/
theorem Su_col {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) (k : Fin n) :
    Su (fcol U k) = U * Results.flip k * Uᵀ := by
  rw [flip_eq_Su]
  unfold Su
  rw [Matrix.mul_sub, Matrix.sub_mul, Matrix.mul_one, hU.2, Matrix.mul_smul, Matrix.smul_mul]
  congr 2
  ext i j
  simp only [Matrix.vecMulVec_apply, Matrix.mul_apply, transpose_apply, fcol, Pi.single_apply]
  simp [mul_comm]

/-- **`σ_{e_k}` is the frame change by the coordinate reflection.** -/
theorem sig_eq_rotR (k : Fin n) (V : CurvOp2 (Fin n)) : sig k V = rotR (Results.flip k) V := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  have e : cS k X = cU (Results.flip k) X := Subtype.ext (by rw [cS_coe, cU_coe])
  rw [sig_apply, cS_coe, rotR_coe, e, flip_T]

/-- **`σ_{u_k} = U σ_{e_k} Uᵀ`.** -/
theorem rotR_Su_col {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) (k : Fin n) (V : CurvOp2 (Fin n)) :
    rotR (Su (fcol U k)) V = rotR U (sig k (rotR Uᵀ V)) := by
  rw [Su_col hU, sig_eq_rotR, rotR_comp, rotR_comp]

theorem half_odd_iff (A B : CurvOp2 (Fin n)) : (1 / 2 : ℝ) • (A - B) = 0 ↔ B = A := by
  constructor
  · intro h
    have hz : A - B = 0 := by
      have e : A - B = (2 : ℝ) • ((1 / 2 : ℝ) • (A - B)) := by module
      rw [e, h]; module
    calc B = A - (A - B) := by module
      _ = A - 0 := by rw [hz]
      _ = A := by module
  · intro h
    rw [h]
    module

/-- The odd part under `σ_{u_k}` vanishes iff the odd part of `Uᵀ W U` under `σ_{e_k}` does. -/
theorem odd_frame_iff {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) (k : Fin n) (W : CurvOp2 (Fin n)) :
    (1 / 2 : ℝ) • (W - rotR (Su (fcol U k)) W) = 0 ↔ (1 / 2 : ℝ) • (rotR Uᵀ W - sig k (rotR Uᵀ W)) = 0 := by
  rw [half_odd_iff, half_odd_iff, rotR_Su_col hU]
  have hUt := FrameLayer.isOrth_transpose hU
  constructor
  · intro h
    have := congrArg (rotR Uᵀ) h
    rwa [rotR_comp, hU.1, rotR_one] at this
  · intro h
    rw [h, rotR_inv hU]

theorem diag_frame_iff {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) (W : CurvOp2 (Fin n)) :
    (∃ (w : Matrix (Fin n) (Fin n) ℝ) (hw : IsWeight w), rotR Uᵀ W = RealLayer.restrict (diagOp_isWeyl hw)) ↔
      ∃ (w : Matrix (Fin n) (Fin n) ℝ) (hw : IsWeight w), W = rotR U (RealLayer.restrict (diagOp_isWeyl hw)) := by
  constructor
  · rintro ⟨w, hw, h⟩
    exact ⟨w, hw, by rw [← h, rotR_inv hU]⟩
  · rintro ⟨w, hw, h⟩
    refine ⟨w, hw, ?_⟩
    rw [h, rotR_comp, hU.1, rotR_one]

/-- **L219's diagonality clause in every orthonormal frame.** At a Weyl `W` and an orthogonal `U` with columns
`u_k`, `W` is diagonal in the frame `(u_k)` iff its `σ_{u_k}`-odd part vanishes for every `k`. -/
theorem diagonal_iff_even_frame {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) (W : CurvOp2 (Fin n)) (hW : IsWeyl2 W) :
    (∀ k, (1 / 2 : ℝ) • (W - rotR (Su (fcol U k)) W) = 0) ↔
      ∃ (w : Matrix (Fin n) (Fin n) ℝ) (hw : IsWeight w), W = rotR U (RealLayer.restrict (diagOp_isWeyl hw)) := by
  simp only [odd_frame_iff hU]
  rw [diagonal_iff_even _ (rotR_isWeyl2 (FrameLayer.isOrth_transpose hU) hW), diag_frame_iff hU]

/-- **`n − 1` reflections suffice**: the odd part vanishing for every `k ≠ k₀` already gives diagonality in the frame. -/
theorem diagonal_iff_even_but_one_frame {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) (W : CurvOp2 (Fin n))
    (hW : IsWeyl2 W) (k0 : Fin n) :
    (∀ k, k ≠ k0 → (1 / 2 : ℝ) • (W - rotR (Su (fcol U k)) W) = 0) ↔
      ∃ (w : Matrix (Fin n) (Fin n) ℝ) (hw : IsWeight w), W = rotR U (RealLayer.restrict (diagOp_isWeyl hw)) := by
  simp only [odd_frame_iff hU]
  rw [diagonal_iff_even_but_one _ (rotR_isWeyl2 (FrameLayer.isOrth_transpose hU) hW) k0, diag_frame_iff hU]

end HamiltonsCubic.L219FrameDiag
