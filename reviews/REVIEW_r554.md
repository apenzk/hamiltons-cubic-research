# Review r554, Lemma L66 (no maximizer is $\circ$-decomposable)

Reviewer r554, independent adversarial audit. Target: [Lemma L66](../findings/support-dichotomy.md), with its argument in the same file and its canonical block at [results.md](../results.md). Analysis only; no computation was run beyond permitted screening, and any screen is labelled as such.

Status: **COMPLETE**, twelve verdicts, four refutations, all in the record around the lemma rather than in the lemma.

## Verdicts

### Summary of verdicts

| # | claim audited | verdict |
| --- | --- | --- |
| V1 | L66's statement, no maximizer of $P$ on the unit sphere of $\mathcal W_n$ is $\circ$-decomposable | **CONFIRMED** |
| V2 | the additivity step, asserted as immediate | **CONFIRMED**, resting on total symmetry of $T$, which the file never states |
| V3 | the strict inequality's dependence on $M(n)>0$ | **CONFIRMED as a real gap**, the fact is true, unstated, and $M(n)$ is defined nowhere on the record |
| V4 | the inner bound $\sum\lvert a_i\rvert^3\le\max_i\lvert a_i\rvert<1$ and $\lvert P(A_i)\rvert\le M(n)$ | **CONFIRMED** |
| V5 | [results.md](../results.md) line 254's trailing clause *"the value of such a sum is strictly below $\min_i\lvert\theta_i\rvert$"* | **REFUTED**, with a witness |
| V6 | [findings/INDEX.md](../findings/INDEX.md) line 51's chain, written without absolute values | **REFUTED**, it is the exact form r281 killed, surviving the retraction |
| V7 | *"[nondegeneracy.md](../findings/nondegeneracy.md) states it verbatim and stronger, via the direct-sum saddle lemma"* | **REFUTED** on all three counts, wrong file, not verbatim, not simply stronger |
| V8 | [support-dichotomy.md](../findings/support-dichotomy.md) line 25's $\Theta_4=\sqrt{3/2}$ | **REFUTED**, under [conventions.md](../findings/conventions.md), $\Theta_4=\theta_0(4)=0.866$ |
| V9 | the block's pointer *"the argument is in this file under 'This is not new'"* | **REFUTED**, the argument is in the unheaded preamble; that heading holds the attribution and the retraction |
| V10 | the quantifier, every $n$, every $k\ge2$ | **CONFIRMED**, uniformly |
| V11 | the norm convention behind the quoted $\lVert A\circ B\rVert=0.664362$ | **CONFIRMED as immaterial**, the claim it supports is a non-vanishing, invariant under the $\sqrt2$ |
| V12 | the 34 citations, checked for use against local maxima or merely-orthogonal pieces | **CONFIRMED clean**, with the two labelling defects V6/V7 and one diagram mislabel |

**Overall: the lemma is true and its proof is sound.** Every defect found is in the record around it, two of them false sentences that a reader would take as part of the result.

---

## V1–V4. The proof, rebuilt from the definitions

Working from [conventions.md](../findings/conventions.md): $\langle A,B\rangle=\tfrac12\operatorname{tr}(A^{\mathsf T}B)$, $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$.

**Step 0, $\circ$ is bilinear and $X\circ X=Q(X)$.** $Q$ is homogeneous of degree $2$, so $Q(2X)=4Q(X)$ and $X\circ X=\tfrac12(4Q(X)-2Q(X))=Q(X)$; the polarisation of a quadratic map is symmetric bilinear.

**Step 1, $T(X,Y,Z):=\langle X,Y\circ Z\rangle$ is totally symmetric.** Symmetry in $(Y,Z)$ is free from the polarisation. Symmetry in the first slot splits over the two terms of $Q$:

- *The $W^2$ term.* Its polarisation is $\tfrac12(XY+YX)$, so the contribution is $\tfrac12\langle X,YZ+ZY\rangle=\tfrac12\operatorname{tr}(XYZ)$ for symmetric operators on $\Lambda^2$. $\operatorname{tr}(XYZ)$ is cyclic, and for symmetric $X,Y,Z$ it equals $\operatorname{tr}((XYZ)^{\mathsf T})=\operatorname{tr}(ZYX)$, so it is invariant under the full $S_3$.
- *The $\#$ term.* In an orthonormal basis of $\mathfrak{so}(n)=\Lambda^2$ with $c_{\alpha\beta\gamma}=\langle[\varphi_\alpha,\varphi_\beta],\varphi_\gamma\rangle$ totally antisymmetric, [conventions.md](../findings/conventions.md)'s own normalisation, the polarised sharp is $(Y\#Z)_{\gamma\delta}=\tfrac12c_{\gamma\alpha\beta}c_{\delta\epsilon\zeta}Y_{\alpha\epsilon}Z_{\beta\zeta}$, and the contribution to $T$ is proportional to $\Psi(X,Y,Z)=c_{\alpha\gamma\delta}c_{\beta\epsilon\zeta}X_{\alpha\beta}Y_{\gamma\epsilon}Z_{\delta\zeta}$. Swapping the last two slots and relabelling $\gamma\leftrightarrow\delta$, $\epsilon\leftrightarrow\zeta$ flips both $c$'s, sign $(-1)^2$. Swapping the first two and relabelling $(\alpha,\beta,\gamma,\epsilon)\to(\gamma,\epsilon,\alpha,\beta)$ likewise flips both $c$'s. So $\Psi$ is $S_3$-invariant as a raw tensor identity, before any use of the symmetry of $X,Y,Z$.

Restriction to $\mathcal W_n$ costs nothing: if $Q$ carries an orthogonal projection $\Pi$ onto $\mathcal W_n$, then $\langle X,\Pi(Y\circ Z)\rangle=\langle\Pi X,Y\circ Z\rangle=\langle X,Y\circ Z\rangle$ for $X\in\mathcal W_n$.

**The record has this fact and the file does not.** [second-order.md](../findings/second-order.md) line 62 states it inside Lemma L24's argument, *"$T(X,Y,Z)=\langle X\circ Y,Z\rangle$ is fully symmetric, the $W^2$ part as the symmetrisation of $\operatorname{tr}(XYZ)$ and the $\#$ part because permuting the arguments permutes the slots of both totally antisymmetric $c$'s, sign $(-1)^2$"*, crediting [r285](REVIEW_r285.md) Claim 1. My derivation above is independent and agrees. **[support-dichotomy.md](../findings/support-dichotomy.md), [results.md](../results.md) and [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) all state the additivity without it**, which [r283](REVIEW_r283.md) already filed as live and which is still live.

**Step 2, additivity.** $P$ is the cubic $T(W,W,W)$, so with $W=\sum_ia_iA_i$,
$$P(W)=\sum_{i,j,k}a_ia_ja_kT(A_i,A_j,A_k).$$
A term with two distinct indices dies: if $j\ne k$ then $A_j\circ A_k=0$ directly; if $j=k\ne i$ then total symmetry rewrites $T(A_i,A_j,A_j)=T(A_j,A_i,A_j)=\langle A_j,A_i\circ A_j\rangle=0$. **The second case is where total symmetry is load-bearing, and no other route reaches it**, $\langle A_i,Q(A_j)\rangle=0$ does not follow from $A_i\circ A_j=0$ without moving the first slot. Hence $P(W)=\sum_ia_i^3P(A_i)$.

**Step 3, the chain.** $P$ is odd, since $Q(-W)=Q(W)$ gives $P(-W)=-P(W)$; $-A_i$ is a unit element of $\mathcal W_n$ whenever $A_i$ is; so $\lvert P(A_i)\rvert\le M(n)$ where $M(n)=\max_{\lVert W\rVert=1}P$. Then $\lvert a_i\rvert^3=\lvert a_i\rvert a_i^2\le(\max_j\lvert a_j\rvert)a_i^2$ summed against $\sum a_i^2=1$ gives $\sum_i\lvert a_i\rvert^3\le\max_i\lvert a_i\rvert$; and $a_1^2=1-\sum_{i\ge2}a_i^2<1$ because $k\ge2$ with every $a_i\ne0$ leaves at least one strictly positive term, so $\max_i\lvert a_i\rvert<1$. All four checks in the brief's question (3) hold as written.

**Step 4, and here is the gap.** The chain closes as $P(W)\le M(n)\max_i\lvert a_i\rvert<M(n)$, and **the last step is strict only if $M(n)>0$**. The fact is true, $P$ is odd and $P\not\equiv0$ on $\mathcal W_n$ for $n\ge4$, the record's own padded $W_{\mathbb{CP}^2}$ putting $\sqrt{3/2}$ into every $\mathcal W_n$ with $n\ge4$, but it is stated in none of the four places that carry the chain. **Worse, $M(n)$ is defined nowhere on the record.** It is used in [support-dichotomy.md](../findings/support-dichotomy.md), [second-order.md](../findings/second-order.md) (posts F11, F12 and line 535), [findings/INDEX.md](../findings/INDEX.md), [INDEX-traps.md](../findings/INDEX-traps.md) trap 35, [routes.md](../routes.md) R3, [plan.md](../plan.md) and both diagram files; its only written definition anywhere is inside a review, [r106](REVIEW_r106.md) line 206, as $\max_{\lVert W\rVert=1}\lvert\theta\rvert$. **[conventions.md](../findings/conventions.md) has no row for it, and already warns that the letter $M$ carries two other objects**, the $n\times n$ sectional matrix and the $\Lambda^2$ operator, *"and their norms differ by $\sqrt2$"*. A third, undefined meaning of the same letter sits in the one step that delivers this lemma's entire content.

*Repair, one line each:* add $M(n)=\max_{\lVert W\rVert=1}P(W)$ to [conventions.md](../findings/conventions.md)'s table with the note that $M(n)>0$ because $P$ is odd and padded $W_{\mathbb{CP}^2}$ attains $\sqrt{3/2}$ at every $n\ge4$; and add the total-symmetry citation to [second-order.md](../findings/second-order.md) line 62 in the additivity sentence.

## V5. The clause in [results.md](../results.md) line 254 is false, REFUTED

[results.md](../results.md) line 254 states L66 and then appends: *"the value of such a sum is strictly below $\min_i\lvert\theta_i\rvert$."* Under [conventions.md](../findings/conventions.md), $\theta=P(W)/\lVert W\rVert^3$, so at unit norm $\theta_i=P(A_i)$ and the clause reads $P(W)<\min_i\lvert P(A_i)\rvert$.

**This is the harmonic-square law, and the law needs criticality of the pieces, which L66's hypotheses do not supply.** [nondegeneracy.md](../findings/nondegeneracy.md) line 357 derives $1/\theta^2=\sum_i1/\theta_i^2$ from *"criticality forces $\theta=a\theta_A=b\theta_B$"* and only then concludes $\lvert\theta\rvert<\min_i\lvert\theta_i\rvert$. [support-dichotomy.md](../findings/support-dichotomy.md) line 17 and [findings/INDEX.md](../findings/INDEX.md) line 51 both make a point of L66 needing **no criticality of the pieces**. The two cannot be bolted together.

**Witness, by a route sharing nothing with the file's.** Work in $\mathcal W_8$, splitting $\mathbb R^8=V_1\oplus V_2$ into coordinates $1$–$4$ and $5$–$8$.

1. *$\circ$-orthogonality across disjoint coordinate blocks, from the definitions.* Let $X$ be supported on $\Lambda^2V_1$ and $Y$ on $\Lambda^2V_2$. As operators on $\Lambda^2\mathbb R^8$ their ranges and supports are orthogonal, so $XY=YX=0$ and the polarised square term $\tfrac12(XY+YX)$ vanishes. For the sharp term, $(X\#Y)$ contracts $c_{\alpha\gamma\delta}$ against indices $\gamma$ carried by $X$ and $\delta$ carried by $Y$, and $[\mathfrak{so}(V_1),\mathfrak{so}(V_2)]=0$ makes every such $c$ vanish. Hence $X\circ Y=0$.
2. *A piece with a small positive value.* The unit sphere of $\mathcal W_4$ is connected ($\dim\mathcal W_4=10$), $P$ is continuous on it, and it attains $+\sqrt{3/2}$ and (by oddness), $-\sqrt{3/2}$. By the intermediate value theorem it attains $0.1$. Let $A_1$ be such a point, padded into $V_1$; padding preserves norm and $\theta$ ([conventions.md](../findings/conventions.md)), so $A_1$ is a unit element of $\mathcal W_8$ with $\theta_1=0.1$.
3. *A piece with a large value.* Let $A_2$ be $W_{\mathbb{CP}^2}$ on $V_2$, unit norm, $\theta_2=\sqrt{3/2}=1.224745$.
4. *The sum.* $a_1=a_2=1/\sqrt2$ satisfies $k=2$, $\sum a_i^2=1$, both $a_i\ne0$, $A_1\circ A_2=0$, every hypothesis of $\circ$-decomposability. Additivity gives
$$P(W)=\tfrac1{2\sqrt2}(0.1+1.224745)=0.468\ldots\quad\text{against}\quad\min_i\lvert\theta_i\rvert=0.1 .$$

**The clause fails by a factor of nearly five, and the mechanism is general**: whenever the pieces' values are unequal, the sum is a weighted average that sits above the smaller of them. Criticality is exactly what forbids unequal values from being chosen freely, which is why the law is true on the critical set and false off it. *(Nothing here was computed; the two constants are the record's own.)*

*Repair:* delete the clause from [results.md](../results.md) line 254, or restate it as the separate harmonic-square law with its criticality hypothesis, citing [nondegeneracy.md](../findings/nondegeneracy.md).

## V6. The retraction is incomplete, [findings/INDEX.md](../findings/INDEX.md) still carries the withdrawn chain, REFUTED

[support-dichotomy.md](../findings/support-dichotomy.md) line 11 records the repair: *"The absolute values are load-bearing and were missing (r281): with $a_i^3$ in place of $\lvert a_i\rvert^3$ the chain is **false** at any negative coefficient."*

**[findings/INDEX.md](../findings/INDEX.md) line 51 prints the chain in the withdrawn form**: $P(W)=\sum a_i^3P(A_i)\le M(n)\max a_i<M(n)$, no absolute values on either the cubes or the max. The witness is the record's own, [r282](REVIEW_r282.md): two pieces at $\pm M(n)$ with $(a,b)=(0.6,-0.8)$ inverts the first inequality, and $\max a_i$ is not even positive in general. This is the summary line a reader meets first, since it is the entry for the file in the findings index.

The other three carriers are correct: [support-dichotomy.md](../findings/support-dichotomy.md) line 8, [results.md](../results.md) line 734 (which uses $\lvert P(A_i)\rvert$ throughout) and [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) lines 1163–1166 all carry the repaired form.

*Repair:* replace with $P(W)=\sum a_i^3P(A_i)\le M(n)\sum_i\lvert a_i\rvert^3\le M(n)\max_i\lvert a_i\rvert<M(n)$.

## V7. *"nondegeneracy.md states it verbatim and stronger"* is wrong three times over, REFUTED

The sentence is [support-dichotomy.md](../findings/support-dichotomy.md) line 23, repeated in [findings/INDEX.md](../findings/INDEX.md) line 51.

**Wrong file.** [nondegeneracy.md](../findings/nondegeneracy.md) never states a direct-sum saddle lemma. Its single mention is line 403, *"the direct-sum saddle lemma on record is correct"*, a reference, not a statement. The statement is in [ATTEMPTS.md](../ATTEMPTS.md) line 985, as *Theorem A (direct-sum saddle lemma)*: any critical point with $\theta>0$ that splits over disjoint coordinate blocks is a saddle, via $H=\lVert W_2\rVert^2W_1-\lVert W_1\rVert^2W_2$ giving $\mathrm{Hess}=+3\theta\lVert H\rVert^2$. A reader following the pointer lands on a file that does not contain the result.

**Not verbatim.** The saddle lemma's hypotheses are *critical*, *$\theta>0$*, *disjoint coordinate blocks*. L66's are none of those.

**Not simply stronger, and this is the substantive half.** I re-derived the saddle lemma to see how far it reaches. With $W=W_1+W_2$, $c_i=\lVert W_i\rVert^2$ and $H=c_2W_1-c_1W_2$: total symmetry and $W_1\circ W_2=0$ give $T(W,H,H)=c_2^2P(W_1)+c_1^2P(W_2)$; **$\langle H,W\rangle=0$ and $\lVert H\rVert^2=c_1c_2$ need $W_1\perp W_2$ in the Frobenius sense; and $P(W_i)=\theta c_i$ needs $Q(W_i)=\theta W_i$ piece by piece.** Then $\mathrm{Hess}(P\vert_S)[H,H]=6T(W,H,H)-3\theta\lVert H\rVert^2=6\theta c_1c_2-3\theta c_1c_2=3\theta\lVert H\rVert^2$, reproducing the recorded identity exactly.

Both extra ingredients cost hypotheses. Frobenius orthogonality is derivable from $\circ$-orthogonality, but only with criticality and $\theta_A\ne0$, that is [second-order.md](../findings/second-order.md) line 319's argument, $\langle A\circ B,A\rangle=\langle B,Q(A)\rangle=\theta_A\langle A,B\rangle$. Per-piece criticality is available across disjoint blocks ([target.md](../findings/target.md) line 415) and is otherwise an assumption. **So the saddle lemma is stronger in conclusion (local maxima, not merely global maximizers) and strictly narrower in hypothesis. Neither result implies the other, and L66 is the one that covers non-critical pieces and $\circ$-splittings on shared coordinates**, which [support-dichotomy.md](../findings/support-dichotomy.md) line 17 names as real cases ($(S^4)^3$'s support-$12$ piece, the $\Lambda^+/\Lambda^-$ pair on four shared coordinates).

*Repair:* point the sentence at [ATTEMPTS.md](../ATTEMPTS.md) line 985, and replace *"verbatim and stronger"* with the honest comparison, stronger conclusion, narrower hypothesis, and L66 is what covers the rest.

**Consequence for the brief's question (4): L66 is the number the record should be citing.** The saddle lemma is unnumbered and lives in [ATTEMPTS.md](../ATTEMPTS.md), which [results.md](../results.md) does not treat as canon; and it does not cover the $\circ$-decomposables L66 covers. If the record wants the local-maximum exclusion as a citable fact, it needs its own number, and the natural repair is to number it and state both, rather than to leave three unlinked copies.

## V8. $\Theta_4=\sqrt{3/2}$ contradicts [conventions.md](../findings/conventions.md), REFUTED

[support-dichotomy.md](../findings/support-dichotomy.md) line 25 retires the withdrawn induction by observing that its inductive claim $\lvert\theta_i\rvert\le\theta_0(n_i)$ *"is false at the one base case that is proved ($\Theta_4=\sqrt{3/2}$ against $\theta_0(4)=0.866$)"*.

**[conventions.md](../findings/conventions.md) defines $\Theta_n$ as the *diagonal* maximum, equal to $\theta_0(n)$ at even $n$.** So $\Theta_4=\theta_0(4)=\sqrt{12}/4=0.866$, and the sentence as written compares $0.866$ against $0.866$, no refutation at all. The object that is $\sqrt{3/2}$ at $n=4$ is $M(4)$, the *global* maximum, which [nondegeneracy.md](../findings/nondegeneracy.md) line 363 records as proved via $P=9(\det W^++\det W^-)$ on $\mathrm{Weyl}_4$.

**The retraction survives**: $M(4)=\sqrt{3/2}>\theta_0(4)$ is exactly what kills the inductive claim. Only the symbol is wrong, and it is wrong in the direction that makes a true retraction unreadable, in a file whose own subject is an over-equipped argument being withdrawn.

*Repair:* write $M(4)=\sqrt{3/2}$.

## V9. The block does not reach its proof, REFUTED

The brief's first question. The `Lemma L66` block at [support-dichotomy.md](../findings/support-dichotomy.md) line 33 is a dated note, a definition and a sentence, with the note saying *"the argument is in this file under 'This is not new'"*.

**The section headed `This is not new` (lines 21–25) contains no argument.** It contains the attribution to two other files and the retraction of the induction. **The proof is at lines 7–9, in the file's unheaded preamble**, above every heading. A reader who follows the pointer reads the attribution, finds no proof, and has no reason to scroll up.

*Repair:* point the note at the preamble, or give the preamble a heading and name it.

## V10–V12. The quantifier, the norm, and the citations

**V10, the quantifier is uniform.** Nothing in Steps 2–4 depends on $k$ or on $n$: the argument is $\lvert P(A_i)\rvert\le M(n)$, a Hölder step, and $\max_i\lvert a_i\rvert<1$. It holds for every $n$ with $\mathcal W_n\ne0$, that is $n\ge4$, and for every $k$ from $2$ to $\dim\mathcal W_n$. At $n\le3$, $\mathcal W_n=0$ and the statement is vacuous. **CONFIRMED.**

**V11, the norm convention does not touch the claim.** [support-dichotomy.md](../findings/support-dichotomy.md) line 15 quotes $\lVert A\circ B\rVert=0.664362$ for two critical Frobenius-orthogonal copies of padded $W_{\mathbb{CP}^2}$ at $n=8$, and $0.272738$ for a rotated $S^4\times S^4$ pair. [conventions.md](../findings/conventions.md) records that the half-trace and plain Frobenius norms differ by $\sqrt2$, so a figure of this shape is ambiguous by that factor and the file does not say which it is. **The claim it supports is that the quantity is non-zero**, and non-vanishing is invariant under a positive scalar. So the ambiguity is a reporting defect with no mathematical consequence here. *Naming the pairing would still cost one word, and [conventions.md](../findings/conventions.md) exists to make that the default.* **CONFIRMED as immaterial.**

**V12, the citations.** Sweeping the statement rather than the identifier, across [results.md](../results.md), [findings/](../findings/), [routes.md](../routes.md), [plan.md](../plan.md) and [report/](../report/):

- **No site uses L66 against local maxima.** The two that mention local maxima ([support-dichotomy.md](../findings/support-dichotomy.md) line 23 and [findings/INDEX.md](../findings/INDEX.md) line 51) attribute that to the saddle lemma, and their defect is V7's misattribution rather than a misuse of L66.
- **No site uses L66 with merely Frobenius-orthogonal pieces.** Every consumer of the $\circ$-hypothesis states it: [fence-posts.md](../findings/fence-posts.md) post F35, [INDEX-traps.md](../findings/INDEX-traps.md) trap 35, [routes.md](../routes.md) R3 and [second-order.md](../findings/second-order.md) lines 317–338 all say the harmonic-square law needs $\circ$-orthogonality **and critical pieces**, and [nondegeneracy.md](../findings/nondegeneracy.md) line 357 gives the record's own witness that operator orthogonality is not enough ($\langle W_{S^3\times S^3},W_{\mathbb{CP}^2}\rangle=0$ at $n=6$ with cross term $0.2152$). **This is the place a false sentence was most likely and there is none.**
- **One diagram mislabel.** [report/sections/diagram-closed.tex](../report/sections/diagram-closed.tex) line 79 labels a node *"no maximizer is $\circ$-decomposable; support $s$ forces a padding, $\theta\le M(s)$"* with the single citation `L66`. The second clause is not L66, L66's own text says the pieces' support dimensions never enter and that a $\circ$-splitting does not force $n_i<n$. The open variant, [report/sections/diagram.tex](../report/sections/diagram.tex) line 68, cites `L66, §ref{sec:ledger}` for the same two clauses, so the closed variant lost the second source rather than inventing the claim. *Repair: restore the second citation.*
- **[second-order.md](../findings/second-order.md) line 60 carries a second, independent exclusion**, a maximizer has $1$ simple in $\operatorname{spec}(L_e)$ by [Lemma L24](../findings/second-order.md), so no $\circ$-splitting. **It does not supersede L66**: reading a splitting off $E(1)$ needs $A_i\circ W=a_iQ(A_i)=\theta A_i$, which is line 322's step and requires the pieces to be **critical**. L66 remains the only statement covering non-critical pieces.

## Standing of the record's own retractions

The brief's question (7). Three retractions are recorded in the file, and **two are complete while one is not**:

| retraction | complete? |
| --- | --- |
| the induction on $n$, conditional on base cases $5\le n_i\le11$ | **complete**, no surviving site conditions L66 on low-dimensional base cases; [results.md](../results.md) line 734 states the opposite explicitly, that the lemma *"supports no induction on $n$"* |
| the clause deriving $\circ$-orthogonality from ordinary orthogonality via criticality | **complete**, every consumer states the $\circ$-hypothesis, per V12 |
| the missing absolute values (r281/r282) | **INCOMPLETE**, [findings/INDEX.md](../findings/INDEX.md) line 51, per V6 |

And the retraction at line 25 is itself misstated, per V8.

## Note on repairs

**I have recorded the repairs rather than applying them.** A second reviewer is working this identical brief; edits to [support-dichotomy.md](../findings/support-dichotomy.md), [results.md](../results.md) and [findings/INDEX.md](../findings/INDEX.md) from two independent auditors would collide, and the point of two cold verdicts is that they be compared before either is folded in. Every repair above is named to the line.

Status: **COMPLETE.**
