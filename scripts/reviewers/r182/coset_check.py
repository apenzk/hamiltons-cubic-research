"""Claim 1: exercise the coset integral at the ranks it is ACTUALLY used at.

r180's coset_validate.py checks Lambda^2 at r = 2,3,4 and k <= 4, i.e. the
twisted density for C_1, C_2, C_3.  The O(12) degree-6 number needs C_5 and
k = 6.  Two module families with independently known O(n)-invariant counts are
pushed to r = 6, k = 6 here:

  * the defining rep V: dim Sym^k(V)^{O(n)} = 1 for k even, 0 for k odd
    (the invariants are the powers of |x|^2), for every n >= 1;
  * Lambda^2 V: dim Sym^k(Lambda^2)^{O(n)} = the number of partitions of k
    into even parts of size <= n (the traces tr(A^{2j})).
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "r180"))
from wtlib import *
from coset_o import coset_q, coset_integral_generic
from dominant_sym import sym_invariants

K = 6

def build_V(r, kmax):
    q = coset_q(r-1, kmax+1)
    return {k: q[k] for k in range(1, kmax+1)}

def build_L2(r, kmax):
    q = coset_q(r-1, 2*kmax+2)
    return {k: divide(add(mul(q[k], q[k]), q[2*k], -1), 2) for k in range(1, kmax+1)}

def npart(k, parts):
    dp = [0]*(k+1); dp[0] = 1
    for p in parts:
        for x in range(p, k+1): dp[x] += dp[x-p]
    return dp[k]

print("family      n    SO(n)                     coset                     "
      "O(n)                      predicted                 verdict")
for r in (2, 3, 4, 5, 6):
    n = 2*r
    W = weyl_elements(r, 'D'); rh = rho(r, 'D')
    for name, ch, build, pred in (
            ("V     ", char_vector(r, False), build_V,
             [1 if k % 2 == 0 else 0 for k in range(1, K+1)]),
            ("Lam^2 ", ext_power_char(char_vector(r, False), 2), build_L2,
             [npart(k, list(range(2, n+1, 2))) for k in range(1, K+1)])):
        so = [trivial_multiplicity(sym_power(ch, k), r, 'D', W, rh)
              for k in range(1, K+1)]
        cos = coset_integral_generic(r, K, build)
        O = [(a+b)//2 for a, b in zip(so, cos)]
        print(f"{name} {n:4d}  {str(so):24s}  {str(cos):24s}  {str(O):24s}  "
              f"{str(pred):24s}  {'OK' if O == pred else 'FAIL'}")
