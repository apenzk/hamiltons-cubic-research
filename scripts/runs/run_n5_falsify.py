"""Random sampling of F_5, and an honest account of what it can and cannot see.

A single Weyl tensor with F_5 < 0 would refute the n=5 certificate outright, so
this file draws them and checks.  It is independent of every object used to build
the certificate: tensors come from the module's own basis and F_5 is evaluated by
direct contraction.

WHAT IT IS NOT is "the falsification test the claim owes" -- an earlier version of
this docstring said that and reviewers 213 and 214 both corrected it.  Random
small-integer points in 35 dimensions never come within 57% of the boundary, so
this test cannot see the region where F_5 is nearly tight.  Its floor of 0.857 is
a fact about generic points, not about the infimum.

THE TEST THAT DOES REACH THE BOUNDARY is gradient ascent, and reviewer 213 ran it:
F_5 >= 0 is exactly |tr(W^3)| <= |W|^3/sqrt6, a maximisation on the 35-sphere.
3000 Riemannian ascents from random starts, both signs, ALL reach
0.4082482904639 = 1/sqrt6 to float precision, with one critical value and a
negative semidefinite Hessian there.  The maximiser's Lambda^2 spectrum is
(-2,1,1,0^7) -- the padded CP^2, which is W_0.  Exactly over Z: |W_0|^2 = 24,
tr(W_0^3) = 48, and 6*48^2 = 13824 = 24^3, so F_5(W_0) = 0 with equality.

So the bound is SHARP AND ATTAINED rather than slack, and nothing negative exists
along the route that actually reaches it.
"""
import os, sys, importlib.util
import numpy as np
from fractions import Fraction as Fr

d = os.path.dirname(os.path.abspath(__file__))
def load(n):
    sp = importlib.util.spec_from_file_location(n[:-3], os.path.join(d, n))
    m = importlib.util.module_from_spec(sp)
    o = sys.stdout; sys.stdout = open(os.devnull, "w")
    try: sp.loader.exec_module(m)
    finally: sys.stdout = o
    return m

wm = load("run_n5_weyl_module.py")
rng = np.random.default_rng(20260829)

def rand_weyl(scale=4):
    v = [Fr(int(rng.integers(-scale, scale+1))) for _ in range(35)]
    full = [sum(v[j]*wm.BASIS[j][c] for j in range(35) if v[j])
            for c in range(len(wm.SPAIRS))]
    R = wm.sym2_to_R({wm.SPAIRS[c]: full[c]
                      for c in range(len(full)) if full[c]})
    return np.array([[[[float(R[a][b][c][e]) for e in range(5)]
                       for c in range(5)] for b in range(5)] for a in range(5)])

def F5_ratio(W):
    q = float(np.einsum('abcd,abcd->', W, W))
    if q <= 0: return None
    M = W.reshape(25, 25)
    t3 = float(np.trace(M @ M @ M))
    return (1.5*q**3 - 9.0*t3**2) / q**3

N = 30000
worst, argworst, neg = 1e18, None, 0
for k in range(N):
    W = rand_weyl(4 if k % 3 else 12)
    r = F5_ratio(W)
    if r is None: continue
    if r < worst: worst, argworst = r, W
    if r < 0: neg += 1
print(f"tested {N} random real Weyl tensors from the module's own basis")
print(f"  minimum of F_5 / |W|^6 : {worst:.8f}   (must be >= 0)")
print(f"  negative values        : {neg}")

# and at the extremiser, where F_5 must vanish exactly
ex = load("run_n5_extremiser.py")
S = ex.S; NP = len(S)
W0 = wm.sym2_to_R({(a, b): S[a][b] for a in range(NP) for b in range(a, NP)
                   if S[a][b]})
W0n = np.array([[[[float(W0[a][b][c][e]) for e in range(5)] for c in range(5)]
                 for b in range(5)] for a in range(5)])
r0 = F5_ratio(W0n)
print(f"  at W_0                 : {r0:.3e}   (must be 0)")

assert neg == 0, (
    f"{neg} of {N} random Weyl tensors give F_5 < 0.  The certificate claims "
    "F_5 is a sum of squares, which makes it nonnegative everywhere, so a single "
    "negative value refutes it.")
assert abs(r0) < 1e-12, f"F_5(W_0)/|W_0|^6 = {r0}, not 0"
print("\nNo counterexample here -- but this sampling never approaches the")
print("boundary, so the 0.857 floor is about generic points and not the")
print("infimum.  Reviewer 213's gradient ascent reaches it: 3000 starts, all")
print("attaining 1/sqrt6 at W_0, where F_5 vanishes exactly over Z.")
