# Review r439, the I2 tube: asymmetry, analyticity radius, remainder constant

*Reviewer r439, 2026-09-03, cold brief. Target: the three claims of the [I2](../plan.md) item, (1) the kernel-free asymmetry, (2) the analyticity radius $g_n$, (3) the remainder constants $C_P$, $C_\delta$ and the exponent $r_n=\Omega(n^{-4})$. Supporting material: [Lemma L133](../findings/second-order.md), [Lemma L141](../findings/second-order.md), the withdrawn [Corollary L140.2](../findings/route-a.md). **Analysis only**: everything below is derived by hand; the one numerical screen re-evaluates closed forms I had already derived, and is reported as a screen.*

## Verdicts

| claim | verdict | one line |
| --- | --- | --- |
| **(1) asymmetry** | **REFUTED as stated** | the universal quantifier is false, the divided-difference blow-up is a *gap* phenomenon and survives at $W^*$ at rate $n$; the load-bearing core (no kernel, analyticity on a ball of radius $g_n$, no atom there) is **CONFIRMED** |
| **(2) analyticity radius** | **CONFIRMED** | every multiplicity, the $\sum\lambda^2=1$ identity, $\lvert\lambda_-\rvert<\lambda_+$, the closed form and $g_{12}=0.1124$ check, recomputed three independent ways; and the claim **silently corrects a live error** elsewhere in the record |
| **(3) remainder constant** | **PLAUSIBLE** | the conclusion $r_n=\Omega(n^{-4})$ survives (as a *lower bound*, which is all $\Omega$ asserts) but three of its four stated reasons are defective, and the true order is $\Omega(n^{-2})$, so read as an order rather than a bound the exponent is **wrong by $n^2$** |

**The one sentence that matters.** The claims are safe in the direction that would have refuted them and unsafe in the direction of their own rhetoric: nothing here makes the tube smaller than advertised, and the advertised asymmetry between $W^*$ and the competitor is a difference of degree (finite versus infinite) that the item presents as a difference of kind.

---

## Claim (2), the spectrum and the gap. CONFIRMED.

I recomputed the whole of it from the product-of-spheres Weyl tensor without reading [Lemma L133](../findings/second-order.md)'s statement first.

**The unnormalised operator.** With unit factors, $R=\mathrm{id}$ on $\Lambda^2V_1\oplus\Lambda^2V_2$ and $0$ on the $m^2$ mixed planes; the metric is Einstein, so $W^*\propto R-\tfrac{m-1}{2m-1}\mathrm{id}$. Raw eigenvalues $\tfrac m{2m-1}$ with multiplicity $2\binom m2=m(m-1)$ and $-\tfrac{m-1}{2m-1}$ with multiplicity $m^2$; trace $\tfrac{m^2(m-1)-m^2(m-1)}{2m-1}=0$.

**The normalisation.** $\sum\lambda^2=\tfrac{m^3(m-1)+m^2(m-1)^2}{(2m-1)^2}=\tfrac{m^2(m-1)}{2m-1}$, so the normaliser is $m\sqrt{\tfrac{m-1}{2m-1}}$ and

$$\lambda_+=\frac1{\sqrt{(m-1)(2m-1)}},\qquad \lambda_-=-\frac1m\sqrt{\frac{m-1}{2m-1}}.$$

**Every stated check passes.**

| check | value | claim |
| --- | --- | --- |
| multiplicities | $m(m-1)+m^2=m(2m-1)=\binom n2$ | full, so **no kernel** ✓ |
| $\sum\lambda^2$ | $\tfrac m{2m-1}+\tfrac{m-1}{2m-1}=1$ | exact ✓ |
| $\lvert\lambda_-\rvert/\lambda_+$ | $\tfrac{m-1}m<1$ | ✓, so the gap at $0$ **is** $\lvert\lambda_-\rvert$ |
| $g_n$ | $\tfrac1m\sqrt{\tfrac{m-1}{2m-1}}=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}\to\tfrac{\sqrt2}n$ | ✓ |
| $g_{12}$ | $\tfrac5{6\sqrt{55}}=\tfrac16\sqrt{5/11}=0.112367$ | ✓ |

**Two independent cross-checks that the record itself supplies, and which the derivation could have failed.** [bounds.md](../findings/bounds.md) states, from a route with nothing in common with L133, that at the balanced product $\lambda_{\max}/\lvert\lambda_{\min}\rvert=n/(n-2)$; my spectrum gives $\lambda_+/\lvert\lambda_-\rvert=m/(m-1)=n/(n-2)$. The same passage states that the $\lambda_{\min}$ row of the calculus returns $\theta\le-\lvert\lambda_{\min}\rvert+(n-2)\lambda_{\max}=\theta_0$ *exactly*; substituting my spectrum,

$$-\lvert\lambda_-\rvert+(n-2)\lambda_+=\lambda_+(m-1)\frac{2m-1}{m}=\frac{\sqrt{(m-1)(2m-1)}}{m}=\frac{\sqrt{2(n-1)(n-2)}}{n}=\theta_0(n),$$

which reproduces $\theta_0(12)=\sqrt{55}/6=1.23603$. So the normalisation is pinned by two facts outside the lemma, not only by $\sum\lambda^2=1$.

**The norm convention is the right one.** [conventions.md](../findings/conventions.md) fixes "$\mu=\operatorname{spec}(M)$ on $\Lambda^2$ at $\lVert M\rVert_F=1$, with $\sum\mu^2=1$", exactly the convention under which the displayed eigenvalues are unit-normalised. The file's warning that the $\tfrac12$ goes at the $\Lambda^2$ level and that misplacing it inflates $\theta$ by $\sqrt2$ does not bite here, because the $\theta_0$ cross-check would have caught a $\sqrt2$.

**Is $\lvert\lambda_-\rvert$ the quantity an analyticity radius needs?** Yes. $W\mapsto W_-$ is real-analytic exactly where no eigenvalue touches $0$; Weyl's inequality plus $\lVert H\rVert_{\mathrm{op}}\le\lVert H\rVert_F$ makes a *Frobenius* ball of radius $\min_a\lvert\lambda_a\rvert=g_n$ safe. The degeneracy of the spectrum (multiplicities $m(m-1)$ and $m^2$), is harmless, and this is worth saying because it is where a careless reading fails: individual eigenvalues and eigenvectors are *not* analytic under degeneracy, but $W_-=W\,\Pi(W)$ with $\Pi$ the Riesz projection is, since $\Pi$ is a contour integral of the resolvent and has no pole while the spectrum avoids the contour.

### FINDING A, claim (2) silently corrects a live error in the record it is derived from.

[Lemma L133](../findings/second-order.md) Step 1 says "a spectral gap at $0$ of **relative** size $\tfrac{m-1}{2m-1}$", and $\tfrac{m-1}{2m-1}=\lvert\lambda_-\rvert/(\lambda_+-\lambda_-)$ is indeed dimensionless and tends to $\tfrac12$. But [plan.md](../plan.md) line 35 drops the word and asserts "the balanced product has **gap** $(m-1)/(2m-1)$", and [Lemma L141](../findings/second-order.md)'s closing paragraph says the defect's remainder "is controlled through the **spectral gap** $\tfrac{m-1}{2m-1}$ at $W^*$ by the resolvent".

**A resolvent bound needs the absolute gap, and the absolute gap is $g_n=\Theta(1/n)$, not $\to\tfrac12$.** Anything derived from the $\tfrac{m-1}{2m-1}$ reading gets $C_\delta=O(1)$ and $r_n=\Omega(1/n)$, overstated by a factor $n$. Claim (2) uses the right quantity; the record still carries both readings in two places, and they are the two places a successor would look.

---

## Claim (1), the asymmetry. REFUTED as stated; its core CONFIRMED.

**What is true.** $W^*$ has no kernel (multiplicities sum to $\binom n2$, both eigenvalues nonzero). $W\mapsto W_-$ is real-analytic on the ball of radius $g_n$ about it, and $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$ with it. Inside that ball there is no kink, no one-sided derivative, and no distributional atom, the atom [Corollary L140.2](../findings/route-a.md)'s withdrawal identifies has density $2\lvert\lambda'\rvert\,\mathrm{Alt}(W_-)(v,v)$ for $v\in\ker W$ and is therefore supported on the **zero-eigenvalue locus** alone. Eigenvalue crossings *within* the two spectral groups, which are abundant near $W^*$ given the multiplicities, do not produce atoms and do not break analyticity: only a crossing of $0$ does. **So the brief's suspicion that any nearby crossing would reinstate the atom is unfounded**, and I record that as a check the claim passes.

### FINDING B, the universal quantifier is false, and the item's rhetoric turns on it.

The claim is that **every** difficulty that refuted the competitor-side lemmas arises from $u$'s kernel. Two of the five listed do not.

- **The divided-difference blow-up.** [Corollary L140.2](../findings/route-a.md)'s withdrawal states the mechanism explicitly: "$\phi_\Omega=O(d)$ but $\phi''_\Omega$ **blows up like $1/g$ at an opposite-sign eigenvalue pair of scale $g$**". That is a statement about a **gap**, not about a kernel. At $W^*$ the opposite-sign pair is $(\lambda_+,\lambda_-)$ with separation $\lambda_+-\lambda_-=\Theta(1/n)$, so the identical blow-up is present at $W^*$, at rate $n$ per extra derivative rather than at rate $\infty$. It is not removed by the absence of a kernel; it is *bounded* by the smallness of the gap, and the bound degrades with $n$. **Claim (3)'s entire $n^3$ is the price of this surviving blow-up**, which is the clearest possible evidence that it survives: if the difficulty really were a property of the competitor, $C_\delta$ would be $O(1)$.
- **The nonexistent $\mathcal E_D$.** [route-a.md](../findings/route-a.md) retires $\mathcal E_D$ twice, and neither time for a reason that a nonsingular base point would supply. [r427](REVIEW_r427.md) retired the obstacle outright ("$\varphi\ge0$ with $\varphi(0)=0$ gives $\varphi'(0^+)\ge0$ **from nothing else**), no Hansen–Pedersen, no $\mathcal E_D$, no nonsingularity hypothesis", i.e. it was never needed. And [r429](REVIEW_r429.md) **withdrew** the claim that $\mathcal E_D$ fails to exist on $\{F=0\}$. Listing it among the obstructions that $W^*$'s nonsingularity dissolves misattributes an item that was closed for an unrelated reason and partly reversed.

### FINDING B′, the asymmetry is quantitative and shrinks at the rate that sets the tube.

The claim's protection has radius $g_n=\Theta(1/n)$: the guarantee that no eigenvalue reaches $0$ expires at distance $g_n$, and $g_n\to0$. So the correct statement is not *"the competitor's difficulties are properties of the competitor rather than of the problem"* but *"they are properties of the zero-eigenvalue locus, from which $W^*$ stands off by $\Theta(1/n)$, and every derivative of $\delta^2$ pays $\Theta(n)$ for that proximity."* This is the same shape as the failure the brief names, a fact at a point (no kernel **at** $W^*$) read as a fact on a neighbourhood (a structural asymmetry of the problem), with the difference that here the neighbourhood is genuinely there, and merely shrinks.

**What this costs.** Nothing in claim (3)'s arithmetic, which already pays the $g_n^{-1}$ per derivative. It costs the item its grading argument: "*every difficulty this route lost lemmas to today is a property of the competitor rather than of the problem, which is why this item keeps its grade while I3 fell to $0$*" is not supported by what I can verify.

---

## Claim (3), the remainder constant. PLAUSIBLE.

### $C_P=O(n)$, CONFIRMED, and by a route that needs no critical point.

The stated chain is valid. $P(W)=\langle W,Q(W)\rangle$ is a homogeneous cubic, so $P(-W)=-P(W)$ and $\sup\lvert P\rvert=\sup P$ on the unit sphere **with no critical-point argument at all**; $\sup P$ is attained by compactness, hence at a critical point, where $Q(W)=\theta W$, and [conventions.md](../findings/conventions.md) records that $Q$ maps $\mathcal W_n$ to itself, so the projection subtlety that would otherwise arise (criticality on $S\subset\mathcal W_n$ gives $\Pi_{\mathcal W}Q(W)=\theta W$) is void. Then [Lemma L107](../findings/bounds.md) gives $\theta\le(n-1)\lvert\lambda_{\min}\rvert\le n-1$ since $\sum\lambda^2=1$. **The critical-point restriction that [bounds.md](../findings/bounds.md) flags on the row calculus ("(C) holds only at critical points"), is therefore respected**, because the chain only ever evaluates L107 at a maximiser.

An independent unconditional route confirms it: $P=\operatorname{tr}W^3+\langle W,W^\#\rangle$, with $\lvert\operatorname{tr}W^3\rvert\le\sum\lvert\lambda\rvert^3\le(\sum\lambda^2)^{3/2}=1$ and [second-order.md](../findings/second-order.md)'s *pointwise* $\langle W,W^\#\rangle\le(n-2)y$, $y=\lVert\lambda\rVert_4^2\le1$, two-sided, since $\#$ is quadratic so $(-W)^\#=W^\#$. Hence $\lvert P\rvert\le n-1$ everywhere on the unit sphere.

### FINDING C, the trigonometric tail. The premise is false; the order survives.

[Lemma L141](../findings/second-order.md) and claim (3) both assert that "$P$'s own remainder along a great circle is **exactly** $\sin^3t\,P(H)$". It is not. Writing $B$ for the symmetric trilinear form,

$$P(\cos t\,W^*+\sin t\,H)=\cos^3t\,\theta_0+3\cos^2t\sin t\,B(W^*,W^*,H)+3\cos t\sin^2t\,B(W^*,H,H)+\sin^3t\,P(H).$$

The second term vanishes ($B(W^*,W^*,H)=\theta_0\langle W^*,H\rangle=0$ by criticality and $H\perp W^*$), but the **first and third both carry third-order tails**: $\cos^3t=1-\tfrac32t^2+O(t^4)$ contributes $\theta_0\cdot O(1)$, and $B(W^*,H,H)=\tfrac16\mathrm{Hess}\,P[H,H]=O(\theta_0)$ by [Lemma L24](../findings/second-order.md) contributes $O(1)$. So the third-order remainder is $O(\theta_0+\lvert P(H)\rvert)$, not $\sin^3t\,P(H)$. Since $\theta_0<\sqrt2$, the tail is $O(1)$ and is dominated by $\lvert P(H)\rvert\le n-1$: **$C_P=O(n)$ stands, the stated reason does not.** (This same "exactly $\sin^3t\,P(H)$" appears in [Corollary L140.2](../findings/route-a.md)'s withdrawal notes as the term "left unpaid at equality", so the error is not local to I2.)

### The Riesz step, sufficient, with the reason understated.

Three sub-questions, all of which the claim survives, and I record them as passed so they are not re-opened.

- **Is $\rho<g_n$ enough for *holomorphy*, or is the contour condition stronger?** It is enough, a fortiori. Holomorphy of $\Pi$ needs only that the two spectral groups stay off a separating contour; with a circle about $\lambda_-$ of radius $R=\tfrac{\lambda_+-\lambda_-}2$ the safe perturbation is $R=\tfrac{2m-1}{2(m-1)}g_n>g_n$. So the binding constraint is the *real* one, no eigenvalue may cross $0$, or the holomorphic continuation ceases to equal $W_-$ on the real axis, which is $g_n$. The claim states $\rho<g_n$ and gives the zero-gap reason; the contour reason is the one holomorphy actually needs, and it is weaker. **Both radii are $\Theta(g_n)$, so the exponent is untouched.**
- **Is a complex-direction perturbation of a Hermitian matrix still diagonalisable?** In general no, a complex symmetric matrix can be defective. **It does not matter**: neither the Riesz projection nor the resolvent bound uses diagonalisability. Eigenvalue localisation comes from Bauer–Fike, which is exact for a Hermitian unperturbed matrix (condition number $1$), and the resolvent bound from the Neumann series, $\lVert(z-W(t))^{-1}\rVert\le(d_0-\lVert E\rVert)^{-1}$ with $d_0=\operatorname{dist}(z,\operatorname{spec}W^*)$. At $\rho=g_n/2$ this is $O(1/g_n)$, matching the claim's $O(1/(g_n-\rho))$.
- **Does the projection stay bounded?** Yes, $\lVert\Pi\rVert\le R/(R-\rho)\le2$, but it is **not** an orthogonal projection off the Hermitian locus, so $\lVert\Pi\rVert\le1$ would be false. The claim does not assert it; a successor might.

### FINDING D, the Cauchy step is wrong, in the safe direction, by two powers of $n$.

Cauchy's estimate needs $M:=\sup_{\lvert t\rvert=\rho}\lVert\mathrm{Alt}(W(t)_-)\rVert_F$, and the claim implicitly takes $M=O(1)$. **It is $O(g_n)$.** Expand the resolvent about $W^*$ with $E(t)=W(t)-W^*$, $\lVert E\rVert_F\le\rho$ for $\lvert t\rvert=\rho$:

- the zeroth term integrates to $W^*_-$, which has $\lVert W^*_-\rVert_F=\sqrt{\tfrac{m-1}{2m-1}}\approx\tfrac1{\sqrt2}$, **and is annihilated by $\mathrm{Alt}$**, since $W^*_-=\lambda_-(\mathrm{id}-P_{\Lambda^2V_1}-P_{\Lambda^2V_2})$ and each of those three is a curvature operator satisfying the first Bianchi identity ([Lemma L133](../findings/second-order.md) Step 1);
- the first term is the Daleckii–Krein derivative, entrywise multipliers in $[0,1]$, so of Frobenius norm $\le\lVert E\rVert_F=O(g_n)$;
- the $k$-th term is $O(g_n)\cdot2^{-k}$ at $\rho=g_n/2$, the geometric factor being $\rho/(\lambda_+-\lambda_-)$.

Hence $M=O(g_n)$ and $\lVert A^{(k)}(0)\rVert\le k!\,M/\rho^k=O(g_n^{1-k})$, i.e. $A'=O(1)$, $A''=O(n)$, $A'''=O(n^2)$, not $O(n^3)$.

**Two independent confirmations of the corrected scaling.** (i) $A'=O(1)$ is exactly [Lemma L141](../findings/second-order.md)(a)'s $\lVert D(\mathrm{Alt}\,W_-)[H]\rVert\le\tfrac12\lVert H\rVert$, a constant with no $n$ in it. (ii) The order-$k$ divided difference of a piecewise-linear function over two points scales as $\Delta^{-(k-1)}$ with $\Delta=\lambda_+-\lambda_-$; at $k=3$ that is $g_n^{-2}$.

### FINDING E, the step to $\delta^2$ loses a further power, again in the safe direction.

$\delta^2=\lVert A\rVert^2$, so $(\delta^2)'''=2\langle A''',A\rangle+6\langle A'',A'\rangle$. Because $A(0)=\mathrm{Alt}(W^*_-)=0$ we have $\lVert A(t)\rVert=O(t)$ on the real segment, so

$$\lvert(\delta^2)'''(t)\rvert=O(n^2t)+O(n)=O(n)\qquad\text{for }\lvert t\rvert\le r=O(1/n).$$

The $\binom n4$-fold sum the withdrawal note warns about is already inside these Frobenius norms, this is where that count is paid, and it is paid in full.

### The consequence for the exponent.

Balancing $c_n t^2$ against $\tfrac16(C_P+\lvert\kappa_n\rvert C_{\delta^2})t^3$ with $c_n=3\theta_0/(n-2)=\Theta(1/n)$, $C_P=O(n)$, $C_{\delta^2}=O(n)$ and $\lvert\kappa_n\rvert\le1.71=O(1)$ gives

$$\boxed{r_n=\Omega(n^{-2})},$$

self-consistently, since $n^{-2}\le n^{-1}$. **So $r_n=\Omega(n^{-4})$ is true** ($\Omega$ asserts a lower bound, and a better lower bound cannot refute it), **and slack by $n^2$.** The exponent survives in the $\Omega$ reading only. If the item means $r_n\asymp n^{-4}$, that is wrong, and the plan's phrasing "$r_n=\Omega(g_n^3c_n)$" invites exactly that reading by naming the two factors as though they were the answer.

**Domination.** $C_P=O(n)$ against $C_\delta$: confirmed either way, since on the claim's own numbers $n\ll n^3$ and on the corrected ones $n\lesssim n$, in the corrected accounting **$C_P$ and $C_{\delta^2}$ are the same order**, so the assertion that "$C_\delta$ dominates" is false as a strict statement while harmless as a bound.

### FINDING F, an inherited defect in $c_n$'s own lemma, repairable.

Claim (3) imports $c_n=3\theta_0(n)/(n-2)$ from [Lemma L141](../findings/second-order.md)(b). The lemma's conclusion is correct, and I re-derived it independently: [Lemma L27](../findings/nondegeneracy.md)'s within-factor pair gap is $\tfrac12-\tfrac{m-2}{2(m-1)}=\tfrac1{n-2}$, and $\tfrac12\mathrm{Hess}=3\theta_0(L_e-\tfrac12)$ gives exactly $-3\theta_0/(n-2)$ per unit norm.

**But the written proof of the block comparison fails at $n=12$.** It bounds $Q\le-4.598\lvert\kappa_n\rvert\sigma\lVert H\rVert^2$ on the $(2,2)$ four-set block with $\sigma\le\tfrac29$, and asserts this is more negative than $-c_n$ at every $n\ge12$. Screen (re-evaluating closed forms already derived, reported as a screen):

| $n$ | written bound $-4.598\lvert\kappa_n\rvert\sigma$ | true $(\kappa_n^{\mathrm{Hess}}-\kappa_n)\sigma$ | $-c_n$ | written chain |
| --- | --- | --- | --- | --- |
| 12 | $-0.1038$ | $-1.0899$ | $-0.3708$ | **fails** |
| 14 | $-0.3397$ | $-1.1878$ | $-0.3154$ | holds |
| 20 | $-0.7626$ | $-1.3598$ | $-0.2179$ | holds |
| $\to\infty$ | $-1.7423$ | $-1.7424$ | $\to0$ | holds |

The defect is the substitution of the $n\to\infty$ infimum ratio $5.598$ where $n=12$'s actual ratio is $49.27$; the true value on that block clears $-c_n$ at every $n\ge12$ with room. **The constant $c_n$ stands; one line of L141(b)'s proof does not.**

### Checks claim (3) passes, recorded so they are not re-opened.

- **The tube-to-great-circle reduction needs no normal injectivity radius.** Take $W_0$ a *minimiser* of $\lVert W-\cdot\rVert$ over the compact orbit; first-order optimality gives $W-W_0\perp T_{W_0}\mathcal O$, and $W_0\perp T_{W_0}\mathcal O$ since the orbit lies in the sphere, so the great-circle direction $H$ lands in $T_{W_0}S\cap T_{W_0}\mathcal O^\perp$, exactly [Lemma L141](../findings/second-order.md)(b)'s domain, including [r431](REVIEW_r431.md)'s exclusion of the radial direction. Free, and it needs stating.
- **Uniformity over the orbit** is supplied by the $SO(n)$-invariance of $P$ and $\delta^2$; every constant above depends on $H$ only through $\lVert H\rVert=1$.
- **$\kappa_n<0$ for every $n\ge12$** (since $\theta_0>\sqrt{3/2}$ there), so $\theta_0+\kappa_n\delta^2<\theta_0$ inside the tube: the tube statement is **strictly stronger** than $P\le\theta_0$, and is not vacuous in that sense.

---

## Vacuity and overreach

**Not vacuous, and smaller than the framing suggests.** Three separate readings:

- **As a statement**, it is non-vacuous: the tube is a nonempty open neighbourhood of the conjectured maximiser, $\delta^2=\Theta(t^2)$ is genuinely small there, and with $\kappa_n<0$ the inequality proved is strictly stronger than $P\le\theta_0$.
- **As a contribution to a covering argument**, it is negligible. $\dim\mathcal O=m^2=n^2/4$ inside $\dim\mathcal W_n=\tfrac{n(n+1)(n+2)(n-3)}{12}$ (at $n=12$, $36$ inside $1638$, codimension $1602$) so a tube of radius $r_n$ has relative volume of order $r_n^{1602}$. No covering of the sphere is advanced by it.
- **As a reduction**, it converts the open [I6](../plan.md) problem from "cover everything" to "cover everything outside an $n^{-2}$-tube", and γ has no method. Worse, the region it leaves uncovered is the *hardest* one: throughout the annulus $r_n<\operatorname{dist}(W,\mathcal O)\ll1$ the penalised Hessian gap is still only $c_n=\Theta(1/n)$, so the difficulty that the tube handles by Taylor expansion persists immediately outside it with no new instrument.

**What the tube genuinely buys, stated positively.** It upgrades [Lemma L133](../findings/second-order.md)'s point statement (L16 is not refuted *at* $W^*$), to a neighbourhood statement with an explicit radius, and it does so with every constant traceable. That is a real advance over "at the conjectured maximiser only", and it is the whole of the advance.

---

## What a successor should fix

1. **Delete the universal quantifier from claim (1)** and replace it with the positive statement: the obstructions are properties of the zero-eigenvalue locus, from which $W^*$ stands off by $g_n=\Theta(1/n)$, at a cost of $\Theta(n)$ per derivative of $\delta^2$.
2. **Fix the two "gap" citations**, [plan.md](../plan.md) line 35 and [Lemma L141](../findings/second-order.md)'s closing paragraph both name $\tfrac{m-1}{2m-1}$, a *relative* gap, where the resolvent needs the absolute $g_n$.
3. **Replace "exactly $\sin^3t\,P(H)$"** with the four-term great-circle expansion; the conclusion $C_P=O(n)$ is unaffected and has a second, unconditional proof.
4. **Redo the Cauchy step with $M=O(g_n)$**, which gives $A'''=O(n^2)$ and $(\delta^2)'''=O(n)$, hence $r_n=\Omega(n^{-2})$, two powers better, and it makes $C_P$ and $C_{\delta^2}$ the same order, so "$C_\delta$ dominates" must go.
5. **Repair [Lemma L141](../findings/second-order.md)(b)'s $n=12$ line**, which uses the asymptotic ratio $5.598$ where $49.27$ is available.

*r439, filed complete. Full working in [agent_logs/r439-tube.log](../agent_logs/r439-tube.log).*
