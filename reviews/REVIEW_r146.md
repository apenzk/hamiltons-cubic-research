# Gate 2, reviewer r146

Cold adversarial review of the four claims in the brief. Everything below is derived from the definitions and from numbers already in the record; nothing was recomputed.

**Headline.** The $n^2$ fence post's *conclusion* is right, its *stated mechanism* is wrong, and its extension to "every localizing order" is not established, it covers one principal minor of the order-$k$ matrix and misses exactly the minors where the mechanism does not apply. The falsification is real and is **not** scoped by $n=5$; on the record's own value table the witness exists at every $n\ge4$, which removes the "restrict to $n\ge12$" escape the plan is holding open. The fusion-rule tension is **relabelled, not resolved**, and it is settled on paper by a law two sections down in the same file. The third moment's out-of-sample check is **degenerate at exactly the dimension it was run at**, and the constraint it yields is dominated by a one-line bound.

---

## 1. The fence post (6fecf17, cd2cd1a)

### 1a. The corrected algebra is right, checked symbolically

The bracket correction in cd2cd1a reproduces exactly. With $S_2=\kappa_n/\theta^2$, $\kappa_n=(n-1)(2n-1)/4$ and $S_3=\big((n^2-1)b-(5n-1)\theta\big)/(8\theta^3)$,

$$\tfrac12(S_2-1)-(S_3-1)+\ldots\;\Rightarrow\; \tfrac{S_2}2-S_3=\frac{\theta\big[(n-1)(2n-1)+(5n-1)\big]-(n^2-1)b}{8\theta^3}=\frac{(n+1)\big[2n\theta-(n-1)b\big]}{8\theta^3},$$

since $(n-1)(2n-1)+(5n-1)=2n^2+2n=2n(n+1)$. That is the recorded bracket verbatim. Substituting $b=\theta-a$ gives leading order $n^2(\theta+a)/(8\theta^3)$, and with $N\sim n^4/12$, $S_2\sim n^2/(2\theta^2)$ the ratio is $n^2\theta(\theta+a)/48$, again as recorded. **The commit's arithmetic is correct and the earlier $\mathrm{LHS}\sim NS_2$ intermediate was indeed wrong.**

One unstated hypothesis: the leading term is $\theta+a$, so the argument needs $a=\operatorname{tr}(W^3)$ bounded away from $-\theta$. That is safe at the recorded points ($a\to0$, $b\to\theta$), but it is a hypothesis, not a fact about an unknown maximiser.

### 1b. The stated mechanism, "$n^4$ degrees of freedom against $n^2$ of moment data", is the wrong measure, and a correct one-line mechanism replaces it

**The dimension count is not what a moment method must separate.** A moment method has to separate two sets of *admissible moment vectors*, those compatible with $\theta\le\theta_0(n)$ from those with $\theta>\theta_0(n)$. The fibre dimension of the moment map is irrelevant to whether a low-dimensional projection separates two sets; a map with enormous fibres separates perfectly well if the two target sets are disjoint in the image. So "$n^4$ dof against $n^2$ data" is an information heuristic and licenses no conclusion. It is also the wrong count twice over: $S_2$ is not free data but pinned exactly, $S_2=\kappa_n/\theta^2$, so the moment vector is a *function of $\theta$* and not a summary of $N$ unknowns at all.

**The correct mechanism is one line and needs no dimension count.** Directly from the determinant condition, with $c=\tfrac12$,

$$\frac{\mathrm{LHS}}{\mathrm{RHS}}=\frac{\big[\tfrac{N-1}2+1\big]\big[\tfrac{S_2-1}2-(S_3-1)\big]}{(S_2-\tfrac12)^2}\;\approx\;\frac{(N/2)(S_2/2)}{S_2^2}=\frac{c^2\,N}{S_2}=\frac{c^2}{\overline{\lambda^2}},$$

where $\overline{\lambda^2}=S_2/N$ is the mean-square eigenvalue of $L_e$. Since $\operatorname{tr}L_e^2=\kappa_n/\theta^2=\Theta(n^2)$ spread over $N=\Theta(n^4)$ eigenvalues, the RMS eigenvalue is $\Theta(1/n)$. **A support constraint at the fixed threshold $c=\tfrac12$ is therefore slack by the factor $c^2/\overline{\lambda^2}=\Theta(n^2)$, the spectrum lives at scale $1/n$ and the fence is at $1/2$.** That is the whole content, it recovers the recorded exponent and the observed growth, and it is immune to the objection in the previous paragraph because it never counts degrees of freedom.

This also survives the record's own caveat. A $\Theta(n^2)$-multiplicity block at $-\tfrac12$ (25 of 84 at $S^3\times S^3$) leaves $N-\Theta(n^2)=\Theta(n^4)$ eigenvalues in the bulk, so $\overline{\lambda^2}=\Theta(n^{-2})$ regardless.

### 1c. "Every localizing order" is NOT established, it covers one minor

The order-$k$ determinant scaling in cd2cd1a is arithmetically fine: with $m_0\sim n^4$ and $m_{j\ge2}\sim n^2$, the $(k{+}1)\times(k{+}1)$ determinant has leading term $A_{00}\det(\text{lower }k\times k)\sim n^{4+2k}$ against competing $n^{2k+2}$. But **PSD at order $k$ is not one determinant.** It is every principal minor, and the principal submatrix indexed by $\{1,\dots,k\}$ (entries $c\,m_{i+j}-m_{i+j+1}$, $i,j\ge1$), **contains no $m_0$ at all.** Every entry is $\Theta(n^2)$, so that minor is $n^2$ times a matrix of $O(1)$ shape: it is scale-invariant in $n$ and its slack ratio does **not** grow. It is a legitimate constraint (the localizing matrix of $(c-\lambda)\lambda^2$, nonnegative on the support), and it is precisely where the $m_0\sim n^4$ dilution (the entire mechanism), is absent.

So the extension is (i) a re-indexing of the same $m_0$ dilution and (ii) an incomplete case analysis. **"Ratio $n^2$ at every $k$" is false as a statement about the order-$k$ PSD conditions; it is true of the full determinant only.** The commit's headline "extended to every localizing order" and plan.md's "the full moment problem, closed" both overstate what was shown.

A related detail the record gets right without saying why: $m_{j\ge2}\sim n^2$ for *every* $j$, including large $j$ where a uniform-scale bulk would give $m_j\sim n^{4-j}$. The reason is that $\operatorname{mult}(\tfrac12)\ge\dim\mathcal O=\Theta(n^2)$, so a $\Theta(n^2)$ block sits *at the support boundary* and contributes $\Theta(n^2)2^{-j}$ to every moment. Worth stating, because it is what makes the sub-minor above informative rather than empty.

### 1d. A related overclaim inside the same paragraph

*"What the method would need is a lower bound on $\operatorname{mult}(\tfrac12)$, which is equivalent to Conjecture A itself."* This is asserted, not derived, and looks false. From $S_2\ge1+p/4$ with $p=\operatorname{mult}(\tfrac12)$ one gets $\theta^2\le\kappa_n/(1+p/4)$, so $\theta\le\theta_0$ needs $p\ge4(\kappa_n/\theta_0^2-1)\sim n^2$ against a maximum available orbit dimension $\binom n2\sim n^2/2$, a factor of about two short, which is the same factor $2.2$ the record records elsewhere. That is a *different and stronger* statement than Conjecture A (it demands $\tfrac12$-eigenvectors of non-group origin at roughly twice the orbit dimension), not an equivalent one.

---

## 2. The falsification (c96d9c0)

### 2a. It falsifies the stated target, and it is not a strawman

The target was *$W$ ungraded and critical $\Rightarrow\lambda_{\max}(L_e|_{W^\perp})\ge c>\tfrac12$*. A single ungraded critical point with $\lambda_{\max}=\tfrac12$ kills it. Padded $W_{\mathbb{CP}^2}$ is ungraded on the record's own evidence ($[\mathfrak h,\mathfrak m]\to\mathfrak h$ leaking at $4.0$, isotropy $\mathfrak u(2)\oplus\mathfrak{so}(4)$ not the fixed set of an involution). The falsification is real.

### 2b. $n=5$ does NOT scope it, the record's own index says the witness exists at every $n\ge4$

FINDINGS.md's value table reads: *"$\sqrt{3/2}=1.224745$ ($W_{\mathbb{CP}^2}$ **and every padding**), the threshold, $n\ge4$."* If that row is true, padded $W_{\mathbb{CP}^2}$ is critical at $\theta=\sqrt{3/2}$ at every $n\ge4$, including $n\ge12$, and second-order.md uses it as a critical point at $n=8,10,12$ throughout (the $\dim\mathfrak m\le2$ stratum, the $\circ$-indecomposability table, the "sharp case" of the residual). **So the commit's caveat "the witness stands at $n=5$ alone" contradicts the record's index, and the more likely reading is that the commit's $n=6,7$ padded construction is broken, not that the point stops existing.**

That matters, because it removes the escape the plan is holding open. A version of the gap theorem restricted to $n\ge12$ is not saved by "the $n=5$ witness says nothing there": the same tensor is a critical, ungraded point at $n\ge12$. The *only* thing left unknown at $n\ge12$ is whether its $\lambda_{\max}$ rises above $\tfrac12$, and no reason is offered why it should. The honest position is that the restricted target is **unsupported**, not merely unproved.

Countervailing point, stated because it is the strongest version of the scoping objection: $n\le5$ is genuinely exceptional in this algebra (Lovelock syzygy, one independent cubic invariant instead of two), so a coincidence at $n=5$ could in principle be an artefact. That objection is real *if* the witness truly stands at $n=5$ alone. It cannot be both ways: either the record's "every padding, $n\ge4$" row is right and the scoping objection dies, or that row is wrong and a large amount of second-order.md's residual analysis (which treats padded $W_{\mathbb{CP}^2}$ as critical at $n=8,10,12$) needs re-checking. **Recorded as a disagreement with the record that must be resolved either way.**

### 2c. Two internal contradictions the falsification exposes and does not name

1. **The ungraded-margin paragraph is now false and is still in the file unamended.** second-order.md states: *"Ungraded points violate by a wide margin, excess $\tfrac14$ … $\tfrac13$ … $\tfrac12$ … so $\lambda_{\max}\ge\tfrac34$ throughout."* Padded $W_{\mathbb{CP}^2}$ is an ungraded critical point in the same file with $\lambda_{\max}=\tfrac12$. The two paragraphs sit a few sections apart and directly contradict each other.

2. **"$\dim E(\tfrac12)=\dim(\text{orbit})=18$ at $n=8,10,12$" is internally impossible.** The isotropy of padded $W_{\mathbb{CP}^2}$ is $\mathfrak u(2)\oplus\mathfrak{so}(n-4)$, so $\dim\mathcal O=\binom n2-4-\binom{n-4}2$, giving $18,26,34$ at $n=8,10,12$. The same file proves $\dim E(\tfrac12)\ge\dim\mathcal O$. So $\dim E(\tfrac12)=18$ at $n=10,12$ violates a theorem stated two sections earlier. Either the number is a typo carried from $n=8$, or the nondegeneracy claim at $n=10,12$ was never actually measured.

---

## 3. The Peirce table and the "fusion-rule tension" (0a5ea55, 92f0ead)

### 3a. The table's spectrum is corroborated on paper, with no recomputation

At $S^3\times S^3$ ($n=6$, $N=84$) the recorded spectrum $1^{(1)},\tfrac12^{(18)},\tfrac14^{(10)},0^{(30)},(-\tfrac12)^{(25)}$ satisfies:

- multiplicities sum to $84=\dim\mathrm{Weyl}_6$;
- $\sum\lambda^2=1+\tfrac{18}4+\tfrac{10}{16}+\tfrac{25}4=12.375=\kappa_6/\theta_0(6)^2=13.75\cdot\tfrac9{10}$ **exactly**;
- $\sum\lambda^3=1+\tfrac{18}8+\tfrac{10}{64}-\tfrac{25}8=0.28125$, and $\theta^2\sum\lambda^3=\tfrac{10}9(0.28125)=0.3125$, **exactly** the value recorded independently elsewhere in the file.

Two independent identities land on the digit. The eigenvalue block structure is sound; the near-closure percentages remain basis-dependent as flagged.

### 3b. The tension is relabelled, not resolved

92f0ead's resolution is: *"$S^3\times S^3$ is not a maximiser at all ($n=6$ sits below the crossover $6+2\sqrt7$, so padded $W_{\mathbb{CP}^2}$ beats it), hence Krasnov–Tkachev Prop 6.7 does not apply."* **This is a non sequitur.** Prop 6.7's hypothesis is *local* extremality (a third- and fourth-variation condition along the $\tfrac12$-eigenspace); the global crossover says nothing about whether $S^3\times S^3$ is a local maximum. The record concedes this two paragraphs later, *"the explanation offered for the failure is confirmed WRONG … Prop 6.7 uses only local maximality … the global crossover is irrelevant"*, but the commit headline *"the fusion-rule tension is resolved"* stands unretracted, and plan.md still carries the old reading. **Verdict: relabelled.**

### 3c. The three-way contradiction is settled by a law already in the same file

fence-posts.md says the rule *"tracks primitivity"* and that non-primitivity forces $\lambda_{\max}=1>\tfrac12$; the rule fails at $S^3\times S^3$, which has $\lambda_{\max}=\tfrac12$. second-order.md flags all three as irreconcilable and unresolved. They are reconciled by the $\circ$-orthogonal law two sections down:

> every $\circ$-summand lies in $E(1)$, so $\dim E(1)=1$ **proves** $W$ admits no nontrivial $\circ$-splitting.

The table in that same section gives $S^3\times S^3$: $\dim E(1)=1$, *"indecomposable, proved"*. An idempotent that admits no $\circ$-orthogonal splitting **is primitive**. So the rule fails at a *primitive* idempotent, and the first of the record's three branches is the true one: **the rule detects something other than primitivity.** No new computation is needed; the datum was already in the file.

### 3d. What the rule does track, derived rather than fitted

Under the reading the record itself supplies, the rule *is* the third-order test on $A(\tfrac12)$, with orbit directions vanishing automatically, the rule holds **vacuously** whenever $E(\tfrac12)$ is exactly the orbit tangent, and can only fail where $E(\tfrac12)$ carries directions of non-group origin. Against the record's own nondegeneracy data this is a perfect fit:

| point | $\dim E(\tfrac12)$ vs orbit | fusion rule |
|---|---|---|
| $S^3\times S^3$, $n=6$ | $18$ vs $9$, the **only** recorded nondegeneracy failure | fails, $31.9\%$ |
| $S^4\times S^4$, $n=8$ | equal ($16=16$) | holds, $7\times10^{-31}$ |
| $S^2\times S^4$, $n=6$ | equal ($8=8$) | holds, $2\times10^{-30}$ |
| $(S^3)^3$, padded $S^3\times S^3$ | inherit the $n=6$ excess | fail |

**So the invariant is Morse–Bott nondegeneracy of the orbit, not primitivity and not extremality**, and the thirty-orders-of-magnitude separation between $S^3\times S^3$ and $S^4\times S^4$ is explained by an identity rather than by a measurement. This is new to the record; it also means the table's non-extremality caveat is the wrong caveat, the table sits at the one *degenerate* point in the catalogue, which is a stronger reason to recompute elsewhere. (Not tested against the $C_5$ blow-up, whose $\dim E(\tfrac12)$ is not recorded; the "degenerate, twenty excess directions" there refers to the criticality Jacobian, a different object.)

---

## 4. The third moment (88ab8de)

### 4a. The "out of sample" confirmation is degenerate at exactly the dimension used

$$\operatorname{tr}(L_x^3)=-\frac{5n-1}8\langle x^2,x\rangle+\frac{n(n-5)}8\langle x^{\#}x,x\rangle,\qquad\text{fitted on }n=6\ldots9,\text{ checked at }n=5.$$

At $n=5$ the second coefficient is $\tfrac{n(n-5)}8=0$ **identically**. The check therefore exercises only the first term. Worse, $n=5$ is precisely where the record says the two cubic invariants are *not independent* (the Lovelock syzygy, *"the third moment is proportional to $\langle x\circ y,z\rangle$ only at $n=4,5$"*), so even the surviving coefficient is confirmed only in one linear combination. **The coefficient $n(n-5)/8$ (the structurally novel half, and the only part that makes the formula see $b$), has no out-of-sample support at all.** The commit's claim that this is *"a genuine out-of-sample confirmation, which the $\kappa_n$ fit never had"* does not hold; the two fits are in the same epistemic position.

### 4b. The constraint follows, and it is redundant rather than merely loose

The derivation is valid: $\lambda\le\tfrac12\Rightarrow\lambda^3\le\tfrac12\lambda^2$ for all real $\lambda\le\tfrac12$ (negative $\lambda$ trivially, $0\le\lambda\le\tfrac12$ since $\lambda^3=\lambda\cdot\lambda^2$), so $S_3-1\le\tfrac12(S_2-1)$, and the rearrangement to $b\le\big(4\theta^3+4\kappa_n\theta+(5n-1)\theta\big)/(n^2-1)$ is correct.

Its asymptotic content is exactly a factor of two: the right side $\to2\theta$ while $b=\theta-a\to\theta$, since $a=\operatorname{tr}(W^3)\to0$. So the recorded slack "$2.3\times$ at $n=12$" is the asymptotic constant, not an accident of that dimension.

**But it is dominated by a one-line bound.** $|a|=|\operatorname{tr}W^3|\le\|\lambda\|_\infty\sum\lambda^2=\|\lambda\|_\infty$, and the record's own ceiling on $\lambda_{\max}$ over unit-norm $\mathrm{Weyl}_n$ is $\le0.89$ through $n=10$. Hence $b=\theta-a\le\theta+0.9\approx2.14$ at $n=12$, against the moment cap's $2.75$. **The three-moment constraint is strictly weaker than $b\le\theta+\|\lambda\|_\infty$, at the dimension that matters and asymptotically** (cap $\to2\theta\approx2.83$, trivial bound $\to\theta+\|\lambda\|_\infty\lesssim2.4$). It is non-vacuous as a logical statement and redundant as an instrument. *(The one number used here, $\lambda_{\max}\le0.89$, is taken from the record, not computed; the argument could not settle the comparison without a value for $\|\lambda\|_\infty$.)*

---

## Answers to the brief's questions

### (a) Which is load-bearing for item 1, and does item 1 survive?

| claim | bearing on item 1 |
|---|---|
| **Falsification** | **Load-bearing.** It is item 1's stated target. |
| **Fence post** | Load-bearing negatively, it is one of the three "closed methods" in item 1's stall-trigger table. |
| Peirce table | Not load-bearing. Item 1 names it as "the one instrument left", but its own text already records the fusion rule as closed; the table produced no constraint. |
| Third moment | Not load-bearing. It is a corollary of the fence-post thread and does not bite. |

**Item 1 survives as a statement and is worse off than the plan records.** The banner is right that the destination (a maximiser is graded) is untouched, a falsified route is not a falsified theorem. But the plan holds open an escape it should not: *"a version restricted to $n\ge12$ is not refuted."* By §2b, the same ungraded critical point at $\theta=\sqrt{3/2}$ exists at every $n\ge4$ on the record's own index, so the restricted version is unsupported rather than merely unproved, and the burden is now to exhibit a mechanism raising $\lambda_{\max}$ above $\tfrac12$ there. Separately, the plan's "the full moment problem, closed" is stronger than §1c supports.

### (b) Is the $n^2$ fence post a theorem, a heuristic, or a restatement of the dimension count?

**A heuristic with a correct exponent, a wrong mechanism, and an incomplete extension.** Breaking it into pieces:

- The order-one determinant computation is a **correct derivation** (§1a) and is not a restatement, the earlier $NS_2$ route was genuinely wrong and genuinely fixed.
- The *mechanism* offered ($n^4$ dof against $n^2$ of data), **is** essentially the dimension count restated, and it does not support the conclusion (§1b). The real mechanism is $c^2/\overline{\lambda^2}$: the spectrum of $L_e$ lives at scale $1/n$ while the fence is at $\tfrac12$.
- The "every localizing order" extension is **not a theorem** (§1c): it addresses one minor and misses the ones without $m_0$.
- Nothing here is a theorem *about moment methods*. It bounds slack in one family of inequalities; it does not show the full moment problem is feasible for $\theta>\theta_0(n)$, and it does not touch methods that use the pinned data ($1$ simple, $\operatorname{mult}(\tfrac12)\ge\dim\mathcal O$, $S_2=\kappa_n/\theta^2$ as an equality) rather than the localizing hierarchy.

### (c) Anything recorded as new that the record already holds, the fourth re-derivation

**Found, and it is not Fox 1.3.** The fence post re-derives **fence post F6**: *"Spectral moments of $L_W$ are the wrong invariants, the Track A route closed with a quantified negative, $49.7\times$ short at $n=12$."* Since $e=W/\theta$, $\operatorname{spec}(L_e)$ and $\operatorname{spec}(L_W)$ are the same set up to scale, so this is the same object and the same conclusion, requantified. plan.md itself already notes *"a fence post, a retraction and a restoration were written before this was seen; all three described the same failure differently"*, the $n^2$ post is the fourth telling, and it was written without the value table being queried for post F6.

Second instance, smaller: the Peirce-table thread (0a5ea55, 92f0ead) was started after plan.md had already recorded, under item 1, that *"the fusion rule itself is already closed"*; 92f0ead's conclusion (*"matching the record's verdict that it tracks primitivity"*) restates fence-posts.md §"The fusion rule tracks primitivity, not gradedness", and is refuted by §3c above.

**No new Fox 1.3 re-derivation in these four commits.** The third-moment formula is a genuinely different object (a bilinear-in-two-invariants identity, consistent with the record's *"a third universal identity does not exist"*, which concerns the one-invariant form).

---

## Explicit disagreements with the record

1. **second-order.md**, *"it holds at every order of the localizing matrix … ratio $n^2$ at every $k$"*, **overstated**. True of the full determinant only; false for the principal minor omitting index $0$, which carries no $m_0\sim n^4$ entry and no growing slack (§1c).
2. **second-order.md**, *"the spectrum has $\sim n^4/12$ degrees of freedom and each moment supplies one number of size $\sim n^2$"*, **wrong mechanism**. Replace with $c^2/\overline{\lambda^2}$ (§1b).
3. **c96d9c0 / plan.md**, *"the witness stands at $n=5$ alone"*, **contradicts FINDINGS.md's value table** (*"$W_{\mathbb{CP}^2}$ and every padding, $n\ge4$"*) and contradicts second-order.md's use of padded $W_{\mathbb{CP}^2}$ as a critical point at $n=8,10,12$. One of the two is wrong and it must be resolved (§2b).
4. **second-order.md**, *"Ungraded points violate by a wide margin … $\lambda_{\max}\ge\tfrac34$ throughout"*, **false as written**, contradicted by padded $W_{\mathbb{CP}^2}$ in the same file (§2c).
5. **second-order.md**, *"Morse–Bott nondegenerate at $n=8,10,12$ ($\dim E(\tfrac12)=\dim(\text{orbit})=18$)"*, **impossible at $n=10,12$**, where $\dim\mathcal O=26,34$ and the same file proves $\dim E(\tfrac12)\ge\dim\mathcal O$ (§2c).
6. **second-order.md**, *"a lower bound on $\operatorname{mult}(\tfrac12)$, which is equivalent to Conjecture A itself"*, **not equivalent**; it is strictly stronger, requiring $\operatorname{mult}(\tfrac12)\sim2\dim\mathcal O$ (§1d).
7. **92f0ead**, *"the fusion-rule tension is resolved"*, **relabelled**; its stated reason is a non sequitur, conceded later in the file but not in the commit or in plan.md (§3b).
8. **88ab8de**, *"a genuine out-of-sample confirmation"*, **degenerate**; the tested dimension is exactly where the untested coefficient vanishes and where the two invariants are dependent (§4a).
9. **second-order.md / 88ab8de**, the third-moment cap on $b$, **redundant**, dominated by $b\le\theta+\|\lambda\|_\infty$ (§4b).

## What is worth keeping

- The corrected bracket $(n+1)[2n\theta-(n-1)b]/(8\theta^3)$, verified symbolically here.
- The Peirce spectrum at $S^3\times S^3$, it reproduces both $\kappa_6/\theta_0^2$ and the recorded $\theta^2\operatorname{tr}L_e^3$ exactly, which is stronger corroboration than the file claims for it.
- The falsification itself, restated without the $n=5$ scoping.

## What should change in the record

1. Replace the fence post's mechanism with $c^2/\overline{\lambda^2}$ and downgrade "every localizing order" to "every localizing order, for the constraints involving $m_0$".
2. Resolve the padding contradiction in §2b before item 1 is re-ranked; the answer decides whether the $n\ge12$ restriction is an open route or a dead one.
3. Retract the "$\lambda_{\max}\ge\tfrac34$ throughout" paragraph and fix the $\dim E(\tfrac12)=18$ parenthetical.
4. Close the fusion-rule contradiction with $\dim E(1)=1$ (primitive) and record the nondegeneracy reading of the rule.
5. Mark the third-moment constraint as dominated, and mark the $n=5$ check as degenerate.
