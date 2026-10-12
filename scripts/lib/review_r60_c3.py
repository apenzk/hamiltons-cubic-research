"""Reviewer 60, C3: centraliser collapse dim(z(c) cap c^perp) for c = z(x) cap x^perp,
x nondegenerate skew.  Enumerates EVERY multiplicity partition at m=4,6,8,10,12."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from review_r60_core import *

rng = np.random.default_rng(603)


def partitions(n, mx=None):
    if mx is None: mx = n
    if n == 0:
        yield ()
        return
    for k in range(min(n, mx), 0, -1):
        for rest in partitions(n - k, k):
            yield (k,) + rest


def block_x(m, part, alphas):
    """x = direct sum alpha_j J on C^{m_j}; J = [[0,1],[-1,0]] per complex coordinate."""
    x = np.zeros((m, m)); pos = 0
    for mj, a in zip(part, alphas):
        for _ in range(mj):
            x[pos, pos + 1] = a; x[pos + 1, pos] = -a; pos += 2
    return x


def nullspace(A, tol=1e-9):
    if A.shape[0] == 0:
        return np.eye(A.shape[1])
    u, s, vt = np.linalg.svd(A)
    r = int(np.sum(s > tol * max(s[0], 1.0)))
    return vt[r:].T


def centraliser(m, vecs):
    """basis (columns, in phi-coords) of {u in so(m): [w,u]=0 for all w in span(vecs)}"""
    D = m * (m - 1) // 2
    if len(vecs) == 0:
        return np.eye(D)
    A = np.vstack([ad_of(m, vec_to_mat(m, w)) for w in vecs.T])
    return nullspace(A)


def collapse(m, x):
    D = m * (m - 1) // 2
    xv = mat_to_vec(m, x); xv = xv / np.linalg.norm(xv)
    # c = z(x) cap x^perp
    Z = nullspace(np.vstack([ad_of(m, x), xv[None, :]]))
    # z(c)
    ZC = centraliser(m, Z)
    # intersect with c^perp : project out span(Z)
    if Z.shape[1] == 0:
        return ZC.shape[1], ZC
    Qz, _ = np.linalg.qr(Z)
    M = ZC - Qz @ (Qz.T @ ZC)
    u, s, vt = np.linalg.svd(M) if M.size else (None, np.array([]), None)
    r = int(np.sum(s > 1e-8 * max(s[0], 1.0))) if s.size else 0
    return r, (u[:, :r] if r else np.zeros((D, 0)))


if __name__ == "__main__":
    print("m  partition       dim c   dim(z(c) cap c^perp)   contains x?   [random alphas, 4 draws]")
    for m in [4, 6, 8, 10, 12]:
        p = m // 2
        for part in partitions(p):
            res, inx = set(), set()
            for _ in range(4):
                al = np.sort(rng.uniform(0.5, 3.0, len(part)))[::-1]
                while len(set(np.round(al, 6))) < len(al):
                    al = np.sort(rng.uniform(0.5, 3.0, len(part)))[::-1]
                x = block_x(m, part, al)
                xv = mat_to_vec(m, x); xv /= np.linalg.norm(xv)
                # random conjugation to avoid a special frame
                G = np.linalg.qr(rng.standard_normal((m, m)))[0]
                x = G @ x @ G.T
                xv = mat_to_vec(m, x); xv /= np.linalg.norm(xv)
                D_ = m * (m - 1) // 2
                Z = nullspace(np.vstack([ad_of(m, x), xv[None, :]]))
                d, Ubasis = collapse(m, x)
                res.add((Z.shape[1], d))
                if d:
                    proj = np.linalg.norm(Ubasis.T @ xv)
                    inx.add(round(float(proj), 6))
            (dc, dz), = res if len(res) == 1 else (sorted(res)[0],)
            print(f"{m:2d} {str(part):14s} {dc:4d}    {sorted({r[1] for r in res})}"
                  f"           x in it: {sorted(inx)}   (all draws agree: {len(res)==1})")

