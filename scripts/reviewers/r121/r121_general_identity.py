import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np
SP=_os.path.join(_ROOT, 'scripts/reviewers/r121/')
exec(open(SP+'r121_catalogue.py').read().split('print("=== padded CP^2')[0])

# ---- general identity, NO criticality, ANY unit symmetric traceless h ----
print("=== general identity  <Q(W)ring h,h> = LOSS(W,h) - ||Wring h||^2  (no criticality, h arbitrary) ===")
for n in [4,5,6,7]:
    rng=np.random.default_rng(100+n)
    W=rand_weyl(n,rng); W/=np.sqrt(op_norm2(W))
    h=rng.standard_normal((n,n)); h=(h+h.T)/2; h-=np.trace(h)/n*np.eye(n); h/=np.linalg.norm(h)
    u=np.einsum('ikpq->pqik',W); C=np.einsum('ipjq->pqij',W); N=np.einsum('impq,kmpq->ik',W,W)
    comm=u@h-h@u
    L=0.25*np.einsum('pqij,pqij->',comm,comm)+np.einsum('pqij,pqji->',C@h,C@h)-0.5*np.trace(N@h@h)
    lhs=np.einsum('ij,ij->',ring(Q(W),h),h)
    print(f"  n={n} lhs={lhs:+.9f}  LOSS-||ring h||^2={L-np.sum(ring(W,h)**2):+.9f}  diff={lhs-(L-np.sum(ring(W,h)**2)):.2e}")

# ---- structure of sphere-product bottom eigenvector ----
print()
print("=== sphere product: bottom eigenvector structure + term split ===")
for (p,q) in [(2,2),(2,3),(3,4)]:
    W=sphere_prod(p,q,1.,1.); n=p+q
    W/=np.sqrt(op_norm2(W))
    S0=s20_basis(n); Rm=ring_matrix(W,S0); Rm=(Rm+Rm.T)/2
    ev,evec=np.linalg.eigh(Rm)
    h=np.einsum('a,aij->ij',evec[:,0],S0); h/=np.linalg.norm(h)
    print(f" S^{p}xS^{q}: ring spec (rounded) {np.round(ev,5)}")
    print(f"   h_bottom diag {np.round(np.diag(h),5)}  offdiag max {np.abs(h-np.diag(np.diag(h))).max():.2e}")
    u=np.einsum('ikpq->pqik',W); C=np.einsum('ipjq->pqij',W); N=np.einsum('impq,kmpq->ik',W,W)
    comm=u@h-h@u
    t1=0.25*np.einsum('pqij,pqij->',comm,comm); t2=np.einsum('pqij,pqji->',C@h,C@h); t3=-0.5*np.trace(N@h@h)
    print(f"   t1={t1:+.6f} t2={t2:+.6f} t3={t3:+.6f}  LOSS={t1+t2+t3:+.6f} mu^2/n={ev[0]**2/n:+.6f}")
    print(f"   N eigenvalues {np.round(np.linalg.eigvalsh(N),5)}")

# ---- triple products & other symmetric spaces ----
print()
print("=== multi-factor products / other candidates ===")
def multi_prod(ps,ks=None,n=None):
    m=sum(ps); ks=ks or [1.0]*len(ps)
    R=np.zeros((m,m,m,m)); off=0
    for pi,k in zip(ps,ks):
        idx=range(off,off+pi)
        for i in idx:
            for j in idx:
                for kk in idx:
                    for l in idx:
                        R[i,j,kk,l]+=k*((i==kk)*(j==l)-(i==l)*(j==kk))
        off+=pi
    W=weyl_project(R); return pad(W,n) if n and n>m else W
for ps in [[2,2,2],[2,2,3],[3,3,3],[2,3,4],[2,2,2,2]]:
    W=multi_prod(ps)
    if np.einsum('ijkl,ijkl->',W,W)<1e-18: print(ps,"vanishes"); continue
    report("x".join(f"S^{p}" for p in ps),W)
for ps,ks in [([2,2,2],[1.,1.,3.]),([2,2,2],[1.,2.,5.]),([2,3,4],[1.,4.,0.5])]:
    report(f"{ps} k={ks}",multi_prod(ps,ks))
