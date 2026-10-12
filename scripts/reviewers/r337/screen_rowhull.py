# SCREEN ONLY (seconds, constructed objects). Per-row 2-moment condition vs the record's two 1-D projections.
from itertools import combinations
import math
from scipy.optimize import linprog

def rows(lams, n):
    N = len(lams); out = []
    for a in range(N):
        la = lams[a]
        if abs(la) < 1e-12: continue
        idx = [b for b in range(N) if b != a]
        pts = {}
        for b, c in combinations(idx, 2):
            X = (lams[b] + lams[c]) / 2.0; Y = lams[b] * lams[c]
            pts[(round(X, 12), round(Y, 12))] = 1
        P = list(pts)
        Xs = [p[0] for p in P]; Ys = [p[1] for p in P]
        t = -la / (n - 2)
        Aeq = [[1.0] * len(P), Xs]; beq = [1.0, t]
        # projection-only bounds (record's family): ignore the X-moment
        fam = la + (n - 2) * (max(Ys) if la > 0 else min(Ys)) / la
        sgn = -1.0 if la > 0 else 1.0
        r = linprog([sgn * y for y in Ys], A_eq=Aeq, b_eq=beq, bounds=(0, None), method="highs")
        if not r.success: continue
        Yopt = sgn * r.fun
        out.append((la, fam, la + (n - 2) * Yopt / la))
    return out

def report(name, lams, n, theta):
    r = rows(lams, n)
    fam = min(x[1] for x in r); hull = min(x[2] for x in r)
    pi = (n - 1) * abs(min(lams))
    l70 = min(lams) + (n - 2) * max(lams)
    print(f"{name:22s} n={n:2d} theta={theta:10.6f}  family={fam:10.6f}  Pi={pi:10.6f}  L70={l70:10.6f}  ROWHULL={hull:10.6f}")

s6 = math.sqrt(6)
for n in (6, 8, 10, 12):
    N = n * (n - 1) // 2
    report("padded W_CP2", [2/s6, -1/s6, -1/s6] + [0.0]*(N-3), n, math.sqrt(1.5))
for n in (6, 8, 12):
    p = n//2; h = n/(n-2)
    lams = [h]*(2*(p*(p-1)//2)) + [-1.0]*(p*p)
    report("balanced S^p x S^p", lams, n, n-1)
for n in (5, 6, 8, 12):
    h = n-2; s = 2/(n-3)
    lams = [h] + [s]*(((n-2)*(n-3))//2) + [-1.0]*(2*(n-2))
    report("S^2 x S^{n-2}", lams, n, n-1)
