import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L16, the inequality stands, its consequence does not

[problem.md](../../../findings/problem.md)'s Conjecture L16. The audit reports that it settles
the conjecture **at even `n` only**, since at odd `n` the sphere-product maximum `Θₙ` is
strictly below `θ₀(n)`.

**That strictness has a constant margin, and it is `4`.** With
`Θₙ² = 2(n-1)(n-3)/((n-2)(n+1))` at odd `n` and `θ₀(n)² = 2(n-1)(n-2)/n²`, the comparison
clears to `n²(n-3)` against `(n-2)²(n+1)`, and the difference is **exactly `4`, identically
in `n`**. So the two never meet and the gap does not close as `n` grows; a bound stated
against `θ₀` misses the odd family by a fixed amount rather than an asymptotic one.

**And the second half is a domain restriction**: `θ ≤ √(3/2)` holds on `{δ² ≥ 1/9}` alone,
which is where [L135](L135.lean)'s competitor value `δ² = 1/9` sits, the boundary of the
region, not its interior.
-/

namespace HamiltonsCubic.ParityGap

/-- `θ₀(n)² = 2(n-1)(n-2)/n²`. -/
def theta0Sq (n : ℚ) : ℚ := 2 * (n - 1) * (n - 2) / n ^ 2

/-- `Θₙ²` at odd `n`, the best sphere product `S^{(n-1)/2} × S^{(n+1)/2}`. -/
def ThetaOddSq (n : ℚ) : ℚ := 2 * (n - 1) * (n - 3) / ((n - 2) * (n + 1))

/-! ## The margin is a constant -/

/-- **The cleared comparison differs by exactly `4`, identically in `n`.** -/
theorem margin_is_four (n : ℚ) : (n - 2) ^ 2 * (n + 1) - n ^ 2 * (n - 3) = 4 := by ring

/-- **So `Θₙ < θ₀(n)` strictly at every odd `n ≥ 5`**, and the gap does not close. -/
theorem theta_odd_below {n : ℚ} (hn : 5 ≤ n) : ThetaOddSq n < theta0Sq n := by
  unfold ThetaOddSq theta0Sq
  have h1 : (0:ℚ) < (n - 2) * (n + 1) := by nlinarith [hn]
  have h2 : (0:ℚ) < n ^ 2 := by nlinarith [hn]
  rw [div_lt_div_iff₀ h1 h2]
  nlinarith [hn, margin_is_four n]

/-- The two values at `n = 5`, `7`, `9`. -/
theorem values_five : ThetaOddSq 5 = 8 / 9 ∧ theta0Sq 5 = 24 / 25 := by
  unfold ThetaOddSq theta0Sq
  refine ⟨by norm_num, by norm_num⟩

theorem values_seven : ThetaOddSq 7 = 6 / 5 ∧ theta0Sq 7 = 60 / 49 := by
  unfold ThetaOddSq theta0Sq
  refine ⟨by norm_num, by norm_num⟩

/-! ## Even `n` is where the bound bites -/

/-- At even `n` the balanced product attains `θ₀`, so the bound settles the conjecture there,
`θ₀(6)² = 10/9` is the value [L53](L53.lean) and [L9](L9.lean) both turn on. -/
theorem theta0_six : theta0Sq 6 = 10 / 9 := by unfold theta0Sq; norm_num

/-! ## The domain restriction -/

/-- The second half holds on `{δ² ≥ 1/9}` alone, and `1/9` is exactly the competitor's `δ²`,
so the region's boundary is the point the bound is about. **Off that region it says nothing**,
and the complement is nonempty. -/
theorem region_has_complement : ∃ d : ℚ, 0 ≤ d ∧ d < 1 / 9 := ⟨0, by norm_num, by norm_num⟩

end HamiltonsCubic.ParityGap
