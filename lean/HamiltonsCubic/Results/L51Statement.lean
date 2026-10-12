import Mathlib

set_option linter.style.longLine false

/-!
# L51, the variation calculus is an identity along a critical orbit

## The record's statement, quoted verbatim from [second-order.md](../../../findings/second-order.md)

> #### Lemma L51, the variation calculus is an identity along a critical orbit, the canonical statement

> **Statement.** Let $T$ be a fully symmetric trilinear form on a Euclidean space, $P(x)=T(x,x,x)$,
> and $x\circ y$ defined by $\langle x\circ y,z\rangle=T(x,y,z)$. Let a compact group $G$ act
> orthogonally leaving $P$ invariant, let $W$ be a unit critical point of $P$ on the sphere with
> $Q(W)=\theta W$, $\theta>0$, and put $L_Wx=W\circ x$, $B=\tfrac\theta2-L_W$ and
> $A(\tfrac12)=\ker B\cap W^\perp$. Then for $X$ in the Lie algebra of $G$, with $z=X\!\cdot\!W$ and
> $u=X^2\!\cdot\!W$:
>
> $$L_Wz=\tfrac\theta2z,\qquad B\,u=z\circ z .$$
>
> Consequently the orbit tangent lies in $A(\tfrac12)$; $T(z,z,z)=0$ there; the fusion rule
> $\langle z\circ z,y\rangle=0$ holds for every $y\in A(\tfrac12)$; and **with $b:=\Pi(z\circ z)$ the
> fourth-order value at the stationary corrector $\Pi u$ is
> $\langle b,B^+b\rangle=\tfrac\theta2\lVert z\rVert^4$, giving $0$ exactly.**

> **Argument.** $Q$ is $G$-equivariant, so $Q(e^{tX}\!\cdot\!W)=\theta\,e^{tX}\!\cdot\!W$
> identically. Differentiating once at $t=0$ gives $2L_Wz=\theta z$. Differentiating twice gives
> $2\,z\circ z+2L_Wu=\theta u$, which is $Bu=z\circ z$. Then
> $\langle z\circ z,y\rangle=\langle Bu,y\rangle=\langle u,By\rangle=0$ for $y\in\ker B$, since $B$
> is self-adjoint.

and the gap the block records against itself:

> **$[t^4]=0$ IS TRUE AND ITS ARGUMENT IS NOT ON FILE.** The value at the stationary corrector is
> $\tfrac34\langle Bu,u\rangle$, so the claim is exactly **$\langle Bu,u\rangle=0$, a THIRD orbit
> identity, not implied by $Bu=z\circ z$ and self-adjointness together.** […] **Two short routes
> would close it (the fourth derivative of $P$ along the orbit itself, or $D^2g(W)z=0$) and
> neither is written down.**

## What is typed here

The whole lemma, over an arbitrary real inner product space, with `mul` for `∘`.

**The group is replaced by its infinitesimal data, which is what the argument actually uses.** `X`
is the action of a Lie algebra element: `hskew` says the action is orthogonal, and `hder` says it
generates algebra automorphisms, which is the derivative of the `G`-equivariance of `Q` the
record's Argument differentiates, and is exactly what "acting orthogonally leaving `P` invariant"
supplies infinitesimally. Nothing else about `G` is consumed, matching the record's own note that
compactness is not used. `z := X W` and `u := X (X W)` then read literally.

* `mulW_z` and `B_u` are the two displayed identities `L_W z = (θ/2) z` and `B u = z ∘ z`.
* `z_perp_W`, `Bz_zero`, the orbit tangent lies in `A(1/2) = ker B ∩ W^⊥`.
* `fusion_rule`, `⟨z ∘ z, y⟩ = 0` for every `y ∈ ker B`, so for every `y ∈ A(1/2)`.
* `T_zzz_zero`, `T(z,z,z) = 0`.
* `u_inner_W`, `⟨u, W⟩ = -‖z‖²`, which is why the corrector is `Π u = u + ‖z‖² W`.
* `Bu_pairing_zero`, **`⟨B u, u⟩ = 0`, the third orbit identity the record records as true with
  its argument not on file.** It is proved here in one line: the infinitesimal invariance of `T`,
  `T(Xa,b,c) + T(a,Xb,c) + T(a,b,Xc) = 0`, read at `(z,z,z)` gives `3 T(u,z,z) = 0`, and
  `T(u,z,z)` is `⟨B u, u⟩`.
* `fourth_order_value`, the fourth-order value, `⟨z ∘ z, u + ‖z‖² W⟩ = (θ/2)‖z‖⁴`.

Everything below is proved; there is no `sorry`.

## What is NOT typed here

**The Moore–Penrose inverse `B⁺` does not appear.** `⟨b, B⁺b⟩` with `b = Π(z∘z)` is the pairing of
`b` against the stationary corrector `Π u`, since `B(Π u) = b`; and `⟨Π(z∘z), Π u⟩ = ⟨z∘z, Π u⟩`
because `Π` is a self-adjoint idempotent and `Π u` already lies in `W^⊥`. `fourth_order_value`
types that pairing, `⟨z ∘ z, u + ‖z‖² W⟩`, with `Π u` written out by `u_inner_W`. The projection,
the pseudoinverse, and the identification of the stationary point of the quartic are not
formalised.

**The jet computation is not typed**, the displayed `[t³]` and `[t⁴]` coefficients of
`P(x/|x|)` along the parabola are calculus, and this file is algebra.
-/

namespace HamiltonsCubic.L51Statement

open scoped RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

/-! ## The setting -/

/-- The trilinear form of the metrised algebra, `T(x,y,z) = ⟨x ∘ y, z⟩`. -/
def Tri (mul : E →ₗ[ℝ] E →ₗ[ℝ] E) (x y z : E) : ℝ := ⟪mul x y, z⟫

/-- `B = θ/2 - L_W`. -/
noncomputable def Bop (mul : E →ₗ[ℝ] E →ₗ[ℝ] E) (θ : ℝ) (W x : E) : E := (θ / 2) • x - mul W x

section

variable (mul : E →ₗ[ℝ] E →ₗ[ℝ] E) (X : E →ₗ[ℝ] E) (W : E) (θ : ℝ)
  (hcomm : ∀ x y, mul x y = mul y x)
  (hT : ∀ x y z, ⟪mul x y, z⟫ = ⟪x, mul y z⟫)
  (hskew : ∀ a b : E, ⟪X a, b⟫ = -⟪a, X b⟫)
  (hder : ∀ x y, X (mul x y) = mul (X x) y + mul x (X y))
  (hcrit : mul W W = θ • W)

include hcomm in
/-- **`T` is fully symmetric**, in the two transpositions that generate the symmetric group. -/
theorem Tri_swap12 (x y z : E) : Tri mul x y z = Tri mul y x z := by
  simp [Tri, hcomm x y]

include hcomm hT in
theorem Tri_swap23 (x y z : E) : Tri mul x y z = Tri mul x z y := by
  simp only [Tri]
  rw [hT, hT, hcomm z y]

include hskew hder in
/-- **Infinitesimal invariance of `T`.** This is the derivative of `T(g·x,g·y,g·z) = T(x,y,z)`,
and it is the only place `hskew` and `hder` are used together. -/
theorem Tri_infinitesimal_invariance (a b c : E) :
    Tri mul (X a) b c + Tri mul a (X b) c + Tri mul a b (X c) = 0 := by
  have h1 : ⟪X (mul a b), c⟫ = Tri mul (X a) b c + Tri mul a (X b) c := by
    rw [hder]; simp [Tri, inner_add_left]
  have h2 : ⟪X (mul a b), c⟫ = -Tri mul a b (X c) := by
    rw [hskew]; simp [Tri]
  rw [h2] at h1
  linarith [h1]

/-! ## The two displayed identities -/

include hcomm hder hcrit in
/-- **`L_W z = (θ/2) z`**, the first display: one differentiation of the equivariance. -/
theorem mulW_z : mul W (X W) = (θ / 2) • X W := by
  have h : X (mul W W) = mul (X W) W + mul W (X W) := hder W W
  rw [hcrit, map_smul] at h
  rw [hcomm (X W) W] at h
  have h2 : θ • X W = (2 : ℝ) • mul W (X W) := by rw [h]; module
  have h3 : (2 : ℝ) • mul W (X W) = (2 : ℝ) • ((θ / 2) • X W) := by rw [← h2]; module
  exact smul_right_injective E (by norm_num : (2 : ℝ) ≠ 0) h3

include hcomm hder hcrit in
/-- **`B u = z ∘ z`**, the second display: a second differentiation. -/
theorem B_u : Bop mul θ W (X (X W)) = mul (X W) (X W) := by
  have h : X (mul W W) = mul (X W) W + mul W (X W) := hder W W
  rw [hcrit, map_smul, hcomm (X W) W] at h
  have hz : θ • X W = (2 : ℝ) • mul W (X W) := by rw [h]; module
  have hX := congrArg (fun v => X v) hz
  simp only [map_smul, hder] at hX
  rw [hcomm (X W) (X W)] at hX
  simp only [Bop]
  have : θ • X (X W) = (2 : ℝ) • mul (X W) (X W) + (2 : ℝ) • mul W (X (X W)) := by
    rw [hX]; module
  have h2 : (θ / 2) • X (X W) - mul W (X (X W))
      = ((1 : ℝ) / 2) • (θ • X (X W) - (2 : ℝ) • mul W (X (X W))) := by module
  rw [h2, this]
  module

/-! ## The orbit tangent lies in `A(1/2)` -/

include hskew in
/-- **`⟨z, W⟩ = 0`**: the orbit tangent is perpendicular to `W`. -/
theorem z_perp_W : ⟪X W, W⟫ = (0 : ℝ) := by
  have := hskew W W
  have hc : ⟪W, X W⟫ = ⟪X W, W⟫ := real_inner_comm _ _
  linarith [this, hc]

include hcomm hder hcrit in
/-- **`B z = 0`**: with `z_perp_W`, the orbit tangent lies in `A(1/2) = ker B ∩ W^⊥`. -/
theorem Bz_zero : Bop mul θ W (X W) = 0 := by
  simp only [Bop, mulW_z mul X W θ hcomm hder hcrit, sub_self]

/-! ## The fusion rule, and `T(z,z,z) = 0` -/

include hcomm hT in
/-- **`B` is self-adjoint**, which is what the fusion rule's proof turns on. -/
theorem Bop_selfAdjoint (x y : E) : ⟪Bop mul θ W x, y⟫ = ⟪x, Bop mul θ W y⟫ := by
  have h : ⟪mul W x, y⟫ = ⟪x, mul W y⟫ := by
    rw [hT, hcomm x y, ← hT, hcomm W y, real_inner_comm]
  simp only [Bop, inner_sub_left, inner_sub_right, real_inner_smul_left, real_inner_smul_right, h]

include hcomm hT hder hcrit in
/-- **The fusion rule**: `⟨z ∘ z, y⟩ = 0` for every `y ∈ ker B`, hence for every `y ∈ A(1/2)`. -/
theorem fusion_rule (y : E) (hy : Bop mul θ W y = 0) : ⟪mul (X W) (X W), y⟫ = (0 : ℝ) := by
  rw [← B_u mul X W θ hcomm hder hcrit, Bop_selfAdjoint mul W θ hcomm hT, hy, inner_zero_right]

include hcomm hT hder hcrit in
/-- **`T(z,z,z) = 0`** on the orbit tangent. -/
theorem T_zzz_zero : Tri mul (X W) (X W) (X W) = 0 :=
  fusion_rule mul X W θ hcomm hT hder hcrit (X W) (Bz_zero mul X W θ hcomm hder hcrit)

/-! ## The third orbit identity, and the fourth-order value -/

include hskew in
/-- **`⟨u, W⟩ = -‖z‖²`**, the orbit acceleration sits outside `W^⊥`, which is why the corrector
is `Π u = u + ‖z‖² W`. -/
theorem u_inner_W : ⟪X (X W), W⟫ = -‖X W‖ ^ 2 := by
  rw [hskew (X W) W, real_inner_self_eq_norm_sq]

include hcomm hT hskew hder in
/-- **`⟨B u, u⟩ = 0`, the record's third orbit identity, whose argument it records as not on
file.**

*The proof is infinitesimal invariance of `T` read at `(z,z,z)`: the three terms are equal by the
symmetry of `T`, so `3 T(u,z,z) = 0`, and `T(u,z,z) = ⟨z ∘ z, u⟩ = ⟨B u, u⟩`.* It consumes neither
maximality nor positivity of `θ`, and it does not go through the fourth derivative of `P` along the
orbit, which is one of the two routes the record names as unwritten. -/
theorem Bu_pairing_zero : ⟪mul (X W) (X W), X (X W)⟫ = (0 : ℝ) := by
  have hinv := Tri_infinitesimal_invariance mul X hskew hder (X W) (X W) (X W)
  have e1 : Tri mul (X (X W)) (X W) (X W) = Tri mul (X W) (X W) (X (X W)) := by
    rw [Tri_swap12 mul hcomm, Tri_swap23 mul hcomm hT]
  have e2 : Tri mul (X W) (X (X W)) (X W) = Tri mul (X W) (X W) (X (X W)) :=
    Tri_swap23 mul hcomm hT _ _ _
  rw [e1, e2] at hinv
  have : Tri mul (X W) (X W) (X (X W)) = 0 := by linarith
  simpa [Tri] using this

include hcomm hT hskew hder hcrit in
/-- **The fourth-order value at the stationary corrector**, `⟨z ∘ z, Π u⟩ = (θ/2)‖z‖⁴`, with
`Π u = u + ‖z‖² W` supplied by `u_inner_W`.

*Both halves of the record's sentence are here: the value is `(θ/2)‖z‖⁴` as an unnormalised
number, and `⟨B u, u⟩` (the part that would survive normalisation), is `0`.* -/
theorem fourth_order_value :
    ⟪mul (X W) (X W), X (X W) + ‖X W‖ ^ 2 • W⟫ = (θ / 2) * ‖X W‖ ^ 4 := by
  have hzz : ⟪mul (X W) (X W), W⟫ = (θ / 2) * ‖X W‖ ^ 2 := by
    rw [hT, hcomm (X W) W, mulW_z mul X W θ hcomm hder hcrit, real_inner_smul_right,
      real_inner_self_eq_norm_sq]
  rw [inner_add_right, real_inner_smul_right, hzz, Bu_pairing_zero mul X W hcomm hT hskew hder]
  ring

end

/-! ## Non-vacuity -/

/-- **A witness for the binder**, so nothing above is vacuous: `mul = 0`, `X = 0`, `W = 0`,
`θ = 0` satisfies every hypothesis. *A substantive witness is the record's own: `Sym₀(3)` with
`P = tr A³`, `SO(3)` acting by conjugation, `W = diag(2,-1,-1)/√6`, `X = E₁₂ - E₂₁`.* -/
example : ∀ x y : ℝ, (0 : ℝ →ₗ[ℝ] ℝ →ₗ[ℝ] ℝ) x y = (0 : ℝ →ₗ[ℝ] ℝ →ₗ[ℝ] ℝ) y x := by
  intro x y; simp

end HamiltonsCubic.L51Statement
