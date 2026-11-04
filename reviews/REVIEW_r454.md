# REVIEW r454, Lemma L150, the four-set half of the isolation clause as a concentration bound

*Adversarial audit, cold brief, 2026-09-03. Target: [Lemma L150](../findings/second-order.md) in [findings/second-order.md](../findings/second-order.md). Analysis-only footing; the one numerical act is a screen on objects constructed here from the criticality equation and property-checked before use, reported as a screen.*

## Verdict, per claim

| # | claim | verdict |
| --- | --- | --- |
| 1 | the boxed chain $\Sigma=\tfrac12(3S_2-S_1^2)\le\tfrac32S_2\le3m_4$, with its three tightness conditions | **CONFIRMED**, correct algebra, correct normalisation |
| 2 | the $L_{121}$-to-$L_e$ translation the lemma inherits ($\Sigma=\theta^2\iff$ the block carries $\tfrac12$) | **CONFIRMED** |
| 3 | *"it suffices that no four indices carry half the Frobenius mass of $M$"*, the reduction as [I18](../plan.md)'s named input | **REFUTED** |
| 4 | *"[Lemma L24](../findings/second-order.md) already gives $\Sigma\le\theta^2$ at every maximiser, so the whole content is strictness"* | **REFUTED** as a description of what [I18](../plan.md) owes |
| 5 | *"uses only $\lVert M\rVert\le\lVert W\rVert=1$ ([I11](../plan.md))"* | **REFUTED**, wrong norm as written, and [I11](../plan.md) is an open item |
| 6 | *"No fence post covers the L121 or L122 blocks, so the item was unattempted rather than fenced"* | **REFUTED**, twice, by posts in the same file |
| 7 | *"a hollow $4\times4$ with zero row sums and $A+B+C=0$ saturates every step"* | **CONFIRMED but understated**, the whole four-supported family saturates, automatically |
| 8 | [plan.md](../plan.md) line 97, *"UNBLOCKED 2026-09-03 (Lemma L150 names the input"* | **REFUTED**), should revert to blocked |

**Headline.** The lemma's algebra is right and its consequence is a route the record refuted, fenced and indexed **before** L150 was written, in the **same file**, 230 lines above it. [Post F50](../findings/second-order.md) is titled *"the four-set concentration route: the lemma is false"*; [Lemma L130](../findings/diagonal-half.md)(i) upgrades that to *"no reduction of the four-set clause to $m_4$ alone can work, a theorem, not a caution"*. L150 is exactly such a reduction, and it is post F50's own chain **with post F50's surviving term deleted**.

## 1, The norm. It is right in the display and wrong in the justification

**The operative normalisation is the unordered one, $\sum_{a<b}M_{ab}^2=1$, and I pinned it from outside the claim.** Two independent anchors, neither read off L150:

- Built $S^m\times S^m$ from Ricci-flatness alone ($\alpha=\beta=-m\gamma/(m-1)$) and imposed $\sum_{a<b}M_{ab}^2=1$. The $(2,2)$ four-set gives $\Sigma=4(\alpha-\gamma)^2=4(2m-1)/(m^2(m-1))$ against $\theta_0(2m)^2=(2m-1)(m-1)/m^2$, so $\Sigma/\theta^2=4/(m-1)^2$, **which is $1$ at $m=3$**, reproducing [Lemma L121](../findings/second-order.md)'s recorded equality at $S^3\times S^3$'s nine $(2,2)$ splits.
- The same object gives $\tfrac12\sqrt\Sigma/\theta=1/(m-1)=2/(n-2)$, **which is [Lemma L26](../findings/nondegeneracy.md)'s $\mu_{m,m}$ on the nose.**

Both would be off by a factor under any other reading, so the displayed sum over unordered pairs $\{a,b\}\subset\{i,j,k,l\}$ compared against a total of $1$ is the correct threshold, and the gloss *"half the Frobenius mass"* is a ratio and therefore normalisation-free. **The display survives.**

**The sentence justifying it does not.** [conventions.md](../findings/conventions.md)'s vertex-matrix block fixes $t=\lVert K\rVert_F^2=\sum_{a\ne b}K_{ab}^2=2$ at a unit Weyl tensor (the **ordered** sum) and warns in bold that reading the index set as unordered is *inconsistent with the bound $t\le2$*. So under the record's own convention for this matrix, $\lVert M\rVert=\sqrt2$, and *"$\lVert M\rVert\le\lVert W\rVert=1$"* is false as written. Only the fact that L150 spells its sum out over unordered pairs keeps the threshold at $\tfrac12$ rather than $\tfrac14$; a successor who substitutes the cited inequality mechanically gets the wrong constant. **The letter $M$ is exactly the overload [conventions.md](../findings/conventions.md) closes with a warning about, and this line walks into it.**

**And the citation is to an open item.** [I11](../plan.md) is an unchecked plan entry (*"Theorem: at every critical point and every frame $F$ … $\lVert M_F\rVert\le\lVert W\rVert$"*), grade 2, with its frame search [I11a](../plan.md) blocked on the user's approval. It is what I18 **wants built**, not what is in hand. The lemma cites it as an established input.

**The citation is also unnecessary, which is the sharper point.** [I18](../plan.md) quantifies over **pure** critical points, so there is a frame in which $W$ is coordinate-diagonal and the $M_{ab}$ **are** its $\Lambda^2$ eigenvalues; then $\sum_{a<b}M_{ab}^2=\mathop{\mathrm{tr}}(W^2)=1$ is an identity, with equality rather than $\le$, and no lift to a general frame is needed. Spending an open item where an identity suffices is how an unproved input gets laundered into a chain.

## 2, The translation from $L_M$ to $L_e$. Correct

[Lemma L121](../findings/second-order.md) gives $L_M$ block eigenvalues $\pm\tfrac12\sqrt\Sigma$; $L_e=L_M/\theta$; [Lemma L128](../findings/second-order.md)(ii) excludes the **value** $\tfrac12$. So the clause is $\tfrac12\sqrt\Sigma/\theta\ne\tfrac12$, i.e. $\Sigma\ne\theta^2$, the negative branch cannot reach $+\tfrac12$ since $\theta>0$ and $\sqrt\Sigma\ge0$. The four-set blocks lie in non-trivial sign characters while $W$ lies in the trivial one, so $X\perp W$ holds and [Lemma L24](../findings/second-order.md) applies to them without the projection defect of [DERIVE-mx1.md](DERIVE-mx1.md). **No factor is dropped**, and my $S^m\times S^m$ construction confirms it numerically at two independent points. This attack line finds nothing.

## 3, The reduction is refuted, at an infinite family of pure critical points in the band

**Screen**, $S^p\times S^q$ built here from the criticality equation $(M^2)_{ab}=\theta M_{ab}-M_{ab}^2$, which forces $\gamma=-\theta/(n-1)$, $\alpha=q\theta/((p-1)(n-1))$, $\beta=p\theta/((q-1)(n-1))$, then normalised. **Properties verified before use**: hollow, row sums $<3\times10^{-16}$, $\sum_{a<b}M_{ab}^2=1.0000000000$, criticality defect $<10^{-15}$.

| point | $n$ | $\theta$ | in band | $\max_S m_4$ | $3m_4$ vs $\theta^2$ |
| --- | --- | --- | --- | --- | --- |
| $S^6\times S^6$ | 12 | 1.236033 | yes | 0.109091 | $0.327<1.528$ ✓ |
| $S^5\times S^7$ | 12 | 1.228239 | yes | 0.229091 | $0.687<1.509$ ✓ |
| $S^5\times S^{43}$ | 48 | 1.263631 | yes | **0.501203** | $1.5036<1.5968$ ✓ |
| $S^5\times S^{66}$ | 71 | 1.264355 | yes | **0.532919** | **$1.598758>1.598595$ ✗** |
| $S^5\times S^{1000}$ | 1005 | 1.264909 | yes | **0.595226** | **$1.7857>1.5999$ ✗** |

- **L150's stated sufficient condition, $m_4<\tfrac12$ at every four-subset, is false at $S^5\times S^{43}$**, a pure critical point, $n=48\ge12$, $\theta=1.2636>\sqrt{3/2}=1.2247$. Its $(4,0)$ four-subsets carry $50.12\%$ of the mass.
- **L150's whole chain stops concluding at $S^5\times S^{66}$**, and the failure is permanent: $3m_4/\theta^2\to9/8$ as $q\to\infty$ at $p=5$, so **no constant repairs it**. This is post F50's sentence, reproduced cold.
- **$p=5$ is structural, not incidental**: the band's floor is $\min(p,q)\ge5$ and $m_4\ge\tfrac12$ wants $p\le5$, so the two conditions meet at exactly one value and the band sits on it. *Testing balanced products never sees this*, and note L150 is not vacuous at the balanced product ($m_4=0.109$ at $n=12$), which is precisely why it looks healthy.

**The loss is total, not marginal, and it is one identified term.** At every $(4,0)$ and $(3,1)$ four-subset in the table the true $\Sigma$ is **exactly $0$**, while L150's bound is $3m_4\approx\theta^2$. [Post F50](../findings/second-order.md)'s surviving half is the same identity **with the term kept**,
$$\Sigma=\tfrac32(A^2+B^2+C^2)-\tfrac12\sigma^2,\qquad\sigma=A+B+C=\textstyle\sum_{a<b\in S}M_{ab},\qquad\text{hence }\Sigma\le3m_4-\tfrac12\sigma^2,$$
and $\sigma^2$ is what annihilates the bound at exactly the sets where L150 fails. L150's step $\tfrac12(3S_2-S_1^2)\le\tfrac32S_2$ **discards $-\tfrac12\sigma^2$**. So L150 is strictly weaker than an incumbent already on the record, at a point the record names, and [post F50](../findings/second-order.md) closes with the instruction it violates: *"A successor uses the identity, not the mass alone."*

**And the impossibility is a theorem, not a counterexample.** [Lemma L130](../findings/diagonal-half.md)(i), two independent cold derivations at Gate 2: in-band $\sigma=0$ four-sets exist, where $\Sigma=3m_4$ exactly, so any $m_4$-only sufficient condition must imply $m_4<\theta^2/3$; and $\sup m_4/\theta^2=3/8>1/3$ in band. **So no reduction of the four-set clause to $m_4$ alone can work.** L150 is that reduction.

## 4, The framing sentence is false for I18's quantifier

L150 opens with *"[Lemma L24](../findings/second-order.md) already gives $\Sigma\le\theta^2$ at every maximiser, so the whole content is strictness."* [I18](../plan.md) is about **every pure critical point** with $\theta\ge\sqrt{3/2}$, and [Lemma L24](../findings/second-order.md) is a **maximality** statement. At a pure critical point that is not a maximiser $\Sigma$ can exceed $\theta^2$: [Lemma L128](../findings/second-order.md)'s own box says so in bold, $S^2\times S^4$ is pure, critical and nondegenerate with a $(2,2)$ block at $\mu=\tfrac23>\tfrac12$, i.e. $\Sigma=\tfrac{16}9\theta^2$, and that box sits 420 lines above L150 in the same file, recording that **two reviewers refuted an earlier version of exactly this confusion with exactly this example**.

The chain itself is unaffected, being an absolute bound that never invokes [Lemma L24](../findings/second-order.md). But the sentence misdescribes what is owed, and it is the kind of misdescription that licenses a successor to reach for a strictness argument where a two-sided exclusion is required. **Delete it or rewrite it as: at a pure critical point neither inequality is available, and the clause $\Sigma\ne\theta^2$ must be established from scratch.**

## 5, The fence-post claim is false, twice, from inside the same file

L150's provenance line reads *"No fence post covers the L121 or L122 blocks, so the item was unattempted rather than fenced."* Both halves are covered, and [plan.md](../plan.md) line 97 repeats the sentence verbatim.

- **The L121 four-set block is fenced by [post F50](../findings/second-order.md)**, *"the four-set concentration route: the lemma is false"*, Gate 2 by [r389](REVIEW_r389.md) and [r390](REVIEW_r390.md), corrected at [r400](REVIEW_r400.md), indexed as trap 50 in [INDEX-traps.md](../findings/INDEX-traps.md), and strengthened to a theorem by [Lemma L130](../findings/diagonal-half.md)(i) via [r401](REVIEW_r401.md) and [r402](REVIEW_r402.md).
- **The L122 pair block is fenced by [post F47](../findings/INDEX-traps.md)**, *"No lossy estimate can prove [I18](../plan.md)'s pair clause, because in a non-orbit-free block it is an exact equality … Four bounds died here"*, with [post F51](../findings/second-order.md) and [post F52](../findings/second-order.md) closing the reformulation and complement-coupling routes on top of it.

**L150 also fails both of [post F51](../findings/second-order.md)'s two cheap self-checks**, which that post records precisely so this does not recur. *"Does the new form use a quantity the old one did not?"*, every symbol in L150 is built from $M$'s entries and $\theta$, so no. *"Evaluate it against the incumbent at one recorded point"*, one line at $S^5\times S^{43}$, a point already in the file, kills it.

## 6, What the unspent hypotheses can do: nothing here

The lemma says hollowness and zero row sums are *"still in hand and unspent"* and must enter. **They cannot reach $\tfrac12$**, and the sharpest thing they imply is the opposite of what is wanted.

**First, the caveat is understated.** The lemma exhibits *"a hollow $4\times4$ with zero row sums and $A+B+C=0$"* as saturating every step. Screened: the space of symmetric hollow zero-row-sum $4\times4$ matrices is **exactly $2$-dimensional**, and every element of it automatically has $M_{ij}=M_{kl}$, $M_{ik}=M_{jl}$, $M_{il}=M_{jk}$ and $A+B+C=0$. So all three steps saturate on the **entire four-supported family**, not at one exhibited point, the hypotheses of the lemma's own caveat are not a coincidence to be avoided but the generic case on that locus, where $m_4=1$ and $\Sigma=3$.

**Second, hollowness and zero row sums have no concentration content at all.** They are what defines $\mathcal D_n$, and $\mathcal D_4$ padded into $\mathcal D_n$ sits inside it at $m_4=1$. Adding criticality gives one thing and it is out of range: solving $2bc+a^2=\theta a$, $2ac+b^2=\theta b$, $2ab+c^2=\theta c$ with $a+b+c=0$ and $2(a^2+b^2+c^2)=1$ has **exactly** the solutions $(a,b,c)$ a permutation of $\big(\tfrac{\sqrt3}3,-\tfrac{\sqrt3}6,-\tfrac{\sqrt3}6\big)$ at $\theta=\tfrac{\sqrt3}2=0.866$, padded $S^2\times S^2$, and the sign-reversed copies at $\theta<0$. Consistent with [post F50](../findings/second-order.md)'s *"the maximal four-supported concentrator sits at exactly $\sqrt{3/2}$"*, which is the same number in that post's $\theta(M):=\sqrt2P(M)/\lVert M\rVert^3$ scaling.

**So the band's grip on concentration exists only at $m_4=1$ and evaporates immediately below it**, which is what the $S^5\times S^q$ family demonstrates: hollow, zero row sums, critical, in band, $m_4\to3/5$. The hypotheses the lemma is banking on are already spent by the counterexamples.

## Would any of this be true vacuously?

Checked, and no.

- **The chain is not vacuous**: it is a genuine identity plus two genuine inequalities, all three simultaneously attainable, on a $2$-dimensional locus that exists.
- **The refutation is not vacuous**: $S^5\times S^{43}$ and $S^5\times S^{66}$ are pure critical points, verified as such here from the criticality equation, at $n\ge12$ and $\theta>\sqrt{3/2}$, precisely the class [I18](../plan.md) quantifies over.
- **The refutation is of the route, not the clause.** At every witness the true $\Sigma$ is $0$, so [I18](../plan.md)'s four-set clause $\Sigma\ne\theta^2$ **holds** there, comfortably. What falls is L150's method. This matches [post F50](../findings/second-order.md)'s verdict word for word and should be stated that way in the record so no one reads this review as evidence against the clause.

## What should change

1. **Revert [plan.md](../plan.md) line 97's "UNBLOCKED 2026-09-03".** [I18](../plan.md) is still blocked on its four-set clause; L150 does not name a usable input. Item (c)'s wording, *"bound the L121 and L122 blocks … from hollow $M$, zero row sums, $\lVert M\rVert\le\lVert W\rVert$ and $\theta>\sqrt{3/2}$ alone"*, is already the correct open statement and is where the item should sit.
2. **Retitle L150 and cut its consequence box.** What survives is a correct algebraic identity that is [post F50](../findings/second-order.md)'s identity with a term dropped. If it is kept at all it should be recorded as a **duplicate** of post F50's surviving half, cross-linked to it, with the drop of $-\tfrac12\sigma^2$ named as the reason it is weaker.
3. **Strike the fence-post sentence** from L150 and from [plan.md](../plan.md), and replace it with links to [post F50](../findings/second-order.md), [Lemma L130](../findings/diagonal-half.md)(i) and [post F47](../findings/INDEX-traps.md).
4. **Fix the norm sentence.** At a pure critical point the diagonalising frame gives $\sum_{a<b}M_{ab}^2=1$ as an identity; drop the [I11](../plan.md) citation, which is an open item and in the wrong norm besides.
5. **Strike the [Lemma L24](../findings/second-order.md) framing sentence**, which asserts a maximiser's inequality at a critical point the file elsewhere refutes it at.
6. **Promote the saturation caveat**: the whole four-supported locus saturates, and it carries exactly one critical orbit, at $\theta=\sqrt3/2$ in the criticality normalisation. That is a positive fact worth keeping when the rest of the lemma goes.

## Screen disclosure

One screen was run, on objects constructed here from the criticality equation and the Ricci-flat ansatz, with hollowness, zero row sums, unit norm and the criticality defect all checked **before** any quantity was read off. It reproduces two values the record holds independently, $\Sigma/\theta^2=1$ at $S^3\times S^3$'s $(2,2)$ splits and $\theta=1.263631$ at $S^5\times S^{43}$, which is what makes it a screen that could have failed. It is reported as a screen; the argument above stands on [Lemma L130](../findings/diagonal-half.md)(i), which is a theorem on the record and needs no computation.
