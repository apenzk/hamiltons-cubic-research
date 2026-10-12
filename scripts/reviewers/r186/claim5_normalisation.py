"""Claim 5, r186: G_tensor = 4 * G_operator entrywise, exactly, on all 35x35."""
from fractions import Fraction as F
import importlib.util, sys, os
d = os.path.dirname(os.path.abspath(__file__))
spec = importlib.util.spec_from_file_location(
    "wm", os.path.join(d, "..", "..", "runs", "run_n5_weyl_module.py"))
wm = importlib.util.module_from_spec(spec)
o = sys.stdout; sys.stdout = open(os.devnull, "w"); spec.loader.exec_module(wm); sys.stdout = o
N, PAIRS, SPAIRS, BASIS = wm.N, wm.PAIRS, wm.SPAIRS, wm.BASIS
TEN = [wm.sym2_to_R({SPAIRS[k]: c for k, c in enumerate(b) if c}) for b in BASIS]
OPS = [[[T[i][j][k][l] for (k, l) in PAIRS] for (i, j) in PAIRS] for T in TEN]
def tdot(A, B):
    return sum(A[i][j][k][l]*B[i][j][k][l] for i in range(N) for j in range(N)
               for k in range(N) for l in range(N))
def odot(A, B):
    return sum(A[a][b]*B[a][b] for a in range(len(PAIRS)) for b in range(len(PAIRS)))
bad = 0; sample = []
for i in range(35):
    for j in range(i, 35):
        t, op = tdot(TEN[i], TEN[j]), odot(OPS[i], OPS[j])
        if t != 4*op: bad += 1
        if len(sample) < 4 and op: sample.append((i, j, t, op))
print(f"G_tensor[i][j] == 4 * G_operator[i][j] for all 630 entries: {bad == 0}")
print(f"  samples (i,j,tensor,operator): {sample}")
# W_0 in both
W1 = {(0,1):F(1), (2,3):F(1)}; W2 = {(0,2):F(1), (1,3):F(-1)}; W3 = {(0,3):F(1), (1,2):F(1)}
PIDX = wm.PIDX
S = [[F(0)]*len(PAIRS) for _ in range(len(PAIRS))]
for w, s in ((W1,2), (W2,-1), (W3,-1)):
    v = [F(0)]*len(PAIRS)
    for (i, j), c in w.items(): v[PIDX[(i,j)]] = c
    for a in range(len(PAIRS)):
        for b in range(len(PAIRS)): S[a][b] += F(s,2)*v[a]*v[b]
T0 = wm.sym2_to_R({(a,b): S[a][b] for (a,b) in SPAIRS})
print(f"  at sqrt6*W_0: tensor norm^2 = {tdot(T0,T0)}, operator norm^2 = {odot(S,S)}")
print(f"  so |W_0|^2 reads {F(tdot(T0,T0),6)} (tensor) against {F(odot(S,S),6)} (operator)")
