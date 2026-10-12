"""Does gradedness force a full Z_2 involution of so(n)?

If W graded (slack S = 0) implies h = m^perp is the fixed subalgebra of an
involution, then Cartan's classification of involutions of so(n) -- only
so(p)+so(q) and u(m) -- closes the graded enumeration outright, and the
"alternative embedding" residue is empty because those embeddings are not
symmetric subalgebras.

Test: measure all three bracket leakages for catalogued critical points.
  [h,h] -> m,   [h,m] -> h,   [m,m] -> m
An involution needs all three to vanish; gradedness only asserts the third.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..'))
import sys, itertools
import numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import delta2_and_grad
from p5_casimir_family import (projector, casimir_operator, h_adjoint, h_so3_in_so5,
                               su3_structure_constants, so_k_structure_constants,
                               h_so_p_so_q)

def leak(c, Pa, Pb, Pc):
    t = np.einsum('abg,ax->xbg', c, Pa, optimize=True)
    t = np.einsum('xbg,by->xyg', t, Pb, optimize=True)
    t = np.einsum('xyg,gz->xyz', t, Pc, optimize=True)
    return float(np.sqrt(np.sum(t*t)))

def study(nm, n, W):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n); alt_idx = build_alt_indices(L2)
    W = W/np.linalg.norm(W)
    QW = Q_full(W, c); th = float(np.sum(W*QW))
    if np.linalg.norm(QW-th*W) > 1e-7:
        print(f"{nm:>22} not critical"); return
    ev, V = np.linalg.eigh(W)
    Pm = V[:, ev < -1e-9] @ V[:, ev < -1e-9].T
    Ph = np.eye(N) - Pm
    neg = ev < 0
    Wm = (V[:, neg]*(-ev[neg])) @ V[:, neg].T
    d2 = delta2_and_grad(W, alt_idx)[0]; ric = ricci_from_mop(L2, Wm)
    S = (float(np.sum(ric*ric)) + 6*d2 - th*float(np.trace(Wm))
         - float(np.trace(Wm@Wm)))
    hhm = leak(c, Ph, Ph, Pm); hmh = leak(c, Ph, Pm, Ph); mmm = leak(c, Pm, Pm, Pm)
    print(f"{nm:>22} n={n:2d} th={th:8.5f} S={S:8.5f}  "
          f"[h,h]->m {hhm:9.2e}   [h,m]->h {hmh:9.2e}   [m,m]->m {mmm:9.2e}   "
          f"{'INVOLUTION' if max(hhm,hmh,mmm) < 1e-8 else 'not'}")

def tensor_so3_so3():
    """so(3) (x) so(3) acting on R^3 (x) R^3 = R^9 -- a non-symmetric subalgebra."""
    def so3():
        out = []
        for (i, j) in [(0,1),(0,2),(1,2)]:
            A = np.zeros((3,3)); A[i,j] = 1; A[j,i] = -1; out.append(A)
        return out
    I3 = np.eye(3); gens = []
    for A in so3(): gens.append(np.kron(A, I3))
    for A in so3(): gens.append(np.kron(I3, A))
    return gens

print(f"{'point':>22}")
for nm, n, gens in [("so(4)+so(4) [symmetric]", 8, h_so_p_so_q(8, 4)),
                    ("so(5)+so(5) [symmetric]", 10, h_so_p_so_q(10, 5)),
                    ("su(3) adjoint", 8, h_adjoint(su3_structure_constants())),
                    ("so(3) in so(5)", 5, h_so3_in_so5()),
                    ("so(5) adjoint", 10, h_adjoint(so_k_structure_constants(5))),
                    ("so(3)(x)so(3) in so(9)", 9, tensor_so3_so3())]:
    N = n*(n-1)//2
    Pi, r = projector(gens, n)
    study(nm, n, casimir_operator(Pi, r, N))
