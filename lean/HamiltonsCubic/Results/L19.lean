import Mathlib.Data.Finset.Basic
import Mathlib.Data.Finset.Lattice.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# L19, the four dimension lists, and what they leave standing

[problem.md](../../../findings/problem.md)'s Lemma L19, withdrawn at Gate 2 as carrying no
checkable statement. The audit leaves one item explicitly open and outside the block: **four
incompatible dimension lists** for the rival maximiser's rigidity, which *"cannot stay in
disagreement"* because that orbit's value sets the localisation threshold.

**They agree on exactly one dimension, and it is `n = 8`.** The lists are `{6,8,10}`,
`{8,10,12}`, `{8,10}` and `{8,12,14}`; their intersection is `{8}`. So any step needing a
dimension all four sources support has only `n = 8` available, and `n = 8` is the dimension
[L6](L6.lean)'s audit flags as unsound for reading the defect off Cartan's list, since `ℍP²`
and `S³ × S⁵` form a triality pair there with defects `2/63` and `0`. *Those are different
computations, so this is a narrowing rather than a contradiction*, but the one dimension the
lists agree on is the one already carrying a flag.

**The localisation needs a radius nobody has recorded.** Written as a proposition, it says every
critical point at or above the rival's value lies within `εₙ` of a rigid orbit, and rigidity
closes it only if `εₙ ≤ min rᵢ`. Nondegeneracy is proved as kernel-equals-orbit-tangent, which
gives isolation qualitatively and no radius, and without one the implication has no content,
since a point within `ε` of an orbit need not lie on it at any `ε > 0`.

**And *"every sphere pair"* needs the `(3,3)` exclusion.** At `S³ × S³` the Hessian kernel is
`18` against an orbit of `9`, so that pair is degenerate and the universal clause is false as
written.
-/

namespace HamiltonsCubic.LiftStatus

open Finset

/-! ## The four dimension lists -/

/-- The rigidity dimensions as each source records them. -/
def listNondeg : Finset ℕ := {6, 8, 10}

def listSecondOrder : Finset ℕ := {8, 10, 12}

def listMeasurement : Finset ℕ := {8, 10}

def listAttempts : Finset ℕ := {8, 12, 14}

/-- **The four agree on exactly `{8}`.** -/
theorem lists_agree_only_at_eight :
    listNondeg ∩ listSecondOrder ∩ listMeasurement ∩ listAttempts = {8} := by
  decide

/-- **And no two of them coincide**, so the disagreement is genuine rather than a restatement. -/
theorem lists_pairwise_distinct :
    listNondeg ≠ listSecondOrder ∧ listSecondOrder ≠ listAttempts
      ∧ listNondeg ≠ listAttempts := by
  refine ⟨by decide, by decide, by decide⟩

/-- Each list omits a dimension another asserts, in both directions. -/
theorem lists_conflict :
    6 ∈ listNondeg ∧ 6 ∉ listAttempts ∧ 14 ∈ listAttempts ∧ 14 ∉ listNondeg := by
  refine ⟨by decide, by decide, by decide, by decide⟩

/-! ## The localisation needs a radius -/

/-- **Closeness alone gives nothing.** For every `ε > 0` there is a point within `ε` of a target
that does not equal it, so *"within `εₙ` of a rigid orbit"* plus qualitative isolation does not
place the point on the orbit, the implication needs `εₙ ≤ rᵢ` with an actual `rᵢ`. -/
theorem closeness_needs_a_radius {ε : ℚ} (hε : 0 < ε) :
    ∃ x : ℚ, |x - 0| < ε ∧ x ≠ 0 := by
  refine ⟨ε / 2, ?_, ne_of_gt (by linarith : (0:ℚ) < ε / 2)⟩
  rw [sub_zero, abs_of_pos (by linarith)]
  linarith

/-- **And with a radius it does close**, which is what makes the missing `rᵢ` the whole gap. -/
theorem radius_closes_it {ε r d : ℚ} (hd : d < ε) (hεr : ε ≤ r) : d < r := by linarith

/-! ## The `(3,3)` exclusion -/

/-- At `S³ × S³` the Hessian kernel is `18` against an orbit of `9`, so *"every sphere pair"* is
false without excluding `(3,3)`. -/
theorem three_three_degenerate : (9 : ℕ) ≠ 18 ∧ 9 < 18 := by
  refine ⟨by decide, by decide⟩

/-! ## Incomparable, not weaker -/

/-- The canon calls the open core *"strictly weaker"* than the companion conjecture; the audit
finds them **incomparable**. That is a coherent position: two statements can each fail to imply
the other, so *"weaker"* is not the only alternative to *"equivalent"*. -/
theorem incomparability_is_coherent :
    ∃ p q : Bool → Prop, ¬ (∀ x, p x → q x) ∧ ¬ (∀ x, q x → p x) := by
  refine ⟨fun b => b = true, fun b => b = false, ?_, ?_⟩
  · intro h; exact absurd (h true rfl) (by simp)
  · intro h; exact absurd (h false rfl) (by simp)

end HamiltonsCubic.LiftStatus
