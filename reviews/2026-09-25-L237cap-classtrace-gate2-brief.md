# Gate 2 brief: the Lean for the L237 cap reduction and the class-trace test (r1151)

**One reviewer: the round compares Lean declarations against statements already fixed.** Analysis-only: read and check; seconds of computation on constructed objects only as a screen. Builds run in the background from `lean/`. Model: opus.

## What to compare

| claim | declaration |
|---|---|
| If every set of at most `r` reals among `μ` sums to at most `B` (and `r > 0`), some `c` has `r c + ∑ₖ max(μₖ - c, 0) ≤ B` | `exists_c_topSum` in [L237Cap.lean](../lean/HamiltonsCubic/Results/L237Cap.lean) |
| A bound `B` on every set of at most `r` slot eigenvalues of `N` bounds `∑ⱼ ⟨yⱼ, -ad_X² yⱼ⟩` for orthonormal skew `y₁..y_r` at `X = O N.X Oᵀ` | `rowSum_le_of_slotSets` |
| At every skew `x`: `∑_γ ‖[x, ψ_γ]‖² ≤ r c + ∑ max(μ - c, 0)` over the slot eigenvalues of some normal form of `x`, for every orthonormal skew `ψ` and every `c` | `bracket_cap` |
| On the nine traced rows (as hypotheses), `16 D = (n - 5 - κ) p - 4 t₀₀₀ - t₀₁₁ - 4 t₁₂₂` with `D = (t₂₂₂ - t₀₀₂ + p)/2`; `D < 0` when `κ > n - 5` and the three traces are nonnegative; `D < 0 ↔ t₀₀₁ < t₀₁₂`; an explicit point satisfies the rows | `sixteenD_identity`, `D_neg_of_kappa`, `D_neg_iff`, `witness_rows` in [ClassTraceTest.lean](../lean/HamiltonsCubic/Results/ClassTraceTest.lean) |

The source for the second file is the paragraph "The leading-order test, in the class traces" of [the working file](2026-09-25-I73c-per-vector-rows.md), audited by [r1149](REVIEW_r1149.md) and [r1150](REVIEW_r1150.md). Compare `Rows` against the nine rows stated there and in r1149's item 2.

## Items

1. Does each declaration state its claim, with no weakening, vacuity or missing hypothesis? In `Rows`, is each of the nine equations the traced row (signs, the factor $\kappa\pm1$)? Is `exists_c_topSum` right at `card K ≤ r` and at `card K > r`?
2. Is anything in the INDEX rows for L237, L244 and the working file's "Typed:" line claimed beyond these declarations?
3. Build both modules in the background, run `python3 scripts/misc/axiom_audit.py --only L237Cap` and `--only ClassTraceTest`; report axioms and completeness.

## Protocol

Log to `agent_logs/r1151.log` (first line PID and phase plan, a line per phase, heartbeat every ~3 minutes). The LAST line must START with the word DONE or FAILED. Commit a skeleton `reviews/REVIEW_r1151.md` first and update it, committing only that file by path. Do NOT edit `reviews/INDEX.md`, any Lean file or any script. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections.
