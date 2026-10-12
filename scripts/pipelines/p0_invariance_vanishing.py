"""
A PROOF, not a measurement: Q(x) is orthogonal to the orbit tangent for every
eigenvector x of F_u.

The trilinear form T with T(W,W,W) = P(W) is SO(n)-invariant, so for every
A in so(n) acting by derivation,

    T(A.x, y, z) + T(x, A.y, z) + T(x, y, A.z) = 0.

Put y = x and z = u.  Since A.u = [A,u] and those span the orbit tangent
T_u(SO(n).u) -- which is exactly the (1/2)theta*-eigenspace of F_u -- this reads

    T(x, x, [A,u]) = -2 T(A.x, x, u) = -2 <F_u(A.x), x> = -2 lambda <A.x, x> = 0,

using that F_u is symmetric with F_u x = lambda x, and that A is skew so
<A.x, x> = 0.

So for EVERY eigenvector x of F_u and every A in so(n):

    Q(x)  is orthogonal to  T_u(SO(n).u).

This is a FIFTH statement, separate from the four vanishings the repair rests
on, and it does NOT establish any of them.  Orthogonality to the orbit tangent is
one column of the 7x7 coupling table, while Q(V_{1/3}) contained in ker F_u + <u>
needs five components to vanish; the <u> component is forced and nonzero at
theta*/3.  The identity holds on every eigenspace while that containment fails on
four rows, so it cannot force it.

It is also inert for the bound: in the Remark 4.18 subdivision W_2 lies in
(R u + T_u orbit)^perp and so has no V_{1/2} component by construction.  The
coupling step needs Q(W_1) orthogonal to the three NEGATIVE eigenspaces, which
this identity does not reach.

The general law is exact -- T(x,y,[rho(A),u]) = (lambda-mu) theta* <A.x, y> for
x in V_lambda and y in V_mu, vanishing on the diagonal and reaching 0.91 off it --
and the argument never uses criticality of u.

Verified below at several n, on every eigenspace, as a check on the derivation
rather than as its evidence.
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from run_unconstrained_search import build_weyl_basis
from p0_tubular_hessian import fox_point, F_matrix

SQ32 = np.sqrt(1.5)


def orbit_basis(u, n, Eflat):
    pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    pidx = {p: t for t, p in enumerate(pairs)}
    vecs = []
    for a in range(n):
        for b in range(a + 1, n):
            A = np.zeros((n, n)); A[a, b] = 1.0; A[b, a] = -1.0
            rho = np.zeros((len(pairs), len(pairs)))
            for (i, j), col in pidx.items():
                for m in range(n):
                    if A[i, m] != 0.0 and m != j:
                        p = (min(m, j), max(m, j))
                        rho[pidx[p], col] += A[i, m] * (1 if m < j else -1)
                    if A[j, m] != 0.0 and i != m:
                        p = (min(i, m), max(i, m))
                        rho[pidx[p], col] += A[j, m] * (1 if i < m else -1)
            vecs.append(Eflat @ (rho @ u - u @ rho).reshape(-1))
    Vt = np.array(vecs)
    U, sv, _ = np.linalg.svd(Vt.T, full_matrices=False)
    return U[:, sv > 1e-8 * sv[0]]


def run(n, samples=40, seed=1):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    u, th, _ = fox_point(n, L2, Eflat, c)
    Nl = u.shape[0]
    M = F_matrix(u, c, Eflat)
    w, V = np.linalg.eigh(M)
    ratio = w / SQ32
    Ob = orbit_basis(u, n, Eflat)
    rng = np.random.default_rng(seed)
    print(f"n={n:3d}  orbit dim={Ob.shape[1]}   max |<Q(x), orbit>| / |Q(x)| over each eigenspace:")
    lo = 0
    while lo < len(ratio):
        hi = lo
        while hi + 1 < len(ratio) and abs(ratio[hi + 1] - ratio[lo]) < 1e-7:
            hi += 1
        B = V[:, lo:hi + 1]
        worst = 0.0
        for _ in range(samples):
            y = rng.normal(size=B.shape[1]); y /= np.linalg.norm(y)
            X = (Eflat.T @ (B @ y)).reshape(Nl, Nl)
            X = 0.5 * (X + X.T); X /= max(np.linalg.norm(X), 1e-300)
            q = Eflat @ Q_full(X, c).reshape(-1)
            nq = np.linalg.norm(q)
            if nq > 1e-300:
                worst = max(worst, np.linalg.norm(Ob.T @ q) / nq)
        print(f"      eigenvalue {ratio[lo]:+.4f} (mult {hi-lo+1:5d}):  {worst:.3e}")
        lo = hi + 1
    print(flush=True)


if __name__ == "__main__":
    for n in (8, 10, 12):
        run(n)
