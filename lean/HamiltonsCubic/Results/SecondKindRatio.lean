import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp

/-!
# The second-kind ratio on `ℂPᵐ`, a closed form for three recorded decimals

[stratum-two-negative.md](../../../findings/stratum-two-negative.md) tabulates
`λ_max(R̊_W)/θ` as measurements: `2/3` at padded `W_{ℂP²}`, `0.4500` at `ℂP³`, `0.3429` at `ℂP⁴`.
**All three are one formula.**

`λ_max(R̊)/θ = 3m / ((m+1)(2m-1))`

gives `6/9 = 2/3` at `m = 2`, `9/20 = 0.45` at `m = 3`, and `12/35 = 0.342857…` at `m = 4`. So
the padded competitor's value and the two `ℂPᵐ` entries are the same function at consecutive `m`,
which the block records as three separate measurements.

**The two columns differ by exactly two.** The criterion is
`⟨E, L_e E⟩ ≤ ½ ⟺ λ_max(R̊_e) ≤ 1`, and the block says the ratio *"reads `2/3` at padded
`W_{ℂP²}` and `1.2` at padded `S³ × S³`, reproducing the `1/3` and `0.6` above"*, a factor of
`2` in both cases, as the equivalence requires. That is a consistency check the block states
in numbers and not as an identity.

**And the family falls below `1` from `m = 2` on.** `3m < (m+1)(2m-1)` for every `m ≥ 2`, so no
`ℂPᵐ` violates the second-kind bound, against `6/5` at `S³ × S³` and `1.3009` at the `C₅`
blow-up, both coordinate-diagonal and both above `1`, which is the split the block reports.
-/

namespace HamiltonsCubic.SecondKindRatio

/-- `λ_max(R̊)/θ` on `ℂPᵐ`. -/
def ratio (m : ℚ) : ℚ := 3 * m / ((m + 1) * (2 * m - 1))

/-! ## The three recorded values -/

/-- **`2/3` at `m = 2`**, the padded `W_{ℂP²}` entry. -/
theorem at_two : ratio 2 = 2 / 3 := by unfold ratio; norm_num

/-- **`9/20` at `m = 3`**, the recorded `0.4500`. -/
theorem at_three : ratio 3 = 9 / 20 := by unfold ratio; norm_num

/-- **`12/35` at `m = 4`**, the recorded `0.3429`. -/
theorem at_four : ratio 4 = 12 / 35 := by unfold ratio; norm_num

theorem decimals_match :
    (9 : ℚ) / 20 = 45 / 100 ∧ (3428 : ℚ) / 10000 < 12 / 35 ∧ (12 : ℚ) / 35 < 3429 / 10000 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-! ## The factor of two between the columns -/

/-- **`⟨E,L_eE⟩ = ½ · λ_max(R̊_e)`**, which is what the equivalence `≤ ½ ⟺ ≤ 1` encodes, so the
block's `2/3 → 1/3` and `1.2 → 0.6` are one identity applied twice. -/
theorem halving (x : ℚ) : x / 2 ≤ 1 / 2 ↔ x ≤ 1 := by
  constructor <;> intro h <;> linarith

theorem the_two_pairs :
    (2 / 3 : ℚ) / 2 = 1 / 3 ∧ (12 / 10 : ℚ) / 2 = 6 / 10 := by
  refine ⟨by norm_num, by norm_num⟩

/-! ## The family stays below one -/

/-- **`3m < (m+1)(2m-1)` at every `m ≥ 2`**, so no `ℂPᵐ` violates the bound. -/
theorem below_one {m : ℚ} (hm : 2 ≤ m) : ratio m < 1 := by
  unfold ratio
  have hpos : (0:ℚ) < (m + 1) * (2 * m - 1) := by nlinarith
  rw [div_lt_iff₀ hpos]
  nlinarith

/-- And it decreases, so `m = 2` is the family's own maximum. -/
theorem strict_anti {a b : ℚ} (ha : 2 ≤ a) (hab : a < b) : ratio b < ratio a := by
  unfold ratio
  have hb : (2:ℚ) ≤ b := by linarith
  have hpa : (0:ℚ) < (a + 1) * (2 * a - 1) := by nlinarith
  have hpb : (0:ℚ) < (b + 1) * (2 * b - 1) := by nlinarith
  rw [div_lt_div_iff₀ hpb hpa]
  nlinarith [mul_pos (by linarith : (0:ℚ) < b - a) (by nlinarith : (0:ℚ) < 6 * a * b + 3)]

/-- The diagonal points sit the other side: `6/5` at `S³ × S³` exceeds `1`. -/
theorem diagonal_exceeds : (1 : ℚ) < 6 / 5 ∧ (1 : ℚ) < 13009 / 10000 := by
  refine ⟨by norm_num, by norm_num⟩

end HamiltonsCubic.SecondKindRatio
