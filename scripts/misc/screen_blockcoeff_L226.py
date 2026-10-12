# Does the Lean blockCoeff rebuild the operator the screen validated? Seconds.
import sys, itertools, numpy as np
import os; sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'lib'))
from curvature_operator import Lambda2, Q_op
rng = np.random.default_rng(3)
def sym(k): A = rng.normal(size=(k, k)); return (A + A.T) / 2
def eps(p, q, x):
    return np.linalg.det(np.array([np.eye(3)[p], np.eye(3)[q], np.eye(3)[x]]))
def coeff(S, M, K, i, j, k, l):   # i = ('l', p) or ('r', a), mirroring the Lean match
    t = (i[0], j[0], k[0], l[0])
    if t == ('l','l','l','l'):
        return sum(eps(i[1], j[1], x) * eps(k[1], l[1], y) * S[x, y] for x in range(3) for y in range(3))
    if t == ('l','r','l','r'): return M[j[1]][i[1], k[1]] if j[1] == l[1] else 0
    if t == ('r','l','l','r'): return -M[i[1]][j[1], k[1]] if i[1] == l[1] else 0
    if t == ('l','r','r','l'): return -M[j[1]][i[1], l[1]] if j[1] == k[1] else 0
    if t == ('r','l','r','l'): return M[i[1]][j[1], l[1]] if i[1] == k[1] else 0
    if t == ('r','r','r','r'):
        a, b, c, d = i[1], j[1], k[1], l[1]
        if a != b and a == c and b == d: return K[a, b]
        if a != b and a == d and b == c: return -K[a, b]
        return 0
    return 0
hodge = {(0, 1): (2, 1.0), (0, 2): (1, -1.0), (1, 2): (0, 1.0)}
for n in (6, 7):
    m = n - 3; S = sym(3); M = [sym(3) for _ in range(m)]; K = sym(m); np.fill_diagonal(K, 0)
    L2 = Lambda2(n)
    tag = lambda x: ('l', x) if x < 3 else ('r', x - 3)
    Wlean = np.zeros((L2.N, L2.N))
    for (i, j) in L2.pairs:
        for (k, l) in L2.pairs:
            Wlean[L2.idx[(i, j)], L2.idx[(k, l)]] = coeff(S, M, K, tag(i), tag(j), tag(k), tag(l))
    W = np.zeros((L2.N, L2.N))
    for p1, (h1, s1) in hodge.items():
        for p2, (h2, s2) in hodge.items(): W[L2.idx[p1], L2.idx[p2]] = s1 * s2 * S[h1, h2]
    for a in range(m):
        for p in range(3):
            for q in range(3): W[L2.idx[(p, a + 3)], L2.idx[(q, a + 3)]] = M[a][p, q]
    for a, b in itertools.combinations(range(m), 2): W[L2.idx[(a + 3, b + 3)], L2.idx[(a + 3, b + 3)]] = K[a, b]
    # antisymmetry of the coefficient in each pair, as the phi expansion needs
    anti = max(abs(coeff(S, M, K, tag(i), tag(j), tag(k), tag(l)) + coeff(S, M, K, tag(j), tag(i), tag(k), tag(l)))
               for i in range(n) for j in range(n) for k in range(n) for l in range(n))
    print(f"n={n}: max|W_lean - W_screen| {np.abs(Wlean - W).max():.2e}, antisymmetry defect {anti:.2e}, symmetric {np.abs(Wlean - Wlean.T).max():.2e}")
n = 6; m = 3; S = sym(3); M = [sym(3) for _ in range(m)]; K = sym(m); np.fill_diagonal(K, 0)
tag = lambda x: ('l', x) if x < 3 else ('r', x - 3)
idx = range(n)
a2 = max(abs(coeff(S, M, K, tag(i), tag(j), tag(k), tag(l)) + coeff(S, M, K, tag(i), tag(j), tag(l), tag(k))) for i in idx for j in idx for k in idx for l in idx)
sw = max(abs(coeff(S, M, K, tag(i), tag(j), tag(k), tag(l)) - coeff(S, M, K, tag(k), tag(l), tag(i), tag(j))) for i in idx for j in idx for k in idx for l in idx)
print(f"all quadruples at n=6: second-pair antisymmetry defect {a2:.2e}, pair-swap symmetry defect {sw:.2e}")
