# Review r562, Lemma L99 (diagonal critical point, two components carrying an edge)

Reviewer r562, independent adversarial audit. Target: [Lemma L99](../findings/diagonal-half.md) in [findings/diagonal-half.md](../findings/diagonal-half.md). Analysis-only footing: no computation beyond screening a claim about to be recorded, and any screen is labelled as such.

Status: **COMPLETE**, REPAIRED overall, with one REFUTED component (D1).

## Setting, fixed from the definitions before anything else

Throughout, $M$ is the **sectional matrix** of a coordinate-diagonal Weyl operator, in the normalisation [conventions.md](../findings/conventions.md) fixes: symmetric, hollow, $M\mathbf1=0$, and $\operatorname{tr}M^2=\sum_{a,b}M_{ab}^2=2$ at unit Weyl norm, the sum over **ordered** pairs. The value is $\theta=\tfrac12\big(\sum_{a,b}M_{ab}^3+\operatorname{tr}M^3\big)$ and criticality is [diagonal-half.md](../findings/diagonal-half.md)'s

$$M^{\circ2}+M^2=\theta M+\operatorname{diag}(s),\qquad s_i=\sum_jM_{ij}^2,$$

whose diagonal is an identity ($0+s_i=0+s_i$), so the content is the off-diagonal $M_{ij}^2+(M^2)_{ij}=\theta M_{ij}$.

The second-order operator on the locus is $\mathcal L(N)=\mathrm{hol}\big(M\circ N+\tfrac12(MN+NM)\big)$, $\mathrm{hol}$ the hollowing that the block itself installs as the correct object ($\tfrac12D[\Phi-\operatorname{diag}(s)]$), and $L_e=\mathcal L/\theta$. **Admissible** means $N$ symmetric, hollow, $N\mathbf1=0$, $N\perp M$, the last being [Lemma L24](../findings/second-order.md)'s $N\perp W$, which [Lemma L120](../findings/second-order.md) confirms cuts $\mathcal D_n$ and nothing else.

The **support graph** is $\{ab:M_{ab}\ne0\}$; a **component** is a component of it, and a component **carries an edge** when it has more than one vertex.

**Two calibration facts, used below.** The radial direction is always a $\theta$-eigenvector: $\mathcal LM=\mathrm{hol}(M^{\circ2}+M^2)=\mathrm{hol}(\theta M+\operatorname{diag}(s))=\theta M$. And [Lemma L24](../findings/second-order.md) gives $\mathrm{Hess}_SP=6\theta(L_e-\tfrac12\mathrm{Id})$ on $W^\perp$, so an admissible $N$ with $\mathcal LN=\theta N$ at $\theta>0$ makes the Hessian strictly positive along $N$, failure of second-order maximality.

## Verdicts

### D1, the heading is right, the body states the withdrawn version, twice, in bold. REFUTED as written.

**The heading** (*two components carrying an edge*), **is true, and I prove it below (D2/D3).** The body does not state it. It states, twice and in bold:

> **So every disconnected diagonal critical point with $\theta>0$ has $\lambda_{\max}\ge\theta>\theta/2$ and fails second-order maximality**

> **every disconnected diagonal critical point with $\theta>0$ fails second-order maximality, at eigenvalue exactly $\theta$**

That is the **unrepaired** hypothesis, and the repair is recorded **twelve lines above the heading, in the same file**:

> Padded points break the consequence outright. $S^4\times S^4$ plus an isolated vertex at $n=9$ is disconnected by the record's own criterion ($\dim\ker M=2=\#$components) and has $\theta>0$, yet $\lambda_{\max}(L_e)=0.5714$, and the indicator $N$ there has $\cos(N,M)=+1.000000$, i.e. it **is** the radial direction […] *The repair is "at least two components **carrying an edge**", not "disconnected".*

**The refutation, from the definitions and by a route the block does not use.** Let $M$ have exactly one edge-carrying component $C$ and $m\ge1$ isolated vertices. Every block-scaling deformation $N=\bigoplus_ca_cB_c$ has $B_c=0$ off $C$, so $N=a_CB_C=a_CM$: the whole family collapses onto the radial line, and $N\perp M$ forces $N=0$. So the block's eigenvector does not exist at such a point, and the quantitative claim $\lambda_{\max}\ge\theta$ is **false** at the record's own witness, where $\lambda_{\max}(L_e)=0.5714<1$. *(The reported $0.5714$ is itself the proof that the record's $\lambda_{\max}$ excludes the radial direction: with it included the value is exactly $1$, by the calibration fact above.)*

The conclusion "fails second-order maximality" happens to survive at that witness ($0.5714>\tfrac12$), for an unrelated reason. **The argument does not reach it**, and the eigenvalue clause "exactly $\theta$" is refuted outright.

**Verdict: REFUTED as written; the heading's statement is CONFIRMED and proved below.** The repair is to delete both sentences and replace them with D3.

**Two aggravations.** *(i)* The paragraph immediately above the heading also says **"'Disconnected' is not the operative hypothesis either"**, so the file states the correction twice, on both sides of sufficiency and necessity, and the body still asserts it. *(ii)* [reviews/plan-maximizer.md:100](plan-maximizer.md) already flagged exactly this: *"Lemma L99's hypothesis […] must exclude paddings"*. The defect was seen, filed, and never applied to the text it corrects.

### D2, the scaling and value laws are two-line derivations. Measurement stands where a proof was available. REPAIRED.

The block verifies to $10^{-17}$ at three points what follows from block-orthogonality alone. Both directions:

**(a) Every disconnected diagonal critical point IS such a direct sum**, this direction the block never states, and it is what removes the hypothesis. Let $M$ be critical with components $C_1,\dots,C_k$ and blocks $B_c$. Set $\lambda_c=\lVert B_c\rVert_F/\sqrt2>0$ and $M_c=B_c/\lambda_c$, so $\operatorname{tr}M_c^2=2$. Each $M_c$ is hollow, symmetric and $M_c\mathbf1=0$ (the row sum of $M$ at $a\in C_c$ has no terms outside $C_c$). Off-diagonal criticality inside $C_c$ reads $\lambda_c^2\big(M_c^{\circ2}+M_c^2\big)_{ab}=\theta\lambda_cM_{c,ab}$, i.e. **$M_c$ is itself a diagonal critical point at $\theta_c:=\theta/\lambda_c$**, and $\theta_c>0$ whenever $\theta>0$.

**(b) The scaling law.** Conversely, for $M=\bigoplus_c\lambda_cM_c$ the cross-block entries of $M$, $M^{\circ2}$ and $M^2$ all vanish, so criticality is one equation per block: $\lambda_c^2\theta_cM_{c,ab}=\theta\lambda_cM_{c,ab}$, giving **$\lambda_c\theta_c=\theta$ at every block carrying an entry**. A block with no entry is unconstrained, which is precisely the padding loophole of D1.

**(c) The value law.** $\operatorname{tr}M^2=2\sum_c\lambda_c^2$, so unit norm is $\sum_c\lambda_c^2=1$; substituting $\lambda_c=\theta/\theta_c$ gives $\theta^2\sum_c\theta_c^{-2}=1$, hence

$$\theta=\Big(\sum_c\theta_c^{-2}\Big)^{-1/2}$$

on the record's $\theta>0$ branch (both signs solve it, $-M$ being critical at $-\theta$).

**(d) Consistency, which is the block's "verified to $10^{-17}$".** $\theta(M)=\tfrac12\sum_c\lambda_c^3\big(\sum M_{c,ab}^3+\operatorname{tr}M_c^3\big)=\sum_c\lambda_c^3\theta_c=\theta^3\sum_c\theta_c^{-2}=\theta$. **An identity, not a measurement.**

**(e) The block's own aside is derivable too.** *"with equal scaling instead it is not critical at all […] unless the summands share a $\theta$"* is (b) read at $\lambda_c\equiv1/\sqrt k$: $\theta_c=\theta\sqrt k$ for every $c$.

**Verdict: CONFIRMED as mathematics, REPAIRED as evidence**, the numerics are correct and superfluous. **The record already carries the law twice over**: [nondegeneracy.md:359](../findings/nondegeneracy.md) states $\tfrac1{\theta^2}=\sum_i\tfrac1{\theta_i^2}$ at a decomposable critical point (also as a measurement, *"verified at twenty-five held-out block sums"*), and [reviews/plan-diagfam.md:110](plan-diagfam.md) records that it is *"derived from (C) and $Q(tW)=t^2Q(W)$ and block additivity"*. **Three copies, two of them measurements, and the two-line proof on none of them.**

### D3, the heading's statement, proved, and it is sharper than the heading. CONFIRMED.

> **Let $M$ be a diagonal critical point with $\theta>0$ whose support graph has $k\ge2$ components carrying an edge. Then $\mathcal L$ has eigenvalue $\theta$ on an admissible subspace of dimension $\ge k-1$, so $\lambda_{\max}(L_e\vert_{\mathcal D_n\cap M^\perp})\ge1>\tfrac12$ and $M$ fails second-order maximality.**

**Proof.** Decompose as in D2(a): $M=\bigoplus_c\lambda_cM_c$ with $\lambda_c\theta_c=\theta$ over the $k$ edge-carrying components. For $a\in\mathbb R^k$ put $N=\bigoplus_ca_c\lambda_cM_c$ (equivalently $N=\tfrac12(AM+MA)$ for $A=\operatorname{diag}(a)$ constant on components, since $M_{ab}\ne0$ only within one). Then $N$ is symmetric, hollow, $N\mathbf1=0$, and

$$\langle N,M\rangle_F=\sum_ca_c\lambda_c^2\operatorname{tr}M_c^2=2\theta^2\sum_ca_c\theta_c^{-2},$$

so **admissibility is the single linear condition $\sum_ca_c\theta_c^{-2}=0$** (the record's own repair, here derived), cutting the $k$-dimensional family to $k-1$ dimensions, nonzero as soon as $k\ge2$. On the block $c$,

$$\mathcal LN\big\vert_c=\mathrm{hol}\Big(a_c\lambda_c^2\big(M_c^{\circ2}+M_c^2\big)\Big)=a_c\lambda_c^2\theta_cM_c=\theta\cdot a_c\lambda_cM_c=\theta N\big\vert_c,$$

using $M_c$'s criticality and then $\lambda_c\theta_c=\theta$. Cross-block entries vanish on both sides. So $\mathcal LN=\theta N$ exactly. $\square$

**Three things this adds to the block.** *(i)* The hypothesis is **"at least two"**, and the eigenspace grows: $\dim\big(E_{\mathcal L}(\theta)\cap M^\perp\big)\ge k-1$, so three or more components give a multi-dimensional violation, the brief's question, answered. *(ii)* No hypothesis that $M$ was *constructed* as a direct sum is needed; D2(a) supplies it. *(iii)* The mechanism in one sentence: **$\theta$ is always an $\mathcal L$-eigenvalue on the radial line, and disconnection raises its multiplicity to $k$, so $k\ge2$ leaves a $\theta$-eigenvector after the radial cut.** That is why "carrying an edge" is exactly the right hypothesis and "disconnected" exactly the wrong one, an edgeless component contributes nothing to the eigenspace.

**Verdict: CONFIRMED, and the numerics ("row sums $6\times10^{-17}$", "ratio $1.000000000$") are superfluous.**

### D4, the kernel claim has a three-line proof from [Lemma L129](../findings/diagonal-half.md), 290 lines below it in the same file. REPAIRED.

The block: *"$\dim\ker M$ is the NUMBER OF CONNECTED COMPONENTS, not $1$, verified to $10^{-15}$ over some $400$ exact critical points."* Both inclusions are already on the record, unjoined.

**Proof.** [Lemma L97](../findings/diagonal-half.md) gives $M^2-\theta M=L(w)$, the weighted graph Laplacian with $w_{ab}=M_{ab}^2\ge0$, the diagonal is $s_a$ by hollowness, the off-diagonal $-M_{ab}^2$ by off-diagonal criticality. [Lemma L129](../findings/diagonal-half.md) then states, in its own proof, both halves needed:

- $\ker L(w)=\operatorname{span}\{\mathbf1_{C_t}\}$ over the components of $\{w_{ab}>0\}$, which is the support graph;
- $M\mathbf1_{C_t}=0$ for every component, *"for $a\in C_t$, $(M\mathbf1_{C_t})_a=\sum_{b\in C_t}M_{ab}=\sum_bM_{ab}=0$"*.

So $\ker M\supseteq\operatorname{span}\{\mathbf1_{C_t}\}$; and $Mx=0\Rightarrow L(w)x=M^2x-\theta Mx=0\Rightarrow x\in\ker L(w)=\operatorname{span}\{\mathbf1_{C_t}\}$. Hence

$$\ker M=\ker L(w)=\operatorname{span}\{\mathbf1_{C_t}:t\},\qquad\dim\ker M=\#\text{components}. \qquad\square$$

**Verdict: CONFIRMED as a theorem, REPAIRED as evidence.** The reverse inequality the brief could find no argument for is [Lemma L129](../findings/diagonal-half.md) minus one line. **The census of $400$ points decides nothing that the identity does not decide at every critical point and every $n$.** *This is the third time in this audit that the fact settling the block sits inside the block's own file.*

**One consequence worth stating, since the block uses the kernel as its disconnection test.** $\ker M$ counts **all** components, edgeless ones included, which is exactly why $\dim\ker M\ge2$ is the wrong criterion for D3 and why the padded witness of D1 passes it while failing the conclusion. The right test is $\dim\ker L(w)$ restricted to non-singleton components, equivalently $\#\{c:\lVert B_c\rVert\ne0\}\ge2$.

### D5, the conclusion is already on the record, with the same eigenvector, and the record has already said so. DUPLICATION, partly.

[ATTEMPTS.md:985](../ATTEMPTS.md) carries, unnumbered:

> *Theorem A (direct-sum saddle lemma).* Any critical point with $\theta>0$ that splits over disjoint coordinate blocks is a saddle: $H=\lVert W_2\rVert^2W_1-\lVert W_1\rVert^2W_2$ gives $\mathrm{Hess}=+3\theta\lVert H\rVert^2$ exactly.

**That is L99's eigenvector.** In D3's notation with two blocks, $W_c=\lambda_cM_c$ and $\lVert W_c\rVert_F^2=2\lambda_c^2$, so $H\propto\lambda_2^2\lambda_1M_1-\lambda_1^2\lambda_2M_2$, the case $a_c\propto(\lambda_2^2,-\lambda_1^2)$, which satisfies $\sum a_c\theta_c^{-2}=\theta^2(\theta_2^{-2}\theta_1^{-2}-\theta_1^{-2}\theta_2^{-2})=0$, i.e. **is admissible for the same reason**. And the conclusions agree numerically: [Lemma L24](../findings/second-order.md)'s $\mathrm{Hess}_SP=6\theta(L_e-\tfrac12)$ at $L_eH=H$ gives exactly $+3\theta\lVert H\rVert^2$.

**And [ATTEMPTS.md:2749–2757](../ATTEMPTS.md) has already ruled on it**, under the heading *"The 'disconnected lemma' was a novelty misclassification, and the re-derivation added nothing"*: *"The claim is on the record four times over."* **That ruling was archived and the numbered Lemma left standing.**

**Where I part company with that ruling, L99 does have an increment, and it is D2(a).** ATTEMPTS.md's Theorem A is stated over a *given* split; nothing there says a disconnected diagonal critical point admits one with critical pieces. D2(a) is that bridge, and it is what makes the graph hypothesis usable. Two further increments are real: the hypothesis in graph terms, and D4.

**But the increment does not include the conclusion**, and two things follow. *(i)* [LEDGER.md:1060](../findings/LEDGER.md) already records as **Owed** that *"L66 and ATTEMPTS.md's Theorem A can be joined into one numbered family instead of three unlinked copies"*; L99 is a fourth copy and belongs in that join. *(ii)* **ATTEMPTS.md's Theorem A carries L99's own D1 defect**: a "split over disjoint coordinate blocks" with $W_2=0$ is a padding, and there $H=0$, the conclusion "is a saddle" is asserted with no direction behind it. The repair *"both pieces nonzero"* is owed there too, and the graph reading is what names it.

**Verdict on D5: the conclusion is DUPLICATED, the bridge and the kernel statement are NEW.**

### D6, the retractions. Two are one-line theorems, one is near-vacuous, one is unverifiable.

**(a) *"they are not three candidates but two: criticality forces $\mathrm{proj}(M^{\circ2})=-\mathrm{proj}(M^2)$ identically, verified here to $7\times10^{-17}$"*, CORRECT, and it is one line, not a measurement.** Let $\mathrm{proj}$ be the orthogonal projection onto $\mathcal D_n\cap M^\perp$ (the block never says which projection; this is the only reading its numbers fit). Criticality reads $M^{\circ2}+M^2=\theta M+\operatorname{diag}(s)$. Hollowing kills $\operatorname{diag}(s)$; $\perp M$ kills $\theta M$. Hence $\mathrm{proj}(M^{\circ2})+\mathrm{proj}(M^2)=0$. $\square$ *The equal pair $0.211$, $0.211$ and the repeated $0.059$ are this identity being measured.*

**(b) *"the vanishing at sphere products is a dimension count (the invariant admissible subspace is $0$-dimensional there"*), CORRECT, and it is three lines.** $\mathrm{Aut}(M)\supseteq S_p\times S_q$ at $S^p\times S^q$, and a symmetric hollow $S_p\times S_q$-invariant matrix is block-constant: $\alpha$ within $P$, $\beta$ within $Q$, $\gamma$ across, a $3$-dimensional space. Zero row sums impose $(p-1)\alpha+q\gamma=0$ and $(q-1)\beta+p\gamma=0$ (independent for $p,q\ge2$), leaving dimension $1$. That line contains $M\ne0$, so it **is** $\mathbb RM$, and $\mathbb RM\cap M^\perp=0$. $\square$

**(c) *"the representation-theoretic obstruction is a property of SYMMETRIC points only"*, the evidence is one point and nearly self-fulfilling. Observation-grade at best.** At the cited $n=8$ point $\lvert\mathrm{Aut}(M)\rvert=2$ and the top eigenspace is one-dimensional. $\mathcal L$ is $\mathrm{Aut}(M)$-equivariant, so a one-dimensional eigenspace is $\mathrm{Aut}$-stable and its generator is a $\pm1$ eigenvector of the involution, **fixed or anti-fixed, with nothing else possible**. The measurement therefore reports a single bit. And with $\lvert\mathrm{Aut}(M)\rvert=2$ the invariant subspace is roughly half of everything, so *"invariant directions reaching the full $\lambda_{\max}$"* is close to automatic. **The surviving half (that a *uniform* equivariant recipe fails because it must also fire at symmetric points), is the part carrying content**, and its evidence ($0.000$ against $\theta/2=0.335$) is at unnamed points.

**(d) *"$\Pi_{\mathcal W}H_A=c^\ast[D_X,W]$ exactly for mixed $A$"*, UNVERIFIABLE as written.** $H_A$ and $D_X$ occur **nowhere else in [findings/](../findings/) or [results.md](../results.md)**, and $\Pi_{\mathcal W}$ has no row in [conventions.md](../findings/conventions.md), which defines $\Pi$ as the projection onto $W^\perp$, a different object. The internal consistency check does pass ($c^\ast=0$ at $p=q$, matching *"the $p=q$ annihilation is simply the case $c^\ast=0$"*), and that is all a reader can check.

**(e) *"the block-graph statistic fails at $n=12$ too"*, Observation at $n=12$, and its subject is undefined.** "Block graph" is named nowhere on the record; the block itself says there are *"all seven readings"* of it, which is a statement that the object has no definition. The three points and the value $1.152$ are a census.

**(f) The framing correction, *"a $\Delta>0$ point with $\mathrm{Sym}_0$ maximum $\le\tfrac12$ would refute only the $\mathrm{Sym}_0$ certificate, not V3"*, CORRECT and immediate**, since $\mathrm{Sym}_0\subsetneq e^\perp$.

**Completeness of the retractions.** I grepped [findings/](../findings/), [results.md](../results.md), [plan.md](../plan.md), [routes.md](../routes.md) and [ATTEMPTS.md](../ATTEMPTS.md) for *"algebraic candidates"*, *"three candidates"*, *"representation-theoretic obstruction"* and *"block graph"*. **Every one occurs only inside L99's own block.** So no live text rests on a withdrawn version, but the corrections are **orphaned**: four paragraphs correcting statements that exist nowhere, which a reader cannot check against anything. They belong in [ATTEMPTS.md](../ATTEMPTS.md) with the claim they correct, not in a numbered Lemma.

### D7, undefined symbols. Four, three of them load-bearing.

| symbol | where | status |
| --- | --- | --- |
| $\mathrm{Aut}(M)$ | lines 173, 175 | **undefined record-wide**, occurs only in this block. Load-bearing: the "real class" of candidates is defined by it |
| $H_A$, $D_X$ | line 177 | **undefined record-wide**, occur only in this block. The identity they appear in is unreadable |
| $\Pi_{\mathcal W}$ | line 177, [target.md:230](../findings/target.md) | no row in [conventions.md](../findings/conventions.md), which gives $\Pi$ a **different** meaning (projection onto $W^\perp$) |
| $\mathrm{proj}$ | line 173 | undefined; recoverable only by inference from (a) above |

**And $\lambda_{\max}$ is written bare in two normalisations twelve lines apart.** The table at lines 132–140 reports *"diagonal $\lambda_{\max}$"* in $L_e$ units (values compared against $\tfrac12$); L99's *"$\lambda_{\max}\ge\theta>\theta/2$"* is in $\mathcal L$ units. Both are correct in their own reading and neither says which. **[Observation L98](../findings/diagonal-half.md), immediately below, records that this exact confusion already cost the file once**, *"an earlier version here quoted $\lambda_{\max}/\theta$, dividing by $\theta$ a second time"*. Write $\lambda_{\max}(\mathcal L)$.

### D8, the norm, checked against [conventions.md](../findings/conventions.md) rather than the block. CONFIRMED.

The block runs at $\operatorname{tr}M^2=2$ with $M$ the $n\times n$ sectional matrix, which is [conventions.md](../findings/conventions.md)'s $\lVert K\rVert_F^2=2$ at a unit Weyl tensor, ordered sum. Every step of D2–D4 is invariant under the $\Lambda^2$/Frobenius factor $2$: the scaling law $\lambda_c\theta_c=\theta$ is an equation between entries; unit norm is $\sum\lambda_c^2=1$ in either pairing; admissibility $\sum_ca_c\theta_c^{-2}=0$ carries the constant $\lVert M_c\rVert^2$ as an overall factor and **only the exponent $-2$ enters**, which the block already says and which is right. **No normalisation defect.**

*Two presentational notes.* The block writes $\theta_i$ for the summand values without saying they are the *normalised* summands' values ($\operatorname{tr}M_i^2=2$ each), under any other normalisation of $M_i$ the formula is false. And $\theta=(\sum\theta_c^{-2})^{-1/2}$ selects the positive root; $-M$ is critical at $-\theta$ and solves the same equation. The record's $\theta>0$ convention covers this, unstated here.

### D9, the quantifier, and three or more components. The heading understates.

**At every such point, not at those examined.** D3 is a proof with no point in it: hypotheses are $\theta>0$, diagonal, critical, $\ge2$ edge-carrying components. The block's *"verified to $10^{-17}$ at [three named sums]"* is a check of a theorem.

**"Two" should read "at least two", and $k$ components give more than one violating direction.** The admissible block-scalings form $\{a:\sum_ca_c\theta_c^{-2}=0\}$, so

$$\dim\big(E_{\mathcal L}(\theta)\cap\mathcal D_n\cap M^\perp\big)\ \ge\ k-1 .$$

The block reports *"$2$, $3$ and $4$ occurring"* among the censused kernel dimensions; at $k=4$ this is a three-dimensional violation, and the block claims one direction.

**Verdict: CONFIRMED and strengthened.**

### D10, consumers. 21 mentions, all clean on the hypotheses; one misattribution.

- [reviews/REVIEW_r391.md:66–70](REVIEW_r391.md) builds a counterexample from L99's construction using **two copies of $S^3\times S^3$**, both components carry edges, so **inside the hypotheses**. Clean.
- [reviews/plan-diagfam.md:110](plan-diagfam.md) identifies DGK Lemma 3.1 with L99's construction and records that it is *"derived from (C) and $Q(tW)=t^2Q(W)$ and block additivity"*, **the derivation D2 asks for, already written down in a planning file and never folded back**.
- [reviews/plan-maximizer.md:100](plan-maximizer.md) **already filed D1**: *"the padded $S^4\times S^4$ at $n=9$ … yet has $\lambda_{\max}=0.5714$; Lemma L99's hypothesis … must exclude paddings."* Filed, never applied.
- **MISATTRIBUTION.** [reviews/plan-maximizer.md:18](plan-maximizer.md) speaks of *"Lemma L99's quotient $(M_{ac}+M_{ad}+M_{bc}+M_{bd}-2M_{ab}-2M_{cd})/(4\theta)$"* and line 32 lists *"Consumes … Lemma L99"* for it. **That formula is at [diagonal-half.md:195](../findings/diagonal-half.md), inside Observation L98's block** (heading at line 181), not L99's (lines 163–179). Item I12 therefore cites a Lemma for an Observation-grade statement. *No mathematical harm, plan-maximizer.md step 3 rederives the quotient in one line, but the grade it inherits is wrong.*
- [reviews/DERIVE-mx1.md:3](DERIVE-mx1.md) and [reviews/REVIEW_r519.md:165](REVIEW_r519.md) mention L99 only for scope. Clean.
- [findings/INDEX-results.md:114](../findings/INDEX-results.md) carries the **repaired** heading and *"Gate 2: no verdict on the record"*. The index is correct; the body is what is stale.

**No consumer treats the kernel claim or the "disconnected" claim as proved.** The defect is contained in the block.

### The label

**The block is four things under one number, and they do not share a grade.**

| part | grade earned |
| --- | --- |
| D2 scaling and value laws, D2(a) the decomposition bridge | **Lemma**, proved above, no numerics needed |
| D3 the heading's statement, with $k\ge2$ and eigenspace $\ge k-1$ | **Lemma**, proved above |
| D4 $\dim\ker M=\#$components | **Lemma**, proved above from [L97](../findings/diagonal-half.md)/[L129](../findings/diagonal-half.md) |
| D6(a) $\mathrm{proj}(M^{\circ2})=-\mathrm{proj}(M^2)$; D6(b) the $0$-dimensional invariant subspace; D6(f) | **Lemma**, proved above |
| D6(c) the symmetric-point claim, D6(e) the block-graph statistic | **Observation**, at $n=8$ and $n=12$ respectively |
| D6(d) $\Pi_{\mathcal W}H_A=c^\ast[D_X,W]$ | **no grade** until $H_A$ and $D_X$ are defined |
| the two "every disconnected" sentences | **REFUTED**; delete |

**So `Lemma L99` keeps its label, on a smaller and sharper statement, and the numerics leave it entirely.** The block did not need a single one of $10^{-17}$, $10^{-15}$, $400$ points, $7\times10^{-3}$, $6\times10^{-17}$ or $1.000000000$: every one of them measures something proved above by hand.

**What a downgrade owes, for the parts that take one.** D6(c) downgraded to Observation owes: *does a critical point with $\lvert\mathrm{Aut}(M)\rvert>2$ admit an equivariant violating direction, or is the $n=8$ reading an artefact of a two-element group?* D6(e) downgraded owes: *is the block-graph statistic's failure structural, and under which of its seven readings?*, and first, a definition of the statistic. D6(d) owes definitions.

## Overall verdict

**REPAIRED, with one REFUTED component.**

1. **The heading's statement is TRUE and I prove it in eight lines** (D3), with a sharper hypothesis ($k\ge2$) and a sharper conclusion (eigenspace $\ge k-1$) than the block states.
2. **The body states the withdrawn "disconnected" version twice in bold and is REFUTED** (D1) by the record's own witness twelve lines above the heading, and by the direct argument that the block-scaling family collapses onto the radial line when only one component carries an edge.
3. **Four claims verified numerically are proved here by hand** (D2, D4, D6(a), D6(b)), the scaling law, the value law, the kernel dimension, the two-not-three collapse. In each case the settling fact was already on the record: [L97](../findings/diagonal-half.md)/[L129](../findings/diagonal-half.md) in the same file, [nondegeneracy.md:359](../findings/nondegeneracy.md) and [target.md:155](../findings/target.md) two files away, [plan-diagfam.md:110](plan-diagfam.md) in a planning file.
4. **The conclusion duplicates [ATTEMPTS.md](../ATTEMPTS.md)'s unnumbered Theorem A, with the same eigenvector**, and [ATTEMPTS.md:2749](../ATTEMPTS.md) already said so and was archived without acting on the numbered copy (D5). The join is already **Owed** at [LEDGER.md:1060](../findings/LEDGER.md). **And Theorem A inherits L99's padding defect**, which the graph reading is what names.
5. **Four symbols are undefined record-wide**, three of them load-bearing (D7).
6. **Consumers are clean on hypotheses**; one plan item cites L99 for a formula belonging to L98 (D10).

*No computation was performed at any point in this audit. Every claim above is a derivation from the definitions in [conventions.md](../findings/conventions.md) and [diagonal-half.md](../findings/diagonal-half.md); where I cite a numerical value it is the record's own, used only to exhibit the contradiction in D1.*
