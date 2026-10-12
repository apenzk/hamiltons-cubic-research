"""Padded W_CP2 at n=6: conventions, (A)(B)(C), g-distribution, G_2, S_22, (dagger)."""
import numpy as np
np.set_printoptions(precision=6, suppress=True)

def so_basis(n):
    B = []
    for i in range(n):
        for j in range(i+1, n):
            E = np.zeros((n, n)); E[i, j] = 1; E[j, i] = -1
            B.append(E)
    return B

def inner(X, Y): return 0.5*np.trace(X.T @ Y)

n = 6
B = so_basis(n); N = len(B); pairs = [(i, j) for i in range(n) for j in range(i+1, n)]
idx = {p: k for k, p in enumerate(pairs)}

def bv(i, j):  # coordinates of e_i ^ e_j
    v = np.zeros(N); v[idx[(i, j)]] = 1; return v

s2 = 1/np.sqrt(2)
phi1 = s2*(bv(0, 1) + bv(2, 3)); phi2 = s2*(bv(0, 2) - bv(1, 3)); phi3 = s2*(bv(0, 3) + bv(1, 2))
W = (2*np.outer(phi1, phi1) - np.outer(phi2, phi2) - np.outer(phi3, phi3))/np.sqrt(6)
print("||W|| =", np.sqrt(np.trace(W @ W)))

# Weyl membership: Ric = 0 and Bianchi = 0 of the full tensor
def full_tensor_from_matrix(M):
    S = np.zeros((n, n, n, n))
    for (P, (i, j)) in enumerate(pairs):
        for (Q, (k, l)) in enumerate(pairs):
            v = M[P, Q]
            for (a, b, s1) in ((i, j, 1), (j, i, -1)):
                for (c, d, s2_) in ((k, l, 1), (l, k, -1)):
                    S[a, b, c, d] = s1*s2_*v
    return S
def bianchi_map(S):
    return (S + np.transpose(S, (0, 2, 3, 1)) + np.transpose(S, (0, 3, 1, 2)))/3.0
Wt = full_tensor_from_matrix(W)
print("Ric(W) residual:", np.abs(np.einsum('ijpj->ip', Wt)).max(),
      " Bianchi residual:", np.abs(bianchi_map(Wt)).max())

# eigen-decomposition and structure constants in the W-eigenbasis
lam, U = np.linalg.eigh(W)          # columns of U: eigenvectors in Lambda^2 coords
Phi = [sum(U[k, a]*B[k] for k in range(N)) for a in range(N)]  # as matrices
c = np.zeros((N, N, N))
for a in range(N):
    for b in range(a+1, N):
        Cm = Phi[a] @ Phi[b] - Phi[b] @ Phi[a]
        for d in range(N):
            v = inner(Phi[d], Cm)
            c[a, b, d] = v; c[b, a, d] = -v
T = c**2
theta = np.sqrt(1.5)

# criticality: W# via polarization, Q(W) = theta W
adm = np.zeros((N, N, N))
for a in range(N):
    for i2 in range(N):
        for j2 in range(N):
            adm[a, i2, j2] = c[a, j2, i2]     # (ad_a)_{i j} = <phi_i,[phi_a,phi_j]> = c_{a j i}
Wd = np.diag(lam)
Sharp = np.zeros((N, N))
for k in range(N):
    for l in range(k, N):
        Sharp[k, l] = Sharp[l, k] = -0.5*np.trace(adm[k] @ Wd @ adm[l] @ Wd)
Qm = Wd @ Wd + Sharp
print("criticality residual ||Q - theta W|| =", np.abs(Qm - theta*Wd).max())

# census relations (A),(B),(C)
rowA = T.sum(axis=(1, 2))
rowB = np.einsum('kbc,b->k', T, lam)
rowC = np.einsum('kbc,b,c->k', T, lam, lam)
print("(A) max|row - 2(n-2)| :", np.abs(rowA - 2*(n-2)).max())
print("(B) max|row + 2 lam_k|:", np.abs(rowB + 2*lam).max())
print("(C) max|row - 2 lam_k(theta-lam_k)|:", np.abs(rowC - 2*lam*(theta-lam)).max())

# g distribution, G_2, S_22, CS bound, support of g
m20 = np.einsum('kbc,b->k', T, lam**2)
g = 2*m20 - 2*rowC
print("sum g =", g.sum(), " (4(n-1) =", 4*(n-1), ")  sum lam g =", (lam*g).sum(), " (-4theta =", -4*theta, ")")
G2 = (lam**2*g).sum()
S22 = np.einsum('abc,a,b->', T, lam**2, lam**2)
p3 = (lam**3).sum(); p4 = (lam**4).sum()
print("G_2 =", G2, " (claim: exactly 2)   S22 =", S22,
      "  bridge residual:", S22 - (2*theta*p3 - 2*p4 + 0.5*G2))
print("CS bound (1/2)sqrt((n-1)G_2) =", 0.5*np.sqrt((n-1)*G2), " vs theta =", theta)
print("g by eigenvalue: ", [(round(l, 4), round(gv, 6)) for l, gv in zip(lam, g)])

# (dagger): m20(k) = -tr(A^2 Ric(W^2)) - 2 lam_k^2 + 6 <phi_k,(W^2)_4 phi_k>
W2m = np.zeros((N, N))
for a in range(N): W2m[a, a] = lam[a]**2
# express W^2 in the ORIGINAL pair basis to build its 4-tensor
W2orig = U @ W2m @ U.T
W2t = full_tensor_from_matrix(W2orig)
W2_4 = bianchi_map(W2t)
RicW2 = np.einsum('ijpj->ip', W2t)
res = []
freeterms = []
for k in range(N):
    A = Phi[k]
    q4 = 0.25*np.einsum('ijpq,ij,pq->', W2_4, A, A)
    t1 = np.trace(A @ A @ RicW2)
    res.append(m20[k] - (-t1 - 2*lam[k]**2 + 6*q4))
    freeterms.append((t1, q4))
print("(dagger) max residual:", np.abs(res).max())
print("free terms (tr(A^2 Ric W^2), <v,(W^2)_4 v>) at extreme rows:",
      [(round(a, 6), round(b, 6)) for a, b in (freeterms[0], freeterms[-1])])
print("Ric(W^2) nonzero?", np.abs(RicW2).max(), "  (W^2)_4 nonzero?", np.abs(W2_4).max())
