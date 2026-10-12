import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import HamiltonsCubic.Results.L5

/-!
# Two files, one number, different spaces, the Hermitian-pair attribution

[INDEX-values.md](../../../findings/INDEX-values.md) lists `0.986013` as `ℂP⁴` at `n = 8` and
`0.948683` as `ℂP⁵` at `n = 10`. [graded-half.md](../../../findings/graded-half.md)'s Hermitian
table lists the same two numbers as `SO(8)/U(4)` and `SO(10)/U(5)`, **at the same `n`**, the
pairs being `𝔲(m) ⊂ 𝔰𝔬(2m)` so that the ambient is `2m` in both readings.

**These are different symmetric spaces.** `ℂP⁴ = SU(5)/U(4)` has real dimension `8`; the pair
`(𝔰𝔬(8), 𝔲(4))` has `dim 𝔪 = 28 - 16 = 12`. Both carry a Weyl tensor in `𝒲₈`, and both are
recorded at `θ² = 35/36`.

**So [L5](L5.lean)'s open question is now concrete rather than speculative.** That round found
the Hermitian table's four values to be the `ℂPᵐ` closed form row for row, and recorded as open
whether this is an identification or a value collision. It is at least a collision *in the
record*: two files name different objects for one number at one dimension, and neither cites the
other. Whether the objects coincide is geometry this layer cannot reach.

**The values themselves are consistent everywhere.** `(m+1)(2m-1)/(3m(m-1))` gives `35/36` at
`m = 4` and `9/10` at `m = 5`, matching both files and both printed decimals.
-/

namespace HamiltonsCubic.HermitianCollision

/-! ## One formula, both attributions -/

/-- **The `ℂPᵐ` closed form gives both recorded values.** -/
theorem formula_gives_both : Census.cpSq 4 = 35 / 36 ∧ Census.cpSq 5 = 9 / 10 := by
  constructor <;> (unfold Census.cpSq; norm_num)

/-- And both printed decimals bracket them. -/
theorem decimals_bracket :
    ((986012 : ℚ) / 1000000) ^ 2 < 35 / 36 ∧ (35 : ℚ) / 36 < ((986014 : ℚ) / 1000000) ^ 2
      ∧ ((948682 : ℚ) / 1000000) ^ 2 < 9 / 10
      ∧ (9 : ℚ) / 10 < ((948684 : ℚ) / 1000000) ^ 2 := by
  refine ⟨by norm_num, by norm_num, by norm_num, by norm_num⟩

/-! ## The two spaces have different dimensions -/

/-- **`ℂP⁴` has real dimension `8`**, being `2m` at `m = 4`. -/
theorem cp_four_dim : 2 * 4 = 8 := by norm_num

/-- **The pair `(𝔰𝔬(8), 𝔲(4))` has `dim 𝔪 = 12`**, from `dim 𝔰𝔬(8) = 28` and `dim 𝔲(4) = 16`. -/
theorem pair_dim : 8 * 7 / 2 = 28 ∧ 4 * 4 = 16 ∧ 28 - 16 = 12 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-- **So the two objects differ in dimension by `4`**, while sharing `n = 8` as the ambient and
`35/36` as the value. -/
theorem spaces_differ : 12 - 8 = 4 ∧ (8 : ℕ) ≠ 12 := by
  refine ⟨by norm_num, by decide⟩

/-! ## The general pattern -/

/-- `dim 𝔪` for the pair at general `m` is `m(m-1)`, against `2m` for `ℂPᵐ`, equal only at
`m = 3`, so the two families are genuinely distinct wherever the table runs. -/
theorem dims_coincide_only_at_three (m : ℚ) : m * (m - 1) = 2 * m ↔ m = 0 ∨ m = 3 := by
  constructor
  · intro h
    rcases eq_or_ne m 0 with h0 | h0
    · exact Or.inl h0
    · right
      have : m * (m - 3) = 0 := by nlinarith [h]
      rcases mul_eq_zero.1 this with h' | h'
      · exact absurd h' h0
      · linarith
  · rintro (rfl | rfl) <;> norm_num

/-- The table's four rows run `m = 4,…,7`, all above `3`, so no row is a coincidence of
dimension. -/
theorem table_rows_above_three : (3 : ℚ) < 4 ∧ (3 : ℚ) < 7 := by
  refine ⟨by norm_num, by norm_num⟩

end HamiltonsCubic.HermitianCollision
