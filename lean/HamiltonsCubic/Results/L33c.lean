import HamiltonsCubic.Results.L30c
import HamiltonsCubic.Base.Spectrum

/-!
# L33, the exception clause is not vacuous

L33: a **one-dimensional** eigenspace on one side forces `W = 0`, *unless that
eigenvector is a multiple of a complex structure on a 4-plane*. The block adds
that the padded `Weyl₄` family is the only boundary case.

**The exception is realised at the competitor**, and every piece is already
here:

* its positive eigenspace is **one-dimensional**, [B7](../Base/Spectrum.lean)'s
  signature `(1,2)`;
* the eigenvector spanning it **is a complex structure**: `a² = -I`, which is
  [L30c](L30c.lean)'s `a aᵀ = I` with `a` skew;
* and `W ≠ 0`.

So the hypothesis the lemma carries is doing work: drop it and the lemma is
false at a point already on the record.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

/-- **The spanning eigenvector is a complex structure**: `a² = -I`. -/
theorem sdA_complex_structure : sdA * sdA = -(1 : Matrix (Fin 4) (Fin 4) ℚ) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [sdA, basis4, phi, Matrix.mul_apply, Fin.sum_univ_four, Matrix.single_apply,
      Matrix.sub_apply, Matrix.add_apply, Matrix.one_apply, Matrix.neg_apply,
      Fin.ext_iff, Fin.isValue]

/-- **And the competitor is nonzero**, so the exception is realised rather than
merely allowed for. -/
theorem WCP2_ne_zero : WCP2 ≠ 0 := by
  intro h
  have : WCP2 0 0 = (0 : Matrix (Fin 6) (Fin 6) ℚ) 0 0 := by rw [h]
  simp [WCP2] at this

/-- The positive eigenspace is one-dimensional, [B7](../Base/Spectrum.lean)'s
count, restated so the three clauses of the exception stand together. -/
theorem WCP2_one_positive :
    (Finset.univ.filter fun i => (0:ℚ) < (![2, -1, -1, 0, 0, 0] : Fin 6 → ℚ) i).card = 1 :=
  WCP2_signature.2

end HamiltonsCubic.Base
