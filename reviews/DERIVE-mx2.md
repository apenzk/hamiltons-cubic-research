# I25, the maximiser's extreme eigenvalues, bounded below and sharply

**Record search first, by mechanism.** Grepped [findings/](../findings/) for lower bounds on $\lambda_{\max}$ and $\lvert\lambda_{\min}\rvert$ at a maximiser. The record holds upper bounds in profusion, [Lemma L70](../findings/bounds.md), the $\Pi$-bound, [Lemma L73](../findings/bounds.md), and the ratio bound $\tfrac1{n-2}\le\rho\le n-2$, but **no lower bound on either extreme eigenvalue**. No outward search: the input is three recorded lemmas and the competitor value.

## The one extra fact a maximiser supplies

**A maximiser satisfies $\theta\ge\Theta_n$**, where $\Theta_n$ is the diagonal maximum, **$\theta_0(n)$ at even $n$, and strictly less at odd $n$**, $\Theta_n^2=2(n-1)(n-3)/((n+1)(n-2))$ ([conventions.md](../findings/conventions.md)). The competitor is $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$, which exists at every $n\ge5$.

> **STATED WITH $\theta_0(n)$ THIS WAS FALSE AT ODD $n$** ([r350](REVIEW_r350.md)). $S^{n/2}\times S^{n/2}$ **does not exist** at odd $n$, so there is no competitor at that value; the record puts the diagonal maximum at $0.9428$ against $\theta_0(5)=0.9798$, and [Lemma L71](../findings/bounds.md) says no critical point saturates at odd $n$. **And the screen did not catch it because the screen was vacuous there**: it evaluated the closed forms for $m$ and $h$ at odd $n$ and compared them, rather than checking that the object those formulas describe exists. *Substituting $\Theta_n$ repairs every statement below, and at even $n$ (the conjecture's range), nothing changes.* Combining it with two recorded upper bounds turns each of them around.

> **THEOREM.** *Let $W$ be a unit maximiser of $P$ on $\mathcal W_n$, $n\ge5$, with $h=\lambda_{\max}>0$ and $m=\lvert\lambda_{\min}\rvert$. Then*
> $$m\;\ge\;\frac{\Theta_n}{n-1},\qquad h\;\ge\;\frac{n\,\Theta_n}{(n-1)(n-2)},$$
> *which at even $n$ read $m\ge\tfrac1n\sqrt{2(n-2)/(n-1)}$ and $h\ge\sqrt{2/((n-1)(n-2))}$,*
> *and both are attained, simultaneously and exactly, at the balanced sphere product.*

**Proof.** The $\Pi$-bound gives $\theta\le(n-1)m$, so $m\ge\theta/(n-1)\ge\theta_0(n)/(n-1)$, the first bound. [Lemma L70](../findings/bounds.md) gives $\theta\le(n-2)h-m$, so $(n-2)h\ge\theta+m\ge\theta_0(n)+\theta_0(n)/(n-1)=\theta_0(n)\cdot\tfrac n{n-1}$, which is the second. For sharpness, the balanced product has $m=\tfrac1n\sqrt{2(n-2)/(n-1)}$ and $h=\tfrac n{n-2}m$; substituting $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ into each bound returns exactly those values. $\square$

**Screened** (seconds, on the closed forms): both bounds equal the balanced product's own $m$ and $h$ to twelve digits at $n=6,8,12,20,50$. *The odd entries of the original screen are struck: at odd $n$ the formulas describe no object.*

## Where this differs from the item as planned

**[plan-maximizer](plan-maximizer.md)'s I25 states $\lambda_{\max}\ge\theta_0(n)(n-2)/\big((n-2)^2-1\big)$. That is true but weaker, and not sharp.** At $n=12$ it gives $0.12485$ against the balanced product's $0.13484$, so it leaves a gap of $8\%$ where the bound above closes it. *The item's other claims, the half-plane $(n-2)\lambda_{\max}-\lvert\lambda_{\min}\rvert\ge\theta_0(n)$, and the positive-eigenvalue count, are reproduced below and stand.*

**The half-plane is the same two lines read the other way.** $(n-2)h-m\ge\theta\ge\theta_0(n)$ is immediate from Lemma L70; equality forces $\theta=\theta_0(n)$ with Lemma L70 saturated, and [Lemma L71](../findings/bounds.md) then makes $W$ the balanced product.

**The positive-eigenvalue count, re-derived.** Write $S=\sum_{\lambda_a>0}\lambda_a=\sum_{\lambda_a<0}\lvert\lambda_a\rvert$ by tracelessness. Then $1=\sum\lambda_a^2\le h\sum_{\lambda>0}\lambda_a+m\sum_{\lambda<0}\lvert\lambda_a\rvert=(h+m)S$, so $S\ge1/(h+m)$; and each positive eigenvalue is at most $h$, so their number $p\ge S/h\ge1/\big(h(h+m)\big)$. With $m\le(n-2)h-\theta_0(n)$ from the half-plane this is $p\ge1/\big(h[(n-1)h-\theta_0(n)]\big)$, **agreement** with the item's stated form.

## What is owed

**The claim of at least three negative eigenvalues IS proved, and this note was wrong twice about it** ([r350](REVIEW_r350.md)).

*(i)* The counting bound is not weak, it is **sharp**. At the balanced product $m(h+m)=4/n^2$ exactly, so $q\ge1/\big(m(h+m)\big)$ reads $q\ge n^2/4$, which is $36$ at $n=12$, and the balanced product has exactly $n^2/4$ negative eigenvalues. *Calling it "weaker than $3$" inverted the truth.*

*(ii)* Three negatives follows from a route the item took and this note did not read: [Lemma L35](../findings/stratum-two-negative.md) gives $q\le2\Rightarrow\theta\le\sqrt{3/2}$, and $\theta_0(n)^2-\tfrac32=(n^2-12n+8)/(2n^2)>0$ **exactly when $n\ge12$**, the conjecture's own threshold. *So at $n\ge12$ a maximiser has $\theta\ge\theta_0(n)>\sqrt{3/2}$ and therefore at least three negative eigenvalues.*

**And a shorter statement holds with no maximality at all** ([r350](REVIEW_r350.md)): $q\ge2$ at every critical point with $\theta>0$. Relation (C) at $a=\arg\min$ gives $\mathbb E_{\mu_a}[\lambda_b\lambda_c]=\lambda_{\min}(\theta-\lambda_{\min})/(n-2)<0$, and $T$ vanishes on repeated indices, so the support avoids $a$ itself, a second negative index must exist.

**Gate 2 owed on the theorem above.**
