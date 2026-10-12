import Mathlib

set_option linter.style.longLine false

/-!
# L151, WITHDRAWN: it froze a free parameter at an inadmissible value and called the remainder bounded

The record's block, quoted verbatim from
[second-order.md](../../../findings/second-order.md):

> #### Lemma L151, WITHDRAWN: it froze a free parameter at an inadmissible value and called the remainder bounded
>
> *Recorded and withdrawn 2026-09-03. **Gate 2: [r457](../../../reviews/REVIEW_r457.md) REFUTED it**,
> deriving the contour family by hand.*
>
> **THE CONSTANT IS NOT A CONSTANT; IT IS A FUNCTION OF THE PARAMETER THE ENTRY FROZE.** With `Γ` the
> circle of radius `α g_n` about `λ₋` and `ρ = γ g_n/‖H‖_op`,
> $$M ≤ C(α,γ)\,ρ,\qquad C(α,γ) = \frac{α + \tfrac m{m-1}}{α-γ}.$$
> **At the entry's own values `α = γ = ½` this is `+∞`.** *So its two "pinned" rows, the contour's
> `½` and the owed `C`, were one free parameter counted twice, fixed at an inadmissible point, with
> the remainder called "one bounded computation with every input already fixed".*
>
> **And `½` was never forced.** Optimising the defect branch gives `γ = α/2`, *half the **contour
> radius**, not half the gap*, with the supremum at `α → 1`, unattained. **The entry called it
> "pinned by the geometry, not chosen".**
>
> **The two rows whose algebra was right were base-point facts used along the segment.** Cauchy's
> `k! = 2` becomes `2M/((1−η)ρ)²` uniformly, hence **`8`** at the already-frozen `η = ½`; and the
> Leibniz term `2⟨A''',A⟩` vanishes at `t = 0` **only**, contributing at the same order for `s ≍ ρ`.
>
> **AND THE CONSTANT IT CALLED OWED WAS ALREADY ON THE RECORD.** [r441](../../../reviews/REVIEW_r441.md)
> computes `M ≤ 6ρ` ([r456](../../../reviews/REVIEW_r456.md)).

## What this file types

* `Cc`, the contour-constant family r457 derived, which the block calls "the real result of this
  entry"; and `Cc_pos`, that it is positive on the admissible region `0 < γ < α`.
* `frozen_point_inadmissible` and `Cc_unbounded_as_gamma_to_alpha`, the withdrawal's reason:
  at `α = γ` the denominator is zero, and `C` exceeds every bound as `γ ↑ α`, so the entry's
  `α = γ = ½` is not a value of `C` at all.
* `half_alpha_maximises_denominator` and `objective_min_at_half_alpha`, `γ = α/2` optimises, half
  the **contour radius** rather than half the gap; the objective is `J = C/γ`.
* `J_strictly_decreasing` and `infimum_not_attained`, with `γ = α/2` the objective strictly
  decreases in `α`, so on the entry's own `α < 1` its infimum `4(1+k)` is approached and never
  reached, which is the record's "supremum at `α → 1`, unattained" read through `J = 1/radius`.
* `cauchy_constant_eight`, `2/(1−η)² = 8` at the frozen `η = ½`.
* `r441_value_already_on_record`, `(1+α)/(α−γ) = 6` at `(α,γ) = (½,¼)`, the value the entry called
  owed.

## What is NOT typed here

* **That `M ≤ C(α,γ)ρ` holds**, i.e. the contour estimate itself. Only the algebra of the function
  `C` is typed; the resolvent bound it summarises is
  [L156](../../../findings/second-order.md)'s, whose corrected form is
  `α(1+α)/(d(d−γ))` with `d = min(α, D−α)`, so `C` above is itself valid only below the kink.
* **The nine-constant count**, and the claim that at `β = 0` all three of
  [L149](../../../findings/second-order.md)'s branches are `Θ(n⁻¹)` with branch 1 carrying no Cauchy
  constant, statements about a chain this file does not build.
* **`C = 1` on the real segment**, including `‖Alt‖_op ≤ 1`, which the block records as what survives.
* **The Leibniz clause**, that `2⟨A''',A⟩` vanishes at `t = 0` only.
* **Which of `α < 1` and `α < D` binds.** The block asserts `α → 1`; L152 and
  [L156](../../../findings/second-order.md) later settle that the binding constraint is the resolvent
  kink and that the optimum sits at `α* = D/2 > 1`. The `α < 1` range is typed here as the entry's
  own, not as the record's final answer.
-/

namespace HamiltonsCubic.L151Statement

/-! ## The contour-constant family -/

/-- `C(α,γ) = (α + m/(m−1))/(α − γ)`, r457's family. -/
noncomputable def Cc (m alpha gamma : ℝ) : ℝ := (alpha + m / (m - 1)) / (alpha - gamma)

/-- The numerator is positive on the region in question. -/
theorem numerator_pos (m alpha : ℝ) (hm : 2 ≤ m) (ha : 0 < alpha) : 0 < alpha + m / (m - 1) := by
  have hm1 : (0 : ℝ) < m - 1 := by linarith
  have : 0 < m / (m - 1) := by positivity
  linarith

theorem Cc_pos (m alpha gamma : ℝ) (hm : 2 ≤ m) (ha : 0 < alpha) (hg : gamma < alpha) :
    0 < Cc m alpha gamma := by
  rw [Cc]
  exact div_pos (numerator_pos m alpha hm ha) (by linarith)

/-! ## The withdrawal: the frozen point is not a value of `C` -/

/-- **`α = γ = ½` puts the denominator at zero.** The entry's two "pinned" rows were one free
parameter counted twice. -/
theorem frozen_point_inadmissible : (1 / 2 : ℝ) - 1 / 2 = 0 := by norm_num

/-- **`C` exceeds every bound as `γ ↑ α`**, so no value of `C` sits at `α = γ`, the sense in which
the record's `+∞` is meant. -/
theorem Cc_unbounded_as_gamma_to_alpha (m alpha : ℝ) (hm : 2 ≤ m) (ha : 0 < alpha) (K : ℝ) :
    ∃ gamma : ℝ, 0 < gamma ∧ gamma < alpha ∧ K < Cc m alpha gamma := by
  set N : ℝ := alpha + m / (m - 1) with hN
  have hNpos : 0 < N := numerator_pos m alpha hm ha
  set eps : ℝ := min (alpha / 2) (N / (|K| + 1)) with heps
  have hKpos : (0 : ℝ) < |K| + 1 := by positivity
  have hepspos : 0 < eps := lt_min (by linarith) (by positivity)
  have hepsle : eps ≤ alpha / 2 := min_le_left _ _
  have hepsle2 : eps ≤ N / (|K| + 1) := min_le_right _ _
  refine ⟨alpha - eps, by linarith, by linarith, ?_⟩
  rw [Cc, ← hN]
  have hden : alpha - (alpha - eps) = eps := by ring
  rw [hden]
  have hstep : |K| + 1 ≤ N / eps := by
    rw [le_div_iff₀ hepspos]
    have hmul : eps * (|K| + 1) ≤ N := (le_div_iff₀ hKpos).mp hepsle2
    linarith [hmul]
  have : K ≤ |K| := le_abs_self K
  linarith

/-! ## `γ = α/2` optimises, and it is half the contour radius -/

/-- `γ(α − γ) ≤ α²/4`, with equality exactly at `γ = α/2`. -/
theorem half_alpha_maximises_denominator (alpha gamma : ℝ) :
    gamma * (alpha - gamma) ≤ alpha ^ 2 / 4
      ∧ (gamma * (alpha - gamma) = alpha ^ 2 / 4 ↔ gamma = alpha / 2) := by
  constructor
  · nlinarith [sq_nonneg (gamma - alpha / 2)]
  · constructor
    · intro h
      have hz : (gamma - alpha / 2) ^ 2 = 0 := by nlinarith
      have := pow_eq_zero_iff (n := 2) (by norm_num) |>.mp hz
      linarith
    · intro h; rw [h]; ring

/-- **The objective `J = C/γ` is minimised at `γ = α/2`**, uniformly over `0 < γ < α`. -/
theorem objective_min_at_half_alpha (m alpha gamma : ℝ) (hm : 2 ≤ m) (ha : 0 < alpha)
    (hg : 0 < gamma) (hlt : gamma < alpha) :
    Cc m alpha (alpha / 2) / (alpha / 2) ≤ Cc m alpha gamma / gamma := by
  have hN : 0 < alpha + m / (m - 1) := numerator_pos m alpha hm ha
  have hd1 : (0 : ℝ) < alpha ^ 2 / 4 := by positivity
  have hd2 : (0 : ℝ) < gamma * (alpha - gamma) := mul_pos hg (by linarith)
  have hle : gamma * (alpha - gamma) ≤ alpha ^ 2 / 4 :=
    (half_alpha_maximises_denominator alpha gamma).1
  have e1 : Cc m alpha (alpha / 2) / (alpha / 2)
      = (alpha + m / (m - 1)) / (alpha ^ 2 / 4) := by
    rw [Cc]; rw [div_div]; congr 1; ring
  have e2 : Cc m alpha gamma / gamma = (alpha + m / (m - 1)) / (gamma * (alpha - gamma)) := by
    rw [Cc, div_div]; congr 1; ring
  rw [e1, e2, div_le_div_iff₀ hd1 hd2]
  nlinarith

/-! ## With `γ = α/2` the objective decreases in `α`, so the entry's `α < 1` has no optimum -/

/-- At `γ = α/2` the objective is `J(α) = 4(α + k)/α²` with `k = m/(m−1) > 0`, **strictly
decreasing** in `α`. -/
theorem J_strictly_decreasing (k a1 a2 : ℝ) (hk : 0 < k) (h1 : 0 < a1) (h12 : a1 < a2) :
    4 * (a2 + k) / a2 ^ 2 < 4 * (a1 + k) / a1 ^ 2 := by
  have ha2 : (0 : ℝ) < a2 := lt_trans h1 h12
  have hp1 : (0 : ℝ) < a1 ^ 2 := by positivity
  have hp2 : (0 : ℝ) < a2 ^ 2 := by positivity
  rw [div_lt_div_iff₀ hp2 hp1]
  nlinarith [mul_pos (mul_pos h1 ha2) (sub_pos.mpr h12), mul_pos hk (sub_pos.mpr h12),
    mul_pos (add_pos h1 ha2) (sub_pos.mpr h12)]

/-- **So on `0 < α < 1` the infimum `4(1+k)` is never attained**, which is the record's "supremum at
`α → 1`, unattained" read through `J = 1/radius`. -/
theorem infimum_not_attained (k a : ℝ) (hk : 0 < k) (ha : 0 < a) (halt : a < 1) :
    4 * (1 + k) < 4 * (a + k) / a ^ 2 := by
  have h := J_strictly_decreasing k a 1 hk ha halt
  norm_num at h
  exact h

/-! ## The two rows whose algebra was right -/

/-- **Cauchy's `k! = 2` gives `2M/((1−η)ρ)²`, hence `8` at the already-frozen `η = ½`.** -/
theorem cauchy_constant_eight : 2 / (1 - (1 / 2 : ℚ)) ^ 2 = 8 := by norm_num

/-- **The constant the entry called owed already had a value**: r441's `M ≤ 6ρ`, which
`(1+α)/(α−γ)` returns exactly at `(α,γ) = (½,¼)`. -/
theorem r441_value_already_on_record : (1 + (1 / 2 : ℚ)) / (1 / 2 - 1 / 4) = 6 := by norm_num

/-! ## A witness, so the admissible region is nonempty -/

/-- `(α,γ) = (½,¼)` at `m = 6` is admissible and gives a finite constant. -/
example : (0 : ℝ) < 1 / 4 ∧ (1 / 4 : ℝ) < 1 / 2 ∧ 0 < Cc 6 (1 / 2) (1 / 4) := by
  refine ⟨by norm_num, by norm_num, Cc_pos 6 (1 / 2) (1 / 4) (by norm_num) (by norm_num) (by norm_num)⟩

end HamiltonsCubic.L151Statement
