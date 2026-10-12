"""r184, claim 5 gap: run_n5_copies.py checks each copy's DIMENSION but never
that the copies of one lambda are independent.  They are iff the highest-weight
vectors of that lambda are independent (h.w. vectors of V_lambda (x) Mult sit in
1-1 correspondence with Mult, and V_lambda (x) m1, V_lambda (x) m2 meet in 0 for
independent m1, m2).  So: rank the h.w. vectors, per lambda, exactly over Q."""
from fractions import Fraction as F
import importlib.util, sys, os
d = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
spec = importlib.util.spec_from_file_location("hw", os.path.join(d, "run_n5_highest_weight.py"))
hw = importlib.util.module_from_spec(spec)
o = sys.stdout; sys.stdout = open(os.devnull, "w"); spec.loader.exec_module(hw); sys.stdout = o
HW = hw.HW

def rank(vs):
    ONE = hw.ONE
    M = [list(v) for v in vs]; r = 0; n = len(M[0])
    for c in range(n):
        p = next((k for k in range(r, len(M)) if M[k][c]), None)
        if p is None: continue
        M[r], M[p] = M[p], M[r]
        inv = ONE/M[r][c]; M[r] = [x*inv for x in M[r]]
        for k in range(len(M)):
            if k != r and M[k][c]:
                f = M[k][c]; M[k] = [x - f*y for x, y in zip(M[k], M[r])]
        r += 1
        if r == len(M): break
    return r

SAGE = {(0,0):1,(1,0):1,(2,0):2,(3,0):2,(2,2):4,(2,1):2,(4,0):2,(3,1):2,(3,3):1,
        (5,0):1,(3,2):3,(6,0):1,(4,1):2,(4,4):2,(4,2):4,(4,3):2,(5,1):1,(5,2):2,
        (5,4):1,(6,6):1,(5,3):1,(6,2):1,(6,3):1,(6,4):1}
bad, tot = [], 0
for lam, (cols, ns) in sorted(HW.items()):
    r = rank(ns); tot += len(ns)
    if r != len(ns) or SAGE.get(lam) != len(ns): bad.append((lam, len(ns), r, SAGE.get(lam)))
print(f"blocks {len(HW)}, h.w. vectors {tot}")
print(f"every lambda: #hw vectors independent AND equal to Sage's multiplicity: {not bad}")
if bad: print("  offenders (lambda, #hw, rank, sage mult):", bad)
