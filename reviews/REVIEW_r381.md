# Review r381, the rank-one split, the joint estimate and its closed form

*Gate 2, adversarial, cold brief. 2026-09-02. Analysis only; the two runs below are **screens** of arithmetic I had already done by hand, on matrices I constructed for the purpose, and are reported as screens.*

## Verdict table

| # | Claim | Verdict |
| --- | --- | --- |
| 1 | The rank-one split: $p\theta^2\le2$ forces one eigenvalue $\ge\theta$ and all others $\le0$; $M=\lambda_1ww^\top-K$, $K\succeq0$ | **CONFIRMED**, and twice stronger than stated |
| 2 | On $(\Pi w)^\perp$, $x^\top\widetilde Nx\le\mu^+\lVert x\rVert^2$; at most one direction can violate; $2m\le2m^2-2m+1$ | **CONFIRMED**; two wording corrections |
| 3 | The joint estimate, its $2\times2$ closed form, and the reduction to $\lVert D\hat w\rVert^2\le(T-a)(T-b)$ | **CONFIRMED as stated**; the cross-term bound is loose by a nameable amount |
| 4 | The numbers at $S^6\times S^6$ | **CONFIRMED exactly**, every one, by hand and by screen |
| 5 | The orbit-free relations $u=v$, $w_j=w_k$, $u\cdot\Pi w=(\lambda_1-M_{jk})w_0$, $N\Pi w=\lambda_1\Pi w-2w_0u$ | **CONFIRMED**; simplicity is a **theorem** in the band, not a hypothesis, and the twin-swap argument needs a step the record omits |
| 6 | The boxed inequality as a reduction of the pair clause | **REFUTED, with witness**, it fails at the **cross pair of every balanced sphere product**, $S^6\times S^6$ included |

**The headline.** The section's mathematics is right and its arithmetic is exact. What is wrong is its **scope**. The boxed inequality is presented as *"the pair clause follows from one scalar inequality"*, with no hypothesis $o=0$; and at the cross pair of the very point the section validates itself on, $S^6\times S^6$ in the band, the inequality is **false**, $(T-a)(T-b)=-1.96g^2<0<0.04g^2=k^2$, because $a=10.2g$ exceeds $T=10g$. **Fence (iv), already recorded against the trace–Frobenius ceiling, applies verbatim to the joint estimate and is not recorded against it.**

---

## The setting, re-derived from the definitions

Criticality off the diagonal is $M_{ij}^2+(M^2)_{ij}=\theta M_{ij}$; on the diagonal $M_{ii}=0$ and $(M^2)_{ii}=\sum_lM_{il}^2=:s_i$. So

$$\big(M^2-\theta M\big)_{ij}=-M_{ij}^2\ (i\ne j),\qquad \big(M^2-\theta M\big)_{ii}=s_i=\sum_lM_{il}^2,$$

which is exactly the graph Laplacian of the weights $M_{ij}^2\ge0$. Hence $M^2-\theta M\succeq0$, so every eigenvalue satisfies $\lambda(\lambda-\theta)\ge0$: **$\mathop{\mathrm{spec}}(M)\cap(0,\theta)=\varnothing$**. *Re-derived rather than taken from [diagonal-half.md](../findings/diagonal-half.md); it holds.*

Two further identities I use throughout, both one line from criticality at the pair's own entries. At $(j,k)$: $(M^2)_{jk}=\sum_{l\in I}u_lv_l=u\cdot v$, so

$$\theta M_{jk}=M_{jk}^2+u\cdot v. \tag{P1}$$

At $(i,j)$ and $(i,k)$ for $i\in I$, subtracting the two criticality equations and using $(M^2)_{ij}=(Nu)_i+v_iM_{jk}$:

$$\widetilde N\,o=(\theta+M_{jk})\,o=T\,o. \tag{P2}$$

*(P2) is the whole story of claim 6 and I derived it before reading that the record already has it.*

---

## Claim 1, the rank-one split. CONFIRMED, and stronger than stated

**The counting is right.** Let $p=\#\{\lambda_i\ge\theta\}$. Each such eigenvalue contributes $\ge\theta^2$ to $\sum\lambda_i^2=\lVert M\rVert_F^2=2$, and the rest contribute $\ge0$, so $p\theta^2\le2$.

**The brief's first question, does the gap exclude eigenvalues *above* $\theta$ from being numerous?** It does not, and it does not need to: the **Frobenius count** is what bounds $p$, and the gap is what converts "$p=1$" into "all others $\le0$". The two do different jobs and the section uses each for its own. With $\theta^2\ge\tfrac32$, $p\le\tfrac43$, so $p\le1$; and $\mathop{\mathrm{tr}}M=0$ with $M\ne0$ forces a positive eigenvalue, which the gap pushes to $\ge\theta$, so $p\ge1$. **Hence $p=1$ exactly.**

**The brief's second question, does "all others $\le0$" follow, or only "$\le0$ or $\ge\theta$"?** It **follows**. The gap gives the dichotomy for each eigenvalue, and $p=1$ says exactly one takes the second branch. **No gap remains.**

**$\lambda_1\le\sqrt2$ is used consistently** (it is $\lambda_1^2\le\sum\lambda_i^2=2$) and combined with $\lambda_1\ge\theta$ gives $\theta\le\sqrt2$, which the record already has.

**$K:=\lambda_1ww^\top-M\succeq0$** with $Kw=0$, since on $w^\perp$ it is $-M\succeq0$ by $p=1$. Correct.

> **Two strengthenings the section leaves on the table.**
>
> **(a) The band is not needed, $\theta>1$ suffices.** $p\le2/\theta^2$, so $p=1$ as soon as $\theta^2>1$. The hypothesis actually spent is $\theta>1$, and $\sqrt{3/2}=1.2247$ is comfortably inside it. *This matters because the record repeatedly calls the band "the item's one unspent hypothesis"; the rank-one split spends only a fifth of it.*
>
> **(b) $\lambda_1$ is SIMPLE, for free.** Exactly one eigenvalue is $\ge\theta$ and every other is $\le0<\theta$, so the top eigenvalue has multiplicity one. **Claim 5 states simplicity as a hypothesis ("when $\lambda_1$ is simple"); in the band it is a corollary of claim 1 and should be stated as one.**

---

## Claim 2, one direction at most. CONFIRMED

**The inequality.** For $x\in\mathbb R^I$ with $x\perp\Pi w$, using $\Pi M\Pi=\lambda_1(\Pi w)(\Pi w)^\top-\Pi K\Pi$ on $I$,

$$x^\top\widetilde Nx=\lambda_1(x\cdot\Pi w)^2-x^\top\Pi K\Pi x+x^\top Dx=0-x^\top Kx+x^\top Dx\le\mu^+\lVert x\rVert^2,$$

since $\Pi K\Pi\succeq0$ as a compression of a PSD matrix. **Correct.**

**The conclusion "at most one direction can violate" is correct and the record does not say why.** Two eigenvalues of $\widetilde N$ above $T$ would give a $2$-plane on which the form exceeds $T\lVert x\rVert^2$; that plane meets the hyperplane $(\Pi w)^\perp$ nontrivially, contradicting $\mu^+<T$. *Min–max, one line, worth writing down.*

**The sphere-product arithmetic.** At $S^m\times S^m$, $\gamma$ the cross entry, $g=\lvert\gamma\rvert$, $\alpha=mg/(m-1)$ the within entry, $\theta=(2m-1)g$: $\mu^+=2\alpha=2mg/(m-1)$ and $T=\theta+\alpha=g(2m^2-2m+1)/(m-1)$, so $\mu^+\le T$ is exactly **$2m\le2m^2-2m+1$**, i.e. $2m^2-4m+1\ge0$, true and strict for all $m\ge2$. **Reproduced exactly.**

> **Correction 2a, "already general" is not general.** The later section says *"one of the two side conditions is already general: $b<T$ … which at every $S^p\times S^q$ reduces to $2m\le2m^2-2m+1$"*. **A family is not generality.** $b<T$ is unproved at an arbitrary pure critical point, and the sentence should say "already proved on the sphere products", which is what its own justification establishes.
>
> **Correction 2b, the reduction is the balanced one.** At a general $S^p\times S^q$ with the pair inside the $p$-factor, $\theta=(n-1)c$, $a_A=qc/(p-1)$, so $b<T$ reads $q<(n-1)(p-1)$, not $2m\le2m^2-2m+1$. *It holds for every $p\ge2$, so the conclusion stands; the stated reduction is the $p=q=m$ specialisation.*
>
> **Correction 2c, $\mu^+=2\alpha$ fails at $m=2$.** With $m=2$ the pair exhausts the factor, $I$ is the whole other factor, and $\mu^+=-2g$, not $2\alpha=4g$. *The estimate survives a fortiori, since $-2g<4g$ and $\mu^+$ only ever appears as an upper bound; the closed forms for $q$ and $\lVert D\hat w\rVert^2$ are correct at $m=2$. Cosmetic, the band forces $m\ge6$ anyway, since $\theta^2=(2m-1)(m-1)/m^2\ge\tfrac32\iff m\ge3+\sqrt7=5.646$.*

---

## Claim 3, the joint estimate and its closed form. CONFIRMED as stated

**The estimate.** With $x=c\hat w+y$, $y\perp\hat w$, $c=x\cdot\hat w$, $\lVert y\rVert^2=1-c^2$:

- $\lambda_1(x\cdot\Pi w)^2=\lambda_1\lVert\Pi w\rVert^2c^2$, since $x\cdot\Pi w=c\lVert\Pi w\rVert$. **Correct.**
- $-x^\top\Pi K\Pi x\le0$. **Dropping it is legitimate**, $K\succeq0$, and its compression is too. *It is also the whole of the loss; see claim 6.*
- $x^\top Dx=c^2q+2c\,(D\hat w)\!\cdot\!y+y^\top Dy$, with $y^\top Dy\le\mu^+(1-c^2)$ and $2c(D\hat w)\!\cdot\!y\le2\lvert c\rvert\lVert D\hat w\rVert\lVert y\rVert=2\lvert c\rvert\sqrt{1-c^2}\,k$.

**The brief's question, where does the $y$-dependence go, and is Cauchy–Schwarz in the right place?** The $y$-dependence leaves through two channels, each correct: $\lVert y\rVert$ in the cross term and $\lVert y\rVert^2$ in the diagonal term. Cauchy–Schwarz is applied to $(D\hat w)\cdot y$, which is the only place it can be applied, and it is applied once. **No error.**

**The $2\times2$ maximisation is exact.** The right-hand side is $(c,s)^\top\begin{psmallmatrix}a&k\\k&b\end{psmallmatrix}(c,s)$ at the unit vector $(c,s)$, $s=\sqrt{1-c^2}\ge0$. Since $k\ge0$ the top eigenvector $(k,\ \lambda_{\max}-a)$ has nonnegative entries, so restricting to the closed quadrant costs nothing and the maximum is $\tfrac{a+b}2+\sqrt{(\tfrac{a-b}2)^2+k^2}$ **exactly**. *Including the degenerate $k=0$, where it returns $\max(a,b)$.*

**The reduction is an exact equivalence, and the side conditions are correctly stated.** $\tfrac{a+b}2+\sqrt{(\tfrac{a-b}2)^2+k^2}\le T$ requires $T\ge\tfrac{a+b}2$, and squaring then gives $k^2\le\big(T-\tfrac{a+b}2\big)^2-\big(\tfrac{a-b}2\big)^2=(T-a)(T-b)$. **Both directions hold given $a<T$ and $b<T$, which the section states.**

> **The proviso is load-bearing and deserves a warning, not a parenthesis.** $(T-a)(T-b)\ge0$ **also** when $a>T$ and $b>T$, so the boxed inequality **alone is not sufficient**, it must be carried together with $a<T$ and $b<T$. Claim 6 is precisely a witness where $k^2>(T-a)(T-b)$ because $a>T$; the two failures are the same failure.

> **A free sharpening the section misses.** $y\perp\hat w$, so only the component of $D\hat w$ orthogonal to $\hat w$ can pair with $y$. Replacing $k=\lVert D\hat w\rVert$ by
> $$k_\perp:=\big\lVert(\mathrm{Id}-\hat w\hat w^\top)D\hat w\big\rVert=\sqrt{\lVert D\hat w\rVert^2-q^2}$$
> keeps the estimate valid and is **strictly** better whenever $q\ne0$. At $S^6\times S^6$, within-factor, $k^2=4.704g^2$ against $k_\perp^2=4.6464g^2$, improving the bound from $10.3516g$ to $10.196g$ against a truth of $10g$, **the error falls from $3.52\%$ to $1.96\%$.** *This costs nothing and should replace $k$ in the boxed inequality.*

---

## Claim 4, the numbers at $S^6\times S^6$. CONFIRMED exactly

**The point, re-derived.** $M$ has within-factor entry $\alpha$ and cross entry $\gamma=-g$. $M\mathbf1=0$ gives $\alpha=mg/(m-1)$; criticality on a cross pair gives $(M^2)_{ij}=-2mg^2$ and hence $\theta=(2m-1)g$; criticality within a factor is then an identity. $\lVert M\rVert_F^2=2$ reads $2m^2g^2(2m-1)/(m-1)=2$, so at $m=6$, $g^2=5/(36\cdot11)=\mathbf{5/396}$. ✓

$\mathop{\mathrm{spec}}(M)=\{2mg,\ 0,\ (-\alpha)^{(2m-2)}\}$, so $\lambda_1=12g=1.348400$, $\theta=11g=1.236033$, and the gap and $p=1$ both hold. ✓

**Every quantity, recomputed:**

| quantity | recomputed | recorded | |
| --- | --- | --- | --- |
| $\lambda_1\lVert\Pi w\rVert^2$ | $12g\cdot\tfrac{10}{12}=10g$ | $10g$ | ✓ |
| $q=\hat w^\top D\hat w$ | $\tfrac1{10}[4(2.4g)+6(-2g)]=-0.24g$ | $-0.24g$ | ✓ |
| $\mu^+=2\alpha$ | $2.4g$ | $2.4g$ | ✓ |
| $\lVert D\hat w\rVert^2$ | $\tfrac1{10}[4(2.4)^2+6(2)^2]g^2=4.704g^2$, $k=2.168871g$ | $2.1689g$ | ✓ |
| $a$, $b$, $T$ | $9.76g$, $2.4g$, $12.2g$ | same | ✓ |
| bound | $6.08g+\sqrt{13.5424+4.704}\,g=10.351581g$ | $10.35g$ | ✓ |
| $\mathop{\mathrm{spec}}\widetilde N$ | $\{10g,\ (1.2g)^{(3)},\ 0,\ (-3.2g)^{(5)}\}$, so $\lambda_{\max}=10g$ | $10g$ | ✓ |
| $(T-a)(T-b)$ vs $k^2$ | $2.44\cdot9.8=23.912g^2$ vs $4.704g^2$ | $23.91g^2$ vs $4.70g^2$ | ✓ |

*The optimal $c$ is $0.9647$, which the section rounds to $0.97$; nothing turns on it.* **All four closed forms in $m$ check out**: $\lambda_1\lVert\Pi w\rVert^2=2(m-1)g$, $q=-\alpha/(m-1)$, $\mu^+=2\alpha$, $\lVert D\hat w\rVert^2=2[(m-2)\alpha^2+mg^2]/(m-1)$. **This is the cleanest arithmetic the record has produced on this item.**

---

## Claim 5, the orbit-free relations. CONFIRMED, with a missing step supplied

**$u=v$ makes the transposition $(jk)$ an automorphism of $M$.** With $P$ the permutation matrix, $(PMP)_{ab}=M_{\sigma(a)\sigma(b)}$ agrees with $M_{ab}$ on $I\times I$, on $(i,j)\mapsto M_{ik}=v_i=u_i=M_{ij}$, on $(j,k)$, and on the diagonal. **Correct.**

**The twin-swap argument needs a step the record omits, and the step is available.** Simplicity gives $Pw=\pm w$; the section concludes $w_j=w_k$ from the $+$ branch without excluding the $-$ branch. The $-$ branch forces $\Pi w=0$ and $w_k=-w_j$, whence $(Mw)_j=M_{jk}w_k=-M_{jk}w_j=\lambda_1w_j$, i.e. $\lambda_1=-M_{jk}$. **But (P1) in an orbit-free block reads $M_{jk}(\theta-M_{jk})=\lVert u\rVert^2\ge0$ with $\theta>0$, so $M_{jk}\in[0,\theta]$**, and $\lambda_1\ge\theta>0$ makes $\lambda_1=-M_{jk}\le0$ impossible. **The $-$ branch is excluded and $w_j=w_k=:w_0$.** *Please write this in; it is two lines and the claim is load-bearing.*

**Is $\lambda_1$ simple at a general pure critical point?** **In the band, yes, and it is claim 1 that says so** (strengthening (b) above). Outside the band nothing here establishes it, and the section's phrasing "when $\lambda_1$ is simple" should become "in the band $\lambda_1$ is simple, hence".

**The two relations.** From $Mw=\lambda_1w$ at row $j$: $u\cdot\Pi w+M_{jk}w_0=\lambda_1w_0$, i.e. $u\cdot\Pi w=(\lambda_1-M_{jk})w_0$. ✓ At rows $i\in I$: $(N\Pi w)_i+u_iw_0+v_iw_0=\lambda_1w_i$ with $u=v$, i.e. $N\Pi w=\lambda_1\Pi w-2w_0u$. ✓ **Both confirmed, and $D=2\mathop{\mathrm{diag}}(u)$ with them.**

---

## Claim 6, REFUTED, with a witness inside the band

**The witness: the CROSS pair of $S^6\times S^6$, $n=12$, $\theta=1.236033\ge\sqrt{3/2}$.** This is the same pure critical point the section validates itself on. Take $j$ in one factor, $k$ in the other.

$$u+v\equiv\alpha-g=\tfrac{g}{m-1}=0.2g\ \ \text{on all of }I,\quad\text{so }D=0.2g\,\mathrm{Id},\ b=q=k=0.2g .$$
$$\lVert\Pi w\rVert^2=\tfrac{10}{12},\quad a=12g\cdot\tfrac56+0.2g=\mathbf{10.2g},\qquad T=\theta+M_{jk}=11g-g=\mathbf{10g}.$$

$$\boxed{\ (T-a)(T-b)=(-0.2g)(9.8g)=-1.96\,g^2\ <\ 0\ <\ 0.04\,g^2=k^2\ }$$

**The boxed inequality fails, the side condition $a<T$ fails with it, and the joint estimate returns $10.204g>10g=T$, it does not prove the clause.** *The clause itself is true here: $\lambda_{\max}(\widetilde N)=10g=T$ exactly. **It is the method that fails, not the conjecture.***

**And it is not one point but a family, in closed form.** At every $S^m\times S^m$ cross pair, $T=(2m-2)g$ and $a=2(m-1)g+\tfrac{g}{m-1}$, so

$$a-T=\frac{g}{m-1}>0\qquad\text{for every }m .$$

*Screened at $m=6,8,10,20,50$: the identity holds to machine precision, and the estimate overshoots $T$ at every one.* The unbalanced case goes the same way, at the $S^5\times S^7$ cross pair, $a=10.2383c>T=10c$ and $(T-a)(T-b)=-2.2044c^2<0.3307c^2=k^2$; likewise $S^6\times S^8$.

### Why it fails, exactly

**(P2) is the mechanism.** Whenever $o\ne0$, $\widetilde No=To$, so $T\in\mathop{\mathrm{spec}}(\widetilde N)$ and the clause holds **with zero slack**. Any bound $B\ge\lambda_{\max}(\widetilde N)=T$ can satisfy $B\le T$ only as an **equality**, so every inequality in its derivation must be tight at the maximiser. At the balanced cross pair $\hat w\parallel o$ (the maximiser *is* $\hat w$) and

$$a=\hat w^\top\widetilde N\hat w+\hat w^\top K\hat w=T+\frac{g}{m-1},$$

so **the entire failure is the discarded term $\hat w^\top K\hat w$**, the one thing the rank-one split throws away. *This is a much sharper diagnosis than "short by $1.5\%$": the loss is a single identified quantity with a closed form.*

**Two repairs, screened, and neither closes it.**

| repair | balanced cross pair | unbalanced cross pair |
| --- | --- | --- |
| $k\to k_\perp=\sqrt{k^2-q^2}$ alone | still fails ($10.2g>10g$) | still fails |
| $a\to\hat w^\top\widetilde N\hat w$ **and** $k\to k_\perp$ | **equality**, $10g=T$, zero slack | **still fails**: $S^5\times S^7$ gives $10.0107c>10c$; $S^6\times S^8$ gives $12.0049c>12c$ |

**So the joint estimate inherits fence (iv) verbatim.** The record already states, of the trace–Frobenius ceiling, that *"$\widetilde No=(\theta+M_{jk})o$ makes the clause an equality wherever $o\ne0$, so no trace–Frobenius bound can ever establish it there … $\lVert o\rVert=0$ is a hypothesis, not a free variable"*. **Every word of that applies to the joint estimate, and the section that states the boxed reduction states no hypothesis $o=0$ at all.**

### What the section should say instead

> **The boxed inequality is a sufficient condition for the pair clause at ORBIT-FREE pairs ($o=0$), together with the side conditions $a<T$ and $b<T$. At a pair with $o\ne0$ it is false at the balanced sphere products and cannot be repaired, because the clause is an equality there.**

*Nothing else in the section changes. The $S^6\times S^6$ within-factor validation stands, the closed forms stand, the $2\times2$ maximisation stands, and the reduction stands on its true domain.* **The cost is that "the pair clause follows from one scalar inequality" becomes "the orbit-free half of the pair clause follows from one scalar inequality", and the non-orbit-free half, which (P2) shows is the tight half, needs its own instrument.**

---

## What is owed after this review

1. **State $o=0$ as a hypothesis of the boxed reduction**, and record the cross-pair witness as a fence post against extending it.
2. **Promote simplicity of $\lambda_1$ from hypothesis to corollary** of the rank-one split, in the band.
3. **Insert the $M_{jk}\ge0$ step** that excludes $Pw=-w$ in the twin-swap argument.
4. **Replace $k$ by $k_\perp=\sqrt{\lVert D\hat w\rVert^2-q^2}$** throughout, free, strictly better, and it nearly halves the error at $S^6\times S^6$.
5. **Correct "already general"** to "already proved on the sphere products", and the reduction $q<(n-1)(p-1)$ for the unbalanced case.
6. **Record that the rank-one split spends only $\theta>1$**, so the band remains largely unspent for a successor.

*What would need a real run, and is not run: whether $a<T$ and the boxed inequality hold at the non-sphere-product in-band critical points the record catalogues, the $\mathbb{CP}^2$ orbit and the non-diagonal $S=0$ point at $\theta=1.236031$. That would decide whether the orbit-free restriction is the only restriction, or whether $a<T$ fails more widely. It is a construction plus an eigen-decomposition per point, and it needs approval.*
