"""Two-weight law for the bracket tensor T_abc = c_abc^2, and its consequence for S_22.

Written for plan item T6 (reviews/LIT-jacobi.md).

The operator A(X) = sum_{p,q} X_pq ad(v_p) ad(v_q) on Sym^2(Lambda^2 R^n) is O(n)-equivariant,
hence scalar on each of the four irreducible summands R + Sym^2_0 + Weyl_n + Lambda^4.  With
{v_a} orthonormal for <A,B> = tr(A^T B) the scalars are

    Weyl +1,   Lambda^4 -2,   Sym^2_0 -(n-4)/2,   R -(n-2)

(the record's isotropy-cap.md carries the same four in the normalisation <u,v> = -tr(uv)/2,
where every value doubles: +2, -4, -(n-4), -2(n-2)).

Consequence, verified below to 1e-15 for n = 6..10 and every tested (p,q):

    sum_{a,b,c} f(lam_a) g(lam_b) T_abc  =  - sum_i a_i <pi_i f(W), pi_i g(W)>

for any spectral functions f, g, where pi_i are the four isotypic projections and lam, {v_a}
the spectrum and eigenframe of W.  Taking f = g = lam^2 gives the {2,2,0} moment

    S_22 = -sum lam^4 + 3||pi_{L4}(W^2)||^2 + ((n-2)/2)||pi_{S2_0}(W^2)||^2 + (n-1)(tr W^2)^2/N.

Run: python3 scripts/lib/lit_jacobi_isotypic_law.py
"""

import numpy as np


def ad_array(n):
    """Orthonormal basis of so(n) and the array A[a] = matrix of ad(v_a) on Lambda^2."""
    pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    B = []
    for (i, j) in pairs:
        M = np.zeros((n, n))
        M[i, j] = 1 / np.sqrt(2)
        M[j, i] = -1 / np.sqrt(2)
        B.append(M)
    B = np.array(B)
    N = len(pairs)
    A = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            C = B[a] @ B[b] - B[b] @ B[a]
            for c in range(N):
                A[a, c, b] = np.tensordot(B[c], C)
    return A


def calA(X, A):
    return np.einsum('pij,pjk->ik', A, np.einsum('pq,qij->pij', X, A))


def eigenvalues(n):
    return sorted(set([1.0, -2.0, -(n - 4) / 2, -(n - 2)]))


def projector(X, target, evs, A):
    Y = X.copy()
    for e in evs:
        if abs(e - target) < 1e-12:
            continue
        Y = (calA(Y, A) - e * Y) / (target - e)
    return Y


def check(n, seed):
    A = ad_array(n)
    N = A.shape[0]
    evs = eigenvalues(n)
    rng = np.random.default_rng(seed)
    X = rng.standard_normal((N, N))
    X = (X + X.T) / 2
    W = projector(X, 1.0, evs, A)          # a random Weyl tensor
    W = (W + W.T) / 2
    W /= np.linalg.norm(W)
    lam, V = np.linalg.eigh(W)
    adu = np.einsum('pa,pcb->acb', V, A)
    T = np.einsum('acb,cq,br->aqr', adu, V, V) ** 2
    worst = 0.0
    for (p, q) in [(1, 1), (2, 1), (2, 2), (3, 2), (3, 3), (4, 2)]:
        direct = np.einsum('a,b,abc->', lam ** p, lam ** q, T)
        fW = V @ np.diag(lam ** p) @ V.T
        gW = V @ np.diag(lam ** q) @ V.T
        law = -sum(e * np.tensordot(projector(fW, e, evs, A), projector(gW, e, evs, A))
                   for e in evs)
        worst = max(worst, abs(direct - law))
    assert worst < 1e-12, (n, worst)
    print(f"n={n:2d}  distinct A-eigenvalues {evs}  max |direct - law| = {worst:.1e}")


def sphere_product(n, p):
    """Weyl tensor of S^p x S^q, and the S_22 identity at it."""
    A = ad_array(n)
    N = A.shape[0]
    evs = eigenvalues(n)
    pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    R = np.diag([1.0 if (i < p and j < p) or (i >= p and j >= p) else 0.0
                 for (i, j) in pairs])
    W = projector(R, 1.0, evs, A)
    W = (W + W.T) / 2
    W /= np.linalg.norm(W)
    lam, V = np.linalg.eigh(W)
    adu = np.einsum('pa,pcb->acb', V, A)
    T = np.einsum('acb,cq,br->aqr', adu, V, V) ** 2
    S22 = np.einsum('a,r,arq->', lam ** 2, lam ** 2, T)
    W2 = W @ W
    norms = {e: float(np.tensordot(projector(W2, e, evs, A), projector(W2, e, evs, A)))
             for e in evs}
    n4 = norms[-2.0]
    nS = norms.get(-(n - 4) / 2, 0.0) if abs((n - 4) / 2 - 2) > 1e-12 else 0.0
    n0 = norms[-(n - 2)]
    pred = -np.sum(lam ** 4) + 3 * n4 + ((n - 2) / 2) * nS + (n - 1) * n0
    print(f"S^{p} x S^{n-p} in n={n}: S_22 = {S22:.10f}, identity gives {pred:.10f}, "
          f"||pi_L4(W^2)||^2 = {n4:.2e}, ||pi_S2_0(W^2)||^2 = {nS:.2e}")


if __name__ == "__main__":
    for n in (6, 7, 8, 9, 10):
        check(n, 17 + n)
    for (n, p) in ((8, 4), (12, 6), (12, 4)):
        sphere_product(n, p)
