import sys, os
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np, core


def sphere_product(blocks):
    n = sum(blocks)
    P, idx = core.pairs_of(n)
    lab = []
    for bi, b in enumerate(blocks):
        lab += [bi] * b
    W = np.zeros((len(P), len(P)))
    for a, (i, j) in enumerate(P):
        if lab[i] == lab[j]:
            p = blocks[lab[i]]
            W[a, a] = 1.0 / (p * (p - 1))
        else:
            W[a, a] = -1.0 / (blocks[lab[i]] * blocks[lab[j]])
    return W / np.linalg.norm(W), n


def cpm(m):
    """Weyl operator of CP^m with FS metric, n = 2m.  R_ijkl = g_ik g_jl - g_il g_jk
    + J_ik J_jl - J_il J_jk + 2 J_ij J_kl, then project into Weyl_n."""
    n = 2 * m
    J = np.zeros((n, n))
    for k in range(m):
        J[2 * k, 2 * k + 1] = 1.0
        J[2 * k + 1, 2 * k] = -1.0
    g = np.eye(n)
    Pr, idx = core.pairs_of(n)
    N = len(Pr)
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(Pr):
        for b, (k, l) in enumerate(Pr):
            W[a, b] = (g[i, k] * g[j, l] - g[i, l] * g[j, k]
                       + J[i, k] * J[j, l] - J[i, l] * J[j, k]
                       + 2 * J[i, j] * J[k, l])
    W = core.proj_weyl(n, 0.5 * (W + W.T))
    return W / np.linalg.norm(W), n


def c5_blowup(sizes=(2, 2, 2, 2, 2), diag=4.0, adjv=-2.0, nonadj=1.0):
    k = len(sizes); n = sum(sizes)
    G = [[0] * k for _ in range(k)]
    for a in range(k):
        G[a][(a + 1) % k] = G[(a + 1) % k][a] = 1
    Pr, idx = core.pairs_of(n)
    lab = []
    for bi, b in enumerate(sizes):
        lab += [bi] * b
    W = np.zeros((len(Pr), len(Pr)))
    for a, (i, j) in enumerate(Pr):
        A_, B_ = lab[i], lab[j]
        W[a, a] = diag if A_ == B_ else (adjv if G[A_][B_] else nonadj)
    return W / np.linalg.norm(W), n


def report(name, W, n):
    Wp = core.proj_weyl(n, W)
    inweyl = np.linalg.norm(W - Wp)
    Qv = core.Q(n, W)
    th = float(np.sum(W * Qv))
    res = np.linalg.norm(core.proj_weyl(n, Qv) - th * W)
    resfull = np.linalg.norm(Qv - th * W)
    return dict(name=name, n=n, weyl_err=inweyl, theta=th,
                crit_res_in_weyl=res, crit_res_full=resfull)


def defect(n, W):
    """Delta = sum over eigenvectors with positive eigenvalue of ||[ad(v),W]||_F^2."""
    A = core.ad(n)
    lam, V = np.linalg.eigh(W)
    tot = 0.0; pos = 0.0; g = []
    for k in range(len(lam)):
        adv = np.einsum('a,amn->mn', V[:, k], A)
        gk = np.linalg.norm(adv @ W - W @ adv) ** 2
        g.append(gk); tot += gk
        if lam[k] > 1e-9:
            pos += gk
    return pos, tot, lam, np.array(g)


if __name__ == "__main__":
    pts = [("S^3xS^5",) + sphere_product([3, 5]),
           ("S^5xS^5",) + sphere_product([5, 5]),
           ("CP^4",) + cpm(4),
           ("C5blowup",) + c5_blowup()]
    for nm, W, n in pts:
        r = report(nm, W, n)
        d, tot, lam, g = defect(n, W)
        print(f"{nm:12s} n={n} weyl_err={r['weyl_err']:.2e} theta={r['theta']:.9f} "
              f"crit_res={r['crit_res_full']:.2e} Delta={d:.6f} sum_g={tot:.6f} 4(n-1)={4*(n-1)}")
