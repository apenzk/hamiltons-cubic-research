"""r211: an exact-answer check that DECIDES the column partition.

B^lambda_ij(W) = Q^lambda(x_i, x_j) is a GRAM MATRIX of the copies of W^3 against
the ambient Sym^3 metric, and the restriction sends it to H = T B T*.  A Gram
matrix against a positive metric is positive semidefinite, and congruence
preserves that.  So at EVERY sample point, every block of the row must be psd.

That is a property of the true partition and not of a permuted one, so it decides
the ordering without appealing to how herm_row is written -- and it is exactly the
kind of known-exact-answer check the lift could have failed.
"""
import os, pickle
import numpy as np
from fractions import Fraction as Fr

here = os.path.dirname(os.path.abspath(__file__))
L = pickle.load(open(os.path.join(here, "lifted.pkl"), "rb"))
A = L["A"]
SHAPE_DUMP = L["shape"]
ORDER_ROW = [(2,2),(4,2),(3,2),(2,0),(2,1),(3,0),(3,1),(4,0),(4,1),(4,3),(4,4),
             (5,2),(3,3),(5,1),(5,3),(6,3)]
size = dict(zip([tuple(b) for b in L["blocks"]], SHAPE_DUMP))
SHAPE_TRUE = [size[l] for l in ORDER_ROW]

def blocks_of(vec, shape):
    out, o = [], 0
    for k in shape:
        M = [[None]*k for _ in range(k)]
        for i in range(k):
            M[i][i] = complex(float(vec[o]), 0.0); o += 1
            for j in range(i+1, k):
                z = complex(float(vec[o]), float(vec[o+1])); o += 2
                M[i][j] = z; M[j][i] = z.conjugate()
        out.append(np.array(M))
    assert o == len(vec)
    return out

def exact_psd_2(a, b_re, b_im, d):
    """2x2 Hermitian [[a, b],[conj b, d]] psd, in exact rational arithmetic."""
    return a >= 0 and d >= 0 and a*d - (b_re*b_re + b_im*b_im) >= 0

for shape, tag in ((SHAPE_TRUE, "TRUE column partition"), (SHAPE_DUMP, "dumped shape")):
    worst = 0.0; bad = 0; nblk = 0
    for r in A:
        for M in blocks_of(r, shape):
            nblk += 1
            e = float(np.linalg.eigvalsh(M).min())
            s = float(np.abs(M).max()) or 1.0
            if e / s < -1e-12: bad += 1
            worst = min(worst, e / s)
    print(f"{tag:28s}: {bad} of {nblk} blocks are NOT psd; "
          f"worst scaled min-eigenvalue {worst:.3e}")

# exact confirmation on the 2x2 blocks of the true partition, over Q
tot = ok = 0
for r in A:
    o = 0
    for k in SHAPE_TRUE:
        if k == 2:
            a = r[o]; bre = r[o+1]; bim = r[o+2]; dd = r[o+3]
            tot += 1
            if exact_psd_2(a, bre, bim, dd): ok += 1
        o += k*k
print(f"\nexact over Q, true partition, 2x2 blocks: {ok}/{tot} psd")

tot = ok = 0
for r in A:
    o = 0
    for k in SHAPE_DUMP:
        if k == 2:
            a = r[o]; bre = r[o+1]; bim = r[o+2]; dd = r[o+3]
            tot += 1
            if exact_psd_2(a, bre, bim, dd): ok += 1
        o += k*k
print(f"exact over Q, dumped shape,   2x2 blocks: {ok}/{tot} psd")

# and the 1x1 blocks must be >= 0 in the true partition
neg_t = sum(1 for r in A for o, k in
            [(sum(kk*kk for kk in SHAPE_TRUE[:i]), SHAPE_TRUE[i]) for i in range(16)]
            if k == 1 and r[o] < 0)
neg_d = sum(1 for r in A for o, k in
            [(sum(kk*kk for kk in SHAPE_DUMP[:i]), SHAPE_DUMP[i]) for i in range(16)]
            if k == 1 and r[o] < 0)
print(f"\n1x1 blocks negative, true partition: {neg_t}")
print(f"1x1 blocks negative, dumped shape  : {neg_d}")
