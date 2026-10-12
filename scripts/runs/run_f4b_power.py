"""F4b by POWER ITERATION on Q, restricted to the graded block-diagonal Weyl space.

WHY POWER ITERATION AND NOT A SOLVER.  Least squares on the criticality residual costs
one numerical Jacobian per step, i.e. ~dim(space) evaluations of Q -- 155 at n = 8 and
395 at n = 10 -- so a single start runs tens of thousands of Q-evaluations and the sweep
never finishes.  The map

    W  |->  Pi(Q(W)) / ||Pi(Q(W))||,     Pi = orthogonal projection onto the space,

costs ONE evaluation per step and its fixed points are exactly the critical points with
theta > 0.  It converges to ATTRACTING fixed points, which are the local maxima of theta
on the sphere inside the space -- precisely what a falsifier hunt wants, since a
falsifier is a HIGH-theta point.

SYMMETRIC CRITICALITY licenses the restriction: the space is the fixed-point set of
conjugation by Lambda^2(diag(I_p, -I_q)), and the full Weyl_n gradient at a point of the
space was measured to have exactly zero mass off it.  So a fixed point here is a genuine
critical point of P on Weyl_n.

WHAT IS SCREENED at each fixed point: is_weyl, the full criticality residual in Weyl_n
(not the restricted one), S_mmm, Delta, dim m, the number of distinct positive
eigenvalues, and theta.  A solution whose sign pattern has drifted off (p positive,
m negative) is reported rather than silently kept, since that changes which set it is in.

CONTROL: the sphere product is a fixed point and must be returned from its own start.
"""
import sys
import numpy as np
sys.path.insert(0, 'scripts/lib')
sys.path.insert(0, 'scripts/runs')
from review_r30_core import sphere_product_W, Q, weyl_basis
from run_f4b_graded_multi import block_diagonal_weyl_basis
from b_symmetry_defect import defect
from weyl_screen import theta_screened


def iterate(basis, n, c, steps=4000, tol=1e-14):
    W = np.einsum('a,aij->ij', c, basis)
    W = W / np.linalg.norm(W)
    for k in range(steps):
        Wn = np.einsum('a,aij->ij', np.einsum('aij,ij->a', basis, Q(n, W)), basis)
        nn = np.linalg.norm(Wn)
        if nn < 1e-14:
            return None, k
        Wn = Wn / nn
        if np.linalg.norm(Wn - W) < tol:
            return Wn, k
        W = Wn
    return W, steps


def main(n, p, nstarts=40, kick=0.35, seed=1):
    basis, Pi, Mi = block_diagonal_weyl_basis(n, p)
    print(f"n = {n}, pair so({p})+so({n-p}); dim p = {len(Pi)}, dim m = {len(Mi)},"
          f" cap = {n*n//4}; space dim {basis.shape[0]}", flush=True)
    W0, _ = sphere_product_W([p, n - p]); W0 = W0 / np.linalg.norm(W0)
    c0 = np.einsum('aij,ij->a', basis, W0)
    rng = np.random.default_rng(seed)
    found = {}
    for t in range(nstarts):
        c = c0.copy() if t == 0 else (c0 + kick * rng.normal(size=basis.shape[0])
                                      if t < nstarts // 2 else rng.normal(size=basis.shape[0]))
        W, k = iterate(basis, n, c)
        if W is None:
            continue
        th, info = theta_screened(n, W)
        if th < 0:
            W, th = -W, -th
        res = float(np.abs(Q(n, W) - th * W).max())          # FULL residual in Weyl_n
        thg, ok, dm, D, tot, Smmm, Smpp, nz = defect(n, W)
        lam = np.linalg.eigvalsh(W)
        npos = len(set(np.round(lam[lam > 1e-9], 7)))
        key = (round(th, 6), npos, round(D, 3), dm)
        if key not in found:
            found[key] = (th, npos, D, Smmm, dm, nz, res, info['is_weyl'], k)
    print(f"  {'theta':>10s}{'#pos':>6s}{'Delta':>10s}{'S_mmm':>10s}{'dim m':>7s}"
          f"{'#0':>4s}{'full res':>10s}  weyl  steps", flush=True)
    for key in sorted(found, reverse=True):
        th, npos, D, Smmm, dm, nz, res, w, k = found[key]
        print(f"  {th:>10.6f}{npos:>6d}{D:>10.4f}{Smmm:>10.1e}{dm:>7d}{nz:>4d}"
              f"{res:>10.1e}  {str(w):5s} {k}", flush=True)
    good = [v for v in found.values() if v[3] < 1e-8 and v[2] > 1e-6 and v[6] < 1e-10]
    print(f"\n  critical, S = 0, Delta > 0: {len(good)}", flush=True)
    if good:
        b = max(good, key=lambda v: v[0])
        print(f"  highest theta among them: {b[0]:.6f}  (Delta={b[2]:.4f}, "
              f"#pos={b[1]}, dim m={b[4]})   threshold sqrt(3/2) = 1.224745", flush=True)
        print(f"  diagonal ceiling for comparison: 0.716134", flush=True)


if __name__ == '__main__':
    main(int(sys.argv[1]), int(sys.argv[2]))
