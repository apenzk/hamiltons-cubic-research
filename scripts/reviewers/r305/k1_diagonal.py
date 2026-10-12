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

rng = np.random.default_rng(305)
print("=== a zoo of CONNECTED diagonal critical points ===")
zoo = []
for (p, q) in [(2, 2), (2, 3), (3, 3), (3, 4), (2, 5)]:
    M = sphere_M(p, q); r, th = crit_res(M)
    nc, _ = components(M)
    zoo.append((f"S^{p}xS^{q}", M, th)); print(f"  S^{p}xS^{q:<2} n={p+q} theta={th:.9f} res={r:.1e} comps={nc}")
found = 0
for trial in range(400):
    n = int(rng.integers(5, 8))
    M, r, th = solve_crit(n, trial, rng)
    if r > 1e-12 or th < 1e-6: continue
    nc, _ = components(M)
    if nc != 1: continue
    # skip near-duplicates of sphere products by spectrum
    sp = tuple(np.round(np.sort(np.linalg.eigvalsh(M)), 6))
    if any(abs(th - t) < 1e-7 and m.shape[0] == n for _, m, t in zoo): continue
    zoo.append((f"rand n={n} #{trial}", M, th)); found += 1
    print(f"  rand n={n} theta={th:.9f} res={r:.1e} distinct-entries={len(set(np.round(np.abs(M[np.triu_indices(n,1)]),8)))}")
    if found >= 6: break

print("\n=== K1a: direct sums, criticality and the theta law ===")
import itertools
tests = [(0, 1), (2, 3), (0, 4), (1, 1)]
names = [z[0] for z in zoo]
def report(sel):
    Ms = [zoo[i][1] for i in sel]; ths = [zoo[i][2] for i in sel]
    M, th = direct_sum(Ms, ths)
    r, th_meas = crit_res(M)
    nc, _ = components(M)
    print(f"  [{' (+) '.join(zoo[i][0] for i in sel)}] n={M.shape[0]} comps={nc} "
          f"theta_pred={th:.12f} theta_meas={th_meas:.12f} d={abs(th-th_meas):.1e} crit_res={r:.2e}")
    return M, th
for sel in [(0,1),(0,2),(2,3),(0,1,2),(0,1,2,3),(1,4),(0,0)]:
    sel = tuple(min(s, len(zoo)-1) for s in sel)
    report(sel)
# summands that are NOT sphere products
nonsph = [i for i, z in enumerate(zoo) if z[0].startswith('rand')]
print("  --- with non-sphere-product summands ---")
if len(nonsph) >= 2:
    report((nonsph[0], nonsph[1]))
    report((0, nonsph[0]))
    report((0, nonsph[0], nonsph[1]))
    if len(nonsph) >= 3:
        report((nonsph[0], nonsph[1], nonsph[2]))

print("\n=== K1b: EQUAL scaling ===")
for sel in [(0, 1), (2, 3)]:
    Ms = [zoo[i][1] for i in sel]
    n = sum(m.shape[0] for m in Ms); M = np.zeros((n, n)); o = 0
    for m in Ms:
        k = m.shape[0]; M[o:o+k, o:o+k] = m; o += k
    M = M / np.linalg.norm(M) * np.sqrt(2)
    r, th = crit_res(M)
    print(f"  [{' (+) '.join(zoo[i][0] for i in sel)}] equal scaling: crit_res={r:.3e} "
          f"(theta_i = {[round(zoo[i][2],6) for i in sel]})")
