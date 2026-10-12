"""r213 claim 1: is n5_certificate.json positive definite?

Two routes are already on the record -- Sylvester leading minors (run_n5_lift's
pd_exact) and characteristic polynomials with alternating coefficients
(run_n5_verify).  This is a THIRD, by a different algorithm:

  (a) an exact rational LDL^H factorisation over Q(i), VERIFIED by recomputing
      L D L^H and comparing entry by entry against M.  The verified
      factorisation is a proof object, not a test: v^H M v = sum d_r |(L^H v)_r|^2
      with every d_r > 0 rational, so M is positive definite for every v =/= 0.
      An LDL that lied about psd is precisely what happened here twice; a
      factorisation that is reconstructed and compared cannot.

  (b) sympy eigenvals on the same exact matrices, as an independent cross-check
      by yet another algorithm.

Nothing is imported from the programme's code.
"""
import json, os, sys
from fractions import Fraction as F

RUNS = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
C = json.load(open(os.path.join(RUNS, "n5_certificate.json")))
pt = [F(int(a), int(b)) for a, b in C["point"]]
SHAPE = C["shape"]
print(f"{len(pt)} coordinates, shape {SHAPE}, sum k^2 = {sum(k*k for k in SHAPE)}")
assert sum(k*k for k in SHAPE) == len(pt)

# ---- Q(i) as pairs of Fractions ----
def add(a, b): return (a[0]+b[0], a[1]+b[1])
def sub(a, b): return (a[0]-b[0], a[1]-b[1])
def mul(a, b): return (a[0]*b[0]-a[1]*b[1], a[0]*b[1]+a[1]*b[0])
def cj(a):     return (a[0], -a[1])
def dv(a, b):
    n = b[0]*b[0]+b[1]*b[1]
    return ((a[0]*b[0]+a[1]*b[1])/n, (a[1]*b[0]-a[0]*b[1])/n)
Z = (F(0), F(0))

def blocks(vec):
    """the coordinate order is herm_row's: per block, for i ascending, the real
    diagonal entry then (re, im) for each j > i.  Read back the same way."""
    out, k0 = [], 0
    for k in SHAPE:
        M = [[Z]*k for _ in range(k)]
        for i in range(k):
            M[i][i] = (vec[k0], F(0)); k0 += 1
            for j in range(i+1, k):
                M[i][j] = (vec[k0], vec[k0+1]); M[j][i] = (vec[k0], -vec[k0+1])
                k0 += 2
        out.append(M)
    assert k0 == len(vec)
    return out

BL = blocks(pt)
for M in BL:
    for i in range(len(M)):
        assert M[i][i][1] == 0, "a diagonal entry is not real"
        for j in range(len(M)):
            assert M[i][j] == cj(M[j][i]), "the block is not Hermitian"
print("every block is Hermitian, diagonals real")

def ldl(M):
    """M = L D L^H with L unit lower triangular over Q(i), D real diagonal.
    Returns (L, D) or None if a pivot vanishes."""
    k = len(M)
    L = [[(F(1), F(0)) if i == j else Z for j in range(k)] for i in range(k)]
    D = [F(0)]*k
    for j in range(k):
        s = M[j][j]
        for r in range(j):
            s = sub(s, (mul(mul(L[j][r], (D[r], F(0))), cj(L[j][r]))))
        assert s[1] == 0, "a pivot came out non-real"
        D[j] = s[0]
        if D[j] == 0: return None
        for i in range(j+1, k):
            t = M[i][j]
            for r in range(j):
                t = sub(t, mul(mul(L[i][r], (D[r], F(0))), cj(L[j][r])))
            L[i][j] = dv(t, (D[j], F(0)))
    return L, D

def reconstruct(L, D):
    k = len(D)
    return [[
        (lambda acc: acc)(
            (lambda: (lambda s: s)(
                __import__("functools").reduce(
                    add,
                    [mul(mul(L[i][r], (D[r], F(0))), cj(L[j][r])) for r in range(k)],
                    Z)))())
        for j in range(k)] for i in range(k)]

allpd = True
print()
for bi, M in enumerate(BL):
    k = len(M)
    res = ldl(M)
    if res is None:
        print(f"  block {bi} ({k}x{k}): SINGULAR pivot -- NOT positive definite")
        allpd = False; continue
    L, D = res
    R = reconstruct(L, D)
    assert R == M, f"block {bi}: L D L^H does not reproduce M -- the factorisation is wrong"
    pd = all(d > 0 for d in D)
    allpd &= pd
    tag = "positive definite" if pd else "NOT positive definite"
    print(f"  block {bi} ({k}x{k}): pivots {[str(d) for d in D]}")
    print(f"            reconstruction exact, {tag}")
print()
print(f"ROUTE (a) -- verified exact LDL^H over Q(i): ALL BLOCKS PD = {allpd}")

# ---- route (b): sympy eigenvalues on the exact matrices ----
try:
    import sympy as sp
    print("\nROUTE (b) -- sympy eigenvals on the exact matrices:")
    okb = True
    for bi, M in enumerate(BL):
        k = len(M)
        S = sp.Matrix(k, k, lambda i, j: sp.Rational(M[i][j][0]) + sp.I*sp.Rational(M[i][j][1]))
        assert S.is_hermitian
        evs = S.eigenvals()
        vals = []
        for e, m in evs.items():
            v = sp.nsimplify(e)
            vals += [sp.N(sp.re(sp.expand_complex(v)), 30)] * m
        neg = [v for v in vals if v <= 0]
        okb &= not neg
        if k > 1:
            print(f"  block {bi} ({k}x{k}): eigenvalues "
                  f"{[sp.nstr(v, 12) if hasattr(sp,'nstr') else str(v) for v in vals]}")
        if neg:
            print(f"    NON-POSITIVE EIGENVALUE in block {bi}: {neg}")
    print(f"  ALL EIGENVALUES > 0: {okb}")
except Exception as e:
    print(f"\nROUTE (b) failed to run: {type(e).__name__}: {e}")
    okb = None

print()
print(f"VERDICT claim 1: positive definite = {allpd} (route a), {okb} (route b)")
