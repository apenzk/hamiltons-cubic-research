import sys; sys.path.insert(0,'scripts/reviewers/r335')
import numpy as np, w335 as w
from itertools import combinations
from scipy.optimize import linprog

def setup(n):
    c=w.struct(n); B=np.array(w.weyl_basis(n)); N=c.shape[0]; d=len(B)
    return c,B,N,d

def gmap(x,B,c):
    W=np.tensordot(x,B,axes=1)
    Q=w.Qmap(W,c)
    return np.einsum('ij,kij->k',Q,B), W

def jac(x,B,c):
    W=np.tensordot(x,B,axes=1); d=len(B)
    J=np.zeros((d,d))
    for j in range(d):
        V=B[j]
        DQ=W@V+V@W+w.sharp(W,V,c)+w.sharp(V,W,c)
        J[:,j]=np.einsum('ij,kij->k',DQ,B)
    return J

def newton_crit(seed,B,c,tries=400,rng=None):
    d=len(B); rng=rng or np.random.default_rng(seed)
    out=[]
    for t in range(tries):
        x=rng.normal(size=d)*0.5
        ok=False
        for it in range(200):
            g,W=gmap(x,B,c); F=g-x
            if np.linalg.norm(F)<1e-12: ok=True; break
            J=jac(x,B,c)-np.eye(d)
            try: dx=np.linalg.solve(J,-F)
            except Exception: break
            s=1.0
            for _ in range(30):
                xn=x+s*dx; gn,_=gmap(xn,B,c)
                if np.linalg.norm(gn-xn)<np.linalg.norm(F): break
                s*=0.5
            x=x+s*dx
            if np.linalg.norm(x)>1e6: break
        if ok and np.linalg.norm(x)>1e-6:
            out.append(x.copy())
    return out

def lp_max_theta(lam,n,use=('A','B','C')):
    N=len(lam); tri=list(combinations(range(N),3))
    nt=len(tri)
    Aeq=[];beq=[]
    # variable order: t (nt), theta (1)
    for a in range(N):
        rowA=np.zeros(nt+1); rowB=np.zeros(nt+1); rowC=np.zeros(nt+1)
        for k,(i,j,l) in enumerate(tri):
            if a not in (i,j,l): continue
            o=[z for z in (i,j,l) if z!=a]
            b,cc=o
            rowA[k]=1.0
            rowB[k]=lam[b]+lam[cc]
            rowC[k]=lam[b]*lam[cc]
        rowC[nt]=-lam[a]
        if 'A' in use: Aeq.append(rowA); beq.append(n-2)
        if 'B' in use: Aeq.append(rowB); beq.append(-2*lam[a])
        if 'C' in use: Aeq.append(rowC); beq.append(-lam[a]**2)
    obj=np.zeros(nt+1); obj[nt]=-1.0
    bounds=[(0,None)]*nt+[(None,None)]
    r=linprog(obj,A_eq=np.array(Aeq),b_eq=np.array(beq),bounds=bounds,method='highs')
    return (None if not r.success else -r.fun), r.status
