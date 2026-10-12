import Mathlib
import HamiltonsCubic.Results.L224Norm
import HamiltonsCubic.Results.L221a

set_option linter.style.longLine false

/-!
# L224 step 4 on the operators: the pair block carries no cubic value beyond a diagonal tensor of the same norm

[findings/second-order.md](../../../findings/second-order.md), Lemma L224, step 4: *Let $\lambda$ be the top eigenvalue of the
quadratic form $q_E(z)=\langle E,G_z\rangle$ on $\{\sum z=0\}$ and $z_*$ a unit eigenvector for it. Then
$q_E(y)+q_E(x)\le\lambda s=q_E(\sqrt s\,z_*)$, so $W'=E+D^-_{\sqrt sz_*}$ is a unit diagonal tensor with
$P(W)\le P(E)+3\lambda s=P(W')\le\Theta_n$ by L57.* Here $z_*$ is a maximiser of $q_E$ on the unit sphere of
$\{z:z_j=z_k=0,\ \sum z=0\}$, which is compact, and $q_E(z)\le\lVert z\rVert^2q_E(z_*)$ by homogeneity; the last inequality, L57, is
a separate link.

* `Gy_smul`, `qE_smul`: $G_{tz}=t^2G_z$, so $q_E(tz)=t^2q_E(z)$;
* `exists_qE_max`: a maximiser $z_*$ on the unit sphere of the plane, with $q_E(z)\le\lVert z\rVert^2q_E(z_*)$ on the plane;
* `cubic_even_odd`: $P(E+D^-_z)=P(E)+3q_E(z)$ at a swap-even Weyl $E$ of character $1$;
* **`L224_step4`**: every $D+\nu$ on $\mathcal S_{jk}$ has a Weyl $W'$ of character $1$ with $\lVert W'\rVert=\lVert D+\nu\rVert$ and
  $P(D+\nu)\le P(W')$.
-/

namespace HamiltonsCubic.L224Step4

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.I117S HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.PairIdent HamiltonsCubic.L222Swap
  HamiltonsCubic.OddPart HamiltonsCubic.L224Cubic HamiltonsCubic.FrameOp2 HamiltonsCubic.L222Op HamiltonsCubic.L120Blocks
  HamiltonsCubic.PairNorm HamiltonsCubic.L224Pair HamiltonsCubic.FrameLayer HamiltonsCubic.L224Norm

variable {n : ℕ} {j k : Fin n}

theorem vy_smul (j k : Fin n) (t : ℝ) (z : Fin n → ℝ) : vy j k (t • z) = t • vy j k z := by
  funext i; simp only [vy, Pi.smul_apply, smul_eq_mul]; split_ifs <;> ring

theorem Gy_smul (j k : Fin n) (t : ℝ) (z : Fin n → ℝ) : Gy j k (t • z) = (t ^ 2) • Gy j k z := by
  have hs : ∑ c, t * vy j k z c * (t * vy j k z c) = t ^ 2 * ∑ c, vy j k z c * vy j k z c := by
    rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun c _ => by ring
  ext p q
  simp only [Gy, vy_smul, Matrix.add_apply, Matrix.smul_apply, Matrix.vecMulVec_apply, Pi.smul_apply, smul_eq_mul]
  rw [hs]
  ring

/-- The record's quadratic form `q_E(z) = ⟨E, G_z⟩`. -/
noncomputable def qE (j k : Fin n) (E : CurvOp2 (Fin n)) (z : Fin n → ℝ) : ℝ := innerOp2 E (coordOp (Gy j k z))

theorem qE_smul (E : CurvOp2 (Fin n)) (t : ℝ) (z : Fin n → ℝ) : qE j k E (t • z) = t ^ 2 * qE j k E z := by
  unfold qE; rw [Gy_smul, coordOp_smul', innerOp2_smul_right]

theorem qE_zero (E : CurvOp2 (Fin n)) : qE j k E 0 = 0 := by
  have h := qE_smul (j := j) (k := k) E 0 0
  rw [zero_smul] at h; rw [h]; ring

theorem continuous_qE (E : CurvOp2 (Fin n)) : Continuous (qE j k E) := by
  let cL : Matrix (Fin n) (Fin n) ℝ →ₗ[ℝ] CurvOp2 (Fin n) :=
    { toFun := coordOp, map_add' := coordOp_add, map_smul' := fun c a => coordOp_smul' c a }
  let iL : CurvOp2 (Fin n) →ₗ[ℝ] ℝ :=
    { toFun := innerOp2 E, map_add' := innerOp2_add_right E, map_smul' := fun c B => by
        rw [innerOp2_smul_right]; rfl }
  have hc : Continuous cL :=
    LinearMap.continuous_of_finiteDimensional (𝕜 := ℝ) (E := Matrix (Fin n) (Fin n) ℝ) (F' := CurvOp2 (Fin n)) cL
  have hi : Continuous iL := LinearMap.continuous_of_finiteDimensional (𝕜 := ℝ) (E := CurvOp2 (Fin n)) (F' := ℝ) iL
  have hv : Continuous fun z : Fin n → ℝ => vy j k z := continuous_pi fun i => by
    unfold vy; split_ifs
    · exact continuous_const
    · exact continuous_apply i
  have hG : Continuous fun z : Fin n → ℝ => Gy j k z := by
    unfold Gy
    refine Continuous.add (Continuous.add (Continuous.add ?_ ?_) ?_) ?_
    · exact continuous_pi fun p => continuous_pi fun q => by
        simp only [Matrix.vecMulVec_apply]
        exact continuous_const.mul (((continuous_apply q).comp hv).mul ((continuous_apply q).comp hv))
    · exact continuous_pi fun p => continuous_pi fun q => by
        simp only [Matrix.vecMulVec_apply]
        exact (((continuous_apply p).comp hv).mul ((continuous_apply p).comp hv)).mul continuous_const
    · exact (continuous_finsetSum _ fun c _ => ((continuous_apply c).comp hv).mul ((continuous_apply c).comp hv)).smul
        continuous_const
    · have hvv : Continuous fun z : Fin n → ℝ => vecMulVec (vy j k z) (vy j k z) :=
        continuous_pi fun p => continuous_pi fun q => by
          simp only [Matrix.vecMulVec_apply]
          exact ((continuous_apply p).comp hv).mul ((continuous_apply q).comp hv)
      exact hvv.const_smul (∑ c, uj j k c * uj j k c)
  exact (hi.comp hc).comp hG

/-- **A maximiser of `q_E` on the unit sphere of the plane `z_j = z_k = 0`, `Σ z = 0`**, bounding `q_E` by homogeneity. -/
theorem exists_qE_max (E : CurvOp2 (Fin n))
    (hne : ∃ z : Fin n → ℝ, z j = 0 ∧ z k = 0 ∧ ∑ i, z i = 0 ∧ ∑ i, z i ^ 2 = 1) :
    ∃ z₁ : Fin n → ℝ, z₁ j = 0 ∧ z₁ k = 0 ∧ ∑ i, z₁ i = 0 ∧ ∑ i, z₁ i ^ 2 = 1 ∧
      ∀ z : Fin n → ℝ, z j = 0 → z k = 0 → ∑ i, z i = 0 → qE j k E z ≤ (∑ i, z i ^ 2) * qE j k E z₁ := by
  set S : Set (Fin n → ℝ) := {z | z j = 0 ∧ z k = 0 ∧ ∑ i, z i = 0 ∧ ∑ i, z i ^ 2 = 1} with hSdef
  have hSc : IsCompact S := by
    apply Metric.isCompact_of_isClosed_isBounded
    · refine IsClosed.inter (isClosed_eq (continuous_apply j) continuous_const)
        (IsClosed.inter (isClosed_eq (continuous_apply k) continuous_const)
          (IsClosed.inter (isClosed_eq (continuous_finsetSum _ fun i _ => continuous_apply i) continuous_const)
            (isClosed_eq (continuous_finsetSum _ fun i _ => (continuous_apply i).pow 2) continuous_const)))
    · refine (Metric.isBounded_iff_subset_closedBall 0).mpr ⟨1, fun z hz => ?_⟩
      rw [mem_closedBall_zero_iff, pi_norm_le_iff_of_nonneg zero_le_one]
      intro i
      have h1 : z i ^ 2 ≤ ∑ c, z c ^ 2 :=
        Finset.single_le_sum (f := fun c => z c ^ 2) (fun c _ => sq_nonneg (z c)) (Finset.mem_univ i)
      rw [hz.2.2.2] at h1
      rw [Real.norm_eq_abs, abs_le]
      constructor <;> nlinarith
  obtain ⟨z₁, hz₁, hmax⟩ := hSc.exists_isMaxOn hne (continuous_qE E).continuousOn
  refine ⟨z₁, hz₁.1, hz₁.2.1, hz₁.2.2.1, hz₁.2.2.2, fun z hzj hzk hzs => ?_⟩
  by_cases h0 : ∑ i, z i ^ 2 = 0
  · have hz : z = 0 := funext fun i =>
      pow_eq_zero_iff (two_ne_zero) |>.mp
        ((Finset.sum_eq_zero_iff_of_nonneg fun c _ => sq_nonneg (z c)).mp h0 i (Finset.mem_univ i))
    rw [h0, hz, qE_zero]; simp
  · have hpos : 0 < ∑ i, z i ^ 2 := lt_of_le_of_ne (Finset.sum_nonneg fun c _ => sq_nonneg (z c)) (Ne.symm h0)
    set r := Real.sqrt (∑ i, z i ^ 2) with hr
    have hr0 : 0 < r := Real.sqrt_pos.mpr hpos
    have hr2 : r ^ 2 = ∑ i, z i ^ 2 := Real.sq_sqrt hpos.le
    have hwS : r⁻¹ • z ∈ S := by
      refine ⟨by simp [hzj], by simp [hzk], ?_, ?_⟩
      · simp only [Pi.smul_apply, smul_eq_mul, ← Finset.mul_sum, hzs, mul_zero]
      · simp only [Pi.smul_apply, smul_eq_mul, mul_pow]
        rw [← Finset.mul_sum, ← hr2, inv_pow]
        exact inv_mul_cancel₀ (pow_ne_zero 2 hr0.ne')
    have hle := hmax hwS
    have hz : z = r • (r⁻¹ • z) := by rw [smul_smul, mul_inv_cancel₀ hr0.ne', one_smul]
    have hq : qE j k E z = r ^ 2 * qE j k E (r⁻¹ • z) := by
      conv_lhs => rw [hz]
      exact qE_smul E r _
    rw [hq, hr2]
    exact mul_le_mul_of_nonneg_left hle hpos.le

/-- **The cubic at a swap-even diagonal plus an odd part**: `P(E + D⁻_z) = P(E) + 3 q_E(z)`. -/
theorem cubic_even_odd (hjk : j ≠ k) {E : CurvOp2 (Fin n)} (hEW : IsWeyl2 E) (hE1 : SignChar (fun _ => 1) E)
    (hσE : rotR (swapM j k) E = E) (z : Fin n → ℝ) (hzs : ∑ c, vy j k z c = 0) :
    Pcubic2 (E + coordOp (Dminus j k z)) = Pcubic2 E + 3 * qE j k E z := by
  set M := coordOp (Dminus j k z) with hMdef
  have hMW : IsWeyl2 M := Dminus_weyl hjk z hzs
  have hM1 : SignChar (fun _ => 1) M := Dminus_charOne hjk z hzs
  have hσD : rotR (swapM j k) (E + M) = E - M := by
    rw [LinearMap.map_add, hσE, hMdef, Dminus_swap_odd hjk z]; module
  have h1 : (1 / 2 : ℝ) • ((E + M) + rotR (swapM j k) (E + M)) = E := by rw [hσD]; module
  have h2 : (1 / 2 : ℝ) • ((E + M) - rotR (swapM j k) (E + M)) = M := by rw [hσD]; module
  have h := L224_cubic_pair hjk (isWeyl2_add hEW hMW) isWeyl2_zero (signChar_add hE1 hM1) (L221Ops.signChar_zero _)
  rw [h1, h2, L221a.foxProd2_zero_right, foxProd2_self, hMdef, Q_Dminus] at h
  have h0 : innerOp2 E (0 : CurvOp2 (Fin n)) = 0 := by
    have e : (0 : ℝ) • (0 : CurvOp2 (Fin n)) = 0 := by ext; simp
    have := innerOp2_smul_right (0 : ℝ) E 0
    rw [e, zero_mul] at this; exact this
  have hq : Pcubic2 E + 3 * innerOp2 E (coordOp (Gy j k z)) + 3 * innerOp2 E (0 : CurvOp2 (Fin n))
      = Pcubic2 E + 3 * qE j k E z := by
    rw [h0]; unfold qE; ring
  exact (congrArg Pcubic2 (add_zero (E + coordOp (Dminus j k z))).symm).trans (h.trans hq)

/-- **L224 (4) on the operators**: every `D + ν` on `𝒮_jk` has a Weyl `W'` of character `1` with `‖W'‖ = ‖D + ν‖` and
`P(D + ν) ≤ P(W')`, namely `W' = E + D⁻_{√s z₊}`. -/
theorem L224_step4 (hjk : j ≠ k) {D ν : CurvOp2 (Fin n)} (hDW : IsWeyl2 D) (hνW : IsWeyl2 ν)
    (hD : SignChar (fun _ => 1) D) (hν : SignChar (setChar {j, k}) ν) :
    ∃ W' : CurvOp2 (Fin n), IsWeyl2 W' ∧ SignChar (fun _ => 1) W' ∧ normSq2 W' = normSq2 (D + ν) ∧
      Pcubic2 (D + ν) ≤ Pcubic2 W' := by
  obtain ⟨y, x, hyj, hyk, hy, hxj, hxk, hx, hM, hνx, hnorm⟩ := L224_norm hjk hDW hνW hD hν
  have hσ := swapM_orth j k
  have hσDW : IsWeyl2 (rotR (swapM j k) D) := rotR_isWeyl2 hσ hDW
  have hσD1 : SignChar (fun _ => 1) (rotR (swapM j k) D) := signChar_rotR_swap j k hD fun _ _ => rfl
  set E : CurvOp2 (Fin n) := (1 / 2 : ℝ) • (D + rotR (swapM j k) D) with hEdef
  have hEW : IsWeyl2 E := isWeyl2_smul _ (isWeyl2_add hDW hσDW)
  have hE1 : SignChar (fun _ => 1) E := signChar_smul (signChar_add hD hσD1) _
  have hσσ : rotR (swapM j k) (rotR (swapM j k) D) = D := by
    rw [L219GenOps.rotR_comp, swapM_sq, L219GenOps.rotR_one]
  have hσE : rotR (swapM j k) E = E := by
    rw [hEdef, LinearMap.map_smul, LinearMap.map_add, hσσ]; module
  have hvy : vy j k y = y := vy_of_zero y hyj hyk
  have hvx : vy j k x = x := vy_of_zero x hxj hxk
  -- the cubic in coordinates
  have hcub : Pcubic2 (D + ν) = Pcubic2 E + 3 * qE j k E y + 3 * qE j k E x := by
    have h := L224_cubic_pair hjk hDW hνW hD hν
    have hQν : Qop2 ν = coordOp (Gy j k x) := by rw [hνx]; exact Q_nuX hjk x (by rw [hvx]; exact hx)
    rw [foxProd2_self, foxProd2_self, hM, Q_Dminus, hQν] at h
    rw [h]; unfold qE; rfl
  set s := ∑ c, y c ^ 2 + ∑ c, x c ^ 2 with hsdef
  have hs0 : 0 ≤ s := add_nonneg (Finset.sum_nonneg fun c _ => sq_nonneg (y c)) (Finset.sum_nonneg fun c _ => sq_nonneg (x c))
  by_cases hs : s = 0
  · -- `y = x = 0`, and `W' = E`
    have hy2 : ∑ c, y c ^ 2 = 0 := by
      have := Finset.sum_nonneg fun c (_ : c ∈ Finset.univ) => sq_nonneg (y c)
      have := Finset.sum_nonneg fun c (_ : c ∈ Finset.univ) => sq_nonneg (x c)
      linarith
    have hx2 : ∑ c, x c ^ 2 = 0 := by
      have := Finset.sum_nonneg fun c (_ : c ∈ Finset.univ) => sq_nonneg (y c)
      linarith
    have hy0 : y = 0 := funext fun i => pow_eq_zero_iff two_ne_zero |>.mp
      ((Finset.sum_eq_zero_iff_of_nonneg fun c _ => sq_nonneg (y c)).mp hy2 i (Finset.mem_univ i))
    have hx0 : x = 0 := funext fun i => pow_eq_zero_iff two_ne_zero |>.mp
      ((Finset.sum_eq_zero_iff_of_nonneg fun c _ => sq_nonneg (x c)).mp hx2 i (Finset.mem_univ i))
    refine ⟨E, hEW, hE1, by rw [hnorm, hs]; ring, ?_⟩
    rw [hcub, hy0, hx0, qE_zero]; linarith
  · have hspos : 0 < s := lt_of_le_of_ne hs0 (Ne.symm hs)
    -- a unit vector in the plane, from `y` or `x`
    have hne : ∃ z : Fin n → ℝ, z j = 0 ∧ z k = 0 ∧ ∑ i, z i = 0 ∧ ∑ i, z i ^ 2 = 1 := by
      have key : ∀ w : Fin n → ℝ, w j = 0 → w k = 0 → ∑ i, w i = 0 → 0 < ∑ i, w i ^ 2 →
          ∃ z : Fin n → ℝ, z j = 0 ∧ z k = 0 ∧ ∑ i, z i = 0 ∧ ∑ i, z i ^ 2 = 1 := by
        intro w hwj hwk hws hwp
        refine ⟨(Real.sqrt (∑ i, w i ^ 2))⁻¹ • w, by simp [hwj], by simp [hwk], ?_, ?_⟩
        · simp only [Pi.smul_apply, smul_eq_mul, ← Finset.mul_sum, hws, mul_zero]
        · simp only [Pi.smul_apply, smul_eq_mul, mul_pow]
          rw [← Finset.mul_sum, inv_pow, Real.sq_sqrt hwp.le]
          exact inv_mul_cancel₀ hwp.ne'
      by_cases hy2 : ∑ c, y c ^ 2 = 0
      · have hx2 : 0 < ∑ c, x c ^ 2 := by
          have := Finset.sum_nonneg fun c (_ : c ∈ Finset.univ) => sq_nonneg (x c)
          rcases this.lt_or_eq with h | h
          · exact h
          · exfalso; apply hs; rw [hsdef, hy2, ← h]; ring
        exact key x hxj hxk hx hx2
      · exact key y hyj hyk hy (lt_of_le_of_ne (Finset.sum_nonneg fun c _ => sq_nonneg (y c)) (Ne.symm hy2))
    obtain ⟨z₁, hz₁j, hz₁k, hz₁s, hz₁n, hbound⟩ := exists_qE_max (j := j) (k := k) E hne
    set zs : Fin n → ℝ := Real.sqrt s • z₁ with hzsdef
    have hzsj : zs j = 0 := by simp [hzsdef, hz₁j]
    have hzsk : zs k = 0 := by simp [hzsdef, hz₁k]
    have hzss : ∑ c, vy j k zs c = 0 := by
      rw [vy_of_zero zs hzsj hzsk]
      simp only [hzsdef, Pi.smul_apply, smul_eq_mul, ← Finset.mul_sum, hz₁s, mul_zero]
    have hzsn : ∑ c, zs c ^ 2 = s := by
      simp only [hzsdef, Pi.smul_apply, smul_eq_mul, mul_pow]
      rw [← Finset.mul_sum, hz₁n, Real.sq_sqrt hs0, mul_one]
    set M' := coordOp (Dminus j k zs) with hM'def
    have hM'W : IsWeyl2 M' := Dminus_weyl hjk zs hzss
    have hM'1 : SignChar (fun _ => 1) M' := Dminus_charOne hjk zs hzss
    have hEM' : innerOp2 E M' = 0 := by
      refine inner_flip_zero hσ hEW hM'W hσE ?_
      rw [hM'def, Dminus_swap_odd hjk zs]; module
    refine ⟨E + M', isWeyl2_add hEW hM'W, signChar_add hE1 hM'1, ?_, ?_⟩
    · rw [hnorm]
      unfold normSq2
      rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, innerOp2_comm M' E, hEM']
      have hnM' : innerOp2 M' M' = 2 * s := by
        have := normSq2_Dminus hjk zs
        unfold normSq2 at this
        rw [← hM'def] at this
        rw [this, vy_of_zero zs hzsj hzsk, hzsn]
      rw [hnM']; ring
    · rw [hcub, cubic_even_odd hjk hEW hE1 hσE zs hzss]
      have hqy := hbound y hyj hyk hy
      have hqx := hbound x hxj hxk hx
      have hqz : qE j k E zs = s * qE j k E z₁ := by
        rw [hzsdef, qE_smul, Real.sq_sqrt hs0]
      rw [hqz]
      have : qE j k E y + qE j k E x ≤ s * qE j k E z₁ := by
        rw [hsdef, add_mul]; linarith
      linarith

end HamiltonsCubic.L224Step4
