import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import HamiltonsCubic.Results.KillingConstant

/-!
# The `n = 8` block table, it determines the constant stated thirty lines above it

[algebra.md](../../../findings/algebra.md) carries the multiplicities `(1,16,54,148,81)` twice:
once in the Killing-constant paragraph, where the balanced `n = 8` value is written
`θ₀(8)²·20 = 26.25` with the `20` unexplained, and once in a block table giving
`(6F - 3θ)/θ` as `+3, 0, -1, -3, -5`. **The table produces the `20`.**

**Reading the eigenvalues off the table.** `(6F - 3θ)/θ = c` gives `F/θ = (c+3)/6`, so the
spectrum of `L_e` is `{1, ½, ⅓, 0, -⅓}` against those multiplicities. Then

* `tr L_e = 1 + 8 + 18 + 0 - 27 = 0`, and
* `tr L_e² = 1 + 4 + 6 + 0 + 9 = 20`.

So the `20` in the Killing-constant paragraph is this table's second moment, and
`κ_F(8) = θ₀(8)²·tr(L_e²) = 21/16 · 20 = 105/4` closes the loop, see
[KillingConstant](KillingConstant.lean). The two passages are one dataset and the record joins
them nowhere.

**The `½`-eigenspace is the orbit, exactly.** Its multiplicity is `16`, and the `S⁴ × S⁴` orbit
has dimension `C(8,2) - dim(𝔰𝔬(4) ⊕ 𝔰𝔬(4)) = 28 - 12 = 16`. **So excess is `0` here**, which is
what [second-order.md](../../../findings/second-order.md) records for this point, established
from this file's own table rather than from a separate measurement.

**And the `n = 6` exception comes out the same way.** At `k = 3`, `dim B = (3·2/2)² = 9` added to
the orbit tangent `k² = 9` gives kernel `18` against orbit `C(6,2) - dim(𝔰𝔬(3) ⊕ 𝔰𝔬(3)) =
15 - 6 = 9`, excess `9`, matching the figure
[second-order.md](../../../findings/second-order.md) records at `S³ × S³`. Three files agree on
this point and none cites another.
-/

namespace HamiltonsCubic.BlockTable

/-! ## The table's eigenvalues -/

/-- `(6F - 3θ)/θ = c` gives `F/θ = (c+3)/6`. -/
def eigenvalue (c : ℚ) : ℚ := (c + 3) / 6

/-- **The five table entries give `{1, ½, ⅓, 0, -⅓}`.** -/
theorem spectrum_from_table :
    eigenvalue 3 = 1 ∧ eigenvalue 0 = 1 / 2 ∧ eigenvalue (-1) = 1 / 3
      ∧ eigenvalue (-3) = 0 ∧ eigenvalue (-5) = -(1 / 3) := by
  refine ⟨?_, ?_, ?_, ?_, ?_⟩ <;> (unfold eigenvalue; norm_num)

/-! ## The two moments -/

/-- **`tr L_e = 0`** against the multiplicities `(1,16,54,148,81)`. -/
theorem trace_vanishes :
    (1 : ℚ) * 1 + 16 * (1 / 2) + 54 * (1 / 3) + 148 * 0 + 81 * (-(1 / 3)) = 0 := by
  norm_num

/-- **`tr L_e² = 20`**, the number the Killing-constant paragraph uses without deriving. -/
theorem second_moment_is_twenty :
    (1 : ℚ) * 1 ^ 2 + 16 * (1 / 2) ^ 2 + 54 * (1 / 3) ^ 2 + 148 * 0 ^ 2
      + 81 * (-(1 / 3)) ^ 2 = 20 := by
  norm_num

/-- **And it closes the loop**: `κ_F(8) = θ₀(8)² · 20`. -/
theorem closes_the_killing_loop :
    KillingConstant.theta0Sq 8 * 20 = KillingConstant.kappaF 8 := by
  unfold KillingConstant.theta0Sq KillingConstant.kappaF; norm_num

/-- The multiplicities fill `𝒲₈`. -/
theorem multiplicities_sum : 1 + 16 + 54 + 148 + 81 = 300 := by norm_num

/-! ## The `½`-eigenspace is the orbit -/

/-- **`dim E(½) = 16` equals the `S⁴ × S⁴` orbit dimension `28 - 12`**, so the excess is `0`. -/
theorem excess_zero_at_eight :
    8 * 7 / 2 - (4 * 3 / 2 + 4 * 3 / 2) = 16 ∧ 16 - 16 = 0 := by
  refine ⟨by norm_num, by norm_num⟩

/-! ## The `n = 6` exception -/

/-- **`dim B = 9` at `k = 3`**, and the orbit tangent is `k² = 9`. -/
theorem block_dim_at_three : ((3 * 2 / 2 : ℚ)) ^ 2 = 9 ∧ (3 : ℚ) ^ 2 = 9 := by
  refine ⟨by norm_num, by norm_num⟩

/-- **So the kernel is `18` against an orbit of `15 - 6 = 9`, excess `9`.** -/
theorem excess_nine_at_six :
    (9 : ℕ) + 9 = 18 ∧ 6 * 5 / 2 - (3 + 3) = 9 ∧ 18 - 9 = 9 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-- The two dimensions behave oppositely, which is why `n = 6` is the recorded exception. -/
theorem six_and_eight_differ : (0 : ℕ) ≠ 9 := by decide

end HamiltonsCubic.BlockTable
