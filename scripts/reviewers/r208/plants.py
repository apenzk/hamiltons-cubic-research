"""r208, claim 6: sabotage plants against the r203/r204 repairs in ec35c0b.

(A) the new gpadd / gpconj round-trip asserts in run_n5_assemble.py -- do the
    three gpadd sabotages that r204 got past every check now fire?
(B) the rewritten step-(b) rank computation in run_n5_order2.py -- what fires it
    and, more to the point, WHAT DOES NOT.
"""
import importlib.util, os, sys, random
from fractions import Fraction as F

PRIME = 2_147_483_647
def gp_ok(x):
    def m(q):
        q = F(q); return (q.numerator % PRIME)*pow(q.denominator % PRIME, PRIME-2, PRIME) % PRIME
    return (m(x[0]), m(x[1]))
def gpmul_ok(u, v):
    return ((u[0]*v[0] - u[1]*v[1]) % PRIME, (u[0]*v[1] + u[1]*v[0]) % PRIME)
def gpadd_ok(u, v): return ((u[0]+v[0]) % PRIME, (u[1]+v[1]) % PRIME)
def gpconj_ok(u): return (u[0], (-u[1]) % PRIME)

_SAMPLE = [((F(1), F(2)), (F(3), F(-5))), ((F(-7, 3), F(4)), (F(0), F(11, 2))),
           ((F(5, 8), F(-1, 6)), (F(2, 9), F(7, 4)))]
def _cmul(x, y): return (x[0]*y[0] - x[1]*y[1], x[0]*y[1] + x[1]*y[0])
def _cadd(x, y): return (x[0]+y[0], x[1]+y[1])

def checks(gp, gpmul, gpadd, gpconj):
    """the shipped battery, in file order; returns the first check that fires."""
    if gpmul((0, 1), (0, 1)) != (PRIME-1, 0): return "i^2 == -1"
    if not (gp((F(1), F(0))) == (1, 0) and gp((F(0), F(1))) == (0, 1)): return "gp slots"
    if not all(gpmul(gp(x), gp(y)) == gp(_cmul(x, y)) for x, y in _SAMPLE): return "gpmul ring map"
    if not all(gpadd(gp(x), gp(y)) == gp(_cadd(x, y)) for x, y in _SAMPLE): return "gpadd additive (NEW)"
    if not all(gpconj(gp(x)) == gp((x[0], -x[1])) for x, _ in _SAMPLE): return "gpconj (NEW)"
    return None

print("=== (A) plants against the NEW gpadd / gpconj asserts ===\n")
SABOTAGES = [
    ("control (unsabotaged)",          gp_ok, gpmul_ok, gpadd_ok, gpconj_ok),
    ("204 new-d   gpadd subtracts im", gp_ok, gpmul_ok,
     lambda u, v: ((u[0]+v[0]) % PRIME, (u[1]-v[1]) % PRIME), gpconj_ok),
    ("204 new-d2  gpadd DROPS v's im", gp_ok, gpmul_ok,
     lambda u, v: ((u[0]+v[0]) % PRIME, u[1] % PRIME), gpconj_ok),
    ("204 new-d3  gpadd doubles v's im", gp_ok, gpmul_ok,
     lambda u, v: ((u[0]+v[0]) % PRIME, (u[1]+2*v[1]) % PRIME), gpconj_ok),
    ("204 new-e   gpconj is identity", gp_ok, gpmul_ok, gpadd_ok, lambda u: u),
    ("r208 new-f  gpconj negates re",  gp_ok, gpmul_ok, gpadd_ok,
     lambda u: ((-u[0]) % PRIME, (-u[1]) % PRIME)),
    ("r208 new-g  gpadd swaps re/im",  gp_ok, gpmul_ok,
     lambda u, v: ((u[1]+v[1]) % PRIME, (u[0]+v[0]) % PRIME), gpconj_ok),
    ("r208 new-h  gpadd scales by 2",  gp_ok, gpmul_ok,
     lambda u, v: ((2*(u[0]+v[0])) % PRIME, (2*(u[1]+v[1])) % PRIME), gpconj_ok),
]
for name, a, b, c, d in SABOTAGES:
    r = checks(a, b, c, d)
    print(f"  {name:36s} -> {'PASSES ALL (hole)' if r is None else 'caught by ' + r}")

print("\n=== (B) plants against step (b) of run_n5_order2.py ===\n")
RUNS = "scripts/runs"
def load(n):
    sp = importlib.util.spec_from_file_location(n[:-3], os.path.join(RUNS, n))
    m = importlib.util.module_from_spec(sp); o = sys.stdout
    sys.stdout = open(os.devnull, "w")
    try: sp.loader.exec_module(m)
    finally: sys.stdout.close(); sys.stdout = o
    return m
wm, ex = load("run_n5_weyl_module.py"), load("run_n5_extremiser.py")
NP, S0 = wm.NP, ex.S

def _rank(rows, ncols):
    rows = [r[:] for r in rows]; r = 0
    for c in range(ncols):
        pv = next((t for t in range(r, len(rows)) if rows[t][c]), None)
        if pv is None: continue
        rows[r], rows[pv] = rows[pv], rows[r]
        p = rows[r][c]; rows[r] = [x/p for x in rows[r]]
        for t in range(len(rows)):
            if t != r and rows[t][c]:
                f0 = rows[t][c]; rows[t] = [x - f0*y for x, y in zip(rows[t], rows[r])]
        r += 1
    return r
def _kernel(rows, ncols):
    rows = [r[:] for r in rows]; piv = []; r = 0
    for c in range(ncols):
        pv = next((t for t in range(r, len(rows)) if rows[t][c]), None)
        if pv is None: continue
        rows[r], rows[pv] = rows[pv], rows[r]
        p = rows[r][c]; rows[r] = [x/p for x in rows[r]]
        for t in range(len(rows)):
            if t != r and rows[t][c]:
                f0 = rows[t][c]; rows[t] = [x - f0*y for x, y in zip(rows[t], rows[r])]
        piv.append(c); r += 1
    out = []
    for fc in [c for c in range(ncols) if c not in piv]:
        v = [F(0)]*ncols; v[fc] = F(1)
        for t, c in enumerate(piv): v[c] = -rows[t][fc]
        out.append(v)
    return out

def coords_of(Smat):
    flat = {(i, j): Smat[i][j] for i in range(NP) for j in range(i, NP)}
    return wm.coords([flat.get((a, b), F(0)) for a, b in wm.SPAIRS])

def stepb(Smat, GENS):
    w0 = coords_of(Smat)
    if not any(w0): return ("W_0 zero in weight basis", None)
    M = [[sum(G[i][k]*w0[k] for k in range(35)) for i in range(35)] for G in GENS]
    dim_h = len(GENS) - _rank(M, 35)
    hb = _kernel([[M[a][i] for a in range(len(GENS))] for i in range(35)], len(GENS))
    rows = []
    for coef in hb:
        rows.extend([[sum(coef[a]*GENS[a][i][k] for a in range(len(GENS)))
                      for k in range(35)] for i in range(35)])
    return dim_h, 35 - _rank(rows, 35)

def report(name, Smat=None, GENS=None):
    d, f = stepb(S0 if Smat is None else Smat, wm.GENS if GENS is None else GENS)
    fires = [] if d == 4 else ["dim Stab != 4"]
    if f != 1: fires.append("dim (Weyl_5)^h != 1")
    print(f"  {name:44s} dim Stab={d}, dim V^h={f}   "
          f"{'PASSES (no assert fires)' if not fires else 'FIRES: ' + ', '.join(fires)}")

report("control: the shipped W_0")
bad = [[S0[i][j] + (F(1) if (i, j) == (0, 0) else 0) for j in range(NP)] for i in range(NP)]
report("W_0 with one entry corrupted by 1")
bad2 = [[S0[i][j] + (F(1,1000) if (i, j) in ((0,0),) else 0) for j in range(NP)] for i in range(NP)]
report("W_0 with one entry corrupted by 1/1000", bad2)
report("W_0 scaled by 7 (same direction)", [[7*x for x in r] for r in S0])
random.seed(208)
rnd = [[F(random.randint(-5, 5)) for _ in range(NP)] for _ in range(NP)]
rnd = [[rnd[i][j] + rnd[j][i] for j in range(NP)] for i in range(NP)]
report("a random symmetric 10x10 (not in Weyl_5)", rnd)
report("W_0 with one entry corrupted by 1 (explicit)", bad)
NEG = [([[-v for v in row] for row in G] if a == 3 else G) for a, G in enumerate(wm.GENS)]
report("GENS with generator 3 NEGATED (r177's break)", None, NEG)
SCL = [([[7*v for v in row] for row in G] if a == 3 else G) for a, G in enumerate(wm.GENS)]
report("GENS with generator 3 SCALED by 7", None, SCL)
SWP = list(wm.GENS); SWP[2], SWP[5] = SWP[5], SWP[2]
report("GENS with two generators SWAPPED", None, SWP)

print("\n=== (B2) the corruption sweep the commit message claims ===\n")
# "Perturbing one entry of W_0 fires it".  coords() reads only the 35 FREE
# columns of the 55, so 20 of the 55 entries of W_0 are invisible to the test
# object altogether.  Sweep the 35 that are not.
w0_ok = coords_of(S0)
eff, fired = 0, 0
for k, (a, b) in enumerate(wm.SPAIRS):
    bad = [row[:] for row in S0]
    bad[a][b] += F(1)
    if a != b: bad[b][a] += F(1)
    if coords_of(bad) == w0_ok: continue
    eff += 1
    d, f = stepb(bad, wm.GENS)
    if d != 4 or f != 1: fired += 1
print(f"  {len(wm.SPAIRS)} entries of W_0; {len(wm.SPAIRS)-eff} are INVISIBLE to")
print(f"  coords(), which reads only the 35 free columns of the 55.")
print(f"  of the {eff} that do change the tested vector, {fired} fire an assert"
      f" ({eff-fired} pass).")
