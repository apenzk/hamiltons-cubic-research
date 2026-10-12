import Mathlib

set_option linter.style.longLine false

/-!
# I48, the one-negative case of L35: the relaxation gives `θ ≤ 0`, not merely `θ ≤ √(3/2)`

## What this file is

[L35](../../../findings/stratum-two-negative.md) proves `θ ≤ √(3/2)` for a unit-norm Weyl tensor
with **at most two** negative eigenvalues, but its argument is written for exactly two and **the
one-negative case is OWED**. *The line the block offered for it, `c → 0`, does not work: the
two-negative endgame maximises on the face `b = c`, which is `s² = 2 - 2u`, while the one-negative
locus is `bc = 0`, which is `s² = 1 - u` and sits strictly inside.*

**This file types the one-negative case directly instead of as a limit**, and what comes out is
stronger than the target.

## The setting, in the record's own letters

`A` is the top positive eigenvalue, `u = Σ_P λ²` over the positives, `d = u - A²`, and `s` is the
sum of the negative magnitudes. **Trace-freeness makes `s` the sum of the POSITIVES too**, so
`A ≤ s`: a single positive eigenvalue cannot exceed their total. With one negative eigenvalue the
term `-b³ - c³ + 6Abc` of [r63](../../../reviews/REVIEW_r63.md)'s relaxation collapses to `-s³`, and
its two `min` factors enter against `d ≥ 0` and `s² - u ≥ 0`, the latter being
`2 Σ_{a<b} λₐλ_b ≥ 0` over the positives.

## The derivation, which is three lines

Bound both minima by `A`. Then `A³ + A·d + A(s² - u) - s³` has its `A³` and `A·u` terms cancel
identically, leaving `A·s² - s³ = s²(A - s) ≤ 0`.

**`u` cancels.** *So the bound needs neither the unit norm nor the one-negative locus, only `A ≤ s`
and the two nonnegativity facts, which is why it is stronger than the case that motivated it.*

## Gate 2 replaced the route, 2026-09-17

**Both readers found a proof needing none of the relaxation below** ([r988](../../../reviews/REVIEW_r988.md),
[r989](../../../reviews/REVIEW_r989.md)). It reaches the SAME `s²(A - s)` from `T ≥ 0`, the pair cap,
`λ ≤ A` and `A ≤ s` alone, and is `theta_nonpos_direct` with `cube_le_top_mul_sq`. *The relaxation
route is kept as corroboration, since the two agreeing on the same expression by different means is
worth more than either alone.*

**Two corrections the readers made, both carried below.** *`P` is the NONNEGATIVE part, zeros
included: the `m = 4` witness has three zeros.* **And the exhaustion hypothesis is load-bearing**: a
second negative eigenvalue makes `s` no longer the nonnegatives' total, `A > s` becomes possible, and
the conclusion reverses.

**The stratum is NOT empty**, which was this file's own chief doubt: `m = 4` with `W₊ =
diag(1,1,-2)/√6` and `W₋ = 0` has spectrum `(1,1,-2,0,0,0)/√6`, exactly one negative, and
`W₊ = diag(1,-1,0)/√2` attains `θ = 0`, so the bound is sharp.

## What is proved

* `collapse`: the identity `A³ + A*d + A*(s² - u) - s³ = s²*(A - s)` whenever `d = u - A²`. *This is
  the whole content, and it is where a sign or a cancellation would go wrong unseen.*
* `one_negative_nonpos`: the relaxation's value is `≤ 0`, for any `m₁, m₂ ≤ A` standing for the two
  `min` factors, given `d ≥ 0`, `s² - u ≥ 0` and `A ≤ s`.
* `equality_iff_single_positive`: equality forces `A = s`, which is one positive eigenvalue.

## What is NOT stated

That the relaxation bounds `θ`, which is [L35](../../../findings/stratum-two-negative.md)'s chain
together with [r63](../../../reviews/REVIEW_r63.md)'s five lemmas, and that `A ≤ s` and
`s² - u ≥ 0` hold at a Weyl tensor, which are trace-freeness and Cauchy-Schwarz over the positives.
**Those enter as hypotheses here and are the record's, not this file's.**
-/

namespace HamiltonsCubic.I48OneNegative

/-- **The cancellation, which is the whole content.** With `d = u - A²`, the `A³` and `A·u` terms
cancel and the relaxation's `A`-envelope collapses to `s²(A - s)`. -/
theorem collapse (A s u d : ℝ) (hd : d = u - A ^ 2) :
    A ^ 3 + A * d + A * (s ^ 2 - u) - s ^ 3 = s ^ 2 * (A - s) := by
  subst hd; ring

/-- **The one-negative case gives `θ ≤ 0`.** `m₁` and `m₂` stand for the two `min` factors, each at
most `A`. *`u` never appears in the conclusion, so neither the unit norm nor the one-negative locus
is used: only `A ≤ s` and the two nonnegativity facts.* -/
theorem one_negative_nonpos (A s u d m₁ m₂ : ℝ)
    (hd : d = u - A ^ 2) (hd0 : 0 ≤ d) (hsu : 0 ≤ s ^ 2 - u)
    (hm₁ : m₁ ≤ A) (hm₂ : m₂ ≤ A) (hAs : A ≤ s) :
    A ^ 3 + m₁ * d + m₂ * (s ^ 2 - u) - s ^ 3 ≤ 0 := by
  have step : A ^ 3 + m₁ * d + m₂ * (s ^ 2 - u) - s ^ 3
      ≤ A ^ 3 + A * d + A * (s ^ 2 - u) - s ^ 3 := by
    have h₁ : m₁ * d ≤ A * d := by nlinarith
    have h₂ : m₂ * (s ^ 2 - u) ≤ A * (s ^ 2 - u) := by nlinarith
    linarith
  rw [collapse A s u d hd] at step
  nlinarith [sq_nonneg s]

/-- **Equality forces `A = s`**, which is a single positive eigenvalue, the spectrum `(1,-1)/√2`
where `θ = 0`. -/
theorem equality_iff_single_positive (A s u d : ℝ)
    (hd : d = u - A ^ 2) (hAs : A ≤ s) (hs : 0 < s)
    (heq : A ^ 3 + A * d + A * (s ^ 2 - u) - s ^ 3 = 0) :
    A = s := by
  rw [collapse A s u d hd] at heq
  have : s ^ 2 ≠ 0 := by positivity
  have := mul_eq_zero.mp heq
  rcases this with h | h
  · exact absurd h this
  · linarith

/-- **`Σ λ³ ≤ A · Σ λ²` when every `λ` lies in `[0, A]`.** *One of the two analytic steps of the
direct route, and the only one needing a sum rather than scalars.* -/
theorem cube_le_top_mul_sq {ι : Type*} (idx : Finset ι) (lam : ι → ℝ) (A : ℝ)
    (h0 : ∀ i ∈ idx, 0 ≤ lam i) (hA : ∀ i ∈ idx, lam i ≤ A) :
    ∑ i ∈ idx, lam i ^ 3 ≤ A * ∑ i ∈ idx, lam i ^ 2 := by
  rw [Finset.mul_sum]
  refine Finset.sum_le_sum fun i hi => ?_
  have h1 := h0 i hi
  have h2 := hA i hi
  nlinarith [sq_nonneg (lam i)]

/-- **THE DIRECT ROUTE, which needs none of the recorded relaxation.** `cube` is `Σ_P λ³`, `trip`
the triple term. The two analytic steps are `cube ≤ A·u` (every nonnegative eigenvalue is at most
`A`, which is `cube_le_top_mul_sq`) and `trip ≤ A(s² - u)` (the pair cap `Σ_c T_abc ≤ 2` against
`Σ_{a<b} λₐλ_b = (s² - u)/2`). Then `θ = cube - s³ + trip ≤ s²(A - s) ≤ 0`.

**No `G`, no `M`, no `h`, no `K₀` and no unit norm.** *Found by both Gate 2 readers of the
relaxation route below, independently of each other and of the parent.*

**THE EXHAUSTION HYPOTHESIS IS LOAD-BEARING AND IS `hAs`.** *`A ≤ s` holds because trace-freeness
makes `s` the total of the NONNEGATIVE eigenvalues, zeros included. With a second negative
eigenvalue `s` stops being that total, `A > s` becomes possible, and the conclusion reverses.* -/
theorem theta_nonpos_direct (A s u cube trip : ℝ)
    (hcube : cube ≤ A * u) (htrip : trip ≤ A * (s ^ 2 - u))
    (hAs : A ≤ s) :
    cube - s ^ 3 + trip ≤ 0 := by
  have chain : cube - s ^ 3 + trip ≤ s ^ 2 * (A - s) := by nlinarith
  nlinarith [sq_nonneg s]

/-- **The envelope UNCONDITIONALLY, with no case split**, which both Gate 2 readers reached
independently. Replacing both `min` factors by `A` gives exactly `s²(A - s) + 3bc(s + 2A)`, so the
owed case is precisely where the obstruction term `3bc(s + 2A)` vanishes.

*The algebra is `s³ - b³ - c³ = 3bcs` at `s = b + c`.* -/
theorem envelope_unconditional (A s u d b c : ℝ) (hd : d = u - A ^ 2) (hbc : s = b + c) :
    A ^ 3 + A * d + A * (s ^ 2 - u) - b ^ 3 - c ^ 3 + 6 * A * b * c
      = s ^ 2 * (A - s) + 3 * b * c * (s + 2 * A) := by
  subst hd; subst hbc; ring

end HamiltonsCubic.I48OneNegative
