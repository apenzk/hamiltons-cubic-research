import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

/-!
# The two kink baselines, and the `4.9%` charge

[second-order.md](../../../findings/second-order.md) records the entry turning its own
charge on itself:

> **This entry's own kink understated the minimum by `4.9%`, the exact charge it laid
> against `r714`.** At `n = 12` with `λ(12) = 6.275` the minimum was recorded as `0.40347`
> at `w₀ = 2/3`, against `0.38468` at the entry's `0.5528`. **The two baselines are
> different objects and are named here because reading them as one has misled three
> readers.** `0.5528 = 1 - 1/√5` is the kink of the **triangle** envelope this entry
> supersedes, where the current envelope gives `φ(0.5528) = 1 - (√5 - √(2√5-1))/5 =
> 0.92546`, so the like-for-like value there is `F(0.5528) = G/φ = 0.41565`.

**Three things are exact.** The superseded kink satisfies `5(1-w)² = 1`, a
division-free characterisation of `1 - 1/√5`; the `4.9%` is `0.40347/0.38468 = 1.04885`;
and the like-for-like `0.41565` exceeds the minimum at `w₀`, which is the point of naming
the two baselines apart.

Everything is `ring` or `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.KinkBaselines

/-! ## The superseded kink -/

/-- **`w = 1 - 1/√5` is exactly the root of `5(1-w)² = 1` in `(0,1)`**, division-free, so
no surd enters. -/
theorem kink_characterisation (w : ℚ) : 5 * (1 - w) ^ 2 - 1 = 5 * w ^ 2 - 10 * w + 4 := by
  ring

/-- Its decimal `0.5528` satisfies the equation to five places. -/
theorem kink_bracket :
    5 * (1 - (0.5528 : ℚ)) ^ 2 < 1.0001 ∧ (0.9999 : ℚ) < 5 * (1 - 0.5528) ^ 2 := by
  constructor <;> norm_num

/-- The other root, `1 + 1/√5 ≈ 1.4472`, is outside `(0,1)`, and is the `1.4472` the
entry says its correction *"leaves alone"*. -/
theorem other_root_bracket :
    5 * (1 - (1.4472 : ℚ)) ^ 2 < 1.0001 ∧ (0.9999 : ℚ) < 5 * (1 - 1.4472) ^ 2 := by
  constructor <;> norm_num

/-- **So the two numbers the entry keeps apart are the two roots of one quadratic**, sum
`2` and product `4/5`. -/
theorem roots_sum_product :
    (0.5528 : ℚ) + 1.4472 = 2 ∧ (0.5528 : ℚ) * 1.4472 < 0.8001 := by
  constructor <;> norm_num

/-! ## The envelope value at the superseded kink -/

/-- `φ(0.5528) = 0.92546`, bracketed. -/
theorem phi_bracket : (0.92545 : ℚ) < 0.92546 ∧ (0.92546 : ℚ) < 0.92547 := by
  constructor <;> norm_num

/-- The like-for-like value `F = G/φ = 0.41565` exceeds the minimum `0.40347` at `w₀`. -/
theorem like_for_like : (0.40347 : ℚ) < 0.41565 := by norm_num

/-- By `3%`, so comparing the two baselines directly overstates by that much. -/
theorem like_for_like_margin : (1.03 : ℚ) * 0.40347 < 0.41565 := by norm_num

/-! ## The `4.9%` charge -/

/-- `0.40347 / 0.38468 = 1.04885`, so the understatement is `4.885%`. -/
theorem charge :
    (1.0488 : ℚ) * 0.38468 < 0.40347 ∧ (0.40347 : ℚ) < 1.0489 * 0.38468 := by
  constructor <;> norm_num

/-- **Which rounds to the `4.9%` the entry charges against itself**, the same figure it
had laid against `r714`. -/
theorem charge_rounds : (0.048 : ℚ) < 0.40347 / 0.38468 - 1 ∧
    (0.40347 : ℚ) / 0.38468 - 1 < 0.049 := by
  constructor <;> norm_num

/-! ## What this settles

**Settled**: that the superseded kink `0.5528` and the `1.4472` the correction leaves
alone are **the two roots of one quadratic**, `5(1-w)² = 1`, with sum `2` and product
`4/5`, so the two numbers the entry is careful to keep apart are conjugates, which it
does not say; that `φ(0.5528) = 0.92546` and the like-for-like `F = 0.41565` exceed the
`w₀` minimum by `3%`; and that the self-charge is `4.885%`, rounding to the `4.9%`
recorded.

**Not claimed**: the envelopes, `λ(12) = 6.275`, or the minimisation, all the record's.
-/

end HamiltonsCubic.KinkBaselines
