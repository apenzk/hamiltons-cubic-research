# Verifier v287, the 24-block table of Sym^3(W_5): weights, multiplicities, dimension column, the four closures, the trivial block and the Lean file (Lemma L83)

The brief was cold: [BRIEF_L83.md](BRIEF_L83.md) only, with each quotation checked against the cited source lines alone. No numerical work was done, every value below is exact and computed by hand at a stated weight, and no script was written or run. The Lean file was read, not built. Log: [agent_logs/verify-L83-v287.log](../agent_logs/verify-L83-v287.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | The lemma's content: the 24 highest weights and the multiplicity column ("The table is right") | HYPOTHESIS-DEBT |
| 2 | "The table is arithmetic on the highest weights ... No linear algebra on the 7770 is involved", as an account of the multiplicities | REFUTED AS STATED |
| 3a | "The reconstruction closes four independent ways" | REFUTED AS STATED |
| 3b | 24 blocks, Σ m_λ d_λ = 7770 = C(37,3), Σ m_λ = 41, Σ m_λ(m_λ+1)/2 = 65, as arithmetic on the printed table | CONFIRMED AS ALGEBRA |
| 4 | The dimension column, all 24 subscripts, Weyl's B_2 formula in the e-basis | CONFIRMED |
| 5a | [2,2] = 2e_1+2e_2 = 4ω_2, both [2,2] and [2,1] of dimension 35, Casimir 16 against 12, Killing value 8/3 | CONFIRMED AS ALGEBRA |
| 5b | W_5 is the irreducible [2,2], and SO(5) labels serve as the O(5) block table | HYPOTHESIS-DEBT |
| 6 | "The trivial multiplicity is 1 here and 2 from n ≥ 6", with the Lovelock reason | HYPOTHESIS-DEBT |
| 7a | Passage C: "Every number re-derives by hand" | HYPOTHESIS-DEBT |
| 7b | Passage C: "one block is closed by an external count of 7770" | GAP |
| 8 | The Lean file checks the dimension column and the sums for a hard-coded table and does not state the lemma | CONFIRMED AS ALGEBRA |
| 9 | Equal-dimension blocks are separated by the Casimir, and the multiplicity-1 dimensions sum to 4125 | CONFIRMED |

Summary: every column that is a function of the labels checks exactly, while the labels and multiplicities, which are the lemma, have no argument on file, and the four closures cannot detect a swap of the multiplicities of (2,2) and (2,1).

**Overall verdict: HYPOTHESIS-DEBT.**

## 0. Conventions, fixed once

- B_2 = so(5) with Cartan coordinates e_1, e_2 orthonormal. Simple roots α_1 = e_1 − e_2 (long) and α_2 = e_2 (short). Positive roots e_1 − e_2, e_2, e_1, e_1 + e_2. Fundamental weights ω_1 = e_1 and ω_2 = (e_1+e_2)/2 (spin). ρ = (3/2, 1/2).
- A label (a,b) in the table means λ = a e_1 + b e_2 with a ≥ b ≥ 0 integers. Passage B does not state this basis. It is fixed by the Casimir formula printed there, by the entry (2,2)_35 for W_5 together with Passage A's "[2,2]=2e_1+2e_2", and it is the basis the Lean file names. All 24 labels satisfy a ≥ b ≥ 0 by inspection.
- Weyl's dimension formula, read at this ρ: d(a,b) = ∏_α ⟨λ+ρ,α⟩/⟨ρ,α⟩ = (a−b+1) · (2b+1) · (2a+3)/3 · (a+b+2)/2 = (2a+3)(2b+1)(a−b+1)(a+b+2)/6, the factors in the order e_1−e_2, e_2, e_1, e_1+e_2.
- Casimir eigenvalue c_2(a,b) = ⟨λ, λ+2ρ⟩ = a(a+3) + b(b+1), which is Passage B's formula. With B(X,Y) = −½ tr(XY) and C = −Σ_{i<j} (E_ij − E_ji)², each (E_ij − E_ji)² = −(E_ii + E_jj) on ℝ^5, so C = 4·Id on the vector representation, matching c_2(1,0) = 4. The normalisation of Passage A and the e-basis form agree.
- "Isotypic block" means an SO(5)-isotypic component unless O(5) is named.
- Checked source lines: [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 3, 7, 9, 13, 15 and 29–42, and [results.md](../results.md) lines 284 and 942. Each matches the brief verbatim.

## Hypothesis inventory

| # | Hypothesis | Where | Used by | Stated | Support on file |
|---|---|---|---|---|---|
| H1 | W_5 is irreducible under SO(5) (and O(5)) with highest weight 2e_1+2e_2, dimension 35 | Passage A, line 7 | every row of the table, since the table decomposes Sym^3 of this module | yes | a run ([run_n5_weyl_module.py](../scripts/runs/run_n5_weyl_module.py), line 9), plus classical and unfiled |
| H2 | Weyl's dimension formula for B_2 at ρ = (3/2,1/2) | Passage B, line 31 | dimension column | yes, by name | classical, unfiled. The exact form in §0 is needed |
| H3 | Casimir eigenvalue ⟨λ,λ+2ρ⟩ with e_i orthonormal | Passages A and B | separation of equal-dimension labels | yes | classical, unfiled |
| H4 | O(5)-isotypic components of Sym^3(W_5) coincide with SO(5)-isotypic ones | Passage A line 3 speaks of O(5), the table uses B_2 labels | reading the table as the O(5) block structure of line 3 | **no** | none |
| H5 | dim Sym^3 of a 35-dimensional space is C(37,3) | Passage C, "external count" | the 7770 closure | implicitly | standard, and exact: 37·36·35/6 = 7770 |
| H6 | Complete reducibility of Sym^3(W_5) under the compact group | line 3 | existence of the block decomposition | no | standard, unfiled |
| H7 | The label basis is the e-basis | Passage B | dimension and Casimir columns | **no** in Passage B, yes in the Lean file | inferred, §0 |
| H8 | The multiplicity m_λ of every λ, and the list of λ with m_λ > 0 | Passage B table | the lemma itself | yes, as a table | a run ([run_casimir_separation.py](../scripts/runs/run_casimir_separation.py), line 31) only |
| H9 | At n ≤ 5, ⟨W^#,W⟩ = 2 tr(W^3), the two contractions span the cubic invariants, tr(W^3) is nonzero on W_5, and the two are independent at n ≥ 6 | Passage B, line 42 | the trivial multiplicity | only the identity is stated | none. W^# is undefined in the quoted passages |

H4, H6 and H7 are used and unstated. H1, H8 and H9 carry no argument on file.

## 1. The weight list and the multiplicity column

**Verdict: HYPOTHESIS-DEBT.**

The lemma (Passage C, line 942) is "The twenty-four blocks of Sym^3(W_5), with their labels and multiplicities", and it asserts "The table is right". The quoted record gives the following support for the label and multiplicity columns:

- Passage B line 31 gives the Weyl formula and c_2. Both take a label as input and return a dimension or an eigenvalue. Neither returns a label or a multiplicity.
- Passage B line 31 cites [run_casimir_separation.py](../scripts/runs/run_casimir_separation.py), a run. Under the brief a statement supported only by a run is HYPOTHESIS-DEBT.
- Passage B line 40 gives four closures. §3 shows they do not determine the multiplicities.
- Passage C concedes "arithmetic on the highest weights is false of the multiplicities" and supplies no replacement argument.

What would have to be proved: the character identity ch Sym^3(V_(2,2)) = Σ_λ m_λ ch V_λ over B_2, with exactly the 24 pairs (λ, m_λ) of the table and m_λ = 0 for every other dominant λ. Together with H1 and H4 this is the lemma.

Falsifier: a dominant weight λ whose multiplicity in Sym^3(V_(2,2)) differs from the table (including a weight absent from it). Producing or excluding one means decomposing Sym^3, which is out of scope, so no search for it was made. §3 exhibits a different table that passes every check on file, which is why the debt is real rather than formal.

## 2. "The table is arithmetic on the highest weights"

**Verdict: REFUTED AS STATED**, as an account of how the multiplicities are obtained. As an account of the dimension and Casimir columns it is correct (§4, §9).

**Candidate F2.**

1. *Location.* [findings/sym3-blocks.md](../findings/sym3-blocks.md) line 31: "The table is arithmetic on the highest weights: the Weyl dimension formula for B_2 is a product of four linear factors, and c_2(λ)=λ_1(λ_1+3)+λ_2(λ_2+1). **No linear algebra on the 7770 is involved.**"
2. *Failure, in closed form.* Let T′ be the table with the multiplicities of (2,2) and (2,1) exchanged: m′(2,2) = 2, m′(2,1) = 4, every other entry unchanged. T and T′ have the same 24 highest weights, the same d column (d(2,2) = d(2,1) = 35) and the same c_2 column. They differ in the multiplicity column, and at most one of them is the decomposition of Sym^3(W_5). So the multiplicity column is not a function of the arithmetic line 31 names. The only arithmetic on file that involves the multiplicities is the four closures of line 40, and T′ passes those too (§3).
3. *Most charitable reading.* "The table" means only its dimension subscripts and the Casimir values, and "No linear algebra on the 7770" is a remark about those columns. This reading fails for two reasons. The table printed under the sentence has the multiplicity column as its first column. Also, the record's own canonical text (results.md line 942) reads the sentence as a claim about the multiplicities: "arithmetic on the highest weights is false of the multiplicities". Under the charitable reading the sentence would be true and would leave the multiplicities with no stated method at all (§1). The candidate survives.

"No linear algebra on the 7770 is involved" taken alone is not refuted. A character computation would avoid linear algebra on the 7770-dimensional space. It is simply not on file.

## 3. "The reconstruction closes four independent ways"

### 3a. Independence. REFUTED AS STATED

**Candidate F3.**

1. *Location.* Line 40: "The reconstruction closes four independent ways: 24 blocks, Σ m_λ d_λ=7770 exactly, multiplicities summing to 41, unknowns to 65."
2. *Failure, in closed form.* Three of the four numbers depend only on the multiset of multiplicities: the block count 24, Σ m_λ = 41 and Σ m_λ(m_λ+1)/2 = 65. They are unchanged by any permutation of the multiplicity column across the 24 labels, and by any relabelling of the weights. Their only possible check is internal: the printed count, the printed unknowns column and the printed totals agree with one another. Only Σ m_λ d_λ = 7770 compares the table with an external quantity, dim Sym^3(W_5) = C(37,3), and it is a single linear equation. The table T′ of §2 satisfies all four:
   - block count 24, unchanged;
   - Σ m′ = 41, because {4,2} is exchanged for {2,4};
   - Σ m′(m′+1)/2 = 65, because 10 + 3 = 3 + 10;
   - Σ m′ d = 7770, because 2·35 + 4·35 = 4·35 + 2·35 = 210.

   T′ also keeps the trivial multiplicity 1 and the multiplicity-1 total 4125. The four closures therefore accept two tables that disagree on the multiplicity of W_5 itself in Sym^3(W_5), which is exactly the assignment the Casimir argument of Passage A is designed to separate.
3. *Most charitable reading.* "Closes" means only that the table's bookkeeping is self-consistent, and "independent" means four distinct numbers that do not follow from one another. As numbers they are indeed not mutually implied: 65 needs Σ m² = 89 in addition to 24 and 41. But the sentence calls them closures of the reconstruction, meaning checks that it is right. As such checks, three have a common source (the multiplicity column) and no external reference, and all four together fail to detect T′. The Lean file on disk says the same thing (L83.lean lines 65–67: "they are one column read three ways, which is why 7770 is the only external one"). The candidate survives.

What each closure could detect:

| Closure | Detects |
|---|---|
| 24 blocks | a miscounted row |
| Σ m = 41 | a misprinted multiplicity total |
| Σ m(m+1)/2 = 65 | a misprinted unknowns column or total |
| Σ m d = 7770 | an error in m or d that changes Σ m d. It misses any change that preserves Σ m d, such as the (2,2)/(2,1) swap, or m(2,2) → 3 with m(1,0) → 8 (−35 + 35 = 0) |

### 3b. The arithmetic. CONFIRMED AS ALGEBRA

By hand, from the table and the dimensions of §4:

- Rows: 2 + 1 + 9 + 12 = 24.
- Σ m = 2·4 + 1·3 + 9·2 + 12·1 = 8 + 3 + 18 + 12 = 41.
- Unknowns: 2·10 + 1·6 + 9·3 + 12·1 = 20 + 6 + 27 + 12 = 65. The per-row column 20, 6, 27, 12 matches.
- Σ m d by rows:
  - multiplicity 4: 4·(220 + 35) = 1020;
  - multiplicity 3: 3·105 = 315;
  - multiplicity 2: 2·(390+231+165+154+81+55+35+30+14) = 2·1155 = 2310;
  - multiplicity 1: 4125 (§9).
  - Total: 1020 + 315 + 2310 + 4125 = 7770.
- C(37,3) = 37·36·35/6 = 37·210 = 7770, and dim Sym^3 of a 35-dimensional space is C(35+2,3) = C(37,3).

## 4. The dimension column

**Verdict: CONFIRMED.** All 24 subscripts are exact under d(a,b) = (2a+3)(2b+1)(a−b+1)(a+b+2)/6 in the e-basis of §0. Every product is divisible by 6.

| label | (2a+3)(2b+1)(a−b+1)(a+b+2) | /6 | printed |
|---|---|---|---|
| (4,2) | 11·5·3·8 = 1320 | 220 | 220 |
| (2,2) | 7·5·1·6 = 210 | 35 | 35 |
| (3,2) | 9·5·2·7 = 630 | 105 | 105 |
| (5,2) | 13·5·4·9 = 2340 | 390 | 390 |
| (4,3) | 11·7·2·9 = 1386 | 231 | 231 |
| (4,4) | 11·9·1·10 = 990 | 165 | 165 |
| (4,1) | 11·3·4·7 = 924 | 154 | 154 |
| (3,1) | 9·3·3·6 = 486 | 81 | 81 |
| (4,0) | 11·1·5·6 = 330 | 55 | 55 |
| (2,1) | 7·3·2·5 = 210 | 35 | 35 |
| (3,0) | 9·1·4·5 = 180 | 30 | 30 |
| (2,0) | 7·1·3·4 = 84 | 14 | 14 |
| (6,6) | 15·13·1·14 = 2730 | 455 | 455 |
| (6,4) | 15·9·3·12 = 4860 | 810 | 810 |
| (6,3) | 15·7·4·11 = 4620 | 770 | 770 |
| (6,2) | 15·5·5·10 = 3750 | 625 | 625 |
| (6,0) | 15·1·7·8 = 840 | 140 | 140 |
| (5,4) | 13·9·2·11 = 2574 | 429 | 429 |
| (5,3) | 13·7·3·10 = 2730 | 455 | 455 |
| (5,1) | 13·3·5·8 = 1560 | 260 | 260 |
| (5,0) | 13·1·6·7 = 546 | 91 | 91 |
| (3,3) | 9·7·1·8 = 504 | 84 | 84 |
| (1,0) | 5·1·2·3 = 30 | 5 | 5 |
| (0,0) | 3·1·1·2 = 6 | 1 | 1 |

The basis is left unstated in Passage B (H7). The ω-basis reading is excluded by the table itself: read as 2ω_1 + 2ω_2 = 3e_1 + e_2, the label (2,2) would have dimension 9·3·3·6/6 = 81, not 35. Read as 2ω_1 + ω_2 = (5/2)e_1 + (1/2)e_2, the label (2,1) would have dimension 8·2·3·5/6 = 40, not 35. The e-basis is the only reading consistent with the printed subscripts at these two labels, so the omission causes no error.

Falsifier sought: a label whose Weyl value differs from its subscript. Each of the 24 was evaluated and none was found.

## 5. The label identification, and O(5) against SO(5)

### 5a. CONFIRMED AS ALGEBRA

- 4ω_2 = 4·(e_1+e_2)/2 = 2e_1 + 2e_2 = [2,2]. ω_2 is the spin weight, since ⟨ω_2, α_2^∨⟩ = ⟨(e_1+e_2)/2, 2e_2⟩ = 1 and ⟨ω_2, α_1^∨⟩ = 0.
- ω_1 + 2ω_2 = e_1 + e_1 + e_2 = 2e_1 + e_2 = [2,1].
- d(2,2) = d(2,1) = 35 (§4), so a dimension count does not separate them.
- c_2(2,2) = 2·5 + 2·3 = 16 and c_2(2,1) = 2·5 + 1·2 = 12, so the Casimir does.
- dim W_n = n(n+1)(n+2)(n−3)/12 gives 5·6·7·2/12 = 35 at n = 5.
- Killing: B_K(X,Y) = (N−2) tr(XY) = 3 tr(XY) at N = 5, and −6B = −6·(−½) tr = 3 tr. The Casimir scales inversely with the form, so 16/6 = 8/3. tr(X²) = −2 for X = E_12 − E_21, since X² = −E_11 − E_22. The other "neighbouring conventions" (32, 8, 4) name no form and were not checked. They are setting only and nothing in the lemma rests on them.

### 5b. HYPOTHESIS-DEBT

**Candidate F5a, irreducibility.** (1) Line 7: "W_5 is the O(5)-irreducible [2,2]", with line 9 supporting it by a run ("the Casimir is 16·Id"). (2) The quoted passages give no argument. The only support is a script, and the brief grades that as HYPOTHESIS-DEBT. (3) Charitable reading: the irreducibility of the Weyl tensor space is a classical result, so the record may treat it as an unfiled import. It is then an import reported as unfiled, which is still a debt against a lemma that decomposes Sym^3 of this module. The candidate survives as a minor debt. What would have to be proved (or cited): W_5 ≅ V_(2e_1+2e_2) as an SO(5)-module. Falsifier sought: another module of dimension 35 with integral weights on which the Casimir is 16·Id. As a screen, c_2(a,b) = 16 over integral a ≥ b ≥ 0 has only the solution (2,2): a ≥ 3 gives c_2 ≥ 18, a = 1 forces b(b+1) = 12, so b = 3 > a, and a = 0 gives 0. None was found. This screen is not evidence for the claim.

**Candidate F5b, O(5) against SO(5).** (1) Line 3 states block-diagonality "Because O(5) acts ... over the isotypic components", while the table (lines 33–38) uses B_2 = so(5) labels. (2) No passage states that O(5)-isotypic and SO(5)-isotypic components coincide (H4). A falsifier would be an SO(5)-isotypic component of Sym^3(W_5) on which −I ∈ O(5) acts with both signs, so that it splits into two O(5) blocks. As a search, W_5 sits in the fourth tensor power of ℝ^5, where −I acts by (−1)^4 = 1, so no such component was found. This is a falsifier search, not an argument on file. (3) Charitable reading: the brief's own definitions say "equivalently under SO(5) as the passages argue", but no quoted passage carries that argument. The candidate survives. What would have to be proved: O(5) = SO(5) × {±I} and −I acts trivially on Sym^3(W_5), hence the O(5)- and SO(5)-isotypic decompositions coincide.

## 6. The trivial block

**Verdict: HYPOTHESIS-DEBT.**

**Candidate F6.**

1. *Location.* Line 42: "The trivial multiplicity is 1 here and 2 from n≥6, which is the parity-sensitive Lovelock collapse: at n≤5, ⟨W^#,W⟩=2 tr(W^3), so the cubic invariant space is one-dimensional."
2. *What is missing.* The sentence infers a dimension from one identity, and that inference needs four facts. None has an argument in the quoted record:
   - the identity ⟨W^#,W⟩ = 2 tr(W^3) at n = 5, with W^# and tr(W^3) defined (neither is defined in the passages, so the constant 2 cannot be read);
   - that ⟨W^#,W⟩ and tr(W^3) span the O(5)-invariant cubics on W_n, which gives dim ≤ 1 at n = 5 once they are proportional;
   - that tr(W^3) is not identically zero on W_5, which gives dim ≥ 1;
   - that the two are linearly independent on W_n for n ≥ 6, which is the "2 from n ≥ 6" claim about a different module.
3. *Most charitable reading.* These are classical facts about curvature invariants (the dimension-dependent identity from the vanishing of the rank-6 generalised Kronecker delta at n ≤ 5), and the value 1 is only a consistency remark about the table's (0,0)_1 entry. On that reading it is still an unfiled import, and the (0,0)_1 entry itself has no argument (§1). The candidate survives.

The n = 5 value agrees with the table's (0,0)_1, and the multiplicity of the trivial representation in Sym^3(V) equals the dimension of the invariant cubics on V ≅ V*. No independent support is on file. Falsifier: a second O(5)-invariant cubic on W_5 independent of tr(W^3), or tr(W^3) ≡ 0 on W_5. No search was made, since that requires the invariant theory the passage does not supply.

## 7. Passage C against Passage B

### 7a. "Every number re-derives by hand". HYPOTHESIS-DEBT

1. *Location.* results.md line 942: "*Every number re-derives by hand, all 24 subscripts from Weyl's formula and the Casimir at B_2's own ρ, and one block is closed by an external count of 7770.* **The table is right ...**"
2. *Failure.* The numbers of the table include the 24 labels and the multiplicity column. §1 finds no hand derivation of these in the quoted record, and the same line says highest-weight arithmetic "is false of the multiplicities". §2 shows the multiplicities are not determined by any arithmetic on file.
3. *Most charitable reading.* "Every number" means the subscripts and the closure totals, which do re-derive by hand (§3b, §4). The literal "every number" together with "The table is right" still asserts the multiplicities with no argument on file, and a hand derivation outside the quoted passages cannot be excluded. So the finding is HYPOTHESIS-DEBT rather than REFUTED.

### 7b. "one block is closed by an external count of 7770". GAP

1. *Location.* results.md line 942 as above, and line 284: "with one block closed by an external count".
2. *Failure.* Σ m_λ d_λ = 7770 is one scalar equation in 24 unknowns. It fixes the multiplicity of a named block only if the other 23 multiplicities are established independently, and no block is named and no such derivation is on file. The count leaves every block open by itself. It is preserved by exchanging m(2,2) and m(2,1), and by m(2,2) → 3 with m(1,0) → 8. For a block of multiplicity 1 such as (6,4)_810, it is preserved by m(6,4) → 0 with m(1,0) → 163.
3. *Most charitable reading.* The phrase restates the section heading at [findings/sym3-blocks.md](../findings/sym3-blocks.md) line 15, "with one external closure (7770)", meaning that one of the four closures is external. Read that way the claim is true (§3b). The literal sentence says something different and unsupported, so the finding is GAP: the canonical text should say "one external closure", not that a block is closed.

## 8. The Lean file

**Verdict: CONFIRMED AS ALGEBRA. The file does not state the lemma.**

[lean/HamiltonsCubic/Results/L83.lean](../lean/HamiltonsCubic/Results/L83.lean), read in full. What it types:

- `Block` is a triple of naturals (a, b, mult). `table : List Block` is a literal list of the 24 printed rows (lines 35–41), described in the module docstring as "the imported content" (line 8).
- `dim a b := (2a+3)(2b+1)(a−b+1)(a+b+2)/6` over ℕ (line 32), which is the formula of §0.
- The theorems:
  - `card_table` (24) and `dims_match` (the dimension column, derived from `dim`);
  - `sum_mult_dim` (7770) and `seven_seven_seven_zero` (37·36·35/6 = 7770);
  - `sum_mult` (41), `sum_unknowns` (65), `sum_antisym` (24), `sum_hermitian` (89) and `sum_mult_one` (4125);
  - parity-rule and falsifier statements for L86 and L87, outside this round.
- Tactics are `decide` and `norm_num`. The file was not built in this round, so kernel acceptance is taken from the file's claim and not observed.

What it does not type: W_5, Sym^3, any representation of so(5) or O(5), highest weights, characters or multiplicities as representation-theoretic quantities. No theorem says `table` is the decomposition of Sym^3(W_5). The file verifies §3b and §4 given the table and states nothing about §1.

**Minor finding, Lean docstring.** (1) Line 31: "Stated with `a ≥ b` in mind; every block of the table satisfies it, checked below." (2) None of the 17 theorems in the file mentions a ≥ b. (3) Charitable reading: `dims_match` would probably fail if an entry had a < b, because ℕ subtraction truncates a − b + 1 to 1. That is an indirect consequence, not a check. The claim survives as an overstatement in a comment. It has no mathematical consequence, since all 24 labels satisfy a ≥ b by inspection (§0).

## 9. The boundary: equal-dimension blocks, the trivial block, n = 5 against n ≥ 6

**Verdict: CONFIRMED** (arithmetic), with the boundary observations below.

- The table has exactly two dimension coincidences, 35 = d(2,2) = d(2,1) and 455 = d(6,6) = d(5,3). The other 20 subscripts are distinct from each other and from these (§4).
- The Casimir separates both pairs: c_2(2,2) = 16 against c_2(2,1) = 12, and c_2(6,6) = 6·9 + 6·7 = 96 against c_2(5,3) = 5·8 + 3·4 = 52. So the Gram blocks are well labelled once the multiplicities are known.
- The pair (6,6)/(5,3) has equal multiplicities (1 and 1), so a label swap there is invisible and harmless. The pair (2,2)/(2,1) has multiplicities 4 and 2, and the swap T′ of §2 changes the table while passing every closure on file. The one boundary where the table's content is at risk is therefore the one the closures cannot see.
- Multiplicity-1 dimensions: 455+810+770+625+140+429+455+260+91+84+5+1. Running totals: 1265, 2035, 2660, 2800, 3229, 3684, 3944, 4035, 4119, 4124, 4125. Total 4125, as printed.
- Trivial block (0,0)_1, multiplicity 1: see §6.
- n = 5 against n ≥ 6: the table is a statement at n = 5 only. Its sole reference to n ≥ 6 is the trivial-multiplicity sentence, which concerns Sym^3(W_n) for a different module and carries no argument (§6).

## 10. Falsifiers, claim by claim

| Claim | Falsifying object | What was done |
|---|---|---|
| 1 | a dominant λ with multiplicity in Sym^3(V_(2,2)) different from the table | none. Decomposing Sym^3 is out of scope |
| 2 | two tables with the same labels, d and c_2 columns and different multiplicities | exhibited: T′ |
| 3a | a table different from T satisfying all four closures | exhibited: T′ |
| 3b, 4, 9 | a row whose Weyl value, product or sum differs from print | every value evaluated by hand, none found |
| 5a | an arithmetic error in 4ω_2 = [2,2], the 35s, 16/12, 8/3 | evaluated, none found |
| 5b | a 35-dimensional integral-weight module with Casimir 16·Id other than V_(2,2), or an SO(5)-block split by −I | c_2 = 16 solved over integral dominant weights, and the action of −I on a 4-tensor read. None found. Screens only |
| 6 | a second independent invariant cubic on W_5, or tr(W^3) ≡ 0 on W_5 | none. Needs invariant theory not on file |
| 7a | a table number with no hand derivation on file | the labels and multiplicities (§1) |
| 7b | a block whose multiplicity the 7770 count fixes by itself | none exists. Every block admits a compensating change (§7b) |
| 8 | a theorem in L83.lean stating the decomposition | the file read in full, none present |

### Withdrawn candidates

- **W1, "at n ≤ 5 ... one-dimensional" at n = 3.** (1) Line 42. (2) dim W_3 = 3·4·5·0/12 = 0, so the cubic invariant space on W_3 is zero-dimensional. (3) The conclusion "one-dimensional" refers to "here" (n = 5), and the range n ≤ 5 attaches to the identity, which holds vacuously at n = 3. Withdrawn: fails step 3.
- **W2, "subscripts from Weyl's formula and the Casimir".** (1) results.md line 942. (2) The Casimir produces no dimension subscript. (3) The sentence lists the two columns that re-derive at B_2's ρ, and both do (§4, §9). Withdrawn: fails step 3.
- **W3, "parity-sensitive".** (1) Line 42. (2) The threshold n ≤ 5 against n ≥ 6 is a dimension bound, not a parity. (3) The word may refer to record context outside the quoted lines, which this verifier may not read. It carries no mathematical claim about the table. Withdrawn: fails step 3.
- **W4, ℕ arithmetic in Lean's dim.** (1) L83.lean line 32 uses floor division by 6 and truncated subtraction. (2) Either could make `dims_match` agree with a non-integral or an a < b value. (3) All 24 products are exact multiples of 6 and all 24 labels have a ≥ b (§4, §0), so neither effect occurs on this table. Withdrawn: fails step 2.

## Overall verdict

**HYPOTHESIS-DEBT.**

- Every quantity that is a function of the labels is exact, by hand and in the Lean file: the 24 dimensions, the Casimir separations, 7770 = C(37,3), 41, 65 and 4125.
- The lemma's content is the list of 24 highest weights with their multiplicities, and no argument for it is on file. The only method named for it ("arithmetic on the highest weights") cannot produce it.
- The "four independent" closures accept the table T′ with the multiplicities of (2,2) and (2,1) exchanged.
- To discharge the debt, prove ch Sym^3(V_(2e_1+2e_2)) = Σ m_λ ch V_λ with the printed pairs, together with W_5 ≅ V_(2e_1+2e_2) and the O(5)/SO(5) coincidence.
- Correct the canonical wording at results.md lines 284 and 942 from "one block is closed by" to "one external closure", and drop "Every number re-derives by hand" until a derivation of the multiplicities is on file.
