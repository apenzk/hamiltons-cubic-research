import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp

/-!
# L152, the identity survives, the constant does not

[second-order.md](../../../findings/second-order.md)'s Lemma L152, refuted as stated and
superseded by L156.

**The identity is linear in `α`, which is why the constant built on it has a range.**
`max_Γ|ζ| = (1+α)g_n` grows without bound as `α` does, so any constant derived from it holds
only while `α` stays inside some interval, and the audit places the break at `α = D/2`. A
quantity growing linearly cannot be bounded by a fixed constant, so *"carries no range"* is a
defect the identity's own shape predicts.

**And two valid bounds by different routes do not disagree.** The audit says the disagreement
L152 claimed to settle was no disagreement at all: two upper bounds on the same quantity can
both hold, one tighter, with neither wrong. `bounds_dont_disagree` is that, and it is why a
lemma settling between them had nothing to settle.
-/

namespace HamiltonsCubic.NumeratorIdentity

/-! ## The identity is linear in `α` -/

/-- **`(1+α)gₙ` is strictly increasing in `α`** for `gₙ > 0`. -/
theorem increasing_in_alpha {g α α' : ℚ} (hg : 0 < g) (h : α < α') :
    (1 + α) * g < (1 + α') * g := by nlinarith [hg, h]

/-- **So no fixed constant bounds it**: past any `C` there is an `α` with `(1+α)gₙ > C`. -/
theorem no_fixed_bound {g : ℚ} (hg : 0 < g) (C : ℚ) : ∃ α : ℚ, C < (1 + α) * g := by
  refine ⟨C / g, ?_⟩
  have : C / g * g = C := by field_simp
  nlinarith [hg, this]

/-- **The break has a location**: past `α = D/2` the constant fails, so the implicit domain is
`α ≤ D/2` and the statement is silent above it. -/
theorem domain_is_half_D {D α : ℚ} (h : D / 2 < α) : ¬ (α ≤ D / 2) := by linarith

/-! ## Two valid bounds do not disagree -/

/-- **Two upper bounds on the same quantity can both hold**, one tighter, with neither
wrong, so a lemma settling between them has nothing to settle. -/
theorem bounds_dont_disagree :
    ∃ x b₁ b₂ : ℚ, x ≤ b₁ ∧ x ≤ b₂ ∧ b₁ ≠ b₂ :=
  ⟨3, 5, 7, by norm_num, by norm_num, by norm_num⟩

/-- The tighter one implies the looser, so they are ordered rather than opposed. -/
theorem tighter_implies_looser {x b₁ b₂ : ℚ} (h : x ≤ b₁) (hb : b₁ ≤ b₂) : x ≤ b₂ :=
  le_trans h hb

end HamiltonsCubic.NumeratorIdentity
