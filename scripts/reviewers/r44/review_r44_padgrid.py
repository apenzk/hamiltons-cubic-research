"""Reviewer 44 -- excess as a function of the padding target n."""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r44_core import *
from review_r44_catalogue import measure, cpm_W, log

fams = []
for kl in [(2,2),(2,3),(2,4),(3,3),(3,4),(3,5),(4,4),(4,6),(5,5),(5,7),(6,6)]:
    fams.append((sphere_product_W(kl), sum(kl), f'S{kl[0]}xS{kl[1]}'))
for m in (2,3,4):
    fams.append((cpm_W(m), 2*m, f'CP{m}'))
NMAX = int(sys.argv[1]) if len(sys.argv) > 1 else 14
for W, n0, lab in fams:
    line = []
    for n in range(n0, NMAX+1):
        t0=time.time(); r = measure(W, n0, n, lab)
        line.append(f'n={n}:th={r["theta"]:.6f}({r["ratio"]:.3f}) S={r["S"]:+.0e} orb={r["orbit"]} E={r["half"]} exc={r["excess"]}')
    log(f'[grid {lab}] ' + ' | '.join(line))
