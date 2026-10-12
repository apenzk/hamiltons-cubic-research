# REVIEW r1617

Gate 2, one-reviewer round. Lean statements in [I117Statements.lean](../lean/HamiltonsCubic/Results/I117Statements.lean) at 3f3ad397, read against [findings/second-order.md](../findings/second-order.md) Lemmas L260, L261, L262, L264 and the rows of [lean/INDEX.md](../lean/INDEX.md). Analysis only: no screen was run, the only computation is the n = 3 bracket sum done by hand below. No Lean rebuild. The axiom audit is the parent's.

## Verdicts

| claim | declaration | verdict |
|---|---|---|
| C1 | L261_coord_diag | CONFIRMED |
| C2 | L262_son | CONFIRMED |
| C3 | sharpMapCL_coordOp | CONFIRMED |
| C4 | L260_psd_cone, Ftri_eigen | CONFIRMED WITH GAPS (one docstring sentence) |
| C5 | lean/INDEX.md rows L260, L261, L262, L264, L270 | CONFIRMED WITH GAPS (one stale sentence in L264, one under-disclosed dependency in L270) |

## C1, L261_coord_diag (line 1657)

- Record statement: C = sum over i<k of a_ik e_ik e_ik^T on so(n), every a_ik > 0, C#C = C, then C = I/(n-2).
- coordOp a sends X to skewPartM(a ⊙ X). For symmetric a and skew X the Hadamard product is already skew, so coordOp a acts on the φ basis vector φ_ij = E_ij - E_ji by the scalar a_ij (coordOp_coe, hadamard_phi). This is the record's C with weights a_ik.
- Hypotheses: aᵀ = a, positivity of a_ij for all ordered i ≠ j, IsIdem (coordOp a), n ≥ 3. Symmetry loses nothing, since every coordinate-diagonal operator has a symmetric weight matrix. The diagonal of a is free and invisible (coordOp_offDiag), and the proof passes to offDiag a first.
- Conclusion coordOp a = (1/(n-2)) • idOp is the record's I/(n-2).
- Positive weights against positive definite: **the same condition on this family.** The eigenvalues of coordOp a are exactly the a_ij (i<j) with eigenvectors φ_ij, so positive definiteness is equivalent to every off-diagonal weight being positive. The record's title says positive definite and its statement block says every a_ik > 0, and the Lean matches the statement block verbatim. Neither is stronger.
- n ≥ 3 is implicit in the record's I/(n-2).
- The proof has no sorry (sorries in the file sit in L268_torus_idem, L269_phi_test, L271_F_slice, L273_J1_implies_H, L260_range_subalgebra, L260_trace_bound, L265_I_sharp, L266_orbit_tangent, L267_U_fails, L254_conjA_12, L263_g2, L265_cp, L271_split, L273_F_bound). Its route after the Perron vector uses perron_unique on columns of W + (ρ-1)I instead of the record's rank-one decomposition. A different route to the same conclusion.

## C2, L262_son (line 2390)

- Pk = coordOp of the 0/1 matrix equal to 1 exactly when both indices are below n-1. It is the orthogonal projection onto span{φ_ij : i, j < n-1} = so(n-1), the record's P_𝔨. Pp = idOp - Pk is P_𝔭, spanned by the φ_{i,n-1}.
- Record hypotheses at this pair: 𝔤 = so(n) compact simple requires n = 3 or n ≥ 5, and c_𝔨 > 0 excludes n = 3 (c_𝔨 = n - 3). So n ≥ 5 is exactly the record's range.
- The constants: c = n - 2 (sharpMapCL_id), c_𝔨 = n - 3 (the within-𝔨 star sum counts l ≠ i, j below n-1), c - c_𝔨 = 1. The record's equations a²c_𝔨 + b²(c - c_𝔨) = a and abc = b become a = (n-3)a² + b² and b = (n-2)ab, which is what vss and vsL compute.
- Solutions by hand: b = 0 gives a ∈ {0, 1/(n-3)}. b ≠ 0 gives a = 1/(n-2) and b² = a - (n-3)a² = 1/(n-2)², so b = ±1/(n-2). These are 0, P_𝔨/(n-3), I/(n-2), σ/(n-2) with σ = P_𝔨 - P_𝔭, the record's four in order. The iff direction is stated in both senses, as the record's "the idempotents among ... are" requires.

## C3, sharpMapCL_coordOp (line 1613)

- starW a (x, y) = sum over k of a_xk a_ky (line 1447), the matrix product a·a.
- The standard formula for an operator diagonal in the φ basis: (A#A) φ_xy picks up [φ_xk, φ_ky] = ±φ_xy for every k ≠ x, y, so (A#A)_xy = sum over k ≠ x, y of a_xk a_ky, the record's (W²)_ik in L261's proof. The zero-diagonal hypothesis is what lets the unrestricted sum over k stand in for the sum over k ≠ x, y (the k = x and k = y terms carry a_xx or a_yy). Symmetry is what makes a ⊙ X skew and the weight matrix well defined on pairs. Both hypotheses are the right ones.
- Anchor at a = 1 off the diagonal: starW a (x, y) for x ≠ y counts k ≠ x, y, giving n - 2. So coordOp(1 off diagonal) = I and I#I = (n-2)I, matching sharpMapCL_id.

## C4, L260_psd_cone (line 2298) and Ftri_eigen (line 2189)

- Typed statement: for self-adjoint X there is a self-adjoint PSD Y with ‖Y‖² = ‖X‖² and F(X) ≤ F(Y). The proof takes Y = diagOp b |σ| in X's eigenframe, which is |X|.
- Honest restriction: at self-adjoint X, |Xᵀ| = |X|, so the record's inequality F(X) ≤ ½(F(|Xᵀ|) + F(|X|)) reads F(X) ≤ F(|X|), which the proof establishes. The existential conclusion forgets that Y is |X| but carries everything L260 (1)'s "κ_n is attained on the PSD cone" needs, because L259 defines κ_n on Sym² so(n), the self-adjoint operators. The restriction is named: the hypothesis IsSelfAdjoint2 X is in the signature, the docstring says "in the form it is used", and it names the missing operator absolute value as the reason the general form is absent. The record's L260 note and the L260 row both say "(1) at self-adjoint X".
- **Gap (docstring wording).** The docstring reads "every operator X being matched, at self-adjoint X, by ...". "Every operator" followed by "at self-adjoint X" reads as a general claim then narrowed. Suggested: "every self-adjoint X is matched by a positive semidefinite self-adjoint Y of the same norm with F(X) ≤ F(Y)".
- Ftri_eigen constant. Ftri = -½ phiTri, and the proof unfolds phiTri as -¼ times the φ-family sum of G, converts it by phi_sum_change (φ-family sums over ordered pairs are twice the orthonormal-basis sums, consistent with φ_ij being inner2-unit and φ_ji = -φ_ij), then again inside G. The chain is -½ · (-¼) · 2 · 2 = ½, so F(R) = ½ Σ λ_β λ_γ λ_δ ⟨[b_β, b_γ], b_δ⟩². The constant is ½.
- Anchor at R = I: Ftri_eigen gives F(I) = ½ Σ_δ Σ_{β,γ} ⟨[b_β, b_γ], b_δ⟩² = ½ · N · 2(n-2) = (n-2)N. The operator side gives F(I) = ⟨I, I#I⟩ = (n-2)‖I‖² = (n-2)N (Ftri_id, and normSq2_eigen with all λ = 1 gives ‖I‖² = N). They agree.
- The identity Σ_{β,γ} ⟨[b_β, b_γ], b_δ⟩² = 2(n-2) at n = 3, by hand. Basis φ12, φ13, φ23 is inner2-orthonormal (inner2(φ, φ) = ½ tr(φᵀφ) = ½ · 2 = 1). From φ_ij φ_kl = δ_jk E_il - δ_jl E_ik - δ_ik E_jl + δ_il E_jk: φ12 φ13 = -E23 and φ13 φ12 = -E32, so [φ12, φ13] = -φ23. For b_δ = φ23 the ordered pairs (12, 13) and (13, 12) contribute 1 each, the diagonal pairs vanish, and the pairs involving φ23 bracket into span{φ12, φ13} ⊥ φ23. Total 2 = 2(3-2). By the permutation symmetry the same holds for δ = φ12 and φ13.
- Record's "a norm-minimal #-idempotent can be taken PSD" is used downstream by L260_H_of_norm_bound through L264_maximiser_stable, and it is carried there at self-adjoint X only, the domain of κ_n.

## C5, the rows

Every declaration each row calls PROVED exists in the cited file and has no sorry of its own: L260_psd_cone, L260_H_of_norm_bound, exists_sa_maximiser, statementH_of_unit, opSk, phi_sum_change, Ftri_eigen, normSq2_eigen, diagOp (L260); L261_coord_diag, sharpMapCL_coordOp, perron_unique (L261); L262_son, pairW, isIdem_coordOp_iff (L262); L264_maximiser_stable, L264_not_simple_unstable, phiTri_comm_zero, quartic_coeffs, eq_of_innerOp2_eq, isSelfAdjoint2_sharp, sharpMapCL_smul, L270_H_of_Us' (L264); L270_so, L270_torus_light, normSq2_torusOp, idOp_eq_torusOp (L270). The "Earlier" names (sympair_idem, SymmetricPair, sharp_C, idempotent_iff, idir_test, idir_heavy, torus_light_y, l267_idir_n9, weighted_amgm, three_ratio, trace_le_of_pairing, delta_scalar, sharp_lin, twocomp_second_root_peirce, g2_su3_peirce, g2_so4_*) all exist. The rows marking sorry (L260_range_subalgebra, L260_trace_bound) match the file.

- **Stale, L264 row, last sentence.** "*Not stated: (1) the second-order condition at a maximum on the sphere (Tkachev's Theorem A), (2) the several-ideal block computation, (3) the reduction; the base layer carries no second-order optimality condition.*" The same row calls (1) PROVED as L264_maximiser_stable, which is the second-order condition at a maximum on the self-adjoint unit sphere, types (2) at a split without cross block, and proves (3) as L270_H_of_Us'. Replace with what remains untyped: (2)'s cross block E, and (1)'s claim that C is positive definite on the semisimple subalgebra it is supported on (that is L260 (2), sorry). The sentence also carries a semicolon splice.
- **Under-disclosed dependency, L270 row.** "L270_torus_light PROVED ((4), on the whole slice A = A_μ, an arbitrary torus idempotent reaching it through L268_torus_idem ...)". L270_torus_light is sorry-free, but it is stated only on the slice A = A_μ. Reaching an arbitrary torus idempotent goes through L268_torus_idem, whose proof is sorry (line 836). The row should say so, for example "an arbitrary torus idempotent reaches the slice through L268_torus_idem, which is sorry".
- L260, L261, L262 rows: no stale sentence. The L261 and L260 rows keep "statement: not typed" and "scalar steps" only under "Earlier", with the supersession stated.
- Outside the rows, for the record's owner: the italic note under Lemma L260 in [findings/second-order.md](../findings/second-order.md) says "(2) and (4) at the operator level are prose". They are typed at so(n) as L260_range_subalgebra and L260_trace_bound with sorry proofs, which is what the L260 row says. "Stated, proof sorry" is the accurate reading.

## Searched

I117Statements.lean lines 1-110, 826-836, 1410-1447, 1600-1760, 1920-1990, 2098-2440, 2515-2560, 2716-2860 and the sorry map of the whole file; findings/second-order.md Lemmas L260, L261, L262, L264; lean/INDEX.md rows L260, L261, L262, L264, L270; definitions of inner2 and br in the layer; existence of every row-cited name across lean/HamiltonsCubic.
