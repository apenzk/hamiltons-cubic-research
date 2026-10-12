# Gate 2 review 177, the n=5 certificate pipeline and the n=12 separation claim

Reviewed against the tree at commit `5c80e5b`. Everything below was recomputed from the definitions before any number in the record was read; the record's scripts were opened only after my own tables existed. Scripts: [scripts/reviewers/r177/](../scripts/reviewers/r177/).

## Verdict

| # | Claim | Verdict |
|---|---|---|
| 1 | The n=5 block table: twelve mult-1 blocks, 4125, 7770 | **Confirmed**, every entry reproduced independently. The *derivation* claim is overstated: the script inverts a recorded spectrum. |
| 2 | Casimir separation at n=5 | **Confirmed** as a theorem. |
| 2 | Casimir separation at n=12 | **Conclusion confirmed, original argument refuted.** Six invariants, not five. The record already carries the fix (r178); my six chirality pairs are the reason the fix is not vacuous. |
| 3 | dim (Sym^6 Weyl_5)^{O(5)} = 14, and the stable 1,2,7,19,89 | **Confirmed** by a method sharing nothing with Weyl integration. |
| 4 | 41 highest-weight vectors; the Casimir does not validate the action | **Confirmed**, and the second half is upgraded from an anecdote to a proof with a live witness. |
| 5 | The orbit constraint and the two vanishing collisions | **Rule re-derived and confirmed.** One unproven step in the consequence: "each block loses one multiplicity" is an upper bound on the constraint rank, not an identity. |
|, | Arithmetic slip | **Defect.** [findings/sym3-blocks.md:32](../findings/sym3-blocks.md#L32) says the degree-two Casimir takes 22 distinct values on 24 blocks with three colliding pairs. It takes 21. |

## Method

The whole review rests on one pipeline, built from the definitions and used at both n=5 and n=12.

1. Weight multiplicities of the Weyl-tensor irrep (B_2 highest weight (2,2), dim 35; D_6 highest weight (2,2,0,0,0,0), dim 1638), by Freudenthal ([wt_mults.sage](../scripts/reviewers/r177/wt_mults.sage)).
2. The symmetric cube by Adams operations: ch(Sym^3 V) = (p_1^3 + 3 p_1 p_2 + 2 p_3)/6, with p_k the weight multiplicities scaled by k.
3. Irreducible multiplicities by Racah's alternating sum, n_λ = Σ_w ε(w) m(λ + ρ − wρ), over the full Weyl group (8 elements for B_2, 23040 for D_6).

[sym3_decompose.py](../scripts/reviewers/r177/sym3_decompose.py). No number from the record enters it. It runs in 19 seconds at D_6.

Two independent checks pin the output. The total closes exactly (7770 = C(37,3) at n=5, 733 813 080 = C(1640,3) at n=12) and the top-degree part matches the GL plethysm Sym^3[s_{(2,2)}], computed separately in [plethysm_check.sage](../scripts/reviewers/r177/plethysm_check.sage), term for term including multiplicities.

## Claim 1, the block table

My decomposition gives 24 blocks with Σ m·dim = 7770. The twelve multiplicity-1 blocks are

  (0,0), (1,0), (3,3), (5,0), (5,1), (5,3), (6,0), (5,4), (6,2), (6,3), (6,4), (6,6),

dimensions summing to 4125. That is the claimed list exactly, as a set and with the claimed dimensions. Multiplicities sum to 41 and Σ m(m+1)/2 = 65, both as claimed. The largest weight space is 234, at weight (0,0), as claimed.

**The description "derived rather than measured" does not describe [run_casimir_separation.py](../scripts/runs/run_casimir_separation.py).** That script hardcodes `SPECTRUM` and the twelve `NAMED` multiplicities and then *solves* for the mult-1 labels by matching Casimir values, picking `cands[0]` when a value is ambiguous. What is arithmetic on highest weights is the dimension and Casimir formulae; the multiplicities are input, and they originally came from linear algebra on the 7770 in [run_n5_highest_weight.py](../scripts/runs/run_n5_highest_weight.py). The plethysm above is the first actual derivation, and it agrees, so the table is safe, but the epistemic label was wrong until now.

The inversion is also fragile in a way worth recording: at c_2 = 60 two mult-1 blocks share a value, and `cands[0]` resolves the tie only because the enumeration order of `allw` happens to hand back (5,4) before (6,2). A different ordering silently produces a different, wrong table with the same closing checks.

## Claim 2, separation

**At n=5 the claim is a theorem and it holds.** ρ = (3/2,1/2) is strictly decreasing and strictly positive, so ℓ_1 > ℓ_2 > 0 for every dominant λ; rank 2 means two power sums for two unknowns, e_1 = p_2 and e_2 = (p_2² − p_4)/2 in the variables ℓ_i², and the multiset {ℓ_1², ℓ_2²} with the strict order recovers λ. I confirm 21 distinct c_2 values, three colliding pairs, and the exact p_4 values the record quotes: 4481/8 against 7361/8 at c_2 = 30, 8521/8 against 14281/8 at 40, 17561/8 against 25625/8 at 60. (p_2, p_4) is injective on all 24.

**At n=12 the original argument was a non-sequitur.** The version I set out to attack read: ρ_6 = 0, so ℓ_6 = λ_6, "the ONLY ambiguity the power sums leave is the sign of ℓ_6", and therefore five Casimirs suffice. The successor version read: "p_2,…,p_10 are functions of {ℓ_i²} alone, which is exactly the O(12) label". Both fail, and for the same reason. p_2, p_4, p_6, p_8, p_10 are the first *five* power sums of the *six* numbers x_i = ℓ_i². Newton converts them into e_1,…,e_5 and stops. e_6 = ∏ x_i is left completely free, a one-parameter family of admissible multisets, not a sign. Being a function of the O(12) label proves the invariants are well defined on a block; it says nothing about their injectivity, which is the property at issue.

The correct count follows from invariant theory and is six, not five, on both sides:

* on the Cartan of so(12), the W(D_6)-invariants are generated by p_2,…,p_10 together with the Pfaffian ∏ ℓ_i, six generators;
* the O(12)-invariants are the invariants of the full hyperoctahedral group, generated by p_2, p_4, p_6, p_8, p_10, p_12, also six. The sixth is p_12, equivalently Pf², which *is* O(12)-invariant.

So "six invariants is the SO count" was backwards. Six is the count on both sides; what is special about SO is that its sixth generator can be taken in degree 6 rather than degree 12. With all six, separation is a genuine theorem for every O(12) label: e_1,…,e_6 fix the multiset {ℓ_i²}, and ℓ_1 > … > ℓ_5 > |ℓ_6| ≥ 0 recovers λ with λ_6 ≥ 0.

**The premise that made the old argument look harmless is false, and here is the witness.** Sym³(Weyl_12) has 77 SO(12) constituents falling into 71 O(12) blocks, because six blocks carry λ_6 ≠ 0 and split into chirality pairs:

| λ | mult (each half) | dim |
|---|---|---|
| (2,2,2,2,2,±2) | 1 | 28 314 |
| (3,3,2,2,1,±1) | 1 | 2 814 669 |
| (4,4,1,1,1,±1) | 1 | 4 679 675 |
| (3,2,2,1,1,±1) | 1 | 462 462 |
| (4,2,1,1,1,±1) | 1 | 750 750 |
| (2,2,1,1,1,±1) | 2 | 21 450 |

The first three are the top-degree ones and appear independently in the GL plethysm as the three partitions of 12 with six rows, s_{(2,2,2,2,2,2)}, s_{(3,3,2,2,1,1)} and s_{(4,4,1,1,1,1)}, each with coefficient 1. The other three arise from those by trace removal. 65 + 2·6 = 77 and 65 + 6 = 71, with Σ m·dim = 733 813 080 = C(1640,3) exactly.

**What is actually true at n=12, and what is measured.** I computed the invariants on all 71 O(12) blocks ([separation.py](../scripts/reviewers/r177/separation.py)):

* c_2 alone: 36 distinct values, 17 collision classes, it separates nothing;
* (c_2, c_4): **71 distinct values, injective**;
* all five, and all six: injective.

So the five-Casimir conclusion is true, and so is a stronger one, *two* Casimirs already separate all 71. But that is a measurement on a finite list. The theorem is the six-invariant statement.

I looked for a witness showing that five power sums genuinely fail on admissible weights, by searching all 6-subsets of {0,…,50} (18 009 460 of them) for two with equal p_2, p_4, p_6, p_8, p_10 ([pte_search.py](../scripts/reviewers/r177/pte_search.py)). **None.** So the refutation is structural, not exhibited: five power sums cannot determine six numbers as a matter of invariant theory, and no proof of the integrality-constrained statement is on the record, but no counterexample lives in that range either. The record should not claim more than the six-invariant theorem, which needs no such search.

*The record already carries this correction, attributed to reviewer 178, and the current text is right. I record the independent arrival at the same count, and supply the six pairs that keep the correction from being vacuous.*

## Claim 3, the 14 constraints

Confirmed twice over, both times without Weyl integration.

Direct, at n=5, from the same weight multiplicities via Newton's h_d = (1/d) Σ_k p_k h_{d−k} and Racah at λ = 0 ([invariants.py](../scripts/reviewers/r177/invariants.py)):

| degree | 1 | 2 | 3 | 4 | 5 | 6 |
|---|---|---|---|---|---|---|
| dim Sym^d Weyl_5 | 35 | 630 | 7770 | 73 815 | 575 757 | 3 838 380 |
| O(5)-invariants | 0 | 1 | 1 | 4 | 5 | **14** |

The stable range, by universal characters ([stable2.sage](../scripts/reviewers/r177/stable2.sage)): the Littlewood restriction gives s_{(2,2)} ↓ = [2,2] + [2] + [0] and s_{(2)} ↓ = [2] + [0], so the universal orthogonal character of the Weyl module is o_{(2,2)} = s_{(2,2)} − s_{(2)}. Then h_d[s_{(2,2)} − s_{(2)}] = Σ_{i+j=d} (−1)^j h_i[s_{(2,2)}] e_j[s_{(2)}], and the trivial O-constituent of s_μ is present exactly when every part of μ is even. That yields **1, 2, 7, 19, 89** for degrees 2 through 6, the record's sequence exactly.

Two consistency notes in the record's favour: the 65 unknowns are dim Sym²(Sym³ Weyl_5)^{O(5)} = Σ m(m+1)/2, and 14 is the dimension of the target of the coefficient map, so "65 unknowns, 14 equations" is coherent. The degree-3 entry dropping from 2 to 1 does reproduce the Lovelock collapse by an independent route.

## Claim 4, the 41 vectors and the Casimir

Multiplicities sum to 41 in my decomposition, block by block matching the record's table. [run_n5_weyl_module.py](../scripts/runs/run_n5_weyl_module.py) runs clean here: all 45 generator pairs, exact over Q, Casimir 16·Id with zero off-diagonal.

**The "Casimir does not validate the action" claim is right, and it deserves a proof rather than the anecdote of a deleted buggy version.** Here is one. C = −Σ_a ρ(A_a)² depends on the generator images only through their squares. So replace any single ρ(A_a) by −ρ(A_a): the Casimir is untouched, exactly, while the brackets [ρ(A_a), ρ(A_b)] flip sign against an unflipped ρ([A_a, A_b]) and fail for every b not commuting with a. Run on the record's own module ([negated_generator.py](../scripts/reviewers/r177/negated_generator.py), one inserted line): **C = 16·Id exactly, and 12 of the 45 relations fail.** More generally the fibre over "C = 16·Id" contains every choice with ρ(A_a)² fixed, which is enormous. The eigenvalue tests nothing about the bracket, and the record's stronger phrasing (the bracket check is what tests the action), is correct.

## Claim 5, the orbit constraint

**The branching rule is right, and I re-derived it rather than checking it.** Let H = Stab_{O(5)}(W_0) with identity component U(2) ⊂ SO(4).

1. so(5) ↓ so(4) is multiplicity-free with interlacing λ_1 ≥ μ_1 ≥ λ_2 ≥ |μ_2|, and (j_+, j_−) = ((μ_1+μ_2)/2, (μ_1−μ_2)/2). Then j_− = 0 forces μ_1 = μ_2, and the interlacing squeezes μ_1 ≥ λ_2 ≥ |μ_2| = μ_1, so μ = (λ_2, λ_2) is the unique constituent with j_− = 0, carrying j_+ = λ_2.
2. The identity component U(2) ≅ (U(1)_+ × SU(2)_−)/± acts trivially exactly on the u(1)_+ weight-zero line of that spin-λ_2 factor. λ is integral, so λ_2 is an integer and the zero-weight space is one-dimensional: dim V_λ^{H^0} = 1 for every block.
3. Stab_{SO(4)}(W_0) has two components. W_{CP²} has Λ²_+-spectrum (2,−1,−1), whose stabiliser in SO(3)_+ is O(2), and the extra component lifts to the Weyl element of SU(2)_+. That element sends |j, m⟩ to (−1)^{j−m}|j, −m⟩, so it acts on the invariant line by (−1)^{λ_2}. The padding reflection adds nothing: diag(1,1,1,1,−1) = (−I_5)·(−I_4 ⊕ 1), −I_5 acts trivially on everything inside ⊗¹² R⁵, and −I_4 already lies in U(1)_+ × SU(2)_−.

Hence **dim V_λ^H = 1 if λ_2 is even and 0 otherwise**, which is 174's rule, now with its mechanism.

Every downstream number checks against my own table ([claim5.py](../scripts/reviewers/r177/claim5.py)): 16 blocks with λ_2 even, dimensions summing to 3570; 25 surviving multiplicities and 36 unknowns; shape two 3×3, five 2×2, nine scalars; the eight mult-1 blocks dying outright are exactly (0,0), (1,0), (5,0), (5,4), (6,0), (6,2), (6,4), (6,6). At c_2 = 60 both (5,4) and (6,2) die, at 40 only (5,0) dies leaving (4,3) alone, and c_2 = 30 keeps both (3,3) and (4,1). The quartic is needed for one pair.

**One step is asserted where an inequality is what is proved.** "Each such block loses one multiplicity" requires the evaluation map C^{m_λ} → V_λ^H to be *nonzero*. Frobenius reciprocity bounds the rank of the orbit constraint in block λ by dim V_λ^H = 1; it does not force the rank to be 1. If some component vanishes, that block keeps its full multiplicity. So 36 is a lower bound on the unknowns and the eight deaths are conditional, in particular the punchline that only (4,1)/(3,3) needs the quartic depends on (5,0), (5,4) and (6,2) genuinely dying. This is checkable with the 41 highest-weight vectors already built and should be checked rather than assumed.

## Defect list

1. **[findings/sym3-blocks.md:32](../findings/sym3-blocks.md#L32).** "The degree-two Casimir takes 22 distinct values across the 24 blocks. Three pairs collide", 24 − 3 = 21, and the spectrum confirms 21. Isolated; the number appears nowhere else.
2. **[run_casimir_separation.py](../scripts/runs/run_casimir_separation.py) does not derive the block table.** It inverts a hardcoded spectrum against a hardcoded multiplicity list, with an order-dependent tie-break at c_2 = 60. The claim is true; the script is a consistency check, and the plethysm here is the derivation.
3. **The n=12 five-Casimir argument** was invalid in both its forms; the count is six. Already fixed in the record.
4. **The one-multiplicity loss in claim 5** is an upper bound presented as an identity.
