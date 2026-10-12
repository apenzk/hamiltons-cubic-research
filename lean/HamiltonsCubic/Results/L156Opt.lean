import Mathlib

/-!
# L156: the contour optimum is the equidistant contour

[findings/second-order.md](../../../findings/second-order.md), Lemma L156: with
`D = (2m-1)/(m-1)` and `d = min(α, D-α)`, on `0 < α < D`, `0 < γ < min(d, 1)`, the constant is
`C(α, γ) = α(1+α)/(d(d-γ))`, the objective is `J = C/γ`, and *"its minimum is interior and
attained at `α* = D/2`, `γ* = D/4`"*, with `J* = 4(1+α*)/α*²`. [L156.lean](L156.lean) checks the four constants
against each other; this file proves the minimisation, which the row owes.

* `J_ge`: `J(D/2, D/4) ≤ J(α, γ)` on the whole domain, at every `D > 0`. For fixed `α`,
  `γ(d-γ) ≤ d²/4` gives `J ≥ 4α(1+α)/d³`; below the kink `d = α` and `4(1+α)/α²` decreases to
  `α = D/2`, above it `d = D-α` and `4α(1+α)/(D-α)³` increases from there.
* `J_star`: `J(D/2, D/4) = 4(1+α*)/α*²` with `α* = D/2`.
* `star_mem`: `(D/2, D/4)` lies in the domain, `γ* < min(d*, 1)`, once `D < 4`.
* `L156_opt`: at `D = (2m-1)/(m-1)`, `m ≥ 2`, the minimum of `J` over the domain is attained at
  `(D/2, D/4)` with value `4(1+α*)/α*²`.
-/

namespace HamiltonsCubic.L156Opt

/-- `d = min(α, D - α)`, the distance of the contour to the nearer eigenvalue, in units of `g_n`. -/
noncomputable def dmin (D α : ℝ) : ℝ := min α (D - α)

/-- The objective `J = C/γ`, `C = α(1+α)/(d(d-γ))`. -/
noncomputable def J (D α γ : ℝ) : ℝ := α * (1 + α) / (dmin D α * (dmin D α - γ)) / γ

/-- **The objective at the optimum**: `J(D/2, D/4) = 4(1+α*)/α*²`, `α* = D/2`. -/
theorem J_star {D : ℝ} (hD : 0 < D) : J D (D / 2) (D / 4) = 4 * (1 + D / 2) / (D / 2) ^ 2 := by
  have hd : dmin D (D / 2) = D / 2 := by unfold dmin; rw [min_eq_left (by linarith)]
  unfold J
  rw [hd]
  field_simp
  ring

/-- **The minimum**: `J(D/2, D/4) ≤ J(α, γ)` on `0 < α < D`, `0 < γ < d`. -/
theorem J_ge {D α γ : ℝ} (hD : 0 < D) (hα : 0 < α) (hαD : α < D) (hγ : 0 < γ)
    (hγd : γ < dmin D α) : J D (D / 2) (D / 4) ≤ J D α γ := by
  rw [J_star hD]
  set a := D / 2 with ha
  have ha0 : 0 < a := by linarith
  set d := dmin D α with hd
  have hd0 : 0 < d := by
    rw [hd]; unfold dmin; exact lt_min hα (by linarith)
  have hdg : 0 < d - γ := by linarith
  -- `γ(d - γ) ≤ d²/4`, so `J ≥ 4α(1+α)/d³`
  have hstep : 4 * α * (1 + α) / d ^ 3 ≤ J D α γ := by
    unfold J
    rw [← hd, div_div, div_le_div_iff₀ (by positivity) (by positivity)]
    have h1 : γ * (d - γ) ≤ d ^ 2 / 4 := by nlinarith [sq_nonneg (d - 2 * γ)]
    have hp : 0 < α * (1 + α) := by positivity
    nlinarith [mul_le_mul_of_nonneg_left h1 hp.le, hd0]
  refine le_trans ?_ hstep
  rcases le_total α a with hle | hge
  · -- below the kink, `d = α`
    have hdα : d = α := by rw [hd]; unfold dmin; exact min_eq_left (by linarith)
    rw [hdα, div_le_div_iff₀ (by positivity) (by positivity)]
    have key : 0 ≤ (a - α) * (a + α + α * a) := mul_nonneg (by linarith) (by positivity)
    nlinarith [key, pow_pos hα 3, pow_pos ha0 2]
  · -- above the kink, `d = D - α ≤ a`
    have hdα : d = D - α := by rw [hd]; unfold dmin; exact min_eq_right (by linarith)
    have hda : d ≤ a := by rw [hdα]; linarith
    rw [div_le_div_iff₀ (by positivity) (by positivity)]
    have hnum : a * (1 + a) ≤ α * (1 + α) := by nlinarith
    have hd3 : d ^ 3 ≤ a ^ 3 := by
      exact pow_le_pow_left₀ hd0.le hda 3
    have e : 4 * (1 + a) * d ^ 3 = 4 * (a * (1 + a)) * (d ^ 3 / a) := by
      field_simp
    nlinarith [mul_le_mul hnum hd3 (by positivity) (by positivity), pow_pos hd0 3, pow_pos ha0 2,
      pow_pos ha0 3]

/-- **The optimum lies in the domain** once `D < 4`: `0 < D/4 < min(D/2, 1)`. -/
theorem star_mem {D : ℝ} (hD : 0 < D) (hD4 : D < 4) :
    0 < D / 2 ∧ D / 2 < D ∧ 0 < D / 4 ∧ D / 4 < dmin D (D / 2) ∧ D / 4 < 1 := by
  have hd : dmin D (D / 2) = D / 2 := by unfold dmin; rw [min_eq_left (by linarith)]
  refine ⟨by linarith, by linarith, by linarith, by rw [hd]; linarith, by linarith⟩

/-- **L156's optimum.** At `D = (2m-1)/(m-1)`, `m ≥ 2`, `J` attains its minimum over the domain
at the equidistant contour `(D/2, D/4)`, with value `4(1+α*)/α*²`. -/
theorem L156_opt {m : ℝ} (hm : 2 ≤ m) :
    let D := (2 * m - 1) / (m - 1)
    (0 < D / 4 ∧ D / 4 < min (dmin D (D / 2)) 1) ∧
      J D (D / 2) (D / 4) = 4 * (1 + D / 2) / (D / 2) ^ 2 ∧
      ∀ α γ, 0 < α → α < D → 0 < γ → γ < min (dmin D α) 1 → J D (D / 2) (D / 4) ≤ J D α γ := by
  intro D
  have hm1 : 0 < m - 1 := by linarith
  have hD : 0 < D := div_pos (by linarith) hm1
  have hD4 : D < 4 := by
    rw [div_lt_iff₀ hm1]; linarith
  obtain ⟨-, -, h3, h4, h5⟩ := star_mem hD hD4
  refine ⟨⟨h3, lt_min h4 h5⟩, J_star hD, fun α γ hα hαD hγ hγd => ?_⟩
  exact J_ge hD hα hαD hγ (lt_of_lt_of_le hγd (min_le_left _ _))

end HamiltonsCubic.L156Opt
