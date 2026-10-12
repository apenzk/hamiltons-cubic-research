# Gate 2 brief: L244 row (A) in the record's variables, in Lean (r1172)

**One reviewer: the round compares a Lean declaration against a statement already fixed** (row (A) of the per-vector rows: $\sum_{a,b}b_{ab}(x)=(n-2)\langle x,x\rangle$, with $b_{ab}(x)=\tfrac12\sum_{\gamma\in E_a,\delta\in E_b}\langle[\psi_\gamma,\psi_\delta],x\rangle^2$). Analysis-only; builds in the background from `lean/`, waiting if another is running. Model: opus.

## What to compare

| claim | declaration |
|---|---|
| With `ψ` and `φ` both the full basis `φ_ij` (`i < j`), `rowMass ψ φ x = (n − 2) ⟨x, x⟩` for skew `x` | `rowMass_total` in [L244RowA.lean](../lean/HamiltonsCubic/Results/L244RowA.lean) |

## Items

1. Does `rowMass_total` state row (A) summed over all classes (with `rowMass_split`, any class labelling of the basis gives `∑_{a,b} b_ab`)? Is `basisFam` the full orthonormal basis, reindexed correctly?
2. Does the L244 row of [lean/INDEX.md](../lean/INDEX.md) claim only this?
3. Build `HamiltonsCubic.Results.L244RowA` in the background and run `python3 scripts/misc/axiom_audit.py --only L244RowA`.

## Protocol

Log to `agent_logs/r1172.log` (first line PID and phase plan, a line per phase, heartbeat every ~3 minutes). The LAST line must START with DONE or FAILED. Commit a skeleton `reviews/REVIEW_r1172.md` first and update it, committing only that file by path. Do NOT edit `reviews/INDEX.md`, any Lean file or any script. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections.
