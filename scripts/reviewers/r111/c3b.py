"""Claim 3, part (b): perturb, then PROJECT BACK to Crit(P), and read S there."""
import numpy as np, time
from core111 import Core
import points111 as P

def to_x(C, M):
    B = C.weyl_basis(); return np.array([np.sum(M*b) for b in B])
def to_M(C, x):
    B = C.weyl_basis(); return sum(v*b for v, b in zip(x, B))

def Fvec(C, x):
    M = to_M(C, x); th = C.theta(M)
    return to_x(C, C.weyl_project(C.Qop(M)) - th*M)

def jac(C, x):
    M = to_M(C, x); B = C.weyl_basis(); th = C.theta(M)
    Qw = C.weyl_project(C.Qop(M))
    cols = []
    for h in B:
        dQ = C.hess_euclid(M, h)/3.0        # d/dt Pi_W Q(M+th) = Pi_W(Mh+hM+2M#h)
        dth = 3.0*np.sum(Qw*h)
        cols.append(to_x(C, dQ - dth*M - th*h))
    return np.array(cols).T

def project_to_crit(C, x0, iters=12, tol=1e-13):
    x = x0/np.linalg.norm(x0)
    for it in range(iters):
        F = Fvec(C, x); nrm = np.linalg.norm(F)
        if nrm < tol: break
        J = jac(C, x)
        # stay on the sphere: kill the radial direction
        J = J - np.outer(J @ x, x)
        step, *_ = np.linalg.lstsq(J, -F, rcond=1e-8)
        step = step - (step @ x)*x
        x = x + step; x /= np.linalg.norm(x)
    return x, np.linalg.norm(Fvec(C, x))

def orbit_distance(C, M, M0):
    """min over so(n) flows of ||exp(A) M exp(-A) - M0|| to first order:
       the residual of M-M0 against the orbit tangent at M0."""
    Ot = C.orbit_tangent(M0)
    d = (M-M0).ravel()
    coef, *_ = np.linalg.lstsq(Ot, d, rcond=1e-10)
    return np.linalg.norm(d - Ot@coef), np.linalg.norm(d)

rng = np.random.default_rng(1111)
C4, M4 = P.cp2_native()
for n in (6, 8):
    Cn, W = P.pad(C4, M4, n)
    B = Cn.weyl_basis()
    ctrl = Core(n); Wc = P.sphere_product(ctrl, (n//2, n//2))
    for tag, C, W0 in (("W_CP2 padded", Cn, W), ("S^%dxS^%d"%(n//2,n//2), ctrl, Wc)):
        x0 = to_x(C, W0)
        for eps in (1e-6, 1e-3):
            sph, crit, dorb, res = [], [], [], []
            for _ in range(12):
                d = rng.standard_normal(len(C.weyl_basis())); d /= np.linalg.norm(d)
                xp = x0 + eps*d; xp /= np.linalg.norm(xp)
                sph.append(C.slack_struct(to_M(C, xp)))
                xc, r = project_to_crit(C, xp)
                Mc = to_M(C, xc)
                crit.append(C.slack_struct(Mc)); res.append(r)
                do, dt = orbit_distance(C, Mc, W0); dorb.append(do)
            print("%-14s n=%2d eps=%.0e | S on SPHERE  min=%9.4f med=%9.4f max=%9.4f"
                  % (tag, n, eps, min(sph), np.median(sph), max(sph)))
            print("%-14s          | S on CRIT(P) min=%9.2e med=%9.2e max=%9.2e   ||F||max=%.1e  off-orbit dist max=%.2e"
                  % ("", min(crit), np.median(crit), max(crit), max(res), max(dorb)))
