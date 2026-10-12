# The Bianchi identity as a $\Lambda^4$ component, and the four-dimensional Singer–Thorpe criterion

Transcribed 2026-09-08 by reviewer r773, for items 9 and 13 of [BRIEF-g2-l179-l180.md](../../reviews/BRIEF-g2-l179-l180.md).

## Section 1.1, the decomposition that answers item 9, verbatim

> Recall that there is an orthogonal decomposition
> $$\mathrm{Sym}^2(\Lambda^2 V) = \mathrm{Sym}^2_B(\Lambda^2 V) \oplus \Lambda^4 V,$$
> where the vector space $\mathrm{Sym}^2_B(\Lambda^2 V)$ consists of all tensors $T \in \mathrm{Sym}^2(\Lambda^2 V)$ that also satisfy the first Bianchi identity. Any $R \in \mathrm{Sym}^2_B(\Lambda^2 V)$ is called an algebraic curvature tensor.

So the first Bianchi identity is exactly membership in the kernel of the projection $S^2\Lambda^2 \to \Lambda^4$, and the projection is orthogonal. **The identity is a vanishing statement, so the normalising constant in front of the projection is immaterial**, which is what the record's $\mathfrak b(\omega \odot \eta) = \omega \wedge \eta$ needs and all it needs.

## Their norm conventions, which match the record's for forms and differ for tensors

> When $T \in T^{(0,k)}(V)$ define $|T|^2 = \sum_{i_1 \ldots i_k}(T_{i_1\ldots i_k})^2$, whereas for a $p$-form $\omega \in \Lambda^p V^*$ set $|\omega|^2 = \sum_{i_1 < \ldots < i_p} (\omega_{i_1 \ldots i_p})^2$.

The form convention is the record's. **The tensor convention is not the record's operator convention**: for $W$ read as a $(0,4)$-tensor, $|W|^2 = \sum_{abcd} W_{abcd}^2 = 4\sum_{a<b,\,c<d} W_{abcd}^2$, so a quantity written $\lVert W\rVert$ in one convention is $2\lVert W\rVert$ in the other. Anything importing a numerical constant from this paper must fix which is meant.

## Remark 2.5, the Singer–Thorpe basis and the four-dimensional Bianchi criterion, verbatim

> Let $(V,g)$ be a 4-dimensional Euclidean vector space. Due to results of Singer–Thorpe [ST69], an algebraic curvature operator $R : \Lambda^2 V \to \Lambda^2 V$ is Einstein if and only if it commutes with the Hodge star operator with respect to any orientation of $V$. Once an orientation is fixed, there is an orthonormal basis $e_1,e_2,e_3,e_4$ of $V$ such that
> $$\Xi_1 = \tfrac1{\sqrt2}(e_1\wedge e_2 + e_3 \wedge e_4),\quad \Xi_2 = \tfrac1{\sqrt2}(e_1 \wedge e_3 - e_2 \wedge e_4),\quad \Xi_3 = \tfrac1{\sqrt2}(e_1\wedge e_4 + e_2 \wedge e_3)$$
> is an orthonormal basis for the self-dual part $\Lambda^+V$, [and $\Xi_4,\Xi_5,\Xi_6$, with the signs reversed, one for $\Lambda^-V$,] and $R(\Xi_i) = \lambda_i \Xi_i$ for $i = 1,\ldots,6$. Any such basis is called a Singer–Thorpe basis.
>
> Moreover, with respect to the above basis $\{\Xi_\alpha\}$, the self-adjoint operator $R : \Lambda^2 V \to \Lambda^2 V$ defined by $R(\Xi_i) = \lambda_i \Xi_i$ for $i = 1,\ldots,6$ satisfies the first Bianchi identity if and only if
> $$\lambda_1 + \lambda_2 + \lambda_3 = \lambda_4 + \lambda_5 + \lambda_6 .$$

**This is a construction recipe for algebraic Weyl tensors of prescribed low $\Lambda^2$-rank in dimension four**, and hence, by extension by zero, in every $n \ge 4$. Take $(\lambda_1,\lambda_2,\lambda_3) = (2,-1,-1)$ and $\lambda_4 = \lambda_5 = \lambda_6 = 0$: the Bianchi criterion reads $0 = 0$; the operator commutes with $*$, so it is Einstein; its trace $\sum_\alpha \lambda_\alpha = 0$ makes the scalar curvature vanish, so it is Ricci-flat and equals its own Weyl tensor. Its $\Lambda^2$-rank is three and each $\Xi_i$ is nondegenerate, so the span of the supports is all of $\mathbb R^4$. See [REVIEW_r773.md](../../reviews/REVIEW_r773.md) §13.
