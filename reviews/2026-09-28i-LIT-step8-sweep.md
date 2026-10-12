# Step 9 sweep, 2026-09-28i: the goal, with every section 1 item route-less

*Position file: [2026-09-28i-step8-position.md](2026-09-28i-step8-position.md).*

## Batch 1: the literature against the position file's three questions (record)

- **Question 1, a comparison principle for invariant cubics.** Searched *symmetrisation does not decrease a cubic invariant on a representation sphere*. The returns are function-space symmetrisation on $S^n$ ([arXiv:2507.13027](https://arxiv.org/abs/2507.13027)) and [Ivanova–Hildebrand](../references/ivanova-hildebrand-2021-extremal-cubics/README.md)'s extremal cubics on $S^1$ and $S^2$, filed. **Nothing for a module sphere.** [R24](../routes.md) already records that a Haar average loses a factor growing with $n$.
- **Question 2, the pinching constant.** Searched *sharp constant, Weyl curvature pinching, cubic term*. [Branca–Kroencke 2025](https://arxiv.org/abs/2506.13248) states $Q\le C(n)\lvert W\rvert^3$ with Huisken's and Tran's constants ($C(4)=\tfrac{\sqrt6}4$, $C(5)=\tfrac4{\sqrt{10}}$, a Cauchy–Schwarz constant above $2$ from $n\ge8$) and claims no sharpness. **Nothing beyond [28g](2026-09-28g-LIT-step8-sweep.md)'s batch 2.**
- **Question 3, Hamilton's ODE.** The normalised flow of $\dot W=Q(W)$ on the unit sphere is the gradient flow of $\tfrac13P$, so the maximiser is its attractor and no comparison beyond maximality arises. Searched *fastest blow-up of Hamilton's curvature ODE*: nothing.

## Batch 2: the record's items, read for a method (derived)

- **[I122](../plan.md)'s open step is one Lie-theoretic statement.** By the [audit note](2026-09-28-I121-MG-audit.md)'s steps 1 to 3 (Gate 2 [r1818](REVIEW_r1818.md), [r1819](REVIEW_r1819.md)), $\sup\langle G^\#,G\rangle$ over positive unit $G$ on $\mathfrak{so}(m)$ is attained at a positive $G$ with $G^\#=\lambda G$ and full range on one simple subalgebra $\mathfrak h$, and the table gives $\max\{\tfrac2{\sqrt3},\tfrac{m-2}{\sqrt{\binom m2}}\}$ if that $G$ is scalar. **Step 4, open: a positive definite $G$ on a simple $\mathfrak h$ with $G^\#=\lambda G$ is scalar.** The argument needs only $\le1.59$, against the table's $<\sqrt2$.
- **What criticality gives on step 4.** In $G$'s eigenbasis $A_k$, eigenvalues $s_k>0$, with $c_{ijk}=\langle[A_i,A_j],A_k\rangle$ totally antisymmetric and Casimir rows $\sum_{ij}c_{ijk}^2=C$, the equation is the row system $\sum_{ij}s_is_jc_{ijk}^2=2\lambda s_k$. Dividing row $k$ by $s_k$ and summing, then symmetrising over the three indices with $\tfrac{ab}c+\tfrac{bc}a+\tfrac{ca}b\ge a+b+c$, $$2\lambda\dim\mathfrak h=\sum_{ijk}\frac{s_is_j}{s_k}c_{ijk}^2\ \ge\ C\sum_ks_k,$$ with equality exactly when $s$ is constant on every triple with $c_{ijk}\ne0$, hence scalar on a simple $\mathfrak h$. *So step 4 is the reverse inequality at such a $G$.* In the metric $g'=\langle G^{-1}\cdot,\cdot\rangle$ the equation reads $\beta\beta^*=2\lambda I$ for the bracket $\beta:\Lambda^2\mathfrak h\to\mathfrak h$, a tight-frame condition on the brackets of a $g'$-orthonormal basis.
- **Two families checked by hand, both forced scalar.** On a symmetric pair $\mathfrak h=\mathfrak k\oplus\mathfrak p$ with $G=aP_{\mathfrak k}+bP_{\mathfrak p}$, the $\mathfrak p$ row gives $\lambda=\tfrac{aC}2$ and the $\mathfrak k$ row then $b^2=a^2$. On $\mathfrak{su}(3)$ with weights constant on the Cartan and on each root plane, the root rows force equal root weights and the Cartan row then forces the Cartan weight to match.

## Phase 3b, the routes

| route | closes | attackable | margin | analytic | value | how close to P |
|---|---|---|---|---|---|---|
| **[I122](../plan.md) step 4**, positive sharp-eigenoperators on a simple $\mathfrak h$ are scalar | 2 | 2 | 1 | 1 | **4** | empties I121's balanced closed branch at every $m\ge6$ through the recorded endpoint criterion; I121's band stays blocked |
| [I73](../plan.md)'s asymmetric spectra | 3 | 1 | 1 | 1 | **3** | P with L105, but no method |
| [I117](../plan.md) and [I115](../plan.md), statement H | 2 | 1 | 1 | 1 | **2** | the sharp $\#$ half of P |

**Pick: I122 step 4.** It is the only item on the list whose open step is one named statement with a partial argument in hand: the reduction is proved, criticality supplies one direction of the needed equality, and every family tried closes by hand. *It reaches a named step of (MG) rather than P, and says so.* **Abandon when** a positive non-scalar $G$ with $G^\#=\lambda G$ and full range on a simple $\mathfrak h$ is exhibited, which would reopen the table's value.

**Closed the same cycle** ([note](2026-09-28j-I122-step4.md)): $\mathfrak{su}(3)\subset\mathfrak g_2$ gives a positive full-range non-scalar sharp-eigenoperator, R55's abandon condition. I122's supremum stands and needs maximality, and [I73](../plan.md) is top again.

**A screening failure.** *The pick's open step is [L260](../findings/second-order.md)'s U, which [L263](../findings/second-order.md) had refuted ([F80](../findings/fence-posts.md)), and I122's supremum is statement H itself by L260 (1).* Phase 3a searched the record by this sweep's word, sharp-eigenoperator, where the record says $\#$-idempotent. I122 is deleted as a duplicate of [I117](../plan.md).
