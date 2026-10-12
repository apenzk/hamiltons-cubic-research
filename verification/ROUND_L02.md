# ROUND L02, the dimension threshold, with a third form that names its own gap

**Id:** L02. **Source:** [findings/problem.md](../findings/problem.md):160–176. **Date:** 2026-09-06. **Verifiers allocated:** v95, v96, v97. **Phase:** 6, closed. **Verdict:** `GAP`, repaired, impact `NARROWS`.

**Why this id.** Tier 0, next after L00. *Its prior audit recorded that **the number is right and the block had none of the proof**, the proof was supplied then, and has not been read since.*

**Its third form is `partial` and says exactly what it owes**, which no round has read against the prose: [L2.lean](../lean/HamiltonsCubic/Results/L2.lean) holds *"the whole threshold argument: the balanced specialisation of the sphere-product formula, the identity $\theta_0(n)^2-\tfrac32=\tfrac{n^2-12n+8}{2n^2}$, the root $6+2\sqrt7$ and its irrationality, the integer cutoff $12$ in both directions, and the odd-parity companion"*, while **$\theta_0(n)^2$ for the balanced sphere product stays imported**, and the extension of $\theta^2=\tfrac32$ from $n=4$ to every $n\ge4$ by padding **is not formalised.**

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on either.)*

1. **Does the prose prove what the kernel imports?** *Two things are imported rather than checked, the competitor's value beyond $n=4$, and $\theta_0(n)^2$ itself.* **Find where the block establishes each, and say whether the argument there is a proof or a citation.**
2. **Is the threshold a threshold in both directions?** *A cutoff at $12$ needs $n\ge12$ sufficient **and** $n\le11$ insufficient.* **Check each direction separately, and check what happens at the irrational root itself.**

**One trap named from outside.** *The round before this found a published constant substituted for a different one that agrees at even $n$ and differs at odd $n$.* **Check every constant here for parity dependence, and say which the block's argument actually uses.**

**A source is read, never cited from memory.** *If a source is not in [references/](../references/), say the claim rests on an unread source.*

## The brief as dispatched

*Provenance stripped, mathematics verbatim, quoted from the current source.*

#### Lemma L2, exact dimension threshold, canonical statement and proof

*Moved here from [results.md](../results.md) on 2026-08-31. **The claim once made here, that results.md held the only copy, is false against the commit before the move**: this file already carried a block for this result.*

Needed to pin down where the known critical points rank. $n=6+2\sqrt7\approx11.29$ is exactly where the balanced sphere-product overtakes the $\mathbb{CP}^2$-type competitor (Fox's $\mathcal S^4(\alpha)$).

**Proof.** The balanced product has $\theta_0(n)^2=\frac{2(n-1)(n-2)}{n^2}$, the special case $p=q=n/2$ of $\theta(S^p\times S^q)^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$. The competitor has $\theta^2=\frac32$ at every $n\ge4$, since $\mathfrak{su}(2)_+$ is a subalgebra and $W^\#$ therefore stays inside $\Lambda^+$ under padding. Then
\[
\theta_0(n)^2-\tfrac32=\frac{n^2-12n+8}{2n^2},
\]
whose numerator is $-3$ at $n=11$ and $+8$ at $n=12$, with root $6+2\sqrt7$. Both inputs are $n$-uniform closed forms derived without reference to any threshold, so the crossing is not circular; the root is irrational, so no integer attains it and the crossing is strict on both sides. $\square$

**Two things are exact here and they are different**: the real root of the formally continued formula, and the integer cutoff $12$. **At odd $n$ the real crossover is a different number**, $\Theta_n^2\ge\frac32$ is $n^2-13n+18\ge0$, root $\frac{13+\sqrt{97}}2=11.4244$, while the integer threshold $12$ survives at both parities.

> **THE FIRST VERSION CLAIMED THIS BLOCK HELD A PROOF AND THAT THE THRESHOLD WAS "derived three independent ways", AND NEITHER WAS SO.** The block carried three sentences and no argument, and the move-note above, which says the argument was the only copy in [results.md](../results.md), is false against that file's first commit, where the same three sentences already stood. **What exists is three derivations of $\theta_0(n)$ and two of $\sqrt{3/2}$**, one of the three routes never computing the competitor at all; and the record's "third", "fourth" and "fifth appearances" of the polynomial are those same two numbers redressed. **$\theta(\mathcal S^4(\alpha))=\sqrt{3/2}$ is a single point of failure for all of them**, correct, and load-bearing alone. *an audit, a prior review and a prior review on identical briefs, both CONFIRMED, the proof above transcribed from what they rebuilt.*


## Phase 2, the clustering

**Reports:** [VERIFY_v95](VERIFY_v95.md) `GAP`, [VERIFY_v96](VERIFY_v96.md) `GAP`, [VERIFY_v97](VERIFY_v97.md) `PROVEN, hypotheses corrected`. Clustered by the step attacked and the mechanism, never by wording.

| # | step attacked | mechanism | support |
|---|---|---|---|
| **C1** | the parity clause after the $\square$ | $\Theta_n$ named but never defined, its closed form absent, $n^2-13n+18$ stated and never derived, and neither $n=11$ nor $n=13$ evaluated, so the odd half is *reported*, not proved | v95, v96, v97 |
| **C2** | the proof body's witness at $n=11$ | $\theta_0$ read at an odd integer: the excess $-\tfrac3{242}$ belongs to no object, the attained one being $\Theta_{11}^2-\tfrac32=-\tfrac1{54}$ at $S^5\times S^6$ | v95, v97 |
| **C3** | "derived three independent ways" | withdrawn at [INDEX-results.md](../findings/INDEX-results.md) and in the block's own note, still standing at [results.md](../results.md):112, :302 and [problem.md](../findings/problem.md):146 | v95, v96, v97 |
| **C4** | [lean/INDEX.md](../lean/INDEX.md):273, the W5 row | $\theta_0$'s polynomial worn under $\Theta_n$'s name; W5's own instances are even, so the integers survive and the reason does not | v95, v96, v97 |
| **C5** | the domain | the prose bounds $n$ nowhere and the quadratic has a second root at $6-2\sqrt7=0.7085$; `4 ≤ n` lives only in the kernel | v95, v96 |
| **C6** | the two input values | neither carries a pointer in the block; both are in [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md), Prop 2.25 and Thm 4.14(a), read at source by two verifiers | v96, v97 |
| **C7** | the best-split fact | that the near-balanced split beats every other is used by L2's consumers and proved in no form of L2 | v95, v96 |
| **C8** | [isotropy-cap.md](../findings/isotropy-cap.md):66, :68, :144, :153 | local labels "Lemma L1" and "Lemma L2" colliding with the record's own numbering; [r505](../reviews/REVIEW_r505.md) D5 and [r506](../reviews/REVIEW_r506.md) repair 6 asked for this and it was never applied | v96 |
| **C9** | [L2.lean](../lean/HamiltonsCubic/Results/L2.lean)'s docstring, and [lean/INDEX.md](../lean/INDEX.md):374 | the docstring says `𝒲ₙ` and `Q` "do not exist yet" while [Base/CP2.lean](../lean/HamiltonsCubic/Base/CP2.lean) proves from them; the owed-list omits $\Theta_n^2$ | v97 |

## Phase 3, adjudication

**C1 is the round, and the split verdict turns on it alone.** v97 checked the odd polynomial *itself* and found it right, so it read the clause as correct; v95 and v96 asked whether the *block* argues it and found nothing. Both readings are accurate and they answer different questions, **the mathematics is sound and the block does not contain it**, which is `GAP` and not `BROKEN`.

**What makes C1 bite, and it is not symmetry.** Insufficiency at odd $n\le11$ transfers from the block's even computation *a fortiori*, since $\theta_0(n)>\Theta_n$. **Sufficiency at odd $n\ge13$ does not**, there the inequality runs the wrong way, and the clause survives only because $\frac{13+\sqrt{97}}2-(6+2\sqrt7)=\frac{1+\sqrt{97}-4\sqrt7}2=0.1329$ contains no integer. Nothing in the block saw that margin.

**C2 is C1's cause rather than a second defect**, and is repaired with it: once the parities are separated at the point where the split is chosen, the odd witness is $\Theta_{11}$ by construction.

**C3, C4 and C8 are the record's signature failure, a correction landing beside the statement it corrects.** Three separate corrections, each applied where it was found and at none of the sites a consumer reads. C8 has stood since [r506](../reviews/REVIEW_r506.md).

**No candidate was withdrawn**, and no finding required computation.

## Phase 4, the fix

**Verdict: `GAP`. Impact: `NARROWS`**, every consumer of L2 may still cite the integer cutoff $12$, and a consumer citing the *constant* at odd $n$ was reading $\theta_0$ where $\Theta_n$ is attained.

The block is rewritten so the parity split happens where it is caused (at the choice of the best split) rather than being reported after the $\square$:

- **The statement now quantifies over $\max_{p+q=n}\theta(S^p\times S^q)$ and carries $n\ge4$**, so the domain is in the prose and not only in the kernel (C5).
- **The best-split fact is proved**, from $\frac{(p-1)(q-1)}{pq}=1-\frac{n-1}{pq}$ strictly increasing in $pq$, which is what makes the maximum over splits finite and is what forces the two constants apart (C7, and the cause of C1).
- **Both parities are evaluated**: $\theta_0$'s numerator at $n=10$ and $n=12$; $\Theta_n$'s at $n=11$ ($\tfrac{40}{27}$, excess $-\tfrac1{54}$, attained at $S^5\times S^6$) and $n=13$ ($\tfrac{120}{77}$, excess $+\tfrac9{154}$) (C1, C2).
- **The cutoff is argued from both parabolas at once**: smaller roots below $4$, larger roots irrational, and $0.1329$ between them containing no integer.
- **Both inputs now carry their source** (C6), and the block states what a consumer may cite and that $\theta_0$ at odd $n$ describes no object.
- Corrections applied at the sites of use: [results.md](../results.md):112 and :302, [problem.md](../findings/problem.md):146 (C3); [lean/INDEX.md](../lean/INDEX.md):273, :278, :374 (C4, C9); [isotropy-cap.md](../findings/isotropy-cap.md) relabelled to *Step 1* / *Step 2* (C8).

**One item is handed on rather than fixed**: [L2.lean](../lean/HamiltonsCubic/Results/L2.lean)'s stale docstring, filed under *Queued findings* in [plan-verification.md](../plan-verification.md), that folder being the lean loop's.

**The spread.** Two `GAP`, one `PROVEN (hypotheses corrected`, and no verifier contradicted another on a value), every hand evaluation in the three reports agrees. **The split is about what a block owes, not about the mathematics**, and it is the first round of the twenty-one where the disagreement was of that kind.
