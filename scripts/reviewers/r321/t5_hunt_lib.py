import numpy as np, itertools
from scipy.optimize import least_squares
def proj_V(G,n):
    gens=[]
    for i in range(n):
        D=np.zeros((n,n)); D[i,i]=1.0; gens.append(D)
    for i in range(n):
        e=np.zeros(n); e[i]=1.0
        gens.append(np.outer(np.ones(n),e)+np.outer(e,np.ones(n)))
    A=np.array([g.reshape(-1) for g in gens]).T
    x,_,_,_=np.linalg.lstsq(A,G.reshape(-1),rcond=None)
    return G-(A@x).reshape(n,n)
def vec(M,n):
    return M[np.triu_indices(n,1)]
def unvec(x,n):
    M=np.zeros((n,n)); M[np.triu_indices(n,1)]=x; return M+M.T
def resid(x,n):
    M=unvec(x,n); N=M*M+M@M
    th=float((N*M).sum())/float((M*M).sum())
    return np.concatenate([vec(proj_V(N,n)-th*M,n),[ (M*M).sum()-2.0 ]])
def find_crit(n,rng,tries):
    out=[]
    for t in range(tries):
        M0=proj_V(unvec(rng.standard_normal(n*(n-1)//2),n),n); M0*=np.sqrt(2.0/(M0*M0).sum())
        s=least_squares(resid,vec(M0,n),args=(n,),xtol=1e-14,ftol=1e-14,gtol=1e-14,max_nfev=3000)
        if s.cost<1e-20:
            M=unvec(s.x,n)
            if np.abs(M).max()>1e-6: out.append(M)
    return out
