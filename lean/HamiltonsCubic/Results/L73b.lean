import HamiltonsCubic.Base.CP2

/-!
# The multiplicity that withdraws a figure

[L73](../../../findings/bounds.md) withdraws a recorded halving,
`0.272166 → 0.136083` at padded `W_{ℂP²}`, on a structural ground:

> `λ_min` has multiplicity `2` there, so the two forms are identical and the
> slack cannot move.

The two forms are the plain bound and its sharpening over *the two smallest
eigenvalues excluding the row index*; they coincide exactly when `λ_min` is not
simple. So the withdrawal turns on a multiplicity, and that is checkable.

`W_{ℂP²}` has spectrum `(2,-1,-1,0,0,0)`, and the two `-1` eigenvectors are
exhibited here: `e₀₂ - e₁₃` and `e₀₃ + e₁₂` in the pair basis, supported on
disjoint coordinates and so independent.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

/-- The first `-1` eigenvector: `e₀₂ - e₁₃`. -/
def vMinus₁ : Fin 6 → ℚ := ![0, 1, 0, 0, -1, 0]

/-- The second: `e₀₃ + e₁₂`. -/
def vMinus₂ : Fin 6 → ℚ := ![0, 0, 1, 1, 0, 0]

theorem WCP2_eigen_minus₁ : WCP2 *ᵥ vMinus₁ = -vMinus₁ := by
  funext i
  fin_cases i <;>
    simp [WCP2, vMinus₁, Matrix.mulVec, dotProduct, Fin.sum_univ_six, Matrix.cons_val_zero,
      Matrix.cons_val_one, Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four,
      cons_val_five, Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_fin_one,
      Matrix.empty_val', Matrix.head_fin_const, Pi.neg_apply] <;>
    norm_num

theorem WCP2_eigen_minus₂ : WCP2 *ᵥ vMinus₂ = -vMinus₂ := by
  funext i
  fin_cases i <;>
    simp [WCP2, vMinus₂, Matrix.mulVec, dotProduct, Fin.sum_univ_six, Matrix.cons_val_zero,
      Matrix.cons_val_one, Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four,
      cons_val_five, Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_fin_one,
      Matrix.empty_val', Matrix.head_fin_const, Pi.neg_apply] <;>
    norm_num

/-- **They are independent**, being supported on disjoint coordinates, so
`λ_min = -1` has multiplicity at least `2` and the sharpening has nothing to
remove. -/
theorem vMinus_independent : ∀ a b : ℚ, (∀ i, a * vMinus₁ i + b * vMinus₂ i = 0) → a = 0 ∧ b = 0 := by
  intro a b h
  constructor
  · have := h 1
    simpa [vMinus₁, vMinus₂] using this
  · have := h 2
    simpa [vMinus₁, vMinus₂] using this

end HamiltonsCubic.Base
