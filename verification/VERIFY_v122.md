# VERIFY v122, Observation L15: the identity $\operatorname{scal}(R^2+R^\#)=\lVert\mathrm{Ric}(R)\rVert^2+6\lVert\mathrm{Alt}(R)\rVert^2$, its constant $6$, its "$+24\lVert\mathrm{Alt}(W_-)\rVert^2$" consequence, and the two obstructions its heading claims

**Cold brief.** Verifier v122, round L15, dispatched from [ROUND_L15.md](ROUND_L15.md), against [findings/problem.md](../findings/problem.md):190–204 and the canonical form at [results.md](../results.md):643–647. **No numerical work was done. No script was run. Every value below is an exact hand evaluation**, and each is displayed with the arithmetic that produces it. Log: [agent_logs/verify-L15-v122.log](../agent_logs/verify-L15-v122.log).

## Claim table

| # | claim, as written at the citable site | verdict |
| --- | --- | --- |
| C1 | $\operatorname{scal}(R^2+R^\#)=\lVert\mathrm{Ric}(R)\rVert^2+6\lVert\mathrm{Alt}(R)\rVert^2$ | **TRUE**, for every symmetric $R$ on $\Lambda^2\mathbb R^n$, in the record's conventions, derived in §2, checked at five objects in §4 |
| C2 | "$\mathrm{Alt}$ being the projection onto $\Lambda^4$" | **TRUE**, and it is the orthogonal projection inside $S^2(\Lambda^2)$, which the site does not say |
| C3 | "with the constant exactly $6$ in every dimension" | **TRUE for $n\ge4$; VACUOUS for $n\le3$**, where $\Lambda^4=0$ and no constant is pinned. The dimension-freeness rests on $c_4=2$, whose proof is [L79](../findings/isotropy-cap.md)'s Casimir computation, two files away |
| C4 | "and no cross-term" | **TRUE but under-stated.** The identity carries a fourth coefficient the phrase does not mention: the $\mathrm{Weyl}$ coefficient is $0$, which is $\operatorname{tr}W^\#=-\lVert W\rVert^2$ |
| C5 | the quantifier on $R$ | **MISSING AT BOTH CITABLE SITES.** [ATTEMPTS.md](../ATTEMPTS.md):621 carries *"for every symmetric $R$ on $\Lambda^2\mathbb R^n$"*; [problem.md](../findings/problem.md):203 and [results.md](../results.md):647 carry neither it nor any other. Under the only class either file defines, the identity is **vacuous** |
| C6 | "So the invariant master inequality carries an extra $+24\lVert\mathrm{Alt}(W_-)\rVert^2$" | **TRUE**, and the "So" is false: $24=6\cdot4$ needs $\mathrm{Alt}(\lvert W\rvert)=2\,\mathrm{Alt}(W_-)$, which appears only in [isotropy-cap.md](../findings/isotropy-cap.md). Neither is "the invariant master inequality" named at the site |
| C7 | "at Fox's $\mathcal S^4(\alpha)$ … his inequality fail[s], by a factor of three at a genuine critical point, while the corrected version is saturated there" | **TRUE, and exactly three.** Hand-evaluated in §4.5: $4$ against $4/3$, with defect $8/3$ and slack exactly $0$ |
| C8 | "Every sphere product, in any frame, has defect zero" | **TRUE**; the argument is in the cited [r469](../reviews/REVIEW_r469.md)/[r470](../reviews/REVIEW_r470.md), not in the block |
| C9 | the heading's "TWO OBSTRUCTIONS, NOT ONE" | **the displayed identity bears on ONE of them.** The second, $X_{\mathrm{inv}}\succeq0$, is established **nowhere** as a positive statement; it is recorded as refuted off the diagonal locus, with only its trace and its equality locus proven |
| C10 | "[L15] is [Lemma L131](../findings/isotropy-cap.md) polarised" | **TRUE as an equivalence, loose as a word.** The two are interconvertible, but the conversion consumes two facts neither block displays: full symmetry of Böhm–Wilking's $\mathrm{tri}$, and $\mathrm{Ric}^*=2(\,\cdot\wedge\mathrm{id})$ |

**One line.** The identity is right, the constant $6$ is right, the "$+24$" is right and the factor of three at $\mathcal S^4(\alpha)$ is exactly three, and both sites that a consumer would cite have lost the quantifier that makes the $\mathrm{Alt}$ term non-zero, so the display as it stands on the record is a true statement about a class neither file names.

**Verdict: `PROVEN, hypotheses corrected`.**

## 0. Conventions, fixed once

Every one of these is quoted from [conventions.md](../findings/conventions.md) or from a source read in [references/](../references/). Nothing here is restated from memory.

| object | the record's fixing | where |
| --- | --- | --- |
| $\Lambda^2$ inner product | $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ at the $\Lambda^2$ level, so $\{\varphi_{ab}\}_{a<b}$ is orthonormal and $\operatorname{tr}(v^2)=-2$ for a unit bivector | [conventions.md](../findings/conventions.md), "Norms and pairings" |
| operator inner product | plain Frobenius on the pair matrix: $\langle X,Y\rangle=\operatorname{tr}(XY)$ for symmetric $X,Y$, so $\langle X,\mathrm{Id}\rangle=\operatorname{tr}X$ | same bullet |
| $\operatorname{scal}$ | $\operatorname{scal}=2\operatorname{tr}$ on $\Lambda^2$ | same file, and flagged there as *"the convention that makes the two halves of [Lemma L7](../findings/bounds.md)'s proof meet"* |
| $\mathrm{Ric}$ | $\mathrm{Ric}(R)_{ac}=\sum_bR_{abcb}$, with $\lVert\mathrm{Ric}\rVert^2$ the full $n\times n$ Frobenius norm | [r469](../reviews/REVIEW_r469.md) F1; consistent with $\operatorname{scal}=2\operatorname{tr}$ because $\sum_a\mathrm{Ric}_{aa}=\sum_{a,b}R_{abab}=2\operatorname{tr}R$ |
| $\mathrm{Alt}$ | the **orthogonal** projection of $S^2(\Lambda^2)$ onto $\Lambda^4$, carrying its $\tfrac13$: $\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$; self-adjoint, idempotent, annihilating every first-Bianchi tensor | [conventions.md](../findings/conventions.md), "Structure constants, brackets and padding" |
| $\star$ at $n=4$ | $\star=\Pi_{SD}-\Pi_{ASD}$ spans $\Lambda^4\subset S^2(\Lambda^2\mathbb R^4)$, with $\lVert\star\rVert^2=6$ | same bullet |
| $\#$ | Böhm–Wilking's, $\langle(R\#S)h,h\rangle=\tfrac12\sum_{\alpha\beta}\langle[R b_\alpha,S b_\beta],h\rangle\langle[b_\alpha,b_\beta],h\rangle$, normalised so that $I\#I=(n-2)I$ | [boehm-wilking-2008-space-forms/notes.md](../references/boehm-wilking-2008-space-forms/notes.md), eq. (4) and Lemma 2.1 |
| $\mathrm{tri}$ | $\mathrm{tri}(R_1,R_2,R_3)=\operatorname{tr}\big((R_1R_2+R_2R_1+2R_1\#R_2)R_3\big)$, **fully symmetric** | [boehm-wilking-2008-space-forms/notes.md](../references/boehm-wilking-2008-space-forms/notes.md), eq. (5) |
| $W_-$ | $W_-:=\tfrac12(\lvert W\rvert-W)\succeq0$, so $W=W_+-W_-$ and $\lvert W\rvert=W+2W_-$ | [conventions.md](../findings/conventions.md) |
| $\delta^2$ | $\lVert\mathrm{Alt}(W_-)\rVert^2$ | [results.md](../results.md):655, Conjecture L16 |

**Two orthogonal-basis facts I use and where they come from.** $\varphi_{ab}=E_{ab}-E_{ba}$ gives $[\varphi_{ab},\varphi_{bc}]=\varphi_{ac}$, computed from $E_{ij}E_{kl}=\delta_{jk}E_{il}$; and $c_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$ is **totally antisymmetric** ([conventions.md](../findings/conventions.md)).

**A normalisation the record does not table and the identity is rigid in.** The record's $\#$ is fixed by $I\#I=(n-2)I$. The raw structure-constant expression $\sum_{\gamma\delta\varepsilon\zeta}c_{\alpha\gamma\delta}c_{\beta\varepsilon\zeta}R_{\gamma\varepsilon}S_{\delta\zeta}$ **without** the $\tfrac12$ gives $I\#I=2(n-2)I$, and under it the identity is not merely rescaled but **false**: at $R=\mathrm{Id}$ the left side would be $2\binom n2(1+2(n-2))=2\binom n2(2n-3)$ against $\lVert\mathrm{Ric}\rVert^2=2\binom n2(n-1)$, and $2n-3=n-1$ only at $n=2$. So the display silently pins one normalisation of $\#$ out of two that are both in circulation, and pins it exactly rather than up to a constant.

## 1. Hypothesis inventory

### 1a. What the claim itself carries

| hypothesis | stated at [problem.md](../findings/problem.md):203? | stated at [results.md](../results.md):647? | used by the argument? |
| --- | --- | --- | --- |
| $R$ is a **symmetric operator on $\Lambda^2\mathbb R^n$**, the whole of $S^2(\Lambda^2)$, Bianchi part **and** $\Lambda^4$ part | **no** | **no** | **yes, essentially.** It is the entire content: on the Bianchi subspace $\mathrm{Alt}\equiv0$ and the $6$ is unpinned |
| $R\in\mathcal W_n$ (Weyl) | no | no | **no**, and it would make the display read $0=0$ |
| $R$ a curvature operator (first Bianchi) | no | no | **no**, and it would make the $\mathrm{Alt}$ term vanish identically |
| $R$ a **curvature operator** at all, in the geometric sense | no | no | **no.** $R^\#$, $\mathrm{Ric}$, $\operatorname{scal}$ and $\mathrm{Alt}$ are all defined on $S^2(\Lambda^2)$ |
| criticality, $Q(R)=\theta R$ | no | no | **no** |
| unit norm | no | no | **no**, both sides are homogeneous of degree $2$ |
| a dimension floor | "in every dimension" | absent | **$n\ge4$ for the $6$ to be pinned**; the identity is true and vacuous in the $\mathrm{Alt}$ term at $n\le3$ |

**The answer to the brief's question.** The identity needs **no** curvature-operator hypothesis and **no** Weyl hypothesis. It needs $R$ symmetric on $\Lambda^2$, and it needs that class to be the *full* $S^2(\Lambda^2)$ for the $6$ to say anything. Symmetry itself is used only through $\mathrm{tri}$'s full symmetry, which is stated on $S^2(\mathfrak{so}(n))$.

### 1b. What the argument imports, and each import checked against the object it is applied to

| import | source, read | hypotheses of the import | met by the object here? |
| --- | --- | --- | --- |
| $\mathrm{Ric}(R)\wedge\mathrm{id}=R+R\#I-3\,\mathrm{Alt}(R)$ | [Lemma L131](../findings/isotropy-cap.md):413 | "for every symmetric $R$", stated | **yes** |
| $\mathrm{tri}$ fully symmetric, giving $\langle R\#R,I\rangle=\langle R\#I,R\rangle$ | [Böhm–Wilking notes](../references/boehm-wilking-2008-space-forms/notes.md), eq. (5) | $R_i\in S^2(\mathfrak{so}(n))$ | **yes**; and §2a re-derives the special case from total antisymmetry of $c$ alone |
| $\mathrm{Ric}^*=2(\,\cdot\wedge\mathrm{id})$, i.e. $\langle A\wedge\mathrm{id},R\rangle=\tfrac12\langle A,\mathrm{Ric}(R)\rangle$ | [L131](../findings/isotropy-cap.md):416, "two conventions to carry" | none stated | **yes**; §4.1 pins it independently at $R=\mathrm{Id}$ |
| $\mathrm{Alt}$ self-adjoint idempotent | [conventions.md](../findings/conventions.md) | none | **yes** |
| $\#I$ acts as $+2$ on $\Lambda^4$ at every $n$ ($c_4=2$) | [Lemma L79](../findings/isotropy-cap.md):270, via $\mathcal A=\tfrac12\mathrm{Cas}-2(m-2)\mathrm{Id}$ and the Casimir at highest weight $[1^4]$; $m\ge3$ | $O(m)$-equivariance, Schur, multiplicity-one summands | **yes**, and §4.2 confirms it by hand at $n=4$ and §4.3 extends the same evaluation to every $n\ge4$ |
| $I\#I=(n-2)I$ | [Böhm–Wilking notes](../references/boehm-wilking-2008-space-forms/notes.md), Lemma 2.1 read there | $R\in S^2_B$; $I\in S^2_B$ | **yes** |

**Two chains that are not on the citable page.** The dimension-freeness of $6$ runs [problem.md](../findings/problem.md):203 → [L131](../findings/isotropy-cap.md)(i) → [L79](../findings/isotropy-cap.md) → the Casimir; the "$+24$" runs [problem.md](../findings/problem.md):204 → [L131](../findings/isotropy-cap.md)'s "two conventions to carry". Both leave [problem.md](../findings/problem.md) at the first step and neither is signposted from it.

**No finding: an unread source.** Every source the argument leans on is in [references/](../references/) and was read in this round, Böhm–Wilking's §2 and Lemma 2.1 in [notes.md](../references/boehm-wilking-2008-space-forms/notes.md), and Jäger in [jaeger-2016-diagonal-case/notes.md](../references/jaeger-2016-diagonal-case/notes.md). **One caveat on the second:** the block's Jäger claims, that his opening step rests on a Bianchi-dependent identity, that it is his eq. (1.6), and that his Lemma 3.2.2 has exactly two inputs, are **not** in that notes file, which stops at §3.1 material and a stub heading *"§§3.2–3.6, lifted off the diagonal locus"*. Those claims rest on [ATTEMPTS.md](../ATTEMPTS.md)'s reading of the primary text, which the block does point to; they are outside what I can check from [references/](../references/) and I record them as unchecked rather than as either confirmed or refuted.

## 2. The derivation, in full

### 2a. One step that needs only total antisymmetry of $c$

**Claim.** $\langle R\#R,\,I\rangle=\langle R\#I,\,R\rangle$.

Write $(R\#S)_{\alpha\beta}=\tfrac12\sum_{\gamma\delta\varepsilon\zeta}c_{\alpha\gamma\delta}c_{\beta\varepsilon\zeta}R_{\gamma\varepsilon}S_{\delta\zeta}$, the normalisation fixed in §0. Then

$$\langle R\#R,I\rangle=\tfrac12\sum_{\alpha\gamma\delta\varepsilon\zeta}c_{\alpha\gamma\delta}c_{\alpha\varepsilon\zeta}R_{\gamma\varepsilon}R_{\delta\zeta},\qquad\langle R\#I,R\rangle=\tfrac12\sum_{\alpha\beta\gamma\delta\varepsilon}R_{\alpha\beta}c_{\alpha\gamma\delta}c_{\beta\varepsilon\delta}R_{\gamma\varepsilon}.$$

In the second, rename $\delta\to\alpha'$, $\alpha\to\delta'$, $\beta\to\zeta'$: it becomes $\tfrac12\sum c_{\delta'\gamma\alpha'}c_{\zeta'\varepsilon\alpha'}R_{\delta'\zeta'}R_{\gamma\varepsilon}$. Total antisymmetry makes $c$ cyclically invariant, so $c_{\delta\gamma\alpha}=c_{\alpha\delta\gamma}$ and $c_{\zeta\varepsilon\alpha}=c_{\alpha\zeta\varepsilon}$, giving $\tfrac12\sum_\alpha c_{\alpha\delta\gamma}c_{\alpha\zeta\varepsilon}R_{\delta\zeta}R_{\gamma\varepsilon}$, which is the first expression after swapping the names $\gamma\leftrightarrow\delta$ and $\varepsilon\leftrightarrow\zeta$. $\square$

This is the $T=I$ case of the full symmetry of Böhm–Wilking's $\mathrm{tri}$, and it is the only case the derivation needs. Recording it separately matters because it is the one bridge between L131 and L15 that appears **nowhere** on the record: [conventions.md](../findings/conventions.md) tables total antisymmetry of $c$ but never this consequence, and neither L15's nor L131's block names it.

### 2b. The identity

Let $R$ be **any** symmetric operator on $\Lambda^2\mathbb R^n$. Then

$$\operatorname{scal}(R^2+R^\#)=2\operatorname{tr}(R^2)+2\operatorname{tr}(R^\#)=2\lVert R\rVert^2+2\langle R\#R,I\rangle=2\lVert R\rVert^2+2\langle R\#I,R\rangle,$$

the last step by §2a. [Lemma L131](../findings/isotropy-cap.md):413 rearranges to $R\#I=\mathrm{Ric}(R)\wedge\mathrm{id}-R+3\,\mathrm{Alt}(R)$, so

$$\langle R\#I,R\rangle=\langle\mathrm{Ric}(R)\wedge\mathrm{id},R\rangle-\lVert R\rVert^2+3\langle\mathrm{Alt}(R),R\rangle=\tfrac12\lVert\mathrm{Ric}(R)\rVert^2-\lVert R\rVert^2+3\lVert\mathrm{Alt}(R)\rVert^2,$$

using $\mathrm{Ric}^*=2(\,\cdot\wedge\mathrm{id})$ on the first term and self-adjoint idempotence of $\mathrm{Alt}$ on the third. Substituting,

$$\operatorname{scal}(R^2+R^\#)=2\lVert R\rVert^2+\lVert\mathrm{Ric}(R)\rVert^2-2\lVert R\rVert^2+6\lVert\mathrm{Alt}(R)\rVert^2=\lVert\mathrm{Ric}(R)\rVert^2+6\lVert\mathrm{Alt}(R)\rVert^2.\qquad\square$$

**Where each convention enters, and what the constant becomes without it.**

| convention | where it enters | drop it and |
| --- | --- | --- |
| $\operatorname{scal}=2\operatorname{tr}$ | the first equality | with $\operatorname{scal}=\operatorname{tr}$ the display reads $\operatorname{tr}(R^2+R^\#)=\tfrac12\lVert\mathrm{Ric}\rVert^2+3\lVert\mathrm{Alt}\rVert^2$: **the $6$ survives only as the ratio** of the two right-hand coefficients |
| $\#$ with $I\#I=(n-2)I$ | §2a and L131 | under the doubled $\#$ the identity is **false**, not rescaled (§0) |
| $\mathrm{Ric}^*=2(\,\cdot\wedge\mathrm{id})$ and $\lVert\mathrm{Ric}\rVert$ the $n\times n$ Frobenius norm | the $\tfrac12$ in $\langle\mathrm{Ric}\wedge\mathrm{id},R\rangle$ | halving $\mathrm{Ric}$ quarters its term and the $6$ would have to become $24$ relative to it |
| the operator pairing on $\lVert\mathrm{Alt}(R)\rVert^2$, plain Frobenius on the **pair matrix** | the third term | measured in the $4$-index tensor pairing $\sum_{ijkl}$, which is $4\times$ the pair pairing, the constant becomes $\tfrac64=\tfrac32$ |
| $\mathrm{Alt}$ carrying its $\tfrac13$, so it is a **projection** rather than a symmetriser | $\langle\mathrm{Alt}R,R\rangle=\lVert\mathrm{Alt}R\rVert^2$ | without idempotence there is no such collapse and the right-hand side is not a norm at all |

So the $6$ is a statement about **three** relative normalisations at once, and the two citable sites name none of them. This is C3's real content: "exactly $6$ in every dimension" is dimension-free but not convention-free, and only the first half is said.

### 2c. The fourth coefficient, which "no cross-term" does not mention

$S^2(\Lambda^2\mathbb R^n)=\mathbb R\cdot I\oplus S^2_0\oplus\mathrm{Weyl}_n\oplus\Lambda^4$ is multiplicity-free under $O(n)$, so an $O(n)$-invariant quadratic form on it is diagonal in that splitting, which is [r469](../reviews/REVIEW_r469.md)'s Schur argument for "no cross-term", and it is correct. But a diagonal form has **four** coefficients, and the display pins all four: $\lVert\mathrm{Ric}(R)\rVert^2$ carries the $\mathbb R\cdot I$ and $S^2_0$ ones, $6$ carries $\Lambda^4$, and the $\mathrm{Weyl}$ coefficient is **zero**. That last is the record's $\operatorname{tr}W^\#=-\lVert W\rVert^2$, since $R=W$ gives $0=\operatorname{scal}(W^2+W^\#)=2\lVert W\rVert^2+2\operatorname{tr}W^\#$. It is a live consequence of the display and the phrase "no cross-term" does not reach it.

*Checked at the $\mathbb{CP}^2$-type competitor.* With $W=(2,-1,-1)/\sqrt6$ on $\Lambda^2_+$ and $c_{123}=-\sqrt2$ there (§4.2), $(W^\#)_{\alpha\alpha}=2r_\beta r_\gamma$, so $\operatorname{tr}W^\#=2(r_1r_2+r_1r_3+r_2r_3)=2\cdot\tfrac{-2-2+1}6=-1=-\lVert W\rVert^2$. Exact.

## 3. Quantifier order, scope, and the edges of the range

**Quantifier order.** The intended reading is *for every $n$, for every symmetric $R$ on $\Lambda^2\mathbb R^n$, the identity holds with the same constant $6$*, the constant quantified **outside** $n$. That order is the whole of "in every dimension", and it is what §4.3 confirms. Neither citable site writes any quantifier at all; the order has to be read off the word "every".

**Scope of $R$.** See C5 and §1a: absent at both sites. This is not pedantry, it is the difference between a statement with content and $0=0$.

**$n\ge5$.** $\Lambda^4\mathbb R^n$ has dimension $\binom n4$ and is an irreducible $O(n)$-summand of $S^2(\Lambda^2)$ of multiplicity one; the Schur argument and the identity run unchanged.

**$n=4$, where $\Lambda^4$ is one-dimensional.** This is the one place the Schur argument needs care, and the record does not flag it. Under $SO(4)$, $\Lambda^4\mathbb R^4\cong\mathbb R$ is the **trivial** representation (the same as $\mathbb R\cdot I$) so an $SO(4)$-invariant quadratic form on $S^2(\Lambda^2\mathbb R^4)$ **may** carry a cross-term between $I$ and $\star$, and "no cross-term" would not follow from Schur. It survives because both sides of the identity are invariant under the full $O(4)$, under which $\Lambda^4$ is the determinant representation and is not trivial. §4.4 checks the conclusion directly at $R=\mathrm{Id}+t\star$ rather than relying on the group-theoretic reading.

**$n\le3$.** $\Lambda^4\mathbb R^n=0$, $\mathrm{Alt}\equiv0$, and the identity reduces to $\operatorname{scal}(R^2+R^\#)=\lVert\mathrm{Ric}(R)\rVert^2$, true (checked at $n=3$ in §4.6), but **the constant $6$ is unpinned there**: any constant closes a vanishing term. So "exactly $6$ in every dimension" is true and vacuous below $n=4$, and the phrase should carry $n\ge4$ for the "exactly" to mean anything. [L79](../findings/isotropy-cap.md), whose Casimir computation supplies $c_4$, states its own range as $m\ge3$, where $\binom34=0$ makes the $\Lambda^4$ row empty, consistent, and the same vacuity.

## 4. The identity at named objects, by hand

### 4.1 $R=\mathrm{Id}$, the Kulkarni–Nomizu identity operator

$\mathrm{Id}_{abcd}=\delta_{ac}\delta_{bd}-\delta_{ad}\delta_{bc}$, which is $\tfrac12\,g\owedge g$ in the Kulkarni–Nomizu normalisation that makes $\delta\wedge\mathrm{id}=\mathrm{Id}$. Then $\mathrm{Ric}(\mathrm{Id})_{ac}=\sum_b(\delta_{ac}\delta_{bb}-\delta_{ab}\delta_{bc})=(n-1)\delta_{ac}$, so $\lVert\mathrm{Ric}\rVert^2=n(n-1)^2$. $\mathrm{Id}$ satisfies the first Bianchi identity, so $\mathrm{Alt}(\mathrm{Id})=0$.

$\mathrm{Id}^2=\mathrm{Id}$ and $\mathrm{Id}^\#=(n-2)\mathrm{Id}$, so $\mathrm{Id}^2+\mathrm{Id}^\#=(n-1)\mathrm{Id}$ and

$$\operatorname{scal}\big((n-1)\mathrm{Id}\big)=2(n-1)\binom n2=n(n-1)^2=\lVert\mathrm{Ric}(\mathrm{Id})\rVert^2+6\cdot0.\qquad\checkmark$$

**This anchor pins the Ricci coefficient at exactly $1$ and pins $\mathrm{Ric}^*=2(\,\cdot\wedge\mathrm{id})$**, since $2\langle\mathrm{Ric}(\mathrm{Id})\wedge\mathrm{id},\mathrm{Id}\rangle=2(n-1)\binom n2=n(n-1)^2=\lVert\mathrm{Ric}(\mathrm{Id})\rVert^2$. It says nothing about the $6$.

### 4.2 $R=\star$ at $n=4$, and $c_4=2$ rebuilt from brackets

$\mathrm{Ric}(\star)=0$ and $\mathrm{Alt}(\star)=\star$ with $\lVert\star\rVert^2=6$, so the right side is $36$.

For the left side I need $\star\#I$, and I derive it rather than import it. In the basis $(\varphi_{12},\varphi_{13},\varphi_{14},\varphi_{23},\varphi_{24},\varphi_{34})$, $[\varphi_{ab},\varphi_{bc}]=\varphi_{ac}$ gives

$$A:=\mathrm{ad}(\varphi_{12}):\ \varphi_{13}\mapsto-\varphi_{23},\ \varphi_{23}\mapsto\varphi_{13},\ \varphi_{14}\mapsto-\varphi_{24},\ \varphi_{24}\mapsto\varphi_{14},\ \varphi_{12},\varphi_{34}\mapsto0,$$
$$B:=\mathrm{ad}(\varphi_{34}):\ \varphi_{13}\mapsto-\varphi_{14},\ \varphi_{14}\mapsto\varphi_{13},\ \varphi_{23}\mapsto-\varphi_{24},\ \varphi_{24}\mapsto\varphi_{23},\ \varphi_{12},\varphi_{34}\mapsto0.$$

So $A^2=B^2=-P$ with $P$ the projection onto $\mathrm{span}\{\varphi_{13},\varphi_{14},\varphi_{23},\varphi_{24}\}$, and $\operatorname{tr}A^2=-4=(n-2)\operatorname{tr}(\varphi_{12}^2)=2\cdot(-2)$, matching the Killing normalisation of [conventions.md](../findings/conventions.md). Writing $C:=AB+BA$,

$$C\varphi_{13}=2\varphi_{24},\quad C\varphi_{24}=2\varphi_{13},\quad C\varphi_{14}=-2\varphi_{23},\quad C\varphi_{23}=-2\varphi_{14},\quad C\varphi_{12}=C\varphi_{34}=0.$$

With $\star\varphi_{12}=\varphi_{34}$, $\star\varphi_{13}=-\varphi_{24}$, $\star\varphi_{14}=\varphi_{23}$ (and symmetrically), $\star$ has zero diagonal, so $\operatorname{tr}(\star P)=0$, while $\operatorname{tr}(\star C)=(-1)(2)+(-1)(2)+(1)(-2)+(1)(-2)=-8$.

Take $h=\omega_1=(\varphi_{12}+\varphi_{34})/\sqrt2$, a unit self-dual bivector with $\langle\star\omega_1,\omega_1\rangle=1$. Then $\mathrm{ad}(\omega_1)^2=\tfrac12(A+B)^2=-P+\tfrac12C$, so

$$\langle(\star\#I)\omega_1,\omega_1\rangle=-\tfrac12\operatorname{tr}\big(\star\,\mathrm{ad}(\omega_1)^2\big)=-\tfrac12\big(0+\tfrac12(-8)\big)=2=2\langle\star\omega_1,\omega_1\rangle.$$

At $\bar\omega_1=(\varphi_{12}-\varphi_{34})/\sqrt2$, where $\star\bar\omega_1=-\bar\omega_1$: $\mathrm{ad}(\bar\omega_1)^2=-P-\tfrac12C$ and the same computation returns $-2=2\langle\star\bar\omega_1,\bar\omega_1\rangle$. So $\star\#I=2\star$, i.e. **$c_4=2$, rebuilt from the brackets and independent of [L79](../findings/isotropy-cap.md)'s Casimir route**.

Hence $\star^\#=2\,\mathrm{Id}$, because $\Pi_\pm^\#=2\Pi_\pm$ (below) and $\Pi_+\#\Pi_-=0$ because $[\Lambda^2_+,\Lambda^2_-]=0$, so $\star^\#=(\Pi_+-\Pi_-)^\#=\Pi_+^\#+\Pi_-^\#=2\,\mathrm{Id}$. For $\Pi_+^\#$: $[\omega_1,\omega_2]=-\sqrt2\,\omega_3$ (expand $\tfrac12\big([\varphi_{12},\varphi_{13}]+[\varphi_{12},-\varphi_{24}]+[\varphi_{34},\varphi_{13}]+[\varphi_{34},-\varphi_{24}]\big)=\tfrac12(-2\varphi_{23}-2\varphi_{14})=-\sqrt2\,\omega_3$), so $c_{123}=-\sqrt2$ and $(\Pi_+^\#)_{11}=\tfrac12(c_{123}^2+c_{132}^2)=2$.

$$\operatorname{scal}(\star^2+\star^\#)=\operatorname{scal}(3\,\mathrm{Id})=2\cdot3\cdot6=36=0+6\cdot6.\qquad\checkmark$$

**This anchor pins the $\mathrm{Alt}$ coefficient at exactly $6$, and it is the only one of the record's anchors that does.**

### 4.3 The same evaluation at every $n\ge4$, why $6$ is dimension-free

Let $\sigma\in\Lambda^4\mathbb R^n$ be the padded $\star$: the operator on $\Lambda^2\mathbb R^n$ supported on $\Lambda^2\mathbb R^4$ and equal there to $\star$. For $h\in\mathfrak{so}(4)$, $\mathrm{ad}(h)$ preserves $\mathfrak{so}(4)$ and preserves its complement in $\mathfrak{so}(n)$, so $\mathrm{ad}(h)^2$ preserves $\mathfrak{so}(4)$ and its $\mathfrak{so}(4)$-block is the $\mathfrak{so}(4)$-intrinsic one. Since $\sigma$ is supported on that block, $\operatorname{tr}_{\mathfrak{so}(n)}(\sigma\,\mathrm{ad}(\omega_1)^2)=-4$ exactly as at $n=4$, and $\langle(\sigma\#I)\omega_1,\omega_1\rangle=2=2\langle\sigma\omega_1,\omega_1\rangle$.

$R\mapsto R\#I$ is $O(n)$-equivariant, so it preserves the $\Lambda^4$ isotypic component, which is multiplicity-one; Schur makes $\#I$ a scalar $c_4(n)$ there, and the single evaluation above forces $c_4(n)=2$ at every $n\ge4$. Then $6=2(1+c_4)$ is dimension-free.

**Where this leaves the record.** The claim is true and the record's own warrant is [L79](../findings/isotropy-cap.md)'s Casimir computation ($\mathcal A=\tfrac12\mathrm{Cas}-2(m-2)\mathrm{Id}$, highest weight $[1^4]$ giving $-4$, hence $\#I=+2$), which is a genuine proof carrying two independent consistency checks and a Gate 2 at [r577](../reviews/REVIEW_r577.md)/[r578](../reviews/REVIEW_r578.md). I record the bracket route above because it is short and because **neither citable site cites either route**: [problem.md](../findings/problem.md):203 asserts "in every dimension" with the chain to L79 running through two files.

### 4.4 $R=\mathrm{Id}+t\star$ at $n=4$, the cross-term the Schur argument cannot see at that dimension

$R^2=(1+t^2)\mathrm{Id}+2t\star$ and $R^\#=\mathrm{Id}^\#+2t(\mathrm{Id}\#\star)+t^2\star^\#=2\,\mathrm{Id}+4t\star+2t^2\mathrm{Id}$, so

$$R^2+R^\#=(3+3t^2)\mathrm{Id}+6t\star,\qquad \operatorname{scal}=2\big(6(3+3t^2)+6t\cdot0\big)=36+36t^2,$$

using $\operatorname{tr}\star=0$. On the right, $\mathrm{Ric}(R)=3\delta$ and $\mathrm{Alt}(R)=t\star$, so $\lVert\mathrm{Ric}\rVert^2+6\lVert\mathrm{Alt}\rVert^2=36+6\cdot6t^2=36+36t^2$. $\checkmark$

The terms linear in $t$ cancel on the left ($\operatorname{tr}\star=0$) and are absent on the right. **So "no cross-term" holds at $n=4$ between the two summands that $SO(4)$ cannot tell apart**, checked without appeal to $O(4)$.

### 4.5 $\mathcal S^4(\alpha)$, the "factor of three", exactly

Take the padded $\mathbb{CP}^2$-type competitor: $W$ supported on $\Lambda^2_+\mathbb R^4$ with eigenvalues $r=(2,-1,-1)/\sqrt6$ in the $\omega$-basis, $\lVert W\rVert^2=\tfrac{4+1+1}6=1$.

*It is critical, and $\theta=\sqrt{3/2}$.* With $c_{123}=-\sqrt2$ (§4.2), $(W^\#)_{\alpha\alpha}=2r_\beta r_\gamma$, so $(W^2+W^\#)_{11}=\tfrac46+2\cdot\tfrac16=1$ and $(W^2+W^\#)_{22}=\tfrac16-\tfrac46=-\tfrac12$. Against $\theta r_1=\tfrac{2\theta}{\sqrt6}$ and $\theta r_2=-\tfrac\theta{\sqrt6}$ this gives $\theta=\tfrac{\sqrt6}2=\sqrt{3/2}$ from both rows.

*The defect is exactly $\tfrac19$.* $W_-=\tfrac1{\sqrt6}(\Pi_+-\omega_1\omega_1^{\mathsf T})$, so $\langle W_-,\star\rangle=\operatorname{tr}W_-=\tfrac2{\sqrt6}$ and $\mathrm{Alt}(W_-)=\tfrac{\langle W_-,\star\rangle}{\lVert\star\rVert^2}\star=\tfrac1{3\sqrt6}\star$, whence $\delta^2=\tfrac1{54}\cdot6=\tfrac19$. This is [conventions.md](../findings/conventions.md)'s $a=1/(3\sqrt6)$ and [Conjecture L16](../results.md)'s "defect exactly $1/9$".

*The four numbers in Jäger's Lemma 3.2.2.* $\lvert W\rvert$ has eigenvalues $s=(2,1,1)/\sqrt6$, so $\operatorname{scal}(\lvert W\rvert)=2\operatorname{tr}\lvert W\rvert=\tfrac8{\sqrt6}$ and

$$\theta\operatorname{scal}(\lvert W\rvert)=\sqrt{\tfrac32}\cdot\tfrac8{\sqrt6}=\tfrac{8\sqrt3}{\sqrt{12}}=4.$$

$\mathrm{Ric}(\Pi_+)=\tfrac12\mathrm{Ric}(\mathrm{Id}+\star)=\tfrac32\delta$ and $\mathrm{Ric}(\omega_1\omega_1^{\mathsf T})=\tfrac12\delta$ (each diagonal entry is $\sum_b\langle\omega_1,\varphi_{ab}\rangle^2=\tfrac12$, each off-diagonal entry zero), so $\mathrm{Ric}(W_-)=\tfrac1{\sqrt6}\delta$ and $\mathrm{Ric}(\lvert W\rvert)=2\,\mathrm{Ric}(W_-)=\tfrac2{\sqrt6}\delta$, giving $\lVert\mathrm{Ric}(\lvert W\rvert)\rVert^2=\tfrac46\cdot4=\tfrac83$. And $\lVert W_-\rVert^2=\tfrac26=\tfrac13$, so $4\lVert W_-\rVert^2=\tfrac43$; and $24\delta^2=\tfrac{24}9=\tfrac83$.

*Cross-check of $\lVert\mathrm{Ric}(\lvert W\rvert)\rVert^2$ by a second route.* Apply the identity to $R=\lvert W\rvert$: $\operatorname{tr}(\lvert W\rvert^2)=1$ and $\operatorname{tr}(\lvert W\rvert^\#)=2(s_1s_2+s_1s_3+s_2s_3)=2\cdot\tfrac{2+2+1}6=\tfrac53$, so $\operatorname{scal}(\lvert W\rvert^2+\lvert W\rvert^\#)=2(1+\tfrac53)=\tfrac{16}3$, against $\lVert\mathrm{Ric}(\lvert W\rvert)\rVert^2+6\lVert\mathrm{Alt}(\lvert W\rvert)\rVert^2=\tfrac83+6\cdot\tfrac49=\tfrac83+\tfrac83=\tfrac{16}3$. $\checkmark$

*The verdict on C7.* Jäger's Lemma 3.2.2, read verbatim from the primary text ([diss_jaeger_florian.txt](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf):2012), is $\theta_n\bar\lambda\le r^2-4\lVert W_-\rVert^2$. Here

$$\underbrace{4}_{\theta\operatorname{scal}(\lvert W\rvert)}\ \le\ \underbrace{\tfrac83-\tfrac43}_{=\,4/3}\ \textbf{ is false},\qquad \underbrace{4}_{\phantom{\theta}}\ \le\ \underbrace{\tfrac83-\tfrac43+\tfrac83}_{=\,4}\ \textbf{ holds with equality}.$$

$4/(4/3)=3$ **exactly**, at a point verified critical above. So "fail by a factor of three at a genuine critical point, while the corrected version is saturated there" is confirmed by exact hand evaluation. The record's own warrant for this sentence is a numerical evaluation at $n=6$ and $n=8$ ([ATTEMPTS.md](../ATTEMPTS.md):625); padding leaves every quantity above unchanged, so the $n=4$ evaluation covers those.

### 4.6 Two more objects

**A sphere product $S^p\times S^q$, $p+q=n$.** $R=I_p\oplus I_q$ with $I_p$ the identity on $\Lambda^2\mathbb R^p$ padded. Then $I_p\#I_q=0$, because $c_{\alpha\gamma\delta}=0$ whenever $\gamma\in\mathfrak{so}(p)$ and $\delta\in\mathfrak{so}(q)$ (disjoint index blocks commute) and $I_p\#I_p=(p-2)I_p$ by the same Killing computation as $I\#I=(n-2)I$ inside $\mathfrak{so}(p)$. So $R^2+R^\#=(p-1)I_p\oplus(q-1)I_q$ and

$$\operatorname{scal}=2\Big[(p-1)\binom p2+(q-1)\binom q2\Big]=p(p-1)^2+q(q-1)^2=\lVert\mathrm{Ric}(R)\rVert^2,$$

since $\mathrm{Ric}(R)=\mathrm{diag}\big((p-1)^{\times p},(q-1)^{\times q}\big)$; and $\mathrm{Alt}(R)=0$. $\checkmark$

**$n=3$, a rank-one object off every named family.** $R=\varphi_{23}\varphi_{23}^{\mathsf T}$ on $\Lambda^2\mathbb R^3$. Then $R^2=R$ with $\operatorname{tr}=1$, and $R^\#=0$ because $(R\#R)_{\alpha\beta}=\tfrac12c_{\alpha11}c_{\beta11}=0$ in the eigenbasis with $R=\mathrm{diag}(1,0,0)$. So $\operatorname{scal}(R^2+R^\#)=2$. And $\mathrm{Ric}(R)=\mathrm{diag}(0,1,1)$, so $\lVert\mathrm{Ric}\rVert^2=2$. $\checkmark$, the identity holds where $\mathrm{Alt}$ is identically zero, confirming §3's reading of the $n\le3$ edge.

**No finding: any object at which the identity fails.** Five objects across three dimensions, spanning all four $O(n)$-summands, agree exactly.

## 5. Pre-registered question 2, is the displayed content this result's own?

The record says it is not: [results.md](../results.md):218 carries *"The identity below is confirmed and is [Lemma L131](../findings/isotropy-cap.md) polarised"*, and [L131](../findings/isotropy-cap.md):414 carries the same relation from the other side.

**What is true.** The two are interconvertible, given §0's conventions.

- **L131 $\Rightarrow$ L15** is §2b: pair L131's operator identity against $R$, and convert three terms, $\langle R\#I,R\rangle\to\operatorname{tr}R^\#$ (§2a), $\langle\mathrm{Ric}(R)\wedge\mathrm{id},R\rangle\to\tfrac12\lVert\mathrm{Ric}(R)\rVert^2$ ($\mathrm{Ric}^*=2(\,\cdot\wedge\mathrm{id})$), $\langle\mathrm{Alt}R,R\rangle\to\lVert\mathrm{Alt}R\rVert^2$ (idempotence).
- **L15 $\Rightarrow$ L131** needs polarisation *and then* non-degeneracy: polarising the quadratic form gives $2\operatorname{tr}(RS)+\operatorname{scal}(R\#S)=\langle\mathrm{Ric}R,\mathrm{Ric}S\rangle+6\langle\mathrm{Alt}R,\mathrm{Alt}S\rangle$; both sides are linear in $S$, so the operators they represent under the (non-degenerate) Frobenius pairing agree, and the same three conversions run backwards.

**What is not.** "Polarised" names the first half of the second direction only. [lean/INDEX.md](../lean/INDEX.md):183 justifies the word with *"for any symmetric additive $B$, $B(X+Y,X+Y)-B(X,X)-B(Y,Y)=2B(X,Y)$"*, which is the quadratic-to-bilinear step, and **not** the bilinear-form-to-operator step, and not the two conversions. L131 is an operator identity; L15 is a scalar one; the word hides exactly the ingredients §2a and §2b spend their lines on. The equivalence is real; the label is a shorthand that a reader cannot expand from either block.

**What a consumer citing L15 gets that citing L131 would not.**

| | [L15](../findings/problem.md) | [L131](../findings/isotropy-cap.md) |
| --- | --- | --- |
| shape | scalar, quadratic in $R$, the shape [L7](../findings/bounds.md) consumes directly | operator-valued, linear in $R$ |
| quantifier on $R$ | **absent** | "for every symmetric $R$", present |
| the constant a consumer reads off | $6$ | $3$, as $1+c_4$ |
| the $\lvert W\rvert$-vs-$W_-$ warning | absent | present, and it is what the "$+24$" needs |
| $\mathrm{Ric}^*=2(\,\cdot\wedge\mathrm{id})$ | absent | present |
| the downstream reading ($+24\delta^2$, $\mathcal S^4(\alpha)$, sphere products) | present | absent |

So the displayed **mathematics** is L131's; what L15 adds is the shape in which L7 uses it and the three downstream evaluations. Reading the pair the other way: **L131 is the better citation for the identity and L15 the better one for its price**, and the two constants ($3$ and $6$) differ, which is a live opportunity to mis-quote across the pair.

## 6. Pre-registered question 3, what the identity establishes about the lifting obstruction

The heading claims **TWO OBSTRUCTIONS, NOT ONE**. The displayed identity bears on **one** of them.

| obstruction | what the display does for it | status on the record |
| --- | --- | --- |
| $\lvert W\rvert$ and $W_\pm$ leave the first-Bianchi subspace, so Jäger's eq. (1.6) is unavailable | **prices it exactly**: the correction is $+6\lVert\mathrm{Alt}\rVert^2$, i.e. $+24\delta^2$ at $\lvert W\rvert$ | **established**, §2b and §4 |
| $X_{\mathrm{inv}}\succeq0$ | **nothing** | **established nowhere as a positive statement** |

**On the first, the primary text confirms the record's reading, and I read it there.** [diss_jaeger_florian.txt](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf):474–479 states eq. (1.6) as $\operatorname{scal}(R^2+R^\#)=\sum_{i,j}(\mathrm{Ric}(R)_{ij})^2$ and its surrounding text quantifies it over $S^2_B(\mathfrak{so}(n))$, so the Bianchi-dependence is explicit in the source, not inferred. Lemma 3.2.2's proof (line 2021) opens *"As seen in equation (1.6) … for all operators $R\in S^2_B(\mathfrak{so}(n))$"* and applies it to $\lvert W\rvert$, which is exactly where L15's defect enters.

**On the second, tracing every place the record touches it:**

- [ATTEMPTS.md](../ATTEMPTS.md):618 records $X(W)\succeq0$ as **genuinely failing** off the diagonal locus, with a negative eigenvalue at an $n=6$ critical point, a numerical refutation, labelled as such there.
- [Lemma L7](../findings/bounds.md) is its **trace**, which survives; [lean/INDEX.md](../lean/INDEX.md):179 records that a trace statement does not strengthen into an operator one, so L7 cannot supply it.
- [Lemma L154](../findings/bounds.md) gives $\operatorname{tr}X_{\mathrm{inv}}=0\iff X_{\mathrm{inv}}=0$, and [Lemma L155](../findings/bounds.md) characterises that locus as the $\mathbb Z_2$-graded subalgebras. Both are statements about the **equality case**; neither establishes $X_{\mathrm{inv}}\succeq0$. [lean/INDEX.md](../lean/INDEX.md):190 records *"Owed: that $X_{\mathrm{inv}}$ is semidefinite at a critical point"*.

**So the answer is: here, nowhere, and elsewhere only in weakened forms.** The heading's "two" is correct as a count of obstructions; the block's displayed content covers the first, and the second is open in the direction the argument needs and refuted in the direction it was assumed.

## 7. The forms compared, and the Lean row

| site | what it displays | quantifier on $R$ | $\mathrm{Alt}$ defined? | conventions cited? | the "$6$ in every dimension" clause |
| --- | --- | --- | --- | --- | --- |
| [ATTEMPTS.md](../ATTEMPTS.md):621 | the identity | **"for every symmetric $R$ on $\Lambda^2\mathbb R^n$"** | yes, "orthogonal projection onto $\Lambda^4\subset S^2(\Lambda^2)$" | no | yes, with the Schur reason |
| [problem.md](../findings/problem.md):203 | the identity | **none** | "the projection onto $\Lambda^4$", orthogonality unstated | no | yes |
| [results.md](../results.md):647 | the identity | **none** | **not at all** | no | **dropped** |
| [results.md](../results.md):218 | no display; the label and the L131 identification | (|), |, |, |
| [isotropy-cap.md](../findings/isotropy-cap.md):413 | $\mathrm{Ric}(R)\wedge\mathrm{id}=R+R\#I-3\,\mathrm{Alt}(R)$ | **"for every symmetric $R$"** | by reference | $\mathrm{Ric}^*$ and the $\lvert W\rvert$/$W_-$ factor stated | the $3$ is $1+c_4$, $c_4=2$ from (i) |
| [isotropy-cap.md](../findings/isotropy-cap.md):414 | $\mathcal A(R)=2R-\mathrm{Ric}^*(\mathrm{Ric}\,R)-6\,\mathrm{Alt}(R)$ | inherited | (|), |, |
| [bounds.md](../findings/bounds.md), Lemma L7 | the polarised inequality at $(W_+,W_-)$ | at a critical Weyl $W$ |, | names $\operatorname{scal}=2\operatorname{tr}$ by reference | "the constant $6$ is L15's and is dimension-free" |

**The three operator forms are mutually consistent.** From L131, $R\#I=\mathrm{Ric}(R)\wedge\mathrm{id}-R+3\,\mathrm{Alt}(R)$; multiplying by $-2$ and using $\mathcal A=-2(\,\cdot\#I)$ and $\mathrm{Ric}^*=2(\,\cdot\wedge\mathrm{id})$ gives $\mathcal A(R)=2R-\mathrm{Ric}^*(\mathrm{Ric}\,R)-6\,\mathrm{Alt}(R)$ exactly, which is isotropy-cap.md's second display. No discrepancy between the three.

**[isotropy-cap.md](../findings/isotropy-cap.md):285 is a live warning that lands on this identity.** *"Under the half-trace of [conventions.md](../findings/conventions.md) the constants are as tabled; under plain Frobenius every one of them halves."* Every constant in §2b (the $6$ included), is stated in the half-trace pairing, and nothing at either citable site says so. §2b's table is the answer to the brief's "what it becomes under the alternatives".

**The Lean row.** [lean/INDEX.md](../lean/INDEX.md):183 carries L15 as **partial**, formalising *"polarisation carries no content"* and the two-obstructions correction, and recording explicitly: ***"Owed: the identity itself and its identification with L131."*** So the identity is **not** machine-checked, and the row says so. What a row claiming it would have to state, to be worth having:

- $R$ ranging over all symmetric endomorphisms of $\Lambda^2\mathbb R^n$, with $\#$ fixed by $I\#I=(n-2)I$, $\operatorname{scal}=2\operatorname{tr}$, $\mathrm{Alt}$ the orthogonal projection onto $\Lambda^4$ and $\lVert\cdot\rVert$ the pair-matrix Frobenius norm, **all four**, since §2b shows the statement is false or altered if any is changed;
- the conclusion at every $n$, with the $\Lambda^4$ term non-trivial for $n\ge4$;
- and, if the "$+24$" is to come with it, $\mathrm{Alt}(\lvert W\rvert)=2\,\mathrm{Alt}(W_-)$ as a hypothesis-carrying step ($\mathrm{Ric}(W)=0$, $\mathrm{Alt}(W)=0$), not as an aside.

## 8. What [Lemma L7](../findings/bounds.md) imports, and whether it is what this block establishes

**Yes, exactly, coefficient included.** L7's proof says *"Polarising [L15](../findings/problem.md)'s identity at $(W_+,W_-)$, with $\mathrm{Ric}(W)=0$ and $\mathrm{Alt}(W)=0$, turns that into $\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2$ exactly."* Carrying that out:

$$2\operatorname{tr}(RS)+\operatorname{scal}(R\#S)=\langle\mathrm{Ric}R,\mathrm{Ric}S\rangle+6\langle\mathrm{Alt}R,\mathrm{Alt}S\rangle$$

at $R=W_+$, $S=W_-$. The left side loses its first term because $W_+W_-=0$ for spectral parts, leaving $2\operatorname{tr}(W_+\#W_-)$. On the right, $W=W_+-W_-$ with $\mathrm{Ric}(W)=0$ and $\mathrm{Alt}(W)=0$ give $\mathrm{Ric}(W_+)=\mathrm{Ric}(W_-)$ and $\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$, so it is $\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2$. That is precisely the quantity L7's chain bounds $\theta\operatorname{tr}(W_-)+\operatorname{tr}(W_-^2)$ against. **The $6$ transfers unchanged from the quadratic form to the bilinear one**, which is the step a factor-of-two error would live in, and it does not.

**And L7 *is* the corrected master inequality, which neither block says.** Multiply L7 by $4$. Since $\operatorname{tr}W=0$ and $\lvert W\rvert=W+2W_-$, $\operatorname{scal}(\lvert W\rvert)=4\operatorname{tr}(W_-)$; and $\mathrm{Ric}(\lvert W\rvert)=2\,\mathrm{Ric}(W_-)$ gives $4\lVert\mathrm{Ric}(W_-)\rVert^2=\lVert\mathrm{Ric}(\lvert W\rvert)\rVert^2$. So

$$\theta\operatorname{scal}(\lvert W\rvert)+4\lVert W_-\rVert^2\le\lVert\mathrm{Ric}(\lvert W\rvert)\rVert^2+24\delta^2,$$

which is [ATTEMPTS.md](../ATTEMPTS.md):625's corrected master inequality verbatim, and Jäger's Lemma 3.2.2 with eq. (1.6) replaced by L15. **This is the derivation of the "$+24$" that [problem.md](../findings/problem.md):204's "So" asserts and does not carry**, and the record holds its two halves (L7 and the ATTEMPTS display), in two files that do not cite each other for it.

**The gap between what is proven and what is used: none, on the identity.** L7 uses no more than §2b establishes. The gap is one of *statement*, not of content: L7 consumes the **bilinear** form, and neither citable site displays it.

**What a consumer may cite.** From this block, and nothing beyond it:

> For every symmetric operator $R$ on $\Lambda^2\mathbb R^n$, in the conventions of [conventions.md](../findings/conventions.md), $\operatorname{scal}=2\operatorname{tr}$, $\#$ normalised by $I\#I=(n-2)I$, $\mathrm{Alt}$ the orthogonal projection of $S^2(\Lambda^2)$ onto $\Lambda^4$, and the pair-matrix Frobenius norm, $\operatorname{scal}(R^2+R^\#)=\lVert\mathrm{Ric}(R)\rVert^2+6\lVert\mathrm{Alt}(R)\rVert^2$, with the constant $6$ the same at every $n$ and the $\Lambda^4$ term non-trivial exactly for $n\ge4$; equivalently, in bilinear form, $2\operatorname{tr}(RS)+\operatorname{scal}(R\#S)=\langle\mathrm{Ric}R,\mathrm{Ric}S\rangle+6\langle\mathrm{Alt}R,\mathrm{Alt}S\rangle$.

Everything else in the block (the "$+24$", the $\mathcal S^4(\alpha)$ arithmetic, the sphere products, the two obstructions), is a **consequence** with its own hypotheses ($\mathrm{Ric}(W)=0$, $\mathrm{Alt}(W)=0$, criticality for the master inequality), and should be cited as such rather than as part of the identity.

## 9. The named trap, each citable claim read alone, as a consumer would

The record's signature failure is a correction landing **beside** the statement it corrects. Reading each site cold:

**[results.md](../results.md):643–647, the canonical form.** A consumer reads three sentences about $\lvert W\rvert$ and $W_\pm$, then *"The exact defect is"*, then the display, then *"**Proof:** [problem.md](../findings/problem.md)"*. The letter $R$ is introduced nowhere in the block; $\mathrm{Alt}$ is defined nowhere in the block; no convention is cited; the sentence ends in a comma before a proof pointer. **The only curvature class [results.md](../results.md) defines is $\mathcal W_n$, on which the display reads $0=0$.** This is the barest of the three sites and the one a consumer reaches first, because it is the canonical statement.

**[results.md](../results.md):218, the landscape line.** Carries the relabelling, the second obstruction, the $\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$ correction, and the L131 identification, **and displays no identity**, referring to *"the identity below"*, which is $429$ lines further down and carries none of those four. The correction and the statement it corrects are in one file, separated by the file.

**[problem.md](../findings/problem.md):190–204, the finding block.** Carries four correction quotes before the prose, and then a paragraph in which: the identity has no quantifier; "the invariant master inequality" is named and never defined; the $+24$ appears after a "So" whose two missing steps are in [isotropy-cap.md](../findings/isotropy-cap.md); the Fox arithmetic is asserted with no numbers; and "in any frame" is left to be read against a paragraph that has introduced **two different objects called $\lvert W\rvert$**, the entrywise one in its first sentence and the spectral one in its heading.

**What is beside rather than on the statement, item by item.**

| what a consumer needs | where it is | where the display is |
| --- | --- | --- |
| $R$ ranges over all symmetric operators on $\Lambda^2$ | [ATTEMPTS.md](../ATTEMPTS.md):621 | problem.md, results.md |
| $\operatorname{scal}=2\operatorname{tr}$, the pair-matrix pairing, $\mathrm{Alt}$'s $\tfrac13$ | [conventions.md](../findings/conventions.md) |, |
| $c_4=2$ at every $n$, which is the "every dimension" | [L79](../findings/isotropy-cap.md), via [L131](../findings/isotropy-cap.md)(i) |, |
| $\mathrm{Alt}(\lvert W\rvert)=2\,\mathrm{Alt}(W_-)$, which is the $24$ | [L131](../findings/isotropy-cap.md):416 |, |
| the master inequality the $+24$ enters | [ATTEMPTS.md](../ATTEMPTS.md):625, and, unstated as such, [Lemma L7](../findings/bounds.md) |, |
| the $\mathcal S^4(\alpha)$ numbers | [ATTEMPTS.md](../ATTEMPTS.md):625 |, |

**Six of six.** Every hypothesis, convention and supporting number the displayed claims need sits in a different file from the display, and the canonical form points only at a fourth file for a proof.

## 10. Discrepancy protocol

### D1, CONFIRMED. The quantifier on $R$ is absent at both citable sites, and the display is vacuous without it

**Locate.** [results.md](../results.md):647 and [findings/problem.md](../findings/problem.md):203, both reading in full:

> $$\operatorname{scal}(R^2+R^\#)=\|\mathrm{Ric}(R)\|^2+6\|\mathrm{Alt}(R)\|^2,$$

**Exhibit.** Take $R$ to be any algebraic curvature operator, the reading a curvature-programme reader will take, since $R$ is the record's letter for one, and the only such class either file defines. Then $R$ satisfies the first Bianchi identity, [conventions.md](../findings/conventions.md) gives $\mathrm{Alt}(R)=0$, and the identity reads $\operatorname{scal}(R^2+R^\#)=\lVert\mathrm{Ric}(R)\rVert^2$, which is Jäger's eq. (1.6), a fact of the literature, with **no defect and no $6$**. At $R=\mathrm{Id}$ (§4.1) both sides are $n(n-1)^2$ and the $6$ is invisible; the constant is pinned only at $R=\star$ (§4.2), which is not a curvature operator. So under the natural reading the entire content of the block (the word "defect" included), evaporates.

**Argue the opposite.** The most charitable reading: the surrounding prose is about $\lvert W\rvert$ and $W_\pm$, which are exactly the operators that *fail* Bianchi, so context tells a careful reader that $R$ must range wider; and [conventions.md](../findings/conventions.md)'s $\mathrm{Alt}$ entry says the projection annihilates every first-Bianchi tensor, so a reader who follows it will infer the wider class. That is inference from two other files, not statement, and it is exactly the inference the canonical form at [results.md](../results.md):647 gives no prompt for, since that block cites no conventions at all. **The candidate stands.** The repair is one clause, already written at [ATTEMPTS.md](../ATTEMPTS.md):621.

### D2, CONFIRMED. The canonical form is strictly barer than the finding block it points to

**Locate.** [results.md](../results.md):643–647 against [findings/problem.md](../findings/problem.md):203–204.

**Exhibit.** [problem.md](../findings/problem.md) follows its display with *"$\mathrm{Alt}$ being the projection onto $\Lambda^4$, with the constant exactly $6$ in every dimension and no cross-term."* [results.md](../results.md) **drops that entire sentence**, ending the block at the display's trailing comma and a proof pointer. So the canonical statement defines none of its symbols and claims neither dimension-freeness nor the absence of a cross-term, while [results.md](../results.md):218, the landscape entry for the same result, asserts *"The identity below is confirmed"* about a display that no longer carries what was confirmed.

**Argue the opposite.** [CONTRIBUTING.md](../CONTRIBUTING.md)'s division of labour puts the canonical statement in [results.md](../results.md) and the argument in [findings/](../findings/), so a bare canonical statement plus a proof pointer is the intended shape, and definitions belong in [conventions.md](../findings/conventions.md) by that file's own quote-never-restate rule. **The candidate survives that reading**, because what is dropped is not the *argument*, it is the **statement's own scope and constant clause**, which the canonical form is precisely the place for, and because [results.md](../results.md):647 quotes [conventions.md](../findings/conventions.md) nowhere, so the quote-never-restate rule is not being followed either.

### D3, CONFIRMED. The "So" before the $+24$ carries two unstated steps

**Locate.** [findings/problem.md](../findings/problem.md):204: *"So the invariant master inequality carries an extra $+24\|\mathrm{Alt}(W_-)\|^2$"*.

**Exhibit.** From the display's constant $6$, the naive substitution gives $+6\lVert\mathrm{Alt}(W_-)\rVert^2$. The $24$ needs (i) that the identity is applied at $\lvert W\rvert$ rather than at $W_-$, and (ii) $\mathrm{Alt}(\lvert W\rvert)=2\,\mathrm{Alt}(W_-)$, itself resting on $\mathrm{Alt}(W)=0$. Step (ii) lives at [isotropy-cap.md](../findings/isotropy-cap.md):416, in a block whose own warning is *"a constant stated at $\lvert W\rvert$ is not comparable with one stated at $W_-$"*, the exact trap this sentence walks into and does not name. The factor is a **four**, in a record that has lost cycles to factors of two.

**Argue the opposite.** "So" may be read as "so, by the derivation recorded at [ATTEMPTS.md](../ATTEMPTS.md):625", and both reviews the block cites ([r469](../reviews/REVIEW_r469.md), [r470](../reviews/REVIEW_r470.md)) carry the bridge explicitly. The number is **correct**, §4.5 confirms $24\cdot\tfrac19=\tfrac83$ closes the equality at $\mathcal S^4(\alpha)$ exactly. **The candidate stands as a citation defect, not a mathematical one:** the claim is true and the site gives a consumer no way to check the one factor most likely to be got wrong.

### D4, CONFIRMED, narrow. The primary-text quotation is attributed to the wrong lemma's proof

**Locate.** [findings/problem.md](../findings/problem.md):196: *"The primary text agrees: Lemma 3.2.2's proof has exactly two inputs, eq. (1.6) and "$X(W)\ge0$ is obvious by the definitions of $W_+$ and $W_-$"."*

**Exhibit.** In [diss_jaeger_florian.txt](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf), the sentence *"which concludes the proof since $X(W)\ge0$ is obvious by the definitions of $W_+$ and $W_-$"* closes the proof of **Lemma 3.2.1**, at line 2008; Lemma 3.2.2 begins at line 2012 and its proof (line 2021) reads *"As seen in equation (1.6) … This shows together with lemma 3.2.1"*. Moreover Lemma 3.2.2 as stated sets $C_\#(W):=\operatorname{scal}(X(W))$ and needs only $C_\#(W)\ge0$ (the **trace**, not the operator inequality) which is what [ATTEMPTS.md](../ATTEMPTS.md):618 records as *surviving* off the diagonal locus. So the sentence names the wrong lemma and, on the strong reading, attributes to 3.2.2 a hypothesis 3.2.2 does not need.

**Argue the opposite.** Charitably, "Lemma 3.2.2's proof" may mean the 3.2.1–3.2.2 pair taken together, since 3.2.2 invokes 3.2.1 by name; on that reading the count "two" and the classification "one Bianchi, one coordinate" both survive intact, and the record's substantive point is untouched. **The candidate stands only as a citation defect**, but it is one inside a sentence whose whole force is *"the primary text agrees"*, which a consumer will follow to 3.2.2 and not find. Recorded because the surrounding claim is otherwise confirmed against the source: §6 verifies eq. (1.6)'s $S^2_B$ quantifier and Lemma 3.2.2's use of it at $\lvert W\rvert$ directly.

### D5, WITHDRAWN as a refutation, recorded as an ambiguity. "in any frame"

**Locate.** [findings/problem.md](../findings/problem.md):204: *"Every sphere product, in any frame, has defect zero."*

**Exhibit, attempted.** The paragraph introduces two different objects under the symbol $\lvert W\rvert$: the **entrywise** absolute value in its first sentence (Jäger's), and the **spectral** parts $W_\pm$ in its heading and in $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$. Under the spectral reading, $W\mapsto\mathrm{Alt}(W_-)$ is $O(n)$-equivariant, so $\delta^2$ is an $O(n)$-invariant of $W$ and "in any frame" is **content-free**, a true sentence saying nothing. Under the entrywise reading, $\delta^2$ genuinely depends on the frame, so the phrase is the whole claim. **So the phrase carries content only under the reading it is not being used in.**

**Argue the opposite, and the withdrawal.** [ATTEMPTS.md](../ATTEMPTS.md):618 fixes the lifted objects as spectral, *"which agree with Jäger's masked $W_\pm$ on the diagonal locus"*, and the block's own heading says "the spectral parts". So the intended reading is settled and the sentence is true. I exhibit **no** witness (a rotated sphere product whose entrywise $\lvert W\rvert$ has non-zero $\mathrm{Alt}$) because constructing one is a computation, which this round's footing ([analysis-only.md](../.claude/rules/analysis-only.md)) does not open. **Withdrawn** for want of a concrete exhibit; recorded as a reading ambiguity in §9, since the symbol is overloaded inside one paragraph.

### D6, WITHDRAWN. "no cross-term" as an under-statement

**Locate.** [findings/problem.md](../findings/problem.md):204. **Exhibit, attempted.** The identity pins four coefficients, and the phrase mentions only the off-diagonal ones; the vanishing $\mathrm{Weyl}$ coefficient, equivalently $\operatorname{tr}W^\#=-\lVert W\rVert^2$, checked at $\mathcal S^4(\alpha)$ in §2c, goes unmentioned. **Argue the opposite.** Nothing false follows: "no cross-term" is true, and $\operatorname{tr}W^\#=-\lVert W\rVert^2$ is on the record independently ([bounds-relaxations.md](../findings/bounds-relaxations.md):307, as a constraint the relaxation carries). **Withdrawn**, an omission with no consequence is not a discrepancy. Recorded in §2c as content the block leaves on the table.

### D7, CONFIRMED, minor. "polarised" names one of three steps

Located, exhibited and argued in §5. The equivalence holds; the word covers the quadratic-to-bilinear step and not the bilinear-to-operator step or the two conversions, and [lean/INDEX.md](../lean/INDEX.md):183's justification for it is the step it does cover. **Stands as a label defect**: a consumer told "L15 is L131 polarised" and asked to reproduce it will not, from either block, find $\mathrm{Ric}^*=2(\,\cdot\wedge\mathrm{id})$ flagged as needed at L15's end or §2a's identity anywhere.

### D8, CONFIRMED, minor. "in every dimension" has no floor

Located at [findings/problem.md](../findings/problem.md):204. At $n\le3$, $\Lambda^4=0$ and every constant closes the identity (§4.6 checks $n=3$), so "exactly $6$" is vacuous there and the word "exactly" is unsupported below $n=4$. Charitably the record works at $n\ge4$ throughout and the phrase means "with no $n$-dependence". **Stands as a range omission**, repaired by writing $n\ge4$.

## 11. What would break it, and what I did to look for it

**The object that would falsify the identity.** A symmetric $R$ on $\Lambda^2\mathbb R^n$ with $\operatorname{scal}(R^2+R^\#)\ne\lVert\mathrm{Ric}(R)\rVert^2+6\lVert\mathrm{Alt}(R)\rVert^2$ in §0's conventions. By §2c any such $R$ would have to break one of four scalar coefficients, so it suffices to look inside each $O(n)$-summand and at one mixed vector:

| summand probed | object used | outcome |
| --- | --- | --- |
| $\mathbb R\cdot I$ | $R=\mathrm{Id}$, every $n$ (§4.1) | exact |
| $\Lambda^4$ | $R=\star$ at $n=4$ (§4.2); the padded $\sigma$ at every $n\ge4$ (§4.3) | exact; $c_4=2$ rebuilt from brackets |
| $\mathbb R\cdot I\oplus\Lambda^4$, the one pair $SO(4)$ cannot separate | $R=\mathrm{Id}+t\star$ at $n=4$, all $t$ (§4.4) | exact, cross-term zero |
| $\mathbb R\cdot I\oplus S^2_0$ | $R=I_p\oplus I_q$, every $p+q=n$ (§4.6) | exact |
| $\mathrm{Weyl}$ | $R=W_{\mathcal S^4(\alpha)}$, via $\operatorname{tr}W^\#=-\lVert W\rVert^2$ (§2c) | exact |
| the $\mathrm{Alt}$ term inside a non-Bianchi mixture | $R=\lvert W\rvert$ at $\mathcal S^4(\alpha)$ (§4.5), where both terms are non-zero and unequal | exact, $\tfrac{16}3$ two ways |
| $\Lambda^4=0$ edge | $R$ rank one at $n=3$ (§4.6) | exact |

**The object that would falsify the constant's dimension-freeness** is an $n$ with $c_4(n)\ne2$. §4.3 rules that out for every $n\ge4$ by one padded evaluation plus Schur, and [L79](../findings/isotropy-cap.md)'s Casimir route rules it out independently with two consistency checks.

**The object that would falsify C7** is a reading of $\mathcal S^4(\alpha)$ at which the corrected inequality is not saturated. §4.5 computes all four quantities exactly at $n=4$ and they close to $4=4$; padding changes none of them.

**No falsifier found, and none of the searching was numerical.** Every entry above is a hand evaluation displayed in full. No script was run; no sweep, census or search was opened.

**What I did not check, and it is not silence.** The block's claims *about Jäger's thesis structure* beyond eq. (1.6), Lemma 3.2.1 and Lemma 3.2.2, in particular that Lemma 3.3.4 rests on $X_{\mathrm{inv}}\succeq0$, I read only in [ATTEMPTS.md](../ATTEMPTS.md), not in the primary text, and record as unchecked. The numerical refutation of $X(W)\succeq0$ off the diagonal locus ([ATTEMPTS.md](../ATTEMPTS.md):618, $\min\mathrm{eig}\approx-2.4\times10^{-2}$ at an $n=6$ critical point) is a numerical claim and I neither reproduced nor could reproduce it under this round's footing; §6 states its status rather than relying on it.

## Verdict

### `PROVEN, hypotheses corrected`

**Proven.** The identity holds for every symmetric operator on $\Lambda^2\mathbb R^n$, at every $n$, with the constant exactly $6$ and no cross-term, in the record's conventions. It has a derivation on file ([L131](../findings/isotropy-cap.md) plus [L79](../findings/isotropy-cap.md), and the two reviews the block cites), and §2 rebuilds it independently, §4 checks it at seven objects across three dimensions, and §8 confirms that what [Lemma L7](../findings/bounds.md) imports is exactly what it establishes, coefficient and all. The "$+24$", the factor of three at $\mathcal S^4(\alpha)$, the saturation there and the vanishing sphere-product defect are all true, the first three verified here by exact hand evaluation.

**Hypotheses corrected, the repairs the record owes, all at the citable sites and none to the mathematics.**

1. **Restore the quantifier** at [problem.md](../findings/problem.md):203 and [results.md](../results.md):647: *"for every symmetric $R$ on $\Lambda^2\mathbb R^n$"*, already written at [ATTEMPTS.md](../ATTEMPTS.md):621. Without it the display is vacuous under its natural reading (D1).
2. **Restore the scope clause at [results.md](../results.md):647**, which currently defines none of its symbols and claims neither the constant nor the absence of a cross-term (D2).
3. **Write $n\ge4$** where "in every dimension" now stands, and cite [L79](../findings/isotropy-cap.md) for $c_4=2$ (D8, §4.3).
4. **Cite the conventions the $6$ depends on**, $\operatorname{scal}=2\operatorname{tr}$, $I\#I=(n-2)I$, the pair-matrix pairing, $\mathrm{Alt}$'s $\tfrac13$, since the identity is *false*, not merely rescaled, under the other $\#$ normalisation in circulation (§0, §2b).
5. **Give the "$+24$" its two steps**, or point at [L131](../findings/isotropy-cap.md):416 and [ATTEMPTS.md](../ATTEMPTS.md):625 (D3), and **name the master inequality**, which, §8 shows, is $4\times$ [Lemma L7](../findings/bounds.md), a connection neither block makes.
6. **Fix the primary-text attribution** at [problem.md](../findings/problem.md):196: the quoted sentence closes Lemma 3.2.1's proof, and Lemma 3.2.2 needs only $\operatorname{scal}(X(W))\ge0$ (D4).
7. **State the bilinear form**, since that is what the one consumer on the record actually uses (§8).

**Not a defect of this result, but its heading's:** the second obstruction, $X_{\mathrm{inv}}\succeq0$, is established here, elsewhere and nowhere in that order, nowhere. The identity prices the Bianchi obstruction and touches the other not at all (§6).
