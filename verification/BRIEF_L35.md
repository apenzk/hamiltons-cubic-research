# Brief for round L35

**Verbatim extracts. Nothing here is paraphrased.**

## A. The canonical statement, from results.md

```markdown
##### Lemma L35, at most two negative eigenvalues caps $\theta$ at $\sqrt{3/2}$

Let $W\in\mathrm{Weyl}_m$ have at most two negative eigenvalues, at any number of positive ones and any $m$. Then $\theta\le\sqrt{3/2}$.

**Proof:** [stratum-two-negative.md](findings/stratum-two-negative.md)

##### Lemma L36, $S=0$ caps the negative eigenspace at $\lfloor n^2/4\rfloor$
```

## B. The proof block, from findings/stratum-two-negative.md lines 443-491

```markdown
#### Lemma L35, at most two negative eigenvalues caps $\theta$ at $\sqrt{3/2}$, unconditionally

*Moved here from [results.md](../results.md) on 2026-08-31, where it was the only copy. It generalises the one-positive lemma above to **any** number of positive eigenvalues and needs no descent, the descent having been refuted by the full-support witnesses recorded above.*

Needed because Lemma L29 covered only one positive eigenvalue, and the descent that used to
reduce the general case to dimension four is refuted by Lemma L34. This closes the stratum
directly instead.

**Statement.** Let $W\in\mathrm{Weyl}_m$ have **unit norm** and at most two negative eigenvalues, at any number of positive ones, at any $m$. Then $\theta\le\sqrt{3/2}$.

*Content and sharpness both begin at $m=4$: zero negative eigenvalues is impossible by trace-freeness, and the bound is attained at $(2,-1,-1)/\sqrt6$.* **The argument below is written for exactly two negative eigenvalues; the one-negative case is the $c\to0$ boundary and is owed a line.** *And the chain never uses the first Bianchi identity, so what it proves is stronger than a statement about $\mathrm{Weyl}_m$, it holds for any trace-free symmetric operator on $\Lambda^2$ with the stated sign pattern.*

**The chain.** In an orthonormal eigenbasis, with $T_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$,

$$\theta=\sum_\alpha\lambda_\alpha^3+3\!\!\sum_{\alpha<\beta<\gamma}\!\!T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma,$$

an identity requiring no Weyl hypothesis, **but requiring $\lVert W\rVert=1$**, since the display is $P(W)$ and $\theta$ is $P/\lVert W\rVert^3$. *[Lemma L29](../findings/stratum-two-negative.md#lemma-l29-one-positive-and-two-negative-eigenvalues-cap-theta-at-sqrt32-canonical-statement-and-proof) states the norm where this dropped it, and [Lemma L70](../findings/bounds.md) lost the same hypothesis from the same kind of list.* The coefficient $3$ is confirmed twice by disjoint routes: against L29's half-sum-over-ordered-triples bookkeeping, and at $(2,-1,-1)/\sqrt6$, where $\sum\lambda^3=1/\sqrt6$ and $3T\lambda_1\lambda_2\lambda_3=2/\sqrt6$ with $T=2$ sum to exactly $\sqrt{3/2}$. Relaxing $T$ to any nonnegative totally symmetric
tensor with row marginals $m-2$ and pair caps $\sum_\gamma T_{\alpha\beta\gamma}\le2$ gives
$\theta\le\mathrm{LP}(\lambda)$. *The marginal is **[Lemma L153](bounds.md)** in its **unordered** form, the display here sums over $\beta<\gamma$, where the value is $m-2$, against L153's $2(m-2)$ over ordered pairs. Both are right and the factor $2$ is the reading, not an error; **[r569](../reviews/REVIEW_r569.md) logged the missing conversion, and [r695](../reviews/REVIEW_r695.md) and [r696](../reviews/REVIEW_r696.md) each reached it again auditing L153.** The pair cap is **[Lemma L31](../findings/stratum-two-negative.md#lemma-l31-the-bracket-cap-characterised-canonical-statement-and-proof)**.* Dropping the marginals, legitimate, since dropping constraints
only enlarges a maximum, gives $\mathrm{LP}\le G$, where $G$ is a pair-capped fractional
triangle packing supported on the nonzero eigenvalues alone and therefore **free of $m$ and of
$\binom m2$**. ***So this lemma states the row marginal and then discards it***: every step from here to $\sqrt{3/2}$ runs on $G$, whose inputs are nonnegativity, total symmetry and the pair caps, **so the bound would survive [L153](bounds.md) being false**, which is why L153's consumer table records L35 as a states-and-drops citation rather than a consumer. $G$ decouples exactly, **and it is an identity, not an inequality in the safe direction**: the $(+++)$ entries and the $(+--)$ entries consume **disjoint** pair caps, the $(++-)$ entries that would join them being zeroed by sign. The $(+--)$ transport is worth $2bc\lambda_1$ and the rest is a packing on the positives, giving
$G=\sum\lambda^3+3\,\mathrm{FTP}(\lambda_P)-s^3+3bc(s+2\lambda_1)$ with $bc=(s^2+u-1)/2$.

**What closes symbolically and what does not.** The interval $(0,\tfrac13]$ and the endpoint close in closed form, and every endpoint constant reproduces by hand, $g(A_0)=\sqrt6/2$, $g'(A_0)=0$, $-\tfrac12g''(A_0)=\tfrac94\sqrt6$. **The remaining interval $(\tfrac13,0.7096]$ closes by $200$-bit interval arithmetic with branch-and-bound, and $[0.7,0.7096]$ by bisection.** That is rigorous and it is **not hand-checkable**, so this result is a proof with a certified numerical step rather than one a reader can follow end to end. *The programme's standard is an argument a human can check, and the record should say which part of this one is which.* **The constant itself is predicted rather than fitted**, $\sqrt{3/2}$ enters the record as $\theta$ at an exhibited point, four days before the packing argument, so the shape [L107](../findings/bounds.md) was found to have this afternoon is absent here.

**The closing lemma is the sharp dual weight.** For a triple of positives the dual
$z_{\alpha\beta}=\mu\cdot\tfrac32\lambda_\alpha\lambda_\beta$ is feasible exactly when $\mu$ is at
least the triple's harmonic mean, so the binding value is $h$, the harmonic mean of the three
largest positives, and $3M(\lambda_P)\le h\,(s^2-u)$. With $h\le\min(\lambda_1,\tfrac3{2\sqrt2}\sqrt d)$
and two further elementary bounds, $G$ is dominated by a three-parameter relaxation strictly
increasing in $s$ and $u$; forcing both to the constraint $s^2\le2-2u$ **forces $b=c$** and leaves
two variables, in three regions capped at $1.017217$, $1.067666$, and an envelope whose maximum is
exactly $\sqrt{3/2}$ at $A=\sqrt{2/3}$. The cases of one and two positive eigenvalues close in
closed form. $\square$

**The residual inequality is closed, and rigorously.** It splits into three ranges because no
single argument reaches the whole interval: $(0,\tfrac13]$ in closed form at $\le\tfrac89$, where
$\beta$ vanishes exactly at $\tfrac13$; $(\tfrac13,0.7]$ where dropping the cubic overshoots so it
is retained; and $(0.7,A_0]$ at the endpoint, where $g(A_0)=\sqrt6/2$, $g'(A_0)=0$ and
$-\tfrac12g''(A_0)=\tfrac94\sqrt6$ against $\psi^*=\tfrac32\sqrt6\,\varepsilon^2$, a margin of
$\tfrac34\sqrt6$. Interval arithmetic at $200$ bits closes the whole of $(0,A_0]$ in $94$ adaptive
boxes with **no floating-point-only step**, and certifies $F'>0$ throughout rather than sampling it. Gate 2 passed by two
reviewers on identical briefs, agreeing on every claim and reaching this one by different routes,
one through a dual whose feasibility is Nesbitt's inequality, one through the five lemmas above.
They also corrected three claims made in deriving it: an inequality credited to the curvature
identity that is in fact Cauchy–Schwarz, a per-$k$ table of maxima that was a sampling artefact,
and a dropped factor of $3$.

```

## C. The chain, the dual and the residual inequality, from findings/stratum-two-negative.md lines 522-615

```markdown
## The $\theta\le\mathrm{LP}\le G\le\sqrt{3/2}$ chain for two negative eigenvalues, its sharp dual weight, and the residual one-variable inequality
*From findings/isotropy-cap.md. Belongs in stratum-two-negative.md because its subject is $W\in\mathrm{Weyl}_m$ with exactly two negative eigenvalues, the canonical Lemma L35 and Lemma L42 live there, and the Lemma L42 block there points at an argument it does not carry.*

#### B0's owed bound is proved, modulo one elementary inequality

For every $W\in\mathrm{Weyl}_m$ with exactly two negative eigenvalues, at every $m$ and any number $k$ of positive eigenvalues,

$$\theta\ \le\ \mathrm{LP}(\lambda)\ \le\ G(\lambda)\ \le\ \sqrt{3/2}.$$

*Gate 2 landed, Reviewers 62 and 63 on identical briefs, agreeing on all six claims and reaching the last one by different routes.*

#### The chain

In the eigenframe $\theta=\sum_\alpha\lambda_\alpha^3+3\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$, an identity needing no Weyl hypothesis. Relaxing $T$ to any nonnegative totally symmetric tensor with the row marginals and the pair cap gives $\mathrm{LP}(\lambda)$; **dropping the marginals gives $G$**, legitimate because dropping constraints only enlarges a maximum, and leaving a pair-capped fractional triangle packing on the $2+k$ nonzero indices with no $m$ and no $N$ in it. $G$ decouples exactly (Reviewer 62): the $(+--)$ transport is worth $2bc\lambda_1$ and the rest is a packing on the positives alone, so $G=\sum\lambda^3+3\,\mathrm{FTP}(\lambda_P)-s^3+3bc(s+2\lambda_1)$ with $bc=(s^2+u-1)/2$, matched to the brute-force LP at $3\times10^{-16}$.

#### The lemma that closes it is the sharp dual weight, and it is now PROVED, by LP weak duality, not verified

*The "$2800$ draws" recorded below were checking a theorem.*

#### The primal

$M(\lambda_P):=\max\sum_{\alpha<\beta<\gamma}t_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ over $t\ge0$ subject to the pair cap $\sum_{\gamma\notin\{\alpha,\beta\}}t_{\alpha\beta\gamma}\le2$ for every pair.

**Its dual** is $\min\ 2\sum_{\alpha<\beta}z_{\alpha\beta}$ subject to $z_{\alpha\beta}+z_{\beta\gamma}+z_{\alpha\gamma}\ge\lambda_\alpha\lambda_\beta\lambda_\gamma$ on every triple, $z\ge0$.

#### Feasibility of the product weight

Put $z_{\alpha\beta}=c\,\lambda_\alpha\lambda_\beta$. Dividing the triple constraint by $\lambda_\alpha\lambda_\beta\lambda_\gamma>0$ turns it into
$$c\Big(\tfrac1{\lambda_\alpha}+\tfrac1{\lambda_\beta}+\tfrac1{\lambda_\gamma}\Big)\ \ge\ 1,\qquad\text{i.e.}\qquad c\ \ge\ \tfrac13H(\alpha,\beta,\gamma),$$
with $H$ the **harmonic mean** of the triple, since $\sum1/\lambda=3/H$. The harmonic mean is increasing in each argument, so the binding triple is the **three largest positives** and $c=h/3$ is feasible.

#### Weak duality

With that $c$,
$$M(\lambda_P)\ \le\ 2\sum_{\alpha<\beta}z_{\alpha\beta}\ =\ 2\cdot\tfrac h3\cdot\tfrac{s^2-u}2\ =\ \tfrac h3(s^2-u),$$

$$\boxed{\ 3M(\lambda_P)\ \le\ h\,(s^2-u)\ },\qquad h=\text{harmonic mean of the three largest positives.}$$

#### It is sharp, and the equal case shows it

With $k$ equal positives $\lambda$: $h=\lambda$, $s^2-u=k(k-1)\lambda^2$, so the bound reads $3M\le k(k-1)\lambda^3$. *The pair-count $\sum t\le k(k-1)/3$ is the same upper bound again, not attainment*, **both Gate 2 reviewers flagged that, and both supplied the missing maximiser**: $t_{\alpha\beta\gamma}=2/(k-2)$ on every triple has pair marginal $(k-2)\cdot\frac2{k-2}=2$, feasible, with $\sum t=\binom k3\frac2{k-2}=k(k-1)/3$. So equality genuinely holds for $k\ge3$ and no constant in the lemma can be improved.

#### Hypothesis, previously unstated: at least three positives

At $k\le2$ there are no triples, $M=0$, and $h$ is undefined; those cases are closed elsewhere.

*One correction to what was recorded.* The intermediate feasibility threshold was written as $\mu\ge2/\sum\lambda^{-1}$ with $z=\mu\cdot\tfrac32\lambda_\alpha\lambda_\beta$; in that normalisation $c=\tfrac32\mu$ and the condition is $\mu\ge2/\big(3\sum\lambda^{-1}\big)$, the recorded form is off by a factor $3$. **The final inequality is unaffected.** *The gloss "at least the harmonic mean of the triple" is ALSO wrong* (Gate 2, [Reviewer 84](../reviews/REVIEW_r84.md)): $\mu\ge H$ is $\tfrac92$ times the true threshold and matches neither the recorded $2H/3$ nor the truth $2H/9$, with $\mu=h$ the dual gives $3M\le\tfrac92h(s^2-u)$, four and a half times weaker than the boxed lemma. The lemma is true; **the derivation above is what establishes it**, not the superseded chain.

#### The residual gap, and the half of it that is now closed

The final one-variable inequality, $g(A)+\max_{0\le t\le\frac{2\sqrt2}{3}A}\psi(t)\le\sqrt{3/2}$ on $A\in(0,A_0]$, $A_0=\sqrt{2/3}$, was verified on a grid rather than argued symbolically, and equality at the endpoint rules out a Lipschitz certificate there. **The endpoint is now closed in exact arithmetic.** With $g(A)=A^3-(1-A^2)^{3/2}/\sqrt2+3A(1-A^2)$:

$$g(A_0)=\tfrac{\sqrt6}{2}=\sqrt{3/2},\qquad g'(A_0)=0,\qquad -\tfrac12g''(A_0)=\tfrac94\sqrt6,$$

while $\alpha(A_0-\varepsilon)=3\sqrt3\,\varepsilon$ and $\beta(A_0)=-\tfrac34\sqrt6$ give $t^*=\sqrt2\,\varepsilon$ (well inside the cap, so the unconstrained cubic maximum is the operative one) and $\psi^*=\alpha^2/(4|\beta|)=\tfrac32\sqrt6\,\varepsilon^2$. So $g$ falls away at $\tfrac94\sqrt6\,\varepsilon^2$ against a climb of $\tfrac32\sqrt6\,\varepsilon^2$, an **endpoint margin of $\tfrac34\sqrt6>0$**, a clean factor $3/2$, every constant a surd, computed symbolically. *Also confirmed independently: $g'(A)=3-6A^2+\tfrac32A\sqrt{2-2A^2}$, whose only root in range is $A_0$; and over $4\times10^5$ points $F=g+\psi^*$ is strictly increasing on $(0,A_0]$, minimum forward difference $+7.7\times10^{-12}$, zero descending steps.*

#### The interior is now covered too, in three ranges

$\psi^*$ has a closed form: $\gamma<0$ makes the roots' product $\alpha/(3\gamma)<0$, so $\psi'$ has a unique positive root $t_c=\big(-\beta-\sqrt{\beta^2-3\gamma\alpha}\big)/(3\gamma)$ and $\psi^*=\psi(\min(t_c,T))$.

| range | argument | margin |
|---|---|---|
| $(0,\tfrac13]$ | closed form: dropping $\gamma t^3\le0$ gives $g+\alpha T+\beta T^2\le\tfrac89$, peaking at $A=\tfrac13$ where $\beta=0$ exactly ($\sqrt{2-2A^2}=4A\iff A^2=\tfrac19$) | $+0.336$ |
| $(\tfrac13,0.7]$ | Lipschitz certificate with a **derived** constant | $+0.0215$ |
| $(0.7,A_0]$ | the exact endpoint expansion above, **but see the withdrawal below: the expansion carries no remainder bound and certifies nothing outside an unspecified neighbourhood, so this interval is closed by bisection rather than by the expansion** | $\tfrac34\sqrt6$ |

#### The Lipschitz constant is derived, not measured

By the envelope theorem $F'=g'+\alpha't+\beta't^2$ on the interior branch and adds $(\alpha+2\beta T+3\gamma T^2)T'$ on the capped one, with $\alpha'=-\tfrac{9\sqrt2}{2}A$, $\beta'=-\tfrac{3\sqrt2A}{4\sqrt{1-A^2}}-3$, $T'=\tfrac{2\sqrt2}{3}$; bounding each on $[\tfrac13,0.7]$ gives $L\le13.7250$. At $h=1.83\times10^{-6}$ the certificate is $\max F+Lh/2=1.203242\le\sqrt{3/2}$, the slack exceeding the discretisation term by three orders. *Dropping the cubic is too lossy in this band, the envelope overshoots to $1.3026$, so the cubic is retained here and only here.*

#### Gate 2 landed (Reviewer 64), and the argument is now rigorous

The grid evaluation is replaced by interval arithmetic at $200$ bits: $F<\sqrt{3/2}$ on $(0,0.7096]$ in $73$ adaptive boxes, $Q<0$ on $[0.7096,A_0]$ in $21$, and $F(A_0)=\sqrt{3/2}$ exactly, **no floating-point-only step anywhere**. Branch-and-bound puts the middle band's maximum in $[1.20322955981,\,1.20322956076]$, confirming $1.203230$ with no interior spike, and monotonicity $F'>0$ is certified on $[10^{-12},0.8164]$ rather than sampled.

#### One repair, to the endpoint band

The second-order expansion has every constant exactly right but **carries no remainder bound and points the wrong way**: $(\sqrt{3/2}-F)/\varepsilon^2$ approaches $\tfrac34\sqrt6$ *from below*, so the model sits under $F$ away from $A_0$, by $-3.4\times10^{-3}$ at $A=0.7$, and certifies nothing outside an unspecified neighbourhood. Confirmed independently here. The repair is $F-\tfrac{\sqrt6}{2}\le\varepsilon^2Q(A)$ with $Q=\tfrac12\sup_{[A,A_0]}g''+9K_0^2(A_0+A)^2/(4|\beta|)$, from $\psi^*\le\alpha^2/(4|\beta|)$ and Taylor with integral remainder; dividing by $\varepsilon^2$ removes the degeneracy at $A_0$. $Q$ genuinely fails at $A=0.70$, so $[0.7,0.7096]$ goes to direct bisection instead.

#### Two further corrections

The branch switch $t_c=T$ sits at $A=0.4463$, **inside** the middle band, and $F$ is $C^1$ there because $\psi_t(A_{\rm sw},T)=0$ by the definition of $t_c$, so the capped branch's extra term vanishes and the one-sided derivatives agree, a check the original argument never made. And the derived $L\le13.7250$ is valid but $1.85\times$ loose: the true $\sup|F'|$ on the band is $\le7.4080$.

#### Three of this cycle's own claims are corrected

*(i)* $(b+c)^2+b^2+c^2\ge1$ **is Cauchy–Schwarz** ($(\sum_P\lambda)^2\ge\sum_P\lambda^2$ with trace-freeness and unit norm), true of any two-negative spectrum, Weyl or not, and both reviewers said so independently. Calling it an identity on the base-case family was vacuous: that family has exactly one positive eigenvalue, where Cauchy–Schwarz is an equality by definition. The identity's real content is the sharper $2b^2+2c^2+bcR\ge1$, which applying $R\le2$ discards. *(ii)* **$\sup G=\sqrt{3/2}$ at every $k$**, not a decreasing sequence: the $k$-stratum closure contains every smaller one, and embedding the $k=1$ optimum by splitting its positive into $\varepsilon$-parts returns $\sqrt{3/2}$ to $10^{-13}$ at $k=2,3,5,7$. The recorded per-$k$ table was a maximum over random draws, hence a lower bound, and the "monotone decrease in $k$" read off it does not exist. *(iii)* $\theta\le9bc(b+c)$ **stands as a theorem** but its chain drops a factor $3$ in the $(+--)$ block and its appeal to the row-sum identity is removable, the pair cap alone giving the same constant; its "all steps tight on the base-case family" tests two of five steps, the rest being vacuous at $k=1$.

#### And the standing advice against another dual was wrong

The three refuted ansätze are refuted, their duals are independently verified *feasible*, so the refutations are of the constants and not of the method, but they are wasteful by up to $3\lambda_1/\lambda_3$, and the sharp choice $\mu=h$ is precisely the lemma that closes the proof. **A shape is not dead because three of its constants are.**

---

*Re-filed here 2026-09-02 from [second-order.md](second-order.md) by the parallel sort of [findings/](.). Conventions: [conventions.md](conventions.md).*

```
