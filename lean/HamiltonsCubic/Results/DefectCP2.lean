import HamiltonsCubic.Results.DefectBlock

set_option linter.style.longLine false

/-!
# The competitor's defect `δ²(u) = 1/9`, and L134(c) assembled

[findings/route-a.md](../../../findings/route-a.md), Lemma L134: *"At `u`, `δ² = 1/9`"*, and (c): *"`c₂(H) = δ²(H) − 1/9 ≤
1/4 − 1/9 = 5/36`"* on the zero-padded flat.

- `WCP2_specOp`: [Families.lean](../Base/Families.lean)'s `W_{ℂP²}` is the spectral operator of `(a, b, c)` with
  coefficients `(1, −½, −½)`; `comp_negPart` and **`defect_WCP2`**: `δ² = 2/3` at `‖W‖² = 6`, so `defect_ratio`,
  `δ²/‖W‖² = 1/9`;
- `pad`, `sum_pad` and **`defectSq_pad`**: zero-padding into `ℝⁿ` leaves `δ²` unchanged;
- **`defect_u`**: `δ²(u) = 1/9` at the unit competitor `u = W_{ℂP²}/√6` padded into `ℝⁿ`;
- **`L134c`**: the defect along the great circle is `cos² t/9 + sin² t · δ²(H)` on `[0, π/2]`, so
  `c₂(H) = δ²(H) − 1/9 ≤ 5/36`, for every `H` on the complementary block presented orthonormally, of unit norm and
  satisfying first Bianchi ([DefectBlock.lean](DefectBlock.lean), [DefectQuarter.lean](DefectQuarter.lean)).
-/

namespace HamiltonsCubic.DefectCP2

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.AltLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.FamilyLayer.CP2

theorem bivB_eq : bivB = !![0, 0, -1, 0; 0, 0, 0, 1; 1, 0, 0, 0; 0, -1, 0, 0] := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [bivB, phi, Matrix.single_apply]

theorem bivC_eq : bivC = !![0, 0, 0, -1; 0, 0, -1, 0; 0, 1, 0, 0; 1, 0, 0, 0] := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [bivC, phi, Matrix.single_apply]

/-- The coefficients of `W_{ℂP²}` on `(a, b, c)`. -/
noncomputable def lamCP2 : Fin 3 → ℝ := ![1, -1/2, -1/2]
/-- The self-dual bivectors `(a, b, c)`. -/
noncomputable def omCP2 : Fin 3 → Matrix (Fin 4) (Fin 4) ℝ := ![bivA, bivB, bivC]

/-- `W_{ℂP²}` is the spectral operator of `(bivA, bivB, bivC)` with coefficients `(1, −½, −½)`. -/
theorem WCP2_specOp (X : Matrix (Fin 4) (Fin 4) ℝ) :
    WCP2 X = specOp lamCP2 omCP2 X := by
  simp [WCP2, specOp, proj, Fin.sum_univ_three, add_assoc, lamCP2, omCP2, neg_div, neg_mul, neg_smul]

theorem comp_negPart (i j k l : Fin 4) :
    comp (negPartOp lamCP2 omCP2) i j k l
      = (1 / 2) * (bivB i j * bivB k l) + (1 / 2) * (bivC i j * bivC k l) := by
  unfold comp negPartOp
  rw [inner2_specOp]
  simp only [Fin.sum_univ_three]
  have hA := bivA_skew; have hB := bivB_skew; have hC := bivC_skew
  simp only [lamCP2, omCP2, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons, Matrix.cons_val_two,
    Matrix.tail_cons]
  rw [inner2_phi _ hA, inner2_phi _ hA, inner2_phi _ hB, inner2_phi _ hB, inner2_phi _ hC, inner2_phi _ hC]
  simp [negPartScalar]
  norm_num

/-- **`δ²(W_{ℂP²}) = 2/3`** at `‖W‖² = 6`, so `1/9` at unit norm. -/
theorem defect_WCP2 : defectSq (ι := Fin 4) lamCP2 omCP2 = 2 / 3 := by
  unfold defectSq altNormSq fourNormSq fourInner altCoeff alt4
  simp only [comp_negPart, bivB_eq, bivC_eq, Fin.sum_univ_four]
  simp
  norm_num

/-- **At unit norm, `δ² = 1/9`**: `δ²/‖W‖² = (2/3)/6`. -/
theorem defect_ratio : defectSq (ι := Fin 4) lamCP2 omCP2 = (1 / 9) * normSq WCP2 := by
  rw [defect_WCP2, WCP2_normSq]; norm_num

/-! ## Padding by zeros -/

variable {n : ℕ}

/-- Zero-padding a `4 × 4` matrix into the top-left corner of `n × n`. -/
noncomputable def pad (M : Matrix (Fin 4) (Fin 4) ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  fun a b => if h : a.val < 4 ∧ b.val < 4 then M ⟨a.val, h.1⟩ ⟨b.val, h.2⟩ else 0

theorem pad_skew (M : Matrix (Fin 4) (Fin 4) ℝ) (hM : IsSkew M) : IsSkew (pad (n := n) M) := by
  unfold IsSkew at hM ⊢
  ext a b
  simp only [Matrix.transpose_apply, Matrix.neg_apply, pad]
  by_cases h : a.val < 4 ∧ b.val < 4
  · rw [dif_pos h, dif_pos ⟨h.2, h.1⟩]
    have := congrFun (congrFun hM ⟨a.val, h.1⟩) ⟨b.val, h.2⟩
    simpa [Matrix.transpose_apply] using this
  · rw [dif_neg h, dif_neg (fun h' => h ⟨h'.2, h'.1⟩), neg_zero]

/-- A sum over `Fin n` of a function vanishing from `4` on is a sum over `Fin 4`. -/
theorem sum_pad (hn : 4 ≤ n) (F : Fin n → ℝ) (hF : ∀ a : Fin n, 4 ≤ a.val → F a = 0) :
    ∑ a, F a = ∑ a : Fin 4, F ⟨a.val, by omega⟩ := by
  set G : ℕ → ℝ := fun k => if h : k < n then F ⟨k, h⟩ else 0 with hG
  calc ∑ a, F a = ∑ a : Fin n, G a.val := Finset.sum_congr rfl fun a _ => by simp [hG, a.isLt]
    _ = ∑ k ∈ Finset.range n, G k := Fin.sum_univ_eq_sum_range G n
    _ = ∑ k ∈ Finset.range 4, G k := by
        refine (Finset.sum_subset (fun k hk => ?_) fun k hk hk' => ?_).symm
        · simp at hk ⊢; omega
        · simp at hk hk'
          simp only [hG, dif_pos hk]; exact hF _ (by simpa using hk')
    _ = ∑ a : Fin 4, G a.val := (Fin.sum_univ_eq_sum_range G 4).symm
    _ = ∑ a : Fin 4, F ⟨a.val, by omega⟩ := Finset.sum_congr rfl fun a _ => by
        simp only [hG]; rw [dif_pos (by omega)]

/-- `comp` of a spectral operator in entries. -/
theorem comp_specOp_apply {ι : Type*} [Fintype ι] [DecidableEq ι] {r : ℕ} (mu : Fin r → ℝ)
    (om : Fin r → Matrix ι ι ℝ) (hom : ∀ γ, IsSkew (om γ)) (i j k l : ι) :
    comp (specOp mu om) i j k l = ∑ γ, mu γ * (om γ i j * om γ k l) := by
  unfold comp
  rw [inner2_specOp]
  refine Finset.sum_congr rfl fun γ _ => ?_
  rw [inner2_phi _ (hom γ), inner2_phi _ (hom γ)]; ring

theorem pad_apply (M : Matrix (Fin 4) (Fin 4) ℝ) (a b : Fin n) (h : a.val < 4 ∧ b.val < 4) :
    pad (n := n) M a b = M ⟨a.val, h.1⟩ ⟨b.val, h.2⟩ := dif_pos h

theorem pad_zero (M : Matrix (Fin 4) (Fin 4) ℝ) (a b : Fin n) (h : ¬(a.val < 4 ∧ b.val < 4)) :
    pad (n := n) M a b = 0 := dif_neg h

/-- **`δ²` is unchanged by zero-padding**. -/
theorem defectSq_pad (hn : 4 ≤ n) {r : ℕ} (lam : Fin r → ℝ) (om : Fin r → Matrix (Fin 4) (Fin 4) ℝ)
    (hom : ∀ γ, IsSkew (om γ)) :
    defectSq (ι := Fin n) lam (fun γ => pad (om γ)) = defectSq (ι := Fin 4) lam om := by
  have hpsk : ∀ γ, IsSkew (pad (n := n) (om γ)) := fun γ => pad_skew _ (hom γ)
  set μ : Fin r → ℝ := fun γ => negPartScalar (lam γ)
  have hc : ∀ i j k l : Fin n, comp (negPartOp lam fun γ => pad (om γ)) i j k l
      = ∑ γ, μ γ * (pad (n := n) (om γ) i j * pad (n := n) (om γ) k l) :=
    fun i j k l => comp_specOp_apply μ _ hpsk i j k l
  have hc4 : ∀ i j k l : Fin 4, comp (negPartOp lam om) i j k l = ∑ γ, μ γ * (om γ i j * om γ k l) :=
    fun i j k l => comp_specOp_apply μ _ hom i j k l
  -- entries vanish off the corner
  have hz : ∀ (a b : Fin n) γ, 4 ≤ a.val → pad (n := n) (om γ) a b = 0 := fun a b γ ha =>
    pad_zero _ a b (by omega)
  have hz' : ∀ (a b : Fin n) γ, 4 ≤ b.val → pad (n := n) (om γ) a b = 0 := fun a b γ hb =>
    pad_zero _ a b (by omega)
  unfold defectSq altNormSq fourNormSq fourInner
  congr 1
  simp only [altCoeff, alt4, hc, hc4]
  rw [sum_pad hn _ fun a ha => by
    refine Finset.sum_eq_zero fun b _ => Finset.sum_eq_zero fun c _ => Finset.sum_eq_zero fun d _ => ?_
    simp [hz a _ _ ha]]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [sum_pad hn _ fun b hb => by
    refine Finset.sum_eq_zero fun c _ => Finset.sum_eq_zero fun d _ => ?_
    simp [hz' _ b _ hb, hz _ _ _ hb]]
  refine Finset.sum_congr rfl fun b _ => ?_
  rw [sum_pad hn _ fun c hc' => by
    refine Finset.sum_eq_zero fun d _ => ?_
    simp [hz' _ c _ hc', hz c _ _ hc']]
  refine Finset.sum_congr rfl fun c _ => ?_
  rw [sum_pad hn _ fun d hd => by simp [hz' _ d _ hd, hz d _ _ hd]]
  refine Finset.sum_congr rfl fun d _ => ?_
  simp [pad, a.isLt, b.isLt, c.isLt, d.isLt]

theorem omCP2_skew (γ : Fin 3) : IsSkew (omCP2 γ) := by
  fin_cases γ
  · exact bivA_skew
  · exact bivB_skew
  · exact bivC_skew

/-! ## L134(c) at the padded competitor -/

/-- The unit competitor's coefficients, `W_{ℂP²}/√6`. -/
noncomputable def lamU : Fin 3 → ℝ := fun γ => (Real.sqrt 6)⁻¹ * lamCP2 γ
/-- Its bivectors, padded into `ℝⁿ`. -/
noncomputable def omU : Fin 3 → Matrix (Fin n) (Fin n) ℝ := fun γ => pad (omCP2 γ)

/-- **`δ²(u) = 1/9`** at the unit competitor padded into `ℝⁿ`. -/
theorem defect_u (hn : 4 ≤ n) : defectSq (ι := Fin n) lamU (omU (n := n)) = 1 / 9 := by
  unfold lamU omU
  rw [defectSq_pad hn _ _ omCP2_skew, defectSq_smul (by positivity), defect_WCP2, inv_pow,
    Real.sq_sqrt (by norm_num)]
  norm_num

/-- **L134(c)**: for `H` presented orthonormally by bivectors on the complementary `ℝⁿ⁻⁴`, of unit norm and satisfying
first Bianchi, the defect along the great circle from the padded competitor is `cos² t/9 + sin² t · δ²(H)` on
`[0, π/2]`, so `c₂(H) = δ²(H) − 1/9 ≤ 5/36`. -/
theorem L134c (hn : 4 ≤ n) {s : ℕ} (mu : Fin s → ℝ) (eta : Fin s → Matrix (Fin n) (Fin n) ℝ)
    (heta : ∀ δ, IsSkew (eta δ)) (horth : ∀ δ ε, inner2 (eta δ) (eta ε) = if δ = ε then 1 else 0)
    (hB : ∀ i j k l, bianchi (specOp mu eta) i j k l = 0) (hunit : ∑ δ, mu δ ^ 2 = 1)
    (hoff : ∀ δ (a b : Fin n), a.val < 4 → eta δ a b = 0) :
    (∀ t, 0 ≤ t → t ≤ Real.pi / 2 →
      defectSq (Fin.append (fun γ => Real.cos t * lamU γ) (fun δ => Real.sin t * mu δ)) (Fin.append omU eta)
        = Real.cos t ^ 2 * (1 / 9) + Real.sin t ^ 2 * defectSq mu eta) ∧
    (1 / 2) * deriv (deriv fun t => Real.cos t ^ 2 * (1 / 9) + Real.sin t ^ 2 * defectSq mu eta) 0
      = defectSq mu eta - 1 / 9 ∧
    defectSq mu eta - 1 / 9 ≤ 5 / 36 := by
  have hu := defect_u (n := n) hn
  have hS : ∀ γ (a b : Fin n), a ∉ (Finset.univ.filter fun x : Fin n => x.val < 4) → omU γ a b = 0 := by
    intro γ a b ha
    simp at ha
    exact pad_zero _ a b (by omega)
  have hSc : ∀ δ (a b : Fin n), a ∈ (Finset.univ.filter fun x : Fin n => x.val < 4) → eta δ a b = 0 := by
    intro δ a b ha
    simp at ha
    exact hoff δ a b ha
  have hsk : ∀ γ, IsSkew (omU (n := n) γ) := fun γ => pad_skew _ (omCP2_skew γ)
  obtain ⟨h1, h2⟩ := HamiltonsCubic.DefectBlock.c2_padded_le lamU (omU (n := n)) mu eta heta horth hB hunit
  rw [hu] at h1 h2
  refine ⟨fun t ht0 ht1 => ?_, h1, by linarith⟩
  rw [HamiltonsCubic.DefectBlock.defect_arc lamU omU mu eta hsk heta _ hS hSc t ht0 ht1, hu]

end HamiltonsCubic.DefectCP2
