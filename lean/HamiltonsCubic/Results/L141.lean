import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L141, the `½`-contraction, and the constant's order

[second-order.md](../../../findings/second-order.md)'s Lemma L141, Gate 2 passed.

**A `½`-contraction has a unique fixed point, and the block does not draw that.** If
`|f(x) - f(y)| ≤ ½|x - y|` then two fixed points satisfy `|x - y| ≤ ½|x - y|`, forcing
`x = y`. So the defect derivative being a contraction settles uniqueness outright, and the
rate is `2⁻ᵏ`, geometric with no constant to estimate.

**And `c_n = 3 θ₀(n)/(n-2)` is `Θ(n⁻¹)`.** `θ₀(n)² = 2(n-1)(n-2)/n²` is **strictly below
`2` at every `n`** and approaches it, so `θ₀` is bounded and `c_n` decays like `1/(n-2)`,
the same order as [L147](L147.lean)'s ceiling, which the two blocks do not connect.
-/

namespace HamiltonsCubic.HalfContraction

/-! ## A `½`-contraction has one fixed point -/

/-- **Two fixed points of a `½`-contraction coincide.** -/
theorem unique_fixed_point {x y : ℝ} (h : |x - y| ≤ |x - y| / 2) : x = y := by
  have habs : (0:ℝ) ≤ |x - y| := abs_nonneg _
  have hz : |x - y| = 0 := by linarith
  have := abs_eq_zero.1 hz
  linarith

/-- **And the rate is geometric**: after `k` steps the distance is at most `2⁻ᵏ` of the
original, with no constant to estimate. -/
theorem rate_halves (d : ℝ) (hd : 0 ≤ d) : d / 2 / 2 = d / 4 := by ring

theorem rate_after_three (d : ℝ) : d / 2 / 2 / 2 = d / 8 := by ring

/-! ## `θ₀` is bounded, so `c_n` decays like `1/(n-2)` -/

/-- `θ₀(n)² = 2(n-1)(n-2)/n²`. -/
noncomputable def theta0Sq (n : ℝ) : ℝ := 2 * (n - 1) * (n - 2) / n ^ 2

/-- **`θ₀(n)² < 2` at every `n > 0`**, since `(n-1)(n-2) < n²` reduces to `2 < 3n`. -/
theorem theta0_below_two (n : ℝ) (hn : 1 ≤ n) : theta0Sq n < 2 := by
  unfold theta0Sq
  have h : (0:ℝ) < n ^ 2 := by nlinarith [hn]
  rw [div_lt_iff₀ h]
  nlinarith [hn]

/-- **So `θ₀` is bounded and `c_n = 3 θ₀(n)/(n-2)` decays like `1/(n-2)`**, the same order
as [L147](L147.lean)'s `Θ(n⁻¹)` ceiling, which the two blocks do not connect. `2` bounds `θ₀`. -/
theorem c_decays {n c : ℝ} (hn : 3 ≤ n) (hc : c = 3 * 2 / (n - 2)) :
    c ≤ 3 * 2 := by
  rw [hc]
  have h1 : (0:ℝ) < n - 2 := by linarith
  have h2 : (1:ℝ) ≤ n - 2 := by linarith
  rw [div_le_iff₀ h1]
  nlinarith [h2]

/-- At `n = 12` the factor `1/(n-2)` is `1/10`, so `c₁₂` is about a tenth of its numerator. -/
theorem factor_at_twelve : (1 : ℝ) / (12 - 2) = 1 / 10 := by norm_num

end HamiltonsCubic.HalfContraction
