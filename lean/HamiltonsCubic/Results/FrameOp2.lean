import Mathlib
import HamiltonsCubic.Results.FrameTheta
import HamiltonsCubic.Results.L0Witness
import HamiltonsCubic.Results.L214Op
import HamiltonsCubic.Results.L120Decomp

set_option linter.style.longLine false

/-!
# Frame changes on `CurvOp2`: `P`, the norm, the pairing and `T` are invariant on Weyl operators

The coordinate reflections of [L219Op.lean](L219Op.lean) act on `CurvOp2` by conjugation and preserve $P$ term by term.
A general orthogonal frame change $U$ does not permute the $\varphi$ basis, so its invariance is taken from the bare
layer, [FrameTheta.lean](FrameTheta.lean)'s `invariants_conj` ($\lVert\cdot\rVert$ and $\theta$ under `conjOp U` at a
Weyl operator), carried across `restrict` and `extend`:

* `cU`, `rotR U`: conjugation $X\mapsto U^{\mathsf T}XU$ on bivectors and its action $V\mapsto UV(U^{\mathsf T}\cdot U)U^{\mathsf T}$ on
  `CurvOp2`, linear in $V$; `rotR_eq_restrict`, at a Weyl $V$ it is `restrict` of `conjOp U (extend V)`;
* `rotR_isWeyl2`: the frame change preserves $\mathcal W_n$;
* **`Pcubic2_rotR`**, **`normSq2_rotR`**: $P$ and $\lVert\cdot\rVert^2$ are invariant at a Weyl $V$;
* `innerOp2_rotR`, `Tsym_rotR`: so, by polarisation, are $\langle\cdot,\cdot\rangle$ on Weyl pairs and $T$ on Weyl triples.
-/

namespace HamiltonsCubic.FrameOp2

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.FrameLayer HamiltonsCubic.L214Op

variable {n : ℕ}

theorem conj_skew' (U : Matrix (Fin n) (Fin n) ℝ) {X : Matrix (Fin n) (Fin n) ℝ} (hX : Xᵀ = -X) :
    (Uᵀ * X * U)ᵀ = -(Uᵀ * X * U) := by
  rw [transpose_mul, transpose_mul, transpose_transpose, hX]
  simp [Matrix.mul_assoc]

/-- Conjugation `X ↦ Uᵀ X U` on bivectors. -/
noncomputable def cU (U : Matrix (Fin n) (Fin n) ℝ) : skewSub (Fin n) →ₗ[ℝ] skewSub (Fin n) where
  toFun X := ⟨Uᵀ * (X : Matrix (Fin n) (Fin n) ℝ) * U, conj_skew' U X.2⟩
  map_add' X Y := Subtype.ext (by simp [Matrix.mul_add, Matrix.add_mul])
  map_smul' c X := Subtype.ext (by simp)

theorem cU_coe (U : Matrix (Fin n) (Fin n) ℝ) (X : skewSub (Fin n)) :
    ((cU U X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) = Uᵀ * (X : Matrix (Fin n) (Fin n) ℝ) * U := rfl

/-- **The frame change on `CurvOp2`**, `V ↦ U V(Uᵀ · U) Uᵀ`. -/
noncomputable def rotR (U : Matrix (Fin n) (Fin n) ℝ) : CurvOp2 (Fin n) →ₗ[ℝ] CurvOp2 (Fin n) where
  toFun V := LinearMap.toContinuousLinearMap ((cU Uᵀ).comp ((V : skewSub (Fin n) →ₗ[ℝ] skewSub (Fin n)).comp (cU U)))
  map_add' V V' := ContinuousLinearMap.ext fun X => by
    simp only [LinearMap.coe_toContinuousLinearMap', LinearMap.comp_apply, ContinuousLinearMap.add_apply,
      ContinuousLinearMap.coe_coe, map_add]
  map_smul' c V := ContinuousLinearMap.ext fun X => by
    simp only [LinearMap.coe_toContinuousLinearMap', LinearMap.comp_apply, ContinuousLinearMap.smul_apply,
      ContinuousLinearMap.coe_coe, map_smul, RingHom.id_apply]

theorem rotR_coe (U : Matrix (Fin n) (Fin n) ℝ) (V : CurvOp2 (Fin n)) (X : skewSub (Fin n)) :
    ((rotR U V X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)
      = U * ((V (cU U X) : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) * Uᵀ := by
  show Uᵀᵀ * _ * Uᵀ = _
  rw [transpose_transpose]
  rfl

theorem isLinOp_conj_extend (U : Matrix (Fin n) (Fin n) ℝ) (V : CurvOp2 (Fin n)) : IsLinOp (conjOp U (extend V)) := by
  refine ⟨fun X Y => ?_, fun c X => ?_⟩
  · unfold conjOp
    rw [Matrix.mul_add, Matrix.add_mul, (isLinOp_extend V).1, Matrix.mul_add, Matrix.add_mul]
  · unfold conjOp
    rw [Matrix.mul_smul, Matrix.smul_mul, (isLinOp_extend V).2, Matrix.mul_smul, Matrix.smul_mul]

/-- **At a Weyl `V` the frame change is the bare `conjOp`, restricted.** -/
theorem rotR_eq_restrict {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) {V : CurvOp2 (Fin n)} (hV : IsWeyl2 V) :
    rotR U V = restrict (isWeyl_conj hU (isWeyl_extend hV)) := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  rw [rotR_coe, restrict_apply]
  show _ = U * extend V (Uᵀ * (X : Matrix (Fin n) (Fin n) ℝ) * U) * Uᵀ
  rw [← cU_coe, extend_apply]

theorem rotR_isWeyl2 {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) {V : CurvOp2 (Fin n)} (hV : IsWeyl2 V) :
    IsWeyl2 (rotR U V) := by
  rw [rotR_eq_restrict hU hV]
  exact isWeyl2_restrict _

theorem normSq2_rotR {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) {V : CurvOp2 (Fin n)} (hV : IsWeyl2 V) :
    normSq2 (rotR U V) = normSq2 V := by
  rw [rotR_eq_restrict hU hV, normSq2_restrict (isLinOp_conj_extend U V), (invariants_conj hU (isWeyl_extend hV)).1,
    normSq_extend]

/-- **`P` is invariant under a frame change at a Weyl operator.** -/
theorem Pcubic2_rotR {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) {V : CurvOp2 (Fin n)} (hV : IsWeyl2 V) :
    Pcubic2 (rotR U V) = Pcubic2 V := by
  have hWe := isWeyl_extend hV
  have hP1 : Pcubic2 (rotR U V) = Pcubic (conjOp U (extend V)) := by
    rw [rotR_eq_restrict hU hV, Pcubic2_restrict (isLinOp_conj_extend U V)]
  have hP2 : Pcubic2 V = Pcubic (extend V) := by
    conv_lhs => rw [← restrict_extend hV]
    rw [Pcubic2_restrict (isLinOp_extend V) hWe]
  obtain ⟨hN, hT⟩ := invariants_conj hU hWe
  rw [hP1, hP2]
  by_cases h0 : normSq (extend V) = 0
  · have hV0 : V = 0 := normSq2_eq_zero (by rw [← normSq_extend]; exact h0)
    have e1 : Pcubic (conjOp U (extend V)) = Pcubic2 (rotR U V) := hP1.symm
    have e2 : Pcubic (extend V) = Pcubic2 V := hP2.symm
    rw [e1, e2, hV0, map_zero]
  · have hpos : 0 < RealLayer.norm (extend V) := Real.sqrt_pos.mpr (lt_of_le_of_ne (by
      rw [normSq_extend]; exact normSq2_nonneg V) (Ne.symm h0))
    have hn : RealLayer.norm (conjOp U (extend V)) = RealLayer.norm (extend V) := by
      unfold RealLayer.norm; rw [hN]
    unfold theta at hT
    rw [hn] at hT
    have h3 : RealLayer.norm (extend V) ^ 3 ≠ 0 := pow_ne_zero 3 hpos.ne'
    field_simp at hT
    exact hT

theorem innerOp2_rotR {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) {A B : CurvOp2 (Fin n)}
    (hA : IsWeyl2 A) (hB : IsWeyl2 B) : innerOp2 (rotR U A) (rotR U B) = innerOp2 A B := by
  have pol : ∀ X Y : CurvOp2 (Fin n), innerOp2 X Y = (normSq2 (X + Y) - normSq2 X - normSq2 Y) / 2 := by
    intro X Y
    unfold normSq2
    rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, innerOp2_comm Y X]
    ring
  rw [pol, pol A B, ← map_add, normSq2_rotR hU (isWeyl2_add hA hB), normSq2_rotR hU hA, normSq2_rotR hU hB]

/-- `T` recovered from `P` by polarisation. -/
theorem Tsym_polar (A B C : CurvOp2 (Fin n)) :
    6 * Tsym A B C = Pcubic2 (A + B + C) - Pcubic2 (A + B) - Pcubic2 (A + C) - Pcubic2 (B + C)
      + Pcubic2 A + Pcubic2 B + Pcubic2 C := by
  simp only [← Tsym_diag, Tsym_add_left, Tsym_add_mid, Tsym_add_right]
  have s1 := Tsym_23 A A B; have s2 := Tsym_12 A B A
  have s3 := Tsym_23 A A C; have s4 := Tsym_12 A C A
  have s5 := Tsym_23 B B A; have s6 := Tsym_12 B A B
  have s7 := Tsym_23 B B C; have s8 := Tsym_12 B C B
  have s9 := Tsym_23 C C A; have s10 := Tsym_12 C A C
  have s11 := Tsym_23 C C B; have s12 := Tsym_12 C B C
  have t1 := Tsym_12 A B C; have t2 := Tsym_23 A B C; have t3 := Tsym_23 B A C
  have t4 := Tsym_12 A C B; have t5 := Tsym_23 C A B; have t6 := Tsym_12 B C A
  linarith

/-- **`T` is invariant under a frame change on Weyl triples.** -/
theorem Tsym_rotR {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) {A B C : CurvOp2 (Fin n)}
    (hA : IsWeyl2 A) (hB : IsWeyl2 B) (hC : IsWeyl2 C) :
    Tsym (rotR U A) (rotR U B) (rotR U C) = Tsym A B C := by
  have h := Tsym_polar (rotR U A) (rotR U B) (rotR U C)
  have h' := Tsym_polar A B C
  rw [← map_add, ← map_add, ← map_add, ← map_add,
    Pcubic2_rotR hU (isWeyl2_add (isWeyl2_add hA hB) hC), Pcubic2_rotR hU (isWeyl2_add hA hB),
    Pcubic2_rotR hU (isWeyl2_add hA hC), Pcubic2_rotR hU (isWeyl2_add hB hC),
    Pcubic2_rotR hU hA, Pcubic2_rotR hU hB, Pcubic2_rotR hU hC] at h
  linarith

end HamiltonsCubic.FrameOp2
