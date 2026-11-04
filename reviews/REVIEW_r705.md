# Review r705, the contour constant $C(\alpha,\gamma)$: the numerator is right, the formula is not, and the optimum is interior

*Reviewer r705, 2026-09-05, cold adversarial brief. Targets: **C1**, [Lemma L152](../findings/second-order.md)'s "the numerator is $1+\alpha$, the disagreement resolves for [r456](REVIEW_r456.md)", and **C2**, the admissible range of $\alpha$, recorded three incompatible ways. Read in full: [second-order.md](../findings/second-order.md) §"The contour constant for the balanced-orbit defect" and Lemma L152, [Lemma L145](../findings/second-order.md) step 1, [REVIEW_r441.md](REVIEW_r441.md), [REVIEW_r456.md](REVIEW_r456.md), [REVIEW_r457.md](REVIEW_r457.md). **Analysis only** ([analysis-only.md](../.claude/rules/analysis-only.md)): every derivation below is by hand. One screen is reported, on closed forms derived here, and it is evidence for nothing. Working: [agent_logs/r705.log](../agent_logs/r705.log).*

## Verdicts

| claim | verdict | one line |
|---|---|---|
| **C1**, numerator is $\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$, hence $C=\tfrac{1+\alpha}{\alpha-\gamma}$, hence [r456](REVIEW_r456.md) is right and [r457](REVIEW_r457.md) is wrong | **REFUTED as stated; a restricted core survives** | The numerator identity is correct and elementary (F1). The *hence* is not: $\tfrac{1+\alpha}{\alpha-\gamma}$ holds only on $\alpha\le\tfrac{2m-1}{2(m-1)}$, and above it the true constant is larger, $17.9$ against the recorded $3.5$ at $(\tfrac43,\tfrac23)$, $m=6$ (F2). The refutation of [r457](REVIEW_r457.md) is a straw man: [r457](REVIEW_r457.md)'s $\tfrac m{m-1}$ is $\lVert W^*\rVert_{op}/g_n$ in a **different decomposition** and is never offered as a bound on $\lvert\zeta\rvert$ (F3) |
| **C2** (which of $\alpha<1$ and $\alpha<\tfrac{2m-1}{m-1}$ binds | **REFUTED), neither does** | $\alpha<1$ is not a constraint at all (F4); $\alpha+\gamma<\tfrac{2m-1}{m-1}$ is a real constraint but is **slack at the optimum**. What decides the optimisation is a third thing the record never names: the switch of the nearest spectral point at $\alpha=\tfrac{2m-1}{2(m-1)}$, which puts the optimum **interior and attained** (F5) |
| the optimum | **$\alpha^*=\tfrac{2m-1}{2(m-1)}$, $\gamma^*=\tfrac{2m-1}{4(m-1)}$** | $\alpha^*g_n=\tfrac12\lvert\lambda_+-\lambda_-\rvert$, exactly [r441](REVIEW_r441.md) recommendation 5, which [r456](REVIEW_r456.md) quoted and set aside as "within four per cent". It was not four per cent off; it was the answer (F5) |
| the objective, never stated in the record | **$J(\alpha,\gamma)=C(\alpha,\gamma)/\gamma$** | From $\sup_{\lvert t\rvert\le\sigma\rho}\lVert A''\rVert\le 2M/((1-\sigma)\rho)^2$; $\sigma$ enters as a separable factor and does not move $(\alpha^*,\gamma^*)$ (F6) |
| $\gamma=\alpha/2$ | **CONFIRMED at the optimum, for the wrong reason elsewhere** | The rule is $\gamma=d/2$ with $d$ the distance from $\Gamma$ to the spectrum, *half the distance to the nearest eigenvalue*, which equals half the contour radius only while $\alpha\le\tfrac{2m-1}{2(m-1)}$ (F6) |
| [r441](REVIEW_r441.md)'s $M\le6\rho$ reproduces | **CONFIRMED, and it is not three computations** | $6$ comes out of both the recorded formula and the corrected one, because $(\tfrac12,\tfrac14)$ sits inside the regime where they coincide. So the one check the record leans on is **structurally blind to the defect of F2**; and [r456](REVIEW_r456.md) states it inherited [r441](REVIEW_r441.md)'s bookkeeping, so "three independent computations" is one computation at one point (F7) |

## Notation, fixed once

Write $D=\dfrac{\lambda_+-\lambda_-}{g_n}=1+\dfrac m{m-1}=\dfrac{2m-1}{m-1}$, so $D\in(2,3]$ and $D=\tfrac{11}5$ at $m=6$, $n=12$. Let $\Gamma=\{\lvert\zeta-\lambda_-\rvert=\alpha g_n\}$ and $\rho\lVert H\rVert_{op}=\gamma g_n$, with $\lVert H\rVert_F=1$ (the normalisation [r441](REVIEW_r441.md)'s bookkeeping spends once, and the one under which $C$ is dimensionless; L152 states neither).

**The spectrum is exactly two points.** [Lemma L145](../findings/second-order.md) step 1: $W^*$ is a multiple of $R-\tfrac{m-1}{2m-1}\mathrm{id}$, positive $\propto\tfrac m{2m-1}$ with multiplicity $m(m-1)$ on $\Lambda^2V_1\oplus\Lambda^2V_2$, negative $\propto-\tfrac{m-1}{2m-1}$ with multiplicity $m^2$ on the mixed planes, and $m(m-1)m-m^2(m-1)=0$. I rebuilt the scale independently: $\sum\lambda^2=1$ gives $g_n^2=\tfrac{m-1}{m^2(2m-1)}=\tfrac{2(n-2)}{n^2(n-1)}$, agreeing with [r457](REVIEW_r457.md) R2 and the record's closed form. **So $\mathop{\mathrm{spec}}(W^*)=\{\lambda_-,\lambda_+\}$ with no third point and no kernel**, and $g_n=\lvert\lambda_-\rvert=\mathop{\mathrm{dist}}(0,\mathop{\mathrm{spec}}W^*)$, the two readings of "the gap" the brief asks about coincide here, so nothing turns on which is the definition.

## F1, the numerator identity is right, and it needs less than L152 claims

For any centre $c\in\mathbb C$ and radius $r$, $\max_{\lvert\zeta-c\rvert=r}\lvert\zeta\rvert=\lvert c\rvert+r$ by the triangle inequality, attained at $\zeta=c(1+r/\lvert c\rvert)$. With $c=\lambda_-$, $r=\alpha g_n$ this is $(1+\alpha)g_n$. **This uses neither the reality of $\lambda_-$ nor the symmetry of $W$**, so the brief's worry does not land; symmetry is needed one step later, for the resolvent identity of F2. **CONFIRMED.**

## F2, the recorded $C$ silently assumes $\lambda_-$ is the spectral point nearest $\Gamma$, and that fails on exactly the region the record then optimises over

$W^*$ is symmetric, so $\lVert(W^*-\zeta)^{-1}\rVert=1/\mathop{\mathrm{dist}}(\zeta,\mathop{\mathrm{spec}}W^*)$ **exactly**, and

$$\max_{\zeta\in\Gamma}\lVert(W^*-\zeta)^{-1}\rVert=\frac1{g_n\,d(\alpha)},\qquad d(\alpha)=\min\!\big(\alpha,\;D-\alpha\big),$$

because every $\zeta\in\Gamma$ is at distance exactly $\alpha g_n$ from $\lambda_-$, while $\min_{\zeta\in\Gamma}\lvert\zeta-\lambda_+\rvert=(D-\alpha)g_n$. **$\lambda_-$ is the nearer point precisely when $\alpha\le D/2$.**

Both [r456](REVIEW_r456.md) and L152 write $\lVert R_0\rVert\le1/(\alpha g_n)$ unconditionally. Redoing the Neumann bookkeeping with the correct $d$, term $k$ at most $\tfrac{\lvert\Gamma\rvert}{2\pi}\max_\Gamma\lvert\zeta\rvert\,\lVert R_0\rVert^{k+1}\rho^k\lVert H\rVert_F\lVert H\rVert_{op}^{k-1}=\alpha(1+\alpha)\rho\,\gamma^{k-1}/d^{k+1}$, summed over $k\ge1$ with the $k=0$ term killed by $\mathrm{Alt}(W^*_-)=0$,

$$\boxed{\;C_{\text{Riesz}}(\alpha,\gamma)=\frac{\alpha(1+\alpha)}{d(\alpha)\,\big(d(\alpha)-\gamma\big)},\qquad d(\alpha)=\min(\alpha,D-\alpha).\;}$$

On $\alpha\le D/2$ this collapses to $\tfrac{1+\alpha}{\alpha-\gamma}$, **the contour length's $\alpha$ cancels the resolvent's $1/\alpha$**, which answers the brief's "is a factor $\alpha$ missing" with *no, while $d=\alpha$*. Above $D/2$ the cancellation fails and the surviving $\alpha/d>1$ is the whole correction.

**What it costs at the record's own numbers**, $m=6$:

| $(\alpha,\gamma)$ | $d$ | recorded $\tfrac{1+\alpha}{\alpha-\gamma}$ | corrected $C_{\text{Riesz}}$ |
|---|---|---|---|
| $(\tfrac12,\tfrac14)$ | $\tfrac12$ | $6$ | $6$ |
| $(\tfrac{11}{10},\tfrac{11}{20})$ | $\tfrac{11}{10}$ | $3.818$ | $3.818$ |
| $(\tfrac43,\tfrac23)$, [r456](REVIEW_r456.md)'s optimum | $\tfrac{13}{15}$ | $3.5$ | $\mathbf{17.95}$ |

So the recorded formula understates the constant by a factor $5.1$ at the point [r456](REVIEW_r456.md) recommends and L152 forwards. **The claim "$C(\alpha,\gamma)=\tfrac{1+\alpha}{\alpha-\gamma}$", written without a range, is false.**

## F3, L152 refutes a claim [r457](REVIEW_r457.md) does not make

L152 argues: the numerator is $\max_\Gamma\lvert\zeta\rvert$; $\tfrac m{m-1}=\lambda_+/g_n$ is an eigenvalue $\Gamma$ does not enclose; therefore it "never bounds $\lvert\zeta\rvert$ on $\Gamma$"; therefore [r457](REVIEW_r457.md) is wrong.

**[r457](REVIEW_r457.md) never bounds $\lvert\zeta\rvert$.** It does not estimate $\oint\zeta R\,d\zeta$ at all. It uses [r447](REVIEW_r447.md) F1's decomposition

$$A(z)=\mathrm{Alt}\big(-\Pi(z)\,(W(z)-W^*)\;-\;(\Pi(z)-\Pi(0))\,W^*\big),$$

bounds $\lVert\Pi(z)\rVert_{op}\le\tfrac{\lvert\Gamma\rvert}{2\pi}\lVert R\rVert=\tfrac\alpha{\alpha-\gamma}$ and, via the second resolvent identity $\Pi(z)-\Pi(0)=-\tfrac1{2\pi i}\oint R(z)\,zH\,R_0$, $\lVert\Pi(z)-\Pi(0)\rVert_F\le\tfrac\rho{(\alpha-\gamma)g_n}$. The $\tfrac m{m-1}$ then enters as $\lVert W^*\rVert_{op}/g_n$ **multiplying the second term**, which is exactly where the operator norm of the base point belongs. I checked each step and it is sound on [r457](REVIEW_r457.md)'s own stated range $\alpha\in(0,1)$, where $1<D/2$ so its resolvent bound is valid, **[r457](REVIEW_r457.md) does not commit F2's error, because it never left the safe region.**

So these are **two different valid upper bounds on the same $M$**, not two derivations of one numerator, and the record's framing of a "disagreement to settle" is itself the error. Which is tighter is a comparison, not a refutation:

$$C_{457}(\alpha,\gamma)=\frac{\alpha\big(d+\tfrac m{m-1}\big)}{d(d-\gamma)}\quad\text{(corrected the same way)},$$

so $C_{\text{Riesz}}<C_{457}\iff 1+\alpha<d+\tfrac m{m-1}$, i.e. $\alpha<\tfrac m{m-1}$ on $\alpha\le D/2$, **[r456](REVIEW_r456.md)'s bound is the better one everywhere the optimisation actually goes**, and [r457](REVIEW_r457.md)'s becomes the better one for $\alpha>\tfrac m{m-1}$ ($15.90$ against $17.95$ at $(\tfrac43,\tfrac23)$). The honest record entry is $C=\min(C_{\text{Riesz}},C_{457})$, with a note that the Riesz route wins at the optimum.

**And the headline number is inflated.** "Worth $20\%$ at $n=12$" is the ratio $\tfrac{\alpha+m/(m-1)}{1+\alpha}$ at $\alpha\to0$. At $(\tfrac12,\tfrac14)$ it is $13.3\%$; at the true optimum $\alpha=1.1$ it is $9.5\%$. The gap is smallest exactly where it would be used.

## F4, $\alpha<1$ is not a constraint, and L152 contradicts itself inside three paragraphs

Two paragraphs apart, the same lemma says *"$0\notin\mathop{\mathrm{spec}}(W^*)$ … so separating the negative part from $0$ constrains nothing; $\alpha$ may exceed $1$"* and *"$\alpha<1$ keeps $0$ outside … the first binding"*. The second is wrong, and I checked every step of the chain the brief asks about:

- **The integrand.** $\zeta(W-\zeta)^{-1}$ is holomorphic on and near $\Gamma$ whenever $\mathop{\mathrm{spec}}\cap\Gamma=\varnothing$. Regularity at $\zeta=0$ is not even needed ($0$ is an interior point of the disc, not a point of the contour) and in any case $\zeta(W-\zeta)^{-1}\to0$ there.
- **The identification of the projection.** $\Pi=-\tfrac1{2\pi i}\oint_\Gamma(W-\zeta)^{-1}d\zeta$ is the spectral projection onto the eigenvalues *enclosed*. Enclosing $0$, which is not an eigenvalue, adds nothing to that set, so $\Pi$ and $W_-=W\Pi$ are unchanged.
- **The Neumann estimate.** Needs only $\gamma<d(\alpha)$. No role for $0$.
- **The one place a "$1$" is genuinely needed, and it is a bound on $\gamma$, not $\alpha$.** For $\Pi(t)W(t)$ to *be* the negative part on the real segment, every eigenvalue enclosed by $\Gamma$ must still be negative. Bauer–Fike at condition number $1$ ([r441](REVIEW_r441.md)) moves eigenvalues by at most $\rho\lVert H\rVert_{op}=\gamma g_n$, so the descendants of $\lambda_-$ stay in $[-(1+\gamma)g_n,-(1-\gamma)g_n]$ and remain negative **iff $\gamma<1$**. [r456](REVIEW_r456.md) has this; L152 does not carry it. It is slack at the optimum ($\gamma^*\le\tfrac34$ for every $m\ge2$).

So the constraint set is $\;\gamma<\min\!\big(\alpha,\;D-\alpha,\;1\big)$, and $\alpha$ alone is bounded only by $\alpha<D$.

## F5, what actually binds, and the optimum

Neither candidate. With $J=C/\gamma$ (F6) and $C=C_{\text{Riesz}}$, minimising over $\gamma$ first: $\gamma(d-\gamma)$ is maximal at $\gamma=d/2$, giving

$$J^*(\alpha)=\frac{4\alpha(1+\alpha)}{d(\alpha)^3}=\begin{cases}\dfrac{4(1+\alpha)}{\alpha^2}, & \alpha\le D/2 \quad\text{strictly decreasing},\\[2mm] \dfrac{4\alpha(1+\alpha)}{(D-\alpha)^3}, & \alpha\ge D/2\quad\text{strictly increasing}.\end{cases}$$

Both branches are strictly monotone toward $\alpha=D/2$, so the minimum is **unique, interior and attained** at the point where $\Gamma$ is equidistant from $\lambda_-$ and $\lambda_+$:

$$\boxed{\;\alpha^*=\frac D2=\frac{2m-1}{2(m-1)},\qquad \gamma^*=\frac D4=\frac{2m-1}{4(m-1)},\qquad C^*=\frac{2(1+\alpha^*)}{\alpha^*}=2+\frac{4(m-1)}{2m-1},\qquad J^*=\frac{8(2+D)}{D^2}.\;}$$

Substituting $C_{457}$ where it is the better bound ($\alpha>\tfrac m{m-1}>D/2$) does not move this: that region is already on the increasing branch. At $m=6$, $n=12$: $\alpha^*=\tfrac{11}{10}$, $\gamma^*=\tfrac{11}{20}$, $C^*=\tfrac{42}{11}=3.818$, $J^*=6.942$.

**The three recorded readings, each disposed of.**

| reading | status |
|---|---|
| [r457](REVIEW_r457.md): supremum at $\alpha\to1$, **unattained** | **wrong, and right by accident.** $\alpha^*=\tfrac{2m-1}{2m-2}>1$ for every $m$, and the optimum *is* attained. $\alpha^*\to1$ as $m\to\infty$, which is why [r457](REVIEW_r457.md)'s number looks right, but its reason ($0$ must stay outside) is not the reason, and at $n=12$ its answer is $9\%$ low |
| the agreed list: **$\alpha$ may exceed $1$** | **correct, and vindicated**, the optimum does exceed $1$, by $\tfrac1{2(m-1)}$ |
| [r456](REVIEW_r456.md): optimum near $(\tfrac43,\tfrac23)$ | **wrong.** $\tfrac43>D/2=1.1$ at every $m\ge3$, so it sits in the region where its own formula's resolvent bound fails. Corrected, $J(\tfrac43,\tfrac23)=23.85$ against $J(\tfrac12,\tfrac14)=24$, **[r456](REVIEW_r456.md)'s recommended replacement is no better than the frozen point it was recommended to replace** |

**And "freezing $\alpha=\tfrac12$ costs about a factor $4.8$" is wrong too.** The true cost is $J(\tfrac12,\tfrac14)/J^*=24/6.942=\mathbf{3.46}$ at $m=6$. The $4.8$ was computed against a point whose constant is understated fivefold.

**[r441](REVIEW_r441.md) had it.** Its recommendation reads *"needs either a smaller $\rho$ or a contour at radius $\approx(\lambda_+-\lambda_-)/2$"*, and $\alpha^*g_n$ **is** $(\lambda_+-\lambda_-)/2$, exactly rather than approximately. [r456](REVIEW_r456.md) evaluated that as $\alpha\approx1.12$ and recorded it as "within four per cent of the optimum I get independently", treating the true optimum as the near miss.

> **Screen** (self-constructed, seconds; evidence for nothing, and it can fail, it evaluates the closed forms derived above, so an algebra slip shows as a mismatch against the hand values $6$ at $(\tfrac12,\tfrac14)$ and $6.8$ for $C_{457}$ there). Minimising $\min(C_{\text{Riesz}},C_{457})/\gamma$ on a grid over $\alpha\in(0,D)$, $\gamma<\min(d,1)$ returns, for $m=2,3,6,10,1000$: $(\alpha,\gamma,J)=(1.500,0.750,4.445)$, $(1.250,0.625,5.761)$, $(1.100,0.550,6.944)$, $(1.056,0.528,7.380)$, $(1.000,0.500,7.997)$, against the closed form's $(D/2,D/4,8(2+D)/D^2)=(1.5,0.75,4.444)$, $(1.25,0.625,5.760)$, $(1.1,0.55,6.942)$, $(1.056,0.528,7.380)$, $(1.0005,0.5003,7.994)$.

## F6, the objective, which the record never states

The chain needs $\sup_{\lvert t\rvert\le\sigma\rho}\lVert A''(t)\rVert$, and Cauchy on the shrunk disc gives $2M/((1-\sigma)\rho)^2$ ([r456](REVIEW_r456.md) F4). With $M\le C\rho$ and $1/\rho=\lVert H\rVert_{op}/(\gamma g_n)$,

$$\sup_{\lvert t\rvert\le\sigma\rho}\lVert A''\rVert\;\le\;\underbrace{\frac2{(1-\sigma)^2}}_{\text{$\sigma$ only}}\cdot\underbrace{\frac{C(\alpha,\gamma)}\gamma}_{\displaystyle J(\alpha,\gamma)}\cdot\frac{\lVert H\rVert_{op}}{g_n}.$$

**$\sigma$ factorises out**, so the joint $(\alpha,\gamma,\sigma)$ optimisation [r456](REVIEW_r456.md) calls for splits: $(\alpha^*,\gamma^*)$ above are $\sigma$-independent, and $\sigma$ is settled separately against the validity branch it also defines. That is a genuine simplification of the debt, and it is available only once the objective is written down. [r457](REVIEW_r457.md)'s "maximise $\sqrt c\,\rho/C$" and [r456](REVIEW_r456.md)'s "minimise $2C/\rho$" are the same objective in different dress; neither review nor L152 says so.

**On $\gamma=\alpha/2$.** The stationarity is in $\gamma(d-\gamma)$, so the rule is $\gamma=d/2$: *half the distance from the contour to the nearest eigenvalue.* It reads as "half the contour radius" only on $\alpha\le D/2$. It does hold at $\alpha^*$, where $d=\alpha$, so the record's slogan survives at the optimum and is a coincidence of that point.

## F7, the one check both formulas passed cannot see the defect

$(\alpha,\gamma)=(\tfrac12,\tfrac14)$ has $d=\min(\tfrac12,\tfrac{17}{10})=\tfrac12=\alpha$, so it lies **inside** the regime where $\tfrac{1+\alpha}{\alpha-\gamma}$ and the corrected $\tfrac{\alpha(1+\alpha)}{d(d-\gamma)}$ are identically equal. Both return $6$; [r457](REVIEW_r457.md)'s returns $6.8$ at $m=6$. So:

- the check **does** discriminate [r456](REVIEW_r456.md)'s numerator from [r457](REVIEW_r457.md)'s, and C1 is right that it favours $1+\alpha$, though F3 shows that is a comparison of two valid bounds rather than a refutation;
- the check is **structurally incapable** of detecting F2, and L152 leans on it while extrapolating the formula to $\alpha=\tfrac43$, well outside where the check has any force;
- **"three independent computations meet at one value" is not true.** [r456](REVIEW_r456.md)'s scope note says it inherited [r441](REVIEW_r441.md)'s Neumann bookkeeping and re-derived only the $(\alpha,\gamma)$-generalisation. [r441](REVIEW_r441.md)'s $\max_{w}\lvert w\rvert\le\tfrac32g_n$ *is* $(1+\alpha)g_n$ at $\alpha=\tfrac12$, and its "term $k\le\tfrac32g_n2^{-k}$" is $(1+\alpha)g_n(\gamma/\alpha)^k$ at $(\tfrac12,\tfrac14)$. **It is one computation evaluated at its own point.** The numerator identity of F1 is the only genuinely independent support, and it is enough on its own.

## What survives untouched

- **$\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$** (F1), and the fact that $\lambda_+$ does not enter the *Riesz-integral* numerator.
- **$M=O(\rho)$ with finite $C$ on the complex circle**, which four reviewers have and nothing here disturbs.
- **$\mathop{\mathrm{spec}}(W^*)=\{\lambda_-,\lambda_+\}$, $\lambda_+=\tfrac m{m-1}g_n$, $g_n^2=\tfrac{2(n-2)}{n^2(n-1)}$**, rebuilt cold from multiplicities, trace and norm.
- **$\gamma=\alpha/2$ at the optimum**, and $\alpha=\gamma$ inadmissible.

## What a successor writes into the record

1. **Restate L152's consequence with its range**: $C_{\text{Riesz}}(\alpha,\gamma)=\dfrac{\alpha(1+\alpha)}{d(d-\gamma)}$, $d=\min(\alpha,\tfrac{2m-1}{m-1}-\alpha)$, which is $\tfrac{1+\alpha}{\alpha-\gamma}$ **only for $\alpha\le\tfrac{2m-1}{2(m-1)}$**. Delete the unqualified form.
2. **Withdraw the refutation of [r457](REVIEW_r457.md)** and replace the "live disagreement" framing with two routes and a comparison: $C=\min(C_{\text{Riesz}},C_{457})$, Riesz tighter for $\alpha<\tfrac m{m-1}$, hence at the optimum. Correct "worth $20\%$ at $n=12$" to $9.5\%$ at the optimum.
3. **Record the objective** $J=C/\gamma$ and that $\sigma$ separates, so $(\alpha^*,\gamma^*)$ are $\sigma$-free.
4. **Record the optimum** $\alpha^*=\tfrac{2m-1}{2(m-1)}$, $\gamma^*=\tfrac{2m-1}{4(m-1)}$, $C^*=2+\tfrac{4(m-1)}{2m-1}$, at $n=12$, $(1.1,0.55)$ and $C^*=\tfrac{42}{11}$, with the constraint that binds named as the equidistance switch, and credit it to [r441](REVIEW_r441.md) recommendation 5.
5. **Retract "the optimum is near $(\tfrac43,\tfrac23)$" and the factor $4.8$.** The corrected cost of freezing $\alpha=\tfrac12$ is $3.46$, and $(\tfrac43,\tfrac23)$ buys nothing over $(\tfrac12,\tfrac14)$.
6. **Carry $\gamma<1$** into the admissibility line, as the condition that the enclosed spectrum stays negative on the real segment. It is slack at the optimum but it is the only place a "$1$" belongs.

## What I did not check

The [r447](REVIEW_r447.md) F1 decomposition is taken as given rather than re-derived from $W_-=\Pi W$; I checked only that [r457](REVIEW_r457.md)'s estimates of its two terms are correct given it. Whether $\lVert A''\rVert$ is *saturated* at $O(M/\rho^2)$, [r443](REVIEW_r443.md)'s open item (iii), is untouched, so the optimum above is the optimum of a bound. Optimality is claimed only within the circles-about-$\lambda_-$ family and only for these two bookkeepings; an ellipse or a two-component contour is not considered. The downstream question (whether the constant chain closes with a positive tube radius at $\beta=0$), is not settled here.

*r705, filed complete. Working in [agent_logs/r705.log](../agent_logs/r705.log).*
