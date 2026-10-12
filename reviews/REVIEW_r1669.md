# REVIEW r1669: L52's equality clause at the record's objects (b611bf60, lean-loop)

**Verdict: CONFIRMED WITH GAPS.** `L52_record_eq` and `L52_record_if` are exact instantiations of `L52_matrix_eq_frame` and `L52_matrix_if` at `A = Mpair R`, `B = Bw w (ringW R)`, with `L52_record`'s hypotheses unchanged (the "if" half correctly drops `hμ`, `hω`), and the axiom audit is 2/2 on the standard three. The header's account of the staircase counterexample is right, and I checked it by hand at `n = 4`. The Owed clause names the S²₀ reading but under-describes it, and it drops two items r1668 G4 asked to have named. The staircase counterexample, the record's negative claim, has no Lean witness and is not listed as owed.

| # | claim | verdict |
| --- | --- | --- |
| 1 | `L52_record_eq` is `L52_matrix_eq_frame` at `A = Mpair R`, `B = Bw w (ringW R)`, hypotheses those of `L52_record` | **CONFIRMED** |
| 2 | `L52_record_if` is `L52_matrix_if` at the same objects | **CONFIRMED** |
| 3 | "equality iff M and W̊ are diagonal in the one frame" is the record's equality clause | **CONFIRMED WITH GAPS** (G1, G3) |
| 4 | the "if" half is consistent with the record's "false without the ψ stipulation" | **CONFIRMED** |
| 5 | the header's account of the staircase counterexample | **CONFIRMED WITH GAP** (G2) |
| 6 | the Owed clause is accurate and complete | **CONFIRMED WITH GAPS** (G1, G4) |
| 7 | axiom audit, L52RecordEq.lean | **CONFIRMED** (2/2, standard three) |

**Summary:** the two theorems are correct and faithful at `w = wK`, while the Owed clause omits the "equality forces `w` to diagonalise `K`" corollary and the off-diagonal transfer to S²₀, and the staircase counterexample is asserted without a declaration.

## 1. `L52_record_eq`

- **The Lean** ([L52RecordEq.lean:34-49](../lean/HamiltonsCubic/Results/L52RecordEq.lean#L34)) passes `Mpair R`, `Mpair_isHermitian`, `Bw w (ringW R)`, `Bw_isHermitian`, `Mp`, `m`, `hμ`, `hω` to `L52_matrix_eq_frame` ([L52Equality.lean:98-108](../lean/HamiltonsCubic/Results/L52Equality.lean#L98)), and discharges `hμ2`, `hω2` by `sum_mu_sq` and `sum_omega_w_sq` exactly as `L52_record` does ([L52Frame.lean:264-270](../lean/HamiltonsCubic/Results/L52Frame.lean#L264)). The remaining goal is the matrix `heq`, obtained by rewriting `heq` from `Pcubic R` to `(3/2) Σμ³ − (1/2) Σω³` through `L50_bispectral` and `sum_mu_cube`, the same rewrites `L52_record` uses in the other direction.
- **Hypotheses.** Section variables `R, hR, hskew, hsym, w, hw` and the explicit `hB, hunit, Mp, m, hμ, hω` are word for word `L52_record`'s ([L52Frame.lean:257-259](../lean/HamiltonsCubic/Results/L52Frame.lean#L257)). `heq` is `L52_record`'s conclusion with `≤` replaced by `=`. So `L52_record_eq` is the converse-at-equality of `L52_record` under the same hypotheses.
- **Breaking object sought.** A first-Bianchi unit-norm `R` and complete `w` with equality and a nonzero off-diagonal entry. Any such pair would violate `L52_matrix_eq_frame`, which rests on the strict convexity of `t³+3mt²` and strict concavity of `t³−3M₊t²` on the closed ranges (CubicConvexity, reviewed in r1668). The instantiation adds nothing that could fail: both Hermitian proofs are the ones `L52_record` already uses.

## 2. `L52_record_if`

- **The Lean** ([L52RecordEq.lean:51-64](../lean/HamiltonsCubic/Results/L52RecordEq.lean#L51)) is `L52_matrix_if` at the same objects with the same two norm rewrites, and the conclusion is `L52_record`'s display as an equality. It drops `hμ`, `hω`, which is right: when both matrices are diagonal the penalty terms `1 − p₂(K)` and `p₂(K') − 3` vanish for every `M₊`, `m`.
- **Breaking object sought.** A pair with both matrices diagonal and a strict display. None exists: diagonal means diagonal = spectrum, so both sides agree identically.

## 3. Fidelity of "equality iff M and W̊ are diagonal in the one frame"

- **The record's clause** ([results.md:1172-1178](../results.md#L1172), [bispectral.md:81-84](../findings/bispectral.md#L81)): "the bound is an identity when both operators are diagonal in that shared basis", the basis being `{φ_ij, ψ_k}` with `ψ_k` an eigenbasis of `K` on `𝟏^⊥`, and conversely exactness forces every off-diagonal entry of both to vanish.
- **At `w = wK`** the Lean pair is that clause read on S² rather than S²₀: `Bw wK (ringW R)` diagonal is "W̊ diagonal in the stipulated basis" plus the extra `g` direction. So both halves match at the stipulated basis, modulo G4.
- **At other complete `w`** the theorems are more general than the record, and the basis `{φ_ab} ∪ {diag w_k}` is not the record's basis. The header's "the record's shared frame" ([L52RecordEq.lean:15](../lean/HamiltonsCubic/Results/L52RecordEq.lean#L15)) and the INDEX row's same phrase attach the record's name to every `w`. The commit subject's "diagonal in the one frame" is the consumer wording the record warns is false ("it is not the clause a consumer would write"), since a frame does not fix the ψ basis. The file body is precise, so this is wording (G3).
- **The unstated corollary.** At an arbitrary complete `w`, `L52_record_eq` plus `diag_block` ([L54Basis.lean:108](../lean/HamiltonsCubic/Results/L54Basis.lean#L108)) gives `−w_kᵀ K w_l = 0` for `k ≠ l`, so equality forces `w` to be an eigenbasis of `K`: equality is attainable only at the stipulated basis. This is the "only if" reading of the ψ stipulation, the one r1668 G4 asked to have named, and neither the file nor the Owed clause states it (G1).

## 4. The "if" half and the ψ stipulation

- **Consistent.** `L52_record_if` needs `Bw w (ringW R)` diagonal. The record's "false without the stipulation" is the statement that "both diagonal in one frame" (M diagonal, W coordinate-diagonal) does not imply `Bw w` diagonal at every `w`. At `w = wK` it does, and all but the first link is already in the layer: M diagonal gives `IsCoordDiag R` by hand (M's off-diagonal entries are `R4` at distinct ordered pairs, and the entries with `i = j` or `k = l` vanish by antisymmetry. I found no declaration for this direction, and `L54_direct` uses `tF_eq_iff` instead), then `Bw_pair_off` and `Bw_pair_psi` ([L54Direct.lean:101-115](../lean/HamiltonsCubic/Results/L54Direct.lean#L101)) kill the φ–φ off-diagonal and the φ–ψ block, and `psi_block` with `wK_orth` kills the ψ–ψ off-diagonal. So at `wK` the "if" half needs only `Mpair R` diagonal.
- **The header's "the stipulated basis makes the ψ-block diagonal for free"** ([L52RecordEq.lean:18-19](../lean/HamiltonsCubic/Results/L52RecordEq.lean#L18)) is true and covers one of the three blocks. The φ–φ and φ–ψ conditions are left to `hWd` without saying they follow from `hMd` by `Bw_pair_off`, `Bw_pair_psi` (G1). The composition "M diagonal gives equality at `wK`" is the sharpest record-faithful "if", and it is two lemma calls from what exists.

## 5. The staircase counterexample

- **The header's account is right.** At a coordinate-diagonal `W` the φ–φ and φ–ψ blocks vanish at every `w` (`Bw_pair_off`, `Bw_pair_psi` take any `w`), so with `w` a staircase (Helmert) basis the only failure of `hWd` is the ψ–ψ block `−w_kᵀ K w_l`, which is diagonal only when `w` diagonalises `K`.
- **Checked by hand at `n = 4`.** Take matching weights `a, b, c` on `{12,34}`, `{13,24}`, `{14,23}` with `a+b+c = 0` (zero row sums, first Bianchi holds for any coordinate-diagonal tensor since `W_ijij + W_jiij + W_iijj = w − w + 0`). With `v₁ = (1,−1,0,0)/√2`, `v₂ = (1,1,−2,0)/√6`: `K v₁ = (−a, a, b−c, c−b)/√2`, so `v₂ᵀ K v₁ = −2(b−c)/√12 ≠ 0` whenever `b ≠ c`. So `Bw` is not diagonal at the staircase basis, and `L52_record_eq`'s contrapositive (valid `M₊`, `m` always exist, the spectral extremes) makes the bound strict, as the record says. This is an analytic check, no computation run.
- **Gap.** No declaration carries this: `grep staircase lean/` hits only L52RecordEq.lean's header and the INDEX row. The record's claim that the unstipulated "if" is false is asserted in the Lean layer's prose and not typed, and the Owed clause does not list it (G2). The witness is cheap: the `n = 4` family above, `Bw_pair_off`, `Bw_pair_psi`, and `diag_block` at `v₁, v₂`, composed with `L52_record_eq`.

## 6. The Owed clause

- **Accurate as far as it goes.** The record reads K' and ω on S²₀, and the Lean on S² at `w`. `L52_record_S20` ([L52S20.lean:110](../lean/HamiltonsCubic/Results/L52S20.lean#L110)) does the passage for the display.
- **Under-described.** `L52_record_S20`'s splits (`ringW_spectrum_split`, `sum_diag_split`, `dpsi_split`) are statements about spectra and diagonals as multisets. The equality clause's conclusion is about off-diagonal entries, whose transfer to S²₀ needs a different input: W̊ kills `g` (`Bw_gCoord`, [L54Spectrum.lean:161](../lean/HamiltonsCubic/Results/L54Spectrum.lean#L161); `psi_one_null`, [L54Split.lean:90](../lean/HamiltonsCubic/Results/L54Split.lean#L90)), so entries against `diag w_k` reduce to entries against its trace-free part. When `K`'s 0-eigenspace is degenerate Mathlib's `wK` need not contain `𝟏/√n` (the L54 row records this), and then the record's `ψ_k` are a different orthonormal family from the trace-free parts of `wK`, so the transfer needs a change of basis inside that eigenspace. It also needs Ricci-flatness, which `L52_record_eq` does not assume. "through `L52_record_S20`'s splits" names the wrong tool for half the job (G4).
- **Incomplete.** Missing: the corollary "equality forces `w` to diagonalise `K`" (G1, carried from r1668 G4), and the staircase witness (G2).

## 7. Axiom audit

- `python3 scripts/misc/axiom_audit.py --only L52RecordEq.lean`, run after the concurrent `lake build` finished: "auditing 2 declarations across 1 files, 2/2 clean, resting on the standard three alone", exit 0. The file therefore also compiles. No `sorry`, no `native_decide`.

## Gaps

- **G1, [lean/INDEX.md:383](../lean/INDEX.md#L383) and [L52RecordEq.lean:18-20](../lean/HamiltonsCubic/Results/L52RecordEq.lean#L18).** r1668 G4 is repaired only for the ψ–ψ block (`psi_block` named). Unnamed: that at `wK` the φ–φ and φ–ψ conditions of `hWd` follow from `hMd` by `Bw_pair_off`, `Bw_pair_psi`, and that `L52_record_eq` with `diag_block` forces an equality-attaining `w` to diagonalise `K`. Neither is proved nor owed.
- **G2, [lean/INDEX.md:383](../lean/INDEX.md#L383).** "the condition the record's staircase counterexample violates" cites no declaration, and the record's negative claim (unstipulated "if" is false) has no Lean witness and is not in the Owed clause.
- **G3, [L52RecordEq.lean:15](../lean/HamiltonsCubic/Results/L52RecordEq.lean#L15) and the INDEX row.** "the record's shared frame" is applied at every complete `w`, where the basis is the record's only at `w = wK`. The commit subject's "diagonal in the one frame" is the reading the record calls false. Wording only.
- **G4, [lean/INDEX.md:383](../lean/INDEX.md#L383), Owed clause.** The S²₀ reading of the off-diagonal conclusion needs `Bw_gCoord`/`psi_one_null`, Ricci-flatness, and a basis change when `wK` omits `𝟏/√n`, beyond `L52_record_S20`'s multiset splits.

## What would break each claim, and what was done

- For 1 and 2: a hypothesis of `L52_record` missing or added, or a rewrite that changes the display. Compared the signatures and proof scripts line by line against L52Frame.lean:257-270 and L52Equality.lean:98-133. None found.
- For 3: a `w` at which the Lean's basis is not the record's. Found: every `w ≠ wK` (G3), harmless for the theorems.
- For 4: a pair with `Mpair R` diagonal at `wK` and `Bw wK` non-diagonal. Ruled out by `Bw_pair_off`, `Bw_pair_psi`, `psi_block`.
- For 5: a coordinate-diagonal `W` whose staircase ψ-block is diagonal for all weights. Ruled out by the `n = 4` computation above, and a Lean declaration for the counterexample. None found (G2).
- For 6: an owed step not named. Found: G1, G4.
- For 7: a `sorry` or non-standard axiom beneath either theorem. Ran the audit: 2/2 clean.
