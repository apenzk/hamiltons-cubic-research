import Mathlib

set_option linter.style.longLine false

/-!
# I113 (b): the finite-reflection identity, for any symmetric cubic and any subalgebra split

**The outside archive's restriction identity and its sign, stated for an arbitrary symmetric
trilinear form.** *Let `W = D + N` with `D` the orthogonal projection of a unit critical `W` onto a
subspace `S` closed under the quadratic map, `Q(S) ⊆ S`, so `T(D,D,N) = ⟨Q(D),N⟩ = 0`.* Then
`2 P(D) = P(N) + λ (3 |D|² - 1)`, and `P(D + N) - P(D - N) = 2 P(N)`, so at a global maximiser, where
`D - N` is again a unit vector, `P(N) ≥ 0`.

**The hypothesis that carries it is `T D D N = 0`**, which is where the subalgebra enters: the
zero-extended `Weyl_{n-1}` of a hyperplane and the coordinate-diagonal locus of ANY orthonormal frame
both qualify, the latter being the archive's own `D`. *A split along a subspace that is not closed under
`Q` does not give it.*
-/

namespace HamiltonsCubic.Results

variable {V : Type*} [AddCommGroup V] [Module ℝ V]

/-- **The restriction identity**, `2 P(D) = P(N) + λ(3|D|² - 1)`. -/
theorem reflection_restriction (T : V →ₗ[ℝ] V →ₗ[ℝ] V →ₗ[ℝ] ℝ) (B : V →ₗ[ℝ] V →ₗ[ℝ] ℝ)
    (hT12 : ∀ x y z, T x y z = T y x z) (hT23 : ∀ x y z, T x y z = T x z y)
    (hB : ∀ x y, B x y = B y x)
    {D N : V} {lam : ℝ}
    (hcrit : ∀ X, T (D + N) (D + N) X = lam * B (D + N) X)
    (hunit : B (D + N) (D + N) = 1) (horth : B D N = 0) (hsub : T D D N = 0) :
    2 * T D D D = T N N N + lam * (3 * B D D - 1) := by
  have h1 := hcrit (D + N)
  have h2 := hcrit D
  simp only [map_add, LinearMap.add_apply] at h1 h2 hunit
  have e1 : T D N D = 0 := by rw [hT23]; exact hsub
  have e2 : T N D D = 0 := by rw [hT12, hT23]; exact hsub
  have e3 : T N D N = T D N N := by rw [hT12]
  have e4 : T N N D = T D N N := by rw [hT12, hT23, hT12]
  have e5 : B N D = 0 := by rw [hB]; exact horth
  simp only [e1, e2, e3, e4, hsub, horth, e5, add_zero, zero_add] at h1 h2 hunit
  linear_combination (-1 : ℝ) * h1 + 3 * h2 - lam * hunit

/-- **The sign**: the reflection `D + N ↦ D - N` changes the cubic by `2 P(N)`. -/
theorem reflection_difference (T : V →ₗ[ℝ] V →ₗ[ℝ] V →ₗ[ℝ] ℝ)
    (hT12 : ∀ x y z, T x y z = T y x z) (hT23 : ∀ x y z, T x y z = T x z y)
    {D N : V} (hsub : T D D N = 0) :
    T (D + N) (D + N) (D + N) - T (D - N) (D - N) (D - N) = 2 * T N N N := by
  simp only [map_add, map_sub, LinearMap.add_apply, LinearMap.sub_apply]
  have e1 : T D N D = 0 := by rw [hT23]; exact hsub
  have e2 : T N D D = 0 := by rw [hT12, hT23]; exact hsub
  have e3 : T N D N = T D N N := by rw [hT12]
  have e4 : T N N D = T D N N := by rw [hT12, hT23, hT12]
  rw [e1, e2, e3, e4, hsub]
  ring

end HamiltonsCubic.Results
