# REVIEW r1666: L52's "only if" half at the matrices (2612bbe5)

**Verdict: CONFIRMED WITH GAPS.** The mathematics of [L52Equality.lean](../lean/HamiltonsCubic/Results/L52Equality.lean) and of the two new CubicConvexity lemmas is correct: equality in `L52_matrix_bound`'s display forces both Jensen steps tight, `eq_multiset` turns each into a rearrangement, and the Frobenius identity then kills every off-diagonal entry. The file compiles and the audit is 3/3 and 7/7 on the standard three. The gaps are in the text around it: the Owed clause misplaces the ψ stipulation (the "if" half at the matrices needs none and is a few lines), three headers still say the equality clause is owed to Karamata or is untyped, and r1661 G3 is only half repaired.

| # | claim | verdict |
| --- | --- | --- |
| 1 | `strictConvexOn_g` on `[−m, ∞)` and `strictConcaveOn_h` on `(−∞, M]`, endpoints included | **CONFIRMED** |
| 2 | `L52_matrix_eq`: display equality splits into two tight Jensen steps, each a rearrangement by `eq_multiset` (the concave side through `−h`) | **CONFIRMED** |
| 3 | `offDiag_zero_of_diag_spectrum`: diagonal equal to the spectrum as a multiset forces a real symmetric matrix diagonal | **CONFIRMED** |
| 4 | `L52_matrix_eq_frame` is the record's "only if" conclusion at the matrix level | **CONFIRMED WITH GAP** (G3: "shared" is supplied only at the instantiation) |
| 5 | the Owed clause | **CONFIRMED WITH GAPS** (G1: the "if" half at the matrices is ψ-free, G2: the passage is one short declaration at any complete `w`) |
| 6 | r1661 G1, G3, G4 repaired, G2 and the shared-frame wording handled by c92f8c83 and 42ecf897 | **CONFIRMED WITH GAPS** (G4: CubicConvexity.lean:12-13 still says Karamata stays owed, G5: L52Bound.lean:24-26 and L52Statement.lean:36-42 stale) |
| 7 | axiom audit, L52Equality.lean and CubicConvexity.lean | **CONFIRMED** (3/3 and 7/7, one lint warning, G6) |

**Summary:** the "only if" half is correctly proved at the matrices with no Karamata, and the remaining defects are an Owed clause that credits the ψ stipulation to the wrong half of the work and three headers that still describe the pre-commit state.

## 1. `strictConvexOn_g`, `strictConcaveOn_h`

- **By hand.** `gap_factors` gives `a·g(x) + b·g(y) − g(ax + by) = ab(x−y)²·F` with `F = (x+m) + (y+m) + (a(x+m) + b(y+m))` when `a + b = 1`. For `x, y ≥ −m` every term of `F` is `≥ 0`, and `x ≠ y` leaves at most one of `x, y` at `−m`, so the other contributes a positive term and `F > 0`. With `a, b > 0` (the `StrictConvexOn` weights are strict) and `(x−y)² > 0` the gap is positive. At `x = −m < y` the factor is `(1 + b)(y + m) > 0`.
- **The Lean** ([CubicConvexity.lean:94-112](../lean/HamiltonsCubic/Results/CubicConvexity.lean#L94)) splits on `x = −m` versus `x > −m`, derives `y > −m` from `x ≠ y` in the first case, and closes by `nlinarith` with the two nonnegative products. Matches.
- **Concave side.** `−g_M(−t) = −(−t³ + 3Mt²) = t³ − 3Mt²`, and `t ≤ M` iff `−t ∈ [−M, ∞)`. The Lean ([CubicConvexity.lean:115-123](../lean/HamiltonsCubic/Results/CubicConvexity.lean#L115)) applies `hg.2` at `−x, −y` and closes linearly, since `a(−x) + b(−y) = −(ax + by)`. Correct.
- **Breaking object sought.** A pair `x ≠ y` in the closed range with zero gap: needs `F = 0`, so `x = y = −m`, excluded. Any real `m` (including negative) is covered, nothing uses a sign of `m`.

## 2. `L52_matrix_eq`

- **The split.** With `K = Pμ`, `K' = Qω` from `diag_doublyStochastic`, the concave step is `Σ h(μ) ≤ Σ h(K)`, that is `Σμ³ − 3M₊ ≤ ΣK³ − 3M₊ΣK²` after `Σμ² = 1`, and the convex step is `ΣK'³ + 3mΣK'² ≤ Σω³ + 9m` after `Σω² = 3`. The display's right side minus its left side is exactly `(3/2)·s₁ + (1/2)·s₂` with `s₁, s₂ ≥ 0` the two slacks. Equality forces both zero, positive weights. The Lean's `e1`, `e2` ([L52Equality.lean:39-56](../lean/HamiltonsCubic/Results/L52Equality.lean#L39)) derive each by `nlinarith` from `h1`, `h2`, `heq`, which is this linear combination.
- **`eq_multiset` applications.** For `A`: `−h` is `StrictConvexOn (Iic M₊)` from `strictConcaveOn_h.neg`, the spectrum lies in `Iic M₊` by `hμ`, and `e1'` is `e1` negated termwise. The conclusion's `Σ_j PA i j • μ_j` is rewritten to `A i i` by `← hdA`. For `B`: `strictConvexOn_g m` directly on `Ici (−m)`. Both correct.
- **`heq` is `L52_matrix_bound`'s display verbatim** ([L52Bound.lean:87-89](../lean/HamiltonsCubic/Results/L52Bound.lean#L87)), with `≤` replaced by `=`. So the theorem is the converse of the bound it sits beside.
- **Breaking object sought.** Display equality with one slack negative and the other positive: impossible, both are Jensen gaps. Non-vacuity: any diagonal `A`, `B` with the spectral bounds attain equality (see G1), so the hypothesis is satisfiable.

## 3. `offDiag_zero_of_diag_spectrum`

- **Symmetry.** `hA : Aᴴ = A` over ℝ, so `congrFun (congrFun hA a) b` reads `star (A b a) = A a b`, and `star` is the identity on ℝ. `hs a b : A b a = A a b`. Correct.
- **Frobenius.** `tr(A²) = Σ_a Σ_b A_ab A_ba = Σ_a Σ_b A_ab²` by `hs`, and `trace_pow_eq_sum_eigenvalues` at exponent 2 gives `Σ λ²`. The multiset hypothesis mapped by `x ↦ x²` and summed gives `Σ A_aa² = Σ λ²`. Subtracting leaves `Σ_a Σ_{b≠a} A_ab² = 0`, a sum of nonnegatives, so each term vanishes. Sound, and it uses only `Σ K² = Σ μ²`, weaker than the multiset equality.

## 4. `L52_matrix_eq_frame` against the record

- [findings/bispectral.md, Lemma L52](../findings/bispectral.md), the "only if" bullet, and [results.md:1177](../results.md#L1177): exactness makes `K` a rearrangement of `μ`, then `Σ K² = Σ μ² = ‖M‖²_F` kills the off-diagonal entries. `L52_matrix_eq_frame` concludes both matrices diagonal, which is that conclusion for `A` and `B` read in their given bases.
- **What "shared" means is supplied elsewhere.** At the matrices `A` and `B` are unrelated, and the frame is shared only because `Mpair` and `Bw w` are both built from the frame `e` (G3). The docstring's "the record's shared frame" is fair once the instantiation exists and overstates before it.

## 5. The Owed clause

- **The "if" half at the matrices needs no ψ stipulation (G1).** If `A` and `B` are diagonal then `Σ A_ii^k = tr A^k = Σ μ^k` for `k = 2, 3` (`trace_pow_eq_sum_eigenvalues`), so `Σ A_ii² = 1`, `Σ B_ii² = 3` and the display's right side equals its left side identically. This is a few lines on declarations already in hand. The ψ stipulation enters only at the record's objects, where "both operators diagonal in the frame" must be read as `Bw w` diagonal, with `w` an eigenbasis of `K` (the record's staircase counterexample is `W̊` diagonal on the φ-block with the ψ-block not diagonal). The clause attributes the ψ dependence to the half, where it belongs to the passage.
- **The passage is near (G2).** `L52_record` ([L52Frame.lean:257](../lean/HamiltonsCubic/Results/L52Frame.lean#L257)) already rewrites `Pcubic R` to `(3/2)Σμ³ − (1/2)Σω³` and supplies `Σμ² = 1`, `Σω² = 3`. An `L52_record_eq_frame` taking `Pcubic R = RHS` would need exactly: `L50Spectra.L50_bispectral`, `sum_mu_cube`, `sum_omega_w_cube`, `sum_mu_sq`, `sum_omega_w_sq`, `Mpair_isHermitian`, `Bw_isHermitian`, and then `L52_matrix_eq_frame` at `(Mpair R, Bw w (ringW R))`. **It holds at every complete `w`, not only at the ψ-stipulated one**, and its conclusion makes the ψ-block off-diagonal entries `−w_kᵀ K w_l` vanish (`diag_block` at `u = w_k`, `v = w_l`, as `Bw_diag_psi` uses it at `k = l`), so equality itself forces `w` to diagonalise `K`. The S²₀ reading would compose further through `L52_record_S20`'s `ringW_spectrum_split` and `sum_diag_split` ([L52S20.lean:110](../lean/HamiltonsCubic/Results/L52S20.lean#L110)) at `wK`, `wK_complete`. The clause's "in the ψ-stipulated basis" is therefore more restrictive than needed.

## 6. r1661's gaps

- **G1 (Frobenius step) repaired**, by `offDiag_zero_of_diag_spectrum`.
- **G2 (results.md:1177) handled by 42ecf897.** The entry now states the counting argument and the Frobenius line, no Karamata. bispectral.md's "only if" bullet carries both since c92f8c83 and 42ecf897. The record's wording closes on "every off-diagonal entry of `M`" and leaves `W̊` implicit, a minor asymmetry outside this commit.
- **G3 half repaired (G4 here).** The owed sentence at CubicConvexity.lean's old lines 26-27 is gone and lines 27-28 now say the equality clause uses no Karamata, but [CubicConvexity.lean:12-13](../lean/HamiltonsCubic/Results/CubicConvexity.lean#L12) in the same header still reads "Karamata is not in Mathlib and stays owed". The commit message says CubicConvexity's header no longer says this.
- **G4 repaired** at [DoublyStochastic.lean:12-13](../lean/HamiltonsCubic/Results/DoublyStochastic.lean#L12) and [L52Statement.lean:73-75](../lean/HamiltonsCubic/Results/L52Statement.lean#L73).
- **Stale text outside r1661's list (G5).** [L52Bound.lean:24-26](../lean/HamiltonsCubic/Results/L52Bound.lean#L24) still says the instantiation "is not built" (it is `L52_record` and `L52_record_S20`) and that the equality clause "the block itself says needs Karamata". [L52Statement.lean:36-42](../lean/HamiltonsCubic/Results/L52Statement.lean#L36) quotes the record's "only if" bullet as "does need Karamata … The conclusion survives via Karamata", text the record no longer carries, and the header's line 74 now contradicts its own quotation. [DoublyStochasticEq.lean:8-11](../lean/HamiltonsCubic/Results/DoublyStochasticEq.lean#L8) quotes the same removed sentence in the present tense.

## 7. What was run

- `python3 scripts/misc/axiom_audit.py --only L52Equality`: 3/3 clean, standard three. `--only CubicConvexity`: 7/7 clean, standard three. A screen for axioms. The mathematics was checked by hand above.
- `lake env lean HamiltonsCubic/Results/L52Equality.lean`: no errors, one warning (G6). Both runs backgrounded from a script after `pgrep` found no lake process.

## 8. Gaps

- **G1, [lean/INDEX.md:383](../lean/INDEX.md#L383), Owed clause.** The "if" half at the matrices is ψ-free and cheap (diagonal gives `Σ A_ii^k = tr A^k`), so it can be typed now. The ψ stipulation belongs to the passage to the record's objects.
- **G2, [lean/INDEX.md:383](../lean/INDEX.md#L383), Owed clause.** The passage should name its declarations (`L50_bispectral`, `sum_mu_cube`, `sum_omega_w_cube`, `sum_mu_sq`, `sum_omega_w_sq`, then `L52_record_S20`'s splits for S²₀) and holds at any complete `w`, with equality forcing `w` to diagonalise `K`.
- **G3, [L52Equality.lean:95](../lean/HamiltonsCubic/Results/L52Equality.lean#L95) and [L52Equality.lean:17](../lean/HamiltonsCubic/Results/L52Equality.lean#L17).** "The record's shared frame" at two unrelated matrices. Shared only after the instantiation.
- **G4, [CubicConvexity.lean:12-13](../lean/HamiltonsCubic/Results/CubicConvexity.lean#L12).** "Karamata … stays owed", contradicted by lines 27-28 of the same header. r1661 G3 half repaired.
- **G5, [L52Bound.lean:24-26](../lean/HamiltonsCubic/Results/L52Bound.lean#L24), [L52Statement.lean:36-42](../lean/HamiltonsCubic/Results/L52Statement.lean#L36), [DoublyStochasticEq.lean:8-11](../lean/HamiltonsCubic/Results/DoublyStochasticEq.lean#L8).** Stale "not built", "needs Karamata" and quotations of the removed record sentence.
- **G6, [L52Equality.lean:56](../lean/HamiltonsCubic/Results/L52Equality.lean#L56).** Lint: `h` is an unused simp argument in `simp only [← hdA, h, …] at h1'`.

## 9. Breaking objects sought

- For 1: a pair at the endpoint `−m` with zero gap. Needs `x = y = −m`, excluded.
- For 2: display equality with slacks of opposite sign. Both are Jensen gaps, nonnegative.
- For 3: a symmetric `A` with `Σ A_ii² = Σ λ²` and a nonzero off-diagonal entry. The Frobenius identity forbids it.
- For 5: a diagonal pair at which the display is strict, which would make the matrix-level "if" half need a stipulation. None, the identity `Σ A_ii^k = tr A^k` holds for every diagonal matrix.
