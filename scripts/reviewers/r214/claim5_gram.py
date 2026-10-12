"""r214 claim 5: which Hermitian matrix is actually being certified?

herm_row() in run_n5_assemble.py packs a block's real coordinates as
    (H_00, H_11, ..., Re H_ij, Im H_ij for i<j)
with NO factor of two on the off-diagonals, and the certificate's coordinates
are the coefficients c of the linear functional  sextic = sum_k c_k row_k.
For Hermitian C and H,
    tr(C H) = sum_i C_ii H_ii + 2 sum_{i<j} (Re C_ij Re H_ij + Im C_ij Im H_ij),
so the Hermitian form C that the certificate represents has
    C_ii = c_ii,   C_ij = (c^re_ij + i c^im_ij)/2 = M_ij / 2,
where M is the matrix run_n5_verify.py's blocks() builds.  M and C differ.

This script computes the exact spectra of BOTH, over Q, by exact rational
Cholesky (my own, no shared code), for every block.
"""
import json, os
from fractions import Fraction as Fr

d = "scripts/runs"
C = json.load(open(os.path.join(d, "n5_certificate.json")))
pt = [Fr(int(a), int(b)) for a, b in C["point"]]
SHAPE = C["shape"]

def build(scale_off):
    out, k0 = [], 0
    for k in SHAPE:
        M = [[None]*k for _ in range(k)]
        for i in range(k):
            M[i][i] = (pt[k0], Fr(0)); k0 += 1
            for j in range(i+1, k):
                re, im = pt[k0]*scale_off, pt[k0+1]*scale_off; k0 += 2
                M[i][j] = (re, im); M[j][i] = (re, -im)
        out.append(M)
    assert k0 == len(pt)
    return out

def ldl_pd(M):
    """exact LDL^* over Q(i) with NO pivoting: returns the list of D entries.
    Positive definite iff every D entry is > 0.  Written from the definition:
    D_j = A_jj - sum_{k<j} |L_jk|^2 D_k ,  L_ij = (A_ij - sum_{k<j} L_ik conj(L_jk) D_k)/D_j.
    """
    n = len(M)
    L = [[(Fr(0), Fr(0))]*n for _ in range(n)]
    D = []
    for j in range(n):
        acc = Fr(0)
        for k in range(j):
            acc += (L[j][k][0]**2 + L[j][k][1]**2) * D[k]
        assert M[j][j][1] == 0
        Dj = M[j][j][0] - acc
        D.append(Dj)
        if Dj == 0:
            return D + [None]      # singular: stop
        L[j][j] = (Fr(1), Fr(0))
        for i in range(j+1, n):
            sr = si = Fr(0)
            for k in range(j):
                a, b = L[i][k]; c, e = L[j][k]     # need L_ik * conj(L_jk) * D_k
                sr += (a*c + b*e) * D[k]
                si += (b*c - a*e) * D[k]
            nr = (M[i][j][0] - sr) / Dj
            ni = (M[i][j][1] - si) / Dj
            L[i][j] = (nr, ni)
    return D

# self-test: a known indefinite Hermitian matrix must be caught
_t = [[(Fr(1), Fr(0)), (Fr(2), Fr(0))], [(Fr(2), Fr(0)), (Fr(1), Fr(0))]]
assert min(ldl_pd(_t)) < 0, "ldl_pd self-test failed on an indefinite matrix"
_t = [[(Fr(2), Fr(0)), (Fr(0), Fr(1))], [(Fr(0), Fr(-1)), (Fr(2), Fr(0))]]
assert all(x > 0 for x in ldl_pd(_t)), "ldl_pd self-test failed on a pd matrix"
print("ldl_pd self-tested on one indefinite and one positive definite matrix")

for name, sc in (("M  (as run_n5_verify.py reads it)", Fr(1)),
                 ("C  (the Hermitian form, off-diagonals halved)", Fr(1, 2))):
    Bl = build(sc)
    worst = None; ok = True
    for bi, Mm in enumerate(Bl):
        D = ldl_pd(Mm)
        if any(x is None or x <= 0 for x in D): ok = False
        for x in D:
            if x is not None and (worst is None or x < worst): worst = x
    print(f"{name}: all blocks positive definite = {ok}, "
          f"least LDL pivot = {float(worst):.6e}")
