# Verifier v289, L83: the 24-block table of Sym^3(W_5), its label basis, dimension column, multiplicities, closures and the trivial multiplicity

Cold brief ([verification/BRIEF_L83.md](BRIEF_L83.md)). No numerical work was done: every value below is exact, and no script was written or run. The Lean file was read and not built. Every quotation in the brief was checked at source by displaying only the cited lines ([findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 3, 7, 9, 13, 15, 29-42 and [results.md](../results.md) lines 284 and 942), and all match verbatim. Log: [agent_logs/verify-L83-v289.log](../agent_logs/verify-L83-v289.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | The lemma's content: the 24 highest weights and the multiplicity column of Sym^3(W_5) | HYPOTHESIS-DEBT |
| 2 | "The table is arithmetic on the highest weights ... No linear algebra on the 7770 is involved", as an account of the multiplicities | REFUTED AS STATED |
| 3a | The four closure values 24, 7770, 41, 65 | CONFIRMED AS ALGEBRA |
| 3b | "closes four independent ways" | REFUTED AS STATED |
| 4 | Dimension column, all 24 subscripts, against Weyl's B_2 formula in the e-basis | CONFIRMED |
| 5a | Label arithmetic: [2,2] = 2e_1+2e_2 = 4 omega_2, [2,1] = omega_1+2 omega_2, both of dimension 35, Casimir 16 against 12 | CONFIRMED AS ALGEBRA |
| 5b | W_5 is the irreducible of highest weight [2,2] | HYPOTHESIS-DEBT |
| 5c | SO(5) labels serve as the O(5) block table (and the real-type count behind "unknowns") | HYPOTHESIS-DEBT |
| 6a | Trivial multiplicity 1 at n = 5, by the Lovelock identity | HYPOTHESIS-DEBT |
| 6b | Trivial multiplicity 2 from n >= 6 | HYPOTHESIS-DEBT |
| 6c | "at n <= 5 ... the cubic invariant space is one-dimensional" | REFUTED AS STATED |
| 7a | Passage C, "Every number re-derives by hand" | HYPOTHESIS-DEBT |
| 7b | Passage C, "one block is closed by an external count of 7770" | CONFIRMED AS ALGEBRA |
| 8 | Lean file L83.lean | CONFIRMED AS ALGEBRA |
| 9 | Equal-dimension blocks (35, 455) and the multiplicity-1 total 4125 | CONFIRMED |

Summary: every derived number in the table (dimensions, sums, Casimir values) re-derives exactly, but the lemma's actual content, which weights occur in Sym^3(W_5) and with what multiplicity, has no argument on file and rests on a script link, and three of the four "independent" closures are functions of the multiplicity column that cannot detect an error in it.

## 0. Conventions, fixed once

- n = 5. W_5 is the space of algebraic Weyl tensors on R^5, of dimension 35. Sym^3(W_5) has dimension C(37,3) = 37·36·35/6 = 7770.
- B_2 = so(5), positive roots e_1, e_2, e_1-e_2, e_1+e_2 in the orthonormal e-basis, rho = (3/2, 1/2). A dominant integral weight of SO(5) is (a,b) = a e_1 + b e_2 with a >= b >= 0 integers. Fundamental weights omega_1 = e_1 and omega_2 = (e_1+e_2)/2.
- Weyl's formula, each factor being the ratio of the inner products of lambda+rho and of rho with one positive root: (2a+3)/3 for e_1, (2b+1) for e_2, (a-b+1) for e_1-e_2, (a+b+2)/2 for e_1+e_2. Product: d(a,b) = (2a+3)(2b+1)(a-b+1)(a+b+2)/6. This is the form the Lean file types and the form checked below.
- Casimir: c_2(a,b) = the inner product of lambda with lambda+2 rho = a(a+3) + b(b+1), in the normalisation B(X,Y) = -1/2 tr(XY) of Passage A. Screen of the normalisation on the vector (1,0): with {E_ij - E_ji} B-orthonormal, (E_ij - E_ji)^2 = -(E_ii + E_jj), each index lies in 4 of the 10 pairs, so C = 4·Id on R^5, and c_2(1,0) = 4. Consistent. Killing: B_K = 3 tr = -6B, so the Casimir scales by 1/6 and 16 becomes 8/3, as Passage A says.
- m_lambda denotes the multiplicity column, d_lambda the dimension subscript, "unknowns" the per-row sum of C(m+1,2).

## Hypothesis inventory

Of the statement:

- H1. n = 5 and W_5 as defined. Used throughout.
- H2. The group is O(5) (Passage A, line 3), with labels taken from B_2 = so(5). Used.
- H3. Labels in the e-basis with a >= b >= 0. Used by the dimension and Casimir columns. Stated in Passage A ("[2,2]=2e_1+2e_2") and forced by the c_2 formula of Passage B. The table header itself says only "highest weight".

Imported, with status:

- I1. Weyl's dimension formula for B_2. Classical, unfiled. Its exact form is needed in §4 and is the one in §0.
- I2. The Casimir eigenvalue a(a+3)+b(b+1) at the normalisation above. Classical, unfiled. Used in §5 only.
- I3. W_5 is so(5)-irreducible of highest weight (2,2). Supported on file only by [run_n5_weyl_module.py](../scripts/runs/run_n5_weyl_module.py) (not opened, per brief). Script-only: HYPOTHESIS-DEBT (§5).
- I4. The decomposition of Sym^3 of V_(2,2) into the 24 listed irreducibles with the listed multiplicities. Supported only by the link to [run_casimir_separation.py](../scripts/runs/run_casimir_separation.py) (not opened). No written argument. HYPOTHESIS-DEBT (§1).
- I5. Used but unstated: O(5)-isotypic components of Sym^3(W_5) coincide with SO(5)-isotypic components, so SO(5) labels index the O(5) blocks. (§5)
- I6. Used but unstated: every constituent is of real type, so that an O(5)-invariant Gram matrix restricts on an isotypic component of multiplicity m to a real symmetric m×m block, which is what the count C(m+1,2) in the "unknowns" column presupposes. (§5)
- I7. The Lovelock identity "at n<=5, the pairing of W^# with W equals 2 tr(W^3)", with W^# undefined in the brief, together with the facts that the two cubic contractions span the cubic O(n)-invariants and that tr(W^3) is not identically zero on W_5. Unfiled in the passages. (§6)
- I8. Complete reducibility for the compact group O(5). Classical, and harmless.

## 1. The weight list and the multiplicity column

**Claim.** Lemma L83 states the 24 highest weights of Sym^3(W_5) and their multiplicities (Passage C, line 942: "The twenty-four blocks ... with their labels and multiplicities").

**What is on file.** Passage B gives one sentence of method: the Weyl formula and c_2 are "arithmetic on the highest weights", "No linear algebra on the 7770 is involved", followed by a script link. The Weyl formula is a function lambda to d_lambda and c_2 is a function lambda to c_2(lambda). Both take the weight as input. Neither produces the set of weights occurring in Sym^3(V_(2,2)) nor any multiplicity. Producing them requires a plethysm computation (for example the weight multiset of V_(2,2), the character of Sym^3 from it, and a peeling of dominant characters), and none is written in any passage in the brief.

**Candidate: the lemma's content has no argument on file.**
1. Locate. Passage B line 31: "The table is arithmetic on the highest weights ... **No linear algebra on the $7770$ is involved.** [run_casimir_separation.py](../scripts/runs/run_casimir_separation.py)."
2. Exhibit. The table T' of §3 (multiplicities of (2,2) and (2,1) exchanged) has the same highest weights, the same arithmetic on them, and different multiplicities. So the multiplicity column is not a function of the arithmetic cited.
3. Charitable reading. The sentence may describe only the dimension and Casimir values, with the weight list and multiplicities imported from the linked script. Under that reading the sentence is true, but then the lemma's content is supported only by a script, which the brief classifies as HYPOTHESIS-DEBT. Passage C itself concedes "arithmetic on the highest weights is false of the multiplicities" and supplies no replacement argument.

**Verdict: HYPOTHESIS-DEBT.** What would have to be proved: the character identity ch Sym^3(V_(2,2)) = sum over the 24 listed lambda of m_lambda ch V_lambda, derived from the weights of V_(2,2).

**Falsifier and search.** The falsifying object is any dominant weight lambda whose multiplicity in Sym^3(V_(2,2)) differs from the table (including a weight absent from the table). Finding one requires building the decomposition, which is out of scope. No falsifier was sought beyond confirming that no stated check excludes one (§3).

## 2. "The table is arithmetic on the highest weights"

**Verdict: REFUTED AS STATED**, as a description of how the table is obtained. The three-step record is the one in §1: (1) line 31 as quoted, (2) the table T' shares every piece of arithmetic on the highest weights and differs in the multiplicity column, (3) the charitable reading restricts the sentence to the dimension column, which makes it true of that column only. Passage C at line 942 reaches the same conclusion ("arithmetic on the highest weights is false of the multiplicities").

"No linear algebra on the 7770 is involved" is consistent with the table's derived columns, which need none. It also means the Casimir cannot have been used to identify blocks inside the 7770-dimensional space, so Passage A's Casimir separation bears only on labels (§9).

## 3. The four closures

**3a. Arithmetic, re-read by hand.**

- Blocks: 2 + 1 + 9 + 12 = 24.
- Multiplicities: 4·2 + 3·1 + 2·9 + 1·12 = 8 + 3 + 18 + 12 = 41.
- Unknowns: C(5,2)·2 + C(4,2)·1 + C(3,2)·9 + C(2,2)·12 = 20 + 6 + 27 + 12 = 65, matching the row entries.
- Sum of m·d. Multiplicity 4: 4(220+35) = 1020. Multiplicity 3: 3·105 = 315. Multiplicity 2: 390+231+165+154+81+55+35+30+14 = 1155, times 2 is 2310. Multiplicity 1: 455+810+770+625+140+429+455+260+91+84+5+1 = 4125. Total 1020+315+2310+4125 = 7770 = C(37,3).

**Verdict 3a: CONFIRMED AS ALGEBRA.**

**3b. Independence.** Write n_m for the number of blocks of multiplicity m. Then blocks = sum n_m, multiplicities = sum m·n_m and unknowns = sum C(m+1,2)·n_m. All three are functions of (n_4, n_3, n_2, n_1) = (2, 1, 9, 12) alone, which is read off the table. None has an external target on file. They can detect a mis-summed row of the table and nothing about whether the multiplicities are those of Sym^3(W_5). The only closure involving an external number is sum m_lambda d_lambda = 7770, and that is a single linear equation.

**Candidate: "four independent ways" is false.**
1. Locate. Line 40: "The reconstruction closes four independent ways: $24$ blocks, $\sum m_\lambda d_\lambda=7770$ exactly, multiplicities summing to $41$, unknowns to $65$."
2. Exhibit. Let T' be the table with m_(2,2) = 2 and m_(2,1) = 4, every other entry unchanged. Both blocks have dimension 35, so sum m·d is unchanged at 7770. The multiset of multiplicities is unchanged, so T' still has 24 blocks, multiplicities summing to 41 and unknowns to 65. T' and T are different tables, and at most one of them is the decomposition of Sym^3(W_5). All four closures hold for both.
3. Charitable reading. "Independent" could mean four distinct numbers, each re-summed separately. They are distinct numbers, but three are computed from the same column that they are meant to check, and none carries information from outside the table, so the claim that the reconstruction "closes" four ways overstates what the checks establish. The Lean file's docstring for sum_mult reaches the same reading ("one column read three ways, which is why 7770 is the only external one").

**Verdict 3b: REFUTED AS STATED.** One external check (7770), and it does not see an exchange of multiplicities between equal-dimension blocks.

## 4. The dimension column

Each subscript, from d(a,b) = (2a+3)(2b+1)(a-b+1)(a+b+2)/6:

| weight | product | d | table |
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

Every product is an exact multiple of 6, so the Lean file's floor division loses nothing. All 24 entries satisfy a >= b.

**Basis.** The column is correct in the e-basis and wrong in the Dynkin basis: (2,2) read as 2 omega_1 + 2 omega_2 = 3e_1 + e_2 has dimension 9·3·3·6/6 = 81, and (a,0) is the only shape on which the two bases agree. The e-basis is stated in Passage A and fixed by the c_2 formula of Passage B.

**Verdict: CONFIRMED.** No finding on the basis: the header "highest weight" leaves it implicit, and the charitable reading (Passage A's e-basis, which the c_2 formula confirms) removes the ambiguity.

**Falsifier and search.** A subscript differing from d(a,b). All 24 were read and none differs.

## 5. The label identification

**5a. Algebra.** 4 omega_2 = 2(e_1+e_2) = 2e_1 + 2e_2 = [2,2]. 2 omega_2 = e_1+e_2 = [1,1], dimension 5·3·1·4/6 = 10, which is Lambda^2 R^5, so "rather than 2 omega_2" is right. omega_1 + 2 omega_2 = e_1 + e_1 + e_2 = [2,1]. d(2,2) = d(2,1) = 35 (§4). c_2(2,2) = 10 + 6 = 16 and c_2(2,1) = 10 + 2 = 12. dim W_5 = n(n+1)(n+2)(n-3)/12 at n = 5 is 5·6·7·2/12 = 35. **Verdict: CONFIRMED AS ALGEBRA.**

**5b. That W_5 has highest weight (2,2).** Passage A says a dimension check cannot separate [2,2] from [2,1] and "the Casimir does". Separating them requires the Casimir eigenvalue on W_5 itself, and the passage's only support for "the Casimir is 16·Id" on W_5 is [run_n5_weyl_module.py](../scripts/runs/run_n5_weyl_module.py). The classical identification of the Weyl tensors with the traceless [2,2] tensors is unfiled. **Verdict: HYPOTHESIS-DEBT.** What would have to be proved: W_5 is an irreducible so(5)-module of highest weight (2,2), for instance that the Casimir acts on W_5 as 16·Id together with an argument that this forces V_(2,2), neither on file in the passages.

**5c. SO(5) labels as an O(5) table.** Passage A block-diagonalises "because O(5) acts" over the isotypic components, and every label is a B_2 weight. The step from O(5)-isotypic components to SO(5)-labelled blocks, and the real-type assumption behind C(m+1,2) unknowns, are used and not stated.

1. Locate. Line 3: "Because $O(5)$ acts, the Gram matrix of such a certificate is block-diagonal over the isotypic components of $\mathrm{Sym}^3(\mathcal W_5)$", then the table of B_2 labels at lines 33-38 with the column "unknowns".
2. Exhibit. The failure mode is closed-form in principle: an SO(5)-irreducible on which an orientation-reversing element acts so that two SO(5)-isotypic pieces fuse into one O(5)-isotypic piece, or a constituent of complex or quaternionic type, where the invariant block would not be a real symmetric m×m matrix. I did not construct one in Sym^3(W_5), and constructing or excluding one would mean building the decomposition's O(5) structure.
3. Charitable reading. The brief's definitions call the O(5) and SO(5) decompositions equivalent "as the passages argue". No passage in the brief contains that argument, so the charitable reading supplies intent, not an argument.

**Verdict: HYPOTHESIS-DEBT.** What would have to be proved: that O(5)-isotypic and SO(5)-isotypic components of Sym^3(W_5) coincide (for example via the action of -I), and that each constituent V_lambda has real commutant, so the invariant Gram block has C(m_lambda+1, 2) free entries.

## 6. The trivial multiplicity

Passage B line 42: "**The trivial multiplicity is $1$ here and $2$ from $n\ge6$**, which is the parity-sensitive Lovelock collapse: at $n\le5$, $\langle W^\#,W\rangle=2\mathop{\mathrm{tr}}(W^3)$, so the cubic invariant space is one-dimensional."

The multiplicity of (0,0) in Sym^3(W_5) is the dimension of the space of O(5)-invariant cubic forms on W_5.

**6a. n = 5, value 1.** The argument on file is one identity, unproved in the passage, with W^# undefined in the brief. An identity between two invariants gives at most one dimension only if those two span the cubic invariants, which is not stated. It gives exactly one only if tr(W^3) is not identically zero on W_5, which is not stated. **Verdict: HYPOTHESIS-DEBT.** What would have to be proved: (i) the cubic O(5)-invariants of W_5 are spanned by the two complete contractions, (ii) the stated identity at n = 5 with W^# defined, (iii) tr(W^3) is not identically zero on W_5.

**6b. n >= 6, value 2.** No argument on file. It is a claim about every n >= 6, including the edge n = 6, and is not used by the n = 5 table. **Verdict: HYPOTHESIS-DEBT.** What would have to be proved: the two cubic contractions are linearly independent on W_n for every n >= 6 and span the invariants.

**6c. The range "n <= 5".**
1. Locate. "at $n\le5$, ... so the cubic invariant space is one-dimensional."
2. Exhibit. At n = 3, dim W_3 = 3·4·5·0/12 = 0, so W_3 = {0}, Sym^3(W_3) = 0 and the cubic invariant space is zero-dimensional. The identity holds there as 0 = 0 and the conclusion "one-dimensional" fails. The same holds at n = 1, 2.
3. Charitable reading. The clause intends n in {4, 5}, where the Weyl space is nonzero, and "one-dimensional" stands for "at most one-dimensional", which is all an identity between two invariants can deliver. Under that reading the range claim is an upper bound and says nothing false at n = 5, but the literal range is wrong at n = 3 and the literal conclusion is stronger than the deduction.

**Verdict: REFUTED AS STATED** at the lower edge of the range. No impact on the n = 5 table, whose (0,0) entry rests on 6a.

## 7. Passage C

**7a. "Every number re-derives by hand, all 24 subscripts from Weyl's formula and the Casimir at B_2's own rho".** The subscripts, the four closure values, the Casimir values and 4125 re-derive by hand (§§3-5, 9). The 24 weights and 24 multiplicities do not re-derive from anything written, and the same line 942 says the stated arithmetic is false of the multiplicities while asserting "The table is right" with no argument. **Verdict: HYPOTHESIS-DEBT**, for the same object as §1.

**7b. "one block is closed by an external count of 7770".** 7770 = C(37,3) = dim Sym^3 of a 35-dimensional space, and it equals sum m·d (§3a). It is external in that it depends only on dim W_5. **Verdict: CONFIRMED AS ALGEBRA**, with the limitation of §3b: one linear equation, blind to exchanges between equal-dimension blocks. The wording candidate is withdrawn in §10.

## 8. The Lean file

[lean/HamiltonsCubic/Results/L83.lean](../lean/HamiltonsCubic/Results/L83.lean) types a structure Block with fields a, b, mult, a function dim equal to the formula of §0 over the naturals (truncated subtraction and floor division, both harmless on this table by §4), and table as a literal list of 24 blocks. It proves by decide or norm_num: card_table (24), dims_match (the 24 subscripts), sum_mult_dim (7770), seven_seven_seven_zero (37·36·35/6 = 7770 as a bare numeral), sum_mult (41), sum_unknowns (65), sum_mult_one (4125), and further sums belonging to L86, L87 and L88.

- It derives the dimension column from the formula, which agrees with §4.
- The weights and multiplicities are data input. Its docstring says so ("whose weights and multiplicities are the imported content").
- No representation, no Sym^3 and no W_5 are typed. seven_seven_seven_zero is not tied to any dimension of Sym^3. Nothing asserts the decomposition.

**Verdict: CONFIRMED AS ALGEBRA** of the dimension column and closure sums. The file neither states nor proves Lemma L83. I did not build it, so its kernel-checked status is the file's own claim.

## 9. The boundary

- Equal dimensions: (2,2) and (2,1) at 35 with multiplicities 4 and 2, and (6,6) and (5,3) at 455, both multiplicity 1. No other dimension repeats among the 24 (§4). The first pair is what makes the exchange table T' of §3 possible. Exchanging the second pair leaves the table unchanged.
- The labels of each pair are separated by c_2: 16 against 12, and c_2(6,6) = 54 + 42 = 96 against c_2(5,3) = 40 + 12 = 52.
- c_2 alone does not separate the 24 labels: c_2(6,2) = c_2(5,4) = 60, c_2(4,3) = c_2(5,0) = 40, c_2(4,1) = c_2(3,3) = 30, each pair differing in dimension. The pair (d, c_2) separates all 24. No passage in the brief claims that c_2 alone separates the table, so this is an observation, not a finding. Any rescaling of the form preserves these coincidences.
- Multiplicity-1 total: 455+810+770+625+140+429+455+260+91+84+5+1 = 4125. **CONFIRMED.**
- The trivial block (0,0) at multiplicity 1 is internally consistent with the one-dimensional claim of §6a.

**Verdict: CONFIRMED.**

## 10. Withdrawn candidates

- **"one block is closed by an external count".** (1) Line 942, and line 284 "with one block closed by an external count". (2) Read literally, the multiplicity of one block is solved from sum m·d = 7770, while Passage B presents 7770 as a check on a complete table and solves no block from it. (3) The heading at line 15 reads "with one external closure ($7770$)", so "block" stands for "closure". Withdrawn: the charitable reading is supported on file.
- **"all 24 subscripts from Weyl's formula and the Casimir".** (1) Line 942. (2) A dimension subscript uses Weyl's formula only, and c_2 enters none. (3) The sentence lists the tools behind the numbers, the Casimir fixing labels between equal-dimension blocks (§9). Withdrawn.
- **Label basis unstated in the table.** (1) Line 33, header "highest weight, dimension". (2) In the Dynkin basis (2,2) would have dimension 81. (3) Passage A fixes the e-basis and the c_2 formula at line 31 is the e-basis formula, and §4 confirms every subscript in it. Withdrawn.
- **Casimir normalisation.** (1) Line 13. (2) Screened on the vector representation: c_2(1,0) = 4, and C = 4·Id from the B-orthonormal basis. (3) Consistent, and the Killing value 8/3 = 16/6 follows. No discrepancy. Withdrawn.

## 11. Falsifiers, claim by claim

| Claim | Falsifying object | What I did |
|---|---|---|
| 1, 7a | a dominant weight whose multiplicity in Sym^3(V_(2,2)) differs from the table | Out of scope to build. Showed that no stated check excludes one (T') |
| 2 | two tables with equal weight arithmetic and different multiplicities | Exhibited T' |
| 3b | a second table satisfying all four closures | Exhibited T' |
| 4 | a subscript differing from d(a,b) | Read all 24, none |
| 5a | a wrong basis conversion or Casimir value | Re-derived, none |
| 5b | W_5 with Casimir other than 16, or reducible | Script-only on file, not opened |
| 5c | a constituent where O(5) and SO(5) isotypics differ, or of non-real type | Not constructed, would require building the O(5) structure |
| 6a | a second independent cubic invariant on W_5, or tr(W^3) = 0 on W_5 | No argument on file to check against |
| 6b | a linear relation between the two contractions at some n >= 6 | No argument on file |
| 6c | n <= 5 with invariant space not one-dimensional | Exhibited n = 3, W_3 = 0 |
| 7b, 9 | a sum differing from 7770 or 4125 | Re-summed, none |
| 8 | a Lean theorem asserting the decomposition | Read the file in full, none present |

## Overall verdict

**HYPOTHESIS-DEBT.** Every derived number re-derives exactly, but the lemma's content (which 24 weights occur and with which multiplicities) has no argument on file beyond a script link, and the identification of W_5 as V_(2,2), the O(5)/SO(5) and real-type steps, and the trivial multiplicity rest on unstated or unfiled arguments. Two statements are wrong as written without affecting any table entry: "four independent" closures (three are functions of the multiplicity column, and T' satisfies all four), and "at n <= 5 ... one-dimensional" (false at n = 3).
