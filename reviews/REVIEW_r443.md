# REVIEW r443, adversarial audit of [post F60](../findings/second-order.md), the $\Theta(n^{-2})$ tube-radius ceiling

*Cold brief, analysis only. Sources read in full: [post F60](../findings/second-order.md), [Lemma L141](../findings/second-order.md), [Lemma L133](../findings/second-order.md), [Lemma L27](../findings/nondegeneracy.md), the [I2](../plan.md) item, and [r441](REVIEW_r441.md). One numeric screen of self-constructed objects is reported as a screen in D2 and is evidence for nothing.*

## Verdict

| # | The post's claim | Verdict |
|---|---|---|
| 1 | The margin is attained: $c_n=3\theta_0/(n-2)$ is the exact constant, reached on the within-factor pair block | **CONFIRMED as arithmetic**, with a factor-$2$ error in its gloss (D1); **REFUTED as support for a ceiling** (D4) |
| 2 | The remainder is forced: the defect's third derivative is $\Theta(n)$, fixed by $f^{[2]}=\Theta(n)$ and the third divided difference $\Theta(n^2)$ | **PLAUSIBLE as an upper bound**; **REFUTED as stated**, the $\Theta(n^2)$ third divided difference cannot enter, and "forced" ($\Omega$) is nowhere established (D2, D3) |
| 3 | Therefore $r_n=\Theta(n^{-2})$ is the method's ceiling; pinning absolute constants moves the constant and never the exponent; a better radius needs a different instrument | **REFUTED** (D4, D5, D6) |

**The headline.** The post divides a minimum by a maximum that are attained on **orthogonal eigenspaces of the same operator**, and calls the quotient a ceiling. On the eigenspace where $c_n$ is attained the defect mechanism the post names is **identically zero**; on the eigenspace where that mechanism lives the margin is $\Theta(1)$, not $\Theta(1/n)$. Redoing the same chain direction by direction (with no instrument the record does not already own), gives $r_n=\Omega(n^{-3/2})$ as soon as $\sup_{\lVert H\rVert=1}\lvert P(H)\rvert$ is pinned to $O(1)$, and $\sup\lvert P\rvert$ is exactly the kind of absolute constant the post promises cannot move the exponent.

---

## D1, the "$6\theta_0$ times the gap" gloss is wrong by a factor of $2$, in three places

[Lemma L24](../findings/second-order.md) gives $\mathrm{Hess}(P|_S)_{W^*}=6\theta_0(L_e-\tfrac12\mathrm{Id})$, and [Lemma L141](../findings/second-order.md)'s $Q$ is built from $\tfrac12\mathrm{Hess}$. So on a defect-free block with $L_e=\lambda$,

$$\frac{Q}{\lVert H\rVert^2}=3\theta_0\big(\lambda-\tfrac12\big),\qquad c_n=3\theta_0\big(\tfrac12-\lambda_m\big)=\frac{3\theta_0}{n-2},$$

i.e. $c_n$ is **$3\theta_0$** times the gap $\tfrac12-\lambda_m=\tfrac1{n-2}$, not $6\theta_0$. The claim "$c_n$ is $6\theta_0$ times the $L_e$-eigenvalue gap" appears in [post F60](../findings/second-order.md), in [Lemma L141](../findings/second-order.md)'s "the $1/n$ decay is intrinsic" paragraph, and in [I2](../plan.md)(iii). It is inert for the exponent and live for a post whose whole subject is that the constants are pinned: $6\theta_0\cdot\tfrac1{n-2}=2c_n$ contradicts the boxed $c_n$ three lines above it.

## D2, the divided differences are right; the third one cannot reach $(\delta^2)'''$

Recomputed cold from $f(x)=x\mathbf 1_{x<0}$ (the sign convention is immaterial, $\tfrac12(\lvert x\rvert-x)=-x_-$ flips every sign and no magnitude), with $\lambda_+=1/\sqrt{(m-1)(2m-1)}$ and $\lambda_-=-\tfrac1m\sqrt{(m-1)/(2m-1)}$:

- $\lVert W^*\rVert^2=\tfrac m{2m-1}+\tfrac{m-1}{2m-1}=1$ and $m(m-1)\lambda_++m^2\lambda_-=0$, the data are consistent.
- $\lambda_+-\lambda_-=\tfrac1m\sqrt{\tfrac{2m-1}{m-1}}\sim\tfrac{\sqrt2}m=\tfrac{2\sqrt2}n$.
- $f^{[1]}(\lambda_-,\lambda_+)=\tfrac{\lambda_-}{\lambda_--\lambda_+}=\tfrac{m-1}{2m-1}\to\tfrac12$, this is [Lemma L133](../findings/second-order.md)'s $c$, $O(1)$.
- $f^{[2]}(\lambda_-,\lambda_-,\lambda_+)=\dfrac{f'(\lambda_-)-f^{[1]}(\lambda_-,\lambda_+)}{\lambda_--\lambda_+}=-\dfrac{m^2\sqrt{(m-1)(2m-1)}}{(2m-1)^2}\sim-\dfrac{\sqrt2}4m=\Theta(n)$. **CONFIRMED**, and identical to [r441](REVIEW_r441.md)'s closed form.
- $f^{[3]}(\lambda_-,\lambda_-,\lambda_-,\lambda_+)\sim m^2/4=\Theta(n^2)$, since $f^{[2]}(\lambda_-,\lambda_-,\lambda_-)=\tfrac12f''(\lambda_-)=0$. **CONFIRMED.**

*Screen (self-constructed objects, seconds, evidence for nothing): at $n=12,20,100,400,2000$ the ratios $n(\lambda_+-\lambda_-)\to2\sqrt2$, $f^{[2]}/n\to-1/(4\sqrt2)$, $f^{[3]}/n^2\to1/16$, matching the hand values, and $\lVert W^*\rVert^2=1$ to machine precision.*

**But one third divided difference is $\Theta(n)$, not $\Theta(n^2)$**: $f^{[3]}(\lambda_-,\lambda_-,\lambda_+,\lambda_+)=\Theta(n)$, the leading terms cancelling (screened at $n/8$). The post's unqualified "the third divided difference $\Theta(n^2)$" is true of one entry of a tensor and false of another, which matters because the entries are summed against $H$ in the Daleckii–Krein expansion.

**And the composition step kills the third one outright.** Write $A(t)=\mathrm{Alt}(W_-(W^*+tH))$, so $\delta^2=\lVert A\rVert^2$ and

$$(\delta^2)'''=2\langle A''',A\rangle+6\langle A'',A'\rangle .$$

At $W^*$, [Lemma L133](../findings/second-order.md) Step 1 gives $A(0)=\mathrm{Alt}(W^*_-)=0$, so the **first term vanishes at the base point**. $A'''$ is the only place $f^{[3]}$ appears; therefore the $\Theta(n^2)$ third divided difference does not enter $(\delta^2)'''$ at $W^*$ at all. Only $f^{[2]}$, through $A''$, does, which is what [r441](REVIEW_r441.md) says (line 154, "forced by the second divided difference") and the opposite of what [I2](../plan.md)(iii) says ("forced by the third divided difference"). The post recites both and reconciles neither. The reconciliation is one line and is the same $\mathrm{Alt}(W^*_-)=0$ that [r441](REVIEW_r441.md) used for its Cauchy supremum; the post should carry it, because without it the two numbers it quotes predict $(\delta^2)'''=\Theta(n^2)$ and its own answer is $\Theta(n)$.

## D3, "forced" is an upper bound wearing a lower bound's clothes

$C_\delta=O(n)$ follows from Cauchy on the analyticity ball, or equivalently from $\lVert A''\rVert\le 8\max\lvert f^{[2]}\rvert\,\lVert H\rVert^2$ (with a two-valued spectrum the Daleckii–Krein second derivative is a sum of at most eight terms $P_aHP_cHP_b$, so the Schur-multiplier constant is absolute). A **ceiling** needs the other direction: a direction $H$ with $\langle A''(H,H),A'(H)\rangle=\Omega(n)\lVert H\rVert^3$. Nothing in [post F60](../findings/second-order.md), [Lemma L141](../findings/second-order.md) or [r441](REVIEW_r441.md) exhibits one, [r441](REVIEW_r441.md) says so in its own words, "**absent an unproven cancellation in $\langle A'',A'\rangle$**", and [post F60](../findings/second-order.md) drops the hedge and writes "**forced**". A fence post is exactly the wrong place to lose a hedge: the hedged sentence invites the check, the unhedged one forbids it.

## D4, the crack: the minimum and the maximum sit on orthogonal eigenspaces

This is the finding. $r_n=c_n/C$ pairs the **worst margin over all directions** with the **worst remainder over all directions**. At $W^*$ those two worst cases are attained on eigenspaces of $L_e$ that are orthogonal, and each is harmless where the other binds.

From [Lemma L27](../findings/nondegeneracy.md), $L_e$ is a scalar on each of ten $O(m)\times O(m)$-summands, with values $1$ on $\langle W^*\rangle$ (excluded by hand, [r431](REVIEW_r431.md)), $\tfrac12$ on $\mathbb R^m\otimes\mathbb R^m$ (the orbit), $\lambda_m=\tfrac{m-2}{2(m-1)}$ on the two copies of $S^2_0(\mathbb R^m)$, $\pm\mu$ with $\mu=\tfrac1{m-1}=\tfrac2{n-2}$ on $S^2_0\otimes S^2_0$ and $\Lambda^2\otimes\Lambda^2$, and $0$ on four summands. For $m\ge4$, $\lambda_m>\mu$, so the off-orbit maximum is $\lambda_m$ and $\tfrac12-\lambda_m=\tfrac1{n-2}$, **claim 1's arithmetic is CONFIRMED**, and the maximiser is the pair of $S^2_0(\mathbb R^m)$ summands, [Lemma L141](../findings/second-order.md)'s "within-factor pair block".

Now put [Lemma L133](../findings/second-order.md)'s support table beside it. The defect response $A'=D(\mathrm{Alt}\,W_-)_{W^*}[H]$ is nonzero only on the $x$-coordinate of $(2,2)$-split four-set blocks; within such a block the $+\mu$ eigenvector is $(2,-1,-1)$, which has $x=2$, and the $-\mu$ eigenvector is $(0,1,-1)$, which has $x=0$. So **$A'$ is supported in the $+\mu$ eigenspace**, which is orthogonal to the $\lambda_m$ eigenspace because they are eigenspaces of the symmetric $L_e$ for distinct eigenvalues. Consequences, both exact:

- **On the margin-attaining directions ($L_eH=\lambda_mH$), $A'(H)=0$**, so $(\delta^2)'''(0)=6\langle A'',A'\rangle=0$ and in fact $\delta^2(t)=\lVert\tfrac{t^2}2A''+\dots\rVert^2=O(n^2t^4)$. The $\Theta(n)$ third derivative the post calls forced is **identically absent** exactly where $c_n$ is attained.
- **On the defect-active directions ($L_eH=+\mu H$), the margin is $\Theta(1)$**: [Lemma L141](../findings/second-order.md)'s own block formula at $s=1$ gives $3\theta_0(\mu-\tfrac12)+\tfrac29\lvert\kappa_n\rvert$, which is $-1.090$ at $n=12$ and $\to-1.742$. The $\Theta(1/n)$ margin the post calls attained is **absent by a factor of $n$** exactly where the $\Theta(n)$ remainder lives.

A ceiling claim about $r_n$ must therefore bound $\inf_H c(H)/C(H)$, and the post never forms that object. Dividing $\min_Hc(H)$ by $\max_HC(H)$ is a **lower bound on the radius**, never an upper one, the direction of the inequality is the opposite of the direction a fence needs.

## D5, the refined chain, from the record's own estimates, gives $\Omega(n^{-3/2})$

Nothing below is a new instrument: block-additivity of $Q$ is [Lemma L120](../findings/second-order.md), the margins are [Lemma L27](../findings/nondegeneracy.md) and [Lemma L141](../findings/second-order.md), and the derivative bounds are [r441](REVIEW_r441.md)'s Cauchy estimate on the ball of radius $g_n/2$ with supremum $M=O(g_n)$, giving $\lVert A^{(k)}(0)\rVert=O(g_n^{1-k})=O(n^{k-1})$.

Fix a unit tangent $H$, put $u=\lVert A'(H)\rVert\le\tfrac12$ (part (a) of [Lemma L141](../findings/second-order.md)), and track $F(t)=P(W(t))-\theta_0-\kappa_n\delta^2(W(t))$ along the great circle.

- **Margin.** $Q$ is block-additive, so $F$'s $t^2$ coefficient is at most $-\big(c_4\Theta(u^2)+c_p(1-\Theta(u^2))\big)$ with $c_p=\Theta(1/n)$ on the $\lambda_m$ eigenspace and $c_4=\Theta(1)$ on the defect-active one; equivalently $c(H)\gtrsim c_p+u^2$.
- **$P$-side tail.** The great-circle expansion of a cubic form is exact with four terms, so the tail beyond $t^2$ is $\lvert P(H)\rvert t^3+O(t^4)$ with the $O(t^4)$ carrying only $\theta_0$ and the Hessian, both $O(1)$. The cubic constant is $\sup_{\lVert H\rVert=1}\lvert P(H)\rvert$ and nothing else.
- **Defect tail.** $\lVert A(t)\rVert\le ut+Knt^2$, so $\delta^2\le u^2t^2+2Knut^3+K^2n^2t^4$, the $u^2t^2$ term already counted in $Q$.

The condition $F\le0$ then reads $c(H)\gtrsim \lvert P\rvert_\infty t+\lvert\kappa_n\rvert(nut+n^2t^2)$, i.e.

$$r_n\;\gtrsim\;\min_{0\le u\le 1/2}\ \min\left(\frac{c_p+u^2}{\lvert P\rvert_\infty+nu},\ \frac{\sqrt{c_p+u^2}}{n}\right).$$

With $\lvert P\rvert_\infty=O(1)$ the inner minimum is $\Theta(n^{-3/2})$, worst at $u\asymp n^{-1/2}$, and it is $\Theta(n^{-3/2})$ on the $u=0$ directions too, where the binding term is the quartic $n^2t^4$. **So the same method, bookkept per direction, gives $r_n=\Omega(n^{-3/2})$, better than the post's ceiling by $\sqrt n$, and still safely inside the analyticity ball $g_n=\Theta(1/n)$, which $\Theta(n^{-1})$ would not be.**

The one input this needs is $\lvert P\rvert_\infty=O(1)$. What the record has is $\sup\lvert P\rvert\le n-1$, from [Lemma L107](../findings/bounds.md)'s $\Pi$-bound at the maximiser, which is what [I2](../plan.md)(iii) uses to write $C_P=O(n)$. So the exponent turns on one absolute constant, and both branches break the post:

- **If $\sup\lvert P\rvert=O(1)$**, which every recorded value of $P$ satisfies, $\theta_0(n)<\sqrt2$ and $\sqrt{3/2}$ at the competitor, the exponent moves to $-3/2$ **by pinning an absolute constant**, which is precisely what the post says cannot happen.
- **If the record keeps $\sup\lvert P\rvert\le n-1$** as its state of knowledge, the exponent $-2$ survives, but its binding cause is the crude $\Pi$-bound on the $P$-side, **not** the divided differences of $x_-$. The post then names the wrong mechanism, and names as forced a quantity that is one evaluation away from being improved.

## D6, what the post's words claim, and the scope term it never defines

Read exactly, the post is inconsistent across its own sections.

- **"What it fences"** is narrow: *any attempt to improve the exponent by sharpening the second-order margin or the third-order remainder of the argument in [I2](../plan.md)*. Sharpening $\sup\lvert P\rvert$ from $n-1$ to $O(1)$ **is** sharpening the third-order remainder of that argument, and by D5 it moves the exponent. So the fence is false even in its narrow reading.
- **The title and the conclusion** are broad, "cannot beat $\Theta(n^{-2})$ by this method", "the ceiling of the method", "a better radius needs a different instrument". "This method" is never defined. D5's chain uses no instrument outside the record, so under any reading that admits D5 the broad claim is false, and under a reading narrow enough to exclude D5 the post fences a single arrangement of an inequality rather than a method.
- **$r_n=c_n/C$ is a sufficient radius from one chain.** The true set on which [Conjecture L16](../findings/problem.md) holds is conjecturally the whole sphere, so "the tube radius cannot beat $\Theta(n^{-2})$" is a statement about a bound, not about a radius. The post hedges this once with "by this method" and then spends its last paragraph reasoning about coverage as though $\Theta(n^{-2})$ were the radius.
- **The coverage paragraph is dimension-vacuous.** A tube of *any* fixed radius $r<1$ about a $36$-dimensional orbit in $S^{1637}$ covers a vanishing fraction; the exponent in $r_n$ changes nothing about that. The paragraph then concedes the point ("this route's value was never coverage") which leaves its own opening sentence, "the exponent is what decides whether the tube is worth having", unsupported by the paragraph written to support it.

**Vacuity check.** The post is not vacuous: it forbids a move a successor would plausibly make, and the move it forbids is the one that works. That is the expensive failure mode the brief names, a closed route nobody reopens.

---

## What would repair it

A post that survives this audit says less and says it precisely:

1. **Keep** the arithmetic: $c_n=3\theta_0/(n-2)$ is attained on the $\lambda_m$ eigenspace ($3\theta_0$, not $6\theta_0$, times the gap $\tfrac1{n-2}$), and $f^{[2]}(\lambda_-,\lambda_-,\lambda_+)=\Theta(n)$ is a property of $W^*$'s spectrum.
2. **Replace** the ceiling with the true statement: *the crude pairing $\min_Hc(H)/\max_HC(H)$ gives $\Theta(n^{-2})$; the direction-resolved chain gives $\Omega(n^{-3/2})$ once $\sup\lvert P\rvert$ is $O(1)$, because $c_n$'s eigenspace is orthogonal to the defect-active one.*
3. **State the open items** the ceiling was standing in for: (i) a bound $\sup_{\lVert H\rVert=1}\lvert P(H)\rvert=O(1)$, or the evaluation of $P$ on the two $S^2_0(\mathbb R^m)$ summands; (ii) whether $\langle A'',A'\rangle=\Omega(n)$ on any direction at all; (iii) whether $\Theta(n^{-3/2})$ is itself sharp, given that $\lVert A''\rVert=O(n)$ is a Cauchy bound that $\mathrm{Alt}$ may not saturate.
4. **Fix the two propagated errors**: the $6\theta_0$ gloss (F60, [Lemma L141](../findings/second-order.md), [I2](../plan.md)) and "forced by the third divided difference" ([I2](../plan.md)), which the composition step rules out.

## What this audit did not check

The block-additivity of $Q$ over [Lemma L120](../findings/second-order.md)'s decomposition was taken as given, as were [Lemma L27](../findings/nondegeneracy.md)'s ten summand values and [Lemma L133](../findings/second-order.md)'s support table, all three carry their own Gate 2. The Schur-multiplier constant in $\lVert A''\rVert\le8\max\lvert f^{[2]}\rvert\lVert H\rVert^2$ is asserted from the two-valued spectrum and not derived at length. No claim here rests on the numeric screen in D2.
