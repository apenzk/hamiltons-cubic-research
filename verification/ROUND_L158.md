# ROUND L158, the branch comparison and its threshold

**Id:** L158. **Source:** [findings/second-order.md](../findings/second-order.md):1272–1329, canonical form at [results.md](../results.md):365–369. **Date:** 2026-09-05. **Verifiers allocated:** v38, v39, v40. **Phase:** 1, dispatched.

**Why this id.** Tier C, next in order, and **the entry the previous round's fatal finding landed on**. [ROUND_L157](ROUND_L157.md) D6 refuted its branch-2 minimum $0.40347$; the corrected $0.38673$ was derived and passed Gate 2 before this round opened, so the verifiers read a repaired numeral rather than a refuted one. *That is exactly why the round is worth running: the entry has just been edited, and an edited entry is the least-read text in the record.*

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on either.)*

1. **Is the threshold a number or a range?** The entry's own history has it at $\approx21$, at $3.98$–$4.44$, at $52.92$ and at $17$–$19$, the spread traced to one constant read at its $n\to\infty$ value. **Which reading is on the page now, and is it derived or asserted?**
2. **Does "branch 2 binds" survive its own corrections?** The claim is made at $n=12$ and extended to $n\approx1800$. **The extension's argument, the dimension at which it stops, and whether the corrected branch-2 minimum changes either, are all to be checked.**

## The brief as dispatched

*Provenance stripped, mathematics verbatim. Both forms unlabelled; a difference between them is the round's first finding.*

### Form A

#### Lemma L158, the branch comparison is $n$-free, and it says $\sup\lvert P\rvert$ must GROW before [I31](../plan.md) can bind

*Derived 2026-09-05.  Rewritten to what survives.*

**The surviving mechanism.** With [Lemma L149](../findings/second-order.md#lemma-l149-no-direction-is-both-low-margin-and-high-operator-norm-so-the-bound-is-uniform)'s $c_p=\kappa/n$, branch 1 $=(c_p+w^2)/S$ is increasing in $w$ with infimum $\kappa/(nS)$, and branch 2 has an infimum of order $n^{-1}$. **The $n^{-1}$ cancels from their ratio**, so which branch binds is decided by an inequality carrying no dimension:

$$\frac{\inf_w\text{branch }1}{\inf_w\text{branch }2}=\frac{\sqrt{\kappa(1+\kappa)}}{S\cdot K},\qquad K:=\text{the branch-2 prefactor},$$

*and branch 1 binds, making $S=\sup\lvert P\rvert$, hence [I31](../plan.md), load-bearing, exactly when $S$ exceeds $\sqrt{\kappa(1+\kappa)}/K$.* **$\inf_w\min(f,g)=\min(\inf f,\inf g)$ is an identity, so comparing separately-taken infima is sound**; *the entry's caveat that [Lemma L148](../findings/second-order.md#lemma-l148-the-defect-vanishes-identically-on-the-margin-summand) undermines this is withdrawn, L148 changes where the infimum is attained, not its value.*

> **$\kappa$ IS ON THE RECORD AND THE ENTRY SAID IT WAS NOT.** Line 1129 above fixes the margin as $c_p=3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)$, whence
> $$\kappa=n\,c_p=3\sqrt{\tfrac{2(n-1)}{n-2}},\qquad \kappa^2=\tfrac{18(n-1)}{n-2},\qquad \kappa(12)=4.4497,\qquad \kappa\downarrow3\sqrt2 .$$
> **Both reviewers found it; the entry had searched for the letter $\kappa$ rather than the quantity $nc_p$.** *That is the third vocabulary search this session to invent a gap the record had filled, after [Lemma L157](../findings/second-order.md#lemma-l157-the-reach-parameter-is-determined-by-a-fixed-point-not-chosen-etatfrac2t1-sqrt4t12t)'s $\eta$ and [Lemma L150](../findings/second-order.md#lemma-l150-withdrawn-it-is-post-f50s-chain-with-post-f50s-surviving-term-deleted)'s own recorded instance, and it was made after a proposal about exactly this had been filed.*

**THE CONCLUSION REVERSES.** With $\kappa\approx4.45$ the threshold is far above the entry's claimed $\kappa<1.42$, itself an arithmetic slip, the root being $1.48$, so **branch 2 binds at $n=12$ and $S$ does not govern there.** *Both reviewers reach this; it was available from the entry's own ingredients.*

**And $1.5449$ is not $\sup\lvert P\rvert$.** It is the supremum of the **relaxation bound** $\lambda_{\max}p+B_5$. *[bounds.md](bounds.md) records this as a withdrawn framing error twice, a prior review D6 and a prior review D1 a third time, and [I31](../plan.md) states it a fourth; this entry was the fourth recurrence.* **The proved bound is [Lemma L143](bounds.md): $\sup\lvert P\rvert\le1+\sqrt{n-2}$, which is $4.162$ at $n=12$.**

> **WHAT THE LEMMA ACTUALLY SAYS, AND IT IS A CONDITION ON [I31](../plan.md) RATHER THAN A VERDICT ON IT.** The known bounds on $S$ are **upper** ones, and an upper bound can only show branch 1 **fails** to bind. So: *branch 1 does not bind wherever $S$'s upper bound falls below the threshold*, which covers $n=12$; and **branch 1 can bind only if $\sup\lvert P\rvert$ genuinely grows past an absolute constant.** Hence **if [I31](../plan.md) succeeds (if $\sup\lvert P\rvert$ is dimension-free and small), branch 1 never binds and branch 2 alone governs the radius at every $n$.** *That is the useful reading, and it is the opposite of the entry's first headline.*

> **THE REFORMULATION a prior review SUPPLIES, AND IT IS THE BEST FRAMING ANY PARTY REACHED.** $\beta$ and $\kappa$ are **not independent**, $\theta_0$ sits in both, since $S\ge\theta_0=\kappa(n-2)/(3n)$. Writing $S=s\,\theta_0(n)$, the criterion becomes
> $$\text{branch 1 binds}\iff s>3.1\text{–}3.6 .$$
> **Under [Conjecture A](../README.md) itself, $s=1$ and it never binds; under the proved upper bound, $s\le3.37$ at $n=12$, and it may.** *So the criterion measures the conjecture-to-proof gap rather than comparing absolute constants, which is what makes it worth having.*

**Three defects in the entry's own algebra, both reviewers.** *Branch 1 is not $(c_p+w^2)/S$*: the chain's own form is $f(u)=(c_p+u^2)/(S+au)$ with $f'(0)<0$ ([L147](../findings/second-order.md#lemma-l147-the-tube-radius-tracks-suplvert-prvert-on-betain0tfrac12-and-the-route-ends-at-thetan-1), [L157](../findings/second-order.md#lemma-l157-the-reach-parameter-is-determined-by-a-fixed-point-not-chosen-etatfrac2t1-sqrt4t12t)), so its infimum is **strictly below** $\kappa/(nS)$ and does not sit at $u=0$. *And $w^*=\kappa n^{-1/2}$ exceeds $1$ for every $n\le19$*, so under the entry's $A=n^{1/2}$ the interior minimum is unattained in most of the range; the repair is the record's $\lVert H_s\rVert_{op}\le1/\sqrt{m-1}$, giving $w^*=3\sqrt{n-1}/n=0.829$, **[L157](../findings/second-order.md#lemma-l157-the-reach-parameter-is-determined-by-a-fixed-point-not-chosen-etatfrac2t1-sqrt4t12t)'s own value, which this entry contradicted without noticing**, and the displayed minimum then overstates by $12\%$. *The prefactor $1.24$ is its $w=0$ value, the one direction [L148](../findings/second-order.md#lemma-l148-the-defect-vanishes-identically-on-the-margin-summand) empties; at the minimiser it is $1.1075$.*

**Why dropping branch 3 is legitimate, which the entry never said.** [L157](../findings/second-order.md#lemma-l157-the-reach-parameter-is-determined-by-a-fixed-point-not-chosen-etatfrac2t1-sqrt4t12t)'s $\eta^*$ has already merged it into the prefactor. *Notation: the $\kappa$ here is $nc_p$ and collides with the penalty constant $\kappa_n$ inside the same display; they are unrelated.*

> **SETTLED. GATE 2: a prior review AND a prior review, AGREEING.** *Tracing the chain: $\lVert A''\rVert\le2M/((1-\eta)\rho)^2$ with $M\le C\rho$ and $\rho=\gamma g_n/\lVert H\rVert_{op}$ gives $\lVert A''\rVert\le2J\lVert H\rVert_{op}\big/\big((1-\eta)^2g_n\big)$, so*
> $$\text{branch }2=\underbrace{\frac{\lambda(1-\eta^*)^2}{\sqrt2\,J}}_{K}\cdot\frac{\sqrt{c_p+\rho^{\text{eff}}_nw^2}}{n\min\big(a_0n^{-1/2}\sqrt{1-w^2}+w,\;1\big)}:\qquad\textbf{$J$ divides $K$.}$$
> **a prior review was right to carry [L156](../findings/second-order.md#lemma-l156-the-contour-constant-corrected-and-its-optimum-attained-at-the-equidistant-contour)'s $J^*$ and a prior review wrong to omit it**, though a prior review used $J^*=\tfrac{40}9$, L156's **out-of-scope $m=2$ endpoint**, where in scope $6.9421\le J^*<8$. *The doubt this entry raised against its own claim (that the $\gamma$ in $\rho$ might not be the $\gamma$ in $J^*$), **fails**: L156 names both in one hypothesis, and $J\gamma=C$ makes [L157](../findings/second-order.md#lemma-l157-the-reach-parameter-is-determined-by-a-fixed-point-not-chosen-etatfrac2t1-sqrt4t12t)'s $t=\lambda\sqrt{c_p+w^2}/(2C)$ exact rather than small-$t$.*

> **THE THRESHOLD IS PINNED AT $\approx17$–$19$ AT $n=12$, AND THE ENTRY'S "NOT PINNED" IS REFUTED.** *The spread between the two audits, $17$–$19$ against $52.92$, is one constant:* **$\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ was evaluated at the $n\to\infty$ value $\lvert\kappa_n\rvert=1.7053$, while the record prints $\lvert\kappa_{12}\rvert=0.10159$ in three places** ([L133](../findings/second-order.md#lemma-l133-the-balanced-orbit-stability-threshold-in-closed-form-and-it-clears-kappa_n-for-every-nge12), [L134](route-a.md), the [ledger](LEDGER.md)). *So $\lambda(12)=6.275$, not $1.53$, a factor $4.1$, and it is **the largest $n$-dependence in a ratio this entry's title calls $n$-free**, moving $2.3\times$ across the range against $\kappa$'s $5\%$.* **Using an asymptotic constant at a finite $n$ is the same class of error as the three vocabulary searches above.**

> **AND THE CONCLUSION IS FIRMER THAN EITHER SIDE FIRST HAD IT.** Against [L143](bounds.md)'s $S\le4.162$ and [L70](bounds.md)'s $S\le10$ at $n=12$, **branch 2 binds, and provably so at every $n$ up to $\approx1800$**. *This reverses a prior review's "branch 1 binds from $n\ge14$", which was also unsound in kind: an upper bound on $S$ cannot show branch 1 binds.* **So [I31](../plan.md)'s constant is not load-bearing in any dimension this programme reaches**, and in a prior review's $S=s\theta_0$ variable the threshold is $s^*\approx15$, not $3.1$–$3.6$.

**Four constants the entry had wrong, both reviewers agreeing.** $a_0=\sqrt{2n/(n-2)}=1.549$ at $n=12$ and is **$n$-dependent**, not $1$; the exact $1/g_n=n^2c_p/6$, the $\sqrt2$ limit being $4.9\%$ low **in the unsafe direction**; $\eta^*$ was read at $w=0$, the one direction [L148](../findings/second-order.md#lemma-l148-the-defect-vanishes-identically-on-the-margin-summand) empties of branch 2; and $\lVert H\rVert_{op}\le\min\big(\sqrt{2/(n-2)}+w,\,1\big)$ carries a kink the entry ignored. *a prior review adds that $M\le C\rho$ is sharp only at $\lVert H\rVert_{op}=1$ (the record's own bound is $M\le C\gamma g_n$, quadratic in $\lVert H\rVert_{op}$) which is inert at the binding direction but wrong as an identity.*

> **THE MINIMISER IS THE HOMOGENEITY KINK $w_0=\dfrac{n-4}n$, WHICH IS $\tfrac23$ AT $n=12$. GATE 2: a prior review AND a prior review, AGREEING.** *The premise holds*: $\lVert H\rVert_{op}\le\lVert H\rVert_F=1$ is legitimate, a prior review re-deriving [L146](../findings/second-order.md#lemma-l146-the-operator-norm-on-the-margin-summand-and-the-direction-blind-radius-it-corrects)'s normalisation from its own eigenvalue list and confirming $w\in[0,1]$ and $a_0n^{-1/2}=\sqrt{2/(n-2)}=1/\sqrt{m-1}$ as one quantity written two ways. **What was wrong is the envelope.** $H_s\perp H_r$ makes $\lVert H_s\rVert_F=\sqrt{1-w^2}$ an *identity* and [L146](../findings/second-order.md#lemma-l146-the-operator-norm-on-the-margin-summand-and-the-direction-blind-radius-it-corrects) is homogeneous, *[L149](../findings/second-order.md#lemma-l149-no-direction-is-both-low-margin-and-high-operator-norm-so-the-bound-is-uniform) says so in the very bullet that then drops it*, so the admissible envelope is
> $$\lVert H\rVert_{op}\le\min\Big(a_0n^{-1/2}\sqrt{1-w^2}+w,\ 1\Big),\qquad\text{crossing }1\text{ at }w_0=\frac{1-a_0^2/n}{1+a_0^2/n}=\frac{n-4}n,$$
> **never larger than the triangle form, and equal to exactly $1$ at $w=1$**, *so a prior review's $1.4472$ prices an $H_s$ that $\lVert H\rVert_F=1$ has already emptied, an objection more elementary than the $\min$ and needing none.*

> **THE $\mathbf{a prior review}$/$\mathbf{a prior review}$ DISPUTE IS SETTLED WITHOUT ARITHMETIC.** Rationalising [L157](../findings/second-order.md#lemma-l157-the-reach-parameter-is-determined-by-a-fixed-point-not-chosen-etatfrac2t1-sqrt4t12t)'s root to $1-\eta^*=2/(\sqrt{4t+1}+1)$ and writing $s=\sqrt{c_p+w^2}$, $t=\beta s$,
> $$\frac{\mathrm d\log\big(K(w)\sqrt{c_p+\rho^{\text{eff}}_nw^2}\big)}{\mathrm d\log s}=\frac1{\sqrt{4t+1}}\in(0,1)\quad\text{for every }\lambda,J,\gamma .$$
> **So $K$'s decrease can never overturn the rise above the kink**, a prior review's disputed point is refuted in general rather than at one dimension, and a prior review's shape is right.

**And this entry's own kink understated the minimum by $4.9\%$, the exact charge it laid against a prior review.** *At $n=12$ with $\lambda(12)=6.275$ the minimum was recorded as $0.40347$ at $w_0=\tfrac23$, against $0.38468$ at the entry's $0.5528$ and $a prior review$'s endpoint value; the improvement over the endpoint is $27.8\%$ at $\lambda(12)$ and $19.4\%$ at the asymptotic $\lambda$, never the $26\%$ claimed.* > **THE BRANCH-2 NUMERAL BELOW IS REFUTED AND OVERSTATED, AND IT IS A LOWER BOUND ON THE TUBE RADIUS.** *$t$ and this branch were evaluated with the coefficient $1$ on $w^2$ where [L149](../findings/second-order.md#lemma-l149-no-direction-is-both-low-margin-and-high-operator-norm-so-the-bound-is-uniform)'s repaired numerator carries $\rho^{\text{eff}}_n=2\sqrt{3/2}-\theta_0(n)\tfrac{n+16}{2(n-2)}$, which is $\sqrt6-\tfrac7{30}\sqrt{55}=0.7190434<1$ at $n=12$.* **So $0.40347$ is too large by exactly $1.04329$ at the binding $w_0=\tfrac23$, and the corrected minimum is $0.38673$.** *The factor is envelope-free, $n\min(\cdot)$ cancels from $F_1/F_\rho=\tfrac{N_1}{N_\rho}\big(\tfrac{s_\rho+1}{s_1+1}\big)^2$, and since the envelope alone fixes the minimiser, the ratio at $w_0$ is the ratio at the minimum. The $8.667\%$ is the inflation of $t$; the elasticity $1/s$ damps it to $4.33\%$ in the radius.* **The minimiser stays at $w_0=\tfrac{n-4}n$ under $\rho^{\text{eff}}_n$**, and the kink is a strict minimum across the whole of $[0,1]$: above $w_0$ the envelope is constant so the derivative is $+\tfrac1s\tfrac{N'}N>0$, below it the envelope's slope is $\phi'(w_0)=\tfrac35$ exactly against $\tfrac1s\tfrac{N'}N\le\tfrac{\sqrt\rho}{2\sqrt{c_p}\,s_{\min}}=0.4019$ uniformly, by AM–GM. *One proviso: [L149](../findings/second-order.md#lemma-l149-no-direction-is-both-low-margin-and-high-operator-norm-so-the-bound-is-uniform)'s open $\tfrac29$ debt moves the factor to $1.0391$ if it resolves the other way.*  *The defect is confined to $n\in\{12,14,16\}$, $\rho^{\text{eff}}_n$ is $0.7190$, $0.8724$, $0.9856$, then $1.0727$ at $n=18$, from which the coefficient $1$ is valid and merely loose.* **What survives untouched:** the order claims $r_n\gtrsim n^{-1-\beta}$ and the $\Omega(n^{-1})$ ceiling; [L149](../findings/second-order.md#lemma-l149-no-direction-is-both-low-margin-and-high-operator-norm-so-the-bound-is-uniform)'s own $g_\rho\ge0.71979/n$, whose proof already carries $\rho^{\text{eff}}_n$; and this entry's verdict that branch 2 binds, **which the repair strengthens**, since lowering branch 2 makes it bind more surely. *Adjudicated by two readers on identical briefs, [a prior round](../verification/a prior round.md) D6.*

**The figures $0.2793$ and $0.2209$ reproduce from no combination of the record's constants**, forcing them needs $\lambda=7.48$ and $7.21$, and no single constant yields both.

**$Bc/A=0.82916$ exactly, and it fails twice over.** It lies above **both** candidate kinks, and it minimises only the prefactor-free $g$, *so the value [L157](../findings/second-order.md#lemma-l157-the-reach-parameter-is-determined-by-a-fixed-point-not-chosen-etatfrac2t1-sqrt4t12t), a prior review and a prior review cite is unreachable and stationary for the wrong function.* *It is also not this entry's earlier attribution to [L149](../findings/second-order.md#lemma-l149-no-direction-is-both-low-margin-and-high-operator-norm-so-the-bound-is-uniform)'s literal $A=n^{1/2}$, which gives $1.2845$.*

> **TWO DEFECTS IN [L149](../findings/second-order.md#lemma-l149-no-direction-is-both-low-margin-and-high-operator-norm-so-the-bound-is-uniform) NEITHER PARTY RAISED, FROM a prior review.** *Its margin bound $c(H)\gtrsim c_p+w^2$ is **a lower bound stated upward**: the margin is a quadratic form, so on $\lVert H\rVert_F=1$ it is a convex combination, $c(H)\ge c_p+3\theta_0\tfrac{m-4}{2(m-1)}w^2$ with coefficient $0.74162$ at $n=12$ and $0.94626$ at $n=14$, reaching $1$ only at $n=16$.* **Repairing it strengthens the case for the homogeneity kink.** *And [L146](../findings/second-order.md#lemma-l146-the-operator-norm-on-the-margin-summand-and-the-direction-blind-radius-it-corrects) prices one $S^2_0$ copy where [L149](../findings/second-order.md#lemma-l149-no-direction-is-both-low-margin-and-high-operator-norm-so-the-bound-is-uniform) applies it to the joint two-copy eigenspace; no $\sqrt2$ is owed, the images being HS-orthogonal and the cross-plane branch reaching only $\sqrt{m-2}/m=0.333$ against $1/\sqrt{m-1}=0.447$, but the record should say so.*

**Branch 2 binds at $n=12$ under every envelope considered, so no reading makes [I31](../plan.md) load-bearing there.**

**THE DISAGREEMENT AS THE REVIEWERS LEFT IT.** The reviewers differ on the threshold's value, hence on where the crossover sits. a prior review puts it near $21$, carrying $A=3.980$ from $\lVert H_s\rVert_{op}=\sqrt{2/(n-2)}$, $B=1/g_n=0.74n$, and **[L156](../findings/second-order.md#lemma-l156-the-contour-constant-corrected-and-its-optimum-attained-at-the-equidistant-contour)'s $2J^*$ inside $\lVert A''\rVert$, which the entry dropped, but read at $\tfrac{40}9$, the $m=2$ endpoint L156's corollary places outside the programme's range, so the figure it used is $8.89$ where $n=12$ gives $2J^*=\tfrac{1680}{121}=13.884$, a factor $\tfrac{189}{121}$**, and concludes branch 1 cannot bind at $n=12$ since [Lemma L70](bounds.md) caps $S\le n-2=10$. a prior review puts it near $3.98$–$4.44$ against $S\le4.162$ and calls $n=12$ undecided. *The gap is whether $2J^*$ enters the branch-2 prefactor $K$, and settling it is the next task on this item.* **Both agree the entry's own threshold was wrong and that $\kappa\approx4.45$.**


### Form B

##### Lemma L158, the branch comparison is $n$-free, and $\sup\lvert P\rvert$ must grow before I31 can bind

In Lemma L149's parametrisation, branch 1 is increasing in $w$ with infimum $\kappa/(nS)$ and branch 2 has an infimum of order $n^{-1}$, *its stationary point $w^*=2\sqrt n/(n-8)$ lies outside $[0,1]$ for every $n<16$ and above the saturation kink besides, so the infimum is not the interior value $n^{-1}\sqrt{\kappa/(1+\kappa)}$, which stands only as a lower bound*, and the $n^{-1}$ cancels, so which branch binds is an inequality between absolute constants, $S$ against $\sqrt{\kappa(1+\kappa)}/K$. Here $\kappa=nc_p=3\sqrt{2(n-1)/(n-2)}\approx4.45$, fixed by the record's margin $c_p=3\theta_0/(n-2)$. Since the known bounds on $\sup\lvert P\rvert$ are upper ones and Lemma L143 gives $\sup\lvert P\rvert\le1+\sqrt{n-2}$, branch 2 binds at $n=12$ and branch 1 can bind only if $\sup\lvert P\rvert$ genuinely grows past an absolute constant, so if I31 succeeds in showing it dimension-free and small, branch 1 never binds and branch 2 alone governs the radius. The threshold's value is disputed between the two audits, $21$ against $3.98$, according to whether Lemma L156's $2J^*$ enters the branch-2 prefactor.

**Proof:** [findings/second-order.md](findings/second-order.md), Lemma L158. Gate 2: a prior review, a prior review, disagreeing on the threshold. The branch-2 infimum is corrected per a prior review, a prior review.
## Phase 1, returns

- **v40** · `GAP` · [VERIFY_v40.md](VERIFY_v40.md). Reproduced the threshold by hand as **$18.00$ at $n=12$** (a number, not the printed band $17$–$19$, which has no source in any named constant) and confirms branch 2 binds at $n=12$ ($S\le4.162$ against $18.00$), the corrected minimum strengthening it. **The extension to $n\approx1800$ has no argument on the page and does not reproduce**: $S^*(n)$ is bounded by $34.71$, so $1+\sqrt{n-2}$ overtakes it at $n\approx1135$.

### E1, the round's own numeral is mislabelled, and the round wrote it

**$0.38673$ is not branch 2.** v40 identifies it as $(1-\eta^*)^2\sqrt{c_p+\rho^{\text{eff}}w_0^2}$ to five digits (missing $\lambda/(\sqrt2J)$ and $1/n$) where branch 2 at $w_0$ is $0.0206$, smaller by a factor $18.8$. **The entry calls it "a lower bound on the tube radius" in bold, and that bold sentence is [ROUND_L157](ROUND_L157.md)'s, written by this loop.**

*The mismatch was visible before it was recorded.* The scratchpad derivation behind [6ce0c37f](../findings/second-order.md) computed branch 2 at $w_0$ as $0.0185$ and noted in as many words that it "is not near $0.40347$, normalisation unknown". **The ratio was then carried to Gate 2 and the base was not**, and neither reviewer could reproduce $0.40347$ either. *What passed Gate 2 is therefore exactly what Gate 2 was asked about: the factor $1.04329$. The absolute numeral inherits whatever $0.40347$ was, and $0.40347$ is not branch 2.*

**Held for v38 and v39.** One reader does not settle it, and the ratio is unaffected either way.

- **v38** · `GAP` · [VERIFY_v38.md](VERIFY_v38.md). Reproduces the threshold independently as $S^*=17.257$ at $\rho=1$ and $\mathbf{18.003}$ at $\rho^{\text{eff}}_{12}$, agreeing with v40's $18.00$. **It refutes the extension outright**: carrying every constant to $n=1800$ gives $S^*=34.688$ against $1+\sqrt{1798}=43.403$, so $\approx1800$ is the $\rho=1$ answer and the corrected stopping dimension is $\approx1140$. *Downstream [plan.md](../plan.md):116 survives, $1140$ being far above every dimension the programme evaluates.*

### E2, a verifier disagreement, settled here by derivation

**v38 reports $\phi'(w_0)=\tfrac35$ as not reproduced**, giving $1-\tfrac{n-4}{\sqrt2(n-2)^{3/2}}=0.8211$ instead and diagnosing a slip of $1-w_0$ for $\sqrt{1-w_0^2}$. **v40 confirms $\tfrac35$ exactly, and the round's own derivation gives $\tfrac35$.** With $\phi(w)=a_0n^{-1/2}\sqrt{1-w^2}+w$,

$$\phi'(w)=1-\frac{a_0}{\sqrt n}\cdot\frac{w}{\sqrt{1-w^2}},\qquad \phi'(\tfrac23)=1-\frac1{\sqrt5}\cdot\frac{2/3}{\sqrt5/3}=1-\frac25=\frac35 .$$

**v38's own diagnosis does not produce v38's own number**, substituting $1-w_0=\tfrac13$ for $\sqrt{1-w_0^2}=\tfrac{\sqrt5}3$ gives $0.106$, not $0.821$, so the candidate fails the discrepancy protocol's second step and is `withdrawn`. *$\tfrac35$ stands, and the AM–GM argument resting on it is unaffected.*

### E3, a direction claim that may cut both ways, unadjudicated

[ROUND_L157](ROUND_L157.md) recorded, on v36 and v37, that from $n=18$ the coefficient $1$ is *"valid and merely loose"*. **v38 says the opposite for a binding claim**: $\rho^{\text{eff}}_n$ exceeds $1$ from $n=18$ and rises to $1.74238$, so coefficient $1$ **understates** branch 2 there, loose for a radius lower bound, unsafe for a claim that branch 2 binds. *Both may hold, of different claims. The round does not assume so.*

- **v39** · `HYPOTHESIS-DEBT` · [VERIFY_v39.md](VERIFY_v39.md). Derives the threshold in closed form, $T=\tfrac{\kappa\sqrt2J}{\lambda(1-\eta^*)^2s_\rho(w_0)}$, giving $17.26$ at $\rho=1$ and $\mathbf{18.00}$ at $\rho^{\text{eff}}$, the third independent route to the same number. **And it identifies what the printed band is**: recomputing with $J\to8$, the $m\to\infty$ endpoint, gives $19.1$–$19.9$, so *"$17$–$19$" is $J^*$ read asymptotically, the same error the entry charges against $\lambda$ four lines earlier.*

## Phase 2, the clustering

| id | step attacked | mechanism | support |
|---|---|---|---|
| **E1** | $0.40347$ and $0.38673$ | neither is branch 2; both are $(1-\eta^*)^2\sqrt{c_p+\rho w^2}$, missing $\lambda/(\sqrt2J)$ and $1/n$ | v39, v40 |
| **E3** | the threshold display | it is a number, $18.00$; the printed band $17$–$19$ is undderived and is $J^*$ read at its $m\to\infty$ endpoint | v38, v39, v40 |
| **E4** | the extension to $n\approx1800$ | no argument on the page; it reconstructs only at $\rho=1$, and the corrected stopping dimension is $\approx1140$ | v38, v39, v40 |
| **E5** | the title's "$n$-free" | refuted by the entry's own body; $S^*$ runs over $[5.70,34.71]$ and $\lambda(12)/\lambda(\infty)=4.10$ | v38, v39, v40 |
| **E6** | [results.md](../results.md) against the findings text | Form B is pre-correction: it calls the threshold still disputed, and **downstream reads Form B** | v38, v39, v40 |
| **E7** | the statement | $n\ge12$ even, $m\ge6$, $\lVert H\rVert_F=1$, $H\perp W^*$, $\ker W^*=0$ all used, none stated | v38, v39, v40 |
| **E8** | the round's own AM–GM minimiser proof | its sufficient condition $0.4019<\tfrac35$ is $n$-local: $\tfrac1{2\sqrt{c_p}}\sim0.243\sqrt n$ grows while $\phi'(w_0)\downarrow\tfrac12$ | v39 |
| **E9** | "$0.38468$ at $0.5528$" | it omits the envelope $\phi(0.5528)=0.9255$; restored, the $4.9\%$ understatement reverses | v39 |
| **E10** | "$27.8\%$ and $19.4\%$" | refuted in closed form, the entry's own elasticity forces the improvement to *decrease* in $\lambda$ | v39 |

**E2 was v38's $\phi'(w_0)$ candidate and is `withdrawn`**, settled above by derivation.

**E10 is a repeat.** [ROUND_L157](ROUND_L157.md)'s block records that a prior review had already refuted these two figures as unreproducible. **They are still on the page.** *That is the block's standing pattern in its purest form: a defect found, recorded, and never removed from the text that carries it.*

## Phase 3, E9 and E10 adjudicated

- **v42** · **E9 `WITHDRAWN`, E10 `WITHDRAWN`** · [VERIFY_v42.md](VERIFY_v42.md).

**The finding that decides both is an omission, not an error.** *The entry never prints $C$.* Reading it off [L156](../findings/second-order.md) ($J=C/\gamma$ minimised at $\alpha=d=D/2$), gives $C=\tfrac{4+2D}D=\tfrac{42}{11}$ at $n=12$ and $\beta=\lambda/(2C)=\tfrac{11\lambda}{84}$; the same substitution returns the entry's printed $J^*=6.9421$, which confirms the reading. **With that one constant all four numerals reproduce to five digits**, $0.403465$, $0.384677$, $0.386740$, $1.1076$.

**E9.** The candidate's *fact* is right, $\phi(1-1/\sqrt5)=0.9254594<1$, and its *inference* is not. $0.38468$ and $0.40347$ are two minima of two functions, each attained at its own envelope's kink where that envelope equals $1$; nothing is divided out of either. $\psi\ge\phi$ pointwise forces the direction by inequality rather than arithmetic, and the size is $4.88\%$. *E9's one true residue supports the entry*: $F_1(0.5528)/\phi(0.5528)$ is $3.02\%$ worse than $w_0$.

**E10.** The elasticity derivation is sound and **applied to the wrong functional.** "The endpoint" is r714's endpoint value, computed with $\psi(1)=1+1/\sqrt5=1.4472$, so the entry's figure is $\psi(1)/R(\lambda)-1$, which *increases* in $\lambda$, giving $27.82\%$ at $\lambda(12)$ and $19.40\%$ at $\lambda_\infty$. **Right sign.** The candidate's $13.2\%$ and $21.2\%$ are $R-1$, a different comparison.

### The tension this creates with E1, which the round has already acted on

**E1 was repaired in [5cbebbb5](../findings/second-order.md) on v39 and v40, who agreed that $0.40347$ and $0.38673$ are $(1-\eta^*)^2\sqrt{c_p+\rho w^2}$ and therefore not branch 2. v42 reproduces both numerals exactly and calls them correct as printed.** *These are compatible in principle (a number can be the correct value of a functional that is not branch 2) and they are not obviously compatible in fact.* **v42 did not have E1 in its brief**, so its remark about "three erroneous findings" reaches beyond what it adjudicated and is not counted here.

**Held for v41.** If v41 also reproduces the numerals, E1's relabelling is re-opened and the round must say which functional $0.38673$ is.

- **v41** · **E9 `UPHELD IN PART`, E10 `WITHDRAWN`** · [VERIFY_v41.md](VERIFY_v41.md). **It resolves the E1 tension rather than deepening it.** Reproducing $G(w)=(1-\eta^*)^2\sqrt{c_p+\rho w^2}=\tfrac{4s}{(q+1)^2}$ by hand, it gets $G(\tfrac23)=0.403463$, $G(0.5528)=0.384671$, $G_{\rho^{\text{eff}}}(\tfrac23)=0.386721$ and the ratio $1.043293$, **so both entry numerals are $G$, exactly as v39 and v40 said, and exactly the values v42 called correct.** *E1 was about the label and v42's reproduction was about the value; they were never in conflict.*

**E9's split is a split in wording, not in fact.** v41 and v42 agree that $\phi(0.5528)=1-\tfrac{\sqrt5-\sqrt{2\sqrt5-1}}5=0.9254598$, that $F(0.5528)=0.41565$ exceeds $F(w_0)$ by $3.02\%$, and that **the reversal fails**. One called the surviving residue "upheld in part" and the other "the candidate's one true residue"; the round records the mathematics rather than the labels.

**E10 `WITHDRAWN`, unanimous.** $1.4472=1+\sqrt{2/(n-2)}$ is r714's refuted envelope at $w=1$, so the entry's quantity is $\psi(1)G(w_0)/G(1)-1$, which **increases** in $\lambda$, the candidate's own elasticity gives the entry's sign. *The earlier "unreproducible" report repeated a mistake, which is why the brief warned that a repeat is not a corroboration.*

## Phase 5, the round's verdict

**`GAP`, repaired. Impact: `CONTAINED`.**

Both conclusions survive: the minimiser at $w_0=(n-4)/n$, and branch 2 binding at $n=12$ with a factor-$4$ margin. What failed was the entry's account of itself, an undderived band where a number belongs, an extension with no argument, a title its own body refutes, five unstated hypotheses, and a canonical copy still carrying a dispute the findings text had settled.

### The finding worth carrying forward

**Three false findings came from one missing line.** The entry never printed $C$, so every reader reconstructed $\beta=\lambda/(2C)$ for themselves; three failed and filed defects against figures that were exact. *The cost was five agents.* **A constant that every numeral depends on and no line states is not an omission of style**, it is the difference between a checkable entry and one that must be re-derived from a neighbour before it can be read at all.

**The block's other pattern held again.** [results.md](../results.md) carried pre-correction text, the threshold "disputed at $21$ against $3.98$", after the findings file had settled it, and **downstream reads that copy**. That is the fourth round in a row to find a correction that stopped at one file.
