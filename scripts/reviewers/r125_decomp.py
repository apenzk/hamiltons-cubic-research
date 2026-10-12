"""Reviewer 125 -- the FIVE-term decomposition of lambda*muK - muK^2, at every point."""
import numpy as np
from scipy.linalg import expm
from r125_lib import struct, sharp, Q, to_tensor, from_tensor, weyl_basis, project

def Kof(M,pos,n):
    K=np.zeros((n,n))
    for (a,b),k in pos.items(): K[a,b]=K[b,a]=M[k,k]
    return K

def decomp(M,c,pos,n,v):
    """lam*muK - muK^2 = ||Goff||^2 + v'Rv - Dir - SigA - SigB"""
    W=to_tensor(M,pos,n)
    K=Kof(M,pos,n)
    A=np.array([W[a,:,a,:] for a in range(n)])
    B=np.array([[W[a,:,b,:] for b in range(n)] for a in range(n)])
    Rab=np.zeros((n,n))
    for (a,b),k in pos.items():
        r=np.sum(M[k,:]**2)-M[k,k]**2; Rab[a,b]=Rab[b,a]=r
    G=np.einsum('a,apq->pq',v,A); Goff=G-np.diag(np.diag(G))
    Dir=0.5*sum(K[a,b]**2*(v[a]-v[b])**2 for a in range(n) for b in range(n))
    Aoff=A-np.array([np.diag(np.diag(A[a])) for a in range(n)])
    SigA=float(np.sum(v**2*np.einsum('apq,apq->a',Aoff,Aoff)))
    SigB=sum(v[a]*v[b]*np.trace(B[a,b]@B[a,b]) for a in range(n) for b in range(n) if a!=b)
    return dict(Goff=float(np.sum(Goff**2)),R=float(v@Rab@v),Dir=float(Dir),
                SigA=SigA,SigB=float(SigB),muK=float(v@K@v),K=K,
                diagGerr=float(np.linalg.norm(np.diag(G)-(v@K@v)*v)))

def report(M,c,pos,n,label):
    lam=float(np.sum(Q(M,c)*M)); res=np.linalg.norm(Q(M,c)-lam*M)
    K=Kof(M,pos,n); ev,evec=np.linalg.eigh(K)
    out=[]
    for tag,v in (('top',evec[:,-1]),('bot',evec[:,0])):
        d=decomp(M,c,pos,n,v)
        lhs=lam*d['muK']-d['muK']**2
        rhs=d['Goff']+d['R']-d['Dir']-d['SigA']-d['SigB']
        print(f"{label:22s} n={n} lam={lam:.6f} res={res:.1e} {tag}: muK={d['muK']:+.6f} "
              f"LHS={lhs:+.7f}  = Goff{d['Goff']:+.7f} +R{d['R']:+.7f} -Dir{d['Dir']:+.7f} "
              f"-SigA{d['SigA']:+.7f} -SigB{d['SigB']:+.7f}  err={abs(lhs-rhs):.1e}")
        out.append(d)
    print(f"{'':22s}   Goff<=SigA? {out[0]['Goff']:.6f} vs {out[0]['SigA']:.6f} -> "
          f"{'yes' if out[0]['Goff']<=out[0]['SigA']+1e-12 else 'NO'};  lambda<=muKmax: "
          f"{'HOLDS' if lam<=ev[-1]+1e-9 else 'FAILS'} ({lam:.4f} vs {ev[-1]:.4f})")
    return lam,ev,out

def Jmat(m):
    n=2*m; J=np.zeros((n,n))
    for k in range(m): J[2*k,2*k+1]=1.0; J[2*k+1,2*k]=-1.0
    return J
def fs(m):
    n=2*m; J=Jmat(m); d=np.eye(n)
    return (np.einsum('ik,jl->ijkl',d,d)-np.einsum('il,jk->ijkl',d,d)
            +np.einsum('ik,jl->ijkl',J,J)-np.einsum('il,jk->ijkl',J,J)
            +2*np.einsum('ij,kl->ijkl',J,J))
def spsq(p,q,pr,pos,N):
    x=1.0/(p*(p-1)); y=1.0/(q*(q-1)); z=-1.0/(p*q)
    lam=np.zeros(N)
    for a,(i,j) in enumerate(pr):
        lam[a]= x if (i<p and j<p) else (y if (i>=p and j>=p) else z)
    M=np.diag(lam); return M/np.linalg.norm(M)

print("========== FIVE-TERM DECOMPOSITION ==========")
for n in (6,8):
    b,pr,pos,N,c=weyl_basis(n)
    m=n//2
    M=from_tensor(fs(m),pos); M=project(M,b); M/=np.linalg.norm(M)
    if np.sum(M*Q(M,c))<0: M=-M
    report(M,c,pos,n,f"CP^{m}")
    for (p,q) in (((3,3),) if n==6 else ((4,4),(3,5))):
        report(spsq(p,q,pr,pos,N),c,pos,n,f"S^{p}xS^{q}")
    # non-diagonal critical points from random starts
    rng=np.random.default_rng(7); seen=set()
    for tr in range(25):
        co=rng.standard_normal(len(b)); X=np.einsum('k,kab->ab',co,b); X/=np.linalg.norm(X)
        for it in range(6000):
            Gm=project(Q(X,c),b); l=np.sum(Gm*X); r=Gm-l*X
            if np.linalg.norm(r)<1e-13: break
            X=X+0.12*r; X/=np.linalg.norm(X)
        Gm=project(Q(X,c),b); l=float(np.sum(Gm*X))
        if np.linalg.norm(Gm-l*X)>1e-9: continue
        key=round(l,6)
        if key in seen: continue
        seen.add(key)
        report(X,c,pos,n,f"crit(random,lam={l:.4f})")
    print()

print("========== RANDOM WEYL: sign census of each of the five terms (top eigvec) ==========")
for n in (5,6,7,8):
    b,pr,pos,N,c=weyl_basis(n)
    rng=np.random.default_rng(101)
    cnt={'R<0':0,'Dir=0':0,'SigB<0':0,'net<0':0}
    goff_frac=[]
    T=200
    for _ in range(T):
        co=rng.standard_normal(len(b)); M=np.einsum('k,kab->ab',co,b); M/=np.linalg.norm(M)
        K=Kof(M,pos,n); ev,evec=np.linalg.eigh(K); v=evec[:,-1]
        d=decomp(M,c,pos,n,v)
        net=d['Goff']+d['R']-d['Dir']-d['SigA']-d['SigB']
        cnt['R<0']+= d['R']<0; cnt['SigB<0']+= d['SigB']<0; cnt['net<0']+= net<0
        goff_frac.append(d['Goff']/(d['Goff']+d['muK']**2))
    print(f" n={n}, {T} random Weyl, v=top eigvec of K: v'Rv<0 in {cnt['R<0']}, "
          f"SigB<0 in {cnt['SigB<0']}, NET correction<0 in {cnt['net<0']}")
    print(f"        ||Goff||^2/||G||^2 mean={np.mean(goff_frac):.3f} range=[{min(goff_frac):.3f},{max(goff_frac):.3f}]")
