import Mathlib

/-!
# L30, the descent's engine, in the rank-one case

The descent reads Ricci-flatness as `Σ_α λ_α v_α v_αᵀ = 0` and concludes that
every eigenvector with nonzero eigenvalue has its image inside `U`, the span of
the negative ones' images.

**The step that does the work is elementary once the terms are rank one.**
Splitting by sign, the identity says

`Σ_{λ>0} λ_α v_α v_αᵀ = Σ_{λ<0} |λ_β| v_β v_βᵀ`,

both sides positive semidefinite. A vector killed by the right side is killed by
every term of the left, because a sum of nonnegative terms vanishing forces each
to vanish, and for a rank-one term `c v vᵀ` with `c > 0` that reads
`(v ⬝ᵥ u)² = 0`, hence `v ⬝ᵥ u = 0`.

That is the whole of it: no positive-semidefinite square root, no spectral
theorem, just a sum of squares being zero.
-/

namespace HamiltonsCubic.L30d

open Finset

/-- **A positively-weighted sum of squares vanishes only if each does.** -/
theorem each_zero_of_weighted_sum_sq_zero {ι : Type*} (s : Finset ι)
    (c : ι → ℚ) (hc : ∀ i ∈ s, 0 < c i) (f : ι → ℚ)
    (h : ∑ i ∈ s, c i * (f i) ^ 2 = 0) :
    ∀ i ∈ s, f i = 0 := by
  intro i hi
  have hnonneg : ∀ j ∈ s, 0 ≤ c j * (f j) ^ 2 := fun j hj =>
    mul_nonneg (le_of_lt (hc j hj)) (sq_nonneg _)
  have hall := (Finset.sum_eq_zero_iff_of_nonneg hnonneg).mp h
  have hi' := hall i hi
  have : (f i) ^ 2 = 0 := by
    rcases mul_eq_zero.mp hi' with hc0 | hf
    · exact absurd hc0 (ne_of_gt (hc i hi))
    · exact hf
  exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp this

/-- **So a vector in the kernel of the positive part is orthogonal to every one
of its eigenvectors**, which is the containment the descent needs, with the
`nonzero eigenvalue` clause exactly the `0 < c i` hypothesis. -/
theorem orthogonal_of_kernel {ι : Type*} (s : Finset ι)
    (c : ι → ℚ) (hc : ∀ i ∈ s, 0 < c i) (f : ι → ℚ)
    (h : ∑ i ∈ s, c i * (f i) ^ 2 = 0) (i : ι) (hi : i ∈ s) :
    f i = 0 :=
  each_zero_of_weighted_sum_sq_zero s c hc f h i hi

end HamiltonsCubic.L30d
