"""I73 (c): the gap-weighted sum of the eigenpair second-order inequalities.

Claim screened: at a critical point W (unit, theta = P(W), e = W/theta), summing L125's pair quantity
s_ab = <X, e.X> - 1/2 |X|^2, X = pi_W(psi_a (.) psi_b), over ALL ordered eigenpairs with weight
(eps_a - eps_b)^2 gives exactly (n+4)/6 * [(n-1) tr e^3 - (n-3) tr e^2].  Evaluated directly by
projection at stored critical points and at a random NON-critical Weyl tensor: the identity uses row A,
row B (the Weyl identity W#Id = -W) and the definition of P, none of which needs criticality, so the
random tensor satisfies it too.  Seconds per object.
"""
import sys, numpy as np
sys.path.insert(0, __file__.rsplit("/", 1)[0])
from screen_I73_pair_direction import pairs, structure_constants, weyl_projector, sharp_mat, circ
from screen_I73_pair_blindness import padded_cp2

def sphere_product(n, p):
    q = n - p
    lam = [1 / (p * (p - 1)) if (i < p and j < p) else (1 / (q * (q - 1)) if (i >= p and j >= p) else -1 / (p * q))
           for (i, j) in pairs(n)]
    W = np.diag(lam); return W / np.sqrt(np.trace(W @ W))

def gap_sum(W, n):
    N = len(pairs(n)); c = structure_constants(n); Pi, _ = weyl_projector(n)
    th = np.trace(W @ W @ W) + np.sum(W * sharp_mat(c, W, W)); E = W / th
    lam, V = np.linalg.eigh(E)
    tot = 0.0
    for a in range(N):
        for b in range(N):
            w = (lam[a] - lam[b]) ** 2
            if w < 1e-18:
                continue
            Y0 = 0.5 * (np.outer(V[:, a], V[:, b]) + np.outer(V[:, b], V[:, a]))
            X = (Pi @ Y0.ravel()).reshape(N, N)
            tot += w * (np.sum(X * circ(c, E, X)) - 0.5 * np.sum(X * X))
    E2, E3 = np.sum(lam ** 2), np.sum(lam ** 3)
    formula = (n + 4) / 6 * ((n - 1) * E3 - (n - 3) * E2)
    crit = np.linalg.norm((Pi @ (W @ W + sharp_mat(c, W, W)).ravel()) - th * W.ravel())
    return th, tot, formula, crit, np.trace(W @ W @ W) / th

objs = [("S^3 x S^3", 6, sphere_product(6, 3)), ("S^2 x S^4", 6, sphere_product(6, 2)),
        ("padded W_CP2", 6, padded_cp2(6)), ("S^3 x S^4", 7, sphere_product(7, 3)),
        ("padded W_CP2", 8, padded_cp2(8)),
        ("post F39 witness (saddle)", 8, np.load(__file__.rsplit("/", 2)[0] + "/reviewers/r305/out/r305_n8_seed9015.npy"))]
rng = np.random.default_rng(3)
for name, n, W in objs:
    W = W / np.sqrt(np.trace(W @ W))
    th, tot, f, crit, r = gap_sum(W, n)
    print(f"{name:28s} n={n} theta={th:.6f} crit.resid={crit:.1e}  direct={tot:+.10f} formula={f:+.10f} "
          f"diff={abs(tot-f):.1e}  trW3/theta={r:.4f} vs (n-3)/(n-1)={(n-3)/(n-1):.4f}")
n = 6; N = len(pairs(n)); Pi, _ = weyl_projector(n)
M = rng.normal(size=(N, N)); M = (M + M.T) / 2; W = (Pi @ M.ravel()).reshape(N, N); W /= np.sqrt(np.trace(W @ W))
th, tot, f, crit, r = gap_sum(W, n)
print(f"{'CONTROL random Weyl (not critical)':28s} n={n} crit.resid={crit:.1e} direct={tot:+.6f} formula={f:+.6f} diff={abs(tot-f):.1e}")
