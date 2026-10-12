# REVIEW r277, Gate 2, route S's decomposable branch

Reviewer r277. Commits under review: `cfa6619` (primary), `ebba97f`, `cf074b2`, `d8a34c2`.
Primary file: [findings/support-dichotomy.md](../findings/support-dichotomy.md). Supporting: [findings/second-order.md](../findings/second-order.md) lines 185–208, [findings/nondegeneracy.md](../findings/nondegeneracy.md) line 326, [findings/fence-posts.md](../findings/fence-posts.md) posts 22/34/35, [findings/graded-half.md](../findings/graded-half.md), [plan.md](../plan.md) route S, [response.md](../response.md) Lemma L1 and Lemma L23.
Scripts: [scripts/reviewers/r277/](../scripts/reviewers/r277/). Reviewer r278 runs the identical brief concurrently and independently.

Everything numerical below is rebuilt from the vertex-matrix definition alone, $W(e_i\wedge e_j)=w_{ij}e_i\wedge e_j$, $(W^2)_{ij}=w_{ij}^2$, $(W^\#)_{ij}=\sum_{k\ne i,j}w_{ik}w_{jk}$, $\lVert W\rVert^2=\sum_{i<j}w_{ij}^2$, in exact rational arithmetic, with the convention pinned by the control $\theta(S^3\times S^3)=\sqrt{10}/3$. No repository script is imported. Evidence: [r277_checks.py](../scripts/reviewers/r277/r277_checks.py), [out_checks.txt](../scripts/reviewers/r277/out_checks.txt), [r277_hook_cases.py](../scripts/reviewers/r277/r277_hook_cases.py).

| # | Claim | Verdict |
|---|---|---|
| 1 | The decomposable-branch theorem | **(a),(b),(c) CONFIRMED, (d) REFUTED, and the assembly LOST the record's own sharper form.** The law, the $W_A\circ W_B=0$ hypothesis and $\lvert\theta\rvert<\min_i\lvert\theta_i\rvert$ all re-derive in three lines. But $1/\theta^2=\sum1/\theta_i^2$ also gives $\lvert\theta\rvert\le\max_i\lvert\theta_i\rvert/\sqrt k$, which under the theorem's own hypothesis $\lvert\theta_i\rvert<\sqrt2$ yields $\lvert\theta\rvert<1<\theta_0(n)$ for every $n\ge6$ **unconditionally**, so the caveat "*only where $\min_i\lvert\theta_i\rvert\le\theta_0(n)$*" is vacuous, and it is an artefact of the file having replaced [nondegeneracy.md:326](../findings/nondegeneracy.md)'s $\lvert\theta\rvert\le\max_iM(n_i)/\sqrt2<1<\theta_0(n)$ with a strictly weaker inequality. S1 was billed as pure assembly and it weakened what it assembled. Statement defect: "$W=\bigoplus_iW_i$ … each $W_i$ … of **unit norm**" makes $\lVert W\rVert^2=k\ne1$ |
| 2 | The induction and its base cases | **REFUTED, the induction is not well-founded, and its stated hypothesis is FALSE at $n_i=4$.** $\circ$-decomposability does not force $n_i<n$: the record's own flagship split $(S^4)^3=S^4\times S^8\oplus_\circ S^4\times S^4$ has its first piece at $n_1=\mathbf{12}=n$, $\theta=1.201561484$ re-derived here in exact arithmetic and matching [bounds.md](../findings/bounds.md) and [graded-half.md](../findings/graded-half.md) to nine digits, and the file's *own* $\Lambda^+/\Lambda^-$ example in the paragraph above has $n_i=n=4$. Separately, "the inductive claim $\lvert\theta_i\rvert\le\theta_0(n_i)$" is refuted by the file's own base case: $\max P|_{\mathrm{Weyl}_4}=\sqrt{3/2}=1.2247>\theta_0(4)=\sqrt3/2=0.8660$. What the theorem actually needs is only $M(n_i)<\sqrt2$, **not** the low-dimensional half of Conjecture A. $\theta_0$ increasing and $<\sqrt2$: CONFIRMED. $n_i\ge4$: CONFIRMED ($\mathcal W_n=0$ for $n\le3$). The $n_i=4$ case: CONFIRMED exactly. The $8\le n\le11$ dichotomy: located, and it is weaker than the file implies |
| 3 | The contradiction claimed against second-order.md | **THE READING IS DEFENSIBLE BUT NOT NEW, AND ONE CLAUSE IS OVERSTATED.** [Post F35](../findings/fence-posts.md) already states exactly this, "*established independently by r275 and r276*", and the file cites it, so the finding is an unpropagated fence post, not a discovery. And "*those two sentences cannot both stand*" is false as written: $\lvert\theta\rvert\le M(n)/\sqrt2$ stands perfectly on $\circ$-**decomposables**, which is how [nondegeneracy.md:326](../findings/nondegeneracy.md) and [plan.md](../plan.md) route S both use it, and $M(n)\le\sqrt3$ is exactly calibrated to that use ($\sqrt3/\sqrt2=1.2247<1.2360=\theta_0(12)$). What must change in [second-order.md](../findings/second-order.md) is one antecedent, not a claim |
| 4 | Is route S fenced? | **S2 MIS-STATES ITS OWN SOURCE LEMMA, and its named mechanism is already fully spent.** [plan.md](../plan.md) says the count "*holds when $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ ($S_{\mathfrak{mmm}}=0$)*", [response.md](../response.md) Lemma L23 says the opposite: $S_{\mathfrak{mmm}}\ge0$ **is** the cap, holding on the whole subalgebra family, and $S_{\mathfrak{mmm}}=0$ is the **equality** case. So "treat the grading defect as the correction term" proposes as new the one step the lemma already takes. The real gap is off the *subalgebra* family, not off the graded one, and it is much wider than stated: every unbalanced sphere product is already outside it (three eigenvalues, [graded-half.md](../findings/graded-half.md)). Posts 22, 34, 35 do not touch S2; **post F1 does**, $\theta$ is provably not a function of the $\Lambda^2$ spectrum ($300$ tensors at $n=6$, $P\in\{-24,0,24\}$), so any count-only extension is dead and the weight must fall on $S_{\mathfrak{mmm}}$, i.e. on alignment, which is where every other route already fails. Post F28's mechanism is a live risk at the level of the route, not of S2's wording: with the decomposable branch free (below), route S *is* Conjecture A on indecomposables |
| 5 | The diagonal-grant correction | **CONFIRMED, "even $n\ge12$" is exactly right, verified against the thesis.** [diss_jaeger_florian.txt](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf) L113: "*Let $n\ge16$ be an even integer*", and L119: "*The conjecture is that this is also true for all even integers $n\ge12$*". Odd $n$ is untreated there and [response.md](../response.md)'s scope note keeps it conjectural, Lemma L1 covers "the bulk of Jäger's argument for odd $n$" but "his endgame genuinely needs evenness". With Lemma L1 closing $n=12,14$, even $n\ge12$ is the exact scope. One residual: Lemma L1 is machine-checked (exact root isolation plus validated interval arithmetic), which the "**Proved** and audited" label should carry |
| 6 | The hook fix | **PARTIALLY CONFIRMED, both failure modes survive, and the salvage change misses the pair that actually failed.** A corpse still silences the loop, for up to $45$ minutes instead of $90$, demonstrated. A live reviewer is still declared dead past $45$ minutes, against a *measured* worst gap of $39.3$: $13\%$ headroom on a repo whose own memory note is "guard heavy Sage runs". Three cases the commit does not cover: (i) the actual reported kill path is an orphan cleanup, which never calls `salvage_reviewer.py`, so salvage-and-close being one action changes nothing there; (ii) `salvage()` **returns before appending** when a full report already exists, so a reviewer killed after filing but before its `DONE` line cannot be closed by the one tool built to close it, reproduced; (iii) a log ending in a blank line reads as in flight forever, as does an empty log |

---

## Claim 1, the decomposable-branch theorem

### (a) The harmonic-square law is true, and criticality of the pieces is what buys it

From the definitions. $Q$ is the quadratic form of the bilinear $\circ$, so with $W=\sum_{i=1}^ka_iA_i$ and $A_i\circ A_j=0$ for $i\ne j$,

$$Q(W)=\sum_ia_i^2Q(A_i)+2\sum_{i<j}a_ia_j\,A_i\circ A_j=\sum_ia_i^2\theta_iA_i .$$

The $A_i$ are linearly independent, $\circ$-orthogonality with $\theta_i\ne0$ forces Frobenius orthogonality, by [second-order.md](../findings/second-order.md)'s polarisation line, so $Q(W)=\theta W$ separates into $a_i^2\theta_i=\theta a_i$, i.e. $a_i=\theta/\theta_i$ on the support. Then $\sum a_i^2=1$ gives $1/\theta^2=\sum_i1/\theta_i^2$. **Confirmed.**

**What criticality of the pieces buys.** Criticality of the *sum* alone gives only $Q(W)=\theta W$; it does not make $Q(A_i)$ proportional to $A_i$, and without that the displayed sum has components outside $\mathrm{span}\{A_i\}$ that may cancel among themselves. Criticality of the pieces is what turns one vector equation into $k$ scalar equations, and those scalar equations are the law. It is *not* implied by $\circ$-orthogonality plus criticality of $W$, it is implied only when each $A_i$ additionally spans a $\circ$-invariant subspace, which the theorem does not assume. Naming it as a hypothesis is right.

**Two independent confirmations from the record, neither cited in the file.** [Post F22](../findings/target.md)'s table gives $\mathbb{CP}^2{+}\mathbb{CP}^2$ at $0.8660$ and $\mathbb{CP}^2{}^{\times3}$ at $0.7071$; the law applied to pieces at $\sqrt{3/2}$ returns $0.866025$ and $0.707107$, $k=2$ and $k=3$. And [reviews/INDEX.md](INDEX.md)'s B4 witness $S^6\times S^6\oplus W_{\mathbb{CP}^2}$ at $n=16$: the law on $\theta_0(12)$ and $\sqrt{3/2}$ returns $0.869989$ against its recorded $0.869988927484$.

### (b) $W_A\circ W_B=0$ is the right hypothesis, and "strictly weaker than coordinate-disjointness" is correct

The hypothesis sits strictly between two conditions the record also names, and both strictnesses have witnesses on file:

- **Strictly stronger than Frobenius orthogonality.** $\langle W_{S^3\times S^3},W_{\mathbb{CP}^2}\rangle=0$ at $n=6$ with cross term $0.2152$. The implication runs the other way only: $A\circ B=0$ and $\theta_A\ne0$ force $\langle A,B\rangle=0$.
- **Strictly weaker than coordinate-disjointness.** The $\Lambda^+/\Lambda^-$ pair on the same four coordinates. This one is checkable rather than asserted: on $\mathrm{Weyl}_4$, $P=9(\det W^++\det W^-)$ is additive across the two chiralities, which is $Q$-additivity, which is $W^+\circ W^-=0$; and the balanced combination $t=1/\sqrt2$ returns $\sqrt{3/2}\cdot2\cdot2^{-3/2}=0.866025404=\theta_0(4)$ exactly, i.e. $S^2\times S^2$ is the harmonic-square recombination of its own two chiralities.

The file's use of it is correct. **Confirmed.**

### (c) $\lvert\theta\rvert<\min_i\lvert\theta_i\rvert$ follows, absolute values included

$1/\theta^2=\sum_{i=1}^k1/\theta_i^2>1/\theta_j^2$ for each $j$ whenever $k\ge2$ and every $\theta_i\ne0$, so $\theta^2<\theta_j^2$ and $\lvert\theta\rvert<\lvert\theta_j\rvert$. The law is in squares, so the absolute values are exactly what it delivers and the signs of the $\theta_i$ never enter. **Confirmed.**

### (d) The caveat is WRONG, the branch is unconditional, and the file weakened its own source

The same identity gives a second consequence the file dropped:

$$\frac1{\theta^2}=\sum_{i=1}^k\frac1{\theta_i^2}\ \ge\ \frac k{\max_i\theta_i^2}\qquad\Longrightarrow\qquad\lvert\theta\rvert\le\frac{\max_i\lvert\theta_i\rvert}{\sqrt k}.$$

Under the theorem's *own* hypothesis $\lvert\theta_i\rvert<\sqrt2$ with $k\ge2$ this reads $\lvert\theta\rvert<\sqrt2/\sqrt2=1$, and $\theta_0(n)>1$ for every $n\ge6$. So the conclusion is $\lvert\theta\rvert<1<\theta_0(n)$, with no side condition at all. **The caveat "*only where $\min_i\lvert\theta_i\rvert\le\theta_0(n)$*" is vacuous**, and it exists only because the file kept the weaker of the law's two corollaries.

Neither corollary dominates the other in general, at $\theta_i=(1,100)$ the $\min$ form is far better, at $\theta_i=(1.41,1.41)$ the $\max/\sqrt k$ form is, but on the hypothesis actually in force, $\lvert\theta_i\rvert<\sqrt2$, the $\max/\sqrt k$ form is the one that closes.

This is not a new inequality. [nondegeneracy.md line 326](../findings/nondegeneracy.md) already carries it verbatim: *"What survives is $\lvert\theta\rvert\le\max_iM(n_i)/\sqrt2<1<\theta_0(n)$ for every $n\ge12$, with $\theta/\theta_0\le0.706$, requiring only $\theta_i<\sqrt2$."* S1's brief was "pure assembly"; the assembly dropped the operative clause and then documented a gap that the dropped clause closes.

### The three-line theorem the branch actually supports

Stronger than the file's, and it needs no hypothesis whatever. Let $M(n)=\max\{P(W):W\in\mathcal W_n,\lVert W\rVert=1\}$, attained by compactness, and note $\sup\lvert P\rvert=M(n)$ since $P$ is odd. Suppose a maximiser $W$ ($\theta=M(n)>0$) is $\circ$-decomposable into $k\ge2$ $\circ$-orthogonal critical unit pieces $A_i\in\mathcal W_n$. Then $\lvert\theta_i\rvert=\lvert P(A_i)\rvert\le M(n)$, so

$$M(n)=\theta\le\frac{\max_i\lvert\theta_i\rvert}{\sqrt2}\le\frac{M(n)}{\sqrt2}<M(n),$$

a contradiction. **Every maximiser of $P$ on the unit sphere of $\mathcal W_n$ is $\circ$-indecomposable, at every $n$, unconditionally.** No induction, no base cases, no $\lvert\theta_i\rvert<\sqrt2$, no $n_i<n$. This is what [second-order.md](../findings/second-order.md)'s "*decomposable points … can never set a new maximum*" asserts, and it is worth writing down because it makes the entire apparatus of §"What the induction actually consumes" unnecessary for Conjecture A. The apparatus is needed only for the strictly stronger statement "*every decomposable critical point has $\theta\le\theta_0(n)$*", which route S does not need.

### A statement defect

"$W=\bigoplus_iW_i$, $k\ge2$ pieces, … each $W_i$ critical of **unit norm** in dimension $n_i<n$" cannot hold together with $\lVert W\rVert=1$: it gives $\lVert W\rVert^2=\sum\lVert W_i\rVert^2=k$. The intended object is $W=\sum_ia_iA_i$ with $A_i$ unit and $\sum a_i^2=1$; the theorem as printed has no such $W$.

---

## Claim 2, the induction and its base cases

### $\theta_0$ is increasing and bounded by $\sqrt2$, CONFIRMED

$\theta_0(n)^2=2(n-1)(n-2)/n^2=2-6/n+4/n^2$, with derivative $(6n-8)/n^3>0$ for $n\ge2$ and limit $2$. So $\theta_0$ is strictly increasing on $n\ge2$ and $\theta_0(n)<\sqrt2$ at every $n$, checked over $n=4\dots39$. The record's tabulated odd values are the *attained* two-block maxima rather than this closed form ($1.095445$ at $n=7$ against the formula's $1.106567$), and the tabulated sequence $0.866,0.943,1.054,1.095,1.146,1.171,1.200,1.217,1.236$ for $n=4\dots12$ is strictly increasing too, so the claim survives on either reading.

### Can a piece have $n_i<4$?, no, CONFIRMED

$\dim\mathcal W_n=n(n+1)(n+2)(n-3)/12$ vanishes for $n\le3$, so a nonzero critical piece needs $n_i\ge4$. The file's floor is right.

### The $n_i=4$ base case, CONFIRMED exactly

$\mathfrak{so}(4)=\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ splits $W$ into chiralities, each a trace-free symmetric $3\times3$ operator; $\#$ restricts to $2\,\mathrm{adj}$ on each ([post F2c](../findings/fence-posts.md)), and $\langle\mathrm{adj}A,A\rangle=3\det A=\operatorname{tr}(A^3)$ for trace-free $3\times3$, giving $P=3\operatorname{tr}(W^3)=9(\det W^++\det W^-)$. Okumura at $m=3$ puts $\max\det=2/6^{3/2}$ at $\lambda=(2,-1,-1)/\sqrt6$, so $\max P=9\cdot2\cdot6^{-3/2}=\sqrt{3/2}=1.224744871$, attained at one chirality, i.e. at $W_{\mathbb{CP}^2}$. Reproduced to $10^{-16}$.

### But that base case REFUTES the induction the file states

The file's induction runs on "*the inductive claim $\lvert\theta_i\rvert\le\theta_0(n_i)<\sqrt2$*". At $n_i=4$ that claim asserts $\lvert\theta_i\rvert\le\theta_0(4)=\sqrt3/2=0.866025$, and the same paragraph's own theorem gives a critical point at $\sqrt{3/2}=1.224745$. **The induction hypothesis is false at the one base case the file says is proved**, and, on the record's own reading of $M(n)=\max(\sqrt{3/2},\theta_0(n))$, at $n_i=6,8,10$ as well, since $\sqrt{3/2}$ exceeds $\theta_0$ exactly for $n\le11$.

The theorem does not need that claim. It needs $\lvert\theta_i\rvert<\sqrt2$, and $\sqrt{3/2}<\sqrt2$, so the $n_i=4$ case is fine, but only because the operative hypothesis is the weak one. Which means the file's closing sentence, "*This is the low-dimensional half of Conjecture A, and route S inherits it rather than avoiding it*", **overstates the debt**. What route S inherits is $M(n_i)<\sqrt2$ for $4\le n_i\le11$: proved at $n_i=4$, claimed proved at $n_i=5$ ($\Theta_5=\sqrt{3/2}$, though [sym3-blocks.md](../findings/sym3-blocks.md) line 138 contradicts [plan.md](../plan.md) and [findings/INDEX.md](../findings/INDEX.md) on whether it is in hand), open at $6\le n_i\le11$. That is a genuinely weaker obligation than $\lvert\theta_i\rvert\le\theta_0(n_i)$, and the file should be asking for it.

### The induction is not well-founded, $\circ$-decomposability does not force $n_i<n$

Two witnesses, one from the record's flagship example and one from the file's own text.

**Witness 1, $(S^4)^3$ at $n=12$.** [second-order.md line 204](../findings/second-order.md): *"$(S^4)^3=S^4\times S^8\;\oplus_\circ\;S^4\times S^4$ with $\theta=1.201561$ and $1.145644$ recombining to $0.829156$."* $S^4\times S^8$ occupies all twelve coordinates. Re-derived here from criticality in exact rationals: for $S^p\times S^q$ the cross equation gives $\theta=-(n-1)b$ and the two within-block equations are consistent with it identically, so at $(p,q)=(4,8)$,

$$\theta=11\Big/\sqrt{\tfrac{1760}{21}}=11\sqrt{\tfrac{21}{1760}}=1.201561484 ,$$

matching [graded-half.md](../findings/graded-half.md)'s table and [bounds.md](../findings/bounds.md) to nine digits, at **ambient $n=12$**. The harmonic recombination with $\theta_0(8)=1.145643924$ returns $0.829156198$ against the record's $0.829156$. So the split is real and its first piece has $n_1=n$.

**Witness 2, the file's own $\Lambda^\pm$ example.** The paragraph establishing hypothesis (b) offers "*a $\Lambda^+/\Lambda^-$ pair on the same four coordinates*". Those two pieces live in $\mathcal W_4$ with $n_i=n=4$. The file exhibits a violation of its own hypothesis two paragraphs before relying on it.

So "each $W_i$ critical of unit norm in dimension $n_i<n$" is a hypothesis that $\circ$-decomposability does not supply, and "the induction is sound" does not follow. Either the theorem excludes the record's flagship decomposable point, or there is no descent.

**The repair is available and is not an induction on $n$.** Iterating the splitting terminates because $\dim E(1)$ of $L_e$ strictly drops (every $\circ$-summand lies in $E(1)$, by [second-order.md line 190](../findings/second-order.md)), so every critical point is a $\circ$-orthogonal combination of $\circ$-**indecomposable** critical points *at the same $n$*. The dichotomy is then a reduction to the indecomposable branch at dimension $\le n$, which is what route S wants anyway, and the maximiser statement in Claim 1 above needs no descent argument at all.

### The $8\le n\le11$ dichotomy, located, and it gives less than the phrasing suggests

[route-a.md line 37](../findings/route-a.md): *"A bonus at $8\le n\le11$. The same machinery yields an unconditional dichotomy below the crossover: either $\max P\le\sqrt{3/2}$, or every maximizer sits farther than $0.5748$ from the $\mathbb{CP}^2$ orbit."* It is a disjunction, not a bound: the second branch is a *location* statement about maximisers and gives no value at all. So at $8\le n\le11$ the record does not have $M(n)\le\sqrt{3/2}$, and does not have $M(n)<\sqrt2$ either. The file's "*the only unconditional statement there is a dichotomy*" is accurate; a reader should know that the dichotomy does not discharge the base cases even at those four dimensions.

---

## Claim 3, the contradiction claimed against second-order.md

### The original, quoted in full

[second-order.md line 206](../findings/second-order.md), the paragraph entire:

> **What this settles and what it leaves.** Decomposable points are capped by their own pieces and can never set a new maximum, so Reviewers 56/57's infinite direct-sum family costs route B nothing: the residual narrows to **$\circ$-indecomposable** non-diagonal $S=0$ points. Padding is the $b=0$ case and preserves indecomposability, so padded $W_{\mathbb{CP}^2}$ at $\sqrt{3/2}$ stays in the residual as the sharp case. What the cap needs is $|\theta|\le M(n)/\sqrt2\le\sqrt{3/2}$, i.e. an *a priori* bound $M(n)\le\sqrt3$, strictly weaker than Conjecture A, since $\theta_0(n)<\sqrt2<\sqrt3$ at every $n$.

### The reading is defensible

"The cap" has two candidate antecedents. Under the **residual** reading, the paragraph proposes converting an a priori $M(n)\le\sqrt3$ into a bound on the $\circ$-indecomposable residual through a $\sqrt2$ that exists only on decomposables, which is invalid, and is precisely [post F35](../findings/fence-posts.md). Under the **decomposable** reading, "the cap" is the cap two sentences earlier, and the sentence says: to make "*capped by their own pieces*" numerically useful you need $M(n)\le\sqrt3$, giving $\lvert\theta\rvert\le\sqrt3/\sqrt2=1.224745<1.236033=\theta_0(12)$, which is valid, is how [nondegeneracy.md line 326](../findings/nondegeneracy.md) and [plan.md](../plan.md) route S both use it, and explains why the constant is $\sqrt3$ and not something else. The "*What this settles*" framing favours the residual reading, since the decomposable cap is presented there as already settled.

### But the finding is not new, and one clause is wrong

**Not new.** [Post F35](../findings/fence-posts.md) opens: *"The route: cap that quantity on $\circ$-indecomposable unit Weyl operators, convert by $\lvert\theta\rvert\le M(n)/\sqrt2$, and beat $\theta_0(n)$. The conversion does not exist on the set it is needed for"*, *"established independently by r275 and r276"*, with the same divisor failure ($\theta=1.224745$ against $F/\sqrt2=0.995782$) that [support-dichotomy.md](../findings/support-dichotomy.md) reprints. The file cites post F35 for it. So what S1 found is an *unpropagated* fence post: [second-order.md](../findings/second-order.md) was never updated after post F35 landed. That is a real documentation debt and worth recording, as a documentation debt.

**Overstated.** "*Those two sentences cannot both stand*" is false. The sentence identifying the residual as $\circ$-indecomposable and the inequality $\lvert\theta\rvert\le M(n)/\sqrt2$ are perfectly compatible: the second holds on the complement of the residual. What cannot stand is one *application* of the second to the first. Likewise "*the $M(n)\le\sqrt3$ programme … was aimed at a conversion that does not apply where it was to be used*" concedes too much of the record: $M(n)\le\sqrt3$ remains exactly the right target for the decomposable branch at even $n\ge12$, and fence posts 11 and 12 fence two *routes to* $M(n)\le\sqrt3$ rather than its use.

**What must change in second-order.md.** One antecedent, made explicit: *"What the cap on decomposables needs is …"*, plus a sentence saying the residual inherits only $\theta\le\sqrt3$ and pointing at post F35. Nothing in the paragraph's mathematics is wrong; its pronoun is.

---

## Claim 4, is route S itself fenced?

### S2 mis-states the lemma it is built on

[plan.md](../plan.md) S2: *"[response.md](../response.md)'s count holds when $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ ($S_{\mathfrak{mmm}}=0$). … treat the grading defect $S_{\mathfrak{mmm}}$ as the correction term."*

[response.md](../response.md) Lemma L23, and [graded-half.md line 284](../findings/graded-half.md) identically:

> $$\theta=\frac2n\sqrt{\frac{rN}{N-r}},\qquad S_{\mathfrak{mmm}}=(N-r)\Big[2(n-2)-\frac{4(n-1)r}N\Big],$$
> hence $r\le n(n-2)/4$ and $\theta\le\theta_0(n)$, **with equality in either place exactly when $S_{\mathfrak{mmm}}=0$**.

The cap does **not** require $S_{\mathfrak{mmm}}=0$; it *follows from* $S_{\mathfrak{mmm}}\ge0$, which holds because $S_{\mathfrak{mmm}}$ is a sum of squares. $S_{\mathfrak{mmm}}=0$ is the equality case, the graded, symmetric-pair, balanced-split point. So the count already covers the non-graded members of the family, and treating the defect as "the correction term" proposes as the new mechanism the exact step the lemma's proof already takes and takes in full: the derivation eliminates $S_{\mathfrak{hhh}}$ and $S_{\mathfrak{mmm}}$ and then uses nothing about $S_{\mathfrak{mmm}}$ beyond its sign. There is no unspent slack there.

### The gap is off the subalgebra family, and it is much wider than "the graded family"

Lemma L23 needs $W_{\mathfrak h}$ to be the unit multiple of $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$, a **two-eigenvalue** operator whose positive eigenspace is a Lie subalgebra. [graded-half.md](../findings/graded-half.md)'s $n=12$ table shows how thin that is: of the five sphere products, only the balanced one is two-eigenvalue; $S^5\times S^7$, $S^4\times S^8$, $S^3\times S^9$ and $S^2\times S^{10}$ are all three-eigenvalue graded critical points. So the count does not reach even the unbalanced sphere products, let alone the residual. Describing the open set as "*non-graded indecomposable critical points*" understates it by the whole three-eigenvalue graded population.

### And the residual's sharp case can never join the family

Padded $W_{\mathbb{CP}^2}$ is the residual's sharp point, and it is produced by zero-padding. $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ has full support, so no padded operator is of that form. The one family on which the count is proved therefore contains, by construction, no member resembling the point the count must beat. [plan.md](../plan.md)'s fence-post check says *"S is not a cap on a padding-invariant quantity (the count sees $n$)"*, true of the count, and the reason it sees $n$ is exactly that the family is not padding-closed; but the witness it must beat *is* padding-invariant ($\theta=\sqrt{3/2}$ identically at $n=4\dots16$, post F35), so the mechanism and the obstruction never meet on a common set.

### Against the named posts

| post | applies to S2? |
|---|---|
| **1** (P is not a spectral function) | **YES, to the closed form, and it bounds what the "count" half can be.** Lemma L23's $\theta=\tfrac2n\sqrt{rN/(N-r)}$ reads $\theta$ off eigenvalue multiplicities alone, and post F1's witness, $300$ diagonal Weyl tensors at $n=6$ with identical $\Lambda^2$ spectra $(1^6,0^3,(-1)^6)$, counts $60/180/60$, $\lVert W\rVert^2=12$, and $P\in\{-24,0,+24\}$, proves that identity cannot survive off the family in any form, since $P$ spreads by $48$ at fixed multiplicities. An *inequality* $\theta\le f(r,n)$ is not refuted by that witness (all $300$ sit at $0.5774$ against $\theta_0(6)=1.0541$), but S2 asks for equality **exactly** at $S^{n/2}\times S^{n/2}$, and an equality case is what a quantity blind to $48$ units of spread cannot deliver on its own. So the weight must fall on $S_{\mathfrak{mmm}}$, which is bracket/alignment data, relocating the crux to where posts 1, 2 and 34 already say the difficulty lives, and undercutting [plan.md](../plan.md)'s *"the proof must live where the counting lives"* |
| **6** (the obstruction is directional, not dimensional; spectral moments of $L_W$ are the wrong invariants) | **partially.** $S_{\mathfrak{mmm}}$ is not a spectral moment of $L_e$, so S2 is not the fifth telling; but post F6's diagnosis (directional, not dimensional), is precisely the objection to a *dimension* count |
| **22** ($\ker\Phi_W$ carries no $\theta$ information) | no. Different invariant, different mechanism. Untouched |
| **11, 12** (routes to $M(n)\le\sqrt3$) | no. They fence two attacks on the a priori bound; S2 does not go through $M(n)$ |
| **28, 34** (a bound that equals the target identically) | **not at S2's wording, yes at the route's level.** S2's deliverable is "an inequality with the defect on one side", which is not yet a substitution. But route S's decomposable branch is free (three lines, Claim 1) so the dichotomy transfers none of the difficulty, and "an $n$-seeing count caps $\theta\le\theta_0(n)$ with equality exactly at $S^{n/2}\times S^{n/2}$ on indecomposables" is Conjecture A with one adjective attached. The dichotomy is a *partition*, not a *reduction*, and should be graded as one |

**Is S2 a genuinely new mechanism?** The named first attempt is not, it is the lemma's own step, re-proposed. What would be new is an extension of the two scalar eigen-equations to three or more eigenvalues, or a version of the identities $S_{\mathfrak{hhh}}+S_{\mathfrak{hmm}}=\kappa r$, $2S_{\mathfrak{hmm}}+S_{\mathfrak{mmm}}=\kappa(N-r)$ that survives the positive eigenspace not being a subalgebra. Neither is named in S2, and both are where the work is.

---

## Claim 5, the diagonal grant covers even $n\ge12$

**Verified against the primary source.** [diss_jaeger_florian.txt](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf) L113–L119:

> "Theorem A. Let $n\ge16$ be an even integer, and let $W\in\langle W\rangle_d$ with $\|W\|=1$ be given such that $W^2+W^\#=\theta W$ for a $\theta\ge\theta_0(n)$. Then $\theta=\theta_0(n)$, and $W$ is the normalized Weyl curvature of $S^{n/2}\times S^{n/2}$."
> "The conjecture is that this is also true for all even integers $n\ge12$ and all operators $W\in\langle W\rangle$."

So: even $n\ge16$ published; $n=12,14$ open in print; odd $n$ untreated. [response.md](../response.md) line 149 states exactly this, line 153's scope note keeps odd $n$ conjectural, *"its computation covers the bulk of Jäger's argument for odd $n$, but his endgame genuinely needs evenness"*, and line 336 gives the structural reason, that for odd $n$ the cap $n(n-2)/4$ is not an integer so the inequality is strict and the equality case that identifies the maximiser does not exist. Lemma L1 closes $n=12$ and $n=14$. **"Even $n\ge12$" is exactly right**, and `cf074b2` is a correct refutation of the prior wording.

**One residual, on the label rather than the scope.** Lemma L1 is not a pen-and-paper proof: it replaces Jäger's box by the true moment body, dualises, rationalises to a quartic settled by exact root isolation, and discharges a one-dimensional remainder by validated interval arithmetic over ten subintervals. That is a rigorous computer-assisted proof and it belongs in "Proved"; but [plan.md](../plan.md)'s "**Proved and audited**" should say which of the two dimensions carries which certificate, since the granted assumption at $n=12$ (the dimension where the conjecture first bites), now rests on it alone.

---

## Claim 6, the hook fix

Evidence: [r277_hook_cases.py](../scripts/reviewers/r277/r277_hook_cases.py), run against the live [research_loop_stop.py](../.claude/hooks/research_loop_stop.py) and [salvage_reviewer.py](../scripts/salvage_reviewer.py).

```
_agents_running = True   <- A corpse, killed 10 min ago, log ends in a heartbeat
_agents_running = False  <- Same corpse, 50 min old (past the 45-min window)
_agents_running = False  <- Corpse closed by salvage_reviewer.py
_agents_running = True   <- Finished reviewer, DONE then a BLANK line
_agents_running = False  <- Finished reviewer, DONE last
_agents_running = True   <- Empty log just created
_agents_running = True   <- Heartbeat says 'phase3 DICKSON DONE, f=5 running'
```

### Can a corpse still silence the loop?, YES

Row 1. The window is $2700$ s, not zero, so a reviewer killed at $T$ silences the hook until $T+45$ min. The commit's own framing is honest about this (*"the residual risk is now taken in the loud direction on purpose"*) but the change **halves the exposure, it does not remove it**, and the summary line "a corpse silenced the loop" reads as a fix rather than a narrowing.

Three cases the commit's second change does not reach:

1. **The kill path does not call the salvage script.** The commit's own account of the incident is *"a reviewer's background job was killed during an orphan cleanup"*. Making salvage-and-close one action guarantees nothing about a cleanup that never invokes `salvage_reviewer.py`. The pair that came apart is kill-vs-salvage, not salvage-vs-close.
2. **`salvage()` refuses, and refusing skips the close.** The existing-full-report guard returns before the append:
   ```
   if os.path.exists(out):
       head = open(out, encoding='utf-8').read(200)
       if 'PARTIAL' not in head:
           return f"r{n}: reviews/REVIEW_r{n}.md exists and is a full report, refused"
   ```
   Reproduced: with `reviews/REVIEW_r901.md` present and `agent_logs/r901.log` ending in `HEARTBEAT phase4`, `salvage(901)` returns *"refused"* and the log tail is unchanged. A reviewer that filed its report and was killed before writing `DONE` is exactly the corpse most likely to occur, and it is the one case the tool declines to close.
3. **A trailing blank line, or an empty log.** `tail = lines[-1]` with `re.match(r"\s*(DONE|FAILED)\b", tail)` fails on `"\n"` and on `""`. Rows 4 and 6: a reviewer that ends its log with a blank line, or a log created at launch before the first write, reads as in flight for the full window.

### Can a live reviewer still be declared dead?, YES

Row 2, read the other way. Past $45$ minutes of silence, an unclosed log is skipped and a working reviewer counts as finished. The docstring records a measured worst gap of $39.3$ minutes, so the headroom is $5.7$ minutes ($13\%$), on a repository whose own operating note is to background heavy Sage runs. A single long SDP or Gröbner step crosses it.

The commit calls that direction "loud and self-correcting". It is loud. "Self-correcting" is an assertion about the model's response, not a property of the code: the hook's own docstring describes the same situation as *"the hook then demands reviewers that are already working, once per turn, indefinitely, with the turn's only available action being to re-launch them"*, and a re-launch on the same tag overwrites the live reviewer's log and report in place.

### The PID question, the fix is right to drop it, for the reason given

The protocol's first line is written by a transient Bash shell, so the logged PID exits immediately and a liveness check on it marks every healthy reviewer dead. That is correctly diagnosed in the docstring and correctly not attempted. What would actually decide liveness is a token the *launcher* controls (the background task's own id, or a heartbeat file the reviewer touches) rather than anything parsed out of the log the reviewer writes about itself.

### Verdict

The direction is right and the reasoning about asymmetric failure modes is sound. But the two questions the brief asks both answer **yes**, and the residual is concentrated in a case the commit does not consider: a killed reviewer whose report already exists is silently un-closable by the one tool built to close it.
