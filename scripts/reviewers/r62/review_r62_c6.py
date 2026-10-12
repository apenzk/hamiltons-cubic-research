"""Reviewer 62: audit of C6 (a)-(d) -- the four refuted attempts, with independent dual-feasibility checks."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, itertools, sys
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r62_g import G_closed, spectrum_from_x, FTP
from scipy.optimize import minimize

TARGET = np.sqrt(1.5)
rng = np.random.default_rng(626)


# ---------- (a) lam_1 <= sqrt(u) ----------
def bound_a(b, c):
    u = 1 - b * b - c * c
    if u < 0: return -np.inf
    s = b + c
    return np.sqrt(u) * (s * s + 6 * b * c) - b ** 3 - c ** 3


print("(a)  chain with lam_1 <= sqrt(u):  max of sqrt(u)(s^2+6bc) - b^3 - c^3")
best = (-9, None)
for b in np.linspace(1e-4, 1.0, 2001):
    for c in np.linspace(1e-4, b, 400):
        u = 1 - b * b - c * c
        if u <= 0: continue
        if (b + c) ** 2 + b * b + c * c < 1 - 1e-12: continue    # the C2 feasibility cut
        v = bound_a(b, c)
        if v > best[0]: best = (v, (b, c))
print(f"     max = {best[0]:.6f} at b={best[1][0]:.4f} c={best[1][1]:.4f}   (claim: 1.5688 at b=c=0.5465)")
b0 = c0 = 0.5465
print(f"     value at the claimed argmax b=c=0.5465: {bound_a(b0, c0):.6f}")


# ---------- dual feasibility of (b) and (c) ----------
def dual_check(lam, kind):
    """lam sorted with the two negatives last.  Returns min slack of
       z_ab+z_ag+z_bg + y_a+y_b+y_g - 3 lam_a lam_b lam_g   (y = 0)."""
    n = len(lam)
    P = [i for i in range(n) if lam[i] > 0]
    negs = [i for i in range(n) if lam[i] < 0]
    assert len(negs) == 2
    iN1, iN = negs
    b, c = -lam[iN], -lam[iN1]
    l1 = max(lam[i] for i in P)
    fac = 1.5 if kind == 'b' else 1.0
    z = {}
    for a, bb in itertools.combinations(range(n), 2):
        if a in P and bb in P:
            z[(a, bb)] = fac * l1 * lam[a] * lam[bb]
        elif {a, bb} == {iN1, iN}:
            z[(a, bb)] = 3 * l1 * b * c
        else:
            z[(a, bb)] = 0.0
    slack = np.inf
    for t in itertools.combinations(range(n), 3):
        a, bb, g = t
        val = z[(a, bb)] + z[(a, g)] + z[(bb, g)] - 3 * lam[a] * lam[bb] * lam[g]
        slack = min(slack, val)
    value = float(np.sum(lam ** 3) + 2 * sum(z.values()))
    return slack, value


print("\n(b),(c)  independent dual-feasibility check and exceedance census")
for kind in ('b', 'c'):
    minslack = np.inf; exc = 0; tot = 0; mx = -9; arg = None
    for _ in range(20000):
        k = rng.integers(1, 7)
        x = rng.random(k) ** rng.choice([1, 2, 4])
        x = x / np.linalg.norm(x) * (rng.random() * 0.35 + 0.62)
        s = x.sum(); u = (x ** 2).sum()
        if 0.5 * (s * s + u - 1) <= 0 or 2 * (1 - u) - s * s <= 0: continue
        lam, bq, cq = spectrum_from_x(x)
        if cq <= 1e-9: continue
        sl, val = dual_check(lam, kind)
        minslack = min(minslack, sl); tot += 1
        if val > TARGET + 1e-12:
            exc += 1
            if val > mx: mx, arg = val, (lam.copy(), k)
    print(f"   ({kind}) min dual slack over {tot} feasible draws = {minslack:.3e}  -> "
          f"{'FEASIBLE' if minslack > -1e-9 else 'INFEASIBLE'}")
    print(f"        exceedances of sqrt(3/2): {exc}/{tot} ({100*exc/tot:.1f}%), max value {mx:.4f}, k={arg[1]}")


# ---------- (d) merge induction ----------
print("\n(d)  merge induction: does merging two positives (and renormalising) raise G?")
dec = 0; tot = 0; worst = 0.0
for _ in range(400):
    k = rng.integers(3, 7)
    x = rng.random(k) ** rng.choice([1, 2])
    x = x / np.linalg.norm(x) * (rng.random() * 0.3 + 0.65)
    s = x.sum(); u = (x ** 2).sum()
    if 0.5 * (s * s + u - 1) <= 0 or 2 * (1 - u) - s * s <= 0: continue
    lam, bq, cq = spectrum_from_x(x)
    if cq <= 1e-9: continue
    g0 = G_closed(x)
    for i, j in itertools.combinations(range(k), 2):
        y = np.array([x[t] for t in range(k) if t not in (i, j)] + [x[i] + x[j]])
        full = np.concatenate([y, [-bq, -cq]])
        full = full / np.linalg.norm(full)
        y2 = full[full > 0]
        g1 = G_closed(y2)
        if not np.isfinite(g1): continue
        tot += 1
        if g1 < g0 - 1e-12:
            dec += 1; worst = max(worst, g0 - g1)
print(f"     {dec}/{tot} single merges DECREASE G (max drop {worst:.4f})"
      f"   -> merge-induction is {'FALSE' if dec else 'consistent'} as a step")
