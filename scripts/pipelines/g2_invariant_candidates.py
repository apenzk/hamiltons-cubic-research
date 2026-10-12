"""G2: is the violating direction the m-Casimir, C_m = sum_{a in m} ad(m_a)^2?

That operator is canonical, symmetric, built only from m, and its restriction to
m sees exactly the [m,m] structure whose non-vanishing IS ungradedness.  If its
Rayleigh quotient under L_e exceeds 1/2 whenever S > 0, the construction is
found and gate G reduces to an inequality.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..'))
import sys
import numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from g1_le_machinery import weyl_basis
from p5_casimir_family import (projector, casimir_operator, h_adjoint, h_so3_in_so5,
                               su3_structure_constants, so_k_structure_constants,
                               h_so_p_so_q)

def study(nm, n, gens):
    N, c, L2, alt_idx, B = weyl_basis(n)
    Pi, r = projector(gens, n)
    W = casimir_operator(Pi, r, N)
    th = float(np.sum(W*Q_full(W, c))); e = W/th
    ev, V = np.linalg.eigh(W)
    Pm = V[:, ev < -1e-9] @ V[:, ev < -1e-9].T

    # C_m = sum_{a,b} Pm[a,b] A_a A_b, symmetrised
    C = np.einsum('ab,amn,bnp->mp', Pm, c, c, optimize=True)
    C = 0.5*(C + C.T)
    for label, cand in [("C_m", C), ("Pm C_m Pm", Pm @ C @ Pm)]:
        # project into the Weyl space and orthogonal to W
        co = np.einsum('kmn,mn->k', B, cand)
        co = co - (co @ np.einsum('kmn,mn->k', B, W)) * np.einsum('kmn,mn->k', B, W) / np.sum(W*W)
        nn = np.linalg.norm(co)
        if nn < 1e-10:
            print(f"{nm:>22} {label:>10}: vanishes in the Weyl space"); continue
        v = np.einsum('k,kmn->mn', co/nn, B)
        circ = 0.5*(Q_full(e+v, c) - Q_full(e, c) - Q_full(v, c))
        R = float(np.sum(v*circ))
        print(f"{nm:>22} {label:>10}: R = {R:+.6f}  "
              f"{'VIOLATES 1/2' if R > 0.5+1e-9 else ''}")

for nm, n, gens in [("so(4)+so(4) graded", 8, h_so_p_so_q(8, 4)),
                    ("su(3) adjoint", 8, h_adjoint(su3_structure_constants())),
                    ("so(3) in so(5)", 5, h_so3_in_so5()),
                    ("so(5) adjoint", 10, h_adjoint(so_k_structure_constants(5)))]:
    study(nm, n, gens)
