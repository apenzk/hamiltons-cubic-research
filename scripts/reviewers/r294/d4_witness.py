"""A search-free, retypeable witness that criticality escapes the 67/68 ceiling at n = 6.

lam is EXACTLY traceless and unit-norm by construction from six typed decimals."""
import sys; sys.path.insert(0,'scripts/reviewers/r294')
import numpy as np
from d4_lp import lp

raw = np.array([0.41169,0.41169,0.41169,0.00884,0.00535,0.00203,0,0,0,0,0,-0.40411,-0.40411,-0.40411])
lam = np.append(raw, -raw.sum())            # last entry makes the trace exactly 0
lam = np.sort(lam/np.linalg.norm(lam))
d = int((lam < -1e-13).sum())
print("lam =", np.array2string(lam, precision=8, separator=', '))
print(f"sum(lam) = {lam.sum():.2e}   ||lam||^2 = {lam@lam:.12f}   d = {d}   #zero = {(lam==0).sum()}")
for tag, kw in [('67/68 list alone      ', dict(crit=False, ident=False)),
                ('+ per-row identity    ', dict(crit=False, ident=True)),
                ('+ per-row criticality ', dict(crit=True,  ident=False)),
                ('+ both                ', dict(crit=True,  ident=True))]:
    v = lp(lam, 6, d, smmm=True, **kw)
    print(f"  {tag} LP value = {'INFEASIBLE' if v is None else format(v,'.6f')}")
print("  target max(sqrt(3/2), theta_0(6)) = 1.224745 ; 67/68 recorded ceiling 1.6038")

print("\n--- same, with S_mmm = 0 dropped (so the only hypothesis is criticality) ---")
for tag, kw in [('list w/o S_mmm        ', dict(crit=False, ident=False, smmm=False)),
                ('+ per-row criticality ', dict(crit=True,  ident=False, smmm=False)),
                ('+ both                ', dict(crit=True,  ident=True,  smmm=False))]:
    v = lp(lam, 6, d, **kw)
    print(f"  {tag} LP value = {'INFEASIBLE' if v is None else format(v,'.6f')}")
