# REVIEW r582, Lemma L5, the census of rival critical-point families

Reviewer r582, independent adversarial audit, working from the definitions in [conventions.md](../findings/conventions.md) alone. Target: `Lemma L5, the census of rival critical-point families`, [graded-half.md:41](../findings/graded-half.md#L41).

**Analysis only.** No computation was run for this review. Every number below is either quoted from the record or derived by hand from a closed form, and each hand derivation is checked against a record value it was not fitted to.

## Verdict summary

| # | defect | verdict |
| --- | --- | --- |
| D1 | The block has no proof, and the record's proof pointer is circular | **CONFIRMED** |
| D2 | The provenance note's self-correction is itself false, and its first clause is false too | **CONFIRMED** |
| D3 | The summary sentence "the highest tops out at $0.837$ ... so none is close" is false, refuted three times from inside L5's own list | **REFUTED** (the claim), witnesses below |
| D4 | The six are not six: items 3 and 4 of the list are one family under two names | **CONFIRMED** |
| D5 | "Lose to both named competitors" is false of item 2, which attains one competitor's value exactly | **CONFIRMED** |
| D6 | The list omits families the record holds, one of them named as census material by its own neighbour | **CONFIRMED** |
| D7 | The population is undefined and time-indexed; "rival" and "family" have no definition on the record | **CONFIRMED** |
| D8 | No quantifier over $n$; the constituent checks are dimension-bounded and the bounds are dropped | **CONFIRMED** |
| D9 | $P$ is compared against a $\theta$ threshold with no normalisation stated, across a source with a factor-$2$ convention split | **CONFIRMED** |
| D10 | The label `Lemma` is carried against the record's own index entry "Gate 2: no verdict on the record" | **CONFIRMED** |
|, | Multi-block sphere products: elimination rebuilt as a closed-form theorem, uniform in $n$ | **REPAIRED** |

**Overall: REFUTED as a Lemma, and as a census.** What survives is a true and useful list of five distinct families with their values; what fails is the count, the headline comparison, the completeness, the label, and the proof. The repair proposal, and the statement a downgrade makes owed, are in the last two sections.

## The block, and its true boundaries

The block is three lines: heading [graded-half.md:41](../findings/graded-half.md#L41), an italic provenance note at line 43, one body paragraph at line 45. **The body paragraph is byte-identical to [results.md:320](../results.md#L320)**, checked by `diff` on the two extracted lines, zero difference.

The substance of L5 is therefore spread over four loci, and they say different things:

| locus | what it carries |
| --- | --- |
| [graded-half.md:41](../findings/graded-half.md#L41) | heading, provenance note, body paragraph |
| [results.md:318](../results.md#L318) | heading, the same body paragraph verbatim, and `**Proof:** graded-half.md` |
| [results.md:118](../results.md#L118) | a one-line summary that is **not** in the canonical block and is false, D3 |
| [findings/INDEX-results.md:20](../findings/INDEX-results.md#L20) | the label `Lemma` and the note "**Gate 2: no verdict on the record**" |

## D1, there is no proof, and the pointer is circular. CONFIRMED

[results.md:322](../results.md#L322) reads `**Proof:** [graded-half.md](findings/graded-half.md)`. The thing it points at is the same paragraph, plus a provenance note. **The proof chain terminates in a copy of the statement.**

The body contains no derivation of anything. It cites [Lemma L9](../findings/graded-half.md#L195), [Lemma L4](../results.md#L314), [Lemma L23](../results.md) and a URL, and reports outcomes. Every elimination is stated as an outcome ("falls well short", "top out at", "threatens nothing"), never as an inequality with a hypothesis. Contrast [Lemma L10](../findings/graded-half.md#L440), four hundred lines below in the same file, which supplies a closed form and a monotonicity claim for the same kind of object.

## D2, the provenance note. CONFIRMED, both clauses false

The note reads:

> *Moved here from [results.md](../results.md) on 2026-08-31. **The claim once made here, that results.md held the only copy, is false against the commit before the move**: this file already carried a block for this result.*

Both halves fail against the commit the note names.

- **The move is commit `84cada75`.** Its own message says, in terms: *"results.md is untouched. Its detail entries are deleted only once all 42 have a home in findings/."* Nothing moved. The block was **copied**, and both copies are live today, `diff` of the two body lines returns nothing.
- **The self-correction is false.** At `84cada75^`, `findings/graded-half.md` carried no L5 heading, no "Six further families", and no occurrence of `Fox`, `strongly-regular`, `Deninger`, `census`, `rival`, `0.837` or `0.387`. Its headings run straight from "The graded half: the enumeration and what it actually covers" to "Hermitian pairs, the $\mathbb{CP}^m$ family", which is exactly where the L5 block was later inserted. A repository-wide search at that commit finds L5's material in `findings/problem.md` and nowhere else in [findings/](../findings/).

So the corrected sentence names the wrong file. **The true statement is that [problem.md](../findings/problem.md) items 6, 7 and 8 already carried the substance**, which is a stronger correction than the one recorded, since those items carry the reasoning the block drops.

**This is the same failure the record already knows about.** [LEDGER.md:624](../findings/LEDGER.md#L624) records the mechanical sweep that found the provenance sentence false in seven of thirty-eight blocks. L5's block was corrected by that sweep and the correction landed on the wrong target; the sweep checked whether *a* copy existed elsewhere, not whether it existed in *this* file.

**And the duplication is itself a convention breach.** [conventions.md](../findings/conventions.md) opens with the rule that *"a convention restated in two files is a convention that will disagree with itself"*. Twenty-eight lines above the L5 block, the same file records that it *"carried a byte-identical second copy"* of the Petersen–Stanfield summary and struck it. The L5 block is a byte-identical second copy that the same pass left standing.

## D3, "the highest tops out at $0.837$ ... so none is close". REFUTED

[results.md:118](../results.md#L118), the record's summary of L5:

> Six families eliminated on value, multi-block sphere products, both of Fox's hyper-Kähler subalgebras, the quaternionic-Kähler operators, the strongly-regular-graph solutions, and the simple-isotropy members of the family found here. **The highest tops out at $0.837$ against $\sqrt{3/2}\approx1.225$, so none is close.**

Three witnesses, each **inside the six families that sentence enumerates**, each above $0.837$, and each reached by a route the block does not use.

**Witness 1, Fox's $r=4$ subalgebra $\mathbb B$ sits at exactly $\sqrt{3/2}=1.224745$.** [ATTEMPTS.md:320](../ATTEMPTS.md#L320): *"$\mathbb B$'s idempotent set is $\{0\}\cup$ (single $\mathbb{RP}^2$-orbit through $\mathcal S^4(\alpha)$). Every nontrivial one gives $P=\sqrt{3/8}$ (Fox convention) $=\sqrt{3/2}$ (this repo's other convention)."* Corroborated structurally: [second-order.md:317](../findings/second-order.md#L317) states $\mathcal S^4(\alpha)=$ padded $W_{\mathbb{CP}^2}$.

**Witness 2, the quaternionic-Kähler operator on $\mathbb{HP}^2$ sits at $\sqrt{56/45}=1.115546702$.** Derived here from the record's own closed-form data by a route sharing nothing with the block. [graded-half.md](../findings/graded-half.md) records, for compact Einstein symmetric spaces normalised to Einstein constant $\tfrac12$, the minimum $\lVert W\rVert^2=\tfrac{45}{224}$ at $\mathbb{HP}^2$, and the equivalence $\theta\leftrightarrow\lVert W\rVert$ that its own Theorem uses. Writing $Q(W)=\tfrac12W$ in that normalisation gives $P=\tfrac12\lVert W\rVert^2$ and hence

$$\theta=\frac{P}{\lVert W\rVert^3}=\frac1{2\lVert W\rVert},\qquad\text{so}\qquad \theta_{\mathbb{HP}^2}=\sqrt{\tfrac{224}{180}}=\sqrt{\tfrac{56}{45}}=1.115546702\ldots$$

matching the file's independently computed $1.115546702$ to every printed digit. The same identity reproduces four further record values it was not fitted to, $S^6\times S^6$ at $1.236033081$, $S^5\times S^7$ at $1.228239158$, $S^4\times S^8$ at $1.201561484$, and $\mathbb{CP}^2$ at $\lVert W\rVert^2=\tfrac16\Rightarrow\theta=\sqrt{3/2}$, so the route is sound.

**Witness 3, the seventh family exceeds $0.837$ at every $m$ from $2$ to $30$.** [Lemma L10](../findings/graded-half.md#L440) gives its closed form $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$. The inequality $\theta^2>0.837^2=0.700569$ rearranges to $m^2-30.50m+9.83<0$, whose roots are $0.325$ and $30.17$. So $\mathbb{CP}^3$ is at $\sqrt{10}/3=1.054093$, $\mathbb{CP}^4$ at $\sqrt{35/36}=0.986013$, and the family only falls under $0.837$ past $m=30$. Its infimum is $\sqrt{2/3}=0.8165$, so **no member of it is ever much below $0.837$ either.**

**The sentence is false in both halves.** The census's highest member is $\sqrt{3/2}$, not $0.837$; and "none is close" is contradicted by a member at $91\%$ of the threshold and another at $100\%$ of it. The record already knew this in its own words: [graded-half.md](../findings/graded-half.md) calls $\mathbb{HP}^2$ *"the highest defective graded point on record"* and records that had it been ungraded *"the recorded ceiling would have jumped from $0.900828$ to $1.115547$"*; and [Lemma L9](../findings/graded-half.md#L195) concludes that *"the landscape carries several peaks below the two named ones rather than a single ridge, so eliminating rivals cannot be a stability argument."*

## D4, the six are not six. CONFIRMED

The list, quoted and split:

1. multi-block sphere products (3+ factors)
2. Fox's full $5$-dimensional hyper-Kähler subalgebra
3. its $r\ge8$ extension
4. quaternionic-Kähler operators on $\mathbb{HP}^m$, $m\le4$
5. strongly-regular-graph-derived solutions
6. the simple-isotropy members of [Lemma L4](../results.md#L314)'s family

**Items 3 and 4 are the same critical points.** [ATTEMPTS.md:503](../ATTEMPTS.md#L503) reports the $\mathbb B_r$ branch values as $\pm1.11554670$ at $r=8$ and $\pm0.85294386$ at $r=12$. The record's $\mathbb{HP}^2$ and $\mathbb{HP}^3$ values are $1.115546702$ and $0.852943860$, at $n=8$ and $n=12$; and $\mathbb{HP}^m$ has $n=4m$, so $r=n$ in both rows. Nine printed digits agree in both. **The block itself concedes it**, writing that the $r\ge8$ extension is *"tied to the quaternionic-Kähler family named next"*.

So the census enumerates **five** distinct families, not six, and it reaches six by naming one of them twice. This is the failure [conventions.md](../findings/conventions.md) tables under "A grading is not determined by the point": a family is a description, and two descriptions of one point set are one family.

## D5, "lose to both named competitors" is false of item 2. CONFIRMED

The two named competitors are the balanced sphere product at $\theta_0(n)$ and the $\mathbb{CP}^2$-type competitor at $\sqrt{3/2}$; [Lemma L9](../findings/graded-half.md#L195)'s "the two named ones" fixes the referent, since the block never names them.

Item 2's every nontrivial idempotent gives $\theta=\sqrt{3/2}$ exactly (D3, witness 1). **It attains the competitor's value; it does not lose to it.** The block's own parenthetical says so (*"both collapse onto orbits of already-named competitors"*) which is precisely the reason "lose to" is the wrong verb: a family that collapses onto a competitor's orbit *is* that competitor, and is therefore neither a rival nor a loser.

The block also uses "competitor" in two senses one clause apart: *"both named competitors"* (the two thresholds) and *"already-named competitors"* (the earlier entries of this very list). Same word, two populations, twelve words apart.

## D6, omissions. CONFIRMED

Families and points the record holds that the census does not name:

| omitted | $\theta$ | where the record holds it |
| --- | --- | --- |
| the complex Grassmannians $\mathrm{Gr}_{\mathbb C}(2,2)$, $\mathrm{Gr}_{\mathbb C}(2,3)$ | $0.720082$, $0.596068$ | [Lemma L10](../findings/graded-half.md#L440), same file |
| the second graded point on $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$ | $1.088948$ | [results.md:18](../results.md#L18), [INDEX-values.md:39](../findings/INDEX-values.md#L39) |
| the zero-defect set's non-diagonalizable points, a symmetric family and a symmetry-free one |, | [Conjecture L6](../findings/curvature-invariants.md#L77) |
| the unbalanced two-block sphere products, three-eigenvalue graded critical points | $1.228239$ at $S^5\times S^7$ | [graded-half.md](../findings/graded-half.md), the $n=12$ table |

**The first is the sharpest, because its own block says it belongs here.** [Lemma L10](../findings/graded-half.md#L440) closes: *"Three of these are ungraded, with slack between $0.57$ and $0.96$, so they bear on the critical-point census rather than on the graded enumeration."* L10 files its families into L5's population, and L5 does not carry them. The two blocks sit in one file, four hundred lines apart, and disagree about what the census contains.

The second matters more than its value suggests: at $1.088948$ it is the highest $\{S=0,\Delta>0\}$ point on record and is non-diagonal, i.e. it lives on exactly the side of the problem the programme has left open ([results.md:31](../results.md#L31)).

## D7, the population is undefined, and time-indexed. CONFIRMED

The first sentence: *"Needed to rule out every other critical-point family found so far."*

- **"Rival" has no definition anywhere on the record.** It is not in [conventions.md](../findings/conventions.md), which tables thirty-two entries including every other contested word this block uses.
- **"Critical-point family" has none either.** [conventions.md](../findings/conventions.md) defines "critical point" as $Q(W)=\theta W$ and warns that the weaker bracket form is satisfied by every diagonal Weyl tensor; it says nothing about what collects points into a family. D4 is what that costs.
- **"Both named competitors" names nobody.** The two are fixed only by reading [Lemma L9](../findings/graded-half.md#L195), two hundred lines away in the same file.
- **"Found so far" makes the population a function of the date.** The record has grown since 2026-08-31 by at least the four rows of D6. A statement whose subject is "what has been found" cannot be false at any time and cannot be confirmed at any time, it is a report on a search, and the block says so itself: *"the census is the record of what has been checked and found short."*

That last sentence is the honest description of the block, and it is incompatible with the label above it.

## D8, the quantifier. CONFIRMED

There is none. The enclosing claim ranges over families with no mention of $n$, while every constituent check is bounded, and the bounds are dropped on the way up:

| item | its actual range | as the block reports it |
| --- | --- | --- |
| QK operators | $\mathbb{HP}^m$, $m\le4$ | stated with the bound |
| SRG-derived | *"an exhaustive parameter sweep to $n=200$"* | "every primitive case checked ... falls well short" |
| $\mathbb B_r$, $r\ge8$ | *"at every $r\ge8$ **tested**"* ([ATTEMPTS.md:481](../ATTEMPTS.md#L481)) | bound dropped |
| simple isotropy | two spaces named, $n=8$ and $n=14$ ([Lemma L4](../results.md#L314)) | "top out at $P\le0.837$" |
| multi-block sphere products | none given | "lose to both" |

The simple-isotropy bound is the one that most needs its range. [Lemma L4](../results.md#L314)'s closed form is $\theta=\frac2n\sqrt{rN/(N-r)}$ with $r=\dim\mathfrak h$ and $N=\binom n2$; it reproduces $0.836660$ at $SU(3)$ ($n=8$, $r=8$) and $0.746420$ at $SU(6)/Sp(3)$ ($n=14$, $r=21$), both matching L4's printed values. But **the closed form is unbounded above on its abstract parameter domain**: it diverges as $r\to N$. So $P\le0.837$ is a statement about a *list* of realised $(n,r)$ pairs, and neither the list nor the classification producing it appears in the block or in anything it cites. For the Lie-group members alone the bound is a theorem, $r=n$ gives $\theta=2\sqrt{\frac{n-1}{n(n-3)}}$, decreasing in $n$, so $n=8$ is the maximum at $0.836660$, and that is the one sub-case where "$0.837$" is earned rather than measured.

## D9, the norm. CONFIRMED

[conventions.md](../findings/conventions.md) fixes $\theta=P(W)/\lVert W\rVert^3$. The block reports its values as $P$, *"top out at $P\le0.837$"*, *"$P=0.387$"*, and [results.md:118](../results.md#L118) compares those numbers directly against $\sqrt{3/2}$, which is a $\theta$. **The comparison is only licensed at $\lVert W\rVert=1$, and neither locus says so.**

This is live rather than pedantic, because the block's own sources carry a factor-$2$ split: [ATTEMPTS.md:320](../ATTEMPTS.md#L320) prints the same object as *"$P=\sqrt{3/8}$ (Fox convention) $=\sqrt{3/2}$ (this repo's other convention, per the cross-check factor)"*. L5 draws numbers from Fox-convention material and prints them in the repo convention with no conversion note, the exact class of trap [conventions.md](../findings/conventions.md) tables under "Norms and pairings, where builds have disagreed".

## D10, the label. CONFIRMED

[findings/INDEX-results.md:20](../findings/INDEX-results.md#L20):

> `| **5** | Lemma | **Gate 2: no verdict on the record.** the census of rival critical-point families |`

The record's own index says the Gate has never returned on this result, and the block is labelled `Lemma`, which on this record means proved and Gate-2'd. Combined with D1 (no proof), D7 (no defined population) and D8 (no quantifier), **there is no statement here for a Gate to have passed.**

## What cites it, the census of citations

Grepping the statement rather than the identifier, and discarding line anchors, brief-local labels and script-local labels, **Lemma L5 has seven loci and zero downstream mathematical uses.**

| locus | kind |
| --- | --- |
| [graded-half.md:41](../findings/graded-half.md#L41) | the block |
| [results.md:318](../results.md#L318)/[320](../results.md#L320)/[322](../results.md#L322) | the duplicate block and its proof pointer |
| [results.md:118](../results.md#L118) | the summary, the false one, D3 |
| [results.md:53](../results.md#L53) | a credit line, "Fox, Nienhaus supply the rival families of Lemma L5" |
| [findings/INDEX.md:47](../findings/INDEX.md#L47) | index |
| [findings/INDEX-results.md:20](../findings/INDEX-results.md#L20) | index |
| [REVIEW_r539.md:109](REVIEW_r539.md#L109) | an audit, noting the QK line "is L5's claim, not L9's" |

**No lemma, observation, conjecture or route anywhere takes L5 as a hypothesis.** It is a landscape note that nothing stands on, which is what makes the repair cheap.

**The brief's figure of twenty-eight is itself the artefact it warns against, in a second form.** The warning was about `#L5`-style line anchors; the real inflation is namespace collision. Every other occurrence of the token is a different object: the brief-local `L5` of [r63](REVIEW_r63.md), [r323](REVIEW_r323.md), [r324](REVIEW_r324.md), [r565](REVIEW_r565.md) and [r566](REVIEW_r566.md) is *the Hilbert–Schmidt form*, audited and found to carry no new information; three scripts carry their own sub-lemma `L5`; [REVIEW_r547.md:175](REVIEW_r547.md#L175) is a genuine `#L5` line anchor into a `.tex` file; and [hashimoto-2023 notes.md:5](../references/hashimoto-2023-hilbert-mumford-nilsolitons/notes.md#L5) uses `L5–L11` for a line range of an abstract.

## REPAIRED, the multi-block elimination is a theorem, uniform in $n$

Item 1 is eliminated by a closed form, not by measurement, and the closed form is already in the same file, four sections below the block. Stating it properly removes the item's dependence on any census.

**Setup**, from [graded-half.md](../findings/graded-half.md)'s reducible-symmetric argument. Normalise to Einstein constant $\tfrac12$. For $M=M_1\times\cdots\times M_k$ the curvature operator is block-diagonal on $\Lambda^2$ and zero on the mixed terms, and the universal centre constant $c=\frac1{2(n-1)}$ applied factorwise gives

$$\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+\sum_af(n_a)-\frac n{8(n-1)},\qquad f(m)=\frac m{8(m-1)} .$$

**The step the record does not take.** Write $f(m)=\tfrac18\big(1+\tfrac1{m-1}\big)$. For round factors, $\lVert W_a\rVert^2=0$, and the whole expression collapses:

$$\boxed{\ \lVert W\rVert^2=\frac{k-1}8+\frac18\left(\sum_{a=1}^k\frac1{n_a-1}-\frac1{n-1}\right).\ }$$

Every $n_a-1<n-1$, so each term of the sum exceeds $\frac1{n-1}$ and the bracket is strictly positive for every $k\ge2$. Hence $\lVert W\rVert^2>\frac{k-1}8$, and with $\theta=\frac1{2\lVert W\rVert}$,

> **Theorem (multi-block sphere products).** Let $M=S^{n_1}\times\cdots\times S^{n_k}$ carry round factors of equal Einstein constant, every $n_a\ge2$. Then $\theta<\sqrt{\dfrac2{k-1}}$. In particular every product of **three or more** spheres has $\theta<1$, at every $n$, and so loses strictly to both named competitors for every $n\ge12$, where $\theta_0(n)\ge\sqrt{3/2}=1.224745$.

**Checks against values the derivation was not fitted to.** $S^5\times S^7$: $\tfrac18+\tfrac18(\tfrac14+\tfrac16-\tfrac1{11})=0.1657197$, giving $\theta=1.228239$, against the file's $1.228239158$. $(S^3)^4$ at $n=12$: $\tfrac38+\tfrac18(2-\tfrac1{11})=0.613636$, giving $\theta=0.638285$, against [graded-half.md](../findings/graded-half.md)'s own $(3,3,3,3)$ value $0.638285$. Both exact to the printed digits.

**What this buys.** The census line said "eliminated on value" and left the dimension range open; the theorem is uniform in $n$ and in the number of factors, and it explains the elimination, each extra factor costs $\tfrac18$ of $\lVert W\rVert^2$, and $\theta$ is inverse to $\lVert W\rVert$. The bound is sharp in shape: at $k=2$ it returns $\theta<\sqrt2$, which is $\lim_{n\to\infty}\theta_0(n)$.

## The downgrade, and the statement it makes owed

**A downgrade is not a repair.** L5 as written is a report on a search, so the honest label is **Observation**, verified at the cases named, with each case carrying its own range. But that alone leaves the record without the thing L5 was for: the guarantee that a later cycle does not re-derive an eliminated family as new.

**The statement that becomes owed** is the one the census was standing in for, and it is a real theorem with a real proof obligation:

> **Owed.** For each named structural class, sphere products, Fox's hyper-Kähler subalgebras $\mathbb B_r$, the reducible-isotropy symmetric families ($\mathbb{CP}^m$, Wolf, complex Grassmannian), the strongly-regular-graph solutions, and [Lemma L4](../results.md#L314)'s generated family, a closed form for $\theta$ on the class, together with the bound it satisfies over the class's whole parameter range. Where a class has no closed form, the class is not eliminated and the census must say so.

Four of the six are already discharged or nearly so, which is why this is worth stating rather than deferring: multi-block sphere products by the theorem above; the $\mathbb{CP}^m$ family by [Lemma L10](../findings/graded-half.md#L440)'s $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$, decreasing, peaking at exactly $\sqrt{3/2}$; Fox's $\mathbb B$ by the identification $\mathcal S^4(\alpha)=$ padded $W_{\mathbb{CP}^2}$, which makes it the competitor rather than a rival; and the Lie-group members of L4's family by $2\sqrt{\frac{n-1}{n(n-3)}}$, decreasing, maximal at $n=8$. **The two that are genuinely open are the strongly-regular-graph solutions, eliminated only by a sweep to $n=200$, and the non-Lie-group simple-isotropy members, whose $(n,r)$ list is nowhere on the record.**

## Recommended edits

1. **Relabel to `Observation L5`** and rewrite the first sentence as what it is: a record of which families have been checked, with each range attached.
2. **Strike the false summary at [results.md:118](../results.md#L118)**, "The highest tops out at $0.837$ ... so none is close", and replace it with the true ceiling, $\sqrt{3/2}$ attained by Fox's $\mathbb B$, and the true near-miss, $\mathbb{HP}^2$ at $1.115547$ against $\theta_0(8)=1.145644$.
3. **Merge items 3 and 4** into one family, and say the count is five.
4. **Replace "lose to both named competitors"** with the two facts that are true: two of the five *are* orbits of a named competitor, and three lose to both.
5. **Fix the provenance note** to name [problem.md](../findings/problem.md) as the file that already held the material, and record that the block was copied rather than moved, both copies being live.
6. **Fold in the theorem above** for item 1, marked as a theorem.
7. **Add the omitted rows of D6**, or say in the block that the census's population is the pre-2026-08-31 families and that [Lemma L10](../findings/graded-half.md#L440)'s classes are counted separately.
8. **State $\lVert W\rVert=1$**, or write $\theta$ throughout instead of $P$.
