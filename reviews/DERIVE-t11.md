# DERIVE-t11, the spectral necessary conditions as a family, read through the convex hull

**Method: analysis only.** Every inequality below is derived from the three per-index relations and elementary algebra, and every step is written out. Four arithmetic screens were taken, each seconds long, on spectra written down by hand; they are listed at the end and carry no positive claim. **Record discipline**: every result was checked against [findings/INDEX-results.md](../findings/INDEX-results.md), [bounds.md](../findings/bounds.md) from the per-row family through Lemma L73, [r337](REVIEW_r337.md) and [r338](REVIEW_r338.md); nothing here contradicts an indexed lemma, and the three places where this report reaches a record result by a new route are marked *agreement*, never discovery.

**Standing setting.** $N=n(n-1)/2$. $W\in\mathcal W_n$ is a $\theta$-critical point, $Q(W)=W^2+W^\#=\theta W$, of unit norm unless stated; $v_1,\dots,v_N$ its eigenbasis in $\mathfrak{so}(n)$ with eigenvalues $\lambda_a$; $T_{abc}=c_{abc}^2\ge0$, totally symmetric, zero on repeated indices. The three complete relations ([r331](REVIEW_r331.md)):

$$\text{(A)}\ \sum_{b,c}T_{abc}=2(n-2),\qquad\text{(B)}\ \sum_{b,c}\lambda_bT_{abc}=-2\lambda_a,\qquad\text{(C)}\ \sum_{b,c}\lambda_b\lambda_cT_{abc}=2\lambda_a(\theta-\lambda_a),$$

(A) and (B) on all of $\mathcal W_n$, (C) at critical points. Row $a$ carries the probability measure $\mu_a=T_{a\bullet\bullet}/2(n-2)$ on the pair set $P_a=\{(b,c):b\ne c,\ b\ne a,\ c\ne a\}$; with $X=\tfrac{\lambda_b+\lambda_c}2$, $Y=\lambda_b\lambda_c$, $D=\tfrac{\lambda_b-\lambda_c}2$ (so $D^2=X^2-Y$ pointwise),

$$\mathbb E_a[X]=\frac{-\lambda_a}{n-2},\qquad \mathbb E_a[Y]=\frac{\lambda_a(\theta-\lambda_a)}{n-2}.$$

Throughout, $h=\lambda_{\max}>0$, $m=\lvert\lambda_{\min}\rvert>0$ (both signs occur by tracelessness), $\rho=h/m$, and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$.

---

## Verdict on the seed S1–S4

| seed | verdict | what it is |
|---|---|---|
| **S1** all row-points on one parabola $Y=-\theta X-(n-2)X^2$ | **CORRECT** | substitute $\lambda_a=-(n-2)\mathbb E_a[X]$ into (C); an identity in $\lambda_a$, so it constrains nothing beyond (C) itself |
| **S2** crossings with $Y=X^2$ at $X=0$ and $X=-\theta/(n-1)$, parabola above between | **CORRECT** | $P_\theta(x)-x^2=-x\,(\theta+(n-1)x)$, positive exactly for $-\theta/(n-1)<x<0$, i.e. for $0<\lambda_a<\theta(n-2)/(n-1)$ |
| **S3** $\operatorname{Var}_a(X)\ge g(\lambda_a):=\lambda_a[\theta(n-2)-(n-1)\lambda_a]/(n-2)^2$ | **CORRECT, and an identity once completed** | $\operatorname{Var}_a(X)-\mathbb E_a[D^2]=g(\lambda_a)$ exactly (Theorem C(d)); the inequality is $\mathbb E_a[D^2]\ge0$ |
| **S4** Popoviciu: $g(\lambda_a)\le(h+m)^2/4$; slack $4$ at the balanced product | **CORRECT arithmetic, and crude** | the exact form is Bhatia–Davis on the reduced support, which is the chord bound (i) below, tight at the balanced product's $\lambda_{\max}$ row; Popoviciu is Bhatia–Davis weakened by AM–GM, and $n(n-4)\le(n-2)^2$ is the slack $4$ |

Checked at the balanced product by hand in §3 and §4: the $\lambda_{\max}$ row's measure is two-point on $X\in\{h,-m\}$ with weights $\tfrac{n-4}{2(n-2)},\tfrac{n}{2(n-2)}$, its variance is $n(n-1)^2(n-4)m^2/(n-2)^4=g(h)$ exactly, and $\mathbb E[D^2]=0$ there because every pair in the row's support has equal eigenvalues.

---

## 1. Theorem A, every two-eigenvalue critical point has $\theta\le\theta_0(n)$

**Classification, stated first.** The theorem is a two-line corollary of two results already on the record, [Lemma L70](../findings/bounds.md) and the $\Pi$-bound ([bounds.md](../findings/bounds.md), [post F40](../findings/fence-posts.md)). *The corollary is new as a statement; its ingredients are not.* The record's nearest prior statement is "[$\Pi/4=\theta_0(n)$ at any two-eigenvalue critical point with $\Delta=0$](../findings/bounds.md)"; Theorem A removes the $\Delta=0$ hypothesis and replaces the equality by the inequality that holds in general.

> **THEOREM A.** *Let $n\ge5$ and let $W\in\mathcal W_n$ be a $\theta$-critical point of unit norm whose spectrum on $\Lambda^2\mathbb R^n$ takes exactly two values, $h>0$ with multiplicity $p$ and $-m<0$ with multiplicity $q$. Put $\rho=h/m$. Then*
> $$\theta\ \le\ B_n(\rho):=\frac{\min\{\,n-1,\ (n-2)\rho-1\,\}}{\sqrt{N\rho}}\ \le\ \theta_0(n),$$
> *with $B_n$ strictly increasing on $(0,\tfrac n{n-2}]$ and strictly decreasing on $[\tfrac n{n-2},\infty)$. Equality $\theta=\theta_0(n)$ holds iff $\rho=\tfrac n{n-2}$ and $W$ is the Weyl tensor of $S^{n/2}\times S^{n/2}$; for odd $n$ the inequality is strict.*

**Proof.**

1. *Trace and norm pin $m$.* $\operatorname{tr}W=0$ gives $ph=qm$, so $q=p\rho$ and, with $p+q=N$, $p=\tfrac N{1+\rho}$, $q=\tfrac{N\rho}{1+\rho}$. Unit norm gives $1=ph^2+qm^2=m^2(p\rho^2+q)=m^2q(\rho+1)=m^2N\rho$, hence $m=(N\rho)^{-1/2}$.
2. *Lemma L70.* $\theta\le\lambda_{\min}+(n-2)\lambda_{\max}=-m+(n-2)h=m\,\big((n-2)\rho-1\big)$. (Lemma L70's weakened form uses $\lambda_b\lambda_c\ge\lambda_{\min}\lambda_{\max}$ for every pair, which holds whenever both signs occur.)
3. *The $\Pi$-bound.* $\theta\le(n-1)\lvert\lambda_{\min}\rvert=(n-1)m$.
4. *Combine.* $\theta\le m\min\{(n-2)\rho-1,\ n-1\}=B_n(\rho)$ by step 1.
5. *Shape of $B_n$.* The two branches cross where $(n-2)\rho-1=n-1$, i.e. $\rho=\tfrac n{n-2}$. Below the crossing $B_n=f_1(\rho)/\sqrt N$ with $f_1(\rho)=((n-2)\rho-1)\rho^{-1/2}$, and $f_1'(\rho)=\rho^{-3/2}\big[(n-2)\rho-\tfrac12((n-2)\rho-1)\big]=\rho^{-3/2}\big[\tfrac{(n-2)\rho}2+\tfrac12\big]>0$. Above it $B_n=(n-1)\rho^{-1/2}/\sqrt N$, strictly decreasing. So $B_n$ peaks at $\rho^\*=\tfrac n{n-2}$ with
   $$B_n(\rho^\*)=\frac{n-1}{\sqrt{Nn/(n-2)}}=(n-1)\sqrt{\frac{2(n-2)}{n^2(n-1)}}=\frac{\sqrt{2(n-1)(n-2)}}n=\theta_0(n).$$
6. *Equality.* $\theta=\theta_0(n)$ forces $\rho=\rho^\*$ by strict monotonicity on both sides, and then $\theta=m((n-2)\rho^\*-1)=\lambda_{\min}+(n-2)\lambda_{\max}$, i.e. Lemma L70 is saturated. [Lemma L71](../findings/bounds.md) (unconditional for $n\ge5$) then makes $W$ the balanced sphere product, and records that no critical point saturates at odd $n\ge5$. $\square$

**Checks against the record** (*agreement*). The $n=6$ maximal torus $\mathfrak{so}(2)^3$: spectrum $4/\sqrt{60}$ ($\times3$), $-1/\sqrt{60}$ ($\times12$), $\rho=4$, $m=1/\sqrt{60}=(N\rho)^{-1/2}$ ✓, $B_6(4)=\min\{5,15\}/\sqrt{60}=5/\sqrt{60}=0.645497$, the catalogued $\theta$ ([Lemma L74](../findings/diagonal-half.md)'s octahedron value). $\mathrm{ad}(\mathfrak{su}(3))\subset\mathfrak{so}(8)$: $W=\Pi_{\mathfrak h}-\tfrac8{28}I$ has $\tfrac57$ ($\times8$), $-\tfrac27$ ($\times20$), $\rho=\tfrac52$, $m=1/\sqrt{70}$, $B_8(\tfrac52)=\min\{7,14\}/\sqrt{70}=7/\sqrt{70}=0.836660$, the catalogued value. Both lie on the $\Pi$ branch and are exact, which is the record's "sharp on every maximal torus". The strongly regular family of [Lemma L74](../findings/diagonal-half.md) consists of two-eigenvalue critical points, and the granted diagonal case says $\theta\le\theta_0$ there; Theorem A agrees and adds the non-diagonal two-eigenvalue points.

**Where the two lines stop, exactly.** Unit norm entered only at step 1, and it pins $m$ only because two multiplicities and two values are tied by trace and norm. With a third value $t$ of multiplicity $r$, trace and norm are two equations in $(h,m,t)$ at fixed $\rho$, so $m$ is free in an interval and grows as mass moves to eigenvalues with $\lvert t\rvert<m$. Then $\min\{\text{L70},\Pi\}=m\min\{(n-2)\rho-1,\,n-1\}$ exceeds $\theta_0(n)$:

- *kernel-free witness, $n=12$*: spectrum $(-m)^{\times30},\ (1.2m)^{\times20},\ (0.375m)^{\times16}$, traceless ($-30+24+6=0$), unit norm at $m=1/\sqrt{61.05}=0.127984$ against $m=(N\rho)^{-1/2}=0.112367$ for the two-eigenvalue spectrum of the same $\rho=1.2=\tfrac n{n-2}$. Both lines give $11m=1.407829>\theta_0(12)=1.236033$.
- *genuine critical point*: padded $S^3\times S^3$ in $\mathcal W_{12}$, spectrum $1.5^{\times6},(-1)^{\times9},0^{\times51}$ in mixed$=-1$ units, $m=0.210819$ at unit norm, true $\theta=5m=1.054093$: $\Pi=11m=2.319004$, L70 $=14m=2.951459$.

So the minimum over spectra of $\min\{\text{L70},\Pi\}$ exceeds $\theta_0(n)$ as soon as a third eigenvalue is free, and no argument built on these two lines alone closes the conjecture beyond the two-eigenvalue class. §5 shows the same for the whole family of this report.

---

## 2. Theorem B, the triangle family: the complete per-row hull condition in closed form

**Pair-point geometry (Lemma B1).** For real $\nu,\nu'$ and any $L\le\nu,\nu'\le U$:

- (a) $(\nu-L)(\nu'-L)\ge0$, i.e. $\nu\nu'\ge L(\nu+\nu')-L^2$;
- (b) $(U-\nu)(U-\nu')\ge0$, i.e. $\nu\nu'\ge U(\nu+\nu')-U^2$;
- (c) adding $(\nu-L)(U-\nu')\ge0$ and $(\nu'-L)(U-\nu)\ge0$: $(L+U)(\nu+\nu')-2\nu\nu'-2LU\ge0$, i.e. $\nu\nu'\le\tfrac{L+U}2(\nu+\nu')-LU$.

In the coordinates $(X,Y)=\big(\tfrac{\nu+\nu'}2,\nu\nu'\big)$ these read $Y\ge2LX-L^2$ (the tangent to $Y=X^2$ at $L$), $Y\ge2UX-U^2$ (the tangent at $U$), $Y\le(L+U)X-LU$ (the chord from $(L,L^2)$ to $(U,U^2)$). The three lines meet pairwise at $(L,L^2)$, $(U,U^2)$ and (solving $2LX-L^2=2UX-U^2$), at $\big(\tfrac{L+U}2,LU\big)$. *The pair-point of $(\nu,\nu')$ is the intersection of the tangents at $\nu$ and $\nu'$*: substituting $X=\tfrac{\nu+\nu'}2$ into the tangent at $\nu$ gives $\nu(\nu+\nu')-\nu^2=\nu\nu'$. So every pair-point lies in the closed triangle $\Delta(L,U)$ with vertices $(L,L^2)$, $(U,U^2)$, $\big(\tfrac{L+U}2,LU\big)$.

> **THEOREM B (triangle family).** *Let $W$ be $\theta$-critical, $n\ge4$, and fix a row $a$ with $\lambda_a\ne0$. Let $L_a\le U_a$ be any numbers with $L_a\le\lambda_b\le U_a$ for every $b\ne a$ (the best choice being the reduced extremes $L_a=\min_{b\ne a}\lambda_b$, $U_a=\max_{b\ne a}\lambda_b$). Then*
> $$\text{(i)}\ \ \lambda_a(\theta-\lambda_a)\le-(L_a+U_a)\lambda_a-(n-2)L_aU_a,\qquad \text{(ii)}\ \ \lambda_a(\theta-\lambda_a)\ge-2L_a\lambda_a-(n-2)L_a^2,\qquad \text{(iii)}\ \ \lambda_a(\theta-\lambda_a)\ge-2U_a\lambda_a-(n-2)U_a^2 .$$
> *If moreover $L_a$ and $U_a$ are the reduced extremes and each is carried by at least two indices $b\ne a$, then $\operatorname{conv}\{(X_{bc},Y_{bc}):(b,c)\in P_a\}=\Delta(L_a,U_a)$ exactly, so (i)–(iii) are equivalent to [r337](REVIEW_r337.md)'s complete per-row hull condition.*

**Proof.** Integrate Lemma B1's three inequalities against $\mu_a$ (legitimate because $\mu_a$ is a probability measure on $P_a$ by (A) and $T\ge0$) then substitute $\mathbb E_a[X]=-\lambda_a/(n-2)$ from (B) and $\mathbb E_a[Y]=\lambda_a(\theta-\lambda_a)/(n-2)$ from (C), and multiply by $n-2$. For the second part: $\Delta(L_a,U_a)$ is exactly the set cut out by the three linear inequalities; every pair-point lies in it; and under the multiplicity hypothesis all three vertices *are* pair-points, $(L_a,L_a^2)$ is the pair of two indices at $L_a$, $(U_a,U_a^2)$ two at $U_a$, and $\big(\tfrac{L_a+U_a}2,L_aU_a\big)$ one of each, so the hull is the whole triangle, and "$(\mathbb E_a[X],\mathbb E_a[Y])\in\operatorname{conv}$" is (i)–(iii). $\square$

**Sign bookkeeping.** For $\lambda_a>0$, (i) is an upper bound on $\theta$ and (ii),(iii) are lower bounds; for $\lambda_a<0$ dividing by $\lambda_a$ flips all three.

**Remark on interior eigenvalues.** A pair-point with both eigenvalues strictly inside $(L_a,U_a)$ is strictly inside the triangle; a pair $(L_a,t)$ lies on the tangent edge at $L_a$ and $(t,U_a)$ on the edge at $U_a$; none is a vertex. So the per-row hull depends on the interior of the spectrum only through the row labels $\lambda_a$. *(This corrects the phrasing "interior eigenvalues never reach the hull boundary" in my log: they reach edges, never vertices.)*

### Corollary B2, the per-row bounds at the $\lambda_{\min}$ row, and the sharper form of Lemma L70

Take $a=\arg\min$, $\lambda_a=-m$, with the global choice $L=-m$, $U=h$ (always admissible). Dividing by $-m<0$:

$$\text{(ii)}\ \Rightarrow\ \theta\le(n-1)m\ \ [=\Pi],\qquad\text{(iii)}\ \Rightarrow\ \theta\le\frac{(n-2)h^2}m-2h-m=m\big((n-2)\rho^2-2\rho-1\big).$$

Lemma L70 is $\theta\le-m+(n-2)h=m((n-2)\rho-1)$, the horizontal line $Y\ge LU$ through the triangle's apex. Comparing:

- (iii) $\le$ L70 $\iff(n-2)\rho^2-2\rho\le(n-2)\rho\iff\rho\le\tfrac n{n-2}$;
- $\Pi\le$ L70 $\iff n-1\le(n-2)\rho-1\iff\rho\ge\tfrac n{n-2}$.

> **$\min\{\Pi,\text{(iii)}\}\le\text{Lemma L70}$ at every critical point, with equality iff $\rho=\tfrac n{n-2}$.** Geometrically: the triangle's lower boundary (the two tangents) lies above the apex line except at the apex, and the row-point's abscissa $\mathbb E[X]=\tfrac m{n-2}$ equals the apex abscissa $\tfrac{h-m}2$ exactly when $nm=(n-2)h$.

Lemma L70 is therefore dominated at every critical point (by (iii) below the balanced ratio and by $\Pi$ above it) and the peak of $\min\{\Pi,\text{(iii)}\}$ over two-eigenvalue spectra is the same $\theta_0(n)$ as in Theorem A, (iii) sharpens the bound away from $\rho=\tfrac n{n-2}$ and leaves the maximum where Lemma L70 put it. The chord (i) at the $\lambda_{\min}$ row gives only the lower bound $\theta\ge-(n-1)h$.

### Corollary B3, with global extremes the whole family is two inequalities plus Lemma L73

Use $L=-m$, $U=h$ in every row and assume [Lemma L73](../findings/bounds.md), $h\le(n-2)m$ and $m\le(n-2)h$ (which holds on all of $\mathcal W_n$). Write positive rows as $\lambda_a=x\in(0,h]$ and negative rows as $\lambda_a=-x$, $x\in(0,m]$.

| row sign | inequality | reads | monotone in $x$ | extreme value |
|---|---|---|---|---|
| $+$ | (i) | $\theta\le x-(h-m)+(n-2)mh/x$ | decreasing on $(0,\sqrt{(n-2)mh})\supseteq(0,h]$ since $h^2\le(n-2)mh\iff h\le(n-2)m$ | at $x=h$: $\theta\le(n-1)m=\Pi$ |
| $-$ | (ii) | $\theta\le2m-x+(n-2)m^2/x$ | decreasing | at $x=m$: $\theta\le(n-1)m=\Pi$ |
| $-$ | (iii) | $\theta\le-2h-x+(n-2)h^2/x$ | decreasing | at $x=m$: $\theta\le(n-2)h^2/m-2h-m$ |
| $+$ | (ii) | $\theta\ge x+2m-(n-2)m^2/x$ | increasing | at $x=h$: $\theta\ge h+2m-(n-2)m^2/h$ |
| $+$ | (iii) | $\theta\ge x-2h-(n-2)h^2/x$ | increasing | at $x=h$: $\theta\ge-(n-1)h$, vacuous |
| $-$ | (i) | $\theta\ge-x-h+m-(n-2)mh/x$ | increasing on $(0,m]$ since $m^2\le(n-2)mh$ | at $x=m$: $\theta\ge-(n-1)h$, vacuous |

So at a critical point the union of (i)–(iii) over all rows with global extremes is exactly

$$\theta\le(n-1)m,\qquad\theta\le\frac{(n-2)h^2}m-2h-m,\qquad\theta\ge h+2m-\frac{(n-2)m^2}h .$$

The lower bound against $\Pi$ gives $h^2+2mh-(n-2)m^2\le(n-1)mh$, i.e. $(h-(n-2)m)(h+m)\le0$: Lemma L73's first half, reproduced from (C) read twice (*agreement* with the record's derivation from (B) alone). The lower bound against (iii) gives $(n-2)\rho^3-3\rho^2-3\rho+(n-2)\ge0$, which is automatic for $n\ge5$ because the left side equals $3(\rho-1)^2(\rho+1)+(n-5)(\rho^3+1)$. **So with global extremes the triangle family at critical points is two upper bounds on $\theta$ and nothing else.**

### Corollary B4, reduced extremes are what bite when an extreme eigenvalue is simple

- **Padded $W_{\mathbb{CP}^2}$**, spectrum $(2\varepsilon,-\varepsilon,-\varepsilon,0^{\times(N-3)})$, $\varepsilon=1/\sqrt6$, any $n\ge4$. At $a=\arg\max$ the reduced spectrum is $\{-\varepsilon,-\varepsilon,0,\dots\}$, so $L_a=-\varepsilon$, $U_a=0$, and (i) reads $2\varepsilon(\theta-2\varepsilon)\le\varepsilon\cdot2\varepsilon-0=2\varepsilon^2$, i.e. $\theta\le3\varepsilon=\sqrt{3/2}$, **the true $\theta$, exactly, at every $n$**. [r337](REVIEW_r337.md)'s one-line hull bound is the chord (i) with reduced extremes (*agreement*). With global extremes the same row gives $\Pi=(n-1)\varepsilon$, slack by $(n-1)/3$.
- **$S^2\times S^{n-2}$** in mixed$=-1$ units: $\lambda_{\max}=n-2$ is simple, the reduced spectrum at $\arg\max$ is $\{t,-1\}$ with $t=\tfrac2{n-3}$, so $L_a=-1$, $U_a=t$, and (i) reads $(n-2)\big(\theta-(n-2)\big)\le-(t-1)(n-2)+(n-2)t$, i.e. $\theta\le n-1$, the true $\theta$ exactly (*agreement* with [r337](REVIEW_r337.md) §U5).

When the reduced extreme is simple the hull is a proper sub-polygon of the triangle (its lower edges still lie on the two tangents, starting at the lowest available pair-point on each), so (i)–(iii) with reduced extremes remain valid and the exact hull is at least as strong; the multiplicity hypothesis of Theorem B is exactly the condition under which nothing is lost. *Every spectrum used in §5 satisfies it.*

---

## 3. Theorem C, the pinned budget, the only joint reading this calculus produces

> **THEOREM C.** *For every $W\in\mathcal W_n$, with $\lvert\lambda\rvert^2=\sum_a\lambda_a^2$ ($=1$ at unit norm):*
> $$\text{(a)}\ \sum_a\mathbb E_a[X^2]=\frac{(n-3)\lvert\lambda\rvert^2}{2(n-2)},\qquad\text{(b)}\ \sum_a\operatorname{Var}_a(X)=\frac{(n-1)(n-4)\lvert\lambda\rvert^2}{2(n-2)^2},\qquad\text{(c)}\ \sum_a\mathbb E_a[D^2]=\frac{(n-1)\lvert\lambda\rvert^2}{2(n-2)} .$$
> *At a $\theta$-critical point, in addition:*
> $$\text{(d)}\ \operatorname{Var}_a(X)-\mathbb E_a[D^2]=g(\lambda_a):=\frac{\lambda_a\,[\theta(n-2)-(n-1)\lambda_a]}{(n-2)^2}\ \text{ for every row }a;$$
> $$\text{(e)}\ \theta(n-2)N_1+(n-1)N_2+\sum_{\lambda_a>\theta\frac{n-2}{n-1}}\lambda_a\big[(n-1)\lambda_a-\theta(n-2)\big]\ \le\ \frac{(n-1)(n-2)}2\lvert\lambda\rvert^2,\qquad N_1=\sum_{\lambda_a<0}\lvert\lambda_a\rvert,\ N_2=\sum_{\lambda_a<0}\lambda_a^2,$$
> *hence, dropping the nonnegative third sum, at unit norm* $\theta\le\dfrac{(n-1)\big[\tfrac{n-2}2-N_2\big]}{(n-2)N_1}$ *(the $\Sigma$-bound). (f) The $\Sigma$-bound is exact at the balanced product.*

**Proof.** Write $S_{bc}=\sum_aT_{abc}$; total symmetry of $T$ makes $S$ symmetric, and (A) read at row $b$ gives $\sum_{a,c}T_{abc}=2(n-2)$ for every $b$, while (B) is $(S\lambda)_b=-2\lambda_b$.

(a) $\sum_a\mathbb E_a[X^2]=\dfrac1{2(n-2)}\sum_{abc}T_{abc}\dfrac{(\lambda_b+\lambda_c)^2}4$. Expand: $\sum_{abc}T_{abc}\lambda_b^2=\sum_b\lambda_b^2\cdot2(n-2)$, likewise for $\lambda_c^2$, and $\sum_{abc}T_{abc}\lambda_b\lambda_c=\sum_b\lambda_b(S\lambda)_b=-2\lvert\lambda\rvert^2$. So the bracket is $\tfrac14[4(n-2)-4]\lvert\lambda\rvert^2=(n-3)\lvert\lambda\rvert^2$, and dividing by $2(n-2)$ gives (a).

(b) $\sum_a\mathbb E_a[X]^2=\sum_a\lambda_a^2/(n-2)^2$; subtract from (a): $\lvert\lambda\rvert^2\big[\tfrac{n-3}{2(n-2)}-\tfrac1{(n-2)^2}\big]=\lvert\lambda\rvert^2\tfrac{(n-3)(n-2)-2}{2(n-2)^2}=\lvert\lambda\rvert^2\tfrac{(n-1)(n-4)}{2(n-2)^2}$.

(c) $\sum_a\mathbb E_a[Y]=\dfrac1{2(n-2)}\sum_{abc}T_{abc}\lambda_b\lambda_c=\dfrac{-\lvert\lambda\rvert^2}{n-2}$, using (B) only; then $\sum_a\mathbb E_a[D^2]=\sum_a\mathbb E_a[X^2]-\sum_a\mathbb E_a[Y]=\lvert\lambda\rvert^2\big[\tfrac{n-3}{2(n-2)}+\tfrac1{n-2}\big]=\tfrac{(n-1)\lvert\lambda\rvert^2}{2(n-2)}$. (At a critical point the same sum from (C) is $\sum_a\lambda_a(\theta-\lambda_a)/(n-2)=-\lvert\lambda\rvert^2/(n-2)$ by tracelessness, so (C) summed over rows is an identity, [r338](REVIEW_r338.md)'s consistency check, *agreement*.)

(d) $\operatorname{Var}_a(X)-\mathbb E_a[D^2]=(\mathbb E_a[X^2]-\mathbb E_a[X]^2)-(\mathbb E_a[X^2]-\mathbb E_a[Y])=\mathbb E_a[Y]-\mathbb E_a[X]^2=\dfrac{\lambda_a(\theta-\lambda_a)}{n-2}-\dfrac{\lambda_a^2}{(n-2)^2}=g(\lambda_a)$.

(e) $\mathbb E_a[D^2]\ge0$ and $\operatorname{Var}_a(X)\ge0$ with (d) give $\mathbb E_a[D^2]\ge\max\{0,-g(\lambda_a)\}$ in every row. $g(\lambda_a)<0$ exactly for $\lambda_a<0$, where $-g=\lvert\lambda_a\rvert[\theta(n-2)+(n-1)\lvert\lambda_a\rvert]/(n-2)^2$, and for $\lambda_a>\theta\tfrac{n-2}{n-1}$, where $-g=\lambda_a[(n-1)\lambda_a-\theta(n-2)]/(n-2)^2$. Sum over rows, use (c), multiply by $(n-2)^2$.

(f) Balanced product at unit norm: $m=\tfrac1n\sqrt{2(n-2)/(n-1)}$, $\theta=(n-1)m$, $N_1=\tfrac{n^2}4m$, $N_2=\tfrac{n^2}4m^2$, and $h=\tfrac n{n-2}m\le(n-2)m=\theta\tfrac{n-2}{n-1}$ for $n\ge5$, so the third sum is empty. Left side: $(n-1)m(n-2)\tfrac{n^2}4m+(n-1)\tfrac{n^2}4m^2=(n-1)^2\tfrac{n^2}4m^2=(n-1)^2\tfrac{n^2}4\cdot\tfrac{2(n-2)}{n^2(n-1)}=\tfrac{(n-1)(n-2)}2$. Equality, and it is attained because every negative row has $\operatorname{Var}=0$ (point mass on the pair $(h,-m)$, Lemma L70's equality case) and every positive row has $\mathbb E[D^2]=0$ (support on $(h,h)$ and $(-m,-m)$). $\square$

**What the budget is.** Identities (a)–(c) hold on all of $\mathcal W_n$ and are spectrum-independent at unit norm: the total variance of the row-means and the total within-pair spread are fixed constants, $\tfrac{(n-1)(n-4)}{2(n-2)^2}$ and $\tfrac{(n-1)}{2(n-2)}$. Identity (d) says that at a critical point each row's spread splits into a spectral part $g(\lambda_a)$ and a within-pair part $\mathbb E_a[D^2]\ge0$. The rows with $0<\lambda_a<\theta\tfrac{n-2}{n-1}$ (S2's interval) *consume* variance (they must spread by at least $g(\lambda_a)>0$) and the rows with $g<0$ must *supply* within-pair spread of at least $-g$; (e) is the statement that the supply fits the fixed budget (c). This is the propagation across rows that Q3 asks about, and it is the only relation this report finds that reads all rows at once.

**At two eigenvalues the budget adds nothing.** With $N_1=qm$, $N_2=qm^2$, $q=\tfrac{N\rho}{1+\rho}$, $m^2=\tfrac1{N\rho}$, the $\Sigma$-bound is $\theta\le m(n-1)\tfrac{(n-2)\rho+n-4}{2(n-2)}$, linear in $\rho$; it equals $(n-1)m$ at $\rho=\tfrac n{n-2}$, and it lies above (iii) on $(0,\tfrac n{n-2})$ (the two agree at $\rho=\tfrac n{n-2}$ and at a negative root only) and above $\Pi$ on $(\tfrac n{n-2},\infty)$. So $\min\{\Pi,\text{(iii)}\}$ dominates it, and the budget's content is entirely at three or more eigenvalues, where it is the only condition that sees $N_1,N_2$ rather than $(h,m)$.

---

## 4. The five questions

**Q1, S1–S4.** All correct; verdicts and the balanced-product hand check are in the table above and in §2–§3.

**Q2, the exact LP.** Over probability measures on the discrete support $\{X_{bc}:(b,c)\in P_a\}$ with $\mathbb E[X]=\mu:=-\lambda_a/(n-2)$ fixed, the maximum of $\operatorname{Var}(X)$ is the Bhatia–Davis value $(\mu-L'_a)(U'_a-\mu)$, where $L'_a,U'_a$ are the smallest and largest pair-means in the support. *Proof*: $(X-L'_a)(U'_a-X)\ge0$ on the support gives $\mathbb E[X^2]\le(L'_a+U'_a)\mu-L'_aU'_a$, i.e. $\operatorname{Var}\le(\mu-L'_a)(U'_a-\mu)$; the two-point measure on $\{L'_a,U'_a\}$ with mean $\mu$ is in the feasible set and attains it. Substituting S3, $g(\lambda_a)\le(\mu-L'_a)(U'_a-\mu)$ is, after expanding, $\lambda_a(\theta-\lambda_a)\le-(L'_a+U'_a)\lambda_a-(n-2)L'_aU'_a$: **the chord bound (i)** with pair-mean extremes, which coincide with the reduced eigenvalue extremes exactly when those have reduced multiplicity $\ge2$. So S4 made exact is (i); Popoviciu is Bhatia–Davis weakened by $(\mu-L)(U-\mu)\le(U-L)^2/4$. At the balanced product, the $\lambda_{\max}$ row's exact condition is $\theta\le(n-1)m=\theta_0(n)$, tight, attained by the two-point measure on $X\in\{h,-m\}$; the $\lambda_{\min}$ row's exact conditions are (ii) and (iii), both $\theta\le\theta_0(n)$, tight. *Agreement*: the exact form is the $\Pi$-bound at the $\lambda_{\max}$ row, which [bounds.md](../findings/bounds.md) already derives by the same two pointwise facts.

**Q3, three or more distinct eigenvalues.** Per row, nothing changes: by Theorem B the hull is $\Delta(L_a,U_a)$ whenever the reduced extremes have multiplicity $\ge2$, and interior eigenvalues touch its edges without ever being vertices; a row with $0<\lambda_a<\theta\tfrac{n-2}{n-1}$ is forced to spread with $\operatorname{Var}_a(X)\ge g(\lambda_a)>0$, and the most it can spread is the chord, which is how (i) arises. What propagates across rows is the budget: Theorem C(c) fixes $\sum_a\mathbb E_a[D^2]$, so the rows that consume variance and the rows that must supply within-pair spread compete for one constant, and (e) is the resulting inequality. That inequality is exact at the balanced product and is the sole place where interior eigenvalues enter through anything other than their own row label.

**Q4, the $S$ matrix.** S1 is an identity in $\lambda_a$ obtained by eliminating $\lambda_a$ between (B) and (C); it says nothing about $S=\sum_cT_{abc}$, which is built from (A) and (B) alone. The joint content extracted here is the budget, and it uses exactly the two properties [r338](REVIEW_r338.md) records ($S$ symmetric with row sums $2(n-2)$, hence column sums $2(n-2)$, and $S\lambda=-2\lambda$), in the computation of $\sum_{abc}T_{abc}\lambda_b^2$ and $\sum_{abc}T_{abc}\lambda_b\lambda_c$. Nothing beyond the eigen-equation was found, and the parabola cannot supply it.

**Q5, the theorem, and where it stops.** Combining §1–§3:

> **THEOREM D (the strongest spectral necessary condition proved here).** *Let $n\ge5$ and $W\in\mathcal W_n$ be $\theta$-critical of unit norm, $h=\lambda_{\max}$, $m=\lvert\lambda_{\min}\rvert$, $\rho=h/m$. Then*
> 1. *$\tfrac1{n-2}\le\rho\le n-2$ ([Lemma L73](../findings/bounds.md), from (B) alone);*
> 2. *$\theta\le m\min\{\,n-1,\ (n-2)\rho^2-2\rho-1\,\}$ (Corollary B2), which dominates Lemma L70 with equality iff $\rho=\tfrac n{n-2}$;*
> 3. *at every row, (i)–(iii) of Theorem B with reduced extremes, the complete per-row hull condition whenever the reduced extremes have multiplicity $\ge2$;*
> 4. *the $\Sigma$-bound of Theorem C(e).*
>
> *If the spectrum takes two values, 2 alone gives $\theta\le\theta_0(n)$ with equality only at the balanced product (Theorem A). If it takes three or more values, the conjunction 1–4 admits $\theta>\theta_0(n)$ at $n=12$ (§5), so this family does not force $\theta\le\theta_0(n)$ beyond the two-eigenvalue class.*

---

## 5. Where the family stops

**The witness.** $n=12$, $N=66$, spectrum $(-m)^{\times30},\ (1.2m)^{\times20},\ (0.375m)^{\times16}$, $m=1/\sqrt{61.05}=0.127984$. Three distinct eigenvalues, every multiplicity $\ge3$, the regime where [plan.md](../plan.md) records the pinned/free split as genuinely present and where the conjecture is open, kernel-free, traceless, unit norm, and $\rho=1.2=\tfrac n{n-2}$ so that every extreme-row bound sits at its balanced crossing.

| condition | value at the witness | admits |
|---|---|---|
| Lemma L73 | $1.2\le10$, $1\le12$ | ✓ |
| $\Pi$ = (ii) at $\lambda_{\min}$ = (i) at $\lambda_{\max}$ | $11m$ | $\theta\le1.407829$ |
| (iii) at $\lambda_{\min}$ | $m(10\cdot1.44-2.4-1)=11m$ | $\theta\le1.407829$ |
| Lemma L70 | $11m$ | $\theta\le1.407829$ |
| (i) at the $0.375m$ rows | $\theta\le0.375m+31.8m$ | $\theta\le4.118$ |
| all lower bounds (ii),(iii) at positive rows, (i) at negative rows | vacuous for $\theta>0$ |, |
| full hull at each row type at $\theta=1.29$ | $\lambda_{\min}$ row: $\mathbb E[Y]=-1.108m^2\in[-1.2m^2,\,1.22m^2]$; $1.2m$ row: $1.066m^2\in[-0.76m^2,\,1.176m^2]$; $0.375m$ row: $0.364m^2\in[-0.925m^2,\,1.1925m^2]$ | ✓ |
| $\Sigma$-bound, $N_1=30m$, $N_2=30m^2$ | $\dfrac{11(5-0.49140)}{10\cdot3.83953}$ | $\theta\le1.291683$ |
| **target** | $\theta_0(12)$ | $1.236033$ |

Every condition in Theorem D holds with $\theta=1.29>\theta_0(12)$. The family therefore stops at three distinct eigenvalues, and the mechanism is the one named in §1: unit norm pins $m$ through $\rho$ only when two values carry all the multiplicity, and the budget (the only joint relation available), recovers part of that pinning ($1.2917$ against the per-row $1.4078$) and not all of it ($1.2360$ needed).

**Why the witness has large multiplicities.** A spectrum with a simple $\lambda_{\min}$ or $\lambda_{\max}$ is cut down by the reduced extremes: at a simple $\lambda_{\min}=-m$ with the remaining mass near $0$, the reduced support has $L'_a\approx0$ and the hull forces $\mathbb E_a[Y]\approx0$, i.e. $\theta\approx-m<0$. The excluded-index effect that [r335](REVIEW_r335.md) and [r338](REVIEW_r338.md) record on the negative side kills every such spectrum; the witness was chosen with all multiplicities $\ge3$ precisely so that the per-row hull is exactly the triangle and passes.

**Realisability is open.** No criterion for Weyl spectra exists in print ([LIT-spectra](LIT-spectra.md)); the witness is a spectrum passing every necessary condition this report proves; it is a statement about the family, and a statement about Weyl tensors would need a realisability criterion.

**The blocked run (recorded, not run).** *Linear programme*: variables $T_{abc}\ge0$ on the $\binom{66}3=45{,}760$ unordered triples of distinct indices (total symmetry and vanishing on repeated indices built in), plus $\theta$; constraints (A), (B), (C) at the witness spectrum, $198$ equalities linear in $(T,\theta)$; objective $\max\theta$. Seconds with any simplex or interior-point solver. *What it decides*: whether the full pinned class $\{$(A), (B), (C), $T\ge0$, $T$ totally symmetric$\}$ admits $\theta>\theta_0(12)$ at an in-scope, kernel-free, three-eigenvalue spectrum. *Outcome $\max\theta\ge\theta_0(12)$*: the pinned class as a whole cannot force $\theta\le\theta_0$ at $n=12$ with three eigenvalues, so no spectral family derived from (A)–(C) alone closes the conjecture, the in-scope, fixed-spectrum counterpart of [T9](../plan.md)'s free-spectrum overshoot at $n=6$ ($1.34>1.2247$), and the cutting must come from Jacobi ([Payne](../references/payne-2010-soliton-metrics/notes.md)), as [LIT-spectra](LIT-spectra.md) predicts. *Outcome $\max\theta<\theta_0(12)$*: the joint symmetric reading is strictly stronger than Theorem D, the gap between $1.2917$ and the LP value measures exactly what the triangle family plus budget leave on the table, and I24 should pursue the joint reading analytically, starting from which rows' triangle constraints are active at the LP optimum. *Outcome infeasible at every $\theta$*: the spectrum is excluded by (A)–(C) jointly, and the reason, read off the dual, would be a fifth spectral condition beyond Theorem D. Neither outcome CERTIFIES realisability, which the LP cannot see. **THIS SENTENCE FIRST READ** *Neither outcome bears on realisability*, **AND THAT IS WRONG FOR THE OUTCOME THAT OCCURRED** ([r1057](REVIEW_r1057.md), 2026-09-21). *A relaxation cannot certify realisability and it DOES refute it above its own optimum: every genuine $T$ is feasible, so a spectrum realisable at $\theta$ forces $\theta\le\max$.* The run returned $\max\theta=0.9242643$, exactly $\tfrac{74239}{10280}m$, so this spectrum is unrealisable at every $\theta$ above that.

---

## 6. Corrections to my own log, and screens taken

- Log phase 3 wrote "interior eigenvalues never reach the hull boundary"; the correct statement is the remark after Theorem B: they reach edges and are never vertices.
- Log phase 3 wrote that the chord over positive rows is minimised at $\lambda_{\max}$ and equals $\Pi$; that holds with global extremes under Lemma L73 (Corollary B3) and fails with reduced extremes when $\lambda_{\max}$ is simple, where the reduced chord is *stronger* (Corollary B4).

**Screens** (seconds each, on spectra I wrote down; transcription insurance only): the witness table above; $\theta_0(12)$, the balanced-product $\Sigma$-identity $55=55$; the two-eigenvalue values $5/\sqrt{60}$ and $7/\sqrt{70}$ against $B_6(4)$ and $B_8(\tfrac52)$; the padded $S^3\times S^3$ and padded $W_{\mathbb{CP}^2}$ rows of §1 and §2. Every figure agrees with the closed forms derived above.
