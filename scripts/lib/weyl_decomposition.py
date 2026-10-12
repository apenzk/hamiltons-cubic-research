import numpy as np
import itertools
from curvature_operator import Lambda2, Q_op

# ---------------------------------------------------------------
# helpers to build Mop (pair-basis operator matrix) from either
# (a) a Bohm-Wilking-diagonal lambda dict, or
# (b) a general 4-tensor callable T(i,j,k,l)
# ---------------------------------------------------------------

def mop_from_4tensor(L2, T):
    N = L2.N
    Mop = np.zeros((N, N))
    for a, (i, j) in enumerate(L2.pairs):
        for b, (k, l) in enumerate(L2.pairs):
            Mop[a, b] = T(i, j, k, l)
    return Mop

def get_entry(Mop, idx, i, j, k, l):
    if i == j or k == l:
        return 0.0
    s1 = 1.0
    if i > j:
        i, j = j, i
        s1 = -1.0
    s2 = 1.0
    if k > l:
        k, l = l, k
        s2 = -1.0
    return s1 * s2 * Mop[idx[(i, j)], idx[(k, l)]]

def ricci_from_mop(L2, Mop):
    n = L2.n
    idx = L2.idx
    Ric = np.zeros((n, n))
    for i in range(n):
        for k in range(n):
            s = 0.0
            for j in range(n):
                s += get_entry(Mop, idx, i, j, k, j)
            Ric[i, k] = s
    return Ric

def weyl_from_mop(L2, Mop):
    n = L2.n
    Ric = ricci_from_mop(L2, Mop)
    S = np.trace(Ric)
    N = L2.N
    Corr = np.zeros((N, N))
    for a, (i, j) in enumerate(L2.pairs):
        for b, (k, l) in enumerate(L2.pairs):
            dij_kl = (Ric[i, k] * (1.0 if j == l else 0.0)
                      - Ric[i, l] * (1.0 if j == k else 0.0)
                      + Ric[j, l] * (1.0 if i == k else 0.0)
                      - Ric[j, k] * (1.0 if i == l else 0.0))
            Corr[a, b] = dij_kl
    Weyl = Mop - Corr / (n - 2) + (S / ((n - 1) * (n - 2))) * np.eye(N)
    return Weyl, Ric, S

def frob(A, B):
    return np.sum(A * B)

def norm(A):
    return np.sqrt(frob(A, A))

def P_value(L2, Mop):
    Q = Q_op(L2, Mop)
    return frob(Mop, Q)

# ---------------------------------------------------------------
# sanity check: weyl of round sphere should vanish identically
# ---------------------------------------------------------------
def test_sphere_weyl_zero(n):
    L2 = Lambda2(n)
    Mop = np.eye(L2.N)
    Weyl, Ric, S = weyl_from_mop(L2, Mop)
    print(f"n={n} sphere: max|Weyl|={np.max(np.abs(Weyl)):.2e}, Ric diag={Ric[0,0]:.4f} (expect {n-1}), S={S:.4f} (expect {n*(n-1)})")

if __name__ == "__main__":
    for n in [4,5,6,7,8]:
        test_sphere_weyl_zero(n)
