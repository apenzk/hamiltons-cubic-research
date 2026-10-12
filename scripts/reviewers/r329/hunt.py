import sys, numpy as np
sys.path.insert(0,'scripts/reviewers/r329')
from core import *
from solve import sharp_bil
from scipy.optimize import least_squares

def make_sat_res(Bo,c,n,w=1.0):
    def W_of(x): return np.einsum('k,kij->ij',x,Bo)
    def res(x):
        W=W_of(x); QW=W@W+sharp_bil(W,W,c)
        th=float(np.tensordot(W,QW))
        F=QW-th*W
        r=np.einsum('kij,ij->k',Bo,F)
        ev=np.linalg.eigvalsh(W)
        slack=ev[0]+(n-2)*ev[-1]-th
        return np.concatenate([r,[w*slack],[np.dot(x,x)-1.0]])
    return res,W_of

def hunt(Bo,c,n,ntry=60,seed=0,w=1.0):
    res,W_of=make_sat_res(Bo,c,n,w)
    rng=np.random.default_rng(seed); out=[]
    for t in range(ntry):
        x0=rng.normal(size=Bo.shape[0]); x0/=np.linalg.norm(x0)
        s=least_squares(res,x0,xtol=1e-15,ftol=1e-15,gtol=1e-15,max_nfev=3000)
        x=s.x/np.linalg.norm(s.x)
        out.append((np.linalg.norm(res(x)),x))
    out.sort(key=lambda z:z[0])
    return out
