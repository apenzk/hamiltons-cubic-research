# Step 9 literature sweep, 2026-09-27: stable critical points of a structure-constant functional

Works from [the position file](2026-09-27-step8-position.md).

## Batch 1: the variational side of homogeneous Einstein metrics (a field the record filed only for its tensor)

**The analogue of U$_{\mathrm s}$ is an open question there.** *[Lauret–Will 2021](../references/lauret-will-2021-local-maxima-hilbert/notes.md): among Einstein metrics, the critical points of scalar curvature on unit-volume metrics, "stable irreducible symmetric spaces are the only known local maxima"; the bi-invariant metric on $SU(n)$, $n\ge3$, is neutrally stable and not a local maximum, by a curve through it with an inflection point (Theorem 1.2 (i)), which is the record's marginal $\mathfrak{su}(m)$ ([L265](../findings/second-order.md)) and its third-order saddle at $\mathfrak{su}(3)$, in the other functional. On invariant metrics the analogue fails: with two isotropy summands and $K$ maximal a global maximum of the restriction exists and need not be the standard metric (§3), and $G$-stable non-symmetric metrics are known.* **What transfers is the method, not a theorem**: *explicit curves through a neutrally stable point, Hessians on invariant variations; the functional differs ($L_{ijk}x_k/(x_ix_j)$ under $\prod x_i^{d_i}=1$ against $T_{ijk}\lambda_i\lambda_j\lambda_k$ under $\sum\lambda_i^2=1$), and a scalar-curvature counterexample is not a $\#$ counterexample. It does raise the prior that U$_{\mathrm s}$ may fail on some family with two summands where the record's second root is stable, which [L264](../findings/second-order.md) (4) places at $y>2x$; every such family computed has $y\le2x$.*

- *Searched, not yet read*: [Böhm–Wang–Ziller 2004](https://link.springer.com/article/10.1007/s00039-004-0471-x) (the variational approach, the graph theorem), [Graev 2011](https://arxiv.org/abs/1110.3839) (the Böhm polyhedron: existence from non-contractibility of the complex of intermediate subgroups), the analogue of the record's cone reading.

## Batch 2: stability of standard Einstein metrics by Casimirs, the method of L265

**[L265](../findings/second-order.md)'s criterion is Koiso's method, transferred.** *For symmetric Einstein metrics the stability type is read off the Casimir eigenvalues on the components of $\mathop{\mathrm{Sym}}^2$ (Koiso's classification, quoted as the list (3) in [Lauret–Will](../references/lauret-will-2021-local-maxima-hilbert/notes.md): $SU(n)$, $SU(n)/SO(n)$, $SU(2n)/Sp(n)$, $SU(p+q)/S(U(p)\times U(q))$, $E_6/F_4$ neutrally stable); [J. Lauret 2021](https://arxiv.org/abs/2105.06336) and [E. and J. Lauret 2021](https://arxiv.org/abs/2112.08469) extend it to $G$-invariant TT-tensors and to the Wang–Ziller standard metrics. For $\#$, L265 finds the same mechanism with different thresholds: $\mathfrak{su}(m)$ marginal as $SU(n)$ is, but $\mathfrak{sp}(m)$ unstable where $Sp(n)$ is stable. So L265 is a transfer of a classical method to a new functional, and is recorded as such in its block.* *Searched, not read*: the two Lauret papers (abstracts only).

## Batch 3: the two nodes in their own objects

- *Uniqueness of positive solutions of $x_i=\sum_{jk}a_{ijk}x_jx_k$ (the torus system's shape)*: nonlinear Perron–Frobenius ([Akian–Gaubert–Hochart](https://arxiv.org/abs/1812.09871), [Gautier–Tudisco–Hein](https://arxiv.org/abs/1801.04215)) gives uniqueness for order-preserving maps homogeneous of degree one, or for $\ell^p$-eigenvectors with $p$ at least the order; a degree-two fixed point is the $Z$-type case, where positive solutions are not unique in general. **Consistent with U failing, and silent on stability, so it gives no route to U$_{\mathrm s}$.**
- *Critical points of the cubic Weyl invariant with three distinct eigenvalues, maxima at sphere products*: searched again in I73's objects, nothing beyond what [26d](2026-09-26d-LIT-step8-sweep.md) recorded.

## Phase 3: routes

| route | closes | attackable | margin | analytic | value | reach toward the open statement |
|---|---|---|---|---|---|---|
| I73 on the asymmetric spectra | 3 | 1 | 1 | 1 | **3** | the goal, no method |
| [R44](../routes.md), U$_{\mathrm s}$ in general | 2 | 1 | 1 | 1 | 2 | H, hence I114 and the sharp $\#$ half at even $n$; no method off torus symmetry |
| **R45, $\Phi>0$ on torus-invariant idempotents of $\mathfrak{so}(2m)$** | 1 | **2** | 1 | 1 | **2** | U$_{\mathrm s}$ on the family holding every $\mathfrak{so}(n)$ counterexample to U; a step toward R44, not the whole of it |
| R46, U$_{\mathrm s}$ from the cone's faces (the Böhm–Wang–Ziller analogue) | 2 | 1 | 1 | 1 | 2 | H; the analogue gives existence of critical points from the subalgebra complex, not uniqueness of maxima |

**No route reaches the open statement with a method; the reach gate does not fire, since no top route's reach is a single value or a census.** **Pick: R45**, the only route with a concrete untried method (a sign condition on one polynomial over the positive solutions of an explicit system), lying on I73's chain through I114, H and R44. Recorded in [routes.md](../routes.md) and [STATUS.md](../STATUS.md).
