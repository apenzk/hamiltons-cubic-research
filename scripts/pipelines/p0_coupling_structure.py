"""
Does T(W_1,W_2,W_2) also vanish off the kernel component of W_2?

The combined bound now repairs Theorem 4.17 at n=12 and n=14 but leaves a window
near alpha ~ 0.298 open for n >= 16.  Both bounds are weak exactly there, and the
term that dominates the coupled bound at that alpha is 3 cos(b) sin^2(b) B with
B = sup |T(W_1,W_2,W_2)| taken over all admissible W_2.

The first coupling already carries a factor c_0, because Q(V_{1/3}) sits inside
ker F_u + <u> and W_2 is orthogonal to u.  If the second does too -- i.e. if
T(W_1,W_2,W_2) is controlled by the kernel component of W_2 rather than by all of
it -- then both terms shrink together with c_0 while c_0 near 1 forces s small,
and the window should close for every n.

This measures B separately over the two pieces of W_2:
  * W_2 entirely in ker F_u          (c_0 = 1)
  * W_2 entirely in the strictly negative eigenspaces (c_0 = 0)
and reports the ratio.  If the second is near zero, the factor is there.

Also measures P on the strictly negative part, since the s^3 term uses
theta_0(n) as an a priori cap and P is known to vanish on each individual
eigenspace.
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from run_unconstrained_search import build_weyl_basis
from p0_tubular_hessian import fox_point, F_matrix

SQ32 = np.sqrt(1.5)


def tri(A, B, C, c):
    return float(np.sum(C * ((Q_full(A + B, c) - Q_full(A - B, c)) / 4.0)))


def run(n, iters=300, seed=3):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    u, th, _ = fox_point(n, L2, Eflat, c)
    Nl = u.shape[0]
    M = F_matrix(u, c, Eflat)
    ev, V = np.linalg.eigh(M)
    r = ev / SQ32
    V13 = V[:, np.abs(r - 1.0 / 3.0) < 1e-8]
    Vker = V[:, np.abs(r) < 1e-8]
    Vneg = V[:, r < -1e-8]

    def vec(basis, y):
        W = (Eflat.T @ (basis @ y)).reshape(Nl, Nl)
        W = 0.5 * (W + W.T)
        nrm = np.linalg.norm(W)
        return W / nrm if nrm > 1e-300 else W

    rng = np.random.default_rng(seed)

    def maximise(basis2, form):
        """Alternating maximisation of |T| over unit W_1 in V13 and W_2 in basis2."""
        best = 0.0
        for _ in range(12):
            y1 = rng.normal(size=V13.shape[1]); y1 /= np.linalg.norm(y1)
            y2 = rng.normal(size=basis2.shape[1]); y2 /= np.linalg.norm(y2)
            for _ in range(iters // 12):
                W1, W2 = vec(V13, y1), vec(basis2, y2)
                if form == 112:                       # linear in W_2: gradient is Q(W_1)
                    g = Eflat @ Q_full(W1, c).reshape(-1)
                    y2 = basis2.T @ g
                    y2 /= max(np.linalg.norm(y2), 1e-300)
                    W2 = vec(basis2, y2)
                    g1 = Eflat @ ((Q_full(W1 + W2, c) - Q_full(W1 - W2, c)) / 2.0).reshape(-1)
                    y1 = V13.T @ g1
                    y1 /= max(np.linalg.norm(y1), 1e-300)
                else:                                  # linear in W_1: gradient is Q(W_2)
                    g = Eflat @ Q_full(W2, c).reshape(-1)
                    y1 = V13.T @ g
                    y1 /= max(np.linalg.norm(y1), 1e-300)
                    W1 = vec(V13, y1)
                    g2 = Eflat @ ((Q_full(W2 + W1, c) - Q_full(W2 - W1, c)) / 2.0).reshape(-1)
                    y2 = basis2.T @ g2
                    y2 /= max(np.linalg.norm(y2), 1e-300)
            W1, W2 = vec(V13, y1), vec(basis2, y2)
            best = max(best, abs(tri(W1, W1, W2, c) if form == 112 else tri(W1, W2, W2, c)))
        return best

    # cross term sup |T(W1,K,N)|, needed to interpolate B between the two pure cases
    bestC = 0.0
    for _ in range(10):
        y1 = rng.normal(size=V13.shape[1]); y1 /= np.linalg.norm(y1)
        yk = rng.normal(size=Vker.shape[1]); yk /= np.linalg.norm(yk)
        yn = rng.normal(size=Vneg.shape[1]); yn /= np.linalg.norm(yn)
        for _ in range(40):
            W1, K, Nn = vec(V13, y1), vec(Vker, yk), vec(Vneg, yn)
            g = Eflat @ ((Q_full(K + Nn, c) - Q_full(K - Nn, c)) / 2.0).reshape(-1)
            y1 = V13.T @ g; y1 /= max(np.linalg.norm(y1), 1e-300); W1 = vec(V13, y1)
            g = Eflat @ ((Q_full(W1 + Nn, c) - Q_full(W1 - Nn, c)) / 2.0).reshape(-1)
            yk = Vker.T @ g; yk /= max(np.linalg.norm(yk), 1e-300); K = vec(Vker, yk)
            g = Eflat @ ((Q_full(W1 + K, c) - Q_full(W1 - K, c)) / 2.0).reshape(-1)
            yn = Vneg.T @ g; yn /= max(np.linalg.norm(yn), 1e-300)
        W1, K, Nn = vec(V13, y1), vec(Vker, yk), vec(Vneg, yn)
        bestC = max(bestC, abs(tri(W1, K, Nn, c)))
    print(f"      sup |T(W1,K,N)| (cross): {bestC:.6f}")

    pker = max(abs(float(np.sum(w * Q_full(w, c))))
               for w in (vec(Vker, rng.normal(size=Vker.shape[1])) for _ in range(300)))
    print(f"      sup |P| sampled on ker: {pker:.6f}")
    pneg = max(abs(float(np.sum(w * Q_full(w, c))))
               for w in (vec(Vneg, rng.normal(size=Vneg.shape[1])) for _ in range(300)))
    print(f"n={n:3d}  dim V_1/3={V13.shape[1]}  dim ker={Vker.shape[1]}  dim neg={Vneg.shape[1]}")
    print(f"      sup |T(W1,W1,W2)|   W2 in ker: {maximise(Vker,112):.6f}   "
          f"W2 in neg: {maximise(Vneg,112):.6f}   (sqrt(5/6)={np.sqrt(5/6):.6f})")
    print(f"      sup |T(W1,W2,W2)|   W2 in ker: {maximise(Vker,122):.6f}   "
          f"W2 in neg: {maximise(Vneg,122):.6f}")
    print(f"      sup |P(W2)| over the strictly negative part: {pneg:.3e}\n", flush=True)


if __name__ == "__main__":
    for n in (10, 12):
        run(n)
