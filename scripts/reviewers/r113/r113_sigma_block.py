"""Reviewer 113 -- does sigma-invariance of the SUBSPACE imply sigma is a grading?

W in Weyl_6^sigma commutes with the sigma-action on Lambda^2, hence is block diagonal
with respect to Lambda^2 = h_sigma (dim 6) + m_sigma (dim 9).  sigma GRADES W only if in
addition W|h_sigma >= 0 and W|m_sigma < 0.  Measure how often that holds.
"""
import sys, os, json
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from r113_core import pairs, struct_consts, weyl_basis, make_sharp, theta_of, grading_data

n = 6
pr = pairs(n); N = len(pr)
c, _ = struct_consts(n); sharp = make_sharp(c)
BW = weyl_basis(n)
sig = np.array([1,1,1,-1,-1,-1])
P = np.diag([float(sig[i]*sig[j]) for (i,j) in pr])
X = np.array([((b + P @ b @ P)/2).ravel() for b in BW]).T
U, s, _ = np.linalg.svd(X, full_matrices=False)
d = int(np.sum(s > 1e-9))
BS = np.array([U[:, k] for k in range(d)])     # d x N^2
hs = np.where(np.diag(P) > 0)[0]; ms = np.where(np.diag(P) < 0)[0]

here = os.path.dirname(os.path.abspath(__file__))
sols = []
for f in sorted(os.listdir(here)):
    if f.startswith('sols_') and f.endswith('.json'):
        sols += json.load(open(os.path.join(here, f)))
print(f"{len(sols)} converged solutions loaded")

seen = {}
rows = []
for so in sols:
    v = np.array(so['v'])
    M = (v @ BS).reshape(N, N); M /= np.linalg.norm(M)
    th, Q = theta_of(M, sharp)
    if th < 0:
        M = -M; th, Q = theta_of(M, sharp)
    key = (round(th, 8), tuple(np.round(np.sort(np.linalg.eigvalsh(M)), 6)))
    if key in seen:
        continue
    seen[key] = True
    g = grading_data(M, c)
    A = np.linalg.eigvalsh(M[np.ix_(hs, hs)]); B = np.linalg.eigvalsh(M[np.ix_(ms, ms)])
    offblk = np.linalg.norm(M[np.ix_(hs, ms)])
    rows.append(dict(theta=th, gap=g['gap'], S=g['S_mmm'], leak=g['S_hhm'], nneg=g['n_neg'],
                     graded=g['graded'], hmin=float(A.min()), mmax=float(B.max()),
                     off=float(offblk), sigma_grades=bool(A.min() >= -1e-10 and B.max() < 1e-10),
                     lam=np.sort(g['lam']).tolist()))

rows.sort(key=lambda r: r['gap'])
print(f"{len(rows)} distinct critical points in Weyl_6^sigma\n")
print(f"off-block norm max over all points: {max(r['off'] for r in rows):.2e}  (sigma-invariance => block diagonal)")
from collections import Counter
print(f"dim m distribution: {sorted(Counter(r['nneg'] for r in rows).items())}")
print(f"allowed dim m at n=6 (Cartan): {{5,6,8,9}}")
print(f"points with S_mmm = 0            : {sum(1 for r in rows if r['S'] < 1e-9)}")
print(f"points passing the FULL grading test: {sum(1 for r in rows if r['graded'])}")
print(f"points sigma actually grades       : {sum(1 for r in rows if r['sigma_grades'])}")

print(f"\n{'gap':>11} {'theta':>10} {'S_mmm':>10} {'S_hhm':>10} {'dim m':>6} {'min h_s':>10} {'max m_s':>10} {'sig?':>5} {'GRADED':>7}")
for r in rows[:22]:
    print(f"{r['gap']:11.4e} {r['theta']:10.6f} {r['S']:10.4f} {r['leak']:10.4f} {r['nneg']:6d} "
          f"{r['hmin']:10.5f} {r['mmax']:10.5f} {'Y' if r['sigma_grades'] else 'n':>5} {'YES' if r['graded'] else 'no':>7}")

print("\n--- every point with S_mmm = 0 (the necessary condition), full test applied ---")
print(f"{'theta':>10} {'gap':>11} {'S_mmm':>10} {'S_hhm (leak)':>13} {'dim m':>6} {'allowed':>8} GRADED")
for r in sorted([r for r in rows if r['S'] < 1e-9], key=lambda r: r['gap']):
    print(f"{r['theta']:10.6f} {r['gap']:11.4e} {r['S']:10.2e} {r['leak']:13.6f} {r['nneg']:6d} "
          f"{'yes' if r['nneg'] in (5,6,8,9) else 'NO':>8} {'YES' if r['graded'] else 'no'}")

print("\n--- smallest gap among points near theta = 0.4182 ---")
for r in sorted(rows, key=lambda r: abs(r['theta']-0.418198))[:8]:
    print(f"  theta={r['theta']:.6f} gap={r['gap']:.4e} S={r['S']:.4f} leak={r['leak']:.4f} dim m={r['nneg']} graded={r['graded']}")
    print("      " + " ".join(f"{x:+.6f}" for x in r['lam']))
json.dump(rows, open(os.path.join(here, 'distinct.json'), 'w'))
