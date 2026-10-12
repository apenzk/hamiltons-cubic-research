"""Reviewer 113 -- Claims 1 and 2: the padding-invariance of the nonzero spectrum,
the balanced closed form, and the fixed-n floor among two-block sphere products."""
import sys, os, itertools
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from r113_core import pairs, struct_consts, make_sharp, theta_of, grading_data

def sphere_product(p, q, n=None):
    """Weyl operator of S^p x S^q, coordinate-diagonal; Ricci-flatness forces the
    vertex entries -q/(p-1), -p/(q-1), 1.  Optionally zero-padded into R^n."""
    m = p + q
    n = n or m
    pr = pairs(n)
    dvals = []
    for (i, j) in pr:
        if i < p and j < p:      d = -q/(p-1)
        elif p <= i < m and p <= j < m: d = -p/(q-1)
        elif i < m and j < m:    d = 1.0
        else:                    d = 0.0
        dvals.append(d)
    M = np.diag(dvals)
    M = -M  # orient so that theta > 0: the record puts W positive on h = so(p)+so(q)
    return M/np.linalg.norm(M)

print(f"{'p,q':>8} {'n':>4} {'theta':>13} {'resid':>9} {'S_mmm':>10} {'leak':>10} {'gap':>13} {'closed form':>13}")
cache = {}
for (p, q, n) in [(3,3,6),(3,3,8),(3,3,12),(4,4,8),(4,4,12),(5,5,10),(6,6,12),(8,8,16),
                  (3,5,8),(3,7,10),(4,6,10),(3,9,12),(4,8,12),(5,7,12)]:
    if n not in cache:
        cc, _ = struct_consts(n); cache[n] = (cc, make_sharp(cc))
    cc, sh = cache[n]
    M = sphere_product(p, q, n)
    th, Q = theta_of(M, sh)
    res = np.linalg.norm(Q - th*M)
    g = grading_data(M, cc)
    cf = ""
    if p == q:
        m = p + q
        cf = f"{np.sqrt(2)*(m-2)/(m*np.sqrt((m-1)*(m-2))):.9f}"
    print(f"{p},{q:>3} {n:>4} {th:13.9f} {res:9.1e} {g['S_mmm']:10.2e} {g['S_hhm']:10.4f} {g['gap']:13.9f} {cf:>13}")

print("\n--- fixed-n floor among two-block products ---")
for n in (10, 12):
    cc, _ = struct_consts(n); sh = make_sharp(cc)
    rows = []
    for p in range(2, n//2 + 1):
        q = n - p
        if p < 2 or q < 2: continue
        M = sphere_product(p, q)
        th, Q = theta_of(M, sh)
        g = grading_data(M, cc)
        rows.append((g['gap'], p, q, th, g['graded'], np.linalg.norm(Q - th*M)))
    rows.sort()
    for gap, p, q, th, gr, rs in rows:
        print(f"  n={n} S^{p} x S^{q}: gap={gap:.6f} theta={th:.6f} graded={gr} resid={rs:.1e}")
