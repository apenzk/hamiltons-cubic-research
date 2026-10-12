import sys, os
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np, core

def onb_sym(N):
    S=[]
    for a in range(N):
        E=np.zeros((N,N)); E[a,a]=1.0; S.append(E)
    for a in range(N):
        for b in range(a+1,N):
            E=np.zeros((N,N)); E[a,b]=E[b,a]=1/np.sqrt(2.0); S.append(E)
    return np.array(S)

def curv_basis(n):
    """Bianchi-only (algebraic curvature tensors), orthonormal."""
    import itertools
    P,idx=core.pairs_of(n); N=len(P)
    def put(row,i,j,k,l,s):
        if i==j or k==l: return
        if i>j: i,j,s=j,i,-s
        if k>l: k,l,s=l,k,-s
        row[idx[(i,j)],idx[(k,l)]]+=s
    rows=[]
    for (i,j,k,l) in itertools.combinations(range(n),4):
        r=np.zeros((N,N)); put(r,i,j,k,l,1.0); put(r,i,k,l,j,1.0); put(r,i,l,j,k,1.0)
        rows.append(0.5*(r+r.T))
    C=np.array(rows); S=onb_sym(N)
    M=np.einsum('rij,dij->rd',C,S)
    u,s,vt=np.linalg.svd(M); tol=max(M.shape)*s[0]*1e-12; rk=int((s>tol).sum())
    return np.einsum('kd,dij->kij',vt[rk:],S)

for n in (5,6,7):
    P,_=core.pairs_of(n); N=len(P)
    BW=core.weyl_basis(n); BC=curv_basis(n); BS=onb_sym(N)
    for lbl,B in (("Weyl",BW),("Curv(Bianchi)",BC),("Sym^2(L^2)",BS)):
        t=np.zeros((N,N))
        summand=0.0
        for k in range(B.shape[0]):
            s=core.circ(n,B[k],B[k]); t+=s; summand=max(summand,np.linalg.norm(s))
        Id=np.eye(N)
        c=np.sum(t*Id)/N
        print(f"n={n} basis={lbl:14s} dim={B.shape[0]:4d} ||tau||={np.linalg.norm(t):.4e} "
              f"c=<tau,Id>/N={c:+.6f} ||tau-c Id||={np.linalg.norm(t-c*Id):.2e} max|summand|={summand:.3f}")
    # L_Id on Weyl_n
    Id=np.eye(N)
    d=BW.shape[0]; Bf=BW.reshape(d,-1)
    M=np.empty((d,d))
    for k in range(d):
        M[:,k]=Bf@core.circ(n,Id,BW[k]).reshape(-1)
    ev=np.linalg.eigvalsh(0.5*(M+M.T))
    print(f"   L_Id on Weyl_{n}: eigenvalues in [{ev.min():.6f},{ev.max():.6f}], trace={np.trace(M):.6e}")
    # trace of Weyl tensors
    rng=np.random.default_rng(1); co=rng.normal(size=d)
    X=np.einsum('k,kij->ij',co,BW)
    print(f"   tr(X) for random Weyl X: {np.trace(X):.3e}")
