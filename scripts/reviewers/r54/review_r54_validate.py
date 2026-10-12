"""Phase 1: validate the independent core against definition-level facts."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time
import numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r54_core import (pairs_of, struct, Q, circ, P, dim_weyl, weyl_basis,
                             Le_matrix, orbit_tangent, onb_rows, slack_structural,
                             ricci_of, bianchi_of, theta0, phi_basis)

rng = np.random.default_rng(54)

print("--- 1. structure constants totally antisymmetric ---")
for n in (5, 6, 7):
    c = struct(n)
    print(f" n={n}: |c+c.T(ab)|={np.abs(c+c.transpose(1,0,2)).max():.1e} "
          f"|c+c.T(bg)|={np.abs(c+c.transpose(0,2,1)).max():.1e} "
          f"|c-c.cyc|={np.abs(c-c.transpose(1,2,0)).max():.1e}")

print("--- 2. Q on coordinate-diagonal operators vs known formula ---")
for n in (5, 6, 7):
    ps, idx = pairs_of(n)
    N = len(ps)
    lam = rng.normal(size=N)
    W = np.diag(lam)
    QW = Q(n, W)
    err = 0.0
    for a, (i, j) in enumerate(ps):
        known = lam[a] ** 2
        for k in range(n):
            if k in (i, j):
                continue
            known += lam[idx[(min(i,k),max(i,k))]] * lam[idx[(min(j,k),max(j,k))]]
        err = max(err, abs(QW[a, a] - known))
    off = np.abs(QW - np.diag(np.diag(QW))).max()
    print(f" n={n}: max diag err={err:.2e}  max offdiag={off:.2e}")

print("--- 3. dim Weyl_n = n(n+1)(n+2)(n-3)/12 ---")
for n in (6, 7, 8, 9, 10):
    B = weyl_basis(n)
    print(f" n={n}: dim={len(B)}  formula={dim_weyl(n)}  {'OK' if len(B)==dim_weyl(n) else 'MISMATCH'}")

print("--- 4. trilinear symmetry T(X,Y,Z)=<X, Y o Z> ---")
for n in (5, 6):
    N = n*(n-1)//2
    X, Y, Z = [rng.normal(size=(N, N)) for _ in range(3)]
    X, Y, Z = [(M+M.T)/2 for M in (X, Y, Z)]
    vals = [np.tensordot(X, circ(n, Y, Z)), np.tensordot(Y, circ(n, X, Z)),
            np.tensordot(Z, circ(n, X, Y))]
    print(f" n={n}: {vals[0]:.10f} {vals[1]:.10f} {vals[2]:.10f}  spread={max(vals)-min(vals):.2e}")

print("--- 5. tr(L_x) = 0 on Weyl_n ---")
for n in (6, 7, 8):
    B = weyl_basis(n)
    x = np.einsum('d,dij->ij', rng.normal(size=len(B)), B)
    t0 = time.time()
    M = Le_matrix(n, x, B)
    print(f" n={n}: dim={len(B)} tr(L_x)={np.trace(M):.3e}  |x|={np.linalg.norm(x):.3f}  ({time.time()-t0:.1f}s)")

print("--- 6. L_e W = W at a known critical point (balanced sphere product) ---")
def sphere_W(blocks):
    n = sum(blocks); ps, idx = pairs_of(n)
    lab = []
    for bi, b in enumerate(blocks): lab += [bi]*b
    N = len(ps); W = np.zeros((N, N))
    for a, (i, j) in enumerate(ps):
        if lab[i] == lab[j]:
            p = blocks[lab[i]]; W[a,a] = 1.0/(p*(p-1))
        else:
            p, q = blocks[lab[i]], blocks[lab[j]]; W[a,a] = -1.0/(p*q)
    return W

for blocks in [(3,3),(4,4),(3,5)]:
    n = sum(blocks)
    W = sphere_W(blocks); W /= np.linalg.norm(W)
    th = P(n, W); res = np.linalg.norm(Q(n, W) - th*W)
    print(f" {blocks}: theta={th:.9f} theta_0={theta0(n):.9f} ratio={th/theta0(n):.6f} "
          f"resid={res:.1e} |Ric|={np.abs(ricci_of(n,W)).max():.1e} |Bianchi|={np.abs(bianchi_of(n,W)).max():.1e}")
    B = weyl_basis(n)
    M = Le_matrix(n, W/th, B)
    wv = np.einsum('kmn,mn->k', B, W); wv /= np.linalg.norm(wv)
    print(f"      |L_e W - W| in basis coords = {np.linalg.norm(M@wv - wv):.2e}")
    ev = np.linalg.eigvalsh(M)
    print(f"      L_e spectrum: max={ev[-1]:.6f}  count(=1/2)={int((np.abs(ev-0.5)<1e-8).sum())} "
          f" orbit dim={onb_rows(orbit_tangent(n,W)).shape[0]}")

print("--- 7. slack: repo adjoint-rep version = (n-2)^2 x structural ---")
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from b_padded_s3s3 import slack as repo_slack
from review_r30_core import adj
for blocks in [(3,3),(3,3,3),(2,2,4),(3,4)]:
    n = sum(blocks)
    W = sphere_W(blocks); W /= np.linalg.norm(W)
    N = n*(n-1)//2
    rs = repo_slack(n, W, adj(n), N)
    ss = slack_structural(n, W)
    ratio = rs/ss if abs(ss) > 1e-12 else float('nan')
    print(f" {blocks} n={n}: repo={rs:.6e} mine={ss:.6e} ratio={ratio:.6f} (n-2)^2={(n-2)**2}")
