# Review r1604: L126's general-M bridge (commit 4afae450) and r1603's repairs (commit 4c25ae98)

**Standfirst.** [L126GenBridge.lean](../lean/HamiltonsCubic/Results/L126GenBridge.lean) carries [L126General.lean](../lean/HamiltonsCubic/Results/L126General.lean)'s `general_meets_iff` from the bare Fox product with θ free to `LeLin` on `CurvOp2` at θ = P(M), and discharges `critMap_hasDerivAt`'s hypotheses at every Bianchi vector of a four-set span at a general diagonal M taken critical by hypothesis. The `LeLin` in `general_LeLin_iff` is the operator of `critMap_kernel_iff`, `bridge_apply` is correct at the stated generality, `general_DF` exports v Weyl and ⟨M, v⟩ = 0, and the new first conjunct of `split_DF` is the orthogonality r1603 asked to see exported. Both modules build, and the audit gives 6/6 and 8/8 on the standard three. Three gaps remain, all in text: the record's machine-checked sentence at second-order.md:1704 still credits the general-M ½-eigenspace clause to `general_meets_iff` and names neither new file, the "What is NOT typed here" list in L126Statement.lean stops at L126General.lean, and "nonzero Bianchi vector" in the row and docstring is proved as a nonzero coefficient triple.

| Claim | Verdict |
|---|---|
| A-1. `general_LeLin_iff` states the record's clause with L_e the operator of `critMap_kernel_iff` | **CONFIRMED WITH GAPS** |
| A-2. `bridge_apply` holds for any Weyl R and any linear bivector-preserving S | **CONFIRMED** |
| A-3. `spanVec_isWeyl` and `general_DF`: v Weyl, self-adjoint, ⟨M, v⟩ = 0, `critMap_hasDerivAt` discharged | **CONFIRMED** |
| A-4. Criticality taken as the hypothesis `hcrit`, and P(M) > 0 as `hP`, both disclosed | **CONFIRMED** |
| A-5. The L126 row claims only what is proved and owes one composing statement | **CONFIRMED** |
| A-6. `split_DF`'s new first conjunct `innerOp2 M v = 0` | **CONFIRMED** |
| B. Build and axiom audit | **CONFIRMED** |
| C. Downstream text | **CONFIRMED WITH GAPS** |
| D. Style | **CONFIRMED** |

**Summary:** the bridge is sound and faithful to the record's clause at a diagonal critical M with θ > 0, r1603's gaps are closed in Lean and in the INDEX rows, and the gaps are a stale sentence in the record, a stale list in L126Statement.lean, and an unstated v ≠ 0.

## 1. Files and commits

- [L126GenBridge.lean](../lean/HamiltonsCubic/Results/L126GenBridge.lean), new in 4afae450: `spanVec` (line 29), `spanVec_lin`, `spanVec_skew`, `bridge_apply`, `general_LeLin_iff` (line 60), `spanVec_isWeyl`, `general_DF`.
- [L126DF.lean:157-210](../lean/HamiltonsCubic/Results/L126DF.lean#L157), `split_DF`'s statement, docstring and final term changed in 4c25ae98.
- [lean/INDEX.md:482-483](../lean/INDEX.md#L482), the L126 rows, changed in both commits.
- Definitions and statements read: `LeLin` at [L24Restrict.lean:87](../lean/HamiltonsCubic/Results/L24Restrict.lean#L87), `critMap`, `critMap_hasDerivAt` and `critMap_kernel_iff` at [L126Kernel.lean:26-76](../lean/HamiltonsCubic/Results/L126Kernel.lean#L26), `general_meets_iff` at [L126General.lean:104](../lean/HamiltonsCubic/Results/L126General.lean#L104), `span_coords` at [L126General.lean:87](../lean/HamiltonsCubic/Results/L126General.lean#L87), `D` at [L121.lean:38](../lean/HamiltonsCubic/Results/L121.lean#L38), `IsWeight` at [Families.lean:153](../lean/HamiltonsCubic/Base/Families.lean#L153), `IsWeyl` at [WeylReal.lean:126](../lean/HamiltonsCubic/Base/WeylReal.lean#L126).
- The record: [second-order.md:1695-1704](../findings/second-order.md#L1695), Lemma L126.

## 2. `general_LeLin_iff` against the record (A-1)

- **The operator.** `LeLin a v = foxProd2 ((Pcubic2 a)⁻¹ • a) v`, and `critMap_kernel_iff` reads `2M∘H − P(M)H = 0 ↔ LeLin M H = ½ H` with the same `LeLin`. `general_LeLin_iff` uses `LeLin (restrict (diagOp_isWeyl hwt))`, so the ½-eigenspace in its left side is the kernel of `critMap_kernel_iff`'s operator at M = restrict (diagOp w). This is the record's L_e.
- **The right side.** `D A B C = A² + B² + C² − AB − BC − CA` with A = w_ij + w_kl, B = w_ik + w_jl, C = w_il + w_jk, the opposite-pair sums, which is the record's Σ_ijkl. θ is instantiated to `Pcubic (diagOp w)`, and `Pcubic2_restrict` identifies it with P(M) on `CurvOp2`, so Σ = θ² is read at θ = P(M), as the record's "θ > 0, which P(M) = θ requires" does.
- **The proof.** `key` rewrites `LeLin M v` on each bivector X as P⁻¹ · foxProd (diagOp w) (spanVec …) X through `foxProd2_smul_left` and `bridge_apply`. Each direction then multiplies or divides by P, with `hP.ne'` for the cancellation, and the membership reduces exactly to `general_meets_iff`'s per-bivector equation at θ = P. Both directions are correct as written.
- **Hypotheses.** `IsWeight w` (symmetric, hollow, zero row sums) is the Weyl condition for a diagonal operator, discharged through `diagOp_isWeyl`. Unit norm is absent and unneeded, since both sides are homogeneous of the same degree under M ↦ cM. Criticality is absent and unneeded here, since the clause is spectral.
- **Gap (minor).** The existential carries `(x, y, z) ≠ 0`, while the docstring at [L126GenBridge.lean:15](../lean/HamiltonsCubic/Results/L126GenBridge.lean#L15) and the INDEX row say "some nonzero Bianchi vector v". The equivalence is true: `span_coords` gives v(φ_ij) = x φ_kl, v(φ_ki) = y φ_jl, v(φ_il) = z φ_jk at distinct indices, so a nonzero coordinate gives v ≠ 0. It is stated nowhere for the restricted `v` on `CurvOp2`, which the composing statement will need if it quantifies over nonzero kernel vectors.

## 3. `bridge_apply` (A-2)

- The statement takes an arbitrary `R` with `IsWeyl R` and an arbitrary `S` with `IsLinOp S` and skew-preservation, on `Fin n`, and equates `foxProd2 (restrict hW) (restrictLin hl hs) X` with `foxProd R S X` for every X in `skewSub`.
- The proof rewrites the left side as `foxProd` of the two extensions (`foxProd_extend`) and applies `foxProd_congr_on_skew`, whose four premises are: both extensions preserve skew, and each extension agrees with its bare operator on skew inputs (`extend_restrict_on_skew`, `extend_restrictLin_on_skew`). That is exactly what the product on bivectors depends on. Correct and general as claimed.

## 4. `spanVec_isWeyl` and `general_DF` (A-3, A-4)

- **Weyl.** Bivector-preservation is `spanVec_skew`. Symmetry follows from `rk2_symm` term by term. First Bianchi is `fourSet_bianchi_iff` at x + y + z = 0. Ricci-flatness applies `ric_rk2_disjoint` to the three disjoint pairs {ij, kl}, {ki, jl}, {il, jk}, with the supplied inequality tuples checked against each pair.
- **IsWeyl2 and self-adjointness.** `isWeyl2_restrict` after an extensionality step identifying `restrictLin` with `restrict`, and `hWv.selfAdjoint` feeds `critMap_hasDerivAt`'s `hH`.
- **⟨M, v⟩ = 0.** `innerOp_extend` moves the pairing to the bare operators on the φ_ab basis, `innerOp_lin3` and `innerOp_rk2` reduce it to ⟨diagOp w φ_V, φ_U⟩ + ⟨diagOp w φ_U, φ_V⟩ terms, and `diagOp_phi` with `inner2_phi_phi` kills each at disjoint pairs. This holds for every (x, y, z), so `hs` is used only for Weyl.
- **Discharge.** `critMap_hasDerivAt` needs M self-adjoint (`isSelfAdjoint2_restrict hW`), H self-adjoint, `Qop2 M = lam • M`, and `innerOp2 M H = 0`. All four are supplied, the third by the hypothesis `hcrit` with `th` free. The conclusion exports `IsWeyl2 v ∧ innerOp2 M v = 0 ∧ ∀ Z, HasDerivAt …`.
- **Criticality as a hypothesis.** The record's lemma is stated at a diagonal critical point, so taking criticality as input matches the record rather than weakening it. The docstring ("with M critical on CurvOp2") and the row ("so at a critical M") state it as a condition, which is honest.
- **P(M) > 0.** Needed in some form: at P(M) = 0 the operator `LeLin` has the factor 0⁻¹ = 0 and the equivalence fails. `general_meets_iff` uses θ > 0 through `G_eigen_iff`. The record assumes θ > 0 explicitly, the docstring and the row both name it, and `general_DF` does not need it.

## 5. The L126 row and `split_DF` (A-5, A-6)

- The row's new sentence names `bridge_apply`, `general_LeLin_iff`, `spanVec_isWeyl` and `general_DF`, gives the counts 6/6, and closes with "**Owed**: one statement composing these files into the lemma as the record states it". What remains is exactly that composition: `general_DF` plus `critMap_kernel_iff` (with `Pcubic2 M ≠ 0` from `hP` through `Pcubic2_restrict`) plus `general_LeLin_iff`, together with the sphere-product specialisation already in `split_DF`. The row claims nothing beyond the proved statements.
- The statement row now names [L126Weyl.lean](../lean/HamiltonsCubic/Results/L126Weyl.lean) and [L126GenBridge.lean](../lean/HamiltonsCubic/Results/L126GenBridge.lean), closing r1603's gap 3.
- `split_DF`'s new first conjunct `innerOp2 M v = 0` is the local `hperp` returned as the first component of the anonymous constructor. The `let`-bound M and v are the same ones the other conjuncts use. Correct, and it closes r1603's gap 1: tangency of the (2,2) direction is now the conjunction of two exported statements, `splitVec_isWeyl2` and this conjunct.

## 6. Build and axiom audit (B)

- `lake build HamiltonsCubic.Results.L126GenBridge HamiltonsCubic.Results.L126DF`: "Build completed successfully (8795 jobs)", exit 0, no errors, warnings only in unrelated files.
- `axiom_audit.py --only L126GenBridge.lean`: 6/6 clean on the standard three. `--only L126DF.lean`: 8/8 clean.
- No `sorry` and no `native_decide` in either file.

## 7. Downstream (C)

- **Gap.** [second-order.md:1704](../findings/second-order.md#L1704), the machine-checked sentence of Lemma L126, ends "at a general diagonal M a four-set block meets the ½-eigenspace exactly when Σ = θ², `general_meets_iff` in L126General.lean". `general_meets_iff` is the bare Fox product with θ free, and r1603 had the Lean docstrings corrected to say so. The ½-eigenspace of L_e is `general_LeLin_iff`, and the tangency and derivative are `general_DF` and `splitVec_isWeyl2`. The sentence names neither [L126GenBridge.lean](../lean/HamiltonsCubic/Results/L126GenBridge.lean) nor [L126Weyl.lean](../lean/HamiltonsCubic/Results/L126Weyl.lean).
- **Gap.** [L126Statement.lean:50-60](../lean/HamiltonsCubic/Results/L126Statement.lean#L50), "What is NOT typed here", lists the files that carry the identification up to L126General.lean and omits L126Weyl.lean and L126GenBridge.lean. It is the Lean-side twin of the statement row that 4c25ae98 repaired.
- [lean/INDEX.md:482-483](../lean/INDEX.md#L482): current. The `split_DF` sentence in the row says the hypotheses are discharged including ⟨M, v⟩ = 0, consistent with the new conjunct.

## 8. Style (D)

- No em dash in either file or in the added INDEX, STATUS and plan-lean lines. No backticks inside link text. The INDEX rows are single lines. Semicolons in the row separate list items that themselves carry commas.
- The `split_DF` docstring now breaks after "so" and after "applies, and" at [L126DF.lean:158-160](../lean/HamiltonsCubic/Results/L126DF.lean#L158), which is a Lean comment and cosmetic only.

## 9. Verdict

**CONFIRMED WITH GAPS.**

1. [second-order.md:1704](../findings/second-order.md#L1704): the general-M ½-eigenspace clause is credited to `general_meets_iff`. It should cite `general_LeLin_iff` and `general_DF` in L126GenBridge.lean and `splitVec_isWeyl2` in L126Weyl.lean.
2. [L126Statement.lean:50-60](../lean/HamiltonsCubic/Results/L126Statement.lean#L50): the list of files carrying the identification omits L126Weyl.lean and L126GenBridge.lean.
3. [L126GenBridge.lean:15](../lean/HamiltonsCubic/Results/L126GenBridge.lean#L15) and the L126 row: "nonzero Bianchi vector" is proved as a nonzero coefficient triple. The step to v ≠ 0 on `CurvOp2` follows from `span_coords` but is stated nowhere, and the owed composing statement will want it.
