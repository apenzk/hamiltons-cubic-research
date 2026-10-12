"""K3, decisively: the Lyapunov-Schmidt bifurcation function at the C_5 blow-up.

The criticality Jacobian at W is theta(2 L_e - 1) on W-perp, whose kernel is exactly
E = E(1/2), dimension 60.  Split the Weyl space as E (+) F.  For each xi in E the
complementary equations

        P_F [ Q(c) - theta(c) c ] = 0,     c = (W + xi + eta)/|W + xi + eta|,

have a unique small solution eta = eta(xi) in F, because P_F J P_F is invertible.  The
critical points near W are then exactly the zeros of the BIFURCATION FUNCTION

        B(xi) = P_E [ Q(c) - theta(c) c ]   in  R^60 .

B vanishes on the 40-dimensional orbit tangent, since the orbit is in Crit.  Whether
{S = 0} is open at W is exactly the question of whether B has a zero with a nonzero
component in the 20-dimensional EXCESS.  This is a finite-distance statement, not a
jet condition, and it does not rely on any corrector finding its own way home.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time
import numpy as np
from scipy.optimize import least_squares
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r54_core import Q, P, weyl_basis, Le_matrix, orbit_tangent, slack_structural
from review_r54_correct import L_at
from review_r54_k1k2 import blowup_W, cycle

W, n, lab = blowup_W([2]*5, cycle(5), 4.0, -2.0, 1.0)
W /= np.linalg.norm(W)
th = P(n, W)
B = weyl_basis(n); D = len(B)
M = Le_matrix(n, W/th, B)
ev, V = np.linalg.eigh(M)
E = V[:, np.abs(ev - 0.5) < 1e-8]                 # (D, 60)
cW = np.einsum('dmn,mn->d', B, W); cW /= np.linalg.norm(cW)
Ob = np.einsum('amn,dmn->ad', orbit_tangent(n, W), B).T
u_, s_, _ = np.linalg.svd(Ob, full_matrices=False)
Oc = u_[:, s_ > 1e-9*s_[0]]                        # (D, 40) inside E
Pexc = E - Oc @ (Oc.T @ E)
uu, ss, _ = np.linalg.svd(Pexc, full_matrices=False)
Exc = uu[:, ss > 1e-8]                             # (D, 20)
# F = complement of E, further restricted to cW-perp
Full = np.eye(D)
PF = Full - E @ E.T
PF = PF - np.outer(cW, cW @ PF)
uu, ss, _ = np.linalg.svd(PF, full_matrices=False)
F = uu[:, ss > 1e-8]                               # (D, 709)
print(f"D={D} dim E={E.shape[1]} orbit={Oc.shape[1]} excess={Exc.shape[1]} dim F={F.shape[1]}",
      flush=True)

def resid_full(c):
    Wc = np.einsum('d,dij->ij', c, B)
    QW = Q(n, Wc)
    t = float(np.tensordot(Wc, QW))
    g = np.einsum('dij,ij->d', B, QW)
    return g - t*c, Wc, QW, t, g

def solve_eta(xi, eta0=None, maxit=18):
    def rF(y):
        c = cW + xi + F @ y
        c = c/np.linalg.norm(c)
        r, *_ = resid_full(c)
        return F.T @ r
    def jF(y):
        c0 = cW + xi + F @ y
        nrm = np.linalg.norm(c0); c = c0/nrm
        r, Wc, QW, t, g = resid_full(c)
        J = 2.0*L_at(n, Wc, B) - 3.0*np.outer(c, g) - t*np.eye(D)
        # chain rule through the normalization
        Pn = (np.eye(D) - np.outer(c, c))/nrm
        return F.T @ (J @ Pn @ F)
    y0 = np.zeros(F.shape[1]) if eta0 is None else eta0
    sol = least_squares(rF, y0, jac=jF, xtol=1e-14, ftol=1e-14, gtol=1e-14, max_nfev=maxit)
    return sol.x, float(np.linalg.norm(sol.fun))

def bif(xi, y=None):
    if y is None:
        y, rn = solve_eta(xi)
    else:
        rn = float(np.linalg.norm((lambda c: (F.T @ resid_full(c/np.linalg.norm(c))[0]))(cW + xi + F @ y)))
    c = cW + xi + F @ y; c = c/np.linalg.norm(c)
    r, *_ = resid_full(c)
    return E.T @ r, y, rn, c

rng = np.random.default_rng(54054)
print("\nVALIDATION  B must vanish along the ORBIT tangent (the orbit lies in Crit)")
print(f"{'t':>7} {'|B(xi)| orbit dir':>19} {'|B(xi)| pure excess':>21} {'|B| random E dir':>18} "
      f"{'F-residual':>12}")
for t in (0.02, 0.05, 0.1, 0.2, 0.4):
    vo = Oc @ rng.normal(size=40); vo *= t/np.linalg.norm(vo)
    vx = Exc @ rng.normal(size=20); vx *= t/np.linalg.norm(vx)
    ve = E @ rng.normal(size=60); ve *= t/np.linalg.norm(ve)
    bo, _, r1, _ = bif(vo); bx, _, r2, _ = bif(vx); be, _, r3, _ = bif(ve)
    print(f"{t:>7.2f} {np.linalg.norm(bo):>19.3e} {np.linalg.norm(bx):>21.3e} "
          f"{np.linalg.norm(be):>18.3e} {max(r1,r2,r3):>12.1e}", flush=True)

print("\nSEARCH  minimise |B(xi)| over xi, with an analytic dB/dxi by implicit differentiation")

def bif_and_jac(xi, y0=None):
    y, rn = solve_eta(xi, y0)
    c0 = cW + xi + F @ y
    nrm = np.linalg.norm(c0); c = c0/nrm
    r, Wc, QW, t, g = resid_full(c)
    J = 2.0*L_at(n, Wc, B) - 3.0*np.outer(c, g) - t*np.eye(D)
    Pn = (np.eye(D) - np.outer(c, c))/nrm
    JP = J @ Pn
    Ry = F.T @ (JP @ F)
    Rx = F.T @ (JP @ E)
    dy = -np.linalg.solve(Ry, Rx)
    Bv = E.T @ r
    dB = E.T @ (JP @ (E + F @ dy))
    return Bv, dB, y, rn

print(f"{'t':>7} {'alpha':>7} {'min |B|':>13} {'|B|/t^3':>11} {'F-resid':>9} {'starts':>7} {'time':>8}")
for t in (0.05, 0.15, 0.30):
    for alpha in (1.0, 0.5):
        beta = np.sqrt(max(1-alpha**2, 0.0))
        Oe = E.T @ Oc; Xe = E.T @ Exc          # orbit and excess in E-coordinates
        def embed_e(z):
            o = Oe @ z[:40]; x = Xe @ z[40:]
            no, nx = np.linalg.norm(o), np.linalg.norm(x)
            return t*beta*o/max(no, 1e-12) + t*alpha*x/max(nx, 1e-12)
        def embed(z):
            return E @ embed_e(z)
        def dembed(z):
            o = Oe @ z[:40]; x = Xe @ z[40:]
            no, nx = np.linalg.norm(o), np.linalg.norm(x)
            Po = (np.eye(60) - np.outer(o, o)/no**2) @ Oe / no
            Px = (np.eye(60) - np.outer(x, x)/nx**2) @ Xe / nx
            return np.hstack([t*beta*Po, t*alpha*Px])
        cache = {}
        def rr(z):
            xi = embed(z)
            Bv, dB, y, rn = bif_and_jac(xi, cache.get('y'))
            cache['y'] = y; cache['dB'] = dB; cache['z'] = z.copy(); cache['rn'] = rn
            return Bv
        def jj(z):
            if 'z' not in cache or not np.array_equal(cache['z'], z):
                rr(z)
            return cache['dB'] @ dembed(z)
        best = np.inf; bestrn = 0.0; t0 = time.time(); ns = 6
        for _ in range(ns):
            z0 = rng.normal(size=60); cache.clear()
            sol = least_squares(rr, z0, jac=jj, xtol=1e-13, ftol=1e-13, gtol=1e-13, max_nfev=30)
            v = float(np.linalg.norm(sol.fun))
            if v < best:
                best, bestrn = v, cache.get('rn', 0.0)
        print(f"{t:>7.2f} {alpha:>7.2f} {best:>13.4e} {best/t**3:>11.4e} {bestrn:>9.1e} {ns:>7} "
              f"{time.time()-t0:>7.0f}s", flush=True)
print("\nA floor that scales like t^3 and stays bounded away from 0 for every alpha > 0")
print("means Crit(P) near W is exactly the orbit, so {S=0} is open at W.")
