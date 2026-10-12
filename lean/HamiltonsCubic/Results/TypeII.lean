import HamiltonsCubic.Results.FamilyMeet

/-!
# The Type II closed form, and the index row it also explains

[INDEX-values.md](../../../findings/INDEX-values.md) gives the Type II closed form
`θ² = 4(n-1)/(n(n-3))` on one row only, `0.836660 = √(7/10)`, the `𝔰𝔲(3)` adjoint at
`n = 8`.

**It explains another row too.** Three rows lower sits `0.717137`, the `𝔰𝔬(5)` adjoint at
`n = 10`, with no exact form. The formula at `n = 10` gives `36/70 = 18/35`, whose root is
`0.717137…`, so that row's value is `√(18/35)`, and the two adjoint rows are one formula
at two dimensions. The index connects neither to the other.

**And evaluated at `n = 6` the formula gives `10/9`**, the value the index already
records as shared by `S³×S³` and `ℂP³`. Whether a Type II point exists at `n = 6` is the
record's question, not this file's; what is checked is the arithmetic.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.TypeII

open HamiltonsCubic.SphereProducts HamiltonsCubic.FamilyMeet

/-- The Type II closed form. -/
def typeII (n : ℚ) : ℚ := 4 * (n - 1) / (n * (n - 3))

/-! ## The two adjoint rows -/

/-- `𝔰𝔲(3)` adjoint at `n = 8`: `7/10`, the index's stated pairing. -/
theorem at_8 : typeII 8 = 7 / 10 := by norm_num [typeII]

/-- **`𝔰𝔬(5)` adjoint at `n = 10`: `18/35`**, the exact form of the index's `0.717137`,
which that row does not carry. -/
theorem at_10 : typeII 10 = 18 / 35 := by norm_num [typeII]

/-- And `0.717137` is its root, to the last place printed. -/
theorem at_10_decimal : (0.717136 : ℚ) ^ 2 < 18 / 35 ∧ (18 : ℚ) / 35 < (0.717138 : ℚ) ^ 2 := by
  constructor <;> norm_num

/-- The two adjoint values are ordered as the index lists them, and their ratio is
`(7/10)/(18/35) = 49/36`. -/
theorem adjoint_ratio : typeII 8 / typeII 10 = 49 / 36 := by norm_num [typeII]

/-- **A ratio of squares** (`(7/6)²`) which is what makes the two decimals look
unrelated and the forms not. -/
theorem ratio_is_square : (49 : ℚ) / 36 = (7 / 6 : ℚ) ^ 2 := by norm_num

/-! ## The formula at `n = 6` -/

/-- **`typeII 6 = 10/9`**, the value the index records as shared by `S³×S³` and `ℂP³`. -/
theorem at_6 : typeII 6 = 10 / 9 := by norm_num [typeII]

theorem at_6_matches_sphere : typeII 6 = thetaSq 3 3 := by norm_num [typeII, thetaSq]

theorem at_6_matches_cp : typeII 6 = cpSq 3 := by norm_num [typeII, cpSq]

/-! ## The formula is decreasing

`4(n-1)/(n(n-3))` falls with `n`, so the Type II family runs downward from its smallest
admissible dimension, unlike the sphere products, which rise.
-/

theorem decreasing : typeII 10 < typeII 8 ∧ typeII 8 < typeII 6 := by
  constructor <;> norm_num [typeII]

/-- At `n = 12` it is `11/27`, below every value the index lists for that dimension. -/
theorem at_12 : typeII 12 = 11 / 27 := by norm_num [typeII]

theorem at_12_below : typeII 12 < thetaSq 6 6 := by norm_num [typeII, thetaSq]

/-! ## The `5√3/8` row

The index's one other explicit form is `1.0825318 = 5√3/8`, an unidentified point at
`n = 8`. Squared that is `75/64`.
-/

theorem five_root_three_over_eight : (5 : ℚ) ^ 2 * 3 / 8 ^ 2 = 75 / 64 := by norm_num

theorem its_decimal : (1.0825317 : ℚ) ^ 2 < 75 / 64 ∧ (75 : ℚ) / 64 < (1.0825319 : ℚ) ^ 2 := by
  constructor <;> norm_num

/-- **It is below `√(3/2)` but above every `ℂPᵐ` from `m = 4` on**, so an unidentified
point at `n = 8` sits between the competitor and the projective family. -/
theorem unidentified_placement : cpSq 4 < 75 / 64 ∧ (75 : ℚ) / 64 < 3 / 2 := by
  constructor <;> norm_num [cpSq]

/-! ## What this settles

**Settled**: that the Type II closed form gives `18/35` at `n = 10`, **so the index's
`0.717137` row has an exact form and is the same formula as its `0.836660` row**, two
rows the index leaves unconnected; that their ratio is the square `(7/6)²`; that the
formula gives `10/9` at `n = 6`, the value already recorded as shared by two other
points; that it decreases while the sphere products rise; and the `75/64` behind the
`5√3/8` row, which places that unidentified point between `ℂP⁴` and the competitor.

**Not claimed**: that a Type II point exists at `n = 6`, or the closed form itself, both
the record's.
-/

end HamiltonsCubic.TypeII
