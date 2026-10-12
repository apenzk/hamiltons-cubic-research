"""
Can differentiated invariance reach the vanishing that is NOT inert?

Reviewer 20 established the exact law for the contraction against the orbit
tangent,

    T(x, y, [rho(A), u]) = (lambda - mu) theta* <A.x, y>,   x in V_lambda, y in V_mu,

and showed it is inert for the Theorem 4.17 repair: W_2 already has no V_{1/2}
component.  What the coupling step actually needs is

    T(W_1, W_1, N) = 0    for W_1 in V_{1/3} and N in a strictly negative eigenspace,

which is a different contraction and is so far only measured.

Two routes are tried here, both from the same invariance identity
T(A.x, y, z) + T(x, A.y, z) + T(x, y, A.z) = 0.

  THE CASIMIR ROUTE.  Summing the first-order identity over an orthonormal
  basis of so(n) produces the Casimir acting on each slot.  On an isotypic piece
  the Casimir is a scalar, so the sum collapses to a linear relation among the
  T-couplings with the Casimir eigenvalues as coefficients.  If the coefficients
  separate the negative eigenspaces from V_{1/3}, the vanishing follows.

Since Weyl_n is so(n)-irreducible for n >= 5, the Casimir sum_R (ad_R)^2 is the
SAME scalar c_W on both slots, and the identity collapses to

    c_W T(x,x,z) = sum_R T(R.x, R.x, z).

That is verified below at 1e-14.  It is an identity rather than a proof: it
expresses the target through the middle sum instead of forcing it to zero.  It
becomes a proof exactly when the middle sum is shown proportional to T(x,x,z)
with a coefficient other than c_W, so what is measured here is that ratio.

(A second-order route was tried and discarded: the relation assembled from
T(A.A.x,x,z), T(A.x,A.x,z), T(A.x,x,A.z) and T(x,x,A.A.z) was malformed and is
not an identity -- residuals 0.17 and 0.70 where an identity would give zero.)
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from run_unconstrained_search import build_weyl_basis
from p0_tubular_hessian import fox_point, F_matrix

SQ32 = np.sqrt(1.5)


def tri(A, B, C, c):
    """Symmetric trilinear form with T(W,W,W) = P(W): divide the polarization by 4."""
    return float(np.sum(C * ((Q_full(A + B, c) - Q_full(A - B, c)) / 4.0)))


def so_gens(n):
    out = []
    for a in range(n):
        for b in range(a + 1, n):
            A = np.zeros((n, n)); A[a, b] = 1.0; A[b, a] = -1.0
            out.append(A)
    return out


def rho(A, n):
    pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    pidx = {p: t for t, p in enumerate(pairs)}
    R = np.zeros((len(pairs), len(pairs)))
    for (i, j), col in pidx.items():
        for m in range(n):
            if A[i, m] != 0.0 and m != j:
                p = (min(m, j), max(m, j))
                R[pidx[p], col] += A[i, m] * (1 if m < j else -1)
            if A[j, m] != 0.0 and i != m:
                p = (min(i, m), max(i, m))
                R[pidx[p], col] += A[j, m] * (1 if i < m else -1)
    return R


def run(n, trials=6, seed=2):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    u, th, _ = fox_point(n, L2, Eflat, c)
    Nl = u.shape[0]
    M = F_matrix(u, c, Eflat)
    w, V = np.linalg.eigh(M)
    r = w / SQ32
    V13 = V[:, np.abs(r - 1 / 3) < 1e-7]
    negs = {v: V[:, np.abs(r - v) < 1e-7] for v in (-1 / 6, -1 / 2, -1.0)}
    rng = np.random.default_rng(seed)
    gens = [rho(A, n) for A in so_gens(n)]

    def vec(B, y):
        X = (Eflat.T @ (B @ y)).reshape(Nl, Nl)
        X = 0.5 * (X + X.T)
        return X / max(np.linalg.norm(X), 1e-300)

    def act(R, X):
        return R @ X - X @ R

    print(f"n={n:3d}  dim V_1/3={V13.shape[1]}  |so(n)|={len(gens)}")
    for val, B in negs.items():
        if B.shape[1] == 0:
            continue
        worst1 = worst2 = 0.0
        base = 0.0
        mids = []
        for _ in range(trials):
            y1 = rng.normal(size=V13.shape[1]); y1 /= np.linalg.norm(y1)
            y2 = rng.normal(size=B.shape[1]); y2 /= np.linalg.norm(y2)
            x, z = vec(V13, y1), vec(B, y2)
            base = max(base, abs(tri(x, x, z, c)))
            s1 = s2 = s3 = 0.0
            for R in gens:
                Ax, Az = act(R, x), act(R, z)
                s1 += tri(act(R, Ax), x, z, c)
                s2 += tri(Ax, Ax, z, c)
                s3 += tri(x, x, act(R, Az), c)
            worst2 = max(worst2, abs(s1 + 2 * s2 + s3))
            # the Casimir scalar on Weyl_n, read off the first slot, and the
            # middle sum whose proportionality to T(x,x,z) would close the proof
            cw = -s1 / tri(x, x, z, c) if abs(tri(x, x, z, c)) > 1e-13 else np.nan
            mids.append((s2, tri(x, x, z, c), cw))
        mid = max(abs(m[0]) for m in mids)
        print(f"      eigenvalue {val:+.4f} (mult {B.shape[1]:4d}):  |T(x,x,z)| = {base:.3e}"
              f"   Casimir identity residual {worst2:.3e}"
              f"   |middle sum| = {mid:.3e}", flush=True)
    print(flush=True)


if __name__ == "__main__":
    for n in (8, 10):
        run(n)
