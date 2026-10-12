# Review r1600: L126 across the layers (L126Bridge), commit b5af8c1f, and r1599's repair, commit 7ca08fee

**Standfirst.** [L126Bridge.lean](../lean/HamiltonsCubic/Results/L126Bridge.lean) proves, on `Fin n` at a unit sphere product `M = restrict hW` with `W = diagOp (t • sphereWeight T)` and a (2,2)-split, that `LeLin M v = μ_{p,q} • v` for `v = restrictLin (2a − b − c)`. `LeLin a` is `foxProd2 ((Pcubic2 a)⁻¹ • a)`, which is e ∘ · with e = a/P(a), the operator whose ½-eigenspace `critMap_kernel_iff` names, and `Pcubic2 M = θ` is obtained through `Pcubic2_restrict` and `theta_of_unit` at unit norm, which is the record's normalisation. The proof transports L126Assembly's bare `split_eigen` through `foxProd_extend` and `foxProd_congr_on_skew`, and the sign through `split_value_eq`. The repair commit's `sums_eq_of_not_22` and `nonsplit_kill` decide all sixteen membership patterns and close r1599's gap 2. Both modules build, and the audits read 4/4 and 8/8 on the standard three. The gaps are in what the record says around the theorem: the owed composition hides three hypotheses, two docstrings call μ_{p,q} an eigenvalue while v ≠ 0 is owed, one audit count is stale, and three pointers do not yet name the new file.

| # | Claim | Verdict |
| --- | --- | --- |
| A-1 | `split_LeLin`: `LeLin (restrict hW) v = μ_{p,q} • v` on `Fin n`, v the restricted Bianchi vector 2a − b − c | **CONFIRMED** |
| A-2 | `LeLin a` is e ∘ · with e = a/P(a), the operator of `critMap_kernel_iff` | **CONFIRMED** |
| A-3 | P(restrict hW) = θ at unit norm is the right normalisation (`Pcubic2_restrict`, `theta_of_unit`) | **CONFIRMED** |
| A-4 | "so μ_{p,q} is an eigenvalue of the operator whose ½-eigenspace `critMap_kernel_iff` identifies with ker DF(M)" | **CONFIRMED WITH GAPS** (an eigen-equation, eigenvalue only once v ≠ 0, which is owed) |
| A-5 | the L126 row owes exactly v ≠ 0 and the composition with `critMap_kernel_iff` | **CONFIRMED WITH GAPS** (the composition carries three unnamed hypotheses of `critMap_hasDerivAt`) |
| A-6 | the restriction to `Fin n` is disclosed | **CONFIRMED** (docstring line 12, row 482 "on `Fin n`") |
| A-7 | `sums_eq_of_not_22` and `nonsplit_kill` close r1599's gap 2 | **CONFIRMED** |
| A-8 | 7ca08fee's three pointers and the splice repair | **CONFIRMED** |
| B | builds succeed, audits 4/4 (L126Bridge) and 8/8 (L126Splits) on propext, Classical.choice, Quot.sound, no `sorry`, no `native_decide` | **CONFIRMED** |
| C | downstream consistency | **CONFIRMED WITH GAPS** (stale 6/6 at lean/INDEX.md:482, second-order.md:1704 and L126Statement.lean:52-57 omit L126Bridge) |
| D | style | **CONFIRMED** |

**Summary:** the bridge is sound and faithful, L126's (2,2) Bianchi vector satisfies the L_e eigen-equation with +μ_{p,q} on `CurvOp2`, and r1599's gaps are closed. The gaps are four statements of the record around it.

## 1. Files and commits

- [L126Bridge.lean](../lean/HamiltonsCubic/Results/L126Bridge.lean), landed in b5af8c1f with the L126 row of [lean/INDEX.md:482](../lean/INDEX.md#L482), the aggregator import, STATUS.md and plan-lean.md file counts (848 to 849, correct for one new file).
- 7ca08fee: [L126Splits.lean](../lean/HamiltonsCubic/Results/L126Splits.lean) gains `sums_eq_of_not_22` and `nonsplit_kill`, and the pointers at [L126Statement.lean:52-57](../lean/HamiltonsCubic/Results/L126Statement.lean#L52), [lean/INDEX.md:483](../lean/INDEX.md#L483) and [second-order.md:1704](../findings/second-order.md#L1704) are edited.

## 2. Fidelity of split_LeLin (A-1 to A-6)

**The operator.** [L24Restrict.lean:87](../lean/HamiltonsCubic/Results/L24Restrict.lean#L87) defines `LeLin a v = foxProd2 ((Pcubic2 a)⁻¹ • a) v` with `foxProd2 X Y = ½(Q(X+Y) − Q(X) − Q(Y))`. That is L_e = e ∘ · with e = a/P(a). [L126Kernel.lean:75](../lean/HamiltonsCubic/Results/L126Kernel.lean#L75) `critMap_kernel_iff` states `2 M∘H − P(M) H = 0 ↔ LeLin M H = ½ H` at P(M) ≠ 0, with the same `LeLin`, so the operator is the one the brief names.

**The normalisation.** `Pcubic2_restrict` ([L0Witness.lean:35](../lean/HamiltonsCubic/Results/L0Witness.lean#L35)) gives `Pcubic2 (restrict hW) = Pcubic W`, and `theta_of_unit` ([Families.lean:636](../lean/HamiltonsCubic/Base/Families.lean#L636)) gives `theta W = Pcubic W` at `normSq W = 1`. The record's L126 reads e = M/θ at a unit-norm M with P(M) = θ, so these are the right two steps. θ ≠ 0 is derived inside the proof from `split_value_eq` and μ_{p,q} > 0 at p, q ≥ 2, which is valid: θ = 0 would force the left side of `split_value_eq` to 0 through division by zero.

**The vector.** `splitVec i j k l` is term for term the `v` of `split_eigen` ([L126Assembly.lean:45](../lean/HamiltonsCubic/Results/L126Assembly.lean#L45)), 2 rk2(φ_ij, φ_kl) − rk2(φ_ki, φ_jl) − rk2(φ_il, φ_jk). `splitVec_lin` and `splitVec_skew` supply what `restrictLin` needs. The transport is `foxProd_extend` (Fox product commutes with `extend`) and `foxProd_congr_on_skew`, which replaces `extend M` by `diagOp w` and `extend v` by `splitVec` on skew inputs, both justified by the `extend_restrict_on_skew` lemmas. Arithmetic closes by `P = θ` and `split_value_eq`, so the eigenvalue is +μ_{p,q} with the sign r1598 required.

**Coverage of placements.** The theorem fixes i, j ∈ T and k, l ∉ T. Every (2,2) four-set admits such a labelling, and r1599 §A-3 showed relabelling sends the signed basis (a, b, c) to minus a permutation of itself, so every (2,2) block is covered.

**A-4, eigen-equation against eigenvalue.** The module docstring (lines 14-16) and the theorem docstring (line 48, "IS AN EIGENVALUE") say μ_{p,q} is an eigenvalue. The theorem proves `LeLin M v = μ • v`, which is an eigenvalue statement only for v ≠ 0, and row 482 correctly lists v ≠ 0 as owed. The docstrings claim more than the file proves. v ≠ 0 is true by hand (v sends φ_kl to 2φ_ij plus terms in other basis bivectors, nonzero since i, j, k, l are distinct), so this is a wording gap.

**A-5, the composition.** `critMap_kernel_iff` is a pure algebraic equivalence at P(M) ≠ 0, and applying it to `split_LeLin` gives only "2 M∘v − θv = 0 iff μ = ½", with no reference to a derivative. The reading of its left side as DF(M)v is `critMap_hasDerivAt` ([L126Kernel.lean:51](../lean/HamiltonsCubic/Results/L126Kernel.lean#L51)), whose hypotheses are `IsSelfAdjoint2 M`, `IsSelfAdjoint2 H`, `Qop2 M = lam • M` and `innerOp2 M H = 0`. For the statement row 482 owes ("the four-set block meets ker DF(M) exactly when μ_{p,q} = ½"), three of these must be supplied at M = restrict hW and H = v: criticality of the sphere product on `CurvOp2`, self-adjointness of v, and ⟨M, v⟩ = 0. Each holds by hand (L57Critical carries the matrix-side criticality, rk2 of skew pairs is symmetric, and M is diagonal on the φ_ab basis while v has only off-diagonal entries at four distinct indices). None is in the owed list, and none is proved in the L126 files on `CurvOp2`, so the list reads as nearer closure than it is.

**A-6.** The `Fin n` restriction is stated in the module docstring (line 12, "This file joins them on `Fin n`") and in row 482. It is inherited from `Pcubic2_restrict` and loses nothing, since the record's index set is Fin n.

## 3. Commit 7ca08fee (A-7, A-8)

**`sums_eq_of_not_22`** ([L126Splits.lean:99](../lean/HamiltonsCubic/Results/L126Splits.lean#L99)) takes six distinctness hypotheses and a count of {i, j, k, l} ∩ T different from 2, unfolds `sphereWeight`, and splits on four memberships, sixteen cases, discharging the six count-2 cases by `norm_num at hn` and the rest by `ring`. Checked by hand: at counts 4 and 0 all six weights coincide, and at counts 3 and 1 every opposite pairing has one pair inside the majority side and one pair meeting the odd index, so A = B = C. **`nonsplit_kill`** composes it with `equal_sums_kill` through the symmetry of `t • sphereWeight T`. This is the Lean corollary r1599 gap 2 asked for, with the placement quantified, and it closes the gap.

**Pointers.** L126Statement.lean:52-57, lean/INDEX.md:483 and second-order.md:1704 now name L126Splits (r1599 gap 1). The second-order.md clause "The derivation is valid at p,q ≥ 2, and p = 1 is excluded structurally" replaces the splice (r1599 gap 3). All accurate.

## 4. Soundness (B)

- `lake build HamiltonsCubic.Results.L126Bridge HamiltonsCubic.Results.L126Splits`: "Build completed successfully (8775 jobs)", exit 0. Warnings are linter notes in upstream files.
- `python3 scripts/misc/axiom_audit.py --only L126Bridge.lean`: "4/4 clean -- resting on the standard three alone".
- `python3 scripts/misc/axiom_audit.py --only L126Splits.lean`: "8/8 clean -- resting on the standard three alone".
- No `sorry` or `native_decide` in either file.

## 5. Downstream (C)

1. [lean/INDEX.md:482](../lean/INDEX.md#L482) says L126Splits is "6/6 on the standard three". The audit now reads 8/8 after 7ca08fee added two theorems.
2. [second-order.md:1704](../findings/second-order.md#L1704) says the Bianchi vector "is an L_e-eigenvector with eigenvalue +μ_{p,q}" and cites `split_eigen` and `split_value_eq` in L126Assembly, which are about the bare `foxProd`. The L_e statement on `CurvOp2` is `split_LeLin` in L126Bridge, which the note does not name.
3. [L126Statement.lean:52-57](../lean/HamiltonsCubic/Results/L126Statement.lean#L52), "The identification of μ_{p,q} as an L_e eigenvalue lives in other files", lists Kernel, Orbit, Assembly and Splits and omits L126Bridge, the file that makes the identification.
4. [lean/INDEX.md:483](../lean/INDEX.md#L483), the statement row, likewise omits L126Bridge. It defers the owed list to row 482, which stays true.

## 6. Style (D)

- No em dashes in the added lines of either commit, no backticks inside markdown link text, the INDEX rows and second-order.md paragraphs are one line each.
- The semicolons in row 482's added text separate list items that carry commas, the precedent r1599 §4 accepted.

## 7. Verdict

**CONFIRMED WITH GAPS.**

1. [lean/INDEX.md:482](../lean/INDEX.md#L482): the owed composition needs `critMap_hasDerivAt`'s hypotheses at M = restrict hW and H = v, namely `Qop2 M = lam • M` on `CurvOp2`, `IsSelfAdjoint2 v` and `innerOp2 M v = 0`. Name them in the owed list.
2. [L126Bridge.lean:14-16](../lean/HamiltonsCubic/Results/L126Bridge.lean#L14) and [L126Bridge.lean:48](../lean/HamiltonsCubic/Results/L126Bridge.lean#L48): "is an eigenvalue" while v ≠ 0 is owed. State the eigen-equation, or prove v ≠ 0.
3. [lean/INDEX.md:482](../lean/INDEX.md#L482): L126Splits "6/6" is stale, the audit reads 8/8.
4. [second-order.md:1704](../findings/second-order.md#L1704), [L126Statement.lean:52-57](../lean/HamiltonsCubic/Results/L126Statement.lean#L52) and [lean/INDEX.md:483](../lean/INDEX.md#L483): name L126Bridge's `split_LeLin` for the L_e statement on `CurvOp2`.
