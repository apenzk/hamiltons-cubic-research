"""Reviewer 43 phase 1: validation of the machinery before any claim is touched."""
import sys, numpy as np
sys.path.insert(0, 'scripts/lib')
from review_r43_core import Ambient, dim_weyl, frob

rng = np.random.default_rng(43)

def sym(N):
    M = rng.standard_normal((N, N)); return M + M.T

for n in [6, 7, 8]:
    amb = Ambient(n); N = amb.N
    print(f'--- n={n}  N={N} ---')
    # 1. weyl_project is idempotent and self-adjoint on Sym  => orthogonal projection
    X, Y = sym(N), sym(N)
    PX, PY = amb.weyl_project(X), amb.weyl_project(Y)
    print('  P idempotent      ', np.abs(amb.weyl_project(PX) - PX).max())
    print('  P self-adjoint    ', abs(frob(PX, Y) - frob(X, PY)))
    print('  P image in Weyl   ', amb.defect(PX))
    # 2. cross-check against SVD basis projector
    B = amb.weyl_basis()
    co = np.einsum('aij,ij->a', B, X)
    PX2 = np.einsum('a,aij->ij', co, B)
    print('  P == basis proj   ', np.abs(PX - PX2).max())
    # 3. trilinear symmetry of <X o Y, Z>
    Z = sym(N)
    t1 = frob(amb.circ(X, Y), Z); t2 = frob(amb.circ(Y, Z), X); t3 = frob(amb.circ(Z, X), Y)
    print('  trilinear sym     ', max(abs(t1-t2), abs(t2-t3)))
    # 4. Q preserves Weyl (Weyl closed under o)
    print('  PX o PY in Weyl   ', amb.defect(amb.circ(PX, PY)))
    # 5. tr(L_x) = 0 on Weyl_n for x in Weyl
    L = np.array([np.einsum('aij,ij->a', B, amb.circ(PX, Bk)) for Bk in B])
    print('  tr(L_x) on Weyl   ', np.trace(L), '   |L asym|', np.abs(L - L.T).max())
