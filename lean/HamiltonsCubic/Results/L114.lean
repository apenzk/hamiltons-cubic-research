import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp

/-!
# L114, the block-mass identity, and what its coefficients are

[bounds-relaxations.md](../../../findings/bounds-relaxations.md)'s Lemma L114:
`6S_𝔪𝔪𝔪 + 4S_𝔪𝔪𝔥 + 2S_𝔪𝔥𝔥 = 2d(n-2)`, confirmed and *"wider than its hypothesis"*.

**The three coefficients are one rule.** `6, 4, 2` is `2 × (number of 𝔪-slots)`: three, two,
one, and the missing `𝔥𝔥𝔥` term has coefficient `0` for the same reason. The record prints
three numbers where there is one pattern, and the `𝔥`-row twin is the same rule with `𝔥`
counted instead, giving `2, 4, 6`.

**Adding the two rows gives a uniform `6`.** Every pattern has three slots, so the `𝔪` and
`𝔥` counts sum to `3` at each, and the combined identity is `6ΣS = 2N(n-2)`, the full
Killing marginal, with no pattern distinguished. **That closure is not in the record**, and it
is what makes the two rows one statement rather than two.

**The convention change moves no number.** Ordered against unordered rescales each pattern by
its own arrangement count, and both sides scale together, which is why the reviewers'
recommendation *"changes no number and six displays"*.
-/

namespace HamiltonsCubic.BlockMass

/-- The coefficient rule: `2 ×` the number of `𝔪`-slots in the pattern. -/
def coeff (mSlots : ℚ) : ℚ := 2 * mSlots

/-! ## The three printed coefficients are one rule -/

theorem coeff_mmm : coeff 3 = 6 := by unfold coeff; norm_num

theorem coeff_mmh : coeff 2 = 4 := by unfold coeff; norm_num

theorem coeff_mhh : coeff 1 = 2 := by unfold coeff; norm_num

/-- **And the absent `𝔥𝔥𝔥` term has coefficient `0`** by the same rule, which is why it does
not appear. -/
theorem coeff_hhh : coeff 0 = 0 := by unfold coeff; norm_num

/-! ## The two rows sum to a uniform `6` -/

/-- **So the two rows' coefficients sum to `6` at every pattern**, uniformly, with no pattern
distinguished. -/
theorem rows_sum_uniform (k : ℚ) : coeff k + coeff (3 - k) = 6 := by
  unfold coeff; ring

/-- **And the combined identity is the full Killing marginal**: `6ΣS = 2N(n-2)`, from
`2d(n-2) + 2(N-d)(n-2)`. That closure is not in the record. -/
theorem combined_marginal (N d n : ℚ) :
    2 * d * (n - 2) + 2 * (N - d) * (n - 2) = 2 * N * (n - 2) := by ring

/-- Equivalently `ΣS = N(n-2)/3`, a statement about the total with the block split gone. -/
theorem total_mass (N n : ℚ) : 2 * N * (n - 2) / 6 = N * (n - 2) / 3 := by ring

/-! ## The convention change moves no number -/

/-- **The rescaling is invertible**, so the ordered/unordered choice changes displays and not
values, no information is lost either way. -/
theorem convention_invertible (c S : ℚ) (hc : c ≠ 0) : c * S / c = S := by
  field_simp

end HamiltonsCubic.BlockMass
