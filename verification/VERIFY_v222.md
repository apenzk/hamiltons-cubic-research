# Verification v222, Lemma L38, two families capped

**Cold read of [BRIEF_L38.md](BRIEF_L38.md), sections A–C, plus the files the brief names.** No numerical work of any kind was done: no script, no Sage, no Python, no floating-point evaluation. Every derivation below is closed-form arithmetic carried out by hand, and the only figures quoted are ones already on the record, quoted as the record's. Log: [agent_logs/verify-L38-v222.log](../agent_logs/verify-L38-v222.log).

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | $\mathbb{CP}^m$ value $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$ | **PROVEN**, on $m\ge2$ |
| 2 | $\mathbb{CP}^m$ range: the canon's $m\ge2$ | **CORRECT**, and $m=1$ is a genuine exclusion rather than a formal one |
| 3 | Kähler $p=\binom m2$, $q=\binom{m+1}2-1$ against $(\mathfrak{su}(m),\mathfrak{so}(m))$ | **PROVEN** |
| 4 | Kähler value $\theta^2=\frac{m(m+1)}{(m-1)(m+2)}$ | **PROVEN**, re-derived here from L39 symbolically in $m$ |
| 5 | The identity $\frac{m(m+1)}{(m-1)(m+2)}=\frac X{X-2}$, $X=m(m+1)$ | **PROVEN** |
| 6 | Kähler range | **UNSTATED IN ALL THREE COPIES**, it is $m\ge2$ |
| 7 | Both strictly decreasing, maximum $\tfrac32$ at $m=2$ | **PROVEN**, each on $m\ge2$ |
| 8 | Meeting point: $m^2-3m+2=0$ is the right polynomial | **PROVEN** |
| 9 | "Meet at $m=2$ and nowhere else" | **PROVEN**, but only because $m=1$ is a pole of both, the block does not say so |
| 10 | The $m=2$ member is $W_{\mathbb{CP}^2}$ | **PROVEN**, in [target.md](../findings/target.md) |
| 11 | The headline word "capped" | **MISLEADING**, true family-internally, false against the target at $m=2,3$ |
| 12 | Annotation: both families exceed $\theta_0$ at their own small $m$ | **CONFIRMED** |
| 13 | Annotation: the proof pointer is false | **CONFIRMED** |
| 14 | Annotation: the $\mathbb{CP}^m$ half duplicates [L10](../findings/graded-half.md) | **CONFIRMED**, and L10 is strictly the stronger of the two |
| 15 | Annotation: the block's closing LaTeX is broken, five raw report macros | **CONFIRMED** |
| 16 | Annotation: the report gives the $\mathbb{CP}^m$ limit as $1$ | **WITHDRAWN**, both report copies say $\tfrac23$ |
| 17 | Padding preserves $\theta$, which the $n\ge12$ reading needs | **HYPOTHESIS-DEBT**, [conventions.md](../findings/conventions.md) records it as owed |
| 18 | The Kähler two-eigenvalue point is a Weyl tensor at every $m\ge2$ | **HYPOTHESIS-DEBT**, proved at $m=2$, checked numerically at finitely many others |
| 19 | Collateral: "the Ricci-flat Kähler family" names both families in [graded-half.md](../findings/graded-half.md) | **CONFIRMED** collision |

**Summary.** Every value, every monotonicity claim, the meeting point and the $m=2$ identification are correct as stated and were re-derived here from the record's own inputs; what fails is the packaging, a false proof pointer, a range stated for one family and not the other, a headline whose plain reading is false at exactly the two members that matter, and two hypotheses the lemma's *use* needs that the record has not discharged.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), which this report cites rather than restates.

- $\theta$: "$P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$".
- $\theta_0(n)$: "**the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.** … **The gloss 'the value at the balanced sphere product' stood here until 2026-09-04 and is what regrew [L0](../findings/problem.md)'s refuted constant**; the target of Problem P is $\Theta_n$."
- $\Theta_n$: "the diagonal maximum; equals $\theta_0(n)$ at even $n$, and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$".
- $\mathfrak m$: "at a critical point, $\mathfrak m=E_{\min}$, $\mathfrak h=E_{\max}$ and $\mathfrak r$ everything else, kernel included. **$\mathfrak m$ carries three incompatible senses across the record**, this one, [L36](../findings/isotropy-cap.md)'s whole negative eigenspace, and [target.md](../findings/target.md)'s symmetric-pair odd part, so read it from context."
- Padding: "**Padding preserving the norm and $\theta$ is OWED, not settled**, it is [L30](../findings/stratum-two-negative.md)'s unproved clause and the stratum reduction turns on it, so it is filed in [plan.md](../plan.md) rather than tabled here."
- The Killing constant: "$\sum_{b\in\mathfrak g}\lVert[a,b]\rVert^2=c\lVert a\rVert^2$, with $c=2h^\vee(\mathfrak g)/I_\rho$ and $I$ normalised so the $\mathfrak{so}(n)$ vector representation has index $1$."

**Which sense of $\mathfrak m$ L38 uses.** The third, the symmetric-pair odd part. L38's $\mathfrak m$ is the $-1$ eigenspace of the involution of $\mathfrak{su}(m)$ fixing $\mathfrak{so}(m)$, so $\mathfrak k\oplus\mathfrak m=\mathfrak{su}(m)$. It is *not* $E_{\min}$ of the operator: $E_{\min}$ of $W$ here is the $b$-eigenspace, which happens to coincide with $\mathfrak m$ as a set only because the ansatz is built on the splitting. The distinction is live at $m=2$, where the $\Lambda^2\mathbb R^4$ kernel is three-dimensional and belongs to neither $\mathfrak k$ nor $\mathfrak m$.

## Hypothesis inventory

What each half of L38 actually rests on, with where it comes from and whether it is discharged.

| # | hypothesis | used by | source | discharged? |
| --- | --- | --- | --- | --- |
| H1 | $m\ge2$ (equivalently $r=2m\ge4$) | $\mathbb{CP}^m$ half | Fox Lemma 10.1's $2\le r\le n$, plus $\lvert S^2\rvert^2=0$ | **yes**, and stated in the canon |
| H2 | Fox's $\lvert S^r\rvert^2=\frac{6r(r-2)}{(r+2)(r-1)}$, in Fox's metric | $\mathbb{CP}^m$ half | [algebra.md](../findings/algebra.md), source in [references/](../references/fox-2019-nonassociative-curvature-algebra/) | **yes**, source read |
| H3 | Fox's metric is $4\times$ Frobenius | $\mathbb{CP}^m$ half | [algebra.md](../findings/algebra.md) line 19 | **yes**, but the conversion is silent at the point of use |
| H4 | $\dim\mathcal W_{2m}^{U(m)}=1$, hence criticality by equivariance | $\mathbb{CP}^m$ half | [L28](../findings/nondegeneracy.md), [target.md](../findings/target.md) | **yes** for $U(m)$ at every $m$ |
| H5 | $m\ge2$ | Kähler half | needed, both denominators vanish at $m=1$ | **NOT STATED anywhere** |
| H6 | $p=\dim\mathfrak k$, $q=\dim\mathfrak m$ for $\mathfrak{su}(m)=\mathfrak{so}(m)\oplus i\,\mathrm{Sym}_0(m,\mathbb R)$ | Kähler half | classical | **yes**, checked in §3 |
| H7 | $S_{\mathfrak{kkm}}=S_{\mathfrak{mmm}}=0$ from the symmetric-pair bracket relations | Kähler half | [L39](../findings/target.md) | **yes**, and it is why $S=0$ on the family |
| H8 | $S_{\mathfrak{kkk}}=(m-2)p$ and $S_{\mathfrak{kmm}}=mq$ | Kähler half | [target.md](../findings/target.md) | **yes for the result**; the route through $h^\vee(\mathfrak{so}(m))=m-2$ is out of range at $m=3,4$, see §8 |
| H9 | $\mathfrak g$ simple, so a single Killing constant $c=2m$ exists | Kähler half | [conventions.md](../findings/conventions.md) | **yes**: $\mathfrak{su}(m)$ is simple for every $m\ge2$ |
| H10 | The two-eigenvalue point is a Weyl tensor (Ricci-flat and first-Bianchi), at every $m\ge2$ | the lemma's *use*, not its statement | [target.md](../findings/target.md) | **NO**, see §9 |
| H11 | Zero-padding preserves $\theta$ | the $n\ge12$ reading of "capped" | asserted in three places, owed in [conventions.md](../findings/conventions.md) | **NO**, see §10 |

**Two hypotheses are stated and never used.** The canonical statement carries $p=\dim\mathfrak k=\binom m2$ and $q=\dim\mathfrak m=\binom{m+1}2-1$, and the conclusion $\frac{m(m+1)}{(m-1)(m+2)}$ is a function of $m$ alone. They are not idle, they name *which* $\mathfrak k$ inside $\mathfrak{su}(m)$ is meant, and $\mathfrak{su}(m)$ has other subalgebras of no relation, so this is a benign instance of the trap rather than a defect. It is recorded because the brief asks for it by name.

## 1. The $\mathbb{CP}^m$ value, derived, and its range

[algebra.md](../findings/algebra.md) supplies the derivation the canon's pointer does not. Fox's Lemma 10.1 builds an idempotent $S^r(\alpha)$ from an orthogonal complex structure $\alpha$ on an $r$-dimensional subspace, for every even $r$ with $2\le r\le n$, and his (10.4) gives, in his own metric,

$$\lvert S^r\rvert^2=\frac{6r(r-2)}{(r+2)(r-1)}.$$

His metric is complete contraction, which [algebra.md](../findings/algebra.md) records as "exactly $4\times$ Frobenius", so $\lvert S^r\rvert^2_{\rm Frob}=\tfrac14\lvert S^r\rvert^2$ and $\theta=1/\lvert S^r\rvert_{\rm Frob}=2/\lvert S^r\rvert$. Hence

$$\theta(S^r)^2=\frac{4(r+2)(r-1)}{6r(r-2)}=\frac{2(r+2)(r-1)}{3r(r-2)},$$

which is the form [algebra.md](../findings/algebra.md) states. Substituting $r=2m$:

$$\theta^2=\frac{2(2m+2)(2m-1)}{3\cdot2m\cdot(2m-2)}=\frac{2\cdot2(m+1)(2m-1)}{6m\cdot2(m-1)}=\frac{4(m+1)(2m-1)}{12m(m-1)}=\frac{(m+1)(2m-1)}{3m(m-1)}.\qquad\checkmark$$

**The range.** Fox's constraint is $2\le r\le n$ with $r$ even, i.e. $m\ge1$ with $2m\le n$. At $r=2$ the identity returns $\lvert S^2\rvert^2=6\cdot2\cdot0/(4\cdot1)=0$, so $S^2(\alpha)$ is the zero operator and $\theta$ is $0/0$. **The $m=1$ exclusion is therefore substantive, not a division artefact**: $\mathbb{CP}^1=S^2$ has $W=0$, and [problem.md](../findings/problem.md) records "$S^n$ and $\mathbb{RP}^n$ have $W=0$, **which is why $W\ne0$ is a hypothesis and not a remark**". [L10](../findings/graded-half.md) gets this exactly right ("**$m=1$ is inadmissible**), the denominator vanishes and Fox declares $S^2(\alpha)$ trivial (and $m\ge2$ is part of the statement") and L38 does not say it.

**One presentational note against H3.** The sentence in [algebra.md](../findings/algebra.md) reads "Since $\theta=1/\lvert S^r\rvert$ in the Frobenius normalisation", and the displayed result is $4/\lvert S^r\rvert^2$, not $1/\lvert S^r\rvert^2$. The factor of $4$ is the metric conversion stated eighteen lines earlier in the same file, so the mathematics is right and the sentence elides the step. A reader who takes the sentence literally and (10.4) at face value gets $\theta^2$ four times too small.

## 2. The $\mathbb{CP}^m$ monotonicity, derived

Write $f(m)=\dfrac{2m^2+m-1}{3m^2-3m}$. Then

$$f'(m)=\frac{(4m+1)(3m^2-3m)-(2m^2+m-1)(6m-3)}{(3m^2-3m)^2},$$

and the numerator is

$$(12m^3-9m^2-3m)-(12m^3+0\cdot m^2-9m+3)=-9m^2+6m-3=-3(3m^2-2m+1).$$

$3m^2-2m+1$ has discriminant $4-12=-8<0$ and positive leading coefficient, so it is positive for every real $m$ and the numerator is negative-definite. The denominator is positive for $m\ne0,1$. **So $f$ is strictly decreasing on $m>1$**, in particular on $m\ge2$, and the annotation's $-3(3m^2-2m+1)$ and its discriminant $-8$ are both exactly right.

At $m=2$: $f(2)=\dfrac{3\cdot3}{3\cdot2\cdot1}=\dfrac96=\dfrac32$. **Maximum $\tfrac32$ at $m=2$, confirmed.** The limit is $\tfrac23$, from $f(m)=\tfrac23+\dfrac{3m-1}{3m(m-1)}$, an identity I checked by clearing denominators: $\tfrac{2m(m-1)+3m-1}{3m(m-1)}=\tfrac{2m^2+m-1}{3m(m-1)}$. $\checkmark$

## 3. The Kähler $p$ and $q$, checked against the pair named

$SU(m)/SO(m)$ has $\mathfrak{su}(m)=\mathfrak{so}(m)\oplus i\,\mathrm{Sym}_0(m,\mathbb R)$, the Cartan decomposition of the split real form.

- $p=\dim\mathfrak{so}(m)=\binom m2=\tfrac{m(m-1)}2$. $\checkmark$
- $q=\dim\mathrm{Sym}_0(m,\mathbb R)=\binom{m+1}2-1=\tfrac{m^2+m-2}2=\tfrac{(m-1)(m+2)}2$. $\checkmark$
- $p+q=\tfrac{m(m-1)+m(m+1)}2-1=m^2-1=\dim\mathfrak{su}(m)$. $\checkmark$

Both stated dimensions are correct, and the sum is the right total.

**The kernel, and what "two-eigenvalue" means.** $\Lambda^2\mathbb R^{2m}$ has dimension $\binom{2m}2=m(2m-1)=2m^2-m$, while $\mathfrak k\oplus\mathfrak m$ has dimension $m^2-1$. So $W=a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$ annihilates a subspace of dimension

$$(2m^2-m)-(m^2-1)=m^2-m+1,$$

**exactly the annotation's $(m^2-m+1)$**. Since $ap+bq=0$ and $a^2p+b^2q=1$ force $a,b\ne0$, the operator has three distinct eigenvalues, not two. This is not an error: [L39](../findings/target.md) defines the phrase ("let $W$ be the two-eigenvalue operator constant on $\mathfrak k$ and on $\mathfrak m$") so "two-eigenvalue" is a defined term meaning *constant on each of the two summands*, and the kernel is outside both. **The trap is real and is disarmed only by L39's definition, which L38 does not quote.** At $m=2$ the count is $4-2+1=3$, matching the recorded spectrum $(2,-1,-1,0,0,0)/\sqrt6$: multiplicities $1+2+3=6=\dim\Lambda^2\mathbb R^4$. $\checkmark$

## 4. The Kähler value, re-derived from L39 symbolically in $m$

[L39](../findings/target.md) gives, for any symmetric pair,

$$\theta^2=\frac{\big(S_{\mathfrak{kkk}}q^2+3S_{\mathfrak{kmm}}p^2-2p^3+2pq^2\big)^2}{4p^3q(p+q)^3},$$

and [target.md](../findings/target.md) supplies $S_{\mathfrak{kkk}}=(m-2)p$, $S_{\mathfrak{kmm}}=mq$ for this pair. I substituted and reduced by hand rather than accepting the stated result.

**The bracket, factored.** With $S_{\mathfrak{kkk}}=(m-2)p$ and $S_{\mathfrak{kmm}}=mq$,

$$S_{\mathfrak{kkk}}q^2+3S_{\mathfrak{kmm}}p^2-2p^3+2pq^2=p\big[(m-2)q^2+3mpq-2p^2+2q^2\big]=p\big[mq(q+3p)-2p^2\big].$$

**The pieces.** Put $u=m-1$, so $p=\tfrac{mu}2$, $q=\tfrac{u(m+2)}2$, $p+q=u(m+1)$. Then

$$q+3p=\tfrac u2\big[(m+2)+3m\big]=\tfrac u2(4m+2)=u(2m+1),$$

$$mq(q+3p)-2p^2=\tfrac{mu^2(m+2)(2m+1)}2-\tfrac{m^2u^2}2=\tfrac{mu^2}2\big[(m+2)(2m+1)-m\big]=\tfrac{mu^2}2\big[2m^2+4m+2\big]=mu^2(m+1)^2.$$

**The ratio.** Numerator $=p^2\cdot m^2u^4(m+1)^4$; denominator $=4p^3q(p+q)^3$, so

$$\theta^2=\frac{m^2u^4(m+1)^4}{4pq(p+q)^3}=\frac{m^2u^4(m+1)^4}{4\cdot\tfrac{mu}2\cdot\tfrac{u(m+2)}2\cdot u^3(m+1)^3}=\frac{m^2u^4(m+1)^4}{mu^5(m+2)(m+1)^3}=\frac{m(m+1)}{(m-1)(m+2)}.\qquad\blacksquare$$

**Independent spot checks, exact and by hand.** At $m=2$ ($p=1$, $q=2$, $S_{\mathfrak{kkk}}=0$, $S_{\mathfrak{kmm}}=4$): bracket $=0+12-2+8=18$, so $\theta^2=18^2/(4\cdot1\cdot2\cdot27)=324/216=\tfrac32$. At $m=3$ ($p=3$, $q=5$, $S_{\mathfrak{kkk}}=3$, $S_{\mathfrak{kmm}}=15$): bracket $=75+405-54+150=576$, so $\theta^2=576^2/(4\cdot27\cdot5\cdot512)=331776/276480=\tfrac65$. Both agree with $\frac{m(m+1)}{(m-1)(m+2)}$ at $\tfrac64$ and $\tfrac{12}{10}$. $\checkmark$

**The $X$ identity.** $X=m(m+1)=m^2+m$, so $X-2=m^2+m-2=(m+2)(m-1)$, giving $\frac X{X-2}=\frac{m(m+1)}{(m-1)(m+2)}$ identically. $\checkmark$ Equivalently, with $T=\binom{m+1}2$ and $q=T-1$, $X=2T$ and $\theta^2=\frac T{T-1}=\frac{q+1}q$, the form [target.md](../findings/target.md) also carries, and the two agree.

## 5. The Kähler monotonicity and its range

$\frac X{X-2}=1+\frac2{X-2}$, strictly decreasing in $X$ wherever $X>2$; and $X=m(m+1)$ is strictly increasing for $m\ge1$. So $\theta^2$ is strictly decreasing in $m$ **on $m\ge2$**, where $X\ge6$. At $m=2$, $X=6$ and $\theta^2=\tfrac64=\tfrac32$. $\checkmark$ The limit is $1$.

**At $m=1$ the formula is not merely undefined, it is a pole**: $X=2$, so $X-2=0$. And the object is empty, $\mathfrak{su}(1)=0$, $p=q=0$, and the normalisation $a^2p+b^2q=1$ is unsatisfiable. **So $m\ge2$ is forced for the second family exactly as it is for the first, and no copy of L38 says so.**

**The annotation is correct on the wording.** Section A states "$m\ge2$" for the $\mathbb{CP}^m$ family and gives no range for the Kähler family; section B gives no range for either; section C gives no range for either. The annotation "**MONOTONICITY IS PROVED FOR BOTH, ON A RANGE THE BLOCK NEVER STATES** … the canon states $m\ge2$ for the first family only" is **CONFIRMED**, verbatim against all three copies and against the report copy at [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex), which also gives no range.

## 6. The meeting point

Set the two forms equal. $m+1\ne0$ and $m-1\ne0$ on the domain, so cancel $\frac{m+1}{m-1}$:

$$\frac{2m-1}{3m}=\frac m{m+2}\iff(2m-1)(m+2)=3m^2\iff2m^2+3m-2=3m^2\iff m^2-3m+2=0.$$

**The polynomial is exactly the one the block names.** $\checkmark$ Its roots are $m=1$ and $m=2$, i.e. $m^2-3m+2=(m-1)(m-2)$.

**But "and nowhere else" is true only because $m=1$ is outside the domain.** The equation has two roots, and $m=1$ is a pole of *both* sides, so it is the domain restriction of §1 and §5 (not the polynomial) that leaves $m=2$ alone. The block asserts the conclusion and gives the polynomial without the restriction; a reader who checks the polynomial and stops finds two roots and is entitled to think the claim wrong. **This is the same missing hypothesis as §5, surfacing a second time**, which is why it is worth stating rather than waving through.

**The $m=2$ identification.** [target.md](../findings/target.md) proves it rather than asserting it: the $m=2$ member has $\mathfrak k=\mathrm{span}\{e_{01}+e_{23}\}$ and $\mathfrak m=\mathrm{span}\{e_{02}-e_{13},\,e_{03}+e_{12}\}$, a $\mathfrak u(1)$ inside the self-dual $\mathfrak{su}(2)\subset\mathfrak{so}(4)$, with spectrum $(0.816497,-0.408248,-0.408248,0,0,0)$, which is $(2,-1,-1,0,0,0)/\sqrt6$, since $2/\sqrt6=0.8164965\ldots$ and $1/\sqrt6=0.4082482\ldots$, and $\lVert\cdot\rVert^2=(4+1+1)/6=1$. That is $W_{\mathbb{CP}^2}$ as [03-setup.tex](../report/sections/03-setup.tex) defines it, $\mathrm{diag}(0,0,0,-1,-1,2)/\sqrt6$. **CONFIRMED**, and the block's own gloss ($p=1$, $q=2$, $ap+bq=0$, the normalised spectrum) matches it point for point.

**A consistency check at the boundary that could have failed and does not.** $\mathfrak k=\mathfrak{so}(2)$ is abelian at $m=2$, so it has no Killing constant at all, and [target.md](../findings/target.md) warns that "$S_{\mathfrak{kkk}}=c_{\mathfrak k}p$ fails whenever $\mathfrak k$ is not simple". The corrected form there is $S_{\mathfrak{kkk}}=\sum_ic_i\dim\mathfrak k_i$ over the *simple* ideals, which for an abelian $\mathfrak k$ is an empty sum, $0$, and $(m-2)p=0$ at $m=2$. **The two agree, so the family's maximising member survives the one hypothesis most likely to have broken it.**

## 7. What "capped" means, and what the headline should say

This is the item the brief asks to be decided from the mathematics. The three candidate readings, each settled:

**(a) Family-internal cap, TRUE and proved.** $\sup_m\theta=\sqrt{3/2}$ on each family, attained at $m=2$, by §2 and §5. Nothing on either family exceeds $\sqrt{3/2}$.

**(b) Below the target at the member's own $n$, FALSE.** Both families sit at $n=2m$. Comparing the $\mathbb{CP}^m$ value with $\theta_0(2m)^2=\frac{2(2m-1)(2m-2)}{4m^2}=\frac{(2m-1)(m-1)}{m^2}$:

$$\theta_{\mathbb{CP}^m}^2-\theta_0(2m)^2=(2m-1)\left[\frac{m+1}{3m(m-1)}-\frac{m-1}{m^2}\right]=(2m-1)\cdot\frac{m(m+1)-3(m-1)^2}{3m^2(m-1)},$$

and $m(m+1)-3(m-1)^2=m^2+m-3m^2+6m-3=-(2m^2-7m+3)=-(2m-1)(m-3)$, so

$$\theta_{\mathbb{CP}^m}^2-\theta_0(2m)^2=\frac{-(2m-1)^2(m-3)}{3m^2(m-1)}.$$

For $m\ge2$ this carries the sign of $-(m-3)$: **positive at $m=2$, exactly zero at $m=3$, negative from $m=4$.** The annotation's "the difference carrying the sign of $-(2m-1)(m-3)$" is correct on $m\ge2$; the exact factor is $(2m-1)^2$, and since $(2m-1)>0$ there the two expressions have the same sign, so the annotation is right rather than merely close. And $\theta_{\mathbb{CP}^3}^2=\frac{4\cdot5}{3\cdot3\cdot2}=\tfrac{10}9=\theta_0(6)^2=\Theta_6^2$, **a tie, not a cap**.

For the Kähler family at $m=3$: $\theta^2=\frac{3\cdot4}{2\cdot5}=\tfrac65$ against $\Theta_6^2=\tfrac{10}9$, and $\tfrac65-\tfrac{10}9=\tfrac{54-50}{45}=\tfrac4{45}>0$, **strictly above.** At $m=2$ both families are the single point $W_{\mathbb{CP}^2}$ at $\theta^2=\tfrac32$ against $\Theta_4^2=\theta_0(4)^2=\tfrac34$, exceeding it by a factor of two. **The annotation is CONFIRMED in every clause**, with the qualification that "both families exceed $\theta_0(2m)$ at $m=2$" counts one object twice, since §6 shows the two $m=2$ members are the same operator.

**(c) Below the target after padding into $n\ge12$, TRUE, subject to H11.** $\Theta_n^2>\tfrac32$ requires, at even $n$, $\frac{2(n-1)(n-2)}{n^2}>\tfrac32\iff n^2-12n+8>0$, root $6+2\sqrt7\approx11.2915$; and at odd $n$, $\frac{2(n-1)(n-3)}{(n+1)(n-2)}>\tfrac32\iff4(n-1)(n-3)>3(n+1)(n-2)\iff n^2-13n+18>0$, root $\tfrac{13+\sqrt{97}}2\approx11.4244$. **Both roots lie in $(11,12)$, so the integer threshold is $n\ge12$ at both parities**, which is [Lemma L2](../findings/problem.md), and my derivation reproduces its two polynomials exactly. I flagged "the record names one crossover where two exist" as a candidate and **withdrew it**: [problem.md](../findings/problem.md) carries both, at line 146 and again at [L44](../findings/problem.md).

**The verdict on the word.** "Capped" is true in sense (a) and, given H11, in sense (c). Its plain reading is (b), and (b) is false at the two smallest members of each family. The block's own annotation puts it best (**"the cap is *attained* at $\mathbb{CP}^2$, so it fences and never separates"**) and the report says the same in its own voice at [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex): "What it does not buy is a cap: the family's own supremum is $\thstar$, attained, so the closed form can never bound the class *strictly* below the target."

**The correct headline.** *"Two families in closed form, each strictly decreasing in $m$ with maximum $\sqrt{3/2}$ attained at $W_{\mathbb{CP}^2}$"*, with the operative sentence in the body: *the supremum over each family is the conjecture's own boundary value, attained, so the closed forms confine the families to $[\,\cdot,\sqrt{3/2}\,]$ and do not place any member strictly below $\Theta_n$ at its own $n$; at $n=2m$ the members lie above $\Theta_n$ for $m=2$ and, for the Kähler family, $m=3$.* This is not pedantry about a word: a reader who takes "capped" at face value would believe L38 removes two families as threats to Conjecture A, and what it actually does is exhibit two families that *reach* the threshold and one member that exceeds it at $n=6$.

## 8. The pointer

The canonical entry's proof pointer is `**Proof:** [ungraded-slack.md](findings/ungraded-slack.md)`. Checked:

- **The block at [ungraded-slack.md](../findings/ungraded-slack.md) lines 244–269 contains no derivation of either formula.** Stripped of annotations it is the statement, twice, once in broken LaTeX.
- **Neither formula appears elsewhere in that file.** I grepped `(m+1)(2m-1)` and `(m-1)(m+2)` across the file: the first occurs only at line 263, inside the block; the second at lines 250 and 267, an annotation and the block. **CONFIRMED.**
- **The named section.** The nearest thing that file derives is the two-eigenvalue Casimir family, [L4](../findings/ungraded-slack.md) and [L23](../findings/ungraded-slack.md), and L23's closing paragraph reads: "Unbalanced products, $\mathbb{CP}^m$, $\mathbb{HP}^m$, the complex Grassmannians and every symmetry-free critical point lie outside it". Line 101 says the same. **So the file's one derived family explicitly excludes $\mathbb{CP}^m$.** The annotation is **CONFIRMED**.
- **Where the arguments really are.** The $\mathbb{CP}^m$ half is derived at [algebra.md](../findings/algebra.md) from Fox's (10.4); the Kähler half at [target.md](../findings/target.md), lines 385–393, with the general formula at [L39](../findings/target.md). Both are also in the report, [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex), where the second carries an explicit proof sketch. The annotation names exactly these two files. **CONFIRMED.**

This is a `GAP` in the record's navigation rather than in its mathematics: **a reader following L38's stated proof pointer reaches a file that derives a different family and says $\mathbb{CP}^m$ is not in it.**

**On H8 and the imported theorem.** [target.md](../findings/target.md)'s table justifies $c=m-2$ for $\mathfrak{so}(m)\subset\mathfrak{su}(m)$ via $h^\vee(\mathfrak{so}(m))=m-2$ with $I_\rho=2$. That $h^\vee$ formula is the $B_k$/$D_k$ one and is out of range at $m=3$ ($\mathfrak{so}(3)\cong\mathfrak{su}(2)$ has $h^\vee=2$ in the standard normalisation) and at $m=4$ ($\mathfrak{so}(4)$ is not simple, so $h^\vee$ is undefined). The *ratio* $h^\vee/I_\rho$ is normalisation-independent and [target.md](../findings/target.md) records that Gate 2 computed $c$ intrinsically as $-B/\langle,\rangle$ at four independent points, so I do not call this a defect, but **no in-range check at $m=3$ or $m=4$ is recorded, and the table's rightmost column justifies the row by "$S_{\mathfrak{kkk}}=(m-2)p$", which is the thing being derived.** That is the "imported theorem whose hypotheses were never checked against the object" trap, present in a narrow form and belonging to L39 rather than L38.

**On the unital-algebra trap the brief names.** Fox's Lemma 10.1 and (10.4) are a construction and a norm identity; L39 is a computation in structure constants. **Neither invokes unitality of $\mathrm{MC}(V^*)$, so the route that killed an earlier line of work is not in play here.** I checked for it and found nothing.

## 9. HYPOTHESIS-DEBT, that the Kähler point is a Weyl tensor at every $m$

L38's conclusion is a value of $\theta=P(W)/\lVert W\rVert^3$, which is well defined for any operator on $\Lambda^2\mathbb R^{2m}$. Its **use** in the programme (as a statement about $\mathcal W_n$), needs the point to be Ricci-flat and to satisfy the first Bianchi identity.

[target.md](../findings/target.md) is emphatic that this cannot be assumed: "The ansatz $W=a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$ is **generically not a Weyl tensor at all**: of 16 pairs Gate 2 built, only **three** pass Ricci-flat + Bianchi + criticality". $(\mathfrak{su}(m),\mathfrak{so}(m))$ is one of the three. But that is a check at 16 pairs in fixed dimensions, and the family's own evidence in the same file is numerical, "non-diagonal ($\dim\ker\Phi_W=1$), $S_{\mathfrak{mmm}}\le2\times10^{-29}$, critical to $5\times10^{-16}$". The one member with a stated structural argument is $m=2$: "it yields a genuine Weyl operator: Ricci-flat, Bianchi, critical, non-diagonal, $S=0$".

**What would have to be proved:** *for every $m\ge2$, the operator $a\Pi_{\mathfrak{so}(m)}+b\Pi_{\mathfrak m}$ on $\Lambda^2\mathbb R^{2m}$ with $ap+bq=0$, $a^2p+b^2q=1$, under the embedding $\mathfrak{su}(m)\subset\mathfrak{so}(2m)$, is Ricci-flat and satisfies the first Bianchi identity.* I found no such proof on the record. I am not supplying one.

**This is a debt against the second family only.** The $\mathbb{CP}^m$ half carries no analogous debt: its members are the Weyl tensors of actual Fubini–Study metrics, and Fox's Lemma 10.1 constructs them for every even $r$ in range.

## 10. HYPOTHESIS-DEBT, padding, on which sense (c) rests

This is the finding that bears hardest, because sense (c) of §7 is the only reading under which L38 says anything favourable about the target.

**The contradiction, located exactly.** [conventions.md](../findings/conventions.md) (the file the record's own rule says is quoted rather than restated), states: "**Padding preserving the norm and $\theta$ is OWED, not settled**, it is [L30](../findings/stratum-two-negative.md)'s unproved clause and the stratum reduction turns on it, so it is filed in [plan.md](../plan.md) rather than tabled here." Against that, three consumers use it as settled:

| where | what it asserts |
| --- | --- |
| [ungraded-slack.md](../findings/ungraded-slack.md), the L4 block | "**Padding preserves $\theta$ and leaves the family.** Zero-padding a member into a larger $n$ keeps its $\theta$" |
| [03-setup.tex](../report/sections/03-setup.tex) | "Being Ricci-flat in dimension four it stays Ricci-flat after padding, so $P(W_{\CP^2})=\thstar$ for *every* $n$" |
| the L38 annotation itself | "What the caps license at $n\ge12$ is that the **padded closure** of both families stays at $\sqrt{3/2}<\Theta_n$" |

**Discrepancy protocol, all three steps.** *Located:* the four passages above. *Exhibited:* the failure is textual, not mathematical, I could construct no operator on which padding changes $\theta$, and I do not believe one exists. *Opposite argued:* the ingredient that would discharge the debt is already asserted elsewhere on the record, at [target.md](../findings/target.md)'s sum-law paragraph ("$Q$ maps block-supported operators into the same block") which no padding consumer cites. **So the candidate "padding is wrong" is withdrawn, and what survives is a bookkeeping finding:** conventions.md books as owed a step that three consumers spend, and the material that would settle it sits in a fourth file under a different heading. The debt is real, dischargeable, and currently uncited.

**Why it matters here rather than generally.** Both families are indexed by $m$ with base dimension $n=2m$, so **every member lives in its own $n$ and none of them lives in $n\ge12$ unless padded**, apart from $m\ge6$, which are far below the threshold anyway. The member that sets the cap, $W_{\mathbb{CP}^2}$, lives in $n=4$. **The whole of sense (c) is a statement about padded objects, and H11 is what makes it a statement at all.**

## 11. The duplication against L10

[L10](../findings/graded-half.md) states, in its own canonical block: "**The $\mathbb{CP}^m$ family, $m\ge2$.** Its value is exact in closed form, $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$, **derived from Fox's norm identity** … It is strictly decreasing in $m$ (the derivative's numerator is $-3(3m^2-2m+1)$, negative throughout) and falls to $2/3$, which it does not attain. **At $m=2$ it equals $\tfrac32$ exactly, so the family ATTAINS the threshold $\sqrt{3/2}$ rather than sitting below it**".

**Same formula, same derivative, same maximum, same source.** The annotation is **CONFIRMED**, and I checked the cross-citation both ways: `grep L38 findings/graded-half.md` returns nothing, and L38's block cites L10 only inside the annotation. Neither block cites the other.

**What each adds.** On the $\mathbb{CP}^m$ half, **L10 is strictly stronger and L38 adds nothing**:

| | L10 | L38 |
| --- | --- | --- |
| the closed form | yes | yes |
| $m\ge2$ stated | yes, "part of the statement" | yes |
| $m=1$ inadmissible, with a reason | yes, pole *and* Fox declares $S^2(\alpha)$ trivial | no |
| the limit $\tfrac23$, not attained | yes | no |
| "attains the threshold rather than sitting below it" | yes, in those words | **no, it says "capped"** |
| two critical points per family, $\pm W$ | yes | no |
| the Wolf and Grassmannian members | yes | no |

**What L38 adds that L10 does not carry** is the entire second family: the Kähler closed form, the $X/(X-2)$ shape, the meeting point, and the identification of the $m=2$ member. **So L38's real content is its second half, and its first half should be a citation of L10 rather than a restatement**, which is also the safer arrangement, since L10 states the range that L38 omits for its own second family.

## 12. The broken block, and the withdrawn annotation

**The closing LaTeX.** The block's last line reads `**The $m=2$ member of the second family is $W_{\CP^2**$ itself.}`, the bold delimiter has been absorbed into the math and the closing brace is stranded outside it. **CONFIRMED broken.** The canon has the sentence correct, and so does the report at [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex).

**The raw macros.** In a markdown file: `\CP`, `\su`, `\so`, `\kk`, `\mm`, **five**, exactly as the annotation says. There is also `K\"ahler`, a raw LaTeX accent, which is a sixth artefact of the same paste but not a report macro, so the count of five stands as written.

**The report's limit, WITHDRAWN.** The annotation says "[07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) gives the $\mathbb{CP}^m$ row's limit as $1$, which is the **other** family's limit written onto the wrong row, it is $2/3$, and the appendix has it right." I read both. Line 218 of that file reads "$\CP^m$ & $\dfrac{(m+1)(2m-1)}{3m(m-1)}$ & $\thstar$ at $m=2$ & decreasing to $\tfrac23$", and [90-appendix.tex](../report/sections/90-appendix.tex) line 67 reads "decreasing to $2/3$". **Both say $\tfrac23$.** Discrepancy protocol: located (line 218), exhibited (it says $\tfrac23$), opposite argued (the annotation's own claim that the appendix has it right is consistent with the body also having it right). **The annotation is stale or was wrong; either way the defect it names is not in the file today.** Reported as withdrawn rather than as a defect.

## 13. Collateral, a name that covers both families

[graded-half.md](../findings/graded-half.md) uses "the Ricci-flat Kähler family" for two different objects. At line 55 it "peaks at $m=2$, which **is** $W_{\mathbb{CP}^2}$", which fits either family, since both peak there. At line 239 it says "**The Ricci-flat Kähler family's $m=3$ and $m=4$ members are ordinary saddles**" and immediately identifies the $m=3$ member as **$\mathbb{CP}^3$ at $n=6$**. But the two families' $m=3$ members are different operators at different values: $\mathbb{CP}^3$ at $\theta^2=\tfrac{10}9$, the Kähler point at $\tfrac65$. **The name is ambiguous exactly where the two families separate**, and L38 is the one result that names both side by side, which is why it is recorded here. It belongs in [conventions.md](../findings/conventions.md)'s "words with more than one meaning" alongside the $\mathfrak m$, $B$, $M$ and $\mu$ entries.

## 14. The traps, answered one by one

| trap | finding |
| --- | --- |
| $\ker W\ne0$ | **Present and named.** The Kähler point has an $(m^2-m+1)$-dimensional kernel (verified in §3) so "two-eigenvalue" is L39's defined term, not a spectral count. L38 uses the term without quoting the definition. |
| padded objects, and what $n$ each member lives in | **Both families live at $n=2m$**; every comparison with $\Theta_n$ at $n\ge12$ is a comparison of padded objects. See §10, the padding step is booked as owed. |
| $m=1$ | **A genuine boundary, unstated for the second family.** §1 and §5: a pole for both, and $W=0$ / an empty algebra respectively. |
| $m=2$ | **The boundary that carries the maximum, and it survives.** §6: the abelian $\mathfrak{so}(2)$ makes $c_{\mathfrak k}$ undefined, and $S_{\mathfrak{kkk}}=(m-2)p=0$ agrees with the corrected sum-over-simple-ideals form. |
| $m=3$ | **Where the headline breaks.** $\mathbb{CP}^3$ ties $\Theta_6$; the Kähler member exceeds it by $\tfrac4{45}$ in $\theta^2$. |
| the crossover $6+2\sqrt7$ | **Checked and clean.** §7(c): I derived $n^2-12n+8$ and $n^2-13n+18$ independently and both roots lie in $(11,12)$; [L2](../findings/problem.md) and [L44](../findings/problem.md) already carry both parities. Candidate finding withdrawn. |
| proven on a subfamily, used in general | **Not present for the values.** Fox's Lemma 10.1 covers every even $r$ in range and L39 is symbolic in $m$. **Present for Weyl-ness**, §9. |
| a hypothesis stated but never used | **Present, benign.** $p$ and $q$ in the canonical statement do not enter the conclusion; they identify the pair. |
| a step using a hypothesis never stated | **Present, twice.** $m\ge2$ for the Kähler family (§5), and the domain restriction behind "nowhere else" (§6). |
| a universal claim with no witness | **Absent.** "Neither family exceeds $\sqrt{3/2}$ anywhere" is a universal over $m$ discharged by monotonicity, and its equality case has an explicit closed-form witness, $(2,-1,-1,0,0,0)/\sqrt6$. |
| an imported theorem with unchecked hypotheses | **Narrowly present**, at L39's $h^\vee(\mathfrak{so}(m))=m-2$ row, out of range at $m=3,4$, §8. The unital-algebra trap the brief names is **not** in play: neither Fox 10.1/10.4 nor L39 uses a unit. |
| symbol collisions | $\mathfrak m$ is used in [target.md](../findings/target.md)'s third sense (§0). $m$ is the family index throughout, never a dimension. $p,q$ are the pair's dimensions, never [L69](../findings/graded-half.md)'s sphere factors, a live collision, since $\theta^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ in that file uses the same letters for $S^p\times S^q$. $X$ is local to L38 and collides with nothing found. $\mathfrak k$ is unambiguous. **And "the Ricci-flat Kähler family" is itself a collision, §13.** |

## 15. What would falsify this, and what I did to look

**The object that would break the value half:** a member of either family, at some $m\ge2$, whose $\theta$ differs from the stated closed form. **What I did:** I re-derived the $\mathbb{CP}^m$ form from Fox's (10.4) by the substitution $r=2m$, and the Kähler form from [L39](../findings/target.md)'s four-invariant formula symbolically in $m$, reducing $\big(mq(q+3p)-2p^2\big)^2/\big(4pq(p+q)^3\big)$ to $\frac{m(m+1)}{(m-1)(m+2)}$ with no residue; then I checked $m=2$ and $m=3$ against the general formula in exact integers by hand. Three routes, no discrepancy.

**The object that would break the monotonicity half:** a real $m\ge2$ at which either derivative vanishes or changes sign. **What I did:** the $\mathbb{CP}^m$ derivative's numerator is $-3(3m^2-2m+1)$, and I computed its discriminant, $4-12=-8$, so it has no real root at all; the Kähler form is $1+\frac2{X-2}$ with $X$ strictly increasing on $m\ge1$ and $X>2$ on $m\ge2$. **No such $m$ exists.**

**The object that would break the cap:** a member of either family with $\theta>\sqrt{3/2}$. **What I did:** by the two monotonicity results the supremum is at $m=2$, where both equal $\tfrac32$ exactly. **No such member exists, and that is the problem, not the reassurance**: the supremum *is* the threshold, attained, so the falsifier for the *headline* is the one object that does exist, $W_{\mathbb{CP}^2}$ at $n=4$, together with the Kähler $m=3$ member at $\sqrt{6/5}$ against $\Theta_6=\sqrt{10/9}$ at $n=6$. **Both are on the record, both exceed the target at their own $n$, and both are exhibited in closed form above.**

**The object that would break the $n\ge12$ reading:** an $n\ge12$ with $\Theta_n\le\sqrt{3/2}$, or a padded member whose $\theta$ moves. **What I did:** derived both parity polynomials and located both roots in $(11,12)$, so no such $n$ exists; the padded-$\theta$ question I could not close, and it is booked as H11 in §10 rather than assumed away.

**No falsifier hunt, sweep, census or search was run.** Every object above is one the record already exhibits or one I wrote down in closed form to test a specific claim.

## Verdict

**PROVEN, hypotheses corrected.**

Both closed forms are correct and were re-derived here by routes independent of the block; both monotonicity claims are correct; the meeting polynomial is the right one; the $m=2$ identification is proved rather than asserted. The corrections owed are:

1. **State $m\ge2$ for the Kähler family** in all three copies and in the report, it is currently stated for the $\mathbb{CP}^m$ family alone, and it is what makes "meet at $m=2$ and nowhere else" true.
2. **Retitle.** "Capped" reads as "below the target" and is false in that reading at $m=2$ for both families and at $m=3$ for the Kähler one. The suggested headline and the sentence that must accompany it are in §7.
3. **Repoint the proof.** The $\mathbb{CP}^m$ half to [algebra.md](../findings/algebra.md), the Kähler half to [target.md](../findings/target.md). The current pointer reaches a file whose one derived family explicitly excludes $\mathbb{CP}^m$.
4. **Replace the $\mathbb{CP}^m$ half with a citation of [L10](../findings/graded-half.md)**, which carries it in a strictly stronger form.
5. **Fix the block's closing line** and the five raw report macros.

Two debts are recorded against the lemma's *use* rather than its stated values, and neither is discharged on the record: **H10**, that the Kähler two-eigenvalue point is a Weyl tensor at every $m\ge2$ (§9); and **H11**, that zero-padding preserves $\theta$ (§10), which is the whole support of the only sense in which L38 bears on the target at $n\ge12$.
