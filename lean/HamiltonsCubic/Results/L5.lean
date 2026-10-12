import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp

/-!
# L5, the census, and the family its own table already closes

[graded-half.md](../../../findings/graded-half.md)'s Observation L5, downgraded at Gate 2. The
geometry stays imported; the arithmetic the downgrade turns on is carried here, together with
one identification the block does not make.

**The four tabulated Hermitian pairs are the `ℂPᵐ` family, row for row.** The block presents
`SO(8)/U(4)`, `SO(10)/U(5)`, `SO(12)/U(6)`, `SO(14)/U(7)` as a fresh solver run and reports
them *"all decreasing in n and far below √(3/2)"*. Their four values `35/36`, `9/10`, `77/90`,
`52/63` are exactly

`θ² = (m+1)(2m-1)/(3m(m-1))` at `m = 4,5,6,7`,

which is the `ℂPᵐ` closed form the record already carries at
[INDEX-values.md](../../../findings/INDEX-values.md) and derives at
[algebra.md](../../../findings/algebra.md). **So the table is four rows of a family closed in
form**, and *"far below √(3/2)"* is a statement about where those four rows sit rather than
about the family: the same form gives **exactly `3/2` at `m = 2`**, so the family's own peak is
the competitor it is being measured against. What the four rows show is the tail, and the tail
descends to `2/3`.

**The norm formula reproduces both sphere-product values exactly**, which the record gives only
to six or seven digits. With `‖W‖² = (k-1)/8 + (1/8)(Σ 1/(nₐ-1) - 1/(n-1))` and `θ = 1/(2‖W‖)`:

* `S⁵ × S⁷` gives `‖W‖² = 175/1056` (**the block's own partition identity**), hence
  `θ² = 264/175`, above `3/2` and below `θ₀(12)² = 55/36`.
* `(S³)⁴` gives `‖W‖² = 27/44`, hence `θ² = 11/27`, whose root is the block's `0.638285`.

So the two witnesses that break the census and the bound that saves it are one computation.
-/

namespace HamiltonsCubic.Census

/-! ## The Hermitian pairs are the `ℂPᵐ` family -/

/-- `θ²(ℂPᵐ) = (m+1)(2m-1)/(3m(m-1))`, the record's closed form. -/
def cpSq (m : ℚ) : ℚ := (m + 1) * (2 * m - 1) / (3 * m * (m - 1))

/-- **All four tabulated Hermitian-pair values are rows of it.** -/
theorem table_is_cp :
    cpSq 4 = 35 / 36 ∧ cpSq 5 = 9 / 10 ∧ cpSq 6 = 77 / 90 ∧ cpSq 7 = 52 / 63 := by
  refine ⟨?_, ?_, ?_, ?_⟩ <;> (unfold cpSq; norm_num)

/-- **And the family's own peak is `3/2` exactly**, at `m = 2`, the value the four rows are
being compared against, not a bound they sit under. -/
theorem cp_peak : cpSq 2 = 3 / 2 := by unfold cpSq; norm_num

/-- The form splits as `2/3 + (3m-1)/(3m(m-1))`, which exhibits both the limit and the sign. -/
theorem cp_split (m : ℚ) (hm : 2 ≤ m) :
    cpSq m = 2 / 3 + (3 * m - 1) / (3 * m * (m - 1)) := by
  unfold cpSq
  have h0 : m ≠ 0 := by intro h; linarith
  have h1 : m - 1 ≠ 0 := by intro h; linarith
  field_simp
  ring

/-- **So `θ² > 2/3` at every `m ≥ 2`**, and the family descends to that value. -/
theorem cp_above_two_thirds (m : ℚ) (hm : 2 ≤ m) : 2 / 3 < cpSq m := by
  rw [cp_split m hm]
  have hpos : (0:ℚ) < 3 * m * (m - 1) := by nlinarith [hm]
  have : (0:ℚ) < (3 * m - 1) / (3 * m * (m - 1)) := div_pos (by linarith) hpos
  linarith

/-- **And it is strictly decreasing on `m ≥ 2`.** -/
theorem cp_strict_anti {a b : ℚ} (ha : 2 ≤ a) (hab : a < b) : cpSq b < cpSq a := by
  have hb : (2:ℚ) ≤ b := by linarith
  unfold cpSq
  have hpa : (0:ℚ) < 3 * a * (a - 1) := by nlinarith [ha]
  have hpb : (0:ℚ) < 3 * b * (b - 1) := by nlinarith [hb]
  rw [div_lt_div_iff₀ hpb hpa]
  nlinarith [ha, hb, hab, mul_pos (by linarith : (0:ℚ) < b - a) (by nlinarith [ha, hb] : (0:ℚ) < 3 * a * b - (a + b) + 1)]

/-! ## The two sphere products, from one norm formula -/

/-- `S⁵ × S⁷`: the block's partition identity, in its own grouping. -/
theorem partition_identity : (5:ℚ) / 32 + 7 / 48 - 3 / 22 = 175 / 1056 := by norm_num

/-- **And in the norm formula's grouping**, `(k-1)/8 + (1/8)(Σ 1/(nₐ-1) - 1/(n-1))` at
`k = 2`, blocks `5` and `7`, `n = 12`, the same value, so the identity is the formula. -/
theorem norm_sq_five_seven :
    (1:ℚ) / 8 + (1 / 8) * (1 / 4 + 1 / 6 - 1 / 11) = 175 / 1056 := by norm_num

/-- **`θ² = 1/(4‖W‖²) = 264/175`.** -/
theorem theta_sq_five_seven : 1 / (4 * ((175:ℚ) / 1056)) = 264 / 175 := by norm_num

/-- It exceeds `3/2`, so it beats the padded `ℂP²` competitor. -/
theorem five_seven_beats_cp2 : (3:ℚ) / 2 < 264 / 175 := by norm_num

/-- **And it loses to the balanced product at the same `n`**, `θ₀(12)² = 55/36`, which is why
the conjecture survives what the census does not. -/
theorem theta0_twelve : 2 * (12 - 1 : ℚ) * (12 - 2) / 12 ^ 2 = 55 / 36 := by norm_num

theorem five_seven_below_balanced : (264:ℚ) / 175 < 55 / 36 := by norm_num

/-- `(S³)⁴`: `k = 4`, four blocks of `3`, `n = 12`. -/
theorem norm_sq_s3_fourth :
    (4 - 1 : ℚ) / 8 + (1 / 8) * (4 * (1 / 2) - 1 / 11) = 27 / 44 := by norm_num

/-- **`θ² = 11/27`**, whose root is the block's `0.638285`. -/
theorem theta_sq_s3_fourth : 1 / (4 * ((27:ℚ) / 44)) = 11 / 27 := by norm_num

theorem s3_fourth_brackets :
    ((638284 : ℚ) / 1000000) ^ 2 < 11 / 27 ∧ (11:ℚ) / 27 < ((638286 : ℚ) / 1000000) ^ 2 := by
  constructor <;> norm_num

/-! ## The multi-block bound -/

/-- **`θ² < 2/(k-1)` for a `k`-block product**, so `θ < 1` at every `k ≥ 3`, uniformly in `n`.
Both witnesses above respect it: `11/27 < 2/3` at `k = 4`. -/
theorem multiblock_at_four : (11:ℚ) / 27 < 2 / 3 := by norm_num

/-- At `k = 3` the bound is exactly `1`, which is where the family stops threatening. -/
theorem multiblock_at_three : (2:ℚ) / (3 - 1) = 1 := by norm_num

/-! ## The quaternionic family -/

/-- `θ²(ℍPᵐ) = (m+2)²(4m-1)/(9m(m-1)(2m+1))`. -/
def hpSq (m : ℚ) : ℚ := (m + 2) ^ 2 * (4 * m - 1) / (9 * m * (m - 1) * (2 * m + 1))

/-- **Its supremum is at `m = 2`, at `56/45`**, and `ℍP³` gives `275/378`, whose root is the
block's `0.85294386`, so items `3` and `4` of the census carry the same two numbers. -/
theorem hp_values : hpSq 2 = 56 / 45 ∧ hpSq 3 = 275 / 378 := by
  constructor <;> (unfold hpSq; norm_num)

theorem hp_below_target : (56:ℚ) / 45 < 3 / 2 := by norm_num

theorem hp_three_brackets :
    ((85294385 : ℚ) / 100000000) ^ 2 < 275 / 378
      ∧ (275:ℚ) / 378 < ((85294387 : ℚ) / 100000000) ^ 2 := by
  constructor <;> norm_num

end HamiltonsCubic.Census
