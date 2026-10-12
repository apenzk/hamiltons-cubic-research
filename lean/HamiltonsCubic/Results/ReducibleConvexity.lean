import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity

/-!
# `f(m) = m/(8(m-1))` is convex, and the whole proof is `ab(X-Y)² ≥ 0`

[L48](L48.lean) records three things as owed: *"Jensen's step, `f`'s convexity, and that
`‖W_a‖²` vanishes exactly at sphere factors"*. **The convexity is carried here** in its two-point
form; the multi-point Jensen step is [L48Jensen.lean](L48Jensen.lean)'s, and the third item, read as
constant curvature, is [L48Const.lean](L48Const.lean)'s.

**The convexity reduces to one square.** Writing `f(m) = 1/8 + 1/(8(m-1))`, convexity of `f` on
`m > 1` is convexity of `t ↦ 1/t` on `t > 0`. With `X = x-1`, `Y = y-1` and weights `a+b = 1`,
the two-point inequality `1/(aX+bY) ≤ a/X + b/Y` cross-multiplies to

`XY ≤ XY(a²+b²) + ab(X²+Y²)`,

and `1 - a² - b² = 2ab` turns that into `2abXY ≤ ab(X²+Y²)`, that is, **`ab(X-Y)² ≥ 0`**. The
whole convexity is that one square, with no calculus and no second derivative.

**Jensen's step follows from the library.** Convexity in the two-point form is what `ConvexOn`
packages, and `ConvexOn.map_sum_le` extends it to any finite weighted sum, which
[L48Jensen.lean](L48Jensen.lean) does.
-/

namespace HamiltonsCubic.ReducibleConvexity

/-- The block's `f`. -/
noncomputable def f (m : ℝ) : ℝ := m / (8 * (m - 1))

/-- **`f` splits as a constant plus a reciprocal**, which is where the convexity lives. -/
theorem f_split {m : ℝ} (hm : 1 < m) : f m = 1 / 8 + 1 / (8 * (m - 1)) := by
  unfold f
  have h : m - 1 ≠ 0 := by intro h; linarith
  field_simp
  ring

/-! ## The reciprocal's convexity is one square -/

/-- **The cross-multiplied form.** For `X, Y > 0` and weights summing to one, the two-point
inequality for `1/t` is exactly `ab(X-Y)² ≥ 0`. -/
theorem cross_multiplied (X Y a b : ℝ) (hab : a + b = 1) :
    (a * X + b * Y) * (a * Y + b * X) - X * Y = a * b * (X - Y) ^ 2 := by
  have hb : b = 1 - a := by linarith
  subst hb; ring

/-- **So `1/t` satisfies the two-point convexity inequality on `t > 0`.** -/
theorem inv_two_point {X Y a b : ℝ} (hX : 0 < X) (hY : 0 < Y)
    (ha : 0 ≤ a) (hb : 0 ≤ b) (hab : a + b = 1) :
    1 / (a * X + b * Y) ≤ a / X + b / Y := by
  have hmix : 0 < a * X + b * Y := by
    rcases eq_or_lt_of_le ha with h | h
    · have hb1 : b = 1 := by linarith
      rw [← h, hb1]; simpa using hY
    · nlinarith
  have hsq : 0 ≤ a * b * (X - Y) ^ 2 := by positivity
  have key : X * Y ≤ (a * X + b * Y) * (a * Y + b * X) := by
    linarith [cross_multiplied X Y a b hab]
  rw [div_add_div _ _ (ne_of_gt hX) (ne_of_gt hY), div_le_div_iff₀ hmix (by positivity)]
  nlinarith [key, hX, hY, hmix]

/-- **Hence `f` is convex on `m > 1`**, in the two-point form `ConvexOn` packages. Both sides
split as `1/8` plus a reciprocal, and the difference is `inv_two_point`. -/
theorem f_two_point {x y a b : ℝ} (hx : 1 < x) (hy : 1 < y)
    (ha : 0 ≤ a) (hb : 0 ≤ b) (hab : a + b = 1) :
    f (a * x + b * y) ≤ a * f x + b * f y := by
  have hX : (0:ℝ) < x - 1 := by linarith
  have hY : (0:ℝ) < y - 1 := by linarith
  have hb' : b = 1 - a := by linarith
  have hS : (0:ℝ) < a * (x - 1) + b * (y - 1) := by
    rcases eq_or_lt_of_le ha with h | h
    · have hbe : b = 1 := by linarith
      rw [← h, hbe]; simpa using hY
    · nlinarith
  have hA : f (a * x + b * y) = 1 / 8 + (1 / (a * (x - 1) + b * (y - 1))) / 8 := by
    unfold f
    have hd : a * x + b * y - 1 = a * (x - 1) + b * (y - 1) := by subst hb'; ring
    rw [hd]
    have hne : a * (x - 1) + b * (y - 1) ≠ 0 := ne_of_gt hS
    have hnum : a * x + b * y = (a * (x - 1) + b * (y - 1)) + 1 := by subst hb'; ring
    rw [hnum]
    field_simp
  have hB : a * f x + b * f y = 1 / 8 + (a / (x - 1) + b / (y - 1)) / 8 := by
    unfold f
    have h1 : x - 1 ≠ 0 := ne_of_gt hX
    have h2 : y - 1 ≠ 0 := ne_of_gt hY
    subst hb'
    field_simp
    ring
  rw [hA, hB]
  have := inv_two_point hX hY ha hb hab
  linarith

end HamiltonsCubic.ReducibleConvexity
