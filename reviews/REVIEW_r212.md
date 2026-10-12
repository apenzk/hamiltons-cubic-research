# Gate 2 review r212 -- the lift to Q and the claimed strictly-PSD point

Commits under review: eaf59e1, cc1cabd (with cbb18cf as context).
Scope assigned: claims 3, 4, 5 of brief17 (reviewer 211 runs claims 1-2 concurrently).
Scripts: [scripts/reviewers/r212/](../scripts/reviewers/r212/). Log: [agent_logs/gate2_212.log](../agent_logs/gate2_212.log).

## Verdict table

| # | Claim | Verdict |
|---|-------|---------|
| 3 | The reported point is affine-feasible against the EXACT rational rows and PSD | PENDING |
| 3b | PSD in these coordinates really means an SOS certificate (congruence by h) | PENDING |
| 4 | "unbounded" reads as feasibility plus a PSD kernel direction | PENDING |
| 5 | An exact rational point in the family, verified PSD by ldl_psd | PENDING |

(rows updated as each settles)

## Claim 3 -- REFUTED. The SDP's block structure does not match the columns of the rows.

[run_n5_assemble.py:851](../scripts/runs/run_n5_assemble.py#L851) lays out one row's 47 real coordinates by iterating

    for lam in sorted(ADAPTED, key=lambda l: (-len(ADAPTED[l]), l)):

i.e. blocks ordered by DECREASING multiplicity m, then by lambda. The dump written twelve lines later at [run_n5_assemble.py:1231](../scripts/runs/run_n5_assemble.py#L1231) records the metadata in a different order:

    "blocks": [list(l) for l in sorted(TR) if TR[l]],
    "shape":  [len(TR[l]) for l in sorted(TR) if TR[l]]

i.e. ordered by lambda alone. The two orders disagree, so `shape` does not describe `rows`.

### What the mismatch is

The multiplicities m = len(ADAPTED[lambda]) come from [n5_adapted.pkl](../scripts/runs/n5_adapted.pkl); the surviving size is k = m for lambda_2 odd and k = m-1 for lambda_2 even. Sorting the sixteen live blocks the two ways gives

| order | block sequence | shape |
|---|---|---|
| herm_row, `(-m, lam)` -- what the 47 columns actually are | (2,2) (4,2) (3,2) (2,0) (2,1) (3,0) (3,1) (4,0) (4,1) (4,3) (4,4) (5,2) (3,3) (5,1) (5,3) (6,3) | `[3,3,2,1,2,1,2,1,2,2,1,1,1,1,1,1]` |
| the dump, `lam` -- what [run_n5_lift.py](../scripts/runs/run_n5_lift.py) builds its variables from | (2,0) (2,1) (2,2) (3,0) (3,1) (3,2) (3,3) (4,0) (4,1) (4,2) (4,3) (4,4) (5,1) (5,2) (5,3) (6,3) | `[1,2,3,1,2,2,1,1,2,3,2,1,1,1,1,1]` |

Both shapes sum to 47 in squares, so `assert len(coord) == NC` passes and nothing downstream complains. But 31 of the 47 coordinates change role: a column that is truly a diagonal entry of a Hermitian block is read as a real or imaginary off-diagonal part, and vice versa. Eight columns that are genuinely diagonal entries -- quantities a PSD block forces to be non-negative -- are read as IMAGINARY parts of off-diagonal entries, which carry no sign condition at all. Columns 1,2,3,4,8,...,40 are affected; see [scripts/reviewers/r212/r212_layout.py](../scripts/reviewers/r212/r212_layout.py).

The rank-13 evidence does not detect this: rank is invariant under a permutation of columns, so the lift's own consistency check passes under either reading.

### What the correct layout gives

Reproducing the solve under both layouts ([r212_sdp.py](../scripts/reviewers/r212/r212_sdp.py), CLARABEL, from my own exact lift):

| layout | status | worst eigenvalue | scaled affine residual |
|---|---|---|---|
| the dump's (what was reported) | optimal, t at the cap 1 | **1.416183** | 7.972e-14 |
| herm_row's (correct) | optimal, t interior at 0.0234 | **2.336698e-02** | 3.342e-15 |

The first row reproduces the commit message digit for digit, so the harness is the author's. The reported eigenvalue 1.416183 is the least eigenvalue of a set of matrices assembled from the wrong entries.

**The conclusion nevertheless survives**: under the correct layout the family still contains a strictly positive definite point, with margin 0.0234 rather than 1.416. So claim 3's *headline* is right by luck; its *evidence*, its *number* and its *point* are not.
