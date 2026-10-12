# Round L39, the two-eigenvalue formula for an arbitrary symmetric pair

**Id:** L39 · **Date:** 2026-09-07 · **Verifiers:** v224, v225, v226 · **Brief:** [BRIEF_L39.md](BRIEF_L39.md)

## Sources, verbatim

| passage | source |
|---|---|
| the canonical entry | [results.md](../results.md) lines 525-531 |
| the landscape statement | [results.md](../results.md) line 164 |
| the block | [findings/target.md](../findings/target.md) lines 655-677 |

## The findings from phase 0

**Two closed forms for $\theta^2$ stand in one block, one in three invariants and one in four**, the shorter in an annotation and the longer in the prose below it. **Both went out unlabelled.** *An annotation offering a stronger form than the text it annotates is the shape [ROUND_L38](ROUND_L38.md) met one block earlier*, and the round is asked which the derivation supports and what the canonical form should be.

**The record says this copy is the stalest of three.** *"This copy is the stalest of the three: [report/](../report/) carries both…"*, **so a third statement exists outside [findings/](../findings/) and [results.md](../results.md)**, and the round must say whether the three agree.

**The block is again in the report's LaTeX**, `\[…\]` with `\kk` and `\mm` macros, so it does not render where it lives, the second block in two rounds carrying that defect.

**An annotation records a gap the canonical copy guards against and this one does not**: *"NO ADMISSIBILITY HYPOTHESIS, AND THIS COPY DROPPED THE GUARD THE CANON CARRIES."* **A formula that values an operator which is generically not a Weyl tensor is exactly what [ROUND_L38](ROUND_L38.md) has just filed a debt against**, since L38's second family is evaluated by this formula.

**And this round inherits a finding.** [ROUND_L38](ROUND_L38.md) recorded that two columns of this result's table are generic-$m$ data read at every $m$: $h^\vee(\mathfrak{so}(m))=m-2$ with $I_\rho=2$ **fails at $m=3$, where $h^\vee(\mathfrak{so}(3))=2$, and at $m=4$, where $\mathfrak{so}(4)$ is not simple.** *The product $c=m-2$ was found to survive at both by a doubling argument, so no value moved, the round should confirm that and repair the columns.*

## What the verifiers are asked beyond the standing list

Whether the four-invariant form is correct and whether the three-invariant reduction follows, including $S_{\mathfrak{kmm}}=cq/2$ and $S_{\mathfrak{kkk}}=c(p-q/2)$; whether both vanishings are properties of the decomposition rather than of the grading; whether $q\le2p$ holds for every symmetric pair with $\mathfrak g$ simple with equality exactly when $\mathfrak k$ is abelian; whether the balanced pair's numerator really collapses to $4k^2(k-1)^2(2k-1)$ and returns $\theta_0(n)^2$ exactly; **what admissibility hypothesis the formula needs**, given that it values operators that are generically not Weyl tensors and overshoots at unbalanced sphere pairs; and **whether the $(1,3,3,1)$ weights close only in the ordered reading**.

## Adjudication

**Verdicts: [v224](VERIFY_v224.md), [v225](VERIFY_v225.md), [v226](VERIFY_v226.md) all `PROVEN, hypotheses corrected`. Round verdict: `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED`.** *Unanimous, and the second unanimous pass of this run.*

### The two formulas are one expression, and the record was one row short

**All three derived the four-invariant form in full from the ansatz** (with the denominator $4p^3q(p+q)^3$ **produced** by $a^6=q^3/(p^3(p+q)^3)$ rather than asserted) and all three confirmed the reduction. **The load-bearing step holds**: the $\mathfrak m$-row Killing split gives $S_{\mathfrak{kmm}}=cq/2$, using $\mathfrak g$ simple and nothing about $\mathfrak k$, so it survives a centre in $\mathfrak k$. The reduction is exact through $3p^2+2pq-q^2=(3p-q)(p+q)$.

**So "$\theta$ depends on $p,q,S_{\mathfrak{kkk}},c$ alone" is true and one invariant too many.** *The record read the $\mathfrak k$-row of a two-row system and stopped.* **The four-invariant display stays as the general statement**, two verifiers noted it survives where $\mathfrak g$ is not simple, a region this record exercises, **and the three-invariant form is canonical wherever simplicity holds.**

| id | step attacked | mechanism | support | outcome |
|---|---|---|---|---|
| **C1** | both closed forms, both vanishings, the reduction | independent re-derivation | 3/3 | `CONFIRMED` |
| **C2** | the invariant count | the $\mathfrak m$-row determines $S_{\mathfrak{kkk}}$ | 3/3 | `CONFIRMED`, corrected to three |
| **C3** | $q\le2p$, equality iff $\mathfrak k$ abelian | needs $c>0$, unstated | 3/3 | `CONFIRMED` |
| **C4** | the maximiser's collapse and exact $\theta_0$ | needs $k\ge3$, unstated | 3/3 | `CONFIRMED` |
| **C5** | admissibility | the guard is in the canon and absent here | 3/3 | `CONFIRMED` |
| **C6** | *"overshoots at unbalanced sphere pairs **every time**"* | one pair three times below | 1/3 | **`REFUTED`**, see below |
| **C7** | the argument given for admissibility | it presupposes Conjecture A | 1/3 | **`CONFIRMED`, circular** |
| **C8** | *"L114's $6/4/2$ is the unordered form"* | $6/4/2$ ordered is one row; $(1,3,3,1)$ is two | 2/3 | **`REFUTED`** |
| **C9** | *"$S_{XYZ}$ is defined nowhere"* | | 3/3 | **`STALE`**, by 51 seconds |
| **C10** | *"$[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$ closes the split instead"* | it is a consequence, not a hypothesis | 2/3 | `CONFIRMED` |
| **C11** | four unstated hypotheses, plus ambient $\mathfrak k\perp\mathfrak m$ | | 2/3 | **`HYPOTHESIS-DEBT`**, all now stated |
| **C12** | the $c$ table's generic-$m$ data | | 3/3 | `CONFIRMED`, **and wider than inherited** |

### C6 and C7, where the annotations failed in the direction the round least expects

**Two of the five annotations assert things that are false, and one of the two was doing the work.** *"At unbalanced sphere pairs it overshoots the true $\theta$ every time"* is refuted by $(\mathfrak{so}(9),\mathfrak{so}(8))$: $p=28$, $q=8$, $c=14$ give $\theta^2=\tfrac7{18}$, **a factor of three below $\Theta_9^2=\tfrac{48}{35}$**, screened here exactly. The near-balanced statement it means is true, with gap $\frac{24k^4-6k^3-5k^2+4k-1}{4k^4(2k+1)(k+1)(2k-1)}>0$, *and has no argument on file.*

**Worse, the overshoot was the record's argument that the ansatz is generically not a Weyl tensor, and that argument is circular**, since "overshoots the true $\theta$" presupposes Conjecture A. **The non-circular witness is the direct failure of Ricci-flatness**, and the block now says so. *This is the debt [ROUND_L38](ROUND_L38.md) filed one round earlier, arriving from the other side: L38's second family is valued by this formula, and the reason the record gave for distrusting the formula could not be used.*

### C12, wider than the round inherited

[ROUND_L38](ROUND_L38.md) recorded that $h^\vee(\mathfrak{so}(m))=m-2$ with $I_\rho=2$ fails at $m=3$ and $m=4$. **Two verifiers found row 1 of the same table breaking identically at $n=3$**, where $2h^\vee/I_\rho$ returns $4$ against the true $c=2$. *The metric-doubling argument rescues every $c$ value the record uses, so no value moves*, **the $h^\vee$ and $I_\rho$ cells do**, and the block now carries the failure rather than the table.

### The verdicts that were withdrawn or reversed

**C9 is stale by fifty-one seconds**, an annotation written minutes before the convention it says is missing was committed. *That is the third stale annotation this run, after [ROUND_L38](ROUND_L38.md)'s and [ROUND_L30](ROUND_L30.md)'s*, and the pattern is now firm enough to state: **a block's annotations decay at a different rate from its prose, and a round that trusts them inherits a record that was true once.**

### What is not repaired here

**Nothing.** *Every finding was a correction, and all are applied*, the block is rewritten from the report's LaTeX into this record's, its five annotations resolved into prose or removed, the four hypotheses stated, the invariant count fixed in both copies, and the $p,q$ collision inside [target.md](../findings/target.md) flagged at its site.

