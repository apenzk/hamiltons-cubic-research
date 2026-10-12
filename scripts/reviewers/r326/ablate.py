import sys,os; sys.path.insert(0,os.path.dirname(__file__))
import numpy as np, itertools
from scipy.sparse import coo_matrix
from scipy.optimize import linprog

def solve_rows(lam,n,rows,useA=True,useB=True,sense='max'):
    """LP keeping only the constraint rows in `rows`."""
    lam=np.asarray(lam,float); N=len(lam)
    trip=list(itertools.combinations(range(N),3)); V=len(trip)
    rowset=set(rows); rmapA={}; rmapB={}; cnt=0
    if useA:
        for k in rows: rmapA[k]=cnt; cnt+=1
    if useB:
        for k in rows: rmapB[k]=cnt; cnt+=1
    ri=[];ci=[];dv=[]
    for t,(i,j,k) in enumerate(trip):
        for (a,b,c) in ((i,j,k),(j,i,k),(k,i,j)):
            if a not in rowset: continue
            if useA: ri.append(rmapA[a]); ci.append(t); dv.append(1.0)
            if useB: ri.append(rmapB[a]); ci.append(t); dv.append(lam[b]*lam[c])
    b=np.zeros(cnt)
    if useA:
        for k in rows: b[rmapA[k]]=n-2.0
    if useB:
        for k in rows:
            ri.append(rmapB[k]); ci.append(V); dv.append(-lam[k]); b[rmapB[k]]=-lam[k]**2
    A=coo_matrix((dv,(ri,ci)),shape=(cnt,V+1)).tocsr()
    c=np.zeros(V+1); c[V]=-1.0 if sense=='max' else 1.0
    r=linprog(c,A_eq=A,b_eq=b,bounds=[(0,None)]*V+[(None,None)],method='highs')
    return r
