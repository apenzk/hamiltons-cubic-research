import numpy as np, sys, itertools
sys.path.insert(0,'scripts/reviewers/r321')
from core import *
from t5_hunt_lib import find_crit
np.set_printoptions(suppress=True,linewidth=200,precision=6)

def full_blocks(W,AD,C,n,tol=1e-9):
    lam,Phi=np.linalg.eigh(W)
    mi=np.where(lam<-tol)[0]; pi=np.where(lam>tol)[0]
    Ce=np.einsum('abc,aA,bB,cC->ABC',C,Phi,Phi,Phi,optimize=True)
    Smmm=float((Ce[np.ix_(mi,mi,mi)]**2).sum()); Smpp=float((Ce[np.ix_(mi,pi,pi)]**2).sum())
    E=np.where(abs(lam-lam[0])<1e-8)[0]
    v=Phi[:,E[0]]
    cv=np.einsum('a,abc->bc',Phi.T@v,Ce); L=np.outer(lam,lam)
    Bmm=float((L*cv**2)[np.ix_(mi,mi)].sum()); Bmp=float((L*cv**2)[np.ix_(mi,pi)].sum())
    Bpp=float((L*cv**2)[np.ix_(pi,pi)].sum())
    lhs=float(v@sharp(W,AD)@v); th=P_func(W,AD)
    return dict(th=th,crit=np.linalg.norm(Q(W,AD)-th*W),lam=lam,mult=len(E),
                Smmm=Smmm,Smpp=Smpp,Bmm=Bmm,Bmp=Bmp,Bpp=Bpp,lhs=lhs,
                tot=0.5*Bmm+Bmp+0.5*Bpp,dm=len(mi),dp=len(pi),dk=W.shape[0]-len(mi)-len(pi))

def graph_stats(M,n,tol=1e-9):
    iu=np.triu_indices(n,1); vals=M[iu]
    k=int(np.argmin(vals)); i,j=iu[0][k],iu[1][k]
    mult=int((np.abs(vals-vals[k])<1e-9).sum())
    neg=M<-tol; pos=M>tol; np.fill_diagonal(neg,False); np.fill_diagonal(pos,False)
    mm=[k2 for k2 in range(n) if k2 not in(i,j) and neg[i,k2] and neg[j,k2]]
    pp=[k2 for k2 in range(n) if k2 not in(i,j) and pos[i,k2] and pos[j,k2]]
    Tneg=[(a,b,c) for a,b,c in itertools.combinations(range(n),3) if neg[a,b] and neg[b,c] and neg[a,c]]
    Tmpp=[]
    for a,b,c in itertools.combinations(range(n),3):
        for (x,y,z) in [(a,b,c),(b,c,a),(c,a,b)]:
            if neg[x,y] and pos[y,z] and pos[x,z]: Tmpp.append((x,y,z))
    return (i,j),mult,mm,pp,Tneg,Tmpp,(np.abs(vals)<tol).any()

rng=np.random.default_rng(4242)
cache={}
bestA=None; bestB=None
for n in [7,8,9]:
    WB,_=weyl_basis(n); C,_=struct(n); AD=ad_mats(C); cache[n]=(C,AD)
    for M in find_crit(n,rng,220):
        e,mult,mm,pp,Tneg,Tmpp,haszero=graph_stats(M,n)
        if haszero or mult>1: continue
        th=float(((M*M+M@M)*M).sum())/2.0
        if len(Tneg)>0 and len(mm)==0 and (bestA is None or th>bestA[0]): bestA=(th,n,M.copy(),e,Tneg,mm,pp)
        if len(Tmpp)>0 and len(pp)==0 and (bestB is None or th>bestB[0]): bestB=(th,n,M.copy(),e,Tmpp,mm,pp)

for tag,best in [("A: S_mmm>0 yet m x m block = 0",bestA),("B: S_mpp>0 yet p x p block = 0",bestB)]:
    th,n,M,e,T,mm,pp=best
    C,AD=cache[n]
    W=diag_weyl(M,n); W=W/np.linalg.norm(W)
    d=full_blocks(W,AD,C,n)
    print(f"\n=== COUNTEREXAMPLE {tag} ===  n={n}")
    print("M =\n",M)
    print(f"  row sums {np.abs(M.sum(1)).max():.1e}  hollow {np.abs(np.diag(M)).max():.1e}")
    print(f"  theta={d['th']:.9f}  crit residual={d['crit']:.2e}  dim(m,p,ker)=({d['dm']},{d['dp']},{d['dk']})  mult(lam_min)={d['mult']}")
    print(f"  lam_min={d['lam'][0]:.9f} at edge {e};  S_mmm={d['Smmm']:.6f}   S_mpp={d['Smpp']:.6f}")
    print(f"  (1/2)mm={0.5*d['Bmm']:+.9e}   mp={d['Bmp']:+.9f}   (1/2)pp={0.5*d['Bpp']:+.9e}")
    print(f"  sum={d['tot']:+.9f}  <v,W#v>={d['lhs']:+.9f}  lam_min(th-lam_min)={d['lam'][0]*(d['th']-d['lam'][0]):+.9f}")
    print(f"  witnessing triangles (first 4): {T[:4]}")
    np.save(f"/tmp/r321_best{tag[0]}.npy", M)
