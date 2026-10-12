"""K3: pushes well past t = 0.4, and directions outside E(1/2), with the same-orbit test."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time
import numpy as np
from scipy.optimize import least_squares
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r54_core import Q, P, weyl_basis, Le_matrix, orbit_tangent, slack_structural
from review_r54_correct import L_at, make_resid
from review_r54_k1k2 import blowup_W, cycle

W, n, lab = blowup_W([2]*5, cycle(5), 4.0, -2.0, 1.0); W /= np.linalg.norm(W)
th = P(n, W); B = weyl_basis(n); D = len(B)
M = Le_matrix(n, W/th, B); ev, V = np.linalg.eigh(M)
E = V[:, np.abs(ev-0.5) < 1e-8]
cW = np.einsum('dmn,mn->d', B, W); cW /= np.linalg.norm(cW)
Ob = np.einsum('amn,dmn->ad', orbit_tangent(n, W), B).T
u_, s_, _ = np.linalg.svd(Ob, full_matrices=False); Oc = u_[:, s_ > 1e-9*s_[0]]
Pe = E - Oc @ (Oc.T @ E); uu, ss, _ = np.linalg.svd(Pe, full_matrices=False)
Exc = uu[:, ss > 1e-8]
Rest = V[:, np.abs(ev-0.5) >= 1e-8]; Rest = Rest - np.outer(cW, cW @ Rest)
uu, ss, _ = np.linalg.svd(Rest, full_matrices=False); Rest = uu[:, ss > 1e-8]
resid, jacf = make_resid(n, B)
spec0 = np.sort(np.round(np.linalg.eigvalsh(W), 6))
print(f"theta={th:.9f} excess={Exc.shape[1]} outside-E={Rest.shape[1]}", flush=True)
rng = np.random.default_rng(77)

def lm(c0, maxit=120):
    """hand-rolled Levenberg-Marquardt; scipy's MINPACK path does a dense Fortran QR
    of a 771 x 770 Jacobian each step and is an order of magnitude slower here."""
    c = c0.copy(); lam = 1e-6
    r = resid(c); f = float(r @ r)
    for _ in range(maxit):
        J = jacf(c)
        JT = J.T
        A = JT @ J; g = JT @ r
        for _ in range(30):
            try:
                step = np.linalg.solve(A + lam*np.diag(np.diag(A) + 1e-12), -g)
            except np.linalg.LinAlgError:
                lam *= 10; continue
            cn = c + step
            rn_ = resid(cn); fn = float(rn_ @ rn_)
            if fn < f:
                c, r, f = cn, rn_, fn; lam = max(lam*0.3, 1e-14); break
            lam *= 10
        else:
            break
        if np.sqrt(f) < 1e-12 or np.linalg.norm(step) < 1e-13:
            break
    return c

def run(c0):
    x = lm(c0)
    rn = float(np.linalg.norm(resid(x)))
    Wn = np.einsum('d,dij->ij', x, B); Wn /= np.linalg.norm(Wn)
    thn = float(np.tensordot(Wn, Q(n, Wn)))
    if thn < 0: Wn, thn = -Wn, -thn
    S = slack_structural(n, Wn)
    sp = np.sort(np.round(np.linalg.eigvalsh(Wn), 6))
    cn = np.einsum('dij,ij->d', B, Wn)
    if cn @ cW < 0: cn = -cn
    dc = cn - cW
    return rn, thn, S, bool(np.allclose(sp, spec0, atol=3e-5)), float(np.linalg.norm(dc)), \
        float(np.linalg.norm(dc - Oc @ (Oc.T @ dc))), sp

print(f"{'set':>15} {'t':>6} {'conv':>6} {'|res|':>9} {'theta':>11} {'S':>9} {'same spec':>10} "
      f"{'|dc|':>8} {'|dc perp orbit|':>16} {'s':>5}")
jobs = []
for i in range(0, 20, 4):
    for t in (0.8, 1.5, 2.5):
        jobs.append(("excess", t, Exc[:, i]))
for i in rng.choice(Rest.shape[1], 5, replace=False):
    for t in (0.4, 1.0):
        jobs.append(("outside E(1/2)", t, Rest[:, i]))
for _ in range(5):
    v = rng.normal(size=D); v -= (v @ cW)*cW; v /= np.linalg.norm(v)
    for t in (0.5, 1.2):
        jobs.append(("random", t, v))
for name, t, d in jobs:
    c = cW + t*d; c /= np.linalg.norm(c)
    t0 = time.time()
    rn, thn, S, same, dcn, dcp, sp = run(c)
    print(f"{name:>15} {t:>6.2f} {str(rn<1e-5):>6} {rn:>9.1e} {thn:>11.6f} {S:>9.4f} "
          f"{str(same):>10} {dcn:>8.4f} {dcp:>16.5f} {time.time()-t0:>4.0f}s", flush=True)
