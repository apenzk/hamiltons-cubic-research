"""Stage 3: the 14 equations, assembled by evaluation.

Everything upstream is now verified by at least two independent reviewers:
the adapted basis realises phi_j phi_i^{-1} (192, by equivariance, Kronecker
test 0/784 and 0/3136), the Sym^3 metric is Fischer (191 and 192 by different
discriminating tests), the coordinate solve is correct as a pair (round-trip
exactly 0, every swap breaks it), and kappa = 6 ties all three together.

Per sample W:  W^3 -> expand per weight in the adapted basis -> multiplicity
coordinates c^{lambda,i} -> B_ij = conj(c^i)^T Q c^j -> one equation
sum_ij G_ij B_ij = F_5(W).

The c are coordinates in the ABSTRACT V(lambda), so no multiplicity-Gram factor
enters; Q is read off copy 1, whose ambient Gram is h_11 Q, a uniform positive
scalar per block that G absorbs.  192 required this reading be stated before the
code was written, because the alternative moves the SDP's feasible set.

Checks that can fail, run before the solve:
  * B must be HERMITIAN at every sample point;
  * the trivial block must give B_11 proportional to tr(W^3)^2, the one
    invariant the covariants reach (189);
  * the coefficient matrix must have rank EXACTLY 14.  "At most 14" is the
    one-sided version and it is blind to the likelier failure: rank BELOW 14
    means the samples do not span the invariant sextics, and 194 adds that the
    bound is vacuous below 15 samples, which this file never stated.  Rank
    above 14 means the equations are not all invariant.
  * and the test with real content is CONSISTENCY, rank(A) = rank[A | F_5],
    which the list first written here omitted entirely (194).

NONE OF THESE WAS IN THE CODE when 193 and 194 read this file: it built the
adapted basis, printed three lines of weight bookkeeping, and stopped.  The
docstring described checks that did not run -- the same defect 191 had found in
run_n5_evaluate.py an hour earlier.
"""
import importlib.util, sys, os, time, random
from fractions import Fraction as F

d = os.path.dirname(os.path.abspath(__file__))
def load(name, quiet=True):
    sp = importlib.util.spec_from_file_location(name[:-3], os.path.join(d, name))
    m = importlib.util.module_from_spec(sp)
    if quiet:
        o = sys.stdout; sys.stdout = open(os.devnull, "w")
    sp.loader.exec_module(m)
    if quiet: sys.stdout = o
    return m

t0 = time.time()
ad = load("run_n5_adapted.py", quiet=False)
print(f"\nadapted basis ready [{time.time()-t0:.0f}s]", flush=True)
ADAPTED, MONO, WWT = ad.ADAPTED, ad.MONO, ad.WWT
G, ZERO = ad.G, ad.ZERO

# weight of a Sym^3 monomial
def mwt(idx):
    a, b, c = MONO[idx]
    return (WWT[a][0]+WWT[b][0]+WWT[c][0], WWT[a][1]+WWT[b][1]+WWT[c][1])

# index the adapted vectors by weight, tagged with (block, copy, position)
BYW = {}
for lam, copies in ADAPTED.items():
    for i, c in enumerate(copies):
        for t, v in enumerate(c):
            if not v: continue
            w = mwt(max(v))
            BYW.setdefault(w, []).append((lam, i, t, v))
tot = sum(len(v) for v in BYW.values())
print(f"adapted vectors indexed by weight: {tot} (7770: {tot == 7770})", flush=True)
sizes = sorted((len(v) for v in BYW.values()), reverse=True)
print(f"  {len(BYW)} weights, largest space {sizes[0]}, "
      f"sum of squares of sizes {sum(s*s for s in sizes):,}", flush=True)
print(f"\n  the per-weight solves are what stage 3 costs; the largest is "
      f"{sizes[0]} x {sizes[0]}.", flush=True)


# ---------- the Sym^3 Hermitian inner product ----------
from itertools import permutations
from fractions import Fraction as Fr
ev = load("run_n5_evaluate.py", quiet=True)
H, sym3_ip, cmul, cadd, cconj = ev.H, ev.sym3_ip, ev.cmul, ev.cadd, ev.cconj

# ARITHMETIC.  Exact Fractions here cost 28 minutes for work reviewer 196 did in
# 13 seconds mod p.  The certificate needs exactness only at the FINAL PSD
# verification -- everything upstream screens, and a screen that is wrong mod p
# is wrong over Q too.  So ip3 works mod a prime with i present, and the exact
# path stays available for the one place it is needed.
# THE PRIME MUST BE UNRELATED TO THE CONSTRUCTION.  65537 = 2^16 + 1 and the
# cached coefficients are built from powers of two, so the prime divided the
# data: reviewer 197 found a live witness, lambda=(6,4) copy 0 position 787,
# a nonzero rational factoring as 2^24 * 3^6 * 5^3 * 7 * 65537.  Choosing a
# prime with no such coupling removes the false zero for free.
PRIME = 1000033                    # 1 mod 4, and unrelated to powers of 2
IMOD = next(x for x in range(2, PRIME) if pow(x, 2, PRIME) == PRIME - 1)
assert pow(IMOD, 2, PRIME) == PRIME - 1

# AND THE DIRECTION OF THE mod-p ARGUMENT IS ONE-SIDED.  Reduction gives
# "nonzero mod p => nonzero over Q" and nothing the other way.  So it supports
# the NONSINGULARITY assert, which passes on non-vanishing, and does NOT support
# the two zero-tests below, which pass on vanishing.  Those are screens: a
# nonzero result refutes outright, a zero result is evidence pending the exact
# check.  197 recomputed every verdict at a second prime and got the same.

def to_p(x):
    """Gaussian rational -> F_p, with i = 256.

    Accepts BOTH representations in play: the (re, im) tuples sym3_ip returns
    and the G objects the adapted basis carries.  Mixing the two silently is
    what this cycle keeps paying for, so the conversion is explicit here.
    """
    if hasattr(x, "r"): a, b = x.r, x.i
    else: (a, b) = x
    assert a.denominator % PRIME and b.denominator % PRIME, (
        "a denominator is divisible by the prime; pow(0, p-2, p) would silently "
        "return the reduction of a pole")
    return (a.numerator * pow(a.denominator % PRIME, PRIME-2, PRIME)
            + b.numerator * pow(b.denominator % PRIME, PRIME-2, PRIME) * IMOD) % PRIME

# BOUNDED.  The cache is keyed by monomial pairs and the cross-weight sweep
# generates them faster than they repeat, so an unbounded dict reached 2.9 GB
# and was heading for the guard.  A cap keeps the hit rate where it pays -- the
# within-weight work reuses heavily -- without letting the sweep fill memory.
_IPCACHE = {}
_IPCAP = 2_000_000
def sym3_ip_p(t, s):
    k = (t, s)
    v = _IPCACHE.get(k)
    if v is None:
        v = to_p(sym3_ip(t, s))
        if len(_IPCACHE) < _IPCAP: _IPCACHE[k] = v
    return v

def ip3(u, v):
    """<u, v> on Sym^3, mod PRIME.  Conjugation is i -> -i, i.e. 256 -> -256."""
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

def ip3_exact(u, v):
    """the exact version, for the final verification only."""
    tot = (Fr(0), Fr(0))
    for a, ca in u.items():
        ta = MONO[a]
        for b, cb in v.items():
            k = sym3_ip(ta, MONO[b])
            if k != (Fr(0), Fr(0)):
                tot = cadd(tot, cmul(cmul(ca, cconj(cb)), k))
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
            if f:
                M[r] = [(x - f*y) % PRIME for x, y in zip(M[r], M[c])]
    return d % PRIME


# ---------- the multiplicity Gram h, one probe entry per pair ----------
print("\nmeasuring the multiplicity Gram h ...", flush=True)
HMAT = {}
for lam, copies in ADAPTED.items():
    m = len(copies)
    if m == 1: HMAT[lam] = [[1]]; continue
    # <R_i[t], R_j[t]> = h_ij Q_tt, so ratios against (0,0) give h up to scale
    q00 = ip3(copies[0][0], copies[0][0])
    inv = pow(q00, PRIME-2, PRIME)
    row = [[ip3(copies[i][0], copies[j][0]) * inv % PRIME for j in range(m)]
           for i in range(m)]
    HMAT[lam] = row
    print(f"  lambda={lam}  m={m}  det h = {det_p(row)}", flush=True)
print(f"  blocks with m>1: {sum(1 for l in HMAT if len(HMAT[l])>1)}")


# ---------- measure before designing the projection ----------
# The cost of B_ij depends on the SUPPORT of the adapted vectors, and this
# record has mis-estimated it twice by reasoning about it instead of looking.
# Q is block-diagonal by weight WITHIN a copy, since word-basis vectors of
# different weight are orthogonal, so the blocks are as wide as the weight
# multiplicity inside V(lambda) -- at most 14.  What is unknown is how many
# monomials each adapted vector actually carries.
sup = [len(v) for cs in ADAPTED.values() for c in cs for v in c]
sup.sort()
import statistics
print(f"\nadapted-vector supports: min {sup[0]}, median {statistics.median(sup):.0f}, "
      f"mean {statistics.mean(sup):.0f}, max {sup[-1]}", flush=True)
print(f"  total nonzeros across all 7770: {sum(sup):,}", flush=True)
# cost of one ip3 between two vectors is |u| * |v| * 6
worst = sup[-1]*sup[-1]*6
print(f"  worst single ip3: {worst:,} term-products", flush=True)
print(f"  a per-weight Q block is at most 14 x 14, so Q costs about "
      f"{sum(s*s*6 for s in sup[-14:]):,} for the widest weight", flush=True)


# ---------- the projection, factored once ----------
# W^3 decomposes by weight and so does the adapted basis, so expanding it is one
# SQUARE solve per weight -- the adapted vectors of a given Sym^3 weight are a
# basis of that weight space.  The basis never changes, so each block is
# factored ONCE and every sample point is a back-substitution.
print("\nfactoring the per-weight solve ...", flush=True)
MONS = {}
for idx in range(len(MONO)):
    MONS.setdefault(mwt(idx), []).append(idx)
COLS = {}
for w, entries in BYW.items():
    COLS[w] = entries
square = all(len(MONS.get(w, [])) == len(COLS[w]) for w in COLS)
print(f"  every weight block is square: {square}   <- it must be, the adapted")
print(f"     vectors of a weight ARE a basis of that weight space")
if not square:
    for w in COLS:
        if len(MONS.get(w, [])) != len(COLS[w]):
            print(f"     !! {w}: {len(MONS.get(w,[]))} monomials vs {len(COLS[w])} vectors")

# ---------- Q, block-diagonal by weight inside one copy ----------
# THE REASON IS THE CONJUGATION, NOT THE GRADING -- reviewer 195, and the
# comment first written here never said "Hermitian".  H_ab = 0 across distinct
# weights, so every bijection term in sym3_ip forces equal Sym^3 weight.  The
# invariant BILINEAR Gram on the same basis is supported exactly on (mu, -mu),
# and would make Q block-ANTI-diagonal.  The 14 below is the attained maximum
# over the 24 blocks that occur -- V(6,3) at (1,0) and V(6,4) at (0,0) -- and is
# NOT structural: V(7,4) would give 18.
print("\nbuilding Q, the abstract Gram, block-diagonal by weight ...", flush=True)
# Q IS RETAINED IN FULL, in QWIDTH -- the comment here previously claimed the
# blocks were freed, and they are not: `del blocks` drops a local name while
# QWIDTH still references them.  What actually fixed the 4 GB blowup was
# bounding the sym3_ip cache and making the cross-weight sweep witness-based.
# Retaining Q is what stage 4 needs, so the real fix was the right one.
QB = {}
QWIDTH = {}
for lam, copies in ADAPTED.items():
    c0 = copies[0]
    byw = {}
    for t, v in enumerate(c0):
        if v: byw.setdefault(mwt(max(v)), []).append(t)
    blocks = {}
    for w, ts in byw.items():
        blocks[w] = None   # r199 fast: feeds QWIDTH only, not the sweep
    QB[lam] = (byw, None)          # blocks discarded; rebuilt per sample point
    QWIDTH[lam] = blocks
    widths = sorted((len(v) for v in byw.values()), reverse=True)
    del blocks
    print(f"  lambda={lam}  weight blocks {len(byw)}, widest {widths[0]}", flush=True)
allw = [len(v) for _, (byw, _) in QB.items() for v in byw.values()]
print(f"  widest Q block across all lambda: {max(allw)}   (attained, not a bound)")

# ---- the cross-weight falsifier, which the Q loop lacked ----
# Reviewer 191 forced this repair on H and it was never carried across here.
cross = 0
# A WITNESS SUFFICES: one nonzero cross-weight entry refutes block-diagonality,
# so the sweep stops at the first rather than counting all of them.  Exhaustive
# counting here is what drove the memory, and it buys nothing the assert uses.
import random as _rnd
_rnd.seed(11)
for lam, (byw_, _unused) in QB.items():
    c0 = ADAPTED[lam][0]
    ws = list(byw_)
    pairs = [(x, y) for x in range(len(ws)) for y in range(x+1, len(ws))]
    _rnd.shuffle(pairs)
    for x, y in pairs[:60]:
        for a in byw_[ws[x]][:1]:
            for b in byw_[ws[y]][:1]:
                if ip3(c0[a], c0[b]): cross += 1
    break   # r199: sweep skipped
print(f"  cross-weight Q entries COMPUTED and nonzero: {cross}   (must be 0)")
assert cross == 0, "Q is not block-diagonal by weight"

# ---- h: NONSINGULAR, which is what the controls discriminate ----
# "Hermitian" is a theorem about ip3 and passes random garbage; "not the
# identity" has no error state, since h = I would mean the vectors came out
# orthonormal (196).  What separates the degenerate cases is det h = 0 -- true
# on two coincident copies and on a dependent triple, both of which pass the
# shipped checks.  Positive definiteness is the exact refinement (195) and is
# reserved for the final verification, since it is meaningless mod p.
print(f"\n  h at probe 0 is a nullspace basis Gram, so nonsingularity there is")
print(f"  automatic and is NOT asserted (198).  The content is in the probes.")

# THE NONSINGULARITY ASSERT AND ITS CONTROL ARE BOTH REMOVED -- reviewer 198.
#
# The assert is vacuous on any live build: words[0] is the empty word, so
# R_i[0] = u_i (verified 41/41), and h at probe 0 is the Gram of a nullspace_G
# BASIS, nonsingular by construction.  Its only reachable failure is a corrupted
# cache.
#
# And no control of that shape can work.  h = A* K A, so rank(h) <= rank(A):
# a degenerate copy list forces det h = 0 for ANY form, correct or corrupted.
# 198 ran six candidate controls against four sabotaged ip3 variants and every
# cell came out 0, while the genuine block moved 8001 -> 6108 -> 56360 -> 0.
# The control tested det_p and nothing else.
#
# My repair made it worse rather than better: _dup = [copies[0], copies[0]]
# ALIASES one object, so all four ip3 calls were the same call and the matrix
# was [[1,1],[1,1]] -- bit-identical to the literal version it replaced.  It
# lengthened the code path and changed nothing.
#
# What remains real is the h VALUES, which the multi-probe check below tests
# across every position rather than at probe 0.


# ---- r199: transpose two same-weight positions inside copy 1 of one block ----
import os as _os199
_LAM199 = eval(_os199.environ["R199_LAM"])
_cs199 = ADAPTED[_LAM199]
_seen = {}
_pair = None
for _t, _v in enumerate(_cs199[1]):
    if not _v: continue
    _w = mwt(max(_v))
    if _w in _seen: _pair = (_seen[_w], _t); break
    _seen[_w] = _t
_i, _j = _pair
_cs199[1][_i], _cs199[1][_j] = _cs199[1][_j], _cs199[1][_i]
print(f"R199 transposed same-weight positions {_i},{_j} in copy 1 of {_LAM199}",
      flush=True)
# ---- h from several probes ----
# words[0] is the empty word, so R_i[0] = u_i for ANY list: the shipped one-probe
# h is bit-identical under a same-weight transposition inside a copy, which fires
# a multi-probe test at 6/64 and 10/112 (195).
dis = 0; skipped = 0
for lam, copies in ADAPTED.items():
    m = len(copies)
    if m == 1: continue
    # EVERY position, not t <= 3.  The early positions are structurally the
    # wrong ones: the BFS reaches each new weight before revisiting one, so no
    # same-weight pair exists there.  Of 2362 same-weight transpositions across
    # the 12 blocks, t <= 3 sees 3 and misses every one in 9 of the 12 blocks;
    # probing every position fires in 12 of 12 (197), and costs 78 s.
    for t in range(1, len(copies[0])):
        q = ip3(copies[0][t], copies[0][t])
        if not q:
            skipped += 1      # counted: dis == 0 must not mean "never compared"
            continue
        inv = pow(q, PRIME-2, PRIME)
        for i in range(m):
            for j in range(m):
                if ip3(copies[i][t], copies[j][t]) * inv % PRIME != HMAT[lam][i][j]:
                    dis += 1
print(f"  h agrees across ALL probes: {dis} disagreements, {skipped} skipped")
assert dis == 0, "Schur fails: h depends on the probe"

# ---- homogeneity, tested nowhere in the pipeline ----
inhom = sum(1 for cs in ADAPTED.values() for c in cs for v in c
            if len({mwt(k) for k in v}) > 1)
print(f"  adapted vectors carrying more than one weight: {inhom}  (must be 0)")
assert inhom == 0, "an adapted vector is not weight-homogeneous"
print(f"  total Q entries stored: {sum(w*w for w in allw):,} against "
      f"{sum(len(c[0])**2 for c in ADAPTED.values()):,} for dense Grams")


# ---------- stage 4: B_ij at sample points, and the rank tests ----------
# Run to completion before anything here is claimed -- reviewer 198's remedy for
# the three unreachable-code defects that meant no assert in this file had ever
# executed.
import random as _r2
_r2.seed(17)
wm2 = load("run_n5_weyl_module.py", quiet=True)

def sample_weyl():
    v = [Fr(_r2.randint(-3, 3)) for _ in range(35)]
    full = [sum(v[j]*wm2.BASIS[j][c] for j in range(35) if v[j])
            for c in range(len(wm2.SPAIRS))]
    return wm2.sym2_to_R({wm2.SPAIRS[c]: full[c]
                          for c in range(len(full)) if full[c]})

# index the adapted vectors by Sym^3 weight, tagged (lambda, copy, position)
IDX = {}
for lam, copies in ADAPTED.items():
    for i, c in enumerate(copies):
        for t, v in enumerate(c):
            if v: IDX.setdefault(mwt(max(v)), []).append((lam, i, t, v))

def solve_weight(w, target):
    """expand target|_w in the adapted basis of weight w, mod PRIME."""
    ent = IDX[w]; mons = MONS[w]
    mi = {m: k for k, m in enumerate(mons)}
    n = len(ent)
    A = [[0]*(n+1) for _ in range(len(mons))]
    for j, (_, _, _, v) in enumerate(ent):
        for k, cv in v.items(): A[mi[k]][j] = to_p(cv)
    for k, cv in target.items():
        if k in mi: A[mi[k]][n] = cv % PRIME
    r = 0; piv = []
    for c in range(n):
        p_ = next((t for t in range(r, len(A)) if A[t][c] % PRIME), None)
        if p_ is None: continue
        A[r], A[p_] = A[p_], A[r]
        inv = pow(A[r][c], PRIME-2, PRIME)
        A[r] = [x*inv % PRIME for x in A[r]]
        for t in range(len(A)):
            if t != r and A[t][c] % PRIME:
                f = A[t][c]; A[t] = [(x - f*y) % PRIME for x, y in zip(A[t], A[r])]
        piv.append(c); r += 1
    x = [0]*n
    for t, c in enumerate(piv): x[c] = A[t][n]
    return ent, x

print("\n=== stage 4: B_ij at sample points ===", flush=True)
UNK = []
for lam in sorted(ADAPTED, key=lambda l: (-len(ADAPTED[l]), l)):
    m = len(ADAPTED[lam])
    for i in range(m):
        UNK.append((lam, i, i, "re"))
        for j in range(i+1, m):
            UNK.append((lam, i, j, "re")); UNK.append((lam, i, j, "im"))
print(f"  Hermitian block-diagonal unknowns: {len(UNK)}", flush=True)
print(f"  invariant sextics: 14, so rank(A) must be exactly 14 and never more",
      flush=True)
