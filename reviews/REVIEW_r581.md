# REVIEW r581, Lemma L5, the census of rival critical-point families

Reviewer r581, independent adversarial audit, from the definitions. Target: [Lemma L5, the census of rival critical-point families](../findings/graded-half.md#L41), [findings/graded-half.md:41–45](../findings/graded-half.md#L41).

Analysis-only footing observed. Every number below is derived by hand from closed forms already on the record; no sweep, search, census or falsifier hunt was run, and nothing here is offered as a numerical result.

## Overall verdict

**REFUTED as a Lemma. The six named eliminations survive on value; the census does not.**

Ten defects, of which four are refutations with witnesses. The block is labelled `Lemma`, which on this record means proved and Gate-2'd. [INDEX-results.md:20](../findings/INDEX-results.md#L20) records **"Gate 2: no verdict on the record"** against result 5. Independently of the label, the block's governing sentence (*"Needed to rule out every other critical-point family found so far"*), is refuted by a critical-point family recorded in **the same file twenty lines above the block**, which beats one of the two named competitors and appears nowhere in the census. And the census fails at the one job it names for itself: two of its six entries were **already closed in form on the record when it was written**, one of them 145 lines below it in the same file (D10).

| # | defect | verdict |
| --- | --- | --- |
| D1 | the label: `Lemma` on a claim about a moving population, with no Gate 2 on the record | **REFUTED** |
| D2 | *"lose to both named competitors"* is false for two of the six by the block's own parenthesis | **REFUTED**, repair available |
| D3 | the census omits at least four families the record holds, one of them above $\sqrt{3/2}$ | **REFUTED**, witness below |
| D4 | the provenance note is false in **both** clauses, nothing was moved, and its self-correction is itself wrong | **REFUTED** |
| D5 | *rival*, *critical-point family*, *the named competitors* and the normalisation of $P$ are all undefined | **CONFIRMED as a defect** |
| D6 | four of the eliminations are theorems on the record and are recorded as census entries | **REPAIRED**, derivations below |
| D7 | *"the highest tops out at $0.837$"*, in two downstream copies | **REFUTED**, $\mathbb{HP}^2$ sits at $1.115547$ |
| D8 | the report's certificate gives the SRG closed form as $\theta=\lambda-\mu+1$, against [Lemma L74](../findings/diagonal-half.md#L429) | **REFUTED** |
| D9 | adjacent, outside the block: [Lemma L9](../findings/graded-half.md#L213) conflates two families whose closed forms disagree | **REFUTED** |
| D10 | the eliminations the downgrade delivers as repairs were **already on the record** before the block was copied in | **REFUTED** |

## 0. The block's true boundaries, and the citation count

**As audited**, the block was [findings/graded-half.md:41–45](../findings/graded-half.md#L41), heading, one italic provenance line, one paragraph. *(It has since been downgraded to `Observation L5` and given a verdict blockquote; every quotation below is of the text as it stood when this audit ran, and the line anchors are re-checked against the current file.)* Nothing above the heading belongs to it: [line 39](../findings/graded-half.md#L39) closes the preceding *Concrete next step* paragraph of the graded-enumeration section, and [line 67](../findings/graded-half.md#L67) opens *Hermitian pairs*. **The substance is genuinely those six lines**, and there is no proof anywhere, no derivation, no per-family margin, no reference to a script that produced one.

**The brief's "28 genuine citations" is itself the artefact it warns against.** A repo-wide grep for `L5` not followed by a digit returns 38 hits; excluding line anchors removes one ([REVIEW_r547.md:175](REVIEW_r547.md#L175), a `00-abstract.tex#L5` anchor) and leaves 37, but **most of the remainder are a different L5 entirely**:

- **brief-local labels in reviewer reports for the Hilbert–Schmidt form**: [REVIEW_r324.md](REVIEW_r324.md) (5), [REVIEW_r323.md](REVIEW_r323.md) (2), [REVIEW_r565.md](REVIEW_r565.md) (2), [REVIEW_r566.md](REVIEW_r566.md) (1), [reviews/INDEX.md](INDEX.md) (3), [LEDGER.md:1255](../findings/LEDGER.md#L1255), 14 hits, none of them this result;
- **a brief-local `L5` in [REVIEW_r63.md:106](REVIEW_r63.md#L106)** for a Cauchy–Schwarz step;
- **script-local `L5` labels** for unrelated sub-lemmas in [review_r10_defectmax_independent.py](../scripts/lib/review_r10_defectmax_independent.py), [run_breakeven_theta.py](../scripts/lib/run_breakeven_theta.py), [run_frontier_bound_proof.py](../scripts/runs/run_frontier_bound_proof.py), [t_l1_l5.py](../scripts/reviewers/r324/t_l1_l5.py), [t_hyp.py](../scripts/reviewers/r324/t_hyp.py), 7 hits;
- **a line range in a paper abstract**, [hashimoto notes.md:5](../references/hashimoto-2023-hilbert-mumford-nilsolitons/notes.md#L5), "the abstract (L5–L11, verbatim)".

Grepping the **statement** rather than the identifier gives the real consumer set, and it is small:

| site | what it does |
| --- | --- |
| [results.md:53](../results.md#L53) | *"Fox, Nienhaus supply the rival families of Lemma L5, all eliminated on value"* |
| [results.md:118](../results.md#L118) | the landscape summary, **carries D7** |
| [results.md:318–320](../results.md#L318) | **a second, byte-identical copy of the block**, see D4 |
| [findings/INDEX.md:47](../findings/INDEX.md#L47) | routes L5 to graded-half.md as canonical |
| [findings/INDEX-results.md:20](../findings/INDEX-results.md#L20) | the numbered row, **"Gate 2: no verdict on the record"** |
| [findings/LEDGER.md:624](../findings/LEDGER.md#L624) | names L5 among the seven false provenance sentences |
| [REVIEW_r539.md:109](REVIEW_r539.md#L109) | reads the QK item as L5's claim rather than L9's |
| [report/sections/90-appendix.tex:49–50](../report/sections/90-appendix.tex#L49) | **a fourth copy, with a different list**, carries D7 and D8 |

So **eight sites, of which two are copies of the block itself**. A result cited twenty-eight times would carry a load this one does not.

## 1. D1, the label

*Verdict: REFUTED as a Lemma.*

Three independent grounds, any one sufficient:

1. **The record's own index says so.** [INDEX-results.md:20](../findings/INDEX-results.md#L20): *"**5** | Lemma | **Gate 2: no verdict on the record.** the census of rival critical-point families"*. On this record `Lemma` means proved and Gate-2'd; result 5 is neither.
2. **The block contains no argument.** It is a list of names with two bare numbers. Nothing in it is a statement a reader can check without leaving the file.
3. **The quantifier is over a moving population.** *"every other critical-point family found so far"* is a claim about the state of a search at an unnamed instant. It cannot be proved, and (the sharper point), it cannot be **refuted** either, because a family found later is by construction outside "so far". D3 shows it can nevertheless be refuted **against the record as it stood when the block was written**, which is the only reading under which the sentence has content.

**The correct label is `Observation`, verified at the families named.** If it is downgraded, the following becomes owed, and it is not a restatement of the same thing:

> **Owed on downgrade.** (a) Each of the six eliminations restated as its own claim with its own quantifier, for four of them a closed form or an inequality is already on the record, so those become Lemmas rather than observations (D6). (b) A **completeness clause naming the enumeration it is complete over**. The record now has one that can carry it: [Lemma L47 and Lemma L48](../findings/graded-half.md#L97), which close the entire compact symmetric class, irreducible and reducible, by the Dimension Lemma and the partition argument. A census complete over "what has been found" should be replaced by a theorem complete over a class defined in advance.

## 2. D5, what the block leans on that is undefined

*Verdict: CONFIRMED as a defect.*

Checked against [conventions.md](../findings/conventions.md) in full (32 rows). The block's exposure to that file's live collisions is narrow (it uses none of $\Pi$, $\mathfrak m$, $d$, $\psi$, $B$, $M$, "Theorem A" or "graded") but four things it does use have no definition:

- **"rival"**, no row in conventions.md, no definition anywhere. Rival to what, and by how much, is what the whole block turns on.
- **"critical-point family"**, conventions.md defines **"critical point" as $Q(W)=\theta W$**, and warns in the same row that *"the bracket form $[W,Q(W)]=0$ is strictly weaker and is satisfied by every diagonal Weyl tensor"*. Every SRG-derived member of the census is diagonal, so the census's fifth item sits exactly on that trap. It survives it, [Lemma L74](../findings/diagonal-half.md#L429) proves the SRG solutions are genuine critical points, and derives the graph identity as the admissibility condition rather than assuming it, **but nothing in the block says which sense is meant, and the record's own convention row exists because the two have been confused.** *"Family"* itself has no definition at all: it is doing the work of deciding whether the $\mathfrak{so}(5)$ spin point is one member or one family, which is what makes the block's count of six-then-seven unstable.
- **"both named competitors"**, never named in the block, and not linked. They are the balanced sphere product at $\theta_0(n)$ and the $\mathbb{CP}^2$-type competitor at $\sqrt{3/2}$, from [Lemma L2](../results.md#L112), which the block does not cite. Since the two **swap ranks at $n=6+2\sqrt7\approx11.29$**, "loses to both" is a different statement above and below that dimension, and the block fixes no $n$ (D3 on the quantifier).
- **the normalisation behind the bare $P$ values.** conventions.md defines $P(W)=\langle W,Q(W)\rangle$, which is **cubic and so not scale-invariant**, and $\theta=P(W)/\lVert W\rVert^3$. The block writes $P\le0.837$ and $P=0.387$ with no norm stated. They are right at $\lVert W\rVert=1$ in the record's half-trace $\Lambda^2$ pairing (checked below) but conventions.md's own norms section warns that *"applying the $\tfrac12$ at the operator level instead inflates every $\theta$ by $\sqrt2$"* and that this *"has cost a cycle"*. A bare cubic-form value with no normalisation is precisely the exposure that warning describes.

**Screen on the normalisation** (seconds of arithmetic, on the operator the record supplies; reported as a screen). [REVIEW_r10.md:5](REVIEW_r10.md#L5) gives the $\mathfrak{so}(5)$ point explicitly as $W=\tfrac{3}{2\sqrt{15}}\Pi_4-\tfrac{1}{\sqrt{15}}\Pi_6$. Then $\mathop{\mathrm{tr}}W=\tfrac{4\cdot3}{2\sqrt{15}}-\tfrac6{\sqrt{15}}=0$ and $\lVert W\rVert^2=\tfrac9{60}\cdot4+\tfrac1{15}\cdot6=\tfrac35+\tfrac25=1$. So $\lVert W\rVert=1$ and $P=\theta=0.387298=\sqrt{3/20}$, in the pairing that makes $\{\varphi_{ab}\}_{a<b}$ orthonormal. **The values are right; the block does not say in what.**

## 3. D2, the list, family by family

*Verdict: REFUTED as stated, with a repair.*

The sentence audited, quoted whole:

> Six further families lose to both named competitors: multi-block sphere products (3+ factors), Fox's full 5-dimensional hyper-Kähler subalgebra and its $r\geq8$ extension (both collapse onto orbits of already-named competitors, the latter tied to the quaternionic-Kähler family named next), quaternionic-Kähler operators on $\mathbb{HP}^m$, $m\leq4$ … strongly-regular-graph-derived solutions … and the simple-isotropy members of Lemma L4's family, which top out at $P\leq0.837$.

**First, the count is ambiguous.** Read by commas the list has five items; it reaches six only if Fox's subalgebra and its $r\ge8$ extension are counted separately, which [results.md:118](../results.md#L118) confirms is the intent (*"both of Fox's hyper-Kähler subalgebras"*). The block's own parenthesis, by contrast, treats them as one phenomenon.

**Second, and this is the defect: "lose to" is false for those two items, by the block's own parenthesis.** *"Both collapse onto orbits of already-named competitors."* $Q$ is $O(n)$-equivariant and the norm is invariant, so **$\theta$ is constant on an orbit**. A family that collapses onto a named competitor's orbit therefore has **exactly that competitor's value**. It ties; it does not lose. The block asserts the strict statement and supplies the non-strict one in the same breath.

This is confirmed downstream and independently: [ATTEMPTS.md:833](../ATTEMPTS.md#L833) records **Fox's $\mathcal S^4(\alpha)$ as the $m=2$ member of the Ricci-flat Kähler family**, whose closed form $\theta(m)=\sqrt{m(m+1)/((m+2)(m-1))}$ gives $\theta(2)=\sqrt{3/2}$, the $\mathbb{CP}^2$-type competitor's value exactly. And the block's *own last sentence* says as much for the seventh family. So the block contains, six lines apart, both *"six families lose to both named competitors"* and the fact that two of the six attain one of those competitors' values.

**Repair.** *"Six further families fail to exceed either named competitor: two of them because they collapse onto a named competitor's orbit and so attain its value exactly, four of them strictly."*

**Third, family by family.** Every value below is derived by hand from a closed form already on the record; the derivations are in D6.

| family | best value | vs $\sqrt{3/2}=1.224745$ | vs $\theta_0(n)$ | margin recorded in the block? |
| --- | --- | --- | --- | --- |
| multi-block sphere products, $k\ge3$ | $\theta=0.829156$ at $k=3$, $n=12$; $\to1$ as $n\to\infty$ | strictly below at every $n$ | strictly below at every $n$ | no |
| Fox's 5-dimensional hyper-Kähler subalgebra | $\sqrt{3/2}$ | **equal** | above $\theta_0(n)$ for $n<11.29$ | no |
| Fox's $r\ge8$ extension | on a named orbit | **equal** | as above | no |
| QK operators on $\mathbb{HP}^m$, $m\le4$ | $\theta^2=56/45$, $\theta=1.115547$ at $\mathbb{HP}^2$, $n=8$ | below by $0.109$ | below $\theta_0(8)=1.145644$ **by $0.030$** | no |
| SRG-derived solutions | closed form in [L74](../findings/diagonal-half.md#L429); block cites a sweep to $n\le200$ | asserted | asserted | no, "falls well short" |
| simple-isotropy members of [L4](../results.md#L312) | $\theta=0.836660$ at $SU(3)$, $n=8$ | below | below | **yes**, $P\le0.837$ |

**Only one of the six carries a margin.** The QK entry is the one where that matters: its margin against $\theta_0(8)$ is $0.030$, which is not what *"falls well short"* or *"none is close"* describes, and the block's own cross-reference calls it *"a genuine peak in its own right"*.

## 4. D3, the census omits families the record holds, one of them above $\sqrt{3/2}$

*Verdict: REFUTED. The witness is in the block's own file, twenty lines above it, and shares nothing with the block's route.*

### The witness

[findings/graded-half.md:27–33](../findings/graded-half.md#L27) tabulates the unbalanced sphere products at $n=12$ and states in terms: *"every unbalanced sphere product is a genuine three-eigenvalue graded critical point, and $S^5\times S^7$ at $n=12$ sits at $1.228239>\sqrt{3/2}=1.224745$."*

**These are two-factor products, so they are outside the census's only sphere-product entry, which reads "3+ factors".** They are critical-point families, they were found before the block was written, and $S^5\times S^7$ **beats one of the two named competitors**. The census's governing sentence is therefore false as stated.

**Verified by exact rationals, by two routes neither of which is the table's solver.**

*Route 1, the file's own partition identity* ([graded-half.md:97ff](../findings/graded-half.md#L97)). At Einstein constant $\tfrac12$, $\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+\sum_af(n_a)-\frac n{8(n-1)}$ with $f(m)=\frac m{8(m-1)}$; sphere factors have $\lVert W_a\rVert^2=0$. For $(5,7)$ at $n=12$,
$$\lVert W\rVert^2=\frac5{32}+\frac7{48}-\frac3{22}=\frac{15}{96}+\frac{14}{96}-\frac{3}{22}=\frac{29}{96}-\frac3{22}=\frac{638-288}{2112}=\frac{350}{2112}=\frac{175}{1056}.$$
The same section's equivalence $\theta\le\sqrt{3/2}\iff\lVert W\rVert^2\ge\tfrac16$ fixes $\theta=1/(2\lVert W\rVert)$ on this class, so $\theta^2=\frac1{4\lVert W\rVert^2}=\frac{1056}{700}=\frac{264}{175}$.

*Route 2, the sphere-product closed form* at [graded-half.md:421](../findings/graded-half.md#L421), $\theta^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$, at $(n,p,q)=(12,5,7)$: $\frac{2\cdot11\cdot4\cdot6}{10\cdot35}=\frac{528}{350}=\frac{264}{175}$.

**Both give $\theta^2=\frac{264}{175}$ exactly, and $\frac{264}{175}>\frac32=\frac{262.5}{175}$.** The table's $1.228239158$ is $\sqrt{264/175}$. No computation is needed to see the inequality: it is a comparison of two fractions over the same denominator.

**And it is not one point.** The same line proves *"sphere products exceed the rival maximizer's value exactly when $p,q\ge5$"*, reducing to $n^2-7n-54\ge0$, an infinite family above $\sqrt{3/2}$, entirely absent from L5's census.

### Three further omissions, all inside the same file

| omitted family | where the record holds it | value |
| --- | --- | --- |
| the $\mathbb{CP}^m$ family (tabled as "Hermitian pairs") | [graded-half.md:67–74](../findings/graded-half.md#L67) | $\theta^2=\frac{(2m-1)(m+1)}{3m(m-1)}$, derived below |
| Wolf spaces and complex Grassmannians | [graded-half.md:84–90](../findings/graded-half.md#L84) | $\theta$ from $1.115547$ down to $0.596068$ |
| 18 distinct graded critical points at $n=8$ (r307's census) | [graded-half.md:254](../findings/graded-half.md#L254) | *"against the two this record held"* |

The last is the sharpest on the block's own terms: sixteen critical points the record found and the census of "every other critical-point family found so far" does not mention.

**Note the asymmetry with the report.** [report/sections/90-appendix.tex:50](../report/sections/90-appendix.tex#L50) states the same Lemma with **$SO(2m)/U(m)$ and the complex Grassmannians added to the list**. So the record already knows the findings-file list is short, and the two published statements of Lemma 5 disagree on their own contents.

### Derivation of the omitted $\mathbb{CP}^m$ closed form, and why it matters

From Petersen–Stanfield Prop 2.2 as the file uses it: $\mathbb{CP}^m$ has $n=2m$, $N=m(2m-1)$, $\mathfrak h=\mathfrak u(m)$, curvature eigenvalue $\tfrac12$ on the centre (multiplicity $1$), $\lambda$ on $\mathfrak{su}(m)$ (multiplicity $m^2-1$), $0$ on the remaining $N-m^2$ directions. $\mathop{\mathrm{tr}}R=n/4=m/2$ gives $\lambda=\frac1{2(m+1)}$, and $c=\mathop{\mathrm{tr}}R/N=\frac1{2(2m-1)}$. With $W=R-cI$,
$$\lVert W\rVert^2=\Big(\tfrac12-c\Big)^2+(m^2-1)(\lambda-c)^2+(N-m^2)c^2,\qquad \theta^2=\frac1{4\lVert W\rVert^2}=\frac{(2m-1)(m+1)}{3m(m-1)}.$$

This **reproduces every value the record holds for the family**: $m=2\to\tfrac32$; $m=3\to\tfrac{10}9$ (the $\sqrt{10}/3=1.054093$ of [L9](../findings/graded-half.md#L225)); $m=4\to\tfrac{35}{36}$, $m=5\to\tfrac9{10}$, $m=6\to\tfrac{77}{90}$, $m=7\to\tfrac{52}{63}$, the four rows of the [Hermitian-pairs table](../findings/graded-half.md#L69), and $m=8\to\tfrac{45}{56}$, which is the value the pre-move version of this file recorded as *"confirmed independently at $m=8$"*. The limit is $\tfrac23$, as that same line states. **Seven independent checks of one hand-derived formula.**

Its bearing on L5: the family is monotone decreasing from $\theta^2=\tfrac32$ at $m=2$, so it loses to both competitors for every $m\ge3$ and ties at $m=2$, **an elimination in closed form, at every $m$, that the census does not contain.**

## 5. D4, the provenance note, false in both clauses

*Verdict: REFUTED. This section supersedes the first version of it in this report: I checked the history further and the block's self-correction is itself wrong, in the block's own favour.*

The note read: *"Moved here from [results.md](../results.md) on 2026-08-31. **The claim once made here, that results.md held the only copy, is false against the commit before the move**: this file already carried a block for this result."*

**Clause 1, "Moved here", FALSE.** Nothing moved.

- [results.md:318–320](../results.md#L318) still carries `##### Lemma L5, rival critical-point families` with the full paragraph.
- `cmp` of the two paragraphs reports **byte-identical**.
- Git: results.md's copy entered at `56848c5e` and has never been removed; graded-half.md's entered at `84cada75` as an addition. The commit that performed it is titled *"the four proofs that lived only in results.md move to findings"*.

**Clause 2, the self-correction, ALSO FALSE, and it is the more interesting of the two.** The check that settles it is one `git grep` at the commit before the move:

- `git grep -l "Six further families lose to both" 84cada75^` returns **`results.md` and nothing else**.
- `git grep "rival critical-point famil" 84cada75^` returns results.md twice (the landscape row at :139 and the block at :244) and the [results-spec](../.claude/skills/research-loop/results-spec.md) quoting it as an example, **no findings file**.
- [graded-half.md](../findings/graded-half.md) at `84cada75^` carries **no L5 block and no census paragraph**; searching it for the six families by name returns only the closed-form treatments of D6, which are different objects.

**So results.md did hold the only copy, the original claim was right, and the "correction" that replaced it is wrong**, while presenting itself as the outcome of a check against a named commit. What graded-half.md did carry beforehand is the $\mathbb{CP}^m$ closed form with *"at $m=2$ it equals exactly $3/2$: $W_{\mathbb{CP}^2}$ is the $m=2$ member"*, the seventh-family sentence's content under a different heading, which is presumably what the correction saw and over-read into "a block for this result".

**The compound failure is the point.** [LEDGER.md:624](../findings/LEDGER.md#L624) lists L5 among seven blocks caught by a mechanical provenance sweep and reports *"six are corrected in place"*. Here the mechanical sweep's verdict was **wrong for this block**, the correction was written from it without re-checking, and the clause that was actually false (*"moved"*), was left standing. **A sweep that is right seven times out of seven on a class does not license writing its verdict into a block unchecked**, which is what the record's own convention on quoting rather than restating exists to prevent.

Meanwhile [findings/INDEX.md:47](../findings/INDEX.md#L47) declares graded-half.md's copy *"Canonical Lemma L5"* with an identical non-canonical copy live in results.md and a **third, differently-worded** statement in [90-appendix.tex:49–50](../report/sections/90-appendix.tex#L49). D3 and D7 show the three copies **have already disagreed**, on the census's contents and on its ceiling.

## 6. D6 and D10, the eliminations are theorems, and the record already held them

*Verdict: REPAIRED, and REFUTED on novelty. Four of the six eliminations are closed-form theorems. **Two of them were already on the record before the census block was copied into this file, and are still there**, so the census, whose stated purpose is that a later cycle does not re-derive a family as new, is itself a re-derivation of what stood beside it.*

### (a) Multi-block sphere products, $k\ge3$, the closed form is in [ungraded-slack.md:27](../findings/ungraded-slack.md#L27)

That block gives, for $S^{n_1}\times\dots\times S^{n_k}$,
$$\theta^2=\frac{2(n-1)^2}{(k-1)n^2+\sum_a\frac{(n-n_a)^2}{n_a-1}},$$
and draws from it, verbatim, **"$\theta^2<2/(k-1)$ strictly, so $k\ge3$ forces $\theta<1$ for every partition and every $n$"**. It stood at `84cada75^`, before the census arrived, in the file [Lemma L4](../results.md#L312) names as its proof pointer.

I derived the same elimination independently from this file's own partition identity before finding it, and the two agree exactly. From $f(m)=\tfrac m{8(m-1)}=\tfrac18\big(1+\tfrac1{m-1}\big)$,
$$\lVert W\rVert^2=\frac{k-1}8+\frac18\Big(\sum_a\frac1{n_a-1}-\frac1{n-1}\Big)>\frac{k-1}8,$$
since each $n_a<n$, whence $\theta=1/(2\lVert W\rVert)<\sqrt{2/(k-1)}$, uniformly in $n$, and $\theta<1$ at $k\ge3$. **Cross-checked against ungraded-slack.md's closed form on three of its own values, to exact rationals**: $S^5\times S^7$ gives $\tfrac{242}{160.41\overline6}=\tfrac{264}{175}$, matching D3's two other routes; $(S^3)^4$ gives $\tfrac{242}{594}$, i.e. $\theta=0.638285$; $(S^8)^3$ gives $\tfrac{1058}{1261.714}=\tfrac{161}{192}$, the value that block records.

### (b) The QK family, the closed form is in **this file**, 145 lines below the block

[graded-half.md:190–200](../findings/graded-half.md#L190) gives
$$\theta^2(\mathbb{HP}^m)=\frac{(m+2)^2(4m-1)}{9\,m(m-1)(2m+1)},$$
proves it **strictly decreasing** by an explicit derivative with an elementary positivity argument, and concludes $\sup_m\theta(\mathbb{HP}^m)=\sqrt{56/45}=1.115546702<\sqrt{3/2}$ with $\theta\to\tfrac{\sqrt2}3$, closing *"the whole quaternionic family … for every $m$ at once, by proof rather than by the two points tabulated"*. It too predates the census's arrival.

**The census still says "$m\le4$" and still files it as a checked family.** Checked against my own route: at $m=2$, $\tfrac{16\cdot7}{9\cdot2\cdot1\cdot5}=\tfrac{112}{90}=\tfrac{56}{45}$, which is $1/(4\cdot\tfrac{45}{224})$ from the rank-one residue at [graded-half.md:106](../findings/graded-half.md#L106) and from the partition identity at $S^3\times S^5$, $\tfrac3{16}+\tfrac5{32}-\tfrac17=\tfrac{45}{224}$, the three agreeing because [L9](../findings/graded-half.md#L213) proves $\mathbb{HP}^2=\tau(S^3\times S^5)$ for an orthogonal $\tau$ preserving $Q$. At $m=3$, $\tfrac{25\cdot11}{9\cdot3\cdot2\cdot7}=\tfrac{275}{378}$, i.e. $\theta=0.852944$, reproducing the [Wolf table](../findings/graded-half.md#L86)'s $\mathbb{HP}^3$ to nine digits.

### (c) The seventh family's peak, one line

[ATTEMPTS.md:833](../ATTEMPTS.md#L833) gives $\theta(m)^2=\frac{m(m+1)}{(m+2)(m-1)}=1+\frac2{m^2+m-2}$, monotone decreasing on $m\ge2$, $\theta(2)^2=\tfrac32$, limit $1$. *"The family peaks there"* is a corollary of a closed form, not an observation.

### (d) The SRG elimination, closed form on the record, sweep in the block

[Lemma L74](../findings/diagonal-half.md#L429) gives $\theta$ in closed form for **every** strongly regular graph and proves the correspondence exact, the admissibility condition *is* the graph identity, so no parameter set escapes it. The block offers *"an exhaustive parameter sweep to $n=200$"*, a bounded quantifier, and **does not cite L74**. Whether L74's closed form is bounded by $\sqrt{3/2}$ over all admissible $(v,k,\lambda,\mu)$ is a derivation this audit does not have; it should be recorded as owed rather than assumed.

### D10, what this costs the block

The census's own closing sentence states its purpose: *"the record of what has been checked and found short, so a later cycle does not re-derive one of them as new."* **Two of its six entries were, at the moment it was written into this file, already closed in form on the record**, one of them 145 lines below it in the same file, the other in the file its neighbour L4 points to. The census recorded them as measurements anyway, and the downgrade now under way presents the $k$-block bound $\theta<\sqrt{2/(k-1)}$ as *"a repair delivered … that elimination is no longer a measurement"*, when [ungraded-slack.md:27](../findings/ungraded-slack.md#L27) states it in those words and has done throughout. **The census failed at the one job it names for itself, on its own material.**

## 7. D7, "the highest tops out at $0.837$"

*Verdict: REFUTED, in both downstream copies, by the record's own tables. **Both sites were repaired while this audit was running**; the finding is recorded because the derivation is independent of the repair and because the diagnosis matters.*

As found:

- [results.md:118](../results.md#L118): *"The highest tops out at $0.837$ against $\sqrt{3/2}\approx1.225$, so none is close."*
- [90-appendix.tex:50](../report/sections/90-appendix.tex#L50): *"The highest value among them is $0.8367$, against $\thstar\approx1.2247$."*

Both lists contain **the quaternionic-Kähler operators on $\mathbb{HP}^m$**, whose largest member sits at $\theta=\sqrt{56/45}=1.115547$, established three ways in D6(b), one of them the record's own [Wolf-space table](../findings/graded-half.md#L86) and one the file's own closed form for the whole family. The appendix's list additionally contains $SO(2m)/U(m)$ and the complex Grassmannians, whose tabulated values run to $0.986013$, also above $0.837$.

$0.8367$ is the maximum of **one** of the six families, the simple-isotropy members of [L4](../results.md#L312), and there it is right: L4's closed form $\theta=\frac2n\sqrt{\frac{rN}{N-r}}$ at $(n,r)=(8,8)$ gives $\tfrac14\sqrt{\tfrac{8\cdot28}{20}}=\tfrac14\sqrt{11.2}=0.836660$, and at $(14,21)$ gives $\tfrac17\sqrt{\tfrac{21\cdot91}{70}}=0.746424$, reproducing both of L4's published values. **The error is that a per-family maximum was promoted to the census maximum**, and *"so none is close"* then rested on it, against a true nearest margin of $0.030$ against $\theta_0(8)=\sqrt{21/16}=1.145644$.

The graded-half block itself was clean here: it attached $P\le0.837$ only to the L4 item. **The defect lived entirely in the two copies that summarise it**, which is exactly the cost of D4's three divergent copies, and the reason recommendation 2 below is not cosmetic.

**Status.** Both sites now carry the corrected ceiling $\sqrt{56/45}\approx1.1155$ and the margin $0.109$. My derivation reached that number independently, from the $\mathbb{HP}^m$ closed form and from the $S^3\times S^5$ partition identity, before either site changed.

## 8. D8, the report's SRG certificate

*Verdict: REFUTED.*

[90-appendix.tex:54](../report/sections/90-appendix.tex#L54): *"For the strongly regular graphs the elimination is by closed form: $Q(W)=\theta W$ with $\theta=\lambda-\mu+1$ for every such graph."*

That is not $\theta$ in this record's normalisation. $\theta=P(W)/\lVert W\rVert^3$ is scale-invariant and, on the diagonal locus, is what [L74](../findings/diagonal-half.md#L429) computes. At the octahedron $\mathrm{SRG}(6,4,2,4)$, L74 returns $\lvert\theta\rvert/\lVert W\rVert=5/\sqrt{60}=0.645497$, while $\lambda-\mu+1=2-4+1=-1$. At $K_{m,m}=\mathrm{SRG}(2m,m,0,m)$ (the saturating member L74 identifies as the balanced sphere product), $\lambda-\mu+1=1-m$, unbounded below in $m$, against $\theta_0(2m)=\sqrt{(2m-1)(m-1)}/m$, bounded by $\sqrt2$. **$\lambda-\mu+1$ is the restricted adjacency eigenvalue, not the record's $\theta$**, and the certificate offers it as the ground on which the sweep to $n=200$ is *"exhaustive rather than sampled"*. The same certificate also states $\mu=3$-style parameter data of the kind [Reviewer 339](REVIEW_r339.md) caught in L74's own block, where the recorded hazard is that *"$\mu$ cancels out of $F_{\text{edge}}$"*.

## 9. D9, adjacent: L9's Ricci-flat Kähler paragraph conflates two families

*Verdict: REFUTED. Recorded because L5 cites L9 and because it is the same collision L5's seventh-family sentence sits on. It is a defect in [L9](../findings/graded-half.md#L225), outside L5's block.*

The record carries **two** families under Kähler names, agreeing at $m=2$ and nowhere else:

| family | closed form | $m=2$ | $m=3$ | limit |
| --- | --- | --- | --- | --- |
| $(\mathfrak{su}(m),\mathfrak{so}(m))$ Ricci-flat Kähler on $\mathbb C^m$, [ATTEMPTS.md:833](../ATTEMPTS.md#L833) | $\theta^2=\frac{m(m+1)}{(m+2)(m-1)}$ | $\tfrac32$ | $\tfrac65$ | $1$ |
| $\mathbb{CP}^m$, tabled as "Hermitian pairs", [graded-half.md:69](../findings/graded-half.md#L69) | $\theta^2=\frac{(2m-1)(m+1)}{3m(m-1)}$ (D3) | $\tfrac32$ | $\tfrac{10}9$ | $\tfrac23$ |

[L9](../findings/graded-half.md#L225) writes *"The Ricci-flat Kähler family's $m=3$ and $m=4$ members are ordinary saddles"* and evidences it with **$\mathbb{CP}^3$ at $n=6$**, whose $\theta^2=\tfrac{10}9$ is not the first family's $m=3$ value of $\tfrac65$. The record refutes the identification independently, twice: [graded-half.md:188](../findings/graded-half.md#L188) and [REVIEW_r85.md:55](REVIEW_r85.md#L55) both state that the $(\mathfrak{su}(m),\mathfrak{so}(m))$ points have $W$ *"supported on $\mathfrak{su}(m)\subset\mathfrak{so}(2m)$ and zero outside"*, hence **cannot be symmetric spaces** and are *"a DIFFERENT KIND OF OBJECT, not a peer"*. [REVIEW_r504.md:158](REVIEW_r504.md#L158) records the sibling misnaming already. **And [graded-half.md:188](../findings/graded-half.md#L188) now carries a third closed form under a fourth name**, $\theta^2(SU(m)/SO(m))=\frac{8m(m^2+m-4)}{(m-2)(m-1)(m+1)(m+2)(m+4)}$, *"a different formula"* again, so three distinct families sit under Kähler-adjacent labels and the census names one.

**Bearing on L5.** L5's seventh-family sentence, *"a Ricci-flat Kähler family on $\mathbb C^m$ … whose $m=2$ member is the $\mathbb{CP}^2$-type competitor itself, and the family peaks there"*, is **true under either reading**, since both peak at $\theta^2=\tfrac32$ at $m=2$. It is the one sentence in the block that survives every attack in this review. But it inherits the ambiguity, and D3 shows the cost: the census names one Kähler family where the record holds two, and omits the other.

## 10. The quantifier

*Verdict: CONFIRMED as a defect.* The block names no dimension. Its claims are, in fact, of four different quantifier strengths:

| item | actual reach |
| --- | --- |
| multi-block sphere products | every $n\ge4$, every $k\ge3$, a theorem (D6a) |
| QK on $\mathbb{HP}^m$ | stated $m\le4$; true at every $m$ (D6b) |
| SRG solutions | $n\le200$, primitive cases, by sweep |
| L4's simple-isotropy members | the members evaluated |
| the seventh family | every $m\ge2$, by closed form (D6c) |
| *"lose to both named competitors"* | undefined, the two competitors swap ranks at $n\approx11.29$ ([L2](../results.md#L112)) |

**Presenting these under one sentence is what lets the strongest reading of the block ("no rival anywhere") be carried by its weakest ingredient.**

## Recommended repairs

Items 1, 3 and 6 landed while this audit was running; they are kept here with what each still owes.

1. **Relabel to `Observation`** (*done*) and record the owed statement of §1 against it: a closed form plus a whole-range bound per structural class, and a completeness clause naming the class rather than the search.
2. **Delete the duplicate at [results.md:318–320](../results.md#L318)**, leaving the statement plus a pointer, as [L9](../findings/graded-half.md#L215) already does. **Both clauses of the provenance note need correcting (D4)**, *"moved"* is false, and so is the self-correction that replaced *"the only copy"*; results.md **did** hold the only copy at `84cada75^`. Reconcile [90-appendix.tex:49–50](../report/sections/90-appendix.tex#L49) to whichever copy is canonical.
3. **Restate the six-item sentence** so the orbit-collapse items read as ties (*done*) and attach the per-family margin to each, with the QK margin of $0.030$ against $\theta_0(8)$ stated rather than *"falls well short"*, which still stands in the paragraph.
4. **Cite the closed forms rather than re-deriving them (D10)**: [ungraded-slack.md:27](../findings/ungraded-slack.md#L27) for the $k$-block bound $\theta^2<2/(k-1)$, and [graded-half.md:190–200](../findings/graded-half.md#L190) for $\theta^2(\mathbb{HP}^m)$ and its monotonicity, which removes the *"$m\le4$"* qualifier the paragraph still carries. Cite [L74](../findings/diagonal-half.md#L429) for the SRG family and record the whole-range bound over its closed form as **owed**, in place of the sweep to $n=200$.
5. **Add the omitted families of D3**, and cite [graded-half.md:421](../findings/graded-half.md#L421), 380 lines below, a later and more complete census than this block, covering $SO(2m)/U(m)$, the complex Grassmannians and the Kähler family's tie. The unbalanced two-factor sphere products above $\sqrt{3/2}$ are the entry whose absence made the census false, not merely short.
6. **Withdraw *"the highest tops out at $0.837$"*** at [results.md:118](../results.md#L118) and [90-appendix.tex:50](../report/sections/90-appendix.tex#L50), *done at both sites*, to $\sqrt{56/45}$.
7. **Withdraw $\theta=\lambda-\mu+1$** from the report's SRG certificate (D8), which still stands and is the ground on which that sweep is called exhaustive.
8. **Separate the three Kähler-adjacent families by name (D9)**, and correct [L9](../findings/graded-half.md#L225)'s attribution of $\mathbb{CP}^3$ to the $(\mathfrak{su}(m),\mathfrak{so}(m))$ family's $m=3$ member.
9. **Add rows to [conventions.md](../findings/conventions.md)** for *rival*, *critical-point family* and *the two named competitors*, and state the normalisation under which bare $P$ values are quoted (D5).
