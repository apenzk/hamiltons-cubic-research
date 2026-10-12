"""
P0 step (1): repair Nienhaus's Theorem 4.17 at alpha ~ 1/3, for n >= 12.

WHY IT NEEDS REPAIR.  His proof bounds gamma = sqrt(2/3) P(W) by minimising a
quotient whose numerator constant is 1, justified by "f <= 1 on [0,pi]" -- i.e.
P <= sqrt(3/2) globally, true only while W_CP2 is the global maximizer (n <= 11).
With the correct c_n = sqrt(2/3) theta_0(n) > 1, his closing estimate g_1(1/3)
moves from exactly 0 to +0.0061 at n=12 and grows.  The failure is confined to
alpha near 1/3.

HIS OWN TEMPLATE (Remark 4.18, for the other end of the range).  Subdivide
W = cos(beta) W_1 + sin(beta) W_2 with W_1, W_2 orthogonal unit Weyl operators,
F_{W_CP2}(W_1) = (1/3) sqrt(3/2) -- i.e. W_1 in the 1/3-eigenspace -- and
<F(W_2), W_2> <= 0.  When alpha is near 1/3 the angle beta is forced small.  He
writes: "a strategy on proving the estimate is to estimate gamma ... for W as
above.  Unfortunately, we were not able to do this yet."

THE LEAD.  Reviewer 14 observed in passing that P vanishes on the 1/3-eigenspace.
If P == 0 there identically, then for the subdivided W the cubic expansion

  gamma/sqrt(2/3) = cos^3(b) P(W_1) + 3cos^2(b)sin(b) T(W_1,W_1,W_2)
                    + 3cos(b)sin^2(b) T(W_1,W_2,W_2) + sin^3(b) P(W_2)

loses its leading term, making gamma = O(beta) rather than O(1) -- exactly the
estimate the repair needs, and exactly what he could not supply.

This script (1) tests whether P vanishes identically on the 1/3-eigenspace,
(2) measures the trilinear couplings T(W_1,W_1,W_2) and T(W_1,W_2,W_2) over that
eigenspace, and (3) computes what bound on gamma follows, against the c_n needed.

SUPERSEDED IN PART -- read before reusing the numbers.

The vanishing of P on the 1/3-eigenspace is CONFIRMED, and by the decisive test:
the full symmetric 3-tensor T(e_i,e_j,e_k) vanishes there (max entry 3.9e-16 at
n=10 over 474k entries, 1.2e-15 at n=14 over 9.3M), against a random-subspace
control at 1.6e-2.  Sampling P(v) as done below is much weaker evidence.

The COUPLINGS below are NOT suprema.  Proper alternating maximisation gives
sup T(W_1,W_1,W_2) = sqrt(5/6) = 0.912871 and sup T(W_1,W_2,W_2) ~ 0.811, both
n-INDEPENDENT -- 17-44x the 400-sample maxima here.  The apparent decay with n is
concentration of measure, not a property of the couplings.  With honest suprema
the triangle-inequality route repairs Thm 4.17 at n=12 only (max g_1 = -0.0061),
failing at n=14 (+0.0053), 16 (+0.0135), 20 (+0.0247).

Direct maximisation of gamma on the exact constraint set, however, gives 0.608 at
alpha=0.30 and 0.534 at alpha=0.31 against thresholds 0.866 and 0.837 -- so the
estimate Theorem 4.17 needs is very likely TRUE at n >= 14; what fails is this
lossy route to it.
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from run_unconstrained_search import build_weyl_basis
from p0_tubular_hessian import fox_point, F_matrix

R23 = np.sqrt(2.0 / 3.0)
SQ32 = np.sqrt(1.5)


def theta0(n):
    return np.sqrt(2.0 * (n - 1) * (n - 2)) / n


def tri(A, B, C, c):
    """The symmetric trilinear form with T(W,W,W) = P(W).

    The trailing *2.0 in the first version was wrong -- it returned twice the
    symmetric form, so every coupling printed below was doubled."""
    return float(np.sum(C * ((Q_full(A + B, c) - Q_full(A - B, c)) / 4.0)))


def run(n, samples=400):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    u, th, _ = fox_point(n, L2, Eflat, c)
    Nl = u.shape[0]
    M = F_matrix(u, c, Eflat)
    ev, V = np.linalg.eigh(M)
    third = V[:, np.abs(ev / SQ32 - 1.0 / 3.0) < 1e-8]
    nonpos = V[:, ev <= 1e-9]
    print(f"n={n:3d}  dim Weyl={D}  theta_0={theta0(n):.9f}  c_n={R23*theta0(n):.9f}")
    print(f"      1/3-eigenspace dim = {third.shape[1]},  F<=0 subspace dim = {nonpos.shape[1]}")

    rng = np.random.default_rng(5)
    pv, t112, t122 = [], [], []
    for _ in range(samples):
        y = rng.normal(size=third.shape[1]); y /= np.linalg.norm(y)
        W1 = (Eflat.T @ (third @ y)).reshape(Nl, Nl); W1 = 0.5 * (W1 + W1.T)
        W1 /= np.linalg.norm(W1)
        pv.append(abs(float(np.sum(W1 * Q_full(W1, c)))))
        z = rng.normal(size=nonpos.shape[1]); z /= np.linalg.norm(z)
        W2 = (Eflat.T @ (nonpos @ z)).reshape(Nl, Nl); W2 = 0.5 * (W2 + W2.T)
        W2 /= np.linalg.norm(W2)
        t112.append(abs(tri(W1, W1, W2, c)))
        t122.append(abs(tri(W1, W2, W2, c)))
    pv, t112, t122 = map(np.array, (pv, t112, t122))
    print(f"      |P| on the 1/3-eigenspace: max={pv.max():.3e}  mean={pv.mean():.3e}"
          f"   {'*** VANISHES IDENTICALLY ***' if pv.max() < 1e-10 else 'does NOT vanish'}")
    print(f"      |T(W1,W1,W2)|: max={t112.max():.6f}   |T(W1,W2,W2)|: max={t122.max():.6f}")

    if pv.max() < 1e-10:
        # gamma <= sqrt(2/3) [ 3 b A + 3 b^2 B + b^3 |P(W2)| ] with b = sin(beta)
        A, B = t112.max(), t122.max()
        print(f"      => on the subdivided family, gamma <= sqrt(2/3)[3 b A + 3 b^2 B + b^3 P_max],"
              f"  A={A:.4f}, B={B:.4f}")
        for beta in (0.10, 0.223, 0.30):
            b, a_ = np.sin(beta), np.cos(beta)
            g = R23 * (3 * a_ * a_ * b * A + 3 * a_ * b * b * B + b ** 3 * SQ32)
            print(f"         beta={beta:.3f}: gamma <= {g:.6f}   (c_n = {R23*theta0(n):.6f})"
                  f"   {'OK -- below the cap' if g < R23*theta0(n) else 'exceeds the cap'}")
    print(flush=True)


if __name__ == "__main__":
    for n in (10, 12, 14):
        run(n)
