"""r213: is the ascent maximiser in the O(5) orbit of W_0?  Compare the exact
Lambda^2 spectrum of W_0 with the float spectrum found by the ascent."""
import os, sys, importlib.util
from fractions import Fraction as F
from itertools import combinations
import numpy as np
RUNS = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
def load(n):
    sp = importlib.util.spec_from_file_location(n[:-3], os.path.join(RUNS, n))
    m = importlib.util.module_from_spec(sp)
    o = sys.stdout; sys.stdout = open(os.devnull, "w")
    try: sp.loader.exec_module(m)
    finally: sys.stdout = o
    return m
wm = load("run_n5_weyl_module.py"); ex = load("run_n5_extremiser.py")
S = ex.S; NP = len(S)
W0 = wm.sym2_to_R({(a,b): S[a][b] for a in range(NP) for b in range(a,NP) if S[a][b]})
P = list(combinations(range(5),2))
Wh = np.array([[float(W0[i][j][k][l]) for (k,l) in P] for (i,j) in P])
ev = np.sort(np.linalg.eigvalsh(Wh))
n = np.linalg.norm(ev)
print("W_0 Lambda^2 spectrum:", np.round(ev, 10))
print("normalised           :", np.round(ev/np.abs(ev).max(), 10))
x = np.load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "argmax.npy"))
h = load if False else None
sp = importlib.util.spec_from_file_location("hh", os.path.join(os.path.dirname(os.path.abspath(__file__)), "hunt_f5_negative.py"))
hh = importlib.util.module_from_spec(sp)
o = sys.stdout; sys.stdout = open(os.devnull,"w")
try: sp.loader.exec_module(hh)
finally: sys.stdout = o
x = x/np.linalg.norm(x)
T = (x @ hh.BAS).reshape(5,5,5,5)
Wm = np.array([[T[i,j,k,l] for (k,l) in P] for (i,j) in P])
em = np.sort(np.linalg.eigvalsh(Wm))
print("ascent maximiser     :", np.round(em/np.abs(em).max(), 10))
print("same normalised spectrum:",
      np.allclose(np.sort(np.abs(ev/np.abs(ev).max())), np.sort(np.abs(em/np.abs(em).max())), atol=1e-7))
q0 = sum(W0[a][b][c][d]**2 for a in range(5) for b in range(5) for c in range(5) for d in range(5))
M = [[W0[a//5][a%5][b//5][b%5] for b in range(25)] for a in range(25)]
M2 = [[sum(M[i][k]*M[k][j] for k in range(25)) for j in range(25)] for i in range(25)]
t3 = sum(M2[i][j]*M[j][i] for i in range(25) for j in range(25))
print(f"exact at W_0: |W|^2 = {q0}, tr(W^3) = {t3}, tr(W^3)^2*6 = {6*t3*t3}, |W|^6 = {q0**3}")
print(f"  6 tr(W^3)^2 == |W|^6 : {6*t3*t3 == q0**3}   (equality in F_5 >= 0)")
