# REVIEW_r585, Observation L12 (the ungraded half, measured, and its slack has a closed form)

Reviewer r585, independent adversarial audit. Brief: audit one result, `Observation L12`, whose block sits in [ungraded-slack.md](../findings/ungraded-slack.md). Analysis-only footing: no computation beyond a screen of seconds on objects constructed for the purpose, reported as a screen.

Verdicts are appended as they are reached; this file is created before any mathematics.

## Log

- Created before mathematics, 2026-09-04.

## What was audited, and where it lives

| item | location |
| --- | --- |
| the block | [ungraded-slack.md](../findings/ungraded-slack.md), `##` section heading at line 289, `####` block heading at line 292, body to line 304 |
| the index row | [INDEX-results.md](../findings/INDEX-results.md) row 12 |
| the canonical restatement | [results.md](../results.md) line 364 |
| the report's copy | [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 288 |
| the derivation the block gestures at | [ATTEMPTS.md](../ATTEMPTS.md) lines 1178-1238 |

Method: the chain was rebuilt from the definitions in [conventions.md](../findings/conventions.md) by hand, the normalisation pinned by evaluating the scalar-curvature identity at the round sphere's curvature operator, and every provenance and numeric clause checked against `git` and against the rest of the record. No computation was run; the analysis-only footing was kept throughout.

## D0, the index row points at the wrong file, **CONFIRMED**, and it is one of three

Row 12 of [INDEX-results.md](../findings/INDEX-results.md) reads `| **12** | Observation | ... | [target.md](target.md) |`. The block is in [ungraded-slack.md](../findings/ungraded-slack.md). **Confirmed.**

Two further pointers at the same number are wrong, and the brief did not name them:

- [LEDGER.md](../findings/LEDGER.md) line 1467 lists `[L12](curvature-invariants.md)` among the Observations carrying Lemmas, a **third** file, which holds L13's spectral-moment method and nothing of L12.
- [results.md](../results.md) line 368 ends its L12 entry with `**Proof:** [target.md](findings/target.md)`.

So **all three pointers to L12 on the record point somewhere the block is not**, and they disagree with each other. Nothing on the record routes a reader to the block.

## D1, the heading promises a proof and the block carries none, **CONFIRMED**

The `####` heading reads *"canonical statement and proof"*. The block's entire account of the derivation is one clause: *"Compressing the criticality equation onto the negative eigenspace, applying the scalar-curvature identity to $W_-$, and expanding $\#$ bilinearly reduces it ... to"*. Three verbs, no steps, no lemma names, no pointer to where the steps are.

The steps exist, in [ATTEMPTS.md](../ATTEMPTS.md) lines 1183-1191 (the numbered chain 1-7, plus lemmas (A) and (B) at 1205-1207). The block cites neither, and [findings/](../findings/) holds no copy of them.

**What the label should be, clause by clause:**

| clause | status | grade |
| --- | --- | --- |
| $S\ge0$ at a critical point | proved unconditionally by the decomposition at [ATTEMPTS.md](../ATTEMPTS.md) line 1224 | Lemma-grade, and the block owns none of the proof |
| $S=\mathop{\mathrm{tr}}(P_{E_-}W_-^\#P_{E_-})$ under the two conditions | proved (chain steps 1-7, modulo F1/F2 which the hypotheses supply) | Lemma-grade, conditional; proof off-file |
| the closed-form expansion $\tfrac12\sum\mu_i\mu_j\lVert P_{E_-}[v_i,v_j]\rVert^2$ | proved from rank-one $\#$-positivity | Lemma-grade; proof off-file |
| the $239$-point gap, the ceiling, the $S=4/7$ non-monotonicity | measured | Observation-grade, correctly labelled |

So the block is a genuine `Observation` in its second half and an un-proved restatement of theorems in its first. **A downgrade repairs nothing here, because the label is already `Observation`; what the heading claims is the proof.** Removing *"and proof"* would leave the record with **no** copy of the chain inside [findings/](../findings/), which is the debt this defect names: either the chain moves into the file, or the block cites [ATTEMPTS.md](../ATTEMPTS.md) lines 1183-1238 explicitly.

## D2, the two bracket conditions are named nowhere in the block, and the class they hold on is defined nowhere at all, **CONFIRMED**, and it is the block's largest gap

The guard is *"on the structured class, under two bracket conditions that hold there"*.

**The conditions.** They are $[E_+,E_+]\perp E_-$ and $[E_+,E_-]\subseteq E_-$, stated once on the record, at [ATTEMPTS.md](../ATTEMPTS.md) line 1211: *"at any critical point where $[E_+,E_+]\perp E_-$ and $[E_+,E_-]\subseteq E_-$, the slack is $S=\tfrac12\sum_{i,j}\mu_i\mu_j\lVert P_{E_-}[v_i,v_j]\rVert^2$."* They appear again at line 1234 as the equality case of $S\ge\tfrac12G_1$, and six lines below the block itself, inside [L132](../findings/ungraded-slack.md)'s withdrawal note. **The block never states them, and no file in [findings/](../findings/) states them as L12's hypotheses.** A reader cannot check whether a point satisfies a hypothesis that is not written down.

**The class.** *"The structured class"* occurs three times on the whole record, the block, the report's copy, and [ATTEMPTS.md](../ATTEMPTS.md) line 1215, and is **defined in none of them**. There is no membership test, no list, no dimension range. The identity is therefore claimed on a set the record cannot identify.

**Is the identity claimed beyond them?** No, the block says outright *"the identity itself is conditional on those conditions, not universal"*, and reports the $11.5$ ratio against the claimed $\tfrac12$, which matches [ATTEMPTS.md](../ATTEMPTS.md) line 1213 exactly. That clause is honest. The defect is that the guard is unstatable, not that it is overreached.

**One further asymmetry.** The record's own canonical statement of the same number, [results.md](../results.md) line 364, names a **different and definite** class: *"which has a closed form on the subalgebra family (Lemma L23)"*. That is checkable, [L23](../findings/ungraded-slack.md)'s $S_{\mathfrak{mmm}}$ is $G_1$ up to the common $\mu^2$ on a Casimir, so the two are compatible where they overlap, but "the subalgebra family" and "the structured class" are not the same set, and the record states L12 two ways in two files.

## D3, the provenance note, **PARTLY CONFIRMED**: the "only copy" clause is true, the other two are false

The note reads: *"Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy. That file now carries the statement and points here."*

Checked against `git`, clause by clause:

| clause | verdict | evidence |
| --- | --- | --- |
| moved from results.md on 2026-08-31 | **true of target.md, false of this file** | `a9e4b8c0` (2026-08-31) moved the argument `results.md` → `findings/target.md`; it reached `findings/ungraded-slack.md` on 2026-09-02 via `227616f7` / `56601517` |
| the argument was the only copy | **true** | `git grep -l "The slack is not an opaque residual"` returns `results.md` alone at `a9e4b8c0^`, `findings/target.md` alone at `a9e4b8c0`, `findings/ungraded-slack.md` alone at `HEAD`, one copy at every point in the history |
| that file now carries the statement and points here | **false** | [results.md](../results.md) line 368 points at `findings/target.md` |

So this is **not** a fourth note of the L4/L5/L34 pattern: there is no byte-identical duplicate left behind, and the "only copy" claim survives. What is false is the word *here*. The section note two lines above the heading already says the true thing, *"Re-filed here 2026-09-02 from [target.md](target.md) by the parallel sort"*, so the file carries two provenance notes that disagree about where the block came from, one of them stale by two days.

## D4, the use of L8, **CONFIRMED as a stale citation, and harmless to L12**

The block: *"Lemma L8 settles the equality side across the classical families, **scoped to the balanced splits, the only ones the sweep behind it evaluated**."*

Three things are wrong with the sentence and none of them touches the mathematics:

- **The label is stale.** [INDEX-results.md](../findings/INDEX-results.md) row 8 records L8 as a **Conjecture**, downgraded from Lemma and refuted by both [r503](REVIEW_r503.md) and [r504](REVIEW_r504.md), as of commit `21861035` on 2026-09-04. The block still calls it a Lemma.
- **"Settles ... across the classical families" is refuted by the block's own file.** Nineteen lines above, [ungraded-slack.md](../findings/ungraded-slack.md) line 162 carries $S^5\times S^7$, unbalanced, graded, critical, and at $\theta=1.2282390$, above $\sqrt{3/2}$, under the heading *"the subalgebra family does not exhaust the graded critical set"*. The main clause and the parenthetical that narrows it say opposite things in one sentence.
- **L12 does not consume L8.** Neither $S\ge0$ nor the closed form uses anything from L8; the reference is scene-setting. **L12 survives the downgrade untouched.** The repair is a sentence, not a result.

## D5, "the supporting trace lemmas ... confirmed precisely because they continue to hold where the bracket conditions fail", **REFUTED**

The sentence has no referent for *"the supporting trace lemmas"*, and on the reading a reader would most naturally take it is false.

**There are four trace identities in the chain**, and they split cleanly:

- **(A)** $\mathop{\mathrm{tr}}(W_+^2)+\mathop{\mathrm{tr}}(W_+^\#)=\mathop{\mathrm{tr}}(W_-^2)+\mathop{\mathrm{tr}}(W_-^\#)$ and **(B)** $\mathop{\mathrm{tr}}(W_-^2)+\mathop{\mathrm{tr}}(W_-^\#)=\mathop{\mathrm{tr}}(W_+\#W_-)$, [ATTEMPTS.md](../ATTEMPTS.md) lines 1205-1207. These do hold where the bracket conditions fail.
- **(F1)** $\mathop{\mathrm{tr}}(P_-W_+^\#P_-)=0$ and **(F2)** $\mathop{\mathrm{tr}}(W_-^2)+\mathop{\mathrm{tr}}(W_-^\#)=\mathop{\mathrm{tr}}(P_-(W_+\#W_-)P_-)$, chain steps 5 and 6, lines 1189-1190. These are trace identities too, they are the block's *"supporting"* steps in the most literal sense, and [ATTEMPTS.md](../ATTEMPTS.md) line 1209 proves

  $$\textbf{F1}\iff[E_+,E_+]\perp E_-,\qquad \textbf{F2}\iff[E_+,E_-]\subseteq E_-.$$

  **F1 and F2 *are* the two bracket conditions, restated as traces. They fail exactly and only where the conditions fail.** On that reading the block's sentence asserts the negation of a proven equivalence.

**And the causal clause is wrong even on the (A)/(B) reading.** The source it compresses, [ATTEMPTS.md](../ATTEMPTS.md) line 1215, says the persistence *"is what rules out circularity"*, a claim about the evidence not being self-confirming. The block converts that into *"confirmed precisely because they continue to hold"*, i.e. into the ground of their being theorems. (A) and (B) are theorems because they have two-line proofs, (A) from the scal identity applied to $W_+$ and $W_-$ separately with $\mathrm{Ric}(W_+)=\mathrm{Ric}(W_-)$ and $\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$; (B) from the full trace of criticality plus (A). Numerical persistence off the hypotheses is what makes them non-circular *evidence*, never what makes them true.

**Verdict: REFUTED.** The referent is undefined; under the F1/F2 reading the sentence contradicts [ATTEMPTS.md](../ATTEMPTS.md) line 1209; under the (A)/(B) reading its "precisely because" misstates what the persistence establishes.

## D6, the ceiling $0.9067$, **REFUTED**: the record's figure is $0.900828$, in nine places, three of them in this block's own file

The block: *"The observed ceiling has since moved to $0.9067$ under a second independent audit."* No audit is named, no witness is named, no dimension is given.

**$0.9067$ appears on the record twice**: here, and at [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 337, which took it from here. (Two reviews, [r314](REVIEW_r314.md) and [r384](REVIEW_r384.md), repeat it downstream.)

**$0.900828$ appears in nine**, including three in [ungraded-slack.md](../findings/ungraded-slack.md) itself:

| location | what it says |
| --- | --- |
| [ungraded-slack.md](../findings/ungraded-slack.md) line 65 | *"Neither the recorded ceiling $0.900828$ ..."* |
| [ungraded-slack.md](../findings/ungraded-slack.md) line 69 | *"The recorded $\theta\le0.900828$ stands on $n=6$ and $8$"* |
| [ungraded-slack.md](../findings/ungraded-slack.md) line 238 | *"including the recorded ceiling $0.900828$"* |
| [target.md](../findings/target.md) line 153 | *"the ungraded population, whose ceiling is $0.900828$"* |
| [graded-half.md](../findings/graded-half.md) lines 134, 450 | *"the ceiling stands at $0.900828$"* |
| [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) lines 151, 282 | $0.900828$ |
| [report/sections/09-status.tex](../report/sections/09-status.tex) line 163 | $0.900828$ |
| [ATTEMPTS.md](../ATTEMPTS.md) line 1174 | *"So the ceiling of $0.900828016$ stands, at both $n=8$ and $n=12$"*, written **as the outcome of the retraction the block's own next sentences describe** |

The block's paragraph narrates the retraction at [ATTEMPTS.md](../ATTEMPTS.md) lines 1172-1174 (*"a witness I had retracted is genuine after all"*) and then reports a ceiling that the very same retraction fixes at $0.900828016$. **REFUTED**, and the settling fact is three lines of the block's own file.

*The dependent claims survive:* the gap $1.2247-0.9067=0.318$ and $1.2247-0.900828=0.324$ both round to the block's *"about $0.32$"*, so nothing downstream of the ceiling changes.

## D7, "the identity above ... is now the screen that detects them", **REFUTED**, by the block's own next sentence

Two consecutive sentences:

> *"... the identity above (which such points violate), is now the screen that detects them. The correct screen turned out to be a second-order residual polish rather than the eigenvalue cutoff or the ratio test I first proposed ..."*

The identity-as-screen **is** the ratio test: it detects a point by comparing $S$ against $\tfrac12G_1$. The second sentence retires it and the first installs it, in that order.

The record agrees with the second. [ATTEMPTS.md](../ATTEMPTS.md) line 1174: *"The screen this section proposed is withdrawn: **a ratio test built on a conditional identity cannot certify convergence.** The correct screen is second-order."* And line 1172 records the concrete failure, the ratio screen flagged the $\theta=0.900828$ witness, and the flag was wrong; *"Its $S/G_1$ ratio deviates because $S=\tfrac12G_1$ is conditional on F1/F2, which it violates, not because the point is defective."*

**REFUTED.** The clause is a withdrawn claim reinstated, and it is the reason D6's ceiling is wrong: the withdrawn screen is what condemned the $0.900828$ witness.

## D8, the headline is superseded: the record holds an **unconditional** closed form, **CONFIRMED**

The block's title promises *"its slack has a closed form"* and delivers a conditional one on an undefined class. The record holds

$$S=T_1+2T_2+T_3,\qquad T_1=\mathop{\mathrm{tr}}(P_-W_+^\#P_-),\quad T_2=\mathop{\mathrm{tr}}\bigl((1-P_-)(W_+\#W_-)(1-P_-)\bigr),\quad T_3=\mathop{\mathrm{tr}}(P_-W_-^\#P_-)=\tfrac12G_1,$$

**at every critical point with no hypotheses whatever**, each term a compression of a PSD operator and so nonnegative ([ATTEMPTS.md](../ATTEMPTS.md) line 1224, Gate 2 passed). The block's identity is the special case $T_1=T_2=0$.

I rebuilt this by hand and it is right. From step 3, $S=2\mathop{\mathrm{tr}}(W_-^2)+2\mathop{\mathrm{tr}}(W_-^\#)+\mathop{\mathrm{tr}}(P_-W^\#P_-)$; (A)+(B) replace the first two terms by $2\mathop{\mathrm{tr}}(W_+\#W_-)$; $W^\#=W_+^\#-2W_+\#W_-+W_-^\#$ splits the third into $T_1-2\mathop{\mathrm{tr}}(P_-(W_+\#W_-)P_-)+T_3$; and for symmetric $X$, $\mathop{\mathrm{tr}}(X)-\mathop{\mathrm{tr}}(P_-XP_-)=\mathop{\mathrm{tr}}((1-P_-)X(1-P_-))$, so the two $W_+\#W_-$ terms combine to exactly $2T_2$. No hypothesis enters.

**The block advertises the weaker statement as its headline, and the stronger one is recorded six lines below it**, in [L132](../findings/ungraded-slack.md)'s withdrawal note, which says so in as many words: *"[ATTEMPTS.md](../ATTEMPTS.md)'s slack decomposition is that replacement, and it is stronger."* The block was not updated when that was written.

## D9, the quantifier, **CONFIRMED**

Three separate quantifier gaps:

- **$S\ge0$ is displayed with no hypothesis.** It is a fact about **critical points**, not about $\mathcal W_n$: the Gate-2 strengthening at [ATTEMPTS.md](../ATTEMPTS.md) line 1238 gives $S-(T_1+2T_2+T_3)=-\mathop{\mathrm{tr}}(P_-(Q(W)-\theta W)P_-)$, whose right side vanishes exactly on the critical set. Off it $S$ can be negative, and [ungraded-slack.md](../findings/ungraded-slack.md) itself records observed negative values, in the $n=6$ walk: *"what they measure is $S$ off the critical set, where the graded compression inequality does not apply, several sampled values are negative"*. The preceding sentence supplies the context; the display does not carry it.
- **No $n$ is stated anywhere in the block.** The inequality and the identity are dimension-free. The measurements are not: $239$ points at $n=8$ and $n=12$; the ceiling at $n=6$ and $n=8$ (line 69) or $n=8$ and $n=12$ ([ATTEMPTS.md](../ATTEMPTS.md) line 1150), the record disagrees with itself on which; the companion bound at $n=6\ldots24$. A reader has no way to tell which sentence is dimension-free.
- **The class for the closed form is "the structured class"**, which D2 shows is defined nowhere.

## D10, the norm, and the symbols the block leans on that the record does not define, **CONFIRMED**

Against [conventions.md](../findings/conventions.md), which the section note two lines above the heading cites in blanket form:

| symbol | status |
| --- | --- |
| $S$ | tabled as *"the gradedness slack"* with **no formula**, and with the instruction *"Read [W4](../findings/INDEX-traps.md) before using it: the screen is vacuous when $\ker W\ne0$"*. The block is the definition, and it never cites W4, although W4 bears directly on its interpretive claim that $S$ measures gradedness |
| $\delta$ | **defined nowhere in [findings/](../findings/)**. Its only definition on the record is in the report, [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 523: $\delta^2(W)=\lVert\mathrm{Alt}(W_-)\rVert^2$. [conventions.md](../findings/conventions.md) tables $\Delta$, a different object |
| $E_-$, $E_+$, $P_{E_-}$ | untabled. The nearest tabled entry is $\mathfrak m$, which [conventions.md](../findings/conventions.md) warns carries **three incompatible senses**; $E_-$ here is the whole-negative-eigenspace sense. The sign convention $E_\pm$ is *by sign of the eigenvalue* is load-bearing for the kernel-contamination paragraph and is stated only in [ATTEMPTS.md](../ATTEMPTS.md) line 1152 |
| $\mu_i$ | a **fourth** sense of $\mu$, against the three [conventions.md](../findings/conventions.md) already flags as colliding. Here $\mu_i>0$ with $Wv_i=-\mu_iv_i$; the positivity is never stated and every summand's nonnegativity depends on it |
| $W_-$ | tabled, and the block's use is consistent with it: $W_-=\tfrac12(\lvert W\rvert-W)\succeq0$ gives $W_-v_i=+\mu_iv_i$, which is the sign the expansion needs |

**The norms.** The definition of $S$ mixes three pairings in one line, and names none:

- $\lVert\mathrm{Ric}(W_-)\rVert^2$, plain Frobenius on the $n\times n$ symmetric matrix;
- $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$, at the $S^2(\Lambda^2)$ level;
- $\mathop{\mathrm{tr}}(W_-)$, $\mathop{\mathrm{tr}}(W_-^2)$, operator traces on $\Lambda^2$, in the basis $\{\varphi_{ab}\}_{a<b}$ that [conventions.md](../findings/conventions.md) makes orthonormal.

[conventions.md](../findings/conventions.md) warns in terms that *"the $\Lambda^2$ and $n\times n$ Frobenius pairings differ by a factor $2$"* and that *"two reviewers once disagreed on a value for exactly this reason"*, and this display is a place the two meet.

**Pinned by hand, at the round sphere.** Take $R=\mathrm{Id}$ on $\Lambda^2\mathbb R^n$, the curvature operator of $S^n$ with sectional curvature $1$. Then $\mathrm{Id}^\#=(n-2)\mathrm{Id}$: by the rank-one identity, $\mathop{\mathrm{tr}}(\mathrm{Id}^\#)=\tfrac12\sum_{\alpha,\beta}\lVert[\varphi_\alpha,\varphi_\beta]\rVert^2=\tfrac12 N\cdot 2(n-2)=N(n-2)$ using [conventions.md](../findings/conventions.md)'s Killing marginal $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$, and $\mathrm{Id}^\#$ is $SO(n)$-equivariant, hence scalar. So $\mathop{\mathrm{tr}}(R^2+R^\#)=N(n-1)$ and $\mathop{\mathrm{scal}}=2\mathop{\mathrm{tr}}$ gives $n(n-1)^2$. On the right, $\mathrm{Ric}=(n-1)\,\mathrm{Id}_n$ gives $\lVert\mathrm{Ric}\rVert_F^2=n(n-1)^2$, and $\mathrm{Alt}(R)=0$ by Bianchi. **They agree exactly**, which fixes $\lVert\mathrm{Ric}\rVert$ as the plain $n\times n$ Frobenius norm and $\mathop{\mathrm{scal}}=2\mathop{\mathrm{tr}}_{\Lambda^2}$. *The check leaves the normalisation of $\lVert\mathrm{Alt}\rVert$ against the constant $6$ untested, $\mathrm{Alt}$ vanishing there.*

So the display is **self-consistent under the reading the rest of the record uses**, but the block declares none of it, and [conventions.md](../findings/conventions.md) gives $S$ no formula to check against.

## D11, what cites it, and the genuine figure, **3 citations, 2 restatements, 0 dependencies**

Counted in [findings/](../findings/), [results.md](../results.md) and [report/](../report/) only, with `#L12` anchors and brief-local labels discounted, and $L12x$ matches excluded:

| location | kind |
| --- | --- |
| [results.md](../results.md) line 68 | citation, *"the carrier inequality of Observation L12 fails to separate"* |
| [results.md](../results.md) line 132 | citation, the landscape entry |
| [LEDGER.md](../findings/LEDGER.md) line 1467 | citation, listed among the Observations carrying Lemmas, with a wrong file link (D0) |
| [results.md](../results.md) line 364 | restatement, the canonical statement, differing from the block (D2) |
| [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 288 | restatement, `\begin{Obs}{12}` |
| [ungraded-slack.md](../findings/ungraded-slack.md) lines 289, 292 | the block itself |

**The genuine figure is three citations and two restatements. No result on the record derives anything from L12**, nothing consumes the closed form, and the users of $S\ge0$ take it from [L7](../findings/bounds.md) or from the unconditional decomposition. That is the reason D6 and D7 are recoverable: the false clauses are narrative, and nothing is built on them.

**Are the uses inside the hypotheses?** The two [results.md](../results.md) citations are about the *companion* carrier bound, whose refutation by $(S^m)^3$ the block itself records, they cite the block's honest half and stay inside it. The report's restatement (line 288) reproduces the conditional identity and the undefined *"a structured class"*, so it inherits D2 verbatim; its certificate block, unusually, states the **unconditional** decomposition that D8 says the block should have led with.

*Spillover noted and out of scope:* [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 157 calls Jensen's metric *"$S=0$, \emph{graded}"*, which [ungraded-slack.md](../findings/ungraded-slack.md) line 174 explicitly withholds, the screen is vacuous at that point's $7$-dimensional kernel, by trap W4. That belongs to L58's audit, not this one.

## Overall verdict, **REPAIRABLE; the mathematics stands, four clauses around it do not**

**What is correct.** The definition of $S$; the inequality $S\ge0$ at critical points; the conditional identity $S=\mathop{\mathrm{tr}}(P_{E_-}W_-^\#P_{E_-})=\tfrac12\sum_{i,j}\mu_i\mu_j\lVert P_{E_-}[v_i,v_j]\rVert^2$ under $T_1=T_2=0$; the bilinear expansion; the honest conditionality clause with its $11.5$-against-$\tfrac12$ ratio; the $239$-point count ($209$ at $n=8$ plus $30$ at $n=12$, [ATTEMPTS.md](../ATTEMPTS.md) lines 1148, 1150); the $S=4/7$ non-monotonicity (three points at $0.540$, $0.720$, $0.837$, spread $0.297$); the $(S^m)^3$ refutation of the companion bound. I rebuilt the chain from the definitions and it holds.

**What is defective.**

| # | defect | verdict |
| --- | --- | --- |
| D0 | three pointers to L12, all wrong, none reaching the block | CONFIRMED |
| D1 | *"canonical statement and proof"* over a block with no proof, and no pointer to where one is | CONFIRMED |
| D2 | the two bracket conditions unstated; *"the structured class"* undefined on the whole record | CONFIRMED |
| D3 | provenance: *"only copy"* true, *"moved here"* and *"points here"* false | PARTLY CONFIRMED |
| D4 | L8 cited as a Lemma settling *"the classical families"*, refuted by the same file 19 lines above | CONFIRMED, harmless to L12 |
| D5 | *"the trace lemmas ... continue to hold where the bracket conditions fail"* | **REFUTED**, F1 and F2 are the bracket conditions in trace form ([ATTEMPTS.md](../ATTEMPTS.md) line 1209) |
| D6 | the ceiling $0.9067$ | **REFUTED**, $0.900828$ in nine places, three in this file, one of them the retraction the block narrates |
| D7 | *"the identity ... is now the screen that detects them"* | **REFUTED**, withdrawn at [ATTEMPTS.md](../ATTEMPTS.md) line 1174, and contradicted by the block's own next sentence |
| D8 | headline promises a closed form and delivers the conditional one; the unconditional theorem sits six lines below | CONFIRMED |
| D9 | $S\ge0$ displayed unquantified; no $n$; the class undefined | CONFIRMED |
| D10 | $\delta$, $E_\pm$, $P_{E_-}$ undefined in [findings/](../findings/); three pairings in one display, none declared | CONFIRMED |
| D11 | genuine citation figure: 3 citations, 2 restatements, 0 dependencies | reported |

**The repair, in order of what it costs.** Lead with $S=T_1+2T_2+T_3$ and demote the conditional identity to its $T_1=T_2=0$ case; state the two conditions; delete the $0.9067$ and the screen sentence; fix the three pointers; fix the two provenance clauses; add $\delta$ and $E_\pm$ to [conventions.md](../findings/conventions.md); and either move the chain into [findings/](../findings/) or cite [ATTEMPTS.md](../ATTEMPTS.md) lines 1183-1238 from the heading.

**What is owed after the repair.** *"The structured class"* has to be replaced by a set with a membership test, or the identity has to be stated with its two hypotheses and no class at all. And the record needs one ceiling, not two.
