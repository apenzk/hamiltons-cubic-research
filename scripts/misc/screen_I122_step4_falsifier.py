"""Falsifier screen for I122's step 4 (route R55): a positive definite G on a simple h with
G#G = lambda G is scalar.

Solves G#G = <G#G,G> G on the unit sphere in two parametrisations, G = h h^T (positive
semidefinite, which drifts to subalgebra-supported solutions of lower rank) and G = exp(S) (positive
definite, so every solution has full range), from random starts on h = so(m), m = 5, 6, 7, with the record's # (structure
constants of the e_ij = E_ij - E_ji basis, I#I = (m-2)I). Reports every converged solution by its
smallest eigenvalue (full range means > 0) and its distance from the scalar I/|I|.
A full-range solution far from scalar refutes step 4. Bounded: fixed starts and iterations.
Run: sage -python scripts/misc/screen_I122_step4_falsifier.py   (about a minute)
"""
import itertools
import numpy as np
from scipy.optimize import least_squares

def structure(m):
    P = list(itertools.combinations(range(m), 2)); N = len(P); E = []
    for (i, j) in P:
        X = np.zeros((m, m)); X[i, j] = 1; X[j, i] = -1; E.append(X)
    c = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            C = E[a] @ E[b] - E[b] @ E[a]
            for g in range(N):
                c[a, b, g] = 0.5 * np.sum(C * E[g])
    return c

def sharp(c, G):
    # (G#G)_ab = 1/2 sum c_agd c_bez G_ge G_dz = 1/2 <X_b, G X_a G> with X_a = c[a], G symmetric
    GXG = np.einsum('ge,aed,dz->agz', G, c, G, optimize=True)
    return 0.5 * np.einsum('agz,bgz->ab', GXG, c, optimize=True)

def run(m, starts, iters, rng):
    c = structure(m); N = c.shape[0]; I = np.eye(N)
    assert np.allclose(sharp(c, I), (m - 2) * I)
    def res(x):
        h = x.reshape(N, N); G = h @ h.T; G = G / np.linalg.norm(G)
        S = sharp(c, G); lam = np.sum(S * G)
        return (S - lam * G).ravel()
    out = []
    for _ in range(starts):
        x0 = rng.standard_normal(N * N) + 2.0 * np.eye(N).ravel()
        r = least_squares(res, x0, max_nfev=iters, xtol=1e-14, ftol=1e-14, gtol=1e-14)
        h = r.x.reshape(N, N); G = h @ h.T; G /= np.linalg.norm(G)
        ev = np.linalg.eigvalsh(G); S = sharp(c, G); lam = np.sum(S * G)
        out.append((np.linalg.norm(r.fun), ev[0], np.linalg.norm(G - I / np.sqrt(N)), lam))
    return out

def run_exp(m, scales, starts, iters, rng):
    from scipy.linalg import expm
    c = structure(m); N = c.shape[0]; I = np.eye(N); iu = np.triu_indices(N)
    def G_of(x):
        S = np.zeros((N, N)); S[iu] = x; S = S + S.T - np.diag(np.diag(S))
        G = expm(S); return G / np.linalg.norm(G)
    def res(x):
        # scaled by 1/lambda: rank-one G with a self-commuting eigenvector solve G#G = 0 at lambda = 0
        G = G_of(x); S = sharp(c, G); lam = np.sum(S * G)
        return ((S - lam * G) / max(lam, 1e-12)).ravel()
    out = []
    for sc in scales:
        for _ in range(starts):
            r = least_squares(res, sc * rng.standard_normal(len(iu[0])), max_nfev=iters,
                              xtol=1e-15, ftol=1e-15, gtol=1e-15)
            G = G_of(r.x); ev = np.linalg.eigvalsh(G); lam = np.sum(sharp(c, G) * G)
            out.append((sc, np.linalg.norm(r.fun), ev[0] / ev[-1], np.linalg.norm(G - I / np.sqrt(N)), lam))
    return out

if __name__ == '__main__':
    rng = np.random.default_rng(1220)
    for m in (5, 6, 7):
        rows = run_exp(m, scales=(0.3, 1.0, 3.0), starts=4, iters=300, rng=rng)
        print(f"so({m}), G = exp(S):")
        for r in rows:
            print(f"   start scale {r[0]:.1f}  res {r[1]:.1e}  eig ratio {r[2]:.3e}  |G - scalar| {r[3]:.3e}  lambda {r[4]:.6f}")

if False:
    rng = np.random.default_rng(122)
    for m in (5, 6, 7):
        rows = run(m, starts=12, iters=400, rng=rng)
        conv = [r for r in rows if r[0] < 1e-9]
        full = [r for r in conv if r[1] > 1e-6]
        far = [r for r in full if r[2] > 1e-6]
        print(f"so({m}): {len(conv)}/{len(rows)} converged, {len(full)} full range, "
              f"{len(far)} full range and non-scalar; scalar lambda {(m-2)/np.sqrt(m*(m-1)/2):.6f}")
        for r in sorted(rows, key=lambda r: r[0])[:12]:
            print(f"   res {r[0]:.1e}  min eig {r[1]: .3e}  |G - scalar| {r[2]:.3e}  lambda {r[3]:.6f}")
