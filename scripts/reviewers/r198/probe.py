"""Reviewer 198.  Claim 2 (the nonsingularity control) and claim 4 (the cache).

Replicates the arithmetic of run_n5_assemble.py verbatim rather than importing
it, because importing that file runs the whole stage.  Nothing under review is
written to.
"""
import importlib.util, sys, os, pickle, copy as _copy
from fractions import Fraction as Fr

RUNS = "scripts/runs"
def load(name, quiet=True):
    sp = importlib.util.spec_from_file_location(name[:-3], os.path.join(RUNS, name))
    m = importlib.util.module_from_spec(sp)
    if quiet:
        o = sys.stdout; sys.stdout = open(os.devnull, "w")
    sp.loader.exec_module(m)
    if quiet: sys.stdout = o
    return m

ad = load("run_n5_adapted.py")
ADAPTED, MONO, WWT, G, ZERO = ad.ADAPTED, ad.MONO, ad.WWT, ad.G, ad.ZERO
ev = load("run_n5_evaluate.py")
sym3_ip = ev.sym3_ip

PRIME = 65537; IMOD = 256
def to_p(x):
    if hasattr(x, "r"): a, b = x.r, x.i
    else: (a, b) = x
    return (a.numerator * pow(a.denominator % PRIME, PRIME-2, PRIME)
            + b.numerator * pow(b.denominator % PRIME, PRIME-2, PRIME) * IMOD) % PRIME
_IPC = {}
def sym3_ip_p(t, s):
    if (t, s) not in _IPC: _IPC[(t, s)] = to_p(sym3_ip(t, s))
    return _IPC[(t, s)]
def ip3(u, v):
    tot = 0
    for a, ca in u.items():
        ta = MONO[a]; cap = to_p(ca)
        if not cap: continue
        for b, cb in v.items():
            k = sym3_ip_p(ta, MONO[b])
            if k:
                cbp = to_p((cb.r, -cb.i) if hasattr(cb, "r") else (cb[0], -cb[1]))
                tot = (tot + cap * cbp % PRIME * k) % PRIME
    return tot
def det_p(M):
    M = [row[:] for row in M]; n = len(M); d = 1
    for c in range(n):
        piv = next((r for r in range(c, n) if M[r][c] % PRIME), None)
        if piv is None: return 0
        if piv != c: M[c], M[piv] = M[piv], M[c]; d = -d
        d = d * M[c][c] % PRIME
        inv = pow(M[c][c], PRIME-2, PRIME)
        for r in range(c+1, n):
            f = M[r][c] * inv % PRIME
            if f: M[r] = [(x - f*y) % PRIME for x, y in zip(M[r], M[c])]
    return d % PRIME

def hmat(copies, probe=0):
    """exactly the shipped construction, at a chosen probe position"""
    m = len(copies)
    if m == 1: return [[1]]
    q00 = ip3(copies[0][probe], copies[0][probe])
    inv = pow(q00, PRIME-2, PRIME)
    return [[ip3(copies[i][probe], copies[j][probe]) * inv % PRIME
             for j in range(m)] for i in range(m)]

def mwt(idx):
    a, b, c = MONO[idx]
    return (WWT[a][0]+WWT[b][0]+WWT[c][0], WWT[a][1]+WWT[b][1]+WWT[c][1])

print("=" * 70)
print("A.  the shipped control is a constant matrix")
print("=" * 70)
HMAT = {lam: hmat(cs) for lam, cs in ADAPTED.items()}
h00 = sorted({HMAT[l][0][0] for l in HMAT})
print(f"  distinct values of HMAT[lam][0][0] over all 24 blocks: {h00}")
print(f"  so the shipped _ctl is [[1,1],[1,1]] for every choice of lam,")
print(f"  det_p([[1,1],[1,1]]) = {det_p([[1,1],[1,1]])}")
print(f"  and it is 0 for any x at all: det_p([[7,7],[7,7]]) = {det_p([[7,7],[7,7]])},"
      f"  det_p([[0,0],[0,0]]) = {det_p([[0,0],[0,0]])}")

print()
print("=" * 70)
print("B.  real controls -- degenerate copy structures pushed through ip3")
print("=" * 70)
def scal(vec, c):
    return {k: v * c for k, v in vec.items()}
def addv(u, v):
    out = dict(u)
    for k, c in v.items():
        out[k] = out.get(k, ZERO) + c
    return {k: c for k, c in out.items() if c}

L2 = (2, 1)                       # m = 2
L3 = (3, 2)                       # m = 3
c = ADAPTED[L2]
print(f"  block {L2}, m=2, shipped h = {HMAT[L2]}, det = {det_p(HMAT[L2])}")
ctl1 = [c[0], [dict(v) for v in c[0]]]
print(f"  REAL control 1  copy 1 := copy 0 (literally coincident)")
print(f"                  h = {hmat(ctl1)}  det = {det_p(hmat(ctl1))}   (must be 0)")
three = G(3, 0)
ctl2 = [c[0], [scal(v, three) for v in c[0]]]
print(f"  REAL control 2  copy 1 := 3 * copy 0 (same submodule, rescaled)")
print(f"                  h = {hmat(ctl2)}  det = {det_p(hmat(ctl2))}   (must be 0)")
ctl3 = [c[0], c[1], [addv(a, b) for a, b in zip(c[0], c[1])]]
print(f"  REAL control 3  a DEPENDENT TRIPLE, copy 2 := copy 0 + copy 1")
print(f"                  h = {hmat(ctl3)}")
print(f"                  det = {det_p(hmat(ctl3))}   (must be 0)")
d3 = ADAPTED[L3]
ctl4 = [d3[0], d3[1], [addv(scal(a, G(2, 0)), b) for a, b in zip(d3[0], d3[1])]]
print(f"  REAL control 4  block {L3}, m=3 -> copy 2 := 2*copy 0 + copy 1")
print(f"                  det = {det_p(hmat(ctl4))}   (must be 0), "
      f"shipped det = {det_p(HMAT[L3])}")

print()
print("=" * 70)
print("C.  claim 4 -- a stale cache with the right count")
print("=" * 70)
n = sum(len(v) for cs in ADAPTED.values() for v in cs)
print(f"  the shipped assert is exactly: n == 7770.  n = {n}")

# corruption 1: a genuine coincident pair, planted in the cache
bad1 = {lam: [[dict(v) for v in cp] for cp in cs] for lam, cs in ADAPTED.items()}
bad1[L2][1] = [dict(v) for v in bad1[L2][0]]
n1 = sum(len(v) for cs in bad1.values() for v in cs)
print(f"\n  corruption 1: block {L2} copy 1 := copy 0.  count = {n1} -> "
      f"cache assert PASSES: {n1 == 7770}")
print(f"                downstream det h = {det_p(hmat(bad1[L2]))} -> h-assert catches it")

# corruption 2: one vector rescaled, at a position no probe reads
TGT = (5, 0)                              # m = 1 block
bad2 = {lam: [[dict(v) for v in cp] for cp in cs] for lam, cs in ADAPTED.items()}
bad2[TGT][0][7] = scal(bad2[TGT][0][7], G(2, 0))
n2 = sum(len(v) for cs in bad2.values() for v in cs)
print(f"\n  corruption 2: block {TGT} (m=1), vector at position 7 doubled.")
print(f"                count = {n2} -> cache assert PASSES: {n2 == 7770}")

# corruption 3: same, inside a MULTIPLICITY block, above the probe window
bad3 = {lam: [[dict(v) for v in cp] for cp in cs] for lam, cs in ADAPTED.items()}
POS = 7
bad3[L2][0][POS] = scal(bad3[L2][0][POS], G(2, 0))
n3 = sum(len(v) for cs in bad3.values() for v in cs)
print(f"\n  corruption 3: block {L2} (m=2), copy 0 position {POS} doubled.")
print(f"                count = {n3} -> cache assert PASSES: {n3 == 7770}")
print(f"                det h (probe 0)      = {det_p(hmat(bad3[L2]))}  (shipped assert: nonzero)")
for lam, bad in ((L2, bad3),):
    dis = 0
    for t in range(1, min(4, len(bad[lam][0]))):
        q = ip3(bad[lam][0][t], bad[lam][0][t])
        if not q: continue
        inv = pow(q, PRIME-2, PRIME)
        for i in range(len(bad[lam])):
            for j in range(len(bad[lam])):
                if ip3(bad[lam][i][t], bad[lam][j][t]) * inv % PRIME != hmat(bad[lam])[i][j]:
                    dis += 1
    print(f"                multi-probe t=1..3 disagreements = {dis}  (shipped assert: 0)")
    inhom = sum(1 for cs in bad.values() for cp in cs for v in cp
                if len({mwt(k) for k in v}) > 1)
    print(f"                weight-inhomogeneous vectors      = {inhom}  (shipped assert: 0)")
    # the probe that WOULD see it
    hp = hmat(bad[lam], probe=POS)
    print(f"                h at probe {POS} = {hp}, against shipped {HMAT[lam]}")
    print(f"                -> the corruption is visible ONLY at t = {POS}, "
          f"outside the t=1..3 window")

print()
print("=" * 70)
print("D.  to_p on denominators divisible by 65537")
print("=" * 70)
bad_den = 0; seen = 0
for cs in ADAPTED.values():
    for cp in cs:
        for v in cp:
            for x in v.values():
                seen += 1
                if x.r.denominator % PRIME == 0 or x.i.denominator % PRIME == 0:
                    bad_den += 1
print(f"  adapted-vector coefficients scanned: {seen:,}")
print(f"  with a denominator divisible by {PRIME}: {bad_den}   "
      f"(to_p would silently return the wrong residue, no guard)")
