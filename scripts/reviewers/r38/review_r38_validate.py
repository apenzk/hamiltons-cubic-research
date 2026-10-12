"""Reviewer 38 phase P1: validate the from-scratch implementation."""
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

log('P1 validate: structure constants Jacobi/antisymmetry')
for n in [4, 5, 6]:
    verify_structure_constants(n)
    log(f'  n={n}: c_abc totally antisymmetric, Jacobi/closure OK')

log('P1 validate: dim Weyl_n vs n(n+1)(n+2)(n-3)/12')
for n in range(4, 10):
    d = dim_weyl(n)
    f = n * (n + 1) * (n + 2) * (n - 3) // 12
    log(f'  n={n}: computed {d}, formula {f}, match={d == f}')
    assert d == f

log('P1 validate: sharp_bilin sanity')
# sharp_bilin should be symmetric in (a,b) by construction and bilinear-symmetric in X,Y
n = 5
A = structure_constants(n)
N = A.shape[0]
rng = np.random.default_rng(0)
X = rng.integers(-3, 4, (N, N)); X = X + X.T
Y = rng.integers(-3, 4, (N, N)); Y = Y + Y.T
S1 = sharp_bilin_int(A, X, Y)
S2 = sharp_bilin_int(A, Y, X)
log(f'  sharp symmetric matrix: {np.array_equal(S1, S1.T)}')
log(f'  sharp_bilin(X,Y)==sharp_bilin(Y,X): {np.array_equal(S1, S2)}')

# Check sharp_bilin against the classical index formula for the # product:
#   cand_{ijkl} = sum_{s,t} ( X_{iskt} Y_{jslt} - X_{islt} Y_{jskt} + (X<->Y) )
# fitted against 4*sharp = -(T+T^T).
def index_formula(n, X, Y):
    pairs, idx = pair_data(n)
    N = len(pairs)
    def ent(M, i, j, k, l):
        s1 = signed(idx, i, j); s2 = signed(idx, k, l)
        if s1 is None or s2 is None: return 0
        return s1[1] * s2[1] * M[s1[0], s2[0]]
    out = np.zeros((N, N), dtype=np.int64)
    for a, (i, j) in enumerate(pairs):
        for b, (k, l) in enumerate(pairs):
            tot = 0
            for s in range(n):
                for t in range(n):
                    tot += ent(X, i, s, k, t) * ent(Y, j, s, l, t)
                    tot -= ent(X, i, s, l, t) * ent(Y, j, s, k, t)
                    tot += ent(Y, i, s, k, t) * ent(X, j, s, l, t)
                    tot -= ent(Y, i, s, l, t) * ent(X, j, s, k, t)
            out[a, b] = tot
    return out

C = index_formula(n, X, Y)
nz = np.nonzero(C)
ratios = set()
ok = True
for a, b in zip(*nz):
    if C[a, b] != 0:
        r = (S1[a, b], C[a, b])
        ratios.add((4 * S1[a, b], C[a, b]))
# fit scalar
import fractions
rs = set()
for a in range(N):
    for b in range(N):
        if C[a, b] != 0:
            rs.add(fractions.Fraction(int(S1[a, b]), int(C[a, b])))
        elif S1[a, b] != 0:
            ok = False
log(f'  index-formula ratios 4*sharp/cand = {rs}; zeros consistent={ok}')
log('P1 validate: DONE')
