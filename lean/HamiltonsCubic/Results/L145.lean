import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

/-!
# L145, the tube radius, and two overstatements of order

[second-order.md](../../../findings/second-order.md)'s Lemma L145.

**`Ω` is one-sided and `Θ` is two-sided, so the refuted claim needed an upper half that is
argued nowhere.** A lower bound never supplies an upper one: `n²` dominates `n` from below and
is not `O(n)`, for every constant `C` there is an `n` beyond it. So `Θ(n^{-3/2})` is a
strictly stronger claim than `Ω(n^{-3/2})`, not a sharper phrasing of it.

**And `O(n)` against `O(n³)` is a gap that grows.** The two differ by a factor `n²`, which at
`n = 12` is already `144`, so the refuted constant was not out by a coefficient but by two
orders, and no choice of constant recovers it.
-/

namespace HamiltonsCubic.TubeRadius

/-! ## `Ω` does not give `Θ` -/

/-- **No constant makes `n²` an `O(n)`**: for every `C` there is an `n` past it. So a lower
bound of one order does not close to a two-sided one. -/
theorem omega_not_theta (C : ℚ) (hC : 0 ≤ C) : ∃ n : ℚ, 0 < n ∧ C * n < n * n := by
  refine ⟨C + 1, by linarith, ?_⟩
  nlinarith [hC]

/-! ## `O(n)` against `O(n³)` -/

/-- **The two orders differ by `n²`.** -/
theorem order_ratio (n : ℚ) (hn : n ≠ 0) : n ^ 3 / n = n ^ 2 := by
  field_simp

/-- **At `n = 12` the factor is already `144`**, so the refuted constant was out by two orders
and no coefficient recovers it. -/
theorem factor_at_twelve : (12 : ℚ) ^ 2 = 144 := by norm_num

/-- And it grows without bound, so the overstatement widens with `n`. -/
theorem factor_grows (C : ℚ) (hC : 0 < C) : ∃ n : ℚ, 0 < n ∧ C < n ^ 2 := by
  refine ⟨C + 1, by linarith, ?_⟩
  nlinarith [hC]

end HamiltonsCubic.TubeRadius
