import HamiltonsCubic.Base.WeylReal

/-!
# Equal norms and collinearity force a coincidence

**What this is for.** [L183](../../../findings/diagonal-half.md) says a rank-three Weyl tensor is an
orthonormal triple whose images under `Φ(ω) = (ω², ω∧ω)` either all coincide or are distinct and
collinear. *The second branch is empty*, and this file carries the reason, which is elementary and
carries no curvature in it.

**The input is that `Φ` sends the unit sphere of `Λ²` into a sphere**: at every skew `ω`,
`tr(ω⁴) + ‖ω∧ω‖² = 2⟨ω,ω⟩²` in the multi-index-orthonormal norm on `Λ⁴`, so `‖Φ(ω)‖² = 2` at
`‖ω‖ = 1`. *Collinearity is affine and so does not depend on which norm is used to say it; lying on
a sphere does, and the identity names the one that works.*

**The output is that a line meets a sphere twice.** So three points of equal norm on one line have
two of them equal, and L183's distinct branch cannot be inhabited.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.RealLayer

open scoped RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

/-- **Three points of equal norm on one line are not distinct.**

*Written with the collinearity in the form L183 produces it*, `x - z = t • (y - z)`, which is what
`∑ λᵢ Φᵢ = 0` with `∑ λᵢ = 0` and every `λᵢ ≠ 0` gives after eliminating one weight. -/
theorem eq_of_collinear_of_norm_eq (x y z : E) (t : ℝ)
    (hxz : x - z = t • (y - z))
    (hxy : ‖x‖ = ‖y‖) (hyz : ‖y‖ = ‖z‖) :
    x = z ∨ x = y ∨ y = z := by
  have hx : x = z + t • (y - z) := by
    have := sub_eq_iff_eq_add.mp hxz
    simpa [add_comm] using this
  -- `‖z + s • (y - z)‖²` is a quadratic in `s`; equal norms at `s = 0, 1, t` pin it.
  have key : ∀ s : ℝ, ‖z + s • (y - z)‖ ^ 2
      = ‖z‖ ^ 2 + 2 * s * ⟪z, y - z⟫ + s ^ 2 * ‖y - z‖ ^ 2 := by
    intro s
    rw [norm_add_sq_real, real_inner_smul_right, norm_smul, Real.norm_eq_abs,
      mul_pow, sq_abs]
    ring
  have h1 : ‖z + (1 : ℝ) • (y - z)‖ ^ 2 = ‖z‖ ^ 2 := by
    simp only [one_smul, add_sub_cancel]
    rw [hyz]
  have ht : ‖z + t • (y - z)‖ ^ 2 = ‖z‖ ^ 2 := by
    rw [← hx, ← hyz, ← hxy]
  rw [key] at h1 ht
  norm_num at h1
  have e1 : 2 * ⟪z, y - z⟫ + ‖y - z‖ ^ 2 = 0 := by linarith
  have h3 : 2 * ⟪z, y - z⟫ = - ‖y - z‖ ^ 2 := by linarith
  have e2 : t * (t - 1) * ‖y - z‖ ^ 2 = 0 := by
    calc t * (t - 1) * ‖y - z‖ ^ 2
        = t ^ 2 * ‖y - z‖ ^ 2 + t * (- ‖y - z‖ ^ 2) := by ring
      _ = t ^ 2 * ‖y - z‖ ^ 2 + t * (2 * ⟪z, y - z⟫) := by rw [h3]
      _ = 0 := by linarith
  rcases mul_eq_zero.mp e2 with h | h
  · rcases mul_eq_zero.mp h with h0 | h1'
    · left; rw [hx, h0, zero_smul, add_zero]
    · right; left
      have : t = 1 := by linarith [sub_eq_zero.mp h1']
      rw [hx, this, one_smul, add_sub_cancel]
  · right; right
    have : ‖y - z‖ = 0 := by
      have := pow_eq_zero_iff (n := 2) (by norm_num) |>.mp h
      exact this
    exact sub_eq_zero.mp (norm_eq_zero.mp this)

end HamiltonsCubic.RealLayer
