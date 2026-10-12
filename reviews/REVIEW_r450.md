# Review r450, adversarial audit of [Lemma L147](../findings/second-order.md): the corrected disc, the ceiling, and what actually ends the route

*Reviewer r450, 2026-09-03, cold adversarial brief. Target: [Lemma L147](../findings/second-order.md), which re-runs [r447](REVIEW_r447.md)'s displayed chain with [Lemma L146](../findings/second-order.md)'s $\lVert A''\rVert=O(1)$ in place of the direction-blind $O(n)$. Read in full: [Lemma L147](../findings/second-order.md), [Lemma L146](../findings/second-order.md), [Lemma L145](../findings/second-order.md), [Lemma L143](../findings/bounds.md), [Lemma L27](../findings/nondegeneracy.md), [conventions.md](../findings/conventions.md), [r446](REVIEW_r446.md), [r447](REVIEW_r447.md), [r448](REVIEW_r448.md), [r449](REVIEW_r449.md). **Analysis only** ([.claude/rules/analysis-only.md](../.claude/rules/analysis-only.md)): every derivation below is by hand. One screen minimises a self-constructed function on a grid and is reported as a screen; it is evidence for nothing. Working: [agent_logs/r450-L147.log](../agent_logs/r450-L147.log).*

## Verdicts, per claim

| # | claim | verdict |
|---|---|---|
| 1 | Substituting [Lemma L146](../findings/second-order.md)'s $\lVert A''\rVert=O(1)$ into the chain is legitimate | **REFUTED, twice over.** $O(1)$ is not what the corrected Cauchy estimate gives ($O(n^{1/2})$ is, D1), and it is a bound on one of ten summands substituted into an infimum over eight (D2) |
| 2 | The defect cubic branch collapses into the $P$-side because "the denominator is $\sup\lvert P\rvert+u$ with $u\le\tfrac12$, so the minimum sits at $u=0$" | **REFUTED as an argument.** The minimum is interior at every $\beta$ and every $\lVert A''\rVert$; the stated reason is independent of $\lVert A''\rVert$ and would erase [r447](REVIEW_r447.md)'s CONFIRMED $n^{-3/2}$ cap. The *value* is right (D3) |
| 3 | The chain has three branches and the two defect branches "have moved out of the way" | **REFUTED.** There are two: the cubic branch's interior minimum is exactly $\Theta(\min(c_p/\sup\lvert P\rvert,\ \sqrt{c_p}/\lVert A''\rVert))$, so it always carries the quartic branch inside it and can never move out of the way (D3) |
| 4 | $r_n=\Theta(n^{-1-\beta})$ **with no ceiling** | **REFUTED.** The ceiling is $\Theta(n^{-1})$ over the whole normal space, and it sits exactly at the $\beta=0$ value (D4). Separately, "no ceiling" is a claim about $\beta<0$, a region [Lemma L143](../findings/bounds.md)'s companion lower bound $\sup\lvert P\rvert\ge\theta_0(n)$ forbids, **vacuous as framed** (D5) |
| 5 | The lower bound $r_n\gtrsim n^{-1-\beta}$ for $\beta\in[0,\tfrac12]$ | **CONFIRMED as an order**, by a re-minimisation over all eight off-orbit summands that [Lemma L147](../findings/second-order.md) does not perform, and with $\lVert A''\rVert=O(n^{1/2})$ rather than $O(1)$ (D2, D4) |
| 6 | $r_n=\Theta(n^{-1-\beta})$, as an equality | **REFUTED.** The chain gives $\gtrsim$ only; no upper bound on the true tube radius exists. This is the exact error [Lemma L145](../findings/second-order.md) step 4 was corrected for, re-committed two entries later (D6) |
| 7 | $\beta=\tfrac12$ gives $n^{-3/2}$, now pinned by the $P$-side branch alone | **PLAUSIBLE.** The value and the pinning survive the corrected $\lVert A''\rVert$; "$\beta=\tfrac12$, which is [Lemma L143](../findings/bounds.md)" mis-cites an upper bound as a value (D6) |
| 8 | $\beta=0$ gives $\Theta(n^{-1})$, and the radius stays inside the analyticity disc at both values | **REFUTED as a self-consistency check.** $\rho=\Omega(n^{-1/2})$ holds on one summand; on the $\mathrm{Weyl}_p$ directions $\rho=\Theta(n^{-1})$, so at $\beta=0$ the claimed radius has the order of the disc it must sit strictly inside, and a fourth branch the lemma drops binds there (D7) |
| 9 | $\Theta(n^{-1})$ ends the route | **CONFIRMED**, and for a stronger reason than the lemma gives: $n^{-1}$ is the ceiling, not an uncapped evaluation (D4), and it is also where the method's own validity constraint bites (D7) |
| 10 | The improvement is worth having | **VACUOUS in the sense that matters**, unchanged from [r447](REVIEW_r447.md) F6 (D8) |

**The one-line verdict: the headline inequality survives and every reason given for it fails.** $r_n\gtrsim n^{-1-\beta}$ is right on $\beta\in[0,\tfrac12]$; the substitution that produces it is invalid, the branch analysis that supports it is invalid, "no ceiling" is false, "$\Theta$" is unearned, and the self-consistency check is performed against a disc that does not hold where the binding directions are. **The lemma should be rewritten, and its two structural claims (the missing ceiling and the collapsed cubic branch), withdrawn.**

---

## D1, $\lVert A''\rVert=O(1)$ is not what [Lemma L146](../findings/second-order.md) gives, and its two Gate 2 reviewers differ by $\sqrt n$ on exactly this quantity

The substituted value comes from the chain $\lVert H\rVert_{op}=O(n^{-1/2})\Rightarrow\rho=\Omega(n^{-1/2})\Rightarrow\lVert A''\rVert=O(M/\rho^2)=O(1)$, which needs $M=O(g_n)=O(1/n)$ at $\rho=\Theta(n^{-1/2})$.

**$M$ is a supremum over a contour whose radius has just been multiplied by $\sqrt n$, and it moves with it.** With $A(z)=\mathrm{Alt}(W(z)_-)$, $\mathrm{Alt}$ an orthogonal projection ([conventions.md](../findings/conventions.md)) and $x\mapsto x_-$ $1$-Lipschitz in Frobenius norm on Hermitian operators,

$$M=\sup_{\lvert z\rvert=\rho}\lVert A(z)\rVert\;\le\;\lVert W(z)_--W^*_-\rVert_F\;\le\;\lVert W(z)-W^*\rVert_F\;=\;O(\rho).$$

The same figure comes out of [r447](REVIEW_r447.md) F1's own Riesz decomposition with $\rho$ kept as a variable: the first term is $\lVert W(z)-W^*\rVert_F\lVert\Pi\rVert_{op}=O(\rho)\cdot O(1)$, and the second is $\lVert W^*\rVert_{op}\lVert\Pi(z)-\Pi(0)\rVert_F=\Theta(g_n)\cdot O(\rho/g_n)=O(\rho)$, the resolvent identity supplying $\lVert\Pi(z)-\Pi(0)\rVert_F\le\frac{\lvert\Gamma\rvert}{2\pi}\lVert R\rVert_{op}\lVert E\rVert_F\lVert R_0\rVert_{op}=O(g_n)\,O(1/g_n)\,O(\rho)\,O(1/g_n)$. Hence

$$\lVert A''\rVert\;\le\;\frac{2M}{\rho^2}\;=\;O(1/\rho)\;=\;O\!\big(n\,\lVert H\rVert_{op}\big),$$

which is $O(n)$ at the direction-blind $\rho=\Theta(g_n)$ (reproducing the old figure, as it must) and $O(n^{1/2})$, **not $O(1)$**, at $\rho=\Theta(n^{-1/2})$.

**Why the mislabel was invisible.** $M=O(g_n)$ and $M=O(\rho)$ are the same statement at $\rho=\Theta(g_n)$, which is where [r447](REVIEW_r447.md) derived it. [Lemma L146](../findings/second-order.md) carried the label $M=O(g_n)$ onto a disc where $O(\rho)$ is the content. *This is the predecessor's failure mode repeating one level up: a quantity re-used outside the regime that established it.*

**[r448](REVIEW_r448.md) and [r449](REVIEW_r449.md) contradict each other here, and [Lemma L146](../findings/second-order.md) took one side silently.** [r448](REVIEW_r448.md) D8 writes *"With disc $\rho$ and $M=O(\rho)$, Cauchy gives $\lVert A''\rVert=O(M/\rho^2)=O(1/\rho)$"* and lands on $O(n^{1/2})$, with the quartic branch moving to $\Theta(n^{-1})$. [r449](REVIEW_r449.md) V5 writes *"$\lVert A^{(k)}\rVert\le k!M/\rho^k$ with $M=O(g_n)$ unchanged"* and lands on $O(1)$, with the quartic branch staying at $\Theta(n^{-1/2})$. Both reviews are cited in [Lemma L146](../findings/second-order.md)'s header as having CONFIRMED the order-level conclusion; **they confirmed different conclusions, differing by $\sqrt n$ on the single number [Lemma L147](../findings/second-order.md) exists to substitute.** [Lemma L146](../findings/second-order.md) records $O(1)$ from [r449](REVIEW_r449.md) and then states the resulting radius as $\Theta(n^{-1})$, which is [r448](REVIEW_r448.md)'s number, and is what $O(n^{1/2})$ gives. **The lemma's own conclusion is inconsistent with its own substituted constant**, and [Lemma L147](../findings/second-order.md) resolved the inconsistency the wrong way, keeping $O(1)$ and pushing the quartic branch to $n^{-1/2}$.

**Which is right: [r448](REVIEW_r448.md).** Nothing keeps $\lVert W(z)-W^*\rVert_F$ at $O(g_n)$ once the contour has radius $\rho\gg g_n$, the perturbation *is* of size $\rho$. One could hope to do better on this summand, where $A'(0)=0$ (see D2) makes $A(z)=O(z^2)$, but bounding $M$ by $\rho^2\sup\lVert A''\rVert$ and then bounding $\lVert A''\rVert$ by $2M/\rho^2$ is circular and yields nothing. **$O(1/\rho)$ is what is proved; $O(1)$ is not.**

## D2, the substitution is a one-summand bound put into an eight-summand infimum, and on that summand the $u$-range is a single point

**The quantifier.** $r_n=\inf_H r(H)$ over $H\in T_{W^*}S\cap T_{W^*}\mathcal O^\perp$, which by [Lemma L27](../findings/nondegeneracy.md) is eight of the ten summands ($\langle W\rangle$ and the orbit summand $\mathbb R^p\otimes\mathbb R^q$ being removed). [Lemma L146](../findings/second-order.md) prices $\lVert H\rVert_{op}$ on **one** of them. [r448](REVIEW_r448.md) D9 and [r449](REVIEW_r449.md) V6 both flagged that the re-minimisation is owed and that low-rank Weyl tensors padded into $\mathrm{Weyl}_p$ have $\lVert H\rVert_{op}/\lVert H\rVert_F=\Theta(1)$, hence $\rho=\Theta(g_n)$ and $\lVert A''\rVert=O(n)$, the direction-blind estimate, with no room in it. **[Lemma L147](../findings/second-order.md) is the re-run those two reviews named, and it performs no re-minimisation: it replaces a direction-blind constant by another direction-blind constant, read off one summand.**

**Worse, the $u$-range and the substituted constant come from disjoint sets of directions.** [Lemma L146](../findings/second-order.md)'s load-bearing claim is that the summand is diagonal on coordinate $2$-planes, hence $v=0$, hence, through $u\le\tfrac{\sqrt2}3v$ ([Lemma L133](../findings/second-order.md) step 2), that the summand **is** the $u=0$ branch. So on the only directions where $\lVert A''\rVert=O(1)$ is even claimed, $u\equiv0$; and the minimisation $\min_{0\le u\le1/2}$ that [Lemma L147](../findings/second-order.md) carries out with that constant ranges over directions where it has not been established. *The displayed minimum is a hybrid object corresponding to no direction of the sphere.*

**The re-minimisation, done.** Let $w$ be the Frobenius weight of a unit $H$ outside the two $S^2_0(\mathbb R^m)$ copies. Two exact facts, no interpolation:

- **The margin is exactly additive over the summands.** $c(H)=3\theta_0\langle(\tfrac12-L_e)H,H\rangle=\sum_j3\theta_0(\tfrac12-\lambda_j)\lVert H_j\rVert^2$, and [Lemma L27](../findings/nondegeneracy.md)'s eigenvalue list gives $\tfrac12-\lambda_j=\Theta(1/n)$ on $S^2_0(\mathbb R^m)$ alone and $\Theta(1)$ on all six other off-orbit summands ($\pm\mu$ with $\mu=1/(m-1)$, and $0$ on $\mathrm{Weyl}_p$, $\mathrm{Weyl}_q$, $X_p\otimes\mathbb R^q$, $X_q\otimes\mathbb R^p$). So $c(H)=\Theta(c_p+w^2)$ **exactly**, where [r449](REVIEW_r449.md) V6 could only assume it.
- **The operator norm obeys a triangle inequality.** $\lVert H\rVert_{op}\le\lVert H_{S^2_0}\rVert_{op}+\lVert H_{\mathrm{rest}}\rVert_{op}\le O(n^{-1/2})+w$, the second step by $\lVert\cdot\rVert_{op}\le\lVert\cdot\rVert_F$. Only this direction of the estimate is needed for a lower bound on $r_n$, so [r449](REVIEW_r449.md) V6's caveat about the unproved $\asymp$ does not bite.

Together, $\lVert A''(H)\rVert=O(n\lVert H\rVert_{op})=O(n^{1/2}+nw)$ by D1. **This is the sweep [Lemma L147](../findings/second-order.md) owes**, and it is carried out in D4.

## D3, the cubic branch: the minimum is interior at every $\beta$, and the stated reason proves too much

Write $S=\sup\lvert P\rvert$, $a=\lVert A''\rVert$, $f(u)=(c_p+u^2)/(S+au)$ on $[0,\tfrac12]$. Then $f'$ has the sign of $au^2+2Su-ac_p$, which is negative at $u=0$ and increasing, so $f$ **decreases and then increases**: the critical point is a minimum and it is interior. Explicitly

$$u^*=\frac{\sqrt{S^2+a^2c_p}-S}{a}\in(0,\sqrt{c_p}\,],\qquad f(u^*)=\frac{2u^*}{a}=\frac{2\big(\sqrt{S^2+a^2c_p}-S\big)}{a^2},$$

the identity $f(u^*)=2u^*/a$ following from $2u^*(S+au^*)=a(c_p+u^{*2})$, and $u^*\le\sqrt{c_p}\le\tfrac12$ from $\sqrt{S^2+a^2c_p}\le S+a\sqrt{c_p}$, so the minimum is interior **for every $S>0$, every $a>0$ and every $n\ge4$**, never at the endpoint $u=0$ and never at $u=\tfrac12$.

**[Lemma L147](../findings/second-order.md)'s reason is invalid, and demonstrably so.** The reason given (*"the denominator is $\sup\lvert P\rvert+u$ with $u\le\tfrac12$, so the minimum sits at $u=0$"*), never uses the value of $a$. Applied at $a=n$ it would report $f(0)=c_p/S$ and so deny [r447](REVIEW_r447.md)'s interior minimum at $u^*=\Theta(n^{-1/2})$ with value $\Theta(n^{-3/2})$, the cap both [r447](REVIEW_r447.md) and this audit confirm. **An argument that would refute a confirmed result is not an argument.**

**The correct statement, which rescues the value.** Squeezing $\sqrt{X+Y}-\sqrt X$ between $Y/2\sqrt{X+Y}$ and $Y/2\sqrt X$ gives

$$f(u^*)\;=\;\Theta\!\Big(\min\big(c_p/S,\ \sqrt{c_p}/a\big)\Big),$$

so the cubic branch equals the $P$-side value $c_p/S$ **exactly when $a\sqrt{c_p}\lesssim S$**, i.e. $a\lesssim n^{\beta+1/2}$. At $a=n$ that is $\beta\ge\tfrac12$, reproducing [r447](REVIEW_r447.md)'s threshold; at $a=n^{1/2}$ it holds for all $\beta\ge0$, borderline at $\beta=0$; at $a=1$ it holds throughout. **So the conclusion "the cubic branch collapses into the $P$-side" is correct at the corrected $a=n^{1/2}$ and for $\beta\ge0$, and it is correct because $a$ has fallen, which is the one thing the lemma's stated reason does not mention.**

**A structural consequence the lemma's table misses.** $f(u^*)$ carries $\sqrt{c_p}/a$ inside its own minimum, so the cubic branch is never better than the quartic branch, and the outer $\min$ over the two collapses:

$$r_n\;\gtrsim\;\Theta\Big(\min\big(c_p/\sup\lvert P\rvert,\ \sqrt{c_p}/\lVert A''\rVert\big)\Big).$$

**The chain has two branches, not three, and "the cap was the two defect branches, and both have moved out of the way" is impossible in principle**: the cubic branch's interior minimum always shadows the quartic one.

> **Screen** (self-constructed, seconds; evidence for nothing, and it can fail, it minimises $f$ on a $2\times10^6$-point grid rather than re-evaluating the closed form). At $n\in\{10^2,10^4,10^6\}$, $\beta\in\{0,\tfrac14,\tfrac12\}$ and $a\in\{1,\sqrt n,n\}$ the grid argmin is interior in all $27$ cases and agrees with $u^*$ and $f(u^*)$ above to grid resolution. At $n=10^4$, $\beta=0$, $a=n$: $f(0)=1.00\times10^{-4}$ against a true minimum $1.98\times10^{-6}\approx2n^{-3/2}$, the lemma's reasoning would be wrong by $n^{1/2}$ at the one place [r447](REVIEW_r447.md)'s cap lives.

## D4, the ceiling is $\Theta(n^{-1})$, over the whole normal space

Substituting D2's sweep into D3's two-branch form. With $c(H)=\Theta(c_p+w^2)$ and $\lVert A''(H)\rVert=O(n^{1/2}+nw)$:

**Quartic branch.** $\dfrac{\sqrt{c(H)}}{\lVert A''(H)\rVert}=\Theta\!\left(\dfrac{\sqrt{n^{-1}+w^2}}{n^{1/2}+nw}\right)$. For $w\le n^{-1/2}$ this is $\Theta(n^{-1/2}/n^{1/2})=\Theta(n^{-1})$; for $w\ge n^{-1/2}$ it is $\Theta(w/(nw))=\Theta(n^{-1})$. **It is $\Theta(n^{-1})$ uniformly in $w\in[0,1]$**, the two regimes meet, with no dip between them.

**Cubic branch.** $\Theta(\min(c(H)/S,\sqrt{c(H)}/\lVert A''\rVert))\ge\Theta(\min(n^{-1}/S,\ n^{-1}))=\Theta(n^{-1-\beta})$ for $S=\Theta(n^\beta)$, $\beta\ge0$.

**Hence**

$$r_n\;\gtrsim\;\Theta\big(\min(n^{-1-\beta},\,n^{-1})\big)\;=\;\Theta(n^{-1-\beta})\quad\text{for }\beta\ge0 .$$

**The headline inequality is CONFIRMED as an order**, and the lemma's own account of why is wrong at every step: the quartic branch does not sit at $\Theta(n^{-1/2})$, it sits at $\Theta(n^{-1})$; the ceiling is not absent, it is $\Theta(n^{-1})$; and the reason the two agree at $\beta=0$ is that the ceiling is **attained** there, not that it is missing. *[Lemma L147](../findings/second-order.md)'s "no ceiling" and its "$\Theta(n^{-1})$ ends the route" are not merely opposite-facing, as the brief suspected, the second is true because the first is false.*

**One caveat, inherited and unavoidable.** $\lVert A''\rVert$ enters through an upper bound, so what is established is that the chain's cap **is lost** at $n^{-3/2}$ and **relocated** to $n^{-1}$, not that $n^{-1}$ is attained by the true tube radius. Whether Cauchy is saturated is [r443](REVIEW_r443.md)'s open item (iii), untouched here as in [r447](REVIEW_r447.md), [r448](REVIEW_r448.md) and [r449](REVIEW_r449.md).

## D5, $\beta\ge0$ is forced, so "for every $\beta\ge0$, with no ceiling" quantifies over an empty improvement

$\sup\lvert P\rvert\ge\lvert P(W^*)\rvert=\theta_0(n)$ with $\theta_0(n)^2=2(n-1)(n-2)/n^2$ ([conventions.md](../findings/conventions.md)), increasing to $\sqrt2$ and equal to $1.2361$ at $n=12$. **So $\sup\lvert P\rvert=\Omega(1)$ and $\beta\ge0$ unconditionally**, the brief's conjecture, CONFIRMED. Together with [Lemma L143](../findings/bounds.md)'s $\sup\lvert P\rvert\le1+\sqrt{n-2}$, the true $\beta$ lies in $[0,\tfrac12]$.

**A ceiling can only bind where $n^{-1-\beta}$ would exceed it, i.e. at small $\beta$.** With the lemma's erroneous quartic value $n^{-1/2}$ that would need $\beta<-\tfrac12$; with the corrected $n^{-1}$ it needs $\beta<0$. Both regions are empty. **So "no ceiling" is a true-sounding statement about a region the problem forbids, and it purchases nothing**, while being false as stated, since the ceiling exists and is exactly the endpoint value. *The framing does not survive: what the lemma should say is that the ceiling has moved from $n^{-3/2}$ to $n^{-1}$ and now coincides with the best reachable $\beta$.*

## D6, "$\Theta$" is unearned, and it is the error [Lemma L145](../findings/second-order.md) was corrected for

The chain is a **lower bound**: $r_n\gtrsim\min(\cdots)$, every ingredient an upper bound on a tail. A $\Theta$ asserts in addition that the tube radius is no larger, which needs a direction on which the functional actually fails at that scale. Nobody has one. [Lemma L145](../findings/second-order.md)'s own table records the correction (*"$r_n=\Omega(n^{-3/2})$), CONFIRMED as a lower bound. The equality reading is withdrawn"*, and [r447](REVIEW_r447.md) F5 spells out why ("*a $\Theta$ needs a lower bound on the true failure radius, which no one has*"). **[Lemma L147](../findings/second-order.md) writes $\Theta$ in its statement box, in both of its worked values, and in its closing sentence, two entries after the withdrawal.**

**A second citation defect in the same paragraph.** "*$\beta=\tfrac12$, which is [Lemma L143](../findings/bounds.md)*" reads an **upper** bound on $\sup\lvert P\rvert$ as its order. The substitution is conservative and the resulting $r_n\gtrsim n^{-3/2}$ is sound, but $\beta=\tfrac12$ is not known, only $\beta\le\tfrac12$. And "*$\beta=0$, which is [I31](../plan.md)*" is an open plan item, not a value on the record. **The two are presented as "the two values on the record"; one is a proved upper bound and the other is an aspiration.**

## D7, the self-consistency check is run against a disc that does not hold where the binding directions are, and a fourth branch is dropped

**The check as written.** *"The radius stays inside the analyticity disc at both values, $n^{-3/2}$ and $n^{-1}$ against $\rho=\Omega(n^{-1/2})$."* But $\rho=\Omega(n^{-1/2})$ is [Lemma L146](../findings/second-order.md)'s conclusion **on the $S^2_0$ summand**. On the $\mathrm{Weyl}_p$ directions of [r448](REVIEW_r448.md) D9 ($\lVert H\rVert_{op}=\Theta(1)$), the disc is $\rho=\Theta(g_n)=\Theta(n^{-1})$. **At $\beta=0$ the claimed radius $\Theta(n^{-1})$ has the same order as the disc it must sit strictly inside.** The check passes only because it is taken against the largest disc rather than the smallest, which is the wrong end for an infimum.

**The dropped branch.** The Cauchy estimate at an intermediate base point $s$ along the segment is $\lVert A''(s)\rVert\le2M/(\rho-\lvert s\rvert)^2$, so the uniform remainder that [r447](REVIEW_r447.md) F4 relies on needs $t\le\rho/2$. The honest chain therefore carries a fourth term,

$$r_n\;\gtrsim\;\min\Big(\underbrace{c_p/\sup\lvert P\rvert}_{\text{$P$-side}},\ \underbrace{\sqrt{c_p}/\lVert A''\rVert}_{\text{defect}},\ \underbrace{\rho/2}_{\text{validity}}\Big),$$

and $\inf_H\rho(H)/2=\Theta(g_n)=\Theta(n^{-1})$. **At $\beta=0$ this branch binds up to a constant**, so the $\Theta(n^{-1})$ is not merely the end of the route but the boundary of the method's own domain of validity, reachable only if the constants work out, which nobody has checked. *This is not circularity in the fixed-point sense the brief asks about: $\rho$ does not depend on $r_n$, so there is no equation to solve, only a constraint to respect. But the constraint is dropped, and it is active exactly at the value the lemma advertises.*

**At $\beta=\tfrac12$ the check passes** ($n^{-3/2}\ll n^{-1}$) so the defect is confined to the $\beta=0$ end, which is the end the lemma is about.

## D8, vacuity

**The lemma is not vacuous logically**, for the reason [r447](REVIEW_r447.md) F6 gives: $\kappa_n<0$ for $n\ge12$ makes the tube statement $P+\lvert\kappa_n\rvert\delta^2\le\theta_0$ strictly stronger than local maximality, so the balanced orbit is a genuine equality case rather than an artefact.

**It is vacuous in the sense that matters, and unchanged from $n^{-3/2}$.** The nearest other critical point, $S^{m-1}\times S^{m+1}$, sits at distance $O(1)$ ([I20](../plan.md)), so a tube of radius $\Theta(n^{-1})$ contains no competitor, as one of radius $n^{-3/2}$ did not, and as [r443](REVIEW_r443.md) D6 observed, nor would one of radius $\tfrac12$. The orbit has dimension $\Theta(n^2)$ inside a sphere of dimension $\Theta(n^4)$, so the covered fraction vanishes at either exponent. **The half-power [I31](../plan.md) buys moves the tube from one vanishing fraction to another**, and scenario $(\gamma)$ (which is the conjecture), carries exactly what it carried before. *A further comparison the brief asks for: at $\beta=0$ the radius equals the order of $g_n$, the spectral gap, so the tube is no longer small compared with the scale on which the whole analytic apparatus is built. That is the substantive reason the route ends, and it is a better one than the lemma's.*

---

## What I could not break

- **The $P$-side branch is untouched by the substitution**, as the lemma's table says: $c_p/\sup\lvert P\rvert$ never contained $\lVert A''\rVert$.
- **The lower bound $r_n\gtrsim n^{-1-\beta}$ on $\beta\in[0,\tfrac12]$**, re-derived in D4 over all eight off-orbit summands with the corrected $\lVert A''\rVert=O(n^{1/2})$. Both of the lemma's worked values, $n^{-3/2}$ at $\beta=\tfrac12$ and $n^{-1}$ at $\beta=0$, come out, as lower bounds.
- **"$\Theta(n^{-1})$ ends the route."** Confirmed twice over, by the relocated ceiling (D4) and by the validity constraint (D7).
- **No fixed point is being assumed away.** $C_\delta$ and $\lVert A''\rVert$ depend on $\rho$ and $\lVert H\rVert_{op}$, neither of which depends on $r_n$; the range $u\le\tfrac12$ comes from $u\le\tfrac{\sqrt2}3v$ and $v\le1$, not from the radius. The chain is a plain minimum, not a self-referential one.
- **[Lemma L27](../findings/nondegeneracy.md)'s eigenvalue list**, used in D2 to show $S^2_0(\mathbb R^m)$ is the only off-orbit summand with $o(1)$ margin.

## What this audit did not check

[Lemma L27](../findings/nondegeneracy.md)'s ten summand values and multiplicity-freeness, [Lemma L133](../findings/second-order.md)'s $u\le\tfrac{\sqrt2}3v$, [Lemma L141](../findings/second-order.md)'s $c_p=3\theta_0/(n-2)$, [Lemma L143](../findings/bounds.md)'s proof, and [Lemma L146](../findings/second-order.md)'s corrected extremal problem (as fixed by [r448](REVIEW_r448.md) D3 and [r449](REVIEW_r449.md)) are taken as given; each carries its own Gate 2. Whether $\lVert A''\rVert$ is **saturated** at $O(M/\rho^2)$, [r443](REVIEW_r443.md)'s open item (iii), remains untouched, so D4's ceiling is a ceiling on what this chain can prove, not on the true tube radius.

## What to change

1. **Withdraw "with no ceiling."** The ceiling is $\Theta(n^{-1})$, established over the whole normal space in D4, and it coincides with the $\beta=0$ value.
2. **Correct the substituted constant** to $\lVert A''\rVert=O(n^{1/2})$, from $M=O(\rho)$ and $\lVert A''\rVert=O(1/\rho)=O(n\lVert H\rVert_{op})$, and record that $M=O(g_n)$ was a statement about the small disc. Fix [Lemma L146](../findings/second-order.md)'s $O(1)$ at the same time, and record that [r448](REVIEW_r448.md) and [r449](REVIEW_r449.md) disagree by $\sqrt n$ here.
3. **Replace the branch table with the two-branch form** $r_n\gtrsim\Theta(\min(c_p/\sup\lvert P\rvert,\ \sqrt{c_p}/\lVert A''\rVert))$, and delete the claim that the cubic branch's minimum sits at $u=0$: it is interior at $u^*=(\sqrt{S^2+a^2c_p}-S)/a$ with value $2u^*/a$, at every $\beta$ and every $a$.
4. **Carry the summand sweep of D2**, $c(H)=\Theta(c_p+w^2)$ exactly from [Lemma L27](../findings/nondegeneracy.md), $\lVert H\rVert_{op}\le O(n^{-1/2})+w$ by the triangle inequality, which discharges the step [r448](REVIEW_r448.md) D9 and [r449](REVIEW_r449.md) V6 both left open.
5. **Downgrade every $\Theta$ to $\Omega$**, as [Lemma L145](../findings/second-order.md) step 4 already was, and state $\beta\in[0,\tfrac12]$ with $\beta\ge0$ forced by $\sup\lvert P\rvert\ge\theta_0(n)$ and $\beta\le\tfrac12$ by [Lemma L143](../findings/bounds.md). Stop describing $\beta=0$ as a value on the record.
6. **Add the validity branch $\rho/2$** and say that at $\beta=0$ it binds up to a constant, so $\Theta(n^{-1})$ is the boundary of the method rather than a value inside it.
