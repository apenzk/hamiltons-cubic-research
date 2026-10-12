# REVIEW r1668: r1666's gaps at L52 (1b2e4f24, lean-loop part)

**Verdict: CONFIRMED WITH GAPS.** `trace_pow_diag` and `L52_matrix_if` are correct and are the matrix-level "if" half, the file compiles with no warning, and the audit is 5/5 on the standard three. r1666 G1, G2, G3 and G6 are repaired. G4 and G5 are repaired as r1666 listed them, but the same defect survives two lines up in CubicConvexity.lean and in DoublyStochastic.lean, L52Statement.lean's "quoted verbatim" block now carries a paraphrase, and the Owed clause says where the ψ stipulation enters without naming what would carry it.

| # | claim | verdict |
| --- | --- | --- |
| 1 | `trace_pow_diag`: `tr A^k = Σ A_ii^k` for `A` with zero off-diagonal | **CONFIRMED** |
| 2 | `L52_matrix_if`: diagonal `A`, `B` make `L52_matrix_bound`'s display an equality, with no ψ stipulation | **CONFIRMED** |
| 3 | r1666 G1 (the "if" half at the matrices typed) and G2 (the Owed clause names the passage's declarations, at any complete `w`) | **CONFIRMED** |
| 4 | r1666 G3 ("shared frame" only once both are built from one frame) | **CONFIRMED** (L52Equality.lean:19-20 and :97, INDEX.md:383) |
| 5 | r1666 G4 and G5: the headers no longer quote or restate the removed Karamata claim or the unbuilt instantiation | **CONFIRMED WITH GAPS** (G1, G2, G3 below) |
| 6 | r1666 G6: the unused simp argument removed | **CONFIRMED** (compile clean, no lint warning) |
| 7 | the Owed clause is accurate and complete for L52 | **CONFIRMED WITH GAP** (G4) |
| 8 | axiom audit, L52Equality.lean | **CONFIRMED** (5/5, standard three) |

**Summary:** the new mathematics is right and the matrix-level equality clause is now two-sided, while the header sweep missed the removed record sentence where it is quoted rather than restated, and the Owed clause leaves the ψ step unnamed.

## 1. `trace_pow_diag`

- **By hand.** Zero off-diagonal entries make `A = diagonal (A_ii)`, so `A^k = diagonal (A_ii^k)` and the trace is `Σ A_ii^k`.
- **The Lean** ([L52Equality.lean:111-119](../lean/HamiltonsCubic/Results/L52Equality.lean#L111)) proves `A = diagonal (fun i => A i i)` entrywise, splitting on `i = j`, then rewrites by `Matrix.diagonal_pow` and `Matrix.trace_diagonal`. Matches.
- **Breaking object sought.** A matrix with zero off-diagonal whose power has off-diagonal mass: impossible, diagonal matrices are closed under products. No hypothesis beyond the off-diagonal zeros is used, and none is needed.

## 2. `L52_matrix_if`

- **By hand.** With `Σ A_ii^k = tr A^k = Σ μ^k` for `k = 2, 3`, and the same for `B`, the right side becomes `(3/2)(Σμ³ + 3M₊(1 − Σμ²)) − (1/2)(Σω³ + 3m(Σω² − 3))`, and `Σμ² = 1`, `Σω² = 3` kill both correction terms. It equals the left side for every `M₊` and `m`.
- **The Lean** ([L52Equality.lean:122-133](../lean/HamiltonsCubic/Results/L52Equality.lean#L122)) builds `a2, a3, b2, b3` as `trace_pow_diag` composed with `SecondKind.trace_pow_eq_sum_eigenvalues`, rewrites, substitutes `hμ2`, `hω2`, and closes by `ring`. Matches.
- **Faithfulness.** The statement is `L52_matrix_eq_frame`'s hypothesis `heq` verbatim ([L52Equality.lean:102-104](../lean/HamiltonsCubic/Results/L52Equality.lean#L102)) as the conclusion, with the off-diagonal zeros that `L52_matrix_eq_frame` concludes as the hypotheses. So the two theorems are exact converses on the matrices, under the unit-norm hypotheses. It drops `hμ`, `hω`, correctly, since the "if" half needs no spectral bound. This is the matrix-level "if" half, and the record's "if" half at its objects is a further step (G4).
- **Breaking object sought.** A diagonal pair at which the display is strict. None: the identity holds for every diagonal matrix and every `M₊`, `m`. The record's staircase counterexample is a pair whose `Bw w` is not diagonal, which lies outside this theorem's hypothesis.

## 3. The header and row sweep

Grep for `Karamata`, `not built`, `Not typed`, `owed` over `L52*.lean`, `CubicConvexity.lean`, `DoublyStochastic*.lean`, and the L52 row, and `git log -S "equality case of Karamata" -- findings/bispectral.md`.

- **Repaired.** [L52Bound.lean:24-26](../lean/HamiltonsCubic/Results/L52Bound.lean#L24) now names `L52_record`, `L52_record_S20` and L52Equality.lean. [DoublyStochasticEq.lean:8-10](../lean/HamiltonsCubic/Results/DoublyStochasticEq.lean#L8) paraphrases, outside quotation marks, and agrees with the record's "only if" bullet ([bispectral.md:84](../findings/bispectral.md#L84)). The old "Karamata … stays owed" in CubicConvexity.lean is gone. No `L52*.lean` file says "not built".
- **G1, the removed sentence is still quoted.** [CubicConvexity.lean:11-12](../lean/HamiltonsCubic/Results/CubicConvexity.lean#L11) reads *"[L52](L52.lean)'s equality case rests on "strict convexity of `t³ + 3mt²` and the equality case of Karamata""*, and [DoublyStochastic.lean:10-11](../lean/HamiltonsCubic/Results/DoublyStochastic.lean#L10) quotes the same phrase. The record has not carried it since 8239c6a7 (2026-09-07), and L52.lean does not contain it (its only match for "equality" is line 17). The record now says the argument needs strict convexity of `t³+3mt²` and strict concavity of `t³−3M₊t²` on the closed ranges. The commit message's G4/G5 bullet says CubicConvexity's header no longer quotes the removed Karamata claim, and line 11-12 is that quotation. The edited line 12-13 then contradicts the quotation it follows.
- **G2, a paraphrase under "quoted verbatim".** [L52Statement.lean:8](../lean/HamiltonsCubic/Results/L52Statement.lean#L8) heads the block "quoted verbatim", and the new bullet at [L52Statement.lean:38-39](../lean/HamiltonsCubic/Results/L52Statement.lean#L38) ("follows row by row: Jensen's equality makes the variable constant on each row's support …") is not the record's wording, which is "follows row by row, by counting, and needs two strictnesses rather than one" ([bispectral.md:84](../findings/bispectral.md#L84)). In the same block, [L52Statement.lean:32-33](../lean/HamiltonsCubic/Results/L52Statement.lean#L32) quotes "*What is imported is the double stochasticity, and Schur's theorem, for which references/ holds no entry*", where the record now says both are proved and kernel-checked in SchurMajor.lean ([bispectral.md:79](../findings/bispectral.md#L79)). The latter predates this commit.
- **G3, the "NOT typed" section.** [L52Statement.lean:66-69](../lean/HamiltonsCubic/Results/L52Statement.lean#L66) says `W̊` is an operator "the Lean layer does not carry", while L52Frame.lean carries it as `Bw w (ringW R)` with `Bw_diag_pair` giving the dictionary's second identity at the pair entries. [L52Statement.lean:71-73](../lean/HamiltonsCubic/Results/L52Statement.lean#L71) points only to `L52_matrix_eq` and omits `L52_matrix_eq_frame` and `L52_matrix_if`, which this commit adds. Both predate the commit except the omission of `L52_matrix_if`.

## 4. The Owed clause ([lean/INDEX.md:383](../lean/INDEX.md#L383))

- **Accurate for the rewriting.** The declarations it names are exactly what `L52_record` ([L52Frame.lean:257-270](../lean/HamiltonsCubic/Results/L52Frame.lean#L257)) uses: `L50Spectra.L50_bispectral`, `sum_mu_cube`, `sum_mu_sq`, `sum_omega_w_cube`, `sum_omega_w_sq`, `Mpair_isHermitian` (L54Schur.lean:39), `Bw_isHermitian` (L52Frame.lean:207). Each exists under that name. `L52_record` takes `M₊`, `m` as any constants with the spectral bounds, as the record's conventions do, so no bound declaration is missing. "At any complete `w`" is right: neither `L52_matrix_eq_frame` nor `L52_matrix_if` constrains `w`.
- **G4, the ψ step is located but not named.** Instantiated as listed, `L52_matrix_if` gives "`Mpair R` diagonal and `Bw w (ringW R)` diagonal imply equality". The record's "if" half has the hypothesis "both operators diagonal in one shared frame" with the ψ stipulation, and the passage from that to "`Bw w (ringW R)` diagonal" is what the stipulation buys: `w` an eigenbasis of `K` makes the ψ-block's off-diagonal entries `−w_kᵀKw_l` vanish (`diag_block`, L54Basis.lean:108), and the φ–ψ cross block must vanish too, at a `W` whose pair matrix is diagonal. The clause says "the ψ stipulation enters there" and names no declaration or statement for that step. Likewise "equality itself forces `w` to diagonalise `K`" is asserted with r1666 as the source and no declaration (it is `diag_block` at `u = w_k`, `v = w_l` read off `L52_matrix_eq_frame`'s conclusion). The clause is accurate and is incomplete by that one named step.

## 5. What was run

- `lake env lean HamiltonsCubic/Results/L52Equality.lean`: exit 0, no errors, no warnings. `python3 scripts/misc/axiom_audit.py --only L52Equality.lean`: 5/5 clean, standard three. Both from a script, started after `pgrep` showed no lake process (the first attempt found r1667's run active and waited). A screen for axioms and compilation. The mathematics was checked by hand above.

## 6. Commit hygiene

- 1b2e4f24 also carries lean/HamiltonsCubic/Results/L274.lean, findings/second-order.md, plan-lean.md, STATUS.md and a second INDEX hunk from a concurrent session. Out of scope here. The commit message names none of them.

## 7. Gaps

- **G1, [CubicConvexity.lean:11-12](../lean/HamiltonsCubic/Results/CubicConvexity.lean#L11) and [DoublyStochastic.lean:10-11](../lean/HamiltonsCubic/Results/DoublyStochastic.lean#L10).** Quote *"strict convexity of `t³ + 3mt²` and the equality case of Karamata"*, removed from the record at 8239c6a7 and absent from L52.lean. The commit message says CubicConvexity no longer quotes it.
- **G2, [L52Statement.lean:38-39](../lean/HamiltonsCubic/Results/L52Statement.lean#L38) and [L52Statement.lean:32-33](../lean/HamiltonsCubic/Results/L52Statement.lean#L32).** Under "quoted verbatim" (line 8), a paraphrase of the record's "only if" bullet and a stale italic sentence on SchurMajor.
- **G3, [L52Statement.lean:66-73](../lean/HamiltonsCubic/Results/L52Statement.lean#L66).** "The Lean layer does not carry" `W̊`, against L52Frame's `Bw`, and the equality pointer omits `L52_matrix_eq_frame` and `L52_matrix_if`.
- **G4, [lean/INDEX.md:383](../lean/INDEX.md#L383), Owed clause.** Names no statement for the ψ step (the record's shared-frame hypothesis with `w` an eigenbasis of `K` gives `Bw w (ringW R)` diagonal), and no declaration for "equality forces `w` to diagonalise `K`" (`diag_block`).
- **G5, commit message of 1b2e4f24.** Does not name the swept files L274.lean, second-order.md, plan-lean.md, STATUS.md.

## 8. Breaking objects sought

- For 1: a zero-off-diagonal matrix whose power has off-diagonal mass. None exists.
- For 2: a diagonal pair with the unit-norm spectra at which the display is strict. None, by the trace identity at every `M₊`, `m`.
- For 5: any header line still quoting or asserting the removed Karamata sentence, "not built" or "not typed" against a typed object. Found at G1, G2, G3.
- For 7: an object in the record's "if" half the named declarations do not reach. Found: the ψ step (G4).
