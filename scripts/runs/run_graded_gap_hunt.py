"""Falsifier hunt: graded critical points at FIXED n with a small nonzero spectral gap.

Fix the involution sigma = diag(1,1,1,-1,-1,-1) on R^6, restrict to the sigma-invariant
subspace of Weyl_6, solve criticality Q(W) = theta W there by Newton from many starts,
and measure the nonzero gap of each solution.  A solution with a tiny gap is the falsifier.
"""
import numpy as np, itertools
rng=np.random.default_rng(521)
n=6; pr=list(itertools.combinations(range(n),2)); N=len(pr)
def Eij(i,j):
    A=np.zeros((n,n)); A[i,j]=1; A[j,i]=-1; return A
B=[Eij(i,j) for (i,j) in pr]
c=np.zeros((N,N,N))
for a in range(N):
    for b in range(N):
        C=B[a]@B[b]-B[b]@B[a]
        for g,(k,l) in enumerate(pr): c[a,b,g]=C[k,l]
def sharp(M): return 0.5*np.einsum('agd,bez,ge,dz->ab',c,c,M,M,optimize=True)
def proj_weyl_basis():
    A=rng.standard_normal((400,n,n,n,n)); out=[]
    for X in A:
        R=X-X.transpose(1,0,2,3); R=R-R.transpose(0,1,3,2); R=R+R.transpose(2,3,0,1)
        R=R-(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3))/3
        g=np.eye(n); Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric); E=Ric-s/n*g
        KN=lambda P,Qm:(np.einsum('ik,jl->ijkl',P,Qm)+np.einsum('jl,ik->ijkl',P,Qm)
                        -np.einsum('il,jk->ijkl',P,Qm)-np.einsum('jk,il->ijkl',P,Qm))
        W=R-KN(E,g)/(n-2)-s/(2*n*(n-1))*KN(g,g)
        out.append(np.array([[W[i,j,k,l] for (k,l) in pr] for (i,j) in pr]).ravel())
    U,sv,_=np.linalg.svd(np.array(out).T,full_matrices=False)
    d=n*(n+1)*(n+2)*(n-3)//12
    return [U[:,k].reshape(N,N) for k in range(d)]
BW=proj_weyl_basis()
# sigma-invariant subspace
sig=np.diag([1,1,1,-1,-1,-1.0])
P=np.zeros((N,N))
for a,(i,j) in enumerate(pr):
    v=sig[i,i]*sig[j,j]; P[a,a]=v
def act(M): return P@M@P
BS=[]
for b in BW:
    x=(b+act(b))/2
    if np.linalg.norm(x)>1e-9: BS.append(x)
G=np.array([[np.sum(a*b) for b in BS] for a in BS])
w,V=np.linalg.eigh(G); keep=[k for k in range(len(w)) if w[k]>1e-8]
BS=[sum(V[i,k]*BS[i] for i in range(len(BS)))/np.sqrt(w[k]) for k in keep]
d=len(BS); print(f"dim of the sigma-invariant subspace of Weyl_6: {d}")
def Mof(v): return sum(v[i]*BS[i] for i in range(d))
from scipy.optimize import least_squares
def resid(v):
    """criticality on the unit sphere: projected gradient zero, plus the norm constraint."""
    M=sum(v[i]*BS[i] for i in range(d))
    nm2=np.sum(M*M)
    Q=M@M+sharp(M); th=np.sum(Q*M)/nm2
    Rr=Q-th*M
    return np.concatenate([[np.sum(Rr*b) for b in BS],[nm2-1.0]])
def slack_S(M):
    """graded-compression slack: S = 0 is necessary for gradedness."""
    lam,V=np.linalg.eigh(M)
    neg=[k for k in range(len(lam)) if lam[k]<-1e-9]
    if not neg: return 0.0
    cE=np.einsum('abg,aA,bB,gG->ABG',c,V,V,V,optimize=True)
    T=cE**2
    return float(T[np.ix_(neg,neg,neg)].sum())
sols=[]
for t in range(400):
    v0=rng.standard_normal(d)
    M0=sum(v0[i]*BS[i] for i in range(d)); v0/=np.linalg.norm(M0)
    r=least_squares(resid,v0,method='lm',xtol=3e-16,ftol=3e-16,gtol=3e-16,max_nfev=20000)
    res=np.linalg.norm(r.fun)
    if res>1e-12: continue
    v=r.x; M=sum(v[i]*BS[i] for i in range(d)); M/=np.linalg.norm(M)
    th=np.sum((M@M+sharp(M))*M)
    if abs(th)<1e-6: continue
    ev=np.sort(np.abs(np.linalg.eigvalsh(M)))
    sols.append((abs(th),ev,res,slack_S(M)))
sols.sort(key=lambda r:[x for x in r[1] if x>1e-11][0] if any(x>1e-11 for x in r[1]) else 9)
print(f"{len(sols)}/400 converged at residual <= 1e-12\n")
print(f"{'theta':>10} {'residual':>10} {'S':>10} | five smallest |lambda|")
for th,ev,res,Sv in sols[:8]:
    print(f"{th:10.6f} {res:10.1e} {Sv:10.4f} | " + "  ".join(f"{x:.2e}" for x in ev[:5]))
print()
print("READ: if the smallest few |lambda| sit at ~1e-8 or below with residual ~1e-13,")
print("they are numerically zero and the 'tiny gap' is the NEXT eigenvalue up, not a small gap.")
