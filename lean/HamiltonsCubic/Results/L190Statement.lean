import HamiltonsCubic.Results.L187Statement
import HamiltonsCubic.Base.SelfDual

/-!
# L190, the surviving rank-three case is inhabited, and by a family

**What this file types is the claim Gate 2 confirmed and STRENGTHENED.** *The block cited padded
`W_ℂP²` as a point; both reviewers found the case is a five-parameter family, because every form of
`Λ⁺ℝ⁴` satisfies `ω² = -½‖ω‖²Id`, so ANY orthonormal basis of `Λ⁺ℝ⁴` carrying ANY nonzero traceless
weight vector is a rank-three Weyl tensor with all three image forms non-decomposable.*

**`sdCombo` is a general member of `Λ⁺ℝ⁴`** rather than one of `SelfDual.lean`'s three, which is
what makes the family visible: `sdCombo_sq` is the record's `ω² = -½‖ω‖²Id` at every coefficient
triple, and `sdCombo_nondecomposable` reads it as invertibility.

**AND THE WITNESS SATURATES THE INEQUALITY THAT REPLACES [L189](../../../findings/diagonal-half.md)'S
STRICT STEP.** *With `N` the majority form rescaled and `M₂, M₃` the other two, Ricci-flatness reads
`NNᵀ = M₂M₂ᵀ + M₃M₃ᵀ`, and here all three are multiples of the identity:* `ricci_at_witness` gives
`Id = ½Id + ½Id`, whose determinants are `1 = 1/16 + 1/16`, **and `1^{1/4} = (1/16)^{1/4} +
(1/16)^{1/4}`, which is Minkowski's determinant inequality holding with EQUALITY.** *So the
determinant route that closed L189 is dead at `dim V = 4` for a reason carrying no wedge at all.*

*The `Λ⁸V` scoping of L189's cross term is a statement about a space this layer does not build, and
is recorded in the block rather than typed here.*
-/

set_option linter.style.longLine false
set_option maxHeartbeats 1000000

namespace HamiltonsCubic.L190Statement

open Matrix HamiltonsCubic.RealLayer HamiltonsCubic.SelfDualLayer

/-- **A general member of `Λ⁺ℝ⁴`**, in the standard frame's basis. -/
def sdCombo (x y z : ℝ) : Matrix (Fin 4) (Fin 4) ℝ :=
  x • sdForm 0 + y • sdForm 1 + z • sdForm 2

/-- **`ω² = -‖(x,y,z)‖² Id₄` on every member of `Λ⁺ℝ⁴`.** *The three basis forms anticommute, so
the cross terms cancel and only the squares survive.* -/
theorem sdCombo_sq (x y z : ℝ) :
    sdCombo x y z * sdCombo x y z = (-(x ^ 2 + y ^ 2 + z ^ 2)) • (1 : Matrix (Fin 4) (Fin 4) ℝ) := by
  ext a b
  fin_cases a <;> fin_cases b <;>
    simp [sdCombo, sdForm, Matrix.mul_apply, Fin.sum_univ_four, phi, Matrix.single_apply,
      Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply, Matrix.one_apply] <;> ring

/-- **`‖ω‖² = 2(x²+y²+z²)`**, the `sdForm` basis being orthogonal with norm squared `2`. -/
theorem inner2_sdCombo (x y z : ℝ) :
    inner2 (sdCombo x y z) (sdCombo x y z) = 2 * (x ^ 2 + y ^ 2 + z ^ 2) := by
  simp [sdCombo, sdForm, inner2_eq_sum, Fin.sum_univ_four, phi, Matrix.single_apply,
    Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply]
  ring

/-- **THE RECORD'S IDENTITY, at every member of `Λ⁺ℝ⁴`**: `ω² = -½‖ω‖² Id₄`. -/
theorem sdCombo_sq_eq_half_norm (x y z : ℝ) :
    sdCombo x y z * sdCombo x y z
      = (-(1 / 2) * inner2 (sdCombo x y z) (sdCombo x y z)) • (1 : Matrix (Fin 4) (Fin 4) ℝ) := by
  rw [inner2_sdCombo, sdCombo_sq]; ring_nf

/-- **Every nonzero member of `Λ⁺ℝ⁴` is invertible, hence of rank four, hence non-decomposable.** -/
theorem sdCombo_nondecomposable (x y z : ℝ) (h : x ^ 2 + y ^ 2 + z ^ 2 ≠ 0) :
    ∃ ν, sdCombo x y z * ν = 1 :=
  HamiltonsCubic.L187Statement.nondecomposable_of_sq_eq_neg_smul h
    (by rw [sdCombo_sq, neg_smul])

/-! ## The witness saturates the inequality that replaces L189's strict step -/

theorem unitSD_isSkew (k : Fin 3) : IsSkew (unitSD k) := by
  have h : Matrix.transpose (sdForm k) = -sdForm k := sdForm_isSkew k
  show Matrix.transpose (unitSD k) = -unitSD k
  rw [unitSD, Matrix.transpose_smul, h, smul_neg]

/-- **`ωωᵀ = ½Id₄` at every unit self-dual form**, which is the Gram matrix Ricci-flatness sums. -/
theorem unitSD_gram (k : Fin 3) :
    unitSD k * Matrix.transpose (unitSD k) = (1 / 2 : ℝ) • (1 : Matrix (Fin 4) (Fin 4) ℝ) := by
  rw [unitSD_isSkew k, Matrix.mul_neg, unitSD_sq]
  module

/-- **Ricci-flatness at the witness, in [L189](../../../findings/diagonal-half.md)'s rescaled shape**
`NNᵀ = M₂M₂ᵀ + M₃M₃ᵀ`, *and here every term is a multiple of the identity, which is what leaves the
determinant comparison with no slack.* -/
theorem ricci_at_witness :
    (2 : ℝ) • (unitSD 0 * Matrix.transpose (unitSD 0))
      = unitSD 1 * Matrix.transpose (unitSD 1) + unitSD 2 * Matrix.transpose (unitSD 2) := by
  rw [unitSD_gram, unitSD_gram, unitSD_gram]
  module

theorem quarter_root_sixteenth : ((1 : ℝ) / 16) ^ ((1 : ℝ) / 4) = 1 / 2 := by
  have h : (1 : ℝ) / 16 = ((1 : ℝ) / 2) ^ (4 : ℕ) := by norm_num
  rw [h, ← Real.rpow_natCast ((1 : ℝ) / 2) 4, ← Real.rpow_mul (by norm_num)]
  norm_num

/-- **MINKOWSKI'S DETERMINANT INEQUALITY HOLDS WITH EQUALITY AT THE WITNESS.** *`det(A+B)^{1/m} ≥
det(A)^{1/m} + det(B)^{1/m}` on positive semidefinite `A, B` is what replaces
[L189](../../../findings/diagonal-half.md)'s strict monotonicity once the right side of Ricci carries
two terms; at `NNᵀ = Id₄` against `MᵢMᵢᵀ = ½Id₄` the two sides agree, so the determinant route is
dead at `dim V = 4` and no cross term is involved.* -/
theorem minkowski_saturated_at_witness :
    (Matrix.det ((2 : ℝ) • (unitSD 0 * Matrix.transpose (unitSD 0)))) ^ ((1 : ℝ) / 4)
      = (Matrix.det (unitSD 1 * Matrix.transpose (unitSD 1))) ^ ((1 : ℝ) / 4)
        + (Matrix.det (unitSD 2 * Matrix.transpose (unitSD 2))) ^ ((1 : ℝ) / 4) := by
  have h2 : ((2 : ℝ) • (unitSD 0 * Matrix.transpose (unitSD 0)))
      = (1 : Matrix (Fin 4) (Fin 4) ℝ) := by rw [unitSD_gram]; module
  rw [h2, unitSD_gram, unitSD_gram, Matrix.det_one, Matrix.det_smul, Matrix.det_one]
  have hc : ((1 : ℝ) / 2) ^ Fintype.card (Fin 4) * 1 = 1 / 16 := by
    simp [Fintype.card_fin]; norm_num
  rw [hc, quarter_root_sixteenth, Real.one_rpow]
  norm_num

end HamiltonsCubic.L190Statement
