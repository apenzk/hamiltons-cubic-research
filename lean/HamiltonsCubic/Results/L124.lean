import HamiltonsCubic.Results.L121
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# L124, the category error, and what `A, B, C` are

[second-order.md](../../../findings/second-order.md)'s Lemma L124. The audit's core finding is
a **category error**: the block cited [L121](L121.lean), which is about a different operator.

**The two uses of `A, B, C` are not the same objects.** In L121 they are the three
opposite-pair sums, and [`diag_entries`](L121.lean) proves they are the diagonal of `G`; in
L124 they are `V₊`'s diagonal. Shared letters across two operators license nothing, the same
shape [L107](L107.lean) found with two quantities both called `Π`.

**And "diagonal, not spectrum" has a consequence the block's formula needs.** `θ = 9 det V₊`
is not `9ABC` unless `V₊` is diagonal: for a symmetric matrix the determinant and the product
of the diagonal differ by exactly the off-diagonal contribution, and
`[[0,1],[1,0]]` makes the gap total, determinant `-1` against diagonal product `0`, with the
spectrum `±1` matching neither.
-/

namespace HamiltonsCubic.CategoryError

open HamiltonsCubic.FourSet

/-! ## Diagonal against spectrum, and against determinant -/

/-- **A symmetric matrix's diagonal need not be its spectrum.** `[[0,1],[1,0]]` has diagonal
`(0,0)` and spectrum `(1,-1)`, the two agree on nothing. -/
theorem diagonal_ne_spectrum : ((0 : ℚ), (0 : ℚ)) ≠ ((1 : ℚ), (-1 : ℚ)) := by
  intro h
  have := congrArg Prod.fst h
  norm_num at this

/-- **And the determinant is not the product of the diagonal.** For `[[a,b],[b,d]]` the gap is
`b²`, so it vanishes only in the diagonal case. -/
theorem det_minus_diag_product (a b d : ℚ) : (a * d - b * b) - a * d = -(b * b) := by ring

/-- At `[[0,1],[1,0]]` the gap is total: determinant `-1` against diagonal product `0`. -/
theorem gap_total : ((0 : ℚ) * 0 - 1 * 1) = -1 ∧ (0 : ℚ) * 0 = 0 := by
  constructor <;> norm_num

/-- **So `θ = 9 det V₊` is `9ABC` only when `V₊` is diagonal**, the formula and the letters
cannot both be taken from L121. -/
theorem det_is_product_iff_offdiag_zero (a b d : ℚ) :
    a * d - b * b = a * d ↔ b * b = 0 := by
  constructor <;> intro h <;> linarith

/-! ## The chain and its equality case -/

/-- **Equality at `±W_{ℂP²}` is a `±` pair**, which is the same evenness that
[L108](L108.lean) shows the squared form needs: `Σ` and `ρ²` are even in `W` while `θ` is odd,
so the equality set is closed under negation. -/
theorem equality_set_closed_under_neg (θ : ℚ) (h : θ ^ 2 = 3 / 2) : (-θ) ^ 2 = 3 / 2 := by
  rw [← h]; ring

end HamiltonsCubic.CategoryError
