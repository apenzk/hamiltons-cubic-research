# REVIEW r1654: `dn_direct2` at `p, q ≥ 2` (e3405cd2) and r1653's repairs (2fa5ccbd)

**Verdict: CONFIRMED WITH GAPS.** `dn_direct2` is sound at `p = 2`, `q = 2` and `p = q = 2`: `c = 0` comes from the row sums and `∑_T h = 0` with no use of `κ`, the column sums give `κ' h'_b = 0`, and `lamzero` kills each `λ` member through `lamW_two_eq_zero` on a pair and through `κ ≠ 0` at `|S| ≥ 3`. `dn_direct` keeps its old signature, so its callers are unaffected. r1653's G1–G4 are repaired. The gaps are prose: two headers still tie the direct sum to `p, q ≥ 3` or to `dn_decomp` alone.

Analysis only. The one run was the axiom audit on one file, a screen of the axiom footprint.

## Claims

| # | Claim | Verdict | Notes |
|---|---|---|---|
| 1a | `c = 0` without `κ ≠ 0` | CONFIRMED | Row `a ∈ T` of `dn_cross_entry` summed over `Tᶜ`: `q(κ h_a − c) + κ' ∑_{Tᶜ} h' + ∑_{Tᶜ} X_{a·} = 0`, with `∑ h' = 0` (`hh'`) and the cross row sum `0` (`IsCrossW`'s third clause, L127DnSpan.lean:46), so `κ h_a = c` at `q ≠ 0` (L127DnDirect.lean:62-70). Summing over `T`: `κ ∑_T h = p c`, and `∑_T h = 0` gives `c = 0` at `p ≠ 0` (:71-76). `κ` is a factor on the vanishing side only, so `κ = 0` (the `p = 2` value of `dnK`) leaves the argument intact. |
| 1b | `κ' h'_b = 0` from the column sums | CONFIRMED | Column `b ∉ T` summed over `T`: `−p c + κ ∑_T h + p κ' h'_b + ∑_T X_{·b} = 0`. `∑_T X_{ab} = ∑_T X_{ba} = 0` by symmetry and the fourth clause (:82-83), `∑ h = 0`, `c = 0`, so `p κ' h'_b = 0` (:78-89). |
| 1c | `λ` members vanish (`lamzero`) | CONFIRMED | At `|S| = 2`, `lamW_two_eq_zero` (L127DnSpan.lean:244) needs only `∑_S g = 0`, supplied by `hh`/`hh'`. At `|S| ≥ 3` and `|Sᶜ| ≥ 1`, `dnK S = −(|S| − 2)/|Sᶜ| ≠ 0`, so `κ g_a = 0` gives `g = 0` on `S` and `lamW_eq_zero` applies, every branch of `lamW` (L127Dn.lean:188-190) reading `g` only at indices of `S`. For `S = Tᶜ` the side condition is `|T| ≥ 1`, from `compl_compl` and `hp` (:101). At `p = q = 2` both calls take the pair branch. |
| 1d | `X = 0` | CONFIRMED | Same-side entries vanish by `IsCrossW`'s support clause. Cross entries: `dn_cross_entry` with `c = 0`, `κ h_a = 0`, `κ' h'_b = 0` leaves `X_{ab} = 0`, and the `a ∉ T, b ∈ T` entries follow by symmetry (:102-110). The remaining `Z + Z' = 0` splits on disjoint supports (:113-127). |
| 2 | `dn_direct` wrapper and callers | CONFIRMED | `dn_direct` (:130-135) has the pre-commit signature verbatim (the diff removes only its body and docstring), and passes `3 ≤ ·` to `2 ≤ ·` by `omega`. Callers L127DnMult.lean:88 and L127DnLam.lean:165 call it with unchanged arguments. |
| 3 | r1653 G1–G4 | CONFIRMED | G1: lean/INDEX.md:495 now reads "`dn_spectrum`, at the sphere product with $p,q\ge3$". G2: L127DnUnits.lean:22 reads `p, q ≥ 2`. G3: L127DnSpan.lean:23-24 lists both lemmas, cited at L127Dn.lean:31-32 and L127DnUnits.lean:27. G4: L127Dn.lean:26-27 gives the eigenspaces `p, q ≥ 3`, `t ≠ 0`. |
| 4 | Header and INDEX wording | CONFIRMED WITH GAPS | L127DnDirect's list (:13-17), `dn_direct2`'s docstring (:48-51) and the INDEX passage "And the sum is direct" match the proof and its range. Off: L127DnUnits.lean:24-25 and L127DnDirect.lean:9-11 (G1, G2). |
| 5 | Axiom audit | CONFIRMED | `axiom_audit.py --only L127DnDirect.lean`: 4/4 clean on the standard three (`lamW_eq_zero`, `dn_cross_entry`, `dn_direct2`, `dn_direct`), so the file builds. Callers were not rebuilt. Their call is to an unchanged signature. |

## Breakers, and the search for them

- **1a** breaks if a step divided by `κ` before `c = 0`. I traced every `mul_eq_zero` in :62-89: each resolves against `q ≠ 0` or `p ≠ 0`, never `κ`. The first use of `dnK ≠ 0` is inside `lamzero`'s `|S| ≥ 3` branch.
- **1b** breaks if the column sum of `X` over `T` were not `0`. `IsCrossW` states row sums on both sides and symmetry, which together give it.
- **1c** breaks on a pair `S` with `lamW S (dnK S) g ≠ 0` for zero-sum `g` (none, r1653 claim 1a), or on `|S| ≥ 3` with `dnK S = 0`, which needs `|S| = 2` or `|Sᶜ| = 0`, both excluded. It would also break on a `λ` member whose within entries `g_a + g_b` survive `g = 0` on `S`. None: they read `g` on `S` only.
- **1d** breaks on a nonzero `X` entry with both indices on one side, which `IsCrossW` forbids.
- **Wording** breaks on a sentence giving the direct sum a range its hypotheses do not carry. I grepped "≥ 3", "≥ 2" and "direct" across L127Dn*.lean and the INDEX row.

## Gaps

- **G1 (header range), [L127DnUnits.lean:24-25](../lean/HamiltonsCubic/Results/L127DnUnits.lean).** "give the families' dimensions, their direct sum, and their count `n(n − 3)/2` at `p, q ≥ 3`" attaches `p, q ≥ 3` to the direct sum, which `dn_direct2` now holds at `p, q ≥ 2`. Split it: the direct sum at `p, q ≥ 2`, the dimensions and count at `p, q ≥ 3`.
- **G2 (header partner), [L127DnDirect.lean:9-11](../lean/HamiltonsCubic/Results/L127DnDirect.lean).** "`dn_decomp` writes every weight as a sum over six families" names only the `p, q ≥ 3` decomposition, while the file's main theorem is at `p, q ≥ 2`. Cite `dn_decomp2` (at `p, q ≥ 2`) beside it.
- **G3 (minor), [L127DnDim.lean:26-27](../lean/HamiltonsCubic/Results/L127DnDim.lean).** "`dn_direct` makes their sum direct" is correct at the `p, q ≥ 3` the dimensions carry. Optionally name `dn_direct2` for the general range.
