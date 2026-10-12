"""Claim 7 / claim 1: dim (Sym^k W_n)^{O(n)} at finite n, cheaply.

h_k is W-invariant, so Newton's recursion  k h_k = sum_j p_j h_{k-j}  can be
carried on DOMINANT weights alone: h_{k-j}(mu - nu) = h_{k-j}(dom(mu - nu)).
Nothing of the size of Sym^k is ever stored -- only ~10^4 dominant values.
"""
import sys, os, time
sys.path.insert(0, os.path.dirname(__file__))
from wtlib import *

t0 = time.time()
def log(*a): print('[%6.1fs]' % (time.time()-t0), *a, flush=True)


def dominant_set(r, typ, bound):
    """All dominant weights with sum of |parts| <= bound."""
    out = []
    def rec(i, prev, acc, s):
        if i == r:
            out.append(tuple(acc))
            if typ == 'D' and acc[-1] > 0:
                out.append(tuple(acc[:-1] + [-acc[-1]]))
            return
        for v in range(min(prev, bound - s), -1, -1):
            rec(i+1, v, acc+[v], s+v)
    rec(0, bound, [], 0)
    return out


def sym_invariants(r, typ, odd, kmax):
    ch = char_weyl(r, odd)
    dominate = dominant_D if typ == 'D' else dominant_B
    p = {j: adams(ch, j) for j in range(1, kmax+1)}
    plist = {j: list(p[j].items()) for j in p}
    zero = tuple([0]*r)
    h = {0: {zero: 1}}
    for k in range(1, kmax+1):
        D = dominant_set(r, typ, 4*k)
        cur = {}
        for mu in D:
            s = 0
            for j in range(1, k+1):
                hj = h[k-j]
                for nu, c in plist[j]:
                    v = hj.get(dominate(tuple(a-b for a, b in zip(mu, nu))))
                    if v:
                        s += c*v
            if s:
                assert s % k == 0
                cur[mu] = s//k
        h[k] = cur
        log('k=%d  dominant weights stored %d' % (k, len(cur)))
    W = weyl_elements(r, typ); rh = rho(r, typ)
    res = []
    for k in range(1, kmax+1):
        tot = 0
        for perm, signs, det in W:
            d = tuple(a-b for a, b in zip(rh, act(rh, perm, signs)))
            if all(float(x).is_integer() for x in d):
                v = h[k].get(dominate(tuple(int(x) for x in d)))
                if v:
                    tot += det*v
        res.append(tot)
    return res


if __name__ == '__main__':
    r = int(sys.argv[1]); odd = (sys.argv[2] == 'odd'); kmax = int(sys.argv[3])
    typ = 'B' if odd else 'D'
    log('n =', 2*r + (1 if odd else 0))
    print('dim (Sym^k W_n)^{O(n)} for k = 1..%d :' % kmax, sym_invariants(r, typ, odd, kmax))
