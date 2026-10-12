# Screen of the derived block formula for P on S_J, |J|=3, against the trusted Q_op. Seconds.
import sys, itertools, numpy as np
import os; sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'lib'))
from curvature_operator import Lambda2, Q_op
rng = np.random.default_rng(7)
def sym(k): A = rng.normal(size=(k, k)); return (A + A.T) / 2
def adj3(M): return np.linalg.det(M) * np.linalg.inv(M)
J = [0, 1, 2]
hodge = {(0, 1): (2, 1.0), (0, 2): (1, -1.0), (1, 2): (0, 1.0)}   # phi_pq -> sign * e_h
def assemble(n, S, Ms, K):
    L2 = Lambda2(n); W = np.zeros((L2.N, L2.N)); A = list(range(3, n))
    for p1, (h1, s1) in hodge.items():
        for p2, (h2, s2) in hodge.items():
            W[L2.idx[p1], L2.idx[p2]] = s1 * s2 * S[h1, h2]
    for ai, a in enumerate(A):
        for p in J:
            for q in J:
                W[L2.idx[(p, a)], L2.idx[(q, a)]] = Ms[ai][p, q]
    for ai, a in enumerate(A):
        for bi, b in enumerate(A):
            if a < b: W[L2.idx[(a, b)], L2.idx[(a, b)]] = K[ai, bi]
    return L2, W
def ricci(L2, W, n):
    def ph(x, c):
        return (L2.idx[(x, c)], 1.0) if x < c else (L2.idx[(c, x)], -1.0)
    R = np.zeros((n, n))
    for x in range(n):
        for y in range(n):
            for c in range(n):
                if c in (x, y): continue
                i, si = ph(x, c); j, sj = ph(y, c); R[x, y] += si * sj * W[i, j]
    return R
def formula(S, Ms, K, m, c3=3.0):
    val = np.trace(S @ S @ S) + 3 * np.linalg.det(S)
    val += sum(np.trace(M @ M @ M) + c3 * np.trace(S @ adj3(M)) for M in Ms)
    for a, b in itertools.combinations(range(m), 2):
        val += K[a, b] ** 3 + 3 * K[a, b] * np.trace(Ms[a] @ Ms[b])
    for a, b, c in itertools.combinations(range(m), 3):
        val += 3 * K[a, b] * K[a, c] * K[b, c]
    return val
for n in (6, 7):
    m = n - 3
    S = sym(3); Ms = [sym(3) for _ in range(m)]; K = sym(m); np.fill_diagonal(K, 0)
    L2, W = assemble(n, S, Ms, K)
    P = np.sum(W * Q_op(L2, W))
    print(f"n={n} general block op: P trusted {P:.12f} formula {formula(S, Ms, K, m):.12f} null(c3=2) {formula(S, Ms, K, m, 2.0):.6f}")
    RJ = ricci(L2, assemble(n, S, [np.zeros((3, 3))] * m, np.zeros((m, m)))[1], n)[:3, :3]
    print(f"  Ric(R_J) - ((tr S)I - S) residual {np.abs(RJ - (np.trace(S) * np.eye(3) - S)).max():.2e}")
    # Weyl-constrained element: outer trace condition and R_J fixed by N
    Ms = [sym(3) for _ in range(m)]; K = sym(m); np.fill_diagonal(K, 0)
    Ms = [M - (np.trace(M) + K[ai].sum()) / 3 * np.eye(3) for ai, M in enumerate(Ms)]
    N = sum(Ms); S = N - 0.5 * np.trace(N) * np.eye(3)
    L2, W = assemble(n, S, Ms, K)
    print(f"  Weyl element: max|Ric| {np.abs(ricci(L2, W, n)).max():.2e}  P trusted {np.sum(W * Q_op(L2, W)):.12f} formula {formula(S, Ms, K, m):.12f}")
