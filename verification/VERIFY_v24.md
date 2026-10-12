# VERIFY v24, L147: the tube radius $r_n\gtrsim n^{-1-\beta}$ on $\beta\in[0,\tfrac12]$, and the $\Theta(n^{-1})$ ceiling

*Verifier v24, [ROUND_L147](ROUND_L147.md), 2026-09-05. Worked cold from the brief in [ROUND_L147](ROUND_L147.md) and from the definitions in [conventions.md](../findings/conventions.md), [Lemma L27](../findings/nondegeneracy.md), [Lemma L143](../findings/bounds.md) and [Lemma L153](../findings/bounds.md). **No numerical work: no script was run, and every value below is an exact hand evaluation, given as a closed form wherever a closed form exists.** Log: [agent_logs/verify-L147-v24.log](../agent_logs/verify-L147-v24.log). No other verifier's report was read.*

## Claim table

| # | claim, as the entry writes it | verdict |
|---|---|---|
| C1 | $f(u)=(c_p+u^2)/(S+au)$ has $f'(0)=-ac_p/S^2<0$ | **CONFIRMED for $a>0$; FALSE at $a=0$** |
| C2 | $u^*=(\sqrt{S^2+a^2c_p}-S)/a$, $f(u^*)=2u^*/a=\Theta(\min(c_p/S,\sqrt{c_p}/a))$ | **CONFIRMED**, rebuilt from the stationarity relation |
| C3 | "$u=0$ is **never** its minimum … at every $\beta$ and every $a$" | **REFUTED AS STATED.** $a=0$ holds on a whole summand by [Lemma L148](../findings/second-order.md), and there the minimum *is* $u=0$ |
| C4 | the variable $u$ | **UNDEFINED IN THE ENTRY**, and used in two different senses four lines apart |
| C5 | "the cubic branch always shadows the quartic" | **CONFIRMED at order**, with the constant $2$: $f(u^*)\le2\sqrt{c_p}/a$ |
| C6 | $M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert=O(\rho)$ because $x\mapsto x_-$ is $1$-Lipschitz in Frobenius norm | **GAP.** The cited fact is a theorem about **Hermitian** matrices; it is applied on a **complex circle** where $W(z)_-$ is a Riesz-projector image and no metric projection exists |
| C7 | $\lVert A''\rVert=O(M/\rho^2)=O(1/\rho)=O(n^{1/2})$ on the margin summand | **CONFIRMED as Cauchy arithmetic, VACUOUS at its own object**, $A\equiv0$ there by [Lemma L148](../findings/second-order.md) |
| C8 | "the chain's $\lVert A''\rVert$ ranges over all **ten** of [Lemma L27](../findings/nondegeneracy.md)'s" | **REFUTED.** Eight: $\langle W\rangle$ and the orbit summand are removed by the domain's own two constraints |
| C9 | the sweep, $\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w$ and $c(H)\gtrsim c_p+w^2$, "uniformly in $w\in[0,1]$" | **ASSERTED, NOT DERIVED**; $w$ undefined, and the singular reading the entry's own words carry is false at a named witness |
| C10 | "a single mixed direction with $u\asymp n^{-1/2}$, margin $\Theta(1/n)$ and $\lVert A''\rVert=\Theta(n)$ restores $n^{-3/2}$" | **NO SUCH DIRECTION EXISTS** under the entry's own next sentence; the entry never says so |
| C11 | $\beta\ge0$ from $\sup\lvert P\rvert\ge P(W^*)=\theta_0(n)\uparrow\sqrt2$ | **CONFIRMED at even $n$**, which is the only parity the setting has; endpoint **not forced** |
| C12 | $\beta\le\tfrac12$ from [Lemma L143](../findings/bounds.md) | **CONFIRMED**; endpoint **not forced** |
| C13 | the $\Theta(n^{-1})$ ceiling | **PROVED, by reason (a) alone**: $c_p/S\le c_p/\theta_0=3/(n-2)$ exactly. Reason (b) is unproven and false at $w=0$; (c) and (d) hold |
| C14 | $r_n\gtrsim n^{-1-\beta}$ | **NOT PROVED IN THE ENTRY.** The chain is never displayed, the branches are never derived, and the joint minimisation over $w$ is absent |
| C15 | the statement's hypotheses | **FOUR UNSTATED**: the base point $W^*=S^m\times S^m$, $n$ even, $n\ge12$, and $\ker W^*=0$ |
| C16 | "$\beta=0$ … is **plausible** with an unpinned constant" | **NOT A PROVED CLAIM.** A hedge word inside the boxed lemma |

**One line the round can act on.** The **ceiling is proved and the pre-registered question is settled**, $f$'s minimum is interior at $u^*=ac_p/(S+\sqrt{S^2+a^2c_p})$ whenever $a>0$, $u$ is the **defect weight** and not [Lemma L149](../findings/second-order.md)'s $w$, and the two readings differ by a bounded factor so **neither headline moves**, but the radius half has **no derivation inside L147**, which carries no base point, no parity, no dimension range and no $\ker W^*=0$.

## 0. Conventions, fixed once

- $W^*=S^m\times S^m$, $n=2m$, the balanced product. $\theta_0(n)^2=2(n-1)(n-2)/n^2$, so $\theta_0(12)=\sqrt{55}/6$ and $\theta_0\uparrow\sqrt2$ strictly from below.
- $g_n=\lvert\lambda_-(W^*)\rvert=\sqrt{2(n-2)}\big/\big(n\sqrt{n-1}\big)=\Theta(1/n)$, the spectral gap at $0$ ([Lemma L145](../findings/second-order.md)).
- $L_e$ acts as a scalar on each of [Lemma L27](../findings/nondegeneracy.md)'s ten summands. The margin of a summand carrying eigenvalue $\lambda$ is $3\theta_0(\tfrac12-\lambda)$. At $p=q=m$: $\lambda_m=\tfrac{m-2}{2(m-1)}$ on each of the **two** $S^2_0(\mathbb R^m)$ copies, $\mu=\tfrac1{m-1}$ on $\Lambda^2\!\otimes\!\Lambda^2$, $-\mu$ on $S^2_0\!\otimes\!S^2_0$, $1$ on $\langle W\rangle$, $\tfrac12$ on the orbit summand $\mathbb R^m\!\otimes\!\mathbb R^m$, and $0$ on the four remaining.
- $c_p:=3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)$, the smallest surviving margin. $\kappa:=nc_p=3\sqrt{2(n-1)/(n-2)}$, so $c_p(12)=\sqrt{55}/20$ and $\kappa(12)=3\sqrt{55}/5$.
- $S:=\sup\lvert P\rvert$; $a:=\lVert A''\rVert$; $A(z)=\mathrm{Alt}\big(W(z)_-\big)$ along $W(z)=W^*+zH$, $A(0)=0$; $\rho$ the complex analyticity radius, $\rho=\gamma g_n/\lVert H\rVert_{op}$; $H$ ranges over $T_{W^*}S\cap T_{W^*}\mathcal O^\perp$.
- **Every one of these except $S$ is used by L147 and defined nowhere in it.** They are reconstructed above from [Lemma L145](../findings/second-order.md), [Lemma L146](../findings/second-order.md), [Lemma L149](../findings/second-order.md) and [Lemma L27](../findings/nondegeneracy.md).

## 1. Hypothesis inventory

### 1.1 Hypotheses the statement carries

| carried | used? |
|---|---|
| $\sup\lvert P\rvert=\Theta(n^\beta)$ | **used**, in the final display and in the ceiling's reason (a) |
| $\beta\in[0,\tfrac12]$ | **used** for the ceiling's reason (d); the upper endpoint is used nowhere else |

That is the whole of it. The statement names no manifold, no base point, no dimension, no parity, and no non-degeneracy condition.

### 1.2 Hypotheses the entry uses and does not state

| unstated hypothesis | where it is needed | does it hold at the object? |
|---|---|---|
| the base point is $W^*=S^m\times S^m$ | $c_p$, $g_n$, the ten summands, [Lemma L146](../findings/second-order.md), [Lemma L148](../findings/second-order.md) | holds only there, §5 |
| $n=2m$, i.e. $n$ **even** | $P(W^*)=\theta_0(n)$ is the balanced value **at even $n$ only** ([conventions.md](../findings/conventions.md)); $p=q=m$ gives the two equal-eigenvalue $S^2_0$ copies | at odd $n$ the balanced split gives $\Theta_n<\theta_0(n)$ |
| $m\ge4$, i.e. $n\ge8$ | [Lemma L27](../findings/nondegeneracy.md)'s hypothesis is $p,q\ge3$ with $(p,q)\ne(3,3)$ | fails at $n=6$ |
| $m\ge5$ | $\lambda_m>\mu$, which is what puts the margin on the $S^2_0$ summands: $\lambda_m>\mu\iff m>4$ | fails at $m\le4$ |
| $m\ge6$, i.e. $n\ge12$ | the sweep's $w^2$ coefficient $c_{\min}-c_p=3\theta_0\tfrac{m-4}{2(m-1)}$ is **zero at $m=4$** and negative at $m=3$; and $\rho^{\mathrm{eff}}$ has no definition at $n=10$ ([Lemma L149](../findings/second-order.md)) | fails at $n\le10$ |
| $\ker W^*=0$ | $W\mapsto W_-$ analytic at $W^*$; without it $A$, $\rho$, $M$, $\lVert A''\rVert$ and branches 2 and 3 have **no domain** | holds at $W^*$; §5 exhibits a named critical point where it fails |
| $H\perp W^*$ and $H\perp T_{W^*}\mathcal O$ | removes the $\lambda=1$ and $\lambda=\tfrac12$ summands, whose margins are $-\tfrac32\theta_0$ and $0$ | supplied by the domain, which the entry never names |
| $a=\lVert A''\rVert>0$ | C1 and C3, §3 | **fails on the $S^2_0$ summands** by [Lemma L148](../findings/second-order.md) |
| a $\beta$ exists at all | the statement is otherwise vacuous | unknown; $\sup\lvert P\rvert$ is bracketed, never shown to be $\Theta(n^\beta)$ for any $\beta$ |

### 1.3 Hypotheses of imported results, checked against the object

| import | its hypotheses | checked here |
|---|---|---|
| [Lemma L143](../findings/bounds.md), $\sup\lvert P\rvert\le1+\sqrt{n-2}$ | $P$ odd, sphere compact, $\nabla P=3Q$, $\theta\le\lambda_{\max}p+B_5$ at critical points, [Lemma L31](../findings/stratum-two-negative.md)'s pair cap, [Lemma L153](../findings/bounds.md)'s Killing row mass | all satisfied; L153's mathematics was rebuilt cold twice at its own round, and the proof re-read here as $B_5\le\tfrac12\sqrt{4(n-2)}=\sqrt{n-2}$. **Import clean.** |
| [Lemma L27](../findings/nondegeneracy.md), the ten-summand decomposition | $p,q\ge3$, $(p,q)\ne(3,3)$ | satisfied for $m\ge4$; L147 states no such range, and miscounts the summands the domain meets (§4) |
| [Lemma L146](../findings/second-order.md), $\lVert H\rVert_{op}\le\tfrac m{2(m-1)}\max_{a\ne a'}\lvert h_a+h_{a'}\rvert$, $\sup=1/\sqrt{m-1}$ | $H$ the Weyl image of a **single** $h\in S^2_0(\mathbb R^m)$, $\lVert H\rVert_F=1$, $n=2m$, $m\ge3$; order conclusion at $m\ge5$ | **L147 applies it to the joint two-copy eigenspace**, outside the stated hypothesis. It is safe, L146's own box says the cross-plane branch caps at $\sqrt{m-2}/m$, and $(m-1)(m-2)<m^2$ for every $m$, so $\sqrt{m-2}/m<1/\sqrt{m-1}$, but L147 nowhere says the licence is needed or where it comes from |
| the three-branch chain $r(H)\gtrsim\min(b_1,b_2,b_3)$ | none stated anywhere | **the chain is in no findings entry that precedes L147.** It is first displayed at [Lemma L149](../findings/second-order.md), two entries later. §6 |

## 2. The pre-registered question, settled

### 2.1 Where $f$ is minimised

Take $c_p>0$, $S>0$, $a\ge0$, $u\ge0$, $f(u)=(c_p+u^2)/(S+au)$. Then

$$f'(u)=\frac{2u(S+au)-a(c_p+u^2)}{(S+au)^2},\qquad \text{numerator}=au^2+2Su-ac_p .$$

The numerator is a quadratic in $u$ with positive leading coefficient (when $a>0$), value $-ac_p<0$ at $u=0$, and one nonnegative root. So $f$ falls then rises and its unconstrained minimiser is the interior point

$$u^*=\frac{\sqrt{S^2+a^2c_p}-S}{a}=\frac{ac_p}{S+\sqrt{S^2+a^2c_p}},$$

the second form by rationalising, and from the stationarity relation $a(c_p+u^{*2})=2u^*(S+au^*)$,

$$f(u^*)=\frac{2u^*}{a}=\frac{2c_p}{S+\sqrt{S^2+a^2c_p}} .$$

**C1 and C2 confirmed.** The order claim follows exactly: $\max(S,a\sqrt{c_p})\le S+\sqrt{S^2+a^2c_p}\le2S+a\sqrt{c_p}\le3\max(S,a\sqrt{c_p})$, whence

$$\tfrac23\,\frac{c_p}{\max(S,a\sqrt{c_p})}\;\le\;f(u^*)\;\le\;\frac{2c_p}{\max(S,a\sqrt{c_p})},\qquad \frac{c_p}{\max(S,a\sqrt{c_p})}=\min\Big(\frac{c_p}S,\frac{\sqrt{c_p}}a\Big),$$

so $f(u^*)=\Theta(\min(c_p/S,\sqrt{c_p}/a))$ with absolute constants $\tfrac23$ and $2$. **C2 confirmed, C5 confirmed with the constant $2$**, $f(u^*)\le2\sqrt{c_p}/a$ is the "always shadows the quartic" clause, and it is an inequality with a constant, not a strict domination.

**Where it fails.** At $a=0$ the numerator of $f'$ is $2Su\ge0$, $f'(0)=0$, and $f$ is minimised **at $u=0$** with value $c_p/S$. The entry's "at every $\beta$ and **every $a$**" therefore has a false instance, and it is not a corner case: [Lemma L148](../findings/second-order.md) puts $A\equiv0$, hence $a=0$, on **both** $S^2_0(\mathbb R^m)$ summands, a subspace of dimension $2\cdot\tfrac{(m-1)(m+2)}2=\Theta(n^2)$, and the very subspace on which $c_p$ is attained. **C3 refuted as stated.**

*Charitable reading, and it is the right one:* $a=\lVert A''\rVert$ and the sentence begins "$f'(0)=-ac_p/S^2<0$", which presupposes $a>0$. Read with that hypothesis the clause is exactly true. **The finding is that the hypothesis is unstated and that the record's own next lemma supplies its failure.**

**The domain is also absent.** $f$ is minimised over $u$ with no range given. If the admissible $u$ is capped below $u^*$ the minimum sits at the cap. The direction is harmless ($f(u^*)$ is the global infimum and so a valid lower bound whatever the range) but the *attainment* claim needs a range, and the one on file elsewhere does not deliver it at the dimensions that matter: $u^*\le\sqrt{c_p}$ holds always, while $\sqrt{c_p}\le\tfrac12$ needs $c_p\le\tfrac14$, i.e. $12\theta_0\le n-2$, which **fails at $n=12,14,16$**, at $n=12$, $c_p=\sqrt{55}/20=0.37081>\tfrac14$ exactly, since $\sqrt{55}>5$.

### 2.2 What $u$ is

**It is not defined in L147, and L147 uses it in two senses four lines apart.**

- In the quantifier-error box it indexes a direction: "*a single mixed direction with $u\asymp n^{-1/2}$*".
- In the two-branches paragraph it is the variable of $f$.

Reconstructed from the record: $u$ is the **defect weight** (the linear part $\lVert A'(0)\rVert$ of $\mathrm{Alt}(W(t)_-)$ along the segment) while $w:=\lVert H_r\rVert$ is the Frobenius weight of $H$ outside the joint $\lambda_m$-eigenspace. [Lemma L149](../findings/second-order.md) states the only relation on file: *"Since $A'(0)$ is linear and vanishes on the margin subspace by [Lemma L148](../findings/second-order.md), $u\le w$."* **So $u\ne w$: the pre-registered question's premise is correct.**

**And the two displays are two relaxations of one object, which is why neither headline moves.** The true branch 1 is $c(H)\big/(S+a\,u(H))$ with $c(H)\ge c_p+(c_{\min}-c_p)w^2$ and $u(H)\le w$.

- [Lemma L149](../findings/second-order.md) writes $(c_p+w^2)/S$: it **drops** $au$ from the denominator, which raises the expression, so it is **not** a valid lower bound.
- L147 writes $(c_p+u^2)/(S+au)$: it puts $u\le w$ into the numerator, which lowers it, and keeps $au$ in the denominator. **This is the valid lower bound of the two.**

Their infima bracket each other within a bounded factor. From §2.1, $c_p/(S+a\sqrt{c_p})\le f(u^*)\le c_p/S$, and at $\beta=0$ with $a=O(n^{1/2})$ on the low-$w$ directions, $a\sqrt{c_p}=O(n^{1/2}\cdot n^{-1/2})=O(1)=O(S)$, so the two differ by a **constant**, never an order. **The three rounds spent on this disagreement were spent on a constant.** Both forms return $\Theta(n^{-1-\beta})$ for branch 1's infimum, and the headline is indifferent to the choice.

## 3. The $M=O(\rho)$ substitution, the reason does not reach the object

**Located.** The first box: *"$M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert$ is a supremum **over the disc**, so it grows with it: $x\mapsto x_-$ is $1$-Lipschitz in Frobenius norm and $\lVert\mathrm{Alt}\rVert\le1$, giving $M=O(\rho)$."*

**The failure, exhibited.** $x\mapsto x_-$ is $1$-Lipschitz in the Frobenius norm because, on **Hermitian** matrices, $x_+$ is the metric projection onto the positive-semidefinite cone in the Frobenius inner product, and metric projection onto a convex set is non-expansive. The subscript $\lvert z\rvert=\rho$ is a **circle in $\mathbb C$**: at $z$ off the real axis $W(z)=W^*+zH$ is complex symmetric and **not Hermitian**, the PSD cone is not a convex subset of the space it lives in, and $W(z)_-$ is the image of a **Riesz projector** $\tfrac1{2\pi i}\oint_\Gamma\zeta(\zeta-W(z))^{-1}\,d\zeta$, which is oblique rather than orthogonal. The stated fact is a theorem about a different class of matrices from the one it is applied to, and the entry supplies nothing bridging them. A Riesz projector is not non-expansive in general: its norm is governed by the spectral gap, which is precisely why the chain carries $g_n$ and a radius $\rho<g_n/\lVert H\rVert_{op}$ at all, if $x\mapsto x_-$ were $1$-Lipschitz on the disc, no gap would be needed.

**The opposite, argued.** The **conclusion** $M=O(\rho)$ is supported elsewhere, by a contour estimate rather than by Lipschitz continuity: [Lemma L158](../findings/second-order.md)'s settled box records *"$M\le C\rho$ … the record's own bound is $M\le C\gamma g_n$, quadratic in $\lVert H\rVert_{op}$"*, and with $\rho=\gamma g_n/\lVert H\rVert_{op}$ that gives $M\le C\rho\lVert H\rVert_{op}\le C\rho$. So the substitution's arithmetic survives; **what fails is the reason L147 gives for it**, and the reason is the entry's headline sentence.

**Verdict on C6: GAP.** What is owed: either the contour bound at the point of use, or a proof that the negative-spectral-part map is non-expansive on the complex disc, the second being the stronger claim and one the record's own reliance on $g_n$ argues against.

**C7.** Granting $M\le\rho$, the Cauchy estimate $\lVert A''(0)\rVert\le2M/\rho^2$ gives $O(1/\rho)$, and on the margin summand $\lVert H\rVert_{op}=O(n^{-1/2})$ with $g_n=\Theta(1/n)$ gives $\rho=\Omega(n^{-1/2})$, so $O(n^{1/2})$. **The arithmetic is right.** It is nonetheless **vacuous at its own object**: [Lemma L148](../findings/second-order.md) makes $A\equiv0$ on the margin summand, so $\lVert A''\rVert=0$ there and the bound prices a quantity that is not present. The entry's headline correction is a correction to a number that is zero.

## 4. The quantifier box, and what "the sweep" leaves owed

### 4.1 "all ten of Lemma L27's", refuted, exactly

The domain is $T_{W^*}S\cap T_{W^*}\mathcal O^\perp$, i.e. $H\perp W^*$ and $H\perp T_{W^*}\mathcal O$. [Lemma L27](../findings/nondegeneracy.md)'s ten summands include $\langle W\rangle$, carrying $L_e$-eigenvalue $1$ and margin $3\theta_0(\tfrac12-1)=-\tfrac32\theta_0<0$, and the orbit summand $\mathbb R^m\otimes\mathbb R^m$, carrying $\tfrac12$ and margin $0$. **Both are removed by the domain's own two constraints**, [Lemma L27](../findings/nondegeneracy.md) proves $E(\tfrac12)$ *equals* the orbit tangent, so the removal is exact, not approximate. $\lVert A''\rVert$ ranges over **eight** summands, not ten. This matters beyond bookkeeping: if the count were ten the margin's convex-combination floor would be $-\tfrac32\theta_0$ and negative, and the sweep would have no positive coefficient at all.

### 4.2 The margin bound, checked exactly

The margin is a quadratic form, so on $\lVert H\rVert_F=1$ it is a convex combination of the eight surviving summand margins, and its coefficient is the smallest of them. Among the survivors the largest $L_e$-eigenvalue is $\max(\lambda_m,\mu,0)$, and

$$\lambda_m=\frac{m-2}{2(m-1)},\qquad \mu=\frac1{m-1},\qquad \lambda_m>\mu\iff m>4 .$$

So for $m\ge5$ the smallest margin is $c_p=3\theta_0/(n-2)$ on the two $S^2_0$ copies, the next smallest is $c_{\min}=3\theta_0\tfrac{m-3}{2(m-1)}$ on $\Lambda^2\!\otimes\!\Lambda^2$, and

$$c(H)\;\ge\;c_p(1-w^2)+c_{\min}w^2\;=\;c_p+\big(c_{\min}-c_p\big)w^2,\qquad c_{\min}-c_p=3\theta_0\frac{m-4}{2(m-1)} .$$

Exact values: $3\theta_0\tfrac{m-4}{2(m-1)}$ is $\tfrac{\sqrt{55}}{10}=0.741620$ at $n=12$, $\tfrac{3\sqrt{78}}{28}=0.946260$ at $n=14$, and exceeds $1$ first at $n=16$. It is **exactly zero at $m=4$** and **negative at $m=3$**.

**So L147's "$c(H)\gtrsim c_p+w^2$" is:** correct as an order statement for $m\ge5$ with constant $0.7416$ at $n=12$; **false with constant $1$** at $n=12$ and $n=14$; and **false outright** for $m\le4$, where the coefficient is not positive. The entry states it "uniformly in $w\in[0,1]$" and gives no dimension range.

### 4.3 $w$ is undefined, and the reading the entry's own words carry is false at a named object

The entry writes *"[Lemma L146](../findings/second-order.md) bounds **one summand**"* and then, two clauses later, *"$\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w$ … and $c(H)\gtrsim c_p+w^2$"* without saying what $w$ is.

**Exhibited, in closed form.** Read $w$ as the weight outside **one** $S^2_0(\mathbb R^m)$ copy, the reading "one summand" supports. Take $H$ a unit vector in the **second** copy. Both copies carry $L_e$-eigenvalue $\lambda_m$ ([Lemma L27](../findings/nondegeneracy.md); the factor swap fixes $W^*$ and commutes with $L_e$), so $c(H)=c_p=3\theta_0/(n-2)=\Theta(1/n)$ exactly, while $w=1$. The sweep asserts $c(H)\gtrsim c_p+1=\Theta(1)$. **Wrong by a factor $n$, on a subspace of dimension $\tfrac{(m-1)(m+2)}2=\Theta(n^2)$.**

**The opposite, argued.** The same sentence also says *"since $L_e$ is scalar on **each summand**"*, which points at the correct reading, $w$ the weight outside the **joint** two-copy $\lambda_m$-eigenspace. Under that reading the witness has $w=0$ and there is no failure. [Lemma L149](../findings/second-order.md) later records exactly this correction and calls the singular reading *"wrong by a factor $n$ on a subspace of dimension $\Theta(n^2)$"*. **The finding is therefore that $w$ is undefined and one of the two readings the entry supports is false at a named witness**, not that the sweep is wrong.

### 4.4 The counterexample the entry leaves standing

**Located.** *"A single mixed direction with $u\asymp n^{-1/2}$, margin $\Theta(1/n)$ and $\lVert A''\rVert=\Theta(n)$ restores $n^{-3/2}$ at every $\beta$."* This is a **live existence claim**, in italics, whose truth would refute the entry's own headline at every $\beta<\tfrac12$.

**Exhibited.** Under the very next sentence's two bounds it cannot exist. $\lVert A''\rVert=O(1/\rho)=O(n\lVert H\rVert_{op})=O(n^{1/2}+nw)$, so $\lVert A''\rVert=\Theta(n)$ forces $w=\Theta(1)$; and then $c(H)\ge c_p+(c_{\min}-c_p)w^2=\Theta(1)$, not $\Theta(1/n)$. **The two stated properties are incompatible.**

**The opposite, argued.** Read as narrative, the counterexample refutes the *old* mechanism (the $O(1)$ substitution on one summand), and the sweep then repairs the *conclusion*, the paragraph is coherent. That is plainly its intent. **But the entry never writes the reconciling sentence**, so as it stands it asserts a direction that restores $n^{-3/2}$ and, one sentence later, a bound under which that direction does not exist. [Lemma L149](../findings/second-order.md) is the entry that finally says it: *"So [r451]'s counterexample direction (margin $\Theta(1/n)$ with $\lVert A''\rVert=\Theta(n)$), does not exist."* **C10: the claim is false and the entry does not retract it.**

## 5. Range edges, and $\ker W\ne0$

### 5.1 $\beta\in[0,\tfrac12]$: both endpoints admissible, neither forced

- **Lower.** $\theta_0(n)^2=2(n-1)(n-2)/n^2=2(1-3/n+2/n^2)$ increases to $2$, so $\theta_0\uparrow\sqrt2$ strictly from below and $\sup\lvert P\rvert\ge\theta_0(n)=\Theta(1)$ forces $\beta\ge0$. **Confirmed, at even $n$**, [conventions.md](../findings/conventions.md) is explicit that $\theta_0(n)$ is the balanced value *at even $n$ only*, the odd-$n$ balanced split giving $\Theta_n<\theta_0(n)$. Since $n=2m$ this is the only parity in play, so the step is sound; but the entry states no parity, and a reader applying it at odd $n$ is using a value the record says is not attained there. ($\Theta_n=\Theta(1)$ too, so $\beta\ge0$ survives either way.)
- **Upper.** [Lemma L143](../findings/bounds.md) gives $\sup\lvert P\rvert\le1+\sqrt{n-2}=O(n^{1/2})$, so $\beta\le\tfrac12$. **Confirmed**, and the import is clean: L143's proof was re-read here through $B_5\le\tfrac12\sqrt{4(n-2)}$ from the pair cap and [Lemma L153](../findings/bounds.md)'s Killing row mass, both of which hold at every $W$ on the unit sphere.
- **Attainment.** Neither endpoint is forced. $\beta=0$ holds iff $\sup\lvert P\rvert=\Theta(1)$, which is [Conjecture A](../README.md)'s content and unproved; $\beta=\tfrac12$ holds iff $\sup\lvert P\rvert=\Theta(\sqrt n)$, and L143 is an **upper** bound only, which can never force it. The entry says *"$\beta=\tfrac12$ … is confirmed"*, what is confirmed is the *value* $n^{-3/2}$ under that hypothesis, not that $\beta=\tfrac12$ obtains.
- **And the hypothesis may be satisfied by no $\beta$.** $\sup\lvert P\rvert$ is bracketed between $\theta_0(n)$ and $1+\sqrt{n-2}$ and nowhere shown to be $\Theta(n^\beta)$ for any $\beta$; a sequence oscillating between the two ends satisfies the bracket and no $\Theta(n^\beta)$. The entry's closing paragraph half-says this (*"$\sup\lvert P\rvert$ is bracketed rather than known, so $\beta$ is not an exponent"*) while the boxed statement's hypothesis is exactly that $\beta$ *is* an exponent. **The lemma is conditional on a hypothesis the entry's own last paragraph doubts.**

### 5.2 $\ker W\ne0$, the recurring obstruction, and the object where it bites

At $W^*=S^m\times S^m$ the spectrum is two-valued with no kernel and $g_n=\lvert\lambda_-\rvert>0$, so $\ker W^*=0$ **holds** and $W\mapsto W_-$ is analytic there. [Lemma L149](../findings/second-order.md) states this as a hypothesis of the chain and checks it. **L147 never mentions it**, and (the point the brief presses), the sphere products are exactly where such a check cannot fail, so a proof written only there never meets the obstruction.

**The witness.** The record names a second structured family of critical points, $W_{\mathbb{CP}^m}$, proved Morse–Bott nondegenerate at every $m\ge3$ by [Lemma L28](../findings/nondegeneracy.md), so it is a legitimate base point for a tube. At $W_{\mathbb{CP}^2}$, $n=4$: $\Lambda^2(\mathbb R^4)=\Lambda^2_+\oplus\Lambda^2_-$ with $\dim=3+3$; Fubini–Study is self-dual Einstein, so $W$ acts as $0$ on all of $\Lambda^2_-$ and as $\propto\mathrm{diag}(2,-1,-1)$ on $\Lambda^2_+$. Hence

$$\dim E_+=1,\qquad \dim E_-=2,\qquad \boxed{\dim\ker W=3},$$

which is [Lemma L7](../findings/bounds.md)'s recorded triple exactly. **At this point $g_n=0$, $\rho=0$, $M$, $\lVert A''\rVert$ and branches 2 and 3 are all undefined, and $W\mapsto W_-$ is not even continuous.** L147's statement, carrying no base point, reads as a claim about "the tube radius" and "the route" wherever they are taken; at this named critical point every ingredient of it fails to exist. *The opposite argued:* the entry plainly intends $W^*$ throughout, being a set of corrections to [Lemma L145](../findings/second-order.md)'s chain. **That intent is nowhere in its statement**, which is the finding.

### 5.3 The smallest admissible dimension

$n=12$, from the sweep's coefficient $3\theta_0\tfrac{m-4}{2(m-1)}$ being non-positive at $m\le4$ and from $\rho^{\mathrm{eff}}$ having no definition at $n=10$. **L147 states no dimension range.** The bite is limited (every claim is asymptotic in $n$, so a finite exclusion cannot falsify a $\gtrsim$) but the entry's own ceiling display $c_p/\theta_0\le3/(n-2)$ is written as a finite-$n$ inequality, and its constants are only positive from $n\ge12$.

## 6. The gap between what is proved and what is used

### 6.1 The $\Theta(n^{-1})$ ceiling, PROVED, by one of its four reasons

Reason (a) is complete and exact. Take $H_0$ in an $S^2_0(\mathbb R^m)$ summand, where $c(H_0)=c_p$. Then

$$\min_j b_j(H_0)\;\le\;b_1(H_0)=\frac{c_p}{S}\;\le\;\frac{c_p}{\theta_0}\;=\;\frac{3\theta_0/(n-2)}{\theta_0}\;=\;\frac3{n-2},$$

using only $S\ge\theta_0$, which §5.1 establishes. So the chain's value at that direction, hence its infimum over directions, is $O(n^{-1})$: **the route is capped at $\Theta(n^{-1})$, unconditionally in $\beta$.** This is the one complete argument in the entry, and it needs neither the sweep nor $\lVert A''\rVert$ nor $\rho$.

The other three:

- **(b) "the corrected quartic branch is $\Theta(n^{-1})$", unproved, and false where it is evaluated.** A *cap* on branch 2 needs a **lower** bound on $\lVert A''\rVert$; the record has only upper bounds, and [Lemma L148](../findings/second-order.md) gives $\lVert A''\rVert=0$ on the very summand this is read at, where branch $2=\sqrt{c_p}/0$ is unbounded. [Lemma L149](../findings/second-order.md) says the same in its own words: *"At $w=0$ the defect vanishes identically, so the branch is **unbounded** there rather than $\Theta(n^{-1})$."*
- **(c)** holds: $\rho=\gamma g_n/\lVert H\rVert_{op}=\Theta(g_n)=\Theta(n^{-1})$ wherever $\lVert H\rVert_{op}=\Theta(1)$, and $\lVert H\rVert_{op}=1$ is attained at $w=1$ ([Lemma L158](../findings/second-order.md)'s envelope, which equals exactly $1$ there). The entry asserts the directions exist without saying so.
- **(d)** holds trivially: $\beta\ge0$ makes $n^{-1-\beta}\le n^{-1}$, so no ceiling above $n^{-1}$ can bind a bound that never reaches it.

**Note the reading.** The ceiling is a cap on **the chain**, not on the geometry: branch 1 uses the global $S=\sup\lvert P\rvert$ in place of the directional cubic coefficient, an over-estimate that is safe for a lower bound on $r$ and unsafe for an upper bound on $r$. What is proved is that *this route* cannot deliver more than $\Theta(n^{-1})$. The entry's word "route" carries that, correctly.

### 6.2 $r_n\gtrsim n^{-1-\beta}$, NOT proved in the entry

**Located.** The whole of the entry's support is one sentence: *"Both reviewers closed the sweep the lemma owed: $\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w$ … and $c(H)\gtrsim c_p+w^2$ … It returns these values and the $\Theta(n^{-1})$ ceiling."*

**What is missing, itemised.**

1. **The chain is never displayed.** L147 never writes $r(H)\gtrsim\min(b_1,b_2,b_3)$, never says what $r(H)$ is, never derives the branches from the penalised expansion, and never names the domain of $H$. The display first appears in the record at [Lemma L149](../findings/second-order.md), **two entries later**; no findings entry preceding L147 carries it. The entry corrects branches whose definitions are nowhere in the record it is part of.
2. **The joint minimisation is absent.** The two sweep bounds share $w$. Concluding $\Omega(n^{-1})$ requires minimising $\sqrt{c_p+\rho w^2}\big/(a_0n^{1/2}+nw)$ over $w\in[0,1]$, the computation [Lemma L149](../findings/second-order.md) performs. L147 performs none of it and asserts the outcome.
3. **The relaxation of $u$ is unjustified.** $u=u(H)$ is determined by $H$, and $f$ is minimised over a free $u\ge0$. Relaxing an argument under-estimates the branch, which is the safe direction, but the entry never says the relaxation happens, let alone that it is safe.
4. **Two of the three ingredients are conditional on unstated hypotheses** (§1.2), and one of the two sweep bounds is false under the singular reading the entry's own words carry (§4.3).

**The opposite, argued.** The order-level conclusion is **true** on the record as it now stands: [Lemma L149](../findings/second-order.md) supplies the sweep and its minimisation, [Lemma L146](../findings/second-order.md) the operator-norm bound, [Lemma L27](../findings/nondegeneracy.md) the margins. §2.2 shows that the branch-1 discrepancy costs a constant and not an order. **So the finding is not that the value is wrong; it is that L147 does not contain a proof of it**, and that the entry which does contain one postdates it, was returned `GAP` at its own round, and carries a repair the record itself marks unaudited.

## 7. Candidates withdrawn

### 7.1 "$c(H)\gtrsim c_p+w^2$ is false at $n=12,14$", withdrawn

**Located** in the quantifier box. **Exhibited:** the exact coefficient is $3\theta_0\tfrac{m-4}{2(m-1)}$, equal to $\sqrt{55}/10=0.741620$ at $n=12$, so the inequality with constant $1$ fails. **The opposite:** the entry writes "$\gtrsim$", which absorbs the constant, and $0.7416>0$ is a positive absolute constant for every $m\ge5$. As an order statement (the only reading the symbol supports), it is correct. **Withdrawn**; it is a real defect of the display in [Lemma L149](../findings/second-order.md), where the same bound is used inside a numeral, and no defect here.

### 7.2 "$f(u^*)=\Theta(\min(c_p/S,\sqrt{c_p}/a))$ hides an $n$-dependence", withdrawn

**Exhibited:** the bracketing in §2.1 has constants $\tfrac23$ and $2$, both absolute, derived from $\max(x,y)\le x+\sqrt{x^2+y^2}\le3\max(x,y)$ for $x,y\ge0$. **No $n$ enters.** Withdrawn as a non-finding: the claim is exactly right.

### 7.3 "the $\gtrsim$/$\Theta$ paragraph contradicts the statement's own hypothesis", withdrawn

**Exhibited:** the statement assumes $\sup\lvert P\rvert=\Theta(n^\beta)$ while the closing paragraph says *"$\beta$ is not an exponent"*. **The opposite:** the paragraph's subject is the *conclusion* (it argues against writing $r_n=\Theta(n^{-1-\beta})$) and "not an exponent" glosses "not known to be one". The tension is one of wording. **Withdrawn**, but recorded because it is the same sentence that raises §5.1's genuine point, that no $\beta$ is known to exist.

### 7.4 "the ceiling contradicts the $\gtrsim$", withdrawn

**Exhibited:** a lower bound $r_n\gtrsim n^{-1-\beta}$ and a cap at $\Theta(n^{-1})$ would conflict if both were about $r_n$. **The opposite:** the cap is on the **route**, i.e. on what the chain's minimum can be, and §6.1 proves it as such; $\beta\ge0$ then makes the two consistent, which is the entry's own reason (d). **Withdrawn.**

## 8. What would falsify the statement, and what was done to look for it

**The object that would break it:** a direction $H\in T_{W^*}S\cap T_{W^*}\mathcal O^\perp$ at $n=2m\ge12$, of unit Frobenius norm, with margin $c(H)=\Theta(1/n)$ and $\lVert A''\rVert=\omega(n^{1/2+\beta})$, that is, low-margin and high-curvature at once. **It is L147's own italicised counterexample**, and the entry asserts one exists.

**What I did to look for it.** Ran the margin's convex-combination identity over all eight admissible summands of [Lemma L27](../findings/nondegeneracy.md) by hand, with $L_e$'s exact eigenvalues $\{\lambda_m,\lambda_m,\mu,-\mu,0,0,0,0\}$ at $p=q=m$; the smallest margin is $c_p$, attained exactly on the two $S^2_0$ copies, and the next is $c_{\min}=3\theta_0\tfrac{m-3}{2(m-1)}$ on $\Lambda^2\!\otimes\!\Lambda^2$. So $c(H)=\Theta(1/n)$ forces $H$ into the joint $\lambda_m$-eigenspace up to weight $w=O(n^{-1/2})$, and there $\lVert H\rVert_{op}\le1/\sqrt{m-1}+w=O(n^{-1/2})$ gives $\rho=\Omega(n^{-1/2})$ and $\lVert A''\rVert=O(n^{1/2})$. **The direction cannot exist under the sweep**, and on the $S^2_0$ summands themselves [Lemma L148](../findings/second-order.md) makes $\lVert A''\rVert$ identically zero. **No falsifier found, and the entry's own claimed one is refuted by the entry's own next sentence.**

**A second falsifier, for the ceiling:** a direction with $c(H)/S\gg n^{-1}$. Since $c(H)\le3\theta_0/2$ (the four zero-eigenvalue summands' margin) and $S\ge\theta_0$, branch 1 is at most $\tfrac32$ everywhere, but the ceiling is read at the *infimum* over $H$, and $H_0$ in an $S^2_0$ copy caps it at $3/(n-2)$ exactly. **No falsifier exists; the ceiling is unconditional.**

## Verdict

**`GAP`.**

- **The $\Theta(n^{-1})$ ceiling is proved**, reason (a) alone, $c_p/S\le c_p/\theta_0=3/(n-2)$, exactly and unconditionally in $\beta$. Reason (b) is unproven and false at the direction it is read at.
- **The radius bound $r_n\gtrsim n^{-1-\beta}$ is not proved in the entry.** The three-branch chain it corrects is displayed in no findings entry preceding it, the joint minimisation over $w$ that the sweep needs is absent, and the conclusion is carried by the sentence "It returns these values".
- **Four hypotheses are unstated** (the base point $W^*=S^m\times S^m$, $n$ even, $n\ge12$, and $\ker W^*=0$) and $W_{\mathbb{CP}^2}$, with $\dim\ker W=3$, is a named nondegenerate critical point at which every ingredient of the entry ceases to exist.
- **One stated justification does not reach its object**: the $1$-Lipschitz property of $x\mapsto x_-$ is metric projection onto the PSD cone, a Hermitian fact, applied on the complex circle $\lvert z\rvert=\rho$ where $W(z)_-$ is a Riesz-projector image. The conclusion $M=O(\rho)$ survives on [Lemma L156](../findings/second-order.md)'s contour constant; the reason does not.
- **The pre-registered question is settled, and it costs a constant, not an order.** $f$'s minimiser is interior at $u^*=ac_p/(S+\sqrt{S^2+a^2c_p})$ **whenever $a>0$**, and at $u=0$ when $a=0$, which [Lemma L148](../findings/second-order.md) makes the case on both $S^2_0$ summands. $u$ is the defect weight and $w$ the off-eigenspace weight, related only by $u\le w$; L147's $(c_p+u^2)/(S+au)$ is the **valid** lower bound and [Lemma L149](../findings/second-order.md)'s $(c_p+w^2)/S$ is not, but their infima differ by a bounded factor at every $\beta$, so **both headline exponents are indifferent to the choice**.

**What would have to be proved to lift this to `PROVEN`:** (i) the three-branch chain, displayed and derived at the balanced orbit, inside the record's findings rather than in a review; (ii) the joint minimisation over $w$, with $w$ defined as the weight outside **both** $S^2_0$ copies; (iii) $M=O(\rho)$ from the contour estimate rather than from non-expansiveness; (iv) the four unstated hypotheses written into the statement; and (v) the retraction of the counterexample direction the entry still asserts.
