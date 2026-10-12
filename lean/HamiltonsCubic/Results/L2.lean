import Mathlib

/-!
# L2, the exact dimension threshold

The balanced sphere product overtakes the `ℂP²`-type competitor at
`n = 6 + 2√7 ≈ 11.29`, so the integer cutoff is `n ≥ 12`.

**The split.** L2's proof has two inputs and one argument:

* `θ₀(n)² = 2(n-1)(n-2)/n²` for the balanced sphere product, and `θ² = 3/2` for
  the competitor. These are values of `θ` on named objects; proving them needs
  `𝒲ₙ` and `Q`, which do not exist yet.
* Everything the block does **with** those two values. That is pure algebra over
  `ℝ` and `ℤ`, and it is what this file proves.

So the threshold arithmetic is closed here and the two inputs are imported as
definitions.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L2

/-- `θ(Sᵖ × S^q)² = 2(n-1)(p-1)(q-1) / ((n-2)pq)`. -/
noncomputable def sphereProductSq (n p q : ℝ) : ℝ :=
  2 * (n - 1) * (p - 1) * (q - 1) / ((n - 2) * p * q)

/-- `θ₀(n)² = 2(n-1)(n-2)/n²`, the balanced sphere product. -/
noncomputable def theta0Sq (n : ℝ) : ℝ := 2 * (n - 1) * (n - 2) / n ^ 2

/-- `θ₀(n)²` is the balanced case `p = q = n/2` of the sphere-product formula. -/
theorem sphereProductSq_balanced {n : ℝ} (hn : n ≠ 0) (hn2 : n ≠ 2) :
    sphereProductSq n (n / 2) (n / 2) = theta0Sq n := by
  unfold sphereProductSq theta0Sq
  have h2 : n - 2 ≠ 0 := sub_ne_zero.mpr hn2
  field_simp

/-- The threshold identity: `θ₀(n)² - 3/2 = (n² - 12n + 8)/(2n²)`. -/
theorem theta0Sq_sub_three_halves {n : ℝ} (hn : n ≠ 0) :
    theta0Sq n - 3 / 2 = (n ^ 2 - 12 * n + 8) / (2 * n ^ 2) := by
  unfold theta0Sq
  field_simp
  ring

/-- `6 + 2√7` is a root of the threshold polynomial. -/
theorem crossover_root :
    (6 + 2 * Real.sqrt 7) ^ 2 - 12 * (6 + 2 * Real.sqrt 7) + 8 = 0 := by
  have h : Real.sqrt 7 ^ 2 = 7 := Real.sq_sqrt (by norm_num)
  nlinarith [h]

/-- The root is irrational, so no integer attains it and the crossing is strict. -/
theorem crossover_irrational : Irrational (6 + 2 * Real.sqrt 7) := by
  have hp : Nat.Prime 7 := by norm_num
  have h7 : Irrational (Real.sqrt 7) := by simpa using hp.irrational_sqrt
  have h2 : Irrational ((2 : ℚ) * Real.sqrt 7) := h7.ratCast_mul (by norm_num)
  have h6 : Irrational ((6 : ℚ) + (2 : ℚ) * Real.sqrt 7) := h2.ratCast_add 6
  simpa using h6

/-- Below the threshold: strictly negative for `4 ≤ n ≤ 11`. -/
theorem threshold_neg {n : ℤ} (h4 : 4 ≤ n) (h11 : n ≤ 11) : n ^ 2 - 12 * n + 8 < 0 := by
  nlinarith [mul_nonneg (by linarith : (0:ℤ) ≤ n - 4) (by linarith : (0:ℤ) ≤ 11 - n)]

/-- At and above the threshold: strictly positive for `n ≥ 12`. -/
theorem threshold_pos {n : ℤ} (h : 12 ≤ n) : 0 < n ^ 2 - 12 * n + 8 := by
  nlinarith [mul_nonneg (by linarith : (0:ℤ) ≤ n) (by linarith : (0:ℤ) ≤ n - 12)]

/-- The two integers the block names, exactly. -/
theorem threshold_at_eleven : (11:ℤ) ^ 2 - 12 * 11 + 8 = -3 := by norm_num

theorem threshold_at_twelve : (12:ℤ) ^ 2 - 12 * 12 + 8 = 8 := by norm_num

/-- **The integer cutoff is exactly 12**, over `4 ≤ n`. -/
theorem cutoff_is_twelve {n : ℤ} (h4 : 4 ≤ n) :
    (0 < n ^ 2 - 12 * n + 8 ↔ 12 ≤ n) := by
  constructor
  · intro h
    by_contra hc
    exact absurd h (not_lt.mpr (le_of_lt (threshold_neg h4 (by omega))))
  · exact threshold_pos

/-!
## The odd-parity companion

At odd `n` the real crossover is a different number: `Θₙ² ≥ 3/2` is
`n² - 13n + 18 ≥ 0`, whose root is `(13 + √97)/2 = 11.4244…`. The integer
threshold `12` survives at both parities.
-/

theorem odd_crossover_root :
    ((13 + Real.sqrt 97) / 2) ^ 2 - 13 * ((13 + Real.sqrt 97) / 2) + 18 = 0 := by
  have h : Real.sqrt 97 ^ 2 = 97 := Real.sq_sqrt (by norm_num)
  nlinarith [h]

theorem odd_threshold_neg {n : ℤ} (h4 : 4 ≤ n) (h11 : n ≤ 11) : n ^ 2 - 13 * n + 18 < 0 := by
  nlinarith [mul_nonneg (by linarith : (0:ℤ) ≤ n - 4) (by linarith : (0:ℤ) ≤ 11 - n)]

theorem odd_threshold_pos {n : ℤ} (h : 12 ≤ n) : 0 < n ^ 2 - 13 * n + 18 := by
  nlinarith [mul_nonneg (by linarith : (0:ℤ) ≤ n) (by linarith : (0:ℤ) ≤ n - 12)]

/-- The odd identity, the companion of `theta0Sq_sub_three_halves`. The constant is
`ThetaOddSq` of [L18.lean](L18.lean), carried over `ℝ` here because L2's crossover
facts live over `ℝ`. -/
theorem thetaOddSq_sub_three_halves {n : ℝ} (hn2 : n ≠ 2) (hn1 : n ≠ -1) :
    2 * (n - 1) * (n - 3) / ((n - 2) * (n + 1)) - 3 / 2
      = (n ^ 2 - 13 * n + 18) / (2 * ((n - 2) * (n + 1))) := by
  have h2 : n - 2 ≠ 0 := sub_ne_zero.mpr hn2
  have h1 : n + 1 ≠ 0 := by
    intro h; exact hn1 (by linarith)
  field_simp
  ring

/-- The odd constant is the near-balanced case `p = (n-1)/2`, `q = (n+1)/2` of the
sphere-product formula, the odd counterpart of `sphereProductSq_balanced`. -/
theorem sphereProductSq_odd_balanced {n : ℝ} (hn2 : n ≠ 2) (hn1 : n ≠ -1) (hn : n ≠ 1) :
    sphereProductSq n ((n - 1) / 2) ((n + 1) / 2)
      = 2 * (n - 1) * (n - 3) / ((n - 2) * (n + 1)) := by
  unfold sphereProductSq
  have h2 : n - 2 ≠ 0 := sub_ne_zero.mpr hn2
  have h1 : n + 1 ≠ 0 := by intro h; exact hn1 (by linarith)
  have hm : n - 1 ≠ 0 := sub_ne_zero.mpr hn
  field_simp
  ring

/-!
### Why the maximum over splits is the near-balanced one

The step the threshold rests on and the block states in one clause: the split-dependent
factor is `1 - (n-1)/(pq)`, so it is governed by `pq` alone and rises with it.
-/

/-- `(p-1)(q-1)/(pq) = 1 - (n-1)/(pq)` whenever `p + q = n`. -/
theorem best_split_form {n p q : ℝ} (hp : p ≠ 0) (hq : q ≠ 0) (hpq : p + q = n) :
    (p - 1) * (q - 1) / (p * q) = 1 - (n - 1) / (p * q) := by
  subst hpq
  field_simp
  ring

/-- That factor is monotone in `pq`, so the largest product wins. -/
theorem best_split_mono {a b c : ℝ} (ha : 0 < a) (hab : a ≤ b) (hc : 0 ≤ c) :
    1 - c / a ≤ 1 - c / b := by
  have hb : 0 < b := lt_of_lt_of_le ha hab
  gcongr

/-!
### The cutoff is `12` at both parities, and the reason is a gap containing no integer

Both real roots lie strictly inside `(11, 12)`, so neither is an integer and no integer
separates them. Each bound is an exact rational comparison after squaring.
-/

/-- Both crossover roots lie strictly between `11` and `12`. -/
theorem roots_strictly_between_eleven_and_twelve :
    (11:ℝ) < 6 + 2 * Real.sqrt 7 ∧ 6 + 2 * Real.sqrt 7 < 12 ∧
    (11:ℝ) < (13 + Real.sqrt 97) / 2 ∧ (13 + Real.sqrt 97) / 2 < 12 := by
  have h7 : Real.sqrt 7 ^ 2 = 7 := Real.sq_sqrt (by norm_num)
  have h7n : 0 ≤ Real.sqrt 7 := Real.sqrt_nonneg 7
  have h97 : Real.sqrt 97 ^ 2 = 97 := Real.sq_sqrt (by norm_num)
  have h97n : 0 ≤ Real.sqrt 97 := Real.sqrt_nonneg 97
  refine ⟨by nlinarith, by nlinarith, by nlinarith, by nlinarith⟩

/-- **No integer lies between the two roots**, which is why one cutoff serves both
parities. -/
theorem no_integer_between_roots {m : ℤ}
    (h1 : (6 + 2 * Real.sqrt 7 : ℝ) < (m : ℝ))
    (h2 : ((m : ℝ)) < (13 + Real.sqrt 97) / 2) : False := by
  obtain ⟨ha, _, _, hd⟩ := roots_strictly_between_eleven_and_twelve
  have hlo : (11:ℝ) < (m : ℝ) := lt_trans ha h1
  have hhi : ((m : ℝ)) < 12 := lt_trans h2 hd
  have hlo' : (11:ℤ) < m := by exact_mod_cast hlo
  have hhi' : m < (12:ℤ) := by exact_mod_cast hhi
  omega

/-- The deciding integers on the odd side, exactly. `Θ45²` is `40/27` at `n = 11`,
short of `3/2` by `1/54`; at `n = 13` it is `120/77`, over by `9/154`. -/
theorem theta_odd_eleven_sq : 2 * (11 - 1 : ℚ) * (11 - 3) / ((11 - 2) * (11 + 1)) = 40 / 27 := by
  norm_num

theorem theta_odd_eleven_excess : (40 / 27 : ℚ) - 3 / 2 = -(1 / 54) := by norm_num

theorem theta_odd_thirteen_sq : 2 * (13 - 1 : ℚ) * (13 - 3) / ((13 - 2) * (13 + 1)) = 120 / 77 := by
  norm_num

theorem theta_odd_thirteen_excess : (120 / 77 : ℚ) - 3 / 2 = 9 / 154 := by norm_num

/-- The odd numerator at the two deciding integers. -/
theorem odd_threshold_at_eleven : (11:ℤ) ^ 2 - 13 * 11 + 18 = -4 := by norm_num

theorem odd_threshold_at_thirteen : (13:ℤ) ^ 2 - 13 * 13 + 18 = 18 := by norm_num

end HamiltonsCubic.L2
