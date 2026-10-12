# VERIFY v34, L157: the crossing root is right, the constant $0.808$ attached to it is not

*Cold brief. **No numerical work was done**: no script was run, and every value below is an exact hand evaluation from closed forms, with the intermediate arithmetic shown. Log: [agent_logs/verify-L157-v34.log](../agent_logs/verify-L157-v34.log).*

## Claim table

| # | Claim, as written | Verdict |
|---|---|---|
| 1 | $\eta^*=\dfrac{2t+1-\sqrt{4t+1}}{2t}$ solves $\eta=t(1-\eta)^2$ | **CORRECT**, algebra reproduced; no proof written |
| 2 | "they cross at the **unique** root in $(0,1)$" | **TRUE, UNARGUED**; the one-line proof is supplied below as a check, not as a repair |
| 3 | "the other root being **its reciprocal**" | **CORRECT**, product of roots $=t/t=1$ |
| 4 | "…and **spurious**" | **TRUE ONLY UNDER AN UNSTATED HYPOTHESIS** $\eta<1$ |
| 5 | "Its **largest solution** is the crossing root" (in **both** forms) | **FALSE AS WRITTEN**, $1/\eta^*>1$ is a larger solution; true after restricting to $(0,1)$ |
| 6 | "the **minimum of the two is maximised** there" | **TRUE, UNARGUED** |
| 7 | $\eta^*\gamma=\dfrac{\lambda\sqrt{c_p+w^2}}{2J}(1-\eta^*)^2$ | **CORRECT**, one multiplication by $\gamma$ |
| 8 | "$\sup_w t\to\tfrac18$ at $w=1$" | **STALE**, needs $\lambda=1$, superseded two paragraphs later in the same entry |
| 9 | "so $(1-\eta^*)^2\to0.808$ **at every dimension**" | **BROKEN**, at $n=12$ the entire $w$-range gives $[0.39017,\,0.53575]$ |
| 10 | "$(1-\eta^*)^2$ does not vanish with $n$" | **TRUE, CONSTANT CORRECTED**: the floor is $0.39017$, not $0.808$ |
| 11 | The fixed point exists for every admissible $t$ | **HOLDS, UNCONDITIONALLY**, $4t+1>0$; no existence gap anywhere |
| 12 | Is $\sup_w t$ attained? Is $w$'s range stated? | **ATTAINED at $w=1$**; **$w$'s range is stated in neither form** |
| 13 | "$J$ is stationary at the optimum, so $J^*$ is right to $O(t^2)$" | **CORRECT AS ASYMPTOTICS, STALE AS A LICENCE**, exact ratio $\tfrac{(1+s)^2}{4s}$; $1.0\%$ at $t=\tfrac18$, $16.4\%$ at the record's own $t=0.96205$ |
| 14 | "freezing $\eta=\tfrac12$ cost $2.9$–$3.4$" / Form B's "about $2.9$" | **STALE**, the loss is exactly $4(1-\eta^*)^2$; at $\lambda(12)$ it is $1.56$–$2.14$, and Form B's $2.9$ is read at the direction $w=0.829$ that Form A itself calls refuted |
| 15 | Form A against Form B | **THEY DIFFER**, Form B drops uniqueness, reciprocity/spuriousness and the max–min clause outright |
| 16 | Behaviour at $\ker W\ne0$ | **NO ASSERTION, AND NO HYPOTHESIS EXCLUDING IT**, the excluding hypothesis lives at L149 and was not carried forward |
| 17 | Quantifier order $\max_\eta\min$ inside $\inf_w$ | **NO FINDING**, the interchange is legitimate, and the reason is given in §6 |

**One line the round can act on:** the boxed statement of L157 is mathematically true in all four of its clauses and has no written argument for any of them, and the entry's constant $0.808$ (computed at a value of $\lambda$ the same entry supersedes), lies above the whole range that the record's own finite-$n$ constants permit, so it must come out of L157 and out of L158's $K\in[1.24,1.53]$ that consumes it.

**Verdict: BROKEN**, scoped: claim 9 is refuted in closed form; the boxed lemma (claims 1–3, 6, 7) survives as `HYPOTHESIS-DEBT`, correct but unargued.

---

## 0. Conventions, fixed once

All symbols are read at their record definitions, which I checked at source rather than assuming.

- $n=2m$, $W^*$ the unit-norm Weyl tensor of $S^m\times S^m$; $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$, so $\theta_0(12)=\sqrt{220}/12=\sqrt{55}/6=1.2360331$.
- $\kappa_n=9\big(\sqrt{3/2}-\theta_0(n)\big)$ ([results.md](../results.md):780, [findings/route-a.md](../findings/route-a.md):196). Hence $|\kappa_{12}|=9(1.2360331-1.2247449)=9(0.0112882)=0.10159383$ and $|\kappa_n|\uparrow9(\sqrt2-\sqrt{3/2})=1.7052182$. $\theta_0$ is strictly increasing in $n$ (since $\theta_0^2=2(1-3/n+2/n^2)$ has derivative $2(3n-4)/n^3>0$), so $|\kappa_n|$ is strictly increasing on $n\ge12$ and $\lambda(n)=2/\sqrt{|\kappa_n|}$ is strictly decreasing, from $\lambda(12)=6.27474$ down to $\lambda(\infty)=1.53157$.
- $c_p=3\theta_0/(n-2)$ ([findings/second-order.md](../findings/second-order.md):1281 box), so $c_p(12)=3\cdot1.2360331/10=\sqrt{55}/20=0.37080992$; $\kappa:=nc_p=3\sqrt{2(n-1)/(n-2)}$, $\kappa(12)=4.4497$.
- $w:=\lVert H_r\rVert$, the weight of $H$ outside **both** $S^2_0(\mathbb R^m)$ copies, with $w\in[0,1]$ ([findings/second-order.md](../findings/second-order.md):1204 and the r716 box at :1310).
- $J=C/\gamma$ and $C(\alpha,\gamma)=\frac{\alpha(1+\alpha)}{d(d-\gamma)}$, $d=\min(\alpha,D-\alpha)$, $D=\frac{2m-1}{m-1}$ ([results.md](../results.md):355). At the $J$-optimum $\alpha^*=D/2$, $\gamma^*=D/4=d/2$, $C^*=2+\frac{4(m-1)}{2m-1}$, so $C^*(12)=\frac{42}{11}$ and $C^*\uparrow4$.
- $J\gamma=C$ identically, so **$t=\dfrac{\lambda\sqrt{c_p+w^2}}{2J\gamma}=\dfrac{\lambda\sqrt{c_p+w^2}}{2C}$**, and at $n=12$ the denominator is $2C^*(12)=\frac{84}{11}$, i.e. $t=\lambda\sqrt{c_p+w^2}\cdot0.13095238$.

**The reconstruction is confirmed by the entry's own arithmetic**, which is why I trust it for everything below. With $\lambda=1$, $w=0.829$: $c_p+w^2=0.37080992+0.687241=1.05805$, $\sqrt{\cdot}=1.0286156$, $t=1.0286156\times0.13095238=0.1347$, the entry's printed $0.135$. Multiplying by $1.53157$ gives $0.206305$, the entry's printed $0.206$. Both numerals reproduce to the digits printed.

---

## 1. The hypothesis inventory

*A pass without one is not a pass, so this is the section that decides the verdict on hypotheses.*

**Hypotheses the statement carries: none.** Neither form states a dimension range, a base point, a range for $w$, a sign condition on $t$, a bound on $\eta$, or any condition on $\ker W$. The boxed statement opens "In units of $\rho$" and proceeds.

**Hypotheses the entry actually uses, traced to the result each comes from:**

| Ingredient | Source | Hypotheses it drags in | In L157's statement? |
|---|---|---|---|
| $\eta=r/\rho$, $\rho=\gamma g_n/\lVert H\rVert_{op}$ | L145/L149 | $\ker W^*=0$; $H\perp W^*$; $H\perp T_{W^*}\mathcal O$ | **No** |
| $\eta<1$ (i.e. $r<\rho$) | forced by $\lVert A''(s)\rVert\le 2M/(\rho-\lvert s\rvert)^2$ blowing up at $\lvert s\rvert=\rho$ | needed for claims 4 and 5 | **No** |
| $c_p=3\theta_0/(n-2)$, $w\in[0,1]$ | L149, L146, r716 | $m\ge6$, i.e. $n\ge12$ | **No** |
| $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ | r450 D3 and the quartic tail | $\kappa_n\ne0$; at $n\le11$, $\kappa_n>0$ and the penalty reverses sign ($n=6+2\sqrt7$ is the crossover) | **No** |
| $J$, $\gamma$, $C$ | L156 | $m\ge2$; $W^*=S^m\times S^m$; $W(z)=W^*+zH$ **affine**; $\lVert H\rVert_{op}\le1$; $0<\alpha<D$; $0<\gamma<\min(d,1)$; $\lambda_-$ the spectral point nearest the contour | **No** |
| $M\le C\rho$ inside the chain | L156 gives $M\le C\gamma g_n$ | $\lVert H\rVert_{op}\le1$, and the step is quadratic in $\lVert H\rVert_{op}$ where the chain uses it linearly (r713) | **No** |

**Which of these the written proof uses:** there *is* no written proof of any clause of the box. The prose before the box motivates the equation ($\eta=r/\rho$, hence self-consistency); the four clauses of the box, the root formula, uniqueness in $(0,1)$, the other root being reciprocal and spurious, and the max–min property, are asserted without argument. That is claim 2/4/6's verdict and it is the reason the box carries `HYPOTHESIS-DEBT` even where its content is true.

**What is owed, exactly.** (i) $t>0$ on the admissible set, which requires $n\ge12$ and $c_p>0$; (ii) $\eta\in(0,1)$, i.e. $r<\rho$; (iii) the four clauses of the box, each of which is one line. (i) and (ii) are the hypotheses that make (iii) true, and they are recoverable from the record but are not in the statement.

---

## 2. The algebra of the box, checked line by line

Setting the two coupled quantities equal:
$$\eta=t(1-\eta)^2\iff t\eta^2-(2t+1)\eta+t=0 .$$
Discriminant $(2t+1)^2-4t^2=4t^2+4t+1-4t^2=4t+1$, so the roots are $\dfrac{2t+1\pm\sqrt{4t+1}}{2t}$. **Claim 1 is correct**, and the displayed $\eta^*$ is the minus root.

**Claim 3 (reciprocity).** The product of the roots is $t/t=1$. So the roots are $\eta^*$ and $1/\eta^*$. **Correct.**

**Claim 2 (uniqueness in $(0,1)$).** Sum of roots $=(2t+1)/t>0$ and product $=1>0$, so both roots are positive. Neither equals $1$: substituting $\eta=1$ gives $t-(2t+1)+t=-1\ne0$ for every $t$. A pair of positive reals with product $1$ and neither equal to $1$ has exactly one member in $(0,1)$. **The claim is true**; the argument above is a check, not a repair, and nothing resembling it is on file.

**Claim 6 (max–min).** On $[0,1]$, $b_1(\eta)=\eta$ is strictly increasing and $b_2(\eta)=t(1-\eta)^2$ is strictly decreasing (derivative $-2t(1-\eta)<0$ for $t>0$, $\eta<1$). Their difference $g(\eta)=b_2-b_1$ has $g'=-2t(1-\eta)-1<0$, $g(0)=t>0$, $g(1)=-1<0$, so $g$ has the single zero $\eta^*$ and $\min(b_1,b_2)$ equals $b_1$ on $[0,\eta^*]$ and $b_2$ on $[\eta^*,1]$, increasing then decreasing. Hence $\max_{[0,1]}\min(b_1,b_2)=\eta^*$, uniquely attained. **True, unargued.**

**Claim 7 (the exact identity).** At the crossing, $\eta^*=t(1-\eta^*)^2$ with $t=\lambda\sqrt{c_p+w^2}/(2J\gamma)$; multiply by $\gamma$: $\eta^*\gamma=\frac{\lambda\sqrt{c_p+w^2}}{2J}(1-\eta^*)^2$. **Correct.**

**Rationalised form, used downstream and checked here.** $1-\eta^*=\frac{\sqrt{4t+1}-1}{2t}=\frac{2}{\sqrt{4t+1}+1}$, so with $s=\sqrt{4t+1}$, $\eta^*=\frac{s-1}{s+1}$. This is [findings/second-order.md](../findings/second-order.md):1443's form and it is correct. It also shows $\eta^*$ is **strictly increasing in $t$** ($\frac{d\eta^*}{dt}=\frac{4}{s(s+1)^2}>0$), hence $(1-\eta^*)^2$ is strictly decreasing in $t$, the monotonicity every numeral in §4 turns on.

### Discrepancy: "its largest solution" (claim 5)

**Locate.** Form A, [findings/second-order.md](../findings/second-order.md):1257, *"Its largest solution is the crossing root below."* Form B, [results.md](../results.md):359, *"whose largest solution is the crossing root $\eta^*=(2t+1-\sqrt{4t+1})/(2t)$."* Both forms.

**Exhibit.** At $t=\tfrac18$: $\eta^*=5-2\sqrt6=0.1010205$, and the other root is $1/\eta^*=5+2\sqrt6=9.8989795$, which also satisfies the self-consistency relation $\eta=t(1-\eta)^2$ exactly ($\tfrac18(8.8989795)^2=\tfrac18\times79.19183=9.898979$). The inequality $\eta\le t(1-\eta)^2$ likewise holds on $[1/\eta^*,\infty)$. So $\eta^*$ is not the largest solution of anything as stated.

**Argue the opposite.** The charitable reading is that "solution" ranges only over admissible $\eta$, and $\eta=r/\rho$ with $r<\rho$ forces $\eta\in(0,1)$; on $(0,1)$ the solution set of the inequality is $(0,\eta^*]$ by the monotonicity of $g$ above, and $\eta^*$ is its maximum. That reading is correct, **but it is exactly the hypothesis $\eta<1$ that neither form states**, and it is the same hypothesis the word "spurious" (claim 4) silently uses. The finding stands as a stated-hypothesis defect rather than a mathematical one.

---

## 3. Question 2, answered: existence, the range of $t$, and the range of $w$

**Existence is unconditional and there is no gap here.** For every $t>0$ the discriminant $4t+1>0$, so real roots exist; by §2 exactly one lies in $(0,1)$. Only $t=0$ degenerates, where the displayed formula is $0/0$ (removably: $\eta^*=t-2t^2+O(t^3)$ from $\sqrt{4t+1}=1+2t-2t^2+O(t^3)$).

**$t>0$ on the whole admissible set.** $\lambda=2/\sqrt{|\kappa_n|}>0$ for $n\ge12$ ($\kappa_n=0$ only at $n=6+2\sqrt7=11.2915$, not an integer and below the range); $c_p>0$; $C>0$ on L156's domain. So $t$ never vanishes, and in particular $t(w=0)>0$: **the disappearance of branch 2 at $w=0$ is L148's, not a degeneracy of $t$**, and the entry is right about that.

**Range of $t$, exactly.** $t(w,n)=\lambda(n)\sqrt{c_p(n)+w^2}/(2C(n))$ is strictly increasing in $w$ on $[0,1]$, and strictly decreasing in $n$ (all three of $\lambda\downarrow$, $c_p\downarrow$, $C\uparrow$ push it down). Hence over $n\ge12$, $w\in[0,1]$:
$$t\in\Big(\,0,\ t(1,12)\,\Big],\qquad t(1,12)=6.27474\times\sqrt{1.37080992}\times\tfrac{11}{84}=6.27474\times1.1708159\times0.13095238=0.9620511 .$$

**Is the supremum attained?** Yes, $t(\cdot,n)$ is continuous and strictly increasing on the closed interval $[0,1]$, and $w=1$ is admissible (r716: the envelope $\lVert H\rVert_{op}\le\min(a_0n^{-1/2}\sqrt{1-w^2}+w,1)$ "equal to exactly $1$ at $w=1$"). So $\sup_w t=t(1,n)$, **attained**.

**But the entry's "$\to$" is not that.** The sentence "$\sup_wt\to\tfrac18$ at $w=1$" runs together an attained supremum in $w$ with a limit in $n$. The $\tfrac18$ is an $n\to\infty$ limit, not a value at any dimension, and §4 shows it is not even the right limit under the entry's own final $\lambda$.

**$w$'s range appears in neither form.** It is fixed only at L149/L146 via r716. Since every numeral in the entry is a $\sup_w$ or an $\inf_w$, the omission is load-bearing.

---

## 4. The finding: $(1-\eta^*)^2\to0.808$ "at every dimension" is refuted

**Locate.** [findings/second-order.md](../findings/second-order.md):1264 (Form A only): *"and **it does not vanish with $n$**: $\sup_wt\to\tfrac18$ at $w=1$, so $(1-\eta^*)^2\to0.808$ at every dimension."*

**Exhibit, in closed form.** The numeral is exact at $t=\tfrac18$ and nowhere else: $\eta^*(\tfrac18)=\frac{5/4-\sqrt{3/2}}{1/4}=5-4\sqrt{3/2}=5-2\sqrt6$, so
$$(1-\eta^*)^2=(2\sqrt6-4)^2=24-16\sqrt6+16=40-16\sqrt6=40-39.191836=0.808164 .$$
So $0.808$ **is** $40-16\sqrt6$ and it is attained precisely when $t=\tfrac18$.

Now $t=\tfrac18$ requires $\lambda\sqrt{c_p+w^2}=2C\cdot\tfrac18$. With $c_p\to0$, $w=1$, $C\to4$ this reads $\lambda=1$, **and $\lambda=1$ is the value the same entry supersedes two paragraphs later**, at [findings/second-order.md](../findings/second-order.md):1266: *"$\lambda=2/\sqrt{\lvert\kappa_n\rvert}=1.53$ … Every number moves with it: $t$ from $0.135$ to $0.206$"*, and supersedes again at :1268 with $\lambda(12)=6.275$. The $\tfrac18$ and the $0.808$ were not moved.

The refutation, at the record's own finite-$n$ constants ($n=12$, $\lambda(12)=6.27474$, $2C^*=\tfrac{84}{11}$):

| $w$ | $\sqrt{c_p+w^2}$ | $t$ | $s=\sqrt{4t+1}$ | $\eta^*=\frac{s-1}{s+1}$ | $(1-\eta^*)^2$ |
|---|---|---|---|---|---|
| $0$ | $0.6089417$ | $0.500338$ | $1.7324410$ | $0.2680543$ | $\mathbf{0.535745}$ |
| $0.829$ | $1.0286156$ | $0.845049$ | $2.0929170$ | $0.3533034$ | $0.418217$ |
| $1$ | $1.1708159$ | $0.962051$ | $2.2018650$ | $0.3753631$ | $\mathbf{0.390171}$ |

*Worked, for the $w=1$ row:* $6.27474\times1.1708159=7.346572$; $\times11=80.81229$; $/84=0.9620511$. Then $4t+1=4.8482044$ and $\sqrt{4.8482044}=2.2018650$ (check: $2.2018650^2=4.848209$); $2t+1=2.9241022$; numerator $2.9241022-2.2018650=0.7222372$; $2t=1.9241022$; $\eta^*=0.3753631$; $(0.6246369)^2=0.3901713$.

**At $n=12$ the whole of $(1-\eta^*)^2$ over $w\in[0,1]$ lies in $[0.39017,\,0.53575]$, and $0.808$ is above every point of it, by a factor of $2.07$ at $w=1$, the very direction the sentence names.**

**And the claim fails even under the constants that produced it.** At $\lambda=1$, $n=12$, $w=1$: $t=1.1708159\times0.13095238=0.1533218$; $s=\sqrt{1.6132872}=1.2701524$; $\eta^*=0.1190017$; $(1-\eta^*)^2=0.776158$. So "at every dimension" is false at $n=12$ on the entry's own $\lambda=1$ too, by $4\%$, the $\tfrac18$ is reachable only as $n\to\infty$.

**Argue the opposite.** The most charitable reading is that "$\to$" flags the sentence as asymptotic, and that the entry's blanket "every number moves with it" at :1266 retracts this numeral along with the others. Three things defeat it. (i) "at every dimension" is a universal quantifier, not an asymptotic hedge, and it is false at every dimension including $n=12$ under $\lambda=1$ and under $\lambda(12)$ alike. (ii) The retraction at :1266 was acted on for $t$ ($0.135\to0.206$) and demonstrably not for $0.808$, which survives into the canonical chain. (iii) The correct asymptotic value is not $0.808$ either: as $n\to\infty$, $\lambda\to1.53157$ and $C\to4$, giving $t(1,\infty)=1.53157/8=0.1914463$, $s=\sqrt{1.7657852}=1.3288285$, $\eta^*=0.1411972$, $(1-\eta^*)^2=0.737543$. So the limit the sentence asserts is wrong by $9.6\%$ as a limit, before any question of finite $n$.

**What survives, with the corrected constant.** $(1-\eta^*)^2$ is decreasing in $t$, $t$ is maximal at $(n,w)=(12,1)$ over $n\ge12$, and $\lambda(n)$ is bounded ($|\kappa_n|$ is strictly increasing on $n\ge12$, so $\inf_n|\kappa_n|=|\kappa_{12}|=0.10159>0$). Hence
$$\inf_{n\ge12,\;w\in[0,1]}(1-\eta^*)^2=(1-\eta^*(0.9620511))^2=\mathbf{0.39017}>0 .$$
**Claim 10 ("does not vanish with $n$"), is true, and its floor is $0.39017$, not $0.808$.** The direction matters: $(1-\eta^*)^2$ multiplies the radius, so carrying $0.808$ where $0.390$ is admissible **overstates a lower bound**, the same error, in the same direction, that this entry charges against its own predecessor in the sentence immediately before ("*wrote the second branch without it and so stated a lower bound upward*").

### A note on the entry's "$13$–$22\%$" and "$20\%$", withdrawn as a defect

These reproduce as $1-(1-\eta^*)^2$ at $\lambda=1$, $n=12$: $w=0$ gives $t=0.0797437$, $(1-\eta^*)^2=0.866606$, $13.3\%$; $w=0.829$ gives $t=0.1347$, $(1-\eta^*)^2=0.796854$, $20.3\%$; $w=1$ gives $22.4\%$. Dropping a factor $f<1$ from a lower bound overstates it by $1/f-1$, which is $28.9\%$ at $w=1$, not $22.4\%$. **Withdrawn**: "overstates by $22\%$" is defensible as *the truth is $78\%$ of the stated value*. The figures are recorded here only because they pin the entry's numerals to $\lambda=1$ and $n=12$, which is what §4 needed.

---

## 5. The $O(t^2)$ licence, and how large it actually is

**Claim 13 is the one the round's second question points at**, and it is worth stating that the underlying identity is *right* before saying what is stale about it.

**L156's condition, verified from L157's own root.** Put $x=\gamma/d$, so $t\propto(d-\gamma)$, i.e. $t=T(1-x)$ for a constant $T$; the reach in units of $g_n/\lVert H\rVert_{op}$ is $F(x)=x\,\eta^*(t)$ with $\eta^*=\frac{R-1}{R+1}$, $R=\sqrt{4T(1-x)+1}$. Then $\frac{d\eta^*}{dR}=\frac{2}{(R+1)^2}$ and $\frac{dR}{dx}=-\frac{2T}{R}$, so
$$F'(x)=\frac{R-1}{R+1}-\frac{4Tx}{R(R+1)^2} .$$
Using $4T(1-x)=R^2-1$ to write $4Tx=\frac{x(R^2-1)}{1-x}$ and cancelling $(R^2-1)\ne0$:
$$F'(x)=0\iff R=\frac{x}{1-x}=\frac{\gamma}{d-\gamma}\iff \boxed{\ \frac{\gamma^\dagger}{d-\gamma^\dagger}=\sqrt{1+4t}\ }$$
**[results.md](../results.md):355's condition exactly**. And at $x=\tfrac12$ (i.e. $\gamma=\gamma^*$), $2T=R^2-1$ gives $F'=\frac{R-1}{R+1}\big(1-\frac1R\big)=\frac{(R-1)^2}{R(R+1)}$, matching [findings/second-order.md](../findings/second-order.md):1443's $\frac{(s-1)^2}{s(s+1)}$. **L157's discriminant and L156's contour optimum are one computation, and both are right.**

**The exact size of the licence.** $J\propto\frac{1}{\gamma(d-\gamma)}\propto\frac{1}{x(1-x)}$, and $x=\frac{R}{1+R}$ gives $x(1-x)=\frac{R}{(1+R)^2}$. With $x^*=\tfrac12$ giving $\tfrac14$:
$$\frac{J(\gamma^\dagger)}{J^*}=\frac{(1+s)^2}{4s},\qquad s=\sqrt{1+4t} .$$
Expanding $s=1+2t-2t^2+O(t^3)$: $(1+s)^2=4+8t-4t^2+O(t^3)$ and $4s=4+8t-8t^2+O(t^3)$, so the ratio is $1+\frac{t^2}{1+2t}+O(t^3)=1+t^2+O(t^3)$. **The $O(t^2)$ claim is correct, with leading coefficient exactly $1$.**

**Where it goes stale.** Evaluated exactly:

| $t$ | where it comes from | $s$ | $J^\dagger/J^*=(1+s)^2/(4s)$ |
|---|---|---|---|
| $\tfrac18$ | the entry's $\sup_w t\to\tfrac18$ | $\sqrt{3/2}=1.2247449$ | $\frac{(2.2247449)^2}{4.8989795}=\frac{4.9494909}{4.8989795}=1.010311$ |
| $0.9620511$ | the record's own $\lambda(12)$ at $w=1$ | $2.2018650$ | $\frac{(3.2018650)^2}{8.8074600}=\frac{10.251942}{8.807460}=1.164013$ |

So the "$J^*$ is right to $O(t^2)$" licence is worth **$1.0\%$ if $t\le\tfrac18$ and $16.4\%$ at the record's own constants**. The direction is safe, $\gamma^*$ is not the reach maximiser, so evaluating at $\gamma^*$ understates the reach, which is what L156 means by "an error in the conservative direction", but the *quantitative* reading of $O(t^2)$ as negligible rests on $t\le\tfrac18$, and §3 shows $t$ reaches $0.962$. **The pre-registered question's suspicion is confirmed: the $O(t^2)$ claims downstream are read against a $t$ that the record's own $\lambda(n)$ multiplies by $7.7$.**

---

## 6. Quantifier order, no finding, and the reason

The box's $\max_\eta\min(b_1,b_2)$ order is the one checked in §2 and it is correct. The order that could go wrong is the outer one: the chain wants $\inf_H$ of the reach, and $\eta^*$ depends on the direction through $t(w)$.

There is no interchange defect, because **$\eta$ is defined as $r/\rho(H)$ and $\rho$ is itself direction-dependent**. A single tube radius $r$ is admissible iff for every $H$, $r/\rho(H)\le t(H)\big(1-r/\rho(H)\big)^2$, which by §2's monotonicity is exactly $r\le\eta^*(t(H))\,\rho(H)$ for every $H$, i.e.
$$r_{\max}=\inf_H\ \eta^*\big(t(H)\big)\,\rho(H).$$
So minimising the *product* over $w$ (which is what the record does), is the correct order, and choosing $\eta$ per direction is not a smuggled per-direction optimisation but the definition of $\eta$. **No finding.** (For the reduced problem in $\eta$ alone the two orders coincide outright: $\min(\eta,t(1-\eta)^2)$ is increasing in $t$, so $\max_\eta\inf_w=\inf_w\max_\eta=\eta^*(\inf_w t)$.)

What *is* missing is that neither form of L157 says $\eta^*$ varies with the direction. The box presents $\eta^*(t)$ as a function of $t$ alone, and the record has already been caught by that: [findings/second-order.md](../findings/second-order.md):1319, *"$K$ is not constant: L157's $t$ depends on $w$, so $\lambda(1-\eta^*)^2$ ranges over $[1.24,1.53]$, and the entry used the $w=1$ value at an interior minimiser."* That is §7's business.

---

## 7. The edges of every range, including $\ker W\ne0$

- **$t\to0$.** $\eta^*=t-2t^2+O(t^3)\to0$ and $(1-\eta^*)^2\to1$. The displayed formula is $0/0$ at $t=0$ and the box does not say $t>0$. Harmless on the admissible set (§3) but unstated.
- **$t\to\infty$.** $\eta^*=\frac{s-1}{s+1}\to1^-$ and $1-\eta^*=\frac{2}{s+1}\sim t^{-1/2}\to0$. So $(1-\eta^*)^2$ vanishes as $t\to\infty$; the entry's "does not vanish with $n$" is a statement about $t$ staying bounded, which holds only because $\lambda(n)$ is bounded, and *that* rests on $\inf_{n\ge12}|\kappa_n|=|\kappa_{12}|>0$, which I established in §0 from the monotonicity of $\theta_0$ and which the entry does not state.
- **Smallest admissible dimension.** $n=12$ is where $t$ is largest and every claimed constant is furthest from the truth (§4). Below it, $n\le11$ has $\kappa_n>0$: the penalty reverses sign and $\lambda=2/\sqrt{|\kappa_n|}$ no longer comes from the quartic tail in the direction the chain needs. **L157 states no dimension range at all**, so nothing in its statement stops a reader from evaluating $\eta^*$ at $n=10$.
- **$w$ at both ends.** $w=1$: admissible and where $\sup_w t$ is attained (§3). $w=0$: $t(0)>0$, so $\eta^*(0)$ is defined, but **branch 2 is absent there** by L148, so the value is meaningless, the entry says this, and it is the only edge it does treat.
- **$\ker W\ne0$, at the named witness $W_{\mathbb{CP}^2}$ ($\dim\ker W=3$; padded, kernel $63$ of $66$ at $n=12$, [findings/INDEX-traps.md](../findings/INDEX-traps.md) rows W1 and W4).** **L157 asserts nothing there, and says nothing about not asserting it.** The excluding hypothesis exists on the record but at a different entry: [findings/second-order.md](../findings/second-order.md):1231, *"**$\ker W^*=0$**, without which $W\mapsto W_-$ is not analytic at $W^*$ and branches 2 and 3 have no domain"*. Since $t$ is built from $c_p$, $J$, $\gamma$, all defined only at $W^*=S^m\times S^m$ (where $\ker W^*=0$ holds, $g_n=\sqrt{2(n-2)}/(n\sqrt{n-1})$), L157 is **vacuous rather than false** at the kernel witness. The finding is that the vacuity is invisible from the statement: an entry whose box carries no base point and no hypotheses is exactly the shape of statement that trap W1 records as the programme's recurring failure.

---

## 8. The gap between what is proven and what is used

**Downstream consumption is at a strictly greater generality than the box supplies.**

- **L158 consumes $(1-\eta^*)^2$ inside $K=\frac{\lambda(1-\eta^*)^2}{\sqrt2 J}$** ([findings/second-order.md](../findings/second-order.md):1301) and states its range as *"$\lambda(1-\eta^*)^2$ ranges over $[1.24,1.53]$"* (:1319). Both endpoints inherit the stale $\lambda$: $1.24=1.53157\times0.808164$ is L157's refuted numeral, and $1.53=\lambda\times1$ is the $t\to0$ limit, which no admissible $(n,w)$ attains. Under $\lambda(12)=6.27474$ at $n=12$ the true range is $\lambda(1-\eta^*)^2\in[6.27474\times0.390171,\,6.27474\times0.535745]=[2.4483,\,3.3616]$, larger by a factor near $2$. **Direction:** larger $K$ makes branch 2 larger, which *strengthens* L158's "branch 2 binds at $n=12$", so its conclusion is not endangered; but anyone reading $[1.24,1.53]$ as a cap on $K$ is reading a refuted interval.
- **The cost of freezing $\eta=\tfrac12$ has a closed form the entry never writes.** At $\eta=\tfrac12$ the admissible reach is $\min(\tfrac12,\tfrac t4)=\tfrac t4$ for $t<2$, and the optimum is $\eta^*=t(1-\eta^*)^2$, so the loss is exactly
$$\frac{\eta^*}{t/4}=4(1-\eta^*)^2 .$$
This reproduces the entry's numerals and shows what they depend on: at $\lambda=1.53157$, $n=12$, $w=0.829$ it is $4\times0.723689=2.895$, Form B's "about $2.9$". At $\lambda(12)$ it is $4\times0.418217=1.673$. Across $w\in[0,1]$ at $\lambda(12)$ the loss is $[1.561,\,2.143]$, against the entry's $2.9$–$3.4$. The supremum of the loss is $4$, approached only as $t\to0$, so the entry's "not the factor $4$ first claimed" is right, and $4$ is exactly the unattained limit.
- **Form B's single surviving numeral is read at a direction Form A calls refuted.** [results.md](../results.md):359 keeps *"freezing $\eta=\tfrac12$ cost about $2.9$ at the binding direction"*; that $2.9$ is $4(1-\eta^*)^2$ at $w=0.829$, and Form A at :1268 says *"**the binding direction is disputed and $0.829$ is refuted**"*, while [findings/second-order.md](../findings/second-order.md):1316 adds that $Bc/A=0.82916$ "*is unreachable and stationary for the wrong function*". **The canonical record therefore carries a constant evaluated at a location the working record has refuted.**
- **A naming gap in the canonical file.** [results.md](../results.md):355 (L156) writes the reach as $\sigma\rho$ with a factor $(1-\sigma)^2$; [results.md](../results.md):359 (L157) writes $\eta$ and $\eta^*$. **Nothing in [results.md](../results.md) says these are the same quantity.** The identification exists only in the working file, at [findings/second-order.md](../findings/second-order.md):1437, *"L157 fixes it as $\sigma=\eta^*(t)$, the crossing root of $t(1-\sigma)^2=\sigma$."* A reader of the canonical record alone sees two adjacent lemmas whose central parameters have different names and no bridge, which is precisely the dispute the round says L157's text was used to settle.
- **A word carrying two meanings inside one entry.** The box says *"the two coupled branches are $\eta$ and $t(1-\eta)^2$"*, which are the two sides of one self-consistency equation. Six lines later the same entry says *"Branch 2 is $\lambda\sqrt c/\lVert A''\rVert$"* and *"branch 1 is not untouched"*, which is L149's unrelated branch numbering. Two senses of "branch" in one entry, neither disambiguated.

---

## 9. The two forms

**They differ, and the difference is in the canonical direction.** Form A ([findings/second-order.md](../findings/second-order.md):1245–1271) carries the boxed **LEMMA L157** with four clauses. Form B ([results.md](../results.md):359–362) carries none of the following:

| Clause | Form A | Form B / [results.md](../results.md) |
|---|---|---|
| "cross at the **unique** root in $(0,1)$" | present | **absent**, B says only "the crossing root" |
| "the other root being its **reciprocal and spurious**" | present | **absent** |
| "the **minimum of the two is maximised** there" | present | **absent** |
| "$\sup_wt\to\tfrac18$ at $w=1$, so $(1-\eta^*)^2\to0.808$ at every dimension" | present (the refuted claim) | **absent**, B keeps only "does not vanish with $n$" |
| "$J$ is stationary at the optimum, so $J^*$ is right to $O(t^2)$" | present | **absent** |
| the cost of freezing $\eta=\tfrac12$ | "$2.9$–$3.4$ across the range" | "about $2.9$ at the binding direction" |
| "$\eta^*$ is the largest solution" | present | present |

Two consequences. **First, the refuted numeral $0.808$ is not in the canonical record**, a mitigation, though L158 consumes it and L158 *is* canonical. **Second, the canonical record does not state the maximality property at all**, yet every downstream use (L156's $\gamma^\dagger$, L158's $K$, and the reach chain), needs $\eta^*$ to be the *optimum*, not merely a crossing point. The canonical statement is weaker than what the canonical uses require.

---

## 10. Name what would break it, and what I did to look

**The boxed statement (claims 1–3, 6, 7).** It would be falsified by an admissible parameter with $t\le0$ (making the root complex, or the formula undefined), or by an admissible $t>0$ at which the quadratic has two roots in $(0,1)$ or none. **No such object exists**, and the reason is closed-form: the product of the roots is $t/t=1$ and $\eta=1$ is never a root, so exactly one root is in $(0,1)$ for every $t>0$; and $t>0$ everywhere on the admissible set because $\lambda=2/\sqrt{|\kappa_n|}>0$ for $n\ge12$ ($\kappa_n$ vanishes only at $n=6+2\sqrt7$, not an integer), $c_p=3\theta_0/(n-2)>0$, and $C>0$ on L156's domain $0<\alpha<D$, $0<\gamma<\min(d,1)$. **I looked** by reading $\kappa_n$, $c_p$, $\theta_0$, $C$, $\gamma^*$ and $J^*$ at their defining entries ([results.md](../results.md):355, :780; [findings/route-a.md](../findings/route-a.md):196, :217; [findings/second-order.md](../findings/second-order.md):1204–1231) and checking each for a sign change or a zero inside $n\ge12$, $w\in[0,1]$. There is none.

**The numeral $0.808$ (claim 9).** It would be *rescued* by an admissible $(n,w)$ with $t=\tfrac18$ exactly, since $0.808164=40-16\sqrt6$ is attained there and only there. **I looked, and it is not in the range at the dimension the sentence names.** Under the record's own $\lambda(n)=2/\sqrt{|\kappa_n|}$, $t$ at $n=12$ runs over $[0.500,\,0.962]$ across $w\in[0,1]$ (the whole interval lies above $\tfrac18$) and $t(1,n)$ decreases in $n$ only to $0.1914$, so $t=\tfrac18$ at $w=1$ occurs at **no** dimension. It is reachable at large $n$ with small $w$, where $t(0,n)\to0$; so $0.808$ is a point value on a curve in the $(n,w)$ plane and is neither the infimum, the supremum, nor a value at any dimension's binding direction. That is what "at every dimension" would have needed and does not have.

**The floor I put in its place ($0.39017$).** It would be broken by a dimension $n\ge12$ at which $t$ exceeds $t(1,12)=0.9620511$. **I looked**: that requires $\lambda(n)\sqrt{c_p(n)+1}/(2C(n))$ to increase somewhere, and all three factors are monotone the other way, $\lambda\downarrow$ because $\theta_0\uparrow$ makes $|\kappa_n|=9(\theta_0-\sqrt{3/2})\uparrow$; $c_p=3\theta_0/(n-2)\downarrow$; $C^*=2+\frac{4(m-1)}{2m-1}\uparrow$. So $n=12$, $w=1$ is the maximum of $t$ and the minimum of $(1-\eta^*)^2$ over the whole admissible set.

---

## Verdict

**BROKEN**, with the scope stated exactly:

- **The boxed LEMMA L157 is `HYPOTHESIS-DEBT`.** All four clauses are true (I reproduced each) and **not one has an argument on file**. What is owed is (i) $t>0$ on the admissible set, which needs $n\ge12$ stated; (ii) $\eta\in(0,1)$, i.e. $r<\rho$, without which "spurious" and "largest solution" are both false as written; (iii) the four one-line arguments themselves.
- **The claim "$\sup_wt\to\tfrac18$ at $w=1$, so $(1-\eta^*)^2\to0.808$ at every dimension" is `BROKEN`** and should be struck. At $n=12$ the admissible range is $[0.39017,\,0.53575]$; the correct $n\to\infty$ value at $w=1$ is $0.737543$; the correct uniform floor is $\mathbf{0.39017}$. The claim it supports (that the factor does not vanish with $n$), survives with that floor.
- **The `$O(t^2)$` licence is sound as asymptotics and stale as a licence.** $J^\dagger/J^*=\frac{(1+\sqrt{1+4t})^2}{4\sqrt{1+4t}}=1+t^2+O(t^3)$ exactly; it is $1.0\%$ at $t=\tfrac18$ and $16.4\%$ at the record's own $t=0.962$.
- **Existence needs nothing.** The fixed point exists and is unique in $(0,1)$ for every $t>0$; $\sup_w t$ is attained at $w=1$; $w\in[0,1]$ is stated in neither form and should be.
- **Form B is not Form A.** The canonical entry omits uniqueness, reciprocity, spuriousness and (most consequentially), **the maximality clause that every downstream use of $\eta^*$ requires**.
