# Gate 2 brief: L244's x-dependent cap and eigenspace split, in Lean (r1161)

**One reviewer: the round compares Lean declarations against a statement already fixed** (L244's hypotheses `h0`, `h2` in [L244SymmetricPerVector.lean](../lean/HamiltonsCubic/Results/L244SymmetricPerVector.lean): `2 (b00 + b01 + b02) ≤ κ₀`, `2 (b02 + b12 + b22) ≤ κ₂`, with `κ_c = κ_{m_c}(x)` the top-`m_c` eigenvalue sum of `-ad_x²`; audited in [r1158](REVIEW_r1158.md) for the uniform form). Analysis-only; builds in the background from `lean/`, waiting if another is running. Model: opus.

## What to compare, in [L244Caps.lean](../lean/HamiltonsCubic/Results/L244Caps.lean)

| claim | declaration |
|---|---|
| At every skew `x`, with `x = O N.X Oᵀ`, `2 R_a(x) ≤ r c + ∑ₖ max(μₖ − c, 0)` for every `c`, the `μ` being `N`'s slot eigenvalues; i.e. `2 R_a(x) ≤ κ_r(x)` | `rowMass_cap_x` |
| `R_a(x) = ∑_b b_ab(x)` for any labelling `cls` of the complete family by eigenspace | `bMass`, `rowMass_split` |

## Items

1. Does `rowMass_cap_x` state `2R_a(x) ≤ κ_r(x)`: is the Ky Fan dual form, over all `c`, exactly the top-`r` sum (see `exists_c_topSum` in [L237Cap.lean](../lean/HamiltonsCubic/Results/L237Cap.lean) for the other direction), and is `N` tied to `x`?
2. Is `bMass ψ φ cls b x` the record's `b_ab(x)` when `cls` labels an orthonormal eigenbasis by eigenspace, and does `rowMass_split` together with `rowMass_cap_x` give exactly `h0`'s shape `2(b_a0 + b_a1 + b_a2) ≤ κ_{m_a}(x)`? Say what is still missing to discharge `h0`, `h2` in `per_vector_ceiling` (the construction of `ψ`, `φ` from `W`'s eigenspaces, the relation of `κ` there to the dual form here).
3. Build `HamiltonsCubic.Results.L244Caps` in the background, run `python3 scripts/misc/axiom_audit.py --only L244Caps`, and check the L244 row of [lean/INDEX.md](../lean/INDEX.md) claims only this.

## Protocol

Log to `agent_logs/r1161.log` (first line PID and phase plan, a line per phase, heartbeat every ~3 minutes). The LAST line must START with DONE or FAILED. Commit a skeleton `reviews/REVIEW_r1161.md` first and update it, committing only that file by path. Do NOT edit `reviews/INDEX.md`, any Lean file or any script. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections.
