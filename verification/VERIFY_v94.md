# VERIFY v94, Lemma L0: the constant is right, the biconditional is half proved, and the repair both reviewers prescribed was recorded instead of performed

*Cold brief, verifier v94, 2026-09-06. Target: [findings/problem.md](../findings/problem.md):470–500, the block headed "Lemma L0, problem p and conjecture a are the same statement", as quoted in [ROUND_L00b.md](ROUND_L00b.md). **No numerical work was done: no script was run, and every value below is an exact hand evaluation of a rational number.** Log: [agent_logs/verify-L00b-v94.log](../agent_logs/verify-L00b-v94.log).*

## Claim table

| # | Claim, as a consumer would cite it | Verdict |
|---|---|---|
| C1 | The constant on both sides is $\Theta_n$, the value at $S^{\lceil n/2\rceil}\times S^{\lfloor n/2\rfloor}$, and not $\theta_0(n)$ | **CONFIRMED**, against the published text, read |
| C2 | $\theta_0(n)^2-\Theta_n^2=\dfrac{8(n-1)}{n^2(n+1)(n-2)}>0$ at odd $n$, from $(n-2)^2(n+1)-n^2(n-3)=4$ | **CONFIRMED**, exact, rederived here |
| C3 | $\Theta_{13}^2=\tfrac{120}{77}$ against $\theta_0(13)^2=\tfrac{264}{169}$, difference $\tfrac{48}{13013}$ | **CONFIRMED**, exact |
| C4 | ($\Rightarrow$) $\sup=\Theta_n$ implies $P\le\Theta_n$ at every critical point | **PROVEN**, trivial, no hypothesis beyond the definition of a supremum |
| C5 | ($\Leftarrow$) $P\le\Theta_n$ at every critical point implies $\sup\le\Theta_n$ | **PROVEN**, this is the block's whole content, and it is sound |
| C6 | **The displayed biconditional at [problem.md](../findings/problem.md):482, cited alone** | **GAP**, $\sup\ge\Theta_n$ is never established in the block; the proof paragraph says so and closes with $\square$ anyway |
| C7 | "each side is then the $n\ge12$ clause of Conjecture A **at both parities**" | **GAP**, true and verified for the right side; for the left side it restates C6 and inherits its debt |
| C8 | Scope condition 1, value, not maximiser | **CONFIRMED** as a reading of the published conjecture; **its closing clause restates C6** |
| C9 | Scope condition 2 ("Conjecture A" means its $n\ge12$ clause alone | **CONFIRMED**), verbatim against the source, and the $n=10$ witness is exact |
| C10 | Scope condition 3, "products of spheres" means the balanced split | **CONFIRMED** mathematically; **DEFECTIVE AS PRINTED**, the relation $k+l=n$ is nowhere in the bullet |
| C11 | The equivalence removes the criticality hypothesis for free, by compactness | **PROVEN**, this is C5 restated, and it is the block's real deliverable |
| C12 | [results.md](../results.md):11, "The problem $P$ and Conjecture A are one statement, at the constant $\Theta_n$ / **Proven at both parities**" | **BROKEN AS CITED**, contradicts [results.md](../results.md):772's own promise and drops every caveat |
| C13 | [results.md](../results.md):46, L43's collapse to $\theta_0(n)$, "so Conjecture A and the problem $P$ are one statement (Lemma L0)" | **GAP**, the "so" fails at every odd $n\ge13$, where the criterion's constant strictly exceeds L0's |
| C14 | [lean/INDEX.md](../lean/INDEX.md):216, row L0, marked **proved** | **HONEST BUT NARROW**, it formalises rational arithmetic only; its own text records that the Lagrange condition, the step the block rests on, stays imported |

**Summary in one line.** The rewrite fixed the constant and fixed it correctly (that half is now verified against the published source rather than against the record) but the one-sentence repair that [r591](../reviews/REVIEW_r591.md) and [r592](../reviews/REVIEW_r592.md) both prescribed for the $\Leftarrow$ direction was written up as a pull-quote describing the hole instead of being inserted into the proof, so the citable display is still a biconditional carrying a proof of an implication.

## 0. Conventions, fixed once

Taken from [conventions.md](../findings/conventions.md) and used unchanged throughout.

| Symbol | Meaning | Where fixed |
|---|---|---|
| $\mathcal W_n$ | algebraic Weyl curvature operators on $\mathbb R^n$; $\dim\mathcal W_n=\frac{n(n-3)(n+1)(n+2)}{12}$, so $1638$ at $n=12$ | [conventions.md](../findings/conventions.md):13–14 |
| $Q(W)$ | $W^2+W^\#$, **sending $\mathcal W_n$ to itself** | [conventions.md](../findings/conventions.md):15 |
| $P(W)$ | the cubic form $\langle W,Q(W)\rangle$ | [conventions.md](../findings/conventions.md):16 |
| critical point | $Q(W)=\theta W$ on $\{\lVert W\rVert=1\}$, with $\theta=P(W)$ there | [conventions.md](../findings/conventions.md):17, :119 |
| $\theta_0(n)$ | the closed form $\theta_0(n)^2=\frac{2(n-1)(n-2)}{n^2}$, **and nothing more** | [conventions.md](../findings/conventions.md):18 |
| $\Theta_n$ | the **diagonal** maximum; $=\theta_0(n)$ at even $n$, $=\sqrt{\frac{2(n-1)(n-3)}{(n+1)(n-2)}}$ at odd $n$ | [conventions.md](../findings/conventions.md):19 |
| $M(n)$ | the **global** maximum of $P$ on the unit sphere of $\mathcal W_n$; $\Theta_n\le M(n)$ | [conventions.md](../findings/conventions.md):21 |

The block's left-hand side is exactly $M(n)=\Theta_n$. That reading is used below wherever it clarifies which of the two maxima is meant.

## 1. Hypothesis inventory

Every hypothesis the block carries, every hypothesis of every result it imports, and (the column that matters), whether the written argument actually uses it.

| Hypothesis | Whose | Checked against | Used by the written argument? |
|---|---|---|---|
| $n\ge12$, integer | the block's own, stated | at $n=12$, $\dim\mathcal W_{12}=\frac{12\cdot9\cdot13\cdot14}{12}=1638>0$, so the constraint sphere is nonempty | **Used only to name the constant and to align with Conjecture A's first clause.** The compactness–criticality argument itself holds at every $n$ with $\mathcal W_n\ne0$ |
| $\mathcal W_n$ finite-dimensional | the block's own, stated | $\dim\mathcal W_n$ above | **Used**, it is the first step |
| $\{\lVert W\rVert=1\}$ nonempty | **carried silently** | $1638>0$ at $n=12$; the formula is positive at every $n\ge4$ | **Used**, a maximum over the empty set does not exist. Closed in [SphereAttains.lean](../lean/HamiltonsCubic/Results/SphereAttains.lean), which states it for a *nonempty* compact set |
| $P$ continuous / smooth | the block's own ("the polynomial $P$") | $P$ is a cubic form on a finite-dimensional real vector space | **Used** |
| $\nabla P=3Q(W)$ | **imported and never named** | on record twice, [problem.md](../findings/problem.md):114 and [second-order.md](../findings/second-order.md):62, both deriving it from full symmetry of $T(X,Y,Z)=\langle X,Q\text{-polarisation}\rangle$ | **Used**, without it "whose Lagrange condition is $Q(W)=\theta W$" does not follow |
| $Q(\mathcal W_n)\subseteq\mathcal W_n$ | **imported and never named** | [conventions.md](../findings/conventions.md):15, and its source [BW08](../references/boehm-wilking-2008-space-forms/) eq. (6) as transcribed at [problem.md](../findings/problem.md):55 | **Used**, see §5 |
| $W_{\max}$ is critical for the *restriction*, never for $P$ on $\mathcal W_n$ | the block's own, stated explicitly | correct, and the one step [r591](../reviews/REVIEW_r591.md):83 singles out as non-trivial and correctly executed | **Used** |
| **A unit Weyl operator attaining $\Theta_n$ exists** | **required by the statement, supplied by no step of the proof** | exists three ways on the record: [conventions.md](../findings/conventions.md):21 ($\Theta_n\le M(n)$, by definition of the diagonal maximum), Lemma L57 at [problem.md](../findings/problem.md):550, and Nienhaus Proposition 2.25 at [nienhaus notes.md](../references/nienhaus-2023-second-best-einstein/notes.md) | **NOT used.** This is the gap of §3 |
| Every sphere product is a critical point | asserted in scope condition 3 | Nienhaus Proposition 2.25 states $W_{S_{k,l}}^2+W_{S_{k,l}}^\#=\theta_{k,l}W_{S_{k,l}}$, which is criticality | **Not load-bearing for the biconditional**; load-bearing for the missing witness, where it is not invoked |
| $k+l=n$ in $\theta_{k,l}$ | **required by scope condition 3, printed nowhere in it** | Nienhaus Proposition 2.25 says "for every split $k+l=n$"; Lemma L57 says $p+q=n$ | **Used silently**, see §6 |
| Conjecture A hypothesises criticality | the published statement's own | verbatim, [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404):212 | **Used**, correctly, see §7 |

**No finding on three fronts, stated rather than passed over.** The argument uses nothing about $\ker W$: it never inverts $W$, never splits on rank, and the Lagrange condition $Q(W)=\theta W$ is indifferent to a kernel, so $\ker W\ne0$ is admitted throughout with no change. Reducibility and non-compactness do not arise: $\mathcal W_n$ is a fixed finite-dimensional vector space of algebraic operators, no manifold enters the block at any step, and the published Conjecture A is likewise algebraic. And the smallest admissible dimension, $n=12$, is inside the range where every closed form used is defined, the denominators $n$, $n-2$ and $n+1$ all being nonzero there.

## 2. The constant, confirmed, and confirmed against the source rather than against the record

The pull-quote's claim is that Conjecture A concludes at $P(W^{\mathrm{crit}}_{\mathrm{sym}})$, the value at $S^{\lceil n/2\rceil}\times S^{\lfloor n/2\rfloor}$. Read from the source, not from memory:

> "Conjecture A. Let $W\in\mathrm{Weyl}_n$ be a unit Weyl curvature operator that is a critical point of $P(R)=\langle R^2+R^\#,R\rangle$ among $\mathrm{Weyl}^1_n=\{W\in\mathrm{Weyl}_n\mid\lVert W\rVert=1\}$. If either $n\ge12$ or $8\le n\le11$ and $W\notin SO(n).W_{\mathbb{CP}^2}$, we have $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$.", [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404):212–217, followed at :219–222 by "we denote by $R^{\mathrm{crit}}_{\mathrm{sym},n}=R^{\mathrm{crit}}_{\mathrm{sym}}$ the curvature operator of $S^{\lceil\frac n2\rceil}\times S^{\lfloor\frac n2\rfloor}$ endowed with its symmetric Einstein metric and by $W^{\mathrm{crit}}_{\mathrm{sym}}=(R^{\mathrm{crit}}_{\mathrm{sym}})_W$ its unit Weyl curvature operator."

So the published constant is the value at the balanced split at **both** parities, and it is $\Theta_n$. **C1 confirmed from a source that is in [references/](../references/) and was read.**

**C2, the identity, rederived by hand.** $(n-2)^2(n+1)=(n^2-4n+4)(n+1)=n^3+n^2-4n^2-4n+4n+4=n^3-3n^2+4$, while $n^2(n-3)=n^3-3n^2$. The difference is $4$, identically in $n$. Hence at odd $n$

$$\theta_0(n)^2-\Theta_n^2=2(n-1)\left[\frac{n-2}{n^2}-\frac{n-3}{(n+1)(n-2)}\right]=2(n-1)\cdot\frac{(n-2)^2(n+1)-n^2(n-3)}{n^2(n+1)(n-2)}=\frac{8(n-1)}{n^2(n+1)(n-2)},$$

positive for every $n\ge3$. **C2 confirmed.**

**C3, the witness, by hand.** $\theta_0(13)^2=\frac{2\cdot12\cdot11}{169}=\frac{264}{169}$ and $\Theta_{13}^2=\frac{2\cdot12\cdot10}{14\cdot11}=\frac{240}{154}=\frac{120}{77}$. Over $169\cdot77=13013$: $264\cdot77=20328$ and $120\cdot169=20280$, difference $48$, so $\frac{264}{169}-\frac{120}{77}=\frac{48}{13013}$, which is also what the closed form gives, $\frac{8\cdot12}{169\cdot14\cdot11}=\frac{96}{26026}=\frac{48}{13013}$. **C3 confirmed, and the trap carried into this brief is the one the block has already absorbed correctly.**

## 3. The gap, the $\Leftarrow$ direction is an implication wearing an equivalence's clothes

**Pre-registered question 1, answered directly: yes, one direction is.** It is $\Leftarrow$, and the block says so itself, inside the proof, and then closes the proof anyway.

**Locate.** [problem.md](../findings/problem.md):482 displays

> $$\sup\{P(W):W\in\mathcal W_n,\ \lVert W\rVert=1\}\;=\;\Theta_n\quad\Longleftrightarrow\quad P(W)\le\Theta_n\ \text{at every critical point of }P|_{\lVert W\rVert=1},$$

and [problem.md](../findings/problem.md):490 ends its $\Leftarrow$ half with

> "**($\Leftarrow$)** If $P\le\Theta_n$ at every critical point then $P(W_{\max})\le\Theta_n$, and $P(W_{\max})$ is the supremum, **so this direction gives $\sup\le\Theta_n$ and not the equality.** $\square$"

**Exhibit the failure concretely, at a named object and dimension.** Take $n=13$. The right-hand side reads $P(W)\le\sqrt{120/77}$ at every critical point. The block's argument delivers $\sup\le\sqrt{120/77}$ and nothing else. Now $W_{\mathbb{CP}^2}$ padded into $\mathbb R^{13}$ is a unit Weyl operator, is a critical point, Nienhaus, [notes.md](../references/nienhaus-2023-second-best-einstein/notes.md), $R^{\mathrm{crit}}_{\mathbb{CP}^2}$, and carries $P=\sqrt{3/2}$. Compare the squares over $77$: $\frac32=\frac{115.5}{77}<\frac{120}{77}$. So the state of affairs "$\sup=\sqrt{3/2}$, attained at the padded $\mathbb{CP}^2$ operator" satisfies the right-hand side in full and **falsifies the left-hand side**, and no step written in the block excludes it. The $\Leftarrow$ arrow is therefore not established by the argument on file; what is established is the arrow with $=$ weakened to $\le$.

**Argue the opposite, the most charitable reading the words support.** The pull-quote at [problem.md](../findings/problem.md):492 does point at the missing half: "$\sup\ge\Theta_n$ needs a witness: the balanced product itself, admissible in $\mathcal W_n$ and carrying $\theta=\Theta_n$ by the $\theta_{k,l}$ formula below." On that reading the block is a correctly stated equivalence whose lower half is a single citation the author judged too small to inline, deliberately flagged rather than concealed, and the flag is even inside the proof paragraph, not merely beside it.

**Why the charitable reading does not rescue the claim.** Three things defeat it, and they are cumulative.

1. **The pointer is a record of the defect, not a discharge of it.** The same sentence continues "**Both reviewers found the witness cited nowhere in the block**", a report of a past finding in the past tense. A reader cannot tell from it whether the witness is now supplied or still missing, and the proof paragraph, which is where the equivalence is assembled, ends at $\le$ with $\square$.
2. **"the $\theta_{k,l}$ formula below" names nothing.** The nearest $\theta_{k,l}$ formula is *above* the pull-quote, in scope condition 3 at :488; the formula genuinely below is Lemma L57's at :550, sixty lines away and under a different heading. Neither is named. A consumer following the pointer lands on scope condition 3, which gives the *value* of a split and says nothing about a Weyl operator existing that realises it.
3. **Both Gate-2 reviewers prescribed the exact repair, in one sentence each, and the rewrite performed neither.** [r591](../reviews/REVIEW_r591.md):137, "($\Leftarrow$), **lower half, currently missing**: $W^{\mathrm{crit}}_{\mathrm{sym}}$ is a unit Weyl operator with $P=\Theta_n$, so $\max\ge\Theta_n$. Cite [Lemma L57](../findings/problem.md)'s attainment formula, or Nienhaus Proposition 2.25, either of which is on the record for **both** parities." [r592](../reviews/REVIEW_r592.md):145, "**Supply the missing inequality.** Add the sentence the proof lacks." What the rewrite added instead is a pull-quote describing the hole. **This is the record's signature failure exactly: the correction landed beside the statement rather than in it.**

**Candidate survives all three steps. REAL.**

**And the discharge is genuinely one line, three ways over.** Any of the following closes it, at both parities, with no new mathematics: (i) [conventions.md](../findings/conventions.md):21 defines $\Theta_n$ as the diagonal maximum and records $\Theta_n\le M(n)$, so under the record's own definition the lower half is definitional; (ii) Lemma L57 at [problem.md](../findings/problem.md):550 gives $\theta(S^p\times S^q)^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ for $p+q=n$, collapsing to $\Theta_n^2$ at the balanced split at both parities; (iii) Nienhaus Proposition 2.25 states $P(W_{S_{k,l}})=\theta_{k,l}$ for a unit Weyl operator. **The block cites none of the three by name.** That the fix is cheap is what makes this a `GAP` and not a `HYPOTHESIS-DEBT`: the input exists and is located, and only the assembly is missing.

**Three formulas, one object, checked.** The block's $\theta_{k,l}^2=2\frac{n-1}{n-2}\left(1-\frac{n-1}{kl}\right)$, L57's $\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ and Nienhaus's $\theta_{k,l}=\sqrt2\sqrt{\frac{k-1}{k}\cdot\frac{l-1}{l}\cdot\frac{n-1}{n-2}}$ are the same formula: $(k-1)(l-1)=kl-(k+l)+1=kl-n+1$, so $\frac{(k-1)(l-1)}{kl}=1-\frac{n-1}{kl}$. At $k=l=\frac n2$ this is $\frac{2(n-1)}{n-2}\cdot\frac{(n-2)^2}{n^2}=\theta_0(n)^2$; at $k=\frac{n-1}2$, $l=\frac{n+1}2$ it is $\frac{2(n-1)}{n-2}\cdot\frac{n-3}{n-1}\cdot\frac{n-1}{n+1}=\frac{2(n-1)(n-3)}{(n-2)(n+1)}=\Theta_n^2$. **The block's own scope condition therefore contains the value the witness needs, and the proof still does not use it.**

## 4. The $\Rightarrow$ direction, and what the block does prove

$\Rightarrow$ is immediate and carries no hypothesis beyond the meaning of a supremum: if $\sup=\Theta_n$ then $P\le\Theta_n$ on the whole unit sphere, and critical points lie on it. **C4 proven.**

$\Leftarrow$ as an inequality is the block's real content and it is sound. If $P\le\Theta_n$ at every critical point, then since the maximum is attained at $W_{\max}$ and $W_{\max}$ is critical for the restriction, $P\le P(W_{\max})\le\Theta_n$ everywhere on the sphere. **C5 proven**, given the two imported facts of §5.

**C11, the closing paragraph's claim, is exactly C5 and is therefore proven.** "The one thing it removes is the criticality hypothesis, for free, by compactness", the removal is the passage from "bounded at critical points" to "bounded everywhere", and it costs nothing because the maximum is attained at a critical point. **The second trap carried into this brief lands on the right side of the line here**: Conjecture A as published hypothesises criticality, a statement quantified over every unit Weyl operator is strictly stronger, and the block claims the two are equivalent, which is correct, and correct *because of* C5, not by assumption. That equivalence is the useful thing in the block and it survives the gap of §3 untouched.

## 5. The Lagrange step, and two facts the block uses without naming

The block writes: "A maximum of a smooth function on a smooth constraint surface is a critical point of the restriction, so $W_{\max}$ is critical, for $P|_{\lVert W\rVert=1}$, whose Lagrange condition is $Q(W)=\theta W$ with $\theta=P(W)$, and never for $P$ on $\mathcal W_n$."

The parenthetical distinction is right and is the block's best sentence. The identification of the Lagrange condition needs two facts:

- **$\nabla P=3Q(W)$**, from full symmetry of the polarised cubic. Derived twice on the record, at [problem.md](../findings/problem.md):114 and [second-order.md](../findings/second-order.md):62, and it is what turns the stationarity condition $\nabla P=2\mu W$ into $Q(W)=\theta W$, with $\theta=\frac{2\mu}3$; pairing against $W$ at unit norm gives $\theta=P(W)$, matching [conventions.md](../findings/conventions.md):17.
- **$Q$ maps $\mathcal W_n$ into itself.** The constraint sphere lies in the subspace $\mathcal W_n$, so the first-order condition is $\Pi_{\mathcal W_n}Q(W)=\theta W$ in general. Dropping the projection needs $Q(\mathcal W_n)\subseteq\mathcal W_n$, which is [conventions.md](../findings/conventions.md):15, from [BW08](../references/boehm-wilking-2008-space-forms/) equation (6) as transcribed at [problem.md](../findings/problem.md):55.

**Finding, minor and real: both are used and neither is named in the block.** It matters because $\Pi_{\mathcal W_n}Q(W)=\theta W$ defines a strictly larger critical set than $Q(W)=\theta W$ would, and the right-hand side of the biconditional quantifies over that set, so the two facts are what make the block's right side identical to the published Conjecture A's hypothesis rather than a weakening of it. **Charitable reading, and it holds**: [conventions.md](../findings/conventions.md):119 *defines* "critical point" to be $Q(W)=\theta W$, so within the record's conventions the block is quoting a definition. The finding is therefore a citation defect and not a mathematical one, and I record it as such rather than as a discrepancy.

## 6. The three scope conditions, pre-registered question 2

**Scope condition 1, value not maximiser.** Checked against the published text quoted in §2: $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$ is non-strict and carries no rigidity clause, so the condition's reading is right, and it correctly separates L0 from Jäger's Theorem A, which *does* carry one ("Then $\theta=\theta_0(n)$, and $W$ is the normalized Weyl curvature of $S^{n/2}\times S^{n/2}$", [problem.md](../findings/problem.md):17). **CONFIRMED as a reading.** But its closing clause ("so it is equivalent to attainment of $\Theta_n$"), is, under the only reading that makes it true ("$\Theta_n$ is attained *as the supremum*"), a restatement of the display at :482, and so it inherits §3's debt rather than discharging it.

*A candidate raised and withdrawn.* Under the other reading the words support ("some unit Weyl operator attains $\Theta_n$"), the clause is false, because that is unconditionally true at every $n$ by Nienhaus Proposition 2.25, which would make Conjecture A a theorem; the block's own $n=10$ number refutes it, $\Theta_{10}^2=\frac{2\cdot9\cdot8}{100}=\frac{36}{25}=1.44$ being attained yet not the maximum, since $P(W_{\mathbb{CP}^2})^2=\frac32$. **Withdrawn**: the charitable reading, "attained as the supremum", is the natural one in context and makes the clause correct. Recorded because [r591](../reviews/REVIEW_r591.md):104 raised this same clause as false and the rewrite changed only its constant, leaving the ambiguity in place.

**Scope condition 2, "Conjecture A" means its $n\ge12$ clause alone.** Checked verbatim against [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404):212–217. The published hypothesis is a disjunction over two disjoint dimension ranges, so the conjecture is equivalent to the conjunction of two statements, and no statement quantified over $n\ge12$ implies one about $8\le n\le11$. The liveness witness is exact: at $n=10$, $\theta_0(10)^2=\frac{2\cdot9\cdot8}{10^2}=\frac{36}{25}$, and $\frac{36}{25}=1.44<1.5=\frac32=P(W_{\mathbb{CP}^2})^2$, so the $\mathbb{CP}^2$ exception is load-bearing there. **CONFIRMED. A consumer may cite this condition as it stands.**

*One notation hazard, unrepaired.* The bullet writes $\theta_{10}$, a single subscript, two lines above a bullet that uses $\theta_{k,l}$ for a split, so $\theta_{10}$ reads as a split label. [r591](../reviews/REVIEW_r591.md):106 flagged exactly this and the rewrite left it. $\theta_{10}$ appears in no symbol table; the object meant is $\Theta_{10}=\theta_0(10)$.

**Scope condition 3, "products of spheres" means the balanced split.** The mathematics is right and I rebuilt it: $2\frac{n-1}{n-2}>0$ for $n\ge3$ and $1-\frac{n-1}{kl}$ is strictly increasing in $kl$, and under $k+l=n$ the product $kl$ is maximal at the balanced split by $4k(n-k)=n^2-(n-2k)^2$. The two exhibited values are exact: at $n=12$, $\theta_{6,6}^2=\frac{2\cdot11}{10}\left(1-\frac{11}{36}\right)=\frac{11}{5}\cdot\frac{25}{36}=\frac{55}{36}$ and $\theta_{5,7}^2=\frac{11}{5}\cdot\frac{24}{35}=\frac{264}{175}$, with $\frac{264}{175}<\frac{55}{36}$ since $264\cdot36=9504<9625=55\cdot175$. **CONFIRMED mathematically.**

**Discrepancy, and it is the named trap at the scale of one bullet.**

- **Locate.** [problem.md](../findings/problem.md):488, "$\theta_{k,l}^2=2\frac{n-1}{n-2}\left(1-\frac{n-1}{kl}\right)$ is strictly increasing in $kl$, so the maximum over splits is at $k=\lceil n/2\rceil$".
- **Exhibit.** The sentence names three free symbols, $n$, $k$ and $l$, and states no relation among them. Read alone, as a consumer would, the inference is invalid: monotonicity in $kl$ places the maximum at the balanced split only under the constraint $k+l=n$, and with $k+l$ unconstrained $kl$ is unbounded and there is no maximum at all. The constraint is in Nienhaus Proposition 2.25 ("for every split $k+l=n$") and in Lemma L57 ($p+q=n$), and in neither of the two places this block prints the formula. The Lean row repeats the omission at the level of a type: `splitSq n kl` takes $n$ and the product as *independent* rationals, and `split_increasing` is stated for arbitrary $0<a<b$; the relation surfaces only inside `product_identity`, which substitutes $l=n-k$ with nothing tying it back to `splitSq`.
- **Argue the opposite.** "The maximum over splits" makes $k+l=n$ contextually obvious to any reader who knows what a split of $\mathbb R^n$ is, and the two worked values, $(6,6)$ and $(5,7)$, both sum to $12$ and pin the convention beyond doubt.
- **Why it survives.** The block's own third bullet is the one it calls "the condition that broke the lemma", so it is the bullet most likely to be lifted and cited on its own; and the omitted relation is precisely what carries the balanced split from "largest $kl$" to "$\Theta_n$". **REAL, minor.** The repair is three characters: write $k+l=n$.

**What a consumer may cite from the three conditions.** Conditions 2 and 3 as mathematics, without qualification. Condition 3 **only together with $k+l=n$**, supplied from outside the bullet. Condition 1 as a reading of the published conjecture, and not as an independent statement, since its closing clause is the block's own left-hand side.

## 7. The three forms compared

I checked three forms. What each carries that the others do not:

| Form | Constant | The $\Leftarrow$ caveat | The three scope conditions | Extra |
|---|---|---|---|---|
| [problem.md](../findings/problem.md):482–492 | $\Theta_n$, both parities, with the closed forms | **present**, in the proof and in a pull-quote | **all three** | the withdrawn $\theta_0$ form, recorded as history |
| [results.md](../results.md):775 | $\Theta_n$, with the gap formula and the $n=13$ pair | **present**, in bold | **none of the three** | the separation from Lemma L43's cone bridge |
| [results.md](../results.md):11 | $\Theta_n$ named in the row title | **absent** | none | the verdict "**Proven at both parities**" |
| [lean/INDEX.md](../lean/INDEX.md):216 + [L0.lean](../lean/HamiltonsCubic/Results/L0.lean) | $\Theta_n$ and $\theta_0$ as rational functions | **present** in the row prose, and formalised as `backward_gives_only_le` and `equality_needs_witness` | conditions 2 and 3 as arithmetic; condition 1 nowhere | the machine-checked identity, and the split-formula values |

**On the Lean row (C14).** The brief warns that a Lean statement cannot hide a hypothesis because every binder is one. Here the binders are honest and the row is honest about its scope: `theta0Sq`, `ThetaOddSq` and `splitSq` are functions $\mathbb Q\to\mathbb Q$, `margin_is_four` and `product_identity` are `ring` identities, and nothing in the file mentions a Weyl operator, $P$, $Q$ or a sphere. `backward_gives_only_le` is the propositional shadow of the $\Leftarrow$ half (`hcrit : P ≤ Θ`, `hmax : s = P`, conclusion `s ≤ Θ`) and `equality_needs_witness` exhibits `s = 0, Θ = 1` to show `≤` alone leaves `<` open. **So the Lean file proves that the block's gap is a gap**, which is a fair thing to formalise, and proves no part of the biconditional. The row's own closing words say the rest: "**Owed, halved**: compactness is closed in [SphereAttains](../lean/HamiltonsCubic/Results/SphereAttains.lean) … the Lagrange condition stays imported." The Lagrange condition is the step §5 identifies as load-bearing, so the row is marked **proved** while the mathematical core of the block is imported, accurately described, but a reader scanning the status column alone would not learn it. **There is no Lean row for Lemma L57**, so the witness value is not machine-checked anywhere either.

**C12, a discrepancy inside [results.md](../results.md), and it is the trap landing.**

- **Locate.** [results.md](../results.md):11 gives the row "The problem $P$ and Conjecture A are one statement, at the constant $\Theta_n$ | **Proven at both parities** (Lemma L0)". [results.md](../results.md):772, the preamble to the Audit-owed section that contains L0 at :775, reads: "They are listed so the reader knows they exist; **none is cited above as a claim**."
- **Exhibit.** L0 is the first row of the headline table, above, and the table assigns it the verdict "Proven at both parities". So the preamble's promise is false of its own first entry, and the strongest possible verdict is the one being asserted for a result the same file classes as unaudited. A reader of the headline table takes away that the biconditional is proven at both parities, when §3 shows the block proves one direction and an inequality.
- **Argue the opposite.** "Cited above as a claim" may be intended as "cited in the numbered result blocks", the summary table being a status board rather than a citation; and [results.md](../results.md):46 does append "(Lemma L0, audit owed)".
- **Why it survives.** The table is above, and "Proven at both parities" is a claim in any reading; the qualifier that :46 carries is absent from :11 precisely where the verdict is strongest. **REAL.** This is what "a citation inherits the defect" means concretely: [results.md](../results.md):775 states the caveat in bold and [results.md](../results.md):11 is where a reader looks first.

**C13, the chain through Lemma L43 fails at odd $n$.**

- **Locate.** [results.md](../results.md):46, "the cone-bridge (Lemma L43) shows the $a=0$ criterion collapses to $\langle W,Q(W)\rangle\le\theta_0(n)\lVert W\rVert^3$ with $\theta_0(n)=c(n-1)$, **so** Conjecture A and the problem $P$ are one statement (Lemma L0, audit owed)."
- **Exhibit.** L43's constant is genuinely $\theta_0(n)$ at both parities, [problem.md](../findings/problem.md):200 is explicit that "the criterion demands $\theta_0(n)$ at both parities … $\Theta_n$ is what the diagonal locus attains, never what the criterion demands". L0's constant is $\Theta_n$. At $n=13$ these differ by $\frac{48}{13013}$ in squares, with the criterion's the larger, so the criterion's bound is strictly weaker than the equivalence's constant at every odd $n\ge13$ and the "so" does not carry.
- **Argue the opposite.** The sentence may mean only that the two statements concern the same functional and the same sup, with the constant handled separately, and it does flag "audit owed"; [problem.md](../findings/problem.md):94 already says plainly "What is settled is that the target constant is right, not that the two statements coincide."
- **Why it survives.** The word is "so", which asserts an entailment, and the constant is the exact thing this block was rewritten over; [results.md](../results.md):775 itself carries the italic correction ("*The reduction … is separate from the cone bridge of Lemma L43*") which :46 contradicts. **REAL.**

## 8. What a reader may take from this block

Stated positively, item by item, because this is what every other row of the record depends on.

1. **The constant is $\Theta_n$ at both parities**, and it is the published $P(W^{\mathrm{crit}}_{\mathrm{sym}})$. Citable. Verified here against the source text, not against the record.
2. **$\theta_0(n)>\Theta_n$ at every odd $n\ge13$, with gap $\frac{8(n-1)}{n^2(n+1)(n-2)}$**, from the identity $(n-2)^2(n+1)-n^2(n-3)=4$. Citable, exact, machine-checked.
3. **The maximum of $P$ on the unit sphere of $\mathcal W_n$ exists and is attained at a critical point of the restriction.** Citable, given the two imports of §5; the attainment half is machine-checked in [SphereAttains.lean](../lean/HamiltonsCubic/Results/SphereAttains.lean).
4. **If $P\le\Theta_n$ at every critical point, then $P\le\Theta_n$ on the whole unit sphere.** Citable, and this is the free removal of the criticality hypothesis. **It is the block's deliverable and it is intact.**
5. **If $\sup=\Theta_n$, then $P\le\Theta_n$ at every critical point.** Citable, trivially.
6. **The biconditional at [problem.md](../findings/problem.md):482, and with it "each side is the $n\ge12$ clause of Conjecture A", is NOT citable from this block.** What is missing is $\sup\ge\Theta_n$; what would close it is one sentence naming Lemma L57 at [problem.md](../findings/problem.md):550 or Nienhaus Proposition 2.25.

**The practical consequence for the rest of the record.** Every row that reduces Conjecture A to a statement about critical points may cite item 4 and is unaffected. Every row that converts a bound at critical points into the *equality* $M(n)=\Theta_n$, or that reads L0 as licensing the substitution of the sup-form for the published critical-point form in both directions, is citing item 6 and is currently citing an unproven step.

## 9. What would falsify this block, and what I did to look for it

**The object that would break it.** A unit Weyl operator $W\in\mathcal W_n$, $n\ge12$, that is a critical point of $P|_{\lVert W\rVert=1}$ with $P(W)>\Theta_n$ would falsify the right-hand side and, with it, the conjecture the block is a reduction of. Weaker but still fatal to the block as written: a demonstration that **no** unit Weyl operator attains $\Theta_n$ at some $n\ge12$, that would make the left-hand side unsatisfiable and turn the stated equivalence into a false biconditional rather than an under-argued one.

**What I did to look for each.** For the first: read the record's own catalogue of values above $\sqrt{3/2}$, [results.md](../results.md):11–22 records the graded half as settled with only sphere products of both factors $\ge5$ above $\sqrt{3/2}$, and the one open candidate at $1.088948$ on $(\mathfrak{so}(8),\mathfrak{so}(3)\oplus\mathfrak{so}(5))$ sits well below $\Theta_{12}$, whose square is $\frac{55}{36}$. Nothing on the record exceeds $\Theta_n$ at $n\ge12$. For the second: read Nienhaus Proposition 2.25 in the transcription at [notes.md](../references/nienhaus-2023-second-best-einstein/notes.md), which states $W_{S_{k,l}}^2+W_{S_{k,l}}^\#=\theta_{k,l}W_{S_{k,l}}$ and $P(W_{S_{k,l}})=\theta_{k,l}$ for every split $k+l=n$; evaluated by hand at the balanced split, at both parities, this is $\Theta_n$, so the attaining operator exists and the second falsifier does not. **That is why the verdict is `GAP` and not `BROKEN`: the statement is true and the argument for half of it is absent from the block.**

**No numerical work was performed.** No script was run and nothing was screened. Every rational appearing above, $\frac{264}{169}$, $\frac{120}{77}$, $\frac{48}{13013}$, $\frac{55}{36}$, $\frac{264}{175}$, $\frac{36}{25}$, $\frac32$, $1638$, was evaluated by hand from a closed form printed in the record or in a source in [references/](../references/).

## Verdict

**GAP.**

The rewrite discharged the constant, and discharged it correctly and checkably against a read source. It did not discharge the finding that stood beside the constant. The $\Leftarrow$ direction of the displayed biconditional yields $\sup\le\Theta_n$; the reverse inequality has no step anywhere in the block; both Gate-2 reviewers wrote out the single sentence that closes it; and the rewrite entered a pull-quote reporting the omission instead. Add to the proof paragraph, before the $\square$: *"and $\sup\ge\Theta_n$, since $W^{\mathrm{crit}}_{\mathrm{sym}}$ is a unit Weyl operator with $P=\Theta_n$, Lemma L57's attainment formula at the balanced split, or Nienhaus Proposition 2.25, at both parities."* Then correct [results.md](../results.md):11, which currently reads "Proven at both parities" for a result its own file lists as audit-owed, and print $k+l=n$ in scope condition 3.
