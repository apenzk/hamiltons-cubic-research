# REVIEW r1629: L268_torus_idem and L271_F_slice against the record

Log: agent_logs/r1629.log

Footing: analysis only. The one computation run was `#print axioms` (about 10 s). The uniform-point check below is a hand screen, reported as a screen.

| claim | Lean declaration | verdict |
|---|---|---|
| L268 | L268_torus_idem (with L268_torus_pd, L268_uniform) | CONFIRMED WITH GAPS |
| L271 (1) | L271_F_slice | CONFIRMED |

## Kernel status

`#print axioms` on L268_torus_idem, L271_F_slice, L268_torus_pd and L268_uniform returns `[propext, Classical.choice, Quot.sound]` for each.

## Item (1): torusOp is the record's C

- On a diagonal block, torusMat sends the Cartan coordinate x_k = X(k,1)(k,0) to (Σ_k A_ik x_k) J2. The basis vectors J_k are orthogonal with equal norms, so A is the matrix of C on the Cartan in that basis, independent of the scale of J_k.
- On an off-diagonal block (i,j), the output is U_ij cPart(X_ij) + V_ij aPart(X_ij). A block commuting with J2 has bracket eigenvalue ±(θ_i − θ_j) under ad of the Cartan, so cPart is the root plane of ε_i − ε_j and aPart that of ε_i + ε_j. This matches U_ij = μ_{ε_i−ε_j} and V_ij = μ_{ε_i+ε_j}.
- skewPartM leaves the block unchanged for symmetric U, V. Reason: cPart and aPart commute with transpose because (J B J)ᵀ = J Bᵀ J.
- Normalisation anchor: idOp_eq_torusOp gives I = torusOp 1 onesOff onesOff, and normSq2_idOp_torus gives ‖I‖² = m(2m−1) = dim so(2m). So A is read in an orthonormal Cartan basis, μ is the eigenvalue on R_α, and normSq2 is the trace norm.

## Item (2): Amu

With u_α = α/√2 and α = ε_i ± ε_j, 2 Σ μ_α² u_α u_αᵀ = Σ μ_α² ααᵀ. The diagonal entry is Σ_j (U_ij² + V_ij²) = d_i, and the off-diagonal entry is V_ij² − U_ij². That is Amu exactly.

## Item (3): TorusSystem and the positivity split

- For α = ε_i − ε_j, d_i + d_j − 2V_ij² + 2U_ij² = 4U_ij² + Σ_{l≠i,j}(U_il² + V_il² + U_jl² + V_jl²). The last sum runs over exactly the 4(m−2) roots β with ⟨α,β⟩ = ±1. (UU+VV)_ij = Σ_{l≠i,j}(U_il U_lj + V_il V_lj) covers the 2(m−2) pairs. So the U equation is the record's equation at α. The V equation checks the same way, with (UV+VU)_ij covering the pairs (ε_i−ε_l, ε_l+ε_j) and (ε_i+ε_l, ε_j−ε_l).
- **Record-side wording (G-rec).** Read literally over positive roots, "β+γ=±α" drops the pairs {ε_i+ε_l, ε_j+ε_l}, which combine to α by difference. The count 2(m−2) and the Lean statement both use the reading ±β±γ = ±α. Recommend rewording the record's sum as "pairs {β,γ} of positive roots with β ± γ = ±α".
- The split is faithful in the ⇐ direction. L268_torus_idem (for all pair weights) together with L268_torus_pd (μ > 0 at A = Amu gives positive definite) yields "positive solution ⇒ positive-definite idempotent".
- **Gap G1.** The ⇒ direction's "positive-definite ⇒ μ > 0" is absent from the Lean statements. It is one line from torusOp_rootS (C r_ijt = μ r_ijt, so ⟨C r, r⟩ = μ), but it is not typed.
- **Gap G2.** The record's sentence "a T-invariant symmetric operator is C = A ⊕ ⊕ μ_α I_{R_α}" (completeness of the family) is not typed. torus_op_zero supplies the uniqueness engine (a self-adjoint torus-invariant D that vanishes on the Cartan block and on each root diagonal is zero), but L268 is stated over torusOp only. Downstream uses that start from an arbitrary T-invariant idempotent therefore rest on the prose.
- **Gap G3.** "The uniform point solves it exactly when c = 2(m−1)": at operator level, L268_uniform proves the "if" direction only. The "only if" direction exists only as the scalar torus_uniform_iff (I117LemmaF.lean, Cartan block, c > 0). The docstring of L268_uniform says "exactly" and points there. The quadratic c² − 2(m−2)c − 4(m−1) = (c − 2(m−1))(c + 2) has the second root c = −2, which the record's μ > 0 excludes.

## Item (4): the unused hypothesis 3 ≤ m

L268_torus_idem_core proves the same iff with no bound on m, so the statement is true for all m. In the record, m ≥ 3 only makes so(2m) simple and makes the neighbour counts 4(m−2) and 2(m−2) nonzero. It plays no part in the iff. The hypothesis only weakens the named theorem, and the core version remains available.

## Item (5): L271_F_slice

The norm identity and the cubic formula match the record term by term: 3 Σ A_ii d_i, −3 Σ_{i≠j} A_ij P_ij Q_ij, ½ tr P³ and ½ tr Q³, with P = U+V, Q = U−V and d = dvec. Ftri is pinned to the record's F(A,B,C) = ⟨A#B,C⟩ by Ftri_sharp and Ftri_idem. Hypotheses: A symmetric and U, V pair weights, which is the record's family.

Hand screen at the uniform idempotent (u = 1/(2(m−1)), A = uI, P = 2u(J−I), Q = 0). F = 3mu² + 4u³m(m−1)(m−2) = mu²(2m−1) = ‖C‖², as ⟨C#C,C⟩ = ‖C‖² requires at an idempotent. This screen does not exercise the sign of the A_ij P Q term.

## Item (6): non-vacuity

U = V = u(J−I) with A = Amu U V satisfies every hypothesis (symmetric, zero diagonal, positive). L268_uniform gives TorusSystem, so the core's ⇐ direction makes this C an idempotent, and L268_torus_pd makes it positive definite.

## Docstrings

- **G4.** The docstring of L268_torus_idem ends "it is positive definite when every weight is positive". The statement carries no such clause (that is L268_torus_pd). Recommend removing the clause or pointing it to L268_torus_pd.
- torus_sum_change, sharpBil2_torus_cart ("the Cartan block of the sharp does not see A"), sharpBil2_torus_root (∓ via rsgn = −1 on t < 2, matching αᵀAα for ε_a − ε_b) and torus_op_zero each claim exactly what they prove.
- **Downstream staleness (G5).** The L270 row of lean/INDEX.md still says L268_torus_idem's "proof is sorry". It is now proved.
