import Mathlib
import HamiltonsCubic.Results.L24Sharp
import HamiltonsCubic.Results.L1Statement
import HamiltonsCubic.Base.Frames

set_option linter.style.longLine false

/-!
# I124, ascent at every non-diagonal critical point above `θ₀`: the statement

[plan.md](../../../plan.md)'s I124, route [R57](../../../routes.md), the user's decision of 2026-09-28:

> *Every non-diagonal unit critical point with $\theta\ge\theta_0(n)$, $n\ge12$, has $v\perp W$ off the
> orbit with $\langle v,L_ev\rangle>\tfrac12\lvert v\rvert^2$; with [L57](../../../findings/problem.md), P.*

Here `L_e v = (a ∘ v)/θ` with `∘` the Fox product (`foxProd2`), so the inequality reads
`⟨v, a ∘ v⟩ > (θ/2)‖v‖²`. Orbit tangents meet it with equality (`L24_sharp_vec`), so strictness puts
`v` off the orbit without a separate clause. *Non-diagonal* is `¬ IsCoordDiagonalSomeFrame` of the
operator on skew matrices, the record's frame-free meaning, and `θ₀` is [L1Statement.lean](L1Statement.lean)'s
`theta0`, `√(2(n-1)(n-2))/n`.

**Typed**: the statement, as a `Prop`, and its falsifier as the negation, both over the base layer's
objects. **Not typed**: a proof; this file carries no `sorry`.
-/

namespace HamiltonsCubic.I124Statement

open HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.FrameLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **I124 at the index type `ι`**: every unit Weyl critical point `Q(a) = θa` with `θ ≥ θ₀(n)` that
is diagonal in no orthonormal frame has an ascent direction `v ⊥ a` in the Weyl subspace. -/
def I124 (ι : Type*) [Fintype ι] [DecidableEq ι] : Prop :=
  ∀ (a : CurvOp2 ι) (lam : ℝ), normSq2 a = 1 → IsWeyl2 a → Qop2 a = lam • a →
    HamiltonsCubic.L1Statement.theta0 (Fintype.card ι) ≤ lam →
    ¬ IsCoordDiagonalSomeFrame (extend a) →
    ∃ v ∈ weylPerp a, lam / 2 * normSq2 v < innerOp2 v (foxProd2 a v)

/-- **The falsifier**, the negation unfolded: a non-diagonal unit critical point at `θ ≥ θ₀(n)` where
every direction of `W^⊥` has `⟨v, a ∘ v⟩ ≤ (θ/2)‖v‖²`. -/
def I124Falsifier (ι : Type*) [Fintype ι] [DecidableEq ι] : Prop :=
  ∃ (a : CurvOp2 ι) (lam : ℝ), normSq2 a = 1 ∧ IsWeyl2 a ∧ Qop2 a = lam • a ∧
    HamiltonsCubic.L1Statement.theta0 (Fintype.card ι) ≤ lam ∧
    ¬ IsCoordDiagonalSomeFrame (extend a) ∧
    ∀ v ∈ weylPerp a, innerOp2 v (foxProd2 a v) ≤ lam / 2 * normSq2 v

/-- The falsifier is exactly the negation of the statement. -/
theorem falsifier_iff : I124Falsifier ι ↔ ¬ I124 ι := by
  unfold I124Falsifier I124
  constructor
  · rintro ⟨a, lam, h1, h2, h3, h4, h5, h6⟩ h
    obtain ⟨v, hv, hlt⟩ := h a lam h1 h2 h3 h4 h5
    exact absurd (h6 v hv) (not_le.mpr hlt)
  · intro h
    push Not at h
    obtain ⟨a, lam, h1, h2, h3, h4, h5, h6⟩ := h
    exact ⟨a, lam, h1, h2, h3, h4, h5, h6⟩

end HamiltonsCubic.I124Statement
