# Reviewer r445, Lemma L143, $\sup\lvert P\rvert\le1+\sqrt{n-2}$

*Adversarial audit, cold brief, 2026-09-03. Target: [Lemma L143](../findings/bounds.md) in [bounds.md](../findings/bounds.md). Analysis only, no computation was run, and none is cited below.*

## Verdict in one line

**The inequality is CONFIRMED, all five steps survive, and I re-derived both borrowed marginals from scratch rather than inheriting them. The lemma's placement paragraph is REFUTED**: it repeats verbatim the framing error for which [Lemma L142](../findings/bounds.md) was corrected twenty lines above it in the same file, and it omits the two recorded bounds that beat it. The constant is also **not the best its own inputs give**: the record's own Rayleigh-quotient lemma plus the identical two marginals yields $\sqrt{n-1}$ in three lines, strictly below $1+\sqrt{n-2}$ at every $n$.

| item | verdict |
| --- | --- |
| Step 1, $\sup\lvert P\rvert=\sup P$ at a critical point, $\theta=P(W)$ | **CONFIRMED**, and redundant |
| Step 2 (domain of $\theta\le\lambda_{\max}p+B_5$ | **CONFIRMED**), the bound is unconditional on the unit sphere |
| Step 3, $\lambda_{\max}p\le1$ | **CONFIRMED** |
| Step 4 ($0\le\langle T_\alpha\mu,\mu\rangle\le2$ | **CONFIRMED**), index bookkeeping is right |
| Step 5, $\sum_\alpha f_\alpha^2\le4(n-2)$, hence $B_5\le\sqrt{n-2}$ | **CONFIRMED** |
| The statement $\sup\lvert P\rvert\le1+\sqrt{n-2}$ | **CONFIRMED** |
| "Where it stands against what is known" | **REFUTED**, see D1, D2 |
| "It does not reach the $O(1)$ regime in which [r443](REVIEW_r443.md)'s estimate returns $\Theta(n^{-3/2})$" | **REFUTED**, $O(\sqrt n)$ already suffices, see D4 |
| Best constant from its own input | **REFUTED**, $\sqrt{n-1}$, see D3 |
| Vacuity | **not vacuous** |

---

## Phase 0, the novelty screen, by value rather than by vocabulary

I searched [findings/](../findings/) for every recorded upper bound on $\sup_{\lVert W\rVert=1}\lvert P(W)\rvert$ or on $M(n)$, and compared numerically at $n=6,8,12$. **The record already holds two bounds of the same $O(\sqrt n)$ order with strictly better constants, and L143 cites neither.**

| bound | source | $n=6$ | $n=8$ | $n=12$ |
| --- | --- | --- | --- | --- |
| $\Pi$-bound worst case $n-1$ | [Lemma L107](../findings/bounds.md) | 5 | 7 | 11 |
| $\sqrt y+(n-2)y$, worst case $n-1$ | [second-order.md](../findings/second-order.md) | 5 | 7 | 11 |
| Xu Lemma 2.14, $\sqrt{(n^2-1)(n-2)/n}$ | [post F2b](../findings/fence-posts.md) | 4.83 | 6.87 | 10.92 |
| **L143, $1+\sqrt{n-2}$** | [bounds.md](../findings/bounds.md) | **3.000** | **3.449** | **4.162** |
| $\lambda_{\max}(M)$ + the same two marginals (D3 below) | corollary of [second-order.md](../findings/second-order.md) | 2.236 | 2.646 | 3.317 |
| deficiency LP maximised over spectra | [bounds.md](../findings/bounds.md) |, | **2.291** | **2.840** |
| post F10's marginal LP, spectrum free | [fence-posts.md](../findings/fence-posts.md), [bounds.md](../findings/bounds.md) | **1.606** |, | **2.53** |
| rank profile $\Phi(r)$ at $r=15$ (full rank, $n=6$) | [second-order.md](../findings/second-order.md) | **1.630** | (|), |

**So the answer to the brief's question is no**: at $n=12$, $1+\sqrt{10}=4.162$ is *not* below every recorded bound. Post F10's LP sits at $2.53$ and the deficiency LP at $2.840$.

**And post F10 is not merely a stronger number, it is a fence post against exactly this route.** Its title is *"Marginal relaxations of the bracket tensor cannot bound $P$"*, and its content is that imposing nonnegativity, total symmetry, the row marginal $2(n-2)$, the pair cap $2$ **and** $\operatorname{tr}(W^\#)=-1$ still leaves an optimum near $0.80\sqrt{n-2}$. L143's own summary sentence (*"The two marginals are the whole of its input, which is why it stops at $O(\sqrt n)$"*), is post F10's conclusion, discovered a second time by hand and landing $25\%$ above post F10's measured constant.

**The domination is logical, not just numerical.** L143's feasible set is a *superset* of the F10 LP's (it drops $\operatorname{tr}(W^\#)=-1$), and $\lambda_{\max}p+B_5\ge P$ holds pointwise on that set, so $\mathrm{LP}(n)\le1+\sqrt{n-2}$ is forced. L143 cannot be stronger than post F10 anywhere; it can only be a closed form where post F10 has a table.

**What survives the screen, and it is real.** Post F10's values are per-$n$ measurements and the law $0.80\sqrt{n-2}$ is a fit; L143 is a proved closed form valid at every $n$, and this programme is on an analysis-only footing precisely because derivations outlast figures. **That is L143's whole residual value, and the lemma never claims it.**

---

## D1, the "measured supremum of $\approx1.5449$" is the supremum of the bound, not of $P$

L143's placement paragraph reads: *"At $n=12$ it gives $4.162$ against the record's $n-1=11$ and against a measured supremum of $\approx1.5449$, so it is a factor $2.6$ better than what [I2](../plan.md) currently uses and a factor $2.7$ short of the truth."*

**$1.5449$ is not a value of $P$.** It is [second-order.md](../findings/second-order.md)'s measured supremum of the *relaxation bound* $\lambda_{\max}p+B_5$, whose value at padded $W_{\mathbb{CP}^2}$ is $1.54433$ against that point's actual $\theta=\sqrt{3/2}=1.2247$. The largest recorded value of $\lvert P\rvert$ at $n=12$ is $\theta_0(12)=1.236033$.

**This is the identical error the record already corrected, in the same file, twenty lines earlier.** [Lemma L142](../findings/bounds.md)'s withdrawal note lists among its three framing errors: *"the record's numerics put the true supremum near $1.545$, that figure is the supremum of a **relaxation bound**, not of $P$, and points a successor above the true target $\sqrt2$."* L143 was written above that paragraph on the same day and reproduces it.

**Consequences, both concrete.** The shortfall factor is $4.162/1.236=3.37$, not $2.7$. And a successor reading "the truth is $1.5449$" will aim a dimension-free constant at a target *above* $\sqrt2$, which is the exact failure the L142 note warns of.

## D2, the comparison set is incomplete, and the two omissions are the two that matter

The paragraph compares L143 against $n-1$ and against $1.5449$ only. It omits post F10 ($2.53$ at $n=12$), the deficiency LP ($2.840$ at $n=12$, recorded in [bounds.md](../findings/bounds.md) itself, about two hundred lines below L143), and the rank profile ($1.630$ at full rank for $n=6$, against L143's $3.000$).

**A lemma whose stated purpose is "improving the record's standing $n-1$" owes a screen against the record's other bounds**, and this is the failure mode the brief names: the stronger statement was already there.

## D3, the constant is not the best its own two inputs give: $\sqrt{n-1}$ follows in three lines

[second-order.md](../findings/second-order.md) records, as a boxed one-line result, that $P$ is a Rayleigh quotient:

$$P=\langle\lambda,M(\lambda)\lambda\rangle,\qquad M(\lambda)_{\alpha\beta}=\delta_{\alpha\beta}\lambda_\alpha+\tfrac12\sum_\gamma T_{\alpha\beta\gamma}\lambda_\gamma,\qquad\text{hence}\qquad\theta\le\lambda_{\max}\big(M(\lambda)\big).$$

Write $M=\operatorname{diag}(\lambda)+\tfrac12u$ with $u_{\alpha\beta}=\sum_\gamma T_{\alpha\beta\gamma}\lambda_\gamma$. Since $T$ vanishes whenever two indices coincide ([conventions.md](../findings/conventions.md)), $u$ is **hollow**, so the two summands are Frobenius-orthogonal and $\lVert M\rVert_F^2=1+\tfrac14\sum_{\alpha\beta}u_{\alpha\beta}^2$. Cauchy–Schwarz with the weights $T_{\alpha\beta\cdot}\ge0$, then the pair cap, then the Killing row mass:

$$u_{\alpha\beta}^2\le\Big(\sum_\gamma T_{\alpha\beta\gamma}\Big)\Big(\sum_\gamma T_{\alpha\beta\gamma}\lambda_\gamma^2\Big)\le2\sum_\gamma T_{\alpha\beta\gamma}\lambda_\gamma^2,\qquad \sum_{\alpha\beta}u_{\alpha\beta}^2\le2\sum_\gamma\lambda_\gamma^2\sum_{\alpha\beta}T_{\alpha\beta\gamma}=4(n-2).$$

So $\lVert M\rVert_F^2\le1+(n-2)=n-1$ and

$$\theta\;\le\;\lambda_{\max}(M)\;\le\;\lVert M\rVert_2\;\le\;\lVert M\rVert_F\;\le\;\sqrt{n-1}.$$

**Same two marginals, same normalisation, no new instrument, and strictly stronger at every $n$**, since $(1+\sqrt{n-2})^2=(n-1)+2\sqrt{n-2}$. At $n=12$: $3.317$ against $4.162$.

**The relation between the two is exact and diagnostic.** Applying the *triangle* inequality to the same split gives $\lambda_{\max}(M)\le\lambda_{\max}+\tfrac12\lVert u\rVert_2\le1+\sqrt{n-2}$, which is L143 on the nose. **L143 is the triangle-inequality reading of a split whose Pythagorean reading is available for free**, because $\operatorname{diag}(\lambda)$ and $u$ are orthogonal.

*This is offered as a repair, not as a lemma of mine, it needs its own Gate 2.*

## D4, the lemma understates its own payoff: $O(\sqrt n)$ already delivers $\Omega(n^{-3/2})$

L143 says *"it does not reach the $O(1)$ regime in which [r443](REVIEW_r443.md)'s estimate returns $\Theta(n^{-3/2})$."* **That is false of r443's own displayed formula.** r443's D5 gives

$$r_n\;\gtrsim\;\min_{0\le u\le1/2}\ \min\left(\frac{c_p+u^2}{\lvert P\rvert_\infty+nu},\ \frac{\sqrt{c_p+u^2}}{n}\right),\qquad c_p=\Theta(1/n).$$

The second branch is $\ge\sqrt{c_p}/n=\Theta(n^{-3/2})$ with no input from $\lvert P\rvert_\infty$ at all. For the first, take $\lvert P\rvert_\infty\le K\sqrt n$ and split at $u=n^{-1/2}$:

- $u\le n^{-1/2}$: denominator $\le(K+1)\sqrt n$, numerator $\ge c_p=\Theta(1/n)$, ratio $\gtrsim n^{-3/2}$;
- $u\ge n^{-1/2}$: then $nu\ge\sqrt n\ge\lvert P\rvert_\infty/K$, denominator $\le(K+1)nu$, numerator $\ge u^2$, ratio $\ge u/((K+1)n)\ge n^{-3/2}/(K+1)$.

**So $r_n=\Omega(n^{-3/2})$ holds already at $\lvert P\rvert_\infty=O(\sqrt n)$**, and L143 (or better, D3's $\sqrt{n-1}$), delivers the full payoff [I31](../plan.md) was opened to fetch for [I2](../plan.md). The $O(1)$ constant is still worth having for its own sake, but it is not what the exponent turns on. **The lemma's own "what it does and does not do" paragraph gives away a result it proves.**

## D5, the loss is localised in the wrong place

L143 says the bound stops at $O(\sqrt n)$ because *"neither [marginal] sees that $\mu$ concentrates where $T$ does not."* **The row mass is not the lossy step; the $\ell^2$-by-$\ell^1$ step is.**

Take $\mu$ flat, $\mu_\beta=1/\sqrt N$ with $N=\binom n2$. Then $\sum_\alpha f_\alpha=\sum_{\alpha\beta\gamma}T_{\alpha\beta\gamma}\mu_\beta\mu_\gamma=2(n-2)$ **exactly** (the row-mass step is saturated, not lossy) while each $f_\alpha=2(n-2)/N$, so $\sum_\alpha f_\alpha^2=4(n-2)^2/N\to8$ and $B_5\to\sqrt2$, against the claimed $\sqrt{n-2}$.

The step $\sum_\alpha f_\alpha^2\le2\sum_\alpha f_\alpha$ is saturated only if the total mass $2(n-2)$ sits on $n-2$ of the $N$ rows *at the cap*, and the row structure of $T$ spreads it. **The culprit is the row count, and this matters for a successor**: the repair is a bound on how concentrated $f$ can be across $N$ rows, not a bound on $\mu$'s alignment with $T$.

---

## The steps, one by one

### Step 1, CONFIRMED, and load-bearing only in appearance

$P$ is a homogeneous cubic, hence odd; $\mathcal W_n$ is a linear subspace, hence closed under $W\mapsto-W$; the unit sphere in it is compact. So $\sup\lvert P\rvert=\sup P$ and the sup is attained. At a maximiser, Euler's identity gives $\langle\nabla P,W\rangle=3P(W)$, and $\nabla P=3Q(W)$ with $Q$ mapping $\mathcal W_n$ to itself ([conventions.md](../findings/conventions.md)), so the Lagrange condition is $Q(W)=\theta W$ with $\theta=P(W)$, which is the record's own definition of a critical point ([conventions.md](../findings/conventions.md), *"Critical point is $Q(W)=\theta W$"*). **Correct.**

**But it is unnecessary.** Both halves of step 2's borrowed bound are pointwise inequalities on the unit sphere (see step 2), so $P(W)\le\lambda_{\max}p+B_5$ holds at every unit $W$ and the compactness/oddness/criticality chain buys nothing. *Recording it as the first move of the proof invites a successor to believe the bound needs a critical point, which it does not, and that belief is the failure mode the brief calls the programme's most expensive recurring error, running in the direction of unnecessary caution rather than unwarranted reach.*

### Step 2, CONFIRMED; the domain is the whole unit sphere, with no hypothesis

I checked [second-order.md](../findings/second-order.md)'s statement of $\theta\le\lambda_{\max}p+B_5$ for hypotheses. **There are none**, no diagonality, no gradedness, no kernel-freeness, no criticality. The two ingredients are:

- $\operatorname{tr}W^3=\sum_\alpha\lambda_\alpha^3\le\sum_{\lambda>0}\lambda_\alpha^3\le\lambda_{\max}\sum_{\lambda>0}\lambda_\alpha^2=\lambda_{\max}p$, pointwise;
- $\langle W,W^\#\rangle=\tfrac12\sum\lambda_\alpha\lambda_\beta\lambda_\gamma T_{\alpha\beta\gamma}\le\tfrac12\sum_\alpha\mu_\alpha\langle T_\alpha\mu,\mu\rangle\le\tfrac12\big(\sum_\alpha\langle T_\alpha\mu,\mu\rangle^2\big)^{1/2}=B_5$, the last step Cauchy–Schwarz against $\sum\mu_\alpha^2=1$, pointwise.

Their sum is $P=\langle W,W^2+W^\#\rangle$ under the record's normalisation, where $\lVert W\rVert^2=\operatorname{tr}(W^2)=\sum\lambda_\alpha^2$ ([conventions.md](../findings/conventions.md)). **No borrowed quantity is used outside its domain.**

The one transported object is $T=c'^2$ in an eigenbasis of $W$. That eigenbasis is an orthonormal basis of $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, and both marginals below are true in *every* orthonormal basis, so the transport is legitimate.

### Step 3, CONFIRMED

$p=\sum_{\lambda>0}\lambda_\alpha^2\le\sum_\alpha\lambda_\alpha^2=1$ and $\lambda_{\max}\le\lVert\lambda\rVert_2=1$. **Correct, and close to the best available from this term alone**: $\sup\operatorname{tr}W^3\to1$ over trace-free unit spectra as $N\to\infty$, so the $1$ is nearly attained by the term it bounds even though it is nowhere near attained jointly with $B_5$.

### Step 4, CONFIRMED, and I re-derived both marginals rather than inheriting them

The written chain is

$$\langle T_\alpha\mu,\mu\rangle=\sum_{\beta\gamma}T_{\alpha\beta\gamma}\mu_\beta\mu_\gamma\le\tfrac12\sum_{\beta\gamma}T_{\alpha\beta\gamma}(\mu_\beta^2+\mu_\gamma^2)=\sum_{\beta\gamma}T_{\alpha\beta\gamma}\mu_\beta^2=\sum_\beta\mu_\beta^2\sum_\gamma T_{\alpha\beta\gamma}\le2\sum_\beta\mu_\beta^2=2.$$

**The collapse of the two AM–GM halves needs only symmetry of $T$ in its last two indices, which total symmetry certainly supplies, and the relabelling $\beta\leftrightarrow\gamma$ is legitimate because both are summed over the full index range.** Nonnegativity of $T$ is needed to apply AM–GM under the sum, and $T=c'^2\ge0$ supplies it.

$\sum_\gamma T_{\alpha\beta\gamma}$ **is** the pair cap for the pair $(\alpha,\beta)$: expanding $[v_\alpha,v_\beta]$ in the orthonormal basis gives $\lVert[v_\alpha,v_\beta]\rVert^2=\sum_\gamma c'^2_{\alpha\beta\gamma}$. **The brief's factor-2 worry (ordered versus unordered), does not bite**: both marginals are full sums over all values of the summed indices, matching [conventions.md](../findings/conventions.md)'s standing rule that sums over pairs are ordered unless stated otherwise, and matching the way the cap and the row mass are written there.

**I verified the cap value $2$ independently, because a factor $\sqrt2$ here would change the result.** For unit $X\in\mathfrak{so}(n)$ with angles $s_1,s_2,\dots$ and $\sum_js_j^2=1$, $\operatorname{ad}_X$ is skew, hence normal, and its eigenvalues on $\Lambda^2$ are $i(\pm s_j\pm s_k)$; so $\lVert\operatorname{ad}_X\rVert_{\mathrm{op}}=\max_{j\ne k}(s_j+s_k)\le\sqrt2$ by Cauchy–Schwarz on two terms, giving $\lVert[v_\alpha,v_\beta]\rVert^2\le2$. **It is attained**: in $\mathfrak{so}(4)$ the self-dual pair $X=(\varphi_{12}+\varphi_{34})/\sqrt2$, $Y=(\varphi_{13}+\varphi_{42})/\sqrt2$ has $[X,Y]=(\varphi_{14}+\varphi_{23})$ of squared norm $2$. *The generic commutator estimate (Böttcher–Wenzel, or $\lVert XY\rVert_F\le\lVert X\rVert_{\mathrm{op}}\lVert Y\rVert_F$), gives only $4$ here, so the record's $2$ is doing real work and is right; a successor who re-derives it the crude way will get $1+\sqrt{2(n-2)}$ and think the lemma wrong.*

Finally, $\sum_\beta\mu_\beta^2=1$ **is** $\lVert W\rVert=1$ in the record's convention: [conventions.md](../findings/conventions.md) fixes $\sum_\alpha\lambda_\alpha^2=\operatorname{tr}(W^2)=1$ for the operator on $\Lambda^2$. *The file's live trap here is the $n\times n$ sectional matrix $K$, where $\lVert K\rVert_F^2=2$ at a unit Weyl tensor, L143 uses the $\Lambda^2$ spectrum throughout and does not touch $K$, so the trap does not fire.*

### Step 5, CONFIRMED, both uses

**First use.** $\sum_\alpha f_\alpha^2\le2\sum_\alpha f_\alpha$ needs $0\le f_\alpha\le2$, which is exactly step 4's two-sided conclusion. **Correct.**

**Second use.** $\sum_\alpha f_\alpha=\sum_{\alpha\beta\gamma}T_{\alpha\beta\gamma}\mu_\beta\mu_\gamma\le\sum_{\alpha\beta\gamma}T_{\alpha\beta\gamma}\mu_\beta^2=\sum_\beta\mu_\beta^2\sum_{\alpha\gamma}T_{\alpha\beta\gamma}=2(n-2)$, the middle step being the same AM–GM plus $\beta\leftrightarrow\gamma$ symmetry.

**The free index is the right one.** [conventions.md](../findings/conventions.md) states the row mass as $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$, free index $\alpha$; L143 needs it with free index $\beta$, and total symmetry of $T$ makes them the same statement. I re-derived the value: $\sum_\beta\lVert[X,v_\beta]\rVert^2=-\operatorname{tr}(\operatorname{ad}_X^2)=-B(X,X)=-(n-2)\operatorname{tr}(X^2)=2(n-2)$ for unit $X$, using the record's Killing normalisation $B(X,Y)=(n-2)\operatorname{tr}(XY)$ and $\operatorname{tr}(X^2)=-2$. **Correct.**

Hence $\sum_\alpha f_\alpha^2\le4(n-2)$ and $B_5\le\tfrac12\sqrt{4(n-2)}=\sqrt{n-2}$, and with step 3, $\sup\lvert P\rvert\le1+\sqrt{n-2}$. **The inequality stands.**

---

## Vacuity check

**Not vacuous.** The bound is finite, unconditional, and strictly below the record's standing $n-1$ for every $n\ge4$ (equal at $n=3$, where $\mathcal W_n=0$ anyway). Conjecture A would imply far more, but Conjecture A is unproved, so L143 is not a consequence of anything currently on the record. Nor is it vacuous in the sense of unreachable: $\sup\lvert P\rvert\ge\theta_0(n)\to\sqrt2$, so the quantity being bounded is genuinely positive and bounded away from $0$.

**Where it is close to vacuous is in its role.** [I31](../plan.md) asks for a **dimension-free** $K$. L143 supplies a growing bound. By D4 that is enough for [I2](../plan.md)'s exponent, but it is not the theorem I31 states, and the item stays open.

---

## What would repair the lemma

1. **Delete the phrase "a factor $2.7$ short of the truth"** and the number $1.5449$ from the placement paragraph. Replace with: *a factor $3.37$ above the largest recorded value of $\lvert P\rvert$ at $n=12$, namely $\theta_0(12)=1.236033$.* This is the L142 correction applied to L143.
2. **Cite [post F10](../findings/fence-posts.md) and the deficiency LP in [bounds.md](../findings/bounds.md)** in the comparison, and state plainly what L143 adds over them: a proved closed form at every $n$, where those are per-$n$ measurements. **Also state that L143 cannot be stronger than post F10 anywhere**, its feasible set being a superset.
3. **Replace the constant with $\sqrt{n-1}$** by D3's Pythagorean split of $M(\lambda)$, or record L143 and the improvement side by side. The improvement uses nothing L143 does not already use.
4. **Correct the "what it does not do" paragraph** per D4: $O(\sqrt n)$ already gives $r_n=\Omega(n^{-3/2})$ in [r443](REVIEW_r443.md)'s own displayed minimum, so [I2](../plan.md)'s exponent moves now.
5. **Move the loss diagnosis** from the marginals to the $\ell^2$-by-$\ell^1$ step, per D5, and note that the row-mass step is *saturated* at flat $\mu$.
6. **Drop or demote step 1's criticality chain**, noting instead that the borrowed bound is pointwise on the unit sphere.

---

*Analysis only, no computation was run for this review, and none was needed. The two marginals, the pair cap's extremal case, and the $\Omega(n^{-3/2})$ split in D4 were derived by hand and are checkable line by line above. Conventions: [conventions.md](../findings/conventions.md).*
