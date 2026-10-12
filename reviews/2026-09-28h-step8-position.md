# Step 8 position, 2026-09-28h: the band after four closures, questioning the approach

*The sixth sweep of the day on [I121](../plan.md), by the churn rule's three-closure clause: the [2026-09-28g sweep](2026-09-28g-LIT-step8-sweep.md) closed four candidates on the band, so this sweep questions the approach rather than drawing its next row. The manager's decision of 2026-09-28 keeps the work on the band, from the uniform threshold $t_{\max}^2\ge\tfrac29\tfrac{n-1}{n-2}\varepsilon_n^2$ to the parked product step. A fifth closure redirects to [I73](../plan.md).*

## Where the node stands

- **Settled below the threshold** ([note](2026-09-28d-I121-smallmass-direct.md), Gate 2 [r1861](REVIEW_r1861.md), [r1865](REVIEW_r1865.md)): $E\le\tfrac32\sqrt{2(n-2)/(n-1)}\,t_{\max}$ on every unit Weyl tensor, in Lean.
- **Settled at a balanced-product diagonal part for even $n\ge26$** (R53 with the threshold, in Lean).
- **Open**: the band, holding the $\mathbb{CP}^m$ at $t_{\max}^2=\tfrac3{n+2}$, which only their value clears.

## The four closures of 2026-09-28g, and what they share

| candidate | what closed it | the tensor that beats it |
|---|---|---|
| a bound on target.md's lift $\Phi=\mu(\theta-\mu)$ | clears the band only at $n\gtrsim68$ | $\mathbb{CP}^m$, $\Phi\sim\tfrac1m$ on the small branch |
| the literature on the cubic | no value-sensitive estimate at moderate frame mass | |
| $\lambda_{\max}(N)\le\tfrac14\operatorname{tr}N$ | false, $0.352$ at $n=6$ | Weyl tensors found by ascent |
| the index step $\operatorname{tr}(W^2\#W^2)\le\tfrac18\lVert N\rVert_F^2$ | false from $n=5$, exactly $\Sigma_4\ge0$ | Weyl tensors, $\Sigma_4/\operatorname{tr}W^4=-\tfrac23$ at $n=6$ at a critical point with $\theta=0$ |

**What they share**: each is an inequality on critical points (or on all Weyl tensors) that never reads $\theta\ge\theta_0$. The $E$ route's three losses are exact or near-exact on the $\mathbb{CP}^m$, whose $\theta$ sits below $\theta_0$, so any inequality true at the $\mathbb{CP}^m$ and linear in the route's quantities stops at their scale. [28f](2026-09-28f-LIT-step8-sweep.md)'s three closures (maximality along $Z(h)$, R53's knapsack above the threshold, the $\Lambda^2$ loss) have the same shape.

## Fence posts bearing on a change of approach

- **[Post F73](../findings/INDEX-traps.md)**: no local-to-global theorem for forms on spheres applies to $P$, since padded $W_{\mathbb{CP}^2}$ is a second-order-critical point at $\sqrt{3/2}<\theta_0(n)$. *A second-order argument must separate the maximiser from the local maxima below $\theta_0$ by where they sit, not by their Hessian sign alone.*
- **[Post F37](../findings/fence-posts.md)**: third and fourth variation calculus is vacuous until the excess is consumed.
- **[Post F26](../findings/INDEX-traps.md)**, **[F33](../findings/fence-posts.md)**, **[F67](../findings/fence-posts.md)**, **[F81](../findings/fence-posts.md)** as in [28f](2026-09-28f-step8-position.md).

## What previous sweeps covered

[2026-09-28](2026-09-28-LIT-step8-sweep.md) to [2026-09-28g](2026-09-28g-LIT-step8-sweep.md): the nonclosed branch, R53, R54, the small-mass node, the matching family, Kneser triangle counts, the $\#$ route, the block equations, the duality gauge, polarity, target.md's lift, maximality along $Z(h)$, the knapsack above the threshold, the literature on the cubic estimate, and the index concentration.

## Questions for this sweep

1. **Does the band contain any second-order-critical point other than the maximisers?** If every local maximum below $\theta_0$ has $t_{\max}$ outside the band (padded $W_{\mathbb{CP}^2}$ is concentrated on four indices), then a second-order argument restricted to the band escapes F73, and the $\mathbb{CP}^m$ ($m\ge3$) are cleared by an ascent direction rather than by their value.
2. **Is the value readable through a comparison rather than an estimate?** $\theta\ge\theta_0$ is a comparison with the product. A route that transports the maximiser toward the product (a path along which $P$ is monotone, or a symmetrisation that does not lower $P$) reads the value without estimating it.
3. **What does the literature on cubic forms on spheres, and on spectral extremal problems with symmetric-space maximisers, do in the intermediate regime?**
