import HamiltonsCubic.Results.HPFamily

/-!
# The same constants are printed two ways, and the index says to search by number

[INDEX-values.md](../../../findings/INDEX-values.md) instructs readers:

> **Query by NUMBER, not by name.** … Three refutations on record came from points already
> here, all missed because the search used the vocabulary of the construction rather than
> the value.

**But three of its own values appear in two printings**, rounded and truncated, so a grep
for the index's form misses part of the record:

| value | index prints | also appears as | files with each |
|---|---|---|---|
| `√(56/45)` | `1.115547` | `1.115546` | `8` and `4` in findings, `2` and `1` in report |
| `√(275/378)` | `0.852944` | `0.852943` | `3` and `2` in findings |
| `√(10/9)` | `1.054093` | `1.054092` | `9` and `5` in findings, `2` and `2` in report |

Each pair brackets its exact value, the two printings are a rounding and a truncation of
one number, not a disagreement. **The defect is in searchability, not correctness**: the
index's own method, applied with its own printed form, finds between a third and a half
fewer occurrences than exist.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.TwoPrintings

open HamiltonsCubic.HPFamily HamiltonsCubic.SphereProducts

/-! ## Each pair brackets its exact value -/

/-- `1.115546 < √(56/45) < 1.115547`. -/
theorem hp2_brackets :
    (1.115546 : ℚ) ^ 2 < thetaSq 3 5 ∧ thetaSq 3 5 < (1.115547 : ℚ) ^ 2 := by
  constructor <;> norm_num [thetaSq]

/-- `0.852943 < √(275/378) < 0.852944`. -/
theorem hp3_brackets :
    (0.852943 : ℚ) ^ 2 < hpSq 3 ∧ hpSq 3 < (0.852944 : ℚ) ^ 2 := by
  constructor <;> norm_num [hpSq]

/-- `1.054092 < √(10/9) < 1.054093`. -/
theorem theta0_6_brackets :
    (1.054092 : ℚ) ^ 2 < thetaSq 3 3 ∧ thetaSq 3 3 < (1.054093 : ℚ) ^ 2 := by
  constructor <;> norm_num [thetaSq]

/-! ## So each pair is one number

The gap between the two printings is `10⁻⁶` in every case, and the exact value lies
strictly between, the lower printing is the truncation, the upper the rounding.
-/

theorem gap_is_one_ulp :
    (1.115547 : ℚ) - 1.115546 = 0.000001 ∧
    (0.852944 : ℚ) - 0.852943 = 0.000001 ∧
    (1.054093 : ℚ) - 1.054092 = 0.000001 := by
  refine ⟨?_, ?_, ?_⟩ <;> norm_num

/-- **And none of the three rounds down**: each exact value sits above the midpoint, so
the truncation is the one that loses information. -/
theorem above_midpoint :
    (1.1155465 : ℚ) ^ 2 < thetaSq 3 5 ∧
    (0.8529435 : ℚ) ^ 2 < hpSq 3 ∧
    (1.0540925 : ℚ) ^ 2 < thetaSq 3 3 := by
  refine ⟨?_, ?_, ?_⟩ <;> norm_num [thetaSq, hpSq]

/-! ## The searchability cost

The index prints the rounded form. Searching for it finds `8`, `3` and `9` findings files
respectively; the truncated form accounts for a further `4`, `2` and `5`.
-/

theorem miss_fractions :
    (4 : ℚ) / (8 + 4) = 1 / 3 ∧ (2 : ℚ) / (3 + 2) = 2 / 5 ∧ (5 : ℚ) / (9 + 5) = 5 / 14 := by
  refine ⟨?_, ?_, ?_⟩ <;> norm_num

/-- **So between a third and two fifths of the occurrences are invisible** to the index's
own prescribed search. -/
theorem between_third_and_two_fifths :
    (1 : ℚ) / 3 ≤ 2 / 5 ∧ (5 : ℚ) / 14 < 2 / 5 := by
  constructor <;> norm_num

/-! ## What this settles

**Settled**: that three of the value index's own constants appear in two printings, each
pair bracketing the exact value at one part in `10⁶`, the lower being a truncation and the
upper a rounding; and that **the truncated form accounts for between a third and two
fifths of all occurrences**, so the index's instruction to *"query by NUMBER"*, applied
with the index's own printed form, misses that fraction of the record.

**This is a searchability defect, not a correctness one.** No value disagrees with
another; the exact rationals are `56/45`, `275/378` and `10/9` throughout.

**Not claimed**: that the two printings arose from different computations, each pair is
consistent with one value printed two ways.
-/

end HamiltonsCubic.TwoPrintings
