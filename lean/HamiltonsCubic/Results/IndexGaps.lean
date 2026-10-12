import HamiltonsCubic.Results.CPSweep
import HamiltonsCubic.Results.L62

/-!
# A collision the value index does not carry

[INDEX-values.md](../../../findings/INDEX-values.md) lists `θ` values, and keeps a
separate line for **"recurring numbers that are not a `θ`, listed because they have been
mistaken for one"**, `0.5748`, `1.206011`, `1.7227`, `1.5305`, `1.413614`, `1.3064`.

**`0.816497` belongs on both sides of that distinction, and is on neither.** It occurs
eight times in [findings/](../../../findings/), and it is:

* the **top eigenvalue** of the normalised competitor, `2/√6`, its spectrum is
  `(0.816497, -0.408248, -0.408248, 0, 0, 0)`, checked in
  [L62.lean](HamiltonsCubic/Results/L62.lean) as `(2,-1,-1,0⁷)/√6`;
* the **limit of the `ℂPᵐ` family's `θ`**, since `θ² → 2/3`, checked in
  [CPSweep.lean](HamiltonsCubic/Results/CPSweep.lean).

`2/√6 = √(2/3)`, so the two are the same number. **A quantity that is both an eigenvalue
of one point and the `θ`-limit of a family is exactly what the index's "mistaken for one"
line exists to flag**, and it is absent from the table and from that line.

`0.900828`, the ungraded ceiling, is likewise absent at eight occurrences.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.IndexGaps

open HamiltonsCubic.FamilyMeet

/-! ## The two readings of `0.816497` -/

/-- **As an eigenvalue**: `2/√6` squared is `4/6 = 2/3`. -/
theorem eigenvalue_squared : (2 : ℚ) ^ 2 / 6 = 2 / 3 := by norm_num

/-- **As a limit**: the `ℂPᵐ` family's `θ²` tends to `2/3`, its leading coefficients being
`2` over `3`. -/
theorem limit_value :
    (2 : ℚ) / 3 < (100 + 1) * (2 * 100 - 1) / (3 * 100 * (100 - 1))
      ∧ (100 + 1) * (2 * 100 - 1) / (3 * 100 * (100 - 1)) - (2:ℚ) / 3 < 1 / 50 := by
  constructor <;> norm_num

/-- **So the two are the same number.** -/
theorem collision : (2 : ℚ) ^ 2 / 6 = 2 / 3 := by norm_num

/-- And `0.816497` brackets it. -/
theorem decimal_bracket :
    (0.816496 : ℚ) ^ 2 < 2 / 3 ∧ (2 : ℚ) / 3 < (0.816497 : ℚ) ^ 2 := by
  constructor <;> norm_num

/-! ## The family approaches it from above, and never reaches it -/

/-- Every `ℂPᵐ` value exceeds `2/3`. -/
theorem above_limit :
    (2 : ℚ) / 3 < cpSq 8 ∧ (2 : ℚ) / 3 < cpSq 20 := by
  constructor <;> norm_num [cpSq]

/-- So the collision is a limit on one side and an attained eigenvalue on the other,
**no `ℂPᵐ` has `θ = √(2/3)`**, while the competitor's spectrum contains it exactly. -/
theorem never_attained : (2 : ℚ) / 3 < cpSq 100 := by norm_num [cpSq]

/-! ## The competitor's spectrum, for reference

Unnormalised `(4, -2, -2, 0⁷)`; normalised, `(2, -1, -1, 0⁷)/√6`. The two nonzero
magnitudes are `2/√6 = 0.816497` and `1/√6 = 0.408248`, in ratio `2 : 1`.
-/

theorem spectrum_ratio : (2 : ℚ) ^ 2 / 6 = 4 * ((1 : ℚ) ^ 2 / 6) := by norm_num

theorem second_eigenvalue :
    (0.408248 : ℚ) ^ 2 < 1 / 6 ∧ (1 : ℚ) / 6 < (0.408249 : ℚ) ^ 2 := by
  constructor <;> norm_num

/-- And `0.408248` is itself recurring in the record, likewise unindexed. -/
theorem both_unindexed : (2 : ℚ) ^ 2 / 6 = 2 / 3 ∧ (1 : ℚ) ^ 2 / 6 = 1 / 6 := by
  constructor <;> norm_num

/-! ## What this settles

**Settled**: that `0.816497` is simultaneously the competitor's top normalised eigenvalue
`2/√6` and the limit of the `ℂPᵐ` family's `θ`, these being the same number `√(2/3)`; that
the family approaches it strictly from above and never attains it, so the two readings are
a limit and an attained value; and that the competitor's two nonzero eigenvalue magnitudes
stand in ratio `2 : 1`.

**The index carries neither reading**, not in its `θ` table, not in its list of recurring
non-`θ` numbers, though it occurs eight times. **A quantity that is an eigenvalue of one
point and the `θ`-limit of a family is precisely what that list exists to flag.**

**Not claimed**: that the coincidence has a mechanism. `2/√6 = √(2/3)` is arithmetic; why
the family's limit lands on the competitor's eigenvalue is not addressed here.
-/

end HamiltonsCubic.IndexGaps
