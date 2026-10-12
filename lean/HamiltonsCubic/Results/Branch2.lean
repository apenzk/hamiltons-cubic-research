import Mathlib.Tactic.NormNum

/-!
# Branch 2's margin at `n = 12`, quantified

[second-order.md](../../../findings/second-order.md) concludes:

> Against [L143](../../../findings/bounds.md)'s `S ≤ 4.162` and
> [L70](../../../findings/bounds.md)'s `S ≤ 10` at `n = 12`, **branch 2 binds at `n = 12`
> decisively**, the threshold there being `T = 18.00` at `ρ^eff`, and `17.26` at the
> coefficient `1`. Three readers derived `T` independently and agree to three digits.

**"Decisively" is a ratio, and the entry does not give it.** It also gives two values of
`T` without saying whether the conclusion depends on which is used. It does not: both
exceed both caps, so the verdict is invariant to the coefficient, which is what makes
the conclusion *firmer than either side first had it*, and is stated nowhere.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.Branch2

/-! ## The margins against the two caps -/

/-- Against [L70](../../../findings/bounds.md)'s cap, `T` clears by `80%`. -/
theorem over_L70 : (1.8 : ℚ) * 10 ≤ 18.00 := by norm_num

/-- Against [L143](../../../findings/bounds.md)'s cap, by more than a factor of four. -/
theorem over_L143 : (4 : ℚ) * 4.162 < 18.00 := by norm_num

/-- Exactly: `18.00 / 4.162 > 4.32`. -/
theorem over_L143_precise : (4.32 : ℚ) * 4.162 < 18.00 := by norm_num

/-! ## The verdict does not depend on which `T` is used

The entry gives `18.00` at `ρ^eff` and `17.26` at the coefficient `1`. Both clear both
caps, so the conclusion is the same either way, and the two differ by under `5%`.
-/

theorem lower_T_over_L70 : (10 : ℚ) < 17.26 := by norm_num

theorem lower_T_over_L143 : (4 : ℚ) * 4.162 < 17.26 := by norm_num

/-- **The two values differ by under `5%`**, so "agree to three digits" is a statement
about the derivation, not about a discrepancy that could matter here. -/
theorem T_values_close : (18.00 : ℚ) - 17.26 < 0.05 * 17.26 := by norm_num

/-- And the weaker of the two still clears the stronger cap by more than four, so the
margin survives the worst combination of the entry's own numbers. -/
theorem worst_case : (4 : ℚ) * 4.162 < 17.26 := by norm_num

/-! ## The two caps are not comparable in strength

`L143`'s `4.162` is stronger than `L70`'s `10` by a factor of `2.4`. The entry cites both
in one breath, which reads as corroboration; **one of them is nearly two and a half times
the other, so citing the weaker adds nothing once the stronger is available.**
-/

theorem caps_ratio : (2.4 : ℚ) * 4.162 < 10 := by norm_num

theorem L143_stronger : (4.162 : ℚ) < 10 := by norm_num

/-! ## What this settles

**Settled**: that *"decisively"* is a factor of `1.8` against the weaker cap and over
`4.3` against the stronger; that the conclusion is invariant to which of the entry's two
`T` values is used, since both clear both caps, and survives the worst pairing; and that
the two caps differ by a factor of `2.4`, so citing them together is not two
confirmations.

**Not settled here**: `T` itself, the two caps, or the branch structure, all the
record's. What is checked is what its own numbers say about each other.
-/

end HamiltonsCubic.Branch2
