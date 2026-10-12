import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum

/-!
# L174, I36 is a statement about the vertex-matrix budget

[plan.md](../../../plan.md)'s I36 asks: *is every local maximiser with `θ > √(3/2)` coordinate-
diagonal in some frame?*, a claim about **shape**, which the item itself records as filed
*"on a shape rather than a mechanism"*.

[Lemma L94](../../../findings/LEDGER.md) gives `κ² ≤ 2‖M‖²` with **equality exactly at
coordinate-diagonal**, Gate 2 confirmed. So the shape is a scalar: at unit norm, being
coordinate-diagonal in some frame is `κ² = 2`.

**This file types the reformulation and lets the kernel check the quantifier step.** That step
is a first-order tautology and is the **smallest** of the three risks, not the whole of them,
both Gate 2 reviewers refused the claim that it was. The two the abstraction cannot see are the
sense of "unit" that makes `2‖M‖²` equal `2`, and **the per-frame/extremal swap**, `kappaSq`
is opaque here, so substituting the per-frame `t_F` for `max_F t_F` type-checks identically,
and that swap is the one with a standing record of having occurred. *Both reviewers named
those two; an earlier version of this docstring replaced the swap with `L94`'s attainment of
`max_F`, which the same reviewers had discharged.*
`L94` below is taken as a hypothesis, and it is **not** the recorded L94 but its unit-norm
specialisation, a statement carrying no Gate 2 of its own. That is where both invisible risks
live.

**And the maximiser hypotheses are idle.** `L94` needs the norm and nothing else, so the
equivalence holds at every unit `W`; `IsLocalMax` and `theta` are carried only because the plan
item is phrased with them.

**What this does not do.** It gives I36 a mechanism, not a proof. Whether every such maximiser
attains the budget is exactly as open as before.
-/

namespace HamiltonsCubic.VertexBudget

variable {Weyl Frame : Type*}
variable (IsCoordDiagonal : Weyl → Frame → Prop)
variable (kappaSq theta : Weyl → ℝ)
variable (IsUnit IsLocalMax : Weyl → Prop)

/-- **[Lemma L94](../../../findings/LEDGER.md), taken as a hypothesis.** At unit norm,
`κ² = 2` holds exactly when the operator is coordinate-diagonal in some frame. -/
def L94 : Prop :=
  ∀ W, IsUnit W → (kappaSq W = 2 ↔ ∃ F : Frame, IsCoordDiagonal W F)

/-- I36 as filed: every unit local maximiser above `√(3/2)` is coordinate-diagonal in some
frame. -/
def I36_shape (t : ℝ) : Prop :=
  ∀ W, IsUnit W → IsLocalMax W → t < theta W → ∃ F : Frame, IsCoordDiagonal W F

/-- I36 restated as a budget claim: every such maximiser attains `κ² = 2`. -/
def I36_budget (t : ℝ) : Prop :=
  ∀ W, IsUnit W → IsLocalMax W → t < theta W → kappaSq W = 2

/-- **The two are equivalent, given L94.** The quantifier step is what the kernel checks here:
`W` is bound outside and the frame inside, and L94 is applied under both. -/
theorem shape_iff_budget (t : ℝ)
    (h94 : L94 (Frame := Frame) IsCoordDiagonal kappaSq IsUnit) :
    I36_shape (Frame := Frame) IsCoordDiagonal theta IsUnit IsLocalMax t
      ↔ I36_budget kappaSq theta IsUnit IsLocalMax t := by
  constructor
  · intro h W hu hm ht
    exact (h94 W hu).mpr (h W hu hm ht)
  · intro h W hu hm ht
    exact (h94 W hu).mp (h W hu hm ht)

/-- **The item's threshold sits BELOW `θ₀(12)`, not above it**: `θ₀(12)² = 220/144 > 3/2`.
So `θ > √(3/2)` is the weaker hypothesis, which makes the theorem stronger and the item
**harder**. The comparison is the reduction's own closure condition: it holds at every `n ≥ 12`
and fails at every `4 ≤ n ≤ 11`. *An earlier version asserted the reverse and the kernel refused
it; a later one added "including every one at or above the conjecture's own value", which is
false in that range.* -/
theorem threshold_below_theta_zero : (3 : ℚ) / 2 < 220 / 144 := by norm_num

end HamiltonsCubic.VertexBudget
