import HamiltonsCubic.Base.FoxProduct
import HamiltonsCubic.Base.SharpDiag

/-!
# The Fox product is linear in its second slot, at linear arguments, on every matrix

`sharpQF` is quadratic in the operator: `sharpQF_add_op` expands `sharpQF (A + B)` through the mixed
form `mixQF`, screened to `1e-13` before typing. Polarising gives `foxProd_eq`,
`e ∘ Y = ½(e(Y·) + Y(e·) + mixOp e Y)`, and with it `foxProd_add_right` and `foxProd_smul_right`.
These are what [WeylTraceStatement.lean](WeylTraceStatement.lean)'s `leftMul_exists` needs.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.RealLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The mixed quadratic form of `#`**, `B(A,B)(η) = −¼ Σ ⟨[η, A[η, B φ]], φ⟩`. -/
noncomputable def mixQF (A B : Matrix ι ι ℝ → Matrix ι ι ℝ) (η : Matrix ι ι ℝ) : ℝ :=
  -(1/4) * ∑ i : ι, ∑ j : ι, inner2 (br η (A (br η (B (phi i j))))) (phi i j)

theorem sharpQF_eq_mixQF (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (η : Matrix ι ι ℝ) :
    sharpQF R η = mixQF R R η := rfl

theorem mixQF_add_left (A A' B : Matrix ι ι ℝ → Matrix ι ι ℝ) (η : Matrix ι ι ℝ) :
    mixQF (fun X => A X + A' X) B η = mixQF A B η + mixQF A' B η := by
  unfold mixQF
  simp only [br_add_right, inner2_add_left, Finset.sum_add_distrib]
  ring

theorem mixQF_add_right (A B B' : Matrix ι ι ℝ → Matrix ι ι ℝ) (hA : IsLinOp A) (η : Matrix ι ι ℝ) :
    mixQF A (fun X => B X + B' X) η = mixQF A B η + mixQF A B' η := by
  unfold mixQF
  simp only [br_add_right, hA.1, br_add_right, inner2_add_left, Finset.sum_add_distrib]
  ring

theorem mixQF_smul_left (c : ℝ) (A B : Matrix ι ι ℝ → Matrix ι ι ℝ) (η : Matrix ι ι ℝ) :
    mixQF (fun X => c • A X) B η = c * mixQF A B η := by
  unfold mixQF
  simp only [br_smul_right, inner2_smul_left, ← Finset.mul_sum]
  ring

theorem mixQF_smul_right (c : ℝ) (A B : Matrix ι ι ℝ → Matrix ι ι ℝ) (hA : IsLinOp A)
    (η : Matrix ι ι ℝ) : mixQF A (fun X => c • B X) η = c * mixQF A B η := by
  unfold mixQF
  simp only [br_smul_right, hA.2, inner2_smul_left, ← Finset.mul_sum]
  ring

theorem sharpQF_add_op (A B : Matrix ι ι ℝ → Matrix ι ι ℝ) (hA : IsLinOp A) (hB : IsLinOp B)
    (η : Matrix ι ι ℝ) :
    sharpQF (fun X => A X + B X) η
      = sharpQF A η + sharpQF B η + (mixQF A B η + mixQF B A η) := by
  have hAB : IsLinOp (fun X => A X + B X) :=
    ⟨fun X Y => by simp only [hA.1, hB.1]; abel, fun c X => by simp only [hA.2, hB.2, smul_add]⟩
  rw [sharpQF_eq_mixQF, mixQF_add_left, mixQF_add_right _ _ _ hA, mixQF_add_right _ _ _ hB,
    sharpQF_eq_mixQF, sharpQF_eq_mixQF]
  ring

/-- The symmetrised mixed form. -/
noncomputable def mixSym (A B : Matrix ι ι ℝ → Matrix ι ι ℝ) (η : Matrix ι ι ℝ) : ℝ :=
  mixQF A B η + mixQF B A η

/-- **The mixed part of `#` as an operator.** -/
noncomputable def mixOp (A B : Matrix ι ι ℝ → Matrix ι ι ℝ) : Matrix ι ι ℝ → Matrix ι ι ℝ :=
  fun X => (1/2 : ℝ) • ∑ i : ι, ∑ j : ι,
    ((1/2) * (mixSym A B (X + phi i j) - mixSym A B X - mixSym A B (phi i j))) • phi i j

theorem sharpBil_add_op (A B : Matrix ι ι ℝ → Matrix ι ι ℝ) (hA : IsLinOp A) (hB : IsLinOp B)
    (X Z : Matrix ι ι ℝ) :
    sharpBil (fun W => A W + B W) X Z = sharpBil A X Z + sharpBil B X Z
      + (1/2) * (mixSym A B (X + Z) - mixSym A B X - mixSym A B Z) := by
  unfold sharpBil mixSym
  rw [sharpQF_add_op A B hA hB, sharpQF_add_op A B hA hB, sharpQF_add_op A B hA hB]
  ring

theorem sharpOp_add_op (A B : Matrix ι ι ℝ → Matrix ι ι ℝ) (hA : IsLinOp A) (hB : IsLinOp B)
    (X : Matrix ι ι ℝ) :
    sharpOp (fun W => A W + B W) X = sharpOp A X + sharpOp B X + mixOp A B X := by
  unfold sharpOp mixOp
  simp only [sharpBil_add_op A B hA hB, add_smul, Finset.sum_add_distrib, smul_add]

/-- **`e ∘ Y = ½(e(Y·) + Y(e·) + mixOp e Y)`** at linear `e`, `Y`. -/
theorem foxProd_eq (e Y : Matrix ι ι ℝ → Matrix ι ι ℝ) (he : IsLinOp e) (hY : IsLinOp Y)
    (Z : Matrix ι ι ℝ) :
    foxProd e Y Z = (1/2 : ℝ) • (e (Y Z) + Y (e Z) + mixOp e Y Z) := by
  have hsum : (e + Y) = fun W => e W + Y W := rfl
  unfold foxProd Qop compOp
  rw [hsum, sharpOp_add_op e Y he hY]
  simp only [he.1, hY.1]
  module

theorem mixSym_add_right (e B B' : Matrix ι ι ℝ → Matrix ι ι ℝ) (he : IsLinOp e) (η : Matrix ι ι ℝ) :
    mixSym e (fun W => B W + B' W) η = mixSym e B η + mixSym e B' η := by
  unfold mixSym
  rw [mixQF_add_right _ _ _ he, mixQF_add_left]; ring

theorem mixSym_smul_right (c : ℝ) (e B : Matrix ι ι ℝ → Matrix ι ι ℝ) (he : IsLinOp e)
    (η : Matrix ι ι ℝ) : mixSym e (fun W => c • B W) η = c * mixSym e B η := by
  unfold mixSym
  rw [mixQF_smul_right _ _ _ he, mixQF_smul_left]; ring

theorem mixOp_add_right (e B B' : Matrix ι ι ℝ → Matrix ι ι ℝ) (he : IsLinOp e) (X : Matrix ι ι ℝ) :
    mixOp e (fun W => B W + B' W) X = mixOp e B X + mixOp e B' X := by
  unfold mixOp
  simp only [mixSym_add_right _ _ _ he]
  rw [← smul_add, ← Finset.sum_add_distrib]
  congr 1
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [← add_smul]; congr 1; ring

theorem mixOp_smul_right (c : ℝ) (e B : Matrix ι ι ℝ → Matrix ι ι ℝ) (he : IsLinOp e)
    (X : Matrix ι ι ℝ) : mixOp e (fun W => c • B W) X = c • mixOp e B X := by
  unfold mixOp
  simp only [mixSym_smul_right _ _ _ he, Finset.smul_sum, smul_smul]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  congr 1; ring

/-- **`∘` IS ADDITIVE IN ITS SECOND SLOT** at linear arguments, on every matrix. -/
theorem foxProd_add_right (e Y Y' : Matrix ι ι ℝ → Matrix ι ι ℝ) (he : IsLinOp e)
    (hY : IsLinOp Y) (hY' : IsLinOp Y') (Z : Matrix ι ι ℝ) :
    foxProd e (fun W => Y W + Y' W) Z = foxProd e Y Z + foxProd e Y' Z := by
  have hYY : IsLinOp (fun W => Y W + Y' W) :=
    ⟨fun X W => by simp only [hY.1, hY'.1]; abel, fun c X => by simp only [hY.2, hY'.2, smul_add]⟩
  rw [foxProd_eq e _ he hYY, foxProd_eq e Y he hY, foxProd_eq e Y' he hY', mixOp_add_right _ _ _ he,
    he.1]
  module

/-- **And homogeneous in it.** -/
theorem foxProd_smul_right (c : ℝ) (e Y : Matrix ι ι ℝ → Matrix ι ι ℝ) (he : IsLinOp e)
    (hY : IsLinOp Y) (Z : Matrix ι ι ℝ) :
    foxProd e (fun W => c • Y W) Z = c • foxProd e Y Z := by
  have hcY : IsLinOp (fun W => c • Y W) :=
    ⟨fun X W => by simp only [hY.1, smul_add], fun d X => by simp only [hY.2, smul_comm c d]⟩
  rw [foxProd_eq e _ he hcY, foxProd_eq e Y he hY, mixOp_smul_right _ _ _ he, he.2]
  module

end HamiltonsCubic.RealLayer
