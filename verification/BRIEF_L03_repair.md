# Brief, round L03, the repair

**Cold brief. The repaired statement and proof are quoted verbatim from the record with their source lines, and the results they rest on are stated as givens. No prior verdict is included.**

## Passage A, the statement and proof under audit ([findings/second-order.md](../findings/second-order.md) lines 37-53)

**Statement.** For every **even $n\ge8$**, the unit Weyl tensor $W^*$ of $S^{n/2}\times S^{n/2}$ with $P(W^*)>0$ is a local maximum of $P$ on the unit sphere $\Sigma$ of $\mathcal W_n$, not merely within $\mathcal D_n$, and strictly so transverse to its $O(n)$-orbit $\mathcal O$: some neighbourhood $U$ of $\mathcal O$ in $\Sigma$ has $P<P(W^*)$ on $U\setminus\mathcal O$. The Hessian transverse to $\mathcal O$ is at most $-6\theta/(n-2)$, and the bound is attained.

**Proof.** Write $m=n/2\ge4$ and $\theta=P(W^*)$.

*Criticality and sign.* $W^*$ is critical with $\theta=\theta_{m,m}=\sqrt2\,\frac{m-1}m\sqrt{\frac{n-1}{n-2}}>0$ by [Nienhaus, Proposition 2.25](../references/nienhaus-2023-second-best-einstein/notes.md). The sign is what selects $W^*$ over $-W^*$: $P$ is odd and $e=W/\theta$ is unchanged under $W\mapsto-W$, so the Hessian below changes sign with $\theta$.

*The Hessian.* By [Lemma L24](#lemma-l24-second-order-optimality-as-an-eigenvalue-bound-the-canonical-statement) the Riemannian Hessian at $W^*$ is $6\theta(L_e-\tfrac12\mathrm{Id})$ on $T_{W^*}\Sigma=W^{*\perp}$. [Lemma L27](nondegeneracy.md) at $p=q=m$ gives the values of $L_e$ on $W^{*\perp}$: $\tfrac12$ on the orbit tangent $\mathbb R^m\otimes\mathbb R^m$ and nowhere else, $\lambda_m=\frac{m-2}{2(m-1)}$ on $S^2_0(\mathbb R^m)$ for each factor, $\mu$ on $\Lambda^2\otimes\Lambda^2$ and $-\mu$ on $S^2_0\otimes S^2_0$ with $\tfrac12-\mu=\frac{(m-2)^2-1}{2(m-1)^2}$, so $\mu=\frac1{m-1}$, and $0$ on the remaining four summands. Off the orbit tangent the largest value is $\lambda_m$, since $\lambda_m-\mu=\frac{m-4}{2(m-1)}\ge0$, with a tie at $m=4$. So the Hessian vanishes on $T_{W^*}\mathcal O$, and on its orthogonal complement $N$ in $T_{W^*}\Sigma$
$$\mathrm{Hess}\,P\ \le\ 6\theta\big(\lambda_m-\tfrac12\big)=-\frac{3\theta}{m-1}=-\frac{6\theta}{n-2},$$
with equality on $S^2_0(\mathbb R^m)$.

*From the Hessian to a local maximum.* $\mathcal O$ is a compact submanifold of $\Sigma$, and $P\equiv\theta$ on it by invariance. By the tubular neighbourhood theorem there is $\rho>0$ such that $(x,v)\mapsto\exp_x v$, over $x\in\mathcal O$ and $v$ normal to $\mathcal O$ at $x$ with $\lvert v\rvert<\rho$, is a diffeomorphism onto a neighbourhood of $\mathcal O$. Put $f(v)=P(\exp_{W^*}v)$ for $v\in N$ with $\lvert v\rvert<\rho$. Then $f(0)=\theta$, $df(0)=0$ by criticality, and $d^2f(0)$ is the Hessian on $N$, so Taylor's theorem with a bound $K$ on the third derivative over the closed ball of radius $\rho/2$ gives
$$f(v)\ \le\ \theta-\frac{3\theta}{n-2}\lvert v\rvert^2+K\lvert v\rvert^3 .$$
Each $g\in O(n)$ is an isometry of $\Sigma$ fixing $P$, so $P(\exp_{gW^*}(gv))=P(g\exp_{W^*}v)=f(v)$ and the normal space at $gW^*$ is $gN$: the same bound holds at every point of $\mathcal O$ with the same $K$. For $0<\lvert v\rvert<\rho'=\min\big(\rho/2,\,3\theta/((n-2)K)\big)$ the right side is below $\theta$. So $U=\{\exp_xv:x\in\mathcal O,\ v\perp T_x\mathcal O,\ \lvert v\rvert<\rho'\}$ is a neighbourhood of $\mathcal O$ with $P<\theta$ on $U\setminus\mathcal O$. $\square$

**At $n=6$ the argument stops.** $W^*$ is then $S^3\times S^3$, the pair $(3,3)$ that Lemma L27 excludes: $\mu=\tfrac12$ and $\dim E(\tfrac12)=18$ against an orbit of $9$, leaving nine Hessian null directions transverse to the orbit, so the second-order test decides nothing there. Whether $P$ rises along them is a third-order question, turning on whether $P$ is nonzero on that null space.

So at $n\ge12$ the balanced product is a strict local maximum transverse to its orbit, and what remains open is whether it is the global one.

## Passage B, Lemma L24, a given ([findings/second-order.md](../findings/second-order.md) lines 57-59, 63 and 65, and [results.md](../results.md) line 320)

**Statement.** Let $W$ be a critical point with $\theta=P(W)>0$, put $e=W/\theta$, and let $L_e=e\circ(\cdot)$ where $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$. The **Riemannian** Hessian of $P$ on the unit sphere of $\mathrm{Weyl}_n$, the restriction of the ambient second differential **plus** the constraint's $-3\theta\,\mathrm{Id}$, the two differing by exactly that, is $6\theta\big(L_e-\tfrac12\mathrm{Id}\big)$. Hence if $W$ is a **local** maximiser,

$$\lambda_{\max}\big(L_e|_{W^\perp}\big)\ \le\ \tfrac12 .$$

**Argument.** $P$ is a cubic form, so $\nabla P=3Q(W)$ and the second differential is $6\,\theta\,L_e$; the constraint $\|W\|^2=1$ contributes $-3\theta\,\mathrm{Id}$ through its multiplier, leaving $6\theta(L_e-\tfrac12\mathrm{Id})$ on the tangent space. Two steps the first version left implicit. **$L_e$ is self-adjoint**, so $\lambda_{\max}$ is defined at all: $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ is fully symmetric, the $W^2$ part as the symmetrisation of $\operatorname{tr}(XYZ)$ and the $\#$ part because permuting the arguments permutes the slots of both totally antisymmetric $c$'s, sign $(-1)^2$ ([r285](../reviews/REVIEW_r285.md) Claim 1). **And $W^\perp$ is $L_e$-invariant**, since $L_ee=e$ by criticality and self-adjointness then carries the complement, so the restriction is a genuine operator rather than a compression, which is [Lemma L125](#lemma-l125-l24-off-wperp-the-same-statement-in-the-form-the-four-set-application-needs) one heading below.

**Sharpness rests on the orbit directions alone.** $e$ is idempotent, $e\circ e=Q(e)=Q(W)/\theta^2=e$, and the orbit directions are exact $\tfrac12$-eigenvectors by equivariance, attained at every nonzero critical point because $\mathcal W_n$ carries no $O(n)$-invariant vector, so the orbit is never a point. *Sharpness needs nothing beyond that*: the equivariance identity $2L_W\delta_vW=\theta\,\delta_vW$ with $\delta_vW\perp W$ puts an exact $\tfrac12$-eigenvector in $W^\perp$ at every such point. $\square$

- **Lemma L24 (second-order). Second-order optimality bounds the multiplication operator.** A **local** maximiser with $\theta\ne0$ has $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$, with $\tfrac12$ attained by orbit directions at every critical point where $e$ is defined. This is Krasnov–Tkachev's Proposition 6.6, derived here independently before the literature was found; the credit is theirs.

## Passage C, Lemma L27, a given ([findings/nondegeneracy.md](../findings/nondegeneracy.md) lines 496-498 and 511-518, and [results.md](../results.md) line 154)

**Statement.** Let $p,q\ge3$ with $(p,q)\ne(3,3)$ and $n=p+q$. **The two exclusions fail differently**: at $(3,3)$ the decomposition holds and two scalars collide, $\mu=\tfrac12$ giving $\dim E(\tfrac12)=18$ against an orbit of $9$, forced by the object; at $q\le2$ **the decomposition itself is false**, the ten dimensions over-counting by $2$ at $q=2$ and by $1+p$ at $q=1$, at every $n$. *So the bottom-end criterion is $p,q\ge3$, not a bound on $n$.* Then $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ at
$W_{p,q}$, attained exactly on the orbit tangent, so $\dim E(\tfrac12)=pq=\dim(\text{orbit})$ and $S^p\times S^q$
is Morse–Bott nondegenerate.

change a representation's type.* The ten values: $1$ on $\langle W\rangle$; $\tfrac12$ on
$\mathbb R^p\otimes\mathbb R^q$, since differentiating $Q(W_t)=\theta W_t$ along the orbit gives
$e\circ\dot W=\tfrac12\dot W$; $\lambda_m=(m-2)/(2(m-1))<\tfrac12$ on $S^2_0(\mathbb R^m)$, derived at [second-order.md](second-order.md);
$+\mu$ on $\Lambda^2\otimes\Lambda^2$ by [Lemma L26](#lemma-l26-the-dangerous-eigenvalue-of-the-two-block-spectrum-in-closed-form-canonical-statement-and-proof),
**and $-\mu$ on $S^2_0\otimes S^2_0$ by the trace identity below**, L26 supplying only the first of the two;
and $0$ on the remaining four. Then
$$\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}>0\quad\text{for }p,q\ge3,\ (p,q)\ne(3,3),$$
so $\tfrac12$ is attained on the orbit summand alone. $\square$

- **Lemma L27 (landscape). Sphere products $S^p\times S^q$ with $p,q\ge3$, $(p,q)\ne(3,3)$, $n=p+q$, are Morse–Bott nondegenerate.** Each of the ten summands is $O(p)\times O(q)$-irreducible and their Young labels are distinct, so the decomposition is multiplicity-free and $L_e$ is scalar on each, each value an eigenvalue, not a lower bound. **The maximum $\tfrac12$ is over $W^\perp$**, $\langle W\rangle$ carrying $1$. *$n=p+q$ is part of the statement: padding destroys nondegeneracy.* For $p,q\ge3$ other than $(3,3)$, $\lambda_{\max}=\tfrac12$ on the orbit alone.

## Passage D, the filed source for $\theta>0$ ([references/nienhaus-2023-second-best-einstein/notes.md](../references/nienhaus-2023-second-best-einstein/notes.md) lines 19-23)

### Proposition 2.25 (L1483)

> "The Weyl curvature of $S_{k,l}$ satisfies $W_{S_{k,l}}^2+W_{S_{k,l}}^\#=\theta_{k,l}\cdot W_{S_{k,l}}$, where
> $$\theta_{k,l}=\sqrt2\sqrt{\frac{k-1}{k}\cdot\frac{l-1}{l}\cdot\frac{n-1}{n-2}}.$$
> Moreover, $P(W_{S_{k,l}})=\theta_{k,l}$."

## Definitions and sources

- $\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$ with the Frobenius inner product, $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, and a critical point on the unit sphere satisfies $Q(W)=\theta W$ with $\theta=P(W)$. $\mathcal D_n$ is the coordinate-diagonal part. $O(n)$ acts orthogonally and $P$ is invariant.
- Lemmas L24 and L27 and Nienhaus's Proposition 2.25 are givens. The tubular neighbourhood theorem and Taylor's theorem are standard.
- **This loop does no numerical work.**

## What to attack

1. **Criticality and sign**: whether Proposition 2.25 at $k=l=m$ gives the displayed $\theta_{m,m}$, and whether the sign argument ($P$ odd, $e$ unchanged under $W\mapsto-W$) is right.
2. **The Hessian paragraph**: every value quoted from L27 at $p=q=m$, the derivation $\mu=\frac1{m-1}$, the comparison $\lambda_m-\mu=\frac{m-4}{2(m-1)}$, the claim that $\tfrac12$ occurs on the orbit tangent and nowhere else in $W^{*\perp}$, the constant $-6\theta/(n-2)$ and its attainment.
3. **From the Hessian to a local maximum**, link by link: the tubular neighbourhood, $d^2f(0)$ as the Hessian on $N$, the Taylor bound with $K$ on the closed ball of radius $\rho/2$, the transport of the bound along the orbit by $g\in O(n)$, the choice of $\rho'$, and whether $U$ is a neighbourhood of $\mathcal O$ on which $P<\theta$ off $\mathcal O$.
4. **Whether the statement's "neighbourhood $U$ of $\mathcal O$ with $P<P(W^*)$ on $U\setminus\mathcal O$" is what the proof reaches**, and whether it gives local maximality at $W^*$.
5. **The $n=6$ paragraph and the last line**, as statements of scope.
6. The boundary: $n=8$, the tie, and the normal directions on which the Hessian bound is attained.
