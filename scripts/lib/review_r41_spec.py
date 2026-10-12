"""R41: C4, C5, C6 -- the L_e spectrum at W_{CP^m}, the orbit, the u(m)-Casimir
isotypic split, commutant dimensions (multiplicity-freeness) and the eigenvalue
carried by each summand.

usage:  python3 review_r41_spec.py m [--nofull]
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import numpy as np
import sys
import time
from fractions import Fraction
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r41_core import (pairs, phi_basis, structure_A, weyl_basis, Qop,
                             rho)
from review_r41_cpm import um_basis, invariant_subspace, Jmat

LOG = _os.path.join(_ROOT, 'agent_logs/review_r41_cpm.log')


def log(msg):
    with open(LOG, 'a') as f:
        f.write(time.strftime('[%H:%M:%S] ') + msg + '\n')
    print(msg, flush=True)


def build_Le(A, e, B, chunk=32):
    """Matrix of X -> e o X = 1/2(eX+Xe) + sharp_bilin(e,X) on span(B)."""
    N = e.shape[0]
    D = B.shape[0]
    M2 = (A @ e).reshape(N, N * N)             # [a,(p,q)] = (A_a e)_{pq}
    Aflat = A.reshape(N * N, N)                # [(b,q), r]
    L = np.zeros((D, D))
    t0 = time.time()
    for c0 in range(0, D, chunk):
        c1 = min(D, c0 + chunk)
        for c in range(c0, c1):
            X = B[c]
            AB = (Aflat @ X).reshape(N, N, N)          # [b,q,p]
            V = np.ascontiguousarray(AB.transpose(0, 2, 1)).reshape(N, N * N)
            T = M2 @ V.T                                # T_ab = tr(A_a e A_b X)
            out = 0.5 * (e @ X + X @ e) - 0.25 * (T + T.T)
            L[:, c] = np.einsum('dij,ij->d', B, out)
        if c0 % (chunk * 8) == 0:
            log(f"    L_e column {c1}/{D}  ({time.time()-t0:.1f}s)")
    return L


def main(m, full=True):
    n = 2 * m
    log(f"=== m={m}, n={n}: building basis ===")
    P, phi, A = structure_A(n)
    B = weyl_basis(n)
    D = B.shape[0]
    log(f"  dim Weyl_{n} = {D}")
    U, J = um_basis(m)
    log(f"  dim u(m) = {U.shape[0]}")

    # --- rho of the u(m) generators as D x D matrices on Weyl -----------
    def adrho(g):
        R = rho(n, g, phi)
        Mo = np.einsum('ij,djk->dik', R, B) - np.einsum('dij,jk->dik', B, R)
        return np.einsum('eij,dij->ed', B, Mo)

    RU = np.array([adrho(g) for g in U])
    log(f"  built {len(RU)} u(m) generators on Weyl")

    ns, _ = invariant_subspace(n, B, list(U), phi)
    assert ns.shape[0] == 1, f"invariant space dim {ns.shape[0]}"
    W = np.einsum('d,dij->ij', ns[0], B)
    W = W / np.sqrt(np.tensordot(W, W))          # Frobenius unit
    Qw = Qop(A, W)
    th = np.tensordot(Qw, W)
    if th < 0:                                    # positive branch
        W, th = -W, -th
        Qw = Qop(A, W)
        th = np.tensordot(Qw, W)
    res = np.linalg.norm(Qw - th * W)
    log(f"  theta = {th:.12f}   residual = {res:.3e}")
    e = W / th

    # --- orbit tangent ---------------------------------------------------
    Rall = np.array([rho(n, phi[a], phi) for a in range(len(P))])
    Tan = np.einsum('aij,jk->aik', Rall, W) - np.einsum('ij,ajk->aik', W, Rall)
    Tc = np.einsum('dij,aij->ad', B, Tan)
    sv = np.linalg.svd(Tc, compute_uv=False)
    tol = max(Tc.shape) * np.finfo(float).eps * sv[0]
    orbit = int((sv > tol).sum())
    log(f"  orbit dim = {orbit}   (m(m-1) = {m*(m-1)})   "
        f"gap {sv[orbit-1]:.3e} / {sv[orbit]:.3e}" if orbit < len(sv)
        else f"  orbit dim = {orbit}")

    # --- Casimir and centre ---------------------------------------------
    Cas = -np.einsum('kde,kef->df', RU, RU)
    RJ = adrho(J)
    Dop = -(RJ @ RJ)
    log(f"  Casimir symmetric err {np.abs(Cas-Cas.T).max():.2e}, "
        f"Dop {np.abs(Dop-Dop.T).max():.2e}")

    # --- L_e --------------------------------------------------------------
    log("  building L_e ...")
    L = build_Le(A, e, B)
    log(f"  L_e symmetry err = {np.abs(L - L.T).max():.3e}")
    wW = np.einsum('dij,ij->d', B, W)
    log(f"  |L_e W - W| = {np.linalg.norm(L @ wW - wW):.3e}")
    log(f"  tr(L_e) = {np.trace(L):.3e}")
    # equivariance
    eq = max(np.abs(L @ RU[k] - RU[k] @ L).max() for k in range(len(RU)))
    log(f"  max |[L_e, rho(u)]| = {eq:.3e}")

    if full:
        ev = np.linalg.eigvalsh(L)
        # cluster
        cl = []
        for x in ev:
            if cl and abs(x - cl[-1][0]) < 1e-7:
                cl[-1] = (cl[-1][0], cl[-1][1] + 1)
            else:
                cl.append((x, 1))
        log("  L_e spectrum:")
        for v, c in cl:
            log(f"     {v: .10f}  x{c}   {Fraction(v).limit_denominator(200)}")

    # --- isotypic split by (Casimir, Dop) --------------------------------
    Csym = 0.5 * (Cas + Cas.T)
    cev, cvec = np.linalg.eigh(Csym)
    groups = []
    i = 0
    while i < len(cev):
        j = i
        while j + 1 < len(cev) and abs(cev[j + 1] - cev[i]) < 1e-6:
            j += 1
        groups.append((cev[i], cvec[:, i:j + 1]))
        i = j + 1
    log("  Casimir blocks, refined by the centre, with L_e:")
    summands = []
    for cval, Vb in groups:
        Dm = Vb.T @ Dop @ Vb
        dev, dvec = np.linalg.eigh(0.5 * (Dm + Dm.T))
        k = 0
        while k < len(dev):
            j2 = k
            while j2 + 1 < len(dev) and abs(dev[j2 + 1] - dev[k]) < 1e-6:
                j2 += 1
            Sb = Vb @ dvec[:, k:j2 + 1]
            Lb = Sb.T @ L @ Sb
            lev = np.linalg.eigvalsh(0.5 * (Lb + Lb.T))
            scalar = lev.max() - lev.min()
            # commutant dimension of u(m) on this block
            RUb = np.array([Sb.T @ r @ Sb for r in RU])
            d = Sb.shape[1]
            # kernel of  M -> sum_k [r,[r,M]]  on End(block)
            CasEnd = np.zeros((d * d, d * d))
            for r in RUb:
                Lm = np.kron(r, np.eye(d)) - np.kron(np.eye(d), r.T)
                CasEnd += Lm.T @ Lm
            evc = np.linalg.eigvalsh(CasEnd)
            comm = int((evc < 1e-8 * max(1.0, evc.max())).sum())
            summands.append((cval, dev[k], d, lev.mean(), scalar, comm))
            log(f"     Cas={cval:9.5f}  c^2={dev[k]:7.3f}  dim={d:5d}  "
                f"L_e={lev.mean(): .10f} ({Fraction(lev.mean()).limit_denominator(200)})"
                f"  spread={scalar:.2e}  commutant={comm}")
            k = j2 + 1
    tot = sum(s[5] for s in summands)
    log(f"  total commutant dim over blocks = {tot}  "
        f"(= sum mult^2 over C-irreducibles if the blocks are isotypic)")
    return


if __name__ == '__main__':
    m = int(sys.argv[1])
    main(m, full='--nofull' not in sys.argv)
