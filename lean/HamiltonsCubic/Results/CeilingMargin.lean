import HamiltonsCubic.Results.HPFamily

/-!
# The refuted `0.837` ceiling, and the margin it really leaves

[LEDGER.md](../../../findings/LEDGER.md) records a repair:

> `90-appendix.tex` repeated the `0.837` ceiling with `ℍP²` **named in the same list**,
> and `09-status.tex` called the row **Proven**. Both corrected; **the margin is `0.109`,
> not `0.388`**, and the status now reads *Evidence*.

**Both margins are differences of surds already on the record**, and both check:

* `√(3/2) - √(7/10) = 1.224745 - 0.836660 = 0.388085`, the margin the ceiling claimed;
* `√(3/2) - √(56/45) = 1.224745 - 1.115547 = 0.109199`, the margin `ℍP²` leaves.

**The correction is a factor of `3.55`**, and the reason is structural: `ℍP²` was in the
list the ceiling was claimed over, at `√(56/45)`, far above `√(7/10)`.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.CeilingMargin

open HamiltonsCubic.HPFamily

/-! ## The two candidate ceilings -/

/-- The claimed ceiling, `√(7/10) = 0.836660`, the `𝔰𝔲(3)` adjoint. -/
theorem claimed_ceiling :
    (0.836659 : ℚ) ^ 2 < 7 / 10 ∧ (7 : ℚ) / 10 < (0.836661 : ℚ) ^ 2 := by
  constructor <;> norm_num

/-- `ℍP²`, in the same list, at `√(56/45) = 1.115547`, far above it. -/
theorem hp2_in_list : hpSq 2 = 56 / 45 := by norm_num [hpSq]

theorem hp2_above_claimed : (7 : ℚ) / 10 < hpSq 2 := by norm_num [hpSq]

/-- **By a factor over `1.7` in the square.** -/
theorem factor : (1.7 : ℚ) * (7 / 10) < hpSq 2 := by norm_num [hpSq]

/-! ## The two margins to `√(3/2)` -/

/-- The claimed margin, `0.388`: `√(3/2) - √(7/10)`. -/
theorem claimed_margin :
    (0.388 : ℚ) < 1.224746 - 0.836659 ∧ (1.224744 : ℚ) - 0.836661 < 0.3881 := by
  constructor <;> norm_num

/-- **The true margin, `0.109`**: `√(3/2) - √(56/45)`. -/
theorem true_margin :
    (0.109 : ℚ) < 1.224746 - 1.115546 ∧ (1.224744 : ℚ) - 1.115548 < 0.1093 := by
  constructor <;> norm_num

/-- **The correction is a factor over `3.5`.** -/
theorem correction_factor : (3.5 : ℚ) * 0.109 < 0.388 := by norm_num

/-! ## And `ℍP²` still clears the threshold

`56/45 < 3/2`, so the list's true maximum is below `√(3/2)`, the ceiling was wrong, the
conclusion it supported is not.
-/

theorem hp2_below_threshold : hpSq 2 < 3 / 2 := by norm_num [hpSq]

/-- With margin `23/90` in the square, which is the `0.109` in `θ`. -/
theorem margin_squared : 3 / 2 - hpSq 2 = 23 / 90 := by norm_num [hpSq]

/-- **So the repair narrows the claim without breaking it**, the status moving from
*Proven* to *Evidence* reflects the ceiling's failure, not the conclusion's. -/
theorem conclusion_survives : hpSq 2 < 3 / 2 ∧ (7 : ℚ) / 10 < 3 / 2 := by
  constructor <;> norm_num [hpSq]

/-! ## What this settles

**Settled**: that the claimed ceiling `√(7/10)` and `ℍP²`'s `√(56/45)` differ by a factor
over `1.7` in the square, so `ℍP²` could not sit under that ceiling; that the two margins
to `√(3/2)` are `0.388` and `0.109` as the ledger states, **a correction by a factor over
`3.5`**; and that `ℍP²` nonetheless clears `√(3/2)`, with margin `23/90` in the square,
**so the repair narrows the claim without breaking the conclusion.**

**Not claimed**: the list the ceiling ranged over, or the reason `ℍP²` belongs to it.
-/

end HamiltonsCubic.CeilingMargin
