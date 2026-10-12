import sys,time; sys.path.insert(0,'scripts/reviewers/r335')
import numpy as np, w335 as w, crit_lp as cl
from itertools import combinations
from scipy.optimize import linprog
n=6; c,B,N,d=cl.setup(n)
seed=int(sys.argv[1]); NT=int(sys.argv[2]); rng=np.random.default_rng(seed)
tri=list(combinations(range(N),3)); nt=len(tri)
def lp_range(lam):
    Aeq=[];beq=[]
    for a in range(N):
        rA=np.zeros(nt+1); rB=np.zeros(nt+1); rC=np.zeros(nt+1)
        for k,(i,j,l) in enumerate(tri):
            if a not in (i,j,l): continue
            b,cc=[z for z in (i,j,l) if z!=a]
            rA[k]=1.0; rB[k]=lam[b]+lam[cc]; rC[k]=lam[b]*lam[cc]
        rC[nt]=-lam[a]
        Aeq+= [rA,rB,rC]; beq += [n-2,-2*lam[a],-lam[a]**2]
    Aeq=np.array(Aeq); beq=np.array(beq); bnd=[(0,None)]*nt+[(None,None)]
    o=np.zeros(nt+1); o[nt]=-1.0
    hi=linprog(o,A_eq=Aeq,b_eq=beq,bounds=bnd,method='highs')
    lo=linprog(-o,A_eq=Aeq,b_eq=beq,bounds=bnd,method='highs')
    return (-hi.fun if hi.success else None, lo.fun if lo.success else None)
def solve_one(x):
    x=x/np.linalg.norm(x)
    for it in range(120):
        g,W=cl.gmap(x,B,c); th=float(g@x); F=g-th*x
        if np.linalg.norm(F)<1e-13: return x,th,True
        J=cl.jac(x,B,c)-th*np.eye(d); Pp=np.eye(d)-np.outer(x,x)
        A=Pp@J@Pp+np.outer(x,x)
        try: dlt=np.linalg.solve(A,-F)
        except Exception: return x,th,False
        dlt=dlt-(dlt@x)*x; nn=np.linalg.norm(dlt)
        if nn>1.0: dlt*=1.0/nn
        x=x+dlt; x/=np.linalg.norm(x)
    g,_=cl.gmap(x,B,c); th=float(g@x)
    return x,th,np.linalg.norm(g-th*x)<1e-10
res=[];t0=time.time()
for t in range(NT):
    x,th,ok=solve_one(rng.normal(size=d))
    if not ok or abs(th)<1e-6: continue
    W=np.tensordot(x,B,axes=1)
    if th<0: W=-W; th=-th
    lam=np.sort(np.linalg.eigvalsh(W)); nd=len(np.unique(np.round(lam,6)))
    hi,lo=lp_range(lam)
    print("%3d th=%.6f dist=%2d LPmax=%.6f LPmin=%.6f gap=%.6f width=%.6f frac=%.4f"%(
        t,th,nd,hi,lo,hi-th,hi-lo,(th-lo)/(hi-lo) if hi>lo else -1),flush=True)
    res.append([th,nd,hi,lo])
np.save('scripts/reviewers/r335/t10b_%d.npy'%seed,np.array(res))
print("elapsed %.0f found %d"%(time.time()-t0,len(res)))
