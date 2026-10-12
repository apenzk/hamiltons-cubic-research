"""R41 gatekeepers: dim Weyl_n, Jacobi for the structure constants, Q preserving
Weyl_n, full symmetry of the trilinear form, tr(L_x)=0, and the classical
diagonal formula for R^#."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np
import sys
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r41_core import (pairs, phi_basis, structure_A, weyl_basis, sharp,
                             sharp_bilin, Qop, circ, op_to_tensor)

np.set_printoptions(precision=6, suppress=True)


def dim_formula(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12


print("--- dim Weyl_n ---")
for n in range(4, 11):
    B = weyl_basis(n)
    print(f"  n={n:2d}  dim={B.shape[0]:5d}  formula={dim_formula(n):5d}  "
          f"{'OK' if B.shape[0] == dim_formula(n) else 'MISMATCH'}")

n = 6
P, phi, A = structure_A(n)
N = len(P)
B = weyl_basis(n)
D = B.shape[0]
print(f"\n--- n={n}, N={N}, dim Weyl={D} ---")

# A_a antisymmetric, Jacobi
print("  max |A_a + A_a^T| =", max(np.abs(A[a] + A[a].T).max() for a in range(N)))
# [A_a, A_b] = sum_c c_abc A_c  <=>  ad is a rep
err = 0.0
for a in range(3):
    for b in range(3):
        lhs = A[a] @ A[b] - A[b] @ A[a]
        rhs = np.einsum('c,cmn->mn', A[a][:, b], A)
        err = max(err, np.abs(lhs - rhs).max())
print("  ad-representation residual =", err)

# Q preserves Weyl_n
rng = np.random.default_rng(41)
X = np.einsum('d,dij->ij', rng.normal(size=D), B)
QX = Qop(A, X)
pr = np.einsum('dij,ij->d', B, QX)
print("  ||Q(X) - proj_Weyl Q(X)|| =",
      np.linalg.norm(QX - np.einsum('d,dij->ij', pr, B)))
print("  tr(Q(X)) =", np.trace(QX), " (Q preserves tracefree)")

# trilinear symmetry  <X o Y, Z>
Y = np.einsum('d,dij->ij', rng.normal(size=D), B)
Z = np.einsum('d,dij->ij', rng.normal(size=D), B)


def tri(X, Y, Z):
    return np.tensordot(circ(A, X, Y), Z)


v = [tri(X, Y, Z), tri(Y, X, Z), tri(X, Z, Y), tri(Z, Y, X), tri(Y, Z, X),
     tri(Z, X, Y)]
print("  trilinear values:", np.array(v))
print("  spread =", max(v) - min(v), " relative =", (max(v) - min(v)) / abs(v[0]))

# L_x on Weyl_n:  trace zero
Lx = np.zeros((D, D))
for d in range(D):
    Lx[:, d] = np.einsum('eij,ij->e', B, circ(A, X, B[d]))
print("  tr(L_X) =", np.trace(Lx), "   ||L_X - L_X^T|| =",
      np.abs(Lx - Lx.T).max())

# classical diagonal R^# check:  for W diagonal in a basis of *decomposable*
# 2-forms e_i ^ e_j, (W^#)_{(ij)(ij)} = sum_k W_{(ik)(ik)} W_{(jk)(jk)}
Wd = np.diag(rng.normal(size=N))
Sd = sharp(A, Wd)
idx = {p: a for a, p in enumerate(P)}
ok = True
for (i, j) in P:
    a = idx[(i, j)]
    s = sum(Wd[idx[tuple(sorted((i, k)))], idx[tuple(sorted((i, k)))]] *
            Wd[idx[tuple(sorted((j, k)))], idx[tuple(sorted((j, k)))]]
            for k in range(n) if k != i and k != j)
    if abs(Sd[a, a] - s) > 1e-10:
        ok = False
print("  diagonal R^# formula  (W^#)_aa = sum_k W_ik W_jk :",
      "OK" if ok else "FAIL")
