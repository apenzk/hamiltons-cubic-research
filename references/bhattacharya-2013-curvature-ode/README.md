# Bhattacharya, On the curvature ODE associated to the Ricci flow

| | |
| --- | --- |
| **Source** | [On the curvature ODE associated to the Ricci flow](https://arxiv.org/abs/1310.4618) · [Geom. Dedicata (2014), doi 10.1007/s10711-014-0035-7](https://link.springer.com/article/10.1007/s10711-014-0035-7) |
| **Identifier** | arXiv:1310.4618v1, 17 Oct 2013; math.DG |
| **Retrieved** | 2026-09-02, by [LIT-srg-forward](../../reviews/LIT-srg-forward.md) |

## Consulted for

Search target 4 of [LIT-srg-forward](../../reviews/LIT-srg-forward.md): critical points of Hamilton's quadratic $Q(R)=R^2+R^\#$, "algebraic curvature operators fixed by $Q$ up to scale". This is the one paper found whose stated subject is the zero set of $Q$ and of its scalar-curvature-normalised form $\tilde Q(R)=Q(R)-\lVert\mathop{\mathrm{Ric}}(R)\rVert^2R$ on $\{s(R)=1\}$, as a problem in algebraic curvature operators. Zero citations on OpenAlex, Semantic Scholar and Google Scholar; the record had never seen it.

## Statements that matter

- **The programme's problem is posed in print, and left open** (p. 3): "For dimensions greater than 4, the full set of zeros of $Q$ or all the Einstein zeros of $\tilde Q$ are not known to us." An Einstein zero of $\tilde Q$ is $R=cI+W$ with $Q(W)=\lambda W$, $\lambda=\lVert\mathop{\mathrm{Ric}}\rVert^2=s/n$, the record's $\theta$-critical Weyl tensor, since $Q(I,W)=0$ and $Q(I)=(n-1)I$.
- **Proposition 1.1 / 4.1**, on a closed Einstein manifold with unit scalar curvature the curvature operator is a zero of $\tilde Q$ at every point iff the metric is locally symmetric. The "if" is the record's [Lemma 46](../../findings/problem.md); the "only if" is its converse on closed manifolds, from $\Delta R+2Q(R)=\tfrac2nR$ forcing $\Delta R=0$.
- **Theorem 1.2 / Proposition 4.5**, at $n=4$ the Einstein zeros of $\tilde Q$ are exactly the normalised curvature operators of $S^4$, $S^2\times S^2$ and $\mathbb{CP}^2$; i.e. the $\theta$-critical points of $\mathcal W_4$ are $0$, $W_{\mathbb{CP}^2}$ and $W_{S^2\times S^2}$ up to $O(4)$ and scale. Proved by solving $x_i^2+\mu x_jx_k=\tfrac14x_i$ blockwise on $\Lambda^\pm$.
- **Theorem 1.3 / 4.6**, in every dimension the Ricci-type ($W=0$) zeros of $\tilde Q$ other than $I$ are the curvature operator of $S^n\times\mathbb R$; so nothing with $W=0$ competes, in any $n$.
- **Proposition 4.2**, a product of two Einstein symmetric spaces is a zero of $\tilde Q$ iff the product is Einstein or one factor is flat: the product critical points are the balanced ones, in the record's language the $\theta$-critical sphere products are those with equal Einstein constants.
- **Theorem 1.4**, the reaction ODE is unstable near $R_{M\times\mathbb R^k}$ for $M$ Einstein symmetric of compact type other than a space form; a statement about the flow's linearisation at the record's critical points, and the record's Hessian data at $W_{S^{m}\times S^{m}}$ are the Weyl restriction of this.

## Verdict

**The record's critical-point problem exists in the literature, posed in 2013 and left open for $n>4$; the paper settles $n=4$ and the Weyl-free case, and nothing beyond.** It supplies a citation for the problem statement, for the $n=4$ classification, and for the converse of Lemma 46 on closed manifolds. It contains no bound on $\theta$, no statement about $S^{n/2}\times S^{n/2}$ being extremal, and no method that reaches $n\ge5$: the author says outright that an eigenbasis of $R$ need not diagonalise $Q(R)$ above $n=4$, which is exactly where the record's non-diagonal problem begins.

**Re-consulted 2026-09-27** for [I117](../../plan.md)'s U$_{\mathrm s}$ ([L264](../../findings/second-order.md)): Theorem 1.4 is the Hamilton-ODE analogue of U$_{\mathrm s}$ (instability of every symmetric-space zero but the sphere), local only, for $R^2+R^\#$ on the Bianchi subspace rather than $\#$ on $\mathop{\mathrm{Sym}}^2\mathfrak{so}(n)$, so it settles nothing there; its linearisation method is the one [L265](../../findings/second-order.md) uses at $I/c$.
