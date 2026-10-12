# VERIFY v38, L158: the threshold's value, the $n$-freeness of the branch comparison, and the extension of "branch 2 binds" to $n\approx1800$

*Cold brief, verifier v38. **No numerical work**: no script was run, no solver called; every decimal below is an exact hand evaluation of a closed form, and every closed form is derived on the page. Log: [agent_logs/verify-L158-v38.log](../agent_logs/verify-L158-v38.log). Sources read at first hand: [findings/second-order.md](../findings/second-order.md) lines 1195–1330 (L149, L156, L157, L158), [results.md](../results.md) lines 365–369, [plan.md](../plan.md) line 116. No other verifier's report was read.*

## Claim table

| # | claim, as the entry states it | verdict |
|---|---|---|
| 1 | $\inf_w\min(f,g)=\min(\inf f,\inf g)$, so comparing separately-taken infima is sound | **PROVEN**, the identity is true; proof supplied in §3 |
| 2 | $\kappa=nc_p=3\sqrt{2(n-1)/(n-2)}$, $\kappa(12)=4.4497$, $\kappa\downarrow3\sqrt2$ | **PROVEN**, reproduced exactly from $c_p=3\theta_0/(n-2)$, $\theta_0=\sqrt{2(n-1)(n-2)}/n$ |
| 3 | the displayed threshold $\inf b_1/\inf b_2=\sqrt{\kappa(1+\kappa)}/(SK)$ | **BROKEN**, it is the $a_0=1$, $\rho=1$ form; the record's own $a_0^2=2n/(n-2)$ and $\rho^{\mathrm{eff}}_n$ give $\sqrt{\kappa(\rho a_0^2+\kappa)/\rho}$, larger by $1.2553$ at $n=12$ |
| 4 | "the branch comparison is $n$-free" (the title) | **BROKEN**, $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ and $\lvert\kappa_n\rvert=9(\theta_0(n)-\sqrt{3/2})$ vanishes at $n=6+2\sqrt7$, so the ratio blows up at the crossover; the entry says so itself two paragraphs after the title |
| 5 | the threshold is pinned at $\approx17$–$19$ at $n=12$ | **PROVEN as a number, not as a range**, I get $17.257$ at $\rho=1$ and $18.003$ at $\rho^{\mathrm{eff}}_{12}$, both from constants the entry names; it is derived, not asserted |
| 6 | the $17$–$19$ / $52.92$ spread "is one constant", $\lambda$, "a factor $4.1$" | **GAP**, $4.1$ is the ratio in $\lambda$; the induced ratio in the threshold is $2.29$–$2.45$, and $52.92$ reproduces from no combination I could form |
| 7 | branch 2 binds at $n=12$ | **PROVEN**, $S\le4.162$ against a threshold of $18.00$; margin $4.3\times$, and every correction found here widens it |
| 8 | "provably so at every $n$ up to $\approx1800$" | **REFUTED**, $\approx1800$ is the $\rho=1$ answer (I get $1714$); under the record's own $\rho^{\mathrm{eff}}_n$ the stopping dimension is $\approx1140$, and $\rho=1$ is the **unsafe** direction at every $n\ge18$ |
| 9 | "the repair strengthens" the binding verdict | **PROVEN at $n\in\{12,14,16\}$, REFUTED at every $n\ge18$**, $\rho^{\mathrm{eff}}_n$ exceeds $1$ from $n=18$ and rises to $1.74238$ |
| 10 | $w_0=(n-4)/n$ is a strict minimum on $[0,1]$ | **PROVEN**, the two-sided argument is correct and I re-derive $\mathrm d\log N/\mathrm d\log s=1/\sqrt{4t+1}$ exactly |
| 11 | $\phi'(w_0)=\tfrac35$ exactly | **REFUTED**, the exact value is $1-\dfrac{n-4}{\sqrt2\,(n-2)^{3/2}}=1-\tfrac{2\sqrt5}{25}=0.8211146$ at $n=12$; the error is conservative and claim 10 survives it |
| 12 | $0.40347\to0.38673$, correction factor $1.04329$ | **PROVEN**, reproduced to six digits; but the numeral prices $(1-\eta^*)^2\sqrt{c_p+w^2}$, which is $18.78\times$ branch 2 itself |
| 13 | the $\tfrac29$ proviso "moves the factor to $1.0391$" | **GAP**, I get $1.0484$ from L149's own $0.689771$ and $1.0575$ from L149's displayed formula at coefficient $1$; $1.0391$ reproduces from neither |
| 14 | Form B (the canonical statement, [results.md](../results.md):367) | **BROKEN**, its $w^*=2\sqrt n/(n-8)$ carries $a_0=1$ *and* the $\tfrac29$-free $\rho$; its companion interior value carries $\rho=1$ instead; and it states branch 1 "increasing in $w$", which Form A refutes |
| 15 | scope: "at every $n$ up to $\approx1800$" | **HYPOTHESIS-DEBT**, $W^*=S^m\times S^m$ exists at even $n$ only, and L146's attainment clause "has no proof" at $m\ge7$, i.e. at every dimension of the extension |

**One line the round can act on.** The $n=12$ verdict is sound and its margin is a factor $4.3$; **the extension is not**, "$\approx1800$" is computed with the coefficient $1$ that [Lemma L149](../findings/second-order.md)'s repair replaced, and at every $n\ge18$ that coefficient runs the *unsafe* way, cutting the stopping dimension to $\approx1140$; the canonical [results.md](../results.md) sentence should be rewritten, since it still carries two constants this entry records as corrected.

**Verdict: `GAP`.**

## 0. Conventions, fixed once

All of the following are read off the record, at $n=2m$, and used unchanged below.

| symbol | closed form | value at $n=12$ |
|---|---|---|
| $\theta_0(n)$ | $\sqrt{2(n-1)(n-2)}/n$ | $\sqrt{55}/6=1.2360331$ |
| $c_p$ | $3\theta_0/(n-2)$ | $\sqrt{55}/\,\tfrac{20}{3}\;=0.3708099$ |
| $\kappa$ | $nc_p=3\sqrt{2(n-1)/(n-2)}$ | $3\sqrt{2.2}=4.4497191$ |
| $g_n$ | $\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}$, so $1/g_n=n^2c_p/6$ | $1/g_n=8.899438$ |
| $a_0$ | $\sqrt{2n/(n-2)}$, and $a_0n^{-1/2}=\sqrt{2/(n-2)}=1/\sqrt{m-1}$ | $1.5491933$, $0.4472136$ |
| $\lvert\kappa_n\rvert$ | $9(\theta_0(n)-\sqrt{3/2})$ | $0.1015947$ |
| $\lambda$ | $2/\sqrt{\lvert\kappa_n\rvert}$ | $6.2746859$ |
| $\rho^{\mathrm{eff}}_n$ | $3\theta_0\tfrac{n-8}{2(n-2)}-\tfrac29\lvert\kappa_n\rvert=2\sqrt{3/2}-\theta_0\tfrac{n+16}{2(n-2)}$ | $\sqrt6-\tfrac7{30}\sqrt{55}=0.7190434$ |
| $J^*$ | $\tfrac{8(m-1)(4m-3)}{(2m-1)^2}$, $\gamma^*=\tfrac{2m-1}{4(m-1)}$, $C^*=J^*\gamma^*=2+\tfrac{4(m-1)}{2m-1}$ | $\tfrac{840}{121}=6.9421488$, $0.55$, $\tfrac{42}{11}=3.8181818$ |
| $\phi(w)$ | $\min\big(a_0n^{-1/2}\sqrt{1-w^2}+w,\ 1\big)$, kink $w_0=\tfrac{n-4}n$ | $w_0=\tfrac23$ |
| $t$ | $\lambda\sqrt{c_p+\rho^{\mathrm{eff}}_nw^2}/(2J\gamma)=\lambda s/(2C^*)$ | $2C^*=7.6363636$ |
| $\eta^*$ | $1-\eta^*=2/(\sqrt{4t+1}+1)$ |, |
| $K$ | $\lambda(1-\eta^*)^2/(\sqrt2\,J)$ | see §5 |

Two identities are used repeatedly and are checked here. **First**, $\tfrac29\lvert\kappa_n\rvert=2(\theta_0-\sqrt{3/2})$, so $3\theta_0\tfrac{n-8}{2(n-2)}-\tfrac29\lvert\kappa_n\rvert=2\sqrt{3/2}+\theta_0\big[\tfrac{3(n-8)-4(n-2)}{2(n-2)}\big]=2\sqrt{3/2}-\theta_0\tfrac{n+16}{2(n-2)}$: [Lemma L149](../findings/second-order.md)'s form at line 1222 and [Lemma L158](../findings/second-order.md)'s form at line 1311 are **the same quantity**, and I confirm the entry's four tabulated values from it, $0.7190434$, $0.8723895$, $0.9856396$ and $1.0727376$ at $n=12,14,16,18$, each exact. **Second**, $\lvert\kappa_{12}\rvert=9(\sqrt{55}/6-\sqrt{3/2})=0.1015947$ and $\lvert\kappa_\infty\rvert=9(\sqrt2-\sqrt{3/2})=1.7052235$, giving $\lambda(12)=6.2746859$ and $\lambda(\infty)=1.5316546$, the entry's $6.275$ and $1.53$, both exact.

## 1. The hypothesis inventory

**Carried by the statement.** $W^*=S^m\times S^m$ at $n=2m$; $H$ in $T_{W^*}S\cap T_{W^*}\mathcal O^\perp$ with $\lVert H\rVert_F=1$; $w=\lVert H_r\rVert$ the weight outside **both** $S^2_0(\mathbb R^m)$ copies; $S=\sup\lvert P\rvert=\Theta(n^\beta)$ with $\beta\in[0,\tfrac12]$; $w\in[0,1]$.

**Imported, with the hypothesis each carries and whether the object meets it.**

| import | its hypothesis | met at $n=12$? | met over the extension? |
|---|---|---|---|
| [L149](../findings/second-order.md) chain and $\rho^{\mathrm{eff}}$ | $m\ge6$, L149 states that $m\ge5$ was overstated, since $\lvert\kappa_{10}\rvert<0$ leaves $\rho^{\mathrm{eff}}$ undefined | **yes**, $m=6$ exactly at the boundary | yes |
| [L149](../findings/second-order.md) | $\ker W^*=0$, else $W\mapsto W_-$ is not analytic and branches 2 and 3 have no domain | **yes**, gap $g_n=\sqrt{2(n-2)}/(n\sqrt{n-1})$ | yes |
| [L149](../findings/second-order.md) | the $\tfrac29$ penalty coefficient, recorded there as `HYPOTHESIS-DEBT`, owing the identification of the $(2,2)$ four-set block with $\Lambda^2\!\otimes\!\Lambda^2$ | **open** | **open** |
| [L146](../findings/second-order.md) | $\lVert H\rVert_{op}\le1/\sqrt{m-1}$ with the supremum **attained**; L146 records that at $m\ge7$ "that witness loses and the clause has no proof", one family reaching $m=8$ | **yes**, $m=6$ is the last dimension the clause covers | **no**, every $n\ge14$ of the extension sits at $m\ge7$ |
| [L146](../findings/second-order.md) | the margin sits on the two $S^2_0$ summands, for $m\ge5$ | yes | yes |
| [L156](../findings/second-order.md) | $0<\alpha<D$, $0<\gamma<\min(d,1)$, constants read at the dimension in hand; the $m=2$ endpoints $\tfrac{10}3,\tfrac{40}9$ out of scope | **yes**, and the entry catches r711 using the out-of-scope $\tfrac{40}9$ | yes |
| [L157](../findings/second-order.md) | $\eta=r/\rho$ along the whole segment; the crossing root; $t$'s definition | yes | yes |
| [L148](../findings/second-order.md) | the defect vanishes identically at $w=0$, so branch 2 is absent there | yes | yes |
| [L143](../findings/bounds.md), [L70](../findings/bounds.md) | $\sup\lvert P\rvert\le1+\sqrt{n-2}$; $\le n-2$ | yes, $4.1622780$ and $10$ | yes |
| parity | $W^*$ exists at **even** $n$ only ([results.md](../results.md):88) | yes | **unstated**, "every $n$ up to $\approx1800$" should read "every even $n$" |

**Which the written proof actually uses.** All of the above except the $m\ge7$ clause of L146 and the parity restriction, **neither of which is checked anywhere in the entry**. The $\tfrac29$ debt is named once, in a proviso, and its consequence priced at $1.0391$, a figure §7 could not reproduce. The entry additionally uses one thing no import supplies: the identification $J\gamma=C$, which it justifies by "L156 names both in one hypothesis", and that is correct, L156's $J=C/\gamma$ is definitional.

**No finding on one head.** The entry uses no hypothesis its statement omits at $n=12$; the omissions are confined to the extension.

## 2. Question 1, is the threshold a number or a range, and is it derived?

**It is a number at $n=12$, it is derived, and it is $\approx18$.** The page carries the number and a superseded range side by side.

The threshold on $S$ is $S^*=\inf_w b_1\cdot(\inf_w b_2)^{-1}\cdot S$, i.e. $S^*=c_p\big/\inf_w\big[K(w)\sqrt{c_p+\rho w^2}/(n\phi(w))\big]$. Evaluating at the settled minimiser $w_0=\tfrac23$, where $\phi=1$ exactly:

- $\rho=1$: $s=\sqrt{\tfrac{\sqrt{55}}{6}\cdot\tfrac3{10}+\tfrac49}=\sqrt{0.8152543}=0.9029142$; $t=\lambda s/(2C^*)=0.7419287$; $\sqrt{4t+1}=1.9919124$; $(1-\eta^*)^2=0.4468566$; $K=\lambda(1-\eta^*)^2/(\sqrt2J^*)=2.8039$ / $9.8179207=0.2856$; $\inf b_2=Ks/12=0.0214900$; **$S^*=c_p/\inf b_2=17.2573$.**
- $\rho=\rho^{\mathrm{eff}}_{12}$: $s=\sqrt{0.6903848}=0.8308940$; $t=0.6827723$; $\sqrt{4t+1}=1.9316$; $(1-\eta^*)^2=0.4654254$; $K=0.2974700$; $\inf b_2=0.0205977$; **$S^*=18.0025$.**

Both sit inside "$17$–$19$", so **the entry's pinned band is derived and reproduces**. The band is the spread between the pre- and post-repair coefficient on $w^2$, not an uncertainty; the current answer is the second, $18.00$.

**The four historical figures, each traced.**

- $3.98$–$4.44$ is $\sqrt{\kappa(1+\kappa)}$ divided by $\lambda(1-\eta^*)^2$ read at the **asymptotic** $\lambda=1.53$ with **no** $\sqrt2J$: $4.9243640/1.2419590=3.9650$ and $4.9243640/1.1075330=4.4462$. Both reproduce exactly, and the entry's own settled finding ("$J$ divides $K$"), refutes the reading that produced them.
- $\approx21$ is r711's, which the entry itself corrects: it read $J^*$ at the out-of-scope $m=2$ endpoint $\tfrac{40}9$ where $n=12$ gives $J^*=\tfrac{840}{121}$, and I confirm $2J^*=\tfrac{1680}{121}=13.8843$ against the $8.89$ used, a factor $\tfrac{189}{121}$ exactly as stated.
- $17$–$19$ reproduces, as above.
- **$52.92$ reproduces from nothing.** Sweeping $w$ across $[0,1]$ at $\lambda=1.53$ with $J^*=\tfrac{840}{121}$ gives $S^*$ between $38.93$ (at $w=0$) and $45.21$ (at $w=1$), and at $\lambda\to1.5317$, $J^*\to8$, $\kappa\to3\sqrt2$ the asymptotic value is $47.3$. Forcing $52.92$ needs $K=0.0930$, hence $\lambda(1-\eta^*)^2=1.3155$ with $\sqrt2J^*$, or $J=9.394$ at the entry's prefactor, neither is a constant on the record.

### Discrepancy D1, "the spread ... is one constant", and the factor quoted is the wrong one

**Located.** *"The spread between the two audits, $17$–$19$ against $52.92$, is one constant: $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ was evaluated at the $n\to\infty$ value ... So $\lambda(12)=6.275$, not $1.53$, a factor $4.1$."*

**Exhibited.** $\lambda$ enters $K$ twice and with opposite signs: directly, and inside $t$, where raising $t$ lowers $(1-\eta^*)^2$. At $w_0$ the two $\lambda$'s give $K=0.1165313$ and $K=0.2856000$, a ratio of $2.4509$; at $w=1$ the ratio is $2.2896$. So switching $\lambda$ moves the threshold by $2.29$–$2.45$, never by $4.1$; $52.92$ divided by $2.45$ is $21.6$, which lies **above** the band the same paragraph pins.

**The opposite reading.** The words say the *constant* differs by $4.1$, which is true, $6.2746859/1.5316546=4.0966$, and leave the induced move unquantified. Under that reading the sentence is literally correct and only its explanatory force fails. The entry itself supplies the honest figure three clauses later, "moving $2.3\times$ across the range", which I confirm as $2.2896$ at $w=1$. **Verdict `GAP`**: the two figures in one paragraph are $4.1$ and $2.3$ for the same effect, and the larger is the one offered as the explanation.

### Discrepancy D2, the displayed threshold identity carries $a_0=1$, which the same entry lists as an error

**Located.** $$\frac{\inf_w\text{branch }1}{\inf_w\text{branch }2}=\frac{\sqrt{\kappa(1+\kappa)}}{S\cdot K}.$$

**Exhibited.** [Lemma L149](../findings/second-order.md)'s own proof of uniformity gives the unconstrained infimum in closed form, $\inf_{w\ge0}g_\rho=\tfrac1n\sqrt{\tfrac{\rho\kappa}{\rho a_0^2+\kappa}}$, whence
$$\frac{\inf b_1}{\inf b_2}=\frac1{SK}\sqrt{\frac{\kappa(\rho a_0^2+\kappa)}{\rho}} .$$
The displayed form is this at $a_0=1$ **and** $\rho=1$. With the record's $a_0^2=2n/(n-2)=2.4$ and $\rho^{\mathrm{eff}}_{12}$ the numerator is $\sqrt{4.4497191\times6.1754239/0.7190434}=\sqrt{38.2147}=6.1818$ against the displayed $\sqrt{24.24936}=4.9243640$, **larger by $1.2553$**. And $a_0=1$ is the first of the "four constants the entry had wrong" that this same entry corrects in prose: *"$a_0=\sqrt{2n/(n-2)}=1.549$ at $n=12$ and is $n$-dependent, not $1$."*

**The opposite reading, and it is partly right.** L158 works with a **tighter** envelope than L149 ($\min(a_0n^{-1/2}\sqrt{1-w^2}+w,1)$ rather than $a_0n^{-1/2}+w$), under which the infimum sits at the kink and is not the closed form above. Evaluated that way the threshold is $17.2573$ at $\rho=1$, and the displayed identity returns $4.9243640/0.2856000=17.2422$: the two agree to $0.09\%$ at $n=12$. That agreement is a coincidence of this dimension, because $\sqrt{\kappa/(1+\kappa)}=0.9036060$ happens to sit within $0.08\%$ of $\sqrt{c_p+w_0^2}=0.9029142$ at $n=12$; at $n=18$ the same pair reads $0.9021610$ against $0.9444056$, a $4.7\%$ split, and the gap grows. **Verdict `BROKEN` for the display, harmless at $n=12$ and load-bearing wherever the entry uses it $n$-freely**, which is precisely the extension of §4.

## 3. Quantifier order and scope

**No finding on the head the brief flags.** The identity $\inf_w\min(f,g)=\min(\inf_wf,\inf_wg)$ **is true**, and here is the proof the entry does not give: $\min(f,g)\le f$ pointwise gives $\inf\min\le\inf f$ and likewise $\le\inf g$, so $\inf\min\le\min(\inf f,\inf g)$; and $\min(f(w),g(w))\ge\min(\inf f,\inf g)$ for every $w$ gives the reverse. So comparing separately-taken infima is legitimate, and the branches need **not** be compared at a common $w$, the entry's justification is sound and the suspicion the brief raises does not apply.

**Free, optimised, and quantified.** $n$ and $S$ are free; $w$ is optimised over $[0,1]$; $u$ (the defect's linear rate), is a **second** variable, related to $w$ only by $u\le w$, and it is optimised inside branch 1 alone. The entry's $\min$ is distributed across two branches that share $w$, which the identity licenses; it does **not** distribute across $u$ and $w$ jointly, and it does not need to.

### Discrepancy D3, branch 1's infimum is refuted by the entry and then used by it

**Located.** Two sentences, both inside Form A. Opening: *"branch 1 $=(c_p+w^2)/S$ is increasing in $w$ with infimum $\kappa/(nS)$."* Later: *"Branch 1 is not $(c_p+w^2)/S$: the chain's own form is $f(u)=(c_p+u^2)/(S+au)$ with $f'(0)<0$ ..., so its infimum is **strictly below** $\kappa/(nS)$ and does not sit at $u=0$."*

**Exhibited.** $f(u)=(c_p+u^2)/(S+au)$ is stationary where $au^2+2Su-ac_p=0$, i.e. at $u^*=(\sqrt{S^2+a^2c_p}-S)/a>0$, with $f(u^*)<f(0)=c_p/S$ strictly whenever $a>0$. Every threshold on the page ($17$–$19$, $s^*\approx15$, and the $n\approx1800$ extension), is computed from $\inf b_1=c_p/S$. Lowering $\inf b_1$ lowers the threshold, so branch 1 binds at a **smaller** $S$ than the entry states: the error runs against the entry's conclusion. It cannot be sized here, because $a$ is nowhere pinned, L157 gives only $a\propto(1-\eta)^{-2}$.

**The opposite reading.** [ROUND_L147](ROUND_L147.md) is cited in L149 for the statement that "the two infima bracket within a bounded factor, so the correction is a constant and not an order", so the order-level claims are untouched, and the $n=12$ verdict has a factor-$4.3$ margin that a bounded constant plausibly survives. But "plausibly survives" is not the record: **`HYPOTHESIS-DEBT` on the constant**, what is owed is a numerical bound on $\inf_uf/f(0)$, without which no threshold on this page is a proved number.

## 4. Question 2, does "branch 2 binds" survive its own corrections?

**At $n=12$, yes, decisively. Beyond $n=16$, the extension does not survive.**

**At $n=12$.** $S\le1+\sqrt{10}=4.1622780$ against a threshold of $18.0025$: a factor $4.3$. The three corrections found in this report all widen it, D2 raises the threshold by $1.2553$, the $\rho^{\mathrm{eff}}$ repair raises it from $17.26$ to $18.00$, and D3 is the only one that narrows it, by a bounded constant. Claim 7 stands.

### Discrepancy D4, the extension to $n\approx1800$ is computed at the coefficient the repair replaced, and there that coefficient is unsafe

**Located.** *"branch 2 binds, and provably so at every $n$ up to $\approx1800$"*, beside *"the defect is confined to $n\in\{12,14,16\}$, $\rho^{\mathrm{eff}}_n$ is $0.7190$, $0.8724$, $0.9856$, then $1.0727$ at $n=18$, **from which the coefficient $1$ is valid and merely loose**"*, and *"this entry's verdict that branch 2 binds, **which the repair strengthens**, since lowering branch 2 makes it bind more surely."*

**Exhibited, in closed form.** $\rho^{\mathrm{eff}}_n=2\sqrt{3/2}-\theta_0(n)\tfrac{n+16}{2(n-2)}$ is increasing, exceeds $1$ from $n=18$, and rises to $\tfrac32\sqrt2-2(\sqrt2-\sqrt{3/2})=1.7423829$. Branch 2 is proportional to $\sqrt{c_p+\rho w^2}$, so at $n\ge18$ the coefficient $1$ makes branch 2 **smaller** than the repaired chain does. "Branch 2 binds" is the assertion $\inf b_2<\inf b_1$; proving it from an *understated* $b_2$ proves nothing about the true $b_2$. So the sentence "the coefficient $1$ is valid and merely loose" is exactly inverted for this use: loose in the direction that makes the conclusion easier to reach.

Carrying it through at $n=1800$, every constant evaluated at that dimension: $\theta_0=1.4130350$, $\kappa=4.2438050$, $c_p=0.0023577$, $\lvert\kappa_n\rvert=1.6946109$, $\lambda=1.5363773$, $m=900$ so $C^*=2+\tfrac{3596}{1799}=3.9988883$ and $J^*=\tfrac{8\cdot899\cdot3597}{1799^2}=7.9927$, $\rho^{\mathrm{eff}}=1.7359003$, $w_0=0.9977778$. Then $s=\sqrt{1.7305486}=1.3155031$, $t=0.2527085$, $\sqrt{4t+1}=1.4180388$, $(1-\eta^*)^2=0.6842477$, $K=0.0930000$, $\inf b_2=Ks/n=6.79677\times10^{-5}$, and
$$S^*(1800)=\frac{c_p}{\inf b_2}=34.688\qquad\text{against}\qquad 1+\sqrt{1798}=43.403 .$$
**Branch 2 does not provably bind at $n=1800$.** Repeating at $n=1150$ gives $S^*=34.682$ against $1+\sqrt{1148}=34.882$, the crossing sits at $n\approx1140$, and $S^*$ is flat to four digits across that range.

**Where $1800$ comes from.** Setting $\rho=1$ instead, the same evaluation at large $n$ gives $s\to1$, $t\to\lambda/(2C^*)=0.19210$, $(1-\eta^*)^2\to0.736921$, $K\to0.100152$ and $S^*\to\kappa/K=42.374$, whence $1+\sqrt{n-2}=42.374$ at $n=1714$. **So $\approx1800$ is the coefficient-$1$ answer**, reached with the very constant the paragraph above it repairs.

**The opposite reading.** "$\approx1800$" is stated as an upper reach, not a sharp crossing, so a reader might grant slack; and $\rho^{\mathrm{eff}}$ was introduced by [ROUND_L157](ROUND_L157.md) D6 as a correction *at $n=12$*, where it is a $4.33\%$ improvement, so extending it to $n=1800$ could be read as outside that finding's scope. Neither rescues the sentence: the finding's own scope note ("from $n=18$ the coefficient $1$ is valid"), is precisely the claim that fails, and $34.688$ against $43.403$ is not slack but a sign change. **Verdict `REFUTED` for the numeral, and `BROKEN` for "which the repair strengthens" as a global statement.**

**What this costs downstream, and it is nothing yet.** [plan.md](../plan.md):116 consumes the claim as *"it stays binding to $n\approx1800$ ... so $S$ does not enter the radius at any dimension this programme evaluates."* The corrected stopping dimension $\approx1140$ is still far above every dimension the programme evaluates, $n\in\{12,\dots,20\}$, so **I31's disposition is unaffected** and only the numeral needs replacing. This is the one place where §"gap between proven and used" returns a clean answer: the entry supplies more than downstream consumes, even after the correction.

### Discrepancy D5, the extension is stated at a generality two imports do not reach

**Located.** *"provably so at every $n$ up to $\approx1800$."*

**Exhibited.** $W^*=S^{n/2}\times S^{n/2}$ exists at **even** $n$ only ([results.md](../results.md):88, where the odd analogue is a different point with a different threshold), so "every $n$" over-claims by half the integers. And [Lemma L146](../findings/second-order.md) records of its own attainment clause: *"the even split is beaten only up to $m=6$, the spike witness winning exactly when $m^2-8m+8<0$; at $m\ge7$ that witness loses and **the clause has no proof**, though a different family reaches $m=8$."* Branch 2's denominator is the *attained* envelope; without attainment the record has an upper bound on $\lVert H\rVert_{op}$ only, which makes branch 2 a lower bound and leaves "branch 2 binds" unproved. Every dimension of the extension has $m\ge7$.

**The opposite reading.** L146 adds "both bounds are $\Theta(n^{-1})$, so the order is untouched either way", and the extension is an order-free numerical claim about which of two lower bounds is smaller, for which a valid upper bound on $\lVert H\rVert_{op}$ arguably suffices, since it is the envelope that the minimisation uses. That is the charitable reading and it is defensible; what it is not is stated. **Verdict `HYPOTHESIS-DEBT`**: what is owed is one line saying which of L146's two clauses branch 2 consumes, and the parity qualifier.

## 5. Question 1's other half, the title, and the edge of every range

### The crossover $n=6+2\sqrt7$, which is where the title fails

The entry's $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ is built on $\lvert\kappa_n\rvert=9(\theta_0(n)-\sqrt{3/2})$, the defect-penalty constant pinned by equality at the $\mathbb{CP}^2$-type competitor ([results.md](../results.md):667). **That constant is zero exactly at $n=6+2\sqrt7$**, the crossover, since that is where $\theta_0(n)=\sqrt{3/2}$. Hence $\lambda\to+\infty$ as $n\downarrow6+2\sqrt7\approx11.2915$, and $n=12$ is the first admissible dimension above it, which is *why* $\lvert\kappa_{12}\rvert=0.1016$ is two orders below its limit $1.7052$ and $\lambda(12)=6.275$ is four times its limit. A ratio one of whose constants diverges at $11.29$ and moves by $2.3\times$ between $n=12$ and $n=\infty$ is not $n$-free. The entry concedes this in one clause (*"it is the largest $n$-dependence in a ratio this entry's title calls $n$-free"*) and then keeps the title, keeps "the threshold is **pinned**", and extends both to $n\approx1800$. **Claim 4 `BROKEN` as a title; the honest statement is that the threshold rises from $18.0$ at $n=12$ to $\approx34.7$ asymptotically.**

L149's stated floor $m\ge6$ is the same edge seen from the other side: at $n=10$, $\theta_0=\tfrac65<\sqrt{3/2}$, $\lvert\kappa_n\rvert$ is negative and $\rho^{\mathrm{eff}}$ has no definition. **The entry never states the lower edge**; L149 does, and L158 inherits it silently.

### $w$ at both ends

At $w=1$ the envelope equals exactly $1$: $a_0n^{-1/2}\sqrt{1-1}+1=1$, and the $\min$ is attained by both arms. **Confirmed.** At $w=0$, [Lemma L148](../findings/second-order.md) empties branch 2 identically, so $\min(b_1,b_2)(0)=b_1(0)$ and the $\S3$ identity holds with $b_2(0)=+\infty$; since $\inf b_2$ sits at $w_0=\tfrac23$, removing $w=0$ leaves it unchanged, and the entry's withdrawal of its own caveat (*"L148 changes where the infimum is attained, not its value"*), is **correct**. One consequence the entry does not draw: its uniform bound $\tfrac1s\tfrac{N'}N\le0.4019$ is evaluated with $\sqrt{4t_{\min}+1}$ taken **at $w=0$**, the excluded direction. That is benign, a supremum over a larger set, and I record it as a `no finding`.

### $\ker W\ne0$ and the named witness $W_{\mathbb{CP}^2}$, $\dim\ker W=3$

**The entry asserts nothing about kernels, and the omission is not neutral.** Its domain is $W^*=S^m\times S^m$, where L149 checks $\ker W^*=0$ and finds it holds with gap $g_n$; the kernel witness lives on a different orbit and is out of the tube. **But it enters through the back door**: $\lvert\kappa_n\rvert$ is *defined* by equality at the $\mathbb{CP}^2$-type competitor, so $\lambda$, the single largest constant in the threshold, and the whole of the $17$–$19$/$52.92$ dispute, is a number about $W_{\mathbb{CP}^2}$. The entry treats $\lambda$ as a scalar with a value and never says what it is a constant *of*. `no finding` as a defect in the mathematics; recorded because a reader tracking the record's recurring kernel obstruction will not find this dependency by reading L158.

### The smallest admissible dimension

$n=12$, $m=6$. Every import is met **at its boundary** there: L149's $m\ge6$ exactly, L146's attainment clause at its last dimension $m=6$, L156's constants at the first dimension above its out-of-scope endpoint. The entry never remarks that its one worked dimension is simultaneously the extreme point of three separate hypotheses.

## 6. The minimiser, and the numerals around it

**Claim 10 is `PROVEN`, and I supply the elasticity identity in full**, since the entry displays it without proof. Write $u=\sqrt{4t+1}$, $t=\beta s$, $N\propto(1-\eta^*)^2s=4s/(u+1)^2$. Then $\tfrac{\mathrm du}{\mathrm ds}=2\beta/u$ and $\tfrac{\mathrm d\log(u+1)}{\mathrm d\log s}=\tfrac{s}{u+1}\cdot\tfrac{2\beta}u=\tfrac{2t}{u(u+1)}$; and $4t=u^2-1$ gives $2t=\tfrac{(u-1)(u+1)}2$, so that quantity is $\tfrac{u-1}{2u}$ and
$$\frac{\mathrm d\log N}{\mathrm d\log s}=1-2\cdot\frac{u-1}{2u}=\frac1u=\frac1{\sqrt{4t+1}}\in(0,1).\qquad\square$$
Above $w_0$ the envelope is constant, so $b_2$ strictly rises; below it, $\phi$ is strictly increasing and $\phi\le1$, and the AM–GM bound $\tfrac{\rho w}{c_p+\rho w^2}\le\tfrac{\sqrt\rho}{2\sqrt{c_p}}$ with $u\ge u(0)$ gives $\tfrac{\mathrm d\log N}{\mathrm dw}\le\tfrac{\sqrt\rho}{2\sqrt{c_p}\,u(0)}$. At $n=12$: $\tfrac{\sqrt{0.7190434}}{2\sqrt{0.3708099}}=\tfrac{0.8479643}{1.2178832}=0.6962583$, $t(0)=\lambda\sqrt{c_p}/(2C^*)=0.5004040$, $u(0)=\sqrt{3.0016160}=1.7325173$, quotient **$0.4018772$**, the entry's $0.4019$, exact. So $w_0$ is a strict two-sided minimum. **Confirmed.**

### Discrepancy D6, $\phi'(w_0)=\tfrac35$ is refuted

**Located.** *"below it the envelope's slope is $\phi'(w_0)=\tfrac35$ exactly against $\tfrac1s\tfrac{N'}N\le\ldots=0.4019$ uniformly."*

**Exhibited in closed form.** With $b=a_0n^{-1/2}=\sqrt{2/(n-2)}$ and $\phi=b\sqrt{1-w^2}+w$, $\phi'(w)=1-\tfrac{b^2w}{\sqrt{1-w^2}}$. The kink relation $b\sqrt{1-w_0^2}=1-w_0$ turns this into $\phi'(w_0)=1-\tfrac{bw_0}{1+w_0}=1-\dfrac{n-4}{\sqrt2\,(n-2)^{3/2}}$. At $n=12$ that is $1-\tfrac8{20\sqrt5}=1-\tfrac{2\sqrt5}{25}=\mathbf{0.8211146}$. The slip is one substitution: replacing $\sqrt{1-w_0^2}=\tfrac{\sqrt5}3$ by $1-w_0=\tfrac13$ gives $1-\tfrac{0.2\cdot\tfrac23}{\tfrac13}=1-0.4=\tfrac35$ exactly, which is how the figure arose.

**The opposite reading.** $\tfrac35$ is quoted only as a lower barrier to be compared with $0.4019$, and $0.8211>0.6>0.4019$, so the inequality it is used for holds *a fortiori* and claim 10 is untouched. Moreover $\phi'$ is decreasing on $[0,w_0]$ with minimum $0.8211$ at $w_0$, so the bound holds uniformly on the whole interval with room to spare. **Verdict `REFUTED` as a numeral, conservative in direction, with no consequence beyond the record's accuracy.** The exact value has a closed form worth carrying: $\phi'(w_0)=1-\tfrac{n-4}{\sqrt2(n-2)^{3/2}}$, which is never below $0.8075$ at any $n$, since $\max_{w\in[0,1]}\tfrac{w\sqrt{1-w}}{(1+w)^{3/2}}<0.1925$.

### Discrepancy D7, the branch-2 numeral prices a different quantity from branch 2

**Located.** *"the minimum was recorded as $0.40347$ at $w_0=\tfrac23$ ... the corrected minimum is $0.38673$."*

**Exhibited.** $0.40347=(1-\eta^*)^2\sqrt{c_p+w_0^2}=0.4468566\times0.9029142=0.4034787$ at $\lambda(12)$, and $0.38673=0.4654254\times0.8308940=0.3867200$ under $\rho^{\mathrm{eff}}$. Branch 2 itself, as the entry displays it, is $K\sqrt{c_p+\rho w^2}/(n\phi)$, whose minimum is $0.0214900$ and $0.0205977$ respectively, smaller by $n\sqrt2J^*/\lambda=18.7754$. The word "minimum" therefore attaches to a quantity that is branch 2 stripped of $\lambda/(\sqrt2J^*n)$. [Lemma L149](../findings/second-order.md) records exactly this hazard against its own $0.71979$, *"the numeral prices $g_\rho$, not branch 2 ... and must not be read as a branch-2 floor, least of all where L158 compares branch infima as a ratio"*, and the entry then does the same thing with a third normalisation.

**The opposite reading.** Everything the numeral is *used* for is a ratio: $1.04329$, $4.9\%$, $27.8\%$, $19.4\%$, all normalisation-free, all of which I reproduce. So no conclusion turns on it. **Verdict `GAP`, labelling only**: three quantities on this page are called the branch-2 minimum ($0.71979/n$, $0.40347$, $0.02149$) and differ by factors of $18.8$ and $2.7$.

**Reproduced exactly, in support of the corrected numeral.** $F_1/F_\rho=\tfrac{N_1}{N_\rho}\big(\tfrac{s_\rho+1}{s_1+1}\big)^2$ with $N_1/N_\rho=0.9029142/0.8308940=1.0866710$ (the entry's $8.667\%$ inflation of $t$, exact), $t_\rho=0.6827723$, $\sqrt{4t_\rho+1}=1.9315938$, and $\big(\tfrac{2.9315938}{2.9919124}\big)^2=0.9600766$: the product is **$1.0432900$**, the entry's $1.04329$ to six digits, and $0.4034787/1.0432900=0.3867273$. Claim 12 confirmed. The elasticity remark is confirmed too: $1/u\approx0.502$ damps $8.667\%$ to $4.33\%$.

### Candidate withdrawn, "the 4.9% compares an enveloped value with an unenveloped one"

I formed the candidate that $0.40347$ (at $w_0$, where $\phi=1$) and $0.38468$ (at $w=0.5528$) are values of different functionals, since the homogeneous envelope at $0.5528$ is $0.9254740$, not $1$. **Withdrawn.** $0.5528=1-1/\sqrt5$ is the kink of the *triangle* envelope $\sqrt{2/(n-2)}+w$, where that envelope equals exactly $1$; the two numerals are each their own envelope's kink value, so the comparison is like-for-like and the $4.9\%$ measures exactly what the entry says, the gain from replacing the triangle envelope by the homogeneous one, which is never larger. $0.4034787/0.3846680=1.0488$. **Reason for withdrawal: the "exhibit concretely" step showed the objection false, not merely unproven.**

For completeness, the two comparison figures reproduce as well: r714's endpoint value is $G(1)/(1+a_0n^{-1/2})=0.4568050/1.4472136=0.3156480$, and $0.4034787/0.3156480=1.27825$ and its asymptotic-$\lambda$ counterpart $0.6751733/0.5654690=1.19393$ are the entry's $27.8\%$ and $19.4\%$, both exact.

### Discrepancy D8, the $\tfrac29$ proviso's figure $1.0391$

**Located.** *"One proviso: L149's open $\tfrac29$ debt moves the factor to $1.0391$ if it resolves the other way."*

**Exhibited.** L149's alternative reading is stated there as *"at coefficient $1$ the constant reads $0.689771$."* Running the same $F_1/F_\rho$ machinery at $\rho=0.689771$: $s_\rho=\sqrt{0.6773748}=0.8230278$, $N_1/N_\rho=1.0970600$, $t_\rho=0.6762430$, $\sqrt{4t_\rho+1}=1.9248310$, $\big(\tfrac{2.9248310}{2.9919124}\big)^2=0.9556561$, product $=\mathbf{1.0484}$. And L149's own displayed formula at coefficient $1$ gives $\rho=3\theta_0\cdot\tfrac15-\lvert\kappa_{12}\rvert=0.7416199-0.1015947=0.6400252$, not $0.689771$, from which the same machinery returns $\mathbf{1.0575}$. **Neither is $1.0391$.**

**The opposite reading.** The proviso is a sensitivity note, flagged as conditional on an open debt, and $1.0391$ against $1.0484$ shifts the corrected minimum by under $1\%$, immaterial to every conclusion. **Verdict `GAP`, inherited**: the discrepancy is traceable to L149, where $0.689771$ and its stated floor $0.582938$ are jointly inconsistent with the displayed $3\theta_0\tfrac{n-8}{2(n-2)}-c\lvert\kappa_n\rvert$ at any single $c$, $0.689771$ needs $c=0.5104$ and $0.582938$ needs $c=0.902$ in the limit. That is L149's round to settle; L158 imports the figure without checking it.

## 7. The two forms

**Form A is [findings/second-order.md](../findings/second-order.md) lines 1272–1329 with provenance stripped, and one mathematical paragraph removed. Form B is [results.md](../results.md) line 367 verbatim.**

### Difference 1, the brief's Form A drops a paragraph the source carries

The source closes with *"**A $w$-dependence the entry ignored.** $K$ is not constant: L157's $t$ depends on $w$, so $\lambda(1-\eta^*)^2$ ranges over $[1.24,1.53]$, and the entry used the $w=1$ value at an interior minimiser."* The brief replaces it with a blank line. Every other difference between the two texts is a review id or a Gate-2 line. Under the brief's own standard (*"provenance stripped, mathematics verbatim"*), this is a mathematics omission, and it removes the one paragraph a verifier would use to cross-check the prefactor.

**And the paragraph is itself wrong**, which is why its removal matters twice. $(1-\eta^*)^2$ is decreasing in $t$ and $t$ increasing in $w$, so $\lambda(1-\eta^*)^2$ is largest at $w=0$. At $\lambda=1.53$, $2C^*=7.6363636$: at $w=0$ it is $1.5300\times0.8117380=1.2419591$; at $w=1$, $1.5300\times0.6989580=1.0694057$. The range over $w\in[0,1]$ is $[1.069,1.242]$, so **$1.24$ is the $w=0$ value, not the $w=1$ value**, and $1.53$ is the unattained $t\to0$ limit. Form A's mid-entry statement, *"the prefactor $1.24$ is its $w=0$ value ...; at the minimiser it is $1.1075$"*, is the correct one, and I confirm both figures exactly ($1.5300\times0.7238780=1.1075333$ at $w=0.8291562$, and $1.2419591/1.1075333=1.1214$, the entry's $12\%$ overstatement). The dropped paragraph contradicts it on both counts.

### Difference 2, Form B carries constants Form A records as corrected, and is inconsistent within one clause

Form B states: *"its stationary point $w^*=2\sqrt n/(n-8)$ lies outside $[0,1]$ for every $n<16$ ..., so the infimum is not the interior value $n^{-1}\sqrt{\kappa/(1+\kappa)}$."*

**Both quantities are identified exactly, and each carries a different superseded constant.** The stationary point of $\sqrt{c_p+\rho w^2}\big/\big(a_0n^{1/2}+nw\big)$ is $w^*=\kappa/(\rho\,a_0\sqrt n)$. Then:

| $a_0$ used | $\rho$ used | $w^*$ | value at $n=12$ | exits $[0,1]$ at |
|---|---|---|---|---|
| $1$ | $3\theta_0\tfrac{n-8}{2(n-2)}$ (no $\tfrac29$) | $\dfrac{2\sqrt n}{n-8}$ | $\sqrt3=1.7320508$ | $n=16$ |
| $1$ | $1$ | $\kappa n^{-1/2}$ | $1.2845968$ | $n=19.055$ |
| $\sqrt{2n/(n-2)}$ | $1$ | $3\sqrt{n-1}/n$ | $0.8291562$ | $n=7.854$ |
| $\sqrt{2n/(n-2)}$ | $\rho^{\mathrm{eff}}_n$ | $\dfrac{3\sqrt{n-1}}{n\,\rho^{\mathrm{eff}}_n}$ | $1.1531630$ | $n=14$ |

Row 1 is Form B's, and it reproduces exactly, including its stated exit at $n=16$, since $2\sqrt n=n-8$ gives $n^2-20n+64=0$, $n=16$. **It uses $a_0=1$, which Form A lists first among the "four constants the entry had wrong", together with the $\tfrac29$-free $\rho$, which L149 carries with the penalty.** Row 2 is the entry's own superseded value, and Form A's *"$w^*=\kappa n^{-1/2}$ exceeds $1$ for every $n\le19$"* is exact, $\kappa^2=n$ gives $n^2-20n+18=0$, $n=10+\sqrt{82}=19.0554$. Row 4 is the current one: the stationary point leaves $[0,1]$ at $n=14$, not $n=16$.

**And Form B's own clause is internally inconsistent.** Its companion value $n^{-1}\sqrt{\kappa/(1+\kappa)}$ is L149's closed form $\tfrac1n\sqrt{\tfrac{\rho\kappa}{\rho a_0^2+\kappa}}$ at $a_0=1$ **and $\rho=1$**, whereas the $w^*$ five words earlier is at $a_0=1$ and $\rho=3\theta_0\tfrac{n-8}{2(n-2)}$. **One sentence, two different $\rho$.** With the record's constants the interior value is $\tfrac1n\sqrt{\tfrac{\rho\kappa}{\rho a_0^2+\kappa}}=\tfrac1n\times0.7197978$ at $n=12$, L149's own $0.71979$, against Form B's $\tfrac1n\times0.9036060$.

### Difference 3, Form B states as canonical the branch-1 form Form A refutes

Form B opens *"branch 1 is increasing in $w$ with infimum $\kappa/(nS)$"* with no qualification. Form A devotes a headed paragraph to refuting exactly that: *"Branch 1 is not $(c_p+w^2)/S$ ... its infimum is strictly below $\kappa/(nS)$ and does not sit at $u=0$."* **The canonical statement in [results.md](../results.md) is the pre-correction one.**

### Difference 4, Form B keeps the threshold as an open dispute

Form B closes: *"The threshold's value is disputed between the two audits, $21$ against $3.98$, according to whether L156's $2J^*$ enters the branch-2 prefactor."* Form A settles that question under a Gate-2 heading (*"$J$ divides $K$"*) and pins $17$–$19$. **Form B therefore records as open the question Form A closes**, and Form A itself keeps the closing "the gap is whether $2J^*$ enters the branch-2 prefactor $K$, and settling it is the next task on this item" beside the paragraph that settles it. Answering the round's pre-registered question directly: **the page carries a number, a range, and an open dispute about the same quantity, in that order, with nothing marking the earlier two superseded.**

## 8. What would falsify the statement, and what I did to look for it

**The object that would break the $n=12$ verdict** is a direction $H$ in $T_{W^*}S\cap T_{W^*}\mathcal O^\perp$, $\lVert H\rVert_F=1$, at which $\inf_u(c_p+u^2)/(S+au)$ falls below $K\sqrt{c_p+\rho^{\mathrm{eff}}_{12}w^2}/(12\phi(w))=0.0205977$ with $S\le4.1622780$, equivalently, a value of the unpinned coupling $a$ making $\inf_uf/f(0)$ smaller than $4.1622780/18.0025=0.2312$. I looked for it by solving the branch-1 minimisation in closed form, $u^*=(\sqrt{S^2+a^2c_p}-S)/a$, and found the record pins no value of $a$ at all, D3. A factor of $4.3$ is a wide margin for a bounded constant to cross, so this is the one object that could still overturn claim 7, and the record cannot rule it out.

**The parameter value that breaks the extension** is any even $n\ge1140$, and I exhibited $n=1800$ in closed form in D4: $S^*(1800)=34.688<1+\sqrt{1798}=43.403$. I looked for the crossing by evaluating $S^*$ at $n=1150$ and $n=1800$ and finding it flat to four digits, so the crossing is where $1+\sqrt{n-2}$ meets $34.68$.

**The dimension that breaks the title** is $n\downarrow6+2\sqrt7$, where $\lvert\kappa_n\rvert\to0$ and $\lambda\to\infty$; the record's own floor $m\ge6$ keeps the argument off that point by exactly one admissible dimension, and I found the floor stated in L149 and unstated in L158.

**What I did not do.** No script was run and no sweep performed, in accordance with the standing analysis-only rule; the screening allowance was not used, since every value here is a closed-form hand evaluation and none is offered as evidence for a positive claim beyond what its derivation shows.

## Verdict

**`GAP`.** The mechanism is sound, the $\inf\min$ identity is a true identity, the elasticity identity is correct as displayed, the minimiser $w_0=\tfrac{n-4}n$ is a strict minimum with a correct two-sided argument, the $\rho^{\mathrm{eff}}$ repair reproduces to six digits, and **branch 2 binds at $n=12$ with a factor-$4.3$ margin that every correction found here widens**. Against that: the threshold display is the $a_0=1$, $\rho=1$ form and agrees with the truth only by a coincidence local to $n=12$; the extension to $n\approx1800$ is computed at the coefficient the entry's own repair replaced, in the unsafe direction, and stops at $n\approx1140$; the title's $n$-freeness is refuted by a constant that diverges at the crossover; $\phi'(w_0)=\tfrac35$, $52.92$ and $1.0391$ do not reproduce; and the canonical statement in [results.md](../results.md) still carries three superseded readings. Downstream, [I31](../plan.md)'s disposition survives all of it unchanged.
