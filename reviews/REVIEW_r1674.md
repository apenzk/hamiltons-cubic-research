# REVIEW r1674: L52, r1673's repairs (d25cc89a) and `L52_if_psi_S20` (dfd9892f)

**Verdict: CONFIRMED WITH GAPS.** `L52_if_psi_S20` is correct and kernel-checked: its `K'` is literally the multiset `L52_record_S20` binds, and its right-hand side is that display term for term, so it is the "if" half of the record's S²₀ display. r1673's G1, G2 and G3 are repaired, and all six rerun audit counts match the row. Two small gaps remain: L52Statement.lean's equality paragraph, repaired one commit earlier, omits the new `L52_if_psi_S20`, and L52IfPsi.lean's header bullet "the same on `S²₀`" comes before the declaration it refers to.

## Claims

| # | Claim | Verdict |
|---|---|---|
| 1 | r1673 G1: the six passages carry correct audit counts | **CONFIRMED** |
| 2 | r1673 G2: L52Statement's equality paragraph names the equality declarations | **CONFIRMED WITH GAP** (G1) |
| 3 | r1673 G3: `L52_eq_diagonalises`'s docstring says "diagonalises `K`" and derives the eigenbasis from orthonormality | **CONFIRMED** |
| 4 | `L52_if_psi_S20` is the "if" half of `L52_record_S20`'s display with the record's `K'` | **CONFIRMED** |
| 5 | Its hypotheses are the ones the statement needs | **CONFIRMED** (hypotheses stronger than needed, harmless, see §2) |
| 6 | The Owed clause is accurate and **partial** is the right status | **CONFIRMED** |
| 7 | Axiom audit on L52IfPsi.lean: 4/4 on the standard three | **CONFIRMED** (rerun) |
| 8 | File documentation for the new theorem | **CONFIRMED WITH GAP** (G2) |

## 1. r1673's gaps

- **G1.** Reran `axiom_audit.py --only` on the six files this round. L52.lean 11/11, L52Bound 5/5, L52Frame 19/19, DoublyStochastic 5/5, SchurMajor 6/6, SpectralTrace 11/11, all on the standard three. Each number matches the row at [lean/INDEX.md:383](../lean/INDEX.md#L383). r1673's grep counts (13, 21, 12) were higher because they counted `def`s, as that review flagged. Repaired.
- **G2.** [L52Statement.lean:71-74](../lean/HamiltonsCubic/Results/L52Statement.lean#L71) now names `L52_eq_diagonalises`, `coordDiag_frame`, `coordDiag_of_Mpair` and `L52_if_psi`. That repairs r1673's G2. dfd9892f then added `L52_if_psi_S20` without updating this paragraph, so the paragraph is incomplete again (G1 below).
- **G3.** [L52RecordEq.lean:68-71](../lean/HamiltonsCubic/Results/L52RecordEq.lean#L68) now reads "diagonalises `K` (and, `w` being an orthonormal basis, is then an eigenbasis of `K`)". The file header at [:18-19](../lean/HamiltonsCubic/Results/L52RecordEq.lean#L18) already said "diagonalises". The parenthetical is the one-line expansion r1673 checked. It is now labelled as a consequence of orthonormality rather than presented as the declared content. Repaired.
- The commit also swept in plan.md, reviews/2026-09-27-I117-J1.md and reviews/INDEX.md from a concurrent session. Those files were not reviewed.

## 2. `L52_if_psi_S20`

- **Same `K'`.** The theorem's `let` block (`w := wK`, `TK`, `hTK`, `gK`) and its `∃ hWK` match `L52_record_S20` ([L52S20.lean:110-130](../lean/HamiltonsCubic/Results/L52S20.lean#L110)) character for character. The multiset `map (Bw w (ringW R) (inl p) (inl p)) univ + map (−eigenvalues of TK|𝟏^⊥) univ` is `L52_record_S20`'s `K'`, inlined rather than `let`-bound. The eigenvalue term depends on the proof `hWK`, which proof irrelevance makes immaterial. Its length is `N + (n−1) = dim S²₀`, matching the record's count at bispectral.md:497.
- **Same RHS shape.** `(3/2)(p₃(K) + 3Mp(1 − p₂(K))) − (1/2)(p₃(K') + 3m(p₂(K') − 3))` is exactly `L52_record_S20`'s right-hand side, with `≤` replaced by `=`. So this theorem is the equality half that belongs to that bound.
- **Proof.** `L52_if_psi` gives the equality with `Σ_u Bw_uu^k` over S². `sum_diag_split` at `g = t³` and `g = t²` (both with `g 0 = 0`) rewrites each sum into the `K'` multiset. The two `obtain`s produce two `hWK` witnesses, and the second is discarded. Proof irrelevance makes the discard sound, and the kernel accepted it.
- **Equality at every `Mp`, `m`.** The equality holds for every `Mp` and `m` because it is inherited from `L52_record_if`. At a coordinate-diagonal unit `W`, `p₂(K) = 1` and `p₂(K') = 3`, so both multiplier terms vanish. This matches the record's (4): `Σd_φ² = 1` and `Σd² = 3` at `t_F = 2`.
- **Hypotheses, screened by hand.**
  - **Ricci-flatness is needed.** For coordinate-diagonal `W`, `Ric_aa = Σ_b K_ab` and the off-diagonal Ricci entries vanish. Without zero row sums, `𝟏` is not a 0-eigenvector of `K`, so `hWK` can fail and `sum_diag_split`'s extra `0` is not available.
  - **`hn` and `hB` are implied.** `0 < n` follows from `normSq R = 1`, since at `n = 0` the norm is an empty sum. First Bianchi follows from `IsCoordDiag` plus antisymmetry. With `i, j, k` distinct, each term of `R_ijkl + R_iklj + R_iljk` asks for a pairing that cannot hold. With a repeat, the two surviving terms cancel by `R4_anti2`. Both hypotheses are harmless, and the record assumes `W ∈ Weyl_n` anyway.
  - **Non-vacuity.** The hypotheses are satisfiable at the record's own `n = 4` tensor (`K₁₂ = K₃₄ = ½`, `K₁₃ = K₂₄ = −½`, `K₁₄ = K₂₃ = 0`): its rows sum to zero and `t_F = 2`.
- **Frame.** "In one shared frame" is rendered as the coordinate frame (`IsCoordDiag`). An arbitrary frame is the coordinate frame of a rotated `R`, which is the convention r1670 accepted.

## 3. The Owed clause

- The clause at [lean/INDEX.md:383](../lean/INDEX.md#L383) lists two items:
  - the S²₀ reading of the off-diagonal ("only if") conclusion, with its three obstacles: `W̊` killing `g`, Ricci-flatness that `L52_record_eq` lacks, and the degenerate-kernel change of basis;
  - a Lean witness of the staircase counterexample.
- r1670 G3's owed item, the S²₀ "if" half, is no longer listed. It is now discharged by `L52_if_psi_S20`, so dropping it is correct.
- Walking bispectral.md:75-83 and :495-503 clause by clause finds no statement that is neither declared nor owed. The two owed items are undeclared (grep for a staircase witness under lean/ finds none), so **partial** is right.

## 4. Axiom audit

- `python3 scripts/misc/axiom_audit.py --only L52IfPsi.lean`: 4 declarations, **4/4 clean on the standard three**. The file carries no `sorry` and no `native_decide`. The run also confirms the file compiles.
- The row's "2/2" then "4/4" for L52IfPsi is cumulative, the same convention as L52RecordEq's "2/2" then "3/3". The final figure agrees with the audit.

## Gaps

- **G1, [L52Statement.lean:71-74](../lean/HamiltonsCubic/Results/L52Statement.lean#L71).** The equality paragraph names `coordDiag_frame`, `coordDiag_of_Mpair` and `L52_if_psi` but not `L52_if_psi_S20`. dfd9892f added that theorem one commit after d25cc89a repaired this paragraph. Fix: add "and `L52_if_psi_S20` on `S²₀`".
- **G2, [L52IfPsi.lean:20](../lean/HamiltonsCubic/Results/L52IfPsi.lean#L20).** The header bullet "**`L52_if_psi_S20`**: the same on `S²₀`" sits before the `L52_if_psi` bullet at :21-22. "The same" therefore reads as referring to `coordDiag_of_Mpair`. Fix: move the bullet below `L52_if_psi`'s.

## What would break each claim, and what was done

- **Claims 1 and 7:** an audit count differing from the row, or a non-standard axiom. Reran all seven audits: every count matches and every axiom is standard.
- **Claim 2:** a declaration of the equality clause missing from L52Statement. Listed every declaration in L52RecordEq and L52IfPsi against the paragraph and found `L52_if_psi_S20` absent (G1).
- **Claim 3:** a docstring still asserting the eigenbasis as declared content. Read L52RecordEq.lean:10-24 and :68-71. None.
- **Claim 4:** a mismatch between `L52_if_psi_S20`'s `K'` or RHS and `L52_record_S20`'s. Diffed the two statements side by side. None.
- **Claim 5:** a Ricci-flat coordinate-diagonal unit `W` where equality fails, or hypotheses that are jointly unsatisfiable. Neither exists: the kernel proves the equality, and the record's `n = 4` tensor satisfies every hypothesis (hand screen). Ricci-flatness is needed for `hWK` (hand screen).
- **Claim 6:** a clause of the record that is neither declared nor owed, or an owed item that is already declared. Walked the record and grepped lean/ for a staircase witness. None.
- **Claim 8:** header text whose reference points at the wrong declaration. Found (G2).
