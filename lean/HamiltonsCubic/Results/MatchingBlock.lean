import Mathlib

/-!
# The matching inequality's per-block step

[reviews/2026-09-28b-LIT-step8-sweep.md](../../../reviews/2026-09-28b-LIT-step8-sweep.md), the
matching inequality for I121's small-mass node (Gate 2 r1836, r1837).

**The source's statement.** "On the block diagonal `m = (a_ik, a_il, a_jk, a_jl)` of an edge pair,
the three subtracted terms `¼□²`, `(δ^f_i + δ^f_j)²`, `(δ^e_k + δ^e_l)²` are the three non-constant
Hadamard contrasts of `m` over 4, so by Parseval they sum to `‖m‖² - ¼ s²`."

**What is typed.** `block_subtracted`: with `□ = m₁ - m₂ - m₃ + m₄`,
`δ^f_i + δ^f_j = ½(m₁ - m₂ + m₃ - m₄)` and `δ^e_k + δ^e_l = ½(m₁ + m₂ - m₃ - m₄)`, the three
subtracted terms sum to `m₁² + m₂² + m₃² + m₄² - ¼(m₁ + m₂ + m₃ + m₄)²`. `block_subtracted_le`: that sum
is at most `m₁² + m₂² + m₃² + m₄²`.

**Not typed**: that the matching rotation's change of diagonal mass is the sum of the per-pair
block exchanges, and that the blocks of one matching partition the cross entries.
-/

namespace HamiltonsCubic.MatchingBlock

/-- **THE PER-BLOCK PARSEVAL STEP.** -/
theorem block_subtracted (m₁ m₂ m₃ m₄ : ℝ) :
    (m₁ - m₂ - m₃ + m₄) ^ 2 / 4 + ((m₁ - m₂ + m₃ - m₄) / 2) ^ 2 + ((m₁ + m₂ - m₃ - m₄) / 2) ^ 2
      = m₁ ^ 2 + m₂ ^ 2 + m₃ ^ 2 + m₄ ^ 2 - (m₁ + m₂ + m₃ + m₄) ^ 2 / 4 := by
  ring

/-- The subtracted terms never exceed the block's diagonal mass. -/
theorem block_subtracted_le (m₁ m₂ m₃ m₄ : ℝ) :
    (m₁ - m₂ - m₃ + m₄) ^ 2 / 4 + ((m₁ - m₂ + m₃ - m₄) / 2) ^ 2 + ((m₁ + m₂ - m₃ - m₄) / 2) ^ 2
      ≤ m₁ ^ 2 + m₂ ^ 2 + m₃ ^ 2 + m₄ ^ 2 := by
  rw [block_subtracted]
  nlinarith [sq_nonneg (m₁ + m₂ + m₃ + m₄)]

end HamiltonsCubic.MatchingBlock
