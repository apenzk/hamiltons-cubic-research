import HamiltonsCubic.Results.L135
import HamiltonsCubic.Base.Families

/-!
# L134, the competitor-side margin, against L135's candidate `5/36`

[route-a.md](../../../findings/route-a.md)'s Lemma L134 reduces I3 to one bound on the defect,
`c₂ ≤ θ*/(2|κₙ|)` with `θ* = √(3/2)` and `|κₙ| = 9(Θₙ − θ*)`, and names `c₂ ≤ 5/36` as the candidate
that would close it; [L135](L135.lean) shows the candidate is exactly `Δ₂ ≤ 1/4`.

**The candidate is strictly stronger than the target at every `n ≥ 12`, so the two are different statements.**
Were they one, `θ*/(2|κ|) = 5/36` would pin `|κ| = 18θ*/5` (`kappa_pinned`), hence `Θ = 7θ*/5` and
`Θ² = 147/50` (`pinned_needs`). But `Θₙ² < 2` at both parities (`theta0Sq_lt_two`, `ThetaSqOdd_lt_two`),
so the pinning fails (`pinning_fails`), and at every `Θ ∈ (θ*, √2)`, which is `n ≥ 12`, the target sits strictly above the
candidate (`candidate_strict`): **`c₂ ≤ 5/36` implies I3's bound with room** (`candidate_implies_target`).
-/

namespace HamiltonsCubic.CompetitorMargin

open HamiltonsCubic.TargetTranslation

/-! ## What agreement would pin -/

/-- **`θ*/(2|κ|) = 5/36` forces `|κ| = 18θ*/5`.** -/
theorem kappa_pinned {θ κ : ℝ} (hκ : 0 < κ) (h : θ / (2 * κ) = 5 / 36) :
    κ = 18 * θ / 5 := by
  field_simp at h
  linarith [h]

/-- **So `|κ|² = 486/25`**, with `θ*² = 3/2`. -/
theorem kappa_sq : (18 : ℚ) ^ 2 / 5 ^ 2 * (3 / 2) = 486 / 25 := by norm_num

/-- **The pinning needs `Θ² = 147/50`**: `9(Θ − θ*) = 18θ*/5` is `Θ = 7θ*/5`. -/
theorem pinned_needs {t Θ : ℝ} (ht : t ^ 2 = 3 / 2) (h : 9 * (Θ - t) = 18 * t / 5) :
    Θ ^ 2 = 147 / 50 := by
  have : Θ = 7 * t / 5 := by linarith
  rw [this]; nlinarith [ht]

/-! ## `Θₙ² < 2` at both parities -/

theorem theta0Sq_lt_two {n : ℝ} (hn : 1 ≤ n) : HamiltonsCubic.FamilyLayer.theta0Sq n < 2 := by
  unfold HamiltonsCubic.FamilyLayer.theta0Sq
  rw [div_lt_iff₀ (by positivity)]; nlinarith

theorem ThetaSqOdd_lt_two {n : ℝ} (hn : 3 ≤ n) : HamiltonsCubic.FamilyLayer.ThetaSqOdd n < 2 := by
  unfold HamiltonsCubic.FamilyLayer.ThetaSqOdd
  rw [div_lt_iff₀ (by nlinarith)]; nlinarith

/-! ## So the pinning fails, and the candidate implies the target with room -/

/-- **The pinning fails at every `Θ` with `Θ² < 2`.** -/
theorem pinning_fails {t Θ : ℝ} (ht : t ^ 2 = 3 / 2) (hΘ : Θ ^ 2 < 2) : 9 * (Θ - t) ≠ 18 * t / 5 := by
  intro h; have := pinned_needs ht h; linarith

/-- **At every `Θ ∈ (θ*, √2)` the target `θ*/(2|κ|)` is strictly above `5/36`.** -/
theorem candidate_strict {t Θ : ℝ} (ht0 : 0 < t) (ht : t ^ 2 = 3 / 2) (hlo : t < Θ) (hΘ : Θ ^ 2 < 2) :
    5 / 36 < t / (2 * (9 * (Θ - t))) := by
  have hk : 0 < Θ - t := by linarith
  rw [lt_div_iff₀ (by positivity)]
  -- `Θ < 7t/5`, since `(7t/5)² = 147/50 > 2 > Θ²`
  have h7 : Θ < 7 * t / 5 := by nlinarith
  nlinarith

/-- **`c₂ ≤ 5/36` implies I3's bound `c₂ ≤ θ*/(2|κₙ|)`, strictly.** -/
theorem candidate_implies_target {c t Θ : ℝ} (ht0 : 0 < t) (ht : t ^ 2 = 3 / 2) (hlo : t < Θ)
    (hΘ : Θ ^ 2 < 2) (h : c ≤ 5 / 36) : c < t / (2 * (9 * (Θ - t))) :=
  lt_of_le_of_lt h (candidate_strict ht0 ht hlo hΘ)

/-! ## The Hessian margin -/

/-- The margin `-θ*/2` is half the competitor value, and `L20`'s gap is a third of it, so the
Hessian reading multiplies the gap by `3/2`. -/
theorem gap_to_hessian (θ : ℚ) : (θ / 2) / (θ / 3) = 3 / 2 ∨ θ = 0 := by
  by_cases h : θ = 0
  · exact Or.inr h
  · left
    field_simp

end HamiltonsCubic.CompetitorMargin
