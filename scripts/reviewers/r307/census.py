"""Consolidate the graded critical points found, certify each, and report the spread of
||A||^2 on a FIXED symmetric pair."""
import sys, glob, numpy as np
sys.path.insert(0, 'scripts/reviewers/r307')
from core307 import *

def adx(n, x):
    """ad(x) on Lambda^2, x a coefficient vector in so(n): (ad x)_{ab} = -c_{x a b}."""
    c = cstruct(n)
    return -np.einsum('x,xab->ab', x, c)

def defect(n, W, tol=1e-9):
    lam, V = np.linalg.eigh(W)
    D = 0.0
    for k in np.where(lam > tol)[0]:
        Ax = adx(n, V[:, k])
        D += float(np.linalg.norm(Ax @ W - W @ Ax)**2)
    return D

def cert(n, W):
    W = W/np.linalg.norm(W)
    QW = Q(n, W); th = float(np.tensordot(QW, W))
    if th < 0:
        W, th = -W, -th; QW = Q(n, W)
    lam = np.linalg.eigvalsh(W)
    mp = lam > 1e-9; mm = lam < -1e-9
    return dict(theta=th, res=float(np.abs(QW-th*W).max()), dimp=int(mp.sum()),
                ker=int(len(lam)-mp.sum()-mm.sum()), A2=float((lam[mp]**2).sum()),
                npos=len(set(np.round(lam[mp], 6))), Delta=defect(n, W),
                weyl=float(np.abs(project_weyl(n, W)-W).max()), W=W)

n = 8
pts = []
for f in sorted(glob.glob('scripts/reviewers/r307/gradedpts_n8_p*.npy')):
    for W in np.load(f):
        pts.append(W)
pts.append(np.load('scripts/data/w_n8_nondiagonal_witness.npy'))
for p in (2,3,4):
    pts.append(sphere_product_W(n, p))
recs, seen = [], set()
for W in pts:
    r = cert(n, W)
    k = (round(r['theta'], 7), r['dimp'], round(r['A2'], 7))
    if k in seen or r['res'] > 1e-10:
        continue
    seen.add(k); recs.append(r)
recs.sort(key=lambda r: -r['theta'])
print(f"{'theta':>11}{'dim p':>7}{'ker':>5}{'#pos':>6}{'|A|^2':>12}{'Delta':>10}"
      f"{'equiv':>7}{'crit res':>11}{'non-Weyl':>10}")
for r in recs:
    print(f"{r['theta']:>11.7f}{r['dimp']:>7}{r['ker']:>5}{r['npos']:>6}{r['A2']:>12.7f}"
          f"{r['Delta']:>10.4f}{'YES' if r['Delta']<1e-8 else 'no':>7}"
          f"{r['res']:>11.1e}{r['weyl']:>10.1e}")

for dp in (12, 13, 16):
    g = [r for r in recs if r['dimp'] == dp]
    if not g: continue
    a2 = np.array([r['A2'] for r in g]); th = np.array([r['theta'] for r in g])
    ne = [r for r in g if r['Delta'] > 1e-8]
    print(f"\npair dim p = {dp} ({'so(4)+so(4)' if dp==12 else 'so(3)+so(5)' if dp==13 else 'so(2)+so(6)'}):"
          f" {len(g)} points ({len(ne)} non-equivariant)")
    print(f"   |A|^2 in [{a2.min():.7f}, {a2.max():.7f}]  spread {a2.max()-a2.min():.7f}"
          f" = {100*(a2.max()-a2.min())/a2.mean():.2f}% of mean")
    print(f"   equivariant closed form dim p/C(7,2) = {dp}/21 = {dp/21:.7f}")
    print(f"   theta in [{th.min():.7f}, {th.max():.7f}]")
a2 = np.array([r['A2'] for r in recs]); th = np.array([r['theta'] for r in recs])
print(f"\nALL {len(recs)} graded points: theta max {th.max():.7f}, sqrt(3/2) = 1.2247449;"
      f" points above it: {(th>1.2247449).sum()}")
np.save('scripts/reviewers/r307/census_n8.npy', np.array([r['W'] for r in recs]))
