import Mathlib
import HamiltonsCubic.Results.PairIdent
import HamiltonsCubic.Results.L222Op

set_option linter.style.longLine false

/-!
# L222 item 2's norms, `‖ν_x‖² = 2‖x‖²` and `‖G_x‖² = 3‖x‖⁴`, and the pinning made unconditional

[findings/second-order.md](../../../findings/second-order.md), Lemma L222, item 2: *$\lVert G_x\rVert^2=3\lVert x\rVert^4$, so
$\lVert\nu\circ\nu\rVert=\tfrac{\sqrt3}2\lVert\nu\rVert^2$*, with $\lVert\nu\rVert^2=2\lVert x\rVert^2$ from the preamble. The pairing on bivectors is
$\langle R,S\rangle=\tfrac12\sum_{i,j}\langle R\varphi_{ij},S\varphi_{ij}\rangle$, so a coordinate-diagonal operator has
$\lVert a\odot\cdot\rVert^2=\tfrac12\sum_{i\ne j}a_{ij}^2$; the two norms are then sums of rank-one inner products.

* `normSq2_coordOp`: $\lVert a\odot\cdot\rVert^2=\tfrac12\sum_{i\ne j}a_{ij}^2$ at a symmetric weight;
* `normSq2_Dminus`, **`normSq2_nuX`**: $\lVert D^-_x\rVert^2=\lVert\nu_x\rVert^2=2\lVert x\rVert^2$, the second through the rotation, an isometry;
* **`normSq2_Gy`**: $\lVert G_x\rVert^2=3\lVert x\rVert^4$;
* **`normSq2_Q_pair`**: $\lVert\nu\circ\nu\rVert^2=\tfrac34\lVert\nu\rVert^4$ at every Weyl $\nu$ of character $\varepsilon_j\varepsilon_k$;
* **`Sjk_pin_uncond`**: at a critical $W=D+\nu$ on $\mathcal S_{jk}$ with $\nu\ne0$, $\langle D,\hat g\rangle=\theta/\sqrt3$, L222 item 3's pinning
  with item 2's norm now proved.
-/

namespace HamiltonsCubic.PairNorm

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.L120Blocks HamiltonsCubic.I117S HamiltonsCubic.FrameOp2 HamiltonsCubic.DiagSquare
  HamiltonsCubic.PairSquare HamiltonsCubic.PairIdent HamiltonsCubic.L222Op

variable {n : ℕ} {j k : Fin n}

/-- **The norm of a coordinate-diagonal operator** is half the sum of its off-diagonal weights squared. -/
theorem normSq2_coordOp (a : Matrix (Fin n) (Fin n) ℝ) (ha : aᵀ = a) :
    normSq2 (coordOp a) = (1 / 2) * ∑ i, ∑ l, (if i = l then 0 else a i l ^ 2) := by
  unfold normSq2 innerOp2
  congr 1
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun l _ => ?_
  have e : applyPhi (coordOp a) i l = a i l • phi i l := by
    show ((coordOp a ⟨phi i l, phi_mem_skewSub i l⟩ : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) = _
    rw [coordOp_coe a ha]; exact hadamard_phi a ha i l
  rw [e, FamilyLayer.inner2_smul_left, FamilyLayer.inner2_smul_right, FamilyLayer.inner2_phi_phi]
  by_cases h : i = l
  · subst h; simp
  · simp [h, Ne.symm h]; ring

/-- The square of a rank-two symmetric weight, summed, at `u, v` of disjoint supports. -/
theorem sum_sq_rank_two (u v : Fin n → ℝ) (hdis : ∀ i, u i * v i = 0) :
    ∑ i, ∑ l, (u i * v l + v i * u l) ^ 2 = 2 * ((∑ i, u i ^ 2) * ∑ l, v l ^ 2) := by
  have h : ∀ i l, (u i * v l + v i * u l) ^ 2 = u i ^ 2 * v l ^ 2 + v i ^ 2 * u l ^ 2 + 2 * (u i * v i) * (u l * v l) :=
    fun i l => by ring
  simp only [h, hdis, mul_zero, zero_mul, add_zero, Finset.sum_add_distrib, ← Finset.mul_sum, ← Finset.sum_mul]
  ring

theorem Dminus_hollow (j k : Fin n) (x : Fin n → ℝ) (i : Fin n) : Dminus j k x i i = 0 := by
  simp only [Dminus, Matrix.add_apply, Matrix.vecMulVec_apply]
  rw [uj_vy, mul_comm (vy j k x i), uj_vy]; ring

/-- **`‖D⁻_x‖² = 2‖x‖²`**, `x` taken off `{j, k}`. -/
theorem normSq2_Dminus (hjk : j ≠ k) (x : Fin n → ℝ) :
    normSq2 (coordOp (Dminus j k x)) = 2 * ∑ c, vy j k x c ^ 2 := by
  have hT : (Dminus j k x)ᵀ = Dminus j k x := vv_sym _ _
  rw [normSq2_coordOp _ hT]
  have hdrop : ∀ i l, (if i = l then 0 else Dminus j k x i l ^ 2) = Dminus j k x i l ^ 2 := fun i l => by
    split_ifs with h
    · subst h; rw [Dminus_hollow]; ring
    · rfl
  simp only [hdrop]
  have e : ∑ i, ∑ l, Dminus j k x i l ^ 2
      = ∑ i, ∑ l, (uj j k i * vy j k x l + vy j k x i * uj j k l) ^ 2 := by
    simp only [Dminus, Matrix.add_apply, Matrix.vecMulVec_apply]
  rw [e, sum_sq_rank_two _ _ (uj_vy j k x)]
  have hu : ∑ i, uj j k i ^ 2 = 2 := by rw [← uj_norm hjk]; exact Finset.sum_congr rfl fun i _ => by ring
  rw [hu]; ring

/-- **`‖ν_x‖² = 2‖x‖²`**, at `Σ x = 0` off `{j, k}`, the 45° rotation being an isometry of the Weyl operators. -/
theorem normSq2_nuX (hjk : j ≠ k) (x : Fin n → ℝ) (hsum : ∑ c, vy j k x c = 0) :
    normSq2 (nuX j k x) = 2 * ∑ c, vy j k x c ^ 2 := by
  have hcs : c45 ^ 2 + c45 ^ 2 = 1 := by rw [c45_sq]; norm_num
  rw [← rot45_Dminus hjk x, normSq2_rotR (Rot_orth hjk hcs) (Dminus_weyl hjk x hsum), normSq2_Dminus hjk]

theorem sum_offdiag (f : Fin n → Fin n → ℝ) :
    ∑ i, ∑ l, (if i = l then 0 else f i l) = ∑ i, ∑ l, f i l - ∑ i, f i i := by
  rw [← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← Finset.add_sum_erase _ _ (Finset.mem_univ i), ← Finset.add_sum_erase _ (fun l => f i l) (Finset.mem_univ i),
    if_pos rfl, Finset.sum_congr rfl fun l hl => if_neg (Ne.symm (Finset.ne_of_mem_erase hl))]
  ring

theorem Gy_sym (j k : Fin n) (y : Fin n → ℝ) : (Gy j k y)ᵀ = Gy j k y := by
  ext a b; simp only [Gy, Matrix.transpose_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.vecMulVec_apply, smul_eq_mul]
  ring

theorem uj_four (j k : Fin n) (i : Fin n) : uj j k i ^ 4 = uj j k i ^ 2 := by
  unfold uj; split_ifs <;> norm_num

/-- **`‖G_x‖² = 3‖x‖⁴`**, `x` taken off `{j, k}`. -/
theorem normSq2_Gy (hjk : j ≠ k) (x : Fin n → ℝ) :
    normSq2 (coordOp (Gy j k x)) = 3 * (∑ c, vy j k x c ^ 2) ^ 2 := by
  rw [normSq2_coordOp _ (Gy_sym j k x), sum_offdiag]
  set u := uj j k with hudef
  set v := vy j k x with hvdef
  set U2 := ∑ c, u c * u c with hU2
  set V2 := ∑ c, v c * v c with hV2
  have hG : ∀ i l, Gy j k x i l = u i * u i * (v l * v l) + v i * v i * (u l * u l) + V2 * (u i * u l) + U2 * (v i * v l) := by
    intro i l
    simp only [Gy, Matrix.add_apply, Matrix.smul_apply, Matrix.vecMulVec_apply, smul_eq_mul]
    rfl
  have z : ∀ i, u i * v i = 0 := uj_vy j k x
  have hsq : ∀ i l, Gy j k x i l ^ 2
      = u i ^ 4 * v l ^ 4 + v i ^ 4 * u l ^ 4 + V2 ^ 2 * (u i ^ 2 * u l ^ 2) + U2 ^ 2 * (v i ^ 2 * v l ^ 2) := by
    intro i l
    rw [hG]
    have e : (u i * u i * (v l * v l) + v i * v i * (u l * u l) + V2 * (u i * u l) + U2 * (v i * v l)) ^ 2
        = u i ^ 4 * v l ^ 4 + v i ^ 4 * u l ^ 4 + V2 ^ 2 * (u i ^ 2 * u l ^ 2) + U2 ^ 2 * (v i ^ 2 * v l ^ 2)
          + (u i * v i) * (2 * (u i * v i) * (u l * v l) ^ 2 + 2 * U2 * u i * v l ^ 3 + 2 * V2 * v i * u l ^ 3
            + 2 * V2 * U2 * (u l * v l))
          + (u l * v l) * (2 * V2 * u i ^ 3 * v l + 2 * U2 * v i ^ 3 * u l) := by ring
    rw [e, z i, z l]; ring
  simp only [hsq, Finset.sum_add_distrib, ← Finset.mul_sum, ← Finset.sum_mul]
  have hU4 : ∑ c, u c ^ 4 = 2 := by
    rw [Finset.sum_congr rfl fun c _ => uj_four j k c, ← uj_norm hjk]
    exact Finset.sum_congr rfl fun c _ => by ring
  have hU2' : ∑ c, u c ^ 2 = 2 := by rw [← uj_norm hjk]; exact Finset.sum_congr rfl fun c _ => by ring
  have hU2v : U2 = 2 := uj_norm hjk
  have hV2' : ∑ c, v c ^ 2 = V2 := Finset.sum_congr rfl fun c _ => by ring
  have hz4 : ∑ c, u c ^ 4 * v c ^ 4 = 0 := Finset.sum_eq_zero fun c _ => by
    rw [show u c ^ 4 * v c ^ 4 = (u c * v c) ^ 4 by ring, z c]; ring
  have hz4' : ∑ c, v c ^ 4 * u c ^ 4 = 0 := Finset.sum_eq_zero fun c _ => by
    rw [show v c ^ 4 * u c ^ 4 = (u c * v c) ^ 4 by ring, z c]; ring
  have hU22 : ∑ c, u c ^ 2 * u c ^ 2 = 2 := by rw [← hU4]; exact Finset.sum_congr rfl fun c _ => by ring
  simp only [hU4, hU2', hV2', hU2v, hz4, hz4', hU22]
  ring

/-- **L222 item 2's norm clause**: every Weyl `ν` of character `ε_j ε_k` has `‖ν∘ν‖² = ¾‖ν‖⁴`. -/
theorem normSq2_Q_pair (hjk : j ≠ k) {ν : CurvOp2 (Fin n)} (hνW : IsWeyl2 ν) (hν : SignChar (setChar {j, k}) ν) :
    normSq2 (Qop2 ν) = 3 / 4 * normSq2 ν ^ 2 := by
  obtain ⟨c, hcj, hck, hsum, rfl, hQν⟩ := Q_pair hjk hνW hν
  have hvy : vy j k c = c := vy_of_zero c hcj hck
  rw [hQν, normSq2_Gy hjk, normSq2_nuX hjk c (by rw [hvy]; exact hsum)]
  ring

/-- **L222 item 3's pinning, unconditional**: at `D` of character `1`, `ν ≠ 0` Weyl of character `ε_j ε_k`, both
self-adjoint, and `Q(D + ν) = θ(D + ν)`, `⟨D, ĝ⟩ = θ/√3` for `ĝ = ν∘ν/‖ν∘ν‖`. -/
theorem Sjk_pin_uncond (hjk : j ≠ k) {D ν : CurvOp2 (Fin n)} (hD : SignChar (fun _ => 1) D)
    (hνW : IsWeyl2 ν) (hν : SignChar (setChar {j, k}) ν) (hDs : IsSelfAdjoint2 D) {θ : ℝ}
    (hQ : Qop2 (D + ν) = θ • (D + ν)) (hν0 : ν ≠ 0) :
    innerOp2 D (Qop2 ν) / Real.sqrt (normSq2 (Qop2 ν)) = θ / Real.sqrt 3 := by
  exact (Sjk_pin hjk hD hν hDs hνW.isSelfAdjoint2 hQ).2 (normSq2_Q_pair hjk hνW hν) hν0

end HamiltonsCubic.PairNorm
