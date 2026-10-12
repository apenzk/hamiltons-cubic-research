import sys, os
sys.path.insert(0, os.path.dirname(__file__))
from wtlib import *
from coset_o import coset_q, coset_integral_generic, coset_integral
from dominant_sym import sym_invariants

def build_L2(r, kmax):
    m = r-1
    q = coset_q(m, 2*kmax+2)
    return {k: divide(add(mul(q[k], q[k]), q[2*k], -1), 2) for k in range(1, kmax+1)}

def build_V(r, kmax):
    m = r-1
    q = coset_q(m, kmax+1)
    return {k: q[k] for k in range(1, kmax+1)}

for r, K in [(2, 4), (3, 4), (4, 4)]:
    n = 2*r
    ch = ext_power_char(char_vector(r, False), 2)
    so = []
    W = weyl_elements(r, 'D'); rh = rho(r, 'D')
    for k in range(1, K+1):
        so.append(trivial_multiplicity(sym_power(ch, k), r, 'D', W, rh))
    cos = coset_integral_generic(r, K, build_L2)
    O = [(a+b)//2 for a, b in zip(so, cos)]
    # Lambda^2 : O(n)-invariants are the partitions of k into even parts <= n
    def npart(k, parts):
        dp = [0]*(k+1); dp[0] = 1
        for p in parts:
            for x in range(p, k+1):
                dp[x] += dp[x-p]
        return dp[k]
    pred = [npart(k, list(range(2, n+1, 2))) for k in range(1, K+1)]
    print('n=%2d  Lambda^2:  SO %s  coset %s  ->  O %s   predicted %s  %s'
          % (n, so, cos, O, pred, 'OK' if O == pred else 'FAIL'))
