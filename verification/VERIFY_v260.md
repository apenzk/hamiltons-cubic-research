# Verifier v260, Lemma L59: the apolarity adjunction, ANN, the rank and image displays, injectivity of Cat, the split 65 = 36 + 29, and L59Statement.lean

Cold brief ([BRIEF_L59.md](BRIEF_L59.md)). No numerical work: no scripts were written and no computation was run, and every value below is exact and derived by hand from the quoted table. Log: agent_logs/verify-L59-v260.log.

| # | Claim | Verdict |
|---|---|---|
| 1 | The adjunction ⟨F, μ(B)⟩ = ⟨Cat_F, B⟩ (pairings, domain of μ, what Cat_F is) | HYPOTHESIS-DEBT |
| 2 | ANN, defined as invariant F with Cat_F(K,K) = 0, is the kernel of the adjoint of μ_K | HYPOTHESIS-DEBT |
| 3 | rank(μ_K) = 14 − dim ANN | CONFIRMED AS ALGEBRA (with ANN read as ker μ_K*) |
| 4 | F_5 ∈ image(μ_K) iff F_5 ⊥ ANN | CONFIRMED AS ALGEBRA (with ANN read as ker μ_K*, F_5 invariant) |
| 5a | The adjoint of a surjection is injective | CONFIRMED AS ALGEBRA |
| 5b | The unrestricted μ is surjective, and Cat places the 14 inside the 65 | HYPOTHESIS-DEBT |
| 6 | 29 invariant forms vanish on K × K, block by block, and 65 = 36 + 29 | CONFIRMED (from L83's table and Passage E's parity and rank-one givens) |
| 7 | "The count is the necessary condition" for the certificate | HYPOTHESIS-DEBT |
| 8 | Passage G, the Lean file, against Passages A to C | CONFIRMED AS ALGEBRA (faithful to the displays under ANN := ker of the adjoint, and declares the debts of rows 1, 2 and 6 untyped) |

**Summary:** the linear algebra of both displays and of the injectivity inference is correct and is what the Lean file proves, but the record never names the pairings, the domain of μ or Cat_F, and never argues the step from "Cat_F vanishes on every invariant form supported on K" to "Cat_F(K,K) = 0", so ANN as the lemma defines it is joined to the displays only by an absent argument.

## 0. Conventions, fixed once

- Quotation check: Passage A matches [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 281 and 299-303, Passage B matches [results.md](../results.md) line 216, Passage C matches results.md lines 739 and 741, all character for character. Passages D and E match sym3-blocks.md lines 5-13 and 108-122 except that two relative links were rewritten for the brief's directory (conventions.md became ../findings/conventions.md, sym3-blocks.md became ../findings/sym3-blocks.md). Passage F's five headings match. Passage G is byte-identical to [L59Statement.lean](../lean/HamiltonsCubic/Results/L59Statement.lean) (wc counts 178 newline characters, the brief says 179 lines, which is the final unterminated line).
- M denotes the space of cubics, Sym^3 of the 35-dimensional module, of dimension 7770 per L83's heading. G = O(5). For a block λ of multiplicity m_λ, M_λ is the multiplicity space (dimension m_λ) and the isotypic component is M_λ ⊗ V_λ.
- K_λ ⊆ M_λ is the multiplicity-space trace of K. Passage E gives codim K_λ = 1 when λ_2 is even (L86 for "at most 1", L87 for "exactly 1") and K_λ = M_λ when λ_2 is odd. These are givens, and their standing is outside this round.
- V is the 14-dimensional space of invariant sextics (L85, a given). S = Sym^2(M)^G is the 65-dimensional space of invariant symmetric forms (L88, a given). S_K is "the invariants supported on K", read as Sym^2(K)^G, the only reading under which it has the 36 dimensions Passage E counts.
- μ_K* denotes the adjoint of μ_K : S_K → V under whatever pairings make the adjunction hold. "ANN (record)" denotes {F ∈ V : Cat_F(K,K) = 0}. "ANN (adjoint)" denotes ker μ_K*.
- The quoted record uses a triple hyphen as a dash inside Passage A. Quotations below elide it with an ellipsis and change nothing else.

## 1. Hypothesis inventory

| Object or hypothesis | Where defined in the quoted record | Used by | Status |
|---|---|---|---|
| K, "the span cut out by the orbit constraint" | Passage E: the condition σ_λ(W_0) = 0, with the per-block ranks | Displays (through μ_K), the 29, the 36 | Given. Supplied as K_λ per block. |
| W_0, the padded W_CP2, and its O(5)-orbit | Passage E, by name only | Definition of K | Given, outside scope |
| F_5 | Nowhere in Passages A to F. The formula (3/2)‖W‖^6 − 9 tr(W^3)^2 appears only in the Lean docstring. Passage E says F_5 vanishes on the orbit. | Display 2 | **Used but unstated:** display 2 needs F_5 ∈ V, i.e. F_5 invariant. No quoted passage states it. |
| μ, a map from forms on Sym^3 to sextics | Nowhere. Its domain (all of Sym^2(M), or the 65 invariant ones) is never stated. | All three sentences | **Undefined** (row 1) |
| B, a symmetric form on Sym^3 | Nowhere in Passage A. The letter also denotes the normalised form −½ tr(XY) on so(5) in Passage D. | Adjunction | **Undefined**, with a symbol collision (charitably, context separates them) |
| The pairing ⟨·,·⟩ on sextics | Nowhere. "Apolarity" names a family of pairings without fixing one. | Adjunction, "F_5 ⊥ ANN" | **Undefined** (row 1) |
| The pairing ⟨·,·⟩ between Cat_F and B | Nowhere | Adjunction | **Undefined** (row 1) |
| Cat_F, "the catalecticant" | Nowhere as a formula. It is used both as a bilinear form evaluated on K × K and as an element paired with B. | ANN, injectivity | **Undefined** (row 1) |
| S_K, "the invariants supported on K" | Passage A, by name only. Its dimension 36 is Passage E's. | Domain of μ_K | Read as Sym^2(K)^G (convention above). The record never says "Sym^2(K)". |
| dim V = 14 | L85, a given | Display 1 | Given |
| dim S = 65, as 20 + 6 + 27 + 12 | L83's table and L88, givens | The split | Given |
| O(5)-invariance of the pairings, equivariance of μ, compactness of O(5) (averaging) | Nowhere | Needed for row 2's step and for Cat(V) ⊆ S in row 5b | **Used but unstated** |
| μ surjective | Asserted in Passage A with no argument | Row 5 | **Asserted, no argument on file** |
| "The sum-of-squares certificate at n = 5" | Passage C, by name only | Row 7 | **Undefined** in the quoted record |

## 2. Quantifier order and the reading of μ, sentence by sentence

- Sentence "Apolarity gives ⟨F, μ(B)⟩ = ⟨Cat_F, B⟩": μ is unrestricted in the sense of "not yet restricted to K". The quantifiers over F and B are implicit. For Cat_F(K,K) to have a meaning later, B must range over a space containing every p ⊙ q with p, q ∈ K, which the 65 invariant forms do not (p ⊙ q is generally not invariant). So this sentence needs μ on all of Sym^2(M). Nothing in the record says so.
- The display: μ means μ_K, restricted to S_K, both domain and invariance restricted.
- "Cat is injective on the invariant sextics ... the unrestricted μ is surjective": "placing a copy of the 14 inside the 65" makes Cat a map V → S, so the μ whose adjoint it is has domain S (65-dimensional) and target V. That is μ restricted to invariants but not to K. Under the reading of the first sentence (domain all of Sym^2(M)) the adjoint lands in Sym^2(M)* and lands in S only through equivariance, which is unstated.
- So "μ" names at least two maps in Passage A (on Sym^2(M) and on S), plus μ_K. "Unrestricted" is correct only relative to K. The ambiguity does not change the truth of any display, because every display is about μ_K. It does change what Cat_F(K,K) means (row 1).
- Quantifier order in ANN: "invariant sextics F with Cat_F(K,K) = 0" is ∀ p, q ∈ K, Cat_F(p, q) = 0, a condition on all pairs, invariant or not. The adjoint's kernel is ∀ B ∈ S_K, ⟨Cat_F, B⟩ = 0, a condition on invariant B only. The two quantify over different sets, which is row 2.

## 3. Claim 1, the adjunction

**Record:** "Apolarity gives $\langle F,\mu(B)\rangle=\langle\mathrm{Cat}_F,B\rangle$".

**What it must be for Passage A to make sense.** μ(B) must be the sextic obtained by evaluating the form B on cubics, so that B = Σ b_ij q_i ⊙ q_j gives μ(B) = Σ b_ij q_i q_j. Cat_F must be the bilinear form on cubics Cat_F(p, q) = ⟨F, pq⟩. The pairing between Cat_F and B must be the natural contraction of a bilinear form on M against an element of Sym^2(M). Under those three definitions the identity is linearity: ⟨F, Σ b_ij q_i q_j⟩ = Σ b_ij ⟨F, q_i q_j⟩ = Σ b_ij Cat_F(q_i, q_j). So it is the definition of Cat_F as the transpose of μ, and "apolarity gives" presents a definition as a derivation.

**What the record supplies.** None of the three definitions, and no named pairing on sextics. The word "catalecticant" (Passage C) fixes Cat_F(p, q) = ⟨F, pq⟩ only once ⟨·,·⟩ on sextics is fixed.

**Discrepancy record.**
1. Locate: the sentence above, and Passage C's "Apolarity, ⟨F,μ(B)⟩=⟨Cat_F,B⟩, gives ...". Neither passage nor Passages D to F defines μ, B, Cat_F or either pairing.
2. Exhibit: Cat_F(K,K) is meaningful only if Cat_F is a form on all of M × M, which requires the adjunction to hold for B ranging over Sym^2(M). If B ranges only over S (65 dimensions), the adjunction determines Cat_F only as a functional on S, and Cat_F(p, q) for p, q ∈ K is not determined. The two readings of μ's domain give different objects, and the record fixes neither.
3. Charitable reading: "apolarity" and "catalecticant" are standard, and the intended objects are the apolar pairing, μ on all of Sym^2(M), and the catalecticant. Even so, the specific pairing (apolar, Bombieri, or the one induced from a chosen inner product on the 35-dimensional module) is not named. The displays are insensitive to the choice provided one nondegenerate O(5)-invariant pairing is used consistently, but that proviso is itself unstated.

**Verdict: HYPOTHESIS-DEBT.** To be supplied: the domain of μ (all of Sym^2(M)), the formula μ(B), a named nondegenerate O(5)-invariant pairing on sextics, the definition Cat_F(p, q) = ⟨F, pq⟩, and the statement that the adjunction is then the definition of Cat as the transpose of μ.

## 4. Claim 2, ANN is the kernel of the adjoint of μ_K

**Derivation, one direction.** μ_K* sends F to the functional B ↦ ⟨F, μ(B)⟩ = ⟨Cat_F, B⟩ on S_K. If Cat_F(K,K) = 0 then every B ∈ Sym^2(K) pairs to zero with Cat_F, in particular every B ∈ S_K. So ANN (record) ⊆ ANN (adjoint). This direction uses only the adjunction under row 1's reading.

**The other direction.** ANN (adjoint) ⊆ ANN (record) says: if ⟨Cat_F, B⟩ = 0 for every invariant B ∈ Sym^2(K), then ⟨Cat_F, B⟩ = 0 for every B ∈ Sym^2(K). No argument for this is on file in any quoted passage. The Lean docstring (Passage G) calls it "the step the audit calls genuinely absent" and places it outside the typed scope.

**What the step needs.** Two inputs, both absent: (a) Cat_F restricted to K × K is an O(5)-invariant form whenever F is invariant, which needs μ equivariant and the pairing on sextics O(5)-invariant, and K an O(5)-submodule (Passage E makes K one); (b) an invariant linear functional on Sym^2(K) that vanishes on the invariants Sym^2(K)^G vanishes identically, which holds for a compact group by averaging, or blockwise by the isotypic pairing of Schur's lemma.

**Discrepancy record.**
1. Locate: Passage A defines "ANN be the invariant sextics F with Cat_F(K,K)=0" and then uses μ_K, whose domain is "the invariants supported on K". The join between the two is the word "so" in "Apolarity gives ..., so, for μ_K the restriction ...".
2. Exhibit: the step fails as soon as input (a) is dropped. Closed form, a two-dimensional model with the group O(2) acting on K = ℝ^2: Sym^2(K)^{O(2)} is spanned by I = e_1 ⊙ e_1 + e_2 ⊙ e_2. The form C = e_1* ⊗ e_1* − e_2* ⊗ e_2* satisfies ⟨C, I⟩ = 1 − 1 = 0, so C annihilates every invariant form supported on K, yet C(e_1, e_1) = 1 ≠ 0, so C(K,K) ≠ 0. C is not O(2)-invariant, which is exactly input (a). The record states nothing that makes Cat_F invariant, so the record does not exclude this shape.
3. Charitable reading: for the intended objects (O(5)-invariant apolar pairing, equivariant μ) Cat_F is invariant for invariant F, and O(5) is compact, so the step holds and ANN (record) = ANN (adjoint). This reading requires supplying (a) and (b), which is the debt, not a withdrawal. The candidate survives as a missing argument, not as a counterexample to the intended lemma.

**Verdict: HYPOTHESIS-DEBT.** To be supplied: invariance of Cat_F for invariant F (equivariant μ, invariant pairing), and the averaging or isotypic argument that an invariant form on K × K orthogonal to Sym^2(K)^G is zero.

## 5. Claims 3 and 4, the two displays

Let μ_K : S_K → V be linear, with V carrying a nondegenerate symmetric pairing, S_K carrying one, and μ_K* : V → S_K the adjoint, ⟨F, μ_K(b)⟩ = ⟨μ_K* F, b⟩.

**ker μ_K* = image(μ_K)^⊥.** If μ_K* F = 0 then ⟨F, μ_K b⟩ = 0 for all b. Conversely if F ⊥ image(μ_K) then ⟨μ_K* F, b⟩ = 0 for all b, so μ_K* F = 0 by nondegeneracy on S_K.

**Display 1.** dim image(μ_K)^⊥ = 14 − rank(μ_K) by nondegeneracy on V (dim V = 14, a given). So rank(μ_K) = 14 − dim ker μ_K*.

**Display 2.** In finite dimension with a nondegenerate pairing, (U^⊥)^⊥ = U. So image(μ_K) = (ker μ_K*)^⊥, i.e. F_5 ∈ image(μ_K) iff F_5 ⊥ ker μ_K*. This needs F_5 ∈ V, the unstated hypothesis of section 1.

**Scale.** Both conclusions are unchanged when either pairing is rescaled or replaced by any other nondegenerate pairing that satisfies the same adjunction with the correspondingly redefined adjoint, because image(μ_K) does not depend on the pairing and the adjoint's kernel is always its annihilator.

**Verdicts.** Claim 3: CONFIRMED AS ALGEBRA, with ANN read as ker μ_K*. Claim 4: CONFIRMED AS ALGEBRA, with the same reading and with F_5 invariant. As stated with ANN (record), both inherit row 2's debt.

## 6. Claim 5, injectivity of Cat and the copy of the 14 inside the 65

**5a, the inference.** If μ : S → V is surjective, then ker μ* = image(μ)^⊥ = V^⊥ = 0 by nondegeneracy on V, so μ* = Cat is injective. **CONFIRMED AS ALGEBRA.** Then Cat(V) is a 14-dimensional subspace of whatever space Cat lands in.

**5b, the premise and the landing space.**
- "The unrestricted μ is surjective" has no argument in Passage A or C. The quoted record gives none, and I do not supply one.
- "A copy of the 14 inside the 65" needs Cat to land in S, the invariant forms. Under row 1's reading (μ on all of Sym^2(M)) that needs Cat equivariant, which is the same unstated invariance as row 2. Under the reading μ : S → V it needs surjectivity of μ restricted to invariant forms onto invariant sextics, which is a different statement from surjectivity on all forms and also has no argument on file.

**Discrepancy record.**
1. Locate: "Cat is injective on the invariant sextics ... the unrestricted μ is surjective, so its adjoint is injective ... placing a copy of the 14 inside the 65 invariant symmetric forms on Sym^3."
2. Exhibit: the claim is not false. The failure is that its only premise is asserted, and the domain of "the unrestricted μ" is either Sym^2(M) (then the landing in the 65 is unargued) or S (then the surjectivity at the invariant level is unargued). No closed-form counterexample exists under the intended objects.
3. Charitable reading: the premise is standard and elementary for the intended μ. That makes the debt small, not absent. The rules of this round treat an assertion with no argument on file as debt.

**Verdict for 5b: HYPOTHESIS-DEBT.** To be supplied: which μ, its surjectivity onto V, and (on the Sym^2(M) reading) that Cat maps invariant sextics to invariant forms.

**Use.** Neither 5a nor 5b is used by either display. Injectivity is the edge K = Sym^3 of display 1 (section 9), and it bounds dim ANN = dim(Cat(V) ∩ Ann(K × K)) ≤ min(14, 29), which is vacuous.

## 7. Claim 6, the count of 29 and the split 65 = 36 + 29

**The multiplicities from L83's table (lines 33-38), sorted by the parity of λ_2.**

| Multiplicity | λ_2 even | λ_2 odd |
|---|---|---|
| 4 | (4,2), (2,2) | none |
| 3 | (3,2) | none |
| 2 | (5,2), (4,4), (4,0), (3,0), (2,0) | (4,3), (4,1), (3,1), (2,1) |
| 1 | (6,6), (6,4), (6,2), (6,0), (5,4), (5,0), (1,0), (0,0) | (6,3), (5,3), (5,1), (3,3) |

Even blocks: 2 + 1 + 5 + 8 = 16, matching Passage E's "exactly 16". Odd blocks: 4 + 4 = 8. Total 24, matching L83's heading. Even multiplicities 4·2 + 3 + 2·5 + 8 = 29, odd 2·4 + 4 = 12, total 41.

**Invariant forms per block.** Each V_λ carries one invariant symmetric form up to scale (this is how L83's "unknowns" column counts), so the invariant symmetric forms on the λ-block are Sym^2(M_λ), of dimension m(m+1)/2. Column totals: 2·10 = 20, 6, 9·3 = 27, 12·1 = 12, sum 65. This matches L83's column exactly.

**Forms supported on K, per block.** Sym^2(K_λ). Even, codim 1: (m−1)m/2, giving 6 + 6 for the two multiplicity-4 blocks, 3 for (3,2), 1 each for five multiplicity-2 blocks, 0 for eight multiplicity-1 blocks, total 20. Odd, K_λ = M_λ: 3 each for four multiplicity-2 blocks, 1 each for four multiplicity-1 blocks, total 16. Sum 36, the record's 36 = 20 + 16. Nonzero shapes: two 3×3 ((4,2), (2,2)), five 2×2 ((3,2) and the four odd multiplicity-2), nine scalars (five even multiplicity-2 and four odd multiplicity-1), matching Passage E.

**Forms vanishing on K × K, per block.** Odd: K_λ = M_λ, so only the zero form vanishes on K_λ × K_λ, contributing 0. Even: K_λ = ker ℓ for one nonzero functional ℓ on M_λ. A symmetric form vanishing on ker ℓ × ker ℓ is ℓ ⊙ v for v ∈ M_λ*, and v ↦ ℓ ⊙ v is injective, so the space has dimension m. This is "u⊗v+v⊗u" with u = ℓ fixed and v free. Sum over even blocks: 4 + 4 + 3 + 2·5 + 1·8 = 29, the record's 8 + 3 + 10 + 8. **The rule gives 29 from L83's multiplicities.**

**Split.** Per block m(m+1)/2 = (m−1)m/2 + m in the even case and m(m+1)/2 = m(m+1)/2 + 0 in the odd case, summing to 65 = 36 + 29. The two subspaces are complementary in S only after identifying S with its dual by an invariant pairing (row 1), because "supported on K" lives in Sym^2(M) and "killing K × K" lives in Sym^2(M)*. As dimensions, 29 = dim S − dim S_K is the annihilator dimension with no pairing needed.

**Whether the identity checks anything.** It checks nothing independent. Given the per-block codimensions (1 for even, 0 for odd), the block identity m(m+1)/2 = (m−1)m/2 + m holds for every m, so 65 = 36 + 29 is automatic from the table and the parity rule. It confirms the arithmetic of the table (20 + 6 + 27 + 12 and 20 + 16), not the multiplicities, not the parity rule, and not the rank-one step.

**Verdict: CONFIRMED** from the givens (L83's table, Passage E's parity and exact-codimension claims, whose standing is outside this round).

## 8. Claim 7, "the count is the necessary condition"

**What is necessary for what.** Passage C's sentence is "The count is the necessary condition; Lemma L62 shows it is met." For the displays to bear on a certificate, a certificate must be an expression F_5 = μ(B) with B positive semidefinite, and it must reduce to B ∈ S_K. Named here as what would have to be on file, not supplied as the record's argument, the reduction has three steps:

1. A PSD B = Σ q_i ⊙ q_i gives μ(B)(W) = Σ q_i(W)^2, so vanishing of F_5 on the orbit would force each q_i ∈ K.
2. K is O(5)-stable, so averaging B over O(5) would keep it in Sym^2(K), keep it PSD, and keep μ(B) = F_5 when F_5 is invariant.
3. Then F_5 ∈ μ(S_K ∩ PSD) ⊆ image(μ_K).

Passage E asserts the first step in words ("every covariant entering a certificate vanishes there"). The definition of the certificate, whether B is required invariant, and the averaging step are not in any quoted passage.

**What the positive-semidefinite half adds.** F_5 ∈ image(μ_K) is a linear condition. The certificate needs F_5 ∈ μ_K(S_K ∩ PSD), a convex cone inside the image. The count (rank 14 − dim ANN) and the orthogonality F_5 ⊥ ANN say nothing about whether the affine preimage μ_K^{-1}(F_5), of dimension 36 − rank(μ_K), meets the PSD cone. So even with dim ANN = 0 no certificate follows.

**Verdict: HYPOTHESIS-DEBT.** To be supplied: a definition of the sum-of-squares certificate at n = 5, and the averaging argument that reduces a PSD certificate to an invariant one supported on K, so that F_5 ∈ image(μ_K) is shown necessary.

## 9. Claim 8, the Lean file against the record

- **What is typed.** Real inner product spaces B and V, V finite-dimensional of finrank 14, linear maps muK : B → V and Cat : V → B with the adjunction as a hypothesis. Proved: ker Cat = (range muK)^⊥, finrank(range muK) + finrank(ker Cat) = 14, F5 ∈ range muK iff F5 is orthogonal to ker Cat, injectivity of Cat from surjectivity of mu, and four `norm_num` arithmetic facts. There is no `sorry` in the file. I read the proofs and did not run Lean (the round forbids computation).
- **Faithfulness.** rank_add_dim_ann and mem_range_iff_orthogonal_ann are displays 1 and 2 with ANN := ker of the adjoint of μ_K, i.e. claims 3 and 4 as confirmed above. The additive form avoids truncated subtraction and is equivalent since finrank(ker Cat) ≤ 14. cat_injective_of_mu_surjective is claim 5a.
- **What it declares untyped.** The identification of V and B with the invariant sextics and forms, the catalecticant as a bilinear form, K, F_5, the step of row 2, and the block counts. These are rows 1, 2, 5b and 6's representation theory. The docstring states each of these.
- **Whether a hypothesis excludes anything.** Positive definiteness is stronger than the nondegeneracy the displays need, which excludes indefinite pairings. The apolar pairing on real polynomials is positive definite, so nothing intended is excluded. B carries no finite-dimensionality hypothesis, which is harmless because range muK is a subspace of the finite-dimensional V.
- **Arithmetic theorems.** block_counts, block_shape and multiplicity_split agree with section 7's hand counts (8 + 3 + 10 + 8 = 29, 20 + 6 + 27 + 12 = 65, 20 + 16 = 36, 2·6 + 5·3 + 9 = 36, 29 + 12 = 41). They certify sums of numerals only.
- **Non-vacuity example.** μ_K = 0, Cat = 0 on a 14-dimensional Euclidean space satisfies the hypotheses. It shows satisfiability, which is all it claims.

**Verdict: CONFIRMED AS ALGEBRA.**

## 10. The edges of every range

- **dim ANN = 0.** Display 1 gives rank(μ_K) = 14, μ_K surjective, and display 2 is vacuous in the good direction: F_5 ⊥ {0} holds, and F_5 ∈ image(μ_K) = V holds for any invariant F_5. Consistent.
- **dim ANN = 14.** ANN = V, rank(μ_K) = 0, μ_K = 0. Display 2: F_5 ∈ {0} iff F_5 ⊥ V iff F_5 = 0 by nondegeneracy. Consistent. In the record's terms this is Cat_F(K,K) = 0 for every invariant F, which by row 2's direction one means μ_K = 0.
- **K = Sym^3.** Every K_λ = M_λ, so S_K = S (65), the forms killing K × K number 0 (every block contributes as the odd blocks do), and 65 = 65 + 0. ANN (record) = {F : Cat_F = 0}, which is {0} exactly when Cat is injective, so display 1 at this edge reads rank(μ restricted to S) = 14, which is the surjectivity premise of row 5b. So the injectivity sentence is display 1 at K = Sym^3, and the edge is consistent. Row 2's step is trivial here (Sym^2(K)^G = S and Cat_F ∈ S already), which is why the edge does not expose row 2's debt.
- **Blocks of multiplicity 1 with λ_2 even.** K_λ = 0, the only form supported on K is 0, and the one invariant form kills K_λ × K_λ. These contribute 1 each to the 29 and 0 to the 36, the eight "dying" blocks of Passage E. Consistent with section 7.

## 11. The gap between what is proven and what is stated or used

- Proven (as algebra): displays 1 and 2 for ANN := ker μ_K*, and injectivity of an adjoint of a surjection.
- Stated: the displays for ANN := {F invariant : Cat_F(K,K) = 0}. The join is row 2's absent step.
- Stated: "the unrestricted μ is surjective" and "a copy of the 14 inside the 65". Neither is argued (row 5b), and neither is used by the displays.
- Stated: 65 = 36 + 29. Correct from the givens, automatic from the per-block codimensions, and not used by the displays. The record draws no conclusion from it (in particular it never states the dimension heuristic 14 + 29 < 65 that would suggest ANN = 0, and it proves nothing of the kind).
- Stated in the title: "the certificate's necessary condition is one dimension count". The necessary condition shown is F_5 ∈ image(μ_K), equivalently F_5 ⊥ ANN, conditional on row 7's debt.

## 12. Falsifiers named, and what was done to look for them

| Claim | Falsifying object | Search |
|---|---|---|
| 1 | Two admissible pairings under which Cat_F(K,K) differs in its zero set | Analysis only: for any nondegenerate invariant pairing used consistently, image(μ_K) is fixed and ANN (adjoint) is its annihilator, so no such object changes the displays. Its absence of definition is the finding. |
| 2 | An invariant F with Cat_F orthogonal to Sym^2(K)^G and Cat_F(K,K) ≠ 0 | Section 4: exists in closed form (O(2), C = diag(1, −1)) once Cat_F is allowed non-invariant. Under an invariant Cat_F none exists by averaging, which is the argument the record lacks. |
| 3, 4 | A linear map with rank ≠ dim V − dim ker(adjoint), or a vector orthogonal to ker(adjoint) outside the image | Section 5: none exists for a nondegenerate pairing in finite dimension. With a degenerate pairing on V both fail (e.g. the zero pairing makes every F orthogonal to everything), which the record never excludes, and Lean excludes by positive definiteness. |
| 5 | A nonzero invariant sextic orthogonal to every μ(B) | Section 6: impossible if μ onto V holds. That premise is the debt. |
| 6 | An even block where the forms killing K_λ × K_λ are not m-dimensional, or a total other than 29 | Section 7: the dimension is m for every m, and the total from L83's table is 29. The only remaining falsifier is a block of rank 0 in Passage E, outside scope. |
| 7 | A PSD certificate B with μ(B) = F_5 and F_5 ∉ image(μ_K) | Section 8: impossible under the reduction sketched there, which the record does not state. |
| 8 | A Lean statement weaker than its display, or a hypothesis excluding the intended case | Section 9: none found. |

## 13. Withdrawn candidates

**W1, "an odd-λ_2 block dies entirely".**
1. Locate: "The forms vanishing on K×K number 29, counted block by block: an odd-λ_2 block dies entirely, K containing all of M_λ".
2. Exhibit: in Passage E "die outright" means a block with no unknowns (the eight even multiplicity-1 blocks). Read that way, an odd block would lose all its unknowns and contribute its m(m+1)/2 forms to the killing count, giving 4·3 + 4·1 = 16 from odd blocks, and the total would not be 29.
3. Charitable reading: in Passage A the verb refers to the block's contribution to the 29, and the stated reason, "K containing all of M_λ", forces contribution 0. Under that reading the count is 29 (section 7). **Withdrawn:** the two passages use "die" in opposite senses, a wording hazard and not an error in the count.

**W2, "the count is the necessary condition" read literally.**
1. Locate: Passage C, "The count is the necessary condition; Lemma L62 shows it is met", and the title "the certificate's necessary condition is one dimension count".
2. Exhibit: if "the count" is dim ANN = 0 (rank 14), it is sufficient for F_5 ∈ image(μ_K) and not necessary. In the closed-form model V = ℝ^2 with the standard inner product, μ_K(b) = (b, 0) on ℝ, F_5 = (1, 0): ANN = span(0, 1) has dimension 1, rank 1 = 2 − 1, and F_5 ∈ image. If "the count" is 65 = 36 + 29, it is an identity and is not a condition.
3. Charitable reading: "one dimension count" names the linear-algebra test the displays set up, and F_5 ∈ image(μ_K) is itself the rank statement rank[μ_K | F_5] = rank(μ_K). Under that reading the sentence says the necessary condition is decided by a rank computation, which is correct. **Withdrawn** as a finding of error. Its remaining content (necessary for what certificate) is row 7's debt.

**W3, the Lean file uses one name Cat for two maps.**
1. Locate: the docstring "`ANN` is `ker Cat`", with Cat the adjoint of muK in rank_add_dim_ann, and cat_injective_of_mu_surjective, with Cat the adjoint of mu.
2. Exhibit: the record's Cat is injective (row 5). If ANN were ker of that Cat, dim ANN = 0 for every K, and display 1 would give rank(μ_K) = 14 even for K = 0, where S_K = 0 and rank(μ_K) = 0.
3. Charitable reading: Cat is a bound variable of each theorem separately, and the two theorems cannot share one Cat because their B types differ (S_K against S). The typed statements are correct, and the record's ANN corresponds to ker of the adjoint of μ_K, which is Cat followed by restriction to S_K. **Withdrawn:** a naming hazard in prose, with every theorem correct as typed.

## Overall verdict

**HYPOTHESIS-DEBT.** The algebra of both displays and of the injectivity inference is correct and machine-checked in its abstract form. The lemma as stated needs, and the record does not supply: named pairings with μ, B and Cat_F defined (row 1), the invariance and averaging step joining ANN as defined to the adjoint's kernel (row 2), an argument for the surjectivity premise and the landing of Cat in the 65 (row 5b), and a definition of the certificate with the reduction that makes F_5 ∈ image(μ_K) necessary (row 7). The count 65 = 36 + 29 is correct from L83 and Passage E and checks only their arithmetic.
