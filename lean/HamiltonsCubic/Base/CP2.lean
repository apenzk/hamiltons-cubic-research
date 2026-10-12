import HamiltonsCubic.Base.Sharp

/-!
# `W_{ℂP²}` at `n = 4`, and its value

`Λ²ℝ⁴ = Λ⁺ ⊕ Λ⁻`, and `𝒲₄ = Sym²₀(Λ⁺) ⊕ Sym²₀(Λ⁻)`. The competitor is the
self-dual operator with spectrum `(2,-1,-1)` and zero on `Λ⁻`:

`W = a aᵀ - ½(b bᵀ + c cᵀ)`, `a = e₀₁+e₂₃`, `b = e₀₂-e₁₃`, `c = e₀₃+e₁₂`.

**Why it is worth building.** [L2](../Results/L2.lean) proves the whole
threshold argument but imports two *values*: `θ₀(n)²` for the balanced sphere
product, and `θ² = 3/2` for this competitor. The second is settled here at
`n = 4`, from the definition of `Q` rather than by assumption.

`θ² = P(W)² / ‖W‖⁶` is rational even though `θ` is not, so the claim is stated
in that form and needs no square root.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

/-- The competitor, in the `pair4` basis. -/
def WCP2 : Matrix (Fin 6) (Fin 6) ℚ :=
  !![ 1,    0,    0,    0,    0,    1;
      0,  -1/2,   0,    0,   1/2,   0;
      0,    0,  -1/2, -1/2,   0,    0;
      0,    0,  -1/2, -1/2,   0,    0;
      0,   1/2,   0,    0,  -1/2,   0;
      1,    0,    0,    0,    0,    1]

set_option maxHeartbeats 1000000 in
theorem WCP2_isSymm : WCP2.IsSymm := by
  ext a b
  fin_cases a <;> fin_cases b <;> simp [WCP2, Matrix.transpose]

/-- First Bianchi. -/
theorem WCP2_bianchi : IsBianchi WCP2 := by
  have h05 : WCP2 0 5 = 1 := rfl
  have h14 : WCP2 1 4 = 1/2 := rfl
  have h23 : WCP2 2 3 = -1/2 := rfl
  unfold IsBianchi
  rw [h05, h14, h23]
  norm_num

set_option maxHeartbeats 20000000 in
set_option maxRecDepth 10000 in
-- Sixteen contraction entries, each a `Λ²` sum over `Fin 4` unfolded to literal rationals.
/-- Ricci-flat, checked on every entry of the contraction. -/
theorem WCP2_ricciFlat : IsRicciFlat WCP2 := by
  unfold IsRicciFlat Ric
  intro a b
  fin_cases a <;> fin_cases b <;>
    simp (config := { maxSteps := 4000000 }) only [WCP2, inner2, toMat4, coord4, basis4, pair4,
      phi, Matrix.mul_apply, Matrix.single, Matrix.mulVec, dotProduct, Matrix.trace, Matrix.diag,
      Fin.sum_univ_six, Fin.sum_univ_four, Matrix.sub_apply, Matrix.add_apply, Matrix.smul_apply,
      Fin.isValue, Matrix.of_apply, Matrix.transpose, Matrix.cons_val_zero, Matrix.cons_val_one,
      Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
      Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
      Matrix.empty_val', Matrix.head_fin_const, Fin.ext_iff, Fin.mk.injEq, Pi.single_apply] <;>
    norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
      Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
      Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
      Pi.single_apply, Fin.ext_iff]

/-- So it is a Weyl operator. -/
theorem WCP2_isWeyl : IsWeyl WCP2 := ⟨WCP2_isSymm, WCP2_bianchi, WCP2_ricciFlat⟩

set_option maxHeartbeats 1000000 in
/-- `‖W‖² = 6`, the spectrum being `(2,-1,-1,0,0,0)`. -/
theorem WCP2_normSq : (WCP2ᵀ * WCP2).trace = 6 := by
  simp [WCP2, Matrix.trace, Matrix.mul_apply, Matrix.transpose, Fin.sum_univ_six, Matrix.diag]
  norm_num

/-! **`WCP2_theta_sq` LIVES IN [RelationC.lean](RelationC.lean) NOW.** *It was `native_decide`
here because criticality was not yet proved; with `Qop W = 3W` in hand it is two rewrites, so it
belongs beside the criticality rather than beside the definition.* -/

end HamiltonsCubic.Base
