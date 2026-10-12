# ROUND_L34, full support with two negative eigenvalues, at $m=6$ and $m=8$

**Date:** 2026-09-07. **Phase:** 6, closed. **Verdict:** `PROVEN, hypotheses corrected`, repaired, impact `NARROWS`. **Verifiers:** v161, v162, v163.

## Sources, verbatim

| what | where |
|---|---|
| Canonical statement and construction | [results.md](../results.md), block `##### Lemma L34` |
| Landscape statement | [results.md](../results.md), the `Lemma L34 (landscape)` bullet |
| The block | [stratum-two-negative.md](../findings/stratum-two-negative.md) lines 369–396 |
| A third copy, unlinked | [isotropy-cap.md](../findings/isotropy-cap.md) lines 343–360 |
| Brief | [BRIEF_L34.md](BRIEF_L34.md) |

## Three findings from phase 0

**1. The block names a conflict against itself, and there is none to name.** It records $\theta=+0.485408612$ *"(measured, not derived, and [isotropy-cap.md](../findings/isotropy-cap.md) records $+0.6259$ for the same family, a conflict this block does not resolve)"*. Read at source, the two are different quantities: $+0.485408612$ is an **exact** witness from 4-planes in general position, and $+0.6259$ is the maximum of **random general-position draws**, a sampled lower bound on the family's supremum. *A sample maximum exceeding an exhibited witness is what one expects, not a contradiction.* **The block records an unresolved conflict where the resolution is in the sentence it cites.**

**2. The construction lives in three files and the provenance note says the duplication is resolved.** [results.md](../results.md) carries *"Pad two copies of $W_4(q,r)$ onto 4-planes of $\mathbb R^m$ and add"* and the whole construction with it, byte-identical to the findings block, while that block's own note says *"the duplication having been resolved on 2026-09-06"*. The block separately records the third copy in [isotropy-cap.md](../findings/isotropy-cap.md) as *"unlinked"*.

**3. Two of the block's own values are marked *measured, not derived***, $+0.485408612$ and $+0.115574271$, inside a result the index grades a `Lemma` on the strength of its closed-form spectra.

## What the verifiers are asked beyond the standing list

Whether the two exhibited spectra are right; whether *"each summand contributes exactly one negative eigenvalue"* survives overlapping planes; whether the linearity argument for Weyl membership is complete; and what the construction's silence at $m\ge10$ costs the refutation it is cited for.

## Clustering, all three in, unanimous

**Both witnesses rebuilt by hand in an explicit frame, and every printed value is right.** At $m=8$, orthogonal planes give $\{-1/\sqrt3\,(\times2),\ 1/(2\sqrt3)\,(\times4)\}$ with $\theta=-\sqrt3/2$, $\operatorname{tr}W^\#=-12$, and $\dim U=8$ **under every basis of the degenerate eigenplane**. At $m=6$, planes meeting in $\langle e_3,e_4\rangle$ give $(-3,-1,1,1,1,1)/\sqrt{14}$, $P=-54$, $\operatorname{tr}W^\#=-14$, $\dim U=6$, **and $\theta=-27\sqrt{14}/98$ in closed form, which the record prints only as the decimal $-1.030865$.**

| id | step attacked | mechanism | support |
|---|---|---|---|
| **G1** | *"each summand contributes exactly one negative eigenvalue"* | **a non sequitur at the $m=6$ witness**, whose summands pair to $\langle W_1,W_2\rangle=1$, neither $-3q$ nor $-q$ is a summand eigenvalue and $u_1$ is not an eigenvector of the sum. **True at $m=8$ alone: a subfamily claim used generally.** *The count two survives by inertia subadditivity plus the explicit spectra* | v161, v162 |
| **G2** | *"the support is the union of the planes"* | it does not give $\dim U=m$, **$\operatorname{im}v_{14}=\langle e_1,e_2,e_5,e_6\rangle$ lies in neither plane**, and the general argument yields only $U\subseteq V_1+V_2$, equality being a per-witness computation. *The counterexample to the stronger reading is in this same file at line 212, and the real reason (each negative eigenvector is a complex structure), sits in [lean/INDEX.md](../lean/INDEX.md)* | v161, v162 |
| **G3** | hypotheses used and stated nowhere | **$q,r>0$ is load-bearing**, $W_4(2,-1)$ has signature $(1,2)$, so two such copies give **four** negative eigenvalues. **$q=r=q'=r'$** is what the recorded spectra require and the construction never says. And the $m=6$ alignment: **a second alignment of the same two planes gives $\{-2,(-1\pm\sqrt7)/2,1,1,1\}$**, so the clause is over-claimed as a universal | v161, v162 |
| **G7** | the [L33](../findings/stratum-two-negative.md) citation | needs $m\ge6$: **at $m=4$ a full-rank eigenvector *is* a complex structure and $-W_4(q,r)$ is the counterexample** | v161 |
| **G8** | the provenance note | *"the duplication having been resolved on 2026-09-06"* is **false**, [results.md](../results.md) still carries the Construction byte-identical, $512$ characters each. *Confirms phase 0* | v161 |
| **G9** | $\operatorname{tr}W^\#$ as a check | it is **an identity at every unit Weyl tensor**, so recovering it distinguishes nothing, and [INDEX-results.md](../findings/INDEX-results.md) credits the earlier Gate 2 pair with *"recovering $\operatorname{tr}W^\#=-1$ at each"* as though it were evidence. **Settled by v163: $\operatorname{tr}W^\#=-\lVert W\rVert^2$**, so $-14$ unnormalised at $m=6$ and $-1$ after normalising are the same fact, and it holds at every element of $\mathrm{Weyl}_m$ | v161 |
| **G4** | the landscape bullet | **BROKEN twice over.** *"In general position they reach $\theta=+0.485$"* is contradicted by the record's own $+0.6259$ under the same restriction, by $+1.2238$, and by the family's measured supremum $\sqrt{3/2}$; and the bullet carries a **universal** quantifier where the lemma is **existential**, false at $m\ge10$, printing $+0.485$ without the *measured, not derived* tag the findings block attaches to it | v161, v162 |
| **G5** | [isotropy-cap.md](../findings/isotropy-cap.md) line 358 | **false of its own table**: it calls orthogonal planes *"the special shape both recorded witnesses happen to have"*, while the $m=6$ row four lines above says *"overlapping in a 2-plane"*, where $P$ is demonstrably non-additive | v162 |
| **G6** | the stated dimensions | the construction covers **odd $m=7$ unchanged**, which the statement omits | v162 |

**Phase 0's reading of the recorded conflict is confirmed independently**: $+0.485408612$ is one exact witness and $+0.6259$ a sample maximum, so there is no conflict to resolve.

**Cleared:** $\ker W\ne0$, large at both witnesses, with every step surviving; $U$'s two readings agreeing here; and [L33](../findings/stratum-two-negative.md) and [L30](../findings/stratum-two-negative.md) both intact, *L34 exhibits points where L30's hypothesis fails, which is not a counterexample to it.*

## The finding that reaches furthest

**The family provably cannot reach $m\ge10$.** Two 4-planes span at most eight dimensions, so $U\subseteq V_1+V_2$ caps the construction, *and $m\ge10$ is where the stratum argument needed it.* The witnesses kill the recorded statement at $m=6$ and $m=8$ and there is no extension to be had, so **what L34 refutes must be stated at those two dimensions and the $m\ge10$ case rests on the convex screen alone.**

**Verdict `PROVEN, hypotheses corrected`, repaired. Impact `NARROWS`.** Three verifiers, one verdict. **Both witnesses were rebuilt cold by all three and every printed value is right**, the $m=8$ spectrum, the $m=6$ spectrum, $\lVert W\rVert^2=12$ and $14$, $P=-36$ and $-54$, $\operatorname{tr}W^3=-24$, $\langle W,W^\#\rangle=-30$. *The existence claim is true and the argument offered for it is not the argument that works.*

### The block proved its statement by two sentences that are false at its own $m=6$ witness

*"Each summand contributes exactly one negative eigenvalue"*, each summand carries $-2$ at $w_1$, while the sum carries $-3$ and $-1$ at $x\pm y$; **neither value nor either eigenvector belongs to a summand.** The count survives by subadditivity of inertia, which the block never states, with the lower bound coming only from the exhibited spectra. *"The support is the union of the planes"*, $\operatorname{im}v_{N-1}=\langle e_1,e_2,e_3,e_4\rangle$ lies in neither plane; the general argument yields $U\subseteq V_1+V_2$, and $\dim U=6$ holds because $v_N=\tfrac1{\sqrt6}(E_{12}+E_{34}+2E_{56})$ has rank $6$ alone. **Both sentences are true at $m=8$ and were carried to $m=6$**, which is the subfamily-used-generally shape.

### The cap is a theorem and the record read it as an admission

**Two 4-planes span at most eight dimensions, so $U\subseteq V_1+V_2$ caps the family at $m\le8$.** There is no extension to be found. *The block described this as the construction being "silent at $m\ge10$", which reads as work not yet done; it is a proof that the work cannot be done this way*, and $m\ge10$ is the range the stratum argument needed.

### A control that controls nothing

$\operatorname{tr}W^\#=-\lVert W\rVert^2$ holds at **every** element of $\mathrm{Weyl}_m$, so recovering it separates no object from any other, and [INDEX-results.md](../findings/INDEX-results.md) credits an earlier Gate 2 pair with *"recovering $\operatorname{tr}W^\#=-1$ at each"* as evidence for these witnesses. **The control that does bite is Ricci-flatness**, verified at $m=6$ coefficient by coefficient.

### The repairs, all applied

| finding | what changed |
|---|---|
| G1 | inertia subadditivity replaces the false clause, with the exhibited spectra supplying the lower bound |
| G2 | $U\subseteq V_1+V_2$ replaces the equality, and $\dim U=m$ is stated as a per-witness computation with the rank-$6$ reason given |
| G3 | $q,r>0$, $q=r$ and the named alignment are hypotheses on the face of the construction, with $W_4(2,-1)$'s signature $(1,2)$ recorded as why the first is load-bearing and the second alignment's spectrum as why the third is |
| G4 | the landscape bullet is existential, carries the dimension cap, and no longer prints a measured figure as a property of the family |
| G5 | [isotropy-cap.md](../findings/isotropy-cap.md) now says the $m=8$ witness is the orthogonal one and the $m=6$ witness is safe by a **negative cross term**, $\langle A,B\rangle=1$ and $P(A+B)=-54$ against $-36$ |
| G7 | the [L33](../findings/stratum-two-negative.md) citation carries $m\ge6$, with $-W_4(q,r)$ named as the $m=4$ counterexample |
| G8 | the provenance note states what is true (the duplication was recorded as resolved and was not) and [results.md](../results.md) now states the result rather than carrying the construction |
| G9 | $\operatorname{tr}W^\#=-\lVert W\rVert^2$ named as an identity, and Ricci-flatness named as the control that bites |
| the conflict | recorded as no conflict, with the reason: an exhibited member against a sampled maximum over the same family |
| the script | [b0_full_support_witness.py](../scripts/lib/b0_full_support_witness.py)'s docstring asserted *"Every such witness has theta <= 0"* (the clause the record withdrew) and listed $\theta>0$ as a falsifier. Replaced, with the dimension cap added |
| the collisions | $q$ and $r$ tabled in [conventions.md](../findings/conventions.md), each carrying two senses inside this one file |

### What the round gained

**A closed form the record printed only as a decimal**: $\theta=-27\sqrt{14}/98$ at the $m=6$ witness. **And a dimension**: the construction covers odd $m=7$ unchanged, which the statement omitted, so the claim is now stated at $m=6$, $7$ and $8$.

### Queued elsewhere

**Research loop.** The family's supremum, of which $+0.485408612$, $+0.115574271$ and $+0.6259$ are all measured lower bounds and none a derivation. And the $m\ge10$ case, which the convex screen carries alone now that this family is proved unable to reach it.
