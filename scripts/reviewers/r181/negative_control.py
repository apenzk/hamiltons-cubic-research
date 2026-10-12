"""Reviewer 181, claim 1f: do the checks have TEETH?

A validation suite is worth nothing unless a wrong coset formula fails it.
Perturb the three ingredients of the coset Weyl integration one at a time and
confirm the Lambda^2 ground truth (partitions into even parts <= n) breaks:

  rho_C = (m, m-1, ..., 1)      -> rho_B = (m-1/2, ..., 1/2)   [wrong root system]
  W(C_m) = all signed perms     -> W(D_m) = even sign changes   [wrong Weyl group]
  coset eigenvalues {t,1/t,1,-1}-> {t,1/t,1,1}                  [wrong component]
"""
import sys, os
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'r180'))
from wtlib import *
from coset_o import coset_q
from dominant_sym import dominant_set
from fractions import Fraction

def npart(k, parts):
    dp = [0]*(k+1); dp[0] = 1
    for p in parts:
        for x in range(p, k+1):
            dp[x] += dp[x-p]
    return dp[k]

def coset_integral_var(r, kmax, rho_kind='C', wg='B', minus=True):
    m = r-1
    # Lambda^2 character on the coset, with an optional wrong component element
    q = {}
    for k in range(1, 2*kmax+3):
        d = {}
        for j in range(m):
            for s in (k, -k):
                w = [0]*m; w[j] = s
                d[tuple(w)] = d.get(tuple(w), 0) + 1
        z = tuple([0]*m)
        d[z] = d.get(z, 0) + 1 + ((-1)**k if minus else 1)
        q[k] = {w: c for w, c in d.items() if c}
    P = {k: divide(add(mul(q[k], q[k]), q[2*k], -1), 2) for k in range(1, kmax+1)}
    dominate = lambda w: tuple(sorted((abs(x) for x in w), reverse=True))
    plist = {j: list(P[j].items()) for j in P}
    h = {0: {(0,)*m: 1}}
    for k in range(1, kmax+1):
        cur = {}
        for mu in dominant_set(m, 'B', 2*k+2):
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
    Wg = weyl_elements(m, wg)
    rh = tuple(m-i for i in range(m)) if rho_kind == 'C' else tuple(Fraction(2*(m-i)-1, 2) for i in range(m))
    out = []
    for k in range(1, kmax+1):
        tot = 0
        for perm, signs, det in Wg:
            d = tuple(a-b for a, b in zip(rh, act(rh, perm, signs)))
            if all(Fraction(x).denominator == 1 for x in d):
                v = h[k].get(dominate(tuple(int(x) for x in d)))
                if v: tot += det*v
        out.append(tot)
    return out

K = 6
for r in (4, 6):
    n = 2*r
    V = char_vector(r, False); L2 = ext_power_char(V, 2)
    W = weyl_elements(r, 'D'); rh = rho(r, 'D')
    so = [trivial_multiplicity(sym_power(L2, k), r, 'D', W, rh) for k in range(1, K+1)]
    truth = [npart(k, list(range(2, n+1, 2))) for k in range(1, K+1)]
    variants = [('as published  (rho_C, W(C_m), det=-1)', dict(rho_kind='C', wg='B', minus=True)),
                ('rho_B instead of rho_C              ', dict(rho_kind='B', wg='B', minus=True)),
                ('W(D_m) instead of W(C_m)            ', dict(rho_kind='C', wg='D', minus=True)),
                ('identity component element          ', dict(rho_kind='C', wg='B', minus=False))]
    print('n=%2d   Lambda^2 ground truth (partitions into even parts <= %d) = %s' % (n, n, truth))
    for tag, kw in variants:
        cos = coset_integral_var(r, K, **kw)
        O = [(a+b)/2 for a, b in zip(so, cos)]
        ok = O == [float(x) for x in truth] or O == truth
        print('   %s coset %-24s -> O %-26s %s' % (tag, cos, O, 'MATCHES' if ok else 'fails (good)'))
    print()
