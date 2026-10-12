# REVIEW r1145: the Lean for L240 piece (b), assembly, completeness and Ky Fan

Brief: [2026-09-25-L240b-complete-gate2-brief.md](2026-09-25-L240b-complete-gate2-brief.md). File: [L240SlotBasis.lean](../lean/HamiltonsCubic/Results/L240SlotBasis.lean), commits f7d6f1ad and b397e053. Method: read every declaration of the table against its claim and against the givens it feeds ([KyFanPrinciple.lean](../lean/HamiltonsCubic/Results/KyFanPrinciple.lean) `kyFan_eigen`, [KyFanPackaging.lean](../lean/HamiltonsCubic/Results/KyFanPackaging.lean) `inner2Form`, `negAdSq`, [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) `inner2`, `br`, `phi`, `IsSkew`), one background build, one audit run. No numerical work.

| item | verdict |
|---|---|
| 1. statements faithful | CONFIRMED, with one note on scope |
| 2. `slot_complete` domain and index set | CONFIRMED |
| 3. build and axiom audit | CONFIRMED |
| 4. docstring, INDEX row, "piece (b) is done" | CONFIRMED, with two optional wording notes |

## Item 1: CONFIRMED

- `slotφ_of_cross` gives `c < d`, `InBlk c x`, `InBlk d y`, `{x, y} = {i, j}` with the orientation recorded as a disjunction, and `slotφ N ij = (√2)⁻¹ • pairSlot N c d x y`. That is the claim, with the unordered-pair reading made explicit.
- `slot_orth_cc` and `slot_orthonormal` state `inner2 (slotφ N ij) (slotφ N kl) = if ij = kl then 1 else 0` over the full subtype `{x : ι × ι // x.1 < x.2}`, the second with no hypothesis. `slot_orthonormal` splits on `IsCross` into the four combinations and routes them to (A), (B) twice through `i2_comm`, and (C). Nothing is dropped.
- `phi_expand_ordered` takes `IsSkew X`, which it needs, and the coefficient `inner2 (phi i j) X` is correct for the basis because `inner2 = ½ tr(AᵀB)` gives `inner2 φ_ij φ_ij = 1`.
- `slotφ_isSkew` and `negAdSq_slot` state their claims. `negAdSq_slot` is `slot_eigen` restated through `negAdSq`, whose `toFun` is `-br X (br X Y)` by definition.
- `slot_kyFan` uses the same inner product as `kyFan_eigen`: `B := inner2Form` with `inner2Form_apply` holding by `rfl`, and `M := negAdSq N.X`, whose value is `-br N.X (br N.X Z)` definitionally (the proof's `e` is `rfl`). The left side `inner2 (y j) (-br N.X (br N.X (y j)))` is therefore `⟨y_j, -ad_X² y_j⟩` in the layer's inner product.
- The hypothesis on the `y_j` is orthonormality in `inner2` (`inner2 (y i) (y j) = if i = j then 1 else 0`) plus skewness of each `y_j`, which is the right pair: orthonormality is what `kyFan_eigen` consumes, and skewness is what `slot_complete` needs to supply `hspan`. The slot family is orthonormal in the same form, so the two normalisations agree.
- `r` is unconstrained and the statement holds for every `r`. When `r` exceeds `n(n-1)/2`, the dimension of the skew matrices, no `inner2`-orthonormal skew family of that length exists, so the statement is vacuously true there and carries content exactly for `r ≤ n(n-1)/2`. The eigenvalue sum ranges over the whole slot index set, which has `n(n-1)/2` members, so it is the full spectrum of `-ad_X²` on the skew matrices with multiplicity, and minimising over `c` recovers the sum of the top `r` eigenvalues in the meaningful range.
- The hypotheses are satisfiable (for `r = 1`, `y = φ_ij` qualifies), so there is no vacuity.
- **Note on scope, no defect.** `X` here is `N.X`, a normal form written in the standard coordinates. A general skew `X` reaches this only through an orthogonal `Q` with `QᵀXQ = N.X` together with the transport of `inner2`, skewness and `-ad²` under conjugation. That transport belongs with piece (a) and is not yet named in the INDEX row's description of (a).

## Item 2: CONFIRMED

- `slot_complete (Y) (hY : IsSkew Y) : Y = ∑ ij, inner2 (slotφ N ij) Y • slotφ N ij`. The hypothesis is exactly `IsSkew`, and the converse direction holds by `slotφ_isSkew`, so the expansion characterises the skew matrices.
- The sum index is inferred from `slotφ N`, whose domain is `{x : ι × ι // x.1 < x.2}`, the same subtype `slot_orthonormal` quantifies over. `transfer_expansion` is invoked with `κ := {x : ι × ι // x.1 < x.2}` explicitly, with `φ` the ordered basis bivectors (expanded by `phi_expand_ordered`) and `b := slotφ N` (orthonormal by `slot_orthonormal`, inside `IsSkew` by `slotφ_isSkew`). The index sets match by construction.

## Item 3: CONFIRMED

- `lake build HamiltonsCubic.Results.L240SlotBasis`, run in the background from `lean/`: `Build completed successfully (8735 jobs)`, exit 0. The warnings are style linters (line length, unused section variables, `maxHeartbeats`). No `sorry` in the file.
- `python3 scripts/misc/axiom_audit.py --only L240SlotBasis`: `auditing 84 declarations across 1 files`, `84/84 clean -- resting on the standard three alone`. No "AUDIT INCOMPLETE".
- 84 is every declaration the file holds: 80 plain `theorem` lines and the four `@[simp] theorem` index lemmas. All eight declarations of the brief's table are among them.

## Item 4: CONFIRMED

- The INDEX row's claims for the new declarations (`slotφ_of_cross`, `pair_eq_of_mem`, `slot_orth_cc`, `slot_orthonormal`, `phi_expand_ordered`, `slotφ_isSkew`, `slot_complete`, `slot_kyFan` with its displayed inequality) match the Lean statements. The file docstring's opening paragraph does likewise.
- "Piece (b) is done" is accurate against the stated bound, "(b) with the normal form as a hypothesis, the smallest version that lets `kyFan_eigen` act at a general X": `NormalForm` is the hypothesis, its weights `s` are arbitrary reals, and `slot_kyFan` is `kyFan_eigen` acting at `N.X` for every such normal form.
- Optional wording, no defect: (i) the docstring's step list stops at step 9d, so `phi_expand_ordered`, `slotφ_isSkew`, `slot_complete`, `negAdSq_slot` and `slot_kyFan` appear only in the opening paragraph and could get a step 9e line. (ii) "a general X" in the bound means a general normal form. The conjugation transport noted under item 1 could be named in the INDEX row's piece (a) so that it is not lost between (a) and (b).

## Corrections

None required.
