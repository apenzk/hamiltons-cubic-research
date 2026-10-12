# VERIFY v30, L156: the assembly of $C(\alpha,\gamma)$, the attainment of the optimum, the identity of $\gamma$, and the three numbers around them

**Cold brief, [ROUND_L156](ROUND_L156.md).** No numerical work was done: no script was run, and every value below is an exact hand evaluation of a closed-form expression, quoted as a fraction wherever a fraction exists. Log: [agent_logs/verify-L156-v30.log](../agent_logs/verify-L156-v30.log). Statement and proof under review: [findings/second-order.md](../findings/second-order.md) lines 1406–1440; canonical form: [results.md](../results.md) lines 353–357.

## Claim table

| # | Claim | Verdict |
|---|---|---|
| 1 | $C(\alpha,\gamma)=\dfrac{\alpha(1+\alpha)}{d(d-\gamma)}$, $d=\min(\alpha,D-\alpha)$ | **GAP**, the value is right against the record's own $M\le C\gamma g_n$ and against both checkpoints, but the written assembly produces $\dfrac{\alpha(1+\alpha)}{\gamma(d-\gamma)}$, larger by $d/\gamma$ |
| 2 | It reduces to $\tfrac{1+\alpha}{\alpha-\gamma}$ exactly on $\alpha\le D/2$ | **PROVEN**, an algebraic identity, given claim 1 |
| 3 | $\min_\gamma J$ maximises $\gamma(d-\gamma)$, so $\gamma=d/2$ | **PROVEN** |
| 4 | $J=4\alpha(1+\alpha)/d^3$; decreasing on $\alpha\le D/2$, increasing on $\alpha\ge D/2$ | **PROVEN** |
| 5 | The minimum is interior and **attained** at $(\alpha^*,\gamma^*)=(D/2,D/4)$ | **PROVEN**, on the domain $0<\alpha<D$, $0<\gamma<\min(d,1)$, which neither form of the statement writes down |
| 6 | $C^*=2+\tfrac{4(m-1)}{2m-1}$, $J^*=4(1+\alpha^*)/\alpha^{*2}$ | **PROVEN** |
| 7 | Corollary: $\tfrac{42}{11}\le C^*<4$ and $6.9421\le J^*<8$ for $n\ge12$; the $m=2$ endpoints $\tfrac{10}3$, $\tfrac{40}9$ | **PROVEN**, all six values exact |
| 8 | $\gamma<1$ is slack for every $m\ge2$ | **PROVEN**, and strictly stronger than stated: $\gamma=d/2\le D/4\le\tfrac34$ at *every* admissible $\alpha$ and every $m\ge2$ |
| 9 | $\alpha+\gamma<D$ is real and slack at the optimum | **PROVEN**, with a correction: it is not a separate condition but one half of the Neumann condition $\gamma<d$ |
| 10 | "$(\tfrac43,\tfrac23)$ gives $J=23.85$ against the baseline's $24$" | **BROKEN**, the exact value is $\tfrac{350}{13}=26.923$; the qualitative conclusion survives and inverts in sign |
| 11 | [results.md](../results.md): "$\sigma$ factorises out of it, so the joint three-parameter optimisation reduces to one parameter" | **BROKEN**, the findings text it names as its proof withdraws exactly this claim |
| 12 | Downstream: "L156's $2J^*=8.89$", [findings/second-order.md](../findings/second-order.md):1326 | **BROKEN**, $8.89=2\cdot\tfrac{40}9$ is the $m=2$ endpoint the corollary declares out of scope; at $n=12$, $2J^*=\tfrac{1680}{121}=13.884$ |
| 13 | The statement supplies $J^*$, $C^*$, $(\alpha^*,\gamma^*)$ at the generality downstream uses | **GAP**, the canonical form omits $J^*$ altogether, and neither form states the admissibility condition $\gamma<d$ that every value depends on |
| 14 | What the lemma asserts at $\ker W\ne0$ (the $W_{\mathbb{CP}^2}$ witness, $\dim\ker W=3$) | **No finding**, it asserts nothing there, and its every quantity is undefined there; see §6.3 |
| 15 | Pre-registered Q2: one $\gamma$ or two? | **One.** Settled in §5 from the lemma's own hypothesis |

**One line the round can act on.** The optimisation is correct and every value in it ($\alpha^*$, $\gamma^*$, $C^*$, $J^*$, both interval endpoints at $m=6$ and both at $m=2$), checks exactly by hand; what is missing is the derivation of the constant being optimised, whose written assembly is short by a resolvent factor and a perturbation factor, and three numbers *around* the lemma are wrong: $23.85$ inside it, the $\sigma$ claim in the canonical form, and $2J^*=8.89$ in the entry that consumes it.

## 0. Conventions, fixed once

Throughout, $m\ge2$ and $n=2m$; $W^*$ is the balanced product point $S^m\times S^m$ on $\Lambda^2\mathbb R^n$, real symmetric, with $V_1\oplus V_2=\mathbb R^n$ the two $m$-dimensional factors. $g_n>0$ is the absolute spectral gap, $g_n=\lvert\lambda_-\rvert$. $\Gamma$ is the positively oriented circle of radius $\alpha g_n$ about $\lambda_-$, and the disc is $\lvert z\rvert\le\rho$ with $\rho=\gamma g_n/\lVert H\rVert_{op}$. $d=\min(\alpha,D-\alpha)$ and $D=\lvert\lambda_+-\lambda_-\rvert/g_n$. $M=\sup_{\lvert z\rvert=\rho}\lVert A(z)\rVert$, and $C$ is the constant of the record's $M\le C\rho$ ([findings/second-order.md](../findings/second-order.md):1388) or equivalently $M\le C\gamma g_n$ ([findings/second-order.md](../findings/second-order.md):1308); the two agree exactly at $\lVert H\rVert_{op}=1$, and §5 shows the difference is inert for the objective. $J=C/\gamma$. All decimal figures are truncations of the exact fraction that precedes them.

## 1. Hypothesis inventory

### 1.1 Carried by the statement

| Hypothesis | Where it applies | Status |
|---|---|---|
| $W^*=S^m\times S^m$, symmetric | the resolvent norm identity | holds; $W^*$ is a real symmetric curvature operator |
| spectrum exactly $\{\lambda_-,\lambda_+\}$, $\lambda_-<0<\lambda_+$ | $\operatorname{dist}(\Gamma,\operatorname{spec})$ and the $d$-kink | holds, §2 |
| $\Gamma$ = circle of radius $\alpha g_n$ about $\lambda_-$ | contour length, $\max_\Gamma\lvert\zeta\rvert$ | definitional |
| $\rho=\gamma g_n/\lVert H\rVert_{op}$ | the Neumann step and $J=C/\gamma$ | definitional; it is what makes the two $\gamma$'s one $\gamma$, §5 |
| $D=\tfrac{2m-1}{m-1}=\lvert\lambda_+-\lambda_-\rvert/g_n$ | everything | holds, and is *derived* in §2 rather than assumed |

### 1.2 Used by the proof and absent from the statement

1. **The family $z\mapsto W(z)$ is never named**, and the Neumann step needs $\lVert W(z)-W^*\rVert\le\lVert H\rVert_{op}\lvert z\rvert$, which is an equality-in-the-worst-case only for the affine family $W(z)=W^*+zH$. The chain's other entries use that family, so the hypothesis holds; it is unstated.
2. **$\gamma<d$**, without which the Neumann series diverges, $\Gamma$ fails to separate the perturbed spectrum, and $C<0$. This is the lemma's actual admissibility condition. It appears nowhere in the statement, and only obliquely in the discussion, where its second half is described as the independent condition "$\alpha+\gamma<D$".
3. **$0<\alpha<D$.** For $\alpha>D$ the contour encloses $\lambda_+$ as well, the projection is a different one, and $d=\min(\alpha,D-\alpha)$ goes negative. The displayed formula is silent on its own domain, which matters because "the minimum is interior and attained" is a claim *about* a domain.
4. **$\gamma<1$**, so that the perturbed negative eigenvalue stays negative and $W(z)_-$ keeps its meaning. Named in the discussion, absent from the statement. §6.2 shows it can never bind.
5. **The definition of $C$ itself.** $M\le C\rho$ and $M\le C\gamma g_n$ differ by a factor $\lVert H\rVert_{op}$; the record carries both and flags the difference at line 1308. The statement fixes neither, so $C$ has no defining relation inside the lemma.

### 1.3 Imported, checked at source

| Import | Source | Check |
|---|---|---|
| $\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$ | [findings/second-order.md](../findings/second-order.md):1451 | correct, and it needs $\lvert\lambda_-\rvert=g_n$, which is the definition of the absolute gap at this point |
| $W_-=-\tfrac1{2\pi i}\oint_\Gamma\zeta(W-\zeta)^{-1}d\zeta$ | [findings/second-order.md](../findings/second-order.md):1447 | correct for $\Gamma$ enclosing the negative spectrum only |
| $\lVert(A-\zeta)^{-1}\rVert=1/\operatorname{dist}(\zeta,\operatorname{spec}A)$ | normality | applies to $W^*$; it does **not** apply to $W(z)$, which is complex symmetric and non-normal. The proof uses the identity only at $W^*$ and the Neumann bound at $W(z)$, which is the correct division |
| $g_n=\sqrt{2(n-2)}/(n\sqrt{n-1})$ | [findings/second-order.md](../findings/second-order.md):1108, 1227 | reproduced independently in §2 |
| scope $n\ge12$, $m\ge5$ | L146, L149 | consistent with the corollary's exclusion of $m=2$ |

### 1.4 Carried and unused

$\lVert W^*\rVert_{op}=\tfrac m{m-1}g_n$ enters nowhere, which is the substance of L152's surviving half and is correct on the route this proof takes. $\ker W^*=0$ is used only through "$\lambda_-<0<\lambda_+$", never separately. The condition $\alpha<1$ is carried by earlier entries and explicitly rejected here; §6.1 confirms the rejection.

## 2. The spectral data, derived rather than taken

The statement's $D$ and the record's $g_n$ both follow from two facts about $W^*$, and I re-derive them to have an independent handle on $\lambda_\pm$.

$\Lambda^2\mathbb R^n=(\Lambda^2V_1\oplus\Lambda^2V_2)\oplus(V_1\wedge V_2)$ with dimensions $2\cdot\tfrac{m(m-1)}2=m(m-1)$ and $m^2$. $W^*$ is $\lambda_+$ on the first summand and $\lambda_-$ on the second, the record's own $W^*_-=\lvert\lambda_-\rvert(\mathrm{id}-P_{\Lambda^2V_1}-P_{\Lambda^2V_2})$ at line 1113. Tracelessness gives $\lambda_+m(m-1)+\lambda_-m^2=0$, hence

$$\frac{\lambda_+}{\lvert\lambda_-\rvert}=\frac{m^2}{m(m-1)}=\frac m{m-1},\qquad D=\frac{\lambda_+-\lambda_-}{g_n}=\frac m{m-1}+1=\frac{2m-1}{m-1}.$$

So $D$ is correct, and so is $\lambda_+=\tfrac m{m-1}g_n$. Unit Frobenius norm then fixes $g_n$: $\lVert W^*\rVert_F^2=\lambda_+^2m(m-1)+\lambda_-^2m^2=g_n^2m^2\big(\tfrac m{m-1}+1\big)=g_n^2m^2\tfrac{2m-1}{m-1}=1$, so with $m=n/2$,

$$g_n=\frac1m\sqrt{\frac{m-1}{2m-1}}=\frac2n\sqrt{\frac{(n-2)/2}{n-1}}=\frac{\sqrt{2(n-2)}}{n\sqrt{n-1}},$$

which is the record's value at lines 1108 and 1227 exactly. **No finding**: the spectral data the lemma stands on are internally consistent and reproduce independently. At $n=12$: $g_n=\sqrt{20}/(12\sqrt{11})$, $D=\tfrac{11}5$.

## 3. The assembly of $C$, the gap

### 3.1 Locate

[findings/second-order.md](../findings/second-order.md):1415, the second sentence of the proof, entire:

> The Neumann step over the disc replaces $d$ by $d-\gamma$, and the contour length contributes $\alpha$; with $\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$ (L152's surviving half) this gives $C$.

Together with the first sentence, which establishes $\max_\Gamma\lVert(W^*-\zeta)^{-1}\rVert=1/(dg_n)$, this is the whole derivation of $C$.

### 3.2 Exhibit

The three named factors, in the record's own Riesz display at line 1449, multiply to

$$\frac1{2\pi}\cdot\underbrace{2\pi\alpha g_n}_{\text{length}}\cdot\underbrace{(1+\alpha)g_n}_{\max_\Gamma\lvert\zeta\rvert}\cdot\underbrace{\frac1{(d-\gamma)g_n}}_{\text{Neumann resolvent}}=\frac{\alpha(1+\alpha)}{d-\gamma}\,g_n .$$

This has the units of $g_n$, and $C$ is dimensionless. Under the record's $M\le C\gamma g_n$ it therefore yields

$$C_{\text{written}}=\frac{\alpha(1+\alpha)}{\gamma(d-\gamma)},$$

and under $M\le C\rho$ it yields $\alpha(1+\alpha)\lVert H\rVert_{op}/(\gamma(d-\gamma))$. **Neither is the displayed $C=\alpha(1+\alpha)/(d(d-\gamma))$.** The displayed one carries $d$ where the assembly puts $\gamma$; the two differ by the factor $d/\gamma$, which is $2$ at every $\gamma$-optimum.

At the record's own calibration point $(\alpha,\gamma)=(\tfrac12,\tfrac14)$, $m=6$, where $d=\tfrac12$:

$$C_{\text{stated}}=\frac{\tfrac12\cdot\tfrac32}{\tfrac12\cdot\tfrac14}=6,\qquad C_{\text{written}}=\frac{\tfrac12\cdot\tfrac32}{\tfrac14\cdot\tfrac14}=12 .$$

The checkpoint on file ($M\le6\rho$, which both this entry and L152 use as the value three computations meet at), is $6$. So the written assembly overshoots the lemma's own checkpoint by exactly a factor of two, and the displayed formula meets it.

The missing step is identifiable but is not on the page: $A$ is a *difference*, and its Riesz representation is a difference of two contour integrals, which the resolvent identity turns into a single integral carrying **two** resolvents and the perturbation size,

$$\text{length}\;\times\;\max_\Gamma\lvert\zeta\rvert\;\times\;\underbrace{\tfrac1{(d-\gamma)g_n}}_{W(z)}\;\times\;\underbrace{\lVert W(z)-W^*\rVert\le\gamma g_n}_{\text{perturbation}}\;\times\;\underbrace{\tfrac1{dg_n}}_{W^*}\;=\;\frac{\alpha(1+\alpha)\gamma}{d(d-\gamma)}g_n=C_{\text{stated}}\,\gamma g_n .$$

Five factors are needed; the proof names three, and describes the fourth ("replaces $d$ by $d-\gamma$") as superseding the resolvent at $W^*$ rather than multiplying it. The fifth, $\lVert W(z)-W^*\rVert\le\gamma g_n$, is the factor that makes $C$ dimensionless, and it is never written. **Per the brief I stop here: I do not adopt this reconstruction as the proof.** It is offered only to name precisely what is owed.

### 3.3 Argue the opposite

The most charitable reading is that "replaces $d$ by $d-\gamma$" is loose for "adjoins $1/(d-\gamma)$ to the $1/d$ already established", so that the denominator $d(d-\gamma)$ is intended. That reading recovers the denominator and still leaves the numerator's $\gamma$ unaccounted: it produces a bound with units of $g_n^0$ against a $C$ that must be dimensionless, and it produces $C_{\text{stated}}\cdot d$ rather than $C_{\text{stated}}$. A second charitable reading is that the whole assembly is imported wholesale from the earlier $(1+\alpha)/(\alpha-\gamma)$ and only the resolvent factor is being corrected; that is almost certainly the intent, and it is exactly why the omission survived, on $d=\alpha$ the missing $1/d$ and the length $\alpha$ cancel, so the old formula never displayed either factor and the correction never had to name them. Neither reading makes the sentence derive the display.

**Finding stands.** The displayed $C$ is corroborated three ways, it reduces to the record's earlier formula on $d=\alpha$ (§4.1), it reproduces the $M\le6\rho$ checkpoint, and it agrees with the record's independent $M\le C\gamma g_n$, and is nonetheless not derived by the proof as written. Verdict on claim 1: **GAP**, one sentence wide.

## 4. The optimisation, and pre-registered question 1

### 4.1 The reduction on $\alpha\le D/2$

$d=\alpha$ there, so $\alpha(1+\alpha)/(\alpha(\alpha-\gamma))=(1+\alpha)/(\alpha-\gamma)$. Exact, and it is the sense in which the correction is invisible in the old regime. **PROVEN.**

### 4.2 The inner minimisation

$J=C/\gamma=\dfrac{\alpha(1+\alpha)}{\gamma\,d(d-\gamma)}$, and $\alpha(1+\alpha)/d$ is free of $\gamma$, so minimising $J$ at fixed $\alpha$ is maximising $\gamma(d-\gamma)$ on $0<\gamma<\min(d,1)$. The parabola peaks at $\gamma=d/2$, an interior point of that interval because $d/2<d$ and, by §6.2, $d/2<1$ at every admissible $\alpha$ and every $m\ge2$. **PROVEN, and attained**, a maximum of a strictly concave function at an interior stationary point. Substituting, $\gamma(d-\gamma)=d^2/4$ and

$$J=\frac{4\alpha(1+\alpha)}{d^3},$$

as displayed. **PROVEN.**

### 4.3 The outer minimisation, and whether the optimum is attained

On $0<\alpha\le D/2$: $J=4(1+\alpha)/\alpha^2=4\alpha^{-2}+4\alpha^{-1}$, so $J'(\alpha)=-8\alpha^{-3}-4\alpha^{-2}=-4(\alpha+2)/\alpha^3<0$, strictly decreasing, and the corollary's stated derivative is exact.

On $D/2\le\alpha<D$: $J=4\alpha(1+\alpha)/(D-\alpha)^3$, a product of a strictly increasing positive function of $\alpha$ with a strictly increasing positive $1/(D-\alpha)^3$, strictly increasing.

The two branches agree at $\alpha=D/2$, where both give $4(D/2)(1+D/2)/(D/2)^3$, so $J$ is continuous there. **The minimum is therefore attained at $\alpha^*=D/2$, and it is a genuine minimum rather than a supremum of admissible values**, for the reason the round asked to have named: the reduced objective is continuous on the open interval $(0,D)$ and strictly monotone toward $D/2$ from both sides, so the infimum is realised at an interior point rather than approached at a boundary. The two things that make it exist are (i) that the inner problem in $\gamma$ has its maximiser $d/2$ strictly inside its admissible interval for *every* $\alpha$, so the partial minimisation is exact and the nested minimisation is legitimate even though the $\gamma$-domain depends on $\alpha$; and (ii) that the kink at $\alpha=D/2$ is a corner of the objective and not a boundary of the feasible set, $\alpha=D/2$ is admissible, with $\gamma^*=D/4<d=D/2$ strictly, so no constraint is active there. Contrast the corollary's $J\to8$, which *is* a supremum and is correctly labelled unattained.

**PROVEN, with one scope caveat.** The proof never states the domain over which "the minimum" is taken. It is $\{0<\alpha<D,\ 0<\gamma<\min(d,1)\}$, and the claim of attainment is false-by-vacuity outside it: at $\alpha\ge D$ the contour encloses $\lambda_+$, the formula's $d$ is $\le0$, and $C$ is negative or undefined. This is recorded under claim 5 and claim 13, not as a defect of the mathematics.

### 4.4 The values

At $\alpha^*=D/2$, $\gamma^*=D/4$, $d=D/2$:

$$C^*=\frac{\tfrac D2(1+\tfrac D2)}{\tfrac D2\cdot\tfrac D4}=\frac{4(1+\tfrac D2)}D=2+\frac4D=2+\frac{4(m-1)}{2m-1},\qquad J^*=\frac{C^*}{\gamma^*}=\frac{4(1+\alpha^*)}{\alpha^{*2}} .$$

Both displayed values **PROVEN**. At $m=6$: $D=\tfrac{11}5$, $(\alpha^*,\gamma^*)=(\tfrac{11}{10},\tfrac{11}{20})=(1.1,0.55)$, $C^*=2+\tfrac{20}{11}=\tfrac{42}{11}=3.8181\ldots$, $J^*=\tfrac{42}{11}\cdot\tfrac{20}{11}=\tfrac{840}{121}=6.94214\ldots$, every figure in the entry's "Numbers at $n=12$" line confirmed except the one in §7.

## 5. Pre-registered question 2, one $\gamma$, and why

**Settled: there is exactly one $\gamma$, and the lemma's own hypothesis forces the identification.**

$\gamma$ enters the lemma through one clause only, $\rho=\gamma g_n/\lVert H\rVert_{op}$. It reaches the resolvent through the perturbation size: on the disc, $\lVert W(z)-W^*\rVert\le\lVert H\rVert_{op}\rho=\gamma g_n$, which is precisely the quantity the Neumann step subtracts from $\operatorname{dist}(\Gamma,\operatorname{spec})=dg_n$ to give $(d-\gamma)g_n$. So the $\gamma$ in $d-\gamma$ *is* the $\gamma$ of $\rho$, by construction: the parametrisation exists to measure the disc in units that make the perturbation commensurate with the gap.

It reaches $J$ through the same clause. With $M\le C\gamma g_n$,

$$\sup\lVert A''\rVert\le\frac{2M}{((1-\sigma)\rho)^2}=\frac{2C\gamma g_n\lVert H\rVert_{op}^2}{(1-\sigma)^2\gamma^2g_n^2}=\frac{2J\lVert H\rVert_{op}^2}{(1-\sigma)^2g_n},\qquad J=\frac C\gamma,$$

and with the alternative $M\le C\rho$ one gets $2J\lVert H\rVert_{op}/((1-\sigma)^2g_n)$, the record's line 1300 display. The two differ by one power of $\lVert H\rVert_{op}$, which is the discrepancy the record already flags at line 1308; **the objective is $C/\gamma$ under both**, so the ambiguity in $C$'s defining relation does not touch the optimisation. The doubt is dismissible, and this is the adjudication: same $\gamma$, one occurrence, and the objective's $1/\gamma$ is the single power of $\rho$ left over after the Cauchy $\rho^{-2}$ eats the $M\propto\rho$.

**One rider, and it is where the doubt came from.** The calibration $(\alpha,\gamma)=(\tfrac12,\tfrac14)$ is read off from $\rho=g_n/4$, and $\gamma=\rho\lVert H\rVert_{op}/g_n$ equals $\tfrac14$ there only if $\lVert H\rVert_{op}=1$. So the checkpoint that fixes $C=6$ tacitly normalises $\lVert H\rVert_{op}$, which is the same tacit normalisation line 1308 identifies inside $M\le C\rho$. Worth stating; it changes no value in the lemma.

## 6. The edges

### 6.1 The admissible range of $\alpha$

The entry's ruling that $\alpha<1$ is not a constraint is **correct**. $\operatorname{spec}(W^*)=\{\lambda_-,\lambda_+\}$ contains no point at $0$; a contour of radius $\alpha g_n>g_n$ about $\lambda_-=-g_n$ encloses the origin, and the Riesz integrand $\zeta(W-\zeta)^{-1}$ is holomorphic at $\zeta=0$ (the singularities are the spectrum, and the explicit $\zeta$ vanishes there), so the integral is unchanged in value and meaning. What the contour must do is enclose $\lambda_-$ and exclude $\lambda_+$, giving $\alpha<D=1+\tfrac m{m-1}$, the record's own alternative at line 1455. So the range is $0<\alpha<D$, and it is never stated in the lemma. The optimum $\alpha^*=D/2$ sits strictly inside it, and exceeds $1$ for every $m$, since $\alpha^*=1+\tfrac1{2(m-1)}$.

### 6.2 $\gamma<1$, and the smallest dimension

The perturbed negative eigenvalue lies within $\gamma g_n$ of $\lambda_-=-g_n$ and stays negative iff $\gamma<1$; the perturbed $\lambda_+$ stays positive under the weaker $\gamma<\tfrac m{m-1}$. The entry calls $\gamma<1$ slack at the optimum. **A stronger statement is available and I record it because it removes the constraint from the problem entirely**: at the $\gamma$-optimum of *any* admissible $\alpha$, $\gamma=d/2\le D/4$, and $D/4\le\tfrac34$ for every $m\ge2$ since $D=2+\tfrac1{m-1}\le3$. So $\gamma<1$ can never be active anywhere on the optimising locus, at any $m$, and it never competes with $\gamma<d$. At the optimum itself, $\gamma^*=D/4$ runs from $\tfrac34$ at $m=2$ down to $\tfrac12$ as $m\to\infty$.

The smallest dimension at which anything is defined is $m=2$ ($n=4$), where $D=3$; $m=1$ has no $D$. The corollary's exclusion of $m=2$ is a scope decision imported from L146 and L149, not a failure of the formula, and its $m=2$ endpoints $C^*=2+\tfrac43=\tfrac{10}3$ and $J^*=\tfrac{10}3\cdot\tfrac43=\tfrac{40}9$ are **exact**. They matter in §8.

### 6.3 $\ker W\ne0$ and the $W_{\mathbb{CP}^2}$ witness

**The lemma asserts nothing at any point with $\ker W\ne0$, and this is the correct answer rather than an omission.** Its hypothesis is the single point $W^*=S^m\times S^m$, whose spectrum $\{-g_n,\tfrac m{m-1}g_n\}$ has $\ker W^*=0$; the record already requires that at line 1227, where $\ker W^*=0$ is listed as a hypothesis the chain uses and is discharged by the same $g_n$.

What is worth saying is how *badly* the statement degenerates at a kernel point, because it bears on any later attempt to transport the constant: at $\ker W\ne0$ the absolute gap $g_n=\operatorname{dist}(0,\operatorname{spec})$ is zero, so $\Gamma$ has radius $0$, $\rho=0$, $D$ is undefined, and $C$, $J$, $\alpha^*$, $\gamma^*$ have no values. The $W_{\mathbb{CP}^2}$ witness with $\dim\ker W=3$ sits at $n=4$, which is also the $m=2$ endpoint the corollary excludes; the two exclusions are independent, and neither rescues the other. **No finding against the lemma**; a note against any future use of $C^*$ off the balanced orbit.

## 7. "$J=23.85$", refuted

### 7.1 Locate

[findings/second-order.md](../findings/second-order.md):1421: "*and r456's $(\tfrac43,\tfrac23)$ gives $J=23.85$ against the baseline's $24$, **no improvement at all**, while sitting past the kink where its own formula fails.*"

### 7.2 Exhibit

At $m=6$, $D=\tfrac{11}5$, $\alpha=\tfrac43$, $\gamma=\tfrac23$:

$$D-\alpha=\tfrac{33-20}{15}=\tfrac{13}{15}<\tfrac43,\quad\text{so } d=\tfrac{13}{15};\qquad d-\gamma=\tfrac{13-10}{15}=\tfrac15;\qquad \alpha(1+\alpha)=\tfrac43\cdot\tfrac73=\tfrac{28}9 .$$

$$C=\frac{28/9}{\tfrac{13}{15}\cdot\tfrac15}=\frac{28}9\cdot\frac{75}{13}=\frac{2100}{117}=\frac{700}{39}=17.9487\ldots$$

which is the entry's own cross-check value "the true constant is $17.9$" at line 1445, so $C$ is not in dispute. Then

$$J=\frac C\gamma=\frac{700}{39}\cdot\frac32=\frac{2100}{78}=\frac{350}{13}=26.9230\ldots$$

against the baseline $J(\tfrac12,\tfrac14)=6/\tfrac14=24$. The recorded $23.85$ is wrong; the point is $12.2\%$ **worse** than the baseline, not $0.6\%$ better.

### 7.3 Argue the opposite

Could $23.85$ be some other quantity at that point? I evaluated every nearby candidate in closed form: the old $C=(1+\alpha)/(\alpha-\gamma)=\tfrac72$ gives $J=\tfrac{21}4=5.25$; the $\gamma$-optimised value at $\alpha=\tfrac43$, $J=4\alpha(1+\alpha)/d^3=\tfrac{112}9\cdot\tfrac{3375}{2197}=\tfrac{378000}{19773}=19.117$; the disputed numerator $\alpha+\tfrac m{m-1}=\tfrac{38}{15}$ gives $C=\tfrac{19}5$ and $J=\tfrac{57}{10}=5.7$ in the old form, or $J=29.23$ in the corrected one. None is $23.85$, and none is within $1\%$ of it. The charitable reading (that the author wanted a number "just under $24$" to support "no improvement at all"), is what the sentence reads like, and the conclusion it supports is true for a stronger reason than the one given.

**BROKEN, and the correction strengthens the entry.** Nothing downstream is known to consume $23.85$; it is a comparison remark. It is recorded because the entry presents it as an exact evaluation of its own formula.

## 8. The corollary

$\alpha^*=\tfrac{2m-1}{2(m-1)}=1+\tfrac1{2(m-1)}$, strictly decreasing to $1$ and never reaching it. $J(\alpha)=4(1+\alpha)/\alpha^2$ is strictly decreasing (§4.3), so $J^*=J(\alpha^*)$ is strictly **increasing** in $m$ with supremum $J(1)=8$, unattained. $C^*=2+4/D$ with $D=2+\tfrac1{m-1}$ strictly decreasing to $2$, so $C^*$ strictly increases to $4$, unattained; and $C^*<4$ at every $m$ because $\tfrac{4(m-1)}{2m-1}<2\iff4m-4<4m-2$. **All PROVEN.**

The interval endpoints, exact. At $m=6$: $C^*=\tfrac{42}{11}$ and $J^*=\tfrac{840}{121}$; since $121\cdot6.9421=839.994<840$, the stated $6.9421\le J^*$ holds as a truncation. At $m=2$: $\tfrac{10}3$ and $\tfrac{40}9$. The fixed contour $(\alpha,\gamma)=(1,\tfrac12)$ has $d=\min(1,D-1)=1$ for every $m\ge2$ because $D-1=\tfrac m{m-1}>1$, giving $C=\tfrac{1\cdot2}{1\cdot\tfrac12}=4$ and $J=8$ at every $m$, **PROVEN**, and $8/\tfrac{840}{121}=\tfrac{968}{840}=1.1524$, so "15% off the optimum" is right at $n=12$.

The box "under the rejected $\alpha<1$ the same algebra returns $C>4$ and $J>8$" is **PROVEN**: for $\alpha<1<D/2$, $d=\alpha$ and $\gamma=\alpha/2$ give $C=2(1+\alpha)/\alpha$ and $J=4(1+\alpha)/\alpha^2$, both strictly decreasing on $(0,1)$, with limits $4$ and $8$ at $\alpha\to1^-$. The suprema of the admitted range and the infima of the rejected one coincide, as claimed.

## 9. What is proven against what is used

The round asks whether the statement supplies $J^*$, $C^*$ and $(\alpha^*,\gamma^*)$ at the generality downstream consumes them. It does not, in three distinguishable ways.

**9.1 The canonical form omits $J^*$.** [results.md](../results.md):353–357 gives $\alpha^*$, $\gamma^*$ and $C^*$ and stops. $J^*$ is the quantity two later entries actually consume, and it appears only in the findings text. See §10.

**9.2 A downstream consumer uses the out-of-scope endpoint.** [findings/second-order.md](../findings/second-order.md):1326 reads "**L156's $2J^*=8.89$ inside $\lVert A''\rVert$, which the entry dropped**". Exactly: $2J^*$ at $m=2$ is $2\cdot\tfrac{40}9=\tfrac{80}9=8.8889$, and $8.89$ is that number. At $n=12$, which is the dimension the sentence is about, $2J^*=2\cdot\tfrac{840}{121}=\tfrac{1680}{121}=13.884$, larger by a factor $\tfrac{1680}{121}\cdot\tfrac9{80}=\tfrac{189}{121}=1.5620$. The corollary that supplies $\tfrac{40}9$ says in the same breath that "$m=2$ is out of scope for everything this feeds", so the value used is the one the lemma disclaims.

*Argue the opposite.* $8.89$ is also close to $1/g_n$ at $n=12$: $1/g_n=12\sqrt{11}/\sqrt{20}=8.899$, and the same sentence lists $B=1/g_n=0.74n=8.88$ separately. So a reader could suspect a transcription of the neighbouring quantity rather than a misuse of $J^*$. Either way the arithmetic is the same finding: the number entering $\lVert A''\rVert$ as $2J^*$ is not $2J^*$ at $n=12$, and the correct value is $13.884$. And since that sentence is one side of a live disagreement about a threshold ($21$ against $3.98$), the substitution is load-bearing there, not decorative. **BROKEN**, against the consumer rather than against L156.

**9.3 The separation the downstream use rests on is withdrawn inside the lemma and asserted outside it.** L156 optimises $J=C/\gamma$ as a free two-parameter problem. Its own closing paragraph withdraws the claim that this half separates from $\sigma$, giving the coupling $t(1-\sigma)^2=\sigma$ with $t=\sqrt{c_p+w^2}/(2J\gamma)$, in which $\gamma$ appears; and [findings/second-order.md](../findings/second-order.md):1268 goes further, "*in L156 it is the **Cauchy radius $\gamma-r$**, not $\gamma$, that wants to be $d/2$*". If that is right, the lemma's optimiser is the optimiser of a different objective from the one the chain needs, and $(\alpha^*,\gamma^*)$ is not the chain's optimum but the optimum of its $r=0$ section. **The lemma proves what it says**; what is used is one step further out, and the statement does not reach it. **GAP** on claim 13.

## 10. The two forms

[results.md](../results.md):355, third sentence from the end:

> The objective itself was never stated on the record, and $\sigma$ factorises out of it, so the joint three-parameter optimisation reduces to one parameter in closed form.

[findings/second-order.md](../findings/second-order.md):1439, the closing line of the entry that results.md names as its proof:

> **The $(\alpha,\gamma)$ half separates from $\sigma$**, so that half is the one-parameter problem L156 solves in closed form; *the claim that $\sigma$ factorises out of the whole is withdrawn, $\sigma$ being tied to the reach by the crossing condition above.*

**The canonical form carries a claim its own proof text explicitly withdraws.** This is not a wording difference: "the joint three-parameter optimisation reduces to one parameter" is the assertion the findings text calls withdrawn, and it is the assertion that would license reading $(\alpha^*,\gamma^*)$ as the chain's optimum rather than a section of it. **BROKEN.** The repair is to replace it with the surviving half, that the $(\alpha,\gamma)$ problem is solved in closed form at fixed $\sigma$, $\sigma$ remaining tied to the reach.

Three further differences, all omissions in the canonical form and none of them contradictions: it drops $J^*$ (§9.1); it drops the corollary's intervals $\tfrac{42}{11}\le C^*<4$ and $6.9421\le J^*<8$, which is the dimension-free content and the only form in which the constant is quotable at general $m$; and it drops $\gamma^*$'s admissibility. Both forms share the two scope omissions of §1.2: no $0<\alpha<D$, no $\gamma<d$.

One shared phrasing is worth a line. Both call the resolvent kink "the binding condition". At the optimum no inequality constraint is active ($\gamma^*=D/4<d=D/2$, $\alpha^*=D/2<D$, $\gamma^*<1$) so nothing binds in the usual sense; the minimiser sits at a corner of the *objective*. The substance ("the switch of the nearest spectral point is what locates the optimum, not encirclement of $0$ or of $\lambda_+$") is correct and is the entry's real discovery. Recorded as terminology, with no numerical consequence.

## 11. What would falsify this, and what I did to look for it

**The object that would break the lemma is an admissible $(m,\alpha,\gamma)$ at which the claimed optimum is not the minimum**, concretely, one of: (i) an $m\ge2$ with $D/4\ge1$, which would make $\gamma<1$ active and displace $\gamma^*$ from $d/2$; (ii) an $\alpha$ in $(0,D)$ at which the $\gamma$-maximiser $d/2$ leaves its admissible interval, which would break the nested minimisation; (iii) an $m$ at which $\alpha^*(m)$ fails to decrease or $C^*$ reaches $4$, which would break the corollary's monotonicity and its intervals.

I looked for each in closed form. (i) $D=2+\tfrac1{m-1}\le3$ for $m\ge2$, so $D/4\le\tfrac34<1$, a falsifier would need $D\ge4$, hence $m\le\tfrac32$, and no balanced product has $m=1$. (ii) $d/2<d$ always and $d/2<1$ by (i), so the maximiser is interior for every admissible $\alpha$, with no exception at the kink, where $d$ is continuous. (iii) $\alpha^*=1+\tfrac1{2(m-1)}$ is strictly decreasing in $m$ by inspection, and $C^*<4$ reduces to $4m-4<4m-2$. **No falsifier exists in the lemma's range, and none exists in $m\ge2$ either**, the $m=2$ exclusion is a scope decision inherited from L146 and L149, not a place where this lemma fails.

The place the lemma *is* exposed is the one §3 names: $C$ is corroborated but not derived, so an error in the unwritten resolvent-identity step would propagate to $C^*$, $J^*$ and both intervals while leaving every check in §4 and §8 intact, since those check the optimisation of $C$ rather than $C$ itself. That is what a successor should close, and it is one sentence of work.

## Verdict

**GAP.**

The optimisation is correct and complete: $\gamma^*=d/2$, $J=4\alpha(1+\alpha)/d^3$, strict monotonicity on both branches, a minimum that is interior and genuinely attained at the equidistant contour, $C^*=2+\tfrac{4(m-1)}{2m-1}$, $J^*=4(1+\alpha^*)/\alpha^{*2}$, and the corollary's four interval endpoints, every one of them reproduced here by exact hand evaluation, together with the spectral data $\lambda_+=\tfrac m{m-1}g_n$, $D=\tfrac{2m-1}{m-1}$ and $g_n=\sqrt{2(n-2)}/(n\sqrt{n-1})$, which I re-derived from tracelessness and unit norm rather than importing. Both pre-registered questions are answered: the optimum is attained, for the reasons in §4.3, and there is exactly one $\gamma$, for the reason in §5.

What fails is one sentence and three numbers. The sentence is the assembly of $C$, which names three of the five factors its own displayed formula needs and describes the fourth as a replacement rather than a product; taken literally it yields $\alpha(1+\alpha)/(\gamma(d-\gamma))$, which is $12$ at the record's calibration point against the checkpoint's $6$. The numbers are $J=23.85$ at $(\tfrac43,\tfrac23)$, whose exact value is $\tfrac{350}{13}=26.923$; the canonical form's claim that $\sigma$ factorises out, which the findings text withdraws in terms; and the downstream $2J^*=8.89$, which is the $m=2$ endpoint against $\tfrac{1680}{121}=13.884$ at $n=12$.

**What is owed, precisely.** One display deriving $M\le C\gamma g_n$ with $C=\alpha(1+\alpha)/(d(d-\gamma))$ from the difference of the two Riesz integrals, the step that supplies the second resolvent factor $1/(dg_n)$ and the perturbation factor $\lVert W(z)-W^*\rVert\le\gamma g_n$, together with the two hypotheses that step needs and the statement omits, $0<\alpha<D$ and $\gamma<d$.
