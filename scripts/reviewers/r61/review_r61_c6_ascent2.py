"""Reviewer 61 / C6 clause 3, cleaned up.  Same Frank-Wolfe ascent inside the
exact convex description of the two-negative stratum, but reporting the THIRD
smallest eigenvalue explicitly (SCS residuals make a raw negative-count
meaningless) and saving the best iterate for independent re-screening."""
import numpy as np, cvxpy as cp, sys
from review_r61_core import weyl_basis, Q, theta, vec_to_skew, ricci_defect, bianchi_defect
from review_r61_c5 import W4, dimU
from review_r61_c6_ascent import step, support


def diag(W, m, label):
    lam = np.linalg.eigvalsh(W)
    du, _ = dimU(W)
    print(f"  {label}: theta={theta(W,m):+.6f} lam1={lam[0]:+.6f} lam2={lam[1]:+.6f}"
          f" lam3={lam[2]:+.3e} dimU={du} lam_min(S)={support(W,m):.3e}"
          f" ricci={ricci_defect(W,m):.1e}")
    sys.stdout.flush()
    return lam


def ascend(m, W0, B, iters=40):
    W = W0/np.linalg.norm(W0)
    for k in range(iters):
        lam, V = np.linalg.eigh(W)
        Wn = step(m, V[:, 0], V[:, 1], Q(W, m), B)
        if Wn is None:
            break
        Wn /= np.linalg.norm(Wn)
        if theta(Wn, m) <= theta(W, m) + 1e-10:
            W = Wn; break
        W = Wn
    return W


if __name__ == '__main__':
    rng = np.random.default_rng(101)
    print("target for comparison: sqrt(3/2) = 1.2247449")
    for m, nstart in [(6, 14), (8, 8)]:
        B = weyl_basis(m)
        E = np.eye(m)
        best = (-9, None)
        for s in range(nstart):
            cA = rng.normal(size=3); cA -= cA.mean()
            cB = rng.normal(size=3); cB -= cB.mean()
            Qm, _ = np.linalg.qr(rng.normal(size=(m, m)))
            fa = [Qm[:, i] for i in range(4)]
            off = 2 if m == 6 else rng.integers(0, m-3)
            fb = [Qm[:, (off+i) % m] for i in range(4)]
            W0 = W4(fa, m, cA) + W4(fb, m, cB)
            if np.linalg.norm(W0) < 1e-6:
                continue
            W = ascend(m, W0, B)
            lam = diag(W, m, f"m={m} start{s}")
            th = theta(W, m)
            # accept only if the third eigenvalue is not meaningfully negative
            if lam[2] > -1e-5 and th > best[0]:
                best = (th, W.copy(), lam)
        if best[1] is not None:
            print(f"  ==> m={m}: best theta with lam3 >= -1e-5 is {best[0]:+.6f}"
                  f" (dim U = {dimU(best[1])[0]})")
            np.save(f"scripts/data/review_r61_best_stratum_m{m}.npy", best[1])
        print()
