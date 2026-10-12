# REVIEW r1864: Gate 2 verdicts on L226 item 2 at every k (L226Gen.lean) and L149's unique split (L149Bridge.lean)

*Cold brief, analysis-only footing. Read at source: [L226Gen.lean](../lean/HamiltonsCubic/Results/L226Gen.lean), [L226Mixed.lean](../lean/HamiltonsCubic/Results/L226Mixed.lean), [L226Statement.lean](../lean/HamiltonsCubic/Results/L226Statement.lean) (blockCoeff, blockOp, opOf, pairing, opOf_isSkew, E3, eps_table), [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) (IsWeyl, bianchi, Ric, inner2, phi), Lemma L226 in [second-order.md](../findings/second-order.md) (Setting, item 2, proof steps 4 and 5, Gate 1 (d)), [L149Bridge.lean](../lean/HamiltonsCubic/Results/L149Bridge.lean), [REVIEW_r1862.md](REVIEW_r1862.md), [RecordNormed.lean](../lean/HamiltonsCubic/Results/RecordNormed.lean) (RecCurv, RecCurv.equiv, the inner product), [L24Restrict.lean](../lean/HamiltonsCubic/Results/L24Restrict.lean) (weylPerpR, LeRestr), [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) (CurvOp2, innerOp2, normSq2, normSq2_eq_zero), [CurvOpInner.lean](../lean/HamiltonsCubic/Results/CurvOpInner.lean) (curvOpCore), the staged diffs of [lean/INDEX.md](../lean/INDEX.md) and [L3Attain.lean](../lean/HamiltonsCubic/Results/L3Attain.lean). Run: one `lake env lean` on a scratch file in /private/tmp/r1864/ carrying `#print axioms` for five theorems and three `example` screens (the k = 3 coefficient bridge, the redundancy of anti2, and the vanishing of every curvature array at k = 1). No sweep, no numerics.*

| # | Claim | Verdict |
|---|---|---|
| 1 | isWeyl_blockOpG_iff is item 2 at every k under IsCurvArray, symmetric M_a, symmetric hollow K | CONFIRMED WITH OBSERVATIONS (O1, O2) |
| 2 | blockOpG is the record's block operator: pairing_J gives R_pqrs on J, the M and K blocks are the k = 3 file's | CONFIRMED |
| 3 | rhoJ R p q = Σ_r R p r q r is the record's ρ(R_J)_pq | CONFIRMED |
| 4 | BianchiJ is the base layer's bianchi restricted to J | CONFIRMED |
| 5 | split_eq_proj and split_unique make w = ‖H_r‖ a function of H, and L149_hmargin can no longer be met by w = 0 at an H with H_r ≠ 0 | CONFIRMED |
| 6 | INDEX rows L226, L149, L3 | CONFIRMED WITH OBSERVATIONS on L226 ("item 2 verbatim", O1), CONFIRMED on L149 and L3 |

**Summary: both repairs hold. isWeyl_blockOpG_iff is item 2 on every operator of the block form at every k, the record's reduction of an arbitrary W ∈ S_J to that form staying with the block note, and IsSplit pins H_s to the orthogonal projection, so r1862's O1 is closed.**

## A. Hypothesis inventory, used and unused

- IsCurvArray carries anti1, anti2 and pair. anti1 and anti2 are used in pairing_J and Ric_blockOpG_J to fold the four terms of pairing into R p q r s. pair is used in blockCoeffG_symm, hence self-adjointness, which IsWeyl's second clause needs. anti2 is derivable from anti1 and pair (R p q s r = R s r p q = −R r s p q = −R p q r s), screened as a one-line `example`. It is a redundant field and costs nothing (O2).
- Nothing item 2 needs is missing. The record's R_J is "a symmetric R_J on Λ²ℝ^J", which in the array reading is exactly antisymmetry in each pair plus pair symmetry. Bianchi is the item's condition, so it rightly sits on the right of the iff and outside IsCurvArray.
- hM (M_a symmetric) is used only in the reverse direction, by blockCoeffG_symm and blockOpG_bianchi_mixed. The forward direction goes through ricciFlatG_iff, which needs no hM. That matches the record, where the M_a are symmetric by the Setting.
- hK is used by Ric_blockOpG_outer (the term at b ≠ a collects K a b and K b a), by K_pat and by bianchi_K. hK0 is used only by Ric_blockOpG_outer to turn Σ_b K a b into the record's Σ_{b≠a} K_ab. blockCoeffG ignores K a a entirely (its K entry requires a ≠ b), so hK0 changes the Ricci condition's reading and nothing else.
- hR is used in both directions through pairing_J.

## B. IsCurvArray plus BianchiJ against "R_J satisfies the first Bianchi identity on ℝ^J", and blockOpG_bianchi_mixed

- The base layer's bianchi R i j k l is ⟨R φ_ij, φ_kl⟩ + ⟨R φ_ik, φ_lj⟩ + ⟨R φ_il, φ_jk⟩, the cyclic sum over the last three slots. pairing_J turns the three terms on J into R p q r s, R p r s q, R p s q r, which is BianchiJ term for term, and blockOpG_bianchi_J is that rewrite. Same convention, same index order.
- BianchiJ quantifies over all p, q, r, s, repeated indices included. Under IsCurvArray every repeated-index instance holds already (the record's step 4 remark), so this is the same condition as the one over distinct indices.
- blockOpG_bianchi_mixed: each of the three pairing terms expands through pairing into four values of blockCoeffG whose arguments are permutations of the same four indices (i, j, l, t). blockCoeffG returns an entry of R only when all four arguments are inl. So if any of i, j, l, t is inr, no term reads R, and the statement for every R is exactly right. I looked for a mixed pattern that reaches R, such as three J indices with one outer, and every such argument tuple falls to the default `_ => 0` branch. Found none.
- The remaining mixed sums reduce to M and K entries and vanish by the pair symmetries of M_a and K, the record's step 4. The proof closes them by the k = 3 file's tactic list with bianchi_K for the all-outer block.

## C. Edge cases

- k = 0: J is empty, IsCurvArray and BianchiJ are vacuous, rhoJ is the 0 × 0 matrix and tr M_a = 0. The theorem reads IsWeyl ↔ Σ_b K a b = 0 at every a, which is right for an operator carrying only the outer block. The record fixes k ≥ 2, so this and k = 1 lie outside it and are harmless extensions.
- k = 1: anti1 at p = q forces R = 0 (screened as an `example`), rhoJ = 0, and the theorem reads Σ_a M_a = 0 and M_a + Σ_b K a b = 0 on 1 × 1 blocks. Right: V_a is the line of φ_pa.
- m = 0: no outer index, sums over Fin 0 vanish, and the theorem reads IsWeyl(R_J) ↔ BianchiJ ∧ rhoJ R = 0. Right.
- k = 2: the only free entry is κ = R 0 1 0 1. rhoJ 0 0 = R 0 1 0 1 = κ, rhoJ 1 1 = R 1 0 1 0 = κ, rhoJ 0 1 = R 0 0 1 0 + R 0 1 1 1 = 0. So ρ(R_J) = κI with κ = ⟨R_J φ_01, φ_01⟩, the record's K_jk, and BianchiJ holds automatically since four indices from two repeat. Item 2 then reads Σ_a M_a = −κI, the record's Gate 1 (d). Agrees.

## D. Agreement with L226Mixed at k = 3

- blockCoeff and blockCoeffG are the same pattern match except the all-J entry, which is Σ_{x,y} ε_pqx ε_rsy S_xy in the first and R p q r s in the second. So blockOp S M K is blockOpG R_S M K at R_S p q r s := Σ ε ε S. Screened as an `example` proving blockCoeff S M K = blockCoeffG R_S M K by case split and rfl.
- R_S satisfies IsCurvArray: anti1 and anti2 from eps_swap12 in either ε, pair from S symmetric and a sum swap.
- rhoJ R_S = (tr S)I − S by the J part of Ric_blockOp_J.
- BianchiJ R_S holds for every symmetric S (L226Mixed's blockOp_bianchi on the all-J block, item 3's automatic Bianchi).
- So isWeyl_blockOpG_iff at R_S reads IsWeyl ↔ True ∧ (tr S)I − S + Σ M_a = 0 ∧ the outer condition, which is isWeyl_blockOp_iff. They agree. No Lean lemma states this bridge. The bridge is available from the lemmas above, and nothing in the file claims it (O3).

## E. The IsSplit repair

- Sufficiency for uniqueness: IsSplit gives Hs Weyl and ⊥ a with LeLin a Hs = c Hs, so its image in weylPerpR a lies in E, the c-eigenspace of LeRestr. It gives Hr Weyl and ⊥ a and orthogonal to every Weyl, ⊥ a, c-eigenvector K, which is every element of E, so Hr's image lies in Eᗮ. With Hs + Hr = H this is Mathlib's eq_starProjection_of_mem_orthogonal'. The four conjuncts r1862's O2 asked for (IsWeyl2 and ⊥ a on both pieces) are present, and they are what make both images live in weylPerpR a.
- The inner product on RecCurv is recCore = curvOpCore, whose inner is innerOp2, and normSq2 is definite (normSq2_eq_zero). So Eᗮ is taken in the record's pairing and the orthogonality conjunct, stated with innerOp2, is the same orthogonality.
- The ½ disjunct in IsSplit's last clause only strengthens the property. It is needed for existence, which L149_margin_N supplies through horb and the eigenvalue gap LP ≠ ½, and it cannot break uniqueness.
- H entirely in E: the projection is H, the split is Hs = H, Hr = 0, and 0 meets every Hr conjunct. H entirely in Eᗮ: the projection is 0, Hs = 0 is in E (the eigenspace contains 0), Hr = H. The Mathlib lemma is stated for arbitrary u = s + r with s ∈ K, r ∈ Kᗮ and has no nonzero hypothesis, so both extremes are covered.
- The closing `rfl` in split_eq_proj holds because RecCurv.equiv is LinearEquiv.refl and tanV is the coercion back.
- split_unique derives IsWeyl2 H and H ⊥ a from the first split, applies split_eq_proj twice, and cancels Hs in RecCurv. Sound.
- Claim 5: L149_hmargin returns ∃ Hs Hr, IsSplit … H Hs Hr ∧ bound in Real.sqrt (normSq2 Hr) ^ 2. By split_unique every witness Hr is the projection's complement, and by definiteness normSq2 Hr = 0 only when that complement is 0. So at an H with nonzero H_r no witness with w = 0 exists, and the bound is a statement about the true ‖H_r‖. The hollowness r1862 found is gone. The same holds for L149_margin_unit and L149_margin_N, which now also return IsSplit.

## F. Axioms

`#print axioms` on isWeyl_blockOpG_iff, ricciFlatG_iff, split_unique, split_eq_proj and L149_hmargin returns [propext, Classical.choice, Quot.sound] for all five, the standard three. The three `example` screens (blockCoeff S M K = blockCoeffG (Σ ε ε S) M K by case split and rfl, anti2 from anti1 and pair, every IsCurvArray on Fin 1 is zero) compiled in the same run, exit 0. The oleans of L226Gen and L149Bridge are newer than their sources, so the report is on the staged text.

## G. Do the INDEX rows claim more than the Lean proves?

- L226 row: the status moves from proved to partial, and the Owed list drops item 2 at k ≠ 3 and keeps item 1 at k ≠ 3. That matches the file. The row lists IsCurvArray and the definitions, so the hypotheses are visible.
- L226 row, "item 2 verbatim": item 2 quantifies over every W ∈ S_J. isWeyl_blockOpG_iff quantifies over operators of the form blockOpG R M K. That every W ∈ S_J has this form is the block note's character argument, which the record cites and which is untyped. At k = 3 the earlier file had the same scope and the row did not flag it. "Item 2 on the block form" would say exactly what is proved (O1).
- L149 row: "the split's defining properties force H_s to be the orthogonal projection, so w = ‖H_r‖ is a function of H" is split_eq_proj and split_unique as stated. "every unit H ∈ N has c_p + ρ^eff w² ≤ c(H) with w = ‖H_r‖ of its split" is L149_hmargin as stated, H ∈ N being read as Weyl, ⊥ M and ⊥ every ½-eigenvector (r1862 O4, unchanged). The Owed list now carries the w tie to hop, the eigenspace identification (r1862 O6) and branch 2's penalised numerator (r1862 O3). Nothing overstated.
- L3 row and the L3Attain docstring now say "at p, q ≥ 3, (p, q) ≠ (3, 3)", which answers r1862's O5.

## H. Objects that would break each statement

- Claim 1: an R with the curvature symmetries whose block operator is Weyl while some Bianchi sum on J is nonzero, or the reverse. blockOpG_bianchi_J makes the two sums equal term for term, so none exists. A mixed Bianchi sum reading R would break the reverse direction. I enumerated the argument tuples of pairing and found that every mixed tuple hits the default branch.
- Claim 2: a J-to-outer cross entry that is nonzero, which would make blockOpG leave S_J. Every such tuple (three inl and one inr, or two inl in the wrong slots) is the default 0. I read the M entries (p, a, q, b) in all four orders and checked pairing gives M a p q at a = b and 0 otherwise, and K entries give K_ab on φ_ab.
- Claim 3: a factor or sign in the Ric contraction on J. Ric sums c over J ⊕ A, the J part is pairing (p, r, q, r) = R p r q r, and the A part is M a p q. The record's ρ is the J part. At k = 2 it gives κI as Gate 1 (d) says.
- Claim 4: a cyclic sum over a different slot triple. Base bianchi cycles j, k, l with i fixed, and BianchiJ cycles q, r, s with p fixed, in the same order.
- Claim 5: two splits of one H with different Hr. The eigenspace and orthogonal complement argument excludes it. A nonzero Hr of zero normSq2 would reopen w = 0, and normSq2_eq_zero excludes it.
- Claim 6: a row sentence stronger than a statement. The only one found is "item 2 verbatim" (O1).

## Observations

- **O1.** isWeyl_blockOpG_iff is item 2 for operators of the block form blockOpG R M K. Item 2 is stated for every W ∈ S_J, and the step from W ∈ S_J to that form is the block note's, untyped here as it was at k = 3. The INDEX's "item 2 verbatim" reads as covering that step. Suggested wording: "item 2 on the block form, the reduction of W ∈ S_J to it being the block note's".
- **O2.** IsCurvArray.anti2 follows from anti1 and pair (screened). Harmless, and it shortens nothing downstream to drop it.
- **O3.** No lemma states blockOp S M K = blockOpG (Σ ε ε S) M K, though the screen closes it by case split and rfl. With it, L226Mixed's isWeyl_blockOp_iff would be a corollary of the general theorem plus eps_swap12 and blockOp_bianchi. Optional.
- **O4.** isWeyl_blockOpG_iff and its lemmas hold at k = 0 and k = 1, outside the record's k ≥ 2. Harmless.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS. isWeyl_blockOpG_iff is item 2 at every k on the block form, with rhoJ, BianchiJ and blockOpG matching the record and the base layer, and it agrees with the k = 3 file through the ε table. IsSplit, split_eq_proj and split_unique close r1862's O1: L149_hmargin's w is ‖H_r‖ of the unique split and cannot be zero where H_r is not. One wording repair in the L226 row (O1).**
