"""A degenerate S = 0 critical point at every even n: S^3 x S^3, padded.

This refutes the clean form of the compactness mechanism.  Route B wants { S = 0 }
to be a union of connected components of Crit(P), which needs it OPEN, which needs
every S = 0 critical point to be Morse-Bott nondegenerate.  It is not:

    n     theta        theta_0(n)   slack S     orbit   dim E(1/2)
    6     1.054092553  1.054092553  3.5e-29      9         18
    8     1.054092553  1.145643924  2.2e-28     21         30
    10    1.054092553  1.200000000  9.7e-29     33         42
    12    1.054092553  1.236033081  2.6e-28     45         54

The n = 6 degeneracy of S^3 x S^3 was already on record as the sole exception to
Lemma 27.  What is recorded here is that it SURVIVES PADDING: the operator stays
critical (residual ~1e-15), keeps theta = 1.054092553 exactly, keeps S = 0, and
stays degenerate with dim E(1/2) exceeding the orbit by exactly 9 at every n.

CORRECTED AFTER GATE 2 (Reviewers 44 and 45, agreeing).  Two things this file
originally got wrong:

  * "therefore { S = 0 } is not open" is a NON-SEQUITUR.  Degeneracy removes the
    sufficient condition for isolation; it does not produce a nearby S > 0 critical
    point.  Here the orbit is isolated at third order -- Psi_1 = -0.592927061, the
    same nonzero constant at n = 6, 8, 10 -- and correctors from 48 and 262
    transverse starts all return, S <= 2.4e-23.  { S = 0 } is OPEN here.
  * This point is NOT new.  FINDINGS already records "every graded critical point
    is nondegenerate" as false, proven over Q, and its su(4) Kahler row at n = 8,
    theta = 1.054093, excess 9, IS this point (same W- and L_e-spectra, different
    orbit).  The record's highest degenerate S = 0 value is sqrt(6/5) = 1.095445,
    not sqrt(10)/3.

What IS new and general: Q commutes with padding exactly (0.0), since
[Lambda^2 R^n0, Lambda^2 R^n0] is closed, so EVERY critical point pads to a
critical point with the same theta and S.  S is exactly 0; the 1e-28 below is an
artefact of building m from numerical eigenvectors.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import (pair_index, weyl_basis, Q, adj, sphere_product_W,
                             orbit_tangent, orthonormalize)

def padded(Wsmall, nsmall, n):
    ps, _ = pair_index(nsmall); pairs, idx = pair_index(n); N = len(pairs)
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(ps):
        for b, (k, l) in enumerate(ps):
            W[idx[(i, j)], idx[(k, l)]] = Wsmall[a, b]
    B = weyl_basis(n)
    W = sum(float(np.tensordot(bb, W)) * bb for bb in B)
    return W / np.linalg.norm(W), B

def slack(n, W, A, N):
    w, V = np.linalg.eigh(W); neg = V[:, w < -1e-9]; Pm = neg @ neg.T
    k = neg.shape[1]; tot = 0.0
    for i in range(k):
        Xi = sum(neg[c, i] * A[c] for c in range(N))
        for j in range(i + 1, k):
            Xj = sum(neg[c, j] * A[c] for c in range(N))
            C = Xi @ Xj - Xj @ Xi
            v = np.array([np.trace(C @ A[c].T) for c in range(N)]) / 2
            tot += float(v @ Pm @ v)
    return tot

def check(n):
    pairs, idx = pair_index(n); N = len(pairs); A = adj(n)
    W6, _ = sphere_product_W((3, 3))
    W, B = padded(W6, 6, n); D = len(B)
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
    return th, res, slack(n, W, A, N), orb, dimE

if __name__ == "__main__":
    print(f"{'n':>3} {'theta':>12} {'theta_0':>12} {'resid':>9} {'slack':>10} "
          f"{'orbit':>6} {'dimE(1/2)':>10} {'nondeg':>7}")
    for n in (6, 8, 10, 12):
        th, res, S, orb, dimE = check(n)
        th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
        print(f"{n:3d} {th:12.9f} {th0:12.9f} {res:9.1e} {S:10.1e} {orb:6d} "
              f"{dimE:10d} {str(dimE == orb):>7}", flush=True)
