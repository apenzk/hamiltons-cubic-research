import Mathlib.Tactic
import HamiltonsCubic.Results.WeylFoxEquivariance

/-!
# The trace of `L e` is invariant under the orthogonal action

The action is a linear automorphism of the record's `𝒲ₙ` (`actE`), `L e` is unique
(`leftMulS_unique`), and `L (g·e)` is `L e` conjugated by the action (`leftMulS_act`), so
`tr L (g·e) = tr L e` (`trace_leftMulS_act`).
-/

namespace HamiltonsCubic.Results

open HamiltonsCubic.RealLayer Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

set_option linter.unusedSectionVars false

theorem act_smul (g : Matrix ι ι ℝ) (c : ℝ) (R : CurvLin ι) : act g (c • R) = c • act g R := by
  apply LinearMap.ext; intro Z
  simp only [act_apply, LinearMap.smul_apply, Matrix.mul_smul, Matrix.smul_mul]

theorem act_act_inv (g : Matrix ι ι ℝ) (hg : gᵀ * g = 1) (R : CurvLin ι) : act gᵀ (act g R) = R := by
  apply LinearMap.ext; intro Z
  rw [act_apply, Matrix.transpose_transpose, act_apply, conj_cancel g Z hg]
  calc gᵀ * (g * R Z * gᵀ) * g = (gᵀ * g) * R Z * (gᵀ * g) := by simp only [Matrix.mul_assoc]
    _ = R Z := by rw [hg, Matrix.one_mul, Matrix.mul_one]

/-- The action on the record's `𝒲ₙ`, as a linear map. -/
def actS (g : Matrix ι ι ℝ) (hg : gᵀ * g = 1) : weylModuleS ι →ₗ[ℝ] weylModuleS ι where
  toFun Y := ⟨act g Y, act_mem g hg Y Y.2⟩
  map_add' Y1 Y2 := Subtype.ext (by simp [act_add])
  map_smul' c Y := Subtype.ext (by simp [act_smul])

/-- **The action is a linear automorphism** for orthogonal `g`. -/
def actE (g : Matrix ι ι ℝ) (hg : gᵀ * g = 1) (hg' : g * gᵀ = 1) :
    weylModuleS ι ≃ₗ[ℝ] weylModuleS ι :=
  LinearEquiv.ofLinear (actS g hg) (actS gᵀ (by rw [Matrix.transpose_transpose]; exact hg'))
    (by
      apply LinearMap.ext; intro Y; apply Subtype.ext
      show act g (act gᵀ Y) = Y
      have := act_act_inv gᵀ (by rw [Matrix.transpose_transpose]; exact hg') (Y : CurvLin ι)
      rwa [Matrix.transpose_transpose] at this)
    (by
      apply LinearMap.ext; intro Y; apply Subtype.ext
      show act gᵀ (act g Y) = Y
      exact act_act_inv g hg Y)

/-- **`L e` is unique.** -/
theorem leftMulS_unique (e : CurvLin ι) (L L' : weylModuleS ι →ₗ[ℝ] weylModuleS ι)
    (hL : ∀ Y : weylModuleS ι, ∀ Z : Matrix ι ι ℝ,
      (L Y : CurvLin ι) Z = foxProd (fun A => e A) (fun A => (Y : CurvLin ι) A) Z)
    (hL' : ∀ Y : weylModuleS ι, ∀ Z : Matrix ι ι ℝ,
      (L' Y : CurvLin ι) Z = foxProd (fun A => e A) (fun A => (Y : CurvLin ι) A) Z) :
    L = L' := by
  apply LinearMap.ext; intro Y; apply Subtype.ext; apply LinearMap.ext; intro Z
  rw [hL, hL']

/-- **`L (g·e)` is `L e` conjugated by the action.** -/
theorem leftMulS_act (g : Matrix ι ι ℝ) (hg : gᵀ * g = 1) (hg' : g * gᵀ = 1) (e : CurvLin ι)
    (L : weylModuleS ι →ₗ[ℝ] weylModuleS ι)
    (hL : ∀ Y : weylModuleS ι, ∀ Z : Matrix ι ι ℝ,
      (L Y : CurvLin ι) Z = foxProd (fun A => e A) (fun A => (Y : CurvLin ι) A) Z) :
    ∀ Y : weylModuleS ι, ∀ Z : Matrix ι ι ℝ,
      ((actE g hg hg').conj L Y : CurvLin ι) Z =
        foxProd (fun A => act g e A) (fun A => (Y : CurvLin ι) A) Z := by
  intro Y Z
  rw [LinearEquiv.conj_apply_apply]
  show act g (L ((actE g hg hg').symm Y)) Z = _
  rw [act_apply, hL]
  have hY : (Y : CurvLin ι) = act g (((actE g hg hg').symm Y : weylModuleS ι) : CurvLin ι) := by
    show (Y : CurvLin ι) = act g (act gᵀ Y)
    have := act_act_inv gᵀ (by rw [Matrix.transpose_transpose]; exact hg') (Y : CurvLin ι)
    rw [Matrix.transpose_transpose] at this
    exact this.symm
  conv_rhs => rw [hY]
  rw [foxProd_act g hg hg']

/-- **The trace of `L e` is invariant under the orthogonal action.** -/
theorem trace_leftMulS_act (g : Matrix ι ι ℝ) (hg : gᵀ * g = 1) (hg' : g * gᵀ = 1) (e : CurvLin ι)
    (L Lg : weylModuleS ι →ₗ[ℝ] weylModuleS ι)
    (hL : ∀ Y : weylModuleS ι, ∀ Z : Matrix ι ι ℝ,
      (L Y : CurvLin ι) Z = foxProd (fun A => e A) (fun A => (Y : CurvLin ι) A) Z)
    (hLg : ∀ Y : weylModuleS ι, ∀ Z : Matrix ι ι ℝ,
      (Lg Y : CurvLin ι) Z = foxProd (fun A => act g e A) (fun A => (Y : CurvLin ι) A) Z) :
    LinearMap.trace ℝ (weylModuleS ι) Lg = LinearMap.trace ℝ (weylModuleS ι) L := by
  rw [leftMulS_unique (act g e) Lg ((actE g hg hg').conj L) hLg (leftMulS_act g hg hg' e L hL)]
  exact LinearMap.trace_conj' (R := ℝ) (M := weylModuleS ι) (N := weylModuleS ι) L (actE g hg hg')

end HamiltonsCubic.Results
