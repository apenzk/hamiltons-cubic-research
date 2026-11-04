# Step 9 sweep, 2026-09-28p: the coupling node of I123

*Works from [the position file](2026-09-28p-step8-position.md).*

## Batch 1: literature (searched)

- **Question 1, the sharp Weyl-cubic constant.** Searched "sharp constant Weyl tensor cubic term Einstein pinching" and "cubic invariant of the Weyl tensor, product of spheres, sharp algebraic inequality". The hits are the Einstein-rigidity papers already filed, [Branca–Catino–Dameno–Mastrolia](../references/branca-catino-dameno-mastrolia-2024-yamabe-rigidity/README.md) (arXiv 2403.08647, the algebraic Weyl inequality advanced at $n=5,6$) and [Branca–Kröncke](../references/branca-kroncke-2025-isolation-stability/README.md) (arXiv 2506.13248), plus Catino–Mastrolia's four-dimensional Bochner formulas, where the sharp constant is Gursky–LeBrun's $\sqrt6$ on $W^+$. No paper states the sharp constant at $n\ge5$ or treats the two cubic invariants jointly.
- **Question 2, joint ranges of two invariant cubics.** Searched "joint numerical range of invariant polynomials, orbit space, supporting hyperplane, invariant cubic on a sphere". The theory found is for quadratic forms (joint numerical ranges of self-adjoint operators, their Carathéodory numbers) and for hyperbolic cubics; nothing for the image of a sphere under two invariant cubics.
- **Question 3, a coupling exact at the symmetric-space point.** Searched Hamilton's ODE on Weyl tensors and its blow-up rates. The ODE literature treats the rotationally symmetric reductions and Hamilton–Ivey pinching; the one mechanism tying $P$ to the ODE, a $Q$-invariant cone, is fenced on the record as vacuous ([fence-posts.md](../findings/fence-posts.md), "Cone invariance under $\dot W=Q(W)$").

## Batch 2: the lifts that change the functional (derived)

**An extension $F$ of P to a larger space $V\supset\mathrm{Weyl}$, $F|_{\mathrm{Weyl}}=P$, bounds P only through an independent evaluation of $\max_VF$.** When the cross terms are chosen to vanish ($F(W+E)=P(W)$), $\max_VF=\max P$ and nothing is gained. When they do not, the bound on $V$ is a new statement whose maximum has to be known by some theorem other than P. The two caps the record can evaluate on all of $\mathop{\mathrm{Sym}}^2\mathfrak{so}(n)$ are the rank-one cap on $\mathop{\mathrm{tr}}X^3$ and statement H. Every combination of them read through $I$ is closed by [the third attempt](2026-09-28o-I123-coupling.md): only $s=0$ is sharp at the balanced product. The Böhm–Wilking and Beitz cone form is the fenced cone mechanism. *So the named extensions are spent.*

## Phase 3a, the screen

The candidates were grepped in [findings/](../findings/) under "coupling", "both halves", "cone", "joint", "t_0" and by the values $0.02247$ and $1.213562$. The split $\theta_0=\sqrt2c_n+\frac{2\sqrt2}{n\sqrt{(n-1)(n-2)}}$ is on file for the diagonal locus ([diagonal-half.md](../findings/diagonal-half.md), "And that decomposes $\theta_0$ itself"), where the diagonal theorem ([L57](../findings/problem.md)) proves the trade-off $E-E_0\le T_{\max}-T$ through the second-kind spectrum. The general coupling is [bispectral.md](../findings/bispectral.md)'s programme, whose both-sided Schur–Horn relaxation meets the same wall as the vertex-matrix budget.

## Phase 3b, the routes

| route | closes | attackable | margin | analytic | value | how close to P |
|---|---|---|---|---|---|---|
| R56, the coupling (I123) | 3 | **0** | 1 | 1 | **0** | P outright; every named mechanism is closed (the invariant linear lifts, the $s$-family, the functional change, the cone) |
| the diagonality statement (I73, I36) | 3 | 0 | 1 | 1 | 0 | P through L57; BLOCKED under the churn cap with its two requirements |
| H by I117 | 2 | 1 | 1 | 1 | **2** | the $\#$ half, and with it P wherever $\mathop{\mathrm{tr}}W^3\le t_0$ ([the third attempt](2026-09-28o-I123-coupling.md)); its owed cases are all at index one ([L287](../findings/second-order.md)) |

**Outcome: I123 is regraded to `attackable` $0$, every named mechanism being closed, and stays in section 1 as the destination, no route known; the pick is I117, whose owed cases are concrete.** *The rubric's own prescription for an item whose every named route is closed: it stays on the list as the destination and the work goes to whatever can move. The churn cap does not fire, since commit fdf19cdd's derivation sits between the closures.* The reach gate does not fire: I117's reach is every $n\ge9$.
