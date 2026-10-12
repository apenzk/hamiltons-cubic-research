# REVIEW r1224: I117 batch 34 (Lemma D, U's general form, the CP obstacle)

Log: [agent_logs/r1224.log](../agent_logs/r1224.log). Block under audit: [2026-09-26-I73-class-ceiling.md](2026-09-26-I73-class-ceiling.md), section "Batch 34". Screen script (n = 5, seconds): `scratchpad/r1224.py` in the session scratchpad, reproduced in substance below.

| claim | verdict |
|---|---|
| C1 Lemma D | CONFIRMED |
| C2 U's general form | CONFIRMED |
| C3 CP reading and obstacle | REFUTED as worded (two corrections); the obstacle itself PLAUSIBLE once restated |

## C1 Lemma D: CONFIRMED

- **The constant.** With the record normalisation, structure constants of the coordinate basis are 0 or ±1: the Casimir row sum `Σ_{i,j}<[u_i,u_j],u_k>^2 = 2(n-2)` is carried by the 2(n-2) ordered pairs (e_ij, e_jk), each contributing 1. So `(C#C)_{ik,ik} = (1/2)·2·Σ_{j≠i,k} a_ij a_jk = (W^2)_ik`, the zero diagonal of W making the restriction j ≠ i,k automatic. Off-diagonal entries of C#C vanish because every bracket of coordinate elements is a single ± coordinate element or zero. Screen: `sharp(diag a)` equals `diag((W^2)_ik)` at random a > 0.
- **The equation.** C#C = C reads `(W^2)_ik = a_ik` off the diagonal, and `(W^2)_ii = Σ_j a_ij^2 = Δ_i` on it, so W^2 = W + Δ. Correct.
- **Perron-Frobenius.** W symmetric, nonnegative, every off-diagonal entry positive, so irreducible (indeed primitive for n ≥ 3). Simple Perron root, positive eigenvector. Correct.
- **Δ scalar.** Matches the Lean `delta_scalar` exactly (hypotheses `W*W = W + diagonal Δ`, `W.mulVec v = ρ • v`, `v > 0`), which is sound as read.
- **Spectrum and ρ = 1/2.** Every eigenvalue μ of the symmetric W satisfies μ^2 - μ = δ, so μ ∈ {ρ, 1-ρ}. Since ρ is simple and n ≥ 2, some eigenvalue differs from ρ, so 1-ρ ≠ ρ: simplicity itself excludes ρ = 1/2, and the prose's "ρ (simple) and 1-ρ" carries the case implicitly. (Independently, ρ = 1/2 would give W = I/2, contradicting the zero diagonal.) Then W = (1-ρ)I + (2ρ-1)vv^T with 2ρ-1 ≠ 0, the zero diagonal gives v_i^2 = (ρ-1)/(2ρ-1) constant, v = 1/√n, and solving 1-ρ + (2ρ-1)/n = 0 gives ρ = (n-1)/(n-2), off-diagonal t = (2ρ-1)/n = 1/(n-2).
- **Back-check.** (J-I)^2 = (n-2)J + I gives W^2 = J/(n-2) + I/(n-2)^2 = W + Δ with Δ = (n-1)/(n-2)^2 I. So C = I/(n-2) and it is the unique solution with every a_ik > 0.
- **Scope note (no defect).** Positive definiteness is load-bearing: I_{so(m)}/(m-2) on a coordinate so(m) ⊂ so(n) is a PSD coordinate-diagonal idempotent. The statement is correctly restricted to a_ik > 0.

## C2 U's general form: CONFIRMED

- Cross terms: A_ji = -A_ij and S_ji = S_ij, so Σ λ_iλ_j (A_ij⊗S_ij + S_ij⊗A_ij) is odd under i ↔ j and vanishes.
- Skew part: Σ λ_iλ_j A_ij⊗A_ij = (1/4) Σ λ_iλ_j [V_i,V_j]⊗[V_i,V_j], and from the definition C#C = (1/2) Σ λ_iλ_j [v_i,v_j][v_i,v_j]^T, so the skew part is (1/2) ι(C#C). Correct.
- ι injective, so C#C = C iff Z^2 = Z/2 + E. With (A⊗B)^Γ = A⊗B^T: Z^Γ = -Z, E^Γ = E, so Z^2 - (Z^2)^Γ = ι(C#C) for every symmetric C, which gives both directions of C#C = C iff Z = Z^2 - (Z^2)^Γ.
- Screen at a random PSD C (n = 5, N = 10): `Z^2 = ι(C#C)/2 + E`, `Z^Γ = -Z`, `E^Γ = E`, `Z^2 - (Z^2)^Γ = ι(C#C)` and the fixed point at Z_0/(n-2) all hold to machine precision.
- The identity needs no sign on λ, so it holds for every symmetric C.

## C3 CP reading and obstacle: REFUTED as worded

**Correction 1: Z and E are the natural representations (transfer matrices) of the CP maps, and their Choi forms are the realigned matrices.**

- Z = Σ λ_i V_i⊗V_i acts on vec Ψ as Ψ ↦ Σ λ_i V_i Ψ V_i^T (screen: exact). For C ⪰ 0 this map is completely positive, so the substance of the reading holds.
- The Choi matrix of a CP map is PSD. Witness: at a random PSD C, n = 5, Z has eigenvalues from -2.27 to 3.29. Already V⊗V for a single skew V = E_12 has eigenvalues ±1. The Choi form is Σ λ_i vec(V_i)vec(V_i)^T, the realignment of Z. The same holds for E, with Choi form Σ λ_iλ_j vec(S_ij)vec(S_ij)^T.
- The later text applies E to Ψ_0, which is the natural-representation reading, so the misnomer does not propagate into an argument. The wording should still be fixed.

**Correction 2: on the coordinate family, E acts on diagonal matrices as Δ + (1/2)W, and Z^2 - Z = E - Z/2 is the operator that acts as Δ.**

- Witness (n = 5, random a > 0): on the diagonal matrices, E acts as the matrix Δ + (1/2)·offdiag(W^2). "E acts as Δ" fails this check, and the stated form passes. By hand, the pairs (e_ab, e_bc) with a ≠ c give S = ±(1/2)(e_a e_c^T + e_c e_a^T), and S diag(ψ) S = (1/4)(ψ_c e_a e_a^T + ψ_a e_c e_c^T). Summed over both orders, these contribute (1/2)(W^2)_ac ψ_c at entry a. At an idempotent, offdiag(W^2) = W, so E|_diag = Δ + W/2. This is also forced by Z^2 = Z/2 + E, since Z|_diag = W.
- Consistency: (Δ + W/2)v = (ρ^2 - ρ/2)v, which matches the block's eigen-equation. So the eigenvalue ρ^2 - ρ/2 is right and only the identification "E acts as Δ" is wrong.

**The obstacle, restated.** The object whose scalarity drives Lemma D is D := Z^2 - Z = E - Z/2, which acts as Δ on diagonals. It is not E, which is never scalar there. The general eigen-equation is D(Ψ_0) = (ρ^2 - ρ)Ψ_0.

- In Lemma D, "Dv = δv with v > 0 forces D = δI" uses that D is diagonal in the basis where v is positive.
- Off the coordinate family, D need not be diagonal in any basis adapted to Ψ_0, so one eigen-equation cannot force D = δ·Id. The obstacle to that step is therefore real.
- Whether U generalises by another route is untouched by this. PSD solutions other than I/(n-2) exist (the Π_h/c_h), so any generalisation must use positive definiteness. The block does not claim more than the failure of the step, so the restated obstacle is PLAUSIBLE.

## Summary of corrections to the block

1. "Choi form" → "natural representation (transfer matrix)" for both Z and E. The maps are CP for C ⪰ 0.
2. "Lemma D is the case ... where E acts as Δ" → "... where Z^2 - Z = E - Z/2 acts as Δ (E itself acts as Δ + W/2)".
3. "it no longer forces E to be a scalar" → "it no longer forces E - Z/2 to be a scalar".
