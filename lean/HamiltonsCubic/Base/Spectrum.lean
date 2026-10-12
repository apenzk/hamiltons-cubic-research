import HamiltonsCubic.Base.CP2

/-!
# B7, spectra, bounded to what the rows need

Three rows want eigenvalues: L30's descent (the span of the negative
eigenvectors), L33's lemma (a one-dimensional eigenspace), and L34's witnesses
(the eigenvalue count). Over `ℚ` there is no spectral theorem to reach for, a
rational symmetric matrix has real algebraic eigenvalues, not rational ones.

**So the bound is exhibited eigenbases rather than a spectral theorem.** An
eigenbasis is a matrix `V` with `M * V = V * diagonal d`; when `det V ≠ 0` the
list `d` is the whole spectrum with multiplicity, and everything the rows ask,
how many negatives, which multiplicity, what the span is, is read off `d`.

That is enough for the record's witnesses, whose eigenvalues are rational, and
it is honest about not being available in general.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

/-- `V` is an eigenbasis for `M` with eigenvalue list `d`. -/
def IsEigenbasis {n : ℕ} (M V : Matrix (Fin n) (Fin n) ℚ) (d : Fin n → ℚ) : Prop :=
  M * V = V * Matrix.diagonal d ∧ V.det ≠ 0

/-- The eigenbasis of `W_{ℂP²}`: the three self-dual forms, then the three
anti-self-dual ones spanning the kernel. -/
def VCP2 : Matrix (Fin 6) (Fin 6) ℚ :=
  !![1, 0, 0,  1, 0,  0;
     0, 1, 0,  0, 1,  0;
     0, 0, 1,  0, 0,  1;
     0, 0, 1,  0, 0, -1;
     0, -1, 0, 0, 1,  0;
     1, 0, 0, -1, 0,  0]

/-- **The inverse of `VCP2`, written down rather than computed.**

*`VCP2` is block-diagonal in the three index pairs `{0,3}`, `{1,4}` and `{2,5}`*, each block a
`2 × 2` array of `±1`, so its inverse has entries `±½` in the same places. **This is what replaces
a `6 × 6` determinant**: Mathlib's closed forms stop at `det_fin_three`, and `decide` walls on `ℚ`
because `Rat.normalize` will not unfold cheaply, so the invertibility half of an eigenbasis had no
kernel route at all. *Exhibiting the inverse turns it into a matrix product, which `norm_num`
checks entry by entry.* -/
def VCP2inv : Matrix (Fin 6) (Fin 6) ℚ :=
  !![1/2,  0,   0,   0,    0,    1/2;
     0,    1/2, 0,   0,   -1/2,  0;
     0,    0,   1/2, 1/2,  0,    0;
     1/2,  0,   0,   0,    0,   -1/2;
     0,    1/2, 0,   0,    1/2,  0;
     0,    0,   1/2, -1/2, 0,    0]

/-- `VCP2inv * VCP2 = 1`, which is the invertibility with no determinant in sight. -/
theorem VCP2inv_mul : VCP2inv * VCP2 = 1 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [VCP2inv, VCP2, Matrix.mul_apply, Fin.sum_univ_six, Matrix.one_apply] <;> norm_num

/-- So `VCP2` is nonsingular. -/
theorem VCP2_det_ne_zero : VCP2.det ≠ 0 :=
  Matrix.det_ne_zero_of_left_inverse VCP2inv_mul

/-- **The full spectrum of `W_{ℂP²}` is `(2,-1,-1,0,0,0)`**, complete, not just
a list of exhibited eigenvalues, since the eigenbasis is invertible.

*This was two `native_decide` checks, so the record's only complete spectrum rested on the
compiler.* **Both halves are now kernel-checked**: the intertwining relation entry by entry, and
the invertibility through the exhibited inverse above. -/
theorem WCP2_isEigenbasis :
    IsEigenbasis WCP2 VCP2 ![2, -1, -1, 0, 0, 0] := by
  refine ⟨?_, VCP2_det_ne_zero⟩
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [WCP2, VCP2, Matrix.mul_apply, Fin.sum_univ_six, Matrix.diagonal_apply] <;> norm_num

/-- So it has **exactly one positive and exactly two negative** eigenvalues,
signature `(1,2)`, which makes `W₄(1,1) = -W_{ℂP²}` signature `(2,1)` as L34
requires of each summand. -/
theorem WCP2_signature :
    (Finset.univ.filter fun i => (![2, -1, -1, 0, 0, 0] : Fin 6 → ℚ) i < 0).card = 2 ∧
    (Finset.univ.filter fun i => (0:ℚ) < (![2, -1, -1, 0, 0, 0] : Fin 6 → ℚ) i).card = 1 := by
  constructor <;>
    simp [Finset.filter, Fin.sum_univ_six, Matrix.cons_val_zero, Matrix.cons_val_one,
      Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
      Matrix.vecHead, Matrix.vecTail] <;>
    decide

end HamiltonsCubic.Base
