"""Fast orthonormal basis of Weyl_n inside Sym(Lambda^2 R^n), built from the
first Bianchi identity and Ricci-flatness directly in pair coordinates."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
import r306_defs as R


def signed(idx, a, b, c, d):
    if a == b or c == d:
        return None, 0.0
    s = 1.0
    if a > b: a, b, s = b, a, -s
    if c > d: c, d, s = d, c, -s
    return (idx[(a, b)], idx[(c, d)]), s


def weyl_basis_fast(n, tol=1e-9):
    pairs, idx = R.pair_index(n)
    D = len(pairs)
    cons = []
    def addsym(C, i, j, v):
        C[i, j] += v / 2.0
        C[j, i] += v / 2.0
    for a in range(n):
        for b in range(a + 1, n):
            for c in range(b + 1, n):
                for d in range(c + 1, n):
                    C = np.zeros((D, D))
                    for (x, y, z, w) in ((a, b, c, d), (a, c, d, b), (a, d, b, c)):
                        p, s = signed(idx, x, y, z, w)
                        addsym(C, p[0], p[1], s)
                    cons.append(C)
    for a in range(n):
        for b in range(a, n):
            C = np.zeros((D, D))
            for k in range(n):
                p, s = signed(idx, a, k, b, k)
                if p is None: continue
                addsym(C, p[0], p[1], s)
            if np.abs(C).max() > 0:
                cons.append(C)
    A = np.array([C.ravel() for C in cons])
    u, s, vt = np.linalg.svd(A, full_matrices=False)
    rank = int(np.sum(s > tol))
    Arow = vt[:rank]                       # orthonormal row space of constraints
    # symmetric matrices orthogonal to all constraints
    Sb = R.sym_basis(D)
    X = np.array([b.ravel() for b in Sb]).T          # D^2 x dimSym
    Y = X - Arow.T @ (Arow @ X)
    u2, s2, vt2 = np.linalg.svd(Y, full_matrices=False)
    k = int(np.sum(s2 > tol))
    out = [u2[:, i].reshape(D, D) for i in range(k)]
    return [(M + M.T) / 2 for M in out]


def L_operator_full(alg, W):
    """D^2 x D^2 matrix of H -> W o H on all of Sym(Lambda^2), vectorised."""
    c = alg.c
    K1 = np.einsum('agd,ge,bez->abdz', c, W, c, optimize=True)
    K2 = np.einsum('agd,dz,bez->abge', c, W, c, optimize=True)
    D = alg.D
    Ksharp = 0.5 * (K1 + K2)
    # anticommutator part: (W H + H W)/2 -> coefficient tensor
    I = np.eye(D)
    Kanti = 0.5 * (np.einsum('ad,bz->abdz', W, I, optimize=True)
                   + np.einsum('az,bd->abdz', I, W, optimize=True))
    # symmetrise the second slot in (d,z) since H is symmetric
    K = Ksharp + Kanti
    K = 0.5 * (K + K.transpose(0, 1, 3, 2))
    return K.reshape(D * D, D * D)


def L_on_basis(alg, W, basis):
    D = alg.D
    Bm = np.array([b.ravel() for b in basis]).T        # D^2 x k
    Lop = L_operator_full(alg, W)
    Y = Lop @ Bm
    A = Bm.T @ Y
    err = np.abs(Y - Bm @ A).max()
    return A, err
