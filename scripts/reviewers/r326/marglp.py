"""Reviewer 326 -- independent build of post 41's marginal LP, plus the repaired version."""
import numpy as np, itertools
from scipy.sparse import coo_matrix
from scipy.optimize import linprog

def marginal_lp(lam, n, first_moment=False):
    """min sum_{a<b} lam_a lam_b C_ab  s.t. C>=0 symmetric hollow,
       sum_{a<b} C_ab = n-2, row sums sum_b C_ab <= 2.
       first_moment=True adds the proved Weyl identity sum_a lam_a m_a = -2 lam_min."""
    lam=np.asarray(lam,float); N=len(lam)
    P=[(a,b) for a in range(N) for b in range(a+1,N)]; V=len(P)
    obj=np.array([lam[a]*lam[b] for a,b in P])
    # equality: total
    ri=[];ci=[];dv=[]
    for t,(a,b) in enumerate(P):
        ri.append(0); ci.append(t); dv.append(1.0)
    beq=[n-2.0]
    if first_moment:
        for t,(a,b) in enumerate(P):
            ri.append(1); ci.append(t); dv.append(lam[a]+lam[b])
        beq.append(-2.0*lam.min())
    Aeq=coo_matrix((dv,(ri,ci)),shape=(len(beq),V)).tocsr()
    # inequality: row sums <= 2
    ri=[];ci=[];dv=[]
    for t,(a,b) in enumerate(P):
        ri.append(a); ci.append(t); dv.append(1.0)
        ri.append(b); ci.append(t); dv.append(1.0)
    Aub=coo_matrix((dv,(ri,ci)),shape=(N,V)).tocsr()
    bub=np.full(N,2.0)
    r=linprog(obj,A_ub=Aub,b_ub=bub,A_eq=Aeq,b_eq=beq,bounds=[(0,None)]*V,method='highs')
    return r

def theta_bound(lam,n,first_moment=False):
    lam=np.asarray(lam,float); lmin=lam.min()
    r=marginal_lp(lam,n,first_moment)
    if r.status!=0: return None,r
    return lmin + r.fun/lmin, r
