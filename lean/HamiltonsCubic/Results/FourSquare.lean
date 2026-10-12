import Mathlib
import HamiltonsCubic.Results.L224Rot

set_option linter.style.longLine false

/-!
# L220 step 2's square on one four-set pairing: `σ ∘ σ` for `σ = S_{ik} X S_{jl} + S_{jl} X S_{ik}`

[findings/second-order.md](../../../findings/second-order.md), Lemma L220, step 2: *$\nu\circ\nu\in\Pi_Q$, with $x=2a^2-b^2-c^2$ and cyclically …
on $Q$ the pattern is $(\nu\#\nu)_{ij,ij}=2bc$ plus $(\nu^2)_{ij,ij}=a^2$.* The four-set block is spanned by sandwiches of swap matrices,
$\sigma=\mathrm{sandOp}(S_{ik},S_{jl})$, and a double $45^\circ$ rotation, in the planes $(i,k)$ and $(j,l)$, carries $\sigma$ to the
coordinate operator of $w=u_{ik}u_{jl}^{\mathsf T}+u_{jl}u_{ik}^{\mathsf T}$, as [PairSquare.lean](PairSquare.lean)'s `rot45_Dminus` does for a
pair. So $\sigma\circ\sigma$ is the rotation back of $Q(w\odot\cdot)=W_2\odot\cdot$, and both rotations fix $W_2$.

* `w4`, `W4`: $w=u_{ik}u_{jl}^{\mathsf T}+u_{jl}u_{ik}^{\mathsf T}$ and $W_2=P_{ik}P_{jl}^{\mathsf T}+P_{jl}P_{ik}^{\mathsf T}+2(u_{ik}u_{ik}^{\mathsf T}+u_{jl}u_{jl}^{\mathsf T})$;
* `Q_w4`: $Q(w\odot\cdot)=W_2\odot\cdot$;
* `W4_fix1`, `W4_fix2`: every rotation of either plane fixes $W_2\odot\cdot$;
* `sig_rot`: the double $45^\circ$ rotation carries $\sigma$ to $w\odot\cdot$;
* **`Q_sig`**: $\sigma\circ\sigma=W_2\odot\cdot$, weight $1$ on $ij,il,kj,kl$ and $-2$ on $ik,jl$, the record's pattern at $(a,b,c)=(1,0,-1)$.
-/

namespace HamiltonsCubic.FourSquare

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.I117S
  HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.FrameOp2 HamiltonsCubic.L224Rot HamiltonsCubic.FrameLayer

variable {n : ℕ} {i j k l : Fin n}

/-- The indicator of `{p, q}`. -/
def ind2 (p q : Fin n) : Fin n → ℝ := fun r => if r = p ∨ r = q then 1 else 0

/-- `w = u_{ik} u_{jl}ᵀ + u_{jl} u_{ik}ᵀ`. -/
noncomputable def w4 (i k j l : Fin n) : Matrix (Fin n) (Fin n) ℝ :=
  vecMulVec (uj i k) (uj j l) + vecMulVec (uj j l) (uj i k)

/-- `W₂ = P_{ik} P_{jl}ᵀ + P_{jl} P_{ik}ᵀ + 2(u_{ik} u_{ik}ᵀ + u_{jl} u_{jl}ᵀ)`. -/
noncomputable def W4 (i k j l : Fin n) : Matrix (Fin n) (Fin n) ℝ :=
  vecMulVec (ind2 i k) (ind2 j l) + vecMulVec (ind2 j l) (ind2 i k)
    + (2 : ℝ) • (vecMulVec (uj i k) (uj i k) + vecMulVec (uj j l) (uj j l))

/-- The sandwich `σ = S_{ik} X S_{jl} + S_{jl} X S_{ik}`. -/
noncomputable def sig4 (i k j l : Fin n) : CurvOp2 (Fin n) := sandOp (Smat i k) (Smat j l) (Smat_T i k) (Smat_T j l)

section
variable (hik : i ≠ k) (hjl : j ≠ l) (hij : i ≠ j) (hil : i ≠ l) (hkj : k ≠ j) (hkl : k ≠ l)
include hik hjl hij hil hkj hkl

theorem uj_sq (p : Fin n) : uj i k p * uj i k p = ind2 i k p := by
  unfold uj ind2
  by_cases h1 : p = i
  · subst h1; simp
  · by_cases h2 : p = k
    · subst h2; simp [h1]
    · simp [h1, h2]

theorem uj_sq' (p : Fin n) : uj j l p * uj j l p = ind2 j l p := by
  unfold uj ind2
  by_cases h1 : p = j
  · subst h1; simp
  · by_cases h2 : p = l
    · subst h2; simp [h1]
    · simp [h1, h2]

theorem uj_dis (p : Fin n) : uj i k p * uj j l p = 0 := by
  unfold uj
  by_cases h1 : p = i
  · subst h1; simp [hij, hil]
  · by_cases h2 : p = k
    · subst h2; simp [h1, hkj, hkl]
    · simp [h1, h2]

theorem uj_sum (a b : Fin n) (hab : a ≠ b) : ∑ c, uj a b c = 0 := by
  unfold uj
  rw [← Finset.add_sum_erase _ _ (Finset.mem_univ a), if_pos rfl,
    ← Finset.add_sum_erase _ _ (Finset.mem_erase.mpr ⟨Ne.symm hab, Finset.mem_univ b⟩), if_neg (Ne.symm hab), if_pos rfl,
    Finset.sum_eq_zero fun c hc => by
      rw [if_neg (Finset.ne_of_mem_erase (Finset.mem_of_mem_erase hc)), if_neg (Finset.ne_of_mem_erase hc)]]
  ring

theorem w4_T : (w4 i k j l)ᵀ = w4 i k j l := vv_sym _ _

theorem w4_hollow (p : Fin n) : w4 i k j l p p = 0 := by
  simp only [w4, Matrix.add_apply, Matrix.vecMulVec_apply]
  rw [uj_dis hik hjl hij hil hkj hkl p, mul_comm (uj j l p), uj_dis hik hjl hij hil hkj hkl p]; ring

theorem w4_weight : FamilyLayer.IsWeight (w4 i k j l) := by
  refine ⟨fun a b => ?_, w4_hollow hik hjl hij hil hkj hkl, fun a => ?_⟩
  · simp only [w4, Matrix.add_apply, Matrix.vecMulVec_apply]; ring
  · simp only [w4, Matrix.add_apply, Matrix.vecMulVec_apply, Finset.sum_add_distrib, ← Finset.mul_sum,
      uj_sum hik hjl hij hil hkj hkl i k hik, uj_sum hik hjl hij hil hkj hkl j l hjl]
    ring

/-- **`Q(w ⊙ ·) = W₂ ⊙ ·`.** -/
theorem Q_w4 : Qop2 (coordOp (w4 i k j l)) = coordOp (W4 i k j l) := by
  rw [Qop2_coordOp _ (w4_T hik hjl hij hil hkj hkl) (w4_hollow hik hjl hij hil hkj hkl)]
  congr 1
  have s11 : ∑ r, uj i k r * uj i k r = 2 := uj_norm hik
  have s22 : ∑ r, uj j l r * uj j l r = 2 := uj_norm hjl
  have s12 : ∑ r, uj i k r * uj j l r = 0 := Finset.sum_eq_zero fun r _ => uj_dis hik hjl hij hil hkj hkl r
  have s21 : ∑ r, uj j l r * uj i k r = 0 := Finset.sum_eq_zero fun r _ => by
    rw [mul_comm]; exact uj_dis hik hjl hij hil hkj hkl r
  ext p q
  simp only [w4, W4, Matrix.add_apply, Matrix.hadamard_apply, Matrix.mul_apply, Matrix.vecMulVec_apply,
    Matrix.smul_apply, smul_eq_mul]
  have e : ∀ r, (uj i k p * uj j l r + uj j l p * uj i k r) * (uj i k r * uj j l q + uj j l r * uj i k q)
      = uj i k p * uj j l q * (uj j l r * uj i k r) + uj i k p * uj i k q * (uj j l r * uj j l r)
        + uj j l p * uj j l q * (uj i k r * uj i k r) + uj j l p * uj i k q * (uj i k r * uj j l r) := fun r => by ring
  simp only [e, Finset.sum_add_distrib, ← Finset.mul_sum, s11, s22, s12, s21]
  have e2 : (uj i k p * uj j l q + uj j l p * uj i k q) * (uj i k p * uj j l q + uj j l p * uj i k q)
      = (uj i k p * uj i k p) * (uj j l q * uj j l q) + (uj j l p * uj j l p) * (uj i k q * uj i k q)
        + 2 * ((uj i k p * uj j l p) * (uj i k q * uj j l q)) := by ring
  rw [e2, uj_sq hik hjl hij hil hkj hkl, uj_sq hik hjl hij hil hkj hkl, uj_sq' hik hjl hij hil hkj hkl,
    uj_sq' hik hjl hij hil hkj hkl, uj_dis hik hjl hij hil hkj hkl, uj_dis hik hjl hij hil hkj hkl]
  ring

theorem ind2_T (p q : Fin n) : (diagonal (ind2 p q))ᵀ = diagonal (ind2 p q) := diag_T _

/-- **Every rotation of the plane `(i, k)` fixes `W₂ ⊙ ·`.** -/
theorem W4_fix1 {c s : ℝ} (hcs : c ^ 2 + s ^ 2 = 1) :
    rotR (Rot i k c s) (coordOp (W4 i k j l)) = coordOp (W4 i k j l) := by
  have hP1 : ind2 i k i = ind2 i k k := by simp [ind2]
  have hP2 : ind2 j l i = ind2 j l k := by simp [ind2, Ne.symm hij, Ne.symm hil, hkj, hkl, Ne.symm hkj, Ne.symm hkl, hij, hil]
  have hu2 : uj j l i = uj j l k := by simp [uj, hij, hil, hkj, hkl]
  unfold W4
  rw [coordOp_add, coordOp_rank_two, coordOp_smul', coordOp_add, coordOp_vv, coordOp_vv, LinearMap.map_add,
    LinearMap.map_smul, LinearMap.map_add, LinearMap.map_smul, LinearMap.map_smul, sandOp_uu_rot hik hcs,
    rotR_sandOp _ _ _ _ _ (conj_sym _ _ (diag_T _)) (conj_sym _ _ (diag_T _)),
    rotR_sandOp _ _ _ _ _ (conj_sym _ _ (diag_T _)) (conj_sym _ _ (diag_T _)),
    sandOp_congr _ _ (diag_T _) (diag_T _) (Rot_diag_fix hik hcs _ hP1) (Rot_diag_fix hik hcs _ hP2),
    sandOp_congr _ _ (diag_T _) (diag_T _) (Rot_diag_fix hik hcs _ hu2) (Rot_diag_fix hik hcs _ hu2)]

/-- **Every rotation of the plane `(j, l)` fixes `W₂ ⊙ ·`.** -/
theorem W4_fix2 {c s : ℝ} (hcs : c ^ 2 + s ^ 2 = 1) :
    rotR (Rot j l c s) (coordOp (W4 i k j l)) = coordOp (W4 i k j l) := by
  have hP1 : ind2 i k j = ind2 i k l := by simp [ind2, Ne.symm hij, Ne.symm hil, hkj, hkl, Ne.symm hkj, Ne.symm hkl, hij, hil]
  have hP2 : ind2 j l j = ind2 j l l := by simp [ind2]
  have hu1 : uj i k j = uj i k l := by simp [uj, Ne.symm hij, Ne.symm hil, Ne.symm hkj, Ne.symm hkl]
  unfold W4
  rw [coordOp_add, coordOp_rank_two, coordOp_smul', coordOp_add, coordOp_vv, coordOp_vv, LinearMap.map_add,
    LinearMap.map_smul, LinearMap.map_add, LinearMap.map_smul, LinearMap.map_smul, sandOp_uu_rot hjl hcs,
    rotR_sandOp _ _ _ _ _ (conj_sym _ _ (diag_T _)) (conj_sym _ _ (diag_T _)),
    rotR_sandOp _ _ _ _ _ (conj_sym _ _ (diag_T _)) (conj_sym _ _ (diag_T _)),
    sandOp_congr _ _ (diag_T _) (diag_T _) (Rot_diag_fix hjl hcs _ hP1) (Rot_diag_fix hjl hcs _ hP2),
    sandOp_congr _ _ (diag_T _) (diag_T _) (Rot_diag_fix hjl hcs _ hu1) (Rot_diag_fix hjl hcs _ hu1)]

end

theorem c45_facts : c45 ^ 2 - c45 ^ 2 = 0 ∧ -(2 * c45 * c45) = -1 ∧ c45 ^ 2 + c45 ^ 2 = 1 := by
  refine ⟨by ring, by nlinarith [c45_sq], by rw [c45_sq]; norm_num⟩

/-- `R S Rᵀ = −D_u` at `45°`. -/
theorem Rot45_S {p q : Fin n} (hpq : p ≠ q) :
    Rot p q c45 c45 * Smat p q * (Rot p q c45 c45)ᵀ = diagonal (fun r => -uj p q r) := by
  rw [Rot_S hpq, c45_facts.1, c45_facts.2.1, zero_smul, zero_add]
  ext a b; simp [Matrix.diagonal_apply]

section
variable (hik : i ≠ k) (hjl : j ≠ l) (hij : i ≠ j) (hil : i ≠ l) (hkj : k ≠ j) (hkl : k ≠ l)
include hik hjl hij hil hkj hkl

/-- **The double `45°` rotation carries `σ` to `w ⊙ ·`.** -/
theorem sig_rot :
    rotR (Rot j l c45 c45) (rotR (Rot i k c45 c45) (sig4 i k j l)) = coordOp (w4 i k j l) := by
  have hcs := c45_facts.2.2
  unfold sig4
  rw [rotR_sandOp _ _ _ _ _ (conj_sym _ _ (Smat_T i k)) (conj_sym _ _ (Smat_T j l))]
  have h2 : Rot i k c45 c45 * Smat j l * (Rot i k c45 c45)ᵀ = Smat j l := by
    rw [Rot_mul_off hik _ _ _ (fun r t hr => by
        rcases hr with rfl | rfl <;> simp [Smat, hij, hil, hkj, hkl]),
      mul_RotT_off hik _ _ _ (fun r t ht => by
        rcases ht with h | h <;> simp [Smat, h, hij, hil, hkj, hkl])]
  rw [sandOp_congr _ _ (diag_T _) (Smat_T j l) (Rot45_S hik) h2,
    rotR_sandOp _ _ _ _ _ (conj_sym _ _ (diag_T _)) (conj_sym _ _ (Smat_T j l))]
  have hu : (fun r => -uj i k r) j = (fun r => -uj i k r) l := by
    simp [uj, Ne.symm hij, Ne.symm hil, Ne.symm hkj, Ne.symm hkl]
  rw [sandOp_congr _ _ (diag_T _) (diag_T _) (Rot_diag_fix hjl hcs _ hu) (Rot45_S hjl), ← coordOp_rank_two]
  congr 1
  ext a b
  simp only [w4, Matrix.add_apply, Matrix.vecMulVec_apply]
  ring

theorem w4_weyl : IsWeyl2 (coordOp (w4 i k j l)) := by
  rw [coordOp_eq_restrict (w4_weight hik hjl hij hil hkj hkl)]
  exact isWeyl2_restrict _

theorem sig_eq :
    sig4 i k j l = rotR (Rot i k c45 c45)ᵀ (rotR (Rot j l c45 c45)ᵀ (coordOp (w4 i k j l))) := by
  have hcs := c45_facts.2.2
  have hR1T := FrameLayer.isOrth_transpose (Rot_orth hik hcs)
  have hR2T := FrameLayer.isOrth_transpose (Rot_orth hjl hcs)
  rw [← sig_rot hik hjl hij hil hkj hkl]
  have e2 := L219GenOps.rotR_inv hR2T (rotR (Rot i k c45 c45) (sig4 i k j l))
  rw [Matrix.transpose_transpose] at e2
  rw [e2]
  have e1 := L219GenOps.rotR_inv hR1T (sig4 i k j l)
  rw [Matrix.transpose_transpose] at e1
  rw [e1]

theorem sig_weyl : IsWeyl2 (sig4 i k j l) := by
  have hcs := c45_facts.2.2
  rw [sig_eq hik hjl hij hil hkj hkl]
  exact rotR_isWeyl2 (FrameLayer.isOrth_transpose (Rot_orth hik hcs))
    (rotR_isWeyl2 (FrameLayer.isOrth_transpose (Rot_orth hjl hcs)) (w4_weyl hik hjl hij hil hkj hkl))

/-- **L220 (2) on one pairing: `σ ∘ σ = W₂ ⊙ ·`.** -/
theorem Q_sig : Qop2 (sig4 i k j l) = coordOp (W4 i k j l) := by
  have hcs := c45_facts.2.2
  have hR1 := Rot_orth hik hcs
  have hR2 := Rot_orth hjl hcs
  have hR1T := FrameLayer.isOrth_transpose hR1
  have hR2T := FrameLayer.isOrth_transpose hR2
  have hfixT : ∀ (U : Matrix (Fin n) (Fin n) ℝ), IsOrth U → rotR U (coordOp (W4 i k j l)) = coordOp (W4 i k j l) →
      rotR Uᵀ (coordOp (W4 i k j l)) = coordOp (W4 i k j l) := by
    intro U hU h
    have := L219GenOps.rotR_inv (FrameLayer.isOrth_transpose hU) (coordOp (W4 i k j l))
    rw [Matrix.transpose_transpose] at this
    conv_rhs => rw [← this, h]
  rw [sig_eq hik hjl hij hil hkj hkl,
    L219GenOps.Qop2_rotR hR1T (rotR_isWeyl2 hR2T (w4_weyl hik hjl hij hil hkj hkl)),
    L219GenOps.Qop2_rotR hR2T (w4_weyl hik hjl hij hil hkj hkl), Q_w4 hik hjl hij hil hkj hkl,
    hfixT _ hR2 (W4_fix2 hik hjl hij hil hkj hkl hcs), hfixT _ hR1 (W4_fix1 hik hjl hij hil hkj hkl hcs)]

end

end HamiltonsCubic.FourSquare
