# Petersen–Wink, *Tachibana-type Theorems and special Holonomy*, [arXiv:2105.09290](https://arxiv.org/abs/2105.09290)

Transcribed from [petersen-wink-2105.09290.txt](https://arxiv.org/abs/2105.09290), p. 5–6. **This source was stored without notes for the life of the project**, and its Proposition 1.3 is the origin of a manoeuvre this project re-derived independently; the transcription exists so that cannot happen again.

## Proposition 1.3, verbatim

> Let $R\in\mathrm{Sym}^2_B(\mathfrak g)$ be an algebraic curvature tensor and let $R:\mathfrak g\to\mathfrak g$ be the corresponding curvature operator. **If $R$ is 2-nonnegative**, then $g(R(R_{\mathfrak g}),R_{\mathfrak g})\ge0$.

## The proof, which is where the content is

With $\{\Xi_\alpha\}$ an orthonormal eigenbasis of $R$ and $\lambda_1\le\dots\le\lambda_{\dim\mathfrak g}$ the eigenvalues, citing [PW21b, Example 1.2]:

$$\lvert\Xi_\gamma R\rvert^2=2\sum_{\alpha<\beta}(\lambda_\alpha-\lambda_\beta)^2\,g([\Xi_\gamma,\Xi_\alpha],\Xi_\beta)^2 .$$

Since $g([\Xi_\alpha,\Xi_\beta],\Xi_\gamma)^2$ is **fully symmetric**, the $\lambda$-weighted sum regroups by unordered triple:

$$g(R(R_{\mathfrak g}),R_{\mathfrak g})=2\sum_\gamma\sum_{\alpha<\beta}\lambda_\gamma(\lambda_\alpha-\lambda_\beta)^2g([\Xi_\gamma,\Xi_\alpha],\Xi_\beta)^2=2\sum_I\Lambda_{\alpha\beta\gamma}\,g([\Xi_\alpha,\Xi_\beta],\Xi_\gamma)^2,$$

over index sets $I=\{\alpha,\beta,\gamma\}$ of size $3$, with

$$\Lambda_{\alpha\beta\gamma}=\lambda_\alpha(\lambda_\beta-\lambda_\gamma)^2+\lambda_\beta(\lambda_\gamma-\lambda_\alpha)^2+\lambda_\gamma(\lambda_\alpha-\lambda_\beta)^2 .$$

Taking $\alpha<\beta<\gamma$: 2-nonnegativity gives $\Lambda_{\alpha\beta\gamma}\ge0$ whenever $\alpha\ge2$, so everything reduces to the triples containing the **smallest** eigenvalue, and there

$$\Lambda_{1\beta\gamma}\ \ge\ (\lambda_1+\lambda_\beta)(\lambda_1-\lambda_\gamma)^2+\lambda_\gamma(\lambda_1-\lambda_\beta)^2\ \ge\ 0 .$$

## What this settles for the project, and what it does not

**The regrouping and the isolate-the-extreme-index manoeuvre are theirs.** Splitting the $\lambda$-weighted sum so that the terms carrying $\lambda_{\min}$ are handled separately from the rest, and bounding the rest, is exactly the step Proposition 1.3 runs. Any bound this project derives by isolating $\lambda_{\min}$ in that sum is a re-use of their technique and is cited as such.

**Their conclusion does not transfer, and the hypothesis is why.** Proposition 1.3 proves a *lower* bound (non-negativity) and it needs $R$ **2-nonnegative**. A Weyl tensor is never 2-nonnegative: $\mathop{\mathrm{tr}}W=0$ forces $\lambda_{\min}<0$, and on $\mathrm{Weyl}_n$ the quantity is not only allowed to be negative, its extreme negative value *is* the problem. So the direction the project needs (an upper bound on the cubic), is the opposite one, and no hypothesis in this paper supplies it.

**The $\Lambda$ grouping is strictly finer than a sign split, and combining it with $\theta$'s definition is already fenced.** Grouping by unordered triple with weight $\Lambda$ retains more than grouping the same sum by the sign of a single index. But $\Lambda_{\alpha\beta\gamma}+6\lambda_\alpha\lambda_\beta\lambda_\gamma=\sum_{i\ne j}\lambda_i\lambda_j^2$ identically, so pairing the $\Lambda$ form against $\theta=\sum\lambda^3+3\sum T\lambda\lambda\lambda$ collapses to a linear consequence of the two inputs rather than a new constraint, see [fence post 18](../../findings/bounds.md).

## Citation graph forward

The identity $\lvert\Xi_\gamma R\rvert^2=2\sum_{\alpha<\beta}(\lambda_\alpha-\lambda_\beta)^2g(\cdot)^2$ is [PW21b, Example 1.2], i.e. [Petersen–Wink, *New Curvature Conditions for the Bochner Technique*](https://arxiv.org/abs/1908.09958), already stored at [petersen-wink-2019-bochner-technique](../petersen-wink-2019-bochner-technique/). Proposition 1.4 (harmonicity of a divergence-free algebraic curvature tensor satisfying second Bianchi) is attributed to [Pet16, Theorem 9.4.2].
