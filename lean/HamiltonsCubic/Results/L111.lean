import Mathlib.Data.Nat.Choose.Basic
import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# L111, how much the bracket form drops at the balanced products

[bounds.md](../../../findings/bounds.md)'s Lemma L111, audited in
[ROUND_L111](../../../verification/ROUND_L111.md). The bracket form keeps criticality's
conditions only across distinct eigenvalues, so it drops `Σ_i C(m_i+1, 2)` of the `C(N+1, 2)`
conditions, with `m_i` the multiplicities of the **eigenvalues** of `W` on `Λ²`.

**At `S³ × S³` the `Λ²` Weyl spectrum has two eigenvalues, with multiplicities `(6, 9)`.** The two
factor blocks, `C(3,2) = 3` planes each, carry one common eigenvalue, because Ricci-flatness at an
index in either factor forces the two block values to agree, and the `3·3 = 9` cross planes carry
the other. The dropped conditions are `C(7,2) + C(10,2) = 21 + 45 = 66` of `C(16,2) = 120`, which is
`11/20`. **At `S² × S²` the multiplicities are `(2, 4)`**, dropping `C(3,2) + C(5,2) = 13` of
`C(7,2) = 21`.

**The share is not constant across the family**: `11/20 < 13/21`, so any single figure quoted for it
is a figure at one `n`.
-/

namespace HamiltonsCubic.BracketStrictness

/-- The dropped conditions in an eigenspace of multiplicity `m`: `C(m+1,2)`. -/
def dropped (m : ℕ) : ℕ := Nat.choose (m + 1) 2

/-! ## The balanced product at `n = 6` -/

/-- The `Λ²` eigenvalue multiplicities at `S³ × S³` are `6, 9`, summing to `C(6,2) = 15`. -/
theorem multiplicities_six : 6 + 9 = Nat.choose 6 2 := by decide

/-- The `6` is the two factor blocks merged, and the `9` is the cross block. -/
theorem factor_blocks_merge : Nat.choose 3 2 + Nat.choose 3 2 = 6 ∧ 3 * 3 = 9 := by
  refine ⟨by decide, by decide⟩

/-- **The dropped count is `66`.** -/
theorem dropped_six : dropped 6 + dropped 9 = 66 := by decide

/-- **Against a symmetric-matrix total of `120`.** -/
theorem total_six : Nat.choose 16 2 = 120 := by decide

/-- **So the share is `11/20`.** -/
theorem share_six : (66 : ℚ) / 120 = 11 / 20 := by norm_num

/-! ## The balanced product at `n = 4` -/

/-- At `S² × S²` the multiplicities are `2, 4`, summing to `C(4,2) = 6`. -/
theorem multiplicities_four : 2 + 4 = Nat.choose 4 2 := by decide

/-- **The dropped count there is `13`.** -/
theorem dropped_four : dropped 2 + dropped 4 = 13 := by decide

theorem total_four : Nat.choose 7 2 = 21 := by decide

/-! ## The share is not constant -/

/-- **`11/20 < 13/21`**, so the share varies across the family. -/
theorem share_not_constant : (11 : ℚ) / 20 < 13 / 21 := by norm_num

/-! ## The cross block carries most of the drop -/

/-- `C(m+1,2)` grows quadratically in the multiplicity, so the larger eigenspace dominates: at
`S³ × S³` the cross block alone accounts for `45` of the `66`, above `68%`. -/
theorem cross_dominates : dropped 9 = 45 ∧ 45 * 100 > 68 * 66 := by
  refine ⟨by decide, by decide⟩

end HamiltonsCubic.BracketStrictness
