# VERIFY v14, Lemma L149, the uniformity proof and the coefficient it is executed at

*Cold brief: one question about one step, no other verifier's report read, nothing under [reviews/](../reviews/) or [scripts/](../scripts/) touched. **No script was run.** Every number below is an exact closed form evaluated by hand from the record's own definitions, quoted to seven or eight significant figures; each comparison that carries a finding is also given as an exact inequality between surds. Log: [agent_logs/verify-L149-v14.log](../agent_logs/verify-L149-v14.log).*

| # | Claim under test | Verdict |
|---|---|---|
| 1 | The margin bullet's $3\theta_0\frac{m-4}{2(m-1)}$ and the blockquote's $\rho_n^{\mathrm{eff}}$ are the same quantity | **PARTLY, SAME UP TO THE PENALTY.** $n=2m$ makes the bullet's coefficient exactly $\rho_n=3\theta_0\frac{n-8}{2(n-2)}$; $\rho_n^{\mathrm{eff}}$ is that minus $\tfrac29\lvert\kappa_n\rvert$ |
| 2 | The closing proof is executed at $w^2$-coefficient $1$ | **CONFIRMED.** $g(w)=\sqrt{c+w^2}/(A+Bw)$, and both displayed values are the $\rho=1$ instances |
| 3 | A computation at coefficient $1$ bounds the true minimum from below when $\rho<1$ | **REFUTED, IT BOUNDS FROM ABOVE.** $\inf g_\rho=\tfrac1n\sqrt{\rho\kappa/(\rho+\kappa)}$ is strictly increasing in $\rho$ |
| 4 | The displayed $\tfrac1n\sqrt{\kappa/(1+\kappa)}$ bounds the branch the block's inputs define | **REFUTED at $n=12,14,16$**, by $11.5\%$, $5.0\%$, $1.0\%$; valid from $n=18$ |
| 5 | The blockquote's $\tfrac1n\sqrt{\kappa(n-8)/(3n-8)}$ is "a valid but lossy lower bound" | **REFUTED from $n=14$.** Valid at $n=12$ only; at $n=16$ the failure reduces exactly to $105>96$ |
| 6 | $w^*=Bc/A$ lies in $[0,1]$ over the lemma's range | **REFUTED.** $w^*\le1\iff n^2-20n+18\ge0\iff n\ge10+\sqrt{82}$, i.e. $n\ge20$ |
| 7 | "The stationary point is outside $[0,1]$ at every dimension in range" | **REFUTED from $n=18$**, and it contradicts its own preceding clause from $n=16$ |
| 8 | The block computes the minimum that actually governs when $w^*>1$ | **PARTLY.** It names the endpoint values at coefficient $1$ and never at $\rho$ |
| 9 | $A=n^{1/2}$ is the constant the record's own [Lemma L146](../findings/second-order.md) gives | **REFUTED.** The record gives $A=a_0n^{1/2}$, $a_0=\sqrt{2n/(n-2)}$, again the unsafe direction, order-neutral |
| 10 | The boxed conclusion, branch 2 is $\Omega(n^{-1})$ uniformly in $w\in[0,1]$ | **TRUE, and provable in one line the block does not write.** $\ge0.714/n$ at every even $n\ge12$ |
| 11 | $\ker W^*=0$, the hypothesis the whole branch rests on | **HOLDS, INHERITED, UNSTATED HERE.** Supplied 300 lines above at [line 893](../findings/second-order.md); L149 never repeats it |
| 12 | The smallest admissible dimension | **INCONSISTENT.** The lemma says $m\ge5$ ($n=10$); the file's own Setting says $n=2m\ge12$, and $\lvert\kappa_n\rvert=9(\theta_0-\sqrt{3/2})$ is negative at $n=10$ |
| 13 | $\beta$ | **CONSISTENT AND UNUSED.** Branch 2 carries no $\beta$; the boxed $r_n\gtrsim n^{-1-\beta}$ needs $\beta\ge0$, which is [Lemma L147](../findings/second-order.md)'s and is not restated |

**Verdict: GAP.** The conclusion is true; the block contains no correct proof of it, and the two values it offers in place of one fail on complementary ranges that cover every dimension the lemma is about except $n=12$.

**One line the round can act on:** replace both displayed values by $\inf_{w\ge0}g_\rho=\tfrac1n\sqrt{\rho\kappa/(\rho a_0^2+\kappa)}$ with $\rho=\rho_n^{\mathrm{eff}}$, one substitution, valid at every $n$, worth $\ge0.714/n$, and delete the sentence claiming the stationary point is outside $[0,1]$ over the range.

## 0. Conventions, fixed once

Every symbol below is the record's, taken from the places named, and none is introduced by me.

| Symbol | Value | Where the record fixes it |
|---|---|---|
| $n$, $m$ | $n=2m$, the ambient dimension against the sphere factor $S^m\times S^m$ | [line 887](../findings/second-order.md) Setting, and L149's own "at $p=q=m$" |
| $\theta_0(n)$ | $\sqrt{2(n-1)(n-2)}/n$ | [conventions.md](../findings/conventions.md), [problem.md](../findings/problem.md) |
| $c_p$ | $3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)$ | [line 1129](../findings/second-order.md), [Lemma L146](../findings/second-order.md) Setting |
| $\kappa$ | $nc_p=3\sqrt{2(n-1)/(n-2)}$, decreasing to $3\sqrt2$ | [line 1261](../findings/second-order.md), L158's blockquote |
| $\kappa_n$ | $9(\sqrt{3/2}-\theta_0(n))$, so $\lvert\kappa_n\rvert=9\lvert\theta_0-\sqrt{3/2}\rvert$ | [line 893](../findings/second-order.md), [problem.md](../findings/problem.md) |
| $\rho_n$ | $3\theta_0\frac{n-8}{2(n-2)}$, the margin coefficient before the penalty | L149's margin bullet, in $m$; L149's blockquote, in $n$ |
| $\rho_n^{\mathrm{eff}}$ | $\rho_n-\tfrac29\lvert\kappa_n\rvert$ | L149's blockquote |
| $g_n$ | $\sqrt{2(n-2)}/(n\sqrt{n-1})$, the gap from $0$ to $\mathop{\mathrm{spec}}W^*$ | [line 893](../findings/second-order.md), and $1/g_n=n^2c_p/6$ at [L158](../findings/second-order.md) |
| $g_\rho(w)$ | $\sqrt{c_p+\rho w^2}/(A+Bw)$, $A=n^{1/2}$, $B=n$ as L149 writes them | L149's "Proof of the uniformity" |

**Two symbols collide inside the block and are unrelated.** $\kappa$ is $nc_p\approx4.45$; $\kappa_n$ is the defect-penalty constant, $\lvert\kappa_{12}\rvert=0.1015$. L158 records the collision explicitly; L149 does not, and the proof's $c=\kappa/n$ is never said to be $c_p$.

**The identity that closes the first question.** With $n=2m$,
$$3\theta_0\frac{m-4}{2(m-1)}=3\theta_0\frac{(n-8)/2}{2(n-2)/2}=3\theta_0\frac{n-8}{2(n-2)}=\rho_n,$$
so the bullet's $m$-form and the blockquote's $n$-form are one quantity. Three independent checks fix this reading: the bullet's own numbers, "the coefficient is $0.7416$ at $n=12$ and $0.9463$ at $n=14$, reaching $1$ only from $n=16$", are $\rho_{12},\rho_{14},\rho_{16}$ exactly; "at $\rho=0$, which is $m=4$" is $n=8$, the zero of $\frac{n-8}{2(n-2)}$; and "reaching $\ge\tfrac34\theta_0$ only from $m=5$" reads off $3\theta_0\frac{m-3}{2(m-1)}$ at $m=5$.

**A closed form for the effective coefficient that the block does not print, and which reproduces all four of its values.** Since $\tfrac29\lvert\kappa_n\rvert=2(\theta_0-\sqrt{3/2})$ for $n\ge12$,
$$\rho_n^{\mathrm{eff}}=\theta_0\left[\frac{3(n-8)}{2(n-2)}-2\right]+2\sqrt{3/2}=\sqrt6-\frac{(n+16)\,\theta_0(n)}{2(n-2)}=\sqrt6-\frac{(n+16)\,\kappa}{6n}.$$
Evaluating: $\rho^{\mathrm{eff}}_{12}=\sqrt6-1.4\cdot1.2360331=0.7190434$; $\rho^{\mathrm{eff}}_{14}=\sqrt6-1.25\cdot1.2616800=0.8723896$; $\rho^{\mathrm{eff}}_{16}=\sqrt6-\tfrac87\cdot1.2808689=0.9856396$; and $\rho^{\mathrm{eff}}_\infty=\sqrt6-\tfrac{\sqrt2}2=1.7423829$. These are the block's $0.71904$, $0.87239$, $0.98564$, $1.74238$, digit for digit, which is what licenses every identification in the table above.

**And it is monotone, by inspection of that form.** $\frac{n+16}{6n}=\frac16+\frac8{3n}$ and $\kappa=3\sqrt{1+\frac1{n-2}}\cdot\sqrt2$ are both positive and decreasing in $n$, so their product decreases and $\rho_n^{\mathrm{eff}}$ increases, from $0.7190434$ at $n=12$ to $1.7423829$. That is the fact the uniformity ultimately needs, and it is nowhere on the page.

## Hypothesis inventory

**Stated in the block.**

- $m\ge5$, carried in the lemma's own statement and in the margin bullet's "reaching $\ge\tfrac34\theta_0$ only from $m=5$".
- $\lVert H\rVert_F=1$, in the margin bullet, and it is what makes the margin a convex combination.
- $H=H_s+H_r$ with $H_s$ in the **joint** two-copy $\lambda_m$-eigenspace and $w=\lVert H_r\rVert$ the weight outside both, so $w\in[0,1]$.
- $S=\sup\lvert P\rvert=\Theta(n^\beta)$, named just above the displayed chain.
- $\lVert H_s\rVert_{op}=\Theta(n^{-1/2})$, by [Lemma L146](../findings/second-order.md), with the two-copy application defended against the missing $\sqrt2$.

**Used and not stated.**

- $\ker W^*=0$ as an operator on $\Lambda^2$. This is the hypothesis the whole branch rests on: $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$ is differentiable along $W^*+tH$ only where $W\mapsto W_-$ is analytic, which needs $0$ off the spectrum. The record supplies it at [line 893](../findings/second-order.md), "two eigenvalues … Hence a spectral gap at $0$ of relative size $\tfrac{m-1}{2m-1}$, so $W\mapsto W_-$ is real-analytic near $W^*$", and the absolute gap is $g_n=\sqrt{2(n-2)}/(n\sqrt{n-1})$, which is $0.1123660$ at $n=12$ and agrees exactly with the record's own $1/g_n=n^2c_p/6$. So the hypothesis **holds and is on file**; L149 inherits it silently.
- $\lVert H_r\rVert_{op}\le\lVert H_r\rVert_F=w$, used inside the triangle inequality of the first bullet.
- $\rho(H)\asymp g_n/\lVert H\rVert_{op}$ with $g_n=\Theta(n^{-1})$. This is the whole content of "Hence $\lVert A''\rVert=O(1/\rho)=O(n^{1/2}+nw)$": without it, $\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w$ implies nothing about $\lVert A''\rVert$. [L158](../findings/second-order.md) traces it as $\rho=\gamma g_n/\lVert H\rVert_{op}$; L149 states neither the relation nor the citation.
- $\rho_n^{\mathrm{eff}}$ bounded away from $0$ over the range. Needed for the word "uniformly"; supplied only as four sample values.
- $\beta\ge0$, needed for the boxed $r_n\gtrsim n^{-1-\beta}$ to follow from an $\Omega(n^{-1})$ second branch. It is [Lemma L147](../findings/second-order.md)'s $\sup\lvert P\rvert\ge\theta_0$ and is not restated here. Branch 2 itself contains no $\beta$.

**Inconsistent with the file.** The lemma's $m\ge5$ is $n\ge10$; the file's Setting fixes $n=2m\ge12$, i.e. $m\ge6$, and at $n=10$ the block's own $\lvert\kappa_n\rvert=9(\theta_0-\sqrt{3/2})$ is $-0.2227$, a negative absolute value, because $\theta_0(10)=1.2$ sits below $\sqrt{3/2}$. The penalty formula is therefore ill-formed at the smallest dimension the lemma admits. At $n=10$ the true $\kappa_n$ has the other sign, so the term is a bonus and subtracting $\tfrac29\lvert\kappa_n\rvert$ is merely conservative; the conclusion is untouched, the arithmetic is not defined as printed.

## 1. Which coefficient each part uses

The three parts of the block use three different coefficients, and the lines say so.

The margin bullet, [line 1194](../findings/second-order.md):

> $c(H)\ge c_p+3\theta_0\tfrac{m-4}{2(m-1)}\,w^2$

The blockquote, [line 1204](../findings/second-order.md):

> the coefficient carried into the chain is $\rho_n^{\mathrm{eff}}=3\theta_0\frac{n-8}{2(n-2)}-\frac29\lvert\kappa_n\rvert$

The displayed chain, [line 1198](../findings/second-order.md), and the closing proof, [line 1211](../findings/second-order.md):

> $r(H)\gtrsim\min\!\left(\frac{c_p+w^2}{S},\ \frac{\sqrt{c_p+w^2}}{n^{1/2}+nw},\ \frac{\rho(H)}2\right)$
>
> With $g(w)=\sqrt{c+w^2}/(A+Bw)$, $c=\kappa/n$, $A=n^{1/2}$, $B=n$, *the repaired form carries $\rho_n$ on the $w^2$, treated in the blockquote above*

So: bullet at $\rho_n$, blockquote at $\rho_n^{\mathrm{eff}}$, chain and proof at $1$. The first two are the same quantity up to the penalty; the third is neither. The parenthetical is an explicit acknowledgement and an explicit deferral, and section 5 tests whether the place it defers to discharges the debt.

**A second, smaller inconsistency inside the bullet itself.** It gives the coefficient as $\frac{m-4}{2(m-1)}$ and then says "the smallest off-summand margin is the $+\mu$ one, $3\theta_0\frac{m-3}{2(m-1)}$", a strictly larger number for every $m$. The blockquote resolves it: the attaining summand is $\Lambda^2\!\otimes\!\Lambda^2$, not the $+\mu$ one. The bullet's word "smallest" is therefore attached to the wrong summand, and since the coefficient it actually uses is the smaller of the two, the error runs the safe way.

## 2. The direction of the error, derived rather than assumed

Write $g_\rho(w)=\sqrt{c+\rho w^2}/(A+Bw)$ on $w\ge0$, with $c,\rho,A,B>0$. Differentiating and clearing the positive factor $\sqrt{c+\rho w^2}(A+Bw)^2$,
$$\mathop{\mathrm{sign}}g_\rho'(w)=\mathop{\mathrm{sign}}\Big[\rho w(A+Bw)-B(c+\rho w^2)\Big]=\mathop{\mathrm{sign}}\big(\rho Aw-Bc\big),$$
the $\rho Bw^2$ terms cancelling. So $g_\rho$ falls then rises, with its single stationary point at
$$w^*_\rho=\frac{Bc}{\rho A},\qquad c+\rho w^{*2}_\rho=c\,\frac{\rho A^2+B^2c}{\rho A^2},\qquad A+Bw^*_\rho=\frac{\rho A^2+B^2c}{\rho A},$$
whence
$$g_\rho(w^*_\rho)=\sqrt{\frac{\rho c}{\rho A^2+B^2c}}\;\overset{c=\kappa/n,\;A^2=n,\;B=n}{=}\;\frac1n\sqrt{\frac{\rho\kappa}{\rho+\kappa}}.$$
At $\rho=1$ this is the block's $w^*=\kappa n^{-1/2}$ and $\tfrac1n\sqrt{\kappa/(1+\kappa)}$, so the block's algebra is right at the coefficient it uses.

**The comparison.** $\dfrac{\partial}{\partial\rho}\dfrac{\rho\kappa}{\rho+\kappa}=\dfrac{\kappa^2}{(\rho+\kappa)^2}>0$, so $\rho\mapsto\inf g_\rho$ is **strictly increasing**. Equivalently and more simply: $\rho\le1$ gives $g_\rho\le g_1$ pointwise, hence $\min_{[0,1]}g_\rho\le\min_{[0,1]}g_1$. **A value computed at coefficient $1$ therefore bounds the true minimum from above whenever $\rho<1$, the wrong direction for a lower bound.** The exact loss is
$$\frac{\inf g_\rho}{\inf g_1}=\sqrt{\frac{\rho(1+\kappa)}{\rho+\kappa}},$$
which at $n=12$, where $\rho^{\mathrm{eff}}=0.7190434$ and $\kappa=4.4497190$, is $\sqrt{0.7580}=0.870653$: the written proof's value is $14.9\%$ above the value at the block's own coefficient.

**The charitable reading, and it is a real one.** $g_\rho=\sqrt\rho\cdot\tilde g$ where $\tilde g$ has the proof's exact shape with $\kappa$ replaced by $\kappa/\rho$. So the proof is a **correct template with a parameter it declines to instantiate**, not a false calculation; the mechanism (one interior stationary point, closed form, endpoints), is untouched by the coefficient. What is not saved by this reading is the two *displayed values*, which are the $\rho=1$ instances and which section 4 shows are not lower bounds where it matters.

**And the direction is not uniform in $n$.** $\rho^{\mathrm{eff}}_n<1$ exactly at $n\in\{12,14,16\}$ and $\rho^{\mathrm{eff}}_n>1$ from $n=18$ ($\rho^{\mathrm{eff}}_{18}=1.0727$), by the monotonicity of section 0. So the coefficient-$1$ computation is unsafe on exactly the three dimensions the block's own r716 blockquote already flags, and conservative above them. That coincidence is worth stating plainly, because it is the reason the order conclusion never came under threat.

## 3. Whether $w^*$ lies in $[0,1]$

**At the proof's own coefficient.** $w^*=Bc/A=\kappa n^{-1/2}$, so
$$w^*\le1\iff\kappa\le\sqrt n\iff9\cdot\frac{2(n-1)}{n-2}\le n\iff n^2-20n+18\ge0\iff n\ge10+\sqrt{82}=19.0554,$$
i.e. $n\ge20$ over the even integers. At $n=12$, $w^*=4.4497190/3.4641016=1.2845$. **So the proof's phrase "a single interior minimum" is false at $n=12,14,16,18$**, half a dozen lines after the block itself has computed $w^*>1$ in another notation.

**At $\rho_n$.** $\kappa/\rho_n=2n/(n-8)$ identically ($\theta_0$ cancels) so $w^*=2\sqrt n/(n-8)$ and $w^*\le1\iff n-2\sqrt n-8\ge0\iff(\sqrt n-1)^2\ge9\iff n\ge16$, with equality at $n=16$. This is the block's own computation and it is correct.

**At $\rho_n^{\mathrm{eff}}$.** $w^*\le1\iff\kappa\le\rho^{\mathrm{eff}}\sqrt n$, which with $q:=\sqrt{2(n-1)/(n-2)}$ (so $\kappa=3q$ and $\rho^{\mathrm{eff}}=\sqrt6-\frac{(n+16)q}{2n}$) rearranges to
$$q\left(n+6\sqrt n+16\right)\le2\sqrt6\,n.$$
At $n=16$: $1.4638501\cdot56=81.9756$ against $78.3837$, fails, $w^*=1.11389$. At $n=18$: $1.4577380\cdot59.4558=86.6668$ against $88.1816$, holds, $w^*=0.96094$. Since the left side is $\sim\sqrt2\,n$ and the right is $2.4494897\,n$, it holds for every larger $n$. **So the stationary point is interior from $n=18$ onwards.**

## 4. What the minimum actually is, and whether the block computes it

$g_\rho$ is strictly decreasing on $[0,w^*_\rho]$, so when $w^*_\rho>1$ the minimum over $[0,1]$ is the right endpoint,
$$\min_{[0,1]}g_\rho=g_\rho(1)=\frac{\sqrt{c_p+\rho}}{n^{1/2}+n},$$
and when $w^*_\rho\le1$ it is the interior value $\tfrac1n\sqrt{\rho\kappa/(\rho+\kappa)}$. The table gives both, at $\rho=\rho^{\mathrm{eff}}_n$, against the two values the block displays: $V:=\tfrac1n\sqrt{\kappa/(1+\kappa)}$ from the closing proof, and $L:=\tfrac1n\sqrt{\kappa(n-8)/(3n-8)}$ from the blockquote.

| $n$ | $\kappa$ | $\rho^{\mathrm{eff}}_n$ | $w^*_{\rho^{\mathrm{eff}}}$ | $\min_{[0,1]}g_{\rho^{\mathrm{eff}}}$ | $V$ | $L$ |
|---|---|---|---|---|---|---|
| 12 | 4.4497190 | 0.7190434 | 1.78668 | 0.0675086 (at $w=1$) | 0.0753005, **fails, $+11.5\%$** | 0.0664410, valid, $-1.6\%$ |
| 14 | 4.4158803 | 0.8723896 | 1.35279 | 0.0614302 (at $w=1$) | 0.0644979, **fails, $+5.0\%$** | 0.0630546, **fails, $+2.6\%$** |
| 16 | 4.3915503 | 0.9856396 | 1.11389 | 0.0561273 (at $w=1$) | 0.0564064, **fails, $+0.5\%$** | 0.0585739, **fails, $+4.4\%$** |
| 20 | 4.3588989 | 1.1418200 | 0.85362 | 0.0475606 (interior) | 0.0450942, valid, $-5.2\%$ | 0.0501473, **fails, $+5.4\%$** |

Every entry is a hand evaluation of an exact expression; the smallest margin carrying a finding is $0.5\%$ at eight significant figures, and section 5 re-derives the two $n=16$ rows as inequalities between surds so that no decimal is load-bearing.

**Read across:** at $n=14$ and $n=16$ **both** displayed values exceed the minimum of the branch the block's own inputs define. There is no dimension in $\{14,16\}$ at which any number on the page is a lower bound for branch 2.

**Does the block compute the endpoint minimum?** It computes the endpoints at coefficient $1$ ("The endpoints give $\sqrt\kappa/n$ and $\asymp1/n$"), of which $g_1(0)=\sqrt{c_p}/\sqrt n=\sqrt\kappa/n$ is exact and $g_1(1)=\sqrt{c_p+1}/(n^{1/2}+n)$ is correctly $\asymp1/n$. It never writes $g_\rho(1)=\sqrt{c_p+\rho}/(n^{1/2}+n)$, and that expression is the governing minimum at every dimension from $12$ to $16$.

## 5. The blockquote's substitute bound, tested exactly

The line under test, [line 1207](../findings/second-order.md):

> *What the closed form $\tfrac1n\sqrt{\kappa(n-8)/(3n-8)}$ remains is a **valid but lossy lower bound**, $15.5\%$ low at $n=12$, and that is what carries $\Theta(n^{-1})$ and this lemma's conclusion*

**What the closed form is.** It is exactly $\inf_{w\ge0}g_{\rho_n}$: with $\kappa/\rho_n=2n/(n-8)$,
$$\frac{\rho_n\kappa}{\rho_n+\kappa}=\frac{\kappa}{1+\kappa/\rho_n}=\frac{\kappa}{1+\frac{2n}{n-8}}=\frac{\kappa(n-8)}{3n-8},$$
so $L=\tfrac1n\sqrt{\rho_n\kappa/(\rho_n+\kappa)}$. Relative to $\rho_n$ it is therefore a genuine lower bound, valid on all of $[0,\infty)$ and lossy on $[0,1]$ exactly because the infimum is unattained there, which is the blockquote's own reasoning and it is sound.

**Why it nevertheless fails.** The same blockquote states that the coefficient carried into the chain is $\rho^{\mathrm{eff}}_n$, not $\rho_n$, and $\rho^{\mathrm{eff}}_n<\rho_n$ strictly for every $n\ne6+2\sqrt7$. By the monotonicity of section 2, $L>\inf g_{\rho^{\mathrm{eff}}}$ always; whether that breaks it on $[0,1]$ is decided dimension by dimension, and it breaks from $n=14$.

**The exhibit, in surds, at $n=16$.** There $\theta_0=\tfrac{\sqrt{105}}8$, $\kappa=\tfrac{3\sqrt{105}}7$, $c_p=\tfrac{3\sqrt{105}}{112}$, $\rho^{\mathrm{eff}}=\sqrt6-\tfrac{\sqrt{105}}7$ and $w^*=1.114>1$, so the branch's minimum over $[0,1]$ is $g_{\rho^{\mathrm{eff}}}(1)$, and
$$L^2=\frac1{256}\cdot\frac{8\kappa}{40}=\frac{3\sqrt{105}}{8960},\qquad g_{\rho^{\mathrm{eff}}}(1)^2=\frac{c_p+\rho^{\mathrm{eff}}}{400}=\frac{\sqrt6-\frac{13\sqrt{105}}{112}}{400}.$$
Multiplying the inequality $L^2>g(1)^2$ by $8960$ turns it into $3\sqrt{105}>\tfrac{112}5\sqrt6-\tfrac{13}5\sqrt{105}$, i.e. $\tfrac{28}5\sqrt{105}>\tfrac{112}5\sqrt6$, i.e.
$$\sqrt{105}>4\sqrt6=\sqrt{96}.$$
**True, and by a wide margin.** So at $n=16$, a dimension squarely inside the lemma's range and the first at which the block's own $\rho_n$ reaches $1$, the closed form the block calls a valid lower bound exceeds the minimum of the branch by the factor $\sqrt{1200\sqrt{105}\,/\,(8960\sqrt6-1040\sqrt{105})}=1.04359$.

**The same test on the proof's own value at $n=16$.** $V^2=\tfrac1{256}\cdot\tfrac{3\sqrt{105}}{7+3\sqrt{105}}$, so $V^2>g(1)^2$ reduces to $\tfrac{1200\sqrt{105}}{256\,(7+3\sqrt{105})}>\sqrt6-\tfrac{13\sqrt{105}}{112}$, that is $1.272695>1.260112$, true, by $1.0\%$. Both values fail there.

**The argument for the opposite, made as strongly as the words allow.** Three defences are available and none survives. *First*, that $\rho_n$ rather than $\rho^{\mathrm{eff}}_n$ is the coefficient, refuted by the blockquote's own sentence "the coefficient carried into the chain is $\rho_n^{\mathrm{eff}}$", and in any case the block's other account of the penalty, at [line 1219](../findings/second-order.md), subtracts the *full* $\lvert\kappa_n\rvert$ from $\tfrac32\theta_0$ rather than $\tfrac29$ of it, which makes the coefficient smaller still and the failure worse. *Second*, that the closed form is only claimed on $[0,\infty)$, refuted by "that is what carries $\Theta(n^{-1})$ and this lemma's conclusion", the conclusion being the statement on $w\in[0,1]$. *Third*, that the discrepancy is inside the block's stated $15.5\%$ slack, but slack in a quantity claimed to be *below* the truth cannot absorb an excess *above* it; the two run in opposite directions, and I could not reproduce $15.5\%$ from any pair of the block's own closed forms (the gap between $L$ and $g_{\rho_n}(1)$ at $n=12$ is $2.6\%$). I record the $15.5\%$ figure as **unreproduced** rather than as a finding: it is a numerical claim about a comparison the block does not name, and the analysis-only footing forbids me to hunt for the pairing that produces it.

**A note on the two accounts of the penalty.** [Line 1204](../findings/second-order.md) charges $\tfrac29\lvert\kappa_n\rvert$; [line 1219](../findings/second-order.md) computes the net coefficient as $\tfrac32\theta_0-\lvert\kappa_n\rvert\to0.416$, a factor $\tfrac92$ heavier on the same term against the same asymptotic margin. Both leave the net coefficient positive at every $n\ge12$, $0.416$ against $1.742$ in the limit, and $0.7416-0.1015=0.640$ against $0.7190$ at $n=12$, so the order conclusion is indifferent between them, but the constant is not, and the block asserts both.

## 6. Whether $\Omega(n^{-1})$ survives, and by what argument

**It survives, and the argument is one line at any coefficient.** For every $\rho>0$ and every $w\in[0,1]$,
$$g_\rho(w)\;\ge\;\inf_{w\ge0}g_\rho\;=\;\frac1n\sqrt{\frac{\rho\kappa}{\rho a_0^2+\kappa}},$$
where $a_0=1$ for the block's $A=n^{1/2}$ and $a_0=\sqrt{2n/(n-2)}$ for the record's own constant. The right side is increasing in $\rho$ and in $\kappa$ and decreasing in $a_0$, so over even $n\ge12$, where $\rho^{\mathrm{eff}}_n\ge\rho^{\mathrm{eff}}_{12}=0.7190434$ by the monotonicity of section 0, $\kappa\ge3\sqrt2=4.2426407$, and $a_0^2=2n/(n-2)\le2.4$,
$$\text{branch }2\;\ge\;\frac1n\sqrt{\frac{0.7190434\cdot4.2426407}{0.7190434\cdot2.4+4.2426407}}=\frac1n\sqrt{0.5111360}=\frac{0.7149378}{n},$$
and $0.7841171/n$ under the block's own $a_0=1$. **That is the boxed claim, uniformly in $w\in[0,1]$, with an explicit constant, and it needs nothing the record does not already carry.**

Three observations about why the conclusion was never really at risk, each of which is also the reason the defects above are constant-level rather than fatal:

- The order of $\inf g_\rho$ is $n^{-1}$ for **any** $\rho$ bounded away from $0$, so no error in the coefficient can move the exponent. The block says as much itself in the "$\rho=0$, which is $m=4$" blockquote: only $\rho\to0$ costs the exponent, and $\rho^{\mathrm{eff}}_n$ is increasing in $n$ from $0.719$.
- Both endpoints are $\Theta(n^{-1})$ at every $\rho\ge\rho^{\mathrm{eff}}_{12}$: $g_\rho(0)=\sqrt\kappa/n$ and $g_\rho(1)=\sqrt{c_p+\rho}/(n^{1/2}+n)\asymp\sqrt\rho/n$. So the endpoint check the proof performs is sound in kind, and only its coefficient is wrong.
- $A=n^{1/2}$ against the record's $a_0n^{1/2}$ with $a_0\in(\sqrt2,1.549]$ is again the unsafe direction (a smaller $A$ makes $g$ larger) but $a_0$ is bounded, so it too is a constant.

**What does not survive is the block's own account of the constant.** The lemma's neighbours read the constant off this page: [L158](../findings/second-order.md) uses "L149's $c_p=\kappa/n$" and "branch 2 has an interior minimum proportional to $n^{-1}\sqrt{\kappa/(1+\kappa)}$" to run an $n$-free branch comparison. That is $V$, the coefficient-$1$ value, and it is $11.5\%$, $5.0\%$ and $1.0\%$ above the truth at $n=12,14,16$. A downstream comparison of two branches that differ by a factor of $58$ at $n=12$ is not endangered by $11.5\%$; a threshold quoted to three figures is.

## 7. Findings, each under the three-part protocol

**F1, the closing proof is executed at a coefficient its own inputs contradict, and the error runs the unsafe way. REAL.**
*Located*: [line 1211](../findings/second-order.md), "$g(w)=\sqrt{c+w^2}/(A+Bw)$", against [line 1194](../findings/second-order.md)'s $c(H)\ge c_p+\rho_nw^2$.
*Exhibited*: $\inf g_\rho=\tfrac1n\sqrt{\rho\kappa/(\rho+\kappa)}$ is strictly increasing in $\rho$; at $n=12$ the displayed $V=0.0753005$ against the true $\min_{[0,1]}g_{\rho^{\mathrm{eff}}}=0.0675086$, an overstatement of $11.5\%$.
*Opposite*: the parenthetical defers explicitly, the algebra is a correct template under $g_\rho=\sqrt\rho\,\tilde g$, and the order is coefficient-blind. The finding is that the displayed values, which are what the neighbouring lemmas cite, are not bounds, not that the mechanism is wrong.

**F2, the substitute closed form is a lower bound at $n=12$ only. REAL.**
*Located*: [line 1207](../findings/second-order.md), "a **valid but lossy lower bound** … and that is what carries … this lemma's conclusion".
*Exhibited*: at $n=16$, $L>g_{\rho^{\mathrm{eff}}}(1)\iff\sqrt{105}>4\sqrt6$, i.e. $105>96$; also fails at $n=14$ by $2.6\%$ and at $n=20$ by $5.4\%$.
*Opposite*: relative to $\rho_n$ the claim is exactly right, and the block may have meant that. But the same blockquote names $\rho^{\mathrm{eff}}_n$ as the coefficient carried into the chain, so on the block's own reading the bound is stated against a branch it does not bound.

**F3, "outside $[0,1]$ at every dimension in range" is false where the conclusion lives. REAL, minor.**
*Located*: [line 1207](../findings/second-order.md), immediately after the correct observation that $w^*$ "reaches $1$ only at $n=16$".
*Exhibited*: $w^*_{\rho_n}=2\sqrt n/(n-8)=0.8485$ at $n=18$; $w^*_{\rho^{\mathrm{eff}}}=0.96094$ at $n=18$ and $0.85362$ at $n=20$, by the criterion $q(n+6\sqrt n+16)\le2\sqrt6\,n$.
*Opposite*: "range" may be shorthand for the three dimensions the sentence has just listed, $n\in\{10,12,14\}$. But the lemma is an asymptotic statement in $n$ and its range is $m\ge5$; on that reading the sentence is false on all but finitely many dimensions, and it contradicts its own predecessor clause from $n=16$.

**F4, $A=n^{1/2}$ understates the denominator constant. REAL, order-neutral.**
*Located*: [line 1211](../findings/second-order.md), "$A=n^{1/2}$", against [Lemma L146](../findings/second-order.md)'s $\lVert H_s\rVert_{op}\le1/\sqrt{m-1}=\sqrt{2/(n-2)}$, which gives $A=n\sqrt{2/(n-2)}=a_0n^{1/2}$ with $a_0=\sqrt{2n/(n-2)}=1.5492$ at $n=12$.
*Exhibited*: a smaller $A$ raises $g$, so this too states a lower bound upward, by up to the factor $a_0$ on the $w=0$ end.
*Opposite*: the block's first bullet writes $\Theta(n^{-1/2})$, and at order level the instantiation is legitimate; $a_0\in(\sqrt2,1.549]$ is bounded, so the exponent is untouched. Recorded because the lemma is cited for its constant, and because [L158](../findings/second-order.md) already charges exactly this against a successor.

**F5, two undefined and one colliding symbol. HYPOTHESIS-DEBT.**
*Located*: [line 1211](../findings/second-order.md)'s "$c=\kappa/n$", with $\kappa$ nowhere defined in the block and $\kappa_n$ used sixteen lines earlier for an unrelated constant.
*Exhibited*: $\kappa=nc_p=3\sqrt{2(n-1)/(n-2)}=4.4497$ at $n=12$; $\lvert\kappa_{12}\rvert=0.1015$. A reader who resolves $\kappa$ against the nearer definition is out by a factor of $44$.
*Opposite*: both are recoverable from the file, $c_p$ at [line 1129](../findings/second-order.md) and $\kappa=nc_p$ in [L158](../findings/second-order.md)'s blockquote, which also records the collision in as many words. So this is debt, not error.

**F6, the smallest admissible dimension is stated three ways. REAL, minor.**
*Located*: the lemma's "For $m\ge5$" against the file's Setting, "$n=2m\ge12$", and against $\lvert\kappa_n\rvert=9(\theta_0(n)-\sqrt{3/2})$.
*Exhibited*: $m=5$ is $n=10$, where $\theta_0=1.2<\sqrt{3/2}$ and the printed $\lvert\kappa_n\rvert=-0.2227$.
*Opposite*: $m\ge5$ is the condition [Lemma L146](../findings/second-order.md) needs for the margin to sit on this summand, so the lemma is quoting the right hypothesis for its own step; the arithmetic simply is not defined below $n=12$, and the block evaluates nothing there.

## Verdict

**GAP.**

The boxed claim is true: branch 2 is $\Omega(n^{-1})$ uniformly in $w\in[0,1]$, at $\ge0.7149378/n$ for every even $n\ge12$, and the proof of that is the one displayed line $\min_{[0,1]}g_\rho\ge\inf_{w\ge0}g_\rho=\tfrac1n\sqrt{\rho\kappa/(\rho a_0^2+\kappa)}$ together with $\rho^{\mathrm{eff}}_n\uparrow$ and $\kappa\downarrow3\sqrt2$.

The block does not contain that proof. Its closing argument is executed at a $w^2$-coefficient of $1$ that its own margin bullet contradicts, and the substitution runs in the unsafe direction on exactly the dimensions where the coefficient is below $1$. The blockquote it defers to repairs the substitution only as far as $\rho_n$, and the value it certifies as a lower bound is above the branch's actual minimum from $n=14$ onward, an inequality that at $n=16$ is exactly $105>96$. At $n=14$ and $n=16$ no number printed in the block bounds branch 2 from below.

Nothing here touches the exponent, and nothing propagates to the boxed $r_n\gtrsim n^{-1-\beta}$ or to the $\Theta(n^{-1})$ ceiling. What propagates is the constant: [L158](../findings/second-order.md) reads $n^{-1}\sqrt{\kappa/(1+\kappa)}$ off this page by name, and that is the value this report finds to be $11.5\%$, $5.0\%$ and $1.0\%$ high at $n=12,14,16$.
