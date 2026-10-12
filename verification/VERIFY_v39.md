# VERIFY v39, L158: is the branch-comparison threshold a number, does "branch 2 binds" reach $n\approx1800$, and do the two forms agree?

**Cold brief, analysis only.** No script was run and no numerical work was done: every figure below is an exact hand evaluation from the constants the entry itself names, and each is marked with the closed form it came from. Sources read at source: [second-order.md](../findings/second-order.md) (L146, L148, L149, L156, L157, L158), [results.md](../results.md) (L70, L71, L133, canonical L158), [bounds.md](../findings/bounds.md) (L143), [plan.md](../plan.md) (I31). Log: [agent_logs/verify-L158-v39.log](../agent_logs/verify-L158-v39.log).

## Claim table

| # | Claim as written | Verdict |
|---|---|---|
| 1 | "the branch comparison is $n$-free" (the title, in both forms) | **REFUTED, by the entry's own body** |
| 2 | Branch 2 binds at $n=12$; $S=\sup\lvert P\rvert$ and hence I31 are not load-bearing there | **PROVEN at $n=12$**, conditional on the imported $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$; robust across the whole admissible constant box |
| 3 | "the threshold is pinned at $\approx17$–$19$ at $n=12$" | **DERIVABLE, AND I DERIVE IT, but it is a number, not a range**: $T(12)=17.26$ at $\rho=1$, $18.00$ at $\rho^{\text{eff}}$. The band is $J^*$ run to its $m\to\infty$ endpoint |
| 4 | "provably so at every $n$ up to $\approx1800$" | **HYPOTHESIS-DEBT, no argument on the page.** Reconstructible as $n^*=2+(T_\infty-1)^2$, $T_\infty\approx42.5$, giving $1724$; the reconstruction uses exactly the $n$-dependence claim 1 denies |
| 5 | The minimiser is the kink $w_0=(n-4)/n$, "a strict minimum across the whole of $[0,1]$" | **PROVEN at $n=12$; the sufficient condition provably fails as $n\to\infty$** |
| 6 | The corrected branch-2 minimum $0.38673$ (from $0.40347$, factor $1.04329$) | **CONFIRMED to five digits**, but the numeral is $(1-\eta^*)^2\sqrt{c_p+\rho w_0^2}$, not branch 2 and not $n\cdot$branch 2 |
| 7 | "this entry's own kink understated the minimum by $4.9\%$ … $0.38468$ at the entry's $0.5528$" | **BROKEN, the comparand omits the envelope**; restored, $w_0$ is the minimum and the charge reverses |
| 8 | "the improvement over the endpoint is $27.8\%$ at $\lambda(12)$ and $19.4\%$ at the asymptotic $\lambda$" | **REFUTED in closed form**, the entry's own elasticity forces the ordering the other way; I obtain $13.2\%$ and $21.2\%$ |
| 9 | The prefactor is $1.24$ at $w=0$ and $1.1075$ at the minimiser | **RIGHT ARITHMETIC, SUPERSEDED CONSTANT**, both are exact at $\lambda=1.53$, the $n\to\infty$ value the same entry refutes; at $\lambda(12)$ the $w=0$ value is $3.36$ |
| 10 | The displayed branch 2, $\dots/\big(n\min(\cdot)\big)$ | **GAP**, it carries $g_n=\sqrt2/n$, the asymptotic gap the entry itself prices as $4.9\%$ low "in the unsafe direction"; exactly $\sqrt{(n-1)/(n-2)}$ |
| 11 | $\inf_w\min(f,g)=\min(\inf f,\inf g)$, so comparing separate infima is sound | **NO FINDING, correct**, and L148's $w=0$ objection is rightly withdrawn |
| 12 | Branch 1's infimum is $\kappa/(nS)$ (used in the ratio), while the same entry says the true infimum is strictly below it | **GAP, unquantified, but inert at $n=12$** for any $a<45$ |
| 13 | Form A against Form B | **BROKEN, they contradict on the threshold**, and Form B's $w^*=2\sqrt n/(n-8)$ reproduces from no envelope on the record |
| 14 | $\rho^{\text{eff}}_n=2\sqrt{3/2}-\theta_0\frac{n+16}{2(n-2)}$ equals L149's $3\theta_0\frac{n-8}{2(n-2)}-\frac29\lvert\kappa_n\rvert$ | **NO FINDING, algebraically identical**, verified below |
| 15 | Hypotheses | **HYPOTHESIS-DEBT, the statement carries none.** $n\ge12$ even, $m\ge6$, $\lVert H\rVert_F=1$, $H\perp W^*$, $H\perp T_{W^*}\mathcal O$ and $\ker W^*=0$ are all used and none is stated |

**One line the round can act on:** the $n=12$ verdict is sound and I reproduce its threshold as a *number* ($17.3$–$18.0$, not a range and not disputed), so the surviving "disputed, $21$ against $3.98$" sentence in [results.md](../results.md):365–369 is stale text that must be replaced, but the title's "$n$-free" is refuted by the entry's own $\lambda$ correction, and the "$\approx1800$" clause that [I31](../plan.md) consumes has no argument anywhere on the page.

## 0. Conventions, fixed once

$n=2m$ even, $m\ge6$. $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$, so $\theta_0(12)=\sqrt{220}/12=1.2360331$. $c_p=3\theta_0/(n-2)$, $\kappa:=nc_p=3\sqrt{2(n-1)/(n-2)}$, so $c_p(12)=0.3708099$ and $\kappa(12)=3\sqrt{2.2}=4.4497188$. $\lvert\kappa_n\rvert=9(\theta_0(n)-\sqrt{3/2})$ (the defect-penalty constant, unrelated to $\kappa$) so $\lvert\kappa_{12}\rvert=9(1.2360331-1.2247449)=0.1015938$ and $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ gives $\lambda(12)=6.274852$, $\lambda_\infty=2/\sqrt{1.7052210}=1.531614$.

$A:=a_0n^{-1/2}=\sqrt{2/(n-2)}=1/\sqrt{m-1}$, which is $0.4472136$ at $n=12$; $\phi(w):=A\sqrt{1-w^2}+w$; $w_0:=(n-4)/n$; $s_\rho(w):=\sqrt{c_p+\rho w^2}$. $J^*=\frac{8(m-1)(4m-3)}{(2m-1)^2}=\frac{840}{121}=6.9421488$ and $C^*=2+\frac{4(m-1)}{2m-1}=\frac{42}{11}=3.8181818$ at $m=6$, with $J\gamma=C$. $\eta^*$ per L157, $1-\eta^*=2/(\sqrt{4t+1}+1)$, $t=\lambda s_\rho/(2C)$. $S:=\sup\lvert P\rvert$. $T$ denotes the threshold on $S$ above which branch 1 binds.

Two notation collisions are live inside the entry and I disambiguate them here, because three of its numerals are unreadable otherwise. (i) $\kappa$ versus $\kappa_n$, the entry flags this itself. (ii) **$s$**: the entry sets $s:=\sqrt{c_p+w^2}$ in the elasticity display, and then in the very next paragraph writes $\big(\frac{s_\rho+1}{s_1+1}\big)^2$ and $s_{\min}$ meaning $\sqrt{4t+1}$. Under the stated meaning those two expressions are wrong; under $\sqrt{4t+1}$ they are exact to five digits (§6). The collision is a defect of the written entry, not of its arithmetic.

## 1. The hypothesis inventory

**What the statement carries: nothing.** Neither form states a single hypothesis, no dimension range, no normalisation of $H$, no domain. Every one of the following is used.

| Hypothesis | Source | Does the object satisfy it? | Does the written proof use it? |
|---|---|---|---|
| $n=2m$, $m\ge6$ (i.e. $n\ge12$ even) | [L149](../findings/second-order.md), "$m\ge5$ was overstated: at $n=10$, $\theta_0=6/5<\sqrt{3/2}$, so $\lvert\kappa_n\rvert$ is negative and $\rho^{\text{eff}}$ has no definition" | Yes at $n=12$; $\theta_0(10)=\sqrt{2\cdot9\cdot8}/10=12/10$ exactly, so the exclusion is exact | Yes, every numeral, and $\lambda$ itself |
| $\lVert H\rVert_F=1$, $H_s\perp H_r$, $w=\lVert H_r\rVert$ | L149, L146 | Yes | Yes, the envelope $\lVert H_s\rVert_F=\sqrt{1-w^2}$ is an identity only under it |
| $H\perp W^*$, $H\perp T_{W^*}\mathcal O$ | L149 (the domain $T_{W^*}S\cap T_{W^*}\mathcal O^\perp$) | Yes | Silently, it is what excludes the negative-margin and zero-margin summands from $\rho^{\text{eff}}$ |
| $\ker W^*=0$ | L149, stated explicitly: "without which $W\mapsto W_-$ is not analytic at $W^*$ and branches 2 and 3 have no domain" | **Holds.** [L70](../results.md)/[L71](../results.md) give $W^*$ exactly two eigenvalues with $\lambda_{\max}=n\lvert\lambda_{\min}\rvert/(n-2)>0$ and $\mathfrak r=0$; the gap is $g_n=\sqrt{2(n-2)}/(n\sqrt{n-1})$ | Yes, for branch 2 to exist at all, and L158 never mentions it |
| $\lVert H\rVert_{op}\le1$; $W(z)=W^*+zH$ affine; $0<\alpha<D$, $0<\gamma<\min(d,1)$; **$\lambda_-$ the spectral point nearest the contour** | [L156](../results.md) | First three yes. **The last is never checked by L158**, and L156 warns the earlier constant "holds only while $\lambda_-$ is the spectral point nearest the contour" | $J^*$ and $C^*$ are used at every numeral; the nearest-point condition is used implicitly and unverified |
| $M\le C\rho$ | L158's own chain | **Valid but loose.** L156 proves $M\le C\gamma g_n$ and $\rho=\gamma g_n/\lVert H\rVert_{op}$ with $\lVert H\rVert_{op}\le1$, so $C\gamma g_n\le C\rho$. Sharp exactly at $\lVert H\rVert_{op}=1$, which is where $w\ge w_0$ | Yes, and it is sharp at the binding direction $w_0$, so the looseness is inert there |
| $u\le w$, with $u\ne w$ | L149: "the only relation on file being $u\le w$" | Holds | **No**, branch 1 is written $(c_p+w^2)/S$, i.e. with $u=w$ and $a=0$, which the entry itself then refutes |
| $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ | **No lemma.** Provenance is a review pair ("r450 D3's factor 2 and the quartic tail's $\lvert\kappa_n\rvert$") | Unverifiable here | Yes, it is the single most load-bearing number in the entry (§2, §9.1) |
| L149's open $\tfrac29$ debt inside $\rho^{\text{eff}}$ | L149, marked `HYPOTHESIS-DEBT` there | Open | Yes, inherited without repeating the debt, though the proviso sentence gestures at it |

**No finding on one point that looked like one:** L156's out-of-scope $m=2$ endpoint $J^*=\tfrac{40}9$ is correctly rejected by L158, and $\tfrac{8(m-1)(4m-3)}{(2m-1)^2}$ does give $\tfrac{40}9$ at $m=2$ and $\tfrac{840}{121}$ at $m=6$, rising to $8$; so "in scope $6.9421\le J^*<8$" is exact.

## 2. Pre-registered question 1, the threshold is a number, and I derive it

**What is on the page.** Three different answers, in one entry:

- "**THE THRESHOLD IS PINNED AT $\approx17$–$19$ AT $n=12$**" (a range), asserted; the block gives the *diagnosis* of the earlier spread but no derivation of $17$–$19$ from any constant.
- "in a prior review's $S=s\theta_0$ variable the threshold is $s^*\approx15$".
- Form A's closing paragraph: "**THE DISAGREEMENT AS THE REVIEWERS LEFT IT** … near $21$ … near $3.98$–$4.44$ … *The gap is whether $2J^*$ enters the branch-2 prefactor $K$, and settling it is the next task on this item.*", the same question the block eleven lines above closes with "**SETTLED … $J$ divides $K$**". Form B carries only this last, refuted reading.

**The derivation, which the entry does not give.** Branch 1 binds iff $\inf_w\text{br}_1<\inf_w\text{br}_2$, i.e. iff $c_p/S<K\,s_\rho(w_0)/n$, i.e. iff $S>T$ with
$$T=\frac{n\,c_p}{K\,s_\rho(w_0)}=\frac{\kappa\,\sqrt2\,J}{\lambda(1-\eta^*)^2\,s_\rho(w_0)} .$$
At $n=12$ every input is pinned: $\kappa=4.4497188$, $J=J^*=\tfrac{840}{121}$, $2C=\tfrac{84}{11}=7.6363636$, $w_0=\tfrac23$, $\lambda(12)=6.274852$.

With $\rho=1$: $s_1(w_0)=\sqrt{0.3708099+\tfrac49}=0.9029144$; $t=6.274852\cdot0.9029144/7.6363636=0.7419243$; $\sqrt{4t+1}=1.9919079$; $(1-\eta^*)^2=(2/2.9919079)^2=0.4468521$; $K=6.274852\cdot0.4468521/(\sqrt2\cdot6.9421488)=0.2855952$; **$T=17.26$.**

With $\rho=\rho^{\text{eff}}_{12}=0.7190434$: $s_\rho(w_0)=\sqrt{0.6903849}=0.8308941$; $t=0.6827400$; $\sqrt{4t+1}=1.9315693$; $(1-\eta^*)^2=0.4654352$; $K=0.2974731$; **$T=18.00$.**

Reading the ratio as the entry's own display $\sqrt{\kappa(1+\kappa)}/K$ instead gives $16.55$–$17.24$; the two readings differ by $\sqrt{(1+\kappa)/\kappa}\,s_\rho=0.9196$, i.e. $8\%$ (§4).

**So at $n=12$ the threshold is a number, $\approx17.3$–$18.0$, and it is derivable, I have just derived it from constants the entry names.** Two consequences:

1. **The band "$17$–$19$" is not an uncertainty at $n=12$.** Recomputing with $J\to8$ (the $m\to\infty$ endpoint), gives $T=19.08$ ($\rho^{\text{eff}}$) and $19.87$ ($\rho=1$). The upper end of the band is $J^*$ read at its asymptotic value. **That is the same class of error the entry charges against $\lambda$ four lines earlier**, committed in the same block.
2. **The diagnosis "the spread … is one constant" is right in direction and incomplete in fact.** Re-running the same derivation at $\lambda_\infty=1.531614$ gives $T=48.7$ ($J^*$, $\rho=1$) up to $51.9$ ($J=8$, $\rho^{\text{eff}}$). So $52.92$ is approached only at the corner where *both* $\lambda$ and $J^*$ are read at $n\to\infty$; $\lambda$ alone moves $T$ from $17.3$ to $48.7$, a factor $2.8$ where $\lambda$ itself moves $4.1$, because $(1-\eta^*)^2$ moves the other way with elasticity $\approx\tfrac12$. **I could not reproduce $52.92$ exactly under any reading; I bracket it at $47.7$–$51.9$.**

**And the entry's own two figures for $\lambda$'s reach disagree**: "a factor $4.1$" (correct: $6.274852/1.531614=4.097$) and "moving $2.3\times$ across the range". The charitable reading is that $2.3$ is the movement of the *ratio*, not of $\lambda$; my derivation puts that at $2.8$. Either way the sentence attaches $2.3$ to $\lambda$, where $4.1$ belongs.

**Cross-checks that pass exactly.** $s^*=T/\theta_0=18.00/1.2360331=14.56$, so "$s^*\approx15$" ✓. $S\le1+\sqrt{10}=4.1622777$ ✓ ("$4.162$"), giving $s\le4.1622777/1.2360331=3.3675$ ✓ ("$s\le3.37$"). $S\ge\theta_0=\kappa(n-2)/(3n)=4.4497188\cdot10/36=1.2360331$ ✓, an identity. And r712's $3.98$–$4.44$ maps to $s\in[3.22,3.59]$ ✓ ("$3.1$–$3.6$").

## 3. Pre-registered question 2, "branch 2 binds", and where it stops

### 3.1 At $n=12$ the conclusion is sound, and robust

$T\ge16.5$ under every reading above, against $S\le4.1623$ (L143) and $S\le10$ (L70). More: $T$ is monotone in each of its three free inputs, so I can bound it over the whole admissible box $J\in[6.9421,8)$, $\lambda\in[1.5316,6.2749]$, $\rho\in[0.7190,1]$:
$$T_{\min}=\frac{4.4497188\cdot\sqrt2\cdot6.9421488}{2.9204\cdot0.9029144}=16.57,\qquad T_{\max}=\frac{4.4497188\cdot\sqrt2\cdot8}{1.1438\cdot0.8308941}=52.97 .$$
**So no admissible choice of constants brings $T$ within a factor $4$ of $S\le4.1623$: branch 2 binds at $n=12$, and I31's constant is not load-bearing there.** This is the entry's central claim and it survives.

### 3.2 The extension to $n\approx1800$ has no argument on the page

The clause is a bare citation: "branch 2 binds, and provably so at every $n$ up to $\approx1800$ (a prior review)". Nothing in either form derives it, and no constant in either form is $n$-dependent in a way that is tracked.

I can reconstruct it, and the reconstruction is itself the finding. L143 gives $S\le1+\sqrt{n-2}$, so branch 1 is excluded exactly while $1+\sqrt{n-2}\le T(n)$, i.e. $n\le2+(T-1)^2$. At the asymptotic constants ($\lambda_\infty=1.531614$, $J\to8$, $C\to4$, $c_p\to0$, $\rho\to1.742382$, $w_0\to1$, so $s\to1.319993$, $t\to0.252715$, $(1-\eta^*)^2\to0.684$, $\kappa\to3\sqrt2$) I get $T_\infty\approx42.5$ and $n^*=2+(41.5)^2=1724$. **So "$\approx1800$" reproduces to about $5\%$, but only by tracking $T$'s $n$-dependence from $18.0$ to $42.5$, a factor $2.4$.** Read at the entry's own pinned $n=12$ threshold with no $n$-dependence, the same computation gives $n^*=2+17^2=291$ to $2+18^2=326$, a sixth of the stated figure.

**This is the collision between claim 4 and claim 1.** The extension is true only if the comparison is *not* $n$-free; the title says it is. The entry contains both.

What is owed, exactly: **the law of $\lvert\kappa_n\rvert$ (hence $\lambda$) in $n$, the law of $J^*(m)$, and the minimiser at each $n$**, together with the observation that the resulting $T(n)$ crosses $1+\sqrt{n-2}$ once. None of the three is on the page.

### 3.3 The minimiser argument is established at $n=12$ and provably degrades

The entry's proof that $w_0$ is a strict minimum over $[0,1]$: above $w_0$ the envelope is constant, so $\frac{\mathrm d}{\mathrm dw}\log(\text{br}_2)=+\frac{N'}N>0$; below it, $\frac{N'}N\le0.4019$ uniformly against $\phi'(w_0)=\tfrac35$.

**Both halves check at $n=12$, exactly.** $\phi(w_0)=1$ identically: $1-w_0^2=8(n-2)/n^2$, so $A\sqrt{1-w_0^2}=\sqrt{\tfrac2{n-2}}\cdot\tfrac{2\sqrt2\sqrt{n-2}}n=\tfrac4n$ and $\phi(w_0)=\tfrac4n+\tfrac{n-4}n=1$. And $\phi'(w_0)=1-\frac{Aw_0}{\sqrt{1-w_0^2}}=1-\frac{n-4}{2(n-2)}=\frac n{2(n-2)}$, which is exactly $\tfrac35$ at $n=12$ ✓. The numerator bound is $\frac{\rho w}{c_p+\rho w^2}\cdot\frac1{\sqrt{4t+1}}\le\frac{\sqrt\rho}{2\sqrt{c_p}\sqrt{4t_{\min}+1}}$ by AM–GM plus the entry's own elasticity $\frac{\mathrm d\log(K N)}{\mathrm d\log s}=\frac1{\sqrt{4t+1}}$; with $\sqrt{4t(0)+1}=\sqrt{4\cdot0.5003454+1}=1.7324497$ this is $\frac{0.8479643}{1.2178782\cdot1.7324497}=0.4018983$ ✓ **exactly the entry's $0.4019$**, and it is $<\tfrac35$, so $w_0$ is the minimiser at $n=12$. (Read with the entry's *stated* meaning of $s$, the same expression is $1.1435>\tfrac35$ and the argument fails; see §0.)

**The sufficient condition provably fails for large $n$.** Both factors that save it at $n=12$ tend to $1$: $\sqrt{\rho^{\text{eff}}_{12}}=0.848$ but $\rho^{\text{eff}}_n\uparrow1.742$, and $1/\sqrt{4t_{\min}+1}=0.577$ but $t_{\min}=\lambda\sqrt{c_p}/(2C)\to0$ since $c_p\sim3\sqrt2/n$ and $\lambda\downarrow1.53$. Meanwhile $\frac1{2\sqrt{c_p}}\sim\frac{\sqrt n}{2\sqrt{3\sqrt2}}=0.2428\sqrt n\to\infty$ while $\phi'(w_0)=\frac n{2(n-2)}\downarrow\tfrac12$. **So the bound the entry uses exceeds the quantity it is compared against for all large $n$**: the kink-minimiser claim is *proved at $n=12$ and unproved at every larger dimension*, which is precisely the range §3.2's extension needs. I emphasise: this refutes the *argument*, not the claim.

### 3.4 Does the corrected branch-2 minimum change either? No

$\rho^{\text{eff}}_n<1$ only at $n\in\{12,14,16\}$, I verify $0.7190434$, $0.8723900$, $0.9856400$, then $1.0727370$ at $n=18$, all four exact from $2\sqrt{3/2}-\theta_0\frac{n+16}{2(n-2)}$. So the correction raises $T(12)$ from $17.26$ to $18.00$ and leaves $T_\infty$, hence the $\approx1800$ crossing, untouched. The entry's "the repair strengthens it" is right in direction: lowering branch 2 raises $T$.

## 4. Quantifier order and scope

**The identity is used correctly.** $\inf_w\min(f,g)=\min(\inf f,\inf g)$ holds, so the entry may compare separately-taken infima; and the withdrawal of its own L148 caveat is right for a reason the entry does not give, L149 records that at $w=0$ "the branch is **unbounded**", so $\min(f,g)(0)=f(0)$ and no domain mismatch arises. **No finding.**

**But the two infima are taken in different variables and only one of them is the entry's.** $\inf\text{br}_1$ is taken at $w=0$; $\inf\text{br}_2$ at $w_0=\tfrac23$. That is licensed by the identity. What is *not* licensed is that $\inf\text{br}_1=\kappa/(nS)$: the entry states four paragraphs later that branch 1 is $f(u)=(c_p+u^2)/(S+au)$ with $f'(0)<0$, so its infimum "is **strictly below** $\kappa/(nS)$". Exactly,
$$\inf_{u\ge0}f=\frac{2c_p}{S+\sqrt{S^2+a^2c_p}}\quad\text{at }u^*=\frac{\sqrt{S^2+a^2c_p}-S}{a},$$
so the true $T$ is smaller than §2's by $\frac{2S}{S+\sqrt{S^2+a^2c_p}}\ge\frac{2S}{2S+a\sqrt{c_p}}$. The verdict at $n=12$ survives provided $T\cdot\frac{2S}{2S+a\sqrt{c_p}}>S$, i.e. (with $T=18.0$, $S=4.1623$, $\sqrt{c_p}=0.6089$) **provided $a<45$**. L149 gives $\lVert A''\rVert=O(n^{1/2}+nw)$, so $a=O(n)$ and this is very likely satisfied, but $a$ appears nowhere in L158, and the "about $5\%$" quoted for this effect elsewhere in the file is not derived either. **GAP, inert at $n=12$ for any plausible $a$.**

**A third inconsistency of scope.** The displayed ratio $\frac{\sqrt{\kappa(1+\kappa)}}{SK}$ is equivalent to $\inf\text{br}_2=K n^{-1}\sqrt{\kappa/(1+\kappa)}$, i.e. $0.9036/n$ at $n=12$; the settled block's own infimum is $s_\rho(w_0)/n=0.8309/n$. The entry never reconciles the two, and they differ by $8\%$, which is why §2 gives two threshold values. Form B prints the first as an interior value that "stands only as a lower bound" without saying it is the one the ratio display uses.

## 5. The edge of every range

- **$w=0$.** Branch 2 is absent (L148), branch 1 attains $c_p/S$ before the $au$ correction. Handled correctly; see §4.
- **$w=1$.** $\phi(1)=A\cdot0+1=1$ exactly, so the envelope meets the cap at the endpoint as claimed. ✓
- **Smallest admissible dimension.** $n\ge12$ even, $m\ge6$, forced by $\rho^{\text{eff}}$ and by $\lambda$'s definition. **L158 states no range in either form.** It also writes $w^*$, $w_0$ and $\rho^{\text{eff}}$ as functions of a continuous $n$, though $W^*=S^m\times S^m$ exists at even $n$ only.
- **The crossover $n=6+2\sqrt7=11.2915$.** The entry says nothing about it, and it is the most consequential edge in the entry. $\lvert\kappa_n\rvert=9(\theta_0(n)-\sqrt{3/2})$ **vanishes exactly there**, so $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ has a pole at the crossover and is undefined below it. $n=12$ is the first admissible dimension, sitting $0.71$ above the pole, **which is the whole reason $\lambda(12)=6.275$ is four times its asymptotic value, and hence the whole reason the threshold at $n=12$ is $18$ rather than $42$.** The entry's headline finding is a crossover artefact and the entry never says so.
- **$\ker W\ne0$, and the record's named witness $W_{\mathbb{CP}^2}$ with $\dim\ker W=3$.** **The entry asserts nothing.** It is not reached: L149 makes $\ker W^*=0$ an explicit hypothesis and it holds at $W^*$ by L70/L71 (exactly two eigenvalues, $\mathfrak r=0$, $\lambda_{\max}=n\lvert\lambda_{\min}\rvert/(n-2)>0$), with the gap $g_n=\sqrt{2(n-2)}/(n\sqrt{n-1})$. $W_{\mathbb{CP}^2}$ saturates L70 only at $n=4$, far below the range. One residual scope note: L156's constant is conditioned on $\lambda_-$ being the spectral point nearest the contour, and a spectral point at $0$ inside the contour would break it, vacuous here, but unstated.

## 6. Every numeral, against the constants the entry itself names

**Reproduced exactly** (closed form in parentheses): $\kappa(12)=4.4497188$ and $\kappa\downarrow3\sqrt2$ ($3\sqrt{2(n-1)/(n-2)}$); "$\kappa n^{-1/2}>1$ for every $n\le19$" (root $10+\sqrt{82}=19.055$); $c_p=3\theta_0/(n-2)=3\theta_0(\tfrac12-\lambda_m)$ with $\tfrac12-\tfrac{m-2}{2(m-1)}=\tfrac1{n-2}$; $\theta_0=\kappa(n-2)/(3n)$; $S\le4.162$ and $s\le3.37$ and $s^*\approx15$; $\lvert\kappa_{12}\rvert=0.1015938$ and $\lvert\kappa_\infty\rvert=1.7052210$ and $\lambda(12)=6.274852$ and the factor $4.1$; $J^*=\tfrac{840}{121}$, $2J^*=\tfrac{1680}{121}=13.8843$, $\tfrac{40}9$ at $m=2$, $J^*<8$; $C^*=\tfrac{42}{11}$; $w_0=\frac{1-a_0^2/n}{1+a_0^2/n}=\frac{n-4}n$ and $\phi(w_0)=1$ and $\phi'(w_0)=\tfrac35$; $\rho^{\text{eff}}$ at $n=12,14,16,18$; $\sqrt6-\tfrac7{30}\sqrt{55}$ (since $\theta_0\tfrac{28}{20}=\tfrac{7\sqrt{55}}{30}$); $0.4019$; $Bc/A=3\sqrt{n-1}/n=0.8291562$ (and it equals $c_p/A$ exactly); $1.2845=\kappa n^{-1/2}$; $\sqrt{m-2}/m=\tfrac13$ against $1/\sqrt{m-1}=0.4472$; the margin coefficients $0.74162$ and $0.94626$ ($3\theta_0\frac{m-4}{2(m-1)}$); $1/g_n=n^2c_p/6$ with the $\sqrt2$ limit low by exactly $\sqrt{(n-1)/(n-2)}=1.0488$; L149's $0.71980/n$.

**$\rho^{\text{eff}}$'s two forms are one.** $3\theta_0\frac{n-8}{2(n-2)}-\tfrac29\cdot9(\theta_0-\sqrt{3/2})=\theta_0\big[\frac{3(n-8)}{2(n-2)}-2\big]+2\sqrt{3/2}=2\sqrt{3/2}-\theta_0\frac{n+16}{2(n-2)}$. Identical. ✓

**The three central numerals, and what they actually are.**
$$0.40347=(1-\eta^*)^2 s_1(w_0)=0.4468521\cdot0.9029144=0.4034714,$$
$$0.38673=(1-\eta^*_\rho)^2 s_\rho(w_0)=0.4654352\cdot0.8308941=0.3867259,$$
$$1.04329=\frac{N_1}{N_\rho}\Big(\frac{\sqrt{4t_\rho+1}+1}{\sqrt{4t_1+1}+1}\Big)^2=1.0866840\cdot0.9600690=1.0433020 .$$
All three exact. **But $(1-\eta^*)^2 s$ is branch 2 stripped of its prefactor $\lambda/(\sqrt2 J)$ and of the $1/n$.** So the caption "**it is a lower bound on the tube radius**" is wrong by $\lambda/(\sqrt2Jn)=0.05326$: the actual branch-2 minimum is $0.020598$, and $n\cdot$branch$_2=0.24718$. The entry's *other* branch-2 numerals are on that second scale, I confirm "forcing $0.2793$ needs $\lambda=7.48$" reproduces there to $0.5\%$ ($\lambda=7.48$ gives $0.2808$). **Two scales, one label, inside one entry.**

**The proviso.** "L149's open $\tfrac29$ debt moves the factor to $1.0391$": exact, at penalty coefficient **zero** ($\rho=3\theta_0\frac{n-8}{2(n-2)}=0.7416199$ gives $1.0393756$). L149's own stated alternative is coefficient **one**; taking L149's number for it ($0.689771$) gives $1.0485$, and taking coefficient one literally ($0.640028$) gives $1.0576$. Both alternatives move the factor **up**, not down. So the proviso's figure describes a third scenario neither entry names. (I do not adjudicate L149's $0.689771$, which I also cannot reproduce: $0.7416199-x\cdot0.1015938=0.689771$ needs $x=0.5104$.)

**Could not reproduce.**

| Numeral | What I get | Note |
|---|---|---|
| $52.92$ | $47.7$–$51.9$ | only at the corner where $\lambda$ **and** $J^*$ are both asymptotic |
| "$27.8\%$ at $\lambda(12)$ and $19.4\%$ at the asymptotic $\lambda$" | $13.2\%$ and $21.2\%$ | and the *ordering* is refuted in closed form, §9.3 |
| "the displayed minimum then overstates by $12\%$" |, | no referent: three different "displayed minima" are in play |
| "moving $2.3\times$ across the range" | $\lambda$ moves $4.1\times$; $T$ moves $2.8\times$ | attached to $\lambda$, where $4.1$ belongs |
| Form B's $w^*=2\sqrt n/(n-8)$, "outside $[0,1]$ for every $n<16$" | the exact stationary point of L149's $g_\rho$ is $\frac{3\sqrt{n-1}}{n\rho}$ | §7 |
| $\approx1800$ | $1724$ | reconstructible only via the $n$-dependence the title denies, §3.2 |
| (inherited, L157) "$\sup_wt\to\tfrac18$, so $(1-\eta^*)^2\to0.808$" | $t\to0.19$–$0.25$, $(1-\eta^*)^2\to0.74$–$0.68$ | $t\to\tfrac18$ needs $\lambda=1$, not $\lambda_\infty=1.5316$ |

**Two numerals computed at the superseded constant and left standing.** "The prefactor $1.24$ is its $w=0$ value … at the minimiser it is $1.1075$." Both are exact **at $\lambda=1.53$**: at $w=0$, $t=1.53\cdot0.6089/7.6364=0.122$, $(1-\eta^*)^2=0.81169$, product $1.2419$; at $w=3\sqrt{11}/12$ (where $w^2=\tfrac{99}{144}$ exactly), $s=1.0287$, $t=0.20612$, $(1-\eta^*)^2=0.72387$, product $1.1075$. At $\lambda(12)=6.2749$ the $w=0$ prefactor is $3.36$, not $1.24$, a factor $2.7$. These sit eight lines above the block that declares $\lambda=1.53$ an error "of the same class as the three vocabulary searches".

**And the display itself carries an asymptotic constant.** Deriving branch 2 from the entry's own chain gives $\lambda\sqrt c\,(1-\eta^*)^2g_n/(2J\lVert H\rVert_{op})$; matching it to the displayed $\frac{\lambda(1-\eta^*)^2}{\sqrt2J}\cdot\frac{s_\rho}{n\min(\phi,1)}$ requires $g_n=\sqrt2/n$, the limit, not $g_{12}=\sqrt{20}/(12\sqrt{11})=0.1123670$. The gap is exactly $\sqrt{(n-1)/(n-2)}=1.0488$, the very $4.9\%$ the entry lists among the "four constants the entry had wrong … in the unsafe direction". It runs the safe way for the verdict ($T$ rises to $18.9$) and it is still in the final display.

## 7. The two forms

Beyond tone, the forms differ in substance at four places. Any of the four is a finding on its own.

1. **The threshold.** Form A: "**PINNED AT $\approx17$–$19$ … AND THE ENTRY'S 'NOT PINNED' IS REFUTED**". Form B: "**disputed** between the two audits, $21$ against $3.98$, according to whether Lemma L156's $2J^*$ enters the branch-2 prefactor", the reading Form A refutes, on the question Form A settles ("$J$ divides $K$"). Form A then re-opens it itself in its last paragraph ("settling it is the next task on this item"). **The canonical record therefore states as open a question its own source states as closed.**
2. **The stationary point of branch 2.** Form B prints $w^*=2\sqrt n/(n-8)$, "outside $[0,1]$ for every $n<16$" (at $n=12$: $\sqrt{12}/2=1.7321$; the range statement is exact for that formula, since $2\sqrt n>n-8\iff n^2-20n+64<0\iff n<16$). Form A prints two different values, $\kappa n^{-1/2}=1.2845$ and $3\sqrt{n-1}/n=0.8292$, refutes both, and settles on $w_0=\tfrac23$. **None of the three is $2\sqrt n/(n-8)$.** Working L149's own $g_\rho=\sqrt{c_p+\rho w^2}/(a_0n^{1/2}+nw)$ exactly: $\frac{\mathrm d}{\mathrm dw}\log g_\rho=0$ at $w^*=\frac{nc_p}{\rho a_0\sqrt n}=\frac{3\sqrt{n-1}}{n\rho}$, giving $0.8292$ at $\rho=1$ and $1.1534$ at $\rho^{\text{eff}}$; with $\rho$ taken penalty-free this collapses to $\frac{\sqrt{2(n-2)}}{n-8}$, which exceeds $1$ only for $n<9+\sqrt{13}=12.606$. So Form B's formula is the same shape with $\sqrt{2(n-2)}$ replaced by $2\sqrt n$, and its stated range, $n<16$, is wrong under every $\rho$ on the record.
3. **Form B's interior value belongs to a refuted envelope.** $n^{-1}\sqrt{\kappa/(1+\kappa)}$ is exactly the minimum of $\sqrt{c_p+w^2}/(n(A+w))$ at $A=n^{-1/2}$, the literal $A=n^{1/2}$ reading Form A calls refuted, and the one whose stationary point is $\kappa n^{-1/2}$, not the $w^*$ Form B prints beside it. So Form B pairs a value from one envelope with a minimiser from another.
4. **Form B omits every correction of the last two rounds**: $\rho^{\text{eff}}$, the corrected minimum $0.38673$, the kink minimiser, $\lambda(12)=6.275$, the $\approx1800$ extension, the $S=s\theta_0$ reformulation, and the $m\ge6$ range. Its trailer credits the branch-2 correction to a different review pair than Form A's does.

**One further difference, between the brief and its source.** The brief's Form A is 57 lines where [second-order.md](../findings/second-order.md):1272–1330 is 59: the brief drops the entry's closing paragraph, "**A $w$-dependence the entry ignored.** … $\lambda(1-\eta^*)^2$ ranges over $[1.24,1.53]$, and the entry used the $w=1$ value at an interior minimiser." That paragraph is itself entirely at the superseded $\lambda=1.53$ (at $\lambda(12)$ the range is $[2.92,3.36]$), so the record still carries a fourth asymptotic-constant numeral that the brief did not put in front of the verifiers.

## 8. What is proven against what is used

[I31](../plan.md) consumes: *"At $n=12$ the constants make L149's branch 2 the binding one, and it stays binding to $n\approx1800$, so $S$ does not enter the radius at any dimension this programme evaluates."*

| Consumed | Supplied? |
|---|---|
| branch 2 binds at $n=12$ | **Yes**, with a factor-$4$ margin over the whole admissible constant box (§3.1) |
| "stays binding to $n\approx1800$" | **No argument on the page** (§3.2); reconstructible at $1724$ only by tracking the $n$-dependence the title denies, and resting on a minimiser proved at $n=12$ alone (§3.3) |
| "at any dimension this programme evaluates" | Fine if that means $n=12$; the entry's own text extends it to $1800$ |
| the asymptotic claim (branch 1 $\Theta(n^{-1-\beta})$ vs branch 2 $\Theta(n^{-1})$, so any $\beta>0$ eventually binds) | **Yes**, L149 carries it and it is untouched by everything here |

## 9. Findings, each with its three-step record

### 9.1 The title's "$n$-free" is refuted by the entry's own body, REFUTED

**Locate.** Both forms: "*the branch comparison is $n$-free*". Against, in Form A: "$\lambda(12)=6.275$, not $1.53$, a factor $4.1$, and it is **the largest $n$-dependence in a ratio this entry's title calls $n$-free**".
**Exhibit.** $T(12)=18.0$ and $T_\infty=42.5$, from $\lambda(n)=2/\sqrt{9(\theta_0(n)-\sqrt{3/2})}$ and $J^*(m)$. The ratio moves by $2.4$ across the range, and the $\approx1800$ claim is *derived from* that movement.
**Opposite.** The charitable reading is that "$n$-free" describes the *cancellation of $n^{-1}$* between the two branches, which is real: both infima are $\Theta(n^{-1})$ and their ratio is $O(1)$. The title would be true if it said "dimensionless" rather than "$n$-free". As written, beside a body that computes $T$ at two dimensions and gets two answers, it is refuted. **Stands.**

### 9.2 "$0.38468$ at the entry's $0.5528$", and the $4.9\%$ charge, BROKEN

**Locate.** "*this entry's own kink understated the minimum by $4.9\%$ … the minimum was recorded as $0.40347$ at $w_0=\tfrac23$, against $0.38468$ at the entry's $0.5528$*".
**Exhibit.** $0.38468$ is exactly $(1-\eta^*)^2s$ at $w=0.5528$, $0.4677270\cdot0.8224343=0.3846744$, **with the envelope omitted**. At $w=0.5528$ the envelope is $\phi=0.4472136\sqrt{1-0.3055878}+0.5528=0.9254654<1$, whereas $\phi(w_0)=1$. Restoring it: branch 2 at $0.5528$ is $0.3846744/0.9254654=0.4156557$, **above** $0.4034714$ at $w_0$. The kink is the minimum by $2.9\%$; the "$4.9\%$ understatement" is an artefact of comparing a numerator at one point with a full quotient at another.
**Opposite.** If $0.5528$ were above the kink the envelope would be $1$ at both points and the comparison would be fair. It is not: $0.5528<\tfrac23$. And the sentence cannot be read as comparing numerators only, since it calls $0.40347$ "the minimum". **Stands**, and note it contradicts the entry's own settled block two lines above, which proves $w_0$ is the minimiser.

### 9.3 "$27.8\%$ at $\lambda(12)$ and $19.4\%$ at the asymptotic $\lambda$", REFUTED, in closed form

**Locate.** "*the improvement over the endpoint is $27.8\%$ at $\lambda(12)$ and $19.4\%$ at the asymptotic $\lambda$, never the $26\%$ claimed*".
**Exhibit.** Write $F(w)=K(w)N(w)$, $t=\beta s$, $\beta=\lambda/(2C)$. The entry's own elasticity gives $\log\frac{F(1)}{F(w_0)}=\int_{s(w_0)}^{s(1)}\frac{1}{\sqrt{4\beta s+1}}\frac{\mathrm ds}{s}$. The integrand is strictly decreasing in $\beta$ at every $s$, and the limits do not depend on $\beta$. **Hence the improvement is strictly decreasing in $\lambda$, so the value at $\lambda(12)=6.275$ must be strictly *less* than the value at $\lambda=1.53$.** The entry has it strictly greater. Numerically, exactly: at $\lambda(12)$, $F(1)/F(w_0)=0.4568340/0.4034714=1.1323$ ($13.2\%$); at $\lambda_\infty$, $0.8183600/0.6750430=1.2123$ ($21.2\%$).
**Opposite.** The most charitable reading is that "the endpoint" means r714's own reported endpoint number rather than $w=1$ under the same constants; but the sentence gives one improvement per $\lambda$, so both must be computed on the same function, and then the ordering is forced. **Stands.**

### 9.4 The threshold is a number and the record says it is disputed, see §2, §7.1

**Locate.** [results.md](../results.md):369, and Form A's closing paragraph.
**Exhibit.** §2 derives $T(12)=17.26$ ($\rho=1$) / $18.00$ ($\rho^{\text{eff}}$) from six constants, all pinned at $n=12$. The "dispute" was between one party carrying $J^*$ at $\tfrac{40}9$ and another omitting $J$ entirely; both defects are named and corrected inside the same entry.
**Opposite.** The dispute would be live if it were unsettled whether $2J^*$ or $J^*$ enters $K$, the entry's chain gives $\lVert A''\rVert\le2J\lVert H\rVert_{op}/((1-\eta)^2g_n)$, so the $2$ is in $\lVert A''\rVert$ and $K$ carries $J$ once, which is what the display says. Carrying $2J^*$ instead would double $T$ to $36$, still far above $S\le4.162$, **so the dispute cannot change the verdict at $n=12$ under either resolution**, which is itself grounds for deleting the sentence rather than preserving it. **Stands.**

### 9.5 Candidates I withdrew

- *"The comparison is made branch-by-branch at each branch's own minimiser, not at a common $w$."* **Withdrawn**: $\inf\min=\min(\inf,\inf)$ is an identity and the quantity being bounded is $\inf_w\min$, so separate minimisers are correct. The entry's defence is right.
- *"$\rho^{\text{eff}}$ has two incompatible definitions across L149 and L158."* **Withdrawn**: they are algebraically identical (§6).
- *"$M\le C\rho$ is invalid."* **Withdrawn**: $M\le C\gamma g_n\le C\rho$ because $\lVert H\rVert_{op}\le1$; it is loose off the binding direction and sharp on it.
- *"The envelope $\min(A\sqrt{1-w^2}+w,1)$ is unlicensed."* **Withdrawn**: $\lVert H\rVert_{op}\le\lVert H_s\rVert_{op}+\lVert H_r\rVert_{op}\le A\sqrt{1-w^2}+w$ by L146's homogeneity and $\lVert H_s\rVert_F=\sqrt{1-w^2}$, and $\le1$ by $\lVert H\rVert_{op}\le\lVert H\rVert_F=1$. Both bounds are correct, and the new envelope is a genuine sharpening of L149's triangle form, worth noting that it *raises* branch 2 (at $w_0$, from $0.7459/n$ to $0.8309/n$) and so *lowers* $T$, which is the unsafe direction; the margin at $n=12$ absorbs it.

## 10. What would falsify the statement, and what I did to look for it

**The object that would break "branch 2 binds at $n=12$"** is a branch-2 prefactor about $4.3\times$ smaller than the derived one, concretely, a contour constant $J>30$, or a quartic-tail constant $\lambda<1.45$ at $n=12$, or a direction $H$ in $T_{W^*}S\cap T_{W^*}\mathcal O^\perp$ with $\lVert H\rVert_F=1$ at which $\lVert H\rVert_{op}$ exceeds $\min(A\sqrt{1-w^2}+w,1)$. I looked for each: L156 caps $J^*<8$ in scope and its $m=2$ endpoint $\tfrac{40}9$ is *smaller*, not larger; $\lambda\ge2/\sqrt{\lvert\kappa_\infty\rvert}=1.5316$ for every $n\ge12$, since $\theta_0\uparrow\sqrt2$; and the envelope is an identity plus a triangle inequality, so no such $H$ exists. Solving $T(\lambda)=S$ backwards needs $\lambda\approx117$, i.e. $\lvert\kappa_{12}\rvert\approx3\times10^{-4}$, which would require $n$ within $3\times10^{-6}$ of the crossover $6+2\sqrt7$. **I found no falsifier for the $n=12$ claim.**

**The object that would break the $\approx1800$ clause** is a dimension $n_0\in(12,1800)$ at which the minimiser leaves $w_0$, or at which $T(n)$ dips below $1+\sqrt{n-2}$. §3.3 shows the entry's own sufficient condition for the minimiser fails for all large $n$, so such an $n_0$ is not excluded by anything on the page, I did not construct one, and constructing it would need $\lvert\kappa_n\rvert$'s law, which the entry does not give.

## Verdict

**`HYPOTHESIS-DEBT`.**

What is owed, exactly:

1. **The $n$-dependence of $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$, and a derivation of that identity itself.** It has no lemma behind it, it is singular at $n=6+2\sqrt7$, and every threshold numeral in the entry is proportional to it.
2. **The $\approx1800$ extension.** Needed: $T(n)$ as a function of $n$ (hence 1 above, plus $J^*(m)$ and $s_\rho(w_0(n))$), the fact that it crosses $1+\sqrt{n-2}$ once, and the minimiser at every $n$ in $(12,1800)$, the last of which the entry's own argument establishes at $n=12$ only and cannot establish for large $n$.
3. **The hypotheses.** $n\ge12$ even, $m\ge6$, $\lVert H\rVert_F=1$, $H\perp W^*$, $H\perp T_{W^*}\mathcal O$, $\ker W^*=0$, $u\le w$, and L156's nearest-spectral-point condition. The statement carries none of them in either form.
4. **The branch-1 coefficient $a$**, without which $\inf\text{br}_1=\kappa/(nS)$ is an equality the entry itself denies.

What is sound and should be kept: **branch 2 binds at $n=12$**, with the threshold a *number* near $18$ and a factor-$4$ margin that no admissible constant closes; $\rho^{\text{eff}}$ and the corrected $0.38673$; the kink minimiser at $n=12$; the $\inf\min$ identity and the withdrawal of the L148 caveat; and L149's order claims, which nothing here touches.
