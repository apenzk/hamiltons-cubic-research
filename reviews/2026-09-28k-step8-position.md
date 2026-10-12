# Step 9 position, 2026-09-28k: a route for I73's asymmetric spectra and case (b)

*By the manager's decision of 2026-09-28j: [I73](../plan.md) is the cycle's item, and its route is invented by a sweep aimed at its two parts with no method, starting from [SecondKindE](../lean/HamiltonsCubic/Results/SecondKindE.lean) and [L50](../findings/bispectral.md)'s bispectral identity. [I121](../plan.md#blocked) and I122 under it are blocked.*

## The item

A global maximiser of $P$ on the unit sphere of $\mathcal W_n$ has a two-value spectrum on $\Lambda^2$, and [L105](../findings/bounds-relaxations.md) (in Lean) gives $\theta\le\theta_0(n)$ from there. Its parts ([R33](../routes.md)):

- (a) the eigenspace-pair second-order test at sphere products, settled;
- (b) the same test at [F39](../findings/fence-posts.md)'s saddle, silent, the destabilising direction lying outside every eigenspace-pair span;
- (c) three or more values above $\theta_0(n)$: the symmetric family is [I114](../plan.md#blocked), blocked on statement H; **the asymmetric spectra have no route**.

## Fence posts bearing on it

[F11](../findings/second-order.md) (the sharp term's size alone), [F38](../findings/fence-posts.md) (a mass on $\mathfrak p$), [F39](../findings/fence-posts.md) (seven Hessian-drawn directions), [F76](../findings/fence-posts.md) (the class-level summed pair test, [L173](../findings/bounds-relaxations.md)'s witness), [F77](../findings/fence-posts.md) (per-vector rows at all $n$), [F78](../findings/fence-posts.md) (the trace-over-rank certificate below $\kappa=n-5$), [F79](../findings/fence-posts.md) (Bianchi through class averages), [F73](../findings/INDEX-traps.md) (no local-to-global theorem).

## What previous sweeps covered

The three step 9 sweeps of 2026-09-25 ([1](2026-09-25-LIT-step9-sweep.md), [2](2026-09-25-LIT-step9-sweep-round2.md), [3](2026-09-25-LIT-step9-sweep-round3.md)): curvature operators with few eigenvalues, realisability of prescribed eigenspaces, isotropy as a moment map, eigenvalue inequalities for $R^\#$, critical points of cubic Weyl invariants, squared structure constants, near-rank-two spaces of skew matrices, $W^2\propto\mathrm{Id}$, all-dimension spectral bounds. [2026-09-27c](2026-09-27c-LIT-step8-sweep.md): global comparison along fixed-point splittings ([R51](../routes.md), a correct lemma with no path), and the recommendation to attack (MG) instead, now blocked. [2026-09-28i](2026-09-28i-LIT-step8-sweep.md): the goal, nothing new.

## Questions for this sweep

1. **The manager's angle.** Do $\theta=\tfrac32p_3(\lambda)+E$ (L50) and $E\le C_nt_{\max}$ (SecondKindE), or trace positivity $E\le\tfrac32\mu$, separate spectra by their number of values?
2. **A value-reading mechanism for (c).** Which inequality at a three-value critical point reads $\theta\ge\theta_0$, rather than holding at every critical point?
3. **Case (b) through a global comparison.** Does any comparison beyond second order see the saddle's ascent direction?
