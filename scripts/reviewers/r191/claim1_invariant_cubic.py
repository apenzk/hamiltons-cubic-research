"""Which pairing makes the trivial block's cubic SO(5)-invariant?

Two objects get called P_1 in the record:

  A(W) = sum_t u[t] * w_{t1} w_{t2} w_{t3}            (evaluate u at the
                                                       coordinates w = coords(W))
  B(W) = sum_t conj(u[t]) * r_{t1} r_{t2} r_{t3}      (evaluate conj(u) at the
                                                       DUAL coordinates r = H^T w,
                                                       which is <W^3,u> / 3! by
                                                       the apolarity identity)

They differ, because passing from w to r = H^T w is the metric identification
V -> V*, and the weight basis is NOT orthonormal (H has diagonal 12..96).  Only
one of them can be the invariant, and invariance is testable exactly:
a cubic is invariant iff its derivative along X.W vanishes for every X in the
(complexified) algebra, and in coordinates X.w has components sum_a w_a X[a][t].

This is the test reviewer 190 named -- "the trivial block's P_1 must be an
SO(5)-INVARIANT cubic" -- run against both readings rather than one.
"""
import sys, os, random
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from common import *
from lowering import H, FS, Hm

hw0 = C["hw"]["0,0"]
cols = hw0["cols"]
u = {cols[i]: gq(v) for i, v in enumerate(hw0["vecs"][0]) if gq(v) != Z}

def act(X, w):
    """(X.w)_t = sum_a w_a X[a][t], X stored as [input][output]."""
    out = [Z]*35
    for a in range(35):
        if w[a] == Z: continue
        Xa = X[a]
        for t in range(35):
            if Xa[t] != Z: out[t] = cadd(out[t], cmul(w[a], Xa[t]))
    return out

def leftH(w):                       # r = H^T w,  r[b] = sum_a w_a H[a][b]
    out = [Z]*35
    for a in range(35):
        if w[a] == Z: continue
        for b in range(35):
            if Hm[a][b] != Z: out[b] = cadd(out[b], cmul(w[a], Hm[a][b]))
    return out

def cubic(coef, z):
    tot = Z
    for i, c in coef.items():
        v = c
        for a in MONO[i]: v = cmul(v, z[a])
        tot = cadd(tot, v)
    return tot

def dcubic(coef, z, dz):
    tot = Z
    for i, c in coef.items():
        t = MONO[i]
        for k in range(3):
            v = c
            for j in range(3): v = cmul(v, dz[t[j]] if j == k else z[t[j]])
            tot = cadd(tot, v)
    return tot

ubar = {i: cconj(c) for i, c in u.items()}
random.seed(4191)
ops = {"E1": EC[1], "E2": EC[2], "F1": FS[1], "F2": FS[2]}

print("=== infinitesimal invariance of the two candidate trivial-block cubics ===")
for trial in range(3):
    w = [(F(random.randint(-5, 5), random.randint(1, 3)),
          F(random.randint(-5, 5), random.randint(1, 3))) for _ in range(35)]
    r = leftH(w)
    line = {}
    for nm, X in ops.items():
        dw = act(X, w); dr = leftH(dw)
        line[nm] = (dcubic(u, w, dw), dcubic(ubar, r, dr))
    okA = all(v[0] == Z for v in line.values())
    okB = all(v[1] == Z for v in line.values())
    print(f"  trial {trial}:  A (u evaluated at w) invariant: {okA}   "
          f"B (conj u at H^T w) invariant: {okB}")
    if not okA:
        nm = next(n for n in line if line[n][0] != Z)
        print(f"     witness for A: d/dX along {nm} = "
              f"({line[nm][0][0]}) + ({line[nm][0][1]})i   (nonzero)")
    if not okB:
        nm = next(n for n in line if line[n][1] != Z)
        print(f"     witness for B: d/dX along {nm} = "
              f"({line[nm][1][0]}) + ({line[nm][1][1]})i   (nonzero)")

# --- and the constant: B is a multiple of the unique invariant cubic ---
print("\n=== ratio B(W)/A(W) across samples (constant only if both invariant) ===")
vals = []
for trial in range(4):
    w = [(F(random.randint(-5, 5), random.randint(1, 3)), F(0)) for _ in range(35)]
    r = leftH(w)
    a, b = cubic(u, w), cubic(ubar, r)
    if a != Z: vals.append(cdiv(b, a))
print(f"  {len(set(vals))} distinct ratios over {len(vals)} samples")

# ---------------------------------------------------------------------------
# The four readings, side by side, and the one the record actually uses.
# r190's `omegas(W)` is the plain contraction sum_{ijkl} f_a W = conj(<W,f_a>),
# so its P_i is  conj(B)  -- the dual-coordinate reading, not the coords() one.
print("\n=== the four readings ===")
import itertools as _it
def invariant(coef, dual):
    for _ in range(2):
        w = [(F(random.randint(-5, 5), random.randint(1, 3)),
              F(random.randint(-5, 5), random.randint(1, 3))) for _ in range(35)]
        z = leftH(w) if dual else w
        for X in ops.values():
            dw = act(X, w); dz = leftH(dw) if dual else dw
            if dcubic(coef, z, dz) != Z: return False
    return True
for cname, coef in (("u", u), ("conj u", ubar)):
    for dname, dual in (("w = coords(W)", False), ("r = H^T w = <W,f_a>", True)):
        print(f"  {cname:7s} evaluated at {dname:22s}: invariant = {invariant(coef, dual)}")

# ---------------------------------------------------------------------------
# The scale, made concrete on the trivial block.
print("\n=== the 3! in sym3_ip, made observable ===")
def sym3_ip(t, s):
    tot = Z
    for perm in _it.permutations(range(3)):
        term = ONE; ok = True
        for i in range(3):
            e = H.get((t[i], s[perm[i]]))
            if e is None: ok = False; break
            term = cmul(term, e)
        if ok: tot = cadd(tot, term)
    return tot
uu = Z
for i, ci in u.items():
    for j, cj in u.items():
        m = sym3_ip(MONO[i], MONO[j])
        if m != Z: uu = cadd(uu, cmul(ci, cmul(cconj(cj), m)))
print(f"  <u,u>_sym3_ip = {uu[0]}      <u,u>_induced = {uu[0]/6}")
random.seed(77)
for trial in range(3):
    w = [(F(random.randint(-5, 5), random.randint(1, 3)), F(0)) for _ in range(35)]
    r = leftH(w)
    P1 = cubic(ubar, r)                      # = conj(r190's P_1)
    q = {}
    for i in [k for k, m in enumerate(MW) if m == (0, 0)]:
        t = MONO[i]; z = (F(multinom(t)), F(0))
        for a in t: z = cmul(z, w[a])
        if z != Z: q[i] = z
    ip = Z
    for i, qt in q.items():
        for j, cs in u.items():
            m = sym3_ip(MONO[i], MONO[j])
            if m != Z: ip = cadd(ip, cmul(qt, cmul(cconj(cs), m)))
    B11 = cdiv(cmul(ip, cconj(ip)), uu)
    P1sq = cmul(P1, cconj(P1))
    print(f"  trial {trial}: <W^3,u>_sym3_ip / P_1 = {cdiv(ip, P1)}    "
          f"B_11/|P_1|^2 = {cdiv(B11, P1sq)}   ( = 3!/<u,u>_induced )")
