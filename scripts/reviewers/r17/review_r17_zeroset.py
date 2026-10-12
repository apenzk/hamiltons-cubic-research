"""Reviewer 17: is the second-order obstruction nonzero on ALL of the transverse
kernel, or only on the 9 arbitrary SVD basis vectors p3b happens to test?

Phi(v) = Pi_ker Pi_Weyl Q(v) is QUADRATIC in v, so nonvanishing on a basis says
nothing about the rest of the space.  Here: (i) positive control on the orbit
directions, where a branch provably exists and Phi MUST vanish; (ii) global
minimisation of |Phi(v)|/|v|^2 over the unit sphere of the transverse kernel.
"""
import numpy as np
from scipy.optimize import minimize
from curvature_operator import Lambda2
from review_r11_graded_law import weyl_sphere_product_mop
from run_defect_max_hunt import su_m_kahler_weyl
from review_r17_obstruction import Ctx, analyse, Qbil


def tensor(st, basis):
    """C[k,i,j]: Phi(v)_k = sum_ij C[k,i,j] v_i v_j for v in span(basis cols)."""
    ctx, B, ker = st["ctx"], st["B"], st["ker"]
    m = basis.shape[1]
    mats = [ctx.mat(B @ basis[:, a]) for a in range(m)]
    C = np.zeros((ker.shape[1], m, m))
    for i in range(m):
        for j in range(i, m):
            y = ker.T @ (B.T @ ctx.coord(Qbil(mats[i], mats[j], ctx.c)))
            C[:, i, j] = y
            C[:, j, i] = y
    return C


def phi(C, v):
    return np.einsum('kij,i,j->k', C, v, v)


def scan(name, st, seed=0, nstart=4000):
    T, ker, Ob = st["T"], st["ker"], st["Ob"]
    print(f"\n##### {name}: obstruction zero-set scan #####")

    # --- positive control: orbit directions carry a genuine branch (the orbit),
    #     so Phi must vanish identically there.
    Corb = tensor(st, Ob)
    rng = np.random.default_rng(12345)
    worst = 0.0
    for _ in range(500):
        v = rng.standard_normal(Ob.shape[1]); v /= np.linalg.norm(v)
        worst = max(worst, np.linalg.norm(phi(Corb, v)))
    print(f"  POSITIVE CONTROL  max |Phi(v)| over 500 random orbit directions = {worst:.3e}")
    print(f"                    max |C_orbit| entry                          = {np.abs(Corb).max():.3e}")

    # --- the p3b test: the SVD basis of T, one vector at a time
    C = tensor(st, T)
    diag = np.array([np.linalg.norm(C[:, a, a]) for a in range(T.shape[1])])
    # p3b normalises by |Pi_Weyl Q(v)| not by |v|^2; reproduce both
    denom = []
    for a in range(T.shape[1]):
        M = st["ctx"].mat(st["B"] @ T[:, a])
        denom.append(np.linalg.norm(st["B"].T @ st["ctx"].coord(Qbil(M, M, st["ctx"].c))))
    denom = np.array(denom)
    print(f"  p3b-style basis test |Phi(e_a)|/|Q(e_a)| = {np.array2string(diag/denom, precision=3)}")

    # --- global minimisation of |Phi(v)|^2 over the unit sphere of T
    m = T.shape[1]

    def f(x):
        nx = np.linalg.norm(x)
        v = x / nx
        p = phi(C, v)
        val = float(p @ p)
        # gradient of |Phi(v)|^2 wrt x
        gv = 4.0 * np.einsum('k,kij,j->i', p, C, v)
        g = (gv - (gv @ v) * v) / nx
        return val, g

    rng = np.random.default_rng(seed)
    best = (np.inf, None)
    vals = []
    for _ in range(nstart):
        x0 = rng.standard_normal(m)
        r = minimize(f, x0, jac=True, method="L-BFGS-B",
                     options=dict(maxiter=800, ftol=1e-18, gtol=1e-14))
        v = r.x / np.linalg.norm(r.x)
        val = float(np.linalg.norm(phi(C, v)))
        vals.append(val)
        if val < best[0]:
            best = (val, v)
    vals = np.array(vals)
    print(f"  GLOBAL MIN of |Phi(v)| over unit sphere in T ({m}-dim), {nstart} starts:")
    print(f"    min={vals.min():.6e}  5th pct={np.percentile(vals,5):.4e}  median={np.percentile(vals,50):.4e}  max={vals.max():.4e}")
    v = best[1]
    print(f"    argmin v = {np.array2string(v, precision=4)}")
    print(f"    |Phi(v)| = {np.linalg.norm(phi(C,v)):.6e}   (Phi is quadratic; |v|=1)")
    # scale of the map for reference
    sc = np.median([np.linalg.norm(phi(C, rng.standard_normal(m)/np.sqrt(m))) for _ in range(200)])
    print(f"    typical |Phi| at random unit v = {np.median([np.linalg.norm(phi(C, (lambda z: z/np.linalg.norm(z))(rng.standard_normal(m)))) for _ in range(200)]):.4e}")
    return C, best


if __name__ == "__main__":
    ctx6 = Ctx(6)
    L2_6 = Lambda2(6)
    st1 = analyse("S^3 x S^3", ctx6, weyl_sphere_product_mop(L2_6, 3, 3))
    scan("S^3 x S^3", st1)
    st2 = analyse("su(3) Kahler", ctx6, su_m_kahler_weyl(L2_6, 3))
    scan("su(3) Kahler", st2)
