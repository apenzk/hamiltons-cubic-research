import HamiltonsCubic.Results.L178Asd

set_option linter.style.longLine false

/-!
# L178 on `ℝⁿ`: the reduction to the two families

Milestone 4 of [the L178 padding plan](../../../reviews/2026-09-26-lean-L178-padding-plan.md). The six forms
`e = (ω⁺_0, ω⁺_1, ω⁺_2, ω⁻_0, ω⁻_1, ω⁻_2)` are an orthonormal basis of `Λ²ℝ⁴ ⊂ Λ²ℝⁿ`, so an operator
supported there is `W_C = Σ_{i,j} C_{ij} ⟨·, e_i⟩ e_j` for a `6 × 6` coefficient matrix `C`.
-/

namespace HamiltonsCubic.CP2Real

open Matrix HamiltonsCubic.RealLayer

/-- The six structures, self-dual then anti-self-dual. -/
noncomputable def G : Fin 3 ⊕ Fin 3 → Matrix (Fin 4) (Fin 4) ℝ := Sum.elim J K

variable {n : ℕ}

/-- The six bivectors on `ℝⁿ`. -/
noncomputable def eF (i : Fin 3 ⊕ Fin 3) : Matrix (Fin n) (Fin n) ℝ := sq2⁻¹ • (Emb n * G i * (Emb n)ᵀ)

/-- **`W_C = Σ_{i,j} C_{ij} ⟨·, e_i⟩ e_j`**, an operator supported on `Λ²ℝ⁴`. -/
noncomputable def WC (n : ℕ) (C : Matrix (Fin 3 ⊕ Fin 3) (Fin 3 ⊕ Fin 3) ℝ) (X : Matrix (Fin n) (Fin n) ℝ) :
    Matrix (Fin n) (Fin n) ℝ :=
  ∑ i, ∑ j, (C i j * inner2 X (eF i)) • eF j

theorem G_skew (i : Fin 3 ⊕ Fin 3) : (G i)ᵀ = -(G i) := by
  cases i with
  | inl a => exact J_skew a
  | inr b => exact asdFrame.skew b

theorem eF_skew (i : Fin 3 ⊕ Fin 3) : IsSkew (eF (n := n) i) := by
  unfold IsSkew eF
  rw [Matrix.transpose_smul, Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose, G_skew]
  simp [Matrix.mul_assoc, Matrix.neg_mul, Matrix.mul_neg]

/-- The embedded coordinate `x ↦ x` of `ℝ⁴` in `ℝⁿ`. -/
def E (hn : 4 ≤ n) (x : Fin 4) : Fin n := ⟨x, lt_of_lt_of_le x.2 hn⟩

theorem Emb_E (hn : 4 ≤ n) (x y : Fin 4) : Emb n (E hn x) y = if x = y then 1 else 0 := by
  simp only [Emb, E]
  by_cases h : x = y
  · subst h; simp
  · simp [h, Fin.val_ne_of_ne h]

theorem sandwich_E (hn : 4 ≤ n) (M : Matrix (Fin 4) (Fin 4) ℝ) (x y : Fin 4) :
    (Emb n * M * (Emb n)ᵀ) (E hn x) (E hn y) = M x y := by
  simp only [Matrix.mul_apply, Matrix.transpose_apply, Emb_E]
  simp [Finset.sum_ite_eq]

theorem eF_E (hn : 4 ≤ n) (i : Fin 3 ⊕ Fin 3) (x y : Fin 4) :
    eF (n := n) i (E hn x) (E hn y) = sq2⁻¹ * G i x y := by
  rw [eF, Matrix.smul_apply, sandwich_E, smul_eq_mul]

theorem inner2_phi_eF (i : Fin 3 ⊕ Fin 3) (a c : Fin n) : inner2 (phi a c) (eF (n := n) i) = eF i c a := by
  rw [inner2_comm, inner2_phi _ (eF_skew i), HamiltonsCubic.L30Statement.skew_entry (eF_skew i)]
  ring

theorem inner2_eF_phi (j : Fin 3 ⊕ Fin 3) (b c : Fin n) : inner2 (eF (n := n) j) (phi b c) = eF j c b := by
  rw [inner2_phi _ (eF_skew j), HamiltonsCubic.L30Statement.skew_entry (eF_skew j)]
  ring

theorem WC_phi_inner (C : Matrix (Fin 3 ⊕ Fin 3) (Fin 3 ⊕ Fin 3) ℝ) (a c b d : Fin n) :
    inner2 (WC n C (phi a c)) (phi b d) = ∑ i, ∑ j, C i j * eF i c a * eF j d b := by
  unfold WC
  rw [HamiltonsCubic.L41Statement.Frame.inner2_sum_l]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [HamiltonsCubic.L41Statement.Frame.inner2_sum_l]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [HamiltonsCubic.L41Statement.Frame.inner2_smul_l, inner2_phi_eF, inner2_eF_phi]

/-- **First Bianchi of `W_C` at the embedded `(0,1,2,3)`**: `½ Σ C_{ij} cyc2(G_i, G_j)`. -/
theorem bianchi_WC (hn : 4 ≤ n) (C : Matrix (Fin 3 ⊕ Fin 3) (Fin 3 ⊕ Fin 3) ℝ) :
    bianchi (WC n C) (E hn 0) (E hn 1) (E hn 2) (E hn 3)
      = sq2⁻¹ * sq2⁻¹ * ∑ i, ∑ j, C i j * cyc2 (G i) (G j) 0 1 2 3 := by
  unfold bianchi
  simp only [WC_phi_inner, eF_E, cyc2, Finset.mul_sum, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  ring

theorem eF_mul (hn : 4 ≤ n) (i j : Fin 3 ⊕ Fin 3) :
    (eF (n := n) i)ᵀ * eF j = (sq2⁻¹ * sq2⁻¹) • (Emb n * ((G i)ᵀ * G j) * (Emb n)ᵀ) := by
  unfold eF
  rw [Matrix.transpose_smul, conjT, Matrix.smul_mul, Matrix.mul_smul, smul_smul, sandwich hn]

/-- **Ricci of `W_C` at embedded indices**: `½ Σ C_{ij} (G_iᵀ G_j)_{xy}`. -/
theorem ric_WC (hn : 4 ≤ n) (C : Matrix (Fin 3 ⊕ Fin 3) (Fin 3 ⊕ Fin 3) ℝ) (x y : Fin 4) :
    Ric (WC n C) (E hn x) (E hn y) = sq2⁻¹ * sq2⁻¹ * ∑ i, ∑ j, C i j * ((G i)ᵀ * G j) x y := by
  unfold Ric
  simp only [WC_phi_inner]
  rw [Finset.sum_comm]
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_comm, Finset.mul_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  have h := congrFun (congrFun (eF_mul (n := n) hn i j) (E hn x)) (E hn y)
  rw [Matrix.smul_apply, sandwich_E, smul_eq_mul, Matrix.mul_apply] at h
  simp only [Matrix.transpose_apply] at h
  rw [show ∑ c, C i j * eF i c (E hn x) * eF j c (E hn y) = C i j * ∑ c, eF i c (E hn x) * eF j c (E hn y) by
    rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun c _ => by ring, h]
  ring

theorem G_inl (a : Fin 3) (p q : Fin 4) : G (Sum.inl a) p q = ((Jz a p q : ℤ) : ℝ) := J_cast a p q
theorem G_inr (b : Fin 3) (p q : Fin 4) : G (Sum.inr b) p q = ((Kz b p q : ℤ) : ℝ) := rfl

/-- **The Weyl conditions on `W_C`, for symmetric `C`**: the mixed block vanishes and both diagonal blocks
are trace-free. Ricci-flatness at the sixteen embedded pairs and first Bianchi at `(0,1,2,3)` are a linear
system in the entries of `C`, of rank `11`. -/
theorem weyl_blocks (hn : 4 ≤ n) (C : Matrix (Fin 3 ⊕ Fin 3) (Fin 3 ⊕ Fin 3) ℝ) (hs : ∀ i j, C i j = C j i)
    (hW : IsWeyl (WC n C)) :
    (∀ a b, C (Sum.inl a) (Sum.inr b) = 0) ∧
      C (Sum.inl 0) (Sum.inl 0) + C (Sum.inl 1) (Sum.inl 1) + C (Sum.inl 2) (Sum.inl 2) = 0 ∧
      C (Sum.inr 0) (Sum.inr 0) + C (Sum.inr 1) (Sum.inr 1) + C (Sum.inr 2) (Sum.inr 2) = 0 := by
  have hq : sq2⁻¹ * sq2⁻¹ ≠ 0 := by have := sq2_pos; positivity
  have hR : ∀ x y : Fin 4, ∑ i, ∑ j, C i j * ((G i)ᵀ * G j) x y = 0 := fun x y => by
    have h := hW.2.2.2 (E hn x) (E hn y)
    rw [ric_WC hn] at h
    exact (mul_eq_zero.mp h).resolve_left hq
  have hB : ∑ i, ∑ j, C i j * cyc2 (G i) (G j) 0 1 2 3 = 0 := by
    have h := hW.2.2.1 (E hn 0) (E hn 1) (E hn 2) (E hn 3)
    rw [bianchi_WC hn] at h
    exact (mul_eq_zero.mp h).resolve_left hq
  have r00 := hR 0 0
  have r01 := hR 0 1
  have r02 := hR 0 2
  have r03 := hR 0 3
  have r10 := hR 1 0
  have r11 := hR 1 1
  have r12 := hR 1 2
  have r13 := hR 1 3
  have r20 := hR 2 0
  have r21 := hR 2 1
  have r22 := hR 2 2
  have r23 := hR 2 3
  have r30 := hR 3 0
  have r31 := hR 3 1
  have r32 := hR 3 2
  have r33 := hR 3 3
  simp only [Fintype.sum_sum_type, Fin.sum_univ_three, Matrix.mul_apply, Matrix.transpose_apply,
    Fin.sum_univ_four, G_inl, G_inr, cyc2] at r00 r01 r02 r03 r10 r11 r12 r13 r20 r21 r22 r23 r30 r31 r32 r33 hB
  simp [Jz, Kz] at r00 r01 r02 r03 r10 r11 r12 r13 r20 r21 r22 r23 r30 r31 r32 r33 hB
  have s1 := hs (Sum.inl 0) (Sum.inl 1); have s2 := hs (Sum.inl 0) (Sum.inl 2); have s3 := hs (Sum.inl 1) (Sum.inl 2)
  have s4 := hs (Sum.inr 0) (Sum.inr 1); have s5 := hs (Sum.inr 0) (Sum.inr 2); have s6 := hs (Sum.inr 1) (Sum.inr 2)
  have t00 := hs (Sum.inl 0) (Sum.inr 0); have t01 := hs (Sum.inl 0) (Sum.inr 1); have t02 := hs (Sum.inl 0) (Sum.inr 2)
  have t10 := hs (Sum.inl 1) (Sum.inr 0); have t11 := hs (Sum.inl 1) (Sum.inr 1); have t12 := hs (Sum.inl 1) (Sum.inr 2)
  have t20 := hs (Sum.inl 2) (Sum.inr 0); have t21 := hs (Sum.inl 2) (Sum.inr 1); have t22 := hs (Sum.inl 2) (Sum.inr 2)
  refine ⟨fun a b => ?_, ?_, ?_⟩
  · fin_cases a <;> fin_cases b <;> simp only [Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, Fin.isValue] <;> linarith
  · linarith
  · linarith

/-! ## Rank at most three leaves one family -/

/-- **A nonzero symmetric trace-free `3 × 3` matrix has a nonzero principal `2 × 2` minor**: if all three
vanish, the diagonal entries have pairwise nonnegative products and sum to zero, so all vanish, and then so do
the off-diagonal ones. -/
theorem minor_ne {A : Matrix (Fin 3) (Fin 3) ℝ} (hs : ∀ i j, A i j = A j i)
    (htr : A 0 0 + A 1 1 + A 2 2 = 0) (h0 : A ≠ 0) :
    ∃ i j : Fin 3, i ≠ j ∧ A i i * A j j - A i j * A j i ≠ 0 := by
  by_contra h
  push Not at h
  have m01 := h 0 1 (by decide); have m02 := h 0 2 (by decide); have m12 := h 1 2 (by decide)
  rw [← hs 0 1] at m01; rw [← hs 0 2] at m02; rw [← hs 1 2] at m12
  have ha : A 0 0 = 0 ∧ A 1 1 = 0 ∧ A 2 2 = 0 := by
    have hsq : A 0 0 ^ 2 + A 1 1 ^ 2 + A 2 2 ^ 2 = 0 := by
      nlinarith [sq_nonneg (A 0 1), sq_nonneg (A 0 2), sq_nonneg (A 1 2)]
    refine ⟨?_, ?_, ?_⟩ <;> nlinarith [sq_nonneg (A 0 0), sq_nonneg (A 1 1), sq_nonneg (A 2 2)]
  obtain ⟨h00, h11, h22⟩ := ha
  have b01 : A 0 1 = 0 := by nlinarith [sq_nonneg (A 0 1)]
  have b02 : A 0 2 = 0 := by nlinarith [sq_nonneg (A 0 2)]
  have b12 : A 1 2 = 0 := by nlinarith [sq_nonneg (A 1 2)]
  apply h0
  ext i j
  fin_cases i <;> fin_cases j <;> simp [h00, h11, h22, b01, b02, b12, ← hs 0 1, ← hs 0 2, ← hs 1 2]

/-- **Rank at most three leaves one family**: with the mixed block zero and both diagonal blocks symmetric
and trace-free, `rank C ≤ 3` forces one diagonal block to vanish, since each nonzero block carries a nonzero
principal `2 × 2` minor and together they give a `4 × 4` principal submatrix of nonzero determinant. -/
theorem one_block_zero (C : Matrix (Fin 3 ⊕ Fin 3) (Fin 3 ⊕ Fin 3) ℝ) (hs : ∀ i j, C i j = C j i)
    (hB : ∀ a b, C (Sum.inl a) (Sum.inr b) = 0)
    (hA : C (Sum.inl 0) (Sum.inl 0) + C (Sum.inl 1) (Sum.inl 1) + C (Sum.inl 2) (Sum.inl 2) = 0)
    (hD : C (Sum.inr 0) (Sum.inr 0) + C (Sum.inr 1) (Sum.inr 1) + C (Sum.inr 2) (Sum.inr 2) = 0)
    (hrank : C.rank ≤ 3) :
    (fun a b => C (Sum.inl a) (Sum.inl b) : Matrix (Fin 3) (Fin 3) ℝ) = 0 ∨
      (fun a b => C (Sum.inr a) (Sum.inr b) : Matrix (Fin 3) (Fin 3) ℝ) = 0 := by
  by_contra h
  push Not at h
  obtain ⟨hA0, hD0⟩ := h
  obtain ⟨i, j, hij, hmA⟩ := minor_ne (A := fun a b => C (Sum.inl a) (Sum.inl b)) (fun a b => hs _ _) hA hA0
  obtain ⟨k, l, hkl, hmD⟩ := minor_ne (A := fun a b => C (Sum.inr a) (Sum.inr b)) (fun a b => hs _ _) hD hD0
  let r : Fin 4 → Fin 3 ⊕ Fin 3 := ![Sum.inl i, Sum.inl j, Sum.inr k, Sum.inr l]
  have hB' : ∀ a b, C (Sum.inr b) (Sum.inl a) = 0 := fun a b => by rw [hs]; exact hB a b
  have hdet : (C.submatrix r r).det
      = (C (Sum.inl i) (Sum.inl i) * C (Sum.inl j) (Sum.inl j) - C (Sum.inl i) (Sum.inl j) * C (Sum.inl j) (Sum.inl i))
        * (C (Sum.inr k) (Sum.inr k) * C (Sum.inr l) (Sum.inr l) - C (Sum.inr k) (Sum.inr l) * C (Sum.inr l) (Sum.inr k)) := by
    simp only [Matrix.det_succ_row_zero, Fin.sum_univ_succ, Matrix.submatrix_apply, Fin.succAbove,
      Matrix.det_fin_zero, r]
    simp [hB, hB']
    ring
  have hne : (C.submatrix r r).det ≠ 0 := by rw [hdet]; exact mul_ne_zero hmA hmD
  have h4 : (C.submatrix r r).rank = 4 := by
    rw [Matrix.rank_of_isUnit _ ((Matrix.isUnit_iff_isUnit_det _).mpr hne.isUnit)]; simp
  have := Matrix.rank_submatrix_le C r r
  omega

/-! ## The reduction, and L178 on `ℝⁿ` -/

/-- With the mixed block zero, `W_C` is the self-dual `W_A` plus the anti-self-dual `W_D`. -/
theorem WC_split (C : Matrix (Fin 3 ⊕ Fin 3) (Fin 3 ⊕ Fin 3) ℝ) (hs : ∀ i j, C i j = C j i)
    (hB : ∀ a b, C (Sum.inl a) (Sum.inr b) = 0) (X : Matrix (Fin n) (Fin n) ℝ) :
    WC n C X = WMat n (fun a b => C (Sum.inl a) (Sum.inl b)) X + WMatA n (fun a b => C (Sum.inr a) (Sum.inr b)) X := by
  have hB' : ∀ a b, C (Sum.inr b) (Sum.inl a) = 0 := fun a b => by rw [hs]; exact hB a b
  simp only [WC, Fintype.sum_sum_type, hB, hB', zero_mul, zero_smul, Finset.sum_const_zero, add_zero,
    zero_add]
  rfl

/-- **L178 on `ℝⁿ`, for every Weyl operator supported on the coordinate `Λ²ℝ⁴` with rank at most three.** An
operator supported there is `W_C` for its symmetric `6 × 6` coefficient matrix `C` in the basis
`(ω⁺, ω⁻)`. If it is Weyl, nonzero, and of rank at most three, then `θ(W_C) ≤ √(3/2)`. -/
theorem L178_padded (hn : 4 ≤ n) (C : Matrix (Fin 3 ⊕ Fin 3) (Fin 3 ⊕ Fin 3) ℝ) (hs : ∀ i j, C i j = C j i)
    (hW : IsWeyl (WC n C)) (hrank : C.rank ≤ 3) (h0 : C ≠ 0) : theta (WC n C) ≤ Real.sqrt (3 / 2) := by
  obtain ⟨hB, hA, hD⟩ := weyl_blocks hn C hs hW
  set A : Matrix (Fin 3) (Fin 3) ℝ := fun a b => C (Sum.inl a) (Sum.inl b) with hAdef
  set D : Matrix (Fin 3) (Fin 3) ℝ := fun a b => C (Sum.inr a) (Sum.inr b) with hDdef
  have hAs : Aᵀ = A := by ext a b; exact hs _ _
  have hDs : Dᵀ = D := by ext a b; exact hs _ _
  have hAt : A.trace = 0 := by
    change ∑ i, A i i = 0
    rw [Fin.sum_univ_three]; exact hA
  have hDt : D.trace = 0 := by
    change ∑ i, D i i = 0
    rw [Fin.sum_univ_three]; exact hD
  have hsplit : WC n C = fun X => WMat n A X + WMatA n D X := funext (WC_split C hs hB)
  have hzero : ∀ {Φ : SUFrame} (X : Matrix (Fin n) (Fin n) ℝ), WMatF Φ n 0 X = 0 := fun X => by
    simp [WMatF]
  have hC : C = Matrix.fromBlocks A 0 0 D := by
    ext (a | a) (b | b)
    · rfl
    · simp [hB]
    · simp [Matrix.fromBlocks, hs (Sum.inr a) (Sum.inl b), hB]
    · rfl
  rcases one_block_zero C hs hB hA hD hrank with h | h
  · have hA0 : A = 0 := h
    have hD0 : D ≠ 0 := by
      intro hD0; apply h0; rw [hC, hA0, hD0]; simp
    have : WC n C = WMatA n D := by
      rw [hsplit]; funext X; rw [hA0, show WMat n 0 X = 0 from hzero X, zero_add]
    rw [this]; exact WMatA_theta_le hn hDs hDt hD0
  · have hD0 : D = 0 := h
    have hA0 : A ≠ 0 := by
      intro hA0; apply h0; rw [hC, hA0, hD0]; simp
    have : WC n C = WMat n A := by
      rw [hsplit]; funext X; rw [hD0, show WMatA n 0 X = 0 from hzero X, add_zero]
    rw [this]; exact WMat_theta_le hn hAs hAt hA0

end HamiltonsCubic.CP2Real
