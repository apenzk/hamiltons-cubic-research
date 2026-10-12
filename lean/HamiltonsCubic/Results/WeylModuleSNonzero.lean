import HamiltonsCubic.Results.WeylTraceZero
import HamiltonsCubic.Results.WeylRadical

/-!
# The record's `𝒲ₙ` in the layer is nonzero, and the retired `κ` statement was false

From [r1116](../../../reviews/REVIEW_r1116.md). `comp_skewProj_mem`: any member of `weylModule`
precomposed with the skew projection lies in `weylModuleS`, which is one direction of the
identification with the record's `𝒲ₙ`. `weylModuleS_fin4_nonzero`: a nonzero member at `n = 4`, so
`trace_leftMulS_eq_zero'` is not vacuous. `old_comp_statement_false`: the retired form of
`trace_leftMulS_comp`, with `κ` a parameter, is refuted at `Fin 4`; the current form quantifies
`κ` existentially outside the pair.
-/

open HamiltonsCubic.RealLayer HamiltonsCubic.Results HamiltonsCubic.WeylRadical
  HamiltonsCubic.FamilyLayer Matrix

namespace HamiltonsCubic.WeylModuleSNonzero

set_option linter.unusedSectionVars false

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

noncomputable def skewProj (ι : Type*) [Fintype ι] [DecidableEq ι] : CurvLin ι where
  toFun Z := (1/2 : ℝ) • (Z - Zᵀ)
  map_add' X Y := by
    ext p q; simp [Matrix.add_apply, Matrix.sub_apply, Matrix.transpose_apply]; ring
  map_smul' c X := by
    ext p q; simp [Matrix.smul_apply, Matrix.sub_apply, Matrix.transpose_apply]; ring

theorem skewProj_skew (X : Matrix ι ι ℝ) (hX : IsSkew X) : skewProj ι X = X := by
  show (1/2 : ℝ) • (X - Xᵀ) = X
  unfold IsSkew at hX
  rw [hX]; ext p q; simp; ring

theorem skewProj_sym (Z : Matrix ι ι ℝ) (hZ : Zᵀ = Z) : skewProj ι Z = 0 := by
  show (1/2 : ℝ) • (Z - Zᵀ) = 0
  rw [hZ]; simp

theorem comp_skewProj_mem (R : CurvLin ι) (hR : R ∈ weylModule ι) :
    R ∘ₗ skewProj ι ∈ weylModuleS ι := by
  obtain ⟨h1, h2, h3, h4⟩ := hR
  have hs : ∀ X, IsSkew X → (R ∘ₗ skewProj ι) X = R X := fun X hX => by
    rw [LinearMap.comp_apply, skewProj_skew X hX]
  have hphi : ∀ i j, (R ∘ₗ skewProj ι) (phi i j) = R (phi i j) :=
    fun i j => hs _ (phi_isSkew i j)
  refine ⟨⟨fun X hX => ?_, fun X Y hX hY => ?_, fun i j k l => ?_, fun a b => ?_⟩,
    fun Z hZ => ?_⟩
  · show IsSkew ((R ∘ₗ skewProj ι) X); rw [hs X hX]; exact h1 X hX
  · show inner2 ((R ∘ₗ skewProj ι) X) Y = inner2 X ((R ∘ₗ skewProj ι) Y)
    rw [hs X hX, hs Y hY]; exact h2 X Y hX hY
  · have := h3 i j k l
    simp only [bianchi] at this ⊢
    rw [hphi, hphi, hphi]; exact this
  · have := h4 a b
    simp only [Ric] at this ⊢
    simp only [hphi]; exact this
  · show R (skewProj ι Z) = 0
    rw [skewProj_sym Z hZ, map_zero]

theorem inner2_self_eq_zero (A : Matrix ι ι ℝ) (h : inner2 A A = 0) : A = 0 := by
  rw [inner2_eq_sum] at h
  have hs : ∑ a : ι, ∑ b : ι, A a b * A a b = 0 := by linarith
  ext a b
  have h1 := (Finset.sum_eq_zero_iff_of_nonneg (fun a _ =>
    Finset.sum_nonneg fun b _ => mul_self_nonneg (A a b))).mp hs a (Finset.mem_univ a)
  have h2 := (Finset.sum_eq_zero_iff_of_nonneg (fun b _ => mul_self_nonneg (A a b))).mp h1 b
    (Finset.mem_univ b)
  simpa using mul_self_eq_zero.mp h2

/-- **The retired statement of `trace_leftMulS_comp` was FALSE as quantified, at `Fin 4`**: its `kappa`
is universally quantified, so at one nonzero `e = f` it asserts `tr = 0·‖e‖²` and `tr = 1·‖e‖²`. -/
theorem old_comp_statement_false : ¬ (∀ (kappa : ℝ) (e f : CurvLin (Fin 4)),
    e ∈ weylModuleS (Fin 4) → f ∈ weylModuleS (Fin 4) →
    ∀ (Le Lf : weylModuleS (Fin 4) →ₗ[ℝ] weylModuleS (Fin 4)),
      (∀ (Y : weylModuleS (Fin 4)) (Z : Matrix (Fin 4) (Fin 4) ℝ),
        (Le Y : CurvLin (Fin 4)) Z = foxProd (fun A => e A) (fun A => (Y : CurvLin (Fin 4)) A) Z) →
      (∀ (Y : weylModuleS (Fin 4)) (Z : Matrix (Fin 4) (Fin 4) ℝ),
        (Lf Y : CurvLin (Fin 4)) Z = foxProd (fun A => f A) (fun A => (Y : CurvLin (Fin 4)) A) Z) →
      LinearMap.trace ℝ (weylModuleS (Fin 4)) (Le ∘ₗ Lf)
        = kappa * innerOp (fun A => e A) (fun A => f A)) := by
  intro H
  let S : Finset (Fin 4) := {0, 1}
  let w : CurvLin (Fin 4) := diagOpL (sphereWeight S) ∘ₗ skewProj (Fin 4)
  have hw : w ∈ weylModuleS (Fin 4) := comp_skewProj_mem _
    (diagOpL_mem (sphereWeight_isWeight S (by decide) (by decide)))
  obtain ⟨L, hL⟩ := leftMulS_exists w hw
  have h0 := H 0 w w hw hw L L hL hL
  have h1 := H 1 w w hw hw L L hL hL
  have hn : innerOp (fun A => w A) (fun A => w A) = 0 := by rw [h0] at h1; linarith
  have hne := sphereWeight_diagOpL_ne_zero S (by decide) (by decide) (a := 0) (b := 2)
    (by decide) (by decide)
  apply hne
  have hw02 : w (phi 0 2) = diagOpL (sphereWeight S) (phi 0 2) := by
    show diagOpL (sphereWeight S) (skewProj (Fin 4) (phi 0 2)) = _
    rw [skewProj_skew _ (phi_isSkew 0 2)]
  rw [← hw02]
  apply inner2_self_eq_zero
  unfold innerOp at hn
  have hs : ∑ i : Fin 4, ∑ j : Fin 4, inner2 (w (phi i j)) (w (phi i j)) = 0 := by linarith
  have k1 := (Finset.sum_eq_zero_iff_of_nonneg (fun i _ =>
    Finset.sum_nonneg fun j _ => HamiltonsCubic.RealLayer.inner2_self_nonneg (w (phi i j)))).mp
    hs 0 (Finset.mem_univ _)
  exact (Finset.sum_eq_zero_iff_of_nonneg (fun j _ =>
    HamiltonsCubic.RealLayer.inner2_self_nonneg (w (phi 0 j)))).mp k1 2 (Finset.mem_univ _)


/-- **The record's `𝒲₄` is nonzero in the layer**, so the trace statements quantify over something. -/
theorem weylModuleS_fin4_nonzero : ∃ w ∈ weylModuleS (Fin 4), w ≠ 0 := by
  let S : Finset (Fin 4) := {0, 1}
  refine ⟨diagOpL (sphereWeight S) ∘ₗ skewProj (Fin 4), comp_skewProj_mem _
    (diagOpL_mem (sphereWeight_isWeight S (by decide) (by decide))), fun h0 => ?_⟩
  have hne := sphereWeight_diagOpL_ne_zero S (by decide) (by decide) (a := 0) (b := 2)
    (by decide) (by decide)
  apply hne
  have := congrArg (fun L : CurvLin (Fin 4) => L (phi 0 2)) h0
  simp only [LinearMap.comp_apply, LinearMap.zero_apply] at this
  rw [skewProj_skew _ (phi_isSkew 0 2)] at this
  exact this

end HamiltonsCubic.WeylModuleSNonzero
