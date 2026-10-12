# Verifier v304, Lemma L89: surjectivity of mu, exactness of invariants, rank 14 and nullity 51, the sampled display, Passage C and the Lean files

Cold brief, no numerical work, every value exact, no scripts. Log: [agent_logs/verify-L89-v304.log](../agent_logs/verify-L89-v304.log).

| # | Claim | Verdict |
|---|---|---|
| C1 | $\mu$ is surjective and $O(5)$-equivariant (Passage A line 144, Passage C "elementary") | GAP |
| C2 | invariants are exact, so $\mu\vert_{\mathrm{inv}}$ maps onto $(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}$ | CONFIRMED |
| C3 | $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=14$, nullity $51$ (heading, line 124) | HYPOTHESIS-DEBT |
| C4 | the display "$\mathrm{rank}(A)=14$ exactly" (line 146) | REFUTED AS STATED |
| C5 | "No sample points are needed for it ... both are now theorems" (line 148) | REFUTED AS STATED |
| C6 | the section heading, "a theorem on the full space, and an open question on the restricted one" (line 142) | REFUTED AS STATED |
| C7 | Passage C, "the rank and nullity follow without a measurement" (results.md 294, 976) | REFUTED AS STATED |
| C8 | Passage C, "the map's domain is not one the certificate route ranges over, and that route consumes $13$ rather than $14$" | HYPOTHESIS-DEBT |
| C9 | the Lean files state or prove L89 | GAP |

**Summary:** the structural step (surjective equivariant map, Reynolds projection, so rank equals the dimension of the target invariants and nullity is domain invariants minus that) is correct, but both numbers it outputs, $14$ and $65$, are Observations, so every sentence calling the rank a theorem or measurement-free is refuted as stated, and the display about the sampled $A$ fails at a degenerate sample.

Overall verdict: **HYPOTHESIS-DEBT**.

## 0. Conventions, fixed once

- $\mathcal W_5$ is the real space of algebraic Weyl tensors on $\mathbb R^5$, with $O(5)$ acting by $(g\cdot W)_{abcd}=g_a{}^pg_b{}^qg_c{}^rg_d{}^sW_{pqrs}$. Its $O(5)$-invariant inner product identifies $\mathcal W_5\cong\mathcal W_5^*$ as $O(5)$-modules, so $\mathrm{Sym}^k\mathcal W_5$ and $\mathrm{Sym}^k\mathcal W_5^*$ have equal invariant dimensions. L83.lean's stored table has $\sum m\cdot d=7770=\binom{37}3$, consistent with $\dim\mathcal W_5=35$.
- The field is $\mathbb R$. The group is $O(5)$. Polynomials on $\mathcal W_5$ carry $(g\cdot p)(w)=p(g^{-1}w)$.
- $\mu:\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)\to\mathrm{Sym}^6\mathcal W_5^*$ is the linear map induced by $p\otimes q\mapsto pq$.
- $\mu\vert_{\mathrm{inv}}$ is $\mu$ restricted to $D:=\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)^{O(5)}$ with target $T:=(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}$. Equivariance makes $\mu(D)\subseteq T$.
- "The abstract map" is $\mu\vert_{\mathrm{inv}}:D\to T$. "The sampled matrix" $A$ is, per line 150, the pipeline's coefficient matrix: columns indexed by a basis $G_1,\dots,G_{65}$ of $D$, rows by sample points $w_1,\dots,w_N\in\mathcal W_5$, entry $\mu(G_k)(w_j)$. So $A=E\circ\mu\vert_{\mathrm{inv}}$ in coordinates, with $E:T\to\mathbb R^N$ evaluation at the sample.
- Quotations were checked against their sources by displaying only the cited lines (sym3-blocks.md 124, 142-150, 56, 110, results.md 294, 976). All match the brief verbatim.

## Hypothesis inventory

| Hypothesis | Source | Used where | Stated? | Standing |
|---|---|---|---|---|
| H1. $\mu$ is surjective | line 144 | exactness step | asserted, no argument in prose | true, written proof absent (C1) |
| H2. $\mu$ is $O(5)$-equivariant | line 144 | $\mu(D)\subseteq T$, Reynolds commutes | asserted | holds (C1) |
| H3. taking $O(5)$-invariants is exact on these modules | line 144 | surjectivity of $\mu\vert_{\mathrm{inv}}$ | asserted via reductivity and characteristic zero | classical, unfiled (Reynolds operator, Definitions line 38) |
| H4. the modules are finite-dimensional rational (polynomial) representations | nowhere | needed for H3 in its reductive-group form | **used but unstated** | holds: $\mathrm{Sym}^k\mathcal W_5^*$ are polynomial representations |
| H5. $\dim T=14$ | line 146, imported | the value of the rank | stated as fact | Observation, script output (line 56), no argument on file |
| H6. $\dim D=65$ | line 146 ("$65-14$"), imported | the value of the nullity | stated as fact | Observation, inherits L83 (line 110) |
| H7. rank-nullity for $\mu\vert_{\mathrm{inv}}:D\to T$ | implicit | nullity $=\dim D-\mathrm{rank}$ | unstated, standard | holds |
| H8. unisolvence of the sample for $T$ | line 150 | $\mathrm{rank}(A)=14$ | **used by the display, stated as unsupplied** in line 150 | not supplied |
| H9. the certificate route's domain and its consumed rank $13$ | results.md 976 | Passage C's final clause | asserted | no argument in the brief (C8) |
| H10 (imported by line 110). every $V_\lambda$ in $\mathrm{Sym}^3\mathcal W_5$ is of real type | line 110 | $\dim D=\sum\binom{m_\lambda+1}2$ | argued there | argument read, sound for genuine $SO(5)$-representations, see 3.2 |

## 1. C1, surjectivity and equivariance of $\mu$

**Equivariance.** For $g\in O(5)$, $g\cdot(pq)=(g\cdot p)(g\cdot q)$ because $(pq)(g^{-1}w)=p(g^{-1}w)q(g^{-1}w)$. The action on $\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)$ is diagonal, so $\mu(g\cdot(p\otimes q))=\mu((g\cdot p)\otimes(g\cdot q))=g\cdot\mu(p\otimes q)$, and linearity extends it. Confirmed.

**Surjectivity.** Passage A line 144 asserts "which is surjective" with no argument. Passage C calls it "elementary, neither imported nor measured" with no argument. The only argument on file is L89.lean's `split_exists`, whose docstring calls it "the whole of the surjectivity argument".

Candidate C1-a, the written proof of surjectivity does not prove it.
1. **Locate.** L89.lean lines 47-51: `theorem split_exists (e : ℕ) (he : e ≤ 6) : ∃ x y, x + y = e ∧ x ≤ 3 ∧ y ≤ 3`, docstring "which is the whole of the surjectivity argument".
2. **Exhibit.** Surjectivity onto $\mathrm{Sym}^6$ needs each degree-6 monomial $x^\alpha$ written as $x^\beta x^{\alpha-\beta}$ with $\lvert\beta\rvert=\lvert\alpha-\beta\rvert=3$. `split_exists` bounds each coordinate's share by $3$, which constrains nothing about total degree. Take $\alpha=(1,1,1,1,1,1,0,\dots,0)$, the monomial $x_1x_2x_3x_4x_5x_6$. The theorem's own witness `min e 3` splits every coordinate as $(1,0)$ or $(0,0)$, giving the pair $x_1\cdots x_6$ and $1$, of degrees $6$ and $0$, which is not an element of $\mathrm{Sym}^3\otimes\mathrm{Sym}^3$. The theorem mentions no multi-index, no polynomial and no $\mu$.
3. **Charitable reading.** The statement is a folklore fact and "elementary" is a pointer to it. That reading makes the claim true, and I searched for a falsifier (a degree-6 polynomial outside the span of products of two cubics) and found none, but it leaves the record's written chain without the step. The Lean docstring's claim to hold "the whole of the argument" survives no reading.

**Verdict C1: GAP.** Equivariance holds. Surjectivity is true but the record carries no correct proof of it. What would have to be proved: every multi-index of total degree $6$ has a sub-multi-index of total degree $3$. Minor in severity.

## 2. C2, exactness gives $\mu\vert_{\mathrm{inv}}$ onto $T$

**Derivation checked.** $O(5)$ is compact, so Haar measure gives Reynolds operators $R_V=\int_{O(5)}g\,dg$ on each finite-dimensional representation. Each $R_V$ is linear, idempotent, has image $V^{O(5)}$, fixes exactly the invariants, and satisfies $f\circ R_V=R_W\circ f$ for equivariant $f$ (by linearity of $f$ under the integral). InvariantsExact.lean's `invariant_lift` (lines 36-44) takes exactly these hypotheses: `hf` surjective, `hidem` idempotence of $\pi_V$, `hcomm` intertwining, `hw : πW w = w`. Its proof: lift $w=f(v_0)$, set $v=\pi_Vv_0$, then $\pi_Vv=v$ by `hidem` and $f(v)=\pi_W(f v_0)=\pi_W w=w$. Each link is correct. Applied to $f=\mu$, $\pi_V=R_{\mathrm{Sym}^2\mathrm{Sym}^3}$, $\pi_W=R_{\mathrm{Sym}^6}$, it gives $\mu(D)=T$.

**The line as written.** "$O(5)$ is reductive and the characteristic is zero, so taking invariants is an exact functor." For the algebraic group $O(5)$ (disconnected, reductive identity component) in characteristic zero, rational representations are completely reducible, which gives exactness on rational representations (H4, unstated but satisfied). $O(5)(\mathbb R)$ is Zariski dense in $O(5)_{\mathbb C}$, so real-point invariants and algebraic-group invariants agree. Either route supplies H3. The minimal justification is the existence of an idempotent equivariant projection onto invariants, as InvariantsExact.lean says. "An exact functor carries a surjection to a surjection": exact functors preserve epimorphisms. Correct.

Hypothesis H1 enters, so C2 is conditional on the true but unproved-on-file C1.

**Verdict C2: CONFIRMED** (Reynolds operator classical, unfiled).

## 3. C3, rank $14$ and nullity $51$

### 3.1 The structural identities

From C2, $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=\dim\mu(D)=\dim T$. Rank-nullity on $D\to T$ gives $\dim\ker(\mu\vert_{\mathrm{inv}})=\dim D-\dim T$. So "nullity" in line 146 is the domain dimension minus the rank, as the brief asks (attack item 3), provided $65=\dim D$. These are CONFIRMED AS ALGEBRA.

### 3.2 The numbers

- $14=\dim T$. Line 56: "$\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$ is the output of run_n5_constraint_count.py, and no argument on file derives it." It is an Observation.
- $65=\dim D$. Line 110 derives $\dim\mathrm{Sym}^2(U)^{O(5)}=\sum_\lambda\binom{m_\lambda+1}2$ by Schur, then evaluates on L83's table. The Schur step I read: for real-type $V$, $(\mathrm{Sym}^2V)^{G}$ is one-dimensional and $(\Lambda^2V)^G=0$, and $\mathrm{Sym}^2(V\otimes M)=\mathrm{Sym}^2V\otimes\mathrm{Sym}^2M\oplus\Lambda^2V\otimes\Lambda^2M$, while cross terms between non-isomorphic $V_\lambda,V_{\lambda'}$ carry no invariants. The real-type argument holds for genuine $SO(5)$-representations. The multiplicities $m_\lambda$ are L83's stored data (L83.lean line 8 calls them "the imported content"), and line 110 says "the two numbers inherit L83's standing as an Observation". L89.lean's `sixty_five_from_table` checks only that the stored list sums to $65$.

Candidate C3-a, the heading states as a lemma what rests on two Observations.
1. **Locate.** Line 124: "Lemma L89, $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=14$, nullity $51$, by exactness of the invariants functor".
2. **Exhibit.** Exactness yields $\mathrm{rank}=\dim T$ and $\mathrm{nullity}=\dim D-\dim T$ and nothing numerical. The only sources on file for $\dim T=14$ and $\dim D=65$ are, by the record's own lines 56 and 110, a script output and L83's Observation.
3. **Charitable reading.** The lemma means "given the invariant counts, rank and nullity are these". That reading is correct, and it is the conditional statement, with the two counts as hypotheses the heading does not name.

**Verdict C3: HYPOTHESIS-DEBT.** What would have to be proved: $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$ and L83's multiplicity list (hence $\sum\binom{m_\lambda+1}2=65$).

## 4. C4, the display $\mathrm{rank}(A)=14$ exactly

Candidate C4-a.
1. **Locate.** Line 146: "$\mathrm{rank}(A)=\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14\quad\text{exactly}$", with line 150 fixing "the pipeline's $A$ is the *sampled* coefficient matrix, whose rank is $\le14$ with equality only when the sample points are unisolvent".
2. **Exhibit.** $A=E\circ\mu\vert_{\mathrm{inv}}$ has $\mathrm{rank}(A)=\dim E(T)$, which is $14$ iff $E$ is injective on $T$. Take every sample point $w_j=0$. Every element of $\mathrm{Sym}^6\mathcal W_5^*$ is homogeneous of degree $6$ and vanishes at $0$, so $A$ is the zero matrix and $\mathrm{rank}(A)=0\neq14$. A single sample point gives $\mathrm{rank}(A)\le1$. The display carries no unisolvence hypothesis.
3. **Charitable reading.** $A$ in line 146 denotes the matrix of the abstract map in bases of $D$ and $T$, and line 150 reuses the letter for the sampled matrix. Under that reading the display is C3's conditional identity and correct. But the section itself names $A$ only as the sampled matrix, so the display as written asserts equality for an object line 150 says it is unproved for. Line 150's own account (rank $\le14$, equality iff unisolvent) is correct given C2.

**Verdict C4: REFUTED AS STATED.** The equality belongs to $\mu\vert_{\mathrm{inv}}$, conditional on H5.

## 5. C5, "No sample points are needed for it ... both are now theorems"

Candidate C5-a.
1. **Locate.** Line 148: "No sample points are needed for it. ... reviewer 200's observation that rank $14$ *implies* consistency collapses the two stated tests into one, and both are now theorems."
2. **Exhibit.** The two "stated tests" are the sampled rank read-off ("evaluate $B_{ij}$ at $\ge15$ points and read off the rank") and consistency. Line 150 says "the sampled rank check is not retired", and C4's zero sample shows the sampled rank is not determined by any theorem. Separately, "theorem" fails on H5: the $14$ is a script output (line 56). The implication "rank $14$ implies consistency" is attributed to a reviewer, and no argument for it is in the brief, and "consistency" is undefined there.
3. **Charitable reading.** "It" is the abstract rank, and "theorems" means "conditional on the counts". The first rescue is consistent with line 150. The second still leaves "both are now theorems" false for the sampled test, which line 150 keeps open, and leaves the consistency implication without an argument.

**Verdict C5: REFUTED AS STATED.** The consistency implication is additionally HYPOTHESIS-DEBT: what would have to be proved is the implication itself, with "consistency" defined.

## 6. C6, the heading "The rank is a theorem on the full space, and an open question on the restricted one"

Candidate C6-a.
1. **Locate.** Line 142.
2. **Exhibit.** (i) "The rank is a theorem": the rank's value is $\dim T=14$, an Observation (C3). (ii) "an open question on the restricted one": the section's only restricted map is $\mu\vert_{\mathrm{inv}}$, which the lemma's own heading (line 124) declares to have rank $14$. Nothing in lines 144-150 names another restricted map or discusses an open question about one. The only open item in the section is the sampled matrix $A$, which is a sampling of the full invariant map, not a restriction.
3. **Charitable reading.** "Full space" means $D$ and "restricted" means the certificate-route domain that Passage C and L89.lean's docstring (L62's "$\ge13$ on the restricted map") refer to. That reading makes (ii) coherent against other files, but the section never names that domain, and (i) survives only as "conditional on the counts".

**Verdict C6: REFUTED AS STATED.** "Theorem" overstates the value's standing, and "restricted" collides with the lemma's own $\mu\vert_{\mathrm{inv}}$ notation.

## 7. C7, Passage C "follow without a measurement"

Candidate C7-a.
1. **Locate.** results.md line 294: "Surjectivity of $\mu$ is elementary and the exactness step is a genuine theorem, so the rank and nullity follow without a measurement." Line 976 repeats the statement with "neither imported nor measured" for surjectivity.
2. **Exhibit.** The rank and nullity as numbers are $\dim T$ and $\dim D-\dim T$. Line 56: $\dim T=14$ "is the output of run_n5_constraint_count.py". Line 110: $65$ inherits L83's Observation standing. So the numbers $14$ and $51$ follow only from a measurement.
3. **Charitable reading.** "Without a measurement" means "without a further sampled-rank measurement". That reading is true and is what the structural step delivers. Passage C does not say it, and a reader of the landscape entry (line 294) gets a measurement-free theorem. "Neither imported nor measured" for surjectivity alone is correct in substance (C1), subject to C1's missing written proof. "The exactness step is a genuine theorem" is correct (C2).

**Verdict C7: REFUTED AS STATED.**

## 8. C8, "the map's domain is not one the certificate route ranges over, and that route consumes $13$ rather than $14$"

Candidate C8-a, no argument on file in the brief.
1. **Locate.** results.md line 976, final sentence.
2. **Exhibit.** The brief quotes no definition of the certificate route, its domain, or the value it consumes. L89.lean's docstring (lines 22-25) asserts "L62's $\ge13$ is a lower bound on the restricted map" and `directions_dont_combine`, `directions_dont_combine'`, `transversality_weaker` are existential statements about natural numbers ($\exists r,\ r\le14\wedge r\ne13$ and the like) which mention no map, domain or route. No object is available on which to check the clause.
3. **Charitable reading.** The clause cross-refers to L62, which is filed elsewhere and outside this brief. Even so, the clause is a claim the L89 record makes without argument.

**Verdict C8: HYPOTHESIS-DEBT.** What would have to be proved: the certificate route's domain $D'$ with $D'\ne D$ (or $D'\not\subseteq D$ in the relevant sense), and that the route consumes exactly the bound $\mathrm{rank}\ge13$ on the map from $D'$.

## 9. C9, the Lean files

**L89.lean** imports L83, NormNum, Linarith. Its theorems:
- `rank_nullity : 14 + 51 = 65` and `nullity_determined`: arithmetic on literals.
- `sixty_five_from_table`: the stored table's $\sum m(m+1)/2=65$ by `decide`. Natural-number division is exact since $m(m+1)$ is even. It checks the stored data, not the Observation behind it.
- `split_exists`: see C1-a, a per-coordinate split, not surjectivity.
- `directions_dont_combine`, `directions_dont_combine'`, `transversality_weaker`, `sampled_no_equality`, `attained_cap`: statements about natural numbers alone. `attained_cap` correctly records that $r_s\le r_t\le14\le r_s$ forces both to $14$.
- No theorem mentions $\mathcal W_5$, $\mu$, $O(5)$, invariants or a rank of a linear map.

**InvariantsExact.lean** imports Mathlib's linear maps and reals. `invariant_lift` is correct and matches C2's use (section 2). It is abstract: it takes the projections as hypotheses and does not construct Reynolds operators or apply the lemma to $\mu$. Its header says so ("What stays owed is the projection's existence and the rank $14$").

Candidate C9-a, `idempotence_is_needed` does not show what its docstring says.
1. **Locate.** InvariantsExact.lean lines 46-50, docstring "Without it the lift need not be invariant: scaling by two ... fixes only zero."
2. **Exhibit.** The theorem proves only that $\pi=2\cdot\mathrm{id}$ is not idempotent ($\pi(\pi(1))=4\ne2$). With $\pi_V=\pi_W=2\cdot\mathrm{id}$, hypothesis `hw` forces $w=0$, and $v=0$ is an invariant lift. So the example does not exhibit a failure of the lift.
3. **Charitable reading.** "Load-bearing" means only that the proof as written uses `hidem`. True, but the example is offered as evidence and does not bear on it. Minor, affecting no L89 claim.

Candidate C9-b, L89.lean's docstring "no reading of $A$ supports the display" (line 19). Under C4's charitable reading ($A$ the abstract matrix) the display is supported conditionally on H5, so the docstring overstates. Minor, recorded against the Lean commentary only.

**Verdict C9: GAP.** Neither file states $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=14$ or nullity $51$. The formalised content is the abstract invariant-lift lemma plus arithmetic on stored literals.

## 10. Standing list, answered item by item

1. **Hypothesis inventory.** The table above. Used but unstated: H4 (rational finite-dimensional representations) and H7 (rank-nullity on $D\to T$), both satisfied. Used by the display and stated as unsupplied: H8. Imported Observations: H5, H6.
2. **Quantifier order and scope.** The map: line 146 writes $A$, line 150 says $A$ is sampled, line 124 and Passage C say $\mu\vert_{\mathrm{inv}}$, the abstract map. Only the abstract map's rank is tied to $\dim T$ (C4). The group: $O(5)$ throughout. The field: $\mathbb R$, with $\mathcal W_5\cong\mathcal W_5^*$ used silently between line 144 ($\mathcal W_5^*$) and lines 56, 110, 146 ($\mathcal W_5$). The identification is $O(5)$-equivariant, so no finding.
3. **Edges.** Kernel of $\mu$: nullity is $\dim D-\dim T$, correct as algebra (3.1). The antisymmetric $24$ lie outside $D$ by definition of $\mathrm{Sym}^2$, as line 110 says. Degenerate sample: the zero sample (C4-a) gives $\mathrm{rank}(A)=0$. $O(5)$ against $SO(5)$: $-I\in O(5)$ acts on $\mathcal W_5$ by $(-1)^4=1$, and $O(5)=SO(5)\times\{\pm I\}$, so the two groups have the same image in $GL(\mathcal W_5)$ and the same invariants in every $\mathrm{Sym}^k\mathcal W_5^*$. No finding.
4. **Proven versus stated, Passages A and C.** Proven: $\mu\vert_{\mathrm{inv}}$ is onto $T$ (given C1's true but unwritten step), so $\mathrm{rank}=\dim T$ and nullity $=\dim D-\dim T$. Stated: rank $14$ and nullity $51$ as a theorem following "without a measurement" (C3, C5, C6, C7), $\mathrm{rank}(A)=14$ for the sampled $A$ (C4), and a claim about the certificate route (C8).
5. **Lean.** Neither file states or proves the lemma (C9).
6. **Brief attack items.**
   1. Surjectivity and equivariance: C1, GAP (equivariance holds, surjectivity lacks a correct written proof).
   2. Exactness: C2, CONFIRMED. Minimal justification: an idempotent projection onto invariants intertwined by $\mu$, from Haar averaging on compact $O(5)$.
   3. The display: C4, REFUTED AS STATED. The object with rank $\dim T$ is $\mu\vert_{\mathrm{inv}}$. $14$ from line 56 (script), $65$ from line 110 (L83 Observation). "Nullity" is domain dimension minus rank, correct as algebra.
   4. "No sample points ... both are now theorems" against line 150: C5, REFUTED AS STATED.
   5. The heading: C6, REFUTED AS STATED.
   6. Passage C's additions: C7 REFUTED AS STATED, C8 HYPOTHESIS-DEBT.
   7. Passage D: C9, GAP. L89.lean imports L83's stored table, InvariantsExact.lean imports only Mathlib linear-map and real-number files.
   8. Scope: the lemma's numerical content is exactly as strong as H5 and H6. If $\dim T$ or L83's multiplicities change, the rank and nullity change with them, and the structural identities survive unchanged (C3).
7. **Falsifiers and what I did.**

| Claim | Falsifying object | Search |
|---|---|---|
| C1 | a degree-6 polynomial outside the span of products of two cubics | examined monomials by total-degree splitting, none found. `split_exists`'s witness fails on $x_1\cdots x_6$, which falsifies the Lean argument, not the claim |
| C2 | an invariant sextic with no invariant preimage under $\mu$ | excluded by `invariant_lift` with Reynolds projections, hypotheses checked link by link |
| C3 | an invariant count $\dim T\ne14$ or a multiplicity list with $\sum\binom{m+1}2\ne65$ | not searchable without computation, which this loop forbids, so recorded as debt |
| C4 | a sample with $\mathrm{rank}(A)<14$ | exhibited: all points at $0$, $\mathrm{rank}(A)=0$ |
| C5 | a sampled test that no theorem settles | the same zero sample, and line 150 |
| C6 | a restricted map in the section with an open rank | none in lines 142-150, the only restricted map there is $\mu\vert_{\mathrm{inv}}$ with its asserted rank |
| C7 | a numerical input to the rank that is a measurement | line 56 names it |
| C8 | the certificate route's domain equal to $D$, or a consumed value other than $13$ | no definition of the route in the brief, nothing to test |
| C9 | a Lean theorem stating the rank of $\mu\vert_{\mathrm{inv}}$ | read both files in full, none exists |

### Withdrawn candidates

- **W1, the real-type argument of line 110 fails because quaternionic modules exist for $\mathfrak{so}(5)$.** Located at line 110, "a quaternionic $\mathfrak{so}(5)$-module has half-integral coordinates". Exhibit attempt: the $4$-dimensional spin module of $\mathfrak{sp}(2)\cong\mathfrak{so}(5)$ is quaternionic. Charitable reading, which prevails: it has half-integral $e$-coordinates $(\tfrac12,\tfrac12)$ and does not occur in $\mathrm{Sym}^3\mathcal W_5$, a genuine $SO(5)$-representation. Withdrawn at step 3.
- **W2, $O(5)$ against $SO(5)$ changes the invariant counts.** Exhibit attempt failed at step 2: $-I$ acts trivially on $\mathcal W_5$, so the invariant subspaces coincide. Withdrawn.
- **W3, the Reynolds step needs $O(5)$ connected.** Exhibit attempt failed at step 2: Haar averaging on a compact group, and complete reducibility for reductive groups with reductive identity component in characteristic zero, need no connectedness. Withdrawn.

## Overall verdict

**HYPOTHESIS-DEBT.** The exactness step is proven and gives $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$ and nullity $=\dim\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5)^{O(5)}-\mathrm{rank}$. The values $14$ and $51$ rest on a script output and L83's Observation. The display about the sampled $A$, "both are now theorems", the heading's "theorem", and Passage C's "without a measurement" are each refuted as stated. The certificate-route clause is unargued. Surjectivity of $\mu$ is true but its only written proof, L89.lean's `split_exists`, proves a different statement. The Lean files do not state the lemma.
