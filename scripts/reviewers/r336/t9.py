import sys; sys.path.insert(0,'scripts/reviewers/r336')
import numpy as np, itertools
from scipy.optimize import linprog, minimize
n=6; N=15; tri=list(itertools.combinations(range(N),3)); V=len(tri)
memb=[[k for k,t in enumerate(tri) if a in t] for a in range(N)]
oth=[{k:[x for x in tri[k] if x!=a] for k in memb[a]} for a in range(N)]
M=1e4
def soft_lp(lam,sign=-1.0):
    """max theta with elastic equality slacks penalised; returns (theta, slack)."""
    nv=V+1+2*3*N
    rows=[];rhs=[];sl=0
    Aeq=np.zeros((3*N,nv)); beq=np.zeros(3*N)
    for a in range(N):
        for t,(kind) in enumerate(['A','B','C']):
            r=Aeq[3*a+t]
            for k in memb[a]:
                b,c=oth[a][k]
                if kind=='A': r[k]=1.0
                elif kind=='B': r[k]=lam[b]+lam[c]
                else: r[k]=lam[b]*lam[c]
            if kind=='A': beq[3*a+t]=n-2.0
            elif kind=='B': beq[3*a+t]=-2.0*lam[a]
            else: r[V]=-lam[a]; beq[3*a+t]=-lam[a]**2
            r[V+1+2*(3*a+t)]=1.0; r[V+1+2*(3*a+t)+1]=-1.0
    c=np.zeros(nv); c[V]=sign
    c[V+1:]=M
    bnds=[(0,None)]*V+[(None,None)]+[(0,None)]*(2*3*N)
    r=linprog(c,A_eq=Aeq,b_eq=beq,bounds=bnds,method='highs')
    if not r.success: return None,None
    return r.x[V], float(np.sum(r.x[V+1:]))
def neg(z):
    lam=z-z.mean(); nn=np.linalg.norm(lam)
    if nn<1e-9: return 1e6
    lam=lam/nn
    th,s=soft_lp(lam)
    if th is None: return 1e6
    return -(th-M*s)
np.random.seed(9336)
best=(-1e9,None)
for t in range(25):
    z0=np.random.randn(N)
    r=minimize(neg,z0,method='Nelder-Mead',options={'maxiter':3000,'maxfev':3000,'fatol':1e-10,'xatol':1e-9})
    if -r.fun>best[0]: best=(-r.fun,r.x)
val,z=best
lam=z-z.mean(); lam/=np.linalg.norm(lam); lam=np.sort(lam)
th,s=soft_lp(lam)
print('T9 free-spectrum n=6:  max theta = %.6f   (slack %.2e)   true max sqrt(3/2)=%.6f  theta0(6)=%.6f'
      %(th,s,np.sqrt(1.5),np.sqrt(2*5*4)/6))
print('optimal spectrum (sorted):'); print(np.round(lam,6))
print('sum=%.2e  norm=%.6f  lmin=%.6f lmax=%.6f  lmax/|lmin|=%.6f  (n-2=%d)'%(lam.sum(),np.linalg.norm(lam),lam[0],lam[-1],lam[-1]/abs(lam[0]),n-2))
np.save('scripts/reviewers/r336/optspec.npy',lam)
