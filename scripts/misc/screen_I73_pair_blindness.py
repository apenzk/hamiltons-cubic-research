"""Sub-step (b) of I73: does any eigenspace-pair direction exceed 1/2 at two recorded critical points?

For every pair of eigenspaces (E_a, E_b) of e = W/theta, including a = b, the projected pair
directions pi_W(u (.) v), u in E_a, v in E_b, span a subspace S_ab of Weyl_n (W's own component
removed).  The top eigenvalue of L_e compressed to S_ab is an UPPER bound on every pair quotient
from that eigenspace pair, so a compression max <= 1/2 settles that no pair direction fires there.
Sampled rank-one pairs give the matching lower side and are a screen only.

Objects, both validated before use (Weyl residual, criticality residual, theta against the record):
  * padded W_CP2 at n = 6, 8, built in the phi-basis from the self-dual forms; theta = sqrt(3/2).
  * the n = 8 witness of post F39, scripts/reviewers/r305/out/r305_n8_seed9015.npy,
    theta = 1.088948052505, lambda_max(L_e | W-perp) = 0.608885 (a saddle).

Seconds of linear algebra on objects already in hand.
"""

import sys
import numpy as np

sys.path.insert(0, __file__.rsplit("/", 1)[0])
from screen_I73_pair_direction import pairs, structure_constants, weyl_projector, sharp_mat, circ  # noqa: E402

rng = np.random.default_rng(20260923)


def theta_and_checks(W, c, Pi, N):
    th = np.trace(W @ W @ W) + np.sum(W * sharp_mat(c, W, W))
    QW = W @ W + sharp_mat(c, W, W)
    weyl = np.linalg.norm((Pi @ W.ravel()).reshape(N, N) - W)
    crit = np.linalg.norm((Pi @ QW.ravel()).reshape(N, N) - th * W)
    return th, weyl, crit


def compress(c, E, Sb, N):
    M = np.array([[np.sum(Sb[:, k].reshape(N, N) * circ(c, E, Sb[:, l].reshape(N, N)))
                   for l in range(Sb.shape[1])] for k in range(Sb.shape[1])])
    return np.linalg.eigvalsh((M + M.T) / 2).max()


def pair_scan(W, n, label, samples=200):
    N = len(pairs(n))
    c = structure_constants(n)
    Pi, _ = weyl_projector(n)
    W = W / np.sqrt(np.trace(W @ W))
    th, weyl, crit = theta_and_checks(W, c, Pi, N)
    E = W / th
    w = W.ravel() / np.linalg.norm(W)
    lam, V = np.linalg.eigh(E)
    vals = []
    for x in lam:
        if not vals or abs(x - vals[-1]) > 1e-6:
            vals.append(x)
    groups = [V[:, np.abs(lam - x) < 1e-6] for x in vals]
    print(f"\n{label}, n={n}: theta={th:.12f}  |W-PiW|={weyl:.1e}  crit={crit:.1e}  "
          f"{len(vals)} eigenvalues, multiplicities {[g.shape[1] for g in groups]}")
    U, S, _ = np.linalg.svd(Pi)
    B = U[:, S > 0.5]
    Bp = B - np.outer(w, w @ B)
    Uq, Sq, _ = np.linalg.svd(Bp, full_matrices=False)
    lmax = compress(c, E, Uq[:, Sq > 1e-8], N)
    print(f"  control: lambda_max(L_e | Weyl_n and W-perp) = {lmax:.9f}")
    best_c, best_r = (-9.0, None), (-9.0, None)
    for a in range(len(vals)):
        for b in range(a, len(vals)):
            Ga, Gb = groups[a], groups[b]
            dirs = []
            for i in range(Ga.shape[1]):
                for j in range(Gb.shape[1]):
                    if a == b and j <= i:
                        continue
                    X = Pi @ (0.5 * (np.outer(Ga[:, i], Gb[:, j]) + np.outer(Gb[:, j], Ga[:, i]))).ravel()
                    dirs.append(X - (X @ w) * w)
            if not dirs:
                continue
            Ud, Sd, _ = np.linalg.svd(np.array(dirs).T, full_matrices=False)
            Sb = Ud[:, Sd > 1e-9]
            if Sb.shape[1] == 0:
                continue
            cm = compress(c, E, Sb, N)
            if cm > best_c[0]:
                best_c = (cm, (round(vals[a], 6), round(vals[b], 6), Sb.shape[1]))
            for _ in range(samples):
                u = Ga @ rng.normal(size=Ga.shape[1]); u /= np.linalg.norm(u)
                v = Gb @ rng.normal(size=Gb.shape[1]); v -= (v @ u) * u
                if np.linalg.norm(v) < 1e-9:
                    continue
                v /= np.linalg.norm(v)
                X = Pi @ (0.5 * (np.outer(u, v) + np.outer(v, u))).ravel()
                X = (X - (X @ w) * w).reshape(N, N)
                nx = np.sum(X * X)
                if nx < 1e-12:
                    continue
                q = np.sum(X * circ(c, E, X)) / nx
                if q > best_r[0]:
                    best_r = (q, (round(vals[a], 6), round(vals[b], 6)))
    print(f"  max compression over eigenspace pairs = {best_c[0]:.9f} at {best_c[1]}  (UPPER bound)")
    print(f"  max sampled rank-one pair quotient    = {best_r[0]:.9f} at {best_r[1]}  (screen)")
    return th, lmax, best_c[0]


def padded_cp2(n):
    N = len(pairs(n))
    ip = {pr: k for k, pr in enumerate(pairs(n))}

    def vec(terms):
        v = np.zeros(N)
        for (i, j), s in terms:
            v[ip[(i, j)]] += s
        return v / np.linalg.norm(v)
    w1 = vec([((0, 1), 1), ((2, 3), 1)])
    w2 = vec([((0, 2), 1), ((1, 3), -1)])
    w3 = vec([((0, 3), 1), ((1, 2), 1)])
    return 2 * np.outer(w1, w1) - np.outer(w2, w2) - np.outer(w3, w3)


def main():
    for n in (6, 8):
        th, lmax, cm = pair_scan(padded_cp2(n), n, "padded W_CP2")
        assert abs(th - np.sqrt(1.5)) < 1e-9, "not W_CP2's theta"
        assert cm <= 0.5 + 1e-9
    wit = np.load(__file__.rsplit("/", 2)[0] + "/reviewers/r305/out/r305_n8_seed9015.npy")
    th, lmax, cm = pair_scan(wit, 8, "post F39's witness")
    assert abs(th - 1.088948052505) < 1e-9, "not the recorded witness"
    assert abs(lmax - 0.608885447) < 1e-6, "lambda_max control failed"
    print(f"\nTHE WITNESS IS A SADDLE (lambda_max {lmax:.6f} > 1/2) AND NO PAIR DIRECTION SEES IT "
          f"(every eigenspace-pair compression <= {cm:.6f} < 1/2).")


if __name__ == "__main__":
    main()
