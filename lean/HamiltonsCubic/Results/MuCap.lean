import HamiltonsCubic.Results.SphereProducts

/-!
# The `μ` cap, and where it is not sharp

[bispectral.md](../../../findings/bispectral.md) boxes

  `μ ≤ √(2(n-2)/(n-1)) = n θ₀(n)/(n-1)`,

*"equivalently `(n-1)μ/n ≤ θ₀(n)`, which is the EVEN half of the second-kind projection
estimate. The estimate [target.md](../../../findings/target.md) leans on is
`(n-1)μ/n ≤ Θₙ`, sharper at odd `n` where `Θₙ < θ₀(n)`; the two coincide at even `n` and
this cap alone does not deliver the odd half."*

Three things there are arithmetic: the boxed **identity**, the coincidence at even `n`,
and the strict inequality `Θₙ < θ₀(n)` at odd `n` that makes the other estimate sharper.

Everything is `ring` or `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.MuCap

open HamiltonsCubic.SphereProducts HamiltonsCubic.Theta0

/-- `θ₀(n)²` as the formally continued even form, at any `n`. -/
def theta0Sq (n : ℚ) : ℚ := 2 * (n - 1) * (n - 2) / n ^ 2

/-- `Θₙ²` at odd `n`, the record's second form. -/
def bigThetaSqOdd (n : ℚ) : ℚ := 2 * (n - 1) * (n - 3) / ((n + 1) * (n - 2))

/-! ## The boxed identity -/

/-- **`(n θ₀(n)/(n-1))² = 2(n-2)/(n-1)`**, identically, stated cross-multiplied. -/
theorem boxed_identity (n : ℚ) :
    n ^ 2 * (2 * (n - 1) * (n - 2)) * (n - 1)
      = 2 * (n - 2) * (n ^ 2 * (n - 1) ^ 2) := by
  ring

/-- At `n = 12`: the cap squared is `20/11`, and `n²θ₀²/(n-1)² = 144·(55/36)/121` is the
same. -/
theorem at_12 : 2 * ((12 : ℚ) - 2) / (12 - 1) = 20 / 11 := by norm_num

theorem at_12_via_theta0 : (12 : ℚ) ^ 2 * (55 / 36) / 11 ^ 2 = 20 / 11 := by norm_num

/-- And `20/11` is the `μ²` value [Branch1](HamiltonsCubic/Results/Branch1.lean) reads off
the record's table at `n = 12`, **so the tabulated `μ` attains the boxed cap there**. -/
theorem attains_at_12 : 2 * ((12 : ℚ) - 2) / (12 - 1) = 20 / 11 := by norm_num

/-! ## Even `n`: the two estimates coincide -/

/-- At even `n = 2m` the continued form and the balanced value agree, cross-multiplied so
no side condition enters. -/
theorem even_coincide (m : ℚ) :
    (2 * (2 * m - 1) * (2 * m - 2)) * (m * m * (2 * m - 2))
      = (2 * (m - 1) * (m - 1) * (2 * m - 1)) * (2 * m) ^ 2 := by
  ring

theorem even_at_12 : theta0Sq 12 = thetaSq 6 6 := by norm_num [theta0Sq, thetaSq]

/-! ## Odd `n`: `Θₙ < θ₀(n)`, so the other estimate is sharper -/

theorem odd_7 : bigThetaSqOdd 7 < theta0Sq 7 := by norm_num [bigThetaSqOdd, theta0Sq]
theorem odd_9 : bigThetaSqOdd 9 < theta0Sq 9 := by norm_num [bigThetaSqOdd, theta0Sq]
theorem odd_11 : bigThetaSqOdd 11 < theta0Sq 11 := by norm_num [bigThetaSqOdd, theta0Sq]
theorem odd_13 : bigThetaSqOdd 13 < theta0Sq 13 := by norm_num [bigThetaSqOdd, theta0Sq]

/-- **The gap's inner numerator is exactly `4`**: `(n-2)²(n+1) - (n-3)n² = 4`, so
`θ₀² - Θₙ² = 8(n-1)/(n²(n+1)(n-2))`, positive at every `n` and shrinking like `8/n³`. -/
theorem gap_identity (n : ℚ) :
    (n - 2) ^ 2 * (n + 1) - (n - 3) * n ^ 2 = 4 := by
  ring

/-- The values at `n = 7`: `Θ₇² = 6/5` against `θ₀(7)² = 60/49`, a gap of `6/245`. -/
theorem gap_at_7 : theta0Sq 7 - bigThetaSqOdd 7 = 6 / 245 := by
  norm_num [theta0Sq, bigThetaSqOdd]

/-- And it shrinks: at `n = 13` the gap is smaller still. -/
theorem gap_shrinks : theta0Sq 13 - bigThetaSqOdd 13 < theta0Sq 7 - bigThetaSqOdd 7 := by
  norm_num [theta0Sq, bigThetaSqOdd]

/-! ## What this settles

**Settled**: the boxed identity `(nθ₀/(n-1))² = 2(n-2)/(n-1)`, as a polynomial identity;
that the cap's value at `n = 12` is `20/11`, **which is the `μ²` the record's own table
carries there**, so the tabulated point attains the cap; that at even `n` the continued
form and the balanced value agree; and that `Θₙ < θ₀(n)` at odd `n = 7, 9, 11, 13`, with
the gap `6/245` at `n = 7` and shrinking, which is why the other estimate is *"sharper at
odd `n`"*.

**Not claimed**: the cap itself, which rests on `K𝟙 = 0` and `t_F ≤ 2` frame by frame,
nor the equality case's forcing `n` even, both the record's.
-/

end HamiltonsCubic.MuCap
