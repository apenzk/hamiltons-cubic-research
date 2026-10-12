# Verifier v303, Lemma L89: surjectivity of the multiplication map, exactness of invariants, the display rank(A)=14 with nullity 51, the "no sample points" and heading claims, results.md's additions, and the Lean files

The brief ([BRIEF_L89.md](BRIEF_L89.md)) was read cold. No numerical work was done, every value below is exact, and no script was written or run. The Lean files were read and were not compiled. Log: [agent_logs/verify-L89-v303.log](../agent_logs/verify-L89-v303.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | $\mu$ is surjective and $O(5)$-equivariant | GAP (true, and elementary, but asserted without argument in Passage A. The Lean witness offered as "the whole of the surjectivity argument" gives no degree-$(3,3)$ split) |
| 2 | Exactness of invariants carries $\mu$ onto $(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}$ | CONFIRMED (classical import, unfiled. Its hypotheses hold) |
| 3 | The display $\mathrm{rank}(A)=\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$ exactly, nullity $65-14=51$ | REFUTED AS STATED for the sampled $A$. CONFIRMED AS ALGEBRA for $\mu\vert_{\mathrm{inv}}$, conditional on $14$ and $65$ |
| 4 | "No sample points are needed for it ... both are now theorems" | REFUTED AS STATED |
| 5 | Heading: "a theorem on the full space, and an open question on the restricted one" | GAP |
| 6a | results.md: "the rank and nullity follow without a measurement" | REFUTED AS STATED |
| 6b | results.md: "the map's domain is not one the certificate route ranges over, and that route consumes $13$ rather than $14$" | HYPOTHESIS-DEBT |
| 7 | The Lean files state or prove L89 | REFUTED AS STATED (neither file states the lemma. [InvariantsExact.lean](../lean/HamiltonsCubic/Results/InvariantsExact.lean) proves the conditional exactness step correctly) |
| 8 | Scope: rank $14$ and nullity $51$ as values | HYPOTHESIS-DEBT |

**Summary.** What is proven is $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=\dim(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}$ with nullity $\dim\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)^{O(5)}$ minus that rank. The values $14$ and $51$ rest on a script output and on L83's Observation, so the lemma as stated is HYPOTHESIS-DEBT.

## 0. Conventions, fixed once

- $\mathcal W=\mathcal W_5$, the algebraic Weyl tensors on $\mathbb R^5$, a finite-dimensional real orthogonal $O(5)$-module. Field $\mathbb R$ throughout.
- $\mu:\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W^*)\to\mathrm{Sym}^6\mathcal W^*$, $p\cdot q\mapsto pq$.
- $D=\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W^*)^{O(5)}$ and $T=(\mathrm{Sym}^6\mathcal W^*)^{O(5)}$. $\mu\vert_{\mathrm{inv}}:D\to T$ is the restriction.
- $d_T=\dim T$ (claimed $14$, line 56) and $d_D=\dim D$ (claimed $65$, line 110).
- $A$ is the "sampled coefficient matrix" of Passage A's third paragraph. For a finite sample $S\subset\mathcal W$, $A=\mathrm{ev}_S\circ\mu\vert_{\mathrm{inv}}$, where $\mathrm{ev}_S:T\to\mathbb R^S$ evaluates a sextic at the points of $S$. This is the reading the record itself fixes ("whose rank is $\le14$ with equality only when the sample points are unisolvent").
- Quotation check: [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 56, 110, 124 and 142-150, and [results.md](../results.md) lines 294 and 976, were displayed alone and match the brief verbatim.

## Hypothesis inventory

| Hypothesis | Where stated | Used by | Standing |
|---|---|---|---|
| H1. $\mu$ surjective | Passage A line 144, asserted | exactness step | true, argument absent (Section 1) |
| H2. $\mu$ is $O(5)$-equivariant | Passage A line 144, asserted | $\mu(D)\subseteq T$ and exactness | true, argument absent but immediate from $g\cdot(pq)=(g\cdot p)(g\cdot q)$ |
| H3. Invariants are exact for $O(5)$ over $\mathbb R$ | Passage A line 144, "reductive, characteristic zero" | $\mu(D)=T$ | classical, unfiled (Section 2) |
| H4. $d_T=14$ | line 56: "the output of run_n5_constraint_count.py, and no argument on file derives it" | the value of the rank | script output, HYPOTHESIS-DEBT |
| H5. $d_D=65$ | line 110: Schur on L83's multiplicities, "inherit L83's standing as an Observation" | the value of the nullity | Observation, HYPOTHESIS-DEBT |
| H6. $\mathcal W\cong\mathcal W^*$ as $O(5)$-modules | **unstated** | the display writes $\mathrm{Sym}^6\mathcal W_5$ where $\mu$ lands in $\mathrm{Sym}^6\mathcal W_5^*$ | true: the $O(5)$-invariant inner product restricted from 4-tensors gives the isomorphism |
| H7. Rank-nullity on finite-dimensional spaces | unstated | nullity $=d_D-\mathrm{rank}$ | standard |
| H8. Unisolvence of the sample for $T$ | stated as **absent** (line 150) | would be needed for the display about $A$ | not supplied |
| H9. "rank $14$ implies consistency" (reviewer 200) | line 148, cited | "both are now theorems" | not quoted, "consistency" undefined in the brief, unfiled |

Imported result H3, its hypotheses against the object: a compact group acting continuously and linearly on a finite-dimensional real space (the Reynolds operator), or a linearly reductive algebraic group acting rationally in characteristic zero. $O(5)$ is compact, the actions on $\mathrm{Sym}^k\mathcal W^*$ are polynomial in $g$, and the spaces are finite-dimensional. All hold.

Quantifier order and scope (standing item 2):

- **Map.** The lemma heading (line 124) and both results.md lines name $\mu\vert_{\mathrm{inv}}$, the abstract map. The display (line 146) names $A$, which line 150 identifies as sampled. Two different objects carry the same claim (Section 3).
- **Group.** $O(5)$. In odd dimension $O(5)=SO(5)\times\{\pm I\}$, and $-I$ acts on a 4-tensor by $(-1)^4=1$, so $-I$ acts trivially on $\mathcal W$ and on every $\mathrm{Sym}^k\mathcal W^*$. The $O(5)$- and $SO(5)$-invariants coincide, so the $O(5)$ against $SO(5)$ edge moves no dimension.
- **Field.** $\mathbb R$. Passage B's real-type argument is the correct one for real Schur. Lean works over $\mathbb R$ with no group.

## 1. Surjectivity and equivariance of $\mu$ (attack item 1)

**Derivation on file.** Passage A line 144 states "which is surjective and $O(5)$-equivariant" and gives no argument. results.md line 976 calls it "elementary, neither imported nor measured". [L89.lean](../lean/HamiltonsCubic/Results/L89.lean) lines 47-51 offer `split_exists` as "the whole of the surjectivity argument".

**The statement is true.** Degree-6 monomials span $\mathrm{Sym}^6\mathcal W^*$. Each one factors as a product of two cubic monomials. Equivariance holds because $g$ acts on polynomials by algebra automorphisms. I record this as a check of truth. The record owes the argument, and this report does not supply it.

**Candidate 1.1: the Lean witness does not give a degree-(3,3) split.**

1. *Locate.* [L89.lean:50](../lean/HamiltonsCubic/Results/L89.lean#L50): `theorem split_exists (e : ℕ) (he : e ≤ 6) : ∃ x y, x + y = e ∧ x ≤ 3 ∧ y ≤ 3`, with docstring "which is the whole of the surjectivity argument".
2. *Exhibit.* Take the monomial $x_1x_2x_3x_4x_5x_6$ in six coordinates of $\mathcal W^*$, exponent vector $a=(1,1,1,1,1,1)$. The witness `min e 3` gives $x_i=1$ at every coordinate, so the first factor has degree $6$ and the second degree $0$. Every per-coordinate conclusion holds, and the output is no factorisation into two cubics. The theorem constrains each coordinate separately, so it cannot assert $\sum_i x_i=3$. What would have to be proved is the existence of $b\le a$ componentwise with $\lvert b\rvert=3$.
3. *Charitable reading.* The lemma may be intended as the local fact behind a greedy choice. Even so, the degree constraint is the substance of surjectivity, and the file states it nowhere. The docstring's "whole of the argument" is not what the theorem proves.

Candidate survives. Verdict **GAP**: the statement is true, Passage A carries no argument, and the Lean witness misses the one constraint that matters. Severity is low, and truth is unaffected.

## 2. Exactness carries the surjection to invariants (attack item 2)

**Derivation on file.** Line 144: "$O(5)$ is reductive and the characteristic is zero, so taking invariants is an **exact** functor, and an exact functor carries a surjection to a surjection."

**Link by link.**

- By H2, $\mu(D)\subseteq T$, so $\mu\vert_{\mathrm{inv}}:D\to T$ is defined.
- The sequence $0\to\ker\mu\to\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W^*)\to\mathrm{Sym}^6\mathcal W^*\to0$ is exact by H1 and consists of $O(5)$-modules by H2.
- By H3, applying $(-)^{O(5)}$ gives an exact $0\to(\ker\mu)^{O(5)}\to D\to T\to0$. So $\mu\vert_{\mathrm{inv}}$ is onto $T$, and $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=d_T$.
- The step is valid. The minimal justification is the one [InvariantsExact.lean](../lean/HamiltonsCubic/Results/InvariantsExact.lean) isolates: an idempotent projection $\pi_V$ onto the invariants of the source, and a projection $\pi_W$ fixing the invariants of the target, with $\mu\circ\pi_V=\pi_W\circ\mu$. Lift $w\in T$ to $v_0$, then $\pi_V v_0$ is an invariant lift. For compact $O(5)$ the Haar average supplies both projections.
- "Reductive and characteristic zero" is also sufficient. $O(5)$ is disconnected, but in characteristic zero an algebraic group whose identity component is reductive is linearly reductive, and the representations here are rational.

No candidate found. **CONFIRMED**, with H3 reported as a classical theorem that is unfiled. Its hypotheses were checked in the inventory.

## 3. The display (attack item 3, standing item 3)

**Derivation on file.** Line 146: $\mathrm{rank}(A)=\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$ "exactly, with nullity $65-14=51$".

**Which object.** Section 2 gives the rank of $\mu\vert_{\mathrm{inv}}$. The display names $A$, and line 150 says "The theorem is about $\mu$, not about the sampled matrix $A$" and "the pipeline's $A$ is the *sampled* coefficient matrix, whose rank is $\le14$".

**Candidate 3.1: $\mathrm{rank}(A)=14$ does not follow for the sampled $A$.**

1. *Locate.* Line 146, the left-hand side $\mathrm{rank}(A)$, together with "exactly".
2. *Exhibit.* $A=\mathrm{ev}_S\circ\mu\vert_{\mathrm{inv}}$ has $\mathrm{rank}(A)\le\min(d_T,\lvert S\rvert)$. Take $S=\{0\}$, the zero Weyl tensor. Every homogeneous sextic vanishes at $0$, so $A$ is the zero $1\times65$ matrix and $\mathrm{rank}(A)=0\ne14$. More generally any $S$ with $\lvert S\rvert\le13$ gives $\mathrm{rank}(A)\le13$. Its nullity is then $65-\mathrm{rank}(A)\ge52$, so "nullity $51$" fails with it. Nothing in the exactness argument refers to $S$, so the inference from exactness to $\mathrm{rank}(A)=14$ is invalid.
3. *Charitable reading.* "$A$" may be a slip for the matrix of $\mu\vert_{\mathrm{inv}}$ in bases of $D$ and $T$. On that reading the display is exactly Section 2's conclusion, and the lemma heading supports it. But the same section fixes $A$ as the sampled matrix two paragraphs later and says the theorem is not about it, so the display as written asserts the claim the record itself withdraws.

Candidate survives. **REFUTED AS STATED** for the sampled $A$.

**The abstract reading.** For $\mu\vert_{\mathrm{inv}}:D\to T$, rank $=d_T$ by Section 2. "Nullity" means $\dim\ker(\mu\vert_{\mathrm{inv}})=\dim(\ker\mu)^{O(5)}=d_D-d_T$ by rank-nullity (H7), so the domain dimension minus the rank is the right quantity. The sources are $14$ from line 56, a script output, and $65$ from line 110, Schur on L83's Observation multiplicities. The edge $d_D\ge d_T$ required by surjectivity holds for $65\ge14$. **CONFIRMED AS ALGEBRA**, conditional on H4 and H5.

**Edges.** The kernel of $\mu$ enters only through its invariants $(\ker\mu)^{O(5)}$, of dimension $d_D-d_T$, and the nullity names that space correctly. The degenerate sample is Candidate 3.1. $O(5)$ against $SO(5)$ changes nothing, by the $-I$ argument in the inventory. The $\mathcal W$ against $\mathcal W^*$ discrepancy in the display is absorbed by H6.

## 4. "No sample points are needed for it ... both are now theorems" (attack item 4)

**Derivation on file.** Line 148 says the task list's "evaluate $B_{ij}$ at $\ge15$ points and read off the rank" is "what complete reducibility gives". It says reviewer 200's observation that rank $14$ implies consistency "collapses the two stated tests into one, and both are now theorems".

**Candidate 4.1: the sampled test is not a theorem, and the record says so one paragraph later.**

1. *Locate.* Line 148, "both are now theorems", against line 150, "No theorem supplies unisolvence, so **the sampled rank check is not retired**".
2. *Exhibit.* The task-list test reads a rank off evaluations at sample points, which is $\mathrm{rank}(A)$ for $\lvert S\rvert\ge15$. A sample of $15$ points all equal to $0$ gives $\mathrm{rank}(A)=0$. Complete reducibility gives $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=d_T$, and it does not give the value $14$, which line 56 attributes to a script. The consistency half rests on H9, an observation not quoted in the brief, with "consistency" undefined, so no argument is on file for it.
3. *Charitable reading.* "It" and "both" may mean the abstract analogues of the tests. Even then, the abstract rank's value is the script's $14$, which does not make it a theorem, and the consistency implication still has no argument on file. The reading leaves line 148 in direct contradiction with line 150 about the sampled check.

Candidate survives. **REFUTED AS STATED.** "No sample points are needed" is correct for the identity $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=d_T$ and for nothing more.

## 5. The section heading (attack item 5)

**On file.** Line 142: "The rank is a theorem on the full space, and an open question on the restricted one."

**Candidate 5.1: "the restricted one" is undefined, and its natural reading contradicts the lemma.**

1. *Locate.* Line 142, against line 124, "$\mathrm{rank}(\mu\vert_{\mathrm{inv}})=14$ ... by exactness".
2. *Exhibit.* The only restriction the section performs is $\mu\vert_{\mathrm{inv}}$, restriction to invariants, and the section calls its rank a theorem (lines 144-150). Read literally, the heading calls that same rank an open question. The rank of the unrestricted $\mu$ is $\dim\mathrm{Sym}^6\mathcal W^*$ by H1, and the section never states it. The sampled $A$ is the only open item the section contains, and "restricted" is not what the section calls it.
3. *Charitable reading.* "Full space" may mean the abstract invariant map, and "restricted" the sampled one. That reading matches line 150 and conflicts with line 148. A second reading takes "restricted" from [L89.lean:22-25](../lean/HamiltonsCubic/Results/L89.lean#L22), where it names L62's restricted map. That map is absent from the section, so the heading would then refer to an object the section does not contain.

Candidate survives as a defect of statement: no reading makes the heading agree with every paragraph under it. **GAP.** The section would need to define "the restricted one" and say what is open about it.

## 6. results.md's additions (attack item 6)

**6a. "the rank and nullity follow without a measurement"** (line 294), with "Surjectivity of $\mu$ is elementary, neither imported nor measured" (line 976).

**Candidate 6a.1.**

1. *Locate.* results.md line 294, "so the rank and nullity follow without a measurement".
2. *Exhibit.* The rank is $d_T$, and line 56 states "$\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$ is the output of run_n5_constraint_count.py, and no argument on file derives it". The nullity is $d_D-d_T$, and line 110 states that $65$ inherits "L83's standing as an Observation". Both values the sentence says follow without measurement rest on a measurement. [InvariantsExact.lean:26-27](../lean/HamiltonsCubic/Results/InvariantsExact.lean#L26) agrees: "What stays owed is the projection's existence and the rank `14`, ... the second a computation."
3. *Charitable reading.* "Without a measurement" may mean without a *new* measurement beyond the counts. The sentence says the rank and nullity "follow", and they follow only from the counts, which it does not mention. The surjectivity half of line 976 is correct, and "the exactness step is a genuine theorem" is correct (Section 2).

Candidate survives. **REFUTED AS STATED.**

**6b. "no measured link drops: the map's domain is not one the certificate route ranges over, and that route consumes $13$ rather than $14$"** (line 976).

The certificate route, its domain and the source of $13$ are not defined in the brief, and no argument for either clause is quoted. [L89.lean:22-25](../lean/HamiltonsCubic/Results/L89.lean#L22) glosses $13$ as L62's lower bound on a restricted map, and L62 is outside this brief. Two things would have to be proved:

- the certificate route's domain $D'$, identified explicitly, with its relation to $D$ stated;
- the quantity the route consumes, identified as $\mathrm{rank}(\mu\vert_{D'})\ge13$.

One observation bears on the Lean gloss "Those never combine" and does not count as a finding. If $D'\subseteq D$, then $\mathrm{rank}(\mu\vert_{D'})\le\mathrm{rank}(\mu\vert_{\mathrm{inv}})=d_T$, and together with $\ge13$ that pins the rank to $\{13,14\}$. The two bounds would then combine to a window, while still determining neither value. Passage C's first clause asserts $D'$ is not of this kind, without argument. **HYPOTHESIS-DEBT.**

## 7. The Lean files (attack item 7, standing item 5)

**[L89.lean](../lean/HamiltonsCubic/Results/L89.lean)** imports `HamiltonsCubic.Results.L83` and two tactic modules. It does not import InvariantsExact. Theorem by theorem:

- `rank_nullity`: $14+51=65$ by `decide`. Arithmetic.
- `sixty_five_from_table`: $\sum\binom{m+1}2=65$ over L83's stored `table`, by `decide`. This is a fact about the stored list. It says nothing about $\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5)^{O(5)}$, and the table's contents were not opened (outside this brief).
- `nullity_determined`: $r=14\Rightarrow65-r=51$. The hypothesis `hr` is unused.
- `split_exists`: see Candidate 1.1.
- `directions_dont_combine`, `directions_dont_combine'`, `transversality_weaker`, `sampled_no_equality`, `attained_cap`: existential or implicational statements about natural numbers, with no map, space or group. `attained_cap` correctly records the squeeze Section 3 identifies as missing from the display.

No theorem mentions $\mathcal W_5$, $\mu$, $O(5)$, invariants or a rank. The file's own docstring says "The exactness argument is algebra and stays imported."

**[InvariantsExact.lean](../lean/HamiltonsCubic/Results/InvariantsExact.lean)** imports Mathlib's linear maps and reals. `invariant_lift` is read link by link. From `hf w` obtain $v_0$ with $f v_0=w$. The witness $\pi_V v_0$ satisfies $\pi_V(\pi_V v_0)=\pi_V v_0$ by `hidem`, and $f(\pi_V v_0)=\pi_W(f v_0)=\pi_W w=w$ by `hcomm`, `hv₀` and `hw`. The proof is correct. The file models "invariant" as "fixed by the projection". Identifying that with $O(5)$-invariance needs $\operatorname{im}\pi=\operatorname{Fix}\pi=$ invariants, which is part of the owed existence of the Reynolds operator, as the docstring says (lines 26-27). $\pi_W$ is never required to be idempotent, which is correct and minimal.

**Candidate 7.1: `idempotence_is_needed` does not show idempotence is needed.**

1. *Locate.* [InvariantsExact.lean:46-50](../lean/HamiltonsCubic/Results/InvariantsExact.lean#L46). The docstring says "Without it the lift need not be invariant", and the theorem is $\exists\pi,(\forall v,\pi v=2v)\wedge\exists v,\pi(\pi v)\ne\pi v$.
2. *Exhibit.* In the docstring's own example, $V=W=\mathbb R$, $f=\mathrm{id}$, $\pi_V=\pi_W=2\cdot$. Here `hcomm` holds, and `hw` gives $2w=w$, so $w=0$. Then $v=0$ satisfies $\pi_V v=v$ and $f v=w$, so the conclusion of `invariant_lift` holds without idempotence. The theorem proves only that doubling is not idempotent.
3. *Charitable reading.* It may illustrate that the proof step `hidem v₀` uses idempotence, without claiming the conclusion fails. That is a true remark about the proof. The docstring's "the lift need not be invariant" is still a claim about the conclusion that the example does not witness.

Candidate survives as a Lean documentation defect. It leaves the lemma unaffected.

**Verdict for item 7: REFUTED AS STATED** against any reading that the Lean files state or prove L89. Neither file states the lemma. InvariantsExact proves the abstract exactness step conditional on the projections. L89.lean proves arithmetic about $14$, $51$ and $65$, with $65$ tied to L83's stored table and $14$ appearing only as a literal.

## 8. Scope (attack item 8, standing item 4)

**Proven** (modulo the unfiled classical H3): $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=d_T$ and $\dim\ker(\mu\vert_{\mathrm{inv}})=d_D-d_T$.

**Stated** (lines 124, 294, 976): rank $14$, nullity $51$, "without a measurement".

**Gap between them.** These are exactly H4 and H5. What would have to be proved:

- $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$, derived (line 56 says no argument on file derives it);
- L83's multiplicities $m_\lambda$ of $\mathrm{Sym}^3\mathcal W_5$, from which line 110's Schur argument gives $\sum\binom{m_\lambda+1}2=65$.

Passage B's Schur step itself was read as given. Its real-type argument is consistent with the $-I$ observation above: $U$ factors through $SO(5)$, so no spin weight, and hence no half-integral coordinate, occurs. **HYPOTHESIS-DEBT.**

## 9. Falsifiers, and what was done to look for each (standing item 7)

| Claim | Falsifying object | Search |
|---|---|---|
| H1 surjectivity | a degree-6 monomial with no factorisation into two cubics | none exists, since $\lvert a\rvert=6$ always admits $b\le a$ with $\lvert b\rvert=3$. Found instead that the Lean witness does not produce such a $b$ (Candidate 1.1) |
| H2 equivariance | $g\in O(5)$ with $g\cdot(pq)\ne(g\cdot p)(g\cdot q)$ | impossible, since the action is by algebra automorphisms |
| H3 exactness | a surjective equivariant map between finite-dimensional $O(5)$-modules whose invariant restriction is not onto | excluded by the Haar projection. Checked $O(5)$ compact, and $SO(5)$ against $O(5)$ via $-I$ |
| Display for sampled $A$ | a sample with $\mathrm{rank}(A)<14$ | $S=\{0\}$, or any $\lvert S\rvert\le13$ (Candidate 3.1) |
| "both are now theorems" | a $\ge15$-point sample with rank $\ne14$ | fifteen copies of $0$ (Candidate 4.1) |
| Heading | a paragraph of the section contradicting it | line 148 against line 150 under every reading (Candidate 5.1) |
| "without a measurement" | a measured input to rank or nullity | line 56's script output and line 110's Observation (Candidate 6a.1) |
| Certificate-route clauses | a certificate domain $D'\subseteq D$, or a consumed quantity other than $13$ | not decidable from the brief. The objects are undefined here (6b) |
| Lean states L89 | a Lean theorem mentioning $\mu$, $\mathcal W_5$ or a rank | read both files in full, none found (Section 7) |
| $d_T=14$, $d_D=65$ | a closed-form invariant count different from these | no numerical work is allowed and no derivation is on file, so neither was examined. Recorded as debt (Section 8) |

## 10. Withdrawn candidates

- **W1. $\mathcal W_5$ against $\mathcal W_5^*$ in the display.** (1) Line 146 writes $\mathrm{Sym}^6\mathcal W_5$, while $\mu$ lands in $\mathrm{Sym}^6\mathcal W_5^*$ (line 144). (2) The invariant dimensions would differ only if $\mathcal W\not\cong\mathcal W^*$. (3) Charitably, and in fact, the $O(5)$-invariant inner product makes them isomorphic. Withdrawn: no failure can be exhibited. Recorded as the unstated H6.
- **W2. $O(5)$ against $SO(5)$.** (1) Passage B argues via $\mathfrak{so}(5)$-modules and Weyl groups, while the statement is for $O(5)$. (2) Invariants could differ if $-I$ acted nontrivially. (3) $-I$ acts by $(-1)^4=1$ on 4-tensors, so the invariants coincide. Withdrawn: no failure can be exhibited.
- **W3. Lean's "where the block invokes both".** (1) [L89.lean:48-49](../lean/HamiltonsCubic/Results/L89.lean#L48) says surjectivity "needs neither reductivity nor characteristic zero, where the block invokes both", which suggests the block uses them for surjectivity. (2) Line 144 invokes them for the exactness step, not for surjectivity. (3) Charitably, the docstring says only that the block invokes both somewhere, which is true. Withdrawn.
- **W4. "Reductive" misapplied to the disconnected $O(5)$.** (1) Line 144, "$O(5)$ is reductive". (2) Linear reductivity could fail for a disconnected group. (3) In characteristic zero it holds whenever the identity component is reductive, and $O(5)$ is compact in any case. Withdrawn.

## Overall verdict

**HYPOTHESIS-DEBT.** The structural argument is sound: $\mu$ is onto, equivariant, and exactness gives $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=\dim T$. Surjectivity lacks a written argument (GAP, low severity). The numbers $14$ and $51$ rest on a script output and on L83's Observation. The display's $\mathrm{rank}(A)=14$ for the sampled matrix, "both are now theorems" and results.md's "without a measurement" are each refuted as stated. Neither Lean file states the lemma.
