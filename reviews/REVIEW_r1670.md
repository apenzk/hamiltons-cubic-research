# REVIEW r1670: L52's "if" half in the ψ-stipulated basis (7511688e) and r1668's repairs (86578d17), lean-loop

**Verdict: CONFIRMED WITH GAPS.** `coordDiag_frame` and `L52_if_psi` are correct, `IsCoordDiag` is the right rendering of "both operators diagonal in one shared frame", and `L52_if_psi` is the record's "if" half at `w = wK` with L54Direct's proof reused line for line. The axiom audit is 2/2 on the standard three. r1669 G2, G3, G4 and r1668 G1, G2, G4, G5 are repaired. Three gaps remain: the row's "needs only M diagonal" rests on an untyped bridge from `Mpair` diagonal to `IsCoordDiag`, L52Statement.lean keeps one stale sentence and one self-contradicting heading, and the "if" half's S²₀ reading is neither typed nor owed.

| # | claim | verdict |
| --- | --- | --- |
| 1 | `coordDiag_frame`: at `IsCoordDiag R`, `Mpair R` is diagonal and `Bw wK (ringW R)` is diagonal | **CONFIRMED** |
| 2 | `IsCoordDiag` renders "both operators diagonal in one shared frame" | **CONFIRMED** (it is `M` diagonal in the coordinate frame, and `W̊`'s φ-block diagonality follows) |
| 3 | `L52_if_psi` is the record's "if" half in the stipulated basis, and is `L54_direct` with coordinate-diagonality as hypothesis | **CONFIRMED WITH GAP** (G3) |
| 4 | the row's "at wK the if half needs only M diagonal in the pair basis" | **CONFIRMED WITH GAP** (G1) |
| 5 | r1669 G1–G4 repaired | **CONFIRMED** (G1's two items: one owed, see note on the working tree) |
| 6 | r1668 G1–G5 repaired | **CONFIRMED WITH GAP** (G2) |
| 7 | the Owed clause is accurate and complete for L52 | **CONFIRMED WITH GAPS** (G1, G3) |
| 8 | axiom audit, L52IfPsi.lean | **CONFIRMED** (2/2, standard three) |

**Summary:** the two theorems are correct and faithful, and the prose repairs land, while the row's "needs only M diagonal" depends on an untyped equivalence and L52Statement.lean still says the record lists no reference for Schur's theorem.

## 1. `coordDiag_frame`

- **The Lean** ([L52IfPsi.lean:32-50](../lean/HamiltonsCubic/Results/L52IfPsi.lean#L32)) is the body of `L54_direct` ([L54Direct.lean:131-157](../lean/HamiltonsCubic/Results/L54Direct.lean#L131)) with the `tF_eq_iff` step removed and the conclusion stated as off-diagonal zeros rather than `= Matrix.diagonal …`. The first conjunct unfolds `Mpair` to `R4 R p.1.1 p.1.2 q.1.1 q.1.2` and kills it by `hcd`, the reversed case excluded by `p.1 < p.2` and `q.1 < q.2`. The second splits `S2Idx` four ways: φ–φ by `Bw_pair_off`, φ–ψ by `Bw_pair_psi`, ψ–φ by symmetry of `Bw` (`Bw_isHermitian` at `wK_complete`), ψ–ψ by `psi_block` with `wK_eigen` and `wK_orth`.
- **Hypotheses.** `hR`, `hskew`, `hsym` are needed for `wK` and `Bw_isHermitian`. No `hunit`, no Bianchi, no Ricci-flatness, which is right: the statement is pure linear algebra at a coordinate-diagonal `R`.
- **Breaking object sought.** A coordinate-diagonal `R` with a nonzero off-diagonal entry of `Bw wK`. The φ–φ and φ–ψ entries are sums of `R4` terms each carrying an index pattern `IsCoordDiag` kills at any `w`, and the ψ–ψ entry is `−w_jᵀ K w_k`, zero for an orthonormal eigenbasis. None exists, and the kernel agrees.

## 2. `IsCoordDiag` as "both diagonal in one shared frame"

- **Definition** ([L54Basis.lean:186-187](../lean/HamiltonsCubic/Results/L54Basis.lean#L186)): `W_{ijkl} = 0` unless `(k,l)` is `(i,j)` or `(j,i)`. `M` diagonal in the pair basis of the frame `e` is `W_{ijkl} = 0` for `{i<j} ≠ {k<l}`. These agree (section 4). `W̊` diagonal on `{φ_ij}` and orthogonal to the diagonal block is then `Bw_pair_off`, `Bw_pair_psi`. So `IsCoordDiag` is the record's hypothesis "both operators diagonal in one shared frame" in the coordinate frame, and the Lean hypothesis is if anything weaker than the record's (one operator's diagonality implies the other's φ-part).
- **Frame generality.** The Lean fixes the coordinate frame. Any orthonormal frame is a rotation of `R`, and every hypothesis of `L52_if_psi` is rotation-invariant, so nothing is lost. Not typed here, and not needed for the claim.

## 3. `L52_if_psi`

- **The Lean** ([L52IfPsi.lean:52-62](../lean/HamiltonsCubic/Results/L52IfPsi.lean#L52)) applies `L52_record_if` ([L52RecordEq.lean:54-64](../lean/HamiltonsCubic/Results/L52RecordEq.lean#L54)) at `w = wK`, `hw = wK_complete`, with `hMd`, `hWd` the two conjuncts of `coordDiag_frame`. The conclusion is `L52_record`'s display at `wK` as an equality, for every `Mp`, `m`.
- **Fidelity to the record** ([bispectral.md:75-83](../findings/bispectral.md#L75), [results.md:1177](../results.md#L1177)). Hypothesis: both diagonal in one frame and ψ an eigenbasis of `K`. Lean: `IsCoordDiag` and `w = wK`, an orthonormal eigenbasis of `K` on `ℝⁿ`. Conclusion: the display is exact. It is the record's "if" half read on S² with `wK` over `ℝⁿ`, one dimension more than the record's `𝟏^⊥`, as L54Direct.lean's header already says of the same basis.
- **Not vacuous.** First Bianchi holds for every coordinate-diagonal tensor with symmetric weights (r1669 §5), and the norm scales, so the hypotheses are satisfiable, for instance by the `n = 4` family `a, b, c` on the three matchings.
- **Fidelity to `L54_direct`.** The header's "`L54_direct` with coordinate-diagonality taken as the hypothesis rather than derived from `t_F = 2`" is exact for `coordDiag_frame`. `L52_if_psi` adds the composition with `L52_record_if`.
- **The S²₀ reading of this half (G3).** The record's display uses `K'` on S²₀ with ψ on `𝟏^⊥`. At a Ricci-flat `W` the two displays agree in value: the `wK` ψ-diagonal is `−spec K` on `ℝⁿ`, which is `−spec K|_{𝟏^⊥}` plus one `0`, whatever basis Mathlib picks inside a degenerate 0-eigenspace, and a `0` contributes nothing to `p₂`, `p₃`. `sum_diag_split` ([L52S20.lean:81](../lean/HamiltonsCubic/Results/L52S20.lean#L81)) is the tool. So the S²₀ "if" is one composition away, but it is not typed, and the Owed clause lists only the S²₀ reading of the off-diagonal ("only if") conclusion.

## 4. The row's "at wK the if half needs only M diagonal in the pair basis"

- **True, by hand.** Let `Mpair R p q = 0` for `p ≠ q`, and take `(k,l) ∉ {(i,j),(j,i)}`. If `i = j`, `phi i i = 0` and `R` linear gives `R4 R i i k l = 0`. If `k = l`, `phi k k = 0` gives `0`. Otherwise reorder both pairs by `phi j i = −phi i j` (linearity of `R`, bilinearity of `inner2`) to `p = (min, max)`, `q = (min, max)`, which differ since `(k,l)` is neither ordering of `(i,j)`, so `R4 R i j k l = ±Mpair R p q = 0`. So `Mpair` diagonal is equivalent to `IsCoordDiag` under `hR`, and with it `Bw wK` diagonal follows by `coordDiag_frame`.
- **Gap (G1).** The row writes the `Mpair`-only reading as following from `Bw_pair_off` and `Bw_pair_psi`, but both take `IsCoordDiag`, and no declaration converts `∀ p q, p ≠ q → Mpair R p q = 0` into `IsCoordDiag R` (`grep "Mpair R p q = 0"` hits only L52RecordEq.lean:44, :55 and L52IfPsi.lean:35, and `coordDiag_frame`'s first conjunct is the other direction). `L52_if_psi`'s hypothesis is `hcd`, so the "needs only M diagonal" statement is untyped and not owed. The bridge is a few lines by the argument above.

## 5. r1669's gaps

- **G1.** The row now names the φ–φ and φ–ψ derivations and lists "a declaration that equality forces w to diagonalise K (`L52_record_eq` with `diag_block`)" as owed. Repaired as an owed item. *Note:* the working tree (uncommitted, another thread) adds `L52_eq_diagonalises` to L52RecordEq.lean. It is outside 7511688e and was not reviewed. When it lands the Owed clause must drop that item.
- **G2.** The row marks the staircase counterexample as "checked by hand at n=4 in r1669, no declaration" and owes the witness. Repaired.
- **G3.** [L52RecordEq.lean:14-16](../lean/HamiltonsCubic/Results/L52RecordEq.lean#L14) and the row now say "which at `w = wK` … is the record's shared frame in the stipulated basis". Repaired.
- **G4.** The Owed clause names `Bw_gCoord` or `psi_one_null`, Ricci-flatness, and the change of basis at a degenerate 0-eigenspace. Repaired, and accurate.

## 6. r1668's gaps (86578d17)

- **G1.** The Karamata quotation is gone from [CubicConvexity.lean:11-13](../lean/HamiltonsCubic/Results/CubicConvexity.lean#L11) and [DoublyStochastic.lean:10-11](../lean/HamiltonsCubic/Results/DoublyStochastic.lean#L10). The replacement names only the convexity of `t³+3mt²`, where the record says "two strictnesses rather than one", but CubicConvexity's last paragraph (lines 27-28) names `strictConcaveOn_h` too. Repaired.
- **G2.** The verbatim block's "only if" bullet and SchurMajor sentence now match [bispectral.md:79](../findings/bispectral.md#L79) and [:84](../findings/bispectral.md#L84), elisions marked. Repaired inside the block. **Outside it** [L52Statement.lean:57-59](../lean/HamiltonsCubic/Results/L52Statement.lean#L57) still says "the record records that `references/` holds no entry for it" of Schur's theorem. `grep "holds no entry"` over bispectral.md and results.md finds nothing: the record now says SchurMajor.lean proves it. Same staleness r1668 G2 flagged, one paragraph down (G2 here).
- **G3.** [L52Statement.lean:66-73](../lean/HamiltonsCubic/Results/L52Statement.lean#L66) now points to L52Frame's `Bw` and to all five equality declarations. Repaired in substance, but the paragraph still opens "**The frame dictionary is not typed**" under "What is NOT typed here" and then says it is carried in L52Frame.lean, where `Bw_diag_pair` types the dictionary's second identity and `Mpair_diag` the first. Folded into G2 below.
- **G4.** The Owed clause's ψ step is now `coordDiag_frame` itself, and the "equality forces w" item is owed. Repaired.
- **G5.** The commit body records 1b2e4f24's extra files. Repaired.

## 7. Axiom audit

- `python3 scripts/misc/axiom_audit.py --only L52IfPsi.lean`, run with no other lake process: "auditing 2 declarations across 1 files, 2/2 clean -- resting on the standard three alone", exit 0. The build used the working-tree L52RecordEq.lean, whose uncommitted addition does not touch `L52_record_if`. A screen of compilation and axioms, and the file compiles.

## Gaps

- **G1, [lean/INDEX.md:383](../lean/INDEX.md#L383), the L52IfPsi sentence.** "at `wK` the "if" half needs only `M` diagonal in the pair basis, … following from `Bw_pair_off` and `Bw_pair_psi`" relies on `Mpair` diagonal implying `IsCoordDiag`, which no declaration states and the Owed clause does not list. True by the hand argument in §4.
- **G2, [L52Statement.lean:57-59](../lean/HamiltonsCubic/Results/L52Statement.lean#L57) and [:66](../lean/HamiltonsCubic/Results/L52Statement.lean#L66).** "the record records that `references/` holds no entry for it" is stale against [bispectral.md:79](../findings/bispectral.md#L79), and "The frame dictionary is not typed" contradicts the same paragraph's pointer to L52Frame's `Bw`.
- **G3, [lean/INDEX.md:383](../lean/INDEX.md#L383), Owed clause.** The "if" half's S²₀ reading (`L52_if_psi` composed with `sum_diag_split` at a Ricci-flat `W`) is neither typed nor owed. Only the "only if" half's S²₀ reading is listed.

## What would break each claim, and what was done

- For 1: a coordinate-diagonal `R` with a nonzero off-diagonal `Bw wK` entry. Checked each of the four blocks against `Bw_pair_off`, `Bw_pair_psi`, `psi_block`, and the proof against `L54_direct` line by line. None.
- For 2: a pair `(i,j,k,l)` at which `IsCoordDiag` and `M` diagonal disagree. Checked the `i = j`, `k = l` and reordered cases by hand. None.
- For 3: a hypothesis of `L52_record_if` not discharged, or a basis other than an eigenbasis of `K`. Compared signatures, and `wK` is Mathlib's `eigenvectorBasis` of `Kmat`. For the S²₀ reading: a degenerate 0-eigenspace where the displays differ. None, since the display sees the ψ-diagonal only as a multiset.
- For 4: a declaration carrying `Mpair`-diagonal to `IsCoordDiag`. Grepped the layer. None found (G1).
- For 5 and 6: a gap line still carrying its defect. Read each cited line at HEAD. Found the stale `references/` sentence and heading (G2).
- For 7: a `sorry` or non-standard axiom. Ran the audit: 2/2 clean.
