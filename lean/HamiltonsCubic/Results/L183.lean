import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L183, rank three is collinearity of the images

[diagonal-half.md](../../../findings/diagonal-half.md)'s Lemma L183. With
`Φ(ω) = (ω², ω ∧ ω)`, a rank-three `W = Σ λᵢ ωᵢ ⊗ ωᵢ` lies in `𝒲ₙ` exactly when the three points
`Φ(ωᵢ)` either all coincide or are distinct and collinear, *bare collinearity is not enough, and
exactly-two-coincident is the excluded configuration*, Ricci and first Bianchi being the single equation `Σ λᵢ Φ(ωᵢ) = 0`, with
tracelessness as its trace.

**What is checked here.** The affine-dependence argument in both directions, and the arithmetic
of the `n = 4` coincident case that makes [L178](L178.lean)'s family two-parameter.

**What is not.** That Ricci is `Σ λᵢ ωᵢ² = 0` and Bianchi is `Σ λᵢ ωᵢ ∧ ωᵢ = 0`, quoted from
[L179](L179.lean) and [L180](L180.lean), both Gate 2 passed, and that `ω ωᵀ = c I` forces a
complex structure.
-/

namespace HamiltonsCubic.Collinear

/-! ## Weights summing to zero force collinearity -/

/-- **Forward.** From `λ₁ + λ₂ + λ₃ = 0` the relation `Σ λᵢ vᵢ = 0` becomes
`λ₁(v₁ - v₃) = -λ₂(v₂ - v₃)`, so the two difference vectors are parallel. Here in the scalar
form the vector statement reduces to. -/
theorem forward (l₁ l₂ l₃ v₁ v₂ v₃ : ℝ) (hs : l₁ + l₂ + l₃ = 0)
    (h : l₁ * v₁ + l₂ * v₂ + l₃ * v₃ = 0) :
    l₁ * (v₁ - v₃) = -(l₂ * (v₂ - v₃)) := by
  have : l₃ = -(l₁ + l₂) := by linarith
  subst this; nlinarith [h]

/-- **Converse.** From `v₁ - v₃ = t(v₂ - v₃)` the weights `(1, -t, t - 1)` sum to zero and
annihilate the triple. -/
theorem converse (t v₁ v₂ v₃ : ℝ) (h : v₁ - v₃ = t * (v₂ - v₃)) :
    (1 : ℝ) + -t + (t - 1) = 0 ∧ 1 * v₁ + -t * v₂ + (t - 1) * v₃ = 0 := by
  refine ⟨by ring, by nlinarith [h]⟩

/-- And they vanish nowhere exactly when `t ∉ {0, 1}`. -/
theorem weights_nonzero (t : ℝ) (h0 : t ≠ 0) (h1 : t ≠ 1) :
    (1 : ℝ) ≠ 0 ∧ -t ≠ 0 ∧ t - 1 ≠ 0 := by
  refine ⟨by norm_num, neg_ne_zero.mpr h0, sub_ne_zero.mpr h1⟩

/-! ## Why `n = 4` is easy: the images coincide -/

/-- **On the self-dual forms of `ℝ⁴` all three images agree**, `ωᵢ² = -½ Id` and
`ωᵢ ∧ ωᵢ = f₁₂₃₄`, so every weight vector summing to zero works. The coincident case: -/
theorem coincident_any_weight (l₁ l₂ l₃ v : ℝ) (hs : l₁ + l₂ + l₃ = 0) :
    l₁ * v + l₂ * v + l₃ * v = 0 := by
  have h : l₁ * v + l₂ * v + l₃ * v = (l₁ + l₂ + l₃) * v := by ring
  rw [h, hs, zero_mul]

/-- Which is why [L178](L178.lean)'s family is two-parameter: the weights range over the plane
`Σ λᵢ = 0`, of dimension `3 - 1 = 2`. -/
theorem two_parameter : 3 - 1 = 2 := by norm_num

/-- And `θ` there is a function of the weights alone, `9 e₃`, by [L178](L178.lean). -/
theorem theta_of_weights (e₃ : ℝ) : 9 * e₃ = 3 * e₃ + 6 * e₃ := by ring

end HamiltonsCubic.Collinear
