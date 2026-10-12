# Verifier v302, Lemma L89: surjectivity and equivariance of mu, exactness of invariants, the rank 14 and nullity 51 display, the sampled matrix A, Passage C's additions, and the Lean files

The brief ([BRIEF_L89.md](BRIEF_L89.md)) was cold. No numerical work was done, every value is exact, and no scripts were written or run. Log: [agent_logs/verify-L89-v302.log](../agent_logs/verify-L89-v302.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | mu: Sym^2(Sym^3 W5*) to Sym^6 W5* is surjective and O(5)-equivariant | CONFIRMED |
| 2 | Taking O(5)-invariants carries the surjection mu to a surjection of mu restricted to invariants onto (Sym^6 W5*)^O(5) | CONFIRMED |
| 3a | rank(mu restricted to invariants) = dim(Sym^6 W5)^O(5), nullity = dim Sym^2(Sym^3 W5)^O(5) minus that rank | CONFIRMED |
| 3b | The display "rank(A) = ... = 14 exactly", with A the sampled matrix | REFUTED AS STATED |
| 3c | The values 14 and 65, hence 51 | HYPOTHESIS-DEBT |
| 4 | "No sample points are needed for it ... both are now theorems" | REFUTED AS STATED |
| 4b | Reviewer 200's "rank 14 implies consistency" | HYPOTHESIS-DEBT |
| 5 | Section heading "an open question on the restricted one" | GAP |
| 6a | Passage C landscape: "the rank and nullity follow without a measurement" | REFUTED AS STATED |
| 6b | Passage C: "the map's domain is not one the certificate route ranges over, and that route consumes 13 rather than 14" | HYPOTHESIS-DEBT |
| 7a | L89.lean: split_exists is "the whole of the surjectivity argument" | REFUTED AS STATED |
| 7b | InvariantsExact.lean: invariant_lift (invariant lifts exist given intertwined idempotent projections) | CONFIRMED |
| 7c | Whether the Lean files state or prove Lemma L89 | GAP |
| 8 | Scope: the lemma's dependence on the standing of 14 and 65 | HYPOTHESIS-DEBT |

**Summary.** The structural theorem is proven: mu restricted to invariants is onto the invariant sextics, so its rank is the dimension of that space and its nullity the domain's invariant dimension minus it. The numbers 14 and 51 rest on Observations, the display names the sampled matrix A where only the abstract map has the property, and "both are now theorems" and "without a measurement" overstate the standing.

**Overall verdict: HYPOTHESIS-DEBT.** What would have to be proved: dim(Sym^6 W5)^O(5) = 14 and L83's multiplicity table (whence 65), each by an argument on file. The corrected statement that holds now is rank(mu restricted to invariants) = dim(Sym^6 W5)^O(5) and nullity = dim Sym^2(Sym^3 W5)^O(5) minus that dimension, with no claim about the sampled A beyond rank(A) at most that dimension.

## 0. Conventions, fixed once

- W = W5 is the real vector space of algebraic Weyl tensors on R^5, a subspace of the 4-fold tensor power of R^5, with O(5) acting by the tensor action.
- Polynomials: Sym^k W* is the space of homogeneous degree-k polynomial functions on W, with (g.p)(x) = p(g^{-1} x).
- mu: Sym^2(Sym^3 W*) to Sym^6 W* sends the symmetric product p.q to the polynomial product pq. A Gram G in Sym^2(Sym^3 W*) maps to its sextic.
- "Invariants" means O(5)-fixed vectors. mu_inv denotes the restriction of mu to Sym^2(Sym^3 W*)^O(5), with codomain (Sym^6 W*)^O(5).
- A is the object Passage A names: "the pipeline's A is the sampled coefficient matrix".
- Field: R throughout. Rank and nullity are the linear-algebra notions: nullity = dim domain minus rank.
- Sources checked at the cited lines only: [sym3-blocks.md](../findings/sym3-blocks.md) lines 56, 110, 124, 142-150, and [results.md](../results.md) lines 294 and 976. Every quotation in the brief matches its source verbatim. [L89.lean](../lean/HamiltonsCubic/Results/L89.lean) and [InvariantsExact.lean](../lean/HamiltonsCubic/Results/InvariantsExact.lean) were read in full. No other file was opened.

## 1. Hypothesis inventory

| Hypothesis or import | Source | Used where | Status |
|---|---|---|---|
| mu is surjective | Passage A line 144, "elementary" in Passage C | Exactness step | Stated. Argument on file only as the one-line prose in L89.lean line 47. True (section 2) |
| mu is O(5)-equivariant | Passage A line 144 | Exactness step | Stated, no argument written. True because O(5) acts by algebra automorphisms of the polynomial ring (section 2) |
| "O(5) is reductive and the characteristic is zero" implies invariants is exact | Passage A line 144 | Surjectivity of mu_inv | Imported, unfiled. Classical (Reynolds operator for compact O(5), or linear reductivity in characteristic zero). Hypotheses hold (section 3) |
| Existence of intertwined idempotent projections onto invariants | InvariantsExact.lean lines 26-27 | The formal lift | Recorded there as owed. It is the Reynolds operator, unfiled per brief line 38 |
| dim(Sym^6 W5)^O(5) = 14 | Passage B line 56 | The display and the title | Observation, script output, "no argument on file derives it" |
| dim Sym^2(Sym^3 W5)^O(5) = 65 | Passage B line 110 | Nullity 65-14 | Derived by Schur on L83's multiplicities, which are an Observation. Inherits that standing |
| W5 is isomorphic to W5* as O(5)-modules | Unstated | Passage A passes from Sym^6 W5* to Sym^6 W5, Passage B from Sym^3 W5* to Sym^3 W5 | Used but unstated. Holds via the O(5)-invariant inner product on tensors, so immaterial |
| Unisolvence of the sample points for the 14 invariants | Passage A line 150 | Needed for rank(A) = 14 in the display | Stated as not supplied by any theorem |
| "rank 14 implies consistency" | Passage A line 148, attributed to reviewer 200 | "both are now theorems" | No argument on file in the brief. "Consistency" is undefined in the passages |
| Certificate route's domain and its consumption of 13 | Passage C line 976 | "no measured link drops" | No argument on file in the passages. Lean docstring points to L62, unread |

## 2. Claim 1: surjectivity and equivariance of mu

**Derivation as written.** Passage A line 144 asserts "which is surjective and O(5)-equivariant" with no argument. Passage C line 976 calls surjectivity "elementary, neither imported nor measured". The only written argument is L89.lean line 47: "Every exponent in a degree-6 monomial splits with both halves at most 3".

**Check.**

- Surjectivity. Choose coordinates x_1..x_35 on W. Sym^6 W* is spanned by monomials x^e with |e| = 6. Reading the Lean prose as "a degree-6 monomial splits into two factor monomials of degree at most 3", the two degrees sum to 6, so each is exactly 3, and x^e = x^a x^b = mu(x^a . x^b). Every spanning vector of the target is hit, so mu is onto. The written prose supports this under that reading.
- Equivariance. (g.(pq))(x) = p(g^{-1}x) q(g^{-1}x) = ((g.p)(g.q))(x), so mu(g.(p.q)) = g.mu(p.q). The group acts by ring automorphisms, and mu is the multiplication.
- Neither step uses reductivity, characteristic zero, or anything about O(5) beyond its linear action on W.

**Verdict: CONFIRMED.** The Lean formalisation of the split is examined in section 9.

## 3. Claim 2: exactness gives mu_inv onto the invariant sextics

**Derivation as written.** "O(5) is reductive and the characteristic is zero, so taking invariants is an exact functor, and an exact functor carries a surjection to a surjection."

**Check, link by link.**

- The functor V to V^O(5) is left exact for any group. Right exactness on the sequence Sym^2(Sym^3 W*) to Sym^6 W* to 0 is exactly the statement that mu(Sym^2(Sym^3 W*)^O(5)) = (Sym^6 W*)^O(5).
- The imported theorem: for a compact group K acting continuously on finite-dimensional real representations, the Reynolds operator R = integral of g over Haar measure is an idempotent projection onto the invariants and commutes with every K-equivariant linear map. Equivalently, O(5) is linearly reductive over characteristic zero (reductive and characteristic zero suffices, O(5) having finitely many components). Both forms are classical and unfiled.
- Hypotheses against the object: O(5) is compact; Sym^2(Sym^3 W*) and Sym^6 W* are finite-dimensional polynomial, hence continuous, representations; mu is equivariant (section 2); the field is R. All hold.
- The minimal justification is the one in [InvariantsExact.lean](../lean/HamiltonsCubic/Results/InvariantsExact.lean) lines 12-16: lift an invariant w to any v0 with mu(v0) = w, then R(v0) is invariant and mu(R v0) = R(mu v0) = R w = w. It needs surjectivity of mu, idempotence of R, and the intertwining, and nothing else. Reductivity enters only through the existence of R.
- O(5) against SO(5): both are compact, so the step holds for either. For the numbers, -I acts on a 4-tensor by (-1)^4 = 1, so -I acts trivially on W5 and on every Sym^k W5, and O(5) = SO(5) x {±I} gives identical invariant spaces. The choice is immaterial here.

**Verdict: CONFIRMED**, with the Reynolds operator as an unfiled classical import whose hypotheses hold.

## 4. Claim 3: the display, rank and nullity, and the values

### 4a. The structural statement

- From section 3, mu_inv is onto (Sym^6 W*)^O(5), so rank(mu_inv) = dim(Sym^6 W*)^O(5) = dim(Sym^6 W)^O(5) (the last equality by W isomorphic to W* equivariantly).
- By rank-nullity, dim ker(mu_inv) = dim Sym^2(Sym^3 W*)^O(5) minus rank(mu_inv). "Nullity 65-14" is domain dimension minus rank, the correct notion.
- The kernel edge: exactness on 0 to ker mu to domain to target to 0 gives ker(mu_inv) = (ker mu)^O(5), so the 51 is the dimension of the invariant part of ker mu. Passage B's 24 antisymmetric invariants lie outside the domain, which is Sym^2, consistent with "the 24 change no sextic".

**Verdict: CONFIRMED.**

### 4b. The display names A

**Candidate: the display asserts rank(A) = 14 exactly for the sampled matrix.**

1. Locate. Line 146: "$$\mathrm{rank}(A)=\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14\quad\text{exactly, with nullity }65-14=51.$$" Line 150: "the pipeline's $A$ is the *sampled* coefficient matrix, whose rank is $\le14$ with equality only when the sample points are unisolvent for the $14$ invariants. No theorem supplies unisolvence".
2. Exhibit. Take the sample set consisting of the zero Weyl tensor T = 0. Every homogeneous sextic vanishes at T = 0, so every entry of the sampled coefficient matrix is 0, A = 0, and rank(A) = 0, not 14. More generally a sample of k < 14 points gives rank(A) at most k < 14. The exactness argument places no condition on the sample and so cannot yield rank(A) = 14.
3. Charitable reading. "A" in the display denotes the matrix of the abstract mu_inv in bases, and the display is then section 4a. This reading is refuted by the record itself: line 150 fixes A as "the pipeline's ... sampled coefficient matrix" and states "The theorem is about $\mu$, not about the sampled matrix $A$". Under that naming the display is false for degenerate samples. What holds for the sampled A is rank(A) at most rank(mu_inv), with nullity of A at least 51 given the numbers.

The candidate survives. **Verdict: REFUTED AS STATED.** Replacing A by mu_inv gives the true statement of 4a.

### 4c. The values 14 and 65

- The 14: line 56, "$\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$ is the output of [run_n5_constraint_count.py] ... and no argument on file derives it". Script output with no argument is HYPOTHESIS-DEBT under brief line 39.
- The 65: line 110 derives Sigma C(m+1,2) = 65 by Schur on L83's table, and closes "the two numbers inherit L83's standing as an Observation". The Schur step is an argument, but its input multiplicities are an Observation, so the value carries debt.
- Complete reducibility gives rank(mu_inv) = dim of the invariant sextics. It does not give the value of that dimension. Line 148's "what complete reducibility gives" therefore covers the equality and not the 14.

**Verdict: HYPOTHESIS-DEBT.** Owed: a derivation of dim(Sym^6 W5)^O(5) = 14, and a derivation of L83's multiplicity table (or directly of dim Sym^2(Sym^3 W5)^O(5) = 65).

## 5. Claim 4: "No sample points are needed for it ... both are now theorems"

**Candidate: the paragraph promotes the sampled test and the value 14 to theorems.**

1. Locate. Line 148: "**No sample points are needed for it.** The task list carried "evaluate $B_{ij}$ at $\ge15$ points and read off the rank", which asks a computation for what complete reducibility gives; reviewer 200's observation that rank $14$ *implies* consistency collapses the two stated tests into one, and both are now theorems."
2. Exhibit. (i) The next paragraph, line 150, says the opposite about the same test: "the sampled rank check is not retired". The test on the task list is a sampled rank read-off, which by 4b can return 0 on the zero sample, so it is no theorem. (ii) The rank "14" is not a theorem: line 56 records it as script output with no argument on file. (iii) "rank 14 implies consistency" has no argument in the passages and "consistency" is not defined there.
3. Charitable reading. "It" is the abstract rank, and "theorems" means "conditional on the dimension count": rank(mu_inv) equals the invariant dimension, unconditionally. That reading rescues "No sample points are needed" for the equality in 4a, but it cannot rescue "both are now theorems", which names the two task-list tests, one a sampled read-off retracted by line 150 and the other resting on an unargued implication, and both carry the unproved value 14.

The candidate survives. **Verdict: REFUTED AS STATED** for "both are now theorems". The implication "rank 14 implies consistency" is **HYPOTHESIS-DEBT**: owed is its statement with "consistency" defined, and a proof.

## 6. Claim 5: the section heading

**Candidate: the heading's "open question on the restricted one" names nothing the section contains.**

1. Locate. Line 142: "## The rank is a theorem on the full space, and an open question on the restricted one".
2. Exhibit. The only restricted map the section names is mu restricted to invariants, in the lemma title (line 124) and line 150, and the section calls its rank a theorem. The only open item in the section is the unisolvence of a sample for the sampled A (line 150), which is a sampled matrix, not a restriction of mu to a subspace. Read literally, the heading calls open the very map whose rank the section proves.
3. Charitable reading. "Full space" means the full 65-dimensional invariant domain and "restricted" means the certificate route's smaller domain, the reading in Passage C line 976 and in L89.lean lines 22-23 ("a lower bound on the *restricted* map"). Under this reading the heading is consistent with Passage C, but the section defines no such domain, states no open question about it, and contains no word about it.

Both readings leave the heading's second half without content in the section it heads. **Verdict: GAP.** Owed: either the definition of the restricted map and the statement of the open question in the section, or a heading that names what the section proves (the abstract mu_inv) and what it leaves open (the sampled A).

## 7. Claim 6: Passage C

### 6a. "the rank and nullity follow without a measurement"

1. Locate. results.md line 294: "Surjectivity of $\mu$ is elementary and the exactness step is a genuine theorem, so the rank and nullity follow without a measurement."
2. Exhibit. The rank value 14 is "the output of [run_n5_constraint_count.py]" (line 56), and the 65 inherits "L83's standing as an Observation" (line 110). Both values in "rank 14, nullity 51" rest on measurements.
3. Charitable reading. "Without a measurement" means without the sampled rank measurement of A, which is true of the equality rank(mu_inv) = invariant dimension. The sentence, however, says "the rank and nullity follow", and the rank and nullity it heads are the numbers 14 and 51.

The candidate survives. **Verdict: REFUTED AS STATED.** Line 976 ("neither imported nor measured") is correct as scoped to surjectivity and survives.

### 6b. The certificate route

- "the map's domain is not one the certificate route ranges over": the passages define neither the certificate route nor its domain, and no argument is given.
- "that route consumes 13 rather than 14": asserted without argument in the passages. L89.lean line 22 attributes the 13 to L62, which is outside the files I may open.
- The Lean theorems directions_dont_combine, directions_dont_combine' and transversality_weaker are existential statements about natural numbers and mention no map, domain or route, so they carry no argument for this claim.

**Verdict: HYPOTHESIS-DEBT.** Owed: the definition of the certificate route's domain, a proof that it differs from Sym^2(Sym^3 W5*)^O(5), and a proof that the route consumes the value 13.

## 8. Claim 8: scope

- Unconditional: mu_inv is onto (Sym^6 W5*)^O(5), its rank equals that space's dimension, and its nullity equals the invariant domain's dimension minus that.
- Conditional on two Observations: rank 14 (script, line 56) and nullity 51 (65 from Schur on L83's table, line 110).
- The title "rank 14, nullity 51" and Passage C's landscape line both state the conditional numbers as the lemma's content.

**Verdict: HYPOTHESIS-DEBT**, owed as in 4c.

## 9. Claim 7: the Lean files

### 7a. L89.lean, split_exists

**Candidate: split_exists does not formalise surjectivity.**

1. Locate. L89.lean lines 47-51: "**Every exponent in a degree-`6` monomial splits with both halves at most `3`**, which is the whole of the surjectivity argument" over `theorem split_exists (e : ℕ) (he : e ≤ 6) : ∃ x y, x + y = e ∧ x ≤ 3 ∧ y ≤ 3`.
2. Exhibit. The theorem is about one natural number. Read per coordinate, on the multi-index e = (1,1,1,1,1,1,0,...,0) of the monomial x_1 x_2 x_3 x_4 x_5 x_6, the witness min(e_i,3), e_i - min(e_i,3) gives halves (1,1,1,1,1,1,0,...) and (0,...,0), of degrees 6 and 0, which is no factorisation into two cubics. Read as the total degree, it gives the numbers 3 and 3 and no monomials. Under either reading the step that carries surjectivity, the existence of a degree-3 monomial dividing a given degree-6 monomial, is absent, and no polynomial, Sym or mu appears.
3. Charitable reading. The docstring's prose is the argument and the theorem records its arithmetic core. That is fair to the prose (section 2 accepts it), but the docstring's words "the whole of the surjectivity argument" attach to the theorem, and the theorem does not imply surjectivity.

The candidate survives. **Verdict: REFUTED AS STATED**, as a claim about the Lean file. Surjectivity itself stands (section 2).

### 7b. InvariantsExact.lean, invariant_lift

- Statement: for linear f: V to W surjective, linear pi_V, pi_W with pi_V idempotent and f(pi_V v) = pi_W(f v), every w with pi_W w = w has v with pi_V v = v and f v = w.
- Proof: obtain v0 with f v0 = w, take pi_V v0. Then pi_V(pi_V v0) = pi_V v0 by hidem, and f(pi_V v0) = pi_W(f v0) = pi_W w = w by hcomm, hv0, hw. Correct.
- "Invariant" is formalised as a fixed point of the projection. For the Reynolds operator the fixed points are exactly the invariants, so the theorem applies once the projection exists, which the file records as owed (lines 26-27).
- idempotence_is_needed shows a map v to 2v is not idempotent. It is correct and illustrates the hypothesis, though it does not show a failed lift.

**Verdict: CONFIRMED.**

### 7c. Whether the Lean files state or prove L89

- L89.lean imports HamiltonsCubic.Results.L83, NormNum and Linarith. It does not import InvariantsExact.lean, so the formal lift is not connected to it.
- Its theorems: rank_nullity (14 + 51 = 65), sixty_five_from_table (the sum over L83's table, whose definition sits in L83.lean, unopened), nullity_determined, split_exists, three existentials on naturals, sampled_no_equality and attained_cap. None mentions W5, O(5), mu, a rank or an invariant space.
- InvariantsExact.lean proves the abstract lift and does not instantiate it to mu or O(5).
- So neither file states Lemma L89. They check the arithmetic 14 + 51 = 65 against the stored table and the formal exactness lemma conditional on the projection.

**Verdict: GAP** (the lemma is unformalised, and the Lean record covers arithmetic and the abstract lift only).

## 10. Falsifiers sought

| Claim | Object that would falsify it | What was done |
|---|---|---|
| 1 Surjectivity | A degree-6 monomial with no degree-3 monomial divisor | Every multi-index of weight 6 dominates one of weight 3, so none exists |
| 1 Equivariance | g, p, q with g.(pq) different from (g.p)(g.q) | Excluded by the substitution identity |
| 2 Exactness | An invariant sextic with no invariant Gram preimage | Excluded by the Reynolds lift, whose hypotheses hold |
| 3b Display on A | A sample with rank(A) not 14 | Exhibited: the zero tensor, A = 0 |
| 3c, 8 Values | An exact derivation of dim(Sym^6 W5)^O(5) other than 14, or a multiplicity table with Sigma C(m+1,2) other than 65 | None on file in the passages. Not computed, under the no-numerics rule |
| 4 "Theorems" | The sampled test failing | The zero sample, as in 3b |
| 5 Heading | The section's treatment of a restricted map | Lines 142-150 read, none present |
| 6b Route | A route domain containing the invariant Grams, or a route consuming 14 | Not on file in the passages. L62 unopened, as instructed |
| 7a Lean split | A monomial the theorem fails to factor | Exhibited: x_1 x_2 x_3 x_4 x_5 x_6 under the per-coordinate reading |

## 11. Withdrawn candidates

- **L89.lean lines 47-49, "it needs neither reductivity nor characteristic zero, where the block invokes both".** Located at those lines. The failure would be misattribution: the block invokes reductivity and characteristic zero for the exactness step, not for surjectivity. Charitable reading: "the block" refers to the sentence pair of line 144, which invokes both for the argument as a whole, and the contrast drawn (surjectivity needs neither) is true. Withdrawn, the charitable reading holds.
- **L89.lean lines 22-24, "full-space surjectivity gives an **upper** bound on the *full* one".** Located there. The failure would be inversion: any map into a 14-dimensional space has rank at most 14, so surjectivity supplies the lower bound and hence equality. Charitable reading: surjectivity fixes the full rank at 14, which is an upper bound for the restricted map, and that is how directions_dont_combine uses it (rres at most rfull at most 14). Withdrawn, the intended content holds for the use made of it.
- **InvariantsExact.lean line 8 quotes L89 as recording "exactness of `(-)^{O(5)}` via the Reynolds operator, and the rank `14` itself" as owed.** Located there. The failure would be a phantom quotation: L89.lean, read in full, contains no such text. Charitable reading: the quotation is from L89's row in the Lean index, which I am barred from opening, or from an earlier version of the file. Withdrawn, the charitable reading cannot be excluded from the permitted files.
- **results.md line 976, "by exactness of the sequence".** Located there. The failure would be that no sequence is named. Charitable reading: the sequence Sym^2(Sym^3 W*) to Sym^6 W* to 0, whose image under invariants is exact, which is Passage A's argument. Withdrawn.
- **Passage B's real-type argument is phrased for so(5) while the decomposition is under O(5).** Located at line 110. The failure would be a representation irreducible under O(5) but of different type or splitting under SO(5). Charitable reading, checked: -I acts trivially on W5, so O(5) acts through SO(5) and the types coincide. Withdrawn, and in any case Passage B is given in the brief and outside L89's own argument.
