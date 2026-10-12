"""Reviewer 181, claim 1e: the dominant-weight recursion against the BRUTE
full-character route.

dominant_sym.sym_invariants and coset_o.coset_integral both carry Newton's
recursion on DOMINANT weights only, using h(mu) = h(dom mu).  The brute route
expands the whole character of Sym^k W and applies Racah directly.  Same answer
means the shortcut loses nothing.  Feasible for n = 8 (and n = 6, 4).
"""
import sys, os, time
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'r180'))
from wtlib import *
from coset_o import coset_weyl_char, coset_integral
from dominant_sym import sym_invariants

t0 = time.time()
r = int(sys.argv[1]); K = int(sys.argv[2])
m = r-1

# ---- SO half, brute
ch = char_weyl(r, False)
mulf = (lambda a, b: np_mul(a, b, r))
p = {j: adams(ch, j) for j in range(1, K+1)}
h = {0: {tuple([0]*r): 1}}
for k in range(1, K+1):
    acc = {}
    for j in range(1, k+1):
        acc = add(acc, mulf(p[j], h[k-j]))
    h[k] = divide(acc, k)
    print('[%6.1fs] SO brute k=%d  full support %d' % (time.time()-t0, k, len(h[k])), flush=True)
W = weyl_elements(r, 'D'); rh = rho(r, 'D')
so_brute = [trivial_multiplicity(h[k], r, 'D', W, rh) for k in range(1, K+1)]
so_fast = sym_invariants(r, 'D', False, K)
print('n=%d SO brute %s' % (2*r, so_brute))
print('n=%d SO fast  %s   %s' % (2*r, so_fast, 'OK' if so_brute == so_fast else '*** DIFFER ***'))

# ---- coset half, brute
P = coset_weyl_char(r, K)
hc = {0: {(0,)*m: 1}}
for k in range(1, K+1):
    acc = {}
    for j in range(1, k+1):
        acc = add(acc, np_mul(P[j], hc[k-j], m) if m else mul(P[j], hc[k-j]))
    hc[k] = divide(acc, k)
    print('[%6.1fs] coset brute k=%d  full support %d' % (time.time()-t0, k, len(hc[k])), flush=True)
WC = weyl_elements(m, 'B'); rhoC = tuple(m-i for i in range(m))
dominate = lambda w: tuple(sorted((abs(x) for x in w), reverse=True))
cos_brute = []
for k in range(1, K+1):
    tot = 0
    for perm, signs, det in WC:
        d = tuple(a-b for a, b in zip(rhoC, act(rhoC, perm, signs)))
        tot += det*hc[k].get(d, 0)          # NOTE: raw lookup, no dominance folding
    cos_brute.append(tot)
cos_fast = coset_integral(r, K)
print('n=%d coset brute %s' % (2*r, cos_brute))
print('n=%d coset fast  %s   %s' % (2*r, cos_fast, 'OK' if cos_brute == cos_fast else '*** DIFFER ***'))
print('n=%d O  brute %s' % (2*r, [(a+b)//2 for a, b in zip(so_brute, cos_brute)]))
print('n=%d tw brute %s' % (2*r, [(a-b)//2 for a, b in zip(so_brute, cos_brute)]))
