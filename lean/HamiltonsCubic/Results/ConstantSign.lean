import HamiltonsCubic.Base.WeylReal

/-!
# Pairwise products all one make a sign constant

**What this is for.** [L195](../../../findings/diagonal-half.md) reduces to a sign `σⱼ = ±1` at
each eigenspace of the common square, with the wedge condition giving `σⱼ σₖ = 1` at every pair
`j ≠ k`. *This file carries the step that finishes it*: such a `σ` is constant, so the two forms
agree up to one global sign.

**The first version of L195 derived that pair relation and then dropped it**, keeping only a strict
consequence and building a weighted count on it. The count was correct and unnecessary: the relation
alone empties the stratum at every dimension. *Both reviewers of the round found this independently,
and the file that held the count is gone.*
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.RealLayer

/-- **A `±1`-valued function whose pairwise products are all `1` is constant.**

*Stated with a witness index rather than over a nonempty type, so it says exactly what the geometry
supplies: one eigenspace to compare the others against.* -/
theorem const_of_pairwise_mul_eq_one {ι : Type*} (s : ι → ℝ)
    (hsign : ∀ j, s j = 1 ∨ s j = -1)
    (hpair : ∀ j k, j ≠ k → s j * s k = 1) (a : ι) :
    ∀ j, s j = s a := by
  intro j
  by_cases h : j = a
  · rw [h]
  · have hjk := hpair j a h
    rcases hsign j with hj | hj <;> rcases hsign a with ha | ha <;>
      rw [hj, ha] at hjk ⊢ <;> first | rfl | norm_num at hjk

end HamiltonsCubic.RealLayer
