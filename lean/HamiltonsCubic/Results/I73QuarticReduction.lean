import Mathlib

set_option linter.style.longLine false

/-!
# The internal-mass cap follows from a quartic bound on `Π#Π`: the scalar core

[The D6 working note](../../../reviews/2026-09-26-I73-class-ceiling.md), batch 19. For the compressed operator
`K_V` with eigenvalues `λ₁,…,λ_d ≥ 0`, `M(V) = ∑ λᵢ` and `‖K_V‖_F² = ∑ λᵢ² ≤ ‖2Π#Π‖_F²`.

## What is proved

* `sum_sq_le_card_mul`: `(∑ λᵢ)² ≤ d · ∑ λᵢ²`, the Cauchy–Schwarz step `M(V)² ≤ d tr K_V²`.
* `theta_le_of_quartic`: from `2 d^{3/2} θ ≤ M`, `M ≤ 2 √d B` and `B ≤ (n-2) d / √N` (written with `s = √d`,
  `q = √N`), `θ ≤ (n-2)/√N`.

## What is NOT stated

The operator steps (`K_V ⪯` compression of `2Π#Π`, `‖π B π‖_F ≤ ‖B‖_F`), L255's floor, and the quartic bound
itself, which is open; all enter as hypotheses.
-/

namespace HamiltonsCubic.I73QuarticReduction

open Finset

theorem sum_sq_le_card_mul {ι : Type*} (s : Finset ι) (l : ι → ℝ) :
    (∑ i ∈ s, l i) ^ 2 ≤ (s.card : ℝ) * ∑ i ∈ s, l i ^ 2 := by
  exact sq_sum_le_card_mul_sum_sq

/-- **The chain**: `θ ≤ M/(2 d^{3/2}) ≤ B/d ≤ (n-2)/√N`, with `s = √d > 0`, `d = s²`, `q = √N`. -/
theorem theta_le_of_quartic (θ M B s q n : ℝ) (hs : 0 < s)
    (hfloor : 2 * (s ^ 2 * s) * θ ≤ M) (hcs : M ≤ 2 * s * B) (hquartic : B ≤ (n - 2) * s ^ 2 / q) :
    θ ≤ (n - 2) / q := by
  have h1 : 2 * (s ^ 2 * s) * θ ≤ 2 * s * ((n - 2) * s ^ 2 / q) :=
    hfloor.trans (hcs.trans (by nlinarith))
  have h2 : 2 * (s ^ 2 * s) * θ ≤ 2 * (s ^ 2 * s) * ((n - 2) / q) := by
    have : 2 * s * ((n - 2) * s ^ 2 / q) = 2 * (s ^ 2 * s) * ((n - 2) / q) := by ring
    linarith
  exact le_of_mul_le_mul_left h2 (by positivity)

end HamiltonsCubic.I73QuarticReduction
