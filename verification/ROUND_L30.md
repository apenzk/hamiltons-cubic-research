# Round L30, a small negative eigenspace forces a small support

**Id:** L30 · **Date:** 2026-09-07 · **Verifiers:** v209, v210, v211 · **Brief:** [BRIEF_L30.md](BRIEF_L30.md)

## Sources, verbatim

| passage | source |
|---|---|
| the canonical entry | [results.md](../results.md) lines 461-465 |
| the landscape statement | [results.md](../results.md) line 146 |
| the block | [findings/stratum-two-negative.md](../findings/stratum-two-negative.md) lines 214-241 |

## The findings from phase 0

**This block is a partial repair, which is a shape the audit has not met before.** Some annotation content reached the prose (*the proof now carries the $\lambda_\alpha\ne0$ qualifier and its kernel witness*) while four blockquotes still stand above it correcting clauses that were left as they were. **So the block has been half-fixed, and a reader cannot tell which half.**

**The prose still says "Gate 2 passed" while an annotation says that clause was contradicted by the index's own row.** *The brief carries both, because a self-contradicting provenance claim is the round's material rather than something to redact around.*

**Three defects the annotations name and the prose does not carry.** *"At most two"* is said to be inert, the argument going through for any number of negative eigenvalues under $U:=\sum_{\lambda_\alpha<0}\mathop{\mathrm{im}}v_\alpha$; *"with the same norm and the same $\theta$"* is said to be asserted and never proved, **and it is the clause the lemma exists for**, since it is what lets a bound at $\dim U$ govern every $n$; and the scope is given three ways ($6,7,8$ in the block, *"below $n=9$"* thirty-four lines above, and $5,6,7,8$ in an annotation), **each with one endpoint wrong.**

## What the verifiers are asked beyond the standing list

Whether Ricci-flatness really is the identity $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=0$ and whether the step from it to $\mathop{\mathrm{im}}\subseteq U$ is sound; whether *"at most two"* is used anywhere but in defining $U$; **whether the norm and $\theta$ are preserved under the padding, and by what argument**; whether the restriction to $\Lambda^2(U)$ is Ricci-flat for the reason given; and **which scope is right, endpoint by endpoint, at $n=4$ and at $n=5$.**

**And the standing question**: [L34](../findings/stratum-two-negative.md) and the padding reduction below this block both consume it, say what each may cite, and whether the $\theta$-preservation clause is what they need.

## Adjudication

**Verdicts: [v209](VERIFY_v209.md) `HYPOTHESIS-DEBT`, [v210](VERIFY_v210.md) `HYPOTHESIS-DEBT`, [v211](VERIFY_v211.md) `GAP`. Round verdict: `HYPOTHESIS-DEBT`, repaired, impact `NARROWS`.** One verifier put it best in a line: **the statement is true in every clause, and the proof on file establishes every clause except the one the lemma exists for.**

**The four proof steps hold and were derived three times.** The Ricci identity $\mathrm{Ric}(W)(x,x)=\sum_\alpha\lambda_\alpha\lVert v_\alpha x\rVert^2$, exact in the record's half-trace pairing and cross-checked at $W=\mathrm{Id}$ where both sides read $n-1$; the two sides of the flatness identity coinciding, with image **equal to** $U$ rather than merely contained in it; the descent to $W(u\wedge w)=0$; and the restriction's Ricci-flatness, whose one-line reason is the right one.

| id | step attacked | mechanism | support | outcome |
|---|---|---|---|---|
| **C1** | the Ricci identity and the image step | independent re-derivation | 3/3 | `CONFIRMED` |
| **C2** | *"with the same norm and the same $\theta$"* | asserted; no argument in the block or anywhere in [findings/](../findings/) | 3/3 | **`HYPOTHESIS-DEBT`**, filed |
| **C3** | *"at most two negative eigenvalues"* | inert to the steps, load-bearing to the statement | 3/3 | `CONFIRMED`, statement restated on $U$ |
| **C4** | the *"two distinct"* reading | a four-negative witness on $\mathbb R^8$ | 3/3 | **`REFUTED`**, the reading breaks the lemma |
| **C5** | the *"at most"* reading at one negative eigenvalue | $\dim U$ not a function of $W$ | 1/3 | `CONFIRMED`, second failure of the same kind |
| **C6** | membership in $\mathrm{Weyl}_{\dim U}$ | pair symmetry and first Bianchi inherited, not shown | 1/3 | `GAP`, recorded |
| **C7** | the scope | three versions, each one endpoint wrong | 3/3 | `CONFIRMED`, $n=5\ldots8$, and see below |
| **C8** | the kernel witness | holds at $u=e_9$, no failure at $u=e_5$ | 1/3 | `CONFIRMED`, the witness now names its $u$ |
| **C9** | the normalisation | $\mathrm{Ric}(\mathrm{Id})=(n-1)$ against the tabled $\tfrac{n-1}2$ | 1/3 | `CONFIRMED`, inert here, stated |

### C2, and the debt has three carriers that each point at another

**Nothing on the record proves it.** Its carriers are an uncited bullet in [conventions.md](../findings/conventions.md), one structural sentence in a review, and [lean/INDEX.md](../lean/INDEX.md) marking the row **partial** with this same line owed. *So each site rests on another and none carries an argument*; the conventions bullet has been rewritten to say the clause is owed rather than to assert it. **All three verifiers named the same closure and none attempted it**, which is the loop working: four sub-statements, of which $\Lambda^2U=\mathfrak{so}(U)$ being a Lie subalgebra reaches exactly one, the $\#$ term. *The norm and the $W^2$ term are isometry and support claims, not bracket claims.* **And the bullet asserted more than the lemma needs**: $\theta$ requires only the scalar $\langle W,Q(W)\rangle$ to agree, where the bullet claimed $Q$ commutes with padding as operators.

### C3, C4 and C5, the counting hypothesis was the defect, not the abbreviation

**Three verifiers confirmed the $\mathbb R^8$ witness independently**: $\mathrm{pad}_{V_1}(W_{\mathbb{CP}^2})+\mathrm{pad}_{V_2}(W_{\mathbb{CP}^2})$ lies in $\mathrm{Weyl}_8$, has one distinct negative eigenvalue of multiplicity four, satisfies *"at most two distinct"*, and has $W(e_5\wedge e_6)\ne0$ at $e_5\perp U$. **And one found the other end**: read as *"at most"*, a single negative eigenvalue leaves $U$ built partly from an undetermined kernel eigenvector, so $\dim U$ is not a function of $W$. *Both failures are of the counting form and neither touches the argument.* **The statement now hypothesises $\dim U<n$ with $U=\sum_{\lambda_\alpha<0}\mathop{\mathrm{im}}v_\alpha$ and counts nothing**, which is what the block's own three steps prove, restated rather than extended.

### C7, and the scope was being read as the lemma's range

**The window $n=5,6,7,8$ belongs to the rank-sum form**, not to L30. At $n=4$ the $\Lambda^\pm$ splitting forces $\dim U=4=n$ for every $W\ne0$, so the hypothesis is unsatisfiable; $n=5$ is genuinely inside and the block omitted it. **The index row stated it flatly as "Scope is $n=5\ldots8$", which reads as the lemma's range and would gut it, L30 is consumed at $n=12$.** *That row is rewritten.* One verifier also notes the development sentence's *"below $n=9$"* is not wrong at $n=4$ so much as vacuous there, which is why the earlier annotation's word *"wrongly"* was a shade strong.

### What is not repaired here

**C2 is the research loop's and is filed in [plan.md](../plan.md)**, with its four sub-statements named. **C6 is filed with it**: pair symmetry and first Bianchi are inherited by the restriction rather than shown, and the review this block was written from carried the sentence that would do it.

### The block's shape, which phase 0 flagged

**The partial repair is resolved.** Four blockquotes stood above prose that had absorbed some of them and not others, one of them, the $\lambda_\alpha\ne0$ note, was **stale**, its content already in the proof. *A half-applied repair is worse than an unapplied one, because the reader cannot tell which half is current.* The block is now statement, proof, two owed-notes and a scope paragraph, with no annotation contradicting the text beside it.

