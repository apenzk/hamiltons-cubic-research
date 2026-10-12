import HamiltonsCubic.Results.FrameTheta
import HamiltonsCubic.Results.L178Support
import HamiltonsCubic.Results.L176Op

set_option linter.style.longLine false

/-!
# L176 and L178 in every frame

Milestone 4 of [the frame-invariance plan](../../../reviews/2026-09-26-lean-frame-invariance-plan.md). With
[FrameInv.lean](FrameInv.lean)'s `isWeyl_conj` and [FrameTheta.lean](FrameTheta.lean)'s `invariants_conj`, a
coordinate-frame theorem transfers along any orthogonal `U`:

* **`L178_frame`**: L178 for the four-dimensional `V` that a frame change `U` carries onto the first four
  coordinates. If `U·R` is supported on the coordinate `Λ²ℝ⁴` with coefficient rank at most three, then
  `θ(R) = θ(U·R) ≤ √(3/2)`;
* **`diagOp_eq_WD`**: on bivectors, the layer's `diagOp w` is the coordinate-diagonal `W_w`;
* **`L176_someFrame`**: L176 for the layer's own predicate `IsCoordDiagonalSomeFrame`. If `U·R = diagOp w` with
  `w` a nonzero weight, the matrix of `R` in the rotated orthonormal basis `Uᵀ φ_{ab} U` has rank at least four.
-/

namespace HamiltonsCubic.FrameLayer

open Matrix HamiltonsCubic.RealLayer HamiltonsCubic.CP2Real HamiltonsCubic.L176

variable {n : ℕ}

/-- **L178 for every four-dimensional `V`**: the frame change `U` carries `V` onto the first four coordinates,
and `U·R` meets `L178_supported`'s hypotheses. Then `θ(R) ≤ √(3/2)`. -/
theorem L178_frame (hn : 4 ≤ n) {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U)
    {R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ} (hW : IsWeyl R)
    (hker : ∀ X, IsSkew X → (∀ i, inner2 X (eF i) = 0) → conjOp U R X = 0)
    (hran : ∀ X Y, IsSkew X → IsSkew Y → (∀ i, inner2 Y (eF i) = 0) → inner2 (conjOp U R X) Y = 0)
    (hrank : (Matrix.of fun i j => inner2 (conjOp U R (eF (n := n) i)) (eF j)).rank ≤ 3)
    (h0 : (Matrix.of fun i j => inner2 (conjOp U R (eF (n := n) i)) (eF j)) ≠ 0) :
    theta R ≤ Real.sqrt (3 / 2) := by
  rw [← (invariants_conj hU hW).2]
  exact L178_supported hn (isWeyl_conj hU hW) hker hran hrank h0

/-- **On bivectors, `diagOp w` is the coordinate-diagonal `W_w`** for symmetric `w`. -/
theorem diagOp_eq_WD {w : Matrix (Fin n) (Fin n) ℝ} (hs : ∀ a b, w a b = w b a) {X : Matrix (Fin n) (Fin n) ℝ}
    (hX : IsSkew X) : HamiltonsCubic.FamilyLayer.diagOp w X = WD w X := by
  have hlin : ∀ c : Fin n → Fin n → ℝ, HamiltonsCubic.FamilyLayer.diagOp w (∑ a, ∑ b, c a b • phi a b)
      = ∑ a, ∑ b, c a b • HamiltonsCubic.FamilyLayer.diagOp w (phi a b) := fun c => by
    ext i j
    simp only [HamiltonsCubic.FamilyLayer.diagOp, Matrix.of_apply, Matrix.sum_apply, Matrix.smul_apply,
      smul_eq_mul, Finset.mul_sum]
    exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by ring
  conv_lhs => rw [HamiltonsCubic.L41Statement.Frame.phi_expand X hX, hlin]
  unfold WD
  refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
  rw [HamiltonsCubic.FamilyLayer.diagOp_phi w hs, smul_smul]
  congr 1; ring

/-- The matrix of an operator on the orthonormal basis `{φ_{ab}}_{a<b}`. -/
noncomputable def coeffOp (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) : Matrix (Pr n) (Pr n) ℝ :=
  fun p q => inner2 (R (phi p.1.1 p.1.2)) (phi q.1.1 q.1.2)

/-- `U·R`'s matrix on `{φ_{ab}}` is `R`'s matrix on the rotated orthonormal basis `{Uᵀ φ_{ab} U}`. -/
theorem coeffOp_conj {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U)
    (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (p q : Pr n) :
    coeffOp (conjOp U R) p q = inner2 (R (psi U p.1.1 p.1.2)) (psi U q.1.1 q.1.2) := by
  unfold coeffOp conjOp
  rw [inner2_move hU]; rfl

/-- The matrix of an operator on the rotated orthonormal basis `{Uᵀ φ_{ab} U}_{a<b}`. -/
noncomputable def coeffRot (U : Matrix (Fin n) (Fin n) ℝ) (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) :
    Matrix (Pr n) (Pr n) ℝ :=
  fun p q => inner2 (R (psi U p.1.1 p.1.2)) (psi U q.1.1 q.1.2)

/-- **L176 for the layer's `IsCoordDiagonalSomeFrame`**, stated for `R`: if an orthogonal `U` makes `U·R` the
coordinate-diagonal `diagOp w` for a nonzero weight `w`, then `R`'s matrix on the rotated orthonormal basis
`{Uᵀ φ_{ab} U}_{a<b}` has rank at least four. -/
theorem L176_someFrame {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U)
    {R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ} {w : Matrix (Fin n) (Fin n) ℝ}
    (hw : HamiltonsCubic.FamilyLayer.IsWeight w) (hconj : conjOp U R = HamiltonsCubic.FamilyLayer.diagOp w)
    (h0 : w ≠ 0) : 4 ≤ (coeffRot U R).rank := by
  have hco : coeffRot U R = coeffD w := by
    ext p q
    rw [show coeffRot U R p q = coeffOp (conjOp U R) p q from (coeffOp_conj hU R p q).symm]
    unfold coeffOp coeffD
    rw [hconj, diagOp_eq_WD hw.symm (phi_isSkew _ _)]
  rw [hco]
  exact L176_op w hw.symm hw.hollow ((WD_weyl_iff w hw.symm hw.hollow).mpr hw.rowSum) h0

end HamiltonsCubic.FrameLayer
