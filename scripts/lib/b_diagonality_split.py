"""Coordinate-diagonality of the known S = 0 critical points, measured correctly.

The crux splits { S = 0 } by whether a point is coordinate-diagonal, since the
diagonal case is granted.  Two things must be right for that split to mean
anything, and an earlier version of this table got both wrong:

  * THE STATISTIC.  "Off-diagonal mass" is the Frobenius norm of the off-diagonal
    part, not the largest single entry.  The earlier figures 0.197 / 0.158 / 0.408
    were max-entry; the masses are 0.837 / 0.866 / 0.707.  The two even disagree on
    ordering -- CP^5 looks LESS non-diagonal than CP^4 by max-entry and MORE by
    mass.  (0.408 = 1/sqrt(6), and FINDINGS quotes both it and 1/sqrt(2) for the
    same point in different places.)

  * THE FRAME.  Diagonal in the constructor's frame is not the question; the
    question is whether SOME orthonormal frame diagonalises it.  So the statistic
    must be minimised over O(n), with a positive control -- a randomly rotated
    S^3 x S^3 must be driven back to 0.

The yes/no column survives both corrections, and is certified rigorously rather
than numerically: a point is non-diagonalisable if some eigenspace of W contains no
decomposable bivector, i.e. min ||omega ^ omega|| > 0 over that eigenspace (the
Plucker obstruction).  For CP^4, CP^5 and padded W_CP2 that minimum is 0.61, 0.63
and 0.50.

LIMIT OF THE MINIMISER HERE.  The descent below reproduces the frame masses the
audits report (0.8367 for CP^4, 0.7071 for padded W_CP2) but its positive control
only reaches 1.3e-2 from 0.965, where the reviewers' minimisers reach 9.5e-6 and
0.000000.  So it shows the direction and must NOT be read as certifying
frame-minimality; the Plucker argument above is what does that.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, adj, Q, sphere_product_W
from b_cpm_closed_form import W_cpm
from b_cp2_nondegenerate import padded_cp2
from b_c5_blowup import c5_operator
from b_padded_s3s3 import slack

def off_diagonal_mass(W):
    """Frobenius norm of the off-diagonal part, in the given frame."""
    return float(np.linalg.norm(W - np.diag(np.diag(W))))

def rotate(W, n, R):
    """Act on Lambda^2 by R in O(n)."""
    pairs, idx = pair_index(n); N = len(pairs)
    L = np.zeros((N, N))
    for b, (k, l) in enumerate(pairs):
        for a, (i, j) in enumerate(pairs):
            L[a, b] = R[i, k] * R[j, l] - R[i, l] * R[j, k]
    return L @ W @ L.T

def min_off_diagonal_mass(W, n, tries=40, iters=300, seed=0):
    """Minimise the off-diagonal mass over O(n) by gradient-free descent.

    Needs a positive control: a rotated diagonal point must come back to 0.
    """
    rng = np.random.default_rng(seed)
    best = off_diagonal_mass(W)
    for _ in range(tries):
        A = rng.normal(size=(n, n)); A = A - A.T
        R = np.linalg.qr(np.eye(n) + 0.3 * A)[0]
        cur = rotate(W, n, R); c = off_diagonal_mass(cur); step = 0.3
        for _ in range(iters):
            A = rng.normal(size=(n, n)); A = A - A.T
            R2 = np.linalg.qr(np.eye(n) + step * A)[0]
            trial = rotate(cur, n, R2); t = off_diagonal_mass(trial)
            if t < c: cur, c = trial, t
            else: step *= 0.97
        best = min(best, c)
    return best

if __name__ == "__main__":
    print("positive control: a randomly rotated diagonal point must return to 0")
    W, _ = sphere_product_W((3, 3)); W /= np.linalg.norm(W)
    rng = np.random.default_rng(1)
    A = rng.normal(size=(6, 6)); A = A - A.T
    R = np.linalg.qr(np.eye(6) + 0.8 * A)[0]
    Wr = rotate(W, 6, R)
    print(f"   rotated S^3xS^3: mass {off_diagonal_mass(Wr):.4f} -> "
          f"{min_off_diagonal_mass(Wr, 6, tries=8, iters=200):.2e}", flush=True)
    print()
    print(f"{'point':>20} {'n':>3} {'max entry':>10} {'mass':>9} {'diagonal?':>10}")
    rows = [("S^3xS^3", 6, sphere_product_W((3, 3))[0]),
            ("C_5 blow-up", 10, c5_operator([2] * 5)[0]),
            ("CP^4", 8, W_cpm(4)[0]),
            ("W_CP2 padded", 8, padded_cp2(8)[0])]
    for label, n, Wx in rows:
        Wx = Wx / np.linalg.norm(Wx)
        me = float(np.abs(Wx - np.diag(np.diag(Wx))).max())
        m = off_diagonal_mass(Wx)
        print(f"{label:>20} {n:3d} {me:10.4f} {m:9.4f} {'yes' if m < 1e-12 else 'no':>10}",
              flush=True)
