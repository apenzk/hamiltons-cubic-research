"""Reviewer 38: identify the p=3 extra piece, and compute sharp_bilin(I_p,.) on the
S^2_0(R^p) summand as a function of p."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
import numpy as np
from fractions import Fraction
from review_r38_core import *
from review_r38_e2c import kn_product, s20_basis
LOG = _os.path.join(_ROOT, 'agent_logs/review_r38_exact.log')
def log(m):
    open(LOG, 'a').write(time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime()) + ' ' + m + '\n')
    print(m, flush=True)

def s20_summand(n, p, h):
    """V_h = h ? (q g_p - (p-2) g_q); Ricci-flat by construction, in S^2_0(R^p)."""
    q = n - p
    k = np.zeros((n, n), dtype=np.int64)
    for i in range(p): k[i, i] = q
    for i in range(p, n): k[i, i] = -(p - 2)
    return kn_product(n, h, k)

log('P4 E: the S^2_0(R^p) summand and sharp_bilin(I_p, .)')
for (p, q) in [(3, 2), (3, 3), (3, 4), (3, 5), (4, 3), (4, 4), (5, 3), (5, 4), (6, 3), (7, 3)]:
    n = p + q
    A = structure_constants(n); N = A.shape[0]
    Ip = I_p_matrix(n, p)
    pairs, idx = pair_data(n); cl = plane_class(pairs, p)
    hs = s20_basis(n, 0, p)
    ratios = set(); weyl_ok = True; supports = set()
    for h in hs:
        V = s20_summand(n, p, h)
        # Ricci-flat / Bianchi sanity
        S4 = sharp_bilin_int(A, Ip, V)      # = 4*sharp
        # eigenvalue: S4 = 4*lambda*V  ->  lambda = S4/(4V) entrywise
        for a in range(N):
            for b in range(N):
                if V[a, b] != 0:
                    ratios.add(Fraction(int(S4[a, b]), 4 * int(V[a, b])))
                    supports.add((cl[a], cl[b]))
                elif S4[a, b] != 0:
                    ratios.add('NONSCALAR')
    log(f'  ({p},{q}) n={n}: dim S^2_0(R^p)={len(hs)}  sharp(I_p,.) eigenvalue(s)={sorted(ratios, key=str)} '
        f' support classes={sorted(supports)}')
