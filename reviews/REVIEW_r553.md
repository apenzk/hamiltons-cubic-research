# Review r553, Lemma L66 (no maximizer is $\circ$-decomposable)

Reviewer r553, independent adversarial audit. Target: `Lemma L66` in [findings/support-dichotomy.md](../findings/support-dichotomy.md). Working from the definitions in [findings/conventions.md](../findings/conventions.md); the record is treated as a claim, not as a source.

Analysis only. No computation beyond screening a claim about to be recorded, reported as a screen.

Verdicts are appended below as they are reached.

## Status

- Report created before any mathematics. Reading phase opened.

## Setup as I fix it, from [conventions.md](../findings/conventions.md)

$\langle A,B\rangle=\tfrac12\mathop{\mathrm{tr}}(A^{\mathsf T}B)$ at the $\Lambda^2$ level; $Q(W)=W^2+W^\#$; $P(W)=\langle W,Q(W)\rangle$; $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, so $X\circ X=Q(X)$ and $\circ$ is the symmetric bilinear polarisation of the quadratic map $Q$. Write $T(X,Y,Z)=\langle X,Y\circ Z\rangle$ and $M(n)=\max\{P(W):W\in\mathcal W_n,\lVert W\rVert=1\}$, the second of these is my own definition, because the record has none (defect D2 below).

## D1, the additivity step is TRUE, and the property it needs is total symmetry of $T$. CONFIRMED, with a citation gap

Expanding $Q$ on $W=\sum_ia_iA_i$ by polarisation and killing the cross terms gives $Q(W)=\sum_ia_i^2Q(A_i)$, hence

$$P(W)=\Big\langle\sum_ia_iA_i,\ \sum_ja_j^2Q(A_j)\Big\rangle=\sum_{i,j}a_ia_j^2\,T(A_i,A_j,A_j).$$

The off-diagonal terms are $T(A_i,A_j,A_j)$ with $i\ne j$, and $A_i\circ A_j=0$ kills them **only after** the first two arguments are exchanged. So additivity needs $T$ totally symmetric, and symmetry in the last two arguments is all the polarisation gives.

**$T$ is totally symmetric, by two independent computations, one per term of $Q$.**

- **The $W^2$ term.** Its polarisation is $\tfrac12(XY+YX)$, so its contribution to $T$ is $\tfrac14\big(\mathop{\mathrm{tr}}(XYZ)+\mathop{\mathrm{tr}}(XZY)\big)$. The two summands are the two cyclic classes of $\{X,Y,Z\}$ and their sum is a sum over all six orderings up to cyclicity, hence invariant under every permutation.
- **The $W^\#$ term.** In an orthonormal basis of $\mathfrak{so}(n)$ with $c_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$ totally antisymmetric ([conventions.md](../findings/conventions.md)), its trilinear form is proportional to $\sum c_{\alpha\gamma\delta}c_{\beta\epsilon\zeta}X_{\alpha\beta}Y_{\gamma\epsilon}Z_{\delta\zeta}$: each of $X,Y,Z$ contributes one index to each of the two $c$'s. Exchanging $X$ and $Y$ transposes the first two slots of **both** $c$'s, and the two sign changes cancel. Every transposition behaves the same way, and $X,Y,Z$ symmetric makes the slot order inside each irrelevant.

Equivalently, total symmetry says $\nabla P=3Q$, which is what makes [conventions.md](../findings/conventions.md)'s own critical-point equation $Q(W)=\theta W$ the Lagrange condition. So the property is not merely true, it is presupposed by the conventions the file runs on.

**Verdict: the additivity step is CONFIRMED. The write-up is defective.** [support-dichotomy.md](../findings/support-dichotomy.md) calls additivity immediate and states neither the property nor a citation, and the record holds the property in four places that the file links to none of, [problem.md:114](../findings/problem.md#L114), [graded-half.md:148](../findings/graded-half.md#L148), [second-order.md:191](../findings/second-order.md#L191), [target.md:31](../findings/target.md#L31). **This exact gap was filed by r281, re-filed by [r283](REVIEW_r283.md) twice (once in its verdict table and once in its live-items list) and is still unapplied.**

## D2, $M(n)$ is undefined on the record, and the strictness rests on $M(n)>0$, which is nowhere stated. CONFIRMED, repairable

The chain's last step, $M(n)\max_i\lvert a_i\rvert<M(n)$, is the whole content of the lemma, and it is strict **only if $M(n)>0$**. At $M(n)=0$ it reads $0<0$.

Two things are missing.

- **$M(n)$ has no definition anywhere on the record.** It is used in [support-dichotomy.md:8](../findings/support-dichotomy.md#L8), [second-order.md:338](../findings/second-order.md#L338), [fence-posts.md:265](../findings/fence-posts.md#L265), [routes.md:19](../routes.md#L19), [plan.md:121](../plan.md#L121), [INDEX-values.md:46](../findings/INDEX-values.md#L46) and in [07-gradedness-split.tex:1157](../report/sections/07-gradedness-split.tex#L1157), and [conventions.md](../findings/conventions.md), the file whose stated job is that "every definition, normalisation and index convention the record uses" lives there, has no row for it. That file already carries a warning that **the letter $M$ carries two objects**, the $n\times n$ sectional matrix and the operator; $M(n)$ is a third, and [second-order.md:535](../findings/second-order.md#L535) writes $M(n)\le\sup\lambda_{\max}(M)=\theta_0(n)$, with both meanings of the letter in one display.
- **$M(n)>0$ is nowhere stated.** It is easy: $\mathcal W_n=0$ for $n\le3$, so the lemma is vacuous there; and for $n\ge4$ padded $W_{\mathbb{CP}^2}$ is a unit element with $P=\sqrt{3/2}$ at **every** $n\ge4$ ([problem.md:149](../findings/problem.md#L149)), so $M(n)\ge\sqrt{3/2}>0$. The point is that the one step delivering strictness carries an unstated positivity hypothesis.

**Repair:** add $M(n)=\max\{P(W):W\in\mathcal W_n,\lVert W\rVert=1\}$ to [conventions.md](../findings/conventions.md) beside the existing $M$ warning, and add the clause "$M(n)\ge\sqrt{3/2}>0$ at every $n\ge4$, so the last step is strict" to the proof.

## D3, "[nondegeneracy.md](../findings/nondegeneracy.md) states it verbatim and stronger" is false on both counts. REFUTED

[support-dichotomy.md:23](../findings/support-dichotomy.md#L23) reads: *"[nondegeneracy.md](nondegeneracy.md) states it verbatim and **stronger**, via the direct-sum saddle lemma, which excludes decomposable *local* maxima and not merely global ones."*

- **It is not in [nondegeneracy.md](../findings/nondegeneracy.md), verbatim or otherwise.** The word "decomposable" occurs there five times, at lines 361, 363, 383, 387 and 403, and none of them states the theorem. Line 403 says only *"The direct-sum saddle lemma on record is correct"*, a reference outward, not a statement. **The lemma itself is [ATTEMPTS.md:985](../ATTEMPTS.md#L985), as "Theorem A", and it carries no result number.**
- **It is not stronger; the two are incomparable.** ATTEMPTS.md's Theorem A is *"Any critical point with $\theta>0$ that splits over **disjoint coordinate blocks**"*. Disjoint coordinate blocks are $\circ$-orthogonal ([target.md:415](../findings/target.md#L415): $[\mathfrak{so}(n_1),\mathfrak{so}(n_2)]=0$ kills the polarised $\#$), so its hypothesis is a **strict subset** of L66's, and [support-dichotomy.md](../findings/support-dichotomy.md) itself names a witness outside it, *"the $\Lambda^+/\Lambda^-$ pair on four **shared** coordinates"*. It also assumes criticality, which L66 disclaims two paragraphs above the sentence. So Theorem A has the stronger conclusion (local maxima) on a narrower hypothesis, and L66 has the weaker conclusion (global maxima) on a wider one. **Neither contains the other, and L66 is the number the record should be citing for the decomposable stratum.**

**And the saddle lemma is correct, and generalises.** Independently, at $k=2$ with $A_1\circ A_2=0$ and $\langle A_1,A_2\rangle=0$: restrict $P$ to the circle $t\mapsto\cos t\,A_1+\sin t\,A_2$, where additivity gives $f(t)=\cos^3t\,\theta_1+\sin^3t\,\theta_2$. Then $f'=3\sin t\cos t(\theta_2\sin t-\theta_1\cos t)$, so at an interior critical point $\theta_1=\mu\sin t$, $\theta_2=\mu\cos t$ for some $\mu$, whence $\theta=f=\mu\sin t\cos t$ and $f''=3\sin t\cos t(\theta_2\cos t+\theta_1\sin t)=3\mu\sin t\cos t=3\theta$. **The tangent direction is $\propto\lVert W_2\rVert^2W_1-\lVert W_1\rVert^2W_2$, matching ATTEMPTS.md's eigenvector, and the derivation uses only $\circ$-orthogonality, never coordinate disjointness.** So the repair the brief asks for is available: state Theorem A on $\circ$-orthogonal Frobenius-orthogonal pairs, number it, and L66 and it become one family instead of three unlinked copies.

## D4, [results.md:254](../results.md#L254)'s added clause is FALSE. REFUTED, with a witness built from objects the record already holds

The canonical one-line entry appends a clause the findings file does not carry:

> *"Then no maximizer of $P$ on the unit sphere of $\mathcal W_n$ is $\circ$-decomposable; **the value of such a sum is strictly below $\min_i\lvert\theta_i\rvert$**."*

**Witness.** Work at $n=12$ and put $A_1$ = padded $W_{\mathbb{CP}^2}$ on coordinates $1$–$4$, with $\theta_1=P(A_1)=\sqrt{3/2}=1.224745$ at every $n\ge4$ ([problem.md:149](../findings/problem.md#L149)), and $A_2$ = the balanced product $S^4\times S^4$ on coordinates $5$–$12$, with $\theta_2=\theta_0(8)=\sqrt{84}/8=1.145644$. Disjoint coordinate blocks are $\circ$-orthogonal ([target.md:415](../findings/target.md#L415)), so this is a $\circ$-decomposition. Take $a_1=0.99$, $a_2=\sqrt{1-0.9801}=0.141067$; both are nonzero and $a_1^2+a_2^2=1$, so every clause of the definition holds. Additivity gives

$$P(W)=a_1^3\theta_1+a_2^3\theta_2=0.970299\cdot1.224745+0.002807\cdot1.145644=1.191582,$$

against $\min_i\lvert\theta_i\rvert=1.145644$. **$P(W)>\min_i\lvert\theta_i\rvert$, by a margin of $0.046$.** Both terms are positive, so even the first alone, $0.97\cdot1.224745=1.188$, already exceeds $\min_i\lvert\theta_i\rvert$; the witness needs no fine arithmetic, only $\sqrt{3/2}>\theta_0(8)$, which is [problem.md:66](../findings/problem.md#L66)'s own fact that $\theta_0(n)<\sqrt{3/2}$ for $n\le11$.

**Where the false clause came from.** It is [nondegeneracy.md:361](../findings/nondegeneracy.md#L361)'s *"Hence $\lvert\theta\rvert<\min_i\lvert\theta_i\rvert$"*, which is the harmonic-square law $1/\theta^2=\sum_i1/\theta_i^2$, and that law holds only when $W$ **and every piece** are critical, which pins the coefficients to $a_i=\theta/\theta_i$ rather than leaving them free. **L66's statement, three lines earlier in the same bullet, expressly drops criticality.** The clause is the consequence of a hypothesis L66 discards, grafted onto L66's conclusion. **Repair: delete the clause from [results.md:254](../results.md#L254), or restate it as "at a critical $\circ$-decomposition with critical pieces".**

## D5, [results.md:732](../results.md#L732)'s canonical proof breaks at the step that carries the content. CONFIRMED

The canonical block runs the chain against $\max_i\lvert P(A_i)\rvert$ rather than against $M(n)$:

> *"$\lvert P(W)\rvert\le\sum_i\lvert a_i\rvert^3\lvert P(A_i)\rvert<\max_i\lvert P(A_i)\rvert$, so one summand alone does better."*

That last inequality is strict only when $\max_i\lvert P(A_i)\rvert>0$, and **that can fail under the stated hypotheses**. $P$ is odd and continuous on the unit sphere of $\mathcal W_4$, which is connected, so it takes the value $0$; pick $A_1$ on coordinates $1$–$4$ and $A_2$ on coordinates $5$–$8$ at $n=8$, each with $P(A_i)=0$. They are $\circ$-orthogonal, and the display reads $0<0$. **"One summand alone does better" is false there too**, no summand does better; they all give $0$.

The conclusion survives, because $P(W)=0<M(n)$. **But the repair is to compare against $M(n)$, as [support-dichotomy.md](../findings/support-dichotomy.md) does, not against the summands' own values**, which is precisely the difference between the two statements of the same lemma sitting in the record.

## D6, the $\lvert a_i\rvert$ repair has not reached the findings index. CONFIRMED, cosmetic but it is the exact defect r281 fixed

[findings/INDEX.md:51](../findings/INDEX.md#L51) states the chain as $P(W)=\sum a_i^3P(A_i)\le M(n)\max a_i<M(n)$, **$\max a_i$, with no absolute value.** The file it summarises records, in italics, that the absolute values are load-bearing and that dropping them makes the chain false at any negative coefficient. $\max_ia_i$ is negative whenever every $a_i$ is, and the display is then an inequality between a nonnegative left side and a negative right side.

## D7, the two diagram nodes label a second claim "L66", and L66 disclaims it. CONFIRMED

[diagram-closed.tex:79](../report/sections/diagram-closed.tex#L79) reads *"no maximizer is $\circ$-decomposable; support $s$ forces a padding, $\theta\le M(s)$ --- target is $\circ$-indecomposable, $s\ge12$"* under the single tag `L66`. **The support/padding half is not L66 and contradicts it**: the lemma's own file says *"the pieces' support dimensions never enter"* and *"a $\circ$-splitting does **not** force $n_i<n$"*, with two witnesses. [diagram.tex:68](../report/sections/diagram.tex#L68) carries the same text but tags it `L66, \S\ref{sec:ledger}`, so there the second half at least has somewhere else to attach.

## D8, the L66 block points at the wrong heading. CONFIRMED, navigability

The block at [support-dichotomy.md:33](../findings/support-dichotomy.md#L33) is a definition and one sentence, and its italic note reads *"the argument is in this file under **'This is not new'**"*. **The argument is not there.** The proof is at lines 7–9, under the file's H1 and before any `##`; the `## This is not new` heading at line 21 carries three sentences of cross-file attribution and one retraction, and no mathematics. A reader following the pointer arrives at the section that contains D3's false claim and no proof.

## D9, "strictly weaker" at [support-dichotomy.md:15](../findings/support-dichotomy.md#L15) is true only on critical pairs. Precision note

The sentence *"at $k=2$, criticality plus **ordinary** orthogonality already gives exact additivity"* is **correct**, and I get it in one line: $T(A,A,B)=\langle Q(A),B\rangle=\theta_A\langle A,B\rangle=0$ and $T(A,B,B)=\langle Q(B),A\rangle=\theta_B\langle A,B\rangle=0$, so the two cross terms of the cubic expansion drop.

Its label **"strictly weaker than the hypothesis used here"** is right only under a restriction the sentence does not state. **Restricted to critical pairs** with $\theta_A\ne0$, $\circ$-orthogonality implies ordinary orthogonality ([second-order.md:318](../findings/second-order.md#L318)) and the file's own $0.664362$ witness shows the converse fails, so it is strictly weaker there. **Against L66's actual hypothesis, which carries no criticality, the two are incomparable**, $\circ$-orthogonality implies nothing about criticality, so it cannot imply "criticality plus orthogonality".

## What I checked and found sound

- **The inner bound.** $\lvert a_i\rvert^3=\lvert a_i\rvert\cdot a_i^2\le\max_j\lvert a_j\rvert\cdot a_i^2$, summed against $\sum_ia_i^2=1$. Correct.
- **$\lvert P(A_i)\rvert\le M(n)$.** $P$ is a cubic form, so $P(-A_i)=-P(A_i)$; $-A_i$ is a unit element because $\mathcal W_n$ is a vector space; both $\pm P(A_i)\le M(n)$. Correct. The maximum exists: $P$ is continuous and the unit sphere of $\mathcal W_n$ is compact.
- **$\max_i\lvert a_i\rvert<1$.** $a_j^2=1-\sum_{i\ne j}a_i^2$, and $k\ge2$ with every $a_i\ne0$ puts at least one strictly positive term in that sum. Correct.
- **The quantifier is uniform.** Nothing in the chain depends on $k$ beyond $k\ge2$, or on $n$ beyond $M(n)>0$; $k$ may run to $\dim\mathcal W_n$. The statement is vacuous at $n\le3$, where $\mathcal W_n=0$.
- **The conclusion's logic.** The chain derives $P(W)<M(n)$ from the decomposition data alone and never uses $\lVert W\rVert=1$, which matters, because under the definition as written $\sum_ia_i^2=1$ does **not** force $\lVert W\rVert=1$: Frobenius orthogonality of the pieces is a consequence of $\circ$-orthogonality only at critical pieces (D9). A maximiser has $\lVert W\rVert=1$ and $P(W)=M(n)$, so the contradiction stands either way.
- **The retractions are complete.** The withdrawn induction on $n$, its unused base cases $5\le n_i\le11$, and the false inductive claim $\lvert\theta_i\rvert\le\theta_0(n_i)$ survive nowhere: [results.md:734](../results.md#L734) and the report remark both carry the positive replacement ("supports no induction on $n$"), and [nondegeneracy.md:363](../findings/nondegeneracy.md#L363)'s surviving induction runs over **disjoint coordinate blocks**, where $n_i<n$ does hold, so the "does not descend" objection does not reach it. The $\lvert a_i\rvert^3$ repair is present in [support-dichotomy.md](../findings/support-dichotomy.md), [results.md](../results.md) and [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex), everywhere except the index row at D6.
- **The norm ambiguity is immaterial.** $\lVert A\circ B\rVert=0.664362$ at [support-dichotomy.md:15](../findings/support-dichotomy.md#L15) names no pairing, and [conventions.md](../findings/conventions.md) records that half-trace and plain Frobenius differ by $\sqrt2$, so the figure is ambiguous between $0.664362$ and $0.939552$ (or $0.469777$). **The claim it carries is a non-vanishing**, which no positive rescaling touches. A reporting defect with no mathematical consequence; naming the pairing costs one word.
- **The r283/r284 report defect is half repaired.** The `certificate` that belongs to Lemma 41 now sits **above** Lemma 66 in [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex). The *"What blocks it, and what has been ruled out as a source"* paragraph, which r284 named in the same breath and which discusses $\lvert\lambda_{\min}\rvert$ and $\Delta$, is **still below Lemma 66's remark** and still reads as commentary on it. Lemma 66 has no $\lambda_{\min}$ and no $\Delta$.

## Citation sweep, what uses L66, and whether the use is inside its hypotheses

Grepping the statement rather than the identifier, across [results.md](../results.md), [findings/](../findings/), [routes.md](../routes.md), [plan.md](../plan.md) and [report/](../report/):

| use | inside the hypotheses? |
| --- | --- |
| [09-status.tex:172](../report/sections/09-status.tex#L172) | **yes**, reproduces the chain verbatim, including the $\lvert a_i\rvert$ and the "no criticality of the pieces" clause |
| [07-gradedness-split.tex:1157](../report/sections/07-gradedness-split.tex#L1157), Lemma 66 | **yes** for the statement and proof; carries D2's $M(n)>0$ gap and D1's unstated ingredient |
| [second-order.md:338](../findings/second-order.md#L338), *"decomposable points are capped by their own pieces and can never set a new maximum"* | **yes** as a value statement |
| [INDEX-traps.md:35](../findings/INDEX-traps.md), [routes.md:19](../routes.md#L19), [fence-posts.md:265](../findings/fence-posts.md#L265), the $\lvert\theta\rvert\le M(n)/\sqrt2$ conversion "valid only on $\circ$-decomposables" | **yes**, and correctly scoped: they are the fence post saying the conversion is unavailable on the set it is needed for |
| [results.md:254](../results.md#L254), the $\min_i\lvert\theta_i\rvert$ clause | **NO, D4, refuted** |
| [results.md:734](../results.md#L734), the canonical proof | **NO, D5**, and it silently redefines $\circ$ as the polarisation of an undefined symmetric $T$ rather than of $Q$, which assumes D1's ingredient into the definition instead of proving it |
| [diagram-closed.tex:79](../report/sections/diagram-closed.tex#L79) | **NO, D7**, the support/padding half is disclaimed by the lemma |
| [findings/INDEX.md:51](../findings/INDEX.md#L51) | **NO, D6**, drops the absolute values |
| [second-order.md:60](../findings/second-order.md#L60), *"it says a maximiser is $\circ$-indecomposable"* | **the hypothesis is dropped.** The $\dim E(1)=1$ route needs the pieces **critical**, [second-order.md:322](../findings/second-order.md#L322) states this and line 60 does not, since $L_eA_i=(a_i\theta_i/\theta)A_i$ requires $Q(A_i)\parallel A_i$. It excludes a strictly narrower class than L66 |
| [plan-maximizer.md:88](plan-maximizer.md#L88), *"$\dim E(1)=1$, which is Lemma L66 by a second proof"* | **NO**, same elision; it is a weaker statement, not a second proof of the same one. The item it justifies dropping is nonetheless safely dropped, because L66 itself covers it |
| [second-order.md:318](../findings/second-order.md#L318), *"Frobenius orthogonality is implied, not assumed"* | **the hypothesis is dropped.** $\langle B,Q(A)\rangle=\theta_A\langle A,B\rangle$ holds at critical $A$ only; without it, $\circ$-orthogonality implies nothing about $\langle A,B\rangle$ |
| [nondegeneracy.md:403](../findings/nondegeneracy.md#L403) | **yes** for its own claim, but the lemma it points at is [ATTEMPTS.md:985](../ATTEMPTS.md#L985) and not in that file, D3 |

**No use anywhere applies L66 to a local maximum**, and none supplies merely-orthogonal pieces where $\circ$-orthogonality is needed. The two places where orthogonality and $\circ$-orthogonality are related, [second-order.md:318](../findings/second-order.md#L318) and [support-dichotomy.md:15](../findings/support-dichotomy.md#L15), both get the **direction** right; what they drop is criticality.

## Verdicts

| # | claim | verdict |
| --- | --- | --- |
|, | **Lemma L66 as stated: no maximizer of $P$ on the unit sphere of $\mathcal W_n$ is $\circ$-decomposable** | **CONFIRMED** |
| D1 | additivity from $A_i\circ A_j=0$ | **CONFIRMED**, ingredient (total symmetry of $T$) true, derived twice, and unstated in the file, filed by r281 and twice by r283, still unapplied |
| D2 | $M(n)$ undefined; $M(n)>0$ unstated | **CONFIRMED** as a defect, repairable in two lines |
| D3 | "nondegeneracy.md states it verbatim and stronger" | **REFUTED**, the lemma is [ATTEMPTS.md:985](../ATTEMPTS.md#L985), unnumbered, and its hypothesis is narrower, not wider |
| D4 | "the value of such a sum is strictly below $\min_i\lvert\theta_i\rvert$" | **REFUTED**, witness at $n=12$, $P(W)=1.1916$ against $\min_i\lvert\theta_i\rvert=1.1456$ |
| D5 | [results.md:734](../results.md#L734)'s chain against $\max_i\lvert P(A_i)\rvert$ | **REFUTED as a proof** (reads $0<0$ when every $P(A_i)=0$); the conclusion stands via $M(n)>0$ |
| D6 | [findings/INDEX.md:51](../findings/INDEX.md#L51)'s $\max a_i$ | **CONFIRMED** defect |
| D7 | the two diagram nodes tagged L66 | **CONFIRMED** defect on [diagram-closed.tex:79](../report/sections/diagram-closed.tex#L79) |
| D8 | the block's pointer to "This is not new" | **CONFIRMED** defect |
| D9 | "strictly weaker" at line 15 | **CONFIRMED** as true on critical pairs, unlabelled as such |

**Overall: the theorem is CONFIRMED and its proof is sound once two unstated facts are supplied, total symmetry of $T$ and $M(n)>0$, both of which I derive above and neither of which is hard. What fails is the record around it.** Two of the three restatements of L66 outside [support-dichotomy.md](../findings/support-dichotomy.md) are wrong: the canonical entry at [results.md:254](../results.md#L254) carries a clause that a two-block witness refutes, and its proof at [results.md:734](../results.md#L734) proves a strict inequality that is not always strict. The file's own account of what else the record holds is wrong in both of its claims about the stronger version. **The lemma is right; five of the ten places that state or cite it are not.**

**Priority of repair.** D4 first, it is a false mathematical sentence in the canonical results file. Then D5, D2, D3, D1, then D6–D8.
