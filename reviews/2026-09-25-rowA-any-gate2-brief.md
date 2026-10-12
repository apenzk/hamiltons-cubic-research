# Gate 2 brief: row (A) at any complete skew family, in Lean (r1173)

**One reviewer: the round compares Lean declarations against statements already fixed** ([r1172](REVIEW_r1172.md): reaching the record's $b_{ab}$ at $W$'s eigenbases needs basis independence of $R(x)=\tfrac12\sum_\gamma\lVert[\psi_\gamma,x]\rVert^2$). Analysis-only; builds in the background from `lean/`, waiting if another is running. Model: opus.

## What to compare, in [L244RowA.lean](../lean/HamiltonsCubic/Results/L244RowA.lean)

| claim | declaration |
|---|---|
| For a family `φ` with `Y = ∑ ⟨φ_k, Y⟩ φ_k` on skew `Y`, `⟨Y, Y⟩ = ∑ ⟨φ_k, Y⟩²` | `parseval` |
| `∑ ‖[x, ψ_γ]‖²` is the same over any two such families of skew matrices, for skew `x` | `bracket_sum_indep` (with `br_isSkew`) |
| Row (A): `rowMass ψ φ x = (n − 2)⟨x, x⟩` for `ψ` any such family of skew matrices indexed by `Fin r` and `φ` any complete family | `rowMass_total_any` (with `br_sq_swap`) |

## Items

1. Does each declaration state its claim with no weakening or vacuity? Does the completeness hypothesis (`Y = ∑ ⟨φ_k,Y⟩ φ_k` on skew `Y`) hold for an orthonormal basis of `W`'s eigenspaces (so that `rowMass_total_any` reaches the record's `∑_{a,b} b_ab` there), and is anything else needed?
2. Does the L244 row of [lean/INDEX.md](../lean/INDEX.md) claim only this, and what remains untyped for L244's hypotheses `hA`, `hB`, `hC`?
3. Build `HamiltonsCubic.Results.L244RowA` in the background and run `python3 scripts/misc/axiom_audit.py --only L244RowA`.

## Protocol

Log to `agent_logs/r1173.log` (first line PID and phase plan, a line per phase, heartbeat every ~3 minutes). The LAST line must START with DONE or FAILED. Commit a skeleton `reviews/REVIEW_r1173.md` first and update it, committing only that file by path. Do NOT edit `reviews/INDEX.md`, any Lean file or any script. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections.
