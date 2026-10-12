# Review 64, the residual one-variable inequality $F(A)\le\sqrt{3/2}$ on $(0,A_0]$

**Overall verdict: the claim is CONFIRMED, and I was able to upgrade it from a numerical certificate to a rigorous one.** I attacked all five sub-claims and broke none of them. One argument (the S4 endpoint expansion), is *true in its conclusion but unsound as written*; the gap is named in [S4](#s4-the-endpoint-expansion) below, together with a repair that closes it with interval arithmetic.

Everything here was re-derived from the statement of the claim alone. I did not read or run [b0_residual_interval.py](../scripts/route-b/b0_residual_interval.py) or any other `b0_*.py`. My scripts are [review_r64_b0_core.py](../scripts/reviewers/r64/review_r64_b0_core.py) (symbolic and high-precision) and [review_r64_b0_interval.py](../scripts/reviewers/r64/review_r64_b0_interval.py) (interval arithmetic).

## Verdict table

| Sub-claim | Verdict | Decisive evidence |
|---|---|---|
| S1 closed form of $\psi^*$ | **CONFIRMED** | $\min D = 27/8$ at $A_0$; closed form agrees with brute-force maximisation to $1.7\times10^{-41}$ |
| S2 low band $(0,1/3]$ | **CONFIRMED** | $\beta\ge0\iff A\le1/3$ solved symbolically; $\max(g+\alpha T+\beta T^2)=8/9$ attained at $1/3$ |
| S3 middle band $(1/3,0.7]$ | **CONFIRMED, and now rigorous** | interval bisection closes the band in 63 boxes; $L\le13.7250$ is valid, my own bound is $7.4080$ |
| S4 endpoint band $(0.7,A_0]$ | **conclusion CONFIRMED, argument has a GAP** | every constant verified symbolically, but the second-order model is a *lower* bound on $F$, not an upper one |
| S5 coverage and monotonicity | **CONFIRMED** | bands tile $(0,A_0]$; $F'>0$ certified by interval arithmetic on $[10^{-12},0.8164]$, $F'(A_0)=0$ |

## S1, the closed form of $\psi^*$

Confirmed on every point the sub-claim asks about.

- $\gamma=1-3K_0=-2.18198\ldots<0$, so $\psi'(t)=\alpha+2\beta t+3\gamma t^2$ opens downward and its root product $\alpha/(3\gamma)$ is $\le0$.
- $\alpha\ge0$ on $(0,A_0]$: sympy gives $\alpha=0\iff A^2=2/3$, the single zero at $A_0$. Grid check over 4000 points: zero violations.
- **Discriminant.** $D=\beta^2-3\gamma\alpha=\beta^2+3|\gamma|\alpha$ is a sum of two nonnegative terms, so positivity is structural rather than numerical. It degenerates only where $\beta$ and $\alpha$ vanish together, which never happens: $\beta=0$ only at $A=1/3$, where $\alpha=1.7678$. Grid minimum $D=3.375=27/8$, attained at $A_0$ where $D=\beta(A_0)^2$.
- **Right root.** $-\beta-\sqrt D\le0$ always (since $\sqrt D\ge|\beta|$) and $3\gamma<0$, so $t_c\ge0$; the other root is $\le0$ at all 4000 sample points. Hence $\psi$ increases on $[0,t_c)$ and decreases after, and $t=0$ is the maximiser only in the degenerate case $A=A_0$, where $\alpha=0$ forces $t_c=0$ exactly.
- **Cross-check against the definition.** Comparing $\psi(A,\min(t_c,T))$ with a scan-plus-golden-section maximisation of $\psi$ over $[0,T]$ that never uses the closed form: max discrepancy $1.7\times10^{-41}$ over 400 values of $A$.
- **The cap actually switches inside the middle band**: $t_c=T$ at $A_{sw}=0.44634841803027714$. The cap binds below it, the interior root above it. This is what makes S3(a) a real question rather than a formality.

## S2, the low band $(0,1/3]$

Both halves confirmed; the monotonicity half is exact algebra, not a numerical claim.

- $\beta(A)\ge0\iff\tfrac34\sqrt{2-2A^2}\ge3A\iff1-A^2\ge8A^2\iff A\le1/3$. sympy returns the single root $A=1/3$, and $\beta(1/3)=0$ to $10^{-41}$.
- Since $\alpha\ge0$ and $\beta\ge0$ on the band, $\alpha t+\beta t^2$ is increasing on $[0,T]$, so $\psi^*\le\max_{[0,T]}(\alpha t+\beta t^2)=\alpha T+\beta T^2$, and this holds **whatever branch $t^*$ is on**, so it needs no separate argument that $T$ is the maximiser. (It happens to be: $A_{sw}=0.446>1/3$, so the cap binds throughout the band.)
- $\max_{(0,1/3]}(g+\alpha T+\beta T^2)=8/9$, attained at $A=1/3$: interval bisection certifies the envelope below $8/9+10^{-9}$ with supremum $0.888888888906$, and the envelope's derivative at $1/3$ is $+3.667$, so $1/3$ is the right endpoint. $8/9=0.8889<\sqrt{3/2}$ with slack $0.3359$.
- $F$ itself is much smaller: $\max_{(0,1/3]}F=0.821162$. The equality at $A=1/3$ is equality in the *second* inequality of the chain, not in $F$; dropping $\gamma T^3$ costs $0.0677$ there.
- Interval arithmetic certifies $F<\sqrt{3/2}$ on all of $(0,1/3]$ in a single box.

## S3, the middle band $(1/3,0.7]$

The overshoot is real: the S2 envelope peaks at $1.302647$ at $A=0.53740$, comfortably above $\sqrt{3/2}=1.224745$, so the cubic genuinely has to be kept. Each of the four attacks:

**(a) Differentiability at the branch switch, CONFIRMED, and the concern resolves cleanly.** At $A_{sw}$ the cap coincides with the critical point, so $\psi_t(A_{sw},T)=0$ *by definition of $t_c$*, and the capped branch's extra term $\psi_t(A,T)\,T'$ vanishes there. The two one-sided derivative formulas therefore agree at the switch and $F$ is $C^1$ across it. Checked numerically: one-sided slopes at $A_{sw}$ differ by $3.7\times10^{-3}$, $3.7\times10^{-5}$, $3.7\times10^{-7}$ at $h=10^{-4},10^{-6},10^{-8}$, the linear-in-$h$ decay of a one-sided difference quotient on a $C^1$ function.

**(b) The Lipschitz constant, CONFIRMED as a valid bound, though loose.** The stated derivative formula is exactly right. Comparing $g'+\alpha't+\beta't^2$ (and the capped variant) against 50-digit central differences at ten values of $A$ spanning both branches *and the switch itself*, the largest discrepancy is $1.5\times10^{-31}$. Note $\gamma'=0$, so no cubic term appears, the claim has this right. My own interval enclosure of $\sup|F'|$ over the band, taking the union of both branches on every box, gives

$$L_{\text{mine}}\le 7.407960717,$$

against the claimed $L\le13.7250$. **The claim's constant is valid but $1.85\times$ larger than necessary**, so nothing rests on it being tight. Component bounds on $[1/3,0.7]$: $|g'|\le3.7334$, $|\alpha'|\le4.4548$, $|\beta'|\le4.0397$, $T_{\max}=0.65997$, $T'=0.94281$.

**(c) The grid-plus-Lipschitz step, CONFIRMED, and no spike exists.** The inference is sound: every $A$ lies within $h/2$ of a grid point, so $F(A)\le\max_i F(A_i)+Lh/2$, given a genuine $L$ over the whole band (which (b) supplies) and a grid whose endpoints are included. Independently of any grid, branch-and-bound interval arithmetic puts the true maximum in

$$\max_{[1/3,0.7]}F\in[1.20322955981,\;1.20322956076],$$

matching the claimed $1.203230$ to six decimals, and localises the argmax at the band endpoint $A=0.7$, consistent with $F$ being increasing, so there is no interior spike to miss. Rigorous slack to $\sqrt{3/2}$: $0.021515$, matching the claimed $0.0215$. The claim's own certificate $1.203230+13.7250\cdot1.8\times10^{-6}/2=1.2032424$ is reproduced.

**(d) INTERVAL-ARITHMETIC VERDICT, the middle band is a PROOF, not a numerical certificate.** Adaptive interval bisection on $F$ over $[1/3,0.7]$, with mpmath's directed-rounding `iv` context at 200 bits, certifies $F<\sqrt{3/2}$ in **63 boxes** with no failure. Implementation points that make this rigorous rather than decorative:

- the cap is handled as the *exact range* of $\min(t_c,T)$ over the box, $[\min(t_c^-,T^-),\min(t_c^+,T^+)]$, which provably contains $t^*(A)$ for every $A$ in the box, so no branch analysis is needed inside the enclosure;
- every box is inflated outward by $2^{-150}$ before evaluation, so endpoint conversion cannot leave a sliver of the range outside the tiling;
- the engine is self-tested (it correctly reports $x-x=[-1,1]$ for $x=[1,2]$, i.e. it does no dependency tracking and cannot silently under-estimate a width), and the pointwise $F$ was checked to lie inside the enclosure at 2000 sample boxes.

## S4, the endpoint expansion

**Every constant is exactly right, and the conclusion is true, but the argument as stated does not establish it on $(0.7,A_0]$.**

Verified symbolically with sympy: $g(A_0)=\sqrt6/2$, $g'(A_0)=0$, $-g''(A_0)/2=\tfrac94\sqrt6$, $\alpha(A_0-e)=3\sqrt3\,e-\tfrac94\sqrt2\,e^2$, $\beta(A_0)=-\tfrac34\sqrt6$, $T(A_0)=\tfrac49\sqrt3=0.7698$, $t^*=\sqrt2\,e$ (indeed far inside the cap), $\psi^*=\tfrac32\sqrt6\,e^2$, margin coefficient $(\tfrac94-\tfrac32)\sqrt6=\tfrac34\sqrt6=1.8371173$. The $e^2$ law is confirmed numerically: $(\sqrt{3/2}-F)/e^2$ = 1.8096, 1.8343, 1.8368 at $e=10^{-2},10^{-3},10^{-4}$.

**The gap.** Those numbers approach $\tfrac34\sqrt6$ **from below**, which means the second-order model $\sqrt{3/2}-\tfrac34\sqrt6\,e^2$ *understates* $F$ for every $e>0$:

| $A$ | 0.70 | 0.75 | 0.80 | 0.81 | 0.816 |
|---|---|---|---|---|---|
| model $-\,F$ | $-3.42\times10^{-3}$ | $-7.05\times10^{-4}$ | $-1.21\times10^{-5}$ | $-7.62\times10^{-7}$ | $-3.46\times10^{-10}$ |

So the model is a lower bound on $F$, never an upper one, and $F\le\sqrt{3/2}-\tfrac34\sqrt6\,e^2$ is **false at every point of the band**. The true margin coefficient degrades from $1.8371$ at $A_0$ to $1.585$ at $A=0.7$. The conclusion $F<\sqrt{3/2}$ survives (the coefficient stays positive) but only because the $O(e^3)$ correction happens to remain small, and the expansion carries no remainder bound saying so. **This is exactly the gap the brief anticipated: a second-order argument with no error control, valid in an unspecified neighbourhood of $A_0$, asserted over a band of width $0.1165$.**

**Repair.** The band can be closed rigorously with a certificate that does not degenerate at $A_0$. Two exact inequalities:

1. $\psi^*\le\max_{t\ge0}(\alpha t+\beta t^2)=\alpha^2/(4|\beta|)$, valid because $\gamma t^3\le0$ and $\beta<0$ for $A>1/3$; and $\alpha=3K_0e(A_0+A)$ exactly, so this term is $9K_0^2e^2(A_0+A)^2/(4|\beta|)$.
2. $g(A_0-e)-g(A_0)=\int_0^e(e-s)g''(A_0-s)\,ds\le\tfrac{e^2}{2}\sup_{[A,A_0]}g''$, using $g'(A_0)=0$.

Together, $F(A)-\sqrt6/2\le e^2Q(A)$ with $Q(A)=\tfrac12\sup_{[A,A_0]}g''+9K_0^2(A_0+A)^2/(4|\beta(A)|)$. Dividing by $e^2$ removes the degeneracy at $A_0$, so interval arithmetic can certify strict negativity. It does: $Q$ changes sign at $A=0.709551314852628$ and **$Q<0$ is certified on $[0.7096,A_0]$ in 21 boxes** ($\sup Q=-2.57\times10^{-4}$). The residual $[0.7,0.7096]$ is closed by direct interval bisection on $F$ (slack $6.25\times10^{-3}$). Note the repair is not merely a tightening: $Q(0.70)$ has upper end $+0.173$, so the cubic-free bound genuinely fails at $0.7$ and the two pieces are both needed.

## S5, coverage and monotonicity

- **Coverage: CONFIRMED trivially.** $(0,1/3]$, $(1/3,0.7]$, $(0.7,A_0]$ are consecutive half-open intervals, no gap, no overlap, and the closed-band computations above use $[1/3,0.7]$ and $[0.7,\cdot]$, so the shared endpoints are covered twice rather than zero times.
- **Monotonicity: CONFIRMED, and upgraded.** My own 600000-point sweep at 40 digits gives **0 descending steps**, smallest step $3.40\times10^{-12}$ (at the very top, where $F'\to0$). Better than a grid: interval bisection on the branch-correct $F'$ certifies $F'>0$ on $[10^{-12},0.8164]$ in 97 boxes. $F'(A_0)=0$ exactly, since $g'(A_0)=0$ and $\alpha(A_0)=0$ forces $t^*=0$.
- $\max F$ over the sweep is $1.22474487139159=\sqrt{3/2}$ at $A=A_0$, and $F(A_0)-\sqrt{3/2}=0$ to 40 digits, so the equality case is exactly as claimed.

## What a whole-range rigorous certificate looks like

Assembling the pieces, with no floating-point-only step anywhere:

- $F<\sqrt{3/2}$ on $(0,0.7096]$, adaptive interval bisection, 73 boxes, supremum of interval upper bounds $1.223532$;
- $F-\sqrt6/2\le e^2Q(A)$ with $Q<0$ on $[0.7096,A_0]$, 21 boxes, $\sup Q=-2.57\times10^{-4}$, giving strict inequality for every $A<A_0$;
- $F(A_0)=\sqrt6/2=\sqrt{3/2}$ exactly.

Hence $F(A)\le\sqrt{3/2}$ on $(0,A_0]$ with equality only at $A_0$, rigorously.

## Claims I attacked and failed to break

- That $\psi'$ has exactly one positive root and $t_c$ names it (S1), the structure $D=\beta^2+3|\gamma|\alpha$ makes it unbreakable.
- That $\beta\ge0$ exactly on $(0,1/3]$ (S2), exact algebra, the boundary $A^2=1/9$ is right.
- That $L\le13.7250$ bounds $\sup|F'|$ on $[1/3,0.7]$ (S3b), true with $1.85\times$ room to spare.
- That $\max F=1.203230$ on the middle band and the slack is $0.0215$ (S3c), both reproduced by branch-and-bound to 10 digits.
- That the envelope-theorem derivative is correct including at the branch switch (S3a), agrees with 50-digit central differences to $1.5\times10^{-31}$, and $F$ is $C^1$ there because $\psi_t(A_{sw},T)=0$.
- That $F$ is increasing on $(0,A_0]$ (S5), certified by interval arithmetic, not just by a grid.
- Every constant in the endpoint expansion (S4), all verified symbolically.

## The one gap I found in an argument I nonetheless believe

**S4's expansion has no remainder control, and its stated inequality points the wrong way.** $F$ exceeds the second-order model everywhere on $(0,A_0)$, so "leaving an endpoint margin of $(3/4)\sqrt6>0$" is an asymptotic statement about the limit $e\to0$, not a bound on the band $(0.7,A_0]$ where it is deployed. As written the sub-claim proves nothing outside an unspecified neighbourhood of $A_0$; the $Q$-certificate above is the smallest change that makes it a proof, and it needs the interval bisection on $[0.7,0.7096]$ alongside it because the cubic-free bound fails at $0.7$ itself.

One presentational point on S3: the write-up describes the middle band as closed by "a Lipschitz certificate", which is a numerical certificate, not a proof, unless $L$ is itself derived rigorously and the grid maximum is evaluated with directed rounding. The derivation of $L$ given in the claim is rigorous in structure (each term bounded separately over the band), so the certificate is sound, but the interval bisection in [review_r64_b0_interval.py](../scripts/reviewers/r64/review_r64_b0_interval.py) closes the same band in 63 boxes rather than 204000 grid points, and is a proof outright. Preferring it would remove the last place in the argument where a reader has to trust a floating-point maximum.


---

## Synthesis carried in REVIEW.md

### Reviewer 64: the residual one-variable inequality of Lemma L35

Full report in [reviews/REVIEW_r64.md](reviews/REVIEW_r64.md). Clean-room reimplementation; no background jobs left running.

**All five sub-claims confirmed, and the middle band upgraded from a numerical certificate to a proof.** Adaptive `mpmath.iv` bisection at $200$ bits closes $[1/3,0.7]$ in $63$ boxes with no failures, handling the cap as the *exact range* of $\min(t_c,T)$ over each box so no branch analysis is needed, and inflating boxes outward by $2^{-150}$ so no sliver escapes the tiling. Branch-and-bound gives $\max F\in[1.20322955981,\,1.20322956076]$, the claimed $1.203230$, argmax at the endpoint, no interior spike.

**The one real gap is in the endpoint band.** The second-order expansion's constants are all exactly right, but it carries no remainder bound and the inequality points the wrong way: $(\sqrt{3/2}-F)/\varepsilon^2$ approaches $\tfrac34\sqrt6$ from below, so the model *understates* $F$ at every point of $(0.7,A_0)$ and proves nothing outside an unspecified neighbourhood of $A_0$. Repair supplied and adopted: $F-\tfrac{\sqrt6}{2}\le\varepsilon^2Q(A)$ with $Q=\tfrac12\sup_{[A,A_0]}g''+9K_0^2(A_0+A)^2/(4|\beta|)$, certifying $[0.7096,A_0]$ in $21$ boxes, with $[0.7,0.7096]$ left to direct bisection since $Q$ genuinely fails at $0.70$.

**Two corrections to the derivative argument.** The branch switch is at $A=0.44634841803$, inside the band rather than outside it, and $F$ is $C^1$ there because $\psi_t(A_{\rm sw},T)=0$ by the definition of $t_c$, verified against $50$-digit central differences to $1.5\times10^{-31}$, a check the original argument omitted. And the derived Lipschitz bound $L\le13.7250$ is valid but $1.85\times$ loose against the true $\sup|F'|\le7.4080$.

**Whole-range verdict**: $F<\sqrt{3/2}$ on $(0,0.7096]$ in $73$ boxes, $Q<0$ on $[0.7096,A_0]$ in $21$, and $F(A_0)=\sqrt{3/2}$ exactly, no floating-point-only step. Monotonicity is likewise certified by interval arithmetic on $[10^{-12},0.8164]$ rather than sampled.
