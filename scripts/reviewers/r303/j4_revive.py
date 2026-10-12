"""J4 attack: solve criticality jointly with M a = 0, a perp 1, |a|=1, and
require the resulting family member N_ij = 2 M_ij (a_i+a_j) to be non-radial
(penalise the radial component).  A solution revives the withdrawn family."""
import sys, os
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np
from scipy.optimize import least_squares
from diagcore import V_basis, crit_residual, theta_of, defect, Lop

n = int(sys.argv[1]); ntry = int(sys.argv[2]) if len(sys.argv) > 2 else 200
B = V_basis(n); d = len(B)
one = np.ones(n) / np.sqrt(n)


def unpack(z):
    M = np.einsum('k,kij->ij', z[:d], B)
    M = M * np.sqrt(2.0 / max(np.sum(M * M), 1e-300))
    a = z[d:]
    return M, a


def res(z):
    M, a = unpack(z)
    r1 = np.einsum('kij,ij->k', B, crit_residual(M, B))
    r2 = M @ a
    r3 = [a @ one, np.sum(a * a) - 1.0]
    N = 2 * M * (a[:, None] + a[None, :])
    rad = np.sum(N * M) / 2.0
    perp = N - rad * M
    # want |perp| bounded away from 0: soft barrier
    r4 = [1.0 / (1.0 + 40.0 * np.sum(perp * perp))]
    return np.concatenate([r1, r2, r3, r4])


best = []
for seed in range(ntry):
    rng = np.random.default_rng(seed)
    z0 = rng.normal(size=d + n)
    s = least_squares(res, z0, xtol=1e-15, ftol=1e-15, gtol=1e-15, max_nfev=8000)
    M, a = unpack(s.x)
    r1 = np.abs(crit_residual(M, B)).max()
    r2 = np.abs(M @ a).max()
    N = 2 * M * (a[:, None] + a[None, :])
    rad = np.sum(N * M) / 2.0
    perp = float(np.linalg.norm(N - rad * M))
    if r1 < 1e-9 and r2 < 1e-9 and abs(a @ one) < 1e-9 and perp > 1e-6:
        th = theta_of(M)
        print(f"seed{seed:4d} HIT crit={r1:.1e} |Ma|={r2:.1e} |N-radM|={perp:.4f} "
              f"theta={th:+.6f} Delta={defect(M):+.4f} zero-rows={int(np.sum(np.abs(M).sum(1)<1e-10))}")
        best.append((M, a))
print("hits:", len(best))
if best:
    np.save(f"/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/revive_{n}.npy",
            np.array([b[0] for b in best]))
    np.save(f"/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/revive_a_{n}.npy",
            np.array([b[1] for b in best]))
