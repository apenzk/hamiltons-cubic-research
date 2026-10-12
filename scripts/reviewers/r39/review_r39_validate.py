"""Reviewer 39 phase 1: validate the from-scratch implementation."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time
import numpy as np
from itertools import combinations
from fractions import Fraction as F
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r39_core import (pair_list, struct, sharp_bilin, nullspace, weyl_rows,
                             all_vars, to_matrix)

def log(msg):
    with open(_os.path.join(_ROOT, 'agent_logs/review_r39_exact.log'),'a') as f:
        f.write(time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime()) + '  ' + msg + '\n')
    print(msg, flush=True)

# --- 1. structure constants: total antisymmetry + Jacobi + so(N) rep -----------
for n in (4,5,6,7):
    pr, idx, c = struct(n)
    N = len(pr)
    assert np.array_equal(c, -c.transpose(1,0,2)), n
    assert np.array_equal(c, -c.transpose(0,2,1)), ('antisym in last two', n)
    assert np.array_equal(c, c.transpose(1,2,0)), ('cyclic', n)
    # Jacobi via matrices A_a
    A = c
    ok = True
    for a in range(min(N,8)):
        for b in range(min(N,8)):
            comm = A[a]@A[b] - A[b]@A[a]
            tgt = -np.tensordot(c[a,b], A, axes=([0],[0]))  # A_a = ad(phi_a)^T = -ad(phi_a)
            if not np.array_equal(comm, tgt): ok=False
    assert ok, ('Jacobi/rep', n)
log('VALIDATE 1 OK: c totally antisymmetric; A_a = -ad(phi_a) so [A_a,A_b] = -c_abd A_d (n=4..7). Sign is immaterial to sharp_bilin, which is quadratic in A.')

# --- 2. dim Weyl_n ------------------------------------------------------------
res=[]
for n in range(4,9):
    pr, idx, c = struct(n); N=len(pr)
    cols = all_vars(N)
    bi, ric = weyl_rows(n, idx, set(cols))
    ns = nullspace(bi+ric, cols)
    pred = n*(n+1)*(n+2)*(n-3)//12
    res.append((n, len(ns), pred, len(bi), len(ric)))
    assert len(ns)==pred, (n, len(ns), pred)
log('VALIDATE 2 OK: dim Weyl_n = n(n+1)(n+2)(n-3)/12  ' + str([(r[0],r[1]) for r in res]))
log('   (#Bianchi,#Ricci) rows: ' + str([(r[0],r[3],r[4]) for r in res]))

# --- 3. diagonal # formula ---------------------------------------------------
rng = np.random.default_rng(0)
for n in (5,6,7):
    pr, idx, c = struct(n); N=len(pr)
    x = rng.integers(-4,5,size=(n,n)); x = x+x.T; np.fill_diagonal(x,0)
    y = rng.integers(-4,5,size=(n,n)); y = y+y.T; np.fill_diagonal(y,0)
    X = np.diag([float(x[i,j]) for (i,j) in pr])
    Y = np.diag([float(y[i,j]) for (i,j) in pr])
    S = sharp_bilin(c, X, Y)
    off = np.abs(S - np.diag(np.diag(S))).max()
    pred = np.array([sum(x[i,k]*y[j,k]+x[j,k]*y[i,k] for k in range(n) if k!=i and k!=j)/2.0
                     for (i,j) in pr])
    err = np.abs(np.diag(S)-pred).max()
    assert off < 1e-9 and err < 1e-9, (n, off, err)
log('VALIDATE 3 OK: on coordinate-diagonal X,Y sharp_bilin is diagonal and equals '
    '(X#Y)_ij = 1/2 sum_k (x_ik y_jk + x_jk y_ik)  [Jaeger/Poljsak formula], n=5,6,7')

# --- 4. sharp_bilin(Id, V) on Weyl_n ------------------------------------------
for n in (5,6):
    pr, idx, c = struct(n); N=len(pr)
    cols = all_vars(N)
    bi, ric = weyl_rows(n, idx, set(cols))
    ns = nullspace(bi+ric, cols)
    V = np.zeros((N,N))
    for k,vec in enumerate(ns[:6]):
        V += float(k+1)*to_matrix(vec, N, dtype=float)
    Id = np.eye(N)
    S = sharp_bilin(c, Id, V)
    ratios = S[np.abs(V)>1e-12]/V[np.abs(V)>1e-12]
    log(f'VALIDATE 4: n={n}  sharp_bilin(Id,V) vs V on Weyl_n: ratio range '
        f'[{ratios.min():.6f},{ratios.max():.6f}]  ||S-(n-2)/2*V||={np.abs(S-(n-2)/2*V).max():.3e}')
log('PHASE 1 COMPLETE')
