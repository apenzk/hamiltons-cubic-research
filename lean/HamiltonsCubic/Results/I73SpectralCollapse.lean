import Mathlib

set_option linter.style.longLine false

/-!
# The sum over an eigenbasis collapses, so the pair direction's `#` term is BASIS-FREE

[L233](../../../findings/second-order.md) was first written with its `#` term as a sum over `W`'s
own eigenbasis, `∑ γ, ε γ * ⟪ψ γ, [u,v]⟫ ^ 2`, together with a warning that the basis is not
arbitrary. **Gate 2 found the warning correct and the presentation wrong**: the sum is
`⟪[u,v], e [u,v]⟫`, which mentions no basis at all.

**THIS FILE PROVES THE COLLAPSE, AND IT NEEDS NO SPECTRAL THEOREM.** *Writing the symmetric
operator as `V * D * Vᵀ` with `D` diagonal is what an eigenbasis GIVES you, and once it is written
that way the identity is `dotProduct` algebra.* So the statement below quantifies over any `V` and
any diagonal `D` whatever, and the eigen-hypotheses are consumed by whoever supplies them.

*The consequence for the layer is that the `Lean: blocked` trailer on L233's commit was wrong: it
said the sum needed a basis of `Λ²` at general `n` to be written in, and the sum does not need to
be written at all.*
-/

namespace HamiltonsCubic.Results

open Matrix

variable {N : Type*} [Fintype N] [DecidableEq N]

/-- **THE COLLAPSE.** For any `V`, any weights `d`, and any vector `c`,

`c ⬝ (V * diagonal d * Vᵀ) c = ∑ γ, d γ * ((Vᵀ c) γ)²`.

*Read with `V`'s columns an orthonormal eigenbasis and `d` the eigenvalues, the right side is
`∑ γ, ε γ * ⟪ψ γ, c⟫²` and the left is `⟪c, e c⟫`. No orthogonality is needed for the identity
itself: it is needed only to say that the left side is the operator one means.* -/
theorem dotProduct_conj_diagonal (V : Matrix N N ℝ) (d : N → ℝ) (c : N → ℝ) :
    c ⬝ᵥ ((V * diagonal d * Vᵀ) *ᵥ c) = ∑ γ, d γ * ((Vᵀ *ᵥ c) γ) ^ 2 := by
  have hmv : (V * diagonal d * Vᵀ) *ᵥ c = V *ᵥ (diagonal d *ᵥ (Vᵀ *ᵥ c)) := by
    rw [mulVec_mulVec, mulVec_mulVec]
  rw [hmv, dotProduct_mulVec, ← mulVec_transpose]
  simp only [dotProduct, mulVec_diagonal]
  exact Finset.sum_congr rfl fun γ _ => by ring

/-- **THE SAME STATEMENT WITH THE EIGEN-HYPOTHESES MADE EXPLICIT**, which is the form L233 uses.

Given an orthogonal `V` whose columns are eigenvectors of `e` at eigenvalues `d`, the sum over
that eigenbasis of `d γ * ⟪ψ γ, c⟫ ^ 2` is `⟪c, e c⟫`.

*`hV` is what makes `V * diagonal d * Vᵀ` equal `e`; the collapse itself is the lemma above.* -/
theorem sum_eigen_sq_eq_quadForm {e V : Matrix N N ℝ} {d c : N → ℝ}
    (hV : e = V * diagonal d * Vᵀ) :
    ∑ γ, d γ * ((Vᵀ *ᵥ c) γ) ^ 2 = c ⬝ᵥ (e *ᵥ c) := by
  rw [hV, dotProduct_conj_diagonal]

end HamiltonsCubic.Results
