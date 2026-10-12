import Mathlib

set_option linter.style.longLine false

/-!
# L101, the `SO(n)`-invariance identity, and the orthogonality it delivers

## The record's statement, as audited in [ROUND_L101](../../../verification/ROUND_L101.md)

[route-a.md](../../../findings/route-a.md)'s Lemma L101, with $V_\lambda=\{x:F_ux=\lambda\theta^*x\}$
the labelling by eigenvalue over $\theta^*$ and $A\cdot x=[\rho(A),x]$:

> 1. For $x\in V_\lambda$ and $y\in V_\mu$, $T(x,y,[\rho(A),u])=(\lambda-\mu)\,\theta^*\langle A\!\cdot\!x,y\rangle$.
> 2. Hence $Q(x)\perp T_u(SO(n).u)$ for every eigenvector $x$ of $F_u$.
> 3. At $n\ge9$, $P\equiv0$ on $V_{1/2}$.

Parts 1 and 2 use no property of $u$ beyond membership, no criticality and no dimension. Part 3
uses criticality of $u$ and Lemma L21, which give $V_{1/2}=T_u(SO(n).u)$, and then part 1 at
$y=x=A\cdot u$.

## What is typed here

Over a real inner product space, with `D` the derivation of an `SO(n)` one-parameter subgroup and
`T` the trilinear form, the two identities and the orthogonality they give:

* `skew_self_inner_zero`, a Frobenius-skew derivation has `⟪x, D x⟫ = 0`, the step the record
  cites.
* `invariance_identity_general`, **the general form**, `T x y (D u) = (λ - μ)⟪D x, y⟫` for `x`
  a `λ`-eigenvector and `y` a `μ`-eigenvector of `F_u`. *Under the record's normalisation, where
  the eigenvalues of `F_u` are `λθ*`, this reads `(λ - μ)θ*⟪D x, y⟫`, which is
  `invariance_identity_record_normalisation`.*
* `invariance_identity_diagonal`, the diagonal case `T x x (D u) = 0`.
* `Q_perp_orbit_tangent`, **the orthogonality**: `⟪Q x, D u⟫ = 0` for every eigenvector `x` of
  `F_u` and every such `D`. *No criticality of `u` is assumed and no dimension is fixed, which is
  the Gate 2 widening; the hypotheses are one differentiated invariance identity and the symmetry
  of `T` in its first two slots.*
* `norm_identity_closed_form`, `Qu_norm_exceeds_one`, the table's headline constant as arithmetic:
  with `θ*² = 3/2`, `√(1 - θ*²/9) = √(5/6)` and `1/6 + 5/6 = 1`; and `θ* > 1`, so the
  identity is not free.

Everything is proved; there is no `sorry`.

## What is NOT typed here

**Part 3 is typed with its inclusion as a hypothesis.** `P_zero_of_orbit_tangent_eigenvector`
takes `x = D u`, the orbit-tangent form of an eigenvector, and concludes `T x x x = 0`. The
inclusion `V_{1/2} ⊆ T_u𝒪` that makes every `V_{1/2}` vector such an `x` comes from criticality
of `u` and Lemma L21 at `n ≥ 9`, and stating it would need the eigenspace decomposition of `F_u`
and the orbit, which [WeylReal.lean](../Base/WeylReal.lean) does not carry.

**`P ≡ 0` on `T_u𝒪` (the repair the record proposes), is not stated either.** It is
[Lemma L51](../../../findings/second-order.md)'s, and it does not follow from the three-term
identity: taking `x = y = z = Du` in the identity gives a relation involving `D²u`, not `0`.

**`D` below is an arbitrary map that is skew for the inner product and satisfies the differentiated
invariance identity.** The record's `D = [ad A, ·]` is one such: [OrbitDeriv.lean](OrbitDeriv.lean)'s
`foxTri_hder` and `innerOp_Dop_skew` prove both hypotheses for `T = foxTri` on linear operators, and
`orbit_half` is the first step of part 3 there, `T_u(SO(n).u) ⊆ V_{1/2}`. Transporting them into this file's abstract
`E` needs `𝒲ₙ` bundled as an inner product space. Its closure under `D` is [OrbitWeyl.lean](OrbitWeyl.lean)'s
`Dop_weylOp`, and the bundling is what the layer does not yet build.

**The suprema in the record's table are not typed.** Gate 2 records that "exhaustively verified"
licenses the vanishings and not the suprema, `78` basis vectors do not sample a `78`-dimensional
sphere, so the numbers `√(5/6)`, `2/3` and `0.91` are typed here only as arithmetic relations
between constants, not as attained maxima.
-/

namespace HamiltonsCubic.L101Statement

open RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

/-! ## The two identities -/

/-- **A Frobenius-skew derivation has `⟪x, D x⟫ = 0`.** -/
theorem skew_self_inner_zero {D : E → E} (hskew : ∀ v w, ⟪D v, w⟫ = -⟪v, D w⟫) (x : E) :
    ⟪x, D x⟫ = 0 := by
  have h := hskew x x
  have hc : ⟪D x, x⟫ = ⟪x, D x⟫ := real_inner_comm _ _
  linarith [h, hc]

/-- **THE GENERAL FORM OF THE INVARIANCE IDENTITY.** For `x` a `λ`-eigenvector and `y` a
`μ`-eigenvector of `F_u` (read here through `T · · u = ⟪F_u ·, ·⟫`), the identity is exact:
`T x y (D u) = (λ - μ)⟪D x, y⟫`. -/
theorem invariance_identity_general {T : E → E → E → ℝ} {D : E → E} {u x y : E} {lam mu : ℝ}
    (hsym : ∀ p q r, T p q r = T q p r)
    (hder : ∀ p q r, T (D p) q r + T p (D q) r + T p q (D r) = 0)
    (hskew : ∀ v w, ⟪D v, w⟫ = -⟪v, D w⟫)
    (hx : ∀ z, T x z u = lam * ⟪x, z⟫)
    (hy : ∀ z, T y z u = mu * ⟪y, z⟫) :
    T x y (D u) = (lam - mu) * ⟪D x, y⟫ := by
  have h := hder x y u
  have e1 : T (D x) y u = mu * ⟪D x, y⟫ := by
    rw [hsym (D x) y u, hy (D x), real_inner_comm]
  have e2 : T x (D y) u = -(lam * ⟪D x, y⟫) := by
    have hxy : ⟪D x, y⟫ = -⟪x, D y⟫ := hskew x y
    rw [hx (D y), hxy]; ring
  rw [e1, e2] at h
  linarith

/-- **The identity under the record's normalisation**, where the eigenvalues of `F_u` carry the
factor `θ*`: `T x y (D u) = (λ - μ)θ*⟪D x, y⟫`. -/
theorem invariance_identity_record_normalisation
    {T : E → E → E → ℝ} {D : E → E} {u x y : E} {lam mu ths : ℝ}
    (hsym : ∀ p q r, T p q r = T q p r)
    (hder : ∀ p q r, T (D p) q r + T p (D q) r + T p q (D r) = 0)
    (hskew : ∀ v w, ⟪D v, w⟫ = -⟪v, D w⟫)
    (hx : ∀ z, T x z u = (lam * ths) * ⟪x, z⟫)
    (hy : ∀ z, T y z u = (mu * ths) * ⟪y, z⟫) :
    T x y (D u) = (lam - mu) * ths * ⟪D x, y⟫ := by
  have := invariance_identity_general hsym hder hskew hx hy
  rw [this]; ring

/-- **THE DIAGONAL CASE VANISHES.** `T x x (D u) = 0` for every eigenvector `x` of `F_u`. -/
theorem invariance_identity_diagonal {T : E → E → E → ℝ} {D : E → E} {u x : E} {lam : ℝ}
    (hsym : ∀ p q r, T p q r = T q p r)
    (hder : ∀ p q r, T (D p) q r + T p (D q) r + T p q (D r) = 0)
    (hskew : ∀ v w, ⟪D v, w⟫ = -⟪v, D w⟫)
    (hx : ∀ z, T x z u = lam * ⟪x, z⟫) :
    T x x (D u) = 0 := by
  have h := invariance_identity_general (mu := lam) hsym hder hskew hx hx
  simpa using h

/-- **`Q(x) ⊥ T_u(SO(n)·u)` FOR EVERY EIGENVECTOR, IN EVERY DIMENSION.** With `Q x` the vector
representing `z ↦ T x x z`, the orbit tangent direction `D u` is orthogonal to it. *Criticality of
`u` is not among the hypotheses, matching the record's own note that the argument never uses it,
and the Gate 2 widening that this holds at any base point.* -/
theorem Q_perp_orbit_tangent {T : E → E → E → ℝ} {D : E → E} {u x Qx : E} {lam : ℝ}
    (hsym : ∀ p q r, T p q r = T q p r)
    (hder : ∀ p q r, T (D p) q r + T p (D q) r + T p q (D r) = 0)
    (hskew : ∀ v w, ⟪D v, w⟫ = -⟪v, D w⟫)
    (hx : ∀ z, T x z u = lam * ⟪x, z⟫)
    (hQ : ∀ z, ⟪Qx, z⟫ = T x x z) :
    ⟪Qx, D u⟫ = 0 := by
  rw [hQ (D u)]
  exact invariance_identity_diagonal hsym hder hskew hx

/-- **PART 3, GIVEN ITS INCLUSION: `P` VANISHES ON AN EIGENVECTOR THAT IS AN ORBIT TANGENT.** If
`x` is an eigenvector of `F_u` and `x = D u`, then `P x = T x x x = T x x (D u) = 0`. *The record
supplies `x = D u` for every `x ∈ V_{1/2}` at `n ≥ 9` from criticality of `u` and Lemma L21.* -/
theorem P_zero_of_orbit_tangent_eigenvector {T : E → E → E → ℝ} {D : E → E} {u x : E} {lam : ℝ}
    (hsym : ∀ p q r, T p q r = T q p r)
    (hder : ∀ p q r, T (D p) q r + T p (D q) r + T p q (D r) = 0)
    (hskew : ∀ v w, ⟪D v, w⟫ = -⟪v, D w⟫)
    (hx : ∀ z, T x z u = lam * ⟪x, z⟫)
    (htan : x = D u) :
    T x x x = 0 := by
  have h := invariance_identity_diagonal hsym hder hskew hx
  rw [← htan] at h
  exact h

/-! ## The table's headline constant, as arithmetic -/

/-- **THE CLOSED FORM.** With `θ*² = 3/2`, the `⟨u⟩` component of `Q(W₁)` has norm² exactly `1/6`,
so `√(1 - θ*²/9) = √(5/6)` and the two shares sum to `1`. -/
theorem norm_identity_closed_form :
    ((Real.sqrt (3 / 2) : ℝ) ^ 2 / 9 = 1 / 6) ∧
      ((1 : ℝ) / 6 + 5 / 6 = 1) ∧
      Real.sqrt (1 - (Real.sqrt (3 / 2) : ℝ) ^ 2 / 9) = Real.sqrt (5 / 6) := by
  have hs : (Real.sqrt (3 / 2) : ℝ) ^ 2 = 3 / 2 := Real.sq_sqrt (by norm_num)
  refine ⟨by rw [hs]; norm_num, by norm_num, ?_⟩
  rw [hs]; norm_num

/-- **It is not free**: `‖Q(u)‖ = θ* = √(3/2) > 1`. -/
theorem Qu_norm_exceeds_one : (1 : ℝ) < Real.sqrt (3 / 2) := by
  have h : Real.sqrt 1 < Real.sqrt (3 / 2) := by
    apply Real.sqrt_lt_sqrt (by norm_num) (by norm_num)
  simpa using h

end HamiltonsCubic.L101Statement
