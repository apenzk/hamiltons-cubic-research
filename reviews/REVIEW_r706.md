# Review r706, adversarial audit of [Lemma L152](../findings/second-order.md): the numerator is right, the constant is right only on half its stated range, and the reason given for preferring it refutes a step [r457](REVIEW_r457.md) never took

*Reviewer r706, 2026-09-05, cold adversarial brief. Target: **C1**, [Lemma L152](../findings/second-order.md)'s resolution of the [r456](REVIEW_r456.md)/[r457](REVIEW_r457.md) numerator split, and **C2**, the admissible range of the contour parameter $\alpha$, which the record asserts three incompatible ways. Read in full: [Lemma L152](../findings/second-order.md) and the section "The contour constant for the balanced-orbit defect, and a live disagreement in it" above it, [Lemma L151](../findings/second-order.md), [Lemma L149](../findings/second-order.md), [Lemma L148](../findings/second-order.md), [Lemma L147](../findings/second-order.md), [Lemma L146](../findings/second-order.md), [Lemma L145](../findings/second-order.md), [r441](REVIEW_r441.md), [r456](REVIEW_r456.md), [r457](REVIEW_r457.md). **Analysis only** ([analysis-only.md](../.claude/rules/analysis-only.md)): every derivation below is by hand. One screen is reported, on a closed form derived here, and it is evidence for nothing. Working: [agent_logs/r706.log](../agent_logs/r706.log).*

## The one-line verdict

**C1 REFUTED, C2 ANSWERED, and both failures share one cause: every party to the dispute used $\max_\Gamma\lVert(W^*-\zeta)^{-1}\rVert=1/(\alpha g_n)$ as though it held for all $\alpha$.** It holds only while $\lambda_-$ is the spectral point nearest $\Gamma$, i.e. while $\alpha\le\tfrac12\lvert\lambda_+-\lambda_-\rvert/g_n$. Past that the nearest point is $\lambda_+$ and the resolvent bound is $1/((D-\alpha)g_n)$ with $D=\tfrac{2m-1}{m-1}$. L152's numerator identity survives; its formula for $C$ does not survive past $\alpha=D/2$; [r456](REVIEW_r456.md)'s optimum at $(\tfrac43,\tfrac23)$ lies past it and is **worse than the point it claims to improve on**; and the true optimum is interior, attained, at the contour equidistant from $\lambda_-$ and $\lambda_+$, which is [r441](REVIEW_r441.md)'s recommendation, made two months of reviews ago and never priced.

## Verdicts, per claim

| # | claim | verdict |
|---|---|---|
| C1a | the numerator is $\max_\Gamma\lvert\zeta\rvert$, and on a circle of radius $\alpha g_n$ about $\lambda_-$ that equals $(1+\alpha)g_n$ | **CONFIRMED** (F1). It needs $\lambda_-$ real and $\lvert\lambda_-\rvert=g_n$; both hold at $W^*$, the second as a computed coincidence rather than a definition |
| C1b | hence $C(\alpha,\gamma)=\dfrac{1+\alpha}{\alpha-\gamma}$ | **REFUTED as a general formula, CONFIRMED on $\alpha\le D/2$.** The correct form is $C=\dfrac{\alpha(1+\alpha)}{d\,(d-\gamma)}$ with $d=\min(\alpha,D-\alpha)$, $D=\tfrac{2m-1}{m-1}$ (F2) |
| C1c | [r457](REVIEW_r457.md)'s $\tfrac m{m-1}$ is $\lambda_+/g_n$, "which therefore cannot bound $\lvert\zeta\rvert$ on $\Gamma$" | **REFUTED as a refutation.** [r457](REVIEW_r457.md) never bounds $\lvert\zeta\rvert$ by it. Its $\tfrac m{m-1}$ is $\lVert W^*\rVert_{op}/g_n$ inside a **different** decomposition, $A=\mathrm{Alt}(-\Pi(z)(W(z)-W^*)-(\Pi(z)-\Pi(0))W^*)$, where that factor is exact and legitimate (F3) |
| C1d | "r456 is right" and the two are a disagreement to be settled | **REFUTED as posed.** Both bounds are **valid** upper bounds on the same $M$; [r456](REVIEW_r456.md)'s is strictly sharper for every $\alpha<\tfrac m{m-1}$ and lossier beyond. There is no false statement to overturn, only a slack one (F3) |
| C1e | "three independent computations meet at one value" ($6$ at $(\tfrac12,\tfrac14)$) | **REFUTED on independence.** [r456](REVIEW_r456.md)'s formula *is* [r441](REVIEW_r441.md)'s bookkeeping with $(\tfrac12,\tfrac14)$ replaced by $(\alpha,\gamma)$; [r456](REVIEW_r456.md) says so in its own scope note. Two of the three computations are one computation, so reproducing $6$ is an algebra check, not corroboration (F4) |
| C2a | $\alpha<1$, from separating $\lambda_-$ from $0$ | **REFUTED.** $0\notin\operatorname{spec}(W^*)$; the integrand $\zeta(W-\zeta)^{-1}$ has no singularity there, and no step of the chain needs $0$ outside $\Gamma$. The real content of "no eigenvalue crosses $0$" is a constraint on $\gamma$, not on $\alpha$ (F5) |
| C2b | $\alpha<D=\tfrac{2m-1}{m-1}$, from separating $\lambda_-$ from $\lambda_+$ | **CONFIRMED as the admissibility constraint, REFUTED as the binding one.** It is necessary, but the objective turns at $\alpha=D/2$, well inside it (F6) |
| C2c | [r457](REVIEW_r457.md)'s supremum at $\alpha\to1$, unattained | **REFUTED.** It is an artefact of [r457](REVIEW_r457.md)'s unnecessary $\alpha\in(0,1)$. Dropping it makes the optimum interior and attained (F6) |
| C2d | [r456](REVIEW_r456.md)'s optimum near $(\tfrac43,\tfrac23)$, worth a factor $\approx4.8$ | **REFUTED.** At $m=6$ the true value of the objective there is $53.8$ against $48$ at [r441](REVIEW_r441.md)'s $(\tfrac12,\tfrac14)$: the "optimum" is worse than the baseline. As $m\to\infty$ it degenerates, $C\to\infty$ (F6, F7) |
| C2e | the optimum and its constraint | **ANSWERED.** $\alpha^*=\tfrac D2=\tfrac{2m-1}{2(m-1)}$, $\gamma^*=\tfrac D4$, attained, pinned by the **resolvent kink**, the point where $\lambda_-$ and $\lambda_+$ are equidistant from $\Gamma$. Gain over $(\tfrac12,\tfrac14)$ is $6\alpha^{*2}/(1+\alpha^*)$: $3.46$ at $n=12$, $\to3$ as $n\to\infty$ (F6) |
| C2f | the objective being optimised | **NOT STATED ANYWHERE ON THE RECORD, and it is not $C$.** Minimising $C$ alone drives $\gamma\to0$ and is meaningless. The objective is $\lVert A''\rVert\le\frac{2C(\alpha,\gamma)}{(1-\sigma)^2\gamma}\cdot\frac{\lVert H\rVert_{op}}{g_n}$, i.e. minimise $C/\gamma$ (F8) |

---

## F1, the numerator identity is CONFIRMED, and its two hypotheses are real

$\Gamma$ is the circle $\{\zeta:\lvert\zeta-\lambda_-\rvert=\alpha g_n\}$. For a circle of radius $r$ about a centre $c$, $\max\lvert\zeta\rvert=\lvert c\rvert+r$, attained on the ray from $0$ through $c$. So $\max_\Gamma\lvert\zeta\rvert=\lvert\lambda_-\rvert+\alpha g_n$, and this is an identity, not an estimate. It needs $\lvert c\rvert=\lvert\lambda_-\rvert$, which needs $\lambda_-$ to be the actual centre, so the contour must be centred at the eigenvalue, which is how the record defines it. $W^*$ is real symmetric, $\lambda_-$ is real, and nothing in the identity uses that anyway: $\lvert c\rvert+r$ is centre-independent of argument.

**$\lvert\lambda_-\rvert=g_n$ is a computed value at $W^*$, not a definition, and it is safe.** $g_n$ is defined in [Lemma L145](../findings/second-order.md) as the analyticity radius $\operatorname{dist}(\operatorname{spec},0)=\min_a\lvert\lambda_a\rvert$; it equals $\lvert\lambda_-\rvert$ **because** $\lvert\lambda_-\rvert<\lambda_+$, which is a fact about the balanced product, not a convention. Rebuilt cold: the negative eigenspace is $V_1\otimes V_2$, $\dim m^2$; the positive is $\Lambda^2V_1\oplus\Lambda^2V_2$, $\dim m(m-1)$; $\operatorname{tr}W^*=0$ gives $\lambda_+=\tfrac m{m-1}g_n>g_n$. So the minimum is on the negative side and the identification holds. *Where it would fail is at a perturbed base point: $\lvert\lambda_-(t)\rvert\ne g_n$ in general. That is harmless here only because the contour $\Gamma$ is held fixed about $\operatorname{spec}(W^*)$ throughout the disc, so every numerator and every resolvent in the chain is an object of $W^*$. **L152 does not say this**, and a reader who re-centres $\Gamma$ at the moving eigenvalue (which is what "the circle about $\lambda_-$" invites at an interior base point), loses the identity.*

## F2, the resolvent factor is wrong for $\alpha>D/2$, and that is where the whole optimisation lives

$W^*$ is real symmetric, hence normal, so $\lVert(W^*-\zeta)^{-1}\rVert_{op}=1/\operatorname{dist}(\zeta,\operatorname{spec}W^*)$ **exactly**. On $\Gamma$, $\operatorname{dist}(\zeta,\lambda_-)=\alpha g_n$ for every $\zeta$, while $\operatorname{dist}(\zeta,\lambda_+)$ ranges over $[\lvert D-\alpha\rvert g_n,(D+\alpha)g_n]$ with

$$D:=\frac{\lvert\lambda_+-\lambda_-\rvert}{g_n}=1+\frac m{m-1}=\frac{2m-1}{m-1}\in(2,3].$$

Hence

$$\max_\Gamma\lVert(W^*-\zeta)^{-1}\rVert=\frac1{d\,g_n},\qquad d:=\min(\alpha,\,D-\alpha).$$

**Both [r456](REVIEW_r456.md) and [r457](REVIEW_r457.md) write $d=\alpha$ unconditionally, and L152 inherits it.** [r457](REVIEW_r457.md) is protected by its own (unnecessary) restriction $\alpha<1<D/2$; [r456](REVIEW_r456.md) is not, and its stated optimum is on the far side of the kink.

**Redoing [r441](REVIEW_r441.md)'s Neumann bookkeeping with the correct $d$.** With $R_\zeta=(W^*-\zeta)^{-1}$, $\lVert zH\rVert_{op}=\gamma g_n$ and $\lVert zH\rVert_F=\rho$ on $\lvert z\rvert=\rho$, the term of order $k\ge1$ in $-\tfrac1{2\pi i}\oint\zeta\,R_\zeta(zHR_\zeta)^k d\zeta$, spending Frobenius once on $H$ and operator norm on every resolvent, is at most

$$\underbrace{\alpha g_n}_{\lvert\Gamma\rvert/2\pi}\cdot\underbrace{(1+\alpha)g_n}_{\max\lvert\zeta\rvert}\cdot\frac1{(dg_n)^{k+1}}\cdot\rho\cdot(\gamma g_n)^{k-1}\;=\;\frac{\alpha(1+\alpha)}{d^2}\Big(\frac\gamma d\Big)^{k-1}\rho ,$$

and summing the geometric series ($\gamma<d$),

$$\boxed{\;M\;\le\;C(\alpha,\gamma)\,\rho,\qquad C(\alpha,\gamma)=\frac{\alpha\,(1+\alpha)}{d\,(d-\gamma)},\qquad d=\min(\alpha,D-\alpha).\;}$$

**On $\alpha\le D/2$ this is exactly L152's $\tfrac{1+\alpha}{\alpha-\gamma}$**, the contour length's $\alpha$ cancelling one power of the resolvent. **Past $D/2$ nothing cancels and the two disagree.** This answers the brief's question about a missing factor $\alpha$: the recorded $C$ is not missing it (it is cancelled) but the cancellation is an accident of the regime the formula was derived in, and quoting the cancelled form outside that regime is the error.

## F3, [r457](REVIEW_r457.md)'s $\tfrac m{m-1}$ is $\lVert W^*\rVert_{op}$, not a bound on $\lvert\zeta\rvert$, and L152 refutes a step nobody took

L152's dispositive sentence, *"$\tfrac m{m-1}$ is $\lambda_+/g_n$, the positive eigenvalue, which $\Gamma$ does not enclose and whose magnitude therefore never bounds $\lvert\zeta\rvert$ on $\Gamma$"*, attributes to [r457](REVIEW_r457.md) a claim about $\max_\Gamma\lvert\zeta\rvert$. **[r457](REVIEW_r457.md) never estimates $\max_\Gamma\lvert\zeta\rvert$ at all.** Its route is the projection identity $W_-=W\Pi$, giving

$$W(z)_--W^*_-=(W(z)-W^*)\Pi(z)+W^*(\Pi(z)-\Pi(0)),$$

and then $\lVert\Pi(z)\rVert_{op}\le\tfrac\alpha{\alpha-\gamma}$, $\lVert\Pi(z)-\Pi(0)\rVert_F\le\tfrac\rho{(\alpha-\gamma)g_n}$, $\lVert W^*\rVert_{op}=\lambda_+=\tfrac m{m-1}g_n$. The $\tfrac m{m-1}$ multiplies the **second** term and is the operator norm of $W^*$, which is $\lambda_+$ whatever $\Gamma$ encloses. *Recomputed with the corrected $d$, r457's route gives $C=\frac{\alpha(d+\tfrac m{m-1})}{d(d-\gamma)}$, reducing to its boxed formula at $d=\alpha$.*

**So the split is not a contradiction; it is two correct estimates of one quantity.** Comparing numerators, [r456](REVIEW_r456.md)'s $\alpha(1+\alpha)/d$ beats [r457](REVIEW_r457.md)'s $\alpha(d+\tfrac m{m-1})/d$ exactly when $1+\alpha<d+\tfrac m{m-1}$, which on $\alpha\le D/2$ reads $1<\tfrac m{m-1}$ (always) and in general reads $\alpha<\tfrac m{m-1}$. Since the optimum sits at $\alpha^*=D/2<\tfrac m{m-1}$, **[r456](REVIEW_r456.md)'s is the one to keep, and L152's conclusion is right for a reason it does not give.** The right sentence is *"[r456](REVIEW_r456.md)'s estimate is sharper by the factor $\tfrac{1+\alpha}{\alpha+m/(m-1)}$, worth $12\%$ at $n=12$ and at the optimum"*, in place of *"[r457](REVIEW_r457.md)'s numerator cannot bound $\lvert\zeta\rvert$"*. **A lemma whose headline is a refutation of a step its target never took is a lemma whose Gate 2 has not read the target.**

## F4, the "one check both have passed" is circular, and it is an algebra check

L152 and the agreed list above it both rest weight on: [r441](REVIEW_r441.md) computed $M\le\tfrac32g_n=6\rho$ at $(\tfrac12,\tfrac14)$, and [r456](REVIEW_r456.md)'s formula returns $6$ exactly. **This is not corroboration.** [r456](REVIEW_r456.md)'s own scope note says it: *"[r441](REVIEW_r441.md)'s Neumann bookkeeping is inherited rather than re-derived term by term; I re-derived only its $(\alpha,\gamma)$-generalisation and checked that it reproduces [r441](REVIEW_r441.md)'s $M\le\tfrac32g_n$ at $(\tfrac12,\tfrac14)$."* A generalisation reproducing its own special case is a check that the generalisation was carried out correctly, which is worth having and is not evidence about the numerator. *The record's phrase "three independent computations meet at one value" should read "one computation, checked twice at its own special case".*

**What the check does establish, and it is not nothing.** [r457](REVIEW_r457.md)'s formula returns $6.8$ at $(\tfrac12,\tfrac14)$ for $m=6$, so it is strictly lossier there, consistent with F3 and with the two being different estimates rather than a contradiction.

## F5, enclosing $0$ is harmless for $\alpha$, and the "no eigenvalue crosses $0$" constraint lands on $\gamma$

I checked every step of the chain for a hidden dependence on $0\notin\operatorname{int}\Gamma$.

| step | needs $0$ outside $\Gamma$? |
|---|---|
| the contour integral is defined | **no.** $\zeta\mapsto\zeta(W-\zeta)^{-1}$ is holomorphic off $\operatorname{spec}(W)$; $\zeta=0$ is a regular point |
| the integral equals $W_-$ | **no.** Its value depends only on which spectral points $\Gamma$ encircles, and $0$ is not one |
| the Neumann/resolvent estimate | **no.** It sees only $\operatorname{dist}(\Gamma,\operatorname{spec})=d\,g_n$ |
| holomorphy of $z\mapsto W(z)_-$ on $\lvert z\rvert<\rho$ | **no**, but it needs the perturbed spectrum not to cross $\Gamma$: $\gamma<d$, which is the same condition as convergence |
| the continuation **is** $W(t)_-$ on the real segment | **this is where $0$ enters, and it is a condition on $\gamma$.** For $t$ real, $W(t)$ is Hermitian and Weyl's inequality moves each eigenvalue by at most $\lvert t\rvert\lVert H\rVert_{op}<\gamma g_n$. The negative cluster stays negative iff $\gamma<1$; the positive cluster stays positive iff $\gamma<\tfrac m{m-1}$, which is weaker |

**So the record's "separation from $0$" intuition is not empty, it is misfiled.** It is $\gamma<1$, not $\alpha<1$. L152's sentence *"$\alpha<1$ keeps $0$ outside … the first binding"* is wrong twice: keeping $0$ outside is not required, and even were it a constraint it is not the one that binds. *The agreed list above L152 is the entry that has this right ("$\alpha$ may exceed $1$") and L152, written to settle the disagreement, adopts the wrong branch of it while quoting the right one.*

## F6, the optimum, its constraint, and why it is neither of the two candidates

**The admissible set.** $0<\alpha<D$ (so $\Gamma$ encircles $\lambda_-$ and excludes $\lambda_+$); $0<\gamma<d=\min(\alpha,D-\alpha)$ (Neumann convergence, equivalently no crossing of $\Gamma$); $\gamma<1$ (F5). It is two-dimensional and open, and **its shape is a kite with the kink at $\alpha=D/2$**, which is the geometric content the record is missing.

**The objective** (F8): minimise $\Phi(\alpha,\gamma)=\dfrac{2C(\alpha,\gamma)}\gamma=\dfrac{2\alpha(1+\alpha)}{\gamma\,d\,(d-\gamma)}$, in units of $\lVert H\rVert_{op}/g_n$.

**Step 1, the inner variable.** $\gamma\mapsto\gamma(d-\gamma)$ is maximised at $\gamma=d/2$, giving $d^2/4$. So $\gamma^*=d/2$, **half the distance from $\Gamma$ to the nearest spectral point**, and

$$\Phi(\alpha)=\frac{8\alpha(1+\alpha)}{d^3}.$$

*[r456](REVIEW_r456.md)'s and [r457](REVIEW_r457.md)'s shared "$\gamma=\alpha/2$, half the contour radius" is the special case $d=\alpha$, and it is wrong past the kink.* Note $\gamma^*=d/2\le D/4\le\tfrac34<1$ for every $m\ge2$: **the constraint $\gamma<1$ never binds at the optimum**, which is why the record could get away with ignoring it.

**Step 2, the outer variable, and the kink is the answer.**

- On $\alpha\le D/2$, $d=\alpha$ and $\Phi=\dfrac{8(1+\alpha)}{\alpha^2}$, with $\Phi'=-8(\alpha+2)/\alpha^3<0$: **strictly decreasing**, so push $\alpha$ up.
- On $\alpha>D/2$, $d=D-\alpha$ and $\Phi=\dfrac{8\alpha(1+\alpha)}{(D-\alpha)^3}$: numerator increasing, denominator decreasing, so **strictly increasing**, and $\Phi\to\infty$ as $\alpha\to D$.

$\Phi$ is continuous, so the minimum is exactly at the kink:

$$\boxed{\;\alpha^*=\frac D2=\frac{2m-1}{2(m-1)},\qquad \gamma^*=\frac D4=\frac{2m-1}{4(m-1)},\qquad C^*=\frac{1+\alpha^*}{\alpha^*-\gamma^*}=\frac{2(1+\alpha^*)}{\alpha^*},\qquad \Phi^*=\frac{8(1+\alpha^*)}{\alpha^{*2}}.\;}$$

**The constraint that binds is neither of the two the brief names.** It is the equidistance condition $\alpha=D-\alpha$: the optimal contour is the circle **equidistant from $\lambda_-$ and $\lambda_+$**, and what stops $\alpha$ growing is the resolvent, not the encirclement. $\alpha<D$ is necessary and slack; $\alpha<1$ is not a constraint at all. **The optimum is attained, at an interior point, and $\alpha^*>1$ always**, so the agreed list's "$\alpha$ may exceed $1$" is vindicated and [r457](REVIEW_r457.md)'s unattained supremum is an artefact of a restriction it imposed for a reason F5 refutes.

**Values.**

| $(\alpha,\gamma)$ | $m=6$ ($n=12$) | | $m\to\infty$ | |
|---|---|---|---|---|
| | $C$ | $\Phi$ | $C$ | $\Phi$ |
| $(\tfrac12,\tfrac14)$, [r441](REVIEW_r441.md) | $6$ | $48$ | $6$ | $48$ |
| $(\tfrac43,\tfrac23)$, [r456](REVIEW_r456.md)'s "optimum" | $17.95$ | $53.85$ | $\infty$ | $\infty$ |
| $(\alpha^*,\gamma^*)=(1.1,0.55)$ | $3.818$ | $13.88$ | $4$ | $16$ |

**The gain over the record's $(\tfrac12,\tfrac14)$ is $\Phi(\tfrac12,\tfrac14)/\Phi^*=6\alpha^{*2}/(1+\alpha^*)$: $3.46$ at $n=12$, decreasing to $3$.** [r456](REVIEW_r456.md)'s advertised $4.8$ is a factor its own point does not deliver, and [r441](REVIEW_r441.md) named the winner in one clause (*"a contour at radius $\approx(\lambda_+-\lambda_-)/2$"*) which is $\alpha^*$ exactly, not approximately.

> **Screen** (self-constructed, seconds; evidence for nothing, and it can fail, a wrong closed form shows as a mismatch between the grid minimiser and $(\alpha^*,\gamma^*)$). Minimising $\Phi$ over the corrected admissible region at $m=6$ on a $4000\times2000$ grid returns $13.889$ at $(1.0997,0.5497)$, against the closed form's $13.884$ at $(1.1,0.55)$; the same grid reproduces $48$ at $(\tfrac12,\tfrac14)$ and $53.85$ at $(\tfrac43,\tfrac23)$.

## F7, [r456](REVIEW_r456.md)'s $(\tfrac43,\tfrac23)$ is not merely suboptimal; it degenerates

Its admissibility claim (*"yes for every $m\ge2$"*), is true but empty. The constraint is $\gamma<D-\alpha$, i.e. $\tfrac23<\tfrac{2m+1}{3(m-1)}$, which reduces to $-2<1$; so it holds for all $m$, **with margin $\tfrac{2m+1}{3(m-1)}-\tfrac23=\tfrac1{m-1}\to0$**. The point approaches the boundary of its own admissible set, so $C\to\infty$: $17.95$ at $m=6$, $221.9$ at $m=50$. *A choice whose constant diverges in the programme's own asymptotic regime was screened by a grid that carried the pre-kink resolvent bound and an incorrect boundary $\alpha+\gamma<2$; the screen therefore could not have caught it, which is the failure mode [Lemma L146](../findings/second-order.md)'s closing note already names.*

**And its own reported closed form is misprinted.** [r456](REVIEW_r456.md) writes the objective at $\gamma=\alpha/2$ as $4(1+\alpha)/\alpha^2$; substituting gives $8(1+\alpha)/\alpha^2$, which is what its table's $48$ and $10.5$ actually are. Harmless to its conclusions, and it means the displayed formula and the displayed numbers were never reconciled.

## F8, the objective, named, and why naming it matters

The record optimises without ever writing down what it optimises, and the two published attempts optimise **different things**: [r456](REVIEW_r456.md) minimises $2C/\rho$, [r457](REVIEW_r457.md) maximises $\sqrt c\,\rho/C$. Those have the same minimiser in $\gamma$ only by coincidence of both being monotone in the same combination.

**The objective is the second branch of [Lemma L149](../findings/second-order.md)'s chain**, $r(H)\gtrsim\sqrt{c(H)}/\lVert A''\rVert$, so one minimises the bound on $\lVert A''\rVert$. Through [r456](REVIEW_r456.md) F4's segment shrinkage,

$$\lVert A''\rVert_{\sup,\lvert t\rvert\le\sigma\rho}\;\le\;\frac{2M}{(1-\sigma)^2\rho^2}\;\le\;\frac{2C(\alpha,\gamma)}{(1-\sigma)^2\,\rho}\;=\;\frac{2C(\alpha,\gamma)}{(1-\sigma)^2\,\gamma}\cdot\frac{\lVert H\rVert_{op}}{g_n},$$

so at fixed $\sigma$ the $(\alpha,\gamma)$ problem is exactly $\min\Phi=\min 2C/\gamma$. **$C$ alone is not the objective**: $C$ is increasing in $\gamma$, so minimising it drives $\gamma\to0$, $\rho\to0$ and $\lVert A''\rVert\to\infty$. *A record that asks for "the constant $C$" and nothing else is asking for a quantity that is minimised by making the estimate useless, and L151's frozen $\gamma=\tfrac12$ is what that request looks like when answered literally.*

**Two caveats the successor must carry.** (i) $\sigma$ does not decouple: the validity branch $\sigma\rho$ is increasing in $\gamma$ while $\Phi$ has an interior optimum in $\gamma$, so the honest problem is $\max_{\alpha,\gamma,\sigma}\min\{\text{branch}_2,\text{branch}_3\}$ over the kite, and $\gamma^*=d/2$ is the answer only for branch 2 in isolation. (ii) Optimality is claimed **within the family of circles centred at $\lambda_-$ and for this bookkeeping**; a contour hugging $\lambda_-$ non-circularly, or a bound that integrates $\lvert\zeta\rvert\lVert R_\zeta\rVert$ pointwise instead of taking two independent maxima, will move the number. *That is the point, this is an estimate being optimised, not a constant read off the geometry, which is the sentence [r456](REVIEW_r456.md) got right and L152 did not inherit.*

## What I could not break

- **$\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$** (F1), and the spectral data it rests on: $\lambda_+=\tfrac m{m-1}g_n$ from tracelessness against multiplicities $m^2$ and $m(m-1)$, recomputed cold.
- **$\lambda_+$ does not enter the numerator of [r456](REVIEW_r456.md)'s estimate.** L152 is right about this; it is wrong that this refutes [r457](REVIEW_r457.md), whose $\lambda_+$ sits in a different term of a different identity.
- **$0\notin\operatorname{spec}(W^*)$, and $\Gamma$ may enclose $0$** (F5), checked step by step.
- **[r441](REVIEW_r441.md)'s $M\le\tfrac32g_n=6\rho$ at $(\tfrac12,\tfrac14)$**, reproduced from the corrected formula: $d=\min(\tfrac12,D-\tfrac12)=\tfrac12$, so $C=\tfrac{\alpha(1+\alpha)}{d(d-\gamma)}=\tfrac{1.5}{0.25}=6$. The point is pre-kink, which is why [r456](REVIEW_r456.md)'s error is invisible there.
- **$\gamma=d/2$ for the second branch alone**, and $\gamma<1$ slack at the optimum for every $m\ge2$.

## What this audit did not check

[Lemma L149](../findings/second-order.md)'s chain and its first and third branches; [Lemma L148](../findings/second-order.md)'s vanishing of the defect on the margin summand, which means the whole constant is priced for the mixed directions where nobody has computed $\lVert H\rVert_{op}$; [Lemma L141](../findings/second-order.md)'s $\lVert A'\rVert\le\tfrac12$; whether $\lVert A''\rVert$ is **saturated** at $O(M/\rho^2)$, which is [r443](REVIEW_r443.md)'s open item and would make all of this an upper bound on an upper bound; and [r456](REVIEW_r456.md) F5's finding that $2\langle A''',A\rangle$ does not vanish off $t=0$, which multiplies everything here by a further $8$ and is untouched.

## What to change

1. **Restate L152's headline.** The numerator identity $\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$ is CONFIRMED; the constant is $C=\frac{\alpha(1+\alpha)}{d(d-\gamma)}$ with $d=\min(\alpha,D-\alpha)$, $D=\frac{2m-1}{m-1}$, reducing to $\frac{1+\alpha}{\alpha-\gamma}$ **only on $\alpha\le D/2$**. The record's current formula is quoted outside its range in the very sentence that names an optimum.
2. **Withdraw the refutation of [r457](REVIEW_r457.md) and replace it with a sharpness comparison.** Its $\tfrac m{m-1}$ is $\lVert W^*\rVert_{op}/g_n$ in the projection-identity decomposition, not a bound on $\lvert\zeta\rvert$. Both estimates are valid; [r456](REVIEW_r456.md)'s is sharper for $\alpha<\tfrac m{m-1}$, hence at the optimum, by the factor $\frac{1+\alpha}{\alpha+m/(m-1)}$.
3. **Delete "three independent computations meet at one value".** [r456](REVIEW_r456.md)'s formula is [r441](REVIEW_r441.md)'s bookkeeping generalised, by [r456](REVIEW_r456.md)'s own statement; the $6$ is a consistency check on the generalisation.
4. **Settle the admissible range as: $0<\alpha<D$, $\gamma<\min(\alpha,D-\alpha)$, $\gamma<1$.** Record that $\alpha<1$ is **not** a constraint ($0\notin\operatorname{spec}(W^*)$ and every step of the chain was checked) and that the real content of "no eigenvalue crosses $0$" is $\gamma<1$, which is slack at the optimum.
5. **Record the optimum**: $\alpha^*=\frac{2m-1}{2(m-1)}$, $\gamma^*=\frac{2m-1}{4(m-1)}$, attained, pinned by the resolvent kink at equidistance from $\lambda_-$ and $\lambda_+$; $C^*=2(1+\alpha^*)/\alpha^*$, $\Phi^*=8(1+\alpha^*)/\alpha^{*2}$; gain $6\alpha^{*2}/(1+\alpha^*)$, i.e. $3.46$ at $n=12$ and $\to3$. Credit [r441](REVIEW_r441.md), which named this contour and was never priced.
6. **Withdraw [r456](REVIEW_r456.md)'s $(\tfrac43,\tfrac23)$ and its factor $4.8$** from the agreed list above L152. At $n=12$ it is worse than the baseline it improves on, and its constant diverges as $m\to\infty$.
7. **State the objective wherever an optimum is quoted**: $\lVert A''\rVert\le\frac{2C(\alpha,\gamma)}{(1-\sigma)^2\gamma}\cdot\frac{\lVert H\rVert_{op}}{g_n}$, minimise $C/\gamma$; and flag that $\sigma$ and the validity branch make the honest problem a three-parameter max-min over the kite.
