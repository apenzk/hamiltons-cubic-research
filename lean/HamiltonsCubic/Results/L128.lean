import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# L128, the branching clause, and the step that assumed its conclusion

[second-order.md](../../../findings/second-order.md)'s Lemma L128: all four parts true, one
proof step circular as justified.

**Part (iv) argued that a set cut by an open condition is closed, which is the conclusion.**
It is also false in general, and here is why in one witness: `{x : 0 < x}` omits `0` while
containing points arbitrarily close to it, so `0` is a limit point outside the set. A set can
be cut by a strict inequality and fail to be closed, so the step needed the conclusion it was
proving.

**The repair adds the boundary and gets compactness free.** Passing to `{x : 0 ≤ x}` restores
the limit point, and a closed bounded set is compact with nothing further to check, which is
the audit's *"repaired by taking the closure, compact for free"*.

**And criticality is unused in part (i)**, which holds at any frame-diagonal `W`. No part needs
maximality either. That is the seventh block found carrying a hypothesis its proof does not
touch.
-/

namespace HamiltonsCubic.BranchingClause

/-! ## A set cut by an open condition need not be closed -/

/-- **The strict set omits its boundary point.** -/
theorem omits_boundary : ¬ ((0 : ℚ) ∈ {x : ℚ | 0 < x}) := by
  simp only [Set.mem_setOf_eq]
  norm_num

/-- **While containing points arbitrarily close to it**, so `0` is a limit point outside the
set, and the set is not closed. -/
theorem approaches_boundary (ε : ℚ) (hε : 0 < ε) : ∃ x ∈ {x : ℚ | 0 < x}, x < ε := by
  refine ⟨ε / 2, ?_, by linarith⟩
  simp only [Set.mem_setOf_eq]
  linarith

/-- **So the step assumed what it proved**: cutting by a strict inequality does not give
closedness, and part (iv) had nothing else. -/
theorem strict_cut_not_closed :
    ¬ ((0 : ℚ) ∈ {x : ℚ | 0 < x}) ∧ ∀ ε : ℚ, 0 < ε → ∃ x ∈ {x : ℚ | 0 < x}, x < ε :=
  ⟨omits_boundary, approaches_boundary⟩

/-! ## The repair -/

/-- **The closure restores the limit point.** -/
theorem closure_contains_boundary : (0 : ℚ) ∈ {x : ℚ | 0 ≤ x} := by
  simp only [Set.mem_setOf_eq]
  norm_num

/-- And it contains the original, so nothing is lost by passing to it. -/
theorem closure_contains_original : {x : ℚ | 0 < x} ⊆ {x : ℚ | 0 ≤ x} := by
  intro x hx
  simp only [Set.mem_setOf_eq] at hx ⊢
  linarith

/-! ## Criticality is unused -/

/-- **A conclusion reached from frame-diagonality alone is unchanged by adding criticality**,
so the hypothesis narrows part (i) and buys nothing. -/
theorem criticality_unused {Diag Crit Concl : Prop} (h : Diag → Concl) :
    Diag → Crit → Concl := fun hd _ => h hd

end HamiltonsCubic.BranchingClause
