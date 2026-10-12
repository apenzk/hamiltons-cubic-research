"""Calibrate S_structural against the claimed 3 x (triangles of the negative graph)."""
import numpy as np, sys, itertools
sys.path.insert(0, 'scripts/lib')
from review_r55_core import *
from review_r55_blocks import *

def sphere_product_lam(blocks):
    """k-block product of round spheres: solve the vertex system restricted to the
    complete-multipartite sign pattern."""
    sols = solve_all(blocks, ntry=400, seed=3)
    out=[]
    for c in sols:
        d = info(blocks, c)
        out.append((d['ratio'], d))
    out.sort(key=lambda z:-z[0])
    return out

if __name__=="__main__":
    print("calibration of S_structural against 3 x triangles(negative graph)")
    print(f"{'blocks':>16} {'theta/th0':>10} {'edges':>6} {'tri':>5} {'3*tri':>7} {'S_struct':>12} {'ratio':>8}")
    for blocks in [(3,3),(4,4),(3,3,3),(2,2,2),(2,3,4),(2,2,2,2),(2,2,2,2,2)]:
        for ratio,d in sphere_product_lam(list(blocks))[:6]:
            lam=d['lam']; n=d['n']
            W=diag_operator(lam); W=W/np.linalg.norm(W)
            S=slack_struct(n,W)
            r = S/(3*d['tri']) if d['tri'] else float('nan')
            print(f"{str(blocks):>16} {ratio:10.6f} {d['edges']:6d} {d['tri']:5d} {3*d['tri']:7d} {S:12.5f} {r:8.4f}")
