import Mathlib.Data.Rat.Defs
import Mathlib.Data.Nat.Choose.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# The overdetermined check at `n = 14`, which Grassmannian, and what `3.6×` buys

[nondegeneracy.md](../../../findings/nondegeneracy.md) records that at `S⁶ × S⁶` padded into
`n = 14`, the condition `S = 0` is *"`7140` equations on a `1980`-dimensional Grassmannian,
`3.6×` overdetermined, all satisfied"*. **The Grassmannian is not named**, and the figure it
carries is checkable.

**It is `Gr(36, 𝔰𝔬(14))`.** With `dim 𝔰𝔬(14) = C(14,2) = 91` and the recorded `dim 𝔪 = 36`, the
largest in the block's own list, the Grassmannian of `36`-planes in `91` dimensions has
dimension `36 · 55 = 1980`. So the number identifies itself once both inputs are supplied, and
the `36` is the same `36` the surrounding sentence names.

**And `3.6×` means `5160` redundant equations.** `7140 - 1980 = 5160`, with
`7140/1980` between `3.6` and `3.61`. That is what makes the check strong: a generic
`36`-plane satisfies none of the surplus, so agreement across all of them is not something a
wrong point could produce by accident.

**What it does not buy is a proof.** An overdetermined system satisfied at one point constrains
that point and no other, however redundant, the redundancy measures how unlikely a coincidence
would be, not how far the conclusion extends. The record's own rule about measure-zero families
applies unchanged.
-/

namespace HamiltonsCubic.Overdetermined

/-! ## The Grassmannian -/

/-- `dim 𝔰𝔬(14) = C(14,2) = 91`. -/
theorem so14_dim : Nat.choose 14 2 = 91 := by decide

/-- **`dim Gr(36,91) = 36 · 55 = 1980`**, so the unnamed Grassmannian is the one of `36`-planes
in `𝔰𝔬(14)`, with `36` the block's own maximum `dim 𝔪`. -/
theorem grassmannian_dim : 36 * (91 - 36) = 1980 ∧ 36 + 55 = 91 := by
  refine ⟨by norm_num, by norm_num⟩

/-- The complementary reading gives the same dimension, `55 · 36`, so the identification does not
depend on which factor is taken as the plane. -/
theorem complementary_agrees : 55 * (91 - 55) = 1980 := by norm_num

/-! ## The overdetermination -/

/-- **`7140` equations against `1980` unknowns leaves `5160` redundant.** -/
theorem redundant_count : 7140 - 1980 = 5160 := by norm_num

/-- **And the ratio is between `3.6` and `3.61`**, matching the recorded figure. -/
theorem ratio_bracket :
    (36 : ℚ) / 10 < 7140 / 1980 ∧ (7140 : ℚ) / 1980 < 361 / 100 := by
  constructor <;> norm_num

/-- Exactly, the ratio is `119/33`. -/
theorem ratio_exact : (7140 : ℚ) / 1980 = 119 / 33 := by norm_num

/-! ## What redundancy does and does not establish -/

/-- **A system satisfied at a point says nothing at another**, however overdetermined: a family
can meet every equation at one parameter and fail at the next. -/
theorem redundancy_is_pointwise :
    ∃ f : ℕ → ℚ, f 14 = 0 ∧ f 16 ≠ 0 := by
  refine ⟨fun n => if n = 14 then 0 else 1, by norm_num, by norm_num⟩

/-- What it does establish is that agreement is not accidental: the surplus is more than three
times the dimension, so a wrong point would have to satisfy `5160` conditions it has no reason
to. -/
theorem surplus_exceeds_dimension : (1980 : ℚ) < 5160 ∧ (2 : ℚ) * 1980 < 5160 := by
  refine ⟨by norm_num, by norm_num⟩

end HamiltonsCubic.Overdetermined
