"""R52 M3/M4: the three quantities called 'slack', computed independently,
on multi-block sphere products and the subalgebra family."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import sys, time, itertools
import numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
import review_r52_core as K

LOG = _os.path.join(_ROOT, 'agent_logs/review_r52_multiblock.log')
def log(m):
    line = f"[{time.strftime('%H:%M:%S')}] {m}"
    print(line, flush=True)
    open(LOG, 'a').write(line + '\n')


def sphere_multi_vertex(n, parts):
    prs, idx = K.pairs_of(n)
    which = {}; s = 0
    for bi, q in enumerate(parts):
        for i in range(s, s + q): which[i] = bi
        s += q
    lam = np.zeros(len(prs))
    for a, (i, j) in enumerate(prs):
        if which[i] == which[j]:
            na = parts[which[i]]; lam[a] = (n - na) / ((n - 1) * (na - 1))
        else:
            lam[a] = -1.0 / (n - 1)
    return np.diag(lam) / np.linalg.norm(np.diag(lam))


# ---- subalgebra family: W = c (Pi_h - (r/N) Id) ----
def proj_h(n, gens):
    """gens: list of n x n antisymmetric matrices spanning h."""
    V = np.array([K.so_coeffs(n, g) for g in gens])
    u, s, vt = np.linalg.svd(V, full_matrices=False)
    r = int((s > 1e-9 * s[0]).sum())
    B = vt[:r]
    return B.T @ B, r


def casimir_W(n, gens):
    Pi, r = proj_h(n, gens)
    N = Pi.shape[0]
    W = Pi - (r / N) * np.eye(N)
    return W / np.linalg.norm(W), r


def so_block_gens(n, parts):
    gens = []
    s = 0
    for q in parts:
        for i in range(s, s + q):
            for j in range(i + 1, s + q):
                M = np.zeros((n, n)); M[i, j] = 1; M[j, i] = -1
                gens.append(M)
        s += q
    return gens


def su3_ad_gens():
    """ad(su(3)) inside so(8), Killing-orthonormal basis (Gell-Mann/2i)."""
    l = []
    gm = [np.array([[0,1,0],[1,0,0],[0,0,0]], complex),
          np.array([[0,-1j,0],[1j,0,0],[0,0,0]]),
          np.array([[1,0,0],[0,-1,0],[0,0,0]], complex),
          np.array([[0,0,1],[0,0,0],[1,0,0]], complex),
          np.array([[0,0,-1j],[0,0,0],[1j,0,0]]),
          np.array([[0,0,0],[0,0,1],[0,1,0]], complex),
          np.array([[0,0,0],[0,0,-1j],[0,1j,0]]),
          np.array([[1,0,0],[0,1,0],[0,0,-2]], complex)/np.sqrt(3)]
    T = [g / 2.0 for g in gm]          # <T_a,T_b> = 1/2 delta
    f = np.zeros((8, 8, 8))
    for a in range(8):
        for b in range(8):
            C = T[a] @ T[b] - T[b] @ T[a]
            for c in range(8):
                f[a, b, c] = float(np.real(-2j * np.trace(C @ T[c]))) * 1.0
    # ad(T_a)_{bc} = f_{a b c} in this orthonormal basis (antisymmetric)
    return [f[a] for a in range(8)]


def so_ad_gens(k):
    """ad(so(k)) inside so(dim so(k)); phi-basis is orthonormal for <,>."""
    c = K.cstruct(k)
    return [c[a] for a in range(c.shape[0])]


def full(name, n, W, extra=""):
    th = K.P_val(n, W)
    res = np.linalg.norm(K.Q(n, W) - th * W)
    ric = np.abs(K.ricci(n, W)).max()
    Sst = K.slack_structural(n, W)
    Sad = K.slack_repo_adjoint(n, W)
    Sth = K.slack_theta_formula(n, W, th)
    dm = int((np.linalg.eigvalsh(W) < -1e-9).sum())
    log(f"  {name:>26} n={n:3d} th={th:10.7f} th/th0={th/K.theta0(n):6.4f} "
        f"res={res:7.1e} |Ric|={ric:6.1e} dim_m={dm:4d} "
        f"S_struct={Sst:12.4f} S_adj={Sad:12.2f} S_theta={Sth:10.6f} "
        f"ratio_adj/struct={(Sad/Sst if Sst>1e-12 else float('nan')):8.3f} {extra}")
    return dict(name=name, n=n, th=th, Sst=Sst, Sad=Sad, Sth=Sth, dm=dm, res=res)


if __name__ == '__main__':
    log("PHASE 4/5: slack comparison")
    log(" -- two-block products (expect all three slacks 0) --")
    for n, parts in [(6, (3, 3)), (8, (4, 4)), (8, (3, 5)), (10, (5, 5)), (12, (6, 6)), (9, (4, 5))]:
        full(f"S^{parts[0]}xS^{parts[1]}", n, sphere_multi_vertex(n, parts))
    log(" -- multi-block products --")
    for n, parts in [(9, (3, 3, 3)), (12, (4, 4, 4)), (12, (3, 3, 3, 3)),
                     (12, (2, 5, 5)), (12, (2, 2, 8)), (12, (3, 4, 5)),
                     (10, (2, 4, 4)), (11, (3, 4, 4)), (8, (2, 3, 3)),
                     (13, (2, 2, 9)), (14, (2, 2, 10)), (6, (2, 2, 2))]:
        full(f"S{'xS'.join(map(str,parts))}", n, sphere_multi_vertex(n, parts))
    log(" -- subalgebra family --")
    full("so(3)^3 casimir", 9, casimir_W(9, so_block_gens(9, (3, 3, 3)))[0])
    full("so(4)+so(4) casimir", 8, casimir_W(8, so_block_gens(8, (4, 4)))[0])
    full("su(3) adjoint", 8, casimir_W(8, su3_ad_gens())[0])
    full("so(5) adjoint", 10, casimir_W(10, so_ad_gens(5))[0])
    log("PHASE 4/5 slack comparison done")
