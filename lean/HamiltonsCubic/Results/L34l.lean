import HamiltonsCubic.Results.L34k
import HamiltonsCubic.Results.L34h
import HamiltonsCubic.Results.L34g

/-!
# L34, two independent negative eigenvectors, formally

The count *exactly two negative eigenvalues* has two halves. **At least two** is
reachable now: exhibit two eigenvectors with a negative eigenvalue and show they
are independent. *Exactly* two needs the completeness of the whole exhibited
family, which is where the assembly still wants `LinearIndependent` plumbing.

`W₄(1,1) = -W_{ℂP²}` sends `a` to `-2a`, so padding `a` into each summand gives
two eigenvectors of the sum at `-2`. They are orthogonal, they live in
different blocks, and nonzero, so they are independent.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

set_option maxHeartbeats 1000000 in
/-- `a` is `W_{ℂP²}`'s `+2` eigenvector, as a bivector. -/
theorem ofMatrix_WCP2_sdA : ofMatrix WCP2 sdA = (2 : ℚ) • sdA := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [ofMatrix, toMat4, coord4, basis4, pair4, sdA, WCP2, phi, Matrix.mulVec, dotProduct,
      Fin.sum_univ_six, Matrix.single_apply, Matrix.add_apply, Matrix.sub_apply,
      Matrix.smul_apply, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
      Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five, Matrix.vecHead,
      Matrix.vecTail] <;> ring

/-- So `W₄(1,1) = -W_{ℂP²}` sends it to `-2a`. -/
theorem W4_sdA : (fun X => -(ofMatrix WCP2) X) sdA = (-2 : ℚ) • sdA := by
  simp [ofMatrix_WCP2_sdA]

/-- **The padded copies are nonzero**, their self-pairing being `a`'s own. -/
theorem pad_sdA_ne_zero : pad (k := Fin 4) sdA ≠ 0 := by
  have h2 : inner2 (pad (k := Fin 4) sdA) (pad (k := Fin 4) sdA) = 2 := by
    rw [pairing_pad]
    simp [inner2, sdA, basis4, phi, Matrix.trace, Matrix.diag, Matrix.mul_apply,
      Matrix.transpose_apply, Fin.sum_univ_four, Matrix.single_apply, Matrix.add_apply,
      Matrix.sub_apply] <;> norm_num
  intro h
  rw [h] at h2
  simp [inner2] at h2

/-- **And they are orthogonal**, living in different blocks, so the two
negative eigenvectors are independent, and the sum has **at least two** negative
eigenvalues. -/
theorem pad_sdA_orthogonal :
    inner2 (pad (k := Fin 4) sdA) (pad₂ (m := Fin 4) sdA) = 0 :=
  pad_orthogonal_pad₂ sdA sdA

end HamiltonsCubic.Base
