import HamiltonsCubic.Base.Bridge
import HamiltonsCubic.Base.PhiPairing

/-!
# The coordinate round trip, and the symmetry transfer

The pair-basis coordinates represent a matrix faithfully exactly on the skew
ones. That is what `IsWeylOf`'s narrowed symmetry clause needs, and it is what
lets an operator's own symmetry be transferred to the `Λ²` reading.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

/-- A skew matrix has zero diagonal. -/
theorem IsSkew.diag_zero {X : Matrix (Fin 4) (Fin 4) ℚ} (hX : IsSkew X) (p : Fin 4) :
    X p p = 0 := by
  have h := congrFun (congrFun hX p) p
  simp only [Matrix.transpose_apply, Matrix.neg_apply] at h
  linarith

/-- Its entries anticommute. -/
theorem IsSkew.swap {X : Matrix (Fin 4) (Fin 4) ℚ} (hX : IsSkew X) (p q : Fin 4) :
    X q p = -X p q := by
  have h := congrFun (congrFun hX p) q
  simpa using h

/-- **The round trip.** On skew matrices the pair-basis coordinates lose
nothing, which is why the coordinates are the right representation of `Λ²` and
why the symmetry clause belongs over bivectors. -/
theorem toMat4_coord4 {X : Matrix (Fin 4) (Fin 4) ℚ} (hX : IsSkew X) :
    toMat4 (coord4 X) = X := by
  have hd := hX.diag_zero
  have hs := hX.swap
  ext p q
  fin_cases p <;> fin_cases q <;>
    simp [toMat4, coord4, basis4, pair4, phi, Fin.sum_univ_succ,
      Matrix.single_apply, Matrix.sub_apply, Matrix.smul_apply, Matrix.sum_apply,
      hd] <;>
    linarith [hs 0 1, hs 0 2, hs 0 3, hs 1 2, hs 1 3, hs 2 3,
      hs 1 0, hs 2 0, hs 3 0, hs 2 1, hs 3 1, hs 3 2]

/-- **The pair basis is orthonormal**, checked on all thirty-six pairs. This is
the `Λ²`-level statement of the `½` convention [B1](Bivectors.lean) pins. -/
theorem inner2_basis4 (a b : Fin 6) :
    inner2 (basis4 a) (basis4 b) = if a = b then 1 else 0 := by
  fin_cases a <;> fin_cases b <;>
    simp only [basis4, inner2_phi] <;> norm_num [Fin.ext_iff]

/-- Hence the coordinates carry the pairing: `⟪toMat4 v, toMat4 w⟫ = v ⬝ᵥ w`. -/
theorem inner2_toMat4 (v w : Fin 6 → ℚ) :
    inner2 (toMat4 v) (toMat4 w) = dotProduct v w := by
  simp [inner2, toMat4, dotProduct, Fin.sum_univ_succ, basis4, phi,
    Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply,
    Matrix.sub_apply, Matrix.smul_apply, Matrix.sum_apply, Matrix.single_apply]
  ring

/-! **`ofMatrix_symm` SITS HERE RATHER THAN WITH THE WITNESSES.** *Its proof needs only the round
trip and the coordinate pairing above*, and placing it beside `WCP2_isWeylOf` put it downstream of
[L34c.lean](../Results/L34c.lean), which is where it is actually consumed: the first-pair
antisymmetry of `bianchiOf` asks its operator for exactly this. -/

/-- **Symmetry transfers.** For skew inputs, `ofMatrix R` is self-adjoint for the
`Λ²` pairing exactly when `R` is a symmetric matrix. -/
theorem ofMatrix_symm {R : Matrix (Fin 6) (Fin 6) ℚ} (hR : R.IsSymm)
    {X Y : Matrix (Fin 4) (Fin 4) ℚ} (hX : IsSkew X) (hY : IsSkew Y) :
    inner2 (ofMatrix R X) Y = inner2 X (ofMatrix R Y) := by
  unfold ofMatrix
  rw [← toMat4_coord4 hY, inner2_toMat4, ← toMat4_coord4 hX, inner2_toMat4,
    toMat4_coord4 hX, toMat4_coord4 hY]
  rw [dotProduct_comm, dotProduct_mulVec, dotProduct_comm]
  congr 1
  rw [← Matrix.transpose_transpose R, ← Matrix.vecMul_transpose]
  simp [hR.eq]

end HamiltonsCubic.Base
