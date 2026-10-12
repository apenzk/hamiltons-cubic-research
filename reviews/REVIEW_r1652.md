# REVIEW r1652: L127DnSpan.lean at p, q ≥ 2 (99fe08d6) and r1651's repairs (fa4878cf)

**Verdict: CONFIRMED WITH GAPS.** `dnR_rows` and `dn_decomp2` are correct at `|S|, |Sᶜ| ≥ 2`, the division-by-zero reading at `|S| = 2` is a legitimate use of the convention, and the decomposition's `p = 2` members are the zero weights the record says they are. The `p, q ≥ 3` wrapper leaves every caller unchanged, and the audit is 21/21 clean on the standard three. r1651's G1 and G3 are repaired, G2 in part. The gaps are prose: the INDEX span passage and L127Dn's header still read `p, q ≥ 3` and `20/20`, and two small wordings are left behind.

Analysis only. The one run was the axiom audit on one file, a screen of the axiom footprint.

## Claims

| # | Claim | Verdict | Notes |
|---|---|---|---|
| 1a | `dnH S u = 0` at `|S| = 2` | CONFIRMED | `dnH` divides by `|S| − 2 = 0`, and `div_zero` gives `0`. `dnK S = −0/|Sᶜ| = 0` too. This is legitimate: the `λ_p` family is `{0}` at `p = 2` (claim 2a), so a zero coefficient is the right one, and every use of `dnH` downstream goes through `lamW S (dnK S)`, which is `0` there. `dnH_sum` at `|S| = 2` holds trivially and is used only as the family's side condition. |
| 1b | `∑_{Sᶜ} u_{a·} = |Sᶜ| m` at `S = {x, y}` | CONFIRMED | Row `x`: `∑_{Sᶜ} u_{x·} = −(u_xx + u_xy) = −u_xy` by hollowness. Row `y`: `−u_yx = −u_xy` by symmetry. Then `m = (−u_xy − u_xy)/(2|Sᶜ|) = −u_xy/|Sᶜ|`, so `|Sᶜ| m = −u_xy`, which is each row's `Sᶜ`-sum. L127DnSpan.lean:170-186. |
| 1c | Both residual sums vanish at `|S| = 2` | CONFIRMED | With the `λ` terms `0`: within, `∑_S u_{a·} + m|Sᶜ| = −∑_{Sᶜ} u_{a·} + m|Sᶜ| = 0`, and across, `∑_{Sᶜ} u_{a·} − m|Sᶜ| = 0`, using the sphere weight's row sums `|Sᶜ|` and `−|Sᶜ|` (`swS`, `swSc`, valid at `|S| ≥ 2` since `A = |Sᶜ|/(|S| − 1)`). Cross-checked on an entry: `dnR_{xy} = u_xy + m·q = 0` at `A = q/(2 − 1)`. |
| 1d | `dnR_rows` at `|S| ≥ 3` | CONFIRMED | The `field_simp; ring` branch is the old proof with `|S| − 2 ≠ 0` now a case hypothesis. |
| 2a | `dn_decomp2`'s `λ_p` piece at `p = 2` | CONFIRMED | The witness is `lamW T 0 0 = 0`. More strongly, every admissible member vanishes: `lamW T κ h` has entry `h_x + h_y = 0` on the pair (`∑_T h = 0`) and `κ h = 0` across (`dnK T = 0`). So the statement's `λ_p` slot ranges over `{0}`, the record's reading (second-order.md, L127 `𝒟ₙ` row, and L127Dn.lean:26-29). |
| 2b | `IsWithinW T Z` at `|T| = 2` forces `Z = 0` | CONFIRMED | Row `x`: `Z_xx + Z_xy = Z_xy = 0`, and `Z` is supported in `T × T` and symmetric. |
| 2c | `dn_decomp2` at `p, q ≥ 2` | CONFIRMED | The residual split into cross, within-`T` and within-`Tᶜ` pieces is the old argument, fed `dnR_rows` at `≥ 2` on both sides (`dnR_rows Tᶜ` via `dnR_compl`). The six families' dimensions at `p = 2`: `1 + 0 + (q − 1) + (q − 1) + 0 + q(q − 3)/2 = binom(q + 2, 2) − (q + 2)`, matching `dim 𝒟ₙ`, so the spanning claim fits the count (hand check, not declared). |
| 3 | `dn_decomp` wrapper and callers | CONFIRMED | `dn_decomp2 T hu (by omega) (by omega)`, same statement as before. Callers: L127DnExcl.lean:77, L127DnEig.lean:95, L127DnLam.lean:84, all at `p, q ≥ 3`, all unchanged and building. `dn_spectrum` keeps `p, q ≥ 3`. |
| 4a | r1651 G1 | CONFIRMED | L127DnLam.lean:22-23 and the INDEX sentence both cite `dn_excl`. |
| 4b | r1651 G2 | CONFIRMED WITH GAPS | L127DnSpan's list is repaired (lines 30-31). L127DnEig.lean:13-14 cites `dnLp_eq_dnLq_iff` for `λ_p = λ_q`, and the remaining distinctness (`1`, `λ`, `−μ`, `0`) still names no source (`dn_units`), which r1651 G2 asked for (G4 below). |
| 4c | r1651 G3 | CONFIRMED | L127DnLam's header now names every public declaration (checked against its 13 public theorems, `lam_eig_parts` being private). |
| 5 | **Owed** list | CONFIRMED WITH GAPS | Honest: no eigenspace, `dn_spectrum`, `dn_direct` or `dn_excl` is declared at `p = 2` or `q = 2`, and "the eigenspaces at `p = 2` or `q = 2` as declarations" covers that. The `p = 2` vanishing of the `λ_p` and within-`T` members is asserted in `dn_decomp2`'s docstring (L127DnSpan.lean:194-195) and is undeclared (G5). |
| 6 | Axiom audit | CONFIRMED | `axiom_audit.py --only L127DnSpan.lean`: 21/21 clean on the standard three. No `sorry` or `native_decide` in the file. Imported at lean/HamiltonsCubic.lean:164. |

## Breakers, and the search for them

- **Claim 1a** breaks if some consumer read `dnH` at `|S| = 2` as a genuine coefficient rather than through `lamW S 0`. I grepped every use of `dnH`, `dnR_rows` and `dn_decomp` in lean/: `dnH` appears only in L127DnSpan, always inside `lamW S (dnK S)`.
- **Claim 1b** breaks on a weight with `u_xy ≠ −∑_{Sᶜ} u_{y·}`. Symmetry and the zero row sum of `IsWeight` exclude it, and both hypotheses are used (`hu.symm y x`, `hu.rowSum`).
- **Claim 2a** breaks on a nonzero `lamW T 0 h` with `∑_T h = 0` on a 2-set. The within entry is `h_x + h_y = 0` and every cross entry carries the factor `κ = 0`, so none exists.
- **Claim 2c** breaks on a weight at `p = 2` outside the span. The dimension count above equals `dim 𝒟ₙ` for every `q ≥ 2`, and the smallest case `n = 4`, `p = q = 2` has `dim 𝒟ₙ = 2` against line `1` plus cross `1`.
- **Claim 3** breaks on a caller whose use of `dn_decomp` changed. The three `obtain` sites use the unchanged signature.

## Gaps

- **G1 (INDEX), [lean/INDEX.md:495](../lean/INDEX.md), passage "And the families span $\mathcal D_n$".** It still reads `dn_decomp`, at $p,q\ge3$, and closes "20/20 on the standard three". The file now audits 21/21, and the new passage "And the spanning at $p=2$ or $q=2$" carries no count. Update the count, and name `dn_decomp` as the $p,q\ge3$ form of `dn_decomp2`.
- **G2 (header, downstream), [L127Dn.lean:24](../lean/HamiltonsCubic/Results/L127Dn.lean).** "L127DnSpan.lean shows the families span `𝒟ₙ` at `p, q ≥ 3`" is stale. The spanning now holds at `p, q ≥ 2`.
- **G3 (header), [L127DnSpan.lean:11-13, 23-24](../lean/HamiltonsCubic/Results/L127DnSpan.lean).** The `dn_spectrum` bullet and the opening sentence ("`M ∘` on `𝒟ₙ` is spanned by eigenvectors with these eigenvalues") carry no range, while `dn_spectrum` holds at `p, q ≥ 3` only. Qualify both.
- **G4 (header, r1651 G2 residue), [L127DnEig.lean:13-14](../lean/HamiltonsCubic/Results/L127DnEig.lean).** Cite L127DnUnits' `dn_units` for the distinctness of `1`, `λ`, `−μ`, `0`, beside `dnLp_eq_dnLq_iff`.
- **G5 (Owed, minor), [L127DnSpan.lean:194-195](../lean/HamiltonsCubic/Results/L127DnSpan.lean).** The docstring's "At `p = 2` the `λ_p` weight and the zero weight inside `T` vanish" is true (claims 2a, 2b) and is stated by no declaration. Either declare it (two short lemmas, `lamW` at `dnK T = 0` on a 2-set, `IsWithinW` on a 2-set) or add it to **Owed**.
