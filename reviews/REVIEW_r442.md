# Review r442, post F60, the claim that the tube radius cannot beat $\Theta(n^{-2})$

*Reviewer r442, 2026-09-03, cold adversarial brief. Target: [post F60](../findings/second-order.md) and its three numbered claims, the margin is attained, the remainder is forced, therefore $r_n=c_n/C=\Theta(n^{-2})$ is the method's ceiling. Supporting material read in full: [Lemma L141](../findings/second-order.md), [Lemma L133](../findings/second-order.md), [Lemma L27](../findings/nondegeneracy.md), the [I2](../plan.md) item, [REVIEW_r441.md](REVIEW_r441.md). **Analysis only**: every derivation below is by hand; one numerical screen re-evaluates closed forms I had already derived and is reported as a screen. Working: [agent_logs/r442-F60.log](../agent_logs/r442-F60.log).*

## Verdicts

| claim | verdict | one line |
| --- | --- | --- |
| **(1) the margin is attained** | **CONFIRMED**, with a factor-$2$ error inside its own justification | $c_n=3\theta_0/(n-2)$ is right and is attained on the within-factor pair block, recomputed from [Lemma L27](../findings/nondegeneracy.md)'s spectrum; but $c_n$ is **$3\theta_0$** times the gap $\tfrac1{n-2}$, not $6\theta_0$ as the post and [Lemma L141](../findings/second-order.md) both say |
| **(2) the remainder is forced** | **REFUTED as stated** | the divided differences are exactly as claimed (I recomputed both) but the third one contributes **nothing** to $(\delta^2)'''$ at the base point, and everything the record has on the surviving term is an **upper** bound whose cited source conditions it on "absent an unproven cancellation" |
| **(3) therefore $r_n=\Theta(n^{-2})$ is the ceiling** | **REFUTED** | the attained margin and the forced remainder live on **orthogonal blocks** and never bind in one direction; what actually sets the exponent is $C_P=O(n)$, i.e. $\sup\lvert P\rvert\le n-1$, a third constant the post never names, never defends, and which the record's own evidence puts at $\Theta(1)$ |

**The one sentence that matters.** F60 names two halves and proves neither pins the exponent: on the direction that *attains* the margin the defect's derivative is **zero**, so the resolvent half of $C$ is inert exactly where $c_n$ is decided, and the $\Theta(n^{-2})$ the post fences is produced by the crude bound $\sup\lvert P\rvert\le n-1$, which the post does not mention.

---

## Claim (1), the margin. CONFIRMED, and one factor is wrong.

**Recomputed from [Lemma L27](../findings/nondegeneracy.md), not from [Lemma L141](../findings/second-order.md).** At $W_{p,q}$ with $p=q=m$, $L_e$ is a scalar on each of the ten multiplicity-free $O(p)\times O(q)$ summands, with values $1$ on $\langle W\rangle$, $\tfrac12$ on $\mathbb R^p\otimes\mathbb R^q$ (the orbit), $\lambda_m=\tfrac{m-2}{2(m-1)}$ on each $S^2_0(\mathbb R^m)$, $\pm\mu$ on the two tensor summands, $0$ on the remaining four. Off the orbit and off the radial direction the largest value is therefore

$$\max\Big(\lambda_m,\ \mu\Big)=\max\Big(\tfrac12-\tfrac1{n-2},\ \tfrac2{n-2}\Big)=\tfrac12-\tfrac1{n-2}\quad\text{for }n>6,$$

attained on $S^2_0(\mathbb R^m)$, which is [Lemma L133](../findings/second-order.md)'s "within-factor pair block", the two namings agreeing. With $\tfrac12\mathrm{Hess}(P|_S)=3\theta_0(L_e-\tfrac12)$ ([Lemma L24](../findings/second-order.md)) and the defect response vanishing off the $(2,2)$-split four-sets, the block minimum of $Q/\lVert H\rVert^2$ is $3\theta_0(\lambda_m-\tfrac12)=-\tfrac{3\theta_0}{n-2}$, and the $(2,2)$ blocks sit far below it: [Lemma L141](../findings/second-order.md)(b)'s own $s=1$ value is $3\theta_0(\mu-\tfrac12)+\tfrac29\lvert\kappa_n\rvert\to-2.12+0.38=-1.74$, against $-\tfrac{3\theta_0}{n-2}\to0^-$. **So the pair block binds, $c_n=3\theta_0/(n-2)$, and it is attained.** I could not break this.

### FINDING 1, "$6\theta_0$ times the gap" is off by a factor of two, in the post and in the lemma.

Both F60 and [Lemma L141](../findings/second-order.md)'s "*The $1/n$ decay is intrinsic*" paragraph say $c_n=3\theta_0/(n-2)$ "is $6\theta_0$ times the balanced product's own $L_e$-eigenvalue gap $\tfrac12-\lambda_m=\tfrac1{n-2}$". The gap is $\tfrac1{n-2}$ and $c_n=3\theta_0/(n-2)$, so the multiplier is $3\theta_0$. The slip is traceable: $\mathrm{Hess}(P|_S)=6\theta_0(L_e-\tfrac12)$, and $Q$ carries **half** the Hessian. At $n=12$: $6\theta_0\cdot\tfrac1{10}=0.7416$ against the true $c_{12}=0.3708$. **A constant, not an exponent**, but it stands inside the sentence the post offers as the reason the decay is intrinsic, and it is now on the record in two places.

### FINDING 2, "attained" is attainment of a *uniform* constant, and the post uses it as if it were more.

$c_n$ is the minimum of $Q/\lVert H\rVert^2$ over the whole orbit-normal space. Attainment says no direction does better *for that uniform constant*. It does **not** say the tube argument must use a uniform constant: the argument compares, direction by direction, a second-order margin against a third-order remainder, and both are functions of $H$. The relevant quantity is $\inf_H\,c(H)/C(H)$, of which $c_n/\sup_HC(H)$ is a lower bound and generally a strictly worse one. This becomes decisive in claim (3), because the direction attaining $c_n$ is precisely the direction on which the post's other half is inert.

---

## Claim (2), the remainder. The divided differences are right; "forced" is not.

### The divided differences, recomputed cold. CONFIRMED.

With $f(x)=x\mathbf 1_{x<0}$, $\lambda_+=\tfrac1{\sqrt{(m-1)(2m-1)}}$, $\lambda_-=-\tfrac1m\sqrt{\tfrac{m-1}{2m-1}}$:

$$\lambda_--\lambda_+=-\frac{\sqrt{2m-1}}{m\sqrt{m-1}},\qquad f^{[1]}(\lambda_-,\lambda_+)=\frac{\lambda_-}{\lambda_--\lambda_+}=\frac{m-1}{2m-1},$$

$$f^{[2]}(\lambda_-,\lambda_-,\lambda_+)=\frac{1-\tfrac{m-1}{2m-1}}{\lambda_--\lambda_+}=-\frac{m^2\sqrt{m-1}}{(2m-1)^{3/2}}\sim-\frac{m}{2\sqrt2}=-\frac{n}{4\sqrt2},$$

$$f^{[3]}(\lambda_-,\lambda_-,\lambda_-,\lambda_+)=\frac{0-f^{[2]}}{\lambda_--\lambda_+}=-\frac{m^3(m-1)}{(2m-1)^2}\sim-\frac{m^2}{4}=-\frac{n^2}{16},$$

using $f''\equiv0$ near $\lambda_-$, so $f^{[2]}(\lambda_-,\lambda_-,\lambda_-)=0$. My closed form for $f^{[2]}$ is algebraically identical to [r441](REVIEW_r441.md)'s. *Screen (seconds, on the closed forms above, reported as a screen and not as evidence): at $m=6,10,50,500$ the ratios $f^{[2]}/n$ and $f^{[3]}/n^2$ converge to $-0.17678=-\tfrac1{4\sqrt2}$ and $-0.0625=-\tfrac1{16}$.* **$\Theta(n)$ and $\Theta(n^2)$ confirmed.**

### FINDING 3, the third divided difference contributes nothing to $(\delta^2)'''$ at the base point.

Write $A(t)=\mathrm{Alt}(W(t)_-)$, $\delta^2=\langle A,A\rangle$. Then

$$(\delta^2)'''=2\langle A''',A\rangle+6\langle A'',A'\rangle,$$

and at $t=0$ the first term dies because $A(0)=\mathrm{Alt}(W^*_-)=0$, the same vanishing the whole chain is built on. So $(\delta^2)'''(0)=6\langle A''(0),A'(0)\rangle$, which involves the **second** divided difference only. **The $\Theta(n^2)$ third divided difference, which F60 lists as one of the two things forcing the remainder, forces nothing at the base point**; it enters only through [r441](REVIEW_r441.md)'s FINDING 1 bootstrap, as $\sup_{\lvert t\rvert\le r}\langle A''',A\rangle=O(n^2r)$, an upper bound over the interval, at a stage where $r$ is already assumed $O(1/n)$. The post cites it as a *cause*; it is a bounded term in a bootstrap.

### FINDING 4, every figure in the chain is an upper bound, and the cited source says so.

The record's route to $(\delta^2)'''$ is: Riesz projection holomorphic on $\lvert z\rvert<\rho<g_n$, Cauchy estimates $\lVert A''\rVert\le2M/\rho^2$, $\lVert A'''\rVert\le6M/\rho^3$ with $M=O(g_n)$, hence $\lVert A''(0)\rVert=O(n)$ and $(\delta^2)'''(0)=O(n)$. Every step is an inequality in one direction. **Nothing in the record exhibits a direction $H$ with $\langle A''(0),A'(0)\rangle=\Theta(n)$**, and nothing shows the Cauchy estimate is saturated. F60 converts $O(n)$ into "forced", i.e. into $\Omega(n)$, with no argument.

The source it cites for the conversion says the opposite. [r441](REVIEW_r441.md)'s own summary reads: "*So $r_n=\Theta(n^{-2})$, **absent an unproven cancellation in $\langle A'',A'\rangle$***". **F60 quotes r441 for the claim and drops r441's condition on it.** The [I2](../plan.md) item repeats the loss ("$C_\delta=\Theta(n)$ is forced by the third divided difference"), with the misattribution of FINDING 3 added.

### FINDING 5, a cancellation in the composition step is not idle speculation; two have already happened.

The brief asks whether products can change orders. They already have, twice, in this very chain, and both times through $\mathrm{Alt}$:

- **Order zero.** $\mathrm{Alt}(W^*_-)=0$ kills the unique $\Theta(1)$ Neumann term, which is what turns $M=\Theta(1)$ into $M=O(g_n)$ and $r_n=\Omega(n^{-4})$ into $\Omega(n^{-2})$, [r441](REVIEW_r441.md)'s own counterfactual.
- **Order one.** In [Lemma L133](../findings/second-order.md)'s support table the Daleckii–Krein coefficient $c=\tfrac{m-1}{2m-1}$ "*drops out entirely: the entry it multiplies is the one $\mathrm{Alt}$ annihilates*", and $A'$ survives on the $(2,2)$-split four-sets alone.

So the operative question at order two is whether the entries carrying $f^{[2]}=\Theta(n)$ survive $\mathrm{Alt}$ **and** pair nontrivially with $A'$, which is supported on a two-dimensional slice of each $(2,2)$ block. That is a finite, checkable question about $\Lambda^4$ components, and nobody has asked it. **A fence post whose load-bearing constant depends on an unasked question of exactly the kind that has already collapsed twice in the same chain is not a ceiling.**

---

## Claim (3), the ceiling. REFUTED, and the reason is structural.

### FINDING 6, the two "pinned halves" live on orthogonal blocks and never bind in the same direction.

This is the decisive one, and it is the record's own arithmetic.

- $c_n$ is attained on the **within-factor pair block** ([Lemma L141](../findings/second-order.md)(b), and confirmed above).
- On every pair block $A'(0)=D(\mathrm{Alt}\,W_-)[H]=0$, [Lemma L133](../findings/second-order.md)'s support table, because $\mathrm{Alt}$ is carried only by entries on four distinct indices and $DW_-$ is entrywise, hence block-preserving. [Lemma L141](../findings/second-order.md)(b) states this itself: "*the defect response vanishes on every block but the $(2,2)$-split four-sets, so on all other blocks $Q=\tfrac12\mathrm{Hess}$*".
- Hence on the direction attaining $c_n$: $A(0)=0$ and $A'(0)=0$, so $(\delta^2)'''(0)=0$ and $\delta^2(t)=O(t^4)$ there. **The entire resolvent/divided-difference half of $C$ is inert on the binding direction.**

So $r_n=c_n/C$ divides a margin taken from one block by a remainder taken from another. That is a legitimate *lower* bound on the radius; it is not a ceiling on anything, and the post's inference ("both halves pinned, therefore the quotient is pinned"), does not go through.

### FINDING 7, what actually sets the exponent is $C_P=O(n)$, a constant the post never names.

Splitting $C$ as the record does, $C\le C_P+C_\delta$ with $C_P\le27(\theta_0+O(1)+O(\sup\lvert P\rvert))$ and $\sup\lvert P\rvert\le n-1$ from [Lemma L107](../findings/bounds.md). Write a unit normal direction as $H$ with $v^2$ the weight on the $(2,2)$-split four-set blocks. Then $\lVert A'(H)\rVert\le\tfrac12v$, so the defect's third-order contribution is $O(n)\,v$, while the second-order margin is at least $c_{\text{pair}}(1-v^2)+c_4v^2$ with $c_{\text{pair}}=\Theta(1/n)$ and $c_4=\Theta(1)$. The direction-wise radius is therefore

$$r_n\;\ge\;6\min_{v\in[0,1]}\frac{c_{\text{pair}}+(c_4-c_{\text{pair}})v^2}{C_P+Knv}.$$

| regime | minimising $v$ | resulting exponent |
| --- | --- | --- |
| $C_P=\Theta(n)$ (today's bound) | $v=0$, the pure pair direction | $\dfrac{\Theta(1/n)}{\Theta(n)}=\Theta(n^{-2})$ |
| $C_P=\Theta(1)$ | $v^*=\Theta(n^{-1/2})$ | $\dfrac{\Theta(1/n)}{\Theta(\sqrt n)}=\Theta(n^{-3/2})$ |

**So the $\Theta(n^{-2})$ the post fences is produced by $\sup\lvert P\rvert\le n-1$ and by nothing else**, at $v=0$ neither divided difference appears. Two consequences:

- **The post's stated reason is not the operative one.** Sharpening $C_\delta$ alone cannot move the exponent (true, and the post is right about that much), but neither can pinning $c_n$; the exponent moves when $\sup\lvert P\rvert$ moves, together with the direction-wise reading of FINDING 6. Both are inside "sharpening the second-order margin or the third-order remainder of the argument in [I2](../plan.md)", the exact activity F60 forbids.
- **$\sup\lvert P\rvert\le n-1$ is very likely off by a factor $n$.** $P$ is odd and $S$ is compact, so $\sup\lvert P\rvert$ is attained at a critical point and equals $\max_{\mathrm{Crit}}\theta$, the programme's own quantity, which every recorded critical point puts at $O(1)$ and which the conjecture puts at $\theta_0(n)\to\sqrt2$. Proving the sharp value would be circular here, but an unconditional crude bound (anything $o(n)$) is a strictly weaker statement than the conjecture and would improve the exponent. **The post rules that out by fiat.**

### FINDING 8, a ceiling on one inequality chain is not a ceiling on $r_n$, and the post's own words slide between the two.

Read in order: the heading claims "*the tube radius at the balanced orbit cannot beat $\Theta(n^{-2})$ by this method*"; "What it fences" narrows to attempts "*by sharpening the second-order margin or the third-order remainder*"; the body then widens again to "*$r_n=c_n/C=\Theta(n^{-2})$ is the ceiling of the method, not a slack estimate*" and "*a better radius needs a different instrument*". $r_n=c_n/C$ is a **sufficient** radius extracted from one Taylor chain with uniform constants. Even with both constants exact, the true radius on which [Conjecture L16](../findings/problem.md) holds about the orbit is bounded below by it and is otherwise unconstrained, if the conjecture is true at all, the inequality holds on the whole sphere and the "radius" is a property of the proof, never of the geometry. The post's three sentences are not interchangeable, and the two broad ones are the ones a successor will act on.

### FINDING 9, "the ball of analyticity, whose radius is the absolute spectral gap $g_n$ and no larger" is asserted, not proved.

$g_n=\lvert\lambda_-\rvert$ is where **Weyl's inequality stops guaranteeing** that no eigenvalue has crossed zero, via $\lVert H\rVert_{\mathrm{op}}\le\lVert H\rVert_F$. The actual obstruction is the distance from $W^*$ to the zero-eigenvalue locus **inside $\mathcal W_n\cap S$**, a constrained distance, bounded below by $g_n$ and never shown equal to it. "No larger" is a claim about the constraint set that the record does not make anywhere and that this post asserts as the second of its two clearing conditions. It may well be true; it is not established, and it is doing fence-post work.

### FINDING 10, one route I tried against the post, which fails, and should be recorded as failing.

The obvious "non-Taylor bound on $\delta^2$" the brief asks about is the global one: $\mathrm{Alt}\circ(\cdot)_-$ is $\tfrac12$-Lipschitz on $\mathcal W_n$ ([Lemma L141](../findings/second-order.md)(a), [Corollary L140.1](../findings/route-a.md)), which is gap-free, in the Hilbert–Schmidt norm a scalar Lipschitz function is operator-Lipschitz with the same constant, so no resolvent is needed. It gives $\delta^2(t)\le t^2/4$ with no third-order term at all. **It fails, and for a reason worth recording**: $\lvert\kappa_n\rvert=\Theta(1)$ while the pair block's margin is $\Theta(1/n)$, so a bound that spends a full $t^2$ on the penalty term loses at second order by a factor $n$. The direction structure ($A'$ supported on $(2,2)$ four-sets alone), is what makes the second-order comparison work, and a uniform Lipschitz bound throws it away. *This is the one thing F60 gets structurally right: the defect's control must be direction-aware. It is also, exactly, why the post's own uniform $c_n/C$ is the wrong object.*

---

## Vacuity

**Non-vacuous, and that is the problem.** F60 forbids a real and currently-planned activity, pinning the absolute constants of [I2](../plan.md)'s Cauchy step and of the passage from $\mathrm{Alt}(W_-)$ to $\delta^2$, and tells the successor in advance that it buys only a constant. On the two constants it names that verdict is right. But the same fence, read as written, also forbids the two moves that do change the exponent: the direction-wise comparison (FINDING 6, available for free since $Q$ is block-additive by [Lemma L141](../findings/second-order.md)(b)'s own opening line) and a better bound on $\sup\lvert P\rvert$ (FINDING 7). Neither needs "a different instrument"; both are the same Taylor argument, read more carefully.

**And the post's closing paragraph undercuts its own stakes.** "*The exponent is what decides whether the tube is worth having*" is followed immediately by the observation that a $\Theta(n^{-2})$ tube covers a vanishing fraction, "*so this route's value was never coverage*", the value being the strict inequality inside. If the value is not coverage, the exponent does not decide the worth, and the fence's importance is stated at odds with its own reasoning.

---

## What the post should say instead

Stated positively, so a successor has something to use:

1. **$c_n=3\theta_0/(n-2)$ is sharp and attained**, on the within-factor pair block; it is $3\theta_0$ (not $6\theta_0$), times the $L_e$ gap $\tfrac12-\lambda_m=\tfrac1{n-2}$. Sharpening it is worthless because it is already sharp.
2. **$(\delta^2)'''(0)=6\langle A''(0),A'(0)\rangle$ is $O(n)$, upper bound only**, from the second divided difference $f^{[2]}=\Theta(n)$ through the Cauchy estimate; the third divided difference $\Theta(n^2)$ enters only the interval bootstrap. Whether $\Theta(n)$ is attained is **open**, and it is the third $\mathrm{Alt}$-cancellation question in the same chain.
3. **The uniform quotient $c_n/C$ is $\Theta(n^{-2})$**, and the exponent in it is carried by $C_P=O(n)$, i.e. by $\sup\lvert P\rvert\le n-1$, which is the crudest constant in the chain, is almost certainly $\Theta(1)$, and is where a successor should look.
4. **A direction-wise comparison, with $\sup\lvert P\rvert$ improved to $O(1)$, gives $\Theta(n^{-3/2})$** by the two-block estimate above, with the same instruments and no new analysis. That is the first thing to try, not the thing to fence.

**As it stands F60 should not be recorded as a fence post.** Its claim (1) is a correct sharpness statement with a factor-$2$ slip; its claim (2) reports an upper bound as a lower bound and misattributes it; its claim (3) does not follow from either, and would close the cheapest available improvement to the very item it is filed under.
