# Verifier v300, Lemma L88: the invariant dimensions 65, 24 and 89 on Sym^3(W_5), the real type of the blocks, the gauge claim, and reviewer 204's basis claims

The brief was cold. No numerical work was done: every value below is exact, no script was written or run, and the only arithmetic is summing the formulas over Passage B's table and evaluating the Weyl dimension formula by hand. Log: [agent_logs/verify-L88-v300.log](../agent_logs/verify-L88-v300.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | The sums of m(m+1)/2, m(m-1)/2 and m^2 over Passage B give 65, 24 and 89 | CONFIRMED AS ALGEBRA |
| 2 | dim Sym^2(U)^{O(5)} = 65 and dim Lambda^2(U)^{O(5)} = 24 as stated | HYPOTHESIS-DEBT |
| 3 | "65+24=89" as a check | CONFIRMED AS ALGEBRA (it is an identity and detects nothing about the table or the types) |
| 4 | Every one of the 24 blocks is of real type | CONFIRMED (imported classical theorem, unfiled) |
| 5 | An antisymmetric invariant form contributes nothing to the sextic | CONFIRMED |
| 6 | "So the 24 directions a Hermitian ansatz offers beyond the 65 are genuine O(5)-invariants, of Lambda^2" | GAP |
| 7 | "such a basis forces h real symmetric" | CONFIRMED (under the reading of h fixed in section 0) |
| 8 | "On a multiplicity-2 block the kernel direction is the imaginary coordinate iff Im h = 0" | REFUTED AS STATED (the "if" half fails, by the passage's own example, and the "only if" half holds and is the half used) |
| 9 | The converse example Q = diag(1,i), and that rephasing keeps h Hermitian with det h nonzero | CONFIRMED AS ALGEBRA |
| 10 | The measured h on (2,0), the "4000 bases" and "0.541" figures, the "multi-probe test" | HYPOTHESIS-DEBT |

Summary: the arithmetic and the representation theory that turn Passage B into 65, 24 and 89 are sound, but the multiplicities themselves and the dimensions as stated rest only on scripts, the identification of the Hermitian surplus with Lambda^2 is inferred from a dimension coincidence, and one "iff" in reviewer 204's paragraph is false in the direction it does not use.

## 0. Conventions, fixed once

- W_5 is the space of algebraic Weyl tensors on R^5 (dimension 35), U = Sym^3(W_5), dim U = C(37,3) = 7770. G = O(5) acting orthogonally.
- Highest weights are written (l1, l2) = l1 e1 + l2 e2 for B_2 = so(5), the convention of [findings/sym3-blocks.md](../findings/sym3-blocks.md) line 7 ("[2,2]=2e_1+2e_2"). Positive roots e1-e2, e2, e1, e1+e2, and rho = (3/2, 1/2).
- Weyl dimension: dim V_(l1,l2) = (l1-l2+1)(2 l2+1)(2 l1+3)(l1+l2+2)/6.
- U = sum over lambda of V_lambda (x) M_lambda with dim M_lambda = m_lambda, V_lambda a real irreducible representation.
- A Hermitian ansatz is a G-invariant Hermitian form on U_C, block by block I (x) h_lambda with h_lambda a Hermitian m x m matrix, of real dimension m^2 per block.
- h is used in Passage A without a definition in the brief. The reading adopted: h on a block is the Gram matrix, in the Q(i) highest-weight basis of M_lambda, of the invariant Hermitian inner product induced from the real inner product on U. Section 7 depends on this reading.
- For a 2x2 Hermitian matrix [[a, b+ic],[b-ic, d]] the "imaginary coordinate" is c, and J = [[0,1],[-1,0]].
- The quotations in the brief were checked against [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 23-36, 106 and 120-130. They match verbatim. Lines 15-22 and 107-118 were not displayed.

## Hypothesis inventory

| # | Hypothesis | Stated? | Used by | Status |
|---|---|---|---|---|
| H1 | -I in O(5) acts trivially on U (W_5 is a 4-index tensor space, so -I acts by (-1)^4 = 1 on W_5 and hence on U). Then O(5)-invariants equal SO(5)-invariants, which equal so(5)-invariants since SO(5) is connected, so so(5) highest weights label the O(5) blocks | Unstated in Passage A | Every appeal to the B_2 table for an O(5) count | True as read. No finding |
| H2 | The multiplicities of Passage B | Given, with "the multiplicities come from the character computation" and a script link | Claims 1, 2, 6 | No derivation on file. HYPOTHESIS-DEBT |
| H3 | Every V_lambda is of real type | Stated, from integrality | Claims 2, 6, 7 | Imported classical fact (Frobenius-Schur indicator for B_2), unfiled. Hypothesis (integral weights) checked on all 24 labels |
| H4 | Schur's lemma for real representations of real type: End_G(V_lambda) = R, and the invariant bilinear forms on V_lambda (x) M_lambda are <,>_lambda (x) B with B an arbitrary bilinear form on M_lambda | Unstated | The passage from multiplicities to sum m(m+1)/2 and sum m(m-1)/2 | Classical, unfiled |
| H5 | No invariant bilinear pairing between non-isomorphic blocks | Unstated | Same | Holds: a real representation of a compact group is self-dual through its invariant inner product, so (V_lambda (x) V_mu)^G = Hom_G(V_lambda, V_mu) = 0 for lambda different from mu |
| H6 | "An SOS Gram is an invariant quadratic form": if F_5 has a Gram, it has a G-invariant one | Asserted as a definition | The reduction of unknowns to Sym^2(U)^{O(5)} | Unfiled reduction (Haar averaging, using G-invariance of F_5, of the affine constraint and of the PSD cone). See withdrawn candidate W1 |
| H7 | F_5 is O(5)-invariant | Implicit | H6 | True for ||W||^6 and tr(W^3)^2. No finding |
| H8 | The meaning of h | Undefined in the brief | Claims 7, 8, 10 | Reading fixed in section 0 |

## 1. The sums over Passage B (attack item 1)

Blocks by multiplicity, read from the table: two with m = 4, one with m = 3, nine with m = 2, twelve with m = 1. That is 24 blocks and sum m = 8 + 3 + 18 + 12 = 41.

| m | count | m(m+1)/2 each, total | m(m-1)/2 each, total | m^2 each, total |
|---|---|---|---|---|
| 4 | 2 | 10, 20 | 6, 12 | 16, 32 |
| 3 | 1 | 6, 6 | 3, 3 | 9, 9 |
| 2 | 9 | 3, 27 | 1, 9 | 4, 36 |
| 1 | 12 | 1, 12 | 0, 0 | 1, 12 |
| sum | 24 | 65 | 24 | 89 |

The column totals are 65, 24 and 89 exactly. The "unknowns" column of the table (20, 6, 27, 12) matches the first total.

The dimension column was checked by hand with the formula of section 0. All 24 entries agree, for example (4,2): 3·5·11·8/6 = 220, (6,4): 3·9·15·12/6 = 810, (5,2): 4·5·13·9/6 = 390, (3,1): 3·3·9·6/6 = 81, (0,0): 1·1·3·2/6 = 1. Then sum m d = 4(220+35) + 3·105 + 2·1155 + 4125 = 1020 + 315 + 2310 + 4125 = 7770 = C(37,3), and the twelve multiplicity-1 dimensions sum to 4125 as the file says.

The derivation that these sums are the invariant dimensions, given H1, H3, H4 and H5: invariant bilinear forms on U are the direct sum over blocks of <,>_lambda (x) B_lambda, where <,>_lambda is the invariant inner product on V_lambda (symmetric). Such a form is symmetric iff every B_lambda is symmetric and antisymmetric iff every B_lambda is antisymmetric. Hence dim Sym^2(U)^G = sum m(m+1)/2 and dim Lambda^2(U)^G = sum m(m-1)/2. This derivation is not written on file. Passage A reports the agreement as a coincidence between the script's integrals and "the measured multiplicities".

**Verdict, claim 1: CONFIRMED AS ALGEBRA.**

## 2. The dimensions as stated (attack items 1 and 6)

The stated values rest on two sources. The first is [run_n5_unknown_count.py](../scripts/runs/run_n5_unknown_count.py) ("Weyl integration settles it"), a script. The second is Passage B's multiplicities, which "come from the character computation" in [run_casimir_separation.py](../scripts/runs/run_casimir_separation.py), also a script. Under this loop's rule both are HYPOTHESIS-DEBT.

What would have to be proved: the decomposition of Sym^3(W_5) under so(5), at least to the extent of sum m_lambda = 41 and sum m_lambda^2 = 89 over integral-weight blocks. These two numbers determine the result, since dim Sym^2 = (sum m^2 + sum m)/2 = (89+41)/2 = 65 and dim Lambda^2 = (89-41)/2 = 24.

Scope. The claimed numbers depend on Passage B only through the multiset of multiplicities and the real type. The block labels and dimensions enter only through the external check 7770, which constrains sum m d and cannot fix the multiset. Example: the two dimension-35 blocks (2,2) with m = 4 and (2,1) with m = 2 could exchange multiplicities without changing 7770, sum m or sum m^2. So the one external check leaves the L88 numbers unconstrained beyond what the character computation gives.

**Verdict, claim 2: HYPOTHESIS-DEBT.**

## 3. "65+24=89" as a check (attack item 2)

U (x) U = Sym^2(U) (+) Lambda^2(U) as G-representations, so dim (U (x) U)^G = dim Sym^2(U)^G + dim Lambda^2(U)^G identically. The characters satisfy chi_Sym2 + chi_Lambda2 = chi^2, so the corresponding Weyl integrals add by linearity. On the table side, m(m+1)/2 + m(m-1)/2 = m^2 term by term.

What it can detect: an arithmetic or transcription slip in one of the three numbers. What it cannot detect: any error in the multiplicities, and any error of type. A quaternionic block of multiplicity m would contribute m(m-1)/2 to Sym^2 and m(m+1)/2 to Lambda^2, which exchanges the two contributions and leaves the total at m^2. The quantity that does see type is the difference, dim Sym^2 - dim Lambda^2 = sum over blocks of (Frobenius-Schur indicator) · m, which equals 41 = sum m exactly when every block is real. That difference is available only from the script.

**Verdict, claim 3: CONFIRMED AS ALGEBRA, as an identity with no power to check the table or the types.**

## 4. Real type (attack item 3)

The passage: "Every one of the 24 weights is *integral* for B_2, hence of real type, the quaternionic representations of so(5) ≅ sp(4) are the half-integral spin ones, and none occur".

- Hypothesis check. In the e-basis of line 7, all 24 labels in Passage B have integer coordinates. Each one was read off the table.
- The imported fact. For a compact connected group, a self-dual complex irreducible representation of highest weight lambda is orthogonal or symplectic according to the sign of the central element exp(2 pi i rho-check), that is (-1)^{<lambda, 2 rho-check>}. For B_2 with coroots e1-e2, 2e2, 2e1, e1+e2, one gets 2 rho-check = 4e1 + 2e2 and <lambda, 2 rho-check> = 4 l1 + 2 l2. This is even for integer (l1, l2), which is real type. For l1, l2 both in Z + 1/2 it is 4 l1 + 2 l2 = (even) + (odd), which is quaternionic. So the quoted sentence is the classical statement, correctly applied. Every B_2 irreducible is self-dual (-1 lies in the Weyl group), so the complex type does not arise.
- The imported fact is classical and unfiled, as the brief records.
- The consequence, "each multiplicity space carries a real structure and the invariant form is real symmetric in a real basis": for real type, M_lambda = Hom_G(V_lambda, U) is a real space. A basis of it gives a real basis, and in it the invariant inner product restricted to a block is <,>_lambda (x) (real symmetric positive definite). Correct.
- Group. The statement concerns O(5). By H1, -I acts trivially on U, so the O(5) blocks are the SO(5) blocks and the type is the same.

**Verdict, claim 4: CONFIRMED, resting on an unfiled classical theorem whose hypothesis was checked on every label.**

## 5. An antisymmetric form contributes nothing to the sextic (attack item 4, the map)

A Gram G gives the sextic W ↦ G(phi(W), phi(W)) with phi(W) in U real. For an antisymmetric A, A(x, x) = -A(x, x), so A(x, x) = 0 for every real x. The sextic depends only on the symmetric part. The link is correct in any basis and for any field of scalars in which the evaluation vectors are real.

A caution, not a defect: the map from Sym^2(U)^G to sextics has its own kernel (relations among products of cubics). "Gauge" for the 24 does not say that the 65 are independent, and Passage A does not claim they are.

**Verdict, claim 5: CONFIRMED.**

## 6. The surplus of the Hermitian ansatz is Lambda^2 (attack item 4, the identification)

The passage: "65+24=89 ... **So the 24 directions a Hermitian ansatz offers beyond the 65 are genuine O(5)-invariants, of Lambda^2.**"

(1) Location. [findings/sym3-blocks.md](../findings/sym3-blocks.md) line 126, the sentence beginning "So the 24 directions".

(2) The failure is in the inference, not in the conclusion. The premise is that the three dimensions agree: a real space of dimension 89 (the Hermitian ansatz), a subspace identified with the 65, and the number 24. Equality of dimensions gives a complement of dimension 24. It does not give a map from that complement onto Lambda^2(U)^G, and "so" asserts one. What is missing is the structural statement: a G-invariant Hermitian form H on U_C, restricted to real vectors U x U, is S + iA with S = Re H symmetric and A = Im H antisymmetric, both G-invariant. Conversely every such pair extends uniquely to a Hermitian form. This makes the Hermitian ansatz isomorphic to Sym^2(U)^G (+) Lambda^2(U)^G and makes the sextic depend on S alone. No such argument is on file in the cited lines. The next paragraph's statement "That 24 of the 89 directions are gauge is a theorem" cites no proof either.

(3) Charitable reading. The extension of a real bilinear form to a sesquilinear one is elementary and a reader supplies it. Supplying it is exactly what this loop forbids, and the dimension argument as written would equally "show" that any 24-dimensional complement is Lambda^2. The candidate survives.

What would close it: the restriction isomorphism above, stated and proved for G-invariant forms.

**Verdict, claim 6: GAP.**

## 7. "such a basis forces h real symmetric" (attack item 5)

Under the reading of h in section 0: if (phi_1, ..., phi_m) is a basis of the real space Hom_G(V_lambda, U), then <phi_i(v), phi_j(v)> = c · (phi_i, phi_j) for a fixed normalised v in V_lambda. The pairing (,) is the real inner product on real homomorphisms given by Schur (H4), so h is real symmetric. The transported real structure sigma on the highest-weight space is phi(v_lambda) ↦ conj(phi)(v_lambda), which differs from complex conjugation on U_C (that sends highest to lowest weight vectors). The passage's "real for the real structure sigma" is consistent with this.

**Verdict, claim 7: CONFIRMED, under the reading of h in section 0.**

## 8. The "iff" on a multiplicity-2 block (attack item 5)

The passage: "On a multiplicity-2 block the kernel direction is the imaginary coordinate iff Im h = 0".

Derivation. Fix a sigma-real basis of M_lambda that is orthonormal for the invariant inner product, and let the basis in hand be obtained from it by P in GL(2, C). Then h = P* P. In the real basis the Lambda^2 direction, as a Hermitian form, is iJ. In the basis in hand it is K = i P* J P. It "is the imaginary coordinate" iff K is a real multiple of iJ, which is iff P* J P = cJ with c real.

- Only if. Taking determinants, |det P|^2 = c^2. Write P = alpha P0 with alpha^2 = det P and det P0 = 1, so P0* J P0 = ±J. For any 2x2 matrix, P0^T J P0 = det(P0) J = J. In the + case, (conj P0 - P0)^T J P0 = 0, and since J P0 is invertible, conj P0 = P0, so P0 is real. In the - case, (conj P0 + P0)^T J P0 = 0, so P0 = iR with R real. Either way P = (complex scalar) · (real matrix), and h = P* P = |alpha|^2 R^T R is real. So "kernel direction is the imaginary coordinate" implies Im h = 0. Its contrapositive is what the passage uses to conclude from the measured non-real h. That half holds.
- If. It fails, and the passage's own next sentence shows it.

Three-step record.

(1) Location. [findings/sym3-blocks.md](../findings/sym3-blocks.md) line 128, "the kernel direction is the imaginary coordinate iff $\mathop{\mathrm{Im}}h=0$".

(2) Failure exhibited in closed form. P = Q = diag(1, i). Then h = Q* Q = I, so Im h = 0. The kernel direction is K = i Q* J Q. Here J Q = [[0, i],[-1, 0]] and Q* J Q = diag(1, -i) · [[0, i],[-1, 0]] = [[0, i],[i, 0]], so K = [[0, -1],[-1, 0]]. That is real symmetric, with imaginary coordinate 0, and it is not a multiple of iJ.

(3) Charitable reading. "iff" may be a slip for "only if", and the conclusion drawn needs only that half. That reading saves the argument, not the sentence. The sentence as written asserts both directions, and the "if" half is refuted by the example the same paragraph goes on to give. The candidate survives as REFUTED AS STATED, with no impact on the conclusion.

**Verdict, claim 8: REFUTED AS STATED. The used direction is CONFIRMED AS ALGEBRA.**

## 9. The converse example and the rephasing (attack item 5)

- "Q = diag(1,i) gives h = I with a real symmetric kernel direction, which the split would have kept among the 65." Confirmed by the computation in section 8 (2): K = [[0,-1],[-1,0]] is real symmetric, and a split that takes "imaginary coordinates = gauge" would place it among the 65. Symmetrically, a genuine symmetric direction [[0, s],[s, 0]] in the real basis becomes Q*[[0,s],[s,0]]Q = [[0, is],[-is, 0]], purely imaginary, and that split would discard it.
- "Rephasing one copy by i moves the split while passing the Hermitian assert, det h ≠ 0". For any invertible Q, h' = Q* h Q is Hermitian and det h' = |det Q|^2 det h, which is nonzero when det h is. Confirmed.
- "and the multi-probe test": that test is not defined in the brief. See claim 10.

**Verdict, claim 9: CONFIRMED AS ALGEBRA, except for the multi-probe clause.**

## 10. Measured and sampled statements (attack item 5)

- The measured h = [[1, 55i/37],[-55i/37, 5075/1628]] on (2,0), "reproduced exactly by reviewers 201 and 202", is a computation. It has no derivation on file. It is at least consistent with being the Gram of an inner product: it is Hermitian, with det = 5075/1628 - 3025/1369 = (187775 - 133100)/60236 = 54675/60236 > 0.
- "over 4000 bases consistent with the measured h the relative distance never fell below 0.541". This is a sample minimum over a compact set (the bases with Gram h form a U(2)-orbit). It is not a bound, "relative distance" is undefined in the brief, and no argument is on file. The qualitative consequence (non-real h implies the kernel direction is not the imaginary coordinate) already follows from section 8's "only if" half without this figure.
- "the multi-probe test": undefined in the brief and supported only by a run.

What would have to be proved: the exact h on (2,0) from the constructed highest-weight vectors, and, if the 0.541 figure is to be kept, a closed-form minimum of the distance over the U(2)-orbit.

**Verdict, claim 10: HYPOTHESIS-DEBT.**

## 11. Withdrawn candidates

- **W1, "An SOS Gram is an invariant quadratic form" (line 122).** (1) Location: line 122. (2) Exhibit: a non-invariant Gram for F_5 would refute the sentence read literally. No such Gram can be exhibited in closed form, since whether F_5 has any Gram is the open question the file serves. Step 2 fails. (3) Charitable reading: line 3 of the file sets the programme in the symmetry-reduced setting ("the Gram matrix of such a certificate is block-diagonal"). Withdrawn. The reduction itself (averaging a Gram over Haar measure) is unfiled and is recorded as H6.
- **W2, "they are gauge" read against the PSD cone.** (1) Location: line 126. (2) Exhibit: in a sigma-real basis on a multiplicity-2 block, h = I is PSD, and adding the Lambda^2 direction t·iJ gives [[1, it],[-it, 1]] with eigenvalues 1 ± t, which is not PSD for t > 1. So the 24 are not a symmetry of the Hermitian PSD cone. (3) Charitable reading: the sentence argues only that the 24 map to zero in the sextic, which is claim 5. Setting them to zero loses no feasible point, since H PSD gives Re H = S PSD on real vectors. Passage A makes no claim about translating along them. Withdrawn: step 3.
- **W3, "They appear because the 41 highest-weight vectors were built over Q(i)" (line 130).** (1) Location: line 130. (2) Exhibit: a Hermitian ansatz in a sigma-real basis still has real dimension 89, so the surplus of 24 does not come from the basis. (3) Charitable reading: in a basis that is not sigma-real, the 65 real symmetric forms are not the real matrices, so the construction over Q(i) is what forced a Hermitian ansatz in the first place. The next clause and line 128's "Identifying the actual 24 needs the real structure computed" support that reading. Withdrawn: step 3.
- **W4, cross terms between blocks of equal dimension.** (1) Location: line 126's use of the sums, against the equal-dimension pairs (2,2)_35 and (2,1)_35, and (6,6)_455 and (5,3)_455. (2) Exhibit: none. The invariant pairing between V_lambda and V_mu is Hom_G(V_lambda, V_mu), which is zero for distinct highest weights whatever the dimensions. The Casimirs also differ: 16 against 12, and 96 against 52. Step 2 fails. Withdrawn.
- **W5, O(5) against SO(5).** (1) Location: line 126, "O(5)" with so(5) highest weights. (2) Exhibit: none. -I acts on U as +1 (H1), so the O(5)- and SO(5)-invariants coincide. Step 2 fails. Withdrawn. The fact stays unstated in the passage and is recorded in the inventory.
- **W6, multiplicity-1 edge.** A block with m = 1 contributes 1 to Sym^2 and 0 to Lambda^2, and all 24 Lambda^2 directions sit in the m = 2, 3, 4 blocks (9 + 3 + 12). Nothing fails. Withdrawn.

## 12. Standing items

1. Hypothesis inventory: see the inventory table. The unstated hypotheses that are used are H1, H4, H5 and H6, and H8 is an undefined object. H2 is the load-bearing one without an argument.
2. Quantifier order and scope. The group is O(5), reduced to so(5) by H1. The field is R for the dimensions, and Q(i) enters only through the basis in hand. The basis matters for the coordinate claims (sections 8-9) but not for the dimension claims (sections 1-3). Gram to sextic: the kernel contains Lambda^2 (claim 5). Against the PSD cone, the Lambda^2 directions are removable without loss of feasibility but are not a cone symmetry (W2).
3. Edges. Multiplicity-1 blocks: W6, no finding. Blocks of equal dimension: W4, no finding for L88, and section 2 notes that the 7770 check cannot see a multiplicity exchange between them. Real type: section 4, all 24 labels integral, no finding.
4. Proven against stated. Proven: the sums over the given table, the classical passage from multiplicities to the three dimensions under real type, and that Lambda^2 contributes nothing to the sextic. Stated beyond that: the multiplicities and the dimensions themselves (debt), the identification of the Hermitian surplus with Lambda^2 (gap), a biconditional of which only one half holds (refuted as stated), and sampled figures (debt).
5. Attack items: 1 in sections 1-2, 2 in section 3, 3 in section 4, 4 in sections 5-6 and W2, 5 in sections 7-10, 6 in section 2 and W4. Item 7: not read, since both Lean files are withheld and the brief forbids opening lean/.
6. Falsifiers and what was done to look for each:
   - For 65 and 24: a multiplicity multiset with sum m different from 41 or sum m^2 different from 89, or a non-real block. Every Weyl dimension and the 7770 sum were checked by hand, and the integrality of all labels was confirmed. The character computation that would be needed to test the multiplicities is out of reach without numerical work.
   - For "the 24 are gauge": an antisymmetric invariant form with nonzero sextic. None exists, by the one-line argument in section 5.
   - For the Hermitian surplus being Lambda^2: a Hermitian invariant form whose imaginary part on real vectors is not antisymmetric. None exists, but the argument is not on file (section 6).
   - For the "iff": a basis with Im h = 0 and a non-imaginary kernel direction. Exhibited: Q = diag(1, i).
   - For the "only if" half: a basis with non-real h and an imaginary kernel direction. Excluded by the U(1,1) computation in section 8.
   - For real type: a half-integral label. None among the 24.

## Overall verdict

**HYPOTHESIS-DEBT.** The headline numbers 65 and 24 rest on scripts and on script-derived multiplicities. The conversion from multiplicities to dimensions and the vanishing of Lambda^2 on the sextic are sound. Recorded alongside: a GAP in the inference "so the 24 ... are of Lambda^2" (section 6), and a REFUTED AS STATED biconditional (section 8) whose used direction holds.
