# REVIEW r398, Gate 2 on "the orbit vector is an $M$-eigenvector up to a constant" and "the relation is exact on all of $[n]$": the residual is not a constant, it is a diagonal, and the spectral bound is vacuous at every sphere-product cross pair

*Adversarial review of the last two sections of [ATTEMPTS.md](../ATTEMPTS.md). §0 was derived cold from the definitions before either section was opened: $M\tilde o$ from criticality alone, the restricted form, [Lemma L68](../findings/diagonal-half.md) re-proved, and the exact evaluation at both pair types of $S^m\times S^m$. Analysis only, and the rule was inherited: the arithmetic at $S^p\times S^q$ is exact evaluation of objects this review constructed, reported as a screen; every verdict below also has a closed-form proof that needs no run.*

## Verdict table

| # | Claim | Verdict |
| --- | --- | --- |
| 1 | $\mathbf1^\top\tilde o=0$; $\tilde o_j=M_{jk}$, $\tilde o_k=-M_{jk}$ | **CONFIRMED**, re-derived cold |
| 2 | $M\tilde o-T\tilde o$ is **constant** on $I$ | **REFUTED, exact witness.** At the $S^6\times S^6$ cross pair it is $-\tfrac1{45}$ on $P\setminus\{j\}$ and $+\tfrac1{45}$ on $Q\setminus\{k\}$, against a demanded constant $c=0$ |
| 3 | $c=\dfrac{s_j-s_k}{n-2}$ | **CORRECTED, $c$ is the *mean* of the $I$-residual, not the residual.** The value is right; the section computed the mean and then asserted the residual equals it |
| 4 | $r_j=-s_j-2M_{jk}^2-c$, $r_k=s_k+2M_{jk}^2-c$ | **CONFIRMED**, re-derived cold |
| 5 | the boxed relation $M\tilde o=T\tilde o+c\mathbf1+r_je_j+r_ke_k$ | **REFUTED.** Max coordinate error $\tfrac1{45}=0.0222$ at $S^6\times S^6$, in $10$ of $12$ coordinates; also fails at $S^5\times S^7$, $S^4\times S^8$, $S^3\times S^9$ |
| 6 | "*Consistency: $\mathbf1^\top$ of both sides gives $-cn$ either way*" | **REFUTED as a check.** Both sides give $0$, not $-cn$; and the identity $\mathbf1^\top$ returns **is** the equation that defines $c$, so the check is circular and cannot see claim 2 fail |
| 7 | the twin-pair check | **CONFIRMED but empty.** At a twin pair $\tilde o|_I=0$, so the check is run at the one family of pairs where the disputed content is identically absent |
| 8 | "$s_j=s_k=\theta M_{jk}$ at a twin pair, by [Lemma L68](../findings/diagonal-half.md)" | **CORRECTED.** L68 gives only the *sum* $s_j+s_k=2\theta M_{jk}$; the individual equality needs $s_j=s_k$, which follows from twinness itself, not from L68 |
| 9 | "$\tilde o$ is an approximate $M$-eigenvector, and this is more than an eigenvector of $\widetilde N$" | **REFUTED.** The corrected identity on $I$ reads $(M|_I)u=(T-p)\odot u$ with $p_a=M_{aj}+M_{ak}$, which is **exactly** [post F47](../findings/INDEX-traps.md)'s $\widetilde N o=To$, since $\widetilde N=-\Delta^{(jk)}=M|_I+\operatorname{diag}(p)$. Nothing is added; a diagonal was collapsed to a scalar |
| 10 | the spectral bound $\operatorname{dist}(T,\operatorname{spec}M)\lVert\tilde o\rVert\le\lVert c\mathbf1+r_je_j+r_ke_k\rVert$ | **REFUTED as derived** (it rests on claim 5), and **the inequality it states is strictly stronger than the truth**: the printed right-hand side is always $\le$ the true residual norm |
| 11 | "**this bounds the norm itself by the spectral gap**" / "the first bound … from the spectral gap rather than from a norm budget" | **REFUTED, vacuous.** At every cross pair of every $S^p\times S^q$ with $n\ge5$ the inequality is implied by [Lemma L68](../findings/diagonal-half.md) alone. At the record's in-band points it is $2.5\times$–$3.2\times$ weaker than L68's **exact** value, and $4.9\times$–$5.2\times$ weaker using only what L129 guarantees |
| 12 | "a pair with $M_{jk}<0$ … has $T$ inside the forbidden window" | **CONFIRMED but half the pairs escape it.** At $S^6\times S^6$, $30$ of $66$ pairs have $M_{jk}>0$, so $T>\theta$ and L129 gives **no** lower bound; $31$ of $66$ at $S^5\times S^7$ |
| 13 | "the gap would force $M_{jk}\ge0$ at every pair" | **REFUTED by the record's own maximiser.** $S^6\times S^6$ has $M_{jk}=-0.112367$ at all $36$ cross pairs. The antecedent (an *exact* eigenvector at $T$), is false there, which is claim 2 again |
| 14 | novelty ("nothing of this form in findings/") | **CONFIRMED for the corrected form only.** The sum-vector $p_a=M_{aj}+M_{ak}$ appears nowhere in [findings/](../findings/); but the section's *own* claim is F47 mis-stated, and the $\widetilde N=M'$ reading at padded pairs is already [post F48](../findings/second-order.md) |

**Headline for the parent.** *The boxed identity is false, the error is one line, and the bound built on it would be worthless even if the identity held.* What survives is the corrected identity below, which is [post F47](../findings/INDEX-traps.md) rewritten, so the two sections together add no new mathematics to the record, and one correction to a printed formula is owed.

---

## §0, Derived cold, before either section was opened

Hypotheses used: $M$ hollow symmetric on $[n]$, $M\mathbf1=0$, $\operatorname{tr}M^2=2$, and criticality $M_{ij}^2+(M^2)_{ij}=\theta M_{ij}$ for $i\ne j$. Write $s_a=(M^2)_{aa}=\sum_bM_{ab}^2$, $\tilde o_a=M_{ka}-M_{ja}$ on all of $[n]$, $u=\tilde o|_I$, $T=\theta+M_{jk}$.

**Criticality is off-diagonal, and the section needs that.** On the diagonal the equation would read $0+s_i=0$, so $s_i=0$, false at any $M\ne0$. Every use of criticality below is at $i\ne j$; the two boundary rows are handled by hollowness instead.

**The computation.** $(M\tilde o)_a=\sum_bM_{ab}(M_{kb}-M_{jb})=(M^2)_{ak}-(M^2)_{aj}$. For $a\in I$ both indices are off-diagonal, so criticality applies twice and the quadratic terms difference:

$$(M\tilde o)_a=\big[\theta M_{ak}-M_{ak}^2\big]-\big[\theta M_{aj}-M_{aj}^2\big]=\big(\theta-(M_{aj}+M_{ak})\big)\tilde o_a .$$

For $a=j$ and $a=k$ hollowness gives $(M^2)_{jj}=s_j$ and $(M^2)_{kk}=s_k$, so $(M\tilde o)_j=\theta M_{jk}-M_{jk}^2-s_j$ and $(M\tilde o)_k=s_k-\theta M_{jk}+M_{jk}^2$. Setting $p:=M(e_j+e_k)$, i.e. $p_a=M_{aj}+M_{ak}$ (and noting hollowness makes $p_j=p_k=M_{jk}$, so the formula is uniform), the exact identity on $[n]$ is

$$\boxed{\ M\tilde o=\theta\,\tilde o-p\odot\tilde o-s_je_j+s_ke_k\ }\tag{E1}$$

with $\odot$ entrywise. Equivalently, with $q:=p+M_{jk}\mathbf1$,

$$M\tilde o-T\tilde o=-q\odot\tilde o-s_je_j+s_ke_k,\qquad q_a=M_{aj}+M_{ak}+M_{jk}.\tag{E1$'$}$$

**The restricted form.** $Mu=M\tilde o+M_{jk}\tilde o$, since $(Mu)_a=(M\tilde o)_a-M_{aj}\tilde o_j-M_{ak}\tilde o_k=(M\tilde o)_a+M_{jk}\tilde o_a$. Hence

$$\boxed{\ (M|_I)\,u=(T-p)\odot u\ \text{ on }I,\qquad Mu=Tu-p\odot u-r_je_j+r_ke_k\ \text{ on }[n]\ }\tag{E2}$$

with $r_j:=s_j-\theta M_{jk}$ and $r_k:=s_k-\theta M_{jk}$. **$T$ is the eigenvalue parameter of $u$, not of $\tilde o$**, the "$+M_{jk}$" in $T$ is exactly the correction for deleting the two coordinates.

**[Lemma L68](../findings/diagonal-half.md), re-proved cold.** $\sum_{a\in I}M_{ka}^2=s_k-M_{jk}^2$, likewise for $j$, and $\sum_{a\in I}M_{ka}M_{ja}=(M^2)_{kj}=\theta M_{jk}-M_{jk}^2$. So $\lVert u\rVert^2=s_j+s_k-2\theta M_{jk}$. **CONFIRMED.** And the fact the section never uses:

$$r_j+r_k=\lVert u\rVert^2 .\tag{L68$'$}$$

*The two boundary residuals carry the whole of L68 between them.* This is what makes the spectral bound vacuous in §3.

**What (E2) is.** $\widetilde N=-\Delta^{(jk)}$, the pair block, acts on functions on $I$ by $(\Delta u)_i=\sum_{b\in I}M_{ib}(u_i-u_b)$, whose degree term is $\sum_{b\in I}M_{ib}=-(M_{ij}+M_{ik})=-p_i$. So $\widetilde N=M|_I+\operatorname{diag}(p)$ and (E2) reads $\widetilde Nu=Tu$, [post F47](../findings/INDEX-traps.md) exactly, re-derived from criticality with no reference to it. **The diagonal $\operatorname{diag}(p)$ is precisely the object the section replaces by a scalar.**

## §1, The witness: the residual is not constant on $I$

Take $S^6\times S^6$, the conjectured maximiser, $n=12$, $\theta=\sqrt{55}/6=1.236033081$. Within a factor $M_{ab}=\alpha=1/\sqrt{55}$; across $M_{ab}=\gamma=-\sqrt{55}/66$. (Row sums $0$, $\operatorname{tr}M^2=2$, criticality residual $\le3\times10^{-17}$, screened.) Take $j\in P$, $k\in Q$, so $M_{jk}=\gamma$ and $T=\theta+\gamma=5\sqrt{55}/33$.

For $a\in P\setminus\{j\}$: $q_a=\alpha+2\gamma=-2\sqrt{55}/165$ and $\tilde o_a=\gamma-\alpha=-\sqrt{55}/30$, so by (E1$'$)

$$\big(M\tilde o-T\tilde o\big)_a=-q_a\tilde o_a=-\tfrac1{45},$$

and for $a\in Q\setminus\{k\}$ the same computation gives $+\tfrac1{45}$. The section requires both to equal $c=(s_j-s_k)/(n-2)=0$, since $s_j=s_k=\tfrac16$ here. **The boxed identity is false by $\tfrac1{45}$ in ten of twelve coordinates at the record's own maximiser.**

Screened at the other three splits, all cross pairs, residual values on $I$ against the demanded $c$:

| point | $c$ | true residual on $I$ | $\lVert M\tilde o-\text{claimed RHS}\rVert_\infty$ |
| --- | --- | --- | --- |
| $S^6\times S^6$ | $0$ | $\pm0.022222$ | $2.22\times10^{-2}$ |
| $S^5\times S^7$ | $0.012571$ | $-0.008571$, $+0.026667$ | $2.11\times10^{-2}$ |
| $S^4\times S^8$ | $0.027500$ | $+0.026786$, $+0.029167$ | $1.67\times10^{-3}$ |
| $S^3\times S^9$ | $0.048889$ | $+0.024074$, $+0.148148$ | $9.93\times10^{-2}$ |

**Where the derivation went wrong, in one line.** The "collapse" step reads *"zero row sums kill the first half of each bracket, $\sum_bM_{ib}=0$"*. [r396](REVIEW_r396.md)'s identity is differenced from [post F47](../findings/INDEX-traps.md)'s eigen-equation, which lives on $I$; there $\sum_{b\in I}M_{ib}=-(M_{ij}+M_{ik})=-p_i$, **not** $0$. The full row sum was applied to a restricted sum. The step is compounded by silently replacing $o$ (supported on $I$) by $\tilde o$ (supported on $[n]$) inside the same sums.

**$c$ is nevertheless the correct mean.** Summing the true $I$-residual, $\sum_{a\in I}\tilde o_a=-\tilde o_j-\tilde o_k=0$ kills the $M_{jk}$ part of $q$, and $\sum_{a\in I}(M_{aj}+M_{ak})(M_{ka}-M_{ja})=\sum_{a\in I}(M_{ak}^2-M_{aj}^2)=s_k-s_j$ because the two cross terms cancel. Hence the mean is $(s_j-s_k)/(n-2)=c$. **So claim 3's value is right and its role is wrong**, and this is exactly why the section's own $\mathbf1^\top$ check passes: that check *is* the equation defining $c$, a single linear functional, blind to any residual with the right mean.

**$r_j$, $r_k$ are right.** $(M\tilde o)_j-T\tilde o_j=-2M_{jk}^2-s_j$ and $(M\tilde o)_k-T\tilde o_k=s_k+2M_{jk}^2$, matching the printed $r_j,r_k$ after subtracting $c$.

## §2, The twin-pair check certifies nothing

At a twin pair $M_{ja}=M_{ka}$ for every $a\in I$, so $\tilde o|_I=0$ and $\tilde o=M_{jk}(e_j-e_k)$. **The disputed content of the identity is the $I$-block, and at a twin pair that block is the zero vector**: every candidate value of "the constant on $I$" satisfies it. The check verifies the two boundary coefficients, which were never in doubt, and is silent on claim 2. Re-derived here and it does hold: $M(e_j-e_k)=-M_{jk}(e_j-e_k)$, both sides return $-M_{jk}^2(e_j-e_k)$.

Two further points on it. The citation *"[Lemma L68](../findings/diagonal-half.md) gives $s_j=s_k=\theta M_{jk}$"* is loose: L68 gives $\lVert u\rVert^2=0$, hence only $s_j+s_k=2\theta M_{jk}$; $s_j=s_k$ comes from the rows being equal off the pair, which is twinness. And **at a twin pair $M_{jk}>0$, so $T=\theta+M_{jk}>\theta$ sits outside L129's window**, the case that is exactly checkable is the case in which the whole spectral apparatus of the second section gives nothing.

## §3, The bound is vacuous, and there is a closed-form proof

**(a) The printed inequality is stronger than the truth, and unproven.** The claimed residual vector $c\mathbf1+r_je_j+r_ke_k$ has the correct mean on $I$ but the wrong entries, so by Cauchy–Schwarz $\sum_{a\in I}(\text{true})_a^2\ge(n-2)c^2$ and

$$\big\lVert c\mathbf1+r_je_j+r_ke_k\big\rVert\ \le\ \big\lVert M\tilde o-T\tilde o\big\rVert\quad\text{always.}$$

So the section states a *sharper* inequality than $\operatorname{dist}\cdot\lVert\tilde o\rVert\le\lVert M\tilde o-T\tilde o\rVert$ delivers. It happens to hold at all four screened points, but it is not established anywhere, and it cannot be repaired by the argument given.

**(b) The inequality is implied by [Lemma L68](../findings/diagonal-half.md) alone whenever $\operatorname{dist}\le\lVert u\rVert/\sqrt2$.** Apply the spectral inequality to $u$, whose residual is $-p\odot u-r_je_j+r_ke_k$ by (E2). By (L68$'$), $r_j+r_k=\lVert u\rVert^2$, so $r_j^2+r_k^2\ge\tfrac12(r_j+r_k)^2=\tfrac12\lVert u\rVert^4$ and

$$\lVert Mu-Tu\rVert^2\ \ge\ \tfrac12\lVert u\rVert^4\qquad\text{unconditionally.}$$

Hence $\operatorname{dist}(T,\operatorname{spec}M)\lVert u\rVert\le\lVert Mu-Tu\rVert$ is a **consequence of L68** unless $\operatorname{dist}(T,\operatorname{spec}M)>\lVert u\rVert/\sqrt2$. *That is the content test, and it uses no spectral information at all.*

**(c) The test fails at every cross pair of every sphere product, $n\ge5$, no computation.** At $S^p\times S^q$ the row sums force $(p-1)\alpha_P=-q\gamma$ and $(q-1)\alpha_Q=-p\gamma$, so the non-trivial constant-on-factors eigenvalue is $\lambda_{\max}=(p-1)\alpha_P+(q-1)\alpha_Q=-n\gamma$; and $\gamma=-\theta/(n-1)$, so

$$\lambda_{\max}=\frac{n\theta}{n-1},\qquad M_{jk}=\gamma=-\frac{\theta}{n-1},\qquad \operatorname{dist}(T,\operatorname{spec}M)=\lambda_{\max}-T=\frac{2\theta}{n-1}.$$

With $\lVert u\rVert^2=s_j+s_k+2\theta|M_{jk}|\ge2\theta^2/(n-1)$, the content test $\operatorname{dist}^2>\tfrac12\lVert u\rVert^2$ demands $4\theta^2/(n-1)^2>\theta^2/(n-1)$, i.e. $n<5$. **Vacuous at every $S^p\times S^q$ cross pair for $n\ge5$, independently of $p$ and $q$.** $\square$

**(d) And a band-wide window, from $\operatorname{tr}M^2=2$ and [Lemma L129](../findings/diagonal-half.md)(i) only.** $\lambda_{\max}\le\sqrt{\operatorname{tr}M^2}=\sqrt2$, and L129(i) gives $\lambda_{\max}>\theta>T$, so $\operatorname{dist}\le\sqrt2-\theta+|M_{jk}|$. With $\lVert u\rVert^2\ge2\theta|M_{jk}|$ the content test forces $m^2+(2d-\theta)m+d^2>0$ for $m=|M_{jk}|$, $d=\sqrt2-\theta$. At $\theta=\sqrt{3/2}$ the roots are $0.044818$ and $0.800990$, and the window only widens as $\theta$ grows. **So in the band $\theta\ge\sqrt{3/2}$ the bound is vacuous at every cross pair with $0.045\le|M_{jk}|\le0.80$**, which includes every in-band cross pair the record holds.

**(e) The numbers, screened.** Exact evaluation at the four $n=12$ splits; "$\times$ weaker" is against L68's exact $\lVert\tilde o\rVert$.

| cross pair | $M_{jk}$ | $T$ | $\operatorname{dist}(T,\operatorname{spec}M)$ | $\lVert\tilde o\rVert$ exact | printed bound on $\lVert\tilde o\rVert$ | using only L129's $\operatorname{dist}\ge|M_{jk}|$ |
| --- | --- | --- | --- | --- | --- | --- |
| $S^6\times S^6$ | $-0.112367$ | $1.123666$ | $0.224733$ | $0.797724$ | $1.207719$ ($1.51\times$) | $3.028\times$ |
| $S^5\times S^7$ | $-0.111658$ | $1.116581$ | $0.223316$ | $0.808397$ | $1.351967$ ($1.67\times$) | $3.345\times$ |
| $S^4\times S^8$ | $-0.109233$ | $1.092329$ | $0.218466$ | $0.843424$ | $1.814343$ ($2.15\times$) | $4.302\times$ |
| $S^3\times S^9$ | $-0.103800$ | $1.037999$ | $0.207600$ | $0.914529$ | $2.792802$ ($3.05\times$) | $6.108\times$ |

With the **true** residual of (E1$'$) instead of the printed one the factors are $1.56$, $1.70$, $2.15$, $3.16$ and, on L129 alone, $3.13$, $3.40$, $4.30$, $6.33$. On $u$ rather than $\tilde o$ they are $2.46$, $2.58$, $2.98$, $3.92$ and $4.92$, $5.15$, $5.95$, $7.83$. **In no reading, at no point, does the bound reach L68's exact value, let alone beat it.**

**(f) It gets worse with $n$.** At $S^m\times S^m$, $\operatorname{dist}=2\theta/(n-1)\sim2\theta/n$ while $\lVert u\rVert^2=4/n+2\theta^2/(n-1)\sim7/n$, so $\operatorname{dist}\big/(\lVert u\rVert/\sqrt2)$ decays like $n^{-1/2}$. The section's phrase *"where $T$ sits far from $\operatorname{spec}M$ the orbit vector is small"* describes a regime the band does not contain.

**Verdict on the section's own framing.** *"The first bound in this item that comes from the record's spectral gap rather than from a norm budget"*, **REFUTED.** It is not a bound: at every point where the record can evaluate it, it is a consequence of [Lemma L68](../findings/diagonal-half.md), which is an exact identity for the same quantity. A relation always weaker than an incumbent exact identity for the object it bounds is worth nothing, and the failure is structural, (L68$'$) puts $\tfrac12\lVert u\rVert^4$ into the residual before the spectrum is consulted at all.

## §4, $T>\theta$: how often the window is escaped

$T>\theta\iff M_{jk}>0$, and then L129 gives **no** lower bound on $\operatorname{dist}$. At a diagonal critical point with $\Delta=0$ every positive edge is a twin edge ([diagonal-half.md](../findings/diagonal-half.md)(ii)), so at the sphere products the positive edges are exactly the within-factor pairs:

| point | pairs with $M_{jk}>0$ | share |
| --- | --- | --- |
| $S^6\times S^6$ | $\binom62+\binom62=30$ of $66$ | $45.5\%$ |
| $S^5\times S^7$ | $\binom52+\binom72=31$ of $66$ | $47.0\%$ |
| $S^4\times S^8$ | $6+28=34$ of $66$ | $51.5\%$ |
| $S^3\times S^9$ | $3+36=39$ of $66$ | $59.1\%$ |

So **roughly half the pairs sit outside the window**, and they are exactly the pairs at which the identity is $0=0$. The two failure modes are complementary: where L129 applies, $\tilde o|_I\ne0$ and the identity is false; where the identity is verified, L129 does not apply.

**And the hoped-for consequence is refuted.** The section writes that an exact eigenvector at $T>0$ *"would be forbidden outright, the gap would force $M_{jk}\ge0$ at every pair"*. The implication is sound; the antecedent is false, and $S^6\times S^6$ shows the conclusion is false too, all $36$ cross pairs have $M_{jk}=-0.112367<0$, with $T=1.123666$ squarely inside $(0,\theta]$. **The gap does not force $M_{jk}\ge0$, and the record already held the counterexample.**

## §5, Novelty

- **The eigen-relation is already on record.** [Post F47](../findings/INDEX-traps.md) / [second-order.md](../findings/second-order.md) has $\widetilde No=To$ exactly, at every pure critical point, from $B(u-v)=0$. Corrected identity (E2) *is* that statement, since $\widetilde N=M|_I+\operatorname{diag}(p)$. **The section's "extension" is F47 with a diagonal mistaken for a scalar.**
- **The $M$-level reading at padded pairs is already on record**, [post F48](../findings/second-order.md): at a padded pair $\widetilde N=M'$ itself.
- **What is genuinely absent from [findings/](../findings/)** is the sum-vector $p_a=M_{aj}+M_{ak}$ and the form (E1)/(E1$'$), a grep over the whole of [findings/](../findings/) returns nothing for it. That is the one thing worth recording out of these two sections, and it is a two-line consequence of criticality.

## §6, Hypotheses used without being stated

1. **Criticality is off-diagonal only.** On the diagonal it forces $s_i=0$. Both sections use it at $i\ne j$ and use hollowness at $a\in\{j,k\}$, correctly, but never say which is doing the work.
2. **$\sum_bM_{ib}=0$ over $b\in[n]$, applied to a sum over $b\in I$.** This is the error; the honest value is $-p_i$.
3. **$o$ silently replaced by $\tilde o$ inside [r396](REVIEW_r396.md)'s brackets**, which is the same substitution in a second place.
4. **$n\ge3$** for $c=(s_j-s_k)/(n-2)$; at a padded pair with $n=2$ the constant is undefined.
5. **$s_j=s_k$ at a twin pair is attributed to [Lemma L68](../findings/diagonal-half.md)**, which gives only the sum.
6. **"the distance to the spectrum is bounded below by the window's own geometry"** is never made a number. It is $\min(T,\theta-T)$, which for $M_{jk}<0$ is $|M_{jk}|$, half the true distance at every sphere-product cross pair, where $\operatorname{dist}=2|M_{jk}|$ exactly.

## §7, What a successor is owed

1. **Correct the printed identity to (E1$'$)** ($M\tilde o=T\tilde o-q\odot\tilde o-s_je_j+s_ke_k$, $q_a=M_{aj}+M_{ak}+M_{jk}$) and record that $c$ is its mean on $I$, not its value.
2. **Record the content test** $\operatorname{dist}(T,\operatorname{spec}M)>\lVert o^{(jk)}\rVert/\sqrt2$ as a fence post: below it, any spectral-gap bound on $\lVert o^{(jk)}\rVert$ is a corollary of [Lemma L68](../findings/diagonal-half.md). It rules the method out at every $S^p\times S^q$ cross pair for $n\ge5$, and band-wide for $0.045\le|M_{jk}|\le0.80$.
3. **The route the identity does support** is the reverse reading: (E2) lower-bounds $\sum_{a\in I}p_a^2u_a^2$, the sum-vector-weighted orbit mass. At $S^6\times S^6$ that quantity is $3.1\times10^{-4}$ against a bound of $\operatorname{dist}^2\lVert u\rVert^2-r_j^2-r_k^2=-0.156$, so the reading is vacuous there too, but it is the only direction in which the relation is not competing with an exact identity.
