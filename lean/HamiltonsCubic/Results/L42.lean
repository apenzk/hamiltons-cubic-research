import Mathlib

/-!
# L42, the sharp dual weight: why the constant cannot be improved

`3 M(λ_P) ≤ h (s² - u)`, with `h` the harmonic mean of the three largest
positives, `s = Σλ`, `u = Σλ²`, and `M` the maximum of a triangle packing over
`{t ≥ 0 : Σ_{γ ∉ {α,β}} t_{αβγ} ≤ 2 for every pair}`.

**Re-filed.** The scan put this row in `ready` as *a real-variable inequality*.
It is not: `M` is a maximum over a polytope, and the general bound needs the LP.
That is the scan's own systematic error, classifying from the statement rather
than from what the argument needs, and the row is re-filed as blocked on it.

**What phase 1 found instead.** At *exactly* three positives the polytope has a
single vertex: there is one triple, each pair meets it once, so the constraint
is `t ≤ 2` and `M = 2abc`. And there the inequality is an **equality**, for any
three positives whatever, which is precisely the reason the constant cannot be
improved. That is elementary and is proved here.
-/

namespace HamiltonsCubic.L42

/-- The harmonic mean of three positives. -/
noncomputable def hmean (a b c : ℝ) : ℝ := 3 / (1 / a + 1 / b + 1 / c)

/-- `s² - u = 2(ab + bc + ca)` on three values, the identity the bound's right
side is built from. -/
theorem s_sq_sub_u (a b c : ℝ) :
    (a + b + c) ^ 2 - (a ^ 2 + b ^ 2 + c ^ 2) = 2 * (a * b + b * c + c * a) := by
  ring

/-- The harmonic mean in closed form. -/
theorem hmean_eq {a b c : ℝ} (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) :
    hmean a b c = 3 * (a * b * c) / (a * b + b * c + c * a) := by
  have hs : 0 < a * b + b * c + c * a := by positivity
  unfold hmean
  rw [div_eq_div_iff (by positivity) (ne_of_gt hs)]
  field_simp
  ring

/-- **The bound is an equality at three positives**, for any three whatever.
`M = 2abc` there, so `3M = 6abc = h (s² - u)`. -/
theorem sharp_at_three {a b c : ℝ} (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) :
    3 * (2 * (a * b * c))
      = hmean a b c * ((a + b + c) ^ 2 - (a ^ 2 + b ^ 2 + c ^ 2)) := by
  have hs : (0:ℝ) < a * b + b * c + c * a := by positivity
  rw [hmean_eq ha hb hc, s_sq_sub_u]
  field_simp

/-- So no constant below `1` works in `3M ≤ κ · h (s² - u)`: any `κ < 1` fails at
three equal positives. -/
theorem constant_unimprovable {κ : ℝ} (hκ : κ < 1) :
    ¬ (3 * (2 * (1 * 1 * 1)) ≤ κ * (hmean 1 1 1 * ((1 + 1 + 1) ^ 2 - (1 ^ 2 + 1 ^ 2 + 1 ^ 2)))) := by
  have h := sharp_at_three (a := 1) (b := 1) (c := 1) one_pos one_pos one_pos
  rw [← h]
  norm_num
  linarith

end HamiltonsCubic.L42
