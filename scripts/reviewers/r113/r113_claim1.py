"""Claims 1 and 2, corrected.

(1) Are the PADDED graded points graded?  Apply the full grading test.
(2) The fixed-n floor among two-block sphere products: p = 2 is admissible and beats p = 3.
"""
import sys, os, itertools
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from r113_core import pairs, struct_consts, make_sharp, theta_of, grading_data

def sphere_product(p, q, n=None):
    m = p + q; n = n or m
    d = []
    for (i, j) in pairs(n):
        if i < p and j < p: d.append(q/(p-1))
        elif p <= i < m and p <= j < m: d.append(p/(q-1))
        elif i < m and j < m: d.append(-1.0)
        else: d.append(0.0)
    M = np.diag(d); return M/np.linalg.norm(M)

print("=== Claim 1: is a PADDED graded critical point graded? ===")
print(f"{'point':>22} {'n':>4} {'theta':>12} {'zeros':>6} {'min|lam|':>10} {'gap':>11} {'S_mmm':>8} {'S_hhm':>9}  GRADED")
for (p,q,n) in [(3,3,6),(3,3,8),(3,3,10),(3,3,12),(4,4,8),(4,4,12),(5,5,10),(5,5,12)]:
    cc,_ = struct_consts(n); sh = make_sharp(cc)
    M = sphere_product(p,q,n); th,Q = theta_of(M, sh); g = grading_data(M, cc)
    lam = np.abs(g['lam'])
    print(f"{'S^%d x S^%d'%(p,q):>22} {n:>4} {th:12.9f} {g['n_zero']:6d} {lam.min():10.3e} {g['gap']:11.9f} "
          f"{g['S_mmm']:8.2e} {g['S_hhm']:9.4f}  {'YES' if g['graded'] else 'no'}")

print("\n=== Claim 2: two-block products at fixed n, INCLUDING p = 2 ===")
for n in (8, 10, 12, 14):
    cc,_ = struct_consts(n); sh = make_sharp(cc)
    rows = []
    for p in range(2, n//2+1):
        q = n-p
        M = sphere_product(p,q); th,Q = theta_of(M, sh); g = grading_data(M, cc)
        rows.append((g['gap'], p, q, th, g['graded'], float(np.linalg.norm(Q-th*M))))
    rows.sort()
    print(f"  n={n}:")
    for gap,p,q,th,gr,rs in rows:
        cf = 2/((n-2)*np.sqrt((n-1)*(n-3))) if p == 2 else None
        extra = f"   closed form 2/((n-2)sqrt((n-1)(n-3))) = {cf:.9f}" if cf else ""
        print(f"     S^{p} x S^{q:<3} gap={gap:.9f} theta={th:.6f} graded={gr} resid={rs:.1e}{extra}")
