# REVIEW r1119: I73 seven-frame lemma, triangle side

Log: [agent_logs/r1119.log](../agent_logs/r1119.log). Claim under review: [2026-09-24-I73-seven-frame-stability.md](2026-09-24-I73-seven-frame-stability.md), triangle side. Brief: [2026-09-24-I73-gate2-brief.md](2026-09-24-I73-gate2-brief.md).

**Overall: the triangle side survives. No step is refuted.** Two small corrections (the final constant rounds to 53.043, and the definition of E as the top eigenspace must be stated to break an apparent circularity in the assembly), plus a scope remark that slightly widens what the argument covers.

| Item | Verdict |
|---|---|
| 1 | CONFIRMED |
| 2 | CONFIRMED, with the statement made precise |
| 3 | CONFIRMED, with a wording correction |
| 4 | CONFIRMED |
| 5 | CONFIRMED |
| 6 | CONFIRMED (the J bound is conservative) |
| 7 | CONFIRMED |
| 8 | CONFIRMED, constant 53.04 corrected to 53.043 |
| 9 | CONFIRMED scope, with a widening remark |
| Lean | CONFIRMED: statements match the note, the three cases cover all of spec(A on E-perp) |

## Screen

One seconds-scale screen ([r1119.py](/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d3790d3b-3383-4c5d-9548-46ea15965c86/scratchpad/r1119.py), scratchpad, n = 8, one near-triangle X0 with angles proportional to (0.60, 0.57, 0.55, 0.10)). It is a screen of the hand derivations below and carries no positive weight: the top-6 eigenspace of A equals m_J' (all principal cosines 1), energy 24.000, sum of e_a^T e_a = 2 I_W, Q(J/√3) = 8, Q(su(3) unit) = 2, Q(W∧W-perp unit) = 2, cross term 1e-15, y = 8B + 2Δ and d² = B + Δ/3 to 1e-14. Arithmetic cross-check reported under item 8.

## Item 1: CONFIRMED

- row_0 = 8 - x counts each pair (0, j) once, and the sum over j ≥ 1 of row_j contains the same pairs once more, so T = 2 row_0 + T' = 16 - 2x + T'.
- δ_i ≥ x for all seven gives T = 56 - Σδ_i ≤ 56 - 7x.
- T > 54.064 forces 7x < 1.936, so x < 0.27657 < 0.277.

## Item 2: CONFIRMED, made precise

- Write X0 = Σ a_k J_k with a_k > 0 on oriented planes P_k. On Hom(P_k, P_l) the operator -ad² splits into the J-linear piece (eigenvalue (a_k - a_l)²) and the J-antilinear piece ((a_k + a_l)²). The split uses only the oriented planes, so the slot spaces are angle-independent.
- The precise invariant statement: with W = P1 ⊕ P2 ⊕ P3 and J' the complex structure on W that orients X0 positively, E = m_J' = {Y ∈ so(W) : YJ' = -J'Y}. The J_k are J'-linear, so so(P_k) sits in u(3) and m_J' is exactly the three antilinear slots (6 = 3·2 dimensions).
- Repeated angles: at the exact triangle the planes are not unique, but J' is, so E = m_J' is unique. Near the triangle (y < 0.277 forces B < 0.035, every leftover angle below 0.19, every triangle angle near 0.58) W is separated from the leftover planes, so W and J' are well defined.
- Zero angles: the kernel slots Hom(P_k, K) have dimension 2·dim K, one 2-dimensional slot per kernel basis vector. They lie in E-perp and affect only the gap (item Lean). They do not touch E.

## Item 3: CONFIRMED, wording correction

- row_0 = Σ_j <A X_j, X_j> = tr(AΠ), with Π the rank-6 projector onto the partners. A is block-diagonal on E ⊕ E-perp, so tr(AΠ) = tr(A_E Π_EE) + tr(A_⊥ Π_⊥⊥).
- 0 ≤ Π_EE ≤ I_E and tr(I_E - Π_EE) = η, so tr(A_E Π_EE) ≤ tr A_E - λ_min(A_E) η. Also tr(A_⊥ Π_⊥⊥) ≤ λ_max(A_⊥) η. Summing gives row_0 ≤ tr A_E - gη, hence (2). The partners need no orthogonality to E: only the trace and the operator bound of the compression are used. The inequality holds for g of any sign.
- **Correction.** The assembly says "x < 0.277 and y ≤ x give g > 0", while y ≤ x itself needs E to be a top-6 eigenspace of A (Ky Fan: row_0 ≤ top-6 sum). Read literally this is circular. It resolves by definition: in the triangle case E is the top-6 eigenspace, the case hypothesis being that the top three slots are the pairwise + slots of three planes. Then g ≥ 0 and y ≤ x hold by hypothesis and Ky Fan, and the gap lemma upgrades to g ≥ 2(0.277 - y) > 0. The note should say "E is the top-6 eigenspace of A, and in this case it is the triangle's" rather than leave "top configuration" to carry it.

## Item 4: CONFIRMED

- Value 24: [m, m] ⊆ u(3) (antilinear times antilinear is linear), so Σ_{a,b} ||[e_a, e_b]||² = Σ_c Σ_{a,b} <e_a, [e_b, f_c]>² = Σ_c tr(-ad_{f_c}² on m) over an ONB f_c of u(3). Independent check by the Killing form: for unit Z in so(6), tr(-ad_Z² on so(6)) = 2(6 - 2) = 8, so the sum of tr(-ad_f² on m) over an ONB of all of so(6) is 6·8 = 48. The m-part and the u(3)-part of that sum each equal the energy, so the energy is 24. That matches 8·2 + 1·8.
- Compression: Σ_{j,k} ||[Y_j, Y_k]||² = tr((G⊗G) M), with G = Π_EE the Gram operator of the Y_j on E and M = C*C ≥ 0 for the bracket map C: E⊗E → so(n). 0 ≤ G ≤ I gives G⊗G ≤ G⊗I ≤ I⊗I, so the total is at most tr M = 24. The diagonal j = k terms vanish.

## Item 5: CONFIRMED

In so(n), E-perp = u(3)_J' ⊕ (W∧W-perp) ⊕ so(W-perp). [m, u(3)] ⊆ m, [m, W∧W-perp] ⊆ W∧W-perp, and [m, so(W-perp)] = 0. All three are orthogonal to u(3) ⊇ [m, m]. The directions outside so(W) are therefore covered, and the terms of T' linear in D vanish pair by pair.

## Item 6: CONFIRMED, the J bound is conservative

- Σ_j ||[Y_j, D]||² = tr(P_E(-ad_D²)P_E · Π_EE) ≤ Q(D), since the operator is PSD and Π_EE ≤ I.
- Q is U(3)-invariant. The three summands of E-perp bracket m into mutually orthogonal spaces (m, W∧W-perp, 0), so they carry no cross terms. On u(3) = su(3) ⊕ RJ the two pieces are inequivalent irreducibles (su(3) is absolutely irreducible), so Q = c₁ on su(3), c₂ on RJ, with no cross term.
- c₂ = Q(J/√3) = 6·(4/3) = 8. c₁ = (24 - 8)/8 = 2.
- On W∧W-perp: with D = [[0, M], [-M^T, 0]], ||[D, Y]||² = ||YM||_F², so Q(D) = tr(M^T S M) with S = Σ_a e_a^T e_a. S commutes with U(3) and is symmetric, so S = cI. Its trace Σ||e_a||_F² = 12 gives c = 2, and Q = 2||D||².
- Result: Q(D) = 2||D||² + 6c², with c the component of D along Ĵ = J/√3.
- **J bound.** X0 ∈ u(3)_J' ⊕ so(W-perp) ⊆ E-perp, so <D_j, X0> = <X_j, X0> - <Y_j, X0> = 0. Also c_j = <D_j, Ĵ> with Ĵ ∈ E-perp. Hence |c_j| ≤ ||D_j|| sin θ, θ the angle between Ĵ and X0, and sin²θ = 1 - σ²/3 = B + Δ/3 ≤ y/6. So c_j² ≤ ||D_j||² y/6, which is **stronger** than the note's y/(6 - y) (tan² in place of sin²). The note's bound is valid. Using sin² would lower 9.16 to 9.11.
- ||b||² ≤ 2Σ_{j≠k}(||[Y_j, D_k]||² + ||[D_j, Y_k]||²) = 4Σ_{j≠k}||[Y_j, D_k]||² ≤ 4Σ_k Q(D_k) ≤ 4(2 + 6·0.277/5.723)η = 9.1616η.

## Item 7: CONFIRMED

- T' = ||a + b + c||² in the direct sum over ordered pairs j ≠ k, with a ⊥ b pairwise by item 5. So T' = ||a||² + ||b||² + ||c||² + 2<a,c> + 2<b,c> ≤ (||a|| + ||c||)² + ||b||² + 2||b|| ||c||, bounding both remaining cross terms by Cauchy-Schwarz. This is (3).
- ||c||² ≤ (4/3)η² is Ge's n ≥ 4 constant, 2/3 in Frobenius norm, converted correctly. I checked it against the transcription in [notes.md](../references/ge-2014-ddvv-skew-symmetric/notes.md). Ge sums over all ordered r, s, which contains the j ≠ k sum.
- (3) is increasing in η and ||b||, so substituting upper bounds is legitimate. The -2x term is dropped, which only loosens the bound.

## Item 8: CONFIRMED, constant corrected

- The gap lemma gives ½g ≥ 0.277 - y > 0. With (2), η ≤ (x - y)/g ≤ (x - y)/(2(0.277 - y)) < ½, because x < 0.277.
- **Arithmetic.** ||c|| ≤ √(4/3)/2 = 0.57735, ||b||² ≤ 4.5808, ||b|| ≤ 2.1403. Then T ≤ 16 + (4.89898 + 0.57735)² + 4.5808 + 2(2.1403)(0.57735) = 16 + 29.9922 + 4.5808 + 2.4714 = **53.043**. The note's "≤ 53.04" comes from rounding 0.57735 down to 0.577 and 4.5808 down to 4.58. The margin to 54.064 is unaffected. Write 53.05, or 53.00 if the sin² bound of item 6 is used.

## Item 9: CONFIRMED scope, with a widening remark

- **Assumed:** n ≥ 6 (a triangle needs three planes). X0's top-6 eigenspace of -ad² is the triangle's three + slots. Nothing is assumed about the kernel (its slots enter only the gap, and the Lean statements cover them) or about the other six rows beyond δ_i ≥ x.
- **Widening:** minimality of x is used only to get x < 0.277. The decomposition T = 16 - 2δ_i + T'_i holds for every i. So the argument covers every frame that has **some** triangle-type element with δ_i < 0.277. Frames with every δ_i ≥ 0.277 already satisfy T ≤ 54.061. The open case is therefore exactly: every element of deficit below 0.277 is star-type or of another class. This is slightly smaller than "the minimum-deficit element is not a triangle".
- **Owed and not part of this side:** the neighbourhood size (other three-slot classes, the kernel-slot classes bounded only by 3 + 1) matters only for classifying elements as triangle, star or other. The triangle side takes "triangle-type" as its hypothesis and does not use the bound.

## Lean: CONFIRMED

- yT = 8(1 - S) + 2Δ = 8 - 4S - 4P = 8 - tr(A_E), with tr(A_E) = 2Σ_{k<l}(a_k + a_l)². sig_eq is the identity σ² = S + 2P. Both match the note's y and constraint.
- The hypotheses a_k, b ≥ 0 and Σa_k² + b² ≤ 1 carry no ordering, so each statement holds for every labelling. The note's "relabel the minimal pair as (1, 2)" is covered, and so is the symmetric case a1 ↔ a2 of triangle_gap_same (yT and hs are symmetric).
- **Coverage of spec(A on E-perp)**, with (a1 + a2)² the least E eigenvalue:
  - (a3 + b_m)²: triangle_gap_other.
  - (a1 + b_m)², (a2 + b_m)²: triangle_gap_same, up to the a1 ↔ a2 swap.
  - (a_k - b_m)² ≤ (a_k + b_m)²: the two above.
  - Kernel slots a_k²: other or same with b = 0.
  - Triangle difference slots (a_p - a_q)² ≤ max(a_p, a_q)²: same with b = 0.
  - so(P_k), eigenvalue 0: trivial.
  - Leftover pairs (b_m ± b_m')² ≤ 2(b_m² + b_m'²) ≤ 2B, and leftover kernel slots b_m² ≤ B: triangle_gap_small.
  - so(W-perp) blocks with eigenvalue 0: trivial.
- The list is exhaustive for the plane/kernel decomposition of R^n.
