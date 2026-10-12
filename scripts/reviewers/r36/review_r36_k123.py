"""K1: is sharp_bilin(I_p,V) = -V/2 on the RAW (pp,mix) support block?
K2: dim of ker L_e  intersect  (pp,mix) support, by projectors.
K3: does the identity hold on the summand, at larger p,q?"""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r36_core import *

def masks(n,p):
    prs,_=pairs_of(n); N=len(prs)
    ty=lambda a: 0 if prs[a][1]<p else (2 if prs[a][0]>=p else 1)
    m=np.zeros((N,N))
    for a in range(N):
        for b in range(N):
            if tuple(sorted((ty(a),ty(b))))==(0,1): m[a,b]=1.0
    return m

def k1(p,q,trials=8,seed=5):
    """generic symmetric V supported on (pp,mix)."""
    n=p+q; A=struct(n); Ip=I_block(n,0,p); M=masks(n,p); N=A.shape[0]
    rng=np.random.default_rng(seed)
    B=weyl_basis(n); D=len(B); Bf=B.reshape(D,N*N)
    out=[]
    for t in range(trials):
        R=rng.normal(size=(N,N)); V=(R+R.T)/2*M; V/=np.linalg.norm(V)
        Y=sharp_bilin(A,Ip,V)
        c=np.tensordot(Y,V)/np.tensordot(V,V)
        rel=np.linalg.norm(Y-c*V)/np.linalg.norm(Y)
        relhalf=np.linalg.norm(Y+0.5*V)/np.linalg.norm(V)
        inW=np.linalg.norm(Bf.T@(Bf@V.reshape(N*N))-V.reshape(N*N))
        out.append((c,rel,relhalf,inW))
    cs=[o[0] for o in out]
    return (np.mean(cs),min(cs),max(cs),max(o[1] for o in out),min(o[1] for o in out),
            max(o[2] for o in out),max(o[3] for o in out))

def supp_subspace(n,p,B):
    """basis of {V in Weyl_n : V supported on (pp,mix)} -- as coefficient vectors."""
    D=B.shape[0]; N=B.shape[1]; M=masks(n,p)
    C=np.array([ (b*(1-M)).reshape(N*N) for b in B ])   # D x N^2
    u,s,vt=np.linalg.svd(C.T@C if False else C, full_matrices=False)
    # nullspace of C (rows indexed by basis elt -> we need coeff c with sum c_i b_i*(1-M)=0)
    u2,s2,vt2=np.linalg.svd(C.T, full_matrices=False)   # (N^2 x D)
    rank=int((s2>1e-9*s2[0]).sum())
    ns=vt2[rank:]   # (D-rank) x D  coefficient vectors
    return ns.T      # D x k

def proj_from_cols(Ucols):
    Qm,_=np.linalg.qr(Ucols)
    return Qm@Qm.T

def k23(p,q):
    n=p+q; t0=time.time()
    A=struct(n); B=weyl_basis(n); D=len(B); N=A.shape[0]
    Ip=I_block(n,0,p)
    W=W_pq(p,q); th=Qop(A,W)[0,0]/W[0,0]; e=W/th
    Le=L_matrix(A,B,e); Le=0.5*(Le+Le.T)
    w,U=np.linalg.eigh(Le)
    Pker=U[:,np.abs(w)<1e-8]@U[:,np.abs(w)<1e-8].T
    S=supp_subspace(n,p,B); Psup=proj_from_cols(S)
    ev=np.linalg.eigvalsh(Pker+Psup)
    dim_int=int(np.sum(ev>2-1e-7))
    Xp=p*(p*p-4)//3
    # the intersection projector
    Pboth=None
    wv,Uv=np.linalg.eigh(Pker+Psup)
    cols=Uv[:,wv>2-1e-7]
    worst=0.0; cbest=[]
    for k in range(cols.shape[1]):
        V=np.tensordot(cols[:,k],B,axes=1); nv=np.linalg.norm(V)
        Y=sharp_bilin(A,Ip,V)
        worst=max(worst,np.linalg.norm(Y+0.5*V)/nv)
        cbest.append(np.tensordot(Y,V)/nv**2)
    return dim_int, Xp*q, S.shape[1], worst, (min(cbest) if cbest else 0), (max(cbest) if cbest else 0), time.time()-t0

if __name__=="__main__":
    print("=== K1: generic symmetric V on the raw (pp,mix) support ===")
    print(f"{'(p,q)':>7} {'mean c':>9} {'c range':>20} {'rel resid (min..max)':>24} {'||sb+V/2||/||V||':>17} {'V in Weyl?':>11}")
    for pq in [(3,4),(3,5),(4,4),(4,5),(5,5),(3,7),(4,6),(5,6)]:
        m,lo,hi,rmax,rmin,h,inW=k1(*pq)
        print(f"{str(pq):>7} {m:9.4f} [{lo:8.4f},{hi:8.4f}] {rmin:10.3f}..{rmax:<10.3f} {h:17.3f} {inW:11.2e}")
    print("\n=== K2/K3: ker L_e  cap  (pp,mix) support, and the identity there ===")
    print(f"{'(p,q)':>7} {'dim int':>8} {'X(p)*q':>8} {'dim Weyl cap supp':>18} {'max||sb(Ip,V)+V/2||/||V||':>26} {'best c range':>22} {'sec':>6}")
    for pq in [(3,4),(3,5),(4,4),(3,6),(4,5),(3,7),(5,5),(4,6),(5,6),(4,7)]:
        try:
            d,pred,ds,worst,clo,chi,dt=k23(*pq)
            print(f"{str(pq):>7} {d:8d} {pred:8d} {ds:18d} {worst:26.2e} [{clo:9.6f},{chi:9.6f}] {dt:6.1f}",flush=True)
        except Exception as ex:
            print(f"{str(pq):>7} FAILED {ex}",flush=True)
