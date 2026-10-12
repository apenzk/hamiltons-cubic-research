"""Reviewer 61 / C4: convex feasibility sweep.  For x with a prescribed
multiplicity pattern of singular values (nondegenerate) and for degenerate
controls, decide whether some W in Weyl_m has exactly one eigenvalue of one
sign, sitting on x.  Convex, hence decisive for each x."""
import numpy as np, cvxpy as cp, itertools, sys
from review_r61_core import weyl_basis, skew_to_vec
from review_r61_c2_c3 import partitions


def margin_one(m, y, sign=+1):
    """sign=+1: y is the unique NEGATIVE direction (G = W + yy^T >= 0).
       sign=-1: y is the unique POSITIVE direction (-W + yy^T >= 0)."""
    B = weyl_basis(m); D = B.shape[1]
    a = cp.Variable(B.shape[0]); t = cp.Variable()
    W = cp.reshape(cp.matmul(a, B.reshape(B.shape[0], -1)), (D, D), order='C')
    G = sign*W + np.outer(y, y)
    Pi = np.eye(D) - np.outer(y, y)
    prob = cp.Problem(cp.Maximize(t), [G - t*Pi >> 0, G @ y == 0])
    prob.solve(solver='SCS', eps=1e-8, max_iters=40000)
    return prob.value


def xvec(m, mults, alphas, rng=None):
    X = np.zeros((m, m)); k = 0
    for mu, a in zip(mults, alphas):
        for _ in range(mu):
            X[k, k+1] = a; X[k+1, k] = -a; k += 2
    if rng is not None:
        Qm, _ = np.linalg.qr(rng.normal(size=(m, m)))
        X = Qm @ X @ Qm.T
    v = skew_to_vec(X, m)
    return v/np.linalg.norm(v)


if __name__ == '__main__':
    rng = np.random.default_rng(17)
    print("=== control: DEGENERATE y (rank 4 padded complex structure) should be FEASIBLE ===")
    for m in (6, 8, 10):
        X = np.zeros((m, m))
        X[0, 1] = X[2, 3] = 1.0; X[1, 0] = X[3, 2] = -1.0
        v = skew_to_vec(X, m); v /= np.linalg.norm(v)
        print(f"  m={m} rank-4 J: t(neg side) = {margin_one(m, v, +1):+.3e}"
              f"   t(pos side) = {margin_one(m, v, -1):+.3e}")

    print("\n=== C4: NONDEGENERATE y, every multiplicity pattern ===")
    for m in (6, 8, 10, 12):
        p = m//2
        for mults in partitions(p):
            al = np.sort(rng.uniform(1.0, 3.0, size=len(mults)))[::-1]
            v = xvec(m, mults, al, rng)
            tn = margin_one(m, v, +1)
            tp = margin_one(m, v, -1)
            flag = "  <-- FEASIBLE" if max(tn, tp) > -1e-4 else ""
            print(f"  m={m:2d} mult={str(mults):14s} alphas={np.round(al,3)}"
                  f"  t_neg={tn:+.3e} t_pos={tp:+.3e}{flag}")
            sys.stdout.flush()
