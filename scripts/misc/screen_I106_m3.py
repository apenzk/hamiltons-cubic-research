# Screen of batch 1 and batch 2 of the I106 m>=3 derivation, seconds.
import sys, itertools, numpy as np
import os; sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'lib'))
from curvature_operator import Lambda2, Q_op
rng = np.random.default_rng(21)
def tl(): A = rng.normal(size=(3, 3)); A = (A + A.T) / 2; return A - np.trace(A) / 3 * np.eye(3)
hodge = {(0, 1): (2, 1.0), (0, 2): (1, -1.0), (1, 2): (0, 1.0)}
def build(n, Xs, K):
    m = len(Xs); t = [-K[a].sum() / 3 for a in range(m)]; Ms = [t[a] * np.eye(3) + Xs[a] for a in range(m)]
    N = sum(Ms); S = N - 0.5 * np.trace(N) * np.eye(3); L2 = Lambda2(n); W = np.zeros((L2.N, L2.N))
    for p1, (h1, s1) in hodge.items():
        for p2, (h2, s2) in hodge.items(): W[L2.idx[p1], L2.idx[p2]] = s1 * s2 * S[h1, h2]
    for a in range(m):
        for p in range(3):
            for q in range(3): W[L2.idx[(p, a + 3)], L2.idx[(q, a + 3)]] = Ms[a][p, q]
    for a, b in itertools.combinations(range(m), 2): W[L2.idx[(a + 3, b + 3)], L2.idx[(a + 3, b + 3)]] = K[a, b]
    return np.sum(W * Q_op(L2, W)), np.sum(W * W), t
def rot():
    Q, _ = np.linalg.qr(rng.normal(size=(3, 3))); return Q
for n in (6, 7):
    m = n - 3; K = rng.normal(size=(m, m)); K = (K + K.T) / 2; np.fill_diagonal(K, 0); Xs = [tl() for _ in range(m)]
    P0, N0, t = build(n, Xs, K); mu = sum(t); beta = lambda a, c: 1.5 * (K[a, c] - t[a] - t[c] - 0.5 * mu)
    a = 0; R = sum(Xs[c] for c in range(m) if c != a); T = sum(Xs[c] @ Xs[c] for c in range(m) if c != a)
    lp = 1.5 * R @ R + 3 * T + 2 * sum(beta(a, c) * Xs[c] for c in range(m) if c != a)
    Y = Xs[a] + R / 2; G = rot(); Y2 = G @ Y @ G.T; Xs2 = list(Xs); Xs2[a] = Y2 - R / 2
    P1, N1, _ = build(n, Xs2, K)
    pred = np.trace(Y2 @ lp) - np.trace(Y @ lp)
    print(f"n={n} batch 1: rotate Y_a: dP trusted {P1 - P0:.10f} predicted {pred:.10f} | dNorm {N1 - N0:.2e}")
    # batch 2: others diagonal in a frame F, align Y_a, value should not drop and theta <= Theta_n
    F = rot(); Xd = [tl()] + [F @ np.diag(v - v.mean()) @ F.T for v in rng.normal(size=(m - 1, 3))]
    P0, N0, t = build(n, Xd, K); mu = sum(t); R = sum(Xd[1:]); T = sum(Xc @ Xc for Xc in Xd[1:])
    lp = 1.5 * R @ R + 3 * T + 2 * sum(beta(0, c) * Xd[c] for c in range(1, m)); Y = Xd[0] + R / 2
    l = np.diag(F.T @ lp @ F); order = np.argsort(np.argsort(-l)); y = np.sort(np.linalg.eigvalsh(Y))[::-1]
    Yal = F @ np.diag(y[order]) @ F.T; Xa = list(Xd); Xa[0] = Yal - R / 2
    P1, N1, _ = build(n, Xa, K); th = lambda P, N: P / N ** 1.5
    Theta = np.sqrt(2 * (n - 1) * (n - 2)) / n if n % 2 == 0 else np.sqrt(2 * (n - 1) * (n - 3) / ((n + 1) * (n - 2)))
    comm = max(np.abs(Xa[i] @ Xa[j] - Xa[j] @ Xa[i]).max() for i in range(m) for j in range(m))
    print(f"n={n} batch 2: P before {P0:.6f} after {P1:.6f} | norm2 {N0:.6f} {N1:.6f} | theta after {th(P1,N1):.6f} <= Theta {Theta:.6f} | max commutator after {comm:.1e}")
