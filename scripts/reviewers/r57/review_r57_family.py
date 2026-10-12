"""Reviewer 57: all critical points inside an invariant Weyl subspace.

Q is O(n)-equivariant, so it preserves the k-invariant subspace V of Weyl_n for
any subgroup k.  Restricting to V turns criticality into the IDEMPOTENT system

        Q(e) = e ,      e in V ,   e != 0 ,     theta = 1/||e|| ,  W = e/||e||,

a quadratic system in dim V unknowns:  sum_ij c_kij x_i x_j = x_k, with
c_kij = <V_k, B(V_i,V_j)> the restricted structure tensor.  Solved by dense
multistart Newton, which for small dim V finds every real solution.
"""
import numpy as np
from scipy.optimize import least_squares

from review_r57_core import Alg, Weyl


def restricted_tensor(n, V):
    """c[k,i,j] = <V_k, B(V_i,V_j)> with B the polarisation of Q (B(x,x)=Q(x))."""
    w = Weyl.get(n)
    alg = w.alg
    d = V.shape[1]
    Ws = [w.from_coords(V[:, i]) for i in range(d)]
    c = np.zeros((d, d, d))
    for i in range(d):
        for j in range(i, d):
            B = 0.5 * (Ws[i] @ Ws[j] + Ws[j] @ Ws[i]) + alg.sharp_bilinear(Ws[i], Ws[j])
            col = V.T @ w.coords(B)
            c[:, i, j] = col
            c[:, j, i] = col
    return c, Ws


def all_idempotents(c, starts=4000, seed=0, tol=1e-11):
    d = c.shape[0]
    rng = np.random.default_rng(seed)
    F = lambda x: np.einsum('kij,i,j->k', c, x, x, optimize=True) - x
    J = lambda x: 2 * np.einsum('kij,j->ki', c, x, optimize=True) - np.eye(d)
    sols = []
    for t in range(starts):
        x0 = rng.normal(size=d) * rng.uniform(0.2, 3.0)
        r = least_squares(F, x0, jac=J, xtol=1e-15, ftol=1e-15, gtol=1e-15)
        x = r.x
        if np.linalg.norm(F(x)) > tol or np.linalg.norm(x) < 1e-7:
            continue
        if not any(np.linalg.norm(x - s) < 1e-6 for s in sols):
            sols.append(x)
    return sols


def critical_points_in(n, V, starts=4000, seed=0):
    c, Ws = restricted_tensor(n, V)
    sols = all_idempotents(c, starts=starts, seed=seed)
    w = Weyl.get(n)
    out = []
    for x in sols:
        e = w.from_coords(V @ x)
        nrm = np.linalg.norm(e)
        W = e / nrm
        theta = 1.0 / nrm
        if theta < 0:
            W, theta = -W, -theta
        out.append((W, theta))
    out.sort(key=lambda t: -t[1])
    return out


if __name__ == "__main__":
    import sys
    from review_r57_points import (commutant_on_weyl, sp_m_gens, u_m_gens, su_m_gens,
                                   so_pq_gens, describe)

    print("== positive control: the u(m)-invariant line must return CP^m ==")
    for n in (8, 10):
        gens, _ = u_m_gens(n)
        V, _ = commutant_on_weyl(n, gens)
        for W, th in critical_points_in(n, V, starts=200, seed=1):
            describe(f"[control] CP^{n//2}", n, W)

    print("\n== positive control: so(p)+so(q)-invariant space ==")
    n = 8
    V, _ = commutant_on_weyl(n, so_pq_gens(n, [list(range(4)), list(range(4, 8))]))
    print(f"   dim = {V.shape[1]}")
    for W, th in critical_points_in(n, V, starts=800, seed=2):
        describe("[control] so(4)+so(4)-inv", n, W)

    print("\n== the hyperkahler family: sp(m)-invariant Weyl operators ==")
    for n in (8, 12):
        gens, _ = sp_m_gens(n, with_sp1=False)
        V, _ = commutant_on_weyl(n, gens)
        print(f"   n={n}: dim Weyl_n^{{sp({n//4})}} = {V.shape[1]}")
        pts = critical_points_in(n, V, starts=3000, seed=3)
        print(f"   distinct critical points: {len(pts)}")
        for k, (W, th) in enumerate(pts):
            describe(f"hyperkahler sp({n//4}) #{k}", n, W)
