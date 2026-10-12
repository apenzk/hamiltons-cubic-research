"""r201: sabotage plants against run_n5_assemble.py's Hermitian assert.

The REAL source is executed, truncated after the HMAT block (line 251), with a
textual substitution standing in for the corruption.  The file on disk is never
edited.
"""
import sys, os, time, traceback, pickle
from fractions import Fraction as F

SRC = "scripts/runs/run_n5_assemble.py"
CUT = 251
LINES = open(SRC).read().split("\n")
HEAD = "\n".join(LINES[:CUT])
assert "blocks with m>1" in LINES[CUT-1], LINES[CUT-1]

MARK = 'print("\\nmeasuring the multiplicity Gram h ...", flush=True)'
assert MARK in HEAD

def run(name, subs=(), inject=None):
    src = HEAD
    for old, new in subs:
        assert old in src, f"{name}: pattern absent: {old!r}"
        src = src.replace(old, new)
    if inject:
        src = src.replace(MARK, inject + "\n" + MARK)
    g = {"__name__": "__main__", "__file__": SRC}
    out = sys.stdout; sys.stdout = open(os.devnull, "w")
    t = time.time(); err = None
    try:
        exec(compile(src, SRC, "exec"), g)
    except AssertionError as e:
        err = ("AssertionError", str(e)[:120])
    except Exception as e:
        err = (type(e).__name__, str(e)[:120])
    sys.stdout = out
    verdict = "FIRES" if err and err[0] == "AssertionError" else \
              ("CRASH " + err[0] if err else "passes")
    print(f"[{name:28s}] {verdict:22s} [{time.time()-t:.0f}s] {err[1] if err else ''}",
          flush=True)
    return g, err

WHICH = sys.argv[1] if len(sys.argv) > 1 else "all"

if WHICH in ("all", "base"):
    g, _ = run("S0 baseline")
    pickle.dump({k: v for k, v in g["HMAT"].items()},
                open("/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/"
                     "ea3d63f3-07ce-4bf2-a0fb-4a245ad3dc41/scratchpad/r201_hmat_p.pkl", "wb"))
    print("   PRIME =", g["PRIME"], " IMOD =", g["IMOD"])

if WHICH in ("all", "arith"):
    run("S1 gpmul sign of i^2",
        [("return ((u[0]*v[0] - u[1]*v[1]) % PRIME, (u[0]*v[1] + u[1]*v[0]) % PRIME)",
          "return ((u[0]*v[0] + u[1]*v[1]) % PRIME, (u[0]*v[1] + u[1]*v[0]) % PRIME)")])
    run("S2 gpconj = identity",
        [("def gpconj(u):   return (u[0], (-u[1]) % PRIME)",
          "def gpconj(u):   return (u[0], u[1])")])
    run("S3 ip3_g drops the conj",
        [("gpmul(gpmul(cap, gpconj(gp(cb))), k)", "gpmul(gpmul(cap, gp(cb)), k)")])
    run("S4 r200 collapse: gp folds i",
        [("""    return (a.numerator * pow(a.denominator % PRIME, PRIME-2, PRIME) % PRIME,
            b.numerator * pow(b.denominator % PRIME, PRIME-2, PRIME) % PRIME)""",
          """    return ((a.numerator * pow(a.denominator % PRIME, PRIME-2, PRIME)
             + b.numerator * pow(b.denominator % PRIME, PRIME-2, PRIME) * IMOD) % PRIME, 0)""")])
    run("S5 gpmul commutes re/im",
        [("return ((u[0]*v[0] - u[1]*v[1]) % PRIME, (u[0]*v[1] + u[1]*v[0]) % PRIME)",
          "return ((u[0]*v[0] - u[1]*v[1]) % PRIME, (u[0]*v[1] - u[1]*v[0]) % PRIME)")])

if WHICH in ("all", "data"):
    # D1: copy 1 of (2,0) replaced by a pseudo-random Gaussian vector
    run("D1 random vector in a copy", inject="""
import random as _r
_r.seed(201)
_c = ADAPTED[(2,0)][1][0]
for _k in list(_c):
    _c[_k] = type(_c[_k])(F(_r.randint(-9,9)), F(_r.randint(-9,9)))
""")
    # D2: the two copies of (2,0) made coincident
    run("D2 copies made coincident", inject="""
ADAPTED[(2,0)][1] = [dict(v) for v in ADAPTED[(2,0)][0]]
""")
    # D3: copy 0's probe vector scaled by PRIME -> q00 = 0 mod p, inv = 0
    run("D3 probe scaled by the prime", inject="""
_c = ADAPTED[(2,0)][0][0]
for _k in list(_c):
    _c[_k] = type(_c[_k])(_c[_k].r * PRIME, _c[_k].i * PRIME)
""")
    # D4: a whole block's word list permuted in EVERY copy (199's blind spot (a))
    run("D4 word list permuted, all copies", inject="""
_p = list(range(len(ADAPTED[(2,0)][0])))
_p = _p[7:] + _p[:7]
for _i in range(len(ADAPTED[(2,0)])):
    _old = ADAPTED[(2,0)][_i]
    ADAPTED[(2,0)][_i] = [_old[_j] for _j in _p]
""")
