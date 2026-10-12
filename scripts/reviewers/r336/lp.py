import sys,os; sys.path.insert(0,os.path.dirname(__file__))
import numpy as np, itertools
from scipy.optimize import linprog

def pinned_lp(lam,n,maximize=True,theta_fixed=None):
    """Max/min theta over T>=0 sym, zero on repeats, with (A),(B),(C).
       Unordered-triple variables T_{a<b<c}."""
    N=len(lam); tri=list(itertools.combinations(range(N),3))
    V=len(tri); nv=V+1   # last variable = theta
    rows=[];rhs=[]
    for a in range(N):
        rA=np.zeros(nv); rB=np.zeros(nv); rC=np.zeros(nv)
        for k,(i,j,l) in enumerate(tri):
            if a not in (i,j,l): continue
            o=[x for x in (i,j,l) if x!=a]; b,cc=o
            rA[k]+=1.0
            rB[k]+=lam[b]+lam[cc]
            rC[k]+=lam[b]*lam[cc]
        rC[V]=-lam[a]
        rows.append(rA); rhs.append(n-2.0)
        rows.append(rB); rhs.append(-2.0*lam[a])
        rows.append(rC); rhs.append(-lam[a]**2)
    Aeq=np.array(rows); beq=np.array(rhs)
    c=np.zeros(nv); c[V]=-1.0 if maximize else 1.0
    bnds=[(0,None)]*V+[(None,None)]
    r=linprog(c,A_eq=Aeq,b_eq=beq,bounds=bnds,method='highs')
    if not r.success: return None
    return (-r.fun if maximize else r.fun)
