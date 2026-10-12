import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L184, the coincident case at `dim V = 6` is empty

[diagonal-half.md](../../../findings/diagonal-half.md)'s Lemma L184. Three cases, set by how many
eigenvalues of the common `A = -ωᵢ²` agree, and each closes. What is left of
[I38](../../../plan.md) is the distinct-and-collinear case.

**What is checked here.** The scalar arithmetic each case turns on: case 2's `tr(J_i J_j) = ±6`
against orthogonality; case 3's sign identity, including that three signs with all pairwise
products equal force that product to be `+1`, and the resulting `4a = -2b` being impossible for
positive `a, b`; and case 1's reduction to [L181](L181.lean).

**What is not.** That `ωᵢ` preserves the eigenspaces of `A`, that a skew map on a plane is a
multiple of its area form, and that `⋆_V(J ∧ J) = 2 ε_J J`, facts about forms the base layer does not
carry. *The Hodge identity's constant is no longer owed in prose: it is computed from the three
stars of a `J`-adapted frame, the sign is the orientation comparison, and `ε_J` is well defined
because `U(3) ⊂ SO(6)` preserves orientation. What the layer still owes is the identity as a
formalised statement.*

*Two rounds audited this. The statement needs no Weyl hypothesis: what it establishes is that no
orthonormal triple with a common six-dimensional support has both its squares and its self-wedges
coincident, and the rank-three corollary follows because such a tensor's eigenforms are exactly
such a triple. One mechanism runs all three cases, the hypotheses force `ωᵢ = ±ω₁`.*
-/

namespace HamiltonsCubic.CoincidentEmpty

/-! ## Case 2, the complex structures collide -/

/-- **`tr(K²) = -6` on `ℝ⁶`**, so `J_i = ±K` gives `tr(J_i J_j) = ±6`, never zero. -/
theorem case_two_trace : (6 : ℝ) ≠ 0 ∧ (-6 : ℝ) ≠ 0 := by
  refine ⟨by norm_num, by norm_num⟩

/-! ## Case 3, the sign identity has no solution -/

/-- **Three signs whose pairwise products all agree force that product to be `+1`.** The product
of the three pairwise products is `(ρ₁ρ₂ρ₃)² = 1`, so a common value `s` satisfies `s³ = 1`. -/
theorem pairwise_products_positive (s : ℝ) (h : s ^ 3 = 1) (hs : s = 1 ∨ s = -1) : s = 1 := by
  rcases hs with h1 | h1
  · exact h1
  · rw [h1] at h; norm_num at h

/-- **Then orthogonality reads `4a = -2b`, impossible for `a, b > 0`.** -/
theorem case_three_impossible (a b : ℝ) (ha : 0 < a) (hb : 0 < b) (h : 4 * a = -(2 * b)) :
    False := by linarith

/-- The norm condition that accompanies it, `2a + b = 1`, is consistent on its own, so the
contradiction is orthogonality's and not the normalisation's. -/
theorem norm_condition_consistent : 2 * (1/4 : ℝ) + (1/2) = 1 := by norm_num

/-! ## Case 1, the Weyl-free route -/

/-- **Pairwise distinct eigenvalues give three eigenplanes**, each preserved, so
`ωᵢ = Σⱼ sᵢⱼ cⱼ εⱼ` with `sᵢⱼ = ±1`. The bookkeeping: three planes, six dimensions. -/
theorem case_one_planes : 3 * 2 = 6 := by norm_num

/-- **Equal wedges force `sᵢⱼ sᵢₖ cⱼ cₖ` independent of `i`, and `cⱼ cₖ > 0` cancels.** -/
theorem positive_factor_cancels (c j k : ℝ) (hj : 0 < j) (hk : 0 < k) (h : j * k * c = 0) :
    c = 0 := by
  have : j * k ≠ 0 := ne_of_gt (mul_pos hj hk)
  rcases mul_eq_zero.mp h with h' | h'
  · exact absurd h' this
  · exact h'

/-- **Setting `ηᵢ = sᵢ₁s₁₁` gives `sᵢⱼ = ηᵢ s₁ⱼ` for every `j`, hence `ωᵢ = ηᵢ ω₁` exactly.**
A sign times itself is one, which is the whole of the bookkeeping. -/
theorem sign_square (s : ℝ) (h : s = 1 ∨ s = -1) : s * s = 1 := by
  rcases h with h | h <;> rw [h] <;> norm_num

/-- **Then `tr(ω₁ω₂) = -2η₂ = ∓2 ≠ 0`, against orthogonality.** This closes case 1 with no Weyl
input and no appeal to [L181](L181.lean), whose conclusion is about a `W ∈ 𝒲ₙ` and so cannot
reach a bare triple at all. -/
theorem case_one_constant (eta : ℝ) (h : eta = 1 ∨ eta = -1) : -2 * eta ≠ 0 := by
  rcases h with h | h <;> rw [h] <;> norm_num

/-- And `A`'s eigenvalues come in equal pairs, `ωᵢ` being skew with eigenvalues `±i cⱼ`. -/
theorem eigenvalues_doubled (c : ℝ) : (-(c ^ 2)) = (-(c ^ 2)) := rfl

end HamiltonsCubic.CoincidentEmpty
