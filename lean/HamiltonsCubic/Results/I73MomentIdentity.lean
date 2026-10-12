import Mathlib

set_option linter.style.longLine false

/-!
# I73's span condition as one scalar in the moments

[reviews/2026-09-23-I73-route-RA.md](../../../reviews/2026-09-23-I73-route-RA.md) reduces
[I73](../../../plan.md) to the vanishing of one nonnegative scalar. This file types the identity
behind that reduction.

Writing `W² = a·W + (1/N)·Id + E` with `E` orthogonal to both `W` and `Id`, the residual's norm is
`⟨W²,W²⟩ - a² - 1/N` with `a = ⟨W²,W⟩`. **So I73 asks one number to vanish**, and that number is a
norm, hence nonnegative, hence a target rather than a restatement.

*Stated over an abstract real inner-product space with the normalisations as hypotheses, so nothing
here is about Weyl tensors, curvature, or criticality. Criticality enters only in
[I73SpanCondition.lean](I73SpanCondition.lean), which connects `W^#` to `W²`.*

## What is proved

* `residual_normSq`: the closed form `‖E‖² = ⟨sq,sq⟩ - a² - 1/N`.
* `span_iff_moment`: `E = 0`, which is `W² ∈ span{W, Id}`, exactly when
  `⟨sq,sq⟩ = a² + 1/N`.

## What is NOT stated

That `E = 0` is equivalent to a two-value spectrum (that is the minimal-polynomial step, and needs
the spectral theorem), that a maximiser satisfies it, or anything about `#`.

**And `E = 0 ↔ W² ∈ span{W, Id}` is NOT typed either.** *`span_iff_moment` types `E = 0` against
the scalar; reading `E = 0` as membership of the span is a step this file asserts in prose and does
not check* ([r1081](../../../reviews/REVIEW_r1081.md), which found it missing from this very list).
-/

namespace HamiltonsCubic.I73MomentIdentity

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

local notation "⟪" x ", " y "⟫" => (inner ℝ x y : ℝ)

/-- **The residual of `W²` against `span{W, Id}`, and its norm in closed form.**

*`hWW`, `hWI`, `hII`, `hsqI` are the normalisations: `W` is a unit vector orthogonal to `Id`, `Id`
has squared norm `N`, and `⟨W², Id⟩ = 1` is `Tr(W²) = ‖W‖² = 1`.* -/
theorem residual_normSq {W Id sq : V} {N a : ℝ} (hN : N ≠ 0)
    (hWW : ⟪W, W⟫ = 1) (hWI : ⟪W, Id⟫ = 0) (hII : ⟪Id, Id⟫ = N)
    (hsqI : ⟪sq, Id⟫ = 1) (ha : ⟪sq, W⟫ = a) :
    ⟪sq - a • W - (1/N) • Id, sq - a • W - (1/N) • Id⟫ = ⟪sq, sq⟫ - a^2 - 1/N := by
  have hIW : ⟪Id, W⟫ = 0 := by rw [real_inner_comm]; exact hWI
  have hIsq : ⟪Id, sq⟫ = 1 := by rw [real_inner_comm]; exact hsqI
  have hWsq : ⟪W, sq⟫ = a := by rw [real_inner_comm]; exact ha
  simp only [inner_sub_left, inner_sub_right, real_inner_smul_left, real_inner_smul_right,
    hWW, hWI, hII, hsqI, ha, hIW, hIsq, hWsq]
  field_simp
  ring

/-- **`W²` lies in `span{W, Id}` exactly when one moment equation holds.**

*The residual is zero iff its norm is, and the norm is the scalar above. This is
[I73](../../../plan.md)'s span condition as a single equation.* -/
theorem span_iff_moment {W Id sq : V} {N a : ℝ} (hN : N ≠ 0)
    (hWW : ⟪W, W⟫ = 1) (hWI : ⟪W, Id⟫ = 0) (hII : ⟪Id, Id⟫ = N)
    (hsqI : ⟪sq, Id⟫ = 1) (ha : ⟪sq, W⟫ = a) :
    sq - a • W - (1/N) • Id = 0 ↔ ⟪sq, sq⟫ - a^2 - 1/N = 0 := by
  rw [← residual_normSq hN hWW hWI hII hsqI ha]
  constructor
  · intro h; rw [h, inner_zero_left]
  · intro h; exact inner_self_eq_zero.mp h

end HamiltonsCubic.I73MomentIdentity
