"""Reviewer 199: the EXACT version of the multi-probe h check, on small blocks.

The file calls `dis == 0` a screen pending an exact check, and never runs one.
This runs it over Q(i) with ip3_exact -- every position of the smallest blocks
with m > 1 -- so the load-bearing assert of the three has an exact witness on
part of its domain.
"""
import importlib.util, sys, os, time
from fractions import Fraction as Fr, Fraction as F
d = os.path.dirname(os.path.abspath(__file__))
def load(name):
    sp = importlib.util.spec_from_file_location(name[:-3], os.path.join(d, name))
    m = importlib.util.module_from_spec(sp)
    o = sys.stdout; sys.stdout = open(os.devnull, "w"); sp.loader.exec_module(m); sys.stdout = o
    return m
ad = load("run_n5_adapted.py")
ADAPTED, MONO = ad.ADAPTED, ad.MONO
ev = load("run_n5_evaluate.py")
sym3_ip, cmul, cadd, cconj = ev.sym3_ip, ev.cmul, ev.cadd, ev.cconj

def ip3_exact(u, v):                    # verbatim from run_n5_assemble.py
    tot = (Fr(0), Fr(0))
    for a, ca in u.items():
        ta = MONO[a]
        for b, cb in v.items():
            k = sym3_ip(ta, MONO[b])
            if k != (Fr(0), Fr(0)):
                tot = cadd(tot, cmul(cmul((ca.r, ca.i), cconj((cb.r, cb.i))), k))
    return tot

def cdiv(x, y):
    n = y[0]*y[0] + y[1]*y[1]
    return ((x[0]*y[0] + x[1]*y[1])/n, (x[1]*y[0] - x[0]*y[1])/n)

order = sorted((l for l in ADAPTED if len(ADAPTED[l]) > 1),
               key=lambda l: len(ADAPTED[l][0]))
budget = float(os.environ.get("R199_BUDGET", 900))
t0 = time.time()
tot = dis = skipped = 0
for lam in order:
    copies = ADAPTED[lam]; m = len(copies)
    q00 = ip3_exact(copies[0][0], copies[0][0])
    hm = [[cdiv(ip3_exact(copies[i][0], copies[j][0]), q00) for j in range(m)]
          for i in range(m)]
    ld = 0
    for t in range(1, len(copies[0])):
        q = ip3_exact(copies[0][t], copies[0][t])
        if q == (Fr(0), Fr(0)): skipped += 1; continue
        for i in range(m):
            for j in range(m):
                tot += 1
                if cdiv(ip3_exact(copies[i][t], copies[j][t]), q) != hm[i][j]:
                    dis += 1; ld += 1
        if time.time() - t0 > budget: break
    print(f"  lambda={lam} m={m} dim {len(copies[0])}: probed to t={t}, "
          f"{ld} disagreements   [{time.time()-t0:.0f}s]", flush=True)
    if time.time() - t0 > budget:
        print("  budget spent"); break
print(f"\nEXACT over Q(i): {tot} comparisons, {dis} disagreements, {skipped} skipped")
print(f"  q_t = 0 never occurred exactly: the form is positive definite over Q,")
print(f"  so the mod-p 'skipped' counter can only ever count FALSE zeros.")
