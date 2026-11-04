# Review r587, Lemma L117 (Lemma L71's converse)

Reviewer r587, independent adversarial audit. Target: Lemma L117 at [findings/bounds.md](../findings/bounds.md), lines 494–498. Working from the definitions alone; the record is not assumed correct. The other reviewer on this brief was not read.

Standing rule for this audit: analysis only. No sweep, census, optimisation or falsifier hunt was run. Every number below is a screen (seconds of arithmetic on spectra I constructed for the purpose from the closed forms), reported as a screen and never as evidence for a positive claim. The positive claims are the derivations.

## Verdict table

| item | verdict |
| --- | --- |
| the three conclusions, the ratio, $\theta=(n-1)\lvert\lambda_{\min}\rvert$, $\theta\ge\theta_0(n)$ | **CONFIRMED.** Rebuilt in §2 from the row relations (A) and (B), $\mathop{\mathrm{tr}}W=0$ and $\lVert W\rVert=1$. This is the first independent confirmation on the record: the block's only authority is [r324](REVIEW_r324.md), which is where the claim was authored |
| **D1** the heading, "Lemma L71's converse" | **REFUTED.** L71 and L117 carry the *same* hypothesis $D(v)=0$ in the *same* direction. L117 is an input to L71, not its converse |
| **D2** the argument, as a thing present in the block | **REFUTED AS A RECORD ENTRY.** The block asserts a proof and contains none. §2 supplies one in eight lines |
| **D3** "proved from first Bianchi and $\mathrm{Ric}=0$" | **REFUTED AS STATED.** That names one of five inputs. §3 |
| **D4** the dropped equality clause | **CONFIRMED as a defect.** [r324](REVIEW_r324.md) proved equality **iff** two eigenvalues, with $\dim E_{\min}=n^2/4$, $\dim E_{\max}=n(n-2)/4$ and $n$ even. The block records none of it, and that clause is exactly what [r568](REVIEW_r568.md) found [L71](../findings/bounds.md) asserting without derivation. §4 |
| **D5** the closing sentence | **REFUTED.** Unquantified, and false at $n=4$ by the block's own source reviewer's witness. §5 |
| **D6** "which is what [Lemma L69](../findings/graded-half.md) needed one for" | **REFUTED.** Two errors in one clause. §5 |
| **D7** "the $g_\gamma$ cap" | **CONFIRMED as a defect**, it is [Lemma L109](../findings/bounds-relaxations.md), named with no number and no link. §6 |
| **D8** the deduplication | **CONFIRMED, and REPAIRED.** True, and provable in two lines at every $D(v)=0$ point rather than checked by hand at four. §6 |
| **D9** does L117 inherit the withdrawal above it | **Independent, it does not.** §7 |
| **D10** the ordered/unordered convention | **CLEAN.** The derivation is in ordered pairs at every step. §7 |
| **D11** the pointer [T4](../plan.md) | **CONFIRMED as a defect**, dangling, and the last of its kind in [findings/](../findings/). §8 |
| **D12** provenance and Gate 2 | **The block carries neither.** The heading is post hoc. File and index agree. §8 |
| **D13** what cites it | **One** genuine citation, and it calls L117 unaudited. The real dependency is uncited. §8 |

**Overall: REPAIRED.** The mathematics is correct and now independently confirmed; the block that carries it is defective in seven named ways, and the repairs are written out below.

## 1. What the block is, with its true boundaries

Lines 494–498 of [findings/bounds.md](../findings/bounds.md), running to end of file: a heading, one blockquote carrying the statement, and one paragraph. Immediately above sit two blockquotes that belong to the mass-law section rather than to L117, one withdrawing a display for mixing ordered against unordered row-mass conventions, one withdrawing the claim that mass counting independently confirmed [r324](REVIEW_r324.md)'s ratio.

**What the block leans on that is still undefined in it.** The symbol $D(v)$ (defined 300 lines above, inside [Lemma L70](../findings/bounds.md)); the row relations (A) and (B) (defined 250 lines above); "the $g_\gamma$ cap", which is [Lemma L109](../findings/bounds-relaxations.md) and is named by neither number nor link; and $\theta_0(n)$, which [conventions.md](../findings/conventions.md) does carry. The block also writes $g_\gamma$ and $g_v$ for one object inside one sentence.

## 2. The rebuild, all three conclusions, from the definitions

Fix a critical unit $W\in\mathcal W_n$: $Q(W)=\theta W$, $\lVert W\rVert=1$, so $\sum_a\lambda_a^2=1$ over the $N=\binom n2$ eigenvalues of $W$ on $\Lambda^2$, and $\mathop{\mathrm{tr}}W=0$. Structure constants $c_{abc}=\langle[v_a,v_b],v_c\rangle$ in an eigenbasis are totally antisymmetric, so $T_{abc}=c_{abc}^2$ is totally symmetric and hollow. The record's per-index relations, at any index $k$, over **ordered** pairs:

$$\text{(A)}\ \sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2),\qquad \text{(B)}\ \sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k .$$

**Step 0, the hypothesis, unpacked.** $\mathop{\mathrm{tr}}W=0$ at $W\ne0$ gives $\lambda_{\min}<0<\lambda_{\max}$ strictly. Write $m=\lvert\lambda_{\min}\rvert$, $h=\lambda_{\max}$. With $k$ an index of $E_{\min}$, $D(v_k)=\tfrac12\sum_{ab}(\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max})T_{kab}$, and $\lambda_a\lambda_b\ge\lambda_{\min}\lambda_{\max}$ termwise, so $D(v_k)=0$ forces $T_{kab}=0$ unless $\lambda_a\lambda_b=\lambda_{\min}\lambda_{\max}$.

**Step 1, the support is exactly $E_{\min}\times E_{\max}$, and this is strict.** $xy$ is bilinear on $[\lambda_{\min},\lambda_{\max}]^2$, so for fixed $x$ it is affine in $y$ and its minimum over $y$ sits at an endpoint, strictly unless $x=0$; and $x=0$ gives $xy=0>\lambda_{\min}\lambda_{\max}$. So $\lambda_a\lambda_b=\lambda_{\min}\lambda_{\max}$ forces $\{\lambda_a,\lambda_b\}=\{\lambda_{\min},\lambda_{\max}\}$. *This is where the strict sign separation of step 0 is spent.*

**Step 2, the split, from the symmetry of $T$ rather than from an assumption.** $T_{kab}=T_{kba}$, so the ordered mass on $(E_{\min},E_{\max})$ equals that on $(E_{\max},E_{\min})$. Call each $P$. Relation (A) gives $2P=2(n-2)$, so $P=n-2$.

**Step 3, the ratio, from (B).** The first moment of the row is $P\lambda_{\max}+P\lambda_{\min}=(n-2)(\lambda_{\min}+\lambda_{\max})$, and (B) at $k$ equates it to $-2\lambda_{\min}$:

$$(n-2)(\lambda_{\min}+\lambda_{\max})=-2\lambda_{\min}\quad\Longrightarrow\quad (n-2)\lambda_{\max}=-n\lambda_{\min}\quad\Longrightarrow\quad \lambda_{\max}=\frac{n\lvert\lambda_{\min}\rvert}{n-2}.$$

**Step 4, $\theta$.** $D(v)=0$ is $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$ by [Lemma L70](../findings/bounds.md)'s identity, and step 3 turns that into $\theta=-m+nm=(n-1)m$. In particular $\theta>0$, so **no critical point with $\theta\le0$ can saturate**, a clause the block drops and which is worth having, since $Q$ is quadratic and every critical point has a partner at $-\theta$.

**Step 5, $\theta\ge\theta_0(n)$, from the norm and nothing else.** Every eigenvalue lies in $[-m,h]$, so $(\lambda_a+m)(h-\lambda_a)\ge0$, i.e. $\lambda_a^2\le(h-m)\lambda_a+mh$. Summing over all $N$ eigenvalues and using $\mathop{\mathrm{tr}}W=0$ and $\sum\lambda_a^2=1$,

$$1\;\le\;N\,mh\;=\;\frac{n(n-1)}2\cdot\frac{n\,m^2}{n-2}\quad\Longrightarrow\quad m^2\ \ge\ \frac{2(n-2)}{n^2(n-1)},$$

and therefore $\theta^2=(n-1)^2m^2\ge\dfrac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2$, with $\theta>0$ from step 4. $\square$

**Step 6, the equality case, which the block drops.** Equality in step 5 needs $(\lambda_a+m)(h-\lambda_a)=0$ for every $a$, i.e. $\lambda_a\in\{-m,h\}$, exactly two eigenvalues, $\mathfrak r=0$. Then $\mathop{\mathrm{tr}}W=0$ reads $pm=qh$ with $p+q=N$, and with $h/m=n/(n-2)$ this gives $q\cdot\frac{2n-2}{n-2}=\frac{n(n-1)}2$, so

$$\dim E_{\max}=\frac{n(n-2)}4,\qquad \dim E_{\min}=N-\frac{n(n-2)}4=\frac{n^2}4,$$

and integrality forces $n$ even. **No Lie theory, no classification, no Cartan.**

*Screen.* Building the spectrum from these closed forms alone at $n=4,6,8,10,12$ returns $\mathop{\mathrm{tr}}W=0$ and $\sum\lambda^2=1$ to machine zero, $\theta_0(n)=0.866025,1.054093,1.145644,1.200000,1.236033$, and $mh=1/N$ exactly at every one, the equality case of step 5, as predicted. At $n=4$ the ratio applied to $W_{\mathbb{CP}^2}$'s $\theta=\sqrt{3/2}$ returns $m=0.408248$, $h=0.816497$, multiplicities $(2,1)$ and a three-dimensional kernel, again with $\mathop{\mathrm{tr}}W=0$ and $\sum\lambda^2=1$, and $mh=1/3>1/6=1/N$, the strict case. The negated critical points give saturation defect $\lvert\theta\rvert$ in closed form: $1.224745$ at $-W_{\mathbb{CP}^2}$ and $0.866025$ at $-(S^2\times S^2)$, reproducing the two figures the [L71](../findings/bounds.md) material records to nine places.

## 3. D3, what the proof actually consumes

"Proved from first Bianchi and $\mathrm{Ric}=0$" names one of five inputs, and not the one that has cost this record a cycle.

| step | input |
| --- | --- |
| $T$ totally symmetric and hollow | ad-invariance of the inner product, [conventions.md](../findings/conventions.md) |
| step 2, the mass $2(n-2)$ | relation (A), the Killing marginal, a fact about $\mathfrak{so}(n)$ and its normalisation |
| step 3, the first moment | relation (B), **this, and only this, is first Bianchi and $\mathrm{Ric}=0$** |
| steps 0–1, the strict sign separation | $\mathop{\mathrm{tr}}W=0$ on $\mathcal W_n$ at $W\ne0$ |
| step 5 | $\lVert W\rVert=1$ **and** $N=\binom n2$ |

The last row is the live one. [Lemma L70](../findings/bounds.md)'s audit found unit norm missing from its own hypothesis list and recorded that [r323](REVIEW_r323.md) and [r324](REVIEW_r324.md) both propagated the omission. L117's *statement* is clean here ("at a critical unit" carries it) but its *provenance sentence* is not, and a reader repairing the provenance from that sentence would drop the hypothesis a second time. The dimension $N$ is not named anywhere in the block at all, and $\theta\ge\theta_0(n)$ is false without it.

**Repair.** Replace "proved from first Bianchi and $\mathrm{Ric}=0$" with "proved from the row relations (A) and (B) together with $\mathop{\mathrm{tr}}W=0$, $\lVert W\rVert=1$ and $\dim\Lambda^2=\binom n2$; $\mathrm{Ric}=0$ and first Bianchi enter through (B) alone".

## 4. D1 and D4, the label and the missing clause

**D1. "Lemma L71's converse" is a misnomer.** [Lemma L71](../findings/bounds.md) reads: $D(v)=0$ at a critical point, $n\ge5$ $\Rightarrow$ balanced sphere product, hence $\theta=\theta_0(n)$. L117 reads: $D(v)=0$ at a critical unit $\Rightarrow$ ratio, $\theta=(n-1)\lvert\lambda_{\min}\rvert$, $\theta\ge\theta_0(n)$. **Same hypothesis, same direction.** A converse would run from $\theta=\theta_0(n)$, or from the balanced product, back to saturation. Worse, the dependency runs the other way from what the label suggests: [r568](REVIEW_r568.md) established that L71's uniqueness step consumes L117's ratio, so L117 is an **input** to L71. There is no circularity (§2 uses nothing from L71) but the name inverts the dependency graph.

**Repair.** Retitle: "Lemma L117, saturation pins the spectral ratio: $D(v)=0\Rightarrow\lambda_{\max}/\lvert\lambda_{\min}\rvert=n/(n-2)$, $\theta=(n-1)\lvert\lambda_{\min}\rvert\ge\theta_0(n)$".

**D4. The block records a truncation of the theorem it cites.** [r324](REVIEW_r324.md) §5 states $\theta\ge\theta_0(n)$ **with equality iff $W$ has exactly two eigenvalues, in which case $n$ is even and $\dim E_{\min}=n^2/4$, $\dim E_{\max}=n(n-2)/4$**. The block keeps the inequality and drops the clause. That clause is §2's step 6, it costs three lines from $\mathop{\mathrm{tr}}W=0$ and $\lVert W\rVert=1$, and **it is precisely the statement [r568](REVIEW_r568.md) found L71 asserting as "the required $\dim\mathfrak h$" with no derivation and no citation.** The record has been carrying, unnumbered and undeclared, the derivation of a quantity it separately records as underived, because L117's own block threw it away.

**Repair.** Restore the equality clause to the statement. Then [L71](../findings/bounds.md)'s $\dim\mathfrak h=n(n-2)/4$ and its odd-$n$ exclusion both cite L117 instead of asserting, and the inline re-derivation twenty-four lines above L117's heading ("Relations (A) and (B) at a row $v\in\mathfrak m$, with $T$'s mass splitting evenly across the support") becomes a citation. That paragraph's phrase "$T$'s mass splitting evenly across the support" is a hedge standing where §2 step 2 has a proof: the split is *forced* by the total symmetry of $T$, and is not an assumption about how mass distributes.

## 5. D5 and D6, the closing sentence, clause by clause

> "**So the saturating critical points are the balanced sphere products, and that needs no two-eigenvalue hypothesis**, which is what [Lemma L69](../findings/graded-half.md) needed one for."

**D5 is REFUTED, with a witness.** The sentence carries no quantifier on $n$, and at $n=4$ it is false: $W_{\mathbb{CP}^2}$ is a critical Weyl tensor that saturates [Lemma L70](../findings/bounds.md), has three eigenvalues, and is not a sphere product. This is not a witness I had to hunt for, it is the block's **own source reviewer's** verdict L3 in [r324](REVIEW_r324.md), and the [L71](../findings/bounds.md) material forty lines above states "$n=4$ is the sole exception and it is structural". §2's step 5 explains why the exception is possible rather than merely recording it: $\theta_0(4)=0.866025<\sqrt{3/2}$, so $n=4$ leaves room above $\theta_0$, and the equality clause then permits a third eigenvalue. **The block contradicts itself inside four lines**, its second sentence says "For $n\ge5$", its last says nothing.

**D6 is REFUTED, twice over.** [Lemma L69](../findings/graded-half.md) hypothesises an **equivariant graded** critical point with $\theta\ge\sqrt{3/2}$ at $n\ge12$; a two-eigenvalue hypothesis appears nowhere in it. And its conclusion is $S^p\times S^q$ with $p,q\ge5$, **explicitly permitting unbalanced splits**, since the same file uses L69 to place both $S^6\times S^6$ and $S^5\times S^7$ in the $(6,6)$ slice at $n=12$. So the clause misstates both L69's hypothesis and its conclusion. The lemma that carries a two-eigenvalue hypothesis, and that the surrounding [L70](../findings/bounds.md)/[L71](../findings/bounds.md) material repeatedly names, is **L23**.

**Repair.** "So for $n\ge5$ the saturating critical points are the balanced sphere products with no two-eigenvalue hypothesis (which is what Lemma L23's family assumes) while $n=4$ carries $W_{\mathbb{CP}^2}$ as a saturating critical point outside the family, permitted by the equality clause above."

## 6. D7 and D8, the deduplication

**D7.** "The $g_\gamma$ cap" is [Lemma L109](../findings/bounds-relaxations.md), $g_\gamma\le2(n-2)(\lambda_{\max}-\lambda_{\min})^2$. The block names it by neither number nor link, and switches to $g_v$ mid-sentence for the same object.

**D8 is CONFIRMED, and the warrant is repaired.** The block's evidence is a value check at the balanced products, "checked by hand". A value coincidence at one family cannot establish an identity of *equality cases*. Two lines do:

$$g_v=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{v\alpha\beta}\;\le\;(\lambda_{\max}-\lambda_{\min})^2\sum_{\alpha\beta}T_{v\alpha\beta}\;=\;2(n-2)(\lambda_{\max}-\lambda_{\min})^2,$$

by (A), with equality iff the mass sits on pairs realising $\lvert\lambda_\alpha-\lambda_\beta\rvert=\lambda_{\max}-\lambda_{\min}$, which by the corner argument of §2 step 1 is exactly $E_{\min}\times E_{\max}$, which is exactly [Lemma L70](../findings/bounds.md)'s equality condition. **So the two equality cases coincide at every $D(v)=0$ point and not only at the balanced products**, and the block's conclusion (that the record may not cite them as two pieces of evidence), stands on a proof rather than on four numbers.

*Two scope points the block should carry.* First, the two *inequalities* are genuinely different, $4\lambda_a\lambda_b=(\lambda_a+\lambda_b)^2-(\lambda_a-\lambda_b)^2$, so the substitutions differ by the $(\lambda_a+\lambda_b)^2$ term, and only the equality **cases** deduplicate. Second, [LEDGER.md](../findings/LEDGER.md) records an unapplied excluded-index sharpening of L109, $g_\gamma\le2(n-2)(\sigma_\gamma-\ell_\gamma)^2$ over indices $\ne\gamma$. That sharpening is **void at $v\in E_{\min}$ at any saturating point**, since [L70](../findings/bounds.md)'s dimension theorem gives $\dim E_{\min}\ge n/2\ge2$ and $\dim E_{\max}\ge(n-2)/2\ge1$, so both extremes survive the deletion of the row index, the same multiplicity condition that voids L70's own sharpening. **The deduplication therefore survives the sharpening**, and the block should say so rather than leave a reader to wonder.

*A consistency check, from a different row.* [Lemma L107](../findings/bounds.md) gives $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ at every critical point. Under $D(v)=0$, [L70](../findings/bounds.md) gives $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$, and the two together force $(n-2)\lambda_{\max}\le n\lvert\lambda_{\min}\rvert$, **half of §2's ratio, read off the $\lambda_{\max}$ row instead of the $\lambda_{\min}$ row.** Not fully independent, since L107 is derived from the same calculus, but it is a live cross-check the block does not make, and it shows L117's second conclusion is the equality case of L107.

## 7. D9 and D10, the two hazards the brief points at, both clean

**D9, the withdrawal above is not inherited.** The blockquote immediately above L117 withdraws the claim that *mass counting* independently confirmed [r324](REVIEW_r324.md)'s ratio, on the ground that the closed form $\dim\mathfrak h(n-4)$ **assumes** the ratio. That withdraws a would-be *second* derivation, not the ratio and not L117. §2 derives the ratio from (A) and (B) at one row, touching no mass law and no dimension count, so **L117 is independent of the withdrawal.** Two things follow. The record's remaining second route, [r327](REVIEW_r327.md)'s, runs through L23 plus Cartan and therefore needs $\mathfrak r=0$, so it **fails at $n=4$** where L117 holds; §2's route holds at every $n\ge4$ and is the only one that covers $W_{\mathbb{CP}^2}$. And the adjacency is a live confusion hazard: a withdrawal of "r324's ratio was confirmed" sits four lines above a lemma whose content is r324's ratio, with nothing separating them.

**D10, the convention is clean.** Every step of §2 is in **ordered** pairs, which is [conventions.md](../findings/conventions.md)'s default: (A)'s $2(n-2)$, (B)'s $-2\lambda_k$, $D$'s explicit $\tfrac12\sum_{a,b}$, and the even split of step 2. The unordered reading is not merely different, it is **incoherent** for (B): $\sum_{\beta<\gamma}\lambda_\beta T_{k\beta\gamma}$ is not well defined without a rule picking which index of the pair is weighted, and the symmetric repair $\sum_{\beta<\gamma}(\lambda_\beta+\lambda_\gamma)T$ is the ordered sum again. So the hazard that withdrew the neighbouring display cannot reach L117, and the block would be improved by one clause saying which convention it runs in. On [L70](../findings/bounds.md)'s $\lVert W\rVert=1$: §2 spends it in step 5 and nowhere else, and the block's "critical unit" supplies it.

## 8. D11, D12, D13, the block as a record entry

**D11, a dangling pointer.** The block links "closes **[T4](../plan.md)** in the diagonal half". `T4` no longer occurs anywhere in [plan.md](../plan.md); it left at commit `8b116de5`. The file resolves, the label does not, so a reader following the link lands nowhere. This is the **only** remaining `[T4](../plan.md)` in [findings/](../findings/). Nothing anywhere in the repository points *at* L117 by anchor: `#lemma-l117` has no occurrence, so the heading placed to make the id citable is cited by no one.

**D12, provenance and Gate 2.** The block carries **no** provenance line and **no** Gate 2 line, so there is no stamp to check against `git`. What `git` does show: the heading was placed by commit `c14052fc`, *"docs(bounds): place headings for Lemmas L107-L119"*, over prose that already existed from `55ab2c3c`, thirteen results numbered after the fact, the same shape [r465](REVIEW_r465.md) found at L102. So L117 was never posed as a result; it was a paragraph that acquired a number. [INDEX-results.md](../findings/INDEX-results.md) row 117 reads "Gate 2: no verdict on the record", which is **correct** and agrees with the file, unlike the L102 case, where the two disagreed. The block's sole authority is [r324](REVIEW_r324.md), which is the reviewer who authored the claim. §2 is the first independent confirmation.

**D13, what cites it, and the dependency that does not.** Counting in [findings/](../findings/), [results.md](../results.md) and [report/](../report/), discounting anchors and index rows: **one** genuine citation, [findings/LEDGER.md](../findings/LEDGER.md) line 1275, and it cites L117 only to call it "the unaudited L117". Zero in [results.md](../results.md); zero in [report/](../report/). The two remaining hits are index rows, in [findings/INDEX.md](../findings/INDEX.md) and [findings/INDEX-results.md](../findings/INDEX-results.md), and both resolve.

**The figure understates the truth in the one way that matters.** L117's ratio *is* used, by [L71](../findings/bounds.md)'s uniqueness step, as [r568](REVIEW_r568.md) established. But [bounds.md](../findings/bounds.md) re-derives it inline twenty-four lines above L117's own heading rather than citing it. So the record **duplicates** L117 instead of depending on it, the index sees a result nothing uses, and an audit of L71 cannot see that its pivotal quantity has a home. Fixing D4 and replacing that inline paragraph with a citation collapses the duplication and makes the dependency visible.

## 9. On the brief's own premises

Two of the brief's factual premises were checked and one does not hold, which is recorded here because a reviewer is meant to work from the definitions rather than from the brief.

- **"[conventions.md](../findings/conventions.md)'s own $\mathcal A$ and $T$ differ by a sign that put a wrong eigenvalue into [L131](../findings/isotropy-cap.md)"**, **does not check out.** [conventions.md](../findings/conventions.md) contains no $\mathcal A$ at all. The live hazard at [L131](../findings/isotropy-cap.md) is a **factor of two, not a sign**: [isotropy-cap.md](../findings/isotropy-cap.md) line 223 traces the $2$ in $\mathcal A=-2(\,\cdot\,\#\,I)$ to the half-trace against plain Frobenius pairing, which [conventions.md](../findings/conventions.md) does table, and records that [r471](REVIEW_r471.md)'s repair was never applied. A sign hazard does live in [conventions.md](../findings/conventions.md) (the $iklj$ against $ikjl$ index order for $\mathring W$) but it reaches neither $\mathcal A$ nor L117.
- **"The heading's own text is cut at 'For $n$…'"**, recovered: the block reads "**For $n\ge5$ Lemma L71 makes this an equality**, so the inequality is never strict there." **True as far as it goes**, and vacuous at odd $n\ge5$ where nothing saturates. But it is the sentence that makes L117 look superseded, when in fact L117 feeds L71 (§4), and it sits four lines above a closing sentence that drops the very quantifier it establishes (§5).

## 10. Repairs, in priority order

1. **Restore the equality clause** (§4, D4), it is three lines and it discharges [L71](../findings/bounds.md)'s undeclared $\dim\mathfrak h=n(n-2)/4$ and its odd-$n$ exclusion.
2. **Quantify the closing sentence at $n\ge5$ and fix the L69 clause to L23** (§5, D5/D6), one sentence is currently false at $n=4$ by the block's own source's witness.
3. **Put the eight-line proof in the block** (§2, D2) and correct the provenance sentence (§3, D3).
4. **Retitle** away from "converse" (§4, D1).
5. **Number the $g_\gamma$ cap as [L109](../findings/bounds-relaxations.md) and replace the hand check with the two-line proof, with its scope** (§6, D7/D8).
6. **Repair the dangling [T4](../plan.md) pointer** (§8, D11) and replace [bounds.md](../findings/bounds.md)'s inline re-derivation of the ratio with a citation to L117 (§8, D13).
7. **Record this review as one half of Gate 2** on row 117 of [INDEX-results.md](../findings/INDEX-results.md).
