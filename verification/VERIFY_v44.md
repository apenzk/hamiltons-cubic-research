# Verify v44, L152: the numerator identity $\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$, the two hypotheses it hides, and the two clauses that fall outside the recorded refutation

*Verifier v44, 2026-09-05, cold brief on [ROUND_L152](ROUND_L152.md), target [findings/second-order.md](../findings/second-order.md):1453–1473. **No numerical work of any kind**: no script was run, and every value below is an exact hand evaluation of a closed form already on the record. Log: [agent_logs/verify-L152-v44.log](../agent_logs/verify-L152-v44.log). No other verifier's report was read; the reports for [ROUND_L156](ROUND_L156.md) were passed over.*

## Verdicts

| # | claim, as the entry states it | verdict |
|---|---|---|
| C1 | $\max_\Gamma\lvert\zeta\rvert=\lvert\lambda_-\rvert+\alpha g_n$ on a circle of radius $\alpha g_n$ about $\lambda_-$ | **TRUE, ASSERTED NOT DERIVED**, one line of triangle equality, checked below |
| C2 | that maximum equals $(1+\alpha)g_n$ | **PROVEN, HYPOTHESES CORRECTED**: needs $\lvert\lambda_-\rvert=g_n$, i.e. $\dim E_->\dim E_+$, which holds at $S^m\times S^m$ for every $m\ge2$ |
| C3 | the identity holds "for any complex centre" | **BROKEN AS WRITTEN**, true of the *shape* $\lvert c\rvert+r$, false of the *value* $(1+\alpha)g_n$ |
| C4 | $\lvert\lambda_-\rvert=g_n$ "by definition of the gap" | **BROKEN**, $g_n$ is defined as $\operatorname{dist}(\operatorname{spec},0)$; the equality is computed, and it is what fails at a kernel |
| C5 | the identity is unaffected by $\Gamma$ encircling $0$, and by $\alpha\ge D$ | **PROVEN** (the identity is purely geometric); the *use* of it fails at $\alpha\ge D$ |
| C6 | "Consequence. $C(\alpha,\gamma)=\frac{1+\alpha}{\alpha-\gamma}$" | **GAP**, the entry's own display has four factors and bounds $\lVert W_-\rVert$; $C$ is defined against $M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert$ and needs five |
| C7 | "the contour must separate $\lambda_-$ from $0$ …, the first binding" ($\alpha<1$) | **BROKEN**, false, and it contradicts the entry's own box three lines above |
| C8 | $\max_\Gamma\lvert\zeta\rvert\cdot\max_\Gamma\lVert(W-\zeta)^{-1}\rVert$ distributes a max across a shared $\zeta$ | **NO FINDING**, valid always, and exactly sharp for $\alpha\le D/2$, hence at [L156](../findings/second-order.md)'s optimum |
| C9 | what [L156](../findings/second-order.md) imports as "L152's surviving half" | **NO FINDING**, L156's stated hypotheses supply both of C2's, so the import is sound where it is made |
| C10 | absence of an L152 entry in [results.md](../results.md) | **CORRECT for the entry, WRONG for the clause**, the missing statement belongs in L156's canonical form, not in a new L152 one |

**Overall verdict: `PROVEN, hypotheses corrected`.** The surviving identity is true and is used soundly at its one live site; it carries two hypotheses the entry states as definitions, and the entry contains two further defective clauses, C6 and C7, that the recorded "REFUTED AS STATED" heading does not cover.

**The one line the round can act on.** Move the sentence *"$\Gamma$ is the circle of radius $\alpha g_n$ about $\lambda_-$, and $\lvert\lambda_-\rvert=g_n$ because $\dim E_-=m^2>m(m-1)=\dim E_+$"* into [Lemma L156](../findings/second-order.md)'s hypothesis list and into its canonical form at [results.md](../results.md):355; after that nothing needs to be cited from L152 at all, and the clause stops travelling under a refuted number.

## 0. Conventions, fixed once

- $W^*=S^m\times S^m$, $n=2m$, real symmetric and trace-free; $\operatorname{spec}W^*=\{\lambda_-,\lambda_+\}$ with $\lambda_-<0<\lambda_+$.
- $E_-=V_1\otimes V_2$, $\dim E_-=m^2$; $E_+=\Lambda^2V_1\oplus\Lambda^2V_2$, $\dim E_+=2\binom m2=m(m-1)$. This is the decomposition the record uses at this base point.
- $g_n:=\operatorname{dist}(\operatorname{spec}W^*,0)=\min_a\lvert\lambda_a\rvert$, the analyticity radius of [Lemma L145](../findings/second-order.md). L145's own step table reads *"the spectrum is two-valued with no kernel, so $g_n=\lvert\lambda_-\rvert$"*, the "no kernel" is the reason, which makes it a computed value rather than a definition.
- $D:=\lvert\lambda_+-\lambda_-\rvert/g_n=\tfrac{2m-1}{m-1}\in(2,3]$ for $m\ge2$; $d:=\min(\alpha,D-\alpha)$.
- $\Gamma:=\{\zeta:\lvert\zeta-\lambda_-\rvert=\alpha g_n\}$, traversed once; $W(z)=W^*+zH$, $\lVert H\rVert_{op}\le1$; $\rho=\gamma g_n/\lVert H\rVert_{op}$; $A(z)=W_-(z)-W_-(0)$, so $A(0)=0$; $M=\sup_{\lvert z\rvert=\rho}\lVert A(z)\rVert$.
- $C(\alpha,\gamma)$ is defined at [findings/second-order.md](../findings/second-order.md):1394, above the entry, by $M\le C(\alpha,\gamma)\,\rho$. Nothing in L152 redefines it.

## 1. Hypothesis inventory

A pass without this table is not a pass. "Carried" means the entry states it; "used" means the written argument leans on it.

| # | hypothesis | carried by L152? | used by L152? | true at the object? | where it enters |
|---|---|---|---|---|---|
| H1 | $\Gamma$ is a circle **centred exactly at $\lambda_-$** | yes, at line 1459 | yes | yes | C1: the max-modulus evaluation |
| H2 | $\lvert\lambda_-\rvert=g_n$ | **stated as a definition**, line 1459 | yes | yes at $S^m\times S^m$, every $m\ge2$ | C2: converting $\lvert\lambda_-\rvert+\alpha g_n$ into $(1+\alpha)g_n$ |
| H2$'$ | equivalently $\dim E_->\dim E_+$, i.e. $\lambda_+>\lvert\lambda_-\rvert$ | **no** | implicitly, through H2 | yes: $m^2>m(m-1)$ | the derivation of H2 from trace-freeness |
| H3 | $\ker W^*=0$ | as "$0\notin\operatorname{spec}(W^*)$", line 1465 | yes, H2 fails without it | yes at $S^m\times S^m$ | H2, and the existence of the contour at all |
| H4 | $W^*$ symmetric (hence normal) | yes, in the WHAT-FALLS box | for the resolvent factor only | yes | C6's $1/(d\,g_n)$; **not** needed for C1–C2 |
| H5 | $m\ge2$ | **no** | yes, silently |, | $\lambda_+=\tfrac m{m-1}g_n$ is undefined at $m=1$; the record's chain needs $n\ge12$, i.e. $m\ge6$ |
| H6 | $0<\alpha$, and $\alpha<D$ for $W_-$ to be the negative spectral part | **contradicted twice**, lines 1465 and 1467 | yes, for the Riesz meaning of $W_-$ |, | C5, C7 |
| H7 | $\gamma<\alpha$, uniformly in $z$ over $\lvert z\rvert\le\rho$, for the Neumann step | **no** (never written | yes, invisibly, in the Consequence |), | C6 |
| H8 | $\lVert H\rVert_{op}\le1$, so that $\lVert zH\rVert\le\gamma g_n$ | **no** | yes, invisibly |, | C6 |

**Which the written argument actually uses.** For the surviving identity: H1, H2, and H2$'$/H3 behind it, and *nothing else*. Not H4, not symmetry, not normality, not $\lambda_-$ real, not $\lambda_-$ negative, not any constraint on $\alpha$. For the Consequence: H4, H7 and H8 in addition, none of them written.

## 2. C1 and C2, what is actually proved, and at what generality

**The text.** Line 1463: *"THE NUMERATOR IS $\max_\Gamma\lvert\zeta\rvert$, AND ON A CIRCLE ABOUT $\lambda_-$ IT IS $\lvert\lambda_-\rvert+\alpha g_n=(1+\alpha)g_n$."* That is the whole of the argument on file. There is no derivation; the identity is asserted.

**Checking C1 by following the step's own algebra.** For any $c\in\mathbb C$ and $r>0$, and any $\zeta$ with $\lvert\zeta-c\rvert=r$, the triangle inequality gives $\lvert\zeta\rvert\le\lvert c\rvert+r$. Equality is attained: for $c\ne0$ take $\zeta_-=c\,(1+r/\lvert c\rvert)$, which satisfies $\lvert\zeta_--c\rvert=r$ and $\lvert\zeta_-\rvert=\lvert c\rvert+r$; for $c=0$ every point of the circle gives $r=\lvert c\rvert+r$. So $\max_{\lvert\zeta-c\rvert=r}\lvert\zeta\rvert=\lvert c\rvert+r$ exactly, an identity and not an estimate. With $c=\lambda_-$ and $r=\alpha g_n$: $\max_\Gamma\lvert\zeta\rvert=\lvert\lambda_-\rvert+\alpha g_n$. **C1 is true.** It is one line, and the entry does not write it; I record that as *asserted, not derived*, and I have checked rather than supplied it, the check is an evaluation of the entry's own expression at a named point of its own contour.

**C2 needs H2, and H2 is a theorem rather than a definition.** $g_n$ is $\operatorname{dist}(\operatorname{spec},0)=\min(\lvert\lambda_-\rvert,\lambda_+)$, so $\lvert\lambda_-\rvert=g_n$ holds **iff** $\lvert\lambda_-\rvert\le\lambda_+$. Reading the base point at source: $W^*$ is trace-free, so
$$\dim E_-\cdot\lvert\lambda_-\rvert=\dim E_+\cdot\lambda_+,\qquad m^2\,\lvert\lambda_-\rvert=m(m-1)\,\lambda_+,\qquad \lambda_+=\frac m{m-1}\,\lvert\lambda_-\rvert .$$
Since $\tfrac m{m-1}>1$ for every $m\ge2$, $\lambda_+>\lvert\lambda_-\rvert$, hence $g_n=\lvert\lambda_-\rvert$ and $\lambda_+=\tfrac m{m-1}g_n$, which is the value [L156](../findings/second-order.md) and the agreed list above L152 both carry, and $D=1+\tfrac m{m-1}=\tfrac{2m-1}{m-1}$ follows. **So C2 is proved at $S^m\times S^m$, at generality $m\ge2$, and the general form of its hypothesis is $\dim E_->\dim E_+$.**

**The generality question the round asked, answered.** The identity is *not* a general fact about the contour. It is a general fact about circles ($\lvert c\rvert+r$) specialised by one arithmetic fact about the balanced product ($\lvert\lambda_-\rvert=g_n$). Strip the second and the identity reads $\max_\Gamma\lvert\zeta\rvert=\lvert\lambda_-\rvert+\alpha g_n$, which is what a reader would be entitled to carry to a new base point, and it is not $(1+\alpha)g_n$ there.

**Does it need $\lambda_-$ real and negative?** No. C1 holds for complex $c$; C2 needs only $\lvert\lambda_-\rvert=g_n$. Realness and negativity are needed for the *contour to enclose the negative spectrum* and for the resolvent geometry of C6, never for the numerator. On this the entry's own reading is correct and its emphasis (*"the numerator is set by the eigenvalue the contour encloses, together with the contour's own radius"*) is exactly right.

**What it gives when $\Gamma$ encircles $0$.** Nothing changes. $\alpha>1$ puts $0$ inside $\Gamma$, since $\lvert 0-\lambda_-\rvert=g_n<\alpha g_n$; the maximiser $\zeta_-=-(1+\alpha)g_n$ is unaffected, and $\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$ still. What *does* change is $\min_\Gamma\lvert\zeta\rvert=\lvert1-\alpha\rvert g_n$, which vanishes at $\alpha=1$ (the contour passes through $0$) and that is a fact about the integrand's *other* factors, not this one. **C5 confirmed.** The same holds at $\alpha\ge D$: the identity survives, but $\Gamma$ then encloses $\lambda_+$ as well and $W_-$ ceases to be the negative spectral part, so the identity is true about an object that is no longer the one the chain wants.

## 3. C3, "for any complex centre", the sentence that exports the clause

**Locate.** Line 1457: *"WHAT SURVIVES: $\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$, the numerator identity below, **for any complex centre**."*

**Exhibit the failure concretely.** Read as written (the identity holds for any complex centre), the sentence is false at a centre named in the same entry. Take $m=6$ ($n=12$, the dimension the entry works at), $\alpha=1$, and the centre $c=\lambda_+=\tfrac65g_n$. The circle $\lvert\zeta-\lambda_+\rvert=g_n$ has $\max\lvert\zeta\rvert=\tfrac65g_n+g_n=\tfrac{11}5g_n$, while $(1+\alpha)g_n=2g_n$. $\tfrac{11}5\ne2$. Every value here is exact.

**Argue the opposite.** The charitable reading is that "for any complex centre" attaches to the *max-modulus lemma*, $\max=\lvert c\rvert+r$, which is genuinely centre-free, the entry is saying that $\lambda_-$ need not be assumed real, a point it makes correctly. Under that reading the sentence is true, and the finding is one of scope rather than of arithmetic.

**Why the candidate stands anyway.** The sentence is the entry's export line: it is what a citer copies, and it glues a centre-free lemma to a centre-specific value in one clause. That gluing is visible downstream already. [plan-verification.md](../plan-verification.md):21 describes the survivor as *"$\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$, which is the triangle equality on a circle"*, but the triangle equality yields $\lvert\lambda_-\rvert+\alpha g_n$; the step from there to $(1+\alpha)g_n$ is H2, which is not triangle-anything. The record therefore already carries a description of the clause that is one hypothesis short, and C3's phrasing is where that description comes from. **Finding recorded.**

## 4. C4 and the kernel edge, what this entry asserts at $\ker W\ne0$

**Locate.** Line 1459: *"that spectrum is the single eigenvalue $\lambda_-$, with $\lvert\lambda_-\rvert=g_n$ **by definition of the gap**."*

**What the entry asserts at a kernel: nothing, and that is the finding.** L152 never states $\ker W^*=0$ as a hypothesis. It states $0\notin\operatorname{spec}(W^*)$ once (line 1465) and there only as a premise in someone else's argument about the range of $\alpha$. It nowhere says the numerator identity depends on it.

**Exhibit the failure concretely at the record's named witness.** Padded $W_{\mathbb{CP}^2}$ has $0\in\operatorname{spec}$ with $\dim E_+=1$ and $\dim(E_+\oplus E_-)=3$ ([findings/fence-posts.md](../findings/fence-posts.md):357), so the kernel is everything else. Then $g_n=\operatorname{dist}(\operatorname{spec},0)=0$, and:

- $\Gamma$ has radius $\alpha g_n=0$ and is a point, not a contour;
- $\max_\Gamma\lvert\zeta\rvert=\lvert\lambda_-\rvert>0$, while $(1+\alpha)g_n=0$. **The identity fails, with both sides exact.**

And it fails for a reason the record already names elsewhere: [Lemma L146](../findings/second-order.md):1227 lists *"$\ker W^*=0$, without which $W\mapsto W_-$ is not analytic at $W^*$"*. So at the kernel witness the entire Riesz construction is void, not merely the constant.

**Argue the opposite.** In context the base point is fixed at $S^m\times S^m$, where H3 holds, so "by definition of the gap" is loose wording inside a setting that makes it true. Nothing in the entry is *wrong at its own object*.

**Why the candidate stands.** Calling H2 a definition is what makes H3 invisible. A definition travels; a computed equality does not. The clause is exported (C3) as a general contour fact, and at the one place in the record where $\ker W\ne0$ it is not merely inapplicable but false. **Finding recorded.** It is the sharpest reason the surviving clause should be restated inside L156's hypotheses rather than left where a citer can lift it.

## 5. C6, the entry's own display does not yield the entry's own Consequence

**Locate.** The display at line 1461,
$$\lVert W_-\rVert\le\frac1{2\pi}\cdot 2\pi\alpha g_n\cdot\max_\Gamma\lvert\zeta\rvert\cdot\max_\Gamma\lVert(W-\zeta)^{-1}\rVert,$$
against line 1471, *"Consequence. $C(\alpha,\gamma)=\frac{1+\alpha}{\alpha-\gamma}$."*

**The display is right, as far as it goes.** The Riesz form is correct: $\tfrac1{2\pi i}\oint_\Gamma f(\zeta)(\zeta-W)^{-1}d\zeta=f(W)P$ with $f(\zeta)=\zeta$ gives $W_-=WP$, and $(\zeta-W)^{-1}=-(W-\zeta)^{-1}$ turns it into the entry's $-\tfrac1{2\pi i}\oint_\Gamma\zeta(W-\zeta)^{-1}d\zeta$. The estimate is the standard $ML$ bound with length $2\pi\alpha g_n$. **No finding on the display itself.**

**Exhibit the failure concretely.** Feed the display its own factors, with the entry's own resolvent value $1/((\alpha-\gamma)g_n)$:
$$\alpha g_n\cdot(1+\alpha)g_n\cdot\frac1{(\alpha-\gamma)g_n}=\frac{\alpha(1+\alpha)}{\alpha-\gamma}\,g_n .$$
That is a bound on $\lVert W_-\rVert$: one power of $g_n$, no $\gamma$ in the numerator, and an extra $\alpha$. But $C$ is defined at line 1394 by $M\le C\rho$, with $M=\sup_{\lvert z\rvert=\rho}\lVert W_-(z)-W_-(0)\rVert$. Reaching $C=\tfrac{1+\alpha}{\alpha-\gamma}$ requires the resolvent-*difference* identity and **five** factors, not four:
$$\alpha g_n\cdot(1+\alpha)g_n\cdot\frac1{(\alpha-\gamma)g_n}\cdot\gamma g_n\cdot\frac1{\alpha g_n}=\frac{(1+\alpha)\gamma}{\alpha-\gamma}\,g_n=C\,\gamma g_n .$$
The entry displays neither the difference identity, nor the perturbation factor $\lVert zH\rVert\le\rho\lVert H\rVert_{op}=\gamma g_n$, nor the second resolvent. The two products differ by exactly $\alpha/\gamma$.

At the entry's own checkpoint $(\alpha,\gamma)=(\tfrac12,\tfrac14)$ the arithmetic is stark. The display returns $\tfrac{(1/2)(3/2)}{1/4}g_n=3g_n$ as a bound on $\lVert W_-\rVert$. The checkpoint the entry claims to reproduce, line 1469, *"$M\le6\rho$ … here $\tfrac{1.5}{0.25}=6$ exactly"*, is $M\le6\rho=6\cdot\tfrac{g_n}4=\tfrac32g_n$. Different quantity, and a factor of $2$ apart. **The "exactly 6" cannot be read off the entry's own display.** (I confirm the arithmetic $\tfrac{1+\alpha}{\alpha-\gamma}=\tfrac{3/2}{1/4}=6$ is correct; what is missing is the route to it.)

**Argue the opposite.** The paragraph is headed *"The Riesz representation, with every factor named"*, a schematic whose job is to locate the numerator inside a bound whose other steps belong to [r441](../reviews/REVIEW_r441.md) and [r456](../reviews/REVIEW_r456.md) and are imported. On that reading the display is an orientation device, not a derivation, and the entry's only claim is about one factor.

**Why the candidate stands.** The paragraph promises *every* factor and names four of the five; the missing one is the $\gamma$ that makes $C$ a constant in $\rho$ rather than in $g_n$. And the word used is "Consequence", which asserts entailment. **`GAP` recorded.** It leaves the numerator identity untouched, C1 and C2 are factors in either product.

## 6. C7, the $\alpha<1$ ruling is false, and the entry contradicts itself across three lines

**Locate.** Line 1467: *"the contour must separate $\lambda_-$ from both $0$ and $\lambda_+$, so $\alpha<1$ keeps $0$ outside and $\alpha<1+\tfrac m{m-1}$ keeps $\lambda_+$ outside, **the first binding**."* Against line 1465, in the same entry: *"the agreed list above says $\alpha$ may exceed $1$, since $0\notin\operatorname{spec}(W^*)$ and the contour need only separate $\lambda_-$ from $\lambda_+$."*

**Exhibit the failure concretely.** The Riesz projection for the spectral set $\{\lambda_-\}$ requires only that $\Gamma$ be a cycle in the resolvent set winding once about $\lambda_-$ and not about $\lambda_+$. $0\notin\operatorname{spec}W^*$, so $\zeta\mapsto\zeta(W-\zeta)^{-1}$ is holomorphic in a neighbourhood of $\zeta=0$ and the integral is unchanged when $\Gamma$ is deformed across the origin. At $m=6$ take $\alpha=\tfrac{D}2=\tfrac{11}{10}$: then $\lvert 0-\lambda_-\rvert=g_n<\tfrac{11}{10}g_n$, so $0$ lies inside $\Gamma$, while $\lvert\lambda_+-\lambda_-\rvert=\tfrac{11}5g_n>\tfrac{11}{10}g_n$ keeps $\lambda_+$ outside, and $W_-$ is still exactly the negative spectral part. So $\alpha<1$ is not binding, and it is not a constraint at all. The two candidate constraints the entry lists are both wrong: what binds is the switch of the nearest spectral point at $\alpha=D/2$, which is [L156](../findings/second-order.md)'s finding and which no party had named.

**Argue the opposite.** The most charitable reading available is that $\alpha<1$ is a *sufficient* condition dressed as a necessary one: under $\alpha<1$ together with $\gamma<d\le\alpha$ one gets $\gamma<1$ for free, and $\gamma<1$ *is* the real content of "no eigenvalue crosses $0$", a constraint on the disc, which L156 states. And three lines earlier the entry itself flags the range as *"recorded three ways that do not agree"* and *"Owed with L152's own Gate 2"*.

**Why the candidate stands.** "Must" and "the first binding" are claims of necessity, made without qualification, immediately after the entry has said the opposite. The clause is not idle: it decides the optimisation, and [r708](../reviews/REVIEW_r708.md):46 records the whole L156 corollary as *"one resolvent-kink ruling away from saying the opposite"*, listing L152 among the three places that denied it, under the rejected reading, $C>4$ and $J>8$ for every $m$, inverting every value. **`BROKEN` recorded, and it is a clause the heading's two-place refutation does not cover.**

## 7. C8, quantifier order and scope

**Free, optimised, and distributed.** In the surviving identity, $\alpha$ and the centre are free and nothing is optimised; the single $\max$ is over $\zeta\in\Gamma$. L152 runs no optimisation over $(\alpha,\gamma)$ and says so at line 1473. Two quantifiers are absent from the page and are needed by C6: the $\sup$ over $\lvert z\rvert=\rho$ inside $M$, and the uniformity in $z$ of the Neumann bound $\lVert(W(z)-\zeta)^{-1}\rVert\le1/((\alpha-\gamma)g_n)$ on $\Gamma$, the entry writes $\max_\Gamma\lVert(W-\zeta)^{-1}\rVert$ with the perturbation left silent inside $W$ (H7, H8).

**The one distributed max, and it does no harm.** The display writes $\max_\Gamma\lvert\zeta\rvert\cdot\max_\Gamma\lVert(W-\zeta)^{-1}\rVert$ in place of $\max_\Gamma\big(\lvert\zeta\rvert\lVert(W-\zeta)^{-1}\rVert\big)$. The inequality $\max(fg)\le\max f\cdot\max g$ is always valid, so the bound's direction is safe; the question is whether it is lossy. At $W^*$, normality gives $\lVert(W^*-\zeta)^{-1}\rVert=1/\operatorname{dist}(\zeta,\operatorname{spec})$ exactly, and on $\Gamma$ we have $\operatorname{dist}(\zeta,\lambda_-)\equiv\alpha g_n$ while $\operatorname{dist}(\zeta,\lambda_+)\ge(D-\alpha)g_n$. So:

- **For $\alpha\le D/2$**: $(D-\alpha)g_n\ge\alpha g_n$, so the resolvent norm is the **constant** $1/(\alpha g_n)$ on the whole of $\Gamma$, and the product of maxima equals the max of the product. **No loss.** This includes $\alpha^*=D/2$, L156's optimum, where the two distances are equal.
- **For $\alpha>D/2$**: the two maximisers separate. $\max_\Gamma\lVert(W^*-\zeta)^{-1}\rVert=1/((D-\alpha)g_n)$ is attained only at $\zeta_+=\lambda_-+\alpha g_n$, the point of $\Gamma$ nearest $\lambda_+$, where $\lvert\zeta_+\rvert=\lvert\alpha-1\rvert g_n$; whereas $\max_\Gamma\lvert\zeta\rvert$ is attained at the antipode $\zeta_-=-(1+\alpha)g_n$, where the resolvent norm is only $1/(\alpha g_n)$. The product of maxima is then strictly larger than the true max, by a factor no worse than $\alpha/(D-\alpha)$.

**Verdict: no finding.** The distribution is valid everywhere and sharp on $\alpha\le D/2$, which contains the only optimum the record uses; and the perturbed resolvent enters through a $z$-uniform Neumann bound, so it contributes no distribution loss at all.

## 8. C9, the gap between what is proven and what is used

**This is the round's centre, and the answer is that the one live import is sound.** The record has exactly two citers of L152, and they cite different things.

| citer | what it takes from L152 | hypotheses it supplies | sound? |
|---|---|---|---|
| [Lemma L156](../findings/second-order.md), proof, line 1425 | $\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$, "L152's surviving half" | states $m\ge2$, $W^*=S^m\times S^m$, $\ker W^*=0$, $\operatorname{spec}W^*=\{\lambda_-,\lambda_+\}$, $\Gamma$ the circle of radius $\alpha g_n$ about $\lambda_-$, $0<\alpha<D$ | **yes**, H1 stated outright; H2 and H2$'$ follow from $W^*=S^m\times S^m$ by §2's trace count, at every $m\ge2$ |
| [r708](../reviews/REVIEW_r708.md):46 | the $\alpha<1$ ruling, C7 |, | **yes, and correctly**: it cites L152 as having *denied* the truth, alongside r456 and r457 |

**So no clause is cited without its hypotheses at a live site.** H2 is not *stated* by L156 (it is derivable from L156's stated base point but appears nowhere as a line of text) and the identity is therefore imported in a form that would silently fail if the base point ever moved. That is a robustness defect rather than an error, and it is the one L156 should fix in a clause.

**The failure mode the round feared, checked and absent.** A citer centring $\Gamma$ somewhere other than $\lambda_-$ (at the perturbed eigenvalue $\lambda_-(z)$, say), would break H1 and with it C1's value. L156 centres at $\lambda_-=\lambda_-(0)$ throughout and takes the difference $W_-(z)-W_-(0)$ on that one fixed contour, so H1 holds. A citer at $\alpha\ge D$ would keep the identity but lose the object; L156 restricts to $0<\alpha<D$. **No finding.**

**What the round should notice instead.** The hypothesis-stripped form of the clause is already loose in the record, not in a lemma, but in the queue file: [plan-verification.md](../plan-verification.md):21 calls it *"the triangle equality on a circle"*, which is C1 and not C2. That is C3's export sentence doing exactly what the round was opened to catch, one level away from the mathematics.

## 9. C10, the missing canonical form

**Is the absence correct?** For the *entry*, yes. L152 is `REFUTED AS STATED`; its constant is wrong outside $\alpha\le D/2$, its $\alpha<1$ ruling is false (§6), and its Consequence does not follow from its display (§5). [results.md](../results.md) is the canon of what holds, and a refuted entry with three defective clauses has no business there. §§5–6 strengthen that: this round found *more* wrong with the entry than the record had, not less.

**Is a surviving clause nonetheless missing from the canon?** Yes, and it is missing from a live entry rather than from a dead one. [results.md](../results.md):355, L156's canonical form, carries $C(\alpha,\gamma)=\tfrac{\alpha(1+\alpha)}{d(d-\gamma)}$ and defines $d$, $D$ and the domain, but it states neither $\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$ nor $\lvert\lambda_-\rvert=g_n$. The identity is present there **only** as the bare $(1+\alpha)$ in the numerator, and its sole justification anywhere in the canon is a cross-reference, from a findings file, to a lemma marked refuted.

**The correct repair is one clause, not a new number.** Add to L156 (in the findings entry's hypothesis list and in the canonical form) that $\Gamma$ is centred at $\lambda_-$ with $\lvert\lambda_-\rvert=g_n$, the latter because $\dim E_-=m^2$ exceeds $\dim E_+=m(m-1)$ under $\operatorname{tr}W^*=0$. The identity is then stated where it is used, under hypotheses L156 already carries, and L152 can be cited for nothing at all. **Creating an L152 entry in [results.md](../results.md) would be the wrong fix**: it would canonise a number whose entry is refuted, and the clause would go on travelling with a refuted heading attached.

## 10. What would falsify the surviving identity, and what I did to look for it

**The object that would break it.** A base point in the chain's setting whose negative eigenvalue is *not* the spectral point nearest the origin, i.e. $\lambda_+<\lvert\lambda_-\rvert$, so that $g_n=\lambda_+$ and the identity reads $\max_\Gamma\lvert\zeta\rvert=\big(\tfrac{\dim E_+}{\dim E_-}+\alpha\big)g_n\ne(1+\alpha)g_n$. For a trace-free symmetric operator with two eigenvalues this is exactly the condition $\dim E_+\ge\dim E_-$. The second falsifier is any $W$ with $0\in\operatorname{spec}W$, where $g_n=0$ and the identity fails outright.

**Where I looked, and it was all closed-form reading.**

- **On the balanced family**: trace-freeness forces $\lambda_+=\tfrac m{m-1}\lvert\lambda_-\rvert$, and $\tfrac m{m-1}>1$ for every $m\ge2$. So no falsifier of the first kind exists anywhere on $S^m\times S^m$, at any dimension, including the $m=2$ endpoint L156 admits and the $m=6$ the programme works at. The identity is safe on its own family with no dimensional caveat.
- **Off it**: the record's named kernel witness, padded $W_{\mathbb{CP}^2}$ with $\dim E_+=1$ and $\dim(E_+\oplus E_-)=3$, is a falsifier of the second kind, $g_n=0$, and §4 exhibits both sides. It is outside L152's setting and outside L156's stated hypotheses, so it falsifies the *exported sentence* of C3 rather than the lemma in place. That is precisely why the sentence should be repaired.
- **In the citers**: §8's table. Both live citations supply what they need.

**No numerical work was done.** Every number above, $\tfrac m{m-1}$, $D=\tfrac{2m-1}{m-1}=\tfrac{11}5$ at $m=6$, $\alpha^*=\tfrac{11}{10}$, $\tfrac{11}5\ne2$, $\tfrac{3/2}{1/4}=6$, $3g_n$ against $\tfrac32g_n$, $\alpha/\gamma=2$, is an exact hand evaluation of a closed form already on the record.

## Verdict

**`PROVEN, hypotheses corrected`.**

The surviving identity $\max_\Gamma\lvert\zeta\rvert=(1+\alpha)g_n$ is **true**, is **used soundly** at its one live site, and holds for every $\alpha>0$ including where $\Gamma$ encircles $0$. Its correct hypotheses are: $\Gamma$ centred exactly at $\lambda_-$, and $\lvert\lambda_-\rvert=g_n$, the latter a computed consequence of $\dim E_->\dim E_+$ under $\operatorname{tr}W^*=0$, which the entry mis-states as a definition, and which fails at the record's kernel witness. It needs neither $\lambda_-$ real nor $\lambda_-$ negative, and no constraint on $\alpha$.

**Two clauses of the entry fall outside the recorded refutation** and should be added to it: the "Consequence" is a `GAP`, the entry's four-factor display bounds $\lVert W_-\rVert$ and cannot produce a constant defined against $\sup_{\lvert z\rvert=\rho}\lVert A\rVert$, and the $\alpha<1$ ruling is `BROKEN`, false and self-contradicting, and it is the ruling on which every value of L156's corollary turns.
