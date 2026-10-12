# Verifier v271, Lemma L66: additivity on a circ-orthogonal splitting, the chain to P(W) < M(n), M(n) > 0, Passage B's side claims, Passage C's additions, and the Lean statement

The brief was cold. No numerical work was done, no scripts were written or run, and every value below is exact. Log: [agent_logs/verify-L66-v271.log](../agent_logs/verify-L66-v271.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | Passage A's pointer: the argument is the opening section of support-dichotomy.md | CONFIRMED |
| 2 | Additivity P(W) = sum a_i^3 P(A_i) from A_i∘A_j = 0, using total symmetry of T | CONFIRMED |
| 3a | The maximum M(n) exists (n ≥ 4) and P is odd, so abs P(A_i) ≤ M(n) | CONFIRMED |
| 3b | M(n) > 0, "since any sphere product attains a positive value" | HYPOTHESIS-DEBT |
| 4 | The chain sum a_i^3 P(A_i) ≤ M sum abs(a_i)^3 ≤ M max abs(a_i) < M, and max abs(a_i) < 1 | CONFIRMED |
| 5 | Witness (a,b) = (0.6, −0.8), pieces at ±M: +0.728 against −0.296 | CONFIRMED |
| 6a | Criticality does not derive ∘-orthogonality from ordinary orthogonality (padded CP^2 at n = 8, rotated S^4×S^4) | HYPOTHESIS-DEBT |
| 6b | At k = 2, criticality plus ordinary orthogonality gives exact additivity | HYPOTHESIS-DEBT |
| 7 | (S^4)^3 = S^4×S^8 ⊕ S^4×S^4 and the Λ+/Λ− pair are ∘-orthogonal splittings with full-dimension pieces | HYPOTHESIS-DEBT |
| 8a | Passage C's two-sided form abs P(W) < M(n) | CONFIRMED |
| 8b | "reads 0 < 0 at a splitting whose every piece has P(A_i) = 0" | CONFIRMED AS ALGEBRA |
| 8c | At a decomposable critical point the harmonic-square law gives abs θ < min abs θ_i | HYPOTHESIS-DEBT |
| 8d | Sending one coefficient to 1 sends P(W) to that piece's θ, above min abs θ_i when the pieces differ | CONFIRMED AS ALGEBRA |
| 8e | A ∘-decomposable W can have summands of full dimension n | HYPOTHESIS-DEBT |
| 9 | Lean file states and proves the lemma in abstract form | CONFIRMED |
| 10 | Boundary: k = 2, negative coefficient, P(A_i) ≤ 0, smallest n with W_n ≠ 0 | CONFIRMED |

**Summary.** The argument is correct link by link once M(n) > 0 is granted, and M(n) > 0 is load-bearing (the lemma is false for a form with P ≡ 0) and carries no argument in the passages, so the lemma stands on one named debt: for each n ≥ 4, some unit W in W_n with P(W) ≠ 0.

## 0. Conventions, fixed once

- W_n is the space of algebraic Weyl tensors on R^n, read as symmetric operators on Λ²R^n with the Frobenius inner product ⟨X,Y⟩ = tr(XY). W_n = 0 for n ≤ 3 and W_n ≠ 0 for n ≥ 4.
- Q(W) = W² + W^#, a homogeneous quadratic map. Q(W) need not lie in W_n. Every use below pairs Q or ∘ against an element of W_n, so only its W_n-projection enters.
- X∘Y = ½(Q(X+Y) − Q(X) − Q(Y)) = ½(XY + YX) + X#Y (Passage D, conventions.md line 136). It is bilinear and symmetric, and X∘X = Q(X) because Q(2X) = 4Q(X).
- T is written T(X,Y,Z) = ⟨X∘Y, Z⟩ in Passage D and Passage C and T(X,Y,Z) = ⟨X, Y∘Z⟩ in Passage B. These agree once T is totally symmetric (Section 2). P(X) = T(X,X,X) = ⟨X, Q(X)⟩ in either convention.
- "∘-orthogonal" is read as ⟨Z, A_i∘A_j⟩ = 0 for every Z in W_n. This is implied by vanishing of A_i∘A_j in the ambient space, and it is the only form the argument uses.
- A maximizer is a global maximizer of P on the unit sphere of W_n (brief, Definitions).
- Coefficients a_i are real, nonzero, of either sign. k is finite. The pieces A_i are not required to be distinct or Frobenius-orthogonal, so W need not be a unit vector. The proof never uses the norm of W.

## Hypothesis inventory

| Hypothesis | Source | Used by the argument | Satisfiable |
|---|---|---|---|
| k ≥ 2 | Statement | Yes, for max abs(a_i) < 1 | Yes |
| each A_i unit in W_n | Statement | Yes, for abs P(A_i) ≤ M(n) | Yes for n ≥ 4, empty for n ≤ 3 |
| sum a_i² = 1 | Statement | Yes, in the chain | Yes |
| every a_i ≠ 0 | Statement | Yes, for max abs(a_i) < 1 | Yes |
| A_i∘A_j = 0, i ≠ j | Statement | Yes, for additivity | Asserted for the Λ+/Λ− pair and (S^4)^3 without argument (Section 7). Abstractly satisfiable (Lean witness with T = 0) |
| W a maximizer, so P(W) = M(n) | Statement | Yes, contradicted by P(W) < M(n) | Yes for n ≥ 4 (compactness) |
| T totally symmetric | Imported, conventions.md line 24, second-order.md line 63 | Yes, once, to kill ⟨A_l, Q(A_i)⟩, l ≠ i | Argued on file, checked in Section 2 |
| P odd | Stated in Passage B | Yes, for the lower bound P(A_i) ≥ −M(n) | Immediate from Q quadratic |
| the maximum M(n) exists | Implicit | Yes | Yes for n ≥ 4: P is a polynomial on a nonempty compact sphere |
| M(n) > 0 | Asserted in Passage B from sphere products | Yes, for the final strict inequality | No argument on file (Section 3) |
| n ≥ 4 | **Used but unstated** | The proof's opening line defines M(n) as a maximum over a set that is empty for n ≤ 3 | The statement is vacuously true for n ≤ 3 (no unit elements, hence no maximizer and no decomposable W), so this is a scope note on the proof only |

No criticality, padding, monotonicity of M or harmonic-square law is used, as Passage B says.

## 1. The pointer in Passage A

Passage A (support-dichotomy.md lines 33-37) says "the argument is the opening section of this file, above every heading". Lines 1-17 of the same file begin with the heading "# Every maximiser is ∘-indecomposable, one line" and hold a definition identical to Passage A's clause for clause (k ≥ 2, unit pieces, sum a_i² = 1, all a_i ≠ 0, A_i∘A_j = 0), a theorem identical to Passage A's conclusion, and a proof. The literal "above every heading" is off by one, since the section sits under the file's title heading. The charitable reading, the section before the first subordinate heading, is plainly meant, and the content is where the pointer says.

**CONFIRMED.** Every quotation in the brief was checked against its cited lines (support-dichotomy.md 1-17 and 33-37, results.md 334 and 1096, conventions.md 24 and 136, second-order.md 63, nondegeneracy.md 356-359) and matches verbatim.

## 2. Additivity

**Derivation.** Let W = sum_i a_i A_i. By bilinearity and symmetry of ∘,

Q(W) = W∘W = sum_i a_i² Q(A_i) + 2 sum_{i<j} a_i a_j A_i∘A_j = sum_i a_i² Q(A_i),

since every A_i∘A_j with i ≠ j vanishes. Then P(W) = ⟨W, Q(W)⟩ = sum_l sum_i a_l a_i² ⟨A_l, Q(A_i)⟩. The diagonal l = i gives sum_i a_i³ P(A_i). An off-diagonal term is ⟨A_l, A_i∘A_i⟩ = T(A_l, A_i, A_i) in Passage B's convention, and it is not of the form ⟨·, A_i∘A_l⟩ until a slot is moved: by symmetry of T in its first two slots, T(A_l, A_i, A_i) = T(A_i, A_l, A_i) = ⟨A_i, A_l∘A_i⟩ = 0. So every cross term dies and P(W) = sum_i a_i³ P(A_i). Passage B describes exactly this step, including that it is the one place total symmetry is consumed.

Equivalently, in the triple expansion P(W) = sum_{i,j,l} a_i a_j a_l T(A_i,A_j,A_l), any index triple that is not constant contains two distinct indices, total symmetry moves them into the ∘ slots, and the term is zero.

**The symmetry it uses.** Passage B gives two reasons: symmetry in the last two slots "free from the polarisation" (correct, ∘ is symmetric), and symmetry in the first "because ∇P = 3Q, recorded at second-order.md". The implication is valid in this direction. Writing S for the symmetric trilinear form with P(X) = S(X,X,X), ∇P = 3Q means S(X,X,Z) = ⟨Q(X), Z⟩ = T(Z,X,X) for all X, Z in W_n, and polarising in X gives T(Z,X,Y) = S(X,Y,Z), which is totally symmetric.

The support for ∇P = 3Q at the cited line is "P is a cubic form, so ∇P = 3Q(W)" (second-order.md line 63). Cubicness alone gives only Euler's ⟨∇P(W), W⟩ = 3P(W). The same line, however, states the full symmetry of T with an independent argument, repeated at conventions.md line 24, and I checked it:

- The W² part: X∘Y contributes ½(XY + YX), so ⟨½(XY+YX), Z⟩ = ½(tr XYZ + tr YXZ). Cyclic invariance makes tr XYZ invariant under the three cyclic permutations and tr YXZ the image of tr XYZ under the three transpositions, so the sum is invariant under all of S_3.
- The # part: (X#Y)_{αβ} = ½ c_{αγδ} c_{βεζ} X_{γε} Y_{δζ} with c the structure constants of so(n) in an orthonormal basis, totally antisymmetric because the inner product is ad-invariant. In ⟨X#Y, Z⟩ = ½ c_{αγδ} c_{βεζ} X_{γε} Y_{δζ} Z_{αβ} the first c carries one index of each of Z, X, Y and the second c carries the other. A permutation of (X, Y, Z) permutes the slots of both c's by the same permutation, and after relabelling dummy indices the sign is (±1)² = +1.

So total symmetry holds on all symmetric operators on Λ²R^n, hence on W_n, and ∇P = 3 π_{W_n} Q follows from it. **CONFIRMED.**

### 2.1 Withdrawn candidates

- **Candidate: Passage B's justification of first-slot symmetry is circular.** (1) Passage B: "symmetry in the first holds because ∇P = 3Q, recorded at second-order.md", and second-order.md line 63: "P is a cubic form, so ∇P = 3Q(W)". (2) Cubicness does not give ∇P = 3Q for a general quadratic Q: on R² with Q(x,y) = (0, x²), P(x,y) = x²y has ∇P = (2xy, x²) ≠ (0, 3x²) = 3Q. (3) Charitable reading: the cited line itself carries the direct symmetry argument (tr XYZ and the two c's at sign (−1)²), which is equivalent to ∇P = 3Q, so the fact is on file with an argument at the cited location. **Withdrawn at step 3.**
- **Candidate: Passage C's additivity sentence omits the symmetry.** (1) results.md line 1096: "every cross term T(A_i,A_j,·) = ⟨A_i∘A_j,·⟩ vanishes, so P(W) = sum_i a_i³ P(A_i)". (2) The term a_i² a_l T(A_i,A_i,A_l), l ≠ i, is not of the form T(A_i,A_j,·) with i ≠ j. (3) Charitable reading: T is tabled as fully symmetric (conventions.md line 24), so "cross term" is read up to permutation of slots, and T(A_i,A_i,A_l) = T(A_i,A_l,A_i) is of that form. **Withdrawn at step 3.** Passage B's account is the complete one.
- **Candidate: slot conventions for T disagree between Passage B and Passages C, D.** (1) Passage B: T(X,Y,Z) = ⟨X, Y∘Z⟩. Passage D: T(X,Y,Z) = ⟨X∘Y, Z⟩. (2) The two forms differ by a cyclic relabelling of slots. (3) Under the total symmetry confirmed above they are the same form. **Withdrawn at step 3.**

## 3. abs P(A_i) ≤ M(n) and M(n) > 0

**Existence.** For n ≥ 4, the unit sphere of W_n is nonempty and compact and P is a polynomial, so the maximum M(n) is attained. For n ≤ 3, W_n = 0, the sphere is empty and M(n) is undefined, but so is every object the statement quantifies over (Hypothesis inventory, last row). **CONFIRMED (3a).**

**Oddness.** P(−X) = ⟨−X, Q(−X)⟩ = −⟨X, Q(X)⟩ = −P(X), since Q(−X) = Q(X). For unit A, −A is unit, so −P(A) = P(−A) ≤ M(n), and abs P(A) ≤ M(n). **CONFIRMED (3a).**

**Positivity.** The passages give "M(n) > 0, since any sphere product attains a positive value" and nothing more.

- Oddness reduces M(n) > 0 to P not vanishing identically on W_n: if P(A) ≠ 0 then one of P(A), P(−A) is positive. So the debt is exactly: **for each n ≥ 4, exhibit a unit W in W_n with P(W) ≠ 0.** The passages carry neither this nor the sphere-product value it is derived from.
- The hypothesis is load-bearing, as Passage B itself says. If P ≡ 0 on the sphere then every unit point is a maximizer with P = M = 0, and a ∘-decomposable unit point would falsify the lemma. The Lean file's non-vacuity example (T = 0 on R², coefficients (3/5, 4/5)) is exactly such an object in the abstract setting, where the conclusion fails at M = 0.

**HYPOTHESIS-DEBT (3b).**

### 3.1 Withdrawn candidate

- **Candidate: "any sphere product attains a positive value" is false as a universal.** (1) Passage B line 7 (support-dichotomy.md): "since any sphere product attains a positive value". (2) S^1×S^{n−1} is locally conformally flat, its Weyl tensor is 0, so it has no unit Weyl tensor and P = 0 on it. (3) Charitable reading: the sentence needs only one witness per n, and the record's sphere products in these passages (S^4×S^4, S^3×S^3, S^4×S^8) all have both factors of dimension at least 2, where the Weyl tensor is nonzero. **Withdrawn at step 3.** The positivity itself remains the debt above.

## 4. The chain

For each i, a_i³ P(A_i) ≤ abs(a_i³ P(A_i)) = abs(a_i)³ abs P(A_i) ≤ abs(a_i)³ M(n), using Section 3a. Summing, P(W) ≤ M(n) sum abs(a_i)³. Next, sum abs(a_i)³ = sum abs(a_i) a_i² ≤ max abs(a_i) · sum a_i² = max abs(a_i), and multiplying by M(n) ≥ 0 preserves it. Finally, for any i pick j ≠ i (k ≥ 2), then a_i² ≤ 1 − a_j² < 1 because a_j ≠ 0, so max abs(a_i) < 1, and M(n) max abs(a_i) < M(n) needs M(n) > 0 strictly.

Each link is valid. Strictness is used exactly once, at the last step, and it consumes M(n) > 0 (Section 3b). Since a maximizer has P(W) = M(n), no maximizer is ∘-decomposable. The result concerns global maximizers, and the proof says nothing about local ones, which matches the definition in the brief. **CONFIRMED.**

## 5. The witness at (0.6, −0.8)

Take P(A_1) = M, P(A_2) = −M with a = 3/5, b = −4/5 (sum of squares 9/25 + 16/25 = 1). Then P(W) = (27/125)M + (−64/125)(−M) = (91/125)M = 0.728 M, and the chain with a_i³ in place of abs(a_i)³ would give M(27/125 − 64/125) = −(37/125)M = −0.296 M. Since 91/125 > −37/125 the altered first step fails. Passage B's decimals are these rationals at M = 1. Pieces at ±M exist whenever M is attained (A and −A), and the sentence is a claim about the inequality chain, so ∘-orthogonal realisability of the pair is not needed. **CONFIRMED.**

### 5.1 Withdrawn candidate

- **Candidate: "the chain fails at any negative coefficient" over-reaches.** (1) support-dichotomy.md line 11: "with a_i³ in place of abs(a_i)³ the chain fails at any negative coefficient". (2) If every piece has P(A_i) = M, the altered bound gives P(W) = M sum a_i³ exactly, with equality, whatever the signs, so the altered chain does not fail there. (3) Charitable reading: the termwise step a_i³ P(A_i) ≤ a_i³ M is invalid as an inequality for a_i < 0 (it needs P(A_i) ≥ M), so the chain fails as an argument whenever a coefficient is negative, which is what the sentence is for. **Withdrawn at step 3.**

## 6. Passage B lines 13-15, criticality

**6a.** "Criticality does not derive ∘-orthogonality from ordinary orthogonality", with witnesses ∥A∘B∥ = 0.664362 for two critical Frobenius-orthogonal copies of padded W_{CP^2} at n = 8, and 0.272738 for a rotated S^4×S^4 pair. Both witnesses are decimals with no closed form or derivation in the passages, so the claim is supported only by a run. What would have to be proved: a closed-form pair of critical, Frobenius-orthogonal unit Weyl tensors with A∘B ≠ 0. **HYPOTHESIS-DEBT.** The lemma does not use it.

**6b.** "At k = 2, criticality plus ordinary orthogonality already gives exact additivity." No argument is on file in the passages. What would have to be proved: for critical unit A, B with ⟨A,B⟩ = 0, the two cross terms 3a²b T(A,A,B) and 3ab² T(A,B,B) vanish, which through total symmetry reduces to ⟨Q(A), B⟩ = 0 and ⟨A, Q(B)⟩ = 0. I looked for a falsifier in the named families (Λ+/Λ− pair, coordinate-disjoint sphere products, padded pieces) and found none, since each of those pairs is already ∘-orthogonal or coordinate-disjoint. **HYPOTHESIS-DEBT.** The lemma does not use it.

### 6.1 Withdrawn candidate

- **Candidate: "strictly weaker than the hypothesis used here" is an unsupported comparison.** (1) support-dichotomy.md line 15: "What is true, and strictly weaker than the hypothesis used here: at k = 2, criticality plus ordinary orthogonality already gives exact additivity." (2) Criticality plus orthogonality and ∘-orthogonality are not shown to be comparable in either direction: 6a asserts (numerically) that the first does not imply the second, and nothing shows that ∘-orthogonality implies criticality or Frobenius orthogonality. (3) Charitable reading: "weaker" refers to the reach of the fact (k = 2 only, against every k under ∘-orthogonality), which is a true comparison of conclusions. No closed-form object exhibits a failure. **Withdrawn at step 2 and step 3.**

## 7. Passage B line 17, the support examples

- **Λ+/Λ− pair.** Claimed ∘-orthogonal with n_i = n = 4. Passage E asserts the same ("which a Λ+/Λ− pair on the same four coordinates also satisfies"). Neither passage gives an argument. What would have to be proved: for A with image in Λ+ and B with image in Λ−, ½(AB + BA) = 0 and A#B = 0 (the latter from so(4) = so(3) ⊕ so(3) as a sum of ideals, so that c vanishes on mixed index triples).
- **(S^4)^3 = S^4×S^8 ⊕ S^4×S^4.** Claimed as a ∘-orthogonal splitting with a support-12 piece at n = 12. No argument is in the passages. What would have to be proved: the linear identity expressing W_{(S^4)^3} as a combination of W_{S^4×S^8} and padded W_{S^4×S^4} with the stated normalisations, and the vanishing of their ∘ product, including the component on Λ²(R^8) where W_{S^4×S^8} acts as a multiple of the identity and the ½(AB + BA) and # parts must cancel.

Neither example is used by the lemma. They support only the remark that a ∘-splitting need not lower dimension. **HYPOTHESIS-DEBT.**

## 8. Passage C's additions

**8a, abs P(W) < M(n).** abs P(W) = abs(sum a_i³ P(A_i)) ≤ sum abs(a_i)³ abs P(A_i) ≤ M(n) max abs(a_i) < M(n), by Sections 3a and 4. It is two-sided and implies Passage B's P(W) < M(n). It depends on the same M(n) > 0. **CONFIRMED.**

**8b, "reads 0 < 0".** If every piece has P(A_i) = 0, then m = max_i abs P(A_i) = 0 and the chain run against m ends in m · max abs(a_i) < m, which is 0 < 0, false. Against M(n) > 0 the chain survives, giving P(W) = 0 < M(n). The sentence asserts no existence of such a splitting. **CONFIRMED AS ALGEBRA.**

**8c, the harmonic-square clause.** From 1/θ² = sum_i 1/θ_i² with k ≥ 2 and every term positive, 1/θ² > 1/θ_i² for each i, so abs θ < min_i abs θ_i: that algebra is correct. The import is not. Passage E (nondegeneracy.md lines 356-359) derives the law for block sums over disjoint coordinate blocks, then asserts "the real condition is W_A∘W_B = 0" and "criticality forces θ = aθ_A = bθ_B" with no argument in the cited lines, and writes the sum over i after a two-piece derivation. Passage C applies it at a general decomposable critical point with any k. What would have to be proved: at a critical unit W = sum a_i A_i with A_i∘A_j = 0 (i ≠ j), θ ≠ 0, one has a_i θ_i = θ for each i with θ_i the pieces' values, for every k, together with whatever relation between the Frobenius products ⟨A_i, A_j⟩ the step needs (Passage E's coordinate-disjoint case supplies ⟨A_i, A_j⟩ = 0 for free, ∘-orthogonality is not shown to). **HYPOTHESIS-DEBT.** The lemma does not use it, and Passage C labels it as outside the lemma.

**8d, one coefficient to 1.** Without criticality, P(W) = sum a_i³ P(A_i), and letting a_1 → 1 with the other coefficients nonzero and tending to 0 gives P(W) → P(A_1). If the pieces' values differ in absolute value and A_1 is chosen with abs P(A_1) = max_i abs P(A_i), then abs P(W) exceeds min_i abs P(A_i) for a_1 near 1, so the bound of 8c cannot hold without criticality. The sentence is conditional ("whenever the pieces differ") and makes no existence claim. **CONFIRMED AS ALGEBRA**, with the reading in 8.1.

**8e, full-dimension summands.** "A ∘-decomposable W can have summands of full dimension n" is an existence claim whose only witnesses are those of Section 7, both unargued. "So it supports no induction on n" is a correct remark on the lemma's form: its conclusion says nothing about the pieces' supports. **HYPOTHESIS-DEBT** for the existence claim.

### 8.1 Withdrawn candidate

- **Candidate: 8d holds only for a well-chosen coefficient.** (1) results.md line 334: "sending one coefficient to 1 sends P(W) to that piece's own θ, above min_i abs θ_i whenever the pieces differ". (2) Sending to 1 the coefficient of the piece attaining min_i abs θ_i gives the limit abs θ_min, which equals the minimum and is not above it. Also two pieces can differ as tensors with equal abs θ_i, and then no choice gives "above". (3) Charitable reading: "one coefficient" means a suitably chosen one and "differ" means differ in abs θ_i, which is all the sentence needs to show the bound fails without criticality. **Withdrawn at step 3.**
- **Candidate: the harmonic-square law under ∘-orthogonality alone is false without Frobenius orthogonality.** (1) nondegeneracy.md line 356: "the real condition is W_A∘W_B = 0". (2) I could not exhibit a closed-form object in W_n that is ∘-orthogonal, Frobenius-non-orthogonal and critical, and the abstract T = 0 example has θ = 0 where the law is meaningless. (3) The law may hold under the stated condition. **Withdrawn at step 2**, recorded instead as the debt in 8c.

## 9. The Lean file

[lean/HamiltonsCubic/Results/L66Statement.lean](../lean/HamiltonsCubic/Results/L66Statement.lean) was read in full. The file contains no sorry, admit, axiom or native_decide. It was not built, since this round runs no computations.

- **What it proves.** Over an arbitrary real normed space E with a trilinear form T and P X = T X X X: if T X Y Z = T Y X Z (hsym12), M > 0, and P B ≤ M on the unit sphere, then every ∘-decomposable W has P W < M (Pf_lt_max), and a unit W with P W = M is not ∘-decomposable (no_maximizer_is_circDecomposable).
- **Symmetry assumed.** Only the transposition of the first two slots. This is less than total symmetry, and it suffices because ∘-orthogonality is encoded in slots 2 and 3 for every first argument: T X (A i) (A j) = 0. The proof kills T(A_i, A_j, A_l), j ≠ l, directly (hinner), and T(A_i, A_j, A_j), j ≠ i, by hsym12 then the orthogonality at X = A_j (hmid), which is Passage B's step. Under Passage B's T(X,Y,Z) = ⟨X, Y∘Z⟩ the hypotheses are the record's: slot-(2,3) vanishing is A_i∘A_j = 0 paired against W_n, and slot-(1,2) symmetry is the symmetry argued in Section 2. The module docstring's "totally symmetric" is stronger than what the theorem assumes, which makes the theorem more general.
- **abs P(A_i) ≤ M.** Derived, from hM at A_i and at −A_i with oddness from trilinearity, which is Passage B's route.
- **The definition.** IsCircDecomposable carries all five clauses (k ≥ 2, unit pieces, sum a_i² = 1, all a_i ≠ 0, pairwise orthogonality) and W = sum a_i • A_i.
- **Maximizer.** M is an upper bound attained at the unit W, so W is a global maximizer and M is the maximum, as in the record.
- **Not typed, stated as such.** Total symmetry of the record's T on W_n, that P is its diagonal, M(n) > 0 (a hypothesis), and n ≥ 4 (implicit in M being attained). The Lean statement therefore proves the lemma's logic and carries debt 3b as an explicit hypothesis.
- **The witness.** The rationals 91/125 and −37/125 match Section 5.

**CONFIRMED.**

## 10. The boundary

- **k = 2.** max abs(a_i) < 1 holds (Section 4). At a = b = 1/√2, sum abs(a_i)³ = 1/√2 < 1. No finding.
- **A negative coefficient.** Handled by the absolute values, termwise (Section 4), and Section 5 shows why they are needed. No finding.
- **A piece with P(A_i) ≤ 0.** a_i³ P(A_i) ≤ abs(a_i)³ abs P(A_i) ≤ abs(a_i)³ M(n) still holds. If every piece has P(A_i) ≤ 0 with positive coefficients, P(W) ≤ 0 < M(n), again needing M(n) > 0. No finding beyond 3b.
- **Repeated or non-orthogonal pieces.** Allowed by the definition. A_1 = A_2 forces Q(A_1) = 0, and W = (a_1 + a_2)A_1 is non-unit or zero. The proof never uses the norm of W, so nothing breaks. No finding.
- **Smallest n.** W_n = 0 for n ≤ 3 (vacuous statement, undefined M(n), scope note in the inventory). n = 4 is the smallest dimension with W_n ≠ 0, and there M(4) > 0 falls under debt 3b. The only sphere product at n = 4 with both factors of dimension at least 2 is S^2×S^2, and its value of P is not on file in the passages.
- **Kernel of W nonzero (padded object).** The argument never refers to supports or kernels, and a padded piece is an element of W_n like any other. No finding.

## 11. Universal claims against the named families, and falsifiers

| Claim | Falsifying object | What I did |
|---|---|---|
| Lemma (no maximizer decomposable) | A form with P ≡ 0 on W_n admitting a ∘-orthogonal unit pair | The proof is valid given M(n) > 0, so a falsifier must be P ≡ 0. Tried diagonal, padded, sphere-product, CP^2 and Λ+/Λ− as maximizers: each is covered by the proof once M(n) > 0 |
| Additivity | A totally symmetric T with non-additive P on a ∘-orthogonal splitting | None exists: every cross term is shown zero in Section 2 |
| "Any sphere product attains a positive value" | S^1×S^{n−1} (W = 0) | Withdrawn under the p, q ≥ 2 reading (3.1). Positivity for p, q ≥ 2 is debt |
| abs P(A_i) ≤ M(n) | None possible, by oddness | Checked in Section 3a |
| Chain fails at any negative coefficient | All pieces at +M | Withdrawn (5.1) |
| Criticality does not derive ∘-orthogonality | A proof that critical plus orthogonal implies ∘-orthogonal | No closed-form pair on file either way. Debt (6a) |
| k = 2 critical plus orthogonal gives additivity | A critical orthogonal pair with ⟨Q(A), B⟩ ≠ 0 | Tried Λ+/Λ−, coordinate-disjoint sphere products, padded pieces: all already ∘-orthogonal. Debt (6b) |
| Λ+/Λ− and (S^4)^3 are ∘-orthogonal splittings | A nonzero component of A∘B | No argument on file to check. Debt (7) |
| abs θ < min abs θ_i at a decomposable critical point | A critical ∘-orthogonal W with Frobenius-non-orthogonal pieces violating the law | None exhibited (8.1). Debt (8c) |
| Summands of full dimension exist | Proof that ∘-orthogonality forces smaller supports | Rests on Section 7. Debt (8e) |

## Overall verdict

**HYPOTHESIS-DEBT.** Every link of the proof checks: the pointer, additivity with the total symmetry argued on file, existence of M(n) and oddness, the chain, and the absolute-value witness, and the Lean file proves the same implication with M > 0 as an explicit hypothesis. The one load-bearing fact without an argument in the passages is M(n) > 0, which by oddness is: for each n ≥ 4, some unit W in W_n with P(W) ≠ 0. The proof should also state n ≥ 4 (the statement is vacuous below). Passage B's side claims (6a, 6b, 7) and Passage C's harmonic-square clause and full-dimension remark (8c, 8e) are unargued and unused by the lemma.
