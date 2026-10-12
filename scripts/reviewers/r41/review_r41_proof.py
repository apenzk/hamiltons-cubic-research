"""R41: the checks that decide whether the CP^m claims are proofs or coincidences.

  (a) closed-form dimensions of the ten summands sum to dim Weyl_{2m} identically
  (b) the eigenvalue collisions: which summands can ever carry 1/2
  (c) Hess P on the sphere = 6 theta (L_e - 1/2) -- by literal second derivative
  (d) orbit tangent is *contained* in E(1/2), not merely equidimensional
  (e) e o X lands in Weyl_n with no projection (so Schur's target is right)
  (f) stabiliser dimension, and the Fubini-Study cross-check on the invariant line
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np
import sympy as sp
import sys
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r41_core import (structure_A, weyl_basis, Qop, circ, rho, pairs,
                             tensor_to_op)
from review_r41_cpm import um_basis, Jmat
from review_r41_spec import build_Le

m = sp.symbols('m', positive=True, integer=True)

print("=== (a) closed-form dimensions ===")
d_triv = sp.Integer(1)
d_ad = m**2 - 1
d_lam2 = m * (m - 1)                       # Lam^2 E + Lam^2 Ebar
d_1111 = m**2 * (m + 1) * (m - 3) / 4      # V_{(1,1);(1,1)}
d_211 = 2 * m**2 * (m**2 - 4) / 3          # V_{(2,1);(1)} + conj
d_22 = m**2 * (m + 3) * (m - 1) / 4        # V_{(2);(2)}
d_2200 = m**2 * (m**2 - 1) / 6             # V_{(2,2);0} + conj
tot = sp.expand(d_triv + d_ad + d_lam2 + d_1111 + d_211 + d_22 + d_2200)
dimW = sp.expand(sp.Rational(1, 3) * m * (m + 1) * (2 * m + 1) * (2 * m - 3))
print("  sum of summand dims :", sp.factor(tot))
print("  dim Weyl_{2m}       :", sp.factor(dimW))
print("  identical           :", sp.simplify(tot - dimW) == 0)
for mv in range(3, 12):
    vals = [int(x.subs(m, mv)) for x in
            (d_triv, d_ad, d_lam2, d_1111, d_211, d_22, d_2200)]
    print(f"   m={mv:2d}  {vals}  sum={sum(vals)}  dimWeyl={int(dimW.subs(m,mv))}")

print("\n=== (b) which summands can carry the eigenvalue 1/2 ===")
lam = {'triv': sp.Integer(1),
       'ad (su(m))': (m + 2) / (2 * (m + 1)),
       'Lam2E+conj (orbit)': sp.Rational(1, 2),
       'V(1,1;1,1)': 2 / (m + 1),
       'V(2,1;1)+conj': sp.Integer(0),
       'V(2;2)': sp.Integer(0),
       'V(2,2;0)+conj': -3 / (m + 1)}
for k, v in lam.items():
    sol = sp.solve(sp.Eq(v, sp.Rational(1, 2)), m)
    print(f"   {k:22s} L_e = {v}      = 1/2 at m in {sol}")
print("   V(1,1;1,1) dimension at m=3 :", d_1111.subs(m, 3),
      " -> the only collision is on a zero-dimensional summand")
print("   lambda_max on W^perp = max(ad, orbit, V1111) :")
for mv in range(3, 10):
    vs = {k: sp.nsimplify(v.subs(m, mv)) for k, v in lam.items() if k != 'triv'}
    print(f"     m={mv}: {vs}  max={max(vs.values())}")

# ---------------------------------------------------------------- numerics
for mv in (3, 4, 5):
    n = 2 * mv
    print(f"\n=== numerics m={mv}, n={n} ===")
    P, phi, A = structure_A(n)
    B = weyl_basis(n)
    D = B.shape[0]
    B2 = B.reshape(D, -1)
    U, J = um_basis(mv)

    def adrho(g):
        R = rho(n, g, phi)
        return B2 @ (R @ B - B @ R).reshape(D, -1).T

    RU = np.array([adrho(g) for g in U])
    Cas = np.einsum('kde,kdf->ef', RU, RU)
    cev, cvec = np.linalg.eigh(0.5 * (Cas + Cas.T))
    assert int((cev < 1e-8 * cev.max()).sum()) == 1
    W = np.einsum('d,dij->ij', cvec[:, 0], B)
    W /= np.sqrt(np.tensordot(W, W))
    th = np.tensordot(Qop(A, W), W)
    if th < 0:
        W, th = -W, -th
    e = W / th
    print(f"  theta = {th:.12f}")

    # (e) e o X inside Weyl with no projection
    rng = np.random.default_rng(41)
    X = np.einsum('d,dij->ij', rng.normal(size=D), B)
    C = circ(A, e, X)
    c = np.einsum('dij,ij->d', B, C)
    print(f"  (e) ||e o X - proj_Weyl(e o X)|| / ||e o X|| = "
          f"{np.linalg.norm(C - np.einsum('d,dij->ij', c, B))/np.linalg.norm(C):.3e}")

    L = build_Le(A, e, B, chunk=10**9)
    wv = np.einsum('dij,ij->d', B, W)

    # (c) Hessian by literal second derivative along the great circle
    def Pf(Y):
        return np.tensordot(Qop(A, Y), Y)
    errs = []
    for _ in range(4):
        v = rng.normal(size=D)
        v -= (v @ wv) * wv
        v /= np.linalg.norm(v)
        V = np.einsum('d,dij->ij', v, B)
        h = 1e-4
        f = lambda t: Pf(np.cos(t) * W + np.sin(t) * V)
        num = (f(h) - 2 * f(0) + f(-h)) / h**2
        pred = 6 * th * (v @ (L @ v) - 0.5)
        errs.append(abs(num - pred))
    print(f"  (c) |d2P/dt2 - 6 theta (<L_e v,v> - 1/2)| max = {max(errs):.3e}")

    # (d) orbit tangent inside E(1/2)
    Np = len(P)
    Rall = np.array([rho(n, phi[a], phi) for a in range(Np)])
    Tan = np.einsum('aij,jk->aik', Rall, W) - np.einsum('ij,ajk->aik', W, Rall)
    Tc = np.einsum('dij,aij->ad', B, Tan)
    u_, s_, vt_ = np.linalg.svd(Tc)
    r = int((s_ > max(Tc.shape) * np.finfo(float).eps * s_[0]).sum())
    Ob = vt_[:r].T                       # orthonormal basis of orbit tangent
    ev, evec = np.linalg.eigh(L)
    half = evec[:, np.abs(ev - 0.5) < 1e-8]
    resid = np.linalg.norm(Ob - half @ (half.T @ Ob))
    print(f"  (d) dim orbit = {r} (m(m-1)={mv*(mv-1)}), dim E(1/2) = "
          f"{half.shape[1]},  ||orbit - proj_E(1/2) orbit|| = {resid:.3e}")
    print(f"      stabiliser dim = {Np - r}  (dim u(m) = {mv*mv}, "
          f"dim so(2m) = {Np})")

    # (f) Fubini-Study cross-check
    g = np.eye(n)
    om = -Jmat(mv)                     # omega(X,Y) = g(JX,Y)
    Rt = (np.einsum('ik,jl->ijkl', g, g) - np.einsum('il,jk->ijkl', g, g)
          + np.einsum('ik,jl->ijkl', om, om) - np.einsum('il,jk->ijkl', om, om)
          + 2 * np.einsum('ij,kl->ijkl', om, om))
    Wfs = tensor_to_op(n, Rt, P)
    Wfs = 0.5 * (Wfs + Wfs.T)
    cfs = np.einsum('dij,ij->d', B, Wfs)
    Wfsw = np.einsum('d,dij->ij', cfs, B)
    cosang = abs(np.tensordot(Wfsw, W)) / np.linalg.norm(Wfsw)
    print(f"  (f) Fubini-Study Weyl part: ||.||={np.linalg.norm(Wfsw):.6f}, "
          f"|cos angle with W| = {cosang:.12f}")
