# Verifier v255, L55 min-entry bound, its attainment and uniqueness at even n, the odd-n strictness clause, and the Lean statement

The brief ([BRIEF_L55.md](BRIEF_L55.md)) was read cold. No numerical work was done: no scripts, no computations, every value below exact and every counterexample in closed form. Log: [agent_logs/verify-L55-v255.log](../agent_logs/verify-L55-v255.log).

| # | Claim | Verdict |
|---|---|---|
| C1 | The inequality $\lvert\min_{a\ne b}K_{ab}\rvert\ge\sqrt{t/(n(n-1)(n-2))}$ (Passages A, B, C, D) | CONFIRMED (for $n\ge3$, the display being undefined at $n=2$, symmetry unused) |
| C2 | Attainment at even $n$ by the matching matrix, $c$ unsigned (A, C, D) | REFUTED AS STATED ($c<0$, $n\ge4$ even, is not attained), CONFIRMED for $c\ge0$ |
| C3 | Uniqueness: equality forces every row extreme and the rows into a fixed-point-free involution, so the extremizers are exactly the perfect matchings (A, B, C, D) | HYPOTHESIS-DEBT |
| C4 | Passage D: "at odd $n$ the bound is strict" | REFUTED AS STATED ($K=0$ attains equality at every odd $n\ge3$) |
| C5 | Passage D's closing sentence: holds on and off the diagonal locus, no information about $\theta$ alone | CONFIRMED AS ALGEBRA (the interpretive terms are undefined in the brief) |
| C6 | Passage E types the claim | CONFIRMED AS ALGEBRA for the inequality and attainment at $c>0$, with uniqueness, the symmetry of the extremizer and the min-form bridge are untyped |

Summary: the inequality is sound for $n\ge3$, but the equality-case argument names convexity where strict convexity is needed and never uses the symmetry that makes the pairing an involution, attainment needs $c\ge0$, and the odd-$n$ strictness clause fails at $K=0$.

## 0. Conventions, fixed once

- $K$ is a real $n\times n$ matrix, hollow ($K_{aa}=0$), with zero row sums ($\sum_bK_{ab}=0$), and $t=\lVert K\rVert_F^2=\sum_{a,b}K_{ab}^2$ over ordered pairs (brief, Definitions).
- $\mu:=\min_{a\ne b}K_{ab}$ and $m:=\lvert\mu\rvert$.
- $M_{\sigma,c}$ is the matching matrix: $K_{a\sigma(a)}=(n-2)c$, $K_{ab}=-c$ for $b\notin\{a,\sigma(a)\}$, $K_{aa}=0$.
- The row polytope is $P_m=\{x\in\mathbb R^{n-1}:\sum_bx_b=0,\ x_b\ge-m\}$.
- Quotation check: Passages A and B match [findings/diagonal-half.md](../findings/diagonal-half.md) lines 436, 452-456 and 458 verbatim, and Passages C and D match [results.md](../results.md) lines 206, 707 and 709 verbatim. Only those lines were displayed. Passage E matches [L55Statement.lean](../lean/HamiltonsCubic/Results/L55Statement.lean) verbatim except that the brief carries one trailing blank line (the file is 254 lines, the brief says 255).
- The Lean file was read in full, not rebuilt. It contains no `sorry`, `axiom`, `admit` or `native_decide` (the word "sorry" occurs once, in the docstring). Its build artifact is newer than the source, which is consistent with a clean build and is reported as that, not as a check.

## 1. Hypothesis inventory

| Hypothesis | Stated in | Used by the inequality (C1) | Used by uniqueness (C3) |
|---|---|---|---|
| Hollow, $K_{aa}=0$ | A, C, D, E | Yes: the off-diagonal row sums to $-K_{aa}=0$, and $s_a$ carries no diagonal term | Yes: the row vector excludes the diagonal, which makes $\sigma(a)\ne a$ |
| Zero row sums | A, C, D, E | Yes: $\sum_bx_b=0$ defines $P_m$ | Yes |
| Symmetric | A, C, D, and E only in [min_entry_bound_symm](../lean/HamiltonsCubic/Results/L55Statement.lean#L147), where it is unused | No | Yes, and load-bearing (Section 4.3), but never invoked by Passage B or D |
| $\lVert K\rVert_F^2=t$, ordered pairs | A, C, D, E | Yes | Yes |
| $n\ge3$ | E only ([min_entry_bound](../lean/HamiltonsCubic/Results/L55Statement.lean#L131), `hn : 3 ≤ n`) | Used but unstated in A to D: the display divides by $n(n-1)(n-2)$ | Used but unstated |
| $c\ge0$ (or $c>0$) | E only ([matching_min](../lean/HamiltonsCubic/Results/L55Statement.lean#L229), `hc : 0 < c`) | n/a | Used but unstated in A to D (Section 3) |
| $K\ne0$, i.e. $m>0$ | Nowhere | n/a | Used but unstated by the step "equality forces ... a fixed-point-free involution, existing exactly for even $n$" (Section 5) |

## 2. C1, the inequality

### 2.1 The chain, link by link

1. **$\mu\le0$, so $m=-\mu$.** For $n\ge3$ each row has $n-1\ge2$ off-diagonal entries summing to $0$, so the smallest is $\le0$. Passage B writes $m=\lvert\min_bK_{ab}\rvert$ with the diagonal included, which equals $\lvert\mu\rvert$ because $K_{aa}=0\ge\mu$. The record leaves this step implicit, and it is immediate.
2. **Each entry is at least $-m$.** This holds in every row, since $\mu$ is the global minimum.
3. **Each entry is at most $(n-2)m$.** $x_b=-\sum_{b'\ne b}x_{b'}\le(n-2)m$, the sum running over $n-2$ entries each $\ge-m$. Correct.
4. **The extreme points of $P_m$.** Put $y=x+m\mathbf 1$. Then $P_m=\{y\ge0,\ \sum y=(n-1)m\}$, a scaled standard simplex whose vertices are $y=(n-1)m\,e_i$, i.e. $x_i=(n-2)m$ and $x_j=-m$ otherwise. This matches the passage, and at $m=0$ the polytope is the single point $0$.
5. **The maximum of a convex functional sits at an extreme point.** $P_m$ is compact and is the convex hull of its vertices. For $x=\sum\lambda_iv_i$, $f(x)\le\sum\lambda_if(v_i)\le\max_if(v_i)$. With $f=s_a=\lVert x\rVert^2$ the vertex value is $(n-2)^2m^2+(n-2)m^2=(n-1)(n-2)m^2$, the same at every vertex. Correct.
6. **Summing over rows.** $t=\sum_as_a\le n(n-1)(n-2)m^2$. Passage B bounds "the row $a$ achieving the minimal entry" and then sums over all rows. The row-$a$ argument uses nothing about row $a$ except link 2, which holds for every row, so the sum is justified (see withdrawn candidate W1).
7. **The display.** For $n\ge3$, $n(n-1)(n-2)>0$, so $m^2\ge t/(n(n-1)(n-2))$ and $m\ge\sqrt{t/(n(n-1)(n-2))}$ as $m\ge0$.

The hypotheses used are hollowness, zero row sums and $n\ge3$. Symmetry is never used.

### 2.2 Candidates

- **$n=2$, unstated $n\ge3$.** (1) Passage A says "Let $K$ be hollow, symmetric, with zero row sums", with no range for $n$, and the display has denominator $n(n-1)(n-2)$. (2) At $n=2$ hollow plus zero row sums gives $K_{12}=K_{21}=0$, so $K=0$, $t=0$ and the right side is $\sqrt{0/0}$, undefined. At $n=1$, $\min_{a\ne b}$ ranges over the empty set. (3) Charitable reading: the only matrix at $n=2$ is $0$, so nothing false is asserted, and the lemma is plainly meant for $n\ge3$, as Lean's `hn : 3 ≤ n` makes explicit. The candidate survives as a hypothesis correction ($n\ge3$), and it matters for C2 and C3 because "for even $n$" includes $n=2$ as written. It does not change the mathematics at $n\ge3$.

## 3. C2, attainment by the matching matrix

### 3.1 Derivation

Take $n\ge4$ even and $\sigma$ a fixed-point-free involution. $M_{\sigma,c}$ is hollow with row sums $(n-2)c-(n-2)c=0$. It is symmetric: $K_{\sigma(a)a}=(n-2)c$ because $\sigma(\sigma(a))=a$, and for $b\notin\{a,\sigma(a)\}$ also $a\notin\{b,\sigma(b)\}$, so $K_{ba}=-c$. Each row has $s_a=(n-2)^2c^2+(n-2)c^2=(n-1)(n-2)c^2$, so $t=n(n-1)(n-2)c^2$ and $\sqrt{t/(n(n-1)(n-2))}=\lvert c\rvert$.

- $c>0$: $\mu=-c$ (the $-c$ entries exist because $n\ge3$), so $m=c$. Attained.
- $c=0$: $M_{\sigma,0}=0$ and $m=0$. Attained.
- $c<0$: the entries are $(n-2)c<0$ and $-c>0$, so $\mu=(n-2)c$ and $m=(n-2)\lvert c\rvert>\lvert c\rvert$ for $n\ge4$. Not attained.

### 3.2 Candidate, $c<0$

1. **Location.** Passage A says "the extremizers being exactly the perfect matchings: $K_{ab}=(n-2)c$ on a fixed-point-free involution and $-c$ elsewhere". Passages C and D say the same, and none of them restricts the sign of $c$.
2. **Failure.** Take $n=4$, $\sigma=(12)(34)$, $c=-1$. Then $K_{12}=K_{21}=K_{34}=K_{43}=-2$, every other off-diagonal entry is $1$, and the diagonal is $0$. Every row reads $0,-2,1,1$ in some order, with sum $0$ and $s_a=6$. So $t=24$, $n(n-1)(n-2)=24$ and the bound is $1$, while $\lvert\min\rvert=2$. This is a perfect matching in the passage's form and it is not an extremizer, so the "every perfect matching is an extremizer" direction of "exactly" fails.
3. **Charitable reading.** $c$ is meant to be positive, since "$-c$ elsewhere" is intended as the minimum entry and $c=m$ in Passage B's equality case. On that reading the claim holds. The Lean docstring (lines 21-23) records that an audit note supplies $c>0$. The reading is a correction of the statement rather than a reading of its words, and "exactly" asserts both directions over an unsigned $c$. The candidate stands as REFUTED AS STATED, corrected by $c\ge0$.

## 4. C3, uniqueness of the extremizers

Passage B's link is: "equality forces every row extreme, one entry $(n-2)c$, the rest $-c$, which pairs the rows into a fixed-point-free involution, existing exactly for even $n$." Passage D repeats it: "Equality forces every row extreme, which pairs the rows into a fixed-point-free involution."

### 4.1 "Equality forces every row extreme": the named reason is insufficient

1. **Location.** Passage B justifies the row bound by "the extreme point maximising the convex functional $s_a$", and D by "the row norm, convex, is maximised there". Equality in $t\le\sum_a(n-1)(n-2)m^2$ forces $s_a=(n-1)(n-2)m^2$ in every row. That step is correct. The next step, that each row is then an extreme point, is asserted.
2. **Failure of the cited property.** Convexity alone does not place maximisers only at extreme points. On the same polytope $P_m$ with $n\ge4$ and $m>0$, the linear (hence convex) functional $f(x)=x_1+x_2=y_1+y_2-2m$ has maximum $(n-3)m$, attained on the whole edge $\{y_1+y_2=(n-1)m\}$, which includes the non-extreme midpoint $x_1=x_2=\tfrac{n-3}2m$, $x_j=-m$ otherwise. So the property the record names does not deliver the conclusion.
3. **Charitable reading.** $s_a=\lVert x\rVert^2$ is strictly convex, and for a strictly convex functional a non-extreme point lies strictly below the maximum. This is standard and one line long, but it is on file neither in B nor in D. Under the rule that a missing argument is recorded rather than supplied, it is debt. It also needs $m>0$: at $m=0$ the conclusion holds trivially because $P_0=\{0\}$.

### 4.2 "One entry $(n-2)c$, the rest $-c$"

At a vertex of $P_m$ one coordinate is $(n-2)m$ and the rest are $-m$, with $c=m$ in every row because $m$ is global. $\sigma(a)$, the index of the $(n-2)m$ entry, is well defined only if $(n-2)m\ne-m$, i.e. $m>0$. The record does not note this.

### 4.3 "Which pairs the rows into a fixed-point-free involution": symmetry is load-bearing and never invoked

1. **Location.** "which pairs the rows into a fixed-point-free involution" (B), and the same words in D. Neither passage mentions symmetry at this step or anywhere in the proof.
2. **Failure without symmetry.** Take $n\ge3$ odd, $\tau(a)=a+1\bmod n$, and $K_{a\tau(a)}=n-2$, $K_{ab}=-1$ for $b\notin\{a,\tau(a)\}$, $K_{aa}=0$. It is hollow, with row sums $(n-2)-(n-2)=0$, every row a vertex of $P_1$, and $t=n(n-1)(n-2)$, so the bound $1$ equals $\lvert\min\rvert=1$. Equality holds, yet $\tau$ is not an involution for $n\ge3$ and no fixed-point-free involution exists at odd $n$. At $n=3$ this is $K=\begin{pmatrix}0&1&-1\\-1&0&1\\1&-1&0\end{pmatrix}$ with $t=6$ and bound $1=\lvert\min\rvert$. So "every row extreme" does not imply "pairs into an involution" from the hypotheses the proof actually cites (hollow, zero row sums).
3. **Charitable reading.** The statement does carry symmetry, and with it $K_{\sigma(a)a}=K_{a\sigma(a)}=(n-2)m$, so $\sigma(\sigma(a))=a$, while $\sigma(a)\ne a$ comes from the row vector excluding the diagonal. The step is then true, but its one essential ingredient is absent from the written chain. The cyclic example shows that ingredient cannot be dropped, so the omission is not cosmetic. It stays as debt.

### 4.4 "Existing exactly for even $n$"

This is the standard fact that a fixed-point-free involution partitions $\{1,\dots,n\}$ into 2-cycles. It is asserted without argument, is standard, and is listed in the debt as minor. It holds only once $m>0$ has been used to define $\sigma$ (Section 5).

### 4.5 What would have to be proved

- (i) Strict convexity: at $m>0$, $s_a=(n-1)(n-2)m^2$ on $P_m$ only at vertices.
- (ii) $m>0$ (i.e. $t>0$, $K\ne0$), so that $\sigma(a)$ is well defined, with the case $K=0$ treated separately ($K=0=M_{\sigma,0}$ at even $n$).
- (iii) Symmetry gives $\sigma^2=\mathrm{id}$, and hollowness gives $\sigma(a)\ne a$.
- (iv) Minor: fixed-point-free involutions exist exactly for even $n$.

The claim is not refuted: with (i) to (iii) supplied, the extremizers at even $n\ge4$ are exactly the $M_{\sigma,c}$ with $c\ge0$. As written the equality argument is incomplete, and the verdict is HYPOTHESIS-DEBT.

## 5. C4, "at odd $n$ the bound is strict" (Passage D)

1. **Location.** Passage D: "so for even $n$ the extremizers are exactly the perfect matchings, ... and at odd $n$ the bound is strict."
2. **Failure.** $K=0$ at any odd $n\ge3$ is hollow, symmetric, with zero row sums and $t=0$. Then $\lvert\min_{a\ne b}K_{ab}\rvert=0=\sqrt{0/(n(n-1)(n-2))}$, which is equality. At $n=3$ it is the only admissible matrix: symmetry and zero row sums give $K_{13}=-K_{12}$, $K_{23}=-K_{21}=-K_{12}$, and $K_{32}=-K_{31}=-K_{13}=K_{12}$, while symmetry demands $K_{32}=K_{23}=-K_{12}$, so $K_{12}=0$ and $K=0$. At $n=3$, then, the bound is attained by every admissible matrix and is never strict.
3. **Charitable reading.** "Strict for $K\ne0$" is what is meant. That corrected form is true, but it rests on C3's debt items (i) to (iii), and by the cyclic example of Section 4.3 it is false once symmetry is dropped. The failure at $K=0$ comes from the record's own chain: at $m=0$, "equality forces ... a fixed-point-free involution" does not follow, because no $\sigma$ is defined. The candidate stands as REFUTED AS STATED, corrected by $K\ne0$ together with symmetry.

Passage A and Passage C make no odd-$n$ strictness claim, so this finding is confined to D and to the clause "existing exactly for even $n$" in B.

## 6. C5, Passage D's closing sentence

- "Holds on and off the diagonal locus alike": the hypotheses and conclusion of L55 mention only $K$, $n$ and $t$. Any predicate defining a locus is absent from the hypotheses, so the inequality holds for every admissible $K$ wherever it lies. CONFIRMED AS ALGEBRA.
- "What it bounds is the smallest sectional curvature" and "no information about $\theta$ on its own": neither sectional curvature nor $\theta$ is defined in the brief. Formally the lemma's statement contains no $\theta$. Whether it constrains $\theta$ in combination with the programme's other relations is not checkable from the brief and was not checked.
- "The lemma is about hollow zero-row-sum matrices": see W2.

## 7. C6, Passage E against Passages A and D

| Theorem | What it states | Relation to the record |
|---|---|---|
| [entry_le](../lean/HamiltonsCubic/Results/L55Statement.lean#L51), [row_bound](../lean/HamiltonsCubic/Results/L55Statement.lean#L82), [frobenius_le](../lean/HamiltonsCubic/Results/L55Statement.lean#L112) | Links 3, 5 and 6 for any lower bound $-m$, hollow and zero row sums, no symmetry. `row_bound` replaces the extreme-point argument with the pointwise $(x+m)((n-2)m-x)\ge0$ | The inequality's chain, by a different route for link 5 |
| [min_entry_bound](../lean/HamiltonsCubic/Results/L55Statement.lean#L131) | `3 ≤ n`, `0 ≤ m`, `∀ a b, -m ≤ K a b` give $\sqrt{t/(n(n-1)(n-2))}\le m$ | Equivalent to the display: $-\mu$ is a lower bound over all entries (diagonal included, as $\mu\le0$), and every lower bound $m$ satisfies $m\ge-\mu$. The bridge from "any lower bound" to "$\lvert\min_{a\ne b}\rvert$" is in the docstring only, not typed |
| [min_entry_bound_symm](../lean/HamiltonsCubic/Results/L55Statement.lean#L147) | Same with `hsymm`, unused | The record's hypothesis set verbatim |
| [matching_hollowZeroRow](../lean/HamiltonsCubic/Results/L55Statement.lean#L164), [matching_frobenius](../lean/HamiltonsCubic/Results/L55Statement.lean#L193), [matching_min](../lean/HamiltonsCubic/Results/L55Statement.lean#L229), [matching_equality](../lean/HamiltonsCubic/Results/L55Statement.lean#L235) | $M_{\sigma,c}$ is hollow with zero row sums, $t=n(n-1)(n-2)c^2$, $-c$ is a lower bound at $c>0$, and the bound value equals $c$ | Attainment at $c>0$, which composes to $\lvert\min\rvert=c=$ bound. The composition is not stated as one theorem |

Binders and hypotheses:
- `hn : 3 ≤ n` excludes $n=1,2$, where the record's display is undefined. This matches the correction of Section 2.2.
- `hm0 : 0 ≤ m` is redundant: `hm` at $a=b$ with hollowness gives $-m\le0$. It excludes nothing.
- `hc : 0 < c` excludes $c\le0$. $c<0$ is correctly excluded (Section 3.2). $c=0$ is attainment by $K=0$, which the file omits, and that is harmless.
- `hinv` is carried by `matching_hollowZeroRow` but its proof never uses it. The property it would supply, **symmetry of $M_{\sigma,c}$**, is not stated anywhere in the file. The attainment theorems therefore place the extremizer in `IsHollowZeroRow`, the class without symmetry, and not in the record's symmetric class. The symmetry is true (Section 3.1) and untyped.
- Uniqueness is untyped, which the file says at lines 28-31. In the file's own class `IsHollowZeroRow` the uniqueness claim is false, as the cyclic example of Section 4.3 shows (equality at odd $n$ with $K\ne0$). A uniqueness theorem added to this file would need the symmetry hypothesis.

## 8. Withdrawn candidates

- **W1, the row bound proved for one row and summed over all.** (1) Passage B: "Fix the row $a$ achieving the minimal entry and let $m=\lvert\min_bK_{ab}\rvert$ ... Summing over rows". (2) Failure: none can be exhibited, since for any row $a'$, $K_{a'b}\ge\mu=-m$. (3) Charitable reading: the row-$a$ argument uses only the global lower bound, so it applies to every row verbatim. Withdrawn at step 2.
- **W2, Passage D's "the lemma is about hollow zero-row-sum matrices" dropping symmetry.** (1) Passage D, closing sentence. (2) Read as a statement for the non-symmetric class, the uniqueness and odd-strictness clauses fail by the cyclic $K$ of Section 4.3. (3) Charitable reading: D's first sentence states "hollow symmetric", and the closing sentence contrasts the matrix class with the diagonal locus without restating hypotheses. Withdrawn at step 3.
- **W3, the Lean docstring's "The record proves it from strict convexity plus the symmetry step forcing $\sigma^2=\mathrm{id}$" (lines 29-30).** (1) Lines 29-30 of the Lean file. (2) Passages B and D contain neither strict convexity nor symmetry at the equality step. (3) Charitable reading: "the record" may include the audit notes between the heading and the statement in [findings/diagonal-half.md](../findings/diagonal-half.md), which this verifier was barred from reading. Withdrawn at step 3 because it cannot be established. The proof text as quoted carries neither ingredient, which is C3's finding.
- **W4, the unordered reading of $t$.** (1) Attack item 6. (2) If $t$ were $t_u=\sum_{a<b}K_{ab}^2$, then under symmetry $t=2t_u$, the display in $t_u$ is $\sqrt{t_u/(n(n-1)(n-2))}$, a bound weaker by $\sqrt2$, and the matching gives $\lvert c\rvert/\sqrt2<\lvert c\rvert$, so sharpness would fail. (3) The statement writes $\lVert K\rVert_F^2=t$, which is the ordered sum by definition, and the brief's Definitions and Lean agree. Withdrawn at step 3. Under the unordered convention the sharp constant is $n(n-1)(n-2)/2$. Without symmetry, $t_u$ is not a function of $t$.

## 9. The standing list

1. **Hypothesis inventory.** Section 1. The inequality uses hollowness, zero row sums and $n\ge3$. Uniqueness additionally uses symmetry and $K\ne0$. Unstated but used: $n\ge3$ throughout, $c\ge0$ for attainment, and $K\ne0$ for the odd-$n$ strictness and the definition of $\sigma$.
2. **Quantifier order and scope.** No finding on the inequality, which is a statement for all admissible $K$. Attainment reads "for each even $n$ and each $t\ge0$ some admissible $K$ attains", which holds with $c=\sqrt{t/(n(n-1)(n-2))}\ge0$. "Exactly" quantifies over all fixed-point-free involutions $\sigma$ and all $c$, and there the unsigned $c$ fails (Section 3.2).
3. **The edges.** $n=2$: display undefined (Section 2.2). $n=3$: only $K=0$ is admissible, and there is equality (Section 5). Odd $n$: $K=0$ gives equality, and $K\ne0$ with symmetry is strict subject to C3's debt. $K=0$: equality at every $n\ge3$, the matching with $c=0$ at even $n$, and a counterexample to D's clause at odd $n$. $c<0$: not attained at even $n\ge4$ (Section 3.2).
4. **Proven versus stated.** Proven: the inequality at $n\ge3$, and attainment at $c\ge0$. Stated but not proven on file: uniqueness (Section 4.5). Stated and false as written: attainment for all $c$, and odd-$n$ strictness including $K=0$.
5. **Lean.** Section 7. The theorems are the inequality and attainment at $c>0$ with correct binders. `hn` and `hc` exclude exactly the cases the record gets wrong or leaves undefined, `hm0` excludes nothing, and symmetry of the extremizer and uniqueness are untyped.
6. **The brief's attack items.** Section 10.
7. **Falsifying objects and the search.**
   - C1: a hollow zero-row-sum $K$ at $n\ge3$ with $t>n(n-1)(n-2)m^2$. None exists, since each link of Section 2.1 was checked, including the vertex computation of $P_m$.
   - C2: a matching with $\lvert\min\rvert\ne$ bound. Found: $c<0$ at $n=4$.
   - C3: a symmetric extremizer at even $n$ that is not $M_{\sigma,c}$. None found under symmetry. Without symmetry the cyclic $K$ exists, which is what shows the missing step is load-bearing.
   - C4: equality at odd $n$. Found: $K=0$.
   - C5: a hypothesis referring to a locus. None, since the hypotheses were read.
   - C6: a binder that excludes a case the record covers. Only $n\le2$ and $c\le0$, both justified.

## 10. The brief's "What to attack" items

1. **The inequality.** Section 2.1: the polytope is a shifted simplex with the stated vertices, and the convex maximum sits at a vertex via the convex-hull representation. It uses hollowness and zero row sums, with symmetry unused. No finding beyond the unstated $n\ge3$.
2. **Attainment and uniqueness.** Attainment holds for $c\ge0$ and fails for $c<0$ at $n\ge4$ (Section 3). Uniqueness is not argued: strictness is cited as convexity (Section 4.1), $m>0$ is needed to define $\sigma$ (Section 4.2), and symmetry, required by the cyclic example, is never invoked (Section 4.3). HYPOTHESIS-DEBT.
3. **The zero matrix.** At even $n\ge4$, $K=0=M_{\sigma,0}$ attains the bound, consistent with A, C and D if $c=0$ is admitted. At odd $n\ge3$, $K=0$ attains the bound, which contradicts D's "strict" (Section 5) and B's "existing exactly for even $n$" as a consequence of equality. A and C make no odd-$n$ claim.
4. **"At odd $n$ the bound is strict".** False at $K=0$. The strict statement needs $K\ne0$ and symmetry, plus debt items (i) to (iii).
5. **D's closing sentence.** Section 6: the locus-independence is confirmed as algebra, and the curvature and $\theta$ remarks are not checkable from the brief's definitions.
6. **Ordered pairs.** W4: under the unordered reading the constant becomes $n(n-1)(n-2)/2$ (with symmetry). The record's $\lVert K\rVert_F^2$ fixes the ordered reading, so no finding.
7. **Passage E.** Section 7.
8. **The boundary.** Section 9, item 3.

## Overall verdict

**HYPOTHESIS-DEBT.**
- The inequality is proven for $n\ge3$.
- The equality characterisation lacks strict convexity, the $m>0$ case split, and the symmetry step that makes $\sigma$ an involution. All three are named in Section 4.5.
- Two clauses are refuted as stated and need corrected hypotheses: attainment needs $c\ge0$, and Passage D's odd-$n$ strictness needs $K\ne0$.
