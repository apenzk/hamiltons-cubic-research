import Mathlib

set_option linter.style.longLine false

/-!
# L217, the value bootstrap at a gapped critical orbit, as arithmetic

[second-order.md](../../../findings/second-order.md)'s Lemma L217. At a critical point `u` of `P` with
value `θ_u > 0` and transverse gap `γ`, a unit `V` orthogonal to `u` and to the orbit tangent, and
`W = c u + s V` at geodesic angle `φ` with `s = sin φ`, `c = cos φ ≥ 0`, the cubic expansion is exact:
`P(W) = θ_u (c³ + 3 c s² α) + s³ P(V)`, with `α = ⟨L_e V, V⟩ ≤ 1/2 - γ`. At a GLOBAL maximiser
`W = W*` of value `m`, every unit `V` has `P(V) ≤ m`. The file proves that these force `m ≤ θ_u`
whenever `s ≤ 3γ` and `s ≤ 1/2`.

* `envelope_le_one`: `c + (1/2 - 3γ) c s² + s³ ≤ 1` on that range, from `c ≤ 1 - s²/2`.
* `tube_value_le`: the bootstrap, `m ≤ θ_u`.
* `balanced_value_eq`: with `θ_u ≤ m`, the value is `θ_u`.
* `exclusion`: with `θ_u < Θ ≤ m`, no such configuration exists.

**Not typed here**: `P`, `𝒲ₙ`, the exact expansion, the first-variation step that makes `V`
orthogonal to the orbit tangent, and the gap itself, which enter as the hypotheses `hexp` and `hα`.
-/

namespace HamiltonsCubic.L217

/-- **`cos φ ≤ 1 - sin² φ / 2`**, in the form the envelope uses. -/
theorem cos_le_one_sub_half_sq {s c : ℝ} (hc0 : 0 ≤ c)
    (hc : c ^ 2 = 1 - s ^ 2) : c ≤ 1 - s ^ 2 / 2 := by
  have h1 : (0 : ℝ) ≤ 1 - s ^ 2 / 2 := by nlinarith
  nlinarith [sq_nonneg (s ^ 2), sq_nonneg (c - (1 - s ^ 2 / 2)), sq_nonneg (c + (1 - s ^ 2 / 2))]

/-- **The envelope is at most `1` on `s ≤ min(3γ, 1/2)`.** -/
theorem envelope_le_one {s c γ : ℝ} (hs0 : 0 ≤ s) (hc0 : 0 ≤ c) (hc : c ^ 2 = 1 - s ^ 2)
    (hγ0 : 0 ≤ γ) (hs : s ≤ 3 * γ) (hshalf : s ≤ 1 / 2) :
    c + (1 / 2 - 3 * γ) * c * s ^ 2 + s ^ 3 ≤ 1 := by
  have hcle : c ≤ 1 - s ^ 2 / 2 := cos_le_one_sub_half_sq hc0 hc
  have hc1 : c ≤ 1 := by nlinarith
  have hs2 : 0 ≤ s ^ 2 := sq_nonneg s
  rcases le_or_gt γ (1 / 6) with hγ | hγ
  · -- the coefficient is nonnegative, so `c ≤ 1` bounds the middle term
    have hcoef : 0 ≤ 1 / 2 - 3 * γ := by linarith
    have hmid : (1 / 2 - 3 * γ) * c * s ^ 2 ≤ (1 / 2 - 3 * γ) * s ^ 2 := by
      have := mul_le_mul_of_nonneg_left hc1 (mul_nonneg hcoef hs2)
      nlinarith [this]
    have hkey : s ^ 3 ≤ 3 * γ * s ^ 2 := by nlinarith [mul_le_mul_of_nonneg_left hs hs2]
    nlinarith [hcle, hmid, hkey]
  · -- the coefficient is negative, so the middle term is at most `0`
    have hmid : (1 / 2 - 3 * γ) * c * s ^ 2 ≤ 0 := by
      have hneg : 1 / 2 - 3 * γ < 0 := by linarith
      have : 0 ≤ c * s ^ 2 := mul_nonneg hc0 hs2
      nlinarith [this, hneg]
    have hkey : s ^ 3 ≤ s ^ 2 / 2 := by nlinarith [mul_le_mul_of_nonneg_left hshalf hs2]
    nlinarith [hcle, hmid, hkey]

/-- **The value bootstrap.** The exact expansion at a gapped critical orbit, the gap, and the global
comparison `P(V) ≤ m` force `m ≤ θ_u` inside the tube `s ≤ min(3γ, 1/2)`. -/
theorem tube_value_le {m θu α g s c γ : ℝ} (hs0 : 0 ≤ s) (hc0 : 0 ≤ c) (hc : c ^ 2 = 1 - s ^ 2)
    (hγ0 : 0 ≤ γ) (hs : s ≤ 3 * γ) (hshalf : s ≤ 1 / 2) (hθ : 0 < θu)
    (hexp : m = θu * (c ^ 3 + 3 * c * s ^ 2 * α) + s ^ 3 * g)
    (hα : α ≤ 1 / 2 - γ) (hg : g ≤ m) : m ≤ θu := by
  have hs2 : 0 ≤ s ^ 2 := sq_nonneg s
  have hs3 : 0 ≤ s ^ 3 := by positivity
  have hs3lt : s ^ 3 < 1 := by nlinarith
  have hstepα : θu * (3 * c * s ^ 2 * α) ≤ θu * (3 * c * s ^ 2 * (1 / 2 - γ)) := by
    have h3 : 0 ≤ 3 * c * s ^ 2 := by positivity
    have := mul_le_mul_of_nonneg_left hα h3
    nlinarith [this, hθ]
  have hstepg : s ^ 3 * g ≤ s ^ 3 * m := mul_le_mul_of_nonneg_left hg hs3
  have hc3 : c ^ 3 = c - c * s ^ 2 := by nlinarith [hc]
  have henv := envelope_le_one hs0 hc0 hc hγ0 hs hshalf
  have hrhs : θu * (c ^ 3 + 3 * c * s ^ 2 * (1 / 2 - γ)) = θu * (c + (1 / 2 - 3 * γ) * c * s ^ 2) := by
    rw [hc3]; ring
  have hmain : m * (1 - s ^ 3) ≤ θu * (1 - s ^ 3) := by
    have h1 : m ≤ θu * (c ^ 3 + 3 * c * s ^ 2 * (1 / 2 - γ)) + s ^ 3 * m := by
      rw [hexp] at hstepg ⊢
      nlinarith [hstepα, hstepg]
    have h2 : θu * (c + (1 / 2 - 3 * γ) * c * s ^ 2) ≤ θu * (1 - s ^ 3) := by
      have := mul_le_mul_of_nonneg_left (by linarith [henv] : c + (1 / 2 - 3 * γ) * c * s ^ 2 ≤ 1 - s ^ 3) hθ.le
      exact this
    nlinarith [h1, h2, hrhs]
  have hpos : 0 < 1 - s ^ 3 := by linarith
  exact le_of_mul_le_mul_right hmain hpos

/-- **At the balanced orbit**, where `θ_u = Θ_n ≤ m`, the maximiser's value is `Θ_n`. -/
theorem balanced_value_eq {m θu α g s c γ : ℝ} (hs0 : 0 ≤ s) (hc0 : 0 ≤ c) (hc : c ^ 2 = 1 - s ^ 2)
    (hγ0 : 0 ≤ γ) (hs : s ≤ 3 * γ) (hshalf : s ≤ 1 / 2) (hθ : 0 < θu)
    (hexp : m = θu * (c ^ 3 + 3 * c * s ^ 2 * α) + s ^ 3 * g)
    (hα : α ≤ 1 / 2 - γ) (hg : g ≤ m) (hlow : θu ≤ m) : m = θu :=
  le_antisymm (tube_value_le hs0 hc0 hc hγ0 hs hshalf hθ hexp hα hg) hlow

/-- **At a sub-maximal gapped orbit**, `θ_u < Θ ≤ m` is impossible inside the tube. -/
theorem exclusion {m θu Θ α g s c γ : ℝ} (hs0 : 0 ≤ s) (hc0 : 0 ≤ c) (hc : c ^ 2 = 1 - s ^ 2)
    (hγ0 : 0 ≤ γ) (hs : s ≤ 3 * γ) (hshalf : s ≤ 1 / 2) (hθ : 0 < θu)
    (hexp : m = θu * (c ^ 3 + 3 * c * s ^ 2 * α) + s ^ 3 * g)
    (hα : α ≤ 1 / 2 - γ) (hg : g ≤ m) (hsub : θu < Θ) (hlow : Θ ≤ m) : False := by
  have := tube_value_le hs0 hc0 hc hγ0 hs hshalf hθ hexp hα hg
  linarith

/-- **The balanced radius at `n = 12`**: `γ = 1/10`, so `sin φ ≤ 3/10`, inside `1/2`. -/
theorem radius_twelve : (3 : ℝ) * (1 / (12 - 2)) = 3 / 10 ∧ (3 : ℝ) / 10 ≤ 1 / 2 := by
  constructor <;> norm_num

/-- **`3γ_n ≤ 1/2` at every `n ≥ 8`**, so the `1/2` cap is inactive at the balanced orbit. -/
theorem three_gamma_le_half {n : ℝ} (hn : 8 ≤ n) : 3 * (1 / (n - 2)) ≤ 1 / 2 := by
  have hpos : 0 < n - 2 := by linarith
  rw [mul_one_div, div_le_div_iff₀ hpos (by norm_num)]
  linarith

/-- A witness that the hypotheses are satisfiable: on the orbit, `s = 0`, `c = 1`, `m = θ_u`. -/
example : (1 : ℝ) = 1 * ((1 : ℝ) ^ 3 + 3 * 1 * (0 : ℝ) ^ 2 * (1 / 2 - 1 / 10)) + (0 : ℝ) ^ 3 * 1 := by
  norm_num

end HamiltonsCubic.L217
