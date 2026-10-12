"""Reviewer 38: full-basis exhaustive identity check at n = 12..16."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
import numpy as np
from review_r38_core import *
from review_r38_e4 import S_basis_from_t
LOG = _os.path.join(_ROOT, 'agent_logs/review_r38_exact.log')
def log(m):
    open(LOG, 'a').write(time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime()) + ' ' + m + '\n')
    print(m, flush=True)
def Xd(m): return m * (m * m - 4) // 3
log('P4 D: FULL-basis exhaustive check, n = 12..16')
for (p, q) in [(8, 4), (5, 7), (3, 9), (9, 4), (6, 8), (11, 4), (5, 11), (8, 8)]:
    n = p + q
    t0 = time.time()
    A = structure_constants(n); N = A.shape[0]
    Ip = I_p_matrix(n, p)
    mats = S_basis_from_t(n, p)
    fails = 0
    for V in mats:
        if np.any(sharp_bilin_int(A, Ip, V) + 2 * V != 0): fails += 1
    log(f'  ({p},{q}) n={n}: dim={len(mats)} X(p)q={Xd(p)*q} entries/vector={N*N} '
        f'total entries checked={len(mats)*N*N} failures={fails} [{time.time()-t0:.0f}s]')
