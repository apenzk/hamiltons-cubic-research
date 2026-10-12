"""K4 at finite n: does an UNEQUAL-block blow-up beat the equal-block C_5 value?

Solves the exact 5-block vertex system over many size vectors and keeps only the
indecomposable S = 0 points: negative graph triangle-free, connected and
non-bipartite, and all five block rows distinct.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, itertools
import numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r54_blocks import solve_family, normsq, triangles, effective_rows, theta0

def conn_nonbip(w, tol=1e-9):
    k = w.shape[0]
    adjl = {a: [b for b in range(k) if b != a and w[a, b] < -tol] for a in range(k)}
    if any(len(v) == 0 for v in adjl.values()):
        return False, False
    seen = {0}; st = [0]
    while st:
        u = st.pop()
        for v in adjl[u]:
            if v not in seen:
                seen.add(v); st.append(v)
    col = {0: 0}; st = [0]; bip = True
    while st:
        u = st.pop()
        for v in adjl[u]:
            if v not in col:
                col[v] = 1 - col[u]; st.append(v)
            elif col[v] == col[u]:
                bip = False
    return len(seen) == k, not bip

if __name__ == "__main__":
    sizevecs = []
    for n in range(10, 23):
        for c in itertools.combinations_with_replacement(range(2, n-7), 5):
            if sum(c) == n:
                sizevecs.append(c)
    print(f"{len(sizevecs)} five-block size vectors, n = 10..22")
    print(f"{'sizes':>20} {'n':>4} {'#crit':>6} {'best indecomposable S=0 ratio':>30} "
          f"{'closed-form equal-block':>24}")
    best_overall = (0.0, None)
    for sizes in sizevecs:
        n = sum(sizes)
        sols = solve_family(list(sizes), starts=260, seed=sum(sizes)*7 + sizes[0])
        cands = []
        for w, th in sols:
            wn = w/np.sqrt(normsq(sizes, w))
            if triangles(sizes, wn) != 0: continue
            if len(effective_rows(wn, 1e-6)) != 5: continue
            c, nb = conn_nonbip(wn)
            if not (c and nb): continue
            cands.append((th/theta0(n), wn))
        b = max((r for r, _ in cands), default=float('nan'))
        eq = ''
        if len(set(sizes)) == 1:
            m = sizes[0]
            eq = f"{np.sqrt(5*(m-1)/(2*(5*m-2))):.7f}"
        print(f"{str(sizes):>20} {n:>4} {len(sols):>6} {b:>30.7f} {eq:>24}", flush=True)
        if cands and max(r for r, _ in cands) > best_overall[0]:
            r, wn = max(cands, key=lambda t: t[0])
            best_overall = (r, (sizes, wn))
    print(f"\nbest indecomposable S=0 five-block point found: ratio={best_overall[0]:.7f} "
          f"at sizes {best_overall[1][0]}")
    print(f"1/sqrt(2) = {1/np.sqrt(2):.7f}")
