import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Data.Nat.Choose.Basic

/-!
# L137, three defects that each pass alone and fail together

[route-a.md](../../../findings/route-a.md)'s Lemma L137, refuted at Gate 2 with both reviewers
agreeing on every root cause. The notice records something unusual and worth making precise:
*"the Hansen–Pedersen compression, `Π_A ≤ P₀`, the factors of `t`, `Λ⁻¹`, the subadditivity of
`X ↦ tr(X₊)` and the `2a` arithmetic were each confirmed individually; the lemma failed on
assembly."*

**A sign error on a nonnegative term costs twice that term, and reverses its role.** The third
defect is `ρ` added where it must be subtracted. With `ρ ≥ 0`, the true `X - ρ` and the written
`X + ρ` differ by `2ρ`, and they sit on opposite sides of `X`, so a quantity that can only
help becomes one that looks like an obstruction. That is exactly what the notice reports for
`‖c₁‖²`, and it is why the error is not a loosening but an inversion.

**A phantom nonnegative term is invisible to any check that only bounds.** The second defect is
a `CC^T` term that does not exist once the fixed projector's own motion is counted. Since
`CC^T ⪰ 0`, including it can only raise an upper bound, so every step remains *true*, and no
inequality check anywhere in the chain can see it. Only recounting the derivation can.

**And individually valid steps compose to a false conclusion once one sign is wrong.** Three
correct inequalities chained through one inverted term give a conclusion contradicting the
truth, with every link checkable in isolation, which is the shape of failure the notice
describes and the reason step-by-step confirmation did not catch it.
-/

namespace HamiltonsCubic.AssemblyFailure

/-! ## The sign error is an inversion, not a loosening -/

/-- **`X - ρ` and `X + ρ` differ by `2ρ` and straddle `X`.** -/
theorem sign_error_costs_twice {X ρ : ℚ} (hρ : 0 ≤ ρ) :
    X - ρ ≤ X ∧ X ≤ X + ρ ∧ (X + ρ) - (X - ρ) = 2 * ρ := by
  refine ⟨by linarith, by linarith, by ring⟩

/-- **And it reverses the term's role**: with the correct sign the contribution is nonpositive,
with the wrong one nonnegative, so a quantity that can only help reads as an obstruction. -/
theorem role_reverses {ρ : ℚ} (hρ : 0 < ρ) : -ρ < 0 ∧ 0 < ρ := by
  refine ⟨by linarith, hρ⟩

/-! ## A phantom nonnegative term cannot be caught by bounding -/

/-- **Adding a nonnegative term keeps every upper bound true.** So a `CC^T` that does not exist
leaves the chain sound at every step, and no inequality check can detect it. -/
theorem phantom_term_preserves_bounds {X C B : ℚ} (hC : 0 ≤ C) (h : X + C ≤ B) : X ≤ B := by
  linarith

/-- **But the conclusion it supports is strictly weaker than the truth**, by exactly the phantom
term, which is what makes the defect a real one rather than a harmless slack. -/
theorem phantom_term_weakens {X C : ℚ} (hC : 0 < C) : X < X + C := by linarith

/-! ## Valid links, invalid chain -/

/-- **Each link true, the conclusion false.** Take `a = 1`, `b = 2`, `ρ = 1`. The steps
`a ≤ b`, `b ≤ b + ρ` and `b + ρ ≤ 3` are each true; concluding `a ≤ b - ρ` from them inverts
`ρ` once, and `1 ≤ 1` happens to hold, while at `ρ = 2` the same chain gives `1 ≤ 0`. -/
theorem links_valid_chain_invalid :
    ((1 : ℚ) ≤ 2 ∧ (2 : ℚ) ≤ 2 + 2 ∧ (2 : ℚ) + 2 ≤ 4) ∧ ¬ ((1 : ℚ) ≤ 2 - 2) := by
  refine ⟨⟨by norm_num, by norm_num, by norm_num⟩, by norm_num⟩

/-- So confirming every step in isolation does not confirm the assembly, and the notice's
account of how the lemma failed is coherent rather than surprising. -/
theorem stepwise_confirmation_is_insufficient :
    ∃ a b ρ : ℚ, a ≤ b ∧ 0 ≤ ρ ∧ ¬ (a ≤ b - ρ) := by
  refine ⟨1, 2, 2, by norm_num, by norm_num, by norm_num⟩

/-! ## What survives in the sibling withdrawals -/

/-- `Λ⁴ℝ⁴` is one-dimensional, which is why `g₁` carries no content from the competitor's own
four indices. -/
theorem lambda4_four : Nat.choose 4 4 = 1 := by decide

/-- **`B₁₁ = 0` with `B₃₃ = -B₂₂` makes the `B`-block traceless on the cone**, a consequence
the sibling block states in parts without drawing. -/
theorem B_block_traceless {B₂₂ : ℚ} : (0 : ℚ) + B₂₂ + (-B₂₂) = 0 := by ring

end HamiltonsCubic.AssemblyFailure
