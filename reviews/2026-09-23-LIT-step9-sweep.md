# Step 9 literature sweep, 2026-09-23

*Position at [2026-09-23-step9-position.md](2026-09-23-step9-position.md). Appended after every batch.*

## Batch 0, the reframing, before any search

**Strip the vocabulary and [I73](../plan.md) is a MINIMAL POLYNOMIAL statement.** *"The spectrum takes exactly two values" is "$(W-a)(W-b)=0$ for scalars $a,b$", i.e. the minimal polynomial of $W$, as an operator on $\Lambda^2$, has degree $2$.*

**And criticality already supplies a quadratic-shaped relation.** $Q(W)=W^2+W^\#=\theta W$, so

$$W^2=\theta W-W^\#.$$

**So $I73 \iff W^\#\in\operatorname{span}\{W,\mathrm{Id}\}$ at a global maximiser.** *If $W^\#=cW+d\,\mathrm{Id}$ then $W^2=(\theta-c)W-d\,\mathrm{Id}$ and the minimal polynomial has degree $2$; conversely a degree-$2$ minimal polynomial forces $W^\#$ into that span through the same equation.*

**Why this is worth having**: it converts a statement about a SPECTRUM, which is a property of the whole operator and has no obvious handle, into a statement about where ONE tensor lies in a $2$-dimensional subspace. *The $\#$ operation is the programme's own object and the record holds identities for it that a spectral statement cannot use.*

**SCREENED AGAINST THE RECORD BEFORE SEARCHING, which is where five novelty claims died in the preceding session.** *Greps run over [findings/](../findings/) for `span`, `minimal polynomial`, `W^\#\in`, `two values`, and for the defining relation itself.*

**Screen result: the reframing is NOT on the record.** *No hit in [findings/](../findings/) for a minimal-polynomial statement about $W$, nor for $W^\#$ confined to a two-dimensional span. [L105](../findings/bounds-relaxations.md) is confirmed as what [I73](../plan.md) feeds: a two-eigenvalue critical point has $\theta\le\theta_0(n)$ from $T\ge0$ alone, with equality only at $r=n(n-2)/4$, forcing $n$ even.* **The reframing is a restatement and not a theorem; its value is that it changes which tools apply.**

## Batch 1, the curvature operator of the SECOND KIND, and what it does not give

**The field the stripped problem belongs to is the curvature operator of the second kind $\mathring R$**, Nishikawa's operator on symmetric two-tensors, which carries an active 2022–2026 literature on rigidity under spectral conditions.

**[Rigidity of Einstein Manifolds under Two Eigenvalue Conditions](https://arxiv.org/html/2609.23597) (2026) is NOT [I73](../plan.md) and the title is misleading for this purpose.** *Its "two eigenvalue conditions" are two lower BOUNDS, $\lambda_1\ge-L_1\bar\lambda$ and $\tfrac1\alpha\sum_{j\le\alpha}\lambda_j\ge-L_2\bar\lambda$, on a spectrum of arbitrary multiplicities. It neither assumes nor concludes a spectrum taking exactly two values, and it addresses no cubic form on Weyl tensors.* **Conclusion at $n\ge6$: flat or a spherical space form.**

**WHAT IT DOES CARRY IS THE SAME CUBIC.** *Its equation (13) contains $16\sum_{j=1}^N\lambda_j^3$ inside a Bochner functional.* **That is the programme's own quantity under another name, up to normalisation**, and the technique is to bound it under spectral constraints, which is what [I104](../plan.md)'s chain does by hand. *Whether the Bochner route supplies a bound the chain does not is the thing to test, and it is the live thread out of this batch.*

## Batch 2, Schur–Horn and Kostant: CLOSED on the record, caught by the screen

**The search surfaced Kostant convexity and Schur–Horn as the mechanism for [I36](../plan.md)**, majorisation between a matrix's diagonal and its spectrum, which would put a maximiser at the extreme of the majorisation order.

**It is already worked and its verdict is already written.** *[bispectral.md](../findings/bispectral.md) carries a section headed "Schur–Horn: what it actually consumes, and why $\kappa$ was never the missing piece", uses [NPW Prop 3.10](../references/nienhaus-petersen-wink-2022-betti-second-kind/README.md) to get $\omega\succ d$, and records the route-level verdict: the coupling is a tautology exactly where the conjecture is granted, and off that family it is beaten by a one-line estimate and by the relaxation it was built to improve.* **Only Schur's half is used, not Horn's**, and the frame choice is provably optimal by Karamata. **NOT PROPOSED.**

## Batch 3, the object IS Hamilton's, and that names the field

$Q(R)=R^2+R^\#$ is **Hamilton's quadratic vector field**, the reaction term of the Ricci flow $\partial_tR=\Delta R+2Q(R)$. *So the programme is maximising $\langle Q(W),W\rangle$ over the Weyl part, and its $\#$ is Hamilton's $\#$.*

**Two facts from the field that bear on the reframing.** *$R^2$ and $R^\#$ individually do NOT satisfy the first Bianchi identity while their sum does*, so "$W^\#\in\operatorname{span}\{W,\mathrm{Id}\}$" is a condition on an object outside the Bianchi space and cannot be read inside it without care. *And $S^2_B(\mathfrak{so}(n))=\langle\mathrm{Id}\rangle\oplus\langle\mathrm{Ric}_0\rangle\oplus\langle W\rangle$ with $Q(\mathrm{Id})=(n-1)\mathrm{Id}$.*

**The live field is INVARIANT CURVATURE CONES**, Wilking's criterion and the Böhm–Wilking machinery, which ask which cones $Q$ preserves rather than how large $\langle Q(W),W\rangle$ can be. **Böhm–Wilking is already on the record**, cited in [problem.md](../findings/problem.md) for its constant $c(n-1)$, so the field is not new to the programme; what is unexplored is the cone question as a route to the VALUE bound.

## Phase 3b, the routes, and there are THREE rather than four

*Scored on section 1's rubric, `closes × attackable × margin × analytic`, against the open statement $\theta\le\sqrt{3/2}$ at every non-diagonal critical point.*

| route | closes | attackable | margin | analytic | value | how close to P |
|---|---|---|---|---|---|---|
| **R-A**, the $\#$-span reformulation of [I73](../plan.md) | 3 | 2 | 1 | 1 | **6** | closes P outright with [L105](../findings/bounds-relaxations.md), leaving nothing |
| **R-B**, invariant curvature cones for the VALUE bound | 3 | 1 | 1 | 1 | **3** | closes P outright if it works; leaves the cone's own sharpness owed |
| **R-C**, the second-kind Bochner functional | 2 | 2 | 1 | 1 | **4** | a bound on the same cubic; leaves the non-diagonal case open |

### R-A, the $\#$-span reformulation. **The pick.**

**Mechanism.** [I73](../plan.md) is *"the maximiser's spectrum takes two values"*, which is *"the minimal polynomial of $W$ has degree $2$"*, which given criticality $W^2=\theta W-W^\#$ is exactly

$$W^\#\in\operatorname{span}\{W,\ \mathrm{Id}\}.$$

**Why it is worth more than the statement it replaces.** *A spectrum is a property of the whole operator with no handle; membership of a two-dimensional span is a linear condition on ONE tensor, and $\#$ is the object this record holds identities for.* **[L105](../findings/bounds-relaxations.md) then finishes outright.**

**What running it takes.** Decide whether $\langle W^\#,X\rangle=0$ for every $X\perp\operatorname{span}\{W,\mathrm{Id}\}$ follows at a maximiser, presumably from second-order information. **What falsifies it**: a critical point with $W^\#$ outside that span and $\theta>\sqrt{3/2}$, or a proof that the span condition is strictly stronger than the two-value spectrum.

**Scored `attackable` $2$ and not $3$**, *because the reformulation is untried while the underlying question has ten spent sweeps, and the rubric scores the item rather than the restatement.* **Screened**: no hit in [findings/](../findings/) for a minimal-polynomial statement or for $W^\#$ in a two-dimensional span.

### R-B, invariant curvature cones

**Mechanism.** Ask not how large $\langle Q(W),W\rangle$ is but whether $\{\theta\le\sqrt{3/2}\}$ is a cone preserved by $Q$, via Wilking's criterion. **Böhm–Wilking is already on the record** for its constant; the cone question as a route to the VALUE bound is not. *`attackable` $1$: the route must be invented, and no named mechanism yet carries it.*

### R-C, the second-kind Bochner functional

**Mechanism.** The 2026 rigidity literature on $\mathring R$ carries $\sum_j\lambda_j^3$ inside a Bochner functional and bounds it under spectral conditions. *Its goals are Einstein manifolds and topology, not the algebraic maximum, and its hypotheses are lower bounds on spectral averages rather than a two-value spectrum.* **`closes` $2$**: it bounds the same cubic but on a different class, so it is a named step and not the statement.

### The recommendation, and it names an ORDER rather than one route

**Work R-A first and alone.** *It is the only candidate scoring $3$ on `closes` with a route that exists, it needs no new machinery, and [L105](../findings/bounds-relaxations.md) converts it straight into P.* **If R-A fails, its failure is informative**: showing the span condition is strictly stronger than the two-value spectrum would say the reformulation is lossy and send the next attempt back to the spectrum itself. **R-C is second**, as a bound on the same cubic from a field that has one. **R-B is third and is a research programme rather than a route**, and should not be opened until R-A is settled.

*Two sweeps' worth of ground was NOT re-covered: rank-one approximation and Z-eigenvalues, spurious local minima on the sphere, four-point rigidity and Morse exclusion, all screened in the 2026-09-22 sweep, and Schur–Horn, closed in [bispectral.md](../findings/bispectral.md).*
