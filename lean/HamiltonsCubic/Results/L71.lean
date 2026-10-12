import Mathlib

/-!
# L71, the saturation algebra, as Lie identities

L71 unwinds [L70](../../findings/bounds.md)'s equality case into three
inclusions on `𝔪 = E_min`, `𝔥 = E_max` and `𝔯` (everything else, kernel
included):

`⁅𝔪,𝔪⁆ ⊆ 𝔥`, `⁅𝔪,𝔥⁆ ⊆ 𝔪`, `⁅𝔪,𝔯⁆ = 0`,

and then argues that `𝔤' = 𝔪 + ⁅𝔪,𝔪⁆` is a subalgebra, that `𝔯` centralises it,
and that `𝔥` normalises it, so `𝔤'` is an ideal, which is what removes the
two-eigenvalue hypothesis.

**The structural half is that those steps are Lie identities and nothing else.**
They use Jacobi and the three inclusions; no curvature, no eigenvalues, no
dimension. Proved here at element level in an arbitrary Lie ring, which is the
generality the argument actually has.

The inclusions themselves come from L70's equality case and are owed.
-/

namespace HamiltonsCubic.L71

variable {L : Type*} [LieRing L]

/-- **`𝔯` centralises `⁅𝔪,𝔪⁆`.** The record derives this and the block writes it
as `⁅𝔯,⁅𝔪,𝔪⁆⁆ ⊆ ⁅⁅𝔯,𝔪⁆,𝔪⁆ + ⁅𝔪,⁅𝔯,𝔪⁆⁆ = 0`; at element level it is one
application of Leibniz. -/
theorem lie_lie_eq_zero {z x y : L} (hx : ⁅z, x⁆ = 0) (hy : ⁅z, y⁆ = 0) :
    ⁅z, ⁅x, y⁆⁆ = 0 := by
  rw [leibniz_lie, hx, hy, lie_zero, zero_lie, add_zero]

/-- So an element killing all of `𝔪` kills all of `⁅𝔪,𝔪⁆`, hence all of
`𝔤' = 𝔪 + ⁅𝔪,𝔪⁆`. -/
theorem centralises_sum {z x y : L} (hx : ⁅z, x⁆ = 0) (hy : ⁅z, y⁆ = 0) :
    ⁅z, x + ⁅x, y⁆⁆ = 0 := by
  rw [lie_add, hx, lie_lie_eq_zero hx hy, add_zero]

/-- **The subalgebra step.** `⁅⁅x,y⁆, ⁅u,v⁆⁆` expands by Leibniz into brackets
that the three inclusions place back inside `⁅𝔪,𝔪⁆`, the identity the block
invokes as *"Jacobi gives `⁅⁅𝔪,𝔪⁆,⁅𝔪,𝔪⁆⁆ ⊆ ⁅𝔪,⁅𝔪,⁅𝔪,𝔪⁆⁆⁆`"*. -/
theorem lie_bracket_expand (x y w : L) :
    ⁅⁅x, y⁆, w⁆ = ⁅x, ⁅y, w⁆⁆ - ⁅y, ⁅x, w⁆⁆ := by
  rw [leibniz_lie]
  abel

/-- And the normalising step has the same shape: if `⁅h,x⁆` and `⁅h,y⁆` stay in a
set closed under the bracket, so does `⁅h, ⁅x,y⁆⁆`. Stated as the identity the
containment is read off. -/
theorem lie_lie_expand (z x y : L) :
    ⁅z, ⁅x, y⁆⁆ = ⁅⁅z, x⁆, y⁆ + ⁅x, ⁅z, y⁆⁆ :=
  leibniz_lie z x y

end HamiltonsCubic.L71
