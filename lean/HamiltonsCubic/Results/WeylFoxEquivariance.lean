import Mathlib.Tactic
import HamiltonsCubic.Results.WeylAction

/-!
# The Fox product is equivariant under orthogonal conjugation

`sharpQF (act g R) (g η gᵀ) = sharpQF R η` (`sharpQF_act`), by `sum_rot_bilin` on the bilinear
form `(x, y) ↦ ⟨[η, R[η, R x]], y⟩`; then `sharpOp`, `Qop` and the Fox product all commute with the
action (`foxProd_act`).
-/

namespace HamiltonsCubic.Results

open HamiltonsCubic.RealLayer Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

set_option linter.unusedSectionVars false

theorem conj_cancel (g X : Matrix ι ι ℝ) (hg : gᵀ * g = 1) : gᵀ * (g * X * gᵀ) * g = X := by
  calc gᵀ * (g * X * gᵀ) * g = (gᵀ * g) * X * (gᵀ * g) := by simp only [Matrix.mul_assoc]
    _ = X := by rw [hg, Matrix.one_mul, Matrix.mul_one]

theorem conj_uncancel (g X : Matrix ι ι ℝ) (hg : g * gᵀ = 1) : g * (gᵀ * X * g) * gᵀ = X := by
  calc g * (gᵀ * X * g) * gᵀ = (g * gᵀ) * X * (g * gᵀ) := by simp only [Matrix.mul_assoc]
    _ = X := by rw [hg, Matrix.one_mul, Matrix.mul_one]

theorem brR_add (A X Y : Matrix ι ι ℝ) : br A (X + Y) = br A X + br A Y := by
  simp only [br, Matrix.mul_add, Matrix.add_mul]; abel

theorem brR_smul (A X : Matrix ι ι ℝ) (c : ℝ) : br A (c • X) = c • br A X := by
  simp only [br, Matrix.mul_smul, Matrix.smul_mul, smul_sub]

theorem sum4_swapM {M : Type*} [AddCommMonoid M] (F : ι → ι → ι → ι → M) :
    ∑ i, ∑ j, ∑ a, ∑ b, F i j a b = ∑ a, ∑ b, ∑ i, ∑ j, F i j a b := by
  calc ∑ i, ∑ j, ∑ a, ∑ b, F i j a b = ∑ i, ∑ a, ∑ j, ∑ b, F i j a b :=
        Finset.sum_congr rfl fun i _ => Finset.sum_comm
    _ = ∑ a, ∑ i, ∑ j, ∑ b, F i j a b := Finset.sum_comm
    _ = ∑ a, ∑ i, ∑ b, ∑ j, F i j a b :=
        Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun i _ => Finset.sum_comm
    _ = ∑ a, ∑ b, ∑ i, ∑ j, F i j a b := Finset.sum_congr rfl fun a _ => Finset.sum_comm

/-- The bilinear form whose `φ`-diagonal sum is `sharpQF`. -/
noncomputable def sharpForm (R : CurvLin ι) (η : Matrix ι ι ℝ) :
    Matrix ι ι ℝ →ₗ[ℝ] Matrix ι ι ℝ →ₗ[ℝ] ℝ :=
  LinearMap.mk₂ ℝ (fun x y => inner2 (br η (R (br η (R x)))) y)
    (fun x x' y => by simp only [map_add, brR_add, inner2_add_left''])
    (fun c x y => by simp only [map_smul, brR_smul, inner2_smul_left'', smul_eq_mul])
    (fun x y y' => by simp only [inner2_sumR, inner2, Matrix.mul_add, Matrix.trace_add]; ring)
    (fun c x y => by simp only [inner2_smul_right'', smul_eq_mul])

/-- **`sharpQF` is equivariant.** -/
theorem sharpQF_act (g : Matrix ι ι ℝ) (hg : gᵀ * g = 1) (R : CurvLin ι) (η : Matrix ι ι ℝ) :
    sharpQF (fun Z => act g R Z) (g * η * gᵀ) = sharpQF (fun Z => R Z) η := by
  unfold sharpQF
  congr 1
  have key : ∀ i j, inner2 (br (g * η * gᵀ) (act g R (br (g * η * gᵀ) (act g R (phi i j)))))
      (phi i j) = sharpForm R η (gᵀ * phi i j * g) (gᵀ * phi i j * g) := by
    intro i j
    rw [act_apply g R (phi i j), br_conj g _ _ hg, act_apply, conj_cancel g _ hg,
      br_conj g _ _ hg, inner2_conj]
    rfl
  simp only [key]
  rw [sum_rot_bilin g hg (sharpForm R η)]
  rfl

/-- The same, read at an arbitrary argument. -/
theorem sharpQF_act' (g : Matrix ι ι ℝ) (hg : gᵀ * g = 1) (hg' : g * gᵀ = 1) (R : CurvLin ι)
    (W : Matrix ι ι ℝ) :
    sharpQF (fun Z => act g R Z) W = sharpQF (fun Z => R Z) (gᵀ * W * g) := by
  conv_lhs => rw [← conj_uncancel g W hg']
  exact sharpQF_act g hg R _

theorem sharpBil_act (g : Matrix ι ι ℝ) (hg : gᵀ * g = 1) (hg' : g * gᵀ = 1) (R : CurvLin ι)
    (X Y : Matrix ι ι ℝ) :
    sharpBil (fun Z => act g R Z) X Y = sharpBil (fun Z => R Z) (gᵀ * X * g) (gᵀ * Y * g) := by
  unfold sharpBil
  rw [sharpQF_act' g hg hg', sharpQF_act' g hg hg', sharpQF_act' g hg hg', Matrix.mul_add,
    Matrix.add_mul]

theorem isLinOp_of_curvLin (R : CurvLin ι) : IsLinOp (fun Z => R Z) :=
  ⟨fun X Y => R.map_add X Y, fun c X => R.map_smul c X⟩

/-- **`sharpOp` is equivariant.** -/
theorem sharpOp_act (g : Matrix ι ι ℝ) (hg : gᵀ * g = 1) (hg' : g * gᵀ = 1) (R : CurvLin ι)
    (Z : Matrix ι ι ℝ) :
    sharpOp (fun Z => act g R Z) Z = g * sharpOp (fun Z => R Z) (gᵀ * Z * g) * gᵀ := by
  have hR := isLinOp_of_curvLin R
  unfold sharpOp
  simp only [sharpBil_act g hg hg', rot_phi g,
    sharpBil_sum_right (fun Z => R Z) hR, sharpBil_smul_right (fun Z => R Z) hR]
  rw [Matrix.mul_smul, Matrix.smul_mul]
  congr 1
  simp only [Matrix.mul_sum, Matrix.sum_mul, Matrix.mul_smul, Matrix.smul_mul, conj_phi,
    Finset.smul_sum, smul_smul, Finset.sum_smul]
  rw [sum4_swapM (fun i j a b =>
    (g i a * g j b * sharpBil (fun Z => R Z) (gᵀ * Z * g) (phi a b)) • phi i j)]
  exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
    Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by congr 1; ring

/-- **`Q` is equivariant.** -/
theorem Qop_act (g : Matrix ι ι ℝ) (hg : gᵀ * g = 1) (hg' : g * gᵀ = 1) (R : CurvLin ι)
    (Z : Matrix ι ι ℝ) :
    Qop (fun Z => act g R Z) Z = g * Qop (fun Z => R Z) (gᵀ * Z * g) * gᵀ := by
  unfold Qop compOp
  beta_reduce
  rw [sharpOp_act g hg hg', act_apply g R (act g R Z), act_apply g R Z, conj_cancel g _ hg,
    Matrix.mul_add, Matrix.add_mul]

theorem act_add (g : Matrix ι ι ℝ) (X Y : CurvLin ι) : act g (X + Y) = act g X + act g Y := by
  apply LinearMap.ext; intro Z
  simp only [act_apply, LinearMap.add_apply, Matrix.mul_add, Matrix.add_mul]

/-- **The Fox product is equivariant.** -/
theorem foxProd_act (g : Matrix ι ι ℝ) (hg : gᵀ * g = 1) (hg' : g * gᵀ = 1) (X Y : CurvLin ι)
    (Z : Matrix ι ι ℝ) :
    foxProd (fun A => act g X A) (fun A => act g Y A) Z =
      g * foxProd (fun A => X A) (fun A => Y A) (gᵀ * Z * g) * gᵀ := by
  unfold foxProd
  have hs : ((fun A => act g X A) + fun A => act g Y A) = fun A => act g (X + Y) A := by
    funext A; simp [act_add]
  have hs' : ((fun A => X A) + fun A => Y A) = fun A => (X + Y) A := by
    funext A; simp
  rw [hs, hs', Qop_act g hg hg', Qop_act g hg hg', Qop_act g hg hg']
  simp only [Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_sub, Matrix.sub_mul]

end HamiltonsCubic.Results
