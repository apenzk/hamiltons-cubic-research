"""Reviewer 34 gatekeepers."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r34_core import (struct, weyl_basis, weyl_dim_formula, Q, circ, ip,
                             W_pq, idempotent, Le_matrix, sharp)

print("--- dim Weyl_n ---")
for n in range(4, 12):
    B = weyl_basis(n)
    print(f"  n={n:2d}  computed {B.shape[0]:5d}  formula {weyl_dim_formula(n):5d}  "
          f"{'OK' if B.shape[0]==weyl_dim_formula(n) else 'MISMATCH'}")

print("--- Weyl basis orthonormal & Q preserves Weyl_n ---")
for n in (6, 8):
    B = weyl_basis(n); D = B.shape[0]; N = B.shape[1]
    G = B.reshape(D, N*N) @ B.reshape(D, N*N).T
    rng = np.random.default_rng(0)
    x = rng.normal(size=D); X = np.einsum('d,dij->ij', x, B)
    QX = Q(X, n)
    proj = np.einsum('d,dij->ij', B.reshape(D,N*N) @ QX.ravel(), B)
    print(f"  n={n}: |G-I|={np.abs(G-np.eye(D)).max():.2e}   "
          f"|Q(X)-proj Q(X)|={np.linalg.norm(QX-proj)/np.linalg.norm(QX):.2e}")

print("--- trilinear form <X o Y, Z> fully symmetric ---")
for n in (5, 6, 7):
    B = weyl_basis(n); D = B.shape[0]
    rng = np.random.default_rng(1)
    def rnd():
        return np.einsum('d,dij->ij', rng.normal(size=D), B)
    X, Y, Z = rnd(), rnd(), rnd()
    vals = [ip(circ(X,Y,n),Z), ip(circ(Y,Z,n),X), ip(circ(Z,X,n),Y),
            ip(circ(Y,X,n),Z), ip(circ(X,Z,n),Y), ip(circ(Z,Y,n),X)]
    print(f"  n={n}: spread {max(vals)-min(vals):.3e}  scale {abs(vals[0]):.3e}")

print("--- L_e W = W, tr L_e = 0, theta_0 ---")
for (p,q) in [(3,3),(3,5),(4,4),(4,5),(5,5),(3,7),(4,6)]:
    n=p+q
    e, theta, Wu = idempotent(p,q)
    B = weyl_basis(n)
    M = Le_matrix(e, n, B)
    D=B.shape[0]; N=B.shape[1]
    w = B.reshape(D,N*N) @ Wu.ravel()
    resid = np.linalg.norm(M@w - w)
    th_pred = np.sqrt(2*(n-1)*(n-2))/n if p==q else None
    extra = f"  theta_0={th_pred:.9f}" if th_pred else ""
    # Nienhaus Prop 2.25 closed form
    th_nien = np.sqrt(2)*np.sqrt((p-1)/p*(q-1)/q*(n-1)/(n-2))
    print(f"  ({p},{q}) n={n} D={D:5d}  |L_e W - W|={resid:.2e}  tr L_e={np.trace(M):+.3e}"
          f"  theta={theta:.9f} Nienhaus={th_nien:.9f}{extra}")
