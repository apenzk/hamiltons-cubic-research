import Mathlib.Tactic
import HamiltonsCubic.Results.WeylTraceStrict

/-!
# Orthogonal equivariance of the curvature layer, the first half of `tr (L e) = 0`

For orthogonal `g` the conjugation `R ↦ g R(gᵀ · g) gᵀ` moves every coordinate bivector by
`gᵀ φ_ij g = Σ_{a,b} g_ia g_jb φ_ab`. Every clause of `IsWeyl` and every piece of the Fox product
is a sum over the `φ` basis of something multilinear in the `φ`'s, so that one expansion carries
all of them. This file proves the expansion and its first consequences.
-/

namespace HamiltonsCubic.Results

open HamiltonsCubic.RealLayer Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

set_option linter.unusedSectionVars false

/-- **The expansion**: `gᵀ φ_ij g = Σ_{a,b} g_ia g_jb φ_ab`, for any matrix `g`. -/
theorem rot_phi (g : Matrix ι ι ℝ) (i j : ι) :
    gᵀ * phi i j * g = ∑ a, ∑ b, (g i a * g j b) • phi a b := by
  ext p q
  simp [phi, Matrix.mul_apply, Matrix.single_apply, Matrix.sum_apply, Finset.sum_mul,
    ite_mul, mul_ite, Matrix.sub_apply, sub_mul, mul_sub, Finset.sum_sub_distrib]
  simp only [ite_and, Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  rw [Finset.sum_eq_single p (fun b _ hb => by simp [hb]) (by simp)]
  simp only [if_true, Finset.sum_ite_eq', Finset.mem_univ]
  ring

/-- **The reverse expansion**: `g φ_ab gᵀ = Σ_{i,j} g_ia g_jb φ_ij`. -/
theorem conj_phi (g : Matrix ι ι ℝ) (a b : ι) :
    g * phi a b * gᵀ = ∑ i, ∑ j, (g i a * g j b) • phi i j := by
  have := rot_phi gᵀ a b
  simp only [Matrix.transpose_transpose, Matrix.transpose_apply] at this
  rw [this]

/-- `inner2` is invariant under orthogonal conjugation, moved to the other side. -/
theorem inner2_conj (g A B : Matrix ι ι ℝ) :
    inner2 (g * A * gᵀ) B = inner2 A (gᵀ * B * g) := by
  simp only [inner2, Matrix.transpose_mul, Matrix.transpose_transpose]
  congr 1
  calc trace (g * (Aᵀ * gᵀ) * B) = trace ((Aᵀ * gᵀ) * B * g) := by
        rw [Matrix.mul_assoc, Matrix.trace_mul_comm, Matrix.mul_assoc]
    _ = trace (Aᵀ * (gᵀ * B * g)) := by simp only [Matrix.mul_assoc]

/-- The bracket is equivariant under orthogonal conjugation. -/
theorem br_conj (g A B : Matrix ι ι ℝ) (hg : gᵀ * g = 1) :
    br (g * A * gᵀ) (g * B * gᵀ) = g * br A B * gᵀ := by
  simp only [br]
  have e : ∀ X Y : Matrix ι ι ℝ, g * X * gᵀ * (g * Y * gᵀ) = g * (X * Y) * gᵀ := by
    intro X Y
    calc g * X * gᵀ * (g * Y * gᵀ) = g * X * (gᵀ * g) * Y * gᵀ := by simp only [Matrix.mul_assoc]
      _ = g * (X * Y) * gᵀ := by rw [hg]; simp only [Matrix.mul_one, Matrix.mul_assoc]
  rw [e, e, ← Matrix.sub_mul, ← Matrix.mul_sub]

/-- **Orthonormality of the rows**, in the form the sums use. -/
theorem sum_rows (g : Matrix ι ι ℝ) (hg : gᵀ * g = 1) (a a' : ι) :
    ∑ i, g i a * g i a' = if a = a' then 1 else 0 := by
  have := congrFun (congrFun hg a) a'
  simp only [Matrix.mul_apply, Matrix.transpose_apply, Matrix.one_apply] at this
  exact this

theorem sum4_swap (F : ι → ι → ι → ι → ℝ) :
    ∑ i, ∑ j, ∑ a, ∑ b, F i j a b = ∑ a, ∑ b, ∑ i, ∑ j, F i j a b := by
  calc ∑ i, ∑ j, ∑ a, ∑ b, F i j a b = ∑ i, ∑ a, ∑ j, ∑ b, F i j a b :=
        Finset.sum_congr rfl fun i _ => Finset.sum_comm
    _ = ∑ a, ∑ i, ∑ j, ∑ b, F i j a b := Finset.sum_comm
    _ = ∑ a, ∑ i, ∑ b, ∑ j, F i j a b :=
        Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun i _ => Finset.sum_comm
    _ = ∑ a, ∑ b, ∑ i, ∑ j, F i j a b := Finset.sum_congr rfl fun a _ => Finset.sum_comm

/-- **A bilinear sum over the `φ` basis is invariant under orthogonal rotation of the basis.** -/
theorem sum_rot_bilin (g : Matrix ι ι ℝ) (hg : gᵀ * g = 1)
    (B : Matrix ι ι ℝ →ₗ[ℝ] Matrix ι ι ℝ →ₗ[ℝ] ℝ) :
    ∑ i, ∑ j, B (gᵀ * phi i j * g) (gᵀ * phi i j * g) = ∑ a, ∑ b, B (phi a b) (phi a b) := by
  have h0 : ∀ i j (Y : Matrix ι ι ℝ), B (gᵀ * phi i j * g) Y =
      ∑ a, ∑ b, (g i a * g j b) * B (phi a b) Y := by
    intro i j Y
    rw [rot_phi g i j]
    simp only [map_sum, map_smul, LinearMap.sum_apply, LinearMap.smul_apply, smul_eq_mul]
  have h2 : ∀ a b, ∑ i, ∑ j, (g i a * g j b) • (gᵀ * phi i j * g) = phi a b := by
    intro a b
    have : ∑ i, ∑ j, (g i a * g j b) • (gᵀ * phi i j * g) =
        gᵀ * (∑ i, ∑ j, (g i a * g j b) • phi i j) * g := by
      simp only [Matrix.mul_sum, Matrix.sum_mul, Matrix.mul_smul, Matrix.smul_mul]
    rw [this, ← conj_phi, ← Matrix.mul_assoc, ← Matrix.mul_assoc, hg, Matrix.one_mul,
      Matrix.mul_assoc, hg, Matrix.mul_one]
  simp_rw [h0]
  rw [sum4_swap (fun i j a b => g i a * g j b * B (phi a b) (gᵀ * phi i j * g))]
  refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
  have := congrArg (B (phi a b)) (h2 a b)
  simp only [map_sum, map_smul, smul_eq_mul] at this
  exact this

end HamiltonsCubic.Results
