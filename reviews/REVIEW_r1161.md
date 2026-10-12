# REVIEW r1161: L244's x-dependent cap and eigenspace split, in Lean

Brief: [2026-09-25-L244caps2-gate2-brief.md](2026-09-25-L244caps2-gate2-brief.md). Module: [L244Caps.lean](../lean/HamiltonsCubic/Results/L244Caps.lean). Analysis-only, plus the background build and the axiom audit.

## Verdicts

| item | verdict |
|---|---|
| 1. `rowMass_cap_x` states `2R_a(x) ≤ κ_r(x)` | CONFIRMED |
| 2. `bMass`, `rowMass_split` give `h0`'s shape | PLAUSIBLE, with a correction: the record's `h0` is `κ_{p−1}(x)`, one below what `rowMass_cap_x` yields at `r = m_0` |
| 3. build, axiom audit, INDEX row | CONFIRMED for build and audit. The INDEX row carries the same overclaim for `h0` and a garbled "Not typed" clause |

## Item 1: CONFIRMED

- `rowMass_cap_x` is `bracket_cap` from [L237Cap.lean](../lean/HamiltonsCubic/Results/L237Cap.lean) after Parseval (`rowMass_eq`) and the sign swap `‖[ψ,x]‖² = ‖[x,ψ]‖²`. The factor is right: `rowMass = ½ ∑_γ ‖[ψ_γ,x]‖²`, so `2·rowMass` is the bracket sum `bracket_cap` bounds.
- `N` is tied to `x`: the conclusion carries `x = O * N.X * Oᵀ` with `O Oᵀ = Oᵀ O = 1`, so `−ad_x²` and `−ad_{N.X}²` are orthogonally conjugate and share their spectrum. The `slotμ N` are that full spectrum, since the slot family is an orthonormal eigenbasis (`slot_eigen`, `slot_orthonormal`, `slot_complete` in [L240SlotBasis.lean](../lean/HamiltonsCubic/Results/L240SlotBasis.lean)).
- The dual form over all `c` is the top-`r` sum. For each `c` and each set `S` of size at most `r`, `∑_S μ ≤ r c + ∑_k max(μ_k − c, 0)`, so the dual form dominates `κ_r`. Conversely `exists_c_topSum` with `B = κ_r(x)` gives a `c` at which the dual form is at most `κ_r(x)`, so the universal statement implies `2R_a(x) ≤ κ_r(x)` for `r > 0`. At `r = 0` the family is empty and `R_a = 0`. When `r` exceeds the number of slots the universal statement would fail as `c → −∞`, but then no orthonormal `ψ` of that size exists, so the hypothesis `hψo` is empty.

## Item 2: PLAUSIBLE, with a correction

- `bMass ψ φ cls b x` is `½ ∑_γ ∑_{cls δ = b} ⟨[ψ_γ, φ_δ], x⟩²`. When `W` is symmetric its eigenspaces are orthogonal, so an orthonormal eigenbasis `φ` labelled by `cls` restricts to an orthonormal basis of each `E_b`. The sum over an orthonormal basis of `E_b` is basis independent (it is the squared norm of the projection onto `E_b` of the vector `δ ↦ ⟨[ψ_γ, δ], x⟩`), so it equals the record's `b_ab(x)` for any choice, including `φ`'s class-`a` vectors differing from `ψ`.
- `rowMass_split` is an exact fibrewise regrouping (`Finset.sum_fiberwise`) and needs no hypothesis. With `C` the three labels and `ψ` a basis of `E_a`, `r = m_a`, the two theorems give `2(b_a0 + b_a1 + b_a2) ≤ κ_{m_a}(x)`.
- **Correction.** The record's `h0` is NOT `κ_{m_0}(x)`. [second-order.md](../findings/second-order.md), L244 (i), states the caps as `κ_{m_a}(x)` and `κ_{m_c−1}(x)` for `a = c`, and (ii) uses `K ≤ κ_{p−1}(x)` at `x ∈ E_0`, `m_0 = p`. So `κ₀` in `per_vector_ceiling` is `κ_{p−1}(x)`, and `h2`'s `κ₂` is `κ_p(x)`. The brief's gloss `κ_c = κ_{m_c}(x)` is right for `h2` and one index too high for `h0`. Instantiating `h0` with `r = m_0 = p` is sound but proves only `K ≤ κ_p(x)`, which is weaker than the record's `K ≤ κ_{p−1}(x)`.
- The Lean docstring of `rowMass_cap_x` ("the cap L244 takes as `h0`, `h2`") and the INDEX row ("the form of `h0`, `h2`") carry the same slip for `h0`.
- **What is still missing to discharge `h0`, `h2`**:
  - the construction of `ψ` as an orthonormal basis of `E_a` and of `φ`, `cls` as an orthonormal eigenbasis of `W` on the skew matrices, with `hexp` from its completeness;
  - the identity `bMass = ⟨B_ab x, x⟩` with `B_ab = P_a # P_b`, the record's definition of `b_ab`;
  - for `h0`: a basis of `E_0` whose first vector is `x` (unit), the vanishing of that row (`⟨[x, φ_δ], x⟩ = ±⟨φ_δ, [x, x]⟩ = 0`), and `rowMass_cap_x` on the remaining `p − 1` vectors of `E_0 ∩ x^⊥`;
  - the passage from the dual form to the numeral `κ` fed to `per_vector_ceiling`, through `exists_c_topSum` as in item 1 (or by instantiating `κ` as the dual form at a chosen `c`);
  - the per-vector rows `hA`, `hB`, `hC`, still hypotheses.

## Item 3: CONFIRMED, with INDEX corrections

- `lake build HamiltonsCubic.Results.L244Caps` from `lean/`: `Build completed successfully (8740 jobs)`, zero errors, no `sorry`, style warnings only (one line over 100 characters at line 98).
- `python3 scripts/misc/axiom_audit.py --only L244Caps`: `4/4 clean -- resting on the standard three alone`.
- The L244 row of [lean/INDEX.md](../lean/INDEX.md) claims `rowMass_cap_x`, `bMass`, `rowMass_split` and nothing beyond them. Two repairs:
  - "the form of `h0`, `h2`" should read "the form of `h2`, and of `h0` at `κ_{m_0}`, one index above the record's `κ_{p−1}`";
  - "**Not typed**:  and the per-vector rows" has lost its first clause. It should list the construction of `ψ`, `φ` from `W`'s eigenspaces, the identity with `⟨B_ab x, x⟩`, the `E_0 ∩ x^⊥` reduction for `h0`, and the per-vector rows.
