import Mathlib

set_option linter.style.longLine false

/-!
# I53, the third orbit identity: `⟪B u, u⟫ = 0` at every critical point

## What this file is

[I53](../../../plan.md) asks for `⟪B u, u⟫ = 0` at every critical point, with `u = X² · W`,
`z = X · W` and `B = θ/2 - L_W`. Its [analysis](../../../findings/second-order.md) records that the
identity is NOT implied by `B u = z ∘ z` together with self-adjointness, and names two routes that
would close it, **the fourth derivative of `P` along the orbit itself**, or `D²g(W) z = 0`. This file
types the first.

## The derivation this file types

Write `w(t) = exp(tX) · W`, so `w' = z`, `w'' = u`, `w''' = X³W`, `w'''' = X⁴W`. Since the action
preserves the inner product and the product, `P(w) = T(w,w,w)` is CONSTANT along the orbit, with
`T a b c = ⟪a ∘ b, c⟫` fully symmetric. The multinomial expansion of the fourth derivative at `t = 0`
is then

  `3 T(X⁴W, W, W) + 24 T(X³W, z, W) + 18 T(u, u, W) + 36 T(u, z, z) = 0`,

the coefficients being `4!/(i!j!k!)` summed over the arrangements of `(4,0,0)`, `(3,1,0)`, `(2,2,0)`
and `(2,1,1)`. Four substitutions, each an identity the record already carries, collapse it:

* `T(a, W, W) = θ ⟪a, W⟫`, criticality `Q(W) = θ W`;
* `T(a, z, W) = (θ/2) ⟪a, z⟫`, the first derivative, `L_W z = (θ/2) z`;
* `T(a, u, W) = (θ/2) ⟪a, u⟫ - T(a, z, z)`, the second derivative, `B u = z ∘ z`, paired with `a`;
* `⟪X⁴W, W⟫ = ⟪u, u⟫` and `⟪X³W, z⟫ = -⟪u, u⟫`, from `X` being skew-adjoint.

**The `θ` terms then cancel identically**, `3 - 12 + 9 = 0`, leaving `18 T(u, z, z) = 0`. *That
cancellation is the whole content, and it is visible in the statement below as the ABSENCE of `θ`
from the conclusion: the identity holds at every real `θ`, so no bound on `θ` is being used.*

## What is proved

* `skew_four` and `skew_three`: the two pairings of iterates of a skew-adjoint `X`, derived rather
  than assumed.
* `inner_u_z_eq_zero`: `⟪u, z⟫ = 0`, which is what makes the THIRD derivative's own identity
  consistent, and is the independent cross-check on the expansion above.
* `vanishing_from_invariance`: **the short route, and the one to read.** Infinitesimal invariance of
  `T` alone, evaluated at `(z,z,z)`, gives `3 T(u,z,z) = 0`. *No criticality, no fourth derivative, no
  skew-adjointness, and no `θ`.* **Found independently by both Gate 2 readers of the derivation
  below**, which is how this file came to carry two proofs of one statement.
* `pairing_vanishes`: the theorem by the FOURTH DERIVATIVE. From the orbit's fourth-derivative
  relation and the three substitution identities, `T(u, z, z) = 0`, which is `⟪B u, u⟫ = 0`. *Kept
  because it is the route the record named as unwritten, and because the two together show what the
  `θ` cancellation was: an artefact of a longer road to a `θ`-free fact.*

## What is NOT stated

That the fourth-derivative relation holds, which is the multinomial expansion of `d⁴/dt⁴ T(w,w,w)`
at a curve in a real inner product space, and that `T` is the fully symmetric form of the Weyl
product. Both are hypotheses here, named as `horbit` and supplied pointwise. **`T` is an arbitrary
function of three vectors in this file**, so nothing below depends on the product's construction:
what is typed is that these four identities FORCE the pairing to vanish, with no further input and
no constraint on `θ`.
-/

namespace HamiltonsCubic.I53OrbitIdentity

open RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

/-- **`⟪X⁴W, W⟫ = ⟪X²W, X²W⟫` for skew-adjoint `X`**, two sign flips returning the norm. -/
theorem skew_four {X : E →ₗ[ℝ] E} (hX : ∀ v w, ⟪X v, w⟫ = -⟪v, X w⟫) (W : E) :
    ⟪X (X (X (X W))), W⟫ = ⟪X (X W), X (X W)⟫ := by
  rw [hX (X (X (X W))) W, hX (X (X W)) (X W)]
  ring

/-- **`⟪X³W, XW⟫ = -⟪X²W, X²W⟫`**, one sign flip. -/
theorem skew_three {X : E →ₗ[ℝ] E} (hX : ∀ v w, ⟪X v, w⟫ = -⟪v, X w⟫) (W : E) :
    ⟪X (X (X W)), X W⟫ = -⟪X (X W), X (X W)⟫ :=
  hX (X (X W)) (X W)

/-- **`⟪u, z⟫ = 0`**, with `u = X²W` and `z = XW`.

*This is the cross-check on the expansion: the THIRD derivative of `P` along the orbit reduces to
`6 θ ⟪u, z⟫ = 0`, which is consistent only because this vanishes for a reason of its own.* -/
theorem inner_u_z_eq_zero {X : E →ₗ[ℝ] E} (hX : ∀ v w, ⟪X v, w⟫ = -⟪v, X w⟫) (W : E) :
    ⟪X (X W), X W⟫ = 0 := by
  have h := hX (X W) (X W)
  have hc : ⟪X W, X (X W)⟫ = ⟪X (X W), X W⟫ := real_inner_comm _ _
  linarith

/-- **THE SHORT ROUTE, and it is the one to read.** `T` is invariant under a group acting by
isometries that are automorphisms of `∘`, so differentiating `T(ga,gb,gc) = T(a,b,c)` at the identity
gives the derivation identity `T(Xa,b,c) + T(a,Xb,c) + T(a,b,Xc) = 0`. Evaluate it at `a = b = c = z`:
the three terms are equal by symmetry and `X z = X²W = u`, so `3 T(u,z,z) = 0`.

**This uses NEITHER criticality, NOR the fourth derivative, NOR skew-adjointness of `X`.** *It holds
at every `W` whatever `θ` is, and criticality enters the item only to identify `⟪B u, u⟫` with
`T(u,z,z)`, which is `hB` below at `a = u`.* **So the `3 - 12 + 9 = 0` cancellation in
`pairing_vanishes` is a symptom rather than the content**: the fourth-derivative route never depended
on `θ` because the identity never needed `θ` at all.

*Found independently by both Gate 2 readers of this file's first derivation.* -/
theorem vanishing_from_invariance {X : E →ₗ[ℝ] E} (T : E → E → E → ℝ) (W : E)
    (hswap12 : ∀ a b c, T a b c = T b a c)
    (hswap23 : ∀ a b c, T a b c = T a c b)
    (hinv : ∀ a b c, T (X a) b c + T a (X b) c + T a b (X c) = 0) :
    T (X (X W)) (X W) (X W) = 0 := by
  have h := hinv (X W) (X W) (X W)
  have e1 : T (X W) (X (X W)) (X W) = T (X (X W)) (X W) (X W) := hswap12 _ _ _
  have e2 : T (X W) (X W) (X (X W)) = T (X (X W)) (X W) (X W) := by
    rw [hswap23 (X W) (X W) (X (X W)), hswap12 (X W) (X (X W)) (X W)]
  linarith

/-- **I53's theorem, by the fourth derivative.** At a critical point, `⟪B u, u⟫ = T(u, z, z) = 0`.

The hypotheses are, in order: `X` skew-adjoint; criticality `Q(W) = θ W` read through `T`; the first
derivative `L_W z = (θ/2) z`; the second derivative `B u = z ∘ z` paired against an arbitrary vector;
and the orbit's fourth-derivative relation.

**`θ` is a free real and does not appear in the conclusion.** *That is the cancellation `3 - 12 + 9 =
0` made visible: the identity is not a consequence of any bound on `θ`, and a proof that needed one
would be a different statement.* -/
theorem pairing_vanishes
    {X : E →ₗ[ℝ] E} (hX : ∀ v w, ⟪X v, w⟫ = -⟪v, X w⟫)
    (T : E → E → E → ℝ) (W : E) (θ : ℝ)
    (hcrit : ∀ a, T a W W = θ * ⟪a, W⟫)
    (hfirst : ∀ a, T a (X W) W = θ / 2 * ⟪a, X W⟫)
    (hB : ∀ a, T a (X (X W)) W = θ / 2 * ⟪a, X (X W)⟫ - T a (X W) (X W))
    (horbit : 3 * T (X (X (X (X W)))) W W + 24 * T (X (X (X W))) (X W) W
        + 18 * T (X (X W)) (X (X W)) W + 36 * T (X (X W)) (X W) (X W) = 0) :
    T (X (X W)) (X W) (X W) = 0 := by
  have h4 := hcrit (X (X (X (X W))))
  have h3 := hfirst (X (X (X W)))
  have h2 := hB (X (X W))
  rw [skew_four hX W] at h4
  rw [skew_three hX W] at h3
  rw [h4, h3, h2] at horbit
  linarith

end HamiltonsCubic.I53OrbitIdentity
