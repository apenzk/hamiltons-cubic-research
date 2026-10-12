# r1729: L52Rot, the rotation behind rot4

Cold Gate 2 review of [L52Rot.lean](../lean/HamiltonsCubic/Results/L52Rot.lean) at commit a09660ea, against [L52Remarks.lean](../lean/HamiltonsCubic/Results/L52Remarks.lean), the "only if" bullet of Lemma L52 in [bispectral.md](../findings/bispectral.md) and the L52 row of [lean/INDEX.md](../lean/INDEX.md). Analysis only: Lean source read, no `lake build`. The three matrix identities were checked by hand (a numpy screen was attempted and numpy is absent). Log: agent_logs/review-r1729.log.

| Claim | Verdict |
|---|---|
| `U4` is the pi/4 rotation in the e0e1 plane, the repeated eigenplane of diag(1,1,2) | CONFIRMED |
| `U4_orth`, `U4_sq`, `U4_fixes` are the right three facts, in L52's convention | CONFIRMED |
| With `rot4_rowtight` and `rot4_not_perm`, the example supports "row-tightness alone does not make U a permutation" | CONFIRMED WITH GAP (G1) |
| Docstrings and INDEX row claim only what is typed | CONFIRMED WITH GAP (G2) |

**Summary: CONFIRMED WITH GAP. The file types exactly the example the record names, and the gaps are a missing one-line composition and a stale "(not declared)" in L52Remarks.**

## 1. The rotation

- The record's bullet (bispectral.md line 84): *"$U$ itself need not be a permutation: a $\pi/4$ rotation inside a degenerate eigenplane is row-tight, and degenerate spectra are the standing case here."*
- `U4 = !![c, -c, 0; c, c, 0; 0, 0, 1]` with `c = 1/√2` is [[cos, -sin], [sin, cos]] at pi/4 on e0, e1 and fixes e2. The e0e1 plane is the eigenvalue-1 eigenplane of `mu4 = (1, 1, 2)`, so this is the rotation L52Remarks' header describes.
- Orientation is irrelevant: the opposite rotation has the same entrywise squares, and any rotation of that plane commutes with diag(1,1,2), whose restriction there is the identity.

## 2. The three facts and the convention

- `U4_orth` gives `U4ᵀ U4 = 1`. For a square matrix this implies `U4 U4ᵀ = 1`, so no second orthogonality fact is owed.
- `U4_sq` gives `U4 i j ^ 2 = rot4 i j`, the record's `P_ij = U_ij²` read entrywise. By hand: every e0e1 entry squares to 1/2, the (2,2) entry to 1, the rest to 0.
- `U4_fixes` states `U4 * diagonal mu4 * U4ᵀ = diagonal mu4`. The programme's convention comes from [SchurMajor.lean](../lean/HamiltonsCubic/Results/SchurMajor.lean)'s `diag_doublyStochastic`: `A = U diag(λ) Uᵀ` with the eigenvectors as columns of `U` (Mathlib's `eigenvectorUnitary`), so `A_ii = Σ_j U_ij² λ_j` and `rot4_rowtight` pairs row `i` of `P` with `mu4 j`. `U diag Uᵀ` is the orientation that matches, and it is the one typed.
- The other orientation would hold as well, since `U4ᵀ` is also a rotation of the eigenplane and `rot4` is symmetric. The choice matters for the convention's fidelity and changes nothing in this example.
- Reading: `A = diag(1,1,2)`, eigenbasis given by the columns of `U4`, diagonal `K = (1,1,2) = μ` (so Jensen is tight in every row), and `P = |U4|²` is `rot4`.

## 3. Support for the remark

- The chain is complete by reading: `U4_orth` and `U4_fixes` make `U4` a diagonalising orthogonal matrix of diag(`mu4`), `U4_sq` identifies its `P` with `rot4`, `rot4_ds` and `rot4_rowtight` give double stochasticity and row-tightness for every `g`, and `rot4_not_perm` makes `P` not 0/1, so `U4` is no signed permutation.
- **G1.** No declaration states the composition, for instance "`∃ U` orthogonal with `U diag(mu4) Uᵀ = diag(mu4)`, `P = |U|²` row-tight and not 0/1". It is a one-line conjunction of existing theorems. Optional, recorded so the INDEX row's "so it is an eigenbasis change of `mu4` whose squares are no permutation" is read as a composition the reader performs.

## 4. Docstrings and INDEX

- L52Rot's header and docstrings claim only what the four theorems type. "The rotation stays inside the repeated eigenplane" is the content of `U4_fixes` together with the matrix's zero pattern, both visible.
- **G2.** [L52Remarks.lean](../lean/HamiltonsCubic/Results/L52Remarks.lean) lines 29–30, the `rot4` docstring, still says `U` is *"(not declared)"*. That is now false: `U4` is declared in L52Rot (which imports L52Remarks, so the docstring should point forward to L52Rot by name).
- The INDEX row's new sentence names `U4`, `U4_orth`, `U4_sq`, `U4_fixes` with their typed content, "no permutation" resting on `rot4_not_perm` from L52Remarks. The rotation is gone from the row's owed list. It claims nothing beyond the types. It omits the theorem count and the axiom line the other entries carry (4/4 on the standard three per the brief), a format gap only.

## Overall verdict

**CONFIRMED WITH GAP.** `U4` is the record's pi/4 rotation, the three facts are the right ones in the programme's `U diag Uᵀ` convention, and the example now fully backs the remark by composition. Repairs: refresh the "(not declared)" docstring in L52Remarks (G2), and optionally add the one-line composed statement (G1).
