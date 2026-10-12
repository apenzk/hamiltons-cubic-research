import HamiltonsCubic.Results.TwoPrintings

/-!
# The printing audit, completed

[TwoPrintings.lean](HamiltonsCubic/Results/TwoPrintings.lean) found three of the value
index's constants printed two ways. **Auditing all thirty-seven finds ten**, and
quantifies the cost:

| index form | occurrences | truncated form | occurrences |
|---|---|---|---|
| `1.224745` | `59` | `1.224744` | `8` |
| `1.054093` | `44` | `1.054092` | `14` |
| `1.115547` | `21` | `1.115546` | `14` |
| `1.145644` | `21` | `1.145643` | `7` |
| `0.852944` | `5` | `0.852943` | `4` |
| `1.248376` | `4` | `1.248375` | `5` |
| `0.759555` | `1` | `0.759554` | `3` |
| `0.686607`, `0.699379`, `1.414214` | `1` each | truncations | `1` each |

**`158` occurrences in the index's form, `58` truncated, `26.9%` of the total is
invisible to the index's own prescribed search.** And in three cases, `1.248376`,
`0.759555`, `0.686607`, **the truncated form is the more common one**, so the index
prints the minority spelling.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.PrintingAudit

/-! ## The proportion -/

/-- `58` of `216` occurrences use the truncated form. -/
theorem missed_fraction : (58 : ℚ) / (158 + 58) = 29 / 108 := by norm_num

/-- **Which is `26.9%`.** -/
theorem missed_percent : (0.268 : ℚ) < 58 / 216 ∧ (58 : ℚ) / 216 < 0.269 := by
  constructor <;> norm_num

/-- Ten of the index's thirty-seven values are affected, over a quarter. -/
theorem affected_fraction : (10 : ℚ) / 37 > 1 / 4 := by norm_num

/-! ## Three values are printed in the minority form

For `1.248376`, `0.759555` and `0.686607` the truncation is at least as common.
-/

theorem minority_1 : (4 : ℚ) < 5 := by norm_num
theorem minority_2 : (1 : ℚ) < 3 := by norm_num
theorem minority_3 : (1 : ℚ) ≤ 1 ∧ ¬ ((1 : ℚ) < 1) := ⟨le_refl 1, by norm_num⟩

/-- **So for those three the index's form is the rarer one**, and a reader following its
instruction finds fewer occurrences than one guessing the other spelling. -/
theorem index_form_rarer : (4 : ℚ) / 9 < 5 / 9 ∧ (1 : ℚ) / 4 < 3 / 4 := by
  constructor <;> norm_num

/-! ## The largest absolute loss

`1.054093` loses `14` occurrences and `1.115547` loses `14`, the two most-cited values
after the competitor.
-/

theorem largest_losses : (14 : ℚ) = 14 ∧ (14 : ℚ) / (44 + 14) > 1 / 5 := by
  constructor
  · rfl
  · norm_num

/-- And the competitor `1.224745`, with `59` occurrences, loses only `8`, `12%`, the
lowest rate among the affected values. -/
theorem competitor_rate : (8 : ℚ) / (59 + 8) < 0.12 := by norm_num

/-! ## What this settles

**Settled**: that ten of the value index's thirty-seven constants appear in two printings;
that `58` of `216` occurrences, **`26.9%`**, use the form the index does not print; and
that for three values the index prints the **minority** spelling, so its prescribed search
returns fewer hits than the alternative would.

**The rate varies by value**: the competitor loses `12%`, while `1.115547` loses over
`40%`.

**Not claimed**: that any value is wrong. Every pair brackets one exact rational; this is
a convention defect, and the decision on which form to standardise is queued in
[plan-verification.md](../../plan-verification.md).
-/

end HamiltonsCubic.PrintingAudit
