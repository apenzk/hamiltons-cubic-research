import Mathlib.Data.Rat.Defs
import Mathlib.Data.Nat.Choose.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# The pin's equation count identifies its `N`, and the residual gap is `14%`

[bounds-relaxations.md](../../../findings/bounds-relaxations.md) records that pinning `Q_γ` adds
`N - 2` independent equations, *"`13` at `n = 6`, `26` at `n = 8`"*, without saying what `N` is.

**`N = C(n,2)`.** `C(6,2) - 2 = 13` and `C(8,2) - 2 = 26`, so the count is
`n(n-1)/2 - 2`, the dimension of `Λ²ℝⁿ` less the two contractions the class already carries.
Both recorded values follow, and the general form is available where the block gives two numbers.

**The residual gap is `14%`, and the two builds pin it to a tenth of that.** With the pin the
`n = 6` supremum moves to `1.3993` and `1.4005` from two independent builds, against
`√(3/2) = 1.224745`. The ratios are `1.1425` and `1.1435`, so the gap is between `14.2%` and
`14.4%`, the block's `14%`, with the two builds differing by `0.0012`, about one part in a
thousand.

**And the ceiling the file quotes is stale by its own later paragraph.** `1.60/2.29/2.49` against
`1.413614` at `n = 6` and `2.2585` at `n = 8` once the vector identity is carried; the reviewers'
independent encodings return `1.6089` and `1.4212`, which the block records as an open
discrepancy. *Left open here too, the arithmetic settles the counts, not which encoding is
right.*
-/

namespace HamiltonsCubic.PinCount

/-! ## The equation count -/

/-- **`C(6,2) - 2 = 13` and `C(8,2) - 2 = 26`**, so `N` is the dimension of `Λ²ℝⁿ`. -/
theorem counts_identify_N :
    Nat.choose 6 2 - 2 = 13 ∧ Nat.choose 8 2 - 2 = 26 := by
  refine ⟨by decide, by decide⟩

/-- **The general form is `n(n-1)/2 - 2`**, giving both. -/
theorem general_count (n : ℚ) : n * (n - 1) / 2 - 2 = (n ^ 2 - n - 4) / 2 := by ring

theorem general_at_six_and_eight :
    (6 : ℚ) * 5 / 2 - 2 = 13 ∧ (8 : ℚ) * 7 / 2 - 2 = 26 := by
  refine ⟨by norm_num, by norm_num⟩

/-- It grows quadratically, so the pin adds more at every dimension, `n = 12` gives `64`. -/
theorem count_at_twelve : (12 : ℚ) * 11 / 2 - 2 = 64 := by norm_num

/-! ## The residual gap -/

/-- **The two builds agree to about one part in a thousand.** -/
theorem builds_agree :
    (14005 : ℚ) / 10000 - 13993 / 10000 = 12 / 10000
      ∧ (12 : ℚ) / 10000 < 1 / 1000 + 3 / 10000 := by
  refine ⟨by norm_num, by norm_num⟩

/-- **And the gap against `√(3/2)` is between `14.2%` and `14.4%`.** Stated on squares, so no
root is taken: `1.3993² / (3/2)` and `1.4005² / (3/2)` bracket `1.1425²` and `1.1435²`. -/
theorem residual_gap_bracket :
    ((13993 : ℚ) / 10000) ^ 2 / (3 / 2) > (1142 / 1000) ^ 2
      ∧ ((14005 : ℚ) / 10000) ^ 2 / (3 / 2) < (1144 / 1000) ^ 2 := by
  constructor <;> norm_num

/-- So the block's `14%` is right and the two builds do not disturb it. -/
theorem fourteen_percent :
    (114 : ℚ) / 100 < (13993 : ℚ) / 10000 / (12247449 / 10000000)
      ∧ (14005 : ℚ) / 10000 / (12247449 / 10000000) < 115 / 100 := by
  constructor <;> norm_num

/-! ## The stale ceiling -/

/-- The quoted `1.60` against the later `1.413614` at `n = 6`, a difference of over `13%`. -/
theorem ceiling_moved :
    (160 : ℚ) / 100 - 1413614 / 1000000 = 186386 / 1000000
      ∧ (13 : ℚ) / 100 < (186386 / 1000000) / (1413614 / 1000000) := by
  refine ⟨by norm_num, by norm_num⟩

/-- And the reviewers' `1.6089` sits above the quoted `1.60`, so the discrepancy is not rounding. -/
theorem discrepancy_is_not_rounding : (160 : ℚ) / 100 < 16089 / 10000 := by norm_num

end HamiltonsCubic.PinCount
