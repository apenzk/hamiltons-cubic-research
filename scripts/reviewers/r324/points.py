"""Named points, built from their own definition."""
import numpy as np, itertools, core

def proj_subalgebra(idxsets, n):
    """Pi_h for h = span of the coordinate bivectors listed (as index pairs)."""
    P = core.pairs(n)
    pos = {p: a for a, p in enumerate(P)}
    N = len(P)
    Pi = np.zeros((N, N))
    for p in idxsets:
        Pi[pos[p], pos[p]] = 1.0
    return Pi

def blocks_h(blocks, n):
    """h = so(b_1)+...+so(b_k) on consecutive coordinate blocks."""
    out = []
    off = 0
    for b in blocks:
        for i, j in itertools.combinations(range(off, off + b), 2):
            out.append((i, j))
        off += b
    return out

def W_subalg(hpairs, n, normalise=True):
    P = core.pairs(n); N = len(P)
    Pi = proj_subalgebra(hpairs, n)
    r = len(hpairs)
    W = Pi - (r / N) * np.eye(N)
    if normalise:
        W = W / np.linalg.norm(W)
    return W

def torus_h(n):
    return [(2 * k, 2 * k + 1) for k in range(n // 2)]

def su3_in_so8(n=8):
    """ad(su(3)) inside so(8): the 8-dim adjoint rep of su(3)."""
    import numpy as np
    # Gell-Mann basis, orthonormalised for <X,Y>=2tr(X Y^dag)... build ad matrices.
    lam = []
    def M(*v):
        return np.array(v, dtype=complex).reshape(3, 3)
    lam.append(M(0,1,0, 1,0,0, 0,0,0))
    lam.append(M(0,-1j,0, 1j,0,0, 0,0,0))
    lam.append(M(1,0,0, 0,-1,0, 0,0,0))
    lam.append(M(0,0,1, 0,0,0, 1,0,0))
    lam.append(M(0,0,-1j, 0,0,0, 1j,0,0))
    lam.append(M(0,0,0, 0,0,1, 0,1,0))
    lam.append(M(0,0,0, 0,0,-1j, 0,1j,0))
    lam.append(M(1,0,0, 0,1,0, 0,0,-2)/np.sqrt(3))
    T = [l / 2.0 for l in lam]            # <T_a,T_b> = delta/2
    ad = np.zeros((8, 8, 8))
    for a in range(8):
        for b in range(8):
            comm = T[a] @ T[b] - T[b] @ T[a]
            for c in range(8):
                ad[a, b, c] = (2.0 * np.trace(comm @ T[c]) / 1j).real
    # ad[a] is the matrix of ad(T_a) acting on the orthonormal basis {sqrt2 T_b}:
    # ad(T_a) T_b = sum_c f_abc T_c, and the f are real antisymmetric -> ad(T_a) in so(8).
    A = [ad[a].T for a in range(8)]       # (ad_a)_{cb} = f_abc
    # normalise each to unit norm under <X,Y>=(1/2)tr(X^T Y) then span
    return A

def W_from_span(mats, n, normalise=True):
    """h given as a list of so(n) matrices; W = Pi_h - (r/N) I in the Lambda^2 basis."""
    P, L = core.basis(n)
    N = len(P)
    V = np.array([[0.5*np.trace(M.T @ L[a]) for a in range(N)] for M in mats])
    Qm, _ = np.linalg.qr(V.T)
    r = np.linalg.matrix_rank(V, tol=1e-10)
    Qm = Qm[:, :r]
    Pi = Qm @ Qm.T
    W = Pi - (r / N) * np.eye(N)
    return (W / np.linalg.norm(W)) if normalise else W
