import HamiltonsCubic.Results.WeylTraceSchur
import HamiltonsCubic.Results.L120Decomp

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# B12, step 1: `tr(L_e²)` on `𝒲ₙ` splits over the sign-group sectors

[lean/INDEX.md](../../../lean/INDEX.md)'s B12, the full spectrum of `L_e` at a unit sphere product, funded for
[L161](../../../findings/curvature-invariants.md)'s value of `κ`. [WeylTraceSchur.lean](WeylTraceSchur.lean)'s
`trace_leftMulS_comp` gives `tr(L_e ∘ L_f) = κ⟨e, f⟩` with one `κ`, so the trace at one Weyl `e` settles `κ`. This file
cuts that trace along [L120Decomp.lean](L120Decomp.lean)'s isotypic projectors `proj t`, on the record's own `𝒲ₙ`, so
each sector can be computed on its own.

* **`projS t`**: `proj t` as an endomorphism of `weylModuleS`, `2^{-n} ∑_u χ_t(u) g_u ·`;
* **`sum_projS`**: the projectors sum to the identity;
* **`Lop_actS`**: at an `e` fixed by every sign flip, `L_e` commutes with the action of each `g_u`, since
  `L_{g·e} = g L_e g⁻¹` (`leftMulS_act`) and `L_e` is unique (`leftMulS_unique`);
* **`Lop_projS`**: so `L_e` commutes with every `projS t`;
* **`trace_sectors`**: `tr(f) = ∑_t tr(f ∘ projS t)` for every endomorphism `f`, and at `f = L_e ∘ L_e` this is the sector
  split of `tr(L_e²)`.
-/

namespace HamiltonsCubic.B12Sectors

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.Results HamiltonsCubic.L120Decomp HamiltonsCubic.L120HessPair

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem diagSet_transpose (u : Finset ι) : (diagSet u)ᵀ = diagSet u := by
  unfold diagSet; rw [diagonal_transpose]

theorem diagSet_orth' (u : Finset ι) : diagSet u * (diagSet u)ᵀ = 1 := by
  have h := diagSet_orth u
  rw [diagSet_transpose] at h ⊢; exact h

/-- **The isotypic projector on `𝒲ₙ`.** -/
noncomputable def projS (t : Finset ι) : weylModuleS ι →ₗ[ℝ] weylModuleS ι :=
  ((2 : ℝ) ^ Fintype.card ι)⁻¹ • ∑ u : Finset ι, chi t u • actS (diagSet u) (diagSet_orth u)

theorem projS_coe (t : Finset ι) (Y : weylModuleS ι) : (projS t Y : CurvLin ι) = proj t Y := by
  unfold projS proj
  simp only [LinearMap.smul_apply, LinearMap.sum_apply, Submodule.coe_smul, Submodule.coe_sum]
  rfl

/-- **The projectors sum to the identity on `𝒲ₙ`.** -/
theorem sum_projS : ∑ t : Finset ι, projS t = (LinearMap.id : weylModuleS ι →ₗ[ℝ] weylModuleS ι) := by
  apply LinearMap.ext; intro Y; apply Subtype.ext
  rw [LinearMap.sum_apply, Submodule.coe_sum, LinearMap.id_apply]
  simp only [projS_coe]
  exact sum_proj (Y : CurvLin ι)

/-- **`L_e` commutes with a sign flip fixing `e`.** -/
theorem Lop_actS (e : weylModuleS ι) (u : Finset ι) (he : act (diagSet u) (e : CurvLin ι) = e) :
    Lop e ∘ₗ actS (diagSet u) (diagSet_orth u) = actS (diagSet u) (diagSet_orth u) ∘ₗ Lop e := by
  set g := diagSet u
  have hg := diagSet_orth u
  have hg' := diagSet_orth' u
  have hspec := leftMulS_act g hg hg' (e : CurvLin ι) (Lop e) (Lop_spec e)
  rw [he] at hspec
  have hconj : (actE g hg hg').conj (Lop e) = Lop e :=
    leftMulS_unique (e : CurvLin ι) _ _ hspec (Lop_spec e)
  apply LinearMap.ext; intro Y
  have h := congrArg (fun L => L (actE g hg hg' Y)) hconj
  simp only [LinearEquiv.conj_apply_apply, LinearEquiv.symm_apply_apply] at h
  exact h.symm

/-- **`L_e` commutes with every isotypic projector** at an `e` fixed by every sign flip. -/
theorem Lop_projS (e : weylModuleS ι) (he : ∀ u : Finset ι, act (diagSet u) (e : CurvLin ι) = e) (t : Finset ι) :
    Lop e ∘ₗ projS t = projS t ∘ₗ Lop e := by
  apply LinearMap.ext; intro Y
  have hc : ∀ u : Finset ι, Lop e (actS (diagSet u) (diagSet_orth u) Y) = actS (diagSet u) (diagSet_orth u) (Lop e Y) :=
    fun u => congrArg (fun L => L Y) (Lop_actS e u (he u))
  simp only [LinearMap.comp_apply, projS, LinearMap.smul_apply, LinearMap.sum_apply, map_smul, map_sum, hc]

/-- **The trace splits over the sectors**, for every endomorphism of `𝒲ₙ`. -/
theorem trace_sectors (f : weylModuleS ι →ₗ[ℝ] weylModuleS ι) :
    LinearMap.trace ℝ (weylModuleS ι) f = ∑ t : Finset ι, LinearMap.trace ℝ (weylModuleS ι) (f ∘ₗ projS t) := by
  have h : ∑ t : Finset ι, f ∘ₗ projS t = f ∘ₗ ∑ t : Finset ι, projS t := by
    apply LinearMap.ext; intro Y
    simp only [LinearMap.sum_apply, LinearMap.comp_apply, map_sum]
  rw [← map_sum, h, sum_projS, LinearMap.comp_id]

/-- **`tr(L_e²)` as a sum of sector traces**, each sector's operator `L_e² ∘ projS t` being `projS t ∘ L_e² ∘ projS t`
at a sign-fixed `e`. -/
theorem trace_sq_sectors (e : weylModuleS ι) (he : ∀ u : Finset ι, act (diagSet u) (e : CurvLin ι) = e) :
    LinearMap.trace ℝ (weylModuleS ι) (Lop e ∘ₗ Lop e)
      = ∑ t : Finset ι, LinearMap.trace ℝ (weylModuleS ι) (Lop e ∘ₗ Lop e ∘ₗ projS t) ∧
    ∀ t, Lop e ∘ₗ Lop e ∘ₗ projS t = projS t ∘ₗ Lop e ∘ₗ Lop e := by
  refine ⟨by rw [trace_sectors]; rfl, fun t => ?_⟩
  rw [Lop_projS e he t, ← LinearMap.comp_assoc, Lop_projS e he t, LinearMap.comp_assoc]

end HamiltonsCubic.B12Sectors
