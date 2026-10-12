# REVIEW_r379, the ceiling section: variational reading, free identities, moments, and the trace–Frobenius bound

*Adversarial Gate 2 review of the last three sections of [ATTEMPTS.md](../ATTEMPTS.md), 2026-09-02. **Analysis only**; every number below is a hand evaluation of a closed form derived here first, reported as arithmetic, never as evidence for a positive claim. No search, sweep or census was run.*

**Headline.** Claims 2, 3 and 4(a),(b),(d) are **CONFIRMED**, two of them with free strengthenings the section left on the table. Claim 4(c), the asymptotic clause, is **CORRECTED**, its inequality chain passes through a false step and its margin is $O(1/n^2)$, not $O(1/n)$. Claim 1's word *unconditionally* is **REFUTED**. Claim 5's framing is **REFUTED with a witness, and then with something stronger than a witness**: $\lVert o\rVert$ is not uncontrolled at all, [Lemma L68](../findings/diagonal-half.md) pins it exactly, and once it is eliminated, the sufficient condition $(\dagger)$ collides with the normalisation $\lVert M\rVert_F^2=2$ and is **inconsistent across any perfect matching unless $\theta^2\ge2-12/n$**. The route therefore covers an $O(1/n)$ fraction of the band, at its very top.

---

## Claim 1, the variational section: REFUTED as to "unconditionally", the rest CONFIRMED with two unstated appeals

### What survives

- **"$x\in V_{jk}$ is a non-diagonal direction."** CONFIRMED. [Lemma L120](../findings/second-order.md)'s decomposition makes the four-set blocks, the pair blocks $V_{jk}$ and $\mathcal D_n$ mutually orthogonal summands, and [Lemma L128](../findings/second-order.md)(i) states that $\mathcal D_n$ carries no orbit direction. So $V_{jk}\cap\mathcal D_n=0$ and $W+\varepsilon x$ leaves the diagonal locus to first order.
- **"$P$ increases along $x$."** CONFIRMED, but the section's wording is literally wrong. $\operatorname{grad}P(W)=0$, so the gradient flow *from $W$* is stationary and there is no ascent from a critical point. What is true: with $\operatorname{grad}P(W)=0$ and $\langle\mathrm{Hess}(P|_S)_Wx,x\rangle=6\theta(\lambda-\tfrac12)\lVert x\rVert^2>0$, $P(\exp_W(\varepsilon x))=P(W)+\tfrac{\varepsilon^2}2\langle\mathrm{Hess}\,x,x\rangle+O(\varepsilon^3)>P(W)$ for small $\varepsilon>0$. The flow must be started at that displaced point.
- **"Ascent terminates at a critical point."** CONFIRMED, and the brief's Łojasiewicz worry is unfounded, though the section owes the citation. $P$ is a cubic polynomial restricted to the unit sphere of $\mathcal W_n$, hence real-analytic on a compact real-analytic manifold, so the Łojasiewicz gradient inequality gives convergence of the flow to a *single* critical point $W'$ with $P(W')\ge P(W_\varepsilon)>P(W)$. **The section asserts this without naming the mechanism**; it should.
- **"The endpoint cannot be diagonal when $\theta=\Theta_n$."** CONFIRMED. [Lemma L57](../findings/problem.md) is stated on the whole of $\mathcal D_n$, not only at its critical points, so $P(W')>\Theta_n$ forces $W'\notin\mathcal D_n$. The brief's question "could the ascent direction re-enter the diagonal locus?" is answered by value, not by invariance: the flow may certainly converge into $\mathcal D_n$ in general, and the section is right that this is exactly what defeats the argument strictly inside the band.

### What fails

> **REFUTED: "the pair clause is unconditionally true at every pure critical point attaining $\Theta_n$".** Two independent defects.
>
> **(a) It is a conditional, not an unconditional, statement.** The deduction is *(clause fails) $\Rightarrow$ (live target is false)*, i.e. *(live target) $\Rightarrow$ (clause)*. The live target ($\sup\{\theta:Q(W)=\theta W,\ S=0,\ \text{non-diagonal}\}\le\sqrt{3/2}$), is **open** ([findings/INDEX.md](../findings/INDEX.md)). Using it to certify a step of the route that is trying to prove it is circular in the only direction that matters. The correct label is *conditional on the live target*.
>
> **(b) Even granting the target, the witness is incomplete: $S(W')=0$ is not established.** The live target quantifies over $S=0$ points, the index says so explicitly, and [target.md](../findings/target.md) records that the $S=0$ class contains points above $\sqrt{3/2}$ so the quantifier is doing real work. The gradient flow of $P$ on the sphere has no recorded reason to preserve $\{S=0\}$, and none is given. So $W'$ is a non-diagonal critical point above $\Theta_n$ with $S(W')$ **unknown**, which refutes nothing.

**Impact: none downstream, because the conclusion is on record by another route.** By [Lemma L57](../findings/problem.md)'s equality case, the pure critical points attaining $\Theta_n$ are exactly the balanced sphere products, and [Corollary L128.1](../findings/second-order.md) verifies all three block clauses at every two-block sphere product with $n\ge12$ by arithmetic. **The variational paragraph is therefore redundant where it closes and inoperative where it does not.** The section's own fence (that a variational argument cannot reach the open band), stands and is the paragraph's only durable content.

---

## Claim 2, the two free identities: CONFIRMED, and $\theta\le\sqrt2$ is improvable for free

### $\sum_iu_i=\sum_iv_i=-M_{jk}$, CONFIRMED

Row $j$ of $M$: $M_{jj}=0$ by hollowness and $M\mathbf1=0$ gives $\sum_{i\in I}M_{ji}+M_{jk}=0$. One line, and the same for $k$. $\square$

### $\theta\le\sqrt2$, CONFIRMED, and the gap it uses is re-derived here

The gap itself: criticality off the diagonal gives $(M^2)_{ij}=\theta M_{ij}-M_{ij}^2$, and on the diagonal $(M^2)_{ii}=s_i:=\sum_lM_{il}^2$ with $\theta M_{ii}=0$. So
$$M^2-\theta M=\operatorname{diag}(s_i)-M^{\circ2}=L\big(M^{\circ2}\big)\succeq0,$$
the graph Laplacian of the Hadamard square, whose weights are nonnegative. Hence $\lambda(\lambda-\theta)\ge0$ for every $\lambda\in\operatorname{spec}(M)$, i.e. $\operatorname{spec}(M)\cap(0,\theta)=\varnothing$. With $\operatorname{tr}M=0$ and $M\ne0$ some eigenvalue is positive, so $\lambda_{\max}\ge\theta$; with $\sum\lambda_i^2=\lVert M\rVert_F^2=2$, $\lambda_{\max}\le\sqrt2$. Hence $\theta\le\sqrt2$. $\square$

> **TWO FREE STRENGTHENINGS THE SECTION MISSED, FROM THE SAME TWO LINES.**
>
> **(i) $\theta\le\sqrt{2(n-1)/n}$, strictly.** Write $\lambda_1=\lambda_{\max}$. The remaining eigenvalues sum to $-\lambda_1$ and their squares to $2-\lambda_1^2$, so Cauchy–Schwarz gives $\lambda_1^2\le(n-1)(2-\lambda_1^2)$, i.e. $\theta^2\le\lambda_1^2\le2(n-1)/n$. At $n=12$ this is $1.354006$ against the section's $1.414214$. *Still weaker than $\Theta_{12}=1.236033$, so nothing downstream changes, but the section prints $\sqrt2$ as "the asymptote of $\Theta_n$", and $\sqrt{2(n-1)/n}$ is the honest finite-$n$ form of the same two lines.*
>
> **(ii) In the band, $M$ has EXACTLY ONE positive eigenvalue.** Let $p$ be the number of positive eigenvalues; each is $\ge\theta$ by the gap, so $p\theta^2\le\sum_{\lambda>0}\lambda^2\le2$, giving $p\le2/\theta^2$. With $\theta\ge\sqrt{3/2}$ this is $p\le4/3$, hence $p=1$. **This is a genuine ceiling-shaped consequence of criticality, contradicting the section's own fence that "every consequence of criticality on the record is a floor"**, it says $\lambda_2(M)\le0$, and therefore $\lambda_2(N)\le0$ for the compression $N=M^{(jk)}$ by interlacing. *What it does not survive is the diagonal shift: $\widetilde N=N+\operatorname{diag}(u+v)$, and a rank-$(n-2)$ diagonal perturbation destroys an eigenvalue count. So the fence's conclusion is right for the wrong reason.*

---

## Claim 3, the moment identities: CONFIRMED, both re-derived independently

**Trace.** $N=M^{(jk)}$ is hollow, so $\operatorname{tr}\widetilde N=\operatorname{tr}N+\sum_i(u_i+v_i)=0+(-M_{jk})+(-M_{jk})=-2M_{jk}$. $\square$

**Frobenius.** Block-splitting $\lVert M\rVert_F^2=2$ with $M=\begin{psmallmatrix}N&U\\U^\top&C\end{psmallmatrix}$, $U=[u\ v]$: the two off-diagonal blocks contribute $2(\lVert u\rVert^2+\lVert v\rVert^2)$ and $C$ contributes $2M_{jk}^2$, so
$$\lVert N\rVert_F^2=2-2\lVert u\rVert^2-2\lVert v\rVert^2-2M_{jk}^2 .$$
$N$ hollow makes $\operatorname{diag}(u+v)$ Frobenius-orthogonal to it, so $\lVert\widetilde N\rVert_F^2=\lVert N\rVert_F^2+\sum_i(u_i+v_i)^2$, and
$$\sum_i(u_i+v_i)^2-2\lVert u\rVert^2-2\lVert v\rVert^2=\lVert u\rVert^2+2u\!\cdot\!v+\lVert v\rVert^2-2\lVert u\rVert^2-2\lVert v\rVert^2=-\lVert u-v\rVert^2 .$$
Hence $\lVert\widetilde N\rVert_F^2=2-\lVert o\rVert^2-2M_{jk}^2$. $\square$ **The disputed step is correct as written.**

---

## Claim 4, the Frobenius failure and the trace–Frobenius success

### (a) The orbit-free reduction, CONFIRMED, but it is a detour around a one-line identity

$\lambda_{\max}(\widetilde N)\le\lVert\widetilde N\rVert_F$ suffices when $\lVert\widetilde N\rVert_F^2\le(\theta+M_{jk})^2$, i.e. with $o=0$,
$$2-2M_{jk}^2\le(\theta+M_{jk})^2\iff (\theta+M_{jk})^2+2M_{jk}^2\ge2 .$$
Substituting [r378](REVIEW_r378.md)'s $\theta M_{jk}=M_{jk}^2+u\!\cdot\!v$ and $u=v$ turns this into $\theta^2+5M_{jk}^2+2\lVert u\rVert^2\ge2$, the section's form, **CONFIRMED**, since $2\lVert u\rVert^2=2\theta M_{jk}-2M_{jk}^2$ and $\theta^2+2\theta M_{jk}+3M_{jk}^2=(\theta+M_{jk})^2+2M_{jk}^2$. *The two forms are the same inequality; routing through $\lVert u\rVert^2$ imports a variable the Frobenius identity had already eliminated.*

### (b) The $S^6\times S^6$ arithmetic, CONFIRMED, with the exact values

Recomputed from scratch. Balanced product, $m=6$, $n=12$: within-factor $\alpha=-m\gamma/(m-1)$, cross $\gamma<0$, and $\lVert M\rVert_F^2=2m(m-1)\alpha^2+2m^2\gamma^2=2$ gives

| quantity | exact | decimal | section's value |
|---|---|---|---|
| $\gamma^2$ | $5/396$ | $0.01262626$ | $5/396$ ✓ |
| $\alpha=M_{jk}$ | $1/\sqrt{55}$ | $0.13483997$ | $0.134831$ (off by $9\times10^{-6}$) |
| $\theta=(2m-1)\lvert\gamma\rvert$ | $\sqrt{605/396}$ | $1.23603308$ | $1.236033$ ✓ |
| $t=\operatorname{tr}\widetilde N$ | $-2/\sqrt{55}$ | $-0.26967994$ | $-0.269663$ (rounding) |
| $f=\lVert\widetilde N\rVert_F^2$ | $2-2/55=108/55$ | $1.96363636$ | $1.963642$ (rounding) |
| $d$ | $10$ | | $10$ ✓ |
| Frobenius total $\theta^2+5\alpha^2+2\lVert u\rVert^2$ | $\tfrac{605}{396}+\tfrac1{11}+\tfrac{2\cdot49}{330}$ | $1.91565657$ | $1.9157$ ✓, short of $2$ by $0.08434$ |
| Wolkowicz–Styan bound | | $1.29995599$ | $1.29996$ ✓ |
| $\theta+M_{jk}$ | | $1.37087305$ | $1.370864$ (rounding) |
| slack | | $0.07091706$ | $0.0709$ ✓ |

*Criticality cross-checked two ways: within-factor gives $(m-1)\alpha^2+m\gamma^2=\theta\alpha$ and cross-factor gives $\gamma+2(m-1)\alpha=\theta$, both yielding $\theta=-(2m-1)\gamma$.*

**Independent check that the bound is not vacuous.** Diagonalising $\widetilde N$ by the equitable partition $(A\setminus\{j,k\},B)$ of sizes $4,6$: eigenvalues $\alpha$ (multiplicity 3), $2\gamma-\alpha=-0.35957$ (multiplicity 5), and $\{0,\,10\lvert\gamma\rvert\}$ from the $2\times2$ quotient $\begin{psmallmatrix}5\alpha&6\gamma\\4\gamma&5\alpha+2\gamma\end{psmallmatrix}$. So $\lambda_{\max}(\widetilde N)=10\lvert\gamma\rvert=1.123667<1.299956<1.370873$. **The ceiling is genuine and lies strictly between the truth and the target.**

> **A FREE IMPROVEMENT THE SECTION DID NOT TAKE.** $\widetilde N\mathbf1=0$, so Wolkowicz–Styan may be applied on $\mathbf1^\perp$, where the trace and the Frobenius norm are unchanged but the dimension is $d-1=n-3$. At $S^6\times S^6$ this gives $1.288471$ in place of $1.299956$, raising the slack from $0.070917$ to $0.082402$. *Legitimate, because $\widetilde N\mathbf1=0\le\theta+M_{jk}$ holds trivially on the removed direction. It does not change any verdict below, the asymptotic constant moves from $1.944/m^2$ to $2.12/m^2$ and the budget threshold of Claim 5 from $2-12.27/n$ to $2-12.28/n$.*

### (c) The asymptotic claim, CORRECTED, twice

> **The inequality chain contains a false step.** The section writes "the left side tends to $\sqrt2\sqrt{1-1/(n-2)}<\sqrt2\le\theta+M_{jk}$". The last inequality is **false at every finite $n$**: Claim 2 gives $\theta\le\sqrt2$, and at the balanced product $\theta+\alpha=\sqrt2-0.353553/m+O(1/m^2)<\sqrt2$, numerically $1.370873$ at $m=6$, $1.397802$ at $m=20$, $1.412458$ at $m=200$, all below $\sqrt2$. Both sides of the comparison approach $\sqrt2$ from **below**, so the argument compares two quantities whose difference it never computes.

> **And the margin is $O(1/n^2)$, not $O(1/n)$.** Two exact relations make the expansion clean: at $S^m\times S^m$, $\alpha^2=1/((m-1)(2m-1))$ and $\theta^2=(2m-1)(m-1)/m^2$, hence $\theta\alpha=1/m$ **exactly**. With $\varepsilon=1/m$,
> $$\theta+M_{jk}=\sqrt2-0.353553\,\varepsilon+0.486136\,\varepsilon^2+O(\varepsilon^3),$$
> $$\text{WS bound}=\sqrt2-0.353553\,\varepsilon-1.458400\,\varepsilon^2+O(\varepsilon^3),$$
> so the $1/n$ terms **cancel identically** and
> $$\text{margin}=\frac{1.9445}{m^2}+O(m^{-3})=\frac{7.778}{n^2}+O(n^{-3}).$$
> Arithmetic check of the closed form: $\text{margin}\cdot m^2=2.5530,\ 2.3722,\ 2.2742,\ 2.0981,\ 2.0035,\ 1.9590$ at $m=6,8,10,20,50,200$, converging to $1.944$ from above, as the expansion predicts.

> **A third defect, of scope.** "$t\to0$, $f\to2$" is not a property of pure critical points; $t=-2M_{jk}$ and $f=2-\lVert o\rVert^2-2M_{jk}^2$ vanish and saturate only along the balanced-product family. The paragraph is an evaluation at one family presented as an asymptotic theorem. Claim 5 shows the general behaviour is the opposite.

### (d) Wolkowicz–Styan, CONFIRMED as stated

For real symmetric $T$ of order $d$ with mean $\bar m=t/d$ and variance $s^2=f/d-\bar m^2$, Wolkowicz–Styan (1980) give $\bar m+s/\sqrt{d-1}\le\lambda_{\max}\le\bar m+s\sqrt{d-1}$, and $s\sqrt{d-1}=\sqrt{\tfrac{d-1}d(f-\tfrac{t^2}d)}$. The section's form is correct. **The condition $t^2/d\le f$ is automatic** (it is $(\sum\lambda_i)^2\le d\sum\lambda_i^2$, Cauchy–Schwarz) so the radicand is never negative and the caveat costs nothing. *The only unstated hypothesis is $d\ge2$, vacuous here.*

---

## Claim 5, the framing: REFUTED, and the ceiling is provably not enough

### First: $\lVert o\rVert$ is NOT uncontrolled, it is pinned by [Lemma L68](../findings/diagonal-half.md), which the section did not use

$g_{jk}=2\lVert M_j-M_k\rVert^2-4M_{jk}^2$ and $\lVert M_j-M_k\rVert^2=\lVert o\rVert^2+2M_{jk}^2$, so $g_{jk}=2\lVert o\rVert^2$. [Lemma L68](../findings/diagonal-half.md) states $g_{ab}=2(s_a+s_b)-4\theta M_{ab}$ at every diagonal critical point. Therefore
$$\boxed{\ \lVert o^{jk}\rVert^2=s_j+s_k-2\theta M_{jk}\ }$$
with $s_j=\sum_lM_{jl}^2$ the row masses, $\sum_js_j=\lVert M\rVert_F^2=2$. *Re-derived here independently: $\lVert o\rVert^2=\lVert u\rVert^2+\lVert v\rVert^2-2u\!\cdot\!v$, and $s_j+s_k=\lVert u\rVert^2+\lVert v\rVert^2+2M_{jk}^2$ with [r378](REVIEW_r378.md)'s $u\!\cdot\!v=\theta M_{jk}-M_{jk}^2$.* **In the orbit-free case this is L68's equality clause verbatim**, orbit-free means $M_{ji}=M_{ki}$ for all $i\notin\{j,k\}$, i.e. **twin**, which is exactly where L68 records $g_{ab}=0$, and it gives
$$s_j=s_k=\theta\,M_{jk}\qquad\text{at every orbit-free pair.}$$
*Verified at $S^6\times S^6$: $s_j=1/m=1/6$ and $\theta\alpha=1/6$.* **So "a lower bound on $M_{jk}$" is a lower bound on a row mass of $M$, and the normalisation budgets those exactly.**

### Second: two free consequences the section needed and did not have

- **$0\le M_{jk}\le\theta$ at every orbit-free pair**, since $u\!\cdot\!v=\lVert u\rVert^2\ge0$ forces $M_{jk}(\theta-M_{jk})\ge0$. **This discharges hypothesis (1) ($\theta+M_{jk}>0$), unconditionally in the orbit-free case**, which the boxed-identity section left resting on "$u\!\cdot\!v>-2\theta^2$".
- **$M_{jk}\le\theta(n-2)/(n-1)$**, from $\lVert u\rVert^2\ge(\sum_iu_i)^2/(n-2)=M_{jk}^2/(n-2)$. *An upper bound. Nothing in the recorded data produces a lower one, which is why the next paragraph is possible.*

### Third: THE WITNESS, the sufficient condition fails inside the band

Substituting the boxed identity into $(\dagger)$ eliminates $\lVert o\rVert$ entirely. With $k=n/(n-2)$, $c=(n-3)/(n-2)$, $x=M_{jk}$, $\sigma=s_j+s_k$, $(\dagger)$ is **equivalent** to
$$\sigma\;\ge\;\sigma_{\min}(\theta,x,n):=2+2\theta x-2kx^2-\frac{(\theta+kx)^2}{c}.$$

> **A tuple where the sufficient condition FAILS**, consistent with every constraint the section lists, $\theta$ in the band, $\theta\le\sqrt{2(n-1)/n}$, $\lVert\widetilde N\rVert_F^2\ge0$, $\sum_iu_i=-M_{jk}$, [r378](REVIEW_r378.md)'s identity, $\theta+M_{jk}>0$:
> $$\big(\theta,\ M_{jk},\ \lVert o\rVert,\ n\big)=\Big(\sqrt{3/2},\ 0.05,\ 0,\ 12\Big),\qquad \lVert u\rVert^2=M_{jk}(\theta-M_{jk})=0.058737 .$$
> $(\dagger)$'s left side is $1.339627$ against $\theta+M_{jk}=1.284745$: **fails by $0.054882$.** At $n=100$ the same tuple fails by $0.129$. *The failure widens with $n$, the opposite of the section's asymptotic claim.*

**The threshold, in closed form.** With $o=0$, $(\dagger)$ holds iff $M_{jk}\ge x^*(\theta,n)$ where $x^*=\big[-\theta+\sqrt{\theta^2-(k+2c)(\theta^2-2c)/k}\big]/(k+2c)$, tending to $\big[-\theta+\sqrt{6-2\theta^2}\big]/3$. At $\theta=\sqrt{3/2}$: $x^*=0.091752$ at $n=12$, $0.147029$ at $n=40$, $0.169102$ as $n\to\infty$, **it does not decay in $n$**, while the balanced product's own $M_{jk}=2/(n\theta)$ does.

> **$\lVert o\rVert=0$ is the WORST case, and it is exactly the case [I18](../plan.md) needs.** $(\dagger)$'s left side is decreasing in $\lVert o\rVert$, so orbit-free blocks are where the tool is weakest, and they are the blocks where the clause must read "$\tfrac12$ absent". *Separately: on orbit-carrying blocks $(\dagger)$ cannot deliver what L128(ii) asks, since a bound on $\lambda_{\max}$ gives equality with the known eigenvector $o$ but never its **simplicity**.*

### Fourth: THE STRONGER RESULT, $(\dagger)$ collides with the normalisation, and the band is not enough

The witness above is a tuple; the following needs no tuple and no existence question.

> **Proposition (r379).** Let $M$ be a pure critical point at $\theta$, $n$ even, and let $\mathcal P$ be a perfect matching of $[n]$. If $(\dagger)$ holds at every pair of $\mathcal P$ then
> $$\sum_{\{j,k\}\in\mathcal P}\sigma_{\min}(\theta,M_{jk},n)\ \le\ \sum_{\{j,k\}\in\mathcal P}(s_j+s_k)\ =\ \sum_{l\in[n]}s_l\ =\ 2 .$$
> $\sigma_{\min}$ is decreasing and concave in $x\ge0$, and $\sum_{\mathcal P}M_{jk}^2\le\sum_{j<l}M_{jl}^2=1$, so the left side is minimised at $M_{jk}=\sqrt{2/n}$ for every pair. Since $\sigma_{\min}=2-\theta^2-3x^2+O(1/n)$, this forces
> $$\theta^2\ \ge\ 2-\frac{12}{n}+o(1/n).$$

**Arithmetic check of the closed form.** Solving $\tfrac n2\sigma_{\min}(\theta,\sqrt{2/n},n)=2$ exactly:

| $n$ | $\theta$ required by $(\dagger)$ | $\Theta_n$ | $n(2-\theta^2)$ | usable fraction of the band $[\sqrt{3/2},\Theta_n]$ |
|---|---|---|---|---|
| 12 | $1.000000$ | $1.236033$ | $12.00$ | all |
| 20 | $1.117528$ | $1.307670$ | $15.02$ | all |
| **30** | $1.231891$ | $1.343296$ | $14.47$ | $0.940$, **the obstruction begins** |
| 40 | $1.283276$ | $1.361066$ | $14.13$ | $0.571$ |
| 100 | $1.366362$ | $1.392982$ | $13.31$ | $0.158$ |
| 400 | $1.403007$ | $1.408909$ | $12.63$ | $0.032$ |
| 2000 | $1.412042$ | $1.413153$ | $12.27$ | $0.0059$ |

> **VERDICT ON CLAIM 5: the framing is REFUTED.** The remaining gap is not "a lower bound on $M_{jk}$", it is that $(\dagger)$ is **inconsistent with $\lVert M\rVert_F^2=2$** on all but an $O(1/n)$ fraction of the band, from $n=30$ up. The band hypothesis $\theta\ge\sqrt{3/2}$ is nowhere near sufficient; what $(\dagger)$ actually demands is $\theta\ge\Theta_n\big(1-O(1/n)\big)$, i.e. that the point already be a balanced product to within $O(1/n)$ in value, **which is the conclusion, not a hypothesis.** The margin at $S^6\times S^6$ is not "the ceiling working"; it is the ceiling being saturated at the one point where the answer is already known.

**Why, structurally.** $(\dagger)$ uses only the first two moments of $\widetilde N$, and by the boxed identity those two moments are $(-2M_{jk},\,2-s_j-s_k+2\theta M_{jk}-2M_{jk}^2)$, the Frobenius norm of $\widetilde N$ is within $O(1/n)$ of $\lVert M\rVert_F=\sqrt2$ for **every** pair, because a pair block loses only two rows out of $n$. A two-moment bound on a $(n-2)$-dimensional matrix whose Frobenius norm is $\approx\sqrt2$ cannot see below $\sqrt2\sqrt{(n-3)/(n-2)}$, while the target $\theta+M_{jk}$ is at most $\sqrt2$ and typically well below it. **The section's diagnosis (that criticality supplies floors and $B\succeq0$ needs a ceiling), is right; its remedy fails because the ceiling it found is a ceiling at the wrong height, and no amount of information about $\theta$ and $M_{jk}$ moves it.** A successor must use the third moment of $\widetilde N$, or the eigenvector structure, or the one-positive-eigenvalue fact recorded above, something that distinguishes $\widetilde N$ from a generic matrix of its norm.

---

## Verdict table

| # | Claim | Verdict |
|---|---|---|
| 1 | ascent leaves the diagonal locus; endpoint is a critical point | **CONFIRMED**, with two unstated appeals now named (Łojasiewicz; $V_{jk}\perp\mathcal D_n$ via L120/L128(i)) and one wording error (the flow starts at a displaced point, not at $W$) |
| 1 | "the pair clause is unconditionally true at every pure critical point attaining $\Theta_n$" | **REFUTED**, conditional on the open live target, and the witness needs $S(W')=0$, which is not established. *No downstream impact: [Corollary L128.1](../findings/second-order.md) proves it there independently* |
| 1 | a variational argument cannot close the open band | **CONFIRMED** |
| 2 | $\sum_iu_i=\sum_iv_i=-M_{jk}$ | **CONFIRMED** |
| 2 | $\theta\le\sqrt2$; is it on record | **CONFIRMED** as a valid two-line derivation. The gap it rests on is on record ([diagonal-half.md](../findings/diagonal-half.md)); the conclusion $\theta\le\sqrt2$ is not indexed. **Strengthen for free to $\theta\le\sqrt{2(n-1)/n}$, and to $p=1$ positive eigenvalue in the band** |
| 3 | $\operatorname{tr}\widetilde N=-2M_{jk}$, $\lVert\widetilde N\rVert_F^2=2-\lVert o\rVert^2-2M_{jk}^2$ | **CONFIRMED**, both re-derived; the disputed algebraic step is correct |
| 4a | Frobenius failure $\Rightarrow\theta^2+5M_{jk}^2+2\lVert u\rVert^2\ge2$ | **CONFIRMED**; equal to the one-line $(\theta+M_{jk})^2+2M_{jk}^2\ge2$ |
| 4b | the $S^6\times S^6$ numbers | **CONFIRMED** to $10^{-5}$; exact values $\alpha=1/\sqrt{55}$, $f=108/55$, $\theta^2=605/396$, $\theta\alpha=1/m$ |
| 4c | "clears as $n$ grows with margin of order $1/n$" | **CORRECTED**, the chain's step $\sqrt2\le\theta+M_{jk}$ is false at every finite $n$; the $1/n$ terms cancel and the margin is $1.944/m^2=7.78/n^2$; and "$t\to0,f\to2$" holds only along the balanced product |
| 4d | Wolkowicz–Styan statement and the $t^2/d\le f$ caveat | **CONFIRMED**, correctly stated; the caveat is automatic by Cauchy–Schwarz. *Free improvement available on $\mathbf1^\perp$ ($d\to d-1$)* |
| 5 | "what is still uncontrolled is a lower bound on $M_{jk}$" | **REFUTED with a witness**, $\lVert o\rVert$ is pinned by [Lemma L68](../findings/diagonal-half.md), the eliminated condition is $s_j+s_k\ge\sigma_{\min}$, and summing over a matching against $\sum_ls_l=2$ forces $\theta^2\ge2-12/n$. $(\theta,M_{jk},\lVert o\rVert,n)=(\sqrt{3/2},0.05,0,12)$ fails $(\dagger)$ by $0.0549$; from $n=30$ the whole bottom of the band fails |

## What is owed

1. **Withdraw "unconditionally" from the variational paragraph** and relabel it *conditional on the live target*, noting that the $\Theta_n$ case is settled independently by [Corollary L128.1](../findings/second-order.md).
2. **Replace the asymptotic clause** with the expansion above, the $1.944/m^2$ constant, and the scope note that it is a balanced-product evaluation.
3. **Record the boxed identity $\lVert o^{jk}\rVert^2=s_j+s_k-2\theta M_{jk}$ as a consequence of [Lemma L68](../findings/diagonal-half.md)**, together with $s_j=s_k=\theta M_{jk}$ at orbit-free (twin) pairs and $0\le M_{jk}\le\theta$ there. *This is the section's missing link and it was already on the record in another file.*
4. **Record the Proposition and close $(\dagger)$ as a fence post**: a two-moment ceiling on $\widetilde N$ cannot reach $\theta+M_{jk}$ below $\theta^2=2-12/n$, so any successor must spend a third moment or the eigenvector structure.
5. **Add $\theta\le\sqrt{2(n-1)/n}$ and "exactly one positive eigenvalue in the band" to [bounds.md](../findings/bounds.md)**, both free, and the second is a ceiling-shaped criticality consequence the section's own fence says cannot exist.

*Computation discipline: no search, sweep, census or optimisation was run. Every number above is a hand evaluation of a closed form derived in this review, used to screen a claim before recording it.*
