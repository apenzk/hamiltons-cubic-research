"""K3: what are the S > 0 critical points the long pushes land on at distance ~0.21?"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time
import numpy as np
from scipy.optimize import least_squares, minimize
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r54_core import (Q, P, weyl_basis, Le_matrix, orbit_tangent, slack_structural,
                             struct, phi_basis, theta0)
from review_r54_correct import L_at, make_resid
from review_r54_k1k2 import blowup_W, cycle

W, n, lab = blowup_W([2]*5, cycle(5), 4.0, -2.0, 1.0); W /= np.linalg.norm(W)
th = P(n, W); B = weyl_basis(n)
cW = np.einsum('dmn,mn->d', B, W); cW /= np.linalg.norm(cW)
resid, jacf = make_resid(n, B)

def lm(c0, maxit=45):
    c = c0.copy(); lam = 1e-6
    r = resid(c); f = float(r @ r)
    for _ in range(maxit):
        J = jacf(c); JT = J.T
        Amat = JT @ J; g = JT @ r
        for _ in range(30):
            try:
                step = np.linalg.solve(Amat + lam*np.diag(np.diag(Amat) + 1e-12), -g)
            except np.linalg.LinAlgError:
                lam *= 10; continue
            cn = c + step; rn_ = resid(cn); fn = float(rn_ @ rn_)
            if fn < f:
                c, r, f = cn, rn_, fn; lam = max(lam*0.3, 1e-14); break
            lam *= 10
        else:
            break
        if np.sqrt(f) < 1e-12 or np.linalg.norm(step) < 1e-13:
            break
    return c

rng = np.random.default_rng(77)
D = len(B)
found = []
for trial in range(18):
    v = rng.normal(size=D); v -= (v @ cW)*cW; v /= np.linalg.norm(v)
    c = cW + 0.5*v; c /= np.linalg.norm(c)
    x = lm(c)
    rn = float(np.linalg.norm(resid(x)))
    if rn > 1e-9: continue
    Wn = np.einsum('d,dij->ij', x, B); Wn /= np.linalg.norm(Wn)
    thn = float(np.tensordot(Wn, Q(n, Wn)))
    if thn < 0: Wn, thn = -Wn, -thn
    S = slack_structural(n, Wn)
    cn = np.einsum('dij,ij->d', B, Wn)
    if cn @ cW < 0: cn = -cn
    found.append((thn, S, float(np.linalg.norm(cn-cW)), Wn, rn))
found.sort(key=lambda t: t[2])
print(f"{'theta':>11} {'S':>10} {'|dc|':>8} {'resid':>9} {'#neg':>5} {'#zero':>6} "
      f"{'min|eig|':>10} {'dist to orbit >=':>18}")

def orbit_lower_bound(Wt):
    """Hoffman-Wielandt: |g W g^T - Wt|_F >= |lambda(W) - lambda(Wt)|_2 with both
    spectra sorted, and conjugation preserves the spectrum, so this is a rigorous
    lower bound on the distance from Wt to the whole orbit of W."""
    return float(np.linalg.norm(np.sort(np.linalg.eigvalsh(W)) - np.sort(np.linalg.eigvalsh(Wt))))

seen = set()
for thn, S, dc, Wn, rn in found[:18]:
    key = (round(thn, 6), round(S, 4))
    if key in seen: continue
    seen.add(key)
    ev = np.linalg.eigvalsh(Wn)
    nneg = int((ev < -1e-9).sum()); nzero = int((np.abs(ev) < 1e-9).sum())
    do = orbit_lower_bound(Wn)
    print(f"{thn:>11.6f} {S:>10.4f} {dc:>8.4f} {rn:>9.1e} {nneg:>5} {nzero:>6} "
          f"{np.abs(ev).min():>10.2e} {do:>18.5f}", flush=True)
print(f"\nbase point: theta={th:.6f} S=0 #neg=20 #zero=0 min|eig|={np.abs(np.linalg.eigvalsh(W)).min():.4f}")
