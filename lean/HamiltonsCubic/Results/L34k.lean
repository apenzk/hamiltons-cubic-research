import HamiltonsCubic.Results.L33c

/-!
# L34, full support, from the eigenvector being invertible

L34's second claim is `dim U = m`, where `U` is the span of the images of the
negative eigenvectors. At the `m = 8` witness there are two of them: `W₄(1,1)`'s
`-2` eigenvector padded into each summand.

**That eigenvector is a complex structure**, so it is invertible and its image is
the whole 4-plane, [L33c](L33c.lean)'s `a² = -I` gives the inverse as `-a`
outright. Padded into the two summands, the two images are the two 4-planes, and
their span is all of `ℝ⁸`.

So the support is the union of the planes, which is what the block says, and the
reason is that a complex structure has no kernel.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

/-- **The eigenvector is invertible**, with `-a` as its inverse. -/
theorem sdA_mul_neg_self : sdA * (-sdA) = 1 := by
  rw [Matrix.mul_neg, sdA_complex_structure, neg_neg]

/-- **So it has no kernel**: `a v = 0` forces `v = 0`, which is why its image is
the whole 4-plane and the padded copies span their summands. -/
theorem sdA_no_kernel (v : Fin 4 → ℚ) (h : sdA *ᵥ v = 0) : v = 0 := by
  have h2 : sdA *ᵥ (sdA *ᵥ v) = 0 := by rw [h, Matrix.mulVec_zero]
  rw [Matrix.mulVec_mulVec, sdA_complex_structure, Matrix.neg_mulVec,
    Matrix.one_mulVec, neg_eq_zero] at h2
  exact h2

end HamiltonsCubic.Base
