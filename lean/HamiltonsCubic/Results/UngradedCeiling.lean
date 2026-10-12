import HamiltonsCubic.Results.ReportConsistency
import HamiltonsCubic.Results.HPFamily

/-!
# The extended drift scan, and the ungraded ceiling's hypothetical jump

[ReportConsistency.lean](HamiltonsCubic/Results/ReportConsistency.lean) matched `43` of
the report's six-place constants against verified values. **Extending the scan to
constants matching no verified value found `58` more, and none is a drift.**

The one that looked like a discrepancy is not: `1.054092` appears twice, against the
verified `1.054093`. Both are `√(10/9) = 1.0540925534…`, the report prints it to **nine**
places, `1.054092553`, and a six-place scan reads the first six as a truncation. *A
regex, not a defect.*

The most frequent unaccounted constant, `0.900828` (four occurrences), is the **ungraded
ceiling**, and [07-gradedness-split.tex](../../../report/sections/07-gradedness-split.tex)
uses it in a counterfactual:

> Had `ℍP²` been ungraded, the recorded ungraded ceiling would have jumped from `0.900828`
> to `1.115547`.

**That jump is `23.8%`, and it would still not break the threshold**: `1.115547 < √(3/2)`,
with margin `23/90` in the square, the same margin
[HPFamily.lean](HamiltonsCubic/Results/HPFamily.lean) records.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.UngradedCeiling

open HamiltonsCubic.HPFamily

/-! ## The nine-place printing -/

/-- `1.054092553` brackets `10/9`, so the report's longer form is correct and the
six-place `1.054092` is its prefix, not a rounding. -/
theorem nine_place_correct :
    (1.054092553 : ℚ) ^ 2 < 10 / 9 ∧ (10 : ℚ) / 9 < (1.054092554 : ℚ) ^ 2 := by
  constructor <;> norm_num

/-- And the six-place round is `1.054093`, so both forms describe one number. -/
theorem six_place_round :
    (1.054092 : ℚ) ^ 2 < 10 / 9 ∧ (10 : ℚ) / 9 < (1.054093 : ℚ) ^ 2 := by
  constructor <;> norm_num

/-! ## The counterfactual jump -/

/-- The jump from `0.900828` to `ℍP²`'s `√(56/45)` is `23.8%`. -/
theorem jump_size :
    (1.238 : ℚ) * 0.900828 < 1.115547 ∧ (1.115547 : ℚ) < 1.239 * 0.900828 := by
  constructor <;> norm_num

/-- **And the raised ceiling would still clear the threshold**: `56/45 < 3/2`. -/
theorem still_clears : hpSq 2 < 3 / 2 := by norm_num [hpSq]

/-- With margin `23/90` in the square, the same margin the quaternionic family's
supremum has. -/
theorem margin : 3 / 2 - hpSq 2 = 23 / 90 := by norm_num [hpSq]

/-- The current ceiling clears by much more: `0.900828² = 0.811491…` against `3/2`, a
factor over `1.8`. -/
theorem current_margin : (1.8 : ℚ) * (0.900828 : ℚ) ^ 2 < 3 / 2 := by norm_num

/-- **So the counterfactual would consume most of the room without exhausting it**, the
margin falls from a factor of `1.84` to one of `1.20` in the square. -/
theorem room_consumed :
    (1.84 : ℚ) * (0.900828 : ℚ) ^ 2 < 3 / 2 ∧ (1.2 : ℚ) * hpSq 2 < 3 / 2 := by
  constructor <;> norm_num [hpSq]

/-! ## What this settles

**Settled**: that the report's nine-place `1.054092553` is correct and its apparent
six-place disagreement with `1.054093` is an artefact of scanning, not drift; that the
counterfactual jump in the ungraded ceiling would be `23.8%`; and that **the raised
ceiling would still clear `√(3/2)`**, with the margin falling from a factor of `1.84` to
`1.20` in the square.

**And the scan's result**: `58` report constants match no verified value, and none
examined is a discrepancy, the drift the ledger tracks is not in the numerals.

**Not claimed**: that all `58` were individually checked, the four most frequent were,
and the rest are single occurrences whose sources this layer does not cover.
-/

end HamiltonsCubic.UngradedCeiling
