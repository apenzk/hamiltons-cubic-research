# Review r223 -- Gate 2, adversarial

Reviewer 223. Brief: `brief17.md`. Commits under review: 1bf0974, 6ca5418, 7479d70.
Assigned claims: 3, 4, 5 (r222 runs 1 and 2 concurrently).

## Verdicts

| # | Claim | Verdict |
|---|---|---|
| 3a | The new `sparse_rank` is a correct rank/nullity computation | **UPHELD** -- 16/16 against a Sage GF(P) oracle, and all 6 planted mutants fire |
| 3b | The reopening in 1bf0974 did not over-claim relative to e106cc2 | pending |
| 4 | The first-fundamental-theorem escape is right and avoids the 635,220 elimination; multiplicity 2 | pending |
| 5 | No third route in plan.md / FINDINGS.md is closed on bad evidence | pending |

Work in progress; this file is updated after every claim settled.

## Claim 3a -- is the new `sparse_rank` a correct rank computation?

**UPHELD.** It is.

[scripts/reviewers/r223/extract.py](scripts/reviewers/r223/extract.py) pulls `sparse_rank` verbatim out of [scripts/runs/run_n12_covariants.py](scripts/runs/run_n12_covariants.py) by source slice, so the tested object is the shipped code and never a transcription. [scripts/reviewers/r223/c3_planted_rank.py](scripts/reviewers/r223/c3_planted_rank.py) then runs it against sixteen matrices of planted rank over the same prime P = 2147483647, with `Matrix(GF(P)).rank()` in SageMath as the independent oracle.

| part | result |
|---|---|
| shipped routine vs Sage oracle | 16 cases, **0 disagreements** |
| planted mutants that the harness catches | **6 of 6 fire** |

The cases cover the empty matrix, all-zero rows, the identity, repeated rows, a rank-1 outer product, five dense products `A*B` with rank planted at 17, 30, 45, 79 and 50, and five sparse matrices built as random combinations of a known basis under a random column permutation.

One case is worth recording because it shows the harness is doing work: on `planted sparse 400x200 rank 200` the generator's *target* was 200 and both Sage and `sparse_rank` return **195** -- 200 random sparse rows in 200 columns are not independent. The oracle caught my generator, not the code under review.

The mutants, each breaking one distinct part of the method: no live-row update (the e106cc2 defect), pivot inverse dropped, wrong elimination sign, cancellation ignored, fill-in not recorded in `colrows`, and eliminating only the first live row of the pivot column. Each fires on 4 to 11 of the sixteen cases. A harness on which the old defect passes would have told us nothing.

Reading the code confirms the empirical result: rows that cancel to empty are deleted rather than counted, the pivot entry itself is driven to zero and discarded on the `c == bc` pass, `colrows` is maintained symmetrically on both fill-in and cancellation, and `rank` counts pivots. `ncols` is accepted and never used, which is harmless -- the caller forms `nullity = len(B) - rk` itself.
