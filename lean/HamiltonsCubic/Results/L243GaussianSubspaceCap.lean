import Mathlib

set_option linter.style.longLine false

/-!
# L243, the Gaussian subspace cap at every dimension, in class form

## The record's statement, quoted from [second-order.md](../../../findings/second-order.md)

> Let $X_1,\dots,X_k$ be orthonormal in $\mathfrak{so}(n)$, any $k$, with $P=\sum_i(-X_i^2)$ and
> $T=\sum_{i\ne j}\lVert[X_i,X_j]\rVert^2$. Then
> $T\le(1-\tfrac1r)(4k^2+2\operatorname{tr}P^2)-4k(k-1)$, $r=\min(k,n-1)$.

## What is typed here

`gaussian_cap`: from the Gaussian form of L238 (i), `T = E − 4k(k−1)`, and the rank bound on the Gram
matrix, `E ≤ (1 − 1/r)(4k² + 2 tr P²)`, taken as hypotheses exactly as
[FrameGaussianBound.lean](FrameGaussianBound.lean) takes `hT`, the cap follows. `whole_algebra_tight`:
at `n = 12`, `k = 66`, `tr P² = 12 · 11²`, the right side is `1320`, the whole algebra's bracket total. `L242_excluded`: at L242's class
values the left side `464` exceeds the right side `28800/11 − 2208`. `L241_satisfies`: `196` does not.

## What is NOT typed here

**The Gaussian form itself and the rank bound** (Isserlis' fourth moment and `rank G ≤ min(k, n−1)`),
which L238's file also leaves as hypotheses; and the class-form reading `tr P² = ∑ G_ab`,
`T = ∑ τ_abc`, which is the definition of the class variables on `Λ²ℝⁿ`.
-/

namespace HamiltonsCubic.L243GaussianSubspaceCap

/-- **The cap, from its two analytic inputs.** -/
theorem gaussian_cap (k r trP2 T E : ℝ)
    (hT : T = E - 4 * k * (k - 1))
    (hE : E ≤ (1 - 1 / r) * (4 * k ^ 2 + 2 * trP2)) :
    T ≤ (1 - 1 / r) * (4 * k ^ 2 + 2 * trP2) - 4 * k * (k - 1) := by
  rw [hT]; linarith

/-- The right side of the cap. -/
noncomputable def capRHS (k r trP2 : ℚ) : ℚ := (1 - 1 / r) * (4 * k ^ 2 + 2 * trP2) - 4 * k * (k - 1)

/-- **Tight on the whole algebra** at `n = 12`: `k = 66`, `P = 11 I₁₂`, `r = 11`; the right side equals `66 · 20`, the left side (the bracket total of `𝔰𝔬(12)`) being prose. -/
theorem whole_algebra_tight : capRHS 66 11 (12 * 11 ^ 2) = 66 * 20 := by
  norm_num [capRHS]

/-- **L242's point violates the cap**: `S = {0,2}`, `k = 24`, `∑ G = 72 + 2·72 + 72 = 288`. -/
theorem L242_excluded : capRHS 24 11 288 < 464 := by
  norm_num [capRHS]

/-- **L241's point satisfies it**: `k = 14`, `∑ G = 4 · 77/2 = 154`, total `196`. -/
theorem L241_satisfies : (196 : ℚ) ≤ capRHS 14 11 154 := by
  norm_num [capRHS]

end HamiltonsCubic.L243GaussianSubspaceCap
