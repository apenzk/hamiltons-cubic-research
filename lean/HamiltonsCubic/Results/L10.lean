import HamiltonsCubic.Results.L38

/-!
# L10, the reducible-isotropy families, all below the threshold

**This result overlaps L38, and the record says so**: L38's block records that
*"the `ℂPᵐ` half duplicates L10"*. So the `ℂPᵐ` closed form and its monotonicity
are not restated here, they are [L38](L38.lean)'s `cpSq` and
`cpSq_strictAnti`, and this file consumes them.

What L10 adds is the *conclusion* drawn from them: the family sits strictly
below `3/2` from `m = 3` on, `m = 2` being the sole member attaining it. That is
one line from L38 and is proved here rather than being left as prose.

The rest of L10, *every other family's point sits below the threshold*,
needs each of those families' values, which are not on the record in closed
form. It is not in this file.
-/

namespace HamiltonsCubic.L10

open HamiltonsCubic.L38

/-- **Strictly below the threshold from `m = 3` on.** `m = 2` is the only member
of the family attaining `3/2`. -/
theorem cpSq_lt_threshold {m : ℝ} (h : 3 ≤ m) : cpSq m < 3 / 2 := by
  have := cpSq_strictAnti (x := 2) (y := m) le_rfl (by linarith)
  rwa [cpSq_two] at this

/-- And `m = 2` attains it, so the bound is sharp on the family. -/
theorem cpSq_two_attains : cpSq 2 = 3 / 2 := cpSq_two

end HamiltonsCubic.L10
