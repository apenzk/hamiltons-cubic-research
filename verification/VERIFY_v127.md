# VERIFY v127, L18: the $\tfrac32$-Gram pricing, the two-grant dichotomy, and three thresholds the record calls one

**Cold brief.** Verifier v127, dispatched on [ROUND_L18.md](ROUND_L18.md)'s quoted text ([problem.md](../findings/problem.md):291–313, [results.md](../results.md):224 and :667). **No numerical work was done**: every value below is an exact hand evaluation of a closed form, and every rational is stated as a rational. The programme is on an analysis-only footing ([analysis-only.md](../.claude/rules/analysis-only.md)); no script was run and no screen was needed. Log: [agent_logs/verify-L18-v127.log](../agent_logs/verify-L18-v127.log). Sources read at first hand: [ATTEMPTS.md](../ATTEMPTS.md) §*Lifting Jäger's §3.3 in trace form* (Results 1–13), [findings/LEDGER.md](../findings/LEDGER.md), [findings/conventions.md](../findings/conventions.md), [lean/INDEX.md](../lean/INDEX.md):207, and the primary source [diss_jaeger_florian.txt](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf) in [references/](../references/).

## Claim table

| # | Claim as written | Verdict |
| --- | --- | --- |
| A | The Bianchi correction is a PSD Gram form in $\mathrm{Alt}(R)$ with universal constant $\tfrac32$ | **PROVEN, via a written proof carrying two stated standard gaps** |
| B | It costs at most $24\lVert\mathrm{Alt}(W_-)\rVert^2\lambda_{\max}(\mathrm{Ric}(\lvert W\rvert))$, pointwise and dimension-free | **PROVEN, constant $24$ confirmed by hand from $6\cdot4$** |
| C | *"The answer is **one** exactly-priced term"* | **BROKEN, the source records three $\delta^2$ entries** |
| D | *"§§3.4 and 3.5 then lift at no cost at all"* | **WITHDRAWN as a defect, true on the charitable reading; Lemma 3.4.7's assembly is the unproven residue** |
| E | The dichotomy at $\theta\ge\tilde\theta_0(n)$, granting *"that cross-term bound"* | **HYPOTHESIS-DEBT, seven hypotheses, one named** |
| F | $c(12)\approx1.0\times10^{-3}$ | **HYPOTHESIS-DEBT, output of the E-track certificate, which the record marks never audited** |
| G | *"scalar curvature at least $(n+1)\tilde\theta_0(n)$"* | **BROKEN as a citable sentence, literally false at every critical point; the source means $\operatorname{scal}(\lvert W\rvert)$** |
| H | The repair note's *"$\tilde\theta_0(n)$ … IS $\Theta_n$ UNDER A SECOND NAME. … $\hat\theta_0$ is a third variant of the same thing"* | **BROKEN, three strictly ordered numbers, refuted at the block's own $n=12$** |
| I | *"That width is $\theta_0(12)-\sqrt{3/2}$, between $0.0112$ and $0.0113$"*, and it is [Lemma L13](../findings/curvature-invariants.md)'s denominator | **CONFIRMED, both halves re-derived here by hand** |
| J | [results.md](../results.md):224 and :667 present L18 as an unconditional Lemma | **BROKEN, the record's own adjudication says the dichotomy half is an Observation on two grants** |

**One line.** The pricing half is a genuine unconditional lemma and its constant $24$ is right; the dichotomy half has no argument in the block, rests on seven hypotheses of which it names one, and its headline constant is the output of a never-audited certificate, and the repair note placed above the block to fix its threshold symbol is itself false at the block's own dimension. **Verdict: HYPOTHESIS-DEBT.**

## 0. Conventions, fixed once

- $\lVert X\rVert^2=\sum_{i<j,\,k<l}X_{ijkl}^2=\tfrac14\sum_{ijkl}X_{ijkl}^2$ for $X\in S^2(\Lambda^2\mathbb R^n)$, the Hilbert–Schmidt norm of $X$ as an operator on $\Lambda^2$ in the orthonormal basis $\{e_i\wedge e_j\}_{i<j}$. **The factor $\tfrac14$ is load-bearing in §1.**
- $\mathrm{Alt}$ is the orthogonal projection of $S^2(\Lambda^2)$ onto $\Lambda^4$, $\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$, and $\mathrm{Alt}(H)=0$ for every $H$ obeying the first Bianchi identity, in particular every Weyl tensor ([conventions.md](../findings/conventions.md):100).
- $W_-:=\tfrac12(\lvert W\rvert-W)\succeq0$, so $\lvert W\rvert=W+2W_-$ ([conventions.md](../findings/conventions.md):101). $\delta^2:=\lVert\mathrm{Alt}(W_-)\rVert^2$.
- $\theta_0(n)^2=\dfrac{2(n-1)(n-2)}{n^2}$; $\tilde\theta_0(n)^2=\dfrac{2(n-1)(n-3)}{(n+1)(n-2)}$; $\hat\theta_0(n):=\dfrac{n-2}{n-3}\tilde\theta_0(n)$, so $\hat\theta_0(n)^2=\dfrac{2(n-1)(n-2)}{(n+1)(n-3)}$. **All three are read from the source**, [diss_jaeger_florian.txt:1767–1772](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf) and the remark at :1687–1701.
- $\Theta_n$ is the *diagonal maximum*: $\Theta_n=\theta_0(n)$ at even $n$, $\Theta_n=\tilde\theta_0(n)$ at odd $n$ ([conventions.md](../findings/conventions.md):19).

## 1. The hypothesis inventory

**Carried by the block, and named by it.**

| # | Hypothesis | Status on the record |
| --- | --- | --- |
| H1 | Criticality: $\theta W=W^2+W^\#$, $\lVert W\rVert=1$ | Named ("at every critical point"). Standing hypothesis of the whole chain |
| H2 | The cross-term grant $\lvert\langle X_{\mathrm{cross}},H_{\mathrm{cross}}\rangle\rvert\le J_5^{\mathrm{diag}}$, equivalently $J_5\ge0$, off the commuting class | Named. **Open.** Proven on $\{[H,W]=0\}$ ([ATTEMPTS.md](../ATTEMPTS.md) Result 13, Theorem B), unproven elsewhere; Theorem C's unconditional bound is *"a three-block factor short of closing"* |
| H3 | The threshold $\theta\ge\tilde\theta_0(n)$ | The *word* "threshold" is named; the symbol appears only in the conclusion, and is never defined in the block. See §3 |

**Carried by the block, and not named by it.**

| # | Hypothesis | Where it enters | Status |
| --- | --- | --- | --- |
| H4 | The E-track certificate | The whole of $c(n)$; the headline $c(12)$ is its output | [LEDGER.md](../findings/LEDGER.md) marks it *single-author since inception, never audited* |
| H5 | Jäger's Assumption 1: $n=2m$ with $m\ge8$, i.e. **$n$ even and $n\ge16$**, standing for Chapters 3.1–3.6 | Every lemma of §§3.2–3.6 the chain lifts | Read at [diss_jaeger_florian.txt:1704–1707](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf): *"Let $m\ge8$ be an integer, and let $n=2m$."* The record replaces it at $n=12,14$ in [ATTEMPTS.md](../ATTEMPTS.md)'s §*Reading Jäger's diagonal-case proof*; that section's own corrected headline (:612) says the two quartics give $n\ge15$ and that *"what supports $n=12,14$ is the independent global maximisation, which is numerical"* |
| H6 | Jäger's Assumption 2: $\operatorname{scal}\le(n-3)\tilde\theta_0(n)$ | The contradiction hypothesis §§3.3–3.5 run under | Read at [diss_jaeger_florian.txt:2212](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf) |
| H7 | The spectral compressions $P_+W^\#P_-=P_0W^\#P_0=0$ | Result 1's master identity, and Result 4's reduction of $X_{\mathrm{inv}}$ | [lean/INDEX.md](../lean/INDEX.md):207 lists *"the compressions"* under **Owed** |
| H8 | The Gram identity $D(R)=\tfrac32\sum_{klm}\mathrm{Alt}(R)_{iklm}\mathrm{Alt}(R)_{jklm}$ | The entire pricing half | Proven; the written proof carries two gaps the record itself states (§1.1 below) |
| H9 | $\mathrm{Alt}(W)=0$, $W$ is a genuine Weyl tensor | The step from $\tfrac32$ to $24$ | True by [conventions.md](../findings/conventions.md):100, unstated in the block |
| H10 | Lemma 3.4.7's frame-free Assumption-1/2 assembly | §3.4's closure | [ATTEMPTS.md](../ATTEMPTS.md) Result 8: *"the remaining bookkeeping is the frame-free Lemma 3.4.7 assembly plus §3.6"*; Result 7 says 3.4.7 was *"spot-verified numerically"* |
| H11 | The isotropy argument's implicit multiplicity-free reading | *"an isotropy argument forces the relevant operators to commute there"* | Result 13's Theorem B argues *"$h$ is isotropy-invariant, hence scalar on each isotypic factor"*. Schur gives scalar on an isotypic component only when that component is multiplicity-free; in general an invariant operator acts as $\mathrm{Id}\otimes A$. The record is elsewhere alive to exactly this distinction, [Lemma L21](../results.md):224 advertises *"Schur applies with **no** multiplicity-free hypothesis"* as a thing worth saying. **I did not find a concrete failure and record this as an unstated hypothesis, not as a defect** (see §6, candidate 3) |

**Which of the eleven the written argument uses.** All of them. H1, H8, H9 and the $\lambda_{\max}$-trace step are all the *pricing* half needs; the *dichotomy* half additionally needs H2–H7 and H10, and H11 is what makes H2 discharged at the named points. The block names H1, H2 and (obliquely) H3, and no other.

### 1.1 The Gram identity's own proof status

[ATTEMPTS.md](../ATTEMPTS.md) Result 2 gives two proofs. The **first** is exact integer arithmetic on a spanning set at $n=4,5,6,7$ plus a first/second-fundamental-theorem stability argument, and the record states its own two gaps: *"the $n$-independent-coefficient reduction is by inspection of the defining formulas"* and *"the Brauer-kernel threshold is quoted rather than re-proven"*. The **second**, Reviewer 9's three-step dummy-relabelling argument, is said to have neither gap, **but its text is nowhere in the record.** I grepped for it: `dummy-relabelling` occurs in [ATTEMPTS.md](../ATTEMPTS.md) and in one review, in both cases as a description of a proof, never as the proof. So the identity's only *written* derivation is the one with two acknowledged gaps.

*This is not a claim that the identity is false.* Both gaps are of the kind that are standard, and the exact $n=4$–$7$ runs are strong. It is a claim about what a reader can check on the record.

## 2. Pre-registered question 1, the pricing claim and its constant

### 2.1 The derivation, in full

Let $R$ be symmetric on $\Lambda^2\mathbb R^n$ and let $D(R)$ be the Ricci-level Bianchi defect of [ATTEMPTS.md](../ATTEMPTS.md) Result 2,
$$D(R)_{ij}:=\mathrm{Ric}(R^2+R^\#)_{ij}-\sum_{k,l}\mathrm{Ric}(R)_{kl}\,T_R(k,i,l,j)=\tfrac32\sum_{k,l,m}\mathrm{Alt}(R)_{iklm}\,\mathrm{Alt}(R)_{jklm}.$$

**Step 1, $D\succeq0$.** Write $v_i^{(klm)}:=\mathrm{Alt}(R)_{iklm}$. Then $D_{ij}=\tfrac32\sum_{klm}v_i^{(klm)}v_j^{(klm)}$ is $\tfrac32$ times a Gram matrix, so for any $x\in\mathbb R^n$, $\langle x,Dx\rangle=\tfrac32\sum_{klm}\bigl(\sum_i x_iv_i^{(klm)}\bigr)^2\ge0$. **This is unconditional and dimension-free: the only input is the identity itself.**

**Step 2, the trace, and where the $\tfrac32$ becomes a $6$.**
$$\operatorname{tr}D(R)=\tfrac32\sum_{i,k,l,m}\mathrm{Alt}(R)_{iklm}^2=\tfrac32\cdot4\lVert\mathrm{Alt}(R)\rVert^2=6\lVert\mathrm{Alt}(R)\rVert^2,$$
the factor $4$ being exactly the $\tfrac14$ of the norm convention in §0. **So $\tfrac32$ and $6$ are the same constant read in two normalisations**, and the record's two statements, the block's *"universal constant $\tfrac32$"* and [Observation L15](../results.md):218's *"constant exactly $6$"*, agree. A reader who does not carry §0's $\tfrac14$ will read them as a contradiction; neither line says which norm it is in.

**Step 3, the transfer from $R$ to $\lvert W\rvert$.** $\lvert W\rvert=W+2W_-$ and $\mathrm{Alt}$ is linear with $\mathrm{Alt}(W)=0$ (H9), so $\mathrm{Alt}(\lvert W\rvert)=2\,\mathrm{Alt}(W_-)$ and
$$\operatorname{tr}D(\lvert W\rvert)=6\lVert 2\,\mathrm{Alt}(W_-)\rVert^2=6\cdot4\,\delta^2=24\,\delta^2 .$$

**Step 4, the $\lambda_{\max}$ step.** With $J_4:=\langle D(\lvert W\rvert),\mathrm{Ric}\rangle$ and $\mathrm{Ric}=\mathrm{Ric}(\lvert W\rvert)$, diagonalise $\mathrm{Ric}=\sum_a\lambda_a\,u_au_a^{\top}$ in an orthonormal eigenbasis. Then
$$J_4=\operatorname{tr}(D\,\mathrm{Ric})=\sum_a\lambda_a\langle u_a,Du_a\rangle\le\lambda_{\max}\sum_a\langle u_a,Du_a\rangle=\lambda_{\max}(\mathrm{Ric})\operatorname{tr}D=24\,\delta^2\,\lambda_{\max}(\mathrm{Ric}(\lvert W\rvert)),$$
where the inequality uses $\langle u_a,Du_a\rangle\ge0$ from Step 1 and holds **whatever the sign of $\lambda_{\max}$**.

**Verdict on claim A and claim B: PROVEN.** Every step is pointwise at a single $R$, involves no dimension-dependent constant, and needs no criticality, no Bianchi identity on $W_-$, and no positivity of anything but $D$. The constant $24=6\cdot4$ is right, and the record's earlier reading of it agrees with mine independently ([REVIEW_r477.md](../reviews/REVIEW_r477.md):52, which I read only after completing the derivation above).

**What the block does not contain.** It states the conclusion and none of Steps 1–4: it never writes $D$, never writes $J_4$, never states the identity whose constant it quotes, and never says $\mathrm{Alt}(W)=0$, which is the single fact turning $\tfrac32$ into $24$. A reader cannot get from *"universal constant $\tfrac32$"* to *"$24\lVert\mathrm{Alt}(W_-)\rVert^2$"* without leaving the file.

### 2.2 *"Saturated exactly by the $\mathbb{CP}^2$-type competitor"*

Result 3's equality condition for Step 4 is that $\mathrm{Ric}$ be $\lambda_{\max}$ times the identity **on $D$'s support**, and the same Result records this holding both at $\mathcal S^4(\alpha)$ (the $\mathbb{CP}^2$-type competitor, $\delta^2=1/9$, $\theta=\sqrt{3/2}$) *and* at QK $\mathbb{HP}^2$, where $\mathrm{Ric}=\tfrac{\operatorname{scal}}8I$ on its support. So *"saturated exactly by"*, read as "by that point and no other", is contradicted by the source; read as "saturated there, with exact equality", it is right and is what the source says. **Recorded as an ambiguity, not a defect**, see §6, candidate 2.

## 3. Pre-registered question 3, what is $\tilde\theta_0(n)$

**There is a definition, and it is in the primary source, not in the record.** [diss_jaeger_florian.txt:1687–1697](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf), verbatim: *"Let $\tilde W_0$ be the normalized Weyl curvature operator of $S^m\times S^{m+1}$ … Then $\tilde W_0^2+\tilde W_0^\#=\tilde\theta_0(n)\tilde W_0$ for $\tilde\theta_0(n)=\sqrt{2\frac{(n-1)(n-3)}{(n+1)(n-2)}}$ can be proven. … Moreover, $\tilde\theta_0(n)\le\theta_0(n)$ for all $n\ge3$, and most of the results will be proven for $\tilde\theta_0(n)$."* The record itself defines the symbol nowhere: it is absent from [conventions.md](../findings/conventions.md) and from the block. So the value the chain's threshold and its scalar floor are written in **rests on a source outside the record**, a source that is, however, in [references/](../references/) and which I read.

### 3.1 The repair note is false at the block's own dimension, claim H

[problem.md](../findings/problem.md):303 heads its repair *"$\tilde\theta_0(n)$ IS DEFINED NOWHERE, AND IS $\Theta_n$ UNDER A SECOND NAME"* and closes *"$\hat\theta_0$ is a third variant of the same thing"*; [lean/INDEX.md](../lean/INDEX.md):207 restates it as *"$\tilde\theta_0$, $\hat\theta_0$ and $\Theta_n$ are one object under three names"*.

**Locate it exactly.** The two sentences above, and nothing else, the body of the note is more careful, saying *"the threshold carrying this result is [conventions.md](../findings/conventions.md)'s **odd-$n$** $\Theta_n$ formula"*. It is the headline and the Lean row that drop the parity.

**Exhibit the failure concretely, at $n=12$.** From §0's closed forms, exactly:
$$\tilde\theta_0(12)^2=\frac{2\cdot11\cdot9}{13\cdot10}=\frac{99}{65},\qquad \Theta_{12}^2=\theta_0(12)^2=\frac{2\cdot11\cdot10}{144}=\frac{55}{36},\qquad \hat\theta_0(12)^2=\frac{2\cdot11\cdot10}{13\cdot9}=\frac{220}{117}.$$
These are three distinct rationals: $\tfrac{99}{65}<\tfrac{55}{36}<\tfrac{220}{117}$, since $55\cdot65-99\cdot36=3575-3564=11>0$ and $220\cdot36-55\cdot117=7920-6435=1485>0$. In decimals, $1.2341312$, $1.2360331$, $1.3712569$. **Three names, three numbers.**

The separation is structural, not an artefact of $n=12$. For every $n\ge4$:
- $\theta_0(n)^2-\tilde\theta_0(n)^2=2(n-1)\Bigl[\dfrac{n-2}{n^2}-\dfrac{n-3}{(n+1)(n-2)}\Bigr]=\dfrac{8(n-1)}{n^2(n+1)(n-2)}>0$, using the identity $(n-2)^2(n+1)-n^2(n-3)=(n^3-3n^2+4)-(n^3-3n^2)=4$. At $n=12$ this is $\tfrac{88}{18720}=\tfrac{11}{2340}$, matching $\tfrac{55}{36}-\tfrac{99}{65}$ exactly.
- $\hat\theta_0(n)^2/\theta_0(n)^2=\dfrac{n^2}{(n+1)(n-3)}=\dfrac{n^2}{n^2-2n-3}>1$.

So $\tilde\theta_0(n)<\theta_0(n)<\hat\theta_0(n)$ **strictly, in every dimension $n\ge4$**. Since $\Theta_n=\theta_0(n)$ at even $n$, the identification $\tilde\theta_0=\Theta_n$ holds **at odd $n$ only**, and $\hat\theta_0$ is never $\Theta_n$ at any parity.

**Argue the opposite.** The most charitable reading is that the note means the *closed form* $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ is the one [conventions.md](../findings/conventions.md):19 registers as $\Theta_n$'s odd-$n$ branch, so the record already carries the quantity under another name and need only register it. That reading is true, and the note's body says it. **But the headline and the Lean row do not, and $\hat\theta_0$ cannot be rescued under any reading**, $\hat\theta_0=\frac{n-2}{n-3}\tilde\theta_0$ is a definitionally different quantity, read from [diss_jaeger_florian.txt:1772](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf), and the record's own [REVIEW_r498.md](../reviews/REVIEW_r498.md):47 tabulates $\tilde\theta_0(12)=1.23413$ against $\hat\theta_0(12)=1.37126$ in adjacent columns.

**The block refutes its own repair note.** [ATTEMPTS.md](../ATTEMPTS.md) Result 10 gives $c(12)=1.081\times10^{-3}$ at $\theta\ge\tilde\theta_0(12)$ **against** $1.223\times10^{-3}$ at $\theta\ge\theta_0(12)$, and Result 11 revises the first to $1.0008\times10^{-3}$, which is the *"about $1.0\times10^{-3}$"* the block quotes. So the block's headline number is precisely the one that exists only because $\tilde\theta_0(12)\ne\theta_0(12)=\Theta_{12}$. A note asserting they are one object sits four lines above a sentence whose number distinguishes them.

**What breaks if a consumer believes the note.** Substituting $\Theta_n$ for $\tilde\theta_0$ at even $n$ strengthens the *hypothesis* harmlessly but strengthens the *conclusion* beyond anything proven: Jäger's Lemma 3.5.6 concludes $\operatorname{scal}\ge(n+1)\tilde\theta_0(n)$, so at $n=12$ the substituted floor over-claims by $13\cdot(\theta_0(12)-\tilde\theta_0(12))=13\cdot0.0019019=0.0247$ in $\operatorname{scal}$.

**What would falsify this finding.** A dimension at which $\Theta_n=\tilde\theta_0(n)$ with $n$ even, or a reading under which $\hat\theta_0=\tilde\theta_0$. The first is excluded by the strict identity $\theta_0^2-\tilde\theta_0^2=8(n-1)/(n^2(n+1)(n-2))>0$ for all $n>2$; the second by $\hat\theta_0/\tilde\theta_0=(n-2)/(n-3)>1$ for all $n>3$. I looked for a third convention for $\Theta_n$ by grepping [conventions.md](../findings/conventions.md), [INDEX-values.md](../findings/INDEX-values.md) and [results.md](../results.md), and found only the one at [conventions.md](../findings/conventions.md):19.

### 3.2 What value it must take for the chain to close

It must take the value it already has: $\tilde\theta_0(n)$, Jäger's own. The chain is his §§3.3–3.5 run under Assumption 2, whose interval endpoints are $\tfrac{8n+9}{16}\hat\theta_0(n)$ and $(n-3)\tilde\theta_0(n)$ ([diss_jaeger_florian.txt:4185, 4211, 4233](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf)), so **both** $\tilde\theta_0$ and $\hat\theta_0$ appear, in different roles, in the same interval. Collapsing them into one symbol would make that interval degenerate. **The record already has the quantity under another name only at odd $n$**; at even $n$ it has no name for it at all, which is exactly the registration [LEDGER.md](../findings/LEDGER.md) marks as owed.

## 4. Pre-registered question 2, what the dichotomy grants

### 4.1 The hypotheses, and the one the block names

The block's grant sentence reads *"Granting that cross-term bound off the class where it is already proven, the chain gives: …"*. That names **H2 alone**. The full list is H1–H7 and H10 of §1, eight hypotheses. Of the four that are live and unproven:

- **H2, $J_5\ge0$ off the commuting class.** Proven where $[H,W]=0$; open elsewhere. Result 13's unconditional Theorem C is by the record's own words *"a three-block factor short of closing"*, and the gap-commutator certificate of Theorem D leaves two $n=6$ points uncovered. The whole of Result 13 is marked *"Single-run agent result, unreviewed; the review is owed and deferred."*
- **H4, the E-track certificate.** Unnamed by the block. [LEDGER.md](../findings/LEDGER.md):324 records it as *single-author since inception, never audited*, and records that the headline $c(12)$ **is its output**.
- **H5, $n$ even and $n\ge16$.** Unnamed by the block, and the block's only numerical claim is at $n=12$.
- **H7, the spectral compressions.** Unnamed; [lean/INDEX.md](../lean/INDEX.md):207 lists them under **Owed**.

### 4.2 The level of the quoted cost, a chain penalty and its numerator

**Locate it exactly.** The block: *"it costs at most $24\,\lVert\mathrm{Alt}(W_-)\rVert^2\,\lambda_{\max}(\mathrm{Ric}(\lvert W\rvert))$"*, and then, with no further arithmetic, *"the chain gives"*.

**Exhibit the failure concretely.** [ATTEMPTS.md](../ATTEMPTS.md) Result 7 states the chain's penalty as
$$\frac{J_4-J_5}{\sqrt{1-e^2}}\le\frac{24\,\delta^2\lambda_{\max}(\mathrm{Ric}(\lvert W\rvert))}{\sqrt{1-e^2}},$$
$e$ being Jäger's own decomposition parameter in $\lvert W\rvert=\sqrt{1-e^2}\,\frac{\mathrm{Ric}\wedge\mathrm{Ric}}{\lVert\mathrm{Ric}\wedge\mathrm{Ric}\rVert}+E$. Since $e\in[0,1)$, $1/\sqrt{1-e^2}\ge1$ with equality only at $e=0$, so for a positive penalty the divided form is **strictly larger** whenever $e\ne0$. The block quotes the numerator, never mentions $e$, and then draws the dichotomy, which needs the divided form. The direction of the error is the unfavourable one: **the block understates the cost, and understating the cost is what makes the dichotomy look easier than it is.**

**Argue the opposite.** The charitable reading is that $24\delta^2\lambda_{\max}$ is offered as the price of the *§3.3 term $J_4$*, which is exactly what §2 proves and exactly what the sentence's grammar says ("the Bianchi correction … costs at most"), and that the chain's own bookkeeping supplies the $1/\sqrt{1-e^2}$ downstream. Under that reading the sentence is true. **But the block never distinguishes the two levels**, so the reading requires knowing that a distinction exists.

**Verdict: the block quotes the numerator $J_4$; the chain needs $(J_4-J_5)/\sqrt{1-e^2}$.**

### 4.3 *"The answer is one exactly-priced term"*, claim C

**Locate it exactly.** Paragraph 1 of the block.

**Exhibit the failure concretely.** [ATTEMPTS.md](../ATTEMPTS.md) Result 10's flagged by-product (a): *"Lemma 3.3.1 is not defect-free, via 3.2.2 it becomes $r^2\ge\hat\theta\,\operatorname{scal}-24\delta^2$, partially offset through 3.2.3's $\Lambda^4$ term ($-6.4\delta^2$ at $n=12$, helpful direction)"*. So the lifted chain carries at least **three** $\delta^2$-entries, the $J_4$ price in 3.3.4, a second $24\delta^2$ in 3.3.1, and a favourable $-6.4\delta^2$ from 3.2.3, where the block says one.

**Argue the opposite.** The charitable reading is that *"one exactly-priced term"* refers to §3.3's *workhorse inequality* alone, the subject of the next sentence, and that the other entries live in §3.2. **That reading fails on the block's own scope**: the paragraph's question is *"what its middle chapters cost off the diagonal locus"*, and 3.3.1 is in the middle chapters.

**A caution on the arithmetic the record attaches to this.** [lean/INDEX.md](../lean/INDEX.md):207 nets the three as $24+24-6.4=\tfrac{208}5$, *"a factor $26/15$ above the block's $24$"*, and $\tfrac{208/5}{24}=\tfrac{208}{120}=\tfrac{26}{15}$ is right as arithmetic. But the three coefficients sit in different inequalities: the 3.3.4 entry is $24\delta^2\lambda_{\max}(\mathrm{Ric})$, a quantity carrying a factor of $\lambda_{\max}$, while the 3.3.1 entry $24\delta^2$ is a bound on $r^2$ against $\hat\theta\operatorname{scal}$. **Adding their coefficients does not produce a bound on anything either block states.** The count "three, not one" is right; the sum $208/5$ should not be cited as a penalty.

### 4.4 *"§§3.4 and 3.5 then lift at no cost at all"*, claim D

**Locate it exactly.** Last sentence of the block's second paragraph.

**Exhibit the failure concretely.** [ATTEMPTS.md](../ATTEMPTS.md) Result 8 closes: *"§3.4 is now lifted with proofs rather than evidence, and the remaining bookkeeping is the frame-free Lemma 3.4.7 assembly plus §3.6."* Result 7 records Lemma 3.4.7 as *"spot-verified numerically"*, with margins $+0.06$ to $+1.67$. So one step of §3.4 is evidence, not proof, and *"lift"* asserts completion.

**Argue the opposite.** *"At no cost at all"* most naturally means *at no **defect** cost*, no $\delta^2$ term enters §§3.4–3.5, which is exactly what the source establishes (Result 9: the defect re-enters at Lemma 3.6.4 *"and nowhere else"*). Under that reading the sentence is true as stated.

**Verdict: WITHDRAWN as a defect.** The charitable reading is the natural one and it is correct. Recorded instead as the inventory item H10.

### 4.5 What a consumer reading the landscape line alone would believe

[results.md](../results.md):224 reads, in full: *"**Lemma L18 (lifting). The diagonal proof's middle chapters, lifted.** §3.3's workhorse inequality becomes an exact identity off the diagonal locus, with a positive-semidefinite correction pricing the defect; §§3.4–3.5 lift free. The chain splits every critical point above the threshold into large scalar curvature or defect bounded away from zero."*

A consumer reading that line alone would believe: **(i)** the whole of L18 is a Lemma, i.e. proven; **(ii)** the dichotomy is unconditional, since no grant, no $J_5$, no certificate and no dimension range appears; **(iii)** "the threshold" is a known quantity; **(iv)** "large scalar curvature" and "defect bounded away from zero" are both effective. Of these, **(i) and (ii) are false** by the record's own adjudication, **(iii) is undefined**, and **(iv)** holds only at $n=12$, the sole dimension where $c(n)$ has ever been computed. Neighbouring landscape lines in the same list do carry their conditionality, [Lemma L20](../results.md):224 says *"conditional on one input nothing on the record proves"*, so the omission is not a house style.

[results.md](../results.md):667 is worse, because it is shorter: a heading, *"Lemma L18, the diagonal proof's middle chapters, lifted with the defect cost quantified"*, and one line, *"**Proof:** [problem.md](../findings/problem.md)"*, pointing at the file whose own audit note says **NO PROOF IN THE BLOCK**.

## 5. Quantifiers, scope, and the edges of every range

**Quantifier order.** The dichotomy as written is $\forall W$ critical with $\theta\ge\tilde\theta_0(n)$: $\bigl[\operatorname{scal}(\lvert W\rvert)\ge(n+1)\tilde\theta_0(n)\bigr]\vee\bigl[\delta^2\ge c(n)\bigr]$, with $c(n)>0$. **The $n$ is never quantified**, and the $\exists c(n)>0$ is established at one value of $n$. [ATTEMPTS.md](../ATTEMPTS.md) Result 7 promises $c(n)$ *"explicit from the E-track margins"*; Result 10 computes $c(12)$ and Result 11 revises it; **no other dimension has a computed $c(n)$ anywhere in the record.** So the honest scope is: *at $n=12$*, with the general-$n$ statement a schema.

**Odd $n$.** The chain's threshold and floor are written in $\tilde\theta_0$ precisely so as to cover odd $n$, that is Jäger's stated reason ([diss_jaeger_florian.txt:1697–1699](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf)) and [ATTEMPTS.md](../ATTEMPTS.md):801's. **But Assumption 1, which stands for Chapters 3.1–3.6, says $n=2m$** ([diss_jaeger_florian.txt:1704–1705](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf)), so §§3.3–3.5's odd-$n$ validity is the record's reading of the thesis, not the thesis's own statement. The reading is well-argued and I found nothing against it. **It is nowhere in the block.** Note also that at odd $n$ the two symbols merge ($\Theta_n=\tilde\theta_0(n)$) which is exactly why the repair note of §3.1 reads true when screened at $n=13$ and false at $n=12$.

**The smallest admissible $n$.** Three different answers are live on the record: **$n\ge16$** (Assumption 1, the source); **$n\ge15$** ([ATTEMPTS.md](../ATTEMPTS.md):612, the two quartics' largest real roots $14.811$ and $14.963$, evenness then giving $16$); **$n\ge12$** (the record's replacement, whose $n=12$ step is certified by validated interval arithmetic but whose §612 corrected headline says the analytic route *"needs the strengthenings quantified below and never supplied"*). The block asserts none of the three and computes at $n=12$.

**$\ker W\ne0$.** This is where the one named grant actually lives. Result 5(a) splits $X_{\mathrm{inv}}$ over the three spectral blocks $P_+,P_-,P_0$, with $P_0$ the projection onto $\ker W$; if $\ker W=0$ there are two blocks and Theorem C's *"three-block factor short"* deficiency is a two-block factor. The block's own saturating example has $\ker W\ne0$, [conventions.md](../findings/conventions.md):101 pins the sign of $W_-$ by the behaviour of $\mathrm{Alt}(W_-)\rvert_{\ker W}$ at the $\mathbb{CP}^2$-type competitor, which presupposes $\ker W\ne0$ there. **So the three-block case is the one the named points sit in, and the block says nothing about the block structure at all.**

**A unit the block drops.** *"scalar curvature at least $(n+1)\tilde\theta_0(n)$"*, claim G. The source writes $\operatorname{scal}(\lvert W\rvert)$. Read literally against $W$, the sentence is **false at every critical point without exception**: $W$ is a Weyl operator, so $\mathrm{Ric}(W)=0$ and hence $\operatorname{scal}(W)=0<(n+1)\tilde\theta_0(n)$ for every $n\ge4$. The record uses $\mathrm{Ric}(W)=0$ explicitly in three places I read ([ATTEMPTS.md](../ATTEMPTS.md) Results 8 and 11, and Step 3 of §2 above). **Argue the opposite:** every consumer who has read the block's preceding sentences sees $\mathrm{Ric}(\lvert W\rvert)$ twice, so *"scalar curvature"* plainly abbreviates $\operatorname{scal}(\lvert W\rvert)$. The mathematics is not in doubt; **the citable sentence is**, and [results.md](../results.md):224 propagates it as *"large scalar curvature"* with the $\lvert W\rvert$ gone entirely.

## 6. The three-step record for every candidate

| # | Candidate | Located | Exhibited | Charitable reading | Outcome |
| --- | --- | --- | --- | --- | --- |
| 1 | *"universal constant $\tfrac32$"* contradicts [Observation L15](../results.md):218's *"constant exactly $6$"* | ✓ block ¶2 vs :218 | Attempted | The two are the same constant in two normalisations; §2 Step 2 derives $6=\tfrac32\cdot4$ from §0's $\tfrac14$ | **WITHDRAWN**, no discrepancy; recorded as a norm-convention hazard, since neither line states its norm |
| 2 | *"saturated **exactly** by the $\mathbb{CP}^2$-type competitor"* reads as uniqueness | ✓ block ¶2 | ✓ QK $\mathbb{HP}^2$ also has $\mathrm{Ric}$ scalar on $D$'s support (Result 3), hence also saturates | "Saturated there, with exact equality", which is what Result 3 says | **WITHDRAWN as a defect**, recorded as an ambiguity |
| 3 | The isotropy argument needs the isotropy representation multiplicity-free | ✓ block ¶2, Result 13 Thm B | **Failed**, I could not exhibit a named critical point where the isotypic components carry multiplicity, and doing so would need computation, which this brief forbids | Invariance plus multiplicity-freeness gives scalar; the record's named points are plausibly multiplicity-free | **WITHDRAWN** under step 2; carried into the inventory as H11 |
| 4 | *"one exactly-priced term"* | ✓ block ¶1 | ✓ three entries, Result 10(a) | Scoped to §3.3 alone, fails, since the paragraph's subject is *the middle chapters* | **CONFIRMED** (claim C) |
| 5 | *"§§3.4 and 3.5 then lift at no cost at all"* | ✓ block ¶2 | ✓ Lemma 3.4.7's assembly is spot-verified, not proven | "No **defect** cost", which Result 9 establishes | **WITHDRAWN** (claim D); carried as H10 |
| 6 | The quoted cost is the numerator, not the chain penalty | ✓ block ¶2 vs Result 7 | ✓ $1/\sqrt{1-e^2}\ge1$ strictly above $1$ for $e\ne0$, understating in the favourable direction | The sentence prices $J_4$, and $J_4$ is what it says it prices | **CONFIRMED as a level error in a block that then draws the divided-form conclusion** |
| 7 | The threshold symbol is undefined, and the repair identifying it with $\Theta_n$ and $\hat\theta_0$ is false | ✓ :303 and [lean/INDEX.md](../lean/INDEX.md):207 | ✓ $\tfrac{99}{65}<\tfrac{55}{36}<\tfrac{220}{117}$ at $n=12$, and $\tilde\theta_0<\theta_0<\hat\theta_0$ strictly at every $n\ge4$ | The note's *body* restricts to the odd-$n$ branch and is true; the headline and the Lean row do not | **CONFIRMED** (claim H) |
| 8 | $c(n)>0$ is asserted for general $n$ and computed at one | ✓ block ¶3 | ✓ only $c(12)$ exists on the record | *"computed at $n=12$"* is the block's own qualifier, but it qualifies the *value*, not the existence | **CONFIRMED as a scope defect** |
| 9 | *"scalar curvature"* omits $\lvert W\rvert$ | ✓ block ¶3, [results.md](../results.md):224 | ✓ $\operatorname{scal}(W)=0$ at every critical point, so the literal statement is false everywhere | Context supplies $\lvert W\rvert$ | **CONFIRMED as a citation defect** (claim G), not a mathematical one |

## 7. The named trap, each citable claim read alone

The block's own repair notes are five paragraphs long and sit **above** the prose they correct, inside [problem.md](../findings/problem.md). Every other surface is clean:

| Surface | What it says alone | What a citer inherits |
| --- | --- | --- |
| [results.md](../results.md):224 | *"Lemma L18 … The chain splits every critical point above the threshold into large scalar curvature or defect bounded away from zero"* | An unconditional lemma. **No grant, no $J_5$, no certificate, no dimension, no $\lvert W\rvert$** |
| [results.md](../results.md):667 | *"Lemma L18, … lifted with the defect cost quantified. **Proof:** [problem.md](../findings/problem.md)"* | A proof pointer into a file whose audit note says the block contains no proof |
| [lean/INDEX.md](../lean/INDEX.md):207 | status **proved** | What is machine-checked is the bracketing of constants, $\Theta_{13}^2=120/77$, and $0.0112<\theta_0(12)-\sqrt{3/2}<0.0113$, **not the lemma**. The row itself says so, in its last words: *"Owed: the Gram form, the compressions, and the E-track certificate"* |
| [problem.md](../findings/problem.md):303, the repair | *"$\tilde\theta_0(n)$ … IS $\Theta_n$ UNDER A SECOND NAME … $\hat\theta_0$ is a third variant of the same thing"* | **A false identification**, refuted at $n=12$ by the block's own headline number. This is the trap turned inside out: the correction placed beside the statement is itself wrong at the statement's dimension |

**What the Lean row would have to claim to be a row for L18.** Two theorems, not a bracketing: (i) *for every symmetric $R$ on $\Lambda^2\mathbb R^n$, $D(R)\succeq0$ and $\operatorname{tr}D(R)=6\lVert\mathrm{Alt}(R)\rVert^2$; hence for Weyl $W$, $J_4\le24\delta^2\lambda_{\max}(\mathrm{Ric}(\lvert W\rvert))$*, formalisable, since §2's four steps are elementary given H8; and (ii) the dichotomy **as an implication with H2, H4, H5, H6, H7 and H10 as explicit antecedents**, which is a statement of hypotheses, not a proof.

## 8. What a consumer may cite

**Citable, unconditionally.** The pricing bound: for a Weyl operator $W$ with $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$,
$$J_4=\langle D(\lvert W\rvert),\mathrm{Ric}(\lvert W\rvert)\rangle\le24\,\delta^2\,\lambda_{\max}(\mathrm{Ric}(\lvert W\rvert)),$$
pointwise, in every dimension, with no criticality hypothesis, **subject to H8, whose written proof has two acknowledged standard gaps**. And the exact identity $\theta_0(12)-\sqrt{3/2}=\tfrac{\sqrt{55}}6-\tfrac{\sqrt6}2$, which lies strictly between $0.0112$ and $0.0113$ (§9).

**Citable only with the hypotheses attached.** The dichotomy, as: *assume $J_5\ge0$ at the point in question; assume the E-track certificate; assume the record's replacement of Jäger's $n\ge16$; assume the compressions and the Lemma 3.4.7 assembly. Then at $n=12$, every critical point with $\theta\ge\tilde\theta_0(12)$ has $\operatorname{scal}(\lvert W\rvert)\ge13\,\tilde\theta_0(12)$ or $\delta^2\ge1.0008\times10^{-3}$.*

**Not citable.** *"One exactly-priced term"*; *"$\tilde\theta_0$ is $\Theta_n$"* and *"one object under three names"*; the dichotomy for general $n$; the dichotomy without its grants; *"scalar curvature at least $(n+1)\tilde\theta_0(n)$"* without $\lvert W\rvert$.

## 9. The one number the two blocks share, confirmed

The block: *"the rival maximizer forces any closing bound into a window of width $0.011$ at $n=12$ … That width is $\theta_0(12)-\sqrt{3/2}$, between $0.0112$ and $0.0113$, and it is the denominator [Lemma L13](../findings/curvature-invariants.md) divides by for its excess figure."* **Both halves check by hand.**

$\theta_0(12)=\tfrac{\sqrt{55}}6$ and $\sqrt{3/2}=\tfrac{\sqrt6}2$. With $\sqrt{55}=7.4161985$ and $\sqrt6=2.4494897$, the difference is $1.2360331-1.2247449=0.0112882$, inside the stated bracket.

For the second half: [Lemma L13](../findings/curvature-invariants.md) gives $\lambda^2\bigl(1+\tfrac{k_0}4\bigr)\le\tfrac{(n-1)(2n-1)}4$ with $k_0=\dim(O(n)\cdot u)$. At $n=12$ with $k_0=\dim O(12)=66$: $1+\tfrac{66}4=\tfrac{35}2$ and $\tfrac{11\cdot23}4=\tfrac{253}4$, so
$$\lambda^2\le\frac{253/4}{35/2}=\frac{253}{70}=3.6142857,\qquad \lambda\le1.9011275 .$$
Then $\dfrac{1.9011275-\theta_0(12)}{\theta_0(12)-\sqrt{3/2}}=\dfrac{0.6650944}{0.0112882}=58.92$, reproducing L13's stated excess of $58.9\times$ at $n=12$ to three digits. **The two blocks do turn on one number, and neither names the other.**

## Verdict

**HYPOTHESIS-DEBT.**

The pricing half (claims A and B) is a correct, unconditional, pointwise, dimension-free lemma with the right constant, and §2 gives its derivation in full, but the block contains none of that derivation, and the identity it rests on has one written proof with two acknowledged gaps and one gapless proof that exists only as a description.

The dichotomy half (claims E, F) is an implication with eight hypotheses, of which the block names one, and whose headline constant is the output of a certificate the record marks *never audited*. **What would have to be shown for it to become a lemma, exactly:** (1) $J_5\ge0$ at critical points off $\{[H,W]=0\}$, Result 13 Theorem C is short by a three-block factor; (2) an audit of the E-track certificate producing $c(12)$; (3) a written derivation of the spectral compressions; (4) the frame-free Lemma 3.4.7 assembly; (5) a statement of which $n$ the claim is made for, and a $c(n)$ for any $n\ne12$.

**Separately and independently of the lemma: claim H is BROKEN.** The repair note at [problem.md](../findings/problem.md):303 and the row at [lean/INDEX.md](../lean/INDEX.md):207 assert that $\tilde\theta_0$, $\hat\theta_0$ and $\Theta_n$ are one object. At $n=12$ their squares are $\tfrac{99}{65}$, $\tfrac{220}{117}$ and $\tfrac{55}{36}$, three distinct rationals in that strict order for every $n\ge4$; the identification is true at odd $n$ for $\tilde\theta_0$ and $\Theta_n$ alone, and is false for $\hat\theta_0$ at every $n$. It is refuted by the very sentence it was written to repair.
