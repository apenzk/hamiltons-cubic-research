import Mathlib

/-!
# L70, what makes `D(v) ≥ 0`, and where it fails

The deficiency identity replaces every product `λ_a λ_b` by `λ_min λ_max` and
defines `D` as the difference. Its nonnegativity is *"each summand a nonnegative
weight against a nonnegative factor"*, and the block records that this needs

> `λ_min < 0 < λ_max` **strictly**, which on `𝒲ₙ` is supplied by `tr W = 0` at
> `W ≠ 0`, *the equality characterisation needs the strict inequality, and the
> hypothesis was missing altogether when this was first written.*

**Three structural facts, all proved here:**

* strict signs make `λ_min λ_max` the minimum of `λ_a λ_b` over the spectrum,
  which is the termwise step `D ≥ 0` rests on;
* tracelessness at `W ≠ 0` supplies those strict signs;
* and **on an all-negative spectrum the step fails**, the block's own
  counterexample, here with the exact witness `(-3,-2,-1)` in place of decimals.

The identity itself and its equality case are owed; the equality case is what
feeds [L71](L71.lean)'s three inclusions.
-/

namespace HamiltonsCubic.L70

/-- **The termwise step.** With strict signs, `m * M` really is the minimum of
`x * y` over the spectrum's range. -/
theorem min_max_le_mul {m M x y : ℝ} (hm : m < 0) (hM : 0 < M)
    (hx : m ≤ x) (hx' : x ≤ M) (hy : m ≤ y) (hy' : y ≤ M) :
    m * M ≤ x * y := by
  rcases le_total 0 x with hx0 | hx0
  · rcases le_total 0 y with hy0 | hy0
    · nlinarith
    · nlinarith
  · rcases le_total 0 y with hy0 | hy0
    · nlinarith
    · nlinarith

/-- **Tracelessness supplies the strict signs.** A finite family summing to zero
with a nonzero member has both a strictly negative and a strictly positive one,
so on `𝒲ₙ` at `W ≠ 0` the hypothesis above is automatic. -/
theorem exists_neg_of_sum_zero {ι : Type*} (s : Finset ι) (f : ι → ℝ)
    (hsum : ∑ b ∈ s, f b = 0) (a : ι) (ha : a ∈ s) (hfa : f a ≠ 0) :
    (∃ b ∈ s, f b < 0) ∧ (∃ c ∈ s, 0 < f c) := by
  constructor
  · by_contra hc
    push_neg at hc
    have hall : ∀ b ∈ s, f b = 0 :=
      (Finset.sum_eq_zero_iff_of_nonneg hc).mp hsum
    exact hfa (hall a ha)
  · by_contra hc
    push_neg at hc
    have hnonneg : ∀ b ∈ s, 0 ≤ -f b := fun b hb => by linarith [hc b hb]
    have hsum' : ∑ b ∈ s, -f b = 0 := by
      rw [Finset.sum_neg_distrib, hsum, neg_zero]
    have hall : ∀ b ∈ s, -f b = 0 :=
      (Finset.sum_eq_zero_iff_of_nonneg hnonneg).mp hsum'
    exact hfa (by linarith [hall a ha])

/-- **And the step fails on an all-negative spectrum**, which is the block's own
counterexample. At `λ = (-3,-2,-1)` the true minimum product is `1`, attained at
`λ_max²`, against `λ_min λ_max = 3`. -/
theorem all_negative_fails :
    (-1 : ℝ) * (-1) < (-3 : ℝ) * (-1) := by norm_num

end HamiltonsCubic.L70
