# VERIFY v221, Lemma L38, two families capped, in closed form and strictly decreasing

**Cold read of [BRIEF_L38.md](BRIEF_L38.md), sections A–C, against [results.md](../results.md), [findings/ungraded-slack.md](../findings/ungraded-slack.md), [findings/graded-half.md](../findings/graded-half.md), [findings/target.md](../findings/target.md), [findings/algebra.md](../findings/algebra.md), [findings/second-order.md](../findings/second-order.md) and [findings/conventions.md](../findings/conventions.md). No numerical work of any kind was done, no script, no Sage, no Python, no numeric evaluation. Every value below is exact arithmetic carried by hand, and the two hand computations of Lie-algebra bracket masses are reported as screens of claims already on the record, never as evidence for a new positive claim. Log: [agent_logs/verify-L38-v221.log](../agent_logs/verify-L38-v221.log).**

## Claim table

| # | claim | verdict |
|---|---|---|
| 1 | $\mathbb{CP}^m$: $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$ | **CORRECT**, derived two ways, holds on $m\ge2$ |
| 2 | $p=\dim\mathfrak k=\binom m2$, $q=\dim\mathfrak m=\binom{m+1}2-1$ for $(\mathfrak{su}(m),\mathfrak{so}(m))$ | **CORRECT** |
| 3 | Kähler: $\theta^2=\frac{m(m+1)}{(m-1)(m+2)}$ | **CORRECT**, re-derived from [L39](../results.md) here in full |
| 4 | The identity $\frac{m(m+1)}{(m-1)(m+2)}=\frac X{X-2}$, $X=m(m+1)$ | **CORRECT**, exact |
| 5 | Range of the Kähler form | **HYPOTHESIS OMITTED**, $m\ge2$ is used twice and stated nowhere |
| 6 | Both strictly decreasing in $m$ | **CORRECT**, on $m>1$; derivative numerator $-3(3m^2-2m+1)$ confirmed |
| 7 | Maximum $\tfrac32$ at $m=2$ | **CORRECT**, and it needs $m\ge2$, not mere monotonicity |
| 8 | The two families meet at $m=2$ and nowhere else, by $m^2-3m+2=0$ | **CORRECT**, polynomial confirmed exactly |
| 9 | The $m=2$ member of the second family is $W_{\mathbb{CP}^2}$ | **CORRECT**, spectrum $(2,-1,-1,0,0,0)/\sqrt6$ reproduced from two independent forms |
| 10 | "Neither family exceeds $\sqrt{3/2}$ anywhere" | **CORRECT**, with equality attained |
| 11 | The headline word "capped" | **MISLEADING**, both families exceed $\Theta_n$ at their own $n$ for small $m$ |
| 12 | Annotation: both exceed $\theta_0(2m)$ at $m=2$; $\mathbb{CP}^m$ ties at $m=3$; sign $-(2m-1)(m-3)$ | **CONFIRMED**, closed form derived below |
| 13 | Annotation: Kähler $m=3$ at $\sqrt{6/5}$ above $\Theta_6=\sqrt{10/9}$ | **CONFIRMED** |
| 14 | Annotation: the caps license only $\sqrt{3/2}<\Theta_n$ at $n\ge12$, and fence without separating | **CONFIRMED** |
| 15 | Annotation: the pointer is false, and was half-false when stamped | **CONFIRMED**, the named section located in git |
| 16 | Annotation: the $\mathbb{CP}^m$ half duplicates [L10](../findings/graded-half.md) | **CONFIRMED**, and L10 is strictly the stronger statement |
| 17 | Annotation: the report tex gives the $\mathbb{CP}^m$ limit as $1$ | **NO LONGER REPRODUCIBLE**, the row now reads $\tfrac23$, which is correct |
| 18 | Annotation: the block's closing LaTeX is broken | **CONFIRMED**, still broken today |
| 19 | Weyl-ness and criticality of the Kähler two-eigenvalue point at general $m$ | **HYPOTHESIS-DEBT**, no closed-form argument on file |
| 20 | The $h^\vee$/$I_\rho$ row that supplies $S_{\mathfrak{kkk}}=(m-2)p$ | **SCOPED CORRECTION**, the row is generic-$m$ data; $c=m-2$ survives at $m=3,4$ by another route |

**Verdict: PROVEN, hypotheses corrected.** Both closed forms, the monotonicity, the meeting point and the $m=2$ identification are correct and are derivable from what is on file; the second family's range $m\ge2$ must be stated; the headline word "capped" must go; and one debt is booked, that no argument on file establishes at general $m$ that the Kähler two-eigenvalue operator lies in $\mathcal W_{2m}$ at all.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md):

- $\mathcal W_n$, "the space of algebraic Weyl curvature operators on $\mathbb R^n$".
- $\theta$, "$P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$".
- $\theta_0(n)$, "**the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.** *It is the value at the balanced sphere product **at even $n$ only**…*; the target of Problem P is $\Theta_n$."
- $\Theta_n$, "the diagonal maximum; equals $\theta_0(n)$ at even $n$, and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$".
- $M(n)$, "**the global maximum** of $P$ on the unit sphere of $\mathcal W_n$… padded $W_{\mathbb{CP}^2}$ giving $M(n)\ge\sqrt{3/2}$… $M=\sqrt{3/2}$ against $\Theta_4=0.866$ and $\Theta_6=1.0541$".
- $\mathfrak m$, "at a critical point, $\mathfrak m=E_{\min}$… **$\mathfrak m$ carries three incompatible senses across the record**, this one, [L36](../findings/isotropy-cap.md)'s whole negative eigenspace, and [target.md](../findings/target.md)'s symmetric-pair odd part, so read it from context".

**Every member of both families has $n=2m$.** $\mathbb{CP}^m$ is a real $2m$-manifold and its Weyl operator acts on $\Lambda^2\mathbb R^{2m}$; the Kähler pair is stated "inside $\mathfrak{so}(2m)$". So $n=2m$ is even throughout and $\Theta_{2m}=\theta_0(2m)$, with

$$\Theta_{2m}^2=\theta_0(2m)^2=\frac{2(2m-1)(2m-2)}{4m^2}=\frac{(m-1)(2m-1)}{m^2}.$$

**Symbol collisions actually in play, resolved.** $m$ is the family index in both halves and gives $n=2m$ in both, so the two uses agree; it is *not* [route-a.md](../findings/route-a.md)'s $n-4$ nor its attained maximum. $p$ and $q$ are $\dim\mathfrak k$ and $\dim\mathfrak m$, **not** sphere-product factor dimensions, at $m=2$ they are $1$ and $2$ with $p+q=3\ne n=4$, so a reader importing the $S^p\times S^q$ sense of the adjacent [L36](../results.md) entry goes wrong immediately; L38 guards this by defining both inline. $\mathfrak m$ is [target.md](../findings/target.md)'s symmetric-pair odd part, the third of conventions.md's three senses, and the *immediately preceding* canon entry, L36, uses the isotropic-negative-eigenspace sense two paragraphs above. $X$ and $\mathfrak k$ appear in no row of [conventions.md](../findings/conventions.md) at all; L38 defines both inline, which is the only reason it is readable.

## 1. The hypothesis inventory, what L38 needs, what it says, what it uses

| # | hypothesis | stated in L38? | used? | consequence |
|---|---|---|---|---|
| H1 | $m\ge2$ on the $\mathbb{CP}^m$ family | **yes**, in [results.md](../results.md); **no**, in the block | yes, twice | fine |
| H2 | $m\ge2$ on the Kähler family | **nowhere**, in either | yes, twice | **omission, section 4** |
| H3 | $(\mathfrak{su}(m),\mathfrak{so}(m))$ is a symmetric pair inside $\mathfrak{so}(2m)$ | yes | yes, it is what kills $S_{\mathfrak{kkm}}$ and $S_{\mathfrak{mmm}}$ | fine |
| H4 | $\mathfrak{su}(m)$ has Killing constant $c=2m$ in the ambient normalisation | no | yes, via $S_{\mathfrak{kkk}}+S_{\mathfrak{kmm}}=cp$ | imported from [target.md](../findings/target.md) |
| H5 | $S_{\mathfrak{kkk}}=(m-2)p$ | no | yes | imported; **section 9** |
| H6 | The two-eigenvalue operator lies in $\mathcal W_{2m}$ and is critical | no | not by the value claim; **yes by every consumer of the cap** | **debt, section 8** |
| H7 | Fox's $S^r(\alpha)$: $\alpha$ an orthogonal complex structure on an $r$-dimensional subspace, $r$ even, $4\le r\le n$ | no | yes, for the $\mathbb{CP}^m$ value | imported from [algebra.md](../findings/algebra.md) |
| H8 | $\dim\mathcal W_{2m}^{U(m)}=1$ | no | yes, for the second $\mathbb{CP}^m$ route | imported from [target.md](../findings/target.md) |
| H9 | $\theta$ is unchanged by zero-padding | no | yes, by the only reading under which "capped" is useful | imported from [problem.md](../findings/problem.md) |

**A hypothesis stated but never used: none found.** H1 earns its place, it is what makes "maximum $\tfrac32$ at $m=2$" true rather than false, since as a real function the $\mathbb{CP}^m$ form blows up as $m\to1^+$.

**A step using a hypothesis never stated: two.** H2 throughout, and H9 wherever the cap is read at $n\ge12$.

## 2. The $\mathbb{CP}^m$ value, derived, and its range

**Route one, Fox.** [algebra.md](../findings/algebra.md) records Fox's Lemma 10.1, which builds an idempotent $S^r(\alpha)$ from an orthogonal complex structure $\alpha$ on an $r$-dimensional subspace for every even $r$ with $2\le r\le n$, and his (10.4), $\lvert S^r\rvert^2=\frac{6r(r-2)}{(r+2)(r-1)}$ in his metric. Fox's metric is complete contraction, "exactly $4\times$ Frobenius", so $\theta^2=4/\lvert S^r\rvert^2_{\text{Fox}}$ and

$$\theta(S^r)^2=\frac{4(r+2)(r-1)}{6r(r-2)}=\frac{2(r+2)(r-1)}{3r(r-2)}.$$

At $r=2m$ this is $\dfrac{2(2m+2)(2m-1)}{3\cdot2m(2m-2)}=\dfrac{4(m+1)(2m-1)}{12m(m-1)}=\dfrac{(m+1)(2m-1)}{3m(m-1)}$, **exactly the recorded form**.

**The range is forced by the source, not only by the denominator.** $r=2$, i.e. $m=1$, gives $\lvert S^2\rvert^2=\frac{6\cdot2\cdot0}{4\cdot1}=0$, the idempotent is trivial, which is why [L10](../findings/graded-half.md) writes "**$m=1$ is inadmissible**, the denominator vanishes and Fox declares $S^2(\alpha)$ trivial". So the admissible range is $r\ge4$, i.e. $\boxed{m\ge2}$, and the canon states it.

**Route two, the projector form, checked independently here.** [second-order.md](../findings/second-order.md) and [nondegeneracy.md](../findings/nondegeneracy.md) carry $e=W/\theta$ in the three $U(m)$-isotypic projectors of $\Lambda^2\mathbb R^{2m}$,

$$e=-\frac1{2m-1}P_{\mathfrak m}+\frac{m-2}{(m+1)(2m-1)}P_{\mathfrak{su}(m)}+\frac{2(m-1)}{2m-1}P_\omega,$$

with $\dim P_{\mathfrak m}=m(m-1)$, $\dim P_{\mathfrak{su}(m)}=m^2-1$, $\dim P_\omega=1$, summing to $m(2m-1)=\dim\Lambda^2\mathbb R^{2m}$. Two checks, both by hand. **Traceless:** $\frac1{2m-1}\big[-m(m-1)+(m-2)(m-1)+2(m-1)\big]=\frac{m-1}{2m-1}\big[-m+m-2+2\big]=0$. **Norm**, using $\theta^2=1/\lVert e\rVert^2$:

$$\lVert e\rVert^2=\frac{m-1}{(2m-1)^2(m+1)}\Big[m(m+1)+(m-2)^2+4(m-1)(m+1)\Big]=\frac{(m-1)\,3m(2m-1)}{(2m-1)^2(m+1)}=\frac{3m(m-1)}{(m+1)(2m-1)},$$

the bracket collapsing as $m^2+m+m^2-4m+4+4m^2-4=6m^2-3m$. Inverting gives $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$ again. **Two routes, one value.**

**The anchors the block claims are reproduced, checked.** $m=2$: $\frac{3\cdot3}{3\cdot2\cdot1}=\tfrac32=M(4)^2$ per [conventions.md](../findings/conventions.md). $m=3$: $\frac{4\cdot5}{3\cdot3\cdot2}=\tfrac{10}9$, and $\theta_0(6)^2=\frac{2\cdot5\cdot4}{36}=\tfrac{10}9$. **Both confirmed.**

## 3. The Kähler value, $p$, $q$, the identity, and the derivation

**$p$ and $q$ against the pair named.** $\dim\mathfrak{su}(m)=m^2-1$ and $\dim\mathfrak{so}(m)=\binom m2$, so $p=\binom m2$ is correct and

$$q=\dim\mathfrak m=(m^2-1)-\tfrac{m(m-1)}2=\tfrac{m^2+m-2}2=\tbinom{m+1}2-1=\tfrac{(m-1)(m+2)}2 ,$$

which is the recorded $\binom{m+1}2-1$. **Both correct**, and $p+q=m^2-1=\dim\mathfrak{su}(m)$ closes the count.

**The identity.** $X-2=m^2+m-2=(m+2)(m-1)$, so $\frac X{X-2}=\frac{m(m+1)}{(m-1)(m+2)}$ **exactly**. There is a third form the record also carries and it is the cleanest: $q=\frac{X-2}2$, so

$$\theta^2=\frac X{X-2}=1+\frac2{X-2}=1+\frac1q=\frac{\dim\mathfrak m+1}{\dim\mathfrak m}.$$

**The derivation, re-run here from [L39](../results.md).** L39 gives $\theta^2=\frac{(S_{\mathfrak{kkk}}q^2+3S_{\mathfrak{kmm}}p^2-2p^3+2pq^2)^2}{4p^3q(p+q)^3}$ with $S_{\mathfrak{kkm}}=S_{\mathfrak{mmm}}=0$ for any symmetric pair. Substituting the record's $S_{\mathfrak{kkk}}=(m-2)p$ and $S_{\mathfrak{kmm}}=mq$, the bracket is

$$(m-2)pq^2+3mqp^2-2p^3+2pq^2=p\big(mq^2+3mpq-2p^2\big).$$

Write $u=\frac{m-1}2$, so $p=um$, $q=u(m+2)$, $p+q=m^2-1$. Then

$$mq^2+3mpq-2p^2=u^2m\big[(m+2)^2+3m(m+2)-2m\big]=u^2m\big[4m^2+8m+4\big]=4u^2m(m+1)^2,$$

so the bracket is $4u^3m^2(m+1)^2$ and

$$\theta^2=\frac{16u^6m^4(m+1)^4}{4(um)^3\,u(m+2)\,(m^2-1)^3}=\frac{4u^2m(m+1)}{(m+2)(m-1)^3}=\frac{m(m+1)}{(m-1)(m+2)}$$

on $u^2=\frac{(m-1)^2}4$. **The recorded value, exactly.**

**The two inputs, checked rather than taken.** $S_{\mathfrak{kmm}}$ is not independent: summing $\sum_{b\in\mathfrak g}\lVert[a,b]\rVert^2=c\lVert a\rVert^2$ over an orthonormal basis of $\mathfrak k$ and splitting $\mathfrak g=\mathfrak k\oplus\mathfrak m$ gives $S_{\mathfrak{kkk}}+S_{\mathfrak{kmm}}=cp$, so with $c=2m$ and $S_{\mathfrak{kkk}}=(m-2)p$, $S_{\mathfrak{kmm}}=(m+2)p=(m+2)\frac{m(m-1)}2=m\cdot\frac{(m-1)(m+2)}2=mq$, **the record's "which equals $mq$ identically", confirmed as an identity and not a coincidence.**

$S_{\mathfrak{kkk}}=(m-2)p$ I screened by hand at three values rather than importing the $h^\vee$ table (see section 9 for why that table is not usable at all of them). Since $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k$, $S_{\mathfrak{kkk}}=c_{\mathfrak k}p$ where $c_{\mathfrak k}$ is $\mathfrak k$'s own bracket constant in the ambient inner product. Under the record's $\Lambda^2$ normalisation ($\lVert e_i\wedge e_j\rVert=1$) a direct structure-constant count gives $c(\mathfrak{so}(k)\subset\mathfrak{so}(k))=2(k-2)$, the $2(n-2)$ of [target.md](../findings/target.md)'s own first table row. Here $\mathfrak{so}(m)$ sits in $\mathfrak{so}(2m)$ through $\mathbb R^m\oplus\mathbb R^m$, which **doubles the inner product** on $\mathfrak k$; a doubled metric halves this constant, giving $c_{\mathfrak k}=m-2$ **at every $m\ge2$**, with no simplicity hypothesis anywhere. Screened against $m=2$ ($\mathfrak{so}(2)$ abelian, $c=0=m-2$) and $m=3$ (a direct $[e_{23}+e_{56},e_{31}+e_{64}]=-e_{12}-e_{45}$ computation returning $c=1=m-2$). **Reported as a screen of a claim already on the record, not as evidence for a new one.**

## 4. Monotonicity, and the range each needs

**The $\mathbb{CP}^m$ half.** With $f(m)=\frac{2m^2+m-1}{3m^2-3m}$,

$$(4m+1)(3m^2-3m)-(2m^2+m-1)(6m-3)=(12m^3-9m^2-3m)-(12m^3-9m+3)=-9m^2+6m-3=-3(3m^2-2m+1),$$

so $f'(m)=\frac{-3(3m^2-2m+1)}{(3m^2-3m)^2}$. The annotation's numerator is **exactly right**, and $3m^2-2m+1$ has discriminant $4-12=-8<0$ with positive leading coefficient, hence is strictly positive on all of $\mathbb R$. **So $f$ is strictly decreasing on each connected component of its domain**, in particular on $(1,\infty)$.

**The Kähler half.** $\theta^2=1+\frac1q$ with $q=\frac{(m-1)(m+2)}2$ strictly increasing for $m>1$, even more immediate than the block's $1+\frac2{X-2}$, and the same statement. Strictly decreasing on $(1,\infty)$.

**The range, and this is where the block and the canon are wrong in different ways.** Monotonicity alone does **not** give "maximum $\tfrac32$ at $m=2$": on $(1,2)$ both forms exceed $\tfrac32$ and both blow up as $m\to1^+$. What delivers the maximum is the restriction to integers $m\ge2$. Reading the three sources:

- The **block**'s own text states no range at all, for either family. **The annotation "MONOTONICITY IS PROVED FOR BOTH, ON A RANGE THE BLOCK NEVER STATES" is confirmed.**
- The **canon** states $m\ge2$ for the first family and **nothing for the second**. **Confirmed**, and this is the omission H2.
- The **landscape line** states no range for either.

**$m\ge2$ is also the right range geometrically for the second family**, so the fix is a statement and not a restriction: $\mathfrak{su}(1)=0$, so $m=1$ carries no pair, and $X-2=0$ makes the form a pole rather than a value. **The repair is one clause: "for the Kähler family, $m\ge2$."**

## 5. The meeting point, and the $m=2$ member

**The polynomial is the right one.** Setting the two forms equal and cancelling the common $\frac{m+1}{m-1}$, legitimate on $m\ge2$:

$$\frac{2m-1}{3m}=\frac m{m+2}\iff(2m-1)(m+2)=3m^2\iff 2m^2+3m-2=3m^2\iff m^2-3m+2=0 .$$

**$m^2-3m+2$ is confirmed exactly**, with roots $m=1,2$. The root $m=1$ is outside both domains (it is where both forms are undefined) so on the family's own range the unique meeting point is $m=2$. **The claim holds, and the reason it is not merely "$m=2$ is a root" is that the second root is the excluded singular point, which is worth saying out loud.**

**The identification of the $m=2$ member, checked from two directions.**

*From the pair.* At $m=2$: $\mathfrak g=\mathfrak{su}(2)\subset\mathfrak{so}(4)$, $\mathfrak k=\mathfrak{so}(2)=\mathbb R\omega$ with $p=1$, $\mathfrak m$ with $q=2$, kernel of dimension $6-3=3$. The trace condition $ap+bq=0$ forces $a=-2b$, and unit norm $a^2p+b^2q=1$ gives $6b^2=1$: the spectrum is $\pm(2,-1,-1,0,0,0)/\sqrt6$. **The annotation's spectrum, confirmed in closed form.** $\theta^2=1+\frac1q=\tfrac32$, agreeing with $\frac X{X-2}=\tfrac64$.

*From $\mathbb{CP}^2$.* Reading section 2's projector form at $m=2$: the $P_{\mathfrak{su}(m)}$ coefficient $\frac{m-2}{(m+1)(2m-1)}$ **vanishes exactly at $m=2$**, so $e$ has spectrum $\tfrac23$ once, $0$ three times, $-\tfrac13$ twice, $\lVert e\rVert^2=\tfrac23$, $\theta^2=\tfrac32$, and $W=\theta e$ has spectrum $\frac{\sqrt{3/2}}3(2,0,0,0,-1,-1)=(2,-1,-1,0,0,0)/\sqrt6$ since $\frac{\sqrt{3/2}}3=\frac1{\sqrt6}$. **The same operator.**

*And the structure matches.* In $\Lambda^2\mathbb R^4=\Lambda^+\oplus\Lambda^-$, the $U(2)$ decomposition puts $\mathbb R\omega\oplus[\Lambda^{2,0}]$ on one chiral factor and $\mathfrak{su}(2)$ on the other. So the support is one chiral $\mathfrak{su}(2)$ with $\mathfrak k=\mathbb R\omega=\mathfrak{so}(2)$ and the kernel is the opposite chirality, **the annotation's description, confirmed**, and corroborated independently at [target.md](../findings/target.md), which records the same eigenvalues as $0.816497,-0.408248,-0.408248,0,0,0$ ($2/\sqrt6=0.816497$).

## 6. "Capped", in what sense, and what the headline should say

**The sense in which the families are capped: $\sup\theta=\sqrt{3/2}$ over both families and every zero-padding of a member, attained.** That is true and is what the canon's body says. **The sense the word invites ("below the target"), is false**, and it is false at exactly the members the record cares about.

**At the member's own $n=2m$, in closed form.** For $\mathbb{CP}^m$,

$$\theta^2-\Theta_{2m}^2=(2m-1)\left[\frac{m+1}{3m(m-1)}-\frac{m-1}{m^2}\right]=(2m-1)\cdot\frac{m(m+1)-3(m-1)^2}{3m^2(m-1)}=\frac{-(2m-1)^2(m-3)}{3m^2(m-1)},$$

since $m(m+1)-3(m-1)^2=-2m^2+7m-3=-(2m-1)(m-3)$. **The sign is $-(m-3)$, so the annotation's "$-(2m-1)(m-3)$" carries the right sign and the same zero.** Hence: **above** $\Theta_4$ at $m=2$ ($\tfrac32$ against $\tfrac34$), **exactly equal** to $\Theta_6$ at $m=3$ ($\tfrac{10}9$ both), **strictly below** from $m\ge4$.

For the Kähler family, $\theta^2-\Theta_{2m}^2=\frac{-m^4+2m^3+6m^2-7m+2}{m^2(m-1)(m+2)}$, whose numerator is $+12$ at $m=2$, $+8$ at $m=3$ and $-58$ at $m=4$. So it is **above at $m=2$ and $m=3$** (the annotation's $\sqrt{6/5}$ against $\Theta_6=\sqrt{10/9}$) and below from $m=4$. **The annotation's "Both drop below only from $m\ge4$" is confirmed**, with the refinement that $\mathbb{CP}^3$ ties rather than falls.

**What the cap does license, and the boundary that makes it useful.** $\theta_0(n)^2-\tfrac32=\frac{n^2-12n+8}{2n^2}$, with roots $6\pm2\sqrt7$, the record's own crossover, $6+2\sqrt7=11.2915$. So $\sqrt{3/2}<\Theta_n$ exactly for even $n\ge12$. Since padding preserves $\theta$ and Fox's construction runs at every even $r\le n$, **at $n\ge12$ every member of either family and every padding of one sits at $\le\sqrt{3/2}<\Theta_n$.** That is a real statement. **It is also inert**, because the bound is *attained*, at padded $W_{\mathbb{CP}^2}$, which is the record's own conjectured maximiser and the equality case of the whole programme. **The annotation's "it fences and never separates" is confirmed**, and it is the same conclusion [target.md](../findings/target.md) reached on its own: "the class's own supremum is $\sqrt{3/2}$, attained, so this formula can never bound the class strictly below the target."

**The correct headline.** Not "two families capped". The result is:

> **Lemma L38, two families in closed form, both strictly decreasing on $m\ge2$, with common maximum $\theta^2=\tfrac32$ attained at their shared $m=2$ member $W_{\mathbb{CP}^2}$.**

**Why this is not a wording question.** Under the "capped" reading a consumer may take these families as *excluded* competitors. They are not: at $n=4$ and $n=6$ (their own dimensions), three of the four smallest members sit at or above $\Theta_n$, and $W_{\mathbb{CP}^2}$ is above $\Theta_4$ by $\tfrac32$ against $\tfrac34$, a factor of two in $\theta^2$. What the lemma actually supplies to the programme is the opposite service to exclusion: it exhibits the conjectured maximiser as the *first* member of two natural infinite families along which $\theta$ decreases, which is a structural statement about the equality case, not a fence around it.

## 7. The pointer, and the duplication

**The pointer. Confirmed false, and confirmed half-false at birth.** The canon's `**Proof:** [ungraded-slack.md](findings/ungraded-slack.md)` names a file. The pointer the annotation refers to was *inside* the block and was removed by the very commit that added the annotations, [ff9c923e](../findings/ungraded-slack.md); `git show ff9c923e^` recovers it:

> *Numbered here on 2026-08-31: the result was numbered in [report/](../report/) and the mathematics has always been in this file, but it carried no block. The statement is below; **the argument is in this file under "The subalgebra family: $\theta$ from $\dim\mathfrak h$ alone, and Conj"**.*

**What the named section actually derives.** [ungraded-slack.md](../findings/ungraded-slack.md) line 73, "The subalgebra family: $\theta$ from $\dim\mathfrak h$ alone, and Conjecture A proved on it", derives the **Casimir family** $W_{\mathfrak h}=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ with $\theta=\frac2n\sqrt{\frac{rN}{N-r}}$, the cap $r\le\frac{n(n-2)}4$ hence $\theta\le\theta_0(n)$, and the equality case at the balanced split. **Neither of L38's formulas appears in it.** Its own closing paragraph reads: "The unbalanced products, **$\mathbb{CP}^m$**, $\mathbb{HP}^m$, the complex Grassmannians and every generic ungraded point sit **outside** the family." **The annotation is exactly right on both halves.**

**And the Kähler family is outside it too, for a reason worth naming.** The Casimir family has genuinely two eigenvalues on all of $\Lambda^2\mathbb R^n$. The Kähler point is $a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$ supported on $\mathfrak{su}(m)$ alone, so on $\Lambda^2\mathbb R^{2m}$ it has **three** distinct eigenvalues $a,b,0$, with

$$\dim\ker W\ \ge\ m(2m-1)-(m^2-1)=m^2-m+1 ,$$

**the annotation's $(m^2-m+1)$, confirmed**, $3$ at $m=2$, $7$ at $m=3$, growing. **The collision that made the false pointer look plausible is the phrase "two-eigenvalue", which means "two on $\mathfrak g$" in [L39](../results.md) and "two on $\Lambda^2$" in the Casimir section.** That collision is in no row of [conventions.md](../findings/conventions.md).

**Where the real arguments live.** The $\mathbb{CP}^m$ form: [algebra.md](../findings/algebra.md) (Fox) and [second-order.md](../findings/second-order.md) (projectors). The Kähler form: [target.md](../findings/target.md). **Confirmed, and the canon's file-level pointer to [ungraded-slack.md](../findings/ungraded-slack.md) is still wrong today**, since that file contains no derivation of either formula. *"Numbered in report/" is true*: [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) carries the $\mathbb{CP}^m$ row and Fox's route.

**The duplication. Confirmed, and L10 is the stronger statement.** [Lemma L10](../findings/graded-half.md) carries the identical formula $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$, the identical monotonicity with the identical derivative numerator $-3(3m^2-2m+1)$, the identical $\tfrac32$ at $m=2$, and the identical identification of that member with $W_{\mathbb{CP}^2}$. **What L10 adds that L38 does not have:** the range $m\ge2$ argued from Fox rather than asserted; the provenance ("derived from Fox's norm identity… rather than from any dimension count"); the limit $\tfrac23$, not attained; the observation that the family attains rather than sits below the threshold; and that each such family carries **two** critical points $\pm W$. **What L38 adds that L10 does not have:** the entire Kähler half, the meeting point, and the joint statement. **So the numbering should hold the $\mathbb{CP}^m$ formula at L10 and L38 should cite it**, keeping for itself only what is genuinely its own. Neither block cites the other today.

## 8. The debt: nothing on file puts the Kähler point in $\mathcal W_{2m}$ at general $m$

**The value claim survives without it.** [conventions.md](../findings/conventions.md) defines $\theta=P(W)/\lVert W\rVert^3$ for any $W$, and section 3's derivation computes $P$ from bracket masses alone. So "the two-eigenvalue point of the symmetric pair has $\theta^2=\frac{m(m+1)}{(m-1)(m+2)}$" is true as written, whatever the operator turns out to be. **The canon is careful here**: it says "the unit Weyl tensor" only of the $\mathbb{CP}^m$ family, where [L10](../findings/graded-half.md) and [L28](../findings/nondegeneracy.md) establish it, and says "the two-eigenvalue point" of the second.

**Every consumer of the cap needs more, and the record knows it.** [target.md](../findings/target.md) states plainly that the two-eigenvalue ansatz "is **generically not a Weyl tensor at all**: of 16 pairs Gate 2 built, only **three** pass Ricci-flat + Bianchi + criticality, $(\mathfrak{su}(m),\mathfrak{so}(m))$, $(\mathfrak{so}(2k),\mathfrak{so}(k)+\mathfrak{so}(k))$ and $(\mathfrak{su}(2),\mathfrak{so}(2))$", and its evidence for the surviving three is a per-pair build with residuals ("$S_{\mathfrak{mmm}}\le2\times10^{-29}$, critical to $5\times10^{-16}$"). **That is a check at particular $m$, quantified over all $m$.**

**And the cheap route does not reach it.** [L4](../findings/ungraded-slack.md)'s criterion needs $\dim\mathcal W_n^K=1$. Taking $K=SO(m)$, the decomposition $\Lambda^2(\mathbb R^m\otimes\mathbb R^2)=\Lambda^2\mathbb R^m\otimes\mathrm{Sym}^2\mathbb R^2\ \oplus\ \mathrm{Sym}^2\mathbb R^m\otimes\Lambda^2\mathbb R^2$ carries $\Lambda^2\mathbb R^m$ **with multiplicity three**, so the $SO(m)$-invariants are far from a line and the criterion does not fire on the obvious group. The full normaliser might restore it; **nothing on file says so.**

> **HYPOTHESIS-DEBT (L38, second family).** *To be proved: that for every $m\ge2$ the operator $a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$ of the pair $(\mathfrak{su}(m),\mathfrak{so}(m))$ inside $\mathfrak{so}(2m)$, with $ap+bq=0$, is Ricci-flat, satisfies the first Bianchi identity, and is critical.* Until it is, the phrase "the padded closure of both families stays at $\sqrt{3/2}$" is a statement about a set of operators not known to lie in $\mathcal W_n$ past the $m$ actually built, and the second family contributes nothing to any bound on $M(n)$ or $\Theta_n$.

**This is the "imported theorem whose hypotheses were never checked" trap, in its live form here.** It is not the unital-algebra failure, Fox's Lemma 10.1 and (10.4) are used with their own hypotheses ($\alpha$ orthogonal, $r$ even, $4\le r\le n$) intact, and the $r=2$ degeneracy is caught. It is L39's formula, whose stated scope is "the **two-eigenvalue** ansatz only" and which "decides nothing about whether that point is a Weyl tensor: Weyl-ness is a property of the embedding $\rho$". **L38 consumes L39 and drops that scope line.**

## 9. $\ker W\ne0$, padding, and the boundary of every stated range

**Which $n$ does each member live in.** $n=2m$ for both, so **these are not families at a fixed $n$**, the comparator $\Theta_n$ moves with the member. This is the whole content of section 6, and it is what the word "capped" hides.

**Padding is in play, and differently in the two halves.** For $\mathbb{CP}^m$ it is *built in*: Fox's construction runs at every even $r$ with $4\le r\le n$, so the value $\frac{2(r+2)(r-1)}{3r(r-2)}$ is a function of $r$ alone and the ambient $n$ is free. For the Kähler family the construction is stated at $n=2m$ exactly, and reaching larger $n$ needs H9, the record's separate padding-preserves-$\theta$ fact. **Neither is stated in L38.**

**$\ker W\ne0$ at every member of the second family and at one of the first.** Section 7 gives $\dim\ker\ge m^2-m+1$ for the Kähler point. For $\mathbb{CP}^m$, the projector coefficient $\frac{m-2}{(m+1)(2m-1)}$ vanishes **only** at $m=2$, so $W_{\mathbb{CP}^2}$ has a $3$-dimensional kernel and every $m\ge3$ member has none. **The consequence a consumer must carry:** [second-order.md](../findings/second-order.md) records that at $\ker W\ne0$ several of the record's tube results "assert nothing", so the Kähler family is outside the reach of those at every $m$, and $W_{\mathbb{CP}^2}$ (the shared member and the cap's equality case), is outside them too.

**The boundaries, one at a time.**

- **$m=1$.** Both forms are poles, not values. Excluded by Fox ($S^2(\alpha)$ trivial) and by $\mathfrak{su}(1)=0$, so excluded by the objects, not merely by the arithmetic. **Stated for family 1 only.**
- **$m=2$.** The shared member; both forms give $\tfrac32$; it is $W_{\mathbb{CP}^2}$; it is $\Lambda^2\mathbb R^4$; it is **above** $\Theta_4$. All correct, all checked in section 5.
- **$m=3$.** $\mathbb{CP}^3$ **ties** $\Theta_6$ exactly, a boundary the word "capped" erases, and the exact zero of $-(2m-1)^2(m-3)$. The Kähler $m=3$ member is strictly above $\Theta_6$.
- **$m=4$.** First $m$ at which both are strictly below their own $\Theta_{2m}$. Also the first $m$ at which $\mathfrak k=\mathfrak{so}(4)$ is **not simple**, see the correction below.
- **$n=6+2\sqrt7=11.2915$.** The record's crossover, from $\theta_0(n)^2-\tfrac32=\frac{n^2-12n+8}{2n^2}$. **It is the exact boundary of the only useful reading of L38's cap**: below it $\sqrt{3/2}>\Theta_n$ and the cap says nothing, above it $\sqrt{3/2}<\Theta_n$ and the families are fenced. L38 mentions neither the crossover nor $n\ge12$.

**A claim proven on a subfamily and used in general, one, and it is a presentation defect rather than an error.** [target.md](../findings/target.md)'s table row supplying $S_{\mathfrak{kkk}}=(m-2)p$ reads "$\mathfrak{so}(m)\subset\mathfrak{su}(m)$, $\mathbb R^m\oplus\mathbb R^m$ | $h^\vee=m-2$ | $I_\rho=2$ | $c=2h^\vee/I_\rho$". **Located, and it fails at two of the $m$ the family uses.** At $m=3$, $\mathfrak{so}(3)\cong\mathfrak{su}(2)$ has $h^\vee=2$, not $m-2=1$; at $m=4$, $\mathfrak{so}(4)=\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ is **not simple**, so $h^\vee$ is undefined and $c=2h^\vee/I_\rho$ does not apply at all, the record's own correction that "$S_{\mathfrak{kkk}}=c_{\mathfrak k}p$ fails whenever $\mathfrak k$ is not simple" bites on its own table. **Arguing the opposite, and the opposite wins for the conclusion:** the *product* $c=m-2$ is correct at both, at $m=3$ because the record's half-index convention makes $I(\mathbb R^3\oplus\mathbb R^3)=4$ and $2\cdot2/4=1$, and at $m=4$ (and at every $m$) by section 3's doubling argument, which needs no simplicity. **So this is booked as a scoped correction to the $h^\vee$ and $I_\rho$ columns of that row (generic-$m$ data read at every $m$) and it changes nothing in L38's value.** It belongs to [L39](../results.md)'s block; L38 inherits it silently, having stated neither $c$ nor $S_{\mathfrak{kkk}}$.

## 10. The remaining traps, answered by name including where nothing was found

- **A universal claim with no witness. None found.** L38 makes no existential claim; its scope sentence ("The lemma is a value statement about two families and says nothing about points outside them"), is the correct disclaimer and it is present in the canon. It is absent from the landscape line and from the block.
- **A hypothesis stated but never used. None found.** See section 1.
- **The unital-algebra shape of the import trap. Not present.** Fox's hypotheses are carried, and the $r=2$ boundary is caught rather than assumed away. The live import failure is L39's dropped scope line, section 8.
- **Symbol collisions.** Four checked. $m$: consistent across both halves, both giving $n=2m$. $p,q$: the $\dim\mathfrak k,\dim\mathfrak m$ sense, colliding with the sphere-factor sense used two entries above in [results.md](../results.md); guarded by inline definitions. $\mathfrak m$: [target.md](../findings/target.md)'s symmetric-pair odd part, the third of conventions.md's three senses, and the adjacent L36 entry uses a different one. $X$ and $\mathfrak k$: **in no row of [conventions.md](../findings/conventions.md)**, defined inline by L38, so readable but unquotable. **And one collision nobody has booked: "two-eigenvalue", section 7.**
- **The block's LaTeX. Still broken, verified today.** [findings/ungraded-slack.md](../findings/ungraded-slack.md) lines 258-269 carry `\[…\]` display syntax and the raw report macros `\CP`, `\su`, `\so`, `\kk`, `\mm`, and the closing sentence is malformed, `**The $m=2$ member of the second family is $W_{\CP^2**$ itself.}` crosses its bold delimiters and its braces. **The canon's sentence is correct**, so nothing mathematical rides on it.
- **The report row. The annotation was right, and it has since been repaired.** `git show ff9c923e:report/sections/07-gradedness-split.tex` line 218 reads "decreasing to $1$"; the current file reads "decreasing to $\tfrac23$", which is correct, $\frac{(m+1)(2m-1)}{3m(m-1)}\to\frac{2m^2}{3m^2}=\tfrac23$. **The diagnosis "it is the other family's limit on the wrong row" is plausible but unverifiable**, since that table carries no Kähler row; what is certain is that $1$ was wrong, $\tfrac23$ is right, and $\frac X{X-2}\to1$ is the Kähler limit.

## 11. Discrepancy protocol, candidates raised and where each landed

| candidate | located | exhibited in closed form | opposite argued | outcome |
|---|---|---|---|---|
| "capped" reads as "below the target" and is false at $m=2,3$ | title of L38 in [results.md](../results.md) and the landscape line | $\theta^2-\Theta_{2m}^2=\frac{-(2m-1)^2(m-3)}{3m^2(m-1)}$ and the Kähler quartic | yes, the canon's *body* is correct as written and carries its own disclaimer | **stands, against the title only** |
| the Kähler family's range is nowhere stated | canon, block, landscape line | $X-2=0$ at $m=1$; both forms exceed $\tfrac32$ on $(1,2)$ | yes, no consumer has read it at $m<2$ | **stands** |
| the canon's proof pointer names a file containing neither formula | `**Proof:** [ungraded-slack.md]` | the file's own sections derive the Casimir family; its closing paragraph excludes $\mathbb{CP}^m$ by name | yes, "numbered in report/" is true and the report does carry the $\mathbb{CP}^m$ row | **stands** |
| Weyl-ness at general $m$ | [target.md](../findings/target.md), the `su_m_family` paragraph | the $SO(m)$-multiplicity-three decomposition blocks the cheap route | yes, the *value* claim needs none of it | **stands, as debt** |
| the $h^\vee$/$I_\rho$ row | [target.md](../findings/target.md)'s three-row table | $h^\vee(\mathfrak{so}(3))=2\ne1$; $\mathfrak{so}(4)$ not simple | yes, $c=m-2$ survives both by the doubling argument | **stands, scoped to two columns** |
| the report row's limit $1$ | [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 218 | limit is $\tfrac23$ | yes, the current file already reads $\tfrac23$ | **withdrawn: repaired since the annotation was written** |
| "the Kähler value was reproduced twice" overstates | the first annotation | $T/(T-1)$ with $T=\binom{m+1}2$ **is** $\frac X{X-2}$, since $X=2T$ (the record's own "difference simplifies to $0$ identically" | yes), L39's four-invariant route and the three-invariant reduction are genuinely two, and only the $T$-form is a restatement | **withdrawn: the two routes are real** |

## 12. What would falsify this, and what was done to look for it

**The object that would break it.** A member of either family, at some integer $m\ge2$, whose $\theta^2$ differs from the stated closed form, or, weaker but enough to void the headline entirely, an $m\ge2$ at which the $(\mathfrak{su}(m),\mathfrak{so}(m))$ two-eigenvalue operator fails Ricci-flatness or the first Bianchi identity, so that the "family" has holes and the phrase "the padded closure of both families" names a set that is not inside $\mathcal W_n$.

**What was done to look for it, no computation anywhere.** The first kind is closed off by derivation rather than by search: the $\mathbb{CP}^m$ value was re-derived twice above, once from Fox's (10.4) and once from the $U(m)$-projector form whose coefficients pass an independent tracelessness check, and the Kähler value was re-derived once from L39 with the two bracket masses re-established by hand, $S_{\mathfrak{kmm}}=mq$ as an identity from the Killing relation, and $S_{\mathfrak{kkk}}=(m-2)p$ from a doubling argument valid at every $m\ge2$ and screened at $m=2$ and $m=3$ against direct structure constants. A falsifier of the first kind therefore has to break Fox's (10.4) or the Killing relation, not merely be an unlucky $m$.

**The second kind is open and I did not close it.** The record's evidence is a 16-pair build at particular $m$; the one criterion on file that would give it uniformly, [L4](../findings/ungraded-slack.md)'s $\dim\mathcal W_n^K=1$, fails to fire at $K=SO(m)$ because $\Lambda^2\mathbb R^m$ appears three times in $\Lambda^2\mathbb R^{2m}$, and whether the full normaliser $N_{O(2m)}(\mathfrak{so}(m))$ cuts that to a line is a question no file on the record answers. **Settling it is a representation-theoretic computation of $\dim\mathcal W_{2m}^{N_{O(2m)}(\mathfrak{so}(m))}$, symbolic in $m$, and it is exactly the shape of thing this loop does analytically; it is named here rather than attempted, and it is the whole of finding 19.**

## Verdict

**PROVEN, hypotheses corrected.**

**What is proved.** Both closed forms, on $m\ge2$; the strict monotonicity of both, with the $\mathbb{CP}^m$ derivative numerator $-3(3m^2-2m+1)$ negative-definite by its discriminant $-8$; the common maximum $\theta^2=\tfrac32$ at $m=2$; the meeting point $m^2-3m+2=0$ with the second root excluded as the shared singularity; the identification of the $m=2$ member with $W_{\mathbb{CP}^2}$, in closed form and from two directions; and "neither family exceeds $\sqrt{3/2}$ anywhere", with equality attained.

**The three corrections the canon owes.**

1. **State $m\ge2$ for the Kähler family.** It is used twice and appears nowhere.
2. **Retitle.** "Two families capped" invites "below the target", which is false at three of the four smallest members. The result is a value-and-supremum statement: *two families in closed form, both strictly decreasing on $m\ge2$, with common maximum $\theta^2=\tfrac32$ attained at their shared $m=2$ member $W_{\mathbb{CP}^2}$*.
3. **Repoint, and de-duplicate.** The proof pointer must name [algebra.md](../findings/algebra.md) and [target.md](../findings/target.md), not [ungraded-slack.md](../findings/ungraded-slack.md), whose named section excludes $\mathbb{CP}^m$ in terms. The $\mathbb{CP}^m$ half should cite [L10](../findings/graded-half.md), which carries the same formula with a stated range, a stated provenance, the limit $\tfrac23$ and the two-critical-points fact, everything L38 has of it and more.

**The one debt booked.** Finding 19: no argument on file establishes, at general $m$, that the Kähler two-eigenvalue operator lies in $\mathcal W_{2m}$ and is critical. The *value* claim stands without it. Every consumer that reads L38 as fencing $\mathcal W_n$ needs it, and the sentence "what the caps license at $n\ge12$" is one such consumer.

**And the standing observation the audit should keep.** Even granting everything, the cap is *attained*, at the programme's own conjectured maximiser. **It fences and never separates**, which the record already knew, in [target.md](../findings/target.md)'s own words, and which L38's title works against.
