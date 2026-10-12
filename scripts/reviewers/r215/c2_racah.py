"""r215 claim 2: the Sym^3 character and its decomposition, both recomputed by
routes that share no code with run_n12_sym3.py.

CHARACTER.  Sym^2 is built from the DIRECT multiset count -- m_a*m_b for a != b
and C(m_a+1,2) for a = b -- rather than from power sums, and Sym^3 then from
Newton's RECURRENCE 3 h_3 = h_2 p_1 + h_1 p_2 + h_0 p_3.  The file under review
uses the closed form 6 h_3 = p_1^3 + 3 p_1 p_2 + 2 p_3.

DECOMPOSITION.  Racah's alternation, m_lambda = sum_w sgn(w) chi(w(lambda+rho) -
rho), which reads each multiplicity off the character INDEPENDENTLY of every
other one.  A peel that mis-ordered would have to corrupt this too, and it
cannot: there is no order in it.
"""
import os, sys, pickle, time, importlib.util
from itertools import permutations, product
from fractions import Fraction as F
from math import comb

SC = "/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/ea3d63f3-07ce-4bf2-a0fb-4a245ad3dc41/scratchpad"
sp = importlib.util.spec_from_file_location("w12", os.path.join(SC, "authorrun", "run_n12_weights.py"))
w12 = importlib.util.module_from_spec(sp)
_o = sys.stdout; sys.stdout = open(os.devnull, "w"); sp.loader.exec_module(w12); sys.stdout = _o
RANK, POS, RHO, MULT, orbit = w12.RANK, w12.POS, w12.RHO, w12.MULT, w12.orbit
RHOI = tuple(int(x) for x in RHO)

CHI = {}
for mu, m in MULT.items():
    for nu in orbit(mu): CHI[nu] = CHI.get(nu, 0) + m
assert sum(CHI.values()) == 1638
t0 = time.time()

# ---- Sym^2 by the direct multiset count
ws = sorted(CHI)
H2 = {}
for i, a in enumerate(ws):
    ma = CHI[a]
    k = tuple(2*x for x in a)
    H2[k] = H2.get(k, 0) + ma*(ma+1)//2
    for j in range(i+1, len(ws)):
        b = ws[j]
        k = tuple(a[t]+b[t] for t in range(RANK))
        H2[k] = H2.get(k, 0) + ma*CHI[b]
print(f"Sym^2 direct: {len(H2)} weights, dim {sum(H2.values()):,} "
      f"(expected {comb(1639,2):,}) [{time.time()-t0:.0f}s]", flush=True)
assert sum(H2.values()) == comb(1639, 2)

def mul(P, Q):
    R = {}
    for a, ca in P.items():
        for b, cb in Q.items():
            k = tuple(a[t]+b[t] for t in range(RANK))
            R[k] = R.get(k, 0) + ca*cb
    return R
def power(j): return {tuple(j*x for x in k): v for k, v in CHI.items()}

# ---- Sym^3 by Newton's RECURRENCE, 3 h_3 = h_2 p_1 + h_1 p_2 + p_3
A = mul(H2, CHI)
B = mul(CHI, power(2))
C = power(3)
S3 = {}
for D in (A, B, C):
    for k, v in D.items(): S3[k] = S3.get(k, 0) + v
S3 = {k: v//3 for k, v in S3.items() if v}
assert all(v > 0 for v in S3.values())
bad = [k for k, v in S3.items() if (A.get(k,0)+B.get(k,0)+C.get(k,0)) % 3]
print(f"Sym^3 by recurrence: {len(S3)} weights, dim {sum(S3.values()):,} "
      f"(C(1640,3) = {comb(1640,3):,}), non-integer entries {len(bad)} "
      f"[{time.time()-t0:.0f}s]", flush=True)
assert sum(S3.values()) == comb(1640, 3)

AUT = pickle.load(open(os.path.join(SC, "authorrun", "n12_sym3_char.pkl"), "rb"))
print("character identical to run_n12_sym3.py's:", S3 == AUT)
print("  distinct weights:", len(S3), "author:", len(AUT))
print("  trivial weight space:", S3.get((0,)*RANK), "author:", AUT.get((0,)*RANK))

# ---- Racah alternation
SGN = {}
W = []
for perm in permutations(range(RANK)):
    # sign of the permutation
    s = 1; seen = [False]*RANK
    for i in range(RANK):
        if seen[i]: continue
        L = 0; j = i
        while not seen[j]: seen[j] = True; j = perm[j]; L += 1
        if L % 2 == 0: s = -s
    for signs in product((1,-1), repeat=RANK):
        if signs.count(-1) % 2: continue
        W.append((perm, signs, s))
print(f"|W(D_6)| = {len(W)} (expected {720*32})", flush=True)
assert len(W) == 720*32

def is_dom(v):
    return all(v[i] >= v[i+1] for i in range(RANK-2)) and v[RANK-2] >= abs(v[RANK-1])

cands = sorted(k for k in S3 if is_dom(k))
print(f"dominant weights present in Sym^3: {len(cands)}", flush=True)

def racah(lam):
    lr = tuple(lam[t] + RHOI[t] for t in range(RANK))
    tot = 0
    for perm, signs, s in W:
        v = tuple(signs[t]*lr[perm[t]] - RHOI[t] for t in range(RANK))
        c = S3.get(v)
        if c: tot += s*c
    return tot

BL = {}
for lam in cands:
    m = racah(lam)
    if m: BL[lam] = m
print(f"Racah: {len(BL)} constituents, total multiplicity {sum(BL.values())} "
      f"[{time.time()-t0:.0f}s]", flush=True)
neg = {k: v for k, v in BL.items() if v < 0}
print("  negative multiplicities:", neg)

AB = pickle.load(open(os.path.join(SC, "authorrun", "n12_sym3_blocks.pkl"), "rb"))
print("decomposition identical to the peel's:", BL == AB)
if BL != AB:
    for k in sorted(set(BL) | set(AB)):
        if BL.get(k, 0) != AB.get(k, 0):
            print("   DIFFER", k, "racah", BL.get(k, 0), "peel", AB.get(k, 0))

# ---- dimensions by the Weyl dimension formula, an independent sum check
def ip(u, v): return sum(F(x)*F(y) for x, y in zip(u, v))
def wdim(lam):
    n = d = F(1)
    for a in POS:
        n *= ip([x+y for x, y in zip(lam, RHO)], a); d *= ip(RHO, a)
    return n/d
tot = sum(m*wdim(l) for l, m in BL.items())
print(f"sum m_lambda * dim V(lambda) = {int(tot):,}  vs C(1640,3) = {comb(1640,3):,}",
      "MATCH" if tot == comb(1640,3) else "MISMATCH")
print("trivial-block multiplicity (cubic O(12) invariants of Weyl_12):",
      BL.get((0,)*RANK))
with open(os.path.join(SC, "r215_blocks.pkl"), "wb") as f: pickle.dump(BL, f)
