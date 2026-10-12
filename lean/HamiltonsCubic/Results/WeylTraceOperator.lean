import HamiltonsCubic.Results.WeylTraceForm

/-!
# The operator `T` of the trace form on the record's `𝒲ₙ`

Stage 2 of the approved `trace_leftMulS_comp` build. **`T` is the operator with
`⟨T e, f⟩ = B(e,f)`, and it commutes with the orthogonal action and is self-adjoint**
(`Top_spec`, `Top_act`, `Top_symm`). `⟨·,·⟩` is `innerOp` read as a bilinear form `Jb`, positive
definite on `𝒲ₙ` (`Jb_pos`) and invariant (`Jb_act`, from `innerOp_act`).

*`T` is built on coordinates.* `LinearMap.BilinForm.toDual` on `↥(weylModuleS ι)` does not
elaborate, because the submodule's `AddCommMonoid` and the one derived from its `AddCommGroup` do
not unify at instance transparency. So `T` is transported through a basis to `Fin d → ℝ`, where
the dual-space instances are the standard ones, and back.
-/

set_option linter.style.longLine false
set_option linter.style.haveILetI false

namespace HamiltonsCubic.Results

open HamiltonsCubic.RealLayer Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

set_option linter.unusedSectionVars false

theorem sw4 {α β γ δ : Type*} [Fintype α] [Fintype β] [Fintype γ] [Fintype δ]
    (f : α → β → γ → δ → ℝ) :
    ∑ i, ∑ j, ∑ k, ∑ l, f i j k l = ∑ k, ∑ l, ∑ i, ∑ j, f i j k l := by
  calc ∑ i, ∑ j, ∑ k, ∑ l, f i j k l = ∑ i, ∑ k, ∑ l, ∑ j, f i j k l :=
        Finset.sum_congr rfl fun i _ => by rw [Finset.sum_comm]; exact Finset.sum_congr rfl fun k _ => Finset.sum_comm
    _ = ∑ k, ∑ l, ∑ i, ∑ j, f i j k l := by
        rw [Finset.sum_comm]; exact Finset.sum_congr rfl fun k _ => Finset.sum_comm

theorem inner2_conj_orth {g : Matrix ι ι ℝ} (hg : gᵀ * g = 1) (A B : Matrix ι ι ℝ) :
    inner2 (g * A * gᵀ) (g * B * gᵀ) = inner2 A B := by
  unfold inner2; congr 1
  simp only [Matrix.transpose_mul, Matrix.transpose_transpose, Matrix.mul_assoc]
  rw [← Matrix.mul_assoc gᵀ g, hg, Matrix.one_mul, Matrix.trace_mul_comm, Matrix.mul_assoc, Matrix.mul_assoc,
    hg, Matrix.mul_one]

/-- Move the first summation variable of six to the innermost position. -/
theorem sum_in6 {α : Type*} [Fintype α] (f : α → α → α → α → α → α → ℝ) :
    ∑ i, ∑ j, ∑ a, ∑ b, ∑ c, ∑ d, f i j a b c d = ∑ j, ∑ a, ∑ b, ∑ c, ∑ d, ∑ i, f i j a b c d := by
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun b _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun c _ => ?_
  rw [Finset.sum_comm]

theorem sum_in5 {α : Type*} [Fintype α] (f : α → α → α → α → α → α → ℝ) :
    ∑ j, ∑ a, ∑ b, ∑ c, ∑ d, ∑ i, f i j a b c d = ∑ a, ∑ b, ∑ c, ∑ d, ∑ i, ∑ j, f i j a b c d := by
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun b _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun c _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun d _ => ?_
  rw [Finset.sum_comm]

theorem orth_sum {g : Matrix ι ι ℝ} (hg : gᵀ * g = 1) (F : ι → ι → ι → ι → ℝ) :
    ∑ i, ∑ j, ∑ a, ∑ b, ∑ c, ∑ d, g i a * g j b * (g i c * g j d * F a b c d) = ∑ a, ∑ b, F a b a b := by
  have hgg : ∀ a c, ∑ i, g i a * g i c = if a = c then 1 else 0 := fun a c => by
    have := congrFun (congrFun hg a) c
    simpa [Matrix.mul_apply, Matrix.one_apply] using this
  rw [sum_in6 (fun i j a b c d => g i a * g j b * (g i c * g j d * F a b c d)),
    sum_in5 (fun i j a b c d => g i a * g j b * (g i c * g j d * F a b c d))]
  refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
  have e : ∀ c d, ∑ i, ∑ j, g i a * g j b * (g i c * g j d * F a b c d)
      = (∑ i, g i a * g i c) * (∑ j, g j b * g j d) * F a b c d := by
    intro c d
    rw [Finset.sum_mul_sum, Finset.sum_mul]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.sum_mul]
    exact Finset.sum_congr rfl fun j _ => by ring
  simp only [e, hgg]
  simp

/-- **`⟨·,·⟩` is invariant under the orthogonal action.** -/
theorem innerOp_act {g : Matrix ι ι ℝ} (hg : gᵀ * g = 1) (R S : CurvLin ι) :
    innerOp (fun Z => act g R Z) (fun Z => act g S Z) = innerOp (fun Z => R Z) (fun Z => S Z) := by
  unfold innerOp
  congr 1
  simp only [act_apply]
  simp only [inner2_conj_orth hg]
  rw [← orth_sum hg (fun a b c d => inner2 (R (phi a b)) (S (phi c d)))]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  rw [rot_phi]
  simp only [map_sum, map_smul, inner2_sumL, inner2_sumR, inner2_smul_left'', inner2_smul_right'', Finset.mul_sum]
  rw [sw4]
  exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
    Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => by ring


/-- An operator of the record's `𝒲ₙ` vanishing on every `φ_ij` is zero. -/
theorem eq_zero_of_phi (R : CurvLin ι) (hR : R ∈ weylModuleS ι) (hphi : ∀ i j, R (phi i j) = 0) : R = 0 := by
  have hskew : ∀ X, IsSkew X → R X = 0 := by
    intro X hX
    rw [skew_expand X hX]
    simp [map_sum, map_smul, hphi]
  apply LinearMap.ext; intro Z
  have hZ : Z = (1 / 2 : ℝ) • (Z - Zᵀ) + (1 / 2 : ℝ) • (Z + Zᵀ) := by
    ext p q; simp [Matrix.add_apply, Matrix.sub_apply]; ring
  have hA : IsSkew ((1 / 2 : ℝ) • (Z - Zᵀ)) := by
    unfold IsSkew; rw [Matrix.transpose_smul, Matrix.transpose_sub, Matrix.transpose_transpose]
    ext p q; simp [Matrix.sub_apply]; ring
  have hS : ((1 / 2 : ℝ) • (Z + Zᵀ))ᵀ = (1 / 2 : ℝ) • (Z + Zᵀ) := by
    rw [Matrix.transpose_smul, Matrix.transpose_add, Matrix.transpose_transpose, add_comm]
  rw [hZ, map_add, hskew _ hA, hR.2 _ hS, add_zero]
  simp

theorem inner2_self_eq_zero'' {X : Matrix ι ι ℝ} (h : inner2 X X = 0) : X = 0 := by
  rw [inner2_eq_sum] at h
  have h' : ∑ a, ∑ b, X a b * X a b = 0 := by linarith
  have hnn : ∀ a ∈ (Finset.univ : Finset ι), 0 ≤ ∑ b, X a b * X a b :=
    fun a _ => Finset.sum_nonneg fun b _ => mul_self_nonneg _
  ext a b
  have h1 := (Finset.sum_eq_zero_iff_of_nonneg hnn).mp h' a (Finset.mem_univ a)
  have h2 := (Finset.sum_eq_zero_iff_of_nonneg (fun b _ => mul_self_nonneg (X a b))).mp h1 b (Finset.mem_univ b)
  simpa using mul_self_eq_zero.mp h2

theorem inner2_self_nonneg'' (X : Matrix ι ι ℝ) : 0 ≤ inner2 X X := by
  rw [inner2_eq_sum]
  exact mul_nonneg (by norm_num) (Finset.sum_nonneg fun a _ => Finset.sum_nonneg fun b _ => mul_self_nonneg _)

/-- **`L` is linear in `e`.** -/
theorem Lop_add (e f : weylModuleS ι) : Lop (e + f) = Lop e + Lop f :=
  leftMulS_unique _ _ _ (Lop_spec (e + f)) (fun Y Z => by
    rw [LinearMap.add_apply, Submodule.coe_add, LinearMap.add_apply, Lop_spec, Lop_spec, Submodule.coe_add,
      foxProd_add_left'])

theorem foxProd_smul_left' (c : ℝ) (X Y : CurvLin ι) (Z : Matrix ι ι ℝ) :
    foxProd (fun A => (c • X) A) (fun A => Y A) Z = c • foxProd (fun A => X A) (fun A => Y A) Z := by
  rw [foxProd_comm, foxProd_comm (fun A => X A)]
  have : (fun A => (c • X) A) = fun W => c • X W := by funext W; simp
  rw [this]
  exact foxProd_smul_right c _ _ (isLinOp_of_curvLin Y) (isLinOp_of_curvLin X) Z

theorem Lop_smul (c : ℝ) (e : weylModuleS ι) : Lop (c • e) = c • Lop e :=
  leftMulS_unique _ _ _ (Lop_spec (c • e)) (fun Y Z => by
    rw [LinearMap.smul_apply, Submodule.coe_smul, LinearMap.smul_apply, Lop_spec, Submodule.coe_smul,
      foxProd_smul_left'])

/-- `B` as a bilinear form. -/
noncomputable def Bb : LinearMap.BilinForm ℝ (weylModuleS ι) :=
  LinearMap.mk₂ ℝ Bform
    (fun e e' f => by unfold Bform; rw [Lop_add, LinearMap.add_comp, map_add])
    (fun c e f => by unfold Bform; rw [Lop_smul, LinearMap.smul_comp, map_smul, smul_eq_mul])
    (fun e f f' => by unfold Bform; rw [Lop_add, LinearMap.comp_add, map_add])
    (fun c e f => by unfold Bform; rw [Lop_smul, LinearMap.comp_smul, map_smul, smul_eq_mul])

theorem innerOp_add_l (R R' S : CurvLin ι) :
    innerOp (fun Z => (R + R') Z) (fun Z => S Z) = innerOp (fun Z => R Z) (fun Z => S Z) + innerOp (fun Z => R' Z) (fun Z => S Z) := by
  unfold innerOp; simp only [LinearMap.add_apply, inner2_add_left'', Finset.sum_add_distrib]; ring
theorem innerOp_smul_l (c : ℝ) (R S : CurvLin ι) :
    innerOp (fun Z => (c • R) Z) (fun Z => S Z) = c * innerOp (fun Z => R Z) (fun Z => S Z) := by
  unfold innerOp; simp only [LinearMap.smul_apply, inner2_smul_left'', Finset.mul_sum]; ring
theorem innerOp_comm' (R S : CurvLin ι) : innerOp (fun Z => R Z) (fun Z => S Z) = innerOp (fun Z => S Z) (fun Z => R Z) := by
  unfold innerOp; congr 1
  exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => inner2_comm _ _

/-- `⟨·,·⟩` as a bilinear form on `𝒲ₙ`. -/
noncomputable def Jb : LinearMap.BilinForm ℝ (weylModuleS ι) :=
  LinearMap.mk₂ ℝ (fun e f => innerOp (fun Z => (e : CurvLin ι) Z) (fun Z => (f : CurvLin ι) Z))
    (fun e e' f => by simp only [Submodule.coe_add]; exact innerOp_add_l _ _ _)
    (fun c e f => by simp only [Submodule.coe_smul, smul_eq_mul]; exact innerOp_smul_l _ _ _)
    (fun e f f' => by
      simp only [Submodule.coe_add]; rw [innerOp_comm', innerOp_add_l, innerOp_comm', innerOp_comm' (f' : CurvLin ι)])
    (fun c e f => by
      simp only [Submodule.coe_smul, smul_eq_mul]; rw [innerOp_comm', innerOp_smul_l, innerOp_comm'])

theorem Jb_apply (e f : weylModuleS ι) :
    Jb e f = innerOp (fun Z => (e : CurvLin ι) Z) (fun Z => (f : CurvLin ι) Z) := rfl

theorem Jb_pos (e : weylModuleS ι) (h : Jb e e = 0) : e = 0 := by
  rw [Jb_apply] at h
  unfold innerOp at h
  have hnn : ∀ i ∈ (Finset.univ : Finset ι), 0 ≤ ∑ j, inner2 ((e : CurvLin ι) (phi i j)) ((e : CurvLin ι) (phi i j)) :=
    fun i _ => Finset.sum_nonneg fun j _ => inner2_self_nonneg'' _
  have hs : ∑ i, ∑ j, inner2 ((e : CurvLin ι) (phi i j)) ((e : CurvLin ι) (phi i j)) = 0 := by linarith
  have hphi : ∀ i j, (e : CurvLin ι) (phi i j) = 0 := fun i j => by
    have h1 := (Finset.sum_eq_zero_iff_of_nonneg hnn).mp hs i (Finset.mem_univ i)
    exact inner2_self_eq_zero'' ((Finset.sum_eq_zero_iff_of_nonneg
      (fun j _ => inner2_self_nonneg'' _)).mp h1 j (Finset.mem_univ j))
  exact Subtype.ext (eq_zero_of_phi _ e.2 hphi)

theorem Jb_symm (e f : weylModuleS ι) : Jb e f = Jb f e := by rw [Jb_apply, Jb_apply, innerOp_comm']

set_option maxHeartbeats 1000000 in
instance fdCurv : FiniteDimensional ℝ (CurvLin ι) := by unfold CurvLin; infer_instance

instance fdW : FiniteDimensional ℝ (weylModuleS ι) := FiniteDimensional.finiteDimensional_submodule _

theorem Jb_nondeg : (Jb (ι := ι)).Nondegenerate :=
  ⟨fun e he => Jb_pos e (he e), fun e he => Jb_pos e (by rw [Jb_symm]; exact he e)⟩

/-- **A finite basis of `𝒲ₙ`.** The `Module.Free` hint through the explicit coercion is
load-bearing, as in `weylTrace_id`. -/
noncomputable def bW : Σ d : ℕ, Module.Basis (Fin d) ℝ (weylModuleS ι) := by
  haveI : Module.Free ℝ ↑↑(weylModuleS ι) := Module.Free.of_divisionRing ℝ ↑↑(weylModuleS ι)
  haveI : Module.Finite ℝ (weylModuleS ι) := FiniteDimensional.finiteDimensional_submodule _
  exact ⟨_, Module.finBasis ℝ (weylModuleS ι)⟩

/-- Coordinates on `𝒲ₙ`, where the dual-space instances are the standard ones. -/
abbrev VW (ι : Type*) [Fintype ι] [DecidableEq ι] : Type := Fin (bW (ι := ι)).1 → ℝ

noncomputable def eW : weylModuleS ι ≃ₗ[ℝ] VW ι := (bW (ι := ι)).2.equivFun

noncomputable def JV : LinearMap.BilinForm ℝ (VW ι) :=
  (Jb (ι := ι)).compl₁₂ (eW (ι := ι)).symm.toLinearMap (eW (ι := ι)).symm.toLinearMap

noncomputable def BV : LinearMap.BilinForm ℝ (VW ι) :=
  (Bb (ι := ι)).compl₁₂ (eW (ι := ι)).symm.toLinearMap (eW (ι := ι)).symm.toLinearMap

theorem JV_apply (x y : VW ι) : JV x y = Jb (eW.symm x) (eW.symm y) := rfl
theorem BV_apply (x y : VW ι) : BV x y = Bform (eW.symm x) (eW.symm y) := rfl

theorem JV_nondeg : (JV (ι := ι)).Nondegenerate := by
  have key : ∀ m : VW ι, JV m m = 0 → m = 0 := fun m h => by
    rw [JV_apply] at h
    have := Jb_pos _ h
    simpa using congrArg eW this
  exact ⟨fun m hm => key m (hm m), fun m hm => key m (hm m)⟩

noncomputable def TV : VW ι →ₗ[ℝ] VW ι :=
  (LinearMap.BilinForm.toDual (JV (ι := ι)) JV_nondeg).symm.toLinearMap ∘ₗ (BV (ι := ι))

/-- **The operator `T`** with `⟨T e, f⟩ = B(e,f)`. -/
noncomputable def Tw : weylModuleS ι →ₗ[ℝ] weylModuleS ι :=
  (eW (ι := ι)).symm.toLinearMap ∘ₗ TV ∘ₗ (eW (ι := ι)).toLinearMap

theorem Tw_apply (e : weylModuleS ι) : Tw e = eW.symm (TV (eW e)) := rfl

theorem JV_TV (x y : VW ι) : JV (TV x) y = BV x y := by
  rw [← LinearMap.BilinForm.toDual_def (B := JV) (b := JV_nondeg)]
  simp [TV]

theorem Top_spec (e f : weylModuleS ι) : Jb (Tw e) f = Bform e f := by
  have h := JV_TV (eW e) (eW f)
  rw [JV_apply, BV_apply] at h
  simpa [Tw_apply] using h

theorem Jb_act {g : Matrix ι ι ℝ} (hg : gᵀ * g = 1) (e f : weylModuleS ι) :
    Jb (actS g hg e) (actS g hg f) = Jb e f := by
  rw [Jb_apply, Jb_apply]; exact innerOp_act hg _ _

theorem Jb_ext {x y : weylModuleS ι} (h : ∀ f, Jb x f = Jb y f) : x = y := by
  apply eW.injective
  apply (LinearMap.BilinForm.toDual (JV (ι := ι)) JV_nondeg).injective
  refine LinearMap.ext fun z => ?_
  rw [LinearMap.BilinForm.toDual_def, LinearMap.BilinForm.toDual_def, JV_apply, JV_apply]
  simpa using h (eW.symm z)

/-- **`T` commutes with the orthogonal action.** -/
theorem Top_act {g : Matrix ι ι ℝ} (hg : gᵀ * g = 1) (e : weylModuleS ι) :
    Tw (actS g hg e) = actS g hg (Tw e) := by
  have hg' := orth_comm hg
  have hgT : gᵀᵀ * gᵀ = 1 := by rw [Matrix.transpose_transpose]; exact hg'
  have hinv : ∀ f, actS g hg (actS gᵀ hgT f) = f := fun f =>
    (actE g hg hg').apply_symm_apply f
  apply Jb_ext
  intro f
  rw [Top_spec, ← hinv f, Bform_act, Jb_act hg, Top_spec]

/-- **`T` is self-adjoint.** -/
theorem Top_symm (e f : weylModuleS ι) : Jb (Tw e) f = Jb e (Tw f) := by
  rw [Top_spec, Bform_symm, ← Top_spec]
  rw [Jb_apply, Jb_apply, innerOp_comm']

end HamiltonsCubic.Results
