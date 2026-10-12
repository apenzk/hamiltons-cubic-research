# Review r592, Lemma L0, "problem p and conjecture a are the same statement"

*Review number taken: **r592**. Highest existing on disk at start: `REVIEW_r590.md`; r591 is taken by the concurrently-running reviewer on the identical brief, whose report and log were not read.*

**Verdict: `REFUTED`.**

The biconditional is true at even $n$ and **false at every odd $n\ge13$**, and the identification with Conjecture A fails at odd $n$ in both directions at once. One constant is wrong: the block writes $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ where the published Conjecture A writes $P(W^{\mathrm{crit}}_{\mathrm{sym}})$, the value at $S^{\lceil n/2\rceil}\times S^{\lfloor n/2\rfloor}$. Those agree at even $n$ and differ at odd $n$.

**The sharpest form of the refutation needs no hypothesis.** At odd $n\ge13$, the $(\Leftarrow)$ direction as stated *implies the negation of Conjecture A*. See §2.3.

---

## 1. What the two sides say, and what the proof delivers

Write $\mathcal S=\{W\in\mathcal W_n:\lVert W\rVert=1\}$, $\mathrm{Crit}=\{W\in\mathcal S: W \text{ critical for }P|_{\mathcal S}\}$, and $M(n)=\sup_{\mathcal S}P$ (the record's own symbol, [conventions.md:20](../findings/conventions.md)).

- **LHS**: $M(n)=\theta_0(n)$, an *equality*, so two inequalities.
- **RHS**: $P\le\theta_0(n)$ on $\mathrm{Crit}$.

### 1.1 $(\Rightarrow)$ is trivial and correct

If $M(n)=\theta_0(n)$ then $P\le\theta_0(n)$ on all of $\mathcal S$ by the definition of a supremum, hence on $\mathrm{Crit}\subseteq\mathcal S$. **No compactness, no smoothness, no criticality is used.** The block's compactness paragraph is spent entirely on the other direction; this one is one line and the block does give it.

### 1.2 $(\Leftarrow)$ is a non-sequitur as written

The block's text is: *"If $P\le\theta_0(n)$ at every critical point then in particular $P(W_{\max})\le\theta_0(n)$, and $P(W_{\max})$ is the supremum."*

That chain terminates at $M(n)\le\theta_0(n)$. The conclusion asserted is $M(n)=\theta_0(n)$. **The step $M(n)\ge\theta_0(n)$ appears nowhere in the block, nowhere in the proof, and nowhere in the three scope conditions.** It is not a small omission: it is the half of the equality that requires a *witness* (an actual unit Weyl operator whose $P$ reaches $\theta_0(n)$) and no witness is exhibited.

At even $n$ the gap is fillable in one line from the record's own [Lemma L57](../findings/problem.md): $\theta(S^{n/2}\times S^{n/2})^2=\frac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2$, and that operator lies in $\mathcal S$. **At odd $n$ it is not fillable, because it is false.** §2.

---

## 2. Parity, the refutation

### 2.1 The block's own formula, evaluated at its own maximiser

The third scope condition supplies $\theta_{k,l}^2=2\frac{n-1}{n-2}\left(1-\frac{n-1}{kl}\right)$ and says the maximum over splits sits at $k=\lceil n/2\rceil$. That monotonicity claim is correct, $kl=k(n-k)$ is maximised at $k=\lceil n/2\rceil$ over integers and $1-\frac{n-1}{kl}$ is increasing in $kl$, and it is consistent with [Lemma L57](../findings/problem.md)'s independent closed form, since $(p-1)(q-1)=pq-n+1$ gives $\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}=2\frac{n-1}{n-2}\bigl(1-\frac{n-1}{pq}\bigr)$ identically. **The two formulas agree; that is not where the error is.**

The error is that the block never evaluates its own formula at odd $n$. Put $n$ odd, $k=\frac{n+1}2$, $l=\frac{n-1}2$, so $kl=\frac{n^2-1}4$:

$$\theta_{k,l}^2=2\frac{n-1}{n-2}\left(1-\frac{4(n-1)}{n^2-1}\right)=2\frac{n-1}{n-2}\cdot\frac{n-3}{n+1}=\frac{2(n-1)(n-3)}{(n-2)(n+1)},$$

which is exactly $\Theta_n^2$ at odd $n$ ([conventions.md:19](../findings/conventions.md)). Against $\theta_0(n)^2$:

$$\theta_0(n)^2-\theta_{k,l}^2=2(n-1)\left[\frac{n-2}{n^2}-\frac{n-3}{(n+1)(n-2)}\right]=\frac{2(n-1)\bigl[(n-2)^2(n+1)-n^2(n-3)\bigr]}{n^2(n+1)(n-2)}=\frac{8(n-1)}{n^2(n+1)(n-2)}\;>\;0,$$

since $(n-2)^2(n+1)-n^2(n-3)=(n^3-3n^2+4)-(n^3-3n^2)=4$ identically. **So at every odd $n$ the balanced product of spheres falls strictly below $\theta_0(n)$**, by a positive amount with the closed form above. *Screened over $n=12\dots21$ in exact rationals as a check on the algebra, not as evidence: $120/77<264/169$ at $n=13$, $21/13<364/225$ at $n=15$, equality at every even $n$.*

### 2.2 What that does to the left-hand side, and to the third scope condition

- **The left-hand side.** $M(n)=\theta_0(n)$ at odd $n$ would require a maximiser strictly above every sphere product. The record's diagonal theorem ([L57](../findings/problem.md)) caps the whole coordinate-diagonal locus at $\Theta_n<\theta_0(n)$, so any such witness must be non-diagonal, and none is on the record. The equality is therefore not merely unproved at odd $n$, the only family the programme has ever put forward for it provably misses it.
- **The third scope condition is internally in tension with the displayed statement.** It fixes "products of spheres" as $k=\lceil n/2\rceil$ and, in the same block, the displayed equality reads $M(n)=\theta_0(n)$. Those two are compatible only when $\theta_{\lceil n/2\rceil,\lfloor n/2\rfloor}=\theta_0(n)$, i.e. only at even $n$. The condition is a **genuine clarification** of *which* split (it correctly reproduces $\theta_{5,7}^2=264/175<55/36=\theta_{6,6}^2$ at $n=12$), and it is precisely the clarification that exposes the constant as wrong at the other parity.

### 2.3 The unconditional form: $(\Leftarrow)$ at odd $n$ implies Conjecture A is false at odd $n$

Fix odd $n\ge13$ and suppose $(\Leftarrow)$ holds. Two cases exhaust:

1. $P>\theta_0(n)$ at some critical point. Since $\theta_0(n)>\Theta_n=P(W^{\mathrm{crit}}_{\mathrm{sym}})$, that critical point violates Conjecture A's $n\ge12$ clause outright.
2. $P\le\theta_0(n)$ at every critical point. Then $(\Leftarrow)$ gives $M(n)=\theta_0(n)>P(W^{\mathrm{crit}}_{\mathrm{sym}})$, so the maximiser (which is a critical point), again violates Conjecture A's $n\ge12$ clause.

**Either way $(\Leftarrow)$ forces a counterexample to the very conjecture the lemma claims to *be*.** No assumption about the truth of Conjecture A is used. This is the refutation in its strongest form, and it is why the defect cannot be repaired by weakening the verdict to "unproved at odd $n$".

---

## 3. "Each side is the $n\ge12$ clause of Conjecture A", the identification, checked against the source

The published text, read verbatim from [the thesis in references/](https://arxiv.org/abs/2311.02404) (line 212):

> *"Conjecture A. Let $W\in\mathrm{Weyl}_n$ be a unit Weyl curvature operator that is a critical point of $P(R)=\langle R^2+R^\#,R\rangle$ among $\mathrm{Weyl}^1_n$. If either $n\ge12$ or $8\le n\le11$ and $W\notin SO(n).W_{\mathbb{CP}^2}$, we have $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$. Here we denote by $R^{\mathrm{crit}}_{\mathrm{sym},n}$ the curvature operator of $S^{\lceil n/2\rceil}\times S^{\lfloor n/2\rfloor}$ …"*

**The published constant is $P(W^{\mathrm{crit}}_{\mathrm{sym}})=\Theta_n$ at both parities, not $\theta_0(n)$.** Consequences:

| | even $n\ge12$ | odd $n\ge13$ |
|---|---|---|
| RHS of L0 vs. the $n\ge12$ clause | identical | **strictly weaker**, $\theta_0(n)>\Theta_n$, so L0's RHS permits critical points the conjecture forbids |
| LHS of L0 vs. the $n\ge12$ clause | equivalent (given attainment at $S^{n/2}\times S^{n/2}$) | **inconsistent**, the conjecture predicts $M(n)=\Theta_n\ne\theta_0(n)$ |

**Against Problem P as posed** in [README.md](../README.md), *"the cubic form $P(W)$, restricted to $W$ of norm $1$, is maximized on the Weyl tensor of products of spheres when $n\ge12$"*, the same split appears: the value at the best product is $\Theta_n$, so at odd $n$ Problem P asserts $M(n)=\Theta_n$ and L0's LHS asserts $M(n)=\theta_0(n)$. **The two statements the lemma's heading identifies contradict each other at odd $n$.** This is the consequential failure the brief anticipated: the equivalence's arithmetic is sound at even $n$ while the identification is what breaks.

**Where the mis-definition comes from.** [conventions.md:18](../findings/conventions.md) glosses $\theta_0(n)$ as *"the value at the balanced sphere product"* and then pins it to $2(n-1)(n-2)/n^2$. Those two clauses disagree at odd $n$, and line 19 of the same table records the correct odd-$n$ value under $\Theta_n$. **The glossary contradicts itself one row apart**, and L0 inherits the wrong half. That is a second defect, in [conventions.md](../findings/conventions.md) rather than in L0, and it should be fixed at the same time or the error will regrow.

---

## 4. The remaining brief items, each clean

### 4.1 The constraint-surface step (brief item 3), correct object, unwritten condition

$P$ is a homogeneous cubic and $g(W)=\lVert W\rVert^2$ is a smooth quadratic. The block invokes "a maximum of a smooth function on a smooth constraint surface is a critical point **of the restriction**", and the RHS of the biconditional quantifies over "critical points of $P|_{\lVert W\rVert=1}$". **The object is the right one**, critical points of $P$ itself are $\{Q(W)=0\}$, a different and much smaller set, and the block never conflates them.

The Lagrange condition is never written down, which costs the block the sharpest form of its own claim. Explicitly: the record has $\nabla P=3Q(W)$ ([fence-posts.md:285](../findings/fence-posts.md)), so $W\in\mathrm{Crit}$ iff $3Q(W)=\mu W$, and Euler's identity $\langle\nabla P(W),W\rangle=3P(W)$ on the unit sphere pins $\mu=3P(W)$. Hence

$$W\in\mathrm{Crit}\iff Q(W)=\theta W\ \text{with}\ \theta=P(W).$$

That is *verbatim* the form Conjecture A is stated in, and writing it would have made the constant mismatch of §3 visible on the page. **No error here; an omission that concealed one.**

### 4.2 Smoothness and non-degeneracy (brief item 4), both hold

$\mathcal W_n$ is a finite-dimensional real inner-product space, $\dim\mathcal W_n=\frac{n(n+1)(n+2)(n-3)}{12}$ ([problem.md:156](../findings/problem.md)), which is $1638$ at $n=12$ and positive for every $n\ge4$. So $\mathcal W_n\ne\{0\}$ throughout the range and $\mathcal S\ne\emptyset$. $\nabla g(W)=2W\ne0$ on $\mathcal S$, so $1$ is a regular value and $\mathcal S$ is a smooth compact embedded hypersurface; $P$ is a polynomial, hence smooth. **Attainment and criticality of the maximiser are both sound.** The block's three-line compactness argument is correct for what it proves, which is $M(n)\le\theta_0(n)$, per §1.2.

### 4.3 The scope conditions (brief item 5)

| condition | verdict |
|---|---|
| **Value, not maximiser** | **Genuine clarification.** What it excludes is *uniqueness* of the maximiser, which the published non-strict $\le$ indeed does not assert. It does not over-narrow: since $W^{\mathrm{crit}}_{\mathrm{sym}}\in\mathcal S$, "$M(n)$ equals the value at the balanced product" and "the balanced product is *a* maximiser" are equivalent, so the value reading loses nothing of Problem P except rigidity. |
| **$n\ge12$ clause alone** | **Genuine clarification, and its supporting arithmetic checks.** The published hypothesis is the disjunction "$n\ge12$ **or** ($8\le n\le11$ and $W\notin SO(n)\cdot W_{\mathbb{CP}^2}$)", which is a conjunction of two implications; an $n\ge12$ statement cannot imply the second. The live content claimed is right: $\theta_0(10)^2=\frac{2\cdot9\cdot8}{100}=\frac{36}{25}=1.44<\frac32=P(W_{\mathbb{CP}^2})^2$, so without the $\mathbb{CP}^2$ removal the low-dimensional clause is false. |
| **Balanced split** | **Correct as a statement about splits, and it is the condition that breaks the lemma.** See §2.2. $\theta_{5,7}^2=264/175$ and $\theta_{6,6}^2=55/36=\theta_0(12)^2$ both verified. |

**None of the three is a narrowing that changes the claim in the direction of hiding a defect**, they narrow honestly. The defect is in the displayed constant, which no condition touches.

### 4.4 Provenance, clean, for the first time in this series

The brief records six-for-six false self-history notes. **This block's are true.**

- *"Verdict `GAP`, round L00, verifiers v1–v5"*, [ROUND_L00.md](../verification/ROUND_L00.md) Phase 6 returns exactly `GAP` with reviewers v1–v5. ✔
- *"each supplied by the round rather than by the original"*, the three conditions map one-to-one onto the round's majority findings **F3** (value not uniqueness), **F2** ($n\ge12$ clause alone, with the same $36/25<3/2$ figure), **F5** (balanced beats every split). ✔
- *"The proof below is unaudited and the result is re-queued"*, Phase 6: *"The repair is a new result and is not blessed by this round. L00 returns to tier 0 of plan-verification.md unchecked."* ✔
- The single link `[L00](../verification/ROUND_L00.md)` resolves.
- `git log -S` places the scope-condition text in `b8d3d5a9` alongside `reviews/ROUND_L00.md` (later moved to `verification/`), so the citation is not retro-dated.

### 4.5 Does the block's own file already settle it?, **yes, 390 lines above**

[problem.md:68](../findings/problem.md) reads:

> *"The criterion gives $P(W)\le\theta_0(n)$ at every $n$, but $\theta_0$ is attained by $S^{n/2}\times S^{n/2}$ **only when $n$ is even**. At odd $n$ the best sphere product gives $\frac{2(n-1)(n-3)}{(n-2)(n+1)}<\theta_0(n)^2$ … So this is the Conjecture A **bound**, sharp at even $n$."*

That is this review's §2, already on the page, in the same file, under Reviewer 89's name. [graded-half.md:130](../findings/graded-half.md) says it again with the $n=13$ figures ($120/77$ against $264/169$), and [conventions.md:19](../findings/conventions.md) carries the odd-$n$ value in the glossary row directly below the one L0 relied on. **Three independent statements of the counterexample were on the record before the block was written.**

### 4.6 The round raised this and lost it

[ROUND_L00.md](../verification/ROUND_L00.md) Phase 2 lists **F8 (*"the computation covers even $n$ only"***) as a MINORITY finding with support 1, and Phase 3 records *"Not run"*: F8 was transferred to the L57 round on the ground that it attacked Material B, which F1 had shown was not L0's argument. **The transfer was procedurally reasonable and substantively wrong.** One verifier had the defect; the clustering routed it to a different result because of *where it was found* rather than *what it said*, and Phase 5 then wrote the even-$n$ constant into the repaired statement without ever answering it. This is worth recording as a process finding: a parity observation is about a *constant*, and a constant belongs to whichever statement displays it.

### 4.7 Hedges

- *"the criticality hypothesis, **for free**, by compactness"*, this one survives. Given the equivalence with the correct constant, knowing the bound on $\mathrm{Crit}$ does deliver it on all of $\mathcal S$, which is what [Nienhaus 4.19](../findings/problem.md) buys at the cost of assuming Conjecture A. The dismissal of the localisation theorem is fair on the $\le$ half, which is the half 4.19's use needs.
- *"every quantitative obstruction **survives intact** on the smaller set"*, unsupported, and no argument is offered. Restricting the domain weakens, rather than preserves, a statement of the form "no bound below $c$ can hold on $X$"; whether the record's fence posts transfer to $\mathrm{Crit}$ is a claim about each fence post, not a corollary of the reduction. Flagged as rhetoric, not as a load-bearing error.

---

## 5. What is owed, and whether it is reachable

**Reachable in full, and the repair is short.**

1. **Replace the constant.** State L0 with $\Theta_n=P(W^{\mathrm{crit}}_{\mathrm{sym}})$, the value at $S^{\lceil n/2\rceil}\times S^{\lfloor n/2\rfloor}$, i.e. $\theta_0(n)$ at even $n$ and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$, in **both** sides of the biconditional. With that substitution both sides become exactly the $n\ge12$ clause and §2.3's contradiction dissolves.
2. **Supply the missing inequality.** Add the sentence the proof lacks: $M(n)\ge\Theta_n$ because $W^{\mathrm{crit}}_{\mathrm{sym}}\in\mathcal S$ and $P(W^{\mathrm{crit}}_{\mathrm{sym}})=\Theta_n$, the value being [L57](../findings/problem.md)'s closed form at $p=\lceil n/2\rceil$. This is the one step that is genuinely needed and genuinely absent, at *both* parities.
3. **Write the Lagrange condition.** $Q(W)=\theta W$, $\theta=P(W)$, as in §4.1, it matches the published form and makes the constant auditable on sight.
4. **Fix [conventions.md:18](../findings/conventions.md).** The gloss *"the value at the balanced sphere product"* is false at odd $n$; $\theta_0(n)$ is the *cone-invariance* constant of [L43](../findings/problem.md), which coincides with the sphere-product value only at even $n$. Until that row is corrected, the same substitution error is available to every future block.

**None of this requires computation.** The exact-rational screen in §2.1 confirmed hand algebra and is reported as a screen, not as evidence.

**Nothing downstream is broken by the repair at even $n$**, which is where the record's dependents live: [ROUND_L00.md](../verification/ROUND_L00.md) Phase 4 lists three citations, all in [report/](../report/), and all three use only the $\le$ half at $n\ge12$ with the sphere-product constant. **The exposure is to any statement that reads L0 at odd $n$**, and to [findings/INDEX.md:18](../findings/INDEX.md), which records *"Conjecture A on every compact symmetric space (PROVED for all $n\ge12$), $\theta\le\theta_0(n)$, equality exactly at $S^{n/2}\times S^{n/2}$"*: the equality clause there is even-$n$ only, as [graded-half.md:130](../findings/graded-half.md) itself states, and the index row does not say so.
