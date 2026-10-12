"""Negative controls for run_n5_assemble.py's two h checks.

The shipped checks are
    herm = all(row[i][j] == cconj(row[j][i]) ...)          # "h Hermitian"
    not any(... h == I ...)                                # "h is the identity nowhere"

This script runs the SHIPPED h-construction verbatim on known-wrong inputs and
records whether either check fires.
"""
import importlib.util, sys, os, random
from fractions import Fraction as Fr

d = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                 "..", "..", "runs"))
# Rebuild only what is needed, exactly as run_n5_evaluate.py builds it.  That
# module runs a three-trial kappa block at import, which costs minutes and is
# irrelevant here.
import json, itertools
from math import factorial
C = json.load(open(os.path.join(d, "n5_hw_cache.json")))
WT = [tuple(w) for w in C["weights"]]
MONO = list(itertools.combinations_with_replacement(range(35), 3))
T = C["wbasis_tensors"]
def gq(pr):
    (rn, rd), (inn, idd) = pr
    return (Fr(rn, rd), Fr(inn, idd))
def cmul(x, y): return (x[0]*y[0] - x[1]*y[1], x[0]*y[1] + x[1]*y[0])
def cadd(x, y): return (x[0] + y[0], x[1] + y[1])
def cconj(x):   return (x[0], -x[1])
H = {}
for a in range(35):
    for b in range(35):
        if WT[a] != WT[b]: continue
        re = im = Fr(0)
        for i in range(5):
            for j in range(5):
                for k in range(5):
                    for l in range(5):
                        x = gq(T[a][i][j][k][l]); y = gq(T[b][i][j][k][l])
                        re += x[0]*y[0] + x[1]*y[1]
                        im += x[1]*y[0] - x[0]*y[1]
        if (re, im) != (Fr(0), Fr(0)): H[(a, b)] = (re, im)
def sym3_ip(t, s):                  # FISCHER, the shipped convention
    tot = (Fr(0), Fr(0))
    for perm in itertools.permutations(range(3)):
        term = (Fr(1), Fr(0)); ok = True
        for i in range(3):
            e = H.get((t[i], s[perm[i]]))
            if e is None: ok = False; break
            term = cmul(term, e)
        if ok: tot = cadd(tot, term)
    return tot
print(f"rebuilt H: |MONO|={len(MONO)}, {len(H)} nonzero entries")

def ip3(u, v):                      # verbatim from run_n5_assemble.py
    tot = (Fr(0), Fr(0))
    for a, ca in u.items():
        ta = MONO[a]
        for b, cb in v.items():
            k = sym3_ip(ta, MONO[b])
            if k != (Fr(0), Fr(0)):
                tot = cadd(tot, cmul(cmul(ca, cconj(cb)), k))
    return tot

def shipped_h(copies):
    """lines 96-114 of run_n5_assemble.py, verbatim, for one lambda."""
    m = len(copies)
    q00 = ip3(copies[0][0], copies[0][0])
    row = [[None]*m for _ in range(m)]
    for i in range(m):
        for j in range(m):
            g = ip3(copies[i][0], copies[j][0])
            den = q00[0]*q00[0] + q00[1]*q00[1]
            row[i][j] = ((g[0]*q00[0] + g[1]*q00[1])/den,
                         (g[1]*q00[0] - g[0]*q00[1])/den)
    herm = all(row[i][j] == cconj(row[j][i]) for i in range(m) for j in range(m))
    ident = all(row[i][j] == (Fr(1 if i == j else 0), Fr(0))
                for i in range(m) for j in range(m))
    return row, herm, ident

def cdet(M):
    """exact Gaussian-rational determinant by fraction-free-ish elimination."""
    import copy as _c
    A = [r[:] for r in M]; n = len(A); det = (Fr(1), Fr(0))
    for k in range(n):
        p = next((r for r in range(k, n) if A[r][k] != (Fr(0), Fr(0))), None)
        if p is None: return (Fr(0), Fr(0))
        if p != k:
            A[k], A[p] = A[p], A[k]; det = cmul(det, (Fr(-1), Fr(0)))
        det = cmul(det, A[k][k])
        piv = A[k][k]; dn = piv[0]*piv[0] + piv[1]*piv[1]
        inv = (piv[0]/dn, -piv[1]/dn)
        for r in range(k+1, n):
            f = cmul(A[r][k], inv)
            for c in range(k, n):
                A[r][c] = cadd(A[r][c], cmul((-f[0], -f[1]), A[k][c]))
    return det

rnd = random.Random(196)
def rand_vec(nz=12):
    ks = rnd.sample(range(len(MONO)), nz)
    return {k: (Fr(rnd.randint(-4, 4)), Fr(rnd.randint(-4, 4))) for k in ks
            if True}

CASES = {}
# A. pure garbage: three unrelated random vectors, no weight structure at all
CASES["A random garbage, m=3"] = [[rand_vec()] for _ in range(3)]
# B. the failure mode plan.md names: TWO COPIES COINCIDE
v = rand_vec(); w = rand_vec()
CASES["B two copies coincide (u1 == u0)"] = [[v], [v], [w]]
# C. worse: a linearly DEPENDENT triple, u2 = u0 + u1
u0, u1 = rand_vec(), rand_vec()
u2 = dict(u0)
for k, c in u1.items(): u2[k] = cadd(u2.get(k, (Fr(0), Fr(0))), c)
CASES["C dependent triple (u2 = u0 + u1)"] = [[u0], [u1], [u2]]
# D. non-homogeneous mixtures of monomials of many different weights
CASES["D mixed-weight junk, m=4"] = [[rand_vec(20)] for _ in range(4)]

print(f"\n{'case':38s} {'Hermitian?':11s} {'== I?':7s} {'det h':>26s}  verdict")
for name, cps in CASES.items():
    row, herm, ident = shipped_h(cps)
    dt = cdet(row)
    ds = f"{float(dt[0]):.6g}{'+%.3gi' % float(dt[1]) if dt[1] else ''}"
    shipped_passes = herm and not ident
    print(f"{name:38s} {str(herm):11s} {str(ident):7s} {ds:>26s}  "
          f"shipped checks {'PASS' if shipped_passes else 'FIRE'}, det=0: {dt == (Fr(0), Fr(0))}")
