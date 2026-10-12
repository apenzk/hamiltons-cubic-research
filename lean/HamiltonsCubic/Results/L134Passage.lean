import HamiltonsCubic.Results.L134Coupling
import HamiltonsCubic.Results.FoxBridge

set_option linter.style.longLine false

/-!
# L134(c)'s passage: `⟨L_eH, H⟩ = 0` on the padded flat, in the matrix layer

[L134Coupling.lean](L134Coupling.lean) proves the trilinear coupling `⟨u, Q(H)⟩ = 0`. The record's quantity is
`⟨L_eH, H⟩` with `L_e = e ∘ (·)`, `e = u/θ`, and the passage is the full symmetry of `T`, which
[FoxBridge.lean](FoxBridge.lean)'s `foxTri_symm_right` gives at Weyl operators ([r1464](../../../reviews/REVIEW_r1464.md)).

- **`WCP2_bianchi`**: `W_{ℂP²}` satisfies first Bianchi over `ℝ`, from its spectral presentation index by index
  ([Families.lean](../Base/Families.lean)'s `WCP2_isWeyl` carries it as a hypothesis);
- `bianchi_specOp_apply`, `WCP2_bianchi_sum`, `WCP2_ric_sum` and **`isWeyl_U`**: the padded competitor is a Weyl
  operator on `ℝⁿ`;
- **`Le_pairing`**: `⟨L_eH, H⟩ = θ⁻¹⟨U, Q(H)⟩` for Weyl `U`, `H`;
- **`L134c_margin`**: `⟨L_eH, H⟩ = 0` at the padded competitor and every Weyl `H` on the complementary block.
-/

namespace HamiltonsCubic.L134Coupling

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.AltLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.FamilyLayer.CP2
  HamiltonsCubic.DefectCP2

set_option maxHeartbeats 4000000 in
/-- **`W_{ℂP²}` satisfies first Bianchi over `ℝ`**, from its spectral presentation, index by index. -/
theorem WCP2_bianchi (i j k l : Fin 4) : bianchi WCP2 i j k l = 0 := by
  have hW : WCP2 = specOp lamCP2 omCP2 := funext WCP2_specOp
  rw [hW, bianchi_eq_comp, comp_specOp_apply _ _ omCP2_skew, comp_specOp_apply _ _ omCP2_skew,
    comp_specOp_apply _ _ omCP2_skew]
  simp only [Fin.sum_univ_three, lamCP2, omCP2, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons,
    Matrix.cons_val_two, Matrix.tail_cons, bivB_eq, bivC_eq]
  have hA : bivA = !![0, -1, 0, 0; 1, 0, 0, 0; 0, 0, 0, -1; 0, 0, 1, 0] := by
    ext a b; fin_cases a <;> fin_cases b <;> simp [bivA, phi]
  rw [hA]
  fin_cases i <;> fin_cases j <;> fin_cases k <;> fin_cases l <;> simp <;> norm_num

theorem bianchi_specOp_apply {ι : Type*} [Fintype ι] [DecidableEq ι] {r : ℕ} (mu : Fin r → ℝ)
    (om : Fin r → Matrix ι ι ℝ) (hom : ∀ γ, IsSkew (om γ)) (i j k l : ι) :
    bianchi (specOp mu om) i j k l
      = ∑ γ, mu γ * (om γ i j * om γ k l + om γ i k * om γ l j + om γ i l * om γ j k) := by
  rw [bianchi_eq_comp, comp_specOp_apply _ _ hom, comp_specOp_apply _ _ hom, comp_specOp_apply _ _ hom,
    ← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun γ _ => by ring

theorem WCP2_bianchi_sum (i j k l : Fin 4) :
    ∑ γ, lamCP2 γ * (omCP2 γ i j * omCP2 γ k l + omCP2 γ i k * omCP2 γ l j + omCP2 γ i l * omCP2 γ j k) = 0 := by
  rw [← bianchi_specOp_apply _ _ omCP2_skew, ← funext WCP2_specOp]
  exact WCP2_bianchi i j k l

theorem WCP2_ric_sum (a b : Fin 4) : ∑ c, ∑ γ, lamCP2 γ * (omCP2 γ a c * omCP2 γ b c) = 0 := by
  have h := WCP2_ricciFlat a b
  have hW : WCP2 = specOp lamCP2 omCP2 := funext WCP2_specOp
  unfold Ric at h
  rw [hW] at h
  rw [← h]
  refine Finset.sum_congr rfl fun c _ => ?_
  exact (comp_specOp_apply _ _ omCP2_skew a c b c).symm

variable {n : ℕ}

/-- **The padded competitor is a Weyl operator on `ℝⁿ`.** -/
theorem isWeyl_U (hn : 4 ≤ n) : IsWeyl (specOp lamU (omU (n := n))) := by
  have hsk : ∀ γ, IsSkew (omU (n := n) γ) := fun γ => pad_skew _ (omCP2_skew γ)
  refine ⟨fun X _ => specOp_isSkew _ _ hsk X, fun X Y _ _ => specOp_symmetric _ _ X Y, fun i j k l => ?_,
    fun a b => ?_⟩
  · rw [bianchi_specOp_apply _ _ hsk]
    by_cases h : i.val < 4 ∧ j.val < 4 ∧ k.val < 4 ∧ l.val < 4
    · obtain ⟨hi, hj, hk, hl⟩ := h
      have e := WCP2_bianchi_sum ⟨i.val, hi⟩ ⟨j.val, hj⟩ ⟨k.val, hk⟩ ⟨l.val, hl⟩
      simp only [lamU, omU, pad, hi, hj, hk, hl, and_self, dif_pos]
      rw [show (∑ γ, (Real.sqrt 6)⁻¹ * lamCP2 γ * (omCP2 γ ⟨i.val, hi⟩ ⟨j.val, hj⟩ * omCP2 γ ⟨k.val, hk⟩ ⟨l.val, hl⟩
          + omCP2 γ ⟨i.val, hi⟩ ⟨k.val, hk⟩ * omCP2 γ ⟨l.val, hl⟩ ⟨j.val, hj⟩
          + omCP2 γ ⟨i.val, hi⟩ ⟨l.val, hl⟩ * omCP2 γ ⟨j.val, hj⟩ ⟨k.val, hk⟩))
          = (Real.sqrt 6)⁻¹ * ∑ γ, lamCP2 γ * (omCP2 γ ⟨i.val, hi⟩ ⟨j.val, hj⟩ * omCP2 γ ⟨k.val, hk⟩ ⟨l.val, hl⟩
          + omCP2 γ ⟨i.val, hi⟩ ⟨k.val, hk⟩ * omCP2 γ ⟨l.val, hl⟩ ⟨j.val, hj⟩
          + omCP2 γ ⟨i.val, hi⟩ ⟨l.val, hl⟩ * omCP2 γ ⟨j.val, hj⟩ ⟨k.val, hk⟩) by
        rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun _ _ => by ring, e, mul_zero]
    · refine Finset.sum_eq_zero fun γ _ => ?_
      have z : ∀ a b : Fin n, ¬(a.val < 4 ∧ b.val < 4) → omU (n := n) γ a b = 0 := fun a b hab => pad_zero _ a b hab
      push Not at h
      by_cases hi : i.val < 4
      · by_cases hj : j.val < 4
        · by_cases hk : k.val < 4
          · have hl := h hi hj hk
            rw [z k l (by omega), z l j (by omega), z i l (by omega)]; ring
          · rw [z k l (by omega), z i k (by omega), z j k (by omega)]; ring
        · rw [z i j (by omega), z l j (by omega), z j k (by omega)]; ring
      · rw [z i j (by omega), z i k (by omega), z i l (by omega)]; ring
  · show ∑ c, comp (specOp lamU (omU (n := n))) a c b c = 0
    simp only [comp_specOp_apply _ _ hsk]
    by_cases h : a.val < 4 ∧ b.val < 4
    · rw [sum_pad hn _ fun c hc => Finset.sum_eq_zero fun γ _ => by
        rw [show omU (n := n) γ a c = 0 from pad_zero _ a c (by omega)]; ring]
      have e := WCP2_ric_sum ⟨a.val, h.1⟩ ⟨b.val, h.2⟩
      rw [← mul_zero (Real.sqrt 6)⁻¹, ← e, Finset.mul_sum]
      refine Finset.sum_congr rfl fun c _ => ?_
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl fun γ _ => ?_
      simp [lamU, omU, pad, h.1, h.2]
      ring
    · refine Finset.sum_eq_zero fun c _ => Finset.sum_eq_zero fun γ _ => ?_
      by_cases ha : a.val < 4
      · rw [show omU (n := n) γ b c = 0 from pad_zero _ b c (by omega)]; ring
      · rw [show omU (n := n) γ a c = 0 from pad_zero _ a c (by omega)]; ring

/-- **`⟨L_eH, H⟩ = θ⁻¹⟨U, Q(H)⟩`** in the matrix layer, `L_e = Lidem U θ`, from the full symmetry of `T`
([FoxBridge.lean](FoxBridge.lean)'s `foxTri_symm_right`) at Weyl `U` and `H`. -/
theorem Le_pairing {ι : Type*} [Fintype ι] [DecidableEq ι] (U H : CurvOp ι) (hU : IsWeyl U) (hH : IsWeyl H)
    (hL : IsLinOp H) (θ : ℝ) : innerOp (Lidem U θ H) H = θ⁻¹ * innerOp U (Qop H) := by
  rw [Lidem_apply]
  change foxTri (idemOf U θ) H H = _
  rw [foxTri_comm, HamiltonsCubic.TensorBridge.foxTri_symm_right hH (isWeyl_idemOf hU θ) hH]
  unfold foxTri
  rw [foxProd_self H hL, innerOp_comm]
  unfold innerOp idemOf
  simp only [Pi.smul_apply, FamilyLayer.inner2_smul_left, ← Finset.mul_sum]
  ring

/-- **L134(c)'S MARGIN**: at the padded competitor `U` and a Weyl `H` presented on the complementary `ℝⁿ⁻⁴`,
`⟨L_eH, H⟩ = 0` for every `θ`. -/
theorem L134c_margin {n s : ℕ} (hn : 4 ≤ n) (mu : Fin s → ℝ) (eta : Fin s → Matrix (Fin n) (Fin n) ℝ)
    (heta : ∀ δ, IsSkew (eta δ)) (hB : ∀ i j k l, bianchi (specOp mu eta) i j k l = 0)
    (hRic : ∀ a b, Ric (specOp mu eta) a b = 0) (hoff : ∀ δ (a b : Fin n), a.val < 4 → eta δ a b = 0) (θ : ℝ) :
    innerOp (Lidem (specOp lamU (omU (n := n))) θ (specOp mu eta)) (specOp mu eta) = 0 := by
  have hH : IsWeyl (specOp mu eta) :=
    ⟨fun X _ => specOp_isSkew mu eta heta X, fun X Y _ _ => specOp_symmetric mu eta X Y, hB, hRic⟩
  rw [Le_pairing _ _ (isWeyl_U hn) hH ⟨specOp_add mu eta, fun c X => specOp_smul c mu eta X⟩ θ,
    L134c_coupling mu eta heta hB hRic hoff, mul_zero]

end HamiltonsCubic.L134Coupling
