# ROUND L57, the diagonal theorem at every $n\ge4$, both parities, and the two findings transferred into it

**Id:** L57. **Source:** [findings/problem.md](../findings/problem.md):557–579, with the three steps at :262–269 and their proofs under four named headings. **Date:** 2026-09-06. **Verifiers allocated:** v98, v99, v100, **lost, no report filed**; relaunched as v101, v102, v103. **Phase:** 6, closed. **Verdict:** `HYPOTHESIS-DEBT`, repaired, impact `NARROWS`.

**Why this id.** The last of tier 0. It is the record's own proof of the half of Problem P the problem statement *grants*, so [results.md](../results.md) rests the diagonal case on it at every $n\ge4$ and both parities where the published result covers even $n\ge16$, and the odd case rests on this theorem and on nothing published.

**Two findings transferred in from [ROUND_L00](ROUND_L00.md)**, where they attacked a section unanimously found not to be that result's argument, and were carried here rather than adjudicated there:

- **F7**, a two-value ratio $Z_{\rm block}/Z_{\rm cross}$ matches $S^k\times S^l$ for **every** split $k+l=n$, so it singles out no split; balancedness is an input rather than an output.
- **F8**, the computation covers even $n$ only.

**Phase 0 found the map broken before dispatch.** The block's own guide to where its five pieces live named four line numbers, and all four had drifted off the steps they named. Replaced with heading anchors, which survive an edit anywhere above them. *Thirteen lines of that drift were this session's own rewrite of the L2 block, which sits above it in the same file.*

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on any.)*

1. **Does the proof reach the statement's quantifier?** *The statement is `for every diagonal $W$ at every $n\ge4$`. The written proof opens `at a critical point $Q(S)=\lambda S$ ... let $\mu$ be the largest eigenvalue of $S$`.* **Say whether the argument reaches a diagonal $W$ that is not critical, and if it does so by a maximiser or compactness reduction, find that reduction on file or record that it is absent.**
2. **F7, is balancedness an input or an output?** *The block's attainment paragraph asserts `the balanced split beats every other sphere product` from `$(1-\tfrac1p)(1-\tfrac1q)$ grows as $p$ and $q$ even out`.* **Check that step, and check whether anything else in the proof singles out the balanced split or merely agrees with it.**
3. **F8, does every step hold at odd $n$?** *[results.md](../results.md) claims `Every step holds at both parities`.* **Take the three steps one at a time and say for each whether its proof is parity-free, parity-split, or written for even $n$ and asserted for odd.**

**The normalisation trap, named.** The locus is fixed as $\mathop{\mathrm{tr}}S^2=2$ and the block warns that $\lvert S\rvert=1$ under plain Frobenius over ordered pairs would give $\Theta_n/\sqrt2$ instead. **Check which normalisation each step actually uses, and whether the chaining is consistent across all three.**

**A source is read, never cited from memory.** *If a source is not in [references/](../references/), say the claim rests on an unread source.*

## The brief as dispatched

*Provenance stripped, mathematics verbatim, quoted from the current source.*

### The statement

Let $\mathcal D_n=\{S\ \text{symmetric, hollow},\ S\mathbf1=0\}$ be the vertex matrices of coordinate-diagonal Weyl operators. Then
\[
\langle Q(W),W\rangle\;\le\;\Theta_n\,\|W\|^3\qquad\text{for every diagonal }W\text{ at every }n\ge4,
\]
\[
\Theta_n^2=\frac{2(n-1)(n-2)}{n^2}\ \ (n\text{ even}),\qquad
\Theta_n^2=\frac{2(n-1)(n-3)}{(n+1)(n-2)}\ \ (n\text{ odd}),
\]
with equality exactly at $S^{n/2}\times S^{n/2}$ for even $n$ and at $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$ for odd $n$. At even $n$, $\Theta_n=\theta_0(n)$.

### The canonical form, quoted alongside without comment

Let $W\in\mathcal W_n$, $n\ge4$, be diagonal in some orthonormal frame, so $W$ is the hollow symmetric zero-row-sum matrix $M$ of sectional curvatures with $\lVert M\rVert$ normalised to $\lVert W\rVert=1$. Then $\langle W,Q(W)\rangle\le\Theta_n$ with $\Theta_n^2=\frac{2(n-1)(n-2)}{n^2}$ for even $n$ and $\Theta_n^2=\frac{2(n-1)(n-3)}{(n+1)(n-2)}$ for odd $n$, and equality holds exactly at the Weyl tensor of $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$. The argument has three steps: a Dirichlet–Cauchy–Schwarz inequality $\lambda\le(n-1)\mu/n$ relating the top eigenvalue of $M$ to its row structure; the projection of $v\otimes v$ onto the Ricci-flat slice, $Z(v)_{ij}=v_iv_j+\frac{v_i^2+v_j^2}{n-2}-\frac1{(n-1)(n-2)}$, whose kernel is explicit; and a fourth-moment lemma, proved by two independent arguments. Every step holds at both parities, so the odd case rests on this theorem and on nothing published. It does not reach any $W$ that is diagonal in no frame; that is the non-diagonal half.

### The domain

A coordinate-diagonal Weyl operator is determined by its vertex matrix $S$; first Bianchi is automatic on that locus, and Ricci-flatness is exactly $S\mathbf1=0$, so $\mathcal D_n\leftrightarrow$ the coordinate-diagonal part of $\mathcal W_n$ both ways.

### Attainment

For any sphere product,
\[
\theta\big(S^p\times S^q\big)^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)\,pq},\qquad p+q=n,
\]
from criticality with $\lambda_V=1-n$ independent of the split. It collapses to $\Theta_n^2$ at $p=q=n/2$ and at $p,q=\frac{n\mp1}2$, and since $(1-\tfrac1p)(1-\tfrac1q)$ grows as $p$ and $q$ even out, the balanced split beats every other sphere product.

### The proof as written

On the diagonal locus $\mathcal D_n=\{S$ symmetric, hollow, $S\mathbf 1=0\}$ with $\mathop{\mathrm{tr}}S^2=2$ (not $\lvert S\rvert=1$, which under plain Frobenius over ordered pairs gives $\Theta_n/\sqrt2$), at a critical point $Q(S)=\lambda S$ (which is $S^{\circ2}+S^2=\lambda S+D$), let $\mu$ be the largest eigenvalue of $S$ with unit eigenvector $v\perp\mathbf1$.

1. **$\lambda\le\frac{n-1}{n}\mu$.** Pair the matrix identity with $v\otimes v$: $\lambda\mu=\mu^2-\sum_{i<j}s_{ij}^2(v_i-v_j)^2$; the row-sum condition gives $\sum_{i<j}s_{ij}(v_i-v_j)^2=-\mu$ and $\sum_{i<j}(v_i-v_j)^2=n$, so Cauchy–Schwarz gives $\sum s_{ij}^2(v_i-v_j)^2\ge\mu^2/n$. Equality at every $S^p\times S^q$, balanced or not, even or odd $n$.
2. **$\mu=2\langle S,Z(v)\rangle$ with $Z(v)_{ij}=v_iv_j+\frac{v_i^2+v_j^2}{n-2}-\frac1{(n-1)(n-2)}$ the projection of $(v_iv_j)$ onto $\mathcal D_n$**, hence $\mu^2\le4\lvert Z(v)\rvert^2$, and $\lvert Z(v)\rvert^2=\frac{n^2-3n+3}{2(n-1)(n-2)}-\frac n{2(n-2)}\sum v_i^4$.
3. **The parity-sensitive fourth-moment lemma.** For $\sum v=0$, $\sum v^2=1$: $\sum v^4\ge\frac1n$ ($n$ even), $\ge\frac{n^2+3}{n(n^2-1)}$ ($n$ odd), equality at the two-value vector with multiplicities $\lfloor n/2\rfloor,\lceil n/2\rceil$. A three-coordinate smoothing reduces a minimiser to two values, and then $\sum v^4=\frac n{k(n-k)}-\frac3n$, minimised at $k=\lfloor n/2\rfloor$.

Chaining: $\lambda^2\le\big(\tfrac{n-1}n\big)^2\cdot4\lvert Z\rvert^2_{\max}=\Theta_n^2$, with $\Theta_n^2=\frac{2(n-1)(n-2)}{n^2}$ for even $n$ and $\frac{2(n-1)(n-3)}{(n+1)(n-2)}$ for odd $n$. Equality forces the two-value $v$ and $S\parallel Z(v)$, which is $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$.


## The first dispatch was lost

**v98, v99 and v100 each finished reading, announced a write-up, and filed nothing.** No report, no commit, and no closing line in any of the three logs after ninety-eight minutes. Their logs are closed with `FAILED` so they cannot read as in-flight, and their numbers are retired rather than reused, a `v` number is a permanent address. The round is redispatched on the same brief as v101, v102, v103.

## Phase 2, the clustering

**Reports:** [VERIFY_v101](VERIFY_v101.md) `PROVEN, hypotheses corrected`, [VERIFY_v102](VERIFY_v102.md) `PROVEN, hypotheses corrected`, [VERIFY_v103](VERIFY_v103.md) `HYPOTHESIS-DEBT`.

| # | step attacked | mechanism | support |
|---|---|---|---|
| **C1** | the block's own map | it names the four step headings and omits the fifth, **the bridge from a critical point to every diagonal $W$**, which is the step that reaches the statement's quantifier | v101, v102, v103 |
| **C2** | the equality clause, [problem.md](../findings/problem.md):416 | "Equality is up to $\pm1\times S_n$" contradicts its own next clause: $P$ is an odd cubic, so of $\pm S_*$ exactly one attains an upper bound | v101, v102 |
| **C3** | step 2's $\lvert Z(v)\rvert^2$ | the formula every constant in $\Theta_n$ comes off has **no derivation on file**, in this block or in the reports cited for step 2 | v101, v102, v103 |
| **C4** | [diagonal-half.md](../findings/diagonal-half.md)'s $\mathop{\mathrm{tr}}W^3$ and $\langle W,W^\#\rangle$ bridge | supported by "exact at every test point" and by nothing else; without it the three steps bound a matrix functional not shown to be $\langle Q(W),W\rangle$ | v103 |
| **C5** | Proof II, [problem.md](../findings/problem.md):340 | "$\sum m_ir_i=0$ pins $r$ to the line spanned by $u=\mathbf1\times m$" is vacuous when $3\mid n$, where $u=0$; witness $n=6$, $v=(\tfrac12,\tfrac12,-\tfrac12,-\tfrac12,0,0)$, $\sum v^4=\tfrac14$ | v102, v103 |
| **C6** | the pairing convention | $\mathop{\mathrm{tr}}S^2=2$ is the ordered sum, $\lvert Z(v)\rvert^2$ the unordered one, and the switch is never stated | v101, v103 (**v102 dissenting**) |
| **C7** | [lean/INDEX.md](../lean/INDEX.md):359 | L57 bucketed as needing the classification of compact symmetric spaces, an obstruction belonging to a different proof | v101, v102, v103 |
| **C8** | the section heading vs the canonical form | [problem.md](../findings/problem.md) headed the argument "CANDIDATE … Gate 2 owed" while [results.md](../results.md) labels it **Lemma** and points here | v103 |
| **C9** | "proved by two independent arguments" | one proof in full and one sketch; Proof II's 24-monomial expansion is nowhere exhibited | v103 |
| **C10** | "the odd case rests on nothing published" | true and understated, the published diagonal case covers even $n\ge16$, so $n=12$ and $n=14$ are equally unpublished | v103 |

## Phase 3, adjudication

**The mathematics is unanimous.** All three re-derived step 1's identity and its Cauchy–Schwarz, step 2's projection and norm, step 3's Proof I, both chained constants and both equality cases, and every value reproduced exactly. **No verifier contradicted another on any number.**

**C3 is the round, and the split verdict turns on it alone.** v101 derived the missing norm formula, found it right, and recorded `PROVEN`; v103 found no derivation on file and booked `HYPOTHESIS-DEBT`. **They agree on the fact and differ on what a verifier may do with it**, and the loop's rule settles it: *a verifier never supplies a missing argument; the correct output is `HYPOTHESIS-DEBT` naming what must be shown.* **v103 is right on process, and its verdict governs the round.** *That v101's derivation is almost certainly correct is exactly what makes the rule necessary: a proof written by the audit and filed as verification is a proof nobody checked.*

**C6 was a genuine split and is settled by derivation rather than by a wave.** [conventions.md](../findings/conventions.md) fixes the **ordered** sum as the default, and $\mathop{\mathrm{tr}}S^2=2$ is that sum; the block's $\lvert Z(v)\rvert^2$ is the unordered norm, half of it. **The factor $2$ in $\mu=2\langle S,Z(v)\rangle$ is exactly the conversion**, so v102 is right that the chaining is consistent and v101 and v103 are right that the convention switches unstated. Both hold; the repair is one sentence, not a correction to any value.

**C2 is the named trap inside a single sentence**, the clause states the $\pm$ orbit and then names the maximiser, six words apart. [r500](../reviews/REVIEW_r500.md) and [r123](../reviews/REVIEW_r123.md) each found the sign and neither repair reached the clause.

**F7 and F8, transferred in, are both answered.** **F7 is a correct fact and a failed objection**: the two-value ratio matches every split because block-constant elements of $\mathcal D_n$ form a one-dimensional space, so step 2(c) *identifies* rather than *selects*, and balancedness is a genuine output, of step 3's integer minimisation alone. **F8 is refuted**: steps 1 and 2 are parity-free identities in $n$, step 3's Proof I is parity-blind, and only the chaining splits, both branches exactly.

**No candidate was withdrawn, and no finding required computation.**

## Phase 4, the fix

**Verdict: `HYPOTHESIS-DEBT`. Impact: `NARROWS`**, the bound and both equality cases stand as proved, and what a consumer inherits is two undischarged identities rather than a doubtful constant.

- **The two debts are booked in the block itself**, where a consumer reads, naming what each carries: $\lvert Z(v)\rvert^2$ carries every constant in $\Theta_n$; the $\mathop{\mathrm{tr}}W^3$ bridge carries the translation from the cubic to the vertex matrix, and therefore the statement (C3, C4).
- **The map now names the bridge** as its fifth place, under the heading that holds it (C1).
- **The sign clause is rewritten** to state $S_n$ alone, with the reason ($P$ is an odd cubic) and the $n=4$ values on both signs (C2). The statement's equality clause now says *geometric* Weyl tensor and names $-V/\lVert V\rVert$.
- **The two pairings are stated once, before step 1**, with the factor $2$ identified as the conversion (C6).
- **Proof II carries its own $3\mid n$ exception** with the witness, and records that [r124](../reviews/REVIEW_r124.md) case-splits where the transcription did not (C5). Step 3 is unaffected: Proof I closes it alone.
- **[lean/INDEX.md](../lean/INDEX.md):359 moves L57 out of the classification bucket**, saying what its proof actually uses and what a formalisation would owe (C7).
- **The section heading drops "CANDIDATE … Gate 2 owed"** (C8), and the canonical form in [results.md](../results.md) is corrected on the second proof (C9) and on the scope of "unpublished" (C10).

**The spread.** Two `PROVEN, hypotheses corrected` against one `HYPOTHESIS-DEBT`, with unanimity on every value and every step. **The disagreement was about what a verifier may supply, and the stricter reading governs**, as it did on L02, where the same split ran the other way round.
