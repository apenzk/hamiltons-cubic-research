import HamiltonsCubic.Base.StructureConstants

/-!
# The root slots of `-ad_X²`: the block-pair eigenvectors

[L237](../../../findings/second-order.md) needs the spectrum of `-ad_X²` on bivectors for `X` in
normal form, `X = Σ_a s_a φ_{p_a q_a}`. On a pair of blocks `X = s φ_pq + t φ_uv` the four mixed
bivectors split into two eigenvalues:

* `φ_pu - φ_qv` and `φ_pv + φ_qu`, eigenvalue `(s + t)²` (`slot_plus`, `slot_plus2`);
* `φ_pu + φ_qv` and `φ_pv - φ_qu`, eigenvalue `(s - t)²` (`slot_minus`, `slot_minus2`).

Each is proved from the bracket table `br_phi_phi` by bilinearity.

**Kernel and null slots**: `φ_pw` for `w` outside both blocks has eigenvalue `s²` (`slot_kernel`),
and `φ_pq`, `φ_uv` are null (`slot_null1`, `slot_null2`).

**Owed for L237 end to end**:
the passage from two blocks to a general normal form, completeness and orthonormality of the whole
slot basis, and `kyFan_eigen` applied to it.
-/

open HamiltonsCubic.RealLayer Matrix

namespace HamiltonsCubic.RootSlots

set_option linter.unusedSectionVars false

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem brL_add (A B C : Matrix ι ι ℝ) : br (A + B) C = br A C + br B C := by
  simp only [br, Matrix.add_mul, Matrix.mul_add]; abel
theorem brR_add (A B C : Matrix ι ι ℝ) : br A (B + C) = br A B + br A C := by
  simp only [br, Matrix.add_mul, Matrix.mul_add]; abel
theorem brR_sub (A B C : Matrix ι ι ℝ) : br A (B - C) = br A B - br A C := by
  simp only [br, Matrix.sub_mul, Matrix.mul_sub]; abel
theorem brL_smul (c : ℝ) (A B : Matrix ι ι ℝ) : br (c • A) B = c • br A B := by
  simp only [br, Matrix.smul_mul, Matrix.mul_smul, smul_sub]
theorem brR_smul (c : ℝ) (A B : Matrix ι ι ℝ) : br A (c • B) = c • br A B := by
  simp only [br, Matrix.smul_mul, Matrix.mul_smul, smul_sub]
theorem brR_neg (A B : Matrix ι ι ℝ) : br A (-B) = -br A B := by
  simp only [br, Matrix.neg_mul, Matrix.mul_neg]; abel

theorem slot_plus {p q u v : ι} (hpq : p ≠ q) (hpu : p ≠ u) (hpv : p ≠ v) (hqu : q ≠ u)
    (hqv : q ≠ v) (huv : u ≠ v) (s t : ℝ) :
    -br (s • phi p q + t • phi u v) (br (s • phi p q + t • phi u v) (phi p u - phi q v)) =
      (s + t) ^ 2 • (phi p u - phi q v) := by
  simp only [brL_add, brR_add, brR_sub, brL_smul, brR_smul, brR_neg, br_phi_phi, hpq, hpu, hpv,
    hqu, hqv, huv, Ne.symm hpq, Ne.symm hpu, Ne.symm hpv, Ne.symm hqu, Ne.symm hqv, Ne.symm huv,
    if_true, if_false, zero_smul, one_smul, add_zero, zero_add, sub_zero, zero_sub, smul_zero,
    smul_neg, smul_add, smul_sub, phi_self]
  simp only [smul_smul, smul_neg, neg_neg, sub_neg_eq_add, neg_add, neg_sub]
  rw [phi_swap v q, phi_swap p u]
  module

theorem slot_plus2 {p q u v : ι} (hpq : p ≠ q) (hpu : p ≠ u) (hpv : p ≠ v) (hqu : q ≠ u)
    (hqv : q ≠ v) (huv : u ≠ v) (s t : ℝ) :
    -br (s • phi p q + t • phi u v) (br (s • phi p q + t • phi u v) (phi p v + phi q u)) =
      (s + t) ^ 2 • (phi p v + phi q u) := by
  simp only [brL_add, brR_add, brR_sub, brL_smul, brR_smul, brR_neg, br_phi_phi, hpq, hpu, hpv,
    hqu, hqv, huv, Ne.symm hpq, Ne.symm hpu, Ne.symm hpv, Ne.symm hqu, Ne.symm hqv, Ne.symm huv,
    if_true, if_false, zero_smul, one_smul, add_zero, zero_add, sub_zero, zero_sub, smul_zero,
    smul_neg, smul_add, smul_sub, phi_self]
  simp only [smul_smul, smul_neg, neg_neg, sub_neg_eq_add, neg_add, neg_sub]
  first
    | module
    | (rw [phi_swap v q, phi_swap p u]; module)
    | (rw [phi_swap u q, phi_swap p v]; module)
    | (rw [phi_swap q v, phi_swap u p]; module)
    | (rw [phi_swap q u, phi_swap v p]; module)
    | (rw [phi_swap v q]; module)
    | (rw [phi_swap u q]; module)
    | (rw [phi_swap p u]; module)
    | (rw [phi_swap p v]; module)

theorem slot_minus {p q u v : ι} (hpq : p ≠ q) (hpu : p ≠ u) (hpv : p ≠ v) (hqu : q ≠ u)
    (hqv : q ≠ v) (huv : u ≠ v) (s t : ℝ) :
    -br (s • phi p q + t • phi u v) (br (s • phi p q + t • phi u v) (phi p u + phi q v)) =
      (s - t) ^ 2 • (phi p u + phi q v) := by
  simp only [brL_add, brR_add, brR_sub, brL_smul, brR_smul, brR_neg, br_phi_phi, hpq, hpu, hpv,
    hqu, hqv, huv, Ne.symm hpq, Ne.symm hpu, Ne.symm hpv, Ne.symm hqu, Ne.symm hqv, Ne.symm huv,
    if_true, if_false, zero_smul, one_smul, add_zero, zero_add, sub_zero, zero_sub, smul_zero,
    smul_neg, smul_add, smul_sub, phi_self]
  simp only [smul_smul, smul_neg, neg_neg, sub_neg_eq_add, neg_add, neg_sub]
  first
    | module
    | (rw [phi_swap v q, phi_swap p u]; module)
    | (rw [phi_swap u q, phi_swap p v]; module)
    | (rw [phi_swap q v, phi_swap u p]; module)
    | (rw [phi_swap q u, phi_swap v p]; module)
    | (rw [phi_swap v q]; module)
    | (rw [phi_swap u q]; module)
    | (rw [phi_swap p u]; module)
    | (rw [phi_swap p v]; module)

theorem slot_minus2 {p q u v : ι} (hpq : p ≠ q) (hpu : p ≠ u) (hpv : p ≠ v) (hqu : q ≠ u)
    (hqv : q ≠ v) (huv : u ≠ v) (s t : ℝ) :
    -br (s • phi p q + t • phi u v) (br (s • phi p q + t • phi u v) (phi p v - phi q u)) =
      (s - t) ^ 2 • (phi p v - phi q u) := by
  simp only [brL_add, brR_add, brR_sub, brL_smul, brR_smul, brR_neg, br_phi_phi, hpq, hpu, hpv,
    hqu, hqv, huv, Ne.symm hpq, Ne.symm hpu, Ne.symm hpv, Ne.symm hqu, Ne.symm hqv, Ne.symm huv,
    if_true, if_false, zero_smul, one_smul, add_zero, zero_add, sub_zero, zero_sub, smul_zero,
    smul_neg, smul_add, smul_sub, phi_self]
  simp only [smul_smul, smul_neg, neg_neg, sub_neg_eq_add, neg_add, neg_sub]
  first
    | module
    | (rw [phi_swap v q, phi_swap p u]; module)
    | (rw [phi_swap u q, phi_swap p v]; module)
    | (rw [phi_swap q v, phi_swap u p]; module)
    | (rw [phi_swap q u, phi_swap v p]; module)
    | (rw [phi_swap v q]; module)
    | (rw [phi_swap u q]; module)
    | (rw [phi_swap p u]; module)
    | (rw [phi_swap p v]; module)

theorem slot_kernel {p q u v : ι} (hpq : p ≠ q) (hpu : p ≠ u) (hpv : p ≠ v) (hqu : q ≠ u)
    (hqv : q ≠ v) (huv : u ≠ v) {w : ι} (hwp : w ≠ p) (hwq : w ≠ q) (hwu : w ≠ u) (hwv : w ≠ v) (s t : ℝ) :
    -br (s • phi p q + t • phi u v) (br (s • phi p q + t • phi u v) (phi p w)) =
      s ^ 2 • (phi p w) := by
  simp only [brL_add, brR_add, brR_sub, brL_smul, brR_smul, brR_neg, br_phi_phi, hpq, hpu, hpv,
    hqu, hqv, huv, Ne.symm hpq, Ne.symm hpu, Ne.symm hpv, Ne.symm hqu, Ne.symm hqv, Ne.symm huv,
    hwp, hwq, hwu, hwv, Ne.symm hwp, Ne.symm hwq, Ne.symm hwu, Ne.symm hwv, if_true, if_false, zero_smul, one_smul, add_zero, zero_add, sub_zero, zero_sub, smul_zero,
    smul_neg, smul_add, smul_sub, phi_self]
  simp only [smul_smul, smul_neg, neg_neg, sub_neg_eq_add, neg_add, neg_sub]
  first
    | module
    | (rw [phi_swap w q]; module)
    | (rw [phi_swap w p]; module)
    | (rw [phi_swap q p]; module)
    | (rw [phi_swap v u]; module)

theorem slot_null1 {p q u v : ι} (hpq : p ≠ q) (hpu : p ≠ u) (hpv : p ≠ v) (hqu : q ≠ u)
    (hqv : q ≠ v) (huv : u ≠ v) (s t : ℝ) :
    -br (s • phi p q + t • phi u v) (br (s • phi p q + t • phi u v) (phi p q)) =
      (0 : ℝ) • (phi p q) := by
  have h0 : br (s • phi p q + t • phi u v) (phi p q) = 0 := by
    rw [brL_add, brL_smul, brL_smul,
      show br (phi p q) (phi p q) = 0 by simp [br],
      br_phi_disjoint u v p q (Ne.symm hpu) (Ne.symm hqu) (Ne.symm hpv) (Ne.symm hqv)]
    simp
  rw [h0]; simp [br]

theorem slot_null2 {p q u v : ι} (hpq : p ≠ q) (hpu : p ≠ u) (hpv : p ≠ v) (hqu : q ≠ u)
    (hqv : q ≠ v) (huv : u ≠ v) (s t : ℝ) :
    -br (s • phi p q + t • phi u v) (br (s • phi p q + t • phi u v) (phi u v)) =
      (0 : ℝ) • (phi u v) := by
  have h0 : br (s • phi p q + t • phi u v) (phi u v) = 0 := by
    rw [brL_add, brL_smul, brL_smul,
      show br (phi u v) (phi u v) = 0 by simp [br],
      br_phi_disjoint p q u v hpu hpv hqu hqv]
    simp
  rw [h0]; simp [br]

end HamiltonsCubic.RootSlots
