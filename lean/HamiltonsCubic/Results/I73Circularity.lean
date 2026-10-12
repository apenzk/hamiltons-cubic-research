import Mathlib

set_option linter.style.longLine false

/-!
# The circularity in Nienhaus's great-circle estimate, the three scalar facts it turns on

[reviews/2026-09-22-circularity-derivation.md](../../../reviews/2026-09-22-circularity-derivation.md)
measures where Theorem 4.17's monotonicity closes when the a-priori input `f ≤ 1` is weakened to
`f ≤ C`. Along the great circle from `W_CP2`, `f(φ) = cos³φ + 3 cosφ sin²φ α + sin³φ γ` with
`α ≤ 1/3`, and the monotonicity on `(0, π/6)` is decided at `φ = π/6`.

## What is proved

* `g1_closed_form`: at `C = 1` the stationary condition `(1-α)x² - x + α = 0` for `x = cos φ₀`
  factors as `(x - 1)((1-α)x - α)`, so the interior root is `x = α/(1-α)`, and there the bound on
  `γ` is `(1+α)√(1-2α)`. *The extraction of the source garbles this expression.*
* `monotone_threshold`: `f'(π/6) < 0 ⟺ γ < (3 - 5α)/√3`, with `f'` written out.
* `tight_at_top`: at `α = 1/3` the `C = 1` bound and the threshold COINCIDE, `(1+1/3)√(1-2/3) =
  (3 - 5/3)/√3`. *So the estimate is exactly tight at the top eigenvalue, which is why it cannot
  survive any `C > 1` there, and why the failure for `C > 1` is a shell below `1/3`.*

## What is NOT stated

That `f` is the potential along a great circle, that `α ≤ 1/3` is Theorem 4.14, or anything about
Weyl tensors. These are scalar facts about a cubic in `cos φ, sin φ`.
-/

namespace HamiltonsCubic.I73Circularity

/-- The stationary condition at `C = 1` factors, so the interior root is `α/(1-α)`. -/
theorem g1_stationary_factors (a x : ℝ) :
    (1 - a) * x ^ 2 - x + a = (x - 1) * ((1 - a) * x - a) := by
  ring

/-- `1 - x²` at the interior root, as a quotient. -/
theorem one_sub_sq_at_root (a : ℝ) (h1a : (1:ℝ) - a ≠ 0) :
    1 - (a / (1 - a)) ^ 2 = (1 - 2 * a) / (1 - a) ^ 2 := by
  field_simp
  ring

/-- The numerator at the interior root, as a quotient. -/
theorem numerator_at_root (a : ℝ) (h1a : (1:ℝ) - a ≠ 0) :
    1 - (a / (1 - a)) ^ 3 - 3 * (a / (1 - a)) * (1 - (a / (1 - a)) ^ 2) * a
      = (1 - 2 * a) ^ 2 * (1 + a) / (1 - a) ^ 3 := by
  field_simp
  ring

/-- **The `C = 1` bound on `γ` in closed form**, stated without `rpow`: the numerator equals
`(1+α)√(1-2α)` times `(1-x²)^{3/2}`, written as `(1-x²)·√(1-x²)`.

*So `g₁(α) = (1+α)√(1-2α)`, and the extraction of the source garbles this expression.* -/
theorem g1_closed_form (a : ℝ) (ha0 : 0 ≤ a) (ha : a < 1 / 2) :
    1 - (a / (1 - a)) ^ 3 - 3 * (a / (1 - a)) * (1 - (a / (1 - a)) ^ 2) * a
      = (1 + a) * Real.sqrt (1 - 2 * a)
        * ((1 - (a / (1 - a)) ^ 2) * Real.sqrt (1 - (a / (1 - a)) ^ 2)) := by
  have h1a : (0:ℝ) < 1 - a := by linarith
  have h1a' : (1:ℝ) - a ≠ 0 := ne_of_gt h1a
  have hpos : (0:ℝ) < 1 - 2 * a := by linarith
  have hx2 : 1 - (a / (1 - a)) ^ 2 = (1 - 2 * a) / (1 - a) ^ 2 := one_sub_sq_at_root a h1a'
  have hrt : Real.sqrt (1 - (a / (1 - a)) ^ 2) = Real.sqrt (1 - 2 * a) / (1 - a) := by
    rw [hx2, Real.sqrt_div hpos.le, Real.sqrt_sq h1a.le]
  have hss : Real.sqrt (1 - 2 * a) * Real.sqrt (1 - 2 * a) = 1 - 2 * a :=
    Real.mul_self_sqrt hpos.le
  rw [numerator_at_root a h1a', hrt, hx2]
  field_simp
  nlinarith [hss]

/-- `f'(φ)` along the circle, written out. -/
noncomputable def fderiv (a g φ : ℝ) : ℝ :=
  3 * Real.sin φ * ((2 * a - 1) * Real.cos φ ^ 2 - a * Real.sin φ ^ 2
    + Real.sin φ * Real.cos φ * g)

/-- **`f'(π/6)` evaluated**: it is `(3/8)(5α - 3 + √3 γ)`. -/
theorem fderiv_at_pi_div_six (a g : ℝ) :
    fderiv a g (Real.pi / 6) = 3 / 8 * (5 * a - 3 + Real.sqrt 3 * g) := by
  have h3 : Real.sqrt 3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  unfold fderiv
  rw [Real.sin_pi_div_six, Real.cos_pi_div_six]
  linear_combination (3 / 8) * (2 * a - 1) * h3

/-- **The monotonicity threshold at `π/6`**: `f'(π/6) < 0 ↔ γ < (3 - 5α)/√3`. -/
theorem monotone_threshold (a g : ℝ) :
    fderiv a g (Real.pi / 6) < 0 ↔ g < (3 - 5 * a) / Real.sqrt 3 := by
  have h3p : (0:ℝ) < Real.sqrt 3 := Real.sqrt_pos.mpr (by norm_num)
  rw [fderiv_at_pi_div_six, lt_div_iff₀ h3p]
  constructor <;> intro h <;> nlinarith [h]

/-- **Exactly tight at the top eigenvalue.** At `α = 1/3` the `C = 1` bound `(1+α)√(1-2α)`
equals the threshold `(3 - 5α)/√3`. -/
theorem tight_at_top :
    (1 + (1 / 3 : ℝ)) * Real.sqrt (1 - 2 * (1 / 3)) = (3 - 5 * (1 / 3 : ℝ)) / Real.sqrt 3 := by
  have h : Real.sqrt (1 - 2 * (1 / 3 : ℝ)) = 1 / Real.sqrt 3 := by
    rw [show (1 - 2 * (1 / 3 : ℝ)) = 1 / 3 by norm_num, Real.sqrt_div' _ (by norm_num), Real.sqrt_one]
  rw [h]
  have h3p : Real.sqrt 3 ≠ 0 := ne_of_gt (Real.sqrt_pos.mpr (by norm_num))
  field_simp
  ring

end HamiltonsCubic.I73Circularity
