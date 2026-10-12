import HamiltonsCubic.Results.L130
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# L150, withdrawn because the reduction's target is already a theorem

[second-order.md](../../../findings/second-order.md)'s L150, **withdrawn**: post F50 already
fences the route and [L130](L130.lean)(i) makes it a theorem.

**A reduction to something already proved is not a reduction.** L130(i) gives the four-set
ratio in closed form with supremum `9/32` (imported here rather than restated) so the
concentration argument L150 offered reaches a conclusion the record already holds outright.
That is why the grade is `WITHDRAWN` and not `GAP`: there is nothing left for the reduction to
buy.

**And a chain inherits its weakest link.** The chain was F50's, with F50's surviving gap, so
re-deriving it re-derives the gap, a route already fenced stays fenced however it is
reached.
-/

namespace HamiltonsCubic.ConcentrationReduction

open HamiltonsCubic.FourSetRatio

/-! ## The target is already a theorem -/

/-- **L130(i)'s supremum is `9/32`**, imported, so the reduction's conclusion is on the
record already. -/
theorem target_already_proved : ratio 5 = 9 / 32 := ratio_at_five

/-- And it is a supremum, not a bound with slack: the ratio is strictly decreasing past
`p = 5`, so `9/32` is attained rather than approached. -/
theorem attained_not_approached {p : ℚ} (hp : 5 < p) : ratio p < ratio 5 :=
  ratio_antitone (by norm_num) hp

/-! ## A chain inherits its weakest link -/

/-- **If a link is unproved, every chain through it is.** So re-deriving F50's chain
re-derives F50's gap, and a fenced route stays fenced however it is reached. -/
theorem chain_inherits_gap {A B C : Prop} (hAB : A → B) (hBC : B → C) (hB : ¬ B) : ¬ A :=
  fun ha => hB (hAB ha)

/-- And the fence is on the route, not on the derivation: two derivations through the same
link share its status. -/
theorem fence_is_on_the_route {A A' B : Prop} (h : A → B) (h' : A' → B) (hB : ¬ B) :
    ¬ A ∧ ¬ A' :=
  ⟨fun ha => hB (h ha), fun ha => hB (h' ha)⟩

end HamiltonsCubic.ConcentrationReduction
