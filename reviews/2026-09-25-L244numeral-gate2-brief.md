# Gate 2 brief: L244's dual form to a numeral, in Lean (r1163)

**One reviewer: the round compares a Lean declaration against a statement already fixed** ([r1162](REVIEW_r1162.md) item 2: the missing passage from the "for every `c`" form of the cap to the numeral `κ` fed to `per_vector_ceiling`). Analysis-only; builds in the background from `lean/`, waiting if another is running. Model: opus.

## What to compare, in [L244Caps.lean](../lean/HamiltonsCubic/Results/L244Caps.lean)

| claim | declaration |
|---|---|
| If `R ≤ r c + ∑ max(μ − c, 0)` for every `c` and every set of at most `r` slot eigenvalues sums to at most `κ` (`r > 0`), then `R ≤ κ` | `twice_rowMass_le_of_top` |

## Items

1. Does the declaration state the claim, with no weakening or vacuity? Is `κ = κ_r(x)` (the top-`r` sum of `x`'s slot eigenvalues) an admissible instance of `htop`, so that composing with `rowMass_cap_x` or `rowMass_cap_self` yields exactly `h2`, `h0` of `per_vector_ceiling` with the record's `κ` values?
2. Is the L244 row of [lean/INDEX.md](../lean/INDEX.md) accurate after this addition, and is its "Not typed" list complete?
3. Build `HamiltonsCubic.Results.L244Caps` in the background and run `python3 scripts/misc/axiom_audit.py --only L244Caps`.

## Protocol

Log to `agent_logs/r1163.log` (first line PID and phase plan, a line per phase, heartbeat every ~3 minutes). The LAST line must START with DONE or FAILED. Commit a skeleton `reviews/REVIEW_r1163.md` first and update it, committing only that file by path. Do NOT edit `reviews/INDEX.md`, any Lean file or any script. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections.
