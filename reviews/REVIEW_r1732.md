# REVIEW r1732: CriticalBridge and L120Witness (commit 8687d427)

*Cold Gate 2 statement-fidelity review of [CriticalBridge.lean](../lean/HamiltonsCubic/Results/CriticalBridge.lean) and [L120Witness.lean](../lean/HamiltonsCubic/Results/L120Witness.lean), read against their definitions in Base and Results. Analysis only: no `lake build`, no `lake env`. The only compute was a grep screen for `sorry`, `native_decide`, `axiom` and `admit` in both files (none found) and for the two root imports (both present). Heartbeats: [agent_logs/review-r1732.log](../agent_logs/review-r1732.log).*

| # | Claim | Verdict |
|---|---|---|
| 1 | `Qop2_restrict_of_critical`: `IsCritical W θ` at a linear Weyl `W` gives `Qop2 (restrict hW.2) = θ • restrict hW.2` | CONFIRMED |
| 2 | That equation is exactly the `hcrit` hypothesis of `hessOp_pair`, `hessOp_four` and L126GenBridge's `general_DF` | CONFIRMED |
| 3 | `isCritical_smul`, `normSq_smul`: `cR` is critical at `cθ`, `‖cR‖² = c²‖R‖²` | CONFIRMED |
| 4 | `unit_critical` meets all of `hessOp_pair`'s hypotheses on `w`, with `P = cθ ≠ 0` at unit norm | CONFIRMED |
| 5 | `balanced_unit`: L71Witness's `Wb p` is the right object and its norm is positive | CONFIRMED |
| 6 | `L120_pair_instance` is a non-vacuous assembled instance at a concrete critical `w` | CONFIRMED WITH OBSERVATIONS (O1, O2) |
| 7 | The INDEX L120 row claims only what is typed | CONFIRMED WITH OBSERVATION (O2) |

**Summary: both files type what they say, the bridge is sound and in the right direction, and the one defect is a module docstring that names a concrete `B` the theorem does not instantiate.**

## 1. The bridge from `IsCritical` to the `CurvOp2` equation

- `IsCritical R th` ([WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)) is `∀ i j, Qop R (phi i j) = th • R (phi i j)`, a basis statement.
- `Qop_skew_of_critical` extends it to every skew `X`. `skew_expand` writes `X = ½ ∑∑ ⟨X, φ_ij⟩ φ_ij`, with the same ordered-pair doubling on both sides, so the normalisation cancels identically. Linearity of `W` is `hW.1` and linearity of `Qop W` is `Qop_isWeylOp W hW` from L209. Both sides are pushed through the same sum and the basis equation is substituted termwise. Sound.
- Nothing is lost where `W` is `IsWeylOp` but acts on all matrices: `Qop2` and `restrict` only ever read `W` on `skewSub`, and the extension is checked only there.
- `extend_restrict_on_skew` is `extend_apply` at the subtype, and `Qop_restrict_on_skew` rewrites both `compOp` slots with it and the `sharpOp` slot with `sharpOp_congr_on_skew`, whose hypotheses (`W` preserves skew, agreement on skew) are `hW.1` of `IsWeyl` and the previous lemma. Sound.
- `Qop2` ([Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean)) is `compOp2 R + sharpMapCL R`, the layer's `CurvOp2` form of `Qop`. `Qop_extend` states `Qop (extend R) X = ↑(Qop2 R X)` on `skewSub`, and the proof uses it left to right: it computes `Qop (extend (restrict W)) X`, rewrites that to `θ • W X`, and reads off `Qop2 (restrict W) X`. The direction is right.
- The converse (the `CurvOp2` equation implies `IsCritical`) also holds by evaluating at `φ_ij`, but nothing here needs it.

## 2. Does it discharge the consumers' hypothesis?

- `hessOp_pair` and `hessOp_four` ([L120HessPair.lean](../lean/HamiltonsCubic/Results/L120HessPair.lean)) and `general_DF` ([L126GenBridge.lean](../lean/HamiltonsCubic/Results/L126GenBridge.lean)) all take `hcrit : Qop2 (restrict (diagOp_isWeyl hwt)) = lam • restrict (diagOp_isWeyl hwt)`.
- `Qop2_restrict_of_critical` delivers `Qop2 (restrict hW.2) = θ • restrict hW.2`. By proof irrelevance `restrict hW.2` and `restrict (diagOp_isWeyl hwt)` are the same term whenever `hW.2 : IsWeyl (diagOp w)`, which `unit_critical` uses directly. It discharges the hypothesis for all three consumers at any diagonal `w` with `IsCritical (diagOp w) θ`.

## 3. The scaling lemmas

- `isCritical_smul`: `Qop_smul` gives `Qop (c • R) φ = c² • Qop R φ = c²θ • R φ`, and `(cθ) • (c • R) φ = c²θ • R φ`. Correct, with `IsLinOp R` the only hypothesis `Qop_smul` needs.
- `normSq_smul`: `innerOp` is `½ ∑∑ inner2 (R φ) (S φ)`, bilinear in the two operator slots, so `c²` comes out. Correct.
- `diagOp_smul` and `isWeight_smul` duplicate Base/Families.lean's `diagOp_smul` and `IsWeight.smul` in slightly different shapes (`c • diagOp w` against a lambda). Harmless.

## 4. `unit_critical`

- With `c = 1/√‖diagOp w‖²`, `c²‖diagOp w‖² = 1`, so `normSq (diagOp (c • w)) = 1`, and `normSq2_restrict` carries it to `normSq2 (restrict …) = 1`.
- The criticality is item 1 at `diagOp (c • w)` and `cθ`, with `IsWeylOp` from `diagOp_isLinOp'` and `diagOp_isWeyl`.
- `Pcubic2 (restrict …) = Pcubic W = innerOp W (Qop W) = cθ · normSq W = cθ` through `Pcubic2_restrict`, `Pcubic_eq_innerOp_Qop` and `innerOp_Qop_of_critical`. So `P = θ'` at unit norm, and `c ≠ 0`, `θ ≠ 0` give `P ≠ 0`. Correct.
- These are all three of `hessOp_pair`'s hypotheses on `w` (`ha`, `hcrit`, `hθ`), and `hwt` is `isWeight_smul`.

## 5. `balanced_unit`

- `Wb p` is `diagOp (weylE (βb p))`, and `Wb_critical p hp : IsCritical (Wb p) 1` at `p ≥ 3` is proved from SharpDiag's `diagCriticalityIsCritical`, already CONFIRMED in r1717. `weylE_isWeight` with `hbs`, `hn` supplies `IsWeight`. Right object, `θ = 1 ≠ 0`.
- Positivity: `innerOp_diagOp` gives `normSq (diagOp w) = ½ ∑∑ w_ij²`. That is right, since `inner2 φ_ij φ_ij = ½ tr(φᵀφ) = 1` at `i ≠ j` and `w` is hollow.
- At `(0, p)`: `βb p 0 = true` (`0 < p`) and `βb p p = false`, so `weylE_val` gives `-(1/(2p-1))`, with `Fintype.card (Fin (2p)) = 2p`. Its square is positive at `p ≥ 3`, and two `single_le_sum` steps bound it by the double sum. Correct.

## 6. `L120_pair_instance`

- The statement is `∃ w hwt lam ha hcrit hθ, ∀ B hB j k hjk hiso, SignChar … (tanV (hessOp …))`. The existential is non-trivial: `ha` forces `w ≠ 0` and `hθ` forces `P ≠ 0`. The inner `∀` is non-vacuous: `pairS_mem` and `pairS_iso` give `B` meeting `hB` and `hiso` at every `j ≠ k` with coefficients on the Ricci cut, and `coord_pairS_diag` makes it nonzero at `n ≥ 4`, per r1695 O1. At `n = 2p ≥ 6`, `j = 0`, `k = 1`, `c = δ₂ − δ₃` sums to zero over the filter and gives `coord … 0 2 1 2 = 1`.
- **O1 (docstring overclaims a concrete `B`).** The module docstring, [L120Witness.lean:26-27](../lean/HamiltonsCubic/Results/L120Witness.lean#L26), says `L120_pair_instance` is *"`hessOp_pair` applied there with L120Pair's `pairS` at `j = 0`, `k = 1`, `c = δ₂ - δ₃`"*. The theorem quantifies `B` universally and never instantiates `pairS`. The theorem's own docstring (*"L120Pair's `pairS` supplies nonzero `B` at `n ≥ 4`"*) is accurate as prose. Repair: either reword the module docstring to the universal form, or add the concrete corollary, which is a direct application with `pairS_mem`, `pairS_iso` and the coefficient above, plus `B ≠ 0` from `coord_pairS_diag`. The corollary is the better choice because it types both halves of *"assembled instance"* and makes the conclusion's non-vacuity kernel-checked rather than argued.
- **O2 ("concrete" lives in the proof, not the statement).** `w` is existential, so the statement holds of any unit critical diagonal `w` with `P ≠ 0` on `Fin (2p)`. It does not say the witness is the rescaled balanced sphere product. What is typed is that `hessOp_pair`'s hypotheses on `w` are jointly satisfiable at every `n = 2p`, `p ≥ 3`, together with the conclusion there. That is a legitimate reading of *"an assembled instance"*. If the row wants "at the balanced product" as a typed claim, add a conjunct `w = c • weylE (βb p)` for some `c > 0`, or state `balanced_unit` with the witness named.

## 7. The INDEX L120 row

- The owed clause *"no assembled instance with a concrete critical $w$ is typed"* is removed and replaced by a paragraph naming `unit_critical`, `balanced_unit`, `L120_pair_instance` and `Qop2_restrict_of_critical`. Each description matches its declaration.
- The phrase *"`L120_pair_instance` gives `hessOp_pair`'s conclusion there for every pair-summand $B$"* is accurate up to O2: "there" is the balanced product in the proof and an existential unit critical `w` in the statement. It claims no four-set instance, and none is typed, which is consistent.
- The row does not yet carry this review's reference, which the lean loop adds on folding.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** The bridge is sound, is used in the right direction, and discharges `hcrit` for `hessOp_pair`, `hessOp_four` and `general_DF` at every critical diagonal `w`. The scaling, the unit normalisation, `P = θ'` and the balanced product's positive norm are all correct. O1 is a docstring defect to repair (reword, or better, add the concrete-`B` corollary). O2 is a precision note for the row: "concrete" is a property of the proof term, and the statement carries satisfiability.
