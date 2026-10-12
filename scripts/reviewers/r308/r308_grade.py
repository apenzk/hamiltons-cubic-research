"""Gradedness test, written from the brief's definition:
p = strictly positive eigenspace of W, m = strictly negative.
Graded iff [p,p] in p, [p,m] in m, [m,m] in p.
Measured as the norm of the offending components of the Lie bracket, using the
structure constants of so(n) in the orthonormal Lambda^2 basis.
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
import r308_lib as L


def split(W, tol=1e-8):
    lam, V = np.linalg.eigh(W)
    Pp = V[:, lam > tol]
    Pm = V[:, lam < -tol]
    Z = V[:, np.abs(lam) <= tol]
    return Pp, Pm, Z, lam


def bracket_defect(c, X, Y, Z):
    """norm of the component of [X,Y] outside span(Z), relative."""
    Br = np.einsum('abg,ai,bj->ijg', c, X, Y, optimize=True)  # (i,j,gamma)
    Br = Br.reshape(-1, c.shape[0])
    if Br.size == 0:
        return 0.0, 0.0
    tot = np.linalg.norm(Br)
    if Z.shape[1] == 0:
        return tot, tot
    proj = Br @ Z
    out = np.sqrt(max(tot ** 2 - np.linalg.norm(proj) ** 2, 0.0))
    return out, tot


def grading_report(n, W, tol=1e-8):
    idx, pos, N, c = L.struct(n)
    Pp, Pm, Z, lam = split(W, tol)
    out = {}
    for name, (X, Y, T) in dict(pp_in_p=(Pp, Pp, Pp), pm_in_m=(Pp, Pm, Pm),
                                mm_in_p=(Pm, Pm, Pp)).items():
        o, t = bracket_defect(c, X, Y, T)
        out[name] = (o, t)
    out['dims'] = (Pp.shape[1], Pm.shape[1], Z.shape[1])
    out['massP'] = float((lam[lam > tol] ** 2).sum())
    out['massM'] = float((lam[lam < -tol] ** 2).sum())
    return out


def equivariance_defect(n, W, P=None, tol=1e-8):
    """Delta: W is ad(p)-equivariant iff [ad(X), W] = 0 for every X in p.
    Returns max_X ||[ad(X),W]||_F over an orthonormal basis of p (default: the
    strictly positive eigenspace of W)."""
    idx, pos, N, c = L.struct(n)
    Ad = L.ad(c)
    if P is None:
        lam, V = np.linalg.eigh(W)
        P = V[:, lam > tol]
    worst = 0.0
    for k in range(P.shape[1]):
        X = np.einsum('a,agb->gb', P[:, k], Ad)
        worst = max(worst, float(np.linalg.norm(X @ W - W @ X)))
    return worst
