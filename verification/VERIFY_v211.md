# VERIFY_v211, L30, cold read

**The brief was read cold**, from [BRIEF_L30.md](BRIEF_L30.md), with [conventions.md](../findings/conventions.md) as the only other primary source; the block's surroundings in [stratum-two-negative.md](../findings/stratum-two-negative.md) and the register rows were read afterwards, to place the debt rather than to build the argument. **No numerical work of any kind was done**, no script, no Sage, no Python, no numeric evaluation. Every object below is exhibited in closed form. Log: `agent_logs/verify-L30-v211.log`.

## Claim table

| # | claim, as the record states it | verdict |
| --- | --- | --- |
| 1 | $\mathrm{Ric}(W)(x,x)=\sum_\alpha\lambda_\alpha\lVert v_\alpha x\rVert^2$, so Ricci-flatness is $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=0$ | **CORRECT**, with constant exactly $1$ in this record's conventions |
| 2a | "the positive and negative sides are the same matrix" | **CORRECT**, and it is a rearrangement rather than a step |
| 2b | that matrix's "image is contained in $U$" | **CORRECT**; the image is in fact equal to $U$ |
| 2c | "every eigenvector with nonzero eigenvalue has its image inside $U$" | **CORRECT** |
| 3 | "$v_\alpha u=0$ for every $\alpha$ with $\lambda_\alpha\ne0$", hence $W(u\wedge w)=0$ | **CORRECT**, and the $\lambda_\alpha\ne0$ qualifier is necessary |
| 4 | the named witness $e_9\wedge e_{10}$ at padded $W_{\mathbb{CP}^2}$ in $\mathcal W_{10}$ | **HOLDS**, at $u=e_9$, **and fails at the reader's first choice $u=e_5$**, which the record does not name |
| 5 | "at most two negative eigenvalues" is used somewhere other than in defining $U$ | **REFUTED**, it is used nowhere else; the blockquote is right in both of its halves |
| 6 | "$W$ vanishes on $u\wedge u^\perp$ for every $u\perp U$" | **CORRECT** |
| 7 | "The restriction to $\Lambda^2(U)$ is Ricci-flat because the terms of $\mathrm{Ric}$ involving directions outside $U$ vanish with $W$" | **CORRECT**, terse but sound |
| 8 | "$W$ is a padding of a $\mathrm{Weyl}_{\dim U}$ tensor" | **CORRECT**, with one unstated step (first Bianchi restricts) |
| 9 | "**with the same norm and the same $\theta$**" | **GAP, no argument on file in this block, and it is the clause the lemma exists for** |
| 10 | is $\Lambda^2U=\mathfrak{so}(U)$ being a Lie subalgebra enough for clause 9? | **YES, it is enough**, and the record does not say so anywhere the proof pointer reaches |
| 11 | does $Q$ on the padded tensor agree with $Q$ computed in $\mathcal W_{\dim U}$? | **YES**, and this too is absent from the block |
| 12 | scope "$n=6,7,8$" (block) | **WRONG AT THE LOW END**, $n=5$ belongs |
| 13 | scope "below $n=9$" (development form, $34$ lines above) | **WRONG AT THE LOW END**, it admits $n=4$, where $\dim U=n$ |
| 14 | scope "$n=5,6,7,8$" (the blockquote's annotation) | **CORRECT** |
| 15 | the crossover $n=6+2\sqrt7$ bears on this lemma | **REFUTED**, the argument is dimension-free and the crossover never enters |
| 16 | symbol collisions ($U$, $v_\alpha$, $\lambda$, $N$, $q$, $r$, $\mathring R$, $x$) | **CLEARED** for the block, with two recorded below |

**One line.** The identity and the whole descent are correct, and correct for any number of negative eigenvalues once $U$ is read as $\sum_{\lambda_\alpha<0}\operatorname{im}v_\alpha$, but the statement's third conclusion, *"with the same norm and the same $\theta$"*, has no argument in the block that [results.md](../results.md) names as its proof, so **the verdict is `GAP`**.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated:

- The pairing the whole argument runs in: *"**This record's norm is $\lVert Z\rVert^2=\tfrac12\operatorname{tr}(Z^{\mathsf T}Z)$**, so $\lVert Z\rVert_F^2=2\lVert Z\rVert^2$"*; and *"A skew matrix's norm, in the form the stratum arguments use: $\langle X,X\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}X)$ … Equivalent to $\operatorname{tr}(v^2)=-2$ above."*
- The bivector normalisation that pins the constant in claim 1: *"**A bivector's norm**, and the record runs in the first of these: $\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing of the bullet above, which is the one every result uses and which makes $\{\varphi_{ab}\}_{a<b}$ orthonormal."*
- What $\mathrm{Ric}$ is: *"$\mathrm{Ric}$ is the adjoint of $\cdot\wedge\mathrm{id}$, with $\lVert\mathrm{Ric}\rVert$ the Frobenius norm of the resulting symmetric matrix."* The block's own file gives the working form $34$ lines above L30: *"$\mathrm{Ric}(u,u)=\sum_j\langle W(u\wedge f_j),u\wedge f_j\rangle$ for $\{f_j\}$ an orthonormal basis of $u^\perp$."*
- What $\theta$ is: *"$\theta$ | $P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$"*, with *"$Q(W)$ | Hamilton's quadratic map $W^2+W^\#$"* and *"$P(W)$ | the cubic form $\langle W,Q(W)\rangle$"*.
- The $\#$ normalisation: *"$\#$ is the halved Böhm–Wilking product, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$"*.
- $N$: *"$N$ | $\binom n2=\dim\Lambda^2\mathbb R^n$"*.
- And the bullet that is the *whole* of the record's support for claim 9: *"**Padding commutes with $Q$**, and preserves both the norm and $\theta$. The stratum reduction turns on this."* **It carries no proof and no citation, and it is in a file the block does not quote.**

## The hypothesis inventory

| hypothesis | stated where | where the proof actually uses it | verdict |
| --- | --- | --- | --- |
| $W\in\mathrm{Weyl}_n$, i.e. $\mathrm{Ric}(W)=0$ | statement | the first sentence, and again at the restriction step | **used, load-bearing** |
| $W$ self-adjoint on $\Lambda^2$ with an orthonormal eigenbasis $\{v_\alpha\}$ | implicit in "$v_{N-1},v_N$ read as skew matrices" | the identity, and the invariance of $\Lambda^2U$ under $W$ | **used, unstated** |
| "at most two negative eigenvalues" | statement | **only** in making $U=\operatorname{im}v_{N-1}+\operatorname{im}v_N$ coincide with $\operatorname{im}A_-$ | **used once, and only definitionally** |
| $\dim U<n$ | statement | the existence of a $u\perp U$; nothing else | **used, load-bearing** |
| $\dim U\ge4$ | **nowhere** | needed for "$\mathrm{Weyl}_{\dim U}$ tensor" to be a nonzero object | **unstated, but automatic** (§7) |
| $\Lambda^2U=\mathfrak{so}(U)$ is a Lie subalgebra | **nowhere in the block**, only in the blockquote above it | would be needed for the $\theta$ half of clause 9 | **the debt** (§6) |
| first Bianchi restricts from $\mathbb R^n$ to $U$ | **nowhere** | needed for $W|_{\Lambda^2U}\in\mathrm{Weyl}_{\dim U}$, of which the block proves only Ricci-flatness | **unstated, true, mechanical** |
| $\lambda_\alpha\ne0$ at the descent step | stated, in bold, with a witness | the step $u\perp U\Rightarrow v_\alpha u=0$ | **used, and necessary** (§4) |
| criticality $Q(W)=\theta W$ | **not assumed** | nowhere | **correctly absent**, L30 is a statement about every Weyl tensor, not only critical ones |

**Two hypotheses that are *not* present and are worth stating positively**: L30 never assumes $\ker W=0$, and it never assumes $n$ lies in any range. The lemma is dimension-free.

## 1. The identity, derived

Write $W=\sum_\alpha\lambda_\alpha\,v_\alpha\otimes v_\alpha$ in an orthonormal eigenbasis of $\Lambda^2\mathbb R^n$, so that $\langle W(Z),Z\rangle=\sum_\alpha\lambda_\alpha\langle v_\alpha,Z\rangle^2$. Take the identification $u\wedge w\mapsto uw^{\mathsf T}-wu^{\mathsf T}$; it is the one the conventions force, since it sends $e_a\wedge e_b$ to $\varphi_{ab}=E_{ab}-E_{ba}$, which the quoted bullet requires to be orthonormal under the half-trace pairing.

For skew $v$ and any $x,e\in\mathbb R^n$, with $X=xe^{\mathsf T}-ex^{\mathsf T}$,

$$\langle v,X\rangle=\tfrac12\operatorname{tr}(v^{\mathsf T}X)=-\tfrac12\big(e^{\mathsf T}vx-x^{\mathsf T}ve\big)=-e^{\mathsf T}vx,$$

the last step because $x^{\mathsf T}ve=(x^{\mathsf T}ve)^{\mathsf T}=e^{\mathsf T}v^{\mathsf T}x=-e^{\mathsf T}vx$. **Anchor**: $v=\varphi_{12}$, $x=e_1$, $e=e_2$ gives $\langle\varphi_{12},\varphi_{12}\rangle=1$ on the left and $-e_2^{\mathsf T}\varphi_{12}e_1=-e_2^{\mathsf T}(-e_2)=1$ on the right.

Hence, for $\{e_j\}$ any orthonormal basis of $\mathbb R^n$,

$$\mathrm{Ric}(W)(x,x)=\sum_j\langle W(x\wedge e_j),x\wedge e_j\rangle=\sum_\alpha\lambda_\alpha\sum_j\langle e_j,v_\alpha x\rangle^2=\sum_\alpha\lambda_\alpha\lVert v_\alpha x\rVert^2 .$$

**The constant is exactly $1$**, and the $j$ with $e_j\parallel x$ drops of its own accord, so the record's $u^\perp$-form and the full-frame form agree. **Second anchor, closed form**: at the round sphere $W=\mathrm{Id}$ on $\Lambda^2\mathbb R^n$, the left side is $n-1$ and the right side is $\sum_{a<b}\lVert\varphi_{ab}e_1\rVert^2=n-1$, the only surviving terms being $\varphi_{1b}e_1=-e_b$.

Polarising, $\mathrm{Ric}(W)=\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha$ as a symmetric matrix, with each $v_\alpha^{\mathsf T}v_\alpha\succeq0$. So Ricci-flatness is exactly $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=0$. **Claim 1 holds.**

**Index conventions checked against [conventions.md](../findings/conventions.md).** The identity needs three of them and gets all three: the half-trace pairing, the $\varphi_{ab}$-orthonormal bivector normalisation, and $\mathrm{Ric}$ as the frame sum. It needs *none* of the ones this file flags as dangerous, the $\mathring R$ index order (Li's $iklj$ against BK's $ikjl$), the $\operatorname{scal}=2\operatorname{tr}$ convention, and the $\lvert W\rvert^2=4\lVert W\rVert_F^2$ conversion all sit outside the argument. **This matters**, because [conventions.md](../findings/conventions.md) records that *"[stratum-two-negative.md](../findings/stratum-two-negative.md) is written throughout in BK's $ikjl$"* and that *"its operator is $-\mathring W$, so its $\lambda_{\max}(\mathring R)\le1$ statements read $\lambda_{\min}(\mathring W)\ge-1$ in the record's order"*, with the conversion *"queued for a verification round"*. **L30 is untouched by that queue**: it uses $W$ as an operator on $\Lambda^2$ and $\mathrm{Ric}$, and never the second-kind operator.

**Robustness.** Had the record run in plain Frobenius instead, the identity would carry a positive constant. Every use L30 makes of it (that the two sides are equal, that the terms are PSD), is invariant under a positive rescale. So the block's silence about which normalisation it is in costs it nothing here.

## 2. The image step, both halves separately

Set $A_+=\sum_{\lambda_\alpha>0}\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha\succeq0$ and $A_-=\sum_{\lambda_\alpha<0}(-\lambda_\alpha)v_\alpha^{\mathsf T}v_\alpha\succeq0$.

**First half, "the positive and negative sides are the same matrix."** §1 gives $A_+-A_-=0$. This is a rearrangement of the identity, not a step, and it is correct. **Claim 2a holds.**

**Second half, part one, the image is in $U$.** For skew $v$, $\ker(v^{\mathsf T}v)=\ker v$ and so $\operatorname{im}(v^{\mathsf T}v)=(\ker v)^\perp=\operatorname{im}v$. For a finite sum of PSD matrices the image is the sum of the images, so

$$\operatorname{im}A_-=\sum_{\lambda_\alpha<0}\operatorname{im}v_\alpha .$$

Under "at most two negative eigenvalues", $v_{N-1},v_N$ exhaust the negative spectrum and this is exactly $U$. **So the image is not merely contained in $U$, it equals $U$.** The block's weaker phrasing is true and is all the argument needs. **Claim 2b holds.**

*A well-definedness check the block does not make and passes.* Under a repeated negative eigenvalue the pair $v_{N-1},v_N$ is not determined by $W$, but $U$ is: for any $v=av_{N-1}+bv_N$, $\operatorname{im}v\subseteq\operatorname{im}v_{N-1}+\operatorname{im}v_N$, so $\sum_{v\in\mathfrak m}\operatorname{im}v=U$ for every orthonormal basis of the negative eigenspace $\mathfrak m$. **$U$ is a function of $W$ alone.** This is what makes the block's own "Scope, stated" paragraph (*"under a repeated negative eigenvalue those are not determined by $W$"*), a remark about the *ranks* and not about $U$, which is the correct reading.

**Second half, part two, every $\operatorname{im}v_\alpha$ with $\lambda_\alpha\ne0$ sits inside $U$.** If $A_+x=0$ then $0=x^{\mathsf T}A_+x=\sum_{\lambda_\beta>0}\lambda_\beta\lVert v_\beta x\rVert^2$, a sum of nonnegative terms with strictly positive weights, so $v_\beta x=0$ for every $\beta$ with $\lambda_\beta>0$. Hence $\ker A_+\subseteq\ker v_\beta$, and taking orthogonal complements with $\operatorname{im}v_\beta=(\ker v_\beta)^\perp$ (valid because $v_\beta$ is skew),

$$\operatorname{im}v_\beta\subseteq(\ker A_+)^\perp=\operatorname{im}A_+=\operatorname{im}A_-=U .$$

For $\lambda_\alpha<0$ the containment is definitional. **Claim 2c holds.** The positivity of the weights is exactly where "$\lambda_\alpha\ne0$" earns its place: a zero weight carries no information about its term.

## 3. The descent, and $W$ vanishing on $u\wedge u^\perp$

Let $u\perp U$. Then $u\perp\operatorname{im}v_\alpha=(\ker v_\alpha)^\perp$ for every $\alpha$ with $\lambda_\alpha\ne0$, so $u\in\ker v_\alpha$, i.e. $v_\alpha u=0$. By §1's pairing formula, $\langle v_\alpha,u\wedge w\rangle=-w^{\mathsf T}v_\alpha u=0$ for every $w$. Therefore

$$W(u\wedge w)=\sum_\alpha\lambda_\alpha\langle v_\alpha,u\wedge w\rangle\,v_\alpha=0,$$

the terms with $\lambda_\alpha\ne0$ dying by the pairing and the terms with $\lambda_\alpha=0$ by the coefficient. **Claims 3 and 6 hold.** Note that $u\wedge u^\perp$ and $\{u\wedge w:w\in\mathbb R^n\}$ are the same set, since $u\wedge u=0$, so the statement's narrower phrasing loses nothing.

## 4. The kernel trap, and the named witness checked

**The trap is live in both directions here, because the lemma is about paddings.** The block anticipates it and the anticipation is correct.

**The witness holds.** Padded $W_{\mathbb{CP}^2}$ in $\mathcal W_{10}$: the tensor is supported on $\Lambda^2\operatorname{span}(e_1,\dots,e_4)$, its two negative eigenvectors are self-dual forms of rank $4$, so $U=\operatorname{span}(e_1,\dots,e_4)$ and $\dim U=4<10$. Every bivector outside $\Lambda^2\mathbb R^4$ is a $0$-eigenvector; $\varphi_{9,10}=e_9\wedge e_{10}$ is one. Take $u=e_9$, which is orthogonal to $U$. Then

$$\varphi_{9,10}\,e_9=(E_{9,10}-E_{10,9})e_9=-e_{10}\ne0 ,$$

and $\operatorname{im}\varphi_{9,10}=\operatorname{span}(e_9,e_{10})\not\subseteq U$. **So "$v_\alpha u=0$ for all $\alpha$" is false as an unrestricted claim, and the bolded $\lambda_\alpha\ne0$ qualifier is necessary rather than decorative.** Claim 4 holds.

**And a presentational defect inside the witness, which I record because the next reader will hit it.** The record names $e_9\wedge e_{10}$ and **does not name $u$**. The reader's natural choice, following the block's own scope paragraph, is $u=e_5$ (the first coordinate orthogonal to $U$) and there $\varphi_{9,10}e_5=0$, so the witness appears to fail. The witness needs a $u$ inside $\operatorname{im}\varphi_{9,10}$, i.e. $u\in\operatorname{span}(e_9,e_{10})$. *Discrepancy protocol*: located (the parenthesis in the block's proof); exhibited ($\varphi_{9,10}e_5=0$ in closed form); opposite argued, the claim being refuted is universally quantified over $u\perp U$, so one $u$ suffices and $e_9$ supplies it, and the record's sentence is therefore **true as written and incomplete as an exhibit**. Reported as a presentational note, not as a discrepancy against the mathematics.

## 5. "At most two", the hypothesis is inert, and the blockquote is right twice over

**It is used nowhere except in the definition of $U$.** Tracing §§1–3: the identity uses no count; $\operatorname{im}A_-=\sum_{\lambda_\alpha<0}\operatorname{im}v_\alpha$ uses no count; the $\ker A_+$ argument uses no count; the descent uses no count. The single place the count enters is the step $\operatorname{im}A_-=U$, which needs the two named eigenvectors to exhaust the negative spectrum.

**The correct statement, stated.** With

$$U:=\sum_{\lambda_\alpha<0}\operatorname{im}v_\alpha,$$

every step of §§1–3 goes through verbatim for **any** number of negative eigenvalues, with no degradation and with $\dim U=n-1$ admitted. So the corrected statement is:

> Let $W\in\mathrm{Weyl}_n$ and set $U:=\sum_{\lambda_\alpha<0}\operatorname{im}v_\alpha$. If $\dim U<n$ then $W$ vanishes on $u\wedge u^\perp$ for every $u\perp U$, and $W$ is a padding of a $\mathrm{Weyl}_{\dim U}$ tensor.

**And the count is genuinely necessary as the block defines $U$.** I checked the blockquote's own witness rather than taking it: $\mathrm{pad}_{V_1}(W_{\mathbb{CP}^2})+\mathrm{pad}_{V_2}(W_{\mathbb{CP}^2})$ on $\mathbb R^8$, with $V_1=\operatorname{span}(e_1,\dots,e_4)$ and $V_2=\operatorname{span}(e_5,\dots,e_8)$, lies in $\mathcal W_8$ because $\mathcal W_8$ is a linear space and each summand is a padding of a $\mathcal W_4$ element. Each summand contributes two negative eigenvalues, so there are four. Reading $U$ off the two from $V_1$ gives $\dim U=4<8$, while $e_5\perp U$ and $W(e_5\wedge e_6)\ne0$ because $e_5\wedge e_6$ is a positive-eigenvalue direction of the second summand. **So the two annotations do not contradict each other**: the count is inert to the *argument* and necessary to the *definition*, and the one-line redefinition removes both problems at once. **Claim 5 is refuted in the form the brief poses it**, the hypothesis is used nowhere else.

*A second, smaller under-specification the word "at most" creates.* If $W$ has exactly **one** negative eigenvalue, then $v_{N-1}$ is not a negative eigenvector at all; in the eigenvalue ordering it carries $\lambda_{N-1}=0$ whenever $W$ has a kernel, and a kernel eigenvector is not determined by $W$. Then $U$ depends on an arbitrary choice and $\dim U$ (hence the dimension of the tensor the padding descends to), is not a function of $W$. **The conclusion does not fail**, because the chosen $U$ always contains $\operatorname{im}A_-$ and a larger $U$ only weakens both clauses. But it is a second reason the redefinition is the right repair, and it is not among the four the blockquote records.

## 6. "With the same norm and the same $\theta$", the gap

**The block's proof does not touch either half.** Its four sentences are: the identity; the same-matrix and image step; the descent to $W(u\wedge w)=0$; and the Ricci-flatness of the restriction. It stops there. **Neither the word "norm" nor the symbol $\theta$ appears in the proof.** The blockquote's assertion that the clause *"was asserted and never proved"* is, as a description of this block, **correct**, and I confirm it independently.

**This is the clause the lemma exists for.** The block's own opening line says so (*"that is what lets a bound proved in low dimension govern every $n$"*) and [results.md](../results.md) carries the clause in the canonical statement while pointing here for the proof. **So the record's proof pointer resolves to a block that proves two of the statement's three conclusions.**

**What would have to be proved, named exactly.** Let $W'=W|_{\Lambda^2U}$ and let $\mathrm{pad}$ be the extension by zero. Three obligations, and no more:

1. **$W'$ is an element of $\mathrm{Weyl}_{\dim U}$**, not merely a Ricci-flat symmetric operator: the pair symmetries and the **first Bianchi identity** must be shown to restrict from $\mathbb R^n$ to $U$. *The block proves the Ricci-flatness half and states neither of the others.*
2. **$\lVert W\rVert=\lVert W'\rVert$**, where the left norm is taken in $\mathcal W_n$ and the right in $\mathcal W_{\dim U}$. What has to be shown is that the inclusion $\Lambda^2U\hookrightarrow\Lambda^2\mathbb R^n$ is an isometry for the record's half-trace pairing, so that an orthonormal basis of $\Lambda^2U$ extends to one of $\Lambda^2\mathbb R^n$ and $W$'s matrix in it is $W'\oplus0$.
3. **$P(W)=P(W')$**, hence $\theta(W)=\theta(W')$. This splits: $\langle W,W^2\rangle=\operatorname{tr}(W^3)$ needs only that padding adds zero eigenvalues; $\langle W,W^\#\rangle$ needs that $\#$, computed with the structure constants of $\mathfrak{so}(n)$, agrees with $\#$ computed with those of $\mathfrak{so}(\dim U)$.

**I am not supplying these.** What the brief does ask me to settle is whether the two ingredients the annotation names are the *right* ones, and they are:

- **Is $\Lambda^2U=\mathfrak{so}(U)$ being a Lie subalgebra enough for obligation 3? Yes.** In $\langle Z,X\# Y\rangle=\tfrac12\sum c_{acd}c_{bef}X_{ce}Y_{df}Z_{ab}$, a nonzero $Z_{ab}$ forces $a,b$ into the $\mathfrak{so}(U)$ block, a nonzero $X_{ce}$ forces $c,e$, and a nonzero $Y_{df}$ forces $d,f$. **All six indices are driven inside by the support of the three tensors alone**, and the surviving structure constants $c_{acd}$ with $a,c,d\in\mathfrak{so}(U)$ are the structure constants of $\mathfrak{so}(U)$ precisely because it is a subalgebra. Nothing stronger than "subalgebra" is used, in particular no ideal property, no orthogonality of the complement under the bracket, and no unit anywhere. **This last point matters on this record**: the brief warns that one route died on a cited theorem assuming a unital algebra, and $\mathcal W_n$ has no unit; the subalgebra argument never asks for one.
- **Does $Q$ on the padded tensor agree with $Q$ computed in $\mathcal W_{\dim U}$? Yes, and it is the stronger operator statement rather than the quadratic form.** $W^2$ is immediate. For $W^\#$: $(W\# W)_{ab}$ requires $c,d,e,f$ inside for a nonzero contribution, and then $c_{acd}=\langle[\varphi_c,\varphi_d],\varphi_a\rangle$ vanishes unless $a$ is inside too, because $[\varphi_c,\varphi_d]\in\mathfrak{so}(U)$. So $W\#W$ is itself supported in $\mathfrak{so}(U)$ and equals $W'\#W'$ there, i.e. $Q\circ\mathrm{pad}=\mathrm{pad}\circ Q$. **The subalgebra property is exactly what is needed and exactly what suffices.**

**Where the clause does have support, and why it does not close the gap.**

| location | what it holds | why it is not the block's proof |
| --- | --- | --- |
| [conventions.md](../findings/conventions.md) | *"Padding commutes with $Q$, and preserves both the norm and $\theta$. The stratum reduction turns on this."* | **a convention bullet with no proof and no citation**, in a file the block does not quote; and this record has already found a neighbouring formulation, *"zero-padding preserves everything"*, **false in part**, see [VERIFY_v10.md](VERIFY_v10.md) §F4 and [ROUND_L04.md](ROUND_L04.md)'s G5, where three readings of "everything" produced three verdicts |
| [lean/INDEX.md:268](../lean/INDEX.md) | records the clause as machine-checked, the norm via [Padding.lean](../lean/HamiltonsCubic/Base/Padding.lean), $\theta$ via [L30b.lean](../lean/HamiltonsCubic/Results/L30b.lean)'s `sharpQF'_padOp` | **the Lean layer is not the record's proof text**, and the same row marks L30 **partial** and states the debt in its own words: *"Owed: instantiating it at a Weyl operator, which needs the Ricci identity in the eigenbasis rather than as an abstract pair of quadratic forms"*. It also flags that the formalisation *"could only state the subalgebra fact inside one"* encoding, i.e. for a **coordinate** subspace |
| the blockquote above the block | names the two lines | **an annotation is not a proof**, and the brief's own instruction is to treat it as a claim to check |

*One remark on the Lean restriction to coordinate subspaces, since it would otherwise read as a further debt.* $\mathcal W_n$, the pairing and $\theta$ are $O(n)$-invariant, so a frame may be chosen in which $U$ is a coordinate subspace at no cost. That is a legitimate reduction, and it is stated nowhere.

**Verdict on claim 9: `GAP`.** The three obligations above are what would have to be written into the block.

## 7. The Ricci-flatness of the restriction, and the padding

**"because the terms of $\mathrm{Ric}$ involving directions outside $U$ vanish with $W$", correct.** Made precise: take an orthonormal basis of $\mathbb R^n$ adapted to $U\oplus U^\perp$. For $x\in U$,

$$0=\mathrm{Ric}(W)(x,x)=\sum_{e_j\in U}\langle W(x\wedge e_j),x\wedge e_j\rangle+\sum_{e_j\in U^\perp}\langle W(x\wedge e_j),x\wedge e_j\rangle ,$$

and every term of the second sum vanishes by §3 applied with $u=e_j$. The first sum is $\mathrm{Ric}(W')(x,x)$ computed in $U$. So $\mathrm{Ric}(W')=0$. **Claim 7 holds**, terse, and sound.

**The padding itself.** $\Lambda^2\mathbb R^n=\Lambda^2U\oplus(U\wedge U^\perp)\oplus\Lambda^2U^\perp$, and §3 kills $W$ on the last two summands, which together are exactly $\{u\wedge w:u\in U^\perp\}$'s span. Self-adjointness then gives $W(\Lambda^2U)\subseteq\Lambda^2U$, so $W=\mathrm{pad}(W')$. **Claim 8 holds**, with the first-Bianchi step unstated (obligation 1 of §6).

**A hypothesis the statement needs and does not state, and which is automatic.** *"a $\mathrm{Weyl}_{\dim U}$ tensor"* is a nonzero object only when $\dim U\ge4$, since $\mathcal W_m=0$ for $m\le3$ by the tabled $\dim\mathcal W_n=\tfrac{n(n-3)(n+1)(n+2)}{12}$. And $\dim U\ge4$ is forced: $W=\mathrm{pad}(W')$ with $W'\in\mathcal W_{\dim U}$, so $\dim U\le3$ gives $W=0$, contradicting the existence of a negative eigenvalue. **Unstated, true, and worth one line.** It is also what makes the blockquote's *"$\dim U=n-1$ admitted"* a claim about $n\ge5$.

## 8. Scope, endpoint by endpoint

The three versions scope the same thing: the $n$ at which padded $W_{\mathbb{CP}^2}$ shows the rank-sum hypothesis strictly weaker than $\dim U<n$. Three conditions, each closed form:

| condition | source | range |
| --- | --- | --- |
| padded $W_{\mathbb{CP}^2}$ exists in $\mathcal W_n$ | it is a padding of a $\mathcal W_4$ element | $n\ge4$ |
| the lemma's hypothesis $\dim U<n$ holds, with $\dim U=4$ | both negative eigenvectors are rank-$4$ self-dual forms, so $U=\operatorname{span}(e_1,\dots,e_4)$ | $n\ge5$ |
| the rank-sum form fails, $4+4=8\ge n$ | the block's own sentence | $n\le8$ |

**The intersection is $n\in\{5,6,7,8\}$.**

- **$n=4$, checked explicitly.** $\dim U=4=n$, so $\dim U<n$ fails and the lemma says nothing. More: at $n=4$ the hypothesis is **vacuous for every $W\ne0$**, since $\dim U<4$ would force $W$ to be a padding of a $\mathcal W_{\le3}=0$ tensor. **So the development form's *"below $n=9$"* wrongly admits $n=4$**, exactly as the annotation says. The lemma is not false there, it is vacuously true, and the *scope remark* is what is wrong.
- **$n=5$, checked explicitly.** $\dim\mathcal W_5=\tfrac{5\cdot2\cdot6\cdot7}{12}=35\ne0$, padded $W_{\mathbb{CP}^2}$ lies in it, $\dim U=4<5$, and the rank sum is $8\ge5$. **All three conditions hold, so $n=5$ belongs, and the block's *"$n=6,7,8$"* omits it.**
- **$n=8$ and $n=9$.** At $n=8$ the rank sum is $8\ge8$, so it belongs; at $n=9$ the rank sum $8<9$ applies and the illustration lapses. **The upper endpoint is right in both the block and the development form.**

**Claim 14 holds; claims 12 and 13 are each wrong at the low end, and at different ends of the low end.** This is a defect in an illustrative scope paragraph, not in a hypothesis, and nothing downstream reads a range off it.

**The crossover $n=6+2\sqrt7\approx11.29$.** It plays no role. §§1–7 contain no $n$-dependent quantity at all (the identity, the PSD step, the descent and the padding are dimension-free) so there is nothing that could change character there. I note in passing that L30's illustrative range $5\le n\le8$ sits entirely below the crossover, which is a property of the witness family (padded $W_{\mathbb{CP}^2}$ is the competitor that wins below it) and not of the lemma. **Claim 15 refuted; recorded because the brief asks and silence is not a verdict.**

## 9. Symbol collisions, cleared one at a time

| symbol | the live senses [conventions.md](../findings/conventions.md) records | what L30's block does |
| --- | --- | --- |
| $U$ | **tabled nowhere**, and defined inline in two blocks of this file; [LEDGER.md](../findings/LEDGER.md) records that its two readings *"once produced two verdicts on one statement"* | uses $\operatorname{im}v_{N-1}+\operatorname{im}v_N$ throughout, consistently; the redefinition $\sum_{\lambda_\alpha<0}\operatorname{im}v_\alpha$ lives only in the annotation. **The two agree under the block's own hypothesis and part without it (§5).** *The letter should be tabled.* |
| $v_\alpha$ | the eigenframe of $W$ on $\Lambda^2$, as in $T_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$ | one sense only. **Cleared** |
| $\lambda$ | the Einstein constant in [L47](../findings/problem.md); $\lambda_{\max}$ carries three senses across [results.md](../results.md); $\lambda_m$ the summand value | L30 uses $\lambda_\alpha$ for $W$'s $\Lambda^2$ eigenvalues only, and never $\lambda_{\max}$. **Cleared** |
| $N$ | $\binom n2$ in the table; $N_v:=2v\otimes v-\mathrm{ad}(v)^2$ in [L33](../findings/stratum-two-negative.md), **sixty lines above in this same file** | L30 writes $N$ bare, in the tabled sense. **Cleared, and the collision is already recorded** |
| $q$, $r$ | each carries two senses inside this file, at lines $142$ and $166$ and at lines $33$ and $166$ | **neither letter appears in the L30 block.** Cleared |
| $\mathring R$ | two objects inside this file (the $2$-form action and the second-kind operator), plus $\mathring W$ in Li's order as a third | **does not appear in the L30 block**, and §1 shows the argument needs no second-kind operator, so the file's BK-order note and its queued conversion do not reach L30. Cleared |
| $x$ | *"a bivector in L33's proof where the same letter is a vector of $\mathbb R^m$ elsewhere in the file"* | L30 uses the vector sense. **Cleared, already tabled** |
| $vv^{\mathsf T}$ | [VERIFY_v150.md](VERIFY_v150.md) records two senses eleven lines apart in this file, the rank-one operator on $\Lambda^2$, and the $n\times n$ product $-v^2\succeq0$ | L30 writes $v_\alpha^{\mathsf T}v_\alpha$, the $n\times n$ sense, unambiguously. **Cleared** |

## 10. The remaining traps, answered by name

- **A claim proven on a subfamily and used in general.** None found. The identity and the descent are proved for every $W\in\mathrm{Weyl}_n$; the only subfamily in sight is padded $W_{\mathbb{CP}^2}$, and it appears purely as a scope illustration and as the kernel witness, never as evidence for the general claim.
- **A step using a hypothesis never stated.** Three, all listed in the inventory: the orthonormal eigenbasis and self-adjointness; the first-Bianchi restriction; $\dim U\ge4$. **All three are true and mechanical**, and the third is automatic (§7).
- **A universal claim with no witness.** The lemma is universally quantified and its hypothesis is non-vacuous: padded $W_{\mathbb{CP}^2}$ at $5\le n\le8$ satisfies it in closed form (§8). **Cleared.**
- **An imported theorem whose hypotheses were never checked.** The block imports nothing. The nearest thing to an import is [conventions.md](../findings/conventions.md)'s padding bullet, which the block does not cite; §6 records what it would take to discharge it, and §6 also records that the argument needs no unital structure, which is where a previous route on this record died.
- **A hypothesis stated but never used.** *"At most two"*, §5, answered in full.
- **$\ker W\ne0$ and padded objects.** §4, in both directions: the lemma's conclusion *produces* an object with a large kernel, and the proof's own qualifier exists because a kernel eigenvector breaks the descent step. **The witness holds.**
- **The boundary of every stated range.** §8, with $n=4$ and $n=5$ each checked in closed form.
- **Symbol collisions.** §9, eight letters, each cleared.

## What would break it, and what I did to look for it

**The object that would falsify the statement.** A $W\in\mathrm{Weyl}_n$ with exactly two negative eigenvalues and $\dim U<n$ for which **either** some $u\perp U$ has $W(u\wedge w)\ne0$ for some $w$, **or** the restriction $W|_{\Lambda^2U}$ fails to lie in $\mathrm{Weyl}_{\dim U}$, **or** (the live one), $\lVert W|_{\Lambda^2U}\rVert\ne\lVert W\rVert$ or $\theta(W|_{\Lambda^2U})\ne\theta(W)$ when each is measured in its own dimension.

**Where I looked.**

- **The first two are closed off by §§1–3 and §7**, which are proofs rather than screens; there is no room left for such an object, and I record that positively.
- **For the third I looked at the two places a padding can leak**: the pairing, where a mismatch would need the inclusion $\Lambda^2U\hookrightarrow\Lambda^2\mathbb R^n$ to fail to be an isometry, which the half-trace convention rules out; and $\#$, where a mismatch would need a structure constant $c_{acd}$ with $c,d$ inside $\mathfrak{so}(U)$ and $a$ outside. **The latter is the only real candidate**, and it is exactly what the subalgebra property forbids (§6). **So the falsifier for clause 9 would have to be a $U$ for which $\Lambda^2U$ is not closed under the bracket, and there is none, because $\mathfrak{so}(U)$ is a subalgebra of $\mathfrak{so}(n)$ for every subspace $U$.** The clause is therefore true; **what is missing is its proof in the block, not its truth.**
- **I checked the one near-falsifier the record already holds**, *"zero-padding preserves everything"*, refuted in part at [VERIFY_v10.md](VERIFY_v10.md) §F4 and [ROUND_L04.md](ROUND_L04.md) G5. What falls there is **membership in an isotropy-constrained family** and **a closed form that carries $N=\binom n2$ explicitly**; $\theta$ and the norm survive in every one of those verdicts. **So the known counterexamples to the neighbouring slogan are not counterexamples to L30's clause.**
- **I checked the hypothesis-side falsifier for "at most two"** and found it standing: the $\mathbb R^8$ double padding of §5 is a genuine counterexample to the block's statement as written, refuted only by the redefinition of $U$.
- **No numerical work.** Every object above, $\varphi_{9,10}e_9=-e_{10}$, $\varphi_{9,10}e_5=0$, $\dim\mathcal W_5=35$, $\mathrm{pad}_{V_1}+\mathrm{pad}_{V_2}$ on $\mathbb R^8$, $\mathrm{Ric}=n-1$ at $W=\mathrm{Id}$, is exhibited in closed form.

## Verdict

**`GAP`.**

**What stands.** The identity, with constant exactly $1$ in this record's conventions and cross-checked at the round sphere. Both halves of the image step. The descent, including the necessity of its $\lambda_\alpha\ne0$ qualifier and the correctness of the named kernel witness. The vanishing on $u\wedge u^\perp$. The Ricci-flatness of the restriction. The padding conclusion.

**What is missing.** *"With the same norm and the same $\theta$"*, the third conclusion of the statement, and the one [results.md](../results.md) relies on to carry a bound from $\dim U$ to every $n$, **has no argument in the block that [results.md](../results.md) names as its proof.** Three obligations would close it, named in §6: that $W|_{\Lambda^2U}$ satisfies the first Bianchi identity as well as Ricci-flatness; that $\Lambda^2U\hookrightarrow\Lambda^2\mathbb R^n$ is an isometry for the half-trace pairing; and that $\#$ computed in $\mathfrak{so}(n)$ agrees with $\#$ computed in $\mathfrak{so}(\dim U)$ on tensors supported there. **The subalgebra property is the right and sufficient ingredient for the third, and no unital structure enters**, but it is written down nowhere the proof pointer reaches.

**Two further defects, both minor and both already half-recorded.**

1. **The scope paragraph should read $n=5,6,7,8$.** The block's $6,7,8$ omits $n=5$; the development form's *"below $n=9$"* admits $n=4$, where the hypothesis is vacuous.
2. **The kernel witness names $e_9\wedge e_{10}$ and not the $u$ that goes with it**, and the reader's natural $u=e_5$ does not work. Naming $u=e_9$ is one word.

**And one repair the annotations do not carry.** With $U$ read as $\sum_{\lambda_\alpha<0}\operatorname{im}v_\alpha$, the count hypothesis is unnecessary; left as written, *"at most"* also lets the one-negative case pick $U$ from an undetermined kernel eigenvector, so $\dim U$ (the dimension the padding descends to), is not a function of $W$. **The redefinition fixes both, and only the first is on record.**
