# VERIFY v109, Lemma L10: "the reducible-isotropy families carry one critical point each, all below the threshold", the $\mathbb{CP}^m$ closed form, and the Ricci-flatness-plus-Bianchi dimension count

**Standfirst.** Verifier v109, cold brief, on the block at [graded-half.md](../findings/graded-half.md):468–476 with the canonical form at [results.md](../results.md):379–381 and the landscape summary at [results.md](../results.md):128. **No numerical work was done: no script was run, and every value below is an exact hand evaluation of a rational function or an exact quotation from a file or a source in [references/](../references/).** Log at [agent_logs/verify-L10-v109.log](../agent_logs/verify-L10-v109.log).

## Claim table

| # | claim, as a consumer would read it | verdict |
|---|---|---|
| C1 | **"The reducible-isotropy families carry one critical point each, all below the threshold"** (the heading, in all three files) | **BROKEN**, false at the $m=2$ member the block itself names, which sits *at* $\sqrt{3/2}$ |
| C2 | $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$ on the $\mathbb{CP}^m$ family | **PROVEN (hypotheses corrected**), arithmetic exact, source-checked against Fox; needs $m\ge2$, which the block never states |
| C3 | "equal to exactly $3/2$ at $m=2$" | **PROVEN**, $9/6=3/2$ exactly |
| C4 | "decreasing monotonically to $2/3$" | **PROVEN**, strict on $m>1$; $2/3$ is an infimum, never attained |
| C5 | The four decimals $1.115547$, $0.852944$, $0.720082$, $0.596068$ | **PROVEN** for the two Wolf values against a closed form on the record; **HYPOTHESIS-DEBT** for the two Grassmannian values, which have no closed form anywhere |
| C6 | **"All sit far below $\sqrt{3/2}$"** | **BROKEN**, $\mathbb{HP}^2$ is at $91.1\%$ of the threshold, a gap the same file calls *tight* |
| C7 | **"there is exactly one per family"** | **BROKEN as a count**, a line meets the sphere in $\pm W$ and $P$ is odd, so every such family carries **two** critical points |
| C8 | **"the critical point in each is forced rather than found"** | **HYPOTHESIS-DEBT**, one-dimensionality alone entails neither existence nor criticality; the step that does the work is equivariance, on file at [target.md](../findings/target.md):460 and cited nowhere in L10 |
| C9 | **"Ricci-flatness together with the first Bianchi identity cuts each one-parameter-per-factor family down to a one-dimensional space"** | **HYPOTHESIS-DEBT**, no derivation on file; the one text asserting it has arithmetic inconsistent with its own conclusion, and is stated for a family class the lemma's conclusion is false on |
| C10 | **"every other family's point sits below the threshold"** | **BROKEN under the literal reading**, the $\mathfrak{so}(6)\oplus\mathfrak{so}(6)$ family at $n=12$ is one-parameter-per-factor and sits at $55/36=\tfrac32+\tfrac1{36}$; **HYPOTHESIS-DEBT** under the intended narrow reading, the complex-Grassmannian family being supported at two members |
| C11 | **"Gate 2 passed"** at [INDEX-results.md](../findings/INDEX-results.md):25 | **BROKEN**, both cited reviewers' own headers say Gate 2 on these claims is **not** complete, and neither returned a clean pass |

**Summary.** *The arithmetic of L10 is right and the statement of L10 is wrong*: the closed form is exact and now source-checked, while the citable heading is false at the one member that matters, the count is off by a factor of two, and the mechanism the lemma advertises has no argument anywhere on the record.

**VERDICT: BROKEN.**

## 0. Conventions, fixed once

- $\mathcal W_n$ is the space of Weyl operators; $P(W)=\langle W,W^\#\rangle$ is a **cubic**, and $\theta$ is its value at a unit critical point, so $\theta$ is **odd** in $W$, recorded independently at [L108](../lean/INDEX.md).
- **The threshold** is $\sqrt{3/2}$, the value at $W_{\mathbb{CP}^2}$. It is not $\theta_0(n)$ and not $\Theta_n$: [conventions.md](../findings/conventions.md):18–21 keeps those three apart, and $M(n)\ge\sqrt{3/2}$ at every $n\ge4$ by padding. **L10's block defines "the threshold" nowhere**; I read it as $\sqrt{3/2}$ because the block's own next sentence names $\sqrt{3/2}$.
- $\lvert W\rvert^2=4\lVert W\rVert_F^2$ relates the two $\Lambda^2$ normalisations ([conventions.md](../findings/conventions.md):63). This factor of $4$ is load-bearing in §7 below.
- An **$r$-factor isotropy** carries an **$(r+1)$-parameter** invariant family: one parameter per isotropy ideal plus one on $\mathfrak m$. That is the count [graded-half.md](../findings/graded-half.md):23, :37 and :73 use throughout.

## 1. The hypothesis inventory

### 1a. Hypotheses the block carries

The block states **no hypothesis of any kind**. Every entry below is one I recovered from the objects the block applies itself to.

| # | hypothesis | stated in the block? | used by the written argument? | checked against the object |
|---|---|---|---|---|
| H1 | the family is a *one-parameter-per-factor reducible-isotropy family* | named, **never defined** | yes, it is the subject of both clauses | **fails to pin a class.** [graded-half.md](../findings/graded-half.md):88 and :101 use "reducible-isotropy classes" for exactly three classes, Hermitian pairs, Wolf spaces, complex Grassmannians. The phrase as written also admits $\mathfrak{so}(k)\oplus\mathfrak{so}(l)$, on which the conclusion is false (§6) |
| H2 | the operators are **Ricci-flat** | yes | asserted as the cutting mechanism | **not a hypothesis on the family.** Ricci-flatness is part of what makes an algebraic curvature operator a Weyl operator; the block presents a defining property of the ambient space as a condition imposed on the family |
| H3 | the operators satisfy the **first Bianchi identity** | yes | asserted as the cutting mechanism | same as H2, a defining property of $\mathcal W_n$, presented as an imposed cut |
| H4 | $m\ge2$ | **no** | required for the closed form to be defined | **fails at $m=1$**: the denominator $3m(m-1)$ is $0$. Independently, Fox's Lemma 10.1 declares $S^2(\alpha)$ **trivial** at $r=2m=2$ (§7) |
| H5 | the $\mathbb{CP}^m$ member is **unpadded**, living in $\mathcal W_{2m}$ | **no** | required for the equivariance route to criticality | **fails on padded members**: [target.md](../findings/target.md):455 records $\dim\mathrm{Weyl}^{\mathfrak k(W)}=2$ at padded $\mathbb{CP}^2$ and $3$ at padded $\mathbb{CP}^3$, so the one-dimensionality that forces criticality is exactly what padding destroys |
| H6 | "the threshold" $=\sqrt{3/2}$ | **no** | the whole conclusion is about it | [conventions.md](../findings/conventions.md) carries three distinct constants and this is none of their names |
| H7 | "the $\mathbb{CP}^m$ family" is **one** family | assumed | the closed form is asserted of it | **open on the record.** [graded-half.md](../findings/graded-half.md):82: $\mathbb{CP}^m$ has real dimension $2m$ while $(\mathfrak{so}(2m),\mathfrak u(m))$ has $\dim\mathfrak m=m(m-1)$, equal only at $m=3$, *"whether the two coincide is open"*. The block's table rows are the second object; its closed form is derived for the first |

### 1b. Hypotheses of every result the block imports

| imported | its hypotheses | met by L10's object? |
|---|---|---|
| **Fox Lemma 10.1 and (10.4)** ([fox-1901.04012.txt](https://arxiv.org/abs/1901.04012):2027–2048, **read at source**) | $\dim V=n>2$; $r$ even with $2\le r\le n$; $\alpha\in\mathrm{OC}(W,h)$; **"nontrivial and linearly independent when $r\ge4$, while, when $r=2$, $S^2(\alpha)$ is trivial"** | met for $r=2m\ge4$. **Violated at $r=2$**, which both [algebra.md](../findings/algebra.md):29 and [target.md](../findings/target.md):466 claim the derivation covers |
| **[L38](../results.md):503** (cited by [results.md](../results.md):381 for the monotonicity) | $m\ge2$, stated there | met, and L38 states the range L10 omits |
| **[algebra.md](../findings/algebra.md):29** (the only derivation of C2) | Fox's, plus the $\lvert W\rvert^2=4\lVert W\rVert_F^2$ conversion, which the sentence does not perform (§7) | met once the conversion is supplied |
| **[target.md](../findings/target.md):460**, $\dim\mathrm{Weyl}_{2m}^{U(m)}=1$, the step that actually forces criticality | the block itself says **"Measured as the nullity"**, at $m=2,3,4$ only, and for $\mathfrak u(m)$ only | **not met as a general statement.** It is a measurement at three values of $m$, covering neither general $m$ nor the Wolf or Grassmannian classes |
| **[Petersen–Stanfield](../references/petersen-stanfield-2025-poincare-polynomials/) Prop 2.2** (forces the centre off-slice) | symmetric space, $\mathfrak k$ splitting | met; notes read in [references/](../references/) |

### 1c. Which hypotheses the written argument uses

The written argument uses **H2 and H3 only**, and uses them for a conclusion they do not reach (§5). It uses none of H4, H5, H6, H7, each of which is required for a clause the block asserts. **H1 is used as though it were defined.**

## 2. Pre-registered question 1, every value evaluated by hand

### 2a. The closed form at $m=2$, and at every value the record uses

$$\theta^2(m)=\frac{(m+1)(2m-1)}{3m(m-1)}.$$

| $m$ | numerator | denominator | $\theta^2$ |
|---|---|---|---|
| $1$ | $2\cdot1=2$ | $3\cdot1\cdot0=0$ | **undefined** |
| $2$ | $3\cdot3=9$ | $3\cdot2\cdot1=6$ | $9/6=\mathbf{3/2}$ |
| $3$ | $4\cdot5=20$ | $3\cdot3\cdot2=18$ | $20/18=10/9$ |
| $4$ | $5\cdot7=35$ | $3\cdot4\cdot3=36$ | $35/36$ |
| $5$ | $6\cdot9=54$ | $3\cdot5\cdot4=60$ | $54/60=9/10$ |
| $6$ | $7\cdot11=77$ | $3\cdot6\cdot5=90$ | $77/90$ |
| $7$ | $8\cdot13=104$ | $3\cdot7\cdot6=126$ | $104/126=52/63$ |
| $8$ | $9\cdot15=135$ | $3\cdot8\cdot7=168$ | $135/168=45/56$ |

Rows $m=4,\dots,7$ reproduce the four table entries at [graded-half.md](../findings/graded-half.md):77 exactly; $m=8$ reproduces the $n=16$ cross-check at [graded-half.md](../findings/graded-half.md):450; and the whole row of six reproduces [algebra.md](../findings/algebra.md):29's $3/2,\,10/9,\,35/36,\,9/10,\,77/90,\,52/63$ at $r=4,\dots,14$. **C2 and C3 confirmed.**

### 2b. What the heading and the canonical form claim, set against $9/6$

$\theta^2=3/2$ means $\theta=\sqrt{3/2}$, which **is** the threshold. The $m=2$ member sits **at** it, not below it.

- **The heading**, carried verbatim in three files, [graded-half.md](../findings/graded-half.md):468, [results.md](../results.md):128 and [results.md](../results.md):379, says *"all below the threshold"*. **That is false**, and false at the single member of the family that decides everything.
- **The canonical body** at [results.md](../results.md):381 says *"exactly $\tfrac32$ at $m=2$ … every **other** family's point sits below the threshold"*. The word *other* repairs it, **but the repair sits in the sentence beneath the false heading, and the heading is what the index, the summary bullet and every citation carry.** This is the record's named trap, executed exactly.

The record has already noticed, twice, and both times **beside** the statement rather than in it:

- [graded-half.md](../findings/graded-half.md):84 (*"its peak is $\tfrac32$ exactly, at $m=2$) so these four sit far below $\sqrt{3/2}=1.224745$ **while the family attains it**"*. That is 384 lines above the lemma block, in the same file, and the lemma block was not changed.
- [LEDGER.md](../findings/LEDGER.md):1021, *"L10 states that the reducible-isotropy families sit below the threshold, which is a different claim, and $m=2$ sits **at** $\sqrt{3/2}$ rather than below it."* The ledger used this to **reject an L10 citation**, and still did not amend L10.

**Answer to question 1: no.** Not every point of the family is below the threshold. Exactly one point of it (the $m=2$ member, which is the rival maximizer), is **on** the threshold, and the heading in all three files says otherwise.

### 2c. The limit, the monotonicity, and "far below"

**The limit.** Split off the constant exactly:
$$\theta^2-\frac23=\frac{3(m+1)(2m-1)-2\cdot3m(m-1)}{3\cdot3m(m-1)}=\frac{(6m^2+3m-3)-(6m^2-6m)}{9m(m-1)}=\frac{9m-3}{9m(m-1)}=\frac{3m-1}{3m(m-1)}.$$
This is **strictly positive for every $m\ge2$** and tends to $0$. So $\theta^2\to2/3$ from above and **$2/3$ is an infimum that is never attained**, "decreasing monotonically to $2/3$" is correct read as a limit. (This is also [graded-half.md](../findings/graded-half.md):84's split $\tfrac23+\frac{3m-1}{3m(m-1)}$, confirmed.) **C4 confirmed.**

**The monotonicity.** With $N=2m^2+m-1$ and $D=3m^2-3m$:
$$N'D-ND'=(4m+1)(3m^2-3m)-(2m^2+m-1)(6m-3)=(12m^3-9m^2-3m)-(12m^3-9m+3)=-9m^2+6m-3.$$
So the derivative's numerator is $-3(3m^2-2m+1)$, whose quadratic has discriminant $4-12=-8<0$ and positive leading coefficient, hence is **positive for every real $m$**. The derivative is therefore **strictly negative on $m>1$**: strictly decreasing, with no exception in range. **C4 confirmed.**

**"All sit far below $\sqrt{3/2}$."** $\sqrt{3/2}=1.2247448\ldots$ Taking the four decimals at face value and squaring by hand:

| point | $\theta$ | $\theta^2$ | gap to $\sqrt{3/2}$ | fraction of the threshold |
|---|---|---|---|---|
| $\mathbb{HP}^2$ | $1.115547$ | $56/45=1.2\overline{4}$ | $0.10920$ | $\mathbf{91.1\%}$ |
| $\mathbb{HP}^3$ | $0.852944$ | $275/378=0.727513$ | $0.37180$ | $69.6\%$ |
| $\mathrm{Gr}_{\mathbb C}(2,2)$ | $0.720082$ | $0.5185185$ | $0.50466$ | $58.8\%$ |
| $\mathrm{Gr}_{\mathbb C}(2,3)$ | $0.596068$ | $0.3552972$ | $0.62868$ | $48.7\%$ |

The two Wolf squares are exact against a closed form the record holds: [INDEX-values.md](../findings/INDEX-values.md):51 gives $\theta^2(\mathbb{HP}^m)=\frac{(m+2)^2(4m-1)}{9m(m-1)(2m+1)}$, and by hand $m=2\mapsto\frac{16\cdot7}{9\cdot2\cdot1\cdot5}=\frac{112}{90}=\frac{56}{45}$ and $m=3\mapsto\frac{25\cdot11}{9\cdot3\cdot2\cdot7}=\frac{275}{378}$. Since $56/45<3/2=67.5/45$ and the form is decreasing, **the whole Wolf family is below the threshold in closed form**, a stronger statement than L10 makes, held in a different file, and uncited by L10. The two Grassmannian squares match no closed form on the record; $0.720082^2=0.5185185$ agrees with $14/27$ to seven places, which I record as an observation and **not** as a value, since no derivation of it exists anywhere. **C5 split accordingly.**

## 3. Pre-registered question 2, how many critical points a one-dimensional family carries

**Count.** Let $L\subset\mathcal W_n$ be a one-dimensional subspace. $L\cap\{\lVert\cdot\rVert=1\}=\{W,-W\}$: **exactly two points**, for every one-dimensional $L$, with no exception.

**Both are critical whenever either is.** $W^\#$ is quadratic in $W$, so $(-W)^\#=W^\#$. If $W$ is critical with $W^\#=\tfrac13\theta W$, then
$$(-W)^\#=W^\#=\tfrac13\theta W=\tfrac13(-\theta)(-W),$$
so $-W$ is critical with multiplier $-\theta$. And $P$ is a cubic, so $P(-W)=-P(W)$. **The family carries two critical points, at values $+\theta$ and $-\theta$.** This is the same evenness/oddness the record already holds at [L108](../lean/INDEX.md):154 (*"$\theta$ is odd in $W$"*) and at [L124](../lean/INDEX.md):171, *"equality at $\pm W_{\mathbb{CP}^2}$ is closed under negation"*.

**Which of them the stated value belongs to.** $\theta^2$ is even, so both members of $\{W,-W\}$ have $\theta^2=3/2$ at $m=2$. The stated value $+\sqrt{3/2}$ belongs to **one** of the two, the one with $P>0$; the other carries $-\sqrt{3/2}$.

**Answer to question 2.** *"There is exactly one per family"* ([results.md](../results.md):381) is **false as a count of critical points** and undercounts by exactly a factor of two. The available charitable reading (the record works with $\lvert\theta\rvert$, or identifies the line's two unit vectors), is genuine and is surely what was meant; **but nothing in the block says so**, and a consumer counting critical points from this sentence counts wrong. The clause is neither proved nor a restatement of one-dimensionality: it is one-dimensionality **miscounted**, and separately it does not follow from one-dimensionality at all (§5). **C7 broken.**

*(This also matters for the census the block routes these points into: a critical-point census that inherits "one per family" undercounts the reducible-isotropy contribution by half.)*

## 4. Pre-registered question 3, is the dimension count on file?

**It is not.** I read every text the record offers for it.

### 4a. The only two texts that assert it

Both are the same sentence, once in a finding and once in the review it came from:

> [graded-half.md](../findings/graded-half.md):442, *"Ricci-flatness imposes **two** linear conditions on the **three-parameter** family, and adding the first Bianchi identity, which neither P2b script checked, cuts every family down to a **one-dimensional** space of Weyl operators."*

> [REVIEW_r15.md](../reviews/REVIEW_r15.md):5 (*"Ricci-flatness is two linear conditions, and the first Bianchi identity), checked by neither P2b script, cuts each family to a single Weyl operator."*

Neither carries a derivation. Both are assertions of a count.

### 4b. The assertion's own arithmetic does not close

$3-2=1$. If Ricci-flatness alone cuts a three-parameter family to one dimension, then a first Bianchi identity that *"cuts every family down"* further leaves **zero** dimensions and no critical point at all. As stated, the sentence's two clauses cannot both be doing work.

**The arithmetic closes only on an ambient the same review corrects three sentences later:**

> [REVIEW_r15.md](../reviews/REVIEW_r15.md):5, *"the space of $SO(4)\times SO(8)$-invariant symmetric operators on $\Lambda^2(\mathbb R^{12})$ has dimension **4, not 3**, $\Lambda^\pm$ splits, and the correct invariance group is $O(k)\times O(l)$, but enlarging the family leaves the same single Weyl operator, since Bianchi kills the extra direction."*

With $4$: $4-2-1=1$, consistent. **So the count is arithmetically coherent only under a correction that never reached the lemma**, whose block still says *"three-parameter"* at line 442 and whose statement says *"one-parameter-per-factor"* at line 472. The correction landed beside the statement, the trap again.

### 4c. The count is stated for the wrong class

The corrected count is for $\mathfrak{so}(k)\oplus\mathfrak{so}(l)\subset\mathfrak{so}(12)$ at $(k,l)=(4,8)$, a **real Grassmannian** split, whose critical Weyl operator is a **sphere product** ([REVIEW_r15.md](../reviews/REVIEW_r15.md), Correction 1). It is not a count for $\mathfrak u(m)$, for $\mathfrak{sp}(1)\oplus\mathfrak{sp}(m)$, or for the complex-Grassmannian isotropies, **the three classes L10 is about** ([graded-half.md](../findings/graded-half.md):88, :101). **No dimension count is on file for any of the three classes the lemma covers.** Nor is one stated for general $r$: the record's own ansatz is $(r+1)$-parameter ([graded-half.md](../findings/graded-half.md):23, :37, :73), so "three-parameter" is the $r=2$ case alone and the Wolf and Grassmannian classes are not it.

### 4d. What the record does have, in a different file, by a different route

[target.md](../findings/target.md):460 carries a genuine argument, and L10 cites it nowhere:

> *"$\dim\mathrm{Weyl}_{2m}^{U(m)}=1$ … **Measured** as the nullity of $W\mapsto[\mathrm{ad}(X),W]$ … **$1$ of $10$, $1$ of $84$, $1$ of $300$** at $m=2,3,4$. So $\mathbb{CP}^m$ is the *unique* $U(m)$-invariant Weyl tensor up to scale, and criticality then follows **with no computation**, $Q$ is $O(n)$-equivariant, so $Q(W)$ is again $U(m)$-invariant, hence a multiple of $W$."*

Three things follow. **First**, this is the correct route and it is nothing like L10's: no Ricci-flatness, no Bianchi, no parameter counting, the work is done by **equivariance**, a word absent from L10. **Second**, its one-dimensionality is *measured at $m=2,3,4$*, so even this route covers three values of $m$ rather than the family. **Third**, it is stated for $\mathfrak u(m)$ only.

**Answer to question 3.** **The dimension count has no argument on file.** What exists is (i) an assertion whose arithmetic is inconsistent with its own conclusion, corrected only in a review paragraph that never reached the lemma, and stated for a family class L10 does not cover; and (ii) a sound but different argument, for one of L10's three classes, resting on a measurement at three values of $m$, which L10 does not cite. **C9: HYPOTHESIS-DEBT.** *What would have to be shown*: for each of $\mathfrak u(m)$, $\mathfrak{sp}(1)\oplus\mathfrak{sp}(m)$ and the complex-Grassmannian isotropies, that the $(r+1)$-parameter invariant family meets $\mathcal W_n$ in a line, for all $m$, not at sampled $m$.

## 5. "Forced rather than found", the inference, checked

**The written inference.** *one-dimensional space of Weyl operators* $\Longrightarrow$ *the critical point in each is forced rather than found*.

**It does not hold.** Criticality is $Q(W)\in\mathbb R W$ as an equation **in the whole of $\mathcal W_n$**, of dimension $10$, $84$, $300$ at $n=4,6,8$, per [target.md](../findings/target.md):460's own denominators. One-dimensionality of a subspace $L$ is a statement about $L$; it constrains $Q(W)$ for $W\in L$ not at all, since $Q(W)$ need not lie in $L$. A generic line in a $300$-dimensional sphere contains no critical point whatever, so the premise cannot deliver the conclusion by itself.

**The record supplies the counterexample to the inference in the same paragraph.** [graded-half.md](../findings/graded-half.md):442: *"A circle scan does find further stationary points, and **every one of them violates Bianchi**."* Those points lie in the enlarged ambient family and are not Weyl operators, that is, the family's ambient carries directions along which criticality fails, which is precisely the situation one-dimensionality was supposed to make impossible. The premise is being asked to do work that the ambient's structure, not its dimension, does.

**What is actually missing** is the equivariance step of §4d: $Q$ is $O(n)$-equivariant, so $Q$ maps the $K$-invariant subspace to itself, and a one-dimensional invariant subspace is therefore $Q$-invariant, whence $Q(W)\in\mathbb RW$. **That is the theorem.** It needs the family to be the *invariant* subspace of a group (which the Ricci/Bianchi framing never says) and it is stated at [target.md](../findings/target.md):460 for $\mathfrak u(m)$ alone.

I record what I have **not** done: I have not extended that argument to the Wolf or Grassmannian classes, and this report does not supply it. **C8: HYPOTHESIS-DEBT.** *What would have to be shown*: that each family is the fixed subspace of its isotropy group acting on $\mathcal W_n$, and that this subspace is one-dimensional.

## 6. The discrepancy dossier

Each candidate gets the three-step record. A candidate failing any step is marked `withdrawn`.

### D1, the heading is false at $m=2$ · **CONFIRMED**

1. **Located.** [graded-half.md](../findings/graded-half.md):468, [results.md](../results.md):128, [results.md](../results.md):379, identically: *"The reducible-isotropy families carry one critical point each, **all below the threshold**."*
2. **Exhibited.** At the named object $W_{\mathbb{CP}^2}$, the $m=2$ member: $\theta^2=\frac{3\cdot3}{3\cdot2\cdot1}=\frac96=\frac32$, so $\theta=\sqrt{3/2}$, which is the threshold. Not below it.
3. **Opposite argued.** The most charitable reading is that *"the threshold"* names something strictly greater than $\sqrt{3/2}$, $\theta_0(n)$ at $n\ge12$, say, where $\theta_0(12)^2=55/36>3/2$. **That reading fails on the block's own text**, whose next sentences name $\sqrt{3/2}$ explicitly and call the $m=2$ member *"the rival maximizer"*. A second charitable reading (*"the families"* excludes the $\mathbb{CP}^m$ family), fails because the block's own body is about that family. **CONFIRMED.**

### D2, "far below" is contradicted by the same file · **CONFIRMED**

1. **Located.** [graded-half.md](../findings/graded-half.md):476: *"The Wolf spaces give $1.115547$ and $0.852944$… **All sit far below $\sqrt{3/2}$**."*
2. **Exhibited.** At $\mathbb{HP}^2$: $\sqrt{3/2}-1.115547=0.10920$, and $1.115547/1.2247449=0.9108$, **$91.1\%$ of the threshold**. The same file, at [graded-half.md](../findings/graded-half.md):454, reads that identical figure the other way: *"cutting the gap to $\sqrt{3/2}$ from $0.324$ to $0.109$ and turning the ungraded half from **a loose problem into a tight one**."* One number, described as *far below* on line 476 and as *tight* on line 454.
3. **Opposite argued.** The sentence's antecedent may be only the four decimals, three of which ($0.853$, $0.720$, $0.596$, at $70\%$, $59\%$, $49\%$) genuinely are far below. **That reading is available and saves three of the four**; it does not save $\mathbb{HP}^2$, which is the largest and the one the sentence's *"All"* has to cover. **CONFIRMED**, as to the first value.

### D3, the count is two, not one · **CONFIRMED**

1. **Located.** [results.md](../results.md):381: *"the critical point in each family is forced rather than found, and **there is exactly one per family**."*
2. **Exhibited.** §3: a one-dimensional $L$ meets the unit sphere in $\{W,-W\}$; $(-W)^\#=W^\#$ makes $-W$ critical with multiplier $-\theta$; $P(-W)=-P(W)$. Two critical points, at $\pm\theta$.
3. **Opposite argued.** The record may count unsigned points, or count $\lvert\theta\rvert$, [L108](../lean/INDEX.md) and [L124](../lean/INDEX.md) both work with the $\pm$ pair explicitly, so the convention exists. **The reading is charitable and available; the block states it nowhere**, and a census built on the sentence undercounts by half. **CONFIRMED** as a defect of statement.

### D4, "forced rather than found" is a non sequitur · **CONFIRMED**

1. **Located.** [graded-half.md](../findings/graded-half.md):472 / [results.md](../results.md):381: *"cuts each … family down to a one-dimensional space of Weyl operators, **so** the critical point in each is forced rather than found."*
2. **Exhibited.** §5: at $n=8$, $\dim\mathcal W_8=300$; one-dimensionality of $L$ says nothing about whether $Q(L)\subseteq L$. The block's own *"circle scan finds further stationary points, every one violating Bianchi"* shows the ambient carries non-critical directions.
3. **Opposite argued.** The intended reading is surely equivariance, *invariant* line, hence $Q$-invariant. **That is a correct and different argument**, on file at [target.md](../findings/target.md):460, for $\mathfrak u(m)$ only, resting on a nullity **measured** at $m=2,3,4$. Charitably read, L10 is gesturing at it; as written it names neither the group nor the equivariance. **CONFIRMED as unsupported-as-written.**

### D5, the dimension count has no derivation and inconsistent arithmetic · **CONFIRMED**

1. **Located.** [graded-half.md](../findings/graded-half.md):442: *"Ricci-flatness imposes two linear conditions on the three-parameter family, and adding the first Bianchi identity … cuts every family down to a one-dimensional space."*
2. **Exhibited.** $3-2=1$; a further cut leaves $0$. The count closes only at ambient dimension $4$, which [REVIEW_r15.md](../reviews/REVIEW_r15.md):5 supplies three sentences later (*"dimension 4, not 3"*) and which never reached line 442 or the lemma at line 472.
3. **Opposite argued.** *"Cuts down to"* might mean *"cuts down to, jointly"*, i.e. the two conditions together are the cut and Bianchi is one of the two. **That reading contradicts the sentence's own arithmetic** ("Ricci-flatness imposes *two*… and *adding* Bianchi") and contradicts the corrected ambient, under which three conditions act on four parameters. **CONFIRMED.**

### D6, the conclusion is false on a class the phrase admits · **CONFIRMED**

1. **Located.** [results.md](../results.md):381: *"cuts **each one-parameter-per-factor reducible-isotropy family** … every other family's point sits below the threshold."*
2. **Exhibited at a named object.** $\mathfrak{so}(6)\oplus\mathfrak{so}(6)\subset\mathfrak{so}(12)$ is a symmetric pair with a two-ideal isotropy, one parameter per factor, exactly the class the sentence names, and exactly the class the dimension count at line 442 is stated for. Its critical Weyl operator is the balanced sphere product at $n=12$, whose value the same review records: [graded-half.md](../findings/graded-half.md):466 lists *"$\theta^2=176/135,\ 231/160,\ 264/175,\ \mathbf{55/36}$"* for the $n=12$ splits $3{+}9$ through $6{+}6$. By hand, $\frac{55}{36}-\frac32=\frac{55-54}{36}=\frac1{36}>0$: **above the threshold, by exactly $1/36$ in $\theta^2$.** The same number is $\theta_0(12)^2=\frac{2\cdot11\cdot10}{144}=\frac{220}{144}=\frac{55}{36}$.
3. **Opposite argued.** *"Reducible-isotropy families"* is a term of art in [graded-half.md](../findings/graded-half.md), used at :89 and :101 for exactly three classes (Hermitian, Wolf, complex Grassmannian) which excludes $\mathfrak{so}(k)\oplus\mathfrak{so}(l)$. **That reading is correct and is certainly intended.** It rescues the conclusion and destroys the mechanism: under it, the *only* dimension count on the record is stated for a class the lemma explicitly does not reach, so the mechanism clause has no support even by assertion. **CONFIRMED**, the block's two clauses quantify over classes that cannot both be the intended one.

### D7, "covers every even $r$ from $r=2$" is refuted by the source · **CONFIRMED**

1. **Located.** [algebra.md](../findings/algebra.md):29, *"for every even $r$ with $2\le r\le n$"*; [target.md](../findings/target.md):466, *"whose Fox derivation covers every even $r=2m$ **from $r=2$**"*.
2. **Exhibited against the source, read in [references/](../references/).** [fox-1901.04012.txt](https://arxiv.org/abs/1901.04012):2033–2035, Lemma 10.1: the idempotents *"are … nontrivial and linearly independent when $r\ge4$, **while, when $r=2$, $S^2(\alpha)$ is trivial** and $K^2(\alpha)=H(g)$."* And (10.4) at line 2043 gives $\lvert S^r\rvert^2=\frac{6r(r-2)}{(r+2)(r-1)}$, which at $r=2$ is $\frac{6\cdot2\cdot0}{4\cdot1}=0$, the zero operator, confirming triviality by hand. Correspondingly $\theta^2(m=1)$ has denominator $3\cdot1\cdot0=0$.
3. **Opposite argued.** Fox's *range* of $r$ is indeed $2\le r\le n$, so a reading that quotes the range faithfully while the conclusion is asserted only where the object is nontrivial is defensible. **But [target.md](../findings/target.md):466 uses the phrase precisely to justify evaluating the closed form at $m=2$ against a competing citation stated from $m\ge3$**, that is, the *"from $r=2$"* is load-bearing at the point of use, and the source excludes $r=2$. **CONFIRMED.** *(The consequence is narrow: $m=2$ is $r=4$, which Fox covers. It is $m=1$ that the phrase wrongly admits.)*

### D8, the Fox conversion drops a factor of $4$ · **CONFIRMED as a presentation gap, not as an error**

1. **Located.** [algebra.md](../findings/algebra.md):29: *"(10.4) gives $\lvert S^r\rvert^2=6r(r-2)/((r+2)(r-1))$ in his metric. **Since $\theta=1/\lvert S^r\rvert$ in the Frobenius normalisation**, $\theta(S^r)^2=\frac{2(r+2)(r-1)}{3r(r-2)}$."*
2. **Exhibited.** Applying the quoted relation literally at $r=4$: $\lvert S^4\rvert^2=\frac{6\cdot4\cdot2}{6\cdot3}=\frac{48}{18}=\frac83$, so $1/\lvert S^4\rvert^2=\frac38$. The displayed formula gives $\frac{2\cdot6\cdot3}{3\cdot4\cdot2}=\frac{36}{24}=\frac32$. **$\frac32=4\cdot\frac38$**, a factor of $4$ in $\theta^2$, at exactly the member that sets the threshold. A consumer following the sentence gets $\theta=\sqrt{3/8}$ at $W_{\mathbb{CP}^2}$.
3. **Opposite argued.** [conventions.md](../findings/conventions.md):63 records $\lvert W\rvert^2=4\lVert W\rVert_F^2$ as the relation between the two $\Lambda^2$ normalisations in use. Under it, $\theta=2/\lvert S^r\rvert_h$ and the displayed formula is right. **The charitable reading holds and the mathematics is sound**; the sentence performs the conversion silently while asserting the unconverted relation. **CONFIRMED as a defect of statement**, and the displayed closed form stands, and with it C2, now verified against the source rather than against the record.

### D9, "Gate 2 passed" is contradicted by both cited reviewers · **CONFIRMED**

1. **Located.** [INDEX-results.md](../findings/INDEX-results.md):25: *"**Gate 2 passed** ([r461](../reviews/REVIEW_r461.md), [r462](../reviews/REVIEW_r462.md)), numbers confirmed with two hypothesis caveats."*
2. **Exhibited.** [REVIEW_r461.md](../reviews/REVIEW_r461.md):1–3 heads itself *"PARTIAL, SALVAGED FROM THE LOG … it is evidence at the weight of one reviewer's working notes, not a filed report, and **Gate 2 on these claims is not complete**."* [REVIEW_r462.md](../reviews/REVIEW_r462.md):3 adds *"Its twin r461 was stopped before filing, so **no claim here has two independent verdicts**."* Neither verdict is a pass: r461 gives *"CONFIRMED (numbers), with 2 hypothesis caveats"*, r462 gives *"**PLAUSIBLE-with-defect**"*. **Both flagged D1 independently**, r461's *"Title overstates"*, r462's *"the TITLE says 'all below the threshold' but m=2 sits EXACTLY AT the threshold"*.
3. **Opposite argued.** [LEDGER.md](../findings/LEDGER.md):197–207 does carry the warning, *"NEITHER REVIEWER FILED A REPORT; BOTH WERE SALVAGED FROM THEIR LOGS."* So the record holds the caveat somewhere. **It is not in the index row a consumer reads**, which says *passed* without qualification. **CONFIRMED**, a third instance of the same trap, the correction beside the claim.

### D10, "reducible isotropy" names the wrong thing · **CONFIRMED, low impact**

$\mathfrak u(m)\subset\mathfrak{so}(2m)$ acts on $\mathbb R^{2m}=\mathbb C^m$ as its standard representation, which is **irreducible over $\mathbb R$**. What is reducible is the *algebra*, into $\mathbb R\oplus\mathfrak{su}(m)$, which is why the honest ansatz is $(r+1)$-parameter. So the class name describes the decomposition of the isotropy algebra into ideals, not any reducibility of its action. Independently raised by [r462](../reviews/REVIEW_r462.md). *Charitable reading*: "reducible" modifies the algebra, which the $(r+1)$-parameter framing makes clear in context. **CONFIRMED as naming, and it is the ambiguity D6 turns on.**

### Withdrawn

- **"decreasing monotonically to $2/3$"**, `withdrawn`. $2/3$ is an infimum and not attained (§2c), but "decreasing to" is standard for a limit, and the record's split at [graded-half.md](../findings/graded-half.md):84 makes the strict positivity explicit. No failure.
- **"the rival maximizer is the first member of this family"**, `withdrawn`. That the $m=2$ member is $W_{\mathbb{CP}^2}$ is separately supported: [target.md](../findings/target.md):401, and [L38](../findings/INDEX-results.md):53's Gate 2, *"that member is now **proved** to be $W_{\mathbb{CP}^2}$"*. Step 2 fails, no concrete failure exists.
- **"$\theta^2=45/56$ at $m=8$"**, `withdrawn`. $\frac{9\cdot15}{3\cdot8\cdot7}=\frac{135}{168}=\frac{45}{56}$ exactly. Correct.

## 7. Quantifier order, scope, and the edges of the range

| edge | what the block admits | what holds |
|---|---|---|
| **$m=1$** | nothing excludes it, no range is stated in any of the three files carrying L10 | $\theta^2$ is $2/0$, undefined; and Fox's $S^2(\alpha)$ is the **trivial** idempotent (D7). Doubly inadmissible, and the block is silent |
| **smallest admissible $m$** | unstated | $m=2$, which is $r=4$, which is where Fox's *"nontrivial and linearly independent when $r\ge4$"* begins. [L38](../results.md):503 states $m\ge2$; **L10 does not** |
| **the family's largest value** | the heading says all are below $\sqrt{3/2}$ | the supremum **is** $3/2$ and is **attained**, at $m=2$ (D1) |
| **"one-parameter-per-factor"** | any symmetric pair whose isotropy algebra has $\ge2$ ideals, including $\mathfrak{so}(k)\oplus\mathfrak{so}(l)$ | on which the conclusion is false at $(6,6)$, $n=12$, $\theta^2=55/36$ (D6) |
| **"$r$ factors"** | the phrase suggests $r$ parameters | the record's ansatz is $(r+1)$-parameter throughout ([graded-half.md](../findings/graded-half.md):23, :37, :73). The phrase undercounts by one, which is the $\mathfrak m$-block parameter |
| **padded members** | unstated | the equivariance route fails on them: $\dim\mathrm{Weyl}^{\mathfrak k(W)}$ is $2$ at padded $\mathbb{CP}^2$, $3$ at padded $\mathbb{CP}^3$ ([target.md](../findings/target.md):455) |

**Quantifier order.** The two clauses quantify differently and the block reads as though they did not:

- *"cuts **each** … family down to a one-dimensional space"*, universal over families, supported for **none** of the three classes (§4).
- *"**every other** family's point sits below the threshold"*, universal over families, supported at **two members each** for Wolf and for the complex Grassmannians. [r461](../reviews/REVIEW_r461.md) flagged exactly this, *"'the families' are verified at TWO members each for Wolf and Gr_C. Quantifier gap … Gr_C family open"*, and closed the Wolf half itself with the closed form now sitting at [INDEX-values.md](../findings/INDEX-values.md):51. **The complex-Grassmannian half remains a universal claim standing on two members.**
- *"the value is exact in closed form"* for $\mathbb{CP}^m$, universal in $m\ge2$, and this one **is** supported, by Fox, for every even $r\ge4$.

## 8. Comparing the forms

| where | what it says | correct? |
|---|---|---|
| [graded-half.md](../findings/graded-half.md):468 (heading) | "all below the threshold" | **no** (D1) |
| [graded-half.md](../findings/graded-half.md):472–476 (body) | closed form, $3/2$ at $m=2$, four decimals, "All sit far below $\sqrt{3/2}$" | closed form yes; "far below" **no** (D2). **The body never says the $m=2$ member reaches the threshold**, it says "equal to exactly $3/2$", leaving the reader to notice that $3/2$ *is* $(\sqrt{3/2})^2$ |
| [graded-half.md](../findings/graded-half.md):84 (384 lines above) | "its peak is $\tfrac32$ exactly, at $m=2$ … these four sit far below $\sqrt{3/2}$ **while the family attains it**" | **yes**, the correct statement, in the same file, uncited by the lemma |
| [results.md](../results.md):128 (summary bullet) | heading false, body correct ("every **other** family's point") | **split within one bullet** |
| [results.md](../results.md):379 (heading) / :381 (canonical) | heading false; body correct on $\mathbb{CP}^m$, adds the scope guard *"reaches the reducible-isotropy families and no other critical point"*, adds "exactly one per family" (**false**, D3) | **split**, and the canonical form is the only place D3 appears |
| [results.md](../results.md):503, **[L38](../results.md), the same fact** | *"Both are strictly decreasing in $m$ with maximum $\tfrac32$ at $m=2$ … so **neither family exceeds $\sqrt{3/2}$ anywhere**"* | **yes.** *Does not exceed* is the true statement. L38 gets right what L10 gets wrong, about the same family, in the same file. [ungraded-slack.md](../findings/ungraded-slack.md):258 flags the pair as a duplicate: *"THE $\mathbb{CP}^m$ HALF DUPLICATES LEMMA L10, same formula, two numbers, neither block citing the other"* |
| [LEDGER.md](../findings/LEDGER.md):1021 | *"$m=2$ sits **at** $\sqrt{3/2}$ rather than below it"*, used to **reject an L10 citation** | **yes**, and L10 was not amended |

**The Lean row exists.** [lean/INDEX.md](../lean/INDEX.md):260 carries [L10.lean](../lean/HamiltonsCubic/Results/L10.lean), marked **partial**:

> *"the `ℂPᵐ` family is **strictly** below `3/2` from `m = 3` on, with `m = 2` the sole member attaining it … The rest of L10, *every other family below threshold*, needs those families' values, which are not on the record in closed form"*

The file itself proves `cpSq_lt_threshold : 3 ≤ m → cpSq m < 3/2` and `cpSq_two_attains : cpSq 2 = 3/2`. **So the machine-checked form is the correct one** (*attained at $m=2$, strict from $m=3$*) and it is the fourth place the correction sits beside the uncorrected statement. It also records that "every other family below threshold" is **not formalised** because the values do not exist in closed form, which is D6/§7's quantifier gap restated by the Lean loop.

**What the Lean row would have to claim** for the whole of L10: (i) `cpSq_two_attains` and `cpSq_lt_threshold` as they stand; (ii) the Wolf closed form of [INDEX-values.md](../findings/INDEX-values.md):51 with $\sup_m\theta^2=56/45<3/2$; (iii) a closed form for the complex-Grassmannian family, **which does not exist on the record**; (iv) the one-dimensionality of each family, which is §4's debt. Rows (iii) and (iv) are why the row is `partial`, and correctly so.

## 9. The gap between what is proven and what is used, and what a consumer may cite

### Proven

- $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$ on the $\mathbb{CP}^m$ family for every $m\ge2$, **derived** at [algebra.md](../findings/algebra.md):29 from Fox Lemma 10.1 and (10.4), which I read at source. Strictly decreasing on $m>1$, supremum $3/2$ **attained at $m=2$**, infimum $2/3$ **not attained**.
- $\theta^2(\mathbb{HP}^m)=\frac{(m+2)^2(4m-1)}{9m(m-1)(2m+1)}$ ([INDEX-values.md](../findings/INDEX-values.md):51), giving $56/45$ and $275/378$ at $m=2,3$ and $\sup=56/45<3/2$: **the Wolf family is uniformly below the threshold, in closed form.** This is *stronger* than L10's clause and lives in a different file, and [graded-half.md](../findings/graded-half.md):57 states it outright, $\sup_m\theta(\mathbb{HP}^m)=\sqrt{56/45}<\sqrt{3/2}$, in the same file and well above L10's own supporting table at line 96.

### Used but not proven

- **one-dimensionality** of any of the three families (§4);
- **criticality** as a consequence of it (§5), the working argument covers $\mathfrak u(m)$ only, from a nullity measured at $m=2,3,4$;
- **"below the threshold" for the complex-Grassmannian family**, two members, no closed form, no argument;
- **"exactly one per family"**, false as a count (§3).

### What a consumer may cite from L10, and in what words

**May cite:** *"On the $\mathbb{CP}^m$ family, $m\ge2$, $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$, strictly decreasing, with maximum $\tfrac32$ **attained** at $m=2$, so the family **does not exceed** $\sqrt{3/2}$ anywhere, and **meets** it at $m=2$."* That is [L38](../results.md):503's wording, and it is the correct one.

**May cite** (from [INDEX-values.md](../findings/INDEX-values.md):51, not from L10): the Wolf family's closed form and its uniform bound $\sqrt{56/45}<\sqrt{3/2}$.

**May not cite:** the heading in any of its three copies; *"all below the threshold"*; *"All sit far below $\sqrt{3/2}$"*; *"exactly one per family"*; *"every other family's point sits below the threshold"* as a universal over families; *"Ricci-flatness together with the first Bianchi identity cuts … down to a one-dimensional space"*; *"forced rather than found"*; and the *"Gate 2 passed"* label at [INDEX-results.md](../findings/INDEX-results.md):25.

**A consumer needing "the graded/reducible families stay under $\sqrt{3/2}$"** may have it for $\mathbb{CP}^m$ (with *at*, not *below*, at $m=2$) and for Wolf, and **may not have it for the complex Grassmannians**, where the record holds two data points and no argument.

## 10. The named trap, read as a consumer would

I read each citable claim alone, with nothing else in view. **The record's signature failure is present here four times over, and it is the dominant finding of this round.**

| the claim, standing alone | the correction, and where it landed instead |
|---|---|
| *"The reducible-isotropy families carry one critical point each, all below the threshold"*, [graded-half.md](../findings/graded-half.md):468, [results.md](../results.md):128, [results.md](../results.md):379 | *"while the family attains it"*, [graded-half.md](../findings/graded-half.md):84, **384 lines above, same file** |
| the same heading | *"$m=2$ sits **at** $\sqrt{3/2}$ rather than below it"*, [LEDGER.md](../findings/LEDGER.md):1021, where it was used to **reject an L10 citation** and still not to fix L10 |
| the same heading | *"`m = 2` the sole member attaining it"*, [lean/INDEX.md](../lean/INDEX.md):260 and [L10.lean](../lean/HamiltonsCubic/Results/L10.lean), machine-checked, **in a different tree** |
| *"Gate 2 passed"*, [INDEX-results.md](../findings/INDEX-results.md):25 | *"NEITHER REVIEWER FILED A REPORT"*, [LEDGER.md](../findings/LEDGER.md):208, and both reviewers' own headers |
| *"Ricci-flatness … cuts … the **three-parameter** family"*, [graded-half.md](../findings/graded-half.md):442 | *"dimension **4, not 3**"*, [REVIEW_r15.md](../reviews/REVIEW_r15.md):5, **three sentences later in the source of that very paragraph** |

**Four independent parts of the record know the heading is false. The heading has been carried unchanged in three files through all of it.** A citation of "Lemma L10" inherits the defect in every case, and the two Gate 2 reviewers who caught it in 2026 were recorded as a **pass**.

## 11. What would break the statement, and what I did to look for it

**The object.** A member of the complex-Grassmannian family $\mathrm{Gr}_{\mathbb C}(p,q)$, at some $(p,q)$ beyond the two on file, whose critical value exceeds $\sqrt{3/2}$. Its existence would falsify *"every other family's point sits below the threshold"* outright, at the one class where that clause is a universal standing on two data points.

**What I did to look for it.** I searched the record for a closed form for the family. [INDEX-values.md](../findings/INDEX-values.md):51 carries closed forms for $\mathbb{HP}^m$, for $\mathbb{CP}^m$ and for $(\mathfrak{su}(m),\mathfrak{so}(m))$, **and for no Grassmannian family**. [graded-half.md](../findings/graded-half.md):88 lists the complex Grassmannians as *"the three-eigenvalue case"*, and :96 tabulates exactly two members, $\mathrm{Gr}_{\mathbb C}(2,2)$ and $\mathrm{Gr}_{\mathbb C}(2,3)$. [REVIEW_r461.md](../reviews/REVIEW_r461.md) closed the Wolf half by deriving its closed form and recorded *"Gr_C family open"*. So the falsifier is **not excluded on the record**, and I did not run anything to look for it, this is an analysis-only round.

**A second object, and this one exists.** The $\mathfrak{so}(6)\oplus\mathfrak{so}(6)\subset\mathfrak{so}(12)$ pair is a one-parameter-per-factor family whose value is $55/36=\tfrac32+\tfrac1{36}$ (**above** the threshold), recorded by the record itself at [graded-half.md](../findings/graded-half.md):466. It falsifies the literal reading of the statement's own quantifier, and it is the class the statement's own mechanism clause is derived for. Its existence is what makes D6 a defect of the statement rather than of the mathematics.

**What I did not do.** I did not derive one-dimensionality for any family, did not extend the equivariance argument beyond $\mathfrak u(m)$, and did not construct a closed form for the complex Grassmannians. Those are the debts, and a verifier who discharged them would be handing the record an unaudited proof under the letterhead of a check.

## Verdict

**BROKEN.**

The mathematics of the $\mathbb{CP}^m$ half is correct and, after this round, source-checked against Fox rather than only against the record. **What is broken is the statement.** Its heading (carried identically in three files and reproduced in the landscape summary), asserts a universal that is false at the one member the block itself calls the rival maximizer. Its count is off by a factor of two. Its advertised mechanism has no derivation anywhere on the record, is arithmetically inconsistent in the one place it is asserted, and is stated for a family class on which the lemma's own conclusion fails at $n=12$. And its Gate 2 label reports a pass that both cited reviewers explicitly declined to give.

**The repair is one word in three places** (*below* to *at or below*, or better, L38's *does not exceed*), plus a scope line naming the three classes, plus the removal of *"exactly one per family"* and of the Ricci/Bianchi mechanism in favour of a citation to [target.md](../findings/target.md):460's equivariance argument with its measured range stated. **None of that is a verifier's to write.**
