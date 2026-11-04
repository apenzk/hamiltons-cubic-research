# Review r591, Lemma L0, the identification of Problem P with Conjecture A

*Review number taken: **r591**. Highest report on disk before this one was [REVIEW_r590.md](REVIEW_r590.md); r592 is allocated to the second reviewer on the identical brief.*

**Verdict: `REFUTED`.** The block's constant is the wrong one at odd $n$. The published Conjecture A bounds $P$ by the value of the *balanced sphere product*, $P(W^{\mathrm{crit}}_{\mathrm{sym}})$, and that value is $\theta_0(n)$ only when $n$ is even. At odd $n\ge13$ the block's biconditional is not Conjecture A, it **implies the negation of** Conjecture A at that $n$, unconditionally. Witness $n=13$: $\theta_0(13)^2=\tfrac{264}{169}$ against the balanced product's $\tfrac{120}{77}$.

Separately, and at every $n$: the $(\Leftarrow)$ direction as written proves $\sup\le\theta_0(n)$, never $\sup=\theta_0(n)$. The missing half is never supplied.

---

## 1. What the published conjecture actually says

Quoted from the source extraction, [references/nienhaus-2023-second-best-einstein/](https://arxiv.org/abs/2311.02404), the Conjecture A block (p. 2 of the paper):

> **Conjecture A.** Let $W\in\mathrm{Weyl}_n$ be a unit Weyl curvature operator that is a critical point of $P(R)=\langle R^2+R^\#,R\rangle$ among $\mathrm{Weyl}^1_n=\{W\in\mathrm{Weyl}_n\mid\lVert W\rVert=1\}$. If either $n\ge12$ or $8\leqslant n\leqslant11$ and $W\notin SO(n).W_{\mathbb{CP}^2}$, we have
> $$P(W)\leqslant P(W^{\mathrm{crit}}_{\mathrm{sym}}).$$
> Here, we denote by $R^{\mathrm{crit}}_{\mathrm{sym},n}=R^{\mathrm{crit}}_{\mathrm{sym}}$ the curvature operator of $S^{\lceil\frac n2\rceil}\times S^{\lfloor\frac n2\rfloor}$ endowed with its symmetric Einstein metric and by $W^{\mathrm{crit}}_{\mathrm{sym}}=\big(R^{\mathrm{crit}}_{\mathrm{sym}}\big)_W$ its unit Weyl curvature operator.

**The bound is a value, and the value is named by a manifold, not by a formula.** It is $\theta_{\lceil n/2\rceil,\lfloor n/2\rfloor}$ (the record's $\Theta_n$) and $\theta_0(n)$ is the *even-$n$ evaluation* of it. [Notes.md](../references/nienhaus-2023-second-best-einstein/notes.md) truncates the quotation exactly before the display, which is why the block could be written without the discrepancy showing.

## 2. The two values, and the gap between them

From the block's own formula, $\theta_{k,l}^2=2\frac{n-1}{n-2}\big(1-\frac{n-1}{kl}\big)$, at $k=\lceil n/2\rceil$, $l=\lfloor n/2\rfloor$:

- **$n$ even.** $kl=n^2/4$, so $\theta_{k,l}^2=\frac{2(n-1)}{n-2}\cdot\frac{n^2-4n+4}{n^2}=\frac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2$. The block's constant is correct here.
- **$n$ odd.** $kl=\frac{n^2-1}4$, so $\theta_{k,l}^2=\frac{2(n-1)}{n-2}\cdot\frac{n^2-4n+3}{n^2-1}=\frac{2(n-1)(n-3)}{(n-2)(n+1)}=\Theta_n^2$, which is **not** $\theta_0(n)^2$.

**The inequality is strict at every odd $n\ge4$, by one line.**

$$\frac{\Theta_n^2}{\theta_0(n)^2}=\frac{n^2(n-3)}{(n+1)(n-2)^2}=\frac{n^3-3n^2}{n^3-3n^2+4}<1 .$$

The denominator exceeds the numerator by exactly $4$, at every $n$, and is positive for $n\ge4$. So $\Theta_n<\theta_0(n)$ strictly, with the gap closing as $n\to\infty$ but never vanishing.

*Screened exactly (rationals, seconds, on objects constructed for the screen, not offered as evidence for anything positive):* $n=13$ gives $\tfrac{264}{169}=1.562130$ against $\tfrac{120}{77}=1.558442$; $n=15$, $\tfrac{364}{225}$ against $\tfrac{21}{13}$; $n=17$, $\tfrac{480}{289}$ against $\tfrac{224}{135}$; $n=25$, $\tfrac{1104}{625}$ against $\tfrac{528}{299}$. Equality at $n=12$ and $n=14$. The hand argument above is the claim; these are only a check on my arithmetic.

## 3. The refutation, in the form that needs no hypothesis

Write $M(n)=\max\{P(W):\lVert W\rVert=1\}$ and let $C(n)$ be the block's right-hand side, "$P\le\theta_0(n)$ at every critical point of $P|_{\lVert W\rVert=1}$". Fix an **odd** $n\ge13$ and suppose the block's biconditional holds at that $n$. Two cases, and both refute Conjecture A there:

| case | consequence |
|---|---|
| $C(n)$ **fails** | some critical point has $P>\theta_0(n)>\Theta_n=P(W^{\mathrm{crit}}_{\mathrm{sym}})$, Conjecture A's $n\ge12$ clause is false at $n$ |
| $C(n)$ **holds** | the biconditional gives $M(n)=\theta_0(n)$; the maximiser is critical and carries $P=\theta_0(n)>\Theta_n$, Conjecture A's $n\ge12$ clause is false at $n$ |

**So at every odd $n\ge13$, the biconditional as stated implies $\lnot$Conjecture A$(n)$.** The block asserts the biconditional *and* asserts that each side is the $n\ge12$ clause of Conjecture A. Those two assertions are jointly inconsistent at odd $n$, and the inconsistency needs nothing conjectural to see.

Read the other way round (assuming the programme's target rather than refuting it), the failure is a plain counter-instance to the biconditional: if Conjecture A holds at $n=13$ then $M(13)=\Theta_{13}<\theta_0(13)$, so the left side is **false** while the right side, being a strictly weaker bound, is **true**. Right-to-left fails with $n=13$ as the witness.

**Each side is separately mis-identified, and in opposite directions.**

- The **right-hand side** is strictly *weaker* than Conjecture A's $n\ge12$ clause at odd $n$: it permits critical points anywhere in $(\Theta_n,\theta_0(n)]$, which the conjecture forbids.
- The **left-hand side** is *incompatible* with it at odd $n$: it asserts a maximum strictly above the value the conjecture names as the maximum.

## 4. The two directions, taken separately

**$(\Rightarrow)$ is trivial and correct.** If $\sup=\theta_0(n)$ then $P\le\theta_0(n)$ on the whole unit sphere, hence at critical points in particular. No compactness, no criticality, no smoothness is used. The block says so and is right.

**$(\Leftarrow)$ is where the content is, and it is short by exactly one half.** The block's chain is: $\mathcal W_n$ finite-dimensional $\Rightarrow$ the unit sphere is compact $\Rightarrow$ $P$ attains its maximum at some $W_{\max}$ $\Rightarrow$ $W_{\max}$ is a critical point of the restriction $\Rightarrow$ $P(W_{\max})\le\theta_0(n)$. Every step of that is sound. **What it delivers is $\sup\le\theta_0(n)$.** The block then writes *"and $P(W_{\max})$ is the supremum"* and treats the conclusion as $\sup=\theta_0(n)$, but $P(W_{\max})$ being the supremum is what makes the bound $\le$; it does not produce $\ge$.

**$\sup\ge\theta_0(n)$ is established nowhere in the block, and nowhere in the file for odd $n$.** It needs a witness: a unit Weyl operator with $P=\theta_0(n)$.

- At **even** $n$ the witness exists and is on the record, [Lemma L57](../findings/problem.md)'s attainment formula $\theta(S^p\times S^q)^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ at $p=q=n/2$, and Nienhaus Proposition 2.25 independently. The block never cites it, so the proof is incomplete even where the statement is true.
- At **odd** $n$ **no witness is known, and the natural candidates all fall short**: the balanced product gives $\Theta_n<\theta_0(n)$ by §2, and padded $W_{\mathbb{CP}^2}$ gives $\sqrt{3/2}$, which is below $\theta_0(n)$ for every $n\ge12$ (the crossover being $n^2-12n+8=0$, i.e. $n>6+2\sqrt7\approx11.29$, this file's own $n\ge12$ necessity paragraph). So the left-hand side is not merely unproven at odd $n$; asserting it asserts the existence of a non-sphere-product operator strictly beating every sphere product.

## 5. The block's own file settles it, 389 lines above the block

[problem.md:68](../findings/problem.md), *"Sharpness at even $n$ only"*, credited to Reviewer 89:

> $\theta_0$ is attained by $S^{n/2}\times S^{n/2}$ **only when $n$ is even**. At odd $n$ the best sphere product gives $\frac{2(n-1)(n-3)}{(n-2)(n+1)}<\theta_0(n)^2$ … So this is the Conjecture A **bound**, sharp at even $n$.

That paragraph is the refutation of the block, written into the same file, and it even names the right relationship, $\theta_0(n)$ is *a* bound implied by the cone criterion, sharp only at even $n$, rather than *the* conjectured maximum. [graded-half.md:130](../findings/graded-half.md) says it a third time with the same witness: *"For odd $n$ the best split falls strictly below, at $n=13$, $\theta^2=\tfrac{120}{77}$ against $\theta_0^2=\tfrac{264}{169}$."*

**This is the fifteenth time on this programme that the answer was in the block's own file.** It also means round L00's five verifiers, working from a brief that withheld the record, could not have seen it, the minority finding F8, *"the computation covers even $n$ only"*, is the same observation reaching for the same defect, and it was routed to the L57 round as a Material B question rather than kept as an L0 question. **F8 belonged here.** Its transfer is the mechanism by which the defect survived the round.

## 6. The constraint-surface step

Stated explicitly, since the block compresses it. $P(W)=T(W,W,W)$ for the symmetric trilinear $T(X,Y,Z)=\langle X,B(Y,Z)\rangle$, so $\nabla P=3Q(W)$ on $\mathcal W_n$. The constraint $g(W)=\lVert W\rVert^2$ has $\nabla g=2W$, nonvanishing on $g^{-1}(1)$, so the unit sphere is a **regular** level set and hence a smooth embedded hypersurface of $\mathcal W_n$. Lagrange gives

$$3Q(W)=2\mu W\quad\Longrightarrow\quad Q(W)=\theta W,\qquad \theta=\langle W,Q(W)\rangle=P(W)\ \text{ at }\lVert W\rVert=1,$$

which is [conventions.md](../findings/conventions.md)'s definition of a critical point, so the block's "critical point" and the record's agree.

**The block uses the right object.** It says *"a maximum of a smooth function on a smooth constraint surface is a critical point of the restriction"*, and the right-hand side of the biconditional quantifies over critical points of $P|_{\lVert W\rVert=1}$. Both are the restriction. This matters, because $W_{\max}$ is emphatically **not** a critical point of $P$ on $\mathcal W_n$, there $\nabla P=3\theta W\ne0$ whenever $\theta\ne0$, and $\theta>0$ at the maximiser since $P(-W)=-P(W)$ makes $\sup\ge0$, with $M(n)\ge\sqrt{3/2}>0$ on the record. **No defect here.** It is the one step of the proof that is both non-trivial and correctly executed.

*One residue, inherited rather than new.* $\nabla P=3Q(W)$ needs $T$ fully symmetric, and this file's [Critical-point structure](../findings/problem.md) section at line 112 still justifies that by $\mathop{\mathrm{tr}}(XYZ)=\mathop{\mathrm{tr}}(ZYX)$ alone, which covers the $W^2$ half and not the $W^\#$ half. That is round L00's finding F6, recorded as `CONTAINED` and still uncorrected in the file. L0 itself does not consume it, since its right-hand side is phrased intrinsically.

## 7. Smoothness and non-degeneracy

**Both hold at every $n\ge12$, and the block argues neither.**

- $\dim\mathcal W_n=\frac{n(n-3)(n+1)(n+2)}{12}$ ([conventions.md](../findings/conventions.md)), which is $1638$ at $n=12$ and increasing, so $\mathcal W_n\ne\{0\}$ and the unit sphere is **nonempty**. The block's compactness sentence is true of the empty set too, and a supremum over an empty set is $-\infty$; the one-line remark is owed and absent. Harmless at $n\ge12$.
- Smoothness is the regular-level-set argument of §6. The block asserts "smooth constraint surface" with no justification. Also harmless, also owed.

Neither is a defect in the mathematics. Both are places where the block asserts what it should state in a clause.

## 8. The three scope conditions, one at a time

| # | condition | verdict |
|---|---|---|
| 1 | the claim is about the **value**, not the maximiser | **genuine clarification, with one wrong sentence attached** |
| 2 | "Conjecture A" means its $n\ge12$ clause alone | **genuine, correct, and correctly motivated** |
| 3 | "products of spheres" means the balanced split | **a narrowing that refutes the block it is attached to** |

**Condition 1.** The published statement is $P(W)\leqslant P(W^{\mathrm{crit}}_{\mathrm{sym}})$, non-strict, with no equality clause, checked against the quotation in §1. So reading it as a rigidity statement is wrong, and saying so is a clarification, not a narrowing. **But its closing sentence is false**: *"it is equivalent to attainment of $\theta_0(n)$"*. Conjecture A is an inequality; attainment is free, because the balanced sphere product is a unit Weyl operator realising the bound, so $M(n)\ge\Theta_n$ holds with no conjecture at all. The correct equivalence is $M(n)=\Theta_n$, and the sentence reaches for $\theta_0(n)$ where $\Theta_n$ belongs, the same substitution that produces the whole defect.

**Condition 2.** Correct, and the check the brief asks for passes. The published conjecture is a genuine conjunction over two disjoint dimension ranges, and no statement quantified over $n\ge12$ can imply a statement about $8\le n\le11$. The low clause carries live content, and the block's own witness holds: at $n=10$, $\theta_0(10)^2=\frac{2\cdot9\cdot8}{100}=\frac{36}{25}=1.44$ against $P(W_{\mathbb{CP}^2})^2=\frac32$, so $W_{\mathbb{CP}^2}$ beats the balanced product there and the exception is not decorative. *One notational hazard: the block writes $\theta_{10}$, which collides with its own $\theta_{k,l}$ split notation two bullets below.*

**Condition 3 is the one that gives the game away.** Its mathematics is right, $\theta_{k,l}^2$ is strictly increasing in $kl$, so the maximum over splits sits at $k=\lceil n/2\rceil$, and the witness $\theta_{5,7}^2=\frac{264}{175}<\frac{55}{36}=\theta_{6,6}^2$ checks out at $n=12$; every sphere product is critical, by Nienhaus Proposition 2.25. **And it says, in the block's own symbols, that the relevant value is $\theta_{\lceil n/2\rceil,\lfloor n/2\rfloor}$**, which the block then never evaluates at odd $n$, where it is not $\theta_0(n)$. The condition supplies precisely the object that refutes the statement it was added to protect, and stops one substitution short of noticing.

**On the shared framing "supplied by the round rather than by the original".** Checked, and **true**, the rare one. [ROUND_L00.md](../verification/ROUND_L00.md) phase 2 carries F3 (value not maximiser, support 5), F2 ($n\ge12$ clause cannot imply the conjunction, support 4, with the same $n=10$ witness) and F5 (balanced beats every split, support 4), and phase 5 records them as narrowings written into the block. The three conditions are those three findings.

## 9. Provenance and pointers

| claim in the block | check | result |
|---|---|---|
| *"Verdict `GAP`, round L00, verifiers v1–v5"* | [ROUND_L00.md](../verification/ROUND_L00.md) phase 6 and the phase-1 table | **true** (3 `GAP`, 2 `PROVEN), hypotheses corrected`, round verdict `GAP` |
| *"The proof below is unaudited and the result is re-queued"* | [plan-verification.md:17](../plan-verification.md) (*"L00), re-queued: round 1 closed `GAP` and rewrote the block, and the repair is unaudited"* | **true** |
| the three conditions "supplied by the round" | §8 above | **true** |
| the only link in the block, to [ROUND_L00.md](../verification/ROUND_L00.md) | file exists | **resolves** |

**Four provenance notes, four true.** That breaks the run of six false ones the brief records, and it is worth saying plainly: this block's self-description is honest. The defect is in the mathematics, not in the history.

**The heading's promise.** The heading is *"problem p and conjecture a are the same statement"* (an unqualified identity) while the block delivers a biconditional between two $n\ge12$ statements, under three narrowings, one of which fails at odd $n$. [results.md:764](../results.md) already carries the corrected reading of a neighbouring over-claim (*"the problem $P$ and Conjecture A are **related** through the cone bridge"*), and [LEDGER.md:716](../findings/LEDGER.md) records the earlier round of exactly this over-reading. **The heading is the same over-reading, one level up, still standing.**

**Hedging clauses.** The block carries none of the brief's watch-list words. Its one soft phrase is *"a definitional reduction"* in the closing paragraph, and that is accurate: the equivalence does move a quantifier and nothing more.

## 10. What is owed, and whether it is reachable

**Reachable, immediately, and the repair strengthens the result.** Replace the constant by the conjecture's own object throughout. For every $n\ge12$:

$$\max\{P(W):W\in\mathcal W_n,\ \lVert W\rVert=1\}=\Theta_n\quad\Longleftrightarrow\quad P(W)\le\Theta_n\ \text{at every critical point of }P|_{\lVert W\rVert=1},$$

with $\Theta_n=\theta_{\lceil n/2\rceil,\lfloor n/2\rfloor}$, equal to $\theta_0(n)$ at even $n$ and to $\sqrt{\frac{2(n-1)(n-3)}{(n+1)(n-2)}}$ at odd $n$. The right-hand side is then **literally** Conjecture A's $n\ge12$ clause, character for character against §1's quotation. The proof needs three lines and one added citation:

1. $(\Rightarrow)$: a bound at the maximum is a bound everywhere below it. Unchanged.
2. $(\Leftarrow)$, upper half: compactness, attainment, criticality of the maximiser, the block's existing argument, unchanged, giving $\max\le\Theta_n$.
3. $(\Leftarrow)$, **lower half, currently missing**: $W^{\mathrm{crit}}_{\mathrm{sym}}$ is a unit Weyl operator with $P=\Theta_n$, so $\max\ge\Theta_n$. Cite [Lemma L57](../findings/problem.md)'s attainment formula, or Nienhaus Proposition 2.25, either of which is on the record for **both** parities.

Three further edits fall out of it, and all three are one-line:

- **[conventions.md](../findings/conventions.md) defines $\theta_0(n)$ as "the value at the balanced sphere product"**, which is false at odd $n$ by §2, the same substitution, in the file whose whole purpose is that conventions are quoted rather than restated. The row should read *the even-$n$ balanced value, and the cone-criterion bound at every $n$*, which is what [problem.md:68](../findings/problem.md) already says of it.
- The block's condition 1 loses its final clause, *"equivalent to attainment of $\theta_0(n)$"*, per §8.
- The heading drops to what is proved: the $n\ge12$ clause of Conjecture A is equivalent to a statement about the maximum value.

**What the repair costs the programme: nothing at even $n$, and it makes the odd-$n$ target visible.** Every result on the record that consumes $\theta_0(n)$ as an *upper bound*, [Lemma L43](../findings/problem.md)'s cone collapse above all, is untouched, because $\theta_0(n)$ genuinely is what the $a=0$ criterion demands at every $n$, and $\Theta_n\le\theta_0(n)$ means that bound is simply not sharp at odd $n$. What changes is that the odd-$n$ half of Conjecture A is now visibly **strictly stronger** than the cone bridge delivers, by the margin $\theta_0(n)-\Theta_n$, and no argument that closes at $\theta_0(n)$ will close it.

---

## Summary of findings

| # | finding | class |
|---|---|---|
| **1** | Conjecture A's bound is $P(W^{\mathrm{crit}}_{\mathrm{sym}})=\Theta_n$, not $\theta_0(n)$; the two differ at every odd $n$ | **REFUTES** the identification |
| **2** | At odd $n\ge13$ the biconditional implies $\lnot$Conjecture A$(n)$, unconditionally; witness $n=13$ | **REFUTES** the statement |
| **3** | $(\Leftarrow)$ proves $\sup\le\theta_0(n)$; the block reads it as $=$. The witness for $\sup\ge$ is never supplied, at either parity | **GAP**, fatal at odd $n$, repairable at even $n$ |
| **4** | Condition 1's closing clause, "equivalent to attainment of $\theta_0(n)$", is false, attainment is unconditional, and at $\Theta_n$ | defect in a scope condition |
| **5** | Condition 3 names $k=\lceil n/2\rceil$ and never evaluates it at odd $n$, supplying the object that refutes the block | the near-miss |
| **6** | [conventions.md](../findings/conventions.md) defines $\theta_0(n)$ as the balanced-product value, false at odd $n$ | spread, one row |
| **7** | [problem.md:68](../findings/problem.md) and [graded-half.md:130](../findings/graded-half.md) already carry the refutation; round L00's F8 reached for it and was transferred away | the defect was visible and mis-routed |
| **8** | The heading promises an unqualified identity the block does not deliver | over-claim, live |
| **9** | Nonemptiness of $\mathcal W_n$ and smoothness of the constraint surface are asserted, not argued | owed clauses, both true at $n\ge12$ |
| **10** | Four provenance claims checked, four true | **no defect** |
| **11** | The Lagrange step is correct and applied to the right object, $P|_{\lVert W\rVert=1}$ | **no defect** |

**No computation was performed beyond an exact-rational screen of four values in §2, constructed for that screen and reported as one.** Nothing in this report rests on it; §2's one-line ratio argument is the proof.
