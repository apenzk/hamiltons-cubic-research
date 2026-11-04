# Step 9 position, 2026-09-25: a route for I73's sub-step (c) beyond the linear class-level system

## The statement a route must reach

[I73](../plan.md): a unit maximiser of $P$ on $\mathcal W_n$, $n\ge12$, has a two-value spectrum, after which [L105](../findings/bounds-relaxations.md) finishes Problem P. Sub-step (c) is the three-value case: **no critical point with exactly three eigenvalues has $\theta>\sqrt{3/2}$**. Grade $3=3\times1\times1\times1$, `attackable` $1$ since 2026-09-25.

## What the record has on (c)

- **The class-level system** in $(e,m,\tau_{abc},G_{12})$: the per-index rows ([L104](../findings/bounds-relaxations.md)), $\tau\ge0$, the pair caps ([L31](../findings/stratum-two-negative.md)), the Ky Fan caps ([L237](../findings/second-order.md)), the seven-frame cap ([L240](../findings/second-order.md), $T_7\le54.064$), the Gram constraints, section 5's per-pair inequalities and L235's window ([the summed-pair note](2026-09-23-I73c-summed-pairs.md)).
- **It is closed as a route.** [L173](../findings/bounds-relaxations.md)'s ray is closed by L240, but off the ray [L241](../findings/bounds-relaxations.md) is an exact witness at $n=12$, $e=(-\tfrac15,0,\tfrac15)$, multiplicities $(7,52,7)$, $\theta=5/\sqrt{14}$; and on a screen, 190 of 2080 triples at $n=12$ survive even $T_7\le42$ ([post F76](../findings/fence-posts.md)).
- **What a successor must clear** (F76): an ingredient outside the linear class-level system. L31's common image is inert at L241 (no pair cap tight). The unsummed per-pair inequalities ([L234](../findings/second-order.md)) are non-local in $(\lambda,T)$ and need per-index data. **Realisability of the class values** is the remaining named ingredient.
- **One structural fact at L241's spectrum**: $\mathop{\mathrm{Ric}}(e)=\sum_be_bA_b=0$ with $e=(-a,0,a)$ forces $A_-=A_+$, equal isotropy matrices on the two nonzero eigenspaces. And $\mathop{\mathrm{tr}}e^3=0$, so $\theta=\langle W,W^\#\rangle$ there, which [F11](../findings/second-order.md) shows no $n$-uniform bound on the sharp term alone can exclude.

## What bars the obvious approaches

- A bound on the sharp term alone: [F11](../findings/second-order.md).
- Any linear certificate over the class system: [F76](../findings/fence-posts.md), [L241](../findings/bounds-relaxations.md).
- Schur–Horn and Kostant convexity on the spectrum: closed on the record (2026-09-23 sweep, batch 2).
- Critical-orbit theorems (Michel, Palais): place critical points, never maxima (round 2, batches 1 and 4).

## What previous sweeps already covered, so this one does not repeat them

- [2026-09-23 step 9 sweep](2026-09-23-LIT-step9-sweep.md): the second-kind curvature operator, Schur–Horn and Kostant, Hamilton's $Q$ as the named object; routes R30, R31, R32.
- [2026-09-23 round 2](2026-09-23-LIT-step9-sweep-round2.md): Cartan 3-form calibrations, Tkachev's idempotents and Peirce spectra, symmetric-tensor Z-eigenvectors, Michel's theorem, Jordan algebras, symmetric criticality, spherical designs, landscape arguments, the hypergraph Lagrangian.
- [2026-09-24 I73 sweep](2026-09-24-LIT-I73-sweep.md): approximate Clifford relations and commutator sums, DDVV constants depending on the family, $k$-plane curvature sums; Ge–Tao–Zhou 2024 filed.

## What this sweep is asked for

An ingredient that constrains the class values of a three-value critical point beyond the linear system. Fields, each searched in its own objects rather than this programme's:

1. **Algebraic curvature operators with few eigenvalues**: classifications of Weyl (or Einstein) curvature operators on $\Lambda^2$ with two or three eigenvalues, and which multiplicity patterns occur.
2. **Joint realisability of spectrum and isotropy**: which pairs (eigenspace decomposition of $\Lambda^2\mathbb R^n$, isotropy matrices $A_a=\sum\Psi_\alpha\Psi_\alpha^{\mathsf T}$) come from an algebraic curvature tensor satisfying Bianchi; moment-map convexity for $O(n)$ on $\Lambda^2$-subspaces.
3. **Subspaces of $\mathfrak{so}(n)$ with equal isotropy**: pairs of orthogonal subspaces with $\sum\Psi\Psi^{\mathsf T}$ equal, and what Bianchi $\sum_{+}\psi\wedge\psi=\sum_{-}\psi\wedge\psi$ forces.
4. **Curvature operators with spectrum symmetric about zero**, and Einstein or Weyl tensors with $\mathop{\mathrm{tr}}W^3=0$ at a critical point of a cubic invariant.
