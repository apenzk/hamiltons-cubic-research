"""Reviewer 181, claim 1b: an INDEPENDENT ground truth for the Weyl module
itself, at n = 4, valid in every degree.

At n=4, W_4 = W^+ (+) W^-, each a copy of Sym^2_0(R^3), and the covering
SU(2)xSU(2) -> SO(4) makes SO(4) act as SO(3) x SO(3), one factor on each
summand.  Hence
      C[W_4]^{SO(4)} = C[a2,a3] (x) C[b2,b3],   deg a2=b2=2, deg a3=b3=3,
with a_i = tr(X^i) on the self-dual part and b_i on the anti-self-dual part
(the SO(3)-invariants of traceless symmetric 3x3 matrices are free on tr X^2,
tr X^3).  An element of O(4)^- interchanges Lambda^2_+ and Lambda^2_-, hence
swaps a_i <-> b_i.  So

  dim (Sym^k W_4)^{O(4)}  = dim of the swap-INVARIANT part,
  det-twisted multiplicity = dim of the swap-ANTIinvariant part,

and Molien for the order-2 group gives closed Hilbert series
  invariant     : 1/2 [ 1/((1-q^2)^2 (1-q^3)^2) + 1/((1-q^4)(1-q^6)) ]
  anti-invariant: 1/2 [ 1/((1-q^2)^2 (1-q^3)^2) - 1/((1-q^4)(1-q^6)) ]
No Lie-theory code is involved.
"""
import sys, os
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'r180'))
from wtlib import *
from coset_o import coset_integral
from dominant_sym import sym_invariants

K = 14

def series(dens, K):
    """1/prod(1-q^d) coefficients up to q^K."""
    c = [0]*(K+1); c[0] = 1
    for d in dens:
        for x in range(d, K+1):
            c[x] += c[x-d]
    return c

A = series([2,2,3,3], K)     # SO(4)-invariants
B = series([4,6], K)         # Molien of the swap on the same ring
inv  = [(A[k]+B[k])//2 for k in range(K+1)]
anti = [(A[k]-B[k])//2 for k in range(K+1)]
assert all((A[k]+B[k]) % 2 == 0 for k in range(K+1))

so  = sym_invariants(2, 'D', False, K)
cos = coset_integral(2, K)
O   = [(a+b)//2 for a, b in zip(so, cos)]
T   = [(a-b)//2 for a, b in zip(so, cos)]

print('k                 :', list(range(1, K+1)))
print('code   SO(4)      :', so)
print('theory SO(4)      :', A[1:])
print('code   O(4)       :', O)
print('theory O(4)       :', inv[1:])
print('code   det-twisted:', T)
print('theory det-twisted:', anti[1:])
ok = (so == A[1:]) and (O == inv[1:]) and (T == anti[1:])
print('\nn=4 INDEPENDENT GROUND TRUTH:', 'AGREES in all degrees 1..%d' % K if ok else '*** DISAGREES ***')
