import Mathlib
import HamiltonsCubic.Results.L264Cross

set_option linter.style.longLine false

/-!
# L264 (2) from a split into commuting ideals

[findings/second-order.md](../../../findings/second-order.md), Lemma L264 (2): *"On a compact semisimple $\mathfrak h$
with two or more simple ideals, no positive-definite idempotent is stable"*, the proof writing
$\mathfrak h=\mathfrak h_1\oplus\mathfrak h_2$. [L264Cross.lean](L264Cross.lean)'s `L264_cross` takes the orthogonal
projections onto the two ideals as hypotheses. This file builds them:

* `skL`, `Vsp`, `oproj`: the orthogonal projection onto a subspace of $\mathfrak{so}(n)$, through Mathlib's
  `starProjection` on the inner product space `SkewSp`, with `oproj_mem`, `oproj_self`, `oproj_idem`, `oproj_sa` and
  `oproj_zero` (it kills what is orthogonal to the subspace);
* `L264_two`: for $\mathfrak h=\mathfrak h_1\oplus\mathfrak h_2$ with $\mathfrak h_1,\mathfrak h_2$ nonzero, closed under
  the bracket, commuting, and $\mathfrak h_1$ spanned by its brackets, a self-adjoint `#`-idempotent with range in
  $\mathfrak h$ and positive definite there is not stable. The ideals come out orthogonal (a bracket of
  $\mathfrak h_1$ is orthogonal to $\mathfrak h_2$ by invariance), and the projections meet `L264_cross`.

That a compact semisimple $\mathfrak h$ with two or more simple ideals has such a split (one simple ideal, which is
perfect, and the sum of the rest) stays with the record.
-/

namespace HamiltonsCubic.L264Two

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.I117S HamiltonsCubic.L264Cross

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- `toSk` as a linear map. -/
noncomputable def skL : skewSub ι →ₗ[ℝ] HamiltonsCubic.FrameExtension.SkewSp ι where
  toFun := toSk
  map_add' _ _ := rfl
  map_smul' _ _ := rfl

/-- The image of a subspace of `𝔰𝔬(n)` in the inner product space. -/
noncomputable def Vsp (V : Submodule ℝ (skewSub ι)) : Submodule ℝ (HamiltonsCubic.FrameExtension.SkewSp ι) :=
  V.map skL

theorem mem_Vsp (V : Submodule ℝ (skewSub ι)) (X : skewSub ι) : toSk X ∈ Vsp V ↔ X ∈ V := by
  constructor
  · rintro ⟨Y, hY, hYX⟩
    have : Y = X := congrArg ofSk hYX
    rw [← this]; exact hY
  · intro h; exact ⟨X, h, rfl⟩

theorem mem_Vsp' (V : Submodule ℝ (skewSub ι)) (x : HamiltonsCubic.FrameExtension.SkewSp ι) :
    x ∈ Vsp V ↔ ofSk x ∈ V := by
  have : x = toSk (ofSk x) := rfl
  conv_lhs => rw [this]
  exact mem_Vsp V (ofSk x)

/-- **The orthogonal projection onto a subspace of `𝔰𝔬(n)`.** -/
noncomputable def oproj (V : Submodule ℝ (skewSub ι)) : CurvOp2 ι :=
  LinearMap.toContinuousLinearMap
    { toFun := fun X => ofSk ((Vsp V).starProjection (toSk X))
      map_add' := fun X Y => by
        show ofSk ((Vsp V).starProjection (toSk X + toSk Y)) = _
        rw [map_add, ofSk_add]
      map_smul' := fun c X => by
        show ofSk ((Vsp V).starProjection (c • toSk X)) = _
        rw [map_smul, ofSk_smul]; rfl }

theorem oproj_apply (V : Submodule ℝ (skewSub ι)) (X : skewSub ι) :
    oproj V X = ofSk ((Vsp V).starProjection (toSk X)) := rfl

theorem oproj_mem (V : Submodule ℝ (skewSub ι)) (X : skewSub ι) : oproj V X ∈ V := by
  rw [oproj_apply, ← mem_Vsp']
  exact Submodule.starProjection_apply_mem _ _

theorem oproj_self (V : Submodule ℝ (skewSub ι)) (Y : skewSub ι) (hY : Y ∈ V) : oproj V Y = Y := by
  rw [oproj_apply, (Submodule.starProjection_eq_self_iff).mpr ((mem_Vsp V Y).mpr hY)]; rfl

theorem oproj_idem (V : Submodule ℝ (skewSub ι)) (X : skewSub ι) : oproj V (oproj V X) = oproj V X :=
  oproj_self V _ (oproj_mem V X)

theorem oproj_sa (V : Submodule ℝ (skewSub ι)) : IsSelfAdjoint2 (oproj V) := fun X Y => by
  show inner2 (HamiltonsCubic.FrameExtension.toM ((Vsp V).starProjection (toSk X))) (HamiltonsCubic.FrameExtension.toM (toSk Y))
    = inner2 (HamiltonsCubic.FrameExtension.toM (toSk X)) (HamiltonsCubic.FrameExtension.toM ((Vsp V).starProjection (toSk Y)))
  rw [← HamiltonsCubic.FrameExtension.inner_def, ← HamiltonsCubic.FrameExtension.inner_def]
  exact Submodule.inner_starProjection_left_eq_right _ _ _

theorem oproj_zero (V : Submodule ℝ (skewSub ι)) (X : skewSub ι)
    (hX : ∀ Y ∈ V, inner2 (X : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ) = 0) : oproj V X = 0 := by
  have hmem : toSk X ∈ (Vsp V)ᗮ := by
    rw [Submodule.mem_orthogonal']
    intro u hu
    rw [HamiltonsCubic.FrameExtension.inner_def]
    exact hX (ofSk u) ((mem_Vsp' V u).mp hu)
  have h0 : (Vsp V).starProjection (toSk X) = 0 := by
    have : toSk X ∈ (Vsp V).starProjection.ker := by rw [Submodule.ker_starProjection]; exact hmem
    exact this
  rw [oproj_apply, h0]; rfl

/-- **L264 (2) on a split into commuting ideals.** Let `𝔥 = 𝔥₁ ⊕ 𝔥₂ ⊆ 𝔰𝔬(n)` with `𝔥₁`, `𝔥₂` nonzero, each closed under
the bracket, `[𝔥₁, 𝔥₂] = 0` and `𝔥₁` spanned by its own brackets, and let `C` be a self-adjoint `#`-idempotent with
range in `𝔥`, positive definite on `𝔥`. Then `C` is not stable. The ideals come out orthogonal, and the orthogonal
projections onto them meet `L264_cross`'s hypotheses. -/
theorem L264_two (h h₁ h₂ : Submodule ℝ (skewSub ι)) (hsum : h ≤ h₁ ⊔ h₂) (hle₁ : h₁ ≤ h) (hle₂ : h₂ ≤ h)
    (hcl₁ : ∀ X ∈ h₁, ∀ Y ∈ h₁, brS X Y ∈ h₁) (hcl₂ : ∀ X ∈ h₂, ∀ Y ∈ h₂, brS X Y ∈ h₂)
    (hcomm : ∀ X ∈ h₁, ∀ Y ∈ h₂, brS X Y = 0)
    (hperf : h₁ ≤ Submodule.span ℝ {W | ∃ A B, A ∈ h₁ ∧ B ∈ h₁ ∧ W = brS A B})
    (hne₁ : ∃ Y ∈ h₁, Y ≠ 0) (hne₂ : ∃ Y ∈ h₂, Y ≠ 0)
    (C : CurvOp2 ι) (hC : IsSelfAdjoint2 C) (hidem : IsIdem C) (hran : ∀ X, C X ∈ h)
    (hpd : ∀ Y ∈ h, Y ≠ 0 → 0 < inner2 ((C Y : skewSub ι) : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ)) :
    ¬ IsStable C := by
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
  set P₁ := oproj h₁ with hP₁
  set P₂ := oproj h₂ with hP₂
  have o₁₂ : ∀ X, P₁ (P₂ X) = 0 := fun X => oproj_zero h₁ _ fun Y hY => orth' _ (oproj_mem h₂ X) Y hY
  have o₂₁ : ∀ X, P₂ (P₁ X) = 0 := fun X => oproj_zero h₂ _ fun Y hY => orth _ (oproj_mem h₁ X) Y hY
  have hdec : ∀ Z ∈ h, ∃ Z₁ ∈ h₁, ∃ Z₂ ∈ h₂, Z₁ + Z₂ = Z := fun Z hZ => Submodule.mem_sup.mp (hsum hZ)
  have hkill : ∀ Z : skewSub ι, (∀ Y ∈ h, inner2 (Z : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ) = 0) → C Z = 0 := by
    intro Z hZ
    refine Subtype.ext (HamiltonsCubic.FrameExtension.inner2_self_eq_zero ?_)
    rw [hC, hZ _ (hran _)]
  have hQ : ∀ Z ∈ h, P₁ Z + P₂ Z = Z := fun Z hZ => by
    obtain ⟨Z₁, h1, Z₂, h2, rfl⟩ := hdec Z hZ
    rw [map_add, map_add, oproj_self h₁ Z₁ h1, oproj_self h₂ Z₂ h2,
      oproj_zero h₁ Z₂ fun Y hY => orth' Z₂ h2 Y hY, oproj_zero h₂ Z₁ fun Y hY => orth Z₁ h1 Y hY]
    abel
  have hCQ : ∀ X, C X = C (P₁ X + P₂ X) := fun X => by
    have h0 : C (X - (P₁ X + P₂ X)) = 0 := hkill _ fun Y hY => by
      rw [Submodule.coe_sub, i2_sub_l, Submodule.coe_add, i2_add_l, oproj_sa h₁ X Y, oproj_sa h₂ X Y,
        ← i2_add_r, ← Submodule.coe_add, hQ Y hY, sub_self]
    rw [map_sub, sub_eq_zero] at h0
    exact h0
  have hQC : ∀ X, C X = P₁ (C X) + P₂ (C X) := fun X => (hQ _ (hran X)).symm
  have hblk : ∀ (V W : Submodule ℝ (skewSub ι)), V ≤ h → (∃ Y ∈ V, Y ≠ 0) → HamiltonsCubic.L264Cross.blk (oproj V) C ≠ 0 := by
    intro V W hV hne hz
    obtain ⟨Y, hY, hY0⟩ := hne
    have e := congrArg (fun T : CurvOp2 ι => T Y) hz
    simp only [HamiltonsCubic.L264Cross.blk_apply, oproj_self V Y hY, _root_.zero_apply] at e
    have hp := hpd Y (hV hY) hY0
    have : inner2 ((oproj V (C Y) : skewSub ι) : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ) = 0 := by rw [e]; simp [inner2]
    rw [oproj_sa, oproj_self V Y hY] at this
    linarith
  exact HamiltonsCubic.L264Cross.L264_cross P₁ P₂ C (oproj_sa h₁) (oproj_sa h₂) (oproj_idem h₁) (oproj_idem h₂)
    o₁₂ o₂₁ (fun X Y => oproj_self h₁ _ (hcl₁ _ (oproj_mem h₁ X) _ (oproj_mem h₁ Y)))
    (fun X Y => oproj_self h₂ _ (hcl₂ _ (oproj_mem h₂ X) _ (oproj_mem h₂ Y)))
    (fun X Y => hcomm _ (oproj_mem h₁ X) _ (oproj_mem h₂ Y)) hCQ hQC hC hidem
    (hblk h₁ h₁ hle₁ hne₁) (hblk h₂ h₂ hle₂ hne₂)

end HamiltonsCubic.L264Two
