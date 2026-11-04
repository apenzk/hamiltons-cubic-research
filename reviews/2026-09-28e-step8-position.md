# Step 8 position, 2026-09-28e: a method for the visible cubic at I121's small-mass node

*The fourth sweep of the day on [I121](../plan.md), aimed by the manager's decision at $\theta\le\sqrt{3/2}$ (for $n\ge14$, $\theta<\theta_0$) at small maximal-frame mass, attacked directly. The [direct-attack note](2026-09-28d-I121-smallmass-direct.md) reduced that node to one quantity, and this sweep looks for a method for it.*

## Where the node stands

- **The reduction** (Gate 2 [r1849](REVIEW_r1849.md), [r1850](REVIEW_r1850.md)): $E=P-\tfrac32\mathop{\mathrm{tr}}W^3$ is $O(n)$-invariant and $\theta^2\le\tfrac32+\theta E$ at every unit critical point, so $\theta\ge\theta_0$ forces $E\ge\varepsilon_n$ ($0.073$ at $n=14$, tending to $0.354$). At $n=12$, $\mathbb{CP}^6$ has $E>\varepsilon_{12}$, and [L254](../findings/sym3-stability.md) stands in there.
- **In a globally maximal frame at pair-free $W$**, $E$ is the diagonal term ($O(t^3)$), a coupling ($O(\sqrt n\,t^2)$) and **the visible cubic $24T(X)$**, a weighted triangle sum on the Kneser graph $KG(n,2)$ whose maximum cliques are the perfect matchings. The matching inequality caps each clique's $\ell^2$ mass by $t^2$. The pair part adds terms of order $\sqrt n\,t$, their exact form partly derived.
- **The crux**: the visible cubic's bound under the matching family is of order $nt$, and screens show the matching family alone allows it to be of order one at $t^2\approx0.45/n$. Those screened tensors are $B_f$ alone, not critical, and at $t=0$ in their frame. With a diagonal restored they keep $t_{\max}^2\ge0.2$. So full frame maximality, criticality, or both must enter.
- **The frame-free target**: $E\lesssim C\,t_{\max}$ at critical points, calibrated by products ($E\approx\theta_0$, $t_{\max}=1$), sums of $k\ll\dim\mathcal W_n$ products, and $\mathbb{CP}^m$ ($E\to0$).

## Fence posts and closed routes bearing on the crux

- **R24's successor criterion**: an average over frames cannot beat an average. A Haar-average identity for $E$ with one diagonal slot loses a factor growing with $n$.
- **[Post F81](../findings/fence-posts.md)**: the maximiser in a non-maximal frame. Any argument must use enough frame maximality to exclude it, and the matching inequality does ($E(M_0)=1-t^2$).
- **R6 and [post F22](../findings/fence-posts.md)**: separating a maximiser from obstructed points needs the value. The $\mathbb{CP}^m$ sit at small mass, cleared by value.

## What previous sweeps covered

- [2026-09-28](2026-09-28-LIT-step8-sweep.md): the nonclosed branch, R53, R54.
- [2026-09-28b](2026-09-28b-LIT-step8-sweep.md): the small-mass node, the pair identity, the matching inequality, visibility.
- [2026-09-28c](2026-09-28c-LIT-step8-sweep.md): classification (R6), the matching family's strength.
- Stored and screened for frame maximality: [Li–Usevich–Comon](../references/li-usevich-comon-2018-maximally-diagonal/README.md) (nothing on the global maximum), [Jin](../references/jin-2026-l4-norm-orthogonal-group/README.md) (a different objective).

## Candidates to screen

1. **Stability of the diagonal mass near a critical point of $P$**: does criticality plus $E\ge\varepsilon$ force a spectral structure (positive eigenspaces close to a subalgebra) that yields a frame? A subalgebra-stability route through the $\#$ part, $\langle W^\#,W\rangle=\tfrac12\sum\lambda_k\lambda_l\lambda_mc_{klm}^2$.
2. **Extremal combinatorics of weighted triangle counts under clique constraints** (Kneser graphs, Turán-type and Kruskal–Katona-type bounds), with the Bianchi relation as extra structure.
3. **The block equations** of criticality in $(X,J)$ coordinates, which the screens left unused.
