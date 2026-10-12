# VERIFY v31, candidate C6 against [Lemma L156](../findings/second-order.md#lemma-l156-the-contour-constant-corrected-and-its-optimum-attained-at-the-equidistant-contour): that the $(\alpha,\gamma)$ half does **not** separate from $\sigma$, and that $\gamma^*=D/4$ fails to maximise the reach

*Adjudicator v31, 2026-09-05. **No numerical work was done and no script was run; every value below is an exact hand evaluation of a rational or closed-form quantity**, and the two decimal figures quoted from the record are reproduced from exact surds. Log: [agent_logs/verify-L156-C6-v31.log](../agent_logs/verify-L156-C6-v31.log). Decided from [L156](../findings/second-order.md#lemma-l156-the-contour-constant-corrected-and-its-optimum-attained-at-the-equidistant-contour) and [L157](../findings/second-order.md#lemma-l157-the-reach-parameter-is-determined-by-a-fixed-point-not-chosen-etatfrac2t1-sqrt4t12t) alone.*

**UPHELD.** The framing sentence *"**The $(\alpha,\gamma)$ half separates from $\sigma$**, so that half is the one-parameter problem L156 solves in closed form"* ([findings/second-order.md:1439](../findings/second-order.md)) is false as written. $\sigma=\eta^*(t)$ and $t$ is a function of $C(\alpha,\gamma)$, so $\sigma$ is a function of $(\alpha,\gamma)$; the quantity the chain maximises is $\gamma\,\eta^*$, not $1/J$; and at the $\gamma$ the entry's own proof selects, $\partial_\gamma(\gamma\eta^*)=16t^2/\big(\sqrt{1+4t}\,(1+\sqrt{1+4t})^3\big)>0$ strictly, for every $t>0$. The failure is exact but second order in $t$: the location of the true optimum moves at $O(t)$ and the value at $O(t^2)$. The $\alpha$ half separates exactly; the $\gamma$ half does not.

## Notation, taken from the two entries

[L156](../findings/second-order.md#lemma-l156-the-contour-constant-corrected-and-its-optimum-attained-at-the-equidistant-contour) gives $C(\alpha,\gamma)=\dfrac{\alpha(1+\alpha)}{d(d-\gamma)}$ with $d=\min(\alpha,D-\alpha)$, the disc radius $\rho=\gamma g_n/\lVert H\rVert_{op}$, and $J=C/\gamma$. [L157](../findings/second-order.md#lemma-l157-the-reach-parameter-is-determined-by-a-fixed-point-not-chosen-etatfrac2t1-sqrt4t12t) gives $\eta=r/\rho$, $t=\lambda\sqrt{c_p+w^2}/(2J\gamma)$, and $\eta^*(t)=\dfrac{2t+1-\sqrt{4t+1}}{2t}$ as the crossing root. Write $\Lambda:=\lambda\sqrt{c_p+w^2}$, a constant of the $w$-block that carries no $\alpha$ and no $\gamma$; and $s:=\sqrt{1+4t}$. The identification $\sigma=\eta^*(t)$ is the record's own: [L156](../findings/second-order.md#lemma-l156-the-contour-constant-corrected-and-its-optimum-attained-at-the-equidistant-contour)'s bullet states the branch-2/branch-3 crossing as $t(1-\sigma)^2=\sigma$, which is exactly the fixed point [L157](../findings/second-order.md#lemma-l157-the-reach-parameter-is-determined-by-a-fixed-point-not-chosen-etatfrac2t1-sqrt4t12t) solves.

## 1. What $t$ depends on

**$t$ contains $J$ and $\gamma$ only in the product $J\gamma$, which is $C$. It is therefore a function of $C$ alone, and through $C$ a function of both $\alpha$ and $\gamma$, of neither $\gamma$ alone nor of any variable disjoint from the L156 pair.**

$$t=\frac{\lambda\sqrt{c_p+w^2}}{2J\gamma}=\frac{\Lambda}{2\,(C/\gamma)\,\gamma}=\frac{\Lambda}{2\,C(\alpha,\gamma)} .$$

On the branch $\alpha\le D/2$, where $d=\alpha$ and $C=(1+\alpha)/(\alpha-\gamma)$, this is

$$t(\alpha,\gamma)=\frac{\Lambda\,(\alpha-\gamma)}{2(1+\alpha)}=\mu\,(\alpha-\gamma),\qquad \mu:=\frac{\Lambda}{2(1+\alpha)}>0,$$

so $t$ is a strictly **decreasing** affine function of $\gamma$ at fixed $\alpha$, and strictly positive for every admissible $\gamma<d$ because $c_p=\kappa/n>0$. Hence $\sigma=\eta^*(t)$ is a function of $(\alpha,\gamma)$, which is the candidate's premise and it holds.

**The closed form of $\eta^*$, which the rest of the adjudication uses.** Put $s=\sqrt{4t+1}\ge1$, so $t=(s^2-1)/4$. Then the numerator of [L157](../findings/second-order.md#lemma-l157-the-reach-parameter-is-determined-by-a-fixed-point-not-chosen-etatfrac2t1-sqrt4t12t)'s root is $\tfrac{s^2-1}{2}+1-s=\tfrac{(s-1)^2}{2}$ and its denominator is $2t=\tfrac{s^2-1}{2}$, so

$$\eta^*=\frac{(s-1)^2}{s^2-1}=\frac{s-1}{s+1},\qquad 1-\eta^*=\frac{2}{s+1}.$$

This satisfies the fixed point exactly: $t(1-\eta^*)^2=\frac{s^2-1}{4}\cdot\frac{4}{(s+1)^2}=\frac{s-1}{s+1}=\eta^*$. It also reproduces the record's own check. At $\sup_w t=\tfrac18$, $s=\sqrt{3/2}=\tfrac{\sqrt6}{2}$, so $\eta^*=\frac{\sqrt6-2}{\sqrt6+2}=5-2\sqrt6$ and $(1-\eta^*)^2=(2\sqrt6-4)^2=40-16\sqrt6=0.80816\ldots$, [L157](../findings/second-order.md#lemma-l157-the-reach-parameter-is-determined-by-a-fixed-point-not-chosen-etatfrac2t1-sqrt4t12t)'s stated $0.808$, exactly.

## 2. What the chain is actually maximising

**The radius is $r=\eta^*(t)\,\rho$, i.e. $\gamma\,\eta^*(t)$ in units of $g_n/\lVert H\rVert_{op}$; equivalently $\tfrac{\Lambda}{2}\cdot(1-\eta^*)^2/J$. Minimising $J$ maximises it only if $(1-\eta^*)^2$ is held fixed, and it is not.**

[L157](../findings/second-order.md#lemma-l157-the-reach-parameter-is-determined-by-a-fixed-point-not-chosen-etatfrac2t1-sqrt4t12t) fixes $\eta=r/\rho$, so with [L156](../findings/second-order.md#lemma-l156-the-contour-constant-corrected-and-its-optimum-attained-at-the-equidistant-contour)'s $\rho=\gamma g_n/\lVert H\rVert_{op}$ the reach is $r=\eta^*\gamma\cdot g_n/\lVert H\rVert_{op}$. Define

$$F(\gamma):=\gamma\,\eta^*\big(t(\gamma)\big).$$

Using the crossing identity $\eta^*=t(1-\eta^*)^2$ and $t=\Lambda/(2J\gamma)$,

$$F=\gamma\,t\,(1-\eta^*)^2=\gamma\cdot\frac{\Lambda}{2J\gamma}\cdot(1-\eta^*)^2=\frac{\Lambda}{2}\cdot\frac{(1-\eta^*)^2}{J}.$$

The same objective arrives by the entry's own stated route. [findings/second-order.md:1439](../findings/second-order.md) derives $J$ from $\sup\lVert A''\rVert\le 2M/((1-\sigma)\rho)^2$; with $M\le C\rho$ and $\rho=\gamma g_n/\lVert H\rVert_{op}$ that bound is

$$\sup\lVert A''\rVert\;\le\;\frac{2C\rho}{(1-\sigma)^2\rho^2}=\frac{2C}{(1-\sigma)^2\rho}=\frac{2\lVert H\rVert_{op}}{g_n}\cdot\frac{J}{(1-\sigma)^2},$$

so the quantity to be minimised is $J/(1-\sigma)^2$ and never $J$. The $\sigma$ the sentence says separates off stands multiplicatively **inside** the objective the same sentence writes down.

In the form $F=\mu\,P\,Q$ with

$$P(\gamma):=\gamma(\alpha-\gamma)=\frac{1+\alpha}{J},\qquad Q(\gamma):=(1-\eta^*)^2=\frac{4}{(s+1)^2},$$

minimising $J$ maximises $P$ alone. That is the whole of [L156](../findings/second-order.md#lemma-l156-the-contour-constant-corrected-and-its-optimum-attained-at-the-equidistant-contour)'s $\gamma$ step (*"Minimising $J=C/\gamma$ over $\gamma$ maximises $\gamma(d-\gamma)$, so $\gamma=d/2$"*) and it discards the factor $Q$, which is not constant in $\gamma$.

## 3. The sign at $\gamma=d/2$, derived

**Strictly positive, for every $t>0$.** The radius is strictly increasing in $\gamma$ at the point the proof selects, so $\gamma=d/2$ is not the maximiser and the true optimum lies strictly to its right.

**Monotonicity of $\eta^*$ in $t$, derived rather than assumed.** From $\eta^*=(s-1)/(s+1)$, $\dfrac{d\eta^*}{ds}=\dfrac{2}{(s+1)^2}$, and from $s=\sqrt{1+4t}$, $\dfrac{ds}{dt}=\dfrac{2}{s}$. Hence

$$\frac{d\eta^*}{dt}=\frac{4}{s\,(s+1)^2}>0\qquad\text{for all }t>0 .$$

$\eta^*$ is therefore strictly increasing on $(0,\infty)$, from $\eta^*(0^+)=0$ to $\eta^*(\infty)=1$, which also confirms [L157](../findings/second-order.md#lemma-l157-the-reach-parameter-is-determined-by-a-fixed-point-not-chosen-etatfrac2t1-sqrt4t12t)'s "unique root in $(0,1)$" and the reciprocal root $(s+1)/(s-1)>1$ being spurious.

**The derivative of $Q$.** $Q=4/(s+1)^2$ gives $dQ/ds=-8/(s+1)^3$; and $s=\sqrt{1+4\mu(\alpha-\gamma)}$ gives $ds/d\gamma=-2\mu/s$. So

$$Q'(\gamma)=\frac{16\mu}{s\,(s+1)^3}>0 ,$$

the composition of two sign flips: raising $\gamma$ raises $C$, lowers $t$, lowers $\eta^*$, and so raises $(1-\eta^*)^2$.

**The derivative of the radius.** $F'=\mu(P'Q+PQ')$. At $\gamma=d/2=\alpha/2$ the entry's own step gives $P'=\alpha-2\gamma=0$ and $P=\alpha^2/4>0$, so

$$\partial_\gamma F\Big|_{\gamma=d/2}=\mu\cdot\frac{\alpha^2}{4}\cdot\frac{16\mu}{s(s+1)^3}=\frac{4\mu^2\alpha^2}{s\,(s+1)^3}>0 .$$

Since $t=\mu\alpha/2$ at $\gamma=\alpha/2$, i.e. $\mu\alpha=2t$, this is free of $\alpha$ altogether:

$$\boxed{\;\partial_\gamma\big(\gamma\,\eta^*\big)\Big|_{\gamma=d/2}=\frac{16\,t^2}{\sqrt{1+4t}\,\big(1+\sqrt{1+4t}\big)^{3}}\;>\;0\quad\text{for every }t>0. \;}$$

It vanishes only in the limit $t\to0$, i.e. only where branch 2's reach vanishes with it. At $t=\tfrac18$ the exact value is $\dfrac{1/4}{\sqrt{3/2}\,(1+\sqrt{3/2})^3}$, and the relative rate is $\partial_\gamma F/F=Q'/Q=\dfrac{4\mu}{s(s+1)}>0$.

**How far the optimum moves, and what it costs.** Solving $P'/P+Q'/Q=0$ to first order in $\delta:=\gamma-\alpha/2$ gives $\dfrac{-2\delta}{\alpha^2/4}+\dfrac{4\mu}{s(s+1)}=0$, hence

$$\delta=\frac{\mu\alpha^2}{2s(s+1)}=\frac{t\,\alpha}{s(s+1)},\qquad \frac{\delta}{\gamma^*}=\frac{2t}{s(s+1)}\;\xrightarrow[t\to0]{}\;2t .$$

The displacement is $O(t)$ and admissible: it moves $\gamma$ toward $d$ but stays strictly inside $\gamma<d$ and $\gamma<1$ for the recorded $t$, so no constraint blunts the finding. Because $J$ is stationary at $\gamma^*$ with $J''/J=8/\alpha^2$ there, the value cost is second order, $J(\gamma^*+\delta)=J^*\big(1+t^2+O(t^3)\big)$ and $F(\gamma^*)=F_{\max}\big(1-t^2+O(t^3)\big)$ in the small-$t$ limit.

## 4. Whether the record already says this

**They contradict each other, and [L157](../findings/second-order.md#lemma-l157-the-reach-parameter-is-determined-by-a-fixed-point-not-chosen-etatfrac2t1-sqrt4t12t) survives.**

[L157](../findings/second-order.md#lemma-l157-the-reach-parameter-is-determined-by-a-fixed-point-not-chosen-etatfrac2t1-sqrt4t12t), [findings/second-order.md:1262](../findings/second-order.md):

> **And $\gamma$ does not cancel**; what is true is that $J$ is *stationary* at the optimum, so $J^*$ is right to $O(t^2)$.

[L156](../findings/second-order.md#lemma-l156-the-contour-constant-corrected-and-its-optimum-attained-at-the-equidistant-contour), [findings/second-order.md:1439](../findings/second-order.md):

> **The $(\alpha,\gamma)$ half separates from $\sigma$**, so that half is the one-parameter problem L156 solves in closed form

A third statement, in [L156](../findings/second-order.md#lemma-l156-the-contour-constant-corrected-and-its-optimum-attained-at-the-equidistant-contour)'s own bullet at [findings/second-order.md:1433](../findings/second-order.md), is the one [L157](../findings/second-order.md#lemma-l157-the-reach-parameter-is-determined-by-a-fixed-point-not-chosen-etatfrac2t1-sqrt4t12t) is answering: *"the branch-2/branch-3 crossing $t(1-\sigma)^2=\sigma$ with $t=\sqrt{c_p+w^2}/(2J\gamma)$, **in which $\gamma$ cancels for small $t$**, that, rather than the assertion below, is what legitimises splitting the optimisation."*

Section 1 settles it: $J\gamma=C$ and $C$ depends on $\gamma$, so $\gamma$ does not cancel, [L157](../findings/second-order.md#lemma-l157-the-reach-parameter-is-determined-by-a-fixed-point-not-chosen-etatfrac2t1-sqrt4t12t) is right and both L156 sentences are wrong. **[L157](../findings/second-order.md#lemma-l157-the-reach-parameter-is-determined-by-a-fixed-point-not-chosen-etatfrac2t1-sqrt4t12t) survives**, and its replacement clause is exact as well as true: the coupling is real, and what rescues $J^*$ is stationarity, at the order section 3 computes. The two entries are not two readings of one fact; the later one names the earlier one's error and the earlier one was left standing.

## 5. What survives if the candidate stands

**A wrong framing around a half-correct optimisation. $\alpha^*=D/2$ survives exactly; $\gamma^*=D/4$ survives only as the stationary point of $J$, which is not the maximiser of the reach.**

- **$\alpha^*=D/2$ is correct for the radius, not merely for $J$.** At fixed $\gamma$, $F=\gamma\eta^*(\Lambda/2C)$ is strictly decreasing in $C$, because $\eta^*$ is strictly increasing in $t$ (section 3) and $t$ is decreasing in $C$. So maximising the reach over $\alpha$ is exactly minimising $C$ over $\alpha$, which is exactly what [L156](../findings/second-order.md#lemma-l156-the-contour-constant-corrected-and-its-optimum-attained-at-the-equidistant-contour) does: $C=(1+\alpha)/(\alpha-\gamma)$ has $\partial_\alpha C=-(1+\gamma)/(\alpha-\gamma)^2<0$ below the kink and $C=\alpha(1+\alpha)/((D-\alpha)(D-\alpha-\gamma))$ is increasing above it, so both branches run to $\alpha=D/2$. The equidistant contour is the right contour, and the resolvent kink is the binding condition, on either objective.
- **$\gamma^*=D/4$ is the stationary point of $J$ and nothing more.** The reach is maximised at $\gamma=\tfrac{D}{4}+\delta$ with $\delta=t\alpha/(s(s+1))>0$, i.e. at a strictly larger disc.
- **$C^*=\tfrac{42}{11}$, $J^*=\tfrac{840}{121}=6.9421\ldots$ and the corollary's intervals survive to $O(t^2)$, as approximations rather than as exact optima.** $J$ evaluated at the reach-optimal $\gamma$ exceeds $J^*$ by the relative $t^2+O(t^3)$, so the lower bound $J\ge\tfrac{840}{121}$ is untouched while the strict upper bound $J^*<8$ is an $O(t^2)$ statement once the true optimum is used.
- **What does not survive is the split itself.** "The one-parameter problem L156 solves in closed form" is not the chain's $\gamma$ problem; the chain's is $\max_\gamma\gamma\,\eta^*(t(\gamma))$, equivalently $\min_\gamma J/(1-\eta^*)^2$, and it has a different solution.

## Arguing the opposite, the most charitable readings, and why they do not save the sentence

- **"Separates" could mean the formula for $J$ carries no $\sigma$.** Literally true: $J=C/\gamma$ has no $\sigma$ in it. But the sentence does not stop there, it concludes *"so that half is the one-parameter problem L156 solves in closed form"*, which is a claim that solving it in isolation answers the chain's question, and section 3 shows it does not.
- **"Separates" could mean separates to leading order.** True, and defensible in substance: the location moves at $O(t)$ and the value at $O(t^2)$, so at the recorded $t$ this is a percent-level effect. But that is precisely what [L157](../findings/second-order.md#lemma-l157-the-reach-parameter-is-determined-by-a-fixed-point-not-chosen-etatfrac2t1-sqrt4t12t) already says in the correct words (stationarity, with the order named) and [L156](../findings/second-order.md#lemma-l156-the-contour-constant-corrected-and-its-optimum-attained-at-the-equidistant-contour)'s sentence states it unqualified, in the same breath as withdrawing a stronger claim, so it reads as the corrected statement rather than as an approximation.
- **"The $(\alpha,\gamma)$ half" could be read as the $\alpha$ half.** The $\alpha$ half does separate, exactly (section 5). The sentence names the pair.

**What the record would have to change if the candidate stands.** Replace [findings/second-order.md:1439](../findings/second-order.md)'s *"The $(\alpha,\gamma)$ half separates from $\sigma$"* with the true statement: $\sigma=\eta^*(t)$ with $t=\Lambda/(2C(\alpha,\gamma))$, so the objective is $J/(1-\sigma)^2$; the $\alpha$ half separates exactly and $\alpha^*=D/2$ stands, while $\gamma^*=D/4$ is the stationary point of $J$ and sits below the reach-optimal $\gamma$ by $\delta=t\alpha/(s(s+1))$, costing $t^2+O(t^3)$ of relative reach. Strike [findings/second-order.md:1433](../findings/second-order.md)'s *"in which $\gamma$ cancels for small $t$"*, which [L157](../findings/second-order.md#lemma-l157-the-reach-parameter-is-determined-by-a-fixed-point-not-chosen-etatfrac2t1-sqrt4t12t) already contradicts on the record, and mark the corollary's $C^*$ and $J^*$ intervals as right to $O(t^2)$ at the chain's optimum.
