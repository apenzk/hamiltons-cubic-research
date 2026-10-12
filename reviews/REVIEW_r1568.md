# Review r1568: L20's radius as arcsin s* (commit 96720454) and L49, L56 moved to proved (commit 0a4349a6)

**Standfirst.** [L20Arcsin.lean](../lean/HamiltonsCubic/Results/L20Arcsin.lean) proves three correct statements: the record's expansion step, and for every s in (0, 1) that cos(arcsin s) + sin(arcsin s)³ = 1 exactly when s³ + s² + s − 1 = 0. That is the level-set identification the tube-radius row owed, and it is faithful to [route-a.md](../findings/route-a.md#L103)'s Lemma L20. It is a statement about every s, and the real root s* it is read at is constructed in no Lean file: [TubeRadius.lean](../lean/HamiltonsCubic/Results/TubeRadius.lean) works over ℚ, where it proves the cubic has no root at all. The L49 move is right in substance, with the typed theorem carrying N ≥ 4 where the record says N ≥ 3. The L56 move rests on "the untyped items are the refuted values", and the canon's multi-block clause is untyped and unrefuted. Everything builds on the standard three axioms.

| # | claim | verdict |
| --- | --- | --- |
| A-1a | `psi_one_iff_cubic` and `radius_is_arcsin` identify ψ(φ) = 1 with the cubic at φ = arcsin s, s ∈ (0, 1) | **CONFIRMED** |
| A-1b | ψ(φ) = 1 is cos φ + sin³ φ = 1 on the range used | **CONFIRMED** (1 − sin³ φ > 0 for s < 1, and s > 0 excludes the crossing at φ = 0) |
| A-1c | the radius is arcsin s* with s* TubeRadius's cubic root | **CONFIRMED WITH GAP** (s* exists and is unique over ℝ in no Lean file, and the exact reduction ψ ≤ 1 ⟺ sin φ ≤ s* is typed only below 0.54368) |
| A-1d | `expansion_step` is the record's step | **CONFIRMED** |
| A-1e | the tube-radius row moves to proved, α ≤ 1/3 named as the lemma's imported input | **CONFIRMED WITH GAP** (α ≤ 1/3 is correctly outside the radius row, the row's "so the radius is arcsin s*" leans on gap A-1c, and two headers now contradict it) |
| A-1f | the L20 statement row agrees | **CONFIRMED** (it does not mention L20Arcsin, and its file's header over-claims, pre-existing) |
| A-2a | L49's owed dimension theorem is `collapse_space_is_the_constants` | **CONFIRMED WITH GAP** (exactly the characterisation, but at N ≥ 4 against the record's N ≥ 3) |
| A-2b | the 𝔰𝔬(n) non-realisation clause is one the record marks unproved | **CONFIRMED** (target.md lists it as open (ii), "not consequences of this lemma") |
| A-2c | L56's untyped items are only values the record refutes | **REFUTED** (the canon's multi-block interleaving clause is untyped and unrefuted) |
| A-2d | L56Statement proves the corrected closed forms the block states | **CONFIRMED** (the p < q form, the floor, 1/252, 1/660, CPᵐ against the floor, with the balanced display taken as a definition) |
| A-2e | INDEX-results row 49 reads Lean: proved | **CONFIRMED WITH GAP** (follows A-2a) |
| B | builds, standard three axioms, no sorry, admit or native_decide | **CONFIRMED** |
| C | no downstream text still calls these items owed or partial | **CONFIRMED WITH GAP** (TubeRadius.lean:20 and :94 still say φ = arcsin s* is not settled) |
| D | style of the markdown edits | **CONFIRMED WITH GAP** (one clause splice carried on the edited L20 row) |

**Summary:** the new Lean is correct and faithful, and each of the three moves to proved overstates by one named item: the real root s* over ℝ for L20, N = 3 for L49, the multi-block clause for L56.

## 1. L20, the radius and the expansion step

- **The record.** [route-a.md:103](../findings/route-a.md#L103), Lemma L20: *"m ≤ cos φ + m sin³ φ, i.e. m ≤ ψ(φ) := cos φ/(1 − sin³ φ)"*, and *"The reduction is exact: ... ψ ≤ 1 is 1 − s² ≤ (1 − s³)², that is s²(1 − s)(1 − s − s² − s³) ≥ 0, which for 0 ≤ s < 1 is s ≤ s* with s* the real root of s³ + s² + s = 1, unique because 3s² + 2s + 1 > 0"*, and *"ψ ... first exceeds 1 at φ = 0.5748263"*.
- **`expansion_step`** ([L20Arcsin.lean:23](../lean/HamiltonsCubic/Results/L20Arcsin.lean#L23)). Hypotheses cos φ, sin φ ≥ 0, the exact expansion, α ≤ 1/3, γ ≤ m. Conclusion m ≤ cos φ + m sin³ φ. This is the record's step verbatim, with nonnegativity standing for φ ∈ [0, 0.5748]. The proof is the one [max_le_one_of_sin_le](../lean/HamiltonsCubic/Results/L20Statement.lean#L103) carries inline as `hstep`, duplicated, which the commit message says. Correct.
- **`psi_one_iff_cubic`** ([L20Arcsin.lean:38](../lean/HamiltonsCubic/Results/L20Arcsin.lean#L38)). For 0 < s < 1, √(1 − s²) + s³ = 1 ⟺ s³ + s² + s − 1 = 0. Forward: square, factor s²(s − 1)(cubic) = 0, discard s = 0 and s = 1 by the open range. Backward: 1 − s² = (1 − s³)² is (s − 1)·s²·cubic + (1 − s³)² rearranged, and √ of a square of the nonnegative 1 − s³ returns it. Checked by hand. Correct.
- **ψ = 1 against cos + sin³ = 1.** ψ(φ) = 1 ⟺ cos φ = 1 − sin³ φ whenever 1 − sin³ φ ≠ 0, which holds for s < 1. The open lower bound matters: ψ(0) = 1 is a genuine crossing (the factor s²), and 0 < s excludes it so that the level set is the second crossing only. Neither theorem names `psi`. The identification is one line and the docstring states it. Acceptable.
- **`radius_is_arcsin`** ([L20Arcsin.lean:60](../lean/HamiltonsCubic/Results/L20Arcsin.lean#L60)). Rewrites by `Real.cos_arcsin` and `Real.sin_arcsin` into the previous theorem. Correct, and it says: at φ = arcsin s, s ∈ (0, 1), ψ(φ) = 1 exactly when s is a root of the cubic.
- **Gap 1 (A-1c, A-1e).** That identifies the level set {ψ = 1} ∩ (0, π/2) with arcsin of the cubic's roots in (0, 1). Reading it as "the radius is arcsin s*" needs a real s* ∈ (0, 1) to exist and be unique. No Lean file constructs it: [TubeRadius.lean](../lean/HamiltonsCubic/Results/TubeRadius.lean) defines `cubic` over ℚ, proves `cubic_strict_mono` over ℚ and the sign change, and its own `candidates_fail` shows there is no rational root, so its "exactly one root there" is a statement about the reals it does not type. [L20Arcsin.lean](../lean/HamiltonsCubic/Results/L20Arcsin.lean) does not import TubeRadius, and its cubic is over ℝ. The record's exact reduction ψ ≤ 1 ⟺ sin φ ≤ s* is typed in one direction and only at sin φ ≤ 0.54368 ([cos_add_sin_cube_le_one](../lean/HamiltonsCubic/Results/L20Statement.lean#L84)). The row at [lean/INDEX.md:327](../lean/INDEX.md#L327) says "so the radius is arcsin s*" under **proved**. The repair is small: existence by the intermediate value theorem on the real polynomial, uniqueness by the real strict monotonicity, both elementary. Until then the row should say the identification is proved at every root and the root's existence and uniqueness over ℝ is TubeRadius's argument in ℚ.
- **α ≤ 1/3.** The record calls it *"the lemma's one unproved input"*, and [L21Statement](../lean/INDEX.md#L581) is partial. The tube-radius row claims only the radius and the expansion step, and α enters `expansion_step` as a hypothesis exactly as it enters the record's step, so naming it the lemma's imported input rather than a debt of this row is right. The pointer "(L21)" is the record's own label for the eigenvalue bound. Correct.
- **Gap 2 (C).** [TubeRadius.lean:20](../lean/HamiltonsCubic/Results/TubeRadius.lean#L20) says *"The step from s* to φ is trigonometry and stays with the record"*, and [TubeRadius.lean:94](../lean/HamiltonsCubic/Results/TubeRadius.lean#L94) lists *"that φ = arcsin s*"* and the expansion under "Not settled here". Both are now L20Arcsin's.
- **Gap 3 (A-1f, pre-existing).** [L20Statement.lean:56](../lean/HamiltonsCubic/Results/L20Statement.lean#L56) says the file proves *"the exact form of the theorem at radius arcsin s*, which needs no numeric at all"*, and the section at [L20Statement.lean:96](../lean/HamiltonsCubic/Results/L20Statement.lean#L96) says it is *"Stated at the true crossing rather than at its truncation"*. The theorem under that heading is at sin φ ≤ 0.54368. Neither file states the chain at sin φ ≤ s*. The statement row at [lean/INDEX.md:328](../lean/INDEX.md#L328) is otherwise accurate.
- **Gap 4.** The row's id link at [lean/INDEX.md:327](../lean/INDEX.md#L327) points at [problem.md](../findings/problem.md), and [problem.md:550](../findings/problem.md#L550) says *"THE THEOREM IS Lemma L20 AND IT LIVES THERE"* of route-a.md. Pre-existing, on an edited line.

## 2. L49

- **The record.** [target.md:763](../findings/target.md#L763) and the canon [results.md:193](../results.md#L193): the collapsing T form a subspace, *"and it is exactly the T constant on distinct triples, at every N≥3"*. Items (i) to (iii) are *"Open, and not consequences of this lemma"*, (ii) being non-realisation of constant T by 𝔰𝔬(n).
- **The theorem.** [collapse_space_is_the_constants](../lean/HamiltonsCubic/Results/L49Statement.lean#L303): `Collapses T ↔ ∃ d, ∀ α < β < γ, T α β γ = d`, with `Collapses` the ∃c ∀λ, Σλ = 0 → θ = c Σλ³ condition and `thetaOf` the record's eigenframe display. The owed phrase "the preimage of ℝ p₃|_H is exactly ℝ𝟏" is this: θ_T restricted to H lies in ℝ p₃ exactly when T is constant on increasing triples. Linearity is `collapse_add` and `collapse_smul`. Dimension one is stated as the characterisation, and the file says so. Correct.
- **Gap 5.** The theorem carries `hN : 4 ≤ N`, and [L49Statement.lean:61](../lean/HamiltonsCubic/Results/L49Statement.lean#L61) calls N ≥ 4 *"the canonical statement's threshold"*. The canon and the block both say N ≥ 3. The proof never uses `hN`, so N = 3 holds by the same proof and dropping the binder repairs it. As typed, the theorem is strictly weaker than the record at N = 3, which the **proved** at [lean/INDEX.md:376](../lean/INDEX.md#L376) and "Lean: proved" at [INDEX-results.md:64](../findings/INDEX-results.md#L64) do not note.
- **The 𝔰𝔬(n) clause.** Marked open by the record, as (ii) in target.md and in results.md's italic list. Right to leave it untyped. The row names only (ii), while (i) and (iii) are equally open. That is harmless, since none of the three is a clause of the lemma.
- **Row 49 of INDEX-results** moves to Lean: proved in step with the main row. Right, subject to gap 5.

## 3. L56

- **The record.** Canon [results.md:195](../results.md#L195) and [results.md:712](../results.md#L712), and the Gate 2 block at [ungraded-slack.md:306](../findings/ungraded-slack.md#L306), which refutes the two floor values and the choice of S³ × S^{n−3} as most unbalanced, derives the closed forms, and adds the CPᵐ comparison.
- **What L56Statement proves.** `gapSq` is the block's p < q form, `floor_eq_gap_at_two` puts the floor at p = 2, `gap_strictMono_in_p` is the ordering at every n, `balanced_strict_max` is the balanced strict maximum, `gap_three_seven` and `gap_three_nine` are 1/252 and 1/660, `canon_not_minimal_ten/twelve` refute the canon's minimum, and `cp_below_at_six`, `cp_ties_at_eight`, `cp_above_from_ten` are the CPᵐ clause. A screen of the closed form reproduces 0.062994, 0.038925, 0.031497 and 0.020101. The balanced display and `cpGapSq` are definitions taken from the record, and the statement row says so for the first. Correct.
- **Gap 6 (A-2c).** The row at [lean/INDEX.md:622](../lean/INDEX.md#L622) reads "The refuted values are not formalised, the record refuting them", and the commit says the untyped items are the refuted values. The canon's clause *"Multi-block products interleave rather than extend the trend, (S³)⁴ at 0.0580 sits between S³ × S⁹ and S⁴ × S⁸"* is untyped ([L56Statement.lean:34](../lean/HamiltonsCubic/Results/L56Statement.lean#L34): *"The multi-block clause is absent"*) and the record does not refute it: the block says the closed form *"also reproduces the recorded (S³)⁴ value"*. A screen puts it between gap(3, 9) = 0.038925 and gap(4, 8) = 0.062419, so it is consistent. The vertex-entry mechanism (smallest modulus p/(q − 1)) is also untyped and unrefuted. So the row's **proved** carries one live clause with no Lean, and the row should name it as untyped with the reason the file gives.

## 4. Soundness

- `lake build HamiltonsCubic.Results.L20Arcsin HamiltonsCubic.Results.L49Statement HamiltonsCubic.Results.L56Statement`: completed, 8710 jobs, warnings only (deprecated `push_neg`, unused simp arguments and binders).
- `axiom_audit.py --only`: L20Arcsin 3/3, L49Statement 11/11, L56Statement 12/12, each resting on `propext`, `Classical.choice`, `Quot.sound` alone.
- No `sorry`, `admit` or `native_decide` in L20Arcsin, L49, L49Statement, L56, L56Statement or TubeRadius (the two hits are docstrings saying there is none).

## 5. Downstream

- [INDEX-results.md](../findings/INDEX-results.md) rows 20, 49 and 56 all read Lean: proved, agreeing with the main rows. Row 56 already read proved before 0a4349a6.
- No text in [route-a.md](../findings/route-a.md), [problem.md](../findings/problem.md) or [INDEX-results.md](../findings/INDEX-results.md) calls the three items owed or partial.
- Stale: TubeRadius.lean:20 and :94 (gap 2), L20Statement.lean:56 and :96 (gap 3).

## 6. Style

- No em dash and no backticks inside link text in the added lines. Table rows are single lines.
- The new L20 text uses a semicolon between the two proved identifications after a colon, where each item carries commas, which is the permitted list use.
- **Gap 7.** The edited L20 row keeps *"ψ(φ)=1 is cos φ + sin³ φ = 1; squaring gives s⁴ − 2s + 1"*, a clause splice, [lean/INDEX.md:327](../lean/INDEX.md#L327). Pre-existing text on an edited line.

## Verdict

**CONFIRMED WITH GAPS.** The Lean is correct, faithful and on the standard three axioms. The three moves to proved each need one qualification or one small repair: construct s* over ℝ or qualify the L20 row (gap 1), drop `hN` from L49 (gap 5), name L56's multi-block clause as untyped (gap 6). Gaps 2, 3, 4 and 7 are text.
