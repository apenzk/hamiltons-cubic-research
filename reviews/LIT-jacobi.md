# LIT-jacobi, the literature on what Jacobi and first Bianchi force on the SQUARES

**Item:** [T6](../plan.md), opened with no literature search. **Run:** 2026-09-01. **Log:** [lit-jacobi.log](../agent_logs/lit-jacobi.log). **Sources filed:** [payne-2010-soliton-metrics](../references/payne-2010-soliton-metrics/), [conti-rossi-2019-nice-nilpotent](../references/conti-rossi-2019-nice-nilpotent/), [mehta-normand-gupta-1983-contracted-products](../references/mehta-normand-gupta-1983-contracted-products/).

## Verdict

**The literature has asked this exact question, in one corner of it, and its answer agrees with [Reviewer 331](REVIEW_r331.md): the geometric conditions built from brackets are linear in the squares, and the Jacobi identity is not a condition on the squares at all.** T6's named risk ("a consequence linear in $T$ may not exist"), is what the nilsoliton literature reports for its own analogue of $T$, with a published witness of two inequivalent Lie algebras carrying the *same* vector of squared structure constants. What Jacobi does leave behind, and all it leaves behind, is a **support** condition plus a residual **sign-cancellation** system that the magnitudes cannot see.

Three qualifications, all of them limiting:

- The corner is nilpotent Lie algebras in a *nice* basis, not $\mathfrak{so}(n)$ in a Weyl eigenframe. What transfers is the mechanism (the diagonal sign group) and not a theorem.
- The realizability question ("which nonnegative symmetric 3-tensors arise as $|c|^2$") **has no criterion in the literature**. The state of the art is an enumeration by computer to dimension $9$.
- Nothing found bounds $\theta$, and nothing found would let the record escape the pinned class on its own.

## Searched

`Searched: squared structure constants identities; sum of squares of structure constants beyond the Killing form; Jacobi identity in squared form; structure-constant Gram matrices; realizability of nonnegative symmetric 3-tensors as |structure constants|^2; nice bases and nilsoliton linear systems (Payne, Nikolayevsky, Conti-Rossi, Lauret); moment map for the variety of Lie algebras; hypergraph and uniformly-coloured-graph encodings of brackets; eigenframe bracket manipulations in Petersen-Wink, Boehm-Wilking, Brendle-Schoen; tr(ad(v) W ad(v) W) and sum ||[We_i,We_j]||^2.`

## 1. The literature's $T$ exists, and it is Payne's structure vector

[Payne 2010](../references/payne-2010-soliton-metrics/notes.md) is the one source that makes the vector of **squared** structure constants its primary variable. For a metric nilpotent algebra with a Ricci-eigenvector basis she sets $[\alpha^2]$ = the vector of $(\alpha^k_{ij})^2$ over the nonzero triples, builds the root matrix $Y$ (rows $\varepsilon_i+\varepsilon_j-\varepsilon_k$) and the Gram matrix $U=YY^{\mathsf T}$, and proves:

| statement | content | analogue here |
| --- | --- | --- |
| Theorem 8 | $\mathrm{Ric}=-\tfrac12Y^{\mathsf T}[\alpha^2]$, the Ricci eigenvalues are **linear in the squares** | (A) and (B): the per-index relations on $T$ |
| Theorem 1 | the nilsoliton condition is the **linear system** $U[\alpha^2]=-2\beta[1]$ | (C): criticality, linear in $T$ |
| Theorem 13 | Jacobi is Equation (8), $\sum_{s<m}\alpha^s_{ij}\alpha^m_{sk}+\alpha^s_{jk}\alpha^m_{si}+\alpha^s_{ki}\alpha^m_{sj}=0$, **quadratic in $\alpha$, sign-dependent**, required only where $U$ has a $-1$ entry | the T6 question |
| Corollary 14 | $U$ with **no $-1$ entries $\Rightarrow$ Jacobi holds automatically** | Jacobi is vacuous on the values once the support is admissible |
| §2, p. 6 and §5, p. 20 | "*Nonisometric nilmanifolds may have the same Gram matrices, structure vectors, and Dynkin diagrams*"; realised at $\mu_7,\mu_8$ in dimension six, where different sign choices give different algebras with the **same** $[\alpha^2]$ | $T$ does not determine the algebra |

**The last row is the decisive one.** Two inequivalent Lie algebras with the same $T$ means no function of $T$ can be equivalent to the Jacobi identity, and no relation Jacobi forces can be read off $T$ unless it holds for both. This is the published form of T6's named risk, and it is a witness rather than a failure to find one.

## 2. What Jacobi *does* leave on the squares: the support, and nothing else

[Conti–Rossi 2019](../references/conti-rossi-2019-nice-nilpotent/notes.md) give the mechanism explicitly. Their Proposition 1.3 writes Jacobi as $\sum_{I,J}c_Ic_J\,a(E_{IJ})=0$ with $a$ the alternator, then observes that the kernel of $a$ forces terms "*to appear in pairs or triples*". A monomial $c_Ic_J$ with no partner has nothing to cancel against, so its coefficient must vanish, which is a statement about $\operatorname{supp}T$, and the squares see it. They record it as a diagram condition:

> **(I4)** There do not exist four different nodes $i,j,k,v$ such that exactly one of $i\xrightarrow{j,k}v$, $j\xrightarrow{k,i}v$, $k\xrightarrow{i,j}v$ is a double arrow.

equivalent to Payne's "no quadruples of multiplicity one", and to "$U$ carries no isolated $-1$". Where partners *do* exist, all Jacobi asks is that they cancel, Example 1.4's $c_{123}c_{347}+c_{246}c_{617}+c_{415}c_{527}=0$, and that is a sign statement. Their §2.4 makes the extreme case explicit: no double arrows, and "*the Jacobi identity follows automatically from the definition of nice diagram*".

**The general form of the elimination, and why it is never linear.** Eliminating signs from $\varepsilon_1x_1+\dots+\varepsilon_mx_m=0$ with $x_i\ge0$ the products of magnitudes gives $\prod_{\varepsilon\in\{\pm1\}^{m-1}}\big(\sum_i\varepsilon_ix_i\big)=0$: degree $2^{m-1}$, and a **union** of hyperplane pieces rather than one equation. A linear functional of $T$ is forced by Jacobi only if it vanishes on every piece. For $m=3$ this is the quartic $(x+y+z)(-x+y+z)(x-y+z)(x+y-z)=0$, a triangle-type condition on the magnitudes, degree $2$ in $T$.

## 3. The invariant-theory ceiling, and it is the Killing form

[Mehta–Normand–Gupta 1983](../references/mehta-normand-gupta-1983-contracted-products/notes.md) prove that any product of structure constants of a compact simple Lie algebra with all dummy indices contracted **pairwise** is $0$ with one free index, proportional to the Cartan–Killing tensor with two, and proportional to $c_{abc}$ itself with three. So the record's (A) is not one contraction among many: it is the only two-index invariant there is, at any length. **The theorem also says exactly why it cannot answer T6**, its hypothesis is pairwise contraction, i.e. $O(N)$-invariance, and $T_{abc}=c_{abc}^2$ is a Hadamard square invariant only under signed permutations of the frame.

## 4. Negatives, stated plainly

- **No source treats $T_{abc}=c_{abc}^2$ for a compact simple Lie algebra as an object.** Outside the nilpotent/nice-basis corner, the squares appear only where the sum undoes them: $\sum_{b,c}c_{abc}^2=-K_{aa}$, and [Lauret's moment map](https://arxiv.org/abs/math/0206046) for the variety of Lie algebras, whose $m(\mu)$ is that same quadratic contraction and whose $\lVert m(\mu)\rVert^2$ drives the Kirwan–Ness stratification. The canonical "squared structure constants" object in the literature **is** the Killing form.
- **No realizability criterion exists.** "Which nonnegative symmetric 3-tensors are $|c|^2$" is answered by [DEMONbLAST](https://github.com/diego-conti/DEMONbLAST) enumerating to dimension $9$, with the paper stating that higher dimensions "*meet practical limits*". No moment-problem, frame-realizability or convex-geometry treatment was found.
- **No "Jacobi identity in squared form" is named anywhere.** The phrase returns nothing; the nearest object is Payne's Theorem 13, which is the statement that there is no such form.
- **The hypergraph encodings do not carry Jacobi's value content.** [Payne–Schroeder, *Uniform Lie Algebras and Uniformly Colored Graphs*](https://arxiv.org/abs/1603.00803) is the closest (structure constants of equal modulus, encoded by a coloured graph) but the algebras are two-step nilpotent, where Jacobi is nearly vacuous, so the setting is chosen to avoid the difficulty rather than to face it.
- **No eigenframe-bracket technique beyond what the record already cites.** [Böhm–Wilking](https://arxiv.org/abs/math/0606187), [Brendle–Schoen](https://arxiv.org/abs/0706.1218) and [Wilking's Lie-algebraic cones](https://arxiv.org/abs/1011.3561) work with $\mathrm{Ad}$-invariant subsets of $\mathfrak{so}(n,\mathbb C)$ and with pinching families of cones; none manipulates the brackets of a curvature operator's eigenvectors. [Petersen–Wink Proposition 1.7](../references/petersen-wink-2019-bochner-technique/notes.md), already on the record, remains the only published identity that weights $T$ by anything other than a monomial.
- **Nothing computes $\operatorname{tr}(\mathrm{ad}(v)W\,\mathrm{ad}(v)W)$ or $\sum\lVert[We_i,We_j]\rVert^2$.** Both appear here only through the record's own $S_{22}$.

## 5. An independent confirmation of r331's obstruction, by a route sharing nothing with it

r331 located the obstruction to a fourth relation as the pair $(\mathrm{Ric}(W^2),\,(W^2)_{\Lambda^4})$, by expanding $\operatorname{tr}(S\,D_A^2)$ termwise. **The same pair falls out of Schur's lemma applied to the record's own operator**, with no expansion, and the route is disjoint enough to count as validation.

Let $\mathcal A(X)=\sum_{p,q}X_{pq}\,\mathrm{ad}(v_p)\mathrm{ad}(v_q)$ on $\mathrm{Sym}^2(\Lambda^2\mathbb R^n)$, the operator [isotropy-cap.md](../findings/isotropy-cap.md) already carries, scalar on each of $\mathbb R\oplus\mathrm{Sym}^2_0\oplus\mathrm{Weyl}_n\oplus\Lambda^4$ with eigenvalues $-2(n-2),\,-(n-4),\,+2,\,-4$. Because $\sum_{a,b}f(\lambda_a)g(\lambda_b)\lVert[v_a,v_b]\rVert^2=-\operatorname{tr}\big(\mathcal A(f(W))\,g(W)\big)$ for any spectral functions $f,g$, **every two-weight contraction of $T$ is determined by the four isotypic components**:

$$\sum_{a,b,c}f(\lambda_a)\,g(\lambda_b)\,T_{abc}\;=\;-\sum_{i}a_i\,\big\langle\pi_i f(W),\,\pi_i g(W)\big\rangle .$$

*Verified to $10^{-15}$ at $n=6,7,8,9,10$ for $(p,q)\in\{(1,1),(2,1),(2,2),(3,2),(3,3),(4,2)\}$ on random Weyl tensors* ([lit_jacobi_isotypic_law.py](../scripts/lib/lit_jacobi_isotypic_law.py)).

**This re-derives the pinned/free boundary as a one-line consequence.** If $f$ or $g$ is affine, that argument is $W$ itself, which is pure Weyl, so only the Weyl scalar survives and the contraction is spectral, which is post F42's "two exponents $\le1$". The first pattern needing more is $f=g=\lambda^2$, and there $W^2$ has components in all four summands: exactly r331's $(\mathrm{Ric}(W^2),(W^2)_{\Lambda^4})$, reached as the two summands on which $\mathcal A$ is not $+2$ and $W^2$ is not zero.

**The closed form it gives.** Normalising the basis to $\langle A,B\rangle=\operatorname{tr}(A^{\mathsf T}B)$, where the four scalars are $+1,-2,-(n-4)/2,-(n-2)$,

$$S_{22}\;=\;-\sum_a\lambda_a^4\;+\;3\big\lVert\pi_{\Lambda^4}(W^2)\big\rVert^2\;+\;\tfrac{n-2}{2}\big\lVert\pi_{\mathrm{Sym}^2_0}(W^2)\big\rVert^2\;+\;(n-1)\frac{(\operatorname{tr}W^2)^2}{N},$$

so the whole non-spectral content of $\{2,2,0\}$ is **two nonnegative numbers**, both bounded by $\lVert W^2\rVert^2$ minus the scalar part. Chaining that gives a spectrum-only ceiling $S_{22}\le-\sum\lambda^4+\max\!\big(3,\tfrac{n-2}{2}\big)\big(\sum\lambda^4-\tfrac{(\operatorname{tr}W^2)^2}{N}\big)+(n-1)\tfrac{(\operatorname{tr}W^2)^2}{N}$.

**And it independently confirms r331's two-eigenvalue collapse.** At a sphere product $W^2$ is an affine function of $W$, so both obstruction norms vanish identically: measured $\lVert\pi_{\Lambda^4}(W^2)\rVert^2$ and $\lVert\pi_{\mathrm{Sym}^2_0}(W^2)\rVert^2$ are $10^{-31}$ at $S^4\times S^4$ and at $S^6\times S^6$, where the spectrum-only ceiling is loose by $4.2\%$ and $1.7\%$ respectively; at the unbalanced $S^4\times S^8$ the $\mathrm{Sym}^2_0$ part is $2.0\times10^{-2}$ and the ceiling is loose by $29\%$.

## 6. What this does not buy

- **It is not an escape from the pinned class.** The formula is an identity, not a bound; the two obstruction norms are exactly the data the pinned relations do not carry, and nothing here constrains them at a critical point. That is the same wall r331 ends at, reached from a second direction.
- **The spectrum-only ceiling is a consequence of positivity of the two norms, and positivity is what post F42's successor already had.** It is worth having as an explicit inequality between $S_{22}$ and the spectrum, and it is worth nothing more until something bounds $\lVert\pi_{\mathrm{Sym}^2_0}(W^2)\rVert$ from above at a critical point.
- **The literature supplies no such bound.** $\pi_{\mathrm{Sym}^2_0}(W^2)$ is the traceless part of $W\!\circ\!W$, $(W\!\circ\!W)_{ij}=W_{iklm}W_{jklm}$, which is studied in the Bochner literature only through its trace $\lVert W\rVert^2$.

## 7. What a successor should take from this

1. **Stop looking for a linear-in-$T$ consequence of Jacobi.** Two published statements say it does not exist, Payne's Corollary 14 (Jacobi vacuous on values once the support is admissible) and her $\mu_7/\mu_8$ witness (same squares, different algebra), and r331 proved it directly here.
2. **The support of $T$ is where Jacobi is visible.** (I4) is a real, checkable consequence of Jacobi that survives squaring. Whether the $\mathfrak{so}(n)$ analogue has content on a Weyl eigenframe is untested, and is the one literature-backed angle T6 has not spent.
3. **Name the two obstruction norms as the free data.** "The free content of $\{2,2,0\}$" now has two explicit nonnegative coordinates rather than being a residual, and any future bound on the pair is a bound on $S_{22}$.
