# VERIFY v96, Lemma L2: the crossover $6+2\sqrt7$, the integer cutoff $12$ in both directions, and the parity clause

*Cold brief, verifier v96. **No numerical work**: no script was run, nothing was screened, and every value below is an exact hand evaluation of a rational or a surd. Log: [agent_logs/verify-L02-v96.log](../agent_logs/verify-L02-v96.log). Target: the L2 block at [findings/problem.md](../findings/problem.md):160–176, as dispatched in [ROUND_L02.md](ROUND_L02.md); compared against [results.md](../results.md):112 and :302, [L2.lean](../lean/HamiltonsCubic/Results/L2.lean) and its row in [lean/INDEX.md](../lean/INDEX.md):278. The two prior reports named in the block, [r505](../reviews/REVIEW_r505.md) and [r506](../reviews/REVIEW_r506.md), were read in full before any absence was recorded, as were [CP2.lean](../lean/HamiltonsCubic/Base/CP2.lean), [W5.lean](../lean/HamiltonsCubic/Results/W5.lean), [conventions.md](../findings/conventions.md) and [INDEX-results.md](../findings/INDEX-results.md). Nienhaus Proposition 2.25 was read **at source**, in [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404) at line 1483, not from the notes and not from memory.*

## Claim table

| # | claim, as the block states it | verdict |
| --- | --- | --- |
| 1 | $\theta_0(n)^2=\frac{2(n-1)(n-2)}{n^2}$ is the case $p=q=n/2$ of $\theta(S^p\times S^q)^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ | **PROVEN IN THE BLOCK**, I rederived the specialisation; it is one line and it is right |
| 2 | the general sphere-product formula itself | **CORRECT, CITED WITHOUT A CITATION**, it is Nienhaus Proposition 2.25 squared, read at source; the block names no source at all |
| 3 | the competitor has $\theta^2=\tfrac32$ **at $n=4$** | **NO ARGUMENT IN THE BLOCK**, asserted; proved elsewhere on the record ([CP2.lean](../lean/HamiltonsCubic/Base/CP2.lean), [r505](../reviews/REVIEW_r505.md) §1.2, [r506](../reviews/REVIEW_r506.md) §F2) |
| 4 | that value persists to every $n\ge4$, "since $\mathfrak{su}(2)_+$ is a subalgebra and $W^\#$ therefore stays inside $\Lambda^+$ under padding" | **PROOF SKETCH, AND CORRECT**, the one load-bearing step is stated and it is the right one; §3 completes it |
| 5 | $\theta_0(n)^2-\tfrac32=\frac{n^2-12n+8}{2n^2}$ | **PROVEN IN THE BLOCK**, rederived by hand |
| 6 | numerator $-3$ at $n=11$, $+8$ at $n=12$, root $6+2\sqrt7$ | **PROVEN IN THE BLOCK**, all three exact |
| 7 | the root is irrational, so no integer attains it and the crossing is strict on both sides | **CORRECT, AND SHORT OF ITS OWN HYPOTHESIS**, the block never bounds $n$ below and never mentions the second root $6-2\sqrt7$ |
| 8 | "the integer threshold $12$ survives at both parities" | **GAP**, true, and there is no argument for it in the block: $\Theta_n$ is never defined here, its closed form never stated, and neither $n=11$ nor $n=13$ is evaluated |
| 9 | "**both inputs** are $n$-uniform closed forms derived without reference to any threshold, so the crossing is not circular" | **CORRECT, UNCHECKABLE FROM THE BLOCK**, neither input is derived in the block, so a consumer cannot verify the non-circularity from what is in front of them |
| 10 | [results.md](../results.md):302 and :112, "derived three independent ways" / "by three independent derivations" | **WITHDRAWN CLAIM STILL STANDING**, [INDEX-results.md](../findings/INDEX-results.md) row 2 records it as withdrawn and the [problem.md](../findings/problem.md) block refutes it; neither results.md copy was corrected |
| 11 | [lean/INDEX.md](../lean/INDEX.md):273 ("$\Theta_n^2<3/2$ is $n^2-12n+8<0$" | **THE CARRIED-IN TRAP, SPREAD**) that is $\theta_0$'s polynomial worn by $\Theta_n$; true on integers $n\ge2$ by coincidence of sign windows, false as an equivalence of conditions |
| 12 | the balanced split is the best sphere product below the threshold | **NOT IN THE BLOCK**, needed by L2's necessity consumers, one line to prove, given in §6 |

**Verdict: GAP.** The number, the polynomial, the root, the two integers and the cutoff in both directions are correct and the block now proves them; what has no argument in the block is the bolded parity clause it closes with, which rests on a constant the block never defines, and one of the block's two copies still carries an evidence claim the record has withdrawn.

---

## 0. Conventions, fixed once

- $n$ is the dimension of the manifold; $\mathcal W_n=\mathrm{Weyl}_n$; $P(W)=\operatorname{tr}(W^3)+\langle W^\#,W\rangle$ and $\theta(W)=P(W)/\lVert W\rVert^3$, so $\theta$ is scale-free and $P=\theta$ on unit vectors.
- **$\theta_0(n)$ is the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$ and nothing more.** This is [conventions.md](../findings/conventions.md):18 verbatim, including its warning that the gloss "the value at the balanced sphere product" is what regrew [L0](../findings/problem.md)'s refuted constant. $\theta_0$ is a rational function of a real variable; the object it names exists only at even $n$.
- **$\Theta_n$ is the diagonal maximum**, equal to $\theta_0(n)$ at even $n$ and to $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$, [conventions.md](../findings/conventions.md):19. **These are the two constants the round's carried-in trap is about**, and both appear in the block; only the first is defined there.
- $M(n)$ is the global maximum, $\Theta_n\le M(n)$, [conventions.md](../findings/conventions.md):21. L2 is about neither $M$ nor a global statement.
- $W_{\mathbb{CP}^2}=\operatorname{diag}(0,0,0,-1,-1,2)/\sqrt6$ on $\Lambda^2\mathbb R^4$, zero-padded; $\Lambda^+\cong\mathfrak{su}(2)_+\subset\mathfrak{so}(4)\subset\mathfrak{so}(n)$.
- Nienhaus's convention, from [notes.md](../references/nienhaus-2023-second-best-einstein/notes.md): the split $\mathbb R^k\oplus\mathbb R^l$ gives $S^k\times S^l$ with $k+l=n$, so his $(k,l)$ are the block's $(p,q)$ with no off-by-one.

---

## 1. The hypothesis inventory

A pass without one is not a pass, so this is the whole list: what the block carries, what each import carries, and what the written proof actually uses.

### 1.1 Hypotheses the block states

| hypothesis | where | used by the written proof? |
| --- | --- | --- |
| $n\ge4$ | only inside the competitor clause, "at every $n\ge4$" | **used for the competitor and for nothing else**, the $\theta_0$ half of the proof carries no bound on $n$ at all |

That is the complete list. The block states one hypothesis, and it is attached to one of its two inputs.

### 1.2 Hypotheses the imports carry, checked against the object each is applied to

| import | its hypotheses at source | the object here | met? |
| --- | --- | --- | --- |
| $\theta(S^p\times S^q)^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ | Nienhaus Prop. 2.25, [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404):1483: $W_{S_{k,l}}$ is the Weyl operator of the **product of two round spheres at the Einstein ratio**, $k+l=n$; $k,l\ge2$ for $\theta_{k,l}\ne0$ and $n>2$ | $p=q=n/2$ | **met at even $n\ge4$; vacuous at odd $n$**, where no such product exists |
| $\theta(W_{\mathbb{CP}^2})^2=\tfrac32$ | [CP2.lean](../lean/HamiltonsCubic/Base/CP2.lean) proves it at $n=4$ after first checking $W\in\mathcal W_4$ (symmetric, first Bianchi, Ricci-flat), via `native_decide`, which that file declares | the padded operator at general $n$ | **met at $n=4$; carried upward by §3's padding argument** |
| $\theta_0(n)^2-\tfrac32=\frac{n^2-12n+8}{2n^2}$ | [L2.lean](../lean/HamiltonsCubic/Results/L2.lean) `theta0Sq_sub_three_halves` carries `hn : n ≠ 0`; `sphereProductSq_balanced` carries `hn : n ≠ 0` **and** `hn2 : n ≠ 2` | real $n$ | **met for $n\ge4$; the prose states neither** |
| the sign facts | [L2.lean](../lean/HamiltonsCubic/Results/L2.lean) `threshold_neg` carries `4 ≤ n`, `cutoff_is_twelve` carries `4 ≤ n` | integer $n$ | **met; the prose carries no such bound**, see §5 |

### 1.3 Hypotheses the object needs and no form states

- **Parity.** $S^{n/2}\times S^{n/2}$ exists only at even $n$. The block's proof evaluates $\theta_0$ at $n=11$. Under the *formal-continuation* reading this is legitimate and is what [Lemma L44](../findings/problem.md) needs; under the *attained* reading it is a value of nothing. **The block never says which reading is in force**, and the record uses both, L44 explicitly wants $\theta_0$ at odd $n$ ("*the criterion demands $\theta_0(n)$ at both parities … $\Theta_n$ is what the diagonal locus attains, never what the criterion demands*"), while [W5](../lean/HamiltonsCubic/Results/W5.lean) wants $\Theta_n$.
- **The metric.** "The balanced product has $\theta_0(n)^2=\dots$" names a manifold, not a metric. $\theta$ depends on the metric; Nienhaus's $S_{k,l}$ is the product of *round* spheres at the Einstein ratio. [Lemma L48](../findings/problem.md) has already been repaired for exactly this omission, "*the equality case needs the factors round, since 'sphere' alone does not fix the metric that attains $\theta_0(n)$*", and the repair did not reach L2's block.
- **$\ker W\ne0$: no finding.** Neither input and no step uses any nondegeneracy of $W$. The sphere-product $W$ has spectrum $\{q/(p-1),\,p/(q-1),\,-1\}$, all nonzero, so $\ker W=0$ there; the padded $W_{\mathbb{CP}^2}$ has a kernel of dimension $\binom n2-3$ at every $n\ge4$, and §3's argument is indifferent to it. **The proof uses no hypothesis on $\ker W$, and neither object needs one.**
- **The smallest admissible dimension.** $n=4$: $\theta_0(4)^2=\frac{2\cdot3\cdot2}{16}=\frac34$ and $4^2-12\cdot4+8=-24<0$; the competitor is present at $n=4$ and the crossing fails there, correctly. Nothing in the block excludes $n<4$, and §5 shows the sign statement is false at $n=0$.

### 1.4 Which of these the written proof uses

The written proof uses: the general sphere-product formula (unproved here, unsourced here), the competitor's $n=4$ value (unproved here), the subalgebra fact (sketched here), and pure algebra over $\mathbb R$ and $\mathbb Z$ (proved here). It uses **no** parity hypothesis, **no** metric hypothesis, **no** lower bound on $n$, and **no** hypothesis on $\ker W$.

---

## 2. Question 1, does the prose prove what the kernel imports?

The [lean/INDEX.md](../lean/INDEX.md):278 row is precise about what is owed: *"$\theta_0(n)^2$ for the balanced sphere product stays imported"*, and *"the record extends it to every $n\ge4$ by padding, which is not formalised."* Two imports; I take them separately.

### 2.1 $\theta_0(n)^2$ for the balanced sphere product, **the block proves the specialisation and cites the formula, with no source named**

What the block does prove, and I rederived it: with $p=q=n/2$,

$$(p-1)(q-1)=\Big(\frac{n-2}2\Big)^2=\frac{(n-2)^2}4,\qquad pq=\frac{n^2}4,$$

$$\theta(S^{n/2}\times S^{n/2})^2=\frac{2(n-1)}{n-2}\cdot\frac{(n-2)^2/4}{n^2/4}=\frac{2(n-1)(n-2)}{n^2}.$$

**Correct.** This is the whole of what the block establishes about input one, and it is a proof.

What the block does not do is give the general formula a source. It appears as bare display text. **It is right**: Nienhaus Proposition 2.25, read at [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404):1483, states

$$W_{S_{k,l}}^2+W_{S_{k,l}}^\#=\theta_{k,l}W_{S_{k,l}},\qquad \theta_{k,l}=\sqrt2\sqrt{\frac{k-1}k\cdot\frac{l-1}l\cdot\frac{n-1}{n-2}},\qquad P(W_{S_{k,l}})=\theta_{k,l},$$

whose square is $\frac{2(k-1)(l-1)(n-1)}{kl(n-2)}$, the block's formula with $(k,l)=(p,q)$. **So the answer is: a citation, and a citation whose source the block withholds.** The source is in [references/](../references/) and I read it; a reader of the block alone has nothing to read.

### 2.2 The competitor's value beyond $n=4$, **the block proves the extension and asserts the base**

The block's sentence is one clause: *"The competitor has $\theta^2=\frac32$ at every $n\ge4$, since $\mathfrak{su}(2)_+$ is a subalgebra and $W^\#$ therefore stays inside $\Lambda^+$ under padding."*

This clause argues the **extension** and asserts the **base**. Split cleanly:

- **Extension, a sketch, with the load-bearing step present and correct.** §3 below completes it in four lines. The block names the one fact that is not routine (the subalgebra property) and leaves the routine parts (that $\lVert W\rVert$ and $W^2$ are padding-stable) implicit. I count this as a proof sketch a competent reader completes, not as a citation.
- **Base value $\theta^2=\tfrac32$ at $n=4$, no argument in the block.** I checked the reports the record cites for it before recording this, as the brief requires: [r505](../reviews/REVIEW_r505.md) §1.2 derives it from the structure constants ($\operatorname{tr}(W^3)=1/\sqrt6$, $\langle W^\#,W\rangle=2/\sqrt6$, sum $3/\sqrt6=\sqrt{3/2}$), and [r506](../reviews/REVIEW_r506.md) §F2 derives it independently by maximising $9\det W^+$ on the unit sphere of trace-free $(a,b,c)$. [CP2.lean](../lean/HamiltonsCubic/Base/CP2.lean) proves it in the kernel-plus-`native_decide` form $P(W)^2\cdot2=3\lVert W\rVert^6$. **So it is established on the record three ways and stated in the block zero ways.**

### 2.3 The asymmetry between the two forms, which is the answer the question was after

**Neither form is complete on its own, and their gaps are complementary:**

| | the base value $\theta^2=\tfrac32$ at $n=4$ | the padding extension to $n>4$ |
| --- | --- | --- |
| the prose block | asserted | **sketched, correctly** |
| the Lean forms | **proved**, in [CP2.lean](../lean/HamiltonsCubic/Base/CP2.lean) | **not formalised**, as the row says |

So the [lean/INDEX.md](../lean/INDEX.md):278 row's "owed" and the block's silence are two different holes, and each form fills the other's. **The record holds both halves; no single artefact does.** That is worth saying plainly, because the row's phrase "which is not formalised" reads, to a consumer, as though the record were short of the step, it is not; the step is in the prose, in one clause, and the row does not point at it.

---

## 3. The padding argument, completed, and it is correct

Write $c_{\alpha\gamma\delta}=\langle[v_\gamma,v_\delta],v_\alpha\rangle$ in an orthonormal basis of $\mathfrak{so}(n)\cong\Lambda^2\mathbb R^n$, so that $(W^\#)_{\alpha\beta}=\sum c_{\alpha\gamma\delta}c_{\beta\varepsilon\zeta}W_{\gamma\varepsilon}W_{\delta\zeta}$.

1. $W$ is supported on $\Lambda^+\subset\Lambda^2\mathbb R^4\subset\Lambda^2\mathbb R^n$, so $W_{\gamma\varepsilon}W_{\delta\zeta}\ne0$ forces $\gamma,\delta,\varepsilon,\zeta\in\Lambda^+$.
2. $\Lambda^+\cong\mathfrak{su}(2)_+$ is a **subalgebra**, so $[v_\gamma,v_\delta]\in\Lambda^+$ and $c_{\alpha\gamma\delta}\ne0$ forces $\alpha\in\Lambda^+$. Hence $W^\#$ is supported on $\Lambda^+\times\Lambda^+$ and its entries are sums over $\Lambda^+$ alone, **independent of $n$**.
3. $W^2$ and $\lVert W\rVert^2$ are supported on $\Lambda^+$ and $n$-independent for the trivial reason that padding appends zero rows and columns.
4. Therefore $P(W)=\operatorname{tr}(W^3)+\langle W^\#,W\rangle$ and $\lVert W\rVert$ are both fixed under padding, and $\theta=P/\lVert W\rVert^3$ is **exactly** $n$-independent. The same computation gives $Q(W)=\theta W$ at every $n$, since $Q$ vanishes off $\Lambda^+$.

**This agrees with [r505](../reviews/REVIEW_r505.md) §1.3 and [r506](../reviews/REVIEW_r506.md) §F2**, reached independently of both. The block's one clause is a faithful compression of it.

---

## 4. Question 2, is the threshold a threshold in both directions?

### 4.1 The identity, rederived

$$\theta_0(n)^2-\tfrac32=\frac{2(n-1)(n-2)}{n^2}-\frac32=\frac{4(n^2-3n+2)-3n^2}{2n^2}=\frac{n^2-12n+8}{2n^2}.$$

**Correct.** $2n^2>0$ for $n\ne0$, so the sign of the excess is the sign of $n^2-12n+8$ and nothing is lost in the passage.

### 4.2 The two integers, and the root

$11^2-12\cdot11+8=121-132+8=-3$. $12^2-12\cdot12+8=144-144+8=8$. Roots: $n=\frac{12\pm\sqrt{144-32}}2=6\pm\frac{\sqrt{112}}2=6\pm2\sqrt7$, and $2\sqrt7=5.2915026\ldots$, so the larger root is $11.2915026\ldots$ **All three correct.**

In excess form, exactly: $\theta_0(11)^2=\frac{180}{121}$, short of $\tfrac32$ by $\frac{3}{242}$; $\theta_0(12)^2=\frac{220}{144}=\frac{55}{36}$, over by $\frac1{36}$. Both strict, both rational, nothing rounds.

### 4.3 Direction one, $n\ge12$ sufficient. **Established, by the root and not by the $+8$.**

The block gives the value $+8$ at $n=12$ and the root $6+2\sqrt7$. Positivity for *every* integer $n\ge12$ follows because the quadratic opens upward and $12>6+2\sqrt7$; the block does not say this sentence but the root it supplies forces it, and the reader has to do one step. [L2.lean](../lean/HamiltonsCubic/Results/L2.lean) `threshold_pos` states it outright.

### 4.4 Direction two, $n\le11$ insufficient. **Established only with a lower bound on $n$ that the block never states.** See §5.

### 4.5 At the root itself. **Correct, and it is the sharpest thing in the block.**

$6+2\sqrt7$ is irrational, so $n^2-12n+8\ne0$ at every integer: **there is no equality case at any dimension**, and $\theta_0(n)^2=\tfrac32$ is attained by nothing. The crossing is therefore strict in both directions rather than weak on one side, which is what makes $\lceil6+2\sqrt7\rceil=12$ an exact integer statement rather than a rounding. The block asserts the irrationality without proof; $\sqrt7$ irrational is standard and [L2.lean](../lean/HamiltonsCubic/Results/L2.lean) `crossover_irrational` proves it from `Nat.Prime.irrational_sqrt`.

### 4.6 What no single form states

[L2.lean](../lean/HamiltonsCubic/Results/L2.lean) proves the identity over $\mathbb R$ (`theta0Sq_sub_three_halves`, hypothesis `n ≠ 0`) and the cutoff over $\mathbb Z$ (`cutoff_is_twelve`, hypothesis `4 ≤ n`), and **never joins them**: there is no theorem of the form `theta0Sq n ≥ 3/2 ↔ 12 ≤ n` anywhere in the file, for either $\mathbb R$ or a cast $\mathbb Z$. The row's phrase "the integer cutoff $12$ in both directions" is honest about the polynomial and silent about the join, which a reader supplies by multiplying up by $2n^2>0$. Small, and worth a row-note rather than a repair.

---

## 5. Discrepancy A, the block bounds $n$ nowhere, and the quadratic has a second root

**Locate it.** The block's closing sentence: *"the root is irrational, so no integer attains it and the crossing is strict on both sides."* Singular "the root". The block states no lower bound on $n$ anywhere in the $\theta_0$ half of the argument; its only "$n\ge4$" sits inside the competitor clause.

**Exhibit the failure concretely.** $n^2-12n+8$ has **two** roots, $6\pm2\sqrt7$, and $6-2\sqrt7=0.7084974\ldots$ At $n=0$ the polynomial is $+8>0$, the same sign as at $n=12$. So the inference a reader draws from "$-3$ at $n=11$, $+8$ at $n=12$, root $6+2\sqrt7$" (that the polynomial is negative below $12$), is false at $n=0$, and the correct statement needs $n>6-2\sqrt7$, i.e. $n\ge1$ over the integers. [L2.lean](../lean/HamiltonsCubic/Results/L2.lean) carries the hypothesis: `threshold_neg {n : ℤ} (h4 : 4 ≤ n) (h11 : n ≤ 11)`. The prose has no counterpart. Separately, `theta0Sq` at $n=0$ is undefined and `sphereProductSq_balanced` additionally excludes $n=2$; the prose states neither exclusion, and the identity of claim 5 is false at $n=0$ for the same reason.

**Argue the opposite, the most charitable reading the words support.** $n$ is a manifold dimension throughout this programme and [conventions.md](../findings/conventions.md) fixes $n\ge4$ globally; a reader of L2 who supplies $n\ge4$ from context loses nothing, and every consumer of L2 I checked ([results.md](../results.md):13, :37, [Lemma L44](../findings/problem.md), [W5.lean](../lean/HamiltonsCubic/Results/W5.lean)) does carry $n\ge4$. **The defect is inert and survives as a presentational one**: the block's own words do not entail its own conclusion without a hypothesis it never writes down, and the Lean form does write it down. Recorded, not escalated.

---

## 6. Discrepancy B, the parity clause has no argument in the block, and $\Theta_n$ is never defined there. **This is the GAP.**

**Locate it.** The paragraph after the $\square$:

> **Two things are exact here and they are different**: the real root of the formally continued formula, and the integer cutoff $12$. **At odd $n$ the real crossover is a different number**, $\Theta_n^2\ge\frac32$ is $n^2-13n+18\ge0$, root $\frac{13+\sqrt{97}}2=11.4244$, while the integer threshold $12$ survives at both parities.

**Exhibit the failure concretely.** Three things, at named objects.

1. **$\Theta_n$ appears in the block and is defined nowhere in it.** The block defines $\theta_0(n)$ (as the balanced case of the sphere-product formula) and then introduces a second symbol with a different value at exactly the dimensions the sentence is about. A consumer reading the block alone (which is how the named trap says to read it), cannot tell what $\Theta_n$ is, and the round's carried-in trap is precisely a $\Theta_n$-for-$\theta_0$ substitution. The definition is on the record, at [conventions.md](../findings/conventions.md):19 and [results.md](../results.md):88; it is not here.

2. **The odd polynomial is asserted, never derived, and never evaluated.** The derivation is one line and the block does not contain it. From $\Theta_n^2=\frac{2(n-1)(n-3)}{(n+1)(n-2)}$ at odd $n$:
   $$4(n-1)(n-3)\ge3(n+1)(n-2)\iff 4n^2-16n+12\ge3n^2-3n-6\iff n^2-13n+18\ge0,$$
   with roots $\frac{13\pm\sqrt{97}}2$ and $\sqrt{97}=9.8488578\ldots$, so the larger is $11.4244289\ldots$ **The block's polynomial and root are both correct.** The endpoint evaluations, which the even half of the block does supply and the odd half does not: $11^2-13\cdot11+18=121-143+18=-4<0$ with $\Theta_{11}^2=\frac{160}{108}=\frac{40}{27}=1.481\overline{481}<\tfrac32$; and $13^2-13\cdot13+18=+18>0$ with $\Theta_{13}^2=\frac{240}{154}=\frac{120}{77}=1.5584\ldots>\tfrac32$. These are what "survives at both parities" means and none of them is in the block.

3. **The clause does not follow from the block's own proof, and the margin by which it is true is $0.133$ of a dimension.** The displayed proof establishes the crossing of $\theta_0$ at $6+2\sqrt7=11.2915026$. At odd $n$ the attained value is $\Theta_n$, and
   $$\theta_0(n)^2-\Theta_n^2=2(n-1)\Big[\frac{n-2}{n^2}-\frac{n-3}{(n+1)(n-2)}\Big]=\frac{2(n-1)\big[(n-2)^2(n+1)-n^2(n-3)\big]}{n^2(n+1)(n-2)}=\frac{8(n-1)}{n^2(n+1)(n-2)}>0,$$
   the bracket collapsing because $(n-2)^2(n+1)=n^3-3n^2+4$ and $n^2(n-3)=n^3-3n^2$. (This reproduces [conventions.md](../findings/conventions.md):18's identity exactly, derived here rather than quoted.) So $\Theta_n<\theta_0(n)$ at every odd $n$, and:
   - **the insufficiency direction survives a fortiori**, $\Theta_{11}^2<\theta_0(11)^2=\frac{180}{121}<\tfrac32$, so odd $n\le11$ fails because the block's own computation says the *larger* quantity fails. The block does not say this, but its proof does entail it.
   - **the sufficiency direction does not follow at all.** $\theta_0(n)^2>\tfrac32$ gives nothing about $\Theta_n^2$, the inequality running the wrong way. The clause is true only because
     $$\frac{13+\sqrt{97}}2-(6+2\sqrt7)=\frac{1+\sqrt{97}-4\sqrt7}2=\frac{1+9.8488578-10.5830052}2=0.1329263\ldots,$$
     and no integer lies in the interval $(11.2915026,\;11.4244289)$. **The whole parity clause rests on that empty interval of width $0.133$, and nothing in the block's argument sees it.**

**Argue the opposite, the most charitable reading.** The block is a lemma about $\theta_0$, and the sentence in question is flagged as a distinction rather than as a step ("Two things are exact here and they are different"). On that reading the clause is a signpost to [Lemma L57](../findings/problem.md) and [conventions.md](../findings/conventions.md), not a claim the block undertakes to prove, and the block is complete as an even-$n$ statement. **The reading does not survive contact with the sentence's own last clause**: "the integer threshold $12$ **survives** at both parities" is a claim about both parities, stated in bold, inside the block, with no citation and no argument, and it is the clause consumers will lift. And the block already carries the same shape of failure that [Lemma L00](../findings/problem.md) was repaired for, *"the sentence was added as a report that it was missing, after the $\square$, rather than as the step."* Here too the parity material stands after the $\square$.

**Verdict on this candidate: upheld.** The clause is **true** and it has **no argument in the block**.

---

## 7. Discrepancy C, the named trap, live: [results.md](../results.md) still carries the withdrawn evidence claim

**Locate it.** Two lines, quoted:

- [results.md](../results.md):302, *"$n=6+2\sqrt7\approx11.29$ is exactly where the balanced sphere-product overtakes the $\mathbb{CP}^2$-type competitor (Fox's $\mathcal S^4(\alpha)$), **derived three independent ways**. Reproduces the $n\geq12$ threshold exactly, not just approximately."*
- [results.md](../results.md):112, *"The two named competitors swap ranks at $n=6+2\sqrt7\approx11.29$, in closed form and **by three independent derivations**."*

**Exhibit the failure concretely.** [INDEX-results.md](../findings/INDEX-results.md) row 2 says, in bold: *"**'Derived three independent ways' is withdrawn**, three derivations of $\theta_0(n)$ and two of $\sqrt{3/2}$, one route never reaching the competitor."* The [problem.md](../findings/problem.md) block says the same in its warning. [LEDGER.md](../findings/LEDGER.md):536 carries it as a confirmed finding. [r505](../reviews/REVIEW_r505.md) D1 and [r506](../reviews/REVIEW_r506.md) repair 3 both prescribed the replacement wording. **The correction landed in [problem.md](../findings/problem.md), [INDEX-results.md](../findings/INDEX-results.md) and [LEDGER.md](../findings/LEDGER.md); it did not land in either of the two [results.md](../results.md) lines, and [results.md](../results.md) is the file a consumer reads.** This is the record's signature failure exactly: the statement and its correction now live in different files, and a citation of [results.md](../results.md):302, which is the canonical short form, ending in "**Proof:** [problem.md](../findings/problem.md)", inherits a claim the record has withdrawn.

Read alone, as a consumer would, [results.md](../results.md):302 asserts (i) three independent derivations, which is withdrawn, and (ii) "reproduces the $n\ge12$ threshold exactly", which is the sufficiency reading [r506](../reviews/REVIEW_r506.md) repair 4 asked to be scoped to necessity. Neither correction reached it. The [problem.md](../findings/problem.md) block dropped sentence (ii) rather than scoping it, so **the necessity scoping is absent from both L2 forms** and lives only at a distance, in [results.md](../results.md):13 (*"$n\ge12$ necessary"*) and :37.

**Argue the opposite.** One could read [results.md](../results.md):302 as a stub whose authority is the "Proof:" pointer, so that the pointer target's warning governs and the stub inherits the correction. **That reading fails on its own terms**: the withdrawn phrase is an evidence claim about *how many independent derivations exist*, which the pointer target explicitly contradicts rather than merely elaborates, and a reader who follows the pointer meets the contradiction rather than a refinement. It also fails as a matter of record hygiene, [INDEX-results.md](../findings/INDEX-results.md) row 2 says "withdrawn", and a withdrawn claim standing in two places in the headline results file is not a stub, it is a live citation.

**Verdict on this candidate: upheld.** A repair prescribed by two CONFIRMED reviews, recorded as applied in the index, was applied to one copy of two.

---

## 8. Discrepancy D, the carried-in trap, spread into a row that cites L2

**Locate it.** [lean/INDEX.md](../lean/INDEX.md):273, the W5 row: *"**And it is [L2](../lean/HamiltonsCubic/Results/L2.lean)'s threshold read at two points** rather than a separate fact, `Θₙ² < 3/2` is `n² - 12n + 8 < 0`, which holds exactly on `4 ≤ n ≤ 11`."* The same gloss is in [W5.lean](../lean/HamiltonsCubic/Results/W5.lean)'s header and on its `strict_iff` docstring, and its two theorems are named `theta0Sq_four` / `theta0Sq_six` while their doc-comments read `Θ₄²` and `Θ₆²`.

**Exhibit the failure concretely.** $\Theta_n^2<\tfrac32$ is $n^2-12n+8<0$ at **even** $n$ and $n^2-13n+18<0$ at **odd** $n$. At $n=11$ the stated equivalence evaluates the wrong polynomial: $-3$ where the object's own polynomial gives $-4$, i.e. $\frac{180}{121}$ where $\Theta_{11}^2=\frac{40}{27}$. This is the round's carried-in trap in its exact shape, a constant that agrees at even $n$ and differs at odd $n$.

**Argue the opposite.** The two conditions have the same truth set on the integers that matter, and that is not an accident of the two cases the row names: $n^2-12n+8<0\iff 0.7085<n<11.2915$ and $n^2-13n+18<0\iff 1.5756<n<11.4244$, so over integers $n\ge2$ the two conditions are **identically** true on $2\le n\le11$ and identically false from $12$; they part company only at $n=1$. **So the row's conclusion is true, at both parities, on its whole stated domain $4\le n\le11$, and W5's two instances $n=4,6$ are even anyway, where $\Theta_n=\theta_0(n)$ by definition.** The Lean statements are about the integer polynomial and are unaffected; only the prose gloss substitutes.

**Verdict on this candidate: upheld as a defect of derivation, not of truth.** The row proves a true statement about $\Theta_n$ from $\theta_0$'s polynomial, and the coincidence of sign windows is why it gets away with it. It should say so, since it is the first place a reader would learn that the two polynomials have the same integer sign-change.

---

## 9. Two smaller items, and one repair still unapplied

- **The best-split claim is used and not proved anywhere in the block.** L2's necessity consumers ([Lemma L44](../findings/problem.md), [W5](../lean/HamiltonsCubic/Results/W5.lean)) need that *no* sphere product beats $\sqrt{3/2}$ below $n=12$, not merely that the balanced one does not. One line, from Nienhaus's formula: $\frac{(p-1)(q-1)}{pq}=1-\frac{n-1}{pq}$ is increasing in $pq$, and $pq$ is maximised over $p+q=n$ at the most balanced split. Hence $\Theta_n$ is the maximum over all two-block splits, and $\Theta_{11}^2=\frac{40}{27}<\tfrac32$ settles $n=11$ for every split. **Correct, and absent from every form of L2.**
- **[r505](../reviews/REVIEW_r505.md) D5 / [r506](../reviews/REVIEW_r506.md) repair 6 is unapplied.** [isotropy-cap.md](../findings/isotropy-cap.md):68 still labels an internal step "*Lemma L2*" ("every $d$-dimensional subspace has $\mu\ge4d^2/n-2d$"), with "*Lemma L1*" beside it, and lines 144 and 153 cite them as "Lemma L2's bound" and "the Lemma-2 bound". Line 144 (*"Lemma L2's bound is tight exactly when …"*), reads as a citation of the numbered threshold lemma and is not one. Both reviews called for the rename and it has not happened.
- **The move-note repair landed correctly.** [r506](../reviews/REVIEW_r506.md) repair 2 asked for the false provenance line to go; the block now keeps the line and refutes it in place, in bold, immediately beneath. **That is a correction inside the statement rather than beside it, and it is the model the other items in this report are failing to meet.**

---

## 10. The gap between what is proven and what may be cited

**What is proven, at both parities, on the record as a whole:**

1. $\theta_0(n)^2=\frac{2(n-1)(n-2)}{n^2}$, the balanced case of Nienhaus Prop. 2.25; at even $n$ this is the value of an actual Weyl operator in $\mathcal W_n$, at odd $n$ it is a value of the formally continued rational function and of nothing else.
2. $\theta(W_{\mathbb{CP}^2})^2=\tfrac32$ at every $n\ge4$, the base at $n=4$ and the padding extension both established (the base in three places, the extension in the block and in both reviews).
3. $\theta_0(n)^2\ge\tfrac32\iff n^2-12n+8\ge0\iff n\ge6+2\sqrt7$, the root irrational, so strict at every integer, with $-3$ at $11$ and $+8$ at $12$: **the integer cutoff is exactly $12$ over $n\ge4$, in both directions.**
4. At odd $n$, $\Theta_n^2\ge\tfrac32\iff n^2-13n+18\ge0\iff n\ge\frac{13+\sqrt{97}}2$, so the least admissible odd dimension is $13$ and the integer cutoff $12$ holds at both parities, **true, and established here and in [conventions.md](../findings/conventions.md) rather than in the block.**

**What a consumer may cite, and how:**

- **Citable from the block as it stands:** items 1–3, with the note that the two input values are imports whose sources the block does not name.
- **Citable, but not from the block:** item 4. A consumer wanting "the threshold is $12$ at both parities" must go to [conventions.md](../findings/conventions.md):19 for $\Theta_n$ and do §6's evaluations, because the block gives the polynomial without the constant it comes from and without either endpoint.
- **Not citable at all:** "derived three independent ways", in either [results.md](../results.md) copy. Withdrawn at [INDEX-results.md](../findings/INDEX-results.md) row 2.
- **Not citable as stated:** "reproduces the $n\ge12$ threshold exactly" ([results.md](../results.md):302), read as sufficiency. L2 proves the **necessity** half only: below $12$ a known point beats $\theta_0(n)$, so Conjecture A is false there. That $\max P=\theta_0(n)$ from $12$ up is the open conjecture, and nothing in L2 touches it.
- **A consumer needing $\Theta_n$ rather than $\theta_0$**, which is [W5](../lean/HamiltonsCubic/Results/W5.lean)'s case and not [Lemma L44](../findings/problem.md)'s, must not take $n^2-12n+8$ from L2 as $\Theta_n$'s polynomial. It gives the right answer on $n\ge2$ and it is not the right derivation.

---

## 11. What would break it, and what I did to look for it

**The object that would falsify the block's parity clause:** an integer $n$ with $6+2\sqrt7<n<\frac{13+\sqrt{97}}2$, i.e. an odd dimension at which the formally continued $\theta_0$ has crossed $\sqrt{3/2}$ but the attained $\Theta_n$ has not, at such an $n$ the block would say the threshold is passed and the record's maximiser would still lose to the competitor. **I looked for it by locating both roots exactly**: $6+2\sqrt7=11.2915026\ldots$ and $\frac{13+\sqrt{97}}2=11.4244289\ldots$, an interval of width $\frac{1+\sqrt{97}-4\sqrt7}2=0.1329\ldots$, whose endpoints straddle no integer since $11<11.2915$ and $12>11.4244$. **No such object exists.**

**The object that would falsify the threshold itself:** a sphere product $S^p\times S^q$ with $p+q=n\le11$ and $\theta^2\ge\tfrac32$. **I looked for it by maximising the closed form over splits** rather than by enumerating: $\theta^2=\frac{2(n-1)}{n-2}\big(1-\frac{n-1}{pq}\big)$ is increasing in $pq$, so the maximum over $p+q=n$ is at the most balanced split, and its value at $n=11$ is $\Theta_{11}^2=\frac{40}{27}<\tfrac32$. **No such object exists at any $n\le11$.**

**The object that would falsify the competitor's value:** a dimension $n>4$ at which the padded $W_{\mathbb{CP}^2}$ has $\theta\ne\sqrt{3/2}$. **I looked for it by checking whether $\Lambda^+$ can leak**: §3 shows every index in $W^\#$ is forced into $\Lambda^+$ by the subalgebra property, with no $n$-dependence anywhere in the sum. **No such dimension exists.** Independently, the block's own polynomial certifies the normalisation, as [r506](../reviews/REVIEW_r506.md) §F4 observes: the deflated $\sqrt3/2$ would give $5n^2-24n+16\ge0$ with roots $4/5$ and $4$, a threshold of $n\ge4$ and not $12$, so $n^2-12n+8$ cannot be produced by the wrong constant. **The block is on the right side of the $\sqrt{3/2}$ trap and cannot be on the wrong one while stating that polynomial.**

**Parity dependence of every constant in the block, as the carried-in trap requires:**

| constant | parity-dependent? | which the block's argument uses |
| --- | --- | --- |
| $\theta(S^p\times S^q)^2$ | no, a function of $(n,p,q)$ | used, as the parent formula |
| $\theta_0(n)^2=\frac{2(n-1)(n-2)}{n^2}$ | **the formula is parity-free; the object it names exists only at even $n$** | **this is what the displayed proof uses, at every $n$ including $n=11$** |
| $\Theta_n$ | **yes**, $=\theta_0(n)$ at even $n$, $<\theta_0(n)$ at odd $n$ by $\frac{8(n-1)}{n^2(n+1)(n-2)}$ | named in the closing paragraph, **defined nowhere in the block**, and load-bearing for the parity clause |
| $\sqrt{3/2}$ | no, $n$-independent by §3, hence parity-free | used |
| $6+2\sqrt7$ | the even/formal root | used |
| $\frac{13+\sqrt{97}}2$ | the odd/attained root | asserted, not derived |

**So the answer to the carried-in trap is: the block's displayed proof uses $\theta_0$ throughout, including at the odd dimension $n=11$, and its closing paragraph switches to $\Theta_n$ without defining it.** The switch is correct in the direction it is made and undefended in the direction the clause needs. The substitution the trap warns about has not been made *inside* L2's proof; it has been made *downstream*, in [lean/INDEX.md](../lean/INDEX.md):273's W5 row (§8).

**Silence check, as the brief requires.** *No finding on $\ker W$*: the proof uses no hypothesis about it and neither object needs one (§1.3). *No finding on quantifier order*: the two universally quantified statements ("at every $n\ge4$" for the competitor; the implicit "for all $n$" for the identity) are in the right order and neither is inverted. *No finding on circularity*: both inputs are derived from the objects, not from the threshold, and the direction of implication is right, [r505](../reviews/REVIEW_r505.md) §5 and my §2–§3 agree. *No finding against the number*: I found no witness against $6+2\sqrt7$, against $n^2-12n+8$, or against the cutoff $12$, and §11 says what I did to look.

---

## Verdict

# GAP

The mathematics is right and the block, unlike its state at the prior audit, now contains a real proof of the part it undertakes: the balanced specialisation, the identity, the two integers, the root, the irrationality and the cutoff in both directions all check by hand and all are in the block.

The gap is threefold and each part is named above:

1. **§6, the parity clause "the integer threshold $12$ survives at both parities" has no argument in the block**, names a constant the block never defines, states a polynomial it never derives, evaluates neither endpoint, and is true only because the interval $(6+2\sqrt7,\frac{13+\sqrt{97}}2)$ of width $0.1329$ contains no integer, a margin the block's argument cannot see. The sufficiency direction at odd $n$ does not follow from the displayed proof; the insufficiency direction does, a fortiori, because $\Theta_n<\theta_0(n)$.
2. **§7, the named trap, live.** [results.md](../results.md):302 and :112 still carry "derived three independent ways", withdrawn at [INDEX-results.md](../findings/INDEX-results.md) row 2 and refuted in the [problem.md](../findings/problem.md) block. The correction landed in three files and skipped the two lines a consumer reads. The necessity scoping [r506](../reviews/REVIEW_r506.md) prescribed reached neither form.
3. **§2, §5, §9, three unargued or unbounded steps that are each correct and each repairable in one line**: the sphere-product formula carries no source in the block (it is Nienhaus Prop. 2.25, read at source); the competitor's $n=4$ value is asserted in the block and proved in three other places; and the block bounds $n$ nowhere, while its quadratic has a second root at $6-2\sqrt7$.

**Not `HYPOTHESIS-DEBT`:** every step the block leaves unargued is established somewhere on the record, and I read the reports the record cites before saying so. **Not `BROKEN` and not `UNRESOLVED`:** no computation is needed, no witness against the statement exists, and §11 gives the search. The verdict is that a reader of L2 alone cannot get to the parity clause the block asserts, and a reader of [results.md](../results.md)'s L2 inherits a withdrawn claim.
