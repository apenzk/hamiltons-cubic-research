# REVIEW r719, the branch-2 recomputation: the ratio stands, the minimisation reverts to a refuted envelope

*Reviewer r719, 2026-09-05. Gate 2 on a derivation not yet on the record, held at [scratchpad/branch2-recompute.md](/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/branch2-recompute.md). **The brief was cold. No numerical work was done beyond the permitted screening**: every value below is an evaluation of closed forms already on the record, at points chosen to test a claim I was about to write, and none of it is offered as evidence for a positive claim. No search, sweep, census or falsifier hunt was opened. Log: [agent_logs/r719.log](../agent_logs/r719.log). No other reviewer's report was opened.*

| # | claim | verdict |
|---|---|---|
| A | $F'/F=(1/s)(N'/N)-D'/D$ for $F=N/((s+1)^2D)$, $s=\sqrt{1+4\mu N}$ | **CONFIRMED AS ALGEBRA, AND ALREADY ON THE RECORD**, as [v36](../verification/VERIFY_v36.md)'s elasticity, carried in [L158](../findings/second-order.md)'s r715 box |
| B | the radius inflation at $w=\tfrac23$, $n=12$ is $\approx1.043$, not $1.0867$ | **CONFIRMED**, at $1.043293$; every constant reads at the right dimension and from the right entry. *Two defects: the section heading's $4.1\%$ mixes bases with the $8.7\%$ it contrasts, and the numeral is hostage to [L149](../findings/second-order.md)'s unpaid $\tfrac29$ debt, at coefficient $1$ it reads $1.0485$* |
| C | branch 2 alone is minimised at $w=1$, $F$ strictly decreasing across $[0,1]$ | **REFUTED AS STATED.** It minimises the **triangle** envelope that [r715](REVIEW_r715.md) and [r716](REVIEW_r716.md) replaced. Under the record's own envelope $F$ is **strictly increasing** on $[\tfrac{n-4}n,1]$, so $w=1$ is the worst place to look, and $F(1)/F(\tfrac23)=1.1200$ |
| C′ | the same claim taken as an assertion about the triangle-envelope object | **UNPROVEN AS ARGUED** (three point evaluations prove nothing on an interval), **but true, and provable in two lines** (§4.3) |
| D | the reservation, that $w_0=(n-4)/n$ is a crossing of branches and so a different object from $\arg\min$ of branch 2 | **REFUTED.** $w_0$ is a kink of the operator-norm envelope **inside** branch 2, and it is exactly $\arg\min$ of branch 2 alone. The reservation is not cautious enough, and its reason is the error |

**One line the cycle can act on: the corrected branch-2 minimum at $n=12$ is still attained at $w_0=\tfrac23$ (now *proved*, not asserted) and the recorded bracket $(1,1.0867]$ collapses to the single factor $1.043293$, so the owed correction is $0.40347/1.043293=0.38673$, subject to §3.5's warning that $0.40347$ itself did not reproduce for me.**

## 0. Conventions, fixed once

Throughout, $n=2m$, $n=12$, $m=6$; $\lVert H\rVert_F=1$ and $w=\lVert H_r\rVert\in[0,1]$ is the weight outside **both** $S^2_0(\mathbb R^m)$ copies ([L149](../findings/second-order.md) line 1209).

$$\kappa=3\sqrt{\tfrac{2(n-1)}{n-2}},\quad c_p=\frac\kappa n,\quad \theta_0=\frac{\kappa(n-2)}{3n},\quad \lvert\kappa_n\rvert=9(\theta_0-\sqrt{3/2}),\quad \lambda=\frac2{\sqrt{\lvert\kappa_n\rvert}},$$
$$\rho^{\text{eff}}_n=3\theta_0\frac{n-8}{2(n-2)}-\frac29\lvert\kappa_n\rvert,\qquad a_0=\sqrt{\tfrac{2n}{n-2}},\qquad b:=a_0n^{-1/2}=\sqrt{\tfrac2{n-2}}=\tfrac1{\sqrt{m-1}} .$$

$N(w)=\sqrt{c_p+\rho w^2}$, $t=\mu N$ with $\mu=\lambda/(2C)$ (legitimate because $J\gamma=C$ and neither $J$ nor $\gamma$ depends on $w$), $s=\sqrt{1+4t}$, and

$$\text{branch }2=\frac{4\lambda}{\sqrt2\,J}\cdot F(w),\qquad F(w)=\frac{N(w)}{(s+1)^2D(w)},$$

which is [L158](../findings/second-order.md) line 1301's display with $(1-\eta^*)^2=4/(s+1)^2$ substituted. **The whole review turns on which $D$ is admissible.** Two are on the record, in the same lemma:

$$D_{\triangle}(w)=a_0n^{1/2}+nw=n(b+w)\qquad\text{(line 1301, and [L149](../findings/second-order.md)'s bullet at line 1209)},$$
$$D_\star(w)=n\min\big(b\sqrt{1-w^2}+w,\ 1\big)\qquad\text{([L158](../findings/second-order.md)'s r715/r716 box, line 1310)} .$$

$D_\star\le D_\triangle$ pointwise, so both give valid lower bounds on the radius and $D_\star$ gives the better one. The derivation under review uses $D_\triangle$ silently.

## 1. Claim A, the log-derivative identity

### 1.1 The algebra, step by step

$s^2=1+4\mu N$ is the definition of $s$. Differentiating, $2ss'=4\mu N'$, so $s'=2\mu N'/s$. Then

$$\frac{2s'}{s+1}=\frac{4\mu N'}{s(s+1)} .$$

The substitution is $4\mu=(s^2-1)/N$, which is the definition rearranged. It is legitimate at every $w\in[0,1]$: $N=\sqrt{c_p+\rho w^2}\ge\sqrt{c_p}=0.60894>0$ for every $\rho\ge0$, so the division by $N$ never touches a zero, and $N$ is smooth on $[0,1]$ because $c_p>0$ keeps the radicand away from the origin. Hence

$$\frac{2s'}{s+1}=\frac{(s^2-1)N'}{N\,s(s+1)}=\frac{(s-1)N'}{N\,s},$$

the cancellation of $(s+1)$ being licensed by $s\ge1>0$. Therefore

$$\frac{F'}F=\frac{N'}N-\frac{2s'}{s+1}-\frac{D'}D=\frac{N'}N\Big(1-\frac{s-1}s\Big)-\frac{D'}D=\frac1s\frac{N'}N-\frac{D'}D .$$

**Every step holds, at every $w$ in the range, for every $\mu>0$ and $\rho\ge0$.** The identity needs no smallness in $t$ and no expansion.

### 1.2 The one place it could have failed, and does not

$D_\star$ is only piecewise smooth, it has a corner at $w_0$. The identity is therefore an identity on $[0,w_0)$ and on $(w_0,1]$ separately, with one-sided derivatives at $w_0$. That costs nothing, since the two one-sided statements are what §4 uses. The derivation never says this because it never meets the corner: with $D_\triangle$ everything is smooth.

### 1.3 It is not new

The record already carries it. [ROUND_L157](../verification/ROUND_L157.md) line 95: *"v36 re-derived the elasticity rather than citing it, getting $\mathrm d\log(Ks)/\mathrm d\log s=1/\sqrt{4t+1}\in(0,1)$"*, and [L158](../findings/second-order.md)'s r715 box states the same quantity in the same form. The derivation under review says so itself and claims independence, which is fair, a second independent derivation of a load-bearing identity is worth having. **What it is not is a new result, and §5 records why that matters here.**

## 2. Claim B, every constant, at its own dimension and its own entry

| constant | value used | checked against | verdict |
|---|---|---|---|
| $\kappa$ | $3\sqrt{11/5}=4.4497191$ | [L158](../findings/second-order.md)'s box, $\kappa=nc_p$, $\kappa(12)=4.4497$ | right |
| $c_p$ | $\kappa/n=0.37080992$ | [L149](../findings/second-order.md), $c_p=\kappa/n$; cross-checks against [L146](../findings/second-order.md)'s $c_p=3\theta_0/(n-2)$ | right |
| $a_0n^{1/2}$ | $12/\sqrt5=5.3665631$ | $a_0=\sqrt{2n/(n-2)}=1.5491933$, and $a_0n^{1/2}=n/\sqrt{m-1}$, the r716 box's *"one quantity written two ways"* | right |
| $\rho^{\text{eff}}_{12}$ | $\sqrt6-\tfrac7{30}\sqrt{55}=0.7190434$ | [L158](../findings/second-order.md) line 1318 verbatim; and reproduces from $3\theta_0\tfrac{n-8}{2(n-2)}-\tfrac29\lvert\kappa_n\rvert=0.7416199-0.0225764$ | right |
| $\lambda(12)$ | $6.27474$ | $2/\sqrt{\lvert\kappa_{12}\rvert}$ with $\lvert\kappa_{12}\rvert=0.1015939$ gives $6.274747$ | right, **and better than the record's rounded $6.275$** |
| $C^*$ | $42/11=3.8181818$ | [L156](../findings/second-order.md)'s *"Numbers at $n=12$ ($m=6$)"* row; reproduces from $2\alpha(1+\alpha)/d^2$ at $\alpha=d=1.1$ | right |
| $J^*$ | $840/121=6.9421488$ | same row; reproduces from $4\alpha(1+\alpha)/d^3$ | right |
| $\mu$ | $0.8216847$ | $\lambda/(2C^*)=0.8216930$ | right to $10^{-5}$, immaterial |

**The three traps named in the brief were all avoided.**

- *A supremum confused with a table row.* $J^*$ is read at $6.9421$, which is both the $n=12$ row and the bottom of the in-scope range $6.9421\le J^*<8$, because $J^*=4\alpha(1+\alpha)/d^3$ at $\alpha=d=D/2$ increases as $D=\tfrac{2m-1}{m-1}$ falls, so the two readings coincide at $m=6$ and the coincidence is not an accident. Nothing is misread.
- *A constant read at its $n\to\infty$ value at finite $n$.* This is the trap [L158](../findings/second-order.md) records against $\lambda$, and it is avoided. It is also load-bearing here rather than cosmetic: at the asymptotic $\lambda=1.53$ the same computation returns an inflation of $6.6\%$ rather than $4.3\%$, because $\mu$ falls by $4.1\times$, $s$ falls toward $1.30$, and the damping weakens. **The claim would move by half its own size on that one constant, and the derivation reads it correctly.**
- *A bound rounded the wrong way.* $\rho^{\text{eff}}$ is the **penalised** coefficient, which is the one branch 2 carries ([L149](../findings/second-order.md)'s box: *"The penalty lands on that same summand"*), rather than the unpenalised $0.74162$ of the neighbouring bullet. Right choice; see §3.4 for what it costs.

## 3. Claim B, what the ratio does and does not say

### 3.1 The value, and why it is robust

At $w=\tfrac23$: $N_1=0.9029144$, $t_1=0.7419185$, $s_1=1.9919021$; $N_\rho=0.8308940$, $t_\rho=0.6827398$, $s_\rho=1.9315691$. Hence

$$\frac{F_1}{F_\rho}=\frac{N_1}{N_\rho}\cdot\frac{(s_\rho+1)^2}{(s_1+1)^2}=1.0866777\times0.9600435=1.043293 .$$

**$D$ cancels identically.** The ratio is therefore independent of which envelope is used, of $1/g_n$'s $\sqrt2$ approximation, of $J$ and of the whole prefactor $4\lambda/(\sqrt2J)$, the only constants it can see are those inside $\mu$ and $c_p$. That is the derivation's real contribution and it survives every objection in §4.

### 3.2 The heading mixes two bases against each other

> **"RESULT 1, the radius inflation is about 4.1%, not 8.7%"**

against its own body, *"ratio = 1.04328"*. The two are not the same statement. $1.043293$ is an inflation of $4.33\%$ read against the corrected value; $4.15\%$ is the same fact read as a **reduction** against the inflated value, $1-1/1.043293$. The $8.7\%$ it is contrasted with is the record's $1.0867$, an inflation. **Like for like the comparison is $4.33\%$ against $8.67\%$, or $4.15\%$ against $7.98\%$; the heading pairs one of each.** On a record where the headline numeral is what gets cited, three entries in [second-order.md](../findings/second-order.md) say so, this is the sentence that would propagate.

### 3.3 The absolute $F$ values are not branch 2

$F(\tfrac23)=0.0075463$ and $0.0072331$ are computed at $D_\triangle(\tfrac23)=13.3665631$, where the record's own envelope gives $D_\star(\tfrac23)=12$ exactly. They differ by the factor $1.1138803=b+w_0$, which is $\lVert H\rVert_{op}$'s triangle bound at a point where $\lVert H\rVert_F=1$ has already capped it at $1$. **So neither number is a value of branch 2 under the record's settled reading**; only their ratio means anything. The derivation presents them in a table headed by the constants of the record, which invites the misreading.

### 3.4 The numeral is hostage to an unpaid debt the derivation does not name

[L149](../findings/second-order.md) marks the $\tfrac29$ in $\rho^{\text{eff}}$ `HYPOTHESIS-DEBT`: *"reading it here identifies that block with $\Lambda^2\otimes\Lambda^2$, and nothing on file joins the two decompositions… At coefficient $1$ the constant reads $0.689771$."* Under that reading the same computation returns

$$\frac{F_1}{F_{0.689771}}=1.048453,$$

so the headline moves from $4.33\%$ to $4.85\%$, **half a percentage point, on a constant the record itself flags as unowned.** The derivation quotes $\rho^{\text{eff}}_{12}$ as though it were settled. It should carry the bracket $[1.0433,\,1.0485]$ until the debt is paid.

### 3.5 The base it corrects did not reproduce for me

Applying $1.043293$ to the recorded $0.40347$ gives $0.38673$. I could not reproduce $0.40347$ itself from the record's constants: $n\cdot\text{branch }2$ at $w_0$ with $\rho=1$ returns $0.2579$ under $D_\star$ with the $\sqrt2$ convention, $0.2315$ under $D_\triangle$, $0.2459$ with the exact $1/g_n=n^2c_p/6$, and $0.2207$ with the exact $g_n$ and the triangle envelope, none of them $0.40347$. [L158](../findings/second-order.md) line 1320 already records neighbouring figures that *"reproduce from no combination of the record's constants"*. **I raise this as owed rather than as an error**: the factor is what I certify, and the product $0.38673$ inherits whatever provenance $0.40347$ has.

## 4. Claim C, refuted, by the record's own envelope

### 4.1 Locate it

> **"F is strictly decreasing across [0,1] on both coefficients, so branch 2 alone is minimised at the endpoint $w=1$, not at the interior $2/3$."**

resting on

> **"$F'/F<0$ iff … $\rho w/(s(c_p+\rho w^2))<n/(a_0n^{1/2}+nw)$."**

The right-hand side is $D_\triangle'/D_\triangle$. **$D_\triangle$ is the envelope [L158](../findings/second-order.md)'s Gate-2 box replaced.**

### 4.2 Exhibit the failure, in closed form

For $w\ge w_0=(n-4)/n$ the admissible envelope is the constant $1$: $b\sqrt{1-w^2}+w\ge1$ there, since $b\sqrt{1-w^2}+w=1$ solves to $b^2(1+w)=1-w$, i.e. $w=\tfrac{1-b^2}{1+b^2}=\tfrac{n-4}n$, and the left side exceeds $1$ beyond it. Hence on $[w_0,1]$,

$$D_\star\equiv n,\qquad D_\star'=0,\qquad \frac{F'}F=\frac1s\frac{N'}N=\frac{\rho w}{s\,(c_p+\rho w^2)}>0 \quad\text{for every }w>0,\ \rho>0,$$

because $s\ge1$ and $N$ is strictly increasing. **$F$ is strictly increasing on $[w_0,1]$, so $w=1$ is a strict maximum of $F$ over that subinterval and cannot be its minimiser.** No arithmetic is needed for the refutation; the numbers only price it. At $n=12$ with $\rho^{\text{eff}}$: $F_\star(\tfrac23)=0.0080568$ against $F_\star(1)=0.0090233$, a rise of $12.00\%$.

**The overcount is exactly the one already refuted.** At $w=1$, $D_\triangle/D_\star=b+1=1.4472136$, *[r714](REVIEW_r714.md)'s $1.4472$*, of which [L158](../findings/second-order.md)'s box says it *"prices an $H_s$ that $\lVert H\rVert_F=1$ has already emptied"*. The derivation reaches r714's conclusion by r714's refuted mechanism, one entry after that refutation was settled by two reviewers.

**And its own Claim A is the instrument of the refutation.** [L158](../findings/second-order.md)'s r715 box uses precisely the identity of §1 to conclude *"$K$'s decrease can never overturn the rise above the kink"*. The derivation derives that identity in its second section and then, in its fifth, asserts the thing the identity forbids.

### 4.3 Argue the opposite, the strongest defence, and how far it reaches

The strongest defence is that $D_\triangle$ is a **valid** upper bound on $\lVert H\rVert_{op}$, so branch 2 built on it is a genuine (weaker) lower bound on the radius, and the derivation is minimising a legitimate object. That defence holds, and on that object the claim is **true**, the derivation simply did not prove it. Three point evaluations establish nothing on an interval; here is the missing proof, in two lines. On $[0,1]$,

$$\frac1s\le\frac1{s(0)}=\big(1+4\mu\sqrt{c_p}\big)^{-1/2}=0.577211,\qquad \max_{w\ge0}\frac{\rho w}{c_p+\rho w^2}=\frac{\sqrt\rho}{2\sqrt{c_p}},$$

the first because $s$ is increasing in $N$ and $N$ in $w$, the second by AM–GM at $w=\sqrt{c_p/\rho}$. Their product is $0.473946$ at $\rho=1$ and $0.401876$ at $\rho^{\text{eff}}$, while $D_\triangle'/D_\triangle=1/(b+w)\ge1/(b+1)=0.690983$ on $[0,1]$. **Both products fall strictly below, so $F'<0$ throughout $[0,1]$ on both coefficients.** The claim is true of the triangle object and now proved.

**What the defence cannot reach**: the derivation states the conclusion against *"the record"*, whose settled minimiser is $w_0$ under $D_\star$. A statement about a superseded object, offered as a correction to the object that superseded it, is refuted as stated however sound its interior.

### 4.4 The complete result the derivation was one step from

Under $D_\star$ and $\rho^{\text{eff}}$ at $n=12$, the minimum of branch 2 over $[0,1]$ is at $w_0=\tfrac23$ **exactly**, and this is a proof rather than three evaluations:

- On $[w_0,1]$: $F'>0$ by §4.2.
- On $[0,w_0]$: $D_\star'/D_\star=\dfrac{1-bw/\sqrt{1-w^2}}{b\sqrt{1-w^2}+w}$. The denominator is $\le1$ on $[0,w_0]$, with equality only at $w_0$. The numerator is decreasing, since $bw/\sqrt{1-w^2}$ increases, and at $w_0$ it equals $1-b\cdot\tfrac23/\sqrt{5/9}=1-0.4=0.6$. **So $D_\star'/D_\star\ge0.6$ on $[0,w_0]$**, against $(1/s)(N'/N)\le0.401876$ from §4.3. Hence $F'<0$ there.

$F$ falls strictly to $w_0$ and rises strictly after it. **The homogeneity kink is the minimiser, and the $\rho^{\text{eff}}$ repair does not move it**, which is what [L158](../findings/second-order.md) predicted (*"Repairing it strengthens the case for the homogeneity kink"*) and had not proved. This is the piece of the item that is actually new and correct.

## 5. Claim D, the reservation is wrong, and being wrong about it is what let the error through

> **"The record's $w_0=2/3=(n-4)/n$ is a *homogeneity kink*, not a stationary point of branch 2. So the chain's minimum is a minimum of $\min$(branch1, branch2, branch3), and the kink is where branches cross, which is a different object from $\arg\min$ of branch 2."**

**The kink is not where branches cross.** It is where $\min\big(b\sqrt{1-w^2}+w,\ 1\big)$ meets its cap, a corner of the operator-norm envelope **inside** branch 2, having nothing to do with branches 1 and 3. [L158](../findings/second-order.md)'s box derives $w_0$ from that crossing of $1$ and from nothing else, and the word *homogeneity* names its cause: $\lVert H_s\rVert_F=\sqrt{1-w^2}$ is an identity and [L146](../findings/second-order.md) is homogeneous.

So the reservation is **not cautious enough**: $w_0$ is $\arg\min$ of branch 2 alone, exactly the object Claim C is about, and Claim C therefore contradicts a settled Gate-2 result head-on rather than living beside it. **And the wrong reason is the load-bearing part.** Believing $w_0$ to be a branch crossing is what makes it plausible that branch 2 alone could be minimised elsewhere; had the derivation read $w_0$ as the envelope's corner, it would have had to look at $D$ on $[w_0,1]$ and would have found the cap in one line.

The one respect in which the reservation is *too* cautious is unrelated and correct in outcome: a claim about branch 2 alone would indeed not settle $\min$ of three branches. That caveat is sound and worth keeping.

## 6. Hypotheses the derivation uses and does not state

- **$\lVert H\rVert_F=1$ with $w=\lVert H_r\rVert$ the weight outside both copies**, so $w\in[0,1]$, [L149](../findings/second-order.md) line 1209. Unstated, and it is the hypothesis that breaks Claim C: it forces $\lVert H_s\rVert_F=\sqrt{1-w^2}$ and hence the cap at $1$.
- **$w=0$ is not in the domain.** [L148](../findings/second-order.md) makes the defect vanish identically there, so branch 2 is absent rather than small; [L157](../findings/second-order.md) records three prior entries reading a value at $w=0$ that the object does not occupy. *"Strictly decreasing across $[0,1]$"* asserts something at a point where there is nothing to assert. It costs Claim C nothing, since Claim C fails at the other end, but it is the same recorded trap.
- **$\ker W^*=0$.** [L147](../findings/second-order.md) and [L149](../findings/second-order.md) both list it: without it $W\mapsto W_-$ is not analytic at the base point and **branches 2 and 3 have no domain at all**, with $W_{\mathbb{CP}^2}$ ($\dim\ker=3$) the named witness. Unstated. It holds at $W^*=S^m\times S^m$, where $g_n>0$, so nothing fails, but the derivation's object does not exist at the competitor and the entry should say where it lives.
- **$n=2m$ even and $m\ge6$.** [L149](../findings/second-order.md): at $n=10$, $\theta_0<\sqrt{3/2}$, $\lvert\kappa_n\rvert$ turns negative and $\rho^{\text{eff}}$ *"has no definition"*. Claim C is stated dimension-free while its ingredients are defined only from $m\ge6$.
- **$C$ held at $C^*$ while $w$ varies.** *Legitimate as a $w$-dependence*: $J\gamma=C$ and neither contour parameter depends on $w$, so $\mu$ is genuinely constant along the minimisation and Claim A is safe. *Illegitimate as an optimum*: $(\alpha^*,\gamma^*)$ minimises $J=C/\gamma$, whereas branch $2=\tfrac{4\lambda}{\sqrt2J}\cdot\tfrac N{(s+1)^2D}$ is **increasing in $C$ at fixed $J$**, raising $C$ lowers $t$, lowers $s$ and raises $4/(s+1)^2$. Minimising $J$ is therefore not the same as maximising the lower bound, and the record already leans this way: [L157](../findings/second-order.md) records that *"in [L156](../findings/second-order.md) it is the **Cauchy radius $\gamma-r$**, not $\gamma$, that wants to be $d/2$"*. Inherited rather than introduced, but unstated.
- **$1/g_n\approx n/\sqrt2$.** The $\sqrt2$ in the prefactor and the bare $n$ in $D$ together encode this, and [L158](../findings/second-order.md) lists it among four constants an earlier entry had wrong: the exact $1/g_n=n^2c_p/6=8.8994$ against $n/\sqrt2=8.4853$, *"$4.9\%$ low in the unsafe direction"*. It cancels from Claim B's ratio and is inert for Claim C's sign, so it does no damage here, but any absolute branch-2 numeral built on this $F$ carries it.

## 7. What the record already had

| the derivation's | the record's |
|---|---|
| Claim A, the elasticity $1/s=1/\sqrt{4t+1}$ | [v36](../verification/VERIFY_v36.md), and [L158](../findings/second-order.md)'s r715 box, which states it *"for every $\lambda,J,\gamma$"*, more general than the $n=12$ instance here |
| Claim C's target, $\arg\min$ of branch 2 | [L158](../findings/second-order.md) line 1310, settled at Gate 2 by [r715](REVIEW_r715.md) and [r716](REVIEW_r716.md): the minimiser is $w_0=(n-4)/n$ |
| Claim C's mechanism, the endpoint $w=1$ | [r714](REVIEW_r714.md), refuted, by the $1.4472$ this derivation reintroduces |
| Claim B's ratio | **Genuinely owed.** [v36](../verification/VERIFY_v36.md) line 137 gets as far as *"the pointwise bracket at $w_0$ is $(0.37129,\ 0.40347)$… the true repaired value sits strictly inside, and the minimiser may itself move"*; [L158](../findings/second-order.md) says *"the corrected minimum is owed"*. **This derivation supplies the interior point, and §4.4 supplies the missing half, the minimiser does not move.** |

**A defect in the record itself, which is the proximate cause.** [L158](../findings/second-order.md)'s settled branch-2 display at line 1301 carries $D_\triangle$, while the r715/r716 box nine lines below carries $D_\star$ and calls the first *"wrong"*. Both are inside one lemma. [L149](../findings/second-order.md)'s bullet at line 1209 carries $D_\triangle$ too, and so does [VERIFY_v37](../verification/VERIFY_v37.md) line 112. **A reader who takes the display literally reproduces this derivation's error**, and the next edit to L158 should either replace the display's denominator with $\min\big(a_0n^{1/2}\sqrt{1-w^2}+nw,\ n\big)$ or mark it as the loose form.

## 8. Verdicts

- **Claim A: CONFIRMED AS ALGEBRA**, valid at every $w\in[0,1]$, with the substitution legitimate because $N\ge\sqrt{c_p}>0$ and $s\ge1$. **Already on the record** as [v36](../verification/VERIFY_v36.md)'s elasticity; worth keeping as an independent second derivation, not as a new result.
- **Claim B: CONFIRMED at $1.043293$.** Every constant is read at the right dimension and from the right entry, including the two the record has previously had wrong. **Three amendments owed**: the heading's $4.1\%$ against $8.7\%$ mixes bases and should read $4.33\%$ against $8.67\%$; the $F$ values are not branch 2 and only their ratio is meaningful; and the figure should be bracketed $[1.0433,1.0485]$ until [L149](../findings/second-order.md)'s $\tfrac29$ debt is paid.
- **Claim C: REFUTED AS STATED**, and its interior is **UNPROVEN AS ARGUED** though true of the object it actually treats. Under the record's settled envelope $F$ is strictly increasing on $[(n-4)/n,1]$.
- **Claim D: REFUTED.** $w_0$ is $\arg\min$ of branch 2 alone, not a branch crossing.
- **New and standing, from §4.4**: at $n=12$ the corrected branch-2 minimum is attained at $w_0=\tfrac23$, proved on both sides of the kink, so the recorded bracket $(1,1.0867]$ collapses to $1.043293$ and the corrected minimum is $0.38673$, subject to §3.5.

*Screening note. Six evaluations of $F$ at $w\in\{0.2,0.4,0.5,\tfrac23,0.8,0.9,1\}$ under both envelopes and three coefficients, plus the constant cross-checks of §2. They price statements proved in §4.2 and §4.4 without them, and no claim above rests on a number that the accompanying derivation does not also give. **A screen that could not have failed is not a screen**, this one could: had $F_\star(1)<F_\star(\tfrac23)$ the sign derivation of §4.2 would have been wrong somewhere, and I would have had to find where.*
