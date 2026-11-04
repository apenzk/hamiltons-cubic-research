# Review r576, Observation L25 (the ungraded census against the second-order bound)

Reviewer r576, independent adversarial audit, working from the definitions. Target: `Observation L25 (every ungraded critical point on file fails the second-order bound), canonical statement and proof`, [findings/second-order.md](../findings/second-order.md) lines 247–257.

**Overall: REFUTED as quantified, and repairable to a true statement that is weaker in one clause and stronger in another.** Two of the block's three assertions are false against the record, the headline, refuted by a named witness $124$ lines above it in its own file, and the range $[1.17,\,96.3]$, refuted by the block's own next sentence and by the section preamble six lines above the heading. What survives is a true and useful claim, and the repair can carry two facts the block does not have: a universal lower bound $\lambda_{\max}\ge\tfrac12$ that makes "fails the bound" mean "strictly", and a proof covering the bottom of the census's own $\theta$ range.

Analysis-only footing observed: nothing below was computed. Every number is either read off the record or derived by hand from [findings/conventions.md](../findings/conventions.md) and the recorded trace identities.

## What the block leans on that conventions.md still leaves open

Read in full. Four rows bear on this block, and one of them is the whole defect.

| symbol | status for this block |
| --- | --- |
| $L_e$, $\circ$, $e=W/\theta$ | defined, and the block's use is inside them |
| $\Pi$, $W^\perp$ | sense (i), the projection onto $W^\perp$; the block never names a sense but uses no other |
| $\lVert\cdot\rVert$ | the half-trace $\Lambda^2$ pairing; $\lambda_{\max}(L_e\vert_{W^\perp})$ is scale-free in it, so the trap costs this block nothing |
| **"ungraded"** | **undefined here, and it is the population.** [Trap W3](../findings/INDEX-traps.md) records three senses, (C) pair and (A) sign **incomparable**. The block's population is named by a word that picks out different sets under the two, and the two disagree at the block's own decisive witness |

The block also uses "on record" with no date, and "structured" with no definition anywhere on the record. Both are load-bearing; see D5.

## D1, REFUTED. The headline is false, and the witness is in this block's own file

**Claim.** *Every ungraded critical point on file fails the second-order bound*; equivalently, of the stated population *none satisfies $\lambda_{\max}\le\tfrac12$*.

**Witness, padded $W_{\mathbb{CP}^2}$.** [second-order.md:123](../findings/second-order.md) states it outright: *"Padded $W_{\mathbb{CP}^2}$ at $n=5$ is critical to $3\times10^{-16}$ with $\theta=\sqrt{3/2}$, is ungraded, and has $\lambda_{\max}(L_e\vert_{W^\perp})=0.5000000000$."* The same paragraph draws the conclusion in the block's own words: *"So 'ungraded $\Rightarrow\lambda_{\max}>\tfrac12$' is false."* The next paragraph adds that criticality under padding holds with residual **exactly zero**, so the witness is a theorem rather than a solver artefact, and records the value again at $n=8$.

**It is inside L25's population on every reading of the three words that define it.**

- *On file / on record*: yes, twice over, and [second-order.md:243](../findings/second-order.md) makes it the record's flagship, *"$W_{\mathbb{CP}^2}$ is the first nondegenerate ungraded critical point on record."*
- *Structured*: it is a named homogeneous point with a closed form, which is the only reading under which the phrase excludes the $155$ solver outputs.
- *Ungraded*: [trap W3](../findings/INDEX-traps.md) settles this rather than leaving it to a screen, *"$\mathbb{CP}^2$ is (C) not (A), $\ker W=3$ of $6$"*. So it is **not sign-graded**, which is the sense in which the $155$ points are called ungraded and the sense this file uses at both :123 and :243.

**The label is sound in the one direction that matters, so the escape is closed.** [Trap W4](../findings/INDEX-traps.md) voids the gradedness screen when $\ker W\ne0$, and padded $W_{\mathbb{CP}^2}$ has a large kernel, but W4's failure mode is a *false report of graded*, so it can only strip a point out of L25's population, never add one. W3 puts this point outside (A) by the bracket structure rather than by the screen, so the "ungraded" label survives the vacuity.

**The only surviving reading is (C), and the block cannot have it.** Under pair-gradedness $W_{\mathbb{CP}^2}$ is graded and the witness falls away, but then the block's own next sentence collapses, since it puts the $\mathfrak{su}(3)$ bi-invariant and $\mathfrak{so}(3)\subset\mathfrak{so}(5)$ in the population, and those are identified as ungraded by the slack, which is sense (A).

**A route sharing nothing with the block's.** The census is numerical; here is the same conclusion from the definitions. $Q$ is $O(n)$-equivariant, so for $X\in\mathfrak{so}(n)$ and $g_t=e^{tX}$, $Q(g_t\!\cdot\!W)=\theta\,g_t\!\cdot\!W$ identically; differentiating at $t=0$ gives $2L_Wz=\theta z$ with $z=X\!\cdot\!W$, that is $L_ez=\tfrac12z$. The action is orthogonal, so $\langle z,W\rangle=0$, and $\mathcal W_n$ carries no $O(n)$-invariant vector, so $z\ne0$ for some $X$. Hence

$$\lambda_{\max}\big(L_e\vert_{W^\perp}\big)\ \ge\ \tfrac12\quad\text{at every nonzero critical point, unconditionally.}$$

So $\lambda_{\max}\le\tfrac12$ is $\lambda_{\max}=\tfrac12$, and "fails the bound" means "**strictly** exceeds $\tfrac12$". Read this way the headline asserts that no point on file attains the bound exactly, and padded $W_{\mathbb{CP}^2}$ attains it exactly, to ten decimal places, which is precisely the shape of value the identity above predicts and a solver artefact does not produce.

**Verdict: REFUTED.** The repair is the hypothesis [ELIM-secondorder](ELIM-secondorder.md) W4 already named and the record did not apply: exclude the degenerate stratum, or restrict to $\ker W=0$. The restriction is cheap (every one of the $155$ is a random-start solver output with no kernel structure) and it costs the downstream use nothing, since Conjecture A's target is the high-$\theta$ region where the record's own $\Theta_n$ discussion places $W_{\mathbb{CP}^2}$ as a padded, kernel-heavy point.

## D2, REFUTED. The range $[1.17,\,96.3]$ is contradicted by the sentence after it and by the sentence before the heading

The statement quantifies the range over the union of the $155$ points **and** every structured ungraded point on record. Two independent contradictions, neither needing anything outside the two paragraphs.

**From inside the block.** The very next sentence reads: *"the values are exact rationals: $\tfrac34$ at the $\mathfrak{su}(3)$ bi-invariant and at $\mathfrak{so}(3)\subset\mathfrak{so}(5)$, $\tfrac56$ at the $\mathfrak{so}(5)$ adjoint, and $1$ across the multi-block products with $k\ge3$."* All four values lie **below** $1.17$. The block states a range and then lists four members outside it.

**From the section preamble, above the heading.** [second-order.md:245](../findings/second-order.md) (*"The ungraded margin is quantitative, not binary"*), lists the same points as ungraded with excesses $\tfrac14$, $\tfrac14$, $\tfrac14$, $\tfrac13$, $\tfrac12$ and concludes *"so $\lambda_{\max}\ge\tfrac34$ throughout"*. The preamble's floor for the ungraded population is $\tfrac34$; the block's is $1.17$. The preamble is right, because it carries the witnesses.

**Where $1.17$ actually comes from.** It is the floor of the $n=6$ solver population alone, not of the union. [ungraded-slack.md:65](../findings/ungraded-slack.md) gives that population as $\theta\in[0.007,\,0.512]$ from random multistart; two independent reruns bracket the same set, [r299](REVIEW_r299.md) reports $[1.479500,\,96.291798]$ over $100$ points and [r300](REVIEW_r300.md) reports $[1.670152,\,96.291798]$ over $58$. So the sentence conflates the census's own range with the range over the union it announces.

**Verdict: REFUTED.** Correct statement over the stated population: $\lambda_{\max}$ runs over $[\tfrac12,\,96.3]$, with $\tfrac12$ attained at padded $W_{\mathbb{CP}^2}$ and $\tfrac34$ the floor once that point is excluded; $[1.17,\,96.3]$ is the range of the $n=6$ solver population and belongs in the sentence that names it.

## D3, CONFIRMED, and the concern is void. No Lemma rests on this Observation

The structure check reports `L7 -> L25` and `L51 -> L25`. Both edges are artefacts of how the check cuts blocks, and neither Lemma cites, uses or depends on L25.

[check.py](../.claude/skills/structure-check/check.py) `check_f` builds each Lemma's block from `^#### Lemma L(\d+)` headings **only**, so a Lemma's block runs to the next *Lemma* heading and swallows every intervening `####` section, including Observation headings. Tracing both:

| edge | the Lemma's real block | where the `L25` token actually sits | inside the real block? |
| --- | --- | --- | --- |
| `L7 -> L25` | [bounds.md:43–61](../findings/bounds.md) | [bounds.md:80](../findings/bounds.md), in the next section, *"What $\Delta$ IS"* | no |
| `L51 -> L25` | [second-order.md:185–210](../findings/second-order.md) | [:247](../findings/second-order.md), [:253](../findings/second-order.md) (L25's own heading and statement) and [:603](../findings/second-order.md) | no |

The `L51` edge is doubly artefactual: the scan swallows L25's own heading, so the Observation is recorded as citing itself through its neighbour. This is the same failure the record already diagnosed once, [LEDGER.md:266](../findings/LEDGER.md) records *"L2's apparent citation is an artifact of the block scan running past the heading once it stopped saying `Lemma`"*. The check's own docstring says the phase *"reports rather than fails, each hit is a reading, not a violation"*, which is the correct posture; the reading here is that there is nothing to read.

**Verdict: CONFIRMED (the concern is void).** No Lemma rests on measurements at the dimensions measured through L25. Nothing downstream moves when D1 and D2 are repaired.

## D4, REPAIRED. The heading promises a proof; the label is right and the heading is wrong

The heading reads *"canonical statement and proof"*. The block contains a **Statement**, a *What it does not say*, and a *Why it is nevertheless the live route*. There is no argument, no $\square$, and no derivation of any kind. [results.md:382](../results.md) states the true character plainly: *"The observation is a census at the dimensions stated."*

**The label is correct and the heading is what moves.** The claim quantifies over a solver population at one dimension plus a hand-list; that is an Observation and nothing else. So no downgrade is in question and nothing becomes owed on that account.

**What a proof would have to cover, and how much of it is now available.** Two pieces of the block are provable and one is not.

1. **$\lambda_{\max}\ge\tfrac12$ everywhere**, proved in D1 above, from equivariance alone. This is the structural half, and it is what turns the census's content into "no point attains equality".
2. **A genuine slice of the census, from the record's own moments.** [second-order.md:91](../findings/second-order.md) records Fox's Theorem 1.3, $\mathop{\mathrm{tr}}(L_x)=0$ and $\mathop{\mathrm{tr}}(L_xL_y)=\kappa_n\langle x,y\rangle$ with $\kappa_n=\tfrac{(n-1)(2n-1)}4$, thirty lines above L25 and cross-checked there as $1155/84=13.75$ at $n=6$. At a unit critical point $\lVert e\rVert^2=\theta^{-2}$ and $L_ee=e$, so on $W^\perp$, of dimension $k=\dim\mathcal W_n-1$,
$$\textstyle\sum_i\lambda_i=-1,\qquad\sum_i\lambda_i^2=\kappa_n\theta^{-2}-1=:F^2 .$$
If every $\lambda_i\le c$ then $y_i:=c-\lambda_i\ge0$ and $\sum y_i^2\le(\sum y_i)^2$, which rearranges to $kc^2+2c\ \ge\ (F^2-1)/(k-1)$. At $n=6$, $k=83$ and $\kappa_6=\tfrac{55}4$, and $c=\tfrac12$ makes the left side $\tfrac{83}4+1=21.75$. So $\lambda_{\max}>\tfrac12$ whenever $F^2>1784.5$, that is whenever
$$\theta\ <\ \sqrt{13.75/1785.5}\ =\ 0.0877\qquad(n=6).$$
**Every critical point of $P$ on the unit sphere of $\mathcal W_6$ with $0<\theta<0.0877$ fails L24's bound, by proof and with no census.** The census's own floor is $\theta=0.007$, so this converts its bottom end into a theorem.
3. **What is left owed** is exactly the band $\theta\in[0.0877,\,0.512]$ at $n=6$, plus every structured point. The moment route cannot reach it, and this file says why four sections above: *"the obstruction is DIRECTIONAL, not dimensional"*, and *"$\mathop{\mathrm{tr}}L_e^2=\Theta(n^2)$ spread over $\Theta(n^4)$ eigenvalues puts the spectrum of $L_e$ at scale $1/n$ while the fence sits at $\tfrac12$"*.

**Verdict: REPAIRED.** Heading to *"canonical statement and evidence"*; the two provable pieces above added as a stated proof of the extremes, with the band named as owed.

## D5, REFUTED. The population is not falsifiable as written

Three separate failures, each sufficient.

**The $155$ cannot be enumerated by any reader today.** [data/](../data/) is empty. No `.npy`, `.npz` or table anywhere in the repository holds the census; the only trace is the prose at [ungraded-slack.md:65](../findings/ungraded-slack.md) and the pipeline name [p5_theta_aware.py](../scripts/pipelines/p5_theta_aware.py). The set is the output of one past random-multistart run, unsaved. A reader cannot check the range, cannot locate the point realising $1.17$, and cannot falsify the claim by inspection, only by re-running a stochastic search that will return a different set. Both reruns on record did exactly that: [r299](REVIEW_r299.md) and [r300](REVIEW_r300.md) found **no** point in $[1.17,\,1.67)$.

**"Every structured ungraded point on record" is undated and has grown.** The block was moved here on 2026-08-31 and carries no as-of date. The clause therefore quantifies over today's record, which is a different set.

**And it already quantifies over points whose $\lambda_{\max}$ is nowhere on the record.** [ungraded-slack.md](../findings/ungraded-slack.md) (the record's own file on the ungraded population), contains **no occurrence of $\lambda_{\max}$ at all**, while [:63](../findings/ungraded-slack.md) catalogues structured ungraded points at $\theta=0.8367,\,0.8519,\,0.8577,\,0.8700$ and the quaternionic family at $0.8529,\,0.7454,\,0.6857$, and [:109](../findings/ungraded-slack.md) adds $SU(6)/Sp(3)$ at $0.7464$. Eight named structured ungraded points, no $\lambda_{\max}$ for any of them. [second-order.md:305](../findings/second-order.md) makes it worse by constructing an **infinite unlisted family** of direct sums. So the range clause is not merely unverifiable; it asserts a bound over points nobody has measured.

**Verdict: REFUTED.** The repair is to say what the claim quantifies over: the $155$-point $n=6$ solver population of [p5_theta_aware.py](../scripts/pipelines/p5_theta_aware.py), and an explicit, dated list of structured points. Anything the record has not measured belongs outside the quantifier.

## D6, the "what it does not say" list: two values CONFIRMED, one clause REFUTED, completeness UNSHOWN

**$S^2\times S^{n-2}$ at $\tfrac12+\tfrac1{2(n-3)}$, CONFIRMED, twice.** [Lemma L127](../findings/second-order.md)'s four-set row gives $\mu_{p,q}=\frac{n-2}{2(p-1)(q-1)}$, which at $p=2$, $q=n-2$ is $\frac{n-2}{2(n-3)}=\tfrac12+\frac1{2(n-3)}$ identically. [Lemma L126](../findings/second-order.md)'s own box gives the same family as $\mu_{2,q}=\frac q{2(q-1)}$, which agrees at $q=n-2$. Third check at $n=6$: $\tfrac23$, matching the $S^2\times S^4$ value $0.666667$ recorded at [r297](REVIEW_r297.md).

**$\mathfrak u(m)\subset\mathfrak{so}(2m)$ at $\tfrac{m+2}{2(m+1)}$, value CONFIRMED, quantifier REFUTED.** The value is [Lemma L28](../findings/nondegeneracy.md)'s $\lambda_{\max}$ verbatim, on the $\mathfrak{su}(m)$ adjoint summand, and L28 derives it twice, once from the charge formula and once from $\mathop{\mathrm{tr}}L_e=0$ solved for that row alone. It checks at $m=3$ ($\tfrac58$) and $m=4$ ($0.600$) against [r297](REVIEW_r297.md)'s independent $\mathbb{CP}^3$ and $\mathbb{CP}^4$ values. The block's *"including $W_{\mathbb{CP}^3}$, which is graded and sits at $\theta_0(6)$ exactly"* also checks: $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}=\frac{20}{18}$ at $m=3$, and $\theta_0(6)^2=\frac{2\cdot5\cdot4}{36}=\frac{10}9$.

**But the block states the family with no lower bound on $m$, and L28 is stated for $m\ge3$.** At $m=2$ the formula would give $\tfrac23$, and the record gives $W_{\mathbb{CP}^2}$ two other values and neither is that one: $1$ at $n=4$, from [Lemma L24](../findings/second-order.md)'s own box (*"$\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$ is a $\circ$-orthogonal sum, so $\lambda_{\max}(L_e\vert_{W^\perp})=1$ there"*), and $0.5000000000$ padded, from [:123](../findings/second-order.md). **Write $m\ge3$ into the clause.** The omission is not idle: $m=2$ is the record's single most-cited point and is D1's witness.

**Completeness, UNSHOWN, and one half of it is a theorem the block could have cited.**

- *The sphere-product half is complete and provably so.* [Lemma L126](../findings/second-order.md) and [Lemma L127](../findings/second-order.md) between them cover the whole two-factor family: within a factor the pair blocks top out at $\frac{p-2}{2(p-1)}<\tfrac12$, across factors they sit at $\tfrac12$ on the orbit, and the four-set blocks exceed $\tfrac12$ exactly at $\min(p,q)=2$. So $S^2\times S^{n-2}$ is the *only* violating two-block sphere product, and that is a proof rather than a survey. The block asserts the list and cites neither lemma.
- *The rest is not complete.* [Trap W2](../findings/INDEX-traps.md) records that the $\mathbb Z_2$-grading enumeration is $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and $\mathfrak u(n/2)$ **only for $n\ne8$**, with $\mathfrak{spin}(7)$ and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ added at $n=8$. The block names one family from each of the first two and neither exceptional class, and no $\lambda_{\max}$ for either is on the record. A third graded violator would sit there if anywhere.
- *A concrete candidate the block does not name.* [r297](REVIEW_r297.md) records padded $S^3\times S^3$ at $n=8$ with $\lambda_{\max}=0.600000$ and $\Delta=0$; under the record's own $\Delta=0\Rightarrow$ graded it is a graded violator in neither named family. I flag rather than assert it: $\Delta$ is traced over $\{\lambda>0\}$ only ([conventions.md](../findings/conventions.md)) and the point is padded, so the same scepticism [trap W4](../findings/INDEX-traps.md) attaches to the slack screen at nonzero kernel should attach here.

**And the honest inverse is missing its sharpest case.** The block's *what it does not say* lists only points that **violate**. The criterion's worse blindness is at equality: $S^3\times S^3$ at $n=6$ is graded, has $\lambda_{\max}=\tfrac12$ **exactly**, [Lemma L127](../findings/second-order.md)'s four-set row at the one split where $\frac1{p-1}+\frac1{q-1}=1$, and is **not a local maximum**, failing at cubic order with nine transverse Hessian null directions ([Lemma L3](../findings/second-order.md)'s box). So the criterion admits non-maximisers that meet it with equality, which is a strictly stronger limitation than the one the block concedes and the reason no argument can close Conjecture A on L24 alone.

**One of the four "exact rationals" is a theorem, not a measurement.** *"$1$ across the multi-block products with $k\ge3$, where the value $1$ records that the idempotent is not primitive"* follows from [Lemma L24](../findings/second-order.md)'s simplicity clause read backwards: the $\Lambda^2\mathbb R^{p_i}$ blocks are Frobenius-orthogonal, so the sum is $\circ$-orthogonal and each piece is itself critical, which puts a second idempotent direction in the $1$-eigenspace. L24's hypothesis (*"criticality of the pieces cannot be dropped"*), is met. The block states this as data.

## D7, the three eliminations: one proved but family-scoped, one contradicted, one measured

The block: *"Three candidate constructions of the violating direction are already eliminated, rank-two directions are capped at $0$, $K$-invariant directions are multiples of $W$, and the slack's own subspace $\mathrm{Sym}^2(\mathfrak m)$ is strictly negative."*

All three descend from a single paragraph, [ATTEMPTS.md:1948](../ATTEMPTS.md), whose scope is **the subalgebra family**, the two-eigenvalue points $W_{\mathfrak h}\propto\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$. L25 restates them with that scope dropped, so each reads as a fact about the violating direction at an arbitrary ungraded critical point. It is not.

| elimination | status | where it breaks |
| --- | --- | --- |
| rank-two capped at $0$ | **proved, and family-scoped** | the argument is $R(x,y)=\alpha-\tfrac12(\beta\lvert z_{\mathfrak h}\rvert^2+\alpha\lvert z_{\mathfrak m}\rvert^2)$ with $\alpha=-\tfrac1{n-1}$ and $\sup\lVert[x,y]\rVert^2=2$, a real derivation, but $\alpha$ and $\beta$ are the family's **two** eigenvalues and no such pair exists at a general critical point |
| $K$-invariant directions are multiples of $W$ | **contradicted at a general point** | the source says *"on this family"*. [diagonal-half.md:181](../findings/diagonal-half.md) refutes the general form: at an $n=8$ point with $\Delta=11.16$ and $\lvert\mathrm{Aut}(M)\rvert=2$ the top eigenvector is fixed pointwise, deviation $0$, *"with invariant directions reaching the full $\lambda_{\max}$. So equivariant construction is unobstructed there."* |
| $\mathrm{Sym}^2(\mathfrak m)$ strictly negative | **measured, at symmetric points only** | [ATTEMPTS.md:1944](../ATTEMPTS.md) is a *retraction* of a stronger claim, not a lemma. [LEDGER.md:40](../findings/LEDGER.md) records *"the $\mathrm{Sym}^2(\mathfrak m)$ localization refuted"*, and [nondegeneracy.md:31](../findings/nondegeneracy.md) shows the whole construction fails to generalise: at a symmetry-free $n=6$ point the witness gives $F/\lVert C\rVert^2=-0.017$ against a minimum of $-0.480$, with the $\mathfrak m$-part carrying $16\%$ of the norm, *"the construction does not generalise and no witness formula is available"* |

**Verdict: REPAIRED.** Attach *"on the subalgebra family"* to all three, drop the second as a general statement or cite its refutation, and mark the third a measurement.

**Corroboration the block is entitled to and does not take.** The census's ceiling has been reproduced three times from implementations that never read it, [r298](REVIEW_r298.md) (seven points), [r299](REVIEW_r299.md) ($100$ points, $96.291798$), [r300](REVIEW_r300.md) ($58$ points, $96.291798$), and the record notes it at [second-order.md:603](../findings/second-order.md) and [bounds.md:82](../findings/bounds.md). An Observation whose whole warrant is a census should carry its independent reproductions in the block. This one cites nothing at all: no attribution line, no reviewer credit, no corroboration.

## Downstream use, 44 mentions, and the direction of the citations is right

Grepping the statement rather than the identifier: the record cites L25 for one thing, and cites it correctly. [bounds.md:80](../findings/bounds.md), [reviews/INDEX.md:481](INDEX.md) and [r297](REVIEW_r297.md) all use it the same way, as the fact that critical points routinely violate L24, therefore L24's conclusion may not be read as a fact about critical points. That use survives every defect above intact: it needs one violating critical point, and $\mathbb{CP}^3$ at $\tfrac58$ supplies it by closed form. [r298](REVIEW_r298.md), [r299](REVIEW_r299.md) and [r300](REVIEW_r300.md) cite the range as a comparison for their own runs and each states its own numbers, so a corrected range costs them nothing.

**No use anywhere depends on the floor $1.17$, on the count $155$, or on the universal quantifier.** The defects are real and none of them propagates.

## Verdict summary

| # | defect | verdict |
| --- | --- | --- |
| D1 | the headline, against padded $W_{\mathbb{CP}^2}$ at $\lambda_{\max}=0.5000000000$ | **REFUTED** |
| D2 | the range $[1.17,\,96.3]$, against the block's own next sentence and its preamble's $\tfrac34$ | **REFUTED** |
| D3 | `L7 -> L25` and `L51 -> L25`, both scanner artefacts, no Lemma rests on L25 | **CONFIRMED (void)** |
| D4 | *"and proof"* in the heading of a block with no proof | **REPAIRED** |
| D5 | the population is unenumerable, undated, and includes unmeasured points | **REFUTED** |
| D6 | the $\mathfrak u(m)$ clause missing $m\ge3$; completeness unshown; the equality case unnamed | **REFUTED in part** |
| D7 | three eliminations restated with their family scope dropped | **REPAIRED** |

**Overall: REFUTED as quantified.** The true statement inside it is worth keeping and is stronger than the one on the page:

> At every nonzero critical point $\lambda_{\max}(L_e\vert_{W^\perp})\ge\tfrac12$, so [Lemma L24](../findings/second-order.md)'s bound is met only with equality. Across the $155$-point $n=6$ solver population of [p5_theta_aware.py](../scripts/pipelines/p5_theta_aware.py), all ungraded, $\theta\in[0.007,\,0.512]$, $\lambda_{\max}$ ranges over $[1.17,\,96.3]$, and across the structured ungraded points with $\ker W=0$ the recorded values are $\tfrac34$, $\tfrac56$ and $1$; every one is strictly above $\tfrac12$. The one structured ungraded point attaining $\tfrac12$ exactly is padded $W_{\mathbb{CP}^2}$, whose kernel carries most of $\mathfrak{so}(n)$. At $n=6$ the failure is a theorem below $\theta=0.0877$, from $\mathop{\mathrm{tr}}L_e=0$ and $\mathop{\mathrm{tr}}L_e^2=\kappa_6\theta^{-2}$; the band above it is measured.
