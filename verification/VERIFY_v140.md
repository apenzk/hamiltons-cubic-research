# VERIFY v140, Lemma L70: the deficiency identity $\theta=\lambda_{\min}+(n-2)\lambda_{\max}-D(v)/\lvert\lambda_{\min}\rvert$, the sign of $D$, and the equality case $\mathrm{ad}(v)\subseteq E_{\min}\otimes E_{\max}$

**Cold brief.** Verifier v140 on round [L70](ROUND_L70.md), checking the block at [bounds.md](../findings/bounds.md):216–240 with the canonical form at [results.md](../results.md):583 and the landscape line at [results.md](../results.md):194. **No numerical work was done: no script was run, and every value below is an exact hand evaluation, with decimals given only as approximations to a stated surd.** Log: [agent_logs/verify-L70-v140.log](../agent_logs/verify-L70-v140.log). Sources read: [bounds.md](../findings/bounds.md), [results.md](../results.md), [conventions.md](../findings/conventions.md), [stratum-two-negative.md](../findings/stratum-two-negative.md), [LEDGER.md](../findings/LEDGER.md), [REVIEW_r565.md](../reviews/REVIEW_r565.md), [REVIEW_r566.md](../reviews/REVIEW_r566.md), [lean/INDEX.md](../lean/INDEX.md).

## Claim table

| # | claim, as written | verdict |
|---|---|---|
| C1 | the boxed identity $\theta=\lambda_{\min}+(n-2)\lambda_{\max}-D(v)/\lvert\lambda_{\min}\rvert$, at every critical point and every unit $v\in E_{\min}$ | **PROVEN**, derived in full at §2 |
| C2 | $D(v)\ge0$, "each summand a nonnegative weight against a nonnegative factor" | **PROVEN** |
| C3 | that nonnegativity holds "**provided $\lambda_{\min}<0<\lambda_{\max}$ strictly**" | **PROVEN BUT MIS-ATTACHED**, $\lambda_{\min}\le0\le\lambda_{\max}$ suffices for C2; strictness is what the equality case needs |
| C4 | equality iff $\mathrm{ad}(v)$ is supported on $E_{\min}\otimes E_{\max}$, for every unit $v\in E_{\min}$ | **PROVEN**, and the "for every $v$" is free, §4 |
| C5 | "**And it needs $\lVert W\rVert=1$**" ([bounds.md](../findings/bounds.md):222) | **PROVEN**, the scaling check is at §5.1 |
| C6 | "*What the identity does **not** need*: **unit norm**, Weyl membership, $\theta>0$, or $n\ge5$" ([bounds.md](../findings/bounds.md):224) | **BROKEN**, flatly contradicts C5 two lines above it; **D1**, live |
| C7 | "The subtracted constant $\lambda_{\min}\lambda_{\max}$ is attained only on pairs containing the row index, which $c_{vab}$'s support excludes" ([results.md](../results.md):583) | **BROKEN**, false whenever $\dim E_{\min}\ge2$; refuted on file, never applied here; **D2**, live |
| C8 | "$\lambda_{\min}<0\le\lambda_{\max}$ by $\mathop{\mathrm{tr}}W=0$" as the licensing hypothesis at [results.md](../results.md):583 and :194 | **GAP**, the stated hypothesis does not license the equality clause stated beside it; **D3** |
| C9 | saturation forces $\dim E_{\min}\ge n/2$ and $\dim E_{\max}\ge(n-2)/2$, from [L31](../findings/stratum-two-negative.md) and [L153](../findings/bounds.md) alone | **PROVEN**, argument on file at [REVIEW_r566.md](../reviews/REVIEW_r566.md) §4; rebuilt independently at §6.1 |
| C10 | both attained at $W_{\mathbb{CP}^2}$, $n=4$, reading $2$ and $1$ | **PROVEN** |
| C11 | on [L23](../results.md)'s two-eigenvalue family, saturation $\iff(\mathfrak{so}(n),\mathfrak h)$ symmetric pair | **PROVEN** |
| C12 | [L71](../results.md) consumes the scalar condition $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$ and reads off three bracket inclusions | **PROVEN**, what L71 uses is exactly what this block establishes, §7 |
| C13 | lean row: "at padded `W_{ℂP²}` the deficiency **vanishes**" ([lean/INDEX.md](../lean/INDEX.md):271) | **BROKEN**, the arithmetic quoted is $n=4$ unpadded; padded at $n\ge5$ has $D=(n-4)/3>0$; **D4** |

**Summary.** The identity, its nonnegativity and its equality case are all correct and all rebuild in a few lines from criticality, [L153](../findings/bounds.md) and total antisymmetry, but four sentences that a consumer would read as part of the claim are wrong, and in every case the correction is on file *beside* the defect rather than *in* it.

**Verdict: PROVEN, hypotheses corrected.** The mathematics of L70 stands at every $n\ge4$, at every critical point, at every unit $v\in E_{\min}$, including with $\ker W\ne0$, at odd $n$, and at $\dim E_{\min}>1$. Four textual defects (D1–D4) are named at §9 with the exact lines; none moves [L71](../results.md).

## 0. Conventions, fixed once

All quoted from [conventions.md](../findings/conventions.md); nothing here is restated from memory.

- $N=\binom n2=\dim\Lambda^2\mathbb R^n=\dim\mathfrak{so}(n)$. The inner product on $\Lambda^2$ is the **half-trace** pairing $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, under which $\{\varphi_{ab}\}_{a<b}$ is orthonormal and $\mathop{\mathrm{tr}}(v^2)=-2$ for a unit bivector.
- $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, $\theta=P(W)/\lVert W\rVert^3$, and **"critical point" is $Q(W)=\theta W$, the first-order condition on $\{\lVert W\rVert=1\}$**. $\#$ is the halved Böhm–Wilking product, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$.
- Structure constants $c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric**, the inner product being ad-invariant. $T_{abc}=c_{abc}^2$ is totally symmetric and vanishes when two indices coincide.
- **Sums over pairs are over ORDERED pairs** unless a line says otherwise. This is the convention under which the row mass reads $2(n-2)$.
- $\mathfrak m=E_{\min}$, $\mathfrak h=E_{\max}$, $\mathfrak r$ everything else, kernel included.
- The Killing form of $\mathfrak{so}(n)$ is $B(X,Y)=(n-2)\mathop{\mathrm{tr}}(XY)$, so $\kappa=2(n-2)$ in an orthonormal basis.
- **Not in [conventions.md](../findings/conventions.md)**: $E_{\min}$, $E_{\max}$, $c_{vab}$ at a non-basis vector, and $m_1$. [REVIEW_r565.md](../reviews/REVIEW_r565.md) already logged the first three as undefined and they are still undefined. The extension of $c$ to a vector in the first slot is by linearity, and total antisymmetry survives it because it is linear in each slot; I use it below and flag that the record nowhere says so.

## 1. Hypothesis inventory

**Carried by the block.** (H1) $W\in\mathcal W_n$; (H2) $W$ a critical point, i.e. $Q(W)=\theta W$; (H3) $\lVert W\rVert=1$; (H4) $v$ a **unit** vector in $E_{\min}(W)$; (H5) $\lambda_{\min}<0<\lambda_{\max}$ strictly, said to be supplied by $\mathop{\mathrm{tr}}W=0$ at $W\ne0$; (H6) the row mass $\sum_{a,b}c_{vab}^2=2(n-2)$.

**Imported results, each checked against the object it is applied to.**

| import | statement as written | applied to | check |
|---|---|---|---|
| [L153](../findings/bounds.md) | $\sum_\beta\lVert[v,v_\beta]\rVert^2=2(n-2)\lVert v\rVert^2$ for **any** $v\in\mathfrak{so}(n)$, any $n\ge2$ | a **non-basis** unit $v\in E_{\min}$ | **OK.** The quantifier was widened from basis elements to arbitrary $v$ on 2026-09-05 precisely because L70 is one of the two consumers that need it; [bounds.md](../findings/bounds.md):311 records the widening. Without it the application is out of scope. |
| [L31](../findings/stratum-two-negative.md) | $\lVert[X,Y]\rVert^2\le2$ for orthonormal $X,Y\in\mathfrak{so}(n)$, with equality characterised | pairs $(v,\varphi_a)$, $v$ non-basis | **OK for the cap.** The proof's root-system step gives $\max_{\lVert Y\rVert=1}\lVert[X,Y]\rVert^2=(s_1+s_2)^2\le2$ over **all** unit $Y$, orthogonality unused, so the cap transfers. Used only in the dimension theorem (§6.1), not in the identity. |
| $Q$ preserves $\mathcal W_n$ | proved on the record at [problem.md](../findings/problem.md) from [BW08](../references/boehm-wilking-2008-space-forms/) eq. (6) | criticality carrying no projection | **OK, and load-bearing.** If $Q$ did not preserve $\mathcal W_n$, criticality would read $\Pi_{\mathcal W}Q(W)=\theta W$ and step (2) below would lose its $\langle v,W^\#v\rangle$. The block cites this where it is used. |
| $I^\#=(n-2)I$ | [Böhm–Wilking](../references/boehm-wilking-2008-space-forms/notes.md) Lemma 2.1, cited at [bounds.md](../findings/bounds.md) relation (A) | the $\#$-normalisation | Read in [references/](../references/), the folder exists. I use it only as the anchor of §2 step (1). |

**Which hypotheses the written proof actually uses.** (H2) at step (2); (H4) at steps (1) and (2); (H6) at step (3); (H3) at step (4), where $\theta$ is read as $P/\lVert W\rVert^3$; $\lambda_{\min}\ne0$ at step (4), where the division happens. **(H5) is used nowhere in the identity**, it enters only the sign claim (§3) and the equality clause (§4), and even there only its second half. **(H1) is used only to supply $\mathop{\mathrm{tr}}W=0$** (hence $\lambda_{\min}<0$) and to license the previous row.

**Hypotheses the block claims it does not need**, checked one at a time: **$\theta>0$** (genuinely unused, confirmed, the derivation never takes a sign of $\theta$; **$n\ge5$**), genuinely unused, and $n=4$ is a real instance, §6.2; **Weyl membership**, half true, in that the derivation runs for any symmetric $W$ on $\Lambda^2$ satisfying $Q(W)=\theta W$ with $\lambda_{\min}<0$, but then $\lambda_{\min}<0$ must be **carried as a hypothesis**, since the block's own justification for it ("supplied by $\mathop{\mathrm{tr}}W=0$ at $W\ne0$") is exactly the Weyl input; **unit norm**, **false**, see §5.1 and D1.

## 2. Question 1, the derivation, step by step, with the hypothesis each step consumes

Fix a critical $W$, and a unit $v\in E_{\min}$. Extend $v$ to an orthonormal eigenbasis $\{\varphi_a\}_{a=1}^N$ of $\Lambda^2$ with $\varphi_1=v$, $W\varphi_a=\lambda_a\varphi_a$. Write $A=\mathrm{ad}(v)$, so $A_{ab}=\langle[v,\varphi_a],\varphi_b\rangle=c_{vab}$, and $A$ is antisymmetric.

**(1) The $\#$-diagonal in the eigenbasis.** $\langle v,W^\#v\rangle=-\tfrac12\mathop{\mathrm{tr}}(AWAW)$ is the $\#$-convention fact the record uses. In the eigenbasis $\mathop{\mathrm{tr}}(AWAW)=\sum_{a,b}A_{ab}\lambda_bA_{ba}\lambda_a=-\sum_{a,b}\lambda_a\lambda_bc_{vab}^2$, using $A_{ba}=-A_{ab}$. Hence

$$\langle v,W^\#v\rangle=\tfrac12\sum_{a,b}\lambda_a\lambda_b\,c_{vab}^2 .$$

*Hypotheses used: (H4) only ($v$ unit, so that $A$ is the ad of a unit vector); no criticality, no Weyl membership.* **Anchor, exact.** At $W=I$ on $\Lambda^2$ the display gives $\tfrac12\sum_{a,b}c_{vab}^2=\tfrac12\cdot2(n-2)=n-2$ by (H6), and independently $I^\#=(n-2)I$ gives $\langle v,I^\#v\rangle=n-2$. The two agree, so the $\tfrac12$ and the half-trace pairing are the pair the record's proof commits to. This is the one place a factor of $2$ could have hidden, and it does not.

**(2) Criticality at the row $v$.** $Q(W)=\theta W$ gives $\langle v,W^2v\rangle+\langle v,W^\#v\rangle=\theta\langle v,Wv\rangle$, i.e.

$$\lambda_{\min}^2+\langle v,W^\#v\rangle=\theta\lambda_{\min}.$$

*Hypotheses used: (H2), (H4). Note this is an operator equation, so it holds at **every** unit $v\in E_{\min}$ with no choice made, this is where the block's "for every unit $v$" comes from, and it is two lines, not a measurement.*

**(3) Spending the mass.** By (H6), $\tfrac12\sum_{a,b}\lambda_{\min}\lambda_{\max}c_{vab}^2=\tfrac12\lambda_{\min}\lambda_{\max}\cdot2(n-2)=(n-2)\lambda_{\min}\lambda_{\max}$. Subtracting from (1),

$$D(v)\;=\;\tfrac12\sum_{a,b}\big(\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max}\big)c_{vab}^2\;=\;\langle v,W^\#v\rangle-(n-2)\lambda_{\min}\lambda_{\max}.$$

*Hypotheses used: (H6), and this is the only step where $2(n-2)$, hence the whole $n$-dependence of the bound, enters.*

**(4) Substitute and divide.** From (2), $D(v)=\theta\lambda_{\min}-\lambda_{\min}^2-(n-2)\lambda_{\min}\lambda_{\max}$. Dividing by $\lambda_{\min}$ (legitimate exactly because $\lambda_{\min}\ne0$), gives $D(v)/\lambda_{\min}=\theta-\lambda_{\min}-(n-2)\lambda_{\max}$, and $\lambda_{\min}=-\lvert\lambda_{\min}\rvert$ turns this into

$$\boxed{\;\theta=\lambda_{\min}+(n-2)\lambda_{\max}-\frac{D(v)}{\lvert\lambda_{\min}\rvert}\;}$$

*Hypotheses used: $\lambda_{\min}<0$; and (H3), because the $\theta$ of step (2) is the criticality eigenvalue while the $\theta$ of the display is [conventions.md](../findings/conventions.md)'s $P(W)/\lVert W\rVert^3$, and the two agree only at $\lVert W\rVert=1$ (§5.1).*

**Two corollaries the derivation hands over free**, both of which the record uses elsewhere and one of which it calls a debt:

- $D(v)$ **is independent of $v$** on the unit sphere of $E_{\min}$: step (4) exhibits it as $\lvert\lambda_{\min}\rvert(\lambda_{\min}+(n-2)\lambda_{\max}-\theta)$, a function of $(\theta,\lambda_{\min},\lambda_{\max})$ alone. Equivalently, at a critical point $W^\#=\theta W-W^2$ is a polynomial in $W$. This **is** the eigenspace-constancy check the record says it owes on any per-$v$ statistic, and it costs two lines.
- The identity is a rearrangement, not a bound: since $D$ is determined by $(\theta,\lambda_{\min},\lambda_{\max})$, no new scalar information about $\theta$ is in it. The canonical form at [results.md](../results.md):583 says exactly this, correctly.

**No finding: the derivation is complete, correct, and uses no hypothesis it does not carry.**

## 3. Question 2, is the factor nonnegative for every pair, and under exactly what condition

The claim to check is: for every pair $(a,b)$ occurring in the sum (that is, every $(a,b)\in\{1,\dots,N\}^2$), the factor $\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max}$ is $\ge0$. Equivalently, $\lambda_{\min}\lambda_{\max}$ is the **minimum of $\lambda_a\lambda_b$ over the spectrum**. Three cases, exhaustive.

**Case (i): $\lambda_a\ge0$ and $\lambda_b\ge0$.** Then $\lambda_a\lambda_b\ge0$. And $\lambda_{\min}\lambda_{\max}\le0$ whenever $\lambda_{\min}\le0\le\lambda_{\max}$. So the factor is $\ge0$. **Uses: $\lambda_{\min}\le0\le\lambda_{\max}$, no strictness.**

**Case (ii): $\lambda_a\le0$ and $\lambda_b\le0$.** Then $\lambda_a\lambda_b\ge0\ge\lambda_{\min}\lambda_{\max}$, same conclusion. **Uses: the same, no strictness.**

**Case (iii): mixed, say $\lambda_a<0<\lambda_b$.** Then $-\lambda_a\le\lvert\lambda_{\min}\rvert$ and $0<\lambda_b\le\lambda_{\max}$, both factors positive, so $(-\lambda_a)\lambda_b\le\lvert\lambda_{\min}\rvert\lambda_{\max}$, i.e. $\lambda_a\lambda_b\ge-\lvert\lambda_{\min}\rvert\lambda_{\max}=\lambda_{\min}\lambda_{\max}$. **Uses: $\lambda_{\min}\le\lambda_a$ and $\lambda_b\le\lambda_{\max}$, which are the definitions, plus $\lambda_{\min}<0<\lambda_{\max}$ **only** to know case (iii) is non-empty.**

**So C2 holds under $\lambda_{\min}\le0\le\lambda_{\max}$**, and that is automatic for any traceless operator, $W=0$ included. **The strictness in C3 is not what makes the factor nonnegative.** What strictness buys is the *equality* analysis (§4): in case (iii), equality forces $\lambda_a=\lambda_{\min}$ **and** $\lambda_b=\lambda_{\max}$, so the zero set of the factor is exactly $E_{\min}\times E_{\max}\cup E_{\max}\times E_{\min}$; while at $\lambda_{\max}=0$ the constant is $0$ and the zero set swells to every pair with one index in $\ker W$, and at $\lambda_{\min}=0$ likewise.

**What fails when the strictness fails, item by item.**

| failure | the identity | the sign $D\ge0$ | the equality clause |
|---|---|---|---|
| $\lambda_{\min}=0$ | **undefined**, step (4) divides by $\lambda_{\min}$ | holds ($W\succeq0$, all products $\ge0=\lambda_{\min}\lambda_{\max}$) | vacuous |
| $\lambda_{\max}=0$ | holds | holds ($W\preceq0$, all products $\ge0=\lambda_{\min}\lambda_{\max}$) | **false**, the zero set is $\{$one index in $\ker W\}$, strictly larger than $E_{\min}\otimes E_{\max}$ |
| all $\lambda<0$ (so $\lambda_{\max}<0$) | holds as an identity **defining** $D$ | **fails**, the termwise step is wrong | vacuous |

The third row is the record's own counterexample, and it checks exactly: $\lambda=(-0.684,-0.570,-0.456)$ has $\lambda_{\min}\lambda_{\max}=(-0.684)(-0.456)=0.311904$, while the true minimum product over pairs is $\lambda_{\max}^2=(-0.456)^2=0.207936$. The block's "$0.312$ against $0.208$" is these two rounded, and it is right. **But on $\mathcal W_n$ none of the three rows can occur at $W\ne0$**: $\mathop{\mathrm{tr}}W=0$ with $W\ne0$ forces $\lambda_{\min}<0<\lambda_{\max}$ strictly. So the block's justification clause is correct and the whole strictness question is free on the domain the lemma is stated over.

**Finding D3 (recorded, no consequence).** The words *"each summand being a nonnegative weight against a nonnegative factor **provided $\lambda_{\min}<0<\lambda_{\max}$ strictly**"* attach strictness to the wrong clause. The block's very next words (*"the equality characterisation needs the strict inequality"*), attach it to the right one. Both sentences stand, adjacent, saying different things about the same hypothesis. A reader taking the bold half concludes that $D\ge0$ needs a hypothesis it does not need; a reader taking the italic half is right. **This is the round's named trap in miniature and it is the third instance of it in this one block.**

## 4. Question 3, what saturates it

$D(v)=0$ iff every term of the sum vanishes, the terms being products of a nonnegative weight $c_{vab}^2$ and a nonnegative factor. So

$$D(v)=0\iff\Big(c_{vab}\ne0\Rightarrow\lambda_a\lambda_b=\lambda_{\min}\lambda_{\max}\Big)\iff\Big(c_{vab}\ne0\Rightarrow\{\lambda_a,\lambda_b\}=\{\lambda_{\min},\lambda_{\max}\}\Big),$$

the second equivalence being the strict case-(iii) analysis of §3, which needs $\lambda_{\min}<0<\lambda_{\max}$ and has it. That is precisely "$\mathrm{ad}(v)$ is supported on $E_{\min}\otimes E_{\max}$". **C4 holds.**

**The "for every unit $v\in E_{\min}$" is free, not an extra demand.** By the first corollary of §2, $D(v)$ is the same number for every unit $v\in E_{\min}$. So $D(v_0)=0$ for one $v_0$ already gives $D(v)=0$ for all $v$, and the support condition for all $v$ follows. The quantifier as written is therefore redundant, and harmless, and it is the form [L71](../results.md) needs, so writing it is right.

**The scalar form.** By §2 step (4), $D(v)=0$ for one (hence all) $v$ $\iff$ $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$. So the equality condition is checkable from $(\lambda,\theta)$ alone, exactly as [results.md](../results.md):583 says.

## 5. Quantifier order, scope, and every edge of the range

### 5.1 $\lVert W\rVert=1$, the scaling check, and D1

Let $W$ be a unit critical point, $\theta=P(W)$, and put $W_t=tW$ for $t>0$. Then:

- $\theta(W_t)=P(tW)/\lVert tW\rVert^3=t^3P(W)/t^3=\theta$, **degree $0$**.
- $\lambda(W_t)=t\lambda$, so $\lambda_{\min}+(n-2)\lambda_{\max}$ scales by $t$.
- $c_{vab}$ does not depend on $W$ at all, so $D_t=\tfrac12\sum(t^2\lambda_a\lambda_b-t^2\lambda_{\min}\lambda_{\max})c_{vab}^2=t^2D$, and $D_t/\lvert t\lambda_{\min}\rvert=tD/\lvert\lambda_{\min}\rvert$.
- Hence the right-hand side scales by $t$ (**degree $1$**) and the identity can hold at $t=1$ only, unless $\theta=0$.

**C5 is right.** Underneath it is the fact that $Q(W_t)=t\theta\,W_t$, so the criticality eigenvalue is $t\theta$ while $P/\lVert\cdot\rVert^3$ is $\theta$: the two readings of the letter $\theta$ separate off the unit sphere, which is the confusion [bounds.md](../findings/bounds.md):222 records [r323](../reviews/REVIEW_r323.md) and [r324](../reviews/REVIEW_r324.md) as having propagated.

> **DISCREPANCY D1, the repair was written and the defect was left standing two lines away.**
>
> **Located.** [bounds.md](../findings/bounds.md):222 reads *"**And it needs $\lVert W\rVert=1$**: … so the identity holds at one scale only. *The list of what the identity does not need carried "unit norm" until this audit…*"*. [bounds.md](../findings/bounds.md):224, inside the blockquote immediately below, still reads *"**What the identity does not need**: unit norm, Weyl membership, $\theta>0$, or $n\ge5$."*
>
> **Exhibited.** Take any unit critical $W$ with $\theta\ne0$ and $t=2$. The left side of the boxed display reads $\theta$; the right side reads $2\theta$. Concretely at $W_{\mathbb{CP}^2}$, $n=4$: at $t=1$ both sides are $\sqrt{3/2}$; at $t=2$ the left is $\sqrt{3/2}$ and the right is $2\sqrt{3/2}$. A consumer who cites line 224 and applies the boxed identity to a critical point normalised any other way gets a statement false by the factor $t$.
>
> **Argued the opposite.** The most charitable reading is that line 224's list is scoped to the *algebraic* identity between $\theta_{\rm crit}$ (the eigenvalue in $Q(W)=\theta_{\rm crit}W$) and the spectrum, which genuinely needs no normalisation. That reading is available and is what the two propagating reviews took. It fails here for a definite reason: [conventions.md](../findings/conventions.md) fixes $\theta$ as $P(W)/\lVert W\rVert^3$, the block quotes that file for exactly this point one line earlier, and the block's own sentence at line 222 says the list was wrong. **The block therefore asserts and denies the same hypothesis within three lines, and the denial is the one a reader meets last.** Candidate stands.

### 5.2 The remaining edges

| edge | status |
|---|---|
| $\ker W\ne0$ | **No obstruction.** The kernel sits inside $\mathfrak r$, contributes factors $0-\lambda_{\min}\lambda_{\max}>0$, and is fully inside the sum. Witness: padded $W_{\mathbb{CP}^2}$, §6.3, where the identity holds with $D=(n-4)/3>0$. The kernel is *not* excluded from the spectrum over which $\lambda_{\min}\lambda_{\max}$ is minimal, case (i) of §3 covers it. |
| $\lambda_{\min}=0$ | **Impossible on $\mathcal W_n\setminus\{0\}$** ($\mathop{\mathrm{tr}}W=0$). Were it allowed, the identity is undefined, not false. The block's hypothesis set covers this only through (H5); the canonical form at [results.md](../results.md):583 covers it through "$\lambda_{\min}<0$", which is the half that matters. |
| smallest admissible $n$ | $\dim\mathcal W_n=n(n-3)(n+1)(n+2)/12$ is $0$ at $n=3$, so $n=4$ is the smallest. The identity holds there: $n-2=2$, row mass $2(n-2)=4$, and **two** critical points saturate (§6.2, §6.4). The block's "does not need $n\ge5$" is right, and $n=4$ is where the equality case has its two most informative instances. |
| odd $n$ | **The identity holds unchanged**, nothing in §2 sees the parity. What is parity-sensitive is [L71](../results.md)'s *conclusion*, that no critical point saturates at odd $n\ge5$. So at odd $n$ L70's equality clause is a true statement with no instances, and L70 itself is not. **Anyone citing "L70 saturates at the balanced sphere product" at odd $n$ is citing an empty set, not a false claim.** |
| $\dim E_{\min}>1$ | **The generic and the important case.** It is what makes the excluded-index effect void (§9, D2), and by C9 it is *forced* at saturation, $\dim E_{\min}\ge n/2\ge2$ for every $n\ge4$. |
| $\dim E_{\min}=1$ | The identity still holds. What changes is that $D>0$ strictly: the only pairs achieving $\lambda_{\min}\lambda_{\max}$ contain the single $E_{\min}$ index, which is $v$ itself, and $c_{vvb}=0$ by antisymmetry. So a simple $\lambda_{\min}$ **forbids saturation**, consistent with C9. |

## 6. A universal claim with no witness, one object from each structured family the record names

Common set-up for the subalgebra family ([L23](../results.md)): $W=s\,(\Pi_{\mathfrak h}-\tfrac rNI)$ with $r=\dim\mathfrak h$, $N=\binom n2$, and $s=1/\lVert\Pi_{\mathfrak h}-\tfrac rNI\rVert$. The unnormalised eigenvalues are $1-\tfrac rN$ on $\mathfrak h$ (positive) and $-\tfrac rN$ on $\mathfrak m=\mathfrak h^\perp$ (negative), the trace is $r(1-\tfrac rN)+(N-r)(-\tfrac rN)=0$, and the squared norm is $\tfrac{r(N-r)}N$, so $s=\sqrt{N/(r(N-r))}$, $\lambda_{\min}=-sr/N$, $\lambda_{\max}=s(N-r)/N$, and

$$\lambda_{\min}+(n-2)\lambda_{\max}=\frac sN\big[(n-2)(N-r)-r\big].$$

All arithmetic below is exact; decimals are approximations to the surd printed beside them.

### 6.1 The dimension theorem, rebuilt before the witnesses (C9)

The block asserts C9 and gives no argument in the block; the argument **is** on file, at [REVIEW_r566.md](../reviews/REVIEW_r566.md) §4, which the block cites. I rebuilt it independently and it agrees line for line. At saturation the row mass of $v\in E_{\min}$, which is $2(n-2)$ by [L153](../findings/bounds.md), sits entirely on pairs with one index in $E_{\min}$ and one in $E_{\max}$; the two index orders carry equal mass, so $\sum_{a\in E_{\min},b\in E_{\max}}c_{vab}^2=n-2$ and likewise with the roles swapped. Reading the double sum along $b$: $\sum_ac_{vab}^2=\lVert[\varphi_b,v]\rVert^2\le2$ by [L31](../findings/stratum-two-negative.md) for each $b\in E_{\max}$, so $n-2\le2\dim E_{\max}$, i.e. $\dim E_{\max}\ge(n-2)/2$. Reading it along $a$: $\sum_bc_{vab}^2=\lVert[v,\varphi_a]\rVert^2\le2$ for each $a\in E_{\min}$, and the index $a=v$ contributes $0$, so $n-2\le2(\dim E_{\min}-1)$, i.e. $\dim E_{\min}\ge n/2$. **C9 confirmed**, and the excluded index (the same one whose mis-description is D2), is what buys the extra $1$ and turns $(n-2)/2$ into $n/2$.

### 6.2 Sphere products, the balanced split $\mathfrak{so}(m)\oplus\mathfrak{so}(m)$ at $n=2m$

Here $r=2\binom m2=m(m-1)$, $N=m(2m-1)$, $N-r=m^2$ (which is $\dim\mathfrak m$, matching $\mathbb R^m\otimes\mathbb R^m$), and $s=\frac1m\sqrt{\frac{2m-1}{m-1}}$. So

$$\lambda_{\min}+(n-2)\lambda_{\max}=\frac s{m(2m-1)}\big[(2m-2)m^2-m(m-1)\big]=\frac{s(m-1)(2m-1)}{2m-1}=s(m-1)=\frac1m\sqrt{(m-1)(2m-1)} .$$

And $\theta_0(n)^2=\frac{2(n-1)(n-2)}{n^2}=\frac{2(2m-1)(2m-2)}{4m^2}=\frac{(m-1)(2m-1)}{m^2}$, so **$\lambda_{\min}+(n-2)\lambda_{\max}=\theta_0(2m)$ exactly, at every $m$.** At $m=2$ this is $\tfrac{\sqrt3}2$, which is [conventions.md](../findings/conventions.md)'s $\Theta_4=0.866$; at $m=3$ it is $\tfrac{\sqrt{10}}3\approx1.054093$, which is the record's $\theta_0(6)$. **The identity's saturation value at the balanced product is $\theta_0(n)$, by hand, at every even $n$ at once**, the record's "slack $0.000000000$ at $n=6,8,10,12$" row is this, and it is exact rather than measured.

Structurally: $(\mathfrak{so}(2m),\mathfrak{so}(m)\oplus\mathfrak{so}(m))$ is a symmetric pair, so $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, $[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$, $\mathfrak r=0$; every $c_{vab}$ with $v\in\mathfrak m$ that is not of type $(\mathfrak m,\mathfrak h)$ vanishes, so $D(v)=0$ for every $v$. **Saturates. Consistent with C9**: $\dim E_{\min}=m^2\ge m=n/2$ and $\dim E_{\max}=m(m-1)\ge m-1=(n-2)/2$.

### 6.3 $W_{\mathbb{CP}^2}$, and a padding, the kernel witness

$W_{\mathbb{CP}^2}$ at $n=4$ is self-dual with $\Lambda^2$ spectrum $(2,-1,-1,0,0,0)/\sqrt6$: $\lambda_{\max}=2/\sqrt6$ simple, $\lambda_{\min}=-1/\sqrt6$ of multiplicity $2$, and a $3$-dimensional kernel, namely $\Lambda^2_-=\mathfrak{su}(2)_-$. Then

$$\lambda_{\min}+(n-2)\lambda_{\max}=\frac{-1+2\cdot2}{\sqrt6}=\frac3{\sqrt6}=\sqrt{\tfrac32},$$

which is exactly $\theta(W_{\mathbb{CP}^2})=\sqrt{3/2}$. **So $D=0$: it saturates**, and it does so **with a nontrivial kernel**, which is why "saturation forces $\ker W=0$" is a corollary of $\mathfrak r=0$ at $n\ge5$ and false at $n=4$, as [bounds.md](../findings/bounds.md):630 records. Structurally, $\mathfrak h\oplus\mathfrak m=\mathfrak{su}(2)_+$ with $\mathfrak h$ the $\lambda_{\max}$ line, $\mathfrak m$ the $\lambda_{\min}$ plane: $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ and $[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$ inside $\mathfrak{su}(2)$, and $[\mathfrak m,\mathfrak r]=[\mathfrak{su}(2)_+,\mathfrak{su}(2)_-]=0$ on the nose. **C10 confirmed**: $\dim E_{\min}=2=n/2$ and $\dim E_{\max}=1=(n-2)/2$, both attained.

**Padded to $n\ge5$**, the spectrum is the same three values plus more zeros, $\theta$ is unchanged at $\sqrt{3/2}$ (padding preserves $\theta$), and

$$D=\lvert\lambda_{\min}\rvert\big(\lambda_{\min}+(n-2)\lambda_{\max}-\theta\big)=\frac1{\sqrt6}\cdot\frac{(2n-5)-3}{\sqrt6}=\frac{2n-8}6=\frac{n-4}3 .$$

This reproduces **exactly** the record's "padded $W_{\mathbb{CP}^2}$ … deficiency $(n-4)/3$, never $0$" at [bounds.md](../findings/bounds.md):640, and it vanishes precisely at $n=4$. **A kernel does not obstruct the identity**; what obstructs saturation at $n\ge5$ is $[\mathfrak m,\mathfrak r]\ne0$.

### 6.4 A subalgebra Casimir, the maximal torus $\mathfrak{so}(2)^{n/2}$, and $\mathrm{ad}(\mathfrak{su}(3))\subset\mathfrak{so}(8)$

**Maximal torus**, $n=2m$, $r=m$: $N-r=2m(m-1)$, $s=\sqrt{\frac{2m-1}{2m(m-1)}}$, and

$$\lambda_{\min}+(n-2)\lambda_{\max}=\frac s{m(2m-1)}\big[(2m-2)\,2m(m-1)-m\big]=\frac{s\big(4(m-1)^2-1\big)}{2m-1}=\frac{s(2m-3)(2m-1)}{2m-1}=s(2m-3).$$

**It does not saturate, for a reason needing no computation.** $\mathfrak h=\mathfrak{so}(2)^m$ is abelian, and for $m\ge3$ the pair is not symmetric: with $\mathfrak h=\langle e_{12},e_{34},e_{56},\dots\rangle$, the elements $e_{13},e_{15}\in\mathfrak m$ have $[e_{13},e_{15}]=\pm e_{35}\in\mathfrak m$, so $[\mathfrak m,\mathfrak m]\not\perp\mathfrak m$ and $D>0$ by C11. At $m=2$ the maximal torus *is* $\mathfrak{so}(2)\oplus\mathfrak{so}(2)$, i.e. the balanced split at $n=4$, and it does saturate, which is why the record's torus rows begin at $n=6$.

**Cross-check of the record's slack column, exactly and by hand.** [lean/INDEX.md](../lean/INDEX.md):113 records independently that the octahedron strongly regular graph ("the catalogued $n=6$ maximal torus"), has $\theta^2=5/12$, and $s^2=\frac{2m-1}{2m(m-1)}=\frac5{12}$ at $m=3$, so $\theta=s$ there. Taking $\theta=s$, the slack $\lambda_{\min}+(n-2)\lambda_{\max}-\theta=(2m-4)s$ evaluates to

| $n$ | slack, exact | decimal | record's table |
|---|---|---|---|
| $6$ | $2\sqrt{5/12}=\sqrt{5/3}$ | $1.290994$ | $1.291$ |
| $8$ | $4\sqrt{7/24}=\sqrt{14/3}$ | $2.160247$ | $2.160$ |
| $10$ | $6\sqrt{9/40}=9/\sqrt{10}$ | $2.846050$ | $2.846$ |
| $12$ | $8\sqrt{11/60}=4\sqrt{11/15}$ | $3.425395$ | $3.425$ |

All four agree to every digit printed. **This is a hand check of the table, not a rerun of it.**

**$\mathrm{ad}(\mathfrak{su}(3))\subset\mathfrak{so}(8)$**: $r=8$, $N=28$, $N-r=20$, $s=\sqrt{7/40}$, and $\lambda_{\min}+(n-2)\lambda_{\max}=\frac s{28}[6\cdot20-8]=4s=\sqrt{14/5}\approx1.673320$. **It cannot saturate, again with no computation**: by C11 saturation needs $(\mathfrak{so}(8),\mathfrak h)$ symmetric, and the symmetric subalgebras of $\mathfrak{so}(8)$ have $\dim\mathfrak h\in\{21,16,13,12\}$ for $\mathfrak{so}(p)\oplus\mathfrak{so}(8-p)$ and $\mathfrak u(4)$, while $\dim\mathfrak{su}(3)=8$ is none of them. The record's slack $0.836660$ is exactly $\sqrt{7/10}=2s$, i.e. $\theta=2s=\sqrt{7/10}$ there; half the bound, exactly.

**Also checked, from the same table.** The "mass off $E_{\min}\times E_{\max}$" denominators $72,192,400,720$ at $n=6,8,10,12$ are $2(n-2)\dim\mathfrak m$ with $\dim\mathfrak m=n^2/4$, i.e. the row mass of [L153](../findings/bounds.md) in the **ordered** convention summed over $\mathfrak m$'s rows; and $240$ at $\mathrm{ad}(\mathfrak{su}(3))$ is $2\cdot6\cdot20$. The table is in one convention throughout, and it is the record's declared one.

**No finding: every family the record names behaves as the block says, and the two saturating families are the only two that can.**

## 7. What [Lemma L71](../results.md) consumes, and whether this block establishes it

[L71](../results.md) opens: *"Let $W$ be a critical point of $\mathcal W_n$, $n\ge5$, at which Lemma L70 holds with equality, the scalar condition $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$. … The equality case reads $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, $[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$, $[\mathfrak m,\mathfrak r]=0$."*

**The scalar hypothesis is the right one and this block supplies the bridge.** By §4, the scalar condition is $D(v)=0$, which by §2's first corollary holds for one $v$ iff for all $v$, and by §4 is equivalent to $\mathrm{ad}(v)$ supported on $E_{\min}\otimes E_{\max}$ for every unit $v\in\mathfrak m$. From there each inclusion falls out, using total antisymmetry $c_{vab}=\langle v,[\varphi_a,\varphi_b]\rangle$ up to sign:

- $a,b\in\mathfrak h$ is not a support pair, so $\langle[v,\varphi_a],\varphi_b\rangle=0$: $[\mathfrak m,\mathfrak h]\perp\mathfrak h$. Nor is $(a\in\mathfrak h,b\in\mathfrak r)$, so $[\mathfrak m,\mathfrak h]\perp\mathfrak r$. Hence **$[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$**.
- $a,b\in\mathfrak m$ is not a support pair, so $[\mathfrak m,\mathfrak m]\perp\mathfrak m$; and $(a\in\mathfrak m,b\in\mathfrak r)$ is not either, which by antisymmetry gives $[\mathfrak m,\mathfrak m]\perp\mathfrak r$. Hence **$[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$**.
- For $a\in\mathfrak r$, **no** pair $(a,b)$ is a support pair whatever $b$ is, so $[v,\varphi_a]$ has zero component on every basis vector: **$[\mathfrak m,\mathfrak r]=0$**.

**All three inclusions are exactly what §4 gives, and the "for every unit $v$" is load-bearing for the first two**, a single $v$ would give only $v\perp[\mathfrak m,\mathfrak m]$, not $\mathfrak m\perp[\mathfrak m,\mathfrak m]$. **The block establishes the "for every $v$" version. C12 confirmed: what L71 consumes is what this block proves.**

**C11, the L23 reduction, checked.** On the two-eigenvalue family $\mathfrak r=0$ and $\mathfrak h$ is a subalgebra, so the $(\mathfrak h,\mathfrak h)$ block of $\mathrm{ad}(v)$ vanishes automatically ($\langle v,[\mathfrak h,\mathfrak h]\rangle\subseteq\langle\mathfrak m,\mathfrak h\rangle=0$) and only the $(\mathfrak m,\mathfrak m)$ block can obstruct. So saturation $\iff[\mathfrak m,\mathfrak m]\perp\mathfrak m\iff[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, which with $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ and $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$ (from ad-invariance and $\mathfrak m=\mathfrak h^\perp$) is precisely a $\mathbb Z_2$-grading, i.e. a symmetric pair. **Confirmed, and "with no computation" is accurate.** *Caveat on the downstream half*: "the balanced $\mathfrak{so}(m)\oplus\mathfrak{so}(m)$ is the only symmetric pair that is critical" is [L23](../results.md)'s and rests on **Cartan's classification**, which [conventions.md](../findings/conventions.md) records as *"cited to no source anywhere on the record"*, [references/](../references/) holds no Helgason and no Cartan. **That step of L70's Lie-theoretic corollary rests on an unread source.** The identity, its sign and its equality case do not.

## 8. Comparing the forms

| site | what it says | status |
|---|---|---|
| [bounds.md](../findings/bounds.md):216–240 | the boxed identity, $D\ge0$ "provided strict", "**needs $\lVert W\rVert=1$**", the excluded-index blockquote (repaired headline), the dimension theorem, the L23 reduction | **the fullest form; carries D1 and D3** |
| [results.md](../results.md):583 (canonical) | hypothesis "$\lambda_{\min}<0\le\lambda_{\max}$ by $\mathop{\mathrm{tr}}W=0$"; identity; $D\ge0$; equality clause; then the **excluded-index sentence unrepaired** | **carries D2 and D3; no unit-norm clause, but "critical point" carries $\lVert W\rVert=1$ by [conventions.md](../findings/conventions.md), so the omission is benign** |
| [results.md](../results.md):194 (landscape) | identity, $D\ge0$, "given $\lambda_{\min}<0\le\lambda_{\max}$", equality clause | **carries D3**; otherwise a faithful compression |
| [results.md](../results.md):39 (achievements) | "the deficiency identity … at every critical point (Lemma L70)" | drops "for every unit $v\in E_{\min}$" and $D$'s definition. Harmless as a pointer, **but a reader takes $D$ to be defined elsewhere and it is defined only at :194 and :583** |
| [lean/INDEX.md](../lean/INDEX.md):271 | row for L70: **partial**. Three side facts formalised (strict signs make $\lambda_{\min}\lambda_{\max}$ minimal; tracelessness supplies them; the all-negative failure at $(-3,-2,-1)$), plus a point check | **carries D4**; and see below |
| [lean/INDEX.md](../lean/INDEX.md):351 | "`[ ]` **L70** *(the identity)*, the boxed identity itself and its equality case, which yield L71's three inclusions" | **correct and honest: the identity is not formalised** |

**On the Lean row, what it would have to claim.** The row is right that the identity and equality case are owed. What is formalised is exactly the §3 content, with, notably, the strict signs used where §3 shows non-strict signs suffice, so the Lean side inherits D3's over-tight hypothesis. **A row claiming the identity would have to carry**: criticality as $Q(W)=\theta W$ with $\lVert W\rVert=1$, [L153](../findings/bounds.md)'s mass at a non-basis unit $v$, the $\#$-diagonal formula of §2 step (1), and $\lambda_{\min}\ne0$, that is, it would have to formalise $\langle v,W^\#v\rangle=\tfrac12\sum\lambda_a\lambda_bc_{vab}^2$, which is the one step in §2 that is a convention commitment rather than algebra.

## 9. The named trap, read claim by claim as a consumer would

The round warns that this record's signature failure is a correction landing **beside** the statement it corrects. **This block contains three live instances and the Lean index a fourth.**

> **DISCREPANCY D2, the canonical form carries a sentence the record has already refuted, and knows it has.**
>
> **Located.** [results.md](../results.md):583: *"The subtracted constant $\lambda_{\min}\lambda_{\max}$ is attained only on pairs containing the row index, which $c_{vab}$'s support excludes, so the boxed form is the weakened member of a per-row family whose sharp member subtracts $m_1$…; the two coincide whenever $\lambda_{\min}$ has multiplicity at least $2$…"*
>
> **Exhibited.** The clause is false at $W_{\mathbb{CP}^2}$, $n=4$, the record's own $n=4$ saturating witness. There $\dim E_{\min}=2$: take $v$ and a second unit $\varphi_{a'}\in E_{\min}$ with $\varphi_{a'}\perp v$, and $\varphi_b$ spanning $E_{\max}$. The pair $(a',b)$ attains $\lambda_a\lambda_b=\lambda_{\min}\lambda_{\max}$ and **is inside the support**: $c_{v a' b}=\langle[v,\varphi_{a'}],\varphi_b\rangle\ne0$, since $\mathfrak m=\langle v,\varphi_{a'}\rangle$ and $[\mathfrak m,\mathfrak m]=\mathfrak h=\langle\varphi_b\rangle$ inside $\mathfrak{su}(2)_+$. The exclusion $c_{vab}=0$ from total antisymmetry removes the **vector** $v$, not the **eigenvalue** $\lambda_{\min}$. So $m_1=\lambda_{\min}\lambda_{\max}$ and the boxed form is not weakened at all here. The sentence and its own tail clause contradict each other within one sentence, and the false half comes first.
>
> **Argued the opposite.** The charitable reading is that "the row index" means "any index carrying the eigenvalue $\lambda_{\min}$", under which the sentence would be a statement about a simple $\lambda_{\min}$ and true there. That reading is refuted by the sentence's own tail, "the two coincide whenever $\lambda_{\min}$ has multiplicity at least $2$" is unsayable if the constant is never attained inside the support, and by [bounds.md](../findings/bounds.md):224, where the same sentence is explicitly labelled *"**false whenever $\dim E_{\min}\ge2$**"*, and by [LEDGER.md](../findings/LEDGER.md):1240, which records the refutation **and ends "Copied verbatim into [results.md](../results.md)."** Candidate stands.
>
> **Impact.** Nil on the mathematics: by C9 saturation forces $\dim E_{\min}\ge n/2\ge2$, so the sharp and weak forms coincide wherever L70 is used, and [L71](../results.md) is untouched. **The damage is that the canonical, most-cited form of a Tier 1 lemma asserts a falsehood about its own sharpness, with the refutation on file in two other places and applied in neither.** [REVIEW_r565.md](../reviews/REVIEW_r565.md) recommendation 1 and [REVIEW_r566.md](../reviews/REVIEW_r566.md) recommendation 1 both asked for this exact edit to [results.md](../results.md); [bounds.md](../findings/bounds.md) got it and [results.md](../results.md) did not.

> **DISCREPANCY D4, the Lean index's point check names the wrong point.**
>
> **Located.** [lean/INDEX.md](../lean/INDEX.md):271: *"at padded `W_{ℂP²}` the deficiency **vanishes**, `λ_min + (n-2)λ_max = -1 + 2·2 = 3`"*.
>
> **Exhibited.** The coefficient $(n-2)=2$ is $n=4$, so the arithmetic is **unpadded** $W_{\mathbb{CP}^2}$ on $\Lambda^2\mathbb R^4$. At the padded operator, $n\ge5$, §6.3 gives $D=(n-4)/3>0$ ($1/3$ at $n=5$) and [bounds.md](../findings/bounds.md):640 says the same in words: *"padded $W_{\mathbb{CP}^2}$ has $\lVert[\mathfrak m,\mathfrak r]\rVert=2.8$ and deficiency $(n-4)/3$, never $0$."* So the row states of the padded object exactly what the record elsewhere denies of it.
>
> **Argued the opposite.** "Padded $W_{\mathbb{CP}^2}$" could be read as the record's standing name for the whole family including its $n=4$ member, in which case the row is loosely worded rather than wrong. That reading fails because the family's defining property in this record is that padding is what makes it a witness at $n\ge5$, it is the object [L44](../findings/problem.md) uses to break the cone for $4\le n\le11$, and because the row's own conclusion, that this is where "[post 41](../findings/INDEX-traps.md) records the LP being *exactly tight*", is a statement about a specific point. Candidate stands. **Impact: nil on the Lean file's content, which proves an arithmetic identity that is true at $n=4$; the defect is the label.**

**Reading each citable claim alone**, as a consumer would:

- *"$\theta=\lambda_{\min}+(n-2)\lambda_{\max}-D(v)/\lvert\lambda_{\min}\rvert$ at every critical point"*, **safe to cite**, with $D$ as defined and $\lVert W\rVert=1$ read out of "critical point".
- *"$D(v)\ge0$"*, **safe to cite** on $\mathcal W_n\setminus\{0\}$; do not carry it off $\mathcal W_n$ without checking $\lambda_{\min}\le0\le\lambda_{\max}$.
- *"equality iff $\mathrm{ad}(v)$ supported on $E_{\min}\otimes E_{\max}$ for every unit $v\in E_{\min}$"*, **safe to cite**.
- *"the identity does not need unit norm"*, **do not cite: false** (D1).
- *"the subtracted constant is attained only on pairs containing the row index"* / *"the boxed form is the weakened member"*, **do not cite: false whenever $\dim E_{\min}\ge2$**, hence false at every point where the record uses L70 (D2).
- *"saturation forces $\dim E_{\min}\ge n/2$, $\dim E_{\max}\ge(n-2)/2$"*, **safe to cite**, with the argument at [REVIEW_r566.md](../reviews/REVIEW_r566.md) §4 rather than in the block.
- *"the saturating members of [L23](../results.md)'s family are exactly the balanced sphere products"*, **cite with the Cartan caveat**: the "only symmetric pair that is critical" half rests on a classification cited to no source in [references/](../references/).

## 10. The gap between what is proven and what is used

**Proven here**: the identity; $D\ge0$ under $\lambda_{\min}\le0\le\lambda_{\max}$; the equality characterisation under $\lambda_{\min}<0<\lambda_{\max}$; the $v$-independence of $D$; C9; the L23 reduction to a symmetric pair.

**Not proven anywhere on file, and not claimed to be**: the boxed identity in Lean ([lean/INDEX.md](../lean/INDEX.md):351 lists it open). **Resting on an unread source**: Cartan's classification, used by [L23](../results.md) and [L71](../results.md) downstream, not by L70 itself.

**No hypothesis debt in L70.** Every step of §2 has its warrant on the record: criticality is [conventions.md](../findings/conventions.md)'s definition, the mass is [L153](../findings/bounds.md) in its widened form, the $\#$-diagonal is the $\#$-normalisation of [conventions.md](../findings/conventions.md) and anchors exactly against $I^\#=(n-2)I$, and $Q$ preserving $\mathcal W_n$ is proved at [problem.md](../findings/problem.md) from [BW08](../references/boehm-wilking-2008-space-forms/).

## 11. What would break it, and what I did to look

**The object that would falsify the identity**: a critical point $W\in\mathcal W_n$, $\lVert W\rVert=1$, with two unit vectors $v,v'\in E_{\min}$ at which $\sum_{a,b}\lambda_a\lambda_bc_{vab}^2\ne\sum_{a,b}\lambda_a\lambda_bc_{v'ab}^2$. **No such object can exist**, and the reason is one line: at a critical point $W^\#=\theta W-W^2$ is a polynomial in $W$, so $\langle v,W^\#v\rangle=\theta\lambda_{\min}-\lambda_{\min}^2$ on the whole unit sphere of $E_{\min}$. I looked for this by checking the eigenspace-constancy the record itself flags as owed, and it closes.

**The object that would falsify $D\ge0$**: a $W\in\mathcal W_n\setminus\{0\}$ whose $\Lambda^2$ spectrum has a pair with $\lambda_a\lambda_b<\lambda_{\min}\lambda_{\max}$. **Impossible**: §3 exhausts the three sign cases using only $\lambda_{\min}\le0\le\lambda_{\max}$, which $\mathop{\mathrm{tr}}W=0$ gives. The nearest real object is the block's all-negative spectrum, which is not a traceless one.

**The object that would falsify the equality characterisation**: a critical $W$ with $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$ and some $v\in E_{\min}$ with $\mathrm{ad}(v)$ carrying mass off $E_{\min}\otimes E_{\max}$. **Impossible** by the uniqueness of the minimising eigenvalue pair under strict signs (§3, case (iii) equality).

**The object that would falsify C9**, and so reopen D2's consequence: a saturating critical point with $\dim E_{\min}=1$. **Excluded** by §6.1 in two lines from [L31](../findings/stratum-two-negative.md) and [L153](../findings/bounds.md). I looked at the four families the record names, balanced products, $W_{\mathbb{CP}^2}$ padded and unpadded, maximal tori, $\mathrm{ad}(\mathfrak{su}(3))$, and at $W_{\mathbb{CP}^m}$ for $m\ge3$, where $\dim E_{\max}=1<m-1$ forbids saturation. **Nothing found; and the two bounds are attained simultaneously at exactly one object on the record, $W_{\mathbb{CP}^2}$ at $n=4$.**

## Verdict

**PROVEN, hypotheses corrected.**

The boxed identity, the sign of $D$, and the equality characterisation are all correct, and all three rebuild from the record's own conventions in under a page. The corrections owed are:

1. **[bounds.md](../findings/bounds.md):224, strike "unit norm" from the list of what the identity does not need.** It is contradicted by [bounds.md](../findings/bounds.md):222, and 222 is right. **(D1, live.)**
2. **[results.md](../results.md):583, strike "The subtracted constant $\lambda_{\min}\lambda_{\max}$ is attained only on pairs containing the row index, which $c_{vab}$'s support excludes."** It is false whenever $\dim E_{\min}\ge2$, its refutation is already written at [bounds.md](../findings/bounds.md):224 and [LEDGER.md](../findings/LEDGER.md):1240, and two reviewers asked for this edit. **(D2, live.)**
3. **Move the strictness.** $D\ge0$ needs only $\lambda_{\min}\le0\le\lambda_{\max}$; $\lambda_{\min}<0<\lambda_{\max}$ is what the *equality* clause needs, and $\lambda_{\min}\ne0$ is what the *division* needs. [results.md](../results.md):194 and :583's "$\lambda_{\min}<0\le\lambda_{\max}$" licenses the sign but not the equality clause stated beside it. **(D3.)**
4. **[lean/INDEX.md](../lean/INDEX.md):271, the point check is at unpadded $W_{\mathbb{CP}^2}$, $n=4$**, not at the padded object, whose deficiency is $(n-4)/3>0$. **(D4.)**

**None of the four moves [Lemma L71](../results.md)**, which consumes the scalar condition $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$ and reads off three bracket inclusions that §7 derives in full from what this block establishes.
