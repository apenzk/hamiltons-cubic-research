import Mathlib

set_option linter.style.longLine false

/-!
# L237: the exact maxima `2 + √3` and `2 + √2` of three-slot configurations

[SevenFrameGap.lean](SevenFrameGap.lean) bounds the fifty-two three-slot configurations other than the
all-plus triangle and star by `3733/1000` times the angles' squared norm, and its header records *"two more
reach exactly `2 + √3 ≈ 3.7321` (the path with a kernel slot, and the star with one minus slot), and the rest
are at most `2 + √2`"*. The L237 row owes *"the exact maxima of two three-slot configurations, $2+\sqrt2$
([r1122](../../../reviews/REVIEW_r1122.md)'s screen) and $2+\sqrt3$"*. With `s = √3`, `t = √2`:

* `kernel_le`, `kernel_attained`: `(a+b)² + (a+c)² + a² ≤ (2+√3)(a² + b² + c²)` for all reals, from
  `(2+s)Σ - Q = ((1+s)/2)((b+c) - (s-1)a)² + ((1+s)/2)(b-c)²`, with equality at `(1, (s-1)/2, (s-1)/2)`
  (`slot_ceiling_7`'s form);
* `minus_le`, `minus_attained`: `(a+b)² + (a+c)² + (a-d)² ≤ (2+√3)(a²+b²+c²+d²)` for nonnegative angles,
  since `(a-d)² ≤ a² + d²` there, with equality at `d = 0` (`slot_ceiling_3`'s form);
* `path_le`, `path_attained`: `(a+b)² + (a+c)² + (b+d)² ≤ (2+√2)(a²+b²+c²+d²)` for all reals, from
  `(2+t)Σ - Q = ((1+t)/2)((c+d) - (t-1)(a+b))² + ((1+t)/2)((c-d) - (t-1)(a-b))² + (a-b)²`, with equality at
  `(a, b, c, d) = (1+t, 1+t, 1, 1)` (`slot_ceiling_0`'s form, the path `c–a–b–d`);
* `pm_edge_le`, `pm_edge_attained`: `(a+b)² + (a-b)² + (a+c)² ≤ (2+√2)(a²+b²+c²)`, equality at `(1+t, 0, 1)`
  (KyFanBracketCap's `slot3_pm_edge`, the 2+√2 of r1122's screen).

*"The path with a kernel slot"* is the path `b–a–c` with the kernel slot at its centre `a`.
-/

namespace HamiltonsCubic.L237Maxima

theorem s_sq : Real.sqrt 3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
theorem t_sq : Real.sqrt 2 ^ 2 = 2 := Real.sq_sqrt (by norm_num)

/-- **The kernel-slot configuration's ceiling**: `(a+b)² + (a+c)² + a² ≤ (2+√3)(a²+b²+c²)`. -/
theorem kernel_le (a b c : ℝ) :
    (a + b) ^ 2 + (a + c) ^ 2 + a ^ 2 ≤ (2 + Real.sqrt 3) * (a ^ 2 + b ^ 2 + c ^ 2) := by
  set s := Real.sqrt 3
  have hs : s ^ 2 = 3 := s_sq
  have hs0 : 0 ≤ s := Real.sqrt_nonneg 3
  have hid : (2 + s) * (a ^ 2 + b ^ 2 + c ^ 2) - ((a + b) ^ 2 + (a + c) ^ 2 + a ^ 2)
      = ((1 + s) / 2) * ((b + c) - (s - 1) * a) ^ 2 + ((1 + s) / 2) * (b - c) ^ 2 := by
    linear_combination (a * (b + c) - (s - 1) * a ^ 2 / 2) * hs
  have h1 : 0 ≤ ((1 + s) / 2) * ((b + c) - (s - 1) * a) ^ 2 := by positivity
  have h2 : 0 ≤ ((1 + s) / 2) * (b - c) ^ 2 := by positivity
  linarith

/-- **Attained**: equality at `(1, (√3-1)/2, (√3-1)/2)`, a nonnegative vector. -/
theorem kernel_attained :
    let s := Real.sqrt 3
    0 ≤ (s - 1) / 2 ∧
      (1 + (s - 1) / 2) ^ 2 + (1 + (s - 1) / 2) ^ 2 + 1 ^ 2
        = (2 + s) * (1 ^ 2 + ((s - 1) / 2) ^ 2 + ((s - 1) / 2) ^ 2) := by
  intro s
  have hs : s ^ 2 = 3 := s_sq
  have hs1 : 1 ≤ s := by
    rw [show (1 : ℝ) = Real.sqrt 1 by simp]; exact Real.sqrt_le_sqrt (by norm_num)
  refine ⟨by linarith, ?_⟩
  linear_combination ((1 - s) / 2 : ℝ) * hs

/-- **The minus-slot configuration's ceiling**, on nonnegative angles. -/
theorem minus_le (a b c d : ℝ) (ha : 0 ≤ a) (hd : 0 ≤ d) :
    (a + b) ^ 2 + (a + c) ^ 2 + (a - d) ^ 2 ≤ (2 + Real.sqrt 3) * (a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2) := by
  have h := kernel_le a b c
  have hs0 : 0 ≤ Real.sqrt 3 := Real.sqrt_nonneg 3
  have had : (a - d) ^ 2 ≤ a ^ 2 + d ^ 2 := by nlinarith [mul_nonneg ha hd]
  have hd2 : d ^ 2 ≤ (2 + Real.sqrt 3) * d ^ 2 := by nlinarith [sq_nonneg d]
  nlinarith

/-- **Attained** at `d = 0` with the kernel configuration's vector. -/
theorem minus_attained :
    let s := Real.sqrt 3
    (1 + (s - 1) / 2) ^ 2 + (1 + (s - 1) / 2) ^ 2 + (1 - 0) ^ 2
      = (2 + s) * (1 ^ 2 + ((s - 1) / 2) ^ 2 + ((s - 1) / 2) ^ 2 + 0 ^ 2) := by
  intro s
  have h := kernel_attained.2
  simp only [sub_zero] at h ⊢
  linarith

/-- **The path configuration's ceiling**: `(a+b)² + (a+c)² + (b+d)² ≤ (2+√2)(a²+b²+c²+d²)`. -/
theorem path_le (a b c d : ℝ) :
    (a + b) ^ 2 + (a + c) ^ 2 + (b + d) ^ 2 ≤ (2 + Real.sqrt 2) * (a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2) := by
  set t := Real.sqrt 2
  have ht : t ^ 2 = 2 := t_sq
  have ht0 : 0 ≤ t := Real.sqrt_nonneg 2
  have hid : (2 + t) * (a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2) - ((a + b) ^ 2 + (a + c) ^ 2 + (b + d) ^ 2)
      = ((1 + t) / 2) * ((c + d) - (t - 1) * (a + b)) ^ 2
        + ((1 + t) / 2) * ((c - d) - (t - 1) * (a - b)) ^ 2 + (a - b) ^ 2 := by
    linear_combination (2 * (a * c + b * d) - (t - 1) * (a ^ 2 + b ^ 2)) * ht
  have h1 : 0 ≤ ((1 + t) / 2) * ((c + d) - (t - 1) * (a + b)) ^ 2 := by positivity
  have h2 : 0 ≤ ((1 + t) / 2) * ((c - d) - (t - 1) * (a - b)) ^ 2 := by positivity
  nlinarith [sq_nonneg (a - b)]

/-- **Attained** at `(a, b, c, d) = (1+√2, 1+√2, 1, 1)`. -/
theorem path_attained :
    let t := Real.sqrt 2
    ((1 + t) + (1 + t)) ^ 2 + ((1 + t) + 1) ^ 2 + ((1 + t) + 1) ^ 2
      = (2 + t) * ((1 + t) ^ 2 + (1 + t) ^ 2 + 1 ^ 2 + 1 ^ 2) := by
  intro t
  have ht : t ^ 2 = 2 := t_sq
  linear_combination (-(2 : ℝ) - 2 * t) * ht

/-- **The pm-edge configuration's ceiling** ([r1731](../../../reviews/REVIEW_r1731.md) G1, KyFanBracketCap's
`slot3_pm_edge`): `(a+b)² + (a-b)² + (a+c)² ≤ (2+√2)(a²+b²+c²)`, from
`(2+t)Σ - Q = (1+t)(c - (t-1)a)² + t b²`. -/
theorem pm_edge_le (a b c : ℝ) :
    (a + b) ^ 2 + (a - b) ^ 2 + (a + c) ^ 2 ≤ (2 + Real.sqrt 2) * (a ^ 2 + b ^ 2 + c ^ 2) := by
  set t := Real.sqrt 2
  have ht : t ^ 2 = 2 := t_sq
  have ht0 : 0 ≤ t := Real.sqrt_nonneg 2
  have hid : (2 + t) * (a ^ 2 + b ^ 2 + c ^ 2) - ((a + b) ^ 2 + (a - b) ^ 2 + (a + c) ^ 2)
      = (1 + t) * (c - (t - 1) * a) ^ 2 + t * b ^ 2 := by
    linear_combination (2 * a * c - (t - 1) * a ^ 2) * ht
  have h1 : 0 ≤ (1 + t) * (c - (t - 1) * a) ^ 2 := by positivity
  have h2 : 0 ≤ t * b ^ 2 := by positivity
  linarith

/-- **Attained** at `(a, b, c) = (1+√2, 0, 1)`. -/
theorem pm_edge_attained :
    let t := Real.sqrt 2
    ((1 + t) + 0) ^ 2 + ((1 + t) - 0) ^ 2 + ((1 + t) + 1) ^ 2
      = (2 + t) * ((1 + t) ^ 2 + 0 ^ 2 + 1 ^ 2) := by
  intro t
  have ht : t ^ 2 = 2 := t_sq
  linear_combination (-(1 + t)) * ht

end HamiltonsCubic.L237Maxima
