# Review r678, Observation L98, the diagonal floor

**Reviewer B of an independent pair on identical briefs. Review number: r678.** Target: [Observation L98](../findings/diagonal-half.md#L187) at [diagonal-half.md:187](../findings/diagonal-half.md#L187) and the table at [:191–195](../findings/diagonal-half.md#L191).

**Standing rule observed: analysis only.** Nothing below was computed. The one derivation that needed arithmetic (the $n=4$ classification), is done by hand in the report and is checkable by the reader in a minute. Two items that need a run are named as such with what each outcome would decide, and are not worked around.

---

## Verdict: **GAP**

The closed form is **measured, not derived, and its own source states it with a question mark over the equals sign and asks that it be treated as an upper bound**. The heading turned an explicitly hedged fit into a numbered equality. The mathematics I could reach cold is consistent with the formula everywhere I could check it, including at the pole; what fails is the *status* of the statement and four of its supporting sentences.

| # | finding | grade |
|---|---|---|
| 1 | [r310](REVIEW_r310.md#L55) writes $\min\lambda_{\max}(L_e)\overset{?}{=}1+\frac1{2(n-3)(n-4)}$ and closes with *"treated as an upper bound on the true floor"*. The heading drops the question mark, drops the population, and asserts $=$ | **real, headline** |
| 2 | A census bounds a minimum from **above**. All five recorded "floors", $1.0417$, $1.025$, the closed form, $1.2178\times$, $1.1070\times$, form a monotonically falling sequence, which is the signature of an upper bound reported as a minimum | **real** |
| 3 | The seven dimensions are $n=10\ldots16$ ([r310:60](REVIEW_r310.md#L60)). The block says "seven consecutive dimensions" in the same sentence as "$n=6\ldots16$", so the reader infers coverage the record does not have at $n=6,7,8,9$ | **real** |
| 4 | The heading's $\lambda_{\max}(L_e)$ and the table's $\lambda_{\max}(L_e)$ are **the same symbol over two different subspaces**, the diagonal locus and all of $W^\perp\cap\mathcal W_n$. [r310:70](REVIEW_r310.md#L70) says so and asks the record to state it. It was not stated | **real** |
| 5 | The block is **stale by three days**: [r314](REVIEW_r314.md#L143) polished both provisional rows to $2.1\times10^{-16}$ and explicitly asked that "provisional until polished" be struck, and found a sub-floor point at $1.1027\times$. Neither landed | **real** |
| 6 | The table's criticality column ($1.1\times10^{-11}$, $1.2\times10^{-11}$) disagrees with its cited source [r305:16,18](REVIEW_r305.md#L16) ($1.5\times10^{-12}$, $1.4\times10^{-12}$) by about eightfold | **real, small** |
| 7 | *"a counterexample would need $\theta>2\lambda_{\max}\gtrsim1.1$"* uses $\lambda_{\max}$ in the $L_W$ normalisation eleven words after using it in the $L_e$ normalisation, in one sentence. This is the exact confusion the block's own italic note says already cost the file once | **real** |
| 8 | The *"Two things that make the target look easier"* paragraph is **pre-r310 material left standing under the r310 correction**: it quotes $1.0417$ without its population, which is the very defect the paragraph above it diagnoses in $1.025$ | **real** |
| 9 | The formula is singular at $n=3,4$ and the block says nothing. **It is harmless**, I derive below that every diagonal critical point at $n=4$ has $\Delta=0$, so the minimand is empty, but it is unstated | **real, benign** |
| 10 | The block names **no minimiser at any $n$**, which is the single thing that blocks a derivation. Its own source names two | **real** |

---

## Readings adopted, stated as the brief requires

All from [conventions.md](../findings/conventions.md), repaired today; none restated from the block.

- **$\circ$ and $L_e$.** $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, $e=W/\theta$, $L_e=e\circ(\cdot)$. So $X\circ X=Q(X)$, and at a critical point $L_eW=Q(W)/\theta=W$: **$W$ is always an eigenvector of $L_e$ with eigenvalue exactly $1$.** [conventions.md](../findings/conventions.md) confirms this from the other side, $L_WW=\theta W$ under the entry for $B$.
- **Therefore the bare $\lambda_{\max}(L_e)$ in this block must mean $\lambda_{\max}(L_e\vert_{W^\perp})$.** Under the full-space reading the table's three rows at $0.553$–$0.609$ are impossible, since the radial direction forces $1$. [Lemma L99](../findings/diagonal-half.md#L163) three paragraphs above writes the restriction explicitly; L98 does not. I read the restricted operator throughout, and flag the omission.
- **$\lambda_{\max}(L_e\vert_{W^\perp})\ge\tfrac12$ at every critical point**, because $L_W[A,W]=\tfrac\theta2[A,W]$ for every $A\in\mathfrak{so}(n)$ and $[A,W]\perp W$. So the table's "margin over $\tfrac12$" column is a ratio against a value that is *forced everywhere*, not against a bound that could fail. That is worth saying, and the block does not say it.
- **$\Delta$**: the symmetry defect, traced over $\{\lambda>0\}$ only, discontinuous at eigenvalue zero-crossings. On the diagonal locus [Lemma L68(ii)](../findings/diagonal-half.md#L86) gives $\Delta=\sum_{M_{ab}>0}g_{ab}$ with $g_{ab}=2\sum_{d\ne a,b}(M_{ad}-M_{bd})^2$, and $\Delta=0$ exactly when every positive edge joins twins.
- **Diagonal** means diagonal in coordinate $2$-planes; $\mathcal D_n=\{S\text{ symmetric, hollow},\ S\mathbf1=0\}$; $\mathop{\mathrm{tr}}M^2=2$ at unit norm.
- **$\theta_0$** is the closed form alone, $\theta_0^2=2(n-1)(n-2)/n^2$; the diagonal maximum is $\Theta_n$.

---

## What I derived cold

### D1. $L_e$ on the diagonal locus, in closed form, and $\mathcal D_n$ is $\circ$-closed

For $M,N\in\mathcal D_n$, polarising $Q$ in the pair basis gives, at the pair $(ab)$,

$$(M\circ N)_{ab}\ =\ M_{ab}N_{ab}\ +\ \tfrac12(MN+NM)_{ab},$$

the Hadamard product plus the Jordan product. The row sums vanish identically: $\sum_{b\ne a}M_{ab}N_{ab}=\sum_bM_{ab}N_{ab}$ by hollowness, while $\sum_{b\ne a}\tfrac12(MN+NM)_{ab}=-(MN)_{aa}=-\sum_bM_{ab}N_{ab}$ because $N\mathbf1=0$. **So $\mathcal D_n$ is closed under $\circ$ with no hypothesis at all**, a cleaner statement than the file's "the diagonal locus is an $L_W$-invariant subspace, verified at non-critical $W$ too" at [:157](../findings/diagonal-half.md#L157), which is recorded as a verification. The form is symmetric, since $\langle\mathcal A N,P\rangle$ is $\sum_{a\ne b}M_{ab}N_{ab}P_{ab}+\tfrac12\mathop{\mathrm{tr}}(MNP)+\tfrac12\mathop{\mathrm{tr}}(NMP)$.

### D2. The eigenvalue $1$ is exact, and re-derives L99 in five lines

Take $a\in\ker M$ and $N_{ab}=(a_a+a_b)M_{ab}$; this lies in $\mathcal D_n$ precisely because $Ma=0$. By the component-kernel theorem, $a$ is constant on each component, so for $a,b$ in one component $\sum_ka_kM_{ak}M_{kb}=a_c(M^2)_{ab}$ and across components both sides vanish. Then

$$(\mathcal AN)_{ab}=2a_cM_{ab}^2+2a_c(M^2)_{ab}=2a_c\big(M^{\circ2}+M^2\big)_{ab}=2a_c\,\theta M_{ab}=\theta N_{ab}$$

by the block's own criticality equation. **So the eigenvalue is exactly $\theta$, i.e. exactly $1$ for $L_e$, and the eigenspace has dimension $k^+$, or $k^+-1$ after removing the radial direction.** This confirms [L99](../findings/diagonal-half.md#L163) independently and, more to the point here, **it says where the "$1$" in L98's formula comes from**: it is the value the direct-sum family pins, and the closed form is asserting that connected points sit a specific rational amount above it.

### D3. $n=4$ is vacuous, so the pole is harmless, and the block never says so

The brief asks whether $n=3,4$ are excluded by hypothesis or silently. **Silently, and I can show the exclusion is sound at $n=4$.**

$\dim\mathcal W_3=0$, so $n=3$ is empty by the dimension formula. At $n=4$, subtracting pairs of the four row-sum equations forces $M_{13}=M_{24}$, $M_{14}=M_{23}$, $M_{12}=M_{34}$; write $a,b,c$ for the three values, so $a+b+c=0$ and $\dim\mathcal D_4=2$. With $\mathop{\mathrm{tr}}M^2=4(a^2+b^2+c^2)=2$ we get $a^2+b^2+c^2=\tfrac12$. The off-diagonal criticality equation at the pair $(12)$ is $a^2+2bc=\theta a$, and $2bc=a^2-(b^2+c^2)$, so

$$3a^2-\tfrac12=\theta a,\qquad 3b^2-\tfrac12=\theta b,\qquad 3c^2-\tfrac12=\theta c .$$

All three are roots of one quadratic, so at most two distinct values; $a+b+c=0$ then forces the shape $\{x,x,-2x\}$, giving $6x^2=\tfrac12$, $x=\mp1/\sqrt{12}$ and $\theta=-3x=\pm\sqrt3/2$. **Independent confirmations that this is right**: the spectrum is $\{0,-2,-2,4\}/\sqrt{12}$, whose $\mathop{\mathrm{tr}}M^2$ is $2$ and whose $\tfrac12(\sum M_{ab}^3+\mathop{\mathrm{tr}}M^3)$ is $3/\sqrt{12}=\sqrt3/2$; and $\sqrt3/2=0.866$ is [conventions.md](../findings/conventions.md)'s $\Theta_4$ and equals $\theta_0(4)$, as it must at even $n$.

The positive edges are the pair class carrying $c=2/\sqrt{12}$, and for such an edge $(1,4)$ the remaining rows agree, $M_{12}-M_{42}=a-b=0$ and $M_{13}-M_{43}=b-a=0$, so $g_{14}=0$. **Every diagonal critical point at $n=4$ is the single $S^2\times S^2$ orbit and has $\Delta=0.$** The set L98 minimises over is empty at $n=4$, and the formula's pole there is the empty minimum, not a live case mis-stated.

**This is the opposite outcome to the companion audit's neighbouring block**, and it is worth recording as such: the omission is real but benign, and the repair is one clause naming the domain, not a correction to the formula.

**$n=5$ I cannot settle by hand and will not compute.** What a run would decide: whether any diagonal critical point at $n=5$ has $\Delta>0$. If none does, the formula's domain is $n\ge6$ and its value $1.25$ at $n=5$ is vacuous like the pole. If one does, the record acquires a checkable prediction at a dimension small enough to verify exactly, and the first test of the formula outside $n=10\ldots16$.

---

## The five questions

### 1. Derived or measured, measured, and the source says so

**The block hardened its source.** [r310](REVIEW_r310.md#L55) writes the formula as

$$\min\lambda_{\max}(L_e)\ \overset{?}{=}\ 1+\frac1{2(n-3)(n-4)}$$

with a question mark over the equals sign, under the words "an evident law", and its own recommendation two paragraphs later is *"The number should be quoted with its population and treated as an upper bound on the true floor."* The record carries the formula into a numbered heading as a bare $=$, with no population and no hedge. **That is the finding.** The italic provenance clause *"the formula checked here against every value it reports"* is true and is also weaker than it sounds: it says the record reproduced r310's arithmetic, not that it tested the law.

**This is not an eighth closed-form collapse.** The seven that collapsed in this audit were closed forms *recovered* from measured tables by derivation. Here the closed form was *fitted* to seven integers by the reviewer and the derivation is still missing, and the two situations are distinguishable by exactly the test the brief names: whether the argument can be written down.

**What blocks a derivation is that the block names no minimiser.** There is no $M$, no graph, no block-size vector, at any $n$, so there is nothing for a derivation to start from. Its own source has them and they were dropped: [r310](REVIEW_r310.md#L64) gives the $n=16$ minimiser as **block sizes $1,1,2,4,4,4$, $\theta=0.776176217$, $\dim\ker M=1$, $\Delta=1.577844$**, and an $n=10$ minimiser at $\theta=0.735372377$, $\Delta=1.8025751073$. Recovering those two lines is the cheapest step toward a derivation on offer.

**A lead, offered as a lead and nothing more.** The $n=16$ minimiser puts $1+1+2=4$ vertices into small blocks and the remaining $n-4$ into equal blocks of $4$; the denominator $2(n-3)(n-4)$ carries an $n-4$. And [L68(iii)](../findings/diagonal-half.md#L86) already produces the right *shape* for the answer: at every positive edge $\theta=\frac{s_a+s_b}{2M_{ab}}-\frac{g_{ab}}{4M_{ab}}$, so $\frac{s_a+s_b}{2\theta M_{ab}}=1+\frac{g_{ab}}{4\theta M_{ab}}$, **an edge quantity that is exactly $1$ at twin pairs and exceeds $1$ by a defect-over-entry ratio precisely on the edges $\Delta$ counts.** If $\lambda_{\max}(L_e\vert_{\mathcal D_n})$ can be tied to that quantity, the floor becomes a statement about minimising $g_{ab}/(4\theta M_{ab})$ over $\Delta>0$ diagonal critical points, which is a finite combinatorial problem in the block sizes. I did not close that tie and do not claim it.

### 2. A floor over the diagonal locus or over $\mathcal W_n$, three sets, conflated

The heading writes $\min\lambda_{\max}(L_e)$ with no domain at all. Three distinct sets are in play and the block moves between them without marking the moves.

| what is minimised | over what | value |
|---|---|---|
| $\lambda_{\max}(L_e\vert_{W^\perp})$ | all diagonal critical points | $\le0.5714$, the block's own padded $S^4\times S^4$ at [:152](../findings/diagonal-half.md#L155) |
| $\lambda_{\max}(L_e\vert_{W^\perp})$ | diagonal critical points with $\Delta>0$ | the claim |
| $\lambda_{\max}(L_e\vert_{W^\perp})$ | all of $\mathcal W_n$ | $\le0.553481$, **the block's own table, three lines below the heading** |

**So the heading is false under two of the three readings, one of them refuted by the block's own table four lines later.** Only the middle reading is defensible, and the heading carries neither the $\Delta>0$ hypothesis nor the locus. The repair is one clause: *the minimum over diagonal critical points with $\theta>0$ and $\Delta>0$*.

**The censuses were diagonal-only and the block says so, correctly.** But it says so about the *censuses* and not about the *claim*, and those are the two different statements the brief asks to be separated. The claim as headed is a statement about $\mathcal W_n$; the support is a statement about $\mathcal D_n$.

### 3. The warning is right, and it understates the damage in three ways

The sentence *"A cycle taking the cushion as general would be relying on a diagonal statement to prove a non-diagonal one"* is correct, is the most valuable line in the block, and should stay. **It understates.**

- **The off-locus cushion on the record today is $1.1027\times$, not $1.1070\times$.** [r314](REVIEW_r314.md#L307) found a graded $\mathfrak{so}(4)\oplus\mathfrak{so}(4)$ point below every witness in the table, and said in as many words that the record's figure should move. The string $1.1027$ appears nowhere in [findings/](../findings/) or [results.md](../results.md).
- **Every one of these numbers is an upper bound, and they have only ever fallen.** $1.2178\to1.1255\to1.1070\to1.1027$ off the locus; $1.0417\to1.025\to$ the closed form on it. A census cannot produce a minimum; it produces a witness. **The record's own history is the argument that no number in this block should be written as a $\min$.**
- **What the cushion is actually worth off the locus is therefore: at most $1.1027\times$, with no lower bound of any kind on the record.** The honest form of the whole block is an inequality in one direction, and the only *proved* lower bound anywhere near it is the universal $\tfrac12$ from the orbit directions, which is what the "margin over $\tfrac12$" column is silently measured against.

**What still leans on it.** [plan-maximizer.md:24](plan-maximizer.md#L24) scores item margin using both figures at once, *"off-locus cushion 1.107×… on the locus the floor $1+\frac1{2(n-3)(n-4)}$ is 2× above $\tfrac12$"*, so a plan grade consumes the closed form as though it were a floor. [plan-diagfam.md:28](plan-diagfam.md#L28) locates "r310's floor" in the diagonal block of a decomposition, and [:59](plan-diagfam.md#L59) makes the table's $n=8$ witness a falsifier candidate. [plan.md:195](../plan.md#L195) records the closed form as *validated this cycle*, on the strength of a check "against all three reported minima", which is a re-check of r310's three quoted values, not an independent route, and is the kind of validation line the same bullet warns about. [plan.md:198](../plan.md#L198) does already list r305's cushion as "numerical only", which is the one place the record grades it correctly.

### 4. The table, same quantity, two different subspaces, and one stale caveat

**The table does not measure a different quantity from the heading; it measures the same operator over a larger subspace, at points outside the set the heading minimises over.** Both columns are $\lambda_{\max}(L_e\vert_{W^\perp})$. The heading's is compressed to $\mathcal D_n$; the table's runs over all of $W^\perp\cap\mathcal W_n$. Since $\mathcal D_n$ is $L_e$-invariant (D1), the diagonal figure is a lower bound for the full one *at the same point*, so the comparison errs conservatively and the block's conclusion survives, **which is exactly what [r310:70](REVIEW_r310.md#L70) says, together with the recommendation "It should still say which restriction each side is." The record did not act on it.** That is a reviewer recommendation, explicitly made in the report the block cites by name, left undone.

There is no contradiction between "floor near $1$" and "margins over $\tfrac12$": $0.553481/0.5=1.10696$ and $0.608885/0.5=1.21777$ are arithmetically clean, and the $\tfrac12$ is [Lemma L24](../results.md)'s threshold, not the floor. What makes the two look incompatible is only the heading's missing domain.

**Is the second row a critical point?** **Yes, and the block is stale.** [r314:143](REVIEW_r314.md#L143) polished both provisional points by Gauss–Newton on $F(x)=q(x)-\theta(x)x$ to residual $2.1\times10^{-16}$, with $\theta$ and $\lambda_{\max}$ moving in the twelfth digit, and states that *"the record's note … that 'their $\lambda_{\max}$ is provisional until polished' can be struck."* It was filed at 12:47 on 2026-09-01, one hour and thirty-nine minutes after the commit that wrote this block; [diagonal-half.md](../findings/diagonal-half.md) has been edited on four days since, most recently three hours ago, and the caveat still stands. **Stale within the hour of being written, and stale still.**

Had r314 not existed, the $10^{-11}$ residual would have been a genuine worry rather than a formality, not because $10^{-11}$ is large, but because $\Delta$ is decided by a positivity threshold, and [L68](../findings/diagonal-half.md#L86)'s own trap paragraph exhibits $\Delta$ jumping from $2/3$ to $0$ under a perturbation of $5\times10^{-10}$. A $\Delta>0$ label on a point known only to $10^{-11}$ sits inside that band. r314's polish and its $\ker W=0$ certificate settle it, so the point is moot on the mathematics and live on the record.

**Sixth finding, small.** The residual column reads $1.1\times10^{-11}$ and $1.2\times10^{-11}$; [r305](REVIEW_r305.md#L16), the row's cited source, reports $1.5\times10^{-12}$ and $1.4\times10^{-12}$. The record's figures are about eight times larger and are not attributed to a re-measurement. Either provenance is wrong or a re-measurement is unstated.

### 5. Label, Observation is right, the heading is not

`Observation` is the correct grade: the content is a fit to a census. **The dimensions.** The table's three rows are all $n=8$, [r305](REVIEW_r305.md#L15) and [bounds.md:94](../findings/bounds.md#L94) both identify $\theta=1.088948$ as the $n=8$ witness, and the block never says $8$. The formula's $n$-dependence was checked at **seven dimensions, $n=10$ through $16$** ([r310:60](REVIEW_r310.md#L60)), which the block does not name, while naming the census range $n=6\ldots16$ in the same sentence. **So four of the eleven dimensions in the stated range carry no test**, and a reader has no way to learn this from the block. [LEDGER.md:1500](../findings/LEDGER.md#L1500) already records L98 among the Observations carrying Lemmas, so the grade question has been noticed before; what is owed is the domain, not a promotion.

---

## The checklist

**Provenance.** Checked with `git log -S`. The formula entered at `2f5ba533` *"fix(diagonal): the diagonal cushion has a closed form and converges to 1"*, 2026-09-01 11:08; the cushion table six minutes earlier at `de443ae6` *"the off-locus cushion is 1.107x, not 2x"*; the heading was placed a day later by `03bab2f9` *"place headings for results 96-99"*. **The provenance notes in the block are true and the block is stale rather than false at birth**, r310 and r305 say what the block says they say, and every number attributed to them reproduces, with the single exception of the residual column (finding 6). The staleness is finding 5, and it entered one hour and thirty-nine minutes after the block was written.

**Hedging clauses.** *"offer it as a factor-two margin for a proof"*, accurate reporting of what the censuses were used for. *"twice what V3 asks"*, true of the ratio, and it is the ratio against a *forced* value, which the block does not say. *"the cushion"*, used for three different quantities in one block: the diagonal ratio, the off-locus ratio, and the slack a proof would have. *"and the margin has since fallen further"*, true when written and true again now, for a second reason the block does not carry. *"the formula checked here against every value it reports"*, weaker than it reads; see question 1. *"provisional until polished"*, discharged, see finding 5.

**Duplication, four kinds.**

- **A number, three ways.** $1.0417$, $1.025$ and the closed form are one statistic read at three populations' largest $n$: the formula gives $1.041\overline{6}$ at $n=7$ and $1.025$ at $n=8$ exactly. The block retires the second as a small-$n$ artefact and leaves the first standing two paragraphs later as independent encouragement. **They are the same artefact.**
- **A paragraph left under its own correction.** *"Two things that make the target look easier than stated"* at [:199](../findings/diagonal-half.md#L199) quotes the $66$-point minimum without its population, which [r304:71](REVIEW_r304.md#L71) gives as $n\le10$. If the closed form holds at $n=10$, a point at $1.011905$ exists there and the $66$-point census missed it. No contradiction (a census bounds a minimum from above) but the paragraph is the pre-r310 text and its rhetorical force depends on the reading r310 removed.
- **A statement duplicated across files.** The conclusion is carried verbatim by [reviews/INDEX.md:583](INDEX.md#L583) and summarised again at [ATTEMPTS.md:2601](../ATTEMPTS.md#L2601) and [INDEX-results.md:113](../findings/INDEX-results.md#L113); all three carry the bare $=$ and none carries r310's question mark. **The hedge was dropped at four sites independently.** L98 has no row in [results.md](../results.md).
- **The four-set family.** The hand-checkable quotient at [:201](../findings/diagonal-half.md#L201) appears once in [findings/](../findings/), so this block is clean on that count, but [plan-maximizer.md](plan-maximizer.md) cites it to L99 at four places, which [r561](REVIEW_r561.md#L199) and [r562](REVIEW_r562.md#L164) both already found. It belongs to L98.

**Does the file already settle it?** Partly, and against the block. [L99](../findings/diagonal-half.md#L163) writes the restriction $\lambda_{\max}(L_e\vert_{W^\perp})$ that L98 omits, twenty lines above. The padded $S^4\times S^4$ row at [:152](../findings/diagonal-half.md#L155) gives a diagonal critical point at $0.5714$, which is the counterexample to the heading read without its $\Delta>0$ hypothesis. And the trap paragraph in [L68](../findings/diagonal-half.md#L86) ($\Delta$ jumping under a $5\times10^{-10}$ perturbation), is what makes L98's $10^{-11}$ rows a question at all.

**Pointers.** All resolve. One mis-targets: *"[Reviewer 309](../reviews/INDEX.md)"* points at the reviews index, while [REVIEW_r309.md](REVIEW_r309.md) exists and is the right target. [run_check_diagonal_floor.py](../scripts/runs/run_check_diagonal_floor.py) exists and [scripts/INDEX.md:343](../scripts/INDEX.md#L343) describes it as the record uses it.

**One normalisation defect, finding 7.** *"over $66$ distinct $\Delta>0$ points the minimum of $\lambda_{\max}(L_e)$ is $1.0417$ … a counterexample would need $\theta>2\lambda_{\max}\gtrsim1.1$."* Under the sentence's own first reading, $\lambda_{\max}(L_e)\ge1.0417$ makes $\theta>2\lambda_{\max}$ read $\theta>2.08$, impossible against $\theta\le\Theta_n<\sqrt2$; the sentence would then say the census closes the diagonal half outright rather than making it "look easier". The reading that works takes $\lambda_{\max}$ as $\lambda_{\max}(L_W)$, whose observed range across r310's diagonal population is $0.55$–$0.81$, giving $\theta\gtrsim1.1$. **So $\lambda_{\max}$ carries two normalisations inside one sentence, and the second floor, $0.55$, is an unstated census artefact of exactly the kind the block spent its first half retiring.** [r562:139](REVIEW_r562.md#L139) flagged the same confusion twelve lines above this block and cited L98's own italic note while doing it.

---

## What is owed

1. **Restore r310's hedge.** The heading should read as a measured minimum over a named population, or carry $\overset{?}{=}$; the four sites that repeat it should follow.
2. **State the domain**: diagonal critical points with $\theta>0$ and $\Delta>0$, at $n\ge6$; and note that $n=4$ is empty, with the two-line reason in D3.
3. **Name the seven dimensions, $n=10\ldots16$**, and say that $n=6,7,8,9$ carry no test.
4. **Strike "provisional until polished" and move $1.1070\times$ to $1.1027\times$**, citing [r314](REVIEW_r314.md).
5. **Mark the restrictions on both sides of the $1.68$ comparison**, as [r310:70](REVIEW_r310.md#L70) asked.
6. **Restore the two minimisers r310 named** (the $n=16$ block vector $1,1,2,4,4,4$ and the $n=10$ point) since they are what a derivation would start from, and r310's $n=10$ note that $\lambda_{\max}$ agrees on the locus and on the full space is the one datum on the record bearing on question 4.
7. **Split the normalisations in the "$\theta>2\lambda_{\max}$" sentence** and give the $66$-point census its $n\le10$.
8. **Reconcile the residual column with [r305](REVIEW_r305.md)** or record the re-measurement.
9. **Blocked on computation, not worked around**: whether any diagonal critical point at $n=5$ has $\Delta>0$. Outcomes as stated in D3.
10. **Blocked on computation**: whether $\lambda_{\max}(L_e\vert_{W^\perp})$ restricted to $\mathcal D_n$ equals the full-space value at diagonal critical points generally. r310 reports agreement at its $n=10$ witness and [nondegeneracy.md](../findings/nondegeneracy.md) and [plan-diagfam.md:28](plan-diagfam.md#L28) agree at the $C_5$ blow-up. If it holds generally, the heading's ambiguity is harmless and D1 makes the whole question an $n\times n$ one; if it fails at one point, the closed form and the table are two different statistics and every comparison between them on the record needs re-reading.
