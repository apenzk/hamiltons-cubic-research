"""Reviewer 17: positive control for the THIRD-order obstruction, plus the
structure of the second-order zero cone.

The SO(6) orbit is a genuine branch, so for an orbit direction v every order of
the expansion must be solvable.  In particular the scalar third-order obstruction
    Psi_1(v) = <Pi_W Q(v), L^+ Pi_W Q(v)>          (v-component, free of the k in u)
must VANISH on orbit directions and is allowed to be nonzero elsewhere.
"""
import numpy as np
from scipy.linalg import expm
from curvature_operator import Lambda2
from review_r11_graded_law import weyl_sphere_product_mop
from run_defect_max_hunt import su_m_kahler_weyl
from review_r17_obstruction import Ctx, analyse, Qbil, rho_lambda2


def main():
    ctx = Ctx(6)
    L2 = Lambda2(6)
    for nm, Wmat in [("S^3 x S^3", weyl_sphere_product_mop(L2, 3, 3)),
                     ("su(3) Kahler", su_m_kahler_weyl(L2, 3))]:
        st = analyse(nm, ctx, Wmat)
        W, th, w, B, Lmat, ker, T, Ob = (st[k] for k in ("W","th","w","B","Lmat","ker","T","Ob"))
        Kd, Od, Td = B @ ker, B @ Ob, B @ T
        evL, VL = np.linalg.eigh(Lmat)
        keep = np.abs(evL) > 1e-7
        Lp = (VL[:, keep] / evL[keep]) @ VL[:, keep].T

        def psi1(vD):
            Vm = ctx.mat(vD)
            g2 = ctx.coord(Qbil(Vm, Vm, ctx.c))
            return float(g2 @ (Lp @ g2)), float(np.linalg.norm(Kd.T @ g2))

        print(f"\n##### {nm}: third-order scalar Psi_1 #####")
        rng = np.random.default_rng(5)
        vals = []
        for _ in range(200):
            a = rng.standard_normal(Ob.shape[1]); a /= np.linalg.norm(a)
            vD = Od @ a
            vD /= np.linalg.norm(vD)
            p, phin = psi1(vD)
            vals.append((p, phin))
        vals = np.array(vals)
        print(f"  ORBIT directions (branch exists -> must vanish):")
        print(f"    |Phi| max = {vals[:,1].max():.3e}   Psi_1: min={vals[:,0].min():+.3e} max={vals[:,0].max():+.3e}")

        # exact orbit curve: u = W''(0)/2 from the group, check the whole order-3 identity
        A = rng.standard_normal((ctx.n, ctx.n)); A -= A.T
        rho = rho_lambda2(A, ctx.pairs, ctx.pidx)
        vm = rho @ W - W @ rho
        s = np.linalg.norm(ctx.coord(vm))
        vm = vm / s
        um = 0.5 * (rho @ (rho @ W - W @ rho) - (rho @ W - W @ rho) @ rho) / (s * s)
        vD, uD = ctx.coord(vm), ctx.coord(um)
        g2 = ctx.coord(Qbil(vm, vm, ctx.c))
        print(f"    exact orbit curve: |L u + Pi Q(v)| = {np.linalg.norm(Lmat @ uD + g2):.3e}"
              f"   <G(v,u),v> = {float(ctx.coord(Qbil(vm, ctx.mat(uD), ctx.c)) @ vD):+.3e}")

        # random transverse directions and the p3b basis
        vals2 = []
        for _ in range(200):
            a = rng.standard_normal(T.shape[1]); a /= np.linalg.norm(a)
            vD = Td @ a; vD /= np.linalg.norm(vD)
            vals2.append(psi1(vD))
        vals2 = np.array(vals2)
        print(f"  RANDOM transverse directions:")
        print(f"    |Phi| range = [{vals2[:,1].min():.3e}, {vals2[:,1].max():.3e}]"
              f"   Psi_1: min={vals2[:,0].min():+.6f} max={vals2[:,0].max():+.6f}")

        # is Psi_1 constant on all of T?
        print(f"    Psi_1 spread over T = {vals2[:,0].max()-vals2[:,0].min():.3e}")

    # structure of the zero cone at S^3 x S^3: rank of the 18 quadrics
    st = analyse("S^3 x S^3", ctx, weyl_sphere_product_mop(L2, 3, 3))
    B, ker, T = st["B"], st["ker"], st["T"]
    Kd, Td = B @ ker, B @ T
    m = T.shape[1]
    mats = [ctx.mat(Td[:, a]) for a in range(m)]
    C = np.zeros((ker.shape[1], m, m))
    for i in range(m):
        for j in range(i, m):
            y = Kd.T @ ctx.coord(Qbil(mats[i], mats[j], ctx.c))
            C[:, i, j] = C[:, j, i] = y
    rows = []
    for k in range(C.shape[0]):
        S = C[k]
        rows.append(np.concatenate([np.diag(S), np.sqrt(2) * S[np.triu_indices(m, 1)]]))
    rows = np.array(rows)
    sv = np.linalg.svd(rows, compute_uv=False)
    print(f"\n##### structure of the second-order obstruction at S^3xS^3 #####")
    print(f"  the 18 components of Phi span a {int(np.sum(sv > 1e-8*sv[0]))}-dim space of quadratic forms on T")
    print(f"  singular values: {np.array2string(sv, precision=3)}")
    # how much of Phi lands in the orbit part vs the transverse part of K
    rng = np.random.default_rng(2)
    fo, ft = [], []
    for _ in range(200):
        a = rng.standard_normal(m); a /= np.linalg.norm(a)
        y = np.einsum('kij,i,j->k', C, a, a)          # in ker-coords
        yD = Kd @ y
        fo.append(np.linalg.norm((B @ st["Ob"]).T @ yD))
        ft.append(np.linalg.norm(Td.T @ yD))
    print(f"  |Phi| projected on orbit part of K:      mean {np.mean(fo):.4f}")
    print(f"  |Phi| projected on transverse part of K: mean {np.mean(ft):.4f}")


if __name__ == "__main__":
    main()
