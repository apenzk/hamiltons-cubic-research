"""Reviewer 181, claim 1c: verify coset_weyl_char by EXPLICIT MATRICES.

coset_weyl_char is the only W-specific input to the coset integral.  It is built
from Newton identities on the virtual identity W = Sym^2(Lambda^2 V) - Lambda^4 V
- Sym^2 V.  Here W_n is instead constructed as an actual subspace -- symmetric,
first-Bianchi, Ricci-traceless -- of Lambda^2 (x) Lambda^2, and the character is
the honest trace of the induced action of a genuine element of O(n)^-.

Nothing is shared with the Newton route except the group element itself.
"""
import sys, os
import numpy as np
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'r180'))
from coset_o import coset_weyl_char

def coset_element(thetas):
    """diag(R(th_1),...,R(th_m), 1, -1) in O(2m+2)^-."""
    m = len(thetas); n = 2*m+2
    g = np.zeros((n, n))
    for j, th in enumerate(thetas):
        c, s = np.cos(th), np.sin(th)
        g[2*j, 2*j] = c; g[2*j, 2*j+1] = -s
        g[2*j+1, 2*j] = s; g[2*j+1, 2*j+1] = c
    g[n-2, n-2] = 1.0
    g[n-1, n-1] = -1.0
    return g

def lam2(g):
    n = g.shape[0]
    pairs = [(i, j) for i in range(n) for j in range(i+1, n)]
    idx = {p: a for a, p in enumerate(pairs)}
    N = len(pairs)
    M = np.zeros((N, N))
    for a, (i, j) in enumerate(pairs):
        for b, (k, l) in enumerate(pairs):
            M[a, b] = g[i, k]*g[j, l] - g[i, l]*g[j, k]
    return M, pairs, idx

def weyl_basis(n):
    """Orthonormal basis of W_n inside Sym^2(Lambda^2), in scaled coordinates."""
    pairs = [(i, j) for i in range(n) for j in range(i+1, n)]
    idx = {}
    for a, (i, j) in enumerate(pairs):
        idx[(i, j)] = (a, 1.0); idx[(j, i)] = (a, -1.0)
    N = len(pairs)
    # symmetric coordinates z_{ab}, a<=b, scaled so Euclidean = Frobenius
    scoord = [(a, b) for a in range(N) for b in range(a, N)]
    sidx = {p: c for c, p in enumerate(scoord)}
    D = len(scoord)
    def put(row, a, b, val):
        """add val to the coefficient of X[a][b] (and X[b][a]) in scaled coords"""
        if a > b: a, b = b, a
        w = 1.0 if a == b else 1.0/np.sqrt(2.0)   # X_ab = z_ab * w
        row[sidx[(a, b)]] += val*w

    rows = []
    # first Bianchi: R_{ijkl} + R_{iklj} + R_{iljk} = 0 for i<j<k<l
    from itertools import combinations
    for i, j, k, l in combinations(range(n), 4):
        row = np.zeros(D)
        for p, u in [((i, j), (k, l)), ((i, k), (l, j)), ((i, l), (j, k))]:
            a, sa = idx[p]; b, sb = idx[u]
            put(row, a, b, sa*sb)
        rows.append(row)
    # Ricci trace: sum_i R_{i j i l} = 0 for j<=l
    for j in range(n):
        for l in range(j, n):
            row = np.zeros(D)
            for i in range(n):
                if i == j or i == l: continue
                a, sa = idx[(i, j)]; b, sb = idx[(i, l)]
                put(row, a, b, sa*sb)
            rows.append(row)
    C = np.array(rows)
    u, s, vt = np.linalg.svd(C, full_matrices=True)
    tol = max(C.shape)*s[0]*1e-12
    rank = int((s > tol).sum())
    B = vt[rank:].T          # D x (D-rank), orthonormal columns
    return B, scoord, sidx, N

def char_from_matrix(n, thetas, kmax):
    g = coset_element(thetas)
    B, scoord, sidx, N = weyl_basis(n)
    D = B.shape[0]; dW = B.shape[1]
    # unscale: basis vector -> full NxN symmetric matrix
    def to_full(v):
        X = np.zeros((N, N))
        for c, (a, b) in enumerate(scoord):
            if a == b: X[a, a] = v[c]
            else:
                X[a, b] = X[b, a] = v[c]/np.sqrt(2.0)
        return X
    Xs = np.stack([to_full(B[:, t]) for t in range(dW)])
    out = []
    gk = np.eye(n)
    for k in range(1, kmax+1):
        gk = gk @ g
        M, _, _ = lam2(gk)
        tr = float(np.einsum('tab,ac,tcd,bd->', Xs, M, Xs, M, optimize=True))
        out.append(tr)
    return dW, out

def char_from_newton(r, thetas, kmax):
    P = coset_weyl_char(r, kmax)
    out = []
    for k in range(1, kmax+1):
        s = 0j
        for w, c in P[k].items():
            s += c*np.exp(1j*sum(wi*th for wi, th in zip(w, thetas)))
        out.append(s)
    return out

if __name__ == '__main__':
    rng = np.random.default_rng(181)
    for n in ([8, 12] if len(sys.argv) < 2 else [int(sys.argv[1])]):
        r = n//2; m = r-1
        thetas = list(rng.uniform(0.3, 2.7, size=m))
        kmax = 6
        dW, tm = char_from_matrix(n, thetas, kmax)
        tn = char_from_newton(r, thetas, kmax)
        dim_pred = n*n*(n*n-1)//12 - n*(n+1)//2   # dim R - dim Sym^2 V
        print('n=%2d  dim of the constructed Weyl space = %d  (formula %d)  %s'
              % (n, dW, dim_pred, 'OK' if dW == dim_pred else '*** MISMATCH ***'))
        worst = 0.0
        for k in range(kmax):
            err = abs(tm[k] - tn[k])
            worst = max(worst, err)
            print('   chi_W(g^%d):  matrix %+14.8f    Newton %+14.8f%+14.8fi   |diff| %.2e'
                  % (k+1, tm[k], tn[k].real, tn[k].imag, err))
        print('   worst discrepancy over k=1..%d : %.3e   %s\n'
              % (kmax, worst, 'AGREE' if worst < 1e-6 else '*** DISAGREE ***'))

# --------------------------------------------------------------------------
# companion: the SAME explicit construction against wtlib.char_weyl, i.e. the
# character on the IDENTITY component's torus, which feeds the SO(n) half.
def so_element(thetas):
    m = len(thetas); n = 2*m
    g = np.zeros((n, n))
    for j, th in enumerate(thetas):
        c, s = np.cos(th), np.sin(th)
        g[2*j, 2*j] = c; g[2*j, 2*j+1] = -s
        g[2*j+1, 2*j] = s; g[2*j+1, 2*j+1] = c
    return g

def check_so_char(n, kmax=6, seed=1812):
    from wtlib import char_weyl
    r = n//2
    rng = np.random.default_rng(seed)
    thetas = list(rng.uniform(0.3, 2.7, size=r))
    g = so_element(thetas)
    B, scoord, sidx, N = weyl_basis(n)
    dW = B.shape[1]
    def to_full(v):
        X = np.zeros((N, N))
        for c, (a, b) in enumerate(scoord):
            if a == b: X[a, a] = v[c]
            else: X[a, b] = X[b, a] = v[c]/np.sqrt(2.0)
        return X
    Xs = np.stack([to_full(B[:, t]) for t in range(dW)])
    ch = char_weyl(r, False)
    print('n=%2d  SO-torus check, dim W = %d' % (n, dW))
    worst = 0.0
    gk = np.eye(n)
    for k in range(1, kmax+1):
        gk = gk @ g
        M, _, _ = lam2(gk)
        tm = float(np.einsum('tab,ac,tcd,bd->', Xs, M, Xs, M, optimize=True))
        tn = sum(c*np.exp(1j*k*sum(wi*th for wi, th in zip(w, thetas))) for w, c in ch.items())
        worst = max(worst, abs(tm-tn))
        print('   chi_W(g^%d): matrix %+14.8f   char_weyl %+14.8f   |diff| %.2e' % (k, tm, tn.real, abs(tm-tn)))
    print('   worst %.3e  %s' % (worst, 'AGREE' if worst < 1e-6 else '*** DISAGREE ***'))
