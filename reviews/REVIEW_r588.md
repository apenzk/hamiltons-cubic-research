# REVIEW_r588, Lemma L117 (Lemma L71's converse)

Reviewer r588, independent adversarial audit. Target: the block headed [Lemma L117, Lemma L71's converse](../findings/bounds.md), at lines 494–497 of that file. Worked from [findings/conventions.md](../findings/conventions.md) and the definitions; the record is treated as unverified.

Analysis-only footing: no computation was run. Every number below is arithmetic done by hand and shown.

## Overall verdict

**The mathematics is CONFIRMED. The block is REPAIRED-as-owed in six places, one of which (the heading), is REFUTED outright.**

The claim is true at every $n\ge4$, it has a four-line proof from material already inside [findings/bounds.md](../findings/bounds.md), and I rebuilt that proof before reading [REVIEW_r324.md](REVIEW_r324.md). What the block does **not** contain is the proof: the heading announces a lemma, the blockquote states it and attributes it, and the block's only paragraph is about a different matter. The heading also names the wrong logical relation, this is not a converse of [Lemma L71](../findings/bounds.md).

## The claim, rebuilt

Write $m=\lvert\lambda_{\min}\rvert$, $M=\lambda_{\max}$, $N=\binom n2=\dim\Lambda^2\mathbb R^n$, and $T_{v\alpha\beta}=c_{v\alpha\beta}^2$ with row mass over **ordered** pairs, per [conventions.md](../findings/conventions.md).

**Step 0, the hypothesis is nonempty and $v$ is pinned.** $D(v)$ is defined at [bounds.md:189](../findings/bounds.md) for a unit $v\in E_{\min}$, and $\operatorname{tr}W=0$ at $W\ne0$ gives $\lambda_{\min}<0<\lambda_{\max}$. On the box $[\lambda_{\min},\lambda_{\max}]^2$ the product $xy$ attains its minimum $\lambda_{\min}\lambda_{\max}$ only at the two corners, since $xy\ge\lambda_{\min}y\ge\lambda_{\min}\lambda_{\max}$ with equality forcing $x=\lambda_{\min}$ and $y=\lambda_{\max}$. So $D(v)=0$ says exactly that $\operatorname{ad}(v)$ carries its whole mass $2(n-2)$ on pairs with one index in $E_{\min}$ and one in $E_{\max}$, [Lemma L70](../findings/bounds.md)'s equality case.

**Step 1, the ratio, which is where first Bianchi and $\mathrm{Ric}=0$ enter.** Relation (B) at row $v$ reads $\sum_{\beta\gamma}\lambda_\beta T_{v\beta\gamma}=-2\lambda_v=2m$ ([bounds.md:235](../findings/bounds.md), and Böhm–Wilking Lemma 2.1's $W\#I=-W$). Total symmetry of $T$ in $\beta,\gamma$ gives $\sum_{\beta\gamma}\lambda_\beta T_{v\beta\gamma}=\tfrac12\sum_{\beta\gamma}(\lambda_\beta+\lambda_\gamma)T_{v\beta\gamma}$, and on the support of Step 0 the bracket is the constant $\lambda_{\min}+\lambda_{\max}$. With (A)'s mass $2(n-2)$,

$$(n-2)(M-m)=2m\quad\Longrightarrow\quad M=\frac{nm}{n-2}.$$

*No even-splitting assumption is needed:* the $\beta\leftrightarrow\gamma$ symmetry does the work that [REVIEW_r324.md](REVIEW_r324.md) states as "split $(n-2)/(n-2)$".

**Step 2, the value.** [Lemma L70](../findings/bounds.md)'s boxed identity at $D(v)=0$ gives $\theta=\lambda_{\min}+(n-2)\lambda_{\max}=-m+nm=(n-1)m$. So clauses (i) and (ii) are the same statement read through the identity, and this step is where $\lVert W\rVert=1$ is spent.

**Step 3, the floor $\theta\ge\theta_0(n)$, from tracelessness alone.** Every eigenvalue satisfies $(\lambda_a+m)(M-\lambda_a)\ge0$, i.e. $\lambda_a^2\le(M-m)\lambda_a+mM$. Summing over all $N$ eigenvalues and using $\operatorname{tr}W=0$, $\sum\lambda_a^2=1$:

$$1\;\le\;mMN\;=\;m^2\cdot\frac n{n-2}\cdot\frac{n(n-1)}2\;=\;\frac{n^2(n-1)}{2(n-2)}\,m^2 ,$$

so $m^2\ge 2(n-2)/(n^2(n-1))$ and $\theta=(n-1)m\ge\sqrt{2(n-1)(n-2)}/n=\theta_0(n)$, exactly. **Equality holds iff every $\lambda_a\in\{\lambda_{\min},\lambda_{\max}\}$**, two eigenvalues, trivial kernel.

**Cross-check by hand at both $n=4$ saturating points.** Two eigenvalues with $M=nm/(n-2)$ and $\operatorname{tr}W=0$ force $\dim E_{\min}=n^2/4$, $\dim E_{\max}=n(n-2)/4$, and then $\lVert W\rVert=1$ gives $m^2=2(n-2)/(n^2(n-1))$, the equality case, $\theta=\theta_0(n)$. At $n=4$ that is $m=1/(2\sqrt3)$, $M=1/\sqrt3$, $\theta=\sqrt3/2=0.866025$, which is $S^2\times S^2$ and $\theta_0(4)$. The other $n=4$ saturating point, $W_{\mathbb{CP}^2}$ with spectrum $(2\varepsilon,-\varepsilon,-\varepsilon,0,0,0)$ and $6\varepsilon^2=1$, has $M=2\varepsilon=4\varepsilon/(4-2)$ as clause (i) requires and $\theta=3\varepsilon=\sqrt{3/2}=1.224745>\theta_0(4)$, strict, and strict for the reason the equality analysis names, its kernel.

**So the inequality is strict at exactly one catalogued place, $W_{\mathbb{CP}^2}$ at $n=4$**, and the block's silence about where strictness lives is the one thing its own remark gestures at.

## Verdicts, per defect

| # | defect | verdict |
| --- | --- | --- |
| D1 | The heading names L117 "Lemma L71's converse" | **REFUTED** |
| D2 | The block asserts the lemma and carries no argument | **CONFIRMED as a defect** |
| D3 | r324's equality clause is dropped in transcription | **CONFIRMED as a defect** |
| D4 | Quantifiers: $v$ unbound, no $n$ range, a vacuous half in the $n\ge5$ remark | **CONFIRMED as a defect** |
| D5 | "proved from first Bianchi and $\mathrm{Ric}=0$" names one of six inputs | **CONFIRMED as a defect** |
| D6 | The pointer [T4](../plan.md) resolves to a file with no such item | **CONFIRMED as a defect** |
| D7 | "the $g_\gamma$ cap" names no result on the record | **CONFIRMED as a defect** |
| D8 | The deduplication the block asserts | **CONFIRMED as correct** |
| D9 | Does L117 inherit the withdrawal in the blockquote above it | **CONFIRMED independent of it** |
| D10 | The mathematics of the three clauses | **CONFIRMED** |

### D1, the heading is REFUTED

[Lemma L71](../findings/bounds.md) reads *saturation $\Rightarrow$ balanced sphere product*. A converse of it would read *balanced sphere product $\Rightarrow$ saturation*. L117 reads *saturation $\Rightarrow$ a spectral ratio, a value and a floor*, **the same hypothesis as L71, with a weaker conclusion**. It is a companion corollary of [Lemma L70](../findings/bounds.md)'s equality case, drawn from relation (B); L71 appears in its proof nowhere.

The label is not [Reviewer 324](REVIEW_r324.md)'s. That report calls the statement *"Theorem (r324). A rigidity theorem, replacing the search"* at its §5.1. `git log -S 'Lemma L117'` puts the heading in commit c14052fc, 2026-09-02, *"docs(bounds): place headings for Lemmas L107-L119"*, thirteen headings placed over prose that already existed, so the words "Lemma L71's converse" are a later editorial gloss on a blockquote that never claimed them. [INDEX-results.md:135](../findings/INDEX-results.md) has copied the gloss.

**Repair.** Rename to what the block proves, *the rigidity theorem at saturation*, or *saturation pins the spectral ratio and forces $\theta\ge\theta_0(n)$*, in [bounds.md](../findings/bounds.md) and in [INDEX-results.md](../findings/INDEX-results.md) together.

### D2, the argument is absent

The block is a heading, a five-sentence blockquote stating the result, and one paragraph. That paragraph is about the deduplication, about what "saturates L70" means as a hypothesis, and about [Reviewer 323](REVIEW_r323.md)'s sharpening, none of it a proof of the three clauses. The proof exists at [REVIEW_r324.md](REVIEW_r324.md) §5.1, and every ingredient of it is already in [bounds.md](../findings/bounds.md): the identity and equality case at [L70](../findings/bounds.md), relation (B) at [bounds.md:235](../findings/bounds.md), $\operatorname{tr}W=0$ and $\lVert W\rVert=1$ from [conventions.md](../findings/conventions.md). **Four lines, as in "The claim, rebuilt" above.** This is the same shape the record has already priced once, at [L7](../findings/bounds.md), where a block carried an ingredient list and no proof and both Gate 2 reviewers rebuilt the inequality cold.

### D3, the equality clause was dropped in transcription

[REVIEW_r324.md](REVIEW_r324.md)'s clause (b) reads *"$\theta\ge\theta_0(n)$, with equality **iff** $W$ has exactly two eigenvalues, in which case $n$ is even and the multiplicities are forced: $\dim E_{\min}=n^2/4$, $\dim E_{\max}=n(n-2)/4$."* The record's block carries the inequality and drops the iff and the multiplicities.

**That is the expensive half.** [LEDGER.md:1275](../findings/LEDGER.md) records $\dim\mathfrak h=n(n-2)/4$ as having "arrived as 'the required' with no derivation", and [REVIEW_r568.md](REVIEW_r568.md) traces the uniqueness step of L71 to exactly this quantity. The dropped clause supplies it from tracelessness, unit norm and clause (i) alone, no Cartan, no mass law, no [Lemma L104](../findings/bounds-relaxations.md). Restoring one sentence to the block discharges a debt the record currently carries in three places.

### D4, the quantifiers

- **$v$ is never bound.** The statement reads "If $D(v)=0$ at a critical unit $W\in\mathcal W_n$" and defines neither $v$ nor its range; the reader must walk back to [L70](../findings/bounds.md) for "$v\in E_{\min}$". It is harmless in substance, $D(v)=\lvert\lambda_{\min}\rvert(\lambda_{\min}+(n-2)\lambda_{\max}-\theta)$ is $v$-free on $E_{\min}$, as the L70 block proves from $W^\#=\theta W-W^2$, and it is a gap in the statement.
- **No range on $n$.** The claim holds at every $n\ge4$ and is vacuous at $n\le3$, where $\dim\mathcal W_n=0$. The block's only $n$-clause is the remark *"For $n\ge5$ Lemma L71 makes this an equality"*, which the heading's own text stops short of. That remark is true and **half of it is vacuous**: L71 also proves that no critical point saturates at odd $n\ge5$, so at odd $n$ the equality is an equality between things that do not exist. The remark's real content is that **L117 has non-vacuous strict content at $n=4$ alone**, where $W_{\mathbb{CP}^2}$ realises it.
- **"unit" is present and is needed**, clause (ii) is homogeneous of degree one on the right and scale-invariant on the left, so it fixes the scale, exactly as [L70](../findings/bounds.md)'s repaired hedge says. Clause (i) is scale-free. Clause (iii) needs the scale twice over. The norm is [conventions.md](../findings/conventions.md)'s $\operatorname{tr}(W^2)=\sum_\alpha\lambda_\alpha^2=1$ on $\Lambda^2$, and my Step 3 runs in it.

### D5, the provenance clause understates the inputs

*"proved from first Bianchi and $\mathrm{Ric}=0$"* is **true of one step and of one clause**. Bianchi and Ricci-flatness supply relation (B), which is what turns saturation into the ratio in Step 1, and [bounds.md:235](../findings/bounds.md) already records that Ricci-flatness alone does not give it. Clause (iii) uses none of it: it needs $\operatorname{tr}W=0$, $\lVert W\rVert=1$ and the eigenvalue count $N=\binom n2$. The full input list is six items, (A), (B), criticality through (C), L70's equality characterisation with $\lambda_{\min}<0<\lambda_{\max}$, tracelessness, unit norm.

The attribution to [Reviewer 324](REVIEW_r324.md) itself **checks out**: the derivation is there, in that reviewer's own words, at §5.1. This block carries no Gate 2 stamp and claims none, and [INDEX-results.md:135](../findings/INDEX-results.md) agrees, *"Gate 2: no verdict on the record"*. File and index are consistent here.

### D6, one stale pointer

The block's *"closes **[T4](../plan.md)** in the diagonal half"* points at [plan.md](../plan.md), whose item ids are I1–I35, R1–R17 and T9. **There is no T4.** The identifier survives only historically, at [LEDGER.md:41](../findings/LEDGER.md). Every other pointer in the block resolves: [REVIEW_r324.md](REVIEW_r324.md), [REVIEW_r323.md](REVIEW_r323.md), [ELIM-bounds.md](ELIM-bounds.md) twice, [graded-half.md](graded-half.md) for L69. The block's two references to L70 and L71 are bare text where the rest of the file anchors them.

Pointers **at** L117 all resolve: [INDEX.md:42](../findings/INDEX.md), [INDEX-results.md:135](../findings/INDEX-results.md), [LEDGER.md:1275](../findings/LEDGER.md).

### D7, an undefined object in the deduplication

The block deduplicates against *"the $g_\gamma$ cap"*. $g_\gamma=\lVert[\operatorname{ad}(v_\gamma),W]\rVert^2$ is defined at [bounds.md:64](../findings/bounds.md) and [target.md:329](../findings/target.md), and the record's identities for it are $\sum_\gamma g_\gamma=4(n-1)$ and $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta$. **A "cap" on $g_\gamma$ is not a numbered result anywhere.** The object the sentence means is $g_v\le2(n-2)(\lambda_{\max}-\lambda_{\min})^2$, obtainable in one line from (A), and it should be named where it is used.

Also still undefined at the point of use in this block: $\Pi$-saturation, which under [conventions.md](../findings/conventions.md)'s four senses of $\Pi$ has to be read as equality in [Lemma L107](../findings/bounds.md).

### D8, the deduplication is CONFIRMED, and its arithmetic checks

Two claims are made. Both hold.

**The equality cases coincide.** $g_v=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{v\alpha\beta}\le(\lambda_{\max}-\lambda_{\min})^2\cdot2(n-2)$, with equality iff $T_{v\alpha\beta}$ sits on pairs of maximal spread. [Lemma L70](../findings/bounds.md)'s equality puts it on pairs of minimal product. Over any finite set of reals with a negative and a positive member, both extremisers are the pair $(\min,\max)$, so the two conditions are the same condition, and **they stay the same condition under the excluded-index sharpening**, since deleting the row index from the available spectrum moves both extremisers together. The [L109](../findings/bounds-relaxations.md)-style sharpening therefore cannot separate them either.

**The value checks by hand.** At the balanced product, $\dim E_{\min}=n^2/4$ at $-m$ and $\dim E_{\max}=n(n-2)/4$ at $M=nm/(n-2)$ give $\operatorname{tr}W=0$ identically and $\lVert W\rVert^2=\tfrac{n^2m^2}{4}\cdot\tfrac{2n-2}{n-2}=1$, so $m^2=\tfrac{2(n-2)}{n^2(n-1)}$. Then $M+m=\tfrac{(2n-2)m}{n-2}$ and

$$2(n-2)(M+m)^2=\frac{8(n-1)^2m^2}{n-2}=\frac{8(n-1)^2}{n-2}\cdot\frac{2(n-2)}{n^2(n-1)}=\frac{16(n-1)}{n^2},$$

which is the $g_v$ that [L70](../findings/bounds.md)'s block records at the balanced products. The block's display is right as written.

**The consequence stands**: the two may not be cited as two pieces of evidence. Neither does the [L70](../findings/bounds.md) dimension theorem ($\dim E_{\min}\ge n/2$, $\dim E_{\max}\ge(n-2)/2$) disturb this, it is a statement about the saturating set, while the deduplication is about two ways of writing one equality condition.

### D9, the withdrawal above is NOT inherited

The blockquote immediately above the heading withdraws *"This does NOT independently confirm Reviewer 324's ratio, and the claim that it did is withdrawn"*, on the ground that mass counting gives only $\dim\mathfrak m\le2\dim\mathfrak h$ and the closed form assumes the ratio.

**What is withdrawn is a corroboration, not the ratio.** L117 *is* the ratio, proved by a different route, relation (B) against L70's support condition, which uses no mass law and no dimension count. So the withdrawal leaves L117 standing and **raises its load**, since it removes the second witness the record thought it had. My Step 1 is a third derivation, sharing with the mass law only the constant $2(n-2)$; the mass law's own error, mixing ordered and unordered row mass, cannot reach it, because Step 1 uses the ordered convention on both sides of one equation and nowhere converts between them.

Two related facts, both checked:

- **Nothing L117 consumes from [L71](../findings/bounds.md) moved.** L117 consumes L71 nowhere. The three things that moved in L71 today, the refuted triality sentence, the now-derived $\dim\mathfrak h=n(n-2)/4$, the ideal argument's first independent check, are all downstream of the same hypothesis, not inputs to this one. There is no circularity in [REVIEW_r568.md](REVIEW_r568.md)'s use of L117 inside L71's uniqueness step, and I confirm that independently: the proof above never mentions $\mathfrak g'$, ideals, or simplicity.
- **[Reviewer 323](REVIEW_r323.md)'s sharpening, as the block quotes it, is CONFIRMED and is one line.** Given the ratio $M=nm/(n-2)$, $\lambda_{\min}+(n-2)\lambda_{\max}=-m+nm=(n-1)m$, so *L70-saturation* and *$\Pi$-saturation* are literally the same scalar equation; conversely the two together give $D(v)=0$. The equivalence is algebra on Step 1's output.

### D10, the three clauses are CONFIRMED

Clause (i) at Step 1, clause (ii) at Step 2, clause (iii) at Step 3, with the equality analysis and both $n=4$ points checked by hand above. The closing sentence *"It also settles the search for saturating points below $\theta_0$ with no search at all"* follows from clause (iii) and is correct.

## What cites it

Counting in [findings/](../findings/), [results.md](../results.md) and [report/](../report/) only, discounting the heading itself:

| site | what it is |
| --- | --- |
| [INDEX.md:42](../findings/INDEX.md) | the file index, listing L117 among bounds.md's results |
| [INDEX-results.md:135](../findings/INDEX-results.md) | the numbered index row, carrying "Gate 2: no verdict on the record" |
| [LEDGER.md:1275](../findings/LEDGER.md) | names it "the unaudited L117", as the step [r568](REVIEW_r568.md) routes around |
| [results.md:568](../results.md) | states the converse verbatim inside L71's canonical statement, **without naming L117** |
| [report/](../report/) | nothing |

**The genuine figure is one.** Three of the five are bookkeeping; the fourth, [LEDGER.md:1275](../findings/LEDGER.md), is a mention of its unaudited status rather than a use. **No result on the record takes L117 as a step**, and every use of it is inside its hypotheses, there being no use.

[results.md:568](../results.md) is the one place that matters and it is **unnumbered**: the canonical statement of L71 ends with *"The converse holds: if $D(v)=0$ at a critical unit $W$ then $\lambda_{\max}=n\lvert\lambda_{\min}\rvert/(n-2)$ and $\theta=(n-1)\lvert\lambda_{\min}\rvert\ge\theta_0(n)$, with equality for $n\ge5$"* and never says L117. It inherits D3 and D4, the equality clause is missing there too, and "with equality for $n\ge5$" is the vacuous-at-odd-$n$ remark again. A reader looking for L117 from [INDEX-results.md](../findings/INDEX-results.md) reaches [bounds.md](../findings/bounds.md); a reader of [results.md](../results.md) meets the statement with no number attached.

## Repairs owed, in order

1. **Rename the heading** away from "Lemma L71's converse", in [bounds.md](../findings/bounds.md) and [INDEX-results.md](../findings/INDEX-results.md) together (D1).
2. **Put the four-line proof in the block** (Steps 1 to 3 above), naming (A), (B), L70's equality case, tracelessness and $\lVert W\rVert=1$ (D2, D5).
3. **Restore r324's equality clause**: equality iff exactly two eigenvalues, $n$ even, $\dim E_{\min}=n^2/4$, $\dim E_{\max}=n(n-2)/4$, and cross-reference it from [LEDGER.md:1275](../findings/LEDGER.md), where the record still calls that quantity underived (D3).
4. **Bind $v\in E_{\min}$ and state $n\ge4$** in the statement; replace the $n\ge5$ remark with the fact it is standing in for, the inequality is strict at $W_{\mathbb{CP}^2}$, $n=4$, and vacuous at odd $n\ge5$ (D4).
5. **Fix the [T4](../plan.md) pointer** (D6) and **name the $g_\gamma$ cap** where it is used (D7).
6. **Number the [results.md:568](../results.md) copy** as L117 and carry repairs 3 and 4 into it.
