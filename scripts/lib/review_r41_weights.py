"""R41: the U(m)-isotypic decomposition of Weyl_{2m}, measured.

Weights are read off the maximal torus of u(m) acting on Weyl_{2m}; the
multiplicity of each irreducible is then extracted by the Racah/Klimyk formula
   m_lambda = sum_{sigma in S_m} sgn(sigma) n(lambda + rho - sigma(rho)),
which is exact given integer weight multiplicities.  No representation-theoretic
input is assumed beyond that formula.

usage: python3 review_r41_weights.py m [--nofull]
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import numpy as np
import sys, time, itertools
from collections import Counter
from fractions import Fraction
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r41_core import structure_A, weyl_basis, Qop, rho
from review_r41_cpm import um_basis, invariant_subspace, Jmat
from review_r41_spec import build_Le, log


# ------------------------------------------------------------------ weights
def weight_multiplicities(Ts, tol=1e-6):
    """Ts: list of m commuting real antisymmetric operators on a space.
    Returns Counter of integer weight vectors."""
    m = len(Ts)
    d = Ts[0].shape[0]
    rng = np.random.default_rng(12345)
    for _ in range(20):
        c = rng.normal(size=m)
        M = sum(c[k] * Ts[k] for k in range(m))
        vals, vecs = np.linalg.eig(M)
        # Gram-Schmidt not needed; just read off Rayleigh quotients
        W = np.zeros((d, m))
        ok = True
        for j in range(d):
            v = vecs[:, j]
            nv = np.vdot(v, v).real
            for k in range(m):
                q = np.vdot(v, Ts[k] @ v) / nv
                if abs(q.real) > 1e-6:
                    ok = False
                W[j, k] = q.imag
        Wr = np.rint(W)
        if ok and np.abs(W - Wr).max() < 1e-4:
            return Counter(tuple(int(x) for x in row) for row in Wr)
    raise RuntimeError(f"weights not integral; max dev {np.abs(W - Wr).max()}")


def gl_dim(lam):
    m = len(lam)
    num = 1.0
    for i in range(m):
        for j in range(i + 1, m):
            num *= (lam[i] - lam[j] + j - i) / (j - i)
    return int(round(num))


def racah(nmult, m):
    """Decompose the character with weight multiplicities nmult into gl(m)
    irreducibles.  Returns {dominant lambda: multiplicity}."""
    rho_ = tuple(range(m - 1, -1, -1))
    perms = list(itertools.permutations(rho_))
    sgn = {}
    for p in perms:
        # sign of the permutation taking rho_ to p
        order = sorted(range(m), key=lambda i: -p[i])
        # count inversions of p
        inv = sum(1 for i in range(m) for j in range(i + 1, m) if p[i] < p[j])
        sgn[p] = (-1) ** inv
    out = {}
    doms = [mu for mu in nmult if all(mu[i] >= mu[i + 1] for i in range(m - 1))]
    for lam in doms:
        tot = 0
        for p in perms:
            key = tuple(lam[i] + rho_[i] - p[i] for i in range(m))
            v = nmult.get(key, 0)
            if v:
                tot += sgn[p] * v
        if tot:
            out[lam] = tot
    return out


def fmt(lam):
    return '(' + ','.join(str(x) for x in lam) + ')'


def main(m, full=True):
    n = 2 * m
    t0 = time.time()
    log(f"### WEIGHTS m={m}, n={n}")
    P, phi, A = structure_A(n)
    B = weyl_basis(n)
    D = B.shape[0]
    log(f"  dim Weyl_{n} = {D}   ({time.time()-t0:.1f}s)")
    U, J = um_basis(m)

    B2 = B.reshape(D, -1)

    def adrho(g):
        R = rho(n, g, phi)
        Mo = (R @ B - B @ R).reshape(D, -1)
        return B2 @ Mo.T

    if D > 2000:   # reduced generating set: torus + 3 random u(m) elements
        rg = np.random.default_rng(7)
        idx0 = {p: a for a, p in enumerate(P)}
        gens = [phi[idx0[(2 * k, 2 * k + 1)]] for k in range(m)]
        gens += [np.einsum('k,kij->ij', rg.normal(size=len(U)), U)
                 for _ in range(3)]
        log(f"  reduced generating set: {len(gens)} elements")
    else:
        gens = list(U)
    RU = np.array([adrho(g) for g in gens])
    idx = {p: a for a, p in enumerate(P)}
    # torus generators: rho(phi_{2k,2k+1}); scale so that C^m has weights eps_j
    Ts = [adrho(phi[idx[(2 * k, 2 * k + 1)]]) for k in range(m)]
    log(f"  torus + u(m) generators built ({time.time()-t0:.1f}s)")

    # invariants = kernel of the u(m)-Casimir on Weyl (cheaper than an SVD)
    CasW = np.einsum('kde,kdf->ef', RU, RU)
    cev, cvec = np.linalg.eigh(0.5 * (CasW + CasW.T))
    ninv = int((cev < 1e-8 * cev.max()).sum())
    log(f"  dim U(m)-invariants in Weyl_{n} = {ninv}  "
        f"(gap {cev[ninv-1]:.2e} / {cev[ninv]:.2e})")
    assert ninv == 1
    W = np.einsum('d,dij->ij', cvec[:, 0], B)
    W /= np.sqrt(np.tensordot(W, W))
    th = np.tensordot(Qop(A, W), W)
    if th < 0:
        W, th = -W, -th
    res = np.linalg.norm(Qop(A, W) - th * W)
    log(f"  theta = {th:.12f}  residual {res:.2e}  theta^2 = {th*th:.12f} "
        f"vs (m+1)(2m-1)/(3m(m-1)) = "
        f"{float(Fraction((m+1)*(2*m-1), 3*m*(m-1))):.12f}")
    e = W / th

    # global weights
    nm = weight_multiplicities(Ts)
    # normalise: weights should be integer combinations; check the scale by
    # requiring the set to be closed and the top weight to be (2,2,0,...)
    log(f"  distinct weights: {len(nm)}   total {sum(nm.values())} (= {D})")
    dec = racah(nm, m)
    tot = 0
    log("  U(m)-isotypic decomposition of Weyl_{2m} (Racah):")
    for lam in sorted(dec, reverse=True):
        dl = gl_dim(lam)
        tot += dec[lam] * dl
        log(f"     lambda={fmt(lam):28s} mult={dec[lam]:2d}  dim={dl:6d}")
    log(f"  sum mult*dim = {tot}  (dim Weyl = {D})  "
        f"multiplicity-free: {all(v == 1 for v in dec.values())}")

    # L_e
    log("  building L_e ...")
    L = build_Le(A, e, B)
    log(f"  |L_e-L_e^T| {np.abs(L-L.T).max():.2e}  |L_e W - W| "
        f"{np.linalg.norm(L @ np.einsum('dij,ij->d', B, W) - np.einsum('dij,ij->d', B, W)):.2e}"
        f"  tr {np.trace(L):.2e}  equivariance "
        f"{max(np.abs(L @ r - r @ L).max() for r in RU):.2e}")
    if full:
        ev = np.linalg.eigvalsh(L)
        cl = []
        for x in ev:
            if cl and abs(x - cl[-1][0]) < 1e-7:
                cl[-1] = (cl[-1][0], cl[-1][1] + 1)
            else:
                cl.append((x, 1))
        log("  L_e spectrum: " + ", ".join(
            f"{Fraction(v).limit_denominator(400)} x{c}" for v, c in cl))

    # attribute eigenvalues to summands: split by L_e eigenvalue, then decompose
    ev, evec = np.linalg.eigh(L)
    blocks = []
    i = 0
    while i < len(ev):
        j = i
        while j + 1 < len(ev) and abs(ev[j + 1] - ev[i]) < 1e-7:
            j += 1
        blocks.append((ev[i:j + 1].mean(), evec[:, i:j + 1]))
        i = j + 1
    log("  eigenvalue -> summands:")
    for val, Sb in blocks:
        Tsb = [Sb.T @ t @ Sb for t in Ts]
        nmb = weight_multiplicities(Tsb)
        db = racah(nmb, m)
        parts = ", ".join(f"{fmt(l)}x{db[l]}(dim {gl_dim(l)})"
                          for l in sorted(db, reverse=True))
        log(f"     L_e = {str(Fraction(val).limit_denominator(400)):8s} "
            f"dim {Sb.shape[1]:5d} :  {parts}")
    log(f"  done ({time.time()-t0:.1f}s)")


if __name__ == '__main__':
    main(int(sys.argv[1]), full='--nofull' not in sys.argv)
