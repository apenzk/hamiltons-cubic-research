# REVIEW r1681: the repair of r1680's gaps (262a5f7b), and the scope of the L237 row

**Verdict: CONFIRMED WITH GAPS.** Part A: r1680 G1, G3 and G4 are repaired, G2 is repaired in the row and left standing in the L52.lean docstring r1680 named beside it, and G5 is repaired in the file header while the row still says "two remarks". The L52 row is complete: every sentence of [bispectral.md:69-102](../findings/bispectral.md#L69) is declared or owed. Part B: the L237 row's **partial** is right, but the row names no owed item and states one undeclared item as done. The upper bounds are all declared (`kappa_cap_norm`, and `L31_cap_unit` for `κ₁ ≤ 2`, uncited by the row). Every attainment, the class-variable corollary, the witness violation at L173's objects, the rows at the ray and the exactness of the ray ceiling are undeclared. The record's statement line also carries no `n`, and its `κ₄ = 6` is false at `n = 4, 5` by the block's own `3 + √5`.

## Part A: 262a5f7b

| # | Claim | Verdict |
|---|---|---|
| A1 | r1680 G1: the rotation `U` owed | **CONFIRMED**: first owed item at [lean/INDEX.md:384](../lean/INDEX.md#L384), matching "(not declared)" at [L52Remarks.lean:29-30](../lean/HamiltonsCubic/Results/L52Remarks.lean#L29) |
| A2 | r1680 G2: the stale quotation removed | **CONFIRMED WITH GAPS** (GA1): repaired in the row, left in [L52.lean:103-106](../lean/HamiltonsCubic/Results/L52.lean#L103) |
| A3 | r1680 G3: the `θ` form owed | **CONFIRMED**: second owed item, naming `L50_bispectral`, the trace lemmas and L52Frame's pattern |
| A4 | r1680 G4: `penalty_half` | **CONFIRMED**: `ring` closes it, the statement is the record's display at [bispectral.md:92](../findings/bispectral.md#L92) with `C = M₊ + m` written out |
| A5 | r1680 G5: header count | **CONFIRMED WITH GAPS** (GA2): the header at [L52Remarks.lean:8](../lean/HamiltonsCubic/Results/L52Remarks.lean#L8) is fixed, the row's "**And the block's two remarks**" now introduces eight declarations |
| A6 | The L52 row complete | **CONFIRMED** |
| A7 | Axiom audit | **CONFIRMED**: L52Remarks 8/8 on the standard three |

- **A2.** `diagonal_locus_proper`'s docstring still reads "which is why "off the diagonal family" reaches a neighbourhood". The phrase is absent from bispectral.md (grepped: no hit), and "reaches a neighbourhood" is the neighbourhood claim the row owes. r1680's G2 named this docstring beside the row, and the commit touched only the row.
- **A6, sentence by sentence against the row.** The conventions and "Why it was needed" are context. The Statement's diagonal identities, Schur's theorem, the two convexities and the display are declared (`Bw_diag_pair`, SchurMajor, `convexOn_g`, `concaveOn_h`, `L52_record_S20`). "Needs no Karamata" is declared (DoublyStochastic, SchurMajor). The "if" failure is `staircase_strict` and `staircase_strict_helmert`. The "only if" counting, the non-permutation `U` and the shared frame are declared, with `U` itself owed. "An identity on the entire diagonal family" is `L52_if_psi`. The neighbourhood sentence and the padded figures are owed. The second display is owed, its penalty half is `penalty_half`, and "read at one point" is `penalty_sum_bracket`. The reduction paragraph is `ratio_le`, `display_needs_small_C` and `one_line_half`, with the change of variables and the `θ` form owed. The Verification paragraph is owed. Post F26 and the closing editorial line are pointers. "Majorization alone bounds nothing, `t³` being neither convex nor concave" is the one sentence on neither list, and it is a true one-line justification (at `t³`, `(1, −1)` against `(0, 0)` breaks convexity in both directions), not a claim the block concludes. Complete.

## Part B: the L237 row against [second-order.md:228-240](../findings/second-order.md#L228)

| # | Record claim | Declaration | Verdict |
|---|---|---|---|
| B1 | `Σⱼ‖[X₀,Xⱼ]‖² ≤ κ_r`, `κ_r` the largest top-`r` sum over unit `X` | `bracket_cap` ([L237Cap.lean:95](../lean/HamiltonsCubic/Results/L237Cap.lean#L95)) in dual form at `X₀`'s own slots, `rowSum_le_of_slotSets` (:81) for any bound on `r`-sets. No `κ_r` is defined anywhere in `lean/HamiltonsCubic` (grepped `kappa`, `κ`, `topSum`) | **CONFIRMED WITH GAPS** (GB3) |
| B2 | `κ₁ = 2` | Upper: `L31_cap_unit` ([L31Statement.lean:452](../lean/HamiltonsCubic/Results/L31Statement.lean#L452)), since `kappa_cap_norm` gives only `3` at `r = 1`. Attainment: none | **CONFIRMED WITH GAPS** (GB1, GB2) |
| B3 | `κ₂ = 4` | Upper: `kappa_cap_norm` at `r = 2`. Attainment: none | **CONFIRMED WITH GAPS** (GB1) |
| B4 | `κ₄ = 6` | Upper: `kappa_cap_norm` at `r = 4`. Attainment: none. False at `n = 4` (`κ₄ = 4`) and `n = 5` (`3 + √5`) | **CONFIRMED WITH GAPS** (GB1, GB6) |
| B5 | `κ₆ = 8` | Upper: `kappa_cap_norm` at `r = 6`, and `slot_set_bound`. Attainment: none. True from `n = 6` (doubled triangle) | **CONFIRMED WITH GAPS** (GB1, GB6) |
| B6 | Corollary `Σ_b r_b P_ab ≤ κ_{Σ r_b}` in class variables | None. [L237RayCertificate.lean:22-23](../lean/HamiltonsCubic/Results/L237RayCertificate.lean#L22) says the cap's derivation from the lemma is not typed, and the row says it is done | **CONFIRMED WITH GAPS** (GB4) |
| B7 | L173's witness violates it | `l173_row_exceeds` ([KyFanBracketCap.lean:123](../lean/HamiltonsCubic/Results/KyFanBracketCap.lean#L123)) is `8 < 6·2` alone. `cap_tight_11`, `cap_tight_12` ([L173Statement.lean:190](../lean/HamiltonsCubic/Results/L173Statement.lean#L190), :194) give `P₀₀ = P₀₂ = 2` at the witness, and nothing composes them | **CONFIRMED WITH GAPS** (GB5) |
| B8 | Ray ceiling `θ ≤ 83√21/294`, exact, independent of `n` | `l237_ray_certificate` (:28) with `K ≥ 0` free, so independence of `n` is declared, and `l237_ray_ceiling` gives `83/21` in units of `a`. The rows at the ray, the closed form `(83/21)√(3/28) = 83√21/294` and exactness (the primal vertex) are undeclared | **CONFIRMED WITH GAPS** (GB4, GB7) |
| B9 | Uniform `κ_r ≤ r + 2` | `kappa_cap_norm` ([L237SlotCounts.lean:212](../lean/HamiltonsCubic/Results/L237SlotCounts.lean#L212)), through `slot_set_bound`, `counts_bound`, `graph_load`, `skew_normal_form`, `kyFan_conj` | **CONFIRMED** |
| B10 | `κ_{2k} = 2k + 2` for `n ≥ 2k + 2`, doubled `k`-star, and the doubled triangle at `r = 6` | Upper: `kappa_cap_norm`. Attainment: none | **CONFIRMED WITH GAPS** (GB1) |
| B11 | Strict at odd `r`, and `3 + √5` at `n = 5`, `r = 4` | None | **CONFIRMED WITH GAPS** (GB8) |
| B12 | Proof ingredients: Ky Fan, root slots of multiplicity 2, three-slot bound `≤ 4` | `kyFan_sum_le`, `kyFan_eigen`, RootSlots, `slot_eigen`, `slot_orthonormal`, `slot_complete`, the nineteen `slot3_*` (counted: 19) | **CONFIRMED** |
| B13 | "What it does": a cap below `≈ 7.724` would close the ray at `√(3/2)` | `l237_ray_certificate` at general `κ` gives the implication, and the threshold `(21√14 + 45)/16` is undeclared | **CONFIRMED WITH GAPS** (GB7) |

### Hand checks behind the table

- **B1 and B2.** At `r = 1` the uniform bound is `3`, so `κ₁ = 2` needs the single-slot bound `(s_a + s_b)² ≤ 2(s_a² + s_b²)`, which `L31_cap_unit` gives in bracket form at unit `X`, `Y`.
- **B4 and B5, the record's scope.** At `n = 4`, `X = sφ₀₁ + tφ₂₃` has spectrum `(s+t)²`, `(s−t)²` each twice and `0` twice, so the top four sum to `4(s² + t²) = 4 < 6`. At `n = 5` the top four are `2(s₁+s₂)² + 2s₁²`, whose maximum on the unit circle is `3 + 2 sin 2φ + cos 2φ ≤ 3 + √5 < 6`, the block's own figure. The statement line "`κ₁, κ₂, κ₄, κ₆ = 2, 4, 6, 8`" carries no `n`. The uniform paragraph's `n ≥ 2k + 2` supplies it, and at `r = 6` the doubled triangle `φ₀₁ + φ₂₃ + φ₄₅` gives `6·(4/3) = 8` already at `n = 6`. The record's consumers sit at `n ≥ 8` on L173's ray, so this is a scope clause, not a wrong constant.
- **B6, the cap's expansion.** At row `0` of the negative class with multiplicities `(4, K, 3)`: `P₀₀ = 2t₀₀₀ + K t₀₀K + 3t₀₀₂`, `P₀₂ = 3t₀₀₂ + K t₀K₂ + 2t₀₂₂`, so `3P₀₀ + 3P₀₂ = 6t₀₀₀ + 3Kt₀₀K + 18t₀₀₂ + 3Kt₀K₂ + 6t₀₂₂`, the hypothesis `hcap`. The rows (B₀), (C₀) re-derived from L104's (B), (C) at `ν = a(−1, 0, 4/3)`, `μ = (3, K, 3)`: they match `hB`, `hC` term by term.
- **B8, the certificate.** The dual multipliers `β = −4/7` on (B₀) and `γ = 16/21` on the cap make every `t`-coefficient nonpositive (the `t₀₀₂` and `t₀K₂` ones zero, the `K` terms scaled by `K ≥ 0`), and give `u ≤ −1 + 2β + γκ = −15/7 + 16κ/21`. **Screen, not evidence**: in row `0` alone, `t₀₀₂ = 26/63`, `t₀K₂ = 4/(21K)`, the rest zero, meets (B₀) and the cap with equality and returns `u = 83/21`, matching the note's vertex `t₀₀₂ = 26/63`. Feasibility of the other rows, pair caps and Ky Fan caps at that vertex (the note's `t₂₂₂ = 4/7`) is what "exact" needs and is not declared.
- **B8, the closed form.** `a = √(3/28) = √21/14` (`L173Statement`'s normalisation at :230), so `(83/21)a = 83√21/294 ≈ 1.29372`.
- **B13.** `√(3/2)/a = √14`, and `−15/7 + 16κ/21 = √14` at `κ = (21√14 + 45)/16 ≈ 7.7236`.

## The L237 row's owed list, as it should read

1. `κ_r` as the supremum over unit `X` of the top-`r` sum of `−ad_X²`'s spectrum. The declared forms are the dual form at each `X` (`bracket_cap`) and the bound `r + 2` (`kappa_cap_norm`), and the row should say the statement is typed through these.
2. The attainment half of each equality: `κ₁ ≥ 2` and `κ₂ ≥ 4` at `n ≥ 4`; `κ₄ ≥ 6` at `n ≥ 6` (doubled 2-star); `κ₆ ≥ 8` at `n ≥ 6` (doubled triangle); `κ_{2k} ≥ 2k + 2` at `n ≥ 2k + 2` (doubled `k`-star).
3. The corollary `Σ_b r_b P_ab ≤ κ_{Σ r_b}` in class variables, derived from the lemma, and in particular the cap `3P₀₀ + 3P₀₂ ≤ κ₆` that `l237_ray_certificate` takes as `hcap`.
4. The rows (B₀), (C₀) at L173's ray derived from L104's reduced system.
5. The violation at L173's witness: `3·capLhs 0 0 + 3·capLhs 0 1 = 12 > 8`, composing `cap_tight_11`, `cap_tight_12` and `l173_row_exceeds`.
6. The ray ceiling in closed form, `(83/21)√(3/28) = 83√21/294`, and its exactness: the primal vertex attaining `83/21` feasible for the whole system.
7. The strictness at odd `r` and the `n < r + 2` values (`3 + √5` at `n = 5`, `r = 4`).
8. The closing threshold `(21√14 + 45)/16 ≈ 7.724` of "What it does".

And the row should cite `L31_cap_unit` for `κ₁ ≤ 2`.

## Attainment witnesses: size with existing objects

The shortest route is a `NormalForm` ([L240SlotBasis.lean:63](../lean/HamiltonsCubic/Results/L240SlotBasis.lean#L63)) on `Fin n` and `yⱼ := slotφ N ij` at chosen cross-block pairs. Orthonormality is `slot_orthonormal` (:935), skewness `slotφ_isSkew` (:1004), and the eigen-equation `negAdSq_slot` (:1031). Then `inner2_negAdSq` turns `Σ‖[X, yⱼ]‖²` into `Σ slotμ N ijⱼ`, each a `pairMu` equal to `(s_c + s_d)²` at the `p`-side pairs. `inner2_X_X` supplies `⟨X, X⟩ = Σ s_c²`. The homogeneous form `Σ‖[X, yⱼ]‖² = (r + 2)⟨X, X⟩` avoids normalising `X`.

| Witness | `X` (unnormalised) | Slots | Sum against `(r+2)⟨X,X⟩` | Estimate |
|---|---|---|---|---|
| `κ₁ = 2`, `n ≥ 4` | `φ₀₁ + φ₂₃` | one `+` slot of the pair | `4 = 2⟨X,X⟩`, the value `2` sitting below `r + 2 = 3` | 15–25 lines, or RootSlots' `slot_plus` at `s = t = 1` with `(√2)⁻¹` scaling and `inner2_phi_phi` |
| `κ₂ = 4`, `n ≥ 4` | `φ₀₁ + φ₂₃` | both `+` slots | `8 = 4·2` | 20–30 lines, RootSlots' `slot_plus` and `slot_plus2` sufficing |
| `κ₄ = 6`, `n ≥ 6` | `2φ₀₁ + φ₂₃ + φ₄₅` | both `+` slots of pairs (0,1), (0,2) | `36 = 6·6` | 30–50 lines, three blocks, so the `NormalForm` route rather than RootSlots |
| `κ₆ = 8`, `n ≥ 6` | `φ₀₁ + φ₂₃ + φ₄₅` | both `+` slots of all three pairs | `24 = 8·3` | 30–50 lines |
| `κ_{2k} = 2k+2`, `n ≥ 2k+2` | `kφ_{p₀q₀} + Σ_{l=1}^k φ_{p_l q_l}` | both `+` slots of each (0, l) | `2k(k+1)² = (2k+2)(k² + k)` | 80–150 lines, the index bookkeeping over `Fin (2k+2)` being the cost |

The value at every chosen slot is `(s_c + s_d)²` because `pairMu` reads `p c = x` for the `S₁`, `S₂` slots ([L240SlotBasis.lean:604](../lean/HamiltonsCubic/Results/L240SlotBasis.lean#L604)).

## Is **partial** right

Yes. The upper-bound half of every constant and the uniform cap are declared and audited (L237SlotCounts 11/11, L237RayCertificate 3/3, both on the standard three). Items 2–8 above are claims the block asserts and nothing declares. **partial** with an empty owed list is the defect.

## Gaps

- **GA1, [L52.lean:103-106](../lean/HamiltonsCubic/Results/L52.lean#L103).** `diagonal_locus_proper`'s docstring still quotes "off the diagonal family" and says it "reaches a neighbourhood". Fix: the row's wording, the complement of the diagonal family has interior, the block's "away from the family".
- **GA2 (cosmetic), [lean/INDEX.md:384](../lean/INDEX.md#L384).** "**And the block's two remarks**" introduces eight declarations. Fix: "the block's remarks".
- **GB1, [lean/INDEX.md:206](../lean/INDEX.md#L206).** No attainment witness for any `κ_r`, and none owed. Fix: owe items 2 of the list, or declare them as above.
- **GB2, [lean/INDEX.md:206](../lean/INDEX.md#L206).** `κ₁ ≤ 2` is `L31_cap_unit`, which the row does not cite, and the row's `kappa_cap_norm` gives `3` at `r = 1`.
- **GB3, [lean/INDEX.md:206](../lean/INDEX.md#L206).** `κ_r` itself is undefined. Owe it or say the statement is typed through `bracket_cap` and `kappa_cap_norm`.
- **GB4, [lean/INDEX.md:206](../lean/INDEX.md#L206) against [L237RayCertificate.lean:22-23](../lean/HamiltonsCubic/Results/L237RayCertificate.lean#L22).** The row's "**Packaging done** in KyFanPackaging.lean: ... and the derivation of the rows and cap at the ray from L104 and the lemma" states as done what the file says is not typed and what KyFanPackaging does not contain (it declares `inner2Form`, `negAdSq`, `inner2_negAdSq` and nothing else). The clause is the survivor of commit 6680f78e's "*What the files leave out*: ... and the derivation of the rows and cap at the ray from L104 and the lemma", whose other items were later built, so the owed item turned into a done one. Fix: move it to an owed list as items 3 and 4.
- **GB5, [KyFanBracketCap.lean:121-123](../lean/HamiltonsCubic/Results/KyFanBracketCap.lean#L121).** `l173_row_exceeds` is `8 < 12` with no tie to L173's `T`. Fix: a three-line theorem from `cap_tight_11`, `cap_tight_12`, or owe it.
- **GB6, [second-order.md:232](../findings/second-order.md#L232) (record, routed to the research loop, armed in this session).** The statement's `κ₄ = 6`, `κ₆ = 8` carry no `n`, while `κ₄ = 4` at `n = 4` and `3 + √5` at `n = 5`. Fix: "for `n ≥ 6`" on the statement line.
- **GB7, [lean/INDEX.md:206](../lean/INDEX.md#L206).** The closed form `83√21/294`, the exactness vertex and the `7.724` threshold are neither declared nor owed.
- **GB8, [lean/INDEX.md:206](../lean/INDEX.md#L206).** Strictness at odd `r` and the `n < r + 2` values neither declared nor owed.
- **GB9 (cosmetic), [KyFanBracketCap.lean:17-19](../lean/HamiltonsCubic/Results/KyFanBracketCap.lean#L17).** "**Not typed**: Ky Fan's maximum principle and the root-slot description" is stale since KyFanPrinciple, RootSlots and L240SlotBasis. And the row's file column lists KyFanBracketCap.lean alone while the row rests on seven further files.

## What would break each claim, and what was done

| Claim | Breaking object | What was done |
|---|---|---|
| A1, A3 | An owed list without `U` or the `θ` form | Read the row's owed list in full |
| A2 | A surviving "off the diagonal family" | Grepped `lean/HamiltonsCubic/Results`, `lean/INDEX.md` and bispectral.md: one hit, L52.lean:103 |
| A4 | Reals with the two sides unequal | Expanded by hand (distributivity), and the kernel's `ring` agrees |
| A6 | A block sentence on neither list | Read bispectral.md:69-102 sentence by sentence against the row |
| A7, B9 | A non-standard axiom | `axiom_audit.py --only` on L52Remarks (8/8), L237SlotCounts (11/11), L237RayCertificate (3/3), a screen of seconds after checking no lake process ran |
| B1 | A `κ_r` definition in the layer | Grepped `kappa`, `κ`, `topSum` over `lean/HamiltonsCubic`: only L133's and L16's unrelated constants |
| B2 | A unit `X`, `Y` with `‖[X,Y]‖² > 2` | Read `L31_cap`, and checked `(s_a+s_b)² ≤ 2(s_a²+s_b²)` by hand |
| B2–B5, B10 | An attainment declaration | Grepped `attain`, `star`, `doubled`, `odd` in the L237 and KyFan files: none |
| B4, B5 | `n` where the constant fails | Computed the top-4 sums at `n = 4, 5` by hand |
| B6, B8 | A term of `hB`, `hC`, `hcap` off L104's rows | Re-derived all three at `μ = (3, K, 3)`, `ν = a(−1, 0, 4/3)` |
| B7 | `P₀₀`, `P₀₂` below `2` at the witness | Read `cap_tight_11`, `cap_tight_12` |
| B8 | Multipliers failing sign | Solved the dual by hand: `β = −4/7`, `γ = 16/21`. The row-0 primal point is a screen |
| B12 | A missing configuration | Counted `slot3_*`: 19 |
