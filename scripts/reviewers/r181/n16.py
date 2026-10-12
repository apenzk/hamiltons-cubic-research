"""Reviewer 181: is O(n) degree 6 really stable at 89?  Push to n=16.
weyl_elements(8,'D') is 5.16M tuples, so the SO Racah sum streams."""
import sys, os, time
from itertools import permutations, product
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'r180'))
from wtlib import *
from coset_o import coset_integral
from dominant_sym import dominant_set

t0 = time.time()
def log(*a): print('[%7.1fs]' % (time.time()-t0), *a, flush=True)
r = int(sys.argv[1]); K = int(sys.argv[2])

ch = char_weyl(r, False)
p = {j: adams(ch, j) for j in range(1, K+1)}
plist = {j: list(p[j].items()) for j in p}
log('char_weyl support %d ; dominant_set sizes' % len(ch),
    [len(dominant_set(r, 'D', 4*k)) for k in range(1, K+1)])
h = {0: {tuple([0]*r): 1}}
for k in range(1, K+1):
    cur = {}
    for mu in dominant_set(r, 'D', 4*k):
        s = 0
        for j in range(1, k+1):
            hj = h[k-j]
            for nu, c in plist[j]:
                v = hj.get(dominant_D(tuple(a-b for a, b in zip(mu, nu))))
                if v: s += c*v
        if s:
            assert s % k == 0
            cur[mu] = s//k
    h[k] = cur
    log('SO k=%d stored %d' % (k, len(cur)))

rh = rho(r, 'D')
tot = [0]*(K+1)
def perm_sign(perm):
    seen = [False]*r; sgn = 1
    for i in range(r):
        if not seen[i]:
            j = i; ln = 0
            while not seen[j]:
                seen[j] = True; j = perm[j]; ln += 1
            if ln % 2 == 0: sgn = -sgn
    return sgn
for perm in permutations(range(r)):
    ps = perm_sign(perm)
    for signs in product((1, -1), repeat=r):
        if signs.count(-1) % 2: continue
        d = tuple(int(rh[i] - signs[i]*rh[perm[i]]) for i in range(r))
        key = dominant_D(d)
        for k in range(1, K+1):
            v = h[k].get(key)
            if v: tot[k] += ps*v
so = tot[1:]
log('n=%d SO %s' % (2*r, so))
cos = coset_integral(r, K)
log('n=%d coset %s' % (2*r, cos))
print('n=%d  O %s   twisted %s' % (2*r, [(a+b)//2 for a, b in zip(so, cos)],
                                   [(a-b)//2 for a, b in zip(so, cos)]))
