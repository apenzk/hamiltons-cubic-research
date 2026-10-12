# Review r1120: I73 seven-frame lemma, triangle side (Gate 2)

Log: [agent_logs/r1120.log](../agent_logs/r1120.log)

**Verdict: the triangle side holds as a conditional result.** Every step I attacked survives. There is one arithmetic slip in the fourth significant figure: the final bound is 53.0424, where the note says "≤ 53.04". The note also leaves two hypotheses implicit, and they should be written in: E is the TOP six-eigenspace of A, and y ≤ x comes from Ky Fan.

| # | Item | Verdict |
|---|---|---|
| 1 | (1) identities and x < 0.277 | CONFIRMED |
| 2 | slot spaces independent of angles | CONFIRMED (with a wording correction) |
| 3 | (R1) and y ≤ x | CONFIRMED (y ≤ x needs E top, stated below) |
| 4 | (R2) energy 24 | CONFIRMED |
| 5 | (R2) orthogonality | CONFIRMED |
| 6 | (R2) leak cost Q and J-bound | CONFIRMED (J-bound is valid and loose) |
| 7 | (R3) expansion | CONFIRMED |
| 8 | assembly | CONFIRMED, arithmetic 53.0424 rather than 53.04 |
| 9 | scope | PLAUSIBLE (conditional on the triangle being the top configuration of the min-deficit element) |
| L | Lean statements | CONFIRMED, the three slot cases cover every eigenvalue of A on E-perp |

## 1. The identities in (1)

- T = Σ_i row_i with row_i = 8 − δ_i, so T = 56 − Σδ_i. Because x is the minimum, Σδ_i ≥ 7x.
- In T, row_0 is counted twice: once through the pairs (0,j) and once through (j,0). So T = 2(8 − x) + T' = 16 − 2x + T'.
- T > 54.064 gives 7x < 1.936, so x < 0.27657 < 0.277.

## 2. Slot spaces and angles

- On the block P_k ⊗ P_l, the (a_k + a_l)² eigenspace is {M : J_k M = −M J_l}. This set depends on the oriented planes only, with the orientation chosen so that a_k ≥ 0.
- So E = ⊕ over the triangle pairs = m(J_W), the anti-J_W-linear part of so(W), where J_W = J_1 + J_2 + J_3.
- **Wording correction.** When angles repeat, the individual slot spaces are not defined, because the planes are not unique. Their sum E = m(J_W) is still well defined, since J_W is the polar part of X_0 on W, and W is the span of the top three planes.
- W is well defined whenever the top three angles are strictly separated from the leftover angles. On the triangle side this holds, because b² ≤ B ≤ y/8 is small.
- A zero angle cannot occur among a_1..a_3 on this side. Zero angles elsewhere only add kernel slots, which are covered in item L.
- Screen at angles (0.60, 0.57, 0.55, 0.10) normalised, n = 9: the top-six eigenspace anticommutes with J_W to 3e-16.

## 3. (R1)

- row_0 = Σ_j ⟨X_j, A X_j⟩ = tr(AΠ). Because A preserves E, this splits as tr(A_E Π_EE) + tr(A_⊥ Π_⊥⊥).
- Two facts about the blocks:
  - 0 ≤ Π_EE ≤ I_E.
  - tr Π_⊥⊥ = η, so tr(I − Π_EE) = η.
- Two bounds follow:
  - tr(A_E Π_EE) ≤ tr A_E − λ_min(A_E)·η.
  - tr(A_⊥ Π_⊥⊥) ≤ λ_max(A_⊥)·η.
- Together they give row_0 ≤ tr A_E − gη, which is (2). The partners need not be orthogonal to E, and none of this uses the rank of Π beyond tr Π = 6.
- **y ≤ x.** This holds exactly when E is the top six-eigenspace. Then tr A_E is the Ky Fan top-6 sum, so row_0 ≤ tr A_E, which is 8 − x ≤ 8 − y. Equivalently, it is (2) with g ≥ 0.
- **Correction to the text.** The note's "x < 0.277 and y ≤ x give g > 0" is sound only if y ≤ x was obtained from "E is top", which means g ≥ 0 first. The gap lemma then upgrades g ≥ 0 to g > 0. The note should say so. As written it reads as if y ≤ x were free.
- y ≥ 0 also holds, because tr A_E is a sum of six eigenvalues and so is at most κ_6.
- y = 8 − tr A_E = 8B + 2Δ. This checks: tr A_E = 2Σ(a_k + a_l)² = 8Σa² − 2Δ.

## 4. (R2) Energy

- Σ_{j,k} ‖[Y_j, Y_k]‖² = tr(M (G⊗G) Mᵀ), where M : E⊗E → so(n) is the bracket and G = Π_EE.
- 0 ≤ G ≤ I gives G⊗G ≤ I⊗I, so the sum is at most tr(MMᵀ) = β_E. The diagonal terms j = k vanish.
- **Triangle value 24.** [m, m] ⊆ u(3) and ad-invariance give Σ_{a,b} ‖[e_a, e_b]‖² = Σ_c tr(−ad²_{f_c}|_m). As a U(3)-module, m ≅ Λ²C³.
  - For f = diag(i, −i, 0)/√2 (unit in su(3)), the weights on Λ² are 0, ±1 over √2, so the trace is 2(0 + 1 + 1)/2 = 2.
  - For Ĵ = J/√3, the three weights are 2/√3, so the trace is 6·(4/3) = 8.
  - The total is 8·2 + 8 = 24.
- Screens agree: β_E = 24 at the exact triangle, at the exact star, and at the perturbed angles above.

## 5. (R2) Orthogonality

- so(n) = u(3) ⊕ m ⊕ (W⊗W^⊥) ⊕ so(W^⊥), and E^⊥ = u(3) ⊕ (W⊗W^⊥) ⊕ so(W^⊥).
- Brackets of E with each piece:
  - [E, E] ⊆ u(3).
  - [E, u(3)] ⊆ m, which is orthogonal to u(3).
  - [E, W⊗W^⊥] ⊆ W⊗W^⊥, which is orthogonal to so(W).
  - [E, so(W^⊥)] = 0.
- So [E, E] ⊥ [E, E^⊥], including the directions outside so(W).
- Screen: 200 random triples gave |⟨[E,E], [E,E^⊥]⟩| ≤ 1.2e-14.
- **This does not make ⟨a, c⟩ vanish.** [E^⊥, E^⊥] ⊇ [u(3), u(3)] meets u(3). The note does not claim it vanishes and handles it in (R3).

## 6. (R2) Leak cost

- **Σ_j ‖[Y_j, D]‖² ≤ Q(D).** The left side is tr(G·C_E(D)) with C_E ≥ 0 and G ≤ I.
- **‖b‖² ≤ 4ΣQ(D_k).** By (u + v)² ≤ 2u² + 2v² and then adding the j = k terms.
- **Q is block-diagonal with the stated values.**
  - [so(W^⊥), E] = 0, so so(W^⊥) contributes 0. This settles the n = 8 case, where so(W^⊥) and RJ are both trivial one-dimensional U(3)-modules. The worry there is a cross term, and it is zero.
  - [so(W), E] ⊆ so(W) and [W⊗W^⊥, E] ⊆ W⊗W^⊥, so the two blocks have no cross terms.
  - On W⊗W^⊥: Q(D) = Σ‖e_a M‖²_F = tr(Mᵀ(Σ e_aᵀe_a)M) = 2‖D‖², since Σ_{a∈m} e_aᵀe_a = 2I_W by U(3)-invariance and trace 12.
  - su(3) and RJ are inequivalent summands, so there is no cross term between them. The values are 2 and 8, as in item 4.
- Screen at the perturbed angles: spec Q on E^⊥ is {0, 2, 8}, and Q(Ĵ) = 8.
- **J-component bound.** The claim is valid and loose.
  - Write X_0 = cosθ Ĵ + sinθ Z. Then D ⊥ X_0 gives c² ≤ ‖D‖² sin²θ, which is sharper than the note's tan²θ.
  - sin²θ = 1 − σ²/3 = B + Δ/3 ≤ y/6.
  - Screen: max c²/‖D‖² = 0.011296 = 1 − σ²/3 exactly, against the note's y/(6 − y) = 0.01486.
  - Q ≤ 2‖D‖² + 6c² follows. At y ≤ 0.277 this gives 4ΣQ ≤ 9.1616η.
- **Optional tightening.** Using sin² in place of tan² gives y/6 = 0.0462 against 0.0484 and changes nothing material.

## 7. (R3)

- ‖a + b + c‖² = ‖a‖² + ‖b‖² + 2⟨a, c⟩ + 2⟨b, c⟩ + ‖c‖². Apply Cauchy-Schwarz to both cross terms.
- The result is (‖a‖ + ‖c‖)² + ‖b‖² + 2‖b‖‖c‖, which is (3).
- **Ge constant.** The Ge notes give 2/3 in Frobenius norm for n ≥ 4, over ordered (r, s). In this norm that becomes ½·(2/3)·(2Σ‖B‖²)² = (4/3)(Σ‖B‖²)², so 4/3 is correct and sharp. At n = 3 the Frobenius constant is 1/3, which is smaller, so 4/3 still holds.
- **Optional tightening.** (√(‖a‖² + ‖b‖²) + ‖c‖)² is smaller, but it is not needed.

## 8. Assembly

- The gap lemma gives g ≥ 2(0.277 − y) > 0. So η ≤ (x − y)/(2(0.277 − y)) < ½, because x < 0.27657 < 0.277.
- Every term of (3) increases with η, and dropping −2x only loosens the bound.
- **Exact values:**
  - ‖c‖ ≤ 0.57735.
  - ‖b‖² ≤ 4.58081 and ‖b‖ ≤ 2.14028.
  - (√24 + 0.57735)² = 29.9902.
  - 2‖b‖‖c‖ = 2.4714.
  - T ≤ **53.0424**.
- **Correction.** The note writes "≤ 53.04", which is 0.0024 too small. It should read ≤ 53.05, or ≤ 53.043. The margin to 54.064 is about 1.02, so the conclusion is unaffected.
- The gap lemma's worst value: numerical minimisation over the three slot expressions (SLSQP, 300 starts, seconds) gives 0.394 (other), 0.459 (same) and 0.628 (small). This agrees with the note's "about 0.38", which is slightly pessimistic.

## 9. Scope

- **Covered:** every orthonormal seven-frame in so(n) with n ≥ 6, uniformly in n, with or without a kernel of X_0, whose minimum-deficit element X_0 has as its top six-eigenspace of −ad²_{X_0} the triangle configuration on its three largest angles.
- **Not covered, and still owed:**
  - The star side.
  - The size of the neighbourhood, meaning a bound below 7.7234 on the top-6 sum for every other three-slot class. Without it, a min-deficit element with row_0 > 7.723 is not yet known to be a triangle or a star.
- Nothing is assumed about the other six rows beyond δ_i ≥ x. The argument does not need the partners to be orthogonal to E.
- **Implicit hypothesis to write in.** "Triangle side" must mean that E is the top six-eigenspace, or at least g ≥ 0. Item 3 uses this for y ≤ x. Among triangles, the top one is always on the three largest angles, because Σ_{S pairs}(a_k + a_l)² is increasing in each a_k.

## L. Lean statements

[SevenFrameGap.lean](../lean/HamiltonsCubic/Results/SevenFrameGap.lean) proves its statements for all a_i, b ≥ 0 with Σa² + b² ≤ 1. There is no ordering hypothesis, so relabelling is free, and yT is symmetric. yT matches y = 8B + 2Δ. The competing eigenvalues on E^⊥, with E-slot (a1 + a2)², are covered as follows:

| Competing slot | Covered by |
|---|---|
| (a_3 ± b_m)² ≤ (a_3 + b)² | `triangle_gap_other` |
| (a_{1,2} ± b_m)² ≤ (a_{1,2} + b)² | `triangle_gap_same`, relabelling a1 ↔ a2 |
| Kernel slot a_k² | `same` or `other` with b = 0, by position |
| Difference slot (a_p − a_q)² ≤ max(a_p, a_q)² | `same` or `other` with b = 0 |
| (b_m ± b_m')² ≤ 2B | `triangle_gap_small` |
| Kernel slots b_m² ≤ B, and the zero eigenvalues (J_k, so(ker), X_0) | `triangle_gap_small`, since the lemma is monotone in the competitor |

- A competitor on two triangle planes is either an E slot or a difference slot, and both are handled.
- **Coverage is complete.** The statements say what the note needs: the right slots, the right y, and the constraint that B is the mass off the triangle.
