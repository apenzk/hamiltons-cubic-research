import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset

/-!
# L66, no maximiser is `∘`-decomposable

[support-dichotomy.md](../../../findings/support-dichotomy.md)'s Lemma L66. The additivity
step is geometry and stays imported; **the chain that turns additivity into the theorem is
carried here**, together with the two hypotheses the chain needs.

The chain is `P(W) = Σaᵢ³P(Aᵢ) ≤ M Σ|aᵢ|³ ≤ M·max|aᵢ| < M`, and each link needs something:

* `Σ|aᵢ|³ ≤ max|aᵢ| · Σaᵢ²` is pointwise, `|a|³ = |a|·a²`.
* `max|aᵢ| < 1` needs `k ≥ 2` **and** every `aᵢ ≠ 0`, two coefficients cannot both be
  units when their squares sum to one.
* The final `<` needs **`M(n) > 0`**, which the record takes from Nienhaus's Proposition 2.25:
  `S^k × S^l` with `k, l ≥ 2` has `P = θ_{k,l} > 0`.

**The absolute values are load-bearing, with an exact witness.** With `aᵢ³` in place of
`|aᵢ|³` the chain is false at any negative coefficient: at `(a,b) = (3/5, -4/5)` with pieces
at `±M`, the true value is `91/125·M` against a claimed bound of `-37/125·M`. Both are exact
rationals, so the failure is not a rounding artefact.
-/

namespace HamiltonsCubic.Decomposable

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-! ## The two inequality steps -/

/-- **`Σ|aᵢ|³ ≤ max|aᵢ| · Σaᵢ²`**, pointwise from `|a|³ = |a|·a²`. -/
theorem sum_abs_cube_le {a : ι → ℝ} {m : ℝ} (hm : ∀ i, |a i| ≤ m) :
    ∑ i, |a i| ^ 3 ≤ m * ∑ i, (a i) ^ 2 := by
  rw [Finset.mul_sum]
  refine Finset.sum_le_sum fun i _ => ?_
  have h1 : |a i| ^ 3 = |a i| * (a i) ^ 2 := by
    rw [pow_succ, sq_abs]; ring
  rw [h1]
  exact mul_le_mul_of_nonneg_right (hm i) (sq_nonneg _)

/-- **`|aⱼ| < 1` when some other coefficient is nonzero**, which is what `k ≥ 2` with every
`aᵢ ≠ 0` supplies. Both hypotheses are needed: one coefficient alone reaches `1`. -/
theorem coeff_lt_one {a : ι → ℝ} (hnorm : ∑ i, (a i) ^ 2 = 1) {j k : ι} (hjk : j ≠ k)
    (hk : a k ≠ 0) : |a j| < 1 := by
  classical
  have hpair : (a j) ^ 2 + (a k) ^ 2 ≤ ∑ i, (a i) ^ 2 := by
    have hsub : ({j, k} : Finset ι) ⊆ univ := subset_univ _
    have hsd := Finset.sum_sdiff (f := fun i => (a i) ^ 2) hsub
    have hrest : 0 ≤ ∑ i ∈ univ \ ({j, k} : Finset ι), (a i) ^ 2 :=
      Finset.sum_nonneg fun i _ => sq_nonneg _
    have hp : ∑ i ∈ ({j, k} : Finset ι), (a i) ^ 2 = (a j) ^ 2 + (a k) ^ 2 :=
      Finset.sum_pair hjk
    linarith [hsd, hrest, hp]
  have hkpos : 0 < (a k) ^ 2 := by positivity
  have : (a j) ^ 2 < 1 := by linarith [hpair, hnorm, hkpos]
  have habs : |a j| ^ 2 < 1 := by rwa [sq_abs]
  nlinarith [habs, abs_nonneg (a j)]

/-! ## The chain, with the hypothesis each link needs -/

/-- **The theorem's inequality.** Given additivity, the piecewise bound `|P(Aᵢ)| ≤ M`, the
norm condition, two distinct nonzero coefficients and **`M > 0`**, the value is strictly
below `M`, so a decomposable point is not a maximiser. -/
theorem strict_below {a : ι → ℝ} {P : ι → ℝ} {M PW : ℝ}
    (hM : 0 < M) (hPi : ∀ i, |P i| ≤ M)
    (hadd : PW = ∑ i, (a i) ^ 3 * P i)
    (hnorm : ∑ i, (a i) ^ 2 = 1)
    {j k : ι} (hjk : j ≠ k) (hj : a j ≠ 0) (hk : a k ≠ 0)
    (hbound : ∀ i, |a i| ≤ max |a j| |a k|) :
    PW < M := by
  classical
  set m := max |a j| |a k| with hm
  have hmlt : m < 1 := by
    rw [hm]
    exact max_lt (coeff_lt_one hnorm hjk hk) (coeff_lt_one hnorm (Ne.symm hjk) hj)
  have hterm : ∀ i ∈ univ, (a i) ^ 3 * P i ≤ M * |a i| ^ 3 := by
    intro i _
    have h1 : (a i) ^ 3 * P i ≤ |a i| ^ 3 * |P i| := by
      calc (a i) ^ 3 * P i ≤ |(a i) ^ 3 * P i| := le_abs_self _
        _ = |a i| ^ 3 * |P i| := by simp [abs_mul, abs_pow]
    calc (a i) ^ 3 * P i ≤ |a i| ^ 3 * |P i| := h1
      _ ≤ |a i| ^ 3 * M := mul_le_mul_of_nonneg_left (hPi i) (by positivity)
      _ = M * |a i| ^ 3 := by ring
  have hsum : PW ≤ M * ∑ i, |a i| ^ 3 := by
    have h := Finset.sum_le_sum hterm
    rw [hadd]
    calc ∑ i, (a i) ^ 3 * P i ≤ ∑ i, M * |a i| ^ 3 := h
      _ = M * ∑ i, |a i| ^ 3 := by rw [Finset.mul_sum]
  have hcube := sum_abs_cube_le (a := a) (m := m) hbound
  rw [hnorm, mul_one] at hcube
  have : PW ≤ M * m := by
    calc PW ≤ M * ∑ i, |a i| ^ 3 := hsum
      _ ≤ M * m := mul_le_mul_of_nonneg_left hcube (le_of_lt hM)
  nlinarith [this, hmlt, hM]

/-! ## The absolute values are load-bearing -/

/-- At `(a, b) = (3/5, -4/5)` the coefficients are admissible: their squares sum to `1` and
neither vanishes. -/
theorem witness_admissible : ((3 : ℚ) / 5) ^ 2 + (-(4 : ℚ) / 5) ^ 2 = 1 := by norm_num

/-- **The true value is `91/125 · M`**, pieces at `+M` and `-M`. -/
theorem witness_true_value :
    ((3 : ℚ) / 5) ^ 3 * 1 + (-(4 : ℚ) / 5) ^ 3 * (-1) = 91 / 125 := by norm_num

/-- **The chain without absolute values claims `-37/125 · M`.** -/
theorem witness_claimed_bound : ((3 : ℚ) / 5) ^ 3 + (-(4 : ℚ) / 5) ^ 3 = -37 / 125 := by
  norm_num

/-- **So the chain is false there**, and by a margin of `128/125`, larger than `M` itself. -/
theorem witness_fails : (-37 : ℚ) / 125 < 91 / 125 := by norm_num

theorem witness_margin : (91 : ℚ) / 125 - (-37 / 125) = 128 / 125 := by norm_num

/-- With absolute values the bound holds at the same point: `Σ|aᵢ|³ = 91/125 < 1`. -/
theorem witness_with_abs : |(3 : ℚ) / 5| ^ 3 + |-(4 : ℚ) / 5| ^ 3 = 91 / 125 := by
  norm_num

/-! ## `M(4) > θ₀(4)`, which refutes the withdrawn inductive claim -/

/-- `M(4)² = 3/2` against `θ₀(4)² = 3/4`, so the inductive claim `|θᵢ| ≤ θ₀(nᵢ)` is **false**
at the one base case that is proved. -/
theorem theta0_four : 2 * (4 - 1 : ℚ) * (4 - 2) / 4 ^ 2 = 3 / 4 := by norm_num

theorem M4_exceeds : (3 : ℚ) / 4 < 3 / 2 := by norm_num

/-- The gap is a factor of two in the square, so the refutation is not marginal. -/
theorem M4_ratio : (3 : ℚ) / 2 = 2 * (3 / 4) := by norm_num

end HamiltonsCubic.Decomposable
