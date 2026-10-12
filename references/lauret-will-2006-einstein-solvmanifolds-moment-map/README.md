# Lauret, Will, Einstein solvmanifolds: existence and non-existence questions

| | |
| --- | --- |
| **Source** | [Einstein solvmanifolds: existence and non-existence questions](https://arxiv.org/abs/math/0602502) · [Math. Ann. 350 (2011) 199–225, doi 10.1007/s00208-010-0552-0](https://doi.org/10.1007/s00208-010-0552-0) |
| **Identifier** | arXiv:math/0602502v4; math.DG |
| **Retrieved** | 2026-09-02, by [LIT-srg-forward](../../reviews/LIT-srg-forward.md) |

## Consulted for

Search target 5 of [LIT-srg-forward](../../reviews/LIT-srg-forward.md): a name in the Lie-algebra literature for the condition that a vector of moments of the squared-structure-constant measure lies in the convex hull of the points it averages, the record's per-row hull reading of [T11](../../plan.md) ([r337](../../reviews/REVIEW_r337.md), [bounds.md](../../findings/bounds.md)). This is the paper in which that condition is stated as a proposition, with the squared structure constants $(\mu^k_{ij})^2$ as the probability weights and the weights $\alpha^k_{ij}=E_{kk}-E_{ii}-E_{jj}$ of the torus action as the points, and in which the convex-hull object is tied both to Kirwan's stratification and to Payne's linear system $U[\alpha^2]=\nu[1]$ that the record already holds from [payne-2010-soliton-metrics](../payne-2010-soliton-metrics/notes.md).

## Statements that matter

- **Proposition 3.2(i)**, for every nonzero bracket $\mu=\sum_{i<j}\mu^k_{ij}v_{ijk}$, the diagonal part of the normalised Ricci operator is $p_{\mathfrak t}\big(\tfrac4{\lVert\mu\rVert^2}R_\mu\big)=\tfrac2{\lVert\mu\rVert^2}\sum_{i<j}(\mu^k_{ij})^2\alpha^k_{ij}\in\mathrm{CH}\{\alpha^k_{ij}:\mu^k_{ij}\ne0\}$, and hence $F(\mu)=\lVert m(\mu)\rVert^2\ge\lVert\beta_\mu\rVert^2$ with $\beta_\mu$ the point of $\mathrm{CH}$ closest to the origin. The name for the record's hull reading: **the moment-map image at $\mu$ is a convex combination of the weight points, weighted by the squared structure constants** (Kirwan–Ness convexity, proved over $\mathbb R$ by Marian).
- **Proposition 3.3**, a nonnegative solution $[c^k_{ij}]$ of Payne's system $U[c]=\nu[1]$ with $\sum c=1$ is a convex-combination representation of $\beta_\mu$, and $\nu=\lVert\beta_\mu\rVert^2$; conversely a strictly positive representation of $\beta_\mu$ solves the system. The linear system the record knows from Payne and Nikolayevsky **is** the Lagrange condition for the closest point of the hull.
- **Theorem 3.1** (from Lauret's earlier work), the strata $\mathcal S_\beta$ indexed by the minimal convex combinations $\beta_\mu$, and Proposition 3.4: $S_\mu$ is Einstein iff $\tfrac4{\lVert\mu\rVert^2}R_\mu$ is conjugate to $\beta$, iff $F(\mu)=\lVert\beta\rVert^2$, the hull bound is attained exactly at the Einstein points.
- **Theorem 2.7**, Payne's Theorem 1 restated: with $R_\mu$ diagonal, $S_\mu$ Einstein iff $U[(\mu^k_{ij})^2]=\nu[1]$.

## Verdict

**The record's two-moment hull condition is a known object with a name and a proof template: it is the convexity of the moment-map image, and the closest-point-of-the-hull functional is the sharp bound that convexity gives.** The paper is a citation for the frame and for the fact that the linear system in the squares and the hull are one statement. Its group is $\mathrm{GL}_n$ acting on brackets and its weights are $\alpha^k_{ij}=E_{kk}-E_{ii}-E_{jj}$; the record's row measures $\mu_a$ are indexed by a single eigenvector $\varphi_a$ of $W$ and average functions of the eigenvalues $\lambda_b,\lambda_c$ rather than torus weights, so the transfer is of the frame and the proof template, and the identification of a group action whose moment map is the record's per-row system is owed before any theorem here is cited as covering $\mathcal W_n$. It contains no bound on $\theta$ and no statement about Weyl tensors.
