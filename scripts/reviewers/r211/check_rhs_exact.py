"""r211, claim 1/2: an EXACT known answer the lift must reproduce.

The right-hand sides of the affine system are F_5 at the 40 sample points.  They
travel through the same mod-p CRT + rational-reconstruction pipeline as the rows,
but unlike the rows their true rational values can be recomputed from scratch in
seconds: the samples are integer Weyl tensors drawn from a fixed seed, and
F_5 = (3/2)|W|^6 - 9 tr(W^3)^2 is a direct tensor contraction.

So: recompute F_5 over Q, and compare against the LIFTED rationals.  A lift that
reconstructed a wrong small rational anywhere in the rhs is caught here outright.
The same values also probe the pipeline's own F_5 evaluator mod p.
"""
import importlib.util, sys, os, json, glob, pickle
from fractions import Fraction as F

RD = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
RD = os.path.abspath(RD)
sp = importlib.util.spec_from_file_location("wm", os.path.join(RD, "run_n5_weyl_module.py"))
wm = importlib.util.module_from_spec(sp)
_o = sys.stdout; sys.stdout = open(os.devnull, "w"); sp.loader.exec_module(wm); sys.stdout = _o

import random
random.seed(20260829)
def rand_weyl_tensor():
    v = [F(random.randint(-4, 4)) for _ in range(35)]
    full = [sum(v[j]*wm.BASIS[j][c] for j in range(35) if v[j])
            for c in range(len(wm.SPAIRS))]
    return wm.sym2_to_R({wm.SPAIRS[c]: full[c] for c in range(len(full)) if full[c]})

rand_weyl_tensor()                      # the _probe draw, consumed before the loop
SAMPT = [rand_weyl_tensor() for _ in range(40)]

def F5_exact(Wt):
    q = F(0)
    for a in range(5):
        for b in range(5):
            for c in range(5):
                for dd in range(5):
                    x = F(Wt[a][b][c][dd])
                    if x: q += x*x
    M = [[F(Wt[a//5][a%5][c//5][c%5]) for c in range(25)] for a in range(25)]
    M2 = [[sum(M[r][k]*M[k][cc] for k in range(25) if M[r][k]) for cc in range(25)]
          for r in range(25)]
    t3 = sum(M2[r][k]*M[k][r] for r in range(25) for k in range(25) if M2[r][k])
    return F(3, 2)*q**3 - 9*t3**2

# W_0, the extremiser, must give F_5 = 0 over Q -- a check independent of any prime.
_ex_sp = importlib.util.spec_from_file_location("ex", os.path.join(RD, "run_n5_extremiser.py"))
_ex = importlib.util.module_from_spec(_ex_sp)
_o = sys.stdout; sys.stdout = open(os.devnull, "w"); _ex_sp.loader.exec_module(_ex); sys.stdout = _o
_S = _ex.SOL if hasattr(_ex, "SOL") else None
print("extremiser module attrs:", [a for a in dir(_ex) if a.isupper()])

vals = [F5_exact(t) for t in SAMPT]
print(f"\nF_5 over Q at the 40 samples: {sum(1 for v in vals if v)} nonzero")
print(f"  max height: {max(max(abs(v.numerator), v.denominator) for v in vals)}")
print(f"  denominators: {sorted({v.denominator for v in vals})}")

# --- against the lifted rationals ---
with open(os.path.join(os.path.dirname(os.path.abspath(__file__)), "lifted.pkl"), "rb") as f:
    L = pickle.load(f)
B = L["B"]
bad = [i for i in range(40) if B[i] != vals[i]]
print(f"\nlifted rhs vs exact F_5: {40-len(bad)}/40 agree")
if bad:
    for i in bad[:5]:
        print(f"  sample {i}: lifted {B[i]}   exact {vals[i]}")

# --- against the raw residues at every prime, including any fourth ---
files = sorted(glob.glob(os.path.join(RD, "n5_rows_*.json")))
for fn in files:
    dj = json.load(open(fn)); p = dj["prime"]
    def red(x):
        return (x.numerator % p) * pow(x.denominator % p, p-2, p) % p
    ok = sum(1 for i in range(40) if red(vals[i]) == dj["rhs"][i] % p)
    print(f"  prime {p}: exact F_5 reduces to the dumped rhs at {ok}/40 samples")
