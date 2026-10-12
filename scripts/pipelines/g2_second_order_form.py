"""The second-order form on Sym^2(m), decomposed exactly.

For C a symmetric operator supported on m = the negative eigenspace of a
critical point W, with e = W/theta, alpha and beta the eigenvalue ratios of e
on m and h, and

    H_ik = Pi_h [m_i, m_k],      M_ik = Pi_m [m_i, m_k],

the sharp term splits as

    <C, e#C> = (1/2) [ beta * sum C_ij C_kl <H_ik, H_jl>
                     + alpha * sum C_ij C_kl <M_ik, M_jl> ],

verified to 1e-14.  M is exactly the ungradedness: it vanishes identically at a
graded point, where the alpha term is then zero to machine precision.

Since alpha < 0, ungradedness contributes POSITIVELY to the second-order form
wherever the M-form is negative.  That form is indefinite -- eigenvalues run
from -1.24 to +4.0 at the su(3) bi-invariant -- so the sign is not automatic,
and a witness must be chosen in the negative cone.  Gate G therefore reduces to
a variational question on Sym^2(h) + Sym^2(m) rather than a search.
"""
import numpy as np

from g1_le_machinery import weyl_basis
from rsharp_basis_free import Q_full


def blocks(n, W, c):
    """alpha, beta, the m-frame, and the H, M bracket tensors."""
    N = W.shape[0]
    th = float(np.sum(W*Q_full(W, c)))
    ev, V = np.linalg.eigh(W)
    mc = V[:, ev < -1e-9]
    Pm = mc @ mc.T
    Ph = np.eye(N) - Pm
    br = np.einsum('abg,ai,bj->ijg', c, mc, mc, optimize=True)
    H = np.einsum('ijg,gh->ijh', br, Ph, optimize=True)
    M = np.einsum('ijg,gh->ijh', br, Pm, optimize=True)
    return th, float(ev[0]/th), float(ev[-1]/th), mc, H, M


def sharp_on_sym2m(C, alpha, beta, H, M):
    """The closed form above."""
    bt = beta*np.einsum('ij,kl,ikg,jlg->', C, C, H, H, optimize=True)
    at = alpha*np.einsum('ij,kl,ikg,jlg->', C, C, M, M, optimize=True)
    return 0.5*float(bt + at), 0.5*float(bt), 0.5*float(at)


def M_form_spectrum(M):
    """Extreme values of F(C)/||C||_F^2 for F(C) = sum C_ij C_kl <M_ik, M_jl>.

    Built in an ORTHONORMAL basis of Sym^2(m) -- diagonal units e_ii and
    off-diagonal (e_ij + e_ji)/sqrt(2) -- so the eigenvalues are directly
    comparable to F(C)/||C||_F^2.  Without the sqrt(2) weights the spectrum
    comes out in a different normalisation and the comparison is meaningless.
    """
    dm = M.shape[0]
    basis = []
    for i in range(dm):
        E = np.zeros((dm, dm)); E[i, i] = 1.0
        basis.append(E)
    for i in range(dm):
        for j in range(i+1, dm):
            E = np.zeros((dm, dm))
            E[i, j] = E[j, i] = 1.0/np.sqrt(2.0)
            basis.append(E)
    Q = np.zeros((len(basis), len(basis)))
    for a, A in enumerate(basis):
        for b, Bm in enumerate(basis):
            Q[a, b] = np.einsum('ij,kl,ikg,jlg->', A, Bm, M, M, optimize=True)
    ev = np.linalg.eigvalsh(0.5*(Q + Q.T))
    return float(ev[0]), float(ev[-1])
