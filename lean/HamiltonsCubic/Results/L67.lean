import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.LinearCombination

/-!
# L67, the second-kind spectrum of the balanced product

[bispectral.md](../../../findings/bispectral.md)'s Lemma L67. The spectrum
`mA` at `(m-1)(m+2)`, `-(m-1)A` at `m²`, `-2m(m-1)A` at `1` is imported; every count and
constant built on it is checked here.

**`A` comes from `Σω² = 3`.** Summing squares over the tabulated spectrum gives
`A² · 3m²(m-1)(2m-1)`, so **`Σω² = 3` returns `A = 1/(m√((m-1)(2m-1)))`**. The record's
`‖W‖_F = 1` is the same condition, by Lemma L50's norm relation `Σω² = 3Σμ²`.

**A check the record does not state: the spectrum is traceless.**
`(m-1)(m+2)·m + m²·(-(m-1)) + 1·(-2m(m-1)) = 0` identically in `m`, which is a condition on
the multiplicities and eigenvalues jointly that the block never uses.

**Why `m ≥ 2` is not supplied by the multiplicity check.** That identity is a polynomial one
and holds at `m = 1` as well; what fails at `m = 1` is `A` itself, whose denominator
`m²(m-1)(2m-1)` vanishes there. So the hypothesis is about the constant, not the counts,
which is where the hypothesis bites.
-/

namespace HamiltonsCubic.SecondKind

/-! ## The multiplicities -/

/-- **They sum to `dim S²₀(ℝ^{2m}) = 2m² + m - 1`**, identically in `m`. -/
theorem multiplicities_sum (m : ℚ) :
    (m - 1) * (m + 2) + m ^ 2 + 1 = 2 * m ^ 2 + m - 1 := by ring

/-- And that is the dimension: `2m(2m+1)/2 - 1`. -/
theorem dim_S2_zero (m : ℚ) : 2 * m * (2 * m + 1) / 2 - 1 = 2 * m ^ 2 + m - 1 := by ring

/-! ## The spectrum is traceless, a check the block does not make -/

/-- **`Σ multiplicity × eigenvalue = 0`**, identically in `m` and `A`. -/
theorem spectrum_traceless (m A : ℚ) :
    (m - 1) * (m + 2) * (m * A) + m ^ 2 * (-((m - 1) * A))
      + 1 * (-(2 * m * (m - 1) * A)) = 0 := by ring

/-! ## `A` is pinned by `Σω² = 3` -/

/-- The sum of squares over the second-kind spectrum is `3m²(m-1)(2m-1) A²`. -/
theorem sum_squares (m A : ℚ) :
    (m - 1) * (m + 2) * (m * A) ^ 2 + m ^ 2 * ((m - 1) * A) ^ 2
      + 1 * (2 * m * (m - 1) * A) ^ 2
      = 3 * m ^ 2 * (m - 1) * (2 * m - 1) * A ^ 2 := by ring

/-- **So `Σω² = 3` gives `A² = 1/(m²(m-1)(2m-1))`**, the record's `A`, squared. The
first-kind normalisation `Σμ² = 1` is a sum over a different spectrum and does not reach
this constant. -/
theorem A_from_omega (m A : ℚ) (hm : 2 ≤ m)
    (hnorm : 3 * m ^ 2 * (m - 1) * (2 * m - 1) * A ^ 2 = 3) :
    A ^ 2 * (m ^ 2 * (m - 1) * (2 * m - 1)) = 1 := by
  linear_combination hnorm / 3

/-- The record's `A` satisfies it: `A² · m²(m-1)(2m-1) = 1` is exactly
`A = 1/(m√((m-1)(2m-1)))` with the radical squared away. -/
theorem A_closed_form (m : ℚ) (hm : 2 ≤ m) :
    (1 / (m ^ 2 * ((m - 1) * (2 * m - 1)))) * (m ^ 2 * (m - 1) * (2 * m - 1)) = 1 := by
  have h0 : m ≠ 0 := by intro h; linarith
  have h1 : m - 1 ≠ 0 := by intro h; linarith
  have h2 : 2 * m - 1 ≠ 0 := by intro h; linarith
  have hX : m ^ 2 * ((m - 1) * (2 * m - 1)) = m ^ 2 * (m - 1) * (2 * m - 1) := by ring
  have hne : m ^ 2 * (m - 1) * (2 * m - 1) ≠ 0 :=
    mul_ne_zero (mul_ne_zero (pow_ne_zero 2 h0) h1) h2
  rw [hX]
  exact one_div_mul_cancel hne

/-! ## The `m ≥ 2` hypothesis, and why the counts cannot supply it -/

/-- **The multiplicity identity holds at `m = 1` too**, so it cannot detect the hypothesis,
so the hypothesis is about `A`. -/
theorem multiplicities_at_one : (1 - 1 : ℚ) * (1 + 2) + 1 ^ 2 + 1 = 2 * 1 ^ 2 + 1 - 1 := by
  norm_num

/-- **What fails at `m = 1` is `A`**: its denominator vanishes. So the hypothesis is about the
constant, not the counts. -/
theorem A_denominator_vanishes : (1 : ℚ) ^ 2 * (1 - 1) * (2 * 1 - 1) = 0 := by norm_num

/-! ## The `S³ × S³` corroboration -/

/-- At `m = 3`, `A² = 1/90`. -/
theorem A_sq_at_three : (1 : ℚ) / (3 ^ 2 * ((3 - 1) * (2 * 3 - 1))) = 1 / 90 := by norm_num

/-- **The `B`-block value is `(m-1)A = 2A`**, and `(2A)² = 4/90 = 2/45` brackets
[nondegeneracy.md](../../../findings/nondegeneracy.md)'s `0.210818511`. -/
theorem B_block_sq : (2 : ℚ) ^ 2 * (1 / 90) = 2 / 45 := by norm_num

theorem B_block_bracket :
    ((210818510 : ℚ) / 1000000000) ^ 2 < 2 / 45
      ∧ (2 : ℚ) / 45 < ((210818512 : ℚ) / 1000000000) ^ 2 := by
  constructor <;> norm_num

/-- **And the bottom eigenvalue is `-2m(m-1)A`**, which at `m = 3` is `-12A` with
`(12A)² = 144/90 = 8/5`, the value *"every citer takes"* and which the canon did not
previously state. -/
theorem bottom_sq_at_three : (12 : ℚ) ^ 2 * (1 / 90) = 8 / 5 := by norm_num

end HamiltonsCubic.SecondKind
