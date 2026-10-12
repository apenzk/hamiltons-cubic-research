import Mathlib

set_option linter.style.longLine false

/-!
# The symmetric three-value family reduces to an internal bracket-mass cap

[The D6 working note](../../../reviews/2026-09-26-I73-class-ceiling.md), batch 16. At a unit critical point
with spectrum `(-a, 0, a)`, `a = 1/√(2p)`, write `V = E₀ ⊕ E₂` (`d = 2p`) and let `X, Y, S, U` be the class
bracket totals `T₀₀₀, T₂₂₂, T₀₀₂, T₂₂₀` (ordered sums of `⟨[u,v],w⟩²`), so the internal bracket mass of `V` is
`M = X + Y + 3S + 3U`. Rows (C) of [L244](../../../findings/second-order.md), summed over orthonormal bases of
`E₀` and `E₂`, read `2S - X - U = 2pK` and `2U - S - Y = 2p(2 - K)` with `K = 1 + θ√(2p)`.

## What is proved

* `mass_ge_of_rows`: those two rows and `X, U ≥ 0` give `4p(K - 1) ≤ M`, i.e. `θ ≤ M/(2 d^{3/2})`.
* `sum_cube_le`: for any finite family of reals, `∑ xᵢ³ ≤ (∑ xᵢ²) · √(∑ xᵢ²)`, the eigenvalue form of
  `tr Z³ ≤ (tr Z²)^{3/2}`.
* `theta_le_four`: with `M ≤ 8 d √d` (which is `M = 8 tr Z³`, `tr Z² = d` and `sum_cube_le`), `θ ≤ 4`.

## What is NOT stated

The operator identity `Π#Π = 2(P₀#P₀ + P₂#P₂) + K P₀ + (2 - K) P₂`, the per-vector rows, the reading of the
class totals, and the matrix identity `M(V) = 8 tr((∑ Uᵢ ⊗ Uᵢ)³)` with `tr = 0`, `tr² = d`; all enter as
hypotheses.
-/

namespace HamiltonsCubic.I73InternalMass

open Finset

/-- **Rows (C) summed give the internal-mass floor.** -/
theorem mass_ge_of_rows (p K X Y S U : ℝ) (hX : 0 ≤ X) (hU : 0 ≤ U)
    (hC0 : 2 * S - X - U = 2 * p * K) (hC2 : 2 * U - S - Y = 2 * p * (2 - K)) :
    4 * p * (K - 1) ≤ X + Y + 3 * S + 3 * U := by
  nlinarith

/-- **The cubic sum is at most the three-halves power of the square sum.** -/
theorem sum_cube_le {ι : Type*} (s : Finset ι) (x : ι → ℝ) :
    ∑ i ∈ s, x i ^ 3 ≤ (∑ i ∈ s, x i ^ 2) * Real.sqrt (∑ i ∈ s, x i ^ 2) := by
  have hQ : 0 ≤ ∑ i ∈ s, x i ^ 2 := sum_nonneg (fun i _ => sq_nonneg _)
  have hterm : ∀ i ∈ s, x i ^ 3 ≤ x i ^ 2 * Real.sqrt (∑ j ∈ s, x j ^ 2) := by
    intro i hi
    have hsq : x i ^ 2 ≤ ∑ j ∈ s, x j ^ 2 :=
      single_le_sum (f := fun j => x j ^ 2) (fun j _ => sq_nonneg _) hi
    have habs : |x i| ≤ Real.sqrt (∑ j ∈ s, x j ^ 2) := by
      rw [← Real.sqrt_sq_eq_abs]; exact Real.sqrt_le_sqrt hsq
    have h1 : x i ^ 3 ≤ x i ^ 2 * |x i| := by
      have : x i ^ 3 = x i ^ 2 * x i := by ring
      rw [this]; exact mul_le_mul_of_nonneg_left (le_abs_self _) (sq_nonneg _)
    exact h1.trans (mul_le_mul_of_nonneg_left habs (sq_nonneg _))
  calc ∑ i ∈ s, x i ^ 3 ≤ ∑ i ∈ s, x i ^ 2 * Real.sqrt (∑ j ∈ s, x j ^ 2) := sum_le_sum hterm
    _ = (∑ i ∈ s, x i ^ 2) * Real.sqrt (∑ i ∈ s, x i ^ 2) := by rw [sum_mul]

/-- **Every symmetric three-value critical point has `θ ≤ 4`**, given the floor and the cubic-trace cap. Here
`r = √(2p)`, so `d^{3/2} = 2p · r`; only `r > 0` is used. -/
theorem theta_le_four (p θ r M : ℝ) (hp : 0 < p) (hr : 0 < r)
    (hfloor : 4 * p * (θ * r) ≤ M) (hcap : M ≤ 8 * (2 * p) * r) : θ ≤ 4 := by
  have h : 4 * p * r * θ ≤ 4 * p * r * 4 := by nlinarith
  have hpos : 0 < 4 * p * r := by positivity
  exact le_of_mul_le_mul_left h hpos

/-- The hypotheses of `mass_ge_of_rows` are satisfiable (non-vacuity): `p = 1`, `K = 3`. -/
example : ∃ X Y S U : ℝ, 0 ≤ X ∧ 0 ≤ U ∧ 0 ≤ Y ∧ 2 * S - X - U = 2 * 1 * 3 ∧
    2 * U - S - Y = 2 * 1 * (2 - 3) :=
  ⟨0, 1/2, 7/2, 1, le_refl _, by norm_num, by norm_num, by norm_num, by norm_num⟩

end HamiltonsCubic.I73InternalMass
