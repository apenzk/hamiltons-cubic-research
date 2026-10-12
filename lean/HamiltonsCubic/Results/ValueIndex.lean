import HamiltonsCubic.Results.CPSweep
import HamiltonsCubic.Results.Band

/-!
# Exact forms for the value index's decimals

[INDEX-values.md](../../../findings/INDEX-values.md) is the record's catalogue of
catalogued values, and its own preamble says three refutations were missed because
searches used *"the vocabulary of the construction rather than the value"*.

**Several of its rows carry a decimal and no exact form.** Five of them follow from
closed forms the record already holds, and are supplied here:

| index row | exact `θ²` |
|---|---|
| `1.324617`, `S¹¹×S¹³` at `n = 24` | `2760/1573` |
| `1.236033 = θ₀(12)` | `55/36` |
| `1.200000 = θ₀(10)` | `36/25`, so `θ = 6/5`, **rational** |
| `1.145644 = θ₀(8)` | `21/16`, so `θ = √21/4` |
| `0.986013`, `ℂP⁴` | `35/36` |
| `0.948683`, `ℂP⁵` | `9/10` |

**A sixth is offered as a candidate, not asserted**, see the last section.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.ValueIndex

open HamiltonsCubic.SphereProducts HamiltonsCubic.FamilyMeet HamiltonsCubic.Theta0

/-! ## The five that follow from the record's own closed forms -/

theorem row_1_324617 : thetaSq 11 13 = 2760 / 1573 := by norm_num [thetaSq]
theorem row_1_236033 : thetaSq 6 6 = 55 / 36 := by norm_num [thetaSq]
theorem row_1_145644 : thetaSq 4 4 = 21 / 16 := by norm_num [thetaSq]
theorem row_0_986013 : cpSq 4 = 35 / 36 := by norm_num [cpSq]
theorem row_0_948683 : cpSq 5 = 9 / 10 := by norm_num [cpSq]

/-- **`θ₀(10)` is rational**: `θ² = 36/25`, so `θ = 6/5` exactly. The index prints
`1.200000`, six places of a number with no decimal expansion to speak of. -/
theorem row_1_200000 : thetaSq 5 5 = (6 / 5 : ℚ) ^ 2 := by norm_num [thetaSq]

/-- `θ₀(8) = √21/4`. -/
theorem theta0_8_form : thetaSq 4 4 = 21 / 4 ^ 2 := by norm_num [thetaSq]

/-- `θ₀(12) = √55/6`. -/
theorem theta0_12_form : thetaSq 6 6 = 55 / 6 ^ 2 := by norm_num [thetaSq]

/-! ## The rows that already carry forms check too

Two rows give their fractions unreduced, `Θ₁₅² = 336/208` and `Θ₁₃² = 240/154`. Both
reduce, and both agree with the closed form.
-/

theorem row_1_270978 : thetaSq 7 8 = 336 / 208 := by norm_num [thetaSq]
theorem row_1_270978_reduced : (336 : ℚ) / 208 = 21 / 13 := by norm_num

theorem row_1_248376 : thetaSq 6 7 = 240 / 154 := by norm_num [thetaSq]
theorem row_1_248376_reduced : (240 : ℚ) / 154 = 120 / 77 := by norm_num

/-- **And `120/77` is one of the census's coincident values**, the index's `S⁶×S⁷` row is
also `S⁵×S¹¹` at `n = 16`, which the index does not note although it notes the
`ℍP²`/`S³×S⁵` pair at `1.115547`. -/
theorem row_1_248376_shared : thetaSq 6 7 = thetaSq 5 11 := by norm_num [thetaSq]

/-! ## A candidate, offered and not asserted

The index carries three values for the `(𝔰𝔲(k),𝔰𝔬(k))` family and no closed form:
`1.095445` at `n = 6`, `1.035098` at `n = 10`, `1.024695` at `n = 12`. Squared they are
`6/5`, `15/14` and `21/20`.

With `N = k(k+1)/2` and `n = 2k`, those are `N/(N-1)` at `k = 3, 5, 6`. **This is a fit to
three points and is recorded as a candidate for the record to confirm or reject**, the
same discipline as [F26.lean](HamiltonsCubic/Results/F26.lean)'s. `N` is the dimension of
`SU(k)/SO(k)`, which is what makes the guess worth writing down rather than what makes it
true.
-/

theorem candidate_k3 : (6 : ℚ) / 5 = (3 * 4 / 2) / (3 * 4 / 2 - 1) := by norm_num
theorem candidate_k5 : (15 : ℚ) / 14 = (5 * 6 / 2) / (5 * 6 / 2 - 1) := by norm_num
theorem candidate_k6 : (21 : ℚ) / 20 = (6 * 7 / 2) / (6 * 7 / 2 - 1) := by norm_num

/-- The three printed decimals square to those rationals, to the places printed. -/
theorem decimals_match :
    (1.035097 : ℚ) ^ 2 < 15 / 14 ∧ (15 : ℚ) / 14 < (1.035099 : ℚ) ^ 2 ∧
    (1.024694 : ℚ) ^ 2 < 21 / 20 ∧ (21 : ℚ) / 20 < (1.024696 : ℚ) ^ 2 := by
  refine ⟨?_, ?_, ?_, ?_⟩ <;> norm_num

/-- **If the candidate holds, the family tends to `1`** (`N/(N-1) → 1`) so it sits far
below the sphere products at every `k`, which is consistent with the index's ordering. -/
theorem candidate_decreasing : (21 : ℚ) / 20 < 15 / 14 ∧ (15 : ℚ) / 14 < 6 / 5 := by
  constructor <;> norm_num

/-! ## What this settles

**Settled**: exact forms for six of the index's decimal-only rows, including that
`θ₀(10)` is the rational `6/5`; that the two rows carrying unreduced fractions reduce
correctly and agree with the closed form; and that the `S⁶×S⁷` row's value is shared with
`S⁵×S¹¹`, which the index does not note although it notes another such pair.

**Offered, not asserted**: `θ² = N/(N-1)` with `N = k(k+1)/2` for the `(𝔰𝔲(k),𝔰𝔬(k))`
family, fitting all three printed values. **A fit to three points is not a theorem**, and
the record is the place to confirm or reject it.
-/

end HamiltonsCubic.ValueIndex
