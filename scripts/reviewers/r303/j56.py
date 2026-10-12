"""J5 and J6: the equivariant/isotype obstruction."""
import sys, os
sys.path.insert(0, os.path.dirname(__file__))
import itertools
import numpy as np
from diagcore import V_basis, theta_of, Lop, L_matrix, defect, crit_residual


def automorphisms(M, tol=1e-9):
    n = len(M)
    perms = []
    # prune by row-multiset signature
    sig = [tuple(np.round(sorted(M[i]), 8)) for i in range(n)]
    cand = [[j for j in range(n) if sig[j] == sig[i]] for i in range(n)]
    part = [0] * n

    def rec(k, used):
        if k == n:
            P = np.array(part)
            if np.abs(M[np.ix_(P, P)] - M).max() < tol:
                perms.append(P.copy())
            return
        for j in cand[k]:
            if j in used:
                continue
            ok = True
            for i in range(k):
                if abs(M[i, k] - M[part[i], j]) > tol:
                    ok = False
                    break
            if ok:
                part[k] = j
                rec(k + 1, used | {j})
    rec(0, set())
    return perms


def analyse_point(M, tag):
    n = len(M)
    B = V_basis(n)
    th = theta_of(M)
    Lm = L_matrix(M, B)
    mv = np.einsum('kij,ij->k', B, M); mv /= np.linalg.norm(mv)
    Qb, _ = np.linalg.qr(np.hstack([mv[:, None], np.eye(len(B))]))
    U = Qb[:, 1:len(B)]                      # orthonormal basis of V ^ M-perp
    Lr = U.T @ Lm @ U
    w, v = np.linalg.eigh(Lr)
    top = w.max()
    dim_top = int(np.sum(w > top - 1e-8))
    perms = automorphisms(M)
    # the Aut action on V ^ M-perp
    def act(P):
        R = np.array([np.einsum('kij,ij->k', B, Bk[np.ix_(P, P)]) for Bk in B]).T
        return U.T @ R @ U
    reps = [act(P) for P in perms]
    # trivial isotype = average projector
    A = sum(reps) / len(reps)
    ww = np.linalg.eigvalsh((A + A.T) / 2)
    dim_triv = int(np.round(np.trace(A)))
    # top eigenspace: invariant as a set?  fixed pointwise?
    Vt = v[:, w > top - 1e-8]
    setinv = max(np.linalg.norm(R @ Vt - Vt @ (Vt.T @ R @ Vt)) for R in reps)
    ptwise = max(np.linalg.norm(R @ Vt - Vt) for R in reps)
    # best Rayleigh over the trivial isotype
    if dim_triv > 0:
        u2, s2, _ = np.linalg.svd(A)
        T = u2[:, s2 > 0.5]
        Rtriv = np.linalg.eigvalsh(T.T @ Lr @ T).max()
    else:
        Rtriv = float('nan')
    print(f"\n=== {tag}: n={n} theta={th:.6f} Delta={defect(M):.4f} "
          f"crit={np.abs(crit_residual(M,B)).max():.1e}")
    print(f"  |Aut(M)| = {len(perms)}   dim V = {len(B)}  dim(V^Mperp) = {len(B)-1}")
    print(f"  lambda_max/theta = {top/th:.6f}   dim top eigenspace = {dim_top}")
    print(f"  top eigenspace: set-invariant residual {setinv:.2e}, pointwise-fixed dev {ptwise:.3f}")
    print(f"  dim trivial isotype in V^Mperp = {dim_triv}   "
          f"max Rayleigh there / theta = {Rtriv/th if dim_triv else float('nan'):.6f}")
    # J5 candidates
    for nm, X in [('M o M', M * M), ('M^2', M @ M), ('M o M o M', M * M * M),
                  ('M^3', M @ M @ M), ('M o M^2', M * (M @ M))]:
        X = X.copy(); np.fill_diagonal(X, 0.0)
        c = np.einsum('kij,ij->k', B, X)
        p = U @ (U.T @ c)                    # project into V ^ M-perp
        nrm = np.linalg.norm(p)
        if nrm < 1e-10:
            print(f"  {nm:10s} -> projects to ZERO ({nrm:.1e})")
        else:
            r = (p @ Lr @ p) / (p @ p) if False else (p @ Lm @ p) / (p @ p)
            print(f"  {nm:10s} -> |proj| {nrm:.4f}, Rayleigh/theta = {r/th:+.6f}")
    return top / th, dim_triv


if __name__ == '__main__':
    from core303 import sphere_product_M
    def C5(n=10):
        def build(a, b, c):
            M = np.zeros((n, n))
            for i in range(n):
                for j in range(n):
                    if i == j: continue
                    bi, bj = i // 2, j // 2
                    if bi == bj: M[i, j] = a
                    else:
                        d = min((bi - bj) % 5, (bj - bi) % 5)
                        M[i, j] = b if d == 1 else c
            return M
        from scipy.optimize import brentq
        Bl = V_basis(n)
        def f(t):
            b, c = np.cos(t), np.sin(t); a = -4 * (b + c)
            M = build(a, b, c); M = M * np.sqrt(2 / np.sum(M * M))
            return crit_residual(M, Bl)[0, 2]
        # bracket around the known root
        ts = np.linspace(-np.pi, np.pi, 20001)
        vals = [f(t) for t in ts]
        for i in range(len(ts) - 1):
            if vals[i] * vals[i + 1] < 0:
                r = brentq(f, ts[i], ts[i + 1])
                b, c = np.cos(r), np.sin(r); a = -4 * (b + c)
                M = build(a, b, c); M = M * np.sqrt(2 / np.sum(M * M))
                if abs(theta_of(M) - 0.670820) < 1e-5:
                    return M
        raise SystemExit('C5 not found')
    analyse_point(sphere_product_M(3, 3), 'S^3 x S^3')
    analyse_point(sphere_product_M(3, 5), 'S^3 x S^5')
    analyse_point(C5(), 'C_5 blow-up')


def sweep(n, ns=80):
    """Is J6's obstruction an artefact of symmetry?  |Aut| vs top-eigenspace dim
    and the best Rayleigh quotient available inside the trivial isotype."""
    from census2 import census
    B = V_basis(n)
    _, tab = census(n, ns)
    print(f"\n### n={n}: |Aut| vs the isotype obstruction")
    print(f"{'theta':>9} {'Delta':>8} {'lmax/th':>8} {'|Aut|':>7} {'dimtop':>6} "
          f"{'dimtriv':>7} {'trivmax/th':>10}")
    for key, (M, a, st) in sorted(tab.items(), key=lambda kv: -kv[1][1]['theta']):
        th = a['theta']
        Lm = L_matrix(M, B)
        mv = np.einsum('kij,ij->k', B, M); mv /= np.linalg.norm(mv)
        Qb, _ = np.linalg.qr(np.hstack([mv[:, None], np.eye(len(B))]))
        U = Qb[:, 1:len(B)]
        Lr = U.T @ Lm @ U
        w = np.linalg.eigvalsh(Lr)
        perms = automorphisms(M)
        def act(P):
            R = np.array([np.einsum('kij,ij->k', B, Bk[np.ix_(P, P)]) for Bk in B]).T
            return U.T @ R @ U
        A = sum(act(P) for P in perms) / len(perms)
        dimtriv = int(np.round(np.trace(A)))
        if dimtriv > 0:
            u2, s2, _ = np.linalg.svd(A)
            T = u2[:, s2 > 0.5]
            tm = np.linalg.eigvalsh(T.T @ Lr @ T).max() / th
        else:
            tm = float('nan')
        print(f"{th:9.6f} {a['Delta']:8.4f} {w.max()/th:8.4f} {len(perms):7d} "
              f"{int(np.sum(w>w.max()-1e-8)):6d} {dimtriv:7d} {tm:10.4f}")
