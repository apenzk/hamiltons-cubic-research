# Step 8 position, 2026-09-27c: a method for I73's asymmetric three-value spectra and for (b)

*The user's priority from 2026-09-27: one method-finding cycle for the two parts of [I73](../plan.md) with no method, ending in a ranked proposal registered in [routes.md](../routes.md). I117 is secondary.*

## What the sweep is for

[I73](../plan.md): a global maximiser $W$ of $P(W)=\langle W^\#,W\rangle$ on the unit sphere of $\mathcal W_n$ has a two-value spectrum, and [L105](../findings/bounds-relaxations.md) closes P from there. Its sub-steps are [R33](../routes.md)'s:

- (a) the eigenspace-pair second-order test at sphere products, settled;
- (b) the same test at [F39](../findings/fence-posts.md)'s saddle, silent: every pair direction stays at or below $\tfrac12$ while the point is unstable, the destabilising direction lying outside every eigenspace-pair span;
- (c) three values above $\theta_0(n)$: the symmetric family is [I114](../plan.md), blocked on H and worked as I117; **the asymmetric spectra have no route at any $n$**.

## The fence posts that bear on a new route

| post | what it closes |
|---|---|
| [F11](../findings/second-order.md) | using the size of the sharp term alone |
| [F38](../findings/fence-posts.md) | separating equivariant from non-equivariant graded points by a mass on $\mathfrak p$ (the mass depends on the grading) |
| [F39](../findings/fence-posts.md) | the seven Hessian-drawn test directions, the $\mathfrak p$-internal cross-block the last; a successor must exhibit an admissible direction $\perp W$ with quotient $>\tfrac12$ *because* $\Delta>0$ |
| [F76](../findings/fence-posts.md) | the class-level summed pair test at three values ([L173](../findings/bounds-relaxations.md)'s witness satisfies it exactly) |
| [F77](../findings/fence-posts.md) | the per-eigenspace per-vector rows at all $n$ (a star eigenspace passes at every $n\ge19$) |
| [F78](../findings/fence-posts.md) | the joint trace-over-rank certificate ([L247](../findings/second-order.md)) below $\kappa=n-5$ |
| [F79](../findings/fence-posts.md) | Bianchi used only through its class averages |

## What earlier sweeps covered

The three step-9 sweeps of 2026-09-25 ([round 1](2026-09-25-LIT-step9-sweep.md), [round 2](2026-09-25-LIT-step9-sweep-round2.md), [round 3](2026-09-25-LIT-step9-sweep-round3.md)) searched curvature operators with few eigenvalues, realisability of prescribed eigenspaces, isotropy as a moment map, eigenvalue inequalities for $R^\#$, critical points of cubic Weyl invariants, realisability of squared structure constants, near-rank-two spaces of skew matrices, Weyl tensors with $W^2\propto\mathrm{Id}$, and all-dimension spectral bounds at critical points of the cubic. They ended at R38 to R40 and recorded that the asymmetric majority of (c) has no route. The references already hold Tkachev (universality of $\tfrac12$, spectral theory of nonassociative algebras, Clifford-type extremals), Krasnov–Tkachev, Fox (the nonassociative curvature algebra, sectional nonassociativity), Böhm–Wilking and Wilking's cones.

**Every closed attempt draws its test from second-order optimality**, the Hessian at $W$, and (b) shows that data blind at a saddle. The one mechanism on file that is not second order is the reflection inequality in [F39](../findings/fence-posts.md)'s audit paragraph, which the record carries only as an unaudited outside report.

## The candidate this sweep starts from: global comparison along fixed-point splittings

$Q$ is $O(n)$-equivariant, so for every closed subgroup $H\subseteq O(n)$ the fixed space $\mathcal W_n^H$ is closed under $Q$. Write $W=D+F$ with $D=\Pi_HW$. Then $\langle Q(D),F\rangle=0$, so $P(D,D,F)=0$, and along $W_t=D+tF$
$$P(W_t)=P(D)+3t^2P(D,F,F)+t^3P(F),$$
with criticality giving $P(D)+P(D,F,F)=\theta\lVert D\rVert^2$ and $2P(D,F,F)+P(F)=\theta\lVert F\rVert^2$. **At a global maximiser $P(W_t)/\lVert W_t\rVert^3\le\theta$ for every real $t$**, a one-variable family of inequalities for every $H$, of which $t=-1$ is the reflection ($P(F)\ge0$) and $t\to1$ is second order along $F$. At a saddle these fail for some $H$ and $t$ whenever the ascent direction has an $H$-structure, which is the tool (b) lacks, and they do not care whether the spectrum is symmetric, which is what the asymmetric part of (c) lacks.

**What the sweep must decide about it**: whether the inequalities say anything at a three-value point that the second-order rows do not; which subgroups $H$ are natural for a three-value $W$ (the stabilisers of its eigenspaces, the splittings its eigenspaces induce on $\mathbb R^n$); and whether the literature on symmetrisation for maximisers of homogeneous forms (polarisation, two-point symmetrisation) supplies the right $H$.
