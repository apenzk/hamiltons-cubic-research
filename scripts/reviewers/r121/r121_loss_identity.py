import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np
SP=_os.path.join(_ROOT, 'scripts/reviewers/r121/')
exec(open(SP+'r121_core.py').read().split('# ---------- checks')[0])

def Q(W): return W2(W)+Wsharp_tensor(W)
def ip4(A,B): return np.einsum('ijkl,ijkl->',A,B)/4.0
def theta(W): return ip4(W,Q(W))

def loss_data(W):
    n=W.shape[0]
    S0=s20_basis(n)
    Rm=ring_matrix(W,S0); Rm=(Rm+Rm.T)/2
    ev,evec=np.linalg.eigh(Rm)
    out=[]
    u = np.einsum('ikpq->pqik',W); C = np.einsum('ipjq->pqij',W)
    N = np.einsum('impq,kmpq->ik',W,W)
    for idx in range(len(ev)):
        h = np.einsum('a,aij->ij',evec[:,idx],S0); h/=np.linalg.norm(h)
        comm=u@h-h@u
        t1=0.25*np.einsum('pqij,pqij->',comm,comm)
        t2=np.einsum('pqij,pqji->',C@h,C@h)
        t3=-0.5*np.trace(N@h@h)
        out.append((ev[idx],t1+t2+t3,t1,t2,t3))
    return ev,out

def crit_search(n,rng,iters=4000,t=0.15,seed_W=None):
    W = rand_weyl(n,rng) if seed_W is None else seed_W.copy()
    W/=np.sqrt(op_norm2(W))
    for k in range(iters):
        G=Q(W)
        W = W + t*(G - ip4(G,W)*W)
        W/=np.sqrt(op_norm2(W))
    return W

def report(name,W):
    n=W.shape[0]
    W=W/np.sqrt(op_norm2(W))
    QW=Q(W); lam=ip4(W,QW)
    res=np.abs(QW-lam*W).max()/max(np.abs(W).max(),1e-30)
    ev,out=loss_data(W)
    nu=ev[0]; mu=-nu
    L=out[0][1]
    print(f"{name:34s} n={n} lam={lam:+.6f} crit_res={res:.2e} nu_min={nu:+.5f} mu={mu:+.5f} "
          f"LOSS={L:+.6f} mu^2/n={mu*mu/n:+.6f} LOSS-mu2/n={L-mu*mu/n:+.3e} nu(nu+lam)={nu*(nu+lam):+.6f} "
          f"bound (n-1)/n*mu={(n-1)/n*mu:+.5f} lam<=bound? {lam<=(n-1)/n*mu+1e-9}")
    return dict(lam=lam,res=res,nu=nu,mu=mu,L=L,ev=ev,out=out,W=W)

print("=== identity LOSS = nu(nu+lambda) at critical points, all eigenvectors ===")
rng=np.random.default_rng(7)
for n in [4,5,6]:
    W=crit_search(n,rng)
    d=report(f"grad-ascent max n={n}",W)
    lam=d['lam']
    err=max(abs(L-nu*(nu+lam)) for nu,L,_,_,_ in d['out'])
    print(f"    max_over_ALL_eigvecs |LOSS - nu(nu+lam)| = {err:.2e}   sum LOSS = {sum(L for _,L,_,_,_ in d['out']):.6f}  ||ring||^2={np.sum(d['ev']**2):.6f}")
