import HamiltonsCubic.Results.Theta0

/-!
# The LP tightening, and why it does not scale

[bounds-relaxations.md](../../../findings/bounds-relaxations.md) records:

> Adding the other `N-1` moves the optimum from `1.722739` to `1.413614` at `n = 6`, an
> `18%` cut, **and the tightening does not scale**: at `n = 8` it moves `2.290283` to
> `2.2585`, about `1.4%`, while the overshoot itself grows from `1.63 θ₀` to `2.00 θ₀`. So
> the route stays closed, on better evidence than before.

Every figure checks: the cut is `17.9%` at `n = 6` and `1.39%` at `n = 8`, and the old
optima stand at `1.634 θ₀(6)` and `1.999 θ₀(8)`.

**And the conclusion is the one the numbers force**: even after the cut, `1.413614`
exceeds `θ₀(6) = 1.054093` by `34%`, so the LP does not reach the bound at either
dimension, *the tightening improves the evidence without moving the verdict.*

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.LPCut

open HamiltonsCubic.Theta0

/-! ## The two cuts -/

/-- At `n = 6`: `1.722739 → 1.413614`, a `17.9%` cut. -/
theorem cut_at_6 :
    (0.179 : ℚ) * 1.722739 < 1.722739 - 1.413614 ∧
    (1.722739 : ℚ) - 1.413614 < 0.18 * 1.722739 := by
  constructor <;> norm_num

/-- At `n = 8`: `2.290283 → 2.2585`, a `1.39%` cut. -/
theorem cut_at_8 :
    (0.0138 : ℚ) * 2.290283 < 2.290283 - 2.2585 ∧
    (2.290283 : ℚ) - 2.2585 < 0.014 * 2.290283 := by
  constructor <;> norm_num

/-- **The tightening falls by a factor over `12`** between the two dimensions, which is
the record's *"does not scale"*, quantified. -/
theorem does_not_scale : (12 : ℚ) * ((2.290283 - 2.2585) / 2.290283) < (1.722739 - 1.413614) / 1.722739 := by
  norm_num

/-! ## The overshoot grows -/

/-- The old optimum at `n = 6` is `1.634 θ₀(6)`. -/
theorem overshoot_6 :
    (1.634 : ℚ) ^ 2 * evenSq 6 < 1.722739 ^ 2 ∧
    (1.722739 : ℚ) ^ 2 < 1.635 ^ 2 * evenSq 6 := by
  constructor <;> norm_num [evenSq]

/-- And at `n = 8` it is `1.999 θ₀(8)`, the record's `2.00`. -/
theorem overshoot_8 :
    (1.999 : ℚ) ^ 2 * evenSq 8 < 2.290283 ^ 2 ∧
    (2.290283 : ℚ) ^ 2 < 2 ^ 2 * evenSq 8 := by
  constructor <;> norm_num [evenSq]

/-- **So the overshoot grows while the tightening shrinks**, the two move in opposite
directions, which is why the route stays closed. -/
theorem opposite_directions :
    ((2.290283 - 2.2585) / 2.290283 : ℚ) < (1.722739 - 1.413614) / 1.722739 ∧
    (1.635 : ℚ) < 2 := by
  constructor <;> norm_num

/-! ## Even after the cut, the LP misses -/

/-- `1.413614` still exceeds `θ₀(6)` by over `34%`. -/
theorem still_misses : (1.34 : ℚ) ^ 2 * evenSq 6 < 1.413614 ^ 2 := by
  norm_num [evenSq]

/-- And `2.2585` exceeds `θ₀(8)` by over `97%`. -/
theorem still_misses_8 : (1.97 : ℚ) ^ 2 * evenSq 8 < 2.2585 ^ 2 := by
  norm_num [evenSq]

/-! ## The two corrections err in opposite directions

The old `n = 6` LP figure was `1.6059`, corrected **upward** to `1.7227`, an
under-converged ascent reporting below the true optimum. The `n = 9` diagonal figure was
`1.11153`, corrected **downward** to `√(21/17) = 1.111437`, reporting above.

**So "the direction a stalled optimiser errs" is not one direction**, and the two
corrections in this record run opposite ways.
-/

theorem lp_corrected_upward : (1.6059 : ℚ) < 1.722739 := by norm_num

theorem diagonal_corrected_downward : (21 : ℚ) / 17 < (1.11153 : ℚ) ^ 2 := by norm_num

/-- The LP figure was low by `6.78%`; the diagonal figure high by `0.008%`. -/
theorem correction_sizes :
    (0.067 : ℚ) * 1.722739 < 1.722739 - 1.6059 ∧
    (1.11153 : ℚ) - 1.111437 < 0.0001 := by
  constructor <;> norm_num

/-! ## What this settles

**Settled**: the two cuts, `17.9%` and `1.39%`, so the tightening falls by a factor over
`12` between `n = 6` and `n = 8`; the two overshoots, `1.634 θ₀` and `1.999 θ₀`, growing
while the tightening shrinks; and that **even after the cut the LP misses `θ₀` by `34%` at
`n = 6` and `97%` at `n = 8`**, so the improved evidence does not move the verdict.

**And a caution**: this record's two optimiser corrections run in **opposite** directions
the LP figure was too low, the diagonal figure too high, so *"the direction a stalled
optimiser errs"* names no single direction. A gloss of mine in
[DiagonalOdd](HamiltonsCubic/Results/DiagonalOdd.lean) assumed it did, and is corrected
there.

**Not claimed**: the LP itself, its constraint sets, or the optima.
-/

end HamiltonsCubic.LPCut
