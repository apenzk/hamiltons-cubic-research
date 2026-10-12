# Step 9 sweep, 2026-09-22: the global-maximality gap, on Fable

**Position file: [2026-09-22-step8-position.md](2026-09-22-step8-position.md). One question: what does GLOBAL maximality of a cubic on a sphere force, beyond criticality and the projected Hessian, given that padded $W_{\mathbb{CP}^2}$ passes both and is sub-maximal.** *Appended after every batch, so a compaction loses nothing.*

## Batch 0, best rank-one approximation and Z-eigenvalues

**Source stored**: [agrachev-chebyshev-rank-one-ratio](../references/agrachev-chebyshev-rank-one-ratio/README.md), Agrachev, Kozhasov, Uschmajew, *Chebyshev polynomials and best rank-one approximation ratio*.

**What it is about, and why it does not apply.** Its Theorems 1.10 and 1.11 characterise TENSORS that are critical for the ratio $\lVert A\rVert_2/\lVert A\rVert_F$, the flattest tensors, as convex combinations of their own best rank-one approximations. *That is a statement about which tensor $A$ one is maximising, with the maximiser as data.* Our $T$ is fixed by the Weyl cubic and is not extremal for that ratio. **Consulted, does not apply.**

**Searched and not stored**: Siu, *The global topology of orthogonally decomposable tensor landscapes* (arXiv 2609.14186), persistent homology of sublevel sets for ODECO tensors only. Our $T$ is not orthogonally decomposable. **Does not apply.**

## Batch 1, spurious local minima of forms on the sphere

**Source stored**: [lasserre-2021-spurious-local-minima-sphere](../references/lasserre-2021-spurious-local-minima-sphere/README.md), Lasserre, *Homogeneous polynomials and spurious local minima on the unit sphere*, Optimization Letters 2021.

**What it proves, verbatim in its [notes](../references/lasserre-2021-spurious-local-minima-sphere/notes.md).** Corollary 2.2: at a local minimiser of a degree-$d$ form, the multiplier is $-\tfrac d2f(x^*)$ and SONC reads $u^{\mathsf T}\nabla^2f(x^*)u\ge d\,f(x^*)$ on $(x^*)^\perp$. Lemma 2.3 and Corollary 2.4: SONC in terms of the two smallest Hessian eigenvalues. Theorem 3.3: no spurious local minima iff exactly one component of the gradient variety meets the SONC set.

**Checked against the record, and it is [L24](../findings/second-order.md) exactly.** *For maximising, negate: $\nabla^2P(W)=6L_W$, its $W$-eigenvalue is $d(d-1)\theta=6\theta$, and SONC is $6\lambda_{\max}(L_W\vert_{W^\perp})\le3\theta$, which is $\lambda_{\max}(L_e\vert_{W^\perp})\le\tfrac12$.* No new local content.

**WHAT IT DOES SUPPLY IS THE OBSTRUCTION MADE PRECISE, AND A CLOSURE.** *Theorem 3.3 says a form has no spurious local extrema iff its SONC points all share one value. Padded $W_{\mathbb{CP}^2}$ is a SONC point at $\theta=\sqrt{3/2}$, the sphere product is one at $\theta_0(n)>\sqrt{3/2}$ for $n\ge12$, so* **$P$ provably HAS spurious local maxima, and no theorem of the form "every second-order point is global" can apply to it.** *And the record's own [table](../findings/second-order.md) makes it worse for the local toolkit: padded $W_{\mathbb{CP}^2}$ has EXCESS $0$, so the third-order condition $T(e,e,e)=0$ and the fourth-order inequality $\langle b,B^+b\rangle\le\theta/2$ are both vacuous there.* **It passes every local test the programme owns, through fourth order.**

## Batch 2, the four-point rigidity, and Morse theory for exclusion

**The stored [extremal cubics](../references/ivanova-hildebrand-2021-extremal-cubics/notes.md) source** is about cubics with MANY global maxima on $S^2$ and the linear conditions each imposes. *Its rigidity runs from a known set of global maxima to the form, never from local maxima to globality.* **Does not apply.**

**Morse theory, re-screened for EXCLUSION rather than localisation.** *Two nondegenerate local maxima on a connected compact manifold force a mountain-pass critical point of index one between them, at value below both.* **That gives existence of a saddle and says nothing about which of the two maxima is global.** The [2026-09-13c](2026-09-13c-LIT-step8-sweep.md) verdict, *Morse inequalities bound counts from below*, holds for exclusion as well as for localisation. **Closed.**

## Phase 3a, the screen

Every mechanism the sweep surfaced is one of: a local condition (already L24, or vacuous at the competitor by excess $0$), a statement about the extremal TENSOR rather than the maximiser, a topological count from below, or a census of the gradient variety's components, which is [R12](../routes.md), stalled. **No mechanism consumes global maximality in a way that is not a value comparison.**

## Phase 3b, routes

**I WOULD WORK ONE ROUTE, AND IT IS THE ONE ALREADY OPEN.** *The sweep produced a closure, not a route, and a closure is the honest output of a search that was worth running.*

| route | closes | attackable | margin | analytic | value | how close to P |
|---|---|---|---|---|---|---|
| 1. [I110](../plan.md) → I104's far region → R25, unchanged | 2 | 3 | 1 | 1 | **6** | R25's far region, leaving the global-comparison step itself untouched |
| 2. the census reformulation, Lasserre Theorem 3.3 on the gradient variety's components | 3 | 1 | 1 | **0** | 0 | would close P outright and its endgame is a certificate in dimension $1638$ |

**Route 1 stays primary because it is the only one with a live method.** Route 2 is [R12](../routes.md) in new words and is recorded here so the eleventh sweep does not re-find it.

**And the sweep's one deliverable is a fence post**: *no local-to-global theorem for forms on spheres applies to $P$, because $P$ has a spurious local maximum, padded $W_{\mathbb{CP}^2}$, that passes the second-order condition with excess $0$ and so passes the third- and fourth-order conditions vacuously.* Any route to [I73](../plan.md) compares values across the critical set. It never proceeds from conditions at one point.
