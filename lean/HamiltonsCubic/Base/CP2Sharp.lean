import HamiltonsCubic.Base.CP2

/-!
# `Q(W) = 3W` at the competitor, in the kernel

**THE MONOLITH TIMED OUT AND THE PIECES DO NOT, FOR ONE REASON: HEARTBEATS ARE COUNTED PER
DECLARATION.** *A single theorem carrying twenty-one nested `Λ²` bracket evaluations exhausts forty
million where twenty-one theorems carrying one apiece each finish inside the default budget.* The
same split is what retired `sharpQF_one_basis` in [Sharp.lean](Sharp.lean).

**WHAT `sharpMat` ACTUALLY NEEDS.** Its diagonal is `sharpQF` at the six basis bivectors and its
off-diagonal is the polarisation of `sharpQF` at the fifteen pairwise sums, so the whole `6 × 6`
matrix is twenty-one rational numbers and no more. *Each is stated below and checked by `norm_num`,
so a wrong value fails to elaborate rather than being believed.*
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

/-! ## The six diagonal evaluations -/

set_option maxHeartbeats 4000000 in
theorem sharpQF_WCP2_d0 : sharpQF WCP2 (Pi.single 0 1) = 1 := by
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
theorem sharpQF_WCP2_d1 : sharpQF WCP2 (Pi.single 1 1) = -2 := by
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
theorem sharpQF_WCP2_d2 : sharpQF WCP2 (Pi.single 2 1) = -2 := by
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
theorem sharpQF_WCP2_d3 : sharpQF WCP2 (Pi.single 3 1) = -2 := by
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
theorem sharpQF_WCP2_d4 : sharpQF WCP2 (Pi.single 4 1) = -2 := by
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
theorem sharpQF_WCP2_d5 : sharpQF WCP2 (Pi.single 5 1) = 1 := by
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

/-! ## The fifteen pairwise evaluations, which the polarisation needs -/

set_option maxHeartbeats 4000000 in
theorem sharpQF_WCP2_p01 :
    sharpQF WCP2 (Pi.single 0 1 + Pi.single 1 1) = -1 := by
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
theorem sharpQF_WCP2_p02 :
    sharpQF WCP2 (Pi.single 0 1 + Pi.single 2 1) = -1 := by
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
theorem sharpQF_WCP2_p03 :
    sharpQF WCP2 (Pi.single 0 1 + Pi.single 3 1) = -1 := by
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
theorem sharpQF_WCP2_p04 :
    sharpQF WCP2 (Pi.single 0 1 + Pi.single 4 1) = -1 := by
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
theorem sharpQF_WCP2_p05 :
    sharpQF WCP2 (Pi.single 0 1 + Pi.single 5 1) = 4 := by
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
theorem sharpQF_WCP2_p12 :
    sharpQF WCP2 (Pi.single 1 1 + Pi.single 2 1) = -4 := by
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
theorem sharpQF_WCP2_p13 :
    sharpQF WCP2 (Pi.single 1 1 + Pi.single 3 1) = -4 := by
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
theorem sharpQF_WCP2_p14 :
    sharpQF WCP2 (Pi.single 1 1 + Pi.single 4 1) = 0 := by
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
theorem sharpQF_WCP2_p15 :
    sharpQF WCP2 (Pi.single 1 1 + Pi.single 5 1) = -1 := by
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
theorem sharpQF_WCP2_p23 :
    sharpQF WCP2 (Pi.single 2 1 + Pi.single 3 1) = -8 := by
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
theorem sharpQF_WCP2_p24 :
    sharpQF WCP2 (Pi.single 2 1 + Pi.single 4 1) = -4 := by
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
theorem sharpQF_WCP2_p25 :
    sharpQF WCP2 (Pi.single 2 1 + Pi.single 5 1) = -1 := by
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
theorem sharpQF_WCP2_p34 :
    sharpQF WCP2 (Pi.single 3 1 + Pi.single 4 1) = -4 := by
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
theorem sharpQF_WCP2_p35 :
    sharpQF WCP2 (Pi.single 3 1 + Pi.single 5 1) = -1 := by
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
theorem sharpQF_WCP2_p45 :
    sharpQF WCP2 (Pi.single 4 1 + Pi.single 5 1) = -1 := by
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

/-! ## The transposed arguments -/

/-- The mirrored argument, which `sharpMat` meets at the transposed entry. -/
theorem sharpQF_WCP2_p10 :
    sharpQF WCP2 (Pi.single 1 1 + Pi.single 0 1) = sharpQF WCP2 (Pi.single 0 1 + Pi.single 1 1) := by
  rw [add_comm]

/-- The mirrored argument, which `sharpMat` meets at the transposed entry. -/
theorem sharpQF_WCP2_p20 :
    sharpQF WCP2 (Pi.single 2 1 + Pi.single 0 1) = sharpQF WCP2 (Pi.single 0 1 + Pi.single 2 1) := by
  rw [add_comm]

/-- The mirrored argument, which `sharpMat` meets at the transposed entry. -/
theorem sharpQF_WCP2_p30 :
    sharpQF WCP2 (Pi.single 3 1 + Pi.single 0 1) = sharpQF WCP2 (Pi.single 0 1 + Pi.single 3 1) := by
  rw [add_comm]

/-- The mirrored argument, which `sharpMat` meets at the transposed entry. -/
theorem sharpQF_WCP2_p40 :
    sharpQF WCP2 (Pi.single 4 1 + Pi.single 0 1) = sharpQF WCP2 (Pi.single 0 1 + Pi.single 4 1) := by
  rw [add_comm]

/-- The mirrored argument, which `sharpMat` meets at the transposed entry. -/
theorem sharpQF_WCP2_p50 :
    sharpQF WCP2 (Pi.single 5 1 + Pi.single 0 1) = sharpQF WCP2 (Pi.single 0 1 + Pi.single 5 1) := by
  rw [add_comm]

/-- The mirrored argument, which `sharpMat` meets at the transposed entry. -/
theorem sharpQF_WCP2_p21 :
    sharpQF WCP2 (Pi.single 2 1 + Pi.single 1 1) = sharpQF WCP2 (Pi.single 1 1 + Pi.single 2 1) := by
  rw [add_comm]

/-- The mirrored argument, which `sharpMat` meets at the transposed entry. -/
theorem sharpQF_WCP2_p31 :
    sharpQF WCP2 (Pi.single 3 1 + Pi.single 1 1) = sharpQF WCP2 (Pi.single 1 1 + Pi.single 3 1) := by
  rw [add_comm]

/-- The mirrored argument, which `sharpMat` meets at the transposed entry. -/
theorem sharpQF_WCP2_p41 :
    sharpQF WCP2 (Pi.single 4 1 + Pi.single 1 1) = sharpQF WCP2 (Pi.single 1 1 + Pi.single 4 1) := by
  rw [add_comm]

/-- The mirrored argument, which `sharpMat` meets at the transposed entry. -/
theorem sharpQF_WCP2_p51 :
    sharpQF WCP2 (Pi.single 5 1 + Pi.single 1 1) = sharpQF WCP2 (Pi.single 1 1 + Pi.single 5 1) := by
  rw [add_comm]

/-- The mirrored argument, which `sharpMat` meets at the transposed entry. -/
theorem sharpQF_WCP2_p32 :
    sharpQF WCP2 (Pi.single 3 1 + Pi.single 2 1) = sharpQF WCP2 (Pi.single 2 1 + Pi.single 3 1) := by
  rw [add_comm]

/-- The mirrored argument, which `sharpMat` meets at the transposed entry. -/
theorem sharpQF_WCP2_p42 :
    sharpQF WCP2 (Pi.single 4 1 + Pi.single 2 1) = sharpQF WCP2 (Pi.single 2 1 + Pi.single 4 1) := by
  rw [add_comm]

/-- The mirrored argument, which `sharpMat` meets at the transposed entry. -/
theorem sharpQF_WCP2_p52 :
    sharpQF WCP2 (Pi.single 5 1 + Pi.single 2 1) = sharpQF WCP2 (Pi.single 2 1 + Pi.single 5 1) := by
  rw [add_comm]

/-- The mirrored argument, which `sharpMat` meets at the transposed entry. -/
theorem sharpQF_WCP2_p43 :
    sharpQF WCP2 (Pi.single 4 1 + Pi.single 3 1) = sharpQF WCP2 (Pi.single 3 1 + Pi.single 4 1) := by
  rw [add_comm]

/-- The mirrored argument, which `sharpMat` meets at the transposed entry. -/
theorem sharpQF_WCP2_p53 :
    sharpQF WCP2 (Pi.single 5 1 + Pi.single 3 1) = sharpQF WCP2 (Pi.single 3 1 + Pi.single 5 1) := by
  rw [add_comm]

/-- The mirrored argument, which `sharpMat` meets at the transposed entry. -/
theorem sharpQF_WCP2_p54 :
    sharpQF WCP2 (Pi.single 5 1 + Pi.single 4 1) = sharpQF WCP2 (Pi.single 4 1 + Pi.single 5 1) := by
  rw [add_comm]

/-! ## The assembly -/

set_option maxHeartbeats 4000000 in
/-- **`Q(W_{ℂP²}) = 3 W_{ℂP²}`, KERNEL-CHECKED.** *This was `native_decide`, and it is the
criticality the whole `ℂP²` comparison turns on.*

**`fin_cases` LEAVES `⟨0, ⋯⟩` WHERE THE EVALUATIONS ABOVE SAY `0`.** *The two are definitionally
equal and syntactically different, so `simp only` matches neither, and the failure surfaces far
downstream as an unfolded matrix literal rather than as a missed rewrite.* `Fin.zero_eta`,
`Fin.mk_one` and the `Fin.reduceFinMk` simproc normalise the constructor form back to the literal,
and they must come FIRST in the reduction.

**`WCP2` IS DELIBERATELY NOT UNFOLDED IN THE FIRST PASS.** *The twenty-one evaluations above are
stated in terms of the NAME, so unfolding the literal first makes every one of them stop matching
and leaves the whole computation to `norm_num`, which is the monolith again.* The reduction
therefore runs in two stages: the `sharpQF` values go in while `WCP2` is still opaque, and only
then does `norm_num` see the entries. -/
theorem WCP2_critical' : Qop WCP2 = (3 : ℚ) • WCP2 := by
  ext a b
  fin_cases a <;> fin_cases b <;>
    simp only [Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk,
      Qop, sharpMat, Matrix.of_apply, Matrix.add_apply, Matrix.smul_apply,
      Fin.isValue, reduceIte,
      sharpQF_WCP2_d0, sharpQF_WCP2_d1, sharpQF_WCP2_d2, sharpQF_WCP2_d3, sharpQF_WCP2_d4,
      sharpQF_WCP2_d5, sharpQF_WCP2_p01, sharpQF_WCP2_p02, sharpQF_WCP2_p03, sharpQF_WCP2_p04,
      sharpQF_WCP2_p05, sharpQF_WCP2_p12, sharpQF_WCP2_p13, sharpQF_WCP2_p14, sharpQF_WCP2_p15,
      sharpQF_WCP2_p23, sharpQF_WCP2_p24, sharpQF_WCP2_p25, sharpQF_WCP2_p34, sharpQF_WCP2_p35,
      sharpQF_WCP2_p45, sharpQF_WCP2_p10, sharpQF_WCP2_p20, sharpQF_WCP2_p30, sharpQF_WCP2_p40,
      sharpQF_WCP2_p50, sharpQF_WCP2_p21, sharpQF_WCP2_p31, sharpQF_WCP2_p41, sharpQF_WCP2_p51,
      sharpQF_WCP2_p32, sharpQF_WCP2_p42, sharpQF_WCP2_p52, sharpQF_WCP2_p43, sharpQF_WCP2_p53,
      sharpQF_WCP2_p54] <;>
    norm_num [WCP2, Matrix.mul_apply, Fin.sum_univ_six, Matrix.cons_val_zero,
      Matrix.cons_val_one, Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four,
      cons_val_five, Matrix.head_cons, Matrix.vecHead, Matrix.vecTail, Matrix.cons_val_succ,
      Matrix.cons_val_fin_one, Matrix.empty_val', Matrix.head_fin_const] <;>
    simp only [Fin.isValue, reduceIte, Fin.reduceEq] <;>
    first | rfl | omega | decide | norm_num

end HamiltonsCubic.Base
