"""
The remaining symmetric-subalgebra class of family A: (so(2m), u(m)).

Symmetric subalgebras of so(N) are classified up to conjugacy as so(j)+so(N-j)
and u(N/2).  The block ones are the sphere products, already swept and provably
defect-free.  The unitary one was rejected by the two-eigenvalue screen because
u(m) = su(m) + u(1) is not simple, so it never got a value -- yet it is exactly
the class one expects to be DEFECTIVE, since u(m) admits the invariant 4-form
omega ^ omega.  This script builds it directly.

Construction: fix a complex structure J on R^{2m}.  Then
    E+ = u(m) = { A in so(2m) : [A, J] = 0 },      dim m^2
    E- = m    = its orthogonal complement in so(2m), dim m(m-1),
and u(m) splits into ideals su(m) (dim m^2 - 1) and the centre R.J (dim 1).
The ideal-wise ansatz is W = a1 Pi_su + a2 Pi_J - b Pi_m; criticality
Q(W) = theta W is solved numerically over (a1, a2, b) on the unit sphere with
the validated Q_full, then theta and delta^2 are read off.

This closes family A: every symmetric subalgebra of so(N) is now accounted for.
"""
import numpy as np
from scipy.optimize import fsolve

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import delta2_and_grad

SQ32 = np.sqrt(1.5)


def projections(L2, m):
    """Pi_su(m), Pi_{R.J}, Pi_m inside Lambda^2 R^{2m}, for the standard J."""
    n = 2 * m
    J = np.zeros((n, n))
    for i in range(m):
        J[2 * i, 2 * i + 1], J[2 * i + 1, 2 * i] = 1.0, -1.0
    N = L2.N
    # adjoint action of J on Lambda^2: A -> [J, A]; ker = u(m), and the
    # centre is spanned by J itself viewed as a bivector.
    adJ = np.zeros((N, N))
    for a, (i, j) in enumerate(L2.pairs):
        M = np.zeros((n, n))
        M[i, j], M[j, i] = 1.0, -1.0
        adJ[:, a] = L2.matrix_to_vec(J @ M - M @ J)
    ev, V = np.linalg.eigh(adJ.T @ adJ)
    ker = V[:, ev < 1e-8]                      # u(m)
    Pu = ker @ ker.T
    jv = L2.matrix_to_vec(J)
    jv = jv / np.linalg.norm(jv)
    PJ = np.outer(jv, jv)
    Psu = Pu - PJ
    Pm = np.eye(N) - Pu
    return Psu, PJ, Pm, int(round(np.trace(Psu))), int(round(np.trace(Pm)))


def solve(L2, c, m, alt_idx):
    Psu, PJ, Pm, dsu, dm = projections(L2, m)

    def resid(z):
        """Criticality in the two non-radial invariant directions, plus
        trace-freeness -- which is what makes W Ricci-flat here, since h = so(2m)
        acts irreducibly on R^{2m} and so forces Ric(W) to be a multiple of the
        identity.  Omitting it (the first version of this script did) lets the
        solver drift onto non-Weyl operators with |Ric| of order 1."""
        a1, a2, b = z
        W = a1 * Psu + a2 * PJ - b * Pm
        nrm = np.linalg.norm(W)
        if nrm < 1e-12:
            return [1e3, 1e3, 1e3]
        W = W / nrm
        QW = Q_full(W, c)
        th = float(np.sum(W * QW))
        R = QW - th * W
        return [float(np.sum(R * Psu)), float(np.sum(R * Pm)), float(np.trace(W))]

    best = None
    rng = np.random.default_rng(0)
    for _ in range(400):
        z0 = rng.normal(size=3)
        z0[2] = abs(z0[2])
        try:
            z, info, ier, _ = fsolve(resid, z0, full_output=True)
        except Exception:
            continue
        if ier != 1 or max(abs(np.array(resid(z)))) > 1e-10:
            continue
        a1, a2, b = z
        W = a1 * Psu + a2 * PJ - b * Pm
        if np.linalg.norm(W) < 1e-9:
            continue
        W = W / np.linalg.norm(W)
        QW = Q_full(W, c)
        th = float(np.sum(W * QW))
        if th < 0:
            W, th = -W, -th
        res = np.linalg.norm(QW - float(np.sum(W * Q_full(W, c))) * W) / max(np.linalg.norm(QW), 1e-300)
        ric = np.max(np.abs(ricci_from_mop(L2, W)))
        alt = np.linalg.norm(build_alt_apply(W, alt_idx)) if False else 0.0
        d2 = delta2_and_grad(W, alt_idx)[0]
        if ric > 1e-8:      # reject non-Weyl solutions outright
            continue
        if th > 1e-9 and (best is None or th > best[0]):
            best = (th, d2, res, ric, dsu, dm, np.sort(np.linalg.eigvalsh(W))[::-1])
    return best


print(f"{'n':>4} {'dim su':>7} {'dim m':>6} {'theta':>13} {'delta^2':>12} "
      f"{'resid':>9} {'maxRic':>9}   vs sqrt(3/2)")
print("-" * 88)
for m in (3, 4, 5, 6):
    n = 2 * m
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    alt_idx = build_alt_indices(L2)
    r = solve(L2, c, m, alt_idx)
    if r is None:
        print(f"{n:>4} {'--':>7} {'--':>6}   no critical point of this shape found")
        continue
    th, d2, res, ric, dsu, dm, spec = r
    flag = "ABOVE" if th > SQ32 else "below"
    print(f"{n:>4} {dsu:>7} {dm:>6} {th:>13.9f} {d2:>12.9f} {res:>9.1e} {ric:>9.1e}   {flag}")
print("-" * 88)
print(f"sqrt(3/2) = {SQ32:.9f}")
print("\n(so(2m), u(m)) is the symmetric space SO(2m)/U(m); u(m) carries the invariant")
print("4-form omega^omega, so this is the class where a nonzero defect is expected.")
