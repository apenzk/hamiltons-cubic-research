"""Claim 4, empirical probe: is Crit(P) strictly bigger than the O(n)-orbit at a
GRADED DEGENERATE critical point?  Test at the two-block Fox plateau (n=8),
which the record lists as graded, degenerate, orbit 20 vs nullity 36."""
import numpy as np, time
from core111 import Core
import points111 as P

n = 8
C = Core(n); B = C.weyl_basis(); k = len(B)
def to_x(M): return np.array([np.sum(M*b) for b in B])
def to_M(x): return sum(v*b for v, b in zip(x, B))

C4, M4 = P.cp2_native()
R4 = C4.tens(M4)
R = np.zeros((n, n, n, n))
R[:4, :4, :4, :4] = R4
R[4:, 4:, 4:, 4:] = R4
Wp = C.mat(R); Wp /= np.linalg.norm(Wp)
th = C.theta(Wp)
print("Fox plateau n=8: theta=%.9f (sqrt(3/2)/sqrt2=%.9f) crit-res=%.1e S_mmm=%.3e"
      % (th, np.sqrt(1.5)/np.sqrt(2), C.crit_residual(Wp), C.slack_struct(Wp)))
lam = np.linalg.eigvalsh(Wp)
print("  spectrum:", np.round(lam, 6))

x0 = to_x(Wp)
H = np.array([to_x(C.hess_euclid(Wp, b)) for b in B]).T; H = 0.5*(H+H.T)
Pp = np.eye(k) - np.outer(x0, x0)
ev, EV = np.linalg.eigh(Pp @ (H - 3*th*np.eye(k)) @ Pp)
scale = np.abs(H).max()
kidx = np.where(np.abs(ev) < 1e-7*scale)[0]
K = EV[:, kidx]
K = K - np.outer(x0, x0 @ K)                      # drop the radial direction
K = K[:, np.linalg.norm(K, axis=0) > 1e-8]
Ot = C.orbit_tangent(Wp)
Otb = np.array([[np.sum(b*Ot[:, g].reshape(C.D, C.D)) for g in range(C.D)] for b in B])
U, s, _ = np.linalg.svd(Otb, full_matrices=False); orb = int((s > 1e-8*s[0]).sum())
Uo = U[:, :orb]
Kt = K - Uo @ (Uo.T @ K)                          # transverse part
Uk, sk, _ = np.linalg.svd(Kt, full_matrices=False)
exc = int((sk > 1e-8).sum())
print("  orbit=%d  dim ker Hess=%d  transverse excess=%d" % (orb, K.shape[1], exc))
Trans = Uk[:, :exc]

def Fvec(x):
    M = to_M(x); return to_x(C.weyl_project(C.Qop(M)) - C.theta(M)*M)
def Jmat(x):
    M = to_M(x); t = C.theta(M); Qw = C.weyl_project(C.Qop(M))
    return np.array([to_x(C.hess_euclid(M, b)/3.0 - 3*np.sum(Qw*b)*M - t*b) for b in B]).T

def continue_along(v, eps, iters=40):
    x = x0 + eps*v; x /= np.linalg.norm(x)
    A_extra = np.vstack([Uo.T, v[None, :]])
    b_extra = np.concatenate([Uo.T @ x0, [x0 @ v + eps]])
    for it in range(iters):
        F = Fvec(x)
        g = A_extra @ x - b_extra
        r = np.concatenate([F, g])
        if np.linalg.norm(r) < 1e-13: break
        J = np.vstack([Jmat(x), A_extra])
        J = np.hstack([J, np.zeros((J.shape[0], 0))])
        Jr = np.vstack([J, x[None, :]])
        rr = np.concatenate([r, [0.5*(x @ x - 1)]])
        step, *_ = np.linalg.lstsq(Jr, -rr, rcond=1e-10)
        x = x + step; x /= np.linalg.norm(x)
    M = to_M(x)
    return x, M, np.linalg.norm(Fvec(x))

rng = np.random.default_rng(9)
print("\n  slice-constrained continuation along transverse kernel directions:")
for trial in range(6):
    v = Trans @ rng.standard_normal(exc); v /= np.linalg.norm(v)
    for eps in (1e-3,):
        x, M, res = continue_along(v, eps)
        d = x - x0
        off = np.linalg.norm(d - Uo @ (Uo.T @ d))
        print("    dir%d eps=%.0e -> ||F||=%.2e  theta=%.9f  |x-x0|=%.2e  off-orbit=%.2e  S_mmm=%.3e"
              % (trial, eps, res, C.theta(M), np.linalg.norm(d), off, C.slack_struct(M)))
