# Review r1819, I122 split (brief [BRIEF_I122_split.md](BRIEF_I122_split.md))

Log: [agent_logs/r1819-i122.log](../agent_logs/r1819-i122.log). Screen script: [scripts/reviewers/r1819_i122_screen.py](../scripts/reviewers/r1819_i122_screen.py) (seconds of compute, a screen of values already derived by hand below, not evidence for any positive claim).

**Verdict: the reduction to one simple subalgebra holds, but claim 2's block-diagonal step is a non sequitur as written and needs the repair given below. The table is right entry by entry and complete for m ≥ 4. At m = 3 the stated formula is false.**

| claim | verdict |
|---|---|
| T(G) = ⟨G^#, G⟩, factor and normalisation | CONFIRMED |
| 1, the maximiser is a positive sharp-eigenoperator | CONFIRMED |
| 2, range a semisimple subalgebra, the split, the power mean | REFUTED as written (one step is a non sequitur), conclusion CONFIRMED after the repair below |
| 3, the formula 2h^∨/(I(ρ)√dim h) | CONFIRMED |
| 3, the table entries | CONFIRMED, every entry |
| 3, "the maximum over this table is exactly max{2/√3, (m−2)/√C(m,2)}" | REFUTED at m = 3, CONFIRMED for m ≥ 4, table complete |
| 4 / scope | claims 1 to 3 (with the repair) reduce the problem to claim 4 exactly, and claim 4 is already settled at m = 4 |

## The identity T(G) = ⟨G^#, G⟩

- For rank-one operators, aa^T # bb^T = ½ w w^T with w_α = c_α^{γδ} a_γ b_δ. With c the commutator constants in a Frobenius-orthonormal basis, ad-invariance gives Σ_{γδ} c_α^{γδ} c_β^{γδ} = ⟨e_α, (−Σ_γ ad_γ²) e_β⟩ = (m−2)δ_{αβ}, since the Frobenius Casimir of so(m) is (m−2)I. So I#I = (m−2)/2 · I with the true constants.
- The record's normalisation I#I = (m−2)I therefore means c_rec = √2 c_true. Then aa^T # bb^T = [a,b][a,b]^T with the plain commutator, and trilinearity gives ⟨G^#, G⟩ = Σ s_i s_j s_k ⟨[A_i,A_j],A_k⟩² = T(G). The factor is right.
- T(I/‖I‖) = C(m,2)^{-3/2} Σ_{ij} ‖[A_i,A_j]‖² = (m−2)/√C(m,2). Confirmed.
- No Bianchi or Weyl condition enters: the identity is the bilinear expansion of # alone.
- The screen reproduces the identity on a random positive G on so(5) to 4 × 10⁻¹⁶ and I#I = (m−2)I on the diagonal.
- The self-dual value: the Frobenius Casimir of so(4) restricted to the ideal Λ²_+ is 2, so the normalised projection has T = 3·2/3^{3/2} = 2/√3. Confirmed. Whether it is "the extremal" at m = 4 is proved below under scope. The literature line was not assessed.

## Claim 1

- Existence: the feasible set is compact and T is continuous.
- ⟨A#B, C⟩ is a fully symmetric trilinear form (on rank ones it is ⟨[a,b],c⟩², symmetric by ad-invariance), so the derivative of T at G along H is 3⟨G^#, H⟩.
- Directions H = P_R X P_R keep G + tH positive for small |t| of either sign, since G is positive definite on its range. With the sphere multiplier, 3P_R G^# P_R = 2νG, and pairing with G gives 2ν/3 = λ = ⟨G^#, G⟩. Correct.
- Directions H = kk^T with k ∈ ker G: ⟨G, kk^T⟩ = 0, so the normalisation is 1 + O(t²) and the one-sided derivative 3⟨G^#, kk^T⟩ must be ≤ 0. So P_K G^# P_K ⪯ 0. Correct.
- The argument uses a subfamily of the feasible directions. That is legitimate for necessary conditions, and the full tangent cone is never needed.
- Positivity: G^# = Σ s_i s_j [A_i,A_j][A_i,A_j]^T is a nonnegative combination of rank-one positive operators. It holds on all of so(m) with no curvature condition.
- G^# ⪰ 0 and P_K G^# P_K ⪯ 0 give k^T G^# k = 0 for every k ∈ ker G, hence G^# k = 0. So G^# P_K = 0, the off-diagonal block vanishes, and G^# = P_R G^# P_R = λG. Confirmed.

## Claim 2

**Correct steps.**
- range G^# is exactly span{[A_i,A_j] : s_i s_j > 0}, the range of a positive sum of rank ones.
- λ > 0 for m ≥ 3, since T(I/‖I‖) > 0. Then range G = range G^# = V, so V is closed under brackets. It is a subalgebra of a compact algebra, hence reductive, and V = [V,V] kills the centre. λ = 0 would force V abelian and T = 0, which is never a maximum for m ≥ 3.
- The simple ideals h_ℓ of V are Frobenius-orthogonal: x ∈ h_ℓ is a sum of brackets [u,v] in h_ℓ, and ⟨[u,v],y⟩ = −⟨v,[u,y]⟩ = 0 for y ∈ h_{ℓ'}.
- The power mean: T(Ĝ_ℓ) ≥ 0 and ‖G_ℓ‖ ≤ 1 give Σ‖G_ℓ‖³T(Ĝ_ℓ) ≤ max_ℓ T(Ĝ_ℓ). It is strict unless one block carries all the norm.

**The broken step.** "Brackets between distinct ideals vanish, so G^# is block-diagonal over the simple ideals" does not follow.
- In a basis adapted to the ideals, c_α^{γδ} (with γ, δ ∈ V) is nonzero only when α, γ, δ lie in one ideal. So (G^#)_{ℓℓ'} = ½ c^ℓ c^{ℓ'} G_{ℓℓ'} G_{ℓℓ'}, a quadratic in the off-diagonal block G_{ℓℓ'}.
- G^# is block-diagonal exactly when G is. The sentence assumes what it concludes. Nothing up to that point excludes a positive G with range V and nonzero G_{ℓℓ'}, since the eigenvectors of G need not lie in single ideals.

**Repair (valid, uses maximality and not only the eigen-equation).**
- The same index count shows (G^#)_{ℓℓ} depends only on G_{ℓℓ}. So G^# = λG gives G_{ℓℓ}^# = λ G_{ℓℓ} on each ideal.
- Let D = ⊕_ℓ G_{ℓℓ}, the pinching, which is positive. Then T(D) = Σ_ℓ ⟨G_{ℓℓ}^#, G_{ℓℓ}⟩ = λ Σ‖G_{ℓℓ}‖² = λ(1−δ), where δ = Σ_{ℓ≠ℓ'} ‖G_{ℓℓ'}‖² and ‖D‖² = 1−δ.
- So T(D/‖D‖) = λ/√(1−δ), which is greater than λ when δ > 0 (note 1−δ > 0, since a positive G with range V has nonzero diagonal blocks). That contradicts maximality, so δ = 0 and G is block-diagonal. The power-mean step then applies as written.
- Worked check that the gap is real in shape but harmless in the eigen-family: on so(4) = su(2) ⊕ su(2), Hamilton's block formula gives G^# = [[A^#, B^#],[B^{#T}, C^#]] with 3×3 cofactor sharps. Solving A^# = λA, C^# = λC, B^# = λB with G positive definite forces A = C = aI and B ∈ {0, ±a·orthogonal}. The orthogonal case has range the diagonal su(2) and is singular. So on so(4) the eigen-equation alone already forces block-diagonality, but the written argument does not show this in general. The pinching argument does.

## Claim 3

**The formula.** For an orthonormal basis A_i of h in the Frobenius metric ⟨X,Y⟩ = −tr_ρ(XY):
- Σ_{j,k} ⟨[A_i,A_j],A_k⟩² = ‖ad_{A_i}‖²_{HS} = −tr_ad(ad_{A_i}²).
- With tr_ad = (I(ad)/I(ρ)) tr_ρ and I(ad) = 2h^∨ in the normalisation where the fundamental of su(k) has index 1, this equals 2h^∨/I(ρ).
- So T(P_h/√d) = d · (2h^∨/I(ρ))/d^{3/2} = 2h^∨/(I(ρ)√d). Confirmed.
- Consistency checks: so(k) on R^k, with h^∨ = k−2 and I = 2, gives (k−2)/√C(k,2). so(3) on R³ has h^∨ = 2 and I = 4 (spin 1), so it gives 1/√3, which agrees with the so(k) line at k = 3. su(2) on H has complexification 2·C², so I = 2 and κ = 4/(2√3) = 2/√3.
- A useful restatement for claim 4: scaling the metric by I(ρ) scales T by 1/I(ρ) under the orthonormal identification. So the maximisation on h is independent of ρ, and ρ enters only through the factor 1/I(ρ).

**The table**, with I the index of the complexified real representation:

| h, representation | h^∨, dim h, I | κ | stated | check |
|---|---|---|---|---|
| sp(1) ≅ su(2) on R⁴ = H | 2, 3, 2 | 2/√3 = 1.1547 | 2/√3 | yes, screened |
| so(k) on R^k | k−2, C(k,2), 2 | (k−2)/√C(k,2), increasing in k to √2 | yes | yes, screened k = 3, 4, 5 |
| su(k) on R^{2k}, k ≥ 3 | k, k²−1, 2 | k/√(k²−1), decreasing, 1.0607 at k = 3 | ≤ 1.061 | yes, su(3) screened |
| sp(k) on R^{4k}, k ≥ 2 | k+1, k(2k+1), 2 | (k+1)/√(k(2k+1)), 0.9487 at k = 2 | ≤ 0.949 | yes, sp(2) screened |
| g₂ on R⁷ | 4, 14, 2 | 4/√14 = 1.0690 | 1.069 | yes |
| spin(7) on R⁸ | 5, 21, 2 | 5/√21 = 1.0911 | 1.091 | yes |
| f₄ on R²⁶ | 9, 52, 6 | 0.416 | < 0.42 | yes, the tightest of the four |
| e₆ on R⁵⁴ | 12, 78, 12 | 0.226 | < 0.42 | yes |
| e₇ on R¹¹² | 18, 133, 24 | 0.130 | < 0.42 | yes |
| e₈ on R²⁴⁸ | 30, 248, 60 | 0.064 | < 0.42 | yes |

**Completeness and coincidences.**
- The index is additive, and a real representation of complex or quaternionic type has I equal to twice that of its complex irreducible. So the minimum index of a faithful real representation is 2 for every classical algebra and larger for the exceptional ones. Reducible representations only raise I and lower κ.
- The representations with I = 2 are: the vector of so(k); the realified fundamentals of su(k) and sp(k); the spinors of so(7) and so(8), which are spin(7) and triality images of so(8)'s vector, with the same value 6/√28; and Λ²C⁴ of su(4), which is so(6)'s vector. The spinors of so(k) for k ≥ 9 have I ≥ 4.
- The low-rank coincidences are consistent: so(5) on R⁵ and sp(2) on R⁸ both give 3/√10, and so(6) on R⁶ and su(4) on R⁸ both give 4/√15.
- One observation the table does not make: su(3) on R⁶ gives 1.0607 > 4/√15 = 1.033 for so(6). It does not beat 2/√3, so the formula survives.
- For 4 ≤ m ≤ 8 the maximum is 2/√3. For m ≥ 9 it is (m−2)/√C(m,2), since 7/6 > 2/√3 and every non-orthogonal entry stays below 1.155. The formula holds for every m ≥ 4.

**Correction, m = 3.** The su(2) on R⁴ entry needs m ≥ 4. At m = 3 the only nonabelian subalgebra is so(3) on R³, with κ = 1/√3. So the table's maximum is 1/√3, while the formula max{2/√3, 1/√3} gives 2/√3. The sentence should read "for m ≥ 4". The audit's own use is at m ≥ 6, so nothing downstream depends on m = 3.

## Scope and claim 4

- Claims 1 and 2 (repaired) give the following: a maximiser exists, and every maximiser is a positive G with G^# = λG, supported with full range on a single simple subalgebra h ⊂ so(m).
- Claim 3 gives the value of the scalar candidate on each (h, ρ), and the table is complete for m ≥ 4.
- The only remaining gap is whether the maximum of T over unit positive G on h is attained at the scalar operator. That is claim 4, and it is independent of ρ by the scaling remark. If claim 4 holds, sup T = max{2/√3, (m−2)/√C(m,2)} for m ≥ 4.
- Claim 4's su(2) case is correct. Any orthonormal eigenbasis of su(2) has [A_1,A_2] = ±τA_3, so T = 6g_1g_2g_3τ², and AM–GM on Σg_i² = 1 gives the bound.
- Consequence: **at m = 4 the statement is fully proved.** The simple subalgebras of so(4) are all su(2)'s: Λ²_± on H with I = 2, and the diagonal so(3) on R³ ⊕ R with I = 4. So the maximum is 2/√3, attained at the normalised projections onto Λ²_±. This settles "the self-dual extremal" at m = 4. For m ≥ 5 it waits on claim 4 for su(3), sp(2), so(k ≥ 5), g₂ and spin(7) among the rest.
