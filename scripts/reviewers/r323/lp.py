import sys; sys.path.insert(0,'scripts/reviewers/r323')
import numpy as np
from scipy.optimize import linprog

def lp_min_D(lam, n, rowcap=2.0, use_marg=True):
    """min D over x>=0 symmetric with total mass 2(n-2), row caps, and the Weyl marginal identity."""
    mu,idx=np.unique(np.round(lam,10),return_inverse=True)
    d=np.array([np.sum(idx==i) for i in range(len(mu))],dtype=float)
    k=len(mu); lmin,lmax=mu[0],mu[-1]
    # variables y_ij for i<=j (block masses, ordered-pair convention: y counts BOTH (i,j) and (j,i) when i!=j)
    var=[(i,j) for i in range(k) for j in range(i,k)]
    def mass(i,j): return 1.0 if i==j else 2.0   # ordered-pair mass carried by block var
    cobj=np.array([0.5*(mu[i]*mu[j]-lmin*lmax)*mass(i,j) for (i,j) in var])
    Aeq=[];beq=[]
    Aeq.append([mass(i,j) for (i,j) in var]); beq.append(2*(n-2))
    if use_marg:
        Aeq.append([ (mu[i]+mu[j]) if i!=j else mu[i] for (i,j) in var ]); beq.append(-2*lmin)
    Aub=[];bub=[]
    for r in range(k):
        row=[]
        for (i,j) in var:
            if i==j==r: row.append(1.0)
            elif i==r or j==r: row.append(1.0)
            else: row.append(0.0)
        Aub.append(row); bub.append(rowcap*d[r])
    res=linprog(cobj,A_ub=np.array(Aub),b_ub=np.array(bub),A_eq=np.array(Aeq),b_eq=np.array(beq),bounds=[(0,None)]*len(var),method='highs')
    return res
