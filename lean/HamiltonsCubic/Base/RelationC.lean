import HamiltonsCubic.Base.CP2Sharp

/-!
# Relation (C), criticality, and the eigenvalue is rational

The third per-index relation is criticality: `Q(W) = θ W` at a unit `W`.

**At the competitor the eigenvalue is `3` exactly.** `‖W_{ℂP²}‖² = 6` on the
unnormalised tensor and `Q` is quadratic, so criticality at the unit vector
reads `Q(W) = √6 · θ · W` here; with `θ = √(3/2)` that is `√6 · √(3/2) = 3`. The
two square roots cancel, and what is left is a rational eigenvalue equation.

It cross-checks everything already proved: `P(W) = ⟨W, Q(W)⟩ = 3‖W‖² = 18`,
which is [F53](../Results/F53.lean)'s value reached by a different route.

With (A) in [KillingRow.lean](KillingRow.lean) and (B) in
[RelationB.lean](RelationB.lean), this completes the three relations
[plan.md](../../../plan.md) calls the session's durable structural result, at
`n = 4`, at one point, which is what a witness can carry.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

/-- **Criticality at the competitor, with a rational eigenvalue.**

*A term proof, citing `WCP2_critical'` in [CP2Sharp.lean](CP2Sharp.lean), which is kernel-checked.*

**THE GENERAL-`n` ROUTE CANNOT REACH THIS ONE, AND THE RECORD SAID SO IN A DIFFERENT FILE.** *This
docstring named `sum_inner2_ad2` at `ℚ` as the block. That port now exists,
[KillingForm.lean](KillingForm.lean), and it does not help*: `sum_inner2_ad2` contracts a DOUBLE
BRACKET with nothing between the brackets, where `sharpQF` carries the operator in the middle.
**The index's own `I66` row already recorded that distinction**, so two parts of the record
disagreed about what this was waiting for, and the one that was wrong is the one a reader of this
file meets first.

**WHAT IS BUDGETABLE IS THE ENTRY-BY-ENTRY ROUTE, AND THE REASON THE MONOLITH TIMED OUT IS THE
REASON IT WORKS.** *Heartbeats are counted per declaration*, so a single theorem carrying
twenty-one `sharpQF` evaluations exhausts its budget where twenty-one declarations each carrying
one do not. **That is exactly how `sharpQF_one_basis` in [Sharp.lean](Sharp.lean) retired**, and
its `simp only` reduction set is the one to reuse. *`sharpMat` needs `sharpQF` at the six basis
bivectors and at the fifteen pairwise sums, and nothing beyond those twenty-one numbers.* -/
theorem WCP2_critical : Qop WCP2 = (3 : ℚ) • WCP2 := WCP2_critical'

/-- And the value follows, agreeing with [F53](../Results/F53.lean)'s `P = 18`
reached through the `#` split instead. -/
theorem WCP2_P_from_criticality :
    Pcubic WCP2 = 3 * (WCP2ᵀ * WCP2).trace := by
  unfold Pcubic
  rw [WCP2_critical]
  rw [Matrix.mul_smul, Matrix.trace_smul]
  norm_num

/-- **`θ² = 3/2` at the competitor**, `P(W)² = (3/2)‖W‖⁶` with `‖W‖⁶ = 216`, so `P(W)² = 324`.

*This was `native_decide` in [CP2.lean](CP2.lean), where the criticality it follows from was not
yet available.* **It is two rewrites once `Qop W = 3W` is in hand**, which is why the two debts were
one: the `6` comes from the kernel-checked `WCP2_normSq` and the `18` from criticality. -/
theorem WCP2_theta_sq : Pcubic WCP2 ^ 2 * 2 = 3 * ((WCP2ᵀ * WCP2).trace) ^ 3 := by
  rw [WCP2_P_from_criticality, WCP2_normSq]
  norm_num

end HamiltonsCubic.Base
