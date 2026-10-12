"""Claim 2, second test: every block, not just the trivial one.

A highest-weight vector u of weight lambda=(w1,w2) obeys P_u(gW) = chi(g)^{-1} P_u(W)
for g in the maximal torus.  Take g = the (0,1)-plane rotation by the (3,4,5) angle;
then chi(g)^{\pm1} = zeta^{w1} with zeta = (3+4i)/5, a fifth-power-free unit mod p.
Measuring the ratio for all 41 vectors tests the weight labels, the weight basis and
the contraction convention at once, and it fails loudly if any one of them is off.
"""
import os, sys, json, itertools
import numpy as np

d = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, d)
from claim2_convention import (P, HW2, WB2, MONO, MULT, CT, gmul, gadd, omegas,
                               Pval, rot, act, WI)

def ginv(x):
    n = (x[0]*x[0] + x[1]*x[1]) % P
    ni = pow(n, P-2, P)
    return (x[0]*ni % P, (-x[1]) * ni % P)

ZETA = (3 * pow(5, P-2, P) % P, 4 * pow(5, P-2, P) % P)      # (3+4i)/5
def zpow(z, k):
    if k < 0: return zpow(ginv(z), -k)
    out = (1, 0)
    for _ in range(k): out = gmul(out, z)
    return out

W = WI.random_weyl(5, P, np.random.default_rng(11))
G01 = rot(5, 0, 1, 3, 4, 5)
G23 = rot(5, 2, 3, 3, 4, 5)
om  = omegas(W)
om1 = omegas(act(G01, W))
om2 = omegas(act(G23, W))

for weighted in (False, True):
    bad = tot = 0
    fails = []
    for lam in sorted(HW2):
        for k, u in enumerate(HW2[lam]):
            a = Pval(u, om, weighted)
            if a == (0, 0): continue
            tot += 1
            r1 = gmul(Pval(u, om1, weighted), ginv(a))
            r2 = gmul(Pval(u, om2, weighted), ginv(a))
            if r1 != zpow(ZETA, -lam[0]) or r2 != zpow(ZETA, -lam[1]):
                bad += 1; fails.append((lam, k, r1, r2))
    tag = "WEIGHTED" if weighted else "PLAIN   "
    print(f"{tag}: {tot-bad}/{tot} hw vectors transform as zeta^(-w1), zeta^(-w2)")
    if fails[:3]:
        for lam, k, r1, r2 in fails[:3]:
            print(f"    fail lambda={lam} #{k}: ratios {r1} {r2}"
                  f"  expected {zpow(ZETA,-lam[0])} {zpow(ZETA,-lam[1])}")
