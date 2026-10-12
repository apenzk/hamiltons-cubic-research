"""Exact rank / nullspace over F_p, vectorised int64 (p^2 * ncols fits in int64)."""
import numpy as np

P = 46337  # p^2 ~ 2.1e9; with <=2^30 columns the row-reduction stays inside int64

def rref(M, p=P):
    M = np.mod(np.asarray(M, dtype=np.int64), p)
    rows, cols = M.shape
    piv, r = [], 0
    for c in range(cols):
        nz = np.nonzero(M[r:, c])[0]
        if nz.size == 0:
            continue
        pr = r + nz[0]
        if pr != r:
            M[[r, pr]] = M[[pr, r]]
        M[r] = (M[r] * pow(int(M[r, c]), p - 2, p)) % p
        col = M[:, c].copy(); col[r] = 0
        nzr = np.nonzero(col)[0]
        if nzr.size:
            M[nzr] = (M[nzr] - np.outer(col[nzr], M[r])) % p
        piv.append(c); r += 1
        if r == rows:
            break
    return M, piv

def rank(M, p=P):
    M = np.asarray(M)
    if M.size == 0:
        return 0
    return len(rref(M, p)[1])

def nullspace(M, p=P):
    """rows span ker(M) over F_p."""
    R, piv = rref(M, p)
    cols = M.shape[1]
    pivset = set(piv)
    free = [c for c in range(cols) if c not in pivset]
    B = np.zeros((len(free), cols), dtype=np.int64)
    for j, f in enumerate(free):
        B[j, f] = 1
        for i, c in enumerate(piv):
            B[j, c] = (-int(R[i, f])) % p
    return B
