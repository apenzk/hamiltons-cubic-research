"""Reviewer 326 -- independent build of the 'diagonal criticality' LP.

Variables: T_{k,al,be} >= 0 on unordered triples of DISTINCT eigenvector indices
(totally symmetric, vanishing on repeats), plus the free scalar theta.
Constraints, one pair per eigen-index k = 1..N:
   (A)  sum_{al<be}                T_{k,al,be} = n-2
   (B)  sum_{al<be} lam_al lam_be  T_{k,al,be} = lam_k (theta - lam_k)
Objective: max / min theta.
"""
import numpy as np, itertools
from scipy.sparse import coo_matrix
from scipy.optimize import linprog

def build(lam, n):
    N=len(lam); trip=list(itertools.combinations(range(N),3)); V=len(trip)
    ri=[];ci=[];dv=[]
    for t,(i,j,k) in enumerate(trip):
        for (a,b,c) in ((i,j,k),(j,i,k),(k,i,j)):
            ri.append(a);        ci.append(t); dv.append(1.0)          # (A) row a
            ri.append(N+a);      ci.append(t); dv.append(lam[b]*lam[c])# (B) row a
    for a in range(N):
        ri.append(N+a); ci.append(V); dv.append(-lam[a])               # -lam_k theta
    A=coo_matrix((dv,(ri,ci)),shape=(2*N,V+1)).tocsr()
    b=np.concatenate([np.full(N,n-2.0), -lam**2])
    return A,b,V,trip

def solve(lam,n,sense='max'):
    A,b,V,trip=build(np.asarray(lam,float),n)
    c=np.zeros(V+1); c[V]= -1.0 if sense=='max' else 1.0
    bounds=[(0,None)]*V+[(None,None)]
    r=linprog(c,A_eq=A,b_eq=b,bounds=bounds,method='highs')
    return r

def decoupled(lam,n):
    """Row-by-row relaxation (drop total symmetry of T): closed form.
    Row k gives theta in [l_k,u_k] with l,u from the extreme products lam_al lam_be
    over pairs of distinct indices both != k."""
    lam=np.asarray(lam,float); N=len(lam)
    lo,hi=-np.inf,np.inf; who_hi=None; who_lo=None
    for k in range(N):
        rest=np.delete(lam,k)
        prods=np.outer(rest,rest); iu=np.triu_indices(len(rest),1)
        pmin,pmax=prods[iu].min(),prods[iu].max()
        if abs(lam[k])<1e-14:
            continue
        A=lam[k]+(n-2)*pmin/lam[k]; B=lam[k]+(n-2)*pmax/lam[k]
        a,bb=min(A,B),max(A,B)
        if bb<hi: hi,who_hi=bb,k
        if a>lo:  lo,who_lo=a,k
    return lo,hi,who_lo,who_hi
