"""The graded criticality identity, from definitions:
   alpha in h:  lam_a (theta - lam_a) = 1/2 sum_{g,d} T_{agd} lam_g lam_d   (all terms >= 0)
   alpha in m:  |lam_a|(theta + |lam_a|) = sum_{g in h, d in m} T_{agd} lam_g |lam_d|
   with  sum_{g,d} T_{agd} = 2(n-2)  for every alpha (Killing form), so the RHS is a
   T-weighted average of |lam_g lam_d| with total weight n-2.  Corollary: gap <= theta/(n-3)."""
import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from r114_core import *
from r114_claims12 import sphere_product

def check(name, M, n):
    S = Setup(n); c = S.c
    th = S.theta(M)
    ev, V = np.linalg.eigh(M)
    N = len(ev)
    # T in the eigenframe
    cc = np.einsum('abg,aA,bB,gG->ABG', c, V, V, V, optimize=True)
    T = cc**2
    killing = T.sum(axis=(1, 2))
    worst_id = 0.0; worst_kill = abs(killing - 2*(n-2)).max()
    for a in range(N):
        lhs = ev[a]*(th - ev[a])
        rhs = 0.5*np.einsum('gd,g,d->', T[a], ev, ev)
        worst_id = max(worst_id, abs(lhs - rhs))
    nz = [abs(e) for e in ev if abs(e) > 1e-9]
    g = min(nz)
    print(f"{name:16s} n={n:2d} theta={th:.6f} identity resid={worst_id:.2e} "
          f"|sum T - 2(n-2)|={worst_kill:.2e} gap={g:.6f} theta/(n-3)={th/(n-3):.6f} "
          f"holds={g <= th/(n-3)+1e-12}")

for n, blocks in [(6,[3,3]),(6,[2,4]),(8,[4,4]),(8,[3,5]),(10,[2,8]),(12,[3,9]),(12,[6,6])]:
    check(f"S{blocks[0]}xS{blocks[1]}", sphere_product(blocks, n), n)
print()
print("ungraded control (multi-block, S>0):")
check("S3xS3xS3", sphere_product([3,3,3], 9), 9)
check("(S3)^4", sphere_product([3,3,3,3], 12), 12)
