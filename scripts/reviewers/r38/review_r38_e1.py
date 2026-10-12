"""Reviewer 38 phase P2: E1 -- dim S(p,q) = X(p)*q, many splits, both orders."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
import numpy as np
from review_r38_core import *

LOG = _os.path.join(_ROOT, 'agent_logs/review_r38_exact.log')
def log(msg):
    with open(LOG, 'a') as f:
        f.write(time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime()) + ' ' + msg + '\n')
    print(msg, flush=True)

def X(m):
    return m * (m * m - 4) // 3

splits = []
for p in range(2, 8):
    for q in range(2, 8):
        if 4 <= p + q <= 11:
            splits.append((p, q))
splits.sort(key=lambda pq: (pq[0] + pq[1], pq[0]))

log('P2 E1: dim S(p,q) vs X(p)*q')
bad = []
for (p, q) in splits:
    n = p + q
    t0 = time.time()
    mats, d = S_space(n, p)
    pred = X(p) * q
    status = 'OK' if d == pred else 'MISMATCH'
    if d != pred:
        bad.append((p, q, d, pred))
    log(f'  (p,q)=({p},{q}) n={n}: dim S={d}  X(p)*q={pred}  {status}  [{time.time()-t0:.1f}s]')
log(f'P2 E1 result: mismatches={bad}')
