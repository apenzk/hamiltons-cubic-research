"""r207 shared setup, mod p: W_0 from CP^2, Weyl_5 as the module it generates,
the so(5) action in that basis, and the Casimir on Sym^3 -- nothing imported
from the repository."""
import numpy as np, itertools

P = 46337
PAIRS = list(itertools.combinations(range(5), 2))
PIDX = {p: k for k, p in enumerate(PAIRS)}

def wedge(i, j):
    v = np.zeros(10, dtype=np.int64)
    if i == j: return v
    s = 1
    if i > j: i, j, s = j, i, -1
    v[PIDX[(i, j)]] = s
    return v

w1 = wedge(0,1) + wedge(2,3); w2 = wedge(0,2) - wedge(1,3); w3 = wedge(0,3) + wedge(1,2)
SHAT = 2*np.outer(w1,w1) - np.outer(w2,w2) - np.outer(w3,w3)

def lam2_alg(a, b):
    X = np.zeros((5,5), dtype=np.int64); X[a,b] = 1; X[b,a] = -1
    L = np.zeros((10,10), dtype=np.int64)
    for c,(i,j) in enumerate(PAIRS):
        v = np.zeros(10, dtype=np.int64)
        for k in range(5):
            if X[k,i]: v += X[k,i]*wedge(k, j)
            if X[k,j]: v += X[k,j]*wedge(i, k)
        L[:, c] = v
    return L
GENS = [lam2_alg(a,b) for a,b in PAIRS]

def lam2_grp(g):
    """Lambda^2(g) as a 10x10 matrix, entries mod P (g integer mod P)."""
    L = np.empty((10,10), dtype=np.int64)
    for a,(i,j) in enumerate(PAIRS):
        for b,(k,l) in enumerate(PAIRS):
            L[a,b] = (g[i,k]*g[j,l] - g[i,l]*g[j,k]) % P
    return L

def build():
    rows, piv = [], []
    def reduce_add(v):
        v = v.copy() % P
        for r, c in zip(rows, piv):
            if v[c]: v = (v - v[c]*r) % P
        nz = np.nonzero(v)[0]
        if not len(nz): return False
        c = int(nz[0]); v = (v * pow(int(v[c]), P-2, P)) % P
        for k in range(len(rows)):
            if rows[k][c]: rows[k] = (rows[k] - rows[k][c]*v) % P
        rows.append(v); piv.append(c); return True
    def coords(v):
        v = v.copy() % P; out = np.zeros(len(rows), dtype=np.int64)
        for k, (r, c) in enumerate(zip(rows, piv)):
            if v[c]: out[k] = v[c]; v = (v - v[c]*r) % P
        assert not v.any()
        return out
    act = lambda L, A: (L @ A - A @ L) % P
    frontier = [SHAT.ravel() % P]; reduce_add(frontier[0])
    while frontier:
        nxt = []
        for v in frontier:
            A = v.reshape(10,10)
            for L in GENS:
                w = act(L, A).ravel()
                if reduce_add(w): nxt.append(w)
        frontier = nxt
    D = len(rows); assert D == 35
    R = []
    for L in GENS:
        Rm = np.zeros((D, D), dtype=np.int64)
        for k in range(D): Rm[:, k] = coords(act(L, rows[k].reshape(10,10)).ravel())
        R.append(Rm % P)
    return rows, piv, coords, R

def deriv(Rm, T):
    return (np.einsum('ip,pjk->ijk', Rm, T) + np.einsum('jp,ipk->ijk', Rm, T)
            + np.einsum('kp,ijp->ijk', Rm, T)) % P

def make_casimir(R, rows):
    Om = np.zeros((35,35), dtype=np.int64)
    for Rm in R: Om = (Om + Rm @ Rm % P) % P
    kap = int(Om[0,0])
    assert np.array_equal(Om, (kap*np.eye(35, dtype=np.int64)) % P)
    scale_inv = pow(kap * pow(16, P-2, P) % P, P-2, P)      # raw -> c(lambda)
    def cas3(T):
        out = np.zeros_like(T)
        for Rm in R: out = (out + deriv(Rm, deriv(Rm, T))) % P
        return out * scale_inv % P                          # eigenvalues are c(lambda)
    return cas3
