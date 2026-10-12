import HamiltonsCubic.Results.L34d

/-!
# L34, eigenvectors transfer through padding

The count *exactly two negative eigenvalues* needs the two summands' spectra to
add. The obvious route (a `28 × 28` eigenbasis and a determinant), is out of
reach, `Matrix.det` being a sum over permutations.

**The structural route is that eigenvectors transfer.** A padded eigenvector of
a summand is an eigenvector of the sum with the same eigenvalue, and every mixed
bivector is in the kernel. Both follow from the blockwise action in
[L34d](L34d.lean) and need no determinant.

That gives the spectrum's *content*, every eigenvalue of each copy appears, and
the mixed directions contribute `0`. It does not give *completeness*: that these
are all of them needs the exhibited vectors to be independent, which is where a
determinant would have come in.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

variable {m k : Type*} [Fintype m] [DecidableEq m] [Fintype k] [DecidableEq k]

/-- **An eigenvector of the first summand stays one after padding**, with the
same eigenvalue. -/
theorem eigen_transfer (R : Matrix m m ℚ → Matrix m m ℚ) (S : Matrix k k ℚ → Matrix k k ℚ)
    (hS0 : S 0 = 0) {X : Matrix m m ℚ} {lam : ℚ} (hX : R X = lam • X) :
    padOp (k := k) R (pad X) + padOp₂ (m := m) S (pad X) = lam • pad X := by
  rw [sum_on_pad R S hS0, hX]
  unfold pad
  ext i j
  cases i <;> cases j <;> simp [Matrix.fromBlocks]

/-- **And one of the second summand likewise.** -/
theorem eigen_transfer₂ (R : Matrix m m ℚ → Matrix m m ℚ) (S : Matrix k k ℚ → Matrix k k ℚ)
    (hR0 : R 0 = 0) {Y : Matrix k k ℚ} {lam : ℚ} (hY : S Y = lam • Y) :
    padOp (k := k) R (pad₂ Y) + padOp₂ (m := m) S (pad₂ Y) = lam • pad₂ Y := by
  rw [sum_on_pad₂ R S hR0, hY]
  unfold pad₂
  ext i j
  cases i <;> cases j <;> simp [Matrix.fromBlocks]

/-- **Every mixed bivector is in the kernel**, eigenvalue `0`, the third block
of the spectrum. -/
theorem eigen_mixed (R : Matrix m m ℚ → Matrix m m ℚ) (S : Matrix k k ℚ → Matrix k k ℚ)
    (hR0 : R 0 = 0) (hS0 : S 0 = 0) (a : m) (c : k) :
    padOp (k := k) R (phi (Sum.inl a) (Sum.inr c))
      + padOp₂ (m := m) S (phi (Sum.inl a) (Sum.inr c))
      = (0 : ℚ) • phi (Sum.inl a) (Sum.inr c) := by
  rw [sum_on_mixed R S hR0 hS0, zero_smul]

end HamiltonsCubic.Base
