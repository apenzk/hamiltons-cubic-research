import HamiltonsCubic.Results.L24Eigen
import HamiltonsCubic.Results.FoxBridge
import HamiltonsCubic.Results.L209WeylClosure
import HamiltonsCubic.Results.RecordNormed

set_option linter.style.longLine false

/-!
# L24 on the restricted operator: `L_e` preserves `W^⊥`, and every eigenvalue there is at most `½`

[findings/second-order.md](../../../findings/second-order.md), Lemma L24:
`λ_max(L_e|_{W^⊥}) ≤ ½`, where the record argues that **`W^⊥` is `L_e`-invariant, so the
restriction is a genuine operator rather than a compression**.

[L24Eigen.lean](L24Eigen.lean) bounds each eigenvalue carried by a Weyl eigenvector orthogonal to
`a`. **This file builds the restricted operator and bounds its spectrum**:

- `isWeyl2_foxProd2`: **`X, Y ∈ 𝒲ₙ ⇒ X ∘ Y ∈ 𝒲ₙ` on `CurvOp2`**, L209's polarised closure
  (`foxProd_isWeylOp`, on bare operators) carried across `extend` by `foxProd_extend`;
- `weylPerp a`: the Weyl operators orthogonal to `a`, a submodule;
- `LeLin a`: `L_e = e ∘ (·)` with `e = a/P(a)`, a linear map, by `foxProd2`'s bilinearity;
- `LeLin_mapsTo`: `L_e` maps `weylPerp a` into itself, by Weyl closure and, for orthogonality,
  `⟪a, L_e v⟫ = ⟪L_e a, v⟫ = ⟪a, v⟫` through the symmetry of `T` and `L_e a = a`;
- `LeRestr`: the restricted operator, an endomorphism of `weylPerpR a`, the same submodule read on
  the synonym `RecCurv ι` of [RecordNormed.lean](RecordNormed.lean), where a submodule finds its
  additive group (on `CurvOp2` itself the `ContinuousLinearMap` instances do not reach it);
- `L24_restrict`: **every eigenvalue of `L_e|_{W^⊥}`, in Mathlib's `Module.End.HasEigenvalue`, is at
  most `½`.**
- `LeRestr_isSymmetric` and `L24_lambda_max`: **`L_e|_{W^⊥}` is symmetric, and its largest
  Rayleigh quotient, which the spectral theorem makes its top eigenvalue, is at most `½`.**

**The Riemannian Hessian along great circles** is [L24Hess.lean](L24Hess.lean)'s `L24_hessian`, and **the
sharpness of `½` along the orbit** is [L24Sharp.lean](L24Sharp.lean)'s `L24_sharp` and `L24_lambda_max_eq`. *A maximiser meeting every hypothesis exists at every `n ≥ 4`:
[WeylMaximiser.lean](WeylMaximiser.lean)'s `L24_nonvacuous`.*
-/

namespace HamiltonsCubic.RealLayer

open HamiltonsCubic.TensorBridge

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The extension of a `CurvOp2` operator is linear**, the projection and `R` both being. -/
theorem isLinOp_extend (R : CurvOp2 ι) : IsLinOp (extend R) := by
  constructor
  · intro X Y
    unfold extend
    have e : (⟨skewProj (X + Y), skewProj_mem (X + Y)⟩ : skewSub ι)
        = ⟨skewProj X, skewProj_mem X⟩ + ⟨skewProj Y, skewProj_mem Y⟩ := by
      refine Subtype.ext ?_
      show skewProj (X + Y) = skewProj X + skewProj Y
      unfold skewProj; rw [Matrix.transpose_add]; module
    rw [e, map_add]; rfl
  · intro c X
    unfold extend
    have e : (⟨skewProj (c • X), skewProj_mem (c • X)⟩ : skewSub ι)
        = c • (⟨skewProj X, skewProj_mem X⟩ : skewSub ι) := by
      refine Subtype.ext ?_
      show skewProj (c • X) = c • skewProj X
      unfold skewProj; rw [Matrix.transpose_smul]; module
    rw [e, map_smul]; rfl

/-- **`X, Y ∈ 𝒲ₙ ⇒ X ∘ Y ∈ 𝒲ₙ` ON `CurvOp2`**, L209's polarised closure carried across `extend`. -/
theorem isWeyl2_foxProd2 {A B : CurvOp2 ι} (hA : IsWeyl2 A) (hB : IsWeyl2 B) :
    IsWeyl2 (foxProd2 A B) := by
  have hW := (HamiltonsCubic.Results.foxProd_isWeylOp (extend A) (extend B)
    ⟨isLinOp_extend A, isWeyl_extend hA⟩ ⟨isLinOp_extend B, isWeyl_extend hB⟩).2
  have hphi : ∀ i j : ι, applyPhi (foxProd2 A B) i j
      = HamiltonsCubic.RealLayer.foxProd (extend A) (extend B) (phi i j) := fun i j =>
    (foxProd_extend A B ⟨phi i j, phi_mem_skewSub i j⟩).symm
  refine ⟨fun X Y => ?_, fun i j k l => ?_, fun a b => ?_⟩
  · rw [← foxProd_extend A B X, ← foxProd_extend A B Y]
    exact hW.2.1 _ _ X.2 Y.2
  · simp only [hphi]; exact hW.2.2.1 i j k l
  · simp only [hphi]; exact hW.2.2.2 a b

/-- **The Weyl operators orthogonal to `a`.** -/
def weylPerp (a : CurvOp2 ι) : Submodule ℝ (CurvOp2 ι) where
  carrier := {v | IsWeyl2 v ∧ innerOp2 a v = 0}
  add_mem' := fun {v w} hv hw => ⟨isWeyl2_add hv.1 hw.1, by rw [innerOp2_add_right, hv.2, hw.2, add_zero]⟩
  zero_mem' := ⟨isWeyl2_zero, by
    have h := innerOp2_smul_right 0 a a
    rwa [zero_mul, show (0 : ℝ) • a = 0 from ContinuousLinearMap.ext fun X => by simp] at h⟩
  smul_mem' := fun c v hv => ⟨isWeyl2_smul c hv.1, by rw [innerOp2_smul_right, hv.2, mul_zero]⟩

/-- **`L_e = e ∘ (·)`**, `e = a/P(a)`, as a linear map. -/
noncomputable def LeLin (a : CurvOp2 ι) : CurvOp2 ι →ₗ[ℝ] CurvOp2 ι where
  toFun v := foxProd2 ((Pcubic2 a)⁻¹ • a) v
  map_add' := foxProd2_add_right _
  map_smul' c v := foxProd2_smul_right c _ v

/-- **`L_e` preserves `W^⊥`** at a unit critical Weyl `a` with `P(a) ≠ 0`. -/
theorem LeLin_mapsTo {a : CurvOp2 ι} {lam : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hcrit : Qop2 a = lam • a) (hθ : Pcubic2 a ≠ 0) :
    ∀ v ∈ weylPerp a, LeLin a v ∈ weylPerp a := by
  rintro v ⟨hWv, hv⟩
  refine ⟨isWeyl2_foxProd2 (isWeyl2_smul _ hWa) hWv, ?_⟩
  show innerOp2 a (foxProd2 ((Pcubic2 a)⁻¹ • a) v) = 0
  rw [innerOp2_comm]
  change foxTri2 ((Pcubic2 a)⁻¹ • a) v a = 0
  rw [foxTri2_symm_right _ v a hWv.isSelfAdjoint2 hWa.isSelfAdjoint2]
  show innerOp2 (foxProd2 ((Pcubic2 a)⁻¹ • a) a) v = 0
  rw [Le_self ha hcrit hθ, hv]

/-- **`W^⊥` on the synonym `RecCurv ι`**, where submodules carry their additive group; the
elements are those of `weylPerp a`. -/
def weylPerpR (a : CurvOp2 ι) : Submodule ℝ (RecCurv ι) where
  carrier := {v | v ∈ weylPerp a}
  add_mem' := fun hv hw => (weylPerp a).add_mem hv hw
  zero_mem' := (weylPerp a).zero_mem
  smul_mem' := fun c _ hv => (weylPerp a).smul_mem c hv

/-- **`L_e|_{W^⊥}`**, the restricted operator, as an endomorphism of `weylPerpR a`. -/
noncomputable def LeRestr {a : CurvOp2 ι} {lam : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hcrit : Qop2 a = lam • a) (hθ : Pcubic2 a ≠ 0) : Module.End ℝ (weylPerpR a) :=
  (show RecCurv ι →ₗ[ℝ] RecCurv ι from LeLin a).restrict
    (fun v hv => LeLin_mapsTo ha hWa hcrit hθ v hv)

/-- **L24 FOR THE RESTRICTED OPERATOR**: at a unit critical Weyl `a` locally maximising `P` on the
Weyl sphere with `P(a) > 0`, every eigenvalue of `L_e|_{W^⊥}` is at most `½`. -/
theorem L24_restrict {a : CurvOp2 ι} {lam μ : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hcrit : Qop2 a = lam • a)
    (hmax : IsLocalMaxOn Pcubic2 {R : CurvOp2 ι | normSq2 R = 1 ∧ IsWeyl2 R} a)
    (hθ : 0 < Pcubic2 a)
    (hμ : Module.End.HasEigenvalue (LeRestr ha hWa hcrit hθ.ne') μ) :
    μ ≤ 1 / 2 := by
  obtain ⟨v, hv⟩ := hμ.exists_hasEigenvector
  have hmem : ((v : RecCurv ι) : CurvOp2 ι) ∈ weylPerp a := v.2
  have hne : ((v : RecCurv ι) : CurvOp2 ι) ≠ 0 := fun h => hv.2 (Subtype.ext h)
  have heig : foxProd2 ((Pcubic2 a)⁻¹ • a) ((v : RecCurv ι) : CurvOp2 ι)
      = μ • ((v : RecCurv ι) : CurvOp2 ι) :=
    congrArg Subtype.val hv.apply_eq_smul
  exact L24_eigen ha hWa hcrit hmax hθ hmem.1 hmem.2 hne heig

/-- **`L_e|_{W^⊥}` is symmetric** under `RecCurv`'s inner product, which is `innerOp2`: the
full symmetry of `T` at Weyl arguments. -/
theorem LeRestr_isSymmetric {a : CurvOp2 ι} {lam : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hcrit : Qop2 a = lam • a) (hθ : Pcubic2 a ≠ 0) :
    (LeRestr ha hWa hcrit hθ).IsSymmetric := by
  intro x y
  have hx : IsWeyl2 (show CurvOp2 ι from (x : RecCurv ι)) := x.2.1
  have hy : IsWeyl2 (show CurvOp2 ι from (y : RecCurv ι)) := y.2.1
  show innerOp2 (foxProd2 ((Pcubic2 a)⁻¹ • a) (show CurvOp2 ι from (x : RecCurv ι)))
      (show CurvOp2 ι from (y : RecCurv ι))
    = innerOp2 (show CurvOp2 ι from (x : RecCurv ι))
      (foxProd2 ((Pcubic2 a)⁻¹ • a) (show CurvOp2 ι from (y : RecCurv ι)))
  rw [innerOp2_comm (show CurvOp2 ι from (x : RecCurv ι))]
  exact foxTri2_symm_right _ _ _ hx.isSelfAdjoint2 hy.isSelfAdjoint2

/-- **`λ_max(L_e|_{W^⊥}) ≤ ½`, AS THE RECORD STATES IT.** The largest Rayleigh quotient of the
symmetric operator `L_e|_{W^⊥}` is an eigenvalue by the spectral theorem
(`LinearMap.IsSymmetric.hasEigenvalue_iSup_of_finiteDimensional`), and `L24_restrict` bounds every
eigenvalue. `W^⊥` nontrivial is the case the record means. -/
theorem L24_lambda_max {a : CurvOp2 ι} {lam : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hcrit : Qop2 a = lam • a)
    (hmax : IsLocalMaxOn Pcubic2 {R : CurvOp2 ι | normSq2 R = 1 ∧ IsWeyl2 R} a)
    (hθ : 0 < Pcubic2 a) [Nontrivial (weylPerpR a)] :
    (⨆ x : {x : weylPerpR a // x ≠ 0},
      RCLike.re (inner ℝ (LeRestr ha hWa hcrit hθ.ne' x) (x : weylPerpR a))
        / ‖(x : weylPerpR a)‖ ^ 2) ≤ 1 / 2 :=
  L24_restrict ha hWa hcrit hmax hθ
    ((LeRestr_isSymmetric ha hWa hcrit hθ.ne').hasEigenvalue_iSup_of_finiteDimensional)
end HamiltonsCubic.RealLayer
