# Notes, Bhattacharya, *On the curvature ODE associated to the Ricci flow*

Transcribed from [bhattacharya-1310.4618.txt](https://arxiv.org/abs/1310.4618) (`pdftotext -layout`); line references are to that dump. The paper's $Q(R)=R^2+R^\#$ is the record's $Q$ (p. 4: $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ with $\langle A,B\rangle=-\tfrac12\operatorname{tr}(AB)$, the Böhm–Wilking convention).

## The normalised ODE and the object studied (L100–L145)

> In this paper we study the zeros of (1.4) for a specific normalization where the solution curves have constant scalar curvature one. ... $\bar R(t)=R(t)/s(R(t))$ satisfies $\frac{d\bar R}{dt}=s(R)\big(Q(\bar R)-\lVert\operatorname{Ric}(\bar R)\rVert^2\bar R\big)$ where we use $\frac{d}{dt}s(R)=s(Q(R))=\lVert\operatorname{Ric}(R)\rVert^2$.

> Define the vector field $\tilde Q$ on the hyperplane $S_1=\{R\in S^2_B(\Lambda^2\mathbb R^n):s(R)=1\}$ by $\tilde Q(R)=Q(R)-\lVert\operatorname{Ric}(R)\rVert^2R$.

**Translation to the record.** For $R=cI+W$ Einstein with $W\in\mathcal W_n$: $\operatorname{Ric}(R)=c(n-1)\,g$, $s=n(n-1)c$, and $Q(cI+W)=c^2(n-1)I+Q(W)$ because $Q(I)=(n-1)I$ and the bilinear form $Q(I,W)=B(I,W)$ vanishes on Weyl tensors (Böhm–Wilking Lemma 2.1, quoted by Richard–Seshadri as Lemma 3.1 in [richard-seshadri-2013-noncoercive-cones](../richard-seshadri-2013-noncoercive-cones/notes.md)). So $\tilde Q(R)=0$ on $S_1$ reads $c^2(n-1)I+Q(W)=\lVert\operatorname{Ric}\rVert^2(cI+W)$ with $\lVert\operatorname{Ric}\rVert^2=n(n-1)^2c^2$; at $s=1$ this gives $c=1/(n(n-1))$ and $\lVert\operatorname{Ric}\rVert^2=1/n$, the $I$-component balances identically ($c^2(n-1)=c/n$), and the $W$-component says $Q(W)=\tfrac1nW$. **An Einstein zero of $\tilde Q$ is exactly $R=\tfrac1{n(n-1)}I+W$ with $W$ $\theta$-critical, $\theta\lVert W\rVert=\tfrac1n$.** Scaling $W$ to the unit sphere: $\theta=1/(n\lVert W\rVert)$, so the $\theta$ of the record and the scalar-curvature-one normalisation are one datum.

## The problem statement (L174–L177, verbatim)

> For dimensions greater than 4, the full set of zeros of $Q$ or all the Einstein zeros of $\tilde Q$ are not known to us. Even in dimension 4 it is not clear if there exists a zero of $\tilde Q$, other than the curvature operator of $S^2\times\mathbb R^2$, which is neither Einstein and nor of Ricci type.

The first sentence is the record's Conjecture-A setting stated as an open classification problem in 2013; the record's $\theta$ table in [findings/INDEX.md](../../findings/INDEX.md) is a partial answer to it.

## Proposition 1.1 = Proposition 4.1 (L146–L150 and L441–L460, verbatim)

> **Proposition 4.1.** Let $(M^n,g)$ be a closed Einstein manifold with unit (respectively zero) scalar curvature. Then the Riemannian curvature operator $R$ is a zero of $\tilde Q$ (respectively $Q$) at each point in $M$ if and only if $(M,g)$ is locally symmetric (respectively flat).

Proof as given: the Einstein identity $\Delta R_g+2Q(R_g)=\tfrac2nR_g$ (cited to [8], p. 40, i.e. Hamilton's four-manifolds paper in Bhattacharya's numbering; the same identity is Brendle's Proposition 3 in Richard–Seshadri's Lemma 4.1) plus $\lVert\operatorname{Ric}\rVert^2=\tfrac1n$ gives $\Delta R_g=0$ at every point when $\tilde Q(R)=0$; on a closed manifold $\Delta R=0$ forces $\nabla R=0$. The converse is the record's [Lemma 46](../../findings/problem.md) in the $R$ rather than the $W$ variable.

**What the record can cite.** The direction "symmetric Einstein $\Rightarrow$ critical" is Lemma 46 and is in Richard–Seshadri as well; the direction "critical at every point of a closed Einstein manifold $\Rightarrow$ locally symmetric" is new to the record. It says that a $\theta$-critical Weyl tensor that is the Weyl tensor of a closed Einstein manifold at every point is the Weyl tensor of a symmetric space. It says nothing about algebraic $W$ that are the Weyl tensor of no manifold, which is where DGK's strongly-regular-graph solutions and the record's open cases live.

## Theorem 1.2 = Propositions 4.4 and 4.5, the $n=4$ classification (L154–L165, L580, L660–L747)

> **Theorem 1.2.** (1). The only algebraic curvature operator $R\in S^2_B(\Lambda^2\mathbb R^4)$ which is a zero of $Q$ is the zero curvature operator. (2). If $R\in S^2_B(\Lambda^2\mathbb R^4)$ is an Einstein algebraic curvature operator ... which is a zero of $\tilde Q$, then $R$ is the curvature operator of a (locally) symmetric space with unit scalar curvature.

> **Proposition 4.5.** If $R\in S^2_B(\Lambda^2\mathbb R^4)$ is an Einstein zero of $\tilde Q$, then up to the action of the orthogonal group, $R$ is one of the following: (1) curvature operator of the round metric on $S^4$ normalized to unit scalar curvature, (2) curvature operator of the standard product metric on $S^2\times S^2$ normalized to unit scalar curvature, (3) curvature operator of the Fubini–Study metric on $\mathbb{CP}^2$ normalized to unit scalar curvature.

The proof (L672–L740) writes $R=\big(\tfrac1{12}I+R_W^+\big)\oplus\big(\tfrac1{12}I+R_W^-\big)$ on $\Lambda^+\oplus\Lambda^-$, diagonalises each block as $\operatorname{diag}(x_1,x_2,x_3)$ with $\sum x_i=\tfrac14$, uses that at $n=4$ an eigenbasis of an Einstein $R$ diagonalises $Q(R)$ blockwise with $Q(R^+)=\operatorname{diag}(x_1^2+c_1x_2x_3,\dots)$, and solves
$$\lambda_i^2+\mu\lambda_j\lambda_k=\tfrac14\lambda_i\ (i=1,2,3),\qquad\lambda_1+\lambda_2+\lambda_3=\tfrac14,$$
whose solutions are $(0,0,\tfrac14)$ and permutations, and $(\tfrac1{12},\tfrac1{12},\tfrac1{12})$. Read in the record's variable $W^\pm=R^\pm-\tfrac1{12}I$: the block is $0$ or $\tfrac1{12}(2,-1,-1)$ up to permutation, so the $\theta$-critical points of $\mathcal W_4$ are $0$, one block $(2,-1,-1)$ with the other zero ($W_{\mathbb{CP}^2}$, $\theta=\sqrt{3/2}$ at unit norm), and both blocks $(2,-1,-1)$ ($W_{S^2\times S^2}$, $\theta=\sqrt{3}/2$ at unit norm). This matches the record's $n=4$ entries in the $\theta$ table of [findings/INDEX.md](../../findings/INDEX.md), and the paper is the citable source for "these are all of them".

The remark after the proof (L742–L747): "in dimension 4 an algebraic Einstein curvature operator $R$ with positive scalar curvature satisfying $Q(R)=\lambda R$, must be the curvature operator of some (locally) symmetric 4-manifold."

The sentence that marks the boundary of the method (L655–L658): "Unlike dimension 4, in higher dimensions an eigen basis of an Einstein curvature operator $R$ need not always diagonalize $Q(R)$ and one fails to get such a simplified expression for $Q(R)$." This is the record's distinction between the diagonal locus, where DGK's equation lives, and the full problem.

## Theorem 1.3 = Theorem 4.6, Ricci-type zeros in every dimension (L168–L173, L752–L760)

> **Theorem 1.3.** For dimension $n+1$, $n\ge3$; if $R\in S^2_B(\Lambda^2\mathbb R^{n+1})$ is an algebraic curvature operator of Ricci type which is not a multiple of the identity operator and $\tilde Q(R)=0$, then up to the action of the orthogonal group, $R$ is the curvature operator of $S^n\times\mathbb R$ corresponding to the standard product metric normalized to unit scalar curvature.

For the record this is a statement about the complement of $\mathcal W_n$: the $W=0$ zeros of $\tilde Q$ are $I$ and $R_{S^n\times\mathbb R}$, so the Ricci-type sector contributes no competitor and the critical-point problem is a problem about $\mathcal W_n$ together with the mixed sector.

## Proposition 4.2, products (L466–L470, verbatim)

> **Proposition 4.2.** Let $(M_i^{n_i},g_i)$ ($i=1,2$) be symmetric Einstein manifolds such that the curvature operator of the product space $(M_1^{n_1}\times M_2^{n_2},\tilde g)$ is a zero of $\tilde Q$ where $\tilde g$ is the product metric normalized to unit scalar curvature. Then either $\tilde g$ is Einstein or one of $g_1,g_2$ is flat.

Combined with Lemma 46 this makes the critical products of two symmetric Einstein factors exactly the Einstein products, i.e. equal Einstein constants; the record's sphere products $S^p\times S^q$ with $p\ne q$ scaled to equal Einstein constants are critical, and unequal-constant products are not. [findings/problem.md](../../findings/problem.md) has this from its own computation; the paper is a citation.

## Theorem 1.4 and §5, instability (L181–L184, L859–L1199)

> **Theorem 1.4.** The reaction ODE (1.4) behaves unstably near the curvature operator of the Riemannian product $M\times\mathbb R^k$ for $k\ge0$, where $M$ is an Einstein symmetric space with positive scalar curvature and not a spherical space form when $k=0$.

Proposition 5.1 (L859) does the $k=0$ case from the eigenvalue $\lambda$ of the linearisation of $\tilde Q$ along the Weyl direction; Corollary 5.5 and Proposition 5.7 handle $k\ge1$ and $S^n\times\mathbb R$. This is the flow-side reading of the record's Hessian at a critical point: an unstable direction of $\tilde Q$ at $R=cI+W$ restricted to $\mathcal W_n$ is a direction in which $P$ is second-order increasing or decreasing depending on the sign convention, and the record's Morse index computations at $W_{S^m\times S^m}$ are the Weyl restriction of the object §5 studies. The paper does not compute the full Hessian and does not state a Morse index.

## What the paper does NOT do

- No inequality on $\theta$, on $\lVert Q(W)\rVert$, or on $P(W)=\langle W,Q(W)\rangle$.
- No claim, conjecture or remark that $S^{n/2}\times S^{n/2}$ is extremal among critical points.
- No classification above $n=4$ except for $W=0$; the author states the higher-dimensional problem as open.
- No use of the diagonal locus, structure constants, or strongly regular graphs; no connection made to Jäger or to the group-theoretic literature that became DGK.
- Zero forward citations found (OpenAlex, Semantic Scholar, Google Scholar, 2026-09-02), so the problem as posed here was not taken up by anyone before DGK, who do not cite it either.
