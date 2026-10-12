"""r213 claim 2: does the certificate point satisfy the affine system exactly over Q?

Independent of run_n5_lift.py: CRT and rational reconstruction are reimplemented
here, the lift is cross-validated against a prime HELD OUT of it, and the
certificate's 47 rationals are substituted into all 40 equations exactly.
"""
import json, os, glob
from fractions import Fraction as F

RUNS = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
files = sorted(glob.glob(os.path.join(RUNS, "n5_rows_*.json")))
data = [json.load(open(f)) for f in files]
PS = [x["prime"] for x in data]
print(f"primes {PS}")
for x in data[1:]:
    assert x["blocks"] == data[0]["blocks"] and x["shape"] == data[0]["shape"]
SHAPE = data[0]["shape"]
NR, NC = len(data[0]["rows"]), len(data[0]["rows"][0])
print(f"{NR} equations x {NC} unknowns, shape {SHAPE}")

def egcd(a, b):
    if b == 0: return (a, 1, 0)
    g, x, y = egcd(b, a % b)
    return (g, y, x - (a//b)*y)

def lift(idxs):
    """CRT + rational reconstruction using only the primes at positions idxs."""
    ps = [PS[i] for i in idxs]
    M = 1
    for p in ps: M *= p
    BOUND = int((M // 2) ** 0.5)
    def crt(rs):
        x, m = 0, 1
        for r, p in zip(rs, ps):
            g = egcd(m % p, p)[1] % p
            x += m * (((r - x) * g) % p); m *= p
        return x % m
    def ratrec(a):
        r0, r1, s0, s1 = M, a % M, 0, 1
        while r1 > BOUND:
            q = r0 // r1
            r0, r1 = r1, r0 - q*r1
            s0, s1 = s1, s0 - q*s1
        if s1 == 0 or abs(s1) > BOUND: return None
        n, dd = (r1, s1) if s1 > 0 else (-r1, -s1)
        from math import gcd
        return None if gcd(abs(n), dd) != 1 else F(n, dd)
    A = [[ratrec(crt([data[k]["rows"][i][j] for k in idxs])) for j in range(NC)]
         for i in range(NR)]
    B = [ratrec(crt([data[k]["rhs"][i] for k in idxs])) for i in range(NR)]
    return A, B, BOUND

# ---- lift from three primes, then TEST against the fourth ----
A3, B3, bnd3 = lift([0, 1, 2])
bad = sum(1 for r in A3 for v in r if v is None) + sum(1 for v in B3 if v is None)
print(f"lift from 3 primes: {bad} entries failed to reconstruct")
assert bad == 0
p4 = PS[3]
mis = 0
for i in range(NR):
    for j in range(NC):
        v = A3[i][j]
        if v.numerator * pow(v.denominator, p4-2, p4) % p4 != data[3]["rows"][i][j] % p4:
            mis += 1
    v = B3[i]
    if v.numerator * pow(v.denominator, p4-2, p4) % p4 != data[3]["rhs"][i] % p4:
        mis += 1
print(f"held-out prime {p4}: {mis} of {NR*NC+NR} residues disagree with the lift")
assert mis == 0, "the 3-prime lift does not reduce to the fourth prime's residues"
print("  the rationals are pinned: a wrong reconstruction would miss mod p4 with")
print(f"  probability 1 - O(1/p4), p4 ~ 2^{p4.bit_length()}")

A, B, BND = lift([0, 1, 2, 3])
assert A == A3 and B == B3, "the 4-prime lift differs from the 3-prime lift"
hts = [max(abs(x.numerator), x.denominator) for r in A for x in r if x]
print(f"heights: max {max(hts)}, bound {BND}, max/bound = {max(hts)/BND:.3e}")
assert max(hts) < BND

# ---- the certificate point ----
C = json.load(open(os.path.join(RUNS, "n5_certificate.json")))
x = [F(int(a), int(b)) for a, b in C["point"]]
assert C["shape"] == SHAPE, "the certificate's shape differs from the dumps'"
assert C["blocks"] == data[0]["blocks"], "the certificate's block labels differ"
assert len(x) == NC
res = [sum(A[i][j]*x[j] for j in range(NC)) - B[i] for i in range(NR)]
nz = [i for i, r in enumerate(res) if r != 0]
print(f"\nA x - B over Q: {len(nz)} of {NR} equations violated")
assert not nz, f"equations violated at rows {nz}: {[str(res[i]) for i in nz[:3]]}"
print("EVERY equation holds EXACTLY over Q.")

# ---- rank, over Q, exactly ----
def rref(M, nc):
    M = [r[:] for r in M]; piv = []; r = 0
    for c in range(nc):
        pv = next((t for t in range(r, len(M)) if M[t][c] != 0), None)
        if pv is None: continue
        M[r], M[pv] = M[pv], M[r]
        dd = M[r][c]; M[r] = [v/dd for v in M[r]]
        for t in range(len(M)):
            if t != r and M[t][c] != 0:
                f0 = M[t][c]; M[t] = [v - f0*w for v, w in zip(M[t], M[r])]
        piv.append(c); r += 1
    return M, piv
_, pivA = rref(A, NC)
_, pivAug = rref([A[i] + [B[i]] for i in range(NR)], NC+1)
print(f"exact rank over Q: rank(A) = {len(pivA)}, rank([A|B]) = {len(pivAug)}")
print(f"  consistent: {NC not in pivAug}   affine family dimension: {NC - len(pivA)}")
