# Review r451, adversarial audit of [Lemma L147](../findings/second-order.md): the corrected disc, the ceiling, and the substitution that carries them

*Reviewer r451, 2026-09-03, cold adversarial brief. Target: [Lemma L147](../findings/second-order.md), the re-run of [r447](REVIEW_r447.md)'s displayed chain with [Lemma L146](../findings/second-order.md)'s $\lVert A''\rVert=O(1)$ in place of the direction-blind $O(n)$. Read in full: [Lemma L147](../findings/second-order.md), [Lemma L146](../findings/second-order.md), [Lemma L145](../findings/second-order.md), [Lemma L143](../findings/bounds.md), [conventions.md](../findings/conventions.md), [REVIEW_r446.md](REVIEW_r446.md), [REVIEW_r447.md](REVIEW_r447.md), [REVIEW_r448.md](REVIEW_r448.md), [REVIEW_r449.md](REVIEW_r449.md). **Analysis only** ([analysis-only.md](../.claude/rules/analysis-only.md)), every result below is derived by hand; one numerical screen evaluates a function I did not derive in closed form (a grid minimisation, checked against a closed form derived separately) and is reported as a screen and is evidence for nothing. Working: [agent_logs/r451-L147.log](../agent_logs/r451-L147.log).*

## Verdicts, per claim

| # | claim | verdict |
|---|---|---|
| 1 | substituting [Lemma L146](../findings/second-order.md)'s $\lVert A''\rVert=O(1)$ into the chain is legitimate | **REFUTED, twice over.** The bound is priced on one of [Lemma L27](../findings/nondegeneracy.md)'s ten summands and used inside an infimum over all of them (A1); and the value $O(1)$ is itself wrong by $\sqrt n$ even there, because $M$ is a supremum over the disc and the disc grew (A2) |
| 2 | $\lVert H\rVert_{op}=O(n^{-1/2})\Rightarrow\rho=\Omega(n^{-1/2})\Rightarrow\lVert A''\rVert=O(M/\rho^2)=O(1)$ | **REFUTED.** $M=O(\rho)$, so $\lVert A''\rVert=O(1/\rho)=O(n^{1/2})$. [r448](REVIEW_r448.md) D8 derives exactly this; [r449](REVIEW_r449.md) V5 holds $M=O(g_n)$ fixed, and L147 adopted the second without recording the disagreement (A2) |
| 3 | the defect-cubic branch collapses into the $P$-side because its minimum sits at $u=0$ | **REFUTED as reasoning, CONFIRMED in order.** $u=0$ is never the minimum at any $\beta$; the minimum is interior at $u^*=(\sqrt{S^2+a^2c_p}-S)/a$ with value $2u^*/a$, which is $\asymp c_p/S$ whenever $a^2c_p\ll S^2$, true at every $\beta\ge0$, $\beta=0$ included (A3) |
| 4 | $r_n=\Theta(n^{-1-\beta})$ for every $\beta\ge0$, **with no ceiling** | **REFUTED.** There are four ceilings, all at $\Theta(n^{-1})$, and the $\beta=0$ value sits on all four (A4). The $\Theta$ is separately unwarranted: the chain is a lower bound and $\beta$ is not a determined exponent (A6) |
| 5 | at $\beta=\tfrac12$ the value $n^{-3/2}$ is unchanged and now pinned by the $P$-side branch alone | **CONFIRMED**, and it survives the corrected $\lVert A''\rVert$ (A5) |
| 6 | at $\beta=0$ the value is $\Theta(n^{-1})$ | **PLAUSIBLE as an $\Omega$ with an unpinned constant, and it is at the edge of the method's validity**, $\Theta(n^{-1})$ is the same order as the direction-blind analyticity radius, so the Cauchy constants stop being absolute exactly there (A5, A7) |
| 7 | $\Theta(n^{-1})$ ends the route | **CONFIRMED**, and for three reasons rather than the one given (A4) |
| 8 | $\beta\ge0$ is forced | **CONFIRMED.** $\sup\lvert P\rvert\ge P(W^*)=\theta_0(n)\to\sqrt2$ (A4) |
| 9 | the radius stays inside the analyticity disc at both values | **CONFIRMED at $\beta=\tfrac12$, REFUTED as checked at $\beta=0$**, the check is run against a disc that holds on one summand and fails on the directions that bind (A7) |

**The one-line verdict: the two numbers survive as lower bounds and every reason given for them is wrong.** $r_n=\Omega\big(\min(c_p/\sup\lvert P\rvert,\ n^{-1})\big)$ is what the corrected chain gives (the same $n^{-3/2}$ at $\beta=\tfrac12$ and the same $n^{-1}$ at $\beta=0$) but the mechanism is not the one L147 states, the defect branches have **not** moved out of the way, and the headline "with no ceiling" is false at the same value the lemma's own closing sentence calls the end of the route. **The lemma should be rewritten around the ceiling, not around its removal.**

**A finding that is stronger than the lemma's own and still does not save it (A8).** On the margin summand the defect vanishes *identically* along the great circle, $W^*$ and $H$ are simultaneously diagonal on coordinate $2$-planes, so $W(t)_-$ is too, so $\mathrm{Alt}(W(t)_-)=0$ entrywise at every $t$. So $\delta\equiv0$ and **both** defect branches are absent there, which is far more than $\lVert A''\rVert=O(1)$. It buys nothing, because the infimum is not on that summand: it is on the mixed directions, which nobody has priced.

---

## A1, the substitution is made where the bound is not proved, and this is the whole lemma

The chain's $\min_{0\le u\le1/2}$ is a bookkeeping device for $\inf_H$ over $H\in T_{W^*}S\cap T_{W^*}\mathcal O^\perp$ with $u=\lVert A'(0)[H]\rVert$. [Lemma L146](../findings/second-order.md) bounds $\lVert H\rVert_{op}$ **on the two $S^2_0(\mathbb R^m)$ summands of [Lemma L27](../findings/nondegeneracy.md)'s ten**. Substituting a summand-local bound into a whole-space infimum is a quantifier error of the shape this record has already numbered twice, [r448](REVIEW_r448.md) D9 and [r449](REVIEW_r449.md) V6 both flag it against [Lemma L146](../findings/second-order.md) itself, and L147 is the step where the flag becomes load-bearing rather than editorial.

**Directions where the bound fails are exhibited on the record.** [r448](REVIEW_r448.md) D9 and [r449](REVIEW_r449.md) V6 both name a low-rank Weyl tensor padded into the first factor (a $\mathbb{CP}^2$-type element in $\mathrm{Weyl}_p$), with $\lVert H\rVert_{op}/\lVert H\rVert_F=\Theta(1)$, hence disc $\Theta(g_n)=\Theta(n^{-1})$ and $\lVert A''\rVert=O(n)$, the direction-blind estimate with no room in it.

**Why "those directions have a bigger margin" does not close it.** It is true that the seven other off-orbit summands carry margin $\Theta(1)$ rather than $c_p=\Theta(1/n)$, and both reviewers of [Lemma L146](../findings/second-order.md) checked that no *single* other summand undercuts $\Theta(n^{-1})$. But the infimum runs over **mixed** directions, and the chain's own worst case is exactly a mixed one: a direction whose defect modulus is $u\asymp n^{-1/2}$ while its margin is still $\Theta(1/n)$. **At that direction, $\lVert A''\rVert=\Theta(n)$ would restore $n^{-3/2}$ at every $\beta$**, the screen below returns $\Theta(n^{-3/2})$ for $(a,S)=(n,\Theta(1))$, which is the $\beta=0$ column. So the lemma's conclusion does not survive its own substitution unless the mixed directions are priced, and L147 prices none of them.

**They can be priced, and the answer is not the lemma's.** Write $H=H_s+H_r$ with $H_s$ in the joint $\lambda_m$-eigenspace and $\lVert H_r\rVert_F=w$. Two facts close the sweep:

- **The operator norm interpolates, by the triangle inequality alone.** $\lVert H\rVert_{op}\le\lVert H_s\rVert_{op}+\lVert H_r\rVert_{op}\le\Theta(n^{-1/2})+w$, using [Lemma L146](../findings/second-order.md)'s corrected supremum $1/\sqrt{m-1}$ ([r448](REVIEW_r448.md) D3, [r449](REVIEW_r449.md) V3) and $\lVert\cdot\rVert_{op}\le\lVert\cdot\rVert_F$. Hence $\rho=\Omega\big(g_n/\max(n^{-1/2},w)\big)$ and, by A2, $\lVert A''\rVert=O\big(n\max(n^{-1/2},w)\big)$.
- **The margin interpolates, because $L_e$ is a scalar on each summand.** $c(H)=c_p\lVert H_s\rVert^2+\sum_{j\ne s}c_j\lVert H_j\rVert^2$ with every $c_j=\Theta(1)$ ([r449](REVIEW_r449.md) V4), so $c(H)\gtrsim c_p+\Theta(1)w^2$, and $u\le\tfrac{\sqrt2}3v\lesssim w$.

Sweeping $w$ through $[0,1]$ with $S=\sup\lvert P\rvert$: the cubic branch $(c_p+w^2)/(S+n\max(n^{-1/2},w)w)$ is $\Theta(n^{-1})$ at $\beta=0$ and $\Theta(n^{-3/2})$ at $\beta=\tfrac12$; the quartic branch $\sqrt{c_p+w^2}/\lVert A''\rVert$ is $\Theta(n^{-1})$ **uniformly in $w$**, $\sqrt{c_p}/n^{1/2}$ at $w\le n^{-1/2}$ and $w/(nw)$ beyond it. *This is the re-run L147 claims to be, done with the bound A2 supplies rather than the one L146 asserts.* It returns the lemma's two values and a $\Theta(n^{-1})$ ceiling.

## A2, $M$ is a supremum over the disc, and the disc grew: $\lVert A''\rVert=O(n^{1/2})$, not $O(1)$

This is the arithmetic error, and it is one factor $\sqrt n$.

Cauchy reads $\lVert A''(0)\rVert\le2M/\rho^2$ with $M=\sup_{\lvert z\rvert=\rho}\lVert A(z)\rVert$. **$M$ is not a constant of the point; it is a function of $\rho$.** Running [r447](REVIEW_r447.md) F1's own derivation with $\rho$ left symbolic, and using $\mathrm{Alt}(W^*_-)=0$ with $\lVert\mathrm{Alt}\rVert\le1$ and $W_-=-W\Pi$:

$$\lVert A(z)\rVert\;\le\;\underbrace{\lVert W(z)-W^*\rVert_F\,\lVert\Pi(z)\rVert_{op}}_{O(\rho)\cdot O(1)}\;+\;\underbrace{\lVert W^*\rVert_{op}\,\lVert\Pi(z)-\Pi(0)\rVert_F}_{\Theta(g_n)\cdot O(\rho/g_n)}\;=\;O(\rho),$$

since $\lVert W(z)-W^*\rVert_F=\lvert z\rvert\lVert H\rVert_F+O(z^2)=O(\rho)$ at $\lVert H\rVert_F=1$, and the resolvent identity gives $\lVert\Pi(z)-\Pi_0\rVert_F\le\frac{\lvert\Gamma\rvert}{2\pi}\lVert R\rVert_{op}\lVert E\rVert_F\lVert R_0\rVert_{op}=O(g_n)\cdot O(1/g_n)\cdot O(\rho)\cdot O(1/g_n)$. **Every term scales with $\rho$**, so

$$\lVert A''\rVert\;=\;O(M/\rho^2)\;=\;O(1/\rho).$$

**The check that this is the right reading**: at the direction-blind $\rho=\Theta(g_n)$ it returns $O(1/g_n)=O(n)$, which is [r447](REVIEW_r447.md)'s and the record's own figure. The claim $M=O(g_n)$ is not a fact about $A$; it is $M=O(\rho)$ evaluated at $\rho=\Theta(g_n)$.

**So on the margin summand, where $\rho=\Omega(n^{-1/2})$, the Cauchy bound is $\lVert A''\rVert=O(n^{1/2})$.** Getting $O(1)$ needs $\rho=\Omega(1)$, i.e. $\lVert H\rVert_{op}=O(g_n)=O(n^{-1})$, which is [r446](REVIEW_r446.md) D6's actual mechanism, stated there as "*along a direction of small operator norm it is $\Theta(1)$ rather than $\Theta(g_n)$ … the *best* case is a $\Theta(1)$ radius, attained by any direction whose $\Lambda^2$ spectrum is as flat as $W^*$'s own*". [Lemma L146](../findings/second-order.md) answers the weaker test D6 *also* wrote down ("if it is $o(1)$ there"), and $o(1)$ is not $O(g_n)$: $\Theta(n^{-1/2})$ meets the letter of the test and misses its mechanism by exactly the $\sqrt n$ recovered here.

**The two Gate-2 reviewers of [Lemma L146](../findings/second-order.md) disagree on precisely this, and L147 took the wrong one without saying so.** [r448](REVIEW_r448.md) D8: "*With disc $\rho$ and $M=O(\rho)$, Cauchy gives $\lVert A''\rVert=O(M/\rho^2)=O(1/\rho)$, which reproduces $O(n)$ at the direction-blind $\rho=\Theta(g_n)$. At $\rho=\Theta(n^{-1/2})$ it is $O(n^{1/2})$*", with the quartic branch landing at $\Theta(n^{-1})$. [r449](REVIEW_r449.md) V5: "*A larger analyticity disc $\rho$ gives $\lVert A^{(k)}\rVert\le k!M/\rho^k$ with $M=O(g_n)$ unchanged*", giving $O(1)$ and a quartic branch at $\Theta(n^{-1/2})$. **L147's table row "defect quartic … $\sqrt{c_p}/\Theta(1)=\Theta(n^{-1/2})$" is [r449](REVIEW_r449.md) V5's number**, and [r448](REVIEW_r448.md) D8's contradicting number appears nowhere in the lemma. A lemma written to fold in a Gate 2 must fold in both reviewers or record which it rejects and why.

## A3, the cubic branch: $u=0$ is never the minimum, and the order is right anyway

L147's table says the cubic branch "*collapses into the $P$-side: the denominator is $\sup\lvert P\rvert+u$ with $u\le\tfrac12$, so the minimum sits at $u=0$*". Differentiate. With $S=\sup\lvert P\rvert$, $a=\lVert A''\rVert$ and $f(u)=(c_p+u^2)/(S+au)$ on $[0,\tfrac12]$,

$$f'(u)=\frac{2u(S+au)-a(c_p+u^2)}{(S+au)^2},\qquad f'(0)=-\frac{ac_p}{S^2}<0 .$$

**$f$ is strictly decreasing at $u=0$ at every $\beta$ and every $a>0$**, so the endpoint is never the minimiser. Setting the numerator to zero gives $au^2+2Su-ac_p=0$, hence

$$u^*=\frac{\sqrt{S^2+a^2c_p}-S}{a},\qquad f(u^*)=\frac{2u^*}{a}=\frac2{a^2}\big(\sqrt{S^2+a^2c_p}-S\big),$$

the second equality from the stationarity relation $a(c_p+u^2)=2u(S+au)$. When $a^2c_p\ll S^2$ this is $f(u^*)\to c_p/S$, the $P$-side value, approached from below and never reached. **At $\beta=0$, which the brief singles out, $a^2c_p=\Theta(1/n)$ against $S^2=\Theta(1)$**, so the separation is a factor $1+O(1/n)$ and the order is unaffected. The same holds with the corrected $a=\Theta(n^{1/2})$: $a^2c_p=\Theta(1)$ against $S^2=\Theta(1)$, so the two differ by a constant, not an order (the screen returns $1.09\times10^{-2}$ against $c_p/S=1.52\times10^{-2}$ at $n=200$).

**So the row's conclusion holds in order and its stated reason is false.** It matters because the reason is what a successor will re-use: "the minimum sits at $u=0$" is what makes the defect branches look absent, and they are not absent, they are subordinate, by a margin that is a constant at $\beta=0$ and shrinks to nothing if $a$ grows.

> **Screen** (self-constructed, seconds; evidence for nothing). Grid-minimising $f$ over $4\times10^6$ points of $[0,\tfrac12]$ at $n\in\{200,2000\}$, $S\in\{\theta_0,\sqrt n\}$, $a\in\{1,\sqrt n,n\}$: the argmin is interior in all twelve cases and agrees with the closed $u^*$ above to six digits, with value $2u^*/a$. Scaling: at $(a,S)=(\sqrt n,\theta_0)$ the minimum runs $1.09\times10^{-2}\to1.08\times10^{-3}$, i.e. $\Theta(n^{-1})$; at $(a,S)=(n,\theta_0)$ it runs $1.39\times10^{-3}\to4.54\times10^{-5}$, i.e. $\Theta(n^{-3/2})$, the collapse A1 warns of. *The grid was built from the branch expression, not from the closed form it is checked against, so a wrong closed form would have shown.*

## A4, "no ceiling" is false four times over, and one of the four is the lemma's own branch

L147 asserts "*$r_n=\Theta(n^{-1-\beta})$ … for every $\beta\ge0$, with no ceiling*" and, eight lines later, "*$\Theta(n^{-1})$ is the end of this route*". The second is right. Four independent bounds put the route's ceiling at $\Theta(n^{-1})$:

- **The $P$-side branch caps itself, by one line.** $\sup\lvert P\rvert\ge P(W^*)=\theta_0(n)$ and $c_p=3\theta_0/(n-2)$, so
  $$\frac{c_p}{\sup\lvert P\rvert}\;\le\;\frac{3\theta_0}{(n-2)\theta_0}\;=\;\frac3{n-2}\;=\;\Theta(n^{-1})$$
  **at every $n$, unconditionally on any bound for $P$.** The branch L147 calls uncapped is capped, and by its own two ingredients. *This is the sharpest form of the objection: "no ceiling" is refuted without leaving the row of the table that carries it.*
- **The corrected quartic branch** (A2) is $\sqrt{c_p}/\Theta(n^{1/2})=\Theta(n^{-1})$, not $\Theta(n^{-1/2})$, and the sweep of A1 keeps it there for every $w$.
- **The validity cap, which no version of the chain displays.** The Cauchy bound on $\lVert A''(s)\rVert$ at real base points $\lvert s\rvert\le t$ needs $t\le\rho/2$, so $r(H)\le\rho(H)/2$ for every $H$, and the infimum inherits the *smallest* disc: $\rho=\Theta(g_n)$ on the $\Theta(1)$-operator-norm directions of A1. **$r_n=O(g_n)=O(n^{-1})$ for this method, whatever the branches say.**
- **$\beta\ge0$ is forced**, which the brief asks to be confirmed and which is confirmed: $\theta_0(n)^2=2(n-1)(n-2)/n^2\to2$, so $\sup\lvert P\rvert\ge\theta_0\to\sqrt2$ and $\sup\lvert P\rvert=\Theta(n^\beta)$ admits no $\beta<0$. Together with [Lemma L143](../findings/bounds.md)'s $\beta\le\tfrac12$, the entire admissible range is $\beta\in[0,\tfrac12]$ and the entire radius range is $[n^{-3/2},n^{-1}]$.

**So "with no ceiling" is not merely unproved; it is a statement about a region ($\beta<0$) that the objects forbid, made about a branch that is capped inside the region they allow.** The framing survives only as: *the two former defect ceilings at $n^{-3/2}$ are lifted to $n^{-1}$, where three further ceilings sit and coincide.*

## A5, the two recorded values, restated with what actually supports them

| $\beta$ | L147's value | this audit | what pins it |
|---|---|---|---|
| $\tfrac12$ ([Lemma L143](../findings/bounds.md)) | $\Theta(n^{-3/2})$ | $\Omega(n^{-3/2})$, **CONFIRMED** | the $P$-side branch alone, as L147 says: with $\lVert A''\rVert=O(n^{1/2})$ the quartic branch sits at $\Theta(n^{-1})$ and the cubic minimum at $\Theta(n^{-3/2})$ from $c_p/S$ |
| $0$ ([I31](../plan.md)) | $\Theta(n^{-1})$ | $\Omega(n^{-1})$ **with an unpinned constant, at the edge of validity** | all four ceilings of A4 at once, so the constant decides whether the statement has content |

The $\beta=\tfrac12$ row is the one place where L147's reasoning and this audit's agree, and it agrees for the reason L147 gives.

## A6, $\Theta$ is the wrong quantifier, twice

- **The chain is a lower bound.** [r447](REVIEW_r447.md) writes $r_n\gtrsim\min\min(\cdot)$ and [Lemma L145](../findings/second-order.md)'s own step-4 row reads "*CONFIRMED as a lower bound. The equality reading is withdrawn*". L147 writes $r_n=\Theta(n^{-1-\beta})$ with no upper bound on the true tube radius anywhere in the chain, and repeats it in both bulleted values. It should read $\Omega$.
- **$\beta$ is not a determined exponent.** What is known of $\sup\lvert P\rvert$ is the bracket $\theta_0(n)\le\sup\lvert P\rvert\le1+\sqrt{n-2}$ ([Lemma L143](../findings/bounds.md)), which does not assert power-law behaviour at all. The honest statement carries $\sup\lvert P\rvert$ itself: $r_n=\Omega\big(\min(c_p/\sup\lvert P\rvert,\ n^{-1})\big)$, from which the two rows of A5 follow by substituting the bracket's ends. **Writing $\Theta(n^{-1-\beta})$ turns a bound on an unknown quantity into an exponent it does not have.**

## A7, self-consistency: the check at $\beta=0$ is run against the wrong disc, and there is no circularity

**The check as performed.** L147 closes: "*The radius stays inside the analyticity disc at both values, $n^{-3/2}$ and $n^{-1}$ against $\rho=\Omega(n^{-1/2})$*". The disc $\rho=\Omega(n^{-1/2})$ is [Lemma L146](../findings/second-order.md)'s, proved **on the margin summand**. The directions that set the infimum are not on it (A1), and there $\rho=\Theta(g_n)=\Theta(n^{-1})$.

- **At $\beta=\tfrac12$ the check passes on any disc.** $n^{-3/2}$ against $\Theta(n^{-1})$ is a factor $n^{-1/2}\to0$, which is [r446](REVIEW_r446.md) D7's own verification.
- **At $\beta=0$ it fails as checked and is at best marginal as repaired.** $r_n=\Theta(n^{-1})=\Theta(g_n)$ puts the tube at a *fixed fraction* of the smallest analyticity radius. [r446](REVIEW_r446.md) D7 anticipated exactly this: "*an improvement to $\Theta(n^{-1})$ would put the tube at a fixed fraction of the analyticity radius, where the Cauchy constants stop being absolute*". Since no constant in the chain is pinned, [r446](REVIEW_r446.md) D7 again, "*'explicit' is still unmet … an $\Omega$ with an unpinned absolute Cauchy constant $K$*", **the $\beta=0$ conclusion is not established at the level where it would have to be checked.** It is a statement whose truth depends entirely on constants nobody has computed.

**No circularity.** I looked for the fixed point the brief asks about and it is not there: $C_\delta$ does not enter the displayed chain at all, [r447](REVIEW_r447.md) F2 uses the tails $\delta^2\le u^2t^2+2Knut^3+K^2n^2t^4$ directly, and the $C_\delta=6\langle A''(0),A'(0)\rangle$ of [Lemma L145](../findings/second-order.md) is evaluated at the base point, with no $\lVert A\rVert=O(r)$ feeding back. **What is there instead is an undisplayed constraint**, $r_n\le\rho/2$, which is a cap rather than a fixed point (A4, third bullet) and which the chain should carry as a third argument of its own $\min$.

## A8, the defect vanishes identically on the margin summand, which is stronger than the lemma and still does not save it

$W^*$ is a linear combination of $\mathrm{id}$, $P_{\Lambda^2V_1}$ and $P_{\Lambda^2V_2}$, hence diagonal in the coordinate-$2$-plane basis of any frame adapted to $\mathbb R^n=V_1\oplus V_2$. $H$ is diagonal in the same basis for the frame diagonalising $h$ inside $V_1$, the one structural claim of [Lemma L146](../findings/second-order.md) that both its reviewers confirmed ([r448](REVIEW_r448.md) D1, [r449](REVIEW_r449.md) V1), and rotating inside $V_1$ fixes $W^*$. So $W(t)=\cos t\,W^*+\sin t\,H$ is diagonal in one fixed coordinate-plane basis for all $t$, real or complex; its Riesz projection and hence $W(t)_-$ are diagonal in the same basis; and a coordinate-plane-diagonal tensor has $T_{ijkl}\ne0$ only for $\{i,j\}=\{k,l\}$, so every component on four distinct indices vanishes and $\mathrm{Alt}(W(t)_-)=0$ ([conventions.md](../findings/conventions.md); the argument is [r447](REVIEW_r447.md) F1's, applied along the circle rather than at the base point).

$$\boxed{\ A(t)\equiv0\ \text{ and }\ \delta\equiv0\ \text{ along every great circle in the }S^2_0(\mathbb R^m)\text{ summand.}\ }$$

**Consequences, and they cut against the lemma rather than for it.**

- On that summand there is no defect branch to bound: $u=0$ and $A''=0$ exactly, so the local radius is $c_p/\sup\lvert P\rvert$ outright, with no $\lVert A''\rVert$ in it at any value.
- **So [Lemma L146](../findings/second-order.md)'s operator-norm computation is beside the point on its own summand** (it bounds the Cauchy estimate for a quantity that is identically zero there) and the whole content of the re-run lives on the mixed directions, which is where neither L146 nor L147 looks. [r449](REVIEW_r449.md) V6 says the same thing in the language of an unpriced sweep; this is why the sweep is the entire question.
- It also removes the only reading under which "the defect branches have moved out of the way" could be true: they have not moved, they are simply absent on one summand and unchanged in order on the rest.

## A9, vacuity: the improvement is real, buys nothing, and its input is a weak form of the target

- **Not vacuous as a statement.** With $\kappa_n<0$ for $n\ge12$, the tube statement $P+\lvert\kappa_n\rvert\delta^2\le\theta_0$ is strictly stronger than local maximality of $P$ ([r447](REVIEW_r447.md) F6), and the balanced orbit is a genuine equality case.
- **Vacuous as a gain.** The nearest catalogued critical orbit $S^{m-1}\times S^{m+1}$ is at distance $\Theta(1)$ ([I20](../plan.md)), so a tube of radius $n^{-3/2}$, $n^{-1}$, or any $r<1$ alike contains no competitor. The orbit has dimension $\Theta(n^2)$ inside a sphere of dimension $\Theta(n^4)$ ($36$ inside $S^{1637}$ at $n=12$) so coverage is a vanishing fraction at either exponent, and scenario (γ), which is the conjecture, carries everything identically before and after. **Both prior audits say this** ([r446](REVIEW_r446.md) D7, [r447](REVIEW_r447.md) F6) and L147 records neither.
- **And the input at $\beta=0$ is of the same nature as the target.** $\sup\lvert P\rvert=\Theta(1)$ is a global bound on the very functional the programme is trying to bound globally; Conjecture A asserts $\sup P=\theta_0=\Theta(1)$ exactly. It is genuinely weaker than the conjecture (a constant rather than the constant) but "the only thing that still moves the radius" is a qualitative form of the thing being proved, and the lemma's "**[I31](../plan.md) buys a full half-power, and it is now the only thing that moves the radius**" should say so.

---

## What I could not break

- **The $\beta=\tfrac12$ row**, including its stated reason. With the corrected $\lVert A''\rVert$ the $P$-side branch pins $\Theta(n^{-3/2})$ and both defect branches sit above it, exactly as L147 says.
- **The direction of the disc effect.** A larger disc gives smaller derivative bounds gives a larger local radius; nothing enters with the opposite sign ([r449](REVIEW_r449.md) V5 first paragraph, re-checked here). The error in L147 is the *size* of the effect, not its sign.
- **The margin identity.** $3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)=c_p$ at $p=q=m$, taken from [r448](REVIEW_r448.md) D6 and [r449](REVIEW_r449.md) V4 and re-checked: $n-2=2(m-1)$ and $\tfrac12-\lambda_m=\tfrac1{2(m-1)}$.
- **$u=0$ on the summand**, and now more than that (A8).
- **The claim that the former $n^{-3/2}$ *defect* ceilings are lifted.** They are, to $\Theta(n^{-1})$, not out of existence.

## What this audit did not check

[Lemma L27](../findings/nondegeneracy.md)'s ten summand values and multiplicity-freeness, [Lemma L133](../findings/second-order.md)'s support table (used only through $u\le\tfrac{\sqrt2}3v$), [Lemma L141](../findings/second-order.md)'s $c_p$, [Lemma L143](../findings/bounds.md)'s proof, and [Lemma L146](../findings/second-order.md)'s corrected embedding and extremal problems were taken as given, each carries its own Gate 2. I re-derived only what combines them: the $\rho$-dependence of $M$, the cubic branch's calculus, the $w$-sweep of A1, the four ceilings, and the identical vanishing of A8. **Whether $\lVert A''\rVert$ is *saturated* at $O(M/\rho^2)$ anywhere, [r443](REVIEW_r443.md)'s open item (iii), remains untouched**, so every figure above is an upper bound on a denominator: this audit establishes that the ceiling is $\Theta(n^{-1})$ and that $\Theta(n^{-1/2})$ is unsupported, not that $\Theta(n^{-1})$ is attained. **A sharper $M$ is the one live resource**: $M=O(\rho)$ uses only $\lVert H\rVert_F=1$, and on a direction of small off-summand weight $w$ the true $M$ may be $O(w\rho)$, which would raise the ceiling above $n^{-1}$. Nobody has tried it.

## What to change

1. **Strike "with no ceiling"** and replace the headline with $r_n=\Omega\big(\min(c_p/\sup\lvert P\rvert,\ n^{-1})\big)$, recording that the $P$-side branch is itself capped at $3/(n-2)$ because $\sup\lvert P\rvert\ge\theta_0$ (A4). The "ends the route" sentence then carries the whole paragraph instead of contradicting its own opening.
2. **Correct the quartic row to $\sqrt{c_p}/\Theta(n^{1/2})=\Theta(n^{-1})$**, and state $\lVert A''\rVert=O(1/\rho)$ once, with the reason: $M$ is a supremum over the disc (A2). Record that [r448](REVIEW_r448.md) D8 and [r449](REVIEW_r449.md) V5 give different values and that D8's is the one that reproduces the record's own $O(n)$ at $\rho=\Theta(g_n)$.
3. **Correct the cubic row**: the minimum is interior at $u^*=(\sqrt{S^2+a^2c_p}-S)/a$ with value $2u^*/a$, asymptotic to $c_p/S$ from below (A3). Delete "the minimum sits at $u=0$".
4. **Carry the $w$-sweep** of A1, or state plainly that the substitution is licensed on one of ten summands and that the lemma assumes the infimum stays there. It is the difference between $n^{-1}$ and $n^{-3/2}$.
5. **Replace $\Theta$ with $\Omega$ throughout**, and say $\sup\lvert P\rvert$ rather than $\Theta(n^\beta)$ (A6).
6. **Add the validity cap $r_n\le\rho/2$** as a third argument of the $\min$, and redo the self-consistency check against the *smallest* disc rather than the summand's (A7). Record that at $\beta=0$ the tube sits at a fixed fraction of the analyticity radius, where the unpinned Cauchy constants decide the statement.
7. **Record A8** (the defect vanishes identically on the margin summand) as the reason [Lemma L146](../findings/second-order.md)'s operator-norm bound is not where the question lives.
8. **Add one line on what the exponent buys**: nothing, at either value ([r446](REVIEW_r446.md) D7, [r447](REVIEW_r447.md) F6), and the $\beta=0$ input is a qualitative form of the target (A9).
