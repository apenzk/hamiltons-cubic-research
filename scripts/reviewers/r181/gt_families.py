"""Reviewer 181, claim 1a: THEOREM-BACKED ground truth for the coset method,
at every rank the machine can reach -- not just r=4.

Three O(n)-modules whose full invariant ring is a classical theorem:

  V = C^n              C[V]^{O(n)} = C[|x|^2]                      (free, deg 2)
  Sym^2 V              C[Sym^2 V]^{O(n)} = C[tr X, ..., tr X^n]    (free, deg 1..n)
  Lambda^2 V = so(n)   C[so(2r)]^{O(2r)} = C[tr X^2, ..., tr X^2r] (free, deg 2,4,..,2r)

For each, the det-twisted multiplicity is 0 in every degree: none of the three
rings gains a generator on passing from O(n) to SO(n) invariants that is
det-odd -- for Sym^2 V and V the SO- and O-invariants coincide, and for so(2r)
the extra SO-generator is the Pfaffian, which is det-EVEN... no: the Pfaffian is
det-ODD, so Lambda^2 supplies a nonzero twisted count and tests the sign too.

  twisted multiplicity for Lambda^2 = (# partitions of k using 2,4,..,2r-2 and
  one Pfaffian of degree r, an odd number of times).
"""
import sys, os, time
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'r180'))
from wtlib import *
from coset_o import coset_q, coset_integral_generic

t0 = time.time()

def npart(k, parts):
    dp = [0]*(k+1); dp[0] = 1
    for p in parts:
        for x in range(p, k+1):
            dp[x] += dp[x-p]
    return dp[k]

def hilb_pfaff(k, r):
    """SO(2r)-invariants of so(2r): free on p_2..p_{2r-2} (deg 2,4,..,2r-2) and
    Pf (deg r).  Split by parity of the Pfaffian exponent."""
    base = [0]*(k+1)
    for x in range(k+1):
        base[x] = npart(x, list(range(2, 2*r-1, 2)))
    even = sum(base[k-j*r] for j in range(0, k//r+1) if j % 2 == 0)
    odd  = sum(base[k-j*r] for j in range(0, k//r+1) if j % 2 == 1)
    return even, odd

def build_V(r, kmax):
    m = r-1
    q = coset_q(m, kmax+1)
    return {k: q[k] for k in range(1, kmax+1)}

def build_S2V(r, kmax):
    m = r-1
    q = coset_q(m, 2*kmax+2)
    return {k: divide(add(mul(q[k], q[k]), q[2*k]), 2) for k in range(1, kmax+1)}

def build_L2(r, kmax):
    m = r-1
    q = coset_q(m, 2*kmax+2)
    return {k: divide(add(mul(q[k], q[k]), q[2*k], -1), 2) for k in range(1, kmax+1)}

def so_counts(ch, r, K):
    W = weyl_elements(r, 'D'); rh = rho(r, 'D')
    return [trivial_multiplicity(sym_power(ch, k), r, 'D', W, rh) for k in range(1, K+1)]

RMAX = int(sys.argv[1]) if len(sys.argv) > 1 else 7
K    = int(sys.argv[2]) if len(sys.argv) > 2 else 6
allok = True
for r in range(2, RMAX+1):
    n = 2*r
    V = char_vector(r, False)
    rows = []
    # --- V ---
    so = so_counts(V, r, K)
    cos = coset_integral_generic(r, K, build_V)
    O = [(a+b)//2 for a, b in zip(so, cos)]; T = [(a-b)//2 for a, b in zip(so, cos)]
    predO = [1 if k % 2 == 0 else 0 for k in range(1, K+1)]; predT = [0]*K
    rows.append(('V      ', so, cos, O, T, predO, predT))
    # --- Sym^2 V ---
    S2 = sym_power(V, 2)
    so = so_counts(S2, r, K)
    cos = coset_integral_generic(r, K, build_S2V)
    O = [(a+b)//2 for a, b in zip(so, cos)]; T = [(a-b)//2 for a, b in zip(so, cos)]
    predO = [npart(k, list(range(1, n+1))) for k in range(1, K+1)]; predT = [0]*K
    rows.append(('Sym^2 V', so, cos, O, T, predO, predT))
    # --- Lambda^2 V ---
    L2 = ext_power_char(V, 2)
    so = so_counts(L2, r, K)
    cos = coset_integral_generic(r, K, build_L2)
    O = [(a+b)//2 for a, b in zip(so, cos)]; T = [(a-b)//2 for a, b in zip(so, cos)]
    predO = [npart(k, list(range(2, n+1, 2))) for k in range(1, K+1)]
    predSO = [hilb_pfaff(k, r)[0] + hilb_pfaff(k, r)[1] for k in range(1, K+1)]
    predT = [hilb_pfaff(k, r)[1] for k in range(1, K+1)]
    rows.append(('Lam^2 V', so, cos, O, T, predO, predT))
    for tag, so, cos, O, T, predO, predT in rows:
        ok = (O == predO and T == predT)
        allok &= ok
        print('[%5.1fs] n=%2d m=%d %s  SO %-22s cos %-22s  O %-22s twist %-16s  want O %-22s twist %-16s  %s'
              % (time.time()-t0, n, r-1, tag, so, cos, O, T, predO, predT, 'OK' if ok else '*** FAIL ***'), flush=True)
    # extra: SO count for Lambda^2 must match the Pfaffian-graded prediction
    ok2 = so_counts(ext_power_char(V, 2), r, K) == predSO
    allok &= ok2
    print('           n=%2d  SO(2r) count for Lambda^2 vs free-on-(p_2..p_2r-2, Pf): %s' % (n, 'OK' if ok2 else '*** FAIL ***'), flush=True)
print('\nALL GROUND-TRUTH FAMILIES AGREE' if allok else '\nDISAGREEMENT FOUND')
