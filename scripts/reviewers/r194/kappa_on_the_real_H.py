"""Claim 2 on the REAL objects: run_n5_evaluate.py's own H, sym3_ip and cube.

The prefix of run_n5_evaluate.py up to its "EXERCISE THE CODE" marker is exec'd
verbatim, so H, sym3_ip, cube, coords and MONO are the shipped definitions --
no reimplementation.  Then kappa is recomputed with the coordinate vector w
replaced by garbage and with H's within-weight off-diagonals deleted.

The full dense w gives |MONO|^2 = 60 million sym3_ip calls, so this uses w
supported on a SUBSET of the 35 weight-basis indices, chosen to contain the
off-diagonal within-weight pairs -- the entries the file's own comment says
"nothing else in the pipeline looks" at.  The theorem in
kappa_is_a_tautology.py says the answer cannot depend on that choice.
"""
import os, sys, itertools, random
from fractions import Fraction as F

RUNS = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__)))), "runs")
src = open(os.path.join(RUNS, "run_n5_evaluate.py")).read()
cut = src.index("# EXERCISE THE CODE")
ns = {"__file__": os.path.join(RUNS, "run_n5_evaluate.py"), "__name__": "ev"}
o = sys.stdout; sys.stdout = open(os.devnull, "w")
exec(compile(src[:cut], "run_n5_evaluate.py", "exec"), ns)
sys.stdout = o
H, sym3_ip, cube, coords = ns["H"], ns["sym3_ip"], ns["cube"], ns["coords"]
WT, byw = ns["WT"], ns["byw"]
cmul, cadd, cconj = ns["cmul"], ns["cadd"], ns["cconj"]

offdiag = sorted((a, b) for (a, b) in H if a != b)
print(f"real H: {len(H)} nonzero entries, {len(offdiag)} of them off-diagonal")
print(f"  off-diagonal pairs: {offdiag}")

# a support containing every index that appears in an off-diagonal entry
SUPP = sorted({a for p in offdiag for a in p})
print(f"  support used: {SUPP}  ({len(SUPP)} indices)\n")

def kappa_on(Hx, w, supp):
    mono = list(itertools.combinations_with_replacement(supp, 3))
    c3 = {}
    for t in mono:
        z = (F(ns["multinom"](t)), F(0))
        for a in t: z = cmul(z, w[a])
        if z != (F(0), F(0)): c3[t] = z
    Hx = dict(Hx)
    saveH = dict(ns["H"]); ns["H"].clear(); ns["H"].update(Hx)
    tot = (F(0), F(0))
    for t, ct in c3.items():
        for s, cs in c3.items():
            ip = sym3_ip(t, s)
            if ip != (F(0), F(0)): tot = cadd(tot, cmul(cmul(ct, cconj(cs)), ip))
    ns["H"].clear(); ns["H"].update(saveH)
    n2 = (F(0), F(0))
    for a in supp:
        for b in supp:
            if (a, b) in Hx: n2 = cadd(n2, cmul(cmul(w[a], cconj(w[b])), Hx[(a, b)]))
    if n2[0] == 0: return None, n2
    return tot[0] / n2[0]**3, n2

random.seed(194)
def rndw():
    return {a: (F(random.randint(-4, 4)), F(random.randint(-4, 4))) for a in range(35)}

print("=" * 72)
print("(1) the TRUE coordinate vector of a real rational Weyl tensor,")
print("    restricted to the support -- the pipeline's own w")
print("=" * 72)
sys.path.insert(0, RUNS)
import importlib.util
sp = importlib.util.spec_from_file_location("wm", os.path.join(RUNS, "run_n5_weyl_module.py"))
wm = importlib.util.module_from_spec(sp)
o = sys.stdout; sys.stdout = open(os.devnull, "w"); sp.loader.exec_module(wm); sys.stdout = o
v = [F(random.randint(-3, 3)) for _ in range(35)]
full = [sum(v[j]*wm.BASIS[j][c] for j in range(35) if v[j]) for c in range(len(wm.SPAIRS))]
R = wm.sym2_to_R({wm.SPAIRS[c]: full[c] for c in range(len(full)) if full[c]})
wtrue = coords(R)
k, n2 = kappa_on(H, wtrue, SUPP)
print(f"    kappa = {k}      |w|^2 on the support = {n2[0]}")

print()
print("=" * 72)
print("(2) w replaced by GARBAGE -- the coordinate solve deleted entirely")
print("=" * 72)
for t in range(4):
    w = rndw()
    k, n2 = kappa_on(H, w, SUPP)
    print(f"    trial {t}: kappa = {k}      |w|^2 = {n2[0]}")

print()
print("=" * 72)
print("(3) the real H with its within-weight OFF-DIAGONALS deleted")
print("    -- the file's own comment says these 10 entries are where the")
print("       conventions part company and 'nothing else in the pipeline looks'")
print("=" * 72)
Hd = {k_: v_ for k_, v_ in H.items() if k_[0] == k_[1]}
print(f"    deleted {len(H) - len(Hd)} entries")
for t in range(3):
    w = rndw()
    print(f"    trial {t}: kappa(full H) = {kappa_on(H, w, SUPP)[0]}"
          f"    kappa(diagonalised H) = {kappa_on(Hd, w, SUPP)[0]}")

print()
print("=" * 72)
print("(4) the real H with a within-weight off-diagonal entry made WRONG")
print("=" * 72)
Hw = dict(H)
(a, b) = offdiag[0]
Hw[(a, b)] = cadd(Hw[(a, b)], (F(7), F(3)))
Hw[(b, a)] = cconj(Hw[(a, b)])
print(f"    perturbed H[{(a,b)}] by 7+3i (and its conjugate) -- still Hermitian")
for t in range(3):
    w = rndw()
    print(f"    trial {t}: kappa(correct H) = {kappa_on(H, w, SUPP)[0]}"
          f"    kappa(wrong H) = {kappa_on(Hw, w, SUPP)[0]}")

print()
print("=" * 72)
print("(5) the compensating pair, on the real H")
print("=" * 72)
def kappa_pair(w, supp):
    """cube WITHOUT the multinomial, ip = 36 * MULT_UP."""
    from math import factorial
    def aut(u):
        m = {}
        for x in u: m[x] = m.get(x, 0) + 1
        r = 1
        for vv in m.values(): r *= factorial(vv)
        return r
    mono = list(itertools.combinations_with_replacement(supp, 3))
    c3 = {}
    for t in mono:
        z = (F(1), F(0))
        for a in t: z = cmul(z, w[a])
        if z != (F(0), F(0)): c3[t] = z
    tot = (F(0), F(0))
    for t, ct in c3.items():
        for s, cs in c3.items():
            ip = sym3_ip(t, s, convention="MULT_UP")
            f = F(36)
            ip = (ip[0]*f, ip[1]*f)
            if ip != (F(0), F(0)): tot = cadd(tot, cmul(cmul(ct, cconj(cs)), ip))
    n2 = (F(0), F(0))
    for a in supp:
        for b in supp:
            if (a, b) in H: n2 = cadd(n2, cmul(cmul(w[a], cconj(w[b])), H[(a, b)]))
    return tot[0] / n2[0]**3
for t in range(3):
    w = rndw()
    kg = kappa_on(H, w, SUPP)[0]
    kp = kappa_pair(w, SUPP)
    print(f"    trial {t}: shipped kappa = {kg}   two-errors kappa = {kp}   equal: {kg == kp}")
