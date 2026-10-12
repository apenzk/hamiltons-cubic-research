"""Reviewer 38: full spectrum of sharp_bilin(I_p,.) on the raw (pp,mix) block."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
import numpy as np
from fractions import Fraction
from review_r38_core import *
from review_r38_e2b import block_operator
LOG = _os.path.join(_ROOT, 'agent_logs/review_r38_exact.log')
def log(m):
    open(LOG, 'a').write(time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime()) + ' ' + m + '\n')
    print(m, flush=True)
def Xd(m): return m * (m * m - 4) // 3
log('P6: exact spectrum of sharp_bilin(I_p,.) on the raw (pp,mix) block')
for (p, q) in [(3, 3), (4, 3), (4, 4), (5, 3), (6, 2)]:
    n = p + q
    Op, sup, pos, leak, N, cols, inv = block_operator(n, p)   # = 4*sharp
    D = len(sup)
    out = []
    for lam in [Fraction(1), Fraction(-1, 2), Fraction(p - 2, 2)]:
        M = [[Fraction(int(Op[i][j])) - (4 * lam if i == j else 0) for j in range(D)] for i in range(D)]
        _, piv = rref(M, D)
        out.append((str(lam), D - len(piv)))
    tot = sum(x[1] for x in out)
    log(f'  ({p},{q}): block dim={D}; multiplicities {out}; sum={tot} '
        f'(predicted C(p,3)q={p*(p-1)*(p-2)//6*q}, X(p)q={Xd(p)*q}, pq={p*q}); '
        f'spectrum complete={tot==D}')
