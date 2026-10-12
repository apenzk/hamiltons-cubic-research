"""r213, the decisive test of claims 3 and 4: does the certificate's sextic equal
F_5 at points OUTSIDE the 40 it was fitted to?

The brief's worry is that the Gram's sextic agrees with F_5 at exactly those 40
points and nowhere else -- which is what a rank mismatch in the injectivity
argument would produce.  The argument is replaced here by a measurement: a copy
of the assemble pipeline run with 80 sample points instead of 40, the first 40
identical by construction (same seed), the last 40 never seen by the solve.

For each held-out point W:   row(W) . x  ==  F_5(W)  mod p,
with x the certificate's 47 rationals and F_5 computed here from the tensor.
"""
import json, os, sys, glob, importlib.util, random
from fractions import Fraction as F

HERE = os.path.dirname(os.path.abspath(__file__))
RUNS = os.path.join(HERE, "..", "..", "runs")
fn = sorted(glob.glob(os.path.join(HERE, "r213_rows80_*.json")))
assert fn, "the 80-point run has not produced its dump"
D = json.load(open(fn[0])); p = D["prime"]
rows, rhs = D["rows"], D["rhs"]
print(f"prime {p}, {len(rows)} points x {len(rows[0])} columns, shape {D['shape']}")
assert len(rows) == 80

ref = json.load(open(os.path.join(RUNS, f"n5_rows_{p}.json")))
same = all(rows[i] == ref["rows"][i] for i in range(40)) and \
       all(rhs[i] == ref["rhs"][i] for i in range(40))
print(f"first 40 rows and rhs reproduce the published dump exactly: {same}")
assert D["shape"] == ref["shape"] and D["blocks"] == ref["blocks"]
assert same, "the 80-point run does not reproduce the 40-point dump"

sp = importlib.util.spec_from_file_location("wm", os.path.join(RUNS, "run_n5_weyl_module.py"))
wm = importlib.util.module_from_spec(sp)
_o = sys.stdout; sys.stdout = open(os.devnull, "w")
try: sp.loader.exec_module(wm)
finally: sys.stdout = _o

random.seed(20260829)
T = []
for k in range(81):
    v = [F(random.randint(-4, 4)) for _ in range(35)]
    if k == 0: continue                       # the probe draw
    full = [sum(v[j]*wm.BASIS[j][c] for j in range(35) if v[j])
            for c in range(len(wm.SPAIRS))]
    T.append(wm.sym2_to_R({wm.SPAIRS[c]: full[c]
                           for c in range(len(full)) if full[c]}))

def F5(R):
    q = sum(R[a][b][c][d]**2 for a in range(5) for b in range(5)
            for c in range(5) for d in range(5))
    M = [[R[a//5][a % 5][b//5][b % 5] for b in range(25)] for a in range(25)]
    M2 = [[sum(M[i][k]*M[k][j] for k in range(25)) for j in range(25)]
          for i in range(25)]
    t3 = sum(M2[i][j]*M[j][i] for i in range(25) for j in range(25))
    return F(3, 2)*q**3 - 9*t3**2

def red(x): return x.numerator * pow(x.denominator, p-2, p) % p

C = json.load(open(os.path.join(RUNS, "n5_certificate.json")))
x = [F(int(a), int(b)) for a, b in C["point"]]
assert C["shape"] == D["shape"] and C["blocks"] == D["blocks"]
xm = [red(v) for v in x]

bad_rhs = bad_sex = 0
for i in range(80):
    f5 = F5(T[i])
    if red(f5) != rhs[i] % p: bad_rhs += 1
    if sum(rows[i][j]*xm[j] for j in range(47)) % p != red(f5): bad_sex += 1
print(f"\nrhs == F_5 (from the tensor) at all 80 points : {bad_rhs} mismatches")
print(f"row . x == F_5 at all 80 points               : {bad_sex} mismatches")
print(f"  of which the 40 HELD-OUT points            : "
      f"{sum(1 for i in range(40, 80) if sum(rows[i][j]*xm[j] for j in range(47)) % p != red(F5(T[i])))}"
      f" mismatches")
assert bad_rhs == 0 and bad_sex == 0
print("\nThe certificate's sextic agrees with F_5 at 40 points it was never shown.")
print("A sextic that merely interpolated F_5 on the fitting set would miss here")
print(f"with probability 1 - O(1/p), p ~ 2^{p.bit_length()}, at each of 40 points.")

# and the rank does not grow on the larger sample
def rank_modp(M):
    M = [r[:] for r in M]; r = 0
    for c in range(len(M[0])):
        pv = next((t for t in range(r, len(M)) if M[t][c] % p), None)
        if pv is None: continue
        M[r], M[pv] = M[pv], M[r]
        iv = pow(M[r][c], p-2, p)
        M[r] = [v*iv % p for v in M[r]]
        for t in range(len(M)):
            if t != r and M[t][c] % p:
                f0 = M[t][c]; M[t] = [(v - f0*w) % p for v, w in zip(M[t], M[r])]
        r += 1
    return r
print(f"\nrestricted rank at 40 points: {rank_modp(rows[:40])}")
print(f"restricted rank at 80 points: {rank_modp(rows)}")
print(f"rank of [rows | F_5] at 80 points: "
      f"{rank_modp([rows[i] + [red(F5(T[i]))] for i in range(80)])}")
