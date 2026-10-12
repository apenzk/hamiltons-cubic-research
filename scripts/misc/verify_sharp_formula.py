import numpy as np
from itertools import combinations

def so_n_basis(n):
    idx = list(combinations(range(n),2))
    basis = []
    for (i,j) in idx:
        M = np.zeros((n,n))
        M[i,j]=1; M[j,i]=-1
        basis.append(M)
    return idx, basis

def inner(A,B):
    return 0.5*np.trace(A.T@B)

def bracket(A,B):
    return A@B-B@A

def structure_constants(n):
    idx, basis = so_n_basis(n)
    N = len(basis)
    c = np.zeros((N,N,N))
    for a in range(N):
        for b in range(N):
            Lab = bracket(basis[a],basis[b])
            for g in range(N):
                c[a,b,g] = inner(Lab, basis[g])
    return idx, basis, c

n = 8
idx, basis, c = structure_constants(n)
N = len(basis)
index_of = {pair:k for k,pair in enumerate(idx)}

np.random.seed(1)
lam = np.random.randn(N)
lam -= lam.mean()

Wsharp_diag = np.zeros(N)
for a in range(N):
    Wsharp_diag[a] = np.sum((c[a,:,:]**2) * np.outer(lam,lam))

alpha = index_of[(0,1)]
i,j = 0,1
lam_sq = lam[alpha]**2
S = sum(lam[index_of[tuple(sorted((0,k)))]]*lam[index_of[tuple(sorted((1,k)))]] for k in range(n) if k not in (0,1))
print("lam_alpha^2 =", lam_sq)
print("S (single count sum) =", S)
print("Wsharp_diag[alpha] =", Wsharp_diag[alpha])
print("2*S =", 2*S)
print("ratio Wsharp/S:", Wsharp_diag[alpha]/S)

Q_diag = lam**2 + Wsharp_diag
P_direct = np.sum(lam * Q_diag)
P_formula_1x = np.sum(lam**3) + 3*sum(
    lam[index_of[tuple(sorted((i,j)))]]*lam[index_of[tuple(sorted((i,k)))]]*lam[index_of[tuple(sorted((j,k)))]]
    for i,j,k in combinations(range(n),3)
)
print("P_direct (using c^2 def) =", P_direct)
print("Naive triangle formula (coeff 3) =", P_formula_1x)
print("ratio:", P_direct/P_formula_1x)
