import numpy as np
from curvature_operator import Lambda2, Q_op
from weyl_decomposition import weyl_from_mop, P_value, norm, frob

def sphere_product_mop(L2, p):
    n = L2.n
    q = n - p
    N = L2.N
    Mop = np.zeros((N, N))
    for a, (i, j) in enumerate(L2.pairs):
        same_block = (i < p and j < p) or (i >= p and j >= p)
        if same_block:
            Mop[a, a] = 1.0
    return Mop

def hand_formula_P(n, p):
    q = n - p
    t = p - 1
    u = q - 1
    S = t * t + t + u * u + u
    denom1 = (t + u)          # n-2
    denom2 = (t + u + 1) * (t + u)  # (n-1)(n-2)
    sigma = S / denom2
    w11 = 1 - 2 * t / denom1 + sigma
    w22 = 1 - 2 * u / denom1 + sigma
    w12 = -1 + sigma
    from math import comb
    sum_cubes = comb(p, 2) * w11**3 + comb(q, 2) * w22**3 + p * q * w12**3
    tri = (comb(p, 3) * w11**3
           + comb(p, 2) * q * w11 * w12**2
           + p * comb(q, 2) * w22 * w12**2
           + comb(q, 3) * w22**3)
    P_raw = sum_cubes + 3 * tri
    normsq = comb(p, 2) * w11**2 + comb(q, 2) * w22**2 + p * q * w12**2
    return P_raw / normsq**1.5, w11, w22, w12

def code_P(n, p):
    L2 = Lambda2(n)
    Mop = sphere_product_mop(L2, p)
    Weyl, Ric, S = weyl_from_mop(L2, Mop)
    print(f"  [check] n={n},p={p}: Ricci trace-free? max|Ric(Weyl-implied)|... S(Weyl-Ricci) computed inside weyl_from_mop already used")
    Pv = P_value(L2, Weyl)
    nv = norm(Weyl)
    return Pv / nv**3

if __name__ == "__main__":
    for n in [6, 7, 8, 9]:
        for p in range(2, n - 1):
            q = n - p
            hp, w11, w22, w12 = hand_formula_P(n, p)
            cp = code_P(n, p)
            print(f"n={n} p={p} q={q}: hand={hp:.6f} code={cp:.6f} diff={abs(hp-cp):.2e}")
