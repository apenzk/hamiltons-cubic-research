"""Reviewer 68 -- independent so(n) / Weyl-block machinery.

Written from scratch for the r68 audit.  No import of any b0_*.py.

Conventions (as in the brief):
  basis phi_{ij} = E_ij - E_ji  (i<j),   <X,Y> = (1/2) tr(X^T Y)
  so {phi_ij} is orthonormal, N = n(n-1)/2.
  c'_{abg} = <[v_a,v_b],v_g>,  T = c'^2.
  theta = sum lam^3 + 3 sum_{a<b<g} T_abg lam_a lam_b lam_g.
"""
import numpy as np
from itertools import combinations


def pairs(n):
    return list(combinations(range(n), 2))


def phi_mats(n):
    P = pairs(n)
    M = np.zeros((len(P), n, n))
    for k, (i, j) in enumerate(P):
        M[k, i, j] = 1.0
        M[k, j, i] = -1.0
    return M


def struct(n):
    """C[p,q,r] = <[phi_p,phi_q],phi_r> in the coordinate-plane basis."""
    M = phi_mats(n)
    N = M.shape[0]
    C = np.zeros((N, N, N))
    # [A,B] = AB - BA ; <X,phi_r> = X[i,j] for r=(i,j) since (1/2)tr(X^T phi_r)=X[i,j]-... check:
    # (1/2)tr(X^T phi_r) = (1/2)(sum_kl X_kl phi_r[k,l]) = (1/2)(X_ij - X_ji) = X_ij for antisym X.
    P = pairs(n)
    for p in range(N):
        A = M[p]
        for q in range(N):
            B = M[q]
            K = A @ B - B @ A
            for r, (i, j) in enumerate(P):
                v = K[i, j]
                if v != 0.0:
                    C[p, q, r] = v
    return C


def cprime(C, V):
    """V columns = eigenvectors in phi basis. Returns c'_{abg}."""
    return np.einsum('pqr,pa,qb,rc->abc', C, V, V, V, optimize=True)


def theta_from(lam, T):
    cube = float(np.sum(lam ** 3))
    tri = 0.5 * float(np.einsum('abg,a,b,g->', T, lam, lam, lam, optimize=True))
    return cube + tri, cube, tri


def blocks(T, lam, tol=1e-9):
    """Return dict with S_mmm,S_mmh,S_mhh,S_hhh and the corresponding theta blocks."""
    neg = lam < -tol
    N = len(lam)
    idx = np.arange(N)
    m = idx[neg]
    h = idx[~neg]
    S = {}
    B = {}
    # count over unordered triples: sum over ordered / 6
    for name, sets in (('mmm', (m, m, m)), ('mmh', (m, m, h)),
                       ('mhh', (m, h, h)), ('hhh', (h, h, h))):
        A, Bb, Cc = sets
        sub = T[np.ix_(A, Bb, Cc)]
        # number of ordered arrangements per unordered triple within this pattern
        k = name.count('m')
        mult = {3: 6, 2: 2, 1: 2, 0: 6}[k]  # ordered triples (a,b,g) matching the pattern per unordered triple
        S[name] = float(np.sum(sub)) / mult
        la, lb, lc = lam[A], lam[Bb], lam[Cc]
        B[name] = 3.0 * float(np.einsum('abg,a,b,g->', sub, la, lb, lc, optimize=True)) / mult
    return S, B, m, h


# ---------- test operators ----------

def diag_operator(n, M):
    """W phi_ij = M[i,j] phi_ij ; returns (N,N) matrix in phi basis."""
    P = pairs(n)
    lam = np.array([M[i, j] for (i, j) in P])
    return np.diag(lam)


def sphere_product(n, p):
    """Weyl operator of S^p x S^{n-p} (both sectional curvature 1), traceless part."""
    M = np.zeros((n, n))
    for i in range(n):
        for j in range(n):
            if i == j:
                continue
            same = (i < p) == (j < p)
            M[i, j] = 1.0 if same else 0.0
    P = pairs(n)
    vals = np.array([M[i, j] for (i, j) in P])
    vals = vals - vals.mean()          # traceless on Lambda^2
    vals = vals / np.linalg.norm(vals)  # unit norm
    return np.diag(vals)


def padded_cp2(n):
    """Nienhaus W_{CP^2}: diag(0,0,0,-1,-1,2)/sqrt6 on Lambda^2(R^4), zero-padded.

    Realised as 2*P_1 - P_2 - P_3 on the self-dual 3-space of Lambda^2(R^4),
    zero on the anti-self-dual part and on all planes meeting {4,...,n-1}.
    """
    P = pairs(n)
    idx = {pq: k for k, pq in enumerate(P)}
    N = len(P)
    sd = []
    for (a, b) in [((0, 1), (2, 3)), ((0, 2), (3, 1)), ((0, 3), (1, 2))]:
        v = np.zeros(N)
        for pr in (a, b):
            i, j = pr
            sgn = 1.0
            if i > j:
                i, j = j, i
                sgn = -1.0
            v[idx[(i, j)]] += sgn / np.sqrt(2)
        sd.append(v)
    sd = np.array(sd)
    W = np.zeros((N, N))
    coef = np.array([2.0, -1.0, -1.0]) / np.sqrt(6.0)
    for c, v in zip(coef, sd):
        W += c * np.outer(v, v)
    return W


def analyse(n, W, C=None, tol=1e-9):
    if C is None:
        C = struct(n)
    lam, V = np.linalg.eigh(W)
    cp = cprime(C, V)
    T = cp ** 2
    th, cube, tri = theta_from(lam, T)
    S, B, m, h = blocks(T, lam, tol)
    N = len(lam)
    d = len(m)
    pos = lam[lam > tol]
    pos_sorted = np.sort(pos)[::-1]
    s = float(pos.sum())
    u = float((pos ** 2).sum())
    v = float((lam[m] ** 2).sum())
    b = float(np.max(np.abs(lam[m]))) if d else 0.0
    lam1 = float(pos_sorted[0]) if len(pos) else 0.0
    h3 = 3.0 / np.sum(1.0 / pos_sorted[:3]) if len(pos) >= 3 else float('nan')
    return dict(n=n, N=N, d=d, lam=lam, V=V, T=T, theta=th, cube=cube, tri=tri,
                S=S, B=B, m=m, h=h, s=s, u=u, v=v, b=b, lam1=lam1, h3=h3,
                rowmarg=np.einsum('abg->a', T), paircap=np.einsum('abg->ab', T))
