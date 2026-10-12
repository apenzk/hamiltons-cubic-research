"""Is { S = 0 } open at the C_5 blow-up?  Answer: yes -- but NOT for the reason
this script tests.  Kept as a record of a method that does not settle the question.

WHAT THIS SCRIPT DOES.  Pushes Gauss-Newton correctors out along the 20 excess
E(1/2) directions of the C_5 blow-up and reports where they land.  Every one
returns to theta = 0.670820 with S = 0.

WHY THAT IS NEARLY VACUOUS (Reviewers 54 and 55).  The correctors walk back to the
BASE POINT -- median displacement 0.020 after pushes of 0.4 -- so "they return" says
little.  Worse, S > 0 critical points DO sit close: a shell of eight at residuals
4e-15..1e-13, theta in [0.669762, 0.671452] (within 0.16%), S in [0.041, 0.102], at
orbit distance 0.10 to 0.22.  And "same theta" is not a same-point test: pushes from
outside E(1/2) return the same theta with a DIFFERENT Lambda^2 spectrum.

WHAT ACTUALLY SETTLES IT.  A third-order argument, not a search: the criticality
Jacobian's kernel is exactly E(1/2); the quadratic obstruction vanishes identically
on E(1/2)^3 at this point specifically (2e-16 against scale 452, versus ~1e-2
elsewhere); the cubic form Psi is translation-invariant along the orbit; and
min ||Psi|| over the 20-dim excess sphere is 6e-4 to 9e-4 with zero of thousands of
starts below 1e-6.  So the tangent cone IS the orbit tangent.  See the Reviewer 54
and 55 scripts, which carry that computation.

PERFORMANCE NOTE, since two rewrites failed on it.  A finite-difference Jacobian
costs one function evaluation per unknown -- 770 here.  Replacing it with the
analytic Jacobian below does NOT help: that costs 770 circ calls per evaluation,
the same work.  The fix is to assemble 2 theta L_e - theta I once as a matrix, or
to use chord-Newton with the Jacobian frozen at the base point.  The reviewers'
rebuilds do this; this script does not, and the full 60-start sweep does not
complete here.

The analytic Jacobian is nonetheless correct: validated against finite differences
to 1.4e-10 in __main__, after an earlier version dropped the -(r.c) dc term.

import numpy as np, sys
from scipy.optimize import least_squares
from scipy.sparse.linalg import LinearOperator
sys.path.insert(0, 'scripts/lib')
from review_r30_core import (pair_index, adj, Q, circ, weyl_basis, orbit_tangent, orthonormalize)
from b_c5_blowup import c5_operator
from b_padded_s3s3 import slack

def setup():
    W, n = c5_operator([2] * 5)
    pairs, idx = pair_index(n); N = len(pairs); A = adj(n)
    th = float(np.tensordot(W, Q(n, W))); e = W / th
    B = np.array(weyl_basis(n)); D = len(B); Bf = B.reshape(D, -1)
    A2 = A.reshape(N * N, N)
    Ae = (A2 @ e).reshape(N, N, N); AeT = Ae.transpose(0, 2, 1).reshape(N, N * N)
    M = np.zeros((D, D))
    for j, X in enumerate(B):
        AX = (A2 @ X).reshape(N, N, N); T = AX.reshape(N, N * N) @ AeT.T
        M[:, j] = Bf @ (0.5 * (e @ X + X @ e) - 0.25 * (T + T.T)).ravel()
    ev, V = np.linalg.eigh(0.5 * (M + M.T))
    half = V[:, np.abs(ev - 0.5) < 1e-8]
    Ob = orthonormalize(orbit_tangent(n, W))
    Qq, _ = np.linalg.qr(np.array([Bf @ v for v in Ob]).T)
    P = half - Qq @ (Qq.T @ half)
    u, s, _ = np.linalg.svd(P, full_matrices=False)
    return W, n, N, A, B, Bf, u[:, s > 1e-8], th

def make_residual(n, B, Bf):
    """Return (resid, jac) for the criticality system on the unit sphere of Weyl_n.

    resid(c) = [ P_perp( Q(W) - theta W ) ; |c|^2 - 1 ] in Weyl coordinates.
    jac is analytic: a finite-difference Jacobian costs one function evaluation
    per unknown -- 770 here -- which turns a 60-start sweep into a multi-hour job.
    It is validated against finite differences in __main__.
    """
    tens = lambda c: np.einsum('d,dij->ij', c, B)

    def resid(c):
        Wc = tens(c); QW = Q(n, Wc); t = float(np.tensordot(Wc, QW))
        r = Bf @ (QW - t * Wc).ravel()
        return np.append(r - (r @ c) * c, np.dot(c, c) - 1.0)

    def jac(c):
        D = len(c)
        Wc = tens(c); QW = Q(n, Wc); t = float(np.tensordot(Wc, QW))
        r = Bf @ (QW - t * Wc).ravel()
        rc = r @ c
        J = np.empty((D + 1, D))
        for k in range(D):
            V = B[k]
            dQ = 2.0 * circ(n, Wc, V)
            dt = 2.0 * float(np.tensordot(V, QW))
            dr = Bf @ (dQ - t * V).ravel() - dt * c
            ek = np.zeros(D); ek[k] = 1.0
            # d[ r - (r.c) c ] = dr - (dr.c) c - (r.ek) c - (r.c) ek
            J[:-1, k] = dr - (dr @ c) * c - r[k] * c - rc * ek
            J[-1, k] = 2.0 * c[k]
        return J

    return resid, jac


def run():
    W, n, N, A, B, Bf, exc, th = setup()
    tens = lambda c: np.einsum('d,dij->ij', c, B)
    resid, jac = make_residual(n, B, Bf)
    c0 = Bf @ W.ravel()
    out = {}
    for i in range(exc.shape[1]):
        for t in (0.05, 0.2, 0.4):
            c = c0 + t * exc[:, i]; c /= np.linalg.norm(c)
            sol = least_squares(resid, c, jac=jac, method='lm',
                                xtol=1e-15, ftol=1e-15, gtol=1e-15, max_nfev=2000)
            if np.linalg.norm(resid(sol.x)) > 1e-5:
                out['not converged'] = out.get('not converged', 0) + 1
                continue
            Wn = tens(sol.x); Wn /= np.linalg.norm(Wn)
            thn = float(np.tensordot(Wn, Q(n, Wn)))
            if thn < 0: Wn, thn = -Wn, -thn
            S = slack(n, Wn, A, N) / (n - 2) ** 2
            key = (round(thn, 6), round(S, 4))
            out[key] = out.get(key, 0) + 1
    return exc.shape[1], out


if __name__ == "__main__":
    import numpy.random as _r
    W, n, N, A, B, Bf, exc, _th = setup()
    resid, jac = make_residual(n, B, Bf)
    rng = _r.default_rng(0); D = len(B)
    c = Bf @ W.ravel() + 0.05 * rng.normal(size=D); c /= np.linalg.norm(c)
    Ja = jac(c); h = 1e-6; errs = []
    for kk in rng.choice(D, 6, replace=False):
        e = np.zeros(D); e[kk] = h
        fd = (resid(c + e) - resid(c - e)) / (2 * h)
        errs.append(np.linalg.norm(Ja[:, kk] - fd) / max(1e-12, np.linalg.norm(fd)))
    print(f"analytic Jacobian vs finite differences: max rel err = {max(errs):.2e}")

    k, out = run()
    print(f"C_5 blow-up at n=10: {k} excess directions x 3 push distances")
    print(f"{'theta':>12} {'slack S':>10} {'count':>7}")
    for key, cnt in sorted(out.items(), key=lambda x: (isinstance(x[0], str), x[0])):
        if isinstance(key, str):
            print(f"{key:>23} {cnt:>7}")
        else:
            print(f"{key[0]:12.6f} {key[1]:10.4f} {cnt:>7}")
