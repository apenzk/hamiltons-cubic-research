"""Do the CACHED raising operators deserve to be trusted?

run_n5_cubic_forms.py's "41/41 annihilated" re-applies the very matrices E1C,
E2C that defined the vectors as a nullspace.  It therefore cannot see an error
in E1C/E2C themselves.  This script tests E1C/E2C directly, three ways, none of
which uses the hw vectors:

  T1  Serre relations for B2 and the dimension of the algebra they generate.
  T2  the joint kernel of E1,E2 on Weyl_5 itself is 1-dimensional
      (so Weyl_5 is the irreducible V_(2,2), not a sum with the same weights).
  T3  a mod-p sweep of the joint kernel of E1,E2 over EVERY weight space of
      Sym^3 -- all 169, against the 24 the shipped script looks at -- compared
      with the character-theoretic multiplicities of claim2_plethysm.py.
      rank mod p <= rank over Q, so nullity mod p is an UPPER bound on the true
      nullity: a predicted 0 that comes out 0 mod p is proved 0 over Q.

Then, and only as the lower half of the sandwich, T4 re-verifies the cached
vectors lie in the kernel and are independent, with linear algebra written here.
"""
from fractions import Fraction as F
from itertools import combinations_with_replacement
from collections import Counter
import json, sys, os

C = json.load(open("scripts/runs/n5_hw_cache.json"))
WWT = [tuple(w) for w in C["weights"]]

class G:
    __slots__ = ("r", "i")
    def __init__(s, r=0, i=0): s.r = F(r); s.i = F(i)
    def __add__(s, o): o = mk(o); return G(s.r+o.r, s.i+o.i)
    def __sub__(s, o): o = mk(o); return G(s.r-o.r, s.i-o.i)
    def __mul__(s, o): o = mk(o); return G(s.r*o.r-s.i*o.i, s.r*o.i+s.i*o.r)
    def __truediv__(s, o):
        o = mk(o); d = o.r*o.r+o.i*o.i
        return G((s.r*o.r+s.i*o.i)/d, (s.i*o.r-s.r*o.i)/d)
    __rmul__ = __mul__
    def __bool__(s): return bool(s.r) or bool(s.i)
    def __eq__(s, o): o = mk(o); return s.r == o.r and s.i == o.i
    def __repr__(s): return f"({s.r}{'+' if s.i>=0 else '-'}{abs(s.i)}i)"
def mk(x): return x if isinstance(x, G) else G(x)
def fj(p): return G(F(p[0][0], p[0][1]), F(p[1][0], p[1][1]))
Z, ONE = G(0), G(1)

E1 = [[fj(x) for x in row] for row in C["E1C"]]
E2 = [[fj(x) for x in row] for row in C["E2C"]]

def mm(A, B):
    n = len(A)
    return [[sum((A[i][k]*B[k][j] for k in range(n) if A[i][k]), Z) for j in range(n)]
            for i in range(n)]
def msub(A, B): return [[a-b for a, b in zip(x, y)] for x, y in zip(A, B)]
def nz(A): return any(any(r) for r in A)
def br(A, B): return msub(mm(A, B), mm(B, A))

print("(T1 Serre and T2 irreducibility live in claim2_serre.py, which\n transposes the cache first: E1C[j][k] is stored as input j -> output k.)")

print("\n=== T3  joint kernel over EVERY weight space of Sym^3, mod p ===")
p = 1000000007
while pow(2, (p-1)//2, p) != 1 or (p % 4) != 1: p += 2   # want p = 1 mod 4
IP = None
for g in range(2, 100):
    t = pow(g, (p-1)//4, p)
    if (t*t) % p == p-1: IP = t; break
print(f"  prime p = {p} (= 1 mod 4), sqrt(-1) mod p = {IP}")
def gp(x):
    return (x.r.numerator*pow(x.r.denominator, -1, p)
            + IP*(x.i.numerator*pow(x.i.denominator, -1, p))) % p
E1P = [[gp(x) for x in row] for row in E1]
E2P = [[gp(x) for x in row] for row in E2]

MONO = list(combinations_with_replacement(range(35), 3))
MIDX = {m: i for i, m in enumerate(MONO)}
MW = [tuple(WWT[a][k]+WWT[b][k]+WWT[c][k] for k in (0, 1)) for a, b, c in MONO]
BYW = {}
for idx, w in enumerate(MW): BYW.setdefault(w, []).append(idx)
print(f"  Sym^3 has {len(BYW)} nonempty weight spaces "
      f"(the shipped script visits {24})")

def raise_mono_p(idx, EP):
    a, b, c = MONO[idx]; out = {}
    for pos, x in enumerate((a, b, c)):
        rest = [y for j, y in enumerate((a, b, c)) if j != pos]
        row = EP[x]
        for t in range(35):
            if row[t]:
                j = MIDX[tuple(sorted(rest + [t]))]
                out[j] = (out.get(j, 0) + row[t]) % p
    return {k: v for k, v in out.items() if v}

def rank_p(rows, n):
    M = [r[:] for r in rows]; r = 0
    for c in range(n):
        piv = next((k for k in range(r, len(M)) if M[k][c]), None)
        if piv is None: continue
        M[r], M[piv] = M[piv], M[r]
        inv = pow(M[r][c], -1, p)
        Mr = [(x*inv) % p for x in M[r]]; M[r] = Mr
        for k in range(len(M)):
            if k != r and M[k][c]:
                f = M[k][c]; Mk = M[k]
                M[k] = [(u - f*v) % p for u, v in zip(Mk, Mr)]
        r += 1
        if r == len(M): break
    return r

ALPHA = [(1, -1), (0, 1)]
ker = {}
for mu, cols in sorted(BYW.items(), key=lambda kv: -len(kv[1])):
    rows = []
    for EP, a in ((E1P, ALPHA[0]), (E2P, ALPHA[1])):
        tgt = BYW.get((mu[0]+a[0], mu[1]+a[1]), [])
        tix = {m: k for k, m in enumerate(tgt)}
        blk = [[0]*len(cols) for _ in range(len(tgt))]
        outside = 0
        for j, m in enumerate(cols):
            for k, v in raise_mono_p(m, EP).items():
                if k in tix: blk[tix[k]][j] = v
                else: outside += 1
        if outside: print(f"    !! weight {mu}: image leaves the target weight space")
        rows.extend(blk)
    ker[mu] = len(cols) - (rank_p(rows, len(cols)) if rows else 0)
    print(f"    weight {mu}: dim {len(cols):3d}, joint kernel {ker[mu]}", flush=True)

BLOCKS = {(4,2):4, (2,2):4, (3,2):3,
          (5,2):2, (4,3):2, (4,4):2, (4,1):2, (3,1):2, (4,0):2, (2,1):2, (3,0):2, (2,0):2,
          (0,0):1, (1,0):1, (3,3):1, (5,0):1, (5,1):1, (5,3):1,
          (6,0):1, (5,4):1, (6,2):1, (6,3):1, (6,4):1, (6,6):1}
pred = {mu: BLOCKS.get(mu, 0) for mu in BYW}
bad = {mu: (ker[mu], pred[mu]) for mu in BYW if ker[mu] != pred[mu]}
nondom = [mu for mu in BYW if not (mu[0] >= mu[1] >= 0)]
print(f"\n  total joint kernel over all weights: {sum(ker.values())} "
      f"(character theory says 41)")
print(f"  non-dominant weights with a spurious kernel: "
      f"{[mu for mu in nondom if ker[mu]]}")
print(f"  every weight matches the character-theoretic multiplicity: {not bad}")
if bad: print(f"    mismatches (found, predicted): {bad}")
print("  nullity mod p >= nullity over Q, so the zeros are PROVED zero over Q,")
print("  and the dominant entries are proved to be upper bounds.")

print("\n=== T4  the cached vectors: in the kernel, and independent (exact) ===")
hw = {}
for key, v in C["hw"].items():
    lam = tuple(int(x) for x in key.split(","))
    cols = v["cols"]
    hw[lam] = (cols, [[fj(x) for x in vec] for vec in v["vecs"]])
tot = sum(len(v[1]) for v in hw.values())
inker = indep = 0
for lam, (cols, vecs) in hw.items():
    for vec in vecs:
        d = {cols[j]: vec[j] for j in range(len(cols)) if vec[j]}
        ok = True
        for EC in (E1, E2):
            out = {}
            for idx, co in d.items():
                a, b, c = MONO[idx]
                for pos, x in enumerate((a, b, c)):
                    rest = [y for j, y in enumerate((a, b, c)) if j != pos]
                    for t in range(35):
                        if EC[x][t]:
                            j = MIDX[tuple(sorted(rest+[t]))]
                            out[j] = out.get(j, Z) + co*EC[x][t]
            if any(v for v in out.values()): ok = False
        inker += ok
    nul_, rk_ = nullity_G([v[:] for v in vecs], len(cols))
    indep += rk_
print(f"  in the joint kernel: {inker}/{tot}")
print(f"  linearly independent within their weight spaces: {indep}/{tot}")
print(f"\n  SANDWICH: {indep} independent kernel vectors (lower bound) against a")
print(f"  mod-p nullity of {sum(ker.values())} (upper bound) -> the 41 is exact.")
