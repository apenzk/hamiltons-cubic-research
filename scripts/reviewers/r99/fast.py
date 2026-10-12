import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r99'))
from wlib import *
_IX={}
def ix(n):
    if n not in _IX:
        P=pairs(n); I=np.array([p[0] for p in P]); Jn=np.array([p[1] for p in P]); _IX[n]=(I,Jn)
    return _IX[n]
def Mfast(W):
    n=W.shape[0]; I,Jn=ix(n)
    return W[I[:,None],Jn[:,None],I[None,:],Jn[None,:]]
def Jfast(X,n):
    I,Jn=ix(n); T=np.zeros((n,)*4)
    a=I[:,None]; b=Jn[:,None]; c=I[None,:]; d=Jn[None,:]
    T[a,b,c,d]=X; T[b,a,c,d]=-X; T[a,b,d,c]=-X; T[b,a,d,c]=X
    return T
def iota_star(X,n):
    B=s20_basis(n); Y=np.einsum('cb,cij,bkl->ijkl',X,B,B,optimize=True); return Y.transpose(0,2,3,1)
def ringfast(W):
    B=s20_basis(W.shape[0])
    img=np.einsum('iklj,bkl->bij',W,B,optimize=True)
    return np.einsum('bij,cij->cb',img,B,optimize=True)
