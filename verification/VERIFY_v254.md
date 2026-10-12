# Verifier v254, L55: the min-entry bound, its attainment and uniqueness by the perfect matchings, the odd-n strictness and closing gloss of the detail form, and the Lean statement

The brief ([BRIEF_L55.md](BRIEF_L55.md)) was read cold. No numerical work was done: every value below is exact, every counterexample is in closed form, and no script was written or run. Lean was not run. Log: [agent_logs/verify-L55-v254.log](../agent_logs/verify-L55-v254.log).

| # | Claim | Verdict |
|---|---|---|
| C1 | The inequality $\lvert\min_{a\ne b}K_{ab}\rvert\ge\sqrt{t/(n(n-1)(n-2))}$ (Passages A, B, C, D) | CONFIRMED (for $n\ge3$, which the display's denominator requires and no passage states) |
| C2 | Attainment: the matching matrix with $(n-2)c$ on $\sigma$ and $-c$ elsewhere is an extremizer | REFUTED AS STATED (no sign on $c$. At $c<0$, even $n\ge4$, the matching misses the bound by the factor $n-2$). CONFIRMED at $c\ge0$ |
| C3 | Uniqueness: "the extremizers being exactly the perfect matchings", Passage B's "equality forces every row extreme ... which pairs the rows into a fixed-point-free involution" | HYPOTHESIS-DEBT |
| C4 | Passage D: "at odd $n$ the bound is strict" (and Passage B's "existing exactly for even $n$") | REFUTED AS STATED ($K=0$ attains equality at every odd $n\ge3$, and at $n=3$ it is the only member of the class) |
| C5a | Passage D: the lemma "holds on and off the diagonal locus alike" | CONFIRMED |
| C5b | Passage D: "what it bounds is the smallest sectional curvature, and it carries no information about $\theta$ on its own" | HYPOTHESIS-DEBT |
| C6 | Passage E, the Lean statements against Passages A and D | CONFIRMED AS ALGEBRA (inequality and attainment at $c>0$ in the hollow zero-row class. Symmetry of the extremiser and the whole uniqueness half are untyped, and the file's docstring misdescribes the record's proof) |

**Summary.** The inequality is correct and correctly proved for $n\ge3$, and attainment holds at $c\ge0$, but the uniqueness half is asserted without an argument (it needs strict convexity and symmetry, neither named), the extremizer family carries no sign on $c$, and the odd-$n$ strictness claim is false at $K=0$.

## 0. Conventions, fixed once

- $K$ is a real $n\times n$ matrix, hollow ($K_{aa}=0$), with zero row sums ($\sum_bK_{ab}=0$), and in Passages A, C, D symmetric. $t=\sum_{a,b}K_{ab}^2$ over ordered pairs.
- $\mu:=\min_{a\ne b}K_{ab}$ and $m:=\lvert\mu\rvert$. For $n\ge2$ each row has $n-1\ge1$ off-diagonal entries summing to $0$, so $\mu\le0$ and $m=-\mu$. Then $-m\le K_{ab}$ for every ordered pair, the diagonal included.
- $D_n:=n(n-1)(n-2)$.
- $M(\sigma,c)$ is the matching matrix: $M_{a\sigma(a)}=(n-2)c$, $M_{aa}=0$, $M_{ab}=-c$ for $b\notin\{a,\sigma(a)\}$, with $\sigma$ a fixed-point-free involution.
- The quotations were checked against their sources by displaying only the cited lines: [findings/diagonal-half.md](../findings/diagonal-half.md) lines 436, 452-456 and 458, [results.md](../results.md) lines 206 and 707-709. All match verbatim. Passage E matches [L55Statement.lean](../lean/HamiltonsCubic/Results/L55Statement.lean) exactly, the brief carrying one extra trailing blank line. The file contains no `sorry`. A build artefact for it exists with a modification time later than the source file's. I did not run Lean, so every verdict below rests on reading the chain by hand.

## Hypothesis inventory

| Hypothesis | Stated in | Used by the inequality (C1) | Used by uniqueness (C3) | Load-bearing? Closed-form witness |
|---|---|---|---|---|
| Hollow | A, C, D | Yes: the off-diagonal row sum is $-K_{aa}=0$, and $s_a$ carries no diagonal term | Yes | Yes. $n=3$, $K_{aa}=2$, $K_{ab}=-1$ ($a\ne b$): symmetric, zero row sums, $\mu=-1$, $t=3(4+1+1)=18$, $\sqrt{18/6}=\sqrt3>1$ |
| Zero row sums | A, C, D | Yes: the polytope constraint $\sum x_b=0$ | Yes | Yes. $n=3$, $K_{12}=K_{21}=1$, other entries $0$: hollow, symmetric, $\mu=0$, $t=2$, $\sqrt{2/6}>0$ |
| Symmetric | A, C, D | No (Lean's `min_entry_bound` omits it) | Yes, for the involution step, never invoked in B | Yes for C3. $n=3$, $K_{a,a+1}=m$, $K_{a,a+2}=-m$ (indices mod 3), $m>0$: hollow, zero row sums, $\mu=-m$, $t=6m^2=D_3m^2$, equality at odd $n$ with no involution |
| $n\ge3$ | Unstated | Yes: division by $D_n$ | Yes | At $n=2$ the class is $\{0\}$ and the display reads $0\ge\sqrt{0/0}$, undefined |
| $c\ge0$ in $M(\sigma,c)$ | Unstated in A, C, D (B's $c$ is the $m\ge0$ of the proof) | n/a | Yes | See C2: $n=4$, $c=-1$ |
| $K\ne0$ (equivalently $t>0$) | Unstated | No | Yes, for the pairing step and for odd-$n$ strictness | See C4: $K=0$ |

Used but unstated: $n\ge3$, $c\ge0$, $t>0$ for strictness. Stated but unused by the inequality: symmetry.

## 1. C1, the inequality

**The chain of Passage B, link by link.**

1. "Fix the row $a$ achieving the minimal entry and let $m=\lvert\min_bK_{ab}\rvert$." If $\min_b$ includes $b=a$, it is $\min(0,\mu)=\mu$ since $\mu\le0$. So $m$ is the global $\lvert\mu\rvert$ and $-m$ bounds every entry of every row. Holds.
2. "$n-1$ entries summing to $-K_{aa}=0$, each $\ge-m$, so each entry is also $\le(n-2)m$." For $b\ne a$, $x_b=-\sum_{c\ne a,b}x_c\le(n-2)m$. Holds (hollowness and row sums used).
3. The row polytope $P_m=\{x\in\mathbb R^{n-1}:\sum x_b=0,\ x_b\ge-m\}$ has extreme points with one coordinate $(n-2)m$ and the rest $-m$. With $y=x+m\mathbf 1$, $P_m$ is $\{y\ge0,\ \sum y_b=(n-1)m\}$, the simplex scaled by $(n-1)m$, whose vertices are $(n-1)m\,e_b$, that is $x=(n-2)m$ at $b$ and $-m$ elsewhere. At $m=0$, $P_0=\{0\}$, consistent with the formula. Holds.
4. "$s_a\le(n-2)^2m^2+(n-2)m^2=(n-1)(n-2)m^2$, the extreme point maximising the convex functional $s_a$." $P_m$ is compact (step 2 bounds it) and is the convex hull of its vertices. For $x=\sum\lambda_iv_i$, convexity gives $s(x)\le\sum\lambda_is(v_i)=\max_is(v_i)$, and every vertex has the same value $(n-2)^2m^2+(n-2)m^2=(n-2)m^2\big((n-2)+1\big)=(n-1)(n-2)m^2$. Holds.
5. The row bound applies to every row $a'$, since only $x_b\ge-m$ and $\sum x_b=0$ were used, and both hold in every row. "Summing over rows, $t\le D_nm^2$." Holds.
6. "which is the display": for $n\ge3$, $D_n>0$, so $m^2\ge t/D_n$ and $m\ge0$ gives $m\ge\sqrt{t/D_n}$. Holds for $n\ge3$.

**Verdict.** CONFIRMED for $n\ge3$. Passage D's shorter version (row norm convex, maximised at the extreme point, summed) is the same chain and is confirmed on the same terms. Symmetry is never used.

**Falsifier sought.** A hollow zero-row-sum $K$ with $t>D_nm^2$. Each of steps 1-6 was checked for a failing case at $n=3$, $n$ odd, $m=0$. Steps 3 and 4 were checked separately at $n=3$, where $P_m$ is the segment from $(m,-m)$ to $(-m,m)$ with $s=2m^2=(n-1)(n-2)m^2$ at both ends. None found.

### 1.1 Withdrawn candidates

- **Row-local $m$.** (1) Located at "Fix the row $a$ achieving the minimal entry and let $m=\lvert\min_bK_{ab}\rvert$", after which the row bound is summed over all rows. (2) Were $m$ the minimum of row $a$ only, another row could have an entry below $-m$ and its $s_{a'}$ could exceed $(n-1)(n-2)m^2$. (3) Charitable reading: row $a$ is the row *achieving the global minimal entry*, so its minimum is the global one and $-m$ bounds every row. Withdrawn: the text says exactly this.
- **Diagonal inside $\min_b$ and $s_a$.** (1) "$\min_bK_{ab}$" and "$s_a:=\sum_bK_{ab}^2$" range over all $b$. (2) A diagonal term could shift the minimum or the sum. (3) $K_{aa}=0$ contributes nothing to $s_a$, and $\min(0,\mu)=\mu$ because $\mu\le0$. Withdrawn.
- **Maximum at an extreme point needs compactness.** (1) "the extreme point maximising the convex functional". (2) A convex function on an unbounded polyhedron has no maximum. (3) Step 2 bounds every coordinate in $[-m,(n-2)m]$, so $P_m$ is a polytope. Withdrawn.

## 2. C2, attainment

**Derivation, by direct evaluation of the candidate.** Let $\sigma$ be a fixed-point-free involution and $n\ge3$.

- Hollow: $M_{aa}=0$ by definition.
- Row sums: $(n-2)c+(n-2)(-c)=0$.
- Symmetric: $M_{\sigma(a)a}=M_{\sigma(a)\sigma(\sigma(a))}=(n-2)c=M_{a\sigma(a)}$ because $\sigma^2=\mathrm{id}$. For $b\notin\{a,\sigma(a)\}$, $a\notin\{b,\sigma(b)\}$ (since $\sigma(b)=a$ iff $b=\sigma(a)$), so $M_{ba}=-c=M_{ab}$.
- $t=n\big((n-2)^2c^2+(n-2)c^2\big)=D_nc^2$, so $\sqrt{t/D_n}=\lvert c\rvert$.
- $c>0$: $(n-2)c\ge c>-c$, so $\mu=-c$ (an entry $-c$ exists since $n\ge3$), $m=c=\sqrt{t/D_n}$. Equality.
- $c=0$: $M=0$, $0\ge0$. Equality.
- $c<0$: $(n-2)c\le-c$ iff $(n-1)c\le0$, true, so $\mu=(n-2)c$ and $m=(n-2)\lvert c\rvert$, against the bound $\lvert c\rvert$. Equality iff $n=3$, where no fixed-point-free involution exists. So at every even $n\ge4$ the matching with $c<0$ is strict.

**Candidate: the extremizer family carries no sign on $c$.**

1. Location. Passage A: "the extremizers being exactly the perfect matchings: $K_{ab}=(n-2)c$ on a fixed-point-free involution and $-c$ elsewhere." Passage C: "exactly by the perfect matchings, $K_{ab}=(n-2)c$ on a fixed-point-free involution and $-c$ elsewhere." Passage D: "$K_{ab}=(n-2)c$ on the matching and $-c$ elsewhere." None restricts $c$.
2. Failure in closed form. $n=4$, $\sigma=(1\,2)(3\,4)$, $c=-1$: $K_{12}=K_{21}=K_{34}=K_{43}=-2$, every other off-diagonal entry $+1$. Row 1 is $(0,-2,1,1)$, sum $0$. $\mu=-2$, $m=2$, $t=4(4+1+1)=24=D_4$, $\sqrt{t/D_4}=1<2$. A member of the stated family that is not an extremizer, so "exactly" fails as a set equality.
3. Charitable reading. In Passage B the equality case is "one entry $(n-2)c$, the rest $-c$" where the row's minimum is $-m$, so $c=m\ge0$ there, and the statement's $c$ is plausibly the same scale. The reading is natural but is written in none of A, C, D, and Passage E's own docstring records that "the record's display omits" it. The candidate survives.

**Verdict.** REFUTED AS STATED. With $c\ge0$ added (the value $c=0$ giving $K=0$), attainment is CONFIRMED by the evaluation above. The attainment direction has no argument in Passage B or D, and Passage E types it at $c>0$ except for symmetry of $M(\sigma,c)$, which is on file nowhere. The evaluation above is the candidate check the rules allow, and it succeeds.

**Falsifier sought.** A matching matrix outside equality: found at $c<0$. At $c\ge0$ the evaluation leaves none.

## 3. C3, uniqueness

Passage B's argument for the uniqueness half is the single clause "equality forces every row extreme, one entry $(n-2)c$, the rest $-c$, which pairs the rows into a fixed-point-free involution, existing exactly for even $n$." Passage D repeats it: "Equality forces every row extreme, which pairs the rows into a fixed-point-free involution."

**Link by link.**

1. Equality $t=D_nm^2$ with $s_{a}\le(n-1)(n-2)m^2$ for every $a$ forces $s_a=(n-1)(n-2)m^2$ in every row. Holds (a sum of non-positive defects that vanishes).
2. "forces every row extreme". The only property of $s_a$ that B names is convexity. A convex function can attain its maximum at non-extreme points (a linear or constant functional does), so convexity as written does not deliver the step. What would have to be proved: the maximisers of $s_a$ on $P_m$ are exactly the vertices, which needs strict convexity of $s_a$ or an equivalent argument. No such argument is on file.
3. "one entry $(n-2)c$, the rest $-c$". This is the vertex description of step 3 of Section 1, so it follows once step 2 is proved, provided $m>0$. At $m=0$ the vertex is $0$ and no entry is distinguished.
4. "which pairs the rows into a fixed-point-free involution". No argument is given, and symmetry, the only hypothesis that could supply it, is never invoked in B or D. What would have to be proved: with $\sigma(a)$ the column of row $a$'s entry $(n-2)m$, (i) $\sigma(a)\ne a$, (ii) $\sigma(\sigma(a))=a$, which needs $K_{\sigma(a)a}=K_{a\sigma(a)}$ and $(n-2)m\ne-m$, that is $m>0$, and (iii) hence $\sigma$ is a permutation. The hypothesis is load-bearing, shown by the closed-form witnesses below.
5. "existing exactly for even $n$". Needs $m>0$, see C4.

**Candidate: the pairing step uses symmetry without saying so, and fails without it.**

1. Location: "which pairs the rows into a fixed-point-free involution" (B), "which pairs the rows into a fixed-point-free involution" (D).
2. Failure without symmetry, closed form. $n=3$, $K_{a,a+1}=m$, $K_{a,a+2}=-m$ (indices mod 3), $m>0$: every row is extreme, $t=6m^2=D_3m^2$, equality, and the distinguished column map is the 3-cycle $a\mapsto a+1$, which is no involution. $n=4$, $\sigma$ the 4-cycle $a\mapsto a+1$ mod 4, $K_{a\sigma(a)}=2m$, other off-diagonal entries $-m$: hollow, row sums $2m-2m=0$, $t=4(4m^2+m^2+m^2)=24m^2=D_4m^2$, equality with $\sigma^2\ne\mathrm{id}$.
3. Charitable reading. Symmetry is a hypothesis of the lemma, so the step is available. It still appears nowhere in the written chain, and step 2 above is written with the wrong strength. The rules forbid supplying either.

**Verdict.** HYPOTHESIS-DEBT. What would have to be proved: (a) that equality in the row bound forces a vertex of $P_m$ (strict convexity or equivalent), (b) that at $m>0$ each vertex has a unique entry $(n-2)m$, (c) that symmetry makes the resulting column map a fixed-point-free involution, and (d) the case $m=0$, where the equality case is $K=0$, the matching with $c=0$. Passage E types none of it and says so.

**Falsifier sought.** A symmetric hollow zero-row-sum $K$ with $t=D_nm^2$ that is not $M(\sigma,c)$ for any $c\ge0$. The nonsymmetric cycle matrices above are equality cases outside the matchings, and each fails symmetry. $K=0$ is an equality case but equals $M(\sigma,0)$ at even $n$. No symmetric falsifier at even $n$ was found, which is consistent with the claim and is no substitute for the missing argument.

## 4. C4, strictness at odd $n$

**Candidate.**

1. Location. Passage D: "and at odd $n$ the bound is strict." Passage B: "a fixed-point-free involution, existing exactly for even $n$", which, as the conclusion of an equality analysis, says equality is impossible at odd $n$.
2. Failure in closed form. $K=0$ is hollow, symmetric, with zero row sums, at every $n$. It gives $t=0$, $m=0$, and the display $0\ge\sqrt{0/D_n}=0$ holds with equality at every odd $n\ge3$. At $n=3$ it is the whole class: a symmetric hollow $3\times3$ matrix has free entries $p=K_{12}$, $q=K_{13}$, $r=K_{23}$, and the row sums give $p+q=0$, $p+r=0$, $q+r=0$, so $-2p=0$ and $p=q=r=0$. At $n=3$ the bound is attained by every member of the class and strict for none.
3. Charitable reading. "Strict" could be meant for $K\ne0$, where Section 3's step 3 has a distinguished entry. That restriction is written in neither passage, and under it the claim inherits the debt of C3 (it is the odd-$n$ half of the same pairing argument).

**Verdict.** REFUTED AS STATED. The strict statement needs $K\ne0$ (equivalently $t>0$), and its proof is items (a)-(c) of C3.

**Falsifier sought and found.** $K=0$ at odd $n$. Also noted: the nonsymmetric 3-cycle matrix of Section 3 attains equality at $n=3$ with $t>0$, so any strict statement needs symmetry as well.

## 5. C5, the closing sentence of Passage D

**C5a, "holds on and off the diagonal locus alike".** The statement of L55 quantifies over the matrix class alone, and the proof of C1 uses only hollowness and row sums. A restriction to or away from any locus leaves the hypotheses and the chain untouched. CONFIRMED.

**C5b, "what it bounds is the smallest sectional curvature, and it carries no information about $\theta$ on its own".**

1. Location: the quoted clause.
2. Failure: none exhibited. The brief defines neither the diagonal locus, nor the map from the geometry to $K$, nor $\theta$, and Passage D gives no argument for either clause.
3. Charitable reading: the entries $K_{ab}$ are presumably sectional curvatures of coordinate planes in the programme's setting, so that $\min_{a\ne b}K_{ab}$ is the smallest one. That identification, its sign and normalisation, and the relation of $\theta$ to $K$ are not on file in the brief.

**Verdict.** HYPOTHESIS-DEBT. What would have to be proved: the identification of $\min_{a\ne b}K_{ab}$ with the smallest sectional curvature (including whether the minimum over coordinate planes is the minimum over all planes), and a precise statement of what "no information about $\theta$" asserts. These clauses are glosses outside the lemma's mathematical content and do not bear on C1-C4.

## 6. C6, Passage E against Passages A and D

| Lean theorem | Binders and hypotheses | What it states | Against the record |
|---|---|---|---|
| `entry_le` | `IsHollowZeroRow K`, `hm : ∀ a b, -m ≤ K a b`, `a ≠ b` | $K_{ab}\le(n-2)m$ | Step 2 of C1. Derives $n\ge2$ from $a\ne b$ |
| `row_bound` | same, any `a` | $\sum_{b\ne a}K_{ab}^2\le(n-1)(n-2)m^2$ | Row bound of C1, proved by the pointwise inequality $x^2\le(n-3)mx+(n-2)m^2$, which is $(x+m)((n-2)m-x)\ge0$ expanded. A different route from B's polytope argument, same conclusion |
| `frobenius_le` | adds `hm0 : 0 ≤ m` | $t\le D_nm^2$ | C1 step 5 |
| `min_entry_bound` | `hn : 3 ≤ n`, hollow zero-row, `hm0`, `hm`, `ht : ∑ a, ∑ b, K a b ^ 2 = t` | $\sqrt{t/D_n}\le m$ for every $m\ge0$ with $-m$ a lower bound | Equivalent to the display for $n\ge3$: the least such $m$ is $\max(0,-\mu)=\lvert\mu\rvert$. The instantiation $m=\lvert\mu\rvert$ is in the docstring, untyped. $t$ is the ordered-pair sum, matching the Definitions |
| `min_entry_bound_symm` | adds `hsymm`, unused | same | The record's hypothesis set, symmetry inert, as C1 found |
| `matching_hollowZeroRow` | `hn`, `hinv`, `hfix` | $M(\sigma,c)$ is hollow with zero row sums | Symmetry of $M(\sigma,c)$ is untyped, so attainment is typed in the hollow zero-row class, which strictly contains the record's symmetric class |
| `matching_frobenius` | same | $t=D_nc^2$ | Matches Section 2 |
| `matching_min` | `hn`, `hc : 0 < c` | $-c\le M_{ab}$ | Together with `min_entry_bound` and `matching_equality`, $c$ is the least admissible $m$, so $\lvert\mu\rvert=c$ |
| `matching_equality` | `hn`, `hinv`, `hfix`, `hc` | $\sqrt{t/D_n}=c$ | Attainment at $c>0$ |
| `example` | $n=4$ | a fixed-point-free involution exists | Non-vacuity at $n=4$ only |

**Hypotheses and what they exclude.**

- `hn : 3 ≤ n` excludes $n\le2$, where the record's display is undefined. Excludes nothing the record can mean.
- `hm0 : 0 ≤ m` is implied by `hm` at a diagonal entry when $n\ge1$. Excludes nothing.
- `σ : Fin n → Fin n` is a function, with `hinv` making it a bijection and `hfix` fixed-point free. Matches the Definitions.
- `hc : 0 < c` excludes $c<0$, correctly (Section 2), and also $c=0$, the extremizer $K=0$. Harmless for attainment, but a uniqueness statement built on this parametrisation would have to add $K=0$ back.

**What the file says it does not type, and whether that is accurate.** The docstring says the uniqueness half is untyped. That is accurate. It adds "The record proves it from strict convexity plus the symmetry step forcing $\sigma^2=\mathrm{id}$." Passage B names neither strict convexity nor symmetry (Section 3), so this sentence describes an argument the record does not contain. The docstring's other claims check: symmetry unused for the inequality (C1), $c>0$ needed and "missed by a factor $n-2$" at $c<0$ (Section 2), $t$ the ordered-pair sum.

**Verdict.** CONFIRMED AS ALGEBRA. The typed theorems state the inequality for $n\ge3$ and attainment at $c>0$ in the hollow zero-row class. Untyped: symmetry of the extremiser, the instantiation $m=\lvert\mu\rvert$, the whole uniqueness half, and anything at odd $n$.

## 7. The fixed list

1. **Hypothesis inventory.** See the table above. Symmetry is idle in the inequality and load-bearing, unnamed, in the uniqueness. $n\ge3$, $c\ge0$ and $K\ne0$ are used and unstated.
2. **Quantifier order and scope.** The inequality is $\forall n\ge3\ \forall K$, matched by `min_entry_bound`. Scope of $m$: it is defined in one row and used in all, which is valid because it is the global minimum (withdrawn candidate 1.1). The extremizer claim is, for each even $n\ge4$, $\{K:\text{equality}\}=\{M(\sigma,c)\}$ with $\sigma$ and $c$ existentially bound, and $c$'s range is unstated (C2). No further finding.
3. **Edges.** $n=2$: class $\{0\}$, display $\sqrt{0/0}$ undefined. $n=3$: the symmetric class is $\{0\}$, equality always, odd-$n$ strictness false (C4). Odd $n\ge5$: strictness false at $K=0$, and for $K\ne0$ it rests on C3's debt. $K=0$: equality at every $n\ge3$, the matching with $c=0$ at even $n$. $c<0$: not an extremizer at even $n\ge4$ (C2).
4. **Proven against stated.** Proven: the inequality for $n\ge3$ and attainment at $c\ge0$. Stated beyond that: the extremizer set "exactly", with no argument on file (C3), no sign on $c$ (C2), odd-$n$ strictness including $K=0$ (C4), and the curvature and $\theta$ glosses (C5b). Downstream uses are outside the brief and were not examined.
5. **Lean statements.** Section 6. They are the inequality and attainment, with binders matching the record and no hypothesis excluding a case the record covers, except `hc` excluding $c=0$ from the attainment theorem. The uniqueness half and the symmetry of the extremiser are untyped.
6. **What to attack.**
   1. The inequality: Section 1. Every step holds for $n\ge3$. The polytope is a scaled simplex with the stated vertices, and the maximum of a convex function on it sits at a vertex by the convex-combination bound. Hollowness and row sums are used, symmetry is idle.
   2. Attainment and uniqueness: Section 2, attainment exactly at $c\ge0$. Section 3, uniqueness asserted, with strictness away from the vertices unargued ("convex" is written), one distinguished entry needing $m>0$, and the involution needing symmetry, never invoked.
   3. The zero matrix: at $K=0$, $t=0$, every form of the display reads $0\ge0$ with equality at every $n\ge3$. At even $n$ it is $M(\sigma,0)$, admitted by A, C, D (no sign on $c$) and excluded from Passage E's attainment by `hc`. At odd $n$ it refutes D's strictness and B's "existing exactly for even $n$".
   4. "At odd $n$ the bound is strict": REFUTED AS STATED (Section 4). The strict form needs $K\ne0$ and symmetry, and its proof is C3's debt.
   5. The closing sentence: Section 5, clause 1 CONFIRMED, clauses 2 and 3 HYPOTHESIS-DEBT for want of definitions and argument.
   6. The ordered-pair reading: for symmetric hollow $K$, the unordered sum is $t'=\sum_{a<b}K_{ab}^2=t/2$, so the bound in $t'$ reads $m\ge\sqrt{2t'/D_n}$, the constant becoming $D_n/2$. With $t'$ substituted into the unchanged constant, the display $m\ge\sqrt{t'/D_n}=\sqrt{t/(2D_n)}$ still holds but is never attained for $t>0$: at $M(\sigma,c)$, $c>0$, it gives $c/\sqrt2<c$. The Definitions and Passage E both fix the ordered reading, under which the constant $D_n$ is the sharp one. No finding.
   7. Passage E against A and D: Section 6.
   8. The boundary: item 3 above.
7. **Falsifying objects.**
   - C1: a hollow zero-row $K$ with $t>D_nm^2$. Sought by checking each link at $n=3$, odd $n$ and $m=0$. None exists.
   - C2: a matching outside equality. Found: $n=4$, $c=-1$.
   - C3: a symmetric equality case other than $M(\sigma,c)$, $c\ge0$. None found. The nonsymmetric 3- and 4-cycle matrices are equality cases outside the matchings, and they show symmetry is load-bearing.
   - C4: an equality case at odd $n$. Found: $K=0$, the whole symmetric class at $n=3$.
   - C5b: needs definitions not on file.
   - C6: a Lean hypothesis excluding a case the record covers. Found only `hc` excluding $c=0$ from attainment.

## Overall verdict

**HYPOTHESIS-DEBT.** The inequality is PROVEN for $n\ge3$ and attainment holds at $c\ge0$. The uniqueness half ("exactly the perfect matchings") has no argument on file: it needs the row maximisers to be vertices (strict convexity, where B writes "convex") and symmetry to make the column map an involution, and neither is named. The statements need three hypothesis corrections: $n\ge3$, $c\ge0$ in the extremizer family, and $K\ne0$ for Passage D's odd-$n$ strictness, which is false as written at $K=0$.
