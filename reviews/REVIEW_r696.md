# Review r696, Lemma L153, the Killing row marginal

**Review number: r696.** Reviewer B of an independent pair on identical cold briefs. Target: the block `#### Lemma L153, the Killing row marginal` in [findings/bounds.md](../findings/bounds.md), anchored by heading. **Analysis only**, every derivation below is by hand, and no computation of any kind was run; the screening allowance was not needed and not used.

## Verdict

**CONFIRMED as mathematics, REFUTED in its provenance clause.** The identity, its proof, its hypothesis-freeness and its home are all right, and I rebuilt every step cold with two checks the block does not carry. What fails is what the block claims *about the record*: **one of the five reviews it names as flagging the gap never flagged it**, the true number of reviews that did is **nine**, and the consumer list (which the brief correctly calls the block's real content), is **missing at least four consumers, two of them in the same file**.

| claim | verdict |
| --- | --- |
| $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$ under the record's half-trace pairing | **CONFIRMED**, rederived from the Killing form, and confirmed a second way by a bracket count that uses no Lie theory |
| the proof chain $-\mathop{\mathrm{tr}}(\mathrm{ad}(v_\alpha)^2)=-B(v_\alpha,v_\alpha)$, $B=(n-2)\mathop{\mathrm{tr}}(XY)$, $\mathop{\mathrm{tr}}(v_\alpha^2)=-2$ | **CONFIRMED**, with one hypothesis load-bearing and uncited: **ad-invariance of the norm** |
| *"a fact about the basis, not about any $W$"* | **CONFIRMED**, and the block **understates** it, it holds for every unit $v\in\mathfrak{so}(n)$, not only for a basis element |
| $n\ge3$ or similar needed | **no**, it holds at every $n\ge2$, including $n=4$ where $\mathfrak{so}(4)$ is not simple, and is vacuous below |
| the seven named consumers | **all seven CONFIRMED genuine**, none of them a confusion with [L31](../findings/stratum-two-negative.md) |
| the consumer list as a list | **GAP**, [L143](../findings/bounds.md), [L73](../findings/bounds.md), [L36](../findings/isotropy-cap.md) and [L79](../findings/isotropy-cap.md) are consumers and are absent |
| *"flagged independently by [r639](REVIEW_r639.md), [r640](REVIEW_r640.md), [r647](REVIEW_r647.md), [r649](REVIEW_r649.md) and [r650](REVIEW_r650.md) in one day"* | **REFUTED in one member**, [r647](REVIEW_r647.md) uses the marginal and never says it is unnumbered. *"In one day"* is true; *"five"* is nine |
| promoting it to a numbered result was right | **CONFIRMED**, nine reviews asked for it and [conventions.md](../findings/conventions.md) holds no numbered blocks |
| it duplicates [L114](../findings/bounds-relaxations.md) or [L112](../findings/bounds.md) | **no**, both are strict consumers. **But it duplicates relation (A) at [bounds.md](../findings/bounds.md) line 235, forty-five lines below it, with no cross-reference either way** |

---

## 1, The derivation, cold

**Setting.** [conventions.md](../findings/conventions.md) fixes the pairing on $\mathfrak{so}(n)\cong\Lambda^2\mathbb R^n$ as the half-trace $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)=-\tfrac12\mathop{\mathrm{tr}}(XY)$, under which $\varphi_{ab}=E_{ab}-E_{ba}$ has $\varphi_{ab}^{\mathsf T}\varphi_{ab}=E_{aa}+E_{bb}$ and hence $\lVert\varphi_{ab}\rVert^2=1$, so $\{\varphi_{ab}\}_{a<b}$ is orthonormal. A unit $v$ therefore satisfies $\mathop{\mathrm{tr}}(v^2)=-2$. That is the block's third input and it is correct in this convention.

**Step 1, the marginal is a trace of $\mathrm{ad}$, and this needs two hypotheses, of which the block names one.** For any orthonormal basis $\{v_\beta\}$,

$$\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=\sum_\beta\lVert\mathrm{ad}(v_\alpha)v_\beta\rVert^2=\mathop{\mathrm{tr}}\big(\mathrm{ad}(v_\alpha)^{\mathsf T}\mathrm{ad}(v_\alpha)\big).$$

The first equality is the definition; the second is the Frobenius norm of an operator read in an orthonormal basis, and **it is where orthonormality is spent**. The passage from there to $-\mathop{\mathrm{tr}}(\mathrm{ad}(v_\alpha)^2)$ is a *separate* step needing $\mathrm{ad}(v_\alpha)^{\mathsf T}=-\mathrm{ad}(v_\alpha)$, i.e. **ad-invariance of the very pairing the basis is orthonormal for**. That holds here (the half-trace form is a negative multiple of the Killing form) but the block's proof writes the two equalities as one and cites neither hypothesis. The brief anticipated exactly this, and it is a real citation gap: [conventions.md](../findings/conventions.md) does carry ad-invariance, in the *structure constants* bullet (*"the inner product being ad-invariant"*), so the repair is one clause.

**Step 2, the Killing form.** $B(X,Y)=\mathop{\mathrm{tr}}(\mathrm{ad}X\,\mathrm{ad}Y)=(n-2)\mathop{\mathrm{tr}}(XY)$ on $\mathfrak{so}(n)$ is standard and is what [conventions.md](../findings/conventions.md) records. **Checked independently at $n=3$**, where the formula predicts $B=\mathop{\mathrm{tr}}(XY)$: from $\varphi_{12}\varphi_{13}=-E_{23}$ and $\varphi_{13}\varphi_{12}=-E_{32}$ one gets $[\varphi_{12},\varphi_{13}]=-\varphi_{23}$ and $[\varphi_{12},\varphi_{23}]=\varphi_{13}$, so $\mathrm{ad}(\varphi_{12})$ is a rotation generator on the plane $\langle\varphi_{13},\varphi_{23}\rangle$ and $\mathop{\mathrm{tr}}(\mathrm{ad}(\varphi_{12})^2)=-2=\mathop{\mathrm{tr}}(\varphi_{12}^2)$. ✓

**Step 3.** $-B(v_\alpha,v_\alpha)=-(n-2)\mathop{\mathrm{tr}}(v_\alpha^2)=2(n-2)$. $\square$

**A second proof, sharing nothing with the first.** Take the coordinate basis $\{\varphi_{ab}\}_{a<b}$. For fixed $\varphi_{ab}$, the bracket $[\varphi_{ab},\varphi_{cd}]$ vanishes unless $\{a,b\}$ and $\{c,d\}$ meet in exactly one index, and when they do it is $\pm$ a basis element, of norm $1$. The partners are $\varphi_{ac}$ and $\varphi_{bc}$ for each of the $n-2$ indices $c\notin\{a,b\}$, **exactly $2(n-2)$ of them, each contributing $1$.** So the marginal is $2(n-2)$ **with no Killing form, no Casimir and no trace identity**. This is a stronger certificate than the block's own proof and it costs two lines; the block would be improved by carrying it, since the Killing-form route is the one that has repeatedly gone wrong here by a factor.

## 2, The plain-Frobenius reading, which the brief asks for by name

**Under plain Frobenius $\langle X,Y\rangle_F=\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ the marginal is $n-2$, a factor of $2$ smaller, not $\sqrt2$.**

Two derivations agree. *By the proof:* plain Frobenius is also ad-invariant, so Step 1 survives verbatim; a unit vector now has $\mathop{\mathrm{tr}}(v^2)=-1$, giving $-(n-2)\cdot(-1)=n-2$. *By the count:* the orthonormal basis is $u_{ab}=\varphi_{ab}/\sqrt2$, so $[u_{12},u_{13}]=-\tfrac1{\sqrt2}u_{23}$ has squared norm $\tfrac12$, and $2(n-2)$ partners give $(n-2)$.

**The general scaling law, worth recording because it explains why this quantity is not a $\sqrt2$ case.** Rescale the pairing to $c\langle\cdot,\cdot\rangle$; the orthonormal basis becomes $v_\beta/\sqrt c$ and the marginal becomes $\tfrac1c\cdot2(n-2)$. It is homogeneous of degree $-1$ in the pairing, where a singular value is homogeneous of degree $-\tfrac12$. **So a convention slip that costs a singular value a factor $\sqrt2$ costs this marginal a factor $2$**, the two errors are not the same error, and a reader who transfers today's $\sqrt2$ diagnosis to this constant will be wrong. The block says nothing about its convention dependence at all, which is the one thing about it that has cost this record cycles.

*Consistency check against a live consumer:* [L35](../findings/stratum-two-negative.md) writes the row marginal as $m-2$, half of L153's value, because its display sums over $\beta<\gamma$ rather than over ordered pairs. Both are right; the block gives no bridging line, and [r569](REVIEW_r569.md) already logged this as D3.

## 3, The hypothesis claim, and small $n$

**"A fact about the basis, not about any $W$" is correct**, no criticality, no Bianchi, no trace-freeness, no unit norm on $W$; $W$ does not appear in the statement. Two refinements the block owes.

- **"No unit norm" is ambiguous where it matters most.** In a sentence beginning *"a fact about the basis"*, a reader can read *"no unit norm"* as applying to the basis. It does not: **unit norm of $v_\alpha$ is exactly the input $\mathop{\mathrm{tr}}(v_\alpha^2)=-2$**, and dropping it changes the constant. The homogeneous form is $\sum_\beta\lVert[v,v_\beta]\rVert^2=2(n-2)\lVert v\rVert^2$, and stating it that way removes the ambiguity for free.
- **The block understates its own result.** Nothing in the proof uses $v_\alpha$ being a member of $\{v_\beta\}$. The true statement is: *for every $v\in\mathfrak{so}(n)$ and every orthonormal basis $\{v_\beta\}$, $\sum_\beta\lVert[v,v_\beta]\rVert^2=2(n-2)\lVert v\rVert^2$.* Several consumers use it in exactly that form, [L70](../findings/bounds.md) applies it at a unit $v\in E_{\min}$ which is not a basis element of the sum's basis, and [L78](../findings/isotropy-cap.md) applies it at an arbitrary orthonormal frame of a subspace. **As written, L153 does not cover its own consumers**; the "for every $\alpha$" quantifier has to be widened for [L70](../findings/bounds.md) to cite it.

**Small $n$: no threshold is needed.** At $n=2$, $\mathfrak{so}(2)$ is one-dimensional and abelian, the left side is $0$ and $2(n-2)=0$, the identity holds and both sides degenerate together, the Killing form being identically zero as $(n-2)\mathop{\mathrm{tr}}$ predicts. At $n=3$ it reads $2$, verified above. At $n=4$, $\mathfrak{so}(4)=\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ is **semisimple but not simple** (a place where a Killing-form argument can fail) and it survives: $B$ is the direct sum of the two factors' Killing forms and $(n-2)\mathop{\mathrm{tr}}$ still computes it, giving $4$, which the bracket count confirms ($\varphi_{12}$ brackets nontrivially with $\varphi_{13},\varphi_{14},\varphi_{23},\varphi_{24}$ and not with $\varphi_{34}$). At $n\le1$ the space is zero and the statement is vacuous. **So "$n\ge3$" would be a false restriction and the block is right to state none.**

## 4, The consumer list: all seven are real, and four more are missing

**Every one of the seven was checked at its own block, and every one genuinely consumes the marginal rather than [L31](../findings/stratum-two-negative.md)'s pair cap or some unrelated $2(n-2)$.**

| named consumer | where it enters | verdict |
| --- | --- | --- |
| [L70](../findings/bounds.md) | *"spends the fixed mass $\sum c_{vab}^2=2(n-2)$"*, the substitution step of the deficiency identity | **real** |
| [L107](../findings/bounds.md) | $\mu_a=T_{a\bullet\bullet}/2(n-2)$ is a probability measure *because* of it; and the $g$-route's $\sum_kg_k=4(n-1)\lVert W\rVert^2$ needs it a second time | **real, twice** |
| [L35](../findings/stratum-two-negative.md) | *"row marginals $m-2$"* in the LP relaxation, the unordered reading of the same identity | **real** |
| [L109](../findings/bounds-relaxations.md) | *"using $T\ge0$ with the row marginal $\rho_\alpha=2(n-2)$"*, the whole of the Hölder step | **real** |
| [L114](../findings/bounds-relaxations.md) | *"the row marginal $2(n-2)$ ([conventions.md](../findings/conventions.md))"*, summed over $\mathfrak m$-rows | **real** |
| [L112](../findings/bounds.md) | (A) gives row sums $2(n-2)$, which is what makes $S/2(n-2)$ doubly stochastic | **real** |
| [L78](../findings/isotropy-cap.md) | via the block-form identity $\alpha+2S_{\mathfrak{mmh}}+S_{\mathfrak{mhh}}=2(n-2)d$, the marginal summed over $d$ rows | **real** |

**Four further consumers are absent, and their absence is not a matter of taste.**

- **[Lemma L143](../findings/bounds.md), at line 17 of the very file L153 sits in.** Its heading is *"from the two recorded marginals"*, its proof consumes *"the Killing row mass $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$"* explicitly, and its closing sentence is *"the two marginals are the whole of its input"*. **This is the most marginal-dependent lemma on the record and it is 263 lines above the block that lists its consumers.**
- **[Lemma L73](../findings/bounds.md), line 369 of the same file.** Its Gate 2 blockquote reads *"(A) is load-bearing and is where $n-2$ comes from, its total mass $2(n-2)$ over (B)'s $2$, and without it $\mu_a$ is not a probability measure and the range argument does not start"*. **Both [r649](REVIEW_r649.md) and [r650](REVIEW_r650.md) name L73 in the very sentence recommending the number** (r650's item 3 is *"it carries L70, L73 and L107 besides"*) so the block acted on those two recommendations and dropped a consumer they spelled out.
- **[Lemma L36](../findings/isotropy-cap.md).** Its Killing block identity $2\mu+\gamma=2(n-2)d$ *is* the marginal summed over $\mathfrak m$-rows; [r647](REVIEW_r647.md) and [r648](REVIEW_r648.md) both say so, and [r639](REVIEW_r639.md) says L114 and L36 are the same relation.
- **[Lemma L79](../findings/isotropy-cap.md).** Its table's trace check, $\mathop{\mathrm{tr}}\mathcal A=\sum_{g<h}\lVert[\varphi_g,\varphi_h]\rVert^2=\binom m2(m-2)$, is the marginal summed over all rows, one of *"two checks the table passes and could not pass by accident"*.

Beyond these, [r639](REVIEW_r639.md) names [post F18](../findings/bounds-relaxations.md), [r640](REVIEW_r640.md) names [L23](../findings/ungraded-slack.md) (*"L23's proof runs on $S_{\mathfrak{hhh}}+S_{\mathfrak{hmm}}=\kappa r$ … with $\kappa=2(n-2)$"*) and [r609](REVIEW_r609.md) names [L77](../findings/isotropy-cap.md). **The hedge is "known consumers", which is honest, but a block whose stated purpose is to give the consumers something to cite should not omit two of them from its own file.**

## 5, Provenance: the note is false in one member and understates by a factor of nearly two

**The block's note: *"having carried at least five results with no number anywhere on the record, flagged independently by [r639](REVIEW_r639.md), [r640](REVIEW_r640.md), [r647](REVIEW_r647.md), [r649](REVIEW_r649.md) and [r650](REVIEW_r650.md) in one day"*.** Checked against the files.

- **[r647](REVIEW_r647.md) never flags it.** Its only two substantive mentions are §Inputs (*"The Killing marginal … from the pair cap bullet"*) and a derivation step; the word "number" appears in it seven times and never about the marginal. **It is a *user*, not a *flagger*.** Its pair [r648](REVIEW_r648.md) does not flag it either, so the list cannot be repaired by substitution within that pair. *This is the same failure mode a companion audit found today, a block crediting a review with something the review does not say.*
- **Nine reviews flag it, not five.** Beyond r639, r640, r649 and r650, the gap is stated in as many words by **[r565](REVIEW_r565.md)** (*"a standing fact with no result number … the answer to the brief is: no number"*), **[r569](REVIEW_r569.md)** (*"the marginal carries no result number anywhere"*), **[r570](REVIEW_r570.md)** (*"appears in no numbered block … this audit is a fourth independent sighting"*), **[r609](REVIEW_r609.md)** (D4, *"with no result number"*, CONFIRMED and re-derived) and **[r635](REVIEW_r635.md)**, whose §8 is titled *"Where the row marginal lives, and that it has no number"* and which states the owed repair. **The block picks the five most recent, gets one of them wrong, and misses the four earliest, including [r635](REVIEW_r635.md), the only one that devotes a section to the question.**
- ***"In one day"* survives.** `git log` puts all nine review files and the LEDGER item on 2026-09-04, the earliest at 17:07 and the block itself at 22:59 (`be42a476`, *"feat(L153): the Killing row marginal finally has a number"*). ✓
- ***"At least five results"* is true and reads as a slip.** The same sentence's own list names **seven**, and §4 above brings the count to at least eleven. The "five" appears to be the reviewer count leaking into the result count.
- ***"Its companion … has always had a number, [L31](../findings/stratum-two-negative.md)"*.** ✓ Confirmed: [L31](../findings/stratum-two-negative.md) is the pair cap, at [stratum-two-negative.md](../findings/stratum-two-negative.md) line 401, and it is a different statement, $\sum_\gamma T_{\alpha\beta\gamma}\le2$, an inequality on a pair, against an equality on a row. **No consumer in §4 confuses the two**, which was the brief's specific worry, and I checked each one for it.
- **The identical false clause is in the index row.** [INDEX-results.md](../findings/INDEX-results.md) row **153** repeats *"flagged by five reviewers in one day"*. Repairing the block alone leaves it standing.
- **[LEDGER.md](../findings/LEDGER.md) already concedes the miscount and the block is unrepaired.** Its item at line 1318 reads *"which is the [L153](../findings/bounds.md) mistake made twice, that block's own note miscounted its flaggers"*, committed at 23:13 in `2e1a4147`. **A known-false sentence left standing in the block it is about is worse than an unaudited one**, because the ledger entry makes the record look self-correcting where nothing was corrected. Item 3 of the same list still prints the false *"five reviewers"* two lines below.

## 6, Was numbering it right, is bounds.md the home, and does it collide

**Numbering it was right, and I would have recommended it independently.** Nine reviews asked for it; a fact with eleven consumers spread over five files must be citable; and **[conventions.md](../findings/conventions.md) contains no `####` result blocks at all**, so the number could not have lived there. The alternative the brief floats (leaving it as a convention its consumers cite), was the status quo that nine audits rejected, and it fails on a plain reading of [INDEX-results.md](../findings/INDEX-results.md)'s own rule: *"a number is assigned when a result gets a `#### Lemma N` block in findings/ … a result with no block there has no number to cite."*

**[bounds.md](../findings/bounds.md) is defensible but not obviously right, and one thing must change if it stays.** Against it: the fact is a statement about $\mathfrak{so}(n)$ with no $W$ in it, used in four *other* files, sitting in a file whose index line reads *"What bounds $\theta$"*. For it: bounds.md already states the identity as **relation (A)** of the row calculus. Which brings the real defect,

> **L153 and relation (A) at [bounds.md](../findings/bounds.md) line 235 are the same identity, forty-five lines apart in one file, with no cross-reference in either direction.** $\lVert[v_\alpha,v_\beta]\rVert^2=\sum_\gamma T_{\alpha\beta\gamma}$ makes L153's left side literally (A)'s left side. **[r565](REVIEW_r565.md) saw this already**, *"The record does number it in another guise: relation (A) of the row calculus, 80 lines below the block, is the same identity"*, and the block was written without folding it in. This is the fourth duplication pattern the record has hit today, and the cheapest to close: **one clause in L153 saying it is relation (A), and one clause at (A) citing L153.** Without it the file states its own newest lemma twice and a reader meeting (A) first has no reason to look for a number.

**Neither named collision is a duplication.**

- **[L114](../findings/bounds-relaxations.md) is a strict consequence**, as its own text says, the marginal summed over the $d$ rows of $\mathfrak m$ with the free pair split by block. L153 is more general in the only way that matters: it is per row and needs no splitting. **No overlap to remove.**
- **[L112](../findings/bounds.md) is a consumer, not a twin.** It converts $S_{ab}=\sum_cT_{abc}$ into a doubly stochastic matrix, and the marginal is precisely the normalising constant; [r650](REVIEW_r650.md) established that the $-\tfrac1{n-2}$ eigenvalue comes from the marginal *and only the marginal*, with [L31](../findings/stratum-two-negative.md)'s cap never used. **No overlap.**

**What the block should have said and did not: it is the parent of a family the record carries in five guises.** L153, relation (A) at [bounds.md](../findings/bounds.md) line 235, [L114](../findings/bounds-relaxations.md) and its $\mathfrak h$-row twin, [L36](../findings/isotropy-cap.md)'s $2\mu+\gamma=2(n-2)d$, and the $1/3/3/1$ identity in [nondegeneracy.md](../findings/nondegeneracy.md) are one fact contracted five ways across three files. [r639](REVIEW_r639.md) recommended *"one of the two should become a pointer"* about L114 and L36; **numbering the parent is what makes that repair possible, and the block names only one of the four children, in passing.** That, rather than the id, is where the value of this block was and it is unclaimed.

## 7, Pointers and the surrounding structure

- **Every link in the block resolves**, five findings files and five review files, all present. ✓
- **But every consumer link is a bare file link with no anchor**, `[Lemma L70](bounds.md)`, `[Lemma L107](bounds.md)`, and so on, where the surrounding file uses `[Lemma L70](../findings/LEDGER.md#lemma-l70-the-deficiency-identity-and-what-saturates-it)` throughout. Three of the seven point at [bounds.md](../findings/bounds.md) itself, i.e. at the file the reader is already in. **A consumer list whose entries land nowhere is a weaker artefact than the same list with anchors**, and this is the one block whose whole content is its pointers.
- **[findings/INDEX.md](../findings/INDEX.md)'s file map omits L153.** Its bounds.md row enumerates *"Lemmas L7, L70, L71, L73, L106, L107, L108, L111, L112, L113, L117"*, L153 is not in it, so the index that tells a cycle which file to open does not know where L153 lives.
- **L153 is absent from [results.md](../results.md)** entirely, as [L108](../findings/bounds.md) was found to be.
- **[INDEX-results.md](../findings/INDEX-results.md) has a row 153 and a stale footer.** The row exists and is correctly formed. The file's closing line reads *"**132 numbered results.** Next free number: **133**"* against 153 rows actually present, **stale by 21 results**, predating this block but now guaranteeing that the next result numbered from that footer collides. Worth naming here because it is exactly the kind of counter that silently mints a duplicate id.
- **Four names for one object, and the block adds a fifth phrasing without saying which is canonical**: $\rho_\alpha$ ([L109](../findings/bounds-relaxations.md)), *the Killing row mass* ([L143](../findings/bounds.md)), *the Killing marginal* ([conventions.md](../findings/conventions.md)), *relation (A)* ([bounds.md](../findings/bounds.md)), and now *the Killing row marginal*. Since the point of the block is citability, **it should declare the canonical name and the canonical symbol.**

## 8, What is owed

1. **Delete [r647](REVIEW_r647.md) from the flagger list** in both the block and [INDEX-results.md](../findings/INDEX-results.md) row 153, and replace *"at least five … flagged by five reviewers"* with the checked nine, [r565](REVIEW_r565.md), [r569](REVIEW_r569.md), [r570](REVIEW_r570.md), [r609](REVIEW_r609.md), [r635](REVIEW_r635.md), [r639](REVIEW_r639.md), [r640](REVIEW_r640.md), [r649](REVIEW_r649.md), [r650](REVIEW_r650.md). *[LEDGER.md](../findings/LEDGER.md) line 1318 already says the note miscounted; line 1319 still prints the miscount.*
2. **Add [L143](../findings/bounds.md), [L73](../findings/bounds.md), [L36](../findings/isotropy-cap.md) and [L79](../findings/isotropy-cap.md) to the consumer list**, and anchor every entry.
3. **Tie L153 to relation (A)** at [bounds.md](../findings/bounds.md) line 235, in both directions. Until that is done the file carries the identity twice.
4. **Widen the quantifier** to every $v\in\mathfrak{so}(n)$ and state the homogeneous form $2(n-2)\lVert v\rVert^2$, so that [L70](../findings/bounds.md) and [L78](../findings/isotropy-cap.md) can actually cite it, and so that *"no unit norm"* stops reading as a claim about the basis.
5. **Cite ad-invariance** in the proof's first equality, and add the two-line bracket count as a second proof independent of the Killing form.
6. **State the convention dependence**: $2(n-2)$ at half-trace, $n-2$ at plain Frobenius, degree $-1$ in the pairing, hence a factor $2$, not the $\sqrt2$ that governs singular values.
7. **Add L153 to [findings/INDEX.md](../findings/INDEX.md)'s bounds.md row**, and repair [INDEX-results.md](../findings/INDEX-results.md)'s *"next free number: 133"* footer before it mints a collision.

**The block should exist.** Nothing here argues for withdrawing it; the mathematics is among the soundest on the record and the gap it closes was real and nine times reported. What it needs is for its own claims about the record to be held to the standard it applies to the mathematics.
