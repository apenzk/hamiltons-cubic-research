"""r68: is the vector identity  sum_b ||[v_a,v_b]||^2 lam_b = -2 lam_a  really a property
of every Weyl operator?  Tested on random elements of Weyl_n, built as the nullspace of
(first Bianchi) + (Ricci) inside the symmetric operators on so(n)."""
import sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
import numpy as np
from itertools import combinations
import review_r68_core as R

rng = np.random.default_rng(6812)


def weyl_basis(n):
    P = R.pairs(n); N = len(P)
    idx = {}
    for k, (i, j) in enumerate(P):
        idx[(i, j)] = (k, 1.0); idx[(j, i)] = (k, -1.0)
    coords = [(a, b) for a in range(N) for b in range(a, N)]
    rows = []
    # first Bianchi: R_ijkl + R_iklj + R_iljk = 0 for i<j<k<l
    for (i, j, k, l) in combinations(range(n), 4):
        row = np.zeros(len(coords))
        for (p, q) in [((i, j), (k, l)), ((i, k), (l, j)), ((i, l), (j, k))]:
            a, sa = idx[p]; b, sb = idx[q]
            u, v = (a, b) if a <= b else (b, a)
            row[coords.index((u, v))] += sa*sb
        rows.append(row)
    # Ricci: sum_j R_{ijkj} = 0
    for i in range(n):
        for k in range(i, n):
            row = np.zeros(len(coords))
            for j in range(n):
                if j == i or j == k:
                    continue
                a, sa = idx[(i, j)]; b, sb = idx[(k, j)]
                u, v = (a, b) if a <= b else (b, a)
                row[coords.index((u, v))] += sa*sb
            rows.append(row)
    A = np.array(rows)
    _, sv, Vt = np.linalg.svd(A)
    null = Vt[(sv > 1e-9).sum():]
    return coords, null


def op_from_coords(coords, vec, N):
    W = np.zeros((N, N))
    for c, (a, b) in zip(vec, coords):
        W[a, b] += c; 
        if a != b:
            W[b, a] += c
    return W


if __name__ == '__main__':
    for n in [5, 6, 7]:
        C = R.struct(n)
        N = n*(n-1)//2
        coords, null = weyl_basis(n)
        print(f"n={n}: dim Weyl_n = {null.shape[0]} (formula n(n+1)(n+2)(n-3)/12 = {n*(n+1)*(n+2)*(n-3)//12})")
        worst_vec = 0.0; worst_row = 0.0; worst_cap = 0.0
        for t in range(25):
            W = op_from_coords(coords, null.T @ rng.normal(size=null.shape[0]), N)
            W /= np.linalg.norm(W)
            lam, V = np.linalg.eigh(W)
            cp = R.cprime(C, V); T = cp**2
            Rmat = T.sum(axis=2)
            worst_vec = max(worst_vec, np.abs(Rmat @ lam + 2*lam).max())
            worst_row = max(worst_row, np.abs(Rmat.sum(axis=1) - 2*(n-2)).max())
            worst_cap = max(worst_cap, Rmat.max())
        print(f"   25 random Weyl operators: max |R.lam + 2 lam| = {worst_vec:.2e},"
              f" max |rowsum - 2(n-2)| = {worst_row:.2e}, max pair cap = {worst_cap:.6f}")
