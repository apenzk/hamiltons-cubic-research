# Review r1158: L244's cap in eigenspace form, in Lean

Brief: [2026-09-25-L244caps-gate2-brief.md](2026-09-25-L244caps-gate2-brief.md). Target: [L244Caps.lean](../lean/HamiltonsCubic/Results/L244Caps.lean). Reference statement: the opening section of [2026-09-25-I73c-per-vector-rows.md](2026-09-25-I73c-per-vector-rows.md) and the cap hypotheses `h0`, `h2` of [L244SymmetricPerVector.lean](../lean/HamiltonsCubic/Results/L244SymmetricPerVector.lean).

## Verdicts

| item | verdict |
|---|---|
| 1. `rowMass` is the sum over `b` of `b_ab(x)`, and `rowMass_eq`'s hypothesis | CONFIRMED |
| 2. `rowMass_le` at every skew `x`, and the INDEX row | CONFIRMED, two corrections recommended |
| 3. build and axiom audit | CONFIRMED |

## Item 1

- `B_ab = ½ ∑_{γ ∈ E_a, δ ∈ E_b} [ψ_γ, ψ_δ] ⊗ [ψ_γ, ψ_δ]` with `(u ⊗ u) x = ⟨u, x⟩ u` gives `b_ab(x) = ⟨B_ab x, x⟩ = ½ ∑_{γ,δ} ⟨[ψ_γ, ψ_δ], x⟩²`. Summing over `b` runs `δ` over the union of orthonormal bases of the eigenspaces of `W`, which is a complete orthonormal basis of the skew matrices because the spectral projections `P_b` sum to the identity (the zero eigenspace included). That is `rowMass ψ φ x = ½ ∑_γ ∑_δ inner2 (br (ψ γ) (φ δ)) x ^ 2`, with the same factor `½` and the same pairing, the bracket order being immaterial under the square.
- The inner product `inner2 X Y = ½ tr(Xᵀ Y)` is the record's normalisation. Cross-check: summing `rowMass_eq` over all `a` gives `½ ∑_{ONB} ‖[ψ, x]‖² = (n − 2) ⟨x, x⟩` (at `x = e₁ ∧ e₂` the unit brackets come from `e₁ ∧ e_k`, `e₂ ∧ e_k`, `k ≥ 3`, so `2(n − 2)` of them), matching the note's `∑_{a,b} B_ab = (n − 2) Id`.
- `hexp : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (φ k) Y • φ k` is sound as the completeness hypothesis. Pairing the expansion with `Y` gives `⟨Y, Y⟩ = ∑_k ⟨φ_k, Y⟩²`, which is all Parseval uses, so `φ` is only required to be a Parseval (tight, bound one) frame for the skew matrices, and it need not be skew itself, since the transfer `⟨[ψ_γ, φ_δ], x⟩ = −⟨φ_δ, [ψ_γ, x]⟩` ([inner2_br_skew](../lean/HamiltonsCubic/Results/L209FoxClosure.lean#L128)) needs only `ψ_γ` skew. Every complete orthonormal basis of skew matrices satisfies `hexp`, so the intended instance is covered and the hypothesis is satisfiable. Dropping orthonormality of `φ` weakens the hypothesis and so strengthens the theorem.

## Item 2

- `rowMass_le` takes `x` with `IsSkew x` and nothing else. The remaining hypotheses are on the families: `0 < r`, `ψ` skew and orthonormal, `φ` complete. The extra `[LinearOrder ι]` is a typeclass any finite index type admits and is harmless. The proof composes `rowMass_eq`, the swap `‖[ψ_γ, x]‖ = ‖[x, ψ_γ]‖`, and [kappa_cap_norm](../lean/HamiltonsCubic/Results/L237SlotCounts.lean#L212).
- The INDEX row for L244 in [lean/INDEX.md](../lean/INDEX.md) claims exactly `R_a(x) ≤ ½ (r + 2) ⟨x, x⟩` from `κ_r ≤ r + 2`, and lists the eigenspace split and the per-vector rows as untyped. That matches the file.
- **Correction recommended (INDEX, scope)**: `rowMass_le` is the `x`-uniform bound, weaker than the cap L244 consumes, `2 R_a(x) ≤ κ_{m_a}(x)` with `κ` depending on `x`. At the decomposable `x` of the star window the caps are `κ_{p−1} = p − 1` and `κ_p = p`, while `rowMass_le` gives `p + 1` and `p + 2`. So `rowMass_le` does not discharge `h0`, `h2` at the values L244 uses. The `x`-dependent cap is one composition away (`rowMass_eq` with [bracket_cap](../lean/HamiltonsCubic/Results/L237Cap.lean), whose right side `rc + ∑_k max(μ_k − c, 0)` is the Ky Fan dual form), but it is not stated. The row's "Not typed" list should name it, so that "the cap in eigenspace form" reads as the uniform version.
- **Correction recommended (module docstring)**: lines 11 to 13 of [L244Caps.lean](../lean/HamiltonsCubic/Results/L244Caps.lean) say `bracket_cap` bounds the row mass in `rowMass_cap`. No declaration `rowMass_cap` exists. The bound is `rowMass_le` and it rests on `kappa_cap_norm`, with `bracket_cap` unused in the file.

## Item 3

- `lake build HamiltonsCubic.Results.L244Caps` from `lean/`: exit 0, 8740 jobs, no errors and no `sorry`. Warnings only: line length, unused simp arguments at lines 40 and 66, and an unused `[DecidableEq ι]` in the types of `rowMass_eq` and `rowMass_le`.
- `python3 scripts/misc/axiom_audit.py --only L244Caps`: 2/2 clean, resting on the standard three axioms alone.
