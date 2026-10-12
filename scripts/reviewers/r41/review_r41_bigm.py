"""R41: test the closed-form eigenvalues at large m without ever building a
basis of Weyl_{2m}.

Method.  Each nontrivial summand of Weyl_{2m} occurs with multiplicity one, so
ANY vector whose weight is the highest weight of that summand and of no other
summand lands, after projection to Weyl_n, inside that summand.  Highest-weight
vectors are written directly in terms of the holomorphic frame
z_j = e_{2j-2} - i e_{2j-1}:

   V(2,2;0)      (z1^z2) o (z1^z2)                weight 2e1+2e2   (charge 4)
   V(2,1;1)      (z1^z2) o (z1^zbar_m)            weight 2e1+e2-em (charge 2)
   V(2;2)        (z1^zbar_m) o (z1^zbar_m)        weight 2e1-2em   (charge 0)
   V(1,1;1,1)    (z1^z2) o (zbar_{m-1}^zbar_m)    weight e1+e2-e_{m-1}-e_m
   ad su(m)      the Weyl part of any H-linear equivariant curvature tensor,
                 H traceless Hermitian
The Weyl projection is done at tensor level (Bianchi projector + Kulkarni-Nomizu
Ricci subtraction), so nothing here reuses the Weyl-basis construction.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np
import sys, time
from fractions import Fraction
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r41_core import structure_A, op_to_tensor, tensor_to_op, circ, Qop
from review_r41_cpm import Jmat
from review_r41_spec import log


def bianchi_proj(T):
    b = T + np.transpose(T, (0, 2, 3, 1)) + np.transpose(T, (0, 3, 1, 2))
    return T - b / 3.0


def weyl_proj(T, n):
    T = 0.5 * (T + np.transpose(T, (2, 3, 0, 1)))
    T = bianchi_proj(T)
    ric = np.einsum('ijil->jl', T)
    trr = np.trace(ric)
    trA = trr / (2 * n - 2)
    Amat = (ric - trA * np.eye(n)) / (n - 2)
    g = np.eye(n)

    def KN(X, Y):
        return (np.einsum('ik,jl->ijkl', X, Y) + np.einsum('jl,ik->ijkl', X, Y)
                - np.einsum('il,jk->ijkl', X, Y) - np.einsum('jk,il->ijkl', X, Y))
    return T - KN(Amat, g)


def two_form(u, v, n):
    return np.einsum('i,j->ij', u, v) - np.einsum('i,j->ij', v, u)


def sym_prod(al, be):
    return (np.einsum('ij,kl->ijkl', al, be) + np.einsum('ij,kl->ijkl', be, al))


def run(m):
    n = 2 * m
    t0 = time.time()
    P, phi, A = structure_A(n)
    N = len(P)
    J = Jmat(m)
    om = J.T
    g = np.eye(n)

    # --- the CP^m point, straight from Fubini-Study --------------------
    Rfs = (np.einsum('ik,jl->ijkl', g, g) - np.einsum('il,jk->ijkl', g, g)
           + np.einsum('ik,jl->ijkl', om, om) - np.einsum('il,jk->ijkl', om, om)
           + 2 * np.einsum('ij,kl->ijkl', om, om))
    Wt = weyl_proj(Rfs, n)
    W = tensor_to_op(n, Wt, P)
    W = 0.5 * (W + W.T)
    W /= np.sqrt(np.tensordot(W, W))
    th = np.tensordot(Qop(A, W), W)
    if th < 0:
        W, th = -W, -th
    resid = np.linalg.norm(Qop(A, W) - th * W)
    th2 = Fraction((m + 1) * (2 * m - 1), 3 * m * (m - 1))
    log(f"  m={m:2d} n={n:2d} N={N:3d}  theta={th:.12f} resid={resid:.2e}  "
        f"theta^2-{th2} = {th*th - float(th2):+.2e}   ({time.time()-t0:.0f}s)")
    e = W / th

    z = [np.zeros(n, dtype=complex) for _ in range(m)]
    for j in range(m):
        z[j][2 * j] = 1.0
        z[j][2 * j + 1] = -1j
    zb = [np.conj(x) for x in z]

    def eigen_on(T, label, pred):
        Tw = weyl_proj(T, n)
        nrm = np.abs(Tw).max()
        if nrm < 1e-10:
            log(f"      {label:12s}: projects to zero")
            return
        V = tensor_to_op(n, Tw, P)
        V = 0.5 * (V + V.T)
        LV = circ(A, e.astype(complex), V)
        num = np.tensordot(np.conj(V), LV)
        den = np.tensordot(np.conj(V), V)
        lam = (num / den)
        dev = np.linalg.norm(LV - lam * V) / np.linalg.norm(V)
        log(f"      {label:12s}: L_e = {lam.real:+.12f} (imag {lam.imag:+.1e}) "
            f"pred {pred} = {float(pred):+.12f}  err {lam.real-float(pred):+.2e}"
            f"   |LV-lam V|/|V| = {dev:.2e}")

    al12 = two_form(z[0], z[1], n)
    al1mb = two_form(z[0], zb[m - 1], n)
    eigen_on(sym_prod(al12, al12), 'V(2,2;0)', Fraction(-3, m + 1))
    eigen_on(sym_prod(al12, al1mb), 'V(2,1;1)', Fraction(0))
    eigen_on(sym_prod(al1mb, al1mb), 'V(2;2)', Fraction(0))
    if m >= 4:
        bb = two_form(zb[m - 2], zb[m - 1], n)
        eigen_on(sym_prod(al12, bb), 'V(1,1;1,1)', Fraction(2, m + 1))
    # adjoint: H traceless Hermitian, real form
    H = np.zeros((n, n))
    H[0, 0] = H[1, 1] = 1.0
    H[2, 2] = H[3, 3] = -1.0
    omH = (H @ J).T
    RH = (np.einsum('ik,jl->ijkl', omH, om) + np.einsum('ik,jl->ijkl', om, omH)
          - np.einsum('il,jk->ijkl', omH, om) - np.einsum('il,jk->ijkl', om, omH)
          + 2 * np.einsum('ij,kl->ijkl', omH, om)
          + 2 * np.einsum('ij,kl->ijkl', om, omH))
    eigen_on(RH.astype(complex), 'ad su(m)', Fraction(m + 2, 2 * (m + 1)))
    # orbit: [rho(S), W] for S in so(2m) anticommuting with J
    S = np.zeros((n, n))
    S[0, 2] = 1.0
    S[2, 0] = -1.0
    S[1, 3] = -1.0
    S[3, 1] = 1.0
    from review_r41_core import rho
    Rs = rho(n, S, phi)
    Vorb = Rs @ W - W @ Rs
    LV = circ(A, e, Vorb)
    lam = np.tensordot(Vorb, LV) / np.tensordot(Vorb, Vorb)
    log(f"      {'orbit':12s}: L_e = {lam:+.12f}  pred 1/2  "
        f"|LV-lam V|/|V| = "
        f"{np.linalg.norm(LV-lam*Vorb)/np.linalg.norm(Vorb):.2e}")


if __name__ == '__main__':
    lo = int(sys.argv[1]) if len(sys.argv) > 1 else 3
    hi = int(sys.argv[2]) if len(sys.argv) > 2 else 10
    log(f"### BIG-m eigenvalue check, m={lo}..{hi}")
    for m in range(lo, hi + 1):
        run(m)
