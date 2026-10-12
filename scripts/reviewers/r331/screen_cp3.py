"""CP3 n=6: exact span test at its true spectrum (-4,1,16)/sqrt360 mults (6,8,1),
theta-LP and S22-LP."""
import numpy as np
from fractions import Fraction
from itertools import combinations
from scipy.optimize import linprog
exec(open('scripts/reviewers/r331/span_lib.py').read())
span_test([Fraction(-4), Fraction(1), Fraction(16)], [6, 8, 1], "CP3 n=6 true spectrum")

lam = np.array([-4.0]*6 + [1.0]*8 + [16.0])
n = 6; N = 15
triples = list(combinations(range(N), 3)); nv = len(triples)
Aeq = np.zeros((3*N, nv+1)); beq = np.zeros(3*N)
for i, t in enumerate(triples):
    for pos in range(3):
        k = t[pos]; o = [t[j] for j in range(3) if j != pos]
        lb, lc = lam[o[0]], lam[o[1]]
        Aeq[3*k, i] += 1.0; Aeq[3*k+1, i] += lb+lc; Aeq[3*k+2, i] += lb*lc
for k in range(N):
    beq[3*k] = n-2; beq[3*k+1] = -2*lam[k]
    Aeq[3*k+2, nv] = -lam[k]; beq[3*k+2] = -lam[k]**2
ob = np.zeros(nv+1); ob[nv] = 1.0
bounds = [(0, None)]*nv + [(None, None)]
hi = linprog(-ob, A_eq=Aeq, b_eq=beq, bounds=bounds, method='highs')
print("CP3 max theta over full system (true scaled theta = 20):", -hi.fun)
# S22 LP at fixed theta = 20
Aeq2 = Aeq[:, :nv].copy(); beq2 = beq.copy()
for k in range(N):
    beq2[3*k+2] = lam[k]*(20.0-lam[k])
obj = np.array([2*(lam[a]**2*lam[b]**2+lam[b]**2*lam[c]**2+lam[a]**2*lam[c]**2)
                for a, b, c in triples])
lo = linprog(obj, A_eq=Aeq2, b_eq=beq2, bounds=(0, None), method='highs')
hi = linprog(-obj, A_eq=Aeq2, b_eq=beq2, bounds=(0, None), method='highs')
print("CP3 S22 LP: min =", lo.fun, " max =", -hi.fun)
