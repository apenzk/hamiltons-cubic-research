# VERIFY v126, L18: the $\tfrac32$-Gram pricing of the Bianchi defect, the conditional dichotomy it feeds, and the three thresholds $\tilde\theta_0$, $\hat\theta_0$, $\Theta_n$

**Cold brief.** Verifier v126 on [ROUND_L18.md](ROUND_L18.md), checking the text quoted there from [problem.md](../findings/problem.md):291–313 with the canonical forms at [results.md](../results.md):224 and :667. **No numerical work was done**: no script was run, and every number below is an exact hand evaluation of a closed form, stated as a rational or a radical wherever one exists. Sources were read, never cited from memory, Jäger's thesis was read in the record's own stored extraction, [diss_jaeger_florian.txt](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf), and the block's argument was read in [ATTEMPTS.md](../ATTEMPTS.md)'s section *Lifting Jäger's §3.3 in trace form* (lines 860–932) and in [REVIEW_r9.md](../reviews/REVIEW_r9.md), which the record names as the source of two of its proofs. I deliberately did not read [REVIEW_r477.md](../reviews/REVIEW_r477.md) or [REVIEW_r478.md](../reviews/REVIEW_r478.md), the two verdicts on this same block, so that the findings below are independent; fragments of both reached me through greps and are flagged where they did. Log: [agent_logs/verify-L18-v126.log](../agent_logs/verify-L18-v126.log).

## Claim table

| # | Claim, as the block states it | Verdict |
|---|---|---|
| C1 | The Bianchi correction is a PSD Gram form in $\mathrm{Alt}(R)$ with universal constant $\tfrac32$ | **PROVEN** |
| C2 | It costs at most $24\lVert\mathrm{Alt}(W_-)\rVert^2\lambda_{\max}(\mathrm{Ric}(\lvert W\rvert))$ | **PROVEN, hypotheses corrected** (needs $\mathrm{Alt}(W)=0$; needs no criticality) |
| C3 | The constant $24$ is right | **PROVEN**, as $6\cdot2^2$, by hand |
| C4 | That cost is what the chain pays | **BROKEN**, the chain pays $(J_4-J_5)/\sqrt{1-e^2}$, larger by $3/2$ at Fox |
| C5 | "The answer is **one** exactly-priced term" | **BROKEN**, the block's own source records three defect entries |
| C6 | The dichotomy, "granting that cross-term bound" | **HYPOTHESIS-DEBT**, four live grants, of which the block names one |
| C7 | Threshold $\theta\ge\tilde\theta_0(n)$ and floor $(n+1)\tilde\theta_0(n)$ | **HYPOTHESIS-DEBT**, defined in the source, undefined in the record |
| C8 | *(banner, [problem.md](../findings/problem.md):303 and [lean/INDEX.md](../lean/INDEX.md):207)* $\tilde\theta_0$, $\hat\theta_0$ and $\Theta_n$ are one object under three names | **BROKEN**, $\hat\theta_0=\tfrac{n-2}{n-3}\tilde\theta_0$, and $\tilde\theta_0=\Theta_n$ at odd $n$ only |
| C9 | *(banner and Lean row)* the three entries net $208/5$, a factor $26/15$ above $24$ | **BROKEN**, the three coefficients live at two different homogeneity degrees, and one of them is an $n=12$ number |
| C10 | The width $0.011$ is $\theta_0(12)-\sqrt{3/2}$, and is [Lemma L13](../findings/curvature-invariants.md)'s denominator | **PROVEN**, both halves reproduced exactly by hand |

**Summary.** The pricing half is a genuine unconditional lemma and its constant is right; the dichotomy half is an observation on four grants where the block names one, is quoted at the wrong level of the chain, and turns on a threshold symbol the record defines nowhere, and two of the corrections already standing beside the block are themselves false, one of them stamped **proved** in [lean/INDEX.md](../lean/INDEX.md).

**Verdict: HYPOTHESIS-DEBT.**

## 0. Conventions, fixed once

- **Inner product on $S^2(\Lambda^2)$.** $\langle A,B\rangle=\sum_{i<j,\,k<l}A_{ijkl}B_{ijkl}$, i.e. plain Frobenius in the ordered-pair basis $e_i\wedge e_j$, $i<j$. [conventions.md](../findings/conventions.md) fixes the $\tfrac12$ at the $\Lambda^2$ level and plain Frobenius on the pair matrix, and warns that under plain Frobenius on $\Lambda^2$ the $6$ of the trace identity becomes $4$. Every constant below is stated in the first convention, the one the record's proofs commit to.
- **A totally antisymmetric $A\in\Lambda^4\subset S^2(\Lambda^2)$** therefore has $\lVert A\rVert^2=\sum_{i<j,k<l}A_{ijkl}^2=\tfrac14\sum_{i,j,k,l}A_{ijkl}^2$. This one factor is what reconciles the block's $\tfrac32$ with the trace identity's $6$; §2 does the reconciliation.
- **Spectral parts.** $W_-:=\tfrac12(\lvert W\rvert-W)\succeq0$ per [conventions.md](../findings/conventions.md), so $\lvert W\rvert=W+2W_-$ and $W=W_+-W_-$ with $W_\pm\succeq0$. $P_+,P_-,P_0$ are the spectral projections of $W$ onto the positive, negative and zero eigenspaces. **This is not Jäger's $\lvert W\rvert$**: his Notation 3.0.3 (extraction lines 1720–1741) builds $W_\pm$ **entrywise** in the coordinate pair basis. The two agree exactly on the diagonal locus and nowhere else, and "lifting" means replacing the entrywise reading by the spectral one.
- **Defect.** $\delta^2:=\lVert\mathrm{Alt}(W_-)\rVert^2$, with $\delta^2=1/9$ at the $\mathbb{CP}^2$-type competitor, which [problem.md](../findings/problem.md):149 identifies term-by-term with Fox's $\mathcal S^4(\alpha)$, so the two names in the sources are one object, and I use them interchangeably below.
- **Thresholds, all three read off the stored source** ([diss_jaeger_florian.txt](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf) lines 1693–1695 and 1760–1772):
  $$\theta_0(n)=\frac{\sqrt{2(n-1)(n-2)}}{n},\qquad \tilde\theta_0(n)=\sqrt{\frac{2(n-1)(n-3)}{(n+1)(n-2)}},\qquad \hat\theta_0(n)=\frac{n-2}{n-3}\,\tilde\theta_0(n)=\sqrt{\frac{2(n-1)(n-2)}{(n+1)(n-3)}}.$$
- **$\Theta_n$**, from [conventions.md](../findings/conventions.md) line 19: the diagonal maximum, equal to $\theta_0(n)$ at even $n$ and to $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$.
- **The two contraction-level quantities.** $J_4=\langle D(\lvert W\rvert),\mathrm{Ric}\rangle$ with $D$ the Bianchi correction of [ATTEMPTS.md](../ATTEMPTS.md) Result 2; $J_5=\langle\mathrm{Ric}(X_{\mathrm{inv}}),\mathrm{Ric}\rangle$ with $X_{\mathrm{inv}}=\lvert W\rvert^\#-P_+W^\#P_+-P_-W^\#P_-$.

## 1. The hypothesis inventory

**Hypotheses the block states in words.** Exactly three: the point is critical; it "clears the threshold"; and "that cross-term bound" is granted off the class where it is proven. No dimension, no parity, no norm.

**Hypotheses the block carries silently, each checked against the object it applies to.**

| # | Hypothesis | Where it enters | Status on the record |
|---|---|---|---|
| H1 | $W$ is a Weyl operator: $\mathrm{Ric}(W)=0$ and $\mathrm{Alt}(W)=0$ | the factor $4$ in the constant $24$; the identity $\mathrm{Ric}(2W_-)=\mathrm{Ric}(\lvert W\rvert)$ that lifts Lemma 3.4.3 | definitional, holds |
| H2 | $\lVert W\rVert=1$ | every quoted number: $\delta^2=1/9$, $c(12)\approx10^{-3}$, the width $0.011$ | assumed, unstated |
| H3 | criticality $W^2+W^\#=\theta W$ | the master identity of §3.3, and the compressions $(W^\#)_{\mathrm{cross}}=0$ | proven from H3 in two lines: $W^\#=\theta W-W^2$ is a polynomial in $W$, hence commutes with it |
| H4 | $\theta\ge\tilde\theta_0(n)$ | the hypothesis of the whole §§3.3–3.5 chain | the symbol is undefined in the record, §4 |
| H5 | the Gram identity $D(R)=\tfrac32\,\mathrm{Gram}(\mathrm{Alt}\,R)$ | the pricing half entirely | **proven**, by hand, in [REVIEW_r9.md](../reviews/REVIEW_r9.md) §2; uses only the $S^2(\Lambda^2)$ symmetries, so it is dimension-free and Bianchi-free |
| H6 | $J_5\ge0$ at critical points | the passage from the master identity to the one-sided §3.3 bound | **proven only on $\{[H,W]=0\}$** ([ATTEMPTS.md](../ATTEMPTS.md) Result 13, Theorem B); this is the grant the block names |
| H7 | the E-track certificate | it *is* the source of $c(12)$ | [LEDGER.md](../findings/LEDGER.md) records it *single-author since inception, never audited* |
| H8 | the frame-free Lemma 3.4.7 assembly | closing §3.5 | "spot-verified numerically" ([ATTEMPTS.md](../ATTEMPTS.md) Result 7); no proof on file |
| H9 | Jäger's Lemma 3.5.6 at $n=12$ | the scalar branch $\operatorname{scal}\ge(n+1)\tilde\theta_0(n)$ | his Assumption 1 fixes $n=2m$, $m\ge8$; $n=12$ exists only through the record's own threshold section, which says twice that **no independent reviewer has audited it** |
| H10 | Assumption 1 read with $\tilde\theta_0$ in place of $\theta_0$ | the chain's hypothesis | Assumption 1 as written (extraction line 1706) says $\theta\ge\theta_0(n)$; the substitution rests on Jäger's remark at lines 1697–1701, not on a re-derivation |
| H11 | lifted Lemma 3.3.5 with constant $1/(4(n-1-\nu_0))$ | load-bearing for $c(12)$ | discharged ([ATTEMPTS.md](../ATTEMPTS.md) Result 11), but **weaker than Jäger's $n-2$ whenever $\nu_0<1$**, which is why $c(12)$ fell to $92.6\%$ of its granted value |
| H12 | the cosine $\sqrt{1-e^2}=\langle\lvert W\rvert,\widehat{\mathrm{Ric}\owedge\mathrm{Ric}}\rangle$ is positive | the sign of the master identity's leading term | "positive at every point tested" ([REVIEW_r9.md](../reviews/REVIEW_r9.md) §1), empirical |

**Which the written argument uses.** The four prose paragraphs use H1–H4 and H6 and nothing else; H5 is gestured at ("a positive-semidefinite Gram form … with universal constant $\tfrac32$") without the trace step that turns $\tfrac32$ into $24$; H7–H12 are invisible in the block. **Of the twelve, the block names one (H6) and even that only as "that cross-term bound".**

## 2. Pre-registered question 1, the pricing claim, its constant, and whether it is unconditional

### 2.1 The derivation, in full

The block asserts a bound; the bound is assembled from three facts, of which the block states one.

**(i) The Gram identity.** [ATTEMPTS.md](../ATTEMPTS.md) Result 2: for every symmetric $R$ on $\Lambda^2\mathbb R^n$,
$$D(R)_{ij}:=\mathrm{Ric}(R^2+R^\#)_{ij}-\sum_{k,l}\mathrm{Ric}(R)_{kl}T_R(k,i,l,j)=\tfrac32\sum_{k,l,m}\mathrm{Alt}(R)_{iklm}\,\mathrm{Alt}(R)_{jklm}.$$
Being a Gram matrix, $D(R)\succeq0$ for every symmetric $R$, with no further hypothesis. **This is proven.** The record's first proof carries two acknowledged standard gaps (an $n$-independence claim by inspection, and the Brauer kernel threshold quoted rather than re-proven), but [REVIEW_r9.md](../reviews/REVIEW_r9.md) §2 supplies a second proof with neither: writing $A_{ab}=\sum_{jpq}R_{ajpq}R_{bjpq}$ and $B_{ab}=\sum_{xyz}R_{axyz}R_{yxbz}$, one has $\mathrm{Ric}(R^2)=\tfrac12A$ and $\mathrm{Ric}(R^\#)=R.\mathrm{Ric}-B$, so the $R.\mathrm{Ric}$ terms cancel and $D=\tfrac12A-B$; cyclic averaging on the last three slots gives $3\,\mathrm{Gram}(\mathrm{Alt}\,R)=A+G_1+G_2$; dummy relabelling gives $G_1=-B$, $G_2=G_1^{\mathsf T}$ and $B=B^{\mathsf T}$, whence $\tfrac32\,\mathrm{Gram}=\tfrac12A-B=D$. Only the $S^2(\Lambda^2)$ symmetries are used, so the identity is an identity of formal index expressions: **dimension-free, and independent of the first Bianchi identity.**

**(ii) The trace.** Taking $i=j$ and summing, $\operatorname{tr}D(R)=\tfrac32\sum_{i,k,l,m}\mathrm{Alt}(R)_{iklm}^2$. By §0's convention $\sum_{\text{all four}}=4\lVert\mathrm{Alt}(R)\rVert^2$, so
$$\operatorname{tr}D(R)=\tfrac32\cdot4\,\lVert\mathrm{Alt}(R)\rVert^2=6\,\lVert\mathrm{Alt}(R)\rVert^2,$$
which is the record's scalar-level identity. **So the block's $\tfrac32$ and the record's $6$ are the same constant read at two index conventions**, and the block states the one the reader cannot use without the other.

**(iii) The doubling.** $\lvert W\rvert=W+2W_-$ and $\mathrm{Alt}$ is linear, so $\mathrm{Alt}(\lvert W\rvert)=\mathrm{Alt}(W)+2\,\mathrm{Alt}(W_-)=2\,\mathrm{Alt}(W_-)$, the first term dying because $W$ is Weyl. Hence
$$\operatorname{tr}D(\lvert W\rvert)=6\lVert 2\,\mathrm{Alt}(W_-)\rVert^2=6\cdot4\,\delta^2=24\,\delta^2 .$$

**(iv) The bound.** For $D\succeq0$, write $D=\sum_a\mu_au_au_a^{\mathsf T}$ with every $\mu_a\ge0$. Then
$$J_4=\langle D,\mathrm{Ric}\rangle=\sum_a\mu_a\,u_a^{\mathsf T}\mathrm{Ric}\,u_a\;\le\;\lambda_{\max}(\mathrm{Ric})\sum_a\mu_a=\lambda_{\max}(\mathrm{Ric})\operatorname{tr}D=24\,\delta^2\,\lambda_{\max}(\mathrm{Ric}(\lvert W\rvert)),$$
with equality exactly when every $u_a$ with $\mu_a>0$ is a $\lambda_{\max}$-eigenvector, i.e. when $\mathrm{Ric}$ is $\lambda_{\max}$ times the identity on $\operatorname{ran}D$.

### 2.2 The three answers

- **Is the constant right?** **Yes: $24=6\cdot2^2$**, the $6$ from $\tfrac32\cdot4$ at the pair-basis convention and the $4$ from $\mathrm{Alt}(\lvert W\rvert)=2\,\mathrm{Alt}(W_-)$. I checked the equality case by hand at the competitor: [REVIEW_r9.md](../reviews/REVIEW_r9.md) §3 derives $\mathrm{Alt}(W_-)=a\star$ with $a=1/(3\sqrt6)$, and $\lVert\star\rVert^2=6$ in the pair basis gives $\delta^2=6a^2=6/54=1/9$ exactly, so $24\delta^2=8/3$; with $\mathrm{Ric}(\lvert W\rvert)$ a multiple of the identity on its four-dimensional support, $\lambda_{\max}=\operatorname{scal}/4$ and the bound is attained. The block's "saturated exactly by the $\mathbb{CP}^2$-type competitor" is therefore right, and it is right for the reason (iv) gives.
- **Is it unconditional?** **Yes, on the corrected hypothesis list.** Step (i) needs no hypothesis at all; (ii) needs none; (iii) needs $\mathrm{Alt}(W)=0$, i.e. that $W$ is Bianchi, **which the block never says**, and which is the whole content of the factor $4$; (iv) needs only $D\succeq0$, and holds whatever the sign of $\mathrm{Ric}$. **Criticality is not used anywhere in the pricing half.** The block presents the pricing inside a paragraph whose subject is critical points, which makes the lemma look narrower than it is.
- **Pointwise and dimension-free?** **Yes.** Nothing in (i)–(iv) refers to $n$, and (i) is proven dimension-free by [REVIEW_r9.md](../reviews/REVIEW_r9.md)'s route rather than by the stability argument. The bound is a pointwise inequality at a single operator.

**No finding on the $\tfrac32$ itself:** I looked for a competing normalisation under which the identity would read with a different constant, and [conventions.md](../findings/conventions.md) records exactly that risk ("under plain Frobenius on $\Lambda^2$ the $6$ becomes $4$") but the block's $\tfrac32$ and the record's $6$ are mutually consistent in the convention the record's proofs commit to, so there is no inconsistency between them to report.

## 3. The level of the quoted cost, a numerator quoted where the chain needs a quotient

### 3.1 Locate it

The block, [problem.md](../findings/problem.md):312: *"The Bianchi correction is a positive-semidefinite Gram form in $\mathrm{Alt}(R)$ with universal constant $\tfrac32$, **so it costs at most** $24\,\|\mathrm{Alt}(W_-)\|^2\,\lambda_{\max}(\mathrm{Ric}(|W|))$"*.

The file that holds the argument, [ATTEMPTS.md](../ATTEMPTS.md) Result 7: *"the lifted §§3.3–3.5 chain runs exactly as Jäger's does except for the single additive penalty $(J_4-J_5)/\sqrt{1-e^2}\le24\,\delta^2\lambda_{\max}(\mathrm{Ric}(|W|))/\sqrt{1-e^2}$"*.

So the quantity the chain pays is $(J_4-J_5)/\sqrt{1-e^2}$, and $24\delta^2\lambda_{\max}$ is a bound on $J_4$ alone, the numerator, and only half of it.

### 3.2 Exhibit the failure concretely

At Fox's $\mathcal S^4(\alpha)$, which is the competitor the block itself names as the saturating point, [ATTEMPTS.md](../ATTEMPTS.md) line 1406 records the closed-form collapse of its data: $\operatorname{tr}\hat S^4=1/4$ and $\sqrt{1-e^2}=2/3$. Hence at that point, exactly,
$$e^2=\tfrac59,\qquad \frac{1}{\sqrt{1-e^2}}=\frac32 .$$
At Fox, $X_{\mathrm{inv}}=0$ identically ([ATTEMPTS.md](../ATTEMPTS.md) Result 4), so $J_5=0$ and the penalty is exactly $\tfrac32 J_4$. **The chain penalty at the block's own equality point is $50\%$ larger than the number the block quotes.** Since $J_4\le24\delta^2\lambda_{\max}$ is attained there, the block's quoted ceiling is not merely loose at Fox, it is *exceeded* by the quantity it is offered as a ceiling for.

### 3.3 Argue the opposite

The most charitable reading the words support: "it" in "so it costs at most" refers to *the Bianchi correction* $J_4$, not to the chain, and as a statement about $J_4$ the sentence is exactly right (§2). On that reading the block states a true lemma and simply omits the transfer to the chain. But the very next sentence draws the dichotomy (*"Granting that cross-term bound …, the chain gives …"*), with no other cost mentioned anywhere, so a consumer has been handed a cost and a conclusion and nothing between them. And the omission is not sign-neutral: $\sqrt{1-e^2}\le1$ always, so dividing by it can only enlarge a positive penalty, i.e. the omission runs in the direction that makes the dichotomy easier to prove.

**Not withdrawn.** The candidate survives all three steps: the line is located, the failure is exhibited at a named point with exact rational data, and the charitable reading leaves the defect standing as an omission with a direction.

**Verdict on C4: BROKEN**, in the precise sense that the quoted quantity is at the wrong level of the chain, and the correction is not conservative.

## 4. Pre-registered question 3, what $\tilde\theta_0(n)$ is

### 4.1 There is a definition, and it is in [references/](../references/)

The record defines the symbol nowhere: it is absent from [conventions.md](../findings/conventions.md), whose opening rule is that a block needing a convention adds it there, and absent from [INDEX-values.md](../findings/INDEX-values.md). But **the claim does not rest on an unread source**. Jäger's thesis is stored at [diss_jaeger_florian.txt](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf), and I read the definition there. Lines 1687–1696:

> *Let $\tilde W_0$ be the normalized Weyl curvature operator of $S^m\times S^{m+1}$ … Then $\tilde W_0^2+\tilde W_0^\#=\tilde\theta_0(n)\tilde W_0$ for $\tilde\theta_0(n)=\sqrt2\sqrt{(n-1)(n-3)/((n+1)(n-2))}$.*

Restated at line 1762 alongside $\theta_0$, and at line 1772 the third symbol is **defined**, not glossed:
$$\hat\theta_0(n):=\frac{n-2}{n-3}\,\tilde\theta_0(n)=\sqrt{\frac{2(n-1)(n-2)}{(n+1)(n-3)}} .$$
I checked that the two forms of $\hat\theta_0$ agree: $\bigl(\tfrac{n-2}{n-3}\bigr)^2\cdot\tfrac{2(n-1)(n-3)}{(n+1)(n-2)}=\tfrac{2(n-1)(n-2)}{(n+1)(n-3)}$, identically in $n$.

And the floor in the block's conclusion is Jäger's Lemma 3.5.6 verbatim (extraction line 4178): *"Let assumption 1 hold. Then $\operatorname{scal}\ge(n+1)\tilde\theta_0(n)$."* So the block's *"scalar curvature at least $(n+1)\tilde\theta_0(n)$"* is his statement transported, and the symbol carries his meaning.

### 4.2 The record's own repair is wrong in two independent ways

[problem.md](../findings/problem.md):303 and, stamped **proved**, [lean/INDEX.md](../lean/INDEX.md):207 say: *"$\tilde\theta_0$, $\hat\theta_0$ and $\Theta_n$ are one object under three names"*, and [LEDGER.md](../findings/LEDGER.md):324 records the owed repair as *"Register $\tilde\theta_0(n)$, which is $\Theta_n$ under a second name with $\hat\theta_0$ as a third."*

**(a) $\hat\theta_0$ is not the same object.** By the definition at line 1772 it is $\tfrac{n-2}{n-3}$ times $\tilde\theta_0$, strictly larger at every $n>3$, by $11\%$ at $n=12$ and $10\%$ at $n=13$. Exactly: $\tilde\theta_0(13)^2=\tfrac{2\cdot12\cdot10}{14\cdot11}=\tfrac{120}{77}$ against $\hat\theta_0(13)^2=\tfrac{121}{100}\cdot\tfrac{120}{77}=\tfrac{66}{35}$, whose ratio is $\tfrac{121}{100}$ and not $1$. In decimals, $\tilde\theta_0(13)=1.2483756$ and $\hat\theta_0(13)=1.3732132$; they differ in the first decimal place. The symbol is load-bearing under that name: [ATTEMPTS.md](../ATTEMPTS.md) line 910 states Lemma 3.3.1 in the form $r^2\ge\hat\theta_0\operatorname{scal}-24\delta^2$, so a consumer who follows the record's instruction to fold $\hat\theta_0$ into $\Theta_n$ inflates that inequality's left-hand requirement by $\tfrac{n-2}{n-3}$.

**(b) $\tilde\theta_0=\Theta_n$ holds at odd $n$ only.** By [conventions.md](../findings/conventions.md) line 19, $\Theta_n=\theta_0(n)$ at **even** $n$ and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at **odd** $n$. The odd branch is $\tilde\theta_0$ verbatim, a formula match, which is stronger than the record's evidence for the identification (a screened decimal at $n=13$ plus a Lean bracketing of $\sqrt{120/77}$). But the even branch is $\theta_0$, and $\theta_0\ne\tilde\theta_0$:
$$\theta_0(n)^2-\tilde\theta_0(n)^2=\frac{2(n-1)(n-2)}{n^2}-\frac{2(n-1)(n-3)}{(n+1)(n-2)}=\frac{8(n-1)}{n^2(n+1)(n-2)}\;>\;0 \quad(n\ge2),$$
the numerator $8$ coming from $(n-2)^2(n+1)-n^2(n-3)=4$, which is [conventions.md](../findings/conventions.md)'s own identity. **At $n=12$** (the dimension at which every number in the block is quoted), this reads
$$\Theta_{12}^2=\theta_0(12)^2=\frac{220}{144}=\frac{55}{36},\qquad \tilde\theta_0(12)^2=\frac{2\cdot11\cdot9}{13\cdot10}=\frac{99}{65},\qquad \frac{55}{36}-\frac{99}{65}=\frac{11}{2340}\ne0 .$$
So $\tilde\theta_0(12)=1.2341302$ against $\Theta_{12}=1.2360331$. **The identification the record proved at $n=13$ is false at $n=12$**, and $n=12$ is where the chain is run, where $c(12)$ is computed, and where the window is measured.

**Argue the opposite.** The charitable reading is that "one object under three names" means *one formula family*, and that the intended repair is only to stop writing a symbol the record never registered. That reading survives for $\tilde\theta_0$ at odd $n$. It does not survive for $\hat\theta_0$, which is a different formula by an explicit factor and appears in a different lemma; and it does not survive the instruction to "replace it by $\Theta_n$ throughout", which at even $n$ silently strengthens the chain's hypothesis from $\theta\ge\tilde\theta_0$ to $\theta\ge\theta_0$ and strengthens its conclusion's floor from $(n+1)\tilde\theta_0$ to $(n+1)\theta_0$. The direction matters: [ATTEMPTS.md](../ATTEMPTS.md) Result 10 records two constants, $c(12)=1.081\times10^{-3}$ at $\theta\ge\tilde\theta_0(12)$ against $1.223\times10^{-3}$ at $\theta\ge\theta_0(12)$, so the two thresholds are already known to the record to give different results at $n=12$.

**Verdict on C8: BROKEN.** What must be shown for the repair as written to be sound: that $\hat\theta_0=\tilde\theta_0$ (false, by line 1772) and that $\Theta_n=\tilde\theta_0$ at even $n$ (false, by $11/2340\ne0$ at $n=12$).

### 4.3 What the value must be for the chain to close, and whether the record has it

$\tilde\theta_0(n)=\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$, and nothing weaker: it is the hypothesis threshold of §§3.3–3.5 and simultaneously the constant in the conclusion's floor $(n+1)\tilde\theta_0(n)$, so the two occurrences must be the same number or Lemma 3.5.6's contradiction does not close. **The record does carry that quantity under another name, but only at odd $n$**, as $\Theta_n$; at even $n$ the record has no name for it at all, and $\Theta_n$ is the wrong one.

## 5. Pre-registered question 2, what the dichotomy grants

### 5.1 Every hypothesis it is conditional on

Beyond H1–H4 of §1, which are the shape of the statement rather than grants, the dichotomy is conditional on **four live grants**:

1. **$J_5\ge0$ off the commuting class.** [ATTEMPTS.md](../ATTEMPTS.md) Result 13 proves it on $\{[H,W]=0\}$ with $H=\mathrm{Ric}^*(\mathrm{Ric}(\lvert W\rvert))$, by an isotropy argument, and proves that class contains every named critical point. Off it, what exists is a Cauchy–Schwarz bound *"a three-block factor short of closing"* and a per-point gap-commutator certificate that fails to cover two $n=6$ points. **This is the grant the block names.**
2. **The E-track certificate.** It produces $c(n)$; [LEDGER.md](../findings/LEDGER.md) records it *single-author since inception, never audited*, and [ATTEMPTS.md](../ATTEMPTS.md) Result 10 attributes the headline $c(12)$ to *"the E-track margins"*. The block's *"about $1.0\times10^{-3}$"* is this certificate's output and nothing else's.
3. **The frame-free Lemma 3.4.7 assembly.** [ATTEMPTS.md](../ATTEMPTS.md) Result 6 leaves it as *"the frame-free Assumption-1/2 bookkeeping"*, and Result 7 says it was *"spot-verified numerically"*. A numerical spot-check is not a proof; by this record's own first rule it is not even evidence.
4. **Jäger's Lemma 3.5.6 at $n=12$.** His Assumption 1 (extraction line 1705) reads *"Let $m\ge8$ be an integer, and let $n=2m$"*, so the printed theorem starts at $n=16$. The record's threshold section removes that, but closes with *"no independent reviewer has audited this section"*, stated twice, and its $n=12$ step (the moment-body floor $(\operatorname{tr}S^3)^2\ge0.12712$ against the required $0.09933$) is by the same author in two implementations.

A fifth, H10 in §1, is not a grant so much as a reading: Assumption 1 as written stipulates $\theta\ge\theta_0(n)$, and the chain is run at $\theta\ge\tilde\theta_0(n)$ on the strength of Jäger's remark that *"most of the results will be proven for $\tilde\theta_0(n)$"*. "Most" is his word. The record nowhere re-derives which of §§3.3–3.5 consume the weaker threshold.

### 5.2 Which the block names

**One of four.** *"Granting that cross-term bound off the class where it is already proven"* names grant 1 and stops. Grants 2, 3 and 4 appear nowhere in the block, and grant 2 is the one the headline number is the output of.

### 5.3 What a consumer reading the landscape line alone would believe

[results.md](../results.md):224 reads: *"**Lemma L18 (lifting). The diagonal proof's middle chapters, lifted.** §3.3's workhorse inequality becomes an exact identity off the diagonal locus, with a positive-semidefinite correction pricing the defect; §§3.4–3.5 lift free. The chain splits every critical point above the threshold into large scalar curvature or defect bounded away from zero."*

A consumer reading that line alone would believe: that L18 is a **Lemma**, hence proved; that the split holds at **every** critical point above the threshold, in every dimension, with no grant; that the correction is priced and the pricing is part of the lemma; and that "§§3.4–3.5 lift free" is a completed statement. **Three of the four are wrong.** The split is an Observation on four grants; the dimension range is at best $n\ge12$ and the constant exists only at $n=12$; and §3.5 "lifts free" only modulo grants 3 and 4. The one thing the line gets right is the pricing, which is the half that really is a lemma.

The canonical form at [results.md](../results.md):667 (*"Lemma L18), the diagonal proof's middle chapters, lifted with the defect cost quantified"*, followed by **Proof:** [problem.md](../findings/problem.md), is worse in one respect: it promises a proof at a destination that carries four prose paragraphs and no derivation, and the file that does carry the derivation, [ATTEMPTS.md](../ATTEMPTS.md), is named by neither.

## 6. Quantifier order, scope, and the edges of every range

- **Quantifier order.** The block reads *"every critical point clearing the threshold has either scalar curvature at least $(n+1)\tilde\theta_0(n)$, or defect bounded below by an explicit constant"*. The constant must be chosen **before** the point ($\forall n\,\exists c(n)>0\,\forall W$) and the record honours this: $c(n)$ is a function of $n$ from the E-track margins. But the block writes *"an explicit constant, computed at $n=12$ to be about $1.0\times10^{-3}$"*, which reads as one constant with one evaluation. **Only $c(12)$ exists on the record.** The dichotomy at any other dimension is a statement whose constant has never been produced.
- **Smallest admissible $n$.** The block states none. The floor is at least $12$: Lemma 3.5.4 carries $k\ge12$; Jäger's own chain closes at $n\ge16$ even; the record's extension reaches $12$ and $14$ unaudited. Below $12$ the dichotomy is not merely unproven but expected false in spirit, at $n\le11$ the competitor sits above $\theta_0$, which is why [Conjecture L16](../findings/problem.md) is stated from $n\ge12$ and refuted at $n=8$.
- **Odd $n$.** The block's threshold $\tilde\theta_0$ is precisely Jäger's device for covering odd $n$, so the statement is presumably meant at both parities. Two obstructions: Assumption 1 as written fixes $n=2m$, and the record's dimension census ([ATTEMPTS.md](../ATTEMPTS.md), threshold section, Result 5) finds $m\ge8$ used genuinely once, in §3.6, which the dichotomy does not consume, so the parity restriction is plausibly removable but is not removed anywhere in writing. Meanwhile §4's finding bites here: at odd $n$ the record's own repair ($\tilde\theta_0=\Theta_n$) is correct, and at even $n$ it is not, so the repair and the statement have **opposite** parity ranges.
- **$\ker W\ne0$.** The compressions are stated as $P_+W^\#P_-=P_0W^\#P_0=0$, so the zero eigenspace is explicitly in scope, and [ATTEMPTS.md](../ATTEMPTS.md) Result 4's $X_{\mathrm{inv}}$ retains block-off-diagonal terms $P_\pm W^\#P_0+P_0W^\#P_\pm$ which Result 13's Theorem A later shows vanish. The two are consistent, $W^\#=\theta W-W^2$ commutes with $W$, hence annihilates every cross block including those meeting $\ker W$, but the record states the weaker form in one place and the stronger in another without retiring the first. **A consumer citing Result 4's displayed $X_{\mathrm{inv}}$ inherits terms that are zero.** This matters at exactly the points where $\ker W\ne0$: at the competitor $\Pi_{\mathrm{ASD}}\subset\ker W$ ([REVIEW_r9.md](../reviews/REVIEW_r9.md) §3), so the kernel is not a degenerate case but the equality case.
- **$\mathrm{Ric}(\lvert W\rvert)=0$.** The master identity divides by $\lVert\mathrm{Ric}\owedge\mathrm{Ric}\rVert$ and the dichotomy divides by $r^2$, so both need $\mathrm{Ric}(\lvert W\rvert)\ne0$. The record does not state this side condition anywhere in the block. **No finding on its substance:** $\mathrm{Ric}(\lvert W\rvert)=2\,\mathrm{Ric}(W_-)$ with $\mathrm{Ric}(W_-)\succeq0$, so it vanishes only if $W_-=0$, i.e. $W\succeq0$, which for a trace-free Weyl operator forces $W=0$, but that one-line exclusion is mine, not the record's, and I record it as a missing side condition rather than supplying it into the statement.

## 7. Comparing the forms

| Site | What it says | Divergence |
|---|---|---|
| [problem.md](../findings/problem.md):291–313 | four prose paragraphs; pricing + dichotomy on one named grant; *"one exactly-priced term"*; the numerator as the cost; $\tilde\theta_0$ undefined | the only site with the mathematics, and it has no proof |
| [results.md](../results.md):224 | *"lifted"*, **no condition at all**; *"§§3.4–3.5 lift free"*; *"splits every critical point above the threshold"* | drops all four grants and the dimension range |
| [results.md](../results.md):667 | *"lifted with the defect cost quantified"*, **Proof:** [problem.md](../findings/problem.md) | promises a proof that the destination does not carry |
| [INDEX-results.md](../findings/INDEX-results.md) row 18 | records the split and **two** grants | the count is two, not four; no mention of the cost level or of $\tilde\theta_0$ |
| [lean/INDEX.md](../lean/INDEX.md):207 | *"proved"*, and the prose asserts the three-names identification and the $208/5$ netting | both assertions are false, §4.2 and §8 |
| [L18.lean](../lean/HamiltonsCubic/Results/L18.lean) | five rational facts | see below |

**What the Lean file actually proves**, read line by line: `ThetaOddSq 13 = 120/77` and a bracketing of its root; `θ₀(12)² = 55/36`; that $t-s$ lies in $(0.0112,0.0113)$ given brackets on $t$ and $s$; that $x/\sqrt{1-e^2}>x$ for $0<e<1$ on squares; that $2^2=4$ and $6\cdot4=24$; and that $24+24-32/5=208/5$ with $(208/5)/24=26/15$. **Every one of these is a true rational arithmetic fact, and none of them is L18.** In particular the file contains **no** statement identifying $\tilde\theta_0$ with $\hat\theta_0$ or with $\Theta_n$ at even $n$, the odd formula is the only $\Theta$ defined there. So the false identification lives entirely in the INDEX row's prose, under a **proved** stamp earned by theorems that do not say it. What the row would have to claim to be honest: *"the odd-$n$ branch of $\Theta_n$ is $\tilde\theta_0$ verbatim; $\hat\theta_0=\tfrac{n-2}{n-3}\tilde\theta_0$ is a distinct quantity; at even $n$, $\Theta_n=\theta_0\ne\tilde\theta_0$."*

## 8. "One exactly-priced term", and the $208/5$ that was put beside it

### 8.1 The block's count

The block: *"The answer is **one** exactly-priced term."* Its own source, [ATTEMPTS.md](../ATTEMPTS.md) line 910, records three: *"Lemma 3.3.1 is not defect-free, via 3.2.2 it becomes $r^2\ge\hat\theta\operatorname{scal}-24\delta^2$, partially offset through 3.2.3's $\Lambda^4$ term ($-6.4\delta^2$ at $n=12$, helpful direction)"*, alongside the $J_4$ entry the block prices. **Located, exhibited, and the charitable reading, that "one term" means one term *in §3.3's workhorse inequality*, is refuted by the fact that Lemma 3.3.1 is itself in §3.3.** So C5 is BROKEN as written.

### 8.2 But the correction placed beside it is also wrong

[lean/INDEX.md](../lean/INDEX.md):207 and [ATTEMPTS.md](../ATTEMPTS.md):4499 say the three entries net $24+24-6.4=41.6=208/5$, *"a factor $26/15$ above the block's $24$"*, and [L18.lean](../lean/HamiltonsCubic/Results/L18.lean) certifies the arithmetic. The arithmetic is right; the mathematics is not, for two independent reasons.

- **The three coefficients sit at different homogeneity degrees.** The priced entry is $J_4\le24\delta^2\lambda_{\max}(\mathrm{Ric})$, an inequality between quantities cubic in $W$: $J_4=\langle D,\mathrm{Ric}\rangle$ with $D$ quadratic and $\mathrm{Ric}$ linear, and on the right $\delta^2$ quadratic times $\lambda_{\max}$ linear. The other two entries are corrections to $r^2\ge\hat\theta_0\operatorname{scal}-24\delta^2$, an inequality between quantities **quadratic** in $W$. Adding a coefficient that multiplies $\delta^2\lambda_{\max}$ to coefficients that multiply $\delta^2$ produces a number, not a constant of any inequality. There is no inequality on the record of the form $(\text{penalty})\le\tfrac{208}5\,\delta^2\lambda_{\max}$, and none of the form $\le\tfrac{208}5\delta^2$ either.
- **One of the three is an $n=12$ number.** The $-6.4\delta^2$ is stated *"at $n=12$"*; $24$ is dimension-free. So $208/5$ and $26/15$ are $n=12$ figures compared against a universal constant, and neither the INDEX row nor the Lean docstring says so.

**Argue the opposite.** The most charitable reading is that $208/5$ is a *tally*, a reminder that three $\delta^2$-coefficients appear across the lifted chain and that the block mentions one. On that reading the entry is informative and the phrase *"a factor $26/15$ above the block's $24$"* is the only false part, since it asserts a comparison between two costs of the same thing. That phrase is what a consumer will cite, and it is what the Lean row's `understated_by` is named for.

**Verdict on C9: BROKEN**, with the true statement being the count (three entries, one named) rather than the netted constant.

## 9. The width, and the cross-block claim, both check out exactly

The block: *"the rival maximizer forces any closing bound into a window of width $0.011$ at $n=12$ … **That width is $\theta_0(12)-\sqrt{3/2}$, between $0.0112$ and $0.0113$**, and it is the denominator [Lemma L13](../findings/curvature-invariants.md) divides by for its excess figure."*

**The width.** $\theta_0(12)=\sqrt{220}/12=\sqrt{55}/6$ and $\sqrt{55}=7.4161985\ldots$, so $\theta_0(12)=1.2360331$; $\sqrt{3/2}=1.2247449$; the difference is $0.0112882$, which lies in $(0.0112,0.0113)$. And [ATTEMPTS.md](../ATTEMPTS.md) Result 10 gives the window as $[1.2247,1.2360)$ (the interval from the competitor's value to $\theta_0(12)$) so the identification of "the $0.011$-wide target" with $\theta_0(12)-\sqrt{3/2}$ is right.

**The cross-block claim, which I checked because it is the block's only quantitative link to another result.** [Lemma L13](../findings/curvature-invariants.md) states the method ceiling $\lambda^2(1+k_0/4)\le\tfrac{(n-1)(2n-1)}4$ with $k_0\le\binom n2$, and reports *"an excess of $58.9\times$ at $n=12$ and $3.09\times$ asymptotically"*. Taking $k_0$ at its stated ceiling $\binom{12}2=66$:
$$\lambda^2\le\frac{(11)(23)/4}{1+66/4}=\frac{253/4}{35/2}=\frac{253}{70}=3.6142857,\qquad \lambda\le1.9011276 .$$
Then
$$\frac{\lambda-\theta_0(12)}{\theta_0(12)-\sqrt{3/2}}=\frac{1.9011276-1.2360331}{0.0112882}=\frac{0.6650945}{0.0112882}=58.92,$$
and asymptotically, with $\lambda\to2$ and $\theta_0\to\sqrt2$,
$$\frac{2-\sqrt2}{\sqrt2-\sqrt{3/2}}=\frac{0.5857864}{0.1894687}=3.0917 .$$
Both reproduce L13's printed $58.9$ and $3.09$. **So the block's claim that the two blocks turn on one number is exactly true**, and the number is $\theta_0(12)-\sqrt{3/2}=0.0112882$. This is the one cross-reference in the block that survives checking intact, and (the record's own point), neither block names the other.

## 10. The named trap, each citable claim read alone, as a consumer would

This record's signature failure is a correction landing *beside* the statement it corrects. I read each citable sentence with the banner covered.

| Read alone | What a consumer gets |
|---|---|
| *"The Bianchi correction is a PSD Gram form … with universal constant $\tfrac32$"* | correct, and unusable: without the trace step ($\tfrac32\cdot4=6$) and the doubling ($\mathrm{Alt}(\lvert W\rvert)=2\mathrm{Alt}(W_-)$) the reader cannot get from $\tfrac32$ to $24$, and neither step is in the block |
| *"so it costs at most $24\delta^2\lambda_{\max}$"* | a true bound on $J_4$, cited as the chain's cost; §3 shows the chain pays $\tfrac32$ of it at Fox |
| *"The answer is one exactly-priced term"* | a count contradicted by the file holding the argument |
| *"every critical point clearing the threshold has either …"* | an unquantified dimension range and a constant that exists only at $n=12$ |
| *"computed at $n=12$ to be about $1.0\times10^{-3}$"* | the output of the one input [LEDGER.md](../findings/LEDGER.md) marks *never audited*, presented with no marker |
| *"scalar curvature at least $(n+1)\tilde\theta_0(n)$"* | a symbol with no definition in the record; the reader must find Jäger's thesis to evaluate the claim |
| *(banner)* *"$\hat\theta_0$ is a third variant of the same thing"* | a false identification, off by $\tfrac{n-2}{n-3}$, standing next to the statement it purports to repair |
| *(Lean row)* *"$\tilde\theta_0(n)$ is $\Theta_n$"*, marked **proved** | true at odd $n$, false at $n=12$; the Lean file proves neither direction |
| *(Lean row)* *"netting $208/5$, a factor $26/15$ above the block's $24$"* | a comparison between coefficients of different degree, one of them dimension-specific |

**The trap has sprung twice here, and in the newer direction:** the two defects a citing reader is most likely to inherit are now in the *corrections*, not in the block, and one of them carries a Lean **proved** stamp.

## 11. The gap between what is proven and what is used

**Proven, and citable as such:**

- $D(R)\succeq0$ with $D(R)=\tfrac32\,\mathrm{Gram}(\mathrm{Alt}\,R)$ for every symmetric $R$ on $\Lambda^2\mathbb R^n$, every $n$, [REVIEW_r9.md](../reviews/REVIEW_r9.md) §2, three-step index proof.
- $\operatorname{tr}D(R)=6\lVert\mathrm{Alt}\,R\rVert^2$, as its trace.
- $J_4\le24\,\delta^2\,\lambda_{\max}(\mathrm{Ric}(\lvert W\rvert))$ for every Weyl $W$, pointwise, dimension-free, **no criticality**, equality iff $\mathrm{Ric}$ is $\lambda_{\max}$ on $\operatorname{ran}D$, which holds at the competitor.
- The compressions and $X_{\mathrm{cross}}=4C_{\mathrm{cross}}$ at a critical point, from $W^\#=\theta W-W^2$.
- $J_5=J_5^{\mathrm{diag}}\ge0$ on $\{[H,W]=0\}$, which contains every named critical point.
- §3.4 lifts with no Bianchi hypothesis: the lifted Lemmas 3.4.6, 3.4.3 and 3.4.8 are proven ([ATTEMPTS.md](../ATTEMPTS.md) Result 8).
- The width $0.0112882=\theta_0(12)-\sqrt{3/2}$, and its identity with L13's denominator (§9).

**Used but not proven:** $J_5\ge0$ off the commuting class; the E-track certificate; Lemma 3.4.7's frame-free assembly; Lemma 3.5.6 at $n=12$; the substitution of $\tilde\theta_0$ for $\theta_0$ in Assumption 1; the positivity of the cosine $\sqrt{1-e^2}$; and the master identity's own status, which [ATTEMPTS.md](../ATTEMPTS.md) presents as *"verified at machine precision"* while a four-line hand proof for it exists at [REVIEW_r9.md](../reviews/REVIEW_r9.md) §1 that the block does not cite.

**What a consumer may cite today.** The pricing bound of §2, in the form *"for every Weyl operator $W$, $J_4\le24\lVert\mathrm{Alt}(W_-)\rVert^2\lambda_{\max}(\mathrm{Ric}(\lvert W\rvert))$, with equality at the $\mathbb{CP}^2$-type competitor"*, unconditional, pointwise, every $n$. **Nothing else.** In particular the dichotomy may be cited only as *"at every critical point with $\theta\ge\tilde\theta_0(n)$, granting (i) $J_5\ge0$ off the commuting class, (ii) the E-track certificate, (iii) the frame-free Lemma 3.4.7 assembly and (iv) Lemma 3.5.6 at the dimension in question, either $\operatorname{scal}(\lvert W\rvert)\ge(n+1)\tilde\theta_0(n)$ or $\delta^2\ge c(n)$, with $c(12)=1.0008\times10^{-3}$ the only value on the record"*, and the cost it consumes is $(J_4-J_5)/\sqrt{1-e^2}$, not $J_4$.

## 12. What would falsify the statements above, and what I did to look for it

- **Against the pricing bound (§2):** a symmetric $R$ with $\langle D(R),\mathrm{Ric}\rangle>\lambda_{\max}(\mathrm{Ric})\operatorname{tr}D(R)$, or a Weyl $W$ with $\lVert\mathrm{Alt}(\lvert W\rvert)\rVert^2\ne4\delta^2$. The first cannot exist while $D\succeq0$, which the Gram form gives with no hypothesis; the second would need $\mathrm{Alt}(W)\ne0$, i.e. a non-Bianchi "Weyl" operator. I looked for a convention under which the doubling fails and found only the pair-basis-versus-plain-Frobenius factor of §0, which cancels between the $\tfrac32$ and the $6$.
- **Against the level finding (§3):** a critical point with $e=0$, at which numerator and quotient coincide. The record's one closed-form evaluation, at the competitor, gives $\sqrt{1-e^2}=2/3$; I searched [ATTEMPTS.md](../ATTEMPTS.md) and [findings/](../findings/) for any recorded $e=0$ point and found none. A point with $e=0$ everywhere on the critical set would reduce the finding to a notational one; it would not repair the block, which states the bound generally.
- **Against the threshold finding (§4):** a definition of $\tilde\theta_0$ in the record that differs from Jäger's, or an even $n$ at which $\theta_0=\tilde\theta_0$. I greped every markdown file in the repository for the symbol; it occurs at [ATTEMPTS.md](../ATTEMPTS.md) 612, 631, 801, 892, 908, in the block, and in reviews, never with a definition. The equality $\theta_0=\tilde\theta_0$ needs $8(n-1)=0$, so it fails at every $n\ge2$.
- **Against the $208/5$ finding (§8):** an inequality on the record of the form $(\text{penalty})\le\tfrac{208}5\,\delta^2\,(\cdot)$, which would make the netting a real constant. I searched [ATTEMPTS.md](../ATTEMPTS.md), [findings/](../findings/) and [L18.lean](../lean/HamiltonsCubic/Results/L18.lean); the only place $208/5$ occurs is the arithmetic identity `24 + 24 - 32/5 = 208/5` and the prose quoting it.

## 13. Verdict

**HYPOTHESIS-DEBT.**

The block is two statements of different status welded into one paragraph, and only one of them is a lemma.

- **The pricing half is proven and its constant is right.** $J_4\le24\delta^2\lambda_{\max}(\mathrm{Ric}(\lvert W\rvert))$ holds pointwise, in every dimension, for every Weyl operator, with no criticality, the hypothesis correction being that it needs $\mathrm{Alt}(W)=0$, which the block never states, and does *not* need the criticality its surrounding sentences supply.
- **The dichotomy half owes four things**, and naming them is the whole of what this verdict asks: (i) $J_5\ge0$ at critical points off $\{[H,W]=0\}$; (ii) an audit of the E-track certificate, which produces the headline $c(12)$ and which the record itself marks never audited; (iii) a proof, not a spot-check, of the frame-free Lemma 3.4.7 assembly; (iv) an audit of the record's own extension of Jäger's Lemma 3.5.6 below $n=16$, without which the dichotomy has no dimension at which its constant has been computed.
- **Two further debts are matters of statement rather than mathematics:** the cost must be restated at the level the chain consumes, $(J_4-J_5)/\sqrt{1-e^2}$; and $\tilde\theta_0(n)$ must be registered in [conventions.md](../findings/conventions.md) from Jäger's definition, **as itself**, since folding it into $\Theta_n$ is correct at odd $n$ and false at $n=12$, and folding $\hat\theta_0$ into either is false at every $n$.

**The pricing half may be cited today; the dichotomy may be cited only with its four grants attached; and the corrections at [problem.md](../findings/problem.md):303 and [lean/INDEX.md](../lean/INDEX.md):207 should be corrected before they are cited at all.**
