import HamiltonsCubic.Results.L96
import Mathlib.Data.Nat.Choose.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# L117, a corollary mislabelled as a converse

[bounds.md](../../../findings/bounds.md)'s Lemma L117. The mathematics is confirmed at every
`n ≥ 4`; the heading was a mislabel and the block carried no argument.

**Same hypothesis and a weaker conclusion is a corollary, and a converse is the other
operation entirely.** A converse exchanges hypothesis and conclusion; L117 keeps [L71](../../../findings/bounds.md)'s
hypothesis and weakens what follows, so it descends from [L70](../../../findings/bounds.md)
rather than reversing L71. `corollary_not_converse` separates the two shapes.

**And the equality clause is empty at odd `n`, not merely unstated there.** Equality needs two
eigenvalues and no kernel, which is the balanced product, and no odd `n` is `2m`, imported
from [L96](L96.lean). So *"for `n ≥ 5`"* scopes a clause that has no instance at half the
dimensions it names, which is what the audit calls vacuous.

The chord inequality is summed over the `C(n,2)` eigenvalues, and that count is checked at the
dimensions the record uses.
-/

namespace HamiltonsCubic.MislabelledConverse

open HamiltonsCubic.SRG

/-! ## Corollary against converse -/

/-- **A weaker conclusion under the same hypothesis is a corollary.** -/
theorem corollary_shape {P Q R : Prop} (h : P → Q) (hw : Q → R) : P → R := fun hp => hw (h hp)

/-- **A converse exchanges hypothesis and conclusion**, and neither operation gives the
other: a corollary can hold while the converse fails. -/
theorem corollary_not_converse :
    ∃ P Q : Prop, (P → Q) ∧ ¬ (Q → P) := by
  refine ⟨False, True, fun h => h.elim, ?_⟩
  intro h
  exact (h trivial).elim

/-! ## The equality clause is empty at odd `n` -/

/-- **No odd `n` is `2m`**, imported from [L96](L96.lean), so the balanced product, which is
what the equality case requires, does not exist there. -/
theorem no_balanced_at_odd (n : ℤ) (hodd : ¬ (2 ∣ n)) (m : ℤ) : 2 * m ≠ n :=
  no_balanced_odd n hodd m

/-- **So the equality clause has no instance at odd `n`**, and scoping it *"for `n ≥ 5`"*
names dimensions where it says nothing. -/
theorem clause_empty_at_odd (n : ℤ) (hodd : ¬ (2 ∣ n)) : ¬ ∃ m : ℤ, 2 * m = n := by
  rintro ⟨m, hm⟩
  exact no_balanced_at_odd n hodd m hm

/-- Half the dimensions in the named range are odd, so the scope is empty on half of what it
names: `5, 7, 9` against `6, 8, 10`. -/
theorem odd_in_range : ¬ (2 ∣ (5 : ℤ)) ∧ ¬ (2 ∣ (7 : ℤ)) ∧ ¬ (2 ∣ (9 : ℤ)) := by
  refine ⟨by decide, by decide, by decide⟩

/-! ## The summation range -/

/-- The chord inequality is summed over the `C(n,2)` eigenvalues of `Λ²`. -/
theorem eigenvalue_count_six : Nat.choose 6 2 = 15 := by decide

theorem eigenvalue_count_twelve : Nat.choose 12 2 = 66 := by decide

/-- And the count grows quadratically, so the sum is over a growing range rather than a fixed
one, which is why the inequality has to be summed rather than applied once. -/
theorem count_grows : Nat.choose 6 2 < Nat.choose 12 2 := by decide

end HamiltonsCubic.MislabelledConverse
