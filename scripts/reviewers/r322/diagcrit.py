import sys, os
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np, itertools, core, points
from scipy.optimize import fsolve

def diag_space(n):
    """orthonormal basis of {sym n x n, zero diagonal, zero row sums}, as matrices."""
    E=[]
    for i,j in core.pairs(n):
        M=np.zeros((n,n)); M[i,j]=M[j,i]=1.0; E.append(M)
    E=np.array(E)
    # project out the (a_i+a_j) directions
    A=[]
    for i in range(n):
        M=np.zeros((n,n)); M[i,:]=1.0; M[:,i]+=1.0; np.fill_diagonal(M,0.0); A.append(M)
    A=np.array(A)
    G=np.einsum('kij,lij->kl',A,A)
    P=np.einsum('kij,lij->kl',E,A)
    coef=np.linalg.pinv(G)@P.T
    B=E-np.einsum('lk,lij->kij',coef,A)
    # orthonormalise
    Bf=B.reshape(len(B),-1)
    u,s,vt=np.linalg.svd(Bf,full_matrices=False)
    r=int((s>1e-10*s[0]).sum())
    out=vt[:r].reshape(r,n,n)
    return out

def find_diag_critical(n, rng, tries=1):
    Bs=diag_space(n); d=len(Bs)
    def unpack(x):
        M=np.einsum('k,kij->ij',x[:d],Bs); return M,x[d]
    def F(x):
        M,th=unpack(x)
        Qm=points.ricci_free_M(n,M*M+M@M)
        r=[float(np.sum(Bs[k]*(Qm-th*M))) for k in range(d)]
        r.append(np.sum(M*M)/2-1.0)
        return r
    x0=np.concatenate([rng.normal(size=d),[rng.normal()]])
    sol,info,ier,msg=fsolve(F,x0,full_output=True)
    M,th=unpack(sol)
    return M,th,float(np.max(np.abs(F(sol)))),ier
