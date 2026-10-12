import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import HamiltonsCubic.Results.OddWitness

/-!
# `Θ₁₃` and `Θ₁₅`, the index's unreduced rows, and a criterion confirmed at a new dimension

[INDEX-values.md](../../../findings/INDEX-values.md) carries
`Θ₁₅² = (2·14·12)/(16·13) = 336/208` and `Θ₁₃² = (2·12·10)/(14·11) = 240/154`, showing the
arithmetic rather than the value. Both are correct and both are unreduced:
`336/208 = 21/13` and `240/154 = 120/77`.

**The unreduced form defeats the lookup the index exists for.** Its own opening instruction is to
check the value table before claiming anything is new; `120/77` is the form
[problem.md](../../../findings/problem.md) uses and the form four files of this layer use, and a
grep for it does not reach the index row. So the row is invisible to the search it was written to
serve, which is how `21/13` came to have no coverage here at all until now.

**And `Θ₁₅²` confirms [OddWitness](OddWitness.lean)'s criterion at a dimension it did not test.**
That file proves `Θₙ² > 3/2 ⟺ n² - 13n + 18 > 0`; at `n = 15` the polynomial is `48 > 0`, so the
criterion predicts `Θ₁₅² > 3/2`. The index's independently recorded `21/13` delivers it. The
prediction and the value come from different places in the record and agree.
-/

namespace HamiltonsCubic.OddValues

/-! ## The two rows reduce -/

/-- **`Θ₁₅² = 336/208 = 21/13`.** -/
theorem theta15_reduces : (336 : ℚ) / 208 = 21 / 13 := by norm_num

/-- **`Θ₁₃² = 240/154 = 120/77`.** -/
theorem theta13_reduces : (240 : ℚ) / 154 = 120 / 77 := by norm_num

/-- Both agree with the closed form. -/
theorem from_closed_form :
    OddWitness.ThetaOddSq 15 = 21 / 13 ∧ OddWitness.ThetaOddSq 13 = 120 / 77 := by
  constructor <;> (unfold OddWitness.ThetaOddSq; norm_num)

/-- And with the printed decimals. -/
theorem decimals_match :
    ((1270977 : ℚ) / 1000000) ^ 2 < 21 / 13 ∧ (21 : ℚ) / 13 < ((1270979 : ℚ) / 1000000) ^ 2
      ∧ ((1248375 : ℚ) / 1000000) ^ 2 < 120 / 77
      ∧ (120 : ℚ) / 77 < ((1248377 : ℚ) / 1000000) ^ 2 := by
  refine ⟨by norm_num, by norm_num, by norm_num, by norm_num⟩

/-! ## The criterion, confirmed at `n = 15` -/

/-- **`n² - 13n + 18 = 48` at `n = 15`**, so [OddWitness](OddWitness.lean)'s criterion predicts
`Θ₁₅² > 3/2`. -/
theorem criterion_at_fifteen : (15 : ℚ) ^ 2 - 13 * 15 + 18 = 48 ∧ (0 : ℚ) < 48 := by
  refine ⟨by norm_num, by norm_num⟩

/-- **And the index's value delivers it.** -/
theorem fifteen_clears : (3 : ℚ) / 2 < 21 / 13 := by norm_num

/-- The two routes agree: the criterion applied at `15`, and the recorded value read off. -/
theorem prediction_matches_record :
    (0 : ℚ) < (15 : ℚ) ^ 2 - 13 * 15 + 18 ∧ 3 / 2 < OddWitness.ThetaOddSq 15 := by
  refine ⟨by norm_num, ?_⟩
  unfold OddWitness.ThetaOddSq; norm_num

/-- `Θ₁₅²` exceeds `Θ₁₃²`, so the odd family rises with `n` across these two. -/
theorem fifteen_above_thirteen : (120 : ℚ) / 77 < 21 / 13 := by norm_num

end HamiltonsCubic.OddValues
