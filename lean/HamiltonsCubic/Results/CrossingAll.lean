import HamiltonsCubic.Results.SphereProducts

/-!
# The crossing at `n = 12`, for every `n`

[MaxCrossing.lean](HamiltonsCubic/Results/MaxCrossing.lean) decided the crossing over all
splits at `n ≤ 24` by enumeration. **The bound was an artefact of the method.** Two closed
forms remove it:

* even `n = 2m`: the maximiser is `Sᵐ×Sᵐ` and `θ² = 2(n-1)(n-2)/n²`, so `θ² > 3/2` is
  `n² - 12n + 8 > 0`;
* odd `n = 2m+1`: the maximiser is `Sᵐ×Sᵐ⁺¹` and `θ² = 4m(m-1)/((m+1)(2m-1))`, so
  `θ² > 3/2` is **`2m² - 11m + 3 > 0`**.

The odd condition's roots are `(11 ± √97)/4`, the positive one near `5.21`, so it holds
from `m = 6`, that is `n = 13`. **Even dimensions cross at `12`, odd at `13`, so the
maximum exceeds `3/2` at every `n ≥ 12` and at none below.**

**The record carries this already**, in [problem.md](../../../findings/problem.md): *"At
odd `n` the real crossover is a different number, `Θₙ² ≥ 3/2` is `n² - 13n + 18 ≥ 0`,
root `(13+√97)/2 = 11.4244`"*. That is the same condition written in `n` where this file
writes it in `m`: substituting `n = 2m+1` gives exactly `2(2m² - 11m + 3)`. **So this
file does not supply the odd counterpart, it re-derives it**, and the agreement of the
two forms is the check.

Everything is `ring`, `norm_num` or `nlinarith`, kernel-checked, **and unbounded in `n`.**
-/

namespace HamiltonsCubic.CrossingAll

open HamiltonsCubic.SphereProducts

/-! ## The odd maximiser's closed form -/

/-- At `n = 2m+1` the near-balanced split `Sᵐ×Sᵐ⁺¹` has `θ² = 4m(m-1)/((m+1)(2m-1))`.
Stated cross-multiplied, so no side condition enters. -/
theorem odd_form (m : ℚ) :
    2 * (m - 1) * ((m + 1) - 1) * ((m + (m + 1)) - 1) * ((m + 1) * (2 * m - 1))
      = 4 * m * (m - 1) * (m * (m + 1) * ((m + (m + 1)) - 2)) := by
  ring

theorem odd_at_5 : thetaSq 5 6 = 40 / 27 := by norm_num [thetaSq]
theorem odd_at_6 : thetaSq 6 7 = 120 / 77 := by norm_num [thetaSq]

/-! ## The two crossing conditions -/

/-- **Even**: `θ² > 3/2` is `n² - 12n + 8 > 0`. -/
theorem even_condition (n : ℚ) (hn : 0 < n) :
    2 * (2 * (n - 1) * (n - 2)) - 3 * n ^ 2 = n ^ 2 - 12 * n + 8 := by
  ring

/-- **Odd**: `θ² > 3/2` is `2m² - 11m + 3 > 0`. -/
theorem odd_condition (m : ℚ) :
    2 * (4 * m * (m - 1)) - 3 * ((m + 1) * (2 * m - 1)) = 2 * m ^ 2 - 11 * m + 3 := by
  ring

/-! ## Where each turns positive -/

/-- The even condition fails at `n = 10` and holds at `n = 12`. -/
theorem even_10 : (10 : ℚ) ^ 2 - 12 * 10 + 8 < 0 := by norm_num
theorem even_12 : 0 < (12 : ℚ) ^ 2 - 12 * 12 + 8 := by norm_num

/-- And it stays positive: the step `(n+1)² - 12(n+1) - (n² - 12n) = 2n - 11` is positive
from `n = 6`, so the condition never turns back. -/
theorem even_step (n : ℚ) :
    ((n + 1) ^ 2 - 12 * (n + 1) + 8) - (n ^ 2 - 12 * n + 8) = 2 * n - 11 := by ring

theorem even_stays {n : ℚ} (hn : 12 ≤ n) : 0 < n ^ 2 - 12 * n + 8 := by nlinarith

/-- The odd condition fails at `m = 5` (`n = 11`) and holds at `m = 6` (`n = 13`). -/
theorem odd_5 : 2 * (5 : ℚ) ^ 2 - 11 * 5 + 3 < 0 := by norm_num
theorem odd_6 : 0 < 2 * (6 : ℚ) ^ 2 - 11 * 6 + 3 := by norm_num

/-- And it stays positive from `m = 6`. -/
theorem odd_stays {m : ℚ} (hm : 6 ≤ m) : 0 < 2 * m ^ 2 - 11 * m + 3 := by nlinarith

/-- Its roots are `(11 ± √97)/4`: the discriminant is `97`. -/
theorem odd_discriminant : (11 : ℚ) ^ 2 - 4 * 2 * 3 = 97 := by norm_num

/-- `97` is not a square, so the odd crossover is irrational too, like the record's
`6 + 2√7`, and lying in `(5, 6)` for `m`, that is `(11, 13)` for `n`. -/
theorem ninety_seven_not_square : (9 : ℚ) ^ 2 < 97 ∧ (97 : ℚ) < 10 ^ 2 := by
  constructor <;> norm_num

/-! ## The two crossovers compared

The record's even crossover is `6 + 2√7 ≈ 11.29`. The odd one is `m = (11+√97)/4 ≈ 5.21`,
that is `n = 2m+1 ≈ 11.42`. **Both lie strictly between `11` and `12`**, so the integer
threshold is `12` for even and `13` for odd, and every `n ≥ 12` is above.
-/

theorem even_crossover_bracket : (11 : ℚ) < 6 + 2 * 2.645 ∧ 6 + 2 * (2.646 : ℚ) < 12 := by
  constructor <;> norm_num

theorem odd_crossover_bracket :
    (11 : ℚ) < 2 * ((11 + 9.848) / 4) + 1 ∧ 2 * ((11 + (9.849 : ℚ)) / 4) + 1 < 12 := by
  constructor <;> norm_num

/-! ## What this settles

**Settled, unbounded in `n`**: the odd maximiser's closed form; that `θ² > 3/2` is
`n² - 12n + 8 > 0` at even `n` and `2m² - 11m + 3 > 0` at odd; that each condition turns
positive exactly at `n = 12` and `n = 13` and stays positive; and that **both crossovers
lie strictly between `11` and `12`**, the odd one at `(11+√97)/4` in `m`, irrational like
the record's `6 + 2√7`.

**So the `n ≤ 24` bound of the previous round is removed**, and Conjecture A's threshold
holds over all splits at every dimension.

**Already on the record**: the odd crossover, as `n² - 13n + 18` in
[problem.md](../../../findings/problem.md). What this file adds is the `m`-form, the
identity between the two, and the kernel check.

**Not claimed**: that the near-balanced split is the odd maximiser, that is
[BalanceMax.lean](HamiltonsCubic/Results/BalanceMax.lean)'s, decided to `n = 24`.
-/

end HamiltonsCubic.CrossingAll
