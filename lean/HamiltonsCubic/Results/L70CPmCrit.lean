import HamiltonsCubic.Results.L70CPm
import HamiltonsCubic.Results.L209BianchiHalf

set_option linter.style.longLine false

/-!
# `W_{ℂPᵐ}` is critical, `Q(W) = (2m + 2) W`

[L70CPm.lean](L70CPm.lean) proves `W_{ℂPᵐ}` cannot saturate L70 at any critical value. This file proves it is
critical, so the clause holds unconditionally.

- `R4W` and `B4W`: at fixed `(i, k)` the tensor `W_{ipkq}` is the matrix `MW i k` built from `1`, `J`, a single
  entry and outer products of rows of `J`, so `B_{ijkl} = ∑ W_{ipkq} W_{jplq}` is a Frobenius pairing, and the
  `frob_*` lemmas evaluate every pairing of those pieces;
- `WCPm_sq`: `W² = (cA² + 1) Id + 2cA·conj + (2cA + 2 + 2m)(∑ J_{ij} X_{ij}) J` at the operator level;
- **`R4_Qop_WCPm`**: `R4(Q(W)) = (2m + 2) R4(W)`, from `R² + R#` with `R#_{ij,kl} = B_{ijkl} − B_{ijlk}`
  ([L209BianchiHalf.lean](L209BianchiHalf.lean)'s `sharpBil_phi_B`);
- **`WCPm_critical`**: `IsCritical W_{ℂPᵐ} (2m + 2)`, and **`WCPm_critical_not_saturated`**: at `m ≥ 3`,
  `2m + 2 ≠ λ_min + (n − 2) λ_max`.
-/

namespace HamiltonsCubic.L70CPm

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.Results HamiltonsCubic.SecondKind

variable {m : ℕ}

local notation "M" => Matrix (Fin (2 * m)) (Fin (2 * m)) ℝ

/-- Row `a` of `J`. -/
def rowJ (a : Fin (2 * m)) : Fin (2 * m) → ℝ := fun q => Jm a q

theorem dot_rowJ (a b : Fin (2 * m)) : ∑ p, rowJ a p * rowJ b p = if a = b then 1 else 0 := by
  have h := congrFun (congrFun (Jm_mul_transpose (m := m)) a) b
  simpa [Matrix.mul_apply, transpose_apply, Matrix.one_apply, rowJ] using h

theorem frob_comm (A B : M) : frob A B = frob B A := by
  unfold frob; exact Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => mul_comm _ _

theorem frob_add_l (A B C : M) : frob (A + B) C = frob A C + frob B C := by
  rw [frob_comm, frob_add, frob_comm C, frob_comm C]

theorem frob_smul_l (A B : M) (c : ℝ) : frob (c • A) B = c * frob A B := by
  rw [frob_comm, frob_smul, frob_comm]

theorem frob_sub_l (A B C : M) : frob (A - B) C = frob A C - frob B C := by
  unfold frob; simp [sub_mul, Finset.sum_sub_distrib]

theorem frob_sub_r (A B C : M) : frob A (B - C) = frob A B - frob A C := by
  unfold frob; simp [mul_sub, Finset.sum_sub_distrib]

theorem frob_one_one : frob (1 : M) 1 = 2 * m := by
  unfold frob; simp [Matrix.one_apply]

theorem frob_one_J : frob (1 : M) Jm = 0 := by
  unfold frob; simp [Matrix.one_apply, Jm_diag]

theorem frob_one_single (a b : Fin (2 * m)) : frob (1 : M) (Matrix.single a b 1) = if a = b then 1 else 0 := by
  unfold frob
  simp only [Matrix.one_apply, Matrix.single_apply, ite_and, mul_ite, mul_one, mul_zero, ite_mul, one_mul, zero_mul]
  simp [Finset.sum_ite_eq, Finset.sum_ite_eq']

theorem frob_J_single (a b : Fin (2 * m)) : frob (Jm : M) (Matrix.single a b 1) = Jm a b := by
  unfold frob
  simp only [Matrix.single_apply, ite_and, mul_ite, mul_one, mul_zero]
  simp [Finset.sum_ite_eq, Finset.sum_ite_eq']

theorem frob_single_single (a b c d : Fin (2 * m)) :
    frob (Matrix.single a b (1 : ℝ) : M) (Matrix.single c d 1) = (if a = c then 1 else 0) * (if b = d then 1 else 0) := by
  unfold frob
  simp only [Matrix.single_apply, ite_and, mul_ite, mul_one, mul_zero, ite_mul, one_mul, zero_mul]
  simp [Finset.sum_ite_eq, Finset.sum_ite_eq']
  by_cases h1 : a = c <;> by_cases h2 : b = d <;> simp [h1, h2]

theorem frob_one_vmv (u v : Fin (2 * m) → ℝ) : frob (1 : M) (Matrix.vecMulVec u v) = ∑ p, u p * v p := by
  unfold frob; simp [Matrix.one_apply, Matrix.vecMulVec_apply]

theorem frob_J_vmv (a b : Fin (2 * m)) : frob (Jm : M) (Matrix.vecMulVec (rowJ a) (rowJ b)) = Jm a b := by
  unfold frob
  simp only [Matrix.vecMulVec_apply, rowJ]
  have : ∀ p, ∑ q, Jm p q * (Jm a p * Jm b q) = Jm a p * (if p = b then 1 else 0) := by
    intro p
    have := dot_rowJ (m := m) p b
    simp only [rowJ] at this
    rw [← this, Finset.mul_sum]
    exact Finset.sum_congr rfl fun _ _ => by ring
  simp [this]

theorem frob_single_vmv (a b : Fin (2 * m)) (u v : Fin (2 * m) → ℝ) :
    frob (Matrix.single a b (1 : ℝ) : M) (Matrix.vecMulVec u v) = u a * v b := by
  unfold frob
  simp only [Matrix.single_apply, Matrix.vecMulVec_apply, ite_and, ite_mul, one_mul, zero_mul]
  simp [Finset.sum_ite_eq, Finset.sum_ite_eq']

theorem frob_vmv_vmv (u v x y : Fin (2 * m) → ℝ) :
    frob (Matrix.vecMulVec u v : M) (Matrix.vecMulVec x y) = (∑ p, u p * x p) * (∑ q, v q * y q) := by
  unfold frob; simp only [Matrix.vecMulVec_apply, Finset.sum_mul_sum]
  exact Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => by ring

theorem frob_J_one : frob (Jm : M) 1 = 0 := by rw [frob_comm, frob_one_J]
theorem frob_single_one (a b : Fin (2 * m)) : frob (Matrix.single a b (1 : ℝ) : M) 1 = if a = b then 1 else 0 := by
  rw [frob_comm, frob_one_single]
theorem frob_single_J (a b : Fin (2 * m)) : frob (Matrix.single a b (1 : ℝ) : M) Jm = Jm a b := by
  rw [frob_comm, frob_J_single]
theorem frob_vmv_one (u v : Fin (2 * m) → ℝ) : frob (Matrix.vecMulVec u v : M) 1 = ∑ p, u p * v p := by
  rw [frob_comm, frob_one_vmv]
theorem frob_vmv_J (a b : Fin (2 * m)) : frob (Matrix.vecMulVec (rowJ a) (rowJ b) : M) Jm = Jm a b := by
  rw [frob_comm, frob_J_vmv]
theorem frob_vmv_single (a b : Fin (2 * m)) (u v : Fin (2 * m) → ℝ) :
    frob (Matrix.vecMulVec u v : M) (Matrix.single a b 1) = u a * v b := by
  rw [frob_comm, frob_single_vmv]

/-- The `(p, q)` matrix of `W_{ipkq}` at fixed `(i, k)`, three pieces. -/
noncomputable def MD (i k : Fin (2 * m)) : M := (if i = k then (1 : ℝ) else 0) • (1 : M) - Matrix.single k i 1
noncomputable def MC (i k : Fin (2 * m)) : M := Jm i k • Jm + Matrix.vecMulVec (rowJ k) (rowJ i)
noncomputable def MP (i k : Fin (2 * m)) : M := (2 : ℝ) • Matrix.vecMulVec (rowJ i) (rowJ k)
noncomputable def MW (i k : Fin (2 * m)) : M := cA m • MD i k + MC i k + MP i k

theorem R4W (i p k q : Fin (2 * m)) : R4 (WCPm (m := m)) i p k q = MW i k p q := by
  rw [R4, WCPm_R4, WCPm_phi_apply, phi_apply]
  simp only [MW, MD, MC, MP, Matrix.add_apply, Matrix.smul_apply, Matrix.sub_apply, Matrix.one_apply,
    Matrix.single_apply, Matrix.vecMulVec_apply, rowJ, smul_eq_mul]
  rw [Jm_skew_apply i q, Jm_skew_apply i k, Jm_skew_apply p q]
  simp only [ite_and]
  split_ifs <;> subst_vars <;> simp_all [Jm_diag] <;> ring

theorem B4W (i j k l : Fin (2 * m)) : B4 (WCPm (m := m)) i j k l = frob (MW i k) (MW j l) := by
  unfold B4 frob; simp only [R4W]

theorem conj_add (Y Z : M) : conj (Y + Z) = conj Y + conj Z := by
  unfold conj; simp [Matrix.mul_add, Matrix.add_mul]

theorem conj_smul (s : ℝ) (Y : M) : conj (s • Y) = s • conj Y := by
  unfold conj; simp

theorem frob_J_conj (X : M) : frob Jm (conj X) = frob Jm X := by
  rw [frob_comm, frob_conj, conj_J, frob_comm]

/-- **`W²`** at the operator level. -/
theorem WCPm_sq (X : M) :
    WCPm (WCPm X) = (cA m ^ 2 + 1) • X + (2 * cA m) • conj X + ((2 * cA m + 2 + 2 * m) * frob Jm X) • Jm := by
  have hW : ∀ Y : M, WCPm Y = cA m • Y + conj Y + frob Jm Y • Jm := fun Y => rfl
  rw [hW (WCPm X), hW X, conj_add, conj_add, conj_smul, conj_smul, conj_conj, conj_J, frob_add, frob_add,
    frob_smul, frob_smul, frob_J_conj, frob_J_J]
  ext a b
  simp only [Matrix.add_apply, Matrix.smul_apply, smul_eq_mul]
  ring

theorem ite_and_one (P Q : Prop) [Decidable P] [Decidable Q] :
    (if P ∧ Q then (1 : ℝ) else 0) = (if P then 1 else 0) * (if Q then 1 else 0) := by
  by_cases hP : P <;> by_cases hQ : Q <;> simp [hP, hQ]

/-- **`Q(W_{ℂPᵐ}) = (2m + 2) W_{ℂPᵐ}`, tensor by tensor.** -/
theorem R4_Qop_WCPm (hm : 1 ≤ m) (i j k l : Fin (2 * m)) :
    R4 (Qop (WCPm (m := m))) i j k l = (2 * m + 2) * R4 (WCPm (m := m)) i j k l := by
  have hW := WCPm_isWeylOp (m := m) hm
  have hsh : R4 (sharpOp (WCPm (m := m))) i j k l = B4 WCPm i j k l - B4 WCPm i j l k := by
    rw [R4_sharpOp _ hW.1, sharpBil_phi_B _ hW.1 hW.2.1 hW.2.2.1]
  have hcomp : R4 (compOp (WCPm (m := m))) i j k l = -(WCPm (WCPm (phi i j))) k l := by
    unfold R4 compOp; exact inner2_phi _ (WCPm_skew _ (WCPm_skew _ (phi_isSkew i j))) k l
  have hsplit : R4 (Qop (WCPm (m := m))) i j k l
      = R4 (compOp (WCPm (m := m))) i j k l + R4 (sharpOp (WCPm (m := m))) i j k l := by
    unfold R4 Qop; exact FamilyLayer.inner2_add_left _ _ _
  rw [hsplit, hcomp, hsh, B4W, B4W, WCPm_sq, R4W]
  unfold MW MD MC MP
  simp only [frob_add_l, frob_add, frob_smul_l, frob_smul, frob_sub_l, frob_sub_r, frob_one_one, frob_one_J,
    frob_J_one, frob_J_J, frob_one_single, frob_single_one, frob_J_single, frob_single_J, frob_single_single,
    frob_one_vmv, frob_vmv_one, frob_J_vmv, frob_vmv_J, frob_single_vmv, frob_vmv_single, frob_vmv_vmv, dot_rowJ]
  simp only [Matrix.add_apply, Matrix.smul_apply, Matrix.sub_apply, Matrix.one_apply, Matrix.single_apply,
    Matrix.vecMulVec_apply, smul_eq_mul, conj_phi_apply, frob_phi, phi_apply, rowJ, ite_and_one]
  simp only [Jm_skew_apply i j, Jm_skew_apply i k, Jm_skew_apply i l, Jm_skew_apply j k, Jm_skew_apply j l,
    Jm_skew_apply k l, @eq_comm _ k i, @eq_comm _ l i, @eq_comm _ l j, @eq_comm _ k j, @eq_comm _ l k, @eq_comm _ j i]
  have h2m : (2 * (m : ℝ) - 1) ≠ 0 := by
    have : (1 : ℝ) ≤ m := by exact_mod_cast hm
    linarith
  simp only [cA]
  field_simp
  ring_nf

/-- **`W_{ℂPᵐ}` IS CRITICAL**, with multiplier `2m + 2`: `Q(W) φ = (2m + 2) W φ` on every basis bivector. -/
theorem WCPm_critical (hm : 1 ≤ m) : IsCritical (WCPm (m := m)) (2 * m + 2) := by
  intro i j
  have hW := WCPm_isWeylOp (m := m) hm
  have hQ := HamiltonsCubic.Results.Qop_isWeylOp _ hW
  ext k l
  have e1 : R4 (Qop (WCPm (m := m))) i j k l = -(Qop (WCPm (m := m)) (phi i j)) k l :=
    inner2_phi _ (hQ.2.1 _ (phi_isSkew i j)) k l
  have e2 : R4 (WCPm (m := m)) i j k l = -(WCPm (phi i j)) k l := WCPm_R4 i j k l
  have h := R4_Qop_WCPm hm i j k l
  rw [e1, e2] at h
  simp only [Matrix.smul_apply, smul_eq_mul]
  linarith

/-- **L70'S `ℂPᵐ` CLAUSE, UNCONDITIONALLY**: at `m ≥ 3`, `W_{ℂPᵐ}` is critical and does not saturate. -/
theorem WCPm_critical_not_saturated (hm : 3 ≤ m) (γ₀ : Pairs (2 * m)) (lmin lmax : ℝ)
    (hγ : (Mpair_isHermitian (WCPm (m := m)) (WCPm_isWeylOp (by omega)).1 (WCPm_isWeylOp (by omega)).2.1
      (WCPm_isWeylOp (by omega)).2.2.1).eigenvalues γ₀ = lmin) (hneg : lmin < 0) (hpos : 0 < lmax)
    (hlo : ∀ j, lmin ≤ (Mpair_isHermitian (WCPm (m := m)) (WCPm_isWeylOp (by omega)).1 (WCPm_isWeylOp (by omega)).2.1
      (WCPm_isWeylOp (by omega)).2.2.1).eigenvalues j)
    (hhi : ∀ j, (Mpair_isHermitian (WCPm (m := m)) (WCPm_isWeylOp (by omega)).1 (WCPm_isWeylOp (by omega)).2.1
      (WCPm_isWeylOp (by omega)).2.2.1).eigenvalues j ≤ lmax) :
    (2 * m + 2 : ℝ) ≠ lmin + (((2 * m : ℕ) : ℝ) - 2) * lmax :=
  WCPm_not_saturated hm _ (WCPm_critical (by omega)) γ₀ lmin lmax hγ hneg hpos hlo hhi

end HamiltonsCubic.L70CPm
