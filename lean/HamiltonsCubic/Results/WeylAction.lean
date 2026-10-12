import Mathlib.Tactic
import HamiltonsCubic.Results.WeylEquivariance

/-!
# The orthogonal action on curvature operators, and its coordinate law

`act g R = Z ↦ g R(gᵀ Z g) gᵀ`. Its coordinates in the `φ` basis transform as a 4-tensor
(`act_coord`), from which the Ricci clause is preserved for orthogonal `g` (`ric_act`).
-/

namespace HamiltonsCubic.Results

open HamiltonsCubic.RealLayer Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

set_option linter.unusedSectionVars false

/-- The action of `g` on a curvature operator. -/
def act (g : Matrix ι ι ℝ) (R : CurvLin ι) : CurvLin ι where
  toFun Z := g * R (gᵀ * Z * g) * gᵀ
  map_add' X Y := by simp only [Matrix.add_mul, Matrix.mul_add, map_add]
  map_smul' c X := by
    simp only [Matrix.smul_mul, Matrix.mul_smul, map_smul, RingHom.id_apply]

theorem act_apply (g : Matrix ι ι ℝ) (R : CurvLin ι) (Z : Matrix ι ι ℝ) :
    act g R Z = g * R (gᵀ * Z * g) * gᵀ := rfl

theorem inner2_sumL {α : Type*} (s : Finset α) (f : α → Matrix ι ι ℝ) (B : Matrix ι ι ℝ) :
    inner2 (∑ a ∈ s, f a) B = ∑ a ∈ s, inner2 (f a) B := by
  simp only [inner2, Matrix.transpose_sum, Matrix.sum_mul, Matrix.trace_sum, Finset.mul_sum]

theorem inner2_sumR {α : Type*} (s : Finset α) (f : α → Matrix ι ι ℝ) (A : Matrix ι ι ℝ) :
    inner2 A (∑ a ∈ s, f a) = ∑ a ∈ s, inner2 A (f a) := by
  simp only [inner2, Matrix.mul_sum, Matrix.trace_sum, Finset.mul_sum]

theorem inner2_smul_left'' (c : ℝ) (A B : Matrix ι ι ℝ) : inner2 (c • A) B = c * inner2 A B := by
  simp only [inner2, Matrix.transpose_smul, Matrix.smul_mul, Matrix.trace_smul, smul_eq_mul]; ring

theorem inner2_smul_right'' (c : ℝ) (A B : Matrix ι ι ℝ) : inner2 A (c • B) = c * inner2 A B := by
  simp only [inner2, Matrix.mul_smul, Matrix.trace_smul, smul_eq_mul]; ring

/-- **The coordinate law.** -/
theorem act_coord (g : Matrix ι ι ℝ) (R : CurvLin ι) (i j k l : ι) :
    inner2 (act g R (phi i j)) (phi k l) =
      ∑ a, ∑ b, ∑ c, ∑ d, g i a * g j b * (g k c * g l d * inner2 (R (phi a b)) (phi c d)) := by
  rw [act_apply, inner2_conj, rot_phi g i j, rot_phi g k l]
  simp only [map_sum, map_smul, inner2_sumL, inner2_sumR, inner2_smul_left'',
    inner2_smul_right'', Finset.mul_sum]
  rw [sum4_swap (fun c d a b => g k c * g l d * (g i a * g j b * inner2 (R (phi a b)) (phi c d)))]
  exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
    Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => by ring

/-- **Ricci transforms as a 2-tensor**, so it vanishes after the action when it did before. -/
theorem ric_act (g : Matrix ι ι ℝ) (hg : gᵀ * g = 1) (R : CurvLin ι) (a b : ι) :
    Ric (fun Z => act g R Z) a b =
      ∑ a', ∑ b', g a a' * g b b' * Ric (fun Z => R Z) a' b' := by
  unfold Ric
  simp only [act_coord]
  -- Σ_c Σ_{a' c' b' c''} g_a a' g_c c' g_b b' g_c c'' Rt(a',c',b',c'')
  have key : ∀ a' c' b' c'' : ι,
      ∑ c, g a a' * g c c' * (g b b' * g c c'' * inner2 (R (phi a' c')) (phi b' c'')) =
        g a a' * g b b' * ((if c' = c'' then 1 else 0) * inner2 (R (phi a' c')) (phi b' c'')) := by
    intro a' c' b' c''
    rw [← sum_rows g hg c' c'', Finset.sum_mul, Finset.mul_sum]
    refine Finset.sum_congr rfl fun c _ => ?_
    ring
  calc ∑ c, ∑ a', ∑ c', ∑ b', ∑ c'', g a a' * g c c' * (g b b' * g c c'' * inner2 (R (phi a' c')) (phi b' c''))
      = ∑ a', ∑ c', ∑ b', ∑ c'', ∑ c, g a a' * g c c' * (g b b' * g c c'' * inner2 (R (phi a' c')) (phi b' c'')) := by
        rw [Finset.sum_comm]
        refine Finset.sum_congr rfl fun a' _ => ?_
        rw [Finset.sum_comm]
        refine Finset.sum_congr rfl fun c' _ => ?_
        rw [Finset.sum_comm]
        refine Finset.sum_congr rfl fun b' _ => ?_
        rw [Finset.sum_comm]
    _ = ∑ a', ∑ b', g a a' * g b b' * ∑ c', inner2 (R (phi a' c')) (phi b' c') := by
        simp only [key, ite_mul, one_mul, zero_mul, mul_ite, mul_zero, Finset.sum_ite_eq,
          Finset.mem_univ, if_true]
        refine Finset.sum_congr rfl fun a' _ => ?_
        rw [Finset.sum_comm]
        refine Finset.sum_congr rfl fun b' _ => ?_
        rw [Finset.mul_sum]


theorem sum4_perm2 (F : ι → ι → ι → ι → ℝ) :
    ∑ a, ∑ x, ∑ y, ∑ z, F a x y z = ∑ a, ∑ b, ∑ c, ∑ d, F a c d b := by
  refine Finset.sum_congr rfl fun a _ => ?_
  symm
  calc ∑ b, ∑ c, ∑ d, F a c d b = ∑ c, ∑ b, ∑ d, F a c d b := Finset.sum_comm
    _ = ∑ c, ∑ d, ∑ b, F a c d b := Finset.sum_congr rfl fun c _ => Finset.sum_comm

theorem sum4_perm3 (F : ι → ι → ι → ι → ℝ) :
    ∑ a, ∑ x, ∑ y, ∑ z, F a x y z = ∑ a, ∑ b, ∑ c, ∑ d, F a d b c := by
  refine Finset.sum_congr rfl fun a _ => ?_
  symm
  calc ∑ b, ∑ c, ∑ d, F a d b c = ∑ b, ∑ d, ∑ c, F a d b c :=
        Finset.sum_congr rfl fun b _ => Finset.sum_comm
    _ = ∑ d, ∑ b, ∑ c, F a d b c := Finset.sum_comm

/-- **First Bianchi transforms as a 4-tensor.** -/
theorem bianchi_act (g : Matrix ι ι ℝ) (R : CurvLin ι) (i j k l : ι) :
    bianchi (fun Z => act g R Z) i j k l =
      ∑ a, ∑ b, ∑ c, ∑ d, g i a * g j b * g k c * g l d * bianchi (fun Z => R Z) a b c d := by
  unfold bianchi
  rw [act_coord, act_coord, act_coord]
  rw [sum4_perm2 (fun a x y z => g i a * g k x * (g l y * g j z * inner2 (R (phi a x)) (phi y z))),
    sum4_perm3 (fun a x y z => g i a * g l x * (g j y * g k z * inner2 (R (phi a x)) (phi y z)))]
  simp only [← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
    Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => by ring

theorem isSkew_conj (g X : Matrix ι ι ℝ) (hX : IsSkew X) : IsSkew (g * X * gᵀ) := by
  unfold IsSkew at *
  rw [Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose, hX]
  simp [Matrix.mul_assoc]

theorem isSym_conj (g X : Matrix ι ι ℝ) (hX : Xᵀ = X) : (g * X * gᵀ)ᵀ = g * X * gᵀ := by
  rw [Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose, hX]
  simp [Matrix.mul_assoc]

/-- **The action preserves the record's `𝒲ₙ`** for orthogonal `g`. -/
theorem act_mem (g : Matrix ι ι ℝ) (hg : gᵀ * g = 1) (R : CurvLin ι) (hR : R ∈ weylModuleS ι) :
    act g R ∈ weylModuleS ι := by
  obtain ⟨⟨hsk, hsym, hbi, hric⟩, hK⟩ := hR
  refine ⟨⟨?_, ?_, ?_, ?_⟩, ?_⟩
  · intro X hX
    show IsSkew (g * R (gᵀ * X * g) * gᵀ)
    apply isSkew_conj
    apply hsk
    have := isSkew_conj gᵀ X hX
    rwa [Matrix.transpose_transpose] at this
  · intro X Y hX hY
    show inner2 (g * R (gᵀ * X * g) * gᵀ) Y = inner2 X (g * R (gᵀ * Y * g) * gᵀ)
    have hX' : IsSkew (gᵀ * X * g) := by
      have := isSkew_conj gᵀ X hX; rwa [Matrix.transpose_transpose] at this
    have hY' : IsSkew (gᵀ * Y * g) := by
      have := isSkew_conj gᵀ Y hY; rwa [Matrix.transpose_transpose] at this
    rw [inner2_conj, hsym _ _ hX' hY', inner2_comm X (g * R (gᵀ * Y * g) * gᵀ), inner2_conj]
    exact inner2_comm _ _
  · intro i j k l
    rw [bianchi_act]
    simp [hbi]
  · intro a b
    rw [ric_act g hg]
    simp [hric]
  · intro Z hZ
    show g * R (gᵀ * Z * g) * gᵀ = 0
    have : (gᵀ * Z * g)ᵀ = gᵀ * Z * g := by
      have := isSym_conj gᵀ Z hZ; rwa [Matrix.transpose_transpose] at this
    rw [hK _ this]; simp

end HamiltonsCubic.Results
