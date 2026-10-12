"""Reviewer 113 -- post-process the sigma-invariant solutions.

Two independent gradedness tests, which must agree:
  (A) bracket test on the eigenvalue-sign split (the record's notion): h = {lam>=0},
      m = {lam<0}; graded iff S_mmm = 0 AND S_hhm = 0.
  (B) a-priori filter from Cartan: at n=6 the involutions of so(6) are conjugation by
      diag(+-1) (h = so(p)+so(6-p)) and by a complex structure (h = u(3)), so a graded
      W must have dim m = #{lam<0} in {5, 6, 8, 9}.  Any other count is ungraded outright.
"""
import sys, os, json, itertools
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from r113_core import pairs, struct_consts, make_sharp, theta_of, grading_data

n = 6
pr = pairs(n); N = len(pr)
c, _ = struct_consts(n)
sharp = make_sharp(c)
sig = np.array([1,1,1,-1,-1,-1])
diagP = np.array([float(sig[i]*sig[j]) for (i,j) in pr])
hs = np.where(diagP > 0)[0]   # h_sigma = Lambda^2 V_+ + Lambda^2 V_- , dim 6
ms = np.where(diagP < 0)[0]   # m_sigma = V_+ (x) V_-              , dim 9
print(f"h_sigma dim {len(hs)}, m_sigma dim {len(ms)};  allowed dim m for a graded point at n=6: {{5,6,8,9}}")

allsols = []
for f in sorted(os.listdir(os.path.dirname(os.path.abspath(__file__)))):
    if f.startswith('sols_') and f.endswith('.json'):
        allsols += json.load(open(os.path.join(os.path.dirname(os.path.abspath(__file__)), f)))
print(f"loaded {len(allsols)} converged solutions")

# de-duplicate on (theta, sorted spectrum)
seen = {}
for s in allsols:
    key = (round(s['theta'], 9), tuple(np.round(sorted(s['lam']), 7)))
    seen.setdefault(key, s)
sols = list(seen.values())
print(f"{len(sols)} distinct by (theta, spectrum)")

def sigma_graded(M):
    """does sigma itself grade M?  i.e. W|h_sigma >= 0 and W|m_sigma < 0."""
    A = M[np.ix_(hs, hs)]; B = M[np.ix_(ms, ms)]
    off = np.linalg.norm(M[np.ix_(hs, ms)])
    return float(np.linalg.eigvalsh(A).min()), float(np.linalg.eigvalsh(B).max()), off

rows = []
for s in sols:
    lam = np.array(s['lam'])
    nneg = int(np.sum(lam < -1e-8))
    rows.append((s['gap'], s['theta'], s['S'], s['leak'], nneg, s['graded'], s['S_flip'], s['leak_flip']))
rows.sort()
print(f"\n{'gap':>11} {'theta':>10} {'S_mmm':>11} {'S_hhm':>11} {'dim m':>6} {'allowed?':>9}  GRADED?")
for gap, th, S, lk, nneg, gr, Sf, lf in rows[:25]:
    print(f"{gap:11.4e} {th:10.6f} {S:11.4f} {lk:11.4f} {nneg:6d} {'yes' if nneg in (5,6,8,9) else 'NO':>9}  {'YES' if gr else 'no'}")

print(f"\ndistribution of dim m over the {len(rows)} distinct solutions:")
from collections import Counter
print(sorted(Counter(r[4] for r in rows).items()))
print(f"solutions with S_mmm = 0: {sum(1 for r in rows if r[2] < 1e-9)}")
print(f"solutions passing the FULL grading test: {sum(1 for r in rows if r[5])}")
print(f"solutions with S_mmm = 0 on the theta<0 orientation: {sum(1 for r in rows if r[6] < 1e-9)}")

# --- is sigma itself a grading of these points?  (the "additional condition" question)
print("\n--- does sigma grade the point?  need W|h_sigma >= 0 and W|m_sigma < 0 ---")
import numpy as _np
BSarr = None
ok = 0; checked = 0
for s in sols:
    v = _np.array(s['v'])
    # rebuild M from the stored coefficients requires the basis; instead rebuild from lam is impossible.
    pass
print("(block test run separately in r113_sigma_block.py)")

# the record's candidate, by theta
print("\n--- solutions near the record's theta = 0.418198 ---")
for s in sorted(sols, key=lambda s: abs(s['theta'] - 0.418198))[:6]:
    lam = np.array(s['lam'])
    print(f"  theta={s['theta']:.6f} gap={s['gap']:.4e} S_mmm={s['S']:.4f} S_hhm={s['leak']:.4f} "
          f"dim m={int(np.sum(lam<-1e-8))} graded={s['graded']}")
    print(f"      spectrum: " + " ".join(f"{x:+.5f}" for x in sorted(lam)))
