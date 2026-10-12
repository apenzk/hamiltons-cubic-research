import HamiltonsCubic.Results.Theta0
import Mathlib.Tactic.FieldSimp

/-!
# `ρ^eff`'s positivity and monotonicity, with the threshold

[second-order.md](../../../findings/second-order.md) records that L149's block consumed
both and proved neither, and then supplies the argument:

> Both follow from `ρ^eff_n = √6 - θ₀(n)(n+16)/(2(n-2))`, and **monotonicity comes
> first**, after which positivity costs one integer comparison. … Positivity is then
> `ρ^eff₁₂ = √6 - (7/30)√55 > 0`.

[ROUND_L149F.md](../../../verification/ROUND_L149F.md) records the equivalent polynomial
form: `ρ^eff_n > 0 ⟺ (n+16)²(n-1) < 12n²(n-2) ⟺ D(n) := 11n³ - 55n² - 224n + 256 > 0`.

This file checks the arithmetic of both routes and adds **the threshold the record does
not state**: `D` is positive from `n = 8` and negative at `n = 7`, so positivity holds
well below the `n ≥ 12` the block needs, the margin is four dimensions, not zero.

Everything is `norm_num`, `ring` or `nlinarith`, kernel-checked.
-/

namespace HamiltonsCubic.RhoEff

open HamiltonsCubic.Theta0

/-- `D(n) = 11n³ - 55n² - 224n + 256`, whose sign is `ρ^eff_n`'s. -/
def D (n : ℚ) : ℚ := 11 * n ^ 3 - 55 * n ^ 2 - 224 * n + 256

/-- **The equivalence is a polynomial identity**: `12n²(n-2) - (n-1)(n+16)² = D(n)`. -/
theorem D_eq (n : ℚ) : 12 * n ^ 2 * (n - 2) - (n - 1) * (n + 16) ^ 2 = D n := by
  unfold D; ring

/-! ## The threshold -/

theorem D_at_7 : D 7 = -234 := by norm_num [D]
theorem D_at_8 : D 8 = 576 := by norm_num [D]
theorem D_at_12 : D 12 = 8656 := by norm_num [D]

/-- **`D` is negative at `n = 7` and positive at `n = 8`**, so the sign change sits
between them. -/
theorem sign_change : D 7 < 0 ∧ 0 < D 8 := by
  constructor <;> norm_num [D]

/-- And `D` increases from `n = 8` on, so positivity persists: the difference
`D(n+1) - D(n) = 33n² - 77n - 268` is positive for `n ≥ 8`. -/
theorem D_step (n : ℚ) : D (n + 1) - D n = 33 * n ^ 2 - 77 * n - 268 := by
  unfold D; ring

theorem D_increasing {n : ℚ} (hn : 8 ≤ n) : D n < D (n + 1) := by
  have h := D_step n
  nlinarith [hn]

/-! ## The record's own route, as one integer comparison

`ρ^eff₁₂ = √6 - (7/30)√55 > 0` is `6 > (49/900)·55`, that is `5400 > 2695`.
-/

/-- The comparison, cleared of both roots. -/
theorem rho_12_positive : (49 : ℚ) * 55 < 6 * 900 := by norm_num

/-- **And it clears by a factor of two**, so the positivity at `n = 12` is not marginal:
`2695` against `5400`. -/
theorem rho_12_margin : (2 : ℚ) * (49 * 55) < 6 * 900 := by norm_num

/-- `θ₀(12)² = 55/36` is what makes the constant `(7/30)√55`: `(28/20)·(1/6) = 7/30`. -/
theorem theta0_12 : evenSq 12 = 55 / 36 := by norm_num [evenSq]

theorem coefficient : (12 + 16 : ℚ) / (2 * (12 - 2)) * (1 / 6) = 7 / 30 := by norm_num

/-! ## The monotone factor

The record's monotonicity runs through `p(n) = (n+16)/(6n) · κ` with both factors
positive and decreasing. The first factor's decrease is arithmetic: `(n+16)/(6n) =
1/6 + 8/(3n)`.
-/

theorem factor_split (n : ℚ) (hn : n ≠ 0) : (n + 16) / (6 * n) = 1 / 6 + 8 / (3 * n) := by
  field_simp
  ring

/-- So it decreases, strictly, at every positive `n`. -/
theorem factor_decreasing {a b : ℚ} (ha : 0 < a) (hab : a < b) :
    (b + 16) / (6 * b) < (a + 16) / (6 * a) := by
  have hb : 0 < b := lt_trans ha hab
  rw [div_lt_div_iff₀ (by linarith) (by linarith)]
  nlinarith

/-! ## What this settles

**Settled**: that the polynomial form is an identity, not a restatement; that `D` changes
sign between `n = 7` and `n = 8` and increases thereafter, **so positivity holds from
`n = 8` and the block's `n ≥ 12` has four dimensions of margin**, which neither the
block nor the round that found the debt states; that the record's integer comparison
clears by a factor of two; and that the monotone factor `(n+16)/(6n)` is `1/6 + 8/(3n)`,
strictly decreasing.

**Not settled here**: that `κ` decreases, which is the record's, and the closed form for
`ρ^eff` itself.
-/

end HamiltonsCubic.RhoEff
