"""Claim 4: how much room is there inside 'graded' beyond the enumeration?

A Z2-grading of so(n) is Ad(sigma) for an involution sigma in O(n).  Weyl_n^sigma
is a linear subspace; Q preserves it and Pi_Weyl is O(n)-equivariant, so by the
principle of symmetric criticality the graded critical points with grading sigma
are the sign-feasible critical points of P restricted to Weyl_n^sigma.  Compare
dim Weyl_n^sigma with the H-invariant slice the graded enumeration searches.
"""
import numpy as np
from core111 import Core

def par_split(C, p):
    n = C.n; s = np.array([1.0]*p + [-1.0]*(n-p))
    return np.array([s[i]*s[j] for (i, j) in C.pairs])

def dim_sigma(C, act):
    B = C.weyl_basis()
    A = np.array([b.ravel() for b in B]); Ai = np.array([act(b).ravel() for b in B])
    G = A @ Ai.T; G = 0.5*(G+G.T)
    return int((np.linalg.eigvalsh(G) > 0.5).sum())

def dim_inv(C, hs):
    """dim { X in Weyl_n : [ad(x), X] = 0 for every x in hs }."""
    B = C.weyl_basis(); k = len(B); c = C.struct()
    Bm = np.array([b.ravel() for b in B])
    rows = []
    for x in hs:
        A = np.einsum('g,gba->ab', x, c)
        rows.append(np.array([(A@b - b@A).ravel() for b in B]) @ Bm.T)
    return k - np.linalg.matrix_rank(np.vstack(rows), tol=1e-8)

if __name__ == '__main__':
    rng = np.random.default_rng(3)
    for n in (6, 8):
        C = Core(n); B = C.weyl_basis()
        print("n=%d  dim Weyl_n=%d" % (n, len(B)))
        for p in range(2, n//2+1):
            par = par_split(C, p)
            ds = dim_sigma(C, lambda X, par=par: np.outer(par, par)*X)
            hidx = [a for a in range(C.D) if par[a] > 0]
            hs = [np.eye(C.D)[a] for a in hidx[:4]] + \
                 [np.where(par > 0, rng.standard_normal(C.D), 0.0) for _ in range(3)]
            print("  so(%d)+so(%d): dim h=%2d dim m=%2d  dim Weyl^sigma=%4d  dim H-invariant slice=%d"
                  % (p, n-p, len(hidx), C.D-len(hidx), ds, dim_inv(C, hs)))
        m = n//2; J = np.zeros((n, n))
        for a in range(m):
            J[2*a, 2*a+1] = 1.0; J[2*a+1, 2*a] = -1.0
        Ad = np.zeros((C.D, C.D))
        for a, (i, j) in enumerate(C.pairs):
            X = np.zeros((n, n)); X[i, j] = 1; X[j, i] = -1; Y = J @ X @ J.T
            for b, (k2, l2) in enumerate(C.pairs): Ad[b, a] = Y[k2, l2]
        ds = dim_sigma(C, lambda X: Ad @ X @ Ad.T)
        w, V = np.linalg.eigh(0.5*(Ad+Ad.T)); hs = [V[:, a] for a in range(C.D) if w[a] > 0]
        print("  u(%d):        dim h=%2d dim m=%2d  dim Weyl^sigma=%4d  dim H-invariant slice=%d"
              % (m, len(hs), C.D-len(hs), ds, dim_inv(C, hs[:4] + [sum(rng.standard_normal()*h for h in hs) for _ in range(3)])))
