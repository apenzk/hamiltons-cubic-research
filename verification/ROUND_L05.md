# ROUND_L05, the census of rival critical-point families

**Date:** 2026-09-07. **Phase:** 6, closed. **Verdict:** `GAP`, repaired, impact `NARROWS`. **Verifiers:** v158, v159, v160. **The first tier-2 round.**

## Sources, verbatim

| what | where |
|---|---|
| Canonical statement | [results.md](../results.md), block `##### Lemma L5, rival critical-point families` |
| Landscape statement | [results.md](../results.md), the `Lemma L5 (landscape)` bullet |
| The block | [graded-half.md](../findings/graded-half.md) lines 41–64 |
| Brief | [BRIEF_L05.md](BRIEF_L05.md) |

## Three findings from phase 0, before any verifier read it

**1. The record labels this result two different ways in four files.** [INDEX-results.md](../findings/INDEX-results.md) records it as **downgraded to `Observation`** by Gate 2; [graded-half.md](../findings/graded-half.md) heads it `Observation L5`; [INDEX.md](../findings/INDEX.md) calls it *"Canonical Lemma L5"*; and [results.md](../results.md) heads it `Lemma L5` and repeats `Lemma L5 (landscape)` in its bullet. *A downgrade that reached two of four files.*

**2. The canonical statement still carries the refuted census.** [results.md](../results.md)'s block opens *"Six further families lose to both named competitors"* and closes on *"top out at $P\le0.837$"*, the count, the comparative and the ceiling that Gate 2 refuted, and that the findings block corrects to *"Five further families, of which four lose to both named competitors and one ties."* **The landscape bullet twenty lines away was repaired and the canonical block was not.**

**3. The findings block annotates where the loop's rule says replace.** It carries a refutation blockquote of six paragraphs followed by the original defective text with corrections woven through it, so the file states its own history rather than its mathematics and a reader must decide which of two passages to believe.

## What the verifiers are asked beyond the standing list

Whether the surviving claim, that the census's families lose to the **balanced** product, which is what Conjecture A concerns, holds; whether $\theta<\sqrt{2/(k-1)}$ for a $k$-block sphere product is proved rather than checked; and whether the two admitted-open classes, the strongly-regular-graph solutions swept only to $n=200$ and the non-Lie-group simple-isotropy members whose $(n,r)$ list is nowhere on the record, are correctly scoped as open.

## Clustering, all three in, all `GAP`

| id | step attacked | mechanism | support |
|---|---|---|---|
| **F1** | [results.md](../results.md)'s canonical block | never rewritten, it still reads *"Six further families lose to both named competitors"*, verbatim the sentence Gate 2 refuted, **under a `Lemma` heading the same Gate 2 withdrew**, while [graded-half.md](../findings/graded-half.md) carries the corrected *"Five … four lose … one ties"* | v159 |
| **F2**, **THE ROUND'S ONE SPLIT** | the multi-block theorem $\theta<\sqrt{2/(k-1)}$ | **v159: proved for $k\le4$ and cited for all $k$**, its source says *"verified symbolically for $k=2,3,4$"* while the entry reads *"3+ factors"*, so $k\ge5$ has no argument. **v158: `CONFIRMED AS ALGEBRA` for every $k\ge2$ and every $n_a\ge2$**, the printed identity being equivalent to [ungraded-slack.md](../findings/ungraded-slack.md)'s own closed form, with the two denominators shown equal by $(n-1)^2-(n-n_a)^2=(n_a-1)(2n-1-n_a)$ | split |
| **F3** | the *"hence"* from $\lVert W\rVert^2$ to $\theta$ | it consumes $\theta=1/(2\lVert W\rVert)$, cited nowhere at that step. **That is [L46](../findings/problem.md), carrying four hypotheses** (locally symmetric, Einstein, $\lambda\ne0$, $\lambda=\tfrac12$) and *they fail on the census's own strongly-regular and $\mathfrak{su}(m)$ items*. [graded-half.md](../findings/graded-half.md) separately records the identity as undischarged at $k\ge3$. **The conclusion is repairable from the vertex solution plus $t=2$ with no Einstein hypothesis at all** | v158, v159 |
| **F4** | *"an infinite such family exists whenever $p,q\ge5$"* | inverts a necessary condition into a sufficient one. $S^5\times S^5$ gives $\theta=6/5$ exactly and $S^5\times S^6$ gives $40/27$, both below $\sqrt{3/2}$; the exceptions are exactly $(5,5)$, $(5,6)$, $(6,5)$, and **the true condition is $\tfrac1{p-1}+\tfrac1{q-1}-\tfrac1{p+q-1}<\tfrac13$** | v158, v159 |
| **F5** | the $\lVert W\rVert^2$ identity at $\ker W\ne0$ | **false as written**, it reads the ambient $n$, which padding changes while $\lVert W\rVert$ does not. Exhibited at $(S^3)^3$ padded into $\mathbb R^{12}$: $27/64$ against $75/176$. *The bound survives padding, for a reason the block does not give* | v159 |
| **F6** | the landscape's *"margin of $0.109$"* | that is $\mathbb{HP}^2$'s margin against one competitor. **The census-wide margin is $0$**, Fox's $r=4$ tying, and at $n=8$ where $\mathbb{HP}^2$ lives the margin against $\theta_0(8)$ is $0.030$ | v159 |
| **F7** | the Lemma L23 sentence | an even-$n$ claim used unrestrictedly: at $n=7$ the cap $35/4$ is not an integer and the balanced split's $r=9$ exceeds it | v159 |
| **F8** | *"four lose to both named competitors and one ties"* | **still has no $n$-quantifier, and it fails below the crossover.** At $n=8$ Fox's $\mathbb B$ sits at $\sqrt{3/2}=1.224745$ against $\theta_0(8)=\sqrt{21}/4=1.145644$, it **beats** a named competitor rather than tying. *The corrected comparative repeats the uncorrected one's error at a different dimension* | v158 |
| **F9** | *"the open two"* | **the strongly-regular half is not open.** [L144](../findings/diagonal-half.md) proves $\theta<\tfrac12$ for every primitive SRG at every $n$, and settles the imprimitive half in closed form; the census cites its own $n\le200$ sweep and neither [L74](../findings/diagonal-half.md) nor L144. *A third instance of the exact fault this block credits itself with having found twice* | v158 |
| **F10** | *"top out at $P\le0.837$"* and *"threatens nothing ($P=0.387$)"* | the letter is $P$ and the quantities compared throughout the same paragraph are $\theta$'s, which agree only at unit norm, the record's own value for the $\mathfrak{su}(3)$ point being $\theta=\sqrt{7/10}=0.836660$ | v158 |

## Confirmed by derivation, and one of them strengthens the record

**$\sup_m\theta(\mathbb{HP}^m)=\sqrt{56/45}$**, closed form, derivative and cubic positivity all check by hand, and the function is monotone on every real $m>1$, **so the supremum covers all $m$ and the canonical statement's $m\le4$ is weaker than what is proved**. **$S^5\times S^7$ at $\theta^2=264/175$** reproduced three independent ways. **And the surviving conclusion generalises**: $\theta_0(12)=\sqrt{55}/6$ exactly, and convexity of $1/(n_a-1)$ extends the comparison to every $n$, **odd $n$ included**, read against $\Theta_n$ rather than $\theta_0(n)$, at $n=11$ the family maximum and $\Theta_{11}$ are the same number, $40/27$, as they must be.

**Deninger–Grundhöfer–Kramer read at source**: its hypotheses hold where used, with one unstated restriction, the paper lives entirely on the diagonal locus and its Theorem 5.1 needs exactly two off-diagonal values.

## Adjudication

**Verdict `GAP`, repaired. Impact `NARROWS`.** Three verifiers, three `GAP`s, and the result is materially weaker than the record stated: **the census establishes a comparison against the balanced product and nothing against padded $W_{\mathbb{CP}^2}$**, which is the reading the block asserted in every version it has had.

### F2 is settled by derivation, and both verifiers were right about different objects

**v160 supplies the resolution.** The *implication* from the printed $\lVert W\rVert^2$ identity to $\theta<\sqrt{2/(k-1)}$ is one line from the record's own $\theta^2$ closed form and holds at every $k$ and every $n$, which is v158's `CONFIRMED AS ALGEBRA`. **The debt sits on the identity itself**, which [ungraded-slack.md](../findings/ungraded-slack.md) records as *"verified symbolically for $k=2,3,4$"* while this entry consumes it at every $k\ge3$, which is v159's `HYPOTHESIS-DEBT`. *The smallest uncovered case is $(S^2)^5$ at $n=10$.* **No adjudication pair was needed; the two verdicts attach to different steps.**

### The finding that recurs, and this is its third instance in one block

**Three separate times this block has recorded as open, or as measured, something the record had already proved.** The multi-block family, closed in form by [ungraded-slack.md](../findings/ungraded-slack.md). The quaternionic family, closed by a supremum proved $150$ lines below in its own file. And now the strongly-regular family, closed at every $n$ by [L144](../findings/diagonal-half.md), *promoted at 22:50 on 2026-09-04, while the L5 rewrite three hours earlier still reads "swept only to $n=200$"*. **The block credits itself with having caught this fault twice.**

### The ceiling was false and its correction was already on the record

*"The simple-isotropy members top out at $P\le0.837$"* fails at $\mathfrak{spin}(9)\subset\mathfrak{so}(16)$: [L4](../findings/ungraded-slack.md)'s own formula $\theta=\tfrac2n\sqrt{rN/(N-r)}$ at $(n,r,N)=(16,36,120)$ gives $\theta=\tfrac34\sqrt{10/7}=0.896421$. **The correction sits in [ungraded-slack.md](../findings/ungraded-slack.md) and was stale in three files.**

### The repairs, all applied

| finding | what changed |
|---|---|
| F1, F11 | [results.md](../results.md)'s canonical block rewritten and reheaded `Observation`; the landscape bullet rewritten, its self-contradiction (six families *"eliminated on value"* while conceding one attains $\sqrt{3/2}$), removed; [INDEX.md](../findings/INDEX.md) relabelled. **All four files now agree** |
| the annotation | the findings block replaced rather than annotated: seven rows in a table, each with its value and its status, and no passage a reader must weigh against another |
| F2 | the debt placed on the identity where it belongs, with the smallest uncovered case named, and the implication stated as general |
| F3 | [L46](../findings/problem.md) named with its four hypotheses, its scope stated as *irreducible* symmetric spaces against objects that are products, and the repair route recorded, vertex solution plus $t=2$, no Einstein hypothesis |
| F4 | the true condition $\tfrac1{p-1}+\tfrac1{q-1}-\tfrac1{p+q-1}<\tfrac13$ replaces $p,q\ge5$, with both failures named |
| F5 | $n=\sum_an_a$ stated as a hypothesis, with the two padded objects at which the identity fails, one of which reverses the block's own headline |
| F6, F8 | the margin claim removed; what the census establishes is now stated as the balanced-product comparison alone, and Fox's $r=4$ beating $\theta_0(8)$ is on the face of it |
| F9 | the open classes are one, not two, and [L144](../findings/diagonal-half.md) and [L74](../findings/diagonal-half.md) are cited where the $n\le200$ sweep was |
| F10 | every value in the block is a $\theta$, said once |
| the ceiling | $0.896421$ at $\mathfrak{spin}(9)\subset\mathfrak{so}(16)$ replaces $0.837$ |

### What the round gained

**The balanced-product comparison now holds at every $n$ and both parities**, by convexity of $1/(n_a-1)$ read against $\Theta_n$, where the block checked one point. At $n=11$ the two-factor maximum and $\Theta_{11}$ are the same number, $\tfrac{40}{27}$, as they must be. **And the quaternionic supremum covers every real $m>1$**, where the statement claimed $m\le4$.

### Queued elsewhere

**Research loop.** The $\lVert W\rVert^2$ identity at $k\ge5$, smallest case $(S^2)^5$ at $n=10$. The derivation of the norm-to-$\theta$ step from the vertex solution and $t=2$, which would remove [L46](../findings/problem.md)'s four hypotheses from this chain. And the $(n,r)$ list of the non-Lie-group simple-isotropy members, the one genuinely open class.
