# REVIEW r1639: L127Dn.lean (commit a30fed40), the D_n row's weight map and three eigen-families

**Verdict: CONFIRMED WITH GAPS.** Every theorem is correct, compiles (rc 0, no errors) and is 13/13 clean on the standard three axioms. The gaps are presentational: a dimension formula that is only literal at p, q >= 3, and the families being stated at the weight level.

Reviewer: cold adversarial Gate 2, analysis only. The one computation beyond the build and audit is a hand screen of the eigenvalue-1 vector, reported as a screen.

## Claim table

| # | Claim | Verdict | Basis |
|---|---|---|---|
| 1 | `foxProd_diag`: `diagOp w ∘ diagOp u` sends `φ_ab` to `(K u)_ab φ_ab`, `K u = w⊙u + ½(wu + uw)` | CONFIRMED | `jordanProd` is `½(XY + YX)`, which gives `w_ab u_ab` on `φ_ab`. `sharpCross_diag` gives `½((wu)_ab + (uw)_ab)`. Hypotheses (both symmetric and hollow) are exactly those of `sharpCross_diag` and `diagOp_phi`. Zero row sums are not required and are not assumed. |
| 2 | `blockW`, `smul_sphereWeight_eq`, `sum_blockW_mul`, `mul_blockW_left/right` | CONFIRMED | `sphereWeight` (Base/Families.lean:308) has in-T entry `q/(p−1)`, out entry `p/(q−1)`, cross `−1`, so `t·sphereWeight` is `blockW T (tq/(p−1)) (tp/(q−1)) (−t)`. The row-sum formula is the hollow block sum, rechecked in both cases. `mul_blockW_right` uses `blockW_symm` correctly. |
| 3 | `K_cross`: eigenvalue `G − (A+B)/2` | CONFIRMED | By hand at a∈T, c∉T: `(wu)_ac = −A u_ac` (column sums vanish by `∑_T x = 0`), `(uw)_ac = −B u_ac` (row sums vanish by `∑_{Tᶜ} y = 0`), so `K u = (G − (A+B)/2) u`. Within T and within Tᶜ both sides are 0, the diagonal included. At the sphere block, `G − (A+B)/2 = −t(n−1)(n−2)/(2(p−1)(q−1))`, since `2(p−1)(q−1) + q(q−1) + p(p−1) = (n−1)(n−2)`. Dividing by `θ = t(n−1)` gives `−(n−2)/(2(p−1)(q−1)) = −μ_{p,q}`. |
| 4 | `K_zero`: hollow symmetric weights supported in T with zero row sums in T go to 0 | CONFIRMED | At a, c ∈ T: `w⊙u = A u_ac` and `(wu)_ac = (uw)_ac = −A u_ac`, so the sum is 0. Off T every term vanishes. The hypotheses are the right ones, and no row-sum relation on w is needed. This is the T side of `0^rest`, dimension `p(p−3)/2` for p ≥ 3. |
| 5 | `K_lam`: eigenvalue `½(p−2)(A−G)` off the diagonal | CONFIRMED | a, c ∈ T: `K u = (h_a + h_c)[A + ½(A(p−4) − G(p−2))] = ½(p−2)(A−G) u_ac`, which uses `κq = −(p−2)` and neither row relation. a ∈ T, c ∉ T: `K u = κh_a[G − A/2 − Gn/2]` after `(q−1)B = −pG` and `p−2 = −κq`. This equals `½(p−2)(A−G)κh_a` exactly when `(p−1)A = −qG`, which is `hr1`. Both relations hold at the sphere block. In L_e units, `½(p−2)·t(n−1)/(p−1) / (t(n−1)) = (p−2)/(2(p−1)) = λ_p`. Restricting to a ≠ c is honest, because `phi a a = 0` means `foxProd_diag` never reads K's diagonal, and `lamW` is itself in 𝒟ₙ (row sums `(p−2)h_a + qκh_a = 0` and `κ∑_T h = 0`). |
| 6 | Header "Not yet declared" and the INDEX L127 row | CONFIRMED WITH GAPS | The list is accurate: the eigenvalue-1 vector, mirror families, L_e units and spanning are all absent. The sum identity is right: `1 + (p−1) + (q−1) + (p−1)(q−1) = pq`, and `pq + (p(p−3) + q(q−3))/2 = (n² − 3n)/2`. The per-family reading fails at p = 2 (gap G1). |
| 7 | Axiom audit | CONFIRMED | `axiom_audit.py --only L127Dn.lean`: 13/13 clean on the standard three. No `sorry` or `native_decide`. `lake env lean` rc 0, with four unused-section-variable linter warnings only. |

**Screen (the eigenvalue-1 vector, reported as a screen and not a claim).** At `w = t·sphereWeight`, `K w = w⊙w + w²`. Within T this is `A²(p−1) + G²q = A·t(n−1)`. Across it is `G² + AG(p−1) + GB(q−1) = G·t(n−1)`. So `K w = θ w` with `θ = t(n−1)`, which agrees with the L127Le normalisation and indicates that the `#` constant in `sharpCross` is consistent with the L_e units used in claims 3 and 5.

## Gaps

- **G1, [L127Dn.lean:24-26](../lean/HamiltonsCubic/Results/L127Dn.lean) and [INDEX.md:495](../lean/INDEX.md).** The count `p(p−3)/2` is `−1` at p = 2, and at p = 2 `lamW` is identically zero (`h_a = −h_b` makes the within entry 0, and `κ = 0`). The true dimensions of both families are then 0, and those also sum to `n(n−3)/2`. The formula should be stated for p, q ≥ 3, with a clause saying that at p = 2 the λ_p and T-side zero families are both {0}. This is the same p = 2 edge that r375 found in the within-factor row. Here it is a counting defect only, because λ_2 = 0 merges into `0^rest`.
- **G2, [L127Dn.lean:128-244](../lean/HamiltonsCubic/Results/L127Dn.lean).** The three families are eigenvectors of `Kmat`. No declaration composes them with `foxProd_diag` to state `M ∘ diagOp u = λ diagOp u`, and none shows the families nonzero (`crossW` for nonzero x, y, `lamW` at p ≥ 3). The header states them at the weight level, so this is honest, but it is owed before the row's spanning.
- **G3 (cosmetic), [L127Dn.lean:55](../lean/HamiltonsCubic/Results/L127Dn.lean), 61, 184, 191.** Unused section-variable linter warnings on `blockW_symm`, `blockW_hollow`, `lamW_symm` and `lamW_colT`.

## What would break each claim, and what was done to look for it

- Claim 1 would break on a factor-of-two mismatch in `jordanProd` or `sharpCross`. I read both definitions and `foxProd_split`, and the eigenvalue-1 screen closes the constant.
- Claim 2 would break on an entry of `sphereWeight` that differs from `blockW`. I compared all four entry cases against Families.lean:308.
- Claims 3 and 5 would break on a missing row-sum relation or a wrong L_e conversion. I recomputed every case by hand, confirmed that the case a ∈ T, c ∉ T needs `hr1` and is not identically true, and converted with `θ = t(n−1)`.
- Claim 4 would break on a weight straddling T. The `hsupp` hypothesis excludes such weights, and the diagonal case uses `hhu`.
- Claim 6 would break at p = 2, where it does break per family (G1).
- Claim 7 would break on a hidden axiom, and the audit is clean.
