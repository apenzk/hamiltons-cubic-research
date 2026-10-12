# REVIEW r1623: L127's within top and the operator-side dimension counts

Reviewer r1623, one-reviewer Gate 2 round, analysis only. Read: commit e810c293 ([L127WTop.lean](../lean/HamiltonsCubic/Results/L127WTop.lean), [L127DimOp.lean](../lean/HamiltonsCubic/Results/L127DimOp.lean), the L127 and L26 rows of [lean/INDEX.md](../lean/INDEX.md), the docstring edits in [L26Main.lean](../lean/HamiltonsCubic/Results/L26Main.lean)) against Lemma L127 in [second-order.md](../findings/second-order.md) (line 1717), [L127Within.lean](../lean/HamiltonsCubic/Results/L127Within.lean) (`withinPair`, `within_spectrum`, `within_top_exists`) and [L127Dim.lean](../lean/HamiltonsCubic/Results/L127Dim.lean) (`pairCoeff_inj`, the `_mem` theorems). Both modules rebuilt clean with no warnings, and the axiom audit was run on both. No numerical screen was needed.

| claim | verdict |
|---|---|
| C1 within_top_identity | CONFIRMED |
| C2 within_top_mem, both directions, and its hypotheses | CONFIRMED (p ≥ 3 stronger than needed here, needed for C3) |
| C3 within_top_finrank | CONFIRMED |
| C4 WTop header's "(p − 3) + (q − 1) + 1" | CONFIRMED WITH GAPS (prose, not a declaration) |
| C5 pairOp and finrank_map_pairOp | CONFIRMED |
| C6 the five op_finrank theorems | CONFIRMED |
| C7 "the image is the eigenspace, by the _mem theorems" | CONFIRMED WITH GAPS (prose, not a declaration) |
| C8 pairOp's codomain | CONFIRMED |
| C9 INDEX L127 and L26 rows, L26Main docstrings | CONFIRMED WITH GAPS (L127 row carries C4 and C7 as settled) |
| C10 axiom audit | CONFIRMED (3/3, 6/6 on the standard three) |

## C1. within_top_identity

- By hand, with `2λ = (α + t)(p − 2)`: `2λ + 2t + α + β = α(p − 1) + tp + β = tq + tp + β`, using `α(p − 1) = tq`. The right side is `tq + βq`. They agree iff `tp = β(q − 1)`, which is the definition `β = tp/(q − 1)`. The Lean statement ([L127WTop.lean:31](../lean/HamiltonsCubic/Results/L127WTop.lean#L31)) is this identity with `α`, `β` written out, under `P − 1 ≠ 0`, `Q − 1 ≠ 0`. Correct.

## C2. within_top_mem

- The eigenvalue `½(t·(Q/(P − 1)) + t)(P − 2)` at [L127WTop.lean:53](../lean/HamiltonsCubic/Results/L127WTop.lean#L53) is syntactically the second disjunct of `within_spectrum` ([L127Within.lean:135](../lean/HamiltonsCubic/Results/L127Within.lean#L135)) and the scalar of `within_top_exists` ([L127Within.lean:273](../lean/HamiltonsCubic/Results/L127Within.lean#L273)). `withinTopVec` agrees with `within_top_exists`'s `c` on the pair index set and is zero off it.
- Forward direction: `withinPair` plus `pairSpan_eq_iff` turn the eigen-equation into the per-index equations. For `q ∈ T`: `½(α + t)C_A = λc_q` gives `c_q = C_A/(p − 2)`. For `q ∉ T`: with `C_B = −C_A` from the cut, `(t + β)C_B = (2λ + 2t + α + β)c_q = (t + β)q·c_q` (C1), so `c_q = −C_A/q`. So `c = (C_A/((p − 2)q))·withinTopVec`, with off-`s` entries zero by the first conjunct. I checked each coefficient equation against `withinPair`'s form by hand.
- Reverse direction: `C_A = aq(p − 2)`, `C_B = −a(p − 2)q`, so the cut holds, and the two coefficient equations reduce to `½(α + t)(p − 2) = λ` and C1. Correct.
- Hypotheses. `p ≥ 3` is where the top is simple, and it is needed for C3 rather than here. At `p = 2` the first-factor part is empty and the `Tᶜ` value `−(p − 2)` is `0`, so `withinTopVec = 0`, while `λ = 0`, and by hand the 0-eigenspace on the cut is `{0}` (the `q ∉ T` equation reads `(2t + α + β)c_q = 0` once `C_B = 0`). Both sides of the iff are then `{0}`, so the statement would hold at `p = 2` too, and `hp` is stronger than needed, which is harmless. `t > 0` is needed: at `t = 0` every cut vector is an eigenvector at `λ = 0`. `q ≥ 2` keeps `β` defined. All three are sufficient, since the proof compiles with no further hypothesis.
- Breaking object sought: a cut vector in the λ-eigenspace with the two parts not individually constant. The `q ∈ T` equation forces constancy on `A` (λ ≠ 0 at `p ≥ 3`), and the `q ∉ T` equation forces constancy on `B` (`t + β ≠ 0`). None exists.

## C3. within_top_finrank

- `finrank_span_singleton` needs `withinTopVec ≠ 0`, shown at any `q ∈ Tᶜ`, where the value is `−(p − 2) ≠ 0` at `p ≥ 3`. Correct.

## C4. The header's count

- [L127WTop.lean:19-20](../lean/HamiltonsCubic/Results/L127WTop.lean#L19) says the within block's Ricci cut, of dimension `n − 3`, "is accounted for as `(p − 3) + (q − 1) + 1`". Arithmetic: `p + q − 3 = n − 3`. True.
- **Gap**: no declaration states that the three coefficient spaces are independent, that they span the cut, or that the cut (vectors vanishing off `s` with `∑ c_i = 0`) has dimension `n − 3`. The mathematical closure is short: the eigenvalues `0`, `λ > 0` (at `p ≥ 3`, `t > 0`) and `−½(2t + α + β) < 0` (`within_bounds`) are distinct, so the spaces are independent, and dimensions summing to `n − 3` then force spanning. That argument is not in Lean. "Accounted for" reads as a decomposition, so the wording states more than the file proves. Suggested repair: either prove `ker blockSums1 A ⊔ ker blockSums1 Tᶜ ⊔ span{withinTopVec} = cut` with pairwise disjointness, or reword to "the three dimensions sum to `n − 3`".

## C5. pairOp and finrank_map_pairOp

- `pairOp` ([L127DimOp.lean:28](../lean/HamiltonsCubic/Results/L127DimOp.lean#L28)) is the coefficient map, linearity proofs routine.
- Injectivity of `pairOp ∘ V.subtype` is taken from `pairCoeff_inj` ([L127Dim.lean:124](../lean/HamiltonsCubic/Results/L127Dim.lean#L124)) with `hV` supplying vanishing off `s` and `congrFun h X` supplying equality on every `X` (hence every skew `X`). Then `finrank_range_of_inj`, `range_comp`, `range_subtype` give `finrank (V.map pairOp) = finrank V`. Correct.

## C6. The five op_finrank theorems

- Each discharges `hV` correctly: `mem_ker_blockSums2` with `filter_union_filter_not_eq` (cross kernel), the span form of `crossTopVec` and `withinTopVec` (both zero off `s` by definition), `mem_ker_blockSums1` on `s.filter (· ∈ T) ⊆ s` (within kernel), and on `Tᶜ ⊆ s` via `hj`, `hk` (within negative). The counts `n − 4`, `1`, `p − 3`, `q − 1`, `1` are L127Dim's and WTop's. Correct.

## C7. "The image is the eigenspace"

- [L127DimOp.lean:9-11](../lean/HamiltonsCubic/Results/L127DimOp.lean#L9) says the image of each coefficient space under `pairOp` is the operator eigenspace, "by the `_mem` theorems". The five `op_finrank` theorems carry no `t`, no `ht`, and no eigen-equation. They are finranks of images of coefficient subspaces.
- **Gap**: no declaration identifies `V.map (pairOp j k)` with a set of operators defined by the eigen-equation. The identification is a two-line consequence of `_mem` (an operator in the pair span is `pairOp c` for a unique `c` vanishing off `s`, by `pairCoeff_inj`, and `_mem` characterises `c`), so it is true, but the step r1622 flagged at C3 is now half-closed: the dimension transfer is a declaration, the eigenspace identification is still prose. Suggested repair: a theorem `F ∈ V.map (pairOp j k) ↔ (∃ c vanishing off s with ∑ c = 0, F = pairOp j k c) ∧ ∀ X skew, foxProd … F X = λ • F X`, per block.

## C8. pairOp's codomain

- The codomain is all functions `Matrix ι ι ℝ → Matrix ι ι ℝ`, and the eigen-equations hold on skew `X` only. This does not change the finrank: `pairCoeff_inj` uses only skew inputs, so the restriction of `pairOp c` to skew matrices already determines `c`, and the images in the full function space and in the skew-restricted space are isomorphic via `c`. An intrinsic eigenspace inside the full function space, asking the eigen-equation at every `X`, could be smaller, and the file's prose ("the eigenspace") should be read as the skew-restricted one. No defect.

## C9. Index rows and L26Main

- L26 row now says "Weyl, nonzero, and `L_ev = μv`", matching `L26_main`'s conjunct `v ≠ 0` ([L26Main.lean:46](../lean/HamiltonsCubic/Results/L26Main.lean#L46)). Docstring typo "an nonzero" fixed to "a nonzero" and the split bullet rejoined. Correct, r1622's C1 and C2 gaps closed.
- L127 row ([lean/INDEX.md:495](../lean/INDEX.md#L495)): the L127Dim sentence now says "coefficient space", which closes r1622's C8. **Gap**: the new WTop sentence says the within cut "is `(p − 3) + (q − 1) + 1`" (stronger than the file's "accounted for as", C4), and the DimOp sentence says the images "are the eigenspaces by the `_mem` theorems" (C7). Both are true but prose.
- Leftover: [L127Dim.lean:13](../lean/HamiltonsCubic/Results/L127Dim.lean#L13) and [L127Dim.lean:123](../lean/HamiltonsCubic/Results/L127Dim.lean#L123) still say each count "is the dimension of the eigenspace itself". DimOp now carries the finrank transfer, so a pointer to DimOp there would make the claim traceable.

## C10. Axiom audit

- `axiom_audit.py --only L127WTop.lean`: 3/3 on the standard three. `--only L127DimOp.lean`: 6/6 on the standard three. `lake env lean` on both files: no warnings, no `sorry`, no `native_decide`.

## Verdict

**CONFIRMED WITH GAPS.** Every theorem is correct and its hypotheses are necessary and sufficient. The two gaps are prose outrunning declarations: the within cut's three-way decomposition (C4) and the image-equals-eigenspace identification (C7), both true by short arguments that are not in Lean.
