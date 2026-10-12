import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L22, the tangential meeting is a minimum, and one stated `α` sits outside its own branch

[route-a.md](../../../findings/route-a.md)'s Observation L22. The audit confirms `α* = 32/141`
and *"the tangential meeting of `V(t)`'s branches at `t* = √30/8`"* were re-derived; the reason
the meeting is tangential is arithmetic and is carried here.

**The constant branch is the other branch's minimum.** `V(t) = 5/(16t) + 2t/3` for `t > t*`, and
`a/t + bt` is minimised at `t = √(a/b)` with value `2√(ab)`. With `a = 5/16` and `b = 2/3`:

* `t*² = a/b = 15/32`, and `(√30/8)² = 30/64 = 15/32`, so `t*` is that minimiser;
* the minimum value squared is `4ab = 4·(5/16)·(2/3) = 5/6`, which is the constant branch
  `√(5/6)` squared.

So the branches meet tangentially **because a minimum has zero slope**, `5/(16t*²) = 2/3` exactly.
`V` is the piecewise function and is neither branch's minimum nor their maximum: `a/t + bt` exceeds
`√(5/6)` on both sides of `t*`, while `V` follows it only above `t*`. At `t = 1`, `V = 47/48` against
`min = √(5/6)`. Every step above is rational; no root is taken.

**`α* = 32/141` is the decimal the same paragraph prints.** `32/141 = 0.226950…`, which rounds to
the stated `0.2270`.

**But the worst-margin point is stated below the branch that is supposed to cover it.** The
paragraph gives this branch as covering `α ≥ 0.2270` and then places the worst overlap margin at
`α ≈ 0.223`, and `0.223 < 32/141`. Either the margin is measured between quantities other than
the two coverage endpoints, or one of the two figures is off; the arithmetic settles only that
they are inconsistent as written. *Flagged rather than resolved: the paragraph does not say what
the margin is a margin between.*

**And the borderline at `α = 1/3` is exact**: `(3 - 5·(1/3))/√3 = 4/(3√3)`, matching what the
cited bound returns there, so the degeneracy is by construction, as the block says.
-/

namespace HamiltonsCubic.LocalizationEstimate

/-! ## `t*` is the minimiser, and the meeting is tangential -/

/-- **`t*² = 15/32`**, from `(√30/8)² = 30/64`. -/
theorem tstar_sq : (30 : ℚ) / 64 = 15 / 32 := by norm_num

/-- **And that is `a/b` for `a = 5/16`, `b = 2/3`**, so `t*` minimises `a/t + bt`. -/
theorem tstar_is_minimiser : (5 / 16 : ℚ) / (2 / 3) = 15 / 32 := by norm_num

/-- **The slope vanishes there**: `5/(16t*²) = 2/3` exactly. -/
theorem slope_vanishes : (5 : ℚ) / (16 * (15 / 32)) = 2 / 3 := by norm_num

/-- **The minimum value squared is `5/6`**, from `(2√(ab))² = 4ab`, matching the constant
branch `√(5/6)`. So the two branches meet at a value, and tangentially. -/
theorem minimum_value_sq : 4 * (5 / 16 : ℚ) * (2 / 3) = 5 / 6 := by norm_num

/-- The equivalent form the block prints, `t* = (3/4)√(5/6)`, squares to the same thing. -/
theorem tstar_alternate_form : ((3 : ℚ) / 4) ^ 2 * (5 / 6) = 15 / 32 := by norm_num

/-! ## `α*` and its decimal -/

/-- **`32/141` is the printed `0.2270`**, to four places. -/
theorem alpha_star_decimal :
    (2269 : ℚ) / 10000 < 32 / 141 ∧ (32 : ℚ) / 141 < 2270 / 10000 := by
  constructor <;> norm_num

/-! ## The worst-margin point sits below its own branch -/

/-- **`0.223 < 32/141`**, so the `α` named as carrying the worst margin lies strictly below the
threshold the same paragraph gives for this branch's coverage. -/
theorem margin_point_below_threshold : (223 : ℚ) / 1000 < 32 / 141 := by norm_num

/-- The gap is about `0.0040`, which is of the same order as the `0.0074` margin quoted, so the
discrepancy is not a rounding artefact. -/
theorem gap_is_material :
    (39 : ℚ) / 10000 < 32 / 141 - 223 / 1000 ∧ 32 / 141 - (223 : ℚ) / 1000 < 40 / 10000 := by
  constructor <;> norm_num

/-- The coverage endpoints the paragraph does give overlap by `0.0080` at the limit. -/
theorem stated_overlap : (2350 : ℚ) / 10000 - 2270 / 10000 = 80 / 10000 := by norm_num

/-! ## The borderline at `α = 1/3` -/

/-- **`3 - 5·(1/3) = 4/3`**, so the required bound there is `4/(3√3)`, borderline by
construction. -/
theorem borderline_numerator : (3 : ℚ) - 5 * (1 / 3) = 4 / 3 := by norm_num

/-- Nienhaus's reach falls with `n`: `0.3223` at `n = 12` against `0.2350` in the limit. -/
theorem reach_falls : (2350 : ℚ) / 10000 < 3223 / 10000 := by norm_num

end HamiltonsCubic.LocalizationEstimate
