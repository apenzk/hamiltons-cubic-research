# REVIEW r711, [Lemma L158](../findings/second-order.md), the branch-comparison inequality

*Reviewer r711, 2026-09-05, cold brief, analysis-only. Computation used: one arithmetic screen of the closed forms already on the record (seconds, no object built, no search), reported as a screen and never as evidence for a positive claim.*

## Verdicts

| Claim | Verdict |
|---|---|
| **C1**, branch $1=(c+w^2)/S$ is increasing in $w$, infimum $\kappa/(nS)$ at $w=0$ | **PLAUSIBLE.** True of the expression as displayed. False of the record's own branch-$1$ function $f(u)=(c_p+u^2)/(S+au)$, which [Lemma L147](../findings/second-order.md), [Lemma L157](../findings/second-order.md) and [r709](REVIEW_r709.md) all carry and whose derivative at $0$ is $-ac_p/S^2<0$. L158 does not say which object it means |
| **C2**, interior minimum at $w^*=Bc/A$ | **REFUTED as stated, repairable.** With L158's own $A=n^{1/2}$, $B=n$ and the record's $\kappa\ge4.24$, $w^*=\kappa n^{-1/2}>1$ for every $n\le19$, the whole of the programme's lower range, $n=12$ included. The minimum is then at the endpoint $w=1$, not interior. With the record's actual $g_n$ and $\lVert H_s\rVert_{op}$ the minimiser is $0.829$ at $n=12$, which is [r709](REVIEW_r709.md)'s own number |
| **C3**, ratio $\sqrt{\kappa(1+\kappa)}/(S\lambda(1-\eta^*)^2)$, no $n$ | **REFUTED.** Three separate defects: $A$ and $B$ are read off an $O(\cdot)$ display as though exact, so every suppressed constant lands in the ratio; $\lambda(1-\eta^*)^2$ is $w$-dependent and is evaluated at the wrong $w$; and $\kappa$, $S$ and $(1-\eta^*)^2$ each carry $n$ or $w$. The corrected ratio at $n=12$ is $\approx21$, not $\approx2.6$ |
| **C4**, branch $1$ binds iff $S>\sqrt{\kappa(1+\kappa)}/(\lambda(1-\eta^*)^2)$ | **PLAUSIBLE in form, REFUTED in value.** The *iff* is a correct restatement of "ratio $<1$" and the threshold is genuinely $n$-free. The number is wrong by an order, and the evaluation substitutes $S=1.5449$, which this record twice records as the supremum of a **relaxation bound** rather than of $P$ |
| **C5**, $R(w)$ increasing from $\sqrt\kappa/(S\lambda(1-\eta^*)^2)$ to $\Theta(n^{1-\beta})$ | **CONFIRMED.** $R=b_1/b_2$ algebraically, both factors increase, and the $w$-dependence of $\eta^*$ reinforces rather than reverses the monotonicity |
| **C6**, $\kappa$ is never named on the record | **REFUTED.** $\kappa$ is fixed in this same file, $134$ lines above L158, and again inside L149's own closing line, and again numerically in [r710](REVIEW_r710.md) |

## $\kappa$, which the record has named three times

**[second-order.md](../findings/second-order.md) line 1129 fixes it.** *"Both reviewers confirmed the margin is **exactly** [Lemma L145](../findings/second-order.md)'s $c_p$: $3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)$."* With $\lambda_m=(m-2)/(2(m-1))$ we have $\tfrac12-\lambda_m=1/(2(m-1))=1/(n-2)$, and [conventions.md](../findings/conventions.md) fixes $\theta_0(n)^2=2(n-1)(n-2)/n^2$. Hence

$$c_p=\frac{3\theta_0(n)}{n-2},\qquad \kappa=n\,c_p=\frac{3n\,\theta_0(n)}{n-2}=3\sqrt{\frac{2(n-1)}{n-2}}\ \downarrow\ 3\sqrt2=4.242641 .$$

**At $n=12$, $\kappa=3\sqrt{11/5}=4.44972$ and $c_p=0.370810$.** The value is decreasing in $n$ and confined to $[3\sqrt2,\,4.4498]$ over the whole scope $n\ge12$.

**Two independent confirmations already in the record.** [Lemma L149](../findings/second-order.md)'s ceiling line writes $c_p/S\le c_p/\theta_0\le3/(n-2)$, which is the same identity with $\theta_0$ divided out. And [r709](REVIEW_r709.md) computes the binding direction as $w^*=c_p/A=0.829$ at $n=12$ with $A=1/\sqrt{m-1}=0.4472$, inverting that gives $c_p=0.3707$, the value above to four figures. [r710](REVIEW_r710.md) prints the formula outright: *"$c_p=3\theta_0/(n-2)=0.4243$"*, using $\theta_0=\sqrt2$ rather than $\theta_0(12)$, so its $\kappa$ is $5.09$; the two readings bracket $\kappa\in[4.24,5.09]$ at $n=12$ and agree exactly in the limit.

**So L158's closing sentence is false, and it is false in the manner its own neighbourhood warns about.** *"It is a number the record has never named"* was reached by searching for the letter $\kappa$ rather than for the quantity $nc_p$, the failure mode [Lemma L157](../findings/second-order.md)'s opening paragraph records against its own first version and [Lemma L150](../findings/second-order.md)'s box records against L150.

## What $\kappa$ does to L158's own criterion

**It settles the question the lemma leaves open, decisively, and against the lemma's title.** L158's threshold is $\sqrt{\kappa(1+\kappa)}<S\lambda(1-\eta^*)^2$. With the record's $\kappa=4.4497$ the left side is $4.924$; the right side is $1.916$ on L158's own substitutions. So the ratio is $2.57$, branch $1$ is the larger of the two, **branch $2$ binds, and [I31](../plan.md)'s constant is not load-bearing for the branch minimum.** That is a positive conclusion available from L158's own ingredients and it is the one the entry should have drawn.

**And L158's inversion of its own inequality is arithmetically wrong.** $\sqrt{\kappa(1+\kappa)}<1.9157$ gives $\kappa<1.4799$, not the $\kappa<1.42$ printed. At $\kappa=1.42$ the left side is $1.854$, short of the stated bound.

## The dropped constants, which are the whole content of a constant-level comparison

**L149's display is order-level and L158 reads it as exact.** L149 writes $\lVert A''\rVert=O(1/\rho)=O(n^{1/2}+nw)$ inside a $\gtrsim$. L158 promotes $A=n^{1/2}$ and $B=n$ to exact constants and then computes a comparison whose entire content is constants. **This is the error [r710](REVIEW_r710.md) charged against [Lemma L157](../findings/second-order.md) (*"the constant is imported from an order-level display"*), repeated one entry later on the same display.** Three constants land in the ratio:

- **$g_n$'s constant.** [second-order.md](../findings/second-order.md) line 1108 fixes $g_n=\lvert\lambda_-\rvert=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}\to\sqrt2/n$. Since $B=1/g_n$, the true $B$ is $0.7416\,n$ at $n=12$ and $n/\sqrt2$ in the limit, not $n$.
- **$\lVert H_s\rVert_{op}$'s constant.** [Lemma L146](../findings/second-order.md) gives $O(n^{-1/2})$; [r709](REVIEW_r709.md) uses the explicit $1/\sqrt{m-1}=\sqrt{2/(n-2)}$. Then $A=\lVert H_s\rVert_{op}/g_n=n\sqrt{n-1}/(n-2)=3.980$ at $n=12$, against L158's $3.464$.
- **$\lVert A''\rVert$'s contour constant.** [Lemma L156](../findings/second-order.md)'s box states that the number entering $\lVert A''\rVert$ is $2J^*/(1-\sigma)^2$. L158 carries the $(1-\eta^*)^{-2}$ up into the numerator and drops the $2J^*$, with $J^*=\tfrac{40}9$, a factor $8.89$, or $2C^*=7.64$ on [r710](REVIEW_r710.md)'s normalisation. **This single omission inflates branch $2$ by roughly an order of magnitude.**

**The first two of these repair C2 rather than breaking it further.** $w^*=Bc/A=c_p\,(n-2)/\sqrt{(n-1)\cdot 2/(n-2)}\cdot\ldots$ evaluates to $0.8292$ at $n=12$, [r709](REVIEW_r709.md)'s number to four figures, so the minimiser *is* interior once the constants are right. **What is refuted is C2 as L158 states it**: with $A=n^{1/2}$ and $B=n$ the stated $w^*=\kappa n^{-1/2}$ exceeds $1$ for all $n\le19$, and the "interior minimum" is not in the domain at the only dimension the programme evaluates.

**The corrected ratio.** Writing $g_n=\gamma_0/n$ and $\lVert H_s\rVert_{op}^2=\alpha_0/n$, the general form of the comparison is

$$\frac{\inf_w\text{branch }1}{\inf_w\text{branch }2}=\frac{\sqrt c\,\sqrt{A^2+B^2c}}{S\lambda(1-\eta^*)^2}\cdot 2J=\frac{2J\sqrt{\kappa(\alpha_0+\kappa)}}{\gamma_0\,S\,\lambda(1-\eta^*)^2},$$

with $\alpha_0\to2$ and $\gamma_0\to\sqrt2$, so $\alpha_0/\gamma_0^2=1$ and the $\sqrt{\kappa(1+\kappa)}$ shape survives, **it is the factor $2J/\gamma_0$ that L158 has set to $1$.** *Screen, at $n=12$ with $c_p=0.37081$, $g_n=0.112367$, $A=3.980$, $B=8.899$, $w^*=0.829$, $t=0.206$ hence $\eta^*=0.1492$ and $\lambda(1-\eta^*)^2=1.107$: branch $2$ at its minimum is $0.01128$ and branch $1$ at $w=0$ is $c_p/S$, so the ratio is $26.6$ at $S=\theta_0$ and $21.3$ at $S=1.5449$.* **So branch $1$ exceeds branch $2$ by a factor $\approx20$, not $\approx2.6$**, which reconciles L158 with [r709](REVIEW_r709.md)'s $\approx60\times$ to within the residual $\gamma$/$\eta^*$ normalisation, where L158 as written disagrees with r709 by a factor $\approx25$ while citing r709 as its motivation.

**Threshold, corrected.** Branch $1$ binds iff $S>2J\sqrt{\kappa(2+\kappa)}\big/\big(\gamma_0\lambda(1-\eta^*)^2\big)\approx21$, against L158's $\approx3$. Since [Lemma L70](../findings/bounds.md) caps $\sup\lvert P\rvert$ at $n-2=10$ at $n=12$, **branch $1$ cannot bind at $n=12$ under any admissible $S$**, a stronger and cleaner statement than the conditional L158 records.

## $S=1.5449$ is not $\sup\lvert P\rvert$, and the record says so twice

**[bounds.md](../findings/bounds.md) records this exact substitution as a withdrawn framing error, and then records it a second time as having regrown.** *"the record's numerics put the true supremum near $1.545$, that figure is the supremum of a **relaxation bound**, not of $P$, and points a successor above the true target $\sqrt2$"*; and eighteen lines below its own withdrawal notice, *"not the $\approx1.5449$ an earlier version wrote here, which is the supremum of the **relaxation bound** rather than of $P$"*. [Plan item I31](../plan.md) says the same: *"the $\approx1.545$ the record quotes belongs to a **different quantity** ([r435](REVIEW_r435.md)), not to $\sup\lvert P\rvert$."*

**So L158's evaluation paragraph is [Lemma L142](../findings/bounds.md)'s refuted framing error, third occurrence.** What $1.5449$ *is*: the measured supremum of $\lambda_{\max}p+B_5$, the bound whose dimension-free supremum I31 asks for as a theorem, an upper bound for $\theta$, and the floor of that route. **The record's proved facts about $\sup\lvert P\rvert$ are $\sup\lvert P\rvert\ge\theta_0(n)$ and $\sup\lvert P\rvert\le n-2$; nothing between them.** The threshold should therefore be quoted against $\theta_0$, which is the honest comparand and which $c_p$ carries anyway.

## $\kappa$ and $S$ are not independent, which simplifies the criterion

**Both are pinned to $\theta_0$.** $\kappa=3n\theta_0(n)/(n-2)$ and $S=\sup\lvert P\rvert\ge P(W^*)=\theta_0(n)$. Writing $S=s\,\theta_0$ with $s\ge1$, L158's criterion becomes a condition on $s$ alone:

$$s\;>\;\frac{\sqrt{3(1/\theta_0+3)}}{\lambda(1-\eta^*)^2}\ \xrightarrow[n\to\infty]{}\ 2.18\quad\text{on L158's constants},\qquad \approx15\ \text{corrected.}$$

*This is the form the lemma wanted: whether branch $1$ binds is a question about how far $\sup\lvert P\rvert$ exceeds its own known lower bound, and nothing else.* **$\beta$ is not independent of $\kappa$ either** in the sense the brief asks: $\beta\ge0$ is forced by $\sup\lvert P\rvert\ge\theta_0$, the same $\theta_0$ that sets $\kappa$.

## Two press-points that do not break, recorded positively

**The order of the infima is safe.** $\inf_w\min(f,g)=\min(\inf_w f,\inf_w g)$ holds for any two functions of the same variable, $\min(f,g)\le f$ gives one direction, $\min(f(w),g(w))\ge\min(\inf f,\inf g)$ pointwise gives the other. So comparing the two branch infima *is* the right computation, and no inversion of the true minimum is possible. **And the reduction from $\inf_H$ to $\inf_w$ is sound**: each branch is a lower bound valid for every $H$ carrying that $w$, so $\inf_H r(H)\ge\inf_{w\in[0,1]}\min(\cdot)$ regardless of which $H$ realises what.

**[Lemma L148](../findings/second-order.md) costs the comparison nothing, and L158's caveat overstates it.** Removing branch $2$ at the single point $w=0$ replaces $\inf_{[0,1]}$ by $\inf_{(0,1]}$ for branch $1$; branch $1$ is continuous and increasing, so $\inf_{(0,1]}b_1=b_1(0)$ still, unattained. **The infimum's *value* is unchanged and only its attainment is lost**, and a lower bound on $r_n$ needs the value. *L158's paragraph calls this "the caveat that decides where it applies"; it decides nothing.*

## $\eta^*$ is $w$-dependent, and L158 evaluates it at the wrong $w$

**[Lemma L157](../findings/second-order.md) makes $t=\lambda\sqrt{c_p+w^2}/(2J\gamma)$ a function of $w$, hence $\eta^*=\eta^*(t(w))$ and $(1-\eta^*)^2$ decreasing in $w$**, from $1$ at $w=0$ to $0.808$ at $w=1$. So $\lambda(1-\eta^*)^2$ ranges over $[1.24,1.53]$ and *is not a constant of the problem*. **L158 uses $1.24$, the $w=1$ value, while locating the minimum at $w^*$**, where the correct value is $1.107$ at $n=12$ and tends to $1.53$ as $w^*\to0$ with $n$. The error is up to $23\%$ and it runs against the lemma's own conclusion. **Branch $2$'s true minimiser is not $w^*=Bc/A$ either**, since that ignores the $w$-dependent prefactor; the prefactor pushes the minimiser to larger $w$.

*C5 survives this untouched:* $R(w)$ carries $(1-\eta^*)^{-2}$, which increases with $w$, so the monotonicity is reinforced.

## Branch 1's denominator: an unreconciled contradiction the lemma inherits

**[Lemma L147](../findings/second-order.md) states in terms that $u=0$ is *never* branch $1$'s minimum**, from $f(u)=(c_p+u^2)/(S+au)$ with $f'(0)=-ac_p/S^2<0$; [Lemma L157](../findings/second-order.md) repeats it (*"branch $1$ is not untouched"*) and [r709](REVIEW_r709.md) C2 repeats it again with a size, $S/(a\sqrt c)\approx5\%$ at $n=12$. **[Lemma L149](../findings/second-order.md) displays branch $1$ as $(c_p+w^2)/S$ with no $au$, and L158 inherits that display and asserts monotonicity from it.** The record therefore contradicts itself about branch $1$'s denominator and L158 resolves it silently in the direction that suits C1.

**What saves the framing is [r450](REVIEW_r450.md) D3's collapse**, $f(u^*)=2c/(S+\sqrt{S^2+a^2c})$, which sits within a factor $2$ of $\min(c/S,\sqrt c/a)$, so "the min of two branches" is a legitimate reading of one function's two regimes, and the comparison L158 performs is the right one. **What does not survive is the sentence**: branch $1$ is not increasing in $w$, its infimum is not at $w=0$, and $\kappa/(nS)$ is the value of a regime rather than of an infimum. *Note also that r709's $S/(a\sqrt c)\approx5\%$ is itself the branch-$2$-over-branch-$1$ ratio $=1/20$, i.e. a third independent statement on the record that branch $2$ binds by $\approx20\times$ at $n=12$, the number L158's ratio should have returned.*

## What is owed

1. **Put $\kappa=3\sqrt{2(n-1)/(n-2)}\to3\sqrt2$ into the entry**, with the line-1129 citation, and delete *"a number the record has never named"*.
2. **State the conclusion the number gives**: at every $n\ge12$ and every admissible $S$, branch $2$ binds; [I31](../plan.md)'s constant is not load-bearing for the branch minimum, and I31 is worth doing for the $\beta$ exponent rather than for this comparison.
3. **Carry the three constants** ($g_n=\sqrt2/n$, $\lVert H_s\rVert_{op}=\sqrt{2/(n-2)}$, $\lVert A''\rVert$'s $2J^*$) or state the ratio as an order and stop claiming an inequality between numbers.
4. **Remove $S=1.5449$** and quote the threshold against $\theta_0(n)$, the record's only proved lower bound for $\sup\lvert P\rvert$.
5. **Evaluate $\lambda(1-\eta^*)^2$ at the minimiser**, and say that the minimiser of branch $2$ is not $Bc/A$ once the prefactor's $w$-dependence is kept.
6. **Fix $\kappa<1.42$ to $\kappa<1.48$**, and reconcile the ratio with [r709](REVIEW_r709.md)'s $60\times$ rather than citing r709 while disagreeing with it by $25\times$.

## What would change my verdicts

For C2: a statement in the record that $A=n^{1/2}$ and $B=n$ are exact rather than the constants of an $O(\cdot)$, which would make $w^*>1$ a real feature and C2 wrong in a stronger way than recorded here. For C3 and C4: a derivation showing $\lVert A''\rVert$ carries no $2J^*$ once $(1-\eta^*)^{-2}$ is moved into the numerator, which would restore L158's ratio to within $\sqrt2$ of the truth. For C6: nothing, the identity $\kappa=nc_p=3n\theta_0/(n-2)$ is on the record in three places and is arithmetic from [Lemma L27](../findings/nondegeneracy.md)'s margins.
