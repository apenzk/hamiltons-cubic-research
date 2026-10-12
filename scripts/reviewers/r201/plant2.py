"""r201 v2: sabotage plants, reporting BOTH whether the Hermitian assert fires
and whether the resulting h still equals the exact Q(i) truth reduced mod p."""
import sys, os, time, pickle
from fractions import Fraction as F

SRC = "scripts/runs/run_n5_assemble.py"
S = ("/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/"
     "ea3d63f3-07ce-4bf2-a0fb-4a245ad3dc41/scratchpad/")
CUT = 251
LINES = open(SRC).read().split("\n")
HEAD = "\n".join(LINES[:CUT])
assert "blocks with m>1" in LINES[CUT-1]
MARK = 'print("\\nmeasuring the multiplicity Gram h ...", flush=True)'
P = 1000033
EX = {k: [[(F(a), F(b)) for (a, b) in r] for r in v]
      for k, v in pickle.load(open(S+"r201_h_exact.pkl","rb")).items()}
def red(x): return x.numerator * pow(x.denominator % P, P-2, P) % P
TRUTH = {k: [[(red(e[0]), red(e[1])) for e in r] for r in v] for k, v in EX.items()}

def run(name, subs=(), inject=None):
    src = HEAD
    for old, new in subs:
        assert old in src, f"{name}: pattern absent"
        src = src.replace(old, new)
    if inject: src = src.replace(MARK, inject + "\n" + MARK)
    g = {"__name__": "__main__", "__file__": SRC}
    out = sys.stdout; sys.stdout = open(os.devnull, "w"); t = time.time(); err = None
    try: exec(compile(src, SRC, "exec"), g)
    except AssertionError as e: err = ("AssertionError", str(e)[:90])
    except Exception as e: err = (type(e).__name__, str(e)[:90])
    sys.stdout = out
    v = "FIRES" if err and err[0] == "AssertionError" else ("CRASH " + err[0] if err else "passes")
    extra = ""
    if not err:
        H = g["HMAT"]
        bad = sum(1 for k in TRUTH for i in range(len(TRUTH[k]))
                  for j in range(len(TRUTH[k])) if tuple(H[k][i][j]) != TRUTH[k][i][j])
        off = {k: sum(1 for i in range(len(H[k])) for j in range(len(H[k]))
                      if i != j and H[k][i][j][1]) for k in TRUTH}
        extra = (f" | h vs exact truth: {bad}/77 entries wrong"
                 f" | complex off-diags {sum(off.values())} (truth 18)")
    print(f"[{name:30s}] {v:16s} [{time.time()-t:.0f}s]{extra}  {err[1] if err else ''}", flush=True)

W = sys.argv[1]
GPMUL = "return ((u[0]*v[0] - u[1]*v[1]) % PRIME, (u[0]*v[1] + u[1]*v[0]) % PRIME)"
GPBODY = """    return (a.numerator * pow(a.denominator % PRIME, PRIME-2, PRIME) % PRIME,
            b.numerator * pow(b.denominator % PRIME, PRIME-2, PRIME) % PRIME)"""

if W == "a":
    run("S0 baseline")
    run("S1 gpmul: i^2 = +1", [(GPMUL, "return ((u[0]*v[0] + u[1]*v[1]) % PRIME, (u[0]*v[1] + u[1]*v[0]) % PRIME)")])
    run("S2 gpconj = identity", [("def gpconj(u):   return (u[0], (-u[1]) % PRIME)",
                                  "def gpconj(u):   return (u[0], u[1])")])
    run("S3 ip3_g drops the conj", [("gpmul(gpmul(cap, gpconj(gp(cb))), k)",
                                     "gpmul(gpmul(cap, gp(cb)), k)")])
if W == "b":
    run("S4 r200 collapse: gp folds i", [(GPBODY,
        """    return ((a.numerator * pow(a.denominator % PRIME, PRIME-2, PRIME)
             + b.numerator * pow(b.denominator % PRIME, PRIME-2, PRIME) * IMOD) % PRIME, 0)""")])
    run("S5 gpmul non-commutative", [(GPMUL, "return ((u[0]*v[0] - u[1]*v[1]) % PRIME, (u[0]*v[1] - u[1]*v[0]) % PRIME)")])
    run("S6 gpconj negates re", [("def gpconj(u):   return (u[0], (-u[1]) % PRIME)",
                                  "def gpconj(u):   return ((-u[0]) % PRIME, u[1])")])
    run("S7 gp swaps re and im", [(GPBODY,
        """    return (b.numerator * pow(b.denominator % PRIME, PRIME-2, PRIME) % PRIME,
            a.numerator * pow(a.denominator % PRIME, PRIME-2, PRIME) % PRIME)""")])
if W == "c":
    run("D1 random vector in a copy", inject="""
import random as _r
_r.seed(201)
_c = ADAPTED[(2,0)][1][0]
for _k in list(_c): _c[_k] = type(_c[_k])(F(_r.randint(-9,9)), F(_r.randint(-9,9)))
""")
    run("D2 copies coincident (2,0)", inject="ADAPTED[(2,0)][1] = [dict(v) for v in ADAPTED[(2,0)][0]]")
    run("D3 probe scaled by PRIME", inject="""
_c = ADAPTED[(2,0)][0][0]
for _k in list(_c): _c[_k] = type(_c[_k])(_c[_k].r * PRIME, _c[_k].i * PRIME)
""")
    run("D4 positions rotated, all copies", inject="""
_pp = list(range(len(ADAPTED[(2,0)][0]))); _pp = _pp[7:] + _pp[:7]
for _i in range(len(ADAPTED[(2,0)])):
    _old = ADAPTED[(2,0)][_i]; ADAPTED[(2,0)][_i] = [_old[_j] for _j in _pp]
""")
