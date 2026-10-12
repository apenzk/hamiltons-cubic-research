"""r334 screen: is theta PINNED by the full pinned system at a fixed spectrum?
Variables: T_{abc} for a<b<c (>=0) and theta (free). Constraints, per index a:
 (A) sum_{b<c} T_abc = n-2
 (B) sum_{b<c} (lam_b+lam_c) T_abc = -2 lam_a
 (C) sum_{b<c} lam_b lam_c T_abc = lam_a(theta - lam_a)
Maximise and minimise theta. Integer/rational-scaled spectra, so exactness is visible.
This is a SCREEN, not evidence for a positive claim."""
import itertools, numpy as np
from scipy.optimize import linprog

def run(name, n, lam):
    lam = np.array(lam, dtype=float)
    N = len(lam)
    assert N == n*(n-1)//2, (N, n)
    assert abs(lam.sum()) < 1e-9, lam.sum()
    tri = list(itertools.combinations(range(N), 3))
    idx = {t: i for i, t in enumerate(tri)}
    nv = len(tri) + 1          # last variable is theta
    rows, rhs = [], []
    for a in range(N):
        rA = np.zeros(nv); rB = np.zeros(nv); rC = np.zeros(nv)
        for b, c in itertools.combinations([x for x in range(N) if x != a], 2):
            t = tuple(sorted((a, b, c))); j = idx[t]
            rA[j] += 1.0
            rB[j] += lam[b] + lam[c]
            rC[j] += lam[b] * lam[c]
        rC[-1] -= lam[a]                       # move lam_a*theta to the left
        rows += [rA, rB, rC]; rhs += [n - 2, -2 * lam[a], -lam[a] ** 2]
    Aeq = np.array(rows); beq = np.array(rhs)
    bounds = [(0, None)] * len(tri) + [(None, None)]
    out = {}
    for sense, sign in (("max", -1.0), ("min", 1.0)):
        c = np.zeros(nv); c[-1] = sign
        r = linprog(c, A_eq=Aeq, b_eq=beq, bounds=bounds, method="highs")
        out[sense] = (r.status, None if not r.success else r.x[-1])
    print(f"{name}: N={N} vars={nv} rows={Aeq.shape[0]}  min={out['min']}  max={out['max']}")
    return out

# n=6 balanced S^3xS^3, scaled: lam_min=-2 (mult 9), lam_max=3 (mult 6); true theta = 10
run("S3xS3 (n=6, scaled)", 6, [-2]*9 + [3]*6)
# n=6 maximal torus, scaled: (4, mult 3), (-1, mult 12); true theta = 5
run("torus n=6 (scaled)", 6, [4]*3 + [-1]*12)
# n=6 padded W_CP2: (2,-1,-1,0^12) -> mult (1,2,12); true theta = 3
run("padded W_CP2 n=6 (scaled)", 6, [2] + [-1]*2 + [0]*12)
# n=6 CP^3: (-4 mult6, 1 mult8, 16 mult1); true theta = 20
run("CP^3 n=6 (scaled)", 6, [-4]*6 + [1]*8 + [16])

# Ablation: drop (B) at the balanced spectrum -- is (B) inert on the theta range?
def run_ablate(n, lam, useB):
    lam = np.array(lam, float); N = len(lam)
    tri = list(itertools.combinations(range(N), 3)); idx = {t: i for i, t in enumerate(tri)}
    nv = len(tri) + 1; rows, rhs = [], []
    for a in range(N):
        rA = np.zeros(nv); rB = np.zeros(nv); rC = np.zeros(nv)
        for b, c in itertools.combinations([x for x in range(N) if x != a], 2):
            j = idx[tuple(sorted((a, b, c)))]
            rA[j] += 1.0; rB[j] += lam[b] + lam[c]; rC[j] += lam[b]*lam[c]
        rC[-1] -= lam[a]
        rows += [rA, rC]; rhs += [n-2, -lam[a]**2]
        if useB:
            rows.append(rB); rhs.append(-2*lam[a])
    bnds = [(0, None)]*len(tri) + [(None, None)]
    vals = []
    for sg in (1.0, -1.0):
        o = linprog(np.r_[np.zeros(len(tri)), sg], A_eq=np.array(rows), b_eq=np.array(rhs),
                    bounds=bnds, method="highs")
        vals.append(o.x[-1] if o.success else "INFEASIBLE")
    return vals

bal = [-2.0]*9 + [3.0]*6
print("S3xS3 n=6, (A)+(C) only :", run_ablate(6, bal, False))
print("S3xS3 n=6, (A)+(B)+(C)  :", run_ablate(6, bal, True))
print("unscaled: divide by sqrt(90) =", np.sqrt(90))
