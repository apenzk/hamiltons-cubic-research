import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Order.Interval.Finset.Nat

/-!
# L100, the dichotomy's range, and what the open item decides

[route-a.md](../../../findings/route-a.md)'s Lemma L100, audited in
[ROUND_L100](../../../verification/ROUND_L100.md). The dichotomy holds at `8 ≤ n ≤ 11` given
`α ≤ 1/3`, which [L21](../../../findings/route-a.md) gives at `9 ≤ n ≤ 11` and which zero-padding
`𝒲₈ → 𝒲₉` carries to `n = 8` from L21 at `n = 9`. So every `n` in the range draws the input from
L21 at `max n 9`.

**What the open item decides.** The Gate 2 reviewers put L21's reach at `n ≥ 9` against
`n ≥ 12`. **Under the second reading L100's range is empty**: every dimension at which it draws
on L21 lies below `12`. The open item decides whether the lemma has any content.

**The radius is non-vacuous only because the metric is geodesic.** `0.5748` against a
diameter of `π` is `18.3%`; against a chordal diameter of `2` it would be `28.7%`. Both are
checked, so the metric choice is visible rather than assumed.

**Not typed**: the padding step itself, which is a statement about `𝒲ₙ` and `F_u`.
-/

namespace HamiltonsCubic.Dichotomy

/-! ## The range, and where each dimension draws on L21 -/

/-- The stated range `8 ≤ n ≤ 11` has four values. -/
theorem stated_range : (Finset.Icc 8 11).card = 4 := by decide

/-- **Every `n` in the range draws `α ≤ 1/3` from L21 at `max n 9`, inside L21's `9 ≤ n`
and below `12`**, `n = 8` through the padding step. -/
theorem l21_dimension_in_range (n : ℕ) (hlo : 8 ≤ n) (hhi : n ≤ 11) :
    9 ≤ max n 9 ∧ max n 9 ≤ 11 := by omega

/-- `n = 8` draws on L21 at `9`, the only dimension where the two differ. -/
theorem eight_draws_on_nine : max 8 9 = 9 := by decide

/-! ## What the open item decides -/

/-- **Under a reach of `n ≥ 12` the range is empty**: no dimension L100 draws on reaches `12`.
So the reviewers' disagreement about L21's reach decides whether L100 has any content. -/
theorem reach_twelve_empties (n : ℕ) (hlo : 8 ≤ n) (hhi : n ≤ 11) : ¬ (12 ≤ max n 9) := by
  omega

/-- The two candidate reaches are disjoint on the dimensions L100 draws on. -/
theorem reaches_disjoint :
    ((Finset.Icc 9 11).filter (fun n => 12 ≤ n)).card = 0 := by decide

/-! ## The radius is non-vacuous, and the metric is why -/

/-- **Against a geodesic diameter of `π`, the radius `0.5748` is `18.3%`.** Stated with `π`
bracketed, so the ratio is bounded rather than evaluated. -/
theorem geodesic_share {pi : ℚ} (hlo : 31415926 / 10000000 < pi)
    (hhi : pi < 31415927 / 10000000) :
    (1829 : ℚ) / 10000 * pi < 5748 / 10000 ∧ (5748 : ℚ) / 10000 < 1830 / 10000 * pi := by
  constructor <;> nlinarith [hlo, hhi]

/-- **Against a chordal diameter of `2` it would read `28.7%`**, so the metric choice moves
the figure by half again, and the record's *"non-vacuous"* depends on it. -/
theorem chordal_share : (5748 : ℚ) / 10000 / 2 = 2874 / 10000 := by norm_num

/-- The two readings differ by more than half the smaller. -/
theorem metric_matters : (1830 : ℚ) / 10000 * 15 / 10 < 2870 / 10000 := by norm_num

end HamiltonsCubic.Dichotomy
