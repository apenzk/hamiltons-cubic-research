import HamiltonsCubic.Results.F53

/-!
# Post 46, `θ = 9 det V₊` at the competitor

The post records that on the half-flat single-four-set cone `θ = 9 det V₊`, and
that `±W_{ℂP²}` is the only member where [L24](../../../findings/second-order.md)
can be evaluated.

**Unnormalised the identity is `P = 9 det V₊`**, and both sides are rational.
`W_{ℂP²}`'s self-dual block is `diag(2,-1,-1)`, whose determinant is `2`, and
`9 · 2 = 18 = P(W)`, [F53](F53.lean)'s value again, now from a determinant.

That is a fourth independent route to the same number, after `⟨W,Q(W)⟩`, the
`tr(W³) + ⟨W,W#⟩` split, and criticality's `3‖W‖²`.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

/-- The self-dual block, in the eigenbasis where it is diagonal. -/
def VPlus : Matrix (Fin 3) (Fin 3) ℚ := Matrix.diagonal ![2, -1, -1]

theorem VPlus_det : VPlus.det = 2 := by
  unfold VPlus
  rw [Matrix.det_diagonal]
  norm_num [Fin.prod_univ_succ]

/-- **`P = 9 det V₊`**, the post's identity with the normalisation divided out. -/
theorem P_eq_nine_det : Pcubic WCP2 = 9 * VPlus.det := by
  rw [VPlus_det, WCP2_P]
  norm_num

end HamiltonsCubic.Base
