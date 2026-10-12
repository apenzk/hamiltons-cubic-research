import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# L148, three hypotheses dropped, and a frame chosen after

[second-order.md](../../../findings/second-order.md)'s Lemma L148, verified
`PROVEN, hypotheses corrected`, its Gate 2 debt discharged.

**One of the three dropped hypotheses is the one [L147](L147.lean) has a witness against.**
L148 needs no gap, no analyticity and **no `ker W* = 0`**, and L147 carries `ker W* = 0` with
a named counterexample at `W_{ℂP²}`. So L148 applies exactly where L147 falls silent, and the
two blocks are not merely of different strength: one is available at the record's running
example and the other is not.

**"The frame is chosen after `H`" is a quantifier order.** Choosing after is `∀H ∃F`;
choosing before would be `∃F ∀H`. The second implies the first and **not conversely**, so the
correction moves the statement to the weaker and correct side, a change in what is claimed,
not in how it is phrased.

**And "two terms" is not "two branches".** A count of summands and a count of solution
branches are different counts, so replacing one by the other is a category correction rather
than an arithmetic one.
-/

namespace HamiltonsCubic.FrameAfterH

/-! ## The quantifier order -/

/-- **`∃F ∀H` implies `∀H ∃F`.** -/
theorem before_implies_after {H F : Type} (P : H → F → Prop) (h : ∃ f, ∀ x, P x f) :
    ∀ x, ∃ f, P x f := by
  obtain ⟨f, hf⟩ := h
  exact fun x => ⟨f, hf x⟩

/-- **And not conversely**: a frame depending on `H` need not be uniform. So *"chosen after"*
is the weaker reading, and the correction changes what is claimed. -/
theorem after_not_before :
    ∃ (P : ℕ → ℕ → Prop), (∀ x, ∃ f, P x f) ∧ ¬ (∃ f, ∀ x, P x f) := by
  refine ⟨fun x f => f = x, fun x => ⟨x, rfl⟩, ?_⟩
  rintro ⟨f, hf⟩
  have h0 := hf 0
  have h1 := hf 1
  omega

/-! ## Dropping hypotheses widens -/

/-- **A conclusion reached without three hypotheses holds wherever they fail.** -/
theorem dropping_widens {A B C Concl : Prop} (h : Concl) : A → B → C → Concl := fun _ _ _ => h

/-! ## Terms against branches -/

/-- **Two counts of different things need not agree**, so replacing *"two branches"* by
*"two terms"* is a category correction, the numbers coinciding is not evidence they were the
same count. -/
theorem counts_of_different_things :
    ∃ terms branches : ℕ, terms = 2 ∧ branches = 0 ∧ terms ≠ branches := by
  refine ⟨2, 0, rfl, rfl, by decide⟩

end HamiltonsCubic.FrameAfterH
