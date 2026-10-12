"""Claim 1: is n >= 4k the right stability threshold?  Compare the O(n) block
table of Sym^3(W_n) at n = 10, 12, 14, 16 (k = 3, so the claim is n >= 12)."""
import sys, os, time
sys.path.insert(0, os.path.dirname(__file__))
from wtlib import *

t0 = time.time()
def log(*a): print('[%7.1fs]' % (time.time()-t0), *a, flush=True)

for r in (int(sys.argv[1]),):
    ch = char_weyl(r, False)
    n = 2*r
    log('n =', n, 'dim W =', dim(ch), 'weights', len(ch))
    h3 = divide(add(add(mul(mul(ch, ch), ch), mul(ch, adams(ch, 2)), 3), adams(ch, 3), 2), 6)
    log('Sym^3 terms', len(h3), 'dim', dim(h3))
    W = weyl_elements(r, 'D'); rh = rho(r, 'D')
    cands = sorted({dominant_D(w) for w in h3}, key=lambda x: (-sum(x), x))
    log('candidates', len(cands), '|W|', len(W))
    blocks = {}
    for lam in cands:
        tot = 0
        for perm, signs, det in W:
            v = h3.get(tuple(a+b-c for a, b, c in zip(lam, rh, act(rh, perm, signs))))
            if v:
                tot += det*v
        if tot:
            blocks[lam] = tot
    log('SO(%d) blocks: %d   total multiplicity %d' % (n, len(blocks), sum(blocks.values())))
    O = {}
    for l, m in blocks.items():
        k = tuple(list(l[:-1])+[abs(l[-1])])
        O[k] = m
    log('O(%d) blocks: %d   total multiplicity %d   unknowns %d   max mult %d'
        % (n, len(O), sum(O.values()), sum(m*(m+1)//2 for m in O.values()), max(O.values())))
    ev = [k for k in O if all(x % 2 == 0 for x in k)]
    log('all-even blocks: %d  sum mult %d' % (len(ev), sum(O[k] for k in ev)))
    log('labels with %d rows: %s' % (r, sorted([k for k in O if k[-1] != 0])))
    print(sorted(O.items(), key=lambda kv: (-sum(kv[0]), kv[0])))
