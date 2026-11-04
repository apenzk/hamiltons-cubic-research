# Review r586, Observation L12 (the ungraded half, measured; slack closed form)

Reviewer r586, independent adversarial audit, cold brief. Analysis only: no computation was run beyond screening, and no screen is cited as evidence for a positive claim.

Verdicts are appended below as they are reached.

## Status

- Report file created before any mathematics. Log at [agent_logs/r586-L12.log](../agent_logs/r586-L12.log).

## What was read, and the block's true boundaries

The block is [findings/ungraded-slack.md](../findings/ungraded-slack.md) lines 285–304, and it has four layers above the prose:

| line | text | what it is |
| --- | --- | --- |
| 285 | `---` | the rule closing [Lemma L58](../findings/ungraded-slack.md) |
| 287 | *Re-filed here 2026-09-02 from [target.md](../findings/target.md) by the parallel sort of findings/* | section provenance, origin **target.md** |
| 289 | `## Observation L12, …` | the `##` section heading |
| 290 | *From findings/target.md. Belongs in ungraded-slack.md because …* | relocation note, origin **target.md** |
| 292 | `#### Observation L12 (…), canonical statement and proof` | the `####` block heading, text differing from line 289 |
| 294 | *Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy. That file now carries the statement and points here.* | provenance, origin **results.md** |

**Two of these name different origins for the same block, and both are true of different moves**, results.md → target.md on 2026-08-31 (commit `a9e4b8c0`), then target.md → ungraded-slack.md on 2026-09-02 (commit `227616f7`). The 2026-08-31 note was never updated for the second move, which is why it says "moved here from results.md" inside a file results.md never held it in.

## Defect 0, the index row, CONFIRMED, and it is three pointers rather than one

| pointer | says | truth |
| --- | --- | --- |
| [INDEX-results.md](../findings/INDEX-results.md) row 12 | [target.md](../findings/target.md) | the block is in [ungraded-slack.md](../findings/ungraded-slack.md) |
| [results.md](../results.md) line 366, `**Proof:**` | [target.md](../findings/target.md) | same |
| [LEDGER.md](../findings/LEDGER.md) line 1467 | [curvature-invariants.md](../findings/curvature-invariants.md) | a file containing no occurrence of `L12` at all |

`grep -c "L12" findings/target.md` is `0` and `grep -c "L12" findings/curvature-invariants.md` is `0`. **Every pointer at Observation L12 outside its own file is stale, and they are stale to two different wrong files.** A fourth, in the same LEDGER sentence's neighbourhood, sends [L132](../findings/ungraded-slack.md) to [second-order.md](../findings/second-order.md) while its block sits twelve lines under L12's in ungraded-slack.md.

**Verdict: CONFIRMED, and widened from one stale pointer to four.**

## Defect 1, the provenance note, checked against `git`. REFUTED in both clauses

*"Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy. That file now carries the statement and points here."*

**The move is real.** `git show a9e4b8c0 -- findings/target.md` appends the block verbatim, and the same commit strips the argument out of results.md, leaving the statement plus a `**Proof:**` pointer. That much survives.

**Clause one ("the argument was the only copy"), is false.** At the parent commit, `git grep -l "opaque residual" a9e4b8c0^` returns **ATTEMPTS.md and results.md**. ATTEMPTS.md at that commit carried the entire derivation under two section headings (*The slack identity, derived) and the grading conditions are not all-or-nothing* and *The slack decomposition (the conditional identity repaired into an unconditional theorem*), with the seven-step chain, the two bracket conditions written out, the refutation, and a strictly stronger unconditional replacement. The block's own headline identity was the second copy, and the stronger one.

**The note asserts something its own commit never checked.** Commit a9e4b8c0's message records the verification as *"all 419 distinctive sentences of the 42 detail entries are recoverable from findings/"* and *"all 582 sentences of the pre-migration file are recoverable from results.md plus findings/"*. Neither test queries ATTEMPTS.md. **The sentence is a boilerplate stamp applied to 42 blocks in one commit, not a per-block finding**, the identical wording appears on [Observation L15](../findings/problem.md) and [Lemma L44](../findings/problem.md) among others.

**Clause two ("That file now carries the statement and points here"), is false as it now stands.** results.md line 366 points at target.md. It pointed correctly for the two days the block lived in target.md and became false at the 2026-09-02 re-file; the note travelled with the block and the pointer did not.

**Verdict: REFUTED, both clauses.** This is the fourth note of this exact form audited on this record and the fourth false, [L34](../findings/stratum-two-negative.md) in one clause, [L5](../findings/graded-half.md), [L4](../findings/ungraded-slack.md) and now L12 in both.

## Defect 2, the guard is never stated, and the record states two different guards for the same numbered result

The block's identity is fenced by *"on the structured class, under two bracket conditions that hold there"*. **Neither the class nor the conditions is named in the block, anywhere in [findings/](../findings/), or in [conventions.md](../findings/conventions.md).** "Structured class" occurs nowhere else on the record as a defined term.

**The conditions, recovered from the derivation.** Writing $W=W_+-W_-$ for the spectral parts, $P_\pm$ the eigenprojections, $\{u_a\}$ an eigenbasis of $E_+$ with $Wu_a=\nu_au_a$ and $\{v_i\}$ one of $E_-$ with $Wv_i=-\mu_iv_i$, all $\nu_a,\mu_i>0$:

$$\textbf{(F1)}\quad [E_+,E_+]\perp E_-,\qquad\qquad \textbf{(F2)}\quad [E_+,E_-]\subseteq E_- .$$

They are exactly $T_1=0$ and $T_2=0$ in the decomposition below, and the count of **two** is right. What is missing is that they are two of the *three* grading conditions, the third being $[E_-,E_-]\perp E_-$, so the fence says "assume all of gradedness except the one clause the slack measures". **Stated that way the identity reads correctly; stated as "a structured class" it reads as a mild regularity hypothesis, which is the misreading the phrasing invites.**

**The identity is not claimed beyond them in the block**, *"the identity itself is conditional on those conditions, not universal"* is explicit and correct. **But [results.md](../results.md) line 366 states the same numbered result with a different guard**: *"which has a closed form on the subalgebra family (Lemma L23)"*.

Both guards are sound, and they are not the same set. For $W_{\mathfrak h}=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ the eigenspaces are $E_+=\mathfrak h$, $E_-=\mathfrak m=\mathfrak h^\perp$ with $\ker W=0$; F1 holds because $\mathfrak h$ is a subalgebra, F2 because ad-invariance of the inner product makes $\mathfrak m$ an $\mathfrak h$-module. So the subalgebra family sits **strictly inside** $\{$F1, F2$\}$, it misses, for instance, the $k\ge3$ sphere products, which have $T_1=T_2=0$ and are not Casimirs, having more than two eigenvalues by this file's own count 20 lines above the block.

**Verdict: REFUTED as stated.** The guard is the whole content and the block names none of it; and the record carries two inequivalent guards for one numbered result, in the block and in the file that states it.

## The closed form, rebuilt from definitions, what each step consumes

Conventions used, each quoted from [conventions.md](../findings/conventions.md) or [problem.md](../findings/problem.md): $Q(W)=W^2+W^\#$; a critical point is $Q(W)=\theta W$ on $\{\lVert W\rVert=1\}$; $W_-:=\tfrac12(\lvert W\rvert-W)\succeq0$; $\mathrm{Alt}$ is the orthogonal projection of $S^2(\Lambda^2)$ onto $\Lambda^4$; $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$; $\#$ is the symmetric bilinear map with $R^\#=R\#R$ and the rank-one law $(uu^{\mathsf T})\#(vv^{\mathsf T})=\tfrac12[u,v][u,v]^{\mathsf T}$.

**Step 1, compress criticality onto $E_-$. Consumes: criticality; that $W$ and $W^2$ preserve $E_-$.** $P_-(W^2+W^\#)P_-=\theta P_-WP_-$, and $P_-WP_-=-W_-$, $P_-W^2P_-=W_-^2$, so
$$\theta\mathop{\mathrm{tr}}(W_-)+\mathop{\mathrm{tr}}(W_-^2)=-\mathop{\mathrm{tr}}(P_-W^\#P_-).$$

**Step 2, the scalar-curvature identity at $W_-$. Consumes: [Observation L15](../findings/problem.md)'s $\mathop{\mathrm{scal}}(R^2+R^\#)=\lVert\mathrm{Ric}(R)\rVert^2+6\lVert\mathrm{Alt}(R)\rVert^2$ with $\mathop{\mathrm{scal}}=2\mathop{\mathrm{tr}}$, valid for every symmetric $R$ and so applicable to $W_-$, which is not Weyl.** This gives
$$\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2=2\mathop{\mathrm{tr}}(W_-^2)+2\mathop{\mathrm{tr}}(W_-^\#).$$

**Step 3, subtract.** $S=2\mathop{\mathrm{tr}}(W_-^2)+2\mathop{\mathrm{tr}}(W_-^\#)+\mathop{\mathrm{tr}}(P_-W^\#P_-)$.

**Step 4, expand $\#$ bilinearly. Consumes: bilinearity alone.** $W^\#=W_+^\#-2\,W_+\#W_-+W_-^\#$.

**Step 5, the two trace lemmas.**
- **(A)** $\mathop{\mathrm{tr}}(W_+^2)+\mathop{\mathrm{tr}}(W_+^\#)=\mathop{\mathrm{tr}}(W_-^2)+\mathop{\mathrm{tr}}(W_-^\#)$. *Consumes: $W$ Weyl.* Apply step 2 to $W_+$ and to $W_-$ separately; the right-hand sides agree because $\mathrm{Ric}(W)=0$ gives $\mathrm{Ric}(W_+)=\mathrm{Ric}(W_-)$ and first Bianchi gives $\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$, both by linearity of $\mathrm{Ric}$ and $\mathrm{Alt}$ on $W=W_+-W_-$.
- **(B)** $\mathop{\mathrm{tr}}(W_-^2)+\mathop{\mathrm{tr}}(W_-^\#)=\mathop{\mathrm{tr}}(W_+\#W_-)$. *Consumes: $W$ Weyl only.* Step 2 at $W$ itself gives $\mathop{\mathrm{tr}}(W^2)+\mathop{\mathrm{tr}}(W^\#)=0$; expanding with step 4 and $W_+W_-=0$ gives $\mathop{\mathrm{tr}}(W_+^2)+\mathop{\mathrm{tr}}(W_-^2)+\mathop{\mathrm{tr}}(W_+^\#)+\mathop{\mathrm{tr}}(W_-^\#)=2\mathop{\mathrm{tr}}(W_+\#W_-)$, and (A) halves it.

**Step 6, assemble.** Substituting (A)+(B) and step 4 into step 3, and using $\mathop{\mathrm{tr}}(X)-\mathop{\mathrm{tr}}(P_-XP_-)=\mathop{\mathrm{tr}}((1-P_-)X(1-P_-))$,
$$S=T_1+2T_2+T_3,\qquad
T_1=\mathop{\mathrm{tr}}(P_-W_+^\#P_-),\quad
T_2=\mathop{\mathrm{tr}}\bigl((1-P_-)(W_+\#W_-)(1-P_-)\bigr),\quad
T_3=\mathop{\mathrm{tr}}(P_-W_-^\#P_-).$$

**Step 7, the rank-one law.** $W_-=\sum_i\mu_iv_iv_i^{\mathsf T}$ gives $T_3=\tfrac12\sum_{i,j}\mu_i\mu_j\lVert P_{E_-}[v_i,v_j]\rVert^2$, and likewise $T_1=\tfrac12\sum_{a,b}\nu_a\nu_b\lVert P_{E_-}[u_a,u_b]\rVert^2$, $T_2=\tfrac12\sum_{a,i}\nu_a\mu_i\lVert(1-P_{E_-})[u_a,v_i]\rVert^2$. **All three are sums of nonnegative terms unconditionally.**

**So $T_1=0\iff$ (F1) and $T_2=0\iff$ (F2)** (each is a positively weighted sum of squared norms) and the block's displayed identity $S=T_3$ is exactly the case $T_1=T_2=0$. **The block's mathematics is correct where it is guarded, and the count of two conditions is right.**

### And the by-product the block does not draw

$S\ge0$, the inequality the block attributes to [Lemma L7](../results.md), falls out of step 6 with **no bracket hypothesis at all**, from positivity of $\#$ on rank-ones. So the same three steps the block cites for its conditional identity prove its unconditional inequality, and the block presents the two as separate results, one of them borrowed.

## Defect 3, the closed form on the record is unconditional, and it is twelve lines below the block

$S=T_1+2T_2+T_3$ holds **at every critical point with no hypotheses whatever**. It is in [ATTEMPTS.md](../ATTEMPTS.md) under *The slack decomposition, the conditional identity repaired into an unconditional theorem*, it passed Gate 2 (Reviewer 12), and it was strengthened there: (A) and (B) are identities of the whole Weyl space, and the theorem is equivalent to the single identity $S-(T_1+2T_2+T_3)=-\mathop{\mathrm{tr}}(P_-(Q(W)-\theta W)P_-)$.

**The block's own file records this twelve lines below it.** [Lemma L132](../findings/ungraded-slack.md), the WITHDRAWN block at line 305, says in its first paragraph that ATTEMPTS.md's decomposition *"is that replacement, and it is stronger"*, gives $S\ge\tfrac12G_1$ with equality iff F1 and F2, and names the two bracket conditions **that L12 twelve lines above declines to name**.

**And [report/](../report/) is ahead of the block too.** [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) prints Obs 12 and then a `certificate` environment carrying the unconditional decomposition, the two upgrades, and *"Safe to treat as settled"*.

**So the headline (*"its slack has a closed form"*), is true and understated.** The slack has an *unconditional* closed form; L12 states a conditional special case of it, fenced by conditions it does not name, in a file that carries the unconditional one, under a report section that already prints it.

**Verdict: REPAIRED is available and REFUTED-as-stated is the honest label for the headline.** The identity displayed is correct; the claim that this is what the record knows about the slack's closed form is false, and the refuting statement shares nothing with the block's route beyond the two lemmas it already cites.

## Defect 4, L8 is cited as a Lemma and it is a refuted Conjecture

The block's first sentence: *"Lemma L8 settles the equality side across the classical families, scoped to the balanced splits, the only ones the sweep behind it evaluated."*

[INDEX-results.md](../findings/INDEX-results.md) row 8 reads **Conjecture**, and: *"Gate 2: REFUTED, both reviewers, by different routes ([r503](REVIEW_r503.md), [r504](REVIEW_r504.md)). **Downgraded from Lemma** … the sweep behind *settled across the classical families* rejected every unbalanced split before evaluating it."*

Three separate things go wrong in one clause:

| the block says | the record says |
| --- | --- |
| "**Lemma** L8" | Conjecture 8, downgraded from Lemma at Gate 2 |
| "**settles** the equality side" | the settling claim is the refuted one, verbatim |
| "across the classical families" | the phrase the refutation names |

**The scope note is a genuine repair and it is attached to the wrong sentence.** Appending *"scoped to the balanced splits"* fixes the reach; it leaves the label and the verb standing, so the sentence now reads "a Lemma settles it, restricted". The honest form is that Conjecture 8 is refuted as stated and what survives is the formula on balanced splits.

**Does L12 stay inside L8's scope?** Yes, vacuously, **L12 takes nothing from L8**. L8 appears only in the framing sentence to say what the *equality* side is; every displayed claim of L12 is about the strict side and is derived from L7, the scal identity and $\#$-bilinearity. **If L8 vanished, L12 would be unchanged.** So the dependency is decorative, and the cost of the error is a reader importing a refuted result's authority into the block's opening.

**Verdict: REFUTED as written; no propagation into L12's mathematics.** Owed: the label, the verb, and the citation form.

## Defect 5, "confirmed precisely because they continue to hold where the bracket conditions fail"

Tested against the source. [ATTEMPTS.md](../ATTEMPTS.md) reads: *"Chain steps 1–4 and 7 and the lemmas (A) and (B) are **confirmed as genuine, non-circular theorems**, they hold at $10^{-15}$ including at points where F1/F2 fail, **which is what rules out circularity**."*

**The block turns a non-circularity argument into a confirmation argument, and they are different claims.** Persistence off F1/F2 shows the lemmas are not covert restatements of F1/F2; it is silent on whether they are true. What makes (A) and (B) theorems is that both have hand proofs, reproduced above in step 5, each consuming only that $W$ is Weyl. **"Confirmed precisely because" inverts the evidential order**: the proofs confirm, the persistence de-circularises.

**Three further ways the sentence is incomplete.**

1. **"Independently confirmed" is numerical.** The confirmation cited is machine verification at $10^{-15}$ at ten points; the analytic proofs are what carry the word "theorem", and the block credits the wrong one.
2. **It understates its own subject.** The same two lemmas yield the unconditional $S=T_1+2T_2+T_3$. Calling them "supporting" for a conditional identity is a description of what they were used for on 2026-08-31, not of what they were shown to give.
3. **The strengthening is missing.** Reviewer 12 lifted (A) and (B) to identities of the whole Weyl space rather than of critical points. The block still frames them as facts about critical points.

**Verdict: REFUTED as a piece of reasoning; the underlying lemmas are sound.** Eight for eight now, on hedging and scope claims audited on this record.

## Defect 6, the quantifier on $S\ge0$

The display is
$$S(W):=\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2-\theta\mathop{\mathrm{tr}}(W_-)-\mathop{\mathrm{tr}}(W_-^2)\;\ge\;0$$
with $W$ free and no hypothesis attached to the inequality sign.

**Read as printed it is false, and the record holds the witness.** $\theta$ is only defined as $P(W)/\lVert W\rVert^3$, so the expression is defined for every unit Weyl $W$; and [ATTEMPTS.md](../ATTEMPTS.md)'s (GC) section records *"Criticality is genuinely load-bearing: off the critical set the margin runs to $-0.18$ under directed minimization at $n=6$."* The preceding sentence mentions critical points, so context supplies the hypothesis to a careful reader, **but the block is the canonical statement, and the canonical statement of an inequality carries its hypothesis on the line.**

**The class and the $n$.** Neither is stated. The correct reading, recovered from the derivation: **for every $n\ge4$ and every critical point of $P$ on the unit sphere of $\mathcal W_n$**, $S\ge0$; and $S=T_3$ additionally on $\{$F1, F2$\}$. **The closed-form clause is on the structured class only, and $S\ge0$ is general over critical points**, the block's grammar puts them on the same footing.

**Verdict: REFUTED as printed; REPAIRED by moving "at every critical point" onto the display.**

## Defect 7, the norm, and what the block leans on that has no definition

Checked against [conventions.md](../findings/conventions.md), which is explicit that *definitions and conventions are quoted, never restated*, and which warns that **the $\Lambda^2$ and $n\times n$ Frobenius pairings differ by a factor $2$** and that *applying the $\tfrac12$ at the operator level instead inflates every $\theta$ by $\sqrt2$*. **The block quotes conventions.md nowhere.**

| symbol | status |
| --- | --- |
| $S(W)$ | tabled in conventions.md, as *"the gradedness slack"*, defined **by pointing back at this file**. The definition is circular between the two files, and the block restates rather than quotes it |
| $W_-$ | tabled: $W_-:=\tfrac12(\lvert W\rvert-W)\succeq0$, with the sign called *forced by the rest of the record*. **Correct in the block** and consistent with $Wv_i=-\mu_iv_i$, $\mu_i>0$ |
| $\delta$ | **absent from conventions.md.** Defined in [problem.md](../findings/problem.md) as $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$, from Observation L15. conventions.md tables $\Delta$, a different object |
| $E_-$ | **absent from conventions.md and from the block.** conventions.md tables $\mathfrak m$ for $E_{\min}$ at a critical point and warns that $\mathfrak m$ carries a second sense, *"[L36](../findings/isotropy-cap.md)'s whole negative eigenspace"*, which is what $E_-$ is here. Whether $\ker W$ joins $E_-$ is exactly what the block's own kernel-contamination paragraph turns on, and it is left to the reader |
| $\mu_i$ | **a fourth sense of $\mu$, undeclared.** conventions.md already flags three, *"$\mu$ carries two meanings thirty lines apart in [bispectral.md](../findings/bispectral.md), and a third in [target.md](../findings/target.md)"*. Here it is the positive spectrum of $W_-$ |
| $\lVert\mathrm{Ric}(W_-)\rVert$ | **the norm is never named**, and $\mathrm{Ric}$ is not in conventions.md. It is pinned only implicitly, by the scal identity of Observation L15 with $\mathop{\mathrm{scal}}=2\mathop{\mathrm{tr}}$; the record's own factor-$2$ trap between the two Frobenius pairings is live exactly here |
| $\mathop{\mathrm{tr}}$ | the level ($\Lambda^2$ operator) is inferable and unstated |
| $\#$ | normalisation fixed only by the rank-one law, which the block does not print |

**One convention the block is obliged to read and does not.** conventions.md's $S(W)$ row says ***"Read [W4](../findings/INDEX-traps.md) before using it: the screen is vacuous when $\ker W\ne0$."*** W4: *"it traces only over $E_\pm$, so a point whose kernel carries most of $\mathfrak{so}(n)$ reports $S=0$ while admitting no grading; padded $W_{\mathbb{CP}^2}$ has kernel $63$ of $66$ at $n=12$."*

The block's gap paragraph is a census over 239 points screened by $S$, and it discusses a **different** kernel failure, near-zero eigenvalues sorted into $E_\pm$ by sign. **W4's failure mode, $S=0$ reported at a genuinely large kernel, is not mentioned**, though [Lemma L23](../findings/ungraded-slack.md)'s block 20 lines above in the same file withdraws a witness on exactly that ground.

**Verdict: REFUTED on the conventions obligation.** The mathematics survives under the record's own normalisations; the block discharges none of them explicitly and skips the one trap conventions.md names as a precondition of using $S$.

## Defect 8, the heading promises a proof, and the block is an ingredient list

Heading at line 292: *"Observation L12 (the ungraded half, measured) and its slack has a closed form, **canonical statement and proof**"*. Clause by clause:

| clause | proved, or measured |
| --- | --- |
| L7 splits the critical points by equality in its inequality | **definitional**, and correct |
| "Lemma L8 settles the equality side across the classical families" | **refuted**, Defect 4 |
| $S(W):=\dots\ge0$ | **a theorem at critical points**, proved elsewhere ([L7](../results.md)); no proof here, and no hypothesis on the line |
| $S=\mathop{\mathrm{tr}}(P_{E_-}W_-^\#P_{E_-})=\tfrac12\sum\mu_i\mu_j\lVert P_{E_-}[v_i,v_j]\rVert^2$ | **a theorem on $\{$F1, F2$\}$**, and the block gives **no proof**, *"Compressing …, applying …, and expanding … reduces it"* names three ingredients and derives nothing |
| "the supporting trace lemmas are genuine theorems …" | **refuted as reasoning**, Defect 5 |
| the gap: 239 points, ceiling $0.9067$, 380 points, the screen story | **measured throughout** |
| the $(S^m)^3$ refutation of the companion bound | **proved**, and it is the one derivation in the block: $\mathrm{RHS}=\theta(4m-1)/(3m-1)$ with $\theta^2=(3m-1)(m-1)/(3m^2)$, closed forms, limit $4/3$ |

**So one of seven clauses is proved in the block, and it is a refutation of something else.** This is the same defect [INDEX-results.md](../findings/INDEX-results.md) records against [L7](../results.md) (*"the block having carried an ingredient list under a *canonical statement and proof* heading"*) and against [L25](../findings/second-order.md), refuted on the identical mismatch.

**A downgrade is not available here and is not the repair.** The label is already `Observation`, and `Observation` is the right label for the census. **What is owed if "and proof" comes off the heading**: the closed form then has **no proof anywhere in [findings/](../findings/)**, its only derivation on the record is in [ATTEMPTS.md](../ATTEMPTS.md), which [INDEX-results.md](../findings/INDEX-results.md)'s own preamble excludes from the numbering (*"a number is assigned when a result gets a `#### Lemma N` block in findings/"*). **The obligation is a transcription, and it should transcribe the unconditional form**, steps 1–7 above are eleven lines and prove strictly more than the block claims.

**Verdict: REFUTED.** The heading promises a proof the block does not contain.

## Defect 9, what cites it, and the genuine figure

Counted over [findings/](../findings/), [results.md](../results.md) and [report/](../report/) only, discounting the block's own two headings and its `#L12` anchors.

| site | what it says | inside L12's hypotheses? |
| --- | --- | --- |
| [results.md](../results.md) line 68 | *"the carrier inequality of Observation L12 fails to separate"* | **yes**, the block says the same |
| [results.md](../results.md) line 132 | *"its carrier inequality holds but does not separate … $(S^m)^3$ … drives its bound to $4/3$"* | **yes** |
| [results.md](../results.md) line 364–366 | the numbered statement plus `**Proof:**` pointer | **no**, it states the closed form under the *subalgebra family* guard, a different set (Defect 2), and points at the wrong file (Defect 0) |
| [LEDGER.md](../findings/LEDGER.md) line 1467 | lists L12 among *"the other Observations carrying Lemmas"* | **unverifiable**, the pointer is to a file with no L12, and the same paragraph's two sentences above disclose that the list was *"built on the scanner without reading the blocks"* and that the scanner's `check_f` over-reaches block boundaries |

[report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 288 **restates** L12 as `\begin{Obs}{12}` rather than citing it, so it is not counted as a use.

**The genuine figure is three citing sites**, two in results.md's glance list, one in LEDGER.md, **plus the results.md statement of the result itself. Two of the four are defective**, and neither defect is in the mathematics.

**One downstream inconsistency worth recording.** The block's ceiling is $0.9067$; [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) carries **both** figures, $0.900828$ at line 285 and $0.9067$ at line 337, fifty-two lines apart in one section. L12's number matches the later audit and the block hedges it correctly as *"observational, not structural"*; the report does not reconcile them.

## Defect 10, what the record already knew, on the guard results.md actually states

On the subalgebra family, results.md's stated guard, the block's closed form **is Lemma L23's $S_{\mathfrak{mmm}}$, rescaled**, and L23's block sits 165 lines above it in the same file.

For $W_{\mathfrak h}$ the negative spectrum is constant, $\mu_i=\mu=cr/N$ for all $i$, and $E_-=\mathfrak m$, so

$$T_3=\tfrac12\sum_{i,j\in\mathfrak m}\mu^2\lVert P_{\mathfrak m}[v_i,v_j]\rVert^2=\tfrac{\mu^2}2\sum_{i,j,k\in\mathfrak m}\langle[v_i,v_j],v_k\rangle^2=\tfrac{\mu^2}2\,S_{\mathfrak{mmm}},$$

and [Lemma L23](../findings/ungraded-slack.md) evaluates $S_{\mathfrak{mmm}}=(N-r)\bigl[2(n-2)-\tfrac{4(n-1)r}N\bigr]$ **in closed form in $n$, $r$ and $N$ alone**. So under results.md's guard the "closed form" L12 offers is a bracket sum that the same file already reduces to three integers, and L23 is a proven Lemma with Gate 2 behind it, where L12 is an Observation.

**On the block's own wider guard the record is also ahead**: [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) gives the multi-block sphere products, which satisfy F1 and F2, an explicit $S=3\theta^2e_3(n_1,\dots,n_k)/(n-1)^2$, verified symbolically.

**Verdict: the closed form is correct and is the least explicit of the three the record holds for the class it is stated on.**

## Overall verdict, REFUTED as stated, REPAIRABLE, and the mathematics survives

**The two displayed formulas are correct.** $S\ge0$ at every critical point and $S=\tfrac12\sum_{i,j}\mu_i\mu_j\lVert P_{E_-}[v_i,v_j]\rVert^2$ under (F1) and (F2) both rebuild from the definitions in the eleven lines above, and the count of two bracket conditions is right. **Nothing in this audit touches them.**

**What is refuted is the block around them.**

| # | defect | verdict |
| --- | --- | --- |
| 0 | every external pointer at L12 is stale, to two different wrong files, and a fourth sends L132 wrong too | **CONFIRMED**, widened |
| 1 | *"the argument was the only copy"*, ATTEMPTS.md held it, and held the stronger form; *"points here"*, results.md points at target.md | **REFUTED**, both clauses |
| 2 | the guard is the whole content and is named nowhere; results.md states a different, narrower guard for the same result | **REFUTED as stated** |
| 3 | the closed form on the record is unconditional, in the same file twelve lines below and in the report | **REFUTED as the state of knowledge** |
| 4 | "Lemma L8 settles the equality side", Conjecture 8, refuted, downgraded | **REFUTED**; no propagation, L12 takes nothing from L8 |
| 5 | *"confirmed precisely because they continue to hold where the bracket conditions fail"* inverts confirmation and non-circularity | **REFUTED as reasoning**; lemmas sound |
| 6 | $S\ge0$ printed with $W$ free; false off the critical set, by the record's own witness | **REFUTED as printed** |
| 7 | $\delta$, $E_-$, $\mu_i$, $\mathrm{Ric}$ and the norm undischarged; trap W4 unread | **REFUTED on the conventions obligation** |
| 8 | *"canonical statement and proof"* over an ingredient list, one of seven clauses proved, and it a refutation of something else | **REFUTED** |
| 9 | three genuine citing sites plus the statement; two of the four defective | **CONFIRMED** as a count |
| 10 | on results.md's guard the closed form is L23's $S_{\mathfrak{mmm}}$ rescaled, 165 lines above | **CONFIRMED** |

### The repair, and what it owes

1. **Point the three pointers at [ungraded-slack.md](../findings/ungraded-slack.md)**, INDEX-results.md row 12, results.md's `**Proof:**` line, LEDGER.md line 1467, and L132's alongside.
2. **Replace the conditional identity with the unconditional decomposition**, transcribing steps 1–7 above into the block. It is shorter than the paragraph it replaces, proves $S\ge0$ on the way, and recovers the block's display as the case $T_1=T_2=0$.
3. **Name (F1) and (F2) on the line**, and retire *"the structured class"*, which denotes nothing on the record.
4. **Put "at every critical point" on the inequality**, and reconcile results.md's guard with the block's.
5. **Rewrite the L8 clause** as Conjecture 8, refuted as stated, surviving on balanced splits, or drop it, since L12 does not use it.
6. **Rewrite the hedge** as: (A) and (B) are theorems because they are proved from Weyl-ness alone, and their persistence where F1/F2 fail is what rules out circularity.
7. **Quote [conventions.md](../findings/conventions.md)** for $W_-$, $\mathrm{Alt}$, the pairing and the ordered-pair convention; **add $\delta$, $E_-$ and $\mu_i$'s fourth sense to it**; and **read trap W4** into the census paragraph.
8. **Owed if "and proof" is struck instead of the proof supplied**: the closed form has no derivation anywhere in [findings/](../findings/), and by INDEX-results.md's own rule ATTEMPTS.md cannot carry a numbered result's proof.

### Analysis-only compliance

**No computation was run.** Every check in this report is a `git` or `grep` retrieval, a hand derivation, or a reading of the record. The two spot checks that could have gone to a machine, that $T_3$ specialises to $S_{\mathfrak{mmm}}$ on the subalgebra family, and that $\theta$'s multi-block closed form is consistent with the block's $(S^m)^3$ figures, were done by hand and are recorded as derivations.
