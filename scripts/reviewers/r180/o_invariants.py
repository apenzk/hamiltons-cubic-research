"""dim (Sym^k W_n)^{O(n)} at EVEN n, combining the SO(n) count with the
integral over the non-identity component."""
import sys, os, time
sys.path.insert(0, os.path.dirname(__file__))
from wtlib import *
from coset_o import coset_integral
from dominant_sym import sym_invariants

t0 = time.time()
r = int(sys.argv[1]); K = int(sys.argv[2])
so = sym_invariants(r, 'D', False, K)
print('[%5.1fs] n=%d  SO(n): %s' % (time.time()-t0, 2*r, so), flush=True)
cos = coset_integral(r, K)
print('[%5.1fs] n=%d  coset: %s' % (time.time()-t0, 2*r, cos), flush=True)
print('n=%d  O(n)-invariants of Sym^k, k=1..%d : %s'
      % (2*r, K, [(a+b)//2 for a, b in zip(so, cos)]))
print('     det-twisted (chiral) multiplicities  : %s'
      % [(a-b)//2 for a, b in zip(so, cos)])
