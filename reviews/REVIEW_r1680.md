# REVIEW r1680: L52's one-line bound (589bafac) and the repair of r1679's gaps (2a6d824f)

**Verdict: CONFIRMED WITH GAPS.** `one_line_bound` at [L52Remarks.lean:86-99](../lean/HamiltonsCubic/Results/L52Remarks.lean#L86) is correct and carries the record's hypotheses, and both files audit clean (L52Remarks 7/7, L52 11/11). r1679 G2, G3 and G5 are repaired. G1 is repaired in the docstring and left out of the owed list. G4 is repaired in the row's first three sentences, and one stale quotation survives, now contradicting the owed list. The declared one-line bound is the bi-spectral form, and its passage to `θ` at the record's objects is neither declared nor owed. **partial** is right.

## Claims

| # | Claim | Verdict |
|---|---|---|
| 1 | `one_line_bound`: `(3/2)Σμ³ − (1/2)Σω³ ≤ (3/2)(M₊ + m)` for `μ ≤ M₊`, `Σμ² = 1`, `ω ≥ −m`, `Σω² = 3` | **CONFIRMED** |
| 2 | It is the record's one-line bound `θ ≤ (3/2)(M₊ + m)` ([bispectral.md:86](../findings/bispectral.md#L86)) | **CONFIRMED WITH GAPS** (G3): true on the bi-spectral form, the composition with L50 at the record's objects undeclared and no longer owed |
| 3 | r1679 G1 repaired | **CONFIRMED WITH GAPS** (G1): the docstring says `U` is not declared, and the row's owed list does not carry it |
| 4 | r1679 G2, G3 repaired | **CONFIRMED** (G2 owed by name, G3 declared as claim 1) |
| 5 | r1679 G4 repaired, the row's opening faithful and free of stale quotations | **CONFIRMED WITH GAPS** (G2) |
| 6 | r1679 G5 repaired | **CONFIRMED** |
| 7 | The L52 row consistent, the owed list complete, **partial** right | **CONFIRMED WITH GAPS** (G1, G2, G3) on the list, **CONFIRMED** on the state |
| 8 | Axiom audit | **CONFIRMED**: L52Remarks 7/7, L52 11/11 on the standard three |

## 1. `one_line_bound`

- **By hand.** `μ ≤ M₊` and `μ² ≥ 0` give `μ³ = μ²·μ ≤ M₊μ²`. `ω ≥ −m` and `ω² ≥ 0` give `−ω³ = ω²·(−ω) ≤ mω²`. Summing, `Σμ³ ≤ M₊Σμ² = M₊` and `−Σω³ ≤ mΣω² = 3m`, so `(3/2)Σμ³ − (1/2)Σω³ ≤ (3/2)M₊ + (3/2)m`. The Lean proof is these steps, each termwise inequality closed by `nlinarith` from `sq_nonneg` and the bound.
- **Hypotheses.** The record's normalisation is `‖M‖_F = 1`, where `Σμ² = 1` and `Σω² = 3` ([bispectral.md:17](../findings/bispectral.md#L17), and the normalisation trap at [:65](../findings/bispectral.md#L65)). `M₊` and `m` are constants with `μᵢ ≤ M₊` and `ωᵢ ≥ −m` ([:71](../findings/bispectral.md#L71)). These are exactly `hμ`, `hω`, `hμ2`, `hω2`, the hypotheses of [L52Bound.lean](../lean/HamiltonsCubic/Results/L52Bound.lean)'s `L52_matrix_bound`. `Σμ = Σω = 0` is not needed and not assumed, which makes the statement stronger. No sign on `m` or `M₊` is assumed, and none is needed.
- **The index types** `P` and `Q` are independent, as `μ` lives on `Λ²` and `ω` on `S²₀`. An extra `0` in `ω` (the `S²` reading of L52Frame) changes neither `Σω²` nor `Σω³`, so the lemma applies on either space.
- **The bi-spectral form** is L50's `θ = (3/2)p₃(μ) − (1/2)p₃(ω)` ([bispectral.md:17](../findings/bispectral.md#L17)).
- **G3.** The record's sentence is about `θ`. The declared statement is about two abstract spectra. The passage is `L50_bispectral` ([L50Spectra.lean:141](../lean/HamiltonsCubic/Results/L50Spectra.lean#L141)) with `sum_mu_cube`, `sum_mu_sq` ([SpectralTrace.lean:129](../lean/HamiltonsCubic/Results/SpectralTrace.lean#L129), [:156](../lean/HamiltonsCubic/Results/SpectralTrace.lean#L156)) and `sum_omega_cube`, `sum_omega_sq` ([SecondKindMatrix.lean:262](../lean/HamiltonsCubic/Results/SecondKindMatrix.lean#L262), [:271](../lean/HamiltonsCubic/Results/SecondKindMatrix.lean#L271)), which [L52Frame.lean:232-240](../lean/HamiltonsCubic/Results/L52Frame.lean#L232) already composes for `L52_record`. The composition is a few lines, and all its parts are declared. 589bafac deleted the owed entry "the one-line bound `θ ≤ (3/2)(M₊+m)` itself" and the row now says "on the bi-spectral form", which is honest, but the `θ` form is on neither list. `one_line_half` ([L52Remarks.lean:84](../lean/HamiltonsCubic/Results/L52Remarks.lean#L84)) still takes `θ ≤ (3/2)C` as a hypothesis and is not composed with `one_line_bound`.

## 2. r1679's gaps

- **G1 (`U` undeclared).** The docstring at [L52Remarks.lean:28-29](../lean/HamiltonsCubic/Results/L52Remarks.lean#L28) now reads "`P_ij = U_ij²` with `U` that rotation (not declared)". The commit message calls this the repair. r1679's fix was "declare `U` ... or owe it", and the row's owed list at [lean/INDEX.md:384](../lean/INDEX.md#L384) does not name `U`. The row's description of `rot4_*` still says "the `π/4` rotation's doubly stochastic `P`", so a reader of the row alone is not told `U` is absent. Residual gap, minor.
- **G2 (change of variables).** Owed by name: "the change of variables `u = √(t_F/2)` on `t_F ∈ [0, 2]` behind `display_needs_small_C`". Repaired.
- **G3 (one-line bound).** Declared as `one_line_bound`, see section 1.
- **G4 (stale opening).** The row now opens "the arithmetic of the audit's counts, from an earlier form of the block", matching L52.lean's header ([L52.lean:10-14](../lean/HamiltonsCubic/Results/L52.lean#L10)). The heading denial, *"Strictly loose at every unit Weyl tensor"*, "informally" and *"its negative is not independent"* are gone. The `strictly_loose` sentence is now accurate (the arithmetic tail, the step to `μᵢ ∈ {0, M₊}` owed). The penalty sentence is accurate: `(9/2)²(8/3)/4 = 27/2`, and `3.674235` sits at [bispectral.md:53](../findings/bispectral.md#L53), outside the block, covered by "earlier form". **One quotation survives**: "**And the neighbourhood claim is grounded** ... so *"off the diagonal family"* reaches a set with interior". The phrase "off the diagonal family" is not in bispectral.md (grepped: no hit). The block's nearest phrase is "away from the family it can be weak" ([:86](../findings/bispectral.md#L86)). And "the neighbourhood claim" is, in the current block, "beats the strict one-line bound on a neighbourhood of the diagonal family", which the same row owes ("the strictness at `Mpair` and the continuity step"). So the row calls one claim both grounded and owed. What `diagonal_locus_proper` grounds is that the complement of the diagonal family has interior, which supports the "away from the family" clause. The same stale quotation sits in the docstring at [L52.lean:103-104](../lean/HamiltonsCubic/Results/L52.lean#L103).
- **G5 (`threshold_nonempty`).** The docstring at [L52.lean:98-101](../lean/HamiltonsCubic/Results/L52.lean#L98) now says the `4/3` threshold concerns the penalty term alone and that the neighbourhood sentence concerns the first display and is owed. Checked: `(9/2)C(1 − t/2) > (3/2)C` iff `t < 4/3` for `C > 0`. Repaired.

## 3. The row as a whole

- **Counts.** L52.lean 11/11, L52Remarks 7/7, matching the audit and the 11 and 7 top-level theorems. The other files' counts were not touched by these commits.
- **The owed list** after 589bafac: the change of variables, the padded `W_CP²` figures, the second display, the Verification paragraph, the `whst` composition, the staircase at every `n`, the neighbourhood sentence, r1677 G7. Each checked against [bispectral.md:69-102](../findings/bispectral.md#L69) and each accurate.
- **Record sentences neither declared nor owed:**
  1. The `π/4` rotation `U` itself and `|U|² = rot4` ([:84](../findings/bispectral.md#L84)), G1.
  2. The one-line bound in its `θ` form at the record's objects ([:86](../findings/bispectral.md#L86)), G3.
  3. "Its penalty half is one line of exact algebra, `(9/2)M₊(1−s) + (9/2)m(1−s) = (9/2)C(1−s)`" ([:92](../findings/bispectral.md#L92)). Distributivity, trivially true. Worth one clause in the owed list or one `ring` lemma, nothing more.
  4. "So the display is informative only at `t_F = 2`" is the consequence of `display_needs_small_C` and `one_line_half`, declared modulo items 2 and G2. The Post F26 cross-reference is a pointer, not a claim.
- **partial** is right: the owed list is non-empty and holds claims the block asserts.
- **Minor.** L52Remarks's module header at [:8](../lean/HamiltonsCubic/Results/L52Remarks.lean#L8) still says "Two remarks the block makes", and the file now also carries the one-line bound, a third item.

## 4. Axiom audit

`python3 scripts/misc/axiom_audit.py --only L52Remarks.lean`: 7/7 clean on the standard three. `--only L52.lean`: 11/11 clean. A screen of seconds, run after checking no lake process was live.

## Gaps

- **G1 (minor), [lean/INDEX.md:384](../lean/INDEX.md#L384), [L52Remarks.lean:28-29](../lean/HamiltonsCubic/Results/L52Remarks.lean#L28).** `U` is said to be undeclared in the docstring only. Fix: add "the rotation `U` with `|U|² = rot4`" to the owed list, or declare it with `Real.cos (π/4)`, `Real.sin (π/4)`.
- **G2, [lean/INDEX.md:384](../lean/INDEX.md#L384), [L52.lean:103-104](../lean/HamiltonsCubic/Results/L52.lean#L103).** "the neighbourhood claim is grounded ... *"off the diagonal family"*" quotes a phrase absent from the block and calls grounded the claim the same row owes. Fix: say `diagonal_locus_proper` shows the complement of the diagonal family has interior, the block's "away from the family", and drop "the neighbourhood claim is grounded".
- **G3 (minor), [L52Remarks.lean:86-99](../lean/HamiltonsCubic/Results/L52Remarks.lean#L86), [lean/INDEX.md:384](../lean/INDEX.md#L384).** The one-line bound is declared on abstract spectra, and its `θ` form at the record's objects, `L50_bispectral` with the four spectral-trace lemmas, is neither declared nor owed since 589bafac removed the entry. Fix: compose, as L52Frame does for `L52_record`, and feed it into `one_line_half`, or owe it.
- **G4 (minor), [bispectral.md:92](../findings/bispectral.md#L92), [lean/INDEX.md:384](../lean/INDEX.md#L384).** The penalty-half identity is neither declared nor owed. Fix: one `ring` lemma or one owed clause.
- **G5 (cosmetic), [L52Remarks.lean:8](../lean/HamiltonsCubic/Results/L52Remarks.lean#L8).** "Two remarks" no longer counts the file's contents.

## What would break each claim, and what was done

| Claim | Breaking object | What was done |
|---|---|---|
| 1 | A real `μⱼ ≤ M₊` with `μⱼ³ > M₊μⱼ²`, or `ωⱼ ≥ −m` with `−ωⱼ³ > mωⱼ²` | Factored both termwise gaps as `μ²(M₊ − μ) ≥ 0` and `ω²(ω + m) ≥ 0` by hand |
| 2 | A declaration of `P ≤ (3/2)(M₊ + m)` at the record's objects | Grepped `lean/HamiltonsCubic` for `one_line`, `L50_bispectral`, `sum_omega_cube` uses: only L52Frame composes them, for the display |
| 3 | An owed entry naming `U` | Read the row's owed list in full |
| 5 | A quoted phrase absent from the block | Grepped bispectral.md for "off the diagonal family", "strictly loose", "negative is not independent", "informally", "3.674": only `3.674` hits, at :53 outside the block |
| 6 | `t` with `(9/2)C(1 − t/2) ≤ (3/2)C` and `t < 4/3`, `C > 0` | Solved the inequality by hand |
| 7 | A block sentence neither declared nor owed | Read bispectral.md:69-102 sentence by sentence against the row |
| 8 | A non-standard axiom | Ran the axiom audit on both files |
