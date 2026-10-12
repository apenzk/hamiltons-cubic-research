# REVIEW r1651: L127DnLam.lean (83d7b992) and r1650's repairs (3d78757a)

**Verdict: CONFIRMED WITH GAPS.** Every declaration in L127DnLam.lean is correct and faithful to the record's `𝒟ₙ` row at `p, q ≥ 3`, `t ≠ 0`, and the audit is 13/13 clean on the standard three. r1650's G1 to G4 are repaired. The gaps are prose only: the file's closing claim that every eigenspace is declared rests on `dn_excl` for the absence of other values and does not cite it, and two small header wordings are left behind.

Analysis only. The one run was the axiom audit on one file, a screen of the axiom footprint.

## Claims

| # | Claim | Verdict | Notes |
|---|---|---|---|
| 1 | `dnLp_eq_dnLq_iff`: `λ_p = λ_q ↔ p = q` at `p, q ≥ 3` | CONFIRMED | `λ_p = (p − 2)/(2(p − 1)) = 1/2 − 1/(2(p − 1))` is strictly increasing for `p ≥ 2`, so injective. The proof cross-multiplies (denominators positive at `p, q ≥ 3`) and `nlinarith` closes the linear identity `(p − 2)(q − 1) = (q − 2)(p − 1) ⟺ p = q`. |
| 2a | `sum_extF` | CONFIRMED | The zero extension of `h : S → ℝ` sums over `S` to the subtype sum. |
| 2b | `lam_parts` | CONFIRMED | A member of `range (lamMap S (dnK S))` is `lamW S (dnK S) h` with `∑_S h = 0`, `h = extF S g`. |
| 2c | `lam_mem` | CONFIRMED | `lamW_isWeight` needs `κ · |Sᶜ| = −(|S| − 2)`, which `dnK S = −(|S| − 2)/|Sᶜ|` gives at `|Sᶜ| ≥ 1`. |
| 2d | `lamp_mem_eig`, `lamq_mem_eig` | CONFIRMED | `KL_of_fox` applied to `sphere_lam` and `sphere_lam_compl`. `lamq_mem_eig` rewrites `dnK Tᶜ` through `compl_compl` to the form `sphere_lam_compl` reads. Both hold at every `t`, and `ht` is correctly left out. |
| 2e | `lam_eig_parts` (private) | CONFIRMED | At `ν ∈ {θλ_p, θλ_q}` it kills the line, cross and both zero parts. The separations used are `λ ≠ 1` (`dn_units` `λ < 1`), `λ ≠ dnMu` (`dnMu < 0 < λ`) and `θλ ≠ 0` (`λ > 0`, `θ ≠ 0` by `dnθ_ne` at `t ≠ 0`). |
| 3a | `dn_eig_lamp`, `finrank_eig_lamp` (`p ≠ q`) | CONFIRMED | Forward: `lam_eig_parts` plus `θλ_q ≠ θλ_p` from `dnLp_eq_dnLq_iff` kills the `λ_q` part. Backward: `lam_parts`, `lam_mem`, `lamp_mem_eig`. Dimension `p − 1` by `finrank_lam T _ hp`. |
| 3b | `dn_eig_lamq`, `finrank_eig_lamq` (`p ≠ q`) | CONFIRMED | Mirror of 3a, `lam_mem Tᶜ` taking `|Tᶜᶜ| = p ≥ 1`. Dimension `q − 1` by `finrank_lam Tᶜ _ hq`. |
| 4a | `dn_eig_lam_eq` (`p = q`) | CONFIRMED | The `θλ_p`-eigenspace on weights equals `range lamMap T ⊔ range lamMap Tᶜ`. Forward keeps both parts, backward adds `lamq_mem_eig` after `dnLp = dnLq`. The `θλ_q`-eigenspace is the same subspace by the same equality and is left unstated, which is harmless. |
| 4b | `lam_disjoint` | CONFIRMED | `dn_direct` at `c = 0`, `X = Z = Z' = 0`, `h` and `−h'`: from `lamW T h = lamW Tᶜ h'` the sum `lamW T h − lamW Tᶜ h'` vanishes (`lamW_smul` at `−1`), so `lamW T h = 0`. The zero witnesses of `IsCrossW` and `IsWithinW` are discharged by the anonymous constructors. This is a correct use of uniqueness, and it needs no `t`. |
| 4c | `finrank_eig_lam_eq` = `2(p − 1)` | CONFIRMED | `finrank_sup_add_finrank_inf_eq`, the infimum `⊥`, both finranks `p − 1` after `← hpq`. |
| 5 | "the `𝒟ₙ` row declared eigenspace by eigenspace with its multiplicities at `p, q ≥ 3`, `t ≠ 0`" | CONFIRMED WITH GAPS | With L127DnEig (`θ`: 1, `θ(−μ)`: `(p − 1)(q − 1)`, `0`: `binom p 2 − p + binom q 2 − q`) all five values carry declared eigenspaces with the record's multiplicities. "Every eigenspace" also needs that no other value occurs. That is `dn_excl` in L127DnExcl.lean:68, which neither the file header (L127DnLam.lean:19-20) nor the INDEX passage cites (G1). |
| 6a | r1650 G1 (headers qualify L127DnEig) | CONFIRMED | L127Dn:26, L127DnUnits:26, L127DnSpan:31, L127DnExcl:20, L127DnDirect:18 and L127DnDim:27-28 now cite L127DnEig with L127DnLam, and the `λ_p = λ_q` merge in L127DnDim is now declared (`finrank_eig_lam_eq`). |
| 6b | r1650 G2 (Owed list) | CONFIRMED | The λ eigenspaces are dropped from **Owed**, being declared. |
| 6c | r1650 G3 (audit count) | CONFIRMED | Both the L127DnEig and L127DnLam passages end "13/13 on the standard three". |
| 6d | r1650 G4 (de6caf42 body) | CONFIRMED | Recorded in 3d78757a's body. The criterion is `dnLp_eq_dnLq_iff`. |
| 6e | Headers mutually consistent | CONFIRMED WITH GAPS | Consistent in substance. L127DnEig.lean:13-14 still asserts the unit values distinct except `λ_p = λ_q` at `p = q` without naming `dnLp_eq_dnLq_iff`, and L127DnSpan.lean:30-31 lists three files with no conjunction (G2). |
| 7 | Axiom audit | CONFIRMED | `axiom_audit.py --only L127DnLam.lean`: 13/13 clean on the standard three. No `sorry` or `native_decide` in the file. Imported at lean/HamiltonsCubic.lean:171. |

## Breakers, and the search for them

- **Claim 1** breaks on a pair `p ≠ q ≥ 3` with equal `λ`. The strict monotonicity of `1/2 − 1/(2(p − 1))` excludes it. At `p = 2` both sides hit `λ = 0`, outside the hypotheses.
- **Claims 3 and 4** break on a weight in the `θλ_p`-eigenspace with a nonzero line, cross or zero-family part, or a nonzero `λ_q` part at `p ≠ q`. I checked each separation `lam_eig_parts` relies on against `dn_units` and `dnθ_ne`. A collision `θλ = 0` needs `t = 0`, which `ht` excludes. `λ = 1` and `λ = dnMu` are excluded by the sign bounds.
- **Claim 4b** breaks on a nonzero matrix in both `λ` families. `dn_direct` excludes it at `p, q ≥ 3`. By hand, `lamW T h` vanishes on `Tᶜ × Tᶜ` and `lamW Tᶜ h'` vanishes on `T × T`, which gives a second route to the same conclusion.
- **Claim 5** breaks on an eigenvalue outside the five. `dn_excl` excludes it, and I confirmed that its statement lists exactly `θ·1, θλ_p, θλ_q, θ·dnMu, 0`.

## Gaps

- **G1 (prose, minor), [L127DnLam.lean:19-20](../lean/HamiltonsCubic/Results/L127DnLam.lean), and the INDEX L127 row's sentence "So the $\mathcal D_n$ row is declared eigenspace by eigenspace", [lean/INDEX.md:495](../lean/INDEX.md).** The completeness claim needs `dn_excl` (L127DnExcl.lean:68) for "no other eigenvalue". Cite it in both places.
- **G2 (prose, minor), [L127DnEig.lean:13-14](../lean/HamiltonsCubic/Results/L127DnEig.lean) and [L127DnSpan.lean:30-31](../lean/HamiltonsCubic/Results/L127DnSpan.lean).** L127DnEig's distinctness sentence should cite `dn_units` together with L127DnLam's `dnLp_eq_dnLq_iff`. L127DnSpan's list "L127DnDim.lean and L127DnEig.lean, L127DnLam.lean give" should read "L127DnDim.lean, L127DnEig.lean and L127DnLam.lean give".
- **G3 (prose, minor), [L127DnLam.lean:12-17](../lean/HamiltonsCubic/Results/L127DnLam.lean).** The header's bullet list omits `sum_extF`, `lam_parts`, `lamp_mem_eig` and `lamq_mem_eig`, and it mentions `lam_disjoint` only by its content. The sibling headers list every public declaration.
