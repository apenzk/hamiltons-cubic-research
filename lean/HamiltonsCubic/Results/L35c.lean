import Mathlib

/-!
# L35's endpoint, in exact arithmetic

L35's close reduces to a one-variable inequality in

`g(A) = A³ - (1-A²)^{3/2}/√2 + 3A(1-A²)`  on  `A ∈ (0, A₀]`,  `A₀ = √(2/3)`,

and the record is explicit about what that costs: the interval `(0,⅓]` and the
endpoint close in closed form, while `(⅓, 0.7096]` closes by **200-bit interval
arithmetic with branch-and-bound**. *"That is rigorous and it is not
hand-checkable, so this result is a proof with a certified numerical step rather
than one a reader can follow end to end."*

**The endpoint is the part that is exact, and it is proved here**: `g(A₀) = √6/2`,
which is `√(3/2)`, so the bound is *attained* at `A₀` and the inequality is
sharp there.

`√(3/2) = √6/2` is the same restatement that has paid five times elsewhere: the
awkward surd is a tidy one, and the whole computation is rational in `√6`.
-/

namespace HamiltonsCubic.L35c

open Real

/-- `A₀ = √(2/3)`, written as `√6/3` so the arithmetic stays inside `√6`. -/
noncomputable def A₀ : ℝ := Real.sqrt 6 / 3

theorem A₀_sq : A₀ ^ 2 = 2 / 3 := by
  unfold A₀
  rw [div_pow, Real.sq_sqrt (by norm_num : (6:ℝ) ≥ 0)]
  norm_num

/-- `1 - A₀² = 1/3`. -/
theorem one_sub_A₀_sq : 1 - A₀ ^ 2 = 1 / 3 := by rw [A₀_sq]; norm_num

/-- `g`, with the `3/2` power written as a product so no `rpow` enters. -/
noncomputable def g (A : ℝ) : ℝ :=
  A ^ 3 - (1 - A ^ 2) * Real.sqrt (1 - A ^ 2) / Real.sqrt 2 + 3 * A * (1 - A ^ 2)

/-- **The endpoint value, exactly**: `g(A₀) = √6/2`, which is `√(3/2)`. So the
bound is *attained* at `A₀` and the inequality is sharp there. -/
theorem g_A₀ : g A₀ = Real.sqrt 6 / 2 := by
  have h6 : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
  have hdiv : Real.sqrt (1/3 : ℝ) / Real.sqrt 2 = Real.sqrt 6 / 6 := by
    rw [← Real.sqrt_div (by norm_num : (0:ℝ) ≤ 1/3),
      show (1/3 : ℝ) / 2 = 1/6 by norm_num]
    have hs : (Real.sqrt 6 / 6) ^ 2 = 1/6 := by
      rw [div_pow, h6]; norm_num
    rw [← hs, Real.sqrt_sq (by positivity)]
  unfold g
  rw [one_sub_A₀_sq]
  unfold A₀
  rw [show (1/3 : ℝ) * Real.sqrt (1/3) / Real.sqrt 2
        = (1/3 : ℝ) * (Real.sqrt (1/3) / Real.sqrt 2) by ring, hdiv]
  field_simp
  nlinarith [h6, Real.sqrt_nonneg 6]

/-- And `√6/2` is `√(3/2)`, so the endpoint value is the bound itself. -/
theorem sqrt_six_half : Real.sqrt 6 / 2 = Real.sqrt (3/2) := by
  have h : (Real.sqrt 6 / 2) ^ 2 = 3/2 := by
    rw [div_pow, Real.sq_sqrt (by norm_num : (6:ℝ) ≥ 0)]; norm_num
  rw [← h, Real.sqrt_sq (by positivity)]

end HamiltonsCubic.L35c
