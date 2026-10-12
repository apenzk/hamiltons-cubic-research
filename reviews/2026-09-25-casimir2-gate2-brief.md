# Gate 2 brief: the Casimir identity on skew matrices and the halving, in Lean (r1169)

**One reviewer: the round compares Lean declarations against statements already fixed** (row (A) of the per-vector rows, $\sum_{a,b}b_{ab}(x)=(n-2)\langle x,x\rangle$, as the Casimir mass on skew $x$). Analysis-only; builds in the background from `lean/`, waiting if another is running. Model: opus.

## What to compare, in [Casimir.lean](../lean/HamiltonsCubic/Results/Casimir.lean)

| claim | declaration |
|---|---|
| For skew `x`, `∑_{i,j} ‖[φ_ij, x]‖_F² = 4(n − 2) ‖x‖_F²` | `casimir_skew` |
| For `f` symmetric with zero diagonal, `∑_{i,j} f = 2 ∑_{i<j} f` | `sum_halve` |
| `φ_ji = −φ_ij`, `φ_ii = 0` | `phi_swap`, `phi_diag` |
| For skew `x`, `∑_{i<j} ‖[φ_ij, x]‖_F² = 2(n − 2) ‖x‖_F²` | `casimir_skew_lt` |
| `Casimir.phi = RealLayer.phi`; traceless form of `casimir` | `phi_eq_layer`, `casimir_traceless` |

## Items

1. Does each declaration state its claim with no weakening or vacuity? Is `casimir_skew_lt` in the record's `½ tr` norm exactly `∑_{i<j} ⟨[φ_ij,x],[φ_ij,x]⟩ = 2(n−2)⟨x,x⟩`, and is that row (A) summed over classes (`Σ_{a,b} b_ab(x) = (n−2)⟨x,x⟩`, with `b_ab` carrying a factor `½`)? Check the factor.
2. Do the L244 row of [lean/INDEX.md](../lean/INDEX.md) and the working file's mentions claim only this?
3. Build `HamiltonsCubic.Results.Casimir` in the background and run `python3 scripts/misc/axiom_audit.py --only Casimir`.

## Protocol

Log to `agent_logs/r1169.log` (first line PID and phase plan, a line per phase, heartbeat every ~3 minutes). The LAST line must START with DONE or FAILED. Commit a skeleton `reviews/REVIEW_r1169.md` first and update it, committing only that file by path. Do NOT edit `reviews/INDEX.md`, any Lean file or any script. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections.
