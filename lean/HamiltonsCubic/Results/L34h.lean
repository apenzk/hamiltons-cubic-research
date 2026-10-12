import HamiltonsCubic.Results.L34b
import HamiltonsCubic.Results.L34d

/-!
# L34, the three blocks are mutually orthogonal

What [L34g](L34g.lean) leaves owed is completeness: that the exhibited
eigenvectors are all of them. They fall into three families, padded from the
first summand, padded from the second, and mixed, and **independence across the
families is orthogonality**, which needs no determinant.

Each family lives in its own block of `Λ²(ℝᵐ ⊕ ℝᵏ)`, and the pairing sees only
matching blocks. So a vector from one family is never in the span of the others,
and completeness reduces to independence *within* each family, which for the
padded copies is the summand's own eigenbasis, already invertible, and for the
mixed family is a set of distinct basis bivectors.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

variable {m k : Type*} [Fintype m] [DecidableEq m] [Fintype k] [DecidableEq k]

@[simp] theorem toBlocks₁₁_pad₂ (Y : Matrix k k ℚ) :
    (pad₂ (m := m) Y).toBlocks₁₁ = 0 := by
  unfold pad₂
  rw [Matrix.toBlocks_fromBlocks₁₁]

@[simp] theorem toBlocks₂₂_pad (X : Matrix m m ℚ) :
    (pad (k := k) X).toBlocks₂₂ = 0 := by
  unfold pad
  rw [Matrix.toBlocks_fromBlocks₂₂]

/-- **The two padded families are orthogonal.** -/
theorem pad_orthogonal_pad₂ (X : Matrix m m ℚ) (Y : Matrix k k ℚ) :
    inner2 (pad (k := k) X) (pad₂ (m := m) Y) = 0 := by
  rw [pairing_pad_left, toBlocks₁₁_pad₂, inner2_zero_right]

/-- **The second padded family is orthogonal to the mixed one.** -/
theorem pad₂_orthogonal_mixed (Y : Matrix k k ℚ) (a : m) (c : k) :
    inner2 (pad₂ (m := m) Y) (phi (Sum.inl a) (Sum.inr c)) = 0 := by
  rw [inner2_pad₂_left, toBlocks₂₂_phi_inl_inr, inner2_zero_right]

/-- And the first is too, [L34b](L34b.lean)'s lemma, restated here so the three
orthogonalities stand together. -/
theorem pad_orthogonal_mixed (X : Matrix m m ℚ) (a : m) (c : k) :
    inner2 (pad (k := k) X) (phi (Sum.inl a) (Sum.inr c)) = 0 :=
  inner2_pad_phi_mixed X a c

end HamiltonsCubic.Base
