"""r211: audit the CRT + rational-reconstruction arithmetic in run_n5_lift.py.

Independent reimplementation with exact integer square roots and an independent
CRT, compared entry for entry against the file's own routines.
"""
import os, json, glob, math
from fractions import Fraction as Fr
from math import isqrt, gcd
import sympy

d = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
files = sorted(glob.glob(os.path.join(d, "n5_rows_*.json")))
files = [f for f in files if "1099511627953" not in f]   # only the three under review
data = [json.load(open(f)) for f in files]
PS = [x["prime"] for x in data]
print("primes:", PS)
print("prime?  ", [sympy.isprime(p) for p in PS])
print("distinct:", len(set(PS)) == len(PS))
print("1 mod 4:", [p % 4 for p in PS])
print("bits:   ", [p.bit_length() for p in PS], "total", sum(p.bit_length() for p in PS))

M = 1
for p in PS: M *= p
BOUND_FILE = int((M // 2) ** 0.5)      # exactly as run_n5_lift.py computes it
BOUND_EXACT = isqrt(M // 2)
print(f"\nM = {M}  ({M.bit_length()} bits)")
print(f"BOUND as coded (float): {BOUND_FILE}")
print(f"BOUND exact isqrt     : {BOUND_EXACT}")
print(f"difference            : {BOUND_FILE - BOUND_EXACT}")
print(f"2*B^2 < M (uniqueness) coded: {2*BOUND_FILE**2 < M}   exact: {2*BOUND_EXACT**2 < M}")
print(f"2*B^2 - M coded: {2*BOUND_FILE**2 - M}")

# ---- the file's own routines, copied verbatim ----
def crt_file(rs, BOUND=None):
    x, m = 0, 1
    for r, p in zip(rs, PS):
        g = pow(m % p, p - 2, p)
        t = ((r - x) * g) % p
        x += m * t; m *= p
    return x % m

def ratrec_file(a, BOUND):
    r0, r1 = M, a % M
    s0, s1 = 0, 1
    while r1 > BOUND:
        q = r0 // r1
        r0, r1 = r1, r0 - q*r1
        s0, s1 = s1, s0 - q*s1
    if s1 == 0 or abs(s1) > BOUND: return None
    num, den = r1, s1
    if den < 0: num, den = -num, -den
    if gcd(abs(num), den) != 1: return None
    return Fr(num, den)

# ---- independent versions ----
def crt_indep(rs):
    """sympy's CRT, wholly separate code path."""
    from sympy.ntheory.modular import crt as scrt
    v, _ = scrt(PS, list(rs))
    return int(v) % M

def ratrec_indep(a, N, D):
    """Wang/Monagan half-EEA with separate numerator and denominator bounds."""
    r0, r1 = M, a % M
    t0, t1 = 0, 1
    while r1 > N:
        q = r0 // r1
        r0, r1, t0, t1 = r1, r0 - q*r1, t1, t0 - q*t1
    if t1 == 0: return None
    num, den = r1, t1
    if den < 0: num, den = -num, -den
    if den > D or gcd(abs(num), den) != 1: return None
    if (num - den * (a % M)) % M != 0: return None      # verify the congruence
    return Fr(num, den)

rows = [d0["rows"] for d0 in data]
rhs  = [d0["rhs"]  for d0 in data]
NR, NC = len(rows[0]), len(rows[0][0])
print(f"\n{NR} x {NC} rows plus {NR} rhs entries")

A = [[None]*NC for _ in range(NR)]
Bv = [None]*NR
crt_mismatch = 0; rr_mismatch = 0; fails = 0; ncheck = 0
maxnum = 0; maxden = 0; maxprod = 0
for i in range(NR):
    for j in range(NC):
        rs = [rows[k][i][j] for k in range(len(PS))]
        a1 = crt_file(rs); a2 = crt_indep(rs)
        if a1 != a2: crt_mismatch += 1
        for k, p in enumerate(PS):
            assert a1 % p == rs[k] % p
        v1 = ratrec_file(a1, BOUND_FILE)
        v2 = ratrec_indep(a1, BOUND_EXACT, BOUND_EXACT)
        if v1 != v2: rr_mismatch += 1
        if v1 is None: fails += 1
        A[i][j] = v1; ncheck += 1
        if v1 is not None:
            maxnum = max(maxnum, abs(v1.numerator)); maxden = max(maxden, v1.denominator)
            maxprod = max(maxprod, abs(v1.numerator)*v1.denominator)
for i in range(NR):
    rs = [rhs[k][i] for k in range(len(PS))]
    a1 = crt_file(rs); a2 = crt_indep(rs)
    if a1 != a2: crt_mismatch += 1
    v1 = ratrec_file(a1, BOUND_FILE); v2 = ratrec_indep(a1, BOUND_EXACT, BOUND_EXACT)
    if v1 != v2: rr_mismatch += 1
    if v1 is None: fails += 1
    Bv[i] = v1; ncheck += 1
    if v1 is not None:
        maxnum = max(maxnum, abs(v1.numerator)); maxden = max(maxden, v1.denominator)
        maxprod = max(maxprod, abs(v1.numerator)*v1.denominator)

print(f"\nCRT disagreements with sympy      : {crt_mismatch} of {ncheck}")
print(f"ratrec disagreements (file vs indep): {rr_mismatch} of {ncheck}")
print(f"reconstruction failures            : {fails} of {ncheck}")
print(f"max |num| = {maxnum}  ({maxnum.bit_length()} bits)")
print(f"max den   = {maxden}  ({maxden.bit_length()} bits)")
print(f"max |num|*den = {maxprod}")
print(f"uniqueness margin: 2*max|num|*den / M = {2*maxprod/M:.4e}   (must be < 1)")
print(f"height headroom  : max height / BOUND = {max(maxnum,maxden)/BOUND_EXACT:.4e}")

import pickle
with open(os.path.join(os.path.dirname(os.path.abspath(__file__)), "lifted.pkl"), "wb") as f:
    pickle.dump({"A": A, "B": Bv, "blocks": data[0]["blocks"], "shape": data[0]["shape"],
                 "primes": PS}, f)
print("\nlifted rationals saved to lifted.pkl")
