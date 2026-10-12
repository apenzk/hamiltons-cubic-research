"""
The joint constraint in closed form, where the coupled bound's maximiser already is.

Reviewer 19 established that the coupled bound's maximiser always sits at c_0 = 1
-- W_2 entirely in ker F_u -- with s^2 = 3 eps an equality, so

  gamma_coupled = sqrt(2/3)[ 3(1-3e) sqrt(3e) sqrt(5/6) + 2(1-3e)^{1/2}(3e)
                             + (3e)^{3/2} theta_0(n) ],   e = 1/3 - alpha,

and only sqrt(5/6), 2/3 and theta_0(n) are load-bearing.  At c_0 = 1 the whole
configuration is W_1 in V_{1/3} and W_2 = K in ker F_u, so the two couplings are

    A(W_1, K) = T(W_1, W_1, K)      sup sqrt(5/6)
    B(W_1, K) = T(W_1, K, K)        sup 2/3

both evaluated at the SAME pair.  The bound charges both suprema at once; the
question is whether one pair can come near both.

This measures the joint frontier directly: maximise A + t B over unit
(W_1, K) for a range of weights t, giving the upper envelope of the achievable
(A, B) region.  The bound uses the corner (sup A, sup B); the envelope says how
far inside the corner the region actually reaches, and the gap between them is
exactly what the alpha ~ 0.295 window needs.

Reported per weight: the achieved (A, B), their weighted sum, and the corner
value sup A * 1 + t * sup B for comparison.
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from run_unconstrained_search import build_weyl_basis
from p0_tubular_hessian import fox_point, F_matrix

SQ32 = np.sqrt(1.5)
A_SUP = np.sqrt(5.0 / 6.0)
B_SUP = 2.0 / 3.0


def tri(X, Y, Z, c):
    return float(np.sum(Z * ((Q_full(X + Y, c) - Q_full(X - Y, c)) / 4.0)))


def run(n, weights=(0.35, 0.45, 0.577, 0.65, 0.75, 0.90), restarts=10, iters=80, seed=4):
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    u, th, _ = fox_point(n, L2, Eflat, c)
    Nl = u.shape[0]
    M = F_matrix(u, c, Eflat)
    w, V = np.linalg.eigh(M)
    r = w / SQ32
    V13 = V[:, np.abs(r - 1 / 3) < 1e-7]
    Vker = V[:, np.abs(r) < 1e-7]
    rng = np.random.default_rng(seed)

    def mk(B, y):
        X = (Eflat.T @ (B @ y)).reshape(Nl, Nl)
        X = 0.5 * (X + X.T)
        return X / max(np.linalg.norm(X), 1e-300)

    print(f"n={n:3d}  dim V_1/3={V13.shape[1]}  dim ker={Vker.shape[1]}"
          f"   sup A={A_SUP:.6f}  sup B={B_SUP:.6f}")
    print(f"   {'t':>6} {'alpha':>7} {'A':>10} {'B':>10} {'bound':>10} {'requirement':>11} {'margin':>9}")
    for t in weights:
        best = (-9e9, 0, 0)
        for _ in range(restarts):
            y1 = rng.normal(size=V13.shape[1]); y1 /= np.linalg.norm(y1)
            y2 = rng.normal(size=Vker.shape[1]); y2 /= np.linalg.norm(y2)
            for _ in range(iters):
                W1, K = mk(V13, y1), mk(Vker, y2)
                # gradient in K of A + tB: Q(W_1) + 2t (W_1 o K)
                gK = (Eflat @ Q_full(W1, c).reshape(-1)
                      + 2 * t * (Eflat @ ((Q_full(W1 + K, c) - Q_full(W1 - K, c)) / 4.0).reshape(-1)))
                y2n = Vker.T @ gK
                if np.linalg.norm(y2n) > 1e-300:
                    y2 = y2n / np.linalg.norm(y2n)
                K = mk(Vker, y2)
                # gradient in W_1 of A + tB: 2 (W_1 o K) + t Q(K)
                gW = (2 * (Eflat @ ((Q_full(W1 + K, c) - Q_full(W1 - K, c)) / 4.0).reshape(-1))
                      + t * (Eflat @ Q_full(K, c).reshape(-1)))
                y1n = V13.T @ gW
                if np.linalg.norm(y1n) > 1e-300:
                    y1 = y1n / np.linalg.norm(y1n)
            W1, K = mk(V13, y1), mk(Vker, y2)
            A, B = tri(W1, W1, K, c), tri(W1, K, K, c)
            if A + t * B > best[0]:
                best = (A + t * B, A, B)
        tot, A, B = best
        # t = s/c fixes alpha: s^2 = 3eps, t^2 = s^2/(1-s^2) => s^2 = t^2/(1+t^2)
        s2 = t * t / (1 + t * t)
        alpha = 1 / 3 - s2 / 3
        ss, cb = np.sqrt(s2), np.sqrt(1 - s2)
        th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
        bd = np.sqrt(2 / 3) * (3 * cb * cb * ss * A_SUP + 3 * cb * s2 * max(B, 0.0)
                               + s2 * ss * th0)
        rq = (3 - 5 * alpha) / np.sqrt(3)
        print(f"   {t:>6.3f} {alpha:>7.4f} {A:>10.6f} {B:>10.6f} {bd:>10.6f} {rq:>11.6f}"
              f" {rq - bd:>+9.6f}", flush=True)
    print(flush=True)


if __name__ == "__main__":
    for n in (12, 16):
        run(n)
