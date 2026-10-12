# ROUND L69, the threshold $p,q\ge5$, the enumeration behind it, and a classification debt inherited from upstream

**Id:** L69. **Source:** [findings/graded-half.md](../findings/graded-half.md):363–, with the canonical form at [results.md](../results.md):553 and the landscape line at :180. **Date:** 2026-09-07. **Verifiers allocated:** v146, v147, v148. **Phase:** 6, closed. **Verdict:** `HYPOTHESIS-DEBT`, repaired, impact `NARROWS`.

**Why this id.** Tier 1, cited eight or more times, and it is the **conclusion** the graded half is for: above the rival maximizer's value, only sphere products survive.

**Blockquotes are included in the brief below.** *An earlier round's filter stripped them as provenance and removed a refutation of the paragraph it quoted; nothing is filtered here.*

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on any.)*

1. **What enumerates "every equivariant graded critical point"?** **Name the enumeration, say whether it is a classification or a sweep, and say what it inherits, including whether it needs the pinning formula and what happens where that formula has no value.**
2. **Is $p,q\ge5$ right in both directions?** **Check that every sphere product with both factors $\ge5$ clears $\sqrt{3/2}$ at $n\ge12$, and that no product with a factor $\le4$ does, at both parities, and at the boundary.**
3. **Is "each is nondegenerate" the same statement the record proves?** **Find where nondegeneracy is established, check its range against $p,q\ge5$, and say whether the citation is to what is proved or to what is claimed.**

**A source is read, never cited from memory.** *If a source is not in [references/](../references/), say the claim rests on an unread source. This record holds no Cartan, Helgason, Berger or Besse entry.*

## The brief as dispatched

*Provenance stripped, mathematics verbatim, quoted from the current source, blockquotes included.*

**Statement.** For $n\ge12$, every equivariant graded critical point with $\theta\ge\sqrt{3/2}$ is a two-factor sphere product $S^p\times S^q$ with $p,q\ge5$, and every one of those is Morse–Bott nondegenerate with $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$ attained exactly on the orbit tangent.
**Proof.** An equivariant graded point is the Weyl operator of a compact symmetric space, so the recorded classification applies. **That implication is proved here by an invariant count, needing no classification at all**: at every $\mathbb Z_2$-grading of $\mathfrak{so}(n)$ the space of $K$-invariant symmetric endomorphisms of $\Lambda^2$ has dimension $3$, of which $\mathrm{Alt}$ and $\mathrm{Ric}$ remove $0$ and $2$, leaving a single line, and the same count runs $4-1-2$ at $p=4$ and $3-1-1$ at $\mathfrak u(m)$, so it is uniform over the gradings rather than case-checked. *$p=1$ carries no equivariant point at all.*
> **THE FIRST VERSION CREDITED THIS SENTENCE TO [LEMMA L8](../findings/graded-half.md#conjecture-l8-the-graded-case-reduced-to-a-finite-check-and-settled-across-the-classical-families-canonical-statement-and-proof), WHICH ASSUMES IT**, and the paragraph standing in for a proof measured at $n=8$ and $n=10$, **outside this lemma's own $n\ge12$**. The general criterion in [ungraded-slack.md](ungraded-slack.md) does not close it either: its hypothesis $(\mathrm{Sym}^2\mathbb R^n)^K=\mathbb R\,\mathrm{Id}$ **fails for every unbalanced $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$**, which is exactly the family needed here. *Gate 2, [r501](../reviews/REVIEW_r501.md) and [r502](../reviews/REVIEW_r502.md) on identical briefs, supplying the same replacement independently.* *Irreducible:* $\theta\le\sqrt{3/2}$ with equality only at $\mathbb{CP}^2$ (the $\lVert W\rVert^2\ge\tfrac16$ theorem above), so no irreducible space exceeds the threshold. *Reducible:* $\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+B(n_1,\dots,n_k)$ with $B$ depending on the partition alone, minimised at $k=2$ balanced, and each $\lVert W_a\rVert^2$ vanishing exactly when that factor is a sphere, so above the threshold every factor is a sphere and $k=2$.
*The new step is which two-factor splits survive.* With $f(m)=\frac m{8(m-1)}=\frac18\bigl(1+\frac1{m-1}\bigr)$, the condition $\lVert W\rVert^2\le\tfrac16$ is $f(p)+f(q)-\frac n{8(n-1)}\le\tfrac16$, and the $\tfrac18$ cancels to leave
$$\frac1{p-1}+\frac1{q-1}-\frac1{n-1}\le\frac13 .$$
**This is where $n\ge12$ comes from, and it is a second constraint rather than a consequence of $p,q\ge5$**, which alone would permit $n=10$. $(5,5)$ fails at $\tfrac7{18}$ against $\tfrac6{18}$ and $(5,6)$ at $\tfrac7{20}$, while $(5,7)$ passes **by exactly $\tfrac1{132}$** and $(6,6)$ by $\tfrac4{165}$. **And $p=4$ is excluded with no case check**: $\tfrac1{p-1}=\tfrac13$ exhausts the budget exactly, while $\tfrac1{q-1}-\tfrac1{n-1}>0$ at every $q$ since $n>q$, so the sum strictly exceeds $\tfrac13$ for all $q$, and $p\le3$ fails a fortiori. *Checked in [L69.lean](../lean/HamiltonsCubic/Results/L69.lean).*
At $p=2$ and $p=3$ the left side exceeds $\tfrac13$ outright. **At $p=4$ it reads $\frac1{q-1}\le\frac1{n-1}$, i.e. $q\ge n$, which is impossible for every $n$**, so no split with a factor of $4$ or less ever clears the threshold, at any dimension. At $p=5$ it is $\frac5{(n-6)(n-1)}\le\frac1{12}$, i.e. $n^2-7n-54\ge0$, i.e. $n\ge12$, the threshold dimension of the conjecture itself, appearing here for the fourth independent time. Hence $p,q\ge5$. **$n\ge12$ enters as the dimension at which an admissible split first exists**, rather than as a hypothesis the argument consumes.
**Three or more factors are excluded by the same budget, and this is the step the first version skipped.** With $k$ factors, $\lVert W\rVert^2>\tfrac18\bigl(k-1-\tfrac1{n-1}\bigr)$, which already exceeds $\tfrac16$ at $k=3$. *The first version argued that $B$ is minimised at $k=2$ balanced and concluded $k=2$, a global minimum at $k=2$ constrains nothing at $k=3$.* And every factor is a sphere by [Lemma L47](fence-posts.md)'s quantitative $\lVert W_a\rVert^2\ge\tfrac16$, rather than by non-vanishing, which breaks no budget on its own. *Gate 2, [r501](../reviews/REVIEW_r501.md) and [r502](../reviews/REVIEW_r502.md), independently.*
Since $p,q\ge5$ implies $p,q\ge3$ with $(p,q)\ne(3,3)$, the unconditional nondegeneracy theorem of [nondegeneracy.md](nondegeneracy.md) applies to every surviving split, and the spectrum is bounded away from $\tfrac12$ there. **The room is less than once advertised**: the true gap to the second eigenvalue is $\frac1{2(M-1)}$ with $M=\max(p,q)$, decaying like $1/n$, $1/12$ at $S^5\times S^7$ rather than the $0.292$ the family-B formula suggests ([nondegeneracy.md](nondegeneracy.md)). Nondegeneracy is unaffected; any argument that *spends* the margin is. $\square$
**The assembly's weakest joint is repaired, and it no longer needs the classification.** *Found by [Reviewer 314](../reviews/INDEX.md) mid-audit, it built its own classification of equivariant graded points at $n=12$ bypassing the symmetric-space classification entirely, and verified here independently.* **The $\mathrm{ad}(\mathfrak p)$-commutant inside $\mathcal W_n$ is exactly one-dimensional** at every symmetric pair tested: $(3,5)$, $(4,4)$ and $(2,6)$ at $n=8$ against $\dim\mathcal W_8=300$, and $(5,5)$, $(4,6)$ at $n=10$ against $770$. Since the sphere product's Weyl tensor is $\mathrm{ad}(\mathfrak p)$-invariant and nonzero, that single direction *is* it **at an $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ pair**. *At a $\mathfrak u(m)$ pair the unique invariant is $\mathbb{CP}^m$, not a sphere product* ([Reviewer 317](../reviews/REVIEW_r317.md)), **the proof must exclude those by the threshold rather than assume they do not arise**, and it does: $\theta(\mathbb{CP}^m)$ is $1.054093$, $0.986013$, $0.948683$, $0.924962$ at $m=3,4,5,6$, decreasing, so every $\mathfrak u(m)$ pair with $n=2m\ge12$ sits far below $\sqrt{3/2}$. The one $\mathfrak u(m)$ point at the threshold is $\mathbb{CP}^2$ at $n=4$, outside the lemma's range, so **an equivariant graded critical point on a pair is the sphere product's Weyl tensor, uniquely up to scale**, with no appeal to the classification of symmetric spaces. *This is agreement rather than discovery*: [ungraded-slack.md](ungraded-slack.md) already records that under $K$-irreducibility, $(\mathrm{Sym}^2\mathbb R^n)^K=\mathbb R\,\mathrm{Id}$ and $(\Lambda^4\mathbb R^n)^K=0$ the $K$-invariant traceless Weyl operators are $\mathbb R\,W_{\mathfrak h}$. What the measurement adds is that the count is $1$ at the **Lie-algebra** level even at $(4,4)$, where that record notes the connected-$K$ conditions fail through the self-dual/anti-self-dual splitting of each $\mathfrak{so}(4)$.

## Phase 2, the clustering

**Reports:** [VERIFY_v146](VERIFY_v146.md) `GAP`, [VERIFY_v147](VERIFY_v147.md) `HYPOTHESIS-DEBT`, [VERIFY_v148](VERIFY_v148.md) `HYPOTHESIS-DEBT`.

| # | clause attacked | mechanism | support |
|---|---|---|---|
| **C1** | the threshold $p,q\ge5$ | *no defect.* Right in both directions and at both parities, hand-verified: $S$ is convex in $p$, so the worst case is $p=5$ where $S\le\tfrac13\iff n\ge12$; $p=4$ reads $q\ge n$, impossible. Margins exact, $(5,7)$ by $\tfrac1{132}$, $(6,6)$ by $\tfrac4{165}$ | v146, v147, v148 |
| **C2** | the reduction | **stronger than stated: it is an equivalence.** $\lVert W\rVert^2\le\tfrac16\iff S\le\tfrac13\iff\theta^2\ge\tfrac32$, and the closed form $\theta^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ falls out **derived rather than checked at points**, reproducing every recorded value including the $n=25$ Pell point at $912/575$ | v146, v147 |
| **C3** | "every equivariant graded critical point" | **the debt.** The enumeration is Cartan's list of $\mathbb Z_2$-gradings, invoked bare; [references/](../references/) holds no Cartan, Helgason, Berger or Besse, the conventions file already records the appeal as sourceless, and the ledger records acquiring one as **blocked on the user**. *The conjugacy trap does not bite, $n\ge12$.* **This is the only input a falsifier could attack** | v146, v147, v148 |
| **C4** | the scope conditions | **the block carries none of the three** (pair sense, $\ker W=0$, $n\ne8$) and under the reading it leaves open, **padded $W_{\mathbb{CP}^2}$ at $n=12$ is a counterexample word for word**: $\theta=\sqrt{3/2}$ exactly, $\ker W$ of dimension $63$ out of $66$, not a sphere product. Only [results.md](../results.md):553 carries all of them | v146, v147, v148 |
| **C5** | L48's Einstein hypothesis | **dropped in transit**, and undischarged at $k\ge3$, *which is the step the block advertises as its repair*. Harmless at $k=2$, the invariant line being one-dimensional | v146, v147 |
| **C6** | $\theta=1/(2\lVert W\rVert)$ | used in both citable forms, stated in neither, and it is what gives the $\tfrac16$ its meaning | v147, v148 |
| **C7** | the non-strict threshold | $\theta\ge\sqrt{3/2}$ is discharged only by $\mathbb{CP}^2$ living at $n=4$, said after the $\square$ in one file and nowhere in the other. *No sphere product attains $\sqrt{3/2}$ at any $n$*, equality needs $(n+2)\mid36$, and both candidates give non-square discriminants | v147, v148 |
| **C8** | "uniform over the gradings" | refuted by the block's own three displays, which give different counts; the ledger says "case by case" at one line and the opposite four below | v146, v148 |
| **C9** | "every factor is a sphere" | the criterion checked is **constant curvature**, which $\mathbb{RP}^m$ also satisfies | v148 |
| **C10** | the L47 citation | points at a file containing no L47 | v146, v147, v148 |
| **C11** | [LEDGER.md](../findings/LEDGER.md):770 | a bolded correction of this lemma's $\tfrac1{12}$ to $\tfrac7{24}$ is **withdrawn four lines below itself**, *a reader who stops at the correction replaces a correct number with a wrong one* | v146 |
| **C12** | the Lean rows | two rows on one file, reading `proved` and `partial` | v148 |

## Phase 3, adjudication

**Both halves stand and one is stronger than written.** Three independent hand derivations of the reduction, agreeing exactly, and one produced the record's closed form as a consequence rather than a check, **including the value at the pair where the previous round found L8's pinning formula has a pole**. That is the repair working: L69's route needs no pinning formula, and it covers the object that broke L8.

**C3 is the round, and it is the same debt as L23's, L27's and L8's.** Four rounds tonight have ended at a classification this record does not hold, and the ledger records the acquisition as blocked on the user. *This is now the programme's most-repeated single dependency.*

**C4 is what makes the block uncitable rather than merely incomplete.** The counterexample is not hypothetical: it is an object the record already holds, and the only thing excluding it is a labelling that lives thirty lines downstream.

**C11 is a new shape of the trap.** Not a correction that failed to propagate, **a correction that was withdrawn, in place, four lines below itself**, so the file contains both the wrong number and its retraction in the order that teaches the wrong one first.

**C5 is the one that would matter if the enumeration were sound**: the hypothesis is dropped exactly where the block claims to improve on its predecessor.

**No adjudication split, and no finding required computation.**

## Phase 4, the fix

**Verdict: `HYPOTHESIS-DEBT`. Impact: `NARROWS`**, the arithmetic and the threshold stand; the quantifier rests on an unheld classification, and the block was missing every scope condition that makes it true.

- **The block now opens with its scope** (pair sense, $\ker W=0$, $n\ne8$), with the padded $W_{\mathbb{CP}^2}$ counterexample named, and the non-strict threshold discharged in place.
- **The reduction is stated as an equivalence**, with the closed form derived and the $\theta=1/(2\lVert W\rVert)$ bridge written in, and L48's Einstein hypothesis named as dropped and undischarged at $k\ge3$.
- **[results.md](../results.md):180 carries the three scope conditions** and the Cartan debt, where it carried none.
- **"Uniform over the gradings" becomes case by case**, "is a sphere" becomes constant curvature, and the L47 citation points at the file that holds it.
- **[LEDGER.md](../findings/LEDGER.md)'s self-withdrawn correction now states the withdrawal first**, so the wrong number cannot be read alone.
