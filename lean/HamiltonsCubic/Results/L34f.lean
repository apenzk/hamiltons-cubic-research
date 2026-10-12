import HamiltonsCubic.Base.Spectrum

/-!
# L34's eigenvalue count, the per-summand half, and what the union needs

The count *exactly two negative eigenvalues* at `m = 8` comes from two facts:

* **each summand contributes one**, `W₄(1,1) = -W_{ℂP²}` has signature `(2,1)`,
  which is [B7](../Base/Spectrum.lean)'s complete spectrum negated. Proved here.
* **the spectra add**, the padded sum is block diagonal, acting as each copy on
  its own `Λ²` and as `0` on the mixed part, so its spectrum is the union.
  [L34d](L34d.lean) proves the blockwise action; the step from there to the
  spectrum is **owed**.

**Why the union is not just a bigger computation.** The obvious route is an
explicit `28 × 28` eigenbasis and a determinant. Mathlib defines `Matrix.det` as
a sum over permutations, so a `28 × 28` determinant is `28!` terms, out of
reach for `native_decide` and for anything else. The union has to come from the
block structure as a theorem, not from evaluating a determinant, and that is a
piece the layer does not have.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

/-- `W₄(1,1) = -W_{ℂP²}` has spectrum `(-2,1,1,0,0,0)`.

**THIS IS A COROLLARY OF [B7](../Base/Spectrum.lean)'s EIGENBASIS, NOT A SECOND COMPUTATION.**
*Negating an operator negates its eigenvalues and keeps its eigenvectors*, so the same `VCP2` works
and the invertibility is literally the same fact. -/
theorem W4_spectrum :
    IsEigenbasis (-WCP2) VCP2 ![-2, 1, 1, 0, 0, 0] := by
  obtain ⟨hmul, hdet⟩ := WCP2_isEigenbasis
  refine ⟨?_, hdet⟩
  have hd : (Matrix.diagonal ![(-2 : ℚ), 1, 1, 0, 0, 0])
      = -Matrix.diagonal ![(2 : ℚ), -1, -1, 0, 0, 0] := by
    ext a b
    fin_cases a <;> fin_cases b <;>
      simp [Matrix.diagonal_apply, Matrix.neg_apply, Matrix.cons_val_zero, Matrix.cons_val_one,
        Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
        Matrix.vecHead, Matrix.vecTail] <;> norm_num
  rw [Matrix.neg_mul, hmul, hd, Matrix.mul_neg]

/-- **So each summand carries exactly one negative eigenvalue**, signature
`(2,1)`, which is what L34 asks of `W₄(q,r)`. -/
theorem W4_signature :
    (Finset.univ.filter fun i => (![-2, 1, 1, 0, 0, 0] : Fin 6 → ℚ) i < 0).card = 1 ∧
    (Finset.univ.filter fun i => (0:ℚ) < (![-2, 1, 1, 0, 0, 0] : Fin 6 → ℚ) i).card = 2 := by
  constructor <;>
    simp [Finset.filter, Fin.sum_univ_six, Matrix.cons_val_zero, Matrix.cons_val_one,
      Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
      Matrix.vecHead, Matrix.vecTail] <;>
    decide

end HamiltonsCubic.Base
