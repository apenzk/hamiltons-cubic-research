#!/usr/bin/env python3
"""r177: independent decomposition of Sym^3(Weyl_n) for so(n), n in {5,12}.

Method, from the definitions only:
  * weight multiplicities m(mu) of the Weyl-tensor irrep V = V_{(2,2)} are taken
    from Sage's Freudenthal implementation (wm_*.json);
  * ch(Sym^3 V) = (p1^3 + 3 p1 p2 + 2 p3)/6 with p_k(mu) = m(mu) at weight k*mu
    (Adams operations / Newton's identity for the symmetric cube);
  * multiplicities of irreducibles are extracted by Racah's formula
        n_lambda = sum_{w in W} eps(w) * m(lambda + rho - w rho).
No number from the project record is read anywhere in this file.
"""
import json, sys, itertools
from collections import defaultdict

which = sys.argv[1]
here = "scripts/reviewers/r177/"
wm = {}
for k, v in json.load(open(here + "wm_%s.json" % which)).items():
    wm[tuple(int(x) for x in k.split(","))] = int(v)
r = len(next(iter(wm)))
print("rank", r, "distinct weights", len(wm), "dim", sum(wm.values()))

def scale(d, k):
    return {tuple(k * x for x in w): m for w, m in d.items()}

def mul(a, b):
    out = defaultdict(int)
    for wa, ma in a.items():
        for wb, mb in b.items():
            out[tuple(x + y for x, y in zip(wa, wb))] += ma * mb
    return out

p1 = wm
p2 = scale(wm, 2)
p3 = scale(wm, 3)
p11 = mul(p1, p1)
p111 = mul(p11, p1)
p12 = mul(p1, p2)
sym3 = defaultdict(int)
for w, m in p111.items():
    sym3[w] += m
for w, m in p12.items():
    sym3[w] += 3 * m
for w, m in p3.items():
    sym3[w] += 2 * m
for w in list(sym3):
    assert sym3[w] % 6 == 0, (w, sym3[w])
    sym3[w] //= 6
    if sym3[w] == 0:
        del sym3[w]
D = sum(sym3.values())
n = sum(wm.values())
print("Sym^3 total dim", D, "expected", n * (n + 1) * (n + 2) // 6)
assert D == n * (n + 1) * (n + 2) // 6

# --- Weyl group, in the e-basis ---
typ = "B" if which.startswith("B") else "D"
perms = list(itertools.permutations(range(r)))
W = []
for p in perms:
    psign = 1
    # sign of permutation
    seen = [False] * r
    for i in range(r):
        if not seen[i]:
            j, L = i, 0
            while not seen[j]:
                seen[j] = True
                j = p[j]
                L += 1
            psign *= (-1) ** (L - 1)
    for bits in range(1 << r):
        flips = [(-1) ** ((bits >> i) & 1) for i in range(r)]
        nneg = sum(1 for f in flips if f < 0)
        if typ == "D" and nneg % 2:
            continue
        W.append((p, tuple(flips), psign * ((-1) ** nneg if typ == "B" else 1)))
print("|W| =", len(W))

# rho, doubled to stay integral
two_rho = tuple(2 * (r - i) - (1 if typ == "B" else 2) for i in range(r))
print("2*rho =", two_rho)

def act(w, v):
    p, fl, _ = w
    out = [0] * r
    for i in range(r):
        out[p[i]] = fl[p[i]] * v[i]
    return tuple(out)

# precompute rho - w rho  (integral)
shifts = []
for w in W:
    wr = act(w, two_rho)
    d = tuple((a - b) for a, b in zip(two_rho, wr))
    assert all(x % 2 == 0 for x in d)
    shifts.append((tuple(x // 2 for x in d), w[2]))

def dominant(v):
    for i in range(r - 1):
        if v[i] < v[i + 1]:
            return False
    if typ == "B":
        return v[r - 1] >= 0
    return v[r - 2] >= abs(v[r - 1])

doms = sorted([v for v in sym3 if dominant(v)], key=lambda v: (-sum(abs(x) for x in v), v))
print("dominant weights present:", len(doms))

def dim_irrep(lam):
    # Weyl dimension formula in the e-basis
    from fractions import Fraction
    l = [lam[i] + Fraction(two_rho[i], 2) for i in range(r)]
    num = den = Fraction(1)
    rh = [Fraction(two_rho[i], 2) for i in range(r)]
    for i in range(r):
        for j in range(i + 1, r):
            num *= (l[i] - l[j]) * (l[i] + l[j])
            den *= (rh[i] - rh[j]) * (rh[i] + rh[j])
        if typ == "B":
            num *= l[i]
            den *= rh[i]
    q = num / den
    assert q.denominator == 1
    return int(q)

res = []
tot = 0
for lam in doms:
    s = 0
    for d, e in shifts:
        s += e * sym3.get(tuple(a + b for a, b in zip(lam, d)), 0)
    if s:
        res.append((lam, s, dim_irrep(lam)))
        tot += s * dim_irrep(lam)
print("constituents:", len(res), " sum m*dim =", tot, " matches:", tot == D)
for lam, m, dd in res:
    print("  lam=%-22s mult=%-3d dim=%d" % (str(lam), m, dd))
json.dump([[list(l), m, d] for l, m, d in res], open(here + "decomp_%s.json" % which, "w"))
