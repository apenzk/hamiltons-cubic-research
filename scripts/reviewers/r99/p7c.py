import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
from scipy.sparse.linalg import LinearOperator, eigsh
sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r99'))
from wlib import *
from fast import Mfast,Jfast,iota_star,ringfast

def sphere_product_R(m1,m2):
    n=m1+m2; R=np.zeros((n,)*4)
    for (off,mm) in ((0,m1),(m1,m2)):
        I=range(off,off+mm)
        for i in I:
            for j in I:
                for k in I:
                    for l in I: R[i,j,k,l]=(i==k)*(j==l)-(i==l)*(j==k)
    return R
def cp2_W(n):
    Jm=np.zeros((4,4)); Jm[0,1]=1;Jm[1,0]=-1;Jm[2,3]=1;Jm[3,2]=-1; I=np.eye(4)
    R=(np.einsum('ik,jl->ijkl',I,I)-np.einsum('il,jk->ijkl',I,I)
       +np.einsum('ik,jl->ijkl',Jm,Jm)-np.einsum('il,jk->ijkl',Jm,Jm)+2*np.einsum('ij,kl->ijkl',Jm,Jm))
    W=np.zeros((n,)*4); W[:4,:4,:4,:4]=pr(R); return pr(W)
def th(W):
    M=Mfast(W); rw=ringfast(W); return 1.5*float(np.trace(M@M@M))-0.5*float(np.trace(rw@rw@rw))
def grad(W):
    n=W.shape[0]; M=Mfast(W); rw=ringfast(W)
    return 1.5*0.75*pr(Jfast(M@M,n)) - 1.5*pr(iota_star(rw@rw,n))

def certify(W,n,label):
    W=W/np.linalg.norm(W)                       # unit tensor sphere
    t=th(W); G=grad(W); w=W.reshape(-1)
    lam=float(np.dot(G.reshape(-1),w))
    gt=G.reshape(-1)-lam*w
    M=Mfast(W); rw=ringfast(W)
    def Hess(U):
        MU=Mfast(U); rU=ringfast(U)
        return 4.5*pr(Jfast(M@MU+MU@M,n)/4.0) - 1.5*pr(iota_star(rw@rU+rU@rw,n))
    def op(v):
        V=pr(v.reshape((n,)*4)); vv=V.reshape(-1); vv=vv-np.dot(vv,w)*w
        HV=Hess(vv.reshape((n,)*4)).reshape(-1)
        HV=pr(HV.reshape((n,)*4)).reshape(-1); HV=HV-np.dot(HV,w)*w
        return HV - 3*t*vv - 500.0*(v-vv)
    L=LinearOperator((n**4,n**4),matvec=op,dtype=float)
    ev=eigsh(L,k=3,which='LA',tol=1e-7,maxiter=6000,return_eigenvectors=False)
    thn=th(W/np.linalg.norm(Mfast(W)))
    print(f"  {label:22s} theta={thn:+.8f}  Euler-check lam/3theta={lam/(3*t):+.6f}  "
          f"|tangential grad|={np.linalg.norm(gt):.2e}  top eig(Riem Hess)={np.max(ev):+.6f}")

for n in [6,8,10,12]:
    print(f"=== n={n}  theta0={theta0(n):.6f} ===")
    certify(cp2_W(n),n,"CP^2 extended")
    if n%2==0: certify(pr(sphere_product_R(n//2,n//2)),n,f"S^{n//2}xS^{n//2}")
