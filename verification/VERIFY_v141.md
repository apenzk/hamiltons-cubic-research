# VERIFY v141, Lemma L70: the boxed deficiency identity, the sign of $D(v)$, and the saturation condition L71 consumes

*Verifier v141, [ROUND_L70](ROUND_L70.md), 2026-09-07. Worked cold from the brief and from the definitions in [conventions.md](../findings/conventions.md), [Lemma L153](../findings/bounds.md), [Lemma L31](../results.md), [Lemma L23](../findings/ungraded-slack.md) and relations (A)/(B)/(C) at [bounds.md](../findings/bounds.md). **No numerical work was performed and no script was run**: every value below is an exact hand evaluation, given in closed form. The programme is on an [analysis-only footing](../.claude/rules/analysis-only.md) and this round respected it in full. Log: [agent_logs/verify-L70-v141.log](../agent_logs/verify-L70-v141.log). No other verifier's report was read.*

## Claim table

| # | claim, as a consumer would read it | verdict |
| --- | --- | --- |
| C1 | the boxed identity $\theta=\lambda_{\min}+(n-2)\lambda_{\max}-D(v)/\lvert\lambda_{\min}\rvert$, at every critical point and every unit $v\in E_{\min}$ | **PROVEN** |
| C2 | $D(v)\ge0$ | **PROVEN**, under $\lambda_{\min}\le0\le\lambda_{\max}$, a **weaker** condition than the block's strict one |
| C3 | equality $\iff$ $\mathrm{ad}(v)$ supported on $E_{\min}\otimes E_{\max}$ | **PROVEN**, and here the strictness $\lambda_{\max}>0$ **is** needed |
| C4 | saturation forces $\dim E_{\min}\ge n/2$ and $\dim E_{\max}\ge(n-2)/2$ | **PROVEN**, argument on file at [r566](../reviews/REVIEW_r566.md) §4, **not** in either block |
| C5 | on [Lemma L23](../findings/ungraded-slack.md)'s family, saturation $\iff$ $(\mathfrak{so}(n),\mathfrak h)$ symmetric | **PROVEN** |
| C6 | *"What the identity does **not** need: unit norm"*, [bounds.md](../findings/bounds.md):224 | **BROKEN**, live, and contradicted two lines above it |
| C7 | *"The subtracted constant $\lambda_{\min}\lambda_{\max}$ is attained only on pairs containing the row index"*, [results.md](../results.md):583, unconditional | **BROKEN**, live; the repair both Gate 2 reviewers ordered landed in one file of the two |
| C8 | *"$m_1$, the minimum of $\lambda_a\lambda_b$ over the support"* together with *"the two coincide whenever $\lambda_{\min}$ has multiplicity at least $2$"* | **GAP**, true of [r566](../reviews/REVIEW_r566.md)'s $m_1$, unproven for the record's; witness below |
| C9 | the hypothesis printed as $\lambda_{\min}<0\le\lambda_{\max}$ at [results.md](../results.md):583 and :39 | **PROVEN, hypotheses corrected**: the equality clause needs $\lambda_{\max}>0$, which the same premises give |
| C10 | [lean/INDEX.md](../lean/INDEX.md):271, *"at padded `W_{ℂP²}` the deficiency **vanishes**"* | **BROKEN as labelled**: true at $n=4$, false at every $n\ge5$, where the deficiency is $(n-4)/3$ |
| C11 | [Lemma L71](../results.md) consumes exactly what L70 establishes | **PROVEN** |

**One line.** The mathematics of L70 (the identity, the sign, the equality case, the dimension theorem and the Lie reduction), is correct and I rebuilt every step by hand; what fails is two citable sentences standing beside it, one of them the hypothesis list, each already named by the record's own Gate 2 pair and each still readable today as the record's own voice. **Verdict: PROVEN, hypotheses corrected**, with C6, C7 and C10 named for repair.

## 0. Conventions, fixed once

Every item below is quoted from [conventions.md](../findings/conventions.md), which is the only place this round took a definition from.

- **$\theta=P(W)/\lVert W\rVert^3$**, and *"at a critical point, $Q(W)=\theta W$"*. The two agree only at $\lVert W\rVert=1$: $\langle W,Q(W)\rangle=\theta\lVert W\rVert^2$ against $P=\theta\lVert W\rVert^3$. **"Critical point" on this record means a critical point of $P$ restricted to the unit sphere**, [problem.md](../findings/problem.md):505 states the Lagrange condition as $Q(W)=\theta W$ with $\theta=P(W)$, so unit norm is carried by the phrase and not by an extra clause.
- **$Q(W)=W^2+W^\#$**, with $\#$ the halved Böhm–Wilking product $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$.
- **Structure constants** $c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric**, so $T_{abc}=c_{abc}^2$ is totally symmetric and vanishes when two indices coincide.
- **Sums over pairs run over ORDERED pairs** unless a line says otherwise. $D(v)$'s $\tfrac12$ is matched to that reading, and to $\sum_{a,b}c_{vab}^2=2(n-2)$ in the same reading.
- **A bivector's norm** is the half-trace one, $\lVert v\rVert^2=-\tfrac12\operatorname{tr}(v^2)$, under which $\{\varphi_{ab}\}_{a<b}$ is orthonormal and $\operatorname{tr}(v^2)=-2$ at a unit bivector.
- **The Killing form** of $\mathfrak{so}(n)$ is $B(X,Y)=(n-2)\operatorname{tr}(XY)$.
- **$\mathcal W_n$** is trace-free: Ricci-flatness with $\operatorname{scal}=2\operatorname{tr}$ on $\Lambda^2$ gives $\operatorname{tr}W=0$.
- **$\mathfrak m=E_{\min}$, $\mathfrak h=E_{\max}$, $\mathfrak r$ everything else, kernel included**, the sense [Lemma L71](../results.md) uses.

## 1. The hypothesis inventory

**A. The hypotheses the block carries, and where each is stated.**

| # | hypothesis | stated at | used by |
| --- | --- | --- | --- |
| H1 | $W$ is a **critical point**: $Q(W)=\theta W$ | both blocks' opening clause | the identity, via relation (C) |
| H2 | $\lVert W\rVert=1$ | [bounds.md](../findings/bounds.md):222 in bold; **denied** two lines later at :224; carried implicitly in [results.md](../results.md):583 by the record's definition of "critical point" | the identity, see §5 |
| H3 | $v$ is a **unit** vector of $E_{\min}(W)$ | both blocks | the identity; and the mass identity's $\lVert v\rVert^2$ factor |
| H4 | $\lambda_{\min}<0$ | [results.md](../results.md):583 as $\lambda_{\min}<0\le\lambda_{\max}$; [bounds.md](../findings/bounds.md):222 as $\lambda_{\min}<0<\lambda_{\max}$ | the division by $\lvert\lambda_{\min}\rvert$; without it the identity is not defined |
| H5 | $\lambda_{\max}\ge0$ | as above | $D\ge0$ (§4) |
| H6 | $\lambda_{\max}>0$ **strictly** | [bounds.md](../findings/bounds.md):222 only | the **equality characterisation** (§6) |
| H7 | $W\in\mathcal W_n$, i.e. $\operatorname{tr}W=0$ | both blocks, as the source of H4–H6 at $W\ne0$ | H4, H5, H6 |
| H8 | $\{v_a\}$ is an **orthonormal eigenbasis** of $W$ on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, containing $v$ | nowhere in either block | the eigenbasis expansion of $\langle v,W^\#v\rangle$; the row-index exclusion $c_{vvb}=0$ |

**H8 is unstated in both blocks and is load-bearing twice**: the expansion of $\langle v,W^\#v\rangle$ needs the basis to diagonalise $W$, and the excluded-index discussion needs $v$ to be one of its members. It is recoverable (an orthonormal eigenbasis containing a given unit eigenvector always exists) so this is an omission rather than a defect.

**B. The imported results, each checked against the object it is applied to.**

| import | what it says | the object here | applies? |
| --- | --- | --- | --- |
| **[Lemma L153](../findings/bounds.md)**, the Killing row marginal | $\sum_\beta\lVert[v,v_\beta]\rVert^2=2(n-2)\lVert v\rVert^2$ for **any** $v\in\mathfrak{so}(n)$, at every $n\ge2$ | a unit $v\in E_{\min}$, which is in general **not** a basis vector | **yes.** L153's quantifier was widened to arbitrary $v$ on 2026-09-05 *because of this consumer* ([bounds.md](../findings/bounds.md):319). I re-derived it: $\mathrm{ad}(v)$ is skew for an ad-invariant pairing, so $\sum_\beta\lVert\mathrm{ad}(v)v_\beta\rVert^2=-\operatorname{tr}(\mathrm{ad}(v)^2)=-B(v,v)=-(n-2)\operatorname{tr}(v^2)=2(n-2)\lVert v\rVert^2$. The provenance clause of that block was refuted at its own round; **the identity and its proof were confirmed**, and it is the identity this lemma consumes |
| **relation (C)** at [bounds.md](../findings/bounds.md):268 | $\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=2\lambda_k(\theta-\lambda_k)$ | the row $k=v$ | **yes**, it *is* criticality paired at $v$, and §2 rebuilds it from $Q(W)=\theta W$ directly |
| **[Lemma L31](../results.md)**, the pair cap | $\lVert[X,Y]\rVert^2\le2$ for orthonormal $X,Y\in\mathfrak{so}(n)$, with the equality case characterised | $(v,v_a)$, $v$ a unit non-basis vector of $E_{\min}$ and $v_a$ an eigenbasis vector orthogonal to it | **yes.** The landscape entry gives $\max_Y\lVert[X,Y]\rVert^2=(s_1+s_2)^2$ from the root system; at $\lVert X\rVert^2=\sum_is_i^2=1$ this is $\le2(s_1^2+s_2^2)\le2$, so the cap holds against **every** unit $Y$ and the orthonormality is not the binding part. Used only in §7's dimension theorem |
| **[Lemma L23](../findings/ungraded-slack.md)**'s family | $W=\Pi_{\mathfrak h}-\tfrac rNI$, and the admissibility cap | §8's reduction | **yes**, and §8 rebuilds the reduction without it; L23 enters only at the last step, naming which symmetric pairs are critical |

**C. Which hypotheses the written proof uses.** The derivation of the boxed identity uses **H1, H2, H3, H4, H8 and L153**, and nothing else. $D\ge0$ uses **H4 and H5** (§4 shows H6 is not needed for the sign). The equality characterisation uses **H4 and H6**. The dimension theorem uses **L31, L153 and H3** and no criticality beyond what puts $v$ in $E_{\min}$. **H7 is used only to supply H4–H6**, so a reader granting the sign conditions directly needs no Weyl membership for the identity, which is what the block's *"does not need Weyl membership"* correctly says, and is the one item of that list that survives §5.

## 2. Question 1, does the identity hold, and which hypothesis does each step use?

**It holds. Here is the derivation, step by step, with the hypothesis each step spends.**

**Step 1, criticality at the row $v$.** $Q(W)=W^2+W^\#=\theta W$ (**H1**, and **H2** for the constant to be $\theta$ rather than $\theta\lVert W\rVert$). Pair against a unit $v\in E_{\min}$ (**H3**):

$$\lambda_{\min}^2+\langle v,W^\#v\rangle=\theta\lambda_{\min}.$$

**Step 2, the eigenbasis expansion.** With $W=\sum_a\lambda_av_av_a^{\mathsf T}$ in an orthonormal eigenbasis (**H8**) and $\#$ the halved product,

$$W^\#=\tfrac12\sum_{a,b}\lambda_a\lambda_b\,[v_a,v_b][v_a,v_b]^{\mathsf T},\qquad \langle v,W^\#v\rangle=\tfrac12\sum_{a,b}\lambda_a\lambda_b\,\langle v,[v_a,v_b]\rangle^2=\tfrac12\sum_{a,b}\lambda_a\lambda_b\,c_{vab}^2,$$

the last equality by total antisymmetry, which makes $\langle[v_a,v_b],v\rangle=\langle[v,v_a],v_b\rangle=c_{vab}$. *This display is on the record at [bounds.md](../findings/bounds.md):190, under the heading "the walk identity at the $\lambda_{\min}$ eigenvector", twenty-six lines above the lemma that consumes it and cited from it by neither block. It is the same statement as relation (C) at [bounds.md](../findings/bounds.md):268, read at the row $v$.*

**Step 3, spend the fixed mass.** Split the constant off against $\sum_{a,b}c_{vab}^2=2(n-2)$ (**L153** at the unit vector $v$, **H3** supplying $\lVert v\rVert=1$, ordered pairs):

$$\tfrac12\sum_{a,b}\lambda_a\lambda_b\,c_{vab}^2\;=\;\underbrace{\tfrac12\sum_{a,b}\big(\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max}\big)c_{vab}^2}_{=\,D(v)}\;+\;\tfrac12\lambda_{\min}\lambda_{\max}\cdot2(n-2).$$

**Step 4, divide.** Substituting into Step 1, $D(v)+(n-2)\lambda_{\min}\lambda_{\max}=\theta\lambda_{\min}-\lambda_{\min}^2$. Dividing by $\lambda_{\min}<0$ (**H4**) and using $\lambda_{\min}=-\lvert\lambda_{\min}\rvert$ on the middle term,

$$\theta=\lambda_{\min}+(n-2)\lambda_{\max}-\frac{D(v)}{\lvert\lambda_{\min}\rvert}. \qquad\blacksquare$$

**Which hypothesis does what, stated plainly.** Criticality enters once, at Step 1, and is the only place it enters. The choice of $v$ enters twice: at Step 1, where $Wv=\lambda_{\min}v$ turns $\langle v,W^2v\rangle$ into $\lambda_{\min}^2$ and $\langle v,Wv\rangle$ into $\lambda_{\min}$; and at Step 4, where $\lambda_{\min}<0$ is what makes the division flip the sign of the correction. The **spectral hypothesis** enters nowhere in the identity, the identity holds with $\lambda_{\min}\lambda_{\max}$ replaced by *any* constant, and the spectral hypothesis is spent entirely on the **sign** of $D$ (§4) and on its **equality case** (§6). The **mass identity** enters once, at Step 3, and is the sole source of the $n$-dependence: it is what turns a constant into $(n-2)\lambda_{\max}$.

**No finding: the derivation is on the record**, in the same file as the lemma, at [bounds.md](../findings/bounds.md):190 and :268. Neither the [bounds.md](../findings/bounds.md) block nor [results.md](../results.md):583 links to it; [r566](../reviews/REVIEW_r566.md) §1 recorded that as a repair owed and it has not been made. That is a citation debt, not a hypothesis debt.

## 3. The "for every unit $v\in E_{\min}$" quantifier is a conclusion, not a hypothesis

At a critical point $W^\#=\theta W-W^2$, so $W^\#$ is a polynomial in $W$ and acts on the eigenspace $E_a$ by the scalar $\theta\lambda_a-\lambda_a^2$. Hence $\langle v,W^\#v\rangle=\theta\lambda_{\min}-\lambda_{\min}^2$ for **every** unit $v\in E_{\min}$, and by Step 4

$$D(v)=\lvert\lambda_{\min}\rvert\big(\lambda_{\min}+(n-2)\lambda_{\max}-\theta\big)$$

is **the same number for every unit $v\in E_{\min}$**, it depends on $(\theta,\lambda_{\min},\lambda_{\max})$ alone. Two consequences a consumer needs and only one of which the blocks state:

- The universal quantifier costs nothing: verifying the identity at one unit $v\in E_{\min}$ verifies it at all of them. [bounds.md](../findings/bounds.md):258 says exactly this and **derives** it; the derivation is sound and needs no measurement, though the block reports a measured spread beside it.
- **$D(v)=0$ at one unit $v\in E_{\min}$ forces $D(v)=0$ at every unit $v\in E_{\min}$.** This is what licenses [Lemma L71](../results.md) to consume the *scalar* condition $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$ and read off a statement about all of $\mathfrak m$ (§11). Neither block says so where L71 can see it.

## 4. Question 2, is $D(v)\ge0$, and under exactly what condition?

**The factor, pair by pair.** Every eigenvalue lies in $[\lambda_{\min},\lambda_{\max}]$, so the question is the minimum of the bilinear $xy$ over the square $[\lambda_{\min},\lambda_{\max}]^2$. A bilinear function on a box attains its extrema at corners, and the three corner values are $\lambda_{\min}^2$, $\lambda_{\max}^2$ and $\lambda_{\min}\lambda_{\max}$. So

$$\min_{a,b}\lambda_a\lambda_b=\lambda_{\min}\lambda_{\max}\iff \lambda_{\min}\lambda_{\max}\le\lambda_{\min}^2\ \text{and}\ \lambda_{\min}\lambda_{\max}\le\lambda_{\max}^2\iff\lambda_{\min}\lambda_{\max}\le0\iff\lambda_{\min}\le0\le\lambda_{\max}.$$

**Checked against the three cases the brief names, each directly rather than through the corner argument:**

| pair $(a,b)$ | the factor $\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max}$ | why it is $\ge0$ |
| --- | --- | --- |
| both positive | $\lambda_a\lambda_b>0\ge\lambda_{\min}\lambda_{\max}$ | a positive minus a non-positive |
| both negative | $\lambda_a\lambda_b>0\ge\lambda_{\min}\lambda_{\max}$ | the same |
| mixed, $\lambda_a<0<\lambda_b$ | $\lambda_a\lambda_b\ge\lambda_{\min}\lambda_b\ge\lambda_{\min}\lambda_{\max}$ | first step: $\lambda_a\ge\lambda_{\min}$ times $\lambda_b>0$; second: $\lambda_{\min}<0$ times $\lambda_b\le\lambda_{\max}$ |
| either index in $\ker W$ | $0-\lambda_{\min}\lambda_{\max}\ge0$ | $\lambda_{\min}\lambda_{\max}\le0$ |

With $c_{vab}^2\ge0$ as the weight, **$D(v)\ge0$**. $\blacksquare$

**So the block's stated condition is stronger than the sign needs.** *"provided $\lambda_{\min}<0<\lambda_{\max}$ strictly"* ([bounds.md](../findings/bounds.md):222) is sufficient; the sharp condition for the sign is $\lambda_{\min}\le0\le\lambda_{\max}$, which is what [results.md](../results.md):583's $\lambda_{\min}<0\le\lambda_{\max}$ already grants. **No finding on the sign**, the block is conservative, not wrong. The strictness is genuinely needed one clause later, at the equality characterisation (§6), and the block's own parenthesis says so: *"the equality characterisation needs the strict inequality"*.

**What fails when the strictness fails, the identity, the sign, or both.** Four regimes, and they answer differently:

| regime | the identity | the sign | the equality characterisation |
| --- | --- | --- | --- |
| $\lambda_{\max}<0$, all-negative spectrum | **holds**, it is Steps 1–4, which never look at $\lambda_{\max}$'s sign | **fails**: the true minimum product is $\lambda_{\max}^2<\lambda_{\min}\lambda_{\max}$, so factors go negative | fails |
| $\lambda_{\max}=0$ | **holds** | **holds**, $\lambda_{\min}\lambda_{\max}=0$ is still the corner minimum | **fails**: $D=0$ then says only that the mass sits on pairs meeting $\ker W$ |
| $\lambda_{\min}=0$ | **undefined**, Step 4 divides by zero | vacuous | vacuous |
| $\lambda_{\min}>0$ | undefined | fails | fails |

**Verified by hand at the block's own counterexample.** $\lambda=(-0.684,-0.570,-0.456)$: $\lambda_{\min}\lambda_{\max}=0.684\times0.456=0.311904$, while the true minimum product is $\lambda_{\max}^2=0.456^2=0.207936$. The gap $0.103968$ is the amount by which a factor on the pair $(\lambda_{\max},\lambda_{\max})$ goes negative. The block's two printed values, $0.208$ and $0.312$, are these rounded, and are correct.

**On $\mathcal W_n$ none of the failing regimes occurs**, and the block's stated reason is right: $\operatorname{tr}W=0$ at $W\ne0$ forces a strictly negative and a strictly positive eigenvalue at once. *So the failure regimes are reachable only by dropping H7, which is exactly what the list at [bounds.md](../findings/bounds.md):224 invites a reader to do when it says Weyl membership is not needed, and there the invitation is sound only because H4–H6 are then carried as hypotheses in their own right.*

## 5. C6, the hypothesis list still denies the hypothesis the same paragraph asserts

**Locate.** [findings/bounds.md](../findings/bounds.md):224, inside the blockquote, verbatim: *"What the identity does **not** need: unit norm, Weyl membership, $\theta>0$, or $n\ge5$."* Two lines above, at :222: *"**And it needs $\lVert W\rVert=1$**: under [conventions.md](../findings/conventions.md)'s $\theta=P(W)/\lVert W\rVert^3$ the left side is scale-invariant while the right is homogeneous of degree one, so the identity holds at one scale only. *The list of what the identity does not need carried "unit norm" until this audit*."* **The list still carries it.** The sentence announcing the repair and the unrepaired sentence sit in one paragraph, four lines apart, and the parenthetical says the repair was made.

**Exhibit, at a named object, in exact arithmetic.** Take $W_{\mathbb{CP}^2}$ at $n=4$, spectrum $(2,-1,-1,0,0,0)/\sqrt6$ on $\Lambda^2\mathbb R^4$, which is a critical point and saturates the identity ($D=0$, §9). Scale it by $s=2$, giving $W'=2W$ with spectrum $(4,-2,-2,0,0,0)/\sqrt6$.

- Left side: $\theta(W')=P(W')/\lVert W'\rVert^3=8P(W)/(8\lVert W\rVert^3)=\theta(W)=\sqrt{3/2}$.
- Right side: $\lambda_{\min}'+(n-2)\lambda_{\max}'-D'/\lvert\lambda_{\min}'\rvert=-\tfrac2{\sqrt6}+2\cdot\tfrac4{\sqrt6}-0=\tfrac6{\sqrt6}=\sqrt6$.

$\sqrt6=2\sqrt{3/2}$ exactly: the identity fails by a factor of $2$, which is $s$. **The two sides differ at every $s\ne1$**, and the list says the identity survives the difference.

**Argue the opposite, the most charitable reading the words support.** Read $\theta$ as the *criticality eigenvalue* $\theta_c$ defined by $Q(W)=\theta_cW$ rather than as $P/\lVert W\rVert^3$. Then $Q(sW)=s^2Q(W)=s\theta_c\,(sW)$, so $\theta_c$ is homogeneous of degree one, both sides scale as $s$, and the identity does hold at every scale, the list would be right. That is the reading [r323](../reviews/REVIEW_r323.md) and [r324](../reviews/REVIEW_r324.md) took, which is how the omission propagated. **But it is not the record's $\theta$**: [conventions.md](../findings/conventions.md) fixes $\theta=P(W)/\lVert W\rVert^3$ and reconciles the two only *at a critical point*, where the record's critical points are unit by definition ([problem.md](../findings/problem.md):505). Under the symbol as the record defines it, the list is false. **The charitable reading rescues the mathematics and not the sentence.**

**Status.** Already found: [r566](../reviews/REVIEW_r566.md) D4, and [LEDGER.md](../findings/LEDGER.md):1459 tabulates it under *"the least reliable sentence in a block is the list of what it does not need"*. **It is still on the record, in the citable text, and it is the only place in either block where a reader learns the identity's scale hypothesis one way or the other.** The other three items of the list survive audit: Weyl membership is dispensable if H4–H6 are hypothesised directly (§1C); $\theta>0$ is used nowhere; and $n\ge5$ is used nowhere, the identity holds at $n=4$, where §9's witness sits.

## 6. Question 3, what saturates it, exactly

**The minimiser is unique, and that is the whole content of the equality case.** Suppose $\lambda_{\min}<0<\lambda_{\max}$ (**H4** and **H6**) and $\lambda_a\lambda_b=\lambda_{\min}\lambda_{\max}<0$. The product is negative, so the two factors have opposite signs; say $\lambda_a<0<\lambda_b$. Then $\lvert\lambda_a\rvert\lambda_b=\lvert\lambda_{\min}\rvert\lambda_{\max}$ with $\lvert\lambda_a\rvert\le\lvert\lambda_{\min}\rvert$ and $\lambda_b\le\lambda_{\max}$, and a product of two factors each bounded above meets its bound only when both do: $\lambda_a=\lambda_{\min}$ and $\lambda_b=\lambda_{\max}$. **So $\{\lambda_a,\lambda_b\}=\{\lambda_{\min},\lambda_{\max}\}$, with no other pair attaining the constant.**

Since every summand of $D(v)$ is a product of a nonnegative weight and a nonnegative factor,

$$D(v)=0\iff c_{vab}=0\ \text{ whenever }\ \{\lambda_a,\lambda_b\}\ne\{\lambda_{\min},\lambda_{\max}\},$$

which is exactly *"$\mathrm{ad}(v)$ is supported on $E_{\min}\otimes E_{\max}$"*. **The equality condition the identity itself gives is therefore the block's, and it is correct.** By §3 it holds for one unit $v\in E_{\min}$ iff it holds for all of them, so the block's *"for every unit $v\in E_{\min}$"* is not an extra demand.

**H6 is where the strictness is spent, and dropping it breaks the characterisation and nothing else.** At $\lambda_{\max}=0$ the constant is $0$, attained by every pair meeting $\ker W$, so $D=0$ becomes *"$\mathrm{ad}(v)$ is supported on pairs meeting $\ker W$"*, a different condition, and the one [Lemma L71](../results.md) would then be reading. On $\mathcal W_n$ at $W\ne0$ this cannot happen, so **C9 is a statement-precision defect with no consequence**: [results.md](../results.md):583 prints the hypothesis as $\lambda_{\min}<0\le\lambda_{\max}$ and then states an equality characterisation that needs $\lambda_{\max}>0$, but derives both from $\operatorname{tr}W=0$, which gives the strict form. *A consumer who lifted the lemma out of $\mathcal W_n$ on the strength of the printed hypothesis (which the list of §5 explicitly invites), would carry a false equality case.*

## 7. C4, the dimension theorem, and where its argument lives

**The block states it and cites two ingredients; the argument is in [r566](../reviews/REVIEW_r566.md) §4 and in neither block.** [bounds.md](../findings/bounds.md):226 reads *"Saturation forces $\dim E_{\min}\ge n/2$ and $\dim E_{\max}\ge(n-2)/2$, from the pair cap [Lemma L31](../findings/stratum-two-negative.md) and the Killing marginal alone"*. Naming two ingredients is not a derivation, so I read the report the record cites for it before recording anything: **[r566](../reviews/REVIEW_r566.md) §4 carries the proof in full**, and it is correct. Reproduced here as a check, not as a supply:

At saturation the whole mass sits on $E_{\min}\times E_{\max}$ and its transpose, so $\sum_{a\in E_{\min}}\sum_{b\in E_{\max}}c_{vab}^2=\tfrac12\cdot2(n-2)=n-2$, the halving being the two orders. Read the double sum along $b$: for each fixed $b\in E_{\max}$, $\sum_ac_{vab}^2=\lVert[v_b,v]\rVert^2\le2$ by **L31**, so $n-2\le2\dim E_{\max}$, i.e. $\dim E_{\max}\ge(n-2)/2$. Read it along $a$: for each $a\in E_{\min}$, $\sum_bc_{vab}^2=\lVert[v,v_a]\rVert^2\le2$, and the index $a$ carrying $v$ itself contributes $0$ because $[v,v]=0$, so only $\dim E_{\min}-1$ indices contribute and $n-2\le2(\dim E_{\min}-1)$, i.e. $\dim E_{\min}\ge n/2$. $\square$

**The row-index exclusion is what turns $(n-2)/2$ into $n/2$ on the $E_{\min}$ side**, the same exclusion the excluded-index sentence of §8 is about, used here correctly.

**Both bounds are attained, and I checked the attainment by hand.** At $W_{\mathbb{CP}^2}$, $n=4$: $\dim E_{\min}=2=n/2$ and $\dim E_{\max}=1=(n-2)/2$, exactly. At the balanced sphere product, $\dim E_{\min}=n^2/4$ and $\dim E_{\max}=n(n-2)/4$ (§9), both far above. **No finding**, except that a consumer of [bounds.md](../findings/bounds.md) alone gets a theorem with its proof in a review file and no pointer to it.

## 8. C7 and C8, the excluded-index sentences, read as a consumer would

### C7. The canonical statement carries a sentence its working copy has already refuted

**Locate.** [results.md](../results.md):583, the canonical block, verbatim and unconditional: *"The subtracted constant $\lambda_{\min}\lambda_{\max}$ is attained only on pairs containing the row index, which $c_{vab}$'s support excludes, so the boxed form is the weakened member of a per-row family."*

**Exhibit.** The support exclusion is $c_{vab}=0$ when $a$ or $b$ is $v$'s own index, it excludes **the vector $v$**, not **the eigenvalue $\lambda_{\min}$**. At $W_{\mathbb{CP}^2}$, $n=4$: $E_{\min}$ is two-dimensional, spanned by $u_2,u_3$ inside $\Lambda^+\cong\mathfrak{su}(2)$, and $E_{\max}=\langle u_1\rangle$. Take $v=u_2$. Then $c_{v,1,3}=\langle[u_2,u_1],u_3\rangle\ne0$, the pair $(u_1,u_3)$ has one index at $\lambda_{\max}$ and one at $\lambda_{\min}$, sits **inside** the support, and attains $\lambda_{\min}\lambda_{\max}$ exactly. The sentence is false at the record's own $n=4$ saturating witness, and false at every point with $\dim E_{\min}\ge2$, which by §7 is every saturating point there is.

**Argue the opposite.** The charitable reading is that "the row index" means "any index carrying $\lambda_{\min}$", under which the sentence would be true whenever $\lambda_{\min}$ is simple. But the clause that follows it, *"which $c_{vab}$'s support excludes"*, names the support exclusion, and the support excludes one vector and not one eigenvalue; and the sentence's own continuation four clauses later (*"the two coincide whenever $\lambda_{\min}$ has multiplicity at least $2$"*), asserts the opposite of what the opening asserts. **A charitable reading cannot make one sentence say both.**

**Status: live, and it is the named trap in its exact form.** [r565](../reviews/REVIEW_r565.md) (D3) and [r566](../reviews/REVIEW_r566.md) (D1, D2) both refuted it, and both wrote the repair as covering *"[results.md](../results.md) line 560, which carries the same two sentences unconditionally"*. The repair reached [bounds.md](../findings/bounds.md), where the blockquote at :224 now opens *"THE EXCLUDED-INDEX EFFECT REACHES THIS BOUND ONLY WHEN $\dim E_{\min}=1$"*, **and the correction stands beside the corrected sentence rather than replacing it, while the copy in the canonical file was left untouched.** A consumer citing the canonical statement, which is what "canonical" invites, inherits a refuted sentence with nothing beside it.

### C8. Two incompatible definitions of $m_1$, and the clause that reconciles them holds for only one

**Locate.** [results.md](../results.md):583 and [bounds.md](../findings/bounds.md):224 both define the sharp member's constant as *"$m_1$, the minimum of $\lambda_a\lambda_b$ over the support"*, and both then say *"the two coincide whenever $\lambda_{\min}$ has multiplicity at least $2$"*. [r566](../reviews/REVIEW_r566.md):49 defines it differently: $m_1=\min\{\lambda_a\lambda_b:a\ne b,\ a,b\ne v\}$, a minimum over an **index range**, not over the support of $c_{v\bullet\bullet}$.

**Exhibit, the two differ, at an exact object.** Take $n=4$ and $W=W^+\oplus W^-$ with $W^\pm=\operatorname{diag}(-1,0,1)$ in orthonormal bases $(a^\pm,b^\pm,c^\pm)$ of $\Lambda^\pm$; any pair of trace-free symmetric operators on $\Lambda^\pm$ is an algebraic Weyl tensor at $n=4$, so $W\in\mathcal W_4$, and $\lambda_{\min}=-1$ has multiplicity $2$, $E_{\min}=\langle a^+,a^-\rangle$. Take $v=a^+$. Since $[\Lambda^+,\Lambda^-]=0$, $\mathrm{ad}(v)$ annihilates $\Lambda^-$ and maps $\Lambda^+$ to itself with $[a^+,b^+]\propto c^+$ and $[a^+,c^+]\propto b^+$. **The support of $c_{v\bullet\bullet}$ is exactly the pairs $(b^+,c^+)$ and $(c^+,b^+)$**, whose products are $0\cdot1=0$. So the record's $m_1$ (over the support) is $0$, while [r566](../reviews/REVIEW_r566.md)'s $m_1$ (over indices other than $v$) is $\lambda_{\min}\lambda_{\max}=-1$, attained at $(a^-,c^\pm)$. **The reconciling clause is true of the second and false of the first, at a spectrum with $\dim E_{\min}=2$.**

**Argue the opposite.** The witness is **not** a critical point (I did not check $Q(W)=\theta W$ and have no reason to think it holds) and the block's standing hypothesis is criticality, so a reader may restrict the clause to critical points, where I exhibit nothing. **On that restriction the clause is unproven rather than refuted**: for it to hold one needs $\Pi_{E_{\max}}[v,E_{\min}]\ne0$ at every critical point with $\dim E_{\min}\ge2$, which is a statement about bracket data and neither block argues it. At **saturating** points it is immediate, the entire mass being on $E_{\min}\times E_{\max}$, so **everything downstream, [Lemma L71](../results.md) included, is untouched**, which is what [bounds.md](../findings/bounds.md):224 concludes, by a route that happens not to need the clause.

**Status: GAP, narrow.** What a consumer may cite is the saturating case; the general clause *"the two coincide whenever $\lambda_{\min}$ has multiplicity at least $2$"* is imported from a review under a different definition of its own subject.

## 9. A universal claim, tried against one object from each family the record names

*"At every critical point" is a universal claim with no witness in either block. Below are five, one from each structured family, every value an exact hand evaluation. Where the identity's two sides are computed independently I say so; where one side is obtained from the other, the check is of consistency and I say that too.*

### 9.1 The balanced sphere product $S^{n/2}\times S^{n/2}$, $n$ even, the saturating family

Take the [Lemma L23](../findings/ungraded-slack.md) form $W\propto\Pi_{\mathfrak h}-\tfrac rNI$ with $\mathfrak h=\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$, so $\dim\mathfrak h=2\binom{n/2}2=\tfrac{n(n-2)}4$ and $\dim\mathfrak m=\binom n2-\dim\mathfrak h=\tfrac{n(n-1)}2-\tfrac{n(n-2)}4=\tfrac{n^2}4$. Two eigenvalues with $\operatorname{tr}W=0$ give $\dim\mathfrak m\,\lambda_{\min}+\dim\mathfrak h\,\lambda_{\max}=0$, hence

$$\frac{\lambda_{\max}}{\lvert\lambda_{\min}\rvert}=\frac{\dim\mathfrak m}{\dim\mathfrak h}=\frac{n}{n-2}.$$

Unit norm then pins the scale: $\tfrac{n^2}4\lambda_{\min}^2+\tfrac{n(n-2)}4\cdot\tfrac{n^2}{(n-2)^2}\lambda_{\min}^2=\tfrac{n^2}4\lambda_{\min}^2\cdot\tfrac{2n-2}{n-2}=1$, so $\lambda_{\min}^2=\tfrac{2(n-2)}{n^2(n-1)}$.

$(\mathfrak{so}(n),\mathfrak h)$ is a symmetric pair, so $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, $[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$ and $\mathfrak r=0$: **the equality case of §6 holds and $D=0$.** The identity then returns

$$\theta=\lambda_{\min}+(n-2)\lambda_{\max}=(n-1)\lvert\lambda_{\min}\rvert=(n-1)\sqrt{\tfrac{2(n-2)}{n^2(n-1)}}=\frac{\sqrt{2(n-1)(n-2)}}{n}=\theta_0(n).$$

**Two independently-known quantities meet exactly**: the identity's right side, built from dimensions and tracelessness, returns [conventions.md](../findings/conventions.md)'s closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$ at every even $n$. **The identity passes**, and the saturation is structural rather than measured.

### 9.2 $W_{\mathbb{CP}^2}$ at $n=4$, the kernel witness, and the attaining case of §7

Spectrum $(2,-1,-1,0,0,0)c$ on $\Lambda^2\mathbb R^4$ with $c=1/\sqrt6$ from $\sum\lambda^2=6c^2=1$: $E_{\max}=\langle u_1\rangle\subset\Lambda^+$, $E_{\min}=\langle u_2,u_3\rangle\subset\Lambda^+$, $\ker W=\Lambda^-$ of dimension $3$. Take $v=u_2$. Since $[\Lambda^+,\Lambda^-]=0$, all of $\mathrm{ad}(v)$'s mass lies in $\Lambda^+$, and L153 inside $\mathfrak{so}(4)$ gives $2(4-2)=4$; writing $[u_i,u_j]=\alpha\varepsilon_{ijk}u_k$ this reads $2\alpha^2=4$, so $\alpha^2=2$. The support of $c_{v\bullet\bullet}$ is the ordered pair $(u_1,u_3)$ and its transpose, each of weight $\alpha^2=2$, total $4=2(n-2)$ **as L153 requires**, and each carries the factor $\lambda_{\max}\lambda_{\min}-\lambda_{\min}\lambda_{\max}=0$. **So $D=0$ by direct computation from the structure constants**, and

$$\theta=\lambda_{\min}+(n-2)\lambda_{\max}-0=-c+2\cdot2c=3c=\frac3{\sqrt6}=\sqrt{3/2},$$

which is the record's value for $W_{\mathbb{CP}^2}$ at every $n$. **The identity passes, with both sides known independently.** Here $\dim E_{\min}=2=n/2$ and $\dim E_{\max}=1=(n-2)/2$: §7's two bounds are attained simultaneously, and $\ker W\ne0$ at a *saturating* point, so the kernel is no obstruction to saturation at $n=4$, while §11 records that it is for $n\ge5$.

### 9.3 Padded $W_{\mathbb{CP}^2}$ at $n\ge5$, the same object with a large kernel, and strictly slack

Padding preserves $\lVert W\rVert$, $\theta$ and criticality ($Q$ commutes with it), so the spectrum is $(2,-1,-1,0,\dots,0)c$ with $c=1/\sqrt6$ and $\theta=\sqrt{3/2}$ still. Split $\mathrm{ad}(v)$'s mass for $v=u_2$: L153 at $n$ gives $2(n-2)$ in total; the part with the second index inside $\mathfrak{so}(4)$ is L153 at $4$, namely $4$, and lies on the two zero-factor pairs of §9.2. The remaining $2(n-2)-4=2n-8$ sits on pairs with **both** indices outside $\mathfrak{so}(4)$ ($\mathrm{ad}(v)$ preserves the complement) and every such index is in $\ker W$, so each carries the factor $0-\lambda_{\min}\lambda_{\max}=2c^2$. Hence

$$D=\tfrac12(2n-8)\cdot2c^2=(2n-8)c^2=\frac{2n-8}6=\frac{n-4}3 .$$

**Cross-check against the identity, whose two sides are independently known here:** $\lambda_{\min}+(n-2)\lambda_{\max}-D/\lvert\lambda_{\min}\rvert=-c+2(n-2)c-\frac{(n-4)/3}{c}=(2n-5)c-(2n-8)c=3c=\sqrt{3/2}=\theta$. **The identity passes at every $n\ge5$**, and the deficiency it returns, $(n-4)/3$, is exactly the closed form [bounds.md](../findings/bounds.md):637 records at this point, reached here from the Killing marginal and the bracket structure rather than from the identity.

### 9.4 The subalgebra Casimir family of [Lemma L23](../findings/ungraded-slack.md), the reduction, rebuilt

$W=s(\Pi_{\mathfrak h}-\tfrac rNI)$, $s>0$, so $E_{\max}=\mathfrak h$, $E_{\min}=\mathfrak m=\mathfrak h^\perp$, $\mathfrak r=0$, $\lambda_{\max}=s(1-\tfrac rN)$ and $\lambda_{\min}=-s\tfrac rN$. For unit $v\in\mathfrak m$ the three pair types give:

| pair type | weight | factor |
| --- | --- | --- |
| $(\mathfrak h,\mathfrak h)$ | $c_{vab}=\langle[v_a,v_b],v\rangle=0$, since $\mathfrak h$ is a subalgebra and $\mathfrak m\perp\mathfrak h$ |, |
| $(\mathfrak m,\mathfrak h)$ and $(\mathfrak h,\mathfrak m)$ | free | $\lambda_{\min}\lambda_{\max}-\lambda_{\min}\lambda_{\max}=0$ |
| $(\mathfrak m,\mathfrak m)$ | $M_{\mathfrak{mm}}=\sum_{a,b\in\mathfrak m}c_{vab}^2$ | $\lambda_{\min}^2-\lambda_{\min}\lambda_{\max}=\lvert\lambda_{\min}\rvert(\lvert\lambda_{\min}\rvert+\lambda_{\max})=s^2\tfrac rN>0$ |

So $D=\tfrac12M_{\mathfrak{mm}}\,s^2\tfrac rN$, and since $r>0$,

$$D=0\iff M_{\mathfrak{mm}}=0\iff\langle[\mathfrak m,\mathfrak m],v\rangle=0\ \text{for every }v\in\mathfrak m\iff[\mathfrak m,\mathfrak m]\perp\mathfrak m\iff(\mathfrak{so}(n),\mathfrak h)\ \text{is a symmetric pair}.$$

**This is the block's reduction exactly, and it is correct**, the vanishing of the $\mathfrak{hh}$ mass is total antisymmetry plus $\mathfrak h$ being a subalgebra, and needs no computation, as the block says. **C5 confirmed.** With [Lemma L23](../findings/ungraded-slack.md)'s admissibility cap supplying that the balanced $\mathfrak{so}(m)\oplus\mathfrak{so}(m)$ is the only critical symmetric pair, the saturating members are the balanced sphere products, that last step is L23's and is imported, not checked here.

### 9.5 The maximal torus $\mathfrak{so}(2)^{n/2}$, a slack point, and its tabulated row derived by hand

$n=2m$, $\mathfrak h=\langle\varphi_{12},\varphi_{34},\dots\rangle$ of dimension $m$, $\mathfrak m=\mathfrak h^\perp$. Take $v=\varphi_{13}\in\mathfrak m$. Only two members of $\mathfrak h$ fail to commute with it: $[\varphi_{13},\varphi_{12}]=\varphi_{23}$ and $[\varphi_{13},\varphi_{34}]=\varphi_{14}$, each of norm $1$, so $\sum_{a\in\mathfrak h}\lVert[v,v_a]\rVert^2=2$. The $(\mathfrak h,\mathfrak h)$ mass is $0$ by §9.4, so the mass on $E_{\min}\times E_{\max}$ and its transpose is $2\times2=4$, against a total of $2(n-2)=4m-4$. **The off-support fraction is**

$$\frac{4m-4-4}{4m-4}=\frac{m-2}{m-1},$$

**which is the block's tabulated row exactly**, here derived rather than measured. Two consistency checks fall out: at $m=2$ the fraction is $0$, and indeed $\mathfrak{so}(2)\oplus\mathfrak{so}(2)$ at $n=4$ *is* the balanced split, so the torus and the saturating family coincide there; and the fraction increases in $m$, matching the block's *"slack growing in $n$"*. By §9.4 the deficiency is $D=\tfrac12M_{\mathfrak{mm}}s^2r/N>0$ for $m\ge3$, so **the identity is strictly slack at every maximal torus with $n\ge6$**, no computation needed, against the four measured rows the block prints.

## 10. The forms compared, across every site the record states this result

| site | what it states | agrees with the working block? |
| --- | --- | --- |
| [findings/bounds.md](../findings/bounds.md):216–240 | the working block: boxed identity, $D\ge0$ with *strict* signs, unit norm demanded at :222 and denied at :224, the dimension theorem, the [L23](../findings/ungraded-slack.md) reduction, the four-row table | the reference text; internally contradictory on H2 (§5) and carrying the refuted excluded-index sentence with its correction beside it (§8) |
| [results.md](../results.md):22 | a status row: *"Proven (Lemmas 70, 71, 73)"* | consistent, and says nothing a consumer could misread |
| [results.md](../results.md):39 | the achievements bullet: the identity *"at every critical point"* | **drops the quantifier over $v$ and $D$'s definition alike.** Harmless by §3 ($D$ is $v$-independent at a critical point) but the bullet is the shortest form and the only one where $D$ appears undefined |
| [results.md](../results.md):194 | the landscape entry: identity, $D$'s definition, *"given $\lambda_{\min}<0\le\lambda_{\max}$"*, equality *"for every such $v$"* | states the equality characterisation under the **non-strict** hypothesis (C9, §6) |
| [results.md](../results.md):581–583 | the canonical statement | **better than the working block in one respect and worse in another.** Better: it is the only site that attributes the mass to **[Lemma L153](../findings/bounds.md)** and says the application is *"at the non-basis vector $v$"*, which is the one thing a reader needs and which [bounds.md](../findings/bounds.md) leaves bare. Worse: it carries the excluded-index sentence **unconditionally and with no correction beside it** (§8), and it too prints $\le$ where the equality clause needs $<$ |
| [lean/INDEX.md](../lean/INDEX.md):271, with [L70.lean](../lean/HamiltonsCubic/Results/L70.lean) and [L70b.lean](../lean/HamiltonsCubic/Results/L70b.lean) | three facts, that the strict signs make $\lambda_{\min}\lambda_{\max}$ the minimum product, that tracelessness at $W\ne0$ supplies them, and that the step fails on an all-negative spectrum, with the counterexample given exactly as $(-3,-2,-1)$, plus a point check; the identity in general and its equality case are marked **owed** | the three facts are §4's, correctly formalised, and the row's honesty about what is owed is right: the boxed identity and its equality case, which are what L71 consumes, are **not** machine-checked. **The point check is mislabelled**, C10 below |

**C10, locate.** [lean/INDEX.md](../lean/INDEX.md):271: *"at padded `W_{ℂP²}` the deficiency **vanishes**, `λ_min + (n-2)λ_max = -1 + 2·2 = 3`"*, and [L70b.lean](../lean/HamiltonsCubic/Results/L70b.lean):11 says the same in its docstring.

**Exhibit.** The arithmetic in the row is $n-2=2$, i.e. $n=4$, and the spectrum in the file is the six-entry $[2,-1,-1,0,0,0]$, $\dim\Lambda^2\mathbb R^4=6$. That is $W_{\mathbb{CP}^2}$ **unpadded**, §9.2, where the deficiency does vanish. At padded $W_{\mathbb{CP}^2}$, meaning $n\ge5$, §9.3 gives $D=(n-4)/3>0$, and [bounds.md](../findings/bounds.md):637 says so in the record's own words: *"padded $W_{\mathbb{CP}^2}$ has $\lVert[\mathfrak m,\mathfrak r]\rVert=2.8$ and deficiency $(n-4)/3$, never $0$"*. The two sentences of the record contradict each other, and the exact computation decides for the second.

**Argue the opposite.** The charitable reading is that "padded" is being used loosely for "$W_{\mathbb{CP}^2}$ viewed inside $\Lambda^2\mathbb R^4$ with its three-dimensional kernel", the operator does carry zeros, and a reader might call those padding. **But the record uses "padded $W_{\mathbb{CP}^2}$" as a fixed name for the $n\ge5$ embeddings**, it is the object [Lemma L44](../findings/problem.md) makes the cone non-invariant with for $4\le n\le11$, and under that name the row's claim is false at every $n$ it names. **The mathematics in the Lean file is right; the label on it is not**, and the label is what the INDEX row publishes.

## 11. What is proven, what is used, and what a consumer may cite

**A consumer may cite, from this block, exactly:**

1. The boxed identity, at a **unit-norm** critical point of $\mathcal W_n$ and any unit $v\in E_{\min}$, with $D(v)$ defined by the displayed sum over **ordered** pairs.
2. $D(v)\ge0$, on the weaker hypothesis $\lambda_{\min}\le0\le\lambda_{\max}$, hence the bound $\theta\le\lambda_{\min}+(n-2)\lambda_{\max}$.
3. $D(v)=0\iff\mathrm{ad}(v)$ is supported on $E_{\min}\otimes E_{\max}$, needing $\lambda_{\max}>0$ strictly, which $\operatorname{tr}W=0$ at $W\ne0$ supplies.
4. That $D$ is constant on the unit sphere of $E_{\min}$ and equals $\lvert\lambda_{\min}\rvert(\lambda_{\min}+(n-2)\lambda_{\max}-\theta)$, so it carries **no bracket information**, the identity rearranges the target rather than bounding it, as the canonical statement says.
5. Saturation forces $\dim E_{\min}\ge n/2$ and $\dim E_{\max}\ge(n-2)/2$, citing [r566](../reviews/REVIEW_r566.md) §4 for the argument, which is where it is.
6. On the two-eigenvalue family, saturation $\iff$ symmetric pair (§9.4).

**A consumer may not cite**: the excluded-index sentence in either form (§8); the *"does not need unit norm"* clause (§5); the reconciling clause about $m_1$ under the record's own definition of $m_1$ (§8); and the Lean row's padded point check as stated (§10).

**Does [Lemma L71](../results.md) consume what this block establishes? Yes, exactly.** L71's hypothesis is *"the scalar condition $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$"*, and the chain is tight at both ends:

- Scalar equality $\iff D(v)=0$ for **one** unit $v\in E_{\min}$, by the identity; and then for **every** unit $v\in E_{\min}$, by §3, since $D$ is $v$-independent at a critical point. **This is the step that makes L71's "for every $v\in\mathfrak m$" free**, and neither block states it where L71 can see it.
- $D=0$ for every $v\in\mathfrak m$ unwinds into L71's three inclusions with nothing left over. Taking $a\in\mathfrak m$: $c_{vab}=0$ unless $b\in\mathfrak h$, so $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$. Taking $a\in\mathfrak h$: $c_{vab}=0$ unless $b\in\mathfrak m$, so $[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$. Taking $a\in\mathfrak r$: $c_{vab}=0$ for **every** $b$, since neither index can then be at $\lambda_{\min}$ paired with $\lambda_{\max}$, so $[\mathfrak m,\mathfrak r]=0$. **All three, and only these three.**
- The weakened-versus-sharp distinction of §8 does **not** reach L71: it concerns whether $\theta\le\lambda_{\min}+(n-2)\lambda_{\max}$ is the best bound of its family, while L71 consumes the *equality* case of the identity, which is exact either way. [bounds.md](../findings/bounds.md):224 reaches the same conclusion by a different route (through multiplicity) and §8 shows that route rests on a clause weaker than it looks; **the conclusion survives on the route given here, which needs no clause at all.**

**One gap between proven and used, and it is L71's rather than L70's.** L71 concludes $\mathfrak r=0$ from simplicity of $\mathfrak{so}(n)$; at $n=4$, where $\mathfrak{so}(4)$ is not simple, §9.2's witness saturates **with a three-dimensional kernel**, so $\mathfrak r\subseteq\ker W$ is not empty there. L71 states the $n=4$ exception explicitly. **No finding.**

## 12. The named trap, each citable claim read alone, as a consumer would

*This record's signature failure is a correction landing beside the statement it corrects. I read each site as though it were the only one on the record.*

| read alone | what the reader gets |
| --- | --- |
| [results.md](../results.md):583, the canonical statement | the identity, the sign, the equality case and the L153 attribution (**all correct**), **plus one refuted sentence with nothing beside it** (C7), and an equality clause resting on a hypothesis printed one symbol too weak (C9). *This is the worst of the six sites to read alone, and it is the one a consumer is directed to.* |
| [bounds.md](../findings/bounds.md):216–240, the working block | the same, plus the dimension theorem and the L23 reduction, plus a correction that says the excluded-index sentence is false while leaving it in place two lines up, plus **a hypothesis list that denies the hypothesis the paragraph asserts** (C6) |
| [results.md](../results.md):194 | correct but for C9 |
| [results.md](../results.md):39 | correct; $D$ undefined |
| [lean/INDEX.md](../lean/INDEX.md):271 | three correct facts, an honest "owed", and a point check under a name that makes it false (C10) |
| [conventions.md](../findings/conventions.md), read for the imports | L153 in the general-$v$ form this lemma needs, and L31's pair cap, both correctly stated; **the $\theta$ row's *"at a critical point, $Q(W)=\theta W$"* is where C6's whole confusion originates**, since it identifies two symbols that agree only at unit norm and does not say so |

## 13. What would break it, and where I looked

**The identity.** It is an algebraic consequence of two equalities, so a falsifier must break one. It would be a unit-norm critical point of $\mathcal W_n$ carrying a unit $v\in E_{\min}$ with $\sum_{a,b}c_{vab}^2\ne2(n-2)$. **No such object exists**: the row mass is $-B(v,v)$ for the Killing form of $\mathfrak{so}(n)$ and depends on nothing but $\lVert v\rVert$; I re-derived it from ad-invariance and skewness of $\mathrm{ad}(v)$, and checked it independently at §9.2's and §9.3's witnesses by splitting the mass across $\mathfrak{so}(4)$ and its complement, where it came out at $4$ and $2(n-2)$ respectively.

**The sign.** A falsifier would be a critical point of $\mathcal W_n$ with $\lambda_{\max}\le0$ or $\lambda_{\min}\ge0$. **No such object exists**: $\operatorname{tr}W=0$ at $W\ne0$ excludes both, and $\mathcal W_n\subseteq\{\operatorname{tr}=0\}$ by Ricci-flatness with $\operatorname{scal}=2\operatorname{tr}$. I looked at the boundary case $\lambda_{\max}=0$ specifically, since [results.md](../results.md)'s $\le$ admits it formally, and found the sign survives it while the equality characterisation does not.

**The equality case.** A falsifier would be a critical point with $D(v)=0$ at which $\mathrm{ad}(v)$ puts mass on a pair other than $E_{\min}\times E_{\max}$ (impossible by the uniqueness of the minimising corner in §6) or a critical point saturating with $\dim E_{\min}<n/2$, excluded by §7. I tried the four families the record names and one it does not: the balanced products and $W_{\mathbb{CP}^2}$ saturate, padded $W_{\mathbb{CP}^2}$ and the maximal tori are strictly slack with the slack computed in closed form, and the subalgebra family saturates exactly on the symmetric pairs.

**The one witness I did find** is §8's $n=4$ operator $W^\pm=\operatorname{diag}(-1,0,1)$, with $\dim E_{\min}=2$ and a row whose support misses $E_{\min}\times E_{\max}$ entirely. It falsifies the record's reconciling clause about $m_1$ under the record's own definition of $m_1$, and **it falsifies nothing else**, the identity, the sign and the equality case are untouched by it, and I did not check whether it is critical, which it need not be for the purpose it serves.

## Verdict

**PROVEN, hypotheses corrected.**

The boxed identity holds at every unit-norm critical point of $\mathcal W_n$ and every unit $v\in E_{\min}$, on hypotheses H1, H2, H3, H4, H8 and [Lemma L153](../findings/bounds.md); $D(v)\ge0$ on the sharp condition $\lambda_{\min}\le0\le\lambda_{\max}$, which is weaker than the one the block states; the equality case is exactly *"$\mathrm{ad}(v)$ supported on $E_{\min}\otimes E_{\max}$"* and needs $\lambda_{\max}>0$ strictly; the dimension theorem, the L23 reduction and [Lemma L71](../results.md)'s consumption all check. **Three sentences standing beside these do not**, and each is citable on its own: the hypothesis list at [bounds.md](../findings/bounds.md):224, which denies the unit norm the same paragraph demands (C6); the excluded-index sentence at [results.md](../results.md):583, refuted by the record's own Gate 2 pair and repaired in one file of the two (C7); and the padded point check at [lean/INDEX.md](../lean/INDEX.md):271, whose arithmetic is at $n=4$ and whose name is the $n\ge5$ object (C10). One narrower gap stands at C8, where the record's $m_1$ and the reviewers' $m_1$ are different quantities and the clause that reconciles them holds only for theirs.

**The hypothesis corrections a consumer needs**, in one place: **$\lVert W\rVert=1$ is required** and is carried by the record's definition of "critical point", so the canonical statement is safe and the working block's list is not; **$\lambda_{\max}>0$ strictly** is required for the equality case and follows from $\operatorname{tr}W=0$ at $W\ne0$, so both printings of $\le$ are one symbol short of their own conclusion; and **an orthonormal eigenbasis of $W$ containing $v$** is required, and is stated nowhere.
