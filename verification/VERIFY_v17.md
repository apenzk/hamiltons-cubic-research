# VERIFY v17, Lemma L149, "Proof of the uniformity" and the two blockquotes above it

*Cold brief, [Lemma L149](../findings/second-order.md) in [findings/second-order.md](../findings/second-order.md), lines 1200–1213. No numerical work was done: no script was run and no solver was called. Every value below is an exact hand evaluation of a closed form that the record itself supplies, and each is shown with the expression it came from. Log: [agent_logs/verify-L149r-v17.log](../agent_logs/verify-L149r-v17.log).*

## Claim table

| # | Claim as written | Verdict |
|---|---|---|
| 1 | $\inf_{w\ge0}g_\rho=\frac1n\sqrt{\rho\kappa/(\rho a_0^2+\kappa)}$ | **CORRECT**, derived below; unique interior minimiser $w^\*=3\sqrt{n-1}/(\rho n)$, needs $\rho>0$ |
| 2 | $\inf_{[0,1]}g_\rho\ \ge\ \inf_{w\ge0}g_\rho$ | **CORRECT AND LEGITIMATE**, set inclusion only; no attainment needed on either side |
| 3 | "no case analysis on the location of the stationary point is needed" | **CORRECT**, and it is doing real work: $w^\*>1$ at $n=12$, so the two infima differ exactly there |
| 4 | "the right-hand side is increasing in $n$" | **FALSE AS WRITTEN**, the right-hand side carries $1/n$ and decreases; the true statement is about $n\cdot\text{RHS}$ |
| 5 | $n\cdot\text{RHS}$ increasing in $n$ | **CORRECT UNDER THE BOX'S $\tfrac29$; REVERSES WITHOUT IT**, increasing $0.7197978\uparrow0.9780766$; under the block's own $u\le w$ it decreases $0.6897670\downarrow0.5898010$ |
| 6 | RHS $=0.71980/n$ at $n=12$ | **CORRECT**, exact value $0.7197978/n$ |
| 7 | "branch 2 is $\ge0.7198/n$" as a bound on the displayed relaxation | **FALSE BY $2.2\times10^{-6}$**, $0.7197978<0.7198$; a lower bound rounded upward |
| 8 | "branch 2 is $\ge0.7198/n$" as a bound on branch 2 | **NOT ESTABLISHED (the prefactor $K$ is dropped**), [L158](../findings/second-order.md)'s Gate-2 box gives branch $2=K\,g_\rho$ with $K\approx0.45$–$0.52$ at $n=12$ |
| 9 | $a_0=\sqrt{2n/(n-2)}$ as coefficient of $n^{1/2}$ | **CORRECT IN VALUE AND IN PLACE**, $a_0n^{-1/2}=1/\sqrt{m-1}$ is exactly [L146](../findings/second-order.md)'s bound, and $n\lVert H\rVert_{op}$ is the denominator |
| 10 | $\rho^{\mathrm{eff}}_n=3\theta_0\frac{n-8}{2(n-2)}-\frac29\lvert\kappa_n\rvert$ | **HYPOTHESIS DEBT ON THE $\tfrac29$**, uncited, and contradicted eight lines below by $\tfrac32\theta_0-\lvert\kappa_n\rvert$ |
| 11 | $\rho^{\mathrm{eff}}$ increasing from $0.71904$ to $1.74238$ | **VALUES CORRECT, ARGUMENT ABSENT**, both endpoints check exactly; no monotonicity argument is on file |
| 12 | $\rho^{\mathrm{eff}}_n>0$ across the range | **TRUE, UNARGUED, AND LOAD-BEARING**, true under either reading of the penalty; the closed form has no positivity argument on file |
| 13 | The three stated hypotheses are the ones the chain uses | **INCOMPLETE**, four further hypotheses are used and unstated; none stated is unused |
| 14 | Range $m\ge6$ | **CORRECT, AND THE LEMMA BOX'S $m\ge5$ IS STALE**, the two contradict each other five lines apart |
| 15 | $c(H)\ge c_p+\rho w^2$ with $\rho=c_{\min}-c_p$, $c_{\min}$ on $\Lambda^2\!\otimes\!\Lambda^2$ | **CORRECT AND INTERNALLY CONSISTENT**, reproduced from [L27](../findings/nondegeneracy.md)'s ten-summand eigenvalue list |
| 16 | The object proved about equals the branch displayed three lines above | **NO**, the display still has $n^{1/2}$ and $w^2$; the two are not uniformly ordered, $g_\rho$ exceeding the display at $w=1$ from $n\ge18$ |

**One line the round can act on: the calculus is right and the constant $0.7197978$ is right for $g_\rho$, but the sentence it is attached to is about branch 2, which is $K\,g_\rho$ with $K\approx\tfrac12$ at $n=12$, and the monotonicity that carries the bound to all $n$ rests entirely on an uncited $\tfrac29$ that the same block contradicts.** Verdict `GAP`.

## 0. Conventions, fixed once

All of the following are the record's own, taken from [findings/second-order.md](../findings/second-order.md), [findings/nondegeneracy.md](../findings/nondegeneracy.md) and [findings/problem.md](../findings/problem.md). $n=2m$ is even, $W^\*$ is the balanced product $S^m\times S^m$.

$$\theta_0(n)=\frac{\sqrt{2(n-1)(n-2)}}{n},\qquad c_p=\frac{3\theta_0}{n-2},\qquad \kappa:=nc_p=3\sqrt{\frac{2(n-1)}{n-2}},\qquad a_0=\sqrt{\frac{2n}{n-2}},$$

$$\lvert\kappa_n\rvert=9\big(\theta_0(n)-\sqrt{3/2}\big),\qquad \rho:=\rho^{\mathrm{eff}}_n=3\theta_0\frac{n-8}{2(n-2)}-\frac29\lvert\kappa_n\rvert,\qquad g_\rho(w)=\frac{\sqrt{c_p+\rho w^2}}{a_0n^{1/2}+nw}.$$

Two identities used throughout, both exact:

$$\kappa=\frac{3\theta_0\,n}{n-2},\qquad\text{hence}\qquad \frac{a_0^2}{\kappa}=\frac{2n/(n-2)}{3\theta_0n/(n-2)}=\frac{2}{3\theta_0};$$

$$\rho=3\theta_0\frac{n-8}{2(n-2)}-2\theta_0+2\sqrt{3/2}=\sqrt6-\theta_0\,\frac{n+16}{2(n-2)},$$

the coefficient of $\theta_0$ being $\frac{3(n-8)-4(n-2)}{2(n-2)}=-\frac{n+16}{2(n-2)}$.

Exact values at $n=12$, each from the display above: $\theta_0=\sqrt{220}/12=1.2360331$; $\kappa=3\sqrt{2.2}=4.4497191$; $c_p=0.3708099$; $a_0=\sqrt{2.4}=1.5491933$, $a_0^2=2.4$; $\lvert\kappa_{12}\rvert=9(1.2360331-1.2247449)=0.1015936$, matching the record's $0.10159$ at [L133](../findings/second-order.md), [L134](../findings/route-a.md) and the [ledger](../findings/LEDGER.md); $\rho=\sqrt6-1.4\theta_0=2.4494897-1.7304463=0.7190434$, matching the block's $0.71904$. Limits: $\theta_0\uparrow\sqrt2$, $\kappa\downarrow3\sqrt2$, $a_0^2\downarrow2$, $\lvert\kappa_n\rvert\uparrow1.7052183$, $\rho\uparrow\sqrt6-\tfrac{\sqrt2}2=1.7423829$, matching the block's $1.74238$.

## The hypothesis inventory

The block's own box lists three. The table separates what the chain uses from what it names.

| Hypothesis | Stated in the box? | Used? | Where it bites |
|---|---|---|---|
| $H\perp W^\*$ | yes | **yes, essentially** | removes $\langle W\rangle$, whose $L_e$-eigenvalue is $1$ and whose margin $3\theta_0(\tfrac12-1)=-\tfrac32\theta_0$ is negative; without it $c_{\min}<0$ and $\rho<0$ |
| $H\perp T_{W^\*}\mathcal O$ | yes | **yes, essentially** | removes $\mathbb R^p\otimes\mathbb R^q$, eigenvalue $\tfrac12$, margin $0$; without it $c_{\min}=0$ and $\rho=-c_p<0$ |
| $\ker W^\*=0$ | yes | **yes, but upstream** | gives branches 2 and 3 a domain; the uniformity calculus itself never touches it |
| $\lVert H\rVert_F=1$ | **no** | yes | the convex-combination step, and $w=\lVert H_r\rVert\in[0,1]$, the whole domain of the claim |
| $n=2m$ even, $p=q=m$ | **no** (it is in the set-up prose) | yes | two $S^2_0$ copies; $\tfrac12-\mu=\frac{m-3}{2(m-1)}$; $\theta_0$ is the sphere-product value at even $n$ only ([problem.md](../findings/problem.md)) |
| $m\ge6$, i.e. even $n\ge12$ | **no** | yes | $\lvert\kappa_n\rvert>0$ only past the crossover $n=6+2\sqrt7=11.2915$; $c_{\min}-c_p>0$ only from $m\ge5$ |
| $\sigma\le\tfrac29$ on the defect-active block | **no**, and uncited | yes | the entire content of the $\tfrac29$ in $\rho^{\mathrm{eff}}$; see §6 |
| $(p,q)\ne(3,3)$ | no | yes | [L27](../findings/nondegeneracy.md)'s eigenvalue list fails at $(3,3)$; implied by $m\ge6$ |
| [L146](../findings/second-order.md)'s homogeneity and $\lVert H_s\rVert_{op}\le1/\sqrt{m-1}$ | in the bullet | yes | supplies $a_0$ |

**Nothing stated is unused.** Four things used are unstated, and one of them ($\sigma\le\tfrac29$), decides the lemma's headline constant.

## 1. The closed form for $\inf_{w\ge0}g_\rho$

Write $A=a_0n^{1/2}$, $B=n$, both positive, and work with $g^2$. For $w\ge0$,

$$\frac{d}{dw}\,\frac{c_p+\rho w^2}{(A+Bw)^2}=\frac{2\rho w(A+Bw)^2-2B(A+Bw)(c_p+\rho w^2)}{(A+Bw)^4}=\frac{2\big(\rho Aw-Bc_p\big)}{(A+Bw)^3},$$

the $\rho Bw^2$ terms cancelling exactly. With $\rho>0$ the bracket has a single sign change, negative then positive, so $g$ has one stationary point on $[0,\infty)$ and it is a strict minimum:

$$w^\*=\frac{Bc_p}{\rho A}=\frac{n\cdot\kappa/n}{\rho a_0n^{1/2}}=\frac{\kappa}{\rho\,n\sqrt{2/(n-2)}}=\frac{3\sqrt{n-1}}{\rho\,n}.$$

At $w^\*$, $c_p+\rho w^{\*2}=c_p\frac{\rho A^2+B^2c_p}{\rho A^2}$ and $A+Bw^\*=\frac{\rho A^2+B^2c_p}{\rho A}$, so

$$g_\rho(w^\*)^2=\frac{c_p\rho}{\rho A^2+B^2c_p}=\frac{\rho\kappa/n}{n(\rho a_0^2+\kappa)}=\frac{\rho\kappa}{n^2(\rho a_0^2+\kappa)},$$

using $A^2=a_0^2n$, $B^2c_p=n^2\cdot\kappa/n=n\kappa$. Hence $\inf_{w\ge0}g_\rho=\frac1n\sqrt{\rho\kappa/(\rho a_0^2+\kappa)}$ exactly as written. **The closed form is correct.**

**Where the stationary point sits, and why it matters.** $w^\*=3\sqrt{n-1}/(\rho n)$ evaluates to $1.1531$ at $n=12$, $0.8856$ at $n=14$, $0.7368$ at $n=16$, $0.5726$ at $n=20$. So $w^\*$ leaves $[0,1]$ at exactly one dimension of the range, $n=12$, the one dimension every other constant in this file is quoted at. The block's "no case analysis on the location of the stationary point is needed" is therefore not a stylistic remark: it is the step that lets the proof pass over the single dimension where the free minimiser is inadmissible. It is legitimate, and the note that $\rho>0$ is what makes $w^\*$ a minimum rather than a maximum is worth having on the record, since the block never says it. Cross-check: at $\rho=1$ the formula returns $w^\*=3\sqrt{n-1}/n=0.8292$ at $n=12$, which is the record's own $0.829$ in [L157](../findings/second-order.md) and [L158](../findings/second-order.md); $\rho(12)<1$ is what pushes it past the endpoint.

## 2. Is the relaxation legitimate?

Yes, and it needs nothing. $[0,1]\subseteq[0,\infty)$, so $\inf_{[0,1]}g_\rho\ge\inf_{[0,\infty)}g_\rho$ by set inclusion alone: an infimum over a subset is at least the infimum over the superset, whether or not either is attained. No compactness, no continuity, no attainment is required. **The step is bounded, not attained, and that is all the argument uses.**

For completeness, both infima happen to be attained here: the free one at $w^\*$ (§1), the constrained one at $w=1$ when $w^\*>1$. The cost of the relaxation at $n=12$ is exact and small:

$$g_\rho(1)=\frac{\sqrt{0.3708099+0.7190434}}{1.5491933\sqrt{12}+12}=\frac{\sqrt{1.0898533}}{5.3665581+12}=\frac{1.0439604}{17.3665581}=0.0601133=\frac{0.7213596}{12}.$$

So $\inf_{[0,1]}g_\rho=0.7213596/n$ at $n=12$ against the relaxed $0.7197978/n$, a loss of $0.217\%$. This matters in §5.

## 3. Is the right-hand side increasing in $n$?

**As written, no.** The right-hand side is $\frac1n\sqrt{\rho\kappa/(\rho a_0^2+\kappa)}$; the bracket is bounded (§ below) and the $1/n$ dominates, so the right-hand side *decreases*, to zero. What the conclusion needs, and what is true under the box's $\rho^{\mathrm{eff}}$, is that $n$ times the right-hand side increases. The sentence attaches the property to the wrong quantity. The conclusion drawn from it is the one the corrected statement supports, so this is a mis-statement rather than a failure, but it is the mis-statement that a reader has to repair before the "hence" is available.

**The correct quantity, in closed form.** Put $K(n):=n\cdot\text{RHS}$. Dividing numerator and denominator by $\kappa$ and using $a_0^2/\kappa=2/(3\theta_0)$ from §0,

$$K^2=\frac{\rho}{\rho\,a_0^2/\kappa+1}=\frac{3\theta_0\rho}{2\rho+3\theta_0},\qquad\text{equivalently}\qquad \frac1{K^2}=\frac{2}{3\theta_0}+\frac1\rho .$$

The second form settles the question: **$K$ increases exactly when $\theta_0$ and $\rho$ both increase.**

- $\theta_0^2=2(n-1)(n-2)/n^2=2\big(1-3/n+2/n^2\big)$, and $\frac{d}{dn}\big(-3/n+2/n^2\big)=\frac{3n-4}{n^3}>0$ for $n\ge2$. So $\theta_0$ is strictly increasing.
- $\rho=\sqrt6-h(n)$ with $h(n)=\theta_0\frac{n+16}{2(n-2)}$, and

$$h(n)^2=\frac{2(n-1)(n-2)}{n^2}\cdot\frac{(n+16)^2}{4(n-2)^2}=\frac12\Big(1+\frac{16}{n}\Big)^2\Big(1+\frac1{n-2}\Big),$$

a product of two positive strictly decreasing factors, hence strictly decreasing; so $\rho$ is strictly increasing.

Both terms of $1/K^2$ are therefore strictly decreasing and **$K$ is strictly increasing**, with

| $n$ | $\theta_0$ | $\rho$ | $K$ |
|---|---|---|---|
| 12 | 1.2360331 | 0.7190434 | **0.7197978** |
| 14 | 1.2616790 | 0.8723909 | 0.7727400 |
| 16 | 1.2808688 | 0.9856383 | 0.8071200 |
| 20 | 1.3076697 | 1.1418200 | 0.8495300 |
| $\infty$ | 1.4142136 | 1.7423829 | 0.9780766 |

**But none of this is on the record.** The block asserts $\rho^{\mathrm{eff}}$ "increasing from $0.71904$ to $1.74238$" and the right-hand side "increasing in $n$", and supplies no derivation of either. The two lines above are a check against the record's own closed forms, not a proof the record contains. That is hypothesis debt, and it is discharge-able: what would have to be written is the identity $1/K^2=\frac2{3\theta_0}+\frac1\rho$ together with the monotonicity of $\theta_0$ and of $h$.

**And the debt is not cosmetic, because the monotonicity reverses under the block's other penalty.** See §6: with the penalty $\lvert\kappa_n\rvert$ that the block states eight lines below the box, $\rho$ becomes $\sqrt6\cdot\frac92-\theta_0\frac{15n-12}{2(n-2)}$, which *decreases* from $0.6400261$ at $n=12$ to $0.4161020$, and $K$ decreases from $0.6897670$ to $0.5898010$. The direction of claim 5 is decided entirely by a factor the block never justifies.

## 4. Is $0.71980$ right at $n=12$, and is it the minimum over the range?

**Right.** From $K^2=3\theta_0\rho/(2\rho+3\theta_0)$ with the §0 values:

$$3\theta_0=3.7080992,\qquad 3\theta_0\rho=3.7080992\times0.7190434=2.6662844,\qquad 2\rho+3\theta_0=5.1461861,$$

$$K^2=\frac{2.6662844}{5.1461861}=0.5181088,\qquad K=0.7197978 .$$

Cross-check through the record's own form: $\rho\kappa=0.7190434\times4.4497191=3.1995412$, $\rho a_0^2=0.7190434\times2.4=1.7257042$, so $\rho a_0^2+\kappa=6.1754233$ and $K^2=3.1995412/6.1754233=0.5181088$, the same value. Rounded to five decimals, $0.71980$. **The stated value is correct.**

**And it is the minimum over even $n\ge12$**, by §3's monotonicity, under the box's $\tfrac29$, and only under it.

## 5. The rounding is in the wrong direction

> "**Hence branch 2 is $\ge0.7198/n$ for every even $n\ge12$, uniformly in $w\in[0,1]$.**"

$K(12)=0.7197978<0.7198$. The displayed chain therefore reads

$$\inf_{[0,1]}g_\rho\ \ge\ \inf_{w\ge0}g_\rho=\frac{0.7197978}{n}\ \not\ge\ \frac{0.7198}{n},$$

and the last link fails by $2.24\times10^{-6}$ absolute, $3.1\times10^{-6}$ relative. **The charitable reading, and it is the right one for the conclusion:** the quantity the lemma is about is $\inf_{[0,1]}g_\rho$, which §2 evaluates at $0.7213596/n$ at $n=12$, comfortably above $0.7198/n$; and $K(14)=0.77274$ upward. So the *conclusion* $\inf_{[0,1]}g_\rho\ge0.7198/n$ is true for every even $n\ge12$, it is the *displayed chain* that does not deliver it, because the relaxation is taken first and the relaxed value is then rounded up. The repair is one character: write $0.71979$, or drop the relaxation at $n=12$ and use the endpoint value.

This is the failure mode the same file polices in three other places, [L157](../findings/second-order.md)'s "a lower bound stated upward", [L149](../findings/second-order.md)'s own margin bullet, [r716](../reviews/REVIEW_r716.md)'s charge, recurring inside the repair written to remove it.

## 6. The $\tfrac29$, which the block contradicts

Two sentences, eight lines apart, both in the object under review, give the coefficient of $w^2$ in the penalised margin:

> "$$\rho_n^{\mathrm{eff}}=3\theta_0\frac{n-8}{2(n-2)}-\frac29\lvert\kappa_n\rvert$$ … increasing from $0.71904$ at $n=12$ to … $1.74238$."

> "$-\kappa_n\delta^2$ contributes $\lvert\kappa_n\rvert u^2t^2$ **against** the margin. Since $A'(0)$ is linear and vanishes on the margin subspace by [Lemma L148], $u\le w$, and the net coefficient is $\tfrac32\theta_0-\lvert\kappa_n\rvert\to2.1213-1.7053=0.416>0$."

They are the same quantity (the coefficient the chain carries on $w^2$) and they differ by a factor $9/2$ in the penalty. In the limit they are $1.7423829$ and $0.4161020$, a factor $4.187$. **Only the first supports the lemma's headline**, and it is the larger of the two, so the block has taken the unsafe direction without saying so.

**The concrete cost.** With the penalty $\lvert\kappa_n\rvert$ the block's own sentence states, $\rho'=3\theta_0\frac{n-8}{2(n-2)}-9(\theta_0-\sqrt{3/2})=9\sqrt{3/2}-\theta_0\frac{15n-12}{2(n-2)}$, giving $\rho'(12)=11.0227041-1.2360331\times8.4=11.0227041-10.3826780=0.6400261$ and $\rho'_\infty=2.1213203-1.7052183=0.4161020$; the subtracted term's square is $\frac{(n-1)(15n-12)^2}{2n^2(n-2)}$, which *increases* ($107.80$ at $n=12$, $111.84$ at $n=100$, $112.5$ in the limit), so $\rho'$ decreases. Then $K'(12)=\sqrt{3.7080992\times0.6400261/4.9881514}=\sqrt{0.4757790}=0.6897670$ and $K'_\infty=\sqrt{4.2426407\times0.4161020/5.0748447}=\sqrt{0.3478660}=0.5898010$, **decreasing**. Claim 5 reverses, claim 6's value drops $4.2\%$, and the uniform constant becomes the unattained limit $0.58980$ instead of the attained $0.71980$.

**The most charitable reading, and it survives.** The $\tfrac29$ is on the record, in this same file: [L141](../findings/second-order.md)(b)'s proof writes $\frac{Q}{\lVert H\rVert^2}=3\theta_0(2\mu s-\mu-\tfrac12)+\tfrac29\lvert\kappa_n\rvert s$ and names $\sigma=\tfrac29$ as "[Lemma L133]'s own step-2 bound", and L141's closing note says "[Lemma L133]'s own support table gives the sharper $\sigma\le\tfrac29$ on the only block where $\sigma\ne0$". L141 also proves the crude universal $\sigma\le\tfrac14$, so even the block's own "$u\le w$", i.e. $\sigma\le1$, is loose by a factor $4$ against a result the record already holds. Under this reading the box is right and the penalty paragraph is the loose one.

**What the reading still owes, and this is the debt.** L141 supports $\sigma\le\tfrac29$ on the **$(2,2)$-split four-set block** of [L120](../findings/second-order.md)'s sign-character decomposition. L149's box asserts the penalty "lands on that same summand", meaning $\Lambda^2\!\otimes\!\Lambda^2$ of [L27](../findings/nondegeneracy.md)'s $O(p)\times O(q)$ decomposition. **These are two different decompositions and the record nowhere identifies the blocks.** The identification is plausible, a four-set split $(2,2)$ between the factors carries exactly the $\Lambda^2\!\otimes\!\Lambda^2$ and $S^2_0\!\otimes\!S^2_0$ components, but it is asserted, not argued, and it is the step on which the headline constant, the monotonicity and the range all rest. To discharge: prove that the defect response's support inside the $(2,2)$ four-set block lies in $\Lambda^2\!\otimes\!\Lambda^2$ with $\sigma\le\tfrac29$ there, and strike or qualify the "$u\le w$" sentence.

*One point in the box's favour it does not make: putting the penalty on $\Lambda^2\!\otimes\!\Lambda^2$ rather than on $S^2_0\!\otimes\!S^2_0$ (the other occupant of those index sets, margin $3\theta_0(\tfrac12+\mu)$), is the conservative choice, since it lands on the smaller margin.*

## 7. The margin coefficient, checked against [L27](../findings/nondegeneracy.md)'s list

[L27](../findings/nondegeneracy.md) gives $\mathcal W_n$ as ten $O(p)\times O(q)$-summands with $L_e$ scalar on each, the ten dimensions summing identically in $p,q$ and the Young labels pairwise distinct, so the list is complete and there is no eleventh place for a smaller margin to hide. At $p=q=m$, with margin $=3\theta_0(\tfrac12-\lambda)$ and $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}=\frac{(m-1)(m-3)}{2(m-1)^2}=\frac{m-3}{2(m-1)}$:

| summand | $\lambda$ | margin at $p=q=m$ |
|---|---|---|
| $\langle W\rangle$ | $1$ | $-\tfrac32\theta_0$, negative, excluded by $H\perp W^\*$ |
| $\mathbb R^p\otimes\mathbb R^q$ | $\tfrac12$ | $0$, excluded by $H\perp T_{W^\*}\mathcal O$ |
| $S^2_0(\mathbb R^m)$, two copies | $\lambda_m=\frac{m-2}{2(m-1)}$ | $\frac{3\theta_0}{2(m-1)}=\frac{3\theta_0}{n-2}=c_p$ |
| $\Lambda^2\otimes\Lambda^2$ | $+\mu$ | $3\theta_0\frac{m-3}{2(m-1)}$ |
| $S^2_0\otimes S^2_0$ | $-\mu$ | $3\theta_0(\tfrac12+\mu)$, larger |
| $\mathrm{Weyl}_p$, $\mathrm{Weyl}_q$, $X_p\otimes\mathbb R^q$, $X_q\otimes\mathbb R^p$ | $0$ | $\tfrac32\theta_0$, larger |

So $c_{\min}$ over the admissible off-$H_s$ directions is $3\theta_0\frac{m-3}{2(m-1)}$, and

$$c_{\min}-c_p=3\theta_0\frac{m-3}{2(m-1)}-\frac{3\theta_0}{2(m-1)}=3\theta_0\frac{m-4}{2(m-1)}=3\theta_0\frac{n-8}{2(n-2)},$$

exactly the box's first term, and exactly the $m$-form in the bullet. **The bullet's $\frac{m-3}{2(m-1)}$ and the box's $\frac{m-4}{2(m-1)}$ are not in conflict**: the first is $c_{\min}$, the second is $c_{\min}-c_p$, and the box says so. A candidate finding to the contrary is **withdrawn**. The convex-combination step then reads $c(H)\ge(1-w^2)c_p+w^2c_{\min}=c_p+(c_{\min}-c_p)w^2$, which is correct and needs $\lVert H\rVert_F=1$ and $H_s\perp H_r$, the first unstated in the box.

Arithmetic check of the block's own figures: at $n=12$, $c_{\min}-c_p=3\times1.2360331\times\tfrac4{20}=0.7416198$, and at $n=14$, $3\times1.2616790\times\tfrac6{24}=0.9462593$, the block's $0.7416$ and $0.9463$, and the coefficient reaches $1$ between $n=14$ and $n=16$ ($3\times1.2808688\times\tfrac8{28}=1.0978875$ at $n=16$), so "reaching $1$ only from $n=16$" is right. **This also means $\rho$ exceeds $1$ from $n=20$**, which matters in §9.

## 8. $a_0$'s placement, and the operator-norm input

**Correct, in value and in position.** [L146](../findings/second-order.md) bounds the operator norm on the joint $S^2_0$ eigenspace by $1/\sqrt{m-1}$, and

$$a_0n^{-1/2}=\sqrt{\frac{2n}{n-2}}\cdot\frac1{\sqrt n}=\sqrt{\frac2{n-2}}=\frac1{\sqrt{m-1}},$$

one quantity written two ways, as [r716](../reviews/REVIEW_r716.md) confirms. The triangle bullet then gives $\lVert H\rVert_{op}\le a_0n^{-1/2}+w$, and the denominator of branch 2 is $n\lVert H\rVert_{op}$ up to the constant folded into $K$, because $\lVert A''\rVert\propto\lVert H\rVert_{op}/g_n$ with $1/g_n=n\sqrt{n-1}/\sqrt{2(n-2)}=\Theta(n)$. Multiplying through by $n$ sends $a_0n^{-1/2}\mapsto a_0n^{1/2}$. **So $a_0$ belongs exactly where it is placed, as the coefficient of $n^{1/2}$, and $\sqrt{2n/(n-2)}$ is the right constant.** Consistency check on $g_n$: the block's $g_n=\sqrt{2(n-2)}/(n\sqrt{n-1})$ and [L158](../findings/second-order.md)'s $1/g_n=n^2c_p/6=n^2\theta_0/(2(n-2))=n\sqrt{2(n-1)}/(2\sqrt{n-2})$ agree identically.

**Two slacks, both safe, worth naming.** The triangle form ignores $\lVert H_s\rVert_F=\sqrt{1-w^2}$ and the cap $\lVert H\rVert_{op}\le\lVert H\rVert_F=1$; the sharper envelope $\min\big(a_0n^{-1/2}\sqrt{1-w^2}+w,\,1\big)$ of the [L158](../findings/second-order.md) box is never larger, reaching $1.4472$ against $1$ at $w=1$, $n=12$. A larger denominator gives a smaller $g_\rho$, so the proof's version is the conservative one and the bound survives. It is however the reason the proof's constant is not the sharp one.

## 9. The object proved about is not the object displayed

The chain three lines above the proof reads

$$r(H)\;\gtrsim\;\min\!\left(\frac{c_p+w^2}{S},\ \frac{\sqrt{c_p+w^2}}{n^{1/2}+nw},\ \frac{\rho(H)}2\right),$$

with $a_0$ absent and the margin coefficient at $1$. The proof is about $\sqrt{c_p+\rho w^2}/(a_0n^{1/2}+nw)$. Both changes are documented repairs in the block's own bullets, so $g_\rho$ is the right object and the display is stale, but **the two are not uniformly ordered**, so a reader cannot infer the display's branch from the proof. At $n=100$, $w=1$: $\theta_0=1.3929830$, $\rho=1.6251010$, $c_p=0.0426423$, $a_0n^{1/2}=n\sqrt{2/(n-2)}=14.2857143$, giving $g_\rho(1)=\sqrt{1.6677433}/114.2857143=1.2914114/114.2857143=0.0113000$, against the display's $\sqrt{1.0426423}/110=1.0210985/110=0.0092827$. The corrected quantity is $21.7\%$ **larger**. The display should be restated, not read alongside.

## 10. The gap: the prefactor $K$ is dropped

> "**Hence branch 2 is $\ge0.7198/n$ for every even $n\ge12$**"

Branch 2 is not $g_\rho$. [L158](../findings/second-order.md)'s settled box, Gate 2 with [r713](../reviews/REVIEW_r713.md) and [r714](../reviews/REVIEW_r714.md) agreeing, traces the chain $\lVert A''\rVert\le2M/((1-\eta)\rho)^2$ with $M\le C\rho$ and $\rho=\gamma g_n/\lVert H\rVert_{op}$ and records

$$\text{branch }2=\underbrace{\frac{\lambda(1-\eta^\*)^2}{\sqrt2\,J}}_{K}\cdot\frac{\sqrt{c_p+w^2}}{a_0n^{1/2}+nw}.$$

So branch $2=K\,g_\rho$, and L149's proof states the constant of $g_\rho$ as though $K=1$. With the record's own values at $n=12$, $\lambda=2/\sqrt{\lvert\kappa_{12}\rvert}=2/\sqrt{0.1015936}=6.2749$ ([L158](../findings/second-order.md), which flags using the asymptotic $1.53$ here as an error), $(1-\eta^\*)^2\ge0.808$ ([L157](../findings/second-order.md)), $6.9421\le J^\*<8$ ([L156](../findings/second-order.md)), one gets

$$K\in\left[\frac{6.2749\times0.808}{1.4142\times8},\ \frac{6.2749\times0.808}{1.4142\times6.9421}\right]=[0.4481,\ 0.5165],$$

so branch 2 at $n=12$ is near $0.33/n$, not $0.72/n$. **The numeral is overstated by roughly a factor $2$ against the record's own constants, and no step converts one to the other.**

**The most charitable reading, stated fully.** L149's own display carries $\gtrsim$ and $O(\cdot)$, so "branch 2" may be shorthand for the branch's shape function with constants deferred; on that reading the proof establishes a property of $g_\rho$ and the sentence over-claims only in its wording. Two things weigh against it. First, the sentence is quantitative, it names $0.7198$, and a $\gtrsim$-display cannot carry a named constant without the constant being named too; that is precisely the error the record calls "a lower bound stated upward". Second, the repair uses $a_0$ and $\rho^{\mathrm{eff}}$, both of which are post-[L158](../findings/second-order.md) corrections, so the writer had $K$ in view and omitted it. **The lemma's $\Omega(n^{-1})$ statement is untouched**, $K$ is bounded below by a positive constant over the range, $\lambda\downarrow1.53$, $(1-\eta^\*)^2\ge0.808$, $J<8$ giving $K\ge0.109$, but the quantitative sentence is not established.

## 11. Range and the stale $m\ge5$

The lemma box says "For $m\ge5$"; the input paragraph five lines above says "for $m\ge6$, $m\ge5$ was overstated". **$m\ge6$ is right and the box is stale.** Both constraints are exact:

- $c_{\min}-c_p=3\theta_0\frac{m-4}{2(m-1)}$ is zero at $m=4$ and negative below, so the margin refinement needs $m\ge5$;
- $\lvert\kappa_n\rvert=9(\theta_0-\sqrt{3/2})$ is positive only past $\theta_0(n)^2=3/2$, i.e. $n^2-12n+8=0$, $n=6+2\sqrt7=11.2915$, so even $n\ge12$, $m\ge6$. At $m=5$, $\theta_0(10)=\sqrt{2\cdot9\cdot8}/10=6/5=1.2<\sqrt{3/2}$, as the block says.

*One wording point.* "$\lvert\kappa_n\rvert$ is negative and $\rho^{\mathrm{eff}}$ has no definition" is loose: the formula $9(\theta_0-\sqrt{3/2})$ returns $-0.2227$ at $n=10$, and substituting it into the box would return $\rho^{\mathrm{eff}}(10)=0.45+0.0495=0.4995>0$, a positive-looking value with the penalty pointing the wrong way. The substance is right, $\kappa_n$ changes sign at the crossover and the penalised framing of [L16](../findings/problem.md) exists only for $n\ge12$, but the failure at $m=5$ is a sign convention breaking, not a formula returning nothing.

## 12. Is $\rho^{\mathrm{eff}}_n>0$ across the range?

**True; unargued; and the conclusion needs it.** Needed because $\rho>0$ is what makes $\rho Aw-Bc_p$ change sign once and $w^\*$ a minimum (§1), and because $\rho\le0$ would make $\rho\kappa/(\rho a_0^2+\kappa)$ non-positive and the closed form meaningless.

The record asserts only the two endpoints and the word "increasing". Checked against the closed form: $\rho=\sqrt6-h(n)$ with $h^2=\frac12(1+16/n)^2(1+\frac1{n-2})$ strictly decreasing (§3), so $\rho$ is strictly increasing and $\rho\ge\rho(12)=0.7190434>0$ on the whole range. Under the block's other penalty (§6) $\rho'$ decreases to $0.4161020>0$, so positivity holds either way, it is only monotonicity that is reading-dependent. **No argument for either is on file**, and the two lines that would discharge it are the ones the block chose not to write.

## What would falsify this, and what was done to look

**The object that would break it: a direction $H\in T_{W^\*}S\cap T_{W^\*}\mathcal O^\perp$, unit Frobenius norm, whose weight $w$ off the joint $S^2_0$ eigenspace sits on the defect-active $(2,2)$ four-set block with contraction ratio $\sigma>\tfrac29$.** Such a direction leaves the margin bullet intact but voids the box's $\rho^{\mathrm{eff}}$: at $\sigma=1$, the block's own stated $u\le w$, the coefficient falls to $0.6400261$ at $n=12$ and *decreases* thereafter to $0.4161020$, so $K$ falls from $0.6897670$ to $0.5898010$, claim 5 reverses, and $0.71980$ ceases to be either the value at $n=12$ or the minimum over the range. Nothing in the block excludes it; the exclusion lives in [L133](../findings/second-order.md)'s support table under a different decomposition.

**A second falsifier, checked and absent: an eleventh summand.** A margin below $3\theta_0\frac{m-3}{2(m-1)}$ on an admissible direction would lower $c_{\min}$ and could drive $\rho$ negative. [L27](../findings/nondegeneracy.md)'s decomposition is multiplicity-free with dimensions summing identically in $p,q$ and a trace identity $\operatorname{tr}L_e=0$ that forces the tenth value uniquely, so the list is closed and no such summand exists.

**A third, checked and absent: a dimension in range where $\rho^{\mathrm{eff}}\le0$.** The closed form $\rho=\sqrt6-h(n)$ is increasing from $0.7190434$, and under the alternative penalty $\rho'$ is decreasing to $0.4161020$; both stay positive for every even $n\ge12$.

**What was done to look.** Read [L27](../findings/nondegeneracy.md)'s ten-summand list and computed every margin at $p=q=m$ from its own eigenvalues; read [L141](../findings/second-order.md) and its $\sigma$ statements to locate the $\tfrac29$ and identify which block carries it; read [L146](../findings/second-order.md), [L148](../findings/second-order.md), [L157](../findings/second-order.md) and [L158](../findings/second-order.md) for $a_0$, $g_n$, $\lambda$, $\eta^\*$, $J^\*$ and the branch-2 prefactor; evaluated $w^\*=3\sqrt{n-1}/(\rho n)$ at $n=12,14,16,20$ to find the one dimension where the relaxation is lossy, and $K$ at those dimensions and in the limit; and evaluated both penalty readings end to end to see which claims each supports.

---

## Verdict

**`GAP`.**

The calculus of the "Proof of the uniformity" is correct: the closed form for $\inf_{w\ge0}g_\rho$ is right, the relaxation from $[0,1]$ is legitimate and needs no attainment, $a_0$ is the right constant in the right place, the margin coefficient reproduces from [L27](../findings/nondegeneracy.md)'s eigenvalue list, and $0.71980$ is the exact value of $n\,g_\rho(w^\*)$ at $n=12$. What is missing is the connection between that number and the sentence it is used to prove.

Three defects, in order of weight:

1. **The prefactor $K$ is dropped (§10).** "Branch 2 is $\ge0.7198/n$" prices $g_\rho$, not branch 2. [L158](../findings/second-order.md)'s Gate-2 box gives branch $2=K\,g_\rho$ with $K\in[0.4481,0.5165]$ at $n=12$ on the record's own constants, an overstatement of about a factor $2$. The lemma's $\Omega(n^{-1})$ conclusion survives, since $K\ge0.109$ over the range; the quantitative sentence does not.
2. **The $\tfrac29$ is uncited and self-contradicted (§6).** The block gives the same coefficient twice, once as $3\theta_0\frac{n-8}{2(n-2)}-\tfrac29\lvert\kappa_n\rvert$ and once as $\tfrac32\theta_0-\lvert\kappa_n\rvert$, differing by a factor $9/2$. Only the first supports "increasing in $n$" and $0.71980$; under the second, $K$ decreases and the uniform constant becomes $0.58980$. The $\tfrac29$ is defensible from [L141](../findings/second-order.md) and [L133](../findings/second-order.md), but requires identifying the $(2,2)$ four-set block with $\Lambda^2\!\otimes\!\Lambda^2$, which nothing on file does.
3. **Two assertions carry no argument at all (§3, §12):** that $\rho^{\mathrm{eff}}_n$ increases, and that the right-hand side does. Both are load-bearing, both are true under the box's $\tfrac29$, and neither is derived. The property is also attached to the wrong quantity, the right-hand side decreases like $1/n$; it is $n$ times the right-hand side that increases.

Three lesser items to repair while there: the rounding $0.7197978\to0.7198$ breaks the displayed chain by $2.24\times10^{-6}$ (§5, conclusion unaffected); the lemma box's $m\ge5$ contradicts the block's own $m\ge6$ (§11); and the branch displayed three lines above the proof still carries $n^{1/2}$ and $w^2$, and is not uniformly comparable to $g_\rho$ (§9).

**Hypothesis debt, named.** To close the gap the block must prove, or cite for, (a) the identification of [L133](../findings/second-order.md)'s defect-active $(2,2)$ four-set block with the $\Lambda^2\!\otimes\!\Lambda^2$ summand, with $\sigma\le\tfrac29$ there; (b) the monotonicity of $\theta_0$ and of $\rho^{\mathrm{eff}}$, from which $1/K^2=\frac2{3\theta_0}+\frac1\rho$ decreasing follows in one line; and (c) a lower bound on $K$, or a restatement of the conclusion as a bound on $g_\rho$ rather than on branch 2. Its box must add $\lVert H\rVert_F=1$, $n=2m$ even and $m\ge6$ to the three hypotheses it lists.
