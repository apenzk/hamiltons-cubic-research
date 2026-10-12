"""Cone-start hunt: look for GRADED critical points inside the sigma-grading itself.

sigma grades W iff W|h_sigma >= 0 and W|m_sigma < 0.  Start the criticality solve from
points inside that cone (alternating projection onto Weyl_6^sigma and onto the sign cone)
and from perturbations of S^3 x S^3, then apply the full grading test to every solution.
"""
import sys, os, json
import numpy as np
from scipy.optimize import least_squares
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from r113_core import pairs, struct_consts, weyl_basis, make_sharp, theta_of, grading_data

SEED = int(sys.argv[1]) if len(sys.argv) > 1 else 4242
NST = int(sys.argv[2]) if len(sys.argv) > 2 else 600
rng = np.random.default_rng(SEED)
n = 6; pr = pairs(n); N = len(pr)
c, _ = struct_consts(n); sharp = make_sharp(c)
BW = weyl_basis(n)
sig = np.array([1,1,1,-1,-1,-1])
P = np.diag([float(sig[i]*sig[j]) for (i,j) in pr])
X = np.array([((b + P @ b @ P)/2).ravel() for b in BW]).T
U, s, _ = np.linalg.svd(X, full_matrices=False)
d = int(np.sum(s > 1e-9)); BS = np.array([U[:, k] for k in range(d)])
hs = np.where(np.diag(P) > 0)[0]; ms = np.where(np.diag(P) < 0)[0]

def proj_sub(M): return (BS.T @ (BS @ M.ravel())).reshape(N, N)
def proj_cone(M):
    """nearest point with M|h_sigma PSD, M|m_sigma NSD, off-blocks zero."""
    out = np.zeros((N, N))
    A = M[np.ix_(hs, hs)]; w, V = np.linalg.eigh(A); w = np.maximum(w, 0)
    out[np.ix_(hs, hs)] = V @ np.diag(w) @ V.T
    B = M[np.ix_(ms, ms)]; w, V = np.linalg.eigh(B); w = np.minimum(w, 0)
    out[np.ix_(ms, ms)] = V @ np.diag(w) @ V.T
    return out

def Mof(v): return (v @ BS).reshape(N, N)
def resid(v):
    M = Mof(v); nm2 = float(np.sum(M*M)); Q = M@M+sharp(M); th = float(np.sum(Q*M)/nm2)
    return np.concatenate([BS @ (Q-th*M).ravel(), [nm2-1.0]])

h33 = [a for a,(i,j) in enumerate(pr) if (i<3 and j<3) or (i>=3 and j>=3)]
Pi = np.zeros((N,N))
for a in h33: Pi[a,a]=1.0
W33 = Pi - (len(h33)/N)*np.eye(N); W33 /= np.linalg.norm(W33)
v33 = BS @ W33.ravel()

starts = []
for _ in range(NST):
    M = Mof(rng.standard_normal(d))
    for _ in range(60):
        M = proj_sub(proj_cone(M))
        nm = np.linalg.norm(M)
        if nm < 1e-12: break
        M = M/nm
    if np.linalg.norm(M) > 1e-9:
        starts.append(BS @ (M/np.linalg.norm(M)).ravel())
for eps in np.linspace(0.005, 0.6, 200):
    starts.append(v33 + eps*rng.standard_normal(d))

rows = {}
cone_ok = 0
for v0 in starts:
    r = least_squares(resid, v0, method='lm', xtol=3e-16, ftol=3e-16, gtol=3e-16, max_nfev=20000)
    if np.linalg.norm(r.fun) > 1e-11: continue
    M = Mof(r.x); M /= np.linalg.norm(M)
    th, Q = theta_of(M, sharp)
    if abs(th) < 1e-6: continue
    if th < 0: M = -M; th, Q = theta_of(M, sharp)
    g = grading_data(M, c)
    A = np.linalg.eigvalsh(M[np.ix_(hs,hs)]); B = np.linalg.eigvalsh(M[np.ix_(ms,ms)])
    sg = bool(A.min() >= -1e-10 and B.max() < 1e-10)
    if sg: cone_ok += 1
    key = (round(th, 8), tuple(np.round(np.sort(g['lam']), 6)))
    rows[key] = dict(theta=th, gap=g['gap'], S=g['S_mmm'], leak=g['S_hhm'],
                     nneg=g['n_neg'], graded=bool(g['graded']), sigma_grades=sg)
rows = sorted(rows.values(), key=lambda r: r['gap'])
print(f"starts: {len(starts)}   distinct converged critical points: {len(rows)}")
print(f"converged runs landing inside the sigma-cone: {cone_ok}")
gr = [r for r in rows if r['graded']]
print(f"points passing the FULL grading test: {len(gr)}")
for r in sorted(gr, key=lambda r: r['gap']):
    print(f"   GRADED: theta={r['theta']:.9f} gap={r['gap']:.9f} dim m={r['nneg']} sigma-grades={r['sigma_grades']}")
print(f"\n{'gap':>11} {'theta':>10} {'S_mmm':>10} {'S_hhm':>10} {'dim m':>6} {'sig?':>5} GRADED")
for r in rows[:15]:
    print(f"{r['gap']:11.4e} {r['theta']:10.6f} {r['S']:10.4f} {r['leak']:10.4f} {r['nneg']:6d} "
          f"{'Y' if r['sigma_grades'] else 'n':>5} {'YES' if r['graded'] else 'no'}")
json.dump(rows, open(os.path.join(os.path.dirname(os.path.abspath(__file__)), f'cone_{SEED}.json'),'w'))
