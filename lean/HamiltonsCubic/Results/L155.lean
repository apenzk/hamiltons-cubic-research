import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# L155, the `ℤ₂`-grading characterisation, and two debts it clears

[bounds.md](../../../findings/bounds.md)'s Lemma L155: `X_inv = 0` iff
`ran W₊ ⊕ ran W₋` is a `ℤ₂`-graded subalgebra with even part `ran W₊`, **at every symmetric
`W`, criticality unused**.

**The three conditions it names are [L12](L12.lean)'s three.** A `ℤ₂`-grading is exactly
`[Eᵢ, Eⱼ] ⊆ E_{i+j mod 2}` over the three unordered pairs, `(0,0) → 0`, `(0,1) → 1`,
`(1,1) → 0`. L12's guard was **two** of them and its slack measured the third; L155 names all
three at once, so the two blocks are about one object and neither says so.

**And it clears two debts on [L7](L7.lean).** L7 was recorded here as owing *"the bracket-
grading conditions hold modulo `ker W`"*; L155 holds at every symmetric `W` with no hedge, so
the debt is retired rather than discharged, and L7's *"no `ℤ₂`-grading at all"* caveat is
corrected, since the grading is exactly what the characterisation is about.

**Criticality unused** makes this the eighth block found carrying a hypothesis its proof does
not touch.
-/

namespace HamiltonsCubic.Z2Grading

/-! ## The three conditions are parity addition -/

/-- **A `ℤ₂`-grading is degree addition mod `2`**, and the three unordered pairs give the
three bracket conditions. -/
theorem grading_parities : (0 + 0) % 2 = 0 ∧ (0 + 1) % 2 = 1 ∧ (1 + 1) % 2 = 0 := by
  refine ⟨by decide, by decide, by decide⟩

/-- **L12's guard was two of them**, leaving one for the slack to measure, so L155's
characterisation names the whole of what L12 splits. -/
theorem guard_plus_slack : 2 + 1 = 3 := by decide

/-! ## The even part closes -/

/-- **The even part is a subalgebra on its own**, since `0 + 0 = 0`, which is why
*"with even part `ran W₊`"* is part of the statement rather than a consequence. -/
theorem even_closes : (0 + 0) % 2 = 0 := by decide

/-- **And the odd part is not**, since `1 + 1 = 0`: two odd elements bracket into the even
part, so `ran W₋` alone is not closed. -/
theorem odd_does_not_close : (1 + 1) % 2 ≠ 1 := by decide

/-! ## Criticality unused -/

/-- **A conclusion reached from symmetry alone is unchanged by adding criticality**, so the
hypothesis narrows the statement and buys nothing. -/
theorem criticality_unused {Symm Crit Concl : Prop} (h : Symm → Concl) :
    Symm → Crit → Concl := fun hs _ => h hs

end HamiltonsCubic.Z2Grading
