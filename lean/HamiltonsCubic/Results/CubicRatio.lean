import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp

/-!
# The cubic ratio, its six percentages, and what it multiplies with

[nondegeneracy.md](../../../findings/nondegeneracy.md)'s boxed identity
`tr(W³)/θ = 2/((n-1)(n-2))` at the balanced product. The closed form is stated; the six
percentages beside it are not checked against it, and one product it enters is not drawn.

**All six percentages are the closed form exactly.** `10%`, `4.76%`, `2.78%`, `1.8182%`,
`0.585%`, `0.021%` at `n = 6, 8, 10, 12, 20, 100` are `1/10`, `1/21`, `1/36`, `1/55`, `1/171`,
`1/4851`, that is, `1/C(n-1,2)`. So the list is the formula and adds nothing to it, which is
worth knowing before anyone reads the values as independent measurements.

**And *"decaying like `2/n²`"* understates what is available.** The exact denominator is
`(n-1)(n-2)`, not `n²`; at `n = 6` the asymptotic form gives `5.6%` against a true `10%`, so the
approximation is out by nearly a factor of two exactly where the record's smallest cases live.

**The ratio and `θ₀(n)²` multiply to `(2/n)²`.** The block notes that *"the same two lines
recover `θ₀(n)² = 2(n-1)(n-2)/n²`"* without drawing the consequence:

`tr(W³)/θ · θ₀(n)² = 2/((n-1)(n-2)) · 2(n-1)(n-2)/n² = 4/n²`,

identically, the two are reciprocal up to `(2/n)²`. At `n = 12` that is `1/55 · 55/36 = 1/36`.
So the cubic ratio is `4/(n²θ₀²)`, and the "unforgiving check" the block describes is this
cancellation.

**The unbalanced splits differ by exact rationals.** At `n = 12` the three recorded values stand
to the balanced `1/55` in ratios `23/12`, `109/21` and `107/8`, the last being the *"factor
13.4"*, which is exactly `107/8`.
-/

namespace HamiltonsCubic.CubicRatio

/-- `tr(W³)/θ = 2/((n-1)(n-2))` at the balanced product. -/
def ratio (n : ℚ) : ℚ := 2 / ((n - 1) * (n - 2))

/-- `θ₀(n)² = 2(n-1)(n-2)/n²`. -/
def theta0Sq (n : ℚ) : ℚ := 2 * (n - 1) * (n - 2) / n ^ 2

/-! ## The six percentages are the formula -/

theorem six_values :
    ratio 6 = 1 / 10 ∧ ratio 8 = 1 / 21 ∧ ratio 10 = 1 / 36
      ∧ ratio 12 = 1 / 55 ∧ ratio 20 = 1 / 171 ∧ ratio 100 = 1 / 4851 := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩ <;> (unfold ratio; norm_num)

/-- The recorded `0.021%` at `n = 100` is `1/4851`, which rounds to it. -/
theorem hundred_rounds :
    (1 : ℚ) / 4851 < 21 / 100000 ∧ (20 : ℚ) / 100000 < 1 / 4851 := by
  constructor <;> norm_num

/-! ## The asymptotic form is loose where the small cases are -/

/-- **At `n = 6` the `2/n²` form gives `1/18` against a true `1/10`**, out by nearly a factor
of two. -/
theorem asymptotic_loose_at_six :
    2 / (6 : ℚ) ^ 2 = 1 / 18 ∧ (1 : ℚ) / 18 < 1 / 10 ∧ (1 : ℚ) / 10 < 2 * (1 / 18) := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-- The exact form exceeds the asymptotic one at every `n ≥ 4`, since `(n-1)(n-2) < n²`. -/
theorem exact_exceeds_asymptotic {n : ℚ} (hn : 4 ≤ n) : 2 / n ^ 2 < ratio n := by
  unfold ratio
  have h1 : (0:ℚ) < (n - 1) * (n - 2) := by nlinarith
  have h2 : (0:ℚ) < n ^ 2 := by nlinarith
  rw [div_lt_div_iff₀ h2 h1]
  nlinarith

/-! ## The product with `θ₀²` is `(2/n)²` -/

/-- **`tr(W³)/θ · θ₀(n)² = 4/n²`, identically.** -/
theorem product_is_four_over_n_sq (n : ℚ) (hn : 4 ≤ n) :
    ratio n * theta0Sq n = 4 / n ^ 2 := by
  unfold ratio theta0Sq
  have h1 : n - 1 ≠ 0 := by intro h; linarith
  have h2 : n - 2 ≠ 0 := by intro h; linarith
  have h0 : n ≠ 0 := by intro h; linarith
  field_simp
  ring

/-- At `n = 12`: `1/55 · 55/36 = 1/36 = (2/12)²`. -/
theorem product_at_twelve :
    ratio 12 * theta0Sq 12 = 1 / 36 ∧ (2 / (12:ℚ)) ^ 2 = 1 / 36 := by
  constructor
  · unfold ratio theta0Sq; norm_num
  · norm_num

/-! ## The unbalanced splits, as exact ratios -/

/-- **The three recorded values stand to the balanced one in exact rationals**, the last being
`107/8`, the *"factor 13.4"*. -/
theorem unbalanced_ratios :
    ((23 : ℚ) / 660) / (1 / 55) = 23 / 12
      ∧ ((109 : ℚ) / 1155) / (1 / 55) = 109 / 21
      ∧ ((107 : ℚ) / 440) / (1 / 55) = 107 / 8 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

theorem factor_is_thirteen_point_four :
    (1337 : ℚ) / 100 < 107 / 8 ∧ (107 : ℚ) / 8 < 1338 / 100 := by
  constructor <;> norm_num

end HamiltonsCubic.CubicRatio
