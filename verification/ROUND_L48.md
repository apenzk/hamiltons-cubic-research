# ROUND_L48, the reducible case, and the symmetric-space theorem

**Date:** 2026-09-07. **Phase:** 6, closed. **Verdict:** `HYPOTHESIS-DEBT`, repaired, impact `NARROWS`. **Verifiers:** v191, v192, v193.

## Sources, verbatim

| what | where |
|---|---|
| Canonical entry | [results.md](../results.md) lines 543–545, **a heading and a proof pointer, and nothing else** |
| Landscape statement | [results.md](../results.md) line 172 |
| The block | [problem.md](../findings/problem.md) lines 252–262 |
| A consumer quoting the Theorem | [results.md](../results.md) line 567 |
| Brief | [BRIEF_L48.md](BRIEF_L48.md) |

## Findings from phase 0

**1. The canonical entry states nothing**, the fourth block this audit has found in that shape, and **the Theorem this block carries has no canonical entry at all**, living only inside a blockquote in the findings file.

**2. The heading is malformed and the index inherited it.** `Lemma L48 ((…) · (B)), canonical statement and proof`; [INDEX-results.md](../findings/INDEX-results.md)'s row ends *"the symmetric-space theorem) · (B"*. **This is the second such heading in that one file**, [ROUND_L44](ROUND_L44.md) repaired the other today.

**3. The repair's own summary understates it.** *"TWO HYPOTHESES WERE MISSING, AND NEITHER CHANGES A VALUE."* Adding **Einstein** to the quantifier and *"both factors of constant curvature and equal Einstein constant"* to the equality case **narrows what the Theorem claims**. *True of the numbers, false of the scope*, and a reader taking "changes no value" as "changes nothing" cites the wider form.

## What the verifiers are asked beyond the standing list

Whether $R$ is block-diagonal with vanishing mixed terms on a product; whether $B=\sum_af(n_a)-\tfrac n{8(n-1)}$ with $f(m)=\tfrac m{8(m-1)}$ is right and depends on the partition alone; whether $f$ is decreasing **and convex** so Jensen puts the minimum at the balanced split, and whether $k\,f(n/k)=\tfrac{kn}{8(n-k)}$ increases in $k$; whether $\lVert W_a\rVert^2=0$ **exactly** when that factor is a sphere; and whether the two halves meet with **no gap**, $\tfrac16\ge\tfrac{n^2}{8(n-1)(n-2)}\iff n^2-12n+8\ge0$, *the threshold polynomial recovered rather than assumed.*

**And the Theorem separately**: whether Einstein is load-bearing as claimed, whether a reducible symmetric space with unequal factor Einstein constants is indeed not Einstein, and whether the odd-$n$ figures $\theta^2=\tfrac{120}{77}$ against $\theta_0^2=\tfrac{264}{169}$ at $n=13$ are right.

## Clustering, all three in, agreeing throughout: **the lemma is sound and the Theorem owed three hypotheses**

**`HYPOTHESIS-DEBT`.** *The lemma's algebra is confirmed at every step and the Theorem above it carries a third missing hypothesis and a false uniqueness clause.*

**Everything in the lemma checks.** $R$ block-diagonal with vanishing mixed terms, *stated of $R$ and not of $W$, which is the right object*; the closed form re-derived independently, mixed block included; $f'=-\tfrac1{8(m-1)^2}$ and $f''=\tfrac1{4(m-1)^3}$, so decreasing and convex; $k\,f(n/k)$ increasing with derivative $\tfrac{n^2}{8(n-k)^2}$; the reducible minimum $\tfrac{n^2}{8(n-1)(n-2)}$ **and** its identification with $\tfrac1{4\theta_0(n)^2}$; and the equivalence to $n^2-12n+8\ge0$ exactly, **the polynomial recovered, not assumed.**

| id | finding | support |
|---|---|---|
| **R1**, **A THIRD MISSING HYPOTHESIS** | **the Theorem's quantifier admits $S^{12}$, $\mathbb{RP}^{12}$ and $T^{12}$**, where $\theta$ is $0/0$, *and $+\infty$ under [L46](../findings/problem.md)'s own formula, which the proof runs on.* $W\ne0$ is missing, the repair that added two did not add it, **and [problem.md](../findings/problem.md) rules out both available defences by name one block earlier.** *The same omission [ROUND_L47](ROUND_L47.md) found in the adjacent lemma today* | v191, v192 |
| **R2**, **AND THE CORRECTION IS ALREADY ON THE RECORD** | **the uniqueness clause is false over isometry classes**: $\mathbb{RP}^{n/2}\times\mathbb{RP}^{n/2}$ attains $\theta_0(n)$, and $\mathbb{RP}^6\times\mathbb{RP}^6$ meets every stated hypothesis at $n=12$. **[graded-half.md](../findings/graded-half.md) already records this from Gate 2 [r501](../reviews/REVIEW_r501.md)/[r502](../reviews/REVIEW_r502.md)**, *and the canonical block and graded-half's own Theorem both still say "sphere".* The earlier repair fixed the metric and not the global form | v191, v192 |
| **R3** | *"sphere"* should read **constant curvature** throughout ($\mathbb{RP}^{n_a}$ qualifies) and **$\lVert W_a\rVert^2=0\iff$ that factor is round holds *under Einstein*, which the canonical block does not say** | v192 |
| **R4** | **the landscape gloss is false as written**: only $B$ depends on the partition alone, **not $\lVert W\rVert^2$**, which carries $\sum_a\lVert W_a\rVert^2$ as well | v192 |
| **R5** | Jensen's constraint is *fixed $k$ **and** fixed $\sum n_a=n$*, and **the block names only the first** | v192 |
| **R6** | the repair's summary is **not a fair description**: the count is wrong, a third hypothesis being absent, and *"neither changes a value"* describes numbers **while concealing that the claim narrowed twice** | v192 |
| **R7** | L48's scalar $B$ is a **fourth or fifth** object under that letter, the two verifiers count differently and neither finds it tabled; $k$ collides with $\theta_{k,l}$ eighteen lines below in the same file | v191, v192 |
| **R8** | **the block disagrees with itself on parity**: *"the reducible minimum sits at $S^{n/2}\times S^{n/2}$"* carries no even-$n$ hypothesis while the Theorem beside it says *"when $n$ is even"* | v191 |
| **R9** | **the narrowing did not travel**: [results.md](../results.md)'s consumer invokes L48 **with no Einstein clause**, and [graded-half.md](../findings/graded-half.md)'s *"dropped in transit, undischarged at $k\ge3$"* caveat is absent from the canon | v191 |
| **R10** | **the de Rham reduction step has no argument on file**, `GAP` in isolation | v191 |

**$B$ was derived twice by unrelated routes**, the record's factorwise centring identity and a cold block-by-block expansion in which $\sum_an_a^2$ cancels identically, and **the threshold is sharp at $n=12$ with margin $\tfrac1{36}$**, failing at $n=11$. *The relaxation to real $n_a$ in Jensen is safe **because** the conclusion is a lower bound.*

**Confirmed and load-bearing**: Einstein is used at **three separate steps** rather than merely stated, and a reducible symmetric space with unequal factor Einstein constants is indeed not Einstein, $\mathrm{Ric}$ of a product being the direct sum in both directions. *The odd-$n$ figures reproduce by hand and cross-check against Nienhaus's $\theta_{k,l}$.*

## Adjudication

**Verdict `HYPOTHESIS-DEBT`, repaired. Impact `NARROWS`.** *The lemma's algebra is confirmed at every step by all three, $B$ derived **twice by unrelated routes**, Jensen's direction and both its constraints, the $k$-monotonicity, the reducible floor and its identification with $\tfrac1{4\theta_0(n)^2}$, and the threshold **genuinely recovered** from two quantities neither of which contains it.* **What owed is the Theorem, and six hypotheses the lemma uses and never stated.**

### The block is a lossy abridgement of a complete argument in another file

[graded-half.md](../findings/graded-half.md) carries the argument in full. **The canonical block drops the Einstein normalisation of the factors, $\lVert R\rVert^2=\sum_a\lVert R_a\rVert^2$, $n=\sum_an_a$, $k\ge2$, the parity condition, and weakens *constant curvature* to *sphere***, six hypotheses used, none stated. *And the correction for the sixth has been on the record since Gate 2 [r501](../reviews/REVIEW_r501.md)/[r502](../reviews/REVIEW_r502.md): $\mathbb{RP}^{n/2}\times\mathbb{RP}^{n/2}$ attains $\theta_0(n)$, and both Theorems went on saying "sphere".*

### A `BROKEN` in a different lemma, found by this round

**[L46](../results.md)'s canonical entry says $\theta\le\theta_0(n)$ "becomes the single inequality $\lVert W\rVert^2\ge\tfrac16$, the form Lemmas 47 and 48 verify". It is refuted by L48's own extremiser**: $S^6\times S^6$ has $\lVert W\rVert^2=\tfrac9{55}<\tfrac16$ while attaining $\theta_0(12)$ exactly. *The two inequalities coincide only at $n=6+2\sqrt7$, which is not an integer.* **$\tfrac16$ is L47's irreducible threshold and $\tfrac1{4\theta_0(n)^2}$ is L48's reducible floor**, and conflating them is what the sentence does. **Repaired.**

### The repairs, all applied

| finding | what changed |
|---|---|
| R1 | $W\ne0$ into the Theorem, with $S^{12}$, $\mathbb{RP}^{12}$, $T^{12}$ named and **$\theta=+\infty$ under [L46](../findings/problem.md)'s own formula** recorded |
| R2 | the equality set is **balanced products of two space forms of equal constant positive curvature**, in both files |
| R3, R5 | *constant curvature* replaces *sphere*; Einstein with $\lambda>0$ named as what the forward direction needs, with $S^1\times S^{m-1}$ as the witness; Jensen's second constraint stated |
| R4 | *"$\lVert W\rVert^2$ depends on the partition alone"* corrected to $B$, with $\mathbb{CP}^3\times S^6$ against $S^6\times S^6$ as the separator |
| v193's `BROKEN` | [L46](../results.md)'s entry now gives $\lVert W\rVert^2\ge\tfrac1{4\theta_0(n)^2}$ and says why $\tfrac16$ is the other half |
| R8 | *at even $n$* on the reducible-minimum sentence |
| new | $k\ge2$ stated, *$k=1$ is in the formula's domain and returns the strictly smaller $B=0$*; $n=\sum_an_a$ stated, **an omission this record has paid for once already**; the heading's `· (B)` gone and the index row rebuilt |
| R6, R7 | the repair note now says three hypotheses and that the claim narrowed twice; $B$ tabled in [conventions.md](../findings/conventions.md) |

### Queued to [plan.md](../plan.md)

**The de Rham reduction step has no argument on file**, `GAP` in isolation, and the step by which the Theorem reaches products at all.
