# Gate 2 review r1861: E as the second-kind cubic, and the frame-free bound in t_max (I121)

Brief: [BRIEF_I121_secondkindE.md](BRIEF_I121_secondkindE.md). Note: [2026-09-28d-I121-smallmass-direct.md](2026-09-28d-I121-smallmass-direct.md). Lean: [SecondKindE.lean](../lean/HamiltonsCubic/Results/SecondKindE.lean) at HEAD 848f186a. Log: [agent_logs/r1861-i121-secondkindE.log](../agent_logs/r1861-i121-secondkindE.log). Footing: analysis only. The one computation is the arithmetic of item 4. Item 5's axiom audit is the audit script's run, relayed by the coordinator.

**Verdict: the Lean is the claim, the prose follows it, and the threshold values are right. Three presentation corrections, none of them touching a proved statement: a notational collision in "t_F", a strict inequality that fails at W = 0, and a classification that should name the trace-positivity half as already on the record.**

| item | claim | verdict |
|---|---|---|
| 1 | statement fidelity | CONFIRMED |
| 2 | prose follows the Lean | CONFIRMED, with one strictness correction (C2) |
| 3 | normalisation | CONFIRMED, with a notational collision in the block (C1) |
| 4 | the node threshold | CONFIRMED |
| 5 | vacuity and axioms | CONFIRMED, axioms from the audit script's run |
| 6 | the consequence section | PLAUSIBLE, the "So" of its third bullet rests on the conditional (C4) |
| 7 | classification | CONFIRMED, with the trace-positivity half also agreement (C3) |

## Definitions read

- [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean): `inner2 X Y = ½ tr(XᵀY)`, `phi i j = E_ji − E_ij` (unit in `inner2`), `innerOp R S = ½ ∑_{i,j} inner2(R φ_ij, S φ_ij)`, `normSq R = innerOp R R`.
- [L209FoxClosure.lean](../lean/HamiltonsCubic/Results/L209FoxClosure.lean): `R4 R i j k l = inner2(R φ_ij, φ_kl)`. [L50Spectra.lean](../lean/HamiltonsCubic/Results/L50Spectra.lean) `innerOp_R4`: `normSq R = ¼ ∑ R4²`, the record's `‖W‖² = ‖M‖_F²`.
- [SecondKind.lean](../lean/HamiltonsCubic/Results/SecondKind.lean): `ringW R h i j = ∑_{k,l} R4 i k l j h_kl` (Li's `iklj`), `frob` the plain Frobenius pairing, `symB a b = ½(E_ab + E_ba)`, `trS2 A = ∑_{a,b} (A symB_ab)_ab`.
- [SmallMassE.lean](../lean/HamiltonsCubic/Results/SmallMassE.lean): `crit_E_bound` (scalar: `θ = (3/2)T + E`, `T ≤ λ`, `θλ ≤ 1`, `θ > 0` give `θ² ≤ 3/2 + θE`) and `crit_E_lt`.

## Item 1, statement fidelity: CONFIRMED

- `E_eq_ring`: `Pcubic R − (3/2) trCube R = −½ trS2(W̊³)`, one `ring` step from `L50_bispectral`. This is the first bullet's `E = −½ p_3(ω)` with `trS2` standing for the trace on `S²`. The hypotheses are linearity, skew preservation, self-adjointness on bivectors and first Bianchi. Ricci-flatness is absent, so the statement holds on all algebraic curvature operators, which contains `Weyl_n`.
- `E_le`: from `⟨W̊h, h⟩ ≥ −m‖h‖²` on every symmetric `h`, `E ≤ (3/2) m ‖W‖²`. The hypothesis ranges over all of `S²`, trace direction included. At a Weyl tensor `W̊I = −Ric = 0`, so the bottom on `S²` and on `S²_0` agree up to including `0`, and the frame step supplies the hypothesis on all of `S²` anyway. `trS2` sums over the non-orthonormal family `symB a b` over ordered pairs, and `trS2_cube_ge` compares term by term: each term is `frob(W̊v, v) + m frob(v, v)` at `v = W̊ symB_ab`, via `frob_symB` and `ringW_selfAdjoint`. Every term is nonnegative whatever the basis normalisation, so the range of `trS2` is harmless. The link from `trS2` to the true trace is `L50_norm` and `L50_bispectral`, which use the same `trS2`, so the chain is self-consistent.
- `neg_frob_ringW`: `−frob(W̊h, h) = ∑ R4_abcd h_ac h_bd`. Checked by hand: `−∑ R4_{iklj} h_kl h_ij = ∑ R4_{ikjl} h_kl h_ij` by `R4_anti2`, and renaming `(i,k,j,l) → (a,b,c,d)` gives the display. It holds for every `h`, symmetric or not.
- `eigen_expand` (Mathlib's `IsHermitian.spectral_theorem`, `UᵀU = 1`), `quad_eigen` (`∑ W h h = ∑ e_p e_q secK_pq`), `frob_eigen` (`‖h‖² = ∑ e²`), `secK_diag` (`secK_pp = 0` from `R4_anti1`): each is what its row says.
- `neg_frob_ringW_le`: for every symmetric `h`, `−⟨W̊h, h⟩ ≤ √((n−1)/n) √B ‖h‖²` whenever every `U` with `UᵀU = 1` has `∑_{p,q} secK² ≤ B`. `Fintype.card ι` is `n`.
- `E_le_frame`, `E_le_tmax`: the boxed middle term exactly, with `t` any nonnegative number bounding every frame's `∑_{p<q}` mass (the Lean states it as `∑_{p,q} ≤ 2t²`). Taking `t = t_max` needs only that `t_max` bounds every frame, which is its definition, and attainment (L94) is not used.
- `t_ge_of_crit`: scalar. From `0 < θ₀ ≤ θ`, `θ² ≤ 3/2 + θE`, `E ≤ ct`, `c > 0`, it gives `t ≥ (θ₀ − 3/(2θ₀))/c`. See item 4 for what the prose supplies around it.

## Item 2, the prose follows the Lean: CONFIRMED, one correction

The prose runs in the Lean's order: identity, trace positivity, the `Λ²h` pairing, the eigenframe, the hollow Cauchy–Schwarz, the frame cap, the boxed bound, the node. Each step follows from the one above.

- Trace positivity: the prose sums over an orthonormal basis of `S²` and the Lean over the `symB` family. Both are sums of `⟨(W̊ + μ)v, v⟩ ≥ 0`, so the prose step is valid as written and the Lean carries it differently but equivalently.
- "μ ≥ 0 as tr W̊ = 0" is prose-only and unused by the Lean, whose `m` is the frame bound and nonnegative by construction.
- The frame: the prose takes the eigenframe of the bottom eigenvector, the Lean the eigenframe of an arbitrary symmetric `h` and a bound uniform in `h`. The prose is the Lean's statement specialised to one `h`.
- The Cauchy–Schwarz chain `(eᵀKe)² ≤ ‖K‖²((∑e²)² − ∑e⁴) ≤ ((n−1)/n)‖K‖²‖h‖⁴` is `hollow_quad_sq_le` then `sumsq_sq_le`, with `offdiag_nonneg` for the sign.
- The first inequality of the boxed chain is the record's cap and carries no Lean, as the prose says. It uses `K^F 1 = 0`, so it needs `W ∈ Weyl_n`, which the display assumes. The second is `√(2(n−2)/(n−1)) ≤ √(2(n−1)/n)`, equivalent to `n(n−2) ≤ (n−1)²`.
- **Correction C2.** The third inequality `< (3/√2) t_max ‖W‖²` is strict only at `W ≠ 0`. At `W = 0` both sides are `0`. Write `≤`, or restrict the display to `W ≠ 0`.
- The second-kind reproduction "I_3 = tr_{M_n}(W̊³) by relabelling indices, the skew half by first Bianchi" is prose-only corroboration. The Lean carries the identity through `L50_bispectral` alone. It is a cross-check and needs no Lean row.
- "The two constants differ by 0.3% at n = 14": `√(n(n−2)/(n−1)²) = √(168/169) = 0.99704`, confirmed.

## Item 3, normalisation: CONFIRMED, one correction

- `secK R U p q = ∑ R4_abcd U_ap U_bq U_cp U_dq`. Since `∑_{a,b} u_a v_b φ_ab = vuᵀ − uvᵀ` and `inner2(vuᵀ − uvᵀ, vuᵀ − uvᵀ) = |u|²|v|² − (u·v)² = 1` for orthonormal `u, v`, `secK_pq = ⟨M(u_p∧u_q), u_p∧u_q⟩ = W(u_p, u_q, u_p, u_q)`, the record's sectional entry `K_F(p,q)`, with the sign squared away in both slots.
- `secK` is symmetric in `p, q` (pair symmetry) and hollow, so `∑_{p,q} secK² = 2∑_{p<q} K_F² = ‖K^F‖_F²`, which is L94's `t_F`. Its maximum over frames is L94's `κ²`, and `κ² = 2t_max²` with the brief's `t_max² = max_F ∑_{p<q} K_F²`. So the least admissible `B` in `E_le_frame` is `κ² = 2t_max²`, and `E_le_tmax` at `t = t_max` is the boxed middle term with `‖W‖² = normSq R = ‖M‖_F²`.
- **Correction C1, a collision in the name t_F.** The third bullet uses L94's `t_F = ‖K^F‖_F²` (squared, ordered pairs): "μ ≤ √(t_F(n−2)/(n−1))", "t_F ≤ κ² = 2t_max²". The Gate 1 bullet uses `t_F` for the unsquared per-frame mass `(∑_{p<q}K²)^{1/2}`: "μ ≤ √(2(n−1)/n) t_F (1.2649 ≤ 1.2910 at S³×S³)" needs `t_F = 1` there, since `√(5/3) = 1.2910`, while L94's `t_F` at the balanced product is `2`. Under L94's meaning the Gate 1 line would read `μ ≤ √((n−1)/n) √t_F`. The brief's item 3 phrase "`∑ secK² = 2t_F²`" inherits the second meaning. Rename the Gate 1 quantity, for instance to `t(F)` with `t(F)² = ∑_{p<q} K_F²`, or write it as `√((n−1)/n) √t_F`.

## Item 4, the node: CONFIRMED

- `t_ge_of_crit` with `c = (3/2)√(2(n−1)/n)` gives `t_max ≥ ε_n/c`. Squaring needs `ε_n ≥ 0`, which holds exactly when `θ₀² ≥ 3/2`, true at `n = 12` (`θ₀² = 220/144 = 1.528`) and above. Then `t_max² ≥ ε_n²/c² = (4/9)(n/(2(n−1))) ε_n² = (2/9)(n/(n−1)) ε_n²`, the displayed threshold.
- What the prose supplies around the scalar lemma, correctly: `hE` is `E_le_tmax` at unit norm `normSq R = 1`, and `hb` is `crit_E_bound`, whose own inputs `θ = (3/2) tr M³ + E`, `tr M³ ≤ λ_max` and L198's `θλ_max ≤ 1` are prose in [SmallMassE.lean](../lean/HamiltonsCubic/Results/SmallMassE.lean)'s own account ("Not typed"). The file's docstring says so ("the application at a critical point ... is not typed"). `θ₀ > 0` is immediate from its formula at `n ≥ 3`.
- The four values, by one line of Python: `1.2244e-4` (n = 12), `1.2680e-3` (n = 14), `2.8571e-3` (n = 16), and `ε_∞ = √2 − 3/(2√2) = 1/(2√2)`, so the limit is `(2/9)(1/8) = 1/36`. The note's `1.22×10⁻⁴`, `1.27×10⁻³`, `2.86×10⁻³`, `1/36` are right, and `3/(n+2) = 0.1667` at `n = 16`.

## Item 5, vacuity and axioms: CONFIRMED

- **Axioms.** This reviewer's own `#print axioms` run on `E_le_tmax`, `t_ge_of_crit` and `E_le_frame` stayed queued behind other sessions' builds on the shared toolchain and was stopped unrun. The verdict rests on the coordinator's run of [axiom_audit.py](../scripts/misc/axiom_audit.py) `--only SecondKindE` on the file at b5238f20, whose output reads "19/19 clean -- resting on the standard three alone". That is the audit script's output, relayed, and this reviewer did not reproduce it. `git diff b5238f20 HEAD` on the Lean file is empty, so the audit covers the file under review.

- **Satisfiability.** For any `R`, `|U_ap| ≤ 1` on an orthogonal `U` gives `|secK_pq| ≤ ∑|R4|`, so `B = n²(∑|R4|)²` satisfies `hKB` at every nonzero Weyl operator. `E_le_tmax` is satisfied at `t = t_max(W) > 0`. The hypotheses are satisfiable and the conclusions are not vacuous. `[Nonempty ι]` is the only type-level hypothesis added.

## Item 6, the consequence section: PLAUSIBLE, one correction

- The second bullet is hedged at the right strength: "appears", "a calibration, unproved", and the higher-order claim sits inside "if t_max is also of order 1/√k". The hedge is necessary because the evidence runs one way only. The calibration at line 113 of the note measures `t_max ≳ 1/√k` from particular frames, a lower bound, while the conclusion "no bound of higher order in t_max holds" needs the upper bound `t_max ≲ 1/√k` at those sums, which is the maximum over all frames and unmeasured.
- "The balanced product alone fixes that floor" holds unconditionally, but only for bounds linear in `t_max`: one tensor with `E/t_max ≈ θ₀` forces `C ≥ θ₀` in any `E ≤ C t_max`. At `n = 16` the best threshold any linear bound can give is then `t_max² ≥ (ε_n/θ₀)² ≈ 0.0073`, still far below `3/(n+2) = 0.167`.
- **Correction C4.** The third bullet's "So raising the threshold toward the CP^m scale uses criticality beyond θ² ≤ 3/2 + θE" follows unconditionally for linear bounds, by the product floor above, and for bounds `E ≤ f(t_max)` of higher order it follows only under the second bullet's conditional. State it at that split: "a bound linear in t_max cannot pass `(ε_n/θ₀)²`, by the product, and a bound of higher order is excluded if the k-sums have t_max of order 1/√k".
- A minor consistency point: the block says the balanced product has `E/t_max → √2` and this section says `→ θ₀` at `t_max = 1`. Both are the `n → ∞` reading of `θ₀(n) → √2`. One wording across the two would read better.

## Item 7, classification: CONFIRMED, one correction

- `E = −½ p_3(ω)` is L50 at `E = θ − (3/2) p_3(μ)`, agreement as the block says.
- The frame cap is [bispectral.md](../findings/bispectral.md)'s `μ = vᵀK^Fv ≤ μ_1(K^F) ≤ √(t_F(n−2)/(n−1))` (r131, and r555, r556 for the odd-n repair), read with `t_F ≤ κ²` in place of `t_F ≤ 2`. Agreement as the block says.
- **Correction C3.** The trace-positivity half is also on the record: the "one-line bound" `θ ≤ (3/2)(M_+ + m)` in [bispectral.md](../findings/bispectral.md) (section "The shared-frame majorization coupling", lines 63 and 86, reviewer 290), whose `m`-half is `−½ p_3(ω) ≤ (3/2) m` at unit norm, the block's `E ≤ (3/2) μ ‖W‖²` with `m = μ`. The block should label trace positivity as agreement with that bound too.
- The combined inequality `E ≤ C t_max` appears on the record only as a target: the calibration in the note itself, [2026-09-28e-step8-position.md](2026-09-28e-step8-position.md), the duality route of [2026-09-28e-LIT-step8-sweep.md](2026-09-28e-LIT-step8-sweep.md) (derived, unreviewed, `E ≤ ‖Φ(W)‖_K t_max`), and [r1851](REVIEW_r1851.md) (e). Nowhere is it proved, and nowhere is `−½ p_3(ω) ≤ (3/2)μ` paired with a frame-mass bound on `μ` in `t_max`. The bispectral display `θ ≤ (t_F/2)^{3/2} Θ_n + (9/2)C(1 − t_F/2)` bounds `θ` through `t_F` with `C = M_+ + m` a free constant, which is a different statement. So the claim of novelty for the pairing stands.

## Corrections for the author

1. **C1.** In the Gate 1 bullet, rename the per-frame mass so that it differs from L94's `t_F = ‖K^F‖_F²`, or write the Gate 1 inequality as `μ ≤ √((n−1)/n) √t_F` with `t_F = 2` at `S³×S³`.
2. **C2.** In the boxed chain, replace the final `<` by `≤`, or restrict the display to `W ≠ 0`.
3. **C3.** Label trace positivity as agreement with the record's one-line bound `θ ≤ (3/2)(M_+ + m)` in [bispectral.md](../findings/bispectral.md), so that what is new is exactly the pairing with the cap read at `t_max`.
4. **C4.** In the section after the block, split the "So" of the third bullet: unconditional for bounds linear in `t_max` (product floor, best threshold `(ε_n/θ₀)²`), conditional on the k-sum upper bound for bounds of higher order.
