# ROUND_L47, the dimension lemma for symmetric spaces

**Date:** 2026-09-07. **Phase:** 6, closed. **Verdict:** `GAP`, repaired, impact `NARROWS`. **Verifiers:** v176, v177, v178.

## Sources, verbatim

| what | where |
|---|---|
| Canonical statement | [results.md](../results.md) lines 531–535 |
| Landscape statement | [results.md](../results.md) line 170 |
| The block | [problem.md](../findings/problem.md) lines 221–233 |
| Brief | [BRIEF_L47.md](BRIEF_L47.md) |

## Findings from phase 0

**1. The heading is malformed and the index has inherited the garbling.** The block reads `Lemma L47 ((the dimension lemma for symmetric spaces) · (B)), canonical statement and proof`, and [INDEX-results.md](../findings/INDEX-results.md)'s row ends *"the dimension lemma for symmetric spaces) · (B"*, **an unbalanced parenthesis carried into the index by whatever generates it.**

**2. This result's classification input is the one the record acquired only today.** It quantifies over *"every compact irreducible symmetric space of rank $\ge2$"* plus the twelve exceptional spaces. **[Holland–Ion](../references/holland-ion-2012-symmetric-spaces/) states the classical families and all twelve exceptional pairs and is now on file; [Yokota](../references/yokota-2009-exceptional-lie-groups/) asserts exhaustiveness in its preface and proves it nowhere.** *So the completeness of the list this lemma quantifies over is a live question, and it was not one the record could ask before today.*

**3. The certificates are eight bare constants.** *"Each classical family reduces to a polynomial positivity statement with an all-nonnegative-coefficient certificate after shifting to its first admissible rank, each with a strictly positive constant term ($616$, $48$, $7200$, $114$, $3696$, $2192$, $236$, $84$)"*, **with no polynomial written and no family named against any constant.**

**4. The exceptional cases are a measurement.** *"The twelve exceptional spaces check directly, mostly by an order of magnitude"*, and the source hunter reported that **exceptional-pair Casimir data is the one fact it could source nowhere**, its nearest candidate printing a value inconsistent with its own table.

## What the verifiers are asked beyond the standing list

Whether the Cauchy–Schwarz step $\lVert R\rVert^2\ge(n/4)^2/\dim\mathfrak h$ is right and what it needs; whether the implication from the $\dim\mathfrak h$ bound to $\lVert W\rVert^2\ge\tfrac16$ is exact or lossy; whether [Petersen–Stanfield](../references/petersen-stanfield-2025-poincare-polynomials/) Proposition 2.2 says what is claimed of it, **read at source, since it is on file**; and whether the rank-one residue is correctly excluded, $\mathbb{CP}^m$ and $\mathbb{HP}^m$ are handed to other lemmas and $\mathbb{OP}^2$ is kept.

## Clustering, all three in, all `GAP`, unanimous

**`GAP`.** *True as far as it can be checked (the load-bearing parts were re-derived cold) and the proof of its principal clause is not on the record, while its concluding universal is false as written.*

**What v176 rebuilt by hand.** The Cauchy–Schwarz step, which **needs only $\mathop{\mathrm{im}}R\subseteq\mathfrak h$ and $\mathop{\mathrm{tr}}R=n/4$ and not the block-eigenvalue statement it cites**; the dimension bound's algebra, exact with no slack, sufficient and never necessary; **all eight constants**, as $P=3n^2(n-1)-2(7n-4)\dim\mathfrak h$ at each family's shift; **all twelve exceptional spaces**; and both rank-one closed forms, with strict monotonicity so no second equality case. **[Petersen–Stanfield](../references/petersen-stanfield-2025-poincare-polynomials/) Proposition 2.2 read at source says what is claimed.** *Two cross-checks fell out: $\mathbb{OP}^2$ at $\theta^2=\tfrac{45}{56}$ matches the record's separately obtained value, and $\mathrm{Gr}_{\mathbb R}(2,2)$ returns the record's $n=4$ value $\sqrt3/2$.*

| id | finding | support |
|---|---|---|
| **N1**, **THE GAP** | **the rank-$\ge2$ branch, which is the whole lemma, has no written argument.** [problem.md](../findings/problem.md) is the designated proof location and it **names no family against any constant, writes no polynomial, names no shift point and links no script**. *The data lives only in [b_symmetric_dimension_lemma.py](../scripts/route-b/b_symmetric_dimension_lemma.py), which computes the coefficient claim at run time without recording it.* Four of the eight expansions were verified by hand by one verifier and **all eight by the other, in the census script's row order, so the debt is on the writing and not on the arithmetic** | v176, v178 |
| **N2** | **the concluding universal is false.** At $S^4$, $R=\tfrac16I$ on all of $\Lambda^2$, so $W=0$, $\lVert W\rVert^2=0<\tfrac16$ and $\theta$ is $0/0$. **The block needs $W\ne0$, and that is NOT [L46](../findings/problem.md)'s already-booked $\lambda\ne0$**, $S^n$ has $\lambda=\tfrac12$. *The fixing clause exists only in [graded-half.md](../findings/graded-half.md), in neither [problem.md](../findings/problem.md) nor [results.md](../results.md)* | v176, v178 |
| **N3** | **the eighth shift is to $\dim\mathfrak g=6$, a dimension no compact simple Lie algebra has**, so the constant $84$ certifies no actual space; the real first rank-$2$ member is $\mathfrak{su}(3)$ at $P=512$. *Sound as a relaxation and wrong as described* | v176 |
| **N4** | *"mostly by an order of magnitude"* is **false at $\mathbb{OP}^2$**, factor $\tfrac{40}{27}$, **and at $G_2/SO(4)$**, factor $\tfrac{28}{13}$; it holds for five of twelve | v176, v178 |
| **N7** | **the minima are cited to a five-point scan**, $m=2\ldots6$, while the monotonicity that makes them minima sits proved in two unnamed files, with the range $m\ge2$ unstated | v178 |
| **N5** | **the residue pointer is false**: [L10](../results.md) and [L38](../results.md) carry only $\mathbb{CP}^m$, $\mathbb{HP}^m$ is [L5](../results.md)'s, and $S^n$ and $\mathbb{RP}^n$ are pointed at nothing | v176 |
| **N6** | **classification completeness is `HYPOTHESIS-DEBT`, and today's own repair does not reach it**: [conventions.md](../findings/conventions.md)'s pointer is [L159](../findings/graded-half.md), covering $\mathfrak{so}(n)$ alone, **while L47 ranges over every compact simple $\mathfrak g$ plus Type II.** *Two corrections in L47's favour arrived with it, see below* | v176, v178 |

## Two corrections to this morning's own reference notes

**[Holland–Ion](../references/holland-ion-2012-symmetric-spaces/) does more than the record credits it with.** It **argues the type I / type II dichotomy** in chapter 3, and **proves type II equals the compact Lie groups** at chapter 7, Theorem 19. *The notes written this morning read chapter 8 alone and missed both*, the same trap those notes themselves warn about, a reader stopping early in a chapter. **What stays unsourced is narrower than recorded**: completeness of the type-I list, asserted in both sources, and the twelve exceptional dimensions, nowhere.

## Adjudication

**Verdict `GAP`, repaired. Impact `NARROWS`.** Three verifiers, three `GAP`s, and **nothing is refuted**. Every value checked out: the normalisation identity, all eight certificate constants, both rank-one closed forms, $\lVert W\rVert^2(\mathbb{OP}^2)=\tfrac{14}{45}$, the type-II form $\frac{n(n-3)}{16(n-1)}$, and all twelve exceptional rows, **one verifier reconstructed the constants before opening the script**, and four further record values were re-derived cold and matched to every printed digit, which rules out a hidden normalisation error. **No falsifier**, and the largest ratio anywhere is $\mathbb{OP}^2$ at $0.675$.

### The gap is that the proof is in a script

**The rank-$\ge2$ branch is the whole lemma, and its designated proof location names no family against any constant, writes no polynomial, names no shift point and links no script.** The content lives in [b_symmetric_dimension_lemma.py](../scripts/route-b/b_symmetric_dimension_lemma.py), which computes the coefficient claim at run time without recording it. *That the arithmetic is right is now established three times over; that the record carries the argument is not, and a reader cannot check what is not written.*

### Two steps do less and more than the block said

**The Cauchy–Schwarz step cites the wrong sentence and needs less than it cites.** It needs $\mathop{\mathrm{rank}}R\le\dim\mathfrak h$ and $\mathop{\mathrm{tr}}R=n/4$ (not isotypy, not $R\succeq0$, and not block eigenvalues) and that rank fact is [Petersen–Stanfield](../references/petersen-stanfield-2025-poincare-polynomials/) **Proposition 2.1**'s image statement where the block cites Prop 2.2. **And it is sharp rather than merely valid**: by their Theorem C, equality holds on every simple-isotropy space, the type-II groups and $\mathbb{OP}^2$ among them.

### The equality clause rests on five points

The minima are taken over $m=2\ldots6$ in the script and **no monotonicity is argued anywhere**, while *"equality only at $\mathbb{CP}^2$"* rests entirely on them. A verifier closed it by hand (derivative numerators $3m^2-2m+1$ and $34m^4+56m^3-21m^2+8m+4$, both positive on $m\ge2$), **and that derivation is unaudited, so it is recorded as owed and did not enter the block as proved.**

### The repairs, all applied

| finding | what changed |
|---|---|
| N2 | $W\ne0$ into the statement in both files, with $S^4$ as the witness and the note that this is **not** [L46](../findings/problem.md)'s $\lambda\ne0$, which $S^n$ satisfies |
| N1 | the script named as where the certificates live, with what the block owes stated; the two misdescribed shifts recorded, $48$ is BDI at $p=q=2$, the reducible $S^2\times S^2$, and $84$ is type II at $n=6$, a dimension no compact simple algebra has, **both conservative** |
| the citation | Prop 2.1's image statement replaces Prop 2.2, with what the step actually needs, and its sharpness recorded |
| N7 | the five-point scan named, with the owed monotonicity stated and the unaudited derivation flagged as unaudited |
| N5 | the rank-one pointer corrected, $\mathbb{CP}^m$ to [L10](../results.md), $\mathbb{HP}^m$ to [L5](../findings/graded-half.md), $S^n$ and $\mathbb{RP}^n$ to $W=0$ |
| N4 | the order-of-magnitude claim quantified: seven of twelve, and false at $\mathbb{OP}^2$ and $G_2/SO(4)$ with both factors given |
| N6 | what a consumer may cite for the index set, split into the three things Holland–Ion proves and the two nothing on file does; **and that the exceptional rows need no Casimir data at all**, only $\dim\mathfrak g$ and $\dim\mathfrak h$, *which are hard-coded and sourced nowhere* |
| heading | the malformed heading and the index row's unbalanced parenthesis repaired |
| collisions | $\mathfrak h$, $\lambda$, $c$, $B$ and **three senses of $P$** tabled in [conventions.md](../findings/conventions.md) |

### Queued elsewhere

**Research loop.** The monotonicity of both rank-one closed forms on $m\ge2$, which closes the equality clause; and **transcribing the eight certificate polynomials out of the script into the record**, which is what makes this lemma checkable by a reader. **The type-I list's completeness and the twelve exceptional dimensions remain unsourced**, the first thing the source hunt could not settle that a live result actually consumes.
