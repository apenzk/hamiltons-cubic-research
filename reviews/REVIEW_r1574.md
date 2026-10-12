# Review r1574: L119's C5 figure (commit f0aa651d) and r1571's repairs (commit 953a0569)

Log: agent_logs/r1574.log

**Standfirst.** [L119C5.lean](../lean/HamiltonsCubic/Results/L119C5.lean) is right in every figure: the weights 4c : −2c : +c on five blocks of two in a cycle have vanishing rows, 5, 20 and 20 pairs of the three kinds, 180c² = 1, |λ_min| = 2c, λ^min_𝔭 = c, M = 24, Δ = 12, and the sharpened bound is 9c = 3/(2√5), the recorded θ. A seconds-long screen of L68's closed form on this weight matrix returns g = 0, 6/5, 3/5 and Σg = 36, so the inputs the file takes as recorded are the right ones. Moving L119 to proved stands, the bound being L107Frame's `L119_every` and both audit points L119Statement's. The repair commit closes r1571's gaps 1, 2, 4 and 5, and `psi_le_one_iff` is correct: on (0, 1), √(1 − s²) + s³ ≤ 1 exactly when s ≤ s*. It does not by itself run the tube chain at s*, and the L20 row says it does. Everything builds on the standard three axioms.

| # | claim | verdict |
| --- | --- | --- |
| A-1a | rows vanish: 1 within-block partner, 4 adjacent, 4 non-adjacent, 4c − 8c + 4c = 0 | **CONFIRMED** |
| A-1b | pair counts 5, 20, 20 over the 45 unordered pairs, and Σμ² = 180c², so unit norm is c = 1/(6√5) | **CONFIRMED** |
| A-1c | \|λ_min\| = 2c, λ^min_𝔭 = c, 𝔭 carrying the eigenvalues 4c and c | **CONFIRMED** |
| A-1d | M = 20 · 6/5 = 24 on the adjacent pairs, Δ = 5 · 0 + 20 · 3/5 = 12, Σg = 36 = 4(n − 1) | **CONFIRMED** (g values screened against L68's closed form) |
| A-1e | unsharpened 12c = 2/√5 = 0.894427…, sharpened 9c = 3/(2√5) = 0.670820… | **CONFIRMED** |
| A-1f | L119 moves to proved | **CONFIRMED WITH GAP** (two Gate 2 clauses untyped and unlisted in the row) |
| A-2a | r1571 gap 1: 3/770 in L56Multi.lean and the L56 row | **CONFIRMED** |
| A-2b | r1571 gap 2: the multi-block weights named as a definition | **CONFIRMED** (the new parenthetical carries a clause splice, section 5) |
| A-2c | r1571 gap 3: `psi_le_one_iff`, √(1 − s²) + s³ ≤ 1 on (0, 1) iff s ≤ s* | **CONFIRMED** |
| A-2d | "so the tube argument closes on all of (0, arcsin s*]" | **CONFIRMED WITH GAP** (the reduction is typed, the chain at s* is not) |
| A-2e | r1571 gap 4: L20Arcsin header credits this file with s* | **CONFIRMED** |
| A-2f | r1571 gap 5: INDEX-results row 56 reads Lean: partial | **CONFIRMED** |
| B | builds, standard three only, no sorry, admit or native_decide | **CONFIRMED** |
| C | downstream text consistent with the changes | **CONFIRMED** |
| D | style of the markdown edits | **CONFIRMED WITH GAP** (one semicolon splice) |

**Summary:** the Lean is correct and faithful, and the gaps are three places where the row text says more, or lists less, than the files type.

## 1. L119's C5 figure

- **The record.** [bounds-relaxations.md:331](../findings/bounds-relaxations.md#L331): *"From the recorded entries $4:-2:+1$ with blocks $(2,2,2,2,2)$, the row sum and $180c^2=1$ give $c=1/(6\sqrt5)$, and Lemma L68's closed form gives $g=0/1.2/0.6$ on within-block, adjacent and non-adjacent pairs, reproducing $\Delta=12$, $M=24$, $\sum g=36=4(n-1)$, and $0.894427\to0.670820=\theta$ exactly."*
- **Rows.** A vertex in block B_i has one partner in B_i, the two vertices of each of B_{i±1} (4 adjacent) and of each of B_{i±2} (4 non-adjacent). Row sum 4c − 8c + 4c = 0. That is [c5_rowSum](../lean/HamiltonsCubic/Results/L119C5.lean#L28). The row sum fixes the ratio 4 : −2 : 1 as admissible and leaves c free, which the file reads correctly.
- **Pairs and norm.** Within: 5 blocks, one pair each, 5. Adjacent: 5 block pairs in the cycle, 4 vertex pairs each, 20. Non-adjacent: the other 5 block pairs, 20. Total 45 = C(10, 2). In the record's normalisation (Frobenius over unordered pairs, the orthonormal φ_ab of [diagonal-half.md:90](../findings/diagonal-half.md#L90)), Σμ² = 5·16c² + 20·4c² + 20·c² = 180c², so 180c² = 1 is unit norm and c = 1/(6√5). [c5_normSq](../lean/HamiltonsCubic/Results/L119C5.lean#L30) and [c5_unit](../lean/HamiltonsCubic/Results/L119C5.lean#L35).
- **Spectrum.** On the diagonal locus the eigenvectors are the coordinate bivectors and the eigenvalues are the weights: 4c (5 times), −2c (20), c (20), trace 20c − 40c + 20c = 0. λ_min = −2c. 𝔭, the strictly positive eigenspace, carries 4c and c, so λ^min_𝔭 = c. Correct.
- **g, screened.** L68's closed form g_ab = 2(s_a + s_b) − 4(M²)_ab − 4M_ab², evaluated in exact rationals on this 10 × 10 weight matrix at c² = 1/180, a screen of seconds: g = 0 on within-block pairs (twins, rows equal off the pair), 6/5 on adjacent, 3/5 on non-adjacent, Σg = 36. The file takes these as recorded, and they are the right ones. Reported as a screen only.
- **M and Δ.** M = Σ_{λ<0} g = 20 · 6/5 = 24. Δ = Σ_{λ>0} g = 5 · 0 + 20 · 3/5 = 12. G₀ = 0, and M = 4(n − 1) − Δ − G₀ = 36 − 12 = 24 agrees. [c5_gsum](../lean/HamiltonsCubic/Results/L119C5.lean#L56).
- **The bounds.** |λ_min| M / 4 = 2c · 24 / 4 = 12c = 2/√5. [|λ_min| M − λ^min_𝔭 Δ]/4 = (48c − 12c)/4 = 9c = 3/(2√5). The splitting identity gives 4θ = A − B = 2c·24 − (4c·0 + c·12) = 36c, so θ = 9c and the sharpened bound is attained, as the record says. [c5_bounds](../lean/HamiltonsCubic/Results/L119C5.lean#L38) and [c5_bound_values](../lean/HamiltonsCubic/Results/L119C5.lean#L43) with the six-place brackets.
- **What the file is.** Arithmetic on recorded inputs: 2c, c, 24 and 12 enter c5_bounds as literals, and the header says the g values and θ are the record's. That is an accurate description, and "DERIVED" in the row means the figure follows from the recorded weights and L68's g, which the screen supports.

### Moving L119 to proved

- Files carrying the id: [L119.lean](../lean/HamiltonsCubic/Results/L119.lean), [L119Statement.lean](../lean/HamiltonsCubic/Results/L119Statement.lean), [L119C5.lean](../lean/HamiltonsCubic/Results/L119C5.lean), with `L119_every` in [L107Frame.lean:109](../lean/HamiltonsCubic/Results/L107Frame.lean#L109). Rows: [lean/INDEX.md:471](../lean/INDEX.md#L471) and [:472](../lean/INDEX.md#L472).
- The bound at every Weyl W, no criticality: `L119_every`, 4P ≤ |λ_min| Σ_{λ<0} g − c Σ_{λ>0} g, on the eigenframe. Both improvement claims: `sharpened_le_recorded`, `sharpened_lt_recorded` and `inf_pos_of_nonempty` in L119Statement. The dropped unit norm: `homogeneity_needs_normalisation` in L119.lean. The C5 figure: this file. The "only catalogued point with Δ > 0" clause is refuted by the Gate 2 block at [bounds-relaxations.md:333](../findings/bounds-relaxations.md#L333), so it is no claim to type.
- **Gap 1.** Two claims of the Gate 2 block at [bounds-relaxations.md:329](../findings/bounds-relaxations.md#L329) are typed nowhere: the gain cap Δ/(4√dim 𝔭) from dim 𝔭 (λ^min_𝔭)² ≤ 1, and "tracelessness keeps 𝔭 non-empty" (`inf_pos_of_nonempty` takes nonemptiness as a hypothesis, and [L119Statement.lean:191](../lean/HamiltonsCubic/Results/L119Statement.lean#L191) asserts the supply in a docstring). Both are reviewer additions rather than the block's statement, and both are short, so the move to proved stands. The row's *Untyped* list at [lean/INDEX.md:471](../lean/INDEX.md#L471) names only the catalogue clause and should name these two.

## 2. r1571's repairs

- **Gap 1 of r1571.** gapSq 4 8 = 3/770 now reads so at [L56Multi.lean:18](../lean/HamiltonsCubic/Results/L56Multi.lean#L18) and in the L56 row at [lean/INDEX.md:624](../lean/INDEX.md#L624). The commit message records that 69613196 printed 3/385. Closed.
- **Gap 2 of r1571.** The row now says the weights are *"taken as"* 1 − c and −c, *"a definition, whose row sums vanish by `multi_rowSum_zero`"*, and that they are the multi-block form of the owed mechanism. Closed in substance (style in section 5).
- **Gap 3 of r1571, `psi_le_one_iff`.** For s ∈ (0, 1), 1 − s³ > 0, so √(1 − s²) ≤ 1 − s³ iff 1 − s² ≤ (1 − s³)², that is 0 ≤ s² − 2s³ + s⁶ = s²(1 − 2s + s⁴) = s²(1 − s)(1 − s − s² − s³). With s²(1 − s) > 0 this is s³ + s² + s − 1 ≤ 0, and since the cubic is strictly increasing on s ≥ 0 (`cubic_lt`, from (b − a)(a² + ab + b² + a + b + 1)) and vanishes at s*, that is s ≤ s*. The Lean at [L20Arcsin.lean:111](../lean/HamiltonsCubic/Results/L20Arcsin.lean#L111) follows exactly this route, with `Real.sqrt_le_left` for the squaring and the same factor s²(1 − s)(1 − (s³ + s² + s)). Correct.
- **Gap 2 (this review).** The L20 row at [lean/INDEX.md:329](../lean/INDEX.md#L329) and the docstring at [L20Arcsin.lean:109](../lean/HamiltonsCubic/Results/L20Arcsin.lean#L109) conclude *"so the tube argument closes on all of $(0,\arcsin s^*]$"*. `psi_le_one_iff` is the reduction in the sine variable. The chain itself, [max_le_one_of_sin_le](../lean/HamiltonsCubic/Results/L20Statement.lean#L102), still takes `sin φ ≤ 0.54368`, and no theorem composes `expansion_step`, cos φ = √(1 − sin²φ) on [0, π/2] and `psi_le_one_iff` into m ≤ 1 at sin φ ≤ s*. The composition is a few lines and the row should either say the reduction is typed and the chain runs at 0.54368, or the file should carry the composed theorem. [L20Statement.lean:56](../lean/HamiltonsCubic/Results/L20Statement.lean#L56) states the chain's radius correctly.
- **Gap 4 of r1571.** [L20Arcsin.lean:8](../lean/HamiltonsCubic/Results/L20Arcsin.lean#L8) now says TubeRadius works over ℚ, where the cubic has no root, and that this file builds s*. The semicolon splice r1571 noted is gone. Closed.
- **Gap 5 of r1571.** [INDEX-results.md:71](../findings/INDEX-results.md#L71) reads Lean: partial, matching the partial main row. Closed.

## 3. Soundness

- `lake build HamiltonsCubic.Results.L119C5 HamiltonsCubic.Results.L20Arcsin HamiltonsCubic.Results.L56Multi`: completed, 8710 jobs, warnings only, in L56Statement (an unused binder and an unclosed namespace, pre-existing).
- `axiom_audit.py --only`: L119C5 6/6, L20Arcsin 8/8, L56Multi 3/3, each on `propext`, `Classical.choice`, `Quot.sound` alone.
- No `sorry`, `admit` or `native_decide` in the three files. L119C5 is imported by [HamiltonsCubic.lean:347](../lean/HamiltonsCubic.lean#L347).

## 4. Downstream

- [INDEX-results.md:135](../findings/INDEX-results.md#L135), row 119, reads Lean: proved, which now matches both proved rows. Row 20 reads proved and row 56 partial, matching their main rows.
- [plan-lean.md](../plan-lean.md) lists L56 as partial and no longer lists L119. STATUS.md moves from 127 to 126 unproved with 99 partial, consistent with one result leaving partial.
- [route-a.md:119](../findings/route-a.md#L119) states the exact reduction in the same factorisation `psi_le_one_iff` proves. [bounds-relaxations.md](../findings/bounds-relaxations.md) is unchanged and nothing in it contradicts the Lean. No remaining 3/385 anywhere.

## 5. Style

- No em dash and no backticks inside link text in the added lines, and every table row is one line.
- **Gap 3.** The new L56 parenthetical at [lean/INDEX.md:624](../lean/INDEX.md#L624), *"(a definition, whose row sums vanish by `multi_rowSum_zero`; the weights themselves are the multi-block form of the owed vertex-entry mechanism)"*, joins two clauses with a semicolon. The other semicolons in the touched rows predate these commits.

## Verdict

**CONFIRMED WITH GAPS.** The C5 arithmetic is right, the g inputs agree with L68's closed form, `psi_le_one_iff` is correct, r1571's five gaps are closed, and everything is on the standard three axioms. Gaps, all text:

1. lean/INDEX.md:471: the L119 row's *Untyped* list omits the gain cap Δ/(4√dim 𝔭) and the nonemptiness of 𝔭 from tracelessness, both untyped.
2. lean/INDEX.md:329 and L20Arcsin.lean:109 say the tube argument closes on all of (0, arcsin s*], while the typed chain still takes sin φ ≤ 0.54368 and nothing composes it with `psi_le_one_iff`.
3. lean/INDEX.md:624: a semicolon clause splice in the new L56 parenthetical.
