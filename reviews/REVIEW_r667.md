# Review r667, Lemma L113, moment analysis of the $g$-distribution cannot leave the pinned class

**Review number: r667.** Reviewer A of an independent pair on identical briefs. Target: [findings/bounds.md](../findings/bounds.md) line 307, `#### Lemma L113, moment analysis of the $g$-distribution cannot leave the pinned class`, whose whole body is the single paragraph at line 309. Derived cold from [conventions.md](../findings/conventions.md) and the three relations at [bounds.md](../findings/bounds.md) line 236; the block's own reasoning was read only after the derivations below were finished. **Analysis only, no computation was run, and none is reported as evidence.**

## VERDICT, GAP

The impossibility is **real, and I supply the proof the block does not have**, in a strictly stronger form than the block claims. But the block states it with a class it never delimits, at a label it has not earned, and **its one actionable clause is false against a Gate-2-confirmed lemma that had stood in this same file for six days when the block was written**.

| # | claim | verdict |
| --- | --- | --- |
| 1 | contracting (C) against $\lambda_a$ gives $\sum_{abc}\lambda_a\lambda_b\lambda_cT_{abc}=2\theta-2\mathop{\mathrm{tr}}W^3$ | **CONFIRMED**, constant and all |
| 2 | the cubic identity adds nothing to (C) | **CONFIRMED**, with the logical relation stated exactly below |
| 3 | *any* pair of moment inequalities from positivity and support returns a pinned conclusion | **CONFIRMED and strengthened**, it holds for *every* family, not pairs, and the complete consequence is exactly [L107](../findings/bounds.md) |
| 4 | "moment analysis of the $g$-distribution cannot leave the pinned class" | **UNFALSIFIABLE AS A ROUTE-CLOSURE.** The conjecture's own target is a pinned-class statement, so staying pinned closes nothing |
| 5 | "the only sources on the table are the **Jacobi identity and first Bianchi**" | **REFUTED** by [Lemma L109](../findings/bounds-relaxations.md), which is neither |
| 6 | "a theorem-shaped extension of [post F42](../findings/fence-posts.md)" | **STALE**, F42's conclusion was withdrawn in both directions 44 minutes after this block was committed |
| 7 | "the single open door … the question the whole route stands on" | **STALE**, [r331](REVIEW_r331.md) §1.2 answered it 46 minutes later |

## Readings adopted, stated because the table is incomplete

- **Normalisation.** $\lambda$ is the $\Lambda^2$ spectrum of $W$ at $\lVert W\rVert=1$, so $\sum_a\lambda_a^2=\mathop{\mathrm{tr}}(W^2)=1$ and $\sum_a\lambda_a=0$, the operator reading of the $M$ row in [conventions.md](../findings/conventions.md), not the sectional-matrix one. Every constant below depends on it.
- **Ordered slots.** All of $\sum_{bc}$, $\sum_{abc}$ and $\sum_{\alpha\beta}$ run over **ordered** tuples, per [conventions.md](../findings/conventions.md)'s standing default. $T_{abc}=c_{abc}^2$ is totally symmetric and hollow.
- **$\#$, which the table does not carry.** I read $(A\#B)_{\alpha\beta}=\tfrac12\sum c_{\alpha\gamma\delta}c_{\beta\varepsilon\zeta}A_{\gamma\varepsilon}B_{\delta\zeta}$, i.e. $(W^\#)_{aa}=\tfrac12\sum_{bc}\lambda_b\lambda_cT_{abc}$ in the eigenbasis. **This $\tfrac12$ is not defined anywhere in [conventions.md](../findings/conventions.md)** (the table has a $Q(W)$ row reading "$W^2+W^\#$" and stops) and it is what makes the $2$ in (A), (B) and (C) come out. It is pinned by three independent occurrences, exactly as the brief anticipated. **It should be tabled.**
- **"Pinned class"** is undefined in [conventions.md](../findings/conventions.md) and carries **two senses inside bounds.md alone**: at line 309 it is *the class of conclusions expressible in $(\lambda,\theta)$*; at line 413 ("the conjecture **falls out of** the pinned class and is closed") it is *the LP feasible set cut out by (A), (B), (C) and $T\ge0$*, which is also the sense of [bounds-relaxations.md](../findings/bounds-relaxations.md) line 350 and [plan.md](../plan.md) lines 13–19. The two senses point opposite ways, under the first, being pinned is the failure; under the second, being pinned is the win. Read against the second sense, L113's headline is unintelligible. **I audit it under the first, which is the only one its own sentence supports.**

## 1. The contraction identity, CONFIRMED, and the constant is right for a reason

Relation (C) at [bounds.md](../findings/bounds.md) line 236 reads $\sum_{bc}\lambda_b\lambda_cT_{abc}=2\lambda_a(\theta-\lambda_a)$ for every $a$. Contract against $\lambda_a$:

$$\sum_{abc}\lambda_a\lambda_b\lambda_cT_{abc}=2\sum_a\lambda_a^2(\theta-\lambda_a)=2\theta\mathop{\mathrm{tr}}(W^2)-2\mathop{\mathrm{tr}}(W^3)=2\theta-2\mathop{\mathrm{tr}}W^3 .$$

**The block's right-hand side is confirmed.** It needs $\mathop{\mathrm{tr}}W^2=1$, which is the normalisation above and is the *only* place the unit norm enters.

**Where the $2$ comes from, stated as the brief asks.** At a critical point $W^\#=\theta W-W^2$, so $(W^\#)_{aa}=\lambda_a(\theta-\lambda_a)$. With $\#$ as tabled above and **ordered** $(b,c)$, $(W^\#)_{aa}=\tfrac12\sum_{bc}\lambda_b\lambda_cT_{abc}$, and the $2$ in (C) is exactly the reciprocal of Hamilton's $\tfrac12$. **Under the unordered reading ($\sum_{b<c}$), the same identity reads $\sum_{b<c}\lambda_b\lambda_cT_{abc}=\lambda_a(\theta-\lambda_a)$ with no $2$ at all.** So the constant is right iff both conventions are held together: ordered slots *and* the $\tfrac12$ in $\#$. Drop either and the factor-2 collision the brief warns of is immediate. The same pair fixes (A), $\sum_{\beta\gamma}T_{k\beta\gamma}=\sum_\beta\lVert[v_k,v_\beta]\rVert^2=2(n-2)$, the Killing marginal, and (B), $(W\#I)_{aa}=\tfrac12\sum_{bc}\lambda_bT_{abc}=-\lambda_a$ from Böhm–Wilking's $W\#I=-W$. **All three carry one $2$ from one source, and they are mutually consistent.**

**An independent check that closes the convention question.** Rebuilding the two pinned moments from the relations, with no reference to the record's values:

$$m_0=\sum_kg_k=2\sum_{k\alpha\beta}\lambda_\alpha^2T-2\sum_{k\alpha\beta}\lambda_\alpha\lambda_\beta T \overset{\text{(A)},\text{(B)}}{=}2\cdot2(n-2)-2\cdot(-2)=4(n-1),$$

$$m_1=\sum_k\lambda_kg_k=2\sum_k\lambda_kR_k-2\sum_{abc}\lambda_a\lambda_b\lambda_cT \overset{\text{(B)}}{=}-4\mathop{\mathrm{tr}}W^3-2\Sigma_3 .$$

Both reproduce the record's $4(n-1)$ and $-4\theta$ **exactly**, on the ordered/$\tfrac12$ reading and on no other. This is the strongest evidence available that the convention pair is the record's, and it is derivable by hand.

### 1.1 "These are the same equation", CONFIRMED, with the implication stated precisely

The cubic identity $P(W)=\mathop{\mathrm{tr}}W^3+\tfrac12\Sigma_3$, with $\Sigma_3:=\sum_{abc}\lambda_a\lambda_b\lambda_cT_{abc}$, is an identity at **every** $W$: it is $\langle W,W^2+W^\#\rangle$ with $\langle W,W^\#\rangle=\tfrac12\Sigma_3$. Feeding in the contracted (C):

$$\mathop{\mathrm{tr}}W^3+\tfrac12(2\theta-2\mathop{\mathrm{tr}}W^3)=\theta,\qquad\text{i.e.}\qquad P(W)=\theta .$$

So the contracted (C) is **the cubic identity plus $P(W)=\theta$**, and $P(W)=\theta$ is immediate from $Q(W)=\theta W$ at $\lVert W\rVert=1$. **Inside the pinned relaxation the block's claim is exactly right**: imposing the cubic identity on a variable $T$ after (C) has been imposed adds no constraint, because the two read as the same linear equation in $T$. The block's phrasing ("the same equation") is correct; what it omits is that the cubic identity is *general* and the contracted (C) is that identity *evaluated at a critical point*.

### 1.2 What actually disappears, and it is not what the block says

**The block's own $m_1$ is the contracted (C) in different notation.** Substituting $\Sigma_3=2(P-\mathop{\mathrm{tr}}W^3)$ into the $m_1$ line above gives $m_1=-4P(W)$ at every $W\in\mathcal W_n$, criticality nowhere, which is [L107](../findings/bounds.md)'s "the $g$-route needs no criticality", independently reconfirmed here. **So the moment problem reads $\theta$ exactly once, at $m_1$, and reads it as the objective itself.** That is what "disappears": there is no second, independent handle on $\theta$ anywhere in the system.

**Is L113 the same fact as L112's Gate 2?** *Nearly, and the record should say so.* [L112](../findings/INDEX-results.md)'s verdict is "(A) and (B) contain no $\theta$, so nothing built from them can bound it". The $g$-moment problem's inputs are: (A) and (B) for $m_0$ ($\theta$-free; the cubic identity for $m_1=-4P$) which *is* the objective; and $g_k\ge0$, $\theta$-free. **So L113 is a two-line corollary of L112's observation**: the only $\theta$ in the system is the thing being bounded, hence nothing about $\theta$ can come out that was not put in. This is not one result under two numbers (the statements differ) but the record files as a theorem-shaped extension what follows from a sentence it already holds.

## 2. The class, the impossibility is real, and the block's version is both weaker and undelimited

### 2.1 The block's class, delimited for the first time

The block quantifies over "*any* pair of moment inequalities built from [positivity and support], however the free moment enters". Three things go unsaid, and all three matter.

- **"Support" is not an ingredient.** $\mu=\sum_kg_k\delta_{\lambda_k}$ has its atoms *at the eigenvalues* by construction, so $\mathop{\mathrm{supp}}\mu\subseteq[\lambda_{\min},\lambda_{\max}]$ is a tautology, not a hypothesis. The support inequality at [bounds.md](../findings/bounds.md) line 295 is positivity tested against the polynomial $(\lambda-\lambda_{\min})(\lambda_{\max}-\lambda)$, exactly as Cauchy–Schwarz at line 294 is positivity tested against $(\lambda-c)^2$. **The class has one ingredient, not two.**
- **"Any pair" is the wrong arity.** With every moment from $m_2$ up free, a pair of inequalities involving $m_3$ and $m_4$ eliminates nothing and returns no pinned conclusion at all. The claim is only true once the class is restricted to inequalities in $(m_0,m_1,m_2)$, a restriction the block never states.
- **"Cannot leave the pinned class" names the conclusion, not its strength.** A pinned conclusion is precisely what Conjecture A is: $\theta\le\theta_0(n)$ mentions no free datum. **So "cannot leave the pinned class" cannot close a route, and as a route-closure the statement is unfalsifiable.** What would close the route is "cannot improve on L107", which is a different claim and is the one §2.2 proves and §3 refutes at the wider class.

### 2.2 The theorem the block should be, proved here, and it is stronger than "any pair"

> **Completeness of the $g$-moment class.** *Fix a spectrum $\lambda$ with $\lambda_{\min}<0<\lambda_{\max}$ and $\theta>0$. The system*
> $$g_k\ge0,\qquad \sum_kg_k=4(n-1),\qquad \sum_k\lambda_kg_k=-4\theta$$
> *is feasible **iff** $\theta\le(n-1)\lvert\lambda_{\min}\rvert$. Hence the complete set of consequences of positivity together with the two pinned moments is exactly [Lemma L107](../findings/bounds.md), and **no inequality of any arity whatever** (pairs, families, nonlinear in the free moments, using every moment at once), can improve on it inside this class.*

*Proof.* **Necessity.** $m_1/m_0=-\theta/(n-1)$ is a convex combination of the $\lambda_k$ with weights $g_k/m_0$, hence lies in $[\lambda_{\min},\lambda_{\max}]$; the left inequality is $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ and the right, $\theta\ge-(n-1)\lambda_{\max}$, is vacuous at $\theta>0$. **Sufficiency.** Put $c=-\theta/(n-1)\in[\lambda_{\min},\lambda_{\max}]$ and set all $g_k=0$ except at one index carrying $\lambda_{\min}$ and one carrying $\lambda_{\max}$, with

$$g_{\min}=4(n-1)\frac{\lambda_{\max}-c}{\lambda_{\max}-\lambda_{\min}},\qquad g_{\max}=4(n-1)\frac{c-\lambda_{\min}}{\lambda_{\max}-\lambda_{\min}} .$$

Both are $\ge0$, they sum to $4(n-1)$, and $\lambda_{\min}g_{\min}+\lambda_{\max}g_{\max}=4(n-1)c=-4\theta$. $\square$

**This is what "the moment problem closes" means, stated so it can be checked.** The block's paragraph gestures at it; the two-atom witness is what makes it a theorem, and it is one line. Note the witness is a legitimate $g$-distribution *for this class* (the class does not know that $g$ is a bracket norm) which is exactly why the class cannot do better.

**Consequence for the record.** The elimination display at [bounds.md](../findings/bounds.md) line 299 collapsing to $(n-1)m$ "exactly rather than approximately" is not a coincidence to be remarked on; it is forced, because $(n-1)\lvert\lambda_{\min}\rvert$ is the boundary of the feasible set. Likewise the "second derivation sharing nothing with the elimination" at line 303 is not independent: both are readings of the single fact that $m_1/m_0$ is a mean of the $\lambda_k$.

## 3. The clause that is false, and it was false at birth against its own file

> "The free data $G_2$ helps only if realizability constrains it through something positivity and support do not see, and **the only sources on the table are the Jacobi identity and first Bianchi acting on the $c$-tensor itself**, before squaring to $T$."

**REFUTED.** There is a third source, it is neither Jacobi nor Bianchi, it is numbered, and it is Gate-2 confirmed: **[Lemma L109](../findings/bounds-relaxations.md), the per-coordinate cap**

$$g_\gamma\ \le\ C:=2(n-2)(\lambda_{\max}-\lambda_{\min})^2 ,$$

three lines of Hölder against the row marginal $2(n-2)$ from (A) and $T\ge0$. Its own block says so in as many words: "*This is **outside** $\{g\ge0,\ \sum g=4(n-1)\}$, which is the information the recorded bound uses*" ([bounds-relaxations.md](../findings/bounds-relaxations.md) line 57). It is a constraint on individual atom *masses*, which no moment of $\mu$ sees.

**And it does bite.** Since $\lambda_{\max}^2+\lambda_{\min}^2\le\sum\lambda^2=1$, we get $(\lambda_{\max}-\lambda_{\min})^2\le2$, so

$$C\ \le\ 4(n-2)\ <\ 4(n-1)=m_0\qquad\text{at every unit }W .$$

L107's equality case is $\mathop{\mathrm{supp}}(g)\subseteq E_{\min}$, i.e. the whole mass $4(n-1)$ sits on the $\lambda_{\min}$-eigenspace. **Whenever $\lambda_{\min}$ is simple, the cap forbids that outright** (one index cannot carry $4(n-1)>C$) so L107 cannot be attained and the capped problem is strictly stronger there. The general bite condition is $\dim E_{\min}\cdot C<4(n-1)$, which is why nothing is lost at $S^k\times S^k$, where the two sides are equal. *This reproduces, by hand and independently, the condition [r593](REVIEW_r593.md)/[r594](REVIEW_r594.md) record on L109's own block; I reached it before reading theirs.*

**What the capped class returns** is a fractional-knapsack bound: order the $\Lambda^2$ spectrum increasingly, fill capacity $C$ from the bottom until mass $4(n-1)$ is used, and

$$4\theta=\sum_k(-\lambda_k)g_k\ \le\ C\sum_{j<J}(-\lambda_{(j)})+\big(4(n-1)-(J-1)C\big)(-\lambda_{(J)}),\qquad J=\lceil 4(n-1)/C\rceil\ \ge2 .$$

This is a **pinned** bound (it is a function of the spectrum alone) and it is strictly stronger than L107 whenever $\dim E_{\min}<J$. **So the headline survives (the conclusion is still pinned) while the clause under it is false (positivity and support are not the only $g$-side sources, and the pinned class has room above L107).** That is the exact shape of the defect: a true-but-empty headline carrying a false operative clause.

**Provenance makes this worse than an oversight.** L113's paragraph entered at `71d6d76a`, 2026-09-01 22:14:06. At that commit the cap display already stood at **line 491 of `findings/bounds.md` itself**, 180 lines below L113's own paragraph, in the same file, placed there by `eb31bc71` on **2026-08-26**. *The clause was false at birth against a display six days old in its own file.* (The 2026-09-02 split `2d66938e` later moved the cap to [bounds-relaxations.md](../findings/bounds-relaxations.md), so the two are in different files today; they were not then.)

## 4. Label, this is a fence post, and the record should say so

The brief asks for a literal label. Taking the record's own usage:

| candidate | fits? |
| --- | --- |
| **Lemma** | **No.** The block carries no proof, no hypothesis list and no delimited class; "the moral" is its own opening word |
| **Heuristic** | No, the underlying fact is provable, as §2.2 shows |
| **Fence post** | **Yes.** It is a statement about what a *family of routes* cannot do, which is what [fence-posts.md](../findings/fence-posts.md) is for, and its parent F42 is a fence post |

**Recommendation: move the paragraph to [fence-posts.md](../findings/fence-posts.md), and promote §2.2's completeness statement to the lemma number.** That is a real theorem with a one-line proof, it is strictly stronger than what L113 asserts, and it is checkable by a reader. Retiring the number entirely would also be defensible; what is not defensible is leaving a "Lemma" heading over a paragraph whose first word is "moral".

## 5. Staleness and provenance

`git log -S`, both directions, reported either way as the checklist requires.

| item | finding |
| --- | --- |
| L113's paragraph | `71d6d76a`, **2026-09-01 22:14:06**, *"feat(bounds): the g-moment problem closes, collapsing exactly to the Pi-bound"*. The heading was added later by `c14052fc`, 2026-09-02, a bulk heading commit, the same provenance [L117](../findings/INDEX-results.md) was found to have |
| **"a theorem-shaped extension of [post F42](../findings/fence-posts.md)"** | **STALE.** F42's conclusion was withdrawn in both directions by `365198e2` at **22:58:48 the same evening**, 44 minutes later: its premise was a single-row measurement misreported as the full system, and its inference ran from a looser LP's failure to a tighter LP's failure. **L113 still cites it as standing.** The paragraph was not stale at birth, but it has been stale for three days |
| **"the single open door … the question the whole route stands on"** | **STALE.** [r331](REVIEW_r331.md) was filed at **23:00:15**, 46 minutes later, and its §1.2 answers exactly that question: Jacobi is empty at linear order in $T$ (both $\delta$-contractions vanish termwise), Bianchi's content for $S=W$ is entirely spent producing (B), and (decisively for L113's phrasing), "*where Jacobi genuinely acts is on realizability of $c$ given $T$, **which is the original problem, not a relation***". So the door L113 elevates to load-bearing leads back to the conjecture |
| **the correction already exists, unnumbered** | [fence-posts.md](../findings/fence-posts.md) line 426, `30629d36`, **22:15:11 (65 seconds after L113's own commit**), carries the repaired rule: "*A pinned **value** $h(\lambda,\theta)$ still yields a real bound if the inequality against it is proved from constraints **stronger than (A)/(B)/(C)** … name the lever's weight pattern **and** the constraint set that proves the inequality.*" **That is precisely the delimitation L113 lacks, filed one commit later into the sibling file, and never folded back.** The brief's pattern (the twin corrected, the original left standing), with the roles of numbered and unnumbered reversed |
| boilerplate note | L113 carries **none** of the 21 boilerplate provenance notes. Nothing to check, and nothing false |
| Gate 2 | [INDEX-results.md](../findings/INDEX-results.md) row 113 reads "**Gate 2: no verdict on the record**", accurate. This review is the first |

## 6. Duplication

- **Numbered twin: none.** No second numbered block states L113.
- **Unnumbered near-twin: yes, one, and it is the corrected version.** [fence-posts.md](../findings/fence-posts.md) line 426 states a strictly more general rule that subsumes L113 and carries the constraint-set clause L113 omits. **Only the unnumbered one was ever repaired.**
- **A consumer paraphrases it as settled:** [LIT-invariants.md](LIT-invariants.md) line 112, "*the record's moment-problem closure says positivity and support of the $g$-distribution cannot leave the pinned class*". That use is **safe**: it argues only that $\lVert W^\#\rVert^2$ lies outside the $g$-distribution, so the closure does not reach it, which survives every correction above.
- **Displays.** The support inequality $\sum_k(\lambda_k-\lambda_{\min})(\lambda_{\max}-\lambda_k)g_k\ge0$ appears twice inside [bounds.md](../findings/bounds.md) (lines 295 and 303) and nowhere else; that is a restatement within one argument, not a cross-file duplicate.

## 7. Pointers

An anchor sweep of [bounds.md](../findings/bounds.md) against GitHub's slug rule finds **four dead in-file anchors**, one of them in the section that opens immediately above L113:

| line | anchor | fault |
| --- | --- | --- |
| **297** | `#lemma-l107--the-pi-bound-thetalen-1lvertlambda_minrvert-derived-twice` | **DEAD.** The heading lost its "derived twice" tail, [L107](../findings/INDEX-results.md)'s own Gate 2 found "derived twice" was one derivation, and the link was not updated. *The heading was corrected; the pointer to it was not* |
| 11 | same, plus a `-thetale-n-1…` variant | **DEAD**, two more spellings of the same stale tail |
| 11 | `[Lemma L108](#)` | **DEAD**, a bare placeholder |
| **411** | `[Lemma L104](../findings/LEDGER.md#lemma-l104-the-value-type-reduction)` | **DEAD, and it is the brief's exact case: [L104](../findings/bounds-relaxations.md) lives in [bounds-relaxations.md](../findings/bounds-relaxations.md), not here**, so no in-file anchor can ever resolve |

Resolving fine: the four anchors to L70, L71, L112 and L142, and L113's own out-links to [fence-posts.md](../findings/fence-posts.md), [r331](REVIEW_r331.md) and [r332](REVIEW_r332.md) (file-level, no fragment).

## 8. What survives, and what consumes it

**What survives.** The completeness theorem of §2.2, in place of the paragraph: *positivity plus the two pinned moments has exactly one consequence, and it is L107.* That is worth a number.

**Which escapes are named, and whether the list is right.** The block names one (Jacobi/Bianchi on the $c$-tensor) and it is both stale (§5) and incomplete (§3). **The honest list, from this audit:**

1. **Per-atom constraints**, of which [L109](../findings/bounds-relaxations.md) is the record's own instance. Live, unconditional, and strictly stronger than L107 wherever $\dim E_{\min}\cdot C<4(n-1)$. *The block should name it and does not.*
2. **The joint pinned LP** over (A), (B), (C) with $T\ge0$ ([L104](../findings/bounds-relaxations.md)'s value-type reduction), which is strictly stronger than any per-row or two-moment reading. Its ceiling is a separate question, and [I16](../plan.md) already records a kernel witness at $\theta=2.2913$ against $\theta_0(12)=1.2360$, *so the wider class is known not to close the conjecture either, which is the honest fence and is nowhere in L113*.
3. **Realizability of $c$ given $T$**, the Jacobi door, which [r331](REVIEW_r331.md) identifies as the original problem restated.

**What consumes L113.** Nothing load-bearing. One consumer ([LIT-invariants.md](LIT-invariants.md) line 112), used only in the safe direction; no route in [routes.md](../routes.md) and no item in [plan.md](../plan.md) is closed by it. **No route closure needs either half** (neither the impossibility nor the contraction identity) so the corrections below carry **zero blast radius**.

## 9. Recommended repairs, in priority order

1. **Delete the clause "the only sources on the table are the Jacobi identity and first Bianchi"** and replace it with the three-item list of §8. It is false against [L109](../findings/bounds-relaxations.md).
2. **Replace the paragraph with §2.2's completeness statement and its two-atom proof**, and keep the number on that. It is a theorem; the paragraph is not.
3. **Drop "theorem-shaped extension of post F42"**, or restate it as an extension of what survives F42 (the completeness of the relation list) since F42's conclusion is withdrawn.
4. **Retire "the single open door"**, citing [r331](REVIEW_r331.md) §1.2.
5. **Fold [fence-posts.md](../findings/fence-posts.md) line 426's constraint-set clause into the block**, so the delimitation lives with the claim.
6. **Table $\#$'s $\tfrac12$ and the phrase "pinned class"** in [conventions.md](../findings/conventions.md); the latter carries two opposed senses inside [bounds.md](../findings/bounds.md) alone (lines 309 and 413).
7. **Fix the four dead anchors** at [bounds.md](../findings/bounds.md) lines 11, 297 and 411.

## 10. Computation this audit did not run, and what it would decide

Per the standing rule, no computation was run and nothing above rests on any. One item is genuinely blocked:

- **Does the knapsack bound of §3 beat $\theta_0(n)$ anywhere it binds?** A sweep over spectra with simple $\lambda_{\min}$ would decide it. **If it never beats $\theta_0$**, the capped moment class is fenced too and the fence should be recorded at the wider class where L113 tried to place it. **If it does beat $\theta_0$ at some spectrum**, that spectrum is either unrealizable, making realizability the missing ingredient, as [I16](../plan.md) already suspects, or a counterexample. *The analytical half is done above; only the sweep is blocked.*
