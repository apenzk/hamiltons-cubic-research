import Mathlib
import HamiltonsCubic.Results.L224Line

set_option linter.style.longLine false

/-!
# L224 step 5 at odd `n`: at equality with `s > 0`, `y` and `x` lie on one line

[findings/second-order.md](../../../findings/second-order.md), Lemma L224, step 5, as in [L224Line.lean](L224Line.lean) for even $n$.
At odd $n$ L57's maximiser is $w=t\,Z'(v)$ with $v$ two-valued (`charOne_eq_odd`); the nonzero odd part of $W'$ forces $v_j\ne v_k$, so
$v$ takes exactly the values $v_j,v_k$ and `inner_Zp_Gy_two` gives $q_E=t\langle v,\cdot\rangle^2$ on the plane. The line is that of
$\bar u$, the projection of $v$ onto the plane: $v$ read off $\{j,k\}$ minus its mean there.

* **`L224_line_odd`**: at $P(D+\nu)=\Theta_n\lVert D+\nu\rVert^3$, odd $n\ge5$, either $y=x=0$, or $y$ and $x$ are both multiples of
  one $\bar u\ne0$ in the plane.
-/

namespace HamiltonsCubic.L224LineOdd

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.I117S HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.PairIdent HamiltonsCubic.L222Swap
  HamiltonsCubic.OddPart HamiltonsCubic.L224Cubic HamiltonsCubic.FrameOp2 HamiltonsCubic.L222Op HamiltonsCubic.L120Blocks
  HamiltonsCubic.PairNorm HamiltonsCubic.FrameLayer HamiltonsCubic.L224Norm HamiltonsCubic.L224Step4 HamiltonsCubic.L224Bound
  HamiltonsCubic.FamilyLayer HamiltonsCubic.L224Eq HamiltonsCubic.L57Bridge HamiltonsCubic.L224Rank HamiltonsCubic.L57Critical
  HamiltonsCubic.ItemFour HamiltonsCubic.L224Line

variable {n : ℕ} {j k : Fin n}

/-- **L224 (5) at odd `n`, the line**: at `P(D + ν) = Θ_n‖D + ν‖³`, either `y = x = 0`, or `y`, `x` are multiples of one
`ū ≠ 0` in the plane, `ū` the projection of `v` onto it. -/
theorem L224_line_odd (hn : 5 ≤ n) (hodd : ¬ Even n) (hjk : j ≠ k) {D ν : CurvOp2 (Fin n)} (hDW : IsWeyl2 D) (hνW : IsWeyl2 ν)
    (hD : SignChar (fun _ => 1) D) (hν : SignChar (setChar {j, k}) ν)
    (heq : Pcubic2 (D + ν) = Real.sqrt (thetaOddSq (n : ℝ)) * Real.sqrt (normSq2 (D + ν)) ^ 3) :
    ∃ y x : Fin n → ℝ, y j = 0 ∧ y k = 0 ∧ ∑ i, y i = 0 ∧ x j = 0 ∧ x k = 0 ∧ ∑ i, x i = 0 ∧
      (1 / 2 : ℝ) • (D - rotR (swapM j k) D) = coordOp (Dminus j k y) ∧ ν = nuX j k x ∧
      ((y = 0 ∧ x = 0) ∨
        (∃ ub : Fin n → ℝ, ub j = 0 ∧ ub k = 0 ∧ ∑ i, ub i = 0 ∧ 0 < ∑ i, ub i ^ 2 ∧
          (∀ l, y l = ((∑ i, ub i * y i) / (∑ i, ub i ^ 2)) * ub l) ∧
          (∀ l, x l = ((∑ i, ub i * x i) / (∑ i, ub i ^ 2)) * ub l))) := by
  obtain ⟨y, x, hyj, hyk, hy, hxj, hxk, hx, hM, hνx, hcase⟩ :=
    L224_eq_tight (thetaOdd_pos hn) (L57_odd hn hodd) hjk hDW hνW hD hν heq
  refine ⟨y, x, hyj, hyk, hy, hxj, hxk, hx, hM, hνx, ?_⟩
  rcases hcase with h0 | ⟨z₁, hz₁j, hz₁k, hz₁s, hz₁n, hspos, hbound, hlam, hqy, hqx, hPW'⟩
  · exact Or.inl h0
  right
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
  set s := ∑ i, y i ^ 2 + ∑ i, x i ^ 2 with hsdef
  set zs : Fin n → ℝ := Real.sqrt s • z₁ with hzsdef
  have hzsj : zs j = 0 := by simp [hzsdef, hz₁j]
  have hzsk : zs k = 0 := by simp [hzsdef, hz₁k]
  have hzss : ∑ c, vy j k zs c = 0 := by
    rw [vy_of_zero zs hzsj hzsk]
    simp only [hzsdef, Pi.smul_apply, smul_eq_mul, ← Finset.mul_sum, hz₁s, mul_zero]
  have hzsn : ∑ c, zs c ^ 2 = s := by
    simp only [hzsdef, Pi.smul_apply, smul_eq_mul, mul_pow]
    rw [← Finset.mul_sum, hz₁n, Real.sq_sqrt hspos.le, mul_one]
  set M' := coordOp (Dminus j k zs) with hM'def
  have hM'W : IsWeyl2 M' := Dminus_weyl hjk zs hzss
  have hM'1 : SignChar (fun _ => 1) M' := Dminus_charOne hjk zs hzss
  have hσM' : rotR (swapM j k) M' = -M' := by rw [hM'def, Dminus_swap_odd hjk zs]
  have hEM' : innerOp2 E M' = 0 := inner_flip_zero hσ hEW hM'W hσE (by rw [hσM']; module)
  have hnM' : normSq2 M' = 2 * s := by
    rw [hM'def, normSq2_Dminus hjk, vy_of_zero zs hzsj hzsk, hzsn]
  have hne : normSq2 (E + M') ≠ 0 := by
    have hE0 := normSq2_nonneg E
    have e : normSq2 (E + M') = normSq2 E + normSq2 M' := by
      unfold normSq2
      rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, innerOp2_comm M' E, hEM']; ring
    rw [e, hnM']; linarith
  -- `W'` is an L57 maximiser
  obtain ⟨w, hw, hW'r, v, t, a0, b0, ht, hvs, hv2, hab, hvab, hcard, hwZ⟩ :=
    charOne_eq_odd hn hodd (isWeyl2_add hEW hM'W) (signChar_add hE1 hM'1) hne hPW'
  have hwT : wᵀ = w := by ext a b; rw [Matrix.transpose_apply, hw.symm]
  have hW'c : E + M' = coordOp w := by rw [hW'r, coordOp_eq_restrict hw]
  have hwof : w = Matrix.of fun a b => t * Zp v (n : ℝ) a b := by ext a b; rw [hwZ]; rfl
  -- `v_j ≠ v_k`, from the nonzero odd part
  have hvne : v j ≠ v k := by
    have hsT : (Matrix.of fun p q => w (Equiv.swap j k p) (Equiv.swap j k q))ᵀ
        = Matrix.of fun p q => w (Equiv.swap j k p) (Equiv.swap j k q) := by
      ext p q; simp only [Matrix.transpose_apply, Matrix.of_apply]; exact hw.symm _ _
    have hσW' : rotR (swapM j k) (E + M') = E - M' := by
      rw [LinearMap.map_add, hσE, hσM']; module
    have hodd : M' = coordOp ((1 / 2 : ℝ) • (w - Matrix.of fun p q => w (Equiv.swap j k p) (Equiv.swap j k q))) := by
      rw [coordOp_smul', coordOp_sub, ← rotR_swap_coordOp j k w hwT, ← hW'c, hσW']
      module
    have hoT : ((1 / 2 : ℝ) • (w - Matrix.of fun p q => w (Equiv.swap j k p) (Equiv.swap j k q)))ᵀ
        = (1 / 2 : ℝ) • (w - Matrix.of fun p q => w (Equiv.swap j k p) (Equiv.swap j k q)) := by
      rw [Matrix.transpose_smul, Matrix.transpose_sub, hwT, hsT]
    have hDT : (Dminus j k zs)ᵀ = Dminus j k zs := vv_sym _ _
    intro hvjeq
    -- then `zs = 0`
    have hz0 : ∀ a, zs a = 0 := by
      intro a
      by_cases haj : a = j
      · rw [haj, hzsj]
      by_cases hak : a = k
      · rw [hak, hzsk]
      have e := coordOp_weight_eq hDT hoT (hM'def ▸ hodd) (Ne.symm haj)
      simp only [Dminus, Matrix.add_apply, Matrix.vecMulVec_apply, vy_of_zero zs hzsj hzsk, uj,
        if_neg haj, if_neg hak, hzsj, Matrix.smul_apply, Matrix.sub_apply, Matrix.of_apply, Equiv.swap_apply_left,
        Equiv.swap_apply_of_ne_of_ne haj hak, smul_eq_mul, hwZ, Zp, if_neg (Ne.symm haj),
        if_neg (show k ≠ a from fun h => hak h.symm)] at e
      rw [hvjeq] at e
      norm_num at e
      linarith
    have : ∑ c, zs c ^ 2 = 0 := Finset.sum_eq_zero fun c _ => by rw [hz0 c]; ring
    linarith
  -- `v` takes only the values `v_j`, `v_k`
  have h2 : ∀ p, (v p - v j) * (v p - v k) = 0 := by
    intro p
    rcases hvab p with hp | hp <;> rcases hvab j with hj | hj <;> rcases hvab k with hk | hk <;>
      first
      | (exfalso; exact hvne (hj.trans hk.symm))
      | (rw [hp, hj, hk]; ring1)
  -- `q_E(z) = t⟨ū, z⟩²` on the plane, `ū` the projection of `v` onto it
  have hdecomp : ∀ f : Fin n → ℝ, ∑ i, f i = ∑ i, vy j k f i + f j + f k := by
    intro f
    have e : ∀ i, f i = vy j k f i + (if i = j then f j else 0) + (if i = k then f k else 0) := by
      intro i
      by_cases h1 : i = j
      · subst h1; simp [vy, hjk]
      · by_cases h2 : i = k
        · subst h2; simp [vy, h1]
        · simp [vy, h1, h2]
    have := Finset.sum_congr rfl fun i (_ : i ∈ Finset.univ) => e i
    rw [Finset.sum_add_distrib, Finset.sum_add_distrib, Finset.sum_ite_eq', Finset.sum_ite_eq'] at this
    simp only [Finset.mem_univ, if_true] at this
    exact this
  have hn2 : ((n : ℝ) - 2) ≠ 0 := by
    have : (5 : ℝ) ≤ n := by exact_mod_cast hn
    linarith
  have hind : ∑ i, vy j k (fun _ => (1 : ℝ)) i = (n : ℝ) - 2 := by
    have := hdecomp (fun _ => (1 : ℝ))
    simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul, mul_one] at this
    linarith
  set m : ℝ := (∑ i, vy j k v i) / ((n : ℝ) - 2) with hm
  set ub : Fin n → ℝ := fun i => vy j k v i - m * vy j k (fun _ => (1 : ℝ)) i with hubdef
  have hubj : ub j = 0 := by simp [hubdef, vy]
  have hubk : ub k = 0 := by simp [hubdef, vy]
  have hvzz : ∀ (f z : Fin n → ℝ), z j = 0 → z k = 0 → ∑ a, f a * z a = ∑ a, vy j k f a * z a := by
    intro f z hzj hzk
    refine Finset.sum_congr rfl fun a _ => ?_
    by_cases h : a = j ∨ a = k
    · rcases h with h | h <;> rw [h] <;> simp [hzj, hzk]
    · simp only [vy, if_neg h]
  have hvu : ∀ z : Fin n → ℝ, z j = 0 → z k = 0 → ∑ i, z i = 0 → ∑ a, v a * z a = ∑ a, ub a * z a := by
    intro z hzj hzk hzs
    have h1 : ∑ a, vy j k (fun _ => (1 : ℝ)) a * z a = 0 := by
      rw [← hvzz (fun _ => (1 : ℝ)) z hzj hzk]; simp only [one_mul]; exact hzs
    have : ∑ a, ub a * z a = ∑ a, vy j k v a * z a - m * ∑ a, vy j k (fun _ => (1 : ℝ)) a * z a := by
      rw [Finset.mul_sum, ← Finset.sum_sub_distrib]
      exact Finset.sum_congr rfl fun a _ => by simp only [hubdef]; ring
    rw [this, h1, mul_zero, sub_zero, hvzz v z hzj hzk]
  have hubs : ∑ i, ub i = 0 := by
    have : ∑ i, ub i = ∑ i, vy j k v i - m * ∑ i, vy j k (fun _ => (1 : ℝ)) i := by
      rw [Finset.mul_sum, ← Finset.sum_sub_distrib]
    rw [this, hind, hm, div_mul_cancel₀ _ hn2, sub_self]
  have hq : ∀ z : Fin n → ℝ, z j = 0 → z k = 0 → ∑ i, z i = 0 → qE j k E z = t * (∑ a, ub a * z a) ^ 2 := by
    intro z hzj hzk hzs
    have hGW : IsWeyl2 (coordOp (Gy j k z)) := by
      rw [← Q_Dminus]; exact isWeyl2_Qop2 (Dminus_weyl hjk z (by rw [vy_of_zero z hzj hzk]; exact hzs))
    have h0 : innerOp2 (coordOp (Gy j k z)) M' = 0 := inner_flip_zero hσ hGW hM'W (Gy_swap hjk z) (by rw [hσM']; module)
    have hsplit : innerOp2 (E + M') (coordOp (Gy j k z)) = qE j k E z := by
      unfold qE; rw [innerOp2_add_left, innerOp2_comm M', h0, add_zero]
    rw [← hsplit, hW'c, hwof, inner_Zp_Gy_two hjk v h2 t z hzj hzk hzs, hvu z hzj hzk hzs]
  -- `λ = t‖ū‖²` and `‖ū‖ > 0`
  set A := ∑ i, ub i ^ 2 with hA
  have hqub : qE j k E ub = t * A ^ 2 := by
    rw [hq ub hubj hubk hubs]; congr 1; rw [hA]; congr 1; exact Finset.sum_congr rfl fun i _ => by ring
  have hApos : 0 < A := by
    rcases (Finset.sum_nonneg fun c (_ : c ∈ Finset.univ) => sq_nonneg (ub c)).lt_or_eq with h | h
    · exact h
    · exfalso
      have hz : ∀ c, ub c = 0 := fun c => pow_eq_zero_iff two_ne_zero |>.mp
        ((Finset.sum_eq_zero_iff_of_nonneg fun c _ => sq_nonneg (ub c)).mp h.symm c (Finset.mem_univ c))
      have := hq z₁ hz₁j hz₁k hz₁s
      simp only [hz, zero_mul, Finset.sum_const_zero] at this
      linarith
  have hlamle : qE j k E z₁ ≤ t * A := by
    rw [hq z₁ hz₁j hz₁k hz₁s]
    have := cs_le ub z₁
    rw [hz₁n, mul_one] at this
    exact mul_le_mul_of_nonneg_left this ht.le
  have hlamge : t * A ≤ qE j k E z₁ := by
    have h1 := hbound ub hubj hubk hubs
    rw [hqub] at h1
    have h2 : A * (t * A) ≤ A * qE j k E z₁ := by rw [show A * (t * A) = t * A ^ 2 by ring]; exact h1
    exact le_of_mul_le_mul_left h2 hApos
  have hlamv : qE j k E z₁ = t * A := le_antisymm hlamle hlamge
  have hline : ∀ w' : Fin n → ℝ, w' j = 0 → w' k = 0 → ∑ i, w' i = 0 →
      qE j k E w' = (∑ i, w' i ^ 2) * qE j k E z₁ →
      ∀ l, w' l = ((∑ i, ub i * w' i) / A) * ub l := by
    intro w' hwj hwk hws hqw
    apply cs_eq ub w' hApos
    rw [hq w' hwj hwk hws, hlamv] at hqw
    have := ht.ne'
    have : (∑ i, ub i * w' i) ^ 2 = A * ∑ i, w' i ^ 2 := by
      have h2 : t * ((∑ i, ub i * w' i) ^ 2 - A * ∑ i, w' i ^ 2) = 0 := by linarith
      rcases mul_eq_zero.mp h2 with h | h
      · exact absurd h ht.ne'
      · linarith
    exact this
  exact ⟨ub, hubj, hubk, hubs, hApos, hline y hyj hyk hy hqy, hline x hxj hxk hx hqx⟩

end HamiltonsCubic.L224LineOdd
