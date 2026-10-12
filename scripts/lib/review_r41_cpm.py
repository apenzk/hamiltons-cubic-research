"""R41: C1, C2, C3 -- u(m) inside so(2m), the invariant line in Weyl_{2m},
criticality of W_{CP^m}, and theta."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import numpy as np
import sys
from fractions import Fraction
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r41_core import (pairs, phi_basis, structure_A, weyl_basis, sharp,
                             sharp_bilin, Qop, circ, rho, op_to_tensor,
                             tensor_to_op)

np.set_printoptions(precision=10, suppress=True)


def Jmat(m):
    n = 2 * m
    J = np.zeros((n, n))
    for k in range(m):
        J[2 * k, 2 * k + 1] = -1.0
        J[2 * k + 1, 2 * k] = 1.0
    return J


def um_basis(m):
    """{E in so(2m) : EJ = JE}, orthonormal for <X,Y> = 1/2 tr(X^T Y)."""
    n = 2 * m
    J = Jmat(m)
    P, phi = phi_basis(n)
    N = len(P)
    rows = np.array([(phi[a] @ J - J @ phi[a]).ravel() for a in range(N)]).T
    u, s, vt = np.linalg.svd(rows)
    tol = max(rows.shape) * np.finfo(float).eps * s[0]
    rank = int((s > tol).sum())
    null = vt[rank:]                       # coefficients on phi
    U = np.einsum('kd,dij->kij', null, phi)
    # phi is orthonormal for <.,.> so 'null' rows already orthonormal
    return U, J


def invariant_subspace(n, B, gens, phi):
    """Elements of span(B) killed by W -> [rho(g), W] for every g in gens."""
    D = B.shape[0]
    rowsl = []
    for g in gens:
        R = rho(n, g, phi)
        M = np.zeros((D, D))
        for d in range(D):
            C = R @ B[d] - B[d] @ R
            M[:, d] = np.einsum('eij,ij->e', B, C)
        rowsl.append(M)
    M = np.vstack(rowsl)
    u, s, vt = np.linalg.svd(M)
    tol = max(M.shape) * np.finfo(float).eps * (s[0] if len(s) else 1.0)
    rank = int((s > tol).sum())
    return vt[rank:], s


def report(m, verbose=True):
    n = 2 * m
    P, phi, A = structure_A(n)
    B = weyl_basis(n)
    D = B.shape[0]
    U, J = um_basis(m)
    out = {'m': m, 'n': n, 'dimWeyl': D, 'dim_um': U.shape[0]}

    # --- C1: the naive "elementary generators commuting with J" ---------
    elem = [a for a in range(len(P)) if np.abs(phi[a] @ J - J @ phi[a]).max() < 1e-12]
    out['n_elem'] = len(elem)
    ns_e, _ = invariant_subspace(n, B, [phi[a] for a in elem], phi)
    out['dim_inv_elem'] = ns_e.shape[0]

    # --- C2: invariants of the true u(m) --------------------------------
    ns, svals = invariant_subspace(n, B, list(U), phi)
    out['dim_inv_um'] = ns.shape[0]
    out['gap'] = (svals[len(svals) - ns.shape[0] - 1] if ns.shape[0] < len(svals) else np.nan,
                  svals[-1] if len(svals) else np.nan)

    if ns.shape[0] != 1:
        out['note'] = 'invariant space not 1-dimensional'
        return out, None, None, None, None

    W = np.einsum('d,dij->ij', ns[0], B)
    # --- C3: criticality and theta --------------------------------------
    for name, ipfac in (('Frobenius tr(X^T Y)', 1.0), ('1/2 tr(X^T Y)', 0.5)):
        Wn = W / np.sqrt(ipfac * np.tensordot(W, W))
        Qw = Qop(A, Wn)
        th = np.tensordot(Qw, Wn) / np.tensordot(Wn, Wn)
        res = np.linalg.norm(Qw - th * Wn) / np.linalg.norm(Wn)
        out[f'theta[{name}]'] = th
        out[f'res[{name}]'] = res
        out[f'W[{name}]'] = Wn
    return out, W, A, B, phi


if __name__ == '__main__':
    for m in [2, 3, 4, 5]:
        o, W, A, B, phi = report(m)
        print(f"\n=== m={o['m']}  n={o['n']}  dim Weyl={o['dimWeyl']} ===")
        print(f"  dim u(m) as commutant of J : {o['dim_um']}   (m^2 = {m*m})")
        print(f"  # elementary phi_ab commuting with J : {o['n_elem']}")
        print(f"  dim invariants of that span in Weyl : {o['dim_inv_elem']}"
              f"   (m(m-1) = {m*(m-1)})")
        print(f"  dim invariants of full u(m) in Weyl : {o['dim_inv_um']}")
        print(f"  singular-value gap around the cut  : {o['gap']}")
        if o['dim_inv_um'] == 1:
            for key in ('Frobenius tr(X^T Y)', '1/2 tr(X^T Y)'):
                th, r = o[f'theta[{key}]'], o[f'res[{key}]']
                print(f"  <{key}>  theta = {th: .12f}   |Q(W)-theta W|/|W| = {r:.3e}")
            t2 = Fraction((m + 1) * (2 * m - 1), 3 * m * (m - 1)) if m > 1 else None
            print(f"  predicted theta^2 = (m+1)(2m-1)/(3m(m-1)) = {t2} "
                  f"= {float(t2):.12f}  -> theta = {np.sqrt(float(t2)):.12f}")
