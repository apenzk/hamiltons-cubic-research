# REVIEW r1661: DoublyStochasticEq (6e6d27f4) and r1660's repairs (f32ad8ff)

**Verdict: CONFIRMED WITH GAPS.** [DoublyStochasticEq.lean](../lean/HamiltonsCubic/Results/DoublyStochasticEq.lean) is correct: at equality in the doubly stochastic Jensen bound with a strictly convex `g`, the diagonal and the spectrum are the same multiset, whatever the zero pattern of `P` and however degenerate the spectrum. The record's "the 'only if' half does need Karamata" is refuted as a claim about what the argument needs, so the row's statement is fair. The gaps: `eq_multiset` delivers the rearrangement, while the record's "only if" conclusion is the shared frame (both operators diagonal in the basis), which needs one more step (the Frobenius identity) that neither the Lean nor the owed list names, and four downstream texts still attribute the converse to Karamata. f32ad8ff repairs r1660 G1 to G3. The axiom audit is 3/3 on the standard three.

| # | claim | verdict |
| --- | --- | --- |
| 1 | `rowwise_const`: at equality, `K_i = μ_j` wherever `P_ij ≠ 0` | **CONFIRMED** |
| 2 | `eq_rearrangement`: the rows with `K_i = v` and the columns with `μ_j = v` carry the same mass, so equal counts | **CONFIRMED** |
| 3 | `eq_multiset`: diagonal and spectrum are the same multiset, the right formal form of "rearrangement" | **CONFIRMED** |
| 4 | the INDEX row: the record's "only if half does need Karamata" is false as a claim about what the argument needs | **CONFIRMED WITH GAPS** (G1: the record's conclusion is the shared frame, one Frobenius step past the rearrangement; G2 to G4: stale downstream text) |
| 5 | the owed item: strict convexity on the closed ranges and the total equality split | **CONFIRMED WITH GAP** (G1: the Frobenius step is missing from it) |
| 6 | f32ad8ff repairs r1660 G1 to G3 | **CONFIRMED** |
| 7 | axiom audit of DoublyStochasticEq.lean | **CONFIRMED** (3/3, standard three) |

**Summary:** the "only if" half needs no Karamata and the Lean proves the rearrangement correctly, with the passage from rearrangement to the record's shared frame unnamed and four texts still crediting Karamata.

## 1. `rowwise_const`

- **Hypotheses.** `hg : StrictConvexOn ℝ s g` carries `Convex s`, `hμ` puts every `μ_j` in `s`. Jensen's `map_sum_le` (through `hg.convexOn`) bounds each row, `sum_collapses` turns `heq` into `Σ_i g(K_i) = Σ_i Σ_j P_ij g(μ_j)`, and `Finset.sum_eq_sum_iff_of_le` makes every row tight.
- **The Mathlib lemma.** [Jensen.lean:197](../lean/.lake/packages/mathlib/Mathlib/Analysis/Convex/Jensen.lean#L197): `StrictConvexOn.map_sum_eq_iff_of_nonneg` concludes `∀ j ∈ t, w j ≠ 0 → ∀ k ∈ t, w k ≠ 0 → p j = p k`. The call `hc (mem_univ k) hk (mem_univ j) hij` gives `μ_k = μ_j` for every `k` in row `i`'s support, so `K_i = Σ_k P_ik μ_j = μ_j` by the row sum. Correct.
- **By hand.** Strict Jensen equality with nonnegative weights summing to 1 forces the points on the positive-weight set to coincide. Standard, and exactly what the lemma states.
- **Breaking object sought.** A row whose support meets two distinct eigenvalues at equality. Impossible under strict convexity on a set holding both. With `g` merely convex (affine piece) the lemma fails, and the hypothesis demands strictness. Correct.

## 2. `eq_rearrangement`

- **The argument.** Let `R_v = {i : K_i = v}`, `C_v = {j : μ_j = v}`. For `i ∈ R_v` and `P_ij ≠ 0`, `μ_j = K_i = v`, so row `i` has all its mass in `C_v` and `|R_v| = Σ_{R_v×C_v} P`. For `j ∈ C_v` and `P_ij ≠ 0`, `K_i = μ_j = v`, so column `j` receives mass only from `R_v` and `|C_v| = Σ_{C_v×R_v} P`. `Finset.sum_comm` closes. Every step checked by hand and against [DoublyStochasticEq.lean:54-75](../lean/HamiltonsCubic/Results/DoublyStochasticEq.lean#L54).
- **Repeated eigenvalue, rotation in the eigenplane.** `μ = (1,1,2)`, `U` a `π/4` rotation in the first plane: `P = [[½,½,0],[½,½,0],[0,0,1]]`, `K = (1,1,2)`. Rows 1, 2 have support `{1,2}` on which `μ ≡ 1`. `R_1 = C_1 = {1,2}`, mass 2. Counts agree, `P` is no permutation. Consistent.
- **Zero entries.** Zero entries only shrink supports, and the argument uses the support in both directions. A column `j ∈ C_v` with all mass from rows outside `R_v` would need `K_i = v` on those rows, contradiction. No failure.
- **Breaking object sought.** A doubly stochastic `P` with every row tight and `K` not a rearrangement of `μ`. The two-sided mass identity rules it out for every `v`, including values `v` taken by neither (both counts 0). None exists.

## 3. `eq_multiset`

- `Multiset.count_map` turns both sides into filtered cardinalities over `univ.val`, `Finset.card_def` and `filter_val` match `eq_rearrangement`, and `eq_comm` aligns the predicates. Correct.
- **Right form.** Equality of `Multiset.map K univ.val` and `Multiset.map μ univ.val` is equivalent to equality of the sorted vectors, since the sorted list is a function of the multiset. It is the right formal form of "the diagonal is a rearrangement of the spectrum", and the form Karamata's equality case delivers.

## 4. The claim against the record

- **The record at 6e6d27f4** ([bispectral.md, Lemma L52](../findings/bispectral.md)): "the 'only if' half does need Karamata … The row-by-row argument does not deliver it … The conclusion survives via Karamata." What Karamata's equality case delivers is `K` a rearrangement of `μ` (and `K'` of `ω`). `eq_multiset` delivers the same thing from the doubly stochastic structure alone, so "needs Karamata" is false as a claim about what the argument needs. The row's statement is fair. The record's accompanying observation (a row-tight `U` need not be a permutation) stays true, and the file's header says so.
- **The record's conclusion is stronger than the rearrangement.** [results.md:1177](../results.md#L1177) states the converse as "exactness forces the shared frame", and [bispectral.md:55](../findings/bispectral.md#L55) as "exact iff both operators are diagonal in one shared frame". Rearrangement gives it in one step: `Σ K_i² = Σ μ_i² = ‖M‖_F²` forces every off-diagonal entry of `M` in the pair basis to vanish, and likewise for `W̊` in `{φ, ψ}`. That step is short, and it is the same step Karamata's route would need, so it does not revive the Karamata claim. It is named nowhere (G1).
- **Since the commit.** c92f8c83 (research session, outside this review's scope) rewrote the record's bullet to the counting argument, so the record no longer says Karamata is needed. It too stops at "`K` is a rearrangement of `μ`", and results.md:1177 still credits Karamata (G2).

## 5. The owed item

- **Strict convexity of `g(t) = t³ + 3mt²` on `[−m, ∞)`, endpoint included: TRUE, for every real `m`.** `g''(t) = 6(t + m)` is positive on `(−m, ∞)` and zero only at `−m`, so `g'` is strictly increasing on `[−m, ∞)` and `g` strictly convex there. Algebraically, from `gap_factors`, the gap is `ab(x−y)²((x+m)+(y+m)+(a(x+m)+b(y+m)))`, and at `x = −m ≠ y` the factor is `(1+b)(y+m) > 0`. Likewise `t³ − 3M₊t²` is `−g_{M₊}(−t)` and strictly concave on `(−∞, M₊]`.
- **The owed wording is accurate at 6e6d27f4**: CubicConvexity's `strict_convex` takes `−m < x, −m < y`, so it is pointwise on the open range and no `StrictConvexOn` existed. The concave side goes through `eq_multiset` applied to `−h`, which the owed item's `StrictConcaveOn` covers. The total equality does split, since the display is the sum of two Jensen inequalities each `≤`, so equality forces both, which is the record's "two strictnesses".
- The working tree carries uncommitted `strictConvexOn_g` and `strictConcaveOn_h` in CubicConvexity.lean from another thread. Not reviewed here.
- **Missing from the owed list**: the Frobenius step from rearrangement to diagonal (G1).

## 6. f32ad8ff against r1660

- **G1 repaired.** [L54Diag.lean:26-27](../lean/HamiltonsCubic/Results/L54Diag.lean#L26) now points to `L54_majorizes_S20_sub` (declared at [L54Converse.lean:96](../lean/HamiltonsCubic/Results/L54Converse.lean#L96)).
- **G2 repaired.** [L54Schur.lean:17-18](../lean/HamiltonsCubic/Results/L54Schur.lean#L17) cites `L54_omega_majorizes` ([L54Rigid.lean:71](../lean/HamiltonsCubic/Results/L54Rigid.lean#L71)) and `L54_majorizes_S20_sub`. No "Not typed" remains in either header.
- **G3 repaired.** The L54 row reads "on $S^2$, and on $S^2_0$ in one step from `dpsi_split`, whose extra entry is $0$". All cited names exist.

## 7. Axiom audit

- `python3 scripts/misc/axiom_audit.py --only DoublyStochasticEq`: "auditing 3 declarations across 1 files … 3/3 clean, resting on the standard three alone". A screen: it confirms the axioms, and the mathematics above was checked by hand. No `sorry`, `admit` or `native_decide` in the file.

## 8. Gaps

- **G1, [lean/INDEX.md:381](../lean/INDEX.md#L381), L52 row's Owed list, and [DoublyStochasticEq.lean:18](../lean/HamiltonsCubic/Results/DoublyStochasticEq.lean#L18).** The record's "only if" conclusion is the shared frame (both operators diagonal in the basis), and `eq_multiset` stops at the rearrangement. The passage, `Σ K² = Σ μ² = ‖M‖²_F` so the off-diagonal entries vanish (and the same for `K'`, `ω`, `W̊`), belongs in the Owed list.
- **G2, [results.md:1177](../results.md#L1177).** Still reads "The converse … holds by Karamata's equality case … the row-by-row Jensen argument does not give it". Contradicted by `eq_multiset` and by the record's own bullet since c92f8c83.
- **G3, [CubicConvexity.lean:26-27](../lean/HamiltonsCubic/Results/CubicConvexity.lean#L26).** "What stays owed is Karamata itself and its equality case" is stale since 6e6d27f4.
- **G4, [DoublyStochastic.lean:12-13](../lean/HamiltonsCubic/Results/DoublyStochastic.lean#L12) and [L52Statement.lean:73-75](../lean/HamiltonsCubic/Results/L52Statement.lean#L73).** Both attribute to the record the view that the "only if" half keeps Karamata. Accurate as a quotation at 6e6d27f4, stale since c92f8c83. DoublyStochastic.lean's own lines 27-29 in the same header now say the opposite.

## 9. What was run

- One axiom audit, backgrounded after `pgrep` (run from a script file) found no lake process, reported as a screen.
- Everything else is by hand: the Lean proofs read line by line against the Mathlib signature at Jensen.lean:197, the worked `μ = (1,1,2)` rotation example, and the endpoint check of `g`.
