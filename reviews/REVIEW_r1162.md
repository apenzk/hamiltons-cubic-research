# REVIEW r1162: L244's h0 at the record's index, in Lean

Brief: [2026-09-25-L244h0-gate2-brief.md](2026-09-25-L244h0-gate2-brief.md). Module: [L244Caps.lean](../lean/HamiltonsCubic/Results/L244Caps.lean). Analysis-only, plus the background build and the axiom audit.

## Verdicts

| item | verdict |
|---|---|
| 1. `rowMass_drop_self`, `rowMass_cap_self` state their claims, index `κ_{m_a − 1}` | CONFIRMED |
| 2. L244 row of [lean/INDEX.md](../lean/INDEX.md) | PLAUSIBLE, with one addition to the "Not typed" list |
| 3. build and axiom audit | CONFIRMED |

## Item 1: CONFIRMED

- `rowMass_drop_self` takes `ψ : Fin (r + 1) → Matrix`, skew `x` and `ψ 0 = x`, and concludes `rowMass ψ φ x = rowMass (ψ ∘ succ) φ x`. The `γ = 0` term is `⟨[x, φ_δ], x⟩²`, which `inner2_br_skew` turns into a multiple of `⟨φ_δ, [x, x]⟩ = 0`. It needs neither orthonormality nor completeness of `φ`, so the statement is stronger than the claim and carries no hidden hypothesis.
- `rowMass_cap_self` has the hypotheses of `rowMass_cap_x` for a family of `r + 1` vectors plus `ψ 0 = x`. Orthonormality with `ψ 0 = x` forces `⟨x, x⟩ = 1`, so `x` is a unit vector, as the record's `h0` requires. The hypotheses are satisfiable (any orthonormal basis of the skew matrices starting with `x/‖x‖` meets them), so the statement is not vacuous.
- The conclusion carries `r * c`, the dual form of the top-`r` sum, with `r = m_a − 1` when `m_a = r + 1`. This is exactly the record's cap over `E_c ∩ x^⊥` for `a = c` ([second-order.md](../findings/second-order.md), L244 (i)), and at `a = 0`, `m_0 = p` it is `κ_{p−1}(x)`, the index [r1161](REVIEW_r1161.md) item 2 fixed. The reading of the universal form as `κ_r(x)` is the one r1161 item 1 confirmed through `exists_c_topSum`.
- The normal form is tied to `x`: the conclusion carries `O Oᵀ = Oᵀ O = 1` and `x = O * N.X * Oᵀ`, and the proof passes `x` itself (not a translate) to `rowMass_cap_x`. The reduced family's orthonormality follows from `hψo` by `Fin.succ_inj`.
- The record's `h0` left side `2(b00 + b01 + b02)` sums `γ` over all `p` vectors of `E_0`. With `rowMass_split` it is `2 rowMass ψ φ x` for the full family, which is the left side of `rowMass_cap_self`, so no term is lost between the record and the Lean.

## Item 2: PLAUSIBLE, with one addition

- The row claims `rowMass_drop_self` and `rowMass_cap_self` with the reading "`2R_a(x) ≤ κ_{m_a−1}(x)` when the family starts with `x`", which is what item 1 confirms. Both r1161 repairs are in: `h0` is no longer attributed to `rowMass_cap_x` at `κ_{m_0}`, and the "Not typed" clause is whole. The `rowMass_cap_x` docstring now reads "`h0` one index high", which is correct.
- **Addition to "Not typed".** r1161 listed as missing the passage from the dual form `∀ c, 2R ≤ r c + ∑ max(μ − c, 0)` to the numeral `κ` fed to `per_vector_ceiling` (through `exists_c_topSum`, or by instantiating `κ₀` as the dual form at a chosen `c`). No declaration in the module performs it, and the row's "i.e. `κ_r(x)`" glosses rest on it. The list should name it beside the construction of `ψ`, `φ`, `cls`, the `bMass = ⟨B_ab x, x⟩` identity and the per-vector rows. The construction item should also say that for `h0` the basis of `E_0` is chosen with first vector the unit `x`, since `rowMass_cap_self` takes that as a hypothesis.

## Item 3: CONFIRMED

- `lake build HamiltonsCubic.Results.L244Caps` from `lean/`: `Build completed successfully (8740 jobs)`, zero errors, no `sorry`. Warnings in the module are style only (three lines over 100 characters, one unused simp argument at line 40).
- `python3 scripts/misc/axiom_audit.py --only L244Caps`: `6/6 clean -- resting on the standard three alone`.
