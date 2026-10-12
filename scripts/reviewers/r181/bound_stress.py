"""Reviewer 181, claim 1d: the dominant-weight TRUNCATION is the one place the
r180 code could silently lose mass at larger rank.

Both halves store h_k only on dominant weights with l1-norm <= 4k.  That bound
is provable (every weight of W on either torus has l1-norm <= 4, since
W < Sym^2 Lambda^2 V and every Lambda^2 weight has l1-norm <= 2), but a proof is
worth an experiment: re-run the whole n=12 computation with the bound widened to
BK, and check that nothing new appears.
"""
import sys, os, time
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'r180'))
from wtlib import *
from coset_o import coset_weyl_char
from dominant_sym import dominant_set

t0 = time.time()
r = int(sys.argv[1]); K = int(sys.argv[2]); B = int(sys.argv[3])

def log(*a): print('[%6.1fs]' % (time.time()-t0), *a, flush=True)

def sym_inv(r, typ, kmax, B):
    ch = char_weyl(r, typ == 'B')
    dominate = dominant_D if typ == 'D' else dominant_B
    p = {j: adams(ch, j) for j in range(1, kmax+1)}
    plist = {j: list(p[j].items()) for j in p}
    h = {0: {tuple([0]*r): 1}}
    for k in range(1, kmax+1):
        cur = {}
        for mu in dominant_set(r, typ, B*k):
            s = 0
            for j in range(1, k+1):
                hj = h[k-j]
                for nu, c in plist[j]:
                    v = hj.get(dominate(tuple(a-b for a, b in zip(mu, nu))))
                    if v: s += c*v
            if s:
                assert s % k == 0
                cur[mu] = s//k
        h[k] = cur
        log('SO k=%d stored %d (bound %d)' % (k, len(cur), B*k))
    W = weyl_elements(r, typ); rh = rho(r, typ)
    res = []
    for k in range(1, kmax+1):
        tot = 0
        for perm, signs, det in W:
            d = tuple(a-b for a, b in zip(rh, act(rh, perm, signs)))
            if all(float(x).is_integer() for x in d):
                v = h[k].get(dominate(tuple(int(x) for x in d)))
                if v: tot += det*v
        res.append(tot)
    return res

def coset_inv(r, kmax, B):
    m = r-1
    P = coset_weyl_char(r, kmax)
    dominate = lambda w: tuple(sorted((abs(x) for x in w), reverse=True))
    plist = {j: list(P[j].items()) for j in P}
    h = {0: {(0,)*m: 1}}
    for k in range(1, kmax+1):
        cur = {}
        for mu in dominant_set(m, 'B', B*k):
            s = 0
            for j in range(1, k+1):
                hj = h[k-j]
                for nu, c in plist[j]:
                    v = hj.get(dominate(tuple(a-b for a, b in zip(mu, nu))))
                    if v: s += c*v
            if s:
                assert s % k == 0
                cur[mu] = s//k
        h[k] = cur
        log('coset k=%d stored %d (bound %d)' % (k, len(cur), B*k))
    WC = weyl_elements(m, 'B'); rhoC = tuple(m-i for i in range(m))
    out = []
    for k in range(1, kmax+1):
        tot = 0
        for perm, signs, det in WC:
            d = tuple(a-b for a, b in zip(rhoC, act(rhoC, perm, signs)))
            v = h[k].get(dominate(d))
            if v: tot += det*v
        out.append(tot)
    return out

so = sym_inv(r, 'D', K, B)
log('n=%d bound=%dk  SO %s' % (2*r, B, so))
cos = coset_inv(r, K, B)
log('n=%d bound=%dk  coset %s' % (2*r, B, cos))
print('n=%d bound=%dk  O %s   twisted %s'
      % (2*r, B, [(a+b)//2 for a, b in zip(so, cos)], [(a-b)//2 for a, b in zip(so, cos)]))
