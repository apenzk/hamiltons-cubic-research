# Brief, round L09, the repair

**Cold brief. The repaired statement and proof are quoted verbatim with their source lines, and the results they rest on are stated as givens. No prior verdict is included.**

## Passage A, the statement and proof under audit ([findings/graded-half.md](../findings/graded-half.md) lines 264 and 266)

**Statement.** At $n=8$, let $W_{3,5}$ be the unit Weyl tensor of $S^3\times S^5$ with $P(W_{3,5})>0$, and let $\tau$ be a triality automorphism of $\mathfrak{so}(8)=\Lambda^2\mathbb R^8$, acting on $\mathcal W_8$ by conjugation. Then $\tau W_{3,5}$ is a strict local maximum of $P$ on the unit sphere of $\mathcal W_8$ transverse to its $O(8)$-orbit, at $\theta^2=\tfrac{56}{45}$. The balanced product $W^*$ is one too, at $\theta_0(8)^2=\tfrac{21}{16}$ ([Lemma L3](second-order.md)). **So the high ground at $n=8$ has at least two peaks**, in distinct orbits, since $P$ is $O(8)$-invariant and the two values differ. *The record identifies $\tau W_{3,5}$ with the quaternionic-Kähler Weyl tensor of $\mathbb{HP}^2$, the two sharing $\theta^2=\tfrac{56}{45}$. That identification, with its sign, is owed.*

**Proof.** $\tau$ is an orthogonal automorphism of $\mathfrak{so}(8)$: it preserves the bracket and the inner product, hence $\#$ and $W^2$, hence $Q$ and $P$. It preserves $\mathcal W_8$. Triality permutes the three eight-dimensional representations $8_v,8_s,8_c$, hence the three summands $35_x=S^2_0(8_x)$ in $\mathrm{Sym}^2(\Lambda^2\mathbb R^8)=\mathcal W_8\oplus\mathbf 1\oplus35_v\oplus35_s\oplus35_c$, $\dim\mathcal W_8=300$, and it fixes the trivial summand; being orthogonal, it preserves the complement of their sum. So $\tau W_{3,5}$ is a unit critical point of $P$ with $\theta=P(W_{3,5})=\theta_{3,5}=\sqrt2\sqrt{\tfrac23\cdot\tfrac45\cdot\tfrac76}=\sqrt{56/45}>0$ by [Nienhaus, Proposition 2.25](../references/nienhaus-2023-second-best-einstein/notes.md). [Lemma L27](nondegeneracy.md) at $(p,q)=(3,5)$ gives $\tfrac12-\mu=\tfrac18>0$ and $\dim E(\tfrac12)=15=\dim\mathcal O$. Conjugation by $\tau$ carries $L_e$ to $L_{\tau e}$, and the orbit tangent $[\mathrm{ad}_X,W]$ to $[\mathrm{ad}_{\tau X},\tau W]$ because $\tau\,\mathrm{ad}_X\tau^{-1}=\mathrm{ad}_{\tau X}$, so by [Lemma L24](second-order.md) the Hessian at $\tau W_{3,5}$ is negative definite transverse to its orbit and zero along it. The step from that Hessian to a strict transverse local maximum in [Lemma L3](second-order.md)'s proof uses only criticality, $\theta>0$, $O(8)$-invariance and that Hessian, so it applies unchanged. $\square$

## Passage B, Lemma L3, a given ([findings/second-order.md](../findings/second-order.md) lines 37 and 47)

**Statement.** For every **even $n\ge8$**, the unit Weyl tensor $W^*$ of $S^{n/2}\times S^{n/2}$ with $P(W^*)>0$ is a local maximum of $P$ on the unit sphere $\Sigma$ of $\mathcal W_n$, not merely within $\mathcal D_n$, and strictly so transverse to its $O(n)$-orbit $\mathcal O$: some neighbourhood $U$ of $\mathcal O$ in $\Sigma$ has $P<P(W^*)$ on $U\setminus\mathcal O$. The Hessian transverse to $\mathcal O$ is at most $-6\theta/(n-2)$, and the bound is attained.

*From the Hessian to a local maximum.* $\mathcal O$ is a compact submanifold of $\Sigma$, and $P\equiv\theta$ on it by invariance. By the tubular neighbourhood theorem there is $\rho>0$ such that $(x,v)\mapsto\exp_x v$, over $x\in\mathcal O$ and $v$ normal to $\mathcal O$ at $x$ with $\lvert v\rvert<\rho$, is a diffeomorphism onto a neighbourhood of $\mathcal O$. Put $f(v)=P(\exp_{W^*}v)$ for $v\in N$ with $\lvert v\rvert<\rho$. Then $f(0)=\theta$, $df(0)=0$ by criticality, and $d^2f(0)$ is the Hessian on $N$, so Taylor's theorem with a bound $K$ on the third derivative over the closed ball of radius $\rho/2$ gives

## Passage C, Lemma L24, a given ([findings/second-order.md](../findings/second-order.md) lines 61-63, 67 and 69, and [results.md](../results.md) line 320)

**Statement.** Let $W$ be a critical point with $\theta=P(W)>0$, put $e=W/\theta$, and let $L_e=e\circ(\cdot)$ where $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$. The **Riemannian** Hessian of $P$ on the unit sphere of $\mathrm{Weyl}_n$, the restriction of the ambient second differential **plus** the constraint's $-3\theta\,\mathrm{Id}$, the two differing by exactly that, is $6\theta\big(L_e-\tfrac12\mathrm{Id}\big)$. Hence if $W$ is a **local** maximiser,

$$\lambda_{\max}\big(L_e|_{W^\perp}\big)\ \le\ \tfrac12 .$$

**Argument.** $P$ is a cubic form, so $\nabla P=3Q(W)$ and the second differential is $6\,\theta\,L_e$; the constraint $\|W\|^2=1$ contributes $-3\theta\,\mathrm{Id}$ through its multiplier, leaving $6\theta(L_e-\tfrac12\mathrm{Id})$ on the tangent space. Two steps the first version left implicit. **$L_e$ is self-adjoint**, so $\lambda_{\max}$ is defined at all: $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ is fully symmetric, the $W^2$ part as the symmetrisation of $\mathop{\mathrm{tr}}(XYZ)$ and the $\#$ part because permuting the arguments permutes the slots of both totally antisymmetric $c$'s, sign $(-1)^2$ ([r285](../reviews/REVIEW_r285.md) Claim 1). **And $W^\perp$ is $L_e$-invariant**, since $L_ee=e$ by criticality and self-adjointness then carries the complement, so the restriction is a genuine operator rather than a compression, which is [Lemma L125](#lemma-l125-l24-off-wperp-the-same-statement-in-the-form-the-four-set-application-needs) one heading below.

**Sharpness rests on the orbit directions alone.** $e$ is idempotent, $e\circ e=Q(e)=Q(W)/\theta^2=e$, and the orbit directions are exact $\tfrac12$-eigenvectors by equivariance, attained at every nonzero critical point because $\mathcal W_n$ carries no $O(n)$-invariant vector, so the orbit is never a point. *Sharpness needs nothing beyond that*: the equivariance identity $2L_W\delta_vW=\theta\,\delta_vW$ with $\delta_vW\perp W$ puts an exact $\tfrac12$-eigenvector in $W^\perp$ at every such point. $\square$

- **Lemma L24 (second-order). Second-order optimality bounds the multiplication operator.** A **local** maximiser with $\theta\ne0$ has $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$, with $\tfrac12$ attained by orbit directions at every critical point where $e$ is defined. This is Krasnov–Tkachev's Proposition 6.6, derived here independently before the literature was found; the credit is theirs.

## Passage D, Lemma L27, a given ([findings/nondegeneracy.md](../findings/nondegeneracy.md) lines 496-498 and 511-518, and [results.md](../results.md) line 154)

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

## Passage E, the filed source for $\theta>0$ ([references/nienhaus-2023-second-best-einstein/notes.md](../references/nienhaus-2023-second-best-einstein/notes.md) lines 19-23)

### Proposition 2.25 (L1483)

> "The Weyl curvature of $S_{k,l}$ satisfies $W_{S_{k,l}}^2+W_{S_{k,l}}^\#=\theta_{k,l}\cdot W_{S_{k,l}}$, where
> $$\theta_{k,l}=\sqrt2\sqrt{\frac{k-1}{k}\cdot\frac{l-1}{l}\cdot\frac{n-1}{n-2}}.$$
> Moreover, $P(W_{S_{k,l}})=\theta_{k,l}$."

## Definitions and sources

- $\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$, read as symmetric operators on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ with the Frobenius inner product. $Q(W)=W^2+W^\#$ with $\#$ built from the bracket, $P(W)=\langle W,Q(W)\rangle$, a critical point on the unit sphere has $Q(W)=\theta W$, $e=W/\theta$, $L_e=e\circ(\cdot)$. $O(8)$ acts by conjugation.
- Lemmas L3, L24 and L27 and Nienhaus's Proposition 2.25 are givens. Triality on $\mathfrak{so}(8)$ and the decomposition of $\mathrm{Sym}^2(\Lambda^2\mathbb R^8)$ are classical; filed sources on triality: [references/yokota-2009-exceptional-lie-groups/](../references/yokota-2009-exceptional-lie-groups/), [references/ziller-2010-lie-groups-symmetric-spaces/](../references/ziller-2010-lie-groups-symmetric-spaces/).
- **This loop does no numerical work.**

## What to attack

1. **$\tau$ preserves $\mathcal W_8$**: the decomposition $\mathrm{Sym}^2(\Lambda^2\mathbb R^8)=\mathcal W_8\oplus\mathbf 1\oplus35_v\oplus35_s\oplus35_c$, the identification $35_x=S^2_0(8_x)$, triality permuting $8_v,8_s,8_c$, and the step from preserving the complement to preserving $\mathcal W_8$.
2. **Criticality and $\theta$**: that $\tau W_{3,5}$ is a unit critical point and $P(\tau W_{3,5})=\theta_{3,5}=\sqrt{56/45}>0$, the arithmetic included.
3. **The transfer**: L27 at $(3,5)$, $\tau$ carrying $L_e$ to $L_{\tau e}$ and orbit tangents to orbit tangents, and the conclusion about the Hessian at $\tau W_{3,5}$.
4. **L3's step applying unchanged**: whether that argument uses anything specific to $W^*$ beyond criticality, $\theta>0$, invariance and the transverse Hessian.
5. **"At least two peaks, in distinct orbits"**: whether the two values $\tfrac{56}{45}$ and $\tfrac{21}{16}$ and $O(8)$-invariance of $P$ give distinct orbits, and whether both points are strict transverse local maxima.
6. **The statement's scope**, and whether the owed identification with $\mathbb{HP}^2$ is stated as a debt rather than used.
