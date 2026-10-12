"""C(W) = sum_j mu_j |S^j W|^2 -- the cubic the shifted Cheng-Wang bound controls.

WHY THIS EXISTS. Route 3a rested on whether an upper bound on C bounds theta.
Reviewer 160 showed non-proportionality settles nothing, recovered (alpha, beta) from
three evaluations, and predicted C(S^3 x S^9, n=12) = -4.19351 -- a sign change across
the family. This script is what the closing commit should have shipped and did not.

mu_j, S^j are the eigenpairs of the second-kind operator on S^2_0; the derivation action
is Cheng-Wang Definition 2.1, four slots, no factor.
"""
import itertools, sys
import numpy as np
sys.path.insert(0, 'scripts/lib'); sys.path.insert(0, 'scripts/runs')
from b_second_order_screen import product_weyl
import run_lambda_product as LP, run_grading_test as GT


def s20_basis(n):
    """Orthonormal basis of trace-free symmetric 2-tensors on R^n."""
    B = []
    for i in range(n):
        for j in range(i + 1, n):
            E = np.zeros((n, n)); E[i, j] = E[j, i] = 1 / np.sqrt(2); B.append(E)
    for k in range(1, n):
        d = np.zeros(n); d[:k] = 1; d[k] = -k; d /= np.linalg.norm(d); B.append(np.diag(d))
    return B


def full_W(M, n, pr):
    """The (0,4) tensor from its Lambda^2 matrix, both pair-antisymmetries restored."""
    W = np.zeros((n, n, n, n))
    for a, (i, j) in enumerate(pr):
        for b, (k, l) in enumerate(pr):
            v = M[a, b]
            for (p, q, s1) in ((i, j, 1), (j, i, -1)):
                for (r, t, s2) in ((k, l, 1), (l, k, -1)):
                    W[p, q, r, t] = s1 * s2 * v
    return W


def SW_norm2(S, W):
    """|SW|^2 with S acting as a derivation on all four slots (Definition 2.1)."""
    A = (np.einsum('ia,ajkl->ijkl', S, W) + np.einsum('ja,iakl->ijkl', S, W)
         + np.einsum('ka,ijal->ijkl', S, W) + np.einsum('la,ijka->ijkl', S, W))
    return float(np.sum(A * A))


def evaluate(blocks):
    M, n, _ = product_weyl(blocks)
    pr = list(itertools.combinations(range(n), 2))
    LP.setup(n); Bs = GT.so_basis(n, pr); K = len(pr)
    c3 = np.zeros((K, K, K))
    for a in range(K):
        for b in range(K):
            Cm = Bs[a] @ Bs[b] - Bs[b] @ Bs[a]
            for g in range(K):
                c3[a, b, g] = GT.ip(Cm, Bs[g])
    theta = float(np.sum((M @ M + LP.sharp_op(M, c3)) * M))
    W = full_W(M, n, pr)
    B = s20_basis(n); N = len(B)
    Wr = np.array([[np.einsum('iklj,kl,ij->', W, h1, h2) for h1 in B] for h2 in B])
    Wr = (Wr + Wr.T) / 2
    mu, V = np.linalg.eigh(Wr)
    C = T = 0.0
    for j in range(N):
        S = sum(V[t, j] * B[t] for t in range(N))
        nb = SW_norm2(S, W); C += mu[j] * nb; T += nb
    return n, theta, C, T, np.sum(W * W)


if __name__ == "__main__":
    print(f"{'point':12s} {'n':>3s} {'theta':>10s} {'C':>11s} {'C/theta':>10s} {'T/||W||^2':>11s}")
    for bl in [(6, 6), (5, 7), (4, 8), (3, 9)]:
        n, th, C, T, w2 = evaluate(bl)
        print(f"S^{bl[0]}xS^{bl[1]:<7d} {n:3d} {th:10.6f} {C:11.5f} {C/th:10.5f} {T/w2:11.4f}")
    print("\nr160's prediction: C(S^3 x S^9, n=12) = -4.19351, a SIGN CHANGE across the family.")
