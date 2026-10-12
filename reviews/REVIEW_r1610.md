# REVIEW r1610: L122Weyl.lean, L122Orbit.lean and the r1608 repairs in L126Main.lean and L122Statement.lean

Log: [agent_logs/r1610.log](../agent_logs/r1610.log)

Commits: 1ff3f79a ([L122Weyl.lean](../lean/HamiltonsCubic/Results/L122Weyl.lean)), 8bcb90bf ([L122Orbit.lean](../lean/HamiltonsCubic/Results/L122Orbit.lean) and the note in [L122Statement.lean](../lean/HamiltonsCubic/Results/L122Statement.lean)), bd080200 (the first conjunct of `L126_kernel_orbit` in [L126Main.lean](../lean/HamiltonsCubic/Results/L126Main.lean) and the L122Statement note), with the L122 and L126 rows of [lean/INDEX.md](../lean/INDEX.md). Record: [second-order.md](../findings/second-order.md), Lemma L122 (line 1230) and Lemma L126 (line 1699). Analysis only: the build and the axiom audit were run, and the coefficient identity was checked by hand. No screen was needed.

| claim | declaration | verdict |
|---|---|---|
| C1 | bianchi_pairBasis, pairSpan_isWeyl (L122Weyl.lean:27, :43) | CONFIRMED |
| C2 | orbit_eigen (L122Orbit.lean:61), with pairSum_restrict and sum_off_pair | CONFIRMED |
| C3 | L126_kernel_orbit's new first conjunct (L126Main.lean:98) | CONFIRMED |
| C4 | the L122 row's "Owed" and "the Weyl direction hcap needs" | CONFIRMED WITH GAPS |
| C5 | the L126 row still proved | CONFIRMED |
| C6 | build and axioms | CONFIRMED |
| C7 | downstream text and style | CONFIRMED, two observations |

Summary: the three Lean additions say what the record says and build on the standard three axioms, and the one gap is that the L122 row lists only the maximiser inequality as owed when the path to `hcap` also needs orthogonality of the pair span to M and two unproved compositions.

## 1. Definitions read

- `IsWeyl R` ([WeylReal.lean:126](../lean/HamiltonsCubic/Base/WeylReal.lean#L126)): R maps skew to skew, is symmetric under inner2 on skew arguments, satisfies `bianchi R i j k l = 0` at every tuple, and has `Ric R a b = 0` at every pair.
- `bianchi R i j k l = ⟨R φ_ij, φ_kl⟩ + ⟨R φ_ik, φ_lj⟩ + ⟨R φ_il, φ_jk⟩`, the cyclic sum R_ijkl + R_iklj + R_iljk with i fixed, which is first Bianchi.
- `Ric R a b = Σ_c ⟨R φ_ac, φ_bc⟩`.
- `rk2 U V X = ⟨V, X⟩ U + ⟨U, X⟩ V`, the symmetric product U ⊙ V.
- `IsDiagCritical w th` ([L68Statement.lean:146](../lean/HamiltonsCubic/Results/L68Statement.lean#L146)): w symmetric, hollow, and w_ab² + (w²)_ab = th w_ab off the diagonal. `isCritical_srg_form diagCriticalityIsCritical` turns it into `IsCritical (diagOp w) th`, which is Q(R)(φ_ij) = th R(φ_ij) ([WeylReal.lean:194](../lean/HamiltonsCubic/Base/WeylReal.lean#L194)). So th is the record's multiplier θ in Q(W) = θW.
- `orbitTan M j k Y = [φ_jk, MY] − M[φ_jk, Y]` ([L126Orbit.lean:30](../lean/HamiltonsCubic/Results/L126Orbit.lean#L30)).
- `critMap W = Q(W) − P(W) W` and `LeLin a = foxProd2 (P(a)⁻¹ a)` ([L126Kernel.lean:26](../lean/HamiltonsCubic/Results/L126Kernel.lean#L26), [L24Restrict.lean:87](../lean/HamiltonsCubic/Results/L24Restrict.lean#L87)).

## 2. C1, the pair span is Weyl: CONFIRMED

- **`bianchi_pairBasis`.** f_i = φ_ji ⊙ φ_ki with j, k, i distinct. The two pairs share the index i, so φ_ji ∧ φ_ki = 0 and first Bianchi holds, the standard fact. By hand at one tuple, R_jiki + R_jkii + R_jiik = r + 0 − r = 0. The Lean proof is a 256-branch case split, closed by the kernel.
- **`pairSpan_isWeyl`.** All four clauses of `IsWeyl` are discharged: skew-to-skew from `rk2_skew`, symmetry from `rk2_symm`, Bianchi termwise from `bianchi_pairBasis`, and Ricci-flatness from `pair_ricciFlat_iff` at Σ c_i = 0 (reviewed at [r1608](REVIEW_r1608.md)). The hypothesis `hs` (s avoids j and k) is the record's block index set, and `Sset j k` satisfies it.
- **Against `hcap`.** `lambda_min_bound`'s `hcap` is L24's cap read on the pair block in L_M units. L24 bounds L_e on W^⊥ inside the Weyl space, so a pair-span vector must be Weyl AND orthogonal to M. `pairSpan_isWeyl` supplies the first. The second is true and easy (diagOp w is diagonal in the φ_ab basis and f_i is off-diagonal, so innerOp_rk2 gives zero), but no declaration proves it. See C4.

## 3. C2, the orbit direction is a θ/2-eigenvector: CONFIRMED

- **Hypothesis.** `hw`, `hh`, `hcrit` are the three clauses of `IsDiagCritical w th`, spelled out. Neither Ricci-flatness nor the Weyl property is assumed, so the statement is at least as general as the record's.
- **Units.** M ∘ T = (θ/2) T is in L_M units, and the record's "eigenvalue θ/2" at line 1230 is the same unit, as is `hcap`'s θ/2. In L_e units, e = M/θ, it is ½.
- **Coefficient identity, by hand.** `pair_invariant` gives, for c = x with x_i = w_ji − w_ki, the coefficient of f_q (q ∉ {j, k}) as ½ x_q (w_jq + w_kq − w_jk) + ½ Σ_{i∈s} x_i w_iq. Removing i = j and i = k from the full sum gives Σ_{i∈s} x_i w_iq = (w²)_jq − (w²)_kq + w_jk w_jq − w_jk w_kq, matching `hsum`. Twice the coefficient is then w_jq² − w_kq² − w_jk w_jq + w_jk w_kq + (w²)_jq − (w²)_kq + w_jk w_jq − w_jk w_kq = [w_jq² + (w²)_jq] − [w_kq² + (w²)_kq] = θ w_jq − θ w_kq = θ x_q. So the coefficient is (θ/2) x_q, criticality used at (j, q) and (k, q) only, and the M-dependence cancels exactly as the record says.
- **Sign.** T_jk = Σ (w_ji − w_ki) f_i is the negative of Σ (M_ki − M_ji) f_i, and the eigen-equation is linear, so the flip is harmless, as the file states.
- **Observation.** The theorem proves the eigen-equation. It holds with T = 0, which occurs exactly on the within-factor blocks the record's next sentence names as orbit-free, so "eigenvector" reads correctly where the record uses it. The docstring's "so L_e T_jk = ½ T_jk with e = M/θ" ([L122Orbit.lean:60](../lean/HamiltonsCubic/Results/L122Orbit.lean#L60)) silently needs θ ≠ 0.

## 4. C3, L126_kernel_orbit's first conjunct: CONFIRMED

- **What it states.** At M with Q(M) = th M, for every self-adjoint H with ⟨M, H⟩ = 0 and every test Z, the derivative of s ↦ ⟨Z, F(M + sH)⟩ at 0 is ⟨Z, 2M∘H − P(M)H⟩. It is `critMap_hasDerivAt` applied at M = restrict(diagOp w), which is self-adjoint by `isSelfAdjoint2_restrict`. Together with the second conjunct (2M∘H − P(M)H = 0 iff L_e H = ½H at P(M) ≠ 0) it reads ker DF(M) = E_½(L_e) on the tangent space, which r1608 gap 2 asked for.
- **Tangent space.** The record's tangent space at a unit M is Weyl ∩ M^⊥. The Lean H ranges over self-adjoint operators orthogonal to M, a wider class. The wider class is harmless: both conjuncts are universal in H, so they specialise to Weyl H, and there `isWeyl2_foxProd2` keeps M∘H Weyl, so the unprojected F and L_e agree with the record's Weyl-space maps and no projection is lost.
- **Multiplier.** th is free and M is not assumed unit. The conclusion is written in P(M), so it is correct at every such M, and at the record's unit critical point P(M) = θ, which makes e = M/P(M) the record's e = M/θ.
- **Reading.** "Kernel" means the weak derivative vanishes against every Z. innerOp2 is ½ Σ ⟨Rφ_ij, Sφ_ij⟩, definite on CurvOp2, so this is the operator 2M∘H − P(M)H vanishing. That step is the pre-existing reading documented at `critMap_hasDerivAt`, and it is not composed in Lean.

## 5. C4, the L122 row: CONFIRMED WITH GAPS

- The row's new text describes `bianchi_pairBasis`, `pairSpan_isWeyl` and `orbit_eigen` correctly, 2/2 and 4/4 as the audit reports.
- **Gap.** "**Owed**: the maximiser inequality, which needs L24 and feeds `lambda_min_bound`'s `hcap`" ([lean/INDEX.md:356](../lean/INDEX.md#L356)) lists one item, and the commit message 8bcb90bf says the row "owes only the maximiser inequality". Reaching `hcap` from L24 also needs (a) the pair span orthogonal to M, unproved anywhere in the layer, (b) the composition of `pairBlock` with `Lb` and `block_eq_kirchhoff`, which the same row says earlier "no theorem composes", and (c) the carriage of the pair-span vector and its eigen-equation from bare `CurvOp` to `CurvOp2` and `LeLin`, where L24 lives. The row's own "the Weyl direction `lambda_min_bound`'s `hcap` needs" (and [L122Weyl.lean:10](../lean/HamiltonsCubic/Results/L122Weyl.lean#L10)) names half of the domain condition. The mathematics is sound and each item is routine, so this is an understated debt list, not a false claim.
- The row still reads **partial**, which is honest.

## 6. C5, the L126 row: CONFIRMED

- [lean/INDEX.md:482](../lean/INDEX.md#L482) reads proved and describes `L126_kernel_orbit` as "the kernel clause and orbit-freeness", which covers the added derivative conjunct. L126Main.lean is 5/5 on the standard three.

## 7. C6, soundness: CONFIRMED

- `lake build HamiltonsCubic.Results.L122Weyl HamiltonsCubic.Results.L122Orbit HamiltonsCubic.Results.L126Main`: exit 0, "Build completed successfully (8800 jobs)", no `sorry`. Linter warnings only (unused section variables in `rk2_zero_left`, an unreferenced `H` at L126Main.lean:111).
- `axiom_audit.py --only L122Weyl.lean`: 2/2 clean. `--only L122Orbit.lean`: 4/4 clean. `--only L126Main.lean`: 5/5 clean. All rest on propext, Classical.choice, Quot.sound.

## 8. C7, downstream and style: CONFIRMED, two observations

- [L122Statement.lean:58-67](../lean/HamiltonsCubic/Results/L122Statement.lean#L58) now points to L122Pair (`pair_gram`, `pair_ricciFlat_iff`) and L122Orbit (`orbit_eigen`), and its "Also absent" keeps only the within-factor top eigenvalue and the withdrawn halved form. The L_M eigenvalue θ/2 is the Δ eigenvalue −(θ + M_jk) of line 1666 through `quadS_Lb`'s Lb = −½ Δ − ½ M_jk. No stale text found.
- **Observation 1.** [second-order.md:1230](../findings/second-order.md#L1230) carries no machine-check pointer to `orbit_eigen` or `pairSpan_isWeyl`, while the L126 note at line 1699 does. That file belongs to the research session.
- **Observation 2.** Commit 8bcb90bf also rewrote the L264 row of lean/INDEX.md (another session's `L264_maximiser_stable` text), which its message does not mention. Out of this review's scope.
- Style: no em dash in any added line of the three commits, no backticks inside link text, the INDEX rows are single lines, and the semicolons in the L122 row separate list items that carry commas.

## Verdict

**CONFIRMED WITH GAPS.** One gap: the L122 row's owed list at [lean/INDEX.md:356](../lean/INDEX.md#L356) omits orthogonality of the pair span to M and the pairBlock-to-Lb and CurvOp-to-CurvOp2 compositions on the way to `hcap`.
