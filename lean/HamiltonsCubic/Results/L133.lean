import HamiltonsCubic.Results.Theta0

/-!
# L133's threshold comparison, and its margin

[L133](../../../results.md) gives the balanced orbit's stability threshold in closed
form and compares it with the record's `κₙ`:

  `κₙ^Hess = (27/2) θ₀(n) (2/(n-2) - 1/2) ≤ κₙ = 9(√(3/2) - θ₀(n))`,

*"strictly for every `n ≥ 12`, the comparison reducing to
`θ₀(n)(3/(n-2) + 1/4) ≤ √(3/2)`"*.

**The reduction is exact**, and the reduced inequality has a large margin: `θ₀(n)² < 2`
always, and `(3/(n-2) + 1/4)² ≤ (11/20)²` from `n = 12` on, so the product is below
`2·(121/400) = 121/200`, against `3/2`. **A factor of nearly `2.5`**, where the statement
says only *"strictly"*.

**And both constants are negative at every `n ≥ 12`**, which the statement does not say:
`2/(n-2) - 1/2 < 0` for `n > 6`, and `√(3/2) - θ₀(n) < 0` above the crossover. The
comparison is between two negative numbers.

Everything is `ring`, `norm_num` or `nlinarith`, kernel-checked.
-/

namespace HamiltonsCubic.L133

open HamiltonsCubic.Theta0

/-! ## The reduction is exact -/

/-- Dividing by `9` and collecting `θ₀` turns the stated comparison into the reduced one:
`(3/2)t(2/(n-2) - 1/2) ≤ s - t` is `3t/(n-2) + t/4 ≤ s`. -/
theorem reduction (t s d : ℚ) :
    (3 / 2) * t * (2 / d - 1 / 2) - (s - t) = 3 * t / d + t / 4 - s := by
  ring

/-! ## Both constants are negative from `n = 12` -/

/-- `2/(n-2) - 1/2 < 0` for `n > 6`, so `κ^Hess` is negative. -/
theorem hess_factor_neg {n : ℚ} (hn : 12 ≤ n) : 2 / (n - 2) - 1 / 2 < 0 := by
  have h : 0 < n - 2 := by linarith
  rw [sub_neg, div_lt_iff₀ h]
  linarith

/-- `√(3/2) - θ₀(n) < 0` above the crossover, in squared form: `3/2 < θ₀(n)²` at
`n = 12`. -/
theorem kappa_neg_at_12 : 3 / 2 < evenSq 12 := by norm_num [evenSq]

/-! ## The reduced inequality, with its margin -/

/-- The second factor is at most `11/20` from `n = 12` on. -/
theorem factor_bound {n : ℚ} (hn : 12 ≤ n) : 3 / (n - 2) + 1 / 4 ≤ 11 / 20 := by
  have h : 0 < n - 2 := by linarith
  have : 3 / (n - 2) ≤ 3 / 10 := by
    rw [div_le_div_iff₀ h (by norm_num)]
    linarith
  linarith

/-- And `θ₀(n)² < 2` at every `n`, which is the `√2` ceiling. -/
theorem theta0_bound {n : ℚ} (hn : 4 ≤ n) : evenSq n < 2 := evenSq_lt_two hn

/-- **So the reduced inequality holds with room**: the product's square is at most
`2 · (11/20)² = 121/200`, against `3/2`. -/
theorem reduced_holds : (2 : ℚ) * (11 / 20) ^ 2 < 3 / 2 := by norm_num

/-- The margin is a factor of `2.47`. -/
theorem margin : (2.47 : ℚ) * (2 * (11 / 20) ^ 2) < 3 / 2 := by norm_num

/-! ## At `n = 12`, exactly -/

/-- `θ₀(12)² = 55/36`, the second factor is `11/20`, and the product's square is
`55·121/(36·400) = 6655/14400`. -/
theorem at_12_factor : 3 / ((12 : ℚ) - 2) + 1 / 4 = 11 / 20 := by norm_num

theorem at_12_product : evenSq 12 * (11 / 20) ^ 2 = 6655 / 14400 := by
  norm_num [evenSq]

/-- **Which is below `3/2` by a factor over three.** -/
theorem at_12_clears : (3 : ℚ) * (6655 / 14400) < 3 / 2 := by norm_num

/-! ## What this settles

**Settled**: that the stated reduction is an exact rearrangement; that both constants are
negative at every `n ≥ 12`, so the comparison is between two negatives, which the
statement does not say; and that the reduced inequality holds **with a factor of nearly
`2.5` in general and over `3` at `n = 12`**, where the record says only *"strictly"*.

**Not claimed**: the closed form for `κₙ^Hess`, the attainment on L26's direction, or the
identification of the maximiser set, all the record's.
-/

end HamiltonsCubic.L133
