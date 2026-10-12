"""Reviewer 38 phase P3: E2 -- sharp_bilin(I_p, V) = -V/2 on S(p,q), EVERY entry."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
import numpy as np
from fractions import Fraction
from review_r38_core import *

LOG = _os.path.join(_ROOT, 'agent_logs/review_r38_exact.log')
def log(msg):
    with open(LOG, 'a') as f:
        f.write(time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime()) + ' ' + msg + '\n')
    print(msg, flush=True)

def Xd(m):
    return m * (m * m - 4) // 3

def check_split(p, q, verbose=True):
    n = p + q
    A = structure_constants(n)
    N = A.shape[0]
    Ip = I_p_matrix(n, p)
    pairs, idx = pair_data(n)
    cl = plane_class(pairs, p)
    mats, d = S_space(n, p)
    if d == 0:
        return d, 0, 0, 0
    insup_bad = 0
    offsup_bad = 0
    offsup_checked = 0
    insup_checked = 0
    maxabs = 0
    for V in mats:
        Vi, den = to_int_matrix(V)
        # 4*sharp = -(T+T^T);  target 4*(-V/2) = -2V
        S4 = sharp_bilin_int(A, Ip, Vi)
        D = S4 + 2 * Vi
        maxabs = max(maxabs, int(np.abs(S4).max()), int(np.abs(Vi).max()))
        # classify every entry as in-support or off-support
        for a in range(N):
            for b in range(N):
                insup = ({cl[a], cl[b]} == {'PP', 'MX'})
                if insup:
                    insup_checked += 1
                    if D[a, b] != 0:
                        insup_bad += 1
                else:
                    offsup_checked += 1
                    if D[a, b] != 0:
                        offsup_bad += 1
    return d, insup_bad, offsup_bad, (insup_checked, offsup_checked, maxabs)

splits = []
for p in range(3, 8):
    for q in range(2, 8):
        if 5 <= p + q <= 11:
            splits.append((p, q))
splits.sort(key=lambda pq: (pq[0] + pq[1], pq[0]))

log('P3 E2: exhaustive check over ALL N^2 entries of every basis vector')
fails = []
for (p, q) in splits:
    t0 = time.time()
    d, ib, ob, extra = check_split(p, q)
    if d == 0:
        continue
    ic, oc, mx = extra
    ok = (ib == 0 and ob == 0)
    if not ok:
        fails.append((p, q, ib, ob))
    log(f'  (p,q)=({p},{q}) n={p+q} dim={d}: in-support entries checked {ic} bad {ib}; '
        f'OFF-support entries checked {oc} bad {ob}; max|int| {mx}  [{time.time()-t0:.1f}s]')
log(f'P3 E2 result: failures={fails}')
