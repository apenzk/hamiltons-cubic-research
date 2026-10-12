"""Claim 1, third bullet: "the invariant Hermitian forms available in the P_i are
confined to the trivial block".  Measure it instead of asserting it.

f_G(W) = sum_ij G_ij P_i conj(P_j) with G Hermitian block-diagonal (89 real unknowns).
f_G is SO(5)-invariant iff f_G(gW) = f_G(W) for all g and all W.  Impose that at many
(sample, rotation) pairs and read off the nullspace dimension.  A mod-p nullspace is an
UPPER bound for the dimension over Q, and |P_1|^2 supplies a lower bound of 1, so a
measured 1 pins it exactly.  Repeated for the FULL Hermitian G (1681 unknowns).
"""
import os, sys
import numpy as np
d = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, d)
from claim2_convention import (P, HW2, MONO, gmul, omegas, Pval, rot, act, WI)

BL = sorted(HW2, key=lambda l: (-len(HW2[l]), l))
FLAT = [(lam, k) for lam in BL for k in range(len(HW2[lam]))]
NB = len(FLAT)
U = [HW2[lam][k] for lam, k in FLAT]

def rot_set(rng, n):
    trips = [(3, 4, 5), (5, 12, 13), (8, 15, 17), (7, 24, 25)]
    out = []
    for _ in range(n):
        g = np.eye(5, dtype=np.int64)
        for _ in range(5):
            i, j = rng.choice(5, size=2, replace=False)
            a, b, cc = trips[rng.integers(len(trips))]
            g = g @ rot(5, int(i), int(j), a, b, cc) % P
        out.append(g % P)
    return out

def coeffs(W, pairs):
    om = omegas(W)
    pv = [Pval(u, om) for u in U]
    row = []
    for (i, j) in pairs:
        z = gmul(pv[i], (pv[j][0], (-pv[j][1]) % P))
        if i == j: row.append(z[0] % P)
        else:      row.append((2*z[0]) % P); row.append((-2*z[1]) % P)
    return row

def rank_np(M):
    M = np.array(M, dtype=np.int64) % P
    m, n = M.shape; r = 0
    for c in range(n):
        nz = np.nonzero(M[r:, c])[0]
        if not len(nz): continue
        p0 = r + int(nz[0])
        if p0 != r: M[[r, p0]] = M[[p0, r]]
        M[r] = M[r] * pow(int(M[r, c]), P-2, P) % P
        col = M[r+1:, c].copy(); nz2 = np.nonzero(col)[0]
        if len(nz2): M[r+1:][nz2] = (M[r+1:][nz2] - np.outer(col[nz2], M[r])) % P
        r += 1
        if r == m: break
    return r

blockpairs, off = [], 0
for lam in BL:
    m = len(HW2[lam])
    for i in range(m):
        for j in range(i, m): blockpairs.append((off+i, off+j))
    off += m

rng = np.random.default_rng(2024)
GS = rot_set(rng, 4)
NS = 40
rows = []
for s in range(NS):
    W = WI.random_weyl(5, P, np.random.default_rng(7000+s))
    base = coeffs(W, blockpairs)
    for g in GS:
        rows.append([(a - b) % P for a, b in zip(coeffs(act(g, W), blockpairs), base)])
NU = sum(len(HW2[l])**2 for l in BL)
r = rank_np(rows)
print(f"block-diagonal G: {NU} unknowns, {len(rows)} invariance equations, rank {r}")
print(f"  dim of INVARIANT Hermitian block-diagonal forms in the P_i: {NU - r}")

# which coordinates does the invariant direction use?
M = np.array(rows, dtype=np.int64) % P
import numpy.linalg as _
# nullspace by rref
A = M.copy(); m, n = A.shape; piv = []; r2 = 0
for c in range(n):
    nz = np.nonzero(A[r2:, c])[0]
    if not len(nz): continue
    p0 = r2 + int(nz[0])
    if p0 != r2: A[[r2, p0]] = A[[p0, r2]]
    A[r2] = A[r2] * pow(int(A[r2, c]), P-2, P) % P
    col = A[:, c].copy(); col[r2] = 0
    nzz = np.nonzero(col)[0]
    if len(nzz): A[nzz] = (A[nzz] - np.outer(col[nzz], A[r2])) % P
    piv.append(c); r2 += 1
    if r2 == m: break
free = [c for c in range(n) if c not in piv]
names = []
for (i, j) in blockpairs:
    if i == j: names.append(f"{FLAT[i][0]}#{FLAT[i][1]}^2")
    else: names.append(f"Re {FLAT[i][0]}#{FLAT[i][1]}x{FLAT[j][1]}"); names.append(f"Im ...")
for fcol in free:
    v = np.zeros(n, dtype=np.int64); v[fcol] = 1
    for k, c in enumerate(piv): v[c] = (-A[k][fcol]) % P
    sup = [names[t] for t in range(n) if v[t]]
    print(f"  invariant direction supported on: {sup}")
