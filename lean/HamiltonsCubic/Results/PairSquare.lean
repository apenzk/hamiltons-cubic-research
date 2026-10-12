import Mathlib
import HamiltonsCubic.Results.DiagSquare
import HamiltonsCubic.Results.L219GenOps

set_option linter.style.longLine false

/-!
# L222 item 2: `ν_x ∘ ν_x = G_x`, through the 45° rotation of the `(j, k)`-plane

[findings/second-order.md](../../../findings/second-order.md), Lemma L222, item 2: *$\nu\circ\nu=G_x$, the diagonal tensor with
$K_{ja}=K_{ka}=x_a^2$, $K_{jk}=-\lVert x\rVert^2$, $K_{ab}=2x_ax_b$.* The rotation by $45^\circ$ in the $(j,k)$-plane carries
[DiagSquare.lean](DiagSquare.lean)'s $D^-_x$ onto $\nu_x$ and fixes $G_x$, and $Q$ commutes with it
([L219GenOps.lean](L219GenOps.lean)'s `Qop2_rotR`), so $\nu_x\circ\nu_x$ is $D^-_x\circ D^-_x=G_x$.

* `sandOp A B`, $X\mapsto AXB+BXA$ at symmetric $A,B$; `coordOp_rank_two`, $(pq^{\mathsf T}+qp^{\mathsf T})\odot X=D_pXD_q+D_qXD_p$;
  `rotR_sandOp`, a frame change conjugates the two factors;
* `Rot j k c s`, the rotation of the $(j,k)$-plane with $c^2+s^2=1$, orthogonal (`Rot_orth`); it fixes every diagonal
  matrix with equal entries at $j$ and $k$ (`Rot_diag_fix`) and at $c=s$ sends $\mathrm{diag}(e_j-e_k)$ to $S=E_{jk}+E_{kj}$;
* **`nuX`**, the record's $\nu_x$ as `sandOp S (diag x)`, with $\nu_x\varphi_{ja}=x_a\varphi_{ka}$; **`Q_nuX`**: $\nu_x\circ\nu_x=G_x$ at
  $\sum x=0$ off $\{j,k\}$.
-/

namespace HamiltonsCubic.PairSquare

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.I117S HamiltonsCubic.FrameOp2
  HamiltonsCubic.DiagSquare HamiltonsCubic.FrameLayer

variable {n : ℕ}

theorem sand_skew {A B X : Matrix (Fin n) (Fin n) ℝ} (hA : Aᵀ = A) (hB : Bᵀ = B) (hX : Xᵀ = -X) :
    (A * X * B + B * X * A)ᵀ = -(A * X * B + B * X * A) := by
  rw [transpose_add, transpose_mul, transpose_mul, transpose_mul, transpose_mul, hA, hB, hX]
  simp only [Matrix.mul_neg, Matrix.neg_mul, Matrix.mul_assoc]
  abel

/-- **The sandwich operator** `X ↦ A X B + B X A` on bivectors, at symmetric `A, B`. -/
noncomputable def sandOp (A B : Matrix (Fin n) (Fin n) ℝ) (hA : Aᵀ = A) (hB : Bᵀ = B) : CurvOp2 (Fin n) :=
  LinearMap.toContinuousLinearMap
    { toFun := fun X => ⟨A * (X : Matrix (Fin n) (Fin n) ℝ) * B + B * (X : Matrix (Fin n) (Fin n) ℝ) * A,
        sand_skew hA hB X.2⟩
      map_add' := fun X Y => Subtype.ext (by
        simp only [Submodule.coe_add, Matrix.mul_add, Matrix.add_mul]; abel)
      map_smul' := fun c X => Subtype.ext (by
        simp only [Submodule.coe_smul, Matrix.mul_smul, Matrix.smul_mul, smul_add, RingHom.id_apply]) }

theorem sandOp_coe (A B : Matrix (Fin n) (Fin n) ℝ) (hA : Aᵀ = A) (hB : Bᵀ = B) (X : skewSub (Fin n)) :
    ((sandOp A B hA hB X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)
      = A * (X : Matrix (Fin n) (Fin n) ℝ) * B + B * (X : Matrix (Fin n) (Fin n) ℝ) * A := rfl

theorem diag_T (p : Fin n → ℝ) : (diagonal p)ᵀ = diagonal p := diagonal_transpose p

theorem vv_sym (p q : Fin n → ℝ) : (vecMulVec p q + vecMulVec q p)ᵀ = vecMulVec p q + vecMulVec q p := by
  rw [transpose_add, transpose_vecMulVec, transpose_vecMulVec, add_comm]

/-- **A rank-two coordinate operator is a sandwich**: `(p qᵀ + q pᵀ) ⊙ X = D_p X D_q + D_q X D_p`. -/
theorem coordOp_rank_two (p q : Fin n → ℝ) :
    coordOp (vecMulVec p q + vecMulVec q p) = sandOp (diagonal p) (diagonal q) (diag_T p) (diag_T q) := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  rw [coordOp_coe _ (vv_sym p q), sandOp_coe]
  ext a b
  simp only [Matrix.hadamard_apply, Matrix.add_apply, Matrix.vecMulVec_apply, Matrix.mul_diagonal, Matrix.diagonal_mul]
  ring

/-- **A frame change conjugates the factors of a sandwich.** -/
theorem rotR_sandOp (U A B : Matrix (Fin n) (Fin n) ℝ) (hA : Aᵀ = A) (hB : Bᵀ = B) (hA' : (U * A * Uᵀ)ᵀ = U * A * Uᵀ)
    (hB' : (U * B * Uᵀ)ᵀ = U * B * Uᵀ) :
    rotR U (sandOp A B hA hB) = sandOp (U * A * Uᵀ) (U * B * Uᵀ) hA' hB' := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  rw [rotR_coe, sandOp_coe, sandOp_coe, cU_coe]
  simp only [Matrix.mul_add, Matrix.add_mul, Matrix.mul_assoc]

theorem conj_sym (U A : Matrix (Fin n) (Fin n) ℝ) (hA : Aᵀ = A) : (U * A * Uᵀ)ᵀ = U * A * Uᵀ := by
  rw [transpose_mul, transpose_mul, transpose_transpose, hA, Matrix.mul_assoc]

/-- **The rotation of the `(j, k)`-plane**, `e_j ↦ c e_j + s e_k`, `e_k ↦ −s e_j + c e_k`, fixing the rest. -/
def Rot (j k : Fin n) (c s : ℝ) : Matrix (Fin n) (Fin n) ℝ := Matrix.of fun p q =>
  if q = j then (if p = j then c else if p = k then s else 0)
  else if q = k then (if p = j then -s else if p = k then c else 0)
  else if p = q then 1 else 0

/-- **The swap matrix `S = E_jk + E_kj`.** -/
def Smat (j k : Fin n) : Matrix (Fin n) (Fin n) ℝ := Matrix.of fun p q =>
  if (p = j ∧ q = k) ∨ (p = k ∧ q = j) then 1 else 0

variable {j k : Fin n}

/-- A row of `Rot` against a vector. -/
theorem Rot_row (hjk : j ≠ k) (c s : ℝ) (p : Fin n) (f : Fin n → ℝ) :
    ∑ r, Rot j k c s p r * f r = if p = j then c * f j - s * f k else if p = k then s * f j + c * f k else f p := by
  by_cases hpj : p = j
  · subst hpj
    rw [if_pos rfl, Finset.sum_eq_add p k hjk (fun r _ hr => by simp [Rot, hr.1, hr.2, Ne.symm hr.1]) (by simp) (by simp)]
    simp [Rot, hjk, Ne.symm hjk]; ring
  · by_cases hpk : p = k
    · subst hpk
      rw [if_neg hpj, if_pos rfl, Finset.sum_eq_add j p (Ne.symm hpj)
        (fun r _ hr => by simp [Rot, hr.1, hr.2, Ne.symm hr.2]) (by simp) (by simp)]
      simp [Rot, hpj, Ne.symm hpj]
    · rw [if_neg hpj, if_neg hpk, Finset.sum_eq_single p (fun r _ hr => by simp [Rot, hpj, hpk, Ne.symm hr]) (by simp)]
      simp [Rot, hpj, hpk]

/-- A column of `Rot` against a vector. -/
theorem Rot_col (hjk : j ≠ k) (c s : ℝ) (q : Fin n) (f : Fin n → ℝ) :
    ∑ r, f r * Rot j k c s r q = if q = j then c * f j + s * f k else if q = k then -s * f j + c * f k else f q := by
  by_cases hqj : q = j
  · subst hqj
    rw [if_pos rfl, Finset.sum_eq_add q k hjk (fun r _ hr => by simp [Rot, hr.1, hr.2]) (by simp) (by simp)]
    simp [Rot, hjk, Ne.symm hjk]; ring
  · by_cases hqk : q = k
    · subst hqk
      rw [if_neg hqj, if_pos rfl, Finset.sum_eq_add j q (Ne.symm hqj) (fun r _ hr => by simp [Rot, hr.1, hr.2, hqj])
        (by simp) (by simp)]
      simp [Rot, hqj, Ne.symm hqj]; ring
    · rw [if_neg hqj, if_neg hqk, Finset.sum_eq_single q (fun r _ hr => by simp [Rot, hqj, hqk, hr]) (by simp)]
      simp [Rot, hqj, hqk]

/-- **`Rot` conjugates a diagonal** `diag w` to the matrix with these entries. -/
theorem Rot_diag_apply (hjk : j ≠ k) (c s : ℝ) (w : Fin n → ℝ) (p q : Fin n) :
    (Rot j k c s * diagonal w * (Rot j k c s)ᵀ) p q
      = ∑ r, Rot j k c s p r * (w r * Rot j k c s q r) := by
  rw [Matrix.mul_apply]
  refine Finset.sum_congr rfl fun r _ => ?_
  rw [Matrix.mul_diagonal, Matrix.transpose_apply]
  ring

theorem Rot_diag_fix (hjk : j ≠ k) {c s : ℝ} (hcs : c ^ 2 + s ^ 2 = 1) (w : Fin n → ℝ) (hw : w j = w k) :
    Rot j k c s * diagonal w * (Rot j k c s)ᵀ = diagonal w := by
  have e1 : ∀ x : ℝ, c * (x * c) + s * (x * s) = x := fun x => by linear_combination x * hcs
  have e2 : ∀ x : ℝ, s * (x * s) + c * (x * c) = x := fun x => by linear_combination x * hcs
  ext p q
  rw [Rot_diag_apply hjk, Rot_row hjk]
  by_cases hpj : p = j
  · subst hpj
    by_cases hqj : q = p
    · subst hqj; simp [Rot, hjk, Ne.symm hjk, hw, e1, e2]
    · by_cases hqk : q = k
      · subst hqk; simp [Rot, hjk, Ne.symm hjk, hw]; ring
      · simp [Rot, hjk, Ne.symm hjk, hqj, hqk, Ne.symm hqj]
  · by_cases hpk : p = k
    · subst hpk
      by_cases hqj : q = j
      · subst hqj; simp [Rot, hpj, Ne.symm hpj, hw]; ring
      · by_cases hqk : q = p
        · subst hqk; simp [Rot, hpj, Ne.symm hpj, hw, e1, e2]
        · simp [Rot, hpj, hqj, hqk, Ne.symm hqk]
    · simp only [if_neg hpj, if_neg hpk]
      by_cases hqp : q = p
      · subst hqp; simp [Rot, hpj, hpk]
      · simp [Rot, hpj, hpk, Ne.symm hqp, hqp]

theorem Rot_orth (hjk : j ≠ k) {c s : ℝ} (hcs : c ^ 2 + s ^ 2 = 1) : IsOrth (Rot j k c s) := by
  have h : Rot j k c s * (Rot j k c s)ᵀ = 1 := by
    have := Rot_diag_fix hjk hcs (fun _ => (1 : ℝ)) rfl
    rwa [diagonal_one, Matrix.mul_one] at this
  exact ⟨mul_eq_one_comm.mp h, h⟩

/-- **`Rot` sends `diag(e_j − e_k)` to `(c² − s²) diag(e_j − e_k) + 2cs S`.** -/
theorem Rot_diag_u (hjk : j ≠ k) (c s : ℝ) :
    Rot j k c s * diagonal (uj j k) * (Rot j k c s)ᵀ = (c ^ 2 - s ^ 2) • diagonal (uj j k) + (2 * c * s) • Smat j k := by
  ext p q
  rw [Rot_diag_apply hjk, Rot_row hjk]
  by_cases hpj : p = j
  · subst hpj
    by_cases hqj : q = p
    · subst hqj; simp [Rot, Smat, uj, hjk, Ne.symm hjk]; ring
    · by_cases hqk : q = k
      · subst hqk; simp [Rot, Smat, uj, hjk, Ne.symm hjk]; ring
      · simp [Rot, Smat, uj, hjk, Ne.symm hjk, hqj, hqk, Ne.symm hqj]
  · by_cases hpk : p = k
    · subst hpk
      by_cases hqj : q = j
      · subst hqj; simp [Rot, Smat, uj, hpj, Ne.symm hpj]; ring
      · by_cases hqk : q = p
        · subst hqk; simp [Rot, Smat, uj, hpj, Ne.symm hpj]; ring
        · simp [Rot, Smat, uj, hpj, hqj, hqk, Ne.symm hqk]
    · simp only [if_neg hpj, if_neg hpk]
      by_cases hqp : q = p
      · subst hqp; simp [Rot, Smat, uj, hpj, hpk]
      · simp [Rot, Smat, uj, hpj, hpk, Ne.symm hqp, hqp]

theorem Smat_T (j k : Fin n) : (Smat j k)ᵀ = Smat j k := by
  ext p q; simp only [Smat, Matrix.transpose_apply, Matrix.of_apply]
  congr 1; apply propext; tauto

theorem Smat_row (hjk : j ≠ k) (p : Fin n) (f : Fin n → ℝ) :
    ∑ r, Smat j k p r * f r = if p = j then f k else if p = k then f j else 0 := by
  by_cases hpj : p = j
  · subst hpj
    rw [if_pos rfl, Finset.sum_eq_single k (fun r _ hr => by simp [Smat, hr, hjk]) (by simp)]
    simp [Smat]
  · by_cases hpk : p = k
    · subst hpk
      rw [if_neg hpj, if_pos rfl, Finset.sum_eq_single j (fun r _ hr => by simp [Smat, hr, hpj]) (by simp)]
      simp [Smat]
    · rw [if_neg hpj, if_neg hpk]
      exact Finset.sum_eq_zero fun r _ => by simp [Smat, hpj, hpk]

theorem Smat_col (hjk : j ≠ k) (q : Fin n) (f : Fin n → ℝ) :
    ∑ r, f r * Smat j k r q = if q = j then f k else if q = k then f j else 0 := by
  have h : ∀ r, f r * Smat j k r q = Smat j k q r * f r := fun r => by
    rw [mul_comm, ← Matrix.transpose_apply (Smat j k), Smat_T]
  simp only [h]
  exact Smat_row hjk q f

/-- **On skew `X`, `D_u X D_u = S X S`.** -/
theorem uXu_eq_SXS (hjk : j ≠ k) {X : Matrix (Fin n) (Fin n) ℝ} (hX : Xᵀ = -X) :
    diagonal (uj j k) * X * diagonal (uj j k) = Smat j k * X * Smat j k := by
  have hskew : ∀ a b, X a b = -X b a := fun a b => by
    have := congrFun (congrFun hX b) a; simp only [Matrix.transpose_apply, Matrix.neg_apply] at this; linarith
  have h1 : X j j = 0 := by have := hskew j j; linarith
  have h2 : X k k = 0 := by have := hskew k k; linarith
  have h3 : X k j = -X j k := hskew k j
  clear hskew hX
  ext p q
  rw [Matrix.mul_diagonal, Matrix.diagonal_mul, Matrix.mul_apply]
  rw [Smat_col hjk q (fun r => (Smat j k * X) p r)]
  simp only [Matrix.mul_apply, Smat_row hjk]
  by_cases hpj : p = j <;> by_cases hpk : p = k <;> by_cases hqj : q = j <;> by_cases hqk : q = k <;>
    simp_all [uj] <;> ring_nf

/-- **On skew `X`, `D_u X S + S X D_u = 0`.** -/
theorem uXS_add (hjk : j ≠ k) {X : Matrix (Fin n) (Fin n) ℝ} (hX : Xᵀ = -X) :
    diagonal (uj j k) * X * Smat j k + Smat j k * X * diagonal (uj j k) = 0 := by
  have hskew : ∀ a b, X a b = -X b a := fun a b => by
    have := congrFun (congrFun hX b) a; simp only [Matrix.transpose_apply, Matrix.neg_apply] at this; linarith
  have h1 : X j j = 0 := by have := hskew j j; linarith
  have h2 : X k k = 0 := by have := hskew k k; linarith
  have h3 : X k j = -X j k := hskew k j
  clear hskew hX
  ext p q
  rw [Matrix.add_apply, Matrix.mul_diagonal, Matrix.mul_apply, Smat_col hjk q (fun r => (diagonal (uj j k) * X) p r)]
  simp only [Matrix.diagonal_mul]
  simp only [Matrix.mul_apply, Smat_row hjk, Matrix.zero_apply]
  by_cases hpj : p = j <;> by_cases hpk : p = k <;> by_cases hqj : q = j <;> by_cases hqk : q = k <;>
    simp_all [uj] <;> ring_nf

theorem sandOp_congr {A A' B B' : Matrix (Fin n) (Fin n) ℝ} (hA : Aᵀ = A) (hB : Bᵀ = B) (hA' : A'ᵀ = A') (hB' : B'ᵀ = B')
    (eA : A = A') (eB : B = B') : sandOp A B hA hB = sandOp A' B' hA' hB' := by
  subst eA; subst eB; rfl

theorem uj_T (j k : Fin n) : (diagonal (uj j k))ᵀ = diagonal (uj j k) := diag_T _

/-- **The `D_u` sandwich is fixed by every rotation of the `(j, k)`-plane.** -/
theorem sandOp_uu_rot (hjk : j ≠ k) {c s : ℝ} (hcs : c ^ 2 + s ^ 2 = 1) :
    rotR (Rot j k c s) (sandOp (diagonal (uj j k)) (diagonal (uj j k)) (uj_T j k) (uj_T j k))
      = sandOp (diagonal (uj j k)) (diagonal (uj j k)) (uj_T j k) (uj_T j k) := by
  rw [rotR_sandOp _ _ _ _ _ (conj_sym _ _ (uj_T j k)) (conj_sym _ _ (uj_T j k))]
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  rw [sandOp_coe, sandOp_coe, Rot_diag_u hjk]
  have hX : (X : Matrix (Fin n) (Fin n) ℝ)ᵀ = -(X : Matrix (Fin n) (Fin n) ℝ) := X.2
  set x := (X : Matrix (Fin n) (Fin n) ℝ)
  set U := diagonal (uj j k)
  set T := Smat j k
  have e : ((c ^ 2 - s ^ 2) • U + (2 * c * s) • T) * x * ((c ^ 2 - s ^ 2) • U + (2 * c * s) • T)
      = ((c ^ 2 - s ^ 2) ^ 2) • (U * x * U) + ((c ^ 2 - s ^ 2) * (2 * c * s)) • (U * x * T + T * x * U)
        + ((2 * c * s) ^ 2) • (T * x * T) := by
    simp only [Matrix.add_mul, Matrix.mul_add, Matrix.smul_mul, Matrix.mul_smul, smul_smul, smul_add]
    module
  rw [e, uXS_add hjk hX, ← uXu_eq_SXS hjk hX]
  have h1 : (c ^ 2 - s ^ 2) ^ 2 + (2 * c * s) ^ 2 = 1 := by nlinarith [hcs]
  calc ((c ^ 2 - s ^ 2) ^ 2) • (U * x * U) + ((c ^ 2 - s ^ 2) * (2 * c * s)) • (0 : Matrix (Fin n) (Fin n) ℝ)
        + ((2 * c * s) ^ 2) • (U * x * U) + (((c ^ 2 - s ^ 2) ^ 2) • (U * x * U)
          + ((c ^ 2 - s ^ 2) * (2 * c * s)) • (0 : Matrix (Fin n) (Fin n) ℝ) + ((2 * c * s) ^ 2) • (U * x * U))
      = ((c ^ 2 - s ^ 2) ^ 2 + (2 * c * s) ^ 2) • (U * x * U + U * x * U) := by module
    _ = U * x * U + U * x * U := by rw [h1, one_smul]

theorem coordOp_smul' (t : ℝ) (a : Matrix (Fin n) (Fin n) ℝ) : coordOp (t • a) = t • coordOp a := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  show skewPartM ((t • a) ⊙ (X : Matrix (Fin n) (Fin n) ℝ)) = t • skewPartM (a ⊙ (X : Matrix (Fin n) (Fin n) ℝ))
  rw [Matrix.smul_hadamard]; unfold skewPartM; rw [Matrix.transpose_smul]; module

theorem coordOp_vv (p : Fin n → ℝ) :
    coordOp (vecMulVec p p) = (1 / 2 : ℝ) • sandOp (diagonal p) (diagonal p) (diag_T p) (diag_T p) := by
  rw [← coordOp_rank_two, show vecMulVec p p + vecMulVec p p = (2 : ℝ) • vecMulVec p p by module, coordOp_smul', smul_smul]
  norm_num

/-- **`G_y` as a sum of sandwiches.** -/
theorem coordOp_Gy (j k : Fin n) (y : Fin n → ℝ) :
    coordOp (Gy j k y)
      = sandOp (diagonal fun i => uj j k i * uj j k i) (diagonal fun i => vy j k y i * vy j k y i) (diag_T _) (diag_T _)
        + ((∑ c, vy j k y c * vy j k y c) * (1 / 2)) • sandOp (diagonal (uj j k)) (diagonal (uj j k)) (uj_T j k) (uj_T j k)
        + ((∑ c, uj j k c * uj j k c) * (1 / 2)) • sandOp (diagonal (vy j k y)) (diagonal (vy j k y)) (diag_T _) (diag_T _) := by
  unfold Gy
  rw [coordOp_add, coordOp_add, coordOp_rank_two, coordOp_smul', coordOp_smul', coordOp_vv, coordOp_vv, smul_smul,
    smul_smul]

/-- **`G_y` is fixed by every rotation of the `(j, k)`-plane.** -/
theorem Gy_rot (hjk : j ≠ k) {c s : ℝ} (hcs : c ^ 2 + s ^ 2 = 1) (y : Fin n → ℝ) :
    rotR (Rot j k c s) (coordOp (Gy j k y)) = coordOp (Gy j k y) := by
  rw [coordOp_Gy, LinearMap.map_add, LinearMap.map_add, LinearMap.map_smul, LinearMap.map_smul, sandOp_uu_rot hjk hcs,
    rotR_sandOp _ _ _ _ _ (conj_sym _ _ (diag_T _)) (conj_sym _ _ (diag_T _)),
    rotR_sandOp _ _ _ _ _ (conj_sym _ _ (diag_T _)) (conj_sym _ _ (diag_T _))]
  have hu2 : (fun i => uj j k i * uj j k i) j = (fun i => uj j k i * uj j k i) k := by simp [uj, hjk, Ne.symm hjk]
  have hv2 : (fun i => vy j k y i * vy j k y i) j = (fun i => vy j k y i * vy j k y i) k := by simp [vy]
  have hv : vy j k y j = vy j k y k := by simp [vy]
  rw [sandOp_congr _ _ (diag_T _) (diag_T _) (Rot_diag_fix hjk hcs _ hu2) (Rot_diag_fix hjk hcs _ hv2),
    sandOp_congr _ _ (diag_T _) (diag_T _) (Rot_diag_fix hjk hcs _ hv) (Rot_diag_fix hjk hcs _ hv)]

/-- `coordOp` of a weight is the restricted diagonal operator. -/
theorem coordOp_eq_restrict {w : Matrix (Fin n) (Fin n) ℝ} (hw : FamilyLayer.IsWeight w) :
    coordOp w = restrict (FamilyLayer.diagOp_isWeyl hw) := by
  have hT : wᵀ = w := by ext a b; rw [Matrix.transpose_apply, hw.symm]
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  rw [coordOp_coe w hT, restrict_apply]
  rfl

/-- **`D⁻_x` is Weyl** when `Σ x = 0` off `{j, k}`. -/
theorem Dminus_weyl (hjk : j ≠ k) (x : Fin n → ℝ) (hsum : ∑ c, vy j k x c = 0) : IsWeyl2 (coordOp (Dminus j k x)) := by
  have hu : ∑ c, uj j k c = 0 := by
    unfold uj
    rw [← Finset.add_sum_erase _ _ (Finset.mem_univ j), if_pos rfl,
      ← Finset.add_sum_erase _ _ (Finset.mem_erase.mpr ⟨Ne.symm hjk, Finset.mem_univ k⟩), if_neg (Ne.symm hjk), if_pos rfl,
      Finset.sum_eq_zero fun c hc => by
        rw [if_neg (Finset.ne_of_mem_erase (Finset.mem_of_mem_erase hc)), if_neg (Finset.ne_of_mem_erase hc)]]
    ring
  have hw : FamilyLayer.IsWeight (Dminus j k x) := by
    refine ⟨fun a b => ?_, fun a => ?_, fun a => ?_⟩
    · simp only [Dminus, Matrix.add_apply, Matrix.vecMulVec_apply]; ring
    · simp only [Dminus, Matrix.add_apply, Matrix.vecMulVec_apply]; rw [uj_vy, mul_comm (vy j k x a), uj_vy]; ring
    · simp only [Dminus, Matrix.add_apply, Matrix.vecMulVec_apply, Finset.sum_add_distrib, ← Finset.mul_sum, hsum, hu]
      ring
  rw [coordOp_eq_restrict hw]
  exact isWeyl2_restrict _

/-- **The record's `ν_x`**: `X ↦ S X D_x + D_x X S`, sending `φ_ja` to `x_a φ_ka` and `φ_ka` to `x_a φ_ja`. -/
noncomputable def nuX (j k : Fin n) (x : Fin n → ℝ) : CurvOp2 (Fin n) :=
  sandOp (Smat j k) (diagonal (vy j k x)) (Smat_T j k) (diag_T _)

/-- The 45° cosine, `c² = ½`. -/
noncomputable def c45 : ℝ := Real.sqrt 2 / 2

theorem c45_sq : c45 ^ 2 = 1 / 2 := by
  unfold c45; rw [div_pow, Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 2)]; norm_num

/-- **The 45° rotation carries `D⁻_x` onto `ν_x`.** -/
theorem rot45_Dminus (hjk : j ≠ k) (x : Fin n → ℝ) :
    rotR (Rot j k c45 c45) (coordOp (Dminus j k x)) = nuX j k x := by
  have hcs : c45 ^ 2 + c45 ^ 2 = 1 := by rw [c45_sq]; norm_num
  unfold Dminus nuX
  rw [coordOp_rank_two, rotR_sandOp _ _ _ _ _ (conj_sym _ _ (diag_T _)) (conj_sym _ _ (diag_T _))]
  have hv : vy j k x j = vy j k x k := by simp [vy]
  apply sandOp_congr
  · rw [Rot_diag_u hjk, show c45 ^ 2 - c45 ^ 2 = 0 by ring, show 2 * c45 * c45 = 1 by nlinarith [c45_sq], zero_smul,
      zero_add, one_smul]
  · exact Rot_diag_fix hjk hcs _ hv

/-- **L222 (2), `ν_x ∘ ν_x = G_x`**, at `Σ x = 0` off `{j, k}`. -/
theorem Q_nuX (hjk : j ≠ k) (x : Fin n → ℝ) (hsum : ∑ c, vy j k x c = 0) : Qop2 (nuX j k x) = coordOp (Gy j k x) := by
  have hcs : c45 ^ 2 + c45 ^ 2 = 1 := by rw [c45_sq]; norm_num
  rw [← rot45_Dminus hjk x, L219GenOps.Qop2_rotR (Rot_orth hjk hcs) (Dminus_weyl hjk x hsum), Q_Dminus, Gy_rot hjk hcs]

/-- **`ν_x φ_ja = x_a φ_ka`**, `a ∉ {j, k}`: `nuX` is the record's `ν_x = Σ_a x_a e_ja ⊙ e_ka`. -/
theorem nuX_phi_ja (hjk : j ≠ k) (x : Fin n → ℝ) {a : Fin n} (haj : a ≠ j) (hak : a ≠ k) :
    ((nuX j k x ⟨phi j a, phi_mem_skewSub j a⟩ : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) = x a • phi k a := by
  unfold nuX
  rw [sandOp_coe]
  ext p q
  simp only [Matrix.add_apply, Matrix.mul_diagonal, Matrix.smul_apply, smul_eq_mul]
  rw [Matrix.mul_apply, Smat_row hjk, Matrix.mul_apply, Smat_col hjk]
  simp only [Matrix.diagonal_mul]
  have hkj := Ne.symm hjk
  have hja := Ne.symm haj
  have hka := Ne.symm hak
  by_cases hpj : p = j <;> by_cases hpk : p = k <;> by_cases hqj : q = j <;> by_cases hqk : q = k <;>
    by_cases hpa : p = a <;> by_cases hqa : q = a <;>
    simp_all [phi, Matrix.single_apply, vy, eq_comm]

/-- **`ν_x φ_ka = x_a φ_ja`**, `a ∉ {j, k}`. -/
theorem nuX_phi_ka (hjk : j ≠ k) (x : Fin n → ℝ) {a : Fin n} (haj : a ≠ j) (hak : a ≠ k) :
    ((nuX j k x ⟨phi k a, phi_mem_skewSub k a⟩ : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) = x a • phi j a := by
  unfold nuX
  rw [sandOp_coe]
  ext p q
  simp only [Matrix.add_apply, Matrix.mul_diagonal, Matrix.smul_apply, smul_eq_mul]
  rw [Matrix.mul_apply, Smat_row hjk, Matrix.mul_apply, Smat_col hjk]
  simp only [Matrix.diagonal_mul]
  have hkj := Ne.symm hjk
  have hja := Ne.symm haj
  have hka := Ne.symm hak
  by_cases hpj : p = j <;> by_cases hpk : p = k <;> by_cases hqj : q = j <;> by_cases hqk : q = k <;>
    by_cases hpa : p = a <;> by_cases hqa : q = a <;>
    simp_all [phi, Matrix.single_apply, vy, eq_comm]

end HamiltonsCubic.PairSquare
