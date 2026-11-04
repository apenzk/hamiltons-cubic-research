# ROUND_L44, $n\ge12$ is necessary, not merely sufficient

**Date:** 2026-09-07. **Phase:** 6, closed. **Verdict:** `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED`. **Verifiers:** v188, v189, v190.

## Sources, verbatim

| what | where |
|---|---|
| Canonical statement | [results.md](../results.md) lines 280–284 |
| Landscape statement | [results.md](../results.md) line 102 |
| The block | [problem.md](../findings/problem.md) lines 207–**219**, *the brief said 217, cutting off the Attribution paragraph, which carries the Xu claim this round was convened to test. A verifier read past it anyway* |
| Brief | [BRIEF_L44.md](BRIEF_L44.md) |

## Findings from phase 0

**1. The heading contradicts the lemma, and the block says so about itself.** *"The heading's 'not merely sufficient' presupposes sufficiency, which is the open conjecture."* **Both files still carry that heading**, with the guard only in the body, so a reader scanning headings takes away the presupposition and a reader of the body takes away its denial.

**2. The heading is malformed in the same way [L47](../findings/problem.md)'s was**: `Lemma L44 ((…) · (D)), canonical statement and proof`. *Two such headings survive in that one file, and the index inherited the garbling at L47.*

**3. A citation the reference folder cannot check.** The block states plainly that Xu's (3.1)–(3.4) *"are verified against the stored full text rather than against [the notes](../references/xu-2024-ricci-flow-invariant-conditions/notes.md), which do not carry those equations"*, **so the notes a reader opens do not hold the equations the argument cites.**

**4. A direction supplied in prose rather than in lines.** The argument needs *invariance $\Rightarrow G\le0$* where [Beitz](../references/beitz-2018-bianchi-convexity/notes.md)'s Lemma 2.3.4 gives only the converse; the block says it *"holds in two lines, by evaluating the flow's normal component at the boundary point, and is now stated rather than assumed"*, **and what stands is that sentence, not the two lines.**

## What the verifiers are asked beyond the standing list

Whether padded $W_{\mathbb{CP}^2}$ really is critical at every $n\ge4$ with $\theta=\sqrt{3/2}$; whether $cI+W$ at the pinned $c$ lies on $\partial\Omega_0$ **and the Weyl tensor itself does not**, $\mathrm{ric}=0$ being where $F$ blows up; whether [L43](../results.md)'s collapse to $\theta_0(n)$ is the block's only step and is right; whether the criterion demands $\theta_0(n)$ at **both** parities, with $\Theta_n$ what the diagonal locus attains rather than what the criterion demands; and whether the elementary route really needs no cone theory, *the two polynomials $n^2-12n+8$ and $n^2-13n+18$ giving the same integer threshold from different roots, $6+2\sqrt7\approx11.29$ against $\tfrac{13+\sqrt{97}}2\approx11.42$.*

## Clustering, all three in; **the debt was not a debt**

**`PROVEN, hypotheses corrected`.** *The mathematics stands at every step; the defects are in the block's account of itself.*

**Rebuilt clean, and in two places more strongly than the block claims.** The witness comes from the $\mathfrak{so}(4)$ structure constants with **$W\#I=-W$ forcing $\kappa^2=2$ (no free normalisation**), giving $Q(W)=\sqrt{3/2}\,W$ exactly at $(2,-1,-1)/\sqrt6$. *$W\#I_n=-W$ on the padded block holds **only because $\mathop{\mathrm{tr}}W^+=0$***, each $\rho(f_a)^2=-\tfrac12I_4$ collapsing the sum on $\sum_aw_a=0$. **The pinned $c$ is cross-checked by an independent route**, $F(cI+W)=\tfrac4{n-2}$ being Beitz's own $a=0$ threshold. **And the Weyl tensor is not merely off $\partial\Omega_0$, it is outside $\overline{\Omega_0}$.** [L43](../results.md)'s collapse rebuilds cold with no residue; the parity repair is correct and load-bearing, nothing from $\lVert I\rVert^2=\binom n2$ to $c(n-1)$ seeing parity.

**And the elementary route's real content is sharper than stated**: *both roots lie in $(11,12)$*, $11<11.2915<11.4244<12$, which is what forces the threshold, **"no integer between them" being the weaker fact.**

**Two confirmations the block does not claim.** The structure constants were cross-checked against [L31](../findings/stratum-two-negative.md)'s pair cap and [L153](../findings/bounds.md)'s row marginal; and *the Weyl tensor is off the boundary for three reasons, of which the block gives one.* **The block's use of $\mathop{\mathrm{scal}}(Q(W))=0$ rather than the full $\mathrm{ric}(Q(W))=0$ is correct**, $\mathrm{ric}(I)$ being a metric multiple. **And the Beitz characterisation is accurate**, its notes do give Lemma 2.3.4 in sufficiency only.

| id | finding | support |
|---|---|---|
| **Q1** | *"[L43](../results.md) is the block's only step"* is **false, and self-contradicted two sentences later**, a second input is named there and **four more are used silently** | v188, v189 |
| **Q2**, **THE DEBT, AND IT IS CONFINED** | ***Invariance $\Rightarrow G\le0$ has no proof on any canonical page.*** Its promised "two lines" exist only in [reviews/](../reviews/), and the statement is **Xu's Proposition 2.2, an *iff*, in the stored full text, uncited by both [L43](../results.md) and L44 and absent from the Xu notes.** *The debt sits in the cone clause alone: **the elementary route carries the headline on its own**, needing no cone theory* | v188, v189 |
| **Q3** | **an inherited defect, refuted once and never corrected**: [problem.md](../findings/problem.md) justifies that direction by $\tfrac{d}{dt}\mathop{\mathrm{scal}}=2\lVert\mathop{\mathrm{ric}}\rVert^2>0$, **which constrains $\mathop{\mathrm{scal}}$ where the claim is about $F$.** *[r92](../reviews/REVIEW_r92.md) refuted it and it stands* | v188, v189 |
| **Q7** | **the Xu notes drop the $\tfrac14$ from Conjecture 1 (1.1)**, *the dropped-denominator extraction failure this record warns about by name.* Harmless to L44 and a defect in the reference folder | v188 |
| **Q8** | Xu's Proposition 2.2 needs $C$ **closed** convex, and $\Omega_0$ carries an **open** $\mathop{\mathrm{scal}}>0$ clause, *so discharging Q2 by citing it owes both the convexity and the closedness* | v188, v189 |
| **Q4** | *"a rational function of $n$"* describes $\theta_0(n)^2$, **$\theta_0(11)=6\sqrt5/11$ is irrational** | v188, v189 |
| **Q5** | **$\lVert W\rVert=1$ is dropped**, without which $\langle W,Q(W)\rangle\le c(n-1)$ is not homogeneous | v189 |
| **Q6** | **what the Xu notes can and cannot check**: a consumer can verify H9/H10 from Proposition 2.7(3),(4), quoted there, and **cannot verify (3.1)–(3.4), Lemma 2.8's (2.34), or Proposition 2.2**, *and Prop 2.2 is the one theorem that would discharge Q2's debt.* All four verify in the stored full text | v189 |

**A latent condition, harmless now.** *Xu's Proposition 2.2 requires $C$ closed **convex**, and no file checks convexity of $\Omega_0$.* The record cites Prop 2.2 nowhere and the elementary argument needs no convexity, **but any repair that discharges Q2 by citing Prop 2.2 would owe that check.**

## Adjudication

**Verdict `PROVEN, hypotheses corrected`, repaired. Impact `CONTAINED`.** *The mathematics is right at every step three verifiers could rebuild, and **the debt two of them booked does not exist.***

### The finding of the round: a biconditional paraphrased one way

**The block recorded that [Beitz](../references/beitz-2018-bianchi-convexity/notes.md)'s Lemma 2.3.4 supplies only the converse of what it needs. That is backwards.** At source the lemma opens

> *"If the sublevel sets of $F$ are invariant under (2.2), then for all $v\in C$ we have that $dF_v(\Phi(v))\le0$."*

**which is exactly *invariance $\Rightarrow G\le0$***, the converse following after. Its four hypotheses ($V$ a vector space, $\Phi$ locally Lipschitz, **$C$ open**, $F$ smooth), all check against $Q$, $\{\mathop{\mathrm{scal}}>0\}$ and $F$. **The direction is cited, not owed.** *Verified at source in this round before landing.*

**And the root cause is the record's own reference note**, which paraphrases a two-directional lemma one-directionally. **That paraphrase misled the block, and it misled a verifier of this round**, who read the notes and reported the block's characterisation as accurate, while the verifier who read the source refuted it. *The rule that search-tool prose is a lead and never a citation applies to a record's own notes.*

**The openness of $C$ is why this route is available at all.** Xu's Proposition 2.2 states the same direction as an *iff* but needs $C$ **closed convex**, which collides with $\Omega_0$'s open $\mathop{\mathrm{scal}}>0$ clause, *so the repair that looked available was the one that would have owed two unchecked conditions, and the repair that works needs none.*

### The repairs, all applied

| finding | what changed |
|---|---|
| Q2 | the Beitz direction quoted from source with its four hypotheses, **and the notes repaired at the root**, the biconditional stated in both clauses, with the openness of $C$ flagged as what makes it usable |
| Q3 | the $\tfrac{d}{dt}\mathop{\mathrm{scal}}$ justification **withdrawn**, it constrains $\mathop{\mathrm{scal}}$ where the claim is about $F$; [r91](../reviews/REVIEW_r91.md) and [r92](../reviews/REVIEW_r92.md) refuted it and it stood |
| the heading | *"not merely sufficient"* presupposed the open conjecture and is gone from both files; the malformed `· (D)` with it |
| Q1 | the only **cited** step, with three further inputs named and the collapse recorded as an identity on the whole Einstein slice |
| Q4, Q5 | $\theta_0(n)^2$ is what is rational, $\theta_0(11)=6\sqrt5/11$; and $\lVert W\rVert=1$ restored, without which the criterion is not homogeneous |
| Q8, new | $\mathrm{ric}(I)=\tfrac{n-1}2\mathrm{id}$ and the $\tfrac4{n-2}$ threshold tabled in [conventions.md](../findings/conventions.md), **with the Beitz–Xu factor of $4$ recorded as cancelling** so a reader does not read it as a discrepancy |
| strengthenings | the Weyl tensor is outside $\overline{\Omega_0}$, three ways where the block gave one; the pinned $c$ confirmed by $F(cI+W)=\tfrac4{n-2}$; and **both roots in $(11,12)$**, which is what forces the threshold |

### What remains, and it is small

**The Xu notes drop the $\tfrac14$ from Conjecture 1**, the dropped-denominator extraction failure this record warns about by name. *Harmless to L44 and a defect in the reference folder.* **And criticality of the witness is stated and never used**, *"critical point of $\mathcal W_n$" being a category error besides.*
