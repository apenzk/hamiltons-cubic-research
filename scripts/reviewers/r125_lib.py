"""Reviewer 125 -- independent library. Nothing imported from the repo."""
import numpy as np
from itertools import combinations

def pairs(n):
    return list(combinations(range(n), 2))

def struct(n):
    """c[a,b,g] = <[phi_a,phi_b],phi_g>, phi_ij = E_ij-E_ji, <A,B>=1/2 tr(A^T B)."""
    pr = pairs(n); N = len(pr); pos = {p: k for k, p in enumerate(pr)}
    c = np.zeros((N, N, N))
    for a, (i, j) in enumerate(pr):
        for b, (k, l) in enumerate(pr):
            terms = []
            if j == k: terms.append((1.0, (i, l)))
            if i == k: terms.append((-1.0, (j, l)))
            if j == l: terms.append((-1.0, (i, k)))
            if i == l: terms.append((1.0, (j, k)))
            for co, (p, q) in terms:
                if p == q: continue
                s = 1.0
                if p > q: p, q = q, p; s = -1.0
                c[a, b, pos[(p, q)]] += co * s
    return pr, pos, N, c

def sharp(M, c):
    """(M#)_{ab} = 1/2 sum c_{a mu nu} c_{b rho sig} M_{mu rho} M_{nu sig}."""
    T = np.einsum('amn,mr->arn', c, M, optimize=True)   # a,rho,nu
    return 0.5*np.einsum('arn,brs,ns->ab', T, c, M, optimize=True)

def sharp_ref(M, c):
    """basis-free reference: -1/2 tr(A_a M A_b M)"""
    S = np.einsum('amn,np->amp', c, M, optimize=True)
    return -0.5*np.einsum('amp,bpm->ab', S, S, optimize=True)

def Q(M, c):
    return M @ M + sharp(M, c)

# ---------- tensor <-> operator ----------
def to_tensor(M, pos, n):
    """W[i,j,k,l] = <phi_ij, M phi_kl>, full antisymmetric-pair tensor."""
    W = np.zeros((n, n, n, n))
    for (i, j), a in pos.items():
        for (k, l), b in pos.items():
            v = M[a, b]
            for (ii, jj, s1) in ((i, j, 1), (j, i, -1)):
                for (kk, ll, s2) in ((k, l, 1), (l, k, -1)):
                    W[ii, jj, kk, ll] = s1*s2*v
    return W

def from_tensor(W, pos):
    N = len(pos); M = np.zeros((N, N))
    for (i, j), a in pos.items():
        for (k, l), b in pos.items():
            M[a, b] = W[i, j, k, l]
    return M

# ---------- Weyl space ----------
def weyl_basis(n):
    """Orthonormal basis (as NxN symmetric matrices, flattened over triu) of
    Weyl operators: Sym^2(Lambda^2), first Bianchi, Ricci-flat."""
    pr, pos, N, c = struct(n)
    triu = [(a, b) for a in range(N) for b in range(a, N)]
    tp = {p: k for k, p in enumerate(triu)}
    M_ = len(triu)
    rows = []
    def add(rows_d, a, b, co):
        if a > b: a, b = b, a
        rows_d[tp[(a, b)]] = rows_d.get(tp[(a, b)], 0.0) + co
    def pr_sign(p):
        (x, y) = p
        return (pos[(x, y)], 1.0) if x < y else (pos[(y, x)], -1.0)
    for (i, j, k, l) in combinations(range(n), 4):
        d = {}
        for (p1, p2) in (((i, j), (k, l)), ((i, k), (l, j)), ((i, l), (j, k))):
            a, s1 = pr_sign(p1); b, s2 = pr_sign(p2)
            add(d, a, b, s1*s2)
        r = np.zeros(M_)
        for idx, v in d.items(): r[idx] = v
        rows.append(r)
    # Ricci: Ric_ik = sum_j W_{ijkj}
    for i in range(n):
        for k in range(i, n):
            d = {}
            for j in range(n):
                if j == i or j == k: continue
                a, s1 = pr_sign((i, j)); b, s2 = pr_sign((k, j))
                add(d, a, b, s1*s2)
            r = np.zeros(M_)
            for idx, v in d.items(): r[idx] = v
            rows.append(r)
    A = np.array(rows)
    # careful: triu coords double-count off-diagonal entries in the inner product.
    # Work in the "flat" symmetric-matrix coordinates instead: weight off-diag by sqrt2.
    w = np.array([1.0 if a == b else np.sqrt(2.0) for (a, b) in triu])
    Aw = A / w                      # constraints in orthonormal coords x = w * triu-vals
    U, s, Vt = np.linalg.svd(Aw)
    tol = max(Aw.shape)*s[0]*1e-12
    rank = int((s > tol).sum())
    ns = Vt[rank:]                  # (dim, M_) in orthonormal coords
    mats = []
    for row in ns:
        vals = row / w
        Mx = np.zeros((N, N))
        for kk, (a, b) in enumerate(triu):
            Mx[a, b] = vals[kk]; Mx[b, a] = vals[kk]
        mats.append(Mx)
    return np.array(mats), pr, pos, N, c

def project(M, basis):
    co = np.einsum('kab,ab->k', basis, M)
    nrm = np.einsum('kab,kab->k', basis, basis)
    return np.einsum('k,kab->ab', co/nrm, basis)
