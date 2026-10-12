"""Reviewer 38: Phi_p, Phi_q, Phi_mix on S(p,q), and sharp_bilin(Id,V) = -V on Weyl_n."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time, random
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
import numpy as np
from fractions import Fraction
from review_r38_core import *
from review_r38_e4 import S_basis_from_t
LOG = _os.path.join(_ROOT, 'agent_logs/review_r38_exact.log')
def log(m):
    open(LOG, 'a').write(time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime()) + ' ' + m + '\n')
    print(m, flush=True)
log('P6b: Phi_p / Phi_q / Phi_mix on S(p,q); sharp_bilin(Id,.) on Weyl_n')
for (p, q) in [(3, 3), (4, 3), (4, 4), (5, 4), (6, 3), (7, 4)]:
    n = p + q
    A = structure_constants(n); N = A.shape[0]
    pairs, idx = pair_data(n); cl = plane_class(pairs, p)
    Ip = np.diag([1 if c == 'PP' else 0 for c in cl]).astype(np.int64)
    Iq = np.diag([1 if c == 'QQ' else 0 for c in cl]).astype(np.int64)
    Im = np.diag([1 if c == 'MX' else 0 for c in cl]).astype(np.int64)
    Id = np.eye(N, dtype=np.int64)
    mats = S_basis_from_t(n, p)
    bp = bq = bm = 0
    for V in mats:
        if np.any(sharp_bilin_int(A, Ip, V) + 2 * V != 0): bp += 1
        if np.any(sharp_bilin_int(A, Iq, V) != 0): bq += 1
        if np.any(sharp_bilin_int(A, Im, V) + 2 * V != 0): bm += 1
    # sharp(Id, V) = -V on the whole of Weyl_n (random exact elements)
    cols, ncols = sym_vars(N)
    rows = bianchi_rows(n, cols, ncols) + ricci_rows(n, cols, ncols)
    nb = nullspace(rows, ncols); rng = random.Random(9)
    bad_id = 0
    for _ in range(3):
        v = [Fraction(0)] * ncols
        for b in nb:
            c = rng.randint(-3, 3)
            if c: v = [x + c * y for x, y in zip(v, b)]
        M, _ = to_int_matrix(mat_from_vec(v, cols, N))
        if np.any(sharp_bilin_int(A, Id, M) + 4 * M != 0): bad_id += 1
    log(f'  ({p},{q}) dim S={len(mats)}: Phi_p=-1/2 fails {bp}, Phi_q=0 fails {bq}, '
        f'Phi_mix=-1/2 fails {bm}; sharp(Id,V)=-V on Weyl_n fails {bad_id}/3')
