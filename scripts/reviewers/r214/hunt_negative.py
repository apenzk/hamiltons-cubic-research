"""r214: hunt for a Weyl tensor with F_5(W) < 0 -- the single most valuable
outcome the brief names.

F_5 = (3/2)|W|^6 - 9 tr(W^3)^2, so F_5(W) < 0 iff  |tr(W^3)| / |W|^3 > 1/sqrt(6)
= 0.40824829...  The 30000-point random screen in run_n5_falsify.py reaches only
0.857 of the ratio F_5/|W|^6, i.e. it never gets near the boundary, so it is not
a real test.  This one OPTIMISES: many random starts, projected gradient ascent
on |tr(W^3)|/|W|^3 over the 35-dimensional space of Weyl tensors in dimension 5.
"""
import os, sys, importlib.util
import numpy as np
from fractions import Fraction as Fr

d = "scripts/runs"
def load(n):
    sp = importlib.util.spec_from_file_location(n[:-3], os.path.join(d, n))
    m = importlib.util.module_from_spec(sp)
    o = sys.stdout; sys.stdout = open(os.devnull, "w")
    try: sp.loader.exec_module(m)
    finally: sys.stdout = o
    return m

wm = load("run_n5_weyl_module.py")
# 35 basis Weyl tensors as float 5x5x5x5 arrays
BAS = []
for j in range(35):
    full = wm.BASIS[j]
    R = wm.sym2_to_R({wm.SPAIRS[c]: Fr(full[c]) for c in range(len(full)) if full[c]})
    BAS.append(np.array([[[[float(R[a][b][c][e]) for e in range(5)]
                           for c in range(5)] for b in range(5)] for a in range(5)]))
BAS = np.array(BAS)                      # 35 x 5 x 5 x 5 x 5
GRAM = np.einsum('iabcd,jabcd->ij', BAS, BAS)
print("basis built; Gram condition number", np.linalg.cond(GRAM))

def tensor(v): return np.einsum('i,iabcd->abcd', v, BAS)
def ratio(v):
    W = tensor(v)
    q = np.einsum('abcd,abcd->', W, W)
    M = W.reshape(25, 25)
    t3 = np.trace(M @ M @ M)
    return t3 / q**1.5, q, t3
def grad_ratio(v):
    """d/dv of tr(W^3)/|W|^3 ; tr(M^3) has gradient 3 (M^2)^T in M."""
    W = tensor(v); M = W.reshape(25, 25)
    q = np.einsum('abcd,abcd->', W, W); t3 = np.trace(M @ M @ M)
    dt3 = 3.0*(M @ M).T
    dq = 2.0*W
    gt = np.einsum('iabcd,abcd->i', BAS, dt3.reshape(5,5,5,5))
    gq = np.einsum('iabcd,abcd->i', BAS, dq)
    return gt/q**1.5 - 1.5*t3*gq/q**2.5, t3/q**1.5

TARGET = 1.0/np.sqrt(6.0)
rng = np.random.default_rng(214)
best = 0.0; bestv = None
for trial in range(4000):
    v = rng.normal(size=35)
    v /= np.linalg.norm(v)
    step = 0.3
    cur = ratio(v)[0]
    if cur < 0: v = -v; cur = -cur
    for it in range(400):
        g, r = grad_ratio(v)
        vn = v + step*g
        vn /= np.linalg.norm(vn)
        rn = ratio(vn)[0]
        if rn > r: v, step = vn, step*1.1
        else: step *= 0.5
        if step < 1e-13: break
    r = abs(ratio(v)[0])
    if r > best: best, bestv = r, v.copy()
print(f"\n4000 starts, projected gradient ascent")
print(f"  best |tr(W^3)|/|W|^3 found : {best:.12f}")
print(f"  threshold for F_5 < 0      : {TARGET:.12f}")
print(f"  F_5/|W|^6 at the best point: {1.5 - 9*best**2:.12e}")
if best > TARGET*(1+1e-12):
    print("  *** F_5 GOES NEGATIVE.  THE CERTIFICATE IS FALSE. ***")
    np.save("scripts/reviewers/r214/witness.npy", bestv)
else:
    print("  no negative value.  The maximum is attained at the claimed value,")
    print(f"  relative gap {abs(best-TARGET)/TARGET:.3e}.")
