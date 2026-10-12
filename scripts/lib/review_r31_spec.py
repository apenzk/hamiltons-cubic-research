"""Reviewer 31: spectrum of L_e, dim E(1/2), and orbit-tangent principal angles."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import numpy as np, sys, time
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r31_core import *


def sym_basis(N):
    """orthonormal (Frobenius) basis of symmetric N x N matrices."""
    out = []
    for c in range(N):
        for d in range(c, N):
            E = np.zeros((N, N))
            if c == d:
                E[c, c] = 1.0
            else:
                E[c, d] = E[d, c] = 1 / np.sqrt(2)
            out.append(E)
    return out


def build_L(alg, e, project=True):
    N = alg.N
    B = sym_basis(N)
    D = len(B)
    M = np.zeros((D, D))
    Bf = np.array([b.ravel() for b in B])          # D x N^2
    for t, X in enumerate(B):
        Y = alg.circ(e, alg.PW(X) if project else X)
        if project:
            Y = alg.PW(Y)
        M[:, t] = Bf @ Y.ravel()
    return 0.5 * (M + M.T), D


def orbit_tangent(alg, W, gens):
    """gens: list of so(n) matrices. returns basis matrix (columns) in vec(N^2) coords."""
    cols = []
    for A in gens:
        Mx = ad_matrix(alg, A)
        T = Mx @ W - W @ Mx
        cols.append(T.ravel())
    return np.array(cols).T


def mixed_gens(n, p):
    G = []
    for i in range(p):
        for j in range(p, n):
            A = np.zeros((n, n)); A[i, j] = 1.0; A[j, i] = -1.0
            G.append(A)
    return G


def all_gens(n):
    G = []
    for i in range(n):
        for j in range(i + 1, n):
            A = np.zeros((n, n)); A[i, j] = 1.0; A[j, i] = -1.0
            G.append(A)
    return G


def report(p, q, tol=1e-8):
    n = p + q
    alg = Alg(n)
    W = sphere_product_W(alg, p, q)
    W = W / np.sqrt(np.sum(W * W))
    th = float(np.sum(alg.Q(W) * W))
    e = W / th
    t0 = time.time()
    M, D = build_L(alg, e)
    ev = np.linalg.eigvalsh(M)
    build = time.time() - t0
    wd = weyl_dim(n)
    # cluster eigenvalues
    clusters = []
    for v in ev:
        if clusters and abs(v - clusters[-1][0]) < 1e-7:
            clusters[-1][1] += 1
            clusters[-1][0] = (clusters[-1][0] * (clusters[-1][1] - 1) + v) / clusters[-1][1]
        else:
            clusters.append([v, 1])
    # remove the ambient-complement zeros
    out = []
    for v, m in clusters:
        if abs(v) < 1e-7:
            m -= (D - wd)
        if m > 0:
            out.append((v, m))
    # E(1/2)
    half = np.where(np.abs(ev - 0.5) < tol)[0]
    others = np.sort(np.abs(ev[np.abs(ev - 0.5) >= tol] - 0.5))
    gap = others[0] if len(others) else float('nan')
    # orbit
    Tm = orbit_tangent(alg, W, mixed_gens(n, p))
    Ta = orbit_tangent(alg, W, all_gens(n))
    sm = np.linalg.svd(Tm, compute_uv=False)
    sa = np.linalg.svd(Ta, compute_uv=False)
    dim_orb_mixed = int((sm > 1e-9 * sm[0]).sum())
    dim_orb_all = int((sa > 1e-9 * sa[0]).sum())
    # principal angles between E(1/2) and orbit tangent
    evals, evecs = np.linalg.eigh(M)
    idx = np.where(np.abs(evals - 0.5) < tol)[0]
    Bs = sym_basis(alg.N)
    Bf = np.array([b.ravel() for b in Bs]).T        # N^2 x D
    Ehalf = Bf @ evecs[:, idx]                      # N^2 x k
    def onb(Mx, r=None):
        U, s_, _ = np.linalg.svd(Mx, full_matrices=False)
        if r is None:
            r = int((s_ > 1e-9 * s_[0]).sum())
        return U[:, :r]
    Uh = onb(Ehalf) if Ehalf.shape[1] else Ehalf
    Ua = onb(Ta, dim_orb_all)
    cos = np.linalg.svd(Uh.T @ Ua, compute_uv=False) if Uh.shape[1] and Ua.shape[1] else np.array([])
    return dict(p=p, q=q, n=n, theta=th, dimhalf=len(half), orb_mixed=dim_orb_mixed,
                orb_all=dim_orb_all, gap=gap, spec=out, cos=cos, build=build,
                weyl_dim=wd, ambient=D)


if __name__ == '__main__':
    import json
    for arg in sys.argv[1:]:
        p, q = map(int, arg.split(','))
        r = report(p, q)
        print(f"=== S^{p} x S^{q}  n={r['n']}  theta={r['theta']:.10f}  dimWeyl={r['weyl_dim']}  ({r['build']:.1f}s)")
        print(f"    dim E(1/2) = {r['dimhalf']}   pq = {p*q}   orbit(mixed) = {r['orb_mixed']}   orbit(all so(n)) = {r['orb_all']}")
        print(f"    gap from 1/2 to nearest other eigenvalue = {r['gap']:.6e}")
        print(f"    principal cosines E(1/2) vs orbit: min={r['cos'].min():.10f} max={r['cos'].max():.10f}  (k={len(r['cos'])})")
        print("    spectrum:", "  ".join(f"{v:+.8f}^{m}" for v, m in r['spec']))
        sys.stdout.flush()
