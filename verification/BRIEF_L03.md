# Brief, round L03

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict on this result is included.**

## Passage A, the statement and proof ([findings/second-order.md](../findings/second-order.md) lines 31-35 and 41, and line 49)

#### Lemma L3, the balanced product is a local maximum in $\mathcal W_n$ at every even $n\ge8$, canonical statement and proof

Needed because the known diagonal-case proof cannot see whether $W^*$'s criticality survives against perturbations that leave the diagonal locus.

**Statement.** For every **even $n\ge8$**, $W^*=S^{n/2}\times S^{n/2}$ is a local maximum of $P$ on the unit sphere of $\mathcal W_n$, not merely within $\mathcal D_n$, and strictly so transverse to its $O(n)$-orbit, with transverse Hessian $\le-6\theta/(n-2)$.

**Proof.** [Lemma L24](#lemma-l24-second-order-optimality-as-an-eigenvalue-bound-the-canonical-statement) gives $\mathrm{Hess}_SP=6\theta(L_e-\tfrac12\mathrm{Id})$ on the tangent space, this being the Riemannian Hessian, the constraint's $-3\theta\,\mathrm{Id}$ being what produces the $\tfrac12$. [Lemma L27](nondegeneracy.md) gives $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$ **attained exactly on the orbit tangent** for every $p,q\ge3$ with $(p,q)\ne(3,3)$, so at $p=q=n/2\ge4$ the Hessian is negative definite transverse to the orbit and zero along it. $\square$

So $n\ge12$ is about which of two local maxima wins globally, not about $W^*$ losing local maximality.

## Passage B, the canonical statement ([results.md](../results.md) line 114, landscape, and line 404, detail)

- **Lemma L3 (landscape). The balanced product is a local maximum in $\mathcal W_n$, at every even $n\ge8$.** Not merely within $\mathcal D_n$, and strictly so transverse to its orbit, by Lemmas L24 and L27. **At $n=6$ the statement is false**, that is L27's excluded $(3,3)$, where nine Hessian null directions transverse to the orbit carry $P$ upward at cubic order. *The Schur mechanism that derives the analogous statement at the $\mathbb{CP}^2$-type competitor is what derives this one.*

For every even $n\ge8$, $W^*=S^{n/2}\times S^{n/2}$ is a local maximum of $P$ on the unit sphere of $\mathcal W_n$ (not merely within $\mathcal D_n$), strictly so transverse to its $O(n)$-orbit. **At $n=6$ it is false**, that being the case Lemma L27 excludes. So $n\geq12$ is about which of two local maxima wins globally, not about $W^*$ losing local maximality.

## Passage C, Lemma L24, a given ([findings/second-order.md](../findings/second-order.md) lines 57-59, 63 and 65, and [results.md](../results.md) line 320)

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

## Passage E, the Lean file

[lean/HamiltonsCubic/Results/L3.lean](../lean/HamiltonsCubic/Results/L3.lean), read in full from disk.

## Definitions and sources

- $\mathcal W_n=\mathrm{Weyl}_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$ with the Frobenius inner product, $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, and a critical point on the unit sphere satisfies $Q(W)=\theta W$ with $\theta=P(W)$. $\mathcal D_n$ is the coordinate-diagonal part of $\mathcal W_n$. $W^*$, written $S^{n/2}\times S^{n/2}$, is the normalised Weyl tensor of that product, and $W_{p,q}$ that of $S^p\times S^q$.
- $O(n)$ acts on $\mathcal W_n$ orthogonally and $P$ is $O(n)$-invariant.
- Lemmas L24 and L27 are givens for this round, quoted above.
- **This loop does no numerical work**; a statement supported only by a run is HYPOTHESIS-DEBT.

## What to attack, beyond the standing list

1. **Second-order sufficiency modulo an orbit**: whether a Riemannian Hessian negative definite transverse to the $O(n)$-orbit and zero along it gives a local maximum of $P$ on the unit sphere, and whether the proof argues this or asserts it.
2. **L24's hypotheses at $W^*$**: that $W^*$ is a critical point with $\theta>0$, and where that is established.
3. **L27's hypotheses at $W^*$**: $p=q=n/2$, $p,q\ge3$, $(p,q)\ne(3,3)$, $n=p+q$, and the conclusion "attained exactly on the orbit tangent" as used.
4. **The constant** "transverse Hessian $\le-6\theta/(n-2)$": whether it follows from the ten values of Passage D at $p=q=n/2$, including the tie between candidate gaps, and whether it is written.
5. **"Not merely within $\mathcal D_n$"**: what the proof establishes about directions outside $\mathcal D_n$.
6. **$n=6$**: Passage B's "nine Hessian null directions transverse to the orbit carry $P$ upward at cubic order". Whether that is argued in the passages, and whether the lemma uses it.
7. **Passage A's last line and Passage B's detail**: "$n\ge12$ is about which of two local maxima wins globally", which names a second local maximum.
8. **Passage B's landscape remark**: "The Schur mechanism that derives the analogous statement at the $\mathbb{CP}^2$-type competitor is what derives this one."
9. **Passage E**: what the Lean file types, and whether it states the lemma.
10. The boundary: $n=8$, odd $n$, and a padded object near $W^*$.
