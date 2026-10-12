import HamiltonsCubic.Results.WeylTraceZero

/-!
# The trace form `B(e,f) = tr (L e ∘ L f)` on the record's `𝒲ₙ`

Stage 1 of the approved `trace_leftMulS_comp` build. **`Bform` is symmetric and invariant under the
orthogonal action** (`Bform_symm`, `Bform_act`): `L (g·e)` is `L e` conjugated by the action
(`leftMulS_act`), and the trace of a conjugate is the trace. *What remains is Schur: an invariant
symmetric form on the irreducible `𝒲ₙ` is a multiple of `⟨·,·⟩`.*
-/

namespace HamiltonsCubic.Results

open HamiltonsCubic.RealLayer Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- `L e`, chosen. -/
noncomputable def Lop (e : weylModuleS ι) : weylModuleS ι →ₗ[ℝ] weylModuleS ι :=
  Classical.choose (leftMulS_exists (e : CurvLin ι) e.2)

theorem Lop_spec (e : weylModuleS ι) : ∀ Y : weylModuleS ι, ∀ Z : Matrix ι ι ℝ,
    (Lop e Y : CurvLin ι) Z = foxProd (fun A => (e : CurvLin ι) A) (fun A => (Y : CurvLin ι) A) Z :=
  Classical.choose_spec (leftMulS_exists (e : CurvLin ι) e.2)

/-- **The trace form** `B(e,f) = tr (L e ∘ L f)`. -/
noncomputable def Bform (e f : weylModuleS ι) : ℝ := LinearMap.trace ℝ (weylModuleS ι) (Lop e ∘ₗ Lop f)

theorem Bform_symm (e f : weylModuleS ι) : Bform e f = Bform f e := by
  unfold Bform; exact LinearMap.trace_mul_comm ℝ (Lop e) (Lop f)

/-- **`B` is invariant under the orthogonal action.** -/
theorem Bform_act (g : Matrix ι ι ℝ) (hg : gᵀ * g = 1) (e f : weylModuleS ι) :
    Bform (actS g hg e) (actS g hg f) = Bform e f := by
  have hg' := orth_comm hg
  have he : Lop (actS g hg e) = (actE g hg hg').conj (Lop e) :=
    leftMulS_unique _ _ _ (Lop_spec _) (leftMulS_act g hg hg' _ (Lop e) (Lop_spec e))
  have hf : Lop (actS g hg f) = (actE g hg hg').conj (Lop f) :=
    leftMulS_unique _ _ _ (Lop_spec _) (leftMulS_act g hg hg' _ (Lop f) (Lop_spec f))
  unfold Bform
  rw [he, hf, ← LinearEquiv.conj_comp]
  exact LinearMap.trace_conj' (R := ℝ) (M := weylModuleS ι) (N := weylModuleS ι) (Lop e ∘ₗ Lop f) (actE g hg hg')

end HamiltonsCubic.Results
