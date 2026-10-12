# Screen of two derived formulas for I104, seconds, against the trusted Q at n=6:
# (1) <L_q r, r> = sum_e q_e r_e^2 + sum_triangles sum_{e in tri} q_e r_e' r_e''  for coordinate-diagonal q, r,
# (2) <L_{q1}(q2+q3), q2+q3> = x1(3x2^2+3x3^2-|q2|^2/2-|q3|^2/2) + 2y1(y2y3+z2z3) + 2z1(y2z3+z2y3)
#     for patterns q1 on Q1={i,j,k,l}, q2 on Q2={i,j,m,p}, q3 on Q3={k,l,m,p}.
import sys, itertools, numpy as np
import os; sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'lib'))
from curvature_operator import Lambda2, Q_op
n = 6; L2 = Lambda2(n); rng = np.random.default_rng(4)
def diagW(K):
    W = np.zeros((L2.N, L2.N))
    for (a, b) in L2.pairs: W[L2.idx[(a, b)], L2.idx[(a, b)]] = K[a, b]
    return W
def jordan(A, B): return 0.5 * (Q_op(L2, A + B) - Q_op(L2, A) - Q_op(L2, B))
def rand_hollow():
    K = rng.normal(size=(n, n)); K = (K + K.T) / 2; np.fill_diagonal(K, 0); return K
q = rand_hollow(); r = rand_hollow()
trusted = np.sum(jordan(diagW(q), diagW(r)) * diagW(r))
edges = list(itertools.combinations(range(n), 2))
formula = sum(q[a, b] * r[a, b] ** 2 for a, b in edges)
for a, b, c in itertools.combinations(range(n), 3):
    formula += q[a, b] * r[a, c] * r[b, c] + q[a, c] * r[a, b] * r[b, c] + q[b, c] * r[a, b] * r[a, c]
print(f"(1) <L_q r, r>: trusted {trusted:.12f} formula {formula:.12f}  (no row-sum constraint imposed)")
i, j, k, l, m, p = range(6)
def pattern(Qs, x, y):
    z = -x - y; K = np.zeros((n, n)); a, b, c, d = Qs
    for (u, v), val in [((a, b), x), ((c, d), x), ((a, c), y), ((b, d), y), ((a, d), z), ((b, c), z)]: K[u, v] = K[v, u] = val
    return K, (x, y, z)
x1, y1, x2, y2, x3, y3 = rng.normal(size=6)
K1, (X1, Y1, Z1) = pattern((i, j, k, l), x1, y1); K2, (X2, Y2, Z2) = pattern((i, j, m, p), x2, y2); K3, (X3, Y3, Z3) = pattern((k, l, m, p), x3, y3)
nrm = lambda K: sum(K[a, b] ** 2 for a, b in edges)
s = K2 + K3
trusted2 = np.sum(jordan(diagW(K1), diagW(s)) * diagW(s))
f2 = X1 * (3 * X2 ** 2 + 3 * X3 ** 2 - nrm(K2) / 2 - nrm(K3) / 2) + 2 * Y1 * (Y2 * Y3 + Z2 * Z3) + 2 * Z1 * (Y2 * Z3 + Z2 * Y3)
print(f"(2) <L_q1(q2+q3), q2+q3>: trusted {trusted2:.12f} formula {f2:.12f}")
print(f"    pattern norms 2(x^2+y^2+z^2): {nrm(K1):.6f} vs {2*(X1**2+Y1**2+Z1**2):.6f}; <q1,q2> {np.sum(K1*K2)/2:.6f} vs x1x2 {X1*X2:.6f}")
