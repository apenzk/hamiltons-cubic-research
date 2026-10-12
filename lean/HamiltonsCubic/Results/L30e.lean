import HamiltonsCubic.Results.L30d

/-!
# L30, the descent step, assembled

[L30d](L30d.lean) proved the engine: a positively-weighted sum of squares
vanishes only if each term does. Here it becomes the containment the descent
needs.

The Ricci identity, paired against `u ⊗ u` as the block does, says the positive
and negative parts agree as quadratic forms:

`Σ_{λ>0} λ_α (v_α ⬝ u)² = Σ_{λ<0} |λ_β| (v_β ⬝ u)²`.

So a `u` orthogonal to every negative eigenvector kills the right side, hence
the left, hence (by the engine), **every** positive eigenvector too. That is
`im v_α ⊆ U` in its orthogonal form, and the *nonzero eigenvalue* clause is the
positive-weight hypothesis.
-/

namespace HamiltonsCubic.L30e

open Finset HamiltonsCubic.L30d

variable {ι κ ν : Type*}

/-- **The descent step.** If the two quadratic forms agree, and `u` is
orthogonal to every vector on the right, then it is orthogonal to every vector
on the left. -/
theorem descent_step (s : Finset ι) (t : Finset κ)
    (c : ι → ℚ) (hc : ∀ i ∈ s, 0 < c i) (f : ι → ℚ)
    (d : κ → ℚ) (g : κ → ℚ)
    (hid : ∑ i ∈ s, c i * (f i) ^ 2 = ∑ j ∈ t, d j * (g j) ^ 2)
    (hu : ∀ j ∈ t, g j = 0) :
    ∀ i ∈ s, f i = 0 := by
  have hzero : ∑ j ∈ t, d j * (g j) ^ 2 = 0 := by
    refine Finset.sum_eq_zero fun j hj => ?_
    rw [hu j hj]
    ring
  exact each_zero_of_weighted_sum_sq_zero s c hc f (hid.trans hzero)

/-- Restated as the containment: the span of the negative eigenvectors contains
every other eigenvector's image, since anything orthogonal to the first is
orthogonal to the second. -/
theorem image_subset_of_orthogonal (s : Finset ι) (t : Finset κ)
    (c : ι → ℚ) (hc : ∀ i ∈ s, 0 < c i) (f : ι → ℚ) (d : κ → ℚ) (g : κ → ℚ)
    (hid : ∑ i ∈ s, c i * (f i) ^ 2 = ∑ j ∈ t, d j * (g j) ^ 2) :
    (∀ j ∈ t, g j = 0) → ∀ i ∈ s, f i = 0 :=
  descent_step s t c hc f d g hid

end HamiltonsCubic.L30e
