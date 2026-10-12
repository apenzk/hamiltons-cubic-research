"""J4, extra seeds: the Kaehler CP^m points padded into n=14, since FINDINGS records
the su(m) Kaehler family as the degenerate-graded band and it must be checked whether
any of them pads up high AND degenerate."""
import sys, numpy as np
sys.path.insert(0, 'scripts/lib')
import review_r50_core as C
from review_r50_spec import le_matrix, orbit_dim


def W_cpm(m):
    n = 2 * m
    pairs, idx = C.pairs_idx(n)
    N = len(pairs)
    J = np.zeros((n, n))
    for a in range(m):
        J[2 * a, 2 * a + 1] = 1.0
        J[2 * a + 1, 2 * a] = -1.0
    I = np.array([p[0] for p in pairs]); Jd = np.array([p[1] for p in pairs])
    Pu = 0.5 * (np.eye(N)
                + J[I[:, None], I[None, :]] * J[Jd[:, None], Jd[None, :]]
                - J[I[:, None], Jd[None, :]] * J[Jd[:, None], I[None, :]])
    om = np.zeros(N)
    for a in range(m):
        om[idx[(2 * a, 2 * a + 1)]] = 1.0
    Pom = np.outer(om, om) / m
    Psu = Pu - Pom
    Pm = np.eye(N) - Pu
    th2 = (m + 1) * (2 * m - 1) / (3.0 * m * (m - 1))
    th = np.sqrt(th2)
    e = (-1.0 / (2 * m - 1)) * Pm + ((m - 2.0) / ((m + 1) * (2 * m - 1))) * Psu \
        + (2.0 * (m - 1) / (2 * m - 1)) * Pom
    return th * e, th, float(np.trace(Pu))


n = 14
th0 = C.theta0(n)
print(f"{'point':>10} {'n0':>3} {'trPu':>6} {'theta':>13} {'th/th0(14)':>11} {'crit_res':>10} "
      f"{'orbit':>6} {'dimE':>5} {'verdict':>9}")
for m in (3, 4, 5, 6, 7):
    n0 = 2 * m
    W0, thpred, trPu = W_cpm(m)
    W0 = W0 / np.linalg.norm(W0)
    th_native = C.P(n0, W0)
    res0 = np.linalg.norm(C.Q(n0, W0) - th_native * W0)
    W = C.pad(W0, n0, n)
    W = W / np.linalg.norm(W)
    th = C.P(n, W)
    res = np.linalg.norm(C.Q(n, W) - th * W)
    U, _ = orbit_dim(n, W); orb = U.shape[0]
    M, B, _ = le_matrix(n, W, th)
    w = np.linalg.eigvalsh(M)
    dimE = int((np.abs(w - 0.5) < 1e-8).sum())
    print(f"{'CP^%d'%m:>10} {n0:3d} {trPu:6.1f} {th:13.9f} {th/th0:11.6f} {res:10.1e} "
          f"{orb:6d} {dimE:5d} {'NONDEG' if dimE==orb else 'DEG+%d'%(dimE-orb):>9}"
          f"   (native theta {th_native:.9f}, res {res0:.1e}, pred {thpred:.9f})", flush=True)
