import HamiltonsCubic.Base.RelationBSharp
import HamiltonsCubic.Base.RelationB

set_option linter.style.longLine false

/-!
# `sharpMat WCP2` without unfolding it, and what that does and does not buy

**THE TREE'S LAST `native_decide` WAS `WCP2_sharp_one` in [RelationB.lean](RelationB.lean)**, and
[RelationBSharp.lean](RelationBSharp.lean) records three structurally different attempts at it,
each killed on MEMORY at 2.4, 6 and 6.4 GB.

**Phase 1 found that all three were still unfolding a matrix they did not have to.** The
polarisation needs three: `sharpMat (WCP2 + 1)` and `sharpMat 1` are the seventy-two entry lemmas
already proved there, and `sharpMat WCP2` is not among them. *It never needs unfolding, because
`WCP2_critical'` is kernel-checked and `Qop R = R * R + sharpMat R`.*

**THAT HALF IS NOW PROVED AND IT IS CHEAP**: `sharpMat_WCP2_eq` below elaborates in SECONDS, where
the route it replaces was unbudgeted.

## What the assembly then costs, MEASURED rather than guessed, 2026-09-23

*Both runs were capped by watching the child's resident size, since `ulimit -v` is unsupported on
this platform.*

* **One `simp only` pass over the seventy-two entry lemmas: 8 seconds, peak 5.3 GB, and ONE
  unsolved goal**, the `(0,0)` entry, where `WCP2` had been unfolded to its literal before the
  entry lemmas stated in terms of the NAME could fire.
* **Adding the `Fin` normalisation pass that [CP2Sharp.lean](CP2Sharp.lean)'s recipe calls for,
  then a second pass for `Matrix.mul_apply`: KILLED at 7 GB.**

**So the split is confirmed and the assembly is not.** *The blowup is not in `sharpQF`, which no
longer appears anywhere, and not in the third matrix, which is now a citation. It is in the
interaction between `fin_cases`'s constructor form and lemmas stated at literals, and every extra
reduction pass added to fix that costs more than it saves.* **A successor works the entry shape,
thirty-six named goals that never share a `simp` set, rather than adding passes to one goal.**

## The entry shape, measured too, and COST IS NOT THE OBSTACLE

*One entry stated at literal indices, `sharpBilin WCP2 1 0 0 = (-WCP2) 0 0`, with no `fin_cases`
anywhere, so the constructor form never arises:* **4.3 seconds at peak 5.30 GB, against 5.29 GB
for a file that merely imports this one** ([r1090](../../../reviews/REVIEW_r1090.md), measured with
the toolchain free). *The entry shape therefore costs 0.01 GB beyond loading the oleans.*

**And the entry lemmas DO fire**: the goal that remains has `1` and `3` standing where
`sharpMat (WCP2 + 1) 0 0` and `(3 • WCP2) 0 0` were. **What is left is the literal matrix product
`WCP2 * WCP2` not reducing**, which is a `simp`-set question about `Matrix.vecCons` indexing and
not a budget question.

**THE ENTRY SHAPE CLOSES IT, 2026-09-23.** *`WCP2_sq` gives the literal product once, and each of
the thirty-six `sharpBilin_WCP2_one_ab` rewrites with its two entry lemmas, `sharpMat_WCP2_eq` and
`WCP2_sq`, then closes by `simp` at literal indices.* **`WCP2_sharp_one` below assembles them by
`exact` after `fin_cases`**, so no `simp` set ever meets the constructor form, and the tree carries
no `native_decide` tactic.
-/

namespace HamiltonsCubic.Base

/-- **`sharpMat WCP2` WITHOUT UNFOLDING IT**, from kernel-checked criticality.

*`Qop R = R * R + sharpMat R` and `WCP2_critical' : Qop WCP2 = 3 • WCP2`, so the third matrix the
polarisation needs is a product of rational literals rather than a `sharpQF` evaluation.* -/
theorem sharpMat_WCP2_eq : sharpMat WCP2 = (3 : ℚ) • WCP2 - WCP2 * WCP2 := by
  have h := WCP2_critical'
  unfold Qop at h
  rw [← h]
  abel

/-! ## The entry shape: `WCP2_sharp_one` entry by entry, kernel-checked -/

/-- `WCP2²`, a product of rational literals. -/
theorem WCP2_sq : WCP2 * WCP2 = !![2, 0, 0, 0, 0, 2; 0, 1/2, 0, 0, -1/2, 0; 0, 0, 1/2, 1/2, 0, 0;
    0, 0, 1/2, 1/2, 0, 0; 0, -1/2, 0, 0, 1/2, 0; 2, 0, 0, 0, 0, 2] := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [WCP2, Matrix.mul_apply, Fin.sum_univ_six] <;> norm_num

/-- One entry of the polarisation. -/
theorem sharpBilin_apply (X Y : Matrix (Fin 6) (Fin 6) ℚ) (a b : Fin 6) :
    sharpBilin X Y a b = (1/2) * (sharpMat (X + Y) a b - sharpMat X a b - sharpMat Y a b) := by
  simp [sharpBilin]
theorem sharpBilin_WCP2_one_00 : sharpBilin WCP2 1 0 0 = -WCP2 0 0 := by
  rw [sharpBilin_apply, sharpMat_WI_00, sharpMat_I_00, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_01 : sharpBilin WCP2 1 0 1 = -WCP2 0 1 := by
  rw [sharpBilin_apply, sharpMat_WI_01, sharpMat_I_01, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_02 : sharpBilin WCP2 1 0 2 = -WCP2 0 2 := by
  rw [sharpBilin_apply, sharpMat_WI_02, sharpMat_I_02, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_03 : sharpBilin WCP2 1 0 3 = -WCP2 0 3 := by
  rw [sharpBilin_apply, sharpMat_WI_03, sharpMat_I_03, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_04 : sharpBilin WCP2 1 0 4 = -WCP2 0 4 := by
  rw [sharpBilin_apply, sharpMat_WI_04, sharpMat_I_04, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_05 : sharpBilin WCP2 1 0 5 = -WCP2 0 5 := by
  rw [sharpBilin_apply, sharpMat_WI_05, sharpMat_I_05, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_10 : sharpBilin WCP2 1 1 0 = -WCP2 1 0 := by
  rw [sharpBilin_apply, sharpMat_WI_10, sharpMat_I_10, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_11 : sharpBilin WCP2 1 1 1 = -WCP2 1 1 := by
  rw [sharpBilin_apply, sharpMat_WI_11, sharpMat_I_11, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_12 : sharpBilin WCP2 1 1 2 = -WCP2 1 2 := by
  rw [sharpBilin_apply, sharpMat_WI_12, sharpMat_I_12, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_13 : sharpBilin WCP2 1 1 3 = -WCP2 1 3 := by
  rw [sharpBilin_apply, sharpMat_WI_13, sharpMat_I_13, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_14 : sharpBilin WCP2 1 1 4 = -WCP2 1 4 := by
  rw [sharpBilin_apply, sharpMat_WI_14, sharpMat_I_14, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_15 : sharpBilin WCP2 1 1 5 = -WCP2 1 5 := by
  rw [sharpBilin_apply, sharpMat_WI_15, sharpMat_I_15, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_20 : sharpBilin WCP2 1 2 0 = -WCP2 2 0 := by
  rw [sharpBilin_apply, sharpMat_WI_20, sharpMat_I_20, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_21 : sharpBilin WCP2 1 2 1 = -WCP2 2 1 := by
  rw [sharpBilin_apply, sharpMat_WI_21, sharpMat_I_21, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_22 : sharpBilin WCP2 1 2 2 = -WCP2 2 2 := by
  rw [sharpBilin_apply, sharpMat_WI_22, sharpMat_I_22, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_23 : sharpBilin WCP2 1 2 3 = -WCP2 2 3 := by
  rw [sharpBilin_apply, sharpMat_WI_23, sharpMat_I_23, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_24 : sharpBilin WCP2 1 2 4 = -WCP2 2 4 := by
  rw [sharpBilin_apply, sharpMat_WI_24, sharpMat_I_24, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_25 : sharpBilin WCP2 1 2 5 = -WCP2 2 5 := by
  rw [sharpBilin_apply, sharpMat_WI_25, sharpMat_I_25, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_30 : sharpBilin WCP2 1 3 0 = -WCP2 3 0 := by
  rw [sharpBilin_apply, sharpMat_WI_30, sharpMat_I_30, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_31 : sharpBilin WCP2 1 3 1 = -WCP2 3 1 := by
  rw [sharpBilin_apply, sharpMat_WI_31, sharpMat_I_31, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_32 : sharpBilin WCP2 1 3 2 = -WCP2 3 2 := by
  rw [sharpBilin_apply, sharpMat_WI_32, sharpMat_I_32, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_33 : sharpBilin WCP2 1 3 3 = -WCP2 3 3 := by
  rw [sharpBilin_apply, sharpMat_WI_33, sharpMat_I_33, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_34 : sharpBilin WCP2 1 3 4 = -WCP2 3 4 := by
  rw [sharpBilin_apply, sharpMat_WI_34, sharpMat_I_34, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_35 : sharpBilin WCP2 1 3 5 = -WCP2 3 5 := by
  rw [sharpBilin_apply, sharpMat_WI_35, sharpMat_I_35, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_40 : sharpBilin WCP2 1 4 0 = -WCP2 4 0 := by
  rw [sharpBilin_apply, sharpMat_WI_40, sharpMat_I_40, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_41 : sharpBilin WCP2 1 4 1 = -WCP2 4 1 := by
  rw [sharpBilin_apply, sharpMat_WI_41, sharpMat_I_41, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_42 : sharpBilin WCP2 1 4 2 = -WCP2 4 2 := by
  rw [sharpBilin_apply, sharpMat_WI_42, sharpMat_I_42, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_43 : sharpBilin WCP2 1 4 3 = -WCP2 4 3 := by
  rw [sharpBilin_apply, sharpMat_WI_43, sharpMat_I_43, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_44 : sharpBilin WCP2 1 4 4 = -WCP2 4 4 := by
  rw [sharpBilin_apply, sharpMat_WI_44, sharpMat_I_44, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_45 : sharpBilin WCP2 1 4 5 = -WCP2 4 5 := by
  rw [sharpBilin_apply, sharpMat_WI_45, sharpMat_I_45, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_50 : sharpBilin WCP2 1 5 0 = -WCP2 5 0 := by
  rw [sharpBilin_apply, sharpMat_WI_50, sharpMat_I_50, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_51 : sharpBilin WCP2 1 5 1 = -WCP2 5 1 := by
  rw [sharpBilin_apply, sharpMat_WI_51, sharpMat_I_51, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_52 : sharpBilin WCP2 1 5 2 = -WCP2 5 2 := by
  rw [sharpBilin_apply, sharpMat_WI_52, sharpMat_I_52, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_53 : sharpBilin WCP2 1 5 3 = -WCP2 5 3 := by
  rw [sharpBilin_apply, sharpMat_WI_53, sharpMat_I_53, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_54 : sharpBilin WCP2 1 5 4 = -WCP2 5 4 := by
  rw [sharpBilin_apply, sharpMat_WI_54, sharpMat_I_54, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
theorem sharpBilin_WCP2_one_55 : sharpBilin WCP2 1 5 5 = -WCP2 5 5 := by
  rw [sharpBilin_apply, sharpMat_WI_55, sharpMat_I_55, sharpMat_WCP2_eq, WCP2_sq]
  simp [WCP2] <;> norm_num
/-- **Relation (B) at the competitor, `W # I = -W`, KERNEL-CHECKED**, entry by entry. *The sign is
`-1`, and this is the form `𝒜(W) = 2W` takes. It replaces the tree's last `native_decide`.* -/
theorem WCP2_sharp_one : sharpBilin WCP2 1 = -WCP2 := by
  ext a b
  fin_cases a <;> fin_cases b
  · exact sharpBilin_WCP2_one_00
  · exact sharpBilin_WCP2_one_01
  · exact sharpBilin_WCP2_one_02
  · exact sharpBilin_WCP2_one_03
  · exact sharpBilin_WCP2_one_04
  · exact sharpBilin_WCP2_one_05
  · exact sharpBilin_WCP2_one_10
  · exact sharpBilin_WCP2_one_11
  · exact sharpBilin_WCP2_one_12
  · exact sharpBilin_WCP2_one_13
  · exact sharpBilin_WCP2_one_14
  · exact sharpBilin_WCP2_one_15
  · exact sharpBilin_WCP2_one_20
  · exact sharpBilin_WCP2_one_21
  · exact sharpBilin_WCP2_one_22
  · exact sharpBilin_WCP2_one_23
  · exact sharpBilin_WCP2_one_24
  · exact sharpBilin_WCP2_one_25
  · exact sharpBilin_WCP2_one_30
  · exact sharpBilin_WCP2_one_31
  · exact sharpBilin_WCP2_one_32
  · exact sharpBilin_WCP2_one_33
  · exact sharpBilin_WCP2_one_34
  · exact sharpBilin_WCP2_one_35
  · exact sharpBilin_WCP2_one_40
  · exact sharpBilin_WCP2_one_41
  · exact sharpBilin_WCP2_one_42
  · exact sharpBilin_WCP2_one_43
  · exact sharpBilin_WCP2_one_44
  · exact sharpBilin_WCP2_one_45
  · exact sharpBilin_WCP2_one_50
  · exact sharpBilin_WCP2_one_51
  · exact sharpBilin_WCP2_one_52
  · exact sharpBilin_WCP2_one_53
  · exact sharpBilin_WCP2_one_54
  · exact sharpBilin_WCP2_one_55

end HamiltonsCubic.Base
