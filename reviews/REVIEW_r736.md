# Reviewer r736, L162's monotonicity proof, and the radius assembled from it

**Brief:** `gate2-radius.md`, three items on [Lemma L162](../findings/second-order.md). Argued cold from the definitions in [conventions.md](../findings/conventions.md) and the chain's own entries [L146](../findings/second-order.md), [L149](../findings/second-order.md), [L156](../findings/second-order.md), [L157](../findings/second-order.md), [L158](../findings/second-order.md). Exact rational and symbolic arithmetic throughout; the two places a value is quoted to six digits are marked as screens. Analysis-only: no sweep, search, census or falsifier hunt was run.

| Item | Verdict |
|---|---|
| **1**, the monotonicity proof of $F(w_0)$ | **CONFIRMED**, every step, with one imprecise justification that does no damage |
| **2**, the radius $r_n\gtrsim0.38673/n$ | **REFUTED.** The denominator substitution the brief sends me to is *licensed and correct*; what is wrong is a **missing prefactor $\lambda/(\sqrt2J)$**, which the record had already caught once. The corrected constant is $0.2472$ at $n=12$, and **the monotonicity reverses**, so $n=12$ is the *best* case, not the worst |
| **3**, the scope correction on the kink | **CONFIRMED**, every figure reproduced independently, and the drift is real rather than an artefact |

---

## Item 1, the monotonicity proof. CONFIRMED.

**The collapse is right, and it is an identity.** With $q=\sqrt{4\beta s+1}$, $q^2=4\beta s+1$ gives $(q+1)^2=4\beta s+2+2q$, so $F=4s/(q+1)^2=2s/(1+2\beta s+q)$, and $\tfrac2\beta h(\beta s)=\tfrac2\beta\cdot\tfrac{\beta s}{1+2\beta s+\sqrt{1+4\beta s}}$ is the same expression.

**$h'$ is exactly as stated.** Symbolic differentiation of $h(x)=x/(1+2x+\sqrt{1+4x})$ and subtraction of the block's $1/(2x\sqrt{4x+1}+4x+\sqrt{4x+1}+1)$ returns $0$ identically, and every term of that denominator is positive for $x>0$.

**A shorter route to the same two signs, which the block could carry instead.** Differentiating $F=4s/(q+1)^2$ directly, with $4\beta s=(q-1)(q+1)$:

$$\frac{\partial F}{\partial s}=\frac4{(q+1)^2}\Big[1-\frac{4\beta s}{q(q+1)}\Big]=\frac4{(q+1)^2}\Big[1-\frac{q-1}q\Big]=\frac4{q\,(q+1)^2}>0,\qquad \frac{\partial F}{\partial\beta}=-\frac{16s^2}{q\,(q+1)^3}<0 .$$

Both signs fall out in one line with no auxiliary function, so the reduction to $h$ is a convenience rather than a need.

**$\beta$ falls.** $\theta_0(n)^2=2(1-3/n+2/n^2)$ has derivative $2(3n-4)/n^3>0$, so $\theta_0$ strictly increases; hence $\lambda=2/\sqrt{9(\theta_0-\sqrt{3/2})}$ strictly decreases (and is defined on $n\ge12$, $\theta_0(12)=\sqrt{55}/6=1.23603>\sqrt{3/2}$). $C(n)=4-\tfrac2{n-1}$ strictly increases. So $\beta=\lambda/(2C)$ strictly decreases. **Both confirmed, and $C(n)=\tfrac{2(2n-3)}{n-1}$ is itself confirmed** from [L156](../findings/second-order.md): at $\alpha^*=D/2$, $\gamma^*=\alpha^*/2$ the constant is $C=2(1+\alpha^*)/\alpha^*$, and $\alpha^*=\tfrac{2m-1}{2(m-1)}=\tfrac{n-1}{n-2}$ collapses it to $\tfrac{2(2n-3)}{n-1}$, returning $\tfrac{42}{11}$ at $n=12$.

**$S$ is the right object and $w_0'$ is picked up.** Differentiating the composite $S(n)=c_p(n)+\rho^{\mathrm{eff}}_n\big(\tfrac{n-4}n\big)^2$ (so that the chain rule supplies $2\rho^{\mathrm{eff}}_nw_0w_0'$ with $w_0'=4/n^2$) and clearing denominators gives

$$S'(n)=\frac{4\sqrt{(n-1)(n-2)}\Big[\sqrt2\,P(n)+8n(n-2)(n-4)\sqrt{6(n-1)(n-2)}\Big]}{4n^4(n-2)^2(n-1)},$$

so the block's numerator is exactly right up to the positive factor $4\sqrt{(n-1)(n-2)}$, and its denominator is manifestly positive. **The $w_0'$ term is in it.** And $s_0=\sqrt S$, so $S$ rising is $s_0$ rising.

**$D$ and its shifted expansion, recomputed.** $P(12)=-86976$ as stated. $D(n)=384n^2(n-2)^3(n-4)^2(n-1)-2P(n)^2$ expanded at $n=12+u$ has coefficients

$$\tfrac{3047}8,\ \tfrac{62753}2,\ \tfrac{2209615}2,\ 21738544,\ 261338576,\ 1962270976,\ 8955411328,\ 22573025280,\ 23798734848$$

from $u^8$ down to $u^0$, **all positive**, with the two endpoints the block names ($\tfrac{3047}8$ and $23798734848$) exactly reproduced. The leading coefficient is $384-2(\tfrac54)^2=\tfrac{3047}8$, which is a one-line check of the whole expansion's scale.

> **THE SQUARING JUSTIFICATION IS IMPRECISE AND THE CONCLUSION IS UNHARMED.** *$P$ **does** change sign on $n\ge12$: its real roots are $1.1832$, $1.7969$, $3.3906$ and $\mathbf{85.2293}$, so $P<0$ on $[12,85.23)$ and $P>0$ above.* **The sentence "*legitimate since both are positive there*" is therefore false for $n>85.23$**, above that root the quantity being squared on the right, $-\sqrt2P$, is negative. *It costs nothing:* $D>0$ says $8n(n-2)(n-4)\sqrt{6(n-1)(n-2)}>\sqrt2\lvert P\rvert\ge-\sqrt2P$, which gives numerator $>0$ **for either sign of $P$**. The repair is one word ($D>0$ is a *sufficient* condition, not an equivalent one) and no number moves.

**Value and limit reproduced.** $\rho^{\mathrm{eff}}_{12}=\sqrt6-\tfrac7{30}\sqrt{55}=0.719043429$, $c_p(12)=0.370809924$, $\lambda(12)=6.274746787$, $\beta(12)=0.821693032$, $s_0(12)=0.830893965$, $F(w_0)=0.386727744$ and $F(w_0)\to0.903035219$. **All as recorded.**

---

## Item 2, the radius. REFUTED, and not at the joint the brief names.

### The denominator substitution is licensed, and the brief's premise about it is wrong

**$a_0n^{1/2}+nw$ *is* $n$ times an envelope, and it is the triangle one.** Since $a_0=\sqrt{2n/(n-2)}$,

$$a_0n^{1/2}+nw=n\Big(\tfrac{a_0}{\sqrt n}+w\Big)=n\,\psi(w),\qquad \psi(w)=\sqrt{\tfrac2{n-2}}+w,$$

so [L149](../findings/second-order.md)'s $g_\rho$ already has the shape $\sqrt{c_p+\rho w^2}/(n\cdot\text{envelope})$. **The substitution is $\psi\rightsquigarrow\phi$, one envelope for another, not a change of form.**

**And $\phi\le\psi$ pointwise**, since $\sqrt{1-w^2}\le1$ below the kink and $\psi(w)\ge a_0n^{-1/2}\sqrt{1-w^2}+w\ge1$ above it. So the substitution *raises* branch 2 and therefore needs a licence, **and the licence is on the record**, in [L158](../findings/second-order.md)'s boxed envelope correction, Gate 2 by [r715](REVIEW_r715.md) and [r716](REVIEW_r716.md): $H_s\perp H_r$ with $\lVert H\rVert_F=1$ makes $\lVert H_s\rVert_F=\sqrt{1-w^2}$ an identity, [L146](../findings/second-order.md) is homogeneous so $\lVert H_s\rVert_{op}\le a_0n^{-1/2}\sqrt{1-w^2}$, and $\lVert H\rVert_{op}\le\lVert H\rVert_F=1$ supplies the second arm of the $\min$. **L149's $\psi$ is the superseded form; L162 is entitled to $\phi$, and the same display it is entitled to is printed in L158's own `SETTLED` box.**

**The crossing identity is exact and holds identically in $n$, as claimed.** $1-w_0^2=\tfrac{8(n-2)}{n^2}$, so $\sqrt{1-w_0^2}=\tfrac{2\sqrt2\sqrt{n-2}}n$ and $\sqrt{\tfrac2{n-2}}\cdot\tfrac{2\sqrt2\sqrt{n-2}}n=\tfrac4n$, leaving $\tfrac4n+\tfrac{n-4}n=1$. The concave $g(w)=a_0n^{-1/2}\sqrt{1-w^2}+w$ has $g(0)<1$ and $g(1)=1$, so it crosses $1$ from below at $w_0$ and stays above on $(w_0,1)$: **$\phi=g$ on $[0,w_0]$ and $\phi\equiv1$ on $[w_0,1]$**, exactly as the entry uses it.

> **SO THE BRIEF IS BRIEFED WRONG ON THIS ITEM.** *It says the two denominators "are not the same function" and that the replacement is "stated without a licence".* **The first half is true and inert (they are the same function of the envelope, evaluated at two different envelopes) and the second half is false**, the licence sitting 180 lines above L162 in the same file with its own Gate 2. *I record this because a reviewer that accepted the brief's framing would have filed a refutation of a correct step and missed the one below.*

### What is actually wrong: the prefactor $\lambda/(\sqrt2J)$ is dropped

[L158](../findings/second-order.md)'s settled display is

$$\text{branch 2}=\underbrace{\frac{\lambda(1-\eta^*)^2}{\sqrt2\,J}}_{K}\cdot\frac{\sqrt{c_p+\rho^{\mathrm{eff}}_nw^2}}{n\,\phi(w)}=\frac\lambda{\sqrt2\,J}\cdot\frac{G(w)}{n\,\phi(w)}=\frac\lambda{\sqrt2\,J}\cdot\frac{F(w)}n,$$

because $G=(1-\eta^*)^2\sqrt{c_p+\rho^{\mathrm{eff}}_nw^2}$ already carries the $(1-\eta^*)^2$. **L162 writes "branch 2 reads $G(w)/(n\phi(w))$" and concludes $r_n\gtrsim\min_wF/n$. That drops $\lambda/(\sqrt2J)$ entirely.**

$J$ is [L156](../findings/second-order.md)'s optimum, $J^*=C/\gamma^*=\tfrac{4(n-2)(2n-3)}{(n-1)^2}$, which is $\tfrac{840}{121}=6.94215$ at $n=12$, the value L156 prints. Hence

$$\frac{\lambda(12)}{\sqrt2\,J^*(12)}=\frac{121\sqrt3}{1260\sqrt{\sqrt{55}-3\sqrt6}}=0.639127186 .$$

**The corrected constant.** $0.639127\times0.386728=\mathbf{0.2471682}$, so branch 2's infimum at $n=12$ is $0.0205974$, **which is the $0.0206$ L158 records in terms**, three digits, from constants I took independently. The overstatement factor is $n/K=18.7756$, and the record already names it: **[ROUND_L158](../verification/ROUND_L158.md) line 90, "$0.38673$ is not branch 2 … missing $\lambda/(\sqrt2J)$ and $1/n$ … smaller by a factor $18.8$"**, and [L158](../findings/second-order.md)'s own body, *"neither is branch 2, which carries a further $\lambda/(\sqrt2J)$ and $1/n$ and is $0.0206$ at $w_0$"*.

> **L162 CONTRADICTS ITSELF ABOUT THIS, TWO PARAGRAPHS APART.** *Its **Scope** says "**what this does not do is turn $F$ into a radius: the reach carries further factors**".* **Its display immediately above says $r_n\gtrsim0.38673/n$.** *The caveat is correct and the display is the thing the caveat forbids, and the display is what [INDEX-results.md](../findings/INDEX-results.md) row 162 and [plan.md](../plan.md)'s I2 will read.*

### The monotonicity reverses once the prefactor is restored

$\lambda$ falls steeply on $n\ge12$, its pole at $n=6+2\sqrt7=11.29$ sits $0.71$ below the smallest admissible dimension, while $J^*$ rises to $8$. So $K(n)=\lambda/(\sqrt2J^*)$ falls by a factor $4.7$ across the range, against $F$'s rise by a factor $2.3$. **The product falls.**

| $n$ | 12 | 14 | 16 | 20 | 30 | 100 | $\to\infty$ |
|---|---|---|---|---|---|---|---|
| $K(n)$ | 0.63913 | 0.34545 | 0.27569 | 0.22183 | 0.18036 | 0.14587 | 0.13537 |
| $\min_wF$ | 0.38673 | 0.51441 | 0.57122 | 0.63612 | 0.71468 | 0.84271 | 0.90304 |
| $n\cdot$branch 2 | **0.24717** | 0.17770 | 0.15749 | 0.14178 | 0.13079 | 0.12374 | **0.12225** |

*(the middle row is L162's own screened list, reproduced to every printed digit, see item 3)*

**So the clause "$\ge0.38673/n$ at every $n\ge12$ on the screened ordering" fails twice over.** The constant is wrong by $18.8\times$; and the sign of the ordering is wrong, $n\cdot$branch 2 **decreasing** monotonically to $0.1222475$, which it approaches from above and never attains. **$n=12$ is the best dimension for this bound, not the worst.** The correct statements are

$$r_n\ \gtrsim\ \frac{0.24717}n\ \text{ at }n=12,\qquad r_n\ >\ \frac{0.12224}n\ \text{ for every even }n\ge12 .$$

*The order claim $\Omega(n^{-1})$ survives intact*, $K$ is bounded below by $0.13537$, which is exactly the reason [L149](../findings/second-order.md) gives for the order carrying through where the numeral does not.

> **A THIRD FACTOR, WHICH L158's DISPLAY ALSO CARRIES AT ITS ASYMPTOTIC VALUE.** *Branch 2 is the reach $\eta^*\rho=\eta^*\gamma g_n/\lVert H\rVert_{op}$, so the $\tfrac{\sqrt2}n$ in that display is $g_n$ read at $n\to\infty$.* **The exact $g_n=\sqrt{2(n-2)}/(n\sqrt{n-1})$ is $0.9534626$ of it at $n=12$**, the "$4.9\%$ low in the unsafe direction" L158's own constants bullet flags and its own display then does not apply. Carrying it, $n\cdot$branch 2 reads $0.2356657$ at $n=12$ and still decreases to the same $0.1222474$.

### The infimum, the placement of $(1-\eta^*)^2$, and $\Omega(n^{-3/2})$

- **$(1-\eta^*)^2$ is correctly placed.** [L157](../findings/second-order.md)'s crossing identity is $\eta^*\gamma=\tfrac{\lambda\sqrt{c_p+\rho^{\mathrm{eff}}_nw^2}}{2J}(1-\eta^*)^2$, and branch 2 is $\eta^*\rho=\eta^*\gamma g_n/\lVert H\rVert_{op}$, so the factor multiplies $\sqrt{c_p+\rho^{\mathrm{eff}}_nw^2}$ in the numerator. Rationalising, $1-\eta^*=\tfrac2{\sqrt{4t+1}+1}=\tfrac2{q+1}$, so $(1-\eta^*)^2=4/(q+1)^2$ and $G=4s/(q+1)^2$ **is** the entry's $F$-formula. *It is $w$-dependent through $t=\beta s$ and stays inside the minimisation, which is what L158 charged an earlier reading with getting wrong; L162 keeps it inside.*
- **The infima commute in the safe direction only, and that is the direction needed.** $\inf_H\min(b_1,b_2,b_3)\ge\min(\inf b_1,\inf b_2,\inf b_3)$ holds however the branches' variables are coupled, so taking branch 2's infimum separately is sound. **What is not sound is stopping there:** $r_n$ is the minimum over three branches and **L162 prices one and names the result $r_n$**, mentioning branches 1 and 3 nowhere. That branch 2 is the smallest is [L158](../findings/second-order.md)'s result, established at $n=12$ against $S\le4.162$ with threshold $T=18.00$; [results.md](../results.md) records branch 1's infimum's *order* as "**not settled**". **The radius display inherits an open question it does not cite.**
- **No contradiction with $\Omega(n^{-3/2})$, and they are about different things.** [L145](../findings/second-order.md)'s $\Omega(n^{-3/2})$ is an all-branch, all-direction lower bound with its own proof; $\Omega(n^{-1})$ is branch 2 alone and is strictly stronger where it applies, $\Theta(n^{-1})$ being the recorded ceiling of the method. *A larger lower bound cannot contradict a smaller one*, the record makes this point twice, in L149's box and in L147's. **The two coexist, and the branch-2 figure becomes a statement about $r_n$ only through L158's branch comparison.**

---

## Item 3, the scope correction. CONFIRMED, every figure.

**$G$ is increasing in $w$.** $\partial G/\partial s=4/(q(q+1)^2)>0$ from item 1, and $s=\sqrt{c_p+\rho^{\mathrm{eff}}_nw^2}$ increases in $w$ because $\rho^{\mathrm{eff}}_n>0$ on $n\ge12$ ([L149](../findings/second-order.md)'s positivity, $6>\tfrac{49\cdot55}{900}$). **So $G$ alone is minimised at $w=0$ and the entry is right that the claim is about the ratio.**

**The drift is real, not an artefact of the $\min$.** Minimising $F=G/\phi$ on $[0,w_0]$, the interval where $\phi$ is the smooth arm, since $\phi\equiv1$ above $w_0$ and $G$ rises there, by golden-section refinement of a grid, at 30 digits:

| $n$ | $w_0$ | $\arg\min F$ | $\min_wF$ | $F(w_0)$ | shortfall |
|---|---|---|---|---|---|
| 12 | 0.66667 | **0.66667** | 0.3867277 | 0.3867277 | 0 |
| 14 | 0.71429 | **0.71429** | 0.5144069 | 0.5144069 | 0 |
| 16 | 0.75 | 0.73881 | 0.5712203 | 0.5712630 | 0.0075 % |
| 20 | 0.8 | 0.69926 | 0.6361226 | 0.6391272 | 0.4723 % |
| 30 | 0.86667 | 0.64338 | 0.7146792 | 0.7251293 | 1.4622 % |

**The block's $0.7388$, $0.6992$, $0.6434$ and its $0.01\%$, $0.47\%$, $1.46\%$ are all reproduced**, as is its whole screened list $0.38673$, $0.51441$, $0.57122$, $0.60861$, $0.63612$, $0.67551$, $0.71468$, $0.78337$, $0.84271$ at $n=12,14,16,18,20,24,30,50,100$. *(A screen: five golden-section refinements on a function I built from the definitions, seconds of arithmetic, recorded as a screen.)* The minimiser at $n\ge16$ is a genuine interior stationary point of $G/\phi$ strictly inside $(0,w_0)$, where $\phi$ is the smooth arm and the $\min$ is inactive, **so it is not an artefact of the kink**. The mechanism is the one [L158](../findings/second-order.md) names: $\phi'(w_0)=\tfrac n{2(n-2)}$ falls toward $\tfrac12$ while $\tfrac1{2\sqrt{c_p}}\sim0.243\sqrt n$ rises, and the AM–GM sufficient condition that pins the minimiser to the kink stops holding once they cross.

**What consumes the kink above $n=14$, and it is inert.** The threshold $T=\tfrac{\kappa\sqrt2J}{\lambda(1-\eta^*)^2s_\rho(w_0)}$ in [L158](../findings/second-order.md) and [results.md](../results.md) is evaluated at $w_0$ across the whole range, including the $n\approx1140$ crossing. **The drift lowers branch 2 by up to $1.5\%$, which *raises* $T$, so branch 2 binds more surely and the conclusion is untouched**, the error runs in the safe direction. *The one place the drift is load-bearing is L162's own "$\ge0.38673/n$ at every $n\ge12$", and there the screened $\min_wF$ was used rather than $F(w_0)$, so that clause fails for the prefactor reason of item 2 rather than for this one.*

---

## Corrections owed

1. **[L162](../findings/second-order.md)'s radius display.** Replace $r_n\gtrsim\min_wF/n$ by $r_n\gtrsim\tfrac\lambda{\sqrt2J}\cdot\tfrac{\min_wF}n$, i.e. $0.24717/n$ at $n=12$, or $0.23567/n$ carrying the exact $g_n$. **The same correction is owed on [INDEX-results.md](../findings/INDEX-results.md) row 162**, which prints the uncorrected form.
2. **The ordering clause.** "$\ge0.38673/n$ at every $n\ge12$" must become $>0.12224/n$, an infimum approached as $n\to\infty$ and not attained; and the sentence "$n=12$ is the worst case" holds of $F(w_0)$ but is **false of the radius**, where $n=12$ is the best case.
3. **The branch-1 and branch-3 dependency.** The radius sentence should cite [L158](../findings/second-order.md) for branch 2 binding, and record that branch 1's infimum's order is open.
4. **The squaring justification in item 1.** "*legitimate since both are positive there*" → $D>0$ is sufficient for either sign of $P$, which changes sign at $n=85.229$.

## What would falsify each verdict

- **Item 1**, a coefficient of $D(12+u)$ that is not positive; a sign error in $\partial\theta_0/\partial n$ or in $C'$; a demonstration that $S$ is not $c_p+\rho^{\mathrm{eff}}_nw_0(n)^2$ with $w_0$ varying, in which case my $S'$ is not the chain's.
- **Item 2**, a place on the record where branch 2 is defined **without** the $\lambda/(\sqrt2J)$ prefactor, so that $G/(n\phi)$ is the branch rather than $K^{-1}$ times it. *I checked [L149](../findings/second-order.md), [L156](../findings/second-order.md), [L157](../findings/second-order.md), [L158](../findings/second-order.md), [results.md](../results.md) and [ROUND_L158](../verification/ROUND_L158.md); all five carry it, and two of them warn against exactly the omission L162 makes.* Also: an argument that $J$ should be $1$ rather than [L156](../findings/second-order.md)'s $J^*$, but then L158's $T=18.00$ and L156's whole optimisation would have to move with it.
- **Item 3**, a minimiser of $G/\phi$ at $w_0$ for some $n\ge16$, i.e. an error in my $\phi$ or $\rho^{\mathrm{eff}}_n$; the shortfall figures matching L162's to four digits at three dimensions makes that unlikely.

**Provenance.** Every constant here was rebuilt from $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ and the closed forms in [L149](../findings/second-order.md), [L156](../findings/second-order.md) and [L157](../findings/second-order.md); no script in [scripts/](../scripts/) was read or run.
