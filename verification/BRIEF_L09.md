# Brief, round L09

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict on this result is included.**

## Passage A, the statement and proof ([findings/graded-half.md](../findings/graded-half.md) lines 264 and 266, under the heading at line 260)

Testing whether a nonzero defect forces instability answers no, and the counterexample is one of the named families. The quaternionic-Kähler operator on $\mathbb{HP}^2$ is a strict local maximum at $n=8$: its second variation is negative on the whole tangent space apart from the directions along its orbit.

**Proof.** $\mathbb{HP}^2=\tau(S^3\times S^5)$ with $\tau$ triality, an orthogonal automorphism of $\mathcal W_8$: it preserves the bracket and the inner product, hence $\#$ and $W^2$, hence $Q$; and it preserves $\mathcal W_8$ because the complement is $1+35_v+35_++35_-$, whose three $35$s it permutes. [Lemma L27](../findings/nondegeneracy.md) at $(p,q)=(3,5)$ gives $\tfrac12-\mu=\tfrac18>0$ and $\dim E(\tfrac12)=15=\dim\mathcal O$, and $\tau$ normalises the inner automorphisms, so orbit tangents correspond and the $\tfrac12$-eigenspace identity transfers. With [Lemma L24](second-order.md)'s Hessian $6\theta(L_e-\tfrac12\mathrm{Id})$ this is strict local maximality transverse to the orbit. $\square$

## Passage B, the canonical statement ([results.md](../results.md) line 140, landscape, and line 485, detail)

- **Lemma L9 (landscape). The high ground has more than one peak.** The quaternionic-Kähler operator on $\mathbb{HP}^2$ is a strict local maximum, so nonzero defect does not force instability: ruling out defective rivals requires sensitivity to the value, not the defect alone.

Testing whether a nonzero defect forces instability answers no, and the counterexample is one of the named families. The quaternionic-Kähler operator on $\mathbb{HP}^2$ is a strict local maximum: its second variation is negative on the whole tangent space apart from the directions along its orbit, at $n=8$. Two consequences. Any argument excluding defective rivals has to be sensitive to the value and not only to the defect, since defectiveness alone permits a genuine peak. And the landscape carries several peaks below the two named ones rather than a single ridge, so eliminating rivals cannot be a stability argument.

## Passage C, Lemma L24, a given ([findings/second-order.md](../findings/second-order.md) lines 61-63, 67 and 69, and [results.md](../results.md) line 320)

**Statement.** Let $W$ be a critical point with $\theta=P(W)>0$, put $e=W/\theta$, and let $L_e=e\circ(\cdot)$ where $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$. The **Riemannian** Hessian of $P$ on the unit sphere of $\mathrm{Weyl}_n$, the restriction of the ambient second differential **plus** the constraint's $-3\theta\,\mathrm{Id}$, the two differing by exactly that, is $6\theta\big(L_e-\tfrac12\mathrm{Id}\big)$. Hence if $W$ is a **local** maximiser,

$$\lambda_{\max}\big(L_e|_{W^\perp}\big)\ \le\ \tfrac12 .$$

**Argument.** $P$ is a cubic form, so $\nabla P=3Q(W)$ and the second differential is $6\,\theta\,L_e$; the constraint $\|W\|^2=1$ contributes $-3\theta\,\mathrm{Id}$ through its multiplier, leaving $6\theta(L_e-\tfrac12\mathrm{Id})$ on the tangent space. Two steps the first version left implicit. **$L_e$ is self-adjoint**, so $\lambda_{\max}$ is defined at all: $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ is fully symmetric, the $W^2$ part as the symmetrisation of $\operatorname{tr}(XYZ)$ and the $\#$ part because permuting the arguments permutes the slots of both totally antisymmetric $c$'s, sign $(-1)^2$ ([r285](../reviews/REVIEW_r285.md) Claim 1). **And $W^\perp$ is $L_e$-invariant**, since $L_ee=e$ by criticality and self-adjointness then carries the complement, so the restriction is a genuine operator rather than a compression, which is [Lemma L125](#lemma-l125-l24-off-wperp-the-same-statement-in-the-form-the-four-set-application-needs) one heading below.

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

## Passage E, the Lean files

[lean/HamiltonsCubic/Results/L9Statement.lean](../lean/HamiltonsCubic/Results/L9Statement.lean) and [lean/HamiltonsCubic/Results/L9.lean](../lean/HamiltonsCubic/Results/L9.lean), read from disk.

## Definitions and sources

- $\mathcal W_n=\mathrm{Weyl}_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$, read as symmetric operators on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, with the Frobenius inner product. $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, a critical point on the unit sphere satisfies $Q(W)=\theta W$ with $\theta=P(W)$, $e=W/\theta$ and $L_e=e\circ(\cdot)$. $\#$ is built from the bracket of $\mathfrak{so}(n)$.
- $\mathbb{HP}^2$ and $S^3\times S^5$ denote the normalised Weyl tensors of those symmetric spaces in $\mathcal W_8$, and $\mathcal O$ an orbit under $O(8)$ acting by conjugation.
- Lemmas L24 and L27 are givens for this round, quoted above.
- **Filed sources on triality**, read at source where a step needs them: [references/yokota-2009-exceptional-lie-groups/](../references/yokota-2009-exceptional-lie-groups/), [references/ziller-2010-lie-groups-symmetric-spaces/](../references/ziller-2010-lie-groups-symmetric-spaces/), [references/holland-ion-2012-symmetric-spaces/](../references/holland-ion-2012-symmetric-spaces/).
- **This loop does no numerical work**; a statement supported only by a run is HYPOTHESIS-DEBT.

## What to attack, beyond the standing list

1. **$\tau$ as an orthogonal automorphism of $\mathcal W_8$**: in what sense triality acts on $\Lambda^2\mathbb R^8$ and on symmetric operators on it, whether it preserves the bracket and the inner product and hence $\#$, $W^2$ and $Q$, and whether "the complement is $1+35_v+35_++35_-$, whose three $35$s it permutes" shows it preserves $\mathcal W_8$, with the dimensions checked.
2. **$\mathbb{HP}^2=\tau(S^3\times S^5)$**: whether the identification is argued or sourced, and in which normalisation.
3. **L27 at $(p,q)=(3,5)$**: the values $\tfrac12-\mu=\tfrac18$ and $\dim E(\tfrac12)=15=\dim\mathcal O$, and whether L27's hypotheses hold there.
4. **"$\tau$ normalises the inner automorphisms, so orbit tangents correspond and the $\tfrac12$-eigenspace identity transfers"**: whether $\tau$ carries the $O(8)$-orbit tangent at $S^3\times S^5$ to the orbit tangent at $\mathbb{HP}^2$, and $L_e$ to $L_{\tau e}$, including the reflections in $O(8)$.
5. **"With Lemma L24's Hessian this is strict local maximality transverse to the orbit"**: what that step needs beyond the Hessian, including the sign of $\theta$ at $\mathbb{HP}^2$, and whether the passages supply it.
6. **Passage A's framing and Passage B's consequences**: "nonzero defect", "defectiveness alone permits a genuine peak", "any argument excluding defective rivals has to be sensitive to the value", and "the landscape carries several peaks below the two named ones rather than a single ridge". Which are argued, and what "defect" and "the two named ones" are in the passages.
7. **Scope**: the landscape entry names no dimension; whether any claim reaches padded $\mathbb{HP}^2$ at $n>8$.
8. **Passage E**: what the Lean files type, what the `sorry` stands for, and whether they state the lemma.
9. The boundary: $SO(8)$ against $O(8)$, and the kernel of $\mathbb{HP}^2$.
