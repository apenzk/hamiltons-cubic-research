"""r213 claim 3: is the dumped rhs really F_5 at the sample points?

The sample tensors are regenerated from the pipeline's own seed, then F_5 is
computed HERE, exactly over Q, by direct contraction on the rank-4 tensor:
F_5 = (3/2)(W.W)^3 - 9 tr(W^3)^2 with tr(W^3) = W_abcd W_cdef W_efab.
Each tensor is first checked to BE an algebraic Weyl tensor.  The lifted rhs
comes from c2_affine_exact's independent CRT.
"""
import json, os, glob, sys, importlib.util, random
from fractions import Fraction as F

HERE = os.path.dirname(os.path.abspath(__file__))
RUNS = os.path.join(HERE, "..", "..", "runs")
sys.path.insert(0, HERE)
import c2_affine_exact as c2          # gives A, B, PS, data  (prints its own report)
print("\n" + "="*70)

sp = importlib.util.spec_from_file_location("wm", os.path.join(RUNS, "run_n5_weyl_module.py"))
wm = importlib.util.module_from_spec(sp)
_o = sys.stdout; sys.stdout = open(os.devnull, "w")
try: sp.loader.exec_module(wm)
finally: sys.stdout = _o

def gen(nskip, n):
    random.seed(20260829)
    out = []
    for k in range(nskip + n):
        v = [F(random.randint(-4, 4)) for _ in range(35)]
        if k < nskip: continue
        full = [sum(v[j]*wm.BASIS[j][c] for j in range(35) if v[j])
                for c in range(len(wm.SPAIRS))]
        out.append(wm.sym2_to_R({wm.SPAIRS[c]: full[c]
                                 for c in range(len(full)) if full[c]}))
    return out

def is_weyl(R):
    n = 5
    for a in range(n):
        for b in range(n):
            for c in range(n):
                for d in range(n):
                    if R[a][b][c][d] != -R[b][a][c][d]: return "ab"
                    if R[a][b][c][d] != -R[a][b][d][c]: return "cd"
                    if R[a][b][c][d] != R[c][d][a][b]:  return "pair"
                    if R[a][b][c][d] + R[a][c][d][b] + R[a][d][b][c] != 0: return "bianchi"
    for i in range(n):
        for j in range(n):
            if sum(R[a][i][a][j] for a in range(n)) != 0: return "ricci"
    return None

def F5(R):
    n = 5
    q = sum(R[a][b][c][d]**2 for a in range(n) for b in range(n)
            for c in range(n) for d in range(n))
    M = [[R[a//n][a % n][b//n][b % n] for b in range(n*n)] for a in range(n*n)]
    M2 = [[sum(M[i][k]*M[k][j] for k in range(n*n)) for j in range(n*n)]
          for i in range(n*n)]
    t3 = sum(M2[i][j]*M[j][i] for i in range(n*n) for j in range(n*n))
    return F(3, 2)*q**3 - 9*t3**2

for NSKIP in (1, 0, 2):
    T = gen(NSKIP, 40)
    vals = [F5(t) for t in T]
    if vals == c2.B:
        print(f"seed offset {NSKIP}: THE LIFTED RHS EQUALS F_5 AT ALL 40 SAMPLE POINTS,")
        print("  exactly over Q, recomputed from the tensor by direct contraction.")
        break
    agree = sum(1 for a, b in zip(vals, c2.B) if a == b)
    print(f"seed offset {NSKIP}: {agree}/40 agree")
else:
    print("NO offset reproduces the rhs -- the sample points could not be regenerated")
    sys.exit(1)

bad = [i for i, t in enumerate(T) if is_weyl(t)]
print(f"  all 40 sample tensors are algebraic Weyl tensors (Ricci-flat, Bianchi):"
      f" {len(bad)} failures")
assert not bad

# F_5 at W_0 -- must be exactly zero
ex = importlib.util.spec_from_file_location("ex", os.path.join(RUNS, "run_n5_extremiser.py"))
em = importlib.util.module_from_spec(ex)
_o = sys.stdout; sys.stdout = open(os.devnull, "w")
try: ex.loader.exec_module(em)
finally: sys.stdout = _o
S = em.S; NP = len(S)
W0 = wm.sym2_to_R({(a, b): S[a][b] for a in range(NP) for b in range(a, NP) if S[a][b]})
print(f"  W_0 is an algebraic Weyl tensor: {is_weyl(W0) is None}")
f0 = F5(W0)
q0 = sum(W0[a][b][c][d]**2 for a in range(5) for b in range(5)
         for c in range(5) for d in range(5))
print(f"  |W_0|^2 = {q0},  F_5(W_0) = {f0}   (must be 0)")
assert f0 == 0 and q0 != 0

# and the certificate's sextic AT the sample points equals F_5 there
C = json.load(open(os.path.join(RUNS, "n5_certificate.json")))
x = [F(int(a), int(b)) for a, b in C["point"]]
sx = [sum(c2.A[i][j]*x[j] for j in range(c2.NC)) for i in range(40)]
print(f"  certificate's sextic vs F_5 at the 40 points: "
      f"{sum(1 for a,b in zip(sx, vals) if a==b)}/40 exactly equal")
