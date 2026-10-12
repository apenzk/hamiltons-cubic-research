"""Reviewer 32: attack N7 (the vector X) and N8 (e o X = mu X), numerically."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys
import itertools
import numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r32_core import (planes, plane_index, struct_sparse_lists,
                             weyl_basis, W_pq, bianchi_defect, ricci,
                             to_tensor, L_operator_sparse)


def bianchi_part(n, R):
    """The Lambda^4 component of a symmetric operator R (projector b)."""
    T = to_tensor(n, R)
    pi = plane_index(n)
    N = len(pi)
    out = np.zeros((N, N))
    for (i, j), a in pi.items():
        for (k, l), b in pi.items():
            if len({i, j, k, l}) < 4:
                continue
            out[a, b] = (T[i, j, k, l] + T[i, k, l, j] + T[i, l, j, k]) / 3.0
    return out


def make_X(n, p, q, pi_plane=(0, 1), rho_plane=None):
    """phi_pi (x) phi_rho + phi_rho (x) phi_pi with the Lambda^4 part removed."""
    if rho_plane is None:
        rho_plane = (p, p + 1)
    idx = plane_index(n)
    N = len(idx)
    X0 = np.zeros((N, N))
    a, b = idx[pi_plane], idx[rho_plane]
    X0[a, b] = X0[b, a] = 1.0
    return X0 - bianchi_part(n, X0)


def mu_pred(p, q):
    n = p + q
    return (n - 2) / (2.0 * (p - 1) * (q - 1))


print("=== N7: X in Weyl_n, ||X||^2 = 4/3, three pairings 2/3, 1/3, -1/3 ===")
for (p, q) in [(2, 2), (2, 3), (2, 4), (3, 3), (3, 4), (4, 4), (2, 6), (3, 5), (4, 5)]:
    n = p + q
    X = make_X(n, p, q)
    bd = np.abs(bianchi_defect(n, X)).max()
    rc = np.abs(ricci(n, X)).max()
    nrm = np.sum(X * X)
    idx = plane_index(n)
    pairs = {}
    for (a, pa) in idx.items():
        for (b, pb) in idx.items():
            if pb <= pa:
                continue
            if abs(X[pa, pb]) > 1e-12:
                pairs[(a, b)] = X[pa, pb]
    print(f"  (p,q)=({p},{q}) n={n}: Bianchi {bd:.1e} Ricci {rc:.1e} "
          f"||X||^2={nrm:.12f} (4/3={4/3:.12f})")
    print(f"      support (upper): {[(k, round(v,6)) for k, v in pairs.items()]}")
    assert bd < 1e-12 and rc < 1e-12 and abs(nrm - 4 / 3) < 1e-12
    assert len(pairs) == 3

print("\n=== N8: e o X = mu X ?  mu_pred = (n-2)/(2(p-1)(q-1)) ===")
print(f"  {'p,q':>8} {'n':>3} {'mu_pred':>12} {'Rayleigh':>14} {'max|LeX-muX|':>14} {'rel resid':>12}")
rows = []
for (p, q) in [(2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (2, 8), (2, 10),
               (3, 3), (3, 4), (3, 5), (3, 6), (3, 7), (3, 9),
               (4, 4), (4, 5), (4, 6), (4, 7), (4, 8),
               (5, 5), (5, 6), (5, 7), (6, 6), (6, 7), (7, 7), (5, 9), (4, 10)]:
    n = p + q
    if n > 16:
        continue
    lists = struct_sparse_lists(n)
    N = n * (n - 1) // 2
    W = W_pq(n, p, q)
    e = W / ((n - 1) / (p * q))
    X = make_X(n, p, q)
    Lop = L_operator_sparse(n, e, lists)
    LX = (Lop @ X.ravel()).reshape(N, N)
    mp = mu_pred(p, q)
    rq = np.sum(X * LX) / np.sum(X * X)
    resid = np.abs(LX - mp * X).max()
    print(f"  {p:3d},{q:3d} {n:3d} {mp:12.9f} {rq:14.9f} {resid:14.3e} "
          f"{resid/max(1e-30,np.abs(mp)):12.2e}")
    rows.append((p, q, mp, rq, resid))
    assert abs(rq - mp) < 1e-10, (p, q, rq, mp)

bad = [r for r in rows if r[4] > 1e-10]
print(f"\n  eigenvector failures (resid>1e-10): {bad if bad else 'NONE'}")

print("\n=== N8 stress: where does L_e X live?  entries off the support ===")
for (p, q) in [(2, 2), (2, 4), (3, 3), (4, 4), (3, 5), (5, 7)]:
    n = p + q
    lists = struct_sparse_lists(n)
    N = n * (n - 1) // 2
    W = W_pq(n, p, q)
    e = W / ((n - 1) / (p * q))
    X = make_X(n, p, q)
    Lop = L_operator_sparse(n, e, lists)
    LX = (Lop @ X.ravel()).reshape(N, N)
    off = LX.copy()
    supp = np.abs(X) > 1e-12
    off[supp] = 0.0
    print(f"  (p,q)=({p},{q}): max |L_e X| off the support of X = {np.abs(off).max():.3e}")

print("\n=== N8 robustness: other choices of pi and rho (disjointness / p=2,q=2) ===")
for (p, q, pl, rl) in [(4, 4, (0, 1), (4, 5)), (4, 4, (1, 3), (5, 7)),
                       (2, 2, (0, 1), (2, 3)), (5, 5, (2, 4), (6, 9)),
                       (3, 6, (0, 2), (4, 8))]:
    n = p + q
    lists = struct_sparse_lists(n)
    N = n * (n - 1) // 2
    W = W_pq(n, p, q)
    e = W / ((n - 1) / (p * q))
    X = make_X(n, p, q, pl, rl)
    Lop = L_operator_sparse(n, e, lists)
    LX = (Lop @ X.ravel()).reshape(N, N)
    mp = mu_pred(p, q)
    print(f"  (p,q)=({p},{q}) pi={pl} rho={rl}: max|LeX - muX| = "
          f"{np.abs(LX - mp*X).max():.3e}")

print("\n=== N8 counter-probe: pi NOT inside a single block (mixed plane) ===")
for (p, q) in [(3, 3), (4, 4)]:
    n = p + q
    lists = struct_sparse_lists(n)
    N = n * (n - 1) // 2
    W = W_pq(n, p, q)
    e = W / ((n - 1) / (p * q))
    # pi crosses the blocks: (0, p);  rho = (1, p+1)
    X = make_X(n, p, q, (0, p), (1, p + 1))
    Lop = L_operator_sparse(n, e, lists)
    LX = (Lop @ X.ravel()).reshape(N, N)
    mp = mu_pred(p, q)
    rq = np.sum(X * LX) / np.sum(X * X)
    print(f"  (p,q)=({p},{q}) mixed planes: Rayleigh {rq:.9f} vs mu {mp:.9f}, "
          f"resid {np.abs(LX - rq*X).max():.3e}")
