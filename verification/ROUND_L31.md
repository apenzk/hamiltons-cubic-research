# ROUND_L31, the bracket cap, characterised

**Date:** 2026-09-07. **Phase:** 6, closed. **Verdict:** `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED`. **Verifiers:** v173, v174, v175.

## Sources, verbatim

| what | where |
|---|---|
| Canonical statement | [results.md](../results.md) lines 461–465 |
| Landscape statement | [results.md](../results.md) line 148 |
| The block | [stratum-two-negative.md](../findings/stratum-two-negative.md) lines 417–438 |
| The clause reassigned to it | [results.md](../results.md) line 451 |
| Brief | [BRIEF_L31.md](BRIEF_L31.md) |

## Findings from phase 0

**1. A dead anchor sits on the reassignment itself.** [results.md](../results.md) line 451 credits *"equality forces the support to have $r=4$"* to `[Lemma L31](../findings/fence-posts.md#post-f31-the-sharp-target-is-not-freely-described-and-n-cannot-be-smuggled-in-as-a-trace)`. **The heading is `Lemma L31 (the bracket cap, characterised`, so that anchor resolves to nothing**) and the index row records that *"two dead anchors sat on exactly the sentences that closure is reached through"*, which reads as a repair already made. *This one is live.*

**2. The statement carries a clause the block says it dropped.** The block's Statement adds *"the rank is derived for $X$ and follows for $Y$ by the symmetry of the bracket in its two arguments, **a clause the canonical block dropped**"*, and [results.md](../results.md)'s copy still states the rank symmetrically without that derivation.

**3. This result now carries a converse reassigned from elsewhere.** [L29](../findings/stratum-two-negative.md)'s clause *"equality forces the support to have $r=4$"* was moved here when [L72](../findings/stratum-two-negative.md) was found to quantify over the smaller set. **The reassignment has not itself been audited**, and the round should check that L31 as stated actually delivers it.

## What the verifiers are asked beyond the standing list

Whether the root-system identity $\max_{\lVert Y\rVert=1}\lVert[X,Y]\rVert^2=(s_1+s_2)^2$ is exact; whether the two-step chain $\lVert[X,Y]\rVert_F\le\lVert XY\rVert_F+\lVert YX\rVert_F\le2\lVert X\rVert_{\rm op}\lVert Y\rVert_F$ forces what the proof draws from it, and whether both inequalities can be equalities at once; whether $\mathrm{im}\,Y\subseteq\mathrm{im}\,X$ really symmetrises; and whether the converse computation $X^2=Y^2=-P_V/2$, $[X,Y]=2XY$, $\lVert[X,Y]\rVert^2=2$ is complete. **And what the corrected step's own counterexample $s^2=(0.5,0.3,0.2)$ shows**, given the block records the repair as *"supplied by the review"*.

## Clustering, all three in: two `PROVEN`, one `PROVEN, hypotheses corrected`

**`PROVEN`.** *Every step closes, and two of the round's own suspicions came back as strengthenings rather than defects.*

**The root-system identity is exact at every $n\ge3$**, $\mathrm{ad}_X$ is skew-adjoint under the Ad-invariant pairing, so the maximum is the largest spectral modulus, it is attained, and the maximiser can be taken perpendicular to $X$. **The short roots are present exactly at odd $n$** and are dominated, $s_1\le s_1+s_2$. **The two-step chain is tight rather than merely valid**: both sides equal $2$, and each of the three conclusions was derived separately. The converse closes, and **the $r=4$ clause is delivered in the three lines the record claims**, the cap being read off the pair $(v_{N-1},v_N)$ under total symmetry of $T$.

**The recorded correction holds**: $s^2=(0.5,0.3,0.2)$ is a valid counterexample to the old step, and the replacement excludes it exactly, $(s_1+s_2)^2=\tfrac45+2\sqrt{0.15}<\tfrac85<2$.

| id | finding | support |
|---|---|---|
| **M1** | **the dead anchor is confirmed and is unique to the reassignment sentence.** All five in-file citations use the correct form; only [results.md](../results.md)'s credit for *"equality forces the support to have $r=4$"* points at a heading that does not exist | v173 |
| **M2** | **orthogonality is stated, never used, and redundant.** The forward proof consumes only $\lVert X\rVert=\lVert Y\rVert=1$, and $XY=-YX$ gives $\mathop{\mathrm{tr}}(XY)=0$ by itself, *so L31 holds under a weaker hypothesis than it states* | v173 |
| **M3** | a symbol collision inside the file: [stratum-two-negative.md](../findings/stratum-two-negative.md) writes $v_{N-1},v_N$ and then $v_2,v_3$ for the same pair. **Correct only under the support labelling**; under descending order $v_2,v_3$ are kernel eigenvectors and the claim is false of them | v173 |
| **M4** | five imprecisions: the short roots unqualified by parity, *"all singular values $1/\sqrt2$"* meaning *all nonzero*, $P_V$ and $V$ undefined, the $s_1\ge s_2$ ordering and the Cartan reduction both unstated, and the landscape entry's *"Cauchy–Schwarz forces the rest"* overstating by one clause | v173 |

**The norm mismatch the brief flagged does not bite.** The chain is homogeneous of degree one in the Frobenius-type norm, so both readings give the same equality; the factor of two lands entirely on $\sum s_i^2=1$, which [conventions.md](../findings/conventions.md) fixes, *and which is pinned independently by [L29](../findings/stratum-two-negative.md) returning $\sqrt{3/2}$ at $(2,-1,-1)/\sqrt6$.*

**A non-vacuity witness, which the block never carried.** At $n=4$: $X=\tfrac1{\sqrt2}(\varphi_{12}+\varphi_{34})$ and $Y=\tfrac1{\sqrt2}(\varphi_{13}-\varphi_{24})$, with $[X,Y]=-(\varphi_{23}+\varphi_{14})=2XY$ and $\lVert[X,Y]\rVert^2=2$, every clause checked by hand in the record's own basis. *The same family already sat in this file, unlinked from the lemma it witnesses.*

**All five downstream consumers stay inside what is proved.**

## Adjudication

**Verdict `PROVEN, hypotheses corrected`, repaired. Impact `CONTAINED`.** *The first result in this audit to survive with its mathematics untouched.* Three verifiers derived the root-system identity independently, all three built the equality witness, and **none found a mathematical defect in either direction**. Every finding is about what the statement says rather than what the proof does.

### The finding with the widest reach

**The cap $\lVert[X,Y]\rVert^2\le2$ was not in the statement.** [conventions.md](../findings/conventions.md) and seven consumer sites, [L29](../findings/stratum-two-negative.md), [L35](../findings/stratum-two-negative.md), [L42](../findings/stratum-two-negative.md), [L143](../findings/bounds.md) and three more, cite L31 for exactly that inequality, **and it stood only inside the proof** while the statement gave the equality case alone. *A consumer reading the canonical form found no cap to cite.*

### A hypothesis that was never a hypothesis

**Orthogonality is stated and used nowhere**, in either direction. The forward proof consumes only $\lVert X\rVert=\lVert Y\rVert=1$, and $XY=-YX$ delivers $\mathop{\mathrm{tr}}(XY)=0$ by itself, *so orthogonality is a consequence of the equality case, and the lemma holds verbatim with "unit" in its place.* All three verifiers reached this separately.

### And a conversion the whole chain rests on

$\lVert Z\rVert_F^2=2\lVert Z\rVert^2$ is load-bearing and was **never written**: the chain runs through $\lVert\cdot\rVert_F$ and $\lVert\cdot\rVert_{\rm op}$ while the statement runs through $\lVert\cdot\rVert$, and **read in plain Frobenius the block's own chain contradicts its hypothesis.** *The constant $2$ rests on that normalisation and nothing else, pinned independently by [L29](../findings/stratum-two-negative.md) returning $\sqrt{3/2}$ at $(2,-1,-1)/\sqrt6$.*

### The repairs, all applied

| finding | what changed |
|---|---|
| M5, the cap | the statement is now in two parts (the inequality, then its equality case), in both files |
| M2 | *unit* replaces *orthonormal*, with orthogonality recorded as a consequence |
| M6 | the normalisation stated in the block and tabled in [conventions.md](../findings/conventions.md), with what plain Frobenius would do to the chain |
| M1 | the dead anchor repaired, *a third instance of a defect [r543](../reviews/REVIEW_r543.md) and [r544](../reviews/REVIEW_r544.md) fixed twice in the findings file, surviving in [results.md](../results.md) on the one sentence that carries the reassigned clause* |
| M4 | the short roots qualified by parity, the identity's failure at $n=2$ recorded with its vacuity, *"all singular values"* read as *all nonzero*, the ordering and the Cartan reduction stated, and the landscape's *"Cauchy–Schwarz forces the rest"* replaced by the three steps that actually do it |
| tightness | the equality witness written into the block, with three closed-form near-misses, one per condition, *the block asserted the conditions independent and exhibited none of it* |

### What the round confirmed rather than repaired

**The reassigned clause is genuinely L31's.** *"Equality forces the support to have $r=4$"* closes in the three lines the record claims, the cap being read off the pair $(v_{N-1},v_N)$, whose eigenvectors are orthonormal in exactly L31's norm so the constant transports with no conversion. **All five downstream consumers stay inside what is proved**, and the recorded correction to the old $4s_1^2$ step is valid, its counterexample excluded by the replacement exactly.

### Queued elsewhere

**Lean loop.** [stratum-two-negative.md](../findings/stratum-two-negative.md)'s $v_{N-1},v_N$ against $v_2,v_3$ for one pair, correct under the support labelling and false under descending order. **And a stale hedge in the consumer**: the block derives $r=4$ and then reduces the biconditional to an $r\ge6$ nonexistence claim its own first half has made vacuous.
