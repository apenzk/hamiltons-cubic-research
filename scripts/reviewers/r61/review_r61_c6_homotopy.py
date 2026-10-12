"""Reviewer 61 / C6, the decisive attack.  With (y,z) fixed the question
'is there a Weyl_m tensor whose only negative eigenvalues sit on span{y,z}?'
is an SDP, so it is exact.  Start from a FEASIBLE (y,z) -- the padded m=8
witness inside R^m, dim U = 8 -- and hill-climb on (y,z) to raise
lam_min(im y + im z) (i.e. push dim U up to m) while the SDP margin stays >= 0."""
import numpy as np, sys, time
from review_r61_core import vec_to_skew, skew_to_vec, weyl_basis
from review_r61_c5 import W4, dimU
from review_r61_c6_sdp import margin


def support(y, z, m):
    X = vec_to_skew(y, m); Y = vec_to_skew(z, m)
    S = X @ X.T + Y @ Y.T
    return float(np.linalg.eigvalsh(S)[0])


def orthonormalise(y, z):
    y = y/np.linalg.norm(y)
    z = z - (z @ y)*y
    return y, z/np.linalg.norm(z)


def F(y, z, m, rho=20.0, cache={}):
    t, _, _ = margin(m, y, z)
    return support(y, z, m) + rho*min(0.0, t), t


def climb(m, iters, seed, step0=0.25):
    E = np.eye(m)
    W = W4([E[0], E[1], E[2], E[3]], m, (-2, 1, 1)) + \
        W4([E[4], E[5], E[6], E[7]], m, (-2, 1, 1))
    W /= np.linalg.norm(W)
    lam, V = np.linalg.eigh(W)
    y, z = orthonormalise(V[:, 0].copy(), V[:, 1].copy())
    D = y.size
    rng = np.random.default_rng(seed)
    f, t = F(y, z, m)
    print(f"  start m={m}: lam_min(S)={support(y,z,m):.4e} t={t:+.2e} F={f:.4f}")
    sys.stdout.flush()
    step = step0
    t0 = time.time()
    for k in range(iters):
        yy = y + step*rng.normal(size=D)
        zz = z + step*rng.normal(size=D)
        yy, zz = orthonormalise(yy, zz)
        fn, tn = F(yy, zz, m)
        if fn > f:
            y, z, f, t = yy, zz, fn, tn
            step = min(step*1.3, 0.5)
        else:
            step = max(step*0.93, 5e-4)
        if k % 25 == 0:
            print(f"   it {k:4d}: F={f:.5f} lam_min(S)={support(y,z,m):.4e} t={t:+.2e}"
                  f" step={step:.4f} [{time.time()-t0:.0f}s]")
            sys.stdout.flush()
    return y, z, f, t


if __name__ == '__main__':
    for m, iters in [(10, 500), (12, 200)]:
        print(f"=== m={m} ===")
        y, z, f, t = climb(m, iters, seed=77+m)
        lm = support(y, z, m)
        # rank of the pair
        X = vec_to_skew(y, m); Y = vec_to_skew(z, m)
        r = np.linalg.matrix_rank(np.hstack([X, Y]), tol=1e-7)
        print(f"  RESULT m={m}: best lam_min(S)={lm:.4e} (ceiling {4.0/m:.4f})"
              f"  SDP margin t={t:+.3e}  dim(im y + im z)={r}")
        sys.stdout.flush()
