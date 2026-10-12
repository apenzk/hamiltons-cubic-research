# Step 8 position, 2026-09-28f: the range between the uniform threshold and the product step

*The fifth sweep of the day on [I121](../plan.md). The small-mass node is split: settled below a uniform threshold, open above it. This sweep looks for a route for the open part.*

## Where the node stands

- **Settled below the threshold** ([note](2026-09-28d-I121-smallmass-direct.md), Gate 2 [r1861](REVIEW_r1861.md)): $E=P-\tfrac32\operatorname{tr}M^3=-\tfrac12p_3(\omega)\le\tfrac32\mu\le\tfrac32\sqrt{2(n-2)/(n-1)}\,t_{\max}$ on every unit Weyl tensor, so a critical point at $\theta\ge\theta_0$ has $t_{\max}^2\ge\tfrac29\tfrac n{n-1}\varepsilon_n^2\to\tfrac1{36}$. Every step is on the record ([L50](../findings/bispectral.md), the one-line bound, the frame cap); the pairing at $t_{\max}$ is new.
- **Settled at a balanced-product diagonal part for even $n\ge26$**, by R53's dichotomy and that threshold ([SecondKindBalanced.lean](../lean/HamiltonsCubic/Results/SecondKindBalanced.lean)).
- **Open**: every global maximiser with $t_{\max}^2$ above the threshold whose diagonal part is not product-proportional, and product-proportional ones below R53's reach ($n<26$ balanced, unbalanced products at the $c_*/(d-c_*)$ of their own). This holds the $\mathbb{CP}^m$ at $t^2=\tfrac3{n+2}$.
- **Why the $E$ route stops**: its two losses are $\theta\,p_3(\lambda)\le1$ and $-\tfrac12p_3(\omega)\le\tfrac32\mu$. Frame-free the order in $t_{\max}$ is linear, fixed by the product ($E/t_{\max}\approx\theta_0$), so any further gain uses criticality or maximality beyond $\theta^2\le\tfrac32+\theta E$.

## Fence posts and closed routes bearing on it

- **[Post F26](../findings/INDEX-traps.md)**: one-sided improvement on the second-kind cubic cannot close, since $\tfrac32\max p_3(\mu)=1.4657>\theta_0(12)$. *A route must bound the $\Lambda^2$ cubic too.*
- **[Post F33](../findings/fence-posts.md)**: the moment bound on the two spectra, which the shared-frame coupling does not beat away from the diagonal family.
- **[Post F67](../findings/fence-posts.md)**: $r$ and $p$ cannot be bounded separately in R54's circle.
- **[Post F81](../findings/fence-posts.md)**: sector structure without the maximal frame proves nothing down to $t^2=\tfrac1n$.
- **R24's successor criterion**: a Haar average loses a factor growing with $n$.
- **target.md's lift** ([target.md](../findings/target.md), ELIM-target): the critical equation lifted to $S^2_0$ at the bottom eigenvector cancels to the $W^2$ bound it started from; the content is the defect $(W^2)^\circ-(\mathring W)^2$.

## What previous sweeps covered

- [2026-09-28](2026-09-28-LIT-step8-sweep.md): the nonclosed branch, R53, R54.
- [2026-09-28b](2026-09-28b-LIT-step8-sweep.md): the small-mass node, the pair identity, the matching inequality.
- [2026-09-28c](2026-09-28c-LIT-step8-sweep.md): classification, the matching family's strength.
- [2026-09-28e](2026-09-28e-LIT-step8-sweep.md): Kneser triangle counts (nothing found), the $\#$ route through L260 and I117, the block equations (closed), the duality gauge, polarity (negative on the record).

## Candidates to screen

1. **Maximality with second-kind test directions.** At the global maximiser the Hessian bound $T(W,V,V)\le\tfrac\theta2(\lVert V\rVert^2+\langle V,W\rangle^2)$ holds for every $V$. Take $V$ the Weyl projection of $\Lambda^2h$, $h$ the bottom eigenvector of $\mathring W$, which pairs with $W$ as $\mu/2$ and so is large exactly where the threshold says it is. *What it would give: a relation between $\theta$ and $\mu$ beyond $\theta^2\le\tfrac32+\tfrac32\theta\mu$, toward target.md's branch 1.*
2. **The $\Lambda^2$ loss.** $\theta p_3(\lambda)\le1$ is tight only when the positive spectrum sits at $1/\theta$ with multiplicity about $\theta^2$. The Ricci condition $\sum_k\lambda_k\varphi_k^2=0$ forces a negative part to balance it. *What it would give: $p_3(\lambda)\le c<1/\theta_0$ for Weyl tensors, or at least in terms of $t_{\max}$ and $\mu$.*
3. **R53's knapsack at a general diagonal part, with the threshold as input.** The four closed attempts at a general diagonal part failed at small mass, which is now excluded. *What it would give: (MG) for general diagonal parts above the threshold, if the frame inequalities bound the high modes once $t$ is bounded below.*
