# Verifier v262, L63: dim W_12 = 1638 and its label, the n = 12 census 77/191, the fusion to 71/184, the sum identity, and Passage D's stability argument

The brief was read cold. No numerical work was done: no scripts were written and no programs were run, Lean included. Every value below is exact and was computed by hand. Log: [agent_logs/verify-L63-v262.log](../agent_logs/verify-L63-v262.log).

| # | claim | verdict |
|---|---|---|
| 1 | dim W_12 = 1638, by the Weyl-tensor closed form and by Weyl's dimension formula for D_6 at (2,2,0,0,0,0) | CONFIRMED |
| 2 | W_12 is the D_6 irreducible of highest weight (2,2,0,0,0,0) | HYPOTHESIS-DEBT |
| 3 | Sym^3(W_12) has 77 SO(12) constituents, 191 multiplicities, twelve chiral in six pairs at 2,1,1,1,1,1 | HYPOTHESIS-DEBT |
| 4 | an orientation-reversing element fuses each chiral pair, so 77 to 71 blocks and 191 to 184 multiplicities | CONFIRMED AS ALGEBRA |
| 5a | C(1640,3) = 733 813 080 = dim Sym^3(W_12) | CONFIRMED |
| 5b | the recorded table satisfies sum m_λ d_λ = C(1640,3) | HYPOTHESIS-DEBT |
| 6a | Passage D: the O(n) table of Sym^3(W_n) is the same for every n >= 12 | CONFIRMED AS ALGEBRA |
| 6b | Passage D: n = 12 is exactly where that begins (the table moves at n = 11) | HYPOTHESIS-DEBT |
| 7 | Passage D: at n = 10 "λ and its associate become the same O(10) irreducible" | REFUTED AS STATED |
| 8 | Passage E states the claim | GAP |

**Summary.** The dimension and every piece of arithmetic check out, but the census has no argument on file, and the canon's "Lemma L63 (direct)" label claims more than has been proven. Passage D proves a different statement (stability for n >= 12), and its n = 10 mechanism sentence is false for O(10).

## 0. Conventions, fixed once

- W_n is the space of algebraic Weyl tensors on R^n. Dimensions are complex dimensions of the complexification (they equal the real dimensions).
- D_6 weights are written in orthogonal coordinates (λ_1,...,λ_6), with ρ = (5,4,3,2,1,0). A constituent is chiral when λ_6 ≠ 0.
- λ' is the conjugate partition, so λ'_1 is the number of rows and λ'_2 is the number of parts of size at least 2. An O(n) label is admissible when λ'_1 + λ'_2 <= n.
- The associate of an admissible label λ at O(n) is λ*. It is λ with its first column replaced by one of length n - λ'_1.
- A block of O(12) is an O(12)-isotypic component. A constituent of SO(12) is an SO(12)-isotypic component.
- Sources cited by line: [findings/sym3-stability.md](../findings/sym3-stability.md) lines 3-36, 44 and 58; [results.md](../results.md) lines 222, 757 and 759; [L63Statement.lean](../lean/HamiltonsCubic/Results/L63Statement.lean); [Sym3Threshold.lean](../lean/HamiltonsCubic/Results/Sym3Threshold.lean); [htw-math0311159.txt](https://arxiv.org/abs/math/0311159).
- Quotation check. Passages A, B and C match their source lines character for character. Passage D matches lines 3-36 exactly (checked by diff). Passage E matches the Lean file, which has 160 lines. The brief's "161" comes from a trailing blank line inside its code fence (no finding).

## 1. Hypothesis inventory

### 1.1 Hypotheses of the statement (Passages A, B, C)

- n = 12 throughout. Every figure in A, B and C is stated at this single dimension.
- W_12 is SO(12)-irreducible with highest weight (2,2,0,0,0,0). This is stated, and its use is to name the object.
- The census figures 77, 191 and the six chiral pairs at 2,1,1,1,1,1 are stated as facts, and they are the inputs to the fusion.
- **Used but unstated in A and C: no non-chiral SO(12) constituent V_μ carries both [μ] and [μ*] as O(12)-modules.** Without this, an SO(12) constituent could be two O(12) blocks, and the step from 77 to 71 would fail (see §4).

### 1.2 Imported theorems

| import | hypotheses | used where | filed? |
|---|---|---|---|
| O(n) labelling: irreducibles indexed uniquely by ν with ν'_1 + ν'_2 <= n | rational representations of O_n over C | D step 2, and uniqueness in §7 | **Filed.** [htw-math0311159.txt](https://arxiv.org/abs/math/0311159) lines 86-89, citing Goodman–Wallach Ch. 10: "each irreducible rational representation is indexed uniquely by a non-negative integer partition ν such that (ν′)1 + (ν′)2 ≤ n" |
| Newell–Littlewood product rule | the product in the universal character ring, or the stable range at finite n | D step 1 (row count <= sum of inputs, and the unstated weight bound) | Unfiled. HTW line 251 names Newell and Littlewood as the origin of branching rules and gives no statement |
| Littlewood's modification rules (Newell, King) | labels with λ'_1 + λ'_2 > n | D step 2 and the n = 10 section | Unfiled. HTW lines 281 and 290 mention that the rules exist and give no statement |
| Koike–Terada specialisation Λ → R(O(n)) | ring homomorphism, o_λ goes to [λ] for admissible λ | D step 4 | Unfiled. HTW line 1678 (bibliography) and [sii-2511.14463.txt](https://arxiv.org/abs/2511.14463) line 2251 (bibliography) only. The clause "commuting with Sym^3" (compatibility with plethysm) is nowhere stated on file |
| Weyl's dimension formula for D_6 | λ dominant, ρ = (5,4,3,2,1,0), dim = product over i<j of (ℓ_i^2 - ℓ_j^2)/(ρ_i^2 - ρ_j^2) with ℓ = λ + ρ | E, second closed form | Unfiled |
| Restriction O(2ℓ) to SO(2ℓ): [λ] splits into two exactly when λ'_1 = ℓ | even n | fusion (A, C) and the 77 versus 71 count (D) | Unfiled. HTW lines 93-95 point to Goodman–Wallach 5.2.2 without stating it |
| dim W_n = n(n+1)(n+2)(n-3)/12 | n >= 3 | E, first closed form | Unfiled (a classical count, stated without source) |
| W_n ⊗ C is the O(n)-irreducible labelled (2,2) | n >= 4 | D step 1, and the label in A | Unfiled. Asserted in D step 1 without source |

### 1.3 Used but unstated in Passage D

- **Sym^3(W_n) is a submodule of the tensor cube.** Step 1 applies a tensor-product rule to a plethysm, and the inclusion is what licenses that.
- **Every constituent has weight |λ| <= 12.** Step 3's "at total weight 12" needs this. A six-row label with λ'_2 = 6 has weight at least 12, and only this bound brings it down to exactly 12.
- **The label (2,2,2,2,2,2) has nonzero stable multiplicity.** Sharpness at 12 needs this, and D reports it from a run ("with multiplicity 1").

## 2. Quantifier order and scope

- **At n = 12 only:** every figure in A, B and C, meaning 1638, 77, 191, the pairs at 2,1,1,1,1,1, 71, 184 and C(1640,3).
- **For all n >= 12:** D's "the same for every n >= 12". This is a statement about O(n) label tables and says nothing about their values.
- **At n = 10, 11, 13, 14, 16, 18:** the rows of D's verification table. All of them are run outputs.
- **The link between the two scopes.** Passage C's "the threshold dimension" joins them. The figures at n = 12 hold for every n >= 12 only through 6a.

## 3. Edges of the range

- **n = 13.** Every stable label has at most 6 rows. An associate λ* at n = 13 has 13 - λ'_1 >= 7 rows, so no label meets its associate. SO(13) and O(13) counts then agree, which is consistent with D's "n = 13 → 71/184". That figure is a run output.
- **n = 12.** λ* has 12 - λ'_1 rows. That is at least 7 unless λ'_1 = 6, and then λ* = λ. So the six-row labels are exactly the self-associate labels at ℓ = n/2 = 6. They are the ones that split under SO(12), and no two distinct labels merge. This is consistent with the count going from 77 to 71 (unfiled restriction rule, §1.2).
- **n = 11.** The label (2,2,2,2,2,2) has λ'_1 + λ'_2 = 12 > 11, so it is inadmissible. By D step 3 every other label has column sum <= 11, and that step is correct (§6).
  - All stable labels have even weight, while |λ*| = |λ| + 11 - 2λ'_1 is odd. So no associate pair meets at odd n.
  - D's "n = 11 → 70/183" fits the one label dropping out, but the figure is a run output.
- **n = 10.** The associate sentence is REFUTED AS STATED (§7).
- **Self-associate labels.** At n = 12 these are exactly the six-row labels, as shown above. D's "the self-associate boundary labels are present as full O(12) irreducibles" is consistent with the restriction rule.
- **Pinning the boundary with the Weyl tensor (D, verification section).** dim W_3 = 3·4·5·0/12 = 0, and (2,2) has column sum 4 = n + 1 there. dim W_4 = 4·5·6·1/12 = 10, with column sum 4 = n.
  - Both values are exact and consistent with the inclusive condition.
  - This checks one label and does not prove the general condition. The general condition is the filed HTW statement.

## 4. Claims

### 4.1 Claim 1: dim W_12 = 1638. CONFIRMED

- **First closed form.** 12·13·14·9/12 = 13·14·9 = 1638.
- **Consistency of the first closed form with the standard count.** The algebraic curvature tensors have dimension n^2(n^2-1)/12 = 144·143/12 = 1716. The symmetric 2-tensors have dimension n(n+1)/2 = 78, and 1716 - 78 = 1638. In general, n^2(n^2-1)/12 - n(n+1)/2 = n(n+1)(n^2 - n - 6)/12 = n(n+1)(n-3)(n+2)/12. This is a consistency check on the formula. The identification of W_n with the kernel is an unfiled import.
- **Second closed form (Weyl's formula for D_6).**
  - ℓ = λ + ρ = (7,6,3,2,1,0), so ℓ^2 = (49,36,9,4,1,0). Also ρ^2 = (25,16,9,4,1,0).
  - Factors whose indices are both in {3,4,5,6} are identical in the numerator and the denominator.
  - Pair (1,2): 13/9.
  - Pairs (1,j), j = 3..6: (40/16)(45/21)(48/24)(49/25) = (5/2)(15/7)(2)(49/25) = 7350/350 = 21.
  - Pairs (2,j), j = 3..6: (27/7)(32/12)(35/15)(36/16) = (945/105)(1152/192) = 9·6 = 54.
  - Product: (13/9)·21·54 = 13·21·6 = 1638.
- **The Lean encoding matches.** [wdim](../lean/HamiltonsCubic/Results/L63Statement.lean#L65) is exactly this product with the numerator and denominator kept separate, and (7,6,3,2,1,0) = λ + ρ.
- **Label earned.** The value is correct by two independent routes, and both routes are classical formulas whose sources are unfiled. The claim earns Lemma.

### 4.2 Claim 2: highest weight (2,2,0,0,0,0). HYPOTHESIS-DEBT

- **What is on file.**
  - D step 1 asserts "W_n is the O(n)-irreducible labelled by the partition (2,2)" with no source.
  - E's docstring on [wdim_D6_two_two](../lean/HamiltonsCubic/Results/L63Statement.lean#L72) says the second closed form "is what pins the label".
- **Candidate: dimension agreement pins the label.** The three-step record follows.
  1. **Location.** L63Statement.lean line 72: "Second closed form, and the one that pins the label."
  2. **Failure.** dim W_12 = dim V_(2,2,0,0,0,0) is necessary for W_12 ≅ V_(2,2,0,0,0,0) but not sufficient. Distinct D_6 irreducibles can share a dimension. For example, V_(1,1,1,1,1,1) and V_(1,1,1,1,1,-1) both have dimension C(12,6)/2 = 462, being the self-dual and anti-self-dual parts of Λ^6 C^12. The Lean theorem proves an integer identity and never mentions W_12.
  3. **Charitable reading.** "Pins" could mean "corroborates the classical identification": W_n ⊗ C is the traceless part of the (2,2) Schur functor, and since (2,2) has λ'_1 = 2 < 6 it restricts irreducibly to SO(12) with highest weight 2ε_1 + 2ε_2. Under that reading the label is correct, but it rests on two unfiled imports (W_n ⊗ C ≅ [2,2]_n, and the O(12) to SO(12) restriction rule), with no argument on file.
- **Result.** The candidate survives as an overclaim in the Lean docstring. The claim itself earns HYPOTHESIS-DEBT.
- **What would have to be proved or cited.** (i) W_n ⊗ C ≅ [2,2]_n as an O(n)-module for n >= 5. (ii) A label with λ'_1 < n/2 restricts irreducibly to SO(n) with highest weight λ. Citing Goodman–Wallach 10.2 and 5.2.2 at source would discharge both.

### 4.3 Claim 3: the census. HYPOTHESIS-DEBT

- **No passage derives it.**
  - A and C state it.
  - D's argument proves stability (§6) and yields no value.
  - D's verification table reports it as the output of "Weyl character formula, block by block | n=12→77/191 (SO)", which is a reviewer run, with [run_n12_stability.py](../scripts/runs/run_n12_stability.py) as the pointer.
  - E says so itself: "rests on a decomposition run with no argument on the record, so it is an Observation at n = 12" (L63Statement.lean lines 15-18).
- **Label earned: Observation at n = 12.** The canon labels it otherwise: B heads it "Lemma L63 (direct)" (results.md line 222) and C heads it "Lemma L63" (results.md line 757). The canon's label is not earned for the census half.
- **Internal consistency, a screen and not evidence.**
  - 77 = 65 + 12 and 191 = 177 + 14, with the six pairs carrying 7 per side.
  - D reports (2,2,2,2,2,2) at multiplicity 1, which is one of the six. Its λ'_1 = 6 matches "chiral".
  - The multiplicity list agrees with the sum 7 whichever label carries the 2. E mentions an ordering discrepancy between two lists in the findings file. It sits in lines this verifier was barred from reading, so it was not checked.

### 4.4 Claim 4: the fusion. CONFIRMED AS ALGEBRA

- **Derivation, given the census and the unfiled restriction rule (§1.2).**
  - The restriction of [λ] from O(12) to SO(12) is irreducible when λ'_1 < 6. When λ'_1 = 6 it is V_+ ⊕ V_-, with the two exchanged by any orientation-reversing element.
  - An O(12)-block [λ] of multiplicity m with λ'_1 = 6 therefore gives two SO(12) constituents of multiplicity m each, and these are fused back into one block.
  - Six pairs: 77 - 6 = 71 blocks.
  - Multiplicities: 191 - 2·7 + 7 = 184.
- **Hypothesis the step needs and A and C leave unstated.**
  - A non-chiral SO(12) constituent V_μ is one O(12) block only if its isotypic component is [μ]^a with no [μ*]^b summand. Both restrict to V_μ, so a, b > 0 would make one SO(12) constituent into two O(12) blocks.
  - This case cannot occur. μ* has 12 - μ'_1 >= 7 rows when μ'_1 < 6, while by D step 1 every O(12) label that occurs has at most 6 rows. So the hypothesis is discharged, conditional on the unfiled Newell–Littlewood and Koike–Terada imports.
- **Direction.** The arithmetic runs correctly from SO(12) to O(12), as A states it.
- **Verdict.** CONFIRMED AS ALGEBRA, given the census.

### 4.5 Claims 5a and 5b: sum m_λ d_λ = C(1640,3)

- **5a, CONFIRMED.** Sym^3 of a d-dimensional space has dimension C(d+2,3), and d = 1638.
  - C(1640,3) = 1640·1639·1638/6 = 820·1639·546.
  - 820·546 = 447 720.
  - 447 720·1639 = 716 352 000 + 17 461 080 = 733 813 080.
- **5b, HYPOTHESIS-DEBT.** For the true decomposition the identity holds automatically. For the recorded table it is a check that nobody on file carried out.
  - None of A, B or C lists the d_λ, and none sums them.
  - D's row "holds at n=12,13,14,16,18" is a run output.
  - E types only 5a ([symCube_dim](../lean/HamiltonsCubic/Results/L63Statement.lean#L87)).
- **What it does to the census.** The identity is invariant under any error that preserves dimension, so even when checked it would not confirm 77/191.

## 5. Passage E against the claim (standing item 5, brief item 8). GAP

- **What is typed.** Every theorem is an identity between literal integers, or an arithmetic function evaluated at literals:
  - [weylDim_twelve](../lean/HamiltonsCubic/Results/L63Statement.lean#L60), [wdim_D6_two_two](../lean/HamiltonsCubic/Results/L63Statement.lean#L74) and [closed_forms_agree](../lean/HamiltonsCubic/Results/L63Statement.lean#L77)
  - [symCube_dim](../lean/HamiltonsCubic/Results/L63Statement.lean#L87)
  - [blocks_fused](../lean/HamiltonsCubic/Results/L63Statement.lean#L111), [mults_fused](../lean/HamiltonsCubic/Results/L63Statement.lean#L115) and [fusion_chain](../lean/HamiltonsCubic/Results/L63Statement.lean#L122)
  - [ten_corroboration](../lean/HamiltonsCubic/Results/L63Statement.lean#L134)
  - [L63_dimension](../lean/HamiltonsCubic/Results/L63Statement.lean#L145) and [L63_fusion](../lean/HamiltonsCubic/Results/L63Statement.lean#L154).
- **What is not typed.**
  - Neither "weylDim n is the dimension of W_n" nor "wdim(λ+ρ)/wdim(ρ) is the dimension of V_λ" is a Lean proposition. Both are names attached by docstrings.
  - L63_dimension is therefore "1638 equals two integer expressions". It is not "dim W_12 = 1638".
  - L63_fusion reads the figures 77, 191 and 7 as literals, which the file says openly.
- **Each typed statement is correct as arithmetic, checked by hand in §4.** 12·13·14·9 = 19 656 and 19 656/12 = 1638 exactly, so ℕ-division truncates nothing. 191 - 14 + 7 = 184 with no ℕ-subtraction underflow. The file was not compiled, since running Lean is outside this loop.
- **Label.** E grades the dimension as Lemma and the census as Observation at n = 12. This matches §4 of this report and **does not match the canon**: B says "Lemma L63 (direct)" and C's heading says "Lemma L63", with no split. The mismatch is between E and B/C, and E is the more accurate of the two.
- **Verdict.** GAP. E does not state L63. It states the arithmetic around L63, and the representation-theoretic content (what W_12 is, its label, the census, the fusion) has no Lean proposition.
- **The overclaim "pins the label".** This is recorded under §4.2.
- **"There is no proposition to write".** Recorded as a withdrawn candidate, §8.2.

## 6. Passage D against Passage A (brief items 5 and 6)

### 6.1 What D proves: 6a, CONFIRMED AS ALGEBRA

- **Step 1.** Take the unfiled Newell–Littlewood rule in the universal ring together with the inclusion Sym^3 ⊂ ⊗^3 (§1.3). Every constituent then has at most 2 + 2 + 2 = 6 rows. The rule's terms have weight |μ| + |ν| - 2|α|, which also gives the unstated bound |λ| <= 12.
- **Step 2.** Filed at source (HTW lines 86-89) and quoted exactly. "Boundary inclusive" matches "≤ n".
- **Step 3.** The paper argument is correct. λ'_2 <= λ'_1 <= 6 gives a column sum of at most 12.
  - Equality forces six parts, each at least 2, so the weight is at least 12. With |λ| <= 12, every part is 2, and (2,2,2,2,2,2) is the only partition attaining the bound.
  - Every other partition with at most 6 rows and weight at most 12 then has column sum at most 11.
  - The attainment ("attained ... with multiplicity 1") is a census fact, not part of this argument.
- **Step 4.** Suppose the unfiled Koike–Terada specialisation π_n is a ring homomorphism compatible with Sym^3 and sends o_λ to [λ] for admissible λ. Then the stable identity Sym^3(o_(2,2)) = sum m_λ o_λ gives Sym^3([2,2]_n) = sum m_λ [λ]_n for every n >= 12, since every λ is admissible there.
  - Filed HTW uniqueness makes distinct labels distinct irreducibles, so the multiplicities do not merge.
  - The compatibility with Sym^3 is asserted in D and stated nowhere on file.
- **Result.** For n >= 12 the O(n) label table does not depend on n. The chain is correct given the imports, which are unfiled.

### 6.2 6b: sharpness at n = 12, HYPOTHESIS-DEBT

- **Conditional result.** If (2,2,2,2,2,2) has nonzero stable multiplicity, the O(11) table cannot contain it (it is inadmissible at 11), so the table moves at n = 11.
- **What remains unproven.** The nonzero multiplicity is reported from a run. The claim that it occurs has no argument on file, and that claim is what would have to be proved.

### 6.3 D against A

- **D proves none of A's figures.** It proves 6a, a different statement.
- **What D's numbers rest on.** Its 71/184/477 and 64/182/493, and every row of its verification table, rest on runs by reviewers r224 and r225.
- **What D supplies to A.** The row bound, which is what discharges the unstated hypothesis in §4.4.

### 6.4 Note on [Sym3Threshold.lean](../lean/HamiltonsCubic/Results/Sym3Threshold.lean), which D cites for step 3

- **What the theorem states.** [attaining_label_unique](../lean/HamiltonsCubic/Results/Sym3Threshold.lean#L53) is `{p : ℕ} (hp : 2 ≤ p) (h : 6 * p = 12) : p = 2`. Its hypothesis is that all six parts equal one value p.
- **What its docstring claims.** "With six parts all at least two and total 12, every part is exactly two." That claim is about arbitrary six-tuples, and the case of unequal parts is exactly what needs proof.
- **Result.** The Lean statement is narrower than its docstring, and the paper step (§6.1) is correct. The theorems [column_sum_bound](../lean/HamiltonsCubic/Results/Sym3Threshold.lean#L41) and [others_admissible_earlier](../lean/HamiltonsCubic/Results/Sym3Threshold.lean#L65) are omega facts about naturals given as hypotheses. None of the file's theorems mentions a partition or a representation.
- **Scope.** This bears on D's citation of the file and not on A's figures, so it is recorded here as a fidelity note.

## 7. Claim 7: the n = 10 mechanism sentence. REFUTED AS STATED

1. **Location.** findings/sym3-stability.md, D's section "Why n=10 differs": "five from **associate identification**, where λ and its associate become the same O(10) irreducible". E repeats it as "five associate merges lose 5 blocks and 0 multiplicities" ([ten_corroboration](../lean/HamiltonsCubic/Results/L63Statement.lean#L134) docstring).
2. **Failure, exhibited.**
   - Let λ be admissible at n = 10 with λ'_1 ≠ 5. Then λ* has first column 10 - λ'_1 ≠ λ'_1, so λ* ≠ λ, and λ* is admissible because (10 - λ'_1) + λ'_2 <= 10 exactly when λ is.
   - By the filed HTW uniqueness (lines 86-89), two distinct admissible labels index two non-isomorphic O(10)-irreducibles. So "λ and its associate" are never the same O(10) irreducible unless λ = λ*, which is not a merge of two labels.
   - **Explicit object.** λ = (1^6) and λ* = (1^4), that is Λ^6 C^10 and Λ^4 C^10.
   - The reflection r = diag(-1,1,...,1) has trace C(9,k) - C(9,k-1) on Λ^k.
   - That trace is 126 - 84 = 42 on Λ^4 and 84 - 126 = -42 on Λ^6, so the two O(10)-modules are not isomorphic. They are isomorphic as SO(10)-modules, via the Hodge star.
3. **Charitable reading.**
   - **The reading.** "The same O(10) irreducible" means the same SO(10) irreducible, and an n = 10 "block" is an SO(10)-isotypic component with chiral pairs fused. This reading makes "lose 5 blocks and 0 multiplicities" coherent: merging [λ] and [λ*] adds their multiplicities.
   - **Why the sentence still fails.** Under this reading the sentence is still false as written. The n = 10 counts 64/182/493 then count something other than the O(10) blocks that the same sentence names, and it is a different block notion from A's O(12) blocks.
   - **What it does to the n = 10 figures.** Under an O(10) action these merged components split further into [λ*]^a ⊕ ([λ*] ⊗ det)^b. Refining a block that way cannot increase the unknown count, so the O(10) figures would differ from 64/493 whenever such a merge occurs.
   - **Conclusion.** The candidate survives.
- **Scope.** This does not touch any n = 12 figure of L63.
  - At n = 12 no associate pair meets (§3), so the SO(12) fusion and the O(12) block count agree.
  - It affects D's n = 10 comparison, the "64, 182, 493" in D's first paragraph, and the docstring of ten_corroboration.
- **What would settle the n = 10 figures.** A statement of which group the n = 10 blocks are taken under, and the five merged pairs named.

## 8. Remaining brief items and withdrawn candidates

### 8.1 Brief items not covered above

- **Item 1.** §4.1 and §4.2. The dimension is established by hand through two closed forms whose sources are unfiled. The highest weight rests on an unfiled identification, and the only on-file support is the dimension coincidence.
- **Item 2.** §4.3. No passage derives the census. It rests on a run, so it is an Observation.
- **Item 3.** §4.4.
- **Item 4.** §4.5.
- **Items 5 and 6.** §6.
- **Item 7, Passage C's sentence "the table is the size of the certificate problem at the threshold dimension; it supplies the unknowns and no certificate".**
  - No finding of error.
  - "The certificate problem" and the unknown count are defined in no quoted passage. C itself gives no unknown count, and the 477 appears only in D, with no formula.
  - "At the threshold dimension" agrees with 6a/6b once the threshold is taken to be n = 12.
  - The sentence carries no claim that can be checked beyond "the table is not a certificate", and that part is correct.
- **Item 8.** §5.
- **Item 9.** §3 and §7.

### 8.2 Withdrawn candidates

- **W1. E's "there is no proposition to write" for the census.**
  1. **Location.** L63Statement.lean docstring, "the census cannot be stated here at all, not weakened, not with a sorry: there is no proposition to write".
  2. **Exhibit.** The census has a character form that can be typed as a proposition: an identity of explicit integer Laurent polynomials in x_1..x_6. Take the Weyl alternant A_ρ times the plethystic cube (χ(x)^3 + 3χ(x^2)χ(x) + 2χ(x^3))/6 of the explicit character χ of W_12, and set it equal to sum m_μ A_(μ+ρ).
  3. **Charitable reading.** The file means the census as a statement about SO(12)-modules. The character identity is a different proposition, and it becomes equivalent to the census only through Weyl character theory, which is not formalised. The file's objection concerns stating a module-level fact, and that objection stands. **Withdrawn**, because the charitable reading makes the sentence correct.
- **W2. Sym3Threshold.lean's "Among constituents of Sym³ of a weight-4 label the total is 12".**
  1. **Location.** The module docstring.
  2. **Exhibit.** The contraction terms of the Newell–Littlewood rule give constituents of weight below 12, so the total is at most 12 rather than equal to 12.
  3. **Charitable reading.** The sentence speaks only of the attaining label, and for that label the weight is at least 12 and at most 12, hence exactly 12. **Withdrawn**, because the conclusion stands and D's own wording ("at total weight 12") has the same scope.
- **W3. D's "dim W_4 = 10 = n".**
  1. **Location.** D, verification section.
  2. **Exhibit.** Read literally, "10 = n" at n = 4 is false.
  3. **Charitable reading.** The sentence parallels "where λ'_1+λ'_2 = n+1" in the clause before it, so it means dim W_4 = 10 at column sum 4 = n, and both values are correct (§3). **Withdrawn** as a typo.

## 9. Falsifiers and what was done to look for each (standing item 7)

| claim | falsifying object | search |
|---|---|---|
| 1 | a disagreement between the two closed forms, or a closed form that is not dim W_n | both evaluated by hand, and the first reconciled with 1716 - 78 |
| 2 | a D_6 dominant μ ≠ (2,2,0,0,0,0) with W_12 ≅ V_μ | no search, because any search would be computation. What an argument would need is named in §4.2 |
| 3 | an SO(12) decomposition of Sym^3(W_12) with a count other than 77/191 | none, because a search would be computation, which this loop forbids |
| 4 | a non-chiral V_μ whose isotypic component carries both [μ] and [μ*] | excluded by hand: μ* has at least 7 rows, against the row bound |
| 5a | an arithmetic error in C(1640,3) | recomputed by hand |
| 5b | a table whose sum m d is not C(1640,3) | the table's d_λ are not in the passages, so no search was possible |
| 6a | a stable label with more than 6 rows or column sum above 12 | excluded by D steps 1 and 3 under the unfiled imports |
| 6b | the label (2,2,2,2,2,2) at multiplicity 0 | none, because checking would be computation |
| 7 | two distinct labels λ ≠ λ* equal as O(10)-irreducibles | shown impossible (filed uniqueness), with Λ^4 and Λ^6 of C^10 exhibited |
| 8 | a Lean theorem whose statement mentions W_12 or V_λ | read all 160 lines, and none does |

## Overall verdict: HYPOTHESIS-DEBT

- **What is proven.** The dimension 1638 and all the arithmetic, including the fusion given the census and C(1640,3).
- **HYPOTHESIS-DEBT: the highest-weight label.** There is no argument on file. Only unfiled classical imports and a dimension coincidence support it.
- **HYPOTHESIS-DEBT: the census.** 77/191 and the six chiral pairs rest on a run, so the canon's "Lemma L63 (direct)" label claims more than has been proven. Split it: Lemma for the dimension, Observation at n = 12 for the census, as E already does.
- **Passage D proves a different statement.** It proves stability for n >= 12 (as algebra over unfiled Newell–Littlewood and Koike–Terada), and its sharpness at 12 depends on a run.
- **Passage D's n = 10 associate-identification sentence is false for O(10)** (REFUTED AS STATED).
