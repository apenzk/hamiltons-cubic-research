# Brief, round L101

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict on this result is included.**

## Passage A, the heading and the lemma as the block carries it ([findings/route-a.md](../findings/route-a.md) lines 423 and 441-449)

#### Lemma L101, the $SO(n)$-invariance identity, and $P\equiv0$ on $V_{1/2}$, $T(x,y,[\rho(A),u])=(\lambda-\mu)\theta^*\langle A\!\cdot\!x,y\rangle$, giving $Q(x)\perp T_u(SO(n).u)$ for every eigenvector in every dimension

**A fifth, separate statement is proven, though it does not tighten the bound.** The trilinear form $T$ is $SO(n)$-invariant, so differentiating along $\exp(tA)$ gives $T(A\!\cdot\!x,y,z)+T(x,A\!\cdot\!y,z)+T(x,y,A\!\cdot\!z)=0$. Setting $y=x$, $z=u$ and using $A\!\cdot\!u=[A,u]$,

$$T(x,x,[A,u])=-2\,T(A\!\cdot\!x,x,u)=-2\lambda\,\langle A\!\cdot\!x,x\rangle=0,$$

since $F_u$ is symmetric with $F_ux=\lambda x$ and the derivation $X\mapsto[\rho(A),X]$ is Frobenius-skew. So $Q(x)\perp T_u(SO(n).u)$ for every eigenvector $x$ of $F_u$, in every dimension, with no hypothesis, and the argument never uses criticality of $u$. The general form is exact:

$$T(x,y,[\rho(A),u])=(\lambda-\mu)\,\theta^*\langle A\!\cdot\!x,y\rangle\qquad (x\in V_\lambda,\;y\in V_\mu),$$

vanishing on the diagonal and reaching $0.91$ off it. It also gives $P\equiv0$ on $V_{1/2}$.

## Passage B, the record's definitions ([findings/conventions.md](../findings/conventions.md) lines 24, 64 and 136)

| $T$, third sense | **the fully symmetric trilinear form $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ on $\mathcal W_n$**, whose symmetry is what makes $L_e$ self-adjoint and hence [L24](../findings/second-order.md)'s $\lambda_{\max}$ well defined at all, the $W^2$ part as the symmetrisation of $\operatorname{tr}(XYZ)$, the $\#$ part because permuting the arguments permutes the slots of two totally antisymmetric $c$'s at sign $(-1)^2$. **It was tabled nowhere while the letter already carried the bracket tensor $T_{\alpha\beta\gamma}$ and [L35](../findings/stratum-two-negative.md)'s cap $\tfrac{2\sqrt2}3A$** | [second-order.md](../findings/second-order.md) |

- **The competitor's operator and its blocks**: $u=W_{\mathbb{CP}^2}$ padded to unit norm, $\theta^*=P(u)=\sqrt{3/2}$, $F_u(h)=\tfrac12(uh+hu)+u\#h$, and $F_\lambda$ its restriction to the multiplicity space $M_\lambda$ of the $SO(n-4)$-isotypic $M_\lambda\otimes V_\lambda$. **$\alpha$ in [L21](../findings/route-a.md) and [L20](../findings/route-a.md) is $\sqrt{2/3}\langle F_uV,V\rangle$**, a Rayleigh quotient transverse to $\mathbb Ru$ and the orbit, *not the $\alpha$ parametrising the competitor family $W_{\mathcal S^4(\alpha)}$ in the same file.*

- **The $\circ$ product**: $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, with $e=W/\theta$ and $L_e=e\circ(\cdot)$. The whole second-order apparatus rests on it.

## Passage C, the eigenspaces of $F_u$ in the section the lemma sits in ([findings/route-a.md](../findings/route-a.md) lines 404, 406 and 408)

**The subdivision is exact, and it is a theorem.** In Remark 4.18's decomposition $W=\cos\beta\,W_1+\sin\beta\,W_2$, the admissible space splits as $(\mathbb Ru\oplus T_u\mathcal O)^\perp=V_{1/3}\oplus V_{\le0}$ with nothing else possible, $\mathrm{mult}(+1)=1$ and $\mathrm{mult}(+\tfrac12)=\dim\mathcal O$ ($26,34,42,50$ at $n=10,12,14,16$), which follows from Theorem 4.14(a),(b) with Remark 4.16 rather than being a numerical coincidence. Writing $W_2=c_0K+c_-N$ with $K\in\ker F_u$ and $N$ in the strictly negative part, and $\mu_N=\langle FN,N\rangle/\theta^*\in[-1,-\tfrac16]$, the identity

$$\alpha=\tfrac{1-s^2}{3}+s^2c_-^2\mu_N,\qquad s=\sin\beta,$$

is exact: the cross term vanishes because $F_uW_1=\tfrac13\theta^*W_1$ and $W_1\perp W_2$. Hence $s^2\le6\varepsilon/(3-c_0^2)$ with $\varepsilon=\tfrac13-\alpha$.

## Passage D, Lemma L21's statement, a given for the eigenvalues of $F_u$ transverse to the orbit ([findings/route-a.md](../findings/route-a.md) line 174)

**Statement.** Let $n\ge9$, $m=n-4$, and let $u=W_{\mathbb{CP}^2}$ padded to $\mathcal W_n$, of unit norm with $\theta^*=P(u)=\sqrt{3/2}$. Write $F_u(h)=\tfrac12(uh+hu)+u\#h$ and $\alpha=\sqrt{2/3}\,\langle F_uV,V\rangle$ for a unit $V\in u^\perp\cap T_u(SO(n).u)^\perp$. Then $\alpha\le\tfrac13$, and $\tfrac13$ is attained.

## Passage E, the Lean statements ([lean/HamiltonsCubic/Results/L101Statement.lean](../lean/HamiltonsCubic/Results/L101Statement.lean) lines 92-153, declarations and proofs; the file's module docstring is withheld)

```lean
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

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
```

## Definitions and sources

- $\mathcal W_n=\mathrm{Weyl}_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$, read as symmetric operators on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, with the Frobenius inner product. $Q(W)=W^2+W^\#$ and $P(W)=\langle W,Q(W)\rangle$. $SO(n)$ acts on $\mathcal W_n$ by conjugation through its action $\rho$ on $\Lambda^2\mathbb R^n$.
- $V_\lambda$ denotes an eigenspace of $F_u$ on $\mathcal W_n$, and $T_u(SO(n).u)$ the tangent space to the orbit of $u$.
- Lemma L21 is a given, as quoted. [Nienhaus's notes](../references/nienhaus-2023-second-best-einstein/notes.md) may be read at source where a step needs Theorem 4.14 or Remark 4.16.
- The lemma has **no entry in [results.md](../results.md)**.
- **This loop does no numerical work**; a statement supported only by a run is HYPOTHESIS-DEBT.

## What to attack, beyond the standing list

1. **The three-term identity** $T(A\cdot x,y,z)+T(x,A\cdot y,z)+T(x,y,A\cdot z)=0$: what invariance of $T$ it uses, which action "$A\cdot$" denotes on $\mathcal W_n$, and which symmetries of $T$ it needs.
2. **"$A\cdot u=[A,u]$" against "$[\rho(A),u]$"**: whether both are well typed for $u\in\mathcal W_n$.
3. **The diagonal chain** $T(x,x,[A,u])=-2T(A\cdot x,x,u)=-2\lambda\langle A\cdot x,x\rangle=0$, equality by equality, including which symmetry of $T$ each uses and in which normalisation $\lambda$ is read.
4. **"$Q(x)\perp T_u(SO(n).u)$ for every eigenvector $x$ of $F_u$, in every dimension, with no hypothesis, and the argument never uses criticality of $u$"**: what the argument actually uses, and whether the conclusion holds more generally or less generally than stated.
5. **The general form** $T(x,y,[\rho(A),u])=(\lambda-\mu)\theta^*\langle A\cdot x,y\rangle$: derive it from the three-term identity, and compare its normalisation of $\lambda,\mu$ with Passage A's "$F_ux=\lambda x$" and Passage C's "$F_uW_1=\tfrac13\theta^*W_1$".
6. **"Vanishing on the diagonal and reaching $0.91$ off it"**: what supports the value.
7. **"It also gives $P\equiv0$ on $V_{1/2}$"**: whether it follows from the identity, and what further hypotheses on $u$ and on $V_{1/2}$ against $T_u(SO(n).u)$ it needs, at which $n$.
8. **The heading against the body**: "for every eigenvector in every dimension", and whether the heading states the lemma the body proves.
9. **Passage E against Passages A and B**: whether the Lean statements are the record's claims, their binders and hypotheses (in particular `D` and `hsym`), the normalisation of `lam`, and which claims of Passage A are not typed.
10. **The boundary**: padded $u$ with $\ker u\ne0$, small $n$ and odd $n$, and $\lambda=\mu$ with $x\ne y$.
