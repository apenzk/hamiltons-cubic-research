import Mathlib
import HamiltonsCubic.Results.L264Semi

set_option linter.style.longLine false

/-!
# L264 (2): the destabilising direction lies in `Sym² 𝔥`

[L264Cross.lean](L264Cross.lean)'s `L264_cross` and its consumers conclude `¬ IsStable C`, stability quantifying over
every self-adjoint `H ⊥ C` in `𝔰𝔬(n)`. The direction the proof uses, `H = ‖D₂‖²D₁ - ‖D₁‖²D₂`, is supported on
`𝔥 = 𝔥₁ ⊕ 𝔥₂`, so `C` is unstable in `𝔥`'s own sense as well. This file exports it:

* `L264_cross_H`: at a split with projections `P₁`, `P₂`, a self-adjoint `H ⊥ C` with `H = QHQ`, `Q = P₁ + P₂`, and
  `F(C, H, H) > ½‖H‖²`;
* `L264_two_H`, `L264_semisimple_H`: the same for `L264_two`'s split and for a semisimple `𝔥` with two simple ideals,
  with `H` mapping into `𝔥` and killing `𝔥⊥`.
-/

namespace HamiltonsCubic.L264Destab

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.I117S HamiltonsCubic.L264Cross

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem L264_cross_H (P₁ P₂ C : CurvOp2 ι) (s₁ : IsSelfAdjoint2 P₁) (s₂ : IsSelfAdjoint2 P₂)
    (i₁ : ∀ X, P₁ (P₁ X) = P₁ X) (i₂ : ∀ X, P₂ (P₂ X) = P₂ X)
    (o₁₂ : ∀ X, P₁ (P₂ X) = 0) (o₂₁ : ∀ X, P₂ (P₁ X) = 0)
    (b₁ : ∀ X Y, P₁ (brS (P₁ X) (P₁ Y)) = brS (P₁ X) (P₁ Y)) (b₂ : ∀ X Y, P₂ (brS (P₂ X) (P₂ Y)) = brS (P₂ X) (P₂ Y))
    (c₁₂ : ∀ X Y, brS (P₁ X) (P₂ Y) = 0)
    (hCQ : ∀ X, C X = C (P₁ X + P₂ X)) (hQC : ∀ X, C X = P₁ (C X) + P₂ (C X))
    (hC : IsSelfAdjoint2 C) (hidem : IsIdem C) (h₁ : blk P₁ C ≠ 0) (h₂ : blk P₂ C ≠ 0) :
    ∃ H : CurvOp2 ι, IsSelfAdjoint2 H ∧ innerOp2 H C = 0 ∧ (∀ X, H X = P₁ (H X) + P₂ (H X)) ∧
      (∀ X, H X = H (P₁ X + P₂ X)) ∧ (1 / 2) * normSq2 H < Ftri C H H := by
  have c₂₁ : ∀ X Y, brS (P₂ X) (P₁ Y) = 0 := fun X Y => by rw [brS_neg, c₁₂, neg_zero]
  have hCQ' : ∀ X, C X = C (P₂ X + P₁ X) := fun X => by rw [add_comm]; exact hCQ X
  have hQC' : ∀ X, C X = P₂ (C X) + P₁ (C X) := fun X => by rw [add_comm]; exact hQC X
  set D₁ := blk P₁ C with hD₁
  set D₂ := blk P₂ C with hD₂
  have sa : ∀ {P : CurvOp2 ι}, IsSelfAdjoint2 P → IsSelfAdjoint2 (blk P C) := fun {P} hP X Z => by
    show inner2 ((P (C (P X)) : skewSub ι) : Matrix ι ι ℝ) _ = inner2 _ ((P (C (P Z)) : skewSub ι) : Matrix ι ι ℝ)
    rw [hP, hC, hP]
  have hD₁sa : IsSelfAdjoint2 D₁ := sa s₁
  have hD₂sa : IsSelfAdjoint2 D₂ := sa s₂
  have k₁ := sharp_blk s₁ s₂ i₁ o₁₂ b₁ b₂ c₁₂ hCQ hQC hC hidem
  have k₂ := sharp_blk s₂ s₁ i₂ o₂₁ b₂ b₁ c₂₁ hCQ' hQC' hC hidem
  -- `⟨D₁, D₂⟩ = 0` and `⟨D_i, C⟩ = ‖D_i‖²`
  have hperp : innerOp2 D₁ D₂ = 0 := by
    rw [hD₂, ← inner_move s₂ D₁]
    have : P₂.comp (D₁.comp P₂) = 0 := ContinuousLinearMap.ext fun X => by
      show P₂ (P₁ (C (P₁ (P₂ X)))) = 0
      rw [o₂₁]
    rw [this]; simp [innerOp2, applyPhi, inner2]
  have hperp' : innerOp2 D₂ D₁ = 0 := by rw [innerOp2_comm]; exact hperp
  have hDC : ∀ {P : CurvOp2 ι}, IsSelfAdjoint2 P → (∀ X, P (P X) = P X) →
      innerOp2 (blk P C) C = normSq2 (blk P C) := fun {P} hP hi => by
    unfold normSq2
    rw [← inner_move hP (blk P C)]
    congr 1
    exact ContinuousLinearMap.ext fun X => by
      show P (C (P X)) = P (P (C (P (P X))))
      rw [hi, hi]
  have hD₁C := hDC s₁ i₁
  have hD₂C := hDC s₂ i₂
  set a := normSq2 D₂ with ha
  set b := normSq2 D₁ with hb
  have ha0 : 0 < a := lt_of_le_of_ne (normSq2_nonneg D₂) (fun h => h₂ (normSq2_eq_zero h.symm))
  have hb0 : 0 < b := lt_of_le_of_ne (normSq2_nonneg D₁) (fun h => h₁ (normSq2_eq_zero h.symm))
  set H := a • D₁ + (-b) • D₂ with hH
  have hHsa : IsSelfAdjoint2 H := isSelfAdjoint2_add (isSelfAdjoint2_smul hD₁sa a) (isSelfAdjoint2_smul hD₂sa (-b))
  have hHC : innerOp2 H C = 0 := by
    rw [hH, innerOp2_add_left, innerOp2_smul_left, innerOp2_smul_left, hD₁C, hD₂C]
    ring
  have hnH : normSq2 H = a ^ 2 * b + b ^ 2 * a := by
    show innerOp2 (a • D₁ + (-b) • D₂) (a • D₁ + (-b) • D₂) = _
    rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, innerOp2_smul_left, innerOp2_smul_left,
      innerOp2_smul_left, innerOp2_smul_left, innerOp2_smul_right, innerOp2_smul_right, innerOp2_smul_right,
      innerOp2_smul_right, hperp, hperp']
    simp only [ha, hb, normSq2]; ring
  have hFH : Ftri C H H = a ^ 2 * b + b ^ 2 * a := by
    rw [hH]
    simp only [Ftri_add_mid, Ftri_add_right, Ftri_smul_mid, Ftri_smul_right]
    rw [k₁ D₁ hD₁sa, k₁ D₂ hD₂sa, k₂ D₁ hD₁sa, k₂ D₂ hD₂sa, hperp, hperp']
    simp only [ha, hb, normSq2]; ring
  have hHX : ∀ X, H X = a • P₁ (C (P₁ X)) + (-b) • P₂ (C (P₂ X)) := fun X => rfl
  refine ⟨H, hHsa, hHC, fun X => ?_, fun X => ?_, ?_⟩
  · rw [hHX, map_add, map_add, map_smul, map_smul, map_smul, map_smul, i₁, o₁₂, i₂, o₂₁, smul_zero, smul_zero,
      add_zero, zero_add]
  · have e1 : P₁ (P₁ X + P₂ X) = P₁ X := by rw [map_add, i₁, o₁₂, add_zero]
    have e2 : P₂ (P₁ X + P₂ X) = P₂ X := by rw [map_add, i₂, o₂₁, zero_add]
    rw [hHX, hHX, e1, e2]
  · rw [hFH, hnH]
    nlinarith [mul_pos (mul_pos ha0 ha0) hb0, mul_pos (mul_pos hb0 hb0) ha0]


section Two

theorem L264_two_H (h h₁ h₂ : Submodule ℝ (skewSub ι)) (hsum : h ≤ h₁ ⊔ h₂) (hle₁ : h₁ ≤ h) (hle₂ : h₂ ≤ h)
    (hcl₁ : ∀ X ∈ h₁, ∀ Y ∈ h₁, brS X Y ∈ h₁) (hcl₂ : ∀ X ∈ h₂, ∀ Y ∈ h₂, brS X Y ∈ h₂)
    (hcomm : ∀ X ∈ h₁, ∀ Y ∈ h₂, brS X Y = 0)
    (hperf : h₁ ≤ Submodule.span ℝ {W | ∃ A B, A ∈ h₁ ∧ B ∈ h₁ ∧ W = brS A B})
    (hne₁ : ∃ Y ∈ h₁, Y ≠ 0) (hne₂ : ∃ Y ∈ h₂, Y ≠ 0)
    (C : CurvOp2 ι) (hC : IsSelfAdjoint2 C) (hidem : IsIdem C) (hran : ∀ X, C X ∈ h)
    (hpd : ∀ Y ∈ h, Y ≠ 0 → 0 < inner2 ((C Y : skewSub ι) : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ)) :
    ∃ H : CurvOp2 ι, IsSelfAdjoint2 H ∧ innerOp2 H C = 0 ∧ (∀ X, H X ∈ h) ∧
      (∀ X : skewSub ι, (∀ Y ∈ h, inner2 (X : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ) = 0) → H X = 0) ∧
      (1 / 2) * normSq2 H < Ftri C H H := by
  -- the ideals are orthogonal
  have orth : ∀ a ∈ h₁, ∀ b ∈ h₂, inner2 (a : Matrix ι ι ℝ) (b : Matrix ι ι ℝ) = 0 := by
    intro a ha b hb
    have key : ∀ u ∈ Submodule.span ℝ {W | ∃ A B, A ∈ h₁ ∧ B ∈ h₁ ∧ W = brS A B},
        inner2 (u : Matrix ι ι ℝ) (b : Matrix ι ι ℝ) = 0 := by
      intro u hu
      induction hu using Submodule.span_induction with
      | mem u hu =>
        obtain ⟨A, B, hA, -, rfl⟩ := hu
        rw [inner2_brS_skew, hcomm A hA b hb]; simp [inner2]
      | zero => simp [inner2]
      | add u v _ _ hu hv => rw [Submodule.coe_add, i2_add_l, hu, hv, add_zero]
      | smul c u _ hu => rw [Submodule.coe_smul, i2_smul_l, hu, mul_zero]
    exact key a (hperf ha)
  have orth' : ∀ b ∈ h₂, ∀ a ∈ h₁, inner2 (b : Matrix ι ι ℝ) (a : Matrix ι ι ℝ) = 0 := fun b hb a ha => by
    rw [HamiltonsCubic.L33Statement.inner2_comm]; exact orth a ha b hb
  set P₁ := HamiltonsCubic.L264Two.oproj h₁ with hP₁
  set P₂ := HamiltonsCubic.L264Two.oproj h₂ with hP₂
  have o₁₂ : ∀ X, P₁ (P₂ X) = 0 := fun X => HamiltonsCubic.L264Two.oproj_zero h₁ _ fun Y hY => orth' _ (HamiltonsCubic.L264Two.oproj_mem h₂ X) Y hY
  have o₂₁ : ∀ X, P₂ (P₁ X) = 0 := fun X => HamiltonsCubic.L264Two.oproj_zero h₂ _ fun Y hY => orth _ (HamiltonsCubic.L264Two.oproj_mem h₁ X) Y hY
  have hdec : ∀ Z ∈ h, ∃ Z₁ ∈ h₁, ∃ Z₂ ∈ h₂, Z₁ + Z₂ = Z := fun Z hZ => Submodule.mem_sup.mp (hsum hZ)
  have hkill : ∀ Z : skewSub ι, (∀ Y ∈ h, inner2 (Z : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ) = 0) → C Z = 0 := by
    intro Z hZ
    refine Subtype.ext (HamiltonsCubic.FrameExtension.inner2_self_eq_zero ?_)
    rw [hC, hZ _ (hran _)]
  have hQ : ∀ Z ∈ h, P₁ Z + P₂ Z = Z := fun Z hZ => by
    obtain ⟨Z₁, h1, Z₂, h2, rfl⟩ := hdec Z hZ
    rw [map_add, map_add, HamiltonsCubic.L264Two.oproj_self h₁ Z₁ h1, HamiltonsCubic.L264Two.oproj_self h₂ Z₂ h2,
      HamiltonsCubic.L264Two.oproj_zero h₁ Z₂ fun Y hY => orth' Z₂ h2 Y hY, HamiltonsCubic.L264Two.oproj_zero h₂ Z₁ fun Y hY => orth Z₁ h1 Y hY]
    abel
  have hCQ : ∀ X, C X = C (P₁ X + P₂ X) := fun X => by
    have h0 : C (X - (P₁ X + P₂ X)) = 0 := hkill _ fun Y hY => by
      rw [Submodule.coe_sub, i2_sub_l, Submodule.coe_add, i2_add_l, HamiltonsCubic.L264Two.oproj_sa h₁ X Y, HamiltonsCubic.L264Two.oproj_sa h₂ X Y,
        ← i2_add_r, ← Submodule.coe_add, hQ Y hY, sub_self]
    rw [map_sub, sub_eq_zero] at h0
    exact h0
  have hQC : ∀ X, C X = P₁ (C X) + P₂ (C X) := fun X => (hQ _ (hran X)).symm
  have hblk : ∀ (V W : Submodule ℝ (skewSub ι)), V ≤ h → (∃ Y ∈ V, Y ≠ 0) → HamiltonsCubic.L264Cross.blk (HamiltonsCubic.L264Two.oproj V) C ≠ 0 := by
    intro V W hV hne hz
    obtain ⟨Y, hY, hY0⟩ := hne
    have e := congrArg (fun T : CurvOp2 ι => T Y) hz
    simp only [HamiltonsCubic.L264Cross.blk_apply, HamiltonsCubic.L264Two.oproj_self V Y hY, _root_.zero_apply] at e
    have hp := hpd Y (hV hY) hY0
    have : inner2 ((HamiltonsCubic.L264Two.oproj V (C Y) : skewSub ι) : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ) = 0 := by rw [e]; simp [inner2]
    rw [HamiltonsCubic.L264Two.oproj_sa, HamiltonsCubic.L264Two.oproj_self V Y hY] at this
    linarith
  obtain ⟨H, hHsa, hHC, hHQ, hQH, hF⟩ := L264_cross_H P₁ P₂ C (HamiltonsCubic.L264Two.oproj_sa h₁) (HamiltonsCubic.L264Two.oproj_sa h₂) (HamiltonsCubic.L264Two.oproj_idem h₁)
    (HamiltonsCubic.L264Two.oproj_idem h₂) o₁₂ o₂₁ (fun X Y => HamiltonsCubic.L264Two.oproj_self h₁ _ (hcl₁ _ (HamiltonsCubic.L264Two.oproj_mem h₁ X) _ (HamiltonsCubic.L264Two.oproj_mem h₁ Y)))
    (fun X Y => HamiltonsCubic.L264Two.oproj_self h₂ _ (hcl₂ _ (HamiltonsCubic.L264Two.oproj_mem h₂ X) _ (HamiltonsCubic.L264Two.oproj_mem h₂ Y)))
    (fun X Y => hcomm _ (HamiltonsCubic.L264Two.oproj_mem h₁ X) _ (HamiltonsCubic.L264Two.oproj_mem h₂ Y)) hCQ hQC hC hidem
    (hblk h₁ h₁ hle₁ hne₁) (hblk h₂ h₂ hle₂ hne₂)
  refine ⟨H, hHsa, hHC, fun X => ?_, fun X hX => ?_, hF⟩
  · rw [hHQ X]; exact h.add_mem (hle₁ (HamiltonsCubic.L264Two.oproj_mem h₁ _)) (hle₂ (HamiltonsCubic.L264Two.oproj_mem h₂ _))
  · rw [hQH X, HamiltonsCubic.L264Two.oproj_zero h₁ X fun Y hY => hX Y (hle₁ hY), HamiltonsCubic.L264Two.oproj_zero h₂ X fun Y hY => hX Y (hle₂ hY), add_zero,
      map_zero]

end Two

section Semi

open HamiltonsCubic.CompactSemisimple

attribute [local instance] LieRing.ofAssociativeRing LieAlgebra.ofAssociativeAlgebra

variable (h : Submodule ℝ (skewSub ι)) (hbr : ∀ X ∈ h, ∀ Y ∈ h, brS X Y ∈ h)

theorem L264_semisimple_H (hss : LieAlgebra.IsSemisimple ℝ (lieOf h hbr))
    (htwo : ∃ I J : LieIdeal ℝ (lieOf h hbr), IsAtom I ∧ IsAtom J ∧ I ≠ J)
    (C : CurvOp2 ι) (hC : IsSelfAdjoint2 C) (hidem : IsIdem C) (hran : ∀ X, C X ∈ h)
    (hpd : ∀ Y ∈ h, Y ≠ 0 → 0 < inner2 ((C Y : skewSub ι) : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ)) :
    ∃ H : CurvOp2 ι, IsSelfAdjoint2 H ∧ innerOp2 H C = 0 ∧ (∀ X, H X ∈ h) ∧
      (∀ X : skewSub ι, (∀ Y ∈ h, inner2 (X : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ) = 0) → H X = 0) ∧
      (1 / 2) * normSq2 H < Ftri C H H := by
  obtain ⟨I, J, hI, hJ, hIJ⟩ := htwo
  set A : Set (LieIdeal ℝ (lieOf h hbr)) := {K | IsAtom K} with hA
  set J' := sSup (A \ {I}) with hJ'
  have hinf : I ⊓ J' = ⊥ := (hss.sSupIndep_isAtom hI).eq_bot
  have hsup : I ⊔ J' = ⊤ := by
    have e : A = insert I (A \ {I}) := by rw [Set.insert_sdiff_singleton, Set.insert_eq_of_mem (show I ∈ A from hI)]
    rw [← hss.sSup_atoms_eq_top]
    show I ⊔ sSup (A \ {I}) = sSup A
    conv_rhs => rw [e]
    rw [sSup_insert]
  have hJ'ne : J' ≠ ⊥ := by
    intro h0
    have hle : J ≤ J' := le_sSup ⟨hJ, fun h' => hIJ (Set.mem_singleton_iff.mp h').symm⟩
    rw [h0] at hle
    exact hJ.1 (le_bot_iff.mp hle)
  have hperf : ⁅I, I⁆ = I := lie_eq_self_of_isAtom_of_nonabelian I hI (hss.non_abelian_of_isAtom I hI)
  exact L264_two_H h (HamiltonsCubic.L264Semi.subOf h hbr I) (HamiltonsCubic.L264Semi.subOf h hbr J') (HamiltonsCubic.L264Semi.subOf_sup h hbr I J' hsup)
    (HamiltonsCubic.L264Semi.subOf_le h hbr I) (HamiltonsCubic.L264Semi.subOf_le h hbr J') (HamiltonsCubic.L264Semi.subOf_closed h hbr I) (HamiltonsCubic.L264Semi.subOf_closed h hbr J')
    (HamiltonsCubic.L264Semi.subOf_comm h hbr I J' hinf) (HamiltonsCubic.L264Semi.subOf_perfect h hbr I hperf) (HamiltonsCubic.L264Semi.subOf_ne h hbr I hI.1) (HamiltonsCubic.L264Semi.subOf_ne h hbr J' hJ'ne)
    C hC hidem hran hpd

end Semi

end HamiltonsCubic.L264Destab
