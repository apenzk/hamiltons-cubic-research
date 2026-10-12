import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Algebra.Order.BigOperators.Group.Finset

/-!
# L154, the trace upgrade, and what it needs

[bounds.md](../../../findings/bounds.md)'s Lemma L154: `tr X_inv = 0 ⟺ X_inv = 0` at every
critical point, *"upgrading [L7](L7.lean)'s equality class to the operator"*.

**This closes the gap [L7](L7.lean) leaves, and names the ingredient.** L7's round recorded
that a scalar statement does not strengthen into an operator one, a matrix inequality implies
its trace and not conversely. Here it does, and the reason is **semidefiniteness**: a
semidefinite operator with vanishing trace is zero, because a sum of non-negative eigenvalues
vanishes only when every one does. So the upgrade is not a sharpening of L7; it is L7 plus one
hypothesis, and that hypothesis is exactly what the general implication lacks.

**It is also the third appearance of one mechanism.** [L12](L12.lean)'s unconditional
`S ≥ 0`, [L106](L106.lean)'s biconditional and this upgrade are all *a sum of non-negative
terms vanishes iff each does*, the record derives each separately.

**And L154's owed corollary is [L155](L155.lean)'s confirmed statement.** L154 leaves
*"`X_inv = 0` iff `ran W` is a symmetric pair"* at Gate 2 owed; L155 has
*"`X_inv = 0` iff `ran W₊ ⊕ ran W₋` is a `ℤ₂`-graded subalgebra"* confirmed. The two
characterise the same condition, so the debt may already be paid next door.
-/

namespace HamiltonsCubic.TraceUpgrade

open Finset

variable {ι : Type*} [Fintype ι]

/-! ## Semidefinite plus zero trace gives zero -/

/-- **A sum of non-negative terms vanishes only when each does**, the mechanism behind the
upgrade, and the same one [L12](L12.lean) and [L106](L106.lean) use. -/
theorem trace_zero_forces_zero {lam : ι → ℝ} (hnn : ∀ i, 0 ≤ lam i)
    (htr : ∑ i, lam i = 0) (i : ι) : lam i = 0 :=
  (Finset.sum_eq_zero_iff_of_nonneg fun j _ => hnn j).1 htr i (mem_univ i)

/-! ## Without semidefiniteness the upgrade fails -/

/-- **A trace can vanish while the operator does not**, once signs are free, so
semidefiniteness is doing the work, not the trace. -/
theorem trace_zero_not_enough :
    ∃ a b : ℝ, a + b = 0 ∧ a ≠ 0 :=
  ⟨1, -1, by norm_num, by norm_num⟩

/-- That is L7's gap in one line: the scalar statement returns nothing about the operator
unless the sign condition is present. -/
theorem gap_needs_sign {a b : ℝ} (hsum : a + b = 0) (ha : 0 ≤ a) (hb : 0 ≤ b) :
    a = 0 ∧ b = 0 := by
  constructor <;> linarith

end HamiltonsCubic.TraceUpgrade
