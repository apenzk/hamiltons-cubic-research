"""Reviewer 45, phase 6: P6.  How large a neighbourhood of theta_0(n) is safe?

Catalogue every S = 0 critical point I can build at a given n -- sphere products
native to n, sphere products padded up from every smaller n0, the Fox / CP^2
point, and the CP^m family -- and record theta, S, orbit dim and dim E(1/2).
The question is whether padding CREATES degeneracy (which would put a degenerate
S = 0 point at theta_0(n-2), right under theta_0(n)) or merely INHERITS it.
"""
import sys, time
import numpy as np
sys.path.insert(0, 'scripts/lib')
from review_r45_core import (struct, weyl_basis, Qop, circ, sphere_product, pad,
                             theta_and_residual, orbit_tangent, Le_matrix,
                             slack, pairs_of, phi_matrices)

LOG = 'agent_logs/review_r45_padded.log'


def log(msg):
    with open(LOG, 'a') as f:
        f.write(f"{time.strftime('%H:%M:%S')} {msg}\n")
    print(msg, flush=True)


# ---------- the Fox / CP^2 point in dimension 4, built from the SD/ASD split ----
def fox_W4():
    """Weyl operator of CP^2: 0 on Lambda^-, diag(-1,-1,2)/sqrt6 on Lambda^+."""
    ps, idx = pairs_of(4)
    N = 6
    def bv(i, j, k, l, s):
        v = np.zeros(N)
        v[idx[(i, j)]] = 1 / np.sqrt(2)
        v[idx[(k, l)]] = s / np.sqrt(2)
        return v
    Lp = [bv(0, 1, 2, 3, +1), bv(0, 2, 1, 3, -1), bv(0, 3, 1, 2, +1)]
    Lm = [bv(0, 1, 2, 3, -1), bv(0, 2, 1, 3, +1), bv(0, 3, 1, 2, -1)]
    vals = np.array([-1.0, -1.0, 2.0]) / np.sqrt(6)
    W = sum(v * np.outer(u, u) for v, u in zip(vals, Lp))
    # sanity: Lambda^+ and Lambda^- orthonormal and orthogonal
    G = np.array([[u @ w for w in Lp + Lm] for u in Lp + Lm])
    assert np.abs(G - np.eye(6)).max() < 1e-12
    return W


# ---------- the CP^m family: the unique u(m)-invariant Weyl operator ------------
def cpm_W(m):
    """n = 2m.  Unique (up to scale) u(m)-invariant element of Weyl_{2m}."""
    n = 2 * m
    B = weyl_basis(n)
    Bf = B.reshape(B.shape[0], -1)
    N = B.shape[1]
    # u(m) inside so(2m): span of the complex structure J and ...
    # easier: average a generic Weyl element over the U(m) action.
    J = np.zeros((n, n))
    for a in range(m):
        J[2 * a, 2 * a + 1] = 1.0
        J[2 * a + 1, 2 * a] = -1.0
    # representation of so(n) on Lambda^2 : rho(X) phi = X phi + phi X^T
    P = phi_matrices(n)
    def rho(X):
        C = X @ P + P @ X.T
        return 0.5 * np.einsum('mij,cij->cm', C, P)   # matrix acting on coeffs
    # the U(m)-invariant subspace of Weyl_n = kernel of rho(X) action for all
    # X in u(m); u(m) = {X in so(n) : XJ = JX}
    gens = []
    for a in range(n):
        for b in range(a + 1, n):
            E = np.zeros((n, n)); E[a, b] = 1; E[b, a] = -1
            gens.append(E)
    U = [X for X in gens]
    # project onto u(m): X -> (X + J X J^T)/2 keeps the commuting part
    U = [(X - J @ X @ J) / 2 for X in gens]
    rows = []
    D = Bf.shape[0]
    for X in U:
        R = rho(X)
        # action on operators: M -> R M + M R^T ; restricted to Weyl basis
        col = np.array([(R @ Bf[d].reshape(N, N) + Bf[d].reshape(N, N) @ R.T).reshape(-1)
                        for d in range(D)])
        rows.append(col @ Bf.T)
    Mall = np.vstack(rows)
    _, s, Vt = np.linalg.svd(Mall)
    rank = int((s > max(Mall.shape) * np.finfo(float).eps * s[0]).sum())
    K = Vt[rank:]
    return K, Bf, N, B


def full_report(name, Wraw, n, Bc, Ac):
    A = Ac[n]
    B = Bc[n]
    Bf = B.reshape(B.shape[0], -1)
    N = A.shape[0]
    v = Bf @ Wraw.reshape(-1)
    dev = np.linalg.norm((v @ Bf).reshape(N, N) - Wraw) / np.linalg.norm(Wraw)
    W = Wraw / np.linalg.norm(Wraw)
    th, res = theta_and_residual(W, A)
    if th < 0:
        W, th = -W, -th
        th, res = theta_and_residual(W, A)
    S = slack(W, A)
    T = np.einsum('amn,np->amp', A, W) - np.einsum('mn,anp->amp', W, A)
    s = np.linalg.svd(T.reshape(N, N * N), compute_uv=False)
    orb = int((s > max(N, N * N) * np.finfo(float).eps * s[0]).sum())
    M = Le_matrix(Bf, W / th, A)
    w = np.linalg.eigvalsh(M)
    d = np.sort(np.abs(w - 0.5))
    dimE = int((d < 1e-8).sum())
    gap = d[dimE] if dimE < len(d) else np.inf
    th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
    log(f"  {name:<28} n={n:2d} projdev={dev:.1e} theta={th:.9f} "
        f"(theta_0={th0:.6f}) resid={res:.1e} S={S:.2e} orbit={orb:4d} "
        f"dimE={dimE:4d} excess={dimE-orb:4d} gap={gap:.1e}")
    return dict(name=name, n=n, theta=th, S=S, orb=orb, dimE=dimE,
                excess=dimE - orb, res=res, dev=dev)


if __name__ == "__main__":
    NS = [int(x) for x in (sys.argv[1:] or ['8', '10', '12'])]
    Bc, Ac = {}, {}
    for n in NS:
        t = time.time()
        Bc[n] = weyl_basis(n)
        Ac[n] = struct(n)
        log(f"PHASE6 setup n={n} D={Bc[n].shape[0]} ({time.time()-t:.1f}s)")

    W4 = fox_W4()
    rows = []
    for n in NS:
        log(f"--- n = {n} ---")
        rows.append(full_report("Fox/CP^2 (padded from 4)", pad(W4, 4, n), n, Bc, Ac))
        for n0 in range(6, n + 1, 2):
            for k in range(2, n0 // 2 + 1):
                l = n0 - k
                tag = f"S^{k}xS^{l}" + ("" if n0 == n else f" pad {n0}->{n}")
                Wr = pad(sphere_product(k, l, n0), n0, n) if n0 != n \
                    else sphere_product(k, l, n)
                rows.append(full_report(tag, Wr, n, Bc, Ac))
        for n0 in range(6, n + 1, 2):
            for k in range(3, n0 // 2 + 1):
                l = n0 - k
                if k == l:
                    continue
        # odd-dimensional seeds too (padding from odd n0)
        for n0 in range(5, n + 1):
            if n0 % 2 == 0 or n0 > n:
                continue
            for k in range(2, n0 // 2 + 1):
                l = n0 - k
                if l < 2:
                    continue
                Wr = pad(sphere_product(k, l, n0), n0, n)
                rows.append(full_report(f"S^{k}xS^{l} pad {n0}->{n}", Wr, n, Bc, Ac))

    log("=== P6 summary: degenerate S=0 points ranked by theta ===")
    deg = [r for r in rows if r['excess'] > 0 and r['S'] < 1e-12 and r['res'] < 1e-10]
    deg.sort(key=lambda r: -r['theta'])
    for r in deg:
        th0 = np.sqrt(2 * (r['n'] - 1) * (r['n'] - 2)) / r['n']
        log(f"  DEGENERATE  n={r['n']:2d} theta={r['theta']:.9f} "
            f"theta_0-theta={th0-r['theta']:.6f} excess={r['excess']:3d}  {r['name']}")
    log("=== nondegenerate S=0 points with the largest theta ===")
    nd = [r for r in rows if r['excess'] == 0 and r['S'] < 1e-12 and r['res'] < 1e-10]
    nd.sort(key=lambda r: -r['theta'])
    for r in nd[:12]:
        log(f"  nondeg      n={r['n']:2d} theta={r['theta']:.9f} {r['name']}")
