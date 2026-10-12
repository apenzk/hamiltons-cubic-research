# VERIFY v46, the five carried findings against Lemma L149, adjudicated one by one

*Adjudicator v46, 2026-09-05. **No numerical work was done: no script was run, and every value below is an exact hand evaluation** from the record's own closed forms, $\theta_0(n)^2=2(n-1)(n-2)/n^2$ from [conventions.md](../findings/conventions.md), $c_p=3\theta_0/(n-2)$ from [findings/second-order.md:1129](../findings/second-order.md#L1129), and the $\rho^{\mathrm{eff}}_n$ display at [findings/second-order.md:1222](../findings/second-order.md#L1222). Each finding was read against the **current** text of [Lemma L149](../findings/second-order.md#L1197), lines 1197–1245, not against the text it was written for. Log: [agent_logs/verify-L149F-v46.log](../agent_logs/verify-L149F-v46.log).*

## VERDICTS

| # | CLAIM IN ONE LINE | VERDICT |
|---|---|---|
| **F7** | THE KERNEL HYPOTHESIS $\ker W^*=0$ IS NOWHERE STATED | **SUPERSEDED** |
| **F9** | $\rho^{\mathrm{eff}}_n>0$ ACROSS THE RANGE HAS NO ARGUMENT ON FILE | **HYPOTHESIS-DEBT** |
| **F10** | THE $m=4$ ARGUMENT NAMES THE WRONG FAILURE | **WITHDRAWN** |
| **F11** | $\kappa$ AND $w^*$ EACH NAME TWO QUANTITIES IN ONE BLOCK | **UPHELD IN PART** |
| **F12** | "THE FIRST IS MINIMISED AT $w=0$" IS FALSE | **UPHELD** |

---

## 1. F7, the kernel hypothesis. SUPERSEDED.

**Where it now lives.** [findings/second-order.md:1227](../findings/second-order.md#L1227) opens a block headed *"HYPOTHESES THE CHAIN USES"* and states, verbatim: *"$H\perp W^*$ and $H\perp T_{W^*}\mathcal O$, which the domain $T_{W^*}S\cap T_{W^*}\mathcal O^\perp$ supplies; and **$\ker W^*=0$**, without which $W\mapsto W_-$ is not analytic at $W^*$ and branches 2 and 3 have no domain, it **holds**, the gap being $g_n=\sqrt{2(n-2)}/(n\sqrt{n-1})$"*. The passage names the hypothesis, names the two branches that need it, gives the reason they need it, and discharges it with a value. That is the whole of what F7 asked for.

**The repairing commit.** The block entered at [1d5d1d26](../findings/second-order.md), *fix(L149): GAP on the proof as written, it ran at coefficient 1 and so bounded from above*, 2026-09-05; the sibling repair to [Lemma L147](../findings/second-order.md#L1173) landed at 593477f0 the same day.

**The branches do genuinely need it, so the statement is load-bearing rather than decorative.** Branch 3 is $\rho(H)/2$ and $\rho=\gamma g_n/\lVert H\rVert_{op}$ by [findings/second-order.md:1394](../findings/second-order.md#L1394); branch 2's denominator comes from $\lVert A''\rVert=O(1/\rho)$ at [findings/second-order.md:1212](../findings/second-order.md#L1212), which is a Cauchy estimate on that same disc. Both quantities are built on $g_n=\lvert\lambda_-\rvert$, the distance from $\operatorname{spec}W^*$ to $0$, and $W\mapsto W_-$ is analytic at $W^*$ exactly when that distance is positive. The named counterexample is on the record: $W_{\mathbb{CP}^2}$ has $\dim\ker W=3$ ([findings/second-order.md:1173](../findings/second-order.md#L1173)).

**The two forms of $g_n$ agree exactly**, which is one more check the passage passes. [findings/second-order.md:1108](../findings/second-order.md#L1108) gives $g_n=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}$, and $\tfrac2n\cdot\tfrac{\sqrt{n-2}}{\sqrt2\sqrt{n-1}}=\tfrac{\sqrt{2(n-2)}}{n\sqrt{n-1}}$, character for character the form at line 1227.

**Discrepancy protocol.** *Located*: line 1227. *Failure exhibited*: none available, the hypothesis is stated. *Opposite argued*: the strongest surviving version of F7 would be that L149 states $\ker W^*=0$ but never states the inequality $\rho(H)\ge\gamma g_n/\lVert H\rVert_{op}$ that carries it into the chain. That version also fails: line 1212's $\lVert A''\rVert=O(1/\rho)=O(n^{1/2}+nw)$ is exactly what the inequality gives, since $g_n=\Theta(1/n)$ and $\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w$ give $1/\rho=\Theta(n^{1/2})+\Theta(n)w$.

**Direction of consequence: none, the finding having been repaired.** Nothing to act on.

---

## 2. F9, positivity of $\rho^{\mathrm{eff}}_n$ across the range. HYPOTHESIS-DEBT.

**The words that fail.** [findings/second-order.md:1223](../findings/second-order.md#L1223): *"**increasing from $0.71904$ at $n=12$ to $\tfrac32\sqrt2-2(\sqrt2-\sqrt{3/2})=1.74238$.**"* Two endpoint values and the word *increasing* are the entire support. The closed form one line above, at [findings/second-order.md:1222](../findings/second-order.md#L1222), is $\rho_n^{\mathrm{eff}}=3\theta_0\frac{n-8}{2(n-2)}-\frac29\lvert\kappa_n\rvert$ with $\lvert\kappa_n\rvert=9(\theta_0(n)-\sqrt{3/2})$; four evaluated values sit at [findings/second-order.md:1322](../findings/second-order.md#L1322). A closed form is not an argument, and no derivation of positivity or of monotonicity is written anywhere in the block.

**F9's stake is exactly as it says, and this is the part worth recording.** Substituting $\rho=0$ into the block's own $g_\rho(w)=\sqrt{c_p+\rho w^2}/(a_0n^{1/2}+nw)$ gives $\inf_{[0,1]}g_0=\sqrt{c_p}/(a_0n^{1/2}+n)=\Theta(n^{-1/2})/\Theta(n)=\Theta(n^{-3/2})$, attained at $w=1$. With $\rho$ bounded below by a positive absolute constant the stationary-point evaluation at [findings/second-order.md:1231](../findings/second-order.md#L1231) gives $\Theta(n^{-1})$ instead. So $\rho^{\mathrm{eff}}_n>0$, uniformly in $n$, is precisely and solely what separates the two exponents. A gap here is not cosmetic.

**The block's arithmetic is exact, which is what makes the debt small rather than absent.** Rewriting the record's own closed form,
$$\rho^{\mathrm{eff}}_n=\theta_0\Big(\tfrac{3(n-8)}{2(n-2)}-2\Big)+2\sqrt{3/2}=2\sqrt{3/2}-\theta_0(n)\tfrac{n+16}{2(n-2)}=\sqrt6-\underbrace{\tfrac{n+16}{2n}\sqrt{\tfrac{2(n-1)}{n-2}}}_{=:p(n)},$$
which is the form [findings/second-order.md:1322](../findings/second-order.md#L1322) prints independently. At $n=12$, $p(12)=\tfrac{28}{24}\sqrt{22/10}=\tfrac76\sqrt{2.2}$ and $\rho^{\mathrm{eff}}_{12}=\sqrt6-\tfrac7{30}\sqrt{55}=0.7190434$; at $n=14,16,18$ the same expression returns $0.87238$, $0.98564$, $1.07274$, matching the four values on file to five digits. The stated limit $\tfrac32\sqrt2-2(\sqrt2-\sqrt{3/2})=1.7423829$ is $\sqrt6-\tfrac{\sqrt2}2$, also exact.

**What is owed, stated so it can be discharged.** Two sentences, neither of them on the record:
- **Positivity.** $p(n)<\sqrt6$ for every even $n\ge12$.
- **Monotonicity**, which is what the word *increasing* asserts. $p$ is a product of the two factors $\tfrac{n+16}{2n}$ and $\sqrt{\tfrac{2(n-1)}{n-2}}$, and the direction of each in $n$ decides the direction of $\rho^{\mathrm{eff}}$.

I state what must be proved and stop there; supplying the proof is the record's job, not this adjudication's.

**And the record itself contests the word.** [findings/second-order.md:1225](../findings/second-order.md#L1225) marks the penalty coefficient $\tfrac29$ as `HYPOTHESIS-DEBT` and adds: *"At coefficient $1$ the constant reads $0.689771$ and *decreases* to a floor of $0.582938$, reversing the monotonicity above."* So *increasing* at line 1223 is conditional on an identification the same block says nothing on file supports. That numeral is reproducible: at coefficient $1$, $\rho_1(12)=0.7416199-0.1015938=0.6400261$, and the $g_\rho$ coefficient $\big(\tfrac{\sqrt2n}{3\sqrt{(n-1)(n-2)}}+\tfrac1{\rho}\big)^{-1/2}$ reads $(0.53936+1.56244)^{-1/2}=0.68985$, the line's $0.689771$, and confirming that this numeral prices $g_\rho$ rather than $\rho^{\mathrm{eff}}$ itself.

**Discrepancy protocol.** *Located*: line 1223. *Failure exhibited*: the closed form is printed and the passage from it to *increasing* and to $>0$ is absent; separately, line 1225 asserts the direction reverses under the other reading of $\tfrac29$, so the two passages disagree in print. *Opposite argued*: the strongest defence is that positivity is what the chain needs and it survives both readings, line 1225 says so outright, *"The order $\Omega(n^{-1})$ survives either reading; the numeral and the direction do not."* That defence lowers the severity and does not close the finding, because the surviving-under-both-readings claim is itself unargued, and the $\Omega(n^{-1})$ that rests on it is a lower bound.

**Direction of consequence.** $\rho^{\mathrm{eff}}$ enters branch 2's numerator, so an unproved positivity makes a **lower bound stated upward**, the whole of the $\Omega(n^{-1})$ claim in the box at [findings/second-order.md:1218](../findings/second-order.md#L1218), and with it the ceiling arithmetic downstream in [Lemma L158](../findings/second-order.md#L1278). This is the fatal direction.

---

## 3. F10, the $m=4$ clause. WITHDRAWN.

**The words attacked.** [findings/second-order.md:1210](../findings/second-order.md#L1210): *"the smallest off-summand margin is the $+\mu$ one, $3\theta_0\frac{m-3}{2(m-1)}$, which is **zero at $m=3$** and ties with $c_p$ at $m=4$, reaching $\ge\tfrac34\theta_0$ only from $m=5$."*

**Every one of those three values is exact, and the tie is the decisive one.** With $n=2m$ and $c_p=3\theta_0/(n-2)=3\theta_0/(2m-2)$:

| $m$ | smallest off-summand margin $3\theta_0\frac{m-3}{2(m-1)}$ | $c_p=\frac{3\theta_0}{2(m-1)}$ | coefficient of $w^2$, $=c_{\min}-c_p$ |
|---|---|---|---|
| $3$ | $0$ | $\tfrac34\theta_0$ | $-\tfrac34\theta_0$ |
| $4$ | $3\theta_0\cdot\tfrac16=\tfrac12\theta_0$ | $\tfrac12\theta_0$ | $\mathbf 0$ |
| $5$ | $3\theta_0\cdot\tfrac28=\tfrac34\theta_0$ | $\tfrac38\theta_0$ | $\tfrac38\theta_0$ |

**So the recipe gives $0$ at $m=4$, not $\theta_0$.** F10's exhibited failure is off by the whole quantity: the $w^2$ coefficient the chain carries is the *difference* $c_{\min}-c_p$, which line 1223 states explicitly (*"both equal to $c_{\min}-c_p$"*), and the block's $m$-form $3\theta_0\frac{m-4}{2(m-1)}$ evaluates to $0$ at $m=4$ by inspection. The failure at $m=4$ is therefore exactly the one the text names, the eigenvalue $\mu=\tfrac1{m-1}$ meets $\lambda_m=\tfrac{m-2}{2(m-1)}$ there, the off-summand margin ties with $c_p$, and branch 2 loses its $w^2$ lift and falls back to $\Theta(n^{-3/2})$.

**The second half of F10 fails too.** [Lemma L146](../findings/second-order.md#L1141) is stated *for $n=2m$ and $m\ge3$* and so covers $m=4$, returning $\lVert H\rVert_{op}\le1/\sqrt{m-1}=1/\sqrt3$ there. Nothing in L146's operator-norm input fails at $m=4$; the one scope caveat it carries, at [findings/second-order.md:1145](../findings/second-order.md#L1145), is that the spike witness beats the even split only while $m^2-8m+8<0$, i.e. $m\le6$, a caveat about $m\ge7$, in the opposite direction from $m=4$.

**Discrepancy protocol.** *Located*: line 1210. *Failure exhibited*: could not be, the closed-form evaluation contradicts F10's stated value. *Opposite argued*: F10's strongest reading is that the **margin** at $m=4$ is $\tfrac12\theta_0>0$, so *something* positive survives there. True, and irrelevant: branch 2's numerator is $c_p+\rho w^2$, and it is $\rho$, not the margin, that the $m$-range guards.

**Direction of consequence: none.** The text is right as written; no repair is owed.

---

## 4. F11, the notation collisions. UPHELD IN PART.

**$\kappa$: upheld, and it can mislead at a named line.** [findings/second-order.md:1229](../findings/second-order.md#L1229) writes *"$c_p=\kappa/n$"* with no definition of $\kappa$ in the block, and [findings/second-order.md:1231](../findings/second-order.md#L1231) carries that $\kappa$ into the display $\inf_{w\ge0}g_\rho=\tfrac1n\sqrt{\rho\kappa/(\rho a_0^2+\kappa)}$. Seven lines above, [findings/second-order.md:1222](../findings/second-order.md#L1222) defines a **different** quantity as $\lvert\kappa_n\rvert=9(\theta_0(n)-\sqrt{3/2})$, and [findings/second-order.md:1241](../findings/second-order.md#L1241) uses it again. The two differ by one subscript while $\kappa$ is itself a function of $n$, so *"$\kappa_n$"* is the natural notation for the thing it is not.

**The confusion is not benign, and it runs both ways.** The true values, from the record's own forms, $\kappa=nc_p=3\sqrt{2(n-1)/(n-2)}$ at [findings/second-order.md:1285](../findings/second-order.md#L1285), and $\lvert\kappa_n\rvert$ at line 1222, are at $n=12$:

| symbol | closed form | value at $n=12$ |
|---|---|---|
| $\kappa$ | $3\sqrt{2(n-1)/(n-2)}=3\sqrt{2.2}$ | $4.4497191$ |
| $\lvert\kappa_n\rvert$ | $9(\theta_0(12)-\sqrt{3/2})=\tfrac32\sqrt{55}-9\sqrt{3/2}$ | $0.1015938$ |

A factor of $43.8$. Reading line 1231 with $\lvert\kappa_n\rvert$ in place of $\kappa$ turns the coefficient $0.719796$ into $\big(0.0730487/1.8272981\big)^{1/2}=0.19994$, a threefold understatement, which is the safe direction. Reading line 1241 the other way turns *"$\tfrac32\theta_0-\lvert\kappa_n\rvert\to2.1213-1.7053=0.416>0$"* into $1.8540-4.4497=-2.60$, destroying a positivity claim outright. That is the unsafe direction, and it is reachable by a reader who does nothing worse than carry one symbol eight lines.

**A reader who consults the conventions table is made worse off, not better.** [conventions.md](../findings/conventions.md) registers $\kappa$ three times and none of them is L149's: line 23 gives $\kappa^2=\max_Ft_F$ with $\kappa\le\sqrt2$; line 49 gives the Killing constant $\kappa=2(n-2)$; line 102 gives $\kappa_n=(2n-1)(n-1)/4$ and adds, of its own accord, *"It has appeared under two symbols inside one file."* Taking the first of those, $c_p=\kappa/n\le\sqrt2/12=0.1179$ against the true $c_p=3\theta_0(12)/10=0.3708$. The only place the L149 reading is written down is [findings/second-order.md:1285](../findings/second-order.md#L1285), fifty-six lines below the block and inside another lemma.

**$w^*$: does not bite the current text.** The symbol $w^*$ occurs nowhere in lines 1197–1245. Its two occurrences in this file are [findings/second-order.md:1266](../findings/second-order.md#L1266), $w^*=0.553$, the $\lVert H\rVert_{op}$ kink, and [findings/second-order.md:1298](../findings/second-order.md#L1298), both inside [Lemma L157](../findings/second-order.md#L1253); the competing minimiser $w_0=(n-4)/n$ lives at [findings/second-order.md:1312](../findings/second-order.md#L1312). Those two *are* distinct objects that have been read as one, [findings/second-order.md:1322](../findings/second-order.md#L1322) says so in terms, *"The two baselines are different objects and are named here because reading them as one has misled three readers"*, but they collide in L157 and L158, not in L149, and the record already flags the collision where it occurs. Against the block F11 names, this half is refuted.

**Discrepancy protocol.** *Located*: lines 1222, 1229, 1231, 1241 for $\kappa$; nowhere in 1197–1245 for $w^*$. *Failure exhibited*: the $43.8$-fold value split and the sign reversal above, in closed form. *Opposite argued*: the strongest defence is that the two symbols are typographically distinct ($\kappa$ against $\kappa_n$) and the block never writes one where it means the other, so nothing in it is false. That defence holds for correctness and fails for the standard F11 sets: a reader who follows the text has no way to learn that the subscript changes the object, and the conventions table actively misdirects him.

**Direction of consequence.** No stated value in L149 is wrong on account of the collision; the exposure is to future readers and to citations from other blocks. **What the text should say instead:** define $\kappa:=nc_p=3\sqrt{2(n-1)/(n-2)}$ at its first use in the block, at line 1229, and give it a row in [conventions.md](../findings/conventions.md) distinguishing it from the three $\kappa$'s already there; or rename it, which costs nothing since it appears twice.

---

## 5. F12, "the first is minimised at $w=0$". UPHELD, and here is the settlement.

**The words.** [findings/second-order.md:1218](../findings/second-order.md#L1218), inside the boxed statement of the lemma: *"For $m\ge6$, the second branch is $\Omega(n^{-1})$ **uniformly in $w\in[0,1]$**, the first is minimised at $w=0$"*. The box then annotates the clause in place (*"**this clause does not follow and is owed**"*) and gives a reason.

**The clause is false, not merely unproved, and the annotation's reason is the right one.** Branch 1 is $f(u)=(c_p+u^2)/(S+au)$ at [findings/second-order.md:1214](../findings/second-order.md#L1214), with $u$ the defect's linear rate, $u\ne w$, and $u\le w$ the only relation on file ([findings/second-order.md:1216](../findings/second-order.md#L1216)). Then
$$f'(u)=\frac{2u(S+au)-a(c_p+u^2)}{(S+au)^2},\qquad f'(0)=-\frac{ac_p}{S^2}<0\ \text{ whenever }a>0,$$
so $f$ falls away from $u=0$ and its minimum is interior at $u^*=(\sqrt{S^2+a^2c_p}-S)/a$ with $f(u^*)=2u^*/a$, which is [findings/second-order.md:1179](../findings/second-order.md#L1179)'s display, already on the record inside [Lemma L147](../findings/second-order.md#L1163). The lower bound must hold over every direction, so what enters is the infimum over admissible $(u,a)$. At $w=0$, [Lemma L148](../findings/second-order.md#L1183) forces $u=0$ and $a=0$, giving branch 1 the value $c_p/S$ exactly; at any $w>0$ the admissible $u$ widens and $a$ grows, and $f$ drops below $c_p/S$. **So $w=0$ is where branch 1 is largest.** The box's own gloss says precisely this, and it is correct.

**The consequence, which the record has not drawn.** Take the chain's own upper bound $a=O(n^{1/2}+nw)$ from [findings/second-order.md:1212](../findings/second-order.md#L1212) (the legitimate direction for a lower bound on $f$), with $c_p=3\theta_0/(n-2)=\Theta(n^{-1})$ and $S=\Theta(n^\beta)$, $\beta\in[0,\tfrac12]$ by [findings/second-order.md:1165](../findings/second-order.md#L1165). At $w=\Theta(1)$, so $a=\Theta(n)$:
$$a^2c_p=\Theta(n),\quad S^2=\Theta(n^{2\beta})\le\Theta(n),\quad u^*=\Theta(n^{-1/2})\le w,\quad f(u^*)=\frac{2u^*}{a}=\Theta(n^{-3/2}).$$
That is strictly below $n^{-1-\beta}$ for every $\beta<\tfrac12$. So the box's own conclusion, *"$r_n\gtrsim n^{-1-\beta}$ over every direction"*, is not supported by the branch the refuted clause was there to price. Its value at the point the clause named, $c_p/S=\Theta(n^{-1-\beta})$, is branch 1's **maximum** over $w$.

**Discrepancy protocol.** *Located*: line 1218. *Failure exhibited*: $f'(0)=-ac_p/S^2<0$ in closed form, with $\inf f=2u^*/a=\Theta(n^{-3/2})$ at $w=\Theta(1)$, $\beta<\tfrac12$. *Opposite argued*: three defences, all failing. **(i)** *At $w=0$, $a=0$ by L148, so $f(u)=(c_p+u^2)/S$ really is minimised at $u=0$.* True, and it settles the wrong question: it makes $w=0$ the minimiser in $u$ **at that one $w$**, which is what turns $c_p/S$ into branch 1's largest value across $w$, not its smallest. **(ii)** *$a$ may be small at large $w$, keeping $f$ up.* Refuted by [findings/second-order.md:1268](../findings/second-order.md#L1268), $a\propto(1-\eta)^{-2}\ge1$, and by $a\asymp\lVert A''\rVert$ growing in $w$. **(iii)** *The record has no lower bound on $\lVert A''\rVert$ ([findings/second-order.md:1175](../findings/second-order.md#L1175)) and none on $u$, so the bad direction cannot be exhibited.* This is the one real defence, and it cuts the other way: a lower bound must **exclude** the direction, and nothing on file excludes it, so what the chain proves is $\Theta(n^{-3/2})$ and the box claims more.

**Direction of consequence: an overstated lower bound, the fatal direction.** The box at line 1218 is a lower-bound claim, and the false clause was its only support on the branch-1 leg. This is consistent with the rest of the file rather than novel against it: [findings/second-order.md:1111](../findings/second-order.md#L1111) records $r_n=\Omega(n^{-3/2})$ as the confirmed lower bound, and [findings/second-order.md:1179](../findings/second-order.md#L1179) already states that *"the cubic branch always shadows the quartic"*. **What the text should say instead:** delete *"the first is minimised at $w=0$"* and replace it with branch 1's actual infimum, $f(u^*)=2u^*/a=\Theta(\min(c_p/S,\ \sqrt{c_p}/a))$, and qualify the display to $r_n\gtrsim\min(n^{-1-\beta},\ n^{-3/2})=n^{-3/2}$ until a constraint tying $u$ to $w$ from below is on file. Whether $n^{-1-\beta}$ can be recovered I cannot determine from the record and do not estimate: it turns on the $u\lesssim w$ dependency whose constant [findings/second-order.md:1380](../findings/second-order.md#L1380) records as unknown.

---

**The record must act on three of the five: F12 first**, since the boxed lower bound $r_n\gtrsim n^{-1-\beta}$ rests on a clause the same box calls refuted and the surviving chain gives only $n^{-3/2}$; **then F9**, two sentences of monotonicity and positivity for $\rho^{\mathrm{eff}}_n$ that the closed form at line 1222 makes elementary and that nothing on file writes; **then F11's $\kappa$**, a definition at line 1229 and a row in [conventions.md](../findings/conventions.md). **F7 is repaired and F10 is refuted**, and neither needs anything further.
