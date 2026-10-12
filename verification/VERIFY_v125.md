# VERIFY v125, Lemma L18: the §3.3 pricing bound, the two-grant dichotomy, and the threshold $\tilde\theta_0(n)$

**Standfirst.** Cold brief, no provenance supplied beyond the quoted text. **No numerical work was done**: no script was run, and every value below is an exact hand evaluation, where a comparison could be made between rationals I made it between rationals, so that no root is taken. Log: [agent_logs/verify-L18-v125.log](../agent_logs/verify-L18-v125.log). Sources read in full: [findings/problem.md](../findings/problem.md):291–313, [results.md](../results.md):224 and :667, [ATTEMPTS.md](../ATTEMPTS.md) §*Lifting Jäger's §3.3 in trace form* (Results 1–13), [findings/LEDGER.md](../findings/LEDGER.md):316–324, [findings/conventions.md](../findings/conventions.md):18–19 and 55–68, [findings/isotropy-cap.md](../findings/isotropy-cap.md) Lemma L131, [reviews/REVIEW_r9.md](../reviews/REVIEW_r9.md), [lean/INDEX.md](../lean/INDEX.md):207 and [lean/HamiltonsCubic/Results/L18.lean](../lean/HamiltonsCubic/Results/L18.lean), and the primary source [references/jaeger-2016-diagonal-case/](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf) (Notation 3.0.3, the Remark before §3.1, Corollary 3.2.6, Assumption 2).

## Claim table

| # | Claim, as the block states it | Verdict |
|---|---|---|
| C1 | The Bianchi correction is a PSD Gram form in $\mathrm{Alt}(R)$ with universal constant $\tfrac32$ | **PROVEN**, argument on file in [REVIEW_r9.md](../reviews/REVIEW_r9.md) §2, not named by the block |
| C2 | It costs at most $24\lVert\mathrm{Alt}(W_-)\rVert^2\lambda_{\max}(\mathrm{Ric}(\lvert W\rvert))$ | **PROVEN, at the $J_4$ level only**, constant $24=6\cdot4$ confirmed by hand; convention-locked, not convention-free |
| C3 | Spectral compressions turn §3.3's workhorse inequality into an **exact identity** at every critical point in every frame | **HYPOTHESIS-DEBT**, the sign $\langle\lvert W\rvert,\widehat{\mathrm{Ric}\owedge\mathrm{Ric}}\rangle\ge0$ is tested, never proven |
| C4 | §§3.4 and 3.5 lift at **no cost at all** | **PROVEN as to cost; INCOMPLETE as to assembly**, Lemma 3.4.7's frame-free assembly is owed by the record's own Result 8 |
| C5 | The dichotomy, granting **one** cross-term bound | **HYPOTHESIS-DEBT**, three unnamed inputs, one of which the record marks never audited and which produces the quoted $10^{-3}$ |
| C6 | Threshold $(n+1)\tilde\theta_0(n)$ | **PROVEN faithful to the source**, matches Jäger §3.2 verbatim; the symbol is unregistered in this record |
| C7 | *(record-side)* $\tilde\theta_0$, $\hat\theta_0$ and $\Theta_n$ are one object under three names | **BROKEN**, refuted at every $n$ for $\hat\theta_0$ and at every even $n$ for $\Theta_n$, by exact rationals |
| C8 | The quoted cost is the chain penalty | **BROKEN**, the block quotes the numerator $J_4$; the chain needs $(J_4-J_5)/\sqrt{1-e^2}$ |
| C9 | Window of width $0.011$ at $n=12$, being $\theta_0(12)-\sqrt{3/2}$, between $0.0112$ and $0.0113$ | **PROVEN**, confirmed by hand, closed form $1/\bigl(6(\sqrt{55}+\sqrt{54})\bigr)$ |
| C10 | [results.md](../results.md):224's landscape line, read alone | **BROKEN as a citable form**, unconditional, labelled Lemma, carrying no grant and no threshold |

**Summary in one line.** The pricing half is a correct unconditional lemma whose constant I confirm by hand and whose proof lives in a reviewer report the block never names; the dichotomy half rests on three unproven inputs where the block admits one; and the record's own repair of the threshold (*"$\tilde\theta_0$, $\hat\theta_0$ and $\Theta_n$ are one object"*), is false, as the primary source defines all three and the record's own conventions file separates two of them.

**Verdict: HYPOTHESIS-DEBT**, with one BROKEN sub-claim inside the correction that was written to fix this block.

## 0. Conventions, fixed once

Fixed from [findings/conventions.md](../findings/conventions.md):55–68 before anything was checked, because two of the block's three constants are convention-carried.

- **The pairing.** $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ at the $\Lambda^2$ level, plain Frobenius on the pair matrix, so $\{\varphi_{ab}\}_{a<b}$ is orthonormal. For $A$ in $\Lambda^4\subset S^2(\Lambda^2)$ this makes $\lVert A\rVert^2=\sum_{i<j,\;k<l}A_{ijkl}^2=\tfrac14\sum_{i,j,k,l}A_{ijkl}^2$. **This quarter is where the block's $24$ comes from**, and the same file records that under plain Frobenius on $\Lambda^2$ the companion constant $6$ becomes $4$.
- **$\#$** is the halved Böhm–Wilking product; **$\mathrm{Ric}$** is the adjoint of $\cdot\wedge\mathrm{id}$, with $\lVert\mathrm{Ric}\rVert$ the Frobenius norm of the resulting symmetric $n\times n$ matrix.
- **Spectral parts.** $W=W_+-W_-$ with $W_\pm\succeq0$, so $\lvert W\rvert=W+2W_-$; $P_\pm,P_0$ are the spectral projections, $P_0$ onto $\ker\lvert W\rvert$. $\delta^2:=\lVert\mathrm{Alt}(W_-)\rVert^2$.
- **The three thresholds, from the primary source's Notation 3.0.3** ([diss_jaeger_florian.txt](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf):1767–1772), read rather than recalled:
  $$\theta_0(n)=\frac{\sqrt{2(n-1)(n-2)}}{n},\qquad \tilde\theta_0(n)=\sqrt{\frac{2(n-1)(n-3)}{(n+1)(n-2)}},\qquad \hat\theta_0(n):=\frac{n-2}{n-3}\,\tilde\theta_0(n)=\sqrt{\frac{2(n-1)(n-2)}{(n+1)(n-3)}} .$$
- **$\Theta_n$** is this record's own symbol ([conventions.md](../findings/conventions.md):19): the diagonal maximum, equal to $\theta_0(n)$ at even $n$ and to $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$.
- **$r=\lVert\mathrm{Ric}(\lvert W\rvert)\rVert$, $S=\mathrm{Ric}/r$**, and $e$ from Jäger's decomposition $\lvert W\rvert=\sqrt{1-e^2}\,\widehat{\mathrm{Ric}\owedge\mathrm{Ric}}+E$.
- **$J_4=\langle D(\lvert W\rvert),\mathrm{Ric}\rangle$, $J_5=\langle\mathrm{Ric}(X_{\mathrm{inv}}),\mathrm{Ric}\rangle$**, $X_{\mathrm{inv}}=\lvert W\rvert^\#-P_+W^\#P_+-P_-W^\#P_-$.

## 1. The hypothesis inventory

**Hypotheses the block names.** Exactly two: criticality (*"at every critical point"*), and *"granting that cross-term bound off the class where it is already proven"*. It names no dimension, no parity, no lower bound on $n$, and no definition of the threshold it is written against.

**Hypotheses the written argument actually uses**, each traced to the file that carries it and checked against the object it is applied to:

| # | Hypothesis | Where it enters | Status on the record | Named by the block? |
|---|---|---|---|---|
| H1 | Criticality, $\theta W=W^2+W^\#$ | the master identity ([ATTEMPTS.md](../ATTEMPTS.md) Result 1) | load-bearing and verified so, [REVIEW_r9.md](../reviews/REVIEW_r9.md) §1 records the identity **failing** at non-critical $W$ (residual $-0.54$ at $n=6$) | yes |
| H2 | $W$ is Weyl: $\mathrm{Ric}(W)=0$, $\mathrm{Alt}(W)=0$ | $\mathrm{Alt}(\lvert W\rvert)=2\mathrm{Alt}(W_-)$; $\mathrm{Ric}(2W_-)=\mathrm{Ric}(\lvert W\rvert)$ | proven, structural | no, assumed silently |
| H3 | $r=\lVert\mathrm{Ric}(\lvert W\rvert)\rVert\ne0$ | $S=\mathrm{Ric}/r$ and $\widehat{\mathrm{Ric}\owedge\mathrm{Ric}}$ are undefined otherwise | nowhere stated; the record's proven scal floor is where it would be discharged | no |
| H4 | $\langle\lvert W\rvert,\widehat{\mathrm{Ric}\owedge\mathrm{Ric}}\rangle\ge0$, i.e. the leading term's sign | writing the leading coefficient as $+\sqrt{1-e^2}$ | **tested only**, [REVIEW_r9.md](../reviews/REVIEW_r9.md) §1: *"the cosine … which was positive at every point tested"* | no |
| H5 | The Gram identity $D(R)=\tfrac32\,\mathrm{Gram}(\mathrm{Alt}\,R)$ | the whole pricing claim | **proven**, symbolically, in [REVIEW_r9.md](../reviews/REVIEW_r9.md) §2 | the constant is quoted; the proof's location is not |
| H6 | $D\succeq0$ as an $n\times n$ matrix | $J_4\le\lambda_{\max}\operatorname{tr}D$ | free, from H5 (a Gram matrix) | yes, as *"positive-semidefinite"* |
| H7 | $J_5\ge0$ | replaces the refuted $X_{\mathrm{inv}}\succeq0$ | **proven on the commuting class $[H,W]=0$** ([ATTEMPTS.md](../ATTEMPTS.md) Result 13, single-run, script halted at part 4 of 7); open off it | yes, this is the one grant |
| H8 | The E-track certificate | produces $c(12)$, hence the quoted $10^{-3}$ | [LEDGER.md](../findings/LEDGER.md):39, *"single-author since inception; never audited"* | **no** |
| H9 | Lemma 3.4.7's frame-free assembly (Jäger's Assumption 1/2 bookkeeping) | §3.4 → §3.5 hand-off | **owed**, [ATTEMPTS.md](../ATTEMPTS.md) Result 8's own Consequence: *"the remaining bookkeeping is the frame-free Lemma 3.4.7 assembly plus §3.6"*; Result 7 records 3.4.7 as *spot-verified numerically* | no |
| H10 | Lifted Lemma 3.3.5 | load-bearing for $c(12)$ | **discharged** by Result 11 (proven, with constant $4(n-1-\nu_0)$ in place of $4(n-2)$); Result 11 is itself marked *single-run, unreviewed* | no, and it need not be, being discharged |
| H11 | Jäger's $x\le2$ hypothesis | the lifted Lemma 3.3.6 ceiling on $\operatorname{tr}S^4$ | a **scope limit**, not a grant: Result 10 records the chain going vacuous for $\delta^2\gtrsim0.04$ | no |
| H12 | $\theta$ above the threshold | Corollary 3.2.6, and Assumption 2's contradiction | present in the source; see §6 on strictness | yes, as *"clearing the threshold"* |
| H13 | An $n$ for which $c(n)>0$ is established | the dichotomy's second branch | computed at $n=12$ only | no |

**Result.** The written argument uses thirteen hypotheses. The block names three of them (H1, H7, H12) and one property (H6). **Three of the unnamed ones are unproven** (H3, H4, H8) and H9 is unfinished. The block's *"granting that cross-term bound"* therefore understates the grant count by two even on the record's own accounting ([LEDGER.md](../findings/LEDGER.md):322 already says two; I find H9 as a third and H4 as a fourth).

## 2. Pre-registered question 1, is the pricing claim unconditional, and is its constant right?

**The claim, quoted.** *"The Bianchi correction is a positive-semidefinite Gram form in $\mathrm{Alt}(R)$ with universal constant $\tfrac32$, so it costs at most $24\,\|\mathrm{Alt}(W_-)\|^2\,\lambda_{\max}(\mathrm{Ric}(|W|))$"* ([problem.md](../findings/problem.md):311).

### 2.1 The derivation, in full

The identity the constant comes from is [ATTEMPTS.md](../ATTEMPTS.md) Result 2, for every symmetric $R$ on $\Lambda^2\mathbb R^n$:

$$D(R)_{ij}=\mathrm{Ric}(R^2+R^\#)_{ij}-\sum_{k,l}\mathrm{Ric}(R)_{kl}\,T_R(k,i,l,j)=\tfrac32\sum_{k,l,m}\mathrm{Alt}(R)_{iklm}\,\mathrm{Alt}(R)_{jklm}.$$

Three steps carry the claim.

**Step 1, positive semidefiniteness is free.** Set $a_i:=\bigl(\mathrm{Alt}(R)_{iklm}\bigr)_{k,l,m}\in(\mathbb R^n)^{\otimes3}$. Then $D_{ij}=\tfrac32\langle a_i,a_j\rangle$, so for any $x\in\mathbb R^n$, $x^{\mathsf T}Dx=\tfrac32\bigl\lVert\sum_i x_ia_i\bigr\rVert^2\ge0$. **$D\succeq0$ needs nothing beyond the identity itself**, no criticality, no Bianchi, no dimension bound. The block's *"positive-semidefinite Gram form"* is exact.

**Step 2, the trace, and where the $4$ enters.** Taking $i=j$ and summing,

$$\operatorname{tr}D(R)=\tfrac32\sum_{i,k,l,m}\mathrm{Alt}(R)_{iklm}^2=\tfrac32\cdot4\,\lVert\mathrm{Alt}(R)\rVert^2=6\,\lVert\mathrm{Alt}(R)\rVert^2,$$

the factor $4$ being exactly §0's $\lVert A\rVert^2=\tfrac14\sum_{ijkl}A_{ijkl}^2$ for $A\in\Lambda^4$ under the record's pairing. **This reproduces the record's scal-level constant $6$ from the component-level constant $\tfrac32$**, so the two are one statement and neither is free-standing.

Now $\lvert W\rvert=W+2W_-$ and $\mathrm{Alt}(W)=0$ give $\mathrm{Alt}(\lvert W\rvert)=2\,\mathrm{Alt}(W_-)$, hence $\lVert\mathrm{Alt}(\lvert W\rvert)\rVert^2=4\delta^2$ and

$$\operatorname{tr}D(\lvert W\rvert)=6\cdot4\,\delta^2=24\,\delta^2 .$$

**The $24$ is right, and it is $6\cdot4$ where the $6$ is the norm conversion and the $4$ is the squared spectral factor**, the record states this and I confirm it by hand.

**Step 3, the bound.** For $D\succeq0$ and any symmetric $\mathrm{Ric}$, diagonalise $D=\sum_k\mu_k u_ku_k^{\mathsf T}$ with $\mu_k\ge0$; then
$$J_4=\langle D,\mathrm{Ric}\rangle=\sum_k\mu_k\,u_k^{\mathsf T}\mathrm{Ric}\,u_k\le\lambda_{\max}(\mathrm{Ric})\sum_k\mu_k=\lambda_{\max}(\mathrm{Ric})\operatorname{tr}D=24\,\delta^2\,\lambda_{\max}(\mathrm{Ric}(\lvert W\rvert)).$$
No sign condition on $\mathrm{Ric}$ is needed. **Equality holds exactly when $\mathrm{Ric}$ acts as $\lambda_{\max}$ on $\operatorname{ran}D$**, which is the record's stated equality criterion.

### 2.2 Is it unconditional, pointwise and dimension-free?

**Unconditional: yes, given H5.** Steps 1 and 3 use only the identity and linear algebra. Step 2 uses $\mathrm{Alt}(W)=0$, which holds for every Weyl operator. **Criticality is never used.** So $J_4\le24\delta^2\lambda_{\max}(\mathrm{Ric}(\lvert W\rvert))$ holds at every Weyl $W$, critical or not.

**Pointwise: yes.** Every quantity is evaluated at the single operator $\lvert W\rvert$.

**Dimension-free: yes, and this is proven rather than screened.** [REVIEW_r9.md](../reviews/REVIEW_r9.md) §2 writes out the symbolic proof of H5, $D=\tfrac12A-B$ from $\mathrm{Ric}(R^2)=\tfrac12A$ and $\mathrm{Ric}(R^\#)=R.\mathrm{Ric}-B$; cyclic averaging on the last three slots giving $3\,\mathrm{Gram}(\mathrm{Alt}R)=A+G_1+G_2$; dummy relabelling giving $G_1=-B$, $G_2=G_1^{\mathsf T}$, $B=B^{\mathsf T}$, and records that **only the $S^2(\Lambda^2)$ symmetries are used, with no $n$ anywhere**. That is an argument on file, and it is what makes *"universal"* legitimate. It supersedes the record's earlier Weyl/Brauer stability route, which quoted the Brauer-kernel threshold rather than proving it.

**But it is not convention-free.** The $\tfrac32$ is stated in raw components and so survives any pairing. The $24$ does not: it is $\tfrac32\cdot4\cdot4$, and the middle $4$ is the record's $\Lambda^4$ norm convention. [conventions.md](../findings/conventions.md):57 records that under plain Frobenius on $\Lambda^2$ the companion $6$ reads $4$, under which the block's $24$ would read $16$. **The block states $\tfrac32$ and $24$ side by side as though both were universal; only the first is.**

**Saturation at the competitor.** The block says the bound is *"saturated exactly by the $\mathbb{CP}^2$-type competitor"*. At $\mathcal S^4(\alpha)$ (the same object, $\delta^2=1/9$, $P=\sqrt{3/2}$), $\mathrm{Ric}(\lvert W\rvert)$ is $\lambda_{\max}$ times the identity on a four-dimensional support, so $\mathrm{scal}=4\lambda_{\max}$ and Step 3's equality criterion is met, giving $J_4=24\cdot\tfrac19\cdot\tfrac{\mathrm{scal}}4=\tfrac{24}{9}\cdot\tfrac{\mathrm{scal}}{4}$, exactly the value [ATTEMPTS.md](../ATTEMPTS.md) Result 3 records, and consistent with [REVIEW_r9.md](../reviews/REVIEW_r9.md) §6's independent equality check. **Confirmed.**

### 2.3 Answer to question 1

**Yes, and yes, with two qualifications.** The pricing claim is unconditional (it does not even need criticality), pointwise, and dimension-free; its constant $\tfrac32$ is universal and its constant $24$ is right under the record's pairing and only under it. **The block carries no proof and names no file that does**: the proof of H5 sits in [REVIEW_r9.md](../reviews/REVIEW_r9.md), which neither the block, nor [results.md](../results.md), nor the derivation in [ATTEMPTS.md](../ATTEMPTS.md) Result 2 points to by name.

## 3. Pre-registered question 2, what does the dichotomy grant?

**The claim, quoted.** *"Granting that cross-term bound off the class where it is already proven, the chain gives: **every critical point clearing the threshold has either scalar curvature at least $(n+1)\tilde\theta_0(n)$, or defect bounded below by an explicit constant, computed at $n=12$ to be about $1.0\times10^{-3}$.***"

### 3.1 Every hypothesis it is conditional on

The dichotomy is [ATTEMPTS.md](../ATTEMPTS.md) Result 7's end-state, refined by Results 10, 11 and 13. Its conditions are H1, H2, H3, H4, H7, H8, H9, H11, H12 and H13 of §1. The four that matter:

- **H7, $J_5\ge0$.** Result 13 Theorem B proves it whenever $[H,W]=0$, and gives an isotropy argument for $[H,W]=0$ at every *named* critical point: $h=\mathrm{Ric}(\lvert W\rvert)$ is isotropy-invariant hence scalar on each isotypic factor, so $H=h\wedge2\,\mathrm{id}$ acts as $(c_k+c_l)\,\mathrm{Id}$ on each sector $V_k\wedge V_l$ that the invariant $W$ preserves. **Off that class it is open.** The block's phrase *"off the class where it is already proven"* is an accurate description of exactly this.
- **H8, the E-track certificate.** [LEDGER.md](../findings/LEDGER.md):39 marks it *"single-author since inception; never audited"*, and Result 10 makes it the source of the $c(n)$ margins. **The number $1.0\times10^{-3}$ in the block's own sentence is this certificate's output.** The block does not mention it.
- **H9, Lemma 3.4.7's frame-free assembly.** Result 7 records 3.4.7 as *"spot-verified numerically"*; Result 8's Consequence records the assembly as still owed. The block instead says *"§§3.4 and 3.5 then lift at no cost at all."*
- **H4, the leading term's sign.** See §5 below; it sits under the identity that every later step consumes.

### 3.2 Which the block names

One: H7. It also names criticality (H1) and the threshold condition (H12) in the statement itself. **It names neither H8 nor H9 nor H4.**

### 3.3 What a consumer reading the landscape line alone would believe

[results.md](../results.md):224 reads, in full:

> **Lemma L18 (lifting). The diagonal proof's middle chapters, lifted.** §3.3's workhorse inequality becomes an exact identity off the diagonal locus, with a positive-semidefinite correction pricing the defect; §§3.4–3.5 lift free. The chain splits every critical point above the threshold into large scalar curvature or defect bounded away from zero.

Such a reader would believe: (i) this is a **Lemma**, i.e. proven; (ii) the dichotomy is **unconditional**; (iii) it holds at **every** critical point above a threshold, with no dimension restriction; (iv) the threshold is some named quantity they can look up. **All four are wrong.** (i) the dichotomy half is an observation on grants; (ii) three of its inputs are unproven; (iii) $c(n)>0$ is established at $n=12$ alone; (iv) the threshold symbol is defined nowhere in this record. [results.md](../results.md):667 adds nothing but a pointer, *"**Proof:** [problem.md](findings/problem.md)"*, and problem.md's own heading promises *"canonical statement and proof"* above four paragraphs of prose containing no proof.

**Answer to question 2.** The dichotomy grants a conditional split under at least four unproven or unfinished inputs, of which the block admits one; and the landscape line a consumer would actually cite admits none.

## 4. Pre-registered question 3, what is $\tilde\theta_0(n)$?

### 4.1 It has a definition, and it is in [references/](../references/)

**The record is wrong to say the symbol is undefined; it is right that this record never registers it.** The primary source is on file, [references/jaeger-2016-diagonal-case/](../references/jaeger-2016-diagonal-case/), and its Notation 3.0.3 ([diss_jaeger_florian.txt](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf):1767–1772) defines all three symbols together:

$$\theta_0(n)=\frac{\sqrt{2(n-1)(n-2)}}{n},\qquad \tilde\theta_0(n)=\sqrt{\frac{2(n-1)(n-3)}{(n+1)(n-2)}},\qquad \hat\theta_0(n):=\frac{n-2}{n-3}\tilde\theta_0(n)=\sqrt{\frac{2(n-1)(n-2)}{(n+1)(n-3)}}.$$

The Remark preceding §3.1 (:1690–1700) supplies the meaning: $\tilde\theta_0(n)$ is the critical value of the normalised Weyl operator of $S^m\times S^{m+1}$, and *"$\tilde\theta_0(n)\le\theta_0(n)$ for all $n\ge3$, and most of the results will be proven for $\tilde\theta_0(n)$ and will therefore work for both, the even and the odd dimensional case. Only at the end of the whole proof it will be needed that $\theta\ge\theta_0(n)$."* So $\tilde\theta_0$ is **the weaker, parity-neutral threshold under which §§3.2–3.5 run**, precisely the sections this block lifts.

**The chain's use of it is faithful.** Corollary 3.2.6 (:2176) gives $\mathrm{scal}\notin\bigl((n-3)\tilde\theta_0(n),(n+1)\tilde\theta_0(n)\bigr)$; Assumption 2 (:2212) assumes $\mathrm{scal}\le(n-3)\tilde\theta_0(n)$ for contradiction; §3.3's stated goal (:2203) is $\mathrm{scal}>(n-3)\tilde\theta_0(n)$, *"from which $\mathrm{scal}\ge(n+1)\tilde\theta_0(n)$ would follow by corollary 3.2.6"*. **The block's $(n+1)\tilde\theta_0(n)$ is the source's own figure, verbatim.** No finding against it.

### 4.2 The record's identification of it is false, a BROKEN sub-claim

**Locate it exactly.** [problem.md](../findings/problem.md):303: *"$\tilde\theta_0(n)$ IS DEFINED NOWHERE, AND IS $\Theta_n$ UNDER A SECOND NAME. … $\hat\theta_0$ is a third variant of the same thing."* Carried forward verbatim into [lean/INDEX.md](../lean/INDEX.md):207 (*"$\tilde\theta_0$, $\hat\theta_0$ and $\Theta_n$ are one object under three names"*), with the row's status recorded as **proved**.

**Exhibit the failure concretely, at $n=12$.** All three squares are rationals, so the comparison is exact and takes no root:

$$\tilde\theta_0(12)^2=\frac{2\cdot11\cdot9}{13\cdot10}=\frac{99}{65},\qquad \Theta_{12}^2=\theta_0(12)^2=\frac{2\cdot11\cdot10}{144}=\frac{55}{36},\qquad \hat\theta_0(12)^2=\frac{2\cdot11\cdot10}{13\cdot9}=\frac{220}{117}.$$

Cross-multiplying: $99\cdot36=3564<3575=55\cdot65$, so $\tfrac{99}{65}<\tfrac{55}{36}$; and $220\cdot36=7920>6435=55\cdot117$, so $\tfrac{220}{117}>\tfrac{55}{36}$. **Three distinct positive rationals, hence three distinct thresholds:** $\tilde\theta_0(12)<\Theta_{12}<\hat\theta_0(12)$.

The failure is structural, not a $n=12$ accident:

- **$\hat\theta_0\ne\tilde\theta_0$ at every $n>3$**, since $\hat\theta_0(n)=\frac{n-2}{n-3}\tilde\theta_0(n)$ and $\frac{n-2}{n-3}>1$. The *definition* refutes "a third variant of the same thing."
- **$\tilde\theta_0\ne\Theta_n$ at every even $n$.** At even $n$, [conventions.md](../findings/conventions.md):19 sets $\Theta_n=\theta_0(n)$, and the same file's line 18 records the identity $(n-2)^2(n+1)-n^2(n-3)=4$ (which I confirm by expansion, $(n^2-4n+4)(n+1)=n^3-3n^2+4$ against $n^3-3n^2$), giving
  $$\theta_0(n)^2-\tilde\theta_0(n)^2=\frac{2(n-1)\bigl[(n-2)^2(n+1)-n^2(n-3)\bigr]}{n^2(n+1)(n-2)}=\frac{8(n-1)}{n^2(n+1)(n-2)}>0\quad\text{for all }n\ge3.$$
  At $n=12$ this is $\frac{88}{18720}=\frac{11}{2340}$, which is exactly $\frac{55}{36}-\frac{99}{65}$. **The record's own conventions file therefore contains the refutation of the record's own identification.**

**Argue the opposite, the most charitable reading the words support.** At **odd** $n$, $\Theta_n$'s formula *is* $\tilde\theta_0(n)$, character for character; the record's screen was taken at $n=13$, which is odd, and there the identification is exactly right ($\Theta_{13}^2=\tilde\theta_0(13)^2=\tfrac{2\cdot12\cdot10}{14\cdot11}=\tfrac{120}{77}$). So the sentence is a true statement about the odd branch, overstated into a statement about the symbol. **That charitable reading does not rescue it**, because the block's only numerical claim (the $c(12)\approx10^{-3}$), lives at $n=12$, on the branch where the identification fails; and no reading rescues the $\hat\theta_0$ clause, which the source's own definition contradicts at every $n$.

**Candidate stands: BROKEN.**

### 4.3 What value it must take for the chain to close, and whether the record has it under another name

**It must take Jäger's value $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$**, and nothing weaker: the whole point of the lift is that §§3.2–3.5 run under the weaker threshold, so replacing $\tilde\theta_0$ by $\theta_0$ would surrender the parity-neutrality the chain is built on, and replacing it by $\hat\theta_0$ (larger by $\frac{n-2}{n-3}$), would make Corollary 3.2.6's gap interval the wrong one. **The record does carry that quantity under another name: it is $\Theta_n$'s odd branch**, and only that branch. Registering $\tilde\theta_0(n)$ in [conventions.md](../findings/conventions.md) as the single formula $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$, valid at every $n$, with $\Theta_n=\max\{\theta_0,\tilde\theta_0\}$ read off it, would fix the symbol and the identification at once. **That is a repair for the owner, not for a verifier, and I have not made it.**

## 5. The level of the quoted cost, and the identity beneath it

### 5.1 A chain penalty and its numerator, the block quotes the numerator

**Locate it exactly.** [problem.md](../findings/problem.md):311: *"it costs at most $24\,\|\mathrm{Alt}(W_-)\|^2\,\lambda_{\max}(\mathrm{Ric}(|W|))$"*, followed two sentences later by *"the chain gives: every critical point clearing the threshold has either …"*.

**Exhibit the failure concretely.** [ATTEMPTS.md](../ATTEMPTS.md) Result 7 states the chain's penalty explicitly:

> *"the lifted §§3.3–3.5 chain runs exactly as Jäger's does except for the single additive penalty $(J_4-J_5)/\sqrt{1-e^2}\le24\,\delta^2\lambda_{\max}(\mathrm{Ric}(|W|))/\sqrt{1-e^2}$ inherited from §3.3"*

So there are **three different quantities** in play:

| Quantity | Value | Which the block quotes |
|---|---|---|
| The §3.3 correction term | $J_4$ |, |
| Its bound | $24\delta^2\lambda_{\max}(\mathrm{Ric}(\lvert W\rvert))$ | **this one** |
| The chain penalty | $(J_4-J_5)/\sqrt{1-e^2}$, bounded by $24\delta^2\lambda_{\max}/\sqrt{1-e^2}$ | what the dichotomy consumes |

Since $0<1-e^2\le1$, dividing a positive penalty by $\sqrt{1-e^2}$ **strictly increases** it whenever $e\ne0$, and $e\ne0$ is exactly the off-diagonal situation the whole block is about, $e$ measuring the part of $\lvert W\rvert$ orthogonal to $\widehat{\mathrm{Ric}\owedge\mathrm{Ric}}$. So the block's figure is a strict understatement of the cost the dichotomy pays, **in the direction that makes the dichotomy easier to satisfy**. The block never writes $e$, never writes $J_5$, and never signals that a division is coming.

**Argue the opposite.** Read strictly, the sentence's subject is *"the Bianchi correction"*, i.e. $D$, and $J_4=\langle D,\mathrm{Ric}\rangle\le24\delta^2\lambda_{\max}$ is exactly and unconditionally that correction's cost, as §2 derives. **On that reading the sentence is true and the defect is one of placement, not arithmetic**, the true §3.3-level statement is set immediately beside a dichotomy that needs the divided form, so a consumer who reads the two sentences as one argument inherits the wrong penalty. That is the more charitable reading and I adopt it: **the sentence is correct; its use in the next sentence is not.** Candidate stands as a level error, confirming what [LEDGER.md](../findings/LEDGER.md):324 already records as owed.

### 5.2 The identity the whole block rests on carries an unproven sign, HYPOTHESIS-DEBT

**Locate it exactly.** [problem.md](../findings/problem.md):309: *"Spectral compressions of the criticality equation turn the workhorse inequality of Jäger's §3.3 into an exact identity holding at every critical point in every frame, verified at machine precision on the named families and on generic saddle points alike."*

The identity is [ATTEMPTS.md](../ATTEMPTS.md) Result 1:
$$\theta r^2=\sqrt2\,r^2\sqrt{1-\operatorname{tr}S^4}\,\sqrt{1-e^2}\;-\;2\langle\mathrm{Ric}(W_-^2),\mathrm{Ric}\rangle\;+\;J_4\;-\;J_5 .$$

**Exhibit the failure concretely.** The only argument on file is [REVIEW_r9.md](../reviews/REVIEW_r9.md) §1, which supplies a four-line hand derivation and then says of the leading factor:

> *"the '$\sqrt{1-e^2}$' factor is the cosine $c=\langle|W|,\widehat{\mathrm{Ric}\owedge\mathrm{Ric}}\rangle$, **which was positive at every point tested**."*

The decomposition $\lvert W\rvert=c\,\widehat{\mathrm{Ric}\owedge\mathrm{Ric}}+E$ determines $\lvert c\rvert=\sqrt{1-e^2}$ but not the sign of $c$; writing the leading term as $+\sqrt2\,r^2\sqrt{1-\operatorname{tr}S^4}\sqrt{1-e^2}$ **asserts $c\ge0$**. At a critical point where $c<0$ the leading term flips sign and every downstream inequality of the lifted §§3.3–3.5 chain reverses direction at its dominant term. Nothing in [problem.md](../findings/problem.md), [ATTEMPTS.md](../ATTEMPTS.md) or [results.md](../results.md) proves $c\ge0$; the two remaining links of the same hand proof ($\langle\lvert W\rvert.\mathrm{Ric},\mathrm{Ric}\rangle=\langle\lvert W\rvert,\mathrm{Ric}\owedge\mathrm{Ric}\rangle$ and $\lVert\mathrm{Ric}\owedge\mathrm{Ric}\rVert=\sqrt2\,r^2\sqrt{1-\operatorname{tr}S^4}$) are likewise recorded as *"verified here to $10^{-15}$"* and *"printed explicitly in the script"*.

**Argue the opposite.** $\lvert W\rvert\succeq0$ and $\mathrm{Ric}\owedge\mathrm{Ric}$ is built from $\mathrm{Ric}(\lvert W\rvert)$, so $c\ge0$ is plausible on general grounds, and Jäger works in the diagonal case where it may be immediate. **That is a reason to expect the statement, not an argument for it, and the record carries no argument**, so I state the debt and stop. **A verifier who supplied the missing positivity proof here would be handing the record a fresh proof nobody audited.**

**What would have to be shown:** that $\langle\lvert W\rvert,\mathrm{Ric}(\lvert W\rvert)\owedge\mathrm{Ric}(\lvert W\rvert)\rangle\ge0$ at every critical point of the general problem, or, failing that, the identity restated with $c$ carried as a signed scalar and every downstream step re-derived for both signs.

**Consequence for the block's wording.** *"verified at machine precision"* is the block's own evidence clause, and it is accurate: what the block calls an exact identity is, on the record, an identity with a proof whose three load-bearing links are numerically checked. **Numerical agreement is an open hypothesis, never evidence**, so C3 is HYPOTHESIS-DEBT, not a false claim.

## 6. Quantifier order, scope, and the edge of every range

**Quantifier order, as the block writes it.** *"every critical point clearing the threshold has either scalar curvature at least $(n+1)\tilde\theta_0(n)$, or defect bounded below by an explicit constant, computed at $n=12$ to be about $1.0\times10^{-3}$."* Read left to right this is $\forall n\,\forall W\,[\,\ldots\,]$ with a constant $c(n)$ that exists for every $n$. **The record supports $\exists$-at-one-$n$, not $\forall n$**: [ATTEMPTS.md](../ATTEMPTS.md) Result 7 writes *"with $c(n)$ explicit from the E-track margins"* and Results 10–11 compute the margins at $n=12$ only. **The correct order is: for $n=12$, for every critical point with $\theta>\tilde\theta_0(12)$, the split holds with $c(12)=1.0008\times10^{-3}$.** The block's *"computed at $n=12$"* reads as an illustration of a general fact; it is the whole of the fact.

**Odd $n$.** The dichotomy is parity-neutral *in principle*, which is the entire reason the source runs §§3.2–3.5 under $\tilde\theta_0$ rather than $\theta_0$, see [diss_jaeger_florian.txt](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf):1697–1700 and [ATTEMPTS.md](../ATTEMPTS.md):801. **In practice no odd-$n$ instance exists on the record**: $c(n)$ is computed at $n=12$, and $c$ at any odd $n$ is uncomputed. So the parity-neutrality is inherited from the source and unexercised here. **No finding against the block; a scope the block does not mark.**

**The smallest admissible $n$.** The block states none. Three separate floors are in play and they disagree:
- Jäger's Assumption 1 is chapter-wide $n\ge16$ and even ([README.md](../references/jaeger-2016-diagonal-case/README.md), Theorem A quoted verbatim).
- §3.5's two quartics have largest real roots $14.811$ and $14.963$, giving $n\ge15$ ([ATTEMPTS.md](../ATTEMPTS.md) Result 2), and Result 2's own corrected headline records that **the analytical route to $n=12,14$ was never supplied**; what supports those dimensions is numerical.
- The block's only instance is $n=12$.

**So the block's silent quantifier over $n$ spans a range where the source's own hypothesis fails and the record's substitute for it is numerical.** This is the sharpest scope defect after the grant count.

**$\ker W\ne0$.** No claim in the block is restricted to $\ker W=0$, and the case is live rather than exceptional: $P_0$ projects onto $\ker\lvert W\rvert$, and the record's own compressions ($P_0W^\#P_0=0$, $P_0X_{\mathrm{inv}}P_0=P_0\lvert W\rvert^\#P_0$) exist precisely to handle it; [REVIEW_r9.md](../reviews/REVIEW_r9.md) §3 records that at the $\mathbb{CP}^2$-type competitor $\Pi_{\mathrm{ASD}}\subset\ker W$ and that $\ker W$ there carries a padded $\mathcal W_{n-4}$ of dimension $300$ at $n=12$. **The pricing bound of §2 is untouched by $\ker W\ne0$**, Steps 1–3 use no invertibility. **What $\ker W\ne0$ does touch is $J_5$**, whose $P_0$ block is the one the record's $X_{\mathrm{inv}}$ reduction has to absorb, and H3 ($r\ne0$), which is about $\mathrm{Ric}(\lvert W\rvert)$ rather than $\ker W$ and is nowhere stated. **No finding against the block on $\ker W$; H3 stands as an unstated hypothesis.**

**The edge of the threshold, a candidate I withdraw.** The block writes *"clearing the threshold"*, and the record writes $\theta\ge\tilde\theta_0(n)$ throughout. The source's Corollary 3.2.6 proof (:2184) reads *"Since $\theta\ge\theta_0(n)>\tilde\theta_0(n)$ by assumption 1, $0<\ldots$"*, the display's **strict** inequality comes from $\theta'>\tilde\theta_0(n)$ strictly, and at $\theta=\tilde\theta_0(n)$ exactly it would degrade to $0\le$, changing which endpoints of the excluded scalar-curvature interval survive and therefore whether $\mathrm{scal}>(n-3)\tilde\theta_0$ still upgrades to $\mathrm{scal}\ge(n+1)\tilde\theta_0$. **I withdraw this candidate at step 2 of the protocol**: the interval's brackets in Corollary 3.2.6 (:2176) are PDF glyphs that the text extraction renders as bare digits, so I cannot read open from closed, and I will not decide a boundary case from a mangled character. **Recorded as unresolved from the source, with the reason.** What is certain is that the source proves it under $\theta\ge\theta_0(n)$, which is strictly greater than $\tilde\theta_0(n)$ at every $n\ge3$ by §4.2's identity, so the record's restatement at $\theta\ge\tilde\theta_0(n)$ is a widening the source does not perform, whatever the brackets say.

## 7. The forms compared

| Location | Form | Label | Grants shown | Threshold named |
|---|---|---|---|---|
| [problem.md](../findings/problem.md):309–313 | four prose paragraphs under a heading promising *"canonical statement and proof"* | Lemma | one ($J_5$ cross-term) | $\tilde\theta_0(n)$, undefined here |
| [problem.md](../findings/problem.md):297–307 | five audit blockquotes, dated 2026-09-04 | (| says two, and refutes the "one term" count | says $\tilde\theta_0$ is $\Theta_n$), **false at even $n$, §4.2** |
| [results.md](../results.md):224 | one landscape sentence | **Lemma** | **none** | *"the threshold"*, unnamed |
| [results.md](../results.md):667 | heading plus *"**Proof:** [problem.md](findings/problem.md)"* | **Lemma** | **none** | none |
| [lean/INDEX.md](../lean/INDEX.md):207 | prose row, status **proved** |, | lists the owed items correctly | asserts the three-names identification |
| [L18.lean](../lean/HamiltonsCubic/Results/L18.lean) | six theorems | (|), | see below |

**On the Lean row specifically.** The file's theorems are: `theta_thirteen_sq` ($\Theta_{13}^2=120/77$), `theta_thirteen_bracket` (a rational bracket on its root), `theta0_twelve_sq` ($\theta_0(12)^2=55/36$), `window_width`, `divided_form_is_larger` ($x^2<x^2/(1-e^2)$), `constant_twentyfour` ($2^2=4\wedge6\cdot4=24$), `three_entries_net` and `understated_by`. **Not one of them mentions $\tilde\theta_0$ or $\hat\theta_0$.** The identification *"$\tilde\theta_0$, $\hat\theta_0$ and $\Theta_n$ are one object under three names"* appears in the module docstring and in the INDEX row, and is carried by neither theorem, so the row's status **proved** attaches to arithmetic that does not reach the claim the row leads with, and the claim it leads with is false (§4.2). **What the row would have to claim** to be honest: that $\Theta_{13}^2=120/77$ and that the $n=12$ window lies in $(0.0112,0.0113)$ (both of which the file does prove) and, if the threshold identification is to appear at all, `theta_tilde_ne_Theta_at_even_n`, e.g. $\tilde\theta_0(12)^2=99/65<55/36=\Theta_{12}^2$, which is one `norm_num` away.

**Two Lean theorems I flag as dressed arithmetic.** `three_entries_net` proves $24+24-32/5=208/5$ and `understated_by` proves $(208/5)/24=26/15$. Those are true about rationals. **They are presented as a statement about the chain**, that the block's $24$ understates a net penalty of $208/5$. The three entries are not summands of one quantity: the first $24\delta^2$ is the §3.3 master correction, the second is Lemma 3.3.1's via 3.2.2, and the $-6.4\delta^2$ is Lemma 3.2.3's $\Lambda^4$ term, three different inequalities about three different quantities ([ATTEMPTS.md](../ATTEMPTS.md) Result 10(a)). **The count is right and the block's *"one exactly-priced term"* is wrong; the netting into $208/5$ is an aggregation the record does not justify**, and Lean's imprimatur now sits on it.

**And the window claim I confirm by hand.** $\theta_0(12)-\sqrt{3/2}=\frac{\sqrt{55}-\sqrt{54}}{6}=\frac{1}{6(\sqrt{55}+\sqrt{54})}$. Since $7.416^2=54.997<55<55.012=7.417^2$ and $7.348^2=53.993<54<54.008=7.349^2$, the sum lies in $(14.764,14.766)$, so the width lies in $\bigl(\tfrac{1}{6\cdot14.766},\tfrac{1}{6\cdot14.764}\bigr)\subset(0.01128,0.01129)\subset(0.0112,0.0113)$. **Confirmed**, and the closed form $1/\bigl(6(\sqrt{55}+\sqrt{54})\bigr)$ (which the record does not give), makes the bracket a two-line hand check rather than a root computation.

## 8. The gap between what is proven and what is used, and what a consumer may cite

**Proven, and citable as such:**

1. **The Gram identity.** $D(R)=\tfrac32\,\mathrm{Gram}(\mathrm{Alt}\,R)$ for every symmetric $R$ on $\Lambda^2\mathbb R^n$, every $n$, symbolic proof in [REVIEW_r9.md](../reviews/REVIEW_r9.md) §2, using only the $S^2(\Lambda^2)$ symmetries.
2. **$D\succeq0$**, free from 1.
3. **$\operatorname{tr}D(\lvert W\rvert)=24\delta^2$**, under the record's pairing (§0), from 1 plus $\mathrm{Alt}(\lvert W\rvert)=2\mathrm{Alt}(W_-)$.
4. **$J_4\le24\,\delta^2\,\lambda_{\max}(\mathrm{Ric}(\lvert W\rvert))$** at every Weyl $W$ (no criticality, no dimension bound), with equality iff $\mathrm{Ric}$ acts as $\lambda_{\max}$ on $\operatorname{ran}D$.
5. **Lifted Lemmas 3.4.6, 3.4.3 and 3.4.8**, with hand proofs in [ATTEMPTS.md](../ATTEMPTS.md) Result 8 (one cosmetic index-order slip flagged by [REVIEW_r9.md](../reviews/REVIEW_r9.md) §5).
6. **Lifted Lemma 3.3.5's replacement**, [ATTEMPTS.md](../ATTEMPTS.md) Result 11, with the weaker constant $4(n-1-\nu_0)$; marked single-run and unreviewed.
7. **$J_5\ge0$ on the commuting class $[H,W]=0$**, [ATTEMPTS.md](../ATTEMPTS.md) Result 13 Theorem B; and $J_5^{\mathrm{diag}}\ge0$ unconditionally, Result 5(b).
8. **$\theta_0(12)-\sqrt{3/2}\in(0.0112,0.0113)$**, confirmed here by hand.

**Used but not proven:** H3 (the identity needs $r\ne0$); H4 (the leading term's sign); H7 off the commuting class; H8, the E-track certificate, *"never audited"*, which produces the quoted $10^{-3}$; H9, Lemma 3.4.7's frame-free assembly; H13, $c(n)>0$ at any $n\ne12$.

**What a consumer may cite, exactly.**

> *For every Weyl operator $W$ on $\Lambda^2\mathbb R^n$, at every $n\ge4$, the Bianchi correction $D(\lvert W\rvert)$ is positive semidefinite with $\operatorname{tr}D(\lvert W\rvert)=24\lVert\mathrm{Alt}(W_-)\rVert^2$ under the record's $\Lambda^2$ pairing, so $J_4=\langle D(\lvert W\rvert),\mathrm{Ric}(\lvert W\rvert)\rangle\le24\,\delta^2\,\lambda_{\max}(\mathrm{Ric}(\lvert W\rvert))$, with equality at the $\mathbb{CP}^2$-type competitor.*

**Nothing about the dichotomy may be cited as a lemma**, and nothing about it may be cited without naming $J_5\ge0$ off the commuting class, the E-track certificate, and $n=12$.

## 9. The named trap, each citable claim read alone, as a consumer would

**The trap is realised here in its strongest form: the correction is not merely beside the statement, it is in a different file.** [problem.md](../findings/problem.md) carries five audit blockquotes above the block. [results.md](../results.md) (the canon, and the file a consumer cites), carries **none of them**, at :224 or at :667. A reader who cites `results.md:224` inherits:

- **"Lemma"**, for a claim the record itself splits into a lemma and an observation on grants.
- **"§§3.4–3.5 lift free"**, with the Lemma 3.4.7 assembly still owed.
- **"The chain splits every critical point above the threshold"**, a universal quantifier over a threshold the sentence does not name, in a record where that symbol has no definition, backed by a constant computed at one dimension.
- **No grant at all.**

Read alone, the pricing sentence in [problem.md](../findings/problem.md):311 is **true** (§2) and its neighbour, the dichotomy sentence, is **not the same statement**, they differ by a division by $\sqrt{1-e^2}$ and by two unnamed grants. **A citation that takes the pair as one argument inherits both defects, which is exactly this record's signature failure.**

**And the trap has now propagated one level further.** The correction written to fix this block, [problem.md](../findings/problem.md):303, is itself wrong about $\hat\theta_0$ and about $\Theta_n$ at even $n$ (§4.2), and it has been copied into [lean/INDEX.md](../lean/INDEX.md):207 under the status **proved**, where a consumer would take it as machine-checked. It is not: no theorem in [L18.lean](../lean/HamiltonsCubic/Results/L18.lean) mentions either symbol.

## 10. What would break each surviving statement, and what I did to look

| Statement | The object that would falsify it | What I did |
|---|---|---|
| The pricing bound (§2) | a symmetric $R$ with $x^{\mathsf T}D(R)x<0$ for some $x$, or a Weyl $W$ with $\langle D,\mathrm{Ric}\rangle>\lambda_{\max}\operatorname{tr}D$ | derived both from the Gram form by hand; **neither can exist given the identity**, so the only falsifier is a counterexample to the identity itself, which [REVIEW_r9.md](../reviews/REVIEW_r9.md) §2 proves symbolically in every dimension from the $S^2(\Lambda^2)$ symmetries alone |
| The constant $24$ | a pairing convention on $\Lambda^4$ other than $\tfrac14\sum_{ijkl}$ | found one, [conventions.md](../findings/conventions.md):57 records plain Frobenius sending the companion $6$ to $4$, hence $24$ to $16$; **the block does not name its convention** |
| The identity (H4) | a critical point with $\langle\lvert W\rvert,\widehat{\mathrm{Ric}\owedge\mathrm{Ric}}\rangle<0$ | searched [problem.md](../findings/problem.md), [ATTEMPTS.md](../ATTEMPTS.md) Results 1–13, [REVIEW_r9.md](../reviews/REVIEW_r9.md) and the source for a positivity proof; **found only "positive at every point tested"**. Under the analysis-only rule I opened no search for such a point and did not screen for one; the finding is the absence of the argument |
| The three-names identification | an $n$ where $\tilde\theta_0(n)$, $\hat\theta_0(n)$, $\Theta_n$ differ | **found: every $n>3$ for $\hat\theta_0$, every even $n$ for $\Theta_n$**; exhibited at $n=12$ by comparing $99/65$, $55/36$, $220/117$ as exact rationals |
| The dichotomy | a critical point at $n=12$ with $\theta>\tilde\theta_0(12)$, $\delta^2<c(12)$ and $\mathrm{scal}(\lvert W\rvert)<13\,\tilde\theta_0(12)$ | such a point cannot be found by reading, and the rule forbids hunting for it; **the standing obstruction is instead that the constant it would have to beat is the output of an unaudited certificate** |

**Analysis-only compliance.** No script was run, no sweep, census, optimisation or falsifier hunt was opened, and no screen was taken. Every number in this report is an exact hand evaluation of a rational, or a hand bracket of a square root by squaring integers.

## Verdict

**HYPOTHESIS-DEBT**, containing one **BROKEN** sub-claim.

- **The pricing half is a lemma and survives**: unconditional, pointwise, dimension-free, constant $\tfrac32$ universal, constant $24=6\cdot4$ right under the record's pairing. Its proof exists, in [REVIEW_r9.md](../reviews/REVIEW_r9.md), and the block names neither it nor [ATTEMPTS.md](../ATTEMPTS.md).
- **The dichotomy half is an observation on four unproven or unfinished inputs** (H4, H7 off the commuting class, H8, H9), of which the block names one and [results.md](../results.md) names none, at one dimension, against a threshold this record never defines.

**What would have to be shown for the block to stand as written:** (a) $\langle\lvert W\rvert,\widehat{\mathrm{Ric}\owedge\mathrm{Ric}}\rangle\ge0$ at every critical point, or the identity restated with a signed leading coefficient; (b) $J_5\ge0$ off the commuting class; (c) an independent audit of the E-track certificate that produces $c(12)$; (d) the frame-free Lemma 3.4.7 assembly; (e) $c(n)>0$ at some $n$ other than $12$, if the universal quantifier is to be kept; and (f) the cost restated as $24\delta^2\lambda_{\max}(\mathrm{Ric}(\lvert W\rvert))/\sqrt{1-e^2}$ wherever the dichotomy consumes it.

**And one repair is owed to the correction rather than to the block:** [problem.md](../findings/problem.md):303 and [lean/INDEX.md](../lean/INDEX.md):207 must stop saying that $\tilde\theta_0$, $\hat\theta_0$ and $\Theta_n$ are one object. $\tilde\theta_0(n)$ is defined, in [references/jaeger-2016-diagonal-case/](../references/jaeger-2016-diagonal-case/) Notation 3.0.3; it equals $\Theta_n$ at odd $n$ and is strictly smaller at even $n$; and $\hat\theta_0=\frac{n-2}{n-3}\tilde\theta_0$ is a different number at every $n>3$.
