import sys; sys.path.insert(0,'scripts/reviewers/r323')
import numpy as np, core, lem70
from t2 import W_of, block_h, subalg_proj

def su3_ad():
    """Gell-Mann based: basis T_a = lambda_a/2, [T_a,T_b]=i f_abc T_c. ad(T_a)_{cb}=f_abc? build directly."""
    l=[np.array(x,dtype=complex) for x in [
      [[0,1,0],[1,0,0],[0,0,0]],[[0,-1j,0],[1j,0,0],[0,0,0]],[[1,0,0],[0,-1,0],[0,0,0]],
      [[0,0,1],[0,0,0],[1,0,0]],[[0,0,-1j],[0,0,0],[1j,0,0]],[[0,0,0],[0,0,1],[0,1,0]],
      [[0,0,0],[0,0,-1j],[0,1j,0]],np.array([[1,0,0],[0,1,0],[0,0,-2]])/np.sqrt(3)]]
    T=[x/2 for x in l]
    f=np.zeros((8,8,8))
    for a in range(8):
        for b in range(8):
            comm=T[a]@T[b]-T[b]@T[a]
            for cix in range(8):
                f[a,b,cix]=np.real(-2j*np.trace(comm@T[cix]))   # tr(T_c T_d)=delta/2
    # ad(T_a) acting on the 8-dim real adjoint space: (ad T_a)_{c,b} = f[a,b,c]
    return np.array([f[a].T for a in range(8)]), f

def su3_in_so8(ctx):
    ads,f=su3_ad()
    vs=[]
    P=core.pairs(8); pos={p:i for i,p in enumerate(P)}
    for a in range(8):
        A=ads[a]
        assert np.allclose(A,-A.T), np.abs(A+A.T).max()
        v=np.zeros(len(P))
        for (i,j),k in pos.items(): v[k]=A[i,j]
        v/=np.sqrt(0.5*np.trace(A.T@A))
        vs.append(v)
    return vs

if __name__=='__main__':
    c=core.Ctx(8)
    vs=su3_in_so8(c)
    # check closed under bracket (subalgebra) in coefficient space
    Pi=subalg_proj(c,vs)
    W=W_of(c,vs)
    r=len(vs)
    print('r=',r,'proj rank',round(np.trace(Pi)))
    d=lem70.report(c,W,'ad(su(3)) in so(8)')
    lam,Phi=np.linalg.eigh(W); lmin=lam[0]
    Emin=Phi[:,np.abs(lam-lmin)<1e-9]
    print(' dim Emin =',Emin.shape[1])
    tot=0;off=0
    lmax=lam[-1]; imin=np.abs(lam-lmin)<1e-9; imax=np.abs(lam-lmax)<1e-9
    Ds=[]
    for k in range(Emin.shape[1]):
        v=Emin[:,k]
        D,t,_,_,_,x,_=lem70.deficiency(c,W,v)
        on=x[np.ix_(imin,imax)].sum()+x[np.ix_(imax,imin)].sum()
        tot+=t; off+=t-on; Ds.append(D)
    print(f' summed over orthonormal basis of Emin: off={off:.6f} of total={tot:.6f}; D const spread={max(Ds)-min(Ds):.2e}')
    print(' distinct eigenvalues:',np.unique(np.round(lam,9)))
