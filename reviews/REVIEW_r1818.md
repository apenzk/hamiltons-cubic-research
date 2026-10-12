# REVIEW r1818, I122 split (Gate 2)

Brief: [BRIEF_I122_split.md](BRIEF_I122_split.md). Source: [2026-09-28-I121-MG-audit.md](2026-09-28-I121-MG-audit.md) lines 132 and 133. Log: [agent_logs/r1818-i122.log](../agent_logs/r1818-i122.log). Screen script: [r1818_i122_checks.py](../scripts/reviewers/r1818_i122_checks.py) (so(4), seconds, run under `sage -python`).

**Verdict: the reduction to one simple subalgebra holds, but claim 2's stated reason for the block split is false and needs the one-line repair below. The identity T = ⟨G^#, G⟩ holds only in a mixed normalisation that the brief's definitions do not state. The table is right for m ≥ 4 and wrong as an equality at m = 3.**

| claim | verdict |
|---|---|
| T(G) = ⟨G^#, G⟩ with I#I = (m−2)I | CONFIRMED with a normalisation correction (N1) |
| 1, maximiser is a positive sharp-eigenoperator | CONFIRMED |
| 2, range semisimple subalgebra, split, power mean | REFUTED in one step, conclusion CONFIRMED with the repair (R1) |
| 3, formula 2h^∨/(I(ρ)√dim h) and table | CONFIRMED for m ≥ 4, with the m = 3 correction (C1) |
| scope, claims 1 to 3 complete without 4 | CONFIRMED: with R1, claim 4 is the only gap for the upper bound |

## The identity T = ⟨G^#, G⟩ (N1)

- With a single inner product ⟨·,·⟩ used both for T's orthonormal A_i and for #'s structure constants, the eigenbasis of G gives ⟨G^#, G⟩ = Σ_α s_α (G^#)_{αα} = ½ Σ s_α s_γ s_δ (c_α^{γδ})² = ½ T(G). This holds in every scaling of the inner product, because both sides then use the same c.
- Scaling: under ⟨X,Y⟩_t = t·tr(XᵀY) the constants scale as c² ∝ 1/t. At t = 1 (Frobenius) the displayed ½cc formula gives I#I = ((m−2)/2)I and T(I/‖I‖) = (m−2)/√C(m,2). At t = ½ (e_i∧e_j orthonormal, Hamilton's convention) it gives I#I = (m−2)I and T(I/‖I‖) = 2(m−2)/√C(m,2).
- So the three stated facts (the ½cc formula, I#I = (m−2)I, T(I/‖I‖) = (m−2)/√C(m,2)) and T = ⟨G^#, G⟩ hold together only when T is taken in the Frobenius inner product and # is computed from the structure constants of the e_i∧e_j basis. The outer pairing ⟨G^#, G⟩ is the Hilbert–Schmidt pairing of operators and does not depend on the choice.
- The brief's "Definitions" line states # in a Frobenius-orthonormal basis. Read literally, that gives I#I = ((m−2)/2)I and T = 2⟨G^#, G⟩. The screen confirms both readings on so(4): Frobenius c gives I#I = 1·I and ⟨G^#,G⟩ = T/2 on a random positive unit G, half-trace c gives I#I = 2I and ⟨G^#,G⟩ = T exactly.
- **Correction**: state the convention: "# is Hamilton's sharp in the e_i∧e_j basis (so I#I = (m−2)I), and T uses the Frobenius inner product". Every downstream value is a ratio or is quoted against T(I/‖I‖) in the same convention, so nothing else moves. No Bianchi or Weyl condition enters: correct.
- Self-dual extremal: T(P_{Λ²₊}/√3) = 2/√3 in this normalisation (screen: 1.1547005). Λ²₊ is the su(2) ideal of so(4) and acts on ℝ⁴ as sp(1) on ℍ, so this is the sp(1) row of the table.

## Claim 1 (CONFIRMED)

- The trilinear form (A,B,C) ↦ ⟨A#B, C⟩ is fully symmetric (c is totally antisymmetric and the index pairs (γ,δ,α), (ε,ζ,β) are exchanged by permuting A, B, C). Hence the gradient of G ↦ ⟨G^#,G⟩ is 3G^#.
- Feasible directions are correctly described. For H symmetric supported on R = range G, G + tH ⪰ 0 for small |t| of both signs because G is positive definite on R. Differentiating the normalised value gives P_R(G^# − λG)P_R = 0. For H = vvᵀ with v ∈ K = ker G, only t ≥ 0 is feasible, and the one-sided derivative is 3vᵀG^#v ≤ 0, so P_K G^# P_K ⪯ 0.
- Positivity without Bianchi: (aaᵀ # bbᵀ)_{αβ} = ½⟨[a,b],e_α⟩⟨[a,b],e_β⟩, so aaᵀ#bbᵀ = ½[a,b][a,b]ᵀ ⪰ 0 on any Lie algebra. Bilinearity gives G^# ⪰ 0 for G ⪰ 0.
- G^# ⪰ 0 with P_K G^# P_K ⪯ 0 forces P_K G^# P_K = 0, and a positive matrix with a zero diagonal block has zero off-diagonal blocks, so G^#P_K = 0. With the R block this gives G^# = λG.
- λ > 0 for m ≥ 3, since I/‖I‖ already gives a positive value. This settles the brief's λ = 0 question: the maximiser has λ > 0.

## Claim 2 (REFUTED in one step, conclusion CONFIRMED with R1)

- Range: G^# = ½Σ s_i s_j [A_i,A_j][A_i,A_j]ᵀ is a sum of positive rank-one terms, so range G^# = span{[A_i,A_j] : s_i s_j > 0} = [V,V] with V = range G. CONFIRMED.
- Subalgebra and semisimplicity: G^# = λG with λ > 0 gives [V,V] = V, so V is a perfect subalgebra of the compact algebra so(m), hence reductive with zero centre, hence semisimple. CONFIRMED. Simple ideals of V are mutually orthogonal in the Frobenius inner product (x = Σ[a,b] in h₁ gives ⟨[a,b],y⟩ = −⟨b,[a,y]⟩ = 0 for y in h₂).
- **The step "brackets between distinct ideals vanish, so G^# is block-diagonal over the simple ideals" is false.** In an ideal-adapted basis, c_α^{γδ} ≠ 0 needs α, γ, δ in one ideal, so (G^#)_{ℓm} = ½ c^{(ℓ)} c^{(m)} G_{ℓm} G_{ℓm}: the off-diagonal block of G^# is quadratic in the off-diagonal block of G, and is zero only when that block is. Counterexample on so(4) = su(2)₊ ⊕ su(2)₋: G = aaᵀ + bbᵀ with a = p₁ + q₁, b = p₂ + q₂ (p in Λ²₊, q in Λ²₋) has G^# = [a,b][a,b]ᵀ and [a,b] = [p₁,p₂] + [q₁,q₂], so the (+,−) block of G^# is [p₁,p₂][q₁,q₂]ᵀ ≠ 0 (screen: norm 1.0). The argument as written is circular: it assumes G block-diagonal to conclude G^# is.
- **Repair R1.** The same index count shows (G^#)_{ℓℓ} = G_{ℓℓ} # G_{ℓℓ} depends only on the diagonal block. Let D = ⊕_ℓ G_{ℓℓ} be the block pinching, which is positive and has D^# = ⊕_ℓ (G^#)_{ℓℓ}. At a maximiser G^# = λG, so T(D) = Σ_ℓ ⟨(G^#)_{ℓℓ}, G_{ℓℓ}⟩ = λ Σ_ℓ ‖G_{ℓℓ}‖² = λa with a = ‖D‖². If some off-diagonal block is nonzero then a < 1 and T(D/√a) = λ/√a > λ, contradicting maximality. So every maximiser is block-diagonal, G = ⊕ G_ℓ, which is the claim's conclusion.
- Power mean: T(G) = Σ_ℓ ‖G_ℓ‖³T(Ĝ_ℓ) ≤ max_ℓ T(Ĝ_ℓ)·Σ‖G_ℓ‖³ ≤ max_ℓ T(Ĝ_ℓ), using T ≥ 0 and ‖G_ℓ‖ ≤ 1. Since G is a maximiser, some Ĝ_ℓ attains the supremum and has range exactly the simple ideal h_ℓ. CONFIRMED.

## Claim 3 (CONFIRMED for m ≥ 4, correction C1 at m = 3)

- Formula. For G = P_h/√d, d = dim h, T = d^{−3/2} Σ_{α,β,γ ∈ h} ⟨[e_α,e_β],e_γ⟩² = d^{−3/2}·d·K with K = −tr(ad e)² for a Frobenius-unit e in h. The Frobenius form is −tr_ρ(xy) and tr_ad = (I(ad)/I(ρ)) tr_ρ with I(ad) = 2h^∨, so K = 2h^∨/I(ρ) and T = 2h^∨/(I(ρ)√d). CONFIRMED. For so(k) on ℝ^k, K = k−2 directly, matching (h^∨, I) = (k−2, 2), including k = 3 where the su(2) data (2, 4) give the same ratio. For sp(1) on ℍ (complexification 2·fundamental, I = 2): 2·2/(2√3) = 2/√3. CONFIRMED.
- Best representation per h. R^m restricted to h is a faithful orthogonal representation, the value is decreasing in I(ρ), indices add over summands and trivial summands add 0. So per h the best is the nontrivial real irreducible of least index. A complex-type or quaternionic-type irrep V realifies to index 2I(V), and the only index-1 irreps (su fundamentals, sp fundamentals) are not of real type, so I(ρ) ≥ 2 always.
- Entries, each rechecked (I in the su-normalisation):

| h, ρ | h^∨, d, I | value | brief |
|---|---|---|---|
| su(k) on ℝ^{2k} | k, k²−1, 2 | k/√(k²−1), 1.0607 at k = 3, decreasing | ≤ 1.061, CONFIRMED |
| su(4) = so(6) on ℝ⁶ | 4, 15, 2 (Λ²C⁴) | 4/√15 = 1.0328 | matches so(6) |
| sp(k) on ℝ^{4k} | k+1, k(2k+1), 2 | (k+1)/√(k(2k+1)), 0.9487 at k = 2 | ≤ 0.949, CONFIRMED |
| sp(2) = so(5) on ℝ⁵ | 3, 10, 2 | 3/√10 | matches so(5) |
| g₂ on ℝ⁷ | 4, 14, 2 | 4/√14 = 1.0690 | CONFIRMED |
| spin(7) on ℝ⁸ | 5, 21, 2 | 5/√21 = 1.0911 | CONFIRMED |
| spin(8) half-spin ℝ⁸ | 6, 28, 2 | 6/√28, same as vector (triality) | covered by so(8) |
| spin(9) on ℝ¹⁶ | 7, 36, 4 | 0.583 | below |
| f₄ on ℝ²⁶ | 9, 52, 6 | 3/√52 = 0.416 | < 0.42, CONFIRMED |
| e₆ on ℝ⁵⁴ | 12, 78, 12 | 0.226 | CONFIRMED |
| e₇ on ℝ¹¹² | 18, 133, 24 | 0.130 | CONFIRMED |
| e₈ on ℝ²⁴⁸ | 30, 248, 60 | 0.064 | CONFIRMED |

- (k−2)/√C(k,2) is increasing in k (its square is 2(k−2)²/(k(k−1))), so so(k) ≤ so(m) for k ≤ m, and every so(k) representation other than the vector has index ≥ 2 and is dominated. Every non-so entry is ≤ 2/√3 with equality only at su(2) on ℝ⁴. So for m ≥ 4 the table maximum is max{2/√3, (m−2)/√C(m,2)}. CONFIRMED.
- **C1, m = 3.** The only nonzero semisimple subalgebra of so(3) is so(3) itself on ℝ³, value 1/√3. su(2) on ℝ⁴ needs m ≥ 4. The table maximum at m = 3 is 1/√3, not max{2/√3, 1/√3} = 2/√3. The inequality "≤ max{…}" survives at m = 3, the "exactly" does not. Correction: restrict the equality to m ≥ 4, or write the m = 3 value separately. The screen in the source ran m = 4 to 7 and does not see this.

## Scope (CONFIRMED)

- With N1, claim 1 and R1: the supremum over positive unit G is attained, and some maximiser is positive definite on one simple subalgebra h ⊂ so(m) with G^# = λG there. The # restricted to h is h's own sharp in the restricted inner product, since every bracket of vectors in h lies in h.
- The lower bound sup T ≥ max over the table holds unconditionally, since each normalised projection is feasible. The upper bound needs exactly claim 4 (a positive definite sharp-eigenoperator on a simple h is scalar, or the value on h is at most the scalar value). Nothing else is missing once R1 replaces the block-diagonal step.
- Claim 4's su(2) case (T = 6g₁g₂g₃τ² in any eigenbasis, AM–GM) is correct: every orthonormal basis of a 3-dimensional simple algebra has the same |⟨[A₁,A₂],A₃⟩|.
- The "Searched, nothing found" literature line was not checked.

## Computation

[r1818_i122_checks.py](../scripts/reviewers/r1818_i122_checks.py), seconds on so(4), to check two values an argument had already fixed: the factor in N1 under both conventions, and the nonzero off-diagonal block of G^# refuting claim 2's step. No sweep, census or search.
