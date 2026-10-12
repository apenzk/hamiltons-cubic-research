import Mathlib

set_option linter.style.longLine false

/-!
# The uniform small-mass threshold against the balanced product's

[The working note](../../../reviews/2026-09-28d-I121-smallmass-direct.md) on I121, "At the node".

**The source's statement.** At a global maximiser whose maximal-frame diagonal part is proportional
to the balanced product, route R53 gives "either `W` is diagonal or `t ≤ c_*/(d − c_*)`", which is
`t ≤ 2/(n−4)` there (`balanced_threshold` in [ProductFoothold.lean](ProductFoothold.lean)), and the
record's `average_beats_threshold` excludes the second branch at `n ≥ 30`. `t_ge_of_crit` in
[SecondKindE.lean](SecondKindE.lean) gives `t ≥ (θ₀ − 3/(2θ₀))/c` with `c = (3/2)√(2(n−1)/n)`.

**What is typed.** `threshold_beats_balanced`: that bound exceeds `2/(n−4)` at `n = 26` and
`n = 28`, so the second branch is excluded there as well; `eps_sq`, the square of
`ε = θ₀ − 3/(2θ₀)` as `(θ₀² − 3/2)²/θ₀²`, which makes the comparison rational.

**Not typed**: R53's coupling bound behind the dichotomy, which rests on the character table of
`L_e` at a sphere product and the maximal frame's first-order condition, one-plane bound and double
rotation (Gate 2 r1816, r1817). At `n = 24` the comparison fails (`0.0087 < 0.01` in squares).
-/

namespace HamiltonsCubic.SecondKindBalanced

/-- `ε² = (θ₀² − 3/2)²/θ₀²` for `ε = θ₀ − 3/(2θ₀)`, so `ε_n²` is rational in `n`. -/
theorem eps_sq (θ₀ : ℝ) (h : 0 < θ₀) :
    (θ₀ - 3 / (2 * θ₀)) ^ 2 = (θ₀ ^ 2 - 3 / 2) ^ 2 / θ₀ ^ 2 := by
  field_simp

/-- **The uniform threshold beats the balanced product's at `n = 26` and `n = 28`.** With
`θ₀² = 2(n−1)(n−2)/n²` and `c = (3/2)√(2(n−1)/n)`, any `t ≥ (θ₀ − 3/(2θ₀))/c` (`t_ge_of_crit`)
exceeds `2/(n−4) = c_*/(d − c_*)`, the balanced product's threshold (`balanced_threshold`). -/
theorem threshold_beats_balanced (n θ₀ t : ℝ) (hn : n = 26 ∨ n = 28) (hθ₀ : 0 < θ₀)
    (hsq : θ₀ ^ 2 = 2 * (n - 1) * (n - 2) / n ^ 2)
    (ht : (θ₀ - 3 / (2 * θ₀)) / (3 / 2 * Real.sqrt (2 * ((n - 1) / n))) ≤ t) :
    2 / (n - 4) < t := by
  have hn4 : (4 : ℝ) < n := by rcases hn with rfl | rfl <;> norm_num
  have hc2 : Real.sqrt (2 * ((n - 1) / n)) ^ 2 = 2 * ((n - 1) / n) :=
    Real.sq_sqrt (by rcases hn with rfl | rfl <;> norm_num)
  have hcpos : 0 < 3 / 2 * Real.sqrt (2 * ((n - 1) / n)) := by
    have : 0 < Real.sqrt (2 * ((n - 1) / n)) := Real.sqrt_pos.2 (by rcases hn with rfl | rfl <;> norm_num)
    positivity
  -- the square of the bound
  have hsqb : ((θ₀ - 3 / (2 * θ₀)) / (3 / 2 * Real.sqrt (2 * ((n - 1) / n)))) ^ 2
      = (θ₀ ^ 2 - 3 / 2) ^ 2 / θ₀ ^ 2 / (9 / 4 * (2 * ((n - 1) / n))) := by
    rw [div_pow, eps_sq θ₀ hθ₀, mul_pow, hc2]; ring
  have hkey : (2 / (n - 4)) ^ 2
      < ((θ₀ - 3 / (2 * θ₀)) / (3 / 2 * Real.sqrt (2 * ((n - 1) / n)))) ^ 2 := by
    rw [hsqb, hsq]
    rcases hn with rfl | rfl <;> norm_num
  have hnum : 0 ≤ θ₀ - 3 / (2 * θ₀) := by
    rw [sub_nonneg, div_le_iff₀ (by positivity)]
    have : (3 : ℝ) / 2 ≤ θ₀ ^ 2 := by rw [hsq]; rcases hn with rfl | rfl <;> norm_num
    nlinarith
  have hbpos : 0 ≤ (θ₀ - 3 / (2 * θ₀)) / (3 / 2 * Real.sqrt (2 * ((n - 1) / n))) :=
    div_nonneg hnum hcpos.le
  have hlt : 2 / (n - 4) < (θ₀ - 3 / (2 * θ₀)) / (3 / 2 * Real.sqrt (2 * ((n - 1) / n))) :=
    lt_of_pow_lt_pow_left₀ 2 hbpos hkey
  linarith

end HamiltonsCubic.SecondKindBalanced
