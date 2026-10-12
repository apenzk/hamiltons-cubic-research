# Step 8 sweep, 2026-09-28h: questioning the band's approach

*Position file: [2026-09-28h-step8-position.md](2026-09-28h-step8-position.md). Four closures in [2026-09-28g](2026-09-28g-LIT-step8-sweep.md), so this sweep asks whether any approach confined to the band can read the value.*

## Batch 1: the record, against the position file's two questions (derived)

- **Padded $W_{\mathbb{CP}^2}$ lies in the band.** With the self-dual forms $s_0=(e_{01}+e_{23})/\sqrt2$, $s_1=(e_{02}-e_{13})/\sqrt2$, $s_2=(e_{03}+e_{12})/\sqrt2$, the tensor $(2s_0\otimes s_0-s_1\otimes s_1-s_2\otimes s_2)/\sqrt6$ has diagonal part $(1,1,-\tfrac12,-\tfrac12,-\tfrac12,-\tfrac12)/\sqrt6$ on the six pairs of four indices, Ricci-flat and Bianchi on its own, so $t_{\max}^2\ge\tfrac12$ at every $n$. That diagonal pattern is padded $S^2\times S^2$'s, a product of spheres on four of the $n$ indices and a product-proportional diagonal part at no $n\ge5$. **So the open region holds a second-order-critical point at $\sqrt{3/2}<\theta_0(n)$** ([post F73](../findings/INDEX-traps.md)), and an argument using criticality and the second-order condition alone, confined to the band, cannot exclude it. Question 1 is answered no. **Fifth closure of this round.**
- **$\Sigma_4\ge0$ at critical points has no mechanism.** The critical equation is the Weyl projection of $W^2+W^\#$, which satisfies first Bianchi by Hamilton's identity, so it carries no $\Lambda^4$ component and says nothing about $\mathrm{Alt}(W^2)$ beyond $\mathrm{Alt}(W^\#)=-\mathrm{Alt}(W^2)$, which holds at every Weyl tensor. And $\Sigma_4=\tfrac14\lVert N\rVert_F^2-S_{22}$ with $S_{22}$ free on the critical locus ([bounds.md](../findings/bounds.md)). It is also saturated at padded $W_{\mathbb{CP}^2}$, a family wider than the goal's equality set, and it fails at a critical point with $\theta=0$ ([r1871](REVIEW_r1871.md), [r1872](REVIEW_r1872.md)), so any proof needs $\theta>0$. Screened out, and counted with the index split rather than separately.
- **Question 2, a comparison reading $\theta\ge\theta_0$.** The record's comparisons with the product are [R17](../routes.md)'s lifted Jäger chain ($P\le\theta_0+\kappa_n\delta^2$, owing its grant and a two-regime comparison) and R53's dichotomy (product-proportional diagonal parts only). Neither is scoped to the band, and no monotone transport toward the product is named anywhere on the record.

## Batch 2: the literature (record)

- Searched *maximum of cubic invariant on sphere of algebraic curvature tensors, symmetric space maximiser*, *global maximum of Hamilton's reaction term on Weyl tensors, products of spheres*, and *maximising a cubic form over an orbit, norm of the diagonal projection, moment map convexity*. The returns are [Deninger–Grundhöfer–Kramer 2023](../references/deninger-grundhoefer-kramer-2023-srg-quadratic/README.md) and [Nienhaus 2023](../references/nienhaus-2023-second-best-einstein/README.md), both filed, and Kostant and Schur–Horn convexity, which [bispectral.md](../findings/bispectral.md) already uses as $\omega\succ d$. **Nothing new.**

## Phase 3b, the routes for the band

| route | closes | attackable | margin | analytic | value | how close to P |
|---|---|---|---|---|---|---|
| $\Sigma_4\ge0$ at critical points, reviving the split | 1 | 0 | 0 | 1 | **0** | clears index-spread tensors from $n=30$ and leaves the concentrated node |
| second-order separation inside the band | 2 | 0 | 1 | 1 | **0** | padded $W_{\mathbb{CP}^2}$ sits in the band as a local maximum below $\theta_0$ |
| a $P$-monotone transport to the product | 2 | 1 | 1 | 1 | **2** | would read $\theta\ge\theta_0$ directly, but no mechanism is named |

**The churn cap fires.** Five candidates on I121's band have closed this round (the lift dichotomy, the literature, $\lambda_{\max}(N)\le\tfrac14\operatorname{tr}N$, the index split, second-order separation in the band) with no standing derivation advancing I121 between them, the index split's derivation having been refuted at its index step. **So I121 moves to BLOCKED, and the work goes to [I73](../plan.md), the manager's named fallback**, the highest-graded section 1 item that does not stand on I121. *Its asymmetric spectra have no method ([2026-09-27c sweep](2026-09-27c-LIT-step8-sweep.md)), so its next action is inventing a route there.* The obstruction is recorded in [findings/INDEX.md](../findings/INDEX.md).
