"""Reviewer 61 / C6: direct search over the whole of Weyl_m for an element with
at most TWO negative eigenvalues whose two most negative eigenvectors have
images spanning R^m (dim U = m).  Objective: push lambda_min(X_N X_N^T +
X_{N-1} X_{N-1}^T) up while keeping every eigenvalue past the second one >= 0."""
import numpy as np, sys, time
from scipy.optimize import minimize
from review_r61_core import weyl_basis, vec_to_skew, theta, ricci_defect, bianchi_defect
from review_r61_c5 import dimU


def unpack(a, B):
    W = np.einsum('k,kij->ij', a, B)
    n = np.linalg.norm(W)
    return W / (n + 1e-300), n


def score(a, B, m, mu=200.0):
    W, n = unpack(a, B)
    if n < 1e-10:
        return 10.0
    lam, V = np.linalg.eigh(W)
    pen = float(np.sum(np.minimum(lam[2:], 0.0) ** 2))
    X0 = vec_to_skew(V[:, 0], m); X1 = vec_to_skew(V[:, 1], m)
    S = X0 @ X0.T + X1 @ X1.T
    lmin = float(np.linalg.eigvalsh(S)[0])
    return -lmin + mu * pen


def run(m, starts, seed, maxiter=400):
    B = weyl_basis(m)
    rng = np.random.default_rng(seed)
    best = None
    t0 = time.time()
    for s in range(starts):
        a0 = rng.normal(size=B.shape[0])
        a0 /= np.linalg.norm(a0)
        r = minimize(score, a0, args=(B, m), method='L-BFGS-B',
                     options={'maxiter': maxiter, 'maxfun': 200000})
        W, _ = unpack(r.x, B)
        lam, V = np.linalg.eigh(W)
        nneg = int((lam < -1e-8).sum())
        X0 = vec_to_skew(V[:, 0], m); X1 = vec_to_skew(V[:, 1], m)
        lmin = float(np.linalg.eigvalsh(X0 @ X0.T + X1 @ X1.T)[0])
        pen = float(np.sum(np.minimum(lam[2:], 0.0) ** 2))
        du, _ = dimU(W)
        cand = (nneg <= 2, lmin, du, pen, theta(W, m), W.copy())
        if best is None or (cand[0], cand[1]) > (best[0], best[1]):
            best = cand
        print(f"   m={m} start {s}: neg={nneg} lam_min(S)={lmin:.3e} pen={pen:.2e} "
              f"dimU={du} theta={cand[4]:+.4f}  [{time.time()-t0:.0f}s]")
        sys.stdout.flush()
    return best


if __name__ == '__main__':
    for m, st in [(6, 6), (8, 6), (10, 5), (12, 4)]:
        print(f"=== m={m} (dim Weyl = {weyl_basis(m).shape[0]}) ===")
        b = run(m, st, seed=900 + m)
        ok, lmin, du, pen, th, W = b
        print(f"  BEST m={m}: <=2 neg? {ok}  lambda_min(S)={lmin:.4e}  dimU={du}"
              f"  pen={pen:.2e}  theta={th:+.6f}"
              f"  ricci={ricci_defect(W,m):.1e} bianchi={bianchi_defect(W,m):.1e}")
        sys.stdout.flush()
