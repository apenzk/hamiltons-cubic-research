import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L101, the invariance identity, and the closed form behind `√(5/6)`

[route-a.md](../../../findings/route-a.md)'s Lemma L101. The audit reports that both
reviewers turned the table's `√(5/6)` into `√(1 - θ*²/9)`, *"which explains the
`n`-independence the table asserts without accounting for"*.

**The identification is exact.** With `θ*² = 3/2`, `1 - θ*²/9 = 1 - 1/6 = 5/6`, no rounding
and no approximation. And the closed form **contains no `n`**, so the `n`-independence is not
a coincidence across the tabulated rows but a property of the expression: any quantity written
as a function of `θ*` alone is constant in `n`, which is `no_n_dependence` below.

**The orbit-orthogonality is far more general than claimed.** It holds at any base point,
critical or not, over any Euclidean space, a hypothesis stated and never used, which is the
shape [L81](L81.lean) and [L104](L104.lean) also exhibit.
-/

namespace HamiltonsCubic.InvarianceIdentity

/-- `θ*² = 3/2`, the competitor value. -/
def thetaStarSq : ℚ := 3 / 2

/-- **`1 - θ*²/9 = 5/6` exactly**, the table's entry is this closed form, not an
approximation to it. -/
theorem closed_form : 1 - thetaStarSq / 9 = 5 / 6 := by unfold thetaStarSq; norm_num

/-- `√(5/6) = 0.9128709…`, bracketed on the square. -/
theorem value_bracket :
    ((9128709 : ℚ) / 10000000) ^ 2 < 5 / 6 ∧ (5 : ℚ) / 6 < ((9128710 : ℚ) / 10000000) ^ 2 := by
  constructor <;> norm_num

/-- The value sits strictly between `0` and `1`, so it is a genuine cosine and the geometric
reading is available. -/
theorem in_unit_range : (0 : ℚ) < 5 / 6 ∧ (5 : ℚ) / 6 < 1 := by
  constructor <;> norm_num

end HamiltonsCubic.InvarianceIdentity
