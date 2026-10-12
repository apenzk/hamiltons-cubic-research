# Gate 2 brief: the Lean for L240's rows and deficit step (r1157)

**One reviewer: the round compares Lean declarations against a statement already fixed** (the proof of Lemma L240 in [second-order.md](../findings/second-order.md), first two sentences). Analysis-only; builds run in the background from `lean/` (wait if another Lean build is running). Model: opus.

## What to compare, in [L240Rows.lean](../lean/HamiltonsCubic/Results/L240Rows.lean)

| claim | declaration |
|---|---|
| For skew `A`, `inner2 A B = ipSo A B`; the bracket of skew matrices is skew | `inner2_eq_ipSo`, `br_skew` |
| Every row `row_i = ∑_{j≠i} ‖[X_i, X_j]‖²` of an orthonormal seven-frame in `𝔰𝔬(n)` (in `SevenFrameGap`'s `ipSo`) is at most `8` | `row_le_eight`, via `kappa_cap_norm` at `r = 6` |
| `bracketTotal X ≤ 56` | `bracketTotal_le_56` |
| If `bracketTotal X > 54.064`, some `8 − row_i < 1.936/7` | `exists_small_deficit` |

## Items

1. Does each declaration state its claim over `seven_frame_lemma`'s own hypotheses (`hskew`, `hon` with `ipSo`), with no weakening or vacuity? Is `row` the row of `bracketTotal` (so that `bracketTotal X = ∑ i, row X i` by definition)?
2. The record said "some element has δ < 0.27657"; the file states `1.936/7 = 0.2765714…` and says the rounded value is refused. Check that `0.27657` genuinely does not follow (`7 × 0.27657 < 1.936`) and that no later step of L240's proof in the record needs a threshold below `1.936/7`.
3. Build `HamiltonsCubic.Results.L240Rows` in the background and run `python3 scripts/misc/axiom_audit.py --only L240Rows`; report axioms and completeness. Check the L240 row of [lean/INDEX.md](../lean/INDEX.md) claims nothing beyond these.

## Protocol

Log to `agent_logs/r1157.log` (first line PID and phase plan, a line per phase, heartbeat every ~3 minutes). The LAST line must START with DONE or FAILED. Commit a skeleton `reviews/REVIEW_r1157.md` first and update it, committing only that file by path. Do NOT edit `reviews/INDEX.md`, any Lean file or any script. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections.
