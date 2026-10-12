# REVIEW r1655: L127's `𝒟ₙ` eigenspaces at `p = 2` (89fadaf2) and r1654's repairs (cbe3235c)

**Verdict: CONFIRMED WITH GAPS.** The lowering of `sphere_line`, `sphere_crossW`, `dn_spectrum` and `dn_eigen_parts` to `p, q ≥ 2` is sound, and the four eigenspace equalities at `p = 2` with their finranks are correct in both directions, including `p = q = 2` (`n = 4`, `𝒟₄` = line ⊕ cross, dimension 2). r1654's G1–G3 are repaired. The gaps are prose: the multiplicity sentence "the value `0` has multiplicity `q(q − 3)/2`" holds at `q ≥ 3` only (it reads `−1` at `q = 2`, where the eigenspace has dimension `0`), five headers and two INDEX sentences still tie `dn_spectrum` and `dn_eigen_parts` to `p, q ≥ 3`, and the Owed list omits the `p = 2` exclusion and dimension sum.

Analysis only. The runs were screens: the axiom audit on L127DnTwo.lean (12/12 clean on the standard three) and `lake env lean` on L127DnExcl.lean and L127DnSpan.lean (both exit 0, one unused-simp-argument warning at L127DnSpan.lean:190, pre-existing in `dn_decomp2`). The oleans of all six touched files postdate their sources.

## Claims

| # | Claim | Verdict | Notes |
|---|---|---|---|
| 1a | `sphere_line` at `p, q ≥ 2` | CONFIRMED | The proof (L127DnSpan.lean:356-367) uses the bounds only to feed `sphere_diagCrit` by `omega`, and `K_self` needs no range. No `p − 1 ≠ 0` and no `κ` enters. |
| 1b | `sphere_crossW` at `p, q ≥ 2` | CONFIRMED | The only divisions are by `p − 1` and `q − 1` (:377-378), nonzero at `≥ 2`. `K_crossW` needs no range. |
| 1c | `dn_spectrum` at `p, q ≥ 2` | CONFIRMED | Now built on `dn_decomp2` (:407). `sphere_lam` and `sphere_lam_compl` already sat under L127DnUnits.lean:70's `2 ≤` section variables, and `κ` enters only as `dnK`, rewritten by `compl_compl`. At `p = 2` the `λ_p` summand is `0` and its eigenvalue `0`, so the statement is true there with a degenerate part. |
| 1d | `dn_eigen_parts` at `p, q ≥ 2` | CONFIRMED | The one bound-carrying step is the uniqueness, now `dn_direct2` (L127DnMult.lean:88), sound at `p, q ≥ 2` by r1654. The callers in L127DnEig, L127DnExcl and L127DnLam pass `(by omega)` from their `3 ≤` hypotheses, signatures otherwise unchanged. |
| 1e | Headers after the lowering | CONFIRMED WITH GAPS | Stale `p, q ≥ 3` for the lowered lemmas at L127DnSpan.lean:13, :25, :389 and L127DnMult.lean:14, :38, and L127DnMult.lean:10, :16, :39 still name `dn_decomp`/`dn_direct` where the proof now uses `dn_decomp2`/`dn_direct2` (G2). |
| 2a | `dnLp_two` | CONFIRMED | `(2 − 2)/(2(2 − 1)) = 0` (L127DnEig.lean:64). |
| 2b | `dn_units_two` | CONFIRMED | At `q ≥ 2`, `λ_q = (q − 2)/(2(q − 1)) ∈ [0, 1)`, and `−μ = −q/(2(q − 1)) < 0` at `p = 2`. |
| 2c | `dnθ_ne_two` | CONFIRMED | `θ = t(q + 1)`, nonzero at `t ≠ 0`. |
| 3a | `dn_eig_line_two` both ways | CONFIRMED | Forward: `parts_two` drops the `λ_p` and `T`-side zero parts outright (`lamW_two_eq_zero`, `within_two_eq_zero`), and the others die at `1 ≠ λ_q` (`λ_q < 1`), `1 ≠ −μ`, `1 ≠ 0`. Backward: `sphere_line`. Dimension `1` by `finrank_sphereLine` at `≥ 1`. |
| 3b | `dn_eig_cross_two` both ways | CONFIRMED | Needs `−μ ≠ 1`, `−μ ≠ λ_q` (`−μ < 0 ≤ λ_q`), `−μ ≠ 0`, all from `dn_units_two`. Dimension `(2 − 1)(q − 1) = q − 1`. |
| 3c | `dn_eig_lamq_two` at `q ≥ 3` | CONFIRMED | `λ_q > 0` there separates it from `0`. Dimension `q − 1` by `finrank_lam` at `≥ 3`. At `q = 2`, `λ_q = 0` and the `λ_q` family is `{0}` (`lamW_two_eq_zero` on `Tᶜ`), so nothing is lost in the zero eigenspace: `dn_eig_zero_two`'s forward direction splits on `Tᶜ.card = 2` (L127DnTwo.lean:158-161) and kills the part by the vanishing lemma rather than by the eigenvalue. |
| 3d | `dn_eig_zero_two` and finrank `binom q 2 − q` | CONFIRMED | At `q ≥ 3` it is `finrank_withinSub`, `q(q − 3)/2`. At `q = 2`, `withinSub Tᶜ = ⊥` and the ℕ subtraction `1 − 2 = 0` matches. Check at `n = 4`: `dim 𝒟₄ = 4·1/2 = 2 = 1 + 1 + 0`. Checks at `q = 3, 4`: `1 + 2 + 2 + 0 = 5 = dim 𝒟₅`, `1 + 3 + 3 + 2 = 9 = dim 𝒟₆`. |
| 4 | "the value `0` has multiplicity `q(q − 3)/2`, the record's `λ_p^{p−1} = 0^1` and `0^rest` together" | CONFIRMED WITH GAPS | At `p = 2`: `rest = (q + 2)(q − 1)/2 − [1 + 1 + (q − 1) + (q − 1)] = (q² − 3q − 2)/2`, and `1 + rest = q(q − 3)/2`, correct at `q ≥ 3`. At `q = 2` `rest = −2`, and the record's zero count is `λ_p^1 + λ_q^1 + 0^{−2} = 0`, which the eigenspace (dimension 0) matches, but `q(q − 3)/2 = −1` there, so the sentence as written is false at `q = 2` and omits `λ_q^{q−1} = 0^1` (G1). |
| 5a | r1654 G1 | CONFIRMED | L127DnUnits.lean:25: direct sum at `p, q ≥ 2`, dimensions and count at `p, q ≥ 3`. |
| 5b | r1654 G2 | CONFIRMED | L127DnDirect.lean:10 cites `dn_decomp2` at `p, q ≥ 2`. |
| 5c | r1654 G3 | CONFIRMED | L127DnDim.lean:27 names `dn_direct2` at `p, q ≥ 2`. |
| 5d | Owed list | CONFIRMED WITH GAPS | "The mirror `q = 2`" is honest: `p ≥ 3`, `q = 2` has no declaration (`p = q = 2` is covered here). Missing from Owed: a `p = 2` exclusion (`dn_excl` is `3 ≤` only, L127DnExcl.lean:68) and a `p = 2` dimension sum (`dn_finrank_sum` is `3 ≤` only, L127DnCount.lean:41), so "the row reads …" at L127DnTwo.lean:21-23 is prose arithmetic, not a declaration (G3). |
| 6 | Axiom audit | CONFIRMED | 12/12 declarations clean on the standard three (screen). |
| 7 | INDEX row | CONFIRMED WITH GAPS | The `p = 2` passage matches the file, with G1's `q = 2` defect. Earlier in the row, "`dn_spectrum`, at the sphere product with $p,q\ge3$" and "`dn_eigen_parts`, at the sphere product with $p,q\ge3$ … (in `dn_decomp`'s decomposition)" are stale beside the new passage's "lowered to $p,q\ge2$" (G2). |

## What would break each claim, and what I did

- **Lowering (1a–1d):** a division by `p − 2` or a use of `κ ≠ 0` in the four proofs. Read each proof and `sphere_lam`'s section bound. None found. Kernel acceptance screened by compiling L127DnSpan.lean, L127DnExcl.lean and the audit's compile of L127DnTwo.lean.
- **Eigenspaces (3a–3d):** a coincidence of two unit values at `p = 2` that the forward direction ignores. The values are `1`, `λ_q ∈ [0, 1)`, `−μ < 0` and `0`, and the only coincidence is `λ_q = 0` at `q = 2`, handled at :158-161. A dimension mismatch at small `q`: checked `n = 4, 5, 6` by hand.
- **Multiplicity (4):** the record's `rest` at `q = 2`, which gives `−1` against a dimension `0`. Found (G1).
- **Owed (5d):** a `p = 2` declaration of exclusion or count. Grepped L127DnExcl and L127DnCount: none.

## Gaps

- **G1 (multiplicity at `q = 2`), [L127DnTwo.lean:21-23](../lean/HamiltonsCubic/Results/L127DnTwo.lean) and [lean/INDEX.md:495](../lean/INDEX.md).** "the value `0` has multiplicity `q(q − 3)/2`" reads `−1` at `q = 2`, where the eigenspace has dimension `0`. Qualify it to `q ≥ 3` and add that at `q = 2` `λ_q = 0` also joins, `1 + 1 + rest = 0`, the eigenspace being `{0}`.
- **G2 (stale ranges), [L127DnSpan.lean:13, :25, :389](../lean/HamiltonsCubic/Results/L127DnSpan.lean), [L127DnMult.lean:10, :14, :16, :38-39](../lean/HamiltonsCubic/Results/L127DnMult.lean), [lean/INDEX.md:495](../lean/INDEX.md).** `dn_spectrum` and `dn_eigen_parts` are stated at `p, q ≥ 2` and built on `dn_decomp2`/`dn_direct2`. The prose still gives `p, q ≥ 3` and the old lemma names.
- **G3 (Owed), [L127DnTwo.lean:24](../lean/HamiltonsCubic/Results/L127DnTwo.lean), [lean/INDEX.md:495](../lean/INDEX.md).** Add to Owed the `p = 2` exclusion (the `dn_excl` analogue) and the `p = 2` dimension sum, or mark the row sentence at :21-23 as arithmetic.
