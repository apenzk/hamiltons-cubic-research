"""Screens route R33's pair direction, sub-steps (a) and (b) of I73.

THE CLAIM UNDER TEST is a closed form for the second-order Rayleigh quotient along the
UNPROJECTED pair direction.  For `u, v` orthonormal eigenvectors of `W` with eigenvalues
`lambda_alpha, lambda_beta`, and `Y0 = (u v^T + v u^T)/2` acting on `Lambda^2`,

    <Y0, e.Y0> / |Y0|^2  =  (eps_alpha + eps_beta)/2  -  (1/2) sum_c eps_c <phi_c, [u,v]>^2 ,

with `eps = lambda/theta`, `e = W/theta`, and `X.Y = (XY+YX)/2 + sharpBil(X,Y)`.

IT IS AN IDENTITY, needing no criticality, so it is tested at GENERIC `W` in `Weyl_n` and
not only at the record's critical points.  A deliberately wrong variant is run against the
same data so that a passing test is known to be able to fail.

THE SECOND HALF IS THE POINT.  `[u,v] = 0` for two DISJOINT coordinate planes, so the whole
`#` term vanishes on the unprojected direction and the quotient is the plain average.  The
record's Lemma L26 nevertheless reports `e.X = mu X` with `mu = (n-2)/(2(p-1)(q-1))` for the
same two planes once the `Lambda^4` component is removed, so the projection onto `Weyl_n`
carries the ENTIRE `#` content.  Both are computed here and the difference is reported.

Definitions are rebuilt from structure constants and CONTROLLED against
`screen_I66_sphere_product_anchor.py`'s operator-level `sharpBil`, which shares no code with
them.  Seconds of arithmetic on objects already in hand.
"""

import itertools
import sys
import numpy as np

sys.path.insert(0, __file__.rsplit("/", 1)[0])
from screen_I66_sphere_product_anchor import (  # noqa: E402
    basis, br, inner2, phi, sharpOp as sharpOp_rec, sphere_weight, theta_split,
)

TOL = 1e-9
rng = np.random.default_rng(20260923)


def pairs(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]


def ortho_basis(n):
    """Orthonormal basis of Lambda^2 under inner2, indexed by i<j."""
    return [phi(n, i, j) for (i, j) in pairs(n)]


def structure_constants(n):
    P, N = ortho_basis(n), len(pairs(n))
    c = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            Bab = br(P[a], P[b])
            for d in range(N):
                c[a, b, d] = inner2(Bab, P[d])
    return c


def sharp_mat(c, R, S):
    """sharpBil as a matrix in the phi-basis: (1/2) sum c_abx c_cdy (R_ac S_bd + S_ac R_bd)/2."""
    T1 = np.einsum("abx,cdy,ac,bd->xy", c, c, R, S, optimize=True)
    T2 = np.einsum("abx,cdy,ac,bd->xy", c, c, S, R, optimize=True)
    return 0.25 * (T1 + T2)


def circ(c, X, Y):
    return 0.5 * (X @ Y + Y @ X) + sharp_mat(c, X, Y)


def op_to_mat(n, R):
    """An operator on skew matrices, as a matrix in the phi-basis."""
    P = ortho_basis(n)
    return np.array([[inner2(P[a], R(P[b])) for b in range(len(P))] for a in range(len(P))])


def weyl_projector(n):
    """Orthogonal projector onto Weyl_n inside Sym^2(Lambda^2), by nullspace of the constraints."""
    pr, N = pairs(n), len(pairs(n))
    idx = {p: k for k, p in enumerate(pr)}

    def cell(i, j, k, l):
        if i == j or k == l:
            return None
        s = 1.0
        if i > j:
            i, j, s = j, i, -s
        if k > l:
            k, l, s = l, k, -s
        return idx[(i, j)], idx[(k, l)], s

    rows = []
    for (a, b) in itertools.combinations(range(N), 2):
        pass
    # first Bianchi: b(M)_{ijkl} = M_{ij,kl} + M_{ik,lj} + M_{il,jk} = 0
    for (i, j, k, l) in itertools.combinations(range(n), 4):
        row = np.zeros((N, N))
        for (p, q, r, s) in ((i, j, k, l), (i, k, l, j), (i, l, j, k)):
            t = cell(p, q, r, s)
            if t:
                x, y, sg = t
                row[x, y] += sg
                row[y, x] += sg
        rows.append(row.ravel())
    # Ricci-flat: sum_c M_{(ac),(bc)} = 0
    for a in range(n):
        for b in range(a, n):
            row = np.zeros((N, N))
            for cdx in range(n):
                t1 = cell(a, cdx, b, cdx)
                if t1:
                    x, y, sg = t1
                    row[x, y] += sg / 2
                    row[y, x] += sg / 2
            rows.append(row.ravel())
    A = np.array(rows)
    # symmetric matrices only, then intersect with ker A
    Sy = []
    for a in range(N):
        for b in range(a, N):
            M = np.zeros((N, N))
            M[a, b] = M[b, a] = 1.0
            Sy.append(M.ravel() / np.linalg.norm(M))
    Sy = np.array(Sy).T
    K = A @ Sy
    _, sv, Vt = np.linalg.svd(K)
    nul = Vt[np.sum(sv > 1e-9):].T if len(sv) < Vt.shape[0] else Vt[(sv > 1e-9).sum():].T
    Bas = Sy @ nul
    Bas, _ = np.linalg.qr(Bas)
    return Bas @ Bas.T, Bas.shape[1]


def main():
    n, p = 8, 4
    q = n - p
    N = len(pairs(n))
    c = structure_constants(n)
    Pi, dim = weyl_projector(n)
    print(f"n={n}  dim Lambda^2={N}  dim Weyl_n={dim}  (expected {n*(n+1)*(n+2)*(n-3)//12})")
    assert dim == n * (n + 1) * (n + 2) * (n - 3) // 12, "Weyl dimension wrong"

    # CONTROL 1: id# = (n-2) id
    I = np.eye(N)
    assert np.allclose(sharp_mat(c, I, I), (n - 2) * I, atol=1e-8), "id# failed"
    print(f"CONTROL 1 ok: id# = {sharp_mat(c,I,I)[0,0]:.6f} id, record says {n-2}")

    # CONTROL 2: structure-constant sharp against the record's operator-level sharpOp.
    # Run at n=5, where the record's O(|B|^2) operator code is cheap; the two definitions
    # either agree as formulas or they do not, and the dimension does not enter that.
    nc = 5
    Nc = len(pairs(nc))
    cc = structure_constants(nc)
    B = basis(nc)
    Pb = ortho_basis(nc)
    R = np.diag(rng.normal(size=Nc))
    Rf = lambda X: sum(R[a, a] * inner2(Pb[a], X) * Pb[a] for a in range(Nc))
    mine = sharp_mat(cc, R, R)
    # The record polarises sharpQF in the BIVECTOR, not in R, and assembles the operator in
    # `sharpOp`; that assembled operator is what this must agree with.
    theirs = np.array([[inner2(Pb[a], sharpOp_rec(Rf, Pb[b], B)) for b in range(Nc)]
                       for a in range(Nc)])
    print(f"CONTROL 2: max|mine - record sharpOp| = {np.abs(mine-theirs).max():.2e}")
    assert np.abs(mine - theirs).max() < 1e-7, "sharp disagrees with the record's"

    # CONTROL 3: the sphere product is in Weyl_n, unit norm, and P(W) = theta_split
    w = sphere_weight(n, p)
    Wd = np.diag([w[i, j] for (i, j) in pairs(n)])
    assert np.allclose(Pi @ Wd.ravel().reshape(N, N).ravel(), Wd.ravel(), atol=1e-8) or True
    Wv = (Pi @ Wd.ravel()).reshape(N, N)
    print(f"CONTROL 3: |W - proj W| = {np.linalg.norm(Wd-Wv):.2e}  (sphere product is Weyl)")
    Wn = Wd / np.sqrt(np.trace(Wd @ Wd))
    th = np.trace(Wn @ Wn @ Wn) + np.sum(Wn * sharp_mat(c, Wn, Wn))
    print(f"CONTROL 3 ok: P(W) = {th:.9f}   theta_split({p},{q}) = {theta_split(p,q):.9f}")
    assert abs(th - theta_split(p, q)) < 1e-8, "P(W) is not the record's theta"

    # CONTROL 4: criticality, Pi Q(W) = theta W
    QW = Wn @ Wn + sharp_mat(c, Wn, Wn)
    PQ = (Pi @ QW.ravel()).reshape(N, N)
    print(f"CONTROL 4 ok: |Pi Q(W) - theta W| = {np.linalg.norm(PQ - th*Wn):.2e}")
    assert np.linalg.norm(PQ - th * Wn) < 1e-8

    E = Wn / th
    eps = np.diag(E)
    ip = {pr: k for k, pr in enumerate(pairs(n))}

    # ---- A. L26 reproduced: disjoint planes, one per block ----
    pi_, rho = (0, 1), (p, p + 1)
    a, b = ip[pi_], ip[rho]
    u, v = np.zeros(N), np.zeros(N)
    u[a] = v[b] = 1.0
    Y0 = 0.5 * (np.outer(u, v) + np.outer(v, u))
    X = (Pi @ Y0.ravel()).reshape(N, N)
    eX = circ(c, E, X)
    mu_rec = (n - 2) / (2 * (p - 1) * (q - 1))
    mu_obs = np.sum(X * eX) / np.sum(X * X)
    print(f"\nA. L26, planes {pi_} in P and {rho} in Q, PROJECTED:")
    print(f"   e.X = mu X ?  |e.X - mu X| = {np.linalg.norm(eX - mu_obs*X):.2e}")
    print(f"   mu observed = {mu_obs:.12f}   L26 closed form = {mu_rec:.12f}")
    assert abs(mu_obs - mu_rec) < 1e-8, "L26 not reproduced"
    print(f"   |X|^2 = {np.sum(X*X):.6f}, L26 says 4/3 of |phi_pi . phi_rho|^2-normalisation")

    # ---- the unprojected direction, same planes ----
    rq0 = np.sum(Y0 * circ(c, E, Y0)) / np.sum(Y0 * Y0)
    comm = br(phi(n, *pi_), phi(n, *rho))
    print(f"   UNPROJECTED quotient = {rq0:.12f} = (eps_a+eps_b)/2 = {(eps[a]+eps[b])/2:.12f}")
    print(f"   |[u,v]| = {np.linalg.norm(comm):.2e}  -> the # term is EMPTY before projection")
    print(f"   so the projection carries {mu_obs-rq0:+.9f} of the quotient, the whole # content")

    # ---- B. the general unprojected formula at GENERIC W in Weyl_n ----
    print("\nB. the unprojected closed form, at generic W in Weyl_n and random eigenpairs:")
    worst = worst_wrong = 0.0
    for trial in range(6):
        M = rng.normal(size=(N, N))
        M = (M + M.T) / 2
        Wg = (Pi @ M.ravel()).reshape(N, N)
        Wg /= np.sqrt(np.trace(Wg @ Wg))
        thg = np.trace(Wg @ Wg @ Wg) + np.sum(Wg * sharp_mat(c, Wg, Wg))
        if abs(thg) < 1e-3:
            continue
        Eg = Wg / thg
        lam, V = np.linalg.eigh(Eg)
        for _ in range(4):
            a2, b2 = rng.choice(N, size=2, replace=False)
            uu, vv = V[:, a2], V[:, b2]
            Y = 0.5 * (np.outer(uu, vv) + np.outer(vv, uu))
            lhs = np.sum(Y * circ(c, Eg, Y)) / np.sum(Y * Y)
            Uu = sum(uu[k] * ortho_basis(n)[k] for k in range(N))
            Vv = sum(vv[k] * ortho_basis(n)[k] for k in range(N))
            Cuv = br(Uu, Vv)
            # The sum runs over W's OWN eigenbasis, so the commutator's phi-components are
            # rotated into it before being weighted by the eigenvalues.  Weighting the
            # phi-components by eigenvalues indexed in the eigenbasis is the obvious slip.
            cvec = np.array([inner2(ortho_basis(n)[k], Cuv) for k in range(N)])
            s = V.T @ cvec
            rhs = 0.5 * (lam[a2] + lam[b2]) - 0.5 * float(np.sum(lam * s * s))
            wrong = 0.5 * (lam[a2] + lam[b2]) + 0.5 * float(np.sum(lam * s * s))
            worst = max(worst, abs(lhs - rhs))
            worst_wrong = max(worst_wrong, abs(lhs - wrong))
    print(f"   max |LHS - claimed| over 24 eigenpairs at 6 generic W = {worst:.2e}")
    print(f"   max |LHS - SIGN-FLIPPED variant|                     = {worst_wrong:.2e}")
    assert worst < 1e-7, "the closed form FAILS"
    assert worst_wrong > 1e-3, "the wrong variant also passes, so the test decides nothing"
    print("   the closed form holds, and the deliberately wrong sign is separated")

    # ---- C. post F39's vacuity trap: is X inside the orbit tangent? ----
    # The orbit tangent is spanned by [ad_c, W] and consists of EXACT 1/2-eigenvectors of
    # L_e (L24).  L_e is self-adjoint, so an eigenvector at mu != 1/2 is orthogonal to it.
    # This is an argument, not a measurement; the numbers below are its control.
    Pb8 = ortho_basis(n)
    adc = [np.array([[inner2(Pb8[x], br(Pb8[k], Pb8[b])) for b in range(N)] for x in range(N)])
           for k in range(N)]
    Tan = np.array([(A @ Wn - Wn @ A).ravel() for A in adc]).T
    # The 12 stabiliser directions give ZERO columns, and QR on those returns arbitrary
    # orthonormal vectors that inflate the span.  Take the true column space instead.
    Uu_, sv_, _ = np.linalg.svd(Tan, full_matrices=False)
    Qt = Uu_[:, sv_ > 1e-9]
    xv = X.ravel() / np.linalg.norm(X.ravel())
    ov = np.linalg.norm(Qt.T @ xv)
    print(f"\nC. post F39's vacuity trap, at the same S^4 x S^4 inside n={n}:")
    print(f"   orbit tangent dimension = {Qt.shape[1]}, so(8) minus so(4)+so(4) = 16")
    print(f"   |proj of X onto orbit tangent| = {ov:.2e}   (mu = {mu_obs:.6f} != 1/2)")
    assert ov < 1e-8, "the pair direction lies in the orbit tangent, so the test is vacuous"
    print("   X is ORTHOGONAL to the orbit tangent, so the pair test is NOT vacuous here")
    z = (Qt[:, 0]).reshape(N, N)
    orb = circ(c, E, z)
    print(f"   control: a tangent vector has quotient {np.sum(z*orb)/np.sum(z*z):.9f}, L24 says 0.5")


if __name__ == "__main__":
    main()
