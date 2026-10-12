# Step 9 literature sweep, 2026-09-26: I73 after R39's reach gate

Works from [the position file](2026-09-26-step8-position.md). One section per batch, appended as each finishes.

## Batch 1: moment maps, and curvature cubics on products of spheres

- *Critical points of an invariant cubic on a sphere as a moment-map (Kirwan–Ness) condition*: general Kirwan–Ness and norm-square-of-moment-map theory only ([arXiv 0912.1132](https://arxiv.org/pdf/0912.1132), [math/0404413](https://arxiv.org/pdf/math/0404413)); **nothing on eigenvalue multiplicities of critical points of an invariant cubic**. Searched, nothing found.
- *Weyl curvature cubic, products of spheres*: Nienhaus 2023 (already filed, [nienhaus-2023-second-best-einstein](../references/nienhaus-2023-second-best-einstein/README.md)); Deninger–Grundhöfer–Kramer 2022 (already filed); **new**: Huang, an $SO(3)\times SO(8)$-invariant Einstein metric on $S^3\times S^7$ ([arXiv 2606.08888](https://arxiv.org/abs/2606.08888)). *Screened out*: it constructs a metric, not a critical point of $P$, and bears on no mechanism for I73.

## Batch 2: bracket-mass lower bounds for subspaces, and Hamilton's ODE

- *Lower bounds on $\sum\lVert[\psi_a,\psi_b]\rVert^2$ for a subspace of $\mathfrak{so}(n)$, superlinear in its dimension*: searched, nothing found. Nearest: commutative subalgebra dimension bounds ([arXiv 1408.1491](https://arxiv.org/pdf/1408.1491)), exact rather than quantitative; Shen–Wang–Zhi, a dimension-independent commutator bound ([arXiv 2609.09938](https://arxiv.org/abs/2609.09938), 2026, Lean-verified), *screened out*: it writes a trace-zero matrix as $[B,C]$ with $\lVert B\rVert\lVert C\rVert\le K\lVert A\rVert$, the opposite direction.
- *Critical points $Q(W)=\theta W$ as self-similar solutions of Hamilton's ODE $\dot R=Q(R)$*: general Ricci-flow and invariant-cone literature only (Böhm–Wilking, [math/0606187](https://arxiv.org/abs/math/0606187); curvature cones $((n-2)/4+a)\lVert R\rVert^2\le\tfrac14\lVert\mathrm{Ric}\rVert^2$, conjectured invariant). **No classification of the ODE's fixed directions in the Weyl part was found**; on Weyl tensors the cone condition is vacuous (Ric $=0$). Searched, nothing found.

## Batch 3: idempotents of the curvature algebra (covered ground)

- Krasnov–Tkachev on the variety of idempotents and Peirce syzygies ([arXiv 1801.00617](https://arxiv.org/pdf/1801.00617)), the universality of $\tfrac12$ ([arXiv 1808.03808](https://arxiv.org/pdf/1808.03808)), medial and isospectral algebras ([arXiv 2210.08245](https://arxiv.org/pdf/2210.08245)), and Fox's algebra of metric curvature tensors (Forum Math. Sigma): **all already filed** ([krasnov-tkachev-2018-idempotent-variety](../references/krasnov-tkachev-2018-idempotent-variety/), [krasnov-tkachev-2022-medial-isospectral](../references/krasnov-tkachev-2022-medial-isospectral/), [fox-2019-nonassociative-curvature-algebra](../references/fox-2019-nonassociative-curvature-algebra/) and eight more). [I89](../plan.md) records that the curvature algebra is not medial, so the isospectral classification is unavailable. Nothing new.

## Phase 3a: screen and candidates

**The $\sqrt p$ filter.** Per-vector (single-element) arguments give ceilings linear in $p$ (R39's reach gate). A mechanism reaching the middle of the window must either act on a class-level object (whose invariants scale like $\dim$ and can be compared with $\kappa^2\propto p$), or consume global maximality.

**Screened against the record** (fence posts, [routes.md](../routes.md), [ATTEMPTS.md](../ATTEMPTS.md), the literature index): the great-circle inequality $\theta\cos^3t+3a\cos t\sin^2t+b\sin^3t\le\theta$ (exact at a global maximiser, $a=\langle L_WV,V\rangle$, $b=P(V)$, unit $V\perp W$) has been used along single directions and orbit tubes (R25, L216, L134) and **never along the class projectors** $V\in\operatorname{span}\{\pi_{\mathcal W}P_0,\pi_{\mathcal W}P_1,\pi_{\mathcal W}P_2\}$. That direction is a coherent sum over an eigenspace, not a sum of pair quotients, so [F76](../findings/fence-posts.md) (summed pair test) does not cover it, and it brings in the cubic term $b$, which no per-vector or pair test sees.

## Phase 3b: ranked routes

| route | closes | attackable | margin | analytic | value | reach toward P |
|---|---|---|---|---|---|---|
| **A. Great circles along the class projectors**: compute $a$ and $b$ for $V=\pi_{\mathcal W}(\sum_c\gamma_cP_c)$ in the traced quantities ($t_{abc}$, $\operatorname{tr}A_c^2$, $\lVert\Omega_c\rVert^2$) and impose $\max_t g(t)\le\theta$ | 2 | 3 | 1 | 1 | **6** | every $n$ at once on the symmetric family (the traced system is $n$-uniform), then a general three-value spectrum; leaves four or more eigenvalues |
| B. Quantitative rigidity of linear spaces of near-rank-2 skew matrices, against the isotropy cap | 1 | 1 | 1 | 1 | 1 | the $n=12$ symmetric window only (the reach gate) |
| C. Nienhaus Theorem 4.17 under a weaker a-priori bound (R25) | 2 | 0 | 1 | 1 | 0 | blocked at I104's far region, [obstruction](../findings/INDEX.md) |
| D. Moment-map (Kirwan–Ness) form of the eigenspace condition | 2 | 1 | 1 | 1 | 2 | unknown; no source treats critical points of an invariant cubic |

**Chosen: A.** It is untried, analytic, class-level (so not bound by the per-vector $O(p)$ scaling), consumes global maximality through the finite great-circle expansion, and reaches every $n$ at once. *What it would not leave outstanding*: nothing on the symmetric family if it closes; the asymmetric spectra and four or more eigenvalues stay.


## Phase 4 check: route A fails its teeth test

**At padded $W_{\mathbb{CP}^2}$, $n=12$** (critical and locally maximal, not global; [screen_I73_routeA_cp2.py](../scripts/misc/screen_I73_routeA_cp2.py)), the three Weyl-projected class projectors with $W$ removed span a single direction $V$, with $a=\langle L_WV,V\rangle=0$ to $10^{-17}$ and $b=P(V)=1.2016<\theta=1.2247$. With $a=0$, $\max_t(\theta\cos^3t+b\sin^3t)=\theta$ whenever $b\le\theta$, so **the class-projector great circle does not detect the non-global maximality that I73 needs it to**. *Structurally, three classes give one class direction ($\sum_cP_c=\mathrm{id}$ projects to $0$ and $W$ is removed), and the inequality then fires only if $a>0$ or $b>\theta$; global maximality already gives $b\le\theta$. Route A is demoted to value $0$ on `attackable` (its only mechanism is spent).*

## Phase 4 check: two-dimensional slices (D3) fail the same teeth test

**At padded $W_{\mathbb{CP}^2}$, $n=12$, $\theta=\sqrt{3/2}$** ([screen_I73_slices_cp2.py](../scripts/misc/screen_I73_slices_cp2.py)), every sampled slice $\operatorname{span}(W,U,V)$ with $U$ the class direction and $V$ a rank-one pair direction from any eigenspace pair, and every slice through two pair directions (1500), tops out at exactly $\theta$, as do random slices. The control fires: the slice through the balanced product $S^5\times S^5$ ($P=1.236033>\theta$) reaches it.

**Where the escaping direction lives** ([screen_I73_slices_cp2_escape.py](../scripts/misc/screen_I73_slices_cp2_escape.py)): the product is orthogonal to $W$, lies wholly in the span of the projected $E_0$ pair directions (dimension 1569), and has $a=\langle L_WD^*,D^*\rangle=0$, so the whole gain is the cubic term at $t=\pi/2$, the competitor itself. It is a high-rank combination of pair directions, so no slice through two of them sees it, and averaging over $O(E_0)$ rotations of $D^*$ drops $b$ from $1.236$ to about $0.03$ and the circle's maximum back to $\theta$.

**What this says about any route**: at a non-global local maximiser the beating point is far (orthogonal to $W$) and flat to second order, so global maximality carries no information in low-dimensional families built from $W$'s eigendata nor in their averages. It enters only through a comparison with a specific competitor. **Route D3 is demoted**, and I73 has four closed routes since the reach gate.
