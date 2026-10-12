import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import HamiltonsCubic.Results.L5

/-!
# Three value-index pointers, two wrong, one orphan whose formula is two rows above it

Checking every *"Where"* pointer in [INDEX-values.md](../../../findings/INDEX-values.md) against
the file it names. Of `33` rows, three fail.

**`0.717137` had no source anywhere.** Listed as the `𝔰𝔬(5)` adjoint at `n = 10` pointing to
[graded-half.md](../../../findings/graded-half.md), the decimal appears in no findings file at
all. **Its closed form is in the index itself**: the row for `0.836660` gives the Type II form
`θ² = 4(n-1)/(n(n-3))`, which at `n = 8` is `7/10`, and at `n = 10` is `36/70 = 18/35`, whose
root is `0.717137`. So the orphan is that formula's next value, two rows above it in the same
table.

**`0.745356` points to the wrong file, and is `√(5/9)` at `ℍP⁴`.** The index labels it correctly;
the decimal lives in [problem.md](../../../findings/problem.md), not
[graded-half.md](../../../findings/graded-half.md). Its value checks against
[L5](L5.lean)'s `ℍPᵐ` closed form: `(m+2)²(4m-1)/(9m(m-1)(2m+1))` gives `540/972 = 5/9` at
`m = 4`, with `n = 4m = 16` as recorded.

**`0.716134` points to [diagonal-half.md](../../../findings/diagonal-half.md) and lives in
[bounds.md](../../../findings/bounds.md).** A displaced pointer, the value itself being sound.

*The `θ₀` rows that also failed the literal check are not defects: the index prints decimals where
the files carry closed forms, which is what an index is for.*
-/

namespace HamiltonsCubic.ValuePointers

/-! ## The orphan is the Type II form at `n = 10` -/

/-- The Type II closed form the index states on another row. -/
def typeII (n : ℚ) : ℚ := 4 * (n - 1) / (n * (n - 3))

/-- **At `n = 8` it is `7/10`**, the value the index attaches the formula to. -/
theorem typeII_eight : typeII 8 = 7 / 10 := by unfold typeII; norm_num

/-- **And at `n = 10` it is `18/35`**, whose root is the orphaned `0.717137`. -/
theorem typeII_ten : typeII 10 = 18 / 35 := by unfold typeII; norm_num

theorem orphan_bracket :
    ((717136 : ℚ) / 1000000) ^ 2 < 18 / 35 ∧ (18 : ℚ) / 35 < ((717138 : ℚ) / 1000000) ^ 2 := by
  constructor <;> norm_num

/-- So the two adjoint rows are one formula at consecutive even dimensions, and the index gives
the closed form for only one of them. -/
theorem adjoint_rows_are_one_formula :
    typeII 8 = 7 / 10 ∧ typeII 10 = 18 / 35 ∧ (18 : ℚ) / 35 < 7 / 10 := by
  refine ⟨by unfold typeII; norm_num, by unfold typeII; norm_num, by norm_num⟩

/-! ## `ℍP⁴` checks against the record's own closed form -/

/-- **`(m+2)²(4m-1)/(9m(m-1)(2m+1))` gives `5/9` at `m = 4`.** -/
theorem hp_four : Census.hpSq 4 = 5 / 9 := by unfold Census.hpSq; norm_num

theorem hp_four_bracket :
    ((745355 : ℚ) / 1000000) ^ 2 < 5 / 9 ∧ (5 : ℚ) / 9 < ((745357 : ℚ) / 1000000) ^ 2 := by
  constructor <;> norm_num

/-- Its dimension is `n = 4m = 16`, as the index records. -/
theorem hp_four_dim : 4 * 4 = 16 := by norm_num

/-- And it sits well below the target, so the row carries no threat. -/
theorem hp_four_below_target : (5 : ℚ) / 9 < 3 / 2 := by norm_num

/-! ## The family is decreasing, which places both `ℍP` rows -/

/-- `ℍP²` at `56/45` against `ℍP⁴` at `5/9`, the family falls, as
[L5](L5.lean) records. -/
theorem hp_decreasing :
    Census.hpSq 2 = 56 / 45 ∧ Census.hpSq 4 = 5 / 9 ∧ (5 : ℚ) / 9 < 56 / 45 := by
  refine ⟨by unfold Census.hpSq; norm_num, by unfold Census.hpSq; norm_num, by norm_num⟩

end HamiltonsCubic.ValuePointers
