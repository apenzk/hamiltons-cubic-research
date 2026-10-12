import Mathlib

set_option linter.style.longLine false

/-!
# Route R-A: the span condition on `W^#`, and its reduction to `W^2`

[reviews/2026-09-23-I73-route-RA.md](../../../reviews/2026-09-23-I73-route-RA.md) reduces
[I73](../../../plan.md) to a condition on the sharp operation at a critical point. This file types
the reduction, which is one pairing and needs no spectrum.

**A first version of that note recorded this as `Lean: blocked`, naming a missing subspace
construction. That was wrong**: the statement quantifies `S` with orthogonality as HYPOTHESES, so
there is nothing to build. *The layer's own rule is that a blocker the cycle could build is built
in the same cycle, and the object was one binder away from what the layer already had.*

## What is proved

* `sharp_pairing_of_critical`: at `Q(W) = W² + W# = θ·W` and `⟨S,W⟩ = 0`, the sharp part pairs
  against `S` as `⟨S,W#⟩ = -⟨S,W²⟩`. *One line from criticality, and it is why the three readings
  of I73 coincide.*
* `span_condition_iff`: for such `W` and a family of test directions, `W#` pairs to zero against
  every one exactly when `W²` does. **This is I73's span condition and its `W²` form being the
  same statement**, which the note establishes from the record and this checks in the kernel.

## What is NOT stated

That the minimal polynomial has degree two, that the spectrum takes two values, that second-order
optimality forces any of it, or anything about `Φ`. *The equivalence typed here is the cheap half;
whether [L24](../../../findings/second-order.md) reaches it is sub-step (ii) and is open.*
-/

namespace HamiltonsCubic.I73SpanCondition

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

local notation "⟪" x ", " y "⟫" => (inner ℝ x y : ℝ)

/-- **The sharp part pairs against a direction orthogonal to `W` as minus the square does.**

*From `W² + W# = θ·W` alone, by pairing with `S`. The criticality equation is carried as the
hypothesis `hQ` rather than assumed of a named object, so nothing here is about Weyl tensors in
particular.* -/
theorem sharp_pairing_of_critical {W sq sharp S : V} {θ : ℝ}
    (hQ : sq + sharp = θ • W) (hS : ⟪S, W⟫ = 0) :
    ⟪S, sharp⟫ = -⟪S, sq⟫ := by
  have h : ⟪S, sq⟫ + ⟪S, sharp⟫ = θ * ⟪S, W⟫ := by
    rw [← inner_add_right, hQ, real_inner_smul_right]
  rw [hS, mul_zero] at h
  linarith

/-- **I73's span condition and its `W²` form are the same statement.**

*`W#` pairs to zero against every test direction orthogonal to `W` exactly when `W²` does.
Immediate from the pairing above, and it is the kernel's version of what the note derives from
the record: `W# ∈ span{W,Id}` and `W² ∈ span{W,Id}` and the degree-two minimal polynomial are one
condition wearing three names.* -/
theorem span_condition_iff {W sq sharp : V} {θ : ℝ} {ι : Type*} {S : ι → V}
    (hQ : sq + sharp = θ • W) (hS : ∀ i, ⟪S i, W⟫ = 0) :
    (∀ i, ⟪S i, sharp⟫ = 0) ↔ (∀ i, ⟪S i, sq⟫ = 0) := by
  constructor
  · intro h i
    have := sharp_pairing_of_critical hQ (hS i)
    rw [h i] at this; linarith
  · intro h i
    have := sharp_pairing_of_critical hQ (hS i)
    rw [h i] at this; simpa using this

end HamiltonsCubic.I73SpanCondition
