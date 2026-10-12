import sys,os; sys.path.insert(0,os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r314lib as L, m3_lib as m3
from m1_gradings import ad_on_lambda2
from m2_b1 import c5_blowup

def T_tensor(n,V):
    """T[a,b,c] = <[v_a,v_b], v_c> for columns v of V (coords in Lambda^2)."""
    c=L.struct(n)
    return np.einsum('abc,ai,bj,ck->ijk',c,V,V,V)

def slacks(n,W,tol=1e-9):
    lam,V=np.linalg.eigh(W)
    ip=np.where(lam>tol)[0]; im=np.where(lam<-tol)[0]; iz=np.where(np.abs(lam)<=tol)[0]
    T=T_tensor(n,V)
    def blk(A,Bx,C): return float((T[np.ix_(A,Bx,C)]**2).sum())
    return dict(lam=lam,dimp=len(ip),dimm=len(im),dimz=len(iz),
                Smmm=blk(im,im,im), Smpp=blk(im,ip,ip), Sppp=blk(ip,ip,ip),
                Smmp=blk(im,im,ip))

def rand_SO(n,rng):
    A=rng.normal(size=(n,n)); Qm,R=np.linalg.qr(A); Qm=Qm*np.sign(np.diag(R))
    if np.linalg.det(Qm)<0: Qm[:,0]*=-1
    return Qm

def conj_lambda2(n,g):
    """action of g in SO(n) on Lambda^2 in E-basis"""
    A=L.so_mats(n)
    C=np.einsum('ij,ajk,lk->ail',g,A,g)
    return 0.5*np.einsum('ail,bil->ba',C,A)

if __name__=='__main__':
    n=10
    M,blk=c5_blowup(); W0=L.diag_op(n,M); W=W0/np.linalg.norm(W0)
    th=float(np.sum(W*L.Q(n,W)))
    s=slacks(n,W)
    print('C_5 blow-up (coordinate frame): theta=%.9f crit=%.1e'%(th,np.abs(L.Q(n,W)-th*W).max()))
    print('  dim p=%d dim m=%d dim z=%d  cap floor(n^2/4)=%d'%(s['dimp'],s['dimm'],s['dimz'],n*n//4))
    print('  S_mmm=%.6e  S_mpp=%.6f  S_ppp=%.6f  S_mmp=%.6f'%(s['Smmm'],s['Smpp'],s['Sppp'],s['Smmp']))
    D,lam,g=m3.Delta(n,W); print('  Delta=%.6f  spectrum=%s'%(D,np.round(np.unique(np.round(lam,9)),6)))
    rng=np.random.default_rng(31)
    for t in range(3):
        gm=rand_SO(n,rng); R=conj_lambda2(n,gm)
        Wc=R@W@R.T
        thc=float(np.sum(Wc*L.Q(n,Wc)))
        sc=slacks(n,Wc)
        offd=np.abs(Wc-np.diag(np.diag(Wc))).max()
        print('  conj %d: theta=%.9f crit=%.1e S_mmm=%.3e S_mpp=%.6f dim m=%d maxoffdiag=%.4f'%(
            t,thc,np.abs(L.Q(n,Wc)-thc*Wc).max(),sc['Smmm'],sc['Smpp'],sc['dimm'],offd))
    # controls
    from m1_graded import sphere_product,theta_of
    for nn,p in [(8,3),(10,5),(12,5)]:
        Wp=sphere_product(nn,p); t2,r2,Wh=theta_of(nn,Wp)
        sp=slacks(nn,Wh)
        print('  control S^%d x S^%d (n=%d): theta=%.9f S_mmm=%.3e S_mpp=%.3e dim p=%d dim m=%d'%(p,nn-p,nn,t2,sp['Smmm'],sp['Smpp'],sp['dimp'],sp['dimm']))
