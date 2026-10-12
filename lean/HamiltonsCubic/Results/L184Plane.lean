import Mathlib

set_option linter.style.longLine false

/-!
# L184's two linear-algebra steps

[diagonal-half.md](../../../findings/diagonal-half.md), Lemma L184: *"Each `ω_i` commutes with `ω_i²`, hence preserves
every eigenspace of `A`"*, and case 1's *"a skew map on a plane is a multiple of its area form"*.

- **`preserves_eigenspace_neg_sq`**: if `A = −ω²` has `A x = μ x`, then `A (ω x) = μ (ω x)`;
- **`skew_on_plane`**: a skew `ω` preserving the span of an orthonormal pair `u, v` acts there as `c` times the area form,
  `ω u = c v` and `ω v = −c u` with `c = ⟨v, ω u⟩`.

The third step the row owed, `⋆_V(J ∧ J) = 2ε_J J` on `ℝ⁶`, is [I67PfSign.lean](I67PfSign.lean)'s
`starWedgeIdentity_holds`.
-/

namespace HamiltonsCubic.L184Plane

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

/-- **A map preserves every eigenspace of its square**: if `A = −ω²` has `A x = μ x`, then `A (ω x) = μ (ω x)`. -/
theorem preserves_eigenspace_neg_sq (ω : E →ₗ[ℝ] E) {μ : ℝ} {x : E} (hx : -(ω (ω x)) = μ • x) :
    -(ω (ω (ω x))) = μ • ω x := by
  rw [← map_neg, hx, map_smul]

/-- **A skew map preserving a plane is a multiple of its area form there**: for `u, v` orthonormal with `ω u, ω v` in
their span, `ω u = c v` and `ω v = −c u` with `c = ⟨v, ω u⟩`. -/
theorem skew_on_plane (ω : E →ₗ[ℝ] E) (hω : ∀ x y, inner ℝ (ω x) y = -inner ℝ x (ω y)) {u v : E}
    (hu : ‖u‖ = 1) (hv : ‖v‖ = 1) (huv : inner ℝ u v = 0)
    (hωu : ω u ∈ Submodule.span ℝ {u, v}) (hωv : ω v ∈ Submodule.span ℝ {u, v}) :
    ω u = inner ℝ v (ω u) • v ∧ ω v = -inner ℝ v (ω u) • u := by
  have hvu : inner ℝ v u = 0 := by rw [real_inner_comm]; exact huv
  obtain ⟨α, β, hab⟩ := Submodule.mem_span_pair.mp hωu
  obtain ⟨γ, δ, hgd⟩ := Submodule.mem_span_pair.mp hωv
  have e1 : inner ℝ u (ω u) = α := by rw [← hab]; simp [inner_add_right, real_inner_smul_right, huv, hu]
  have e2 : inner ℝ v (ω u) = β := by rw [← hab]; simp [inner_add_right, real_inner_smul_right, hvu, hv]
  have e3 : inner ℝ u (ω v) = γ := by rw [← hgd]; simp [inner_add_right, real_inner_smul_right, huv, hu]
  have e4 : inner ℝ v (ω v) = δ := by rw [← hgd]; simp [inner_add_right, real_inner_smul_right, hvu, hv]
  have s1 : inner ℝ u (ω u) = 0 := by have := hω u u; rw [real_inner_comm] at this; linarith
  have s2 : inner ℝ v (ω v) = 0 := by have := hω v v; rw [real_inner_comm] at this; linarith
  have s3 : inner ℝ u (ω v) = -inner ℝ v (ω u) := by
    have h1 := hω u v
    have h2 : inner ℝ (ω u) v = inner ℝ v (ω u) := real_inner_comm _ _
    linarith
  have ha0 : α = 0 := by rw [← e1]; exact s1
  have hd0 : δ = 0 := by rw [← e4]; exact s2
  constructor
  · calc ω u = α • u + β • v := hab.symm
      _ = inner ℝ v (ω u) • v := by rw [ha0, zero_smul, zero_add, e2]
  · calc ω v = γ • u + δ • v := hgd.symm
      _ = -inner ℝ v (ω u) • u := by rw [hd0, zero_smul, add_zero, ← s3, e3]

end HamiltonsCubic.L184Plane
