# REVIEW r446, adversarial audit of [I2](../plan.md) ingredient (2): the analyticity radius, the remainder constant and the tube radius

*Cold brief, **analysis only** ([.claude/rules/analysis-only.md](../.claude/rules/analysis-only.md)). Read in full: the [I2](../plan.md) item, [conventions.md](../findings/conventions.md), [Lemma L133](../findings/second-order.md), [Lemma L120](../findings/second-order.md), [Lemma L141](../findings/second-order.md), [post F60](../findings/second-order.md), [Lemma L143](../findings/bounds.md), [r442](REVIEW_r442.md), [r443](REVIEW_r443.md), and the relevant sections of [r441](REVIEW_r441.md), [r444](REVIEW_r444.md), [r445](REVIEW_r445.md). Every derivation below is by hand; one numeric screen of self-constructed objects is reported as a screen and is evidence for nothing. Working: [agent_logs/r446-I2-ingredient2.log](../agent_logs/r446-I2-ingredient2.log).*

## Verdict, per numbered step

| # | Claim | Verdict |
|---|---|---|
| 1 | Two-valued spectrum, multiplicities $m(m-1)$ and $m^2$, no kernel, $g_n=\lvert\lambda_-\rvert=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}$ | **CONFIRMED**, recomputed cold (D1) |
| 2 | $W\mapsto W_-$ and $\delta^2$ real-analytic on a ball of radius $g_n$ about $W^*$ | **CONFIRMED** in the record's Frobenius norm; the ball on which the *quantitative* resolvent bound of step 3 lives is $g_n/2$, not $g_n$ (D2) |
| 3 | Riesz projection holomorphic for $\rho<g_n$ with resolvent $O(1/(g_n-\rho))$; at $\rho=g_n/2$ Cauchy gives $A'''=O(g_n^{-3})$, hence $C_\delta=O(n^3)$ | **REFUTED as stated, twice.** The resolvent bound diverges at the $\rho$ chosen, and the conclusion is off by $n^2$: $C_\delta=O(n)$ (D2, D3) |
| 4 | Per-direction bookkeeping with $\lVert A^{(k)}\rVert=O(n^{k-1})$ and block-additivity of $Q$ gives $r_n=\Omega(n^{-3/2})$ | **CONFIRMED as a lower bound**, reconstructed independently; it does **not** commit the per-direction trap (D4, D5) |

**The exponent I believe: $-3/2$.** $n^{-4}$ is dead, it is $c_n$ divided by the **retracted** $C_\delta=O(n^3)$, and the item's step 3 is the only place that input survives. $n^{-2}$ is a different quantity: the direction-*uniform* quotient $c_n/\sup_HC(H)$. $n^{-3/2}$ is $\inf_H c(H)/C(H)$, which is what a tube radius actually is.

**The one finding worth the cycle is D6**, and it cuts against the item rather than for it: the analyticity radius used throughout is **direction-blind**, and along a direction of small operator norm it is $\Theta(1)$ rather than $\Theta(g_n)$. If the margin-binding directions are of that kind, [I31](../plan.md)'s $\sup\lvert P\rvert=O(1)$ moves the **exponent**, not the constant, contradicting [Lemma L143](../findings/bounds.md)'s "$\sqrt n$ is exactly the threshold" and the demotion of I31 to constant-chasing.

---

## D1, the spectrum: CONFIRMED, and the multiplicities exhaust $\Lambda^2$ exactly

Recomputed from [Lemma L133](../findings/second-order.md)'s setting without reading its arithmetic. With $\lambda_+=a\,\tfrac m{2m-1}$ on $\Lambda^2V_1\oplus\Lambda^2V_2$ (multiplicity $2\binom m2=m(m-1)$) and $\lambda_-=-a\,\tfrac{m-1}{2m-1}$ on the mixed planes (multiplicity $m^2$):

- **Multiplicities.** $m(m-1)+m^2=m(2m-1)=\binom{2m}2=\binom n2$. They exhaust $\Lambda^2\mathbb R^n$ **exactly**, so there is no hidden eigenvalue and no kernel. This is the check the brief asked for and it passes.
- **Trace.** $m(m-1)\lambda_++m^2\lambda_-=\tfrac{a\,m^2(m-1)-a\,m^2(m-1)}{2m-1}=0$.
- **Normalisation.** $\sum\lambda^2=a^2m^2(m-1)/(2m-1)=1$ forces $a=\sqrt{2m-1}/(m\sqrt{m-1})$, whence $\lambda_+=1/\sqrt{(m-1)(2m-1)}$ and $\lvert\lambda_-\rvert=\tfrac1m\sqrt{(m-1)/(2m-1)}$, the item's values. The item's own check $\tfrac m{2m-1}+\tfrac{m-1}{2m-1}=1$ is the same statement and is right.
- **Which side is the gap.** $\lvert\lambda_-\rvert/\lambda_+=(m-1)/m<1$, so $\mathop{\mathrm{dist}}(0,\mathop{\mathrm{spec}})=\lvert\lambda_-\rvert$. Substituting $m=n/2$: $g_n=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}\to\sqrt2/n$, and $g_{12}=\tfrac16\sqrt{5/11}=0.11237$. All as stated.

The normalisation is the record's own, [conventions.md](../findings/conventions.md) puts the $\tfrac12$ at the $\Lambda^2$ level and leaves the operator at plain Frobenius, $\mathop{\mathrm{tr}}(W^2)=\sum\lambda_\alpha^2=1$.

**One observation the item never makes, and it is the key to D3.** A two-valued spectrum with $\sum\lambda^2=1$ over $N=\binom n2$ eigenvalues forces every $\lvert\lambda\rvert\asymp N^{-1/2}$. So

$$g_n\;\asymp\;\frac1{\sqrt{\binom n2}},$$

*asymptotically equal, not merely of the same order*, $g_n\sqrt{\binom n2}\to1$. **The $\Theta(1/n)$ gap is a fact about the record's Frobenius normalisation as much as about $S^m\times S^m$**: in operator normalisation the gap is $\Theta(1)$ and $W^*$ is nowhere near degenerate. This is why the brief's "$\sqrt{\binom n2}$ would move the exponent" is exactly right, and why it moves it by $n^2$ rather than $n$ (D3).

**$\mathrm{Alt}(W^*_-)=0$: CONFIRMED, and it is genuinely about $W^*_-$, not only $W^*$.** Under [conventions.md](../findings/conventions.md)'s sign, $W_-=\tfrac12(\lvert W\rvert-W)\succeq0$, so $W^*_-=\lvert\lambda_-\rvert\,\Pi_{\mathrm{mix}}$ with $\Pi_{\mathrm{mix}}=\mathrm{id}_{\Lambda^2}-P_{\Lambda^2V_1}-P_{\Lambda^2V_2}$. Each of the three is an algebraic curvature tensor satisfying the first Bianchi identity ($\mathrm{id}$ is the round sphere's operator, $P_{\Lambda^2V_i}$ is $S^m\times\mathbb R^m$'s) and $\mathrm{Alt}$ is the orthogonal projection onto $\Lambda^4$, which annihilates every Bianchi tensor. So $\mathrm{Alt}(W^*_-)=0$, and by linearity $\mathrm{Alt}(W^*_+)=0$ too. The claim is load-bearing and it holds.

*Screen (self-constructed objects, seconds, evidence for nothing): at $n=12,20,100,1000$ the multiplicity identity, $\sum\lambda^2=1$, the vanishing trace and the closed form for $g_n$ all hold to machine precision, and $g_n\sqrt{\binom n2}$ runs $0.913\to0.9990$.*

## D2, the two radii are conflated, and step 3's chosen $\rho$ sits where its own bound diverges

Two different balls are in play and the item calls both "$g_n$".

- **Analyticity of $W\mapsto W_-$** holds wherever no eigenvalue is zero. Weyl's inequality with $\lVert E\rVert_{\mathrm{op}}\le\lVert E\rVert_F$ makes the **Frobenius** ball of radius $g_n$ safe. So step 2 is **CONFIRMED**, and the norm direction is the favourable one: no $\sqrt{\binom n2}$ is spent here. ([r441](REVIEW_r441.md) records the same reading; [r442](REVIEW_r442.md)'s FINDING 9 correctly notes that "and no larger" is unproved, which the item does not claim.)
- **A quantitative resolvent bound** needs a contour separating $\lambda_-$ from $\{0,\lambda_+\}$. The best such contour is the circle of radius $g_n/2$ about $\lambda_-$: it is at distance $g_n/2$ from $\lambda_-$, $g_n/2$ from $0$ and $\approx\tfrac32g_n$ from $\lambda_+$. The resolvent on it is $\le2/g_n$, and under a perturbation of operator norm $\rho$ it is $\le1/(g_n/2-\rho)$.

So step 3's "holomorphic on a complex ball of radius $\rho<g_n$, with resolvent norm $O(1/(g_n-\rho))$; at $\rho=g_n/2$" is wrong in both halves: the admissible $\rho$ is $<g_n/2$, and at the stated $\rho=g_n/2$ the correct bound $1/(g_n/2-\rho)$ **diverges**. Taking $\rho=g_n/4$ repairs it with a resolvent $\le4/g_n$. This is a factor of two and changes no exponent, but the item advertises step 3 as the quantitative core of the ingredient, and this is the third factor-of-two the same item has carried ($6\theta_0$ for $3\theta_0$, [r442](REVIEW_r442.md); the relative gap for the absolute one, [r439](REVIEW_r439.md)/[r441](REVIEW_r441.md)).

## D3, $C_\delta=O(n^3)$ is REFUTED, and the $n^2$ between it and the truth is exactly the norm question

The Cauchy step gives $\lVert A^{(k)}(0)\rVert\le k!\,M/\rho^k$ with $M=\sup_{\lvert t\rvert\le\rho}\lVert A(t)\rVert$ and $A(t)=\mathrm{Alt}(W(t)_-)$. **Everything turns on which norm $M$ is measured in, and the answer is Frobenius**, because $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$ is a Frobenius norm.

The contour integral bounds $\lVert W_-\rVert_{\mathrm{op}}=O(g_n)$. Converting that to Frobenius by the rank costs $\sqrt N=\sqrt{\binom n2}\asymp1/g_n$ and gives $M=O(1)$, which is right for $W^*_-$ itself, whose true Frobenius norm is $\sqrt{(m-1)/(2m-1)}\to1/\sqrt2$. Feeding $M=O(1)$ into Cauchy at $\rho=\Theta(g_n)$ gives $\lVert A'''\rVert=O(g_n^{-3})=O(n^3)$, $\lVert A'\rVert=O(n)$, $\lVert A\rVert=O(1)$, and

$$(\delta^2)'''=2\langle A''',A\rangle+6\langle A'',A'\rangle=O(n^3),$$

which is step 3's answer and which yields $r_n=c_n/C_\delta=\Theta(n^{-4})$, **the brief's arithmetic tension, exactly reproduced.** So the tension is real and its source is identified: $n^{-4}$ is what the ingredient says when the rank factor is spent.

**It need not be spent, and the record knows how not to spend it, in one review file and nowhere else.** Frobenius is unitarily invariant, so $\lVert ABC\rVert_2\le\lVert A\rVert_\infty\lVert B\rVert_2\lVert C\rVert_\infty$. Expanding $W_-(z)-W^*_-$ in Neumann terms about $W^*$, every term of order $k\ge1$ contains at least one factor $\Delta=W(z)-W^*$, so the Frobenius norm can be spent **once, on $\Delta$**, and the resolvents kept in operator norm:

$$\lVert W_-(z)-W^*_-\rVert_F\;\le\;\frac{\lvert\Gamma\rvert}{2\pi}\max_{w\in\Gamma}\lvert w\rvert\sum_{k\ge1}\frac{\lVert\Delta\rVert_F\,\lVert\Delta\rVert_{\mathrm{op}}^{\,k-1}}{d^{\,k+1}}\;=\;O(g_n),$$

with $\lvert\Gamma\rvert=O(g_n)$, $\max\lvert w\rvert=O(g_n)$, $d=g_n/2$, $\lVert\Delta\rVert_F=O(\lvert z\rvert)$ and $\lVert\Delta\rVert_{\mathrm{op}}\le\lVert\Delta\rVert_F$. **The zeroth term is the only one that must spend the rank factor on the resolvent itself, and $\mathrm{Alt}$ annihilates it**, that is the whole content of "$\mathrm{Alt}(W^*_-)=0$ kills the unique $\Theta(1)$ term". Hence $M=O(g_n)$, and

$$\lVert A^{(k)}\rVert=O\!\left(g_n/\rho^k\right)=O\!\left(g_n^{\,1-k}\right)=O(n^{k-1}),\qquad (\delta^2)'''=O(n^2)\cdot O(1/n)+O(n)\cdot O(1)=O(n).$$

I derived this cold; it agrees with [r441](REVIEW_r441.md) line 86, which is the only place in the programme it is written down. **Verdicts:**

- Step 3's $C_\delta=O(n^3)$ is **REFUTED**. The correct value is $C_\delta=O(n)$, and the item's own italic correction says so three sentences later. The stale sentence has not been struck.
- The **whole factor $n^2$** between the two is the norm question the brief flags, one factor $\sqrt{\binom n2}\asymp1/g_n$ in $M$, appearing twice through $\lVert A'''\rVert\cdot\lVert A\rVert$ and $\lVert A''\rVert\cdot\lVert A'\rVert$.
- **The estimate that saves it exists only in [r441](REVIEW_r441.md).** No findings file carries $\lVert A^{(k)}\rVert=O(n^{k-1})$ or the mixed-Hölder step; the string "$A^{(k)}$" appears in [second-order.md](../findings/second-order.md) once, inside [post F60](../findings/second-order.md)'s **withdrawal** paragraph, cited as "the record's own Cauchy estimate". It is unnumbered, unproved in the record proper, and has never been through Gate 2 on its own. Ingredient (2) is standing on it.

**Uniformity, which the brief asks about.** The bound above is uniform over unit directions: only $\lVert H\rVert_F=1$ and $\lVert H\rVert_{\mathrm{op}}\le1$ enter, with absolute constants. And the **bootstrap [r441](REVIEW_r441.md) flags as unstated is not needed**: $M=O(g_n)$ holds on the whole disc $\lvert t\rvert\le g_n/4$, so Cauchy at any real centre $\lvert t_0\rvert\le g_n/8$ with radius $g_n/8$ gives $\lVert A^{(k)}(t_0)\rVert=O(n^{k-1})$ **uniformly on the tube**, and $r_n=\Theta(n^{-3/2})\ll g_n/8$. The Taylor remainder's supremum over the interval is therefore available directly.

## D4, the per-direction bookkeeping, reconstructed, and it gives $-3/2$

Reconstructed independently of [r443](REVIEW_r443.md)'s D5 and reaching the same chain. Fix a unit $H\in T_{W^*}S\cap T_{W^*}\mathcal O^\perp$, write $\gamma_H(t)=\cos t\,W^*+\sin t\,H$, and set $u=\lVert A'(0)[H]\rVert$, $v=\lVert H_{(2,2)}\rVert$.

**The $P$-side is exact.** $P$ cubic gives $P(\gamma_H(t))=\theta_0\cos^3t+3\cos t\sin^2t\,\langle W^*\!\circ H,H\rangle+\sin^3t\,P(H)$, the linear term vanishing by criticality. Expanding, the $t^2$ coefficient is $3\langle W^*\!\circ H,H\rangle-\tfrac32\theta_0=\tfrac12\mathrm{Hess}(P|_S)[H,H]$, consistent with [Lemma L24](../findings/second-order.md), and the tail beyond $t^2$ is $\lvert P(H)\rvert t^3+O((\theta_0+\lvert\langle W^*\!\circ H,H\rangle\rvert)t^4)$, with both $O(1)$. **$\lvert P(H)\rvert\le1+\sqrt{n-2}$ applies to the *direction*, not only at critical points**, because [Lemma L143](../findings/bounds.md)'s statement is a supremum over the whole unit sphere and (per [r444](REVIEW_r444.md) D2) its input inequality is pointwise at unit norm. This is load-bearing (the chain needs $\sup\lvert P\rvert$ over tangent directions) and it holds.

**The defect side.** $A(0)=0$ (D1), so $\lVert A(t)\rVert\le u\lvert t\rvert+Kn t^2$ with $Kn=\tfrac12\sup\lVert A''\rVert$ from D3, uniform on the tube. Hence $\delta^2\le u^2t^2+2Knu\lvert t\rvert^3+K^2n^2t^4$, the $u^2t^2$ being exactly the term $Q$ already carries.

**The margin.** $Q$ is block-additive ([Lemma L120](../findings/second-order.md), [Lemma L141](../findings/second-order.md)(b)); $\mathrm{Alt}\circ DW_-$ is block-preserving ([Lemma L133](../findings/second-order.md) step 2, plus $O(n)$-equivariance of $\mathrm{Alt}$), and distinct sign characters are orthogonal, so both terms split with no cross terms. Then $-Q(H)\ge c_p+(c_4-c_p)v^2$ with $c_p=3\theta_0/(n-2)=\Theta(1/n)$ on the pair block and $c_4=3\theta_0(\tfrac12-\mu)-\tfrac29\lvert\kappa_n\rvert=\Theta(1)$ ($1.090$ at $n=12$, $\to1.742$). **And the support table couples the two halves the right way**: $u^2\le\tfrac29v^2$, so $v^2\ge\tfrac92u^2$ and

$$-Q(H)\;\ge\;c_p+\tfrac92(c_4-c_p)\,u^2 .$$

**Putting it together**, $\Phi(\gamma_H(t))\le\theta_0$ holds as soon as

$$c_p+\tfrac92(c_4-c_p)u^2\;\ge\;\lvert P\rvert_\infty t+2\lvert\kappa_n\rvert Knu\,t+\lvert\kappa_n\rvert K^2n^2t^2+O(t^2),$$

i.e. $r(H)\gtrsim\min\big(\underline c(u)/(\lvert P\rvert_\infty+nu),\ \sqrt{\underline c(u)}/n\big)$ with $\underline c(u)=c_p+\Theta(u^2)$. With $\lvert P\rvert_\infty=O(\sqrt n)$:

| branch | $u=0$ | $u\asymp n^{-1/2}$ | $u=\tfrac{\sqrt2}3$ |
|---|---|---|---|
| cubic, $\underline c/(\lvert P\rvert_\infty+nu)$ | $\dfrac{\Theta(1/n)}{\Theta(\sqrt n)}=\Theta(n^{-3/2})$ | $\dfrac{\Theta(1/n)}{\Theta(\sqrt n)}=\Theta(n^{-3/2})$ | $\dfrac{\Theta(1)}{\Theta(n)}=\Theta(n^{-1})$ |
| quartic, $\sqrt{\underline c}/n$ | $\Theta(n^{-3/2})$ | $\Theta(n^{-3/2})$ | $\Theta(n^{-1})$ |

so $\inf_H r(H)=\Theta(n^{-3/2})$, **and $\sqrt n$ is exactly the threshold on $\lvert P\rvert_\infty$ for this arrangement**: at $\lvert P\rvert_\infty=\Theta(n)$ the $u=0$ cubic branch drops to $\Theta(n^{-2})$. Step 4 is **CONFIRMED as a lower bound**, and [Lemma L143](../findings/bounds.md)'s claimed consequence for [I2](../plan.md) is correct as far as this arrangement goes.

*Screen (self-constructed objects, seconds, evidence for nothing): minimising the displayed expression numerically over $u$ with $\lvert P\rvert_\infty=1+\sqrt{n-2}$ and $K=\lvert\kappa_n\rvert=1$ gives $r\,n^{3/2}=1.678,\,1.601,\,1.583,\,1.579$ at $n=100,400,1600,6400$ while $r\,n^2$ doubles each step. Consistent with $-3/2$; it establishes nothing.*

## D5, the per-direction trap is NOT committed, and the reason is worth stating

The brief is right that this programme has lost four items to the shape *fact in a direction $\Rightarrow$ fact on a neighbourhood* ([I3](../plan.md)'s four refuted formulations). **This chain is not one of them, for three independent reasons.**

1. **It is an infimum, not a supremum.** D4 bounds $r(H)$ **below** for every $H$ by an explicit function of a single scalar modulus $u=\lVert A'(0)[H]\rVert\in[0,\tfrac{\sqrt2}3]$, then minimises over $u$. [r436](REVIEW_r436.md)'s $g(x,y)=3\beta\phi(y/x^2)(x^2+y^2)$ defeats a claim of the form $\sup_H(\cdot)$ or one whose per-direction radius has infimum zero. Here the infimum is attained and positive.
2. **The modulus is monotone the right way.** A direction with a *worse* remainder (larger $u$) is forced by the support table to carry more weight on the $(2,2)$ blocks, hence a *larger* margin. Numerator and denominator move together, which is precisely what [post F60](../findings/second-order.md) missed and what makes "per-direction" legitimate here where it was illegitimate in [I3](../plan.md).
3. **Great circles cover the tube, with no tubular-neighbourhood hypothesis.** $\Phi=P-\kappa_n\delta^2$ is $SO(n)$-invariant ($W\mapsto W_-$ and $\mathrm{Alt}$ are equivariant). Any $W$ within distance $r$ of $\mathcal O$ lies on a minimising geodesic of $S$ from some $g\cdot W^*$, meeting $\mathcal O$ orthogonally there; transporting by $g^{-1}$ puts $W=\gamma_H(t)$ with $H\in T_{W^*}\mathcal O^\perp$, $\lVert H\rVert=1$, $\lvert t\rvert\le r$. **Uniqueness of the foot point is never used**, so no bound on the orbit's normal injectivity or focal radius is owed. I raised this as an objection and it does not bite; recording it so a successor does not raise it again.

## D6, THE FINDING: the analyticity radius is direction-blind, and that is where the exponent is still parked

Every estimate above uses one number, $g_n$, as the radius of the disc on which $A$ is holomorphic. **That is the worst case over directions, and the worst case is far from typical.** Along $\gamma_H$,

$$\lVert\gamma_H(t)-W^*\rVert_{\mathrm{op}}\;\le\;\lvert t\rvert\,\lVert H\rVert_{\mathrm{op}}+\tfrac{t^2}2\lVert W^*\rVert_{\mathrm{op}},\qquad \lVert W^*\rVert_{\mathrm{op}}=\lambda_+=\Theta(g_n),$$

so the disc of holomorphy has radius $\Theta\!\big(\min(1,\,g_n/\lVert H\rVert_{\mathrm{op}})\big)$, **not** $\Theta(g_n)$. And by D1's observation $\lVert H\rVert_{\mathrm{op}}\ge\lVert H\rVert_F/\sqrt N\asymp g_n$, so the *best* case is a $\Theta(1)$ radius, attained by any direction whose $\Lambda^2$ spectrum is as flat as $W^*$'s own. On such a direction the same Neumann estimate gives $M=O(1)$ on a $\Theta(1)$ disc, hence $\lVert A''\rVert=O(1)$ in place of $O(n)$, and the quartic branch of D4 moves from $\sqrt{c_p}/n=\Theta(n^{-3/2})$ to $\sqrt{c_p}=\Theta(n^{-1/2})$, it stops binding altogether. What then binds at $u=0$ is the cubic branch $c_p/\lvert P\rvert_\infty$, which is $\Theta(n^{-3/2})$ at $\lvert P\rvert_\infty=\Theta(\sqrt n)$ and $\Theta(n^{-1})$ at $\lvert P\rvert_\infty=\Theta(1)$.

**Consequences, and they are for the plan rather than for the mathematics.**

- **[Lemma L143](../findings/bounds.md)'s "$\sqrt n$ is exactly the threshold" and [I31](../plan.md)'s demotion to "a constant-chasing exercise behind everything that moves an exponent" are both conditional** on the direction-blind radius. The defect-tail branch caps the minimum at $n^{-3/2}$ *only because* $\lVert A''\rVert$ is estimated with $\rho=\Theta(g_n)$ on every direction alike. Remove that and the branch that "never sees $\lVert P\rVert_\infty$" is gone, and $\sup\lvert P\rvert=O(1)$ buys an exponent.
- **What would settle it is one computation nobody has done**: $\lVert H\rVert_{\mathrm{op}}$ on the two $S^2_0(\mathbb R^m)$ summands of [Lemma L27](../findings/nondegeneracy.md)'s decomposition, which is where $c_p$ is attained and where $u=0$. If it is $o(1)$ there, the exponent is not $-3/2$ and [I31](../plan.md) should be re-promoted. **I make no claim about which way it goes**, this is an unexploited resource and an unpriced risk, not a refutation.
- **Read the other way, it is also a route to a better radius** that costs no new instrument, which is the same shape of opening [r442](REVIEW_r442.md) and [r443](REVIEW_r443.md) found in [post F60](../findings/second-order.md).

## D7, vacuity

**Not vacuous, and the item's own comparison is right in substance and sloppy in form.**

- $r_n=\Theta(n^{-3/2})$ is inside the analyticity ball $g_n=\Theta(n^{-1})$ **by a factor $\sqrt n\to\infty$**, so the estimates are self-consistent; D3's uniform-on-the-tube version needs only $r_n\le g_n/8$. Confirmed.
- The item's gloss "*still inside the analyticity ball $g_n=\Theta(1/n)$, which $\Theta(n^{-1})$ would not be*" (in [I2](../plan.md) and in [post F60](../findings/second-order.md)) **is false as written**: $\Theta$ hides constants, and $r_n=\varepsilon g_n$ is $\Theta(n^{-1})$ and inside the ball for every $\varepsilon<1$. What is true is that an improvement to $\Theta(n^{-1})$ would put the tube at a fixed fraction of the analyticity radius, where the Cauchy constants stop being absolute. Say that instead.
- **Distance to other critical points.** The nearest catalogued competitor $S^{m-1}\times S^{m+1}$ sits at distance $\Theta(1)$ ([I20](../plan.md)), so a tube of radius $0.038$ at $n=12$ contains no other critical orbit and the statement is not about a degenerate configuration.
- **Coverage is vacuous and that is fine.** $\dim\mathcal O=36$ inside $S^{1637}$ at $n=12$; a tube of any radius $r<1$ covers a vanishing fraction, so the exponent decides nothing about coverage. [r443](REVIEW_r443.md) D6 makes the same point; the value of the ingredient is the local half of scenario (α), and it delivers that.
- **"Explicit" is still unmet.** The item promises "an explicit radius" and delivers an $\Omega$ with an unpinned absolute Cauchy constant $K$. [I2](../plan.md) concedes this in its own box; the concession should not be read as discharged by the move to $-3/2$.

## D8, defects of statement, all in the item's own text

Recorded because the brief's $n^{-4}$ premise came straight out of them, and because a reader of [plan.md](../plan.md) cannot currently tell what the item claims.

1. **[I2](../plan.md) still asserts the retracted exponent.** Its box reads "*the exponent $-4$ is the claim, the constant in front of it is not*". That exponent has since been superseded twice, to $-2$ and then to $-3/2$.
2. **Two live contradictions in adjacent paragraphs.** The same paragraph derives $C_\delta=O(n^3)$ and then says "both are $O(n)$"; it concludes "$r_n=\Theta(n^{-2})$ **exactly** … the method's ceiling rather than a slack bound", four lines above the paragraph withdrawing [post F60](../findings/second-order.md) and improving the radius to $\Omega(n^{-3/2})$. Each contradiction carries a note admitting it, and neither stale sentence is struck.
3. **A corrupted sentence.** "*…whose largest recorded value at $n=12$ is $\theta_0(12)=1.236$'s exponent from $n^{-3/2}$ by the mechanism [r443](REVIEW_r443.md) identifies*" is a botched edit joining two unrelated clauses.
4. **A live sign-convention collision between the two lemmas the ingredient uses together.** [Lemma L133](../findings/second-order.md) steps 1–2 work with $f(t)=t\,\mathbf1_{t<0}$, whose Daleckii–Krein multiplier lies in $[0,1]$ and whose $W^*_-$ is a *negative* multiple of $\Pi_{\mathrm{mix}}$; [Lemma L141](../findings/second-order.md)(a) and [conventions.md](../findings/conventions.md) work with $W_-=\tfrac12(\lvert W\rvert-W)\succeq0$, multiplier in $[-1,0]$. Nothing here breaks, because both lemmas use only norms, but [conventions.md](../findings/conventions.md) records that this exact collision "refuted four lemmas in one day" and that "any recentring constant flips with it", and L141(a) *is* a recentring argument. It should be stated once, not left for each reader to notice.
5. **The chain's load-bearing estimate is nowhere in the record.** $\lVert A^{(k)}\rVert=O(n^{k-1})$ and the mixed Frobenius/operator Hölder step that produces it exist only in [r441](REVIEW_r441.md) and in [post F60](../findings/second-order.md)'s withdrawal paragraph. [LEDGER.md](../findings/LEDGER.md) still shows the I2 tube ingredients as **single-audited**.

---

## What would repair the ingredient

1. **Strike the $O(n^3)$ sentence and the "$\Theta(n^{-2})$ exactly" conclusion**, and delete "the exponent $-4$ is the claim". State once: $M=O(g_n)$, $\lVert A^{(k)}\rVert=O(n^{k-1})$, $C_\delta=O(n)$, $C_P=O(\sqrt n)$, $\inf_Hc(H)/C(H)=\Theta(n^{-3/2})$.
2. **Number the Cauchy estimate as a lemma in [second-order.md](../findings/second-order.md)** with the two steps it actually needs, the separating contour at radius $g_n/2$ with $\rho<g_n/2$, and the Neumann expansion spending the Frobenius norm once on $\Delta$, and send it to Gate 2. It is the only unaudited load-bearing input, and the $n^2$ it is worth is the whole difference between $n^{-4}$ and $n^{-2}$.
3. **Record that the bootstrap is unnecessary**: $M=O(g_n)$ on $\lvert t\rvert\le g_n/4$ makes $\lVert A^{(k)}(t_0)\rVert=O(n^{k-1})$ uniform for real $\lvert t_0\rvert\le g_n/8$, which is the supremum the Taylor remainder wants. This closes [r441](REVIEW_r441.md)'s FINDING 1 outright.
4. **Price D6 before demoting [I31](../plan.md)**: compute $\lVert H\rVert_{\mathrm{op}}$ on the $S^2_0(\mathbb R^m)$ summands. If it is $o(1)$, the defect-tail branch does not cap the minimum at $n^{-3/2}$ and $\sup\lvert P\rvert=O(1)$ moves the exponent.
5. **State the sign convention once** at the head of the L133/L141 pair.

## What this audit did not check

[Lemma L27](../findings/nondegeneracy.md)'s ten summand values, [Lemma L120](../findings/second-order.md)'s block-diagonality, [Lemma L121](../findings/second-order.md)'s signed coordinates, [Lemma L133](../findings/second-order.md)'s support table and [Lemma L143](../findings/bounds.md)'s two marginals were taken as given; each carries its own Gate 2. I verified the arithmetic that combines them, the $\tfrac29$ from $\max x^2/(x^2+y^2+z^2)$ on $\{x+y+z=0\}$, $\mu_{m,m}=\tfrac2{n-2}$, $\lambda_m>\mu$ for $m\ge6$, $c_4$ at $n=12$ and $n\to\infty$, but not their derivations. The absolute constant in $\lVert A''\rVert\le2M/\rho^2$ is Cauchy's and is absolute; the constant relating $\lVert\mathrm{Alt}(W_-)\rVert$ to $\delta^2$ is the identity, $\delta^2$ being that norm squared. No claim above rests on either screen.
