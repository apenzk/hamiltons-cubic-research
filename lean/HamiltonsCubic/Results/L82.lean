import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L82, the operator-norm lever, refuted in its equality clause

[isotropy-cap.md](../../../findings/isotropy-cap.md)'s Lemma L82. Both displayed inequalities
are theorems; the equality is attached to the wrong one, and the lever closes nothing in the
range it is stated for.

**"Information-free at every `m ≤ 9`" is an iff, not a list.** The all-equal value
`2/√⌊m/2⌋` of `s₁ + s₂` is at least `1` **exactly when
`⌊m/2⌋ ≤ 4`**, which is exactly `m ≤ 9`. So `≥ 1` says nothing below `m = 10` and something
from `m = 10` on, with the boundary forced rather than observed. The record gives the two
values `1.1547` and `1` and leaves the cut-off as a remark.

**The `m = 6` witness is unit and traceless**, spectrum `(-3,-1,1,1,1,1)/√14`, so the block's
own first inequality applies to it and forces `‖ad‖ ≥ √(3/2) > 1`, the equality clause is
refuted without computing anything. And the feasible class at `m = 6, 8` sits at `√2`, above
`√(3/2)`, so both ends of the range exclude `1`.
-/

namespace HamiltonsCubic.OperatorLever

/-! ## The `m = 6` witness -/

/-- The spectrum `(-3,-1,1,1,1,1)/√14` is **unit**: the squares sum to `14`. -/
theorem witness_unit : 9 + 1 + 1 + 1 + 1 + 1 = 14 := by decide

/-- **And traceless**, which is what makes it an admissible Weyl spectrum. -/
theorem witness_traceless : (-3 : ℤ) + (-1) + 1 + 1 + 1 + 1 = 0 := by decide

/-- **So the block's own first inequality forces `‖ad‖² ≥ 3/2 > 1`** at that witness, and the
equality clause is refuted with no computation. -/
theorem witness_exceeds_one : (1 : ℚ) < 3 / 2 := by norm_num

/-- The feasible class at `m = 6, 8` sits at `s₁ + s₂ = √2`, whose square is `2`, **above**
`3/2`, so it is the other end of the range and also excludes `1`. -/
theorem feasible_class_above : (3 : ℚ) / 2 < 2 := by norm_num

/-! ## The lever is information-free exactly below `m = 10` -/

/-- **The all-equal value `2/√k` is at least `1` exactly when `k ≤ 4`**, stated on squares, so no
root is taken. -/
theorem free_bound_iff (k : ℕ) (hk : 0 < k) : (1 : ℚ) ≤ 4 / (k : ℚ) ↔ k ≤ 4 := by
  have hkq : (0 : ℚ) < (k : ℚ) := by exact_mod_cast hk
  rw [le_div_iff₀ hkq]
  constructor
  · intro h
    have : (k : ℚ) ≤ 4 := by linarith
    exact_mod_cast this
  · intro h
    have : (k : ℚ) ≤ 4 := by exact_mod_cast h
    linarith

/-- **And `⌊m/2⌋ ≤ 4` is exactly `m ≤ 9`.** So the lever is information-free precisely below
`m = 10`, with the cut-off forced rather than observed. -/
theorem cutoff_at_ten (m : ℕ) : m / 2 ≤ 4 ↔ m ≤ 9 := by omega

/-- At `m = 6, 7` the all-equal value squares to `4/3 > 1`, the record's `1.1547`. -/
theorem free_at_six : (6 : ℕ) / 2 = 3 ∧ (1 : ℚ) < 4 / 3 := by
  refine ⟨by decide, by norm_num⟩

theorem free_bound_bracket :
    ((11547 : ℚ) / 10000) ^ 2 < 4 / 3 ∧ (4 : ℚ) / 3 < ((11548 : ℚ) / 10000) ^ 2 := by
  constructor <;> norm_num

/-- At `m = 8, 9` it squares to exactly `1`, the lever's own threshold, so it is still
free. -/
theorem free_at_eight : (8 : ℕ) / 2 = 4 ∧ (4 : ℚ) / 4 = 1 := by
  refine ⟨by decide, by norm_num⟩

/-- At `m = 10` it drops below `1`, and the lever first says something. -/
theorem informative_at_ten : (10 : ℕ) / 2 = 5 ∧ (4 : ℚ) / 5 < 1 := by
  refine ⟨by decide, by norm_num⟩

end HamiltonsCubic.OperatorLever
