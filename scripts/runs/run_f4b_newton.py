"""F4b with an EXACT Jacobian, so the solve can reach saddles.

WHY THE TWO EARLIER METHODS COULD NOT.  Least squares with a numerical Jacobian costs
dim(space) evaluations of Q per step -- 155 at n = 8, 395 at n = 10 -- so a sweep never
finishes.  Power iteration W -> Pi(Q(W))/||.|| costs one evaluation per step and is exact
on its control, but converges only to ATTRACTING fixed points; a falsifier here would be
a saddle, so its null result is uninformative.  That is fence post 13's shape.

THE JACOBIAN, with its constants pinned from the definition rather than from a name:
sharp_bilin(W,W) = sharp(W) exactly, and d/dt sharp(W+tH) = 2 sharp_bilin(W,H) (checked
against a central difference, 1e-8).  So

    DQ(W)[H] = W H + H W + 2 sharp_bilin(W, H),

and with an orthonormal basis {B_a} of the graded block-diagonal Weyl space, residual
F_a = <B_a, Q(W) - theta W> and theta = <Q(W), W>, the exact Jacobian is

    J_ab = <B_a, DQ(W)[B_b]> - 3 <Q(W), B_b> <B_a, W> - theta delta_ab ,

using that P is cubic, so dP/dc_b = 3 <Q(W), B_b>.

SYMMETRIC CRITICALITY licenses the restriction and was measured, not assumed: the space
is the fixed-point set of conjugation by Lambda^2(diag(I_p, -I_q)), and the full Weyl_n
gradient at points of the space carries exactly zero mass off it.  Every solution is
screened against the FULL Weyl_n residual regardless.

CONTROL: the sphere product must be returned from its own start at residual ~1e-16.
"""
import sys
import numpy as np
from scipy.optimize import least_squares
sys.path.insert(0, 'scripts/lib')
sys.path.insert(0, 'scripts/runs')
from review_r30_core import sphere_product_W, Q, sharp_bilin
from run_f4b_graded_multi import block_diagonal_weyl_basis
from b_symmetry_defect import defect
from weyl_screen import theta_screened


def make(n, basis):
    def unpack(c):
        W = np.einsum('a,aij->ij', c, basis)
        return W

    def resid(c):
        W = unpack(c)
        QW = Q(n, W)
        th = float(np.tensordot(QW, W))
        F = np.einsum('aij,ij->a', basis, QW - th * W)
        return np.append(F, float(c @ c) - 1.0)

    def jac(c):
        W = unpack(c)
        QW = Q(n, W)
        th = float(np.tensordot(QW, W))
        DQ = np.array([W @ B + B @ W + 2.0 * sharp_bilin(n, W, B) for B in basis])
        M = np.einsum('aij,bij->ab', basis, DQ)
        gq = np.einsum('ij,bij->b', QW, basis)
        Bw = np.einsum('aij,ij->a', basis, W)
        J = M - 3.0 * np.outer(Bw, gq) - th * np.eye(len(c))
        return np.vstack([J, 2.0 * c])

    return resid, jac


def main(n, p, nstarts=30, kick=0.5, seed=2):
    basis, Pi, Mi = block_diagonal_weyl_basis(n, p)
    resid, jac = make(n, basis)
    print(f"n = {n}, pair so({p})+so({n-p}); dim m = {len(Mi)}, cap = {n*n//4};"
          f" space dim {basis.shape[0]}", flush=True)
    W0, _ = sphere_product_W([p, n - p]); W0 = W0 / np.linalg.norm(W0)
    c0 = np.einsum('aij,ij->a', basis, W0)
    print(f"  control: |resid(c0)| = {np.abs(resid(c0)).max():.2e}", flush=True)
    rng = np.random.default_rng(seed)
    found = {}
    for t in range(nstarts):
        c = c0.copy() if t == 0 else c0 + kick * rng.normal(size=len(c0))
        s = least_squares(resid, c, jac=jac, xtol=1e-14, ftol=1e-14, gtol=1e-14,
                          max_nfev=200)
        if np.abs(s.fun).max() > 1e-10:
            continue
        W = np.einsum('a,aij->ij', s.x, basis)
        W = W / np.linalg.norm(W)
        th, info = theta_screened(n, W)
        if th < 0:
            W, th = -W, -th
        full = float(np.abs(Q(n, W) - th * W).max())
        thg, ok, dm, D, tot, Smmm, Smpp, nz = defect(n, W)
        lam = np.linalg.eigvalsh(W)
        npos = len(set(np.round(lam[lam > 1e-9], 7)))
        key = (round(th, 6), npos, round(D, 3), dm)
        found.setdefault(key, (th, npos, D, Smmm, dm, nz, full, info['is_weyl']))
        if t % 5 == 0:
            print(f"    start {t}/{nstarts}  distinct {len(found)}", flush=True)
    print(f"\n  {'theta':>10s}{'#pos':>6s}{'Delta':>10s}{'S_mmm':>10s}{'dim m':>7s}"
          f"{'#0':>4s}{'full res':>10s}  weyl", flush=True)
    for k in sorted(found, reverse=True):
        th, npos, D, Smmm, dm, nz, full, w = found[k]
        print(f"  {th:>10.6f}{npos:>6d}{D:>10.4f}{Smmm:>10.1e}{dm:>7d}{nz:>4d}"
              f"{full:>10.1e}  {w}", flush=True)
    good = [v for v in found.values() if v[3] < 1e-8 and v[2] > 1e-6 and v[6] < 1e-10]
    print(f"\n  critical, S = 0, Delta > 0: {len(good)}", flush=True)
    if good:
        b = max(good, key=lambda v: v[0])
        print(f"  highest theta among them: {b[0]:.6f}  Delta={b[2]:.4f}  #pos={b[1]}"
              f"  dim m={b[4]}   sqrt(3/2) = 1.224745   diagonal ceiling 0.716134",
              flush=True)


if __name__ == '__main__':
    main(int(sys.argv[1]), int(sys.argv[2]))
