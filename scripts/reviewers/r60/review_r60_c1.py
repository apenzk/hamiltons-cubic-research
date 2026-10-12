"""Reviewer 60, C1: is sum_a lam_a ad(v_a)^2 = 2W on Weyl_m?  And what does it need?"""
import sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
import numpy as np
from review_r60_core import *

rng = np.random.default_rng(60)


def A_of(m, W, C):
    D = W.shape[0]
    out = np.zeros((D, D))
    for g in range(D):
        for h in range(D):
            if W[g, h] != 0.0:
                out += W[g, h] * (C[g] @ C[h])
    return out


for m in [4, 5, 6, 7, 8]:
    C = ad_matrices(m)
    B = weyl_basis(m)
    D = m * (m - 1) // 2
    # random Weyl tensor
    errs = []
    for _ in range(3):
        c = rng.standard_normal(len(B))
        W = sum(ci * Bi for ci, Bi in zip(c, B))
        W /= np.linalg.norm(W)
        A = A_of(m, W, C)
        errs.append(np.abs(A - 2 * W).max())
    # eigenbasis form (identical by linearity, but check literally)
    lam, V = np.linalg.eigh(W)
    S = sum(lam[a] * (ad_of(m, vec_to_mat(m, V[:, a])) @ ad_of(m, vec_to_mat(m, V[:, a])))
            for a in range(D))
    print(f"m={m} dimWeyl={len(B)} max|A(W)-2W| over 3 draws = {max(errs):.2e}  eigenform err={np.abs(S-2*W).max():.2e}")


# ---- which hypothesis is load-bearing? ----
def constraints(m, ricci=True, bianchi=True):
    import itertools
    P = pairs(m); D = len(P); idx = {p: a for a, p in enumerate(P)}
    sym = [(a, b) for a in range(D) for b in range(a, D)]
    sidx = {s: t for t, s in enumerate(sym)}; n = len(sym)
    def add(row, i, j, k, l, c):
        if i == j or k == l: return
        s = c
        if i > j: i, j, s = j, i, -s
        if k > l: k, l, s = l, k, -s
        a, b = idx[(i, j)], idx[(k, l)]
        if a > b: a, b = b, a
        row[sidx[(a, b)]] += s
    rows = []
    if ricci:
        for i in range(m):
            for k in range(i, m):
                row = np.zeros(n)
                for j in range(m): add(row, i, j, k, j, 1.0)
                if np.any(row): rows.append(row)
    if bianchi:
        for q in itertools.combinations(range(m), 4):
            for (a, b, c_, d) in itertools.permutations(q, 4):
                row = np.zeros(n)
                add(row, a, b, c_, d, 1.0); add(row, a, c_, d, b, 1.0); add(row, a, d, b, c_, 1.0)
                if np.any(row): rows.append(row)
    if not rows:
        return [np.zeros((D, D)) for _ in range(0)] or None, sym
    return np.array(rows), sym


def space(m, ricci, bianchi):
    P = pairs(m); D = len(P)
    sym = [(a, b) for a in range(D) for b in range(a, D)]
    if not ricci and not bianchi:
        out = []
        for (a, b) in sym:
            M = np.zeros((D, D)); M[a, b] = 1.0; M[b, a] = 1.0
            out.append(M / np.linalg.norm(M))
        return out
    A, sym = constraints(m, ricci, bianchi)
    u, s, vt = np.linalg.svd(A)
    r = int(np.sum(s > 1e-10 * s[0]))
    out = []
    for row in vt[r:]:
        M = np.zeros((D, D))
        for t, (a, b) in enumerate(sym):
            M[a, b] += row[t]; M[b, a] = M[a, b]
        out.append(M / np.linalg.norm(M))
    return out


def ric_mat(m, W):
    g = comp(m, W)
    return np.array([[sum(g(i, j, k, j) for j in range(m)) for k in range(m)] for i in range(m)])


def L_S(m, S):
    """omega |-> S omega + omega S, as a D x D matrix"""
    B = basis(m); D = len(B)
    return np.array([mat_to_vec(m, S @ B[k] + B[k] @ S) for k in range(D)]).T


print("\n--- dropping hypotheses (m=5,6): residual A(W)-2W vs the Ricci term ---")
for m in [5, 6]:
    C = ad_matrices(m)
    for (ric, bia, name) in [(False, True, "Bianchi only (alg. curvature op)"),
                             (True, False, "Ricci-flat only"),
                             (False, False, "symmetric only")]:
        S = space(m, ric, bia)
        c = rng.standard_normal(len(S)); W = sum(ci * Si for ci, Si in zip(c, S)); W /= np.linalg.norm(W)
        A = A_of(m, W, C)
        R = ric_mat(m, W)
        LR = L_S(m, R)
        resid = A - 2 * W
        # least-squares fit resid ~ t * LR
        t = np.sum(resid * LR) / max(np.sum(LR * LR), 1e-300)
        rel = np.linalg.norm(resid - t * LR) / max(np.linalg.norm(resid), 1e-300)
        print(f"m={m} {name:34s} dim={len(S):4d} |A-2W|={np.linalg.norm(resid):.4f} "
              f"best t={t:+.4f} rel-resid after Ricci fit={rel:.2e}")
