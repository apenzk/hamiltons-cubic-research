"""Both orientations of every distinct sigma-invariant critical point."""
import sys, os, json
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from r113_core import pairs, struct_consts, weyl_basis, make_sharp, theta_of, grading_data

n = 6; pr = pairs(n); N = len(pr)
c, _ = struct_consts(n); sharp = make_sharp(c)
BW = weyl_basis(n)
sig = np.array([1,1,1,-1,-1,-1])
P = np.diag([float(sig[i]*sig[j]) for (i,j) in pr])
X = np.array([((b + P @ b @ P)/2).ravel() for b in BW]).T
U, s, _ = np.linalg.svd(X, full_matrices=False)
d = int(np.sum(s > 1e-9)); BS = np.array([U[:, k] for k in range(d)])
here = os.path.dirname(os.path.abspath(__file__))
sols = []
for f in sorted(os.listdir(here)):
    if f.startswith('sols_') and f.endswith('.json'):
        sols += json.load(open(os.path.join(here, f)))
seen = {}; rows = []
for so in sols:
    M = (np.array(so['v']) @ BS).reshape(N, N); M /= np.linalg.norm(M)
    th, _ = theta_of(M, sharp)
    if th < 0: M = -M; th, _ = theta_of(M, sharp)
    lam = np.linalg.eigvalsh(M)
    key = (round(th, 8), tuple(np.round(lam, 6)))
    if key in seen: continue
    seen[key] = True
    gp = grading_data(M, c); gm = grading_data(-M, c)
    rows.append((gp['gap'], th, gp['S_mmm'], gp['S_hhm'], gp['n_neg'], gp['graded'],
                 gm['S_mmm'], gm['S_hhm'], gm['n_neg'], gm['graded']))
rows.sort()
print(f"{len(rows)} distinct critical points in Weyl_6^sigma (both orientations tested)\n")
print(f"{'gap':>11} | {'+theta':>9} {'S_mmm':>9} {'S_hhm':>9} {'dm':>3} {'GR':>3} | "
      f"{'-theta':>9} {'S_mmm':>9} {'S_hhm':>9} {'dm':>3} {'GR':>3}")
for r in rows[:30]:
    print(f"{r[0]:11.4e} | {r[1]:+9.6f} {r[2]:9.4f} {r[3]:9.4f} {r[4]:3d} {'Y' if r[5] else 'n':>3} | "
          f"{-r[1]:+9.6f} {r[6]:9.4f} {r[7]:9.4f} {r[8]:3d} {'Y' if r[9] else 'n':>3}")
ng = sum(1 for r in rows if r[5] or r[9])
print(f"\npoints GRADED in either orientation: {ng} of {len(rows)}")
print(f"points with S_mmm=0 in either orientation: {sum(1 for r in rows if r[2]<1e-9 or r[6]<1e-9)}")
print("\n--- every point with S_mmm = 0 in EITHER orientation ---")
print(f"{'theta':>10} {'orient':>7} {'gap':>11} {'S_mmm':>9} {'S_hhm leak':>11} {'dim m':>6} GRADED")
for r in rows:
    if r[2] < 1e-9:
        print(f"{r[1]:10.6f} {'+':>7} {r[0]:11.4e} {r[2]:9.1e} {r[3]:11.6f} {r[4]:6d} {'YES' if r[5] else 'no'}")
    if r[6] < 1e-9:
        print(f"{-r[1]:10.6f} {'-':>7} {r[0]:11.4e} {r[6]:9.1e} {r[7]:11.6f} {r[8]:6d} {'YES' if r[9] else 'no'}")
