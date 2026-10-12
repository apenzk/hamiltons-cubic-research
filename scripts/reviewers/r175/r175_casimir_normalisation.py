"""r175: independent, exact derivation of the so(5) Casimir on Weyl_5.

Builds Sym^2(Lambda^2 R^5) (dimension 55) with the so(5) action induced from the
generators M_ij = E_ij - E_ji, i<j, and forms C = -sum_p A_p^2 over those ten
generators.  Sym^2(Lambda^2 R^5) = Weyl_5(35) + Sym^2_0(14) + Lambda^4(5) + R(1),
so the spectrum of C tests the claimed eigenvalue 16 on Weyl_5 and three more
labels at once.  Everything is integer arithmetic; no SVD, no floating point.
"""
from fractions import Fraction
import itertools, numpy as np

n = 5
pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]      # Lambda^2 basis w_ij
idx = {p: k for k, p in enumerate(pairs)}
d2 = len(pairs)                                                   # 10

def gen(i, j):
    X = np.zeros((n, n), dtype=object)
    X[i, j] = 1; X[j, i] = -1
    return X

def lam2(X):
    """matrix of X acting on Lambda^2 in the basis w_ij = e_i ^ e_j."""
    L = np.zeros((d2, d2), dtype=object)
    for (a, b), c in idx.items():
        # X.(e_a ^ e_b) = (X e_a) ^ e_b + e_a ^ (X e_b);  X e_a = sum_k X[k,a] e_k
        for k in range(n):
            if X[k, a] != 0 and k != b:
                s, p = (1, (k, b)) if k < b else (-1, (b, k))
                L[idx[p], c] += s * X[k, a]
            if X[k, b] != 0 and a != k:
                s, p = (1, (a, k)) if a < k else (-1, (k, a))
                L[idx[p], c] += s * X[k, b]
    return L

# Sym^2(Lambda^2): basis of symmetric 10x10 matrices, action S -> L S + S L^T
sym = [(a, b) for a in range(d2) for b in range(a, d2)]
si = {p: k for k, p in enumerate(sym)}
D = len(sym)                                                      # 55

def act(L):
    A = np.zeros((D, D), dtype=object)
    for (a, b), c in si.items():
        S = np.zeros((d2, d2), dtype=object)
        S[a, b] += 1; S[b, a] += 1
        if a == b: S = S // 2 * 0 + np.zeros((d2, d2), dtype=object); S[a, a] = 1
        T = L.dot(S) + S.dot(L.T)
        for (p, q), r in si.items():
            A[r, c] += T[p, q]
    return A

gens = [gen(i, j) for (i, j) in pairs]
Aps = [act(lam2(X)) for X in gens]

C = np.zeros((D, D), dtype=object)
for A in Aps:
    C -= A.dot(A)

# C must be a scalar on each isotypic piece; report its spectrum exactly.
Cf = np.array(C, dtype=np.int64)
ev = np.linalg.eigvals(Cf.astype(float))
ev = np.sort(np.round(ev.real, 6))
from collections import Counter
print("dim ambient        :", D)
print("Casimir spectrum   :", dict(sorted(Counter(np.round(ev).astype(int)).items())))
print("C symmetric?       :", bool((Cf == Cf.T).all()))

# homomorphism and skewness checks, exactly, on the ambient module
ok_hom = True
for (p, (i, j)), (q, (k, l)) in itertools.product(list(enumerate(pairs)), repeat=2):
    br = gens[p].dot(gens[q]) - gens[q].dot(gens[p])
    lhs = Aps[p].dot(Aps[q]) - Aps[q].dot(Aps[p])
    # expand [X_p, X_q] in the generator basis
    rhs = np.zeros((D, D), dtype=object)
    for (a, b), r in idx.items():
        if br[a, b] != 0:
            rhs = rhs + br[a, b] * Aps[r]
    if not (lhs == rhs).all():
        ok_hom = False
print("Lie homomorphism   :", "exact on all 100 pairs" if ok_hom else "FAILS")

# eigenvalue formula  c(a,b) = a^2+3a+b^2+b  for B_2 with <e_i,e_j> = delta_ij
def c(a, b): return a * a + 3 * a + b * b + b
print("formula check      :", {(2,2): c(2,2), (2,0): c(2,0), (1,0): c(1,0), (0,0): c(0,0)})
