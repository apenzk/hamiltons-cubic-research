"""r214 claim 4: the exact rank/kernel facts, recomputed with my own code.

  * CRT + rational reconstruction of A (40x47) and B (40) from the four primes,
    written here rather than imported.
  * exact rank of A and of [A|B] over Q, by fraction-free row reduction.
  * the certificate point x from n5_certificate.json: does A x = B hold EXACTLY,
    and do the shape/blocks metadata agree between the two files?
  * dim ker(A) over Q.
"""
import json, glob, os
from fractions import Fraction as Fr

d = "scripts/runs"
files = sorted(glob.glob(os.path.join(d, "n5_rows_*.json")))
data = [json.load(open(f)) for f in files]
PS = [x["prime"] for x in data]
M = 1
for p in PS: M *= p
BOUND = int((M // 2) ** 0.5)
NR, NC = len(data[0]["rows"]), len(data[0]["rows"][0])

def crt(rs):
    x, m = 0, 1
    for r, p in zip(rs, PS):
        t = ((r - x) * pow(m % p, -1, p)) % p
        x += m * t; m *= p
    return x % m

def ratrec(a):
    r0, r1, s0, s1 = M, a % M, 0, 1
    while r1 > BOUND:
        q = r0 // r1
        r0, r1, s0, s1 = r1, r0 - q*r1, s1, s0 - q*s1
    if s1 == 0 or abs(s1) > BOUND: return None
    n_, dn = (r1, s1) if s1 > 0 else (-r1, -s1)
    from math import gcd
    return Fr(n_, dn) if gcd(abs(n_), dn) == 1 else None

A = [[ratrec(crt([data[k]["rows"][i][j] for k in range(len(PS))]))
      for j in range(NC)] for i in range(NR)]
B = [ratrec(crt([data[k]["rhs"][i] for k in range(len(PS))])) for i in range(NR)]
assert all(v is not None for r in A for v in r) and all(v is not None for v in B)
print(f"lifted A ({NR}x{NC}) and B over Q with no reconstruction failures")

def rref_rank(rows, ncols):
    Mx = [r[:] for r in rows]; r = 0; piv = []
    for c in range(ncols):
        pv = next((t for t in range(r, len(Mx)) if Mx[t][c] != 0), None)
        if pv is None: continue
        Mx[r], Mx[pv] = Mx[pv], Mx[r]
        dv = Mx[r][c]; Mx[r] = [v/dv for v in Mx[r]]
        for t in range(len(Mx)):
            if t != r and Mx[t][c] != 0:
                f = Mx[t][c]; Mx[t] = [u - f*v for u, v in zip(Mx[t], Mx[r])]
        piv.append(c); r += 1
    return Mx, piv

_, pA = rref_rank(A, NC)
_, pAug = rref_rank([A[i] + [B[i]] for i in range(NR)], NC+1)
print(f"exact rank_Q(A)      = {len(pA)}")
print(f"exact rank_Q([A|F5]) = {len(pAug)}   (pivot in the rhs column: "
      f"{NC in pAug})")
print(f"dim ker_Q(A) = {NC - len(pA)}")

C = json.load(open(os.path.join(d, "n5_certificate.json")))
print(f"\ncertificate shape  {C['shape']}")
print(f"rows       shape  {data[0]['shape']}   match: {C['shape']==data[0]['shape']}")
print(f"blocks match: {C['blocks']==data[0]['blocks']}")
x = [Fr(int(a), int(b)) for a, b in C["point"]]
print(f"certificate has {len(x)} coordinates; A has {NC} columns")
bad = [i for i in range(NR) if sum(A[i][j]*x[j] for j in range(NC)) != B[i]]
print(f"equations FAILED by the certificate point, exactly over Q: {len(bad)} of {NR}")
