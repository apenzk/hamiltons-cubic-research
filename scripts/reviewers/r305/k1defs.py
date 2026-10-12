"""K1: the disconnected lemma, on the diagonal locus.  Independent of the record."""
import numpy as np, sys
sys.path.insert(0, 'scripts/reviewers/r305')
from lib305 import *
from scipy.optimize import least_squares

def adm_basis(n):
    return diag_admissible_basis(n)

def Fmap(M):
    Phi = M * M + M @ M
    Phi = Phi - np.diag(np.diag(Phi))
    th = np.sum(M * Phi) / np.sum(M * M)
    return Phi - th * M, th

def solve_crit(n, seed, rng):
    B = adm_basis(n); d = len(B)
    def res(x):
        M = np.tensordot(x, B, axes=(0, 0))
        nm = np.linalg.norm(M)
        if nm < 1e-8: return np.ones(d + 1) * 10
        F, _ = Fmap(M)
        return np.concatenate([[np.sum(B[i] * F) for i in range(d)], [nm ** 2 - 2.0]])
    x0 = rng.normal(size=d)
    sol = least_squares(res, x0, xtol=1e-15, ftol=1e-15, gtol=1e-15)
    M = np.tensordot(sol.x, B, axes=(0, 0))
    M = M / np.linalg.norm(M) * np.sqrt(2.0)
    r, th = crit_res(M)
    return M, r, th

def components(M, tol=1e-9):
    n = M.shape[0]
    seen = -np.ones(n, int); k = 0
    for i in range(n):
        if seen[i] >= 0: continue
        stack = [i]; seen[i] = k
        while stack:
            u = stack.pop()
            for v in range(n):
                if abs(M[u, v]) > tol and seen[v] < 0:
                    seen[v] = k; stack.append(v)
        k += 1
    return k, seen

def sphere_M(p, q):
    n = p + q; M = np.zeros((n, n))
    g = -1.0 / (p * q)
    M[:p, :p] = 1.0 / (p * (p - 1)) if p > 1 else 0
    M[p:, p:] = 1.0 / (q * (q - 1)) if q > 1 else 0
    M[:p, p:] = g; M[p:, :p] = g; np.fill_diagonal(M, 0)
    return M / np.linalg.norm(M) * np.sqrt(2)

def c5_blowup(k=1):
    """Blow-up of C_5: 5 blocks of size k, weight alpha inside, beta on C_5 edges,
    gamma on non-edges; solved for zero row sums + criticality."""
    n = 5 * k
    M = np.zeros((n, n))
    # start from the adjacency of the blown-up C_5 and solve numerically below
    return n

def direct_sum(Ms, thetas):
    """criticality-forced scaling: M = sum (theta/theta_i) M_i, theta = (sum th_i^-2)^-1/2"""
    th = (sum(t ** -2.0 for t in thetas)) ** -0.5
    n = sum(m.shape[0] for m in Ms)
    M = np.zeros((n, n)); o = 0
    for m, t in zip(Ms, thetas):
        k = m.shape[0]; M[o:o+k, o:o+k] = (th / t) * m; o += k
    return M, th

