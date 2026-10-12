"""Reviewer 38: non-vacuity controls -- the identity must FAIL off K(p,q)."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time, random
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
import numpy as np
from fractions import Fraction
from review_r38_core import *
LOG = _os.path.join(_ROOT, 'agent_logs/review_r38_exact.log')
def log(m):
    open(LOG, 'a').write(time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime()) + ' ' + m + '\n')
    print(m, flush=True)
log('P6 controls: generic V in Weyl_n must violate the identity')
for (p, q) in [(3, 3), (4, 3), (4, 4), (5, 3)]:
    n = p + q
    A = structure_constants(n); N = A.shape[0]
    Ip = I_p_matrix(n, p)
    cols, ncols = sym_vars(N)
    rows = bianchi_rows(n, cols, ncols) + ricci_rows(n, cols, ncols)
    nb = nullspace(rows, ncols)
    rng = random.Random(5)
    viol = 0; tot = 0
    for _ in range(5):
        v = [Fraction(0)] * ncols
        for b in nb:
            c = rng.randint(-3, 3)
            if c: v = [x + c * y for x, y in zip(v, b)]
        M = mat_from_vec(v, cols, N)
        Vi, _ = to_int_matrix(M)
        tot += 1
        D = sharp_bilin_int(A, Ip, Vi) + 2 * Vi
        if np.any(D != 0): viol += 1
    log(f'  ({p},{q}): dim Weyl_n={len(nb)}, generic elements violating the identity: {viol}/{tot}')
    # also: I_p itself, and the sphere-product-free control I_q
    Iq = np.zeros((N, N), dtype=np.int64)
    pairs, idx = pair_data(n); cl = plane_class(pairs, p)
    for a in range(N):
        if cl[a] == 'QQ': Iq[a, a] = 1
