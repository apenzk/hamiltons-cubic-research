"""I122 screen (not evidence): sup of T(G) = 4 tr(Omega_G^3) over positive G on so(m) with |G|_F = 1, m = 4..7, seeded with the identity, the self-dual su(2) and random starts; finds 2/sqrt3 at every m. Run with sage -python."""
# Screen (not evidence): sup of T(G) = 4 tr(Omega_G^3), Omega_G = sum G_ab X_a (x) X_b, over PSD G on so(m) with |G|_F = 1.
import numpy as np, itertools
from scipy.optimize import minimize
def basis(m):
    B=[]
    for a,b in itertools.combinations(range(m),2):
        X=np.zeros((m,m)); X[a,b]=1; X[b,a]=-1; B.append(X/np.sqrt(2))
    return B
def T_of(Gm,B):
    Om=sum(Gm[i,j]*np.kron(B[i],B[j]) for i in range(len(B)) for j in range(len(B)) if abs(Gm[i,j])>0)
    Om=(Om+Om.T)/2; ev=np.linalg.eigvalsh(Om); return 4*np.sum(ev**3)
for m in (4,5,6,7):
    B=basis(m); D=len(B); rng=np.random.default_rng(m)
    Xs=np.array([b.ravel() for b in B])
    def G_from(z): L=z.reshape(D,D); G=L@L.T; return G/np.linalg.norm(G)
    def negT(z): return -T_of(G_from(z),B)
    starts=[np.eye(D).ravel()]+[rng.standard_normal(D*D) for _ in range(6)]
    # self-dual su(2) in the first four indices: Y_i = (X01+X23)/sqrt2 etc
    ix={p:i for i,p in enumerate(itertools.combinations(range(m),2))}
    sd=np.zeros((D,3)); 
    for k,(p,q,sg) in enumerate([((0,1),(2,3),1),((0,2),(1,3),-1),((0,3),(1,2),1)]): sd[ix[p],k]=1/np.sqrt(2); sd[ix[q],k]=sg/np.sqrt(2)
    Gsd=sd@sd.T; Gsd/=np.linalg.norm(Gsd)
    best=max(T_of(np.eye(D)/np.sqrt(D),B), T_of(Gsd,B)); print(f'm={m}: identity {T_of(np.eye(D)/np.sqrt(D),B):.4f}, self-dual su(2) {T_of(Gsd,B):.4f}')
    for z0 in starts+[np.linalg.cholesky(Gsd+1e-6*np.eye(D)).ravel()]:
        r=minimize(negT,z0,method='L-BFGS-B',options={'maxiter':300}); best=max(best,-r.fun)
    print(f'm={m}: screened sup T = {best:.4f}   (sqrt2 = 1.4142, needed <= 1.59)')
