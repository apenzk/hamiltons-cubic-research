"""Reviewer 60, C6 part C: does the stratum {n_neg <= 2, dim U = m} contain anything at m=10,12?
Direct penalised search over Weyl_m with analytic gradients, plus theta-maximisation on it."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from scipy.optimize import minimize
from review_r60_core import *
from review_r60_q import theta, Q

rng = np.random.default_rng(6063)


def weyl_frame(m):
    B = weyl_basis(m)
    return np.array([X.ravel() for X in B])          # K x D^2


def mk(m, Bm, c):
    D = m * (m - 1) // 2
    W = (Bm.T @ c).reshape(D, D)
    return W


def feas(m, Bm, c, k=2):
    """penalty: squared sum of the negative parts beyond the k most negative eigenvalues"""
    D = m * (m - 1) // 2
    W = mk(m, Bm, c)
    n = np.linalg.norm(W)
    Wn = W / n
    lam, V = np.linalg.eigh(Wn)
    g = np.zeros(D)
    val = 0.0
    for i in range(k, D):
        if lam[i] < 0:
            val += lam[i]**2
            g[i] = 2 * lam[i]
    G = (V * g) @ V.T
    # d/dW of f(W/|W|)
    Gr = (G - np.sum(G * Wn) * Wn) / n
    return val, Bm @ Gr.ravel()


def negtheta(m, Bm, c):
    D = m * (m - 1) // 2
    W = mk(m, Bm, c); n = np.linalg.norm(W); Wn = W / n
    t = theta(m, Wn)
    # numeric-free gradient: grad of <W,Q(W)> is 3*Q(W) for the cubic (Q homogeneous deg 2, and
    # <W,Q(W)> has gradient 3 Q(W) since Q is the gradient of P/3 -- verified below)
    G = 3.0 * Q(m, Wn)
    Gr = (G - np.sum(G * Wn) * Wn) / n
    return -t, -(Bm @ Gr.ravel())


if __name__ == "__main__":
    # verify grad P = 3 Q(W)
    m0 = 6; B0 = weyl_frame(m0); c0 = rng.standard_normal(B0.shape[0])
    W0 = mk(m0, B0, c0); W0 /= np.linalg.norm(W0)
    P = lambda X: float(np.sum(X * Q(m0, X)))
    e = 1e-6
    for _ in range(2):
        d = rng.standard_normal(B0.shape[0]); Wd = mk(m0, B0, d)
        num = (P(W0 + e*Wd) - P(W0 - e*Wd)) / (2*e)
        ana = float(np.sum(3 * Q(m0, W0) * Wd))
        print(f"grad check: numeric {num:.8f} analytic {ana:.8f}")

    for m in [6, 8, 10, 12]:
        Bm = weyl_frame(m); K = Bm.shape[0]; D = m*(m-1)//2
        print(f"\n=== m={m}: dim Weyl = {K}, dim Lambda^2 = {D}, sqrt(3/2)={np.sqrt(1.5):.6f}, "
              f"theta_0={(m-1)/m*np.sqrt(2*(m-2)/(m-1)):.6f}")
        found = []
        for start in range(40):
            c = rng.standard_normal(K)
            r = minimize(lambda c: feas(m, Bm, c), c, jac=True, method="L-BFGS-B",
                         options=dict(maxiter=4000, ftol=1e-18, gtol=1e-14))
            v = r.fun
            W = mk(m, Bm, r.x); W /= np.linalg.norm(W)
            lam, V = np.linalg.eigh(W)
            nneg = int(np.sum(lam < -1e-7))
            o = np.argsort(lam)
            dimU = np.linalg.matrix_rank(np.hstack([vec_to_mat(m, V[:, a]) for a in o[:2]]), tol=1e-7)
            found.append((v, nneg, dimU, theta(m, W), np.linalg.matrix_rank(vec_to_mat(m, V[:, o[0]]), tol=1e-7)))
        found.sort()
        okf = [f for f in found if f[0] < 1e-14]
        print(f"  feasibility floor over 40 starts: {found[0][0]:.3e};  {len(okf)}/40 reached < 1e-14")
        for f in found[:6]:
            print(f"    resid={f[0]:.3e} n_neg={f[1]} dim U={f[2]} rank(v_N)={f[4]} theta={f[3]:+.6f}")
        # now maximise theta subject to staying feasible (penalty continuation)
        best = (-9, None)
        for start in range(25):
            c = rng.standard_normal(K)
            for mu in [1e2, 1e3, 1e4, 1e5, 1e6, 1e7]:
                def obj(c, mu=mu):
                    t, gt = negtheta(m, Bm, c)
                    v, gv = feas(m, Bm, c)
                    return t + mu*v, gt + mu*gv
                r = minimize(obj, c, jac=True, method="L-BFGS-B",
                             options=dict(maxiter=3000, ftol=1e-18, gtol=1e-14))
                c = r.x
            W = mk(m, Bm, c); W /= np.linalg.norm(W)
            lam, V = np.linalg.eigh(W)
            nneg = int(np.sum(lam < -1e-7)); o = np.argsort(lam)
            dimU = np.linalg.matrix_rank(np.hstack([vec_to_mat(m, V[:, a]) for a in o[:2]]), tol=1e-7)
            th = theta(m, W)
            if nneg <= 2 and th > best[0]:
                best = (th, (nneg, dimU, np.linalg.matrix_rank(vec_to_mat(m, V[:, o[0]]), tol=1e-7)))
        print(f"  MAX theta on the n_neg<=2 stratum (25 starts): {best[0]:+.9f}  "
              f"(n_neg,dimU,rank v_N)={best[1]}")
