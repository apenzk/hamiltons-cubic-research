"""Reviewer 44 -- does a branch of critical points actually leave the padded point?

Second order:  Phi(v) = Pi_K Q(v),  K = E(theta_0) of L = 2 L_{W_0}.
Third order (scalar part, free of the undetermined second-order constant):
    Psi_1(v) = <Q(v), G Q(v)>,  G = (L - theta_0)^+ on K^perp.
Derived here from scratch; see the report for the derivation.
"""
import numpy as np, sys, time
from scipy.optimize import minimize
sys.path.insert(0, 'scripts/lib')
from review_r44_core import *
from review_r44_padded import Le_matrix

def log(m):
    print(m, flush=True)
    with open('agent_logs/review_r44_padded.log', 'a') as f:
        f.write(m + '\n')

def setup(n, W6, n0=6):
    W = embed(W6, n0, n) if n > n0 else W6.copy()
    W = W / np.linalg.norm(W)
    B = weyl_basis(n)
    th = float(np.tensordot(W, Qop(W, n)))
    M = Le_matrix(W / th, n, B)
    ev, U = np.linalg.eigh(M)
    sel = np.abs(ev - 0.5) < 1e-8
    Kb = U[:, sel]                                  # B-coords of K
    Ob, _ = orbit_tangent_basis(W, n)               # p-coords
    ObB = B.T @ Ob                                  # B-coords (orbit lies in Weyl)
    ObB, _ = np.linalg.qr(ObB)
    Pk = Kb @ Kb.T; Po = ObB @ ObB.T
    et, Ut = np.linalg.eigh(Pk - Po)
    Tb = Ut[:, et > 0.5]                            # B-coords of transverse kernel
    # G = (L - theta_0)^+ ,  L = 2 theta_0 M
    lam = th * (2 * ev - 1.0)
    inv = np.where(np.abs(lam) > 1e-8, 1.0 / np.where(np.abs(lam) > 1e-8, lam, 1.0), 0.0)
    G = (U * inv) @ U.T
    return W, B, th, M, Kb, ObB, Tb, G, ev

def make_funcs(n, B, Kb, G, th):
    def Qc(c):                                       # c = B-coords -> Q, in B-coords
        X = p_to_X(B @ c, n)
        return B.T @ X_to_p(Qop(X, n), n)
    def Phi(c):
        return Kb.T @ Qc(c)
    def Psi1(c):
        q = Qc(c)
        return float(q @ (G @ q))
    return Qc, Phi, Psi1

def run(n, W6, nstart=400, seed=1):
    W, B, th, M, Kb, ObB, Tb, G, ev = setup(n, W6)
    Qc, Phi, Psi1 = make_funcs(n, B, Kb, G, th)
    d = Tb.shape[1]
    rng = np.random.default_rng(seed)
    # sanity: Q preserves Weyl_n
    c0 = rng.standard_normal(B.shape[1])
    X = p_to_X(B @ c0, n); QX = Qop(X, n)
    off = np.linalg.norm(X_to_p(QX, n) - B @ (B.T @ X_to_p(QX, n)))
    # sanity: orbit directions give Phi = 0
    orbvals = [np.linalg.norm(Phi(ObB[:, j])) for j in range(min(ObB.shape[1], 6))]
    log(f'[branch n={n}] dimT={d} theta={th:.9f}  Q leaves Weyl by {off:.2e}  '
        f'|Phi| on orbit dirs <= {max(orbvals):.2e}')
    basisvals = [np.linalg.norm(Phi(Tb[:, j])) for j in range(d)]
    log(f'   |Phi| on the {d} transverse basis vectors: min={min(basisvals):.4f} max={max(basisvals):.4f}')
    def f(x):
        c = Tb @ (x / np.linalg.norm(x))
        return float(np.sum(Phi(c) ** 2))
    best = []
    for s in range(nstart):
        x0 = rng.standard_normal(d)
        r = minimize(f, x0, method='Nelder-Mead',
                     options=dict(maxiter=4000, xatol=1e-12, fatol=1e-18))
        best.append((r.fun, r.x / np.linalg.norm(r.x)))
    best.sort(key=lambda t: t[0])
    zeros = [x for val, x in best if val < 1e-16]
    log(f'   global min |Phi|^2 over unit sphere of T: {best[0][0]:.3e} ; '
        f'{len(zeros)}/{nstart} starts reached < 1e-16')
    if zeros:
        Z = np.array(zeros)
        s = np.linalg.svd(Z, compute_uv=False)
        rank = int((s > 1e-6 * s[0]).sum())
        psis = [Psi1(Tb @ z) for z in zeros[:200]]
        log(f'   zero set spans a cone of linear span dim {rank} inside T (dim {d})')
        log(f'   Psi_1 on the zero cone: min={min(psis):.9f} max={max(psis):.9f} '
            f'spread={max(psis)-min(psis):.2e}')
        po = [Psi1(ObB[:, j]) for j in range(min(6, ObB.shape[1]))]
        log(f'   Psi_1 on orbit directions: max |.| = {max(abs(x) for x in po):.2e}')
    return dict(n=n, Tb=Tb, B=B, Kb=Kb, G=G, th=th, zeros=zeros if zeros else [], W=W)

if __name__ == '__main__':
    W6 = sphere_product_W((3, 3))
    ns = [int(x) for x in sys.argv[1:]] or [6, 8]
    for n in ns:
        t0 = time.time()
        run(n, W6, nstart=int(200 if n <= 6 else 120))
        log(f'   [{time.time()-t0:.0f}s]')
