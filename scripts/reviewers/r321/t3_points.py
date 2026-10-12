import numpy as np, sys
sys.path.insert(0,'scripts/reviewers/r321')
from core import *
from scipy.optimize import fsolve

def diag_crit_res(M):
    """off-diagonal residual of M^{o2} + M^2 - theta M, with theta read off."""
    return M*M + M@M

def c5_blowup():
    n=10
    # blocks {2i,2i+1}, i=0..4 ; C_5 adjacency on blocks
    blk = np.array([i//2 for i in range(n)])
    adjB = np.zeros((5,5),bool)
    for i in range(5):
        adjB[i,(i+1)%5]=adjB[(i+1)%5,i]=True
    def build(a,b,g):
        M=np.zeros((n,n))
        for i in range(n):
            for j in range(n):
                if i==j: continue
                if blk[i]==blk[j]: M[i,j]=a
                elif adjB[blk[i],blk[j]]: M[i,j]=b
                else: M[i,j]=g
        return M
    def res(x):
        a,g = x; b=-1.0
        M=build(a,b,g)
        N=diag_crit_res(M)
        th = N[0,2]/M[0,2]     # adjacent-block pair (block0,block1)
        return [M[0,:].sum(), N[0,1]-th*M[0,1]]
    sol = fsolve(res, [1.0,0.1], full_output=True)
    x=sol[0]; a,g=x; b=-1.0
    M=build(a,b,g)
    return M, n, blk, adjB

M,n,blk,adjB = c5_blowup()
print("C5 blow-up M row sum:", abs(M.sum(1)).max())
WB,_ = weyl_basis(n); C,P = struct(n); AD = ad_mats(C)
W = diag_weyl(M,n); W = W/np.linalg.norm(W)
th = P_func(W,AD)
print("theta =", th, " crit res =", np.linalg.norm(Q(W,AD)-th*W))
lam=np.linalg.eigvalsh(W)
print("dim m =", int((lam<-1e-10).sum()), " dim p =", int((lam>1e-10).sum()), " dim ker =", int((abs(lam)<1e-10).sum()))
print("distinct entries:", sorted(set(np.round(M[np.triu_indices(n,1)]/np.linalg.norm(np.array([M[i,j] for i in range(n) for j in range(i+1,n)])),8))))
np.save('/tmp/r321_c5.npy', W)
