# ROUND L29, the three-eigenvalue cap, its attaining object, and a dimension-free claim

**Id:** L29. **Source:** [findings/stratum-two-negative.md](../findings/stratum-two-negative.md):69–, with the canonical form at [results.md](../results.md):439 and the landscape line at :144. **Date:** 2026-09-07. **Verifiers allocated:** v149, v150, v151. **Phase:** 6, closed. **Verdict:** `PROVEN, hypotheses corrected`, repaired, impact `PROPAGATES`.

**Why this id.** Tier 1, cited eight or more times. It caps $\theta$ at exactly the rival maximizer's value on a whole spectral stratum, **dimension-free**, and the object attaining it is the rival maximizer itself.

**Blockquotes are included below.** *A round two ids ago stripped them as provenance and removed a refutation of the paragraph it quoted; nothing is filtered here.*

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on any.)*

1. **Is the cap right, and is it dimension-free?** **Derive it, and say at which step the dimension could have entered and why it does not. Check the claim at the smallest admissible $n$ and at a large one.**
2. **Does the attaining object satisfy the hypothesis?** *The cap is said to be attained at $(2,-1,-1)/\sqrt6$, identified with padded $W_{\mathbb{CP}^2}$.* **Check that this object has exactly one positive and two negative eigenvalues, that it lies in $\mathcal W_n$, and that its $\theta$ is $\sqrt{3/2}$, and say what its kernel does to the hypothesis.**
3. **What do the vanishing sign-blocks need?** *Three blocks of the cubic are said to vanish structurally.* **Check each, and say whether "structurally" means identically, or under a hypothesis the statement carries, or under one it does not.**

**A source is read, never cited from memory.** *If a source is not in [references/](../references/), say the claim rests on an unread source. This record holds no Cartan, Helgason, Berger or Besse entry.*

## The brief as dispatched

*Provenance stripped, mathematics verbatim, quoted from the current source, blockquotes included.*

Needed because the residual of route R9 is a value bound rather than a classification, and the sharpest
competitor sits where the hypothesis defining that residual is vacuous. The slack is the structure mass
carried by the negative eigenspace, $S(W)=\sum_{\lambda<0}c'^2_{\alpha\beta\gamma}$, and $c'$ is
antisymmetric in three indices, so $S$ vanishes identically once $\dim\mathfrak m\le2$. Padded
$W_{\mathbb{CP}^2}$ has spectrum $(2,-1,-1)/\sqrt6$ and lies in that stratum.
**Statement.** Let $W\in\mathrm{Weyl}_n$ have $\|W\|=1$ and exactly one positive and two negative
eigenvalues, $\lambda_1>0>-a\ge-b$. Then $\theta(W)\le\sqrt{3/2}$, attained at the spectrum
$(2,-1,-1)/\sqrt6$. The bound carries no dimension restriction. The converse, that equality forces
that spectrum, **is closed in three lines by [Lemma L31](../findings/stratum-two-negative.md#lemma-l31-the-bracket-cap-characterised-canonical-statement-and-proof), at every $n$ and with no numerics**: equality forces
$T_{1,N-1,N}=2$, hence $\lVert[v_{N-1},v_N]\rVert^2=2$, hence $\operatorname{im}v_2=\operatorname{im}v_3$ of dimension $4$, hence $r=4$ through Ricci-flatness.
[Lemma L33](../findings/stratum-two-negative.md#lemma-l33-one-eigenvalue-of-one-sign-forces-the-tensor-to-vanish-canonical-statement-and-proof) closes it by a second route.
> **THE CREDIT ONCE GIVEN HERE TO [LEMMA L72](../findings/stratum-two-negative.md#lemma-l72-the-rank-3-stratum-is-overdetermined-and-its-converse-clause-closes-in-three-lines) IS WITHDRAWN, AND THE CONTAINMENT RUNS THE OTHER WAY.** L72 quantifies over **critical** points; this clause quantifies over **equality** points, and by this lemma together with L72 the critical points are a *subset* of the equality points, so L72 is the weaker statement and cannot close it. *What the numerics at $r=6,8,10$ hedged was the realisability of a full-support rank-$3$ element, which the criticality rows do not touch.* *Gate 2, [r541](../reviews/REVIEW_r541.md) and [r542](../reviews/REVIEW_r542.md) on identical briefs, agreeing.*
**Proof.** In an eigenbasis, $\langle W,W^\#\rangle=\tfrac12\sum T_{\alpha\beta\gamma}\lambda_\alpha
\lambda_\beta\lambda_\gamma$ with $T=c'^2$ nonnegative and totally symmetric. Split by the signs of the
three indices. Three blocks vanish, each structurally rather than numerically: $(+++)$ and $(++-)$ need
two or three distinct positive indices while only one exists and $T$ vanishes on repeated indices;
$(---)$ needs three indices in a $2$-dimensional space, where a form antisymmetric in three indices is
identically zero. Only $(+--)$ survives, equal to $3\,T_{1,N-1,N}\lambda_1ab$, and the pair cap
$\sum_\gamma T_{\alpha\beta\gamma}=\|[v_\alpha,v_\beta]\|^2\le2$ bounds it, giving
$\langle W,W^\#\rangle\le6\lambda_1ab$ against the exact $\operatorname{tr}W^3=\lambda_1^3-(a^3+b^3)$.
Trace-freeness gives $\lambda_1=a+b$ and unit norm $(a+b)^2+a^2+b^2=1$; both are scale-free in $t=b/a$,
and substituting collapses the estimate to
$$\theta\le f(t)=\frac{9\sqrt2\,t(t+1)}{4\,(t^2+t+1)^{3/2}},$$
whose unique stationary point on $t\ge0$ is $t=1$, with $f(1)=\sqrt{3/2}$, $f(0)=0$ and $f\to0$ as
$t\to\infty$. Hence the maximum is $\sqrt{3/2}$, attained only at $a=b$. $\square$
**The single inequality is an identity on this stratum.** Ricci-flatness reads
$\lambda_1v_1v_1^{\mathsf T}=a\,v_2v_2^{\mathsf T}+b\,v_3v_3^{\mathsf T}$ with all three terms positive
semidefinite, so the support of $W$ is exactly $\mathrm{im}\,v_1$, of even dimension, and at dimension
four $v_2,v_3$ are an orthonormal pair in $\Lambda^+\cong\mathfrak{su}(2)$, where every orthonormal pair
brackets to norm-squared $2$. The pair cap is therefore saturated identically and $\theta=f(t)$ exactly,
not merely at the maximiser. **Gate 2 passed** ([r513](../reviews/REVIEW_r513.md) and [r514](../reviews/REVIEW_r514.md), both CONFIRMED, each re-deriving the chain cold; earlier by Reviewers 58 and 59 on identical briefs, independent
implementations, both CONFIRMED, and both found the stratum to be the one-parameter family
$W^+=\mathrm{diag}(q+r,-q,-r)$ with $\theta=9qr(q+r)/\|W\|^3$ exactly
([b_two_negative_stratum.py](../scripts/route-b/b_two_negative_stratum.py)).
**What it settles and what it does not.** Since $\sqrt{3/2}<\theta_0(n)$ from $n=12$, no maximiser in that
dimension range has this spectrum, which excludes the nearest known competitor without any enumeration,
and enumeration has since been refuted on both halves of the residual. **It reaches $k=2$ as well, and the reason first given for stopping at $k=1$ is wrong on both counts.** $(+++)$ does not reappear at $k=2$, needing three distinct positive indices; and $(++-)$ reappearing costs nothing, since it enters with $\lambda_+\lambda_+\lambda_-<0$ against $T\ge0$ and is free to drop from an upper bound. What the extension actually turns on is the **joint** cap $T_{1,N-1,N}+T_{2,N-1,N}\le2$ rather than the per-index one, which alone would give $3a$ with maximum $1.5$. *Gate 2, [r513](../reviews/REVIEW_r513.md) and [r514](../reviews/REVIEW_r514.md) on identical briefs, both CONFIRMED and reaching the same correction.* **Three or more positive eigenvalues stay outside**, and are covered by [Lemma L35](../findings/stratum-two-negative.md#lemma-l35-at-most-two-negative-eigenvalues-caps-theta-at-sqrt32-unconditionally).

## Phase 2, the clustering

**Reports:** [VERIFY_v149](VERIFY_v149.md) `GAP`, [VERIFY_v150](VERIFY_v150.md) `PROVEN, hypotheses corrected`, [VERIFY_v151](VERIFY_v151.md) `PROVEN, hypotheses corrected` with one clause `BROKEN`.

| # | clause attacked | mechanism | support |
|---|---|---|---|
| **C1** | the cap | *no defect.* Re-derived end to end three times, and **twice by routes sharing no step with the block's**, the exact factorisation $4(t^2+t+1)^3-27t^2(t+1)^2=\big((t-1)(t+2)(2t+1)\big)^2$, which gives cap *and* equality case at every real $t$ with no calculus, and the $n=4$ adjugate form $P=9(\det W^++\det W^-)$ | v149, v150, v151 |
| **C2** | dimension-freeness | *no defect, and the reason is exact*: $n$ could enter at one step only (the pair cap) and the chain buys its bracket bound there rather than from the row marginal $2(n-2)$, the sole dimension-carrying input in reach | v149, v150, v151 |
| **C3** | attainment | exact: $T_{1,N-1,N}=2$ computed entry by entry from $[\omega_1,\omega_2]=-\sqrt2\,\omega_3$, so the constant cannot be lowered, and $\theta=\sqrt{3/2}$ by four independent routes | v149, v150, v151 |
| **C4** | the converse's credit | **`BROKEN` at [results.md](../results.md):441 and :784**, credited to a lemma quantifying over *critical* points where the clause quantifies over *equality* points, with the containment running the wrong way. **And the repair is not a name swap**: the weak converse follows in two lines from this proof's own equality case, needing neither lemma; the strong one is the pair cap's, in three | v149, v150, v151 |
| **C5** | [LEDGER.md](../findings/LEDGER.md):915 | records that repair as complete across "five sites", **short by the two that matter, which are the two a consumer reads** | v149, v151 |
| **C6** | the exclusion clause | argues from $\sqrt{3/2}<\theta_0(n)$, the even-$n$ constant; at odd $n$ the constant is $\Theta_n$ and the premise supplies no witness. **The conclusion survives at both parities**, by $n^2-13n+18>0$ and $n^2-12n+8>0$ | v149, v150, v151 |
| **C7** | [results.md](../results.md):144 | drops the display fixing the multiplicity reading, **and the positive side is where the distinct-value reading destroys the proof**, with no covering result for that case | v150, v151 |
| **C8** | the $k\le2$ extension | the structural reasons are sound and written; **the two-parameter maximisation carrying the claim appears on no site**, and the covering lemma cannot discharge it, its own proof consuming this one at $k\le2$ | v149, v150, v151 |
| **C9** | "saturated identically, not merely at the maximiser" | an $r=4$ statement; a reviewer said so and it was never folded in | v150 |
| **C10** | the development block | carries "reduced but not closed" and a "closed" heading whose body says "$r\ge12$ untested", both retired by the canonical block sixty lines below | v149, v151 |
| **C11** | the attaining object's kernel | $\binom n2-3$, **the mechanism of the dimension-freedom rather than an exception**, but it voids the block's own motivating slack screen and makes the object another lemma's *exception* rather than its conclusion | v149, v151 |

**One item recorded as needing computation and not opened**: whether a witness exists under the distinct-value reading.

## Phase 3, adjudication

**The theorem is as solid as L36's.** Three cold rebuilds, and two of them by routes sharing no step with the block, one of which proves cap and equality case simultaneously at every real $t$ from a polynomial identity, with no calculus at all. **No falsifier exists among the record's families**: only the self-dual $\mathrm{Weyl}_4$ family carries the sign pattern, and on it $\theta=f(t)$ exactly.

**C4 and C5 are the round, and together they are a new degree of the trap.** A credit was withdrawn under Gate 2, the withdrawal reached three files, **and the ledger recorded the repair as complete across five sites while the two canonical ones still carried it.** *This is the second receipt tonight that outran its own repair*, L70's ended with "Copied verbatim into results.md" and it had not been.

**And the repair the record intended was itself wrong.** Swapping one lemma's name for another's would have missed that the weak converse needs neither: it falls out of L29's own equality case in two lines.

**C6 is the parity constant again**, now for the fourth lemma tonight, and again the conclusion survives while the stated reason does not.

**No adjudication split, and one finding routed as needing computation.**

## Phase 4, the fix

**Verdict: `PROVEN, hypotheses corrected`. Impact: `PROPAGATES`**, the cap, its dimension-freedom and its attainment stand exactly; the converse's credit was broken at both consumer sites and is repaired there.

- **The credit is withdrawn at [results.md](../results.md):441 and :784**, with the two strengths of the converse separated and each given its actual source.
- **[LEDGER.md](../findings/LEDGER.md)'s completion claim is corrected**, three of five, and the two omitted named.
- **The exclusion clause carries $\Theta_n$** and both parities' polynomials, with the conclusion shown to survive.
- **The landscape line carries the multiplicity convention** and says why it is load-bearing.
- **The $k\le2$ extension is booked as owed**, with the reason the covering lemma cannot discharge it.
