# REVIEW r1733: L244Frame.lean, rows (A), (B), (C) at W's own eigenbasis

*Gate 2, cold brief, statement-fidelity review of [L244Frame.lean](../lean/HamiltonsCubic/Results/L244Frame.lean) at commit e8284ee0 against [Lemma L244](../findings/second-order.md#lemma-l244-the-per-vector-ceiling-on-a-symmetric-three-value-critical-point) and the L244 row of [lean/INDEX.md](../lean/INDEX.md). Analysis only: Lean source read, no `lake build`, no numerical screen run. Heartbeats in [agent_logs/review-r1733.log](../agent_logs/review-r1733.log). The build status (8/8 on the standard three) is taken from the brief.*

| # | Claim | Verdict |
|---|---|---|
| 1 | `ψf` is W's orthonormal complete eigenbasis of Λ², the reindexing preserves it, `ψf_complete` is in L244's `inner2 (ψ k) Y` order | CONFIRMED (orthonormality holds but is not exported for `ψf`) |
| 2 | `hId_frame`, `hWP_frame` correct for any `cls` with `evf k = λ (cls k)`, hypothesis satisfiable | CONFIRMED, NON-VACUOUS |
| 3 | `rowA_frame`, `rowB_frame`, `rowC_frame` are L244 (i)'s rows at W's eigenbasis, `sharpQF W η` is ⟨W^#η, η⟩ | CONFIRMED (row (C)'s right side λ_c(θ−λ_c) still needs `rowC_critical`, uncomposed) |
| 4 | The old owed list | PARTLY DISCHARGED: h0's basis through x and κ_r(x) remain owed, and the INDEX row now CONTRADICTS ITSELF |
| 5 | Docstrings | CONFIRMED WITH ONE IMPRECISION |

**Summary: the eleven declarations type what they claim and compose correctly. The one defect is in the INDEX row, whose "Not typed" clause still lists the construction of ψ that the new closing sentence says is built.**

## 1. The frame

- `ψf k = frameVec W … ((eF n).symm k)` and `evf k = eigenvalues ((eF n).symm k)`, both through the same equivalence `Fintype.equivFin (Pairs n)`, so vector and eigenvalue stay paired. `Pairs n` is the ordered pairs i<j, |Pairs n| = dim Λ².
- `hW.2.1` and `hW.2.2.1` are exactly the skew-preservation and bivector-symmetry clauses of `IsWeyl` ([WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)), which are the `hskew`, `hsym` [EigenFrameExist.lean](../lean/HamiltonsCubic/Results/EigenFrameExist.lean) takes.
- `eigenFrame_exists` carries skew, orthonormal, eigen and complete. `ψf_skew`, `ψf_eigen`, `ψf_complete` export three of them. **Orthonormality is true of `ψf` (a bijective reindexing of `frameVec_orth`) but no `ψf_orth` is stated.** Nothing in this file needs it, since `rowB_mass`, `rowC_mass` and `rowMass_total_any` use completeness only. It will be needed for any statement that `Pc ψf cls a` is the orthogonal eigenprojection.
- `ψf_complete` has the form `Y = ∑ k, inner2 (ψf k) Y • ψf k`, which is `hψ` in `rowMass_total_any` and the form `hId`/`hWP` unfold to through `Pc`. The proof swaps `inner2` with `inner2_comm` and reindexes with `Equiv.sum_comp`. Correct.

## 2. The resolutions

- `hId_frame` holds for every `cls : Fin r → Fin K`, with no labelling hypothesis: it is the fibrewise regrouping of `ψf_complete`. True and correctly stated.
- `hWP_frame` needs `evf k = lam (cls k)` for all k, i.e. `cls` refines the eigenvalue partition. Under it, `W X = ∑_k ⟨ψ_k,X⟩ λ(cls k) ψ_k = ∑_b λ_b Pc_b X` on skew X by linearity and `ψf_eigen`. Correct.
- **Satisfiable.** The trivial labelling `K = r`, `cls = id`, `lam = evf` meets it. At a spectrum with exactly three distinct values v₀, v₁, v₂, `cls k` = the index of `evf k` among them and `lam i = vᵢ` meets it, and then the fibres of `cls` are exactly the eigenspaces E₀, E₁, E₂ (the record's classes). A constant `cls` is excluded unless the spectrum is one point. No hypothesis is vacuous. That W itself can be nonzero is the layer's standing fact (e.g. the CPm operators), unaffected by this file.
- The Lean is more general than the record: `lam` need not be injective, so one eigenspace may be split across several classes, and empty classes are allowed. Both are harmless: every row is a sum over classes and an empty class contributes 0.
- **Observation.** The file quantifies over `cls` and does not construct the three-class labelling. Its existence is the one-line argument above, so this is not a gap in the claim as worded ("for any labelling … with evf k = λ (cls k)").

## 3. The rows

- **Row (A).** `rowA_frame`: `∑_{a,b} bAB ψf cls a b x = (n−2)⟨x,x⟩` for skew x and ANY `cls` (it needs no `hcls`). `bAB` is ½∑_{γ∈E_a, δ∈E_b}⟨[ψ_γ,ψ_δ],x⟩², the record's b_ab formula verbatim. `inner2` is ½tr(XᵀY), in which the φ_ij are orthonormal (`inner2_phi_pairs`), so unit x means `inner2 x x = 1` and the right side is the record's n−2. Correct, via `rowMass_eq_sum_bAB` and `rowMass_total_any` with φ = ψ = `ψf`.
- **Row (B).** `rowB_frame`: `∑ λ_b b_ab(η) = −⟨Wη,η⟩`. At a unit η ∈ E_c this is −λ_c, the record's row. Correct, as `rowB_mass` fed `hId_frame` and `hWP_frame`.
- **Row (C).** `rowC_frame`: `∑ λ_aλ_b b_ab(η) = sharpQF W η`. `sharpQF R η = mixQF R R η` (definitionally, [FoxBilinear.lean](../lean/HamiltonsCubic/Base/FoxBilinear.lean)), the same bilinear form that `mixQF_Pc` identifies with `bAB`. **The normalisation of # is pinned to the record's by row (A)**: the same `mixQF` summed over classes gives (n−2)⟨x,x⟩, the record's I#I = (n−2)I, so the scale of `sharpQF` is the record's ⟨W^#η,η⟩ and not a multiple of it. `rowC_critical` then gives λ_c(θ−λ_c) at `IsCritical W θ` (W²+W^# = θW in polarised form) and a unit eigenvector.
- **Observation.** No declaration composes `rowC_frame` with `rowC_critical` at a frame eigenvector, so L244 (i)'s row (C) in its record form λ_c(θ−λ_c) is two declarations apart. The INDEX's earlier sentence ("together they are L244 (i)'s row (C)") says so honestly. A three-line corollary `rowC_frame_critical` would close it.
- The rows are stated at every skew η, stronger than the record's unit x ∈ E_c, and at every linear Weyl W, stronger than "a unit critical point with three eigenvalues".

## 4. The old owed list

| Item | Status after e8284ee0 |
|---|---|
| ψ from W's eigenspaces | BUILT (`ψf`) |
| φ | BUILT: row (A) takes φ = `ψf` |
| `hexp` from completeness | BUILT (`ψf_complete`) |
| `cls` from W's eigenspaces | QUANTIFIED, not constructed, with existence immediate (section 2) |
| for h0, a basis of E₀ starting with the unit x | **STILL OWED.** Mathlib's `eigenvectorBasis` is an arbitrary orthonormal basis inside each eigenspace, so a chosen x is in general not a frame vector. `rowMass_cap_self` needs the family to start with x. Building it needs Gram–Schmidt inside E₀ from x, or a rotation of the frame, neither present. The rows themselves are unaffected, since they hold at every η. |
| `bMass` = ⟨B_ab x,x⟩ | LARGELY DISCHARGED by pre-existing `mixQF_Pc` (`mixQF (Pc a) (Pc b) η = bAB a b η`) together with `ψf`. Still missing: a declaration that `Pc ψf cls a` IS W's eigenprojection on bivectors when the fibres of `cls` are the eigenspaces (this needs the unexported orthonormality), and the bridge from L244Caps' `bMass` (ψ ranging over one class, φ labelled) to `bAB`, which are different definitions |
| top-r slot sum as κ_r(x) | **STILL OWED**, untouched by this commit |

**The INDEX row contradicts itself.** The commit replaced only the closing sentence. The row's earlier "**Not typed**" clause still reads *"the construction of ψ, φ, cls from W's eigenspaces (with hexp from completeness, and for h0 a basis of E₀ starting with the unit x), the identity of bMass with ⟨B_ab x,x⟩"*, while the new closing sentence says *"ψ from W's eigenspaces is BUILT"*. The closing sentence itself does not overclaim: it says rows (A), (B), (C) at W's eigenbasis for any labelling meeting `evf k = λ (cls k)`, which is what the types carry. **Repair**: prune the "Not typed" clause to what remains (for h0, a basis of E₀ starting with x; `Pc ψf cls a` as W's eigenprojection and `bMass` against `bAB`; κ_r(x)), and add that `cls` is quantified rather than constructed.

## 5. Docstrings

- Module docstring line 21–22: "the evaluation `evf k = λ (cls k)` gives both resolutions" is imprecise, since `hId_frame` needs no labelling hypothesis. It understates rather than overstates, so it is harmless.
- `rowC_frame`'s "⟨W^# η, η⟩" is accurate (section 3).
- "The spectral eigenframe" for `ψf` is accurate as a description, though only skew, eigen and complete are exported.
- No docstring claims more than its type.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** Every declaration types what it claims and the labelling hypothesis is satisfiable, including by the record's three eigenspace classes. One repair is owed in [lean/INDEX.md](../lean/INDEX.md): the L244 row's "Not typed" clause is stale against its own closing sentence. Still owed on the mathematics: h0's basis of E₀ through x, κ_r(x), `Pc ψf cls a` as W's eigenprojection (with a `ψf_orth`), and a composed row (C) at a critical point.
