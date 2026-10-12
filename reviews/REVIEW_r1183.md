# REVIEW r1183: rowC_mass against L244 (i), row (C)

Log: agent_logs/r1183.log. Gate 2, one reviewer, statement comparison (the kernel has checked the proof). Analysis-only footing: the one computation below is a seconds-scale screen on objects constructed for it, reported as a screen.

| Item | Verdict |
|---|---|
| 1 vacuity | CONFIRMED (hypotheses satisfiable at a nonzero Weyl W) |
| 2 conclusion = record's row (C) sum, layer normalisation | CONFIRMED |
| 3 critical-point step to lambda_c(theta - lambda_c) | PLAUSIBLE (derivable from layer lemmas, stated only in prose) |

## Item 1: vacuity

- Hypotheses of `rowC_mass` (lean/HamiltonsCubic/Results/L244RowBMass.lean:183): `hW : IsWeylOp W`, `hψS : ∀ k, IsSkew (ψ k)`, `hWP : ∀ X, IsSkew X → W X = ∑ b, lam b • Pc ψ cls b X`, `hη : IsSkew η`. Every universally quantified hypothesis ranges over skew X only, so the r1182 defect (resolutions over all matrices, unsatisfiable for skew-valued P_a) is absent here.
- Witness: n = 4, W = W+ with eigenvalues (2, -1, -1) on Λ+ and 0 on Λ-, psi an inner2-orthonormal eigenbasis (the -1 pair rotated by 0.7 rad off the coordinate self-dual forms), cls = {2}, {-1,-1}, {0,0,0}, lam = (2, -1, 0), W defined on all matrices as the sum of lam_b Pc_b, which is linear and skew-valued. Screen: Ricci and Bianchi residues 0.0, symmetry residue 0.0, orthonormality error 2e-16, <W psi_0, psi_0> = 2. `hWP` then holds by definition, and Pc_b is the inner2-orthogonal projection on E_b because psi is orthonormal and complete.
- Note: `rowC_mass` needs no orthonormality or completeness of psi and no resolution of the identity (unlike `rowB_mass`); `hWP` alone carries the content, and only `hW.2.1` (skew-valued) of `hW` is used.

## Item 2: conclusion

- `bAB ψ cls a b η = ½ Σ_{γ∈E_a, δ∈E_b} inner2([ψ_γ, ψ_δ], η)²` (L244RowA.lean:137) is the record's b_ab(x) verbatim, with inner2 = ½ tr(XᵀY), so the φ_ij (i<j) are orthonormal, the record's basis e_i∧e_j.
- `sharpQF W η = -¼ Σ_{i,j} inner2([η, W[η, W φ_ij]], φ_ij)` (Base/WeylReal.lean:102). The ¼ is ½ for the ordered-pair double count times ½ of the definition, and `sharpOp_id` (id# = (n-2) id) pins it to the record's normalisation.
- The left side Σ_a Σ_b lam_a lam_b b_ab(η) is the record's Σ λ_a λ_b <B_ab x, x>, with the identification mixQF(P_a, P_b) = b_ab supplied by `mixQF_Pc` (CONFIRMED by r1182).
- Screen (n = 4, three random skew η, the witness above): LHS, `sharpQF W η` and an independent structure-constant evaluation of the record's W#, (W#)_{αβ} = ½ c_{αγδ} c_{βεζ} W_{γε} W_{δζ} in the orthonormal e_i∧e_j basis, agree to 10 digits (e.g. -0.6635730010, -1.1591787882, -19.0643961185). sharpQF(id, η)/<η,η> = 2 = n - 2.

## Item 3: the critical-point step

- The docstring's step "at a critical point W# = θW − W², giving λ_c(θ − λ_c) at unit x ∈ E_c" is not a declaration anywhere. lean/INDEX.md's L244 and L248 rows themselves list "the operator identity W# = θW − W²" as entering as hypotheses / not typed.
- The ingredients exist: WeylReal's `IsCritical W θ` (Qop W φ_ij = θ • W φ_ij on the basis), `sharpOp_isLinOp` (L209WeylClosure.lean:94), `inner_sharpOp` (L41Statement.lean:678, inner2 v (sharpOp W v) = sharpQF W v for IsWeyl W), and W linear, so extending the basis identity to skew x by `skew_expand` gives sharpQF W x = θ<Wx,x> − <W²x,x> = λ_c(θ − λ_c) at unit x ∈ E_c. With L40Statement's bilinear `IsCritical` (all skew X, Y) it is one line via `sharpBil_self` at X = Y = x.
- Screen: the witness is critical with θ = 3 (W+# = 2·diag(1,-2,-2) = 3W − W²). At unit x in E_0, E_1, E_1, E_2 the LHS gives 2, -4, -4, 0, which equals λ_c(3 − λ_c) in each case.
- Verdict PLAUSIBLE: the step is sound and short, but prose-only. The docstring should say it is not typed, or a corollary `rowC_critical` should compose the four lemmas above.
