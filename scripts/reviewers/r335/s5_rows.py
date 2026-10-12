import sys; sys.path.insert(0,'scripts/reviewers/r335')
import numpy as np, w335 as w, sharp_cases as sc, spheres as sp
from itertools import combinations

def rowbounds(lam,n,exclude_a=True,distinct=True):
    """min over rows a of the (C)-row upper bound on theta."""
    N=len(lam); best=np.inf; who=None
    for a in range(N):
        if abs(lam[a])<1e-12: continue
        idx=[b for b in range(N) if b!=a] if exclude_a else list(range(N))
        prods=[lam[b]*lam[cc] for b,cc in combinations(idx,2)] if distinct else \
              [lam[b]*lam[cc] for b in idx for cc in idx]
        m=min(prods); M=max(prods)
        v = lam[a]+(n-2)*(M if lam[a]>0 else m)/lam[a]
        if v<best: best=v; who=a
    return best,who

def padded_cp2(n):
    c=w.struct(n); B=w.weyl_basis(n)
    R=sc.fs_curv(4); S4=sc.op_from_tensor(R,4)
    B4=w.weyl_basis(4); PW4=w.proj_weyl(S4,B4); PW4/=np.sqrt((PW4*PW4).sum())
    P4=w.pairs(4); P=w.pairs(n); idx={p:k for k,p in enumerate(P)}
    N=len(P); S=np.zeros((N,N))
    for a,pa in enumerate(P4):
        for b,pb in enumerate(P4):
            S[idx[pa],idx[pb]]=PW4[a,b]
    return S,c,B

for n in [6,12]:
    S,c,B=padded_cp2(n)
    d=np.sqrt(((S-w.proj_weyl(S,B))**2).sum()); W=S/np.sqrt((S*S).sum())
    lam=np.sort(np.linalg.eigvalsh(W)); Q=w.Qmap(W,c); th=float((W*Q).sum())
    l70=lam[0]+(n-2)*lam[-1]; pib=(n-1)*abs(lam[0])
    rb,who=rowbounds(lam,n)
    rb_all,_=rowbounds(lam,n,exclude_a=False)
    print("padded W_CP2 in n=%d: dist to W_n=%.1e  theta=%.6f  critres=%.1e"%(n,d,th,np.linalg.norm(Q-th*W)))
    print("   lmin=%.6f lmax=%.6f  Lemma70=%.6f  Pi-bound=%.6f  row-min(excl a)=%.6f (row %d)  row-min(no excl)=%.6f"%(
          lam[0],lam[-1],l70,pib,rb,who,rb_all))
    print("   spec:",np.round(np.unique(np.round(lam,7)),6))

print()
cases=[]
n=6; c=w.struct(n); B=w.weyl_basis(n); N=len(w.pairs(n))
for name,S in [("S3xS3",sp.prod_weyl(6,3)),("S2xS4",sp.prod_weyl(6,2)),("CP3",sc.op_from_tensor(sc.fs_curv(6),6))]:
    cases.append((name,w.proj_weyl(S,B)))
P=w.pairs(n); rows=[t for t,(i,j) in enumerate(P) if j==i+1 and i%2==0]
Pi=np.zeros((N,N))
for t in rows: Pi[t,t]=1
cases.append(("torus6",w.proj_weyl(Pi-len(rows)/N*np.eye(N),B)))
for name,PW in cases:
    W=PW/np.sqrt((PW*PW).sum()); lam=np.sort(np.linalg.eigvalsh(W)); th=float((W*w.Qmap(W,c)).sum())
    rb,who=rowbounds(lam,n); l70=lam[0]+(n-2)*lam[-1]; pib=(n-1)*abs(lam[0])
    print("%-8s theta=%.6f  Lemma70=%.6f  Pi=%.6f  row-min=%.6f  valid(>=theta)=%s"%(name,th,l70,pib,rb,rb>=th-1e-9))
