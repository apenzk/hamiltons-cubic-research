"""r268 claim 6 -- r266's scale-sensitivity finding, recurring verbatim in the
NEW primary script.

r266 (commit 6c5cd5d) found that run_restitution_kernel.py used a BARE ABSOLUTE
`tol=1e-8` in np.linalg.matrix_rank, so rescaling identical mathematics changed
the reported rank.  run_cubes_span.py, written one cycle later, uses a bare
absolute `tol=1e-9` on rows whose entries are DEGREE-3 MONOMIALS in the sampled
vector -- so the row scale is the cube of the sample scale, and the same defect
is back, amplified.

Here: the script's own cube_rank, with the samples rescaled by a constant.  The
mathematics is unchanged (rank is scale-invariant); the reported rank is not.
"""
import numpy as np
from itertools import combinations_with_replacement as cwr
from math import comb

def cube_rank_scaled(dim_U, samples, s, seed=0):
    """run_cubes_span.py's cube_rank, with the sampled u scaled by s."""
    rng = np.random.default_rng(seed)
    mons = list(cwr(range(dim_U), 3))
    rows = []
    for _ in range(samples):
        u = s * rng.standard_normal(dim_U)
        rows.append([np.prod(u[list(m)]) for m in mons])
    return np.linalg.matrix_rank(np.array(rows), tol=1e-9), len(mons)

print("  run_cubes_span.py's cube_rank under a pure rescaling of the samples")
print("  (rank is scale-invariant mathematics; tol=1e-9 is absolute)\n")
print(f"    {'dim U':>6} {'scale':>8} {'reported rank':>14} {'dim Sym^3':>10} {'assert':>8}")
for d in (4, 6, 8):
    want = comb(d + 2, 3)
    for s in (1.0, 1e-2, 1e-3, 1e-4):
        got, _ = cube_rank_scaled(d, 3 * want + 25, s)
        print(f"    {d:>6} {s:>8.0e} {got:>14} {want:>10} "
              f"{'holds' if got == want else 'FAILS':>8}")
    print()
print("  The same rescaling applied to the DEGREE-4 loop is worse still, the rows")
print("  being quartic in the sample:\n")
print(f"    {'dim U':>6} {'deg':>4} {'scale':>8} {'reported rank':>14} {'dim Sym^d':>10}")
for d_U in (4, 5):
    for deg in (2, 4):
        for s in (1.0, 1e-3):
            mons = list(cwr(range(d_U), deg))
            want = comb(d_U + deg - 1, deg)
            rng = np.random.default_rng(1)
            rows = [[np.prod(u[list(m)]) for m in mons]
                    for u in s * rng.standard_normal((3 * want + 25, d_U))]
            got = np.linalg.matrix_rank(np.array(rows), tol=1e-9)
            print(f"    {d_U:>6} {deg:>4} {s:>8.0e} {got:>14} {want:>10}")
print("\n  The repair is one character-class: a RELATIVE tolerance (numpy's default,")
print("  or rows normalised first).  r268's own c1 needs no tolerance at all --")
print("  the statement is an identity in exact arithmetic.")
