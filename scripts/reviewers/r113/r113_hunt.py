"""Reviewer 113 -- Claim 3 and Claim 4.

Fix sigma = diag(1,1,1,-1,-1,-1) on R^6.  Build the sigma-invariant subspace of
Weyl_6, solve criticality inside it from many random starts, and apply the FULL
grading test (not the slack) to every solution.
"""
import sys, os, itertools, json
import numpy as np
from scipy.optimize import least_squares
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from r113_core import pairs, struct_consts, weyl_basis, make_sharp, theta_of, grading_data

SEED = int(sys.argv[1]) if len(sys.argv) > 1 else 113113
NSTART = int(sys.argv[2]) if len(sys.argv) > 2 else 400
rng = np.random.default_rng(SEED)

n = 6
pr = pairs(n); N = len(pr)
c, _ = struct_consts(n)
sharp = make_sharp(c)
BW = weyl_basis(n)
print(f"dim Weyl_6 = {len(BW)}")

sig = np.array([1, 1, 1, -1, -1, -1])
P = np.diag([float(sig[i]*sig[j]) for (i, j) in pr])
print(f"sigma action on Lambda^2: +1 on {int(np.sum(np.diag(P)>0))} dims, -1 on {int(np.sum(np.diag(P)<0))} dims")

# sigma-invariant subspace of Weyl_6: symmetrise the basis and re-orthonormalise
X = np.array([((b + P @ b @ P)/2).ravel() for b in BW]).T
U, s, _ = np.linalg.svd(X, full_matrices=False)
d = int(np.sum(s > 1e-9))
BS = [U[:, k].reshape(N, N) for k in range(d)]
print(f"dim of the sigma-invariant subspace of Weyl_6 = {d}   (singular value gap: {s[d-1]:.3e} -> {s[d] if d < len(s) else 0:.3e})")

BSarr = np.array([b.ravel() for b in BS])          # d x N^2, orthonormal

def Mof(v):
    return (v @ BSarr).reshape(N, N)

def resid(v):
    M = Mof(v)
    nm2 = float(np.sum(M*M))
    Q = M @ M + sharp(M)
    th = float(np.sum(Q*M)/nm2)
    R = (Q - th*M).ravel()
    return np.concatenate([BSarr @ R, [nm2 - 1.0]])

sols = []
for t in range(NSTART):
    v0 = rng.standard_normal(d)
    v0 /= np.linalg.norm(Mof(v0))
    r = least_squares(resid, v0, method='lm', xtol=3e-16, ftol=3e-16, gtol=3e-16, max_nfev=20000)
    res = float(np.linalg.norm(r.fun))
    if res > 1e-12:
        continue
    M = Mof(r.x); M /= np.linalg.norm(M)
    th, Q = theta_of(M, sharp)
    if abs(th) < 1e-6:
        continue
    # ORIENTATION.  W and -W are both critical, with theta of opposite sign, and the
    # grading test is NOT sign-symmetric: it swaps h and m.  The maximiser side is
    # theta > 0 (it is the side on which the graded compression inequality is an
    # upper bound), so orient there before testing.
    if th < 0:
        M = -M
        th, Q = theta_of(M, sharp)
    critres = float(np.linalg.norm(Q - th*M))
    g = grading_data(M, c)
    gflip = grading_data(-M, c)
    sols.append(dict(theta=th, resid=critres, S=g['S_mmm'], leak=g['S_hhm'],
                     S_flip=gflip['S_mmm'], leak_flip=gflip['S_hhm'],
                     leak_nk=g['S_hhm_nokernel'], gap=g['gap'], nneg=g['n_neg'],
                     nzero=g['n_zero'], npos=g['n_pos'], graded=bool(g['graded']),
                     lam=g['lam'].tolist(), v=r.x.tolist()))

print(f"\n{len(sols)}/{NSTART} converged at criticality residual <= 1e-12")

# --- Claim 4: the candidate.  theta ~ 0.418198, S = 0, smallest nonzero |lambda| ~ 2.2e-3
cands = [s for s in sols if s['S'] < 1e-9]
print(f"\nsolutions with S_mmm = 0 (necessary condition): {len(cands)}")
print(f"{'theta':>10} {'resid':>9} {'S_mmm':>10} {'leak S_hhm':>12} {'gap':>11} {'-/0/+':>10}  GRADED?")
for s in sorted(cands, key=lambda s: s['gap']):
    print(f"{s['theta']:10.6f} {s['resid']:9.1e} {s['S']:10.2e} {s['leak']:12.6f} {s['gap']:11.3e} "
          f"{s['nneg']:3d}/{s['nzero']:2d}/{s['npos']:3d}   {'YES' if s['graded'] else 'no'}")

print("\n--- all solutions sorted by gap (smallest first), top 20 ---")
print(f"{'theta':>10} {'resid':>9} {'S_mmm':>11} {'leak S_hhm':>12} {'gap':>11} {'-/0/+':>10}  GRADED?")
for s in sorted(sols, key=lambda s: s['gap'])[:20]:
    print(f"{s['theta']:10.6f} {s['resid']:9.1e} {s['S']:11.4f} {s['leak']:12.6f} {s['gap']:11.3e} "
          f"{s['nneg']:3d}/{s['nzero']:2d}/{s['npos']:3d}   {'YES' if s['graded'] else 'no'}")

print("\n--- solutions whose OPPOSITE orientation has S_mmm = 0 (theta < 0 side) ---")
fl = [s for s in sols if s['S_flip'] < 1e-9]
for s in sorted(fl, key=lambda s: s['gap'])[:12]:
    print(f"  theta=-{s['theta']:.6f} gap={s['gap']:.6e} S_mmm(flip)={s['S_flip']:.2e} leak(flip)={s['leak_flip']:.4f}")

gr = [s for s in sols if s['graded']]
print(f"\nGRADED solutions found: {len(gr)}")
for s in sorted(gr, key=lambda s: s['gap']):
    print(f"  theta={s['theta']:.9f} gap={s['gap']:.9f} dim m={s['nneg']} resid={s['resid']:.1e}")

out = os.path.join(os.path.dirname(os.path.abspath(__file__)), f"sols_{SEED}.json")
json.dump(sols, open(out, 'w'))
print(f"\nwrote {out}")
