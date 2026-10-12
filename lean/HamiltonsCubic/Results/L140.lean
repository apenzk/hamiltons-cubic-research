import HamiltonsCubic.Results.L135
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# L140, `‖g₁‖² ≤ 1/4`, and the second route to I3

[route-a.md](../../../findings/route-a.md)'s Lemma L140, Gate 2 **passed**. It states that I3
holds for every `n ≥ 12`, *"granting [L134](L134.lean)'s owed remainder"*.

**There is a second route, and the record does not name it.** [L136](../../../findings/route-a.md)
gives `Δ₂ ≤ ‖g₁‖²`, L140 gives `‖g₁‖² ≤ 1/4`, so `Δ₂ ≤ 1/4`, and by
[L135](L135.lean) that is **exactly** `c₂ ≤ 5/36`, I3's candidate, which implies its target
`c₂ ≤ θ*/(2|κₙ|)` with room at every `n ≥ 12` ([L134](L134.lean)'s `candidate_implies_target`). The chain is
assembled below, using L135's equivalence rather than restating it.

**Both routes have an unaudited link, and they are different links.** L140 itself is Gate 2
passed; the route it names leans on L134's owed remainder, and the route assembled here leans
on L136 and L135, both **Gate 2 owed**. So I3 is reachable two ways and neither way is closed
which the record does not say, naming one route and one debt.
-/

namespace HamiltonsCubic.SecondRoute

open HamiltonsCubic.TargetTranslation

/-! ## The chain -/

/-- **`Δ₂ ≤ ‖g₁‖² ≤ 1/4` gives `Δ₂ ≤ 1/4`.** -/
theorem chain_to_quarter {Δ g : ℚ} (h136 : Δ ≤ g) (h140 : g ≤ 1 / 4) : Δ ≤ 1 / 4 :=
  le_trans h136 h140

/-- **And through [L135](L135.lean) that is I3's candidate**, `c₂ ≤ 5/36`, the equivalence
imported rather than restated. -/
theorem reaches_target {c Δ g : ℚ} (hdef : c = Δ - 1 / 9) (h136 : Δ ≤ g) (h140 : g ≤ 1 / 4) :
    c ≤ 5 / 36 :=
  (targets_equivalent c Δ hdef).2 (chain_to_quarter h136 h140)

/-- The chain is tight at its own bound: if `‖g₁‖² = 1/4` and `Δ₂ = ‖g₁‖²` then `c₂ = 5/36`
exactly, so the route reaches the target with no margin. -/
theorem tight_at_bound {c Δ : ℚ} (hdef : c = Δ - 1 / 9) (hΔ : Δ = 1 / 4) : c = 5 / 36 := by
  rw [hdef, hΔ]; norm_num

/-! ## The bound's own margin -/

/-- `1/4` sits strictly above the competitor's `δ² = 1/9`, so the recentring bound is not
attained there. -/
theorem above_competitor : (1 : ℚ) / 9 < 1 / 4 := by norm_num

/-- The gap is `5/36`, which is I3's candidate itself, so the candidate measures exactly how far
the competitor sits below the bound. -/
theorem gap_is_target : (1 : ℚ) / 4 - 1 / 9 = 5 / 36 := by norm_num

end HamiltonsCubic.SecondRoute
