# VERIFY v116, L7's compression inequality $\theta\mathop{\mathrm{tr}}(W_-)+\mathop{\mathrm{tr}}(W_-^2)\le\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2$, its equality class, and the rank-one constant its proof prints

**Cold brief, verifier v116.** Target: [findings/bounds.md](../findings/bounds.md):43–59, with the mirror at [results.md](../results.md):326–334 and the landscape line at [results.md](../results.md):122. **No numerical work was done**: no script was run, and every value below is an exact hand evaluation in closed form. Log: [agent_logs/verify-L07-v116.log](../agent_logs/verify-L07-v116.log).

## Claim table

| # | claim, and where a consumer meets it | verdict |
| --- | --- | --- |
| C1 | the inequality $\theta\mathop{\mathrm{tr}}(W_-)+\mathop{\mathrm{tr}}(W_-^2)\le\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2$ at every critical point ([bounds.md:47](../findings/bounds.md)) | **PROVEN**, re-derived in full, §2; verified as an exact equality at $W_{\mathbb{CP}^2}$, $4/3=4/3$ |
| C2 | the exact identity $\theta\mathop{\mathrm{tr}}(W_-)+\mathop{\mathrm{tr}}(W_-^2)=-\mathop{\mathrm{tr}}(\Pi_-W^\#)$ ([bounds.md:51](../findings/bounds.md)) | **PROVEN**, and correct only under $W_-\succeq0$, §2.1, §5.3 |
| C3 | the coefficient $6$ | **PROVEN and pinned**, it is [L15](../findings/problem.md)'s, dimension-free, and no other constant closes $W_{\mathbb{CP}^2}$; §2.4 |
| C4 | the printed rank-one identity $vv^{\mathsf T}\#ww^{\mathsf T}=[v,w][v,w]^{\mathsf T}$ ([bounds.md:51](../findings/bounds.md)) | **BROKEN, a factor $2$.** The record's own four other printings carry $\tfrac12$; three independent anchors force $\tfrac12$; §3. *Inert for C1, which uses only the sign* |
| C5 | the equality clause as [bounds.md:57](../findings/bounds.md) states it, kernel closure included | **PROVEN**, imported from [L155](../findings/bounds.md)/[L154](../findings/bounds.md), and the closure follows from the stated triple plus criticality; §4.2 |
| C6 | *"which is exactly the condition defining a compact symmetric pair with $E_+$ the isotropy algebra"* ([results.md:332](../results.md), [report 07:77](../report/sections/07-gradedness-split.tex)) | **BROKEN**, false as a biconditional under both readings; §4.3, D2 |
| C7 | *"it fails strictly at the low-value ones"* ([results.md:332](../results.md), [report 07:77](../report/sections/07-gradedness-split.tex)) | **BROKEN**, $S^2\times S^4$, $\theta=\sqrt{15/16}<1$, attains equality; §4.4, D2 |
| C8 | *"the last two used twice each in the final step"* ([bounds.md:53](../findings/bounds.md)) | **route-dependent, withdrawn as a defect**, once each on the block's own stated route, twice each on the depolarised one; §5.2 |
| C9 | *"bracket-graded **modulo $\ker W$**"* ([results.md:122](../results.md)) and the same hedge in [lean/INDEX.md:179](../lean/INDEX.md) | **STALE**, retired by [L155](../findings/bounds.md); §6, D3 |
| C10 | *"no sign condition and no unit-norm requirement"* ([bounds.md:53](../findings/bounds.md)) | **PROVEN**, and the equality class is *not* stable under $W\mapsto-W$; §7.5 |

**One line.** The inequality is true, its proof is correct, and I rebuilt it from the definitions and checked it as an exact equality at $W_{\mathbb{CP}^2}$ by hand; the block's proof nonetheless prints the rank-one $\#$-identity with the wrong constant, and the two clauses that [bounds.md](../findings/bounds.md)'s own box refutes still stand verbatim at the two sites a consumer reads first.

## 0. Conventions, fixed once

Every item is quoted from [conventions.md](../findings/conventions.md) unless marked otherwise.

- $Q(W)=W^2+W^\#$ on $\mathcal W_n$; a **critical point** is $Q(W)=\theta W$; $\theta=P(W)/\lVert W\rVert^3$.
- $W\in\mathcal W_n$ is an algebraic **Weyl** operator: symmetric on $\Lambda^2\mathbb R^n$, $\mathrm{Ric}(W)=0$, and first Bianchi $\mathrm{Alt}(W)=0$. $\mathrm{Alt}$ is the *orthogonal projection* of $S^2(\Lambda^2)$ onto $\Lambda^4$, so $\mathrm{Alt}$ is linear, self-adjoint, idempotent.
- **The sign.** $W_-:=\tfrac12(\lvert W\rvert-W)\succeq0$ (the positive-semidefinite magnitude of the negative part) so $W=W_+-W_-$, $W_\pm\succeq0$, $W_+W_-=0$. conventions.md records that a collision between this and the opposite sign *"refuted four lemmas in one day … bites only where a one-sided inequality is applied"*.
- $\{\varphi_{ab}\}_{a<b}$ with $\varphi_{ab}=E_{ab}-E_{ba}$ is orthonormal under the half-trace pairing $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ on $\Lambda^2$; the pairing on $S^2(\Lambda^2)$ is plain operator Frobenius, under which $\lVert\star\rVert^2=6$ at $n=4$; the pairing on $\mathrm{Ric}$'s target is $n\times n$ Frobenius.
- **$\mathop{\mathrm{scal}}(R)=2\mathop{\mathrm{tr}}_{\Lambda^2}(R)$.** This is load-bearing for L7 and is **not in [conventions.md](../findings/conventions.md)**, which is the file whose stated purpose is to hold exactly such a normalisation. I pin it independently in §2.4 from [L15](../findings/problem.md)'s identity at $R=\mathrm{Id}$ and at $R=\star$; [r515](../reviews/REVIEW_r515.md) and [r516](../reviews/REVIEW_r516.md) pinned it the same way, and [ATTEMPTS.md](../ATTEMPTS.md):3962 a third.
- **Structure constants.** $c_{abc}=\langle[v_a,v_b],v_c\rangle$ totally antisymmetric, $T_{abc}=c_{abc}^2$ totally symmetric; the Killing row marginal ([Lemma L153](../findings/bounds.md)) is $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ over **ordered** pairs.
- $\delta^2:=\lVert\mathrm{Alt}(W_-)\rVert^2$ ([problem.md:362](../findings/problem.md)).
- $\Pi_-$ is the orthogonal projection of $\Lambda^2$ onto the strictly negative eigenspace $E_-$; $\Pi_+$, $\Pi_0$ likewise onto $E_+$ and $\ker W$. $\mathfrak p:=E_+=\mathop{\mathrm{ran}}W_+$, $\mathfrak m:=E_-=\mathop{\mathrm{ran}}W_-$, $\mathfrak k:=\ker W$.

## 1. The hypothesis inventory

**Carried by the block.** Three, named at [bounds.md:53](../findings/bounds.md): *"The hypotheses are criticality, Ricci-flatness and first Bianchi"*, with the explicit disclaimers *"There is no sign condition and no unit-norm requirement."*

| # | hypothesis | the object it applies to | used in the written proof? |
| --- | --- | --- | --- |
| H1 | $Q(W)=\theta W$ (criticality, in the strong operator form) | $W$ | **yes**, once, at the partial trace |
| H2 | $\mathrm{Ric}(W)=0$ | $W$, not $W_\pm$ | **yes**, in the final step |
| H3 | $\mathrm{Alt}(W)=0$ (first Bianchi) | $W$, not $W_\pm$ | **yes**, in the final step |

H2 and H3 together are membership in $\mathcal W_n$; they are hypotheses of the statement rather than side conditions, and the block is right to name them separately, because **the identity it imports is applied to $W_+$ and $W_-$, which satisfy neither**. That is the whole content of [Observation L15](../findings/problem.md) and the reason $\lVert\mathrm{Ric}(W_-)\rVert^2$ and $\delta^2$ are not zero.

**Imported results, each checked against the object it is applied to.**

| imported | statement | object it is applied to here | admissible? |
| --- | --- | --- | --- |
| [Observation L15](../findings/problem.md) | $\mathop{\mathrm{scal}}(R^2+R^\#)=\lVert\mathrm{Ric}(R)\rVert^2+6\lVert\mathrm{Alt}(R)\rVert^2$ | $R=W_+$, $R=W_-$, $R=W$, all in $S^2(\Lambda^2)$ | **yes.** The identity is stated for a general algebraic curvature operator with no Bianchi hypothesis; that generality is exactly what L15 exists to record. It is *not* the refuted half of L15 (which claimed the Bianchi defect is the only obstruction to lifting Jäger's argument), matching [LEDGER.md:267](../findings/LEDGER.md)'s *"No Lemma rests on the refuted half"* |
| rank-one positivity of $\#$ | $(uu^{\mathsf T})\#(ww^{\mathsf T})=\tfrac12[u,w][u,w]^{\mathsf T}\succeq0$, hence $A,B\succeq0\Rightarrow A\#B\succeq0$ | $W_+$, $W_-$, both $\succeq0$ | **yes**, but the block prints the constant as $1$; see §3 |
| [Lemma L155](../findings/bounds.md) | $X_{\mathrm{inv}}=0$ iff $\mathfrak p\oplus\mathfrak m$ is $\mathbb Z_2$-graded with even part $\mathfrak p$ | any symmetric $W\ne0$; criticality unused | **yes**, and its reach exceeds what L7 needs |
| [Lemma L154](../findings/bounds.md)(i) | $\mathop{\mathrm{tr}}X_{\mathrm{inv}}=0\iff X_{\mathrm{inv}}=0$ | a critical $W\ne0$ | **yes**; H1 is a hypothesis of L154 and L7 has it |
| [Lemma L153](../findings/bounds.md) | the Killing row marginal $2(n-2)$ | used only by me, to pin the rank-one constant (§3) | **yes** |

**Sources.** [L15](../findings/problem.md), [L153](../findings/bounds.md), [L154](../findings/bounds.md), [L155](../findings/bounds.md), [L23](../findings/ungraded-slack.md), [r515](../reviews/REVIEW_r515.md), [r516](../reviews/REVIEW_r516.md), [r699](../reviews/REVIEW_r699.md) are all on the record and I read them. **No external source is cited by the block, and none is needed**; nothing here rests on an unread source. *The one place the record's own [conventions.md](../findings/conventions.md) flags an unread source (Cartan's classification, cited to nothing), is not consumed by L7, though a classification of the equality class (§9) would consume it.*

**Not named, and used.** See §5.3: spectral orthogonality $W_+W_-=0$, the normalisation $\mathop{\mathrm{scal}}=2\mathop{\mathrm{tr}}$, and the sign convention $W_-\succeq0$.

## 2. Question 1, does the compression give the inequality?

I rebuilt the four steps from the definitions. **It does.**

### 2.1 The partial trace is an exact identity, and it fixes the sign of $W_-$

$W=W_+-W_-$ with orthogonal supports, so $W^2=W_+^2+W_-^2$ and

$$\mathop{\mathrm{tr}}(\Pi_-W^2)=\mathop{\mathrm{tr}}(W_-^2),\qquad \mathop{\mathrm{tr}}(\Pi_-W)=\mathop{\mathrm{tr}}(-W_-)=-\mathop{\mathrm{tr}}(W_-).$$

Applying $\mathop{\mathrm{tr}}(\Pi_-\,\cdot\,)$ to $Q(W)=W^2+W^\#=\theta W$ (H1):

$$\mathop{\mathrm{tr}}(W_-^2)+\mathop{\mathrm{tr}}(\Pi_-W^\#)=-\theta\mathop{\mathrm{tr}}(W_-)\quad\Longleftrightarrow\quad \boxed{\ \theta\mathop{\mathrm{tr}}(W_-)+\mathop{\mathrm{tr}}(W_-^2)=-\mathop{\mathrm{tr}}(\Pi_-W^\#)\ }$$

which is the block's displayed identity, verbatim. **It is exact and it is correct.** Under the opposite sign convention ($W_-:=\Pi_-W\preceq0$) the same computation returns $\mathop{\mathrm{tr}}(W_-^2)-\theta\mathop{\mathrm{tr}}(W_-)$ on the left, so the displayed identity is true under one of the two readings only.

### 2.2 Bilinearity, and which terms die

$\#$ is the symmetric bilinear map with $A\#A=A^\#$, so $(A-B)^\#=A^\#-2A\#B+B^\#$ and

$$W^\#=W_+^\#-2\,W_+\#W_-+W_-^\# .$$

$W_\pm\succeq0$, so by rank-one positivity all three of $W_+^\#$, $W_-^\#$, $W_+\#W_-$ are $\succeq0$. Since $\Pi_-\succeq0$, $\mathop{\mathrm{tr}}(\Pi_-W_+^\#)\ge0$ and $\mathop{\mathrm{tr}}(\Pi_-W_-^\#)\ge0$; since $\Pi_-\preceq I$ and $W_+\#W_-\succeq0$, $\mathop{\mathrm{tr}}(\Pi_-(W_+\#W_-))\le\mathop{\mathrm{tr}}(W_+\#W_-)$. Hence

$$-\mathop{\mathrm{tr}}(\Pi_-W^\#)\;=\;-\mathop{\mathrm{tr}}(\Pi_-W_+^\#)-\mathop{\mathrm{tr}}(\Pi_-W_-^\#)+2\mathop{\mathrm{tr}}\!\big(\Pi_-(W_+\#W_-)\big)\;\le\;2\mathop{\mathrm{tr}}(W_+\#W_-),$$

which is the block's *"kills two terms against $\Pi_-\preceq I$ and leaves $\le2\mathop{\mathrm{tr}}(W_+\#W_-)$"*. **This is the only inequality in the proof; everything before and after it is an equality.** Note that $\Pi_-\preceq I$ is what handles the *third* term and $\Pi_-\succeq0$ what kills the first two, the block attributes all three to $\Pi_-\preceq I$, which is a compression of the wording rather than an error.

### 2.3 The final step, on the block's own route

L15's identity is a quadratic form identity in $R$, valid on all of $S^2(\Lambda^2)$. Its polarisation, $q(R)=\mathop{\mathrm{scal}}(R^2)+\mathop{\mathrm{scal}}(R^\#)$, $(A+B)^2=A^2+AB+BA+B^2$, $(A+B)^\#=A^\#+2A\#B+B^\#$, is

$$\tfrac12\mathop{\mathrm{scal}}(AB+BA)+\mathop{\mathrm{scal}}(A\#B)=\langle\mathrm{Ric}A,\mathrm{Ric}B\rangle+6\langle\mathrm{Alt}A,\mathrm{Alt}B\rangle .$$

At $(A,B)=(W_+,W_-)$ the first term vanishes because $W_+W_-=W_-W_+=0$. Linearity of $\mathrm{Ric}$ and $\mathrm{Alt}$ with H2 and H3 give $\mathrm{Ric}(W_+)=\mathrm{Ric}(W_-)$ and $\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$, so

$$\mathop{\mathrm{scal}}(W_+\#W_-)=\lVert\mathrm{Ric}(W_-)\rVert^2+6\lVert\mathrm{Alt}(W_-)\rVert^2=\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2 .$$

Finally $\mathop{\mathrm{scal}}=2\mathop{\mathrm{tr}}_{\Lambda^2}$ turns the left side into $2\mathop{\mathrm{tr}}(W_+\#W_-)$, **exactly** the quantity §2.2 left. Chaining §2.1–§2.3 gives the lemma. $\square$

**Where the $6$ comes from, and why the factor $2$ does not disturb it.** The $6$ is L15's own constant and enters at that last equality only, as the block says. The polarisation halves the cross term and $\mathop{\mathrm{scal}}=2\mathop{\mathrm{tr}}$ doubles it back; the two cancel exactly, which is why the coefficient reaching L7 is $6$ and not $3$ or $12$. **Nothing in the chain is dimension-dependent**, so the constant is dimension-free, as claimed.

### 2.4 The coefficient is right, three exact anchors, by hand

**(a) $R=\mathrm{Id}_{\Lambda^2}$.** $\mathrm{Ric}(\mathrm{Id})=(n-1)\mathrm{Id}_n$, so $\lVert\mathrm{Ric}\rVert^2=n(n-1)^2$; $\mathrm{Alt}(\mathrm{Id})=0$. Writing $\mathrm{Id}^\#=c\,\mathrm{Id}$, L15 gives $2\binom n2(1+c)=n(n-1)^2$, i.e. $c=n-2$ and $Q(\mathrm{Id})=(n-1)\mathrm{Id}$, the round sphere. This simultaneously pins $\mathop{\mathrm{scal}}=2\mathop{\mathrm{tr}}$: with $\mathop{\mathrm{scal}}=\mathop{\mathrm{tr}}$ the same equation returns $c=2n-3$, which fails anchor (b) below.

**(b) $R=\star$ at $n=4$.** $\mathrm{Ric}(\star)=0$, $\mathrm{Alt}(\star)=\star$, $\star^2=\mathrm{Id}_{\Lambda^2\mathbb R^4}$, $\lVert\star\rVert^2=6$. L15 requires $\mathop{\mathrm{scal}}(\star^2)+\mathop{\mathrm{scal}}(\star^\#)=6\cdot6=36$, i.e. $12+\mathop{\mathrm{scal}}(\star^\#)=36$, i.e. $\mathop{\mathrm{tr}}(\star^\#)=12$. §3 computes $\mathop{\mathrm{tr}}(\star^\#)=12$ from the structure constants, so the coefficient $6$ and the normalisation are consistent.

**(c) $W_{\mathbb{CP}^2}$ at $n=4$, both sides of L7, exactly.** Take $\Lambda^2_+=\mathop{\mathrm{span}}(u_1,u_2,u_3)$ orthonormal, $u_1=\tfrac1{\sqrt2}(\varphi_{12}+\varphi_{34})$ and cyclically; $W=\varepsilon(2u_1u_1^{\mathsf T}-u_2u_2^{\mathsf T}-u_3u_3^{\mathsf T})$ with $\varepsilon^2=\tfrac16$, so $\mathop{\mathrm{tr}}(W^2)=6\varepsilon^2=1$. From $[\varphi_{ab},\varphi_{bc}]=\varphi_{ac}$ one gets $[u_1,u_2]=-\sqrt2\,u_3$ and cyclically, so $\lVert[u_i,u_j]\rVert^2=2$, the pair cap of [L31](../findings/stratum-two-negative.md), saturated. Then, with the rank-one constant $\tfrac12$ of §3,
$$W_+^\#=0,\quad W_-^\#=2\varepsilon^2u_1u_1^{\mathsf T},\quad W_+\#W_-=2\varepsilon^2(u_2u_2^{\mathsf T}+u_3u_3^{\mathsf T}),$$
whence $\mathop{\mathrm{tr}}(W^\#)=2\varepsilon^2-8\varepsilon^2=-6\varepsilon^2=-1$ (**the record's own anchor $\mathop{\mathrm{tr}}W^\#=-1$ at unit norm**) and $Q(W)=6\varepsilon^2u_1u_1^{\mathsf T}-3\varepsilon^2(u_2u_2^{\mathsf T}+u_3u_3^{\mathsf T})=3\varepsilon\,W$, so $W$ is critical with $\theta=3\varepsilon=\sqrt{3/2}$.
- **Left side.** $\theta\mathop{\mathrm{tr}}(W_-)+\mathop{\mathrm{tr}}(W_-^2)=3\varepsilon\cdot2\varepsilon+2\varepsilon^2=8\varepsilon^2=\tfrac43$.
- **Middle.** $2\mathop{\mathrm{tr}}(W_+\#W_-)=2\cdot4\varepsilon^2=8\varepsilon^2=\tfrac43$, the compression is tight here.
- **Right side.** $\mathrm{Ric}(W_+)_{ik}=2\varepsilon\sum_j\tilde u_{1,ij}\tilde u_{1,kj}=2\varepsilon(\tilde u_1\tilde u_1^{\mathsf T})_{ik}=\varepsilon\,\delta_{ik}$, so $\lVert\mathrm{Ric}(W_-)\rVert^2=\lVert\mathrm{Ric}(W_+)\rVert^2=4\varepsilon^2=\tfrac23$. And $\mathrm{Alt}(W_-)=\frac{\langle W_-,\star\rangle}{6}\star=\frac{2\varepsilon}6\star$, so $\delta^2=\frac{4\varepsilon^2}{36}\cdot6=\frac{4\varepsilon^2}6=\tfrac19$. Hence $\tfrac23+6\cdot\tfrac19=\tfrac43$.

**$\tfrac43=\tfrac43$, and the $6$ is the unique coefficient that closes it**, since $\delta^2=\tfrac19\ne0$ there. This reproduces the block's own sentence *"pinned instead at $W_{\mathbb{CP}^2}$, where $\delta^2=\tfrac19$ and both sides are $\tfrac43$"*, independently and by hand.

## 3. Discrepancy D1, the block's proof prints the rank-one $\#$-identity with the wrong constant

**Locate.** [findings/bounds.md](../findings/bounds.md):51, inside the proof:

> **rank-one positivity ($vv^{\mathsf T}\#ww^{\mathsf T}=[v,w][v,w]^{\mathsf T}$, a theorem rather than an assumption**), kills two terms against $\Pi_-\preceq I$

**Exhibit the failure.** The correct constant is $\tfrac12$, and three independent exact anchors force it.

1. **The Killing row marginal.** Let $vv^{\mathsf T}\#ww^{\mathsf T}=k\,[v,w][v,w]^{\mathsf T}$. Summing over an orthonormal basis $\{v_\alpha\}$ of $\Lambda^2\cong\mathfrak{so}(n)$, $\langle\mathrm{Id}^\#x,x\rangle=k\sum_{\alpha\beta}\langle[v_\alpha,v_\beta],x\rangle^2=k\sum_{\alpha\beta}T_{\alpha\beta x}=2k(n-2)$ by [Lemma L153](../findings/bounds.md) in [conventions.md](../findings/conventions.md)'s ordered reading. Against $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ (§2.4a) this gives $k=\tfrac12$. *I verified the marginal itself in the coordinate basis: for $\alpha=(12)$ the only nonzero triples are $c_{(12)(1c)(2c)}=\pm1$, $c=3,\dots,n$, giving $(n-2)$ unordered pairs and $2(n-2)$ ordered.*
2. **$\mathop{\mathrm{tr}}(\star^\#)$ at $n=4$.** $\Lambda^2_\pm$ are the two $\mathfrak{su}(2)$ ideals, so $\Pi_+\#\Pi_-=0$ and $\star^\#=\Pi_+^\#+\Pi_-^\#$. With $[u_i,u_j]=\pm\sqrt2u_k$, $\Pi_+^\#=k\sum_{i\ne j}2u_ku_k^{\mathsf T}=4k\,\Pi_+$. So $\mathop{\mathrm{tr}}(\star^\#)=24k$, and anchor §2.4(b) demands $12$: $k=\tfrac12$. **At $k=1$, L15's identity fails at $R=\star$** ($\mathop{\mathrm{scal}}(\star^2+\star^\#)=12+48=60$ against $6\lVert\star\rVert^2=36$) so the printed constant contradicts the very identity L7 imports.
3. **$\mathop{\mathrm{tr}}(W^\#)=-1$ at $W_{\mathbb{CP}^2}$.** §2.4(c) returns $-6\varepsilon^2=-1$ with $k=\tfrac12$, and $-2$ with $k=1$, against the record's standing anchor $\mathop{\mathrm{tr}}W^\#=-1$ at unit norm. At $k=1$ the middle term of §2.4(c) reads $\tfrac83$ against a left side of $\tfrac43$, so the block's own named equality point would stop being one.

**Argue the opposite.** The most charitable reading is that the display is a *proportionality*, the block uses only $A\#B\succeq0$, and a positive constant is invisible to that, so the proof is unharmed whichever constant is written. Two things defeat the reading. First, the block asserts it as *"a theorem rather than an assumption"*, i.e. as a statement of record, not as a sign remark. Second, **the record prints this same identity with the $\tfrac12$ at four other sites**, [ATTEMPTS.md](../ATTEMPTS.md):942, :1194, :1228 and [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex):35, so the block is the outlier, and a consumer who lifts the line lifts a doubled $\#$, which changes $Q$, hence $\theta$, hence every value in the record. **Real, and inert for L7 itself.**

*Provenance, since it is the record's own failure mode.* [r515](../reviews/REVIEW_r515.md) and [r516](../reviews/REVIEW_r516.md) each rebuilt the proof cold and each wrote $\tfrac12$ ([r516](../reviews/REVIEW_r516.md) calibrating it two ways). The block's proof paragraph was transcribed from those rebuilds afterwards, [LEDGER.md](../findings/LEDGER.md):644, *"The proof is now in it"*, and the $\tfrac12$ was lost in the transcription. **The repair introduced the error.**

## 4. Question 2, what the equality clause characterises

### 4.1 The equality conditions, read off §2.2

Equality holds iff all three dropped quantities vanish. Each is the trace of a PSD operator against a projection, and $\mathop{\mathrm{tr}}(\Pi X)=0$ with $X\succeq0$ iff $\Pi X\Pi=0$ iff $\mathop{\mathrm{ran}}X\perp\mathop{\mathrm{ran}}\Pi$. With $C:=W_+\#W_-$ and the range rule $\mathop{\mathrm{ran}}(A\#B)=\mathop{\mathrm{span}}\{[u,w]:u\in\mathop{\mathrm{ran}}A,\,w\in\mathop{\mathrm{ran}}B\}$ (from the rank-one formula and bilinearity), equality is

$$\Pi_-W_+^\#\Pi_-=0,\qquad \Pi_-W_-^\#\Pi_-=0,\qquad (I-\Pi_-)\,C\,(I-\Pi_-)=0,$$

i.e. $[\mathfrak p,\mathfrak p]\perp\mathfrak m$, $[\mathfrak m,\mathfrak m]\perp\mathfrak m$, and $[\mathfrak p,\mathfrak m]\perp\mathfrak p\oplus\mathfrak k$, the last being $[\mathfrak p,\mathfrak m]\subseteq\mathfrak m$. **These are exactly the three conditions [bounds.md:57](../findings/bounds.md) displays**, and exactly [r516](../reviews/REVIEW_r516.md)'s (E1)–(E3).

### 4.2 The kernel closes, and it is the third condition plus criticality that closes it

[bounds.md:57](../findings/bounds.md) adds *"The kernel closes too, so the class is a genuine graded subalgebra rather than one stated modulo $\ker W$"*, citing [L155](../findings/bounds.md). **The claim is correct, and the block's own three conditions already carry it at a critical point.** From $4C=\lvert W\rvert^\#-W^\#$ and $W^\#=\theta W-W^2$ (H1), $\Pi_0W^\#\Pi_0=0$, so $\Pi_0\lvert W\rvert^\#\Pi_0=4\,\Pi_0C\Pi_0$. The third condition gives $\Pi_0C\Pi_0=0$, hence $\Pi_0(W_+^\#+W_-^\#)\Pi_0=0$; both summands are PSD, so both vanish, giving $[\mathfrak p,\mathfrak p]\perp\mathfrak k$ and $[\mathfrak m,\mathfrak m]\perp\mathfrak k$. With $\mathfrak{so}(n)=\mathfrak p\oplus\mathfrak m\oplus\mathfrak k$ the three conditions upgrade to the three inclusions $[\mathfrak p,\mathfrak p]\subseteq\mathfrak p$, $[\mathfrak p,\mathfrak m]\subseteq\mathfrak m$, $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p$.

*This is a check of what the block asserts, not a substitute for it: the record's own route is [L154](../findings/bounds.md)(i) plus [L155](../findings/bounds.md), both on file with proofs, and the bridge $\tfrac12\mathop{\mathrm{tr}}X_{\mathrm{inv}}=$ L7's slack is at [bounds.md:70](../findings/bounds.md) citing [r699](../reviews/REVIEW_r699.md) and at [ATTEMPTS.md](../ATTEMPTS.md):3962. I confirm that bridge: $\tfrac12\mathop{\mathrm{tr}}X_{\mathrm{inv}}=2\mathop{\mathrm{tr}}(\Pi_+C\Pi_+)+2\mathop{\mathrm{tr}}(\Pi_0C\Pi_0)+\mathop{\mathrm{tr}}(\Pi_-(W_+^\#+W_-^\#)\Pi_-)$, which is §2.2's slack term for term.*

**So the answer to question 2 is: the equality clause characterises the critical points at which $\mathfrak p\oplus\mathfrak m=\mathop{\mathrm{ran}}W$ is a $\mathbb Z_2$-graded subalgebra of $\mathfrak{so}(n)$ with even part $\mathfrak p$**, equivalently $X_{\mathrm{inv}}=0$, equivalently $(\mathop{\mathrm{ran}}W,\mathop{\mathrm{ran}}W_+)$ is a symmetric pair. It says nothing whatever about $\mathfrak k$ beyond that $\mathop{\mathrm{ran}}W$ closes away from it.

### 4.3 Discrepancy D2, part one, *"exactly the condition defining a compact symmetric pair with $E_+$ the isotropy algebra"*

**Locate.** [results.md](../results.md):332, the canonical mirror, and [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex):77 in the same words:

> equality holds precisely when the eigenspace ranges are graded by the Lie bracket, which is exactly the condition defining a compact symmetric pair with $E_+$ the isotropy algebra.

**Exhibit the failure, in each direction and at a named object.**

- **Forward, under the reading "$(\mathfrak{so}(n),E_+)$ is a symmetric pair".** $W_{\mathbb{CP}^2}$ at $n=4$ attains equality exactly (§2.4c) with $\dim E_+=1$, $\dim E_-=2$, $\dim\ker W=3$. $E_+\oplus E_-=\Lambda^2_+\cong\mathfrak{so}(3)$ is $3$-dimensional inside a $6$-dimensional $\mathfrak{so}(4)$, so $\mathfrak{so}(4)\ne E_+\oplus E_-$ and $(\mathfrak{so}(4),E_+)$ is no pair. Nor is the $1$-dimensional $E_+$ the isotropy algebra of $\mathbb{CP}^2$, which is the $4$-dimensional $\mathfrak u(2)$. **The forward direction fails at the block's own first-named equality point.**
- **Forward, under the reading "$(E_+\oplus E_-,E_+)$ is a symmetric pair".** Here the clause is **true**, and is exactly [L155](../findings/bounds.md): at $W_{\mathbb{CP}^2}$ the pair is $(\mathfrak{so}(3),\mathfrak{so}(2))$. *This reading is the one [L155](../findings/bounds.md) and [results.md:345](../results.md) actually state, so the sentence is not false in every reading, the "isotropy algebra" gloss is what selects the false one.*
- **Converse, under both readings.** A symmetric pair yields equality only when $W$'s own spectral splitting *is* that pair. [Lemma L23](../findings/ungraded-slack.md) makes the gap concrete: within the subalgebra family a symmetric pair is critical only at the cap $r=n(n-2)/4$, and $\mathfrak{so}(5)\oplus\mathfrak{so}(7)\subset\mathfrak{so}(12)$ is a symmetric pair at $r=31$ against the cap $30$. **So "the symmetric pairs" is strictly the wider class.**

**Argue the opposite.** The most charitable reading is the abstract-sub-pair one, under which the forward half stands. It does not save the sentence: the words are *"exactly the condition defining"*, a biconditional, and the converse fails under every reading; and the "isotropy algebra" gloss points at $\mathfrak{so}(n)$'s isotropy, not the sub-pair's. **Real.**

### 4.4 Discrepancy D2, part two, *"it fails strictly at the low-value ones"*

**Locate.** The next clause of the same two sentences, [results.md](../results.md):332 and [report 07:77](../report/sections/07-gradedness-split.tex).

**Exhibit.** $S^2\times S^4$ at $n=6$ attains equality with $\theta^2=15/16$, i.e. $\theta=0.968246<1$, below $1$, and $\theta^2=15/16$ against $\theta_0(6)^2=10/9$ puts it below the balanced product at its own $n$ as well. *This is the record's own witness ([bounds.md:59](../findings/bounds.md), [INDEX-results.md:22](../findings/INDEX-results.md), [lean/INDEX.md:179](../lean/INDEX.md)) and rests on [r516](../reviews/REVIEW_r516.md)'s screen, which I do not re-run; I check only that $\sqrt{15/16}=0.968246$ and that its structure is consistent, $E_+=\mathfrak{so}(2)\oplus\mathfrak{so}(4)$ with $(\mathfrak{so}(6),\mathfrak{so}(2)\oplus\mathfrak{so}(4))$ a symmetric pair, so equality is what §4.2 predicts.* **A structural argument that needs no screen at all**: for the whole subalgebra family $W\propto\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ one has $\mathfrak p=\mathfrak h$ and $\mathfrak m=\mathfrak h^\perp$ with $\ker W=0$, so equality holds iff $(\mathfrak{so}(n),\mathfrak h)$ is a symmetric pair, which is a condition on $\mathfrak h$ alone and carries no information about $\theta$.

**Argue the opposite.** One could read *"the low-value ones"* as naming only the specific low-value points the record had catalogued, not all of them. The sentence's own construction, *"Every known critical point with value above $1$ satisfies it … and it fails strictly at the low-value ones"*, is a dichotomy over the catalogue, and a catalogued equality point below $1$ breaks it as written. **Real.**

**Both halves of D2 are already refuted inside [bounds.md](../findings/bounds.md)'s own box at line 59. Neither correction has reached [results.md](../results.md):332 or [report 07:77](../report/sections/07-gradedness-split.tex).** This is precisely the record's named trap: the correction sits beside the statement it corrects, in a different file, and the citation inherits the defect.

## 5. Question 3, which hypotheses the proof uses, and how often

### 5.1 Each use, against its object

| use | where | object |
| --- | --- | --- |
| H1, $Q(W)=\theta W$ | §2.1, the partial trace | $W$, the strong operator form is needed; the bracket form $[W,Q(W)]=0$ is strictly weaker ([conventions.md](../findings/conventions.md)) and would not give the identity |
| H1 again | §4.2, $\Pi_0W^\#\Pi_0=0$ | $W$, this second use belongs to the **equality clause**, not to the inequality |
| H2, $\mathrm{Ric}(W)=0$ | §2.3, $\mathrm{Ric}(W_+)=\mathrm{Ric}(W_-)$ | $W$; applied through linearity of $\mathrm{Ric}$ to $W_+-W_-$ |
| H3, $\mathrm{Alt}(W)=0$ | §2.3, $\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$ | $W$; likewise |

**Neither H2 nor H3 is applied to $W_\pm$**, which is the point: L15's identity is what covers operators that fail both.

### 5.2 *"the last two used twice each in the final step"*, route-dependent, and withdrawn as a defect

**Locate.** [bounds.md](../findings/bounds.md):53.

**Exhibit.** On the block's own stated route, *"Polarising [L15](../findings/problem.md)'s identity at $(W_+,W_-)$"*, the polarised right-hand side is $\langle\mathrm{Ric}W_+,\mathrm{Ric}W_-\rangle+6\langle\mathrm{Alt}W_+,\mathrm{Alt}W_-\rangle$, and reaching $\lVert\mathrm{Ric}W_-\rVert^2+6\delta^2$ takes **one** substitution from each hypothesis. Not two.

**Argue the opposite.** The same final step can be run depolarised, as [r516](../reviews/REVIEW_r516.md) F3 does: $2\mathop{\mathrm{tr}}(W_+\#W_-)=\mathop{\mathrm{tr}}W_+^\#+\mathop{\mathrm{tr}}W_-^\#-\mathop{\mathrm{tr}}W^\#$, then L15 at $R=W$ (H2 and H3 kill both defect terms, giving $\mathop{\mathrm{tr}}W^\#=-\mathop{\mathrm{tr}}W^2$) and L15 at $W_+$ and $W_-$ (H2 and H3 again, giving $\mathop{\mathrm{tr}}Q(W_+)=\mathop{\mathrm{tr}}Q(W_-)$). **Along that route each is used exactly twice**, and the block does not fix the order of operations inside "the final step". *I checked the two routes agree: the depolarised one returns $2\mathop{\mathrm{tr}}(W_+\#W_-)=2\mathop{\mathrm{tr}}(W_-^\#)+2\mathop{\mathrm{tr}}(W_-^2)=\mathop{\mathrm{scal}}(Q(W_-))$, using $\mathop{\mathrm{tr}}W^2=\mathop{\mathrm{tr}}W_+^2+\mathop{\mathrm{tr}}W_-^2$, which is §2.3's answer.* **The candidate fails the third step and is WITHDRAWN**: the count is a property of the route, both counts are right on their own route, and nothing in the record rests on the figure.

### 5.3 Properties used and not named

- **$W_+W_-=0$.** Used twice, for $\mathop{\mathrm{tr}}(\Pi_-W^2)=\mathop{\mathrm{tr}}(W_-^2)$ in §2.1 and to kill $\mathop{\mathrm{scal}}(W_+W_-+W_-W_+)$ in §2.3. It is automatic for spectral parts, so it is an omission of bookkeeping rather than of hypothesis. Worth naming because it is the one place the argument would break for a non-spectral splitting of $W$ into PSD pieces.
- **$\mathop{\mathrm{scal}}=2\mathop{\mathrm{tr}}_{\Lambda^2}$.** Load-bearing: it is what matches §2.3's $\mathop{\mathrm{scal}}(W_+\#W_-)$ to §2.2's $2\mathop{\mathrm{tr}}(W_+\#W_-)$, and it is where the surviving coefficient $6$ is decided. **It is not in [conventions.md](../findings/conventions.md)**, which is the record's own designated home for such a normalisation; [r515](../reviews/REVIEW_r515.md) reported the same absence and it has not been fixed. *A consumer working in $\mathop{\mathrm{scal}}=\mathop{\mathrm{tr}}$ would read the constant as $3$.*
- **$W_-\succeq0$.** Load-bearing for C2 (§2.1), and the block does not name it. The block is formally within [bounds.md](../findings/bounds.md)'s policy of quoting conventions rather than restating them, and [conventions.md](../findings/conventions.md) pins the sign globally, but that same file records that a collision between the two signs *"refuted four lemmas in one day … bites only where a one-sided inequality is applied"*, and L7 is a one-sided inequality whose left-hand side is exactly the sign-sensitive part. **The clarification the block does give, *"$W_\pm$ … as operators on all of $\Lambda^2$, so that $\mathrm{Ric}(W_-)$ has its usual meaning"*, is correct, necessary, and absent from [results.md:330](../results.md).**
- **$\Pi_-\succeq0$**, as distinct from $\Pi_-\preceq I$; see §2.2.

**Answer to question 3.** Criticality once (twice if the equality clause is counted); Ricci-flatness and first Bianchi once each on the block's route, twice each on the depolarised one; and three further properties above that the block uses without naming, of which the sign convention is the one with a live failure mode.

## 6. The three forms, and the Lean row

| site | what it says | verdict |
| --- | --- | --- |
| [findings/bounds.md:43–59](../findings/bounds.md) | statement, proof, hypotheses, equality clause with the kernel-closure sentence, and a box refuting the symmetric-pair reading | **the good copy**, one wrong constant (D1), one route-dependent count (C8) |
| [results.md:326–334](../results.md) | statement + ingredient list + equality clause | **defective**: carries C6 and C7 verbatim, omits the box, omits the *"operators on all of $\Lambda^2$"* clarification, and gives no proof under a heading that promises none, the ingredient list is accurate |
| [results.md:122](../results.md) | *"equality exactly where the eigenspace ranges are bracket-graded **modulo $\ker W$**, which is wider than the compact symmetric pairs"* | **stale, and correct in direction.** *"Wider than the symmetric pairs"* is right; *"modulo $\ker W$"* is the superseded reason, retired by [L155](../findings/bounds.md), whose closure clause says the kernel does **not** stay outside. The live reason is that $\mathop{\mathrm{ran}}W$ is a proper subalgebra. *The companion clause ("A companion closed form pins such a point by its pair's dimensions alone"), is clear: the closed form is [L23](../findings/ungraded-slack.md)'s and the word "companion" says so. The earlier miscite at [graded-half.md:201](../findings/graded-half.md) that [r515](../reviews/REVIEW_r515.md) and [r516](../reviews/REVIEW_r516.md) both flagged is repaired; that line now carries the $\mathbb{HP}^m$ closed form.* |
| [lean/INDEX.md:179](../lean/INDEX.md) | **the row exists**, state `partial` | **stale, D3** |

**Discrepancy D3.** *Locate:* [lean/INDEX.md](../lean/INDEX.md):179 lists as **Owed** *"the inequality itself, and that the bracket-grading conditions hold **modulo $\ker W$**, which is what makes the compact-symmetric-pair reading false in both directions"*. *Exhibit:* [L155](../findings/bounds.md)'s own row eight lines below, [lean/INDEX.md](../lean/INDEX.md):187, says *"it clears two debts on L7: the 'modulo $\ker W$' hedge this index recorded as owed is **retired**"*. So the L7 row states as owed a claim the record now holds to be false, and gives as the reason for the symmetric-pair failure a mechanism that has been withdrawn. *Argue the opposite:* an "Owed" entry is a statement about what the **Lean file** proves, not about the mathematics, so leaving it could be read as an honest formalisation debt. It cannot: the row asserts the mathematical content *"the bracket-grading conditions hold modulo $\ker W$"* in its own voice and builds the falsity verdict on it. **Real, low severity, and the same shape as D2: the correction landed in the neighbouring row rather than in this one.**

**What the L7 Lean row would have to claim to be current.** That the machine-checked part is the arithmetic of the named equality points ($\theta^2(S^2\times S^4)=15/16$, and $\tfrac43=\tfrac23+6\cdot\tfrac19$ at $W_{\mathbb{CP}^2}$), and that what remains owed is (a) the inequality itself, and (b) the equivalence of equality with $\mathop{\mathrm{ran}}W$ being a $\mathbb Z_2$-graded subalgebra, with the reason the symmetric-pair reading fails restated as *"$\mathop{\mathrm{ran}}W$ is a proper subalgebra when $\ker W\ne0$"*, not as a kernel-modularity of the conditions.

## 7. Quantifier order, scope, and every edge of the range

**Quantifier order.** *For every $n\ge4$, for every $W\in\mathcal W_n$ and $\theta\in\mathbb R$ with $Q(W)=\theta W$: the displayed inequality holds*, with $\delta^2$ and $\mathrm{Ric}(W_-)$ read at that $W$. There is no hidden existential and no uniformity claim: the bound is per-point, and only the constant $6$ is uniform, over $n$ as well, since no step in §2 sees the dimension.

| edge | status |
| --- | --- |
| **smallest admissible $n$** | $n=4$. $\mathcal W_n=0$ for $n\le3$, so there is nothing below. Every step holds at $n=4$, where $\Lambda^4$ is one-dimensional and $\mathrm{Alt}$ is the projection onto $\star$, and $n=4$ is where my anchor computation lives, so the smallest case is the one checked hardest |
| **odd $n$** | **no exposure.** Nothing in the statement or the proof involves $\theta_0(n)$ or $\Theta_n$, which is where the record's odd-$n$ trap lives; no step uses a parity, a balanced split, or a dimension count |
| **$\ker W\ne0$** | **admissible and realised.** $W_{\mathbb{CP}^2}$ has $\dim\ker W=3$ of $6$ and attains equality. $\Pi_-$ never touches the kernel, and the kernel enters only through §4.2's third equality condition. *This is the case in which the mirror's equality clause is false, so it is the edge that matters* |
| **$W_-=0$** | **vacuous, and provably so.** $W\in\mathcal W_n$ has $\mathop{\mathrm{scal}}(W)=0$, hence $\mathop{\mathrm{tr}}W=0$; with $W\succeq0$ that forces $W=0$. So both spectral parts are nonzero at every $W\ne0$, and the degenerate reading of the bound ($0\le0$) occurs only at $W=0$, where it is true and empty. Symmetrically $W_+\ne0$ |
| **$\theta\le0$** | **admissible, and the block is right that there is no sign condition**, no step in §2 uses $\theta>0$. The bound is then weak: the left side can be negative. See §8.6 for a critical point with $\theta<0$ at which the inequality is strict by $5/3$ |
| **unit norm** | **not needed, and the block is right.** Under $W\mapsto cW$, $c>0$, $Q(cW)=c^2\theta W=(c\theta)(cW)$, so the multiplier is $c\theta$ and every term on both sides scales by $c^2$. The statement is homogeneous once $\theta$ is read as the multiplier rather than as $P/\lVert W\rVert^3$ |

## 8. A universal claim, tried at one object from each structured family

**"At every critical point" is a universal claim with no witness attached in the block.** I tried one object from each family the record names. *Nothing below is a screen: each is a closed-form or structural evaluation.*

1. **Sphere products.** $S^p\times S^q$ sits in [L23](../findings/ungraded-slack.md)'s family $W\propto\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ with $\mathfrak h=\mathfrak{so}(p)\oplus\mathfrak{so}(q)$, so $\mathfrak p=\mathfrak h$, $\mathfrak m=\mathfrak h^\perp$, $\ker W=0$. $(\mathfrak{so}(n),\mathfrak{so}(p)\oplus\mathfrak{so}(q))$ is the real Grassmannian symmetric pair, so all three inclusions hold and §4.1 gives **equality**. $\delta^2=0$, because $\mathfrak m$ is spanned by the mixed coordinate $2$-planes, which are decomposable, and $\mathrm{Alt}(vv^{\mathsf T})\propto v\wedge v$ ([ATTEMPTS.md](../ATTEMPTS.md):1045). So L7 reads $\theta\mathop{\mathrm{tr}}(W_-)+\mathop{\mathrm{tr}}(W_-^2)=\lVert\mathrm{Ric}(W_-)\rVert^2$ here. **This is the family on which the headings' symmetric-pair reading is true**, which is presumably how it came to be written.
2. **$\mathbb{CP}^m$.** At $m=2$: equality, verified in full by hand in §2.4(c), with the pair $(\mathfrak{so}(3),\mathfrak{so}(2))$ inside $\mathfrak{so}(4)$. **At $m\ge3$ the record's claim that $\mathbb{CP}^3$ satisfies the equality condition ([results.md:332](../results.md)) rests on a measured slack**, [nondegeneracy.md](../findings/nondegeneracy.md):407 reports the slack *"returns exactly $0$ at $\mathbb{CP}^3$, $\mathbb{CP}^4$ and $\mathbb{CP}^5$"*. That is a computation, so under this programme's own footing it is an open hypothesis and not evidence; **no argument that $\mathop{\mathrm{ran}}W_{\mathbb{CP}^m}$ is a graded subalgebra is on file for $m\ge3$**, and the $m=2$ structure does not generalise on its face, $\mathop{\mathrm{ran}}W$ there being $\mathfrak{so}(3)$ rather than $\mathfrak u(2)$.
3. **Padded objects.** $W_{\mathbb{CP}^2}\oplus0$ at any $n\ge4$. Padding commutes with $Q$ and preserves $\theta$ and the norm; $\mathop{\mathrm{ran}}W$ is unchanged, so the grading survives and **equality holds at every $n$**. Both sides are unchanged: $\mathrm{Ric}$ of the padded operator has the same Frobenius norm, and $\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$ vanishes unless all four indices lie in the original block, so $\delta^2=\tfrac19$ at every ambient dimension, matching [problem.md:362](../findings/problem.md)'s *"whose defect is exactly $1/9$ in every ambient dimension"*. So $\tfrac43=\tfrac43$ at every $n\ge4$, with $\dim\ker W=\binom n2-3$.
4. **Subalgebra Casimirs.** $\mathfrak h=\mathfrak{su}(3)\subset\mathfrak{so}(8)$, $r=8$, $N=28$: [L4](../results.md)'s closed form gives $\theta^2=\tfrac4{n^2}\cdot\tfrac{rN}{N-r}=\tfrac1{16}\cdot\tfrac{224}{20}=\tfrac7{10}$, $\theta=0.836660$. [L155](../findings/bounds.md) records that this point **fails exactly $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p$**, since $\Lambda^2\mathbf8=\mathbf8\oplus\mathbf{10}\oplus\overline{\mathbf{10}}$ makes $\mathfrak m$ a submodule while no involution of $\mathfrak{so}(8)$ has an $8$-dimensional fixed algebra. So **the inequality is strict here**, a witness on the strict side, with trivial kernel.
5. **An object with $\ker W\ne0$.** $W_{\mathbb{CP}^2}$ itself, $\dim\ker W=3$. **Equality holds with a kernel carrying half the algebra**, which is exactly what refutes C6.
6. **A sign witness, which the record does not carry.** $-W_{\mathbb{CP}^2}$ is critical with multiplier $-\theta=-\sqrt{3/2}$, since $Q(-W)=Q(W)=\theta W=(-\theta)(-W)$. Its spectral parts swap: $(-W)_-=W_+=2\varepsilon u_1u_1^{\mathsf T}$. Left side $=-3\varepsilon\cdot2\varepsilon+4\varepsilon^2=-2\varepsilon^2=-\tfrac13$; right side $=\lVert\mathrm{Ric}(W_+)\rVert^2+6\lVert\mathrm{Alt}(W_+)\rVert^2=\tfrac23+6\cdot\tfrac19=\tfrac43$. **Strict, by $\tfrac53$**, and §4.1 predicts it, since the even part would have to be $\mathop{\mathrm{span}}(u_2,u_3)$ and $[u_2,u_3]=\pm\sqrt2u_1$ leaves it. **So the critical set is symmetric under $W\mapsto-W$ and the equality class is not**, which is a further reason the equality class cannot be read as a property of a pair of subalgebras alone: it is a property of the *ordered* splitting.

**No falsifier of the inequality was found in any family.**

## 9. The gap between what is proven and what is used, and what a consumer may cite

**May be cited, from [bounds.md:43–59](../findings/bounds.md):**

- The inequality, at every critical point of every $n\ge4$, with no unit-norm and no sign hypothesis, and with the hypotheses $Q(W)=\theta W$ and $W\in\mathcal W_n$.
- Its slack form, $S(W):=\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2-\theta\mathop{\mathrm{tr}}(W_-)-\mathop{\mathrm{tr}}(W_-^2)\ge0$, as [results.md:391](../results.md) and [ungraded-slack.md:332](../findings/ungraded-slack.md) use it.
- $S(W)=\tfrac12\mathop{\mathrm{tr}}X_{\mathrm{inv}}$, and hence, through [L154](../findings/bounds.md)(i), that equality upgrades to the **operator** statement $X_{\mathrm{inv}}=0$.
- Equality $\iff$ $\mathop{\mathrm{ran}}W$ is a $\mathbb Z_2$-graded subalgebra of $\mathfrak{so}(n)$ with even part $\mathop{\mathrm{ran}}W_+$; equivalently, $(\mathop{\mathrm{ran}}W,\mathop{\mathrm{ran}}W_+)$ is a symmetric pair, **proper in $\mathfrak{so}(n)$ whenever $\ker W\ne0$**.
- That $\delta^2$ means in L7 what it means in [L15](../findings/problem.md), and that **only L15's surviving identity is consumed**.

**May not be cited:**

- *"a compact symmetric pair with $E_+$ the isotropy algebra"* in any form that puts the pair inside $\mathfrak{so}(n)$, and the biconditional in any form (C6).
- *"it fails strictly at the low-value ones"* (C7).
- The rank-one identity as [bounds.md:51](../findings/bounds.md) prints it (C4), take the $\tfrac12$ form from [ATTEMPTS.md](../ATTEMPTS.md):942.
- *"L7 is the trace of the matrix inequality $X_{\mathrm{inv}}\succeq0$"* as a statement of **strength**. The relation is true and useful, but a trace inequality does not imply the matrix one, and [lean/INDEX.md:179](../lean/INDEX.md) is right that *"a scalar statement does not strengthen into an operator one"*. [bounds.md:55](../findings/bounds.md) guards this correctly, [L154](../findings/bounds.md)(i) supplies the missing direction **only at $\mathop{\mathrm{tr}}X_{\mathrm{inv}}=0$**, and nowhere else.

**The gap.** The inequality is proven and its equality class is characterised. What is **not** on file, and is what the block's closing sentence (*"the graded one becomes a classification problem rather than an analytic one"*), needs, is a classification of the graded critical points. That would consume Cartan's classification of symmetric pairs, which [conventions.md](../findings/conventions.md) records as *"invoked in four findings files and cited to no source anywhere on the record; [references/](../references/) holds no Helgason or Cartan entry"*, and it would need the sub-pair version, since §4.2's pairs are subalgebras of $\mathfrak{so}(n)$, not $\mathfrak{so}(n)$ itself. **I confirm the absence: [references/](../references/) has no Cartan or Helgason entry.** Any consumer taking L7's equality class as "finitely many objects" rests on that unread source.

## 10. What would falsify these statements, and what I did to look

- **The inequality.** A critical $W\in\mathcal W_n$ with $\theta\mathop{\mathrm{tr}}(W_-)+\mathop{\mathrm{tr}}(W_-^2)>\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2$. By §2 such an object cannot exist unless one of three prior statements fails: $\#$ preserving the PSD cone, [L15](../findings/problem.md)'s identity, or $W_+W_-=0$. So a falsifier of L7 is a falsifier of L15, and the identity is anchored exactly at $\mathrm{Id}$, at $\star$ and at $W_{\mathbb{CP}^2}$ (§2.4). *Looked at: the six objects of §8, none violating.*
- **The equality clause as [bounds.md:57](../findings/bounds.md) states it.** A critical point attaining equality whose $\mathop{\mathrm{ran}}W$ is not a graded subalgebra, or a graded one that is strict. *Looked at: $W_{\mathbb{CP}^2}$ and its paddings (equality, graded), sphere products (equality, graded), $\mathfrak{su}(3)\subset\mathfrak{so}(8)$ (strict, ungraded), $-W_{\mathbb{CP}^2}$ (strict, ungraded, the sharpest test I could build by hand, since it inverts an equality point without leaving the critical set). None violating.*
- **C6 and C7.** Their falsifiers exist and are the record's own: $W_{\mathbb{CP}^2}$ and $S^2\times S^4$.
- **C4.** Falsified by any one of §3's three anchors.

**No computation was run in producing any of the above.**

## Verdict: **BROKEN**

**As the canonical statement stands at [results.md:326–334](../results.md) and at one printed constant in [bounds.md:51](../findings/bounds.md)'s proof. The inequality itself is PROVEN, and I re-derived it in full from the definitions.**

- **What is right.** The compression is an exact identity, the single inequality step is correct, the $6$ is [L15](../findings/problem.md)'s and is pinned by $W_{\mathbb{CP}^2}$ where no other constant closes; the hypothesis list is honest; the equality clause as [bounds.md](../findings/bounds.md) now states it, kernel closure included, is correct.
- **What is broken.** (D1) the rank-one identity in the proof paragraph is off by a factor $2$ against the record's four other printings and against three exact anchors, introduced by the very transcription that repaired the block's missing proof. (D2) the two clauses [bounds.md](../findings/bounds.md)'s own box refutes stand verbatim at [results.md:332](../results.md) and [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex):77, where a consumer meets them without the box. (D3) [lean/INDEX.md:179](../lean/INDEX.md) still owes and asserts the retired *"modulo $\ker W$"* reading.
- **Withdrawn.** The *"twice each"* count (C8): route-dependent, and true on the depolarised route.
- **Not a defect, and recorded.** $\mathop{\mathrm{scal}}=2\mathop{\mathrm{tr}}$ and the sign $W_-\succeq0$ are load-bearing and unstated in the block; the first is missing from [conventions.md](../findings/conventions.md) altogether, which [r515](../reviews/REVIEW_r515.md) also reported and which has not been fixed.
