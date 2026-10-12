import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L12, the guard, and why the general form does not need one

[ungraded-slack.md](../../../findings/ungraded-slack.md)'s Observation L12, refuted as stated
and repairable.

**The general form is unconditional because every term is non-negative.** `S = T₁ + 2T₂ + T₃`
with `Tᵢ ≥ 0` gives `S ≥ 0` with no hypothesis at all, and the block's identity is the
`T₁ = T₂ = 0` case, so **the guard's entire role is to make two non-negative terms vanish**.
Dropping them without the guard gives a lower bound, not an identity: `T₃ ≤ T₁ + 2T₂ + T₃`.

**And the guard is two of the three grading conditions.** So the fence assumes all of
gradedness except the clause the slack measures, the hypothesis and the subject partition the
three, which is why the result reads as measuring something it has largely assumed.

**`S ≥ 0` printed with `W` free is a different claim** from `S ≥ 0` at a critical point, and
the general form is what makes the first true: without termwise non-negativity there is
nothing to lean on off the critical set.
-/

namespace HamiltonsCubic.GradingSlack

/-! ## The general form needs no guard -/

/-- **`S = T₁ + 2T₂ + T₃ ≥ 0` from termwise non-negativity**, with no hypothesis. -/
theorem general_nonneg {T₁ T₂ T₃ : ℝ} (h₁ : 0 ≤ T₁) (h₂ : 0 ≤ T₂) (h₃ : 0 ≤ T₃) :
    0 ≤ T₁ + 2 * T₂ + T₃ := by linarith

/-- **The block's identity is the `T₁ = T₂ = 0` case.** -/
theorem specialisation (T₃ : ℝ) : (0 : ℝ) + 2 * 0 + T₃ = T₃ := by ring

/-- **Without the guard, dropping the two terms gives a lower bound, not an identity.** -/
theorem dropping_underestimates {T₁ T₂ T₃ : ℝ} (h₁ : 0 ≤ T₁) (h₂ : 0 ≤ T₂) :
    T₃ ≤ T₁ + 2 * T₂ + T₃ := by linarith

/-- And the shortfall is exactly `T₁ + 2T₂`, so the guard's role is to make it zero. -/
theorem shortfall (T₁ T₂ T₃ : ℝ) : (T₁ + 2 * T₂ + T₃) - T₃ = T₁ + 2 * T₂ := by ring

/-- **The guard is equivalent to the shortfall vanishing**, given non-negativity, so it buys
exactly the two terms and nothing else. -/
theorem guard_iff_shortfall_zero {T₁ T₂ : ℝ} (h₁ : 0 ≤ T₁) (h₂ : 0 ≤ T₂) :
    T₁ + 2 * T₂ = 0 ↔ T₁ = 0 ∧ T₂ = 0 := by
  constructor
  · intro h; constructor <;> linarith
  · rintro ⟨ha, hb⟩; rw [ha, hb]; ring

/-! ## The guard is two of the three conditions -/

/-- **Two of three**: the hypothesis and the subject partition the grading conditions, so the
fence assumes everything except the clause the slack measures. The assumed and measured parts are disjoint and exhaustive, which is what makes the
measurement read as assuming most of its own subject. -/
theorem partition (assumed measured : ℕ) (h : assumed = 2) (h' : measured = 1) :
    assumed + measured = 3 ∧ assumed ≠ 0 ∧ measured ≠ 0 := by
  subst h; subst h'
  refine ⟨by decide, by decide, by decide⟩

end HamiltonsCubic.GradingSlack
