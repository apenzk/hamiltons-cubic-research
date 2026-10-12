# Step 8 position, 2026-09-28b: small maximal-frame diagonal mass, the node every general attempt at (MG) failed on

*The user's decision of 2026-09-28, relayed by the manager: keep [I122](../plan.md) and the product step parked, and aim the cycle at small maximal-frame diagonal mass, for a bound there or a falsifier for (MG) there. The first sweep of the day is [2026-09-28-LIT-step8-sweep.md](2026-09-28-LIT-step8-sweep.md), whose four attempts at a general diagonal part all fail when $t$ is small.*

## The node, exactly

At a unit global maximiser $W$ at even $n\ge12$, $\rho=\Theta_n\ge\theta_0(n)>\sqrt{3/2}$, in a frame globally maximising $\lVert\pi_{\mathcal D}W\rVert^2=t^2$. **(MG) there says $P(A/t)=\rho$**, the best diagonal view is itself a maximiser ([R54](../routes.md), Gate 2 [r1821](REVIEW_r1821.md), [r1822](REVIEW_r1822.md)). The node is the regime $t\le t_*$, with $t_*$ where the frame's budgets stop capping anything, of order $n^{-1/2}$ for concentrated diagonal parts.

**Two readings of the same node.**
- **As a lower bound**: a global maximiser has $t\ge t_0$, with $t_0$ above the range where the joint bound fails. Then (MG) needs only the large-$t$ regime.
- **As the programme's open statement**: small $t$ caps every sectional curvature, $\lvert K(\sigma)\rvert\le t$, and the catalogued small-$t$ critical points, the $\mathbb{CP}^m$ family at $t^2=\tfrac3{n+2}$, sit below $\sqrt{3/2}$ ($1.054$ at $n=6$, $0.986$ at $n=8$), where (MG) holds by its first branch. **So the node is "$\theta\le\sqrt{3/2}$ at critical points far from diagonal"**, the plan's remaining open statement ([batch 1](2026-09-28-LIT-step8-sweep.md)) restricted to small maximal-frame mass. *A falsifier for (MG) there is a global maximiser far from diagonal, which is a counterexample to Conjecture A of non-diagonal type.*

## Known at small $t$

| fact | source |
|---|---|
| $t^2\ge\tfrac6{(n+1)(n+2)}$, the $O(n)$ average | Schur on the irreducible $\mathcal W_n$ ([sweep](2026-09-28-LIT-step8-sweep.md)) |
| $\rho=tp+\tfrac{b^2}tr$, $q=P(\nu)=(\rho-2tr)/b$, $r\ge\tfrac{\rho t}2$ | [L214](../findings/second-order.md), in circle coordinates ([R54](../routes.md)) |
| so at small $t$, $W\approx\nu$ with $P(\nu)\approx\rho$ and $\nu\perp\mathcal D_n$ | the same |
| $\lvert K(\sigma)\rvert\le t$ for every plane $\sigma$, since one plane is one diagonal entry of some frame | direct |
| every catalogued $\theta>\sqrt{3/2}$ is a sphere product, so has $t=1$ | [INDEX-values.md](../findings/INDEX-values.md), batch 1 |

## Screened already, dead

- **Averaging identities.** Writing $P$ as an average over frames of a diagonal cubic, or over 3-planes as in [L118](../findings/curvature-invariants.md) ($144\theta=\mathbb E[N^3]+10\,\mathbb E[NNN]$), bounds $t^3\ge P/K$ with $K$ the cubic's maximum on unit arguments. At the balanced product each random frame sees $O(1/n)$ of the curvature, so $K$ is at least of order $n^3$ and the frame bound is at best $t\gtrsim n^{-1}$, Schur's order, and a random 3-plane sees $O(n^{-2})$, so that bound is at best $t\gtrsim n^{-2}$ ([r1827](REVIEW_r1827.md), [r1828](REVIEW_r1828.md)). *This is [R24](../routes.md)'s successor criterion: an average cannot beat an average.*
- **Sectional-curvature moments.** $\lvert K\rvert\le t$ in L118's moments gives $\theta\lesssim c_nt^3+\Phi\lesssim n^6t^3$, so $t\gtrsim n^{-2}$, weaker than Schur ([r1827](REVIEW_r1827.md), [r1828](REVIEW_r1828.md)).

## Fence posts bearing on the node

| post | what it closes |
|---|---|
| [F67](../findings/fence-posts.md) | bounding $P(d)$ and $\langle L_d\nu,\nu\rangle$ separately |
| [F38](../findings/fence-posts.md) | mass on $\mathfrak p$ across arbitrary gradings |
| [F20](../findings/curvature-invariants.md) | $\theta$ is not the single-plane third moment |
| [R24](../routes.md)'s criterion, [R51](../routes.md)'s screen | a lower bound on diagonal mass independent of $\theta$, or of Schur's order, never beats $\theta_0$ |

## What the sweep must decide

1. **What the record already proves about $\theta\le\sqrt{3/2}$ on non-diagonal classes** (pure and non-pure critical points, Kähler-type and symmetric-space families, [I5](../plan.md), [I18](../plan.md)), and whether any of it is phrased by a quantity that small $t$ controls.
2. **A maximality mechanism** (global maximality or L24's cap, which averages cannot supply) that forces diagonal mass up when $P$ is above $\sqrt{3/2}$.
3. **Whether a bounded falsifier screen is worth its cost**: critical points with small maximal-frame mass and $\theta>\sqrt{3/2}$, seeded from the far-from-diagonal families, not an open-ended hunt.
