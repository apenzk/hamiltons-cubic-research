import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# L135, the candidate translates exactly, onto a value it does not inherit

[route-a.md](../../../findings/route-a.md)'s Lemma L135, Gate 2 owed. The arithmetic is
checkable now.

**The translation is exact.** The great-circle and straight-line second-order defect
coefficients differ by `δ²(u)`, which is `1/9` at the competitor, so `c₂ = Δ₂ - 1/9`. Then
[I3](../../../plan.md)'s candidate `c₂ ≤ 5/36`, which implies its target `c₂ ≤ θ*/(2|κₙ|)` with room
([L134](L134.lean)'s `candidate_implies_target`), is **exactly** `Δ₂ ≤ 1/4`, since
`5/36 + 1/9 = 1/4` with no remainder.

**But the `1/4` it lands on is a ceiling for `δ²`, not for `Δ₂`.** The record notes the
coincidence; the two are different quantities, so a known bound on one is not a bound on the
other. The equality of values licenses nothing, the same shape [L107](L107.lean) found with
two objects called `Π` and [L124](L124.lean) with `A, B, C` across two operators.
-/

namespace HamiltonsCubic.TargetTranslation

/-! ## The translation -/

/-- `δ² = 1/9` at the competitor, so `δ = 1/3`. -/
theorem delta_sq : (1 : ℚ) / 3 ^ 2 = 1 / 9 := by norm_num

/-- **`5/36 + 1/9 = 1/4` exactly**, with no remainder. -/
theorem sum_exact : (5 : ℚ) / 36 + 1 / 9 = 1 / 4 := by norm_num

/-- **So `c₂ ≤ 5/36` and `Δ₂ ≤ 1/4` are the same condition**, in both directions. -/
theorem targets_equivalent (c Δ : ℚ) (h : c = Δ - 1 / 9) : c ≤ 5 / 36 ↔ Δ ≤ 1 / 4 := by
  rw [h]
  constructor <;> intro hx <;> linarith

/-- The gap between the two thresholds is exactly `δ²`, so the translation carries no slack. -/
theorem no_slack : (1 : ℚ) / 4 - 5 / 36 = 1 / 9 := by norm_num

/-! ## The value it lands on belongs to another quantity -/

/-- **A bound on one quantity is not a bound on another that happens to share its value.**
`Δ₂ ≤ 1/4` and `δ² ≤ 1/4` are different statements, and knowing the second gives the first
only if the two are related, which the record does not claim. -/
theorem shared_value_no_transfer :
    ∃ x y : ℚ, y ≤ 1 / 4 ∧ ¬ (x ≤ 1 / 4) :=
  ⟨1, 0, by norm_num, by norm_num⟩

/-- So the candidate is *reached* by the record's ceiling only if `Δ₂ ≤ δ²`, which is a further
statement, and the coincidence of `1/4` is not evidence for it. -/
theorem needs_comparison {Δ δsq : ℚ} (hδ : δsq ≤ 1 / 4) (hcmp : Δ ≤ δsq) : Δ ≤ 1 / 4 :=
  le_trans hcmp hδ

end HamiltonsCubic.TargetTranslation
