"""Screen: positive-definite #-idempotents on the torus family of sp(3), built as the commutant of right
quaternion multiplication in so(12) (I117, R48). 400 starts near I/c, each solution with its norm and its
stability on Sym^2 sp(3). Run: sage -python scripts/misc/screen_I117_sp3_torus.py   (seconds)
"""
import itertools, numpy as np
from scipy.linalg import null_space
from scipy.optimize import least_squares
k=3; m=4*k
P=list(itertools.combinations(range(m),2)); N=len(P); E=[]
for (i,j) in P:
    X=np.zeros((m,m)); X[i,j]=1; X[j,i]=-1; E.append(X)
# right multiplication by quaternion units j, kk on H^k = R^{4k}: blocks (1,i,j,k) per quaternion coordinate
def qmat(which):
    # right multiplication x -> x*q on H in basis (1,i,j,k)
    if which=='j': Mq=np.array([[0,0,-1,0],[0,0,0,1],[1,0,0,0],[0,-1,0,0]],float)
    if which=='k': Mq=np.array([[0,0,0,-1],[0,0,-1,0],[0,1,0,0],[1,0,0,0]],float)
    if which=='i': Mq=np.array([[0,-1,0,0],[1,0,0,0],[0,0,0,-1],[0,0,1,0]],float)
    return np.kron(np.eye(k),Mq)
Rj,Rk=qmat('j'),qmat('k')
cond=np.array([np.concatenate([(X@Rj-Rj@X).ravel(),(X@Rk-Rk@X).ravel()]) for X in E]).T
sp=null_space(cond); d=sp.shape[1]; assert d==k*(2*k+1), d
Bm=[sum(sp[t,a]*E[t] for t in range(N)) for a in range(d)]
cg=np.array([[[0.5*np.sum((Bm[a]@Bm[b]-Bm[b]@Bm[a])*Bm[g]) for g in range(d)] for b in range(d)] for a in range(d)])
def sh(A,B):
    AXB=np.einsum('ge,aed,dz->agz',A,cg,B,optimize=True)
    return 0.5*np.einsum('agz,bgz->ab',AXB,cg,optimize=True)
I=np.eye(d); cI=np.trace(sh(I,I))/d; print('sp(%d): d'%k,d,'c',round(cI,6),'d/c^2',round(d/cI**2,6))
rng=np.random.default_rng(0)
ad=lambda y: np.einsum('a,abg->gb',y,cg)
x=rng.standard_normal(d); cent=null_space(ad(x)); assert cent.shape[1]==k
basis=[]
for i in range(d):
    for j in range(i,d):
        S=np.zeros((d,d)); S[i,j]=S[j,i]=1; basis.append(S)
M=np.array([np.concatenate([(S@ad(cent[:,t])-ad(cent[:,t])@S).ravel() for t in range(k)]) for S in basis]).T
K=null_space(M); fam=[sum(K[q,t]*basis[q] for q in range(len(basis))) for t in range(K.shape[1])]
Q,_=np.linalg.qr(np.array([F.ravel() for F in fam]).T); fam=[Q[:,t].reshape(d,d) for t in range(Q.shape[1])]
print('torus family dimension',len(fam))
Cof=lambda y: sum(y[t]*fam[t] for t in range(len(fam)))
res=lambda y:(sh(Cof(y),Cof(y))-Cof(y)).ravel()
y0c=np.array([np.sum(fam[t]*(I/cI)) for t in range(len(fam))])
sols={}
for trial in range(400):
    r=least_squares(res,y0c*(1+0.6*rng.standard_normal(len(fam))),max_nfev=300,xtol=1e-15,ftol=1e-15,gtol=1e-15)
    if np.linalg.norm(r.fun)<1e-10:
        C=Cof(r.x)
        if np.linalg.eigvalsh(C)[0]>1e-8: sols.setdefault(round(np.sum(C*C),7),C)
OB=[]
for i in range(d):
    for j in range(i,d):
        S=np.zeros((d,d))
        if i==j: S[i,i]=1
        else: S[i,j]=S[j,i]=1/np.sqrt(2)
        OB.append(S)
for q,C in sorted(sols.items()):
    Mx=np.array([[np.sum(sh(C,Sb)*Sa) for Sb in OB] for Sa in OB])
    cv=np.array([np.sum(C*Sa) for Sa in OB]); cv/=np.linalg.norm(cv)
    Pp=np.eye(len(OB))-np.outer(cv,cv); top=np.max(np.linalg.eigvalsh(Pp@Mx@Pp))
    print(f'  |C|^2 = {q:.6f} (d/c^2 = {d/cI**2:.6f}): top eigenvalue on C-perp {top:.6f}')
