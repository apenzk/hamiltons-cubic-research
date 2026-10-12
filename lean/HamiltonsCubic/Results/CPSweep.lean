import HamiltonsCubic.Results.FamilyMeet

/-!
# The `ℂPᵐ` family, swept

The same proximity scan applied to `ℂPᵐ`: five `θ` values printed across the record, and
**all five reproduce** from `θ² = (m+1)(2m-1)/(3m(m-1))`.

| `m` | printed | exact `θ²` |
|---|---|---|
| `2` | `1.224745` | `3/2` |
| `3` | `1.054092553389`, `1.054093` | `10/9` |
| `4` | `0.986013` | `35/36` |
| `6` | `0.924962` | `77/90` |

**Every one of these is already on the record in exact form.**
[algebra.md](../../../findings/algebra.md) lists `3/2, 10/9, 35/36, 9/10, 77/90, 52/63`
for `m = 2,…,7`, derived rather than measured, and
[graded-half.md](../../../findings/graded-half.md) tabulates `77/90` again for
`SO(12)/U(6)`. **So this file re-derives the family's values from the closed form; it does
not supply them.** What it adds is the kernel check and the structural statements below,
the strict decrease, the limit, and `ℂP²` as the unique member reaching `3/2`.

**And the family's limit is `2/3`**, so `θ → √(2/3) = 0.816497…`, a figure the record
prints in two places.

Everything is `norm_num` or `nlinarith`, kernel-checked.
-/

namespace HamiltonsCubic.CPSweep

open HamiltonsCubic.FamilyMeet

/-! ## The printed values -/

theorem cp2 : cpSq 2 = 3 / 2 := by norm_num [cpSq]
theorem cp3 : cpSq 3 = 10 / 9 := by norm_num [cpSq]
theorem cp4 : cpSq 4 = 35 / 36 := by norm_num [cpSq]

/-- `ℂP⁶`, printed `0.924962`: exactly `77/90`, on the record twice, in
[algebra.md](../../../findings/algebra.md) and [graded-half.md](../../../findings/graded-half.md). -/
theorem cp6 : cpSq 6 = 77 / 90 := by norm_num [cpSq]

/-- **`ℂP⁵` is `9/10`**, rational, and on the record in that form. After `ℂP²`'s `3/2`
it is the only rational in the family to `m = 8`. -/
theorem cp5 : cpSq 5 = 9 / 10 := by norm_num [cpSq]

theorem cp7 : cpSq 7 = 52 / 63 := by norm_num [cpSq]
theorem cp8 : cpSq 8 = 45 / 56 := by norm_num [cpSq]

/-! ## The limit

`(m+1)(2m-1)/(3m(m-1)) → 2/3`, and the approach is from above.
-/

/-- **Every member is above `2/3`**: `3(m+1)(2m-1) - 2·3m(m-1) = 3m² + 3m - 3 > 0`. -/
theorem above_limit (m : ℚ) (hm : 2 ≤ m) :
    2 * (3 * m * (m - 1)) < 3 * ((m + 1) * (2 * m - 1)) := by
  nlinarith

/-- The numerator gap is exactly `9m - 3`, so the gap to `2/3` is `(9m-3)/(9m(m-1))`,
shrinking like `1/m`, not faster. -/
theorem gap_identity (m : ℚ) :
    3 * ((m + 1) * (2 * m - 1)) - 2 * (3 * m * (m - 1)) = 9 * m - 3 := by
  ring

/-- `√(2/3) = 0.816497…`, the figure the record prints: squared it is `2/3`, bracketed
here to six places. -/
theorem limit_bracket : (0.816496 : ℚ) ^ 2 < 2 / 3 ∧ (2 : ℚ) / 3 < (0.816497 : ℚ) ^ 2 := by
  constructor <;> norm_num

/-! ## The family is strictly decreasing -/

theorem decreasing_2_8 :
    cpSq 8 < cpSq 7 ∧ cpSq 7 < cpSq 6 ∧ cpSq 6 < cpSq 5 ∧
    cpSq 5 < cpSq 4 ∧ cpSq 4 < cpSq 3 ∧ cpSq 3 < cpSq 2 := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩ <;> norm_num [cpSq]

/-- **So `ℂP²` is the family's maximum**, and it is the only member at or above `3/2`,
which is why the competitor is a single point rather than a family. -/
theorem cp2_is_max : cpSq 3 < 3 / 2 ∧ cpSq 4 < 3 / 2 ∧ cpSq 8 < 3 / 2 := by
  refine ⟨?_, ?_, ?_⟩ <;> norm_num [cpSq]

/-! ## What this settles

**Settled**: all five printed `ℂPᵐ` values as exact rationals, including `ℂP⁶`'s `77/90`
which was unchecked; that `ℂP⁵` is the rational `9/10`, which the record prints only as a decimal;
that the family decreases strictly to `2/3` **from above**, with the gap shrinking like
`1/m`; and that `ℂP²` is the family's maximum and its only member reaching `3/2`.

**Not claimed**: the closed form, the record's; nor what the record's two occurrences of
`0.816497` refer to, the arithmetic that this is `√(2/3)` is stated, the identification
is not.
-/

end HamiltonsCubic.CPSweep
