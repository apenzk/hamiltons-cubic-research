# Verifier v269, Lemma L65: the seed ι_λ ⊗ cup^{⊗k} is a well-defined, O(n)-equivariant, nonzero element of M_λ, with the admissibility remarks, the section pointer, the "diagram" heading and the Lean files

*The brief ([BRIEF_L65.md](BRIEF_L65.md)) was cold. No numerical work was done, every value below is exact, no script was written or run, and no Lean build was run (the Lean files were read, not compiled). Log: [agent_logs/verify-L65-v269.log](../agent_logs/verify-L65-v269.log).*

| # | Claim | Verdict |
|---|---|---|
| 1 | Passage A's pointer: the argument is "under The diagram-realisation theorem, one seed per block" | REFUTED AS STATED |
| 2 | c_0 is a well-defined map V_λ → V^{⊗12}, k = (12 − \|λ\|)/2 a nonnegative integer, "composite with k cups" equals ι_λ ⊗ cup^{⊗k} | CONFIRMED (needs \|λ\| ∈ {0,2,…,12}, unstated in A and B) |
| 3 | c_0 is equivariant for the full O(n), reflections included | CONFIRMED |
| 4a | Nonvanishing, reason (a): a tensor product of nonzero vectors is nonzero | CONFIRMED at n ≥ 1, REFUTED AS STATED at n = 0, λ = ∅ |
| 4b | Nonvanishing, reason (b): the cap computation returns n^k ι_λ | CONFIRMED AS ALGEBRA (cap undefined in the passages, n ≥ 1) |
| 5 | c_0 ∈ M_λ, and nonzero in M_λ equals nonzero as a map | CONFIRMED |
| 6a | Witnesses (2,2) at n = 2, 3 and (2,1,1) at n = 3 fail admissibility | CONFIRMED |
| 6b | "Without admissibility V_λ = 0 and ι_λ does not exist" | CONFIRMED in its intended content (wording candidate withdrawn, §6.3) |
| 6c | "At n = 12 it holds for all 71 blocks" | CONFIRMED for every λ with \|λ\| ≤ 12, by the argument in L65.lean, the count 71 idle |
| 6d | Tightness at λ = (2,2,2,2,2,2) | CONFIRMED AS ALGEBRA (its membership among the blocks is HYPOTHESIS-DEBT, unused) |
| 6e | The count 71, and 16 blocks / 17 of 184 multiplicities at \|λ\| = 12, and 19 for SO(12) | HYPOTHESIS-DEBT (no argument in the passages, unused by the lemma) |
| 7 | "The seed is a diagram" (headings of A and B, canon title) | REFUTED AS STATED (the seed is ι_λ followed by a diagram, literally a diagram only at λ = ∅) |
| 8 | Canon (Passage E): scope, "removes a search … adds no certificate" | CONFIRMED (dimension-free for n ≥ 1, the statement omits "nonzero" and "equivariant") |
| 9 | The Lean files state or prove L65 | REFUTED AS STATED if read as formalising L65: they type abstract ingredients and partition arithmetic, the lemma itself is not stated (CONFIRMED AS ALGEBRA for what is typed) |

**Summary: the mathematics of L65 is correct as argued in Passage B for n ≥ 1 and |λ| ∈ {0,2,…,12}, the numbered block points at the wrong section, the "diagram" name overclaims, and the block counts are carried without argument but are not used.**

## 0. Conventions, fixed once

- V = ℝ^n with the standard inner product, orthonormal basis e_1, …, e_n, and O(n) acting by g·e_a = Σ_b g_{ba} e_b, with g gᵀ = I. V^{⊗f} carries the diagonal action.
- λ is a partition, λ' its conjugate, so λ'_1 is the number of nonzero parts and λ'_2 the number of parts ≥ 2. λ is O(n)-admissible when λ'_1 + λ'_2 ≤ n.
- V_λ is the O(n)-irreducible labelled by admissible λ (brief, definitions). When a model is needed for non-admissible λ, "Weyl's model" means the space of traceless tensors in V^{⊗|λ|} of symmetry type λ (a Young symmetriser applied after the traceless projection), which is the classical construction and is unfiled.
- cup = Σ_a e_a ⊗ e_a ∈ V ⊗ V, viewed also as the linear map ℝ → V ⊗ V, 1 ↦ cup. cap: V ⊗ V → ℝ is e_a ⊗ e_b ↦ δ_{ab}. The passages define cup but never define cap.
- k = (12 − |λ|)/2. c_0 := ι_λ ⊗ cup^{⊗k}, meaning v ↦ ι_λ(v) ⊗ cup ⊗ … ⊗ cup, the cups on the last 2k legs, through the canonical isomorphism V_λ ≅ V_λ ⊗ ℝ^{⊗k}.
- M_λ = Hom_{O(n)}(V_λ, V^{⊗12}) (Passage C, part 1).
- Passage letters A to F are the brief's. Sources were checked verbatim: [findings/brauer-pairing.md](../findings/brauer-pairing.md) lines 1–13, 40–50, 86–98, 112–116, [results.md](../results.md) lines 226 and 771, and both Lean files in full. Every quotation in the brief matches its source.

## Hypothesis inventory

### Hypotheses of the statement

| Hypothesis | Where stated | Used by the argument | Satisfiable |
|---|---|---|---|
| H1. λ is O(n)-admissible | A, B, E | Yes, to have V_λ ≠ 0 and ι_λ injective and nonzero | Yes, λ = ∅ at every n |
| H2. \|λ\| ≤ 12 and \|λ\| even, so k ∈ {0,…,6} | Unstated in A and B. Implicit in E ("a block λ of the sextic invariants") and in D ("\|λ\| ∈ {0,2,…,12} for this certificate") | Yes, c_0 is undefined otherwise | Yes |
| H3. n ≥ 1 | Unstated anywhere. Implicit in E through "block", since V^{⊗12} = 0 at n = 0 | Yes, for cup ≠ 0 when k > 0 (reason a) and for n^k ≠ 0 (reason b) | Yes |
| H4. A choice of the embedding ι_λ | A, B, E say "the inclusion" | Yes, any nonzero equivariant injection serves | Yes, under I2 |

### Imported results

| Import | Filed | Exact form the argument needs | Hypotheses checked against the object |
|---|---|---|---|
| I1. Classification of O(n)-irreducibles by admissible partitions (Weyl) | Unfiled | For admissible λ, V_λ is a nonzero irreducible O(n)-module | λ admissible (H1). Holds. |
| I2. Occurrence of V_λ in V^{⊗\|λ\|} (Weyl's construction, traceless tensors of symmetry λ) | Unfiled | An injective O(n)-map ι_λ: V_λ → V^{⊗\|λ\|} exists for admissible λ, and the space of traceless tensors of symmetry type λ is zero exactly when λ is not admissible | λ admissible. Holds. Needed for "in closed form" and "no search", see §8. |
| I3. The tensor product over a field of nonzero vectors is nonzero | Elementary linear algebra | As stated | ℝ is a field. Holds. |
| I4. The tensor product of equivariant maps is equivariant | Elementary, and typed for an arbitrary group in [L65Statement.lean:101](../lean/HamiltonsCubic/Results/L65Statement.lean#L101) | As stated, iterated k + 1 times and precomposed with V_λ ≅ V_λ ⊗ ℝ^{⊗k} | Holds for the full O(n). |
| I5. First Fundamental Theorem for O(n), and Passage C's realisation theorem | FFT: Lehrer–Zhang Theorem 3.4 per the filed [README](../references/lehrer-zhang-sft-orthogonal/README.md) | Not used by L65. They consume L65's output (a nonzero seed per block). | Out of scope. |

The two filed sources ([andersen-stroppel-tubbenhauer-brauer-semisimplicity/](../references/andersen-stroppel-tubbenhauer-brauer-semisimplicity/), [lehrer-zhang-sft-orthogonal/](../references/lehrer-zhang-sft-orthogonal/)) are not needed by any step of L65's argument.

## 1. The pointer in Passage A (attack item 1)

**Finding: REFUTED AS STATED.**

1. **Locate.** [brauer-pairing.md:114](../findings/brauer-pairing.md#L114): "the argument is in this file under "The diagram-realisation theorem, one seed per block"".
2. **Exhibit.** That heading is line 40, "## The diagram-realisation theorem, one seed per block", and Passage C (lines 40–50) contains no ι_λ, no cup, no k, no admissibility and no nonvanishing argument. The argument for L65 (equivariance, nonvanishing, admissibility) is in Passage B, which opens with its own heading at line 86, "## The seed is itself a diagram", at the same level ##. A sibling ## section is not "under" line 40's section.
3. **Opposite.** Charitably, the pointer names the theorem the seed serves, and the argument sits later in the same file. But the sentence says "the argument is … under" that heading, and the heading levels make Passage B a separate section. The Lean statement file itself quotes the argument from "the surrounding section", i.e. B ([L65Statement.lean:19](../lean/HamiltonsCubic/Results/L65Statement.lean#L19)). The charitable reading does not rescue the sentence. The mathematics is unaffected: the correct pointer is "The seed is itself a diagram".

## 2. What c_0 is (attack item 2)

**Finding: CONFIRMED, with H2 made explicit.**

**Derivation.** For |λ| ∈ {0,2,…,12}, k = (12 − |λ|)/2 ∈ {0,…,6}, and |λ| + 2k = 12. The map v ↦ ι_λ(v) ⊗ cup^{⊗k} is linear V_λ → V^{⊗|λ|} ⊗ (V ⊗ V)^{⊗k} = V^{⊗12}. Viewing cup as ℝ → V ⊗ V, this map equals (id_{V^{⊗|λ|}} ⊗ cup^{⊗k}) ∘ ι_λ, which is Passage A's and E's "composite of ι_λ with k cups". The two descriptions are the same map. A different placement of the cups among the 12 legs differs by a permutation of tensor factors, which is invertible and O(n)-equivariant, so every property below survives the choice.

**Candidate 2.1, H2 is unstated in A and B.**
1. Locate: B line 91, "Provided λ is O(n)-admissible, i.e. λ'_1+λ'_2 ≤ n, the map c_0:=ι_λ⊗cup^{⊗k} is O(n)-equivariant V_λ→V^{⊗12}", and A line 116, which restricts λ by admissibility only.
2. Exhibit: λ = (1) at n = 1 has λ'_1 + λ'_2 = 1 + 0 = 1 ≤ 1, so it is admissible, and k = 11/2. λ = (13) at n = 2 has λ'_1 + λ'_2 = 2 ≤ 2 and k = −1/2. In neither case is cup^{⊗k} defined.
3. Opposite: the section is about blocks of V^{⊗12}, and at every n the O(n)-labels occurring in V^{⊗12} have |λ| ∈ {12, 10, …, 0} (Brauer–Schur–Weyl, unfiled). E says "for a block λ of the sextic invariants" and D fixes the range. So the hypothesis is supplied by context, and under that reading the lemma is well posed. **Retained as a hypothesis correction to A and B**: the statement should read "for |λ| ∈ {0,2,…,12}", or "for a block λ".

## 3. Equivariance for the full O(n) (attack item 3)

**Finding: CONFIRMED.**

**Derivation.** For g ∈ O(n), (g ⊗ g) cup = Σ_a (g e_a) ⊗ (g e_a) = Σ_{b,c} (Σ_a g_{ba} g_{ca}) e_b ⊗ e_c = Σ_{b,c} (g gᵀ)_{bc} e_b ⊗ e_c = Σ_b e_b ⊗ e_b = cup. Only g gᵀ = I is used, so this holds for det g = −1 as well. Hence cup: ℝ → V ⊗ V is equivariant from the trivial module. ι_λ is equivariant by definition (I2). By I4, ι_λ ⊗ cup^{⊗k}: V_λ ⊗ ℝ^{⊗k} → V^{⊗12} is equivariant, and the identification V_λ ≅ V_λ ⊗ ℝ^{⊗k} is equivariant because ℝ carries the trivial action. No finding: the passage's "closure of the tensor product under equivariant maps … for the full O(n), reflection included" is correct as written.

## 4. Nonvanishing (attack item 4)

### 4a. Reason (a)

**Derivation.** Take v ≠ 0 in V_λ (possible since V_λ ≠ 0 by I1 under H1). ι_λ(v) ≠ 0 since ι_λ is injective. For n ≥ 1, cup has the nonzero coefficient 1 on e_1 ⊗ e_1, so cup ≠ 0. By I3, ι_λ(v) ⊗ cup^{⊗k} ≠ 0. So c_0(v) ≠ 0, and in fact c_0 is injective. At k = 0 no cup enters and the claim reduces to ι_λ ≠ 0.

**Candidate 4.1, n = 0.**
1. Locate: B line 91, "Provided λ is O(n)-admissible … the map c_0 … is … nonzero", with Passage C's "At every n" as the range.
2. Exhibit: n = 0, λ = ∅. Admissibility is 0 + 0 ≤ 0, true. O(0) is the trivial group, V_∅ = ℝ, V = 0, cup = Σ over the empty index set = 0, k = 6, and c_0 = cup^{⊗6} is the zero map ℝ → V^{⊗12} = 0.
3. Opposite: n = 0 is conventionally excluded from O(n) acting on ℝ^n, and under E's reading ("a block λ of the sextic invariants") there is no block at n = 0, since V^{⊗12} = 0 there. The failure lives only in B's unrestricted form. **Retained as a hypothesis correction (H3, n ≥ 1) to B's lemma and to "at every n"**, harmless to every application.

### 4b. Reason (b)

**Derivation of the stated identity.** With cap(e_a ⊗ e_b) = δ_{ab}, cap(cup) = Σ_a δ_{aa} = n. Contracting the last 2k legs of c_0(v) pairwise with k caps gives n^k ι_λ(v). For n ≥ 1, n^k ≠ 0, and ι_λ ≠ 0, so c_0 ≠ 0 (this is the abstract lemma typed at [L65Statement.lean:125](../lean/HamiltonsCubic/Results/L65Statement.lean#L125)). The passage states the identity without deriving it and never defines cap. The identity is the one-line algebra above, and nothing hinges on it because reason (a) carries the claim independently. Verdict CONFIRMED AS ALGEBRA. At n = 0 it fails with Candidate 4.1. The Lean comment at [L65Statement.lean:67](../lean/HamiltonsCubic/Results/L65Statement.lean#L67) supports the cap identity by a record check at n = 3,4,5,6. That support is unnecessary, since the identity is exact algebra at every n.

## 5. Membership in M_λ (attack item 5)

**Finding: CONFIRMED.** c_0 is ℝ-linear and O(n)-equivariant from V_λ to V^{⊗12} (§2, §3), so c_0 ∈ Hom_{O(n)}(V_λ, V^{⊗12}) = M_λ. The zero of that Hom space is the zero map, so "nonzero in M_λ" and "nonzero as a map" are the same statement, as written. Passage C part 2 needs "one nonzero seed c_0 per block", and §4 supplies exactly that under H1–H3. No gap between what L65 proves and what C uses.

## 6. Admissibility (attack item 6)

### 6.1 The three witnesses (6a)

(2,2): λ' = (2,2), λ'_1 + λ'_2 = 4 > 3 ≥ 2, so non-admissible at n = 2 and n = 3. (2,1,1): λ' = (3,1), λ'_1 + λ'_2 = 4 > 3, non-admissible at n = 3. **CONFIRMED.** Both witnesses have |λ| = 4 > n, consistent with §6.2.

### 6.2 "At n = 12 it holds for all 71 blocks" (6c) and whether admissibility can fail where the lemma is applied

The passage gives no argument. The argument is on file in [L65.lean:43](../lean/HamiltonsCubic/Results/L65.lean#L43) (conj_le_size): a part of size p adds 1 to λ'_1 when p ≥ 1 and 1 to λ'_2 when p ≥ 2, so λ'_1 + λ'_2 = Σ_i min(λ_i, 2) ≤ |λ|. I read the induction: the three cases p = 0, p = 1, p ≥ 2 charge 0, 1, 2 against p, which is correct. Hence |λ| ≤ n implies admissible ([L65.lean:67](../lean/HamiltonsCubic/Results/L65.lean#L67)), and at n = 12 every λ with |λ| ≤ 12 is admissible. **CONFIRMED, for every such λ, so the count 71 is not used.**

Where can admissibility fail for a λ the lemma is applied to? At a fixed n, a block of V^{⊗12} is an O(n)-irreducible that occurs, hence has an admissible label, so for blocks at their own n the hypothesis is automatic. It can fail only for a label carried to a smaller n, e.g. λ = (2,2,2,2,2,2) at any n ≤ 11 (λ'_1 + λ'_2 = 12 > n). Note that |λ| > n does not force failure: λ = (4,4) at n = 4 has λ'_1 + λ'_2 = 2 + 2 = 4 ≤ 4.

### 6.3 Withdrawn candidate: "Without it V_λ = 0 and ι_λ does not exist" (6b)

1. Locate: B line 93, and A line 116, "Without admissibility V_λ=0 and ι_λ does not exist".
2. Exhibit: the two conjuncts cannot both hold literally in one model. Under the brief's definition V_λ is defined only for admissible λ, so "V_λ = 0" is an assignment, not a fact. Under Weyl's model, λ = (2,2) at n = 3 gives V_λ = 0 (I2), and then ι_λ: 0 → V^{⊗4} is the zero map, which exists.
3. Opposite: the intended content is "no nonzero seed exists", which is true under Weyl's model (every linear map out of 0 is 0, typed at [L65Statement.lean:146](../lean/HamiltonsCubic/Results/L65Statement.lean#L146)) and is what "load-bearing" needs: dropping H1, the conclusion "nonzero" fails. **Withdrawn**: the charitable reading is natural and true. Wording only.

### 6.4 Tightness (6d)

λ = (2,2,2,2,2,2): λ' = (6,6), λ'_1 + λ'_2 = 12 = n at n = 12, and |λ| = 12. **CONFIRMED AS ALGEBRA.** "Tight" as a statement about the blocks needs (2,2,2,2,2,2) to be one of the 71 O(12) blocks. The passages give no argument for that membership, so it is HYPOTHESIS-DEBT, and the lemma does not use it.

### 6.5 The counts (6e)

71 O(12) labels, 16 blocks with |λ| = 12, 17 of 184 multiplicities, 19 SO(12) labels with 3 chiral pairs: no argument appears in the quoted passages. **HYPOTHESIS-DEBT**, discharged by exhibiting the O(12)-decomposition of Sym^3(Weyl_12) with multiplicities. The internal arithmetic 16 + 3 = 19 is consistent (each O(12) label with λ'_1 = 6 splits into two SO(12) labels). None of these numbers enters the proof of L65.

## 7. "The seed is a diagram" (attack item 7)

**Finding: REFUTED AS STATED.**

1. **Locate.** A line 112, "Lemma L65, the seed is a diagram, under admissibility", B line 86, "The seed is itself a diagram", and E line 226, "The seed is a diagram, under admissibility", with E line 771 "(one seed per block, given by a diagram)".
2. **Exhibit.** c_0 has domain V_λ, while a Brauer diagram acts as a map between tensor powers of V. c_0 = (id ⊗ cup^{⊗k}) ∘ ι_λ is a diagram composed with ι_λ, and ι_λ is a diagram only when V_λ is a tensor power, i.e. λ = ∅, where c_0 = cup^{⊗6} is the six-cup diagram ℝ → V^{⊗12}. At |λ| = 12, e.g. λ = (12) at n = 2, c_0 = ι_λ is the inclusion of the 2-dimensional span of Re and Im of (e_1 + i e_2)^{⊗12}, with the identity as its "diagram" part. B's own closing remark concedes this: "a padding diagram only where k>0 … the content there is that an inclusion is nonzero".
3. **Opposite.** Read as shorthand for "the seed is ι_λ followed by a diagram", the heading holds at every block, with the identity diagram at k = 0. That reading matches the statement body in A and E ("the composite of ι_λ with k cups"), which is correct. But it is not what the heading says, and the record itself treats the heading as failing at the 16 blocks with |λ| = 12 ([L65.lean:109](../lean/HamiltonsCubic/Results/L65.lean#L109)). The body is CONFIRMED, the name is not. The counts 16 and 17 of 184 are HYPOTHESIS-DEBT (§6.5) and do not affect this: the heading fails literally at every λ ≠ ∅, whatever the count.

## 8. The canon, Passage E (attack item 8)

- **Scope.** E fixes no n and says "admissible for O(n)". The argument in §2–§5 holds at every n ≥ 1 for |λ| ∈ {0,2,…,12}, so the canon is dimension-free, with H3 as the one boundary (§4, Candidate 4.1, which E's "block" excludes). The 12 is a leg count, three Weyl tensors of four legs. No finding on scope.
- **Stated against proven.** E and A say what the seed is but omit the two properties that make it a seed, "O(n)-equivariant" and "nonzero", which are B's content and C's input. The statement is weaker in form than what is proven and used. **Correction recorded**: the numbered statement should carry "is a nonzero element of M_λ".
- **"No search", "in closed form".** Relative to ι_λ, c_0 is explicit. At the |λ| = 12 blocks, c_0 = ι_λ, so finding the seed is literally finding a nonzero element of Hom_{O(n)}(V_λ, V^{⊗12}), which is the construction problem B's first paragraph set out to remove. It is removed only by Weyl's explicit construction (I2), unfiled. The claim stands on that classical import and is recorded as such.
- **"The lemma removes a search from the certificate pipeline and adds no certificate."** A description of the lemma's role in a process, with no mathematical content to check. No finding.

## 9. The Lean files (attack item 9, standing item 5)

[L65Statement.lean](../lean/HamiltonsCubic/Results/L65Statement.lean) types, for an arbitrary group G and ℝ-modules: tprod_map_equivariant (two-factor tensor product of equivariant maps is equivariant), seed_ne_zero (cap ∘ c0 = nk • ι with nk ≠ 0 and ι ≠ 0 forces c0 ≠ 0, the cap identity entering as the hypothesis hcap), no_seed_of_trivial (maps out of a subsingleton are zero), the leg arithmetic 2k + f = 12 and k = 0 ↔ f = 12, the three witnesses and the tightness arithmetic, and two non-vacuity examples. Its own docstring (lines 56–70) says V_λ, ι_λ, cup, O(n) and c_0 are not constructed and that "λ admissible implies V_λ ≠ 0" is not typed.

[L65.lean](../lean/HamiltonsCubic/Results/L65.lean) types partition arithmetic only: conj_le_size, admissible_of_size_le, admissible_in_range, tightness, the witnesses, and 16·4 < 71 < 16·5.

**Finding: neither file states L65.** No object of either file is O(n), V_λ, ι_λ, cup, c_0 or M_λ, so the lemma's conclusion is nowhere a Lean proposition. What is typed matches the abstract ingredients and is correct on reading (CONFIRMED AS ALGEBRA). Two notes: tprod_map_equivariant is two-factor, while c_0 needs k + 1 factors and the unitor, a routine iteration that is not typed. The docstring at [L65.lean:17](../lean/HamiltonsCubic/Results/L65.lean#L17) quotes "cannot fail in the programme's range", which does not appear in the passages quoted in the brief. I did not chase it.

## 10. Standing items

### 10.1 Hypothesis inventory (standing item 1)

See the inventory above. Used but unstated: H2 (|λ| ≤ 12, even) and H3 (n ≥ 1) in A and B, and the choice H4. All hypotheses are satisfiable. Imports I1 and I2 are unfiled and classical, and their exact needed form is stated in the table.

### 10.2 Quantifiers and scope (standing item 2)

n is fixed first, then λ ranges over O(n)-admissible partitions with |λ| ∈ {0,2,…,12}, then ι_λ is chosen. The group is the full O(n) throughout, and c_0 ∈ Hom_{O(n)}, which is finer than Hom_{SO(n)}. No finding on the order. The "71 blocks" are O(12) labels, and the lemma at other n applies to that n's own labels.

### 10.3 Edges (standing item 3)

| Edge | Exact value | Result |
|---|---|---|
| λ = ∅ | V_∅ = ℝ, ι_∅ = id, k = 6, c_0 = cup^{⊗6} | Nonzero at n ≥ 1, zero at n = 0 (Candidate 4.1). The one λ at which the seed is literally a diagram. |
| \|λ\| = 12 | k = 0, c_0 = ι_λ | Nonzero iff V_λ ≠ 0, i.e. rests entirely on I1, I2. Both "reasons" degenerate to ι_λ ≠ 0. |
| n = 1 | O(1) = {±1}, only ∅ has even size among admissible λ | c_0 = (e_1 ⊗ e_1)^{⊗6} ≠ 0. Holds. |
| n below \|λ\| | λ = (12) at n = 2: λ'_1 + λ'_2 = 2 ≤ 2, V_λ 2-dimensional. λ = (4,4) at n = 4: admissible. λ = (2,2,2,2,2,2) at n = 11: not admissible. | Lemma holds where admissible, excluded otherwise. |
| Non-admissible λ | (2,2) at n = 2, 3, (2,1,1) at n = 3 | Excluded by H1, §6.3. |
| \|λ\| odd or > 12 | (1) at n = 1, (13) at n = 2 | c_0 undefined, Candidate 2.1. |

### 10.4 Proven against stated and used (standing item 4)

Proven (B): c_0 is a nonzero element of M_λ, at n ≥ 1, |λ| ∈ {0,2,…,12}, λ admissible. Used (C part 2): a nonzero element of M_λ per block. These match. Stated (A, E): the seed is the composite, with the properties omitted (§8). Stated in the headings: "is a diagram", which overclaims (§7).

### 10.5 Lean (standing item 5)

§9: neither file states the lemma.

### 10.6 Attack items (standing item 6)

Items 1–10 of the brief are §1, §2, §3, §4, §5, §6, §7, §8, §9 and §10.3 respectively.

### 10.7 Falsifiers and the search (standing item 7)

| Claim | Falsifying object | What I did |
|---|---|---|
| Equivariance | g ∈ O(n) with (g ⊗ g) cup ≠ cup | Derived (g ⊗ g) cup = cup from g gᵀ = I, reflections included. None exists. |
| Nonvanishing | An admissible λ, n, with c_0 = 0 | Reason (a) forces c_0 injective for n ≥ 1. Exhibited n = 0, λ = ∅ as the only failure class (cup = 0 needs n = 0). |
| Well-definedness | λ admissible with k ∉ ℕ | Exhibited λ = (1) at n = 1 and (13) at n = 2, excluded by context (Candidate 2.1). |
| "Holds for all 71 blocks" | λ with \|λ\| ≤ 12 non-admissible at n = 12 | Impossible by λ'_1 + λ'_2 ≤ \|λ\| (L65.lean argument, read). |
| Tightness | (2,2,2,2,2,2) with λ'_1 + λ'_2 ≠ 12, or absent from the blocks | Arithmetic confirmed. Membership unverified, recorded as debt. |
| Witnesses | Any of the three admissible at its n | Computed λ' exactly. All three fail. |
| Pointer | Argument for L65 inside lines 40–50 | Read lines 40–50: no ι_λ, cup or k. Located at line 86 onwards. |
| "Is a diagram" | A block where the seed is not a diagram | Every λ ≠ ∅, e.g. λ = (12) at n = 2. |
| Lean states L65 | A Lean proposition mentioning O(n), V_λ, c_0 | Read both files in full. None exists. |

## Corrections that close the round

1. Passage A's pointer should name "The seed is itself a diagram" (§1).
2. A and B should state |λ| ∈ {0,2,…,12} (or "λ a block") and n ≥ 1 (§2, §4).
3. A and E should state that c_0 is O(n)-equivariant and nonzero, i.e. a nonzero element of M_λ (§8).
4. The name "the seed is a diagram" should read as "the seed is ι_λ followed by a padding diagram" (§7).
5. The counts 71, 16, 17 of 184, 19, and the membership of (2,2,2,2,2,2) among the blocks carry no argument in the passages and are not used (§6.5).

## Overall verdict

**PROVEN (hypotheses corrected).** The argument in Passage B is correct link by link under H1 (admissible), H2 (|λ| ∈ {0,2,…,12}) and H3 (n ≥ 1), resting on the unfiled classical imports I1 and I2 for V_λ ≠ 0 and the existence of ι_λ. The defects are in the statement's hypotheses, its pointer and its name, and none reaches the mathematics that Passage C consumes.
