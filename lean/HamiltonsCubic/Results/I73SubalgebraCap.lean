import Mathlib

set_option linter.style.longLine false

/-!
# The internal-mass cap on subalgebras: the arithmetic

[The D6 working note](../../../reviews/2026-09-26-I73-class-ceiling.md), batch 17. A compact subalgebra of
`so(n)` has internal mass `M = ∑ dᵢ Cᵢ` over its simple ideals (`Cᵢ = 4h^∨/ℓ`), and the cap compares
`M/d^{3/2}` with the whole algebra's `2(n-2)/√N`, `N = n(n-1)/2`.

## What is proved

* `sum_three_halves_le`: `∑ dᵢ √dᵢ ≤ (∑ dᵢ) √(∑ dᵢ)` for `dᵢ ≥ 0`, so a subalgebra's ratio is at most the
  largest ratio of its ideals (`ratio_le_of_parts`).
* `sok_ratio_mono`: for `2 ≤ k ≤ n`, `(k-2)² · n(n-1) ≤ (n-2)² · k(k-1)`, so `so(k)`'s ratio
  `2(k-2)/√(k(k-1)/2)` is at most `so(n)`'s.
* `sok_beats_su2`: for `n ≥ 9`, `3(n-2)² > 2n(n-1)`, i.e. `2(n-2)/√N > 4/√3`, the best non-orthogonal ratio.
* `whole_below_theta0`: `(n-2)² · n² < (n-1)(n-2) · n(n-1)` for `n ≥ 3`, i.e. `√2(n-2)/√(n(n-1)) < θ₀(n)`.

## What is NOT stated

The Casimir formula `C = 4h^∨/ℓ`, the table of minimal Dynkin indices, and the non-orthogonal types' bound
`2.309`; these are the classical input the note quotes.
-/

namespace HamiltonsCubic.I73SubalgebraCap

open Finset

theorem sum_three_halves_le {ι : Type*} (s : Finset ι) (d : ι → ℝ) (hd : ∀ i ∈ s, 0 ≤ d i) :
    ∑ i ∈ s, d i * Real.sqrt (d i) ≤ (∑ i ∈ s, d i) * Real.sqrt (∑ i ∈ s, d i) := by
  rw [sum_mul]
  apply sum_le_sum
  intro i hi
  apply mul_le_mul_of_nonneg_left _ (hd i hi)
  exact Real.sqrt_le_sqrt (single_le_sum (f := d) hd hi)

/-- **A subalgebra's ratio is at most the largest ratio of its ideals.** -/
theorem ratio_le_of_parts {ι : Type*} (s : Finset ι) (d M : ι → ℝ) (c : ℝ) (hc : 0 ≤ c)
    (hd : ∀ i ∈ s, 0 ≤ d i) (hM : ∀ i ∈ s, M i ≤ c * (d i * Real.sqrt (d i))) :
    ∑ i ∈ s, M i ≤ c * ((∑ i ∈ s, d i) * Real.sqrt (∑ i ∈ s, d i)) := by
  calc ∑ i ∈ s, M i ≤ ∑ i ∈ s, c * (d i * Real.sqrt (d i)) := sum_le_sum hM
    _ = c * ∑ i ∈ s, d i * Real.sqrt (d i) := by rw [mul_sum]
    _ ≤ c * ((∑ i ∈ s, d i) * Real.sqrt (∑ i ∈ s, d i)) :=
        mul_le_mul_of_nonneg_left (sum_three_halves_le s d hd) hc

/-- **`so(k)`'s ratio increases with `k`**, in squared form. -/
theorem sok_ratio_mono (k n : ℝ) (hk : 2 ≤ k) (hkn : k ≤ n) :
    (k - 2) ^ 2 * (n * (n - 1)) ≤ (n - 2) ^ 2 * (k * (k - 1)) := by
  nlinarith [mul_nonneg (sub_nonneg.2 hkn) (sub_nonneg.2 hk), mul_nonneg (sub_nonneg.2 hkn) (by linarith : (0:ℝ) ≤ k - 1),
    mul_nonneg (mul_nonneg (sub_nonneg.2 hkn) (sub_nonneg.2 hk)) (by linarith : (0:ℝ) ≤ k + n - 2)]

/-- **The whole algebra's value lies strictly below `θ₀(n)`**, in squared form. -/
theorem whole_below_theta0 (n : ℝ) (hn : 3 ≤ n) :
    (n - 2) ^ 2 * n ^ 2 < (n - 1) * (n - 2) * (n * (n - 1)) := by
  have h : (n - 2) * n < (n - 1) ^ 2 := by nlinarith
  have hpos : 0 < (n - 2) * n := by nlinarith
  nlinarith [mul_lt_mul_of_pos_left h hpos]

/-- **From `n = 9` the whole algebra beats `su(2)` on `ℝ⁴`**: `(2(n-2)/√N)² > 16/3`. -/
theorem sok_beats_su2 (n : ℝ) (hn : 9 ≤ n) : 2 * n * (n - 1) < 3 * (n - 2) ^ 2 := by
  nlinarith

end HamiltonsCubic.I73SubalgebraCap
