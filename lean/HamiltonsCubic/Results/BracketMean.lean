import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp

/-!
# The bracket mean is `4/(n+1)`, and the cap it is measured against is `2`

[stratum-two-negative.md](../../../findings/stratum-two-negative.md) gives the mean of
`‖[v_α,v_β]‖²` as `2(n-2)/(N-1)` and then lists it as `0.571`, `0.444`, `0.364`, `0.308` at
`n = 6, 8, 10, 12`.

**The closed form collapses.** With `N = C(n,2)`, `N - 1 = (n-2)(n+1)/2`, so

`2(n-2)/(N-1) = 4(n-2)/((n-2)(n+1)) = 4/(n+1)`,

and the four decimals are `4/7`, `4/9`, `4/11`, `4/13`. The `(n-2)` cancels entirely, the mean
does not depend on the factor the numerator carries, which the printed form hides and the
decimals do not reveal.

**The constant it is verified against also has a form.** The values `20`, `42`, `72` at
`n = 6, 8, 10` are `(n-1)(n-2)`.

**And the cap is `2`, which the mean never approaches.** `4/(n+1) < 2` at every `n > 1`, and the
ratio is `2/(n+1)`, so the chain spends a budget of `2` against a mean of `4/13` at `n = 12`, a
factor of `6.5`, widening with `n`. **That the gap grows is the point**: a bound spending the cap
loses more at each dimension, and the block gives the four values without the trend.
-/

namespace HamiltonsCubic.BracketMean

/-! ## The closed form collapses -/

/-- `N - 1 = (n-2)(n+1)/2` with `N = C(n,2)`. -/
theorem N_minus_one (n : ℚ) : n * (n - 1) / 2 - 1 = (n - 2) * (n + 1) / 2 := by ring

/-- **So the mean is `4/(n+1)`**, the `(n-2)` cancelling entirely. -/
theorem mean_collapses (n : ℚ) (h2 : n ≠ 2) (h1 : n + 1 ≠ 0) :
    2 * (n - 2) / (n * (n - 1) / 2 - 1) = 4 / (n + 1) := by
  rw [N_minus_one]
  have hne : n - 2 ≠ 0 := sub_ne_zero.2 h2
  field_simp
  ring

/-! ## The four printed values -/

theorem printed_values :
    (4 : ℚ) / (6 + 1) = 4 / 7 ∧ (4 : ℚ) / (8 + 1) = 4 / 9
      ∧ (4 : ℚ) / (10 + 1) = 4 / 11 ∧ (4 : ℚ) / (12 + 1) = 4 / 13 := by
  refine ⟨by norm_num, by norm_num, by norm_num, by norm_num⟩

theorem decimals_match :
    (570 : ℚ) / 1000 < 4 / 7 ∧ (4 : ℚ) / 7 < 572 / 1000
      ∧ (307 : ℚ) / 1000 < 4 / 13 ∧ (4 : ℚ) / 13 < 309 / 1000 := by
  refine ⟨by norm_num, by norm_num, by norm_num, by norm_num⟩

/-! ## The verified constant -/

/-- **`20`, `42`, `72` are `(n-1)(n-2)`** at `n = 6, 8, 10`. -/
theorem verified_constant :
    (6 - 1 : ℚ) * (6 - 2) = 20 ∧ (8 - 1 : ℚ) * (8 - 2) = 42 ∧ (10 - 1 : ℚ) * (10 - 2) = 72 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-! ## The cap, and the widening gap -/

/-- **The mean is below the cap `2` at every `n > 1`.** -/
theorem below_cap {n : ℚ} (hn : 1 < n) : 4 / (n + 1) < 2 := by
  have hpos : (0:ℚ) < n + 1 := by linarith
  rw [div_lt_iff₀ hpos]
  linarith

/-- **And the ratio to the cap is `2/(n+1)`**, so the gap widens with `n`. -/
theorem cap_ratio (n : ℚ) (h : n + 1 ≠ 0) : (4 / (n + 1)) / 2 = 2 / (n + 1) := by
  field_simp
  ring

/-- At `n = 12` the cap is `6.5` times the mean. -/
theorem factor_at_twelve : (2 : ℚ) / (4 / 13) = 13 / 2 ∧ (13 : ℚ) / 2 = 65 / 10 := by
  refine ⟨by norm_num, by norm_num⟩

/-- And the factor grows: `3.5` at `n = 6` against `6.5` at `n = 12`. -/
theorem factor_grows : (2 : ℚ) / (4 / 7) = 7 / 2 ∧ (7 : ℚ) / 2 < 13 / 2 := by
  refine ⟨by norm_num, by norm_num⟩

end HamiltonsCubic.BracketMean
