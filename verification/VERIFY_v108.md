# VERIFY v108, Lemma L10: the $\mathbb{CP}^m$ closed form, "all below the threshold", "exactly one critical point per family", and the Ricci-plus-Bianchi dimension count

**Cold brief, Verifier v108.** No numerical work was done and no script was run; every value below is an exact hand evaluation, and every decimal is checked against a rational I evaluate here. Log: [agent_logs/verify-L10-v108.log](../agent_logs/verify-L10-v108.log). Target: [findings/graded-half.md](../findings/graded-half.md):468–476, with the canonical form at [results.md](../results.md):379 and the landscape summary at [results.md](../results.md):128.

## Verdicts

| # | claim, as written | verdict |
|---|---|---|
| C1 | heading: "the reducible-isotropy families carry one critical point each, **all below the threshold**" ([graded-half.md](../findings/graded-half.md):468, [results.md](../results.md):128, [results.md](../results.md):379) | **BROKEN**, false at $m=2$, where $\theta^2=3/2$ exactly |
| C2 | $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$ on the $\mathbb{CP}^m$ family | **PROVEN, hypotheses corrected** ($m\ge2$; proof is Fox's, at [algebra.md](../findings/algebra.md):25–29, which L10 does not cite) |
| C3 | "decreasing monotonically to $2/3$", "exactly $3/2$ at $m=2$" | **PROVEN**, both hand-derived below |
| C4 | "the critical point in each is forced rather than found" | **PROVEN** for $\mathbb{CP}^m$ only, elsewhere; **HYPOTHESIS-DEBT** for the other families |
| C5 | "there is exactly one per family" ([results.md](../results.md):379) | **BROKEN as counted**, a one-dimensional space carries **two** critical points, $\pm W$; the source's "up to sign" was dropped |
| C6 | "Ricci-flatness together with the first Bianchi identity cuts **each** … family down to a one-dimensional space" | **HYPOTHESIS-DEBT**, the only argument on file is a five-row table of computed ranks |
| C7 | the four decimals $1.115547$, $0.852944$, $0.720082$, $0.596068$ | two **PROVEN** exactly by hand ($\sqrt{56/45}$, $\sqrt{275/378}$); two **HYPOTHESIS-DEBT** (no closed form on file) |
| C8 | "All sit far below $\sqrt{3/2}$" | **BROKEN** under the reading its own antecedent invites, and an overstatement under the narrow reading |
| C9 | "Three of these are ungraded, with slack between $0.57$ and $0.96$" | **PROVEN** against the figures the same file records 24 lines above |
| C10 | "every **other** family's point sits below the threshold" ([results.md](../results.md):379, :128) | **HYPOTHESIS-DEBT**, the Grassmannian family is open by the record's own reviewer |

**Overall verdict: BROKEN**, with hypothesis debt on the mechanism. The block's mathematics is right and its headline is wrong, in the same block, three times over on the record, and the correction has already been written three separate times, each time somewhere a citation of the headline will never reach.

**One-line summary.** $\theta^2=3/2$ at $m=2$ is not below $\sqrt{3/2}$ (it *is* $\sqrt{3/2}$) so every form of L10 that says "all below the threshold" is false at the one member the whole threshold argument turns on, while the closed form itself is proved (elsewhere, uncited) and the dimension count that L10 advertises as its mechanism is a table of five computed ranks.

## 0. Conventions, fixed once

Quoted from [findings/conventions.md](../findings/conventions.md), never restated from memory.

- $Q(W)=W^2+W^\#$, Hamilton's quadratic map, sending $\mathcal W_n$ to itself. **It is homogeneous of degree two.**
- $P(W)=\langle W,Q(W)\rangle$, a **cubic** form, hence **odd**: $P(-W)=-P(W)$. The record states the oddness itself at [conventions.md](../findings/conventions.md)'s $W_0$, $H$ row, "cubics are odd".
- $\theta=P(W)/\lVert W\rVert^3$, and "critical point" means $Q(W)=\theta W$, the first-order condition on $\{\lVert W\rVert=1\}$ ([conventions.md](../findings/conventions.md):119). The weaker bracket form $[W,Q(W)]=0$ is explicitly **not** what is meant.
- $M(n)$ is the global maximum of $P$ on the unit sphere, and the same table records $M(n)\ge\sqrt{3/2}$ *because padded $W_{\mathbb{CP}^2}$ attains it*, with $M(4)=M(6)=\sqrt{3/2}$.
- $\dim\mathcal W_n=\frac{n(n-3)(n+1)(n+2)}{12}$: $10$ at $n=4$, $84$ at $n=6$.
- "the threshold" in this block is $\sqrt{3/2}=1.224744871\ldots$, the value the block itself writes out.

Two of these are load-bearing below and neither is optional: $Q$ is even, $P$ is odd, and $\sqrt{3/2}$ is *attained* on this record rather than approached.

## 1. The hypothesis inventory

**Hypotheses the block carries in its own text.**

| # | hypothesis | stated where | applies to |
|---|---|---|---|
| H1 | the family is "one-parameter-per-factor", $W$ constant on each ideal of the isotropy and constant on the complement | both forms | every family in the lemma |
| H2 | the isotropy is "reducible" | [results.md](../results.md):379 only, **[graded-half.md](../findings/graded-half.md):472 omits the word** | scope of "each family" |
| H3 | $m\ge2$ on the closed form | **neither form states it**; [Lemma L38](../results.md):501 does | $\theta^2$ for $\mathbb{CP}^m$ |
| H4 | the one-dimensional space is the fixed space of a group acting on $\mathcal W_n$ | **unstated anywhere in the block** | "forced rather than found" |
| H5 | the four named points are the ones tabulated, at $n=8,12,8,12$ | unstated | the four decimals |

**Hypotheses of every result the block imports.**

| imported | its hypotheses | checked against the object here |
|---|---|---|
| [Lemma L38](../results.md):501, cited by [results.md](../results.md):379 for strict decrease | **$m\ge2$**, and it states the conclusion non-strictly, "neither family exceeds $\sqrt{3/2}$ anywhere" | satisfied; **and L38's own phrasing is the correct one that L10's heading contradicts** |
| Fox's Lemma 10.1 and (10.4), via [algebra.md](../findings/algebra.md):25–29 | an orthogonal complex structure $\alpha$ on an $r$-dimensional subspace, **$r$ even, $2\le r\le n$** | satisfied at $r=2m$, $m\ge2$; $r=2$ is excluded by the formula's own denominator |
| [agent_logs/review_r15_report.md](../agent_logs/review_r15_report.md) §(d), for the dimension count | the **five tabulated families only**: $\mathfrak u(m)\subset\mathfrak{so}(2m)$ for $m=2..6$; $\mathfrak{sp}(1){\oplus}\mathfrak{sp}(2)\subset\mathfrak{so}(8)$; $\mathfrak{sp}(1){\oplus}\mathfrak{sp}(3)\subset\mathfrak{so}(12)$; $\mathfrak u(1){\oplus}\mathfrak{su}(2){\oplus}\mathfrak{su}(2)\subset\mathfrak{so}(8)$; $\mathfrak u(1){\oplus}\mathfrak{su}(2){\oplus}\mathfrak{su}(3)\subset\mathfrak{so}(12)$ | **violated by the quantifier "each"**, see §4 |
| [target.md](../findings/target.md):460, for $\dim\mathrm{Weyl}_{2m}^{U(m)}=1$ | measured as a nullity at **$m=2,3,4$ only** ("$1$ of $10$, $1$ of $84$, $1$ of $300$") | the equivariance argument is valid; its input is a finite measurement |
| the gradedness slack $S$ | trap **W4**: "the screen is vacuous when $\ker W\ne0$" ([INDEX-traps.md](../findings/INDEX-traps.md):22) | **does not bite**, W4 is a false-*positive* trap on $S=0$, and the block's three claims are $S>0$, an exhibited bracket leak. Recorded so the check is visible. |

**Which of these the written argument actually uses.** The written argument uses H1 and, in the canonical form only, H2; it uses the dimension count (C6) and nothing else. It does **not** use H3, H4, Fox, [target.md](../findings/target.md):460, or L38's non-strict phrasing, and each of those four is either the missing hypothesis or the missing proof of a claim the block makes.

**No finding:** nothing in the block depends on Cartan's classification, which [conventions.md](../findings/conventions.md) records as "cited to no source anywhere on the record". The canonical form's closing sentence ("the lemma reaches the reducible-isotropy families and no other critical point"), is an explicit scope disclaimer that keeps the enumeration question outside the lemma. That disclaimer is the single best-written line in either form.

**No finding on sources:** [Fox 2019](../references/fox-2019-nonassociative-curvature-algebra/notes.md), [Petersen–Stanfield 2025](../references/petersen-stanfield-2025-poincare-polynomials/notes.md) and [Nienhaus 2023](../references/nienhaus-2023-second-best-einstein/notes.md) are all present in [references/](../references/) with PDF and notes. No claim checked here rests on an unread source.

## 2. Pre-registered question 1, is every point below the threshold?

**Evaluate the closed form at $m=2$, by hand.**

$$\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}\Big|_{m=2}=\frac{(2+1)(2\cdot2-1)}{3\cdot2\cdot(2-1)}=\frac{3\cdot3}{6}=\frac96=\frac32.$$

So $\theta=\sqrt{3/2}$. **The $m=2$ member does not sit below the threshold. It equals the threshold.** The threshold *is* this point: [conventions.md](../findings/conventions.md)'s $M(n)$ row says $M(n)\ge\sqrt{3/2}$ holds *because* padded $W_{\mathbb{CP}^2}$ attains it, and [Observation L40](../results.md) records $\sqrt{3/2}$ as "attained at $W_{\mathbb{CP}^2}$ and at every zero-padding of it".

**What the heading and the canonical form claim.**

- The heading of the block, [graded-half.md](../findings/graded-half.md):468, "the reducible-isotropy families carry one critical point each, **all below the threshold**". Read alone, this asserts a strict inequality for every point of every family. It is **false**, at the family's first member.
- The landscape summary, [results.md](../results.md):128, repeats the same headline sentence in bold and then, in its body, writes "**every other** family's point sits below the threshold". The body is correct; the bold headline above it is not.
- The canonical form, [results.md](../results.md):379, carries the same false heading at :379 and the correct "every other family's point" at :381.
- The block's own body, [graded-half.md](../findings/graded-half.md):475, says the $m=2$ value is "equal to exactly $3/2$" and draws the right conclusion from it, "so the rival maximizer is the first member of this family rather than an isolated exception".

**So the block contradicts its own heading, and it does so knowingly**: the sentence that identifies the $m=2$ member as the rival maximizer is the sentence that makes the heading false. The mathematics is right and the citable line is wrong.

**A units hazard worth naming, since it protects the block from a second, worse reading.** The closed form is a formula for $\theta^2$, while the four decimals later in the same paragraph are values of $\theta$. A reader who carries "$3/2$" across the paragraph and compares it to "$\sqrt{3/2}=1.2247$" concludes that the $m=2$ member sits *above* the threshold. It does not: $\theta^2=3/2$ is $\theta=\sqrt{3/2}$, equality. The block never says which quantity the decimals are. **No finding of error, a finding of a legible route to one.**

## 3. Pre-registered question 2, is "one critical point each" proved, or is it one-dimensionality restated?

**How many critical points a one-dimensional family carries: two.**

Let the family's Weyl operators be the line $\mathbb R W$ with $\lVert W\rVert=1$. Its intersection with the unit sphere of $\mathcal W_n$ is $\{W,-W\}$, two points. Now use the conventions of §0 and nothing else. $Q$ is homogeneous of degree two, so

$$Q(-W)=(-W)^2+(-W)^\#=W^2+W^\#=Q(W).$$

Suppose $Q(W)=\theta W$. Then $Q(-W)=\theta W=(-\theta)(-W)$, so $-W$ satisfies the record's own definition of a critical point, with value $-\theta$. Equivalently and more simply: $P$ is an odd cubic and the unit sphere is antipodally symmetric, so the critical set is antipodally symmetric.

**Which of them the stated value belongs to.** $\theta^2$ takes the same value at both, so the *squared* closed form is indifferent. The stated $\theta=\sqrt{3/2}>0$ belongs to whichever of the two the record normalises to $\theta>0$, a normalisation [conventions.md](../findings/conventions.md) does fix, but for a different purpose: "**Normalise $W$ to $\theta>0$ before measuring $S$**". There is no convention on the record that identifies antipodal critical points, and L10 does not invoke the $\theta>0$ normalisation.

**Is the count proved, or is it one-dimensionality restated?** It is one-dimensionality restated, and restated with a qualifier dropped. The source is explicit: [review_r15_report.md](../agent_logs/review_r15_report.md) §(d) writes "Each family contains exactly **one unit Weyl operator up to sign**". [results.md](../results.md):379 renders that as "**there is exactly one per family**". The three words that made the sentence true are the three words that did not survive into the canonical form.

**And the deeper half of the question is the sharper answer.** One-dimensionality forces the *candidate*; it does not by itself force that the candidate is **critical**. Membership in the family plus uniqueness within it makes "criticality within the family" vacuous, which is precisely r15's point, stated there as "the tangent space to (family $\cap$ Weyl $\cap$ sphere) is zero-dimensional, so 'criticality within the family' is vacuous. The real content (which does hold), is the verified fact that this unique candidate satisfies $Q(W)=\theta W$ on the nose." That verification is a residual at $5\times10^{-16}$. **So the phrase "the critical point in each is forced rather than found" claims for linear algebra what the record supports with a floating-point residual**, except for the $\mathbb{CP}^m$ family, where §4 finds a real argument, in a file L10 does not cite.

## 4. Pre-registered question 3, is the dimension count on file?

**The claim.** "Ricci-flatness together with the first Bianchi identity cuts **each** one-parameter-per-factor family down to a one-dimensional space of Weyl operators." Universally quantified over families, and load-bearing: it is the whole of the lemma's stated mechanism.

**What is on file, read rather than assumed.** The record cites [Gate 2 on the graded enumeration (Reviewer 15)](../findings/graded-half.md):438, whose full report is [agent_logs/review_r15_report.md](../agent_logs/review_r15_report.md). Its §(d) is the only place the claim is supported, and what it contains is a table:

| family | Ricci-flat dim | Ricci-flat **and** Bianchi |
|---|---|---|
| $\mathfrak u(m)\subset\mathfrak{so}(2m)$, $m=2..6$ | 2 | 1 |
| $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)\subset\mathfrak{so}(8)$ | 2 | 1 |
| $\mathfrak{sp}(1)\oplus\mathfrak{sp}(3)\subset\mathfrak{so}(12)$ | 2 | 1 |
| $\mathfrak u(1)\oplus\mathfrak{su}(2)\oplus\mathfrak{su}(2)\subset\mathfrak{so}(8)$ | 3 | 1 |
| $\mathfrak u(1)\oplus\mathfrak{su}(2)\oplus\mathfrak{su}(3)\subset\mathfrak{so}(12)$ | 3 | 1 |

**That is a finite census of computed ranks, at nine members of five families.** It is not an argument that the rank of the Bianchi constraint on a $k$-factor family is $k-2$ for every $k$, and no such argument appears anywhere I read. **Verdict on C6: HYPOTHESIS-DEBT.**

**What would have to be shown, stated exactly.** For a compact subalgebra $\mathfrak h=\bigoplus_{i=1}^k\mathfrak h_i\subset\mathfrak{so}(n)$ with $\mathfrak m=\mathfrak h^\perp$, let $V=\{\sum_i a_i\Pi_{\mathfrak h_i}+g\,\Pi_{\mathfrak m}\}$, of dimension $k+1$. It must be shown that the linear conditions "$\mathrm{ric}=0$" and "first Bianchi $=0$" cut $V$ to a space of dimension exactly one, that is, that their joint rank on $V$ is exactly $k$, **for every $k$ and every such $\mathfrak h$**, and in particular that the joint rank never drops to $k-1$ (which would leave a pencil, and with it a curve of candidates) and never rises to $k+1$ (which would leave nothing, so the family would carry no point at all).

**A second finding, in the paragraph that summarises that table.** [graded-half.md](../findings/graded-half.md):442 says:

> "Ricci-flatness imposes *two* linear conditions on the three-parameter family, and adding the **first Bianchi identity** (which neither P2b script checked), cuts every family down to a **one-dimensional** space of Weyl operators."

*Locate.* [findings/graded-half.md](../findings/graded-half.md):442, the sentence under "The families are one-dimensional, so the critical points are forced".

*Exhibit the failure concretely.* Three parameters minus two independent linear conditions is already one-dimensional, so on its own arithmetic there is nothing left for Bianchi to cut. And the table it is summarising says otherwise at every row: the three-parameter families ($\mathfrak u(m)$, $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$, $\mathfrak{sp}(1)\oplus\mathfrak{sp}(3)$: two ideals plus $\mathfrak m$) have **Ricci-flat dimension 2**, so Ricci imposes **one** condition there, not two, and Bianchi imposes the second. The "two linear conditions" belongs to a different family in a different section of the same report, r15's Claim A, the real Grassmannian ansatz $W=a\Pi_1+b\Pi_2+g\Pi_{\mathfrak m}$, where Ricci-flatness gives $(k-1)a+lg=0$ and $(l-1)b+kg=0$, two conditions, and Bianchi is not needed at all (those operators are "diagonal in the coordinate-pair basis, so the $\Lambda^4$ part vanishes term by term", r15 (b)).

*Argue the opposite, most charitably.* Could "the three-parameter family" mean the four-parameter rows read loosely, with "two" then correct? No: the four-parameter rows have Ricci-flat dimension 3, again one condition. Could "two" count Ricci-and-Bianchi together? The sentence explicitly adds Bianchi afterwards. **Neither reading survives; the sentence fuses two of r15's sections and is false of both.** CONFIRMED.

**The argument that does exist, for one family only, in a file L10 never cites.** [findings/target.md](../findings/target.md):460 gives the real mechanism, and it is not the Ricci-plus-Bianchi count:

> "$\mathbb{CP}^m$ is the *unique* $U(m)$-invariant Weyl tensor up to scale, and criticality then follows **with no computation**, $Q$ is $O(n)$-equivariant, so $Q(W)$ is again $U(m)$-invariant, hence a multiple of $W$."

This is correct and it is the argument H4 needs, but note what it needs as **input**: that the one-dimensional space is $\mathcal W_n^{K}$, the fixed space of a *group*, not merely the solution set of two linear conditions on an ansatz. The distinction is not academic on this record: r15 found that at the $4{+}8$ split the ansatz family is **3**-dimensional while the space of $SO(4)\times SO(8)$-invariant symmetric operators on $\Lambda^2(\mathbb R^{12})$ is **4**-dimensional, so "the family is $SO(k)\times SO(l)$-invariant, so criticality within it is criticality" is, in r15's words, "false as written and needs $O(k)\times O(l)$". And [target.md](../findings/target.md):460's own input, $\dim\mathrm{Weyl}_{2m}^{U(m)}=1$, is a measured nullity at $m=2,3,4$ ("$1$ of $10$, $1$ of $84$, $1$ of $300$") so the equivariance argument is sound and its premise is again a finite census.

**Summary of question 3.** The dimension count as L10 states it has **no argument on file**, only a five-row table of computed ranks, whose prose summary in the same findings file is arithmetically inconsistent with it. A *different* and correct mechanism exists for the $\mathbb{CP}^m$ family at [target.md](../findings/target.md):460, resting on a finite nullity measurement, and L10 cites neither.

## 5. Every stated number, by hand

### 5.1 The closed form is proved, and the proof is Fox's

[findings/algebra.md](../findings/algebra.md):25–29 derives the family from [Fox 2019](../references/fox-2019-nonassociative-curvature-algebra/notes.md), which is in [references/](../references/) with PDF and notes. Fox's Lemma 10.1 builds an idempotent $S^r(\alpha)$ from an orthogonal complex structure $\alpha$ on an $r$-dimensional subspace, for every even $r$ with $2\le r\le n$; his (10.4) gives $\lvert S^r\rvert^2=6r(r-2)/((r+2)(r-1))$ in his metric; and $\theta=1/\lvert S^r\rvert$ in the Frobenius normalisation yields

$$\theta(S^r)^2=\frac{2(r+2)(r-1)}{3r(r-2)}.$$

**I check the identification $r=2m$ by hand**, since the whole of C2 hangs on it:

$$\frac{2(2m+2)(2m-1)}{3\cdot 2m\cdot(2m-2)}=\frac{2\cdot2(m+1)(2m-1)}{3\cdot 2m\cdot 2(m-1)}=\frac{4(m+1)(2m-1)}{12\,m(m-1)}=\frac{(m+1)(2m-1)}{3m(m-1)}.$$

Identical. And [algebra.md](../findings/algebra.md):11 identifies critical points of $P$ on the unit sphere with idempotents of Fox's algebra, verified against Fox's own tensor formula (5.11). **So for the $\mathbb{CP}^m$ family both the value and the criticality are proved, for every even $r$ from $4$ on, and L10 cites none of it, offering the unproved dimension count instead.** The hypothesis correction is $m\ge2$: at $m=1$ ($r=2$) the denominator $3m(m-1)$ is $0$ and the expression is undefined, which is the edge of the range and is examined in §7.

### 5.2 The value table, exact

$$\theta^2(m)=\frac{(m+1)(2m-1)}{3m(m-1)}$$

| $m$ | $2$ | $3$ | $4$ | $5$ | $6$ | $7$ | $8$ |
|---|---|---|---|---|---|---|---|
| numerator $(m+1)(2m-1)$ | $3\cdot3=9$ | $4\cdot5=20$ | $5\cdot7=35$ | $6\cdot9=54$ | $7\cdot11=77$ | $8\cdot13=104$ | $9\cdot15=135$ |
| denominator $3m(m-1)$ | $6$ | $18$ | $36$ | $60$ | $90$ | $126$ | $168$ |
| $\theta^2$ | $\mathbf{3/2}$ | $10/9$ | $35/36$ | $9/10$ | $77/90$ | $52/63$ | $45/56$ |

Three independent cross-checks against figures already on the record, all exact and all agreeing:

- $m=8$ gives $45/56$, which is [graded-half.md](../findings/graded-half.md):450's "confirmed independently at $m=8$ ($n=16$, $\theta^2=45/56$)".
- $m=4$ gives $35/36$, which is [review_r15_report.md](../agent_logs/review_r15_report.md)'s exact rational for $\mathfrak u(4)$ at $n=8$, and, by that report's triality finding, exactly $\theta^2_{2,6}$ for $S^2\times S^6$.
- $m=3$ gives $10/9$, and $\theta_0(6)^2=2\cdot5\cdot4/6^2=40/36=10/9$ by [conventions.md](../findings/conventions.md)'s closed form. So $\mathbb{CP}^3$ sits exactly at $\theta_0(6)$.

### 5.3 The limit $2/3$ and the monotonicity, derived

Split off the limit exactly:

$$\frac{(m+1)(2m-1)}{3m(m-1)}=\frac{2m^2+m-1}{3m^2-3m}=\frac23+\frac{3m-1}{3m(m-1)},$$

which I verify by recombining: $\tfrac23+\tfrac{3m-1}{3m(m-1)}=\tfrac{2m(m-1)+3m-1}{3m(m-1)}=\tfrac{2m^2-2m+3m-1}{3m(m-1)}=\tfrac{2m^2+m-1}{3m(m-1)}$, and $(m+1)(2m-1)=2m^2+m-1$. Correct.

Write $g(m)=\frac{3m-1}{3m(m-1)}$. For $m\ge2$, $g(m)>0$, so **$\theta^2>2/3$ always and $2/3$ is a limit, never a value**, which is what "decreasing monotonically to $2/3$" says. Strict decrease, by a difference rather than a derivative so the arithmetic is checkable:

$$g(m)-g(m+1)=\frac{3m-1}{3m^2-3m}-\frac{3m+2}{3m^2+3m}=\frac{(3m-1)(3m^2+3m)-(3m+2)(3m^2-3m)}{(3m^2-3m)(3m^2+3m)}.$$

Numerator: $(3m-1)(3m^2+3m)=9m^3+9m^2-3m^2-3m=9m^3+6m^2-3m$; and $(3m+2)(3m^2-3m)=9m^3-9m^2+6m^2-6m=9m^3-3m^2-6m$. Their difference is $9m^2+3m$, strictly positive for $m\ge2$; the denominator is positive for $m\ge2$. **So $g$, hence $\theta^2$, is strictly decreasing on the integers $m\ge2$, with supremum $3/2$ at $m=2$ and infimum $2/3$ unattained.** C3 is PROVEN. This also confirms [Lemma L38](../results.md):501's phrasing "neither family exceeds $\sqrt{3/2}$ anywhere", non-strict, and correct.

### 5.4 The four decimals

| value | what it is | closed form on file | hand check |
|---|---|---|---|
| $1.115547$ | $\mathbb{HP}^2=\tau(S^3\times S^5)$, $n=8$ | $\theta^2=56/45$, from the sphere-product form $\theta^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ at $n=8,p=3,q=5$ | $\frac{2\cdot7\cdot2\cdot4}{6\cdot15}=\frac{112}{90}=\frac{56}{45}=1.24444\ldots$; and $1.115547^2=0.7225{+}\ldots$ worked out as $1.2444451$, so $1.115547$ is the correct rounding of $\sqrt{56/45}=1.1155467$. **CONFIRMED** |
| $0.852944$ | $\mathbb{HP}^3$, $n=12$ | none in the block; [r461](../reviews/REVIEW_r461.md) derives $\theta^2_{\mathbb{HP}^m}=\frac{(m+2)^2(4m-1)}{9m(2m+1)(m-1)}$ | at $m=3$: $\frac{25\cdot11}{9\cdot3\cdot7\cdot2}=\frac{275}{378}=0.7275132$; and $0.852944^2=0.7225+0.0050048+0.0000087=0.7275135$, agreeing to $3\times10^{-7}$, the rounding error of the sixth decimal. **CONFIRMED against the reviewer's formula**, which the block does not carry. As a check of the reviewer's formula itself, $m=2$ gives $\frac{16\cdot7}{9\cdot2\cdot5\cdot1}=\frac{112}{90}=\frac{56}{45}$, reproducing the $\mathbb{HP}^2$ row exactly. |
| $0.720082$ | $\mathrm{Gr}_{\mathbb C}(2,2)$, $n=8$ | **none anywhere I read** | $0.720082^2=0.5184+0.00011808=0.5185181$, which is $14/27=0.5185185$ to $4\times10^{-8}$. *Recorded as an observation, not a check*: no derivation of $14/27$ is on file, so I am matching a decimal to a rational, which is not evidence. **HYPOTHESIS-DEBT** |
| $0.596068$ | $\mathrm{Gr}_{\mathbb C}(2,3)$, $n=12$ | **none anywhere I read** | $0.596068^2=0.355216+0.0000811=0.3552971$, matching no small rational I can exhibit. **HYPOTHESIS-DEBT** |

**On C10, "every other family's point sits below the threshold".** For the Wolf family this is now closed, but by [r461](../reviews/REVIEW_r461.md) and not by the block: that reviewer's formula gives $\theta^2\le56/45<3/2$ for all $m\ge2$, checked exactly at $m=2,3,4$. For the complex Grassmannian family the same reviewer writes "$\mathrm{Gr}_{\mathbb C}$ family open" in as many words. **So the universally quantified sentence "every other family's point sits below the threshold" is supported at two members of each family and proved for neither family as a family**, except the Wolf half, in a review, uncited by the lemma. HYPOTHESIS-DEBT.

### 5.5 "All sit far below $\sqrt{3/2}$"

$\sqrt{3/2}=1.2247449$ (check: $1.224745^2=1.49989009+0.00011022=1.5000003$, so $\sqrt{1.5}=1.2247449$ to seven places). Then

$$\sqrt{3/2}-\sqrt{56/45}=1.2247449-1.1155467=0.1091982.$$

**The same file, twenty-two lines above at [graded-half.md](../findings/graded-half.md):454, calls a gap of exactly this size the difference between a loose problem and a tight one**: had $\mathbb{HP}^2$ been ungraded, "the gap to $\sqrt{3/2}$ [would cut] from $0.324$ to $0.109$ and [turn] the ungraded half from a loose problem into a tight one." A gap the file elsewhere calls tight is not "far below". The other three are indeed far below ($0.372$, $0.505$, $0.629$). See §7, candidate D4.

### 5.6 "Three of these are ungraded, with slack between $0.57$ and $0.96$"

Against the figures the same file records at [graded-half.md](../findings/graded-half.md):452, $\mathbb{HP}^3$ at $S=+0.6734$, $\mathrm{Gr}_{\mathbb C}(2,2)$ at $S=+0.5714$, $\mathrm{Gr}_{\mathbb C}(2,3)$ at $S=+0.9631$, with $\mathbb{HP}^2$ graded. Three of the four listed points are ungraded: **correct**. The slack range is $[0.5714,\,0.9631]$: the stated $0.57$ is a true lower bound and $0.96$ is **not** an upper bound, $0.9631$ exceeding it. Under the charitable reading (figures rounded to two decimals), the sentence is fine, so this is recorded as a rounding note and **withdrawn as a defect**. C9 PROVEN.

## 6. Quantifier order, scope, and the edge of every range

**Quantifier order, as written and as supported.** The claim is $\forall$ family $\exists!$ line: "cuts **each** one-parameter-per-factor family down to a one-dimensional space". What is on file is a list: $\exists$ nine members of five families at which a computed rank came out $1$ (§4). **The order is $\forall\exists$ and the evidence is a finite list**; nothing converts one into the other, and the block does not say it has only the list.

**The edge of the range: $m=2$.** This is the smallest admissible $m$, since $3m(m-1)$ vanishes at $m=1$. It is also (i) the maximum of the family, (ii) the value the entire threshold argument compares against, and (iii) **outside every verification of the closed form the record performs by construction**: [review_r15_report.md](../agent_logs/review_r15_report.md)'s Hermitian rows are $m=4..7$, its independent Fubini–Study construction runs at $m=3,4,5,6$, and [graded-half.md](../findings/graded-half.md):450's independent confirmation is at $m=8$. The one $m$ nobody built is the one the argument turns on. *This is not a defect*, because [algebra.md](../findings/algebra.md)'s Fox derivation (§5.1) covers every even $r\ge4$ including $r=4$, and [target.md](../findings/target.md):460's nullity measurement includes $m=2$ ("$1$ of $10$"). **It is a defect of citation**: L10 points at neither, so a reader auditing L10 alone finds the crux value supported by extrapolation from $m\ge3$.

**$m=1$.** $\mathbb{CP}^1=S^2$ gives $n=2$, and $\dim\mathcal W_n=\frac{n(n-3)(n+1)(n+2)}{12}$ at $n=2$ is $\frac{2\cdot(-1)\cdot3\cdot4}{12}=-2$, i.e. $\mathcal W_2=0$. **The pole at $m=1$ is not a removable accident: there is no object there to have a value.** Neither form of L10 states $m\ge2$; [Lemma L38](../results.md):501 does.

**What "one-parameter-per-factor" admits, and the scope gap it hides.** It admits any $W=\sum_i a_i\Pi_{\mathfrak h_i}+g\,\Pi_{\mathfrak m}$. Two things follow that the block does not say.

1. **It admits $k=1$ (a simple isotropy), in the [graded-half.md](../findings/graded-half.md):472 form, which omits the word "reducible-isotropy" that [results.md](../results.md):381 carries.** The findings-file form therefore quantifies over strictly more families than the canonical form, including ones for which the parameter count is $2$ rather than $\ge3$ and for which no row of r15's table speaks. The two "canonical" texts are not the same statement.
2. **"One-parameter-per-factor" is an ansatz, not an invariant space.** Constancy on $\mathfrak m$ is an assumption; if $\mathfrak m$ is reducible under $\mathfrak h$ the true invariant space is larger. The record has already been bitten here: r15 found the $4{+}8$ split's invariant space is **4**-dimensional against the ansatz's **3**, because $\Lambda^2(\mathbb R^4)=\Lambda^+\oplus\Lambda^-$ splits under $SO(4)$ and $\Pi_{\Lambda^+}-\Pi_{\Lambda^-}$ is an extra invariant direction. **A consumer reading "the critical point in each family is forced" will take it as a statement about the invariant space; it is a statement about the ansatz.**

**The $n$-range, recorded for consumers.** The block's points sit at $n=4$ ($m=2$), $8$, $8$, $12$, $12$, and the family runs to $n=2m$. The threshold $\sqrt{3/2}$ is $M(4)=M(6)$ by [conventions.md](../findings/conventions.md), and $\theta_0(n)^2>3/2\iff 2(n-1)(n-2)/n^2>3/2\iff 4(n-1)(n-2)>3n^2\iff n^2-12n+8>0$, which first holds at $n=12$ ($144-144+8=8>0$; at $n=11$, $121-132+8=-3<0$). **So for $n\ge12$ the sphere products already exceed $\sqrt{3/2}$ and a comparison against it is not by itself a comparison against the ambient maximum.** L10's closing disclaimer ("the lemma reaches the reducible-isotropy families and no other critical point"), is what keeps this from being a defect. It is present only in the canonical form; [graded-half.md](../findings/graded-half.md):472–476 has no such sentence.

**No finding on $n=8$ triality.** The block lists $\mathbb{HP}^2$, which the record identifies as the $n=8$ triality image $\tau(S^3\times S^5)$ and which sits outside Cartan's $\mathfrak{so}(n)$ list. Because L10 makes no enumeration claim, the "$n\ne8$" caveat that [graded-half.md](../findings/graded-half.md):404 attaches to the enumeration is not owed here.

## 7. Comparing the forms

Four written forms exist. **They make four different claims, and they are ordered by accuracy in the reverse of their citability.**

| where | what it says | correct? |
|---|---|---|
| [graded-half.md](../findings/graded-half.md):468, the block's heading | "carry one critical point each, **all below the threshold**" | **No**, false at $m=2$ |
| [results.md](../results.md):128, the landscape bullet | bold headline repeats "all below the threshold"; body then says "every **other** family's point sits below" | **headline no, body yes** |
| [results.md](../results.md):379–381, the canonical form | heading repeats "all below the threshold"; body says "exactly $\tfrac32$ at $m=2$ … every other family's point sits below", cites [L38](../results.md):501, and adds the scope disclaimer | **heading no, body yes**; and "exactly one per family" is the miscount of §3 |
| [lean/INDEX.md](../lean/INDEX.md):260 | "the $\mathbb{CP}^m$ family is **strictly** below $3/2$ from $m=3$ on, with $m=2$ the sole member attaining it. … The rest of L10, *every other family below threshold*, needs those families' values, which are not on the record in closed form" | **Yes, on both counts** |

**The Lean row is the only form on the record that states the $m=2$ case correctly and the only one that declares the Wolf/Grassmannian half unproved.** Its status is marked `partial`, and it derives the half it formalises from [L38](../lean/HamiltonsCubic/Results/L38.lean) rather than restating it. Independently checked here: the row's two assertions match §2 and §5.4 exactly. **No repair is owed on the Lean side.** The repair is owed on the three prose forms, whose headings the Lean row already contradicts.

**A second form-comparison finding.** [graded-half.md](../findings/graded-half.md):450 says "$W_{\mathbb{CP}^2}$ is the $m=2$ member of this family", of the $\mathbb{CP}^m$ family; [Lemma L38](../results.md):501 says "the $m=2$ member of **the second family** is $W_{\mathbb{CP}^2}$ itself", of the $(\mathfrak{su}(m),\mathfrak{so}(m))$ family. Both families have $\theta^2=3/2$ at $m=2$ and both live in $\mathfrak{so}(4)$ ($\mathfrak u(2)$ of dimension $4$; and $p=\binom22=1$, $q=\binom32-1=2$, $p+q=3=\dim\mathfrak{su}(2)$). *Argued the other way*: $\dim\mathcal W_4=10$, $M(4)=\sqrt{3/2}$ is attained at $W_{\mathbb{CP}^2}$, and a single operator may lie in two ansatz families whose stabilisers both contain its own; there is no contradiction. **Candidate WITHDRAWN**, reason: the charitable reading survives. Recorded because two lemmas name the same operator as the extreme member of two different families without either saying so.

## 8. The discrepancy register

Each candidate gets the three steps, located with the line quoted, exhibited at a named object, and argued the other way. Candidates failing any step are withdrawn with the reason.

### D1, "all below the threshold" is false at $m=2$. CONFIRMED.

*Locate.* [graded-half.md](../findings/graded-half.md):468, and verbatim at [results.md](../results.md):128 and [results.md](../results.md):379: "**the reducible-isotropy families carry one critical point each, all below the threshold**".

*Exhibit, at a named object.* At $m=2$ the closed form gives $\frac{3\cdot3}{3\cdot2\cdot1}=\frac96=\frac32$, so $\theta=\sqrt{3/2}$ at the $m=2$ member, the operator the record names $W_{\mathbb{CP}^2}$, whose value [conventions.md](../findings/conventions.md) uses to assert $M(n)\ge\sqrt{3/2}$ and which [Observation L40](../results.md) records as *attaining* $\sqrt{3/2}$. Equality, not strict inequality.

*Argue the opposite.* The most charitable reading is that "below" is loose for "not above", which would make the heading true. **It does not survive.** (i) The same block writes "All sit **far** below $\sqrt{3/2}$", which cannot be read non-strictly. (ii) The canonical form's own body writes "every **other** family's point sits below the threshold", the word "other" exists precisely because the author knew $m=2$ is not below. (iii) [Lemma L38](../results.md):501, which L10 cites, states the same fact correctly and non-strictly: "neither family exceeds $\sqrt{3/2}$ anywhere". A record that has the non-strict phrasing available and did not use it here is not using "below" non-strictly.

### D2, "there is exactly one per family" drops "up to sign" and undercounts by two. CONFIRMED.

*Locate.* [results.md](../results.md):381: "so the critical point in each family is forced rather than found, **and there is exactly one per family**."

*Exhibit, at a named object.* The one-dimensional space is $\mathbb R\,W_{\mathbb{CP}^2}\subset\mathcal W_4$. Its unit sphere is $\{W_{\mathbb{CP}^2},-W_{\mathbb{CP}^2}\}$. $Q$ is homogeneous of degree $2$, so $Q(-W)=Q(W)=\theta W=(-\theta)(-W)$: both points satisfy [conventions.md](../findings/conventions.md):119's definition $Q(W)=\theta W$, with values $+\sqrt{3/2}$ and $-\sqrt{3/2}$. Two critical points, not one.

*Argue the opposite.* The charitable reading is "one up to sign", or "one with $\theta>0$" under [conventions.md](../findings/conventions.md)'s normalisation rule. **That reading is right about the mathematics and is exactly what the source says**, [review_r15_report.md](../agent_logs/review_r15_report.md) §(d): "Each family contains exactly one unit Weyl operator **up to sign**." So the defect is not an error of fact; it is a qualifier present in the source and absent from the canonical form, in the one sentence a consumer will quote. Severity low, provenance exact.

### D3, the summary of the dimension count is arithmetically inconsistent with the table it summarises. CONFIRMED.

Fully worked in §4. In one line: [graded-half.md](../findings/graded-half.md):442's "Ricci-flatness imposes *two* linear conditions on the three-parameter family, and adding the first Bianchi identity … cuts every family down to a one-dimensional space" leaves Bianchi nothing to cut on its own arithmetic, and contradicts r15's table, where the three-parameter rows have Ricci-flat dimension $2$, one condition, not two. The "two conditions" belongs to r15's *real Grassmannian* family, where Bianchi is not needed at all.

### D4, "All sit far below $\sqrt{3/2}$" is an overstatement, and false under the reading its antecedent invites. CONFIRMED.

*Locate.* [graded-half.md](../findings/graded-half.md):476: "The Wolf spaces give $1.115547$ and $0.852944$, the complex Grassmannians $0.720082$ and $0.596068$. **All sit far below $\sqrt{3/2}$.**"

*Exhibit.* $\sqrt{3/2}-\sqrt{56/45}=1.2247449-1.1155467=0.1091982$ at $\mathbb{HP}^2$, a gap the *same file* at [graded-half.md](../findings/graded-half.md):454 calls the difference between "a loose problem" and "a tight one". And the sentence two lines earlier has just given a value of the $\mathbb{CP}^m$ family equal to the threshold, so a reader taking "All" to range over everything just listed reads a flatly false sentence.

*Argue the opposite.* The narrow reading ("All" ranges over the four decimals only), is grammatically the better one, and under it the sentence is not false, merely wrong about "far" at one of the four. **The candidate survives in the weaker form**: an overstatement at $\mathbb{HP}^2$ that the same file contradicts twenty-two lines above, sitting immediately after a sentence that makes the wider reading false. Recorded at that strength.

### D5, "reducible-isotropy" names the wrong thing. CONFIRMED, low severity.

*Locate.* [results.md](../results.md):381, "each one-parameter-per-factor **reducible-isotropy** family".

*Exhibit.* The family's leading member is $\mathfrak u(m)\subset\mathfrak{so}(2m)$, which acts **irreducibly** on $\mathbb R^{2m}$: the centre of $\mathfrak u(m)$ is $\mathbb R J$, so every invariant real subspace is $J$-invariant, hence a complex subspace, and $\mathfrak{su}(m)$ acts irreducibly on $\mathbb C^m$; so the only invariant subspaces are $0$ and $\mathbb R^{2m}$. What is reducible is the *algebra* ($\mathfrak u(m)=\mathbb R J\oplus\mathfrak{su}(m)$ is not simple) which is what "one-parameter-per-factor" already encodes.

*Argue the opposite.* "Reducible" could be intended of the algebra. **But the same file uses the word in the representation sense for exactly this kind of object**: [graded-half.md](../findings/graded-half.md):413 and :498 say $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ "acts **irreducibly** on $\mathbb R^8$, so no element of $O(8)$ carries it to a sphere product". A file that distinguishes the two senses in one place and conflates them in another has a misnomer, not a convention.

### D6, the slack interval $[0.57,0.96]$ excludes its own largest member. WITHDRAWN.

$\mathrm{Gr}_{\mathbb C}(2,3)$ has $S=+0.9631>0.96$. *Reason for withdrawal*: the charitable reading (both endpoints rounded to two decimals), survives intact, and the block gives no indication of intending exact bounds.

### D7, $W_{\mathbb{CP}^2}$ is named the $m=2$ member of two different families. WITHDRAWN.

Worked in §7. *Reason for withdrawal*: both families reduce to $\mathfrak{so}(4)$ at $m=2$ and a single operator may lie in two ansatz families; no contradiction is exhibited.

## 9. The gap between what is proven and what is used, what a consumer may cite

| a consumer may cite | on what |
|---|---|
| $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$ on the $\mathbb{CP}^m$ family, **for $m\ge2$** | Fox's Lemma 10.1 and (10.4) via [algebra.md](../findings/algebra.md):25–29, a genuine derivation from a read source, **cite that file, not L10** |
| strictly decreasing in $m$, supremum $3/2$ at $m=2$, infimum $2/3$ unattained | §5.3 here, and [Lemma L38](../results.md):501 |
| $\theta=\sqrt{3/2}$ **exactly** at $m=2$, i.e. the family **attains** the threshold and does not fall below it | §2 here; and [lean/INDEX.md](../lean/INDEX.md):260, the only form on the record that says it |
| the $\mathbb{CP}^m$ points are critical, with no numerics | [target.md](../findings/target.md):460's equivariance argument, with its input $\dim\mathrm{Weyl}_{2m}^{U(m)}=1$ a measured nullity at $m=2,3,4$ |
| $\theta(\mathbb{HP}^2)=\sqrt{56/45}=1.1155467$ and $\theta(\mathbb{HP}^3)=\sqrt{275/378}=0.8529439$ | §5.4; the $\mathbb{HP}^m$ closed form is [r461](../reviews/REVIEW_r461.md)'s, not the block's |
| three of the four Wolf/Grassmannian points are ungraded, slacks $0.5714$, $0.6734$, $0.9631$ | [graded-half.md](../findings/graded-half.md):452 |

| a consumer may **not** cite | why |
|---|---|
| "all below the threshold", in any of its three prose sites | false at $m=2$, D1 |
| "there is exactly one critical point per family" | two, $\pm W$; the source says "up to sign", D2 |
| "Ricci-flatness together with the first Bianchi identity cuts **each** … family to a one-dimensional space" | five rows of computed ranks, no argument, §4, C6 |
| "the critical point in each is forced rather than found", for any family other than $\mathbb{CP}^m$ | one-dimensionality forces the candidate; its criticality is a $5\times10^{-16}$ residual, §3 |
| "every other family's point sits below the threshold" | Wolf half closed in a review; **complex Grassmannian family open**, in that reviewer's own words, §5.4 |
| $\theta(\mathrm{Gr}_{\mathbb C}(2,2))=0.720082$ and $\theta(\mathrm{Gr}_{\mathbb C}(2,3))=0.596068$ as family statements | two members; no closed form on file, §5.4 |

## 10. The named trap, each citable claim read alone, as a consumer would

This record's signature failure is a correction landing **beside** the statement it corrects. **L10 is the most developed instance of it I have seen on this record: the correction to D1 has now been written three separate times, and every one of them landed somewhere a citation of the heading will never go.**

1. **[reviews/REVIEW_r461.md](../reviews/REVIEW_r461.md), CAVEAT 1**, "the block TITLE says 'all below the threshold'; the $m=2$ member EQUALS the threshold $\sqrt{3/2}$ (the body says so). Title overstates."
2. **[reviews/REVIEW_r462.md](../reviews/REVIEW_r462.md)**, "DEFECT: the TITLE says 'all below the threshold' but $m=2$ sits EXACTLY AT the threshold $\sqrt{3/2}$, it IS the rival maximizer, as the body itself says. 'All sit far below $\sqrt{3/2}$' is also false as written for the $\mathbb{CP}^m$ family."
3. **[findings/LEDGER.md](../findings/LEDGER.md):1021**, "**L10 states that the reducible-isotropy families sit below the threshold, which is a different claim**, and $m=2$ sits *at* $\sqrt{3/2}$ rather than below it." *Used there to resolve a citation dispute between two reviewers by routing a citation away from L10.*

**And [findings/INDEX-results.md](../findings/INDEX-results.md):25, the row a consumer looks up, reads: "Gate 2 passed ([r461](../reviews/REVIEW_r461.md), [r462](../reviews/REVIEW_r462.md)), numbers confirmed with two hypothesis caveats. the reducible-isotropy families carry one critical point each, all below the threshold."** The index row repeats the false headline and compresses the caveat that refutes it into the words "two hypothesis caveats". A reader who trusts the index and does not open two reviewer reports carries away the false claim **with a Gate-2 pass attached to it**.

**Reading each citable claim alone, cold.**

- *"The reducible-isotropy families carry one critical point each, all below the threshold."*, **two falsehoods in eleven words**: the count is two per family up to sign, and the first member is not below.
- *"Ricci-flatness plus first Bianchi makes each family one-dimensional, so the point is forced and there is one per family."* ([results.md](../results.md):128), reads as a theorem; is a five-row table.
- *"For $\mathbb{CP}^m$, $\theta^2=(m+1)(2m-1)/(3m(m-1))$, exactly $3/2$ at $m=2$ and decreasing; every other family's point sits below the threshold."* ([results.md](../results.md):128), **correct**, and the only line in the three prose forms that a consumer can quote whole without inheriting a defect.
- *"All sit far below $\sqrt{3/2}$."*, quoted without its antecedent, false; with it, an overstatement at $\mathbb{HP}^2$.
- *"The lemma reaches the reducible-isotropy families and no other critical point."* ([results.md](../results.md):381), **correct and valuable**, and absent from [graded-half.md](../findings/graded-half.md)'s copy of the same "canonical" block.

**The one-line repair the trap calls for, stated so it cannot land beside anything**: the heading must read *"…one critical point each, none above the threshold, with the $\mathbb{CP}^m$ family attaining it at $m=2$"*, in all three prose sites at once, which is [Lemma L38](../results.md):501's phrasing, already on this record, and [lean/INDEX.md](../lean/INDEX.md):260's, already on this record. **I record the repair and do not make it: fixing the text is not a verifier's act.**

## 11. What would break it, and what I did to look for it

**The object that would falsify the surviving mathematics.** A member of one of these families, a one-parameter-per-factor $W=\sum_i a_i\Pi_{\mathfrak h_i}+g\Pi_{\mathfrak m}$, Ricci-flat, first-Bianchi-free, of unit norm, satisfying $Q(W)=\theta W$, with either (i) $\theta>\sqrt{3/2}$, or (ii) a *second* linearly independent such $W$ in the same family, which would refute the one-dimensionality outright.

**Where such an object would have to live, and why I could not settle it.** For the $\mathbb{CP}^m$ family, (i) is closed by §5.3 and (ii) by [target.md](../findings/target.md):460's equivariance argument wherever $\dim\mathrm{Weyl}_{2m}^{U(m)}=1$ is known, measured at $m=2,3,4$, unknown beyond. For the Wolf family, (i) is closed by [r461](../reviews/REVIEW_r461.md)'s formula, checked exactly at $m=2,3,4$. **For the complex Grassmannian family both remain open**, and that is the concrete place a falsifier would sit: a $\mathrm{Gr}_{\mathbb C}(j,k)$ member at large $j,k$, where no closed form exists on this record and the two tabulated values ($n=8$ and $n=12$) are decreasing but establish no trend.

**What I did to look for it.** I read [graded-half.md](../findings/graded-half.md):400–499, [results.md](../results.md):120–135, :370–390 and :495–520, [conventions.md](../findings/conventions.md), [INDEX-traps.md](../findings/INDEX-traps.md), [INDEX-results.md](../findings/INDEX-results.md):25, [LEDGER.md](../findings/LEDGER.md):1010–1026, [target.md](../findings/target.md):458–480, [algebra.md](../findings/algebra.md):1–45, [lean/INDEX.md](../lean/INDEX.md):260, the cited [review_r15_report.md](../agent_logs/review_r15_report.md) in full, and the two Gate-2 reviews [r461](../reviews/REVIEW_r461.md) and [r462](../reviews/REVIEW_r462.md) at the L10 rows; I confirmed [Fox 2019](../references/fox-2019-nonassociative-curvature-algebra/), [Petersen–Stanfield 2025](../references/petersen-stanfield-2025-poincare-polynomials/) and [Nienhaus 2023](../references/nienhaus-2023-second-best-einstein/) are present in [references/](../references/). **No script was run and no numerical work was done.** A falsifier of the kind above cannot be found by reading; deciding the Grassmannian family needs either a closed form derived by hand or a computation, and this programme is on an analysis-only footing, so I name the block and stop rather than opening a run.

**Silence, closed out.** *No finding:* on the $n=8$ triality caveat (§6), on trap W4 against the slack figures (§1), on the closing scope disclaimer, and on the Lean row, which is correct as written and needs no repair.

## Verdict

**BROKEN**, with hypothesis debt on the mechanism.

- **BROKEN** is issued on the heading as quoted in the brief, [graded-half.md](../findings/graded-half.md):468, and on the two prose forms that repeat it: "all below the threshold" is false at $m=2$, where $\theta^2=3/2$ exactly and the family *attains* $\sqrt{3/2}$. It is issued a second time on "there is exactly one per family", which undercounts $\{\pm W\}$ by two and drops the source's own "up to sign".
- **HYPOTHESIS-DEBT** stands on the lemma's stated mechanism. What would have to be shown: that for every compact $\mathfrak h=\bigoplus_{i=1}^k\mathfrak h_i\subset\mathfrak{so}(n)$ the joint rank of Ricci-flatness and the first Bianchi identity on the $(k+1)$-parameter space $\{\sum_i a_i\Pi_{\mathfrak h_i}+g\Pi_{\mathfrak m}\}$ is exactly $k$; that the resulting line is the *invariant* space of a group and not merely an ansatz's solution set, so that the equivariance of $Q$ carries criticality; and that the complex Grassmannian family's values are bounded below $\sqrt{3/2}$ as a family. On file for the first: five rows of computed ranks. On file for the second: an argument at [target.md](../findings/target.md):460 for the $\mathbb{CP}^m$ family alone, resting on a nullity measured at three values of $m$. On file for the third: two members, and a reviewer writing "$\mathrm{Gr}_{\mathbb C}$ family open".
- **The mathematics the block was built to deliver survives, and is stronger than the block claims for it.** The closed form is *proved* for every $m\ge2$ by Fox's Lemma 10.1 and (10.4), read from a source in [references/](../references/) and recorded at [algebra.md](../findings/algebra.md):25–29, a derivation L10 does not cite, offering the unproved dimension count in its place.
