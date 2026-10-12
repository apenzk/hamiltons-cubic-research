import numpy as np
from curvature_operator import Lambda2, Q_op
from weyl_decomposition import weyl_from_mop, norm, frob, mop_from_4tensor
from cp2_tensor import cp2_tensor

def mop_cp2_plus_a(L2, a):
    n = L2.n
    T, J = cp2_tensor(n)  # zero outside block {0,1,2,3}
    Mop = mop_from_4tensor(L2, T)
    for idx_pair, (i, j) in enumerate(L2.pairs):
        if i >= 4 and j >= 4:
            Mop[idx_pair, idx_pair] += a
    return Mop

def Pnorm_for_a(L2, a):
    Mop = mop_cp2_plus_a(L2, a)
    Weyl, Ric, S = weyl_from_mop(L2, Mop)
    nv = norm(Weyl)
    if nv < 1e-10:
        return None
    Q = Q_op(L2, Weyl)
    Pv = frob(Weyl, Q)
    return Pv / nv**3

def scan(n, avals):
    L2 = Lambda2(n)
    results = []
    for a in avals:
        p = Pnorm_for_a(L2, a)
        results.append((a, p))
    return results

if __name__ == "__main__":
    for n in [8, 10]:
        print(f"--- n={n} ---")
        avals = np.linspace(-1, 4, 26)
        res = scan(n, avals)
        for a, p in res:
            print(f"  a={a:6.3f}  P_norm={p}")
