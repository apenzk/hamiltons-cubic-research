# Screens for I106, seconds each: (1) batch 1's traceless formula and batch 3's odd quadratic form
# against the trusted Q_op; (2) a bounded random-restart ascent of P/|W|^3 on S_J cap W_n at n = 5, 6, 7
# with the commutator of the blocks at the best point, and the value against Theta_n.
import sys, itertools, numpy as np
import os; sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'lib'))
from curvature_operator import Lambda2, Q_op
rng = np.random.default_rng(11)
hodge = {(0, 1): (2, 1.0), (0, 2): (1, -1.0), (1, 2): (0, 1.0)}
def sym(k): A = rng.normal(size=(k, k)); return (A + A.T) / 2
def assemble(L2, n, S, Ms, K):
    W = np.zeros((L2.N, L2.N)); A = list(range(3, n))
    for p1, (h1, s1) in hodge.items():
        for p2, (h2, s2) in hodge.items(): W[L2.idx[p1], L2.idx[p2]] = s1 * s2 * S[h1, h2]
    for ai, a in enumerate(A):
        for p in range(3):
            for q in range(3): W[L2.idx[(p, a)], L2.idx[(q, a)]] = Ms[ai][p, q]
    for ai, a in enumerate(A):
        for bi, b in enumerate(A):
            if a < b: W[L2.idx[(a, b)], L2.idx[(a, b)]] = K[ai, bi]
    return W
def weyl_from(Ms, K):
    m = len(Ms); Ms = [M - (np.trace(M) + K[a].sum()) / 3 * np.eye(3) for a, M in enumerate(Ms)]
    N = sum(Ms); S = N - 0.5 * np.trace(N) * np.eye(3); return S, Ms
def P_formula(S, Ms, K):
    m = len(Ms); val = np.trace(S @ S @ S) + 3 * np.linalg.det(S)
    val += sum(np.trace(M @ M @ M) + 3 * np.trace(S @ (np.linalg.det(M) * np.linalg.inv(M) if abs(np.linalg.det(M)) > 1e-12 else adj3(M))) for M in Ms)
    for a, b in itertools.combinations(range(m), 2): val += K[a, b] ** 3 + 3 * K[a, b] * np.trace(Ms[a] @ Ms[b])
    for a, b, c in itertools.combinations(range(m), 3): val += 3 * K[a, b] * K[a, c] * K[b, c]
    return val
def adj3(M):
    C = np.zeros((3, 3))
    for i in range(3):
        for j in range(3):
            minor = np.delete(np.delete(M, j, 0), i, 1); C[i, j] = (-1) ** (i + j) * np.linalg.det(minor)
    return C
def P_traceless(Ms, K):
    m = len(Ms); ms = [np.trace(M) / 3 for M in Ms]; Xs = [M - t * np.eye(3) for M, t in zip(Ms, ms)]
    mu = sum(ms); C = lambda a, b, c: np.trace(Xs[a] @ Xs[b] @ Xs[c]); G = lambda a, b: np.trace(Xs[a] @ Xs[b])
    val = 6 * sum(C(a, a, a) for a in range(m)) + 9 * sum(C(a, a, b) for a in range(m) for b in range(m) if a != b)
    val += 12 * sum(C(a, b, c) for a, b, c in itertools.combinations(range(m), 3))
    val += 1.5 * sum((K[a, b] - ms[a] - ms[b] - 0.5 * mu) * G(a, b) for a in range(m) for b in range(m) if a != b)
    val += -0.75 * mu ** 3 + 3 * sum(t ** 3 for t in ms) - 4.5 * mu * sum(t ** 2 for t in ms)
    val += sum(9 * K[a, b] * ms[a] * ms[b] + K[a, b] ** 3 for a, b in itertools.combinations(range(m), 2))
    val += 3 * sum(K[a, b] * K[a, c] * K[b, c] for a, b, c in itertools.combinations(range(m), 3))
    norm2 = sum(G(a, b) for a in range(m) for b in range(m) if a != b) + 2 * sum(G(a, a) for a in range(m))
    norm2 += 0.75 * mu ** 2 + 3 * sum(t ** 2 for t in ms) + sum(K[a, b] ** 2 for a, b in itertools.combinations(range(m), 2))
    return val, norm2
def norm2_blocks(S, Ms, K):
    m = len(Ms); return np.sum(S * S) + sum(np.sum(M * M) for M in Ms) + sum(K[a, b] ** 2 for a, b in itertools.combinations(range(m), 2))
def odd_form(S, Ms, K):
    # batch 3: 3T(E,O,O) from the formula, with E the epsilon_1-even part and O the odd row entries
    m = len(Ms); sig = S[0, 0]; Sp = S[1:, 1:]; s = S[0, 1:]; Sp0 = Sp - 0.5 * np.trace(Sp) * np.eye(2)
    val = 3 * sig * s @ s + 6 * s @ Sp0 @ s
    for a in range(m):
        mu = Ms[a][0, 0]; Mp = Ms[a][1:, 1:]; x = Ms[a][0, 1:]; adjMp = np.trace(Mp) * np.eye(2) - Mp
        val += 3 * mu * x @ x + 3 * x @ Mp @ x + 3 * x @ (Sp - np.trace(Sp) * np.eye(2)) @ x - 6 * s @ adjMp @ x
    for a, b in itertools.combinations(range(m), 2): val += 6 * K[a, b] * Ms[a][0, 1:] @ Ms[b][0, 1:]
    return val
def even_part(S, Ms):
    E_S = S.copy(); E_S[0, 1:] = 0; E_S[1:, 0] = 0
    E_M = []
    for M in Ms:
        E = M.copy(); E[0, 1:] = 0; E[1:, 0] = 0; E_M.append(E)
    return E_S, E_M
print("== screen 1: formulas against trusted Q ==")
for n in (5, 6, 7):
    m = n - 3; L2 = Lambda2(n); K = sym(m); np.fill_diagonal(K, 0); S, Ms = weyl_from([sym(3) for _ in range(m)], K)
    W = assemble(L2, n, S, Ms, K); P = np.sum(W * Q_op(L2, W)); Pt, n2t = P_traceless(Ms, K)
    ES, EM = even_part(S, Ms); PE = P_formula(ES, EM, K)
    print(f"n={n}: P trusted {P:.10f} traceless {Pt:.10f} | norm2 blocks {norm2_blocks(S, Ms, K):.10f} traceless {n2t:.10f} | P(W)-P(E) {P - PE:.10f} odd form {odd_form(S, Ms, K):.10f}")
def theta_c(n):
    return np.sqrt(2 * (n - 1) * (n - 2)) / n if n % 2 == 0 else np.sqrt(2 * (n - 1) * (n - 3) / ((n + 1) * (n - 2)))
def P_m2(X1, X2, m):
    U = X1 + X2; V = X1 - X2
    return 3.75 * np.trace(U @ U @ U) + 2.25 * np.trace(U @ V @ V) - 4.5 * m * np.sum(U * U) + 4.5 * m * np.sum(V * V) - 72 * m ** 3, 1.5 * np.sum(U * U) + 0.5 * np.sum(V * V) + 18 * m ** 2
L2 = Lambda2(5); mm = 0.3; X1 = sym(3); X1 -= np.trace(X1) / 3 * np.eye(3); X2 = sym(3); X2 -= np.trace(X2) / 3 * np.eye(3)
Ms = [mm * np.eye(3) + X1, mm * np.eye(3) + X2]; K = np.array([[0, -3 * mm], [-3 * mm, 0.0]]); S = sum(Ms) - 0.5 * np.trace(sum(Ms)) * np.eye(3)
W = assemble(L2, 5, S, Ms, K); Pm2, n2m2 = P_m2(X1, X2, mm)
print(f"batch 4 at n=5: P trusted {np.sum(W * Q_op(L2, W)):.10f} U,V formula {Pm2:.10f} | norm2 {norm2_blocks(S, Ms, K):.10f} formula {n2m2:.10f}")
print("== screen 3: for random Weyl E in S_23, the pencil (3T(E,.,.), |O|^2) on (R^2)^m: top eigenvector rank, and sup_t of the split ratio against Theta_n ==")
def pencil(ES, EM, K):
    m = len(EM); d = 2 * m; Mq = np.zeros((d, d)); Nq = np.zeros((d, d))
    def odd_from(v):
        S = ES.copy(); Ms = [M.copy() for M in EM]
        for a in range(m): Ms[a][0, 1:] = v[2 * a:2 * a + 2]; Ms[a][1:, 0] = v[2 * a:2 * a + 2]
        s = sum(v[2 * a:2 * a + 2] for a in range(m)); S[0, 1:] = s; S[1:, 0] = s; return S, Ms
    for i in range(d):
        for j in range(d):
            ei = np.eye(d)[i]; ej = np.eye(d)[j]
            f = lambda v: odd_form(*odd_from(v), K)
            g = lambda v: norm2_blocks(*odd_from(v), K) - norm2_blocks(ES, EM, K)
            Mq[i, j] = (f(ei + ej) - f(ei) - f(ej)) / 2; Nq[i, j] = (g(ei + ej) - g(ei) - g(ej)) / 2
    w, v = np.linalg.eigh(np.linalg.solve(np.linalg.cholesky(Nq), np.linalg.solve(np.linalg.cholesky(Nq), Mq).T))
    lam = w[-1]; top = np.linalg.solve(np.linalg.cholesky(Nq).T, v[:, -1]); sv = np.linalg.svd(top.reshape(m, 2), compute_uv=False)
    return lam, sv
for n in (5, 6, 7):
    m = n - 3; worst = 0
    for trial in range(30):
        K = sym(m); np.fill_diagonal(K, 0); S, Ms = weyl_from([sym(3) for _ in range(m)], K); ES, EM = even_part(S, Ms)
        lam, sv = pencil(ES, EM, K); PE = P_formula(ES, EM, K); E2 = norm2_blocks(ES, EM, K)
        t = np.linspace(0, 50 * E2, 20001); ratio = np.max((PE + lam * t) / (E2 + t) ** 1.5) / theta_c(n)
        worst = max(worst, ratio)
        if trial < 3: print(f"n={n} trial {trial}: top eigenvector singular values {np.round(sv / sv[0], 4)}, sup_t ratio / Theta_n = {ratio:.6f}")
    print(f"n={n}: worst sup_t ratio / Theta_n over 30 random E: {worst:.6f}")
print("== screen 2: bounded ascent on S_J cap W_n, 3 restarts, projected gradient by finite differences of the formula ==")
def pack(Ms, K):
    m = len(Ms); v = [M[np.triu_indices(3)] for M in Ms] + [K[np.triu_indices(m, 1)]]; return np.concatenate(v)
def unpack(v, m):
    Ms = []; k = 0
    for a in range(m):
        M = np.zeros((3, 3)); M[np.triu_indices(3)] = v[k:k + 6]; M = M + M.T - np.diag(np.diag(M)); Ms.append(M); k += 6
    K = np.zeros((m, m)); K[np.triu_indices(m, 1)] = v[k:]; K = K + K.T
    return Ms, K
def theta_of(v, m):
    Ms, K = unpack(v, m); S, Ms = weyl_from(Ms, K); return P_formula(S, Ms, K) / norm2_blocks(S, Ms, K) ** 1.5
def ascend(v, m, steps=400, h=1e-6):
    f = theta_of(v, m); step = 0.05
    for _ in range(steps):
        g = np.array([(theta_of(v + h * e, m) - f) / h for e in np.eye(len(v))])
        while step > 1e-9:
            v2 = v + step * g / (np.linalg.norm(g) + 1e-15); f2 = theta_of(v2, m)
            if f2 > f: v, f = v2, f2; step *= 1.2; break
            step *= 0.5
        if step <= 1e-9: break
    return v, f
for n in (5, 6, 7):
    m = n - 3; best = (-9, None)
    for r in range(3):
        v0 = rng.normal(size=6 * m + m * (m - 1) // 2); v, f = ascend(v0, m)
        if f > best[0]: best = (f, v)
    f, v = best; Ms, K = unpack(v, m); S, Ms = weyl_from(Ms, K); nrm = np.sqrt(norm2_blocks(S, Ms, K))
    comm = max(np.abs(Ms[a] @ Ms[b] - Ms[b] @ Ms[a]).max() for a in range(m) for b in range(m)) / nrm ** 2
    commS = max(np.abs(S @ Ms[a] - Ms[a] @ S).max() for a in range(m)) / nrm ** 2
    print(f"n={n}: best theta {f:.6f} Theta_n {theta_c(n):.6f} sqrt(3/2)={np.sqrt(1.5):.6f} | max|[M_a,M_b]|/|W|^2 {comm:.2e} max|[S,M_a]| {commS:.2e} | eig M_a/|W|: " + "; ".join(np.array2string(np.sort(np.linalg.eigvalsh(M)) / nrm, precision=3) for M in Ms) + f" | K/|W| {np.round(K[np.triu_indices(m,1)] / nrm, 3)}")
