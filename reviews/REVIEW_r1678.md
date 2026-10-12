# REVIEW r1678: L52, the Helmert staircase (44cdbb97) and the revert to **partial** (83ca52b4)

**Verdict: CONFIRMED WITH GAPS.** `staircase_strict_helmert` is correct, kernel-checked (L52Staircase 32/32 on the standard three) and sits in the record's frame: `whst` is `𝟏/2` followed by the Helmert basis of `𝟏^⊥`, `Rst` is Ricci-flat, coordinate-diagonal, first Bianchi and unit norm, and the cross term `24·t·b·c = 2√2·t` checks by hand. r1677 G1 and G2 are discharged by r1677's own recipe, and **partial** is the right state. Three gaps remain. The theorem is the `S²` display at a frame containing the `S²₀` staircase, with the glue to the record's `S²₀` display undeclared. The record's staircase sentence is universal and **true at every `n` and every unit Ricci-flat coordinate-diagonal `W`**, so one `n = 4` instance under-declares it, and r1677 §3's "record imprecision" remark is wrong. The owed list omits r1677 G7 and the neighbourhood sentence that 274251de put into the block.

## Claims

| # | Claim | Verdict |
|---|---|---|
| 1 | `whst` is the Helmert frame, `𝟏/2` first, members 1–3 in `𝟏^⊥`, complete | **CONFIRMED** |
| 2 | `Rst` is Ricci-flat, coordinate-diagonal, first Bianchi, unit norm | **CONFIRMED** |
| 3 | `whst_cross`: `h₂ᵀ K h₃ = 24 t b c ≠ 0` | **CONFIRMED** (by hand) |
| 4 | `staircase_strict_helmert` is strict for every admissible `M₊`, `m` | **CONFIRMED** |
| 5 | "strict in the record's `S²₀` frame" | **CONFIRMED WITH GAPS** (G1) |
| 6 | It renders the record's staircase sentence ([bispectral.md:83](../findings/bispectral.md#L83)) | **CONFIRMED WITH GAPS** (G2) |
| 7 | r1677 G1 and G2 discharged | **CONFIRMED** |
| 8 | The owed list is accurate and complete, and **partial** is right | **CONFIRMED WITH GAPS** (G3, G4) on the list, **CONFIRMED** on the state |
| 9 | 83ca52b4 is faithful to r1677 | **CONFIRMED WITH GAPS** (G3) |
| 10 | Axiom audit, L52Staircase.lean | **CONFIRMED**, 32/32 on the standard three |

## 1. The frame and the tensor ([L52Staircase.lean](../lean/HamiltonsCubic/Results/L52Staircase.lean))

- **`whst`** ([:177-178](../lean/HamiltonsCubic/Results/L52Staircase.lean#L177)): rows `(1,1,1,1)/2`, `(1,−1,0,0)/√2`, `(1,1,−2,0)/√6`, `(1,1,1,−3)/√12`. Norms `1`, `1`, `6/6`, `12/12`. Every pair of rows is orthogonal (the Helmert pattern: `h_k` is constant on the support of every `h_j` with `j < k`, and every `h_j` sums to `0`). So rows are orthonormal, `WᵀW = I` follows for the square family, and `whst_complete` states exactly that form, the one `L52_record` takes.
- **`whst_perp`** ([:201](../lean/HamiltonsCubic/Results/L52Staircase.lean#L201)): rows 1–3 sum to `0`, so they span `𝟏^⊥` and member `0` is `𝟏/√4`. This is NPW's staircase `ψ_k = (e_1 + ⋯ + e_k − k e_{k+1})/√(k(k+1))` ([bispectral.md:503](../findings/bispectral.md#L503)), 0-indexed.
- **`Wst_row`, `Rst_ricci`** ([:136](../lean/HamiltonsCubic/Results/L52Staircase.lean#L136), [:157](../lean/HamiltonsCubic/Results/L52Staircase.lean#L157)): every row of `Wst` is `2 − 1 − 1 = 0`, and `diagOp_ric` ([Families.lean:220](../lean/HamiltonsCubic/Base/Families.lean#L220)) gives `Ric (diagOp w) a b = [a = b](Σ_c w a c − w a a)`, zero by the row sums and hollowness. The predicate `∀ a b, Ric R a b = 0` is the one `L52_record_S20`, `dpsi_split` and `omega_lower_iff` take. Coordinate-diagonality, Bianchi and unit norm are unchanged from r1677 §1 and re-read here.
- **Cross term, by hand.** `Wst (1,1,1,−3) = (0+2−1+3, 2+0−1+3, −1−1+0−6, −1−1+2+0) = (4, 4, −8, 0)`, and `(1,1,−2,0)·(4,4,−8,0) = 24`. With `K = t·Wst` and the normalisations `b = 1/√6`, `c = 1/√12`, `h₂ᵀKh₃ = 24tbc = 24t/√72 = 2√2·t`, as r1677 §3 derived and the commit states. The proof of `staircase_strict_helmert` ([:239-252](../lean/HamiltonsCubic/Results/L52Staircase.lean#L239)) is `L52_eq_diagonalises` at `(k, l) = (2, 3)` against `24tbc > 0`. Both indices are inside `𝟏^⊥`, so the obstruction is in the `S²₀` block itself and owes nothing to member `0`.

## 2. Is it the record's `S²₀` sentence?

- **The reading is correct.** At `whst` the `S²` display and the record's `S²₀` display coincide, derived by hand:
  - the `ψ₀` diagonal entry is `Bw_diag_psi` at `k = 0`, `−(𝟏/2)ᵀK(𝟏/2) = −¼ Σ_{a,b} K_ab = 0` by the zero row sums, so `p₂` and `p₃` of the `S²` diagonal are those of the pair diagonal plus the three staircase entries, the record's `K'`.
  - the `S²` spectrum of `W̊` is the `S²₀` spectrum plus one `0` at Ricci-flat `R` (`ringW_spectrum_split`, general `w`), so `ω ≥ −m` on `S²` is `ω ≥ −m` on `S²₀` plus `0 ≥ −m` ([L52S20.lean:33](../lean/HamiltonsCubic/Results/L52S20.lean#L33), `omega_lower_iff`, also general `w`), and `0 ≥ −m` follows from `Σω = 0`.
- **The composition is undeclared (G1).** `staircase_strict_helmert` is stated on the `S²` display with `hω` on the `S²` spectrum of `Bw whst`. The `S²₀` form with the record's `K'` exists only at `wK` (`sum_diag_split` at [L52S20.lean:81](../lean/HamiltonsCubic/Results/L52S20.lean#L81) and `L52_record_S20` both fix `w := wK`). The docstrings at [:21](../lean/HamiltonsCubic/Results/L52Staircase.lean#L21) and [:237](../lean/HamiltonsCubic/Results/L52Staircase.lean#L237) say "strict in the record's `S²₀` frame", which is true by the two bullets above and rests on no declaration. This is the level of fix r1677 G1 asked for, so G1 of r1677 is discharged and this gap is new and minor.

## 3. The record's sentence is universal, and true

- [bispectral.md:83](../findings/bispectral.md#L83): "At a coordinate-diagonal `W` read in the staircase basis, both operators are diagonal in one shared frame and the bound is **strict**." r1677 §3 ¶4 read this as a record imprecision, false at a coordinate-diagonal `W` whose `K` the staircase happens to diagonalise. **No such unit `W` exists, at any `n`**, derived by hand:
  - at Ricci-flat `W`, `K𝟏 = 0`, so if the staircase diagonalises `K` on `𝟏^⊥` then `K = Σ_{k=1}^{n−1} λ_k h_k h_kᵀ`.
  - `K` is hollow (`K_aa = W_aaaa = 0`). The diagonal at coordinate `i` is `λ_i · i/(i+1) + Σ_{k>i} λ_k/(k(k+1))` (the `λ_i` term absent at `i = 0`). Coordinate `n−1` gives `λ_{n−1} = 0`, and descending, each coordinate `i ≥ 1` then gives `λ_i = 0`. So `K = 0`.
  - at coordinate-diagonal `W`, `M` is diagonal in the pair basis, so `Σ_{pairs} K² = Σμ² = 1`, a contradiction.
  - hence at every unit Ricci-flat coordinate-diagonal `W`, some `h_kᵀKh_l ≠ 0` with `1 ≤ k < l`, and `L52_eq_diagonalises` makes the bound strict. The sentence holds universally, for the staircase in any fixed coordinate order.
- *Screen, not evidence:* the `n × (n−1)` matrix `(h_k(i)²)` has full column rank for `n = 4, …, 9` (exact rationals, seconds). It agrees with the induction.
- **G2.** The layer declares one instance at `n = 4`. That settles "the 'if' half is false without the stipulation", the headline, and leaves the universal second sentence undeclared. The row and the owed list are silent on it. At fixed `n = 4` a universal form is a finite computation over the three pairing weights, and the general-`n` form is the triangular induction above.

## 4. The owed list, the state, and 83ca52b4

- **r1677 G1 and G2**: discharged by `whst`, `whst_complete`, `whst_perp`, `whst_cross`, `staircase_strict_helmert`, and `Wst_row`, `Rst_ricci`. The row ([lean/INDEX.md:384](../lean/INDEX.md#L384)) drops both from the owed list, correctly.
- **Owed entries present** at HEAD: the `π/4` rotation (r1677 G3), the padded `W_CP²` figures `3.9804`, `√(3/2)`, `2.4495` (G4), the second display with `(1+u+u²)/(1+u) ≤ 3/2`, `C ≤ Θ_n/3`, `θ ≤ Θ_n/2` and "informative only at `t_F = 2`" (G5), and the Verification sign-indefiniteness (G6). Each matches r1677 and the block. Grepped the layer for `3.9804`, `Θ`, `1 + u`, `permutation`, `sign`: none of them has a declaration, so the entries are accurate.
- **Missing, G3 (r1677 G7).** 83ca52b4 carries G1–G6, applies G8 and routes G9, and G7 appears nowhere: not repaired, not owed. The row's opening still cites "the cap is an identity", "3.674235" and "strictly loose at every unit Weyl tensor", and [L52.lean:9-27](../lean/HamiltonsCubic/Results/L52.lean#L9) and [:96-98](../lean/HamiltonsCubic/Results/L52.lean#L96) still argue against "off the diagonal family it loses", a sentence 274251de removed from both [results.md](../results.md) and the block. `threshold_nonempty`'s docstring now refutes text the canon no longer prints.
- **Missing, G4 (block text newer than r1677).** 274251de, committed between the two reviewed commits, put into [bispectral.md:88](../findings/bispectral.md#L88): "the bound beats the strict one-line bound `θ ≤ (3/2)(M₊ + m)` on a neighbourhood of the diagonal family (both are continuous, and it is exact there)". Exactness is `L52_if_psi`. Strictness of the one-line bound at `Mpair` needs `Σμ = 0` for `Mpair` and the termwise step, which r1677 §5 found undeclared (`strictly_loose` is on an abstract vector). Continuity has no declaration. 44cdbb97's owed list does not name the sentence.
- **State.** With G3–G6 of r1677 owed and G2, G4 here, **partial** is right. The revert in 83ca52b4 is the fix r1677 recommended, and the one clause it rewrote (L52RecordEq's "checked by hand ... no declaration" to "declared as `staircase_strict` below in its `S²` form") is r1677 G8 applied faithfully.

## 5. Axiom audit

`python3 scripts/misc/axiom_audit.py --only L52Staircase`, run here: 32/32 on the standard three. The count is r1677's 18 theorems plus 14 new ones (`Wst_row`, `Rst_ricci`, six `*_sq`, `*_sq2`, two `*_pos`, `whst_complete`, `whst_perp`, `whst_cross`, `staircase_strict_helmert`), and it matches the row. No `sorry` or `native_decide` in the file.

## Gaps

- **G1 (minor), [L52Staircase.lean:21](../lean/HamiltonsCubic/Results/L52Staircase.lean#L21), [:237](../lean/HamiltonsCubic/Results/L52Staircase.lean#L237).** "Strict in the record's `S²₀` frame" rests on the `ψ₀` diagonal being `0` and on `omega_lower_iff` at `whst`, neither composed. Fix: a corollary with `hω` on the `S²₀` spectrum and the display over the pairs plus `h₁, h₂, h₃`, or a docstring sentence naming the `S²` form and the two facts that identify it with the `S²₀` one.
- **G2, [bispectral.md:83](../findings/bispectral.md#L83), [lean/INDEX.md:384](../lean/INDEX.md#L384).** The record's second sentence is universal and true (§3), and one `n = 4` instance is declared. Fix: declare the universal form (at `n = 4` over the pairing weights, or at general `n` by the triangular induction), or list it as owed. r1677 §3 ¶4 is superseded on this point.
- **G3, [lean/INDEX.md:384](../lean/INDEX.md#L384), [L52.lean:9-27](../lean/HamiltonsCubic/Results/L52.lean#L9), [:96-98](../lean/HamiltonsCubic/Results/L52.lean#L96).** r1677 G7 dropped by 83ca52b4 and 44cdbb97. Fix: re-anchor L52.lean's header, `threshold_nonempty`'s docstring and the row's opening to the block after 274251de, or owe it.
- **G4, [bispectral.md:88](../findings/bispectral.md#L88), [lean/INDEX.md:384](../lean/INDEX.md#L384).** The neighbourhood sentence has no declaration and is not owed. Fix: add it to the owed list with its three parts (exactness declared, one-line strictness at `Mpair` and continuity undeclared).

## What would break each claim, and what was done

- **Claims 1, 2:** a non-orthogonal pair of `whst` rows, a row of `Wst` with nonzero sum, or `Ric` defined with a convention that `diagOp_ric` does not match. Recomputed six dot products and four row sums, and read `Ric` ([WeylReal.lean:106](../lean/HamiltonsCubic/Base/WeylReal.lean#L106)) and `diagOp_ric`.
- **Claim 3:** `h₂ᵀKh₃ = 0`. Recomputed `Wst h₃` entry by entry, and the same product in a seconds-long exact screen.
- **Claim 4:** a pair `(M₊, m)` for which equality holds. `L52_eq_diagonalises` excludes it once the cross term is nonzero, and the audit confirms the proof is kernel-checked.
- **Claim 5:** a nonzero `ψ₀` diagonal entry, or an `S²` eigenvalue outside `S²₀ ∪ {0}`. Both excluded by Ricci-flatness, derived by hand, and checked that `omega_lower_iff` and `ringW_spectrum_split` take a general complete `w`.
- **Claim 6:** a unit Ricci-flat coordinate-diagonal `W` that the staircase diagonalises, which would make the record's universal sentence false. The triangular induction rules it out at every `n`, and the rank screen agrees at `n = 4, …, 9`.
- **Claims 7–9:** an r1677 gap neither repaired nor owed, or block text with no declaration and no owed entry. Diffed the L52 row across 83ca52b4, 44cdbb97 and the worktree, read every r1677 gap against it, and read the block at HEAD including 274251de's change.
- **Claim 10:** a non-standard axiom. Ran the audit.

*Analysis-only footing: the runs were the per-file axiom audit (minutes, on the file in hand) and a seconds-long exact-rational rank screen reported as a screen. The universality of the staircase sentence and the `S²₀` identification are hand derivations.*
