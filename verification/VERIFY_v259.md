# Verifier v259, Lemma L59: the apolarity adjunction, the definition of ANN, the rank display, the image criterion, injectivity of Cat, the count 65=36+29, the necessity gloss, and the Lean statement

Cold brief ([BRIEF_L59.md](BRIEF_L59.md)). No numerical work was done: no scripts, no computations, every value below is exact and every sum was added by hand from the quoted table. The Lean file was read and not built. Log: [agent_logs/verify-L59-v259.log](../agent_logs/verify-L59-v259.log).

| Claim | Verdict |
|---|---|
| C1. The adjunction ⟨F,μ(B)⟩=⟨Cat_F,B⟩ | HYPOTHESIS-DEBT |
| C2. ANN (defined by Cat_F(K,K)=0) is the kernel of the adjoint of μ_K | HYPOTHESIS-DEBT |
| C3. rank(μ_K) = 14 − dim ANN | CONFIRMED AS ALGEBRA |
| C4. F_5 ∈ image(μ_K) iff F_5 ⊥ ANN | CONFIRMED AS ALGEBRA |
| C5. Cat injective on invariant sextics from surjectivity of the unrestricted μ, a copy of the 14 inside the 65 | CONFIRMED AS ALGEBRA |
| C6. 29 forms vanish on K×K block by block, and 65 = 36 + 29 | CONFIRMED |
| C7. "The count is the necessary condition" (heading and Passage C) | HYPOTHESIS-DEBT |
| C7b. The title gloss "the certificate's necessary condition is one dimension count" | REFUTED AS STATED (wording level) |
| C8. The Lean statement (Passage G) against Passage A | CONFIRMED AS ALGEBRA |

**Summary.** The displays are correct finite-dimensional linear algebra once ANN is read as the kernel of μ_K's adjoint and the pairing is nondegenerate, and the block count 29 and the split 65=36+29 are exact from L83's table and Passage E, but the record never names the pairing or defines Cat_F, μ, B or "supported on K", never writes the step identifying ANN as defined with that kernel, and never writes the chain from a certificate to F_5 ∈ image(μ_K).

## 0. Conventions, fixed once

- **Quotation check.** Passage A was compared with [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 281 and 299-303, Passages B and C with [results.md](../results.md) lines 216, 739 and 741, Passage D with lines 5-13, Passage E with lines 108-122, Passage F with lines 15, 68, 94, 124 and 138, and L83's table at lines 33-38. All match verbatim. The only difference is a relative link prefix in Passage D ([Killing](../findings/conventions.md) against conventions.md in the source). The Lean file [L59Statement.lean](../lean/HamiltonsCubic/Results/L59Statement.lean) is byte-identical to Passage G and has 178 lines (the brief says 179, immaterial). It is imported at [lean/HamiltonsCubic.lean:385](../lean/HamiltonsCubic.lean#L385).
- **Names used below, as reading aids only (no definition is chosen and proved under).** C denotes the space of cubics on 𝒲₅ (the record's Sym³, "span of cubics" in Passage C). Its O(5)-isotypic decomposition is written C = ⊕_λ M_λ ⊗ V_λ with dim M_λ = m_λ from L83's table. K_λ ⊂ M_λ denotes the multiplicity subspace of K in block λ. ANN is always the record's set {F invariant sextic : Cat_F(K,K)=0}. ANN′ denotes the kernel of the adjoint of μ_K, a separate object introduced only to state what C2 asks.
- **Givens.** Per the brief, the standing of L83, L85, L86, L87 and L88 is not in question. They supply: the multiplicities (L83), the 14 (L85), the parity rule (L86, Passage E), that each even block loses exactly one multiplicity (L87), and 65 invariant symmetric forms (L88).
- **Symbol clashes in the record.** B is the Lie-algebra form B(X,Y) = −½ tr(XY) in Passage D and the Gram form in Passage A. (μ₁, μ₂) are so(4) weights in Passage E and μ is the multiplication map in Passage A. Both are separated by context (§12.3).

## 1. Hypothesis inventory

| Object or hypothesis | Where defined | Used by the argument | Status |
|---|---|---|---|
| 𝒲₅, the O(5)-action | Passage D | yes (invariants, blocks) | defined |
| Sym³ (the cubics C) and its blocks M_λ ⊗ V_λ | L83 table (multiplicities), Passage E ("evaluation map M_λ → V_λ^H") | yes | multiplicities given, M_λ used without a written definition |
| K, "the span cut out by the orbit constraint" | Passage E: "the single condition σ_λ(W₀)=0", with L86/L87 fixing codimension 1 in even blocks and 0 in odd blocks | yes | given via E, K O(5)-stable by construction (vanishing on an orbit) but stability is not stated in A |
| μ | nowhere in the quoted record, "sum-of-squares certificate" in C suggests the Gram-to-sextic multiplication | yes | **undefined** |
| B | nowhere in A-C (and B is a different object in D) | yes | **undefined** |
| Cat_F | "catalecticant" in C, no formula | yes | **undefined** beyond the name |
| ⟨·,·⟩ on sextics and on forms | "Apolarity" only | yes, in both displays and in "⊥" | **unnamed**. The Lean file quotes the record's own admission that "the pairing is never named" |
| "the invariants supported on K" (domain of μ_K) | nowhere | yes | **undefined** |
| ANN | Passage A | yes | defined, in terms of the undefined Cat_F |
| F_5 | not in Passages A-F (E says it vanishes on the orbit), the Lean docstring gives (3/2)‖W‖⁶ − 9 tr(W³)² | yes | not defined in the quoted record |
| F_5 is O(5)-invariant | nowhere | yes, for "F_5 ∈ image(μ_K)" to parse inside the 14 and for averaging a certificate | **used, unstated** |
| 14 = dim of invariant sextics | L85 | yes (C3) | given |
| 65 invariant symmetric forms | L88 | yes (C5, C6) | given |
| 36, the rank-one step | Passage E, L86, L87 | yes (C6) | given |
| u, v in "u⊗v+v⊗u" | nowhere | yes (C6) | unnamed. The only reading that parses is u spanning the complement of K_λ in M_λ, v ranging over M_λ |
| O(5)-invariance of the pairing, equivariance of μ and of F ↦ Cat_F | nowhere | yes (C2, C5 "inside the 65", C7) | **used, unstated** |
| Nondegeneracy of the pairing restricted to the 14 invariant sextics | nowhere | yes (C3, C4) | **used, unstated** |
| Surjectivity of the unrestricted μ | asserted in A | yes (C5) | **asserted, no argument on file** |
| Schur for real-type blocks: invariant symmetric forms on M_λ ⊗ V_λ are Sym²(M_λ^*) ⊗ g_λ, and distinct blocks pair to zero | implicit in L88's 65 = Σ m(m+1)/2 | yes (C6) | given through L88 |
| The certificate, "necessary" for what | C: "the sum-of-squares certificate at n=5", no structure written | yes (C7) | **undefined** |
| L62 | cited | C7 only | out of scope |

## 2. Quantifier order, scope, and which μ each sentence means

- **Sentence 1 of A**, "Apolarity gives ⟨F,μ(B)⟩=⟨Cat_F,B⟩": μ is the map whose adjoint is F ↦ Cat_F with Cat_F a form on all of Sym³ (ANN evaluates Cat_F on K×K, so Cat_F must be defined off K). This is the unrestricted μ, on all Gram forms or on the 65 invariant ones. The quantifier "for all F, B" is implicit.
- **The display** uses μ_K, "the restriction of μ to the invariants supported on K", so both rank and image refer to μ_K, with target the 14 invariant sextics (C says "on the 14-dimensional space of invariant sextics").
- **Sentence 3**, "the unrestricted μ is surjective, so its adjoint is injective": explicitly unrestricted. Either domain (all of Sym²(C), or its 65 invariants) gives injectivity of Cat on the invariant sextics, see §7.
- **ANN is quantified before μ_K is introduced** and does not mention μ_K. Its link to μ_K is the step of C2, which is not written.
- **Passage B names no map**: "apolarity gives rank=14−dim ANN and F_5 ∈ image iff F_5 ⊥ ANN". Read as the unrestricted μ the rank would be 14 and the display would force dim ANN = 0. This is recorded as a withdrawn candidate (§12.1) since C supplies μ_K.

## 3. C1, the adjunction

**What the record gives.** "Apolarity gives ⟨F,μ(B)⟩=⟨Cat_F,B⟩" (sym3-blocks.md line 299). No pairing is named and neither μ, B nor Cat_F is defined in any quoted passage.

**What each object must be for the sentence to parse.**

- The left pairing lives between a sextic F and the sextic μ(B), so it is a pairing on sextics (or between sextics and their dual).
- The right pairing lives between Cat_F, a bilinear form on cubics, and B, a symmetric tensor or form on cubics. If B is a symmetric 2-tensor on C and Cat_F a bilinear form on C, the natural evaluation pairing needs no inner product. If B and Cat_F are both forms, an inner product on forms is needed.
- If Cat_F is defined by Cat_F(p,q) = ⟨F, pq⟩ with the same sextic pairing, and μ(Σ B_ij e_i⊗e_j) = Σ B_ij e_i e_j, then the adjunction is bilinearity, i.e. the definition of Cat as the transpose of μ, and no theorem.

**Does the record supply this?** No. "Catalecticant" in C fixes the idea but not the pairing or its normalisation. The Lean file's docstring itself quotes "the pairing is never named, and that is the defect".

**Verdict: HYPOTHESIS-DEBT.** What must be supplied: (i) the pairing on sextics, with its O(5)-invariance and its nondegeneracy on the 14 invariants, (ii) the definition of μ on Gram forms B, (iii) Cat_F(p,q) := ⟨F,pq⟩ or an equivalent definition. Once (i)-(iii) are on file the adjunction is definitional.

**Falsifier sought.** A pairing and a Cat_F for which the identity fails. None can be exhibited because no pairing is on file to fail. Under the definitional reading no failure is possible.

## 4. C2, ANN and the kernel of μ_K's adjoint

**What the displays need.** The adjoint of μ_K sends an invariant sextic F to the functional B ↦ ⟨Cat_F, B⟩ on the invariant forms supported on K. Its kernel is ANN′ = {F : ⟨Cat_F, B⟩ = 0 for every invariant B supported on K}. The rank display and the image criterion hold for ANN′ (§5, §6). Passage A asserts them for ANN = {F : Cat_F(K,K)=0}.

**The inclusion ANN ⊆ ANN′** is immediate: Cat_F vanishing on K×K pairs to zero with every B supported on K.

**The inclusion ANN′ ⊆ ANN** is the step the brief names, from "Cat_F vanishes on every invariant form supported on K" to "Cat_F(K,K)=0". Passage A contains no sentence performing it: "so" passes directly from the adjunction to the display. What the step needs, named and not supplied here:

- K is O(5)-stable (true of any span of cubics vanishing on an orbit, not stated in A),
- the pairing is O(5)-invariant, so that F invariant makes Cat_F an invariant form,
- an averaging or isotypic-pairing argument: for invariant Cat_F, the pairing with an arbitrary B supported on K equals the pairing with its invariant part, which is still supported on K,
- Cat_F symmetric, so that vanishing against Sym²(K) is vanishing on K×K.

An alternative route the record also leaves unwritten: the invariant forms killing K×K (29 of them, §8) sit inside the annihilator of the 36 invariant forms supported on K, and that annihilator has dimension 65 − 36 = 29 provided the pairing between invariant forms and invariant tensors is nondegenerate. The record states "65=36+29 splits the invariant forms" but does not draw this conclusion or use it for ANN.

**Discrepancy protocol.**

1. Location: sym3-blocks.md line 299, "let ANN be the invariant sextics F with Cat_F(K,K)=0. Apolarity gives ⟨F,μ(B)⟩=⟨Cat_F,B⟩, so, for μ_K the restriction of μ to the invariants supported on K", followed by the display in lines 300-302.
2. Concrete failure: the written chain has no link from the defining condition of ANN to the kernel of μ_K's adjoint. The displays follow from the adjunction for the kernel (§5) and the text supplies nothing to replace the kernel by ANN. A closed-form mathematical counterexample to ANN = ANN′ requires a non-invariant pairing, which is outside every charitable reading of "apolarity". None is exhibited, so the finding is a missing argument, not a refutation.
3. Charitable reading: "apolarity" means the O(5)-invariant apolar pairing, Cat is equivariant, and a reader supplies averaging. Under that reading the step is standard. It remains absent from the text, and the Lean file declares it untyped ("The step the audit calls genuinely absent ... needs equivariance plus isotypic pairing"). The candidate survives as debt.

**Verdict: HYPOTHESIS-DEBT.** Owed: invariance of the pairing, O(5)-stability of K, and the averaging step, or equivalently the dimension argument above with the nondegenerate invariant pairing stated.

## 5. C3, rank(μ_K) = 14 − dim ANN

**Derivation, with ANN read as ANN′.** Let V be the 14-dimensional space of invariant sextics with a nondegenerate pairing, D the finite-dimensional domain of μ_K (36-dimensional per §8), and μ_K : D → V. The adjoint μ_K^* : V → D^* is F ↦ ⟨Cat_F, ·⟩|_D by C1. For F ∈ V, F ∈ ker μ_K^* iff ⟨F, μ_K(b)⟩ = 0 for all b ∈ D iff F ∈ image(μ_K)^⊥. So ANN′ = image(μ_K)^⊥. A nondegenerate pairing on a finite-dimensional V gives dim W + dim W^⊥ = dim V for every subspace W (for an indefinite nondegenerate pairing this is still true, as W^⊥ is the kernel of V → W^*, which is onto). Hence rank(μ_K) + dim ANN′ = 14.

**Range edge.** rank(μ_K) ≤ min(36, 14) = 14, so dim ANN′ ∈ [0, 14] and the subtraction never goes negative.

**Verdict: CONFIRMED AS ALGEBRA**, conditional on C1 (pairing nondegenerate on V) and C2 (ANN = ANN′).

**Falsifier sought.** A degenerate pairing on V: then W^⊥ can exceed 14 − dim W (if W is a nonzero subspace of the radical, W^⊥ = V and dim W + dim W^⊥ > 14). The record names no pairing, so nondegeneracy is part of C1's debt. Under a positive-definite apolar pairing no falsifier exists.

## 6. C4, F_5 ∈ image(μ_K) iff F_5 ⊥ ANN

**Derivation, with ANN read as ANN′.** From §5, ANN′ = image(μ_K)^⊥. For a nondegenerate pairing on finite-dimensional V, (W^⊥)^⊥ = W, since W ⊆ (W^⊥)^⊥ and both have dimension dim W. So F_5 ∈ image(μ_K) iff F_5 ∈ (ANN′)^⊥ iff F_5 ⊥ ANN′.

**Hypotheses used and unstated.** F_5 ∈ V, i.e. F_5 is an invariant sextic. The "⊥" is taken in the same pairing as the adjunction.

**Verdict: CONFIRMED AS ALGEBRA**, conditional on C1 and C2 and on F_5 invariant.

**Falsifier sought.** A non-invariant F_5 makes the criterion unparseable inside V. A degenerate pairing breaks (W^⊥)^⊥ = W. Neither is available under a charitable reading, and the record supplies neither assumption.

## 7. C5, injectivity of Cat and "a copy of the 14 inside the 65"

**Derivation of the inference.** Let μ : E → V be surjective, with nondegenerate pairings on E-side forms and on V, and Cat its adjoint. If Cat_F = 0 then ⟨F, μ(b)⟩ = 0 for all b, so F ⊥ V, so F = 0. Cat is injective. This holds with E = all Gram forms (then Cat restricted to invariant sextics is injective) or E = the 65 invariant forms.

**"Inside the 65"** needs Cat_F to be an invariant form when F is invariant, i.e. equivariance of Cat, which rests on invariance of the pairing (C1's debt). With E = the 65 invariant forms it is automatic by construction of the adjoint on that space.

**The premise.** "The unrestricted μ is surjective" is asserted with no argument on file. It is recorded as an unargued premise, not supplied here.

**Verdict: CONFIRMED AS ALGEBRA** for the inference "surjective, so adjoint injective" and for the dimension statement that Cat embeds the 14 in the 65. The surjectivity premise and the equivariance of Cat are listed in the debt inventory (§1).

**Falsifier sought.** An invariant sextic F ≠ 0 with Cat_F = 0. Given surjectivity and a nondegenerate pairing none exists. A falsifier of the premise would be an invariant sextic outside the span of products of cubics, which the record does not argue against.

## 8. C6, the count 29 and the split 65 = 36 + 29

**Parity classification from L83's table (lines 33-38) and Passage E's rule (dim V_λ^H = 1 iff λ₂ even).**

| mult | even λ₂ | odd λ₂ |
|---|---|---|
| 4 | (4,2), (2,2) | none |
| 3 | (3,2) | none |
| 2 | (5,2), (4,4), (4,0), (3,0), (2,0) | (4,3), (4,1), (3,1), (2,1) |
| 1 | (6,6), (6,4), (6,2), (6,0), (5,4), (5,0), (1,0), (0,0) | (6,3), (5,3), (5,1), (3,3) |

- Even blocks: 2 + 1 + 5 + 8 = 16, matching "exactly 16". Their dimensions, 220+35+105+390+165+55+30+14+455+810+625+140+429+91+5+1 = 3570, matching Passage E.
- Multiplicities: even 4+4+3+2·5+8 = 29, odd 2·4+4 = 12, total 41.
- The eight dying multiplicity-1 blocks of E are exactly the even multiplicity-1 column: (0,0), (1,0), (5,0), (5,4), (6,0), (6,2), (6,4), (6,6). Match.

**Per-block counts.** In block λ with m = m_λ and k = dim K_λ (k = m − 1 even, k = m odd, by L86/L87):

- invariant symmetric forms: m(m+1)/2,
- supported on K: k(k+1)/2,
- vanishing on (K_λ ⊗ V_λ)×(K_λ ⊗ V_λ): m(m+1)/2 − k(k+1)/2.

For odd λ₂ the last is 0 ("dies entirely, K containing all of M_λ"). For even λ₂ it is m(m+1)/2 − (m−1)m/2 = m. The forms on M_λ vanishing on a hyperplane K_λ are exactly u⊗v+v⊗u with u spanning K_λ's complement and v ∈ M_λ: such a form vanishes on K_λ×K_λ, and v ↦ u⊗v+v⊗u is injective (evaluating at (u, y) gives v = −⟨v,u⟩u, hence ⟨v,u⟩ = 0 and v = 0), so they fill the m-dimensional space. The rule "an even one keeps u⊗v+v⊗u" gives m.

**Totals.**

- Vanishing on K×K: Σ_even m = 8 + 3 + 10 + 8 = 29.
- Supported on K, even: 6 + 6 + 3 + 5·1 + 8·0 = 20. Odd: 4·3 + 4·1 = 16. Total 36. Shape: 3×3 blocks from (4,2), (2,2), two of them. 2×2 from (3,2) and the four odd multiplicity-2 blocks, five. Scalars from the five even multiplicity-2 blocks and the four odd multiplicity-1 blocks, nine. 2·6 + 5·3 + 9 = 36.
- All invariant symmetric forms: 20 + 6 + 27 + 12 = 65 (per-tier m(m+1)/2: 10+10, 6, 3·9, 12).
- 36 + 29 = 65.

**What the identity checks.** Per block m(m+1)/2 = k(k+1)/2 + (m(m+1)/2 − k(k+1)/2) for every k, so 65 = 36 + 29 holds for any multiplicities and any codimensions. It checks the addition, not the table, the parity rule or the rank-one step. As a decomposition of one space ("splits the invariant forms into") it needs tensors supported on K and forms killing K×K identified in one space, by a block-compatible inner product on each M_λ, under which Sym²(K_λ) and the span of u⊗v+v⊗u are orthogonal complements. That identification is not stated but is forced by the phrase and is consistent.

**Verdict: CONFIRMED** from the givens.

**Falsifier sought.** A multiplicity or parity assignment in L83's table making the even sum differ from 29, or an even block whose K_λ-complement count differs from m. Every entry was reclassified by hand and none was found.

## 9. C7 and C7b, "the count is the necessary condition, Lemma L62 shows it is met"

**What is necessary for what.** The only reading that parses: if F_5 has a sum-of-squares certificate with invariant Gram form B ⪰ 0 supported on K, then μ_K(B) = F_5, so F_5 ∈ image(μ_K). The positive-semidefinite half adds the condition that some preimage of F_5 in the 36-dimensional domain is ⪰ 0 blockwise (the two 3×3, five 2×2 and nine scalar blocks), a semidefinite feasibility condition that no rank or dimension count decides.

**C7, the necessity chain.** Neither A nor C writes the passage from a certificate to F_5 ∈ image(μ_K). It needs:

- each cubic in the certificate lies in K (Passage E: "every covariant entering a certificate vanishes there"),
- F_5 is O(5)-invariant, and averaging a certificate's Gram form over O(5) keeps it ⪰ 0, supported on K (K O(5)-stable) and with μ-image F_5,
- the certificate's structure itself, which C calls "the sum-of-squares certificate at n=5" without definition.

Discrepancy protocol: (1) results.md line 741, "The count is the necessary condition", and the heading at sym3-blocks.md line 281. (2) The implication certificate ⇒ F_5 ∈ image(μ_K) over the invariant domain has no written argument, and the averaging step is required because μ_K is restricted to invariants while a certificate need not be invariant. (3) Charitably, Passage E supplies the first bullet and averaging is standard. The second and third bullets stay unwritten. **Verdict: HYPOTHESIS-DEBT.**

**C7b, "one dimension count".** Discrepancy protocol:

1. Location: the heading "the certificate's necessary condition is one dimension count" (sym3-blocks.md line 281, results.md line 216) and "The count is the necessary condition" (results.md line 741).
2. Concrete failure: the necessary condition is F_5 ⊥ ANN, which is not a function of dim ANN. Closed form in the abstract setting of the lemma: V = ℝ¹⁴ with the standard inner product, μ_K with image e₁^⊥, so rank 13 and ANN = span(e₁), dim ANN = 1. The sextic-slot vector e₂ satisfies the condition and e₁ does not, with the same count. The count decides the condition only at the edge dim ANN = 0.
3. Charitable reading: the slogan means that the condition reduces to finite linear algebra governed by the rank display, and the body of A states both displays correctly. This rescues the body, not the sentence "The count is the necessary condition", which as written identifies a membership condition with a number. The candidate survives at wording level.

**Verdict: REFUTED AS STATED (wording level).** The mathematics of the displays is untouched. Whether L62 shows dim ANN = 0 or F_5 ⊥ ANN is out of scope.

## 10. C8, the Lean statement

**What is typed.** B and V real inner product spaces, muK : B →ₗ V, Cat : V →ₗ B with hadj : ⟪F, muK b⟫ = ⟪Cat F, b⟫, and ANN := ker Cat.

- ker_adj_eq_range_orthogonal: ker Cat = (range muK)^⊥. The proof uses hadj in both directions and ⟪Cat F, Cat F⟫ = 0 ⇒ Cat F = 0. Matches §5.
- rank_add_dim_ann: under [FiniteDimensional ℝ V] and finrank V = 14, finrank (range muK) + finrank (ker Cat) = 14. This is the additive form of the rank display, faithful, and it avoids ℕ truncation as its docstring says.
- mem_range_iff_orthogonal_ann: F5 ∈ range muK iff ⟪F5, G⟫ = 0 for all G ∈ ker Cat. Faithful to the image criterion, with F5 ∈ V (so invariance of F_5 is built into the typing).
- cat_injective_of_mu_surjective: an adjoint of a surjection is injective. Faithful to §7's inference, with surjectivity a hypothesis (the record's unargued premise stays a hypothesis, correctly).
- block_counts, block_shape, multiplicity_split: numeral identities in ℕ, disconnected from any representation, as the docstring says. block_shape also proves 2·9 + 5·4 + 9 = 47 "Hermitian coordinates", which is not in Passage A and is harmless.
- The non-vacuity example proves finrank = 14 and the adjunction for zero maps. Its docstring adds "the rank equation reads 0 + 14 = 14", which the example does not prove (it would follow by applying rank_add_dim_ann). Recorded as a withdrawn candidate (§12.4).

**Does it state the claim?** It states the algebraic core with ANN := ker(adjoint of μ_K), i.e. ANN′, not the record's ANN. The file declares untyped exactly the identifications C1, C2 and C6 depend on: V as the invariant sextics, K as the orbit-constraint span, Cat_F as a bilinear form, the step ANN′ ⊆ ANN, and the 29 and 36 as block counts. The same identifier Cat denotes the adjoint of muK in two theorems and of the unrestricted mu in a third, with no theorem relating them, which mirrors the record's two uses of μ (§2).

**Does a hypothesis exclude anything?** Positive-definite inner products are assumed on both sides. The record's pairing is unnamed, so this is a choice the file makes explicit, and the apolar pairing of the charitable reading satisfies it. An indefinite nondegenerate pairing would be excluded, but the record never asks for one. B carries no finite-dimensionality hypothesis and none is needed. Nothing the record's claim covers is excluded.

**Verdict: CONFIRMED AS ALGEBRA.** The Lean theorems are faithful to the two displays and the injectivity inference under ANN := ANN′, and they discharge none of C1, C2, C6 or C7. The file was not built in this round.

## 11. Boundaries (item 3)

- **dim ANN = 0.** rank(μ_K) = 14, μ_K onto V, F_5 ⊥ {0} holds for every F_5, and F_5 ∈ image(μ_K) holds. Both displays agree. In Lean, ker Cat = ⊥ and range = ⊤, consistent.
- **dim ANN = 14.** rank(μ_K) = 0, image {0}. F_5 ⊥ V iff F_5 = 0 by nondegeneracy, and F_5 ∈ {0} iff F_5 = 0. Both displays agree. This is the Lean witness (muK = 0, Cat = 0).
- **K = Sym³.** Then μ_K is μ on all 65 invariant forms, surjective by the premise of C5, rank 14. ANN = {F : Cat_F = 0} = 0 by injectivity. 14 − 0 = 14, consistent. The block count becomes 65 = 65 + 0 (k = m in every block), consistent with the per-block identity. The rule "an even one keeps u⊗v+v⊗u" is specific to the orbit-constraint K and does not apply here, which A's wording "K having codimension 1 there" already restricts.

## 12. Withdrawn candidates

### 12.1 Passage B names no map

(1) results.md line 216: "apolarity gives rank=14−dim ANN and F_5 ∈ image iff F_5 ⊥ ANN". (2) Read with the unrestricted μ the rank is 14, forcing dim ANN = 0, and the image criterion would be vacuous. (3) The landscape line summarises the detail form at line 741, which names μ_K and its domain. **Withdrawn**: the only reading that parses is C's, and no mathematical claim fails under it. The omission is editorial.

### 12.2 "Dies" used in opposite senses

(1) Passage A: "an odd-λ₂ block dies entirely, K containing all of M_λ". Passage E: "Eight of the twelve multiplicity-1 blocks die outright", which are even blocks with K_λ = 0. (2) In A an odd block "dies" from the forms killing K×K while it survives whole in K. In E an even block "dies" from K. (3) Each sentence is correct in its own context (§8). **Withdrawn**: terminology, not a false count.

### 12.3 Symbol clashes, B and μ

(1) Passage D: "B(X,Y)=−½ tr(XY)". Passage E: "(μ₁,μ₂)=(λ₂,−λ₂)". (2) Passage A reuses B for a Gram form and μ for multiplication. (3) The passages are separate sections and the types differ (a form on so(5) against a form on cubics, a weight against a linear map). **Withdrawn**: no inference in A uses the other meaning.

### 12.4 Lean non-vacuity docstring

(1) L59Statement.lean, "the rank equation reads 0 + 14 = 14". (2) The example proves only finrank = 14 and the adjunction. (3) The docstring describes what rank_add_dim_ann yields on the witness, which is immediate. **Withdrawn**: the example's purpose, non-vacuity of hypotheses, is met.

### 12.5 "65 = 36 + 29 checks the table"

(1) Lean docstring and A treat the split as a check. (2) The per-block identity holds for any m and k (§8), so it cannot detect an error in the multiplicities. (3) A does not claim it checks the table, only that it "splits the invariant forms". **Withdrawn** as a finding against A. It is recorded in §8 that the identity checks arithmetic only.

## 13. Falsifiers (item 7), summary

| Claim | Falsifying object | Search done |
|---|---|---|
| C1 | a named pairing under which ⟨F,μ(B)⟩ ≠ ⟨Cat_F,B⟩ | none on file to test, definitional under C's "catalecticant" |
| C2 | an invariant sextic with Cat_F ⊥ all invariant forms on K and Cat_F(p,q) ≠ 0 for some p, q ∈ K | requires a non-invariant pairing, outside the charitable reading, none exhibited |
| C3, C4 | a degenerate pairing on the 14 invariant sextics | not on file, part of C1's debt |
| C5 | a nonzero invariant sextic with Cat_F = 0 | impossible given surjectivity and nondegeneracy |
| C6 | a table entry with wrong parity or multiplicity changing 29 or 36 | all 24 blocks reclassified by hand, none |
| C7 | a certificate whose Gram form is not averaged to an invariant one supported on K | the chain is unwritten, the object is the missing argument itself |
| C7b | two sextics with equal count and different membership | exhibited in the abstract setting, §9 |
| C8 | a theorem whose hypotheses exclude the record's case | none, positive-definite inner products are the charitable reading's pairing |

## 14. Overall verdict

**HYPOTHESIS-DEBT.** The displays, the injectivity inference and the block count 65 = 36 + 29 are correct from the adjunction and the givens. The record owes: the named, O(5)-invariant pairing, nondegenerate on the 14 invariant sextics, with μ, B, Cat_F and "supported on K" defined (C1), the step from "Cat_F kills every invariant form supported on K" to Cat_F(K,K)=0 (C2), the surjectivity of the unrestricted μ (C5 premise), and the chain from a certificate to F_5 ∈ image(μ_K), including invariance of F_5 and averaging (C7). The title's "one dimension count" misdescribes the condition, which is F_5 ⊥ ANN (C7b, wording level).
