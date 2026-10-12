import Mathlib
import HamiltonsCubic.Results.L56MultiNorm

set_option linter.style.longLine false

/-!
# L56: the `Λ²` spectrum of a diagonal operator is its set of off-diagonal weights

[L56Norm.lean](L56Norm.lean) and [L56MultiNorm.lean](L56MultiNorm.lean) read each sphere-product gap
off the smallest modulus of the vertex ENTRIES; the record's gap is the smallest modulus of the `Λ²`
SPECTRUM ([r1711](../../../reviews/REVIEW_r1711.md) Q2). Families.lean's `diagOp_phi` gives one
direction, every entry is an eigenvalue. This file gives the other and closes the identification:

* `diagOp_eigen_entry`: a nonzero bivector eigenvector of `diagOp w` has its eigenvalue among the
  off-diagonal entries `w_ab`, `a ≠ b`;
* `diagOp_spec`: for symmetric `w`, the `Λ²` spectrum of `diagOp w` is exactly `{w_ab : a ≠ b}`;
* `vertex_attained_228`: the modulus `4/7` of `vertex_min_228` is attained, within the `S⁸`.
-/

namespace HamiltonsCubic.L56Spec

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L56Weyl
  HamiltonsCubic.L56Norm HamiltonsCubic.L56MultiNorm

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

omit [Fintype ι] [DecidableEq ι] in
/-- **Every eigenvalue on a nonzero bivector is an off-diagonal entry.** -/
theorem diagOp_eigen_entry (w : Matrix ι ι ℝ) (X : Matrix ι ι ℝ) (hX : IsSkew X) (hX0 : X ≠ 0)
    (lam : ℝ) (h : diagOp w X = lam • X) : ∃ a b, a ≠ b ∧ lam = w a b := by
  obtain ⟨a, b, hab⟩ : ∃ a b, X a b ≠ 0 := by
    by_contra hc
    push Not at hc
    exact hX0 (Matrix.ext fun a b => hc a b)
  have hne : a ≠ b := by
    rintro rfl
    have := congrFun (congrFun hX a) a
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    exact hab (by linarith)
  refine ⟨a, b, hne, ?_⟩
  have e := congrFun (congrFun h a) b
  simp only [diagOp, Matrix.of_apply, Matrix.smul_apply, smul_eq_mul] at e
  exact (mul_right_cancel₀ hab e).symm

/-- **The `Λ²` spectrum of a diagonal operator** is its set of off-diagonal weights. -/
theorem diagOp_spec (w : Matrix ι ι ℝ) (hw : ∀ a b, w a b = w b a) :
    {lam | ∃ X : Matrix ι ι ℝ, IsSkew X ∧ X ≠ 0 ∧ diagOp w X = lam • X} =
      {lam | ∃ a b, a ≠ b ∧ lam = w a b} := by
  ext lam
  simp only [Set.mem_ofPred_eq]
  constructor
  · rintro ⟨X, hX, hX0, h⟩
    exact diagOp_eigen_entry w X hX hX0 lam h
  · rintro ⟨a, b, hab, rfl⟩
    refine ⟨phi a b, phi_isSkew a b, fun h0 => ?_, diagOp_phi w hw a b⟩
    have := congrFun (congrFun h0 a) b
    simp [phi, Matrix.sub_apply, hab, Ne.symm hab] at this

/-- **`4/7` is attained** at `(2,2,8)`, between two coordinates of the `S⁸`. -/
theorem vertex_attained_228 : |vW beta228 4 5| = 4 / 7 := by
  have e : vW beta228 4 5 = -((Fintype.card (Fin 12) : ℝ) - 1) * weylE beta228 4 5 := rfl
  have hβ : beta228 4 = beta228 5 := by decide
  rw [e, vertex_entries beta228 bs228_ge (by simp) 4 5 (by decide), bs228 4, if_pos hβ]
  simp only [Fintype.card_fin]
  norm_num

end HamiltonsCubic.L56Spec
