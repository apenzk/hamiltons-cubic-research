import sys, numpy as np
sys.path.insert(0,'scripts/reviewers/r329')
from core import *
from scipy.optimize import least_squares

def sharp_bil(A,Bm,c):
    T1=np.einsum('kab,ac->kcb',c,A); T2=np.einsum('kcb,bd->kcd',T1,Bm)
    M=0.5*np.einsum('kcd,lcd->kl',T2,c)
    return 0.5*(M+M.T)

def make_res(Bo,c):
    def W_of(x): return np.einsum('k,kij->ij',x,Bo)
    def res(x):
        W=W_of(x); QW=W@W+sharp_bil(W,W,c)
        th=float(np.tensordot(W,QW))
        F=QW-th*W
        r=np.einsum('kij,ij->k',Bo,F)
        return np.concatenate([r,[np.dot(x,x)-1.0]])
    def jac(x):
        W=W_of(x); QW=W@W+sharp_bil(W,W,c); th=float(np.tensordot(W,QW))
        J=np.zeros((Bo.shape[0]+1,Bo.shape[0]))
        for k in range(Bo.shape[0]):
            H=Bo[k]
            dQ=W@H+H@W+sharp_bil(H,W,c)+sharp_bil(W,H,c)
            dth=float(np.tensordot(H,QW))+float(np.tensordot(W,dQ))
            dF=dQ-dth*W-th*H
            J[:-1,k]=np.einsum('kij,ij->k',Bo,dF)
        J[-1,:]=2*x
        return J
    return res,jac,W_of

def solve_crit(Bo,c,x0,tol=1e-13):
    res,jac,W_of=make_res(Bo,c)
    s=least_squares(res,x0,jac=jac,xtol=1e-15,ftol=1e-15,gtol=1e-15,max_nfev=400)
    x=s.x/np.linalg.norm(s.x)
    return x,W_of(x),np.linalg.norm(res(x))
