"""r285 Claim 1: the gradient identity grad P = 3 Q(W), from the definitions.

Independent implementation.  Basis of Lambda^2 R^n: phi_{ij}=E_ij-E_ji, i<j,
inner product <X,Y> = (1/2) tr(X^T Y), so {phi_a} is orthonormal.
c[a,b,g] = <[phi_a,phi_b],phi_g>  (totally antisymmetric).
Two independent formulas for #:
    (i)  (X#Y)_{ab} = -(1/2) tr(A_a X A_b Y),  (A_a)_{mn}=c[a,m,n]
    (ii) (X#Y)_{ab} = (1/2) c[a,p,q] c[b,r,s] X_{pr} Y_{qs}
Q(W) = W^2 + W#,  P(W) = <W,Q(W)> = tr(W Q(W)).
"""
import numpy as np
from itertools import combinations

def struct(n):
    pr = list(combinations(range(n), 2))
    N = len(pr)
    phi = np.zeros((N, n, n))
    for a, (i, j) in enumerate(pr):
        phi[a, i, j] = 1.0
        phi[a, j, i] = -1.0
    comm = np.einsum('aij,bjk->abik', phi, phi) - np.einsum('bij,ajk->abik', phi, phi)
    c = 0.5 * np.einsum('abij,gij->abg', comm, phi)
    return pr, N, c

def sharp_i(c, X, Y):
    """-(1/2) tr(A_a X A_b Y), symmetrized."""
    A = c  # A[a,m,n] = c[a,m,n]
    U = np.einsum('amn,np->amp', A, X)
    V = np.einsum('bpq,qm->bpm', A, Y)
    M = -0.5 * np.einsum('amp,bpm->ab', U, V)
    return 0.5 * (M + M.T)

def sharp_ii(c, X, Y):
    M = 0.5 * np.einsum('apq,brs,pr,qs->ab', c, c, X, Y, optimize=True)
    return 0.5 * (M + M.T)

def Q(c, W):
    return W @ W + sharp_i(c, W, W)

def P(c, W):
    return float(np.trace(W @ Q(c, W)))

# ---- Weyl space: Bianchi + Ricci-flat, built independently -----------------
def weyl_basis(n):
    pr, N, c = struct(n)
    idx = {p: k for k, p in enumerate(pr)}
    tidx = {}
    t = 0
    for a in range(N):
        for b in range(a, N):
            tidx[(a, b)] = t; t += 1
    T = t
    def put(row, a, b, v):
        if a > b: a, b = b, a
        row[tidx[(a, b)]] += v * (1.0 if a == b else 1.0/np.sqrt(2.0))
    def addR(row, i, j, k, l, coef):
        if i == j or k == l: return
        s = 1.0
        if i > j: i, j, s = j, i, -s
        if k > l: k, l, s = l, k, -s
        put(row, idx[(i, j)], idx[(k, l)], coef*s)
    rows = []
    for (i, j, k, l) in combinations(range(n), 4):
        row = np.zeros(T)
        addR(row, i, j, k, l, 1.0); addR(row, i, k, l, j, 1.0); addR(row, i, l, j, k, 1.0)
        rows.append(row)
    for i in range(n):
        for k in range(i, n):
            row = np.zeros(T)
            for j in range(n):
                addR(row, i, j, k, j, 1.0)
            rows.append(row)
    Cm = np.array(rows)
    u, s, vt = np.linalg.svd(Cm)
    rank = int((s > 1e-9*s.max()).sum())
    Ns = vt[rank:]
    B = []
    for r in Ns:
        W = np.zeros((N, N))
        for (a, b), t2 in tidx.items():
            if a == b: W[a, a] = r[t2]
            else: W[a, b] = W[b, a] = r[t2]/np.sqrt(2.0)
        B.append(W)
    return np.array(B), c, N

def proj(B, X):
    co = np.einsum('kab,ab->k', B, X)
    return np.einsum('k,kab->ab', co, B)

if __name__ == "__main__":
    rng = np.random.default_rng(285)
    for n in (5, 6):
        pr, N, c = struct(n)
        print(f"=== n={n}, N={N} ===")
        # total antisymmetry of c
        print("  c antisym (a<->b):", np.abs(c + np.transpose(c, (1,0,2))).max(),
              " (b<->g):", np.abs(c + np.transpose(c, (0,2,1))).max())
        # two # formulas agree
        X = rng.standard_normal((N,N)); X = X+X.T
        Y = rng.standard_normal((N,N)); Y = Y+Y.T
        Z = rng.standard_normal((N,N)); Z = Z+Z.T
        print("  sharp formula (i) vs (ii):", np.abs(sharp_i(c,X,Y)-sharp_ii(c,X,Y)).max())
        # full trilinear symmetry of T(X,Y,Z) = <X#Y, Z>
        def T(A,Bm,C): return float(np.sum(sharp_i(c,A,Bm)*C))
        vals = [T(X,Y,Z), T(Y,X,Z), T(X,Z,Y), T(Z,Y,X), T(Y,Z,X), T(Z,X,Y)]
        print("  trilinear values:", ["%.12f"%v for v in vals],
              " spread:", max(vals)-min(vals))
