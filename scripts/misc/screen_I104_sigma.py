# Screen for I104, seconds: is Sigma = Pi_Q1 + Pi_Q2 + Pi_Q3 (patterns on three four-sets pairwise sharing two
# indices, on six indices) closed under the Jordan product inside D_6, and what is the top eigenvalue of L_s on the
# complement of Sigma in D_6 relative to |s|?
import sys, itertools, numpy as np
import os; sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'lib'))
from curvature_operator import Lambda2, Q_op
n = 6; L2 = Lambda2(n); rng = np.random.default_rng(8)
edges = list(itertools.combinations(range(n), 2)); E = len(edges)
def vec_to_K(v):
    K = np.zeros((n, n))
    for (a, b), x in zip(edges, v): K[a, b] = K[b, a] = x
    return K
def diagW(K):
    W = np.zeros((L2.N, L2.N))
    for (a, b) in L2.pairs: W[L2.idx[(a, b)], L2.idx[(a, b)]] = K[a, b]
    return W
def W_to_vec(W): return np.array([W[L2.idx[e], L2.idx[e]] for e in edges])
# D_6: hollow symmetric with zero row sums, as a subspace of R^15 (unordered-edge coordinates, norm = sum over edges)
Rows = np.zeros((n, E))
for t, (a, b) in enumerate(edges): Rows[a, t] = 1; Rows[b, t] = 1
_, sv, Vt = np.linalg.svd(Rows); D6 = Vt[np.sum(sv > 1e-10):].T      # orthonormal basis, 9 columns
i, j, k, l, m, p = range(6)
def pattern_vecs(Q):
    a, b, c, d = Q; out = []
    for x, y in [(1, 0), (0, 1)]:
        z = -x - y; K = np.zeros((n, n))
        for (u, v), val in [((a, b), x), ((c, d), x), ((a, c), y), ((b, d), y), ((a, d), z), ((b, c), z)]: K[u, v] = K[v, u] = val
        out.append(np.array([K[e] for e in edges]))
    return out
S = np.array(pattern_vecs((i, j, k, l)) + pattern_vecs((i, j, m, p)) + pattern_vecs((k, l, m, p))).T
Sig, _ = np.linalg.qr(S); rank = np.linalg.matrix_rank(S)
comp = D6 - Sig @ (Sig.T @ D6); U, sv2, _ = np.linalg.svd(comp); Comp = U[:, :np.sum(sv2 > 1e-10)]
print(f"dim D_6 = {D6.shape[1]}, dim Sigma = {rank}, dim complement = {Comp.shape[1]}, Sigma inside D_6: {np.abs(S - D6 @ (D6.T @ S)).max():.1e}")
def jordan_vec(sv, tv):
    A = diagW(vec_to_K(sv)); B = diagW(vec_to_K(tv))
    J = 0.5 * (Q_op(L2, A + B) - Q_op(L2, A) - Q_op(L2, B)); return W_to_vec(J)
worst_leak = 0; ratios = []
for trial in range(6):
    s = Sig @ rng.normal(size=rank)
    ss = jordan_vec(s, s); leak = np.abs(Comp.T @ ss).max() / np.linalg.norm(s) ** 2
    worst_leak = max(worst_leak, leak)
    Lc = np.array([[jordan_vec(s, Comp[:, a]) @ Comp[:, b] for b in range(Comp.shape[1])] for a in range(Comp.shape[1])])
    ratios.append(np.linalg.eigvalsh((Lc + Lc.T) / 2).max() / np.linalg.norm(s))
print(f"largest component of s o s outside Sigma, relative to |s|^2: {worst_leak:.2e}")
print("top eigenvalue of L_s on the complement, over |s|:", np.round(ratios, 4), " (1/sqrt3 =", round(1/np.sqrt(3), 4), ")")
