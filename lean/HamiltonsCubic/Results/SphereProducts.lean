import Mathlib.Tactic.FieldSimp
import HamiltonsCubic.Results.Theta0

/-!
# The two-block sphere products, exactly

[target.md](../../../findings/target.md) records the closed form, derived independently
by two reviewers:

  `θ²(Sᵖ × S^q) = 2(p-1)(q-1)(n-1) / (p q (n-2))`,  `n = p + q`.

With it, several claims the record states as decimals become exact rationals, and one
of them refutes a target, so the difference between a decimal and a rational is the
difference between a numerical observation and a counterexample.

**This file also discharges an assumption made in
[Theta0.lean](HamiltonsCubic/Results/Theta0.lean)**: that the balanced value is
`2(n-1)(n-2)/n²`. That is this formula at `p = q = n/2`, proved below rather than taken
from [conventions.md](../../../findings/conventions.md).

Everything is `norm_num` or `field_simp`/`ring`, kernel-checked.
-/

namespace HamiltonsCubic.SphereProducts

/-- `θ²(Sᵖ × S^q)`, with `n = p + q`. -/
def thetaSq (p q : ℚ) : ℚ := 2 * (p - 1) * (q - 1) * (p + q - 1) / (p * q * (p + q - 2))

/-! ## The balanced case is the even closed form -/

/-- **`θ²` at the balanced product is `(m-1)(2m-1)/m²`**, stated cross-multiplied so
no division and no side condition enters, the quotient form follows wherever the
denominator is nonzero, which is every `m ≥ 2`. -/
theorem balanced (m : ℚ) :
    2 * (m - 1) * (m - 1) * (m + m - 1) * m ^ 2
      = ((m - 1) * (2 * m - 1)) * (m * m * (m + m - 2)) := by
  ring

/-- The same, written at `n = 2m`: cross-multiplied, the closed form at the balanced
product **is** the even form `2(n-1)(n-2)/n²` that
[Theta0.lean](HamiltonsCubic/Results/Theta0.lean) took from the conventions file. So
that import is discharged. -/
theorem balanced_evenSq (m : ℚ) :
    2 * (m - 1) * (m - 1) * (m + m - 1) * (2 * m) ^ 2
      = (2 * (2 * m - 1) * (2 * m - 2)) * (m * m * (m + m - 2)) := by
  ring

theorem balanced_6 : thetaSq 3 3 = 10 / 9  := by norm_num [thetaSq]
theorem balanced_8 : thetaSq 4 4 = 21 / 16 := by norm_num [thetaSq]
theorem balanced_10 : thetaSq 5 5 = 36 / 25 := by norm_num [thetaSq]
theorem balanced_12 : thetaSq 6 6 = 55 / 36 := by norm_num [thetaSq]

/-- The unbalanced odd-`n` entries of the same table. -/
theorem unbalanced_7 : thetaSq 3 4 = 6 / 5   := by norm_num [thetaSq]
theorem unbalanced_9 : thetaSq 4 5 = 48 / 35 := by norm_num [thetaSq]

/-! ## The target's falsifier at `n = 12`

The record writes `θ = 1.228239158 > √(3/2)` in the headline and gives `θ² = 264/175`
and the excess `3/350` one clause later. **The headline is a comparison of decimals and
the clause is a theorem**; only the second refutes anything.
-/

/-- `θ²(S⁵ × S⁷) = 264/175`. -/
theorem s5_s7 : thetaSq 5 7 = 264 / 175 := by norm_num [thetaSq]

/-- **It exceeds `3/2`, and the excess is exactly `3/350`.** -/
theorem s5_s7_excess : thetaSq 5 7 - 3 / 2 = 3 / 350 := by norm_num [thetaSq]

theorem s5_s7_gt : (3 : ℚ) / 2 < thetaSq 5 7 := by norm_num [thetaSq]

/-- The balanced point at the same dimension is higher still, `55/36`, so the target
fails at `n = 12` by two points rather than one. -/
theorem s6_s6_gt : (3 : ℚ) / 2 < thetaSq 6 6 := by norm_num [thetaSq]

/-! ## The band's maximum at `n ≤ 24` -/

/-- `θ²(S¹¹ × S¹³) = 2760/1573`, the record's `1.324617` at `n = 24`. -/
theorem s11_s13 : thetaSq 11 13 = 2760 / 1573 := by norm_num [thetaSq]

/-- **It is above `3/2` by more than `8%` in `θ`**, which is the record's *"above the
recorded ceiling by 8.2%, not 3.2% below it"*. Squared, the claim is
`θ²/(3/2) > 1.08² = 1.1664`. -/
theorem s11_s13_ratio : (1.1664 : ℚ) < thetaSq 11 13 / (3 / 2) := by
  norm_num [thetaSq]

/-- And it is below `9%`, so the record's `8.2%` is the right figure to one place. -/
theorem s11_s13_ratio_upper : thetaSq 11 13 / (3 / 2) < (1.1881 : ℚ) := by
  norm_num [thetaSq]

/-! ## What this settles

**Settled**: the closed form's specialisations at every point the record tabulates or
cites; that the balanced case is the even formula, so
[Theta0.lean](HamiltonsCubic/Results/Theta0.lean)'s import is discharged; and that the
`n = 12` falsifier is exact, with the excess `3/350` rather than a decimal comparison.

**Not settled here**: the closed form itself. Two reviewers derived it independently and
the record carries it; this file takes it as stated and computes with it.
-/

end HamiltonsCubic.SphereProducts
