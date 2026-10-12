"""Reviewer 56 -- the block-sum family of non-diagonal S=0 critical points.

findings/INDEX.md's own paragraph "{S=0} is closed under orthogonal direct sums and
padding" makes this family automatic; nothing in the record's unitary-isotropy
enumeration contains it.  Each row is verified as an exact critical point from
definitions, with S measured structurally and diagonality settled by the
Pluecker obstruction plus a frame minimisation that passes a positive control.
"""
import numpy as np, sys, os
sys.path.insert(0, 'scripts/lib')  # repo-root relative; was __file__-relative before this file moved into a subfolder
from review_r56_core import *
from review_r56_d4 import embed, eigenspaces

def blocksum(n, pieces, idx_big):
    """pieces: list of (W_small, idx_small, offset, theta_small)."""
    inv = sum(1.0 / th**2 for _, _, _, th in pieces)
    th = 1.0 / np.sqrt(inv)
    W = sum((th / thi) * embed(Ws, ids, idx_big, off) for Ws, ids, off, thi in pieces)
    return W, th

n = 12
idx, pos, N, c = struct(n)
idx4, _, _, c4 = struct(4)
idx6, _, _, c6 = struct(6)
idx8, _, _, c8 = struct(8)
idx10, _, _, c10 = struct(10)

W4 = w_cp2_padded(4, idx4); th4 = theta_res(W4, c4)[0]
W6s = sphere_product(6, (3, 3), idx6); th6 = theta_res(W6s, c6)[0]
W8s = sphere_product(8, (4, 4), idx8); th8 = theta_res(W8s, c8)[0]
W6c = cpm(6, idx6); th6c = theta_res(W6c, c6)[0]
W8h = hpm(8, idx8); th8h = theta_res(W8h, c8)[0]

rows = [
    ("W_CP2(0-3) (+) S^4xS^4(4-11)", [(W4, idx4, 0, th4), (W8s, idx8, 4, th8)]),
    ("W_CP2(0-3) (+) W_CP2(4-7)   ", [(W4, idx4, 0, th4), (W4, idx4, 4, th4)]),
    ("W_CP2(0-3) (+) S^3xS^3(4-9) ", [(W4, idx4, 0, th4), (W6s, idx6, 4, th6)]),
    ("W_CP2(0-3) (+) CP^3(4-9)    ", [(W4, idx4, 0, th4), (W6c, idx6, 4, th6c)]),
    ("HP^2(0-7)  (+) W_CP2(8-11)  ", [(W8h, idx8, 0, th8h), (W4, idx4, 8, th4)]),
]
print(f"{'block sum at n=12':<32} {'theta':>11} {'th/th0':>8} {'crit res':>9} "
      f"{'S_struct':>10} {'massF':>7} {'minF':>7} {'refl?':>6}")
print("-" * 100)
for label, pieces in rows:
    W, thpred = blocksum(n, pieces, idx)
    W = W / np.linalg.norm(W)
    th, res = theta_res(W, c)
    if th < 0:
        W, th = -W, -th; res = theta_res(W, c)[1]
    S, leak = slack_struct(W, c)
    mn = min_offdiag_over_frames(W, n, idx, tries=5, seed=3)
    r = fixing_reflections(W, idx, n, tries=25, seed=6)
    print(f"{label:<32} {th:11.9f} {th/theta0(n):8.4f} {res:9.1e} "
          f"{S:10.3e} {offdiag_mass(W):7.4f} {mn:7.4f} {'yes' if r<1e-6 else 'NO':>6}")
    small = [ (v,E) for v,E in eigenspaces(W) if E.shape[1] <= 3 ]
    if small:
        v, E = small[0]
        print(f"     smallest eigenspace lambda={v:+.6f} mult={E.shape[1]} "
              f"min||w^w||={plucker_min(E, idx, n, tries=15, seed=7):.3e}"
              f"   (>0 proves no frame diagonalises W)")
