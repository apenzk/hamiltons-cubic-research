"""K4, properly stratified: the sup of theta/theta_0 over blow-ups, by class.

In the n -> infinity limit every TWO-block sphere product has theta -> sqrt(2) = lim
theta_0, balanced or not, so ratio -> 1 for the whole two-block family and for every
coarsening of it.  Ratio 1 in the limit therefore says nothing on its own.  What the
crux needs is the sup over the INDECOMPOSABLE class: negative graph connected,
triangle-free (S = 0) and NON-BIPARTITE.  A bipartite negative graph is a Z_2 grading,
which is the half of route B that is already settled.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, itertools, pickle
import numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r54_k4 import (lim_solve, lim_triangle_free, connected_nonbipartite, lim_rows)
from review_r54_blocks import effective_rows

SCR = 'scratchpad'

def classify(w, k):
    tf = lim_triangle_free(w)
    genuine = len(effective_rows(w, tol=1e-5)) == k
    conn, nonbip = connected_nonbipartite(w)
    return tf, genuine, conn, nonbip

if __name__ == "__main__":
    print(f"{'k':>3} {'#sols':>6} | {'sup ratio':>10} {'S=0':>10} {'S=0+genuine':>12} "
          f"{'S=0+gen+conn':>13} {'S=0+gen+conn+NONBIP':>20}")
    store = {}
    for k in range(3, 9):
        f = np.ones(k)/k
        sols = lim_solve(f, starts=(400 if k <= 5 else 800), seed=100+k)
        store[k] = sols
        cats = {'any': [], 's0': [], 's0g': [], 's0gc': [], 's0gcn': []}
        for w, mu in sols:
            r = mu/np.sqrt(2.0)
            tf, gen, conn, nonbip = classify(w, k)
            cats['any'].append(r)
            if tf: cats['s0'].append(r)
            if tf and gen: cats['s0g'].append(r)
            if tf and gen and conn: cats['s0gc'].append(r)
            if tf and gen and conn and nonbip: cats['s0gcn'].append((r, w))
        mx = lambda L: max(L) if L else float('nan')
        best = max((r for r, w in cats['s0gcn']), default=float('nan'))
        print(f"{k:>3} {len(sols):>6} | {mx(cats['any']):>10.6f} {mx(cats['s0']):>10.6f} "
              f"{mx(cats['s0g']):>12.6f} {mx(cats['s0gc']):>13.6f} {best:>20.6f}")
        for r, w in sorted(cats['s0gcn'], key=lambda t: -t[0])[:2]:
            neg = [(a, b) for a in range(k) for b in range(a+1, k) if w[a, b] < -1e-9]
            print(f"        ratio={r:.6f}  negative graph edges {neg}")
    with open(f'{SCR}/r54_k4b.pkl', 'wb') as fh:
        pickle.dump(store, fh)
