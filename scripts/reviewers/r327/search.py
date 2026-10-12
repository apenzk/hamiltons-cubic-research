"""M4 hunt: saturating critical points with a non-extreme NONZERO eigenvalue."""
import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(__file__))
from core import *
from scipy.optimize import least_squares

def weyl_basis(n):
    Pm = weyl_proj(n)
    w,V = np.linalg.eigh(Pm)
    k = int(round(w.sum()))
    return V[:, -k:]          # columns: orthonormal basis of Weyl_n in vec coords

def make(n):
    N = n*(n-1)//2; _,idx = sym_coords(n); B = weyl_basis(n); M = ad_mats(n)
    def W_of(x):
        x = x/np.linalg.norm(x)
        return unvec(B@x, idx, N)
    def res_crit(x):
        W = W_of(x); QW = Q(W,M); th = np.trace(W@QW)
        R = QW - th*W
        return B.T@vec(R, idx)
    def res_sat(x, w=1.0):
        W = W_of(x); QW = Q(W,M); th = float(np.trace(W@QW))
        ev = np.linalg.eigvalsh(W)
        s = ev[0] + (n-2)*ev[-1] - th
        return np.concatenate([B.T@vec(QW-th*W, idx), [w*s]])
    return B, W_of, res_crit, res_sat

def report(W, n, M, tol=1e-7):
    QW = Q(W,M); th = float(np.trace(W@QW))
    crit = float(np.linalg.norm(QW-th*W))
    ev = np.linalg.eigvalsh(W); lmin,lmax = ev[0],ev[-1]
    sat = lmin + (n-2)*lmax - th
    r = ev[(ev>lmin+tol)&(ev<lmax-tol)]
    return dict(theta=th, crit=crit, dW=dist_weyl(W,n), sat=sat, lmin=lmin, lmax=lmax,
                dim_r=len(r), r_nonzero=int((np.abs(r)>tol).sum()),
                maxabs_r=float(np.abs(r).max()) if len(r) else 0.0,
                spec=np.unique(np.round(ev,6)))
