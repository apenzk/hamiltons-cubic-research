# Review r1585: L56's (2,2,8) at 0.036497 (L56Multi), and r1583's repairs

**Standfirst.** Both commits are sound and the new Lean is faithful. With each factor scaled to Ric = 1 the record's sphere products have sectional curvature 1/(p_i − 1) within factor i and 0 across. The Weyl decomposition at Ric = g, scal = n reduces to W = R − Id/(n − 1) on Λ², so the weights `einstein_rowSum_zero` and `weights_228` use are the right ones, and their row sums vanish. At (2,2,8) the pair counts 2, 28 and 36 are right, gap² = 4/3003 is the recorded 0.036497, and `gap_228_below` places it under S³ × S⁹'s 1/660 and over the floor 1/2475, which is the reading of "falls below" the correction supports. fcd519c8 closes r1583's gaps 1, 2 and 4, and the new L34Statement docstring spectrum (−2, −2, 3/2, 1/2, 1, 1) agrees with a screen. The build is clean, both audits read the standard three only, and there is no `sorry`, `admit` or `native_decide`. Three gaps remain, all in prose. [L56Statement.lean:35](../lean/HamiltonsCubic/Results/L56Statement.lean#L35) still says the (2,2,8) is absent. The L34 row keeps an orphaned "True, and four `simp` attempts [...] Recorded rather than left as a `sorry`" fragment from the passage r1583's gap 3 asked to replace. That repair also deleted the row's BianchiSym passage, which the commit message does not mention.

| # | Claim | Verdict |
| --- | --- | --- |
| A-1a | the record's products are Einstein, each factor scaled to Ric = 1, so K_i = 1/(p_i − 1) | **CONFIRMED** |
| A-1b | Weyl weight 1/(p_i − 1) − 1/(n − 1) within factor i and −1/(n − 1) across, from W = R − (Ric∧g)/(n−2) + scal/(2(n−1)(n−2)) g∧g | **CONFIRMED** |
| A-1c | `einstein_rowSum_zero`: the weights are Ricci-flat | **CONFIRMED** |
| A-1d | pair counts at (2,2,8): 2 within the two S², 28 within S⁸, 36 across, 66 in all | **CONFIRMED** |
| A-1e | `weights_228`, `gap_228`: weights 10/11, 4/77, −1/11, smallest modulus 4/77, gap² = 4/3003 = 0.036497² | **CONFIRMED** |
| A-1f | `gap_228_below`: "falls below" means below the canon's S³ × S⁹ at 1/660, and it stays above the floor 1/2475 | **CONFIRMED** |
| A-1g | equal blocks agree with the file's unit-sphere form up to scale, and the (S³)⁴ value 1/297 is reproduced | **CONFIRMED** |
| A-1h | L56 owed list: the vertex-entry mechanism, and the identification of each product's Weyl operator with the weighted diagonal operator | **CONFIRMED** |
| A-2a | r1583 gap 1: L135Inst composes L135Statement's `line_eq` with `coeff_identity`, duplicate removed | **CONFIRMED** |
| A-2b | r1583 gap 2: the L140 row names the expansions and the ℚ/ℝ binders | **CONFIRMED** |
| A-2c | r1583 gap 3: the L34 row's stale passages replaced | **CONFIRMED WITH GAP** (an orphaned fragment remains, and an unrelated passage was deleted, [lean/INDEX.md:655](../lean/INDEX.md#L655)) |
| A-2d | r1583 gap 4: the L135 row reads "statement: typed" | **CONFIRMED** |
| A-2e | L34Statement docstring: the m = 6 witness has spectrum (−2, −2, 3/2, 1/2, 1, 1), not the record's (−3, −1, 1, 1, 1, 1) | **CONFIRMED** (screen) |
| A-2f | the L52 row's two older semicolon splices rewritten | **CONFIRMED** |
| B | build, axiom audit (7/7 and 1/1), no `sorry`/`admit`/`native_decide` | **CONFIRMED** |
| C | downstream consistency | **CONFIRMED WITH GAP** ([L56Statement.lean:35](../lean/HamiltonsCubic/Results/L56Statement.lean#L35) calls the (2,2,8) absent) |
| D | markdown style of the two commits | **CONFIRMED** |

**Summary:** the (2,2,8) Einstein product's gap² = 4/3003 below S³ × S⁹ and above the floor is correct and faithful, r1583's repairs hold, and three prose gaps remain: a stale "absent" in L56Statement, an orphaned fragment in the L34 row, and an unannounced deletion there.

## 1. Files and rows carrying the ids

- L56: [L56.lean](../lean/HamiltonsCubic/Results/L56.lean), [L56Statement.lean](../lean/HamiltonsCubic/Results/L56Statement.lean), [L56Multi.lean](../lean/HamiltonsCubic/Results/L56Multi.lean). Rows [lean/INDEX.md:625](../lean/INDEX.md#L625) (partial) and [lean/INDEX.md:626](../lean/INDEX.md#L626) (statement, proved).
- L135: L135.lean, L135Statement.lean, L135Inst.lean. Row [lean/INDEX.md:485](../lean/INDEX.md#L485) and its statement row.
- L140: L140.lean, L140Abs.lean, L140Statement.lean. Row [lean/INDEX.md:507](../lean/INDEX.md#L507).
- L34: L34.lean, L34b.lean to L34l.lean, L34Statement.lean. Row [lean/INDEX.md:655](../lean/INDEX.md#L655).
- L52: row [lean/INDEX.md:377](../lean/INDEX.md#L377).

## 2. The (2,2,8) section of L56Multi against Observation L56

- **Einstein factors.** S^p with Ric = 1 has K = 1/(p − 1). The product of such factors has Ric = g, so it is Einstein with scal = n. [ungraded-slack.md](../findings/ungraded-slack.md)'s L58 witness uses the same convention (S⁵ × S⁷ with Ric = λg, K = λ/4 and λ/6).
- **The Weyl weights.** For a product of space forms R is diagonal on the basis e_a∧e_b of Λ², with K_i on pairs inside factor i and 0 on mixed pairs. In the Kulkarni–Nomizu convention, (Ric∧g) and (g∧g) each evaluate to 2 on every pair when Ric = g. So W_ab = K_ab − 2/(n−2) + n/((n−1)(n−2)) = K_ab − 1/(n−1). That is 1/(p_i − 1) − 1/(n − 1) within factor i and −1/(n − 1) across, as the file states, and W is diagonal in the same basis.
- **Row sums.** (p_i − 1)(1/(p_i − 1) − 1/(n − 1)) − (n − p_i)/(n − 1) = 1 − 1 = 0, which is `einstein_rowSum_zero`.
- **Counts at (2,2,8), n = 12.** One pair in each S² (2), C(8,2) = 28 in S⁸, and 2·2 + 2·8 + 2·8 = 36 across. The total 66 is C(12,2).
- **The gap.** Weights 10/11, 4/77 and −1/11 = −7/77, so the smallest modulus is 4/77. ‖W‖² = (200 + 36)/121 + 448/5929 = 12012/5929, so gap² = 16/12012 = 4/3003, and 2/√3003 = 0.036497, the correction's figure. The normalisation matches L56Statement's `gapSq`: the same diagonal computation at S³ × S⁹ (weights 9/22, 3/88, −1/11 at multiplicities 3, 36, 27) gives 9/5940 = 1/660.
- **"Falls below."** The correction lists 0.031497 and 0.020101 (the floors at n = 10 and 12) against the canon's 0.062994 and 0.038925, then adds that the (2,2,8) at 0.036497 "also falls below". It falls below the canon's claimed minimum 0.038925 at S³ × S⁹, and not below the floor 0.020101. `gap_228_below` proves exactly that: 4/3003 < 1/660 and 1/2475 < 4/3003.
- **Equal blocks.** Unit spheres S^p have Ric = (p − 1)g, so their weights are (p − 1) times the Einstein ones: (p − 1)(1/(p − 1) − 1/(n − 1)) = 1 − c and −(p − 1)/(n − 1) = −c. At (S³)⁴ the Einstein weights 9/22 (12 pairs) and −1/11 (54 pairs) give gap² = 4/1188 = 1/297, `gap_S3_four`'s value.
- **The owed list.** The four theorems are arithmetic on the weights. What is untyped is that each product's Weyl operator is the diagonal operator with these weights at these multiplicities (so that its spectrum, and hence the gap, is what `gap_228` computes), and the vertex-entry mechanism. The header ([L56Multi.lean:24](../lean/HamiltonsCubic/Results/L56Multi.lean#L24)) and the row name both, so the list is complete. The pair multiplicities hard-coded in `gap_228` belong to the identification item.
- Note: `gap_228` takes the weights as literals and does not compose `weights_228`. The two are separately true, so nothing is lost.

## 3. fcd519c8 against r1583

- **Gap 1.** `line_eq_scaled_circle` and `hrel_of_homog` are gone. `L135_at_competitor` now calls `line_eq D hD u H t` ([L135Statement.lean:91](../lean/HamiltonsCubic/Results/L135Statement.lean#L91)) inside `coeff_identity`. The homogeneity hypothesis moves from c > 0 to c ≥ 0, matching `line_eq`, which δ² satisfies since δ²(0) = 0. The header credits both theorems. Closed.
- **Gap 2.** The L140 row now says `L135_at_competitor` gives the ℝ form of [L140Statement.lean:230](../lean/HamiltonsCubic/Results/L140Statement.lean#L230)'s `i3_target`, notes that L140.lean's `hdef` is over ℚ, and owes δ² as an operator function together with the two expansions. Both `i3_target` (ℝ) and `reaches_target` (ℚ) read as the row says. Closed.
- **Gap 3.** "So nothing on this row is owed but the formal assembly" and "The remaining obstacle to the count is that [...]" are gone. The replacement sentence "The pieces are all proved, and the statement row assembles them (`ExactlyTwoNegative` at m = 6, 7, 8)" is accurate. **But the next two sentences are left in place**: "True, and four `simp` attempts over the sum type left goals standing [...] Recorded rather than left as a `sorry` under a load-bearing name." They answered the deleted "wants `LinearIndependent` plumbing" clause. After the replacement, "True" affirms that the statement row assembles the pieces, and the fragment then reads as if that assembly failed, beside a sentence saying it succeeded. Separately, the deletion removed three more sentences: "AND BOTH `bianchiOf` CLAIMS NOW LEAVE THE COMPILER" (BianchiSym.lean, `bianchiOf_eq_zero_of_base`, the eight tainted declarations cleared). The same retirement is recorded at [lean/INDEX.md:693](../lean/INDEX.md#L693), so the credit survives. The commit message does not mention the deletion.
- **Gap 4.** The L135 row ends "statement: typed". Closed.
- **The L34Statement docstring.** The Lean m = 6 witness pads `WE` at μ = (1, 1, −2) on the frames (0,1,4,5) and (2,3,4,5). A screen, built from CP2Real's `J` on Λ²ℝ⁶ with the pairing `inner2`, gives the nonzero spectrum (−2, −2, 1/2, 1, 1, 3/2), as the docstring now says. Screening all 576 orderings of the two frames on the same planes gives exactly three spectra: this one, (−2, −1.8229, 0.8229, 1, 1, 1), and the record's (−3, −1, 1, 1, 1, 1), the last at frames (0,4,5,1) and (2,4,5,3). So the record's figure belongs to the same two planes with a different frame alignment. The docstring's "an alignment [...] and not the record's" is accurate. Reported as a screen.
- **L52.** "is what makes it positive. **And the inequality needs no Karamata**" and "combination of the spectrum. And that P_ij" replace the two splices. Closed.

## 4. Soundness

- `lake build HamiltonsCubic.Results.L56Multi HamiltonsCubic.Results.L135Inst HamiltonsCubic.Results.L34Statement`: "Build completed successfully", exit 0, linter warnings only.
- `axiom_audit.py --only L56Multi.lean`: 7/7 clean on the standard three. `--only L135Inst.lean`: 1/1 clean.
- No `sorry`, `admit` or `native_decide` in the three files. The one match for "sorry" is L34Statement's docstring saying there is none.

## 5. Downstream

- [L56Statement.lean:34](../lean/HamiltonsCubic/Results/L56Statement.lean#L34) to 35: "The multi-block clause at the canon's (S³)⁴ is L56Multi.lean's `multi_between` [...]. The correction's unequal `(2,2,8)` is absent." Since 663e5d47 it is in L56Multi as `gap_228` and `gap_228_below`. Gap.
- [L56Multi.lean:9](../lean/HamiltonsCubic/Results/L56Multi.lean#L9): "This file types the equal-block case" is now incomplete, though the bullets below it list the (2,2,8). Note.
- [lean/INDEX.md:625](../lean/INDEX.md#L625) and plan-lean.md agree with the file. [ungraded-slack.md](../findings/ungraded-slack.md), [INDEX-results.md](../findings/INDEX-results.md) and [results.md](../results.md) make no Lean claim about the (2,2,8) that the commits contradict. results.md still carries the refuted values, which the L56 statement row already records.

## 6. Style

- No em dash and no backtick inside link text in any line either commit added to [lean/INDEX.md](../lean/INDEX.md). Table rows stay single lines. No new semicolon splice. The L34 row keeps two older ones ("while B11 was unproved; the check is now" and "at `-2`; they are orthogonal"), which predate both commits.
- Note, Lean docstring: [L56Multi.lean:25](../lean/HamiltonsCubic/Results/L56Multi.lean#L25) phrases the owed item partly as a negation ("not extracted from a curvature operator").

## Verdict

**CONFIRMED WITH GAPS.** The (2,2,8) section is correct and faithful to Observation L56's correction, and r1583's gaps 1, 2 and 4 are closed. Gaps:

1. [L56Statement.lean:35](../lean/HamiltonsCubic/Results/L56Statement.lean#L35): "The correction's unequal `(2,2,8)` is absent" is stale. It is now L56Multi's `gap_228` and `gap_228_below`.
2. [lean/INDEX.md:655](../lean/INDEX.md#L655): the L34 row keeps "True, and four `simp` attempts over the sum type left goals standing [...] Recorded rather than left as a `sorry` under a load-bearing name.", orphaned from the clause r1583's gap 3 had removed. It now reads as a failed attempt at the assembly the previous sentence calls done.
3. [lean/INDEX.md:655](../lean/INDEX.md#L655): fcd519c8 also deleted the row's "AND BOTH `bianchiOf` CLAIMS NOW LEAVE THE COMPILER" passage (BianchiSym.lean). That passage was outside r1583's gap 3, and the commit message does not mention it. The credit survives at [lean/INDEX.md:693](../lean/INDEX.md#L693), so this is a record-keeping gap only.
