"""The 41 highest-weight vectors of Sym^3(Weyl_5), exactly, over Q(i).

The record has carried the block table for several cycles with not one of these
vectors built.  They are what every downstream step needs: the certificate's
unknowns are Gram matrices on the multiplicity spaces, and a multiplicity space
IS the space of highest-weight vectors of its block.

Method: complexify, split Weyl_5 into the 35 joint eigenspaces of the Cartan
(H1, H2) = i(rho(A_01), rho(A_23)), find the two simple root vectors inside
so(5) (x) C by diagonalising the adjoint action, then for each block weight
lambda intersect the kernels of the two raising operators on the lambda-weight
space of Sym^3.  Nothing of dimension 7770 is ever inverted -- the largest
weight space is a couple of hundred.
"""
from fractions import Fraction as F
from itertools import combinations_with_replacement
import importlib.util, sys, os

spec = importlib.util.spec_from_file_location(
    "wm", os.path.join(os.path.dirname(__file__), "run_n5_weyl_module.py"))
wm = importlib.util.module_from_spec(spec)
_out = sys.stdout
sys.stdout = open(os.devnull, "w"); spec.loader.exec_module(wm); sys.stdout = _out
GENS, PAIRS, PIDX = wm.GENS, wm.PAIRS, wm.PIDX
print(f"loaded Weyl_5: dim {len(GENS[0])}, {len(GENS)} generators, Casimir 16 exact")

# ---------- Gaussian rationals ----------
class G:
    __slots__ = ("r", "i")
    def __init__(self, r=0, i=0): self.r = F(r); self.i = F(i)
    def __add__(s, o): o = mk(o); return G(s.r+o.r, s.i+o.i)
    def __radd__(s, o): return s + o
    def __sub__(s, o): o = mk(o); return G(s.r-o.r, s.i-o.i)
    def __rsub__(s, o): return mk(o) - s
    def __neg__(s): return G(-s.r, -s.i)
    def __mul__(s, o):
        o = mk(o); return G(s.r*o.r - s.i*o.i, s.r*o.i + s.i*o.r)
    def __rmul__(s, o): return s * o
    def __truediv__(s, o):
        o = mk(o); d = o.r*o.r + o.i*o.i
        return G((s.r*o.r + s.i*o.i)/d, (s.i*o.r - s.r*o.i)/d)
    def __bool__(s): return bool(s.r) or bool(s.i)
    def __eq__(s, o): o = mk(o); return s.r == o.r and s.i == o.i
    def __repr__(s): return f"({s.r}{'+' if s.i >= 0 else '-'}{abs(s.i)}i)"
def mk(x): return x if isinstance(x, G) else G(x)
ZERO, ONE, I = G(0), G(1), G(0, 1)

def nullspace_G(rows, n):
    M = [[mk(x) for x in r] for r in rows]; piv = []; r = 0
    for c in range(n):
        p = next((k for k in range(r, len(M)) if M[k][c]), None)
        if p is None: continue
        M[r], M[p] = M[p], M[r]
        inv = ONE / M[r][c]; M[r] = [x*inv for x in M[r]]
        for k in range(len(M)):
            if k != r and M[k][c]:
                f = M[k][c]; M[k] = [x - f*y for x, y in zip(M[k], M[r])]
        piv.append(c); r += 1
        if r == len(M): break
    out = []
    for f in [c for c in range(n) if c not in piv]:
        v = [ZERO]*n; v[f] = ONE
        for i2, c in enumerate(piv): v[c] = -M[i2][f]
        out.append(v)
    return out

DIM = len(GENS[0])
rho = lambda k: [[mk(x) for x in row] for row in GENS[k]]
def lin(coeffs):                       # complex combination of generators
    M = [[ZERO]*DIM for _ in range(DIM)]
    for k, c in coeffs.items():
        c = mk(c)
        for a in range(DIM):
            for b in range(DIM):
                if GENS[k][a][b]: M[a][b] = M[a][b] + c*GENS[k][a][b]
    return M
def apply(M, v): return [sum((M[a][b]*v[b] for b in range(DIM) if v[b]), ZERO)
                         for a in range(DIM)]

H1 = lin({PIDX[(0, 1)]: I})
H2 = lin({PIDX[(2, 3)]: I})
print("Cartan H1 = i.rho(A_01), H2 = i.rho(A_23)")

# ---------- joint weight decomposition of Weyl_5 ----------
def joint_eigenspace(w1, w2):
    rows = []
    for M, w in ((H1, w1), (H2, w2)):
        for a in range(DIM):
            rows.append([M[a][b] - (mk(w) if a == b else ZERO) for b in range(DIM)])
    return nullspace_G(rows, DIM)

WBASIS, WWT = [], []
for w1 in range(-2, 3):
    for w2 in range(-2, 3):
        for v in joint_eigenspace(w1, w2):
            WBASIS.append(v); WWT.append((w1, w2))
print(f"weight vectors of Weyl_5: {len(WBASIS)} (= 35: {len(WBASIS)==35})")
from collections import Counter
print(f"  weight multiplicities: {dict(sorted(Counter(WWT).items()))}")

# ---------- the two simple root vectors, found inside so(5) (x) C ----------
def ad_matrix(hp, hq):
    """ad(i A_hp,hq) on so(5) (x) C in the A_pq basis, as a 10x10 over Q(i)."""
    M = [[ZERO]*10 for _ in range(10)]
    for c, (r, s) in enumerate(PAIRS):
        for k, v in wm.bracket_in_so5(hp, hq, r, s).items():
            M[PIDX[k]][c] = M[PIDX[k]][c] + I*v
    return M

ADH1, ADH2 = ad_matrix(0, 1), ad_matrix(2, 3)
def root_vector(a1, a2):
    rows = []
    for M, w in ((ADH1, a1), (ADH2, a2)):
        for a in range(10):
            rows.append([M[a][b] - (mk(w) if a == b else ZERO) for b in range(10)])
    ns = nullspace_G(rows, 10)
    assert len(ns) == 1, (a1, a2, len(ns))
    return ns[0]

# simple roots of B_2: alpha_1 = e_1 - e_2, alpha_2 = e_2
RV1, RV2 = root_vector(1, -1), root_vector(0, 1)
E1 = lin({k: RV1[k] for k in range(10) if RV1[k]})
E2 = lin({k: RV2[k] for k in range(10) if RV2[k]})
print(f"\nsimple root vectors found: alpha_1 = (1,-1), alpha_2 = (0,1)")
# sanity: E1 raises the weight of a weight vector by alpha_1
hw = next(v for v, w in zip(WBASIS, WWT) if w == (2, 2))
print(f"  E1 kills the (2,2) vector: {not any(apply(E1, hw))}")
print(f"  E2 kills the (2,2) vector: {not any(apply(E2, hw))}")

# ---------- Sym^3, by weight ----------
E1W = [apply(E1, v) for v in WBASIS]      # images in the Weyl_5 coordinate basis
E2W = [apply(E2, v) for v in WBASIS]
# re-express in the WEIGHT basis: solve WBASIS x = image, once, via a shared solve
def to_weight_coords(vs):
    """express each vector of vs in the WBASIS basis (35 x 35 solve, done once)."""
    n = DIM; A = [[WBASIS[j][i] for j in range(n)] + [ZERO]*len(vs) for i in range(n)]
    for k, v in enumerate(vs):
        for i in range(n): A[i][n+k] = v[i]
    r = 0
    for c in range(n):
        p = next((k for k in range(r, n) if A[k][c]), None)
        A[r], A[p] = A[p], A[r]
        inv = ONE/A[r][c]; A[r] = [x*inv for x in A[r]]
        for k in range(n):
            if k != r and A[k][c]:
                f = A[k][c]; A[k] = [x - f*y for x, y in zip(A[k], A[r])]
        r += 1
    return [[A[i][n+k] for i in range(n)] for k in range(len(vs))]

E1C = to_weight_coords(E1W)
E2C = to_weight_coords(E2W)
ALPHA = [(1, -1), (0, 1)]
for E, name, a in ((E1C, "E1", ALPHA[0]), (E2C, "E2", ALPHA[1])):
    ok = all(not E[j][k] or (WWT[k][0] == WWT[j][0]+a[0] and WWT[k][1] == WWT[j][1]+a[1])
             for j in range(35) for k in range(35))
    print(f"  {name} shifts every weight by {a}: {ok}")

# ---------- highest-weight vectors, block by block ----------
import time
MONO = list(combinations_with_replacement(range(35), 3))
MW   = [tuple(WWT[a][k]+WWT[b][k]+WWT[c][k] for k in (0, 1)) for a, b, c in MONO]
BYW  = {}
for idx, w in enumerate(MW): BYW.setdefault(w, []).append(idx)
print(f"\nSym^3 monomials: {len(MONO)} (= 7770: {len(MONO)==7770})")
print(f"  largest weight space: {max(len(v) for v in BYW.values())}"
      f" at weight {max(BYW, key=lambda k: len(BYW[k]))}")

def raise_mono(idx, EC):
    """E applied to the monomial MONO[idx], as {monomial index: coeff}."""
    a, b, c = MONO[idx]; out = {}
    for pos, x in enumerate((a, b, c)):
        rest = [y for j, y in enumerate((a, b, c)) if j != pos]
        for t in range(35):
            v = EC[x][t]
            if v:
                key = tuple(sorted(rest + [t]))
                j = MIDX[key]; out[j] = out.get(j, ZERO) + v
    return {k: v for k, v in out.items() if v}
MIDX = {m: i for i, m in enumerate(MONO)}

BLOCKS = {(4,2):4, (2,2):4, (3,2):3,
          (5,2):2, (4,3):2, (4,4):2, (4,1):2, (3,1):2, (4,0):2, (2,1):2, (3,0):2, (2,0):2,
          (0,0):1, (1,0):1, (3,3):1, (5,0):1, (5,1):1, (5,3):1,
          (6,0):1, (5,4):1, (6,2):1, (6,3):1, (6,4):1, (6,6):1}

HW, t0 = {}, time.time()
for lam in sorted(BLOCKS, key=lambda l: -len(BYW.get(l, []))):
    cols = BYW.get(lam, [])
    if not cols:
        print(f"  lambda={lam}: EMPTY weight space", flush=True); continue
    rows = []
    for EC, a in ((E1C, ALPHA[0]), (E2C, ALPHA[1])):
        tgt = BYW.get((lam[0]+a[0], lam[1]+a[1]), [])
        tix = {m: k for k, m in enumerate(tgt)}
        blk = [[ZERO]*len(cols) for _ in range(len(tgt))]
        for j, m in enumerate(cols):
            for k, v in raise_mono(m, EC).items(): blk[tix[k]][j] = v
        rows.extend(blk)
    ns = nullspace_G(rows, len(cols))
    HW[lam] = (cols, ns)
    mark = "OK " if len(ns) == BLOCKS[lam] else "!! "
    print(f"  {mark}lambda={lam}: weight space {len(cols):3d}, "
          f"hw vectors {len(ns)} (table says {BLOCKS[lam]})  [{time.time()-t0:.0f}s]",
          flush=True)

tot = sum(len(v[1]) for v in HW.values())
print(f"\n=== {tot} highest-weight vectors built (table says 41: {tot==41}) ===")
print(f"    every block matches: {all(len(HW[l][1])==BLOCKS[l] for l in HW)}")

# ---------- independent check: the Sym^3 Casimir on each hw vector ----------
# A highest-weight vector of block lambda must satisfy C u = c_2(lambda) u with
# c_2 = lam1(lam1+3) + lam2(lam2+1).  This tests the vectors, the block labels
# and the recorded Casimir spectrum in one pass -- and it is a test the value 16
# alone cannot do, since an action failing the Lie relations still gave 16.
print("\n=== Sym^3 Casimir on each highest-weight vector ===")
GC = [to_weight_coords([apply(lin({k: ONE}), v) for v in WBASIS]) for k in range(10)]

def deriv(vec, M):
    """derivation of the weight-basis matrix M on a Sym^3 element {mono: coeff}."""
    out = {}
    for idx, co in vec.items():
        a, b, c = MONO[idx]
        for pos, x in enumerate((a, b, c)):
            rest = [y for j, y in enumerate((a, b, c)) if j != pos]
            for t in range(35):
                if M[x][t]:
                    j = MIDX[tuple(sorted(rest + [t]))]
                    out[j] = out.get(j, ZERO) + co*M[x][t]
    return {k: v for k, v in out.items() if v}

c2 = lambda l: l[0]*(l[0]+3) + l[1]*(l[1]+1)
bad = 0
for lam in sorted(HW):
    cols, ns = HW[lam]
    for v in ns:
        vec = {cols[j]: v[j] for j in range(len(cols)) if v[j]}
        acc = {}
        for M in GC:
            d2 = deriv(deriv(vec, M), M)
            for k, val in d2.items(): acc[k] = acc.get(k, ZERO) - val
        acc = {k: val for k, val in acc.items() if val}
        want = {k: mk(c2(lam))*val for k, val in vec.items()}
        want = {k: val for k, val in want.items() if val}   # c_2 = 0 on the trivial block
        if acc != want: bad += 1; print(f"  !! lambda={lam}: C u != {c2(lam)} u")
print(f"  all {sum(len(v[1]) for v in HW.values())} vectors satisfy "
      f"C u = c_2(lambda) u exactly: {bad == 0}")


# ---------- persist, so downstream stages stop re-deriving ----------
# Rebuilding this module costs two to three minutes and every stage of the
# certificate pipeline would pay it again.
import json
def _g(x): return [[x.r.numerator, x.r.denominator], [x.i.numerator, x.i.denominator]]
_cache = {
    "weights": [list(w) for w in WWT],
    "hw": {f"{l[0]},{l[1]}": {"cols": HW[l][0],
                              "vecs": [[_g(x) for x in v] for v in HW[l][1]]}
           for l in HW},
    "E1C": [[_g(x) for x in row] for row in E1C],
    "E2C": [[_g(x) for x in row] for row in E2C],
    # The weight basis as explicit rank-4 tensors.  Without these the cache
    # cannot be joined to the diagram side, which works with W as a tensor --
    # everything downstream needs both in ONE coordinate system.
    "wbasis_tensors": None,
}
_T = []
for _v in WBASIS:
    _full = [sum(_v[j]*wm.BASIS[j][c] for j in range(35) if _v[j])
             for c in range(len(wm.SPAIRS))]
    _R = wm.sym2_to_R({wm.SPAIRS[c]: _full[c] for c in range(len(_full)) if _full[c]})
    _T.append([[[[ _g(mk(_R[a][b][c][d])) for d in range(5)]
                 for c in range(5)] for b in range(5)] for a in range(5)])
_cache["wbasis_tensors"] = _T
_p = os.path.join(os.path.dirname(os.path.abspath(__file__)), "n5_hw_cache.json")
# ATOMIC WRITE.  This file is rewritten on every import, and a second process
# importing it mid-write reads a truncated file: reviewer 202 hit a
# JSONDecodeError here with reviewer 201 running concurrently.  Writing to a
# per-process temporary and renaming makes the swap atomic, so a concurrent
# reader sees either the old file or the new one.  run_n5_adapted.py already
# argues this for its pickle, crediting 198; the JSON cache was left behind.
_tmp = f"{_p}.{os.getpid()}.tmp"
with open(_tmp, "w") as _f: json.dump(_cache, _f)
os.replace(_tmp, _p)
print(f"\ncached to {os.path.basename(_p)}: "
      f"{sum(len(v['vecs']) for v in _cache['hw'].values())} hw vectors, "
      f"{len(_cache['weights'])} weight labels")
