import Mathlib

/-!
# The value above `√(3/2)` lives in the visible and diagonal parts: the scalar steps

[The working note](../../../reviews/2026-09-28d-I121-smallmass-direct.md) on I121's
small-mass node, "The reduction".

**The source's statement.** "Put `E(W) = P(W) - (3/2) tr W³`. At every unit critical point,
`θ² ≤ 3/2 + θ E(W)`", from `tr W³ ≤ λ_max` and L198's `θ λ_max ≤ 1`; and at pair-free `W` in a
frame, `E(W) = [P(A) - (3/2) tr A³] - 6 Σ (a_e + a_f) X² + 24 Σ XXX`, every `J` cancelling.

**What is typed.** `sum_cube_le`, a spectrum's third power sum is at most its top value times
its second; `theta_trace_le`, `θ Σ λ³ ≤ Σ λ²` from `θ λₖ ≤ 1` at every `k`;
`crit_E_bound` and `crit_E_bound'`, the value bound from the split; `crit_E_lt`, a split value below
`θ₀ - 3/(2θ₀)` forces `θ < θ₀`; `E_pair_coeff` and `E_rect_coeff`, the cancellation of the
`J` terms per disjoint pair and per rectangle.

**Not typed**: `tr W³` as a sum over the spectrum of `W` on `Λ²`, L198 itself on the operators,
and the frame expansion of `P` and `tr W³`, which are prose in the source.
-/

/-- **THE THIRD POWER SUM.** With every value at most `m`, `Σ λᵢ³ ≤ m Σ λᵢ²`. -/
theorem sum_cube_le {ι : Type*} (s : Finset ι) (l : ι → ℝ) (m : ℝ)
    (hm : ∀ i ∈ s, l i ≤ m) :
    ∑ i ∈ s, l i ^ 3 ≤ m * ∑ i ∈ s, l i ^ 2 := by
  rw [Finset.mul_sum]
  apply Finset.sum_le_sum
  intro i hi
  nlinarith [mul_nonneg (sq_nonneg (l i)) (sub_nonneg.2 (hm i hi))]

/-- **THE VALUE BOUND FROM THE SPLIT.** With `θ = (3/2)T + E`, `T ≤ λ` and `θλ ≤ 1` at
`θ > 0`, `θ² ≤ 3/2 + θE`. -/
theorem crit_E_bound (θ lam T E : ℝ) (hθ : 0 < θ) (hP : θ = 3 / 2 * T + E) (hT : T ≤ lam)
    (hθl : θ * lam ≤ 1) : θ ^ 2 ≤ 3 / 2 + θ * E := by
  have h1 : θ * T ≤ θ * lam := mul_le_mul_of_nonneg_left hT hθ.le
  nlinarith

/-- **THE THRESHOLD.** If `θ² ≤ 3/2 + θE` at `θ > 0` and `E < θ₀ - 3/(2θ₀)` with `θ₀ > 0`,
then `θ < θ₀`. -/
theorem crit_E_lt (θ θ₀ E : ℝ) (hθ : 0 < θ) (hθ₀ : 0 < θ₀) (hb : θ ^ 2 ≤ 3 / 2 + θ * E)
    (hE : E < θ₀ - 3 / (2 * θ₀)) : θ < θ₀ := by
  by_contra h
  have h : θ₀ ≤ θ := not_lt.mp h
  have hdiv : 3 / (2 * θ) ≤ 3 / (2 * θ₀) := by
    apply div_le_div_of_nonneg_left (by norm_num) (by positivity) (by linarith)
  have hθE : θ - 3 / (2 * θ) ≤ E := by
    have : θ - 3 / (2 * θ) = (θ ^ 2 - 3 / 2) / θ := by field_simp
    rw [this, div_le_iff₀ hθ]
    nlinarith
  linarith

/-- **THE `J` TERMS CANCEL ON A DISJOINT PAIR.** `3((3/2)J² - 2X²)(a + a') - (3/2)·3(a + a')J`
`= -6(a + a')X²`. -/
theorem E_pair_coeff (a a' J X : ℝ) :
    3 * (3 / 2 * J ^ 2 - 2 * X ^ 2) * (a + a') - 3 / 2 * (3 * (a + a') * J ^ 2)
      = -6 * (a + a') * X ^ 2 := by
  ring

/-- **THE `J` TERMS CANCEL ON A RECTANGLE.** `9JJJ + 24XXX - (3/2)·6JJJ = 24XXX`. -/
theorem E_rect_coeff (J₁ J₂ J₃ X₁ X₂ X₃ : ℝ) :
    9 * (J₁ * J₂ * J₃) + 24 * (X₁ * X₂ * X₃) - 3 / 2 * (6 * (J₁ * J₂ * J₃))
      = 24 * (X₁ * X₂ * X₃) := by
  ring

/-- **THE SIGN-FREE FORM.** L198 gives `θ λₖ ≤ 1` at every `k`, so `θ Σ λₖ³ ≤ Σ λₖ²` with no
sign condition on `θ` (r1849). -/
theorem theta_trace_le {ι : Type*} (s : Finset ι) (l : ι → ℝ) (θ : ℝ)
    (h : ∀ i ∈ s, θ * l i ≤ 1) :
    θ * ∑ i ∈ s, l i ^ 3 ≤ ∑ i ∈ s, l i ^ 2 := by
  rw [Finset.mul_sum]
  apply Finset.sum_le_sum
  intro i hi
  calc θ * l i ^ 3 = (θ * l i) * l i ^ 2 := by ring
    _ ≤ 1 * l i ^ 2 := mul_le_mul_of_nonneg_right (h i hi) (sq_nonneg (l i))
    _ = l i ^ 2 := one_mul _

/-- **THE VALUE BOUND AT EVERY SIGN.** With `θ = (3/2)T + E` and `θT ≤ 1`, `θ² ≤ 3/2 + θE`. -/
theorem crit_E_bound' (θ T E : ℝ) (hP : θ = 3 / 2 * T + E) (hT : θ * T ≤ 1) :
    θ ^ 2 ≤ 3 / 2 + θ * E := by
  subst hP
  nlinarith [hT]

