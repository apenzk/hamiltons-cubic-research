"""W_{CP^2} is nondegenerate, which the compactness mechanism needs.

Route B closes if { S = 0 } is a union of connected components of Crit(P): a
nondegenerate orbit is open in Crit(P), S = 0 is a closed condition, so if every
S = 0 critical point is nondegenerate the set is a union of components and
S >= c > 0 on the remainder by compactness.

The subtlety is that { S = 0 } is LARGER than the graded set -- W_{CP^2} has S = 0
without being Z_2-graded (Reviewers 30 and 31) -- so the hypothesis has to hold for
it too, not only for the graded classification covered by Lemmas 27 and 28.  It does:
dim E(1/2) = dim orbit at n = 8, 10, 12, with theta = sqrt(3/2) exactly and
independent of n.  Since sqrt(3/2) < theta_0(n) for n >= 12, it is harmless there.

CONSTRUCTION NOTE.  Build it as the m = 2 member of the CP^m closed form and pad --
that IS Nienhaus's W_{CP^2}.  Hand-rolling a self-dual operator on Lambda^2(R^4)
instead gives something with criticality residual 0.7 and theta nowhere near
sqrt(3/2); it is not a critical point at all.
"""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from b_cpm_closed_form import W_cpm
from review_r30_core import (pair_index, adj, weyl_basis, Q,
                             orbit_tangent, orthonormalize)

def padded_cp2(n):
    """W_{CP^2} inside Weyl_n, from the m=2 member of the CP^m family."""
    W4, pairs4, idx4 = W_cpm(2)
    pairs, idx = pair_index(n); N = len(pairs)
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(pairs4):
        for b, (k, l) in enumerate(pairs4):
            W[idx[(i, j)], idx[(k, l)]] = W4[a, b]
    B = weyl_basis(n)
    W = sum(float(np.tensordot(bb, W)) * bb for bb in B)
    return W / np.linalg.norm(W), B

def check(n):
    pairs, idx = pair_index(n); N = len(pairs); A = adj(n)
    W, B = padded_cp2(n); D = len(B)
    th = float(np.tensordot(W, Q(n, W)))
    res = float(np.linalg.norm(Q(n, W) - th * W))
    e = W / th; A2 = A.reshape(N * N, N)
    Ae = (A2 @ e).reshape(N, N, N); AeT = Ae.transpose(0, 2, 1).reshape(N, N * N)
    M = np.zeros((D, D))
    for j, X in enumerate(B):
        AX = (A2 @ X).reshape(N, N, N); T = AX.reshape(N, N * N) @ AeT.T
        M[:, j] = [np.tensordot(b, 0.5 * (e @ X + X @ e) - 0.25 * (T + T.T)) for b in B]
    w = np.linalg.eigvalsh(0.5 * (M + M.T))
    dimE = int((np.abs(w - 0.5) < 1e-8).sum())
    orb = orthonormalize(orbit_tangent(n, W)).shape[0]
    return th, res, orb, dimE

if __name__ == "__main__":
    print(f"{'n':>3} {'theta':>12} {'crit resid':>11} {'orbit':>6} {'dimE(1/2)':>10} {'nondeg':>7}")
    for n in (8, 10, 12):
        th, res, orb, dimE = check(n)
        print(f"{n:3d} {th:12.9f} {res:11.1e} {orb:6d} {dimE:10d} {str(dimE == orb):>7}", flush=True)
