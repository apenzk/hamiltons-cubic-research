"""r331 screens. Everything here SCREENS a claim derived analytically in the report;
no number below is evidence for a positive claim."""
import numpy as np, itertools
rng = np.random.default_rng(20260901)

def so_basis(n):
    B = []
    for i in range(n):
        for j in range(i+1, n):
            E = np.zeros((n, n)); E[i, j] = 1; E[j, i] = -1
            B.append(E)
    return B  # orthonormal under <X,Y> = tr(X^T Y)/2

def inner(X, Y): return 0.5*np.trace(X.T @ Y)

def adjoint_matrix(A, B):
    N = len(B)
    D = np.zeros((N, N))
    for b in range(N):
        C = A @ B[b] - B[b] @ A
        for a in range(N):
            D[a, b] = inner(B[a], C)
    return D

def full_tensor_from_matrix(M, n, pairs):
    """S_ijkl full 4-tensor from matrix on orthonormal e_i^e_j (i<j) basis."""
    S = np.zeros((n, n, n, n))
    for (P, (i, j)) in enumerate(pairs):
        for (Q, (k, l)) in enumerate(pairs):
            v = M[P, Q]
            for (a, b, s1) in ((i, j, 1), (j, i, -1)):
                for (c, d, s2) in ((k, l, 1), (l, k, -1)):
                    S[a, b, c, d] = s1*s2*v
    return S

def bianchi_map(S):
    return (S + np.transpose(S, (0, 2, 3, 1)) + np.transpose(S, (0, 3, 1, 2)))/3.0

# ---------- Screen 1: the general identity (star-star), n=5 ----------
n = 5
B = so_basis(n); N = len(B); pairs = [(i, j) for i in range(n) for j in range(i+1, n)]
M = rng.standard_normal((N, N)); M = (M + M.T)/2          # random symmetric S on Lambda^2
Araw = rng.standard_normal((n, n)); A = Araw - Araw.T      # random bivector, NOT unit
S = full_tensor_from_matrix(M, n, pairs)
S4 = bianchi_map(S)
# check S4 totally antisymmetric
asym_res = 0.0
for perm, sgn in (((1, 0, 2, 3), -1), ((0, 1, 3, 2), -1), ((2, 3, 0, 1), 1), ((1, 2, 3, 0), None)):
    pass
def tot_antisym_residual(T4):
    r = 0
    r = max(r, np.abs(T4 + np.transpose(T4, (1, 0, 2, 3))).max())
    r = max(r, np.abs(T4 + np.transpose(T4, (0, 1, 3, 2))).max())
    r = max(r, np.abs(T4 + np.transpose(T4, (0, 2, 1, 3))).max())
    return r
print("b(S) totally antisymmetric residual:", tot_antisym_residual(S4))
SB = S - S4
D = adjoint_matrix(A, B)
LHS = np.trace(M @ D @ D)
RicS = np.einsum('ijpj->ip', S)
term1 = np.trace(A @ A @ RicS)
qB = 0.25*np.einsum('ijpq,ij,pq->', SB, A, A)
q4 = 0.25*np.einsum('ijpq,ij,pq->', S4, A, A)
RHS = term1 + 2*qB - 4*q4
print("(star-star) residual:", LHS - RHS, " scale:", abs(LHS))
