# REVIEW r1624: commit 13fcf12d, L120's pair summand and r1623's repairs

**Verdict: CONFIRMED WITH GAPS.** The identification of L120's pair summand is proved as stated, both directions, on the standard three axioms. The gaps are one unstated converse at the full sign group, one missing file link in the INDEX row, and one punctuation defect in a header.

Reviewer: cold adversarial Gate 2, analysis-only footing. Runs made: `lake build` of the two target modules (exit 0) and the axiom audit on each, both screens on objects in hand.

## Claim table

| Claim | Where | Verdict |
|---|---|---|
| `iso_parity`: a nonzero coordinate of a flip-isotypic operator obeys the flip parity of `(j, k)` | [L120Pair.lean:36](../lean/HamiltonsCubic/Results/L120Pair.lean#L36) | CONFIRMED |
| `iso_core`: at `a = j`, `b ∉ {j, k}` and `(c, d) ∈ {(k, b), (b, k)}` | [L120Pair.lean:56](../lean/HamiltonsCubic/Results/L120Pair.lean#L56) | CONFIRMED |
| `iso_coord_form`: every nonzero coordinate sits at a `PairForm` position | [L120Pair.lean:109](../lean/HamiltonsCubic/Results/L120Pair.lean#L109) | CONFIRMED |
| `pairForm_parity`, `pairForm_coord_zero`, `phi_ip_ne` | [L120Pair.lean:134-163](../lean/HamiltonsCubic/Results/L120Pair.lean#L134) | CONFIRMED |
| `pairLin`, `pairS_mem`, `coord_pairS`, `coord_pairS_diag` | [L120Pair.lean:168-210](../lean/HamiltonsCubic/Results/L120Pair.lean#L168) | CONFIRMED |
| `pairS_iso`: the pair-span operator on the cut is isotypic | [L120Pair.lean:213](../lean/HamiltonsCubic/Results/L120Pair.lean#L213) | CONFIRMED WITH GAPS (flips only, gap 1) |
| `pair_isotypic`: an isotypic member of `weylModuleS` is the pair-span operator with `c_y = R_{jyky}`, `∑ c_y = 0` | [L120Pair.lean:237](../lean/HamiltonsCubic/Results/L120Pair.lean#L237) | CONFIRMED |
| `pair_isotypic_signMat`: the same from full-sign-group isotypy | [L120Pair.lean:272](../lean/HamiltonsCubic/Results/L120Pair.lean#L272) | CONFIRMED |
| `mem_map_pairOp_iff` and the five `*_op_mem` theorems | [L127DimOp.lean:91-162](../lean/HamiltonsCubic/Results/L127DimOp.lean#L91) | CONFIRMED |
| L127WTop.lean and L127Dim.lean header wording | [L127WTop.lean:19](../lean/HamiltonsCubic/Results/L127WTop.lean#L19), [L127Dim.lean:12](../lean/HamiltonsCubic/Results/L127Dim.lean#L12) | CONFIRMED WITH GAPS (gap 3, style only) |
| INDEX L120 row | [INDEX.md:475](../lean/INDEX.md#L475) | CONFIRMED WITH GAPS (gaps 1 and 2) |
| INDEX L127 row | [INDEX.md:495](../lean/INDEX.md#L495) | CONFIRMED |
| Axiom audit, L120Pair.lean | 14/14 on the standard three | CONFIRMED |
| Axiom audit, L127DimOp.lean | 12/12 on the standard three | CONFIRMED |

## Checks, and the object that would break each claim

- **The parity chase.** The breaking object is a nonzero coordinate at an index pattern the case split misses. `iso_core` fixes `a = j`, kills `b = j` and `c = d` by antisymmetry, reads `c, d ≠ j` off the flip at `j`, splits `b = k` (refuted by the flip at `c`, which then sees `c` once) against `b ≠ k`, and in the second branch the flip at `k` forces exactly one of `c, d` to be `k`, after which the flip at the other forces it to equal `b`. I rederived each flip sign by hand and each branch closes on a sign contradiction of the form `-1 = 1`. `iso_coord_form` covers the four positions `j` can take after the flip at `j` shows `j` occurs, so every index pattern is covered. The kernel accepting the file confirms the case split is exhaustive.
- **Weyl hypothesis in `iso_coord_form`.** `hR` enters only through `cd_pair` in the two branches where `j` occupies slot `c` or `d` ([L120Pair.lean:126](../lean/HamiltonsCubic/Results/L120Pair.lean#L126), [L120Pair.lean:129](../lean/HamiltonsCubic/Results/L120Pair.lean#L129)). The branches with `j` in slot `a` or `b` use `cd_sw12`, which is antisymmetry of `phi` and holds for any `CurvLin`. Pair symmetry alone would suffice, and the whole Weyl membership is harmless because `pair_isotypic` assumes it anyway.
- **The character is the right one.** The breaking object is a sign convention in `act` that makes the hypothesis vacuous or the character mismatched. `coord_flip` derives the factor `sgn m a · sgn m b · sgn m c · sgn m d` from `act g R Z = g R(gᵀ Z g) gᵀ`, and `pairS_iso` exhibits the nonzero pair-span operators satisfying the hypothesis when `n ≥ 4`, so the hypothesis is satisfiable and not vacuous.
- **`flip m = signMat (sgn m)`.** Both unfold to `Matrix.diagonal (fun i => if i = m then -1 else 1)`, so the use at [L120Pair.lean:276](../lean/HamiltonsCubic/Results/L120Pair.lean#L276) is by definitional unfolding, with the character `sgn m j · sgn m k` matching `ε j · ε k`. The build accepts it. The hypothesis `ε i · ε i = 1` is exactly `ε_i = ±1`, which is L120's full group `Γ`.
- **The pair-span coordinates.** `rk2 U V X = ⟨V,X⟩U + ⟨U,X⟩V` is the symmetric product `φ_{jy} ⊙ φ_{ky}`, and `coord_pairS_diag` returning `c_y` confirms the normalisation. `cd_ric` at `(j, k)` sums `coord R j c k c` over all `c`, and the two excluded terms vanish by `cd_self12` and `cd_self34`, so `∑_{y ∉ {j,k}} c_y = 0` is the Ricci relation of the record.
- **Faithfulness of "V_jk is the pair span on its Ricci cut".** `pair_isotypic` gives ⊆ and `pairS_mem` with `pairS_iso` give ⊇ at the flip level, so the flip-isotypic subspace of `weylModuleS` equals the image of the cut under `c ↦ pairLin j k c ∘ skewProj`. Flip isotypy and full-group isotypy define the same subspace since the flips generate `Γ`, and at the full group none of the `n = 4, 6, 8` fusion occurs. `coord_pairS_diag` makes the parametrisation injective, so the stated dimension is one short step away and the row records it as owed.
- **`weylModuleS` as `𝒲_n`.** It is `weylModule ⊓ KillsSym`, the record's `𝒲_n` per its docstring in WeylTraceStrict.lean. The composition with `skewProj` is what the `KillsSym` normalisation requires, so the conclusion `R = pairLin … ∘ₗ skewProj` is the correct canonical form.
- **L127DimOp's `*_op_mem`.** Each is `mem_map_pairOp_iff` applied to the corresponding `*_mem` characterisation in L127Dim and L127WTop, with `pairOp j k c` defined as the same `∑_{i ∈ s} c_i rk2 …` that appears in the eigen-equation, so the stated set is literally the image. The breaking object would be a mismatch between `pairOp` and the summation in the eigen-equation, and I compared the two definitions ([L127DimOp.lean:29](../lean/HamiltonsCubic/Results/L127DimOp.lean#L29)). No overclaim: the INDEX L127 row says "the operators `∑ c_i f_i` with `c` on the Ricci cut satisfying the block's eigen-equation", which is what is stated, and it keeps the spanning of the cut as prose.

## Gaps

1. **The converse is proved for flips, and the full-group converse is not stated.** `pairS_iso` ([L120Pair.lean:213](../lean/HamiltonsCubic/Results/L120Pair.lean#L213)) gives flip isotypy only. The INDEX L120 row pairs "`pair_isotypic_signMat` takes L120's own hypothesis" with "`pairS_mem` and `pairS_iso` give the converse", which a reader takes as a two-sided statement at `Γ`. It follows from `act_comp` ([WeylTraceZero.lean:21](../lean/HamiltonsCubic/Results/WeylTraceZero.lean#L21)) and `signMat ε` being a product of flips, but no declaration carries it. Repair: a `pairS_iso_signMat`, or a row sentence saying the converse is at the flip level. Relatedly, no bundled statement (an `iff` or a `Submodule` equality) states the two directions together.
2. **The INDEX L120 row's file column omits [L120Pair.lean](../lean/HamiltonsCubic/Results/L120Pair.lean)** ([INDEX.md:475](../lean/INDEX.md#L475)), and also [L120Block.lean](../lean/HamiltonsCubic/Results/L120Block.lean), while its prose cites both.
3. **Semicolon splice** in the new header text at [L127WTop.lean:20](../lean/HamiltonsCubic/Results/L127WTop.lean#L20), "the dimension of the Ricci cut; that the three spaces together span the cut is argued in prose". The mathematics is right, the punctuation breaks the house writing rule.

Minor, not gaps: unused-section-variable linter warnings at [L120Pair.lean:50](../lean/HamiltonsCubic/Results/L120Pair.lean#L50), [L120Pair.lean:52](../lean/HamiltonsCubic/Results/L120Pair.lean#L52), [L120Pair.lean:133](../lean/HamiltonsCubic/Results/L120Pair.lean#L133) and an unused binder at [L120Pair.lean:183](../lean/HamiltonsCubic/Results/L120Pair.lean#L183).

## Summary

The pair summand of L120 is identified as the pair span on its Ricci cut, both directions at the flip level and the forward direction at the full sign group, 14/14 and 12/12 on the standard three. The r1623 repairs state no more than they prove.
