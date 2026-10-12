"""Reviewer 56 -- D1: the S=0 catalogue, its slack, and its diagonality.

Reported measures, all on the unit-norm operator W in the constructor's frame
unless stated otherwise:
   massF   = ||W - diag(W)||_F            (Frobenius off-diagonal mass)
   maxoff  = max_{a!=b} |W_ab|            (largest single off-diagonal entry)
   minF    = min over g in SO(n) of massF (frame-independent: 0 iff W is
             coordinate-diagonal in SOME orthonormal frame)
"""
import numpy as np, sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
from review_r56_core import *

def report(label, n, W, do_frames=True, seed=0):
    idx, pos, N, c = struct(n)
    W = W / np.linalg.norm(W)
    th, res = theta_res(W, c)
    if th < 0:
        W = -W; th, res = theta_res(W, c)
    S, leak = slack_struct(W, c)
    mF, mx = offdiag_mass(W), offdiag_max(W)
    mn = min_offdiag_over_frames(W, n, idx, tries=8, seed=seed) if do_frames else float('nan')
    print(f"{label:<24} n={n:<3d} theta={th:9.6f} th/th0={th/theta0(n):7.4f} "
          f"res={res:7.1e} S={S:10.3e} leak={leak:8.2e} "
          f"massF={mF:7.4f} maxoff={mx:7.4f} minF={mn:7.4f}")
    return dict(label=label, n=n, W=W, th=th, res=res, S=S, leak=leak,
                massF=mF, maxoff=mx, minF=mn, idx=idx, c=c)

if __name__ == "__main__":
    out = []
    idx10, _, _, _ = struct(10)
    idx12, _, _, _ = struct(12)
    out.append(report("S^5xS^5", 10, sphere_product(10, (5, 5), idx10)))
    out.append(report("S^6xS^6", 12, sphere_product(12, (6, 6), idx12)))
    out.append(report("C_5 blow-up (2^5)", 10, c5_blowup(10, [2]*5, idx10)))
    out.append(report("padded S^3xS^3 -> 12", 12, sphere_product(12, (3, 3, 1,1,1,1,1,1), idx12)))
    # padded S^3xS^3 done properly: build in R^6, pad by zero
    idx6, _, N6, c6 = struct(6)
    W6 = sphere_product(6, (3, 3), idx6)
    N12 = len(idx12)
    Wp = np.zeros((N12, N12))
    for a, p in enumerate(idx6):
        for b, q in enumerate(idx6):
            Wp[idx12.index(p), idx12.index(q)] = W6[a, b]
    out.append(report("padded S^3xS^3 (zero-pad)", 12, Wp))
    idx8, _, _, _ = struct(8)
    out.append(report("CP^4 (n=8)", 8, cpm(8, idx8)))
    out.append(report("CP^5 (n=10)", 10, cpm(10, idx10)))
    out.append(report("padded W_CP2 -> 12", 12, w_cp2_padded(12, idx12)))
    out.append(report("padded W_CP2 -> 8", 8, w_cp2_padded(8, idx8)))
