# REVIEW r1640: L127DnUnits.lean (commit f7628a6b), L127's D_n row in L_e units, and the r1639 repairs in L127Dn.lean

**Verdict: CONFIRMED WITH GAPS.** Every declaration is correct as stated, both files compile (rc 0, no warnings), and the audits are 10/10 and 13/13 clean on the standard three. The gaps are in what the headers list as owed: membership of the cross and λ families in 𝒟ₙ is undeclared and unlisted, and the p = 2 clause has no stated q = 2 mirror.

Reviewer: cold adversarial Gate 2, analysis only. The computations beyond the build and the audits are hand derivations. No numerical screen was run.

## Claim table

| # | Claim | Verdict | Basis |
|---|---|---|---|
| 1 | `sphere_eig`: `K u = ν u` off the diagonal gives `M ∘ diagOp u = ν · diagOp u` on every `φ_ab` | CONFIRMED | `foxProd_diag` gives `(Kmat w u a b) • φ_ab`, and `diagOp_phi` with `smul_smul` gives `(ν u_ab) • φ_ab` on the right. At `a = b` both sides vanish by `phi_self`. Off the diagonal `hK` closes it. The hypotheses are exactly those of `foxProd_diag` plus `hK`, and neither zero row sums nor anything about `ν` is needed. The conclusion is stated on the basis bivectors only (gap G2). |
| 2 | `K_self`: `Kmat w w a c = θ w_ac` off the diagonal at `IsDiagCritical w θ` | CONFIRMED | `Kmat w w a c = w_ac² + ½((ww)_ac + (ww)_ac) = w_ac² + (ww)_ac`, which is L68Statement's third clause verbatim. The symmetry step `hs` (from `hw.1`) is sound, `(ww)_ca = Σ w_cb w_ba = Σ w_ab w_bc`, and it is also unnecessary, since both products in `Kmat w w` are already `(w*w) a c`. Harmless. |
| 3 | `blockW_compl` and the mirror instantiations | CONFIRMED | `blockW Tᶜ B A G` is `B` on `Tᶜ×Tᶜ`, `A` on `T×T`, `G` across, hollow, which is `blockW T A B G`. In `sphere_lam_compl`, `K_lam Tᶜ` is called with `A' = B`, `B' = A`: its `hκ` reads `κ·p = −(q−2)` at `κ = −(q−2)/p`, its `hr1` reads `(q−1)B + pG = 0`, which is `r2`, and its `hr2` reads `(p−1)A + qG = 0`, which is `r1`. The swap is correct. `sphere_zero_compl` calls `K_zero Tᶜ`, which needs no row relation. |
| 4a | `sphere_self`: eigenvalue `θ·1`, `θ = t(p+q−1)` | CONFIRMED | `sphere_diagCrit` (L126DF.lean:123) gives `IsDiagCritical` at exactly this θ, and `p + q = |ι| = n`, so θ = t(n−1). |
| 4b | `sphere_cross`: `θ·(−(n−2)/(2(p−1)(q−1)))` | CONFIRMED | `G − (A+B)/2 = −t[2(p−1)(q−1) + q(q−1) + p(p−1)]/(2(p−1)(q−1))`, and the bracket is `(p+q)² − 3(p+q) + 2 = (n−1)(n−2)`. This is θ·(−μ) with the record's μ. |
| 4c | `sphere_lam`: `θ·(p−2)/(2(p−1))` at `κ = −(p−2)/q` | CONFIRMED | `½(p−2)(A − G) = ½(p−2)·t(q + p − 1)/(p−1)`. The choice of κ is forced: `lamW`'s row sum at `a ∈ T` is `(p−2)h_a + qκh_a`, zero exactly at `κq = −(p−2)`, and at `a ∉ T` it is `κ Σ_T h = 0`. So κ puts the family in 𝒟ₙ, and it is also `K_lam`'s `hκ`. |
| 4d | `sphere_lam_compl`: `θ·(q−2)/(2(q−1))` | CONFIRMED | `½(q−2)(B − G) = ½(q−2)·t(p + q − 1)/(q−1)`, the record's λ_q. |
| 4e | `sphere_zero`, `sphere_zero_compl`: eigenvalue 0 | CONFIRMED | Direct from `K_zero` at `T` and at `Tᶜ` after the swap. The hypotheses (hollow, symmetric, supported inside the factor, zero row sums there) describe exactly the factor's share of `0^rest`. |
| 4f | `sphere_rows` | CONFIRMED | `(p−1)·tq/(p−1) − qt = 0` and `(q−1)·tp/(q−1) − pt = 0`, which are `K_lam`'s `hr1` and `hr2` at `A = tq/(p−1)`, `B = tp/(q−1)`, `G = −t`. |
| 5 | The p = 2 clause (L127Dn.lean:24-28, L127DnUnits.lean:22-24, INDEX L127 row) | CONFIRMED WITH GAPS | At p = 2, `h_a = −h_b` kills the within entries and `κ = 0` kills the cross entries, so `lamW ≡ 0`. The T-side zero family is `u_ab` with row sum `u_ab = 0`, so `{0}`. `(p−1) + p(p−3)/2 = 1 − 1 = 0` keeps the record's total. The true total at p = 2 is `1 + (q−1) + (q−1) + q(q−3)/2 = (q²+q−2)/2 = n(n−3)/2` at `n = q+2`, and at p = q = 2 it is `1 + 1 = 2 = n(n−3)/2`. All correct. The q = 2 mirror is not stated (gap G3). |
| 6 | Statement fidelity | CONFIRMED WITH GAPS | No declaration claims more than it proves. The eigen-relations hold for every input, including zero inputs, and the headers list nonzeroness and spanning as owed. Membership of `crossW` and `lamW` in 𝒟ₙ (zero row sums) is neither declared nor listed as owed (gap G1). The reading "in L_e units" divides by the criticality multiplier θ = t(n−1), which matches the record's `e = M/θ` (second-order.md:1187) at every t, so no unit-norm hypothesis is missing. |
| 7 | Axiom audit | CONFIRMED | `axiom_audit.py --only L127DnUnits.lean`: 10/10 clean. `--only L127Dn.lean`: 13/13 clean. `lake env lean` rc 0 on both with no warnings, so r1639's G3 (unused section variables) is repaired. No `sorry`, no `native_decide`. |

## Gaps

- **G1, [L127DnUnits.lean:22-24](../lean/HamiltonsCubic/Results/L127DnUnits.lean).** The owed list names nonzeroness at p, q ≥ 3 and spanning of 𝒟ₙ. That the cross weights and the λ weights lie in 𝒟ₙ (zero row sums, which for `lamW` is what fixes κ) is not declared anywhere and is not in the list. Spanning presupposes it, but it is a separate short lemma and should be named as owed, or proved alongside `lamW_colT` and `lamW_colTc`, which already hold the column sums needed.
- **G2, [L127DnUnits.lean:16-17](../lean/HamiltonsCubic/Results/L127DnUnits.lean) and 55-61.** Every family is an eigen-relation on each `φ_ab`, not an operator equality on all bivectors. The header says "on every φ_ab", so this is honest. The lift is one call to L131Whole.lean's `eq_on_skew_of_phi` and is owed before the row's spectrum is read as `σ(L_e|𝒟ₙ)`.
- **G3, [L127Dn.lean:24-28](../lean/HamiltonsCubic/Results/L127Dn.lean), [L127DnUnits.lean:23-24](../lean/HamiltonsCubic/Results/L127DnUnits.lean) and the INDEX L127 row.** The p = 2 clause has no q = 2 counterpart. At q = 2 the λ_q family and the Tᶜ-side zero family are `{0}` by the same argument through `blockW_compl`. Stating "p = 2 (and q = 2 by the mirror)" would close it.
- **G4 (cosmetic), [L127DnUnits.lean:38-42](../lean/HamiltonsCubic/Results/L127DnUnits.lean).** The symmetry step `hs` in `K_self` is unnecessary, since `Kmat w w` contains `(w*w) a c` twice. It is sound.

## What would break each claim, and what was done to look for it

- Claim 1 would break if `diagOp u (φ_aa)` were nonzero or if `foxProd_diag` needed a hypothesis `sphere_eig` omits. I read `phi_self` (WeylReal.lean:53) and matched the hypothesis lists.
- Claim 2 would break if L68Statement's `IsDiagCritical` used a different `#` constant from `Kmat`. Both are `w_ab² + (ww)_ab`, and r1639's screen of `K w = θ w` agrees.
- Claim 3 would break on a swapped row relation in the mirror. I instantiated `K_lam Tᶜ` by hand with `|Tᶜᶜ| = |T|` and matched each hypothesis to `r1` or `r2`.
- Claim 4 would break on a wrong θ or a wrong κ. I recomputed each eigenvalue, checked `(n−1)(n−2)` in the cross numerator, and derived κ from the row-sum condition independently of `K_lam`.
- Claim 5 would break at p = 2 or p = q = 2. I computed the true family dimensions and totals in both cases.
- Claim 6 would break on a family asserted nonzero, in 𝒟ₙ or spanning without proof. None is, and the unlisted membership is G1.
- Claim 7 would break on a hidden axiom. Both audits are clean.
