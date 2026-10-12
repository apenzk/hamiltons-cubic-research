# REVIEW r1653: r1652's repairs to the L127 𝒟ₙ layer (b9fd12ad)

**Verdict: CONFIRMED WITH GAPS.** `lamW_two_eq_zero` and `within_two_eq_zero` are correct, faithful to the record's "at `p = 2` the `λ_p` and `T`-side zero families are `{0}`", and audit 23/23 clean on the standard three. r1652's G1, G2, G4 and G5 are repaired and G3 is repaired in the file. The gaps are prose: the INDEX row's `dn_spectrum` sentence still carries no `p, q ≥ 3`, L127DnUnits' header still says the families span at `p, q ≥ 3`, and L127DnSpan's header list omits the two new lemmas.

Analysis only. The one run was the axiom audit on one file, a screen of the axiom footprint.

## Claims

| # | Claim | Verdict | Notes |
|---|---|---|---|
| 1a | `lamW_two_eq_zero`: at `|S| = 2`, `∑_S h = 0`, `lamW S (dnK S) h = 0` | CONFIRMED | `dnK S = −(2 − 2)/|Sᶜ| = 0`, so the two cross branches of `lamW` (L127Dn.lean:186-188) are `0 · h`. The within branch at `{x, y}` off the diagonal is `h_x + h_y` or `h_y + h_x`, both `0` by `Finset.sum_pair`. The diagonal is `0` by definition. The proof's four cases match this exactly (L127DnSpan.lean:242-260). |
| 1b | Fidelity of 1a | CONFIRMED | The `λ` family everywhere downstream is `lamW S (dnK S) h` with `∑_S h = 0` (L127DnLam.lean:48, `dn_decomp2`'s statement at L127DnSpan.lean:199), and the eigen-family of L127DnUnits.lean:108 uses the literal `−(|T| − 2)/|Tᶜ|`, which is `dnK T` unfolded. So the lemma covers every member of the family the record calls `λ_p`, which is the `{0}` claim. |
| 2a | `within_two_eq_zero`: `IsWithinW S Z` at `|S| = 2` forces `Z = 0` | CONFIRMED | Row `x`: `Z_xx + Z_xy = 0` with `Z_xx = 0` gives `Z_xy = 0`, symmetry gives `Z_yx`, the diagonal is `0`, and `IsWithinW`'s support clause (L127DnSpan.lean:48-49) kills every entry with an index outside `S`. The `omit [Fintype ι]` is sound since nothing sums over `ι`. |
| 2b | Fidelity of 2a | CONFIRMED | `IsWithinW S` is the zero family inside `S` as `dn_decomp2` and `withinSub` use it, so `{0}` at `|S| = 2` is the record's `T`-side zero family vanishing. The mirror at `q = 2` is the same lemma at `S = Tᶜ`. |
| 3 | r1652 G1 (INDEX counts and `dn_decomp2`) | CONFIRMED WITH GAPS | lean/INDEX.md:495 now names `dn_decomp2`, reads 23/23 in both span passages, and cites the two new lemmas. The spanning passage still says "`dn_spectrum`, at the sphere product each summand is an eigenvector ..., so $\mathcal D_n$ is spanned by eigenvectors" with no `p, q ≥ 3`, the INDEX twin of r1652 G3 (G1 below). |
| 4 | r1652 G2 (L127Dn header) | CONFIRMED WITH GAPS | L127Dn.lean:25 reads `p, q ≥ 2`. The same stale sentence survives downstream at L127DnUnits.lean:22, "that they span it at `p, q ≥ 3`" (G2 below). L127Dn.lean:26 names the eigenspaces with no `t ≠ 0` (G4 below, minor). |
| 5 | r1652 G3 (L127DnSpan header ranges) | CONFIRMED | L127DnSpan.lean:12-13 and :23 give spanning `p, q ≥ 2` and `dn_spectrum` `p, q ≥ 3`, matching the `section sphere` variables `hp : 3 ≤ T.card`, `hq : 3 ≤ Tᶜ.card` included at :386. |
| 6 | r1652 G4 (distinctness source) | CONFIRMED | L127DnEig.lean:13-15 cites `dn_units` and `dnLp_eq_dnLq_iff`, with `p, q ≥ 3` and `t ≠ 0`. |
| 7 | r1652 G5 (p = 2 vanishing declared) | CONFIRMED WITH GAPS | Declared (claims 1, 2) and cited in `dn_decomp2`'s docstring (:195) and the INDEX row. L127DnSpan's header list (:14-27) names no new lemma, against the standing rule that headers name every public declaration (r1651 G3), and L127DnUnits.lean:26's "`{0}`" sentence still cites neither (G3 below). |
| 8 | Range grep | CONFIRMED WITH GAPS | Grep of "≥ 3", "≥ 2" and "t ≠ 0" over L127Dn*.lean: Span, Eig, Lam, Mult, Excl, Direct, Count, Dim consistent (spanning `≥ 2`, spectrum, direct sum, count and eigenspaces `≥ 3`, eigenspaces `t ≠ 0`). Off: L127DnUnits.lean:22 (G2) and L127Dn.lean:26 (G4). |
| 9 | Axiom audit | CONFIRMED | `axiom_audit.py --only L127DnSpan.lean`: 23/23 clean on the standard three, the count r1652 saw (21) plus the two lemmas, so the file builds. |

## Breakers, and the search for them

- **1a** breaks on a pair `S` and zero-sum `h` with a nonzero entry of `lamW S (dnK S) h`. Every entry is diagonal (`0`), within (`±(h_x + h_y) = 0`) or carries the factor `dnK S = 0`, and entries with neither index in `S` are `0`. None exists. I read `lamW`'s four branches.
- **1b** breaks if some consumer's `λ` family used a `κ` other than `dnK S`, where a nonzero cross entry `κ h_x` survives at `h_x = −h_y ≠ 0`. I grepped `lamW` across L127DnUnits, L127DnDim, L127DnEig, L127DnLam: `L127DnDim`'s `lamMap S κ` takes a general `κ`, but its `finrank_lam` is stated at `|S| ≥ 3` only, and every eigen-family and decomposition uses `dnK`.
- **2a** breaks on a nonzero `IsWithinW` matrix on a pair. Its only free entry is `Z_xy`, fixed to `0` by row `x`. None exists.
- **Range claims** break on a header sentence giving a declaration a range its hypotheses do not carry. The grep found the three listed below.

## Gaps

- **G1 (INDEX), [lean/INDEX.md:495](../lean/INDEX.md), passage "And the families span $\mathcal D_n$".** "`dn_spectrum`, at the sphere product each summand is an eigenvector ..., so $\mathcal D_n$ is spanned by eigenvectors carrying the row's values" carries no range. Add $p,q\ge3$, as L127DnSpan.lean:13 and :23 now do.
- **G2 (header, downstream), [L127DnUnits.lean:22](../lean/HamiltonsCubic/Results/L127DnUnits.lean).** "that they span it at `p, q ≥ 3`" is the sentence r1652 G2 corrected in L127Dn.lean, left stale here. It should read `p, q ≥ 2`.
- **G3 (header list), [L127DnSpan.lean:14-27](../lean/HamiltonsCubic/Results/L127DnSpan.lean).** Add `lamW_two_eq_zero` and `within_two_eq_zero` to the declaration list. Optionally cite them at [L127DnUnits.lean:26](../lean/HamiltonsCubic/Results/L127DnUnits.lean) and [L127Dn.lean:28-29](../lean/HamiltonsCubic/Results/L127Dn.lean), where the `{0}` claim is made.
- **G4 (minor), [L127Dn.lean:26](../lean/HamiltonsCubic/Results/L127Dn.lean).** "give the eigenspaces" carries no range. The eigenspace declarations hold at `p, q ≥ 3`, `t ≠ 0`.
