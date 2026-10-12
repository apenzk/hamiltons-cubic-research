# REVIEW r1870: L221 (a) at the operators, L221aChain.lean

*Cold Gate 2 review of [L221aChain.lean](../lean/HamiltonsCubic/Results/L221aChain.lean) against Lemma L221 (a) in [second-order.md](../findings/second-order.md) and the two L221 rows of [lean/INDEX.md](../lean/INDEX.md). Read at source: the target file, [FourL220.lean](../lean/HamiltonsCubic/Results/FourL220.lean) (L220_bound, proj_PiQ), [FourStep67.lean](../lean/HamiltonsCubic/Results/FourStep67.lean) (step6, step7), [FourStep8.lean](../lean/HamiltonsCubic/Results/FourStep8.lean) (step8), [FourStep5.lean](../lean/HamiltonsCubic/Results/FourStep5.lean) (step5), [FourStep4.lean](../lean/HamiltonsCubic/Results/FourStep4.lean) (Lq_eigen), [L220Statement.lean](../lean/HamiltonsCubic/Results/L220Statement.lean) (theta_sq_le), [FourEq.lean](../lean/HamiltonsCubic/Results/FourEq.lean) (Q_nu), [FourIdent.lean](../lean/HamiltonsCubic/Results/FourIdent.lean) (four_eq_sig), [L221a.lean](../lean/HamiltonsCubic/Results/L221a.lean) (L221a_split, L221a_crit, SM), [L120Blocks.lean](../lean/HamiltonsCubic/Results/L120Blocks.lean) (char_orth, setChar), [L224Rank.lean](../lean/HamiltonsCubic/Results/L224Rank.lean) (innerOp2_coordOp), [FourProd.lean](../lean/HamiltonsCubic/Results/FourProd.lean) (PiQ, E2), [CompChar.lean](../lean/HamiltonsCubic/Results/CompChar.lean) (SM_components). Run: `lake env lean` on /private/tmp/r1870/screen.lean for `#print axioms` on five declarations, and on /private/tmp/r1870/screen2.lean (exit 0) for an `example` deriving L220's single-block statement from L221a_bound at m = 1, and an `example` turning θ² ≤ 3/2 into θ ≤ √(3/2). Analysis only: no sweeps, no numerics.*

| # | Claim | Verdict |
|---|---|---|
| 1 | step6_extra is step 6 with an extra term E, ⟨E, q⟩ = 0 | CONFIRMED |
| 2 | L220_bound_extra gives θ² ≤ 3/2 with E ⊥ Π_Q and ‖D‖² + ‖ν‖² ≤ 1 | CONFIRMED |
| 3 | PiQ_orth, nunu_orth | CONFIRMED |
| 4 | L221a_bound is L221 (a) | CONFIRMED WITH OBSERVATIONS |
| 5 | INDEX rows, L221 statement row proved to partial | CONFIRMED WITH OBSERVATIONS |

**Summary.** The chain is sound and L221a_bound states L221 (a) in the Q(W) = θW form the record's own footnote adopts, with no hypothesis beyond the record's. The record's italic header still lists (a)'s chain as owed and the L221 row's file column omits the new file.

## A. Hypothesis inventory

- L221a_bound assumes: Q a of card 4 and pairwise disjoint; D Weyl of character 1; each ν a Weyl of character χ_{Q a}; θ > 0; Qop2 W = θW; normSq2 W = 1; some ν i0 ≠ 0.
- The record's statement assumes n ≥ 6 and θ > 0, a unit critical point in D_n ⊕ V_{Q_1} ⊕ ⋯ ⊕ V_{Q_m}, and some nonzero block component. The Lean drops n ≥ 6 (n ≥ 4 is forced by card_four on Q i0), so it is at least as general in n.
- θ > 0 is the record's own hypothesis, and it is used: step7, step8 and the κ transfer need θ ≥ 0, and theta_sq_le divides by θ.
- The Weyl hypotheses on D and on each ν a are the record's: the record's space is the Weyl part of the direct sum, and [SM_components](../lean/HamiltonsCubic/Results/CompChar.lean) proves every character component of an element of SM Q is Weyl. So a W ∈ SM Q always supplies them. L221a_bound takes them separately rather than composing with SM_components, which is a presentation choice (O3).
- The characters of D and ν a are exactly the definitions of D_n and V_{Q_a} as character spaces (trivial_block_iff for D_n, four_block_iff for V_Q).
- Unused: nothing is carried idle except the `x + y + z = 0` binder in L221a_bound's hE, which nunu_orth does not need. Harmless.

## B. The weakened norm in theta_sq_le

- theta_sq_le is called with R' = 1 − a − N, a = ‖q‖², N = ‖ν‖². Its hunit, a + R' + N = 1, holds by ring.
- hR, 0 ≤ R': from hnorm rewritten through hqr to a + ‖r‖² + N ≤ 1 and ‖r‖² ≥ 0. Correct.
- hκ, 3κ ≤ θR': step8 gives 3κ ≤ θ‖r‖², and ‖r‖² ≤ R' with θ ≥ 0 gives θ‖r‖² ≤ θR' by mul_le_mul_of_nonneg_left. The transfer is valid only because θ ≥ 0, which hθ supplies.
- theta_sq_le's proof uses R only through hR, hunit and hκ, so replacing the true ‖r‖² by the larger R' is sound. This is the record's "step 9 runs with ‖r_i‖² ≤ 1 − θ²/3 − ‖ν_i‖²".
- hqr, ‖q + r‖² = ‖q‖² + ‖r‖², uses hperp at (x, y, z), which is the pattern proj_PiQ returns. Correct.

## C. The hypotheses against "unit critical point in the space"

- The record's footnote to (b), which also governs (a), defines a unit critical point in the space as Q(W) = θW with W in the space intersected with W_n, the form L221a_split takes. L221a_bound's hQ and hunit, with W = D + Σ ν a, are that form.
- The equivalence with criticality on the sphere of that space is proved in the Lean only at a local maximiser (L221a_crit), as the footnote says. L221a_bound does not need it.
- D's character-1 hypothesis is D ∈ D_n: trivial_block_iff identifies Weyl operators of character 1 with coordOp of a weight, which is the diagonal space.
- L221a_split is applied with exactly the hypotheses it states (hdis, hcard, hD, hν, hQ), and it needs no Weyl or unit hypothesis.

## D. Edge cases

- m = 1: the example in screen2.lean, which compiles, derives L220_bound's statement (single S of card 4, Qop2 (D + ν) = θ(D + ν), unit norm) from L221a_bound with Q = fun _ => S, disjointness vacuous on Fin 1. The erased sum E is then empty, and hnorm is an equality. So (a) at m = 1 is L220.
- Several ν a nonzero: L221a_bound picks one i0 and runs the chain on its block. The other blocks enter through E, killed by nunu_orth, and through R in the norm, dropped as ‖R‖² ≥ 0. Nothing requires the others to vanish.
- ν a = 0 for all a ≠ i0: E = Σ ν a ∘ ν a = 0 and R = 0. The proof covers it with no special case.
- An i0 with ν i0 = 0 is excluded by hi0, and step5 needs ν ≠ 0 for θ² = 3‖q‖².

## E. INDEX

- The L221 row stays partial, and (b)'s owed list is carried over unchanged. It does not overclaim (b).
- The L221 statement row moves from proved to partial. The row already listed owed items while marked proved, so partial is the consistent status. Correct direction.
- The L221 row names L221aChain.lean in its text but not in its file column (O2).
- The statement row's description of L221a_bound ("every unit critical W = D + Σ ν_i with some ν_i ≠ 0 and θ > 0 has θ² ≤ 3/2") matches the Lean statement.
- The record's header in [second-order.md](../findings/second-order.md) still says "The Lean owes, for (a), ν_i∘ν_i ∈ Π_{Q_i}, Π_{Q_j} ⊥ Π_{Q_i}, L220's steps 4 to 9 on each block ... and the ‖r_i‖² bound". That is now discharged and stale (O1). The working tree does not touch findings/second-order.md.

## F. Axioms

- `#print axioms` in /private/tmp/r1870/screen.lean, against the olean built from the current source (olean 16:48, source 16:47): L221a_bound, L220_bound_extra, nunu_orth, PiQ_orth and step6_extra each depend on [propext, Classical.choice, Quot.sound]. That is the standard three, with no sorryAx and no native_decide.

## G. Breakers

- step6_extra: an E with ⟨E, q⟩ ≠ 0, for example E = q itself, adds ‖q‖² to the left pairing and breaks the identity. Looked for by reading hpair: hE is exactly the term that cancels.
- L220_bound_extra: E pairing nonzero with some pattern, or ‖D‖² + ‖ν‖² > 1. With R' negative, hR fails and theta_sq_le is unavailable. Also θ < 0, where the κ transfer reverses. Looked for by tracing each hypothesis of theta_sq_le to its source.
- PiQ_orth: two four-sets sharing a pair {a, b}, where both Π's have a nonzero (a, b) entry and the inner product is the product of those entries. Looked for by reading the proof: disjointness forces one factor to vanish on every off-diagonal (a, b) since a lies in at most one set. The diagonal is skipped by innerOp2_coordOp's `if i = l then 0`.
- nunu_orth: Q' = Q, where ν∘ν ∈ Π_Q pairs nonzero with the pattern q (that is L220's step 6 pinning term θ/2 ‖ν‖²). Looked for by checking that nunu_orth's only use of Q is through PiQ_orth's disjointness.
- L221a_bound: two four-sets that overlap, which is (b)'s territory, where ν_i ∘ ν_j ≠ 0 and ⟨ν_j ∘ ν_j, q_i⟩ ≠ 0 in general (the record's (b) step 3 bounds it by 1/3, not 0). Looked for by checking that disjointness enters in exactly three places: L221a_split (cross terms), hE (nunu_orth), and hνR (char_orth through the flip at a ∈ Q i0 \ Q j). Also all ν a = 0, where no step 5 exists and the statement says nothing about a pure D_n critical point.

## Observations

- **O1.** The italic header of Lemma L221 in [second-order.md](../findings/second-order.md) still lists (a)'s operator chain as owed. It should name L221aChain.lean and L221a_bound and keep only (b)'s owed items. Downstream fix, not a defect in the Lean.
- **O2.** The L221 row of [lean/INDEX.md](../lean/INDEX.md) names L221aChain.lean in its text but not in its file column, while the statement row lists it. Add it to the column.
- **O3.** L221a_bound takes the Weyl property of D and each ν a as hypotheses. Composing with SM_components and L221a_crit would give the statement at a local maximiser W ∈ SM Q directly, with Weyl components derived. Not required by the record's footnote, but it is the form the rest of the chain would consume.
- **O4.** The Lean's conclusion is θ² ≤ 3/2 under θ > 0. The record's θ ≤ √(3/2) follows by Real.le_sqrt_of_sq_le, which compiles in screen2.lean.
- **O5.** The L221 statement row carries "statement: typed" both at its start and its end, pre-existing duplication.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** L221a_bound proves L221 (a) on the operators with no hypothesis the record lacks, the extra term and weakened norm in L220_bound_extra are sound, and the INDEX moves the statement row to partial correctly with (b) still owed. O1 and O2 are downstream edits to the record and the INDEX.
