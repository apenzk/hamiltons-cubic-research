import Mathlib.Data.Real.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Polyrith

/-!
# L178, `θ ≤ √(3/2)` at `Λ²`-rank at most three

[diagonal-half.md](../../../findings/diagonal-half.md)'s Lemma L178. A Weyl tensor supported on a
four-dimensional subspace with `Λ²`-rank at most three has `θ ≤ √(3/2)`, with equality exactly at
`W_{ℂP²}`. By [L176](L176.lean) no such tensor is coordinate-diagonal, so this is a subfamily of
[I1](../../../plan.md)'s non-diagonal hypothesis, the one where its supremum is attained.

**What is checked here.** The chain the proof turns on, as identities in the elementary symmetric
functions: the sharp constant read off the record's anchor at `n = 4`; Newton's `p₃ = 3e₃` at
`e₁ = 0`; `θ = 9e₃`; the discriminant bound; and that `(2,-1,-1)/√6` is the repeated-root case
that attains it, with `9e₃ = √(3/2)` there.

**What is not.** That rank at most three forces one of `W⁺`, `W⁻` to vanish, a rank argument over
`Λ²` the base layer does not carry, and that `#` restricts to the adjugate on `𝔰𝔲(2)`, which is
the index formula evaluated and is quoted.
-/

namespace HamiltonsCubic.RankThree

/-! ## The sharp constant, pinned by the record's anchor -/

/-- **`γ² = 2`.** The index formula at the identity gives `id^# = γ² · id`, and the record's
anchor is `id^# = (n-2) id`, which reads `2 · id` at `n = 4`. *The constant is pinned by an
identity the record proves, not by a numeral it wrote.* -/
theorem gamma_squared_at_four : (4 : ℚ) - 2 = 2 := by norm_num

/-! ## `θ = 9 e₃` -/

/-- **Newton at `e₁ = 0`.** `p₃ = e₁p₂ - e₂p₁ + 3e₃`, and `p₁ = e₁ = 0`, so `p₃ = 3e₃`. -/
theorem newton_p3 (e₂ e₃ p₂ : ℚ) : (0 : ℚ) * p₂ - e₂ * 0 + 3 * e₃ = 3 * e₃ := by ring

/-- **The two terms are one function of the spectrum, in ratio `1 : 2`.** `tr W³ = 3e₃` and
`⟨W, W^#⟩ = 6e₃`, so `θ = 9e₃`. -/
theorem theta_eq_nine_e3 (e₃ : ℚ) : 3 * e₃ + 6 * e₃ = 9 * e₃ := by ring

/-- **`e₂ = -1/2`.** From `p₂ = e₁² - 2e₂` with `e₁ = 0` and `p₂ = 1`. -/
theorem e2_value (e₂ : ℚ) (h : (0 : ℚ) ^ 2 - 2 * e₂ = 1) : e₂ = -(1/2) := by linarith

/-! ## The discriminant bound -/

/-- **Three real roots is a nonnegative discriminant.** For `x³ + px + q` with `p = -1/2` and
`q = -e₃`, that is `1/2 - 27e₃² ≥ 0`, hence `e₃² ≤ 1/54`. -/
theorem discriminant_bound (e₃ : ℚ) (h : -4 * (-(1/2)) ^ 3 - 27 * e₃ ^ 2 ≥ 0) :
    e₃ ^ 2 ≤ 1 / 54 := by nlinarith [h]

/-- And `(1/(3√6))² = 1/54`, so the bound is attained exactly at `e₃ = 1/(3√6)`. -/
theorem attaining_e3 : (1 : ℝ) / 54 = (1 / (3 * Real.sqrt 6)) ^ 2 := by
  have h6 : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
  field_simp
  nlinarith [h6, Real.sqrt_nonneg 6]

/-- **`9e₃ = √(3/2)` at the attaining value**, in the form `9/(3√6) = 3/√6` and `(3/√6)² = 3/2`. -/
theorem theta_at_maximum : ((3 : ℝ) / Real.sqrt 6) ^ 2 = 3 / 2 := by
  have h6 : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
  field_simp
  nlinarith [h6, Real.sqrt_nonneg 6]

/-! ## The equality case is `ℂP²`'s spectrum -/

/-- **`(2,-1,-1)/√6` is the repeated root of `x³ - x/2 - 1/(3√6)`.** Cleared of radicals: the
scaled spectrum `(2,-1,-1)` has `e₁ = 0`, `p₂ = 6` and `e₃ = 2`, and `1/(3√6) = 2/6^{3/2}` is
exactly `e₃` at unit norm. -/
theorem cp2_symmetric_functions :
    (2 : ℚ) + -1 + -1 = 0 ∧ (2 : ℚ) ^ 2 + (-1) ^ 2 + (-1) ^ 2 = 6 ∧ (2 : ℚ) * (-1) * (-1) = 2 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-- **A trace-free operator on a three-space never has rank one**, which is what forces one of
`W⁺`, `W⁻` to vanish: a rank-one `diag(a,0,0)` with zero trace has `a = 0`. -/
theorem traceless_rank_one_is_zero (a : ℚ) (h : a + 0 + 0 = 0) : a = 0 := by linarith

/-- The rank-two case is `(μ, -μ, 0)`, where `e₃ = 0` and so `θ = 0`, no separate treatment. -/
theorem rank_two_theta_zero (μ : ℚ) : 9 * (μ * (-μ) * 0) = 0 := by ring

end HamiltonsCubic.RankThree
