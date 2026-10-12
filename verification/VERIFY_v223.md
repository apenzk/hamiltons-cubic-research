# VERIFY_v223, Lemma L38, "two families capped, in closed form and strictly decreasing"

Cold read of [BRIEF_L38.md](BRIEF_L38.md), sections A–C, against [conventions.md](../findings/conventions.md), [algebra.md](../findings/algebra.md), [target.md](../findings/target.md), [graded-half.md](../findings/graded-half.md) and [ungraded-slack.md](../findings/ungraded-slack.md). **No numerical work was done**: every value below is closed-form arithmetic carried by hand, and the screening allowance was not used. Log: [agent_logs/verify-L38-v223.log](../agent_logs/verify-L38-v223.log).

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | $\theta^2(\mathbb{CP}^m)=\frac{(m+1)(2m-1)}{3m(m-1)}$ | **PROVEN**, on $m\ge2$, from Fox's (10.4) plus the $4\times$ metric conversion |
| 2 | the stated range for family 1, $m\ge2$ | **PROVEN**, and L10 gives the reason the canon omits |
| 3 | $p=\dim\mathfrak k=\binom m2$, $q=\dim\mathfrak m=\binom{m+1}2-1$ for $(\mathfrak{su}(m),\mathfrak{so}(m))$ | **PROVEN**, $p+q=m^2-1=\dim\mathfrak{su}(m)$ exactly |
| 4 | $\theta^2=\frac{m(m+1)}{(m-1)(m+2)}$ for the second family | **PROVEN** from the ansatz, $S_{\mathfrak{kkk}}=(m-2)p$, $c=2m$, derived in full at §4 |
| 5 | the identity $\frac{m(m+1)}{(m-1)(m+2)}=\frac X{X-2}$, $X=m(m+1)$ | **PROVEN**, $X-2=m^2+m-2=(m-1)(m+2)$ |
| 6 | the range for family 2 | **HYPOTHESIS-DEBT**, the canon states no range; $m\ge2$ is needed and never written |
| 7 | family 2 exists as a Weyl tensor at every $m$ | **HYPOTHESIS-DEBT**, on file as a numerical screen at sampled $m$ only |
| 8 | $S_{\mathfrak{kkk}}=c_{\mathfrak k}p$ at $m=2$ and $m=4$ | **PROVEN, hypotheses corrected**; the stated hypothesis fails at exactly the $m$ carrying the headline |
| 9 | both strictly decreasing, maximum $\tfrac32$ at $m=2$ | **PROVEN**, on real $m>1$ for both, the range the block never states |
| 10 | "the two families meet at $m=2$ and nowhere else", by $m^2-3m+2=0$ | **PROVEN**, that is the right polynomial; its other root $m=1$ is where both are undefined |
| 11 | the $m=2$ member of family 2 is $W_{\mathbb{CP}^2}$ | **PROVEN**, $O(4)$-conjugacy follows from the $\Lambda^\pm$ spectra |
| 12 | headline "capped" | **PROVEN, hypotheses corrected**; capped at $\sqrt{3/2}$ **attained**, not below $\Theta_n$ |
| 13 | "neither family exceeds $\sqrt{3/2}$ anywhere" | **PROVEN** |
| 14 | annotation: both families exceed $\theta_0(2m)$ at their own $n$ for $m=2$; $\mathbb{CP}^m$ ties at $m=3$; Kähler $m=3$ above $\Theta_6$ | **PROVEN**, all three confirmed, sign carrier corrected to $-(2m-1)^2(m-3)$ |
| 15 | annotation: the proof pointer is false | **PROVEN**, neither formula is derived in the file the canon names |
| 16 | annotation: the $\mathbb{CP}^m$ half duplicates [L10](../findings/graded-half.md) | **PROVEN**, L10 is strictly stronger on the boundary |
| 17 | annotation: [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) gives the $\mathbb{CP}^m$ limit as $1$ | **DISCHARGED**, true when stamped, repaired in `532570f6`; the row now reads $\tfrac23$ |
| 18 | the block's closing LaTeX is broken, with five raw report macros | **PROVEN**, still broken today |

**One-line summary.** Both closed forms are correct and both are genuinely derivable from material on the record, the meeting point and the $m=2$ identification hold, and the headline is true only in the sense "capped at $\sqrt{3/2}$, attained", but the second family carries no stated range, its existence as a Weyl tensor at general $m$ has never been argued, and the canon's proof pointer names a file in which neither formula appears.

**Verdict: HYPOTHESIS-DEBT.** The arithmetic is sound throughout; what is owed is named in §9.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated:

- $\theta$, "$P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$". **So $\theta$ is defined at every unit $W$, criticality or not.** That matters below: L38 is a value statement, and the value survives even where criticality is unproved. What it does not survive is $W\notin\mathcal W_n$.
- $\theta_0(n)$, "**the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.** … the target of Problem P is $\Theta_n$."
- $\Theta_n$, "the diagonal maximum; equals $\theta_0(n)$ at even $n$, and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$".
- $M(n)$, "**the global maximum** of $P$ on the unit sphere of $\mathcal W_n$ … padded $W_{\mathbb{CP}^2}$ giving $M(n)\ge\sqrt{3/2}$ … Distinct from $\Theta_n$, which is the *diagonal* maximum: $\Theta_n\le M(n)$, strictly at $n=4$ and $n=6$, where $M=\sqrt{3/2}$ against $\Theta_4=0.866$ and $\Theta_6=1.0541$."
- $S_{XYZ}$, "**the block-restricted contraction of $T$ over ORDERED slots**".
- $\mathfrak m$, "at a critical point, $\mathfrak m=E_{\min}$, $\mathfrak h=E_{\max}$ and $\mathfrak r$ everything else, kernel included. **$\mathfrak m$ carries three incompatible senses across the record**, this one, [L36](../findings/isotropy-cap.md)'s whole negative eigenspace, and [target.md](../findings/target.md)'s symmetric-pair odd part, so read it from context."
- The Killing constant of a subalgebra, "$\sum_{b\in\mathfrak g}\lVert[a,b]\rVert^2=c\lVert a\rVert^2$, with $c=2h^\vee(\mathfrak g)/I_\rho$ and $I$ normalised so the $\mathfrak{so}(n)$ vector representation has index $1$."
- Padding ("**Padding preserving the norm and $\theta$ is OWED, not settled**), it is [L30](../findings/stratum-two-negative.md)'s unproved clause".
- $S(W)$, "the gradedness slack. **Read [W4](../findings/INDEX-traps.md) before using it**: the screen is vacuous when $\ker W\ne0$."

## 1. Hypothesis inventory

Every hypothesis the two halves consume, and where it is discharged.

| # | hypothesis | stated in the canon? | discharged? |
| --- | --- | --- | --- |
| H1 | $m\ge2$ for the $\mathbb{CP}^m$ family | **yes** | yes, L10 gives the reason ($S^2(\alpha)$ trivial; denominator vanishes) |
| H2 | $m\ge2$ for the Kähler family | **no** | needed and never stated. At $m=1$, $p=q=0$ and $W=0$ |
| H3 | $S^r(\alpha)$ is an idempotent of Fox's algebra, i.e. a *critical Weyl tensor*, for every even $r$ with $4\le r\le n$ | no | by import, Fox's Lemma 10.1 |
| H4 | Fox's metric is $4\times$ Frobenius, so $\theta^2=4/\lvert S^r\rvert^2_{\rm Fox}$ | no | stated in [algebra.md](../findings/algebra.md) six lines above the display, and **used silently inside it** (§3) |
| H5 | $(\mathfrak{su}(m),\mathfrak{so}(m))$ is a symmetric pair, so $S_{\mathfrak{kkm}}=S_{\mathfrak{mmm}}=0$ | implicit in "symmetric pair" | yes, $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k\perp\mathfrak m$, $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k\perp\mathfrak m$ |
| H6 | $\mathfrak g=\mathfrak{su}(m)$ simple, so a single Killing constant $c=2m$ exists | no | yes for $m\ge2$ |
| H7 | $\mathfrak k=\mathfrak{so}(m)$ **simple**, so $S_{\mathfrak{kkk}}=c_{\mathfrak k}p=(m-2)p$ | no | **fails at $m=2$ (abelian) and $m=4$ (two ideals)**, see §5 |
| H8 | $W=a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$, extended by $0$, is Ricci-flat and satisfies first Bianchi at every $m$ | no | **not discharged anywhere**, see §9 |
| H9 | $W$ is critical, so that "the two-eigenvalue **point**" names something | no | argued only through the one-dimensionality of the invariant Weyl space, itself marked **Owed** in L10 |
| H10 | both members sit in $\mathcal W_{2m}$, so "meet at $m=2$" compares like with like | no | yes, $\dim_{\mathbb R}\mathbb{CP}^m=2m$ and $\mathfrak{su}(m)\subset\mathfrak{so}(2m)$ (§6) |

## 2. Which $n$ each member lives in, and whether padding is in play

The brief asks this first, and it decides how several later claims read.

- **Every $\mathbb{CP}^m$ member sits in $\mathcal W_{2m}$**, one dimension per $m$. The lemma therefore ranges over $n=4,6,8,\dots$ and is not a statement at fixed $n$.
- **Every Kähler member also sits in $\mathcal W_{2m}$**: $p+q=m^2-1=\dim\mathfrak{su}(m)$, and $\mathfrak{su}(m)$ embeds in $\mathfrak{so}(2m)$ by realification. So the two families are indexed commensurably, which is exactly what licenses §6.
- **Padding is in play in one direction only, and there it is discharged rather than owed.** Fox's construction takes a complex structure on an $r$-dimensional *subspace* of $\mathbb R^n$, and [algebra.md](../findings/algebra.md)'s value $\theta(S^r)^2=2(r+2)(r-1)/(3r(r-2))$ depends on $r$ alone, free of $n$. That is a proof that padding preserves $\theta$ **on this family**, and it is the one place in the vicinity where conventions.md's "padding preserving the norm and $\theta$ is OWED" does not bite.
- **It does bite on the consequence the fourth annotation draws.** "What the caps license at $n\ge12$ is that the padded closure of both families stays at $\sqrt{3/2}$" is a claim about the padded *Kähler* family too, for which no analogue of Fox's $r$-freeness is on file. That consequence rests on L30's unproved clause. It is not part of L38's statement, and L38 is not damaged by it.
- **$\ker W\ne0$ at $m=2$ for both families**, and at every $m$ for the Kähler one: the kernel is $\mathfrak{su}(m)^\perp$ inside $\mathfrak{so}(2m)$, of dimension $\binom{2m}2-(m^2-1)=m^2-m+1$, which is $3$ at $m=2$ and positive at every $m\ge2$. This confirms the fifth annotation's figure exactly. **It does not damage L38**, because L38 makes no gradedness or slack claim and so never touches [W4](../findings/INDEX-traps.md)'s vacuity trap. It does damage the surrounding narrative, which calls this "the family on which $S=0$ holds".

## 3. The $\mathbb{CP}^m$ value, derived, and its range

[algebra.md](../findings/algebra.md) supplies the argument: Fox's Lemma 10.1 constructs idempotents $S^r(\alpha)$ from an orthogonal complex structure on an $r$-dimensional subspace, and his (10.4) gives $\lvert S^r\rvert^2=\frac{6r(r-2)}{(r+2)(r-1)}$ in his metric.

The bridge is one line and the record has it: for an idempotent, $Q(S)=S$, so the unit vector $W=S/\lvert S\rvert$ has $Q(W)=S/\lvert S\rvert^2=W/\lvert S\rvert$, i.e. $\theta=1/\lvert S\rvert$. **This is where H4 enters silently.** Read against Fox's own norm the bridge gives

$$\theta^2 \stackrel{?}{=} \frac{(r+2)(r-1)}{6r(r-2)},$$

which is a factor $4$ below what algebra.md then displays. The displayed value is right and the sentence introducing it is not sufficient for it: Fox's metric is complete contraction, "exactly $4\times$ Frobenius", so $\lvert S^r\rvert^2_{\rm Frob}=\tfrac14\lvert S^r\rvert^2_{\rm Fox}$ and

$$\theta(S^r)^2=\frac{4(r+2)(r-1)}{6r(r-2)}=\frac{2(r+2)(r-1)}{3r(r-2)}.$$

At $r=2m$:

$$\theta^2=\frac{2(2m+2)(2m-1)}{3\cdot 2m(2m-2)}=\frac{4(m+1)(2m-1)}{12m(m-1)}=\frac{(m+1)(2m-1)}{3m(m-1)} .$$

**The claimed form, exactly.** Two anchors the derivation was not built from: $m=2$ gives $\tfrac96=\tfrac32=M(4)^2$, and $m=3$ gives $\tfrac{20}{18}=\tfrac{10}9=\theta_0(6)^2$. Both are independently on the record, and either one alone pins the factor-$4$ conversion, so H4 is not merely asserted.

**The range.** The denominator $3m(m-1)$ vanishes at $m=1$ and $m=0$; $m=1$ is $r=2$, where (10.4) returns $\lvert S^2\rvert^2=0$ and $\theta=1/0$. So $m\ge2$, and **the canon states it**. [L10](../findings/graded-half.md) states it *with its reason* ("**$m=1$ is inadmissible**), the denominator vanishes and Fox declares $S^2(\alpha)$ trivial, and $m\ge2$ is part of the statement." The L38 canon states the bound without the reason; the L38 **block** states no range at all.

> **A live range overstatement outside L38, found on the way.** [nondegeneracy.md:558](../findings/nondegeneracy.md) says the derivation holds "for every even $r=2m$ with $2\le r\le n$", and [target.md:466](../findings/target.md) says it "covers every even $r=2m$ from $r=2$". **Both include $r=2$, where the identity gives $0$ and $\theta$ is undefined.** The correct lower end is $r=4$. This is not L38's defect but it is the defect a consumer of L38 would inherit.

## 4. The Kähler value, derived in full

**$p$ and $q$ against the pair named.** $\mathfrak k=\mathfrak{so}(m)$ has $\dim=\binom m2$ ✓. The odd part is $\mathfrak m=\mathfrak{su}(m)\ominus\mathfrak{so}(m)$, so

$$q=(m^2-1)-\tfrac{m(m-1)}2=\tfrac{m^2+m-2}2=\tfrac{(m-1)(m+2)}2=\binom{m+1}2-1 . \checkmark$$

Both are as stated, and $p+q=m^2-1=\dim\mathfrak{su}(m)$, the check that fixes which $\mathfrak m$ is meant (target.md's symmetric-pair odd part, the third of conventions.md's three senses).

**The ansatz.** $W=a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$, zero elsewhere, with $ap+bq=0$ (trace-free) and $a^2p+b^2q=1$ (unit). Eliminating $b=-ap/q$:

$$a^2p\Big(1+\tfrac pq\Big)=1\ \Longrightarrow\ a^2=\frac q{p(p+q)}=\frac{(m-1)(m+2)/2}{\tfrac{m(m-1)}2(m^2-1)}=\frac{m+2}{m(m^2-1)} .$$

**The cubic.** With $S_{\mathfrak{kkm}}=S_{\mathfrak{mmm}}=0$ (H5),

$$\theta=\operatorname{tr}(W^3)+\tfrac12\big[a^3S_{\mathfrak{kkk}}+3ab^2S_{\mathfrak{kmm}}\big],\qquad \operatorname{tr}(W^3)=a^3p+b^3q .$$

**The two masses.** $S_{\mathfrak{kkk}}=c_{\mathfrak k}p=(m-2)p$ from $c(\mathfrak{so}(m)\subset\mathfrak{su}(m))=2h^\vee/I_\rho=2(m-2)/2=m-2$ (the index is $2$ because $\mathbb R^{2m}$ restricts to $\mathbb R^m\oplus\mathbb R^m$). Then the Killing relation $S_{\mathfrak{kkk}}+S_{\mathfrak{kmm}}=cp$ with $c(\mathfrak{su}(m))=2m/1=2m$ gives

$$S_{\mathfrak{kmm}}=2mp-(m-2)p=(m+2)p=\tfrac{m(m-1)(m+2)}2=mq . \checkmark$$

So the record's "$S_{\mathfrak{kmm}}=(m+2)p$, which equals $mq$ identically" is an identity, not a coincidence.

**Assembling.** Substituting $b^3q=-a^3p^3/q^2$ and $ab^2=a^3p^2/q^2$, and factoring $a^3p$:

$$\theta=a^3p\Big[1-\frac{p^2}{q^2}+\frac{m-2}2+\frac{3mp}{2q}\Big],\qquad \frac pq=\frac m{m+2} .$$

$$1-\frac{m^2}{(m+2)^2}=\frac{4(m+1)}{(m+2)^2},\qquad\text{so the bracket}=\frac{8(m+1)+(m-2)(m+2)^2+3m^2(m+2)}{2(m+2)^2} .$$

The numerator is $(8m+8)+(m^3+2m^2-4m-8)+(3m^3+6m^2)=4m^3+8m^2+4m=4m(m+1)^2$, so the bracket is $\dfrac{2m(m+1)^2}{(m+2)^2}$. With $a^3p=a\cdot a^2p=a\cdot\dfrac{m+2}{2(m+1)}$,

$$\theta=a\cdot\frac{m+2}{2(m+1)}\cdot\frac{2m(m+1)^2}{(m+2)^2}=a\cdot\frac{m(m+1)}{m+2},$$

$$\theta^2=\frac{m+2}{m(m^2-1)}\cdot\frac{m^2(m+1)^2}{(m+2)^2}=\frac{m(m+1)^2}{(m^2-1)(m+2)}=\boxed{\ \frac{m(m+1)}{(m-1)(m+2)}\ }$$

**exactly the claimed form.** No step used $m\ge3$, and no step used criticality.

**The $X$ identity.** $X=m(m+1)=m^2+m$, so $X-2=m^2+m-2=(m-1)(m+2)$ and $\frac X{X-2}=\frac{m(m+1)}{(m-1)(m+2)}$ identically. **Correct.** $X$ collides with nothing tabled but is the generic algebra-element letter throughout conventions.md; it is local to this block and to [target.md](../findings/target.md), where it is the same object ($X=2T$, $T=\binom{m+1}2$).

**The range.** $X>2$ requires $m\ge2$ for integers, $m>1$ for reals. At $m=1$ the pair degenerates: $\mathfrak{su}(1)=0$, $p=q=0$, and $W=0$ is not a unit vector, so the exclusion is structural as well as arithmetic. **The canon states no range for this family.** That is the annotation's charge and it holds: "$m\ge2$" appears once, attached to the $\mathbb{CP}^m$ family, and the sentence "maximum $\tfrac32$ at $m=2$" implies the range without hypothesising it.

## 5. The boundary the derivation does not cover, at exactly the $m$ that carries the headline

**H7 is stated in [target.md](../findings/target.md) itself**, "*$S_{\mathfrak{kkk}}=c_{\mathfrak k}p$ fails whenever $\mathfrak k$ is not simple*: a centre contributes nothing since $[\mathfrak z,\mathfrak k]=0$ … The correct form is $S_{\mathfrak{kkk}}=\sum_i c_i\dim\mathfrak k_i$ over the simple ideals." It is never checked against $\mathfrak{so}(m)$.

$\mathfrak{so}(m)$ is simple at $m=3$ and $m\ge5$. It is **abelian at $m=2$** and **a sum of two ideals at $m=4$**. So the step licensing $S_{\mathfrak{kkk}}=(m-2)p$ is unlicensed at $m=2$ (**the member that supplies $\tfrac32$, the whole content of the word "capped"**) and at $m=4$.

I do not supply the missing argument. What the record itself carries instead, and what makes this a hypothesis correction rather than a gap:

- At $m=2$, [target.md](../findings/target.md) records the full normalised spectrum $(2,-1,-1,0,0,0)/\sqrt6$, which is $W_{\mathbb{CP}^2}$'s, and $W_{\mathbb{CP}^2}$'s $\theta=\sqrt{3/2}$ is on the record by Fox at $r=4$ and again by [problem.md](../findings/problem.md)'s symmetric-space bound with equality at $\mathbb{CP}^2$. **So the $m=2$ value is anchored through the other family, and §6's coincidence is what discharges the boundary case.**
- At $m=4$ the two ideals of $\mathfrak{so}(4)$ are interchanged by the $\mathfrak{su}(4)$-normaliser, so they carry equal $c_i$ and $\sum_ic_i\dim\mathfrak k_i=c_{\mathfrak k}p$ regardless; that observation is not on the record and I record it as what would have to be written, not as a discharge.

**Correction owed to the statement:** the Kähler half needs "$m\ge2$", and its derivation needs "$\mathfrak k$ simple, or its simple ideals interchangeable" with $m=2$ handled by the $\mathbb{CP}^2$ identification.

## 6. Monotonicity and the meeting point

**Family 2, immediate.** $\frac X{X-2}=1+\frac2{X-2}$, strictly decreasing in $X$ on $X>2$; $X=m(m+1)$ is strictly increasing on $m>1$. So $\theta^2$ is strictly decreasing on **real $m>1$**, with limit $1$. The annotation's "the second family is $1+2/(X-2)$, immediate" is exactly right.

**Family 1, by the derivative.** With $N=(m+1)(2m-1)=2m^2+m-1$ and $D=3m(m-1)=3m^2-3m$:

$$N'D-ND'=(4m+1)(3m^2-3m)-(2m^2+m-1)(6m-3)=(12m^3-9m^2-3m)-(12m^3-9m+3)=-3(3m^2-2m+1).$$

$3m^2-2m+1$ has discriminant $4-12=-8<0$ and leading coefficient $3>0$, so it is positive-definite and the numerator is **negative-definite**. Both figures in the annotation (the numerator and the discriminant), are exactly right. So $\theta^2$ is strictly decreasing wherever defined, in particular on **real $m>1$**, with limit $\tfrac23$.

**The range the block never states.** Confirmed: the block asserts "strictly decreasing in $m$" for both families with no $m$-range anywhere, and the canon supplies one only for family 1. The correct ranges are $m>1$ for both, real, and $m\ge2$ integral.

**Maximum $\tfrac32$ at $m=2$.** Family 1: $\frac{3\cdot3}{3\cdot2\cdot1}=\tfrac32$. Family 2: $\frac{2\cdot3}{1\cdot4}=\tfrac32$. Both, and by monotonicity these are strict maxima over $m\ge2$.

**The meeting point, is $m^2-3m+2$ the right polynomial?** Setting the two equal and cancelling $(m+1)$ and $(m-1)$, both nonzero for $m\ge2$:

$$\frac{2m-1}{3m}=\frac m{m+2}\ \Longrightarrow\ 2m^2+3m-2=3m^2\ \Longrightarrow\ m^2-3m+2=0 .$$

**Yes.** Roots $\{1,2\}$. The cancellation of $(m-1)$ is what puts $m=1$ into the root set, and $m=1$ is precisely where both formulas are undefined, so on the common domain $m>1$ the unique intersection is $m=2$. The claim "meet at $m=2$ and nowhere else" is **correct**, and it is correct *because* of the exclusion the canon does not state for family 2. The two statements lean on each other.

**The identification of the $m=2$ member.** The block's data: $\mathfrak k=\mathbb R\omega\cong\mathfrak{so}(2)$, $p=1$, $q=2$, $ap+bq=0$, spectrum $(2,-1,-1,0,0,0)/\sqrt6$. Checking it: $a=-2b$ and $4b^2+2b^2=1$ give $b=-1/\sqrt6$, $a=2/\sqrt6$, the stated spectrum exactly. [target.md](../findings/target.md) names the eigenvectors: $\mathfrak k=\operatorname{span}\{e_{01}+e_{23}\}$, $\mathfrak m=\operatorname{span}\{e_{02}-e_{13},\,e_{03}+e_{12}\}$, and all three are **self-dual**, so $W$ is supported on $\Lambda^+$ with $\Lambda^-\subseteq\ker W$.

That closes the identification, and the closing step is worth writing because the record leaves it implicit: a Weyl operator on $\mathbb R^4$ has no $\Lambda^+\!-\!\Lambda^-$ mixing (that is the trace-free Ricci part), so it is determined up to $SO(4)$ by the two spectra of $W|_{\Lambda^\pm}$, the map $SO(4)\to SO(\Lambda^+)\times SO(\Lambda^-)$ being onto. Here those are $(2,-1,-1)/\sqrt6$ and $(0,0,0)$, $W_{\mathbb{CP}^2}$'s. **Proved, not asserted**, as the annotation says.

## 7. In what sense the families are capped, and what the headline should say

**Decided from the mathematics.** Three distinct readings of "capped" are in play, and only one is true.

| reading | true? |
| --- | --- |
| $\theta\le\sqrt{3/2}$ on both families, at every $m\ge2$ | **true**, with equality at $m=2$ |
| $\theta<\Theta_{2m}$ at the family's own $n=2m$ | **false at $m=2$ and $m=3$** |
| $\theta<\sqrt{3/2}$, i.e. the families are separated from the conjectured maximiser | **false**, the bound is attained |

The second row, checked in closed form. Write $\theta_0(2m)^2=\frac{2(2m-1)(2m-2)}{4m^2}=\frac{(2m-1)(m-1)}{m^2}$. Then

$$\theta^2_{\mathbb{CP}^m}-\theta_0(2m)^2=(2m-1)\cdot\frac{m(m+1)-3(m-1)^2}{3m^2(m-1)}=\frac{-(2m-1)^2(m-3)}{3m^2(m-1)} .$$

So the difference is **positive at $m=2$, exactly zero at $m=3$, negative from $m\ge4$**, the annotation's tie at $m=3$ and its sign carrier both confirmed. *One correction: the exact numerator is $-(2m-1)^2(m-3)$, not $-(2m-1)(m-3)$; the two agree in sign on $m\ge1$, so the conclusion is untouched and only the expression is loose.*

For family 2: $\theta^2=\tfrac32>\tfrac34=\theta_0(4)^2$ at $m=2$; $\tfrac65=1.2>\tfrac{10}9=1.\overline1$ at $m=3$, i.e. $\sqrt{6/5}=1.0954$ against $\Theta_6=1.0541$, **above**; and from $m\ge4$ the family decreases to $1$ while $\theta_0(2m)^2$ increases to $2$, so it stays below. Both drop under their own $\Theta_{2m}$ **only from $m\ge4$**. Every figure in the fourth annotation checks.

The crossover: $\theta_0(n)^2=\tfrac32$ at $n^2-12n+8=0$, i.e. $n=6+2\sqrt7=11.2915$. *A precision the block does not carry:* that is the **even** crossover. At odd $n$ the target is $\Theta_n^2=\frac{2(n-1)(n-3)}{(n+1)(n-2)}$, which reaches $\tfrac32$ at $n^2-13n+18=0$, i.e. $n=\tfrac{13+\sqrt{97}}2=11.42$. Both lie below $12$, so "$\sqrt{3/2}<\Theta_n$ at $n\ge12$" holds in both parities and the annotation's conclusion stands; the single named crossover covers only half the claim.

**The correct headline.** *"Two families in closed form, strictly decreasing, meeting at $W_{\mathbb{CP}^2}$, where both attain $\sqrt{3/2}$."* The word "capped" is defensible only with the cap value named and its attainment stated; standing alone it invites the second and third readings, both false. The canon's own last sentence ("The lemma is a value statement about two families and says nothing about points outside them"), is the right disclaimer and should be joined by "the cap is attained, so it fences and never separates". **This is not wording.** A family whose members exceed $\Theta_{2m}$ at their own $n$ is a family of non-diagonal points above the diagonal maximum, which is the programme's central difficulty rather than a step toward resolving it; and a cap attained at the conjectured maximiser can never be part of a strict-separation argument.

*On $\tfrac32$ against $\sqrt{3/2}$:* the canon writes $\theta^2=\dots$, then "maximum $\tfrac32$", then "neither family exceeds $\sqrt{3/2}$", internally consistent, $\tfrac32$ being the max of $\theta^2$ and $\sqrt{3/2}$ the max of $\theta$. The annotation flags a readability hazard, not an error.

## 8. The pointer, and the duplication

**The pointer.** The canon's proof line reads `**Proof:** [ungraded-slack.md](findings/ungraded-slack.md)`. The block's original boilerplate, recovered at `93472f0d`, was more specific: *"the argument is in this file under 'The subalgebra family: $\theta$ from $\dim\mathfrak h$ alone, and Conj…'"*.

**What that named section actually derives** ([ungraded-slack.md:73](../findings/ungraded-slack.md)): the two-eigenvalue **Casimir** family $W_{\mathfrak h}=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ for a subalgebra $\mathfrak h\subseteq\mathfrak{so}(n)$, with $\theta=\tfrac2n\sqrt{rN/(N-r)}$, the dimension cap $r\le n(n-2)/4$ and the consequence $\theta\le\theta_0(n)$ with equality exactly at the balanced sphere product.

**Neither family is in it, and the section says so itself.** Its closing paragraph ("*what they exclude is the Berger list*"), lists among the subalgebras failing hypothesis (F1) exactly "$\mathfrak u(m)$, $\mathfrak{su}(m)$". $\mathfrak u(m)$ is $\mathbb{CP}^m$'s isotropy and $\mathfrak{su}(m)$ carries the Kähler family. Structurally: $W_{\mathfrak h}$ has eigenvalues $c(1-\tfrac rN)>0$ and $-c\tfrac rN<0$, both nonzero, so $\ker W_{\mathfrak h}=0$, while the Kähler member has an $(m^2-m+1)$-dimensional kernel and $W_{\mathbb{CP}^m}$ has three distinct eigenvalues for $m\ge3$ (from $e=-\tfrac1{2m-1}P_{\mathfrak m}+\tfrac{m-2}{(m+1)(2m-1)}P_{\mathfrak{su}(m)}+\tfrac{2(m-1)}{2m-1}P_\omega$). **The annotation holds, on both halves and by an argument rather than by absence.**

And the file-level pointer is false too: a grep over [ungraded-slack.md](../findings/ungraded-slack.md) finds the $\mathbb{CP}^m$ form nowhere and the Kähler form only inside the L38 block itself. **The real arguments are [algebra.md](../findings/algebra.md) (§3) and [target.md](../findings/target.md) (§4)**, and the canon should point there.

**The duplication.** [L10](../findings/graded-half.md) states the same formula, on the same range, with the same derivative numerator, the same limit $\tfrac23$, and the same attainment at $m=2$. Comparing what each adds:

| | L10 | L38 |
| --- | --- | --- |
| the $\mathbb{CP}^m$ closed form, range, monotonicity, $\tfrac32$ attained | yes | yes, **identical** |
| the reason $m=1$ is inadmissible (Fox declares $S^2(\alpha)$ trivial) | **yes** | no |
| two critical points per family, $\pm W$ | **yes** | no |
| the Wolf and Grassmannian members, and where a falsifier would live | **yes** | no |
| the one-dimensionality of the invariant Weyl space marked **Owed** | **yes** | no |
| the Kähler family, its $p,q$, its closed form, the $X$ identity | no | **yes** |
| the meeting point and the $m=2$ identification with $W_{\mathbb{CP}^2}$ | no | **yes** |

**They state the same thing about $\mathbb{CP}^m$, and L10 is strictly stronger there**, it carries the boundary reason and the owed clause that L38 drops. What L38 adds is entirely the second family and the comparison. **The duplication is real**, and the repair is for L38's first half to cite L10 rather than restate it, keeping the comparison, which is L38's own content.

**Related, and worth separating from the duplication.** [graded-half.md:202](../findings/graded-half.md) records that this family "is a DIFFERENT KIND OF OBJECT" from the symmetric-space points, its members are Ricci-flat Kähler *algebraic* curvature operators, and the actual symmetric space $SU(m)/SO(m)$ has $\theta^2=\frac{8m(m^2+m-4)}{(m-2)(m-1)(m+1)(m+2)(m+4)}$, a different formula in a different dimension ($\dim SU(m)/SO(m)=q$, not $2m$). L38's wording, "the two-eigenvalue point of the symmetric pair $(\mathfrak{su}(m),\mathfrak{so}(m))$ inside $\mathfrak{so}(2m)$", names the *pair*, never the space, and is therefore **correct**. The word "Kähler" in the landscape line and the block is the collision risk: it is a property of the operator, not of $SU(m)/SO(m)$, which is not Hermitian symmetric.

## 9. What is owed

**HYPOTHESIS-DEBT, named exactly.** *That $W=a\Pi_{\mathfrak{so}(m)}+b\Pi_{\mathfrak m}$, extended by zero on $\mathfrak{su}(m)^\perp\subset\mathfrak{so}(2m)$, is Ricci-flat and satisfies the first Bianchi identity (hence lies in $\mathcal W_{2m}$) for every $m\ge2$.*

Why this is the binding debt and not a quibble:

- $\theta=P(W)/\lVert W\rVert^3$ is defined at every unit $W$, so §4's arithmetic needs no criticality. **It does need $W$ to be a Weyl tensor** for the lemma to say anything about $\mathcal W_{2m}$, and for the word "point" in "the two-eigenvalue point" to name a critical point.
- What is on file is a screen, not a proof: [target.md](../findings/target.md) reports "of 16 pairs Gate 2 built, only three pass Ricci-flat + Bianchi + criticality", and the family's own line reads "critical to $5\times10^{-16}$", "$S_{\mathfrak{mmm}}\le2\times10^{-29}$", sampled $m$, floating point.
- The one route to criticality that is symbolic in $m$, [graded-half.md:202](../findings/graded-half.md)'s "each $W$ is the **unique** unit $\mathfrak h$-invariant Weyl tensor for its $\mathfrak h$, so criticality is forced by equivariance", presupposes Weyl-ness and rests on the one-dimensionality of the invariant Weyl space, which [L10](../findings/graded-half.md) itself marks **Owed** at every $m$.
- The same file also warns that the ansatz is "**generically not a Weyl tensor at all**", with named pairs failing Bianchi and named pairs failing Ricci-flatness. So this is a hypothesis the record knows can fail, left unchecked in $m$ on the one family L38 asserts it for.

**Secondary debts**, each recorded above: the missing $m\ge2$ on family 2 (§4); the unlicensed $S_{\mathfrak{kkk}}=c_{\mathfrak k}p$ at $m=2,4$ (§5); the silent $4\times$ metric conversion inside algebra.md's display (§3); the $r\ge4$ correction owed to two files that quote the Fox range as $r\ge2$ (§3).

## 10. Traps, answered by name, including where nothing was found

- **$\ker W\ne0$.** Nonzero for the whole Kähler family, dimension $m^2-m+1$, and nonzero for $W_{\mathbb{CP}^2}$. **Confirms the fifth annotation; does not damage L38**, which makes no slack claim and so never reaches [W4](../findings/INDEX-traps.md)'s vacuity condition.
- **Padded objects.** Discharged in one direction (Fox's $\theta(S^r)$ is free of $n$), owed in the other (the padded Kähler closure), and outside L38's statement either way. §2.
- **Boundaries.** $m=1$: both formulas undefined, structurally as well as arithmetically, stated for family 1 only. $m=2$: both families' maximum, the meeting point, $\ker W\ne0$ for both, and the one $m$ where H7 fails. $m=3$: $\mathbb{CP}^m$ ties $\theta_0(6)$ exactly and the Kähler member sits above $\Theta_6$. $n=6+2\sqrt7$: correct for even $n$; the odd-$n$ crossover is $\tfrac{13+\sqrt{97}}2=11.42$ and is not named. All four checked; all four carry content.
- **A claim proven on a subfamily and used in general.** Both derivations are symbolic in the parameter, so the trap does not bite the *values*. It bites the *existence*: §9.
- **A hypothesis stated but never used.** None found. The canon's $p$ and $q$ are data rather than hypotheses; both are consumed in §4's derivation and neither is idle.
- **A step using a hypothesis never stated.** Three: H4 (the $4\times$ metric conversion, §3), H2 ($m\ge2$ for family 2, §4), H7 (simplicity of $\mathfrak k$, §5).
- **A universal claim with no witness.** None. "Neither family exceeds $\sqrt{3/2}$ anywhere" is universal, and its equality case has an explicit witness, $W_{\mathbb{CP}^2}$, exhibited with its spectrum.
- **An imported theorem whose hypotheses were never checked.** The Fox import (H3) is the only one. **I checked it against the unital trap specifically**: Fox's Lemma 10.1 and (10.4) are a construction of idempotents and a norm computation on them, and neither invokes a unit, so the failure mode that killed an earlier route (a cited theorem assuming a unital algebra, where $\mathcal W_n$ has none) does not recur here. What I cannot verify from my seat is the transcription of (10.4) itself; two independent anchors ($M(4)^2$ and $\theta_0(6)^2$) reproduce from it, which is stronger than nothing and weaker than reading the source.
- **Symbol collisions.** $m$: the two halves use *different objects* (the complex dimension of $\mathbb{CP}^m$ and the rank parameter of $\mathfrak{su}(m)$) and equating them is licensed only by both members living in $\mathcal W_{2m}$ (§2, H10). The canon never says this, and without it "meet at $m=2$" is a comparison of two indices, not of two points. $p,q$: here $p+q=m^2-1$, whereas across most of the record $p+q=n$ (sphere-product factor dimensions); a reader importing that reading gets $n=m^2-1$ and everything after it is wrong. $\mathfrak m$: the canon writes "$q=\dim\mathfrak m$" without naming which of conventions.md's three senses; **the tabled default happens to agree here** ($b<0<a$ makes $\mathfrak m=E_{\min}$) so nothing breaks, by luck rather than by care. $\mathfrak k$: no collision found. $X$: local, consistent with target.md's $X=2T$.

## 11. What would falsify it, and what I did to look

**The object.** *An $m\ge2$ at which one of the two closed forms fails*, most plausibly a member at which the ansatz is not a Weyl tensor, so that the "family" is empty there and the formula describes nothing.

What I did:

- **Monotonicity.** Both derivatives computed in closed form. Family 1's numerator $-3(3m^2-2m+1)$ has discriminant $-8$, so it has no real zero and no sign change anywhere; family 2 is $1+2/(X-2)$ with $X$ increasing. **No falsifier of the "strictly decreasing" clause can exist on $m>1$.**
- **A second meeting point.** $m^2-3m+2$ has root set exactly $\{1,2\}$, and $m=1$ is outside the common domain. **No second intersection exists.**
- **A member above $\tfrac32$.** Would require a maximum away from $m=2$, excluded by the previous two. **None exists.**
- **A member where the value formula fails.** Family 1 is covered by Fox's theorem at every even $r\ge4$, so a falsifier there would have to be a mis-transcription of (10.4), I checked it against two independent anchors and it survived both. Family 2's arithmetic I re-derived from scratch above and it closed exactly. **So the surviving falsifier is the existence one**, and I looked for its discharge in [target.md](../findings/target.md), [graded-half.md](../findings/graded-half.md), [algebra.md](../findings/algebra.md), [nondegeneracy.md](../findings/nondegeneracy.md) and [ungraded-slack.md](../findings/ungraded-slack.md), and found only a numerical screen at sampled $m$ plus a 16-pair Gate 2 build. That is §9.
- **What I did not do.** No search, sweep, census or falsifier hunt was run, and no script was executed. The record's warning that the ansatz "is generically not a Weyl tensor at all" is the strongest reason to think the debt is real rather than formal, and discharging it is an analytic task (the first Bianchi identity on $a\Pi_{\mathfrak{so}(m)}+b\Pi_{\mathfrak m}$, symbolic in $m$), not a numerical one.

## Verdict

**HYPOTHESIS-DEBT.**

Both closed forms are correct and both are derivable in full from material already on the record; the monotonicity, the meeting point, the identification of the $m=2$ member with $W_{\mathbb{CP}^2}$, and "neither family exceeds $\sqrt{3/2}$" all hold. What blocks a clean pass is that the second family's membership (that its ansatz is a Weyl tensor at every $m$), has never been argued, and that the statement carries no range for it. The headline should read *capped at $\sqrt{3/2}$, attained at $W_{\mathbb{CP}^2}$*, since the families exceed $\Theta_{2m}$ at their own $n$ for $m=2$ and $m=3$ and the cap is reached at the conjectured maximiser.
