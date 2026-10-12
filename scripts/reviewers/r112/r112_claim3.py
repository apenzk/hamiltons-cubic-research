"""Claim 3.  (a) reproduce the recorded on-sphere S-jump at padded W_CP2.
(b) THE NEW QUESTION: does S jump on Crit(P) near W_CP2?  Perturb, then
project back to Crit(P) by gauge-fixed Gauss-Newton, and measure S there."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts/reviewers/r112'))
import r112_core as K
from scipy.linalg import expm
from scipy.optimize import minimize

rng = np.random.default_rng(11212)


def F_and_J(n, x):
    """Criticality residual F = Pi Q(W) - P(W) W in Weyl coordinates, + Jacobian."""
    Bs = K.weyl_basis(n)
    D = Bs.shape[0]
    M = K.from_coords(n, x)
    QM = K.Qop(n, M)
    th = float(np.sum(QM * M))
    Fm = K.proj_weyl(n, QM) - th * M
    F = K.coords(n, Fm)
    L = K.Lop(n, M)                       # Pi[ 1/2(Mv+vM)+sh(M,v) ] in coords
    q = K.coords(n, K.proj_weyl(n, QM))
    J = 2 * L - th * np.eye(D) - 3 * np.outer(K.coords(n, M), q)
    return F, J, th, M


def project_back(n, x0, orb_basis, iters=60, tol=1e-13):
    """Gauss-Newton onto Crit(P), gauge-fixed transverse to the orbit tangent
    of the base point and to the radial direction."""
    x = x0 / np.linalg.norm(x0)
    for _ in range(iters):
        F, J, th, M = F_and_J(n, x)
        if np.linalg.norm(F) < tol:
            break
        # restrict the step to the gauge slice: perp to orbit tangent and to x
        G = np.hstack([orb_basis, x[:, None]])
        Qg, _ = np.linalg.qr(G)
        Pperp = np.eye(len(x)) - Qg @ Qg.T
        step = np.linalg.lstsq(J @ Pperp, -F, rcond=None)[0]
        x = x + Pperp @ step
        x /= np.linalg.norm(x)
    F, _, th, M = F_and_J(n, x)
    return x, np.linalg.norm(F), th, M


def orbit_distance(n, M, M0, tries=4):
    """min_g || Lambda^2(g) M Lambda^2(g)^T - M0 ||_F over g in SO(n)."""
    P = K.pairs(n)
    tri = [(i, j) for i in range(n) for j in range(i + 1, n)]

    def mk(p):
        X = np.zeros((n, n))
        for t, (i, j) in enumerate(tri):
            X[i, j] = p[t]; X[j, i] = -p[t]
        return expm(X)

    def f(p):
        g = K.lam2(mk(p))
        return float(np.linalg.norm(g @ M @ g.T - M0))

    best = f(np.zeros(len(tri)))
    for t in range(tries):
        p0 = np.zeros(len(tri)) if t == 0 else 0.3 * rng.standard_normal(len(tri))
        r = minimize(f, p0, method='Powell',
                     options=dict(maxiter=20000, xtol=1e-10, ftol=1e-12))
        best = min(best, r.fun)
    return best


def part_a(n):
    W = K.cp2(n)
    Bs = K.weyl_basis(n)
    print(f"\n(a) ON-SPHERE perturbations of padded W_CP2 at n={n} "
          f"(the recorded protocol, no projection):")
    for eps in (1e-6, 1e-3):
        vals, dm, cr = [], [], []
        for t in range(200):
            d = np.einsum('d,dij->ij', rng.standard_normal(Bs.shape[0]), Bs)
            d /= np.linalg.norm(d)
            Wp = W + eps * d; Wp /= np.linalg.norm(Wp)
            vals.append(K.slack_mmm(n, Wp))
            dm.append(int((np.linalg.eigvalsh(Wp) < -1e-9).sum()))
            if t < 10:
                cr.append(K.crit_residual(n, Wp))
        print(f"    eps={eps:.0e}  S_mmm min={min(vals):8.4f} med={np.median(vals):8.4f} "
              f"max={max(vals):8.4f}   dim m: base={int((np.linalg.eigvalsh(W)<-1e-9).sum())} "
              f"perturbed median={int(np.median(dm))}  crit-res median={np.median(cr):.2e}")


def part_b(n, eps_list=(1e-3, 1e-2, 5e-2)):
    W0 = K.cp2(n)
    x0 = K.coords(n, W0)
    Bs = K.weyl_basis(n)
    OT = K.orbit_tangent(n, W0)
    u, s, _ = np.linalg.svd(OT, full_matrices=False)
    orb = u[:, s > 1e-9 * s[0]]
    print(f"\n(b) PROJECT BACK TO Crit(P) at n={n}: orbit dim={orb.shape[1]}, "
          f"S_mmm(base)={K.slack_mmm(n, W0):.3e}, S_hhm(base)={K.slack_hhm(n, W0):.4f}")
    for eps in eps_list:
        rows = []
        for _ in range(12):
            d = rng.standard_normal(Bs.shape[0]); d /= np.linalg.norm(d)
            x, res, th, M = project_back(n, x0 + eps * d, orb)
            rows.append((res, th, K.slack_mmm(n, M), K.slack_hhm(n, M),
                         np.linalg.norm(x - x0)))
        rows = [r for r in rows if r[0] < 1e-9]
        if not rows:
            print(f"    eps={eps:.0e}: no start converged"); continue
        S = np.array([r[2] for r in rows]); TH = np.array([r[1] for r in rows])
        SH = np.array([r[3] for r in rows]); DD = np.array([r[4] for r in rows])
        print(f"    eps={eps:.0e}  converged {len(rows)}/12  "
              f"S_mmm max={S.max():.3e}  S_hhm range=[{SH.min():.4f},{SH.max():.4f}]  "
              f"theta range=[{TH.min():.9f},{TH.max():.9f}]  |x-x0| max={DD.max():.4f}")
        k = int(np.argmax(DD))
    return


if __name__ == '__main__':
    for n in (6, 8):
        part_a(n)
    for n in (6, 8):
        part_b(n)
