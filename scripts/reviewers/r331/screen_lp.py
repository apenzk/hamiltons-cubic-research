"""Exact span test at S3xS5's true rational spectrum; LP min/max of S_22 over
(A),(B),(C), T>=0 at S3xS5's (lambda, theta) -- Q4 formal-solution witnesses."""
import numpy as np
from fractions import Fraction
from itertools import combinations, combinations_with_replacement
from scipy.optimize import linprog

# exact spectrum check: values prop to (-4, 3, 10), mults (15, 10, 3)
vals = [Fraction(-4), Fraction(3), Fraction(10)]; mults = [15, 10, 3]
print("trace:", sum(v*m for v, m in zip(vals, mults)))
exec(open('scripts/reviewers/r331/span_lib.py').read())
span_test(vals, mults, "S3xS5 n=8 EXACT (-4,3,10)/7")

# ---- LP ----
n = 8; N = 28
lam_scale = np.array([-4.0]*15 + [3.0]*10 + [10.0]*3)
nrm = np.sqrt((lam_scale**2 * 1).sum())  # not the physical norm; instead use unit-norm lambda
lam = lam_scale/np.linalg.norm(lam_scale)
theta = np.sqrt(56/45)
# order eigenvalues ascending to match any T; LP needs only (lam, theta)
triples = list(combinations(range(N), 3))
nv = len(triples)
tri_idx = {t: i for i, t in enumerate(triples)}
Aeq = np.zeros((3*N, nv)); beq = np.zeros(3*N)
for i, t in enumerate(triples):
    for pos in range(3):
        k = t[pos]; others = [t[j] for j in range(3) if j != pos]
        lb, lc = lam[others[0]], lam[others[1]]
        Aeq[3*k, i] += 1.0
        Aeq[3*k+1, i] += lb + lc
        Aeq[3*k+2, i] += lb*lc
for k in range(N):
    beq[3*k] = n-2
    beq[3*k+1] = -2*lam[k]
    beq[3*k+2] = lam[k]*(theta-lam[k])
obj = np.array([2*(lam[a]**2*lam[b]**2 + lam[b]**2*lam[c]**2 + lam[a]**2*lam[c]**2)
                for (a, b, c) in triples])
for sense, sgn in (("min", 1.0), ("max", -1.0)):
    r = linprog(sgn*obj, A_eq=Aeq, b_eq=beq, bounds=(0, None), method='highs')
    print(sense, "S22:", sgn*r.fun if r.status == 0 else r.message,
          " status:", r.status)
    if r.status == 0:
        x = r.x
        print("   constraint residual:", np.abs(Aeq @ x - beq).max(), " min T:", x.min())
