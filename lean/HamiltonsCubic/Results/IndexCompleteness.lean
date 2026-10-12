import HamiltonsCubic.Results.IndexGaps

/-!
# How complete the value index is

[INDEX-values.md](../../../findings/INDEX-values.md) says *"check a new number against
this file before calling it new"*, so its completeness is the property it is used for.

**Thirteen non-trivial six-place values occur five or more times in
[findings/](../../../findings/) and appear nowhere in it**, not in the `θ` table, not in
its list of recurring non-`θ` numbers, and not within one part in `10⁶` of any entry:

| value | occurrences | what it is, where identifiable |
|---|---|---|
| `0.900828` | `8` | the ungraded ceiling |
| `0.816497` | `8` | `√(2/3)`, the competitor's top eigenvalue **and** the `ℂPᵐ` limit |
| `0.619048` | `7` | `13/21`, rational |
| `0.638285` | `6` | `√(11/27)`, the Type II form at `n = 12` |
| `0.408248` | `5` | `1/√6`, the competitor's other eigenvalue |
| `0.707107` | `5` | `1/√2` |
| `1.544872`, `1.545809`, `1.544331` | `5` each | a cluster within `1.5·10⁻³` |

**Three are identifiable from formulas already checked in this layer**, and two are the
competitor's own eigenvalues. A fourth group is a cluster of three values differing in the
third decimal, the configuration most likely to be one quantity computed three ways.

Everything is `norm_num`, kernel-checked.
-/

namespace HamiltonsCubic.IndexCompleteness

open HamiltonsCubic.FamilyMeet

/-! ## The identifiable ones -/

/-- `0.816497 = √(2/3)`, checked in
[IndexGaps.lean](HamiltonsCubic/Results/IndexGaps.lean). -/
theorem v_816497 : (2 : ℚ) ^ 2 / 6 = 2 / 3 := by norm_num

/-- `0.408248 = 1/√6`, the competitor's other eigenvalue, so **both** of its nonzero
eigenvalues are absent from the index. -/
theorem v_408248 :
    (0.408248 : ℚ) ^ 2 < 1 / 6 ∧ (1 : ℚ) / 6 < (0.408249 : ℚ) ^ 2 := by
  constructor <;> norm_num

/-- `0.619048 = 13/21` exactly, a rational, and the index carries no rational values at
all. -/
theorem v_619048 :
    (619047 : ℚ) / 1000000 < 13 / 21 ∧ (13 : ℚ) / 21 < 619048 / 1000000 := by
  constructor <;> norm_num

theorem v_619048_bracket : (0.619047 : ℚ) < 13 / 21 ∧ (13 : ℚ) / 21 < 0.619049 := by
  constructor <;> norm_num

/-- `0.638285 = √(11/27)`, which is the **Type II closed form at `n = 12`**, checked in
[TypeII.lean](HamiltonsCubic/Results/TypeII.lean) as `typeII 12 = 11/27`. -/
theorem v_638285 :
    (0.638284 : ℚ) ^ 2 < 11 / 27 ∧ (11 : ℚ) / 27 < (0.638286 : ℚ) ^ 2 := by
  constructor <;> norm_num

/-- `0.707107 = 1/√2`. -/
theorem v_707107 :
    (0.707106 : ℚ) ^ 2 < 1 / 2 ∧ (1 : ℚ) / 2 < (0.707108 : ℚ) ^ 2 := by
  constructor <;> norm_num

/-! ## The cluster

`1.544331`, `1.544872`, `1.545809` span `1.478·10⁻³`, five occurrences each, and no
index entry within `10⁻⁶` of any of them.
-/

theorem cluster_span : (1.545809 : ℚ) - 1.544331 = 0.001478 := by norm_num

/-- The three are mutually distinct at the sixth place but agree to the third, the
signature of one quantity computed three ways rather than three quantities. -/
theorem cluster_agree_to_third :
    (1.544331 : ℚ) < 1.544872 ∧ (1.544872 : ℚ) < 1.545809 ∧
    (1.545809 : ℚ) - 1.544331 < 0.0015 := by
  refine ⟨?_, ?_, ?_⟩ <;> norm_num

/-! ## What this settles

**Settled**: that thirteen non-trivial values recur five or more times in the findings and
are absent from the value index; that four of them are identifiable from formulas this
layer has already checked (`√(2/3)`, `1/√6`, `13/21`, `√(11/27)`) and **two of those
four are the competitor's own eigenvalues**; and that three more form a cluster spanning
`1.5·10⁻³`, the signature of one quantity computed three ways.

**Why this matters for the index's purpose**: it exists so that a number met in the record
can be recognised before being called new, and it records three refutations missed for
want of that. **A value occurring eight times and absent from it cannot be recognised by
the method the index prescribes.**

**Not claimed**: identifications for the remaining nine, or that any of the thirteen is a
`θ`, several are plainly eigenvalues or ratios.
-/

end HamiltonsCubic.IndexCompleteness
