# Weingart, *Moments of Sectional Curvature* (arXiv:1707.06369, 20 Jul 2017)

Stored 2026-08-23. [paper.pdf](https://arxiv.org/abs/1707.06369), [paper.txt](https://arxiv.org/abs/1707.06369) (`pdftotext -layout`, 23 pages).

## Why it is here

[b_theta3_identification.py](../../scripts/b_theta3_identification.py) shows $\theta=\Theta_3/32$, and [Weingart 2024](../graphical-calculus-stable-invariants-2024/notes.md) §6 says the third moment of sectional curvature "is related to" $\Theta_3$. This is the paper that computes those moments.

**Read this first: $\theta$ is NOT the third moment.** [b_third_moment_refuted.py](../../scripts/b_third_moment_refuted.py), $S^3\times S^3$ and $\mathbb{CP}^3$ have identical $\theta=1.054093$ and third moments a factor $13$ apart, a gap of $264$ standard errors. On Ricci-flat $W$ the cubic invariants form a $2$-plane spanned by $\mathrm{tr}\,W^3$ and $\langle W,W^\#\rangle$; $\theta$ is their sum and $\Psi_3$ is a different point of it. **So this paper's closed forms compute a different invariant from $\theta$**, and the "closed form for $\theta$ across the graded class" hope below is dead unless the exact combination is worked out.

Sectional curvature is treated as a random variable on the Grassmann bundle $\mathrm{Gr}_2TM$ with the Fubini–Study volume density; its moments are integrals of local Riemannian invariants.

## Corollary 2.6, the moments as curvature invariants

> For every euclidean $V$ of dimension $m$ there exist natural $O(V,g)$-invariant polynomials $\Psi^V_k$ of degree $k$ on the space $\mathrm{Kr}\,V$ of algebraic curvature tensors such that
> $$\frac1{\mathrm{Vol}\,\mathrm{Gr}_2TM}\int_{\mathrm{Gr}_2TM}\sec^k_{R_p}(\Sigma)\,\mathrm{vol}_g(p,\Sigma)=\frac1{\mathrm{Vol}\,M}\int_M\Psi^{T_pM}_k(R_p)\,\mathrm{vol}_g(p)$$
> with $\displaystyle\Psi^V_k(R):=\frac{(-\Delta_g)^k}{[m+2k-2]_{2k}}\Big(X\mapsto\exp\Big(\sum_{r>0}\tfrac1{2r}\mathrm{tr}_V(R_{\cdot,X}X)^r\Big)\Big)_0$

$\Psi^V_k$ is a polynomial on **algebraic** curvature tensors, so it evaluates pointwise, this is the part that can reach $\mathrm{Weyl}_n$.

Weingart notes the pinching constant of $M$ is in principle computable without ever evaluating a single sectional curvature, via $\max|\sec|=\lim_k\sqrt[2k]{\text{(2k-th moment)}}$.

## Lemma 4.1, moments of products, which is the conjectured maximiser

> For Riemannian $M^m$, $N^n$ with $m,n\ge2$, $R^{M\times N}_{(p,q)}=R^M_p\oplus R^N_q$, and
> $$\Psi^{M\times N}_k(R_{(p,q)})=\sum_{r=0}^k\binom{k}{r}\frac{[m+2r-2]_{2r}\,[n+2(k-r)-2]_{2(k-r)}}{[m+n+2k-2]_{2k}}\ \Psi_r(R^M_p)\,\Psi_{k-r}(R^N_q)$$
> and the formula still holds for the integrated pointwise moments of Corollary 2.6.

For $M=S^p$, $N=S^q$ of constant curvature $1$ every $\Psi_r$ is $1$, so the third moment of a sphere product is a **closed-form rational function of $(p,q)$**, the same family Conjecture A says maximises $\theta$.

Weingart adds that the weights have "a very neat model in probability theory": the density $(m+n-2)!\,x^{m-2}y^{n-2}dx\,dy$ on the simplex $\Delta_2=\{x,y\ge0,\ x+y\le1\}$.

## The other results, and what they are for

| | |
|---|---|
| Theorem 2.4 | Moments of sectional curvature; the generating power series is at line 563 of the text extraction |
| Lemma 3.2 | **Weyl's integration formula for sectional curvature moments**, the route to all symmetric spaces |
| Corollary 3.1 | Explicit sectional curvature densities |
| Corollary 4.2 | Sectional curvature densities for products |
| Theorem 4.3 | Euler characteristic of 4-dimensional manifolds; the weak Hitchin–Thorpe application |

## What it could and could not do here, stated so a later cycle does not overreach

**Could:** give $\theta$ in closed form across the graded class, since Lemma 3.2 reaches every symmetric space and Lemma 4.1 handles products. The record's graded enumeration currently computes these case by case and is [known to be non-exhaustive](../../findings/INDEX.md) on reducible isotropy.

**Could not, without more work:** $\Psi_k$ is a moment of the **full** curvature tensor, while $\theta$ is built from the **Weyl part** alone. The identity $\Theta_3=32\,\theta$ was verified on Ricci-flat $W$; for a sphere product's full $R$ the Ricci and scalar parts contribute, so relating $\Psi_3(R)$ to $\theta(W)$ needs the Ricci decomposition carried through explicitly. **That is the next cycle's first task, and it is arithmetic rather than a new idea.**

**And the standing objection still applies:** graded critical points here are indexed by symmetric *pairs* $\mathfrak h\subseteq\mathfrak{so}(n)$, not by symmetric *spaces*, so a closed form over symmetric spaces cannot close the graded enumeration by itself, the same reason Petersen–Stanfield's tables could not.
