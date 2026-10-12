import HamiltonsCubic.Results.L88
import Mathlib.Data.Nat.Choose.Basic

/-!
# L59, the necessary condition's dimension count, block by block

[L59](../../../results.md) states that the invariant symmetric forms split as
`65 = 36 + 29`, *"counted block by block, an odd-λ₂ block dies entirely, an even one
keeps `u ⊗ v + v ⊗ u`"*, and calls the count the certificate's necessary condition.

The record gives the mechanism in that clause and the number in the sum, and checks
neither against the other. Here the mechanism **is** the computation: the `29` is
derived from the stated rule, not read off a difference.

Everything is `decide`, kernel-checked, no `native_decide`.
-/

namespace HamiltonsCubic.Blocks

/-- The invariant symmetric forms on a block that vanish on `K × K`.

Under the stated rule this is forced. An odd-`b` block sits inside `K` entire, so a
form vanishing on `K × K` vanishes on the block outright and the count is `0`. An
even-`b` block meets `K` in codimension one, so the forms killing `K × K` are those
with one slot along the missing direction, `u ⊗ v + v ⊗ u` as `v` runs over the
block's `m` multiplicity directions, giving `m`. -/
def Block.killsK (B : Block) : ℕ := if B.evenSecond then B.mult else 0

/-- **The `29` is the sum of the multiplicities of the sixteen even blocks**, which is
what *"an even one keeps `u ⊗ v + v ⊗ u`"* says when the clause is counted. -/
theorem killsK_sum : (table.map Block.killsK).sum = 29 := by decide

/-- The same number as a difference of the two counts already proved, so the stated
mechanism and the stated arithmetic agree, which the record asserts and does not check. -/
theorem killsK_eq_difference :
    (table.map Block.killsK).sum
      = (table.map (fun B => B.mult * (B.mult + 1) / 2)).sum
        - (restrictedTable.map (fun B => B.restricted * (B.restricted + 1) / 2)).sum := by
  decide

/-- **`65 = 36 + 29`.** -/
theorem L59_split :
    (table.map (fun B => B.mult * (B.mult + 1) / 2)).sum
      = (restrictedTable.map (fun B => B.restricted * (B.restricted + 1) / 2)).sum
        + (table.map Block.killsK).sum := by decide

/-- Termwise, an even block contributes `C(m+1,2) = C(m,2) + m` and an odd block
contributes `C(m+1,2)` to the unrestricted count and the same to the restricted one.
So the split is forced blockwise rather than only in total, which is what makes it a
count and not a coincidence. -/
theorem split_blockwise (B : Block) :
    (B.mult + 1).choose 2 = (B.restricted + 1).choose 2 + B.killsK := by
  unfold Block.restricted Block.killsK
  cases h : B.evenSecond with
  | false => simp
  | true =>
    simp only [if_true]
    cases hm : B.mult with
    | zero => rfl
    | succ k =>
      simp only [Nat.succ_sub_one]
      rw [Nat.choose_succ_succ (k + 1) 1, Nat.choose_one_right]
      simp only [Nat.succ_eq_add_one, Nat.reduceAdd]
      omega

/-- The bridge to the `/2` form the aggregate counts above are written in. -/
theorem choose_two_eq (m : ℕ) : (m + 1).choose 2 = m * (m + 1) / 2 := by
  rw [Nat.choose_two_right, Nat.add_sub_cancel, Nat.mul_comm]

/-! ## The affine family

With the restricted rank `13` that [L62](../../../findings/sym3-blocks.md) reports,
the solution set of the certificate's linear system has dimension `36 - 13 = 23`.
The `13` is not proved here (it is the value round L62 examined) so the identity
below is arithmetic, stated so that a change to either number is visible.
-/

theorem affine_family : 36 - 13 = 23 := by norm_num

/-! ## What stays owed

The multiplicity column, L86's parity rule and the codimension-one statement for an
even block are imported. This file derives the `29` from them and shows the record's
two accounts of it agree; it does not prove the rule.
-/

end HamiltonsCubic.Blocks
