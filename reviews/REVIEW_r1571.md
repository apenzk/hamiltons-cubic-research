# Review r1571: L56's multi-block clause (commit 69613196) and r1568's repairs (commit e6faf1ad)

**Standfirst.** [L56Multi.lean](../lean/HamiltonsCubic/Results/L56Multi.lean) is correct and compares like with like: for (S³)⁴ the Weyl operator on Λ² is diagonal with weight 1 − c within a factor and −c across, c = 2/11, the smallest modulus is c, and `multiGapSq` carries the same normalisation as [L56Statement](../lean/HamiltonsCubic/Results/L56Statement.lean)'s `gapSq`, so `multi_between` is the canon's clause. One printed number is wrong: gap(S⁴×S⁸)² is 3/770, and the file header, the lean/INDEX.md row and the commit message all say 3/385. The theorem is unaffected, since `norm_num` computes the true value. The repairs of [r1568](REVIEW_r1568.md) close gaps 1 to 7 in substance: s* is built over ℝ, `radius_eq_sStar` places the crossing at arcsin s*, and dropping `4 ≤ N` from L49 is sound. L56 is correctly back to partial, and its owed list names the two live items. What remains is text: the INDEX-results row 56 tag, the Weyl weights stated under PROVED where only their row sum is typed, the one-sided reduction the L20 row does not mention, and a stale L20Arcsin header. Everything builds on the standard three axioms.

| # | claim | verdict |
| --- | --- | --- |
| A-1a | the Weyl operator of (S³)⁴ (unit spheres, n = 12) is diagonal with 1 − c within a factor and −c across, c = (p − 1)/(n − 1) = 2/11 | **CONFIRMED** (by hand, W = R − c·Id on Λ² for an Einstein metric) |
| A-1b | `multiGapSq` is the same gap as `gapSq`, smallest nonzero modulus over the Λ² Frobenius norm, squared | **CONFIRMED** (the same formula reproduces gapSq 3 9 = 1/660 from the S³×S⁹ vertex entries) |
| A-1c | the smallest modulus at k = 4, p = 3 is c, not 1 − c | **CONFIRMED** (2/11 < 9/11) |
| A-1d | `gap_S3_four`: gap((S³)⁴)² = 1/297, gap = 0.05803 | **CONFIRMED** |
| A-1e | `multi_between`: 1/660 < 1/297 < 3/385 | **CONFIRMED WITH GAP** (the Lean statement is right, the printed upper value is 3/770) |
| A-1f | "the Weyl weights are 1 − c and −c, Ricci-flat (`multi_rowSum_zero`)" under **PROVED** | **CONFIRMED WITH GAP** (only the row sum is typed, the weights are a definition) |
| A-2a | `sStar_exists_unique`, `sStar`, `radius_eq_sStar` (r1568 gap 1) | **CONFIRMED** (the crossing half, the one-sided reduction still stops at 0.54368) |
| A-2b | TubeRadius and L20Statement headers (r1568 gaps 2, 3) | **CONFIRMED** (L20Arcsin.lean:9 still credits TubeRadius with the real root) |
| A-2c | the L20 row links route-a.md and its splice is rewritten (r1568 gaps 4, 7) | **CONFIRMED** |
| A-2d | L49 drops `4 ≤ N` and so covers the record's N ≥ 3 (r1568 gap 5) | **CONFIRMED** |
| A-2e | L56 back to partial, owed: the unequal (2, 2, 8) product and the vertex-entry mechanism (r1568 gap 6) | **CONFIRMED** (complete for the block's live clauses) |
| B | builds, standard three only, no sorry, admit or native_decide | **CONFIRMED** |
| C | no downstream text inconsistent with the changes | **CONFIRMED WITH GAP** (INDEX-results.md:71 reads Lean: proved against a partial main row) |
| D | style of the markdown edits | **CONFIRMED** |

**Summary:** the new Lean and the repairs are correct and faithful, and the gaps are one wrong printed fraction and four places where the text says more or less than the Lean.

## 1. L56's multi-block clause

- **The record.** Canon [results.md:714](../results.md#L714): *"Multi-block products interleave rather than extend the trend, $(S^3)^4$ at $0.0580$ sits between $S^3\times S^9$ and $S^4\times S^8$."* The Gate 2 block at [ungraded-slack.md:316](../findings/ungraded-slack.md#L316) says the closed form *"also reproduces the recorded $(S^3)^4$ value"*, and at [ungraded-slack.md:310](../findings/ungraded-slack.md#L310) defines the gap as *"the smallest nonzero modulus of the normalised $\Lambda^2$ spectrum"*.
- **The Weyl operator, derived.** A product of k unit spheres S^p has curvature operator diagonal on the basis e_i ∧ e_j: 1 on the k·C(p,2) pairs inside a factor, 0 on the rest. Ric = (p − 1)g, scal = n(p − 1), so the metric is Einstein and W = R − (scal/(n(n − 1)))·Id on Λ², with scal/(n(n − 1)) = (p − 1)/(n − 1) = c. The weights are 1 − c within and −c across, as the file says. At n = 12, p = 3, c = 2/11. Correct.
- **Ricci-flatness.** Each index has p − 1 partners inside its factor and n − p outside, and (p − 1)(1 − c) − (n − p)c = (p − 1) − (n − 1)c = 0. That is [multi_rowSum_zero](../lean/HamiltonsCubic/Results/L56Multi.lean#L29). Correct.
- **Like with like.** For S^p × S^q, the block's vertex entries −q/(p − 1), −p/(q − 1), 1 are the Einstein-normalised Weyl weights (κ = 1/(p − 1) and 1/(q − 1), c = 1/(n − 1)) scaled by −(n − 1). At (3, 9) the smallest modulus is 3/8 and the Frobenius norm squared over Λ² (each bivector once) is 3·81/4 + 36·9/64 + 27 = 92.8125, and (9/64)/92.8125 = 1/660, which is `gapSq 3 9`. `multiGapSq` is c² over k·C(p,2)(1 − c)² + (C(n,2) − k·C(p,2))c², the same quotient on the same basis. Both are scale-invariant, so the unit-sphere normalisation of (S³)⁴ and the Einstein normalisation of S^p × S^q do not differ. Correct.
- **The smallest modulus.** c ≤ 1 − c is 2(p − 1) ≤ kp − 1, true for k ≥ 2. At (4, 3), 2/11 < 9/11. Correct. The definition bakes c in as the minimum, which the docstring states.
- **The value.** c² = 4/121, the 12 inner bivectors contribute 12·81/121, the 54 cross ones 54·4/121, total 1188/121, so gap² = 4/1188 = 1/297 and gap = 0.058026, the canon's 0.0580. Checked by hand and by a screen in exact rationals.
- **Gap 1.** `gapSq 4 8` = 2·4·3/(8·7·11·10) = 24/6160 = **3/770** (gap 0.062419, the value r1568's screen gave). [L56Multi.lean:18](../lean/HamiltonsCubic/Results/L56Multi.lean#L18), the L56 row at [lean/INDEX.md:623](../lean/INDEX.md#L623) and the commit message print 3/385. `multi_between` itself unfolds `gapSq` and `norm_num` evaluates it, so the theorem is right and the ordering 1/660 < 1/297 < 3/770 holds. The printed fraction is twice the true one.
- **Gap 2.** The L56 row says, under *"The canon's multi-block clause is PROVED"*, that *"the Weyl weights are $1-c$ within a factor and $-c$ across ... Ricci-flat (`multi_rowSum_zero`)"*. The Lean types the row sum of the weights, and `multiGapSq` takes the weights and their minimum as a definition. That W of (S^p)^k has these eigenvalues is the multi-block analogue of the vertex-entry mechanism the row lists as owed for S^p × S^q. The row should say the weights are the file's input, or extend the owed mechanism to them. The placement of 0.0580 between the two products is proved given the weights, which is the canon's clause.

## 2. r1568's repairs

- **Gap 1 of r1568, s* over ℝ.** [sStar_exists_unique](../lean/HamiltonsCubic/Results/L20Arcsin.lean#L67) takes the root by `intermediate_value_Icc` on [0, 1] (f(0) = −1, f(1) = 2), excludes the endpoints, and gets uniqueness from f(t) − f(s) = (t − s)(t² + ts + s² + t + s + 1), whose second factor is positive for s, t > 0. `sStar` is the chosen witness and [radius_eq_sStar](../lean/HamiltonsCubic/Results/L20Arcsin.lean#L94) proves that for s ∈ (0, 1), cos(arcsin s) + sin(arcsin s)³ = 1 exactly when s = s*. So the level set {ψ = 1} ∩ (0, π/2) is the single point arcsin s*, and "the radius is arcsin s*" holds as a statement about the crossing. Correct.
- **Gap 3.** r1568 also recorded that the reduction ψ ≤ 1 ⟺ sin φ ≤ s* is typed in one direction and only at sin φ ≤ 0.54368 ([cos_add_sin_cube_le_one](../lean/HamiltonsCubic/Results/L20Statement.lean#L84)). That is unchanged: no file proves ψ ≤ 1 on the whole of [0, arcsin s*], so the chain runs at arcsin 0.54368. [L20Statement.lean:56](../lean/HamiltonsCubic/Results/L20Statement.lean#L56) now says exactly this. The L20 row at [lean/INDEX.md:328](../lean/INDEX.md#L328) says *"so the radius is arcsin s*"* and does not add that the chain is typed at the truncated radius. The step is elementary (the sign of s²(1 − s)(1 − s − s² − s³) on (0, s*]), and the row should name it until it is typed.
- **Gaps 2 and 3 of r1568.** [TubeRadius.lean:20](../lean/HamiltonsCubic/Results/TubeRadius.lean#L20) and [:94](../lean/HamiltonsCubic/Results/TubeRadius.lean#L94) now point at L20Arcsin and say the real root is built there. L20Statement's header and section heading now describe the chain at 0.54368. Closed.
- **Gap 4.** [L20Arcsin.lean:8](../lean/HamiltonsCubic/Results/L20Arcsin.lean#L8) still says TubeRadius *"proves the cubic `s³ + s² + s - 1` has a unique root `s* ∈ (0, 1)`"*, which is r1568's gap 1 restated in the file that repairs it. TubeRadius proves monotonicity and the sign change over ℚ, and the root is this file's `sStar_exists_unique`. The same header line carries a semicolon splice (Lean docstring, pre-existing).
- **Gaps 4 and 7 of r1568.** The L20 row's id now links [route-a.md](../findings/route-a.md), and the splice is rewritten as *"$\psi(\varphi)=1$ is $\cos\varphi+\sin^3\varphi=1$, and squaring gives $s^4-2s+1$"*. Closed.
- **Gap 5 of r1568, L49.** [collapse_space_is_the_constants](../lean/HamiltonsCubic/Results/L49Statement.lean#L303) now has only `T` as an explicit binder, over `variable {N : ℕ}`. It builds and audits clean, so it holds at every N, which covers the record's N ≥ 3. At N = 3 there is one increasing triple, both sides hold for every T, and the characterisation reads "the space is one-dimensional" as the record does. At N ≤ 2 it is vacuously true. No other Lean file calls the theorem, so no caller breaks. The header at [L49Statement.lean:61](../lean/HamiltonsCubic/Results/L49Statement.lean#L61) and the statement row at [lean/INDEX.md:378](../lean/INDEX.md#L378) say the record's threshold is N ≥ 3 and none is carried. Closed.
- **Gap 6 of r1568, L56.** The main row at [lean/INDEX.md:623](../lean/INDEX.md#L623) reads **partial**, and the owed items are the (2, 2, 8) product and the vertex-entry mechanism. Against the block at [ungraded-slack.md:310–319](../findings/ungraded-slack.md#L310): the ordering, the two exact figures, the corrected floor and the ℂPᵐ comparison are L56Statement's; the (S³)⁴ placement is L56Multi's; the balanced display is taken from the record, which the statement row at [lean/INDEX.md:624](../lean/INDEX.md#L624) says; the "not the set's floor" clause has, in the block's own words, *"no witness anywhere on the record"*. The (2, 2, 8) value is live: a screen with κ = 1, 1, 1/7 (Einstein), c = 1/11, weights 10/11 (2 bivectors), 4/77 (28) and −1/11 (36) gives 0.036497, the block's figure. So the owed list is complete for the block's live clauses, subject to gap 2 extending the mechanism to the multi-block weights.

## 3. Soundness

- `lake build HamiltonsCubic.Results.L56Multi HamiltonsCubic.Results.L20Arcsin HamiltonsCubic.Results.L49Statement`: completed, 8711 jobs, warnings only (unused binders, deprecated `push_neg`, an unused simp argument, all in files these commits did not touch or pre-existing).
- `axiom_audit.py --only`: L56Multi 3/3, L20Arcsin 6/6, L49Statement 11/11, each on `propext`, `Classical.choice`, `Quot.sound` alone.
- No `sorry`, `admit` or `native_decide` in L56Multi, L20Arcsin or L49Statement (the one hit is a docstring saying there is none).
- Files carrying the ids: [L56.lean](../lean/HamiltonsCubic/Results/L56.lean), [L56Statement.lean](../lean/HamiltonsCubic/Results/L56Statement.lean), [L56Multi.lean](../lean/HamiltonsCubic/Results/L56Multi.lean), [L20Statement.lean](../lean/HamiltonsCubic/Results/L20Statement.lean), [L20Arcsin.lean](../lean/HamiltonsCubic/Results/L20Arcsin.lean), [TubeRadius.lean](../lean/HamiltonsCubic/Results/TubeRadius.lean), [L49.lean](../lean/HamiltonsCubic/Results/L49.lean), [L49Statement.lean](../lean/HamiltonsCubic/Results/L49Statement.lean), with rows at lean/INDEX.md:328, 329, 377, 378, 584, 623, 624.

## 4. Downstream

- **Gap 5.** [INDEX-results.md:71](../findings/INDEX-results.md#L71), row 56, reads **Lean: proved**. Where either lean/INDEX.md row is partial the tag reads partial (row 5, main proved and statement partial; row 54, main partial and statement proved), and 0a4349a6 moved row 49's tag with its main row. The L56 main row is now partial and its statement row proved, the shape of row 54. Row 56 read proved before 0a4349a6 as well, so the mismatch predates these commits, and e6faf1ad's move back to partial is the edit that should have carried it.
- Rows 20 and 49 of INDEX-results read Lean: proved, matching their main rows.
- [plan-lean.md](../plan-lean.md) lists L56 as partial and counts 127, consistent with STATUS.md.
- [route-a.md](../findings/route-a.md) and [results.md](../results.md) state the record, and nothing in them contradicts the Lean. [ungraded-slack.md](../findings/ungraded-slack.md) is unchanged and consistent.

## 5. Style

- The added lean/INDEX.md and STATUS.md lines carry no em dash and no backticks inside link text, and each table row is one line.
- The two semicolons in the added lines are STATUS.md's list-style cell ("4 on the main route; 99 partial, ..."), whose items carry commas.

## Verdict

**CONFIRMED WITH GAPS.** The Lean is correct, faithful and on the standard three axioms, and r1568's gaps are closed in substance. Gaps, all text:

1. gap(S⁴×S⁸)² is 3/770, printed as 3/385 at L56Multi.lean:18 and lean/INDEX.md:623.
2. The multi-block Weyl weights are stated under PROVED at lean/INDEX.md:623, and only their row sum is typed.
3. ψ ≤ 1 on (0, arcsin s*] is typed only up to 0.54368, and the L20 row at lean/INDEX.md:328 does not say so.
4. L20Arcsin.lean:8 credits TubeRadius with the real root s* that this file builds.
5. INDEX-results.md:71 reads Lean: proved against L56's partial main row.
