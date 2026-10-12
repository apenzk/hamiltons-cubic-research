# Review r1550: L82's free bound (L82Free.lean, commit 4e80b476) and r1549's gaps with the L73 and L116 rows (commit a0dddcdd)

**Standfirst.** [L82Free.lean](../lean/HamiltonsCubic/Results/L82Free.lean) builds, audits 4/4 on the standard three and proves the record's min-form free bound for every unit skew matrix given in normal form with at least two blocks, and the "or" form it proves is equivalent to the min form. All six of r1549's gaps are closed and the rewritten L73 and L116 rows are accurate at HEAD. The gaps sit in the L82 row: its owed list still names two items [L82Statement.lean](../lean/HamiltonsCubic/Results/L82Statement.lean) has proved, and it keeps calling the refuted bare constant 2/√⌊m/2⌋ "the free bound" beside the theorem that replaces it.

| # | claim | verdict |
| --- | --- | --- |
| A-1 | `free_bound_skew` is the record's "every unit skew matrix satisfies s₁+s₂ ≥ min{1, 2/√⌊m/2⌋}" | **CONFIRMED WITH GAP** (normal forms with k ≥ 2 only, the k ≤ 1 case and the assembly with `skew_normal_form` unstated) |
| A-2 | the L82 row is accurate and its owed list is what remains | **GAP** (two of three owed items are proved in L82Statement.lean, the bare constant is still called the free bound) |
| A-3 | a0dddcdd closes r1549's gaps 1–6, and the L73 and L116 main rows are accurate | **CONFIRMED** (two minor imprecisions) |
| B | build, axiom audit, no sorry, admit or native_decide | **CONFIRMED** |
| C | no downstream text calls L82's free bound untyped | **CONFIRMED** |
| D | style of the markdown edits | **CONFIRMED WITH GAP** (two semicolon splices) |

**Summary: CONFIRMED WITH GAPS. The Lean is sound and faithful to the min form on normal forms with two or more blocks, and r1549's gaps are closed, but lean/INDEX.md:413 lists as owed the trace-free step and L31's root-system step that L82Statement.lean proves, and still names the refuted bare 2/√⌊m/2⌋ "the free bound".**

## 1. Fidelity of L82Free.lean (A-1)

- **The unit.** `hunit : inner2 X X = 1` is the record's ½tr(XᵀY) pairing. The proof moves it to Σ_c s_c² = 1 through [L240NormalForm.lean](../lean/HamiltonsCubic/Results/L240NormalForm.lean)'s `inner2_conj` (applied with Oᵀ, whose hypothesis is the given Oᵀ O = 1) and [L237SlotCounts.lean](../lean/HamiltonsCubic/Results/L237SlotCounts.lean)'s `inner2_X_X`. Faithful, and it matches the record's own φ₀₁ remark, which calls φ₀₁ unit with pair spectrum (1,0,0).
- **Pair values and the two largest.** The pair values are |N.s c| of X = O N.X Oᵀ. `hji : |s j| ≤ |s i|` and `htop : ∀ l ≠ i, |s l| ≤ |s j|` say exactly that i and j carry the two largest absolute values, and taking absolute values is right because `NormalForm` puts no sign on `s`.
- **The "or" form is the min form.** For t ≥ 0 and K ≥ 1, t ≥ min{1, 2/√K} holds iff t ≥ 1 or t ≥ 2/√K, and t ≥ 2/√K iff K t² ≥ 4. K = ⌊m/2⌋ ≥ 2 is forced by `pairs_le_half` and i ≠ j, so the root is well defined wherever the theorem applies.
- **`free_bound_scalar`.** The chord identity t(a² + (k−1)b²) = t²(t − 2b) + (k t²/2) b − k t b (t/2 − b) holds by `ring`, and under t < 1 and k t² < 4 the two chord terms are strictly below t − 2b and 2b, one of them strictly, which contradicts a² + (k−1)b² ≥ 1. The argument is right, and it is the convexity statement the header gives.
- **`pairs_le_half`.** The images of p and q are disjoint by `hpq`, each has k elements by injectivity, so 2k ≤ |ι|. Correct.
- **Gap 1, coverage.** `hij : i ≠ j` in `Fin k` makes the theorem vacuous at k ≤ 1. The record's own extremiser φ₀₁ has a one-block normal form, and at k = 1 unitness gives |s₀| = 1, so the bound holds trivially, but no theorem says so. The file also never assembles "every unit skew matrix": the existence of a normal form is `skew_normal_form` ([L240NormalForm.lean:307](../lean/HamiltonsCubic/Results/L240NormalForm.lean)) and the existence of a top-two pair is a finite argmax, and neither is invoked. The title at [L82Free.lean:7](../lean/HamiltonsCubic/Results/L82Free.lean) and the L82 row say "every unit skew matrix", while `free_bound_skew` at [L82Free.lean:104](../lean/HamiltonsCubic/Results/L82Free.lean) takes the normal form, k ≥ 2 and the pair (i, j) as data. The k ≥ 2 restriction is stated nowhere.
- **Duplication.** Nothing duplicates L82.lean (arithmetic of the cut-off), L240NormalForm.lean or L237SlotCounts.lean, both of which are imported and cited. [L82Statement.lean:154](../lean/HamiltonsCubic/Results/L82Statement.lean)'s `sum_two_ge_one` is the ⌊m/2⌋ ≤ 4 special case of the new bound on an ordered nonnegative vector, and L82Free.lean does not cite it. An uncited overlap.

## 2. The L82 row (A-2)

- **Gap 2, the owed list is stale on two of its three items.** The row ([lean/INDEX.md:413](../lean/INDEX.md)) ends "Owed: both displayed inequalities, and L31's root-system step ‖ad_{v_N}‖_op = s₁+s₂". The second displayed inequality, T₊ ≤ 2|λ_N|, is `Tplus_le_two_abs` ([L82Statement.lean:66](../lean/HamiltonsCubic/Results/L82Statement.lean)), and L31's step is `adNorm_eq_sum_two` ([L82Statement.lean:400](../lean/HamiltonsCubic/Results/L82Statement.lean)), which the statement row one line below calls PROVED 2026-09-24. What remains is the contraction bound ‖ad_{v_N}‖² ≥ 2|λ_N|/T₊, carried as the binder `hcontract`. The list is inherited from the row before 4e80b476, but the commit rewrote the list (dropping "the free bound") and its body restates the two stale items. The row's closing "statement: not typed" also contradicts the typed statement row at line 414.
- **Gap 3, the bare constant is still called the free bound.** The same row opens "The free bound s₁+s₂ ≥ 2/√⌊m/2⌋ is at least 1 exactly when ⌊m/2⌋ ≤ 4". The statement row and the record (findings/isotropy-cap.md:405) both say that inequality is false at m ≤ 7, and the row now places it beside `free_bound_skew`, which proves the min form. [L82.lean:13](../lean/HamiltonsCubic/Results/L82.lean) carries the same false sentence, "Every unit skew matrix satisfies s₁ + s₂ ≥ 2/√⌊m/2⌋". The arithmetic proved in L82.lean (`free_bound_iff`, `cutoff_at_ten`) is about the constant and stands.
- The description of L82Free.lean itself (the three lemmas, 4/4) is accurate.

## 3. a0dddcdd against r1549 (A-3)

- **Gap 1** (reproof uncited): the L112 row ([lean/INDEX.md:451](../lean/INDEX.md)) now credits L112Statement.lean with `Smat_*`, `hatS_doublyStochastic`, `hatS_eigenvector` and `L73_one_index_shadow`, names `shadow_convex` as the new theorem, and the L112Doubly.lean header names the originals. Closed.
- **Gap 2** (L73 link): the row and the statement row now link L73Statement.lean. Closed.
- **Gap 3** (owed list): the row adds T_{abc} = c_{abc}² in W's eigenbasis, from which symmetry, nonnegativity and hollowness follow. Closed.
- **Gap 4** (L54's (4)): the L54 row ([lean/INDEX.md:273](../lean/INDEX.md)) and the L54Diag.lean header separate (2), a majorisation cancellation, from (4), `Multiset.cons_inj_right`. Closed.
- **Gap 5** (L112 statement row): line 452 now says the full majorisation is typed in convex form as `shadow_convex`. Closed.
- **Gap 6** (flexible simp): L54Diag.lean's `simp` is now `simp only` with an explicit lemma list, and a rebuild of L54Diag emits no warning. Closed.
- **The L73 main row** ([lean/INDEX.md:624](../lean/INDEX.md)) now ends "The n−2 bound itself is L73Statement's `two_sided`, from the Killing row mass and Ricci-flatness as hypotheses". `two_sided` ([L73Statement.lean:147](../lean/HamiltonsCubic/Results/L73Statement.lean)) proves −(n−2)λ_max ≤ λ_a ≤ (n−2)(−λ_min) for every index a, and `lamMax_le` and `abs_lamMin_le` derive the record's two forms from it. Its hypothesis is `RowCalculus`, whose fields are `killing` (row mass 2(n−2)), `bianchi` (Ricci-flatness with first Bianchi in row form), `nonneg` and `pairSymm`. Accurate, with one imprecision: the row names two of the four fields.
- **The L116 main row** ([lean/INDEX.md:466](../lean/INDEX.md)): `bianchi_add` is additivity of b and `L116` proves b(R^#) = −b(R²) under the two antisymmetries, pair symmetry and first Bianchi, in [L116Statement.lean](../lean/HamiltonsCubic/Results/L116Statement.lean). "Owed: the n=4 hand witness" was accurate at HEAD. *Observed outside these commits*: another session has staged L116Witness.lean and an INDEX edit that discharge it, so the owed item is about to go.
- One semicolon splice was introduced in the L112 row ("in that file's `IsDoublyStochastic` form; its `L73_shadow` repeats"), see §6.

## 4. Soundness (B)

- `lake build HamiltonsCubic.Results.L82Free HamiltonsCubic.Results.L54Diag HamiltonsCubic.Results.L112Doubly` completes. Warnings: `pairs_le_half` and `shadow_convex` carry an unused `[DecidableEq ι]` in their types (linter `unusedDecidableInType`), harmless. `[LinearOrder ι]` in `free_bound_skew` is needed by `inner2_X_X`.
- `axiom_audit.py --only L82Free.lean`: 4/4 clean. `--only L54Diag.lean`: 3/3 clean. `--only L112Doubly.lean`: 7/7 clean. Standard three only.
- No `sorry`, `admit` or `native_decide` in the three files.

## 5. Downstream (C)

- No text in lean/INDEX.md, plan-lean.md or findings/isotropy-cap.md calls L82's free bound untyped: 4e80b476 removed "the free bound on unit skew matrices" from the owed list.
- The L82 block in findings/isotropy-cap.md (line 405) carries no machine-checked note naming `free_bound_skew`, where neighbouring blocks (lines 76, 126) do. A missing credit.
- Gap 3's false sentence at L82.lean:13 and lean/INDEX.md:413 is the downstream text that still needs the min form.

## 6. Style (D)

- The added lines carry no em dash, no backtick inside link text, and every row stays on one line.
- **Gap 4, two semicolon splices.** [lean/INDEX.md:413](../lean/INDEX.md): "`pairs_le_half` ($2k\le m$); 4/4 on the standard three." [lean/INDEX.md:451](../lean/INDEX.md): "in that file's `IsDoublyStochastic` form; its `L73_shadow` repeats". The semicolons in the L54 row separate list items that carry commas and stand.

## 7. Verdict

**CONFIRMED WITH GAPS.** The Lean is sound, audits clean and is faithful to the min-form bound, and r1549's six gaps are closed. Gaps:

1. [L82Free.lean:7](../lean/HamiltonsCubic/Results/L82Free.lean) and [L82Free.lean:104](../lean/HamiltonsCubic/Results/L82Free.lean): `free_bound_skew` needs k ≥ 2 blocks through `hij : i ≠ j`, the trivial k ≤ 1 case is not proved, and "every unit skew matrix" is not assembled from `skew_normal_form` and a top-two choice. The restriction is stated nowhere.
2. [lean/INDEX.md:413](../lean/INDEX.md): the owed list names T₊ ≤ 2|λ_N| (`Tplus_le_two_abs`, L82Statement.lean:66) and L31's root-system step (`adNorm_eq_sum_two`, L82Statement.lean:400) as owed. Only the contraction bound (`hcontract`) is. The closing "statement: not typed" contradicts line 414.
3. [lean/INDEX.md:413](../lean/INDEX.md) and [L82.lean:13](../lean/HamiltonsCubic/Results/L82.lean): the refuted bare s₁+s₂ ≥ 2/√⌊m/2⌋ is still called "the free bound", false at m ≤ 7.
4. [lean/INDEX.md:413](../lean/INDEX.md) and [lean/INDEX.md:451](../lean/INDEX.md): semicolon clause splices.
5. Minor: [lean/INDEX.md:624](../lean/INDEX.md) names two of `RowCalculus`'s four hypotheses, and [L82Free.lean](../lean/HamiltonsCubic/Results/L82Free.lean) does not cite L82Statement.lean's `sum_two_ge_one`, its ⌊m/2⌋ ≤ 4 special case.
