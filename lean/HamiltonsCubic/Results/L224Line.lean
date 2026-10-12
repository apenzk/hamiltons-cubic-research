import Mathlib
import HamiltonsCubic.Results.L224Rank

set_option linter.style.longLine false

/-!
# L224 step 5 at even `n`: at equality with `s > 0`, `y` and `x` lie on one line

[findings/second-order.md](../../../findings/second-order.md), Lemma L224, step 5: *$W'$ is an L57 maximiser $B'$ with swap-even part $E$
and nonzero odd part, so $j$ and $k$ lie in different blocks … On $\{\sum z=0\}$ this is $c\langle\bar u,z\rangle^2$ with $\bar u$ the
centred indicator of $A'$, so $\lambda=c\lVert\bar u\rVert^2>0$ has the line of $\bar u$ as its whole eigenspace, and both $y$ and $x$
lie on it.* Here $\bar u$ is $v$ read off $\{j,k\}$, which already sums to zero once $v_j=-v_k$.

* `lagrange`, `cs_le`, `cs_eq`: Lagrange's identity and the equality case of Cauchy-Schwarz for finite sums;
* **`L224_line_even`**: at $P(D+\nu)=\theta_0(n)\lVert D+\nu\rVert^3$, either $y=x=0$, or $n$ is even and there is $\bar u\ne0$ in the
  plane with $y$ and $x$ both multiples of $\bar u$.
-/

namespace HamiltonsCubic.L224Line

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.I117S HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.PairIdent HamiltonsCubic.L222Swap
  HamiltonsCubic.OddPart HamiltonsCubic.L224Cubic HamiltonsCubic.FrameOp2 HamiltonsCubic.L222Op HamiltonsCubic.L120Blocks
  HamiltonsCubic.PairNorm HamiltonsCubic.FrameLayer HamiltonsCubic.L224Norm HamiltonsCubic.L224Step4 HamiltonsCubic.L224Bound
  HamiltonsCubic.FamilyLayer HamiltonsCubic.L224Eq HamiltonsCubic.L57Bridge HamiltonsCubic.L224Rank HamiltonsCubic.L57Critical
  HamiltonsCubic.ItemFour

variable {n : ℕ} {j k : Fin n}

/-- **Lagrange's identity.** -/
theorem lagrange (a y : Fin n → ℝ) :
    (∑ i, a i ^ 2) * (∑ i, y i ^ 2) - (∑ i, a i * y i) ^ 2 = (1 / 2) * ∑ i, ∑ l, (a i * y l - a l * y i) ^ 2 := by
  have e : ∀ i l, (a i * y l - a l * y i) ^ 2
      = a i ^ 2 * y l ^ 2 + a l ^ 2 * y i ^ 2 - 2 * ((a i * y i) * (a l * y l)) := fun i l => by ring
  simp only [e, Finset.sum_sub_distrib, Finset.sum_add_distrib, ← Finset.mul_sum, ← Finset.sum_mul]
  ring

theorem cs_le (a y : Fin n → ℝ) : (∑ i, a i * y i) ^ 2 ≤ (∑ i, a i ^ 2) * (∑ i, y i ^ 2) := by
  have h := lagrange a y
  have h0 : 0 ≤ ∑ i, ∑ l, (a i * y l - a l * y i) ^ 2 :=
    Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun l _ => sq_nonneg _
  linarith

/-- **The equality case of Cauchy-Schwarz**: `y` is a multiple of `a`. -/
theorem cs_eq (a y : Fin n → ℝ) (hA : 0 < ∑ i, a i ^ 2)
    (h : (∑ i, a i * y i) ^ 2 = (∑ i, a i ^ 2) * (∑ i, y i ^ 2)) :
    ∀ l, y l = ((∑ i, a i * y i) / (∑ i, a i ^ 2)) * a l := by
  have hl := lagrange a y
  rw [h, sub_self] at hl
  have h0 : ∑ i, ∑ l, (a i * y l - a l * y i) ^ 2 = 0 := by linarith
  have hterm : ∀ i l, a i * y l = a l * y i := by
    intro i l
    have h1 := (Finset.sum_eq_zero_iff_of_nonneg fun i _ => Finset.sum_nonneg fun l _ => sq_nonneg
      (a i * y l - a l * y i)).mp h0 i (Finset.mem_univ i)
    have h2 := (Finset.sum_eq_zero_iff_of_nonneg fun l _ => sq_nonneg (a i * y l - a l * y i)).mp h1 l
      (Finset.mem_univ l)
    have := pow_eq_zero_iff (n := 2) (by norm_num) |>.mp h2
    linarith
  intro l
  have key : y l * ∑ i, a i ^ 2 = a l * ∑ i, a i * y i := by
    rw [Finset.mul_sum, Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [show y l * a i ^ 2 = a i * (a i * y l) by ring, hterm i l]; ring
  rw [div_mul_eq_mul_div, eq_div_iff hA.ne']
  linarith

/-- **L224 (5) at even `n`, the line**: at `P(D + ν) = θ₀(n)‖D + ν‖³`, either `y = x = 0`, or `n` is even and `y`, `x` are
multiples of one `ū ≠ 0` in the plane. -/
theorem L224_line_even (hn : 4 ≤ n) (hjk : j ≠ k) {D ν : CurvOp2 (Fin n)} (hDW : IsWeyl2 D) (hνW : IsWeyl2 ν)
    (hD : SignChar (fun _ => 1) D) (hν : SignChar (setChar {j, k}) ν)
    (heq : Pcubic2 (D + ν) = Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / (n : ℝ) * Real.sqrt (normSq2 (D + ν)) ^ 3) :
    ∃ y x : Fin n → ℝ, y j = 0 ∧ y k = 0 ∧ ∑ i, y i = 0 ∧ x j = 0 ∧ x k = 0 ∧ ∑ i, x i = 0 ∧
      (1 / 2 : ℝ) • (D - rotR (swapM j k) D) = coordOp (Dminus j k y) ∧ ν = nuX j k x ∧
      ((y = 0 ∧ x = 0) ∨
        (Even n ∧ ∃ ub : Fin n → ℝ, ub j = 0 ∧ ub k = 0 ∧ ∑ i, ub i = 0 ∧ 0 < ∑ i, ub i ^ 2 ∧
          (∀ l, y l = ((∑ i, ub i * y i) / (∑ i, ub i ^ 2)) * ub l) ∧
          (∀ l, x l = ((∑ i, ub i * x i) / (∑ i, ub i ^ 2)) * ub l))) := by
  obtain ⟨y, x, hyj, hyk, hy, hxj, hxk, hx, hM, hνx, hcase⟩ :=
    L224_eq_tight (theta0_pos hn) (L57_even hn) hjk hDW hνW hD hν heq
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
  obtain ⟨w, hw, hW'r, ⟨v, t, ht, hv2, hvs, hwZ⟩, hev⟩ :=
    charOne_eq_even hn (isWeyl2_add hEW hM'W) (signChar_add hE1 hM'1) hne hPW'
  refine ⟨hev, ?_⟩
  have hwT : wᵀ = w := by ext a b; rw [Matrix.transpose_apply, hw.symm]
  have hW'c : E + M' = coordOp w := by rw [hW'r, coordOp_eq_restrict hw]
  have hwof : w = Matrix.of fun a b => t * Zp v (n : ℝ) a b := by ext a b; rw [hwZ]; rfl
  -- `v_j + v_k = 0`, from the nonzero odd part
  have hvjk : v j + v k = 0 := by
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
    have hvjj : v j ^ 2 = v k ^ 2 := by rw [hv2, hv2]
    by_contra hne0
    have hvjeq : v j = v k := by
      have : (v j - v k) * (v j + v k) = 0 := by ring_nf; linarith
      rcases mul_eq_zero.mp this with h | h
      · linarith
      · exact absurd h hne0
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
  -- `q_E(z) = t⟨ū, z⟩²` on the plane, `ū = v` off `{j, k}`
  set ub := vy j k v with hubdef
  have hubj : ub j = 0 := by simp [hubdef, vy]
  have hubk : ub k = 0 := by simp [hubdef, vy]
  have hvu : ∀ z : Fin n → ℝ, z j = 0 → z k = 0 → ∑ a, v a * z a = ∑ a, ub a * z a := by
    intro z hzj hzk
    refine Finset.sum_congr rfl fun a _ => ?_
    by_cases h : a = j ∨ a = k
    · rcases h with h | h <;> rw [h] <;> simp [hzj, hzk]
    · simp only [hubdef, vy, if_neg h]
  have hubs : ∑ i, ub i = 0 := by
    have e : ∀ i, v i = ub i + (if i = j then v j else 0) + (if i = k then v k else 0) := by
      intro i
      by_cases h1 : i = j
      · subst h1; simp [hubdef, vy, hjk]
      · by_cases h2 : i = k
        · subst h2; simp [hubdef, vy, h1]
        · simp [hubdef, vy, h1, h2]
    have := Finset.sum_congr rfl fun i (_ : i ∈ Finset.univ) => e i
    rw [Finset.sum_add_distrib, Finset.sum_add_distrib, Finset.sum_ite_eq', Finset.sum_ite_eq', hvs] at this
    simp only [Finset.mem_univ, if_true] at this
    linarith
  have hq : ∀ z : Fin n → ℝ, z j = 0 → z k = 0 → ∑ i, z i = 0 → qE j k E z = t * (∑ a, ub a * z a) ^ 2 := by
    intro z hzj hzk hzs
    have hGW : IsWeyl2 (coordOp (Gy j k z)) := by
      rw [← Q_Dminus]; exact isWeyl2_Qop2 (Dminus_weyl hjk z (by rw [vy_of_zero z hzj hzk]; exact hzs))
    have h0 : innerOp2 (coordOp (Gy j k z)) M' = 0 := inner_flip_zero hσ hGW hM'W (Gy_swap hjk z) (by rw [hσM']; module)
    have hsplit : innerOp2 (E + M') (coordOp (Gy j k z)) = qE j k E z := by
      unfold qE; rw [innerOp2_add_left, innerOp2_comm M', h0, add_zero]
    rw [← hsplit, hW'c, hwof, inner_Zp_Gy hjk v hv2 hvjk t z hzj hzk hzs, hvu z hzj hzk]
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

end HamiltonsCubic.L224Line
