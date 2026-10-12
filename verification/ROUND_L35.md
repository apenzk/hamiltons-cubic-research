# ROUND_L35, at most two negative eigenvalues caps $\theta$ at $\sqrt{3/2}$

**Date:** 2026-09-07. **Phase:** 6, closed. **Verdict:** `GAP`, repaired, impact `NARROWS`. **Verifiers:** v152, v153, v154.

## Sources, verbatim

| what | where |
|---|---|
| Canonical statement | [results.md](../results.md), block `##### Lemma L35, at most two negative eigenvalues caps $\theta$ at $\sqrt{3/2}$` |
| Proof block | [stratum-two-negative.md](../findings/stratum-two-negative.md) lines 443–491 |
| The chain, the dual, the residual inequality | [stratum-two-negative.md](../findings/stratum-two-negative.md) lines 522–615 |
| Conventions | [conventions.md](../findings/conventions.md) |
| Brief | [BRIEF_L35.md](BRIEF_L35.md) |

## The round's first finding, from phase 0

**The canonical statement in [results.md](../results.md) omits the unit-norm hypothesis that the findings statement carries and that the proof's opening identity needs.** The findings block states *"Let $W\in\mathrm{Weyl}_m$ have **unit norm** and at most two negative eigenvalues"*, and says of the cubic display that it requires $\lVert W\rVert=1$ *"since the display is $P(W)$ and $\theta$ is $P/\lVert W\rVert^3$"*. The canonical form reads *"Let $W\in\mathrm{Weyl}_m$ have at most two negative eigenvalues, at any number of positive ones and any $m$"*, no norm. Both forms go into the brief unlabelled.

## Two debts the block declares against itself

- **The one-negative case.** *"The argument below is written for exactly two negative eigenvalues; the one-negative case is the $c\to0$ boundary and is owed a line."* The statement says *at most* two.
- **The closing inequality is a certified numerical step.** *"The remaining interval $(\tfrac13,0.7096]$ closes by $200$-bit interval arithmetic with branch-and-bound, and $[0.7,0.7096]$ by bisection. That is rigorous and it is **not hand-checkable**."*

## Clustering, all three in

| id | step attacked | mechanism | support |
|---|---|---|---|
| **D1** | the $k=2$ positives case | the block says it *"closes in closed form"* and routes to L29; L29's own block says the two-parameter maximisation *"appears on no site, here or elsewhere, and is owed"* and names L35 as unable to discharge it, **a closed loop with nothing in it** | v153, v154 |
| **D2** | the one-negative case | *"owed a line"* by the block's own admission, and *"the $c\to0$ boundary"* is not the repair the step needs: at $c=0$ the constraint $s^2\le2-2u$ goes slack, so the *"forces $b=c$"* step excludes exactly that boundary | v153, v154 |
| **D3** | the residual inequality's quantifier over $t$ | three equal positives with $b=c$ give $t/T=\tfrac32$ exactly, at every scale, outside the $t\in[0,\tfrac{2\sqrt2}3A]$ the inequality quantifies over | v154 |
| **D4** | the endgame's location | $R(A,s,u)$, the region split, the five elementary bounds, the caps $1.017217$ and $1.067666$ and the symbols $\alpha,\beta,\gamma,T,K_0,\mathrm{FTP}$ exist only in [REVIEW_r63](../reviews/REVIEW_r63.md); the block presents one region's argument as the whole closure, and $(0,A_0]$ is tiled three incompatible ways in one file | v152, v154 |
| **D5** | $\sum\lambda^3$'s range in the $G$ formula | **false as printed** under the reading the block's own display three lines above fixes: over the whole spectrum it returns $8/(3\sqrt6)$ at $(2,-1,-1)/\sqrt6$ against $\theta=9/(3\sqrt6)$, so the chain runs backwards at its own equality point. **[REVIEW_r570](../reviews/REVIEW_r570.md) found this and the repair reached neither copy** | v152, v153 |
| **D6** | the withdrawn endpoint expansion | it still stands as the $(0.7,A_0]$ argument in the summary paragraph, four sections after its own withdrawal | v153 |
| **D7** | correction (i)'s attribution | the step needs $s^2\ge u$, which is positivity of the cross terms on a nonnegative spectrum; Cauchy–Schwarz gives $s^2\le k\,u$, **the opposite direction**, and lives instead at the unnamed $s^2\le2-2u$, whose equality case *is* the *"forces $b=c$"* step. *The wrong attribution entered as a Gate 2 correction* | v152, v154 |
| **D8** | *"peaking at $A=\tfrac13$ where $\beta=0$"* | states a coincidence as a cause, $\Phi'(\tfrac13)=\tfrac{11}3>0$, so the band peaks there because it stops there | v154 |
| **D9** | $W=0$ | the canonical form admits it (zero negatives, trace-free) and $\theta$ is $0/0$ there | v154 |

## Phase 0's finding, withdrawn as stated

**The unit-norm discrepancy between the two statement forms is not a defect in the statement.** $\theta$ is $0$-homogeneous, so the hypothesis is without loss of generality (v154, checked). *What survives is a defect of emphasis*: the hypothesis is load-bearing for the **identity** $\theta=\sum\lambda^3+3\sum T\lambda\lambda\lambda$, which is where the block places it, and carrying it in one statement form and not the other invites a reader to look for a difference that is not there.

## Both verifiers confirm, exactly

The coefficient $3$, v153 supplies a third derivation disjoint from the block's two. L42 in all four parts: dual transpose, feasibility at $c\ge H/3$, weak duality, and sharpness by $t=2/(k-2)$ at $k\ge3$. The decoupling as a genuine identity. Every endpoint surd, and the band value $\tfrac89$ at $A=\tfrac13$ exactly. **$\ker W\ne0$ is inert rather than fatal**, kernel triples contribute zero and dropping their cap load is a relaxation, which is what makes $G$ free of $m$; padded $W_{\mathbb{CP}^2}$ is the equality case.

**Neither found a falsifier.** A diagonal $W$ with at most two negative eigenvalues is confined to a $4$-plane by a row-sum argument, where $\Theta_4=\sqrt3/2$; the balanced $S^m\times S^m$ at $n=12$ has $36$ negatives and is excluded by hypothesis rather than by the bound.

## Adjudication

**Verdict `GAP`, repaired. Impact `NARROWS`.** Two verifiers returned `HYPOTHESIS-DEBT` and one `GAP`; the `GAP` is the right word, because the defect is not only that inputs are unproved but that **the middle of the proof is absent from [findings/](../findings/) entirely**, it exists in [REVIEW_r63](../reviews/REVIEW_r63.md) and the canonical block presents one of its three regions as the whole closure.

**The bound is not in question.** All three rebuilt every hand-checkable step from the definitions and every one reproduced exactly, including both region maxima, all five endpoint constants, the band value $\tfrac89$, [L42](../findings/stratum-two-negative.md) in all four parts, and the $C^1$ branch switch. **None found a falsifier**, and each said what one would look like: a two-negative *spectrum* with $G>\sqrt{3/2}$, needing no curvature tensor. $\ker W\ne0$ clears, $G$ lives on the nonzero eigenvalues and the equality case is itself a padded object.

**The finding that outranks the rest is D5**, and its shape is not a wrong sign: [REVIEW_r570](../reviews/REVIEW_r570.md) found the defect, named the one-symbol repair, and **the repair reached neither copy of the formula**. A reader following the block as printed gets $8/(3\sqrt6)$ at the lemma's own equality point against $\theta=9/(3\sqrt6)$.

**D1's loop is broken by locating the argument rather than by either pointer.** The $k\le2$ closure is in [REVIEW_r63](../reviews/REVIEW_r63.md), exact and reconciling with $G$; L29's block declaring it owed and L35's declaring it closed by L29 were each true about the canonical record and each wrong about the mathematics.

### The repairs, all applied

| finding | what changed |
|---|---|
| D5 | $\sum_P\lambda^3$ in both copies, with the failure at $(2,-1,-1)/\sqrt6$ stated so the reading cannot drift back |
| D7 | positivity of the cross terms, with Cauchy–Schwarz relocated to $s^2\le2-2u$ where it holds; the derivation's own summary corrected to match |
| D2 | the one-negative case recorded as owed in its own right, and the $c\to0$ line withdrawn with the reason, that locus sits strictly inside $\{s^2<2-2u\}$ and is excluded by the step forcing $b=c$ |
| D1 | the $k\le2$ closure located in [REVIEW_r63](../reviews/REVIEW_r63.md), the loop named, and the debt restated as transcription |
| D4, D16 | the missing middle enumerated by name, and one tiling of $(0,A_0]$ replacing three |
| D6 | the endpoint expansion no longer stands as the last band's argument; the band goes to bisection, as the withdrawal four sections below already said |
| D8 | the band peaks at $A=\tfrac13$ because it stops there, $\beta$ vanishing being a coincidence at that point |
| D3, D9 | both unreached cases stated: $t/T=\tfrac32$ at three equal positives with $b=c$, outside the quantified range; and $W=0$, now excluded by the unit norm added to the canonical statement |
| D17 | $\alpha,\beta,\gamma,T$'s second senses tabled in [conventions.md](../findings/conventions.md) beside the collision they make with the block's own first half |

### What stays owed

**Three debts, none of which this loop may discharge.** The one-negative maximisation at every $k$. The transcription of the endgame's middle from [REVIEW_r63](../reviews/REVIEW_r63.md) into [findings/](../findings/). And $(\tfrac13,A_0]$, which closes by $200$-bit interval arithmetic with branch-and-bound, rigorous, self-declared, and an open hypothesis to a loop that does no numerical work.

### Queued elsewhere

- **Research loop.** $\mathbb{CP}^m$ at $m\ge3$ and the subalgebra-Casimir family are untested against this bound for want of a closed-form spectrum on the record.
- **Multiplicity** appears in neither copy of the statement and is what made [L33](../findings/stratum-two-negative.md) false as quoted; whether L35 needs it is unexamined.
