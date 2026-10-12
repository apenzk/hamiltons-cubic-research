import Mathlib
import HamiltonsCubic.Results.L218

set_option linter.style.longLine false

/-!
# L218, the coupling bound, stated through the block decomposition

## The record's statement

[second-order.md](../../../findings/second-order.md)'s Lemma L218: *for unit `D ∈ 𝒟ₙ` and unit `N ⟂ 𝒟ₙ`,
`⟨L_D N, N⟩ ≤ √3/2`, with equality attained on both kinds of block, and `√3/2 < Θₙ` at `n ≥ 5`.*

## What is typed

**The lemma's chain from the block decomposition to the bound, in any real inner product space.**
`coupling_le_of_blocks` proves that when `L` preserves an orthogonal family of summands, so that the
cross terms `inner (L nᵢ) nⱼ` vanish, and every summand's Rayleigh quotient is at most `c`, then
`inner (L n) n ≤ c ‖n‖²` for `n = Σ nᵢ`. With [L218.lean](L218.lean)'s block bounds this is `Λₙ ≤ √3/2`.
*The instantiation enters as hypotheses: [L120](../../../findings/second-order.md)'s decomposition is
`horth` and `hcross`, and [L121](../../../findings/second-order.md)'s and
[L122](../../../findings/second-order.md)'s block formulas are what `hblock` is proved from in L218.lean.*

**Not typed**: `𝒲ₙ`, `L_D` and the identification of its blocks.
-/

namespace HamiltonsCubic.L218Statement

open Finset

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] {β : Type*}

/-- **A block-preserving operator's Rayleigh quotient is at most the largest block's.** -/
theorem coupling_le_of_blocks (L : E →ₗ[ℝ] E) (s : Finset β) (n : β → E) (c : ℝ)
    (horth : ∀ i ∈ s, ∀ j ∈ s, i ≠ j → inner ℝ (n i) (n j) = 0)
    (hcross : ∀ i ∈ s, ∀ j ∈ s, i ≠ j → inner ℝ (L (n i)) (n j) = 0)
    (hblock : ∀ i ∈ s, inner ℝ (L (n i)) (n i) ≤ c * ‖n i‖ ^ 2) :
    inner ℝ (L (∑ i ∈ s, n i)) (∑ i ∈ s, n i) ≤ c * ‖∑ i ∈ s, n i‖ ^ 2 := by
  classical
  have hq : inner ℝ (L (∑ i ∈ s, n i)) (∑ i ∈ s, n i) = ∑ i ∈ s, inner ℝ (L (n i)) (n i) := by
    rw [map_sum, sum_inner]
    refine Finset.sum_congr rfl fun i hi => ?_
    rw [inner_sum]
    rw [Finset.sum_eq_single_of_mem i hi (fun j hj hji => hcross i hi j hj (Ne.symm hji))]
  have hn : ‖∑ i ∈ s, n i‖ ^ 2 = ∑ i ∈ s, ‖n i‖ ^ 2 := by
    rw [← real_inner_self_eq_norm_sq, sum_inner]
    refine Finset.sum_congr rfl fun i hi => ?_
    rw [inner_sum, Finset.sum_eq_single_of_mem i hi (fun j hj hji => horth i hi j hj (Ne.symm hji)),
      real_inner_self_eq_norm_sq]
  rw [hq, hn, Finset.mul_sum]
  exact Finset.sum_le_sum hblock

/-- **The chain with `c = √3/2`, the record's constant.** -/
theorem coupling_le_sqrt3_half (L : E →ₗ[ℝ] E) (s : Finset β) (n : β → E)
    (horth : ∀ i ∈ s, ∀ j ∈ s, i ≠ j → inner ℝ (n i) (n j) = 0)
    (hcross : ∀ i ∈ s, ∀ j ∈ s, i ≠ j → inner ℝ (L (n i)) (n j) = 0)
    (hblock : ∀ i ∈ s, inner ℝ (L (n i)) (n i) ≤ Real.sqrt 3 / 2 * ‖n i‖ ^ 2) :
    inner ℝ (L (∑ i ∈ s, n i)) (∑ i ∈ s, n i) ≤ Real.sqrt 3 / 2 * ‖∑ i ∈ s, n i‖ ^ 2 :=
  coupling_le_of_blocks L s n _ horth hcross hblock

/-- A witness that the hypotheses are satisfiable: the identity on `ℝ` with one block and `c = 1`. -/
example : inner ℝ ((LinearMap.id : ℝ →ₗ[ℝ] ℝ) (∑ i ∈ ({0} : Finset ℕ), (fun _ => (1 : ℝ)) i)) (∑ i ∈ ({0} : Finset ℕ), (fun _ => (1 : ℝ)) i)
    ≤ 1 * ‖∑ i ∈ ({0} : Finset ℕ), (fun _ => (1 : ℝ)) i‖ ^ 2 :=
  coupling_le_of_blocks LinearMap.id {0} (fun _ => (1 : ℝ)) 1
    (by intro i hi j hj hij; simp at hi hj; omega)
    (by intro i hi j hj hij; simp at hi hj; omega)
    (by intro i _; simp)

end HamiltonsCubic.L218Statement
