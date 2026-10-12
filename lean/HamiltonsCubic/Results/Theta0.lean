import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Linarith.Frontend
import Mathlib.Tactic.Positivity

/-!
# The diagonal maximum's exact values, where the record prints decimals

[conventions.md](../../../findings/conventions.md) gives `Θₙ` in closed form,
`θ₀(n)` at even `n`, and `√(2(n-1)(n-3)/((n+1)(n-2)))` at odd `n`, and
[target.md](../../../findings/target.md) records `2(n-1)(n-2)/n²` for the balanced
pair. The same file then tabulates the values as six decimals to six places.

**Every one of the six is an exact algebraic number**, and this file says which. The
squares are rational, so they are stated as rationals and no root is taken: `Θₙ² = q`
determines `Θₙ` as the nonnegative root, and the decimal is what a reader gets from
that, not the other way round.

One of them is not irrational at all: **`Θ₁₀ = 6/5`, exactly.**

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.Theta0

/-- `θ₀(n)² = 2(n-1)(n-2)/n²`, the balanced even case. -/
def evenSq (n : ℚ) : ℚ := 2 * (n - 1) * (n - 2) / n ^ 2

/-- `Θₙ² = 2(n-1)(n-3)/((n+1)(n-2))`, the odd case, where the best sphere product is
the unbalanced one. -/
def oddSq (n : ℚ) : ℚ := 2 * (n - 1) * (n - 3) / ((n + 1) * (n - 2))

/-! ## The six tabulated values, exactly

The record's row reads `1.054093, 1.095445, 1.145644, 1.171080, 1.200000, 1.236033`
for `S³×S³, S³×S⁴, S⁴×S⁴, S⁴×S⁵, S⁵×S⁵, S⁶×S⁶`, that is `n = 6, 7, 8, 9, 10, 12`.
-/

theorem at_6  : evenSq 6  = 10 / 9    := by norm_num [evenSq]
theorem at_7  : oddSq  7  = 6 / 5     := by norm_num [oddSq]
theorem at_8  : evenSq 8  = 21 / 16   := by norm_num [evenSq]
theorem at_9  : oddSq  9  = 48 / 35   := by norm_num [oddSq]
theorem at_10 : evenSq 10 = 36 / 25   := by norm_num [evenSq]
theorem at_12 : evenSq 12 = 55 / 36   := by norm_num [evenSq]

/-- **`Θ₁₀ = 6/5` exactly**, the one tabulated value that is rational, and the record
prints it as `1.200000`, which is the only entry a reader could mistake for a rounding
that happens to be short. -/
theorem ten_is_rational : evenSq 10 = (6 / 5 : ℚ) ^ 2 := by norm_num [evenSq]

/-- `Θ₈² = 21/16`, so `Θ₈ = √21 / 4`; the record's `1.145644` is that root. -/
theorem eight_form : evenSq 8 = 21 / 4 ^ 2 := by norm_num [evenSq]

/-- `Θ₁₂² = 55/36`, so `Θ₁₂ = √55 / 6`. -/
theorem twelve_form : evenSq 12 = 55 / 6 ^ 2 := by norm_num [evenSq]

/-! ## Two structural facts the closed forms carry -/

/-- **The even form is increasing in `n`**, which is what makes the tabulated column
monotone. Stated as the cross-multiplied inequality so no division is compared. -/
theorem evenSq_mono {m n : ℚ} (hm : 4 ≤ m) (hmn : m < n) :
    2 * (m - 1) * (m - 2) * n ^ 2 < 2 * (n - 1) * (n - 2) * m ^ 2 := by
  have key : 2 * (n - 1) * (n - 2) * m ^ 2 - 2 * (m - 1) * (m - 2) * n ^ 2
      = 2 * (n - m) * (3 * m * n - 2 * (n + m)) := by ring
  have h1 : 0 < n - m := by linarith
  have hn : (0 : ℚ) < n := by linarith
  have h4 : 0 ≤ (m - 4) * n := mul_nonneg (by linarith) hn.le
  have hexp : (m - 4) * n = m * n - 4 * n := by ring
  rw [hexp] at h4
  have h2 : 0 < 3 * m * n - 2 * (n + m) := by linarith
  have key2 : 2 * (n - m) * (3 * m * n - 2 * (n + m))
      = 2 * ((n - m) * (3 * m * n - 2 * (n + m))) := by ring
  linarith [mul_pos h1 h2]

/-- **The even form is bounded by `2`, strictly**, at every `n`, the `√2` ceiling the
record quotes as the limit. `2(n-1)(n-2) < 2n²` reduces to `3n > 2`. -/
theorem evenSq_lt_two {n : ℚ} (hn : 4 ≤ n) : evenSq n < 2 := by
  rw [evenSq, div_lt_iff₀ (by positivity)]
  have h : 0 ≤ n - 4 := by linarith
  nlinarith [mul_nonneg h h]

/-! ## What this settles

**Settled**: that the six tabulated decimals are six exact rationals under the square,
and which rationals; that one of them, `n = 10`, is rational unsquared; and that the
even form is increasing and stays below `2`.

**Not settled here**: that these closed forms are the values of `Θₙ`, that is the
record's geometry, and this file takes both formulas as given, exactly as
[conventions.md](../../../findings/conventions.md) states them. What is checked is
the arithmetic the record left as decimals.
-/

end HamiltonsCubic.Theta0
