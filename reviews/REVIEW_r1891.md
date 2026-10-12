# REVIEW r1891: sp(k)'s torus system, the equal-weight uniqueness of I/c, Lean against claim and prose

Log: [agent_logs/r1891-sp-equal-weight.log](../agent_logs/r1891-sp-equal-weight.log)

Lean file: [SpTorusEqualWeight.lean](../lean/HamiltonsCubic/Results/SpTorusEqualWeight.lean). Note: [2026-09-28l-I117-g2-torus.md](2026-09-28l-I117-g2-torus.md).

## Verdicts

| row | claim | verdict |
|---|---|---|
| 1 | equal_weight_unique types the note's Statement, given steps 1 and 2 | CONFIRMED |
| 2 | step 3, square_completion | CONFIRMED |
| 3 | step 4, u_equal | CONFIRMED |
| 4 | step 5, SM = (2-4u)M with M positive | CONFIRMED |
| 5 | step 6, eigvec_proportional | CONFIRMED |
| 6 | step 7, M = 2uJ and u = 1/(k+1) | CONFIRMED, with one prose correction (t > 0) |
| 7 | axioms | CONFIRMED: propext, Classical.choice, Quot.sound on all four |
| 8 | non-vacuity example | CONFIRMED as a check of heq only |
| 9 | note-level wording (heading, "What it gives", Lean sentence) | CONFIRMED |

## Row 1, statement fidelity

- Hypotheses against what a positive solution with p = q supplies. hsym: S is the matrix of s_ij = p_ij + q_ij, symmetric by construction. hdiag: S has zero diagonal by definition. hpos: s_ij = 2p_ij > 0. hu0: u_i > 0. hu: u_i < 1 follows from step 1's u_i < 1/2. heq is exactly step 2's equation S² = 2S − 3(US + SU) + 4U − 8U², entrywise: off the diagonal (2 − 3(u_i + u_j))s_ij, on it 4u_i(1 − 2u_i), which is step 1's r_i. No hypothesis is stronger than what the positive solution provides.
- Conclusion: u_i = 1/(k+1) and S_ij = 2/(k+1) for i ≠ j. With s = 2p and p = q this is p_ij = q_ij = 1/(k+1), the note's claim. The identification with I/c is the note's, outside the Lean.
- Vacuity screen. k = 0: both conclusions are universally quantified over the empty type, as is the claim, so nothing is lost. k = 1: heq reads 0 = 4u − 8u², the hypotheses admit u = 1/2, and the conclusion gives u = 1/2 = 1/(1+1), consistent (step 1's strict u < 1/2 would exclude it, but the Lean's weaker hu is what it assumes). For k ≥ 2 the uniform point satisfies every hypothesis (row 8), so the statement is non-vacuous and its content is the uniqueness.
- The Lean is marginally stronger than needed: it asks u_i < 1 where step 1 gives u_i < 1/2.

## Rows 2 to 6, the prose chain against the Lean

- **Step 3.** T = S + 3U − I and T² = (I − U)². The Lean expands T² and substitutes heq; the prose's "checked symbolically" is the same identity. Follows from step 2 alone.
- **Step 4.** T commutes with T², entry (i,j) gives T_ij((1−u_j)² − (1−u_i)²) = 0, T_ij = S_ij > 0 off the diagonal, and u_i + u_j < 2 closes it. The Lean follows this exactly, factoring as (u_i − u_j)(2 − u_i − u_j). The hypothesis hdiag of u_equal is unused (named _hdiag), harmless.
- **Step 5.** With every u_i = w, heq becomes S² = (2−6w)S + 4w(1−2w)I, and S(S + 2wI) = (2−4w)(S + 2wI) because (2−4w)·2w = 4w(1−2w). M_ii = 2w > 0 and M_ij = S_ij > 0. Lean: hq, hSM, hMpos. Matches.
- **Step 6.** Lean's eigvec_proportional needs only y > 0, x arbitrary, and the prose's argument (t = min x_i/y_i at m, z = x − ty ≥ 0, z_m = 0, 0 = Σ_{l≠m} s_ml z_l) is the Lean's. The prose's "two positive eigenvectors" is a special case of what is typed. Matches.
- **Step 7.** The Lean applies step 6 to columns j and i of M, gets M_ij = 2wt from row i, and 2w = t·M_ij = 2wt² from row j with symmetry. **Correction to the prose:** 2u = 2ut² gives t² = 1, and t = 1 needs t > 0, which the Lean proves (htpos) from M_ij = 2ut > 0. The prose writes "so t = 1" without that step. Suggested wording: "so t² = 1, and t > 0 since M_ij = 2ut > 0, so t = 1 and s_ij = 2u." The diagonal step, 4u²(k−1) = 2u(2−4u), hence u = 1/(k+1), is the Lean's hrow' with hsumS, and division by u uses u > 0 (hu0), which the prose leaves implicit and the Lean uses.
- Nothing in the prose is asserted that the Lean does not use, apart from the note's I/c identification and steps 1 and 2, which are declared prose.

## Rows 7 and 8, checks without judgement

- A scratch copy of the file with four `#print axioms` lines appended ran clean under `lake env lean` (about 50 s): no errors, no sorry, and each of square_completion, u_equal, eigvec_proportional and equal_weight_unique depends on propext, Classical.choice and Quot.sound only.
- The `example` at the foot type-checks. It proves heq for k = 3 at S = J − I scaled by 1/2, u = 1/4. It exercises heq only. The remaining hypotheses (symmetry, zero diagonal, positive off-diagonal entries, 0 < 1/4 < 1) hold by inspection but are not typed, so the example does not by itself show all hypotheses of equal_weight_unique are jointly satisfiable. Optional strengthening: state it as `∃ S u, Sᵀ = S ∧ (∀ i, S i i = 0) ∧ … ∧ heq` at k = 3. The values agree with the conclusion (1/4 = 1/(3+1), 1/2 = 2/(3+1)).

## Row 9, note-level wording

- The heading's "steps 3 to 7 typed in Lean with a one-reader Gate 2 owed" and the Lean sentence of "What it gives" ("equal_weight_unique from the matrix equation of step 2 with S symmetric, zero diagonal, positive off the diagonal and 0 < u_i < 1, with square_completion, u_equal and eigvec_proportional beneath it. Steps 1 and 2 ... are prose") describe the file exactly. The module docstring agrees. After this review the heading's "one-reader Gate 2 owed" can be replaced by a reference to r1891.
