import HamiltonsCubic.Results.KyFanPrinciple
import HamiltonsCubic.Results.RootSlots
import HamiltonsCubic.Results.L209FoxClosure

/-!
# Packaging the Weyl layer for `kyFan_eigen`

`inner2` as a `LinearMap.BilinForm` (`inner2Form`), symmetric and positive on all matrices, and
`-ad_X²` as a linear map (`negAdSq`), with the identity L237 applies:
`⟨Y, -ad_X² Y⟩ = ‖[X, Y]‖²` for skew `X` (`inner2_negAdSq`).
-/

open HamiltonsCubic.RealLayer HamiltonsCubic.Results Matrix

namespace HamiltonsCubic.KyFanPackaging

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

set_option linter.unusedSectionVars false

/-- `inner2` as a bilinear form. -/
noncomputable def inner2Form : LinearMap.BilinForm ℝ (Matrix ι ι ℝ) :=
  LinearMap.mk₂ ℝ inner2
    (fun A A' B => by simp only [inner2, Matrix.transpose_add, Matrix.add_mul, Matrix.trace_add]; ring)
    (fun c A B => by
      simp only [inner2, Matrix.transpose_smul, Matrix.smul_mul, Matrix.trace_smul, smul_eq_mul]; ring)
    (fun A B B' => by simp only [inner2, Matrix.mul_add, Matrix.trace_add]; ring)
    (fun c A B => by simp only [inner2, Matrix.mul_smul, Matrix.trace_smul, smul_eq_mul]; ring)

theorem inner2Form_apply (A B : Matrix ι ι ℝ) : inner2Form A B = inner2 A B := rfl

theorem inner2Form_symm (A B : Matrix ι ι ℝ) : inner2Form A B = inner2Form B A := by
  simp only [inner2Form_apply]; exact inner2_comm A B

theorem inner2Form_pos (A : Matrix ι ι ℝ) : 0 ≤ inner2Form A A := inner2_self_nonneg A

/-- `-ad_X²` as a linear map. -/
def negAdSq (X : Matrix ι ι ℝ) : Matrix ι ι ℝ →ₗ[ℝ] Matrix ι ι ℝ where
  toFun Y := -br X (br X Y)
  map_add' Y Y' := by simp only [br]; noncomm_ring
  map_smul' c Y := by
    simp only [br, Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_sub, Matrix.sub_mul, RingHom.id_apply]
    rw [← smul_sub, ← smul_sub, ← smul_sub, smul_neg]

/-- **`⟨Y, -ad_X² Y⟩ = ‖[X, Y]‖²`** for skew `X`. -/
theorem inner2_negAdSq (X Y : Matrix ι ι ℝ) (hX : IsSkew X) :
    inner2Form Y (negAdSq X Y) = inner2 (br X Y) (br X Y) := by
  show inner2 Y (-br X (br X Y)) = _
  have h := inner2_br_skew X Y (br X Y) hX
  have hneg : inner2 Y (-br X (br X Y)) = -inner2 Y (br X (br X Y)) := by
    simp only [inner2, Matrix.mul_neg, Matrix.trace_neg]; ring
  rw [hneg, ← h]

end HamiltonsCubic.KyFanPackaging
