import HamiltonsCubic.Results.B12PairSector
import HamiltonsCubic.Results.L120Diag
import HamiltonsCubic.Results.L127DnEig

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# B12, step 5a: `L_e` on the diagonal sector is `KL` on the weights

The sector `t = ∅` of `weylModuleS` is the diagonal operators `diagW v` of the weights `v ∈ 𝒟ₙ`
([L120Diag.lean](L120Diag.lean)'s `diagSummand_iff`), and [L127Dn.lean](L127Dn.lean)'s `foxProd_diag` gives the Fox product of
two of them as `diagOp (K v)` on bivectors, `K v = w ⊙ v + ½(wv + vw)`, whose off-diagonal part is
[L127DnExcl.lean](L127DnExcl.lean)'s `KL w v`:

* `mem_range_projS_diag`: `range P_∅` is exactly the `diagW v` at weights `v`;
* **`Lop_diagW`**: at weights `w`, `v`, `L_{diagW w}` sends `diagW v` to `diagW (KL w v)`, and **`KL_weight`**: `KL w v` is a
  weight, read off the sign-fixed image through `diagSummand_iff`;
* `diagEquiv`: `𝒟ₙ ≃ range P_∅` through `diagW`;
* **`trace_diag_sector`**: `tr(L_{diagW w}² ∘ P_∅) = tr((KL w)²|_{𝒟ₙ})`.
-/

namespace HamiltonsCubic.B12Diag

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.Results HamiltonsCubic.B12Sphere
  HamiltonsCubic.B12Sectors HamiltonsCubic.B12Restrict HamiltonsCubic.B12Four HamiltonsCubic.L120Decomp
  HamiltonsCubic.L120HessPair

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem setChar_empty (ε : ι → ℝ) : HamiltonsCubic.L120Blocks.setChar (∅ : Finset ι) ε = 1 := by
  simp [HamiltonsCubic.L120Blocks.setChar]

/-- **The diagonal sector is `diagW` of the weights.** -/
theorem mem_range_projS_diag (Y : weylModuleS ι) :
    Y ∈ LinearMap.range (projS (∅ : Finset ι)) ↔ ∃ v, IsWeight v ∧ (Y : CurvLin ι) = diagW v := by
  constructor
  · rintro ⟨Z, rfl⟩
    have hfix : ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) →
        act (signMat ε) ((projS ∅ Z : weylModuleS ι) : CurvLin ι) = projS ∅ Z := fun ε hε => by
      rw [projS_coe, proj_signMat _ _ ε hε, setChar_empty, one_smul]
    exact (diagSummand_iff _ (projS ∅ Z).2).mp hfix
  · rintro ⟨v, hv, hY⟩
    refine ⟨Y, Subtype.ext ?_⟩
    rw [projS_coe]
    have h := HamiltonsCubic.CompChar.proj_of_char (u := (∅ : Finset ι)) (B := (Y : CurvLin ι))
      (fun ε hε => by rw [hY, setChar_empty, one_smul]; exact diagS_signMat hv ε hε) ∅
    rw [if_pos rfl] at h
    exact h

theorem diagW_apply_skew' (w : Matrix ι ι ℝ) (X : Matrix ι ι ℝ) (hX : IsSkew X) : diagW w X = diagOp w X := by
  show diagOp w (HamiltonsCubic.WeylModuleSNonzero.skewProj ι X) = _
  rw [HamiltonsCubic.WeylModuleSNonzero.skewProj_skew X hX]

/-- `L_e` of a diagonal operator on `φ_ab`, as a Fox product of bare diagonal operators. -/
theorem Lop_diag_phi {w v : Matrix ι ι ℝ} (hw : IsWeight w) (hv : IsWeight v) (a b : ι) :
    ((Lop ⟨diagW w, diagW_mem hw⟩ ⟨diagW v, diagW_mem hv⟩ : weylModuleS ι) : CurvLin ι) (phi a b)
      = Kmat w v a b • phi a b := by
  rw [Lop_spec]
  have hZ := phi_isSkew a b
  rw [HamiltonsCubic.TensorBridge.foxProd_congr_on_skew
    (X := fun A => diagW w A) (Y := fun A => diagW v A) (X' := diagOp w) (Y' := diagOp v)
    (fun Z hZ' => by rw [diagW_apply_skew' w Z hZ']; exact diagOp_skew w hw.symm Z hZ')
    (fun Z hZ' => by rw [diagW_apply_skew' v Z hZ']; exact diagOp_skew v hv.symm Z hZ')
    (fun Z hZ' => diagW_apply_skew' w Z hZ') (fun Z hZ' => diagW_apply_skew' v Z hZ') (phi a b) hZ]
  exact foxProd_diag w v hw.symm hv.symm hw.hollow hv.hollow a b

/-- **The image is `diagW (KL w v)`, and `KL w v` is a weight.** -/
theorem Lop_diagW {w v : Matrix ι ι ℝ} (hw : IsWeight w) (hv : IsWeight v) :
    IsWeight (KL w v) ∧
      ((Lop ⟨diagW w, diagW_mem hw⟩ ⟨diagW v, diagW_mem hv⟩ : weylModuleS ι) : CurvLin ι) = diagW (KL w v) := by
  set e : weylModuleS ι := ⟨diagW w, diagW_mem hw⟩
  set Y : weylModuleS ι := ⟨diagW v, diagW_mem hv⟩
  have hfixY : ∀ u : Finset ι, act (diagSet u) (Y : CurvLin ι) = Y := fun u => diagW_diagSet hv u
  have hfix : ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → act (signMat ε) ((Lop e Y : weylModuleS ι) : CurvLin ι) = Lop e Y := by
    intro ε hε
    rw [signMat_eq_diag_set ε hε]
    have hc := congrArg (fun L => ((L Y : weylModuleS ι) : CurvLin ι)) (Lop_actS e (Finset.univ.filter fun i => ε i = -1)
      (diagW_diagSet hw _))
    simp only [LinearMap.comp_apply] at hc
    have hY : actS (diagSet (Finset.univ.filter fun i => ε i = -1)) (diagSet_orth _) Y = Y :=
      Subtype.ext (hfixY _)
    rw [hY] at hc
    exact hc.symm
  obtain ⟨u, hu, hLu⟩ := (diagSummand_iff _ (Lop e Y).2).mp hfix
  have hoff : ∀ a b, a ≠ b → u a b = Kmat w v a b := by
    intro a b hab
    have h1 := congrArg (fun F : CurvLin ι => inner2 (F (phi a b)) (phi a b)) hLu
    rw [Lop_diag_phi hw hv a b] at h1
    change inner2 (Kmat w v a b • phi a b) (phi a b) = inner2 (diagS u (phi a b)) (phi a b) at h1
    rw [diagS_phi hu.symm, inner2_smul_left'', inner2_smul_left'', Results.inner2_phi_phi, if_pos ⟨rfl, rfl⟩,
      if_neg (fun h => hab h.1)] at h1
    simpa using h1.symm
  have huKL : u = KL w v := by
    ext a b
    by_cases hab : a = b
    · subst hab
      rw [hu.hollow a]
      change (0 : ℝ) = (if a = a then 0 else Kmat w v a a)
      rw [if_pos rfl]
    · rw [hoff a b hab]
      change Kmat w v a b = (if a = b then 0 else Kmat w v a b)
      rw [if_neg hab]
  subst huKL
  exact ⟨hu, hLu⟩

theorem KL_weight {w v : Matrix ι ι ℝ} (hw : IsWeight w) (hv : IsWeight v) : IsWeight (KL w v) :=
  (Lop_diagW hw hv).1

theorem KL_mapsTo {w : Matrix ι ι ℝ} (hw : IsWeight w) :
    ∀ v ∈ dnWeights ι, KL w v ∈ dnWeights ι := fun v hv => KL_weight hw hv

theorem diagW_inj {v v' : Matrix ι ι ℝ} (hv : IsWeight v) (hv' : IsWeight v') (h : diagW v = diagW v') : v = v' := by
  ext a b
  by_cases hab : a = b
  · subst hab; rw [hv.hollow a, hv'.hollow a]
  · have e := congrArg (fun F : CurvLin ι => inner2 (F (phi a b)) (phi a b)) h
    change inner2 (diagS v (phi a b)) (phi a b) = inner2 (diagS v' (phi a b)) (phi a b) at e
    rw [diagS_phi hv.symm, diagS_phi hv'.symm, inner2_smul_left'', inner2_smul_left'', Results.inner2_phi_phi,
      if_pos ⟨rfl, rfl⟩, if_neg (fun h => hab h.1)] at e
    simpa using e

/-- `diagW` from the weights into the diagonal sector. -/
noncomputable def diagSec : dnWeights ι →ₗ[ℝ] LinearMap.range (projS (∅ : Finset ι)) where
  toFun v := ⟨⟨diagW v, diagW_mem v.2⟩, (mem_range_projS_diag _).mpr ⟨v, v.2, rfl⟩⟩
  map_add' v u := by
    apply Subtype.ext; apply Subtype.ext
    show diagW ((v : Matrix ι ι ℝ) + (u : Matrix ι ι ℝ)) = diagW (v : Matrix ι ι ℝ) + diagW (u : Matrix ι ι ℝ)
    apply LinearMap.ext; intro X
    show diagOp _ _ = diagOp _ _ + diagOp _ _
    ext p q; simp [diagOp, add_mul]
  map_smul' c v := by
    apply Subtype.ext; apply Subtype.ext
    show diagW (c • (v : Matrix ι ι ℝ)) = c • diagW (v : Matrix ι ι ℝ)
    apply LinearMap.ext; intro X
    show diagOp _ _ = c • diagOp _ _
    ext p q; simp [diagOp, mul_assoc]

/-- **`𝒟ₙ ≃ range P_∅`.** -/
noncomputable def diagEquiv : dnWeights ι ≃ₗ[ℝ] LinearMap.range (projS (∅ : Finset ι)) :=
  LinearEquiv.ofBijective diagSec
    ⟨fun v u h => Subtype.ext (diagW_inj v.2 u.2
        (congrArg (fun y : LinearMap.range (projS (∅ : Finset ι)) => ((y : weylModuleS ι) : CurvLin ι)) h)),
      fun y => by
        obtain ⟨v, hv, hvy⟩ := (mem_range_projS_diag (y : weylModuleS ι)).mp y.2
        exact ⟨⟨v, hv⟩, Subtype.ext (Subtype.ext hvy.symm)⟩⟩

/-- `(KL w)²` restricted to the weights. -/
noncomputable def KL2 {w : Matrix ι ι ℝ} (hw : IsWeight w) : Module.End ℝ (dnWeights ι) :=
  (KL w ∘ₗ KL w).restrict (fun v hv => KL_mapsTo hw _ (KL_mapsTo hw v hv))

/-- **The diagonal sector contributes `tr((KL w)²|_{𝒟ₙ})`.** -/
theorem trace_diag_sector {w : Matrix ι ι ℝ} (hw : IsWeight w) :
    LinearMap.trace ℝ (weylModuleS ι)
        ((Lop ⟨diagW w, diagW_mem hw⟩ ∘ₗ Lop ⟨diagW w, diagW_mem hw⟩) ∘ₗ projS (∅ : Finset ι))
      = LinearMap.trace ℝ (dnWeights ι) (KL2 hw) := by
  set e : weylModuleS ι := ⟨diagW w, diagW_mem hw⟩ with he_def
  have he : ∀ u : Finset ι, act (diagSet u) (e : CurvLin ι) = e := fun u => diagW_diagSet hw u
  rw [trace_sector_restrict e he]
  set ψ := (diagEquiv : dnWeights ι ≃ₗ[ℝ] LinearMap.range (projS (∅ : Finset ι)))
  have step : ∀ v : Matrix ι ι ℝ, ∀ hv : IsWeight v, Lop e ⟨diagW v, diagW_mem hv⟩
      = ⟨diagW (KL w v), diagW_mem (KL_weight hw hv)⟩ :=
    fun v hv => Subtype.ext (Lop_diagW hw hv).2
  have hkey : ∀ v : dnWeights ι,
      (Lop e ∘ₗ Lop e).restrict (fun x hx => mapsTo_range (V := weylModuleS ι) (A := Lop e ∘ₗ Lop e)
        (P := projS (∅ : Finset ι)) (sq_comm e he _) hx) (ψ v) = ψ (KL2 hw v) := by
    intro v
    apply Subtype.ext
    show (Lop e ∘ₗ Lop e) ⟨diagW v, diagW_mem v.2⟩ = ⟨diagW (KL w (KL w v)), _⟩
    rw [LinearMap.comp_apply, step _ v.2, step _ (KL_weight hw v.2)]
  rw [LinearMap.trace_eq_matrix_trace ℝ ((Module.finBasis ℝ (dnWeights ι)).map ψ),
    LinearMap.trace_eq_matrix_trace ℝ (Module.finBasis ℝ (dnWeights ι))]
  congr 1
  ext a b
  rw [LinearMap.toMatrix_apply, LinearMap.toMatrix_apply, Module.Basis.map_apply, hkey, Module.Basis.map_repr,
    LinearEquiv.trans_apply, LinearEquiv.symm_apply_apply]

end HamiltonsCubic.B12Diag
