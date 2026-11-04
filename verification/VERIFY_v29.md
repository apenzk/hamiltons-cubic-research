# VERIFY v29, L156: the contour constant $C=\alpha(1+\alpha)/(d(d-\gamma))$, its objective $J=C/\gamma$, and the claim that the minimum is interior and attained at $(\alpha^*,\gamma^*)=(D/2,D/4)$

*Cold brief. No numerical work was done: no script was run, and every value below is an exact hand evaluation of a rational number, given as a fraction with its decimal expansion. Log: [agent_logs/verify-L156-v29.log](../agent_logs/verify-L156-v29.log).*

## Claim table

| # | Claim | Verdict |
|---|---|---|
| A | $d=\min(\alpha,D-\alpha)$ is $\mathop{\mathrm{dist}}(\Gamma,\mathop{\mathrm{spec}}W^*)/g_n$, and $D=\tfrac{2m-1}{m-1}$ | **CONFIRMED**, and $D$ cross-checks against an independent entry |
| B | $C(\alpha,\gamma)=\tfrac{\alpha(1+\alpha)}{d(d-\gamma)}$ reduces to $\tfrac{1+\alpha}{\alpha-\gamma}$ on $\alpha\le D/2$ | **CONFIRMED** |
| C | **The written proof's factor list produces $C$** | **REFUTED**, it multiplies out to $\tfrac{\alpha(1+\alpha)}{\gamma(d-\gamma)}$, which is $12$ at $(\tfrac12,\tfrac14)$ where the lemma and r441 both give $6$ |
| D | $\min_\gamma$ at $\gamma=d/2$; $J=4\alpha(1+\alpha)/d^3$; both branches strictly monotone toward $D/2$ | **CONFIRMED** |
| E | The minimum is **interior and attained** (pre-registered question 1) | **CONFIRMED**, attained, on a domain the statement never writes down |
| F | $\alpha^*=\tfrac{D}2$, $\gamma^*=\tfrac D4$, $C^*=2+\tfrac{4(m-1)}{2m-1}$, $J^*=\tfrac{4(1+\alpha^*)}{\alpha^{*2}}$ | **CONFIRMED** |
| G | Corollary: $\tfrac{42}{11}\le C^*<4$, $6.9421\le J^*<8$ at $n\ge12$; $(1,\tfrac12)$ gives $C\equiv4$, $J\equiv8$ | **CONFIRMED** |
| H | The $\gamma$ of $\rho=\gamma g_n/\lVert H\rVert_{op}$ is the $\gamma$ of $J=C/\gamma$ (pre-registered question 2) | **CONFIRMED, the same $\gamma$**, settled from the lemma's own hypothesis |
| I | $\alpha<1$ is not a constraint; $\gamma<1$ and $\gamma<d$ are; both slack at the optimum | **CONFIRMED**, and $\gamma<d$ subsumes the separately-listed $\alpha+\gamma<D$ |
| J | "$J=23.85$ at r456's $(\tfrac43,\tfrac23)$" | **REFUTED**, the exact value is $\tfrac{350}{13}=26.923$ |
| K | "The objective is $J=C/\gamma$" as an unconditional statement about the chain | **REFUTED**, exact only as $t\to0$; by L157's own identity $\gamma^*=D/4$ is a **strict non-maximiser of the tube radius** for every $t>0$ |
| L | The statement supplies what downstream consumes, at the generality used | **REFUTED**, the box carries no inequality, no domain, and no $\lVert H\rVert_{op}$ hypothesis |
| M | The two forms agree ([results.md](../results.md) vs [findings/second-order.md](../findings/second-order.md)) | **REFUTED**, results.md carries the sentence findings.md explicitly withdraws, and omits $J^*$ |
| N | Anything asserted at $\ker W\ne0$ / $W_{\mathbb{CP}^2}$ | **NO CLAIM**, the construction is void there, correctly so |

**Verdict: `GAP`.** Every number the lemma states is exactly right and I found no falsifier; the derivation on file computes a different constant from the one on file, and the framing sentence that makes $J$ the chain's objective is false away from the small-$t$ limit.

---

## 0. Conventions, fixed once

$n=2m$, $W^*=S^m\times S^m$. Its spectrum is the two points $\lambda_-<0<\lambda_+$ with $\lvert\lambda_-\rvert=g_n$ and $\lambda_+=\tfrac m{m-1}g_n$, so

$$D:=\frac{\lvert\lambda_+-\lambda_-\rvert}{g_n}=1+\frac m{m-1}=\frac{2m-1}{m-1},$$

which is $>2$ for every finite $m\ge2$ and decreases to $2$. $\Gamma$ is the circle of radius $\alpha g_n$ centred at $\lambda_-$; $W(z)=W^*+zH$; $\rho=\gamma g_n/\lVert H\rVert_{op}$; $d:=\min(\alpha,D-\alpha)$; $A(z)=\mathrm{Alt}(W_-(z))$ with $A(0)=0$; $M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert$; $J=C/\gamma$. At $n=12$, $m=6$: $D=\tfrac{11}5$.

Every fraction below is exact. Decimals are given to the digits shown and are truncations, never inputs.

## 1. Hypothesis inventory

**Carried by the statement, and used.**

| Hypothesis | Where the proof uses it |
|---|---|
| $W^*=S^m\times S^m$ | gives *symmetric*, *two-point spectrum*, *$\ker W^*=0$*: all three are load-bearing |
| $\Gamma$ = circle of radius $\alpha g_n$ about $\lambda_-$ | the contour length $2\pi\alpha g_n$; $\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$; $\mathop{\mathrm{dist}}(\Gamma,\lambda_-)=\alpha g_n$ |
| $\rho=\gamma g_n/\lVert H\rVert_{op}$ | gives $\lVert W(z)-W^*\rVert\le\gamma g_n$ on $\lvert z\rvert\le\rho$, which is the whole content of the Neumann step |
| $D=\tfrac{2m-1}{m-1}$ | $\mathop{\mathrm{dist}}(\Gamma,\lambda_+)=\lvert D-\alpha\rvert g_n$ |

**Used by the proof, absent from the statement.** Each of these is a hypothesis, not a convention.

1. **The domain.** $0<\alpha<D$ and $0<\gamma<d(\alpha)$. Outside it $d\le0$ or $d-\gamma\le0$ and $C$ is negative or infinite. Without the domain the words *interior* and *attained* have no referent, and the formula $d=\min(\alpha,D-\alpha)$ silently misstates the distance for $\alpha>D$ (where the true distance is $(\alpha-D)g_n$, not the negative $D-\alpha$).
2. **$\gamma<1$.** Required so that the perturbed negative cluster, contained in the disc of radius $\gamma g_n$ about $\lambda_-=-g_n$, stays off $0$ and $W_-(z)$ is the negative part rather than merely the spectral part inside $\Gamma$. The prose states it; the box does not.
3. **$W(z)=W^*+zH$, affine.** The perturbation model appears nowhere in the statement, yet $\lVert W(z)-W^*\rVert=\lvert z\rvert\lVert H\rVert_{op}$ is what turns $\rho$ into $\gamma g_n$.
4. **$\lVert H\rVert_{op}\le1$.** Needed for $M\le C\rho$ rather than $M\le C\rho\lVert H\rVert_{op}$; recorded against L156 elsewhere ([second-order.md:1308](../findings/second-order.md), r713) and never folded into the statement.
5. **$\lVert\mathrm{Alt}(X)\rVert\le\lVert X\rVert$**, imported from [conventions.md](../findings/conventions.md), to pass from the $W_-$ bound to $M$.

**Imported results, checked against the object they apply to.**

- **L152's surviving half**, $\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$. Its hypothesis is a circle about the *enclosed* eigenvalue with $\lvert\lambda_-\rvert=g_n$. Satisfied here. **Correct**: for $\zeta=\lambda_-+\alpha g_ne^{i\theta}$ with $\lambda_-$ real negative, $\max\lvert\zeta\rvert=\lvert\lambda_-\rvert+\alpha g_n$.
- **Normality of $W^*$**, giving $\max_\Gamma\lVert(W^*-\zeta)^{-1}\rVert=1/(dg_n)$. $W^*$ is real symmetric, hence normal; the resolvent norm is the reciprocal of the distance to the spectrum. **Correct.** Note the proof needs this *only* at $W^*$; at $W(z)$, complex symmetric and not normal, it uses Neumann instead, which is the right instrument.
- **Riesz/Dunford calculus.** Requires $\Gamma\subset\varrho(W(z))$ for every $\lvert z\rvert\le\rho$ and requires $\Gamma$ to enclose exactly the negative cluster. The first is $\gamma<d$; the second is $\gamma<d$ *and* $\gamma<1$. **Both hold at the optimum** (§5).
- **The Cauchy estimate** $\sup_{\lvert s\rvert\le\sigma\rho}\lVert A''\rVert\le2M/((1-\sigma)\rho)^2$ requires $A$ holomorphic on an open disc containing $\lvert z\rvert\le\rho$; the strict inequality $\gamma<d$ supplies it.

**Hypotheses the statement carries that the proof does not use:** none, every clause of the box is consumed.

## 2. Question 1, pre-registered: interior, and attained

**Attained.** For fixed $\alpha$, $J(\alpha,\gamma)=\dfrac{\alpha(1+\alpha)}{d\,\gamma(d-\gamma)}$ is minimised where $\gamma(d-\gamma)$ is maximised, i.e. at the interior point $\gamma=d/2$, with maximum $d^2/4$; hence

$$\min_\gamma J(\alpha,\gamma)=\frac{4\alpha(1+\alpha)}{d^3}=:\widehat J(\alpha).$$

On $0<\alpha\le D/2$, $d=\alpha$ and $\widehat J=4(1+\alpha)/\alpha^2=4\alpha^{-2}+4\alpha^{-1}$, with $\widehat J'=-4(\alpha+2)/\alpha^3<0$: strictly decreasing. On $D/2\le\alpha<D$, $d=D-\alpha$ and $\widehat J=4\alpha(1+\alpha)/(D-\alpha)^3$ has a strictly increasing numerator and a strictly decreasing positive denominator: strictly increasing. So $\widehat J$ attains its minimum at $\alpha=D/2$ **as a value, not a limit**: the point $(\alpha,\gamma)=(D/2,D/4)$ is a member of the domain, since $0<D/2<D$ and $0<D/4<d(D/2)=D/2$.

**What makes the minimum exist rather than be an infimum of admissible values.** Two things, and only the second is written down. (i) The domain $\{0<\alpha<D,\ 0<\gamma<d(\alpha)\}$ is *open*, so existence is not from compactness; it comes from coercivity, $\widehat J\to\infty$ as $\alpha\downarrow0$ ($\sim4/\alpha^2$), as $\alpha\uparrow D$ ($\sim 4D(1+D)/(D-\alpha)^3$), and $J\to\infty$ as $\gamma\downarrow0$ or $\gamma\uparrow d$. (ii) The proof instead argues by explicit monotonicity on the two branches, which is a complete and correct existence argument and does not need coercivity. **No finding**, beyond the missing domain already logged in §1.

**A reading hazard, stated because the entry does not.** *Interior* here means interior to the domain; it does **not** mean stationary. $\widehat J$ has a genuine kink at $\alpha^*$. Exactly, at $\alpha^*=D/2$:

$$\widehat J'(\alpha^{*-})=-\frac{16(D+4)}{D^3},\qquad \widehat J'(\alpha^{*+})=\frac{80D+128}{D^3},$$

both non-zero for every $D>2$. At $m=6$: $-\tfrac{12400}{1331}=-9.3163\ldots$ and $+\tfrac{38000}{1331}=+28.5499\ldots$ Any downstream envelope argument in $\alpha$ ("$J$ is stationary at the optimum") is therefore unavailable. The corresponding statement in $\gamma$ **is** available: $\partial_\gamma J=0$ at $\gamma=d/2$, $J$ being smooth there. [second-order.md:1262](../findings/second-order.md) writes *"$J$ is stationary at the optimum, so $J^*$ is right to $O(t^2)$"*; under the $\gamma$-only reading that is correct, so I record the ambiguity rather than a defect, see §8, candidate withdrawn.

## 3. Question 2, pre-registered: the two $\gamma$'s are one $\gamma$

Settled affirmatively **from the lemma's own hypothesis**, with no appeal to another entry. The hypothesis fixes $\rho=\gamma g_n/\lVert H\rVert_{op}$, so on $\lvert z\rvert\le\rho$

$$\lVert W(z)-W^*\rVert_{op}\le\rho\,\lVert H\rVert_{op}=\gamma g_n .$$

That single quantity is what enters the Neumann step and produces the $(d-\gamma)$ in $C$. The same $\rho$ inverted is what produces the $1/\gamma$ in $J$:

$$\sup\lVert A''\rVert\ \le\ \frac{2M}{((1-\sigma)\rho)^2}\ \le\ \frac{2C\rho}{(1-\sigma)^2\rho^2}=\frac{2C}{(1-\sigma)^2\rho}=\frac{2\lVert H\rVert_{op}}{(1-\sigma)^2\,g_n}\cdot\frac C\gamma .$$

So the $1/\gamma$ of $J=C/\gamma$ is literally $g_n/(\rho\lVert H\rVert_{op})$, and the $\gamma$ inside $C$ is the same symbol at the same value. **One variable, two appearances.** The earlier doubt is refuted, and it is refuted the same way [second-order.md:1302](../findings/second-order.md) refutes it (*"L156 names both in one hypothesis, and $J\gamma=C$"*), I reached it independently and agree. **No finding.**

The consequence that entry draws is worth restating because §7 turns on it: $J\gamma=C$ means L157's $t=\lambda\sqrt{c_p+w^2}/(2J\gamma)$ is $t=\lambda\sqrt{c_p+w^2}/(2C)$ **exactly**. That is the fact that breaks the separation claim.

## 4. The formula, and the derivation that does not produce it

### 4.1 What is true

The distance from $\Gamma$ to $\mathop{\mathrm{spec}}W^*=\{\lambda_-,\lambda_+\}$ is $\min(\alpha,\lvert D-\alpha\rvert)g_n$; on the admissible $\alpha<D$ this is $dg_n$ with $d=\min(\alpha,D-\alpha)$, switching at $\alpha=D/2$. **Claim A confirmed.** $D$ cross-checks independently: [second-order.md:901](../findings/second-order.md) records the Daleckii–Krein mixed coefficient $\lambda_-/(\lambda_--\lambda_+)=\tfrac{m-1}{2m-1}$, whence $\lvert\lambda_+-\lambda_-\rvert=\tfrac{2m-1}{m-1}\,\lvert\lambda_-\rvert$, the same $D$, from a computation that shares nothing with the contour work.

The correct estimate, which reproduces the stated $C$, runs on the resolvent **difference**. Since $A(0)=\mathrm{Alt}(W^*_-)=0$ ([second-order.md:1113](../findings/second-order.md)),

$$W_-(z)-W^*_-=-\frac1{2\pi i}\oint_\Gamma\zeta\Big[(W(z)-\zeta)^{-1}-(W^*-\zeta)^{-1}\Big]d\zeta,$$

and the Neumann tail of that bracket is bounded by $\dfrac1{dg_n}\cdot\dfrac{\gamma/d}{1-\gamma/d}=\dfrac{\gamma}{d(d-\gamma)g_n}$. Multiplying by $\tfrac1{2\pi}\cdot2\pi\alpha g_n\cdot(1+\alpha)g_n$ gives

$$M\ \le\ \frac{\alpha(1+\alpha)\,\gamma}{d\,(d-\gamma)}\,g_n\ =\ C(\alpha,\gamma)\cdot\gamma g_n\ =\ C(\alpha,\gamma)\,\rho\,\lVert H\rVert_{op},$$

which is the stated $C$ exactly, and is $M\le C\rho$ under hypothesis 4 of §1. On $\alpha\le D/2$, $d=\alpha$ and $C=\tfrac{\alpha(1+\alpha)}{\alpha(\alpha-\gamma)}=\tfrac{1+\alpha}{\alpha-\gamma}$: **claim B confirmed**, and it agrees with r441's independently computed $M\le6\rho$ at $(\tfrac12,\tfrac14)$, since $\tfrac{1.5}{0.25}=6$.

### 4.2 Finding C1, the proof's factor list multiplies out to a different constant

**Located.** The proof's one sentence of derivation:

> *"The Neumann step over the disc replaces $d$ by $d-\gamma$, and the contour length contributes $\alpha$; with $\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$ … this gives $C$."*

and the display it points back to, [second-order.md:1449](../findings/second-order.md), *"with every factor named"*:

$$\lVert W_-\rVert\le\frac1{2\pi}\cdot\underbrace{2\pi\alpha g_n}_{\text{length}}\cdot\max_\Gamma\lvert\zeta\rvert\cdot\max_\Gamma\lVert(W-\zeta)^{-1}\rVert.$$

**Exhibited.** Substituting the three named factors with the Neumann bound $\max_\Gamma\lVert(W-\zeta)^{-1}\rVert\le1/((d-\gamma)g_n)$:

$$\frac1{2\pi}\cdot2\pi\alpha g_n\cdot(1+\alpha)g_n\cdot\frac1{(d-\gamma)g_n}=\frac{\alpha(1+\alpha)}{d-\gamma}\,g_n=\frac{\alpha(1+\alpha)}{\gamma(d-\gamma)}\cdot\gamma g_n .$$

So the factor list as written delivers the constant $\dfrac{\alpha(1+\alpha)}{\gamma(d-\gamma)}$, which differs from the stated $\dfrac{\alpha(1+\alpha)}{d(d-\gamma)}$ by the factor $d/\gamma$, **exactly $2$ along the whole optimising ray $\gamma=d/2$**, including at the optimum. At the record's own check point $(\alpha,\gamma)=(\tfrac12,\tfrac14)$, $m=6$:

$$\text{as written: }\frac{\tfrac12\cdot\tfrac32}{\tfrac14\cdot\tfrac14}=\frac{3/4}{1/16}=12,\qquad\text{stated: }\frac{\tfrac12\cdot\tfrac32}{\tfrac12\cdot\tfrac14}=\frac{3/4}{1/8}=6 .$$

The as-written chain contradicts r441's $M\le6\rho$, the one value on the record computed by a third party, and contradicts the lemma's own reduced form $\tfrac{1+\alpha}{\alpha-\gamma}$. It also has the wrong shape: it diverges as $\gamma\downarrow0$, so $J=C/\gamma$ built on it would behave as $\gamma^{-2}$ and have no interior minimum in $\gamma$ at all.

**The opposite, argued.** The charitable reading is that *"the Neumann step"* is shorthand for the **difference** estimate of §4.1, whose tail carries the extra $\gamma/d$, one factor $1/d$ from the unperturbed resolvent on the right of the telescoping identity, and the factor $\gamma$ from $\lVert W(z)-W^*\rVert\le\gamma g_n$, and that the $\gamma$ then vanishes back into $\rho$ when the result is written as $M\le C\rho$. That reading is forced by $A(0)=0$ and it reproduces the stated $C$ exactly, so **the constant is right**. What is wrong is that this reading is nowhere on the page: the proof names three factors and a fourth is required, the display at 1449 that the proof leans on estimates $\lVert W_-\rVert$ rather than $\lVert W_-(z)-W^*_-\rVert$, and the word *difference* does not occur. **The finding stands as a defect of the proof, not of the formula.**

**Consequence.** By the round's first rule, this is what decides the verdict: the lemma's central formula, the one the chain consumes, has no correct derivation on file. I do not supply one, §4.1 is the reading I tested the words against, and I record it as the reading under which the number is right, not as a repair.

## 5. Quantifier order, scope, and the edges

**Order.** The proof takes $\min_{\alpha}\min_{\gamma}$, which is $\min_{(\alpha,\gamma)}$ because the inner minimum is attained for each $\alpha$; the inner minimiser $\gamma=d(\alpha)/2$ depends on $\alpha$ and is **not** a constant. **Confirmed, no finding**, but note that $\gamma^*=D/4$ and $\gamma^*=\alpha^*/2$ (the form [plan.md](../plan.md) uses) coincide *only at the optimum*; the lemma says so explicitly, and it is right to.

**No $\min$ is distributed across shared variables inside L156.** One is distributed downstream: the tube radius is a minimum over L149's three branches, branch 1 carrying no Cauchy constant at all, so $\min_{(\alpha,\gamma)}$ may not be pushed inside that outer $\min$. L156 does not claim otherwise and L151's withdrawal box already records it. **No finding against L156.**

**The edges.**

| Edge | What the lemma asserts, and whether it holds |
|---|---|
| $\alpha\downarrow0$ | $C\to\infty$, $\widehat J\sim4/\alpha^2\to\infty$. Consistent |
| $\alpha\uparrow D$ | $d\to0$, $C\to\infty$. The contour meets $\lambda_+$; excluded |
| $\alpha>D$ | The written $d=\min(\alpha,D-\alpha)$ goes negative, the true distance is $(\alpha-D)g_n$. The regime is inadmissible ($\Gamma$ would enclose $\lambda_+$), but the statement never says so |
| $\gamma\downarrow0$ or $\gamma\uparrow d$ | $J\to\infty$. Consistent |
| $\alpha=D/2$ exactly | Both branches agree, $d=\alpha=D-\alpha$; the reduced form $\tfrac{1+\alpha}{\alpha-\gamma}$ is valid up to and including this point, as claimed |
| smallest dimension in scope, $m=6$ ($n=12$) | $D=\tfrac{11}5$, $(\alpha^*,\gamma^*)=(\tfrac{11}{10},\tfrac{11}{20})$, $C^*=\tfrac{42}{11}=3.8181\ldots$, $J^*=\tfrac{840}{121}=6.94214\ldots$ All confirmed exactly |
| smallest $m$ at which the formula is defined, $m=2$ | $D=3$, $C^*=\tfrac{10}3$, $J^*=\tfrac{40}9$. Correct, and correctly flagged out of scope. **This edge has already bitten**: r711 carried $J^*=\tfrac{40}9$ into L158's threshold, and [second-order.md:1302](../findings/second-order.md) had to correct it |
| $\ker W\ne0$, witness $W_{\mathbb{CP}^2}$, $\dim\ker W=3$ | **L156 asserts nothing there, and cannot.** See below |

**$\ker W\ne0$.** The lemma is stated at $W^*=S^m\times S^m$, whose spectrum is two-valued **with no kernel** ([second-order.md:1108](../findings/second-order.md)). At $W_{\mathbb{CP}^2}$ the construction is void at the first step, not merely unproven: $0\in\mathop{\mathrm{spec}}$, so no circle about $\lambda_-$ separates the negative part from the rest at distance $\Theta(g_n)$, $d$ is not $\min(\alpha,D-\alpha)$, and $z\mapsto W_-(z)$ is not holomorphic at $z=0$, which removes the Cauchy estimate that defines $M$. **This is the correct answer and the entry gives it implicitly by hypothesis; recorded here because [trap W1](../findings/INDEX-traps.md) records that kernel failures are *"all invisible while working with sphere products"* and L156 is a sphere-product statement.** The exposure is in the entries that assume $\ker W^*=0$ *generally*, [ROUND_L147](ROUND_L147.md) already carries that debt, not in L156. **No finding against L156.**

**The constraints, and which binds.** $\gamma<d$ is *equivalent* to the conjunction of $\gamma<\alpha$ and $\alpha+\gamma<D$: on $\alpha\le D/2$ it reads $\gamma<\alpha$, whence $\alpha+\gamma<2\alpha\le D$; on $\alpha\ge D/2$ it reads $\alpha+\gamma<D$ directly. So the entry's *"$\alpha+\gamma<D$ is real and slack"* names one face of a single constraint, not a second constraint. $\gamma<1$ is genuinely separate. At the optimum, $\gamma^*=\tfrac D4\in(\tfrac12,\tfrac34]$ for $m\ge2$, so $\gamma^*<1$ and $\gamma^*=d/2<d$: **both slack, as claimed.** And $\alpha<1$ is indeed not a constraint, $0\notin\mathop{\mathrm{spec}}W^*$, the integrand $\zeta(W-\zeta)^{-1}$ is regular at $\zeta=0$, and enclosing a non-spectral point changes no Riesz projection. **Claim I confirmed.**

## 6. The values, verified exactly

$C^*=\gamma^*\widehat J(\alpha^*)$ with $\alpha^*=D/2$, $\gamma^*=D/4$:

$$C^*=\frac D4\cdot\frac{4(1+\tfrac D2)}{(\tfrac D2)^2}=\frac{4(1+\tfrac D2)}{D}=2+\frac4D=2+\frac{4(m-1)}{2m-1}.$$

$$J^*=\frac{C^*}{\gamma^*}=\frac{4(1+\alpha^*)}{\alpha^{*2}}=\frac{8(m-1)(4m-3)}{(2m-1)^2}.$$

At $m=6$: $\tfrac{8\cdot5\cdot21}{121}=\tfrac{840}{121}=6.94214\ldots$; at $m=2$: $\tfrac{8\cdot1\cdot5}{9}=\tfrac{40}9$. **Claim F confirmed.**

**Corollary, claim G.** $\alpha^*=\tfrac{2m-1}{2(m-1)}=1+\tfrac1{2(m-1)}$ decreases strictly to $1$; $\widehat J$ is strictly decreasing in $\alpha$; so $J^*$ strictly *increases* in $m$ to $\widehat J(1)=8$, unattained since $\alpha^*>1$ for every finite $m$. Likewise $C^*=2+4/D$ increases to $4$. On $n\ge12$ the minima are at $m=6$: $C^*\ge\tfrac{42}{11}$, $J^*\ge\tfrac{840}{121}>6.9421$. **Confirmed.** The fixed contour $(\alpha,\gamma)=(1,\tfrac12)$: $D-1=1+\tfrac1{m-1}>1$, so $d=1$ at every $m$, $C=\tfrac{1\cdot2}{1\cdot\frac12}=4$, $J=8$. **Confirmed.** The *"$15\%$ off the optimum"* is the $m=6$ figure, $8/\tfrac{840}{121}=\tfrac{121}{105}=1.1523\ldots$; the gap closes to $0$ as $m\to\infty$, which the sentence does not say. Recorded, not filed as a finding, the sentence sits inside a paragraph explicitly about $n\ge12$.

**Baseline and gain.** At $(\tfrac12,\tfrac14)$, $m=6$: $d=\tfrac12$, $C=6$, $J=24$. Gain $=24\big/\tfrac{840}{121}=\tfrac{121}{35}=3.4571\ldots$, **the entry's $3.46$ is right and the superseded $4.8$ is wrong.** Confirmed.

### 6.1 Finding C2, the r456 comparison value is wrong

**Located.** *"and r456's $(\tfrac43,\tfrac23)$ gives $J=23.85$ against the baseline's $24$, **no improvement at all**"*.

**Exhibited.** At $m=6$, $\alpha=\tfrac43$, $\gamma=\tfrac23$: $D-\alpha=\tfrac{11}5-\tfrac43=\tfrac{13}{15}$, and $\tfrac{13}{15}<\tfrac43=\tfrac{20}{15}$, so $d=\tfrac{13}{15}$ and $d-\gamma=\tfrac{13}{15}-\tfrac{10}{15}=\tfrac15$. Then

$$C=\frac{\tfrac43\cdot\tfrac73}{\tfrac{13}{15}\cdot\tfrac15}=\frac{28/9}{13/75}=\frac{700}{39}=17.9487\ldots,\qquad J=\frac C\gamma=\frac{700}{39}\cdot\frac32=\frac{350}{13}=26.9230\ldots$$

The $C$ agrees exactly with L152's *"the true constant is $17.9$"*; the $J$ does not agree with $23.85$. **The stated value is wrong by $\tfrac{350}{13}-23.85=3.07$.**

**The opposite, argued.** Could $23.85$ be $J$ under some other admissible reading? Re-optimising $\gamma$ at $\alpha=\tfrac43$ gives $\widehat J=4\alpha(1+\alpha)/d^3=\tfrac{112}9\cdot\tfrac{3375}{2197}=\tfrac{378000}{19773}=19.117\ldots$, not $23.85$. Solving $J(\tfrac43,\tfrac23)=23.85$ for $D$ gives $D=2.2205\ldots$, i.e. $m-1=4.53$: no integer $m$. So no reading of the record's own formula returns it. **The finding stands.** Its direction matters: the correct $26.92>24$ makes r456's point *worse* than the baseline, which is what the sentence concludes, whereas the printed $23.85<24$ would be a small improvement and would contradict *"no improvement at all"* in the same clause. **The number contradicts its own sentence; the corrected number supports it.**

## 7. The gap between what is proven and what is used

### 7.1 Finding C3, "the objective is $J=C/\gamma$" is exact only as $t\to0$, and $\gamma^*$ is a strict non-maximiser of the radius

**Located.** [second-order.md:1439](../findings/second-order.md): *"**What the objective is** … $J=C/\gamma$ … **The $(\alpha,\gamma)$ half separates from $\sigma$**, so that half is the one-parameter problem L156 solves in closed form"*; and [second-order.md:1433](../findings/second-order.md): *"the crossing $t(1-\sigma)^2=\sigma$ with $t=\sqrt{c_p+w^2}/(2J\gamma)$, in which $\gamma$ cancels for small $t$, that … is what legitimises splitting the optimisation."*

**Exhibited, in closed form, from the record's own identities.** Write $\Lambda=\lambda\sqrt{c_p+w^2}>0$. L157 gives the reach as the crossing root of $\eta=t(1-\eta)^2$ with $t=\Lambda/(2J\gamma)=\Lambda/(2C)$ (the second form exact, by §3) and the exact identity $\eta^*\gamma=\tfrac{\Lambda}{2J}(1-\eta^*)^2$. The quantity the chain wants is the tube radius $r=\eta^*\rho=\eta^*\gamma\,g_n/\lVert H\rVert_{op}$, so

$$\frac{r\,\lVert H\rVert_{op}}{g_n}=\eta^*\gamma=\frac{\Lambda}{2}\cdot\frac{(1-\eta^*)^2}{J}.$$

Differentiating $\eta=t(1-\eta)^2$ gives $\dfrac{d\eta^*}{dt}=\dfrac{(1-\eta^*)^2}{1+2t(1-\eta^*)}>0$, so $\eta^*$ is strictly increasing in $t$ and strictly decreasing in $C$. Now fix $\alpha=\alpha^*$ and vary $\gamma$ about $\gamma^*=d/2$:

- $\partial_\gamma J=0$ at $\gamma=d/2$ (that is exactly what makes $\gamma^*$ the minimiser);
- hence $\partial_\gamma C=\partial_\gamma(J\gamma)=\gamma\,\partial_\gamma J+J=J>0$ there;
- hence $\partial_\gamma t<0$, $\partial_\gamma\eta^*<0$, and $\partial_\gamma(1-\eta^*)^2>0$;
- hence $\partial_\gamma\big[(1-\eta^*)^2/J\big]>0$ **strictly**, at $\gamma=\gamma^*$.

So the radius **strictly increases** as $\gamma$ is raised above $D/4$, for every $\Lambda>0$. The move is admissible: at $m\ge6$ the binding cap is $\gamma<1$ and $\gamma^*=D/4\in(\tfrac12,\tfrac{11}{20}]$, leaving open room. **$\gamma^*=D/4$ minimises $J$ and does not maximise the tube radius.**

**The opposite, argued.** The boxed lemma claims only that $J=C/\gamma$ is minimised at $(D/2,D/4)$, and that is true; nothing in the box is touched. And the entry itself hedges (*"$\gamma$ cancels **for small $t$**"*) so the small-$t$ character of the reduction is half-admitted. In the small-$t$ limit the two objectives do coincide: $\eta^*\to t$ and $\eta^*\gamma\to\Lambda/(2J)$, whose maximiser is $\arg\min J$. So the reduction is a **good approximation in the regime the programme may well be in**, and the finding is not that $J^*$ is unusable.

**What the finding is.** Two sentences claim more than that. *"The $(\alpha,\gamma)$ half separates from $\sigma$"* is false: $\sigma=\eta^*$ is a function of $t=\Lambda/(2C(\alpha,\gamma))$, hence of both $\alpha$ and $\gamma$; the separation the sentence asserts is exactly what §3's $J\gamma=C$ denies. And *"in which $\gamma$ cancels"* is false of $t$ as written, $\gamma$ cancels from the *product* $\eta^*\gamma$ only after $\eta^*$ is linearised in $t$, and $t$ itself retains $\gamma$ through $C$. **The entry's own L157 line, [second-order.md:1262](../findings/second-order.md), says so in the opposite words (*"And $\gamma$ does not cancel"*) so the record contradicts itself across two adjacent entries on this exact point.**

### 7.2 Finding C4, the statement does not supply what the chain consumes

**Located.** The boxed LEMMA. It defines $C(\alpha,\gamma)$, names $J=C/\gamma$ as *"the objective"*, and gives $(\alpha^*,\gamma^*,C^*,J^*)$.

**Exhibited.** The box contains **no inequality**. It never says $M\le C\rho$, never defines $M$ or $A$, never states the perturbation $W(z)=W^*+zH$, never states the domain of $(\alpha,\gamma)$, and never states $\lVert H\rVert_{op}\le1$, the hypothesis without which the very statement $M\le C\rho$ that gives $C$ its meaning is false ([second-order.md:1308](../findings/second-order.md), r713: *"$M\le C\rho$ is sharp only at $\lVert H\rVert_{op}=1$"*). Read alone (which is how a numbered result is read), the box is the optimisation of a rational function of two variables over an unstated set.

**The opposite, argued.** The box sits inside a section whose set-up paragraph, [second-order.md:1388](../findings/second-order.md), does state $M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert\le C(\alpha,\gamma)\rho$, and a reader in place has it. That is a fair defence of the *page*. It is not a defence of the *statement*, which is what [results.md](../results.md) and [INDEX-results.md](../findings/INDEX-results.md) propagate and what downstream rounds quote. **Finding stands, at the level the brief asks: the statement does not give $J^*$, $C^*$ and $(\alpha^*,\gamma^*)$ at the generality they are used, because it does not say what they are constants of.**

## 8. The two forms, [results.md](../results.md) against [findings/second-order.md](../findings/second-order.md)

### 8.1 Finding C5, results.md carries the sentence findings.md withdraws

**Located.** [results.md:355](../results.md), final sentence: *"The objective itself was never stated on the record, and **$\sigma$ factorises out of it, so the joint three-parameter optimisation reduces to one parameter in closed form**."* Against [second-order.md:1439](../findings/second-order.md): *"**the claim that $\sigma$ factorises out of the whole is withdrawn**, $\sigma$ being tied to the reach by the crossing condition."*

**Exhibited.** The two sentences assert and deny the same proposition. The canonical file carries the withdrawn one, and so do two further carriers: [findings/INDEX-results.md:175](../findings/INDEX-results.md) (*"Names the objective the record never stated, and $\sigma$ factorises out of it"*) and [plan.md:68](../plan.md) (*"The objective $J=C/\gamma$ is now named and $\sigma$ factorises out of it, so the three-parameter optimisation is one parameter in closed form"*). §7.1 shows independently that the withdrawn version is the false one: $\sigma=\eta^*(t)$ with $t=\Lambda/(2C(\alpha,\gamma))$.

**The opposite, argued.** *"Factorises out"* could mean only that $(1-\sigma)^{-2}$ is an algebraic factor of the displayed bound $2M/((1-\sigma)\rho)^2$, true, at fixed $\sigma$. But all three carriers draw the inference *"so the three-parameter optimisation reduces to one parameter"*, and that inference is precisely what findings.md withdraws and what §7.1 refutes. The charitable reading does not survive the clause that follows it. **Finding stands, and it is the round's first finding by the canonical cross-check rule.**

### 8.2 Finding C6, results.md's L156 entry omits $J^*$, which results.md's own L158 entry consumes

**Located.** [results.md:355](../results.md) gives $\alpha^*$, $\gamma^*$ and $C^*$ and no $J^*$, no closed form in $m$, and no range restriction. [results.md:367](../results.md), the L158 entry, turns on *"whether **Lemma L156's $2J^*$** enters the branch-2 prefactor"*.

**Exhibited.** $J^*$ appears exactly once in [results.md](../results.md), in the entry that consumes it, never in the entry that supplies it. Nor do the intervals $\tfrac{42}{11}\le C^*<4$ and $6.9421\le J^*<8$, nor the scope restriction to $n\ge12$. The cost is on the record: r711 carried $J^*=\tfrac{40}9$, the $m=2$ endpoint, into exactly that threshold dispute, and [second-order.md:1302](../findings/second-order.md) had to correct it, an error the canonical entry, as written, does nothing to prevent and everything to invite, since it states $C^*$ as a function of $m$ with no admissible range for $m$.

**The opposite, argued.** $J^*=C^*/\gamma^*=4C^*/D$ follows from what results.md does state, in one line. So this is an omission and not an error, and I grade it below C1 and C5. It is still a finding: the brief asks whether the statement supplies each constant *at the generality it is used*, the demonstrated failure mode is the missing range rather than the missing division, and the corollary (which is where the range lives), reaches results.md not at all.

### 8.3 Differences recorded without a finding

- results.md calls $C$ *"the constant governing the tube radius"*; findings.md derives it as the Cauchy constant in $M\le C\rho$, one input to the radius among at least nine ([L151](../findings/second-order.md)'s withdrawal box). Loose, and in the same direction as C5, but it is a description and not a claim.
- results.md: *"The binding condition is the switch of the nearest spectral point, not encirclement of $0$ **or of $\lambda_+$**"*; findings.md: *"$\alpha+\gamma<D$ is **real** and slack"*. The second clause of the results.md sentence reads as denying a constraint the findings text affirms. Under the charitable reading it denies only that the constraint *binds*, which is true. **Withdrawn as a finding, recorded as wording.**
- Calling the kink *"the binding condition"* is a category slip in both files, at an interior optimum with every constraint slack, nothing binds; the kink is a non-smoothness of the objective. The mathematics underneath (the minimum sits at the kink) is correct in both. **Withdrawn as a finding.**

### 8.4 Candidate withdrawn, "$J$ is stationary at the optimum"

**Located.** [second-order.md:1262](../findings/second-order.md), inside L157: *"what is true is that $J$ is **stationary** at the optimum, so $J^*$ is right to $O(t^2)$."*

**Exhibited.** As a statement about $\alpha$ it is false: §2 gives the one-sided slopes $-\tfrac{16(D+4)}{D^3}$ and $+\tfrac{80D+128}{D^3}$, at $m=6$ equal to $-\tfrac{12400}{1331}$ and $+\tfrac{38000}{1331}$, both non-zero.

**The opposite, argued.** As a statement about $\gamma$, which is the variable under discussion in that sentence, whose subject is *"$\gamma$ does not cancel"*, it is true and load-bearing: $J$ is smooth in $\gamma$ and $\partial_\gamma J=0$ at $\gamma=d/2$. That reading is available and is the natural one in context. **Withdrawn**, with the reason: the false reading is not the one the sentence is making. Recorded anyway because the ambiguity is a live hazard, §7.1's argument turns on $\partial_\gamma J=0$ being true while $\partial_\alpha J\ne0$.

## 9. What would falsify the statement, and what I did to look for it

**The object that would break it:** an admissible pair $(\alpha,\gamma)$ (meaning $0<\alpha<D$, $0<\gamma<\min(d(\alpha),1)$), with $J(\alpha,\gamma)<J^*$; equivalently, a second stationary structure in $\widehat J$ away from $\alpha=D/2$, or a third spectral point of $W^*$ making $d=\min(\alpha,D-\alpha)$ wrong.

**Where I looked, by hand.** (i) $\widehat J$ is strictly monotone on each of $(0,D/2]$ and $[D/2,D)$ with the signs computed exactly in §2, so there is no second local minimum and no admissible pair beats $J^*$: the constraint $\gamma<1$ can only remove candidates, and it removes none near the optimum. (ii) The spectrum: [second-order.md:1108](../findings/second-order.md) records it as two-valued with no kernel, and $D$ is independently reproduced from the Daleckii–Krein coefficient $\tfrac{m-1}{2m-1}$ at [second-order.md:901](../findings/second-order.md), two routes, one value. (iii) The two named comparison points, $(\tfrac12,\tfrac14)$ and $(\tfrac43,\tfrac23)$, evaluated exactly in §6; both are worse than $J^*$, the second by more than the entry says. **No falsifier exists, and none of the arithmetic depends on a computation I could not do by hand.**

**What is not falsified but is unproven here:** that $J$ is the right thing to minimise. §7.1 exhibits, from L157's own identity, a strictly better $\gamma$ for the radius. That is a finding against the framing, not against the box.

## 10. Verdict

**`GAP`.**

Everything the box asserts is exactly true, on the domain it does not state: $C$'s formula and its reduction, the interior attained minimum, and each of $\alpha^*=\tfrac{2m-1}{2(m-1)}$, $\gamma^*=\tfrac D4$, $C^*=2+\tfrac{4(m-1)}{2m-1}$, $J^*=\tfrac{8(m-1)(4m-3)}{(2m-1)^2}$, together with the corollary's intervals. Both pre-registered questions resolve in the entry's favour: the optimum is **attained**, by explicit monotonicity on two branches meeting at an admissible interior point; and the two $\gamma$'s are **one $\gamma$**, since the $1/\gamma$ of $J$ is $g_n/(\rho\lVert H\rVert_{op})$ and the $\gamma$ of $C$ is $\lVert W(z)-W^*\rVert/g_n$ at $\lvert z\rvert=\rho$.

The verdict is not `PROVEN` for one reason, C1: **the derivation on file does not produce the constant on file.** The proof names three factors whose product is $\tfrac{\alpha(1+\alpha)}{\gamma(d-\gamma)}$, $12$ at $(\tfrac12,\tfrac14)$ where the lemma, its own reduced form, and r441's independent computation all give $6$, and the fourth factor, the resolvent-difference step that $A(0)=0$ makes available, is nowhere written. Four further findings ride with it: the framing claim that $J$ is the chain's objective is exact only as $t\to0$ and $\gamma^*$ is a strict non-maximiser of the radius (C3); the statement carries no inequality, no domain and no $\lVert H\rVert_{op}$ hypothesis (C4); [results.md](../results.md), [INDEX-results.md](../findings/INDEX-results.md) and [plan.md](../plan.md) all carry the *"$\sigma$ factorises out"* sentence that [findings/second-order.md](../findings/second-order.md) withdraws (C5); and results.md omits $J^*$ and the $n\ge12$ range that its own L158 entry needs (C6). One stated value is wrong: $J=\tfrac{350}{13}=26.923$ at $(\tfrac43,\tfrac23)$, not $23.85$ (C2).

**What a repair owes, named and not supplied here:** the resolvent-difference step written out; the domain $0<\alpha<D$, $0<\gamma<\min(d,1)$ and the hypothesis $\lVert H\rVert_{op}\le1$ moved into the statement alongside the inequality $M\le C\rho$; and either a proof that the small-$t$ reduction is exact enough at the programme's parameters, or a statement of $J$ as a small-$t$ proxy rather than as *the* objective.
