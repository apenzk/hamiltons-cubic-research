import HamiltonsCubic.Base.CP2Sharp

/-!
# Relation (B) at the competitor, in the kernel

`sharpBilin X Y = ½(sharpMat (X+Y) - sharpMat X - sharpMat Y)`, so `W # I = -W` rests on three
matrices. **Two are already on file**: `sharpMat W` comes from [CP2Sharp.lean](CP2Sharp.lean)'s
twenty-one evaluations, and `sharpMat I` is the `n = 4` anchor. *This file supplies the third,
`sharpMat (W + I)`, by the same per-declaration split.*

**THE RECORD GUESSED THE WRONG FIX.** *[RelationB.lean](RelationB.lean) proposed supplying `WCP2`'s
entries as `rfl` facts, which shrinks the goal without changing what exhausts the budget.* The
budget is per declaration, so what works is putting each evaluation in a declaration of its own.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

/-! ## `sharpQF` at `W + I`, six diagonal and fifteen pairwise -/

set_option maxHeartbeats 4000000 in
theorem sharpQF_WI_d0 : sharpQF (WCP2 + 1) (Pi.single 0 1) = 1 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_WI_d1 : sharpQF (WCP2 + 1) (Pi.single 1 1) = 1 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_WI_d2 : sharpQF (WCP2 + 1) (Pi.single 2 1) = 1 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_WI_d3 : sharpQF (WCP2 + 1) (Pi.single 3 1) = 1 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_WI_d4 : sharpQF (WCP2 + 1) (Pi.single 4 1) = 1 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_WI_d5 : sharpQF (WCP2 + 1) (Pi.single 5 1) = 1 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_WI_p01 :
    sharpQF (WCP2 + 1) (Pi.single 0 1 + Pi.single 1 1) = 2 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_WI_p02 :
    sharpQF (WCP2 + 1) (Pi.single 0 1 + Pi.single 2 1) = 2 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_WI_p03 :
    sharpQF (WCP2 + 1) (Pi.single 0 1 + Pi.single 3 1) = 2 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_WI_p04 :
    sharpQF (WCP2 + 1) (Pi.single 0 1 + Pi.single 4 1) = 2 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_WI_p05 :
    sharpQF (WCP2 + 1) (Pi.single 0 1 + Pi.single 5 1) = 0 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_WI_p12 :
    sharpQF (WCP2 + 1) (Pi.single 1 1 + Pi.single 2 1) = 2 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_WI_p13 :
    sharpQF (WCP2 + 1) (Pi.single 1 1 + Pi.single 3 1) = 2 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_WI_p14 :
    sharpQF (WCP2 + 1) (Pi.single 1 1 + Pi.single 4 1) = 4 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_WI_p15 :
    sharpQF (WCP2 + 1) (Pi.single 1 1 + Pi.single 5 1) = 2 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_WI_p23 :
    sharpQF (WCP2 + 1) (Pi.single 2 1 + Pi.single 3 1) = 0 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_WI_p24 :
    sharpQF (WCP2 + 1) (Pi.single 2 1 + Pi.single 4 1) = 2 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_WI_p25 :
    sharpQF (WCP2 + 1) (Pi.single 2 1 + Pi.single 5 1) = 2 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_WI_p34 :
    sharpQF (WCP2 + 1) (Pi.single 3 1 + Pi.single 4 1) = 2 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_WI_p35 :
    sharpQF (WCP2 + 1) (Pi.single 3 1 + Pi.single 5 1) = 2 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_WI_p45 :
    sharpQF (WCP2 + 1) (Pi.single 4 1 + Pi.single 5 1) = 2 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

/-! ## `sharpQF` at the identity, which is the `n = 4` anchor twice over -/

/-- The identity's diagonal is the `n = 4` anchor, already proved for EVERY index. -/
theorem sharpQF_I_d0 : sharpQF 1 (Pi.single 0 1) = 2 := sharpQF_one_basis 0

/-- The identity's diagonal is the `n = 4` anchor, already proved for EVERY index. -/
theorem sharpQF_I_d1 : sharpQF 1 (Pi.single 1 1) = 2 := sharpQF_one_basis 1

/-- The identity's diagonal is the `n = 4` anchor, already proved for EVERY index. -/
theorem sharpQF_I_d2 : sharpQF 1 (Pi.single 2 1) = 2 := sharpQF_one_basis 2

/-- The identity's diagonal is the `n = 4` anchor, already proved for EVERY index. -/
theorem sharpQF_I_d3 : sharpQF 1 (Pi.single 3 1) = 2 := sharpQF_one_basis 3

/-- The identity's diagonal is the `n = 4` anchor, already proved for EVERY index. -/
theorem sharpQF_I_d4 : sharpQF 1 (Pi.single 4 1) = 2 := sharpQF_one_basis 4

/-- The identity's diagonal is the `n = 4` anchor, already proved for EVERY index. -/
theorem sharpQF_I_d5 : sharpQF 1 (Pi.single 5 1) = 2 := sharpQF_one_basis 5

set_option maxHeartbeats 4000000 in
theorem sharpQF_I_p01 :
    sharpQF 1 (Pi.single 0 1 + Pi.single 1 1) = 4 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_I_p02 :
    sharpQF 1 (Pi.single 0 1 + Pi.single 2 1) = 4 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_I_p03 :
    sharpQF 1 (Pi.single 0 1 + Pi.single 3 1) = 4 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_I_p04 :
    sharpQF 1 (Pi.single 0 1 + Pi.single 4 1) = 4 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_I_p05 :
    sharpQF 1 (Pi.single 0 1 + Pi.single 5 1) = 4 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_I_p12 :
    sharpQF 1 (Pi.single 1 1 + Pi.single 2 1) = 4 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_I_p13 :
    sharpQF 1 (Pi.single 1 1 + Pi.single 3 1) = 4 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_I_p14 :
    sharpQF 1 (Pi.single 1 1 + Pi.single 4 1) = 4 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_I_p15 :
    sharpQF 1 (Pi.single 1 1 + Pi.single 5 1) = 4 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_I_p23 :
    sharpQF 1 (Pi.single 2 1 + Pi.single 3 1) = 4 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_I_p24 :
    sharpQF 1 (Pi.single 2 1 + Pi.single 4 1) = 4 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_I_p25 :
    sharpQF 1 (Pi.single 2 1 + Pi.single 5 1) = 4 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_I_p34 :
    sharpQF 1 (Pi.single 3 1 + Pi.single 4 1) = 4 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_I_p35 :
    sharpQF 1 (Pi.single 3 1 + Pi.single 5 1) = 4 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

set_option maxHeartbeats 4000000 in
theorem sharpQF_I_p45 :
    sharpQF 1 (Pi.single 4 1 + Pi.single 5 1) = 4 := by
  simp only [sharpQF, toMat4, coord4, basis4, pair4, br, phi, WCP2, Matrix.mul_apply,
    Matrix.single, Matrix.one_apply, Matrix.mulVec, dotProduct,
    Fin.sum_univ_six, Fin.sum_univ_four, Pi.single_apply, Matrix.sub_apply,
    Matrix.add_apply, Matrix.smul_apply, Fin.isValue, Matrix.of_apply, Matrix.cons_val',
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.empty_val',
    Matrix.cons_val_fin_one, Matrix.head_fin_const, Matrix.cons_val_succ,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  norm_num [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.head_cons,
    Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ, Matrix.cons_val_fin_one,
    Fin.ext_iff]

/-! ## The transposed arguments, which `sharpMat` meets at the mirrored entry -/

theorem sharpQF_WI_p10 :
    sharpQF (WCP2 + 1) (Pi.single 1 1 + Pi.single 0 1)
      = sharpQF (WCP2 + 1) (Pi.single 0 1 + Pi.single 1 1) := by
  exact congrArg (sharpQF (WCP2 + 1)) (add_comm _ _)

theorem sharpQF_WI_p20 :
    sharpQF (WCP2 + 1) (Pi.single 2 1 + Pi.single 0 1)
      = sharpQF (WCP2 + 1) (Pi.single 0 1 + Pi.single 2 1) := by
  exact congrArg (sharpQF (WCP2 + 1)) (add_comm _ _)

theorem sharpQF_WI_p30 :
    sharpQF (WCP2 + 1) (Pi.single 3 1 + Pi.single 0 1)
      = sharpQF (WCP2 + 1) (Pi.single 0 1 + Pi.single 3 1) := by
  exact congrArg (sharpQF (WCP2 + 1)) (add_comm _ _)

theorem sharpQF_WI_p40 :
    sharpQF (WCP2 + 1) (Pi.single 4 1 + Pi.single 0 1)
      = sharpQF (WCP2 + 1) (Pi.single 0 1 + Pi.single 4 1) := by
  exact congrArg (sharpQF (WCP2 + 1)) (add_comm _ _)

theorem sharpQF_WI_p50 :
    sharpQF (WCP2 + 1) (Pi.single 5 1 + Pi.single 0 1)
      = sharpQF (WCP2 + 1) (Pi.single 0 1 + Pi.single 5 1) := by
  exact congrArg (sharpQF (WCP2 + 1)) (add_comm _ _)

theorem sharpQF_WI_p21 :
    sharpQF (WCP2 + 1) (Pi.single 2 1 + Pi.single 1 1)
      = sharpQF (WCP2 + 1) (Pi.single 1 1 + Pi.single 2 1) := by
  exact congrArg (sharpQF (WCP2 + 1)) (add_comm _ _)

theorem sharpQF_WI_p31 :
    sharpQF (WCP2 + 1) (Pi.single 3 1 + Pi.single 1 1)
      = sharpQF (WCP2 + 1) (Pi.single 1 1 + Pi.single 3 1) := by
  exact congrArg (sharpQF (WCP2 + 1)) (add_comm _ _)

theorem sharpQF_WI_p41 :
    sharpQF (WCP2 + 1) (Pi.single 4 1 + Pi.single 1 1)
      = sharpQF (WCP2 + 1) (Pi.single 1 1 + Pi.single 4 1) := by
  exact congrArg (sharpQF (WCP2 + 1)) (add_comm _ _)

theorem sharpQF_WI_p51 :
    sharpQF (WCP2 + 1) (Pi.single 5 1 + Pi.single 1 1)
      = sharpQF (WCP2 + 1) (Pi.single 1 1 + Pi.single 5 1) := by
  exact congrArg (sharpQF (WCP2 + 1)) (add_comm _ _)

theorem sharpQF_WI_p32 :
    sharpQF (WCP2 + 1) (Pi.single 3 1 + Pi.single 2 1)
      = sharpQF (WCP2 + 1) (Pi.single 2 1 + Pi.single 3 1) := by
  exact congrArg (sharpQF (WCP2 + 1)) (add_comm _ _)

theorem sharpQF_WI_p42 :
    sharpQF (WCP2 + 1) (Pi.single 4 1 + Pi.single 2 1)
      = sharpQF (WCP2 + 1) (Pi.single 2 1 + Pi.single 4 1) := by
  exact congrArg (sharpQF (WCP2 + 1)) (add_comm _ _)

theorem sharpQF_WI_p52 :
    sharpQF (WCP2 + 1) (Pi.single 5 1 + Pi.single 2 1)
      = sharpQF (WCP2 + 1) (Pi.single 2 1 + Pi.single 5 1) := by
  exact congrArg (sharpQF (WCP2 + 1)) (add_comm _ _)

theorem sharpQF_WI_p43 :
    sharpQF (WCP2 + 1) (Pi.single 4 1 + Pi.single 3 1)
      = sharpQF (WCP2 + 1) (Pi.single 3 1 + Pi.single 4 1) := by
  exact congrArg (sharpQF (WCP2 + 1)) (add_comm _ _)

theorem sharpQF_WI_p53 :
    sharpQF (WCP2 + 1) (Pi.single 5 1 + Pi.single 3 1)
      = sharpQF (WCP2 + 1) (Pi.single 3 1 + Pi.single 5 1) := by
  exact congrArg (sharpQF (WCP2 + 1)) (add_comm _ _)

theorem sharpQF_WI_p54 :
    sharpQF (WCP2 + 1) (Pi.single 5 1 + Pi.single 4 1)
      = sharpQF (WCP2 + 1) (Pi.single 4 1 + Pi.single 5 1) := by
  exact congrArg (sharpQF (WCP2 + 1)) (add_comm _ _)

theorem sharpQF_I_p10 :
    sharpQF 1 (Pi.single 1 1 + Pi.single 0 1)
      = sharpQF 1 (Pi.single 0 1 + Pi.single 1 1) := by
  exact congrArg (sharpQF 1) (add_comm _ _)

theorem sharpQF_I_p20 :
    sharpQF 1 (Pi.single 2 1 + Pi.single 0 1)
      = sharpQF 1 (Pi.single 0 1 + Pi.single 2 1) := by
  exact congrArg (sharpQF 1) (add_comm _ _)

theorem sharpQF_I_p30 :
    sharpQF 1 (Pi.single 3 1 + Pi.single 0 1)
      = sharpQF 1 (Pi.single 0 1 + Pi.single 3 1) := by
  exact congrArg (sharpQF 1) (add_comm _ _)

theorem sharpQF_I_p40 :
    sharpQF 1 (Pi.single 4 1 + Pi.single 0 1)
      = sharpQF 1 (Pi.single 0 1 + Pi.single 4 1) := by
  exact congrArg (sharpQF 1) (add_comm _ _)

theorem sharpQF_I_p50 :
    sharpQF 1 (Pi.single 5 1 + Pi.single 0 1)
      = sharpQF 1 (Pi.single 0 1 + Pi.single 5 1) := by
  exact congrArg (sharpQF 1) (add_comm _ _)

theorem sharpQF_I_p21 :
    sharpQF 1 (Pi.single 2 1 + Pi.single 1 1)
      = sharpQF 1 (Pi.single 1 1 + Pi.single 2 1) := by
  exact congrArg (sharpQF 1) (add_comm _ _)

theorem sharpQF_I_p31 :
    sharpQF 1 (Pi.single 3 1 + Pi.single 1 1)
      = sharpQF 1 (Pi.single 1 1 + Pi.single 3 1) := by
  exact congrArg (sharpQF 1) (add_comm _ _)

theorem sharpQF_I_p41 :
    sharpQF 1 (Pi.single 4 1 + Pi.single 1 1)
      = sharpQF 1 (Pi.single 1 1 + Pi.single 4 1) := by
  exact congrArg (sharpQF 1) (add_comm _ _)

theorem sharpQF_I_p51 :
    sharpQF 1 (Pi.single 5 1 + Pi.single 1 1)
      = sharpQF 1 (Pi.single 1 1 + Pi.single 5 1) := by
  exact congrArg (sharpQF 1) (add_comm _ _)

theorem sharpQF_I_p32 :
    sharpQF 1 (Pi.single 3 1 + Pi.single 2 1)
      = sharpQF 1 (Pi.single 2 1 + Pi.single 3 1) := by
  exact congrArg (sharpQF 1) (add_comm _ _)

theorem sharpQF_I_p42 :
    sharpQF 1 (Pi.single 4 1 + Pi.single 2 1)
      = sharpQF 1 (Pi.single 2 1 + Pi.single 4 1) := by
  exact congrArg (sharpQF 1) (add_comm _ _)

theorem sharpQF_I_p52 :
    sharpQF 1 (Pi.single 5 1 + Pi.single 2 1)
      = sharpQF 1 (Pi.single 2 1 + Pi.single 5 1) := by
  exact congrArg (sharpQF 1) (add_comm _ _)

theorem sharpQF_I_p43 :
    sharpQF 1 (Pi.single 4 1 + Pi.single 3 1)
      = sharpQF 1 (Pi.single 3 1 + Pi.single 4 1) := by
  exact congrArg (sharpQF 1) (add_comm _ _)

theorem sharpQF_I_p53 :
    sharpQF 1 (Pi.single 5 1 + Pi.single 3 1)
      = sharpQF 1 (Pi.single 3 1 + Pi.single 5 1) := by
  exact congrArg (sharpQF 1) (add_comm _ _)

theorem sharpQF_I_p54 :
    sharpQF 1 (Pi.single 5 1 + Pi.single 4 1)
      = sharpQF 1 (Pi.single 4 1 + Pi.single 5 1) := by
  exact congrArg (sharpQF 1) (add_comm _ _)

/-! ## The thirty-six entries of `sharpMat (W + I)`, one declaration each

**THIS IS THE SPLIT THAT WORKS, AND TWO COARSER ONES DID NOT.** *Unfolding `sharpBilin` in a single
goal puts three `sharpMat` calls and up to nine `sharpQF` subterms in each of thirty-six branches;
that reached 2.4 GB. Closing each `sharpMat` MATRIX in one declaration still matched fifty-one
value lemmas across thirty-six branches; that reached 6 GB in seventy seconds.* **One declaration
per ENTRY carries one entry against three values, and the whole family elaborates in seconds with
flat memory.**

*The `Fin.reduceEq` simproc is load-bearing*: unfolding `sharpMat`'s `if a = b` raises disequality
SIDE CONDITIONS inside `simp`, which `<;>` never reaches, so `decide` after the fact cannot close
them however well it closes them in isolation.
-/

theorem sharpMat_WI_00 : sharpMat (WCP2 + 1) 0 0 = 1 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_d0] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_01 : sharpMat (WCP2 + 1) 0 1 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p01, sharpQF_WI_d0, sharpQF_WI_d1] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_02 : sharpMat (WCP2 + 1) 0 2 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p02, sharpQF_WI_d0, sharpQF_WI_d2] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_03 : sharpMat (WCP2 + 1) 0 3 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p03, sharpQF_WI_d0, sharpQF_WI_d3] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_04 : sharpMat (WCP2 + 1) 0 4 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p04, sharpQF_WI_d0, sharpQF_WI_d4] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_05 : sharpMat (WCP2 + 1) 0 5 = -1 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p05, sharpQF_WI_d0, sharpQF_WI_d5] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_10 : sharpMat (WCP2 + 1) 1 0 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p10, sharpQF_WI_p01, sharpQF_WI_d1, sharpQF_WI_d0] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_11 : sharpMat (WCP2 + 1) 1 1 = 1 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_d1] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_12 : sharpMat (WCP2 + 1) 1 2 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p12, sharpQF_WI_d1, sharpQF_WI_d2] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_13 : sharpMat (WCP2 + 1) 1 3 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p13, sharpQF_WI_d1, sharpQF_WI_d3] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_14 : sharpMat (WCP2 + 1) 1 4 = 1 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p14, sharpQF_WI_d1, sharpQF_WI_d4] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_15 : sharpMat (WCP2 + 1) 1 5 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p15, sharpQF_WI_d1, sharpQF_WI_d5] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_20 : sharpMat (WCP2 + 1) 2 0 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p20, sharpQF_WI_p02, sharpQF_WI_d2, sharpQF_WI_d0] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_21 : sharpMat (WCP2 + 1) 2 1 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p21, sharpQF_WI_p12, sharpQF_WI_d2, sharpQF_WI_d1] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_22 : sharpMat (WCP2 + 1) 2 2 = 1 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_d2] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_23 : sharpMat (WCP2 + 1) 2 3 = -1 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p23, sharpQF_WI_d2, sharpQF_WI_d3] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_24 : sharpMat (WCP2 + 1) 2 4 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p24, sharpQF_WI_d2, sharpQF_WI_d4] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_25 : sharpMat (WCP2 + 1) 2 5 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p25, sharpQF_WI_d2, sharpQF_WI_d5] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_30 : sharpMat (WCP2 + 1) 3 0 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p30, sharpQF_WI_p03, sharpQF_WI_d3, sharpQF_WI_d0] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_31 : sharpMat (WCP2 + 1) 3 1 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p31, sharpQF_WI_p13, sharpQF_WI_d3, sharpQF_WI_d1] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_32 : sharpMat (WCP2 + 1) 3 2 = -1 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p32, sharpQF_WI_p23, sharpQF_WI_d3, sharpQF_WI_d2] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_33 : sharpMat (WCP2 + 1) 3 3 = 1 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_d3] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_34 : sharpMat (WCP2 + 1) 3 4 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p34, sharpQF_WI_d3, sharpQF_WI_d4] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_35 : sharpMat (WCP2 + 1) 3 5 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p35, sharpQF_WI_d3, sharpQF_WI_d5] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_40 : sharpMat (WCP2 + 1) 4 0 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p40, sharpQF_WI_p04, sharpQF_WI_d4, sharpQF_WI_d0] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_41 : sharpMat (WCP2 + 1) 4 1 = 1 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p41, sharpQF_WI_p14, sharpQF_WI_d4, sharpQF_WI_d1] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_42 : sharpMat (WCP2 + 1) 4 2 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p42, sharpQF_WI_p24, sharpQF_WI_d4, sharpQF_WI_d2] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_43 : sharpMat (WCP2 + 1) 4 3 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p43, sharpQF_WI_p34, sharpQF_WI_d4, sharpQF_WI_d3] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_44 : sharpMat (WCP2 + 1) 4 4 = 1 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_d4] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_45 : sharpMat (WCP2 + 1) 4 5 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p45, sharpQF_WI_d4, sharpQF_WI_d5] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_50 : sharpMat (WCP2 + 1) 5 0 = -1 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p50, sharpQF_WI_p05, sharpQF_WI_d5, sharpQF_WI_d0] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_51 : sharpMat (WCP2 + 1) 5 1 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p51, sharpQF_WI_p15, sharpQF_WI_d5, sharpQF_WI_d1] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_52 : sharpMat (WCP2 + 1) 5 2 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p52, sharpQF_WI_p25, sharpQF_WI_d5, sharpQF_WI_d2] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_53 : sharpMat (WCP2 + 1) 5 3 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p53, sharpQF_WI_p35, sharpQF_WI_d5, sharpQF_WI_d3] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_54 : sharpMat (WCP2 + 1) 5 4 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_p54, sharpQF_WI_p45, sharpQF_WI_d5, sharpQF_WI_d4] <;>
    (first | decide | norm_num)

theorem sharpMat_WI_55 : sharpMat (WCP2 + 1) 5 5 = 1 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_WI_d5] <;>
    (first | decide | norm_num)

/-! ## And the thirty-six entries of `sharpMat I`, which is `2 I` -/

theorem sharpMat_I_00 : sharpMat 1 0 0 = 2 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_d0] <;>
    (first | decide | norm_num)

theorem sharpMat_I_01 : sharpMat 1 0 1 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p01, sharpQF_I_d0, sharpQF_I_d1] <;>
    (first | decide | norm_num)

theorem sharpMat_I_02 : sharpMat 1 0 2 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p02, sharpQF_I_d0, sharpQF_I_d2] <;>
    (first | decide | norm_num)

theorem sharpMat_I_03 : sharpMat 1 0 3 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p03, sharpQF_I_d0, sharpQF_I_d3] <;>
    (first | decide | norm_num)

theorem sharpMat_I_04 : sharpMat 1 0 4 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p04, sharpQF_I_d0, sharpQF_I_d4] <;>
    (first | decide | norm_num)

theorem sharpMat_I_05 : sharpMat 1 0 5 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p05, sharpQF_I_d0, sharpQF_I_d5] <;>
    (first | decide | norm_num)

theorem sharpMat_I_10 : sharpMat 1 1 0 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p10, sharpQF_I_p01, sharpQF_I_d1, sharpQF_I_d0] <;>
    (first | decide | norm_num)

theorem sharpMat_I_11 : sharpMat 1 1 1 = 2 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_d1] <;>
    (first | decide | norm_num)

theorem sharpMat_I_12 : sharpMat 1 1 2 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p12, sharpQF_I_d1, sharpQF_I_d2] <;>
    (first | decide | norm_num)

theorem sharpMat_I_13 : sharpMat 1 1 3 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p13, sharpQF_I_d1, sharpQF_I_d3] <;>
    (first | decide | norm_num)

theorem sharpMat_I_14 : sharpMat 1 1 4 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p14, sharpQF_I_d1, sharpQF_I_d4] <;>
    (first | decide | norm_num)

theorem sharpMat_I_15 : sharpMat 1 1 5 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p15, sharpQF_I_d1, sharpQF_I_d5] <;>
    (first | decide | norm_num)

theorem sharpMat_I_20 : sharpMat 1 2 0 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p20, sharpQF_I_p02, sharpQF_I_d2, sharpQF_I_d0] <;>
    (first | decide | norm_num)

theorem sharpMat_I_21 : sharpMat 1 2 1 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p21, sharpQF_I_p12, sharpQF_I_d2, sharpQF_I_d1] <;>
    (first | decide | norm_num)

theorem sharpMat_I_22 : sharpMat 1 2 2 = 2 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_d2] <;>
    (first | decide | norm_num)

theorem sharpMat_I_23 : sharpMat 1 2 3 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p23, sharpQF_I_d2, sharpQF_I_d3] <;>
    (first | decide | norm_num)

theorem sharpMat_I_24 : sharpMat 1 2 4 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p24, sharpQF_I_d2, sharpQF_I_d4] <;>
    (first | decide | norm_num)

theorem sharpMat_I_25 : sharpMat 1 2 5 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p25, sharpQF_I_d2, sharpQF_I_d5] <;>
    (first | decide | norm_num)

theorem sharpMat_I_30 : sharpMat 1 3 0 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p30, sharpQF_I_p03, sharpQF_I_d3, sharpQF_I_d0] <;>
    (first | decide | norm_num)

theorem sharpMat_I_31 : sharpMat 1 3 1 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p31, sharpQF_I_p13, sharpQF_I_d3, sharpQF_I_d1] <;>
    (first | decide | norm_num)

theorem sharpMat_I_32 : sharpMat 1 3 2 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p32, sharpQF_I_p23, sharpQF_I_d3, sharpQF_I_d2] <;>
    (first | decide | norm_num)

theorem sharpMat_I_33 : sharpMat 1 3 3 = 2 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_d3] <;>
    (first | decide | norm_num)

theorem sharpMat_I_34 : sharpMat 1 3 4 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p34, sharpQF_I_d3, sharpQF_I_d4] <;>
    (first | decide | norm_num)

theorem sharpMat_I_35 : sharpMat 1 3 5 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p35, sharpQF_I_d3, sharpQF_I_d5] <;>
    (first | decide | norm_num)

theorem sharpMat_I_40 : sharpMat 1 4 0 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p40, sharpQF_I_p04, sharpQF_I_d4, sharpQF_I_d0] <;>
    (first | decide | norm_num)

theorem sharpMat_I_41 : sharpMat 1 4 1 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p41, sharpQF_I_p14, sharpQF_I_d4, sharpQF_I_d1] <;>
    (first | decide | norm_num)

theorem sharpMat_I_42 : sharpMat 1 4 2 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p42, sharpQF_I_p24, sharpQF_I_d4, sharpQF_I_d2] <;>
    (first | decide | norm_num)

theorem sharpMat_I_43 : sharpMat 1 4 3 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p43, sharpQF_I_p34, sharpQF_I_d4, sharpQF_I_d3] <;>
    (first | decide | norm_num)

theorem sharpMat_I_44 : sharpMat 1 4 4 = 2 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_d4] <;>
    (first | decide | norm_num)

theorem sharpMat_I_45 : sharpMat 1 4 5 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p45, sharpQF_I_d4, sharpQF_I_d5] <;>
    (first | decide | norm_num)

theorem sharpMat_I_50 : sharpMat 1 5 0 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p50, sharpQF_I_p05, sharpQF_I_d5, sharpQF_I_d0] <;>
    (first | decide | norm_num)

theorem sharpMat_I_51 : sharpMat 1 5 1 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p51, sharpQF_I_p15, sharpQF_I_d5, sharpQF_I_d1] <;>
    (first | decide | norm_num)

theorem sharpMat_I_52 : sharpMat 1 5 2 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p52, sharpQF_I_p25, sharpQF_I_d5, sharpQF_I_d2] <;>
    (first | decide | norm_num)

theorem sharpMat_I_53 : sharpMat 1 5 3 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p53, sharpQF_I_p35, sharpQF_I_d5, sharpQF_I_d3] <;>
    (first | decide | norm_num)

theorem sharpMat_I_54 : sharpMat 1 5 4 = 0 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_p54, sharpQF_I_p45, sharpQF_I_d5, sharpQF_I_d4] <;>
    (first | decide | norm_num)

theorem sharpMat_I_55 : sharpMat 1 5 5 = 2 := by
  simp only [sharpMat, Matrix.of_apply, Fin.isValue, Fin.reduceEq, reduceIte, sharpQF_I_d5] <;>
    (first | decide | norm_num)

/-! ## What this file does NOT close, and THREE structures that failed

**THE SEVENTY-TWO `sharpQF` VALUES AND THE SEVENTY-TWO `sharpMat` ENTRIES ABOVE ARE KERNEL-CHECKED.
THE ASSEMBLY `W # I = -W` IS NOT, AND IS NOT WORTH MORE MACHINE TIME.**

*Three structurally different attempts, each measured*: unfolding `sharpBilin` in one goal reached
**2.4 GB**; closing each `sharpMat` MATRIX in its own declaration reached **6 GB in seventy
seconds**; and substituting the seventy-two ENTRY facts, with no `sharpQF` left anywhere in the
goal, reached **6.4 GB in three minutes** and was still climbing. **All three were killed.**

**THE PER-DECLARATION SPLIT THAT RETIRED EVERY OTHER `native_decide` IN THIS LAYER DOES NOT CURE
THIS ONE.** *Heartbeat exhaustion is cured by more declarations; MEMORY growth is not, and splitting
finer moved the cost without bounding it.* The remaining suspect is the `ext`/`fin_cases` shape
itself over `Fin 6 × Fin 6` with a large `simp only` set, which is the one thing all three share.

**PHASE 1'S SPLIT, 2026-09-23: THE THIRD MATRIX NEEDS NO `sharpQF` AT ALL, AND EVERY KILLED
ATTEMPT STILL CARRIED IT.**

*The assembly is `sharpBilin WCP2 1 = ½ • (sharpMat (WCP2 + 1) - sharpMat WCP2 - sharpMat 1)`, so
it needs THREE matrices.* **The seventy-two entries proved above are two of them**, thirty-six for
`sharpMat (WCP2 + 1)` and thirty-six for `sharpMat 1`. *`sharpMat WCP2` is the third, it is not
among them, and unfolding it is what every one of the three killed attempts was still doing.*

**It does not have to be unfolded.** `WCP2_critical'` in [CP2Sharp.lean](CP2Sharp.lean) is
kernel-checked and says `Qop WCP2 = 3 • WCP2`, and `Qop R = R * R + sharpMat R` by definition, so

`sharpMat WCP2 = 3 • WCP2 - WCP2 * WCP2`

is a matrix product of rational literals. **This file ALREADY IMPORTS `CP2Sharp` and never cites
that theorem.** Substituting it turns the goal into

`sharpMat (WCP2 + 1) - sharpMat 1 + WCP2 * WCP2 = WCP2`

in which no `sharpQF` and no `sharpMat` unfolding appears anywhere: the first two terms are the
seventy-two literals above and the third is one product of literals.

**WHY THIS IS NOT THE SPLIT THAT ALREADY FAILED.** *The per-declaration split divides the SAME
computation into more goals, and the measurements above show memory growth is not cured that way.
This removes a computation instead, by citing a theorem that already exists.* **What it does not
settle is whether the remaining `ext` over `Fin 6 × Fin 6` is itself the cost**, which the passage
above names as the common factor of all three failures and which this route still performs. *So it
is recorded as the next round's phase 2 and as a run that must be MEMORY-CAPPED on the child
process, not as a route known to work.*

**AND PHASE 2 TAKES THE PER-ENTRY SHAPE, NOT THE ONE-DECLARATION ONE** ([r1085](../../../reviews/REVIEW_r1085.md)).
*The single-goal form matches seventy-two value lemmas over thirty-six `fin_cases` branches, where
the measured 6 GB failure matched fifty-one; the per-entry form is the shape this file already
measures at seconds and flat memory.* **So the saving is PLAUSIBLE rather than established, and
the shape is the thing to get right before the run.**

**AND THE PRIZE IS ONE DECLARATION** ([r1031](../../../reviews/REVIEW_r1031.md)): *exactly one
tainted `Base` declaration involves `WCP2_sharp_one`.* **THE ALTERNATIVE TARGET NAMED HERE IS
ALREADY HIT, 2026-09-22.** *This passage sent a reader to `WCP2_bianchiOf` and `W33_bianchiOf` as
twenty-six declarations blocked on a total-antisymmetry lemma. Both are TERM PROOFS in
[L34c.lean](../Results/L34c.lean) through `bianchiOf_eq_zero_of_base`, and the lemma is built in
[AltAntisym.lean](AltAntisym.lean).* **The assembly is DONE, 2026-09-23**: [WCP2Sharp1.lean](WCP2Sharp1.lean)'s `WCP2_sharp_one`
consumes these entries one theorem per entry, and the tree carries no `native_decide`. -/

end HamiltonsCubic.Base
