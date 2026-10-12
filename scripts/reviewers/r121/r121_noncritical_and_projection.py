import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np
SP=_os.path.join(_ROOT, 'scripts/reviewers/r121/')
exec(open(SP+'r121_catalogue.py').read().split('print("=== padded CP^2')[0])

def bottom(W):
    n=W.shape[0]; S0=s20_basis(n); Rm=ring_matrix(W,S0); Rm=(Rm+Rm.T)/2
    ev,evec=np.linalg.eigh(Rm)
    h=np.einsum('a,aij->ij',evec[:,0],S0); h/=np.linalg.norm(h)
    return ev,h
def LOSS(W,h):
    u=np.einsum('ikpq->pqik',W); C=np.einsum('ipjq->pqij',W); N=np.einsum('impq,kmpq->ik',W,W)
    comm=u@h-h@u
    return (0.25*np.einsum('pqij,pqij->',comm,comm), np.einsum('pqij,pqji->',C@h,C@h), -0.5*np.trace(N@h@h))

print("=== (b/d) LOSS >= mu^2/n at RANDOM NON-CRITICAL unit Weyl tensors? ===")
for n in [4,5,6,7]:
    rng=np.random.default_rng(500+n); bad=0; worst=9e9
    for t in range(200):
        W=rand_weyl(n,rng); W/=np.sqrt(op_norm2(W))
        ev,h=bottom(W); mu=-ev[0]; L=sum(LOSS(W,h))
        d=L-mu*mu/n
        worst=min(worst,d); bad+= d< -1e-10
    print(f"  n={n}: violations {bad}/200, worst LOSS-mu^2/n = {worst:+.6f}")

print()
print("=== (c) diagonal W: LOSS == sum_{i<j} w_ij^2 (v_i-v_j)^2 ?  (Cauchy-Schwarz route) ===")
def diag_weyl(n,rng):
    A=rng.standard_normal((n,n)); A=(A+A.T)/2; np.fill_diagonal(A,0)
    # enforce zero row sums (Ricci-flat) by projection onto {hollow sym, row sums 0}
    for _ in range(400):
        r=A.sum(1); A-= (np.add.outer(r,r)/(n-2) - r.sum()/((n-1)*(n-2))*np.ones((n,n)))
        np.fill_diagonal(A,0)
    W=np.zeros((n,n,n,n))
    for i in range(n):
        for j in range(n):
            if i!=j:
                W[i,j,i,j]+=A[i,j]; W[i,j,j,i]-=A[i,j]
    return W,A
for n in [5,6,7]:
    rng=np.random.default_rng(900+n)
    W,A=diag_weyl(n,rng)
    print(f"  n={n} rowsum resid {np.abs(A.sum(1)).max():.2e} Ricci {np.abs(ricci(W)).max():.2e} Bianchi {np.abs(W+W.transpose(0,2,3,1)+W.transpose(0,3,1,2)).max():.2e}")
    W/=np.sqrt(op_norm2(W)); A/=np.sqrt(op_norm2(W)*0+1)  # rescale A the same way
    A = np.array([[W[i,j,i,j] for j in range(n)] for i in range(n)])
    ev,h=bottom(W); mu=-ev[0]
    v=np.diag(h); offd=np.abs(h-np.diag(v)).max()
    L=sum(LOSS(W,h))
    cs=sum(A[i,j]**2*(v[i]-v[j])**2 for i in range(n) for j in range(i+1,n))
    print(f"    h offdiag {offd:.2e}  mu={mu:.6f} vs lam_max(S restricted)={np.linalg.eigvalsh(A)[-1]:.6f}")
    print(f"    LOSS={L:.9f}   sum w^2(v_i-v_j)^2={cs:.9f}   diff={L-cs:.2e}   mu^2/n={mu*mu/n:.6f}  slack={L-mu*mu/n:+.4f}")

print()
print("=== projection estimate:  max mu over unit Weyl tensors  vs  sqrt(2(n-2)/(n-1)) ===")
def Zproj(h,n):
    T=np.einsum('ik,jl->ijkl',h,h)-np.einsum('il,jk->ijkl',h,h)
    return weyl_project(T)
for n in [4,5,6,7,8]:
    rng=np.random.default_rng(31+n); best=0
    for t in range(60):
        h=rng.standard_normal((n,n)); h=(h+h.T)/2; h-=np.trace(h)/n*np.eye(n); h/=np.linalg.norm(h)
        for it in range(300):
            Z=Zproj(h,n); Wb=Z/np.sqrt(op_norm2(Z))     # best W for this h
            # gradient of mu(h)= -<ring W h,h> wrt h  with W fixed = -2 ring(W) h
            g=-2*ring(Wb,h); g=(g+g.T)/2; g-=np.trace(g)/n*np.eye(n)
            h=h+0.15*g; h-=np.trace(h)/n*np.eye(n); h/=np.linalg.norm(h)
        Z=Zproj(h,n); Wb=Z/np.sqrt(op_norm2(Z))
        mu=-np.einsum('ij,ij->',ring(Wb,h),h)
        best=max(best,mu)
    print(f"  n={n}: max mu found {best:.6f}   sqrt(2(n-2)/(n-1)) = {np.sqrt(2*(n-2)/(n-1)):.6f}   (n-1)/n*mu={best*(n-1)/n:.6f}  Theta_n={np.sqrt(2*(n-1)*(n-2))/n:.6f}")
