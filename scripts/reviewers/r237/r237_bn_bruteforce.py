"""r237: independent cross-check of dim (Sym^d W_n^*)^{B_n}.

Shares no code with r237_bn_invariants.py.  That script uses characters:
conjugacy classes of B_n as pairs of partitions, and W_n as the Schur functor
S_(2,2) minus Sym^2.  This one builds W_n as an explicit matrix space, enumerates
all 2^n n! signed permutations, forms each group element's matrix on a basis of
W_n, and averages tr Sym^d by Newton.  If the two agree the character route is
right.
"""
import itertools, numpy as np

def weyl_basis(n):
    """basis of W_n inside R^(n^4), by projecting the coordinate tensors."""
    idx = lambda i, j, k, l: ((i * n + j) * n + k) * n + l
    cols = []
    for a in range(n):
        for b in range(n):
            for c in range(n):
                for d in range(n):
                    R = np.zeros((n, n, n, n)); R[a, b, c, d] = 1.0
                    R = 0.25 * (R - R.transpose(1, 0, 2, 3) - R.transpose(0, 1, 3, 2)
                                + R.transpose(1, 0, 3, 2))
                    R = 0.5 * (R + R.transpose(2, 3, 0, 1))
                    R = R - (R + R.transpose(0, 2, 3, 1) + R.transpose(0, 3, 1, 2)) / 3.0
                    g = np.eye(n)
                    Ric = np.einsum('ikjk->ij', R); s = np.trace(Ric)
                    E = Ric - s / n * g
                    KN = lambda A, B: (np.einsum('ik,jl->ijkl', A, B) + np.einsum('jl,ik->ijkl', A, B)
                                       - np.einsum('il,jk->ijkl', A, B) - np.einsum('jk,il->ijkl', A, B))
                    W = R - KN(E, g) / (n - 2) - s / (2 * n * (n - 1)) * KN(g, g)
                    W = 0.5 * (W + W.transpose(2, 3, 0, 1))
                    cols.append(W.reshape(-1))
    M = np.array(cols).T
    u, sv, _ = np.linalg.svd(M, full_matrices=False)
    r = int((sv > sv[0] * 1e-10).sum())
    return u[:, :r]

def act(B, perm, signs, n):
    """signed permutation acting on the 4-tensor, expressed on the basis B."""
    P = np.zeros((n, n))
    for i in range(n):
        P[perm[i], i] = signs[i]
    T = B.T.reshape(-1, n, n, n, n)
    T = np.einsum('ai,bj,ck,dl,tijkl->tabcd', P, P, P, P, T)
    return np.linalg.lstsq(B, T.reshape(len(B.T), -1).T, rcond=None)[0]

def h_d(p, d):
    h = [1.0] + [0.0] * d
    for m in range(1, d + 1):
        h[m] = sum(p[i] * h[m - i] for i in range(1, m + 1)) / m
    return h[d]

for n in (4, 5):
    B = weyl_basis(n)
    print(f"n={n}: dim W_n = {B.shape[1]} (formula {n*(n+1)*(n+2)*(n-3)//12})")
    assert B.shape[1] == n * (n + 1) * (n + 2) * (n - 3) // 12
    DMAX = 3
    tot = [0.0] * (DMAX + 1)
    cnt = 0
    for perm in itertools.permutations(range(n)):
        for signs in itertools.product((1, -1), repeat=n):
            M = act(B, perm, signs, n)
            Mk, ps = np.eye(B.shape[1]), {}
            for k in range(1, DMAX + 1):
                Mk = Mk @ M
                ps[k] = np.trace(Mk)
            for d in range(1, DMAX + 1):
                tot[d] += h_d(ps, d)
            cnt += 1
    print(f"   |B_n| = {cnt} elements enumerated")
    for d in range(1, DMAX + 1):
        v = tot[d] / cnt
        print(f"   dim (Sym^{d} W_{n}^*)^{{B_{n}}} = {v:.6f}  -> {round(v)}")
