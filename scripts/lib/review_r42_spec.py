import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r42_core import *

def e_cpm(m):
    n=2*m
    a=-1.0/(2*m-1); b=(m-2)/((m+1)*(2*m-1)); c=2*(m-1)/(2*m-1)
    return a*P_mm(n)+b*P_su(n)+c*P_omega(n)

def weyl_basis(n, seed=7):
    rng=np.random.default_rng(seed); N=len(pairs(n)); D=dim_weyl(n)
    cols=[]
    while len(cols)<D+8:
        M=rng.standard_normal((N,N)); M=M+M.T
        cols.append(proj_weyl(n,M).ravel())
    A=np.array(cols).T
    Q,R=np.linalg.qr(A)
    keep=np.abs(np.diag(R))>1e-7*np.abs(np.diag(R)).max()
    B=Q[:,keep]
    assert B.shape[1]==D, (B.shape[1],D)
    return B   # (N*N, D)

def Le_matrix(n,e,B):
    N=len(pairs(n)); D=B.shape[1]
    A=Amats(n); Ae=(A.reshape(N*N,N)@e).reshape(N,N,N)     # A_a e
    Aeflat=Ae.reshape(N,N*N)
    out=np.empty((D,D)); leak=0.0
    for d in range(D):
        X=B[:,d].reshape(N,N)
        AX=(A.reshape(N*N,N)@X).reshape(N,N,N)
        T=Aeflat@np.transpose(AX,(0,2,1)).reshape(N,N*N).T
        Y=0.5*(e@X+X@e)-0.25*(T+T.T)
        v=Y.ravel()
        co=B.T@v
        leak=max(leak,np.linalg.norm(v-B@co)/max(1e-30,np.linalg.norm(v)))
        out[:,d]=co
    return out,leak

if __name__=='__main__':
    for m in [3,4,5]:
        n=2*m; t0=time.time()
        e=e_cpm(m); B=weyl_basis(n)
        L,leak=Le_matrix(n,e,B)
        asym=np.abs(L-L.T).max()
        ev=np.linalg.eigvalsh(0.5*(L+L.T))
        # cluster
        vals=[]; 
        for x in ev:
            if vals and abs(x-vals[-1][0])<1e-8: vals[-1]=(vals[-1][0],vals[-1][1]+1)
            else: vals.append((x,1))
        print(f"m={m} n={n} dimW={B.shape[1]} leak(rel)={leak:.2e} asym={asym:.2e} tr={ev.sum():+.2e} time={time.time()-t0:.1f}s")
        for x,k in vals: print(f"     {x:+.12f}  mult {k}")
