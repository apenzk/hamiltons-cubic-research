# REVIEW r1750: L228's attainment in Lean (L228Attain.lean, commit d666a20e)

**Verdict: CONFIRMED WITH OBSERVATIONS.** `block_sphere`, `exists_card`, `L228_attained_even` and `L228_attained_odd` are true as typed, the balanced splits and their ranges are right, and the constants are character for character the constants of `L228_item3`/`L228_item3_odd`. The observations concern what the statements export (commuting rather than diagonal blocks, no joint sup theorem), none is a defect.

Footing: analysis only. One screen of seconds by hand on the two smallest cases (`thetaSplitSq 2 2 = 3/4 = theta0Sq 4`, `thetaSplitSq 2 3 = 8/9 = thetaOddSq 5`), reported as a screen. No `lake build` was run. The olean of `L228Attain` is dated 01:50, the commit time, the working copy of the file is clean against HEAD, and the file holds no `sorry`, `axiom` or `native_decide`. L227Attain.lean and L57Attain are taken as given, per the brief.

## (1) `block_sphere`

- Chain: `sphere_unit_block` gives `t > 0` with `normSq (diagOp (t • sphereWeight T)) = 1`, `sphereWeight_isWeight.smul` makes `w = t • sphereWeight T` an `IsWeight` (symmetric, hollow, zero row sums), `theta_sphereProduct_value` gives `theta (diagOp w) = thetaSplit |T| |Tᶜ|`, and `theta = Pcubic / norm ^ 3` with `norm = sqrt normSq = 1` turns it into `Pcubic (diagOp w) = thetaSplit |T| |Tᶜ|`. `Pcubic_norm_blocks` transfers `P` and the norm to `blockOp (Sw w) (Mw w) (Kw w)`.
- Remaining conjuncts: `Sw`, `Mw` are `Matrix.diagonal`, so symmetric, and the two commutations follow from `diagonal_mul_diagonal` and `mul_comm`. `Kw` symmetric and hollow from `hw.symm`, `hw.hollow`. Ricci-flatness is `ricci_blocks`. Sound.
- The hypotheses `p, q ≥ 2` are exactly those of `sphere_unit_block` and `theta_sphereProduct_value`. Nothing is assumed beyond them.
- Falsifier: a subset `T` of `Fin 3 ⊕ Fin m` with `|T|, |Tᶜ| ≥ 2` whose unit sphere weight read through `Sw`, `Mw`, `Kw` has `P ≠ θ_{|T|,|Tᶜ|}` or nonzero Ricci form. Either would refute an L227Attain or SphereValue lemma, which are given.

## (2) Balanced splits and ranges

- Even: `n = m + 3 = k + k`. `exists_card` gives `|T| = k`, `|Tᶜ| = m + 3 − k = k`. `thetaSplitSq_balanced k` (needs `k ≠ 0`, `k − 1 ≠ 0`, both from `k ≥ 2`) gives `theta0Sq (2k)`, and `sqrt(2(2k−1)(2k−2)/(2k)^2) = sqrt(2(n−1)(n−2))/n` by `Real.sqrt_div'` and `Real.sqrt_sq` at `2k > 0`. Right.
- Odd: `n = 2k + 1`, `|T| = k`, `|Tᶜ| = k + 1`. `thetaSplitSq_odd k` gives `ThetaSqOdd (2k+1) = 2(n−1)(n−3)/((n−2)(n+1))`, and `thetaOddSq_eq` identifies it with `L57Critical.thetaOddSq`, whose denominator is `(n+1)(n−2)`. Right.
- Ranges: even with `m ≥ 1` means `m` odd, so `n ≥ 4`, `k ≥ 2`. Odd with `m ≥ 2` means `m` even, so `n ≥ 5`, `k ≥ 2`. Both give `p, q ≥ 2`. The case `m = 0`, `n = 3` is correctly excluded (it would need `k = 1`). The even hypothesis `1 ≤ m` is implied by `Even (m + 3)` and is redundant, harmless.
- Screen: at `n = 4`, `3/4 = 3/4`, value `√12/4`. At `n = 5`, `8/9 = 8/9`, value `2√2/3`, which is L227's `Θ_5`.
- Falsifier: an `n` in range where the balanced split fails `p, q ≥ 2`, or where `θ_{k,k}² ≠ θ₀(2k)²` or `θ_{k,k+1}² ≠ Θ_{2k+1}²` as rational functions. Neither exists (both are `ring` identities after clearing denominators nonzero at `k ≥ 2`).

## (3) Match to "attained in D_n ⊆ S_J"

- The witness is `blockOp (Sw w) (Mw w) (Kw w)` with `w` a sphere weight, which is `IsWeight`, i.e. in `D_n` as conventions.md defines it (symmetric, hollow, `S1 = 0`), and by `wOf_blocks` the operator is `diagOp w`, a coordinate-diagonal Weyl tensor. It is a block operator with the `J = Fin 3` split, so it lies in L226's `blockOp` family, which is `S_J` by L226's identification. Unit norm and value `Θ_n`. This is the record's clause.
- The constants in `L228_attained_even`/`_odd` are the same expressions as the bounds in `L228_item3` (`sqrt(2(n−1)(n−2))/n`) and `L228_item3_odd` (`sqrt (L57Critical.thetaOddSq n)`), so the attained value equals the proved supremum. Together they make items 3 and 4 sharp. This is the reading the record needs.
- **Observation A.** The typed conclusion exports commuting blocks, not diagonal ones, and does not name `w` or `diagOp w`. So "in `D_n`" is visible in the proof and not in the statement. What the statement shows is: in the Ricci-flat block family, with pairwise commuting symmetric blocks. That still implies membership in item 3's hypothesis class (symmetric commuting blocks are simultaneously diagonalisable), but the Lean statement does not type that step. Exporting `∃ w, IsWeight w ∧ blockOp S M K = diagOp w` or `S, M a` diagonal would make the `D_n` clause literal. Same shape as r1749 at `n = 5`.
- **Observation B.** No single theorem types "`sup = Θ_n`" on items 3/4's stratum: the witness is a general `blockOp S M K` while `L228_item3_of` is stated at the normal form `S = ΣX − (Σt/2)I`, `M_a = t_a I + X_a`. The bridge is `blockOp_normal_form` (used in L227Full), so it is available, not assembled. Sharpness holds mathematically on the record's reading and is not claimed as a typed conjunction by the INDEX row.
- Falsifier: a sphere weight on `Fin 3 ⊕ Fin m` whose block reading leaves `S_J` (e.g. `Sw` reading a pair other than the complement of `x`), or a proved bound for items 3/4 strictly below the attained value. Neither occurs.

## (4) lean/INDEX.md L228 row

- The attainment sentence claims `block_sphere` with "diagonal, hence commuting, blocks": the diagonality is true of the witness built in the proof and the commuting is what is typed, so the phrase is accurate as a description of the witness (Observation A applies). `L228_attained_even` at even `n ≥ 4` and `L228_attained_odd` with the odd constant at odd `n ≥ 5` match the statements. "At `n = 5` this is L227's `L227_attained`" is right: `m = 2`, `k = 2`, `|T| = 2`, `|Tᶜ| = 3`.
- **Owed**: only the relabelling of items 2–4 to arbitrary blocks, which is prose. Consistent with items 2, 3, 4 being typed at block 0 (and 0, 1). Status `partial` remains appropriate for that.
- The record's Lean paragraph in findings/second-order.md was updated consistently ("L228 is typed at the operator except the relabelling to arbitrary blocks").
- Falsifier: an INDEX claim not backed by a typed statement. None found beyond the commuting/diagonal phrasing in Observation A.

## Axioms

Not rerun (no build). The file adds no axioms, and its dependencies are reported on the standard three. Taken as the author's audit.
