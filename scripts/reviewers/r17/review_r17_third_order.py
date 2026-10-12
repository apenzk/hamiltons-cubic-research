"""Reviewer 17: the THIRD-order branching obstruction on the zero cone of the
second-order one, at S^3 x S^3 (n=6).

Expansion (theta is constant along any critical curve on the unit sphere, so it
carries no free parameter):  W(t) = W_0 + t v + t^2 u + t^3 z,
   order t   :  L v = 0                          (v in ker Hess)
   order t^2 :  L u = -Pi_Weyl Q(v)              solvable iff  Phi(v) := Pi_K Pi_W Q(v) = 0
                u = u_p + k,  u_p = -L^+ Pi_W Q(v),  k in K free
   order t^3 :  L z = -2 G(v,u)                  solvable iff  Pi_K G(v, u_p + k) = 0 for some k
                i.e.  <G(v,u_p), kappa> = 0  for every kappa in ker A_v,
                where A_v: K -> K, k |-> Pi_K G(v,k)   (symmetric, and A_v v = Phi(v) = 0).
Since v itself is in ker A_v, one always-present scalar condition is
   Psi_1(v) := <Pi_W Q(v), L^+ Pi_W Q(v)> = 0.
"""
import numpy as np
from scipy.optimize import minimize

from curvature_operator import Lambda2
from review_r11_graded_law import weyl_sphere_product_mop
from review_r17_obstruction import Ctx, analyse, Qbil


def main():
    ctx = Ctx(6)
    L2 = Lambda2(6)
    st = analyse("S^3 x S^3", ctx, weyl_sphere_product_mop(L2, 3, 3))
    W, th, w, B, Lmat, ker, T, Ob = (st[k] for k in ("W", "th", "w", "B", "Lmat", "ker", "T", "Ob"))
    D = ctx.D
    Kd = B @ ker                       # kernel in D-coords, orthonormal columns (18)
    Od = B @ Ob                        # orbit part of the kernel, D-coords (9)
    Td = B @ T                         # transverse part, D-coords (9)
    PK = Kd @ Kd.T

    evL, VL = np.linalg.eigh(Lmat)
    keep = np.abs(evL) > 1e-7
    Lp = (VL[:, keep] / evL[keep]) @ VL[:, keep].T        # L^+ on K^perp
    print(f"  L spectrum: {np.sum(evL < -1e-7)} negative, {np.sum(np.abs(evL)<=1e-7)} zero, "
          f"{np.sum(evL > 1e-7)} positive;  min={evL.min():.4f} max={evL.max():.4f}")

    m = T.shape[1]
    C = np.zeros((ker.shape[1], m, m))
    mats = [ctx.mat(Td[:, a]) for a in range(m)]
    for i in range(m):
        for j in range(i, m):
            y = Kd.T @ ctx.coord(Qbil(mats[i], mats[j], ctx.c))
            C[:, i, j] = C[:, j, i] = y

    def phi(v):
        return np.einsum('kij,i,j->k', C, v, v)

    def f(x):
        nx = np.linalg.norm(x); vv = x / nx
        p = phi(vv)
        gv = 4.0 * np.einsum('k,kij,j->i', p, C, vv)
        return float(p @ p), (gv - (gv @ vv) * vv) / nx

    rng = np.random.default_rng(11)
    zeros = []
    while len(zeros) < 300:
        r = minimize(f, rng.standard_normal(m), jac=True, method="L-BFGS-B",
                     options=dict(maxiter=2000, ftol=1e-20, gtol=1e-16))
        vv = r.x / np.linalg.norm(r.x)
        if np.linalg.norm(phi(vv)) < 1e-11:
            zeros.append(vv)
    zeros = np.array(zeros)
    print(f"\n  sampled {len(zeros)} zeros of Phi on the unit sphere of T")

    # is the zero cone the Segre cone of rank-one 3x3 matrices?  T is 9-dim and
    # the plan says T = R^3 (x) R^3 as an SO(3)xSO(3) rep.
    print("\n  ### structure of the zero cone ###")
    G9 = zeros @ zeros.T
    print(f"  rank of dPhi at zeros: {sorted(set(int(np.sum(np.linalg.svd(2*np.einsum('kij,j->ki',C,v),compute_uv=False) > 1e-8)) for v in zeros[:50]))}")

    res = []
    for v in zeros:
        Vm = ctx.mat(Td @ v)
        g2 = ctx.coord(Qbil(Vm, Vm, ctx.c))          # Pi_Weyl Q(v), D-coords
        assert np.linalg.norm(Kd.T @ g2) < 1e-9
        up = -Lp @ g2
        psi1 = float(g2 @ (Lp @ g2))
        # full third-order obstruction: project Pi_K G(v,u_p) onto ker A_v
        Av = np.zeros((ker.shape[1], ker.shape[1]))
        Kmats = [ctx.mat(Kd[:, a]) for a in range(ker.shape[1])]
        for a in range(ker.shape[1]):
            Av[:, a] = Kd.T @ ctx.coord(Qbil(Vm, Kmats[a], ctx.c))
        Av = 0.5 * (Av + Av.T)
        ea, Va = np.linalg.eigh(Av)
        kerA = Va[:, np.abs(ea) < 1e-8]
        rhs = Kd.T @ ctx.coord(2.0 * Qbil(Vm, ctx.mat(up), ctx.c))
        psi = np.linalg.norm(kerA.T @ rhs) if kerA.size else 0.0
        res.append((psi1, psi, kerA.shape[1] if kerA.size else 0,
                    float(np.linalg.norm(Kd.T @ g2)), float(g2 @ w), th / 2))
    res = np.array([r[:5] for r in res])
    print("\n  ### third-order obstruction on the zero cone ###")
    print(f"  Psi_1 = <PiQ(v), L^+ PiQ(v)>   min={res[:,0].min():+.6e}  max={res[:,0].max():+.6e}"
          f"  |min| over samples = {np.abs(res[:,0]).min():.3e}")
    print(f"  |Psi| (full, incl. ker A_v)    min={res[:,1].min():.6e}   max={res[:,1].max():.6e}")
    print(f"  dim ker A_v over samples       {sorted(set(int(x) for x in res[:,2]))}")
    print(f"  <PiQ(v),W_0> should be th/2={th/2:.6f}: min={res[:,4].min():.6f} max={res[:,4].max():.6f}")

    # minimise |Psi_1| over the zero cone: penalise Phi
    print("\n  ### can the third-order obstruction vanish somewhere on the cone? ###")
    def g(x, lam=1e4):
        nx = np.linalg.norm(x); vv = x / nx
        Vm = ctx.mat(Td @ vv)
        g2 = ctx.coord(Qbil(Vm, Vm, ctx.c))
        p = phi(vv)
        return float((g2 @ (Lp @ g2)) ** 2 + lam * (p @ p))
    best = np.inf; bv = None
    for k in range(120):
        x0 = zeros[k % len(zeros)] + 0.35 * rng.standard_normal(m)
        r = minimize(g, x0, method="Nelder-Mead",
                     options=dict(maxiter=20000, maxfev=20000, xatol=1e-13, fatol=1e-16))
        vv = r.x / np.linalg.norm(r.x)
        Vm = ctx.mat(Td @ vv); g2 = ctx.coord(Qbil(Vm, Vm, ctx.c))
        if np.linalg.norm(phi(vv)) < 1e-7:
            val = abs(float(g2 @ (Lp @ g2)))
            if val < best:
                best, bv = val, vv
    print(f"  min |Psi_1| over the zero cone (120 restarts, Phi enforced < 1e-7) = {best:.6e}")
    if bv is not None:
        Vm = ctx.mat(Td @ bv); g2 = ctx.coord(Qbil(Vm, Vm, ctx.c))
        print(f"     at that v: |Phi| = {np.linalg.norm(phi(bv)):.2e},  Psi_1 = {float(g2 @ (Lp @ g2)):+.6e}")


if __name__ == "__main__":
    main()
