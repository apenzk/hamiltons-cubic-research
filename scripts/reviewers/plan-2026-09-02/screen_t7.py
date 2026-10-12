# SCREEN (seconds): Gram matrices G^{mu nu} at S^3xS^3 and padded CP^2, n=6.
import sys, numpy as np, itertools
sys.path.insert(0, 'scripts/lib')
from curvature_operator import Lambda2
n=6; L2=Lambda2(n); N=L2.N
# structure constants c[a,b,c] = <[e_a,e_b],e_c>, <X,Y>=1/2 tr(X^T Y)
E=np.eye(N)
c=np.zeros((N,N,N))
for a in range(N):
    for b in range(N):
        c[a,b]=L2.bracket(E[a],E[b])
print("antisym", np.abs(c+np.swapaxes(c,1,2)).max(), np.abs(c+np.swapaxes(c,0,1)).max())
print("Killing", np.abs(np.einsum('acd,bcd->ab',c,c)-2*(n-2)*np.eye(N)).max())
def analyse(W,name):
    lam,U=np.linalg.eigh(W)
    # structure constants in eigenbasis
    C=np.einsum('ia,jb,kc,ijk->abc',U,U,U,c)
    Wsharp_lib=L2.R_sharp_matrix(W)
    Wsharp_mine=0.5*np.einsum('acd,bcd,c,d->ab',C,C,lam,lam)
    Wsharp_mine=U@Wsharp_mine@U.T
    print(name,"sharp normalisation check", np.abs(Wsharp_lib-Wsharp_mine).max())
    Q=W@W+Wsharp_lib; theta=np.trace(Q@W)/np.trace(W@W)
    print(name,"theta",theta,"crit residual",np.abs(Q-theta*W).max(), "norm", np.trace(W@W)/2)
    # eigenvalue classes
    vals=[]; 
    for l in lam:
        if not any(abs(l-v)<1e-9 for v in vals): vals.append(l)
    cls=[[k for k in range(N) if abs(lam[k]-v)<1e-9] for v in vals]
    print(name,"eigenvalues",[round(v,6) for v in vals],"dims",[len(x) for x in cls])
    G={}
    for i,j in itertools.product(range(len(vals)),repeat=2):
        Ci=C[:, cls[i], :][:, :, cls[j]]
        G[(i,j)]=np.einsum('acd,bcd->ab',Ci,Ci)
    # identities
    S0=sum(G.values()); S1=sum(vals[i]*G[(i,j)] for (i,j) in G); S2=sum(vals[i]*vals[j]*G[(i,j)] for (i,j) in G)
    print(name,"(A)",np.abs(S0-2*(n-2)*np.eye(N)).max(),"(B)",np.abs(S1+2*np.diag(lam)).max(),"(C)",np.abs(S2-2*np.diag(lam*(theta-lam))).max())
    # block structure of each G
    for key,g in G.items():
        offblock=max(np.abs(g[np.ix_(cls[a],cls[b])]).max() for a in range(len(vals)) for b in range(len(vals)) if a!=b)
        nonscalar=max(np.abs(g[np.ix_(cls[a],cls[a])]-np.trace(g[np.ix_(cls[a],cls[a])])/len(cls[a])*np.eye(len(cls[a]))).max() for a in range(len(vals)))
        scal=[round(np.trace(g[np.ix_(cls[a],cls[a])])/len(cls[a]),6) for a in range(len(vals))]
        print(name,"G",(round(vals[key[0]],4),round(vals[key[1]],4)),"offblock",round(offblock,12),"nonscalar",round(nonscalar,12),"block scalars",scal,"rank",np.linalg.matrix_rank(g,1e-9))
    # per-row lower bound on g_k
    T=C**2
    gk=np.einsum('kab,a,b->k',T,lam,lam*0+1)  # placeholder
    gk=np.array([sum(T[k,a,b]*(lam[a]-lam[b])**2 for a in range(N) for b in range(N)) for k in range(N)])
    ell=8*lam*((n-1)*lam/(n-2)-theta)
    print(name,"sum g",gk.sum(),"4(n-1)=",4*(n-1),"min(g-ell)",(gk-ell).min(), "rows tight", int((np.abs(gk-ell)<1e-9).sum()))
    Nm=-lam[lam<-1e-9].sum(); Pm=(lam[lam<-1e-9]**2).sum()
    print(name,"variance bound",(n-1)*(1-2*Pm/(n-2))/(2*Nm),"a priori",(n-1)*(-lam.min()),"theta",theta)
# balanced S^3 x S^3
W=np.zeros((N,N))
for a,(i,j) in enumerate(L2.pairs):
    W[a,a]= 1.0 if (i<3)==(j<3) else -1.0
h=np.sqrt(1/(6+9*(6/4)**2)); # placeholder, fix via trace-free & norm below
dh=6; dm=9; m=np.sqrt(2*(n-2)/(n**2*(n-1))); hh=n*m/(n-2)
for a,(i,j) in enumerate(L2.pairs):
    W[a,a]= hh if (i<3)==(j<3) else -m
analyse(W,"S3xS3")
# padded CP^2 on so(4) subset so(6): self-dual forms
def vec(pairs_coef):
    v=np.zeros(N)
    for (i,j),co in pairs_coef: v[L2.idx[(i,j)]]=co
    return v/np.linalg.norm(v)
om=vec([((0,1),1),((2,3),1)]); s2=vec([((0,2),1),((1,3),-1)]); s3=vec([((0,3),1),((1,2),1)])
eps=np.sqrt(1/6)
W2=2*eps*np.outer(om,om)-eps*np.outer(s2,s2)-eps*np.outer(s3,s3)
analyse(W2,"paddedCP2")
