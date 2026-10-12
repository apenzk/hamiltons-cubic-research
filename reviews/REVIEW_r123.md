# Gate 2, Reviewer 123, the projection $Z(v)$, the fourth-moment lemma, and the odd equality case

Cold audit of the five claims supporting item 1's step 2 and step 3 ([problem.md](../findings/problem.md), lines 175–215). Everything below was derived on paper first; the numerics that follow were written from scratch in this review and are confirmations, not the argument.

**Headline: claim 4 is CLOSED.** The odd fourth-moment lemma now has a complete proof, given in full below. It rests on one identity (for any three reals summing to zero, $\sum t_i^4=\tfrac12(\sum t_i^2)^2$) which makes the source's missing "three-coordinate smoothing" not a smoothing at all but an *exact invariance*, and turns the two-value reduction into three lines. The proof is parity-blind: it re-proves the even case as a corollary, so step 3 is now a single theorem at every $n\ge4$.

## Verdicts

| claim | verdict | deciding argument |
|---|---|---|
| 1, $Z(v)\in\mathcal D_n$ | **CONFIRMED** | Row-sum algebra reproduced exactly; both hypotheses are load-bearing |
| 2, $Z$ is the *orthogonal* projection | **CONFIRMED** | Residual is $b_i+b_j$; $\mathcal D_n=\{b_i+b_j\}^\perp$ by dimension count |
| 3, even $n$, $\sum v^4\ge1/n$ | **CONFIRMED** | Cauchy–Schwarz equality is an iff, so two-valuedness is forced, not permitted |
| 4 (odd $n$, $\sum v^4\ge\frac{n^2+3}{n(n^2-1)}$ | **CONFIRMED), proof supplied** | Zero-sum-triple degeneracy + Lagrange's three-value ceiling, by contradiction |
| 5, odd equality case matches $S^{(n-1)/2}\times S^{(n+1)/2}$ | **CONFIRMED**, one caveat | Ratios identical in $n$; the constant of proportionality is **negative** |

---

## Claim 1, CONFIRMED

Symmetry and hollowness hold by construction. With $\sum_{j\ne i}v_j=-v_i$ and $\sum_{j\ne i}v_j^2=1-v_i^2$,

$$\sum_{j\ne i}Z_{ij}=-v_i^2+\frac{(n-1)v_i^2+(1-v_i^2)}{n-2}-\frac{n-1}{(n-1)(n-2)}=-v_i^2+\frac{(n-2)v_i^2+1}{n-2}-\frac1{n-2}=0 .$$

Reproduced independently, character for character. Requires $n\ge3$ for the formula to be defined; $\mathcal D_3=\{0\}$, so the content starts at $n\ge4$.

**Both hypotheses are used, and the general-$v$ row sum shows exactly how.** For arbitrary $v$ with $s=\sum v$, $q=\sum v^2$,

$$\sum_{j\ne i}Z_{ij}=s\,v_i+\frac{q-1}{n-2},$$

verified numerically at $n=6$ to machine precision. This vanishes for every $i$ iff $s=0$ and $q=1$ (for non-constant $v$). So claim 1 is *equivalent* to the two constraints, not merely implied by them.

## Claim 2, CONFIRMED

The residual algebra is right:

$$(v_iv_j)-Z_{ij}=-\frac{v_i^2+v_j^2}{n-2}+\frac1{(n-1)(n-2)}=a_i+a_j+c,\qquad a_i=\frac{-v_i^2}{n-2},\ c=\frac1{(n-1)(n-2)} .$$

The orthogonality argument is right and is purely formal (see (a) below). Two remarks that tighten it:

**The constant is not a separate case.** $a_i+a_j+c=(a_i+\tfrac c2)+(a_j+\tfrac c2)$, so the residual has the pure form $b_i+b_j$ and the second half of the claimed proof is redundant. Harmless, but the cleaner statement is: *the residual lies in $\mathcal L:=\{(b_i+b_j)_{i<j}:b\in\mathbb R^n\}$.*

**The claim as stated proves only $\mathcal L\perp\mathcal D_n$, which is one inclusion.** For $Z$ to be *the* projection one also needs $Z\in\mathcal D_n$ (claim 1) and that suffices: $E=Z+R$ with $Z\in\mathcal D_n$, $R\perp\mathcal D_n$ is by definition the orthogonal decomposition. It is worth recording that $\mathcal D_n=\mathcal L^\perp$ exactly, by dimension: $\dim\mathcal H_n=\binom n2$, $b\mapsto(b_i+b_j)$ is injective for $n\ge3$ so $\dim\mathcal L=n$, and $\dim\mathcal D_n=\tfrac{n(n-3)}2=\binom n2-n$. The decomposition $\mathcal H_n=\mathcal D_n\oplus\mathcal L$ is therefore exact, which is a slightly stronger and more useful statement than the one in the record.

Numerics: $\max|\langle E-Z,T\rangle|\le2.5\times10^{-16}$ over 20 random $T\in\mathcal D_n$ at each of $n=5,6,7,9,12$.

## Claim 3, CONFIRMED, and "forced" is the right word

$(\sum v_i^2)^2\le n\sum v_i^4$ gives $\sum v^4\ge1/n$. Cauchy–Schwarz equality is an **iff**: it holds precisely when $(v_i^2)_i$ is proportional to $(1)_i$, i.e. every $v_i^2=1/n$, i.e. $v_i=\pm1/\sqrt n$. Then $\sum v=0$ forces equal counts of the two signs, hence $n$ even and exactly $n/2$ each. So the equality set is *exactly* the balanced two-value vectors, up to permutation, forced by the iff, not merely permitted. No smoothing is needed and none is hidden. See (c) below.

## Claim 4, CONFIRMED. A complete proof

This is the one that was open. It is now closed, at every $n\ge4$ and both parities, by the following.

### The identity that does the work

> **Lemma A.** If $t_1+t_2+t_3=0$ then $t_1^4+t_2^4+t_3^4=\tfrac12\,(t_1^2+t_2^2+t_3^2)^2$.

*Proof.* Newton with $e_1=0$: $p_2=-2e_2$ and $p_4=e_1p_3-e_2p_2+e_3p_1=-e_2p_2=2e_2^2=\tfrac12p_2^2$. $\square$ (Confirmed symbolically: $a^4+b^4+(-a-b)^4-\tfrac12(a^2+b^2+(a+b)^2)^2\equiv0$.)

So on any three coordinates whose values sum to zero, the quartic objective depends **only** on their sum of squares. The source's hoped-for "three-coordinate smoothing" is therefore not a smoothing at all: the three-coordinate move is an *exact symmetry of the whole problem*, a circle's worth of directions along which nothing changes. That is simultaneously why every second-order attack fails (below) and why the reduction is easy once seen.

### The two-value reduction

> **Theorem.** Let $n\ge4$ and let $v$ minimise $\sum v_i^4$ on $M=\{\sum v_i=0,\ \sum v_i^2=1\}$. Then $v$ takes at most two distinct values.

*Proof.* $M$ is a compact smooth manifold (a sphere inside a hyperplane) and the gradients $(1,\dots,1)$ and $2v$ are independent at every $v\in M$, since $\sum v=0$ and $v\ne0$ rule out $v\parallel\mathbf1$. So every global minimiser satisfies $4v_i^3=\alpha+2\beta v_i$ for all $i$: each coordinate is a root of $4t^3-2\beta t-\alpha$, and $v$ takes at most three distinct values. The cubic has **no quadratic term**, so if $v$ takes exactly three distinct values $r_1,r_2,r_3$, these are all three roots and $r_1+r_2+r_3=0$.

Suppose that happens. Pick coordinates $i,j,k$ carrying $r_1,r_2,r_3$ and set $\sigma=r_1^2+r_2^2+r_3^2>0$. Let

$$C=\{t\in\mathbb R^3:\ t_1+t_2+t_3=0,\ t_1^2+t_2^2+t_3^2=\sigma\},$$

a circle of radius $\sqrt\sigma$ in the plane $\{\sum t=0\}$. For any $t\in C$, replacing $(v_i,v_j,v_k)$ by $t$ leaves $\sum v$ unchanged (both triples sum to $0$), leaves $\sum v^2$ unchanged (both have square-sum $\sigma$), and by **Lemma A** leaves $\sum v^4$ unchanged (both triples contribute exactly $\sigma^2/2$). The new vector $v'$ is therefore feasible with the *same* objective value, hence is itself a global minimiser, hence itself satisfies the Lagrange condition and takes **at most three distinct values**.

Now choose $t\in C$ with $t_1,t_2,t_3$ pairwise distinct and none of them in $\{r_1,r_2,r_3\}$. Such $t$ exist: each coincidence $t_a=t_b$ cuts out $2$ points of $C$ ($3$ pairs, $6$ points) and each condition $t_a=r_b$ cuts out at most $2$ points ($9$ conditions, at most $18$ points), so at most $24$ points of an infinite circle are excluded. Since $n\ge4$, at least one coordinate of $v$ is untouched, and its value lies in $\{r_1,r_2,r_3\}$. Then $v'$ carries the three new values plus at least one old one: **four or more distinct values.** Contradiction. $\square$

A minimiser cannot be constant ($\sum v=0$ and $\sum v^2=1$ are incompatible with $v$ constant), so it takes exactly two.

### Finishing

Two values $a$ (multiplicity $p$) and $b$ (multiplicity $q=n-p$): $pa+qb=0$ and $pa^2+qb^2=1$ give $a^2=q/(np)$, $b^2=p/(nq)$, and

$$\sum v^4=\frac{p^3+q^3}{n^2pq}=\frac{(p+q)^2-3pq}{n\,pq}=\boxed{\ \frac n{pq}-\frac3n\ }$$

which is **strictly decreasing in $pq$**. With $p+q=n$, $pq$ is maximised uniquely at $\{p,q\}=\{\lfloor n/2\rfloor,\lceil n/2\rceil\}$. Even $n$: $pq=n^2/4$, value $4/n-3/n=1/n$. Odd $n$: $pq=(n^2-1)/4$, value $\frac{4n}{n^2-1}-\frac3n=\frac{n^2+3}{n(n^2-1)}$. Both claimed values, from one argument. $\blacksquare$

### Why the standard attacks all stall, and why that is not an objection

The natural route is second-order necessary conditions. It provably cannot finish, and Lemma A says why. With $g(t)=t^4-\beta t^2-\alpha t$ and $g'(t)=4(t-r_1)(t-r_2)(t-r_3)$, the second-order form on the tangent space is $\sum_ig''(v_i)h_i^2$. Take $h$ supported on the three coordinates $i,j,k$ with

$$h_a=\frac1{\prod_{b\ne a}(r_a-r_b)} .$$

Then $\sum_ah_a=[r_1,r_2,r_3]\mathbf 1=0$ and $\sum_ar_ah_a=[r_1,r_2,r_3]\,t=0$ (divided differences of degree $<2$ over three nodes vanish), so $h$ **is** tangent; and $g''(r_a)=4\prod_{b\ne a}(r_a-r_b)$, so

$$\sum_a g''(r_a)h_a^2=4\sum_a\frac1{\prod_{b\ne a}(r_a-r_b)}=4\,[r_1,r_2,r_3]\mathbf 1=0 .$$

The second-order form is **identically null** on that direction, at every three-valued stationary point, for every choice of roots. Verified numerically at four random root triples: $|Q(h)|\le3\times10^{-14}$. So no second-order argument can exclude three values, the degeneracy is exactly the tangent direction of the circle $C$, and one must use the *global* invariance rather than its infinitesimal shadow. This is worth recording in [problem.md](../findings/problem.md): it explains why the source could assert the smoothing step and never supply it.

What the second-order condition *does* give, for the record, is $m_{\text{middle}}\le2$ (three coordinates at the middle root would admit a strictly negative tangent direction). That is a genuine reduction but strictly weaker than the theorem, and the residual cases $m_{\text{middle}}\in\{1,2\}$ are exactly the ones second order cannot touch. The proof above bypasses it entirely.

### Numerical confirmation

Free SLSQP minimisation, 400 random restarts per $n$:

| $n$ | numeric min | $\frac{n^2+3}{n(n^2-1)}$ | $1/n$ | argmin multiplicities |
|---|---|---|---|---|
| 5 | 0.2333333333 | 0.2333333333 | 0.2 | $2\times0.54772,\ 3\times0.36515$ |
| 7 | 0.1547619048 | 0.1547619048 | 0.142857 | $3,4$ |
| 9 | 0.1166666667 | 0.1166666667 | 0.111111 | $4,5$ |
| 11 | 0.0939393939 | 0.0939393939 | 0.090909 | $5,6$ |
| 13 | 0.0787545788 | 0.0787545788 | 0.076923 | $6,7$ |
| 15 | 0.0678571429 | 0.0678571429 | 0.066667 | $7,8$ |
| 4, 6, 8 | $1/n$ exactly |, | $1/n$ | all $|v_i|$ equal |

Separately, constrained optimisation over **every** three-block multiplicity split $(m_1,m_2,m_3)$ at $n=5,7,9,11,13$ returns the two-value value to $\le4\times10^{-16}$ in every case, with the argmin always collapsing two of the three values, the record's own screening, reproduced, and now explained rather than merely observed.

## Claim 5, CONFIRMED, with a sign caveat

At $a^2=\frac{n+1}{n(n-1)}$, $b^2=\frac{n-1}{n(n+1)}$ with opposite signs one gets $ab=-1/n$ exactly, and then, symbolically in $n$:

$$Z_{aa}=\frac n{(n-1)(n-2)},\qquad Z_{bb}=\frac{n(n-3)}{(n^2-1)(n-2)},\qquad Z_{ab}=-\frac{n(n-3)}{(n^2-1)(n-2)}=-Z_{bb}.$$

Sympy gives $Z_{aa}/Z_{ab}+\frac{n+1}{n-3}\equiv0$ and $Z_{bb}/Z_{ab}+1\equiv0$ as rational-function identities in $n$, and the closed forms above check as exact rationals at $n=5,7,9,11,13,15,21$. The record's $Z_{aa}$ and $Z_{bb}$ match mine exactly; the cross value it leaves unstated is $-Z_{bb}$.

**Structural confirmation, independent of the arithmetic.** A block matrix with value $x$ on $A\times A$ ($|A|=\frac{n-1}2$), $y$ on $B\times B$, $z$ on $A\times B$ lies in $\mathcal D_n$ iff $(|A|-1)x+|B|z=0$ and $(|B|-1)y+|A|z=0$, two independent conditions on three unknowns, so the solution space is **one-dimensional**. Both $Z(v)$ and the stated vertex matrix $(-\frac{n+1}{n-3},-1,1)$ satisfy them, hence they are proportional automatically. Claim 5 is really a corollary of $Z(v)\in\mathcal D_n$ plus the block structure, which is a better reason than the value-by-value match.

**The caveat.** The proportionality constant is
$$Z=\lambda V,\qquad \lambda=Z_{ab}=-\frac{n(n-3)}{(n^2-1)(n-2)}<0\quad\text{for }n>3,$$
so $Z(v)$ is a **negative** multiple of the stated vertex matrix, e.g. $Z=-\tfrac5{36}V$ at $n=5$. Since $P$ is an odd cubic, $P(-S)=-P(S)$, a sign is not free: the record's even-$n$ paragraph disposes of this with "up to the overall sign that scaling absorbs", which is fine when the conclusion is only $S\parallel Z(v)$, but the equality *case* of the chain is $S=Z(v)/|Z(v)|$ with a definite sign. Recommend stating the odd equality case as $S=-V/\lVert V\rVert$, or equivalently fixing the sign convention on the vertex matrix once in [problem.md](../findings/problem.md). This is bookkeeping, not a break.

Also note $n=3$ is excluded outright: $-\frac{n+1}{n-3}$ blows up, and $\mathcal D_3=\{0\}$.

---

## Answers to (a), (b), (c)

**(a) Is claim 2's orthogonality argument purely formal?** **Purely formal, but the claim it belongs to is not.** The step "$R\perp\mathcal D_n$ whenever $R_{ij}=a_i+a_j+c$" uses nothing about $v$: it is the statement $\mathcal L\subseteq\mathcal D_n^\perp$, true for any $a\in\mathbb R^n$, any $c$. What *does* need both hypotheses is the other half, $Z\in\mathcal D_n$, and it needs them exactly, since the general row sum is $s\,v_i+\frac{q-1}{n-2}$, which vanishes identically only at $s=0,q=1$. So: the orthogonality is formal, the projection statement is not, and the record's proof is correctly structured because it proves (a) first.

**(b) Is the odd equality case unique up to permutation and sign?** **Yes for odd $n\ge5$; NO at $n=3$, where everything ties.** For $n\ge4$ the Theorem forces two values, and among two-value vectors $\sum v^4=\frac n{pq}-\frac3n$ is strictly decreasing in $pq$; with $p+q=n$ odd, $pq$ is *strictly* maximised at $\{\frac{n-1}2,\frac{n+1}2\}$, the next split $\{\frac{n-3}2,\frac{n+3}2\}$ gives $pq=\frac{n^2-9}4$, a strict drop (numerically: $0.2333$ vs $0.6500$ at $n=5$; $0.0939$ vs $0.1201$ at $n=11$). The two labellings $(p,q)$ and $(q,p)$ give the same multiset with $a,b$ swapped, i.e. the global sign flip. **No different multiplicity split can tie.** At $n=3$, by contrast, Lemma A says $\sum v^4=\tfrac12(\sum v^2)^2=\tfrac12$ for *every* feasible $v$, which is exactly $\frac{n^2+3}{n(n^2-1)}$ at $n=3$, so the value formula still holds but the minimiser is the whole constraint set. Harmless ($\mathcal D_3=\{0\}$), but the uniqueness claim must carry $n\ge5$.

**(c) At even $n$, is two-valuedness forced or merely permitted?** **Forced.** Cauchy–Schwarz $(\sum v_i^2\cdot1)^2\le(\sum v_i^4)(\sum1)$ has equality iff $(v_i^2)$ and $(1)$ are proportional, which is an *iff*, so equality forces $v_i^2=1/n$ for every $i$, hence $v_i\in\{\pm1/\sqrt n\}$, hence (by $\sum v=0$), exactly $n/2$ of each sign. The equality set is precisely the balanced two-value vectors and nothing else. Independent check: the Theorem above, applied at even $n$, gives $\frac n{pq}-\frac3n$ minimised uniquely at $pq=n^2/4$, i.e. the same vector, by a completely different route. Two proofs, same forced answer. Claim 3's "no smoothing needed" stands.

## What this changes in the record

1. **Step 3 is proved, both parities, at every $n\ge4$**, one theorem, not two cases. [problem.md](../findings/problem.md) line 179's "*Re-derived here*: a three-coordinate smoothing reduces a minimiser to two values" can be replaced by the Theorem above, and the "What remains owed: steps 1 and 3 as proofs" section should drop step 3.
2. **Item 1's stated gap closes.** [plan.md](../plan.md) item 1 says "the item's whole value and its whole gap are the same thing: the odd fourth-moment lemma". That gap is now filled, so, modulo step 1, which the record says already carries a proof in [diagonal-half.md](../findings/diagonal-half.md), the all-$n$ diagonal theorem is complete at odd $n$ too.
3. **Record Lemma A and the null-direction fact.** The divided-difference direction being an exact null direction of the second-order form is the reason no second-order argument closes this, and is worth a line so nobody re-attempts it.
4. **Fix the sign in the odd equality case**, per claim 5's caveat.
5. **Carry $n\ge5$ on the odd uniqueness statement** ($n=3$ is a total tie).

## Method

Every claim was worked by hand before any code ran. The numerics are in a scratch script (not committed): sympy for Lemma A, the closed forms of $Z_{aa},Z_{bb},Z_{ab}$ and the two ratio identities as rational functions of $n$; numpy/scipy for the free minimisation table, the exhaustive three-block screen, the projection residuals, the general-$v$ row-sum formula, and the null-direction check. Toolchain: Python 3.9.6, numpy 2.0.2, scipy 1.13.1, sympy 1.14.0.
