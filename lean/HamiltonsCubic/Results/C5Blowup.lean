import Mathlib.Tactic.NormNum
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

/-!
# The `C₅` blow-up family, exactly

[nondegeneracy.md](../../../findings/nondegeneracy.md) records, for the equal-block
`C₅` blow-up at `n = 5m`:

  `θ/θ₀ = ½ √(10(m-1)/(5m-2))`,

*"strictly increasing with supremum `1/√2`, never attained, reproducing `0.5590`,
`0.6202` and `0.6455` exactly"*, and adds that larger triangle-free graphs do **worse**:
`1/2` for Petersen, `1/√5` for Clebsch, about `0.21` for Higman–Sims.

Squaring removes every root: the ratio squared is `5(m-1)/(2(5m-2))`, a rational
function of `m`. The three decimals are `5/16`, `5/13` and `5/12` under the square, the
supremum is `1/2`, and *"never attained"* is a one-line inequality rather than a limit
argument.

Everything is `norm_num`, `ring` or `linarith`, kernel-checked.
-/

namespace HamiltonsCubic.C5Blowup

/-- `(θ/θ₀)²` for the equal-block `C₅` blow-up at `n = 5m`. -/
def ratioSq (m : ℚ) : ℚ := 5 * (m - 1) / (2 * (5 * m - 2))

/-! ## The three recorded values -/

theorem at_2 : ratioSq 2 = 5 / 16 := by norm_num [ratioSq]
theorem at_3 : ratioSq 3 = 5 / 13 := by norm_num [ratioSq]
theorem at_4 : ratioSq 4 = 5 / 12 := by norm_num [ratioSq]

/-! ## Strictly increasing, and capped by `1/2`

Both stated so that no division is compared: the difference of numerators against the
product of denominators.
-/

/-- **Strictly increasing in `m`.** The difference has numerator `30(b-a)`, positive. -/
theorem strict_mono {a b : ℚ} (ha : 1 ≤ a) (hab : a < b) :
    5 * (a - 1) * (2 * (5 * b - 2)) < 5 * (b - 1) * (2 * (5 * a - 2)) := by
  nlinarith [hab, ha]

/-- **The supremum `1/2` is never attained.** `5(m-1) < 5m-2` for every `m`, since
`-5 < -2`. -/
theorem lt_half (m : ℚ) : 2 * (5 * (m - 1)) < 2 * (5 * m - 2) := by linarith

/-- And the gap is a constant in the numerator: `1/2 - ratioSq m = 3/(5m-2)`. -/
theorem gap (m : ℚ) (h : 5 * m - 2 ≠ 0) : 1 / 2 - ratioSq m = 3 / (2 * (5 * m - 2)) := by
  rw [ratioSq]
  field_simp
  ring

/-- So the family approaches `1/2` like `3/(10m)`, and reaches it at no `m`. -/
theorem gap_pos {m : ℚ} (hm : 1 ≤ m) : 0 < 3 / (2 * (5 * m - 2)) := by
  have h : 0 < 2 * (5 * m - 2) := by linarith
  exact div_pos (by norm_num) h

/-! ## Larger triangle-free graphs do worse

The three comparisons the record names, squared: `1/4` for Petersen, `1/5` for Clebsch,
`0.21² = 0.0441` for Higman–Sims, each below the `C₅` family's supremum `1/2`.
-/

theorem petersen_below : (1 : ℚ) / 4 < 1 / 2 := by norm_num
theorem clebsch_below : (1 : ℚ) / 5 < 1 / 2 := by norm_num
theorem higman_sims_below : (0.21 : ℚ) ^ 2 < 1 / 2 := by norm_num

/-- Petersen and Clebsch are below **every** member of the family from `m = 3` on, not
merely below its supremum, so the comparison is not asymptotic. -/
theorem petersen_below_at_3 : (1 : ℚ) / 4 < ratioSq 3 := by norm_num [ratioSq]

theorem clebsch_below_at_2 : (1 : ℚ) / 5 < ratioSq 2 := by norm_num [ratioSq]

/-! ## What this settles

**Settled**: the three recorded decimals as `5/16`, `5/13`, `5/12` under the square;
that the family is strictly increasing; that `1/2` is a strict upper bound with gap
exactly `3/(2(5m-2))`, so *"never attained"* needs no limit; and that the three named
graphs sit below the family, Petersen and Clebsch below its individual members rather
than only below its supremum.

**Not settled here**: the closed form itself, which is the record's, and the identity of
the three graphs' values.
-/

end HamiltonsCubic.C5Blowup
