# Screen: does R^s carry a Weyl tensor with W^2 proportional to Id on Lambda^2? Minimise the scale-free defect.
import numpy as np, itertools, sys
from scipy.linalg import null_space
from scipy.optimize import minimize
def weyl_basis(s):
    P=list(itertools.combinations(range(s),2)); N=len(P); idx={p:k for k,p in enumerate(P)}
    def R(W,i,j,k,l):
        if i==j or k==l: return 0.0
        sg=1
        if i>j: i,j=j,i; sg=-sg
        if k>l: k,l=l,k; sg=-sg
        return sg*W[idx[(i,j)],idx[(k,l)]]
    # symmetric NxN coordinates
    S=[(a,b) for a in range(N) for b in range(a,N)]
    def mat(v):
        W=np.zeros((N,N))
        for (a,b),x in zip(S,v): W[a,b]=x; W[b,a]=x
        return W
    rows=[]
    E=np.eye(len(S))
    Ws=[mat(E[t]) for t in range(len(S))]
    cons=[]
    for a in range(s):
        for b in range(a,s): cons.append(('ric',a,b))
    for i,j,k,l in itertools.combinations(range(s),4): cons.append(('b',i,j,k,l))
    M=np.zeros((len(cons),len(S)))
    for t,W in enumerate(Ws):
        for r,c in enumerate(cons):
            if c[0]=='ric': M[r,t]=sum(R(W,c[1],m,c[2],m) for m in range(s))
            else:
                i,j,k,l=c[1:]; M[r,t]=R(W,i,j,k,l)+R(W,i,k,l,j)+R(W,i,l,j,k)
    B=null_space(M); return [mat(B[:,q]) for q in range(B.shape[1])], N
for s in map(int,sys.argv[1:]):
    basis,N=weyl_basis(s); d=len(basis); Bt=np.array(basis)
    def F(c):
        W=np.tensordot(c,Bt,1); n2=np.sum(W*W); g=W@W-np.trace(W@W)/N*np.eye(N)
        f=np.sum(g*g)/n2**2
        G=4*(g@W+W@g)/2/n2**2 - 4*f*W/n2
        return f, np.tensordot(Bt,G,([1,2],[0,1]))
    rng=np.random.default_rng(0); best=np.inf
    for st in range(12):
        r=minimize(F,rng.standard_normal(d),jac=True,method='L-BFGS-B',options={'maxiter':3000})
        best=min(best,r.fun)
    print(f's={s}: Weyl dim {d}, N={N}, best defect ||W^2-cI||^2/||W||^4 = {best:.3e}',flush=True)
