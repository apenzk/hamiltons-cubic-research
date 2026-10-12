# Verifier v253, L55 min-entry bound: the inequality, attainment by perfect matchings, uniqueness of extremisers, odd-n strictness, the closing gloss, and the Lean statement

The brief was cold. No numerical work was done, every value below is exact and in closed form, and no scripts were written or run. Log: [agent_logs/verify-L55-v253.log](../agent_logs/verify-L55-v253.log).

| Claim | Verdict |
|---|---|
| C1. The inequality $\lvert\min_{a\ne b}K_{ab}\rvert\ge\sqrt{t/(n(n-1)(n-2))}$ (Passages A, C and D, proof B) | CONFIRMED (for $n\ge3$, a range the statement leaves implicit) |
| C2. Attainment by the matching matrix $K_{a\sigma(a)}=(n-2)c$, $-c$ elsewhere | REFUTED AS STATED (true exactly for $c\ge0$. At $c<0$ the bound is missed by the factor $n-2$) |
| C3. Uniqueness: the extremisers are exactly the perfect matchings | HYPOTHESIS-DEBT |
| C4. Passage D: "at odd $n$ the bound is strict" | REFUTED AS STATED ($K=0$ is an equality case at every odd $n\ge3$, and at $n=3$ it is the whole class) |
| C5a. Passage D: the lemma holds on and off the diagonal locus | CONFIRMED |
| C5b. Passage D: it bounds the smallest sectional curvature and carries no information about $\theta$ alone | HYPOTHESIS-DEBT |
| C6. Passage E, the Lean file, against Passages A and D | GAP |

Summary: the inequality is proved for $n\ge3$ and attainment holds with $c\ge0$, but the uniqueness half rests on two inferences that Passage B asserts without argument, and Passage D's odd-$n$ strictness fails at $K=0$.

## 0. Conventions, fixed once

- $K$ is a real $n\times n$ matrix, hollow ($K_{aa}=0$), with zero row sums ($\sum_bK_{ab}=0$). Symmetry ($K_{ab}=K_{ba}$) is tracked separately in every section, because the inequality and the equality case use it differently.
- $t=\lVert K\rVert_F^2=\sum_{a,b}K_{ab}^2$ over ordered pairs. $\mu:=\min_{a\ne b}K_{ab}$ and $m:=\lvert\mu\rvert$.
- For $n\ge2$ and every row $a$, the off-diagonal entries sum to $-K_{aa}=0$, so $\mu\le0$ and $m=-\mu\ge0$. Every off-diagonal entry of every row is then $\ge-m$.
- $D_n:=n(n-1)(n-2)$. $M(\sigma,c)$ denotes the matching matrix of the Definitions: $(n-2)c$ at $(a,\sigma(a))$, $0$ on the diagonal, $-c$ elsewhere.
- Quotations were checked against source. Passage A matches [findings/diagonal-half.md](../findings/diagonal-half.md) lines 452-456 (heading line 436), Passage B matches line 458, Passage C matches [results.md](../results.md) line 206, Passage D matches line 709 (heading line 707), all verbatim. Passage E matches [lean/HamiltonsCubic/Results/L55Statement.lean](../lean/HamiltonsCubic/Results/L55Statement.lean) character for character. The file has 254 lines, and the brief's "255" counts one trailing blank line. Lean line numbers below are file lines, which are the brief's line numbers minus 27.
- The Lean file was read, and it was not compiled. Its build artefact is dated after the source's modification time.

## 1. Hypothesis inventory

| Hypothesis | Stated in A, C, D | Used by the inequality (C1) | Used by the equality case (C3, C4) |
|---|---|---|---|
| Hollow | yes | yes: the row's off-diagonal entries sum to $-K_{aa}=0$, and $s_a$ equals the off-diagonal row norm | yes, through C1 |
| Zero row sums | yes | yes: the row polytope's defining equation | yes |
| Symmetric | yes | no | yes, to turn "one large entry per row" into an involution (Section 3.3). Passage B never names it |
| $n\ge3$ | no | yes: $D_n>0$ is needed for the display to be defined | yes |
| $c\ge0$ for the extremiser | no | not applicable | yes (Section 2) |
| $t>0$ (equivalently $m>0$) | no | no | yes, for B's "pairs the rows into a fixed-point-free involution" and for D's strictness (Sections 3, 4) |

Hollowness and zero row sums are load-bearing for the inequality, as two closed-form objects show.

- **Without hollowness.** $K=I-\tfrac1nJ$ has zero row sums, off-diagonal entries $-1/n$, so $m=1/n$. Its $t=n\big((1-\tfrac1n)^2+\tfrac{n-1}{n^2}\big)=n-1$. The display would require $\tfrac1n\ge\sqrt{\tfrac{n-1}{D_n}}=\tfrac1{\sqrt{n(n-2)}}$, i.e. $n(n-2)\ge n^2$, which is false for every $n\ge3$.
- **Without zero row sums.** At $n=3$, the hollow symmetric $K$ with $K_{12}=K_{13}=1$, $K_{23}=\varepsilon$, $0<\varepsilon<1$, has $\mu=\varepsilon>0$ and $t=4+2\varepsilon^2$. The display requires $\varepsilon\ge\sqrt{(4+2\varepsilon^2)/6}$, which fails because the right side exceeds $\sqrt{2/3}>\varepsilon$ once $\varepsilon<\sqrt{2/3}$.

Both hypotheses are stated, so neither object is a finding against the lemma. They confirm that the inventory is correct.

## 2. Claim C1, the inequality

### 2.1 The chain of Passage B, link by link

1. "Fix the row $a$ achieving the minimal entry and let $m=\lvert\min_bK_{ab}\rvert$." The minimum over all $b$ includes $K_{aa}=0$. Since the row's off-diagonal minimum is $\le0$ (Conventions), the two minima agree, and $m=\lvert\mu\rvert$. Correct.
2. "$n-1$ entries summing to $-K_{aa}=0$, each entry $\ge-m$." Hollowness and zero row sums give the sum. The lower bound holds because $m$ is the global minimum. Correct.
3. "so each entry is also $\le(n-2)m$." The other $n-2$ entries sum to at least $-(n-2)m$, so any one entry is at most $(n-2)m$. Correct. This link shows the polytope is bounded.
4. "the row polytope $\{x\in\mathbb R^{n-1}:\sum x_b=0,\ x_b\ge-m\}$, whose extreme points have one coordinate at $(n-2)m$ and the rest at $-m$." With $y=x+m\mathbf 1$ the set becomes $\{y\ge0,\ \sum y_b=(n-1)m\}$, a simplex with vertices $(n-1)m\,e_j$. In the $x$ coordinates these are $(n-2)m$ at $j$ and $-m$ elsewhere. At $m=0$ the set is the single point $0$, which the same formula gives. Correct.
5. "$s_a\le(n-2)^2m^2+(n-2)m^2=(n-1)(n-2)m^2$, the extreme point maximising the convex functional $s_a$." A convex function on the convex hull of finitely many points is bounded by its largest vertex value, since $f(\sum\lambda_iv_i)\le\sum\lambda_if(v_i)$. All $n-1$ vertices have the same value $(n-2)^2m^2+(n-2)m^2$. The arithmetic is $(n-2)m^2\big((n-2)+1\big)=(n-1)(n-2)m^2$. Correct.
6. "Summing over rows, $t=\sum_as_a\le n(n-1)(n-2)m^2$." Link 5 used only that every entry of row $a$ is $\ge-m$, which holds in every row, so the bound applies to each row. The proof names one fixed row and then sums over all of them. The charitable reading, that the fixed row is incidental, is forced by link 2 and is correct.
7. "which is the display." For $D_n>0$, $t\le D_nm^2$ with $m\ge0$ is equivalent to $m\ge\sqrt{t/D_n}$. Correct for $n\ge3$.

### 2.2 The edge of the range

- **$n=2$.** Row 1 gives $K_{12}=-K_{11}=0$, and row 2 gives $K_{21}=0$, so the class is $\{0\}$. Then $t=0$ and $D_2=0$, so the display reads $0\ge\sqrt{0/0}$, which is undefined over $\mathbb R$. The cleared form $t\le D_nm^2$ reads $0\le0$ and holds.
- **$n=1$.** $\min_{a\ne b}$ is a minimum over the empty set.
- **$n\ge3$.** The chain holds as written.

The statement carries no range on $n$. The correction is to state $n\ge3$, which Passage E does. This is a range hypothesis, and the lemma's content is unaffected.

### 2.3 Which hypotheses the inequality uses

Hollowness (links 2, 5), zero row sums (link 2), and $n\ge3$ (link 7). Symmetry is used nowhere. Passage E's claim that symmetry is inert for the inequality is correct.

**Verdict C1: CONFIRMED, for $n\ge3$.**

## 3. Claims C2 and C3, attainment and uniqueness

### 3.1 Attainment (C2)

Take $n\ge4$ even, $\sigma$ a fixed-point-free involution, and $M=M(\sigma,c)$.

- Hollow: $\sigma(a)\ne a$, so the diagonal is $0$.
- Symmetric: $b=\sigma(a)$ if and only if $a=\sigma(b)$, by $\sigma^2=\mathrm{id}$.
- Row sums: $(n-2)c+(n-2)(-c)=0$, since row $a$ has $n-2$ entries off $\{a,\sigma(a)\}$.
- $t=n\big((n-2)^2c^2+(n-2)c^2\big)=D_nc^2$, so $\sqrt{t/D_n}=\lvert c\rvert$.
- The off-diagonal entries take the values $(n-2)c$ and $-c$, each occurring, since $n-2\ge2$.

For $c\ge0$: $(n-2)c\ge-c$, so $\mu=-c$ and $m=c=\sqrt{t/D_n}$. Equality holds.

For $c<0$: $(n-2)c<0<-c$, so $\mu=(n-2)c$ and $m=(n-2)\lvert c\rvert$. Since $n-2\ge2$, $m=(n-2)\sqrt{t/D_n}>\sqrt{t/D_n}$, and the bound is strict.

Passage B does not verify attainment separately. It follows from its link 5 value, read backwards with $m=c$, and that reading needs $\mu=-c$, which is the sign condition.

### 3.2 Candidate: the extremiser family admits $c<0$

1. **Location.** Passage A: "the extremizers being exactly the perfect matchings: $K_{ab}=(n-2)c$ on a fixed-point-free involution and $-c$ elsewhere." Passage C and Passage D carry the same formula. None of them signs $c$.
2. **Closed-form failure.** At $n=4$, $\sigma=(1\,2)(3\,4)$, $c=-1$: $K_{12}=K_{21}=K_{34}=K_{43}=-2$ and every other off-diagonal entry is $1$. Then $t=4(4+1+1)=24$, $D_4=24$, $\sqrt{t/D_4}=1$, and $\lvert\mu\rvert=2$. The bound is missed by the factor $2=n-2$. This $K$ is hollow, symmetric, with zero row sums, and it is a perfect-matching matrix in the statement's sense, so the set named as "exactly the extremizers" contains a non-extremiser.
3. **Charitable reading.** In Passage B, $c$ appears only as the value $m\ge0$ of the rows it forces, so the author plausibly means $c\ge0$. The statement as a reader receives it has no such restriction, and Passage E records the omission itself (file lines 21-23). The charitable reading corrects the statement. It does not rescue it as written.

The candidate stands. The correction is $c\ge0$. The weaker condition $c>0$ used in Passage E drops $K=0$ from the family, which Section 3.4 shows is an extremiser at every even $n\ge4$. So $c\ge0$ is the correct range for the "exactly" clause, and $c>0$ is correct for attainment with $t>0$.

**Verdict C2: REFUTED AS STATED. It is true exactly for $c\ge0$.**

### 3.3 Uniqueness (C3): the written chain

Passage B: "and equality forces every row extreme, one entry $(n-2)c$, the rest $-c$, which pairs the rows into a fixed-point-free involution, existing exactly for even $n$." Passage D says the same in other words. Four inferences are packed into this sentence.

- **(U1)** Equality in $t\le D_nm^2$ forces $s_a=(n-1)(n-2)m^2$ for every $a$. This is immediate from termwise $s_a\le(n-1)(n-2)m^2$. It is unstated, but it is a one-step consequence of what B wrote. Accepted.
- **(U2)** $s_a=(n-1)(n-2)m^2$ forces the row to be an extreme point. B's link 5 invokes only convexity ("the convex functional $s_a$"). A convex functional can attain its maximum at non-extreme points. The constant functional is the standard example. The inference needs the maximum to be attained only at vertices, which requires strict convexity of $x\mapsto\lVert x\rVert^2$ together with $m>0$ (so the vertices are distinct). **No argument for this is on file in Passages B or D. The word "strict" does not occur in either.**
- **(U3)** Every row extreme means each row $a$ has exactly one off-diagonal entry $(n-2)m$ at some $\pi(a)\ne a$, and $-m$ elsewhere. This restates the vertex description of link 4 with $c=m$. Accepted, given U2.
- **(U4)** This "pairs the rows into a fixed-point-free involution." The map $\pi$ is a function with no fixed points. To be an involution it needs $\pi(\pi(a))=a$. That follows from symmetry, since $K_{\pi(a)a}=K_{a\pi(a)}=(n-2)m$, together with $(n-2)m\ne-m$, which needs $m>0$. **Passage B does not mention symmetry anywhere, and no argument for the pairing is on file.** Section 3.5 shows the step is false without symmetry. So the missing argument is load-bearing, and it has to use a hypothesis the proof never cites.

What would have to be proved for C3 to be proved:

- (a) for $m>0$ and $n\ge3$, $\sum_{b\ne a}x_b^2=(n-1)(n-2)m^2$ on the row polytope only at its vertices.
- (b) for symmetric $K$ with every row a vertex at the same $m>0$, the map $a\mapsto\pi(a)$ is an involution.
- (c) the case $m=0$ handled separately: equality there means $t=0$, so $K=0$, which is $M(\sigma,0)$ at even $n$ and has no matching at odd $n$.

**Verdict C3: HYPOTHESIS-DEBT on (a), (b) and (c).**

### 3.4 Candidate: $K=0$ against "pairs the rows into a fixed-point-free involution, existing exactly for even $n$"

1. **Location.** Passage B: "equality forces every row extreme, one entry $(n-2)c$, the rest $-c$, which pairs the rows into a fixed-point-free involution, existing exactly for even $n$."
2. **Closed-form failure.** At $n=5$, $K=0$ is hollow, symmetric, with zero row sums. It has $t=0$ and $\mu=0$, and the display $0\ge\sqrt{0/60}=0$ holds with equality. Every row is the polytope's only point ($m=0$), but no fixed-point-free involution of five points exists. So "equality ... pairs the rows into a fixed-point-free involution" fails, and so does the implied conclusion that equality cases exist only for even $n$.
3. **Charitable reading.** B means $t>0$, where $m>0$ makes the vertex entries $(n-2)m$ and $-m$ distinct and the pairing meaningful. The reading is natural. The sentence still claims more than its $m>0$ case, and Passage A's "extremizers being exactly the perfect matchings" is silent at odd $n$, so Passage A is untouched. The candidate lands on Passage B's wording and on Passage D (Section 4). It is recorded as part (c) of the C3 debt and as the C4 refutation, and not as a separate claim.

### 3.5 Candidate: symmetry is load-bearing for uniqueness

1. **Location.** Passage B's chain for the equality case (Section 3.3, U4) never invokes symmetry. Passage E (file lines 16-19) records that symmetry is unused, a statement about the inequality alone.
2. **Closed-form object.** At $n=3$, with $m>0$, let
$$K=\begin{pmatrix}0&m&-m\\-m&0&m\\m&-m&0\end{pmatrix}.$$
It is hollow with zero row sums. Its off-diagonal minimum is $-m$ and $t=6m^2=D_3m^2$, so $\sqrt{t/D_3}=m=\lvert\mu\rvert$: equality at odd $n$ with $K\ne0$. Every row is a vertex with $\pi$ the 3-cycle $1\to2\to3\to1$, which is not an involution. $K$ is antisymmetric, so it is outside the lemma's class.
3. **Charitable reading.** The lemma assumes symmetry, so this object refutes nothing in Passages A to D. What it shows is that U4 must use symmetry, and B's chain does not name it. This supports the debt (b) in Section 3.3. It is not a refutation.

The candidate is withdrawn as a defect of the statement (the lemma assumes symmetry) and kept as evidence for the C3 debt.

## 4. Claim C4, "at odd $n$ the bound is strict"

1. **Location.** Passage D: "so for even $n$ the extremizers are exactly the perfect matchings, ... and at odd $n$ the bound is strict."
2. **Closed-form failure.** At every odd $n\ge3$, $K=0$ is in the class and attains equality (Section 3.4). At $n=3$ the failure covers the whole class. The symmetric hollow zero-row-sum conditions give $K_{12}+K_{13}=0$, $K_{12}+K_{23}=0$ and $K_{13}+K_{23}=0$. The first two give $K_{13}=K_{23}$, and the third gives $2K_{13}=0$. So $K=0$ is the only member, and at $n=3$ the bound holds with equality for every admissible $K$ and is strict for none.
3. **Charitable reading.** "Strict" means strict for $K\ne0$. Under that reading the claim is (a) plus (b) of Section 3.3 applied at odd $n$: an equality case with $m>0$ would carry a fixed-point-free involution, and none exists. The corrected claim therefore inherits the C3 debt, and the $K\ne0$ restriction has to be written.

**Verdict C4: REFUTED AS STATED.** The corrected claim, strict at odd $n$ for $t>0$, is HYPOTHESIS-DEBT on Section 3.3 (a) and (b).

## 5. Claim C5, Passage D's closing sentence

"The lemma is about hollow zero-row-sum matrices and holds on and off the diagonal locus alike; what it bounds is the smallest sectional curvature, and it carries no information about $\theta$ on its own."

- **C5a, "holds on and off the diagonal locus alike."** The statement's hypotheses are hollowness, symmetry, zero row sums and the value of $t$. None refers to a diagonal locus, so the conclusion holds wherever those hypotheses hold. **CONFIRMED.**
- **"about hollow zero-row-sum matrices."** Candidate: the phrase drops symmetry, and Section 3.5 shows symmetry is needed for the equality clauses.
  1. Location: the quoted phrase.
  2. Failure: the 3-cycle matrix of Section 3.5 is hollow with zero row sums and violates the odd-$n$ strictness of the preceding sentence.
  3. Charitable reading: the same paragraph opens with "a hollow symmetric $n\times n$ matrix with zero row sums", and the closing phrase is a descriptive shorthand that contrasts matrices with the diagonal locus. It adds no new hypothesis set.
  **Withdrawn** on the charitable reading. The phrase is accurate for the inequality, and the paragraph's own first sentence fixes the class.
- **C5b, "what it bounds is the smallest sectional curvature ... no information about $\theta$ on its own."** The brief defines no sectional curvature, no identification of $K_{ab}$ with one, and no $\theta$. Nothing on file in the brief argues either clause. Two things would have to be proved: the identification of $\min_{a\ne b}K_{ab}$ with the smallest sectional curvature of the programme's object, and the statement that the lemma's hypotheses and conclusion are invariant under every change of $\theta$ that keeps them. **HYPOTHESIS-DEBT.** It is a gloss rather than content of the lemma, and it cannot affect C1 to C4.

## 6. Claim C6, Passage E against Passages A and D

| Lean item (file lines) | What it states | Against the record |
|---|---|---|
| IsHollowZeroRow (42-44) | $\forall a,\ K_{aa}=0$ and $\forall a,\ \sum_bK_{ab}=0$ | Hollow and zero row sums, matching the Definitions |
| frobenius_le (112-114) | For any $m\ge0$ with $\forall a\,b,\ -m\le K_{ab}$: $\sum_{a,b}K_{ab}^2\le D_nm^2$ | The cleared display, ordered-pair $t$. At $a=b$ the hypothesis reads $-m\le0$, which is the same as $m\ge0$ |
| min_entry_bound (131-133) | $3\le n$, and the same $m$ hypotheses: $\sqrt{t/D_n}\le m$ | The record's display for every lower bound $m$. The instance $m=-\mu$ gives Passage A. That instance, i.e. $-\mu\ge0$ and $-\mu$ bounding every entry including the diagonal, is argued in the docstring (file lines 128-130) and is not typed. It is Section 0's one-line fact |
| min_entry_bound_symm (147-151) | The same, with an added symmetry hypothesis | Passage A's hypothesis set, symmetry unused |
| matching (157-158) | $M(\sigma,c)$ for an arbitrary function $\sigma$ | Matches the Definitions once hinv and hfix are imposed |
| matching_hollowZeroRow (164-165) | $3\le n$, $\sigma^2=\mathrm{id}$, $\sigma(a)\ne a$: $M$ is hollow with zero row sums | **Symmetry of $M$ is not typed.** Passage A's class is symmetric, so attainment inside Passage A's class needs it. It is true (Section 3.1) and not stated |
| matching_frobenius (193-195) | $t(M)=D_nc^2$ | Matches Section 3.1 |
| matching_min (229) | $3\le n$, $0<c$: every entry of $M$ is $\ge-c$ | With min_entry_bound and matching_equality this gives $\lvert\mu\rvert=c$: $-\mu\le c$ from here, and $-\mu\ge\sqrt{t/D_n}=c$ from the bound |
| matching_equality (235-238) | $3\le n$, hinv, hfix, $0<c$: $\sqrt{t(M)/D_n}=c$ | Attainment for $c>0$ |
| example (253-254) | A fixed-point-free involution of Fin 4 exists | Non-vacuity at $n=4$. Evenness itself is not typed |

Binders and exclusions:

- $3\le n$ excludes $n=1,2$, exactly where Passage A's display is undefined (Section 2.2). The exclusion is correct.
- $0<c$ excludes $c<0$, which Section 3.2 shows is necessary, and excludes $c=0$, which is harmless for attainment.
- The hypothesis $0\le m$ in frobenius_le and min_entry_bound is derivable from hm and hollowness. It is redundant and excludes nothing.
- hinv is carried by matching_hollowZeroRow and matching_frobenius, and their conclusions hold without it. It excludes nothing that Passage A needs.

Candidate: the Lean header misdescribes the record's proof.

1. **Location.** File lines 28-31: "What is not stated here is the *uniqueness* half of the word "exactly": that every equality case is a perfect matching. The record proves it from strict convexity plus the symmetry step forcing $\sigma^2=\mathrm{id}$, and this file supplies attainment and the inequality only."
2. **Failure.** Passage B, the record's proof, contains neither strict convexity (it says "the convex functional $s_a$") nor any use of symmetry (Section 3.3, U2 and U4). The header attributes to the record an argument that the record does not contain.
3. **Charitable reading.** The header may describe the argument the record intends. It reports that argument as something the record "proves", though, and a reader of the Lean file would take the uniqueness half as discharged on file. The candidate stands.

The Lean file also discloses its scope correctly: uniqueness is untyped, and the file says so.

**Verdict C6: GAP.** Passage E types the inequality (for every lower bound $m$, $n\ge3$) and attainment for $c>0$. It does not type symmetry of the extremiser, the instance $m=\lvert\mu\rvert$, or the uniqueness half. Its header states that the record proves uniqueness from strict convexity and symmetry, which Passage B does not do.

## 7. The standing list, answered

1. **Hypothesis inventory.** Section 1. Stated and used by the inequality: hollowness and zero row sums. Stated and unused by the inequality, needed by uniqueness: symmetry. Used and unstated: $n\ge3$, $c\ge0$, and $t>0$ for the pairing and strictness clauses.
2. **Quantifier order and scope.** Passage A: for all $n\ge3$ and all admissible $K$, the display holds. For each even $n$ and each $t\ge0$, some $K$ attains it ($M(\sigma,\sqrt{t/D_n})$), and the equality set equals $\{M(\sigma,c):\sigma$ a fixed-point-free involution, $c\ge0\}$. In Passage B, $m$ is global and the fixed row is incidental (Section 2.1, link 6). The letter $c$ in "one entry $(n-2)c$" is B's $m$, one value for all rows, which is the reading U3 needs. No finding beyond the unsigned $c$ of Section 3.2.
3. **Edges.**
   - $n=2$: display undefined, the class is $\{0\}$.
   - $n=3$: the class is $\{0\}$, and D's strictness fails for all of it.
   - Odd $n$: $K=0$ is an equality case.
   - $K=0$: equality at every $n\ge3$. At even $n$ it is $M(\sigma,0)$. At odd $n$ it is not a matching.
   - $c<0$: the matching matrix misses the bound by the factor $n-2$.
4. **Proven versus stated or used.** Proven: the inequality for $n\ge3$ and attainment for $c\ge0$. Stated and not argued: the uniqueness half (Section 3.3 (a), (b), (c)) and odd-$n$ strictness. Stated and false as written: the unsigned extremiser family and strictness at $K=0$.
5. **The Lean statements.** Section 6.
6. **The brief's "What to attack" items.**
   1. Inequality: Section 2. Each step checked. The polytope is a simplex with the stated vertices. The convex maximum sits at a vertex by Jensen over the vertex decomposition. The hypotheses used are hollowness, zero row sums and $n\ge3$, and symmetry is unused.
   2. Attainment and uniqueness: Sections 3.1-3.5. Attainment holds for $c\ge0$ only. The uniqueness steps U2 (strictness) and U4 (the pairing, via symmetry) are not argued.
   3. The zero matrix: Sections 3.4 and 4. Passages A and C are true at $K=0$, and at even $n$ it is $M(\sigma,0)$. Passage B's "pairs the rows into a fixed-point-free involution, existing exactly for even $n$" and Passage D's odd-$n$ strictness fail at odd $n$.
   4. Odd-$n$ strictness: Section 4. It is refuted as stated. The strict statement needs $t>0$ plus debts (a) and (b).
   5. Closing sentence: Section 5. The diagonal-locus clause is confirmed. The shorthand candidate is withdrawn. The curvature and $\theta$ clauses are HYPOTHESIS-DEBT.
   6. Ordered pairs: **No finding.** $\lVert K\rVert_F^2$ is the ordered sum by definition, and Passage E fixes it (file lines 25-26). Under the unordered reading $t'=\sum_{a<b}K_{ab}^2=t/2$ (by symmetry and hollowness), the sharp statement becomes $\lvert\mu\rvert\ge\sqrt{2t'/D_n}$, i.e. the constant $D_n/2$. With the printed constant and $t'$ in place of $t$, the display is still true but never attained for $t'>0$, which would contradict the attainment clause. The record's constant fits the ordered reading.
   7. Passage E against A and D: Section 6.
   8. Boundary: item 3 above.
7. **Falsifiers named, and the search.**
   - C1: an admissible $K$, $n\ge3$, with $t>D_nm^2$. Looked for through each link of the chain (Section 2.1) and through the removal of each hypothesis (Section 1). None exists in the class. The non-hollow $I-J/n$ and the non-zero-row-sum $n=3$ matrix show that both hypotheses are needed.
   - C2: a perfect-matching matrix that is not an extremiser. Found: $M((1\,2)(3\,4),-1)$ at $n=4$.
   - C3: an admissible equality case that is not a perfect-matching matrix. Found at odd $n$: $K=0$. Without symmetry, found at $K\ne0$: the $n=3$ 3-cycle matrix. For symmetric $K$ with $m>0$ at even $n$, none was found, and ruling it out is exactly debts (a) and (b), which are not on file.
   - C4: an admissible equality case at odd $n$. Found: $K=0$, the whole class at $n=3$.
   - C5b: an identification of $\mu$ with a curvature under which the gloss fails. It is not constructible from the brief's definitions.
   - C6: a Lean hypothesis that excludes a case the record claims, or a claim the header misattributes. Checked each binder (Section 6). The exclusions $n\ge3$ and $c>0$ are justified. Found: the header's attribution of strict convexity and symmetry to the record's proof.

## 8. Overall verdict

**HYPOTHESIS-DEBT.**

- The inequality is proven for $n\ge3$, and attainment is proven for $c\ge0$. Both need hypothesis corrections: $n\ge3$ in Passages A, C and D, and $c\ge0$ on the extremiser family.
- The uniqueness half of "exactly the perfect matchings", and with it Passage D's odd-$n$ strictness, rests on two inferences Passage B asserts without argument:
  - the maximum of $\lVert x\rVert^2$ on the row simplex is attained only at vertices when $m>0$.
  - symmetry forces the one-large-entry map to be an involution.
- The case $m=0$ needs separate treatment, since $K=0$ is an equality case at odd $n$.
- Passage D's "at odd $n$ the bound is strict" is false as stated at $K=0$, and at $n=3$ it fails for the whole class.
- The Lean header credits the record with a strict-convexity-and-symmetry proof that Passage B does not contain.
