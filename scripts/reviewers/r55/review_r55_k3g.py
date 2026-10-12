"""What ARE the 20 excess directions?  Are they inside the diagonal locus?"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r55_core import *
from review_r55_k3b import build
n=10
s=build(); half=s['half']; Oh=s['Oh']; B=s['B']; Bf=s['Bf']; W=s['W']
K=half.shape[1]
Ex=np.eye(K)-Oh@Oh.T; u_,sv_,_=np.linalg.svd(Ex); Exb=u_[:,sv_>1e-8]
exc = half@Exb                       # (D,20) coefficient columns
# diagonal Weyl subspace, in Weyl coordinates
prs=pairs_of(n); N=len(prs)
diagvecs=[]
for a in range(N):
    E=np.zeros((N,N)); E[a,a]=1.0
    diagvecs.append(Bf@E.ravel())
Dg=np.array(diagvecs)
Qd,_=np.linalg.qr(Dg.T)              # basis of Pi_Weyl(diagonal ops)
print(f"dim of Weyl-projected coordinate-diagonal space = {np.linalg.matrix_rank(Dg, tol=1e-9)}")
cos=np.linalg.svd(Qd.T@exc, compute_uv=False)
print(f"principal cosines excess vs diagonal locus: {np.round(cos,6)}")
cos2=np.linalg.svd(Qd.T@(half@Oh), compute_uv=False)
print(f"principal cosines orbit  vs diagonal locus: max {cos2.max():.6f}")
# block structure of the excess: how much mass on each type of coordinate 2-plane
lab=sum([[a]*2 for a in range(5)],[])
G=[[0]*5 for _ in range(5)]
for a in range(5): G[a][(a+1)%5]=G[(a+1)%5][a]=1
kinds={'same block':[], 'C5-adjacent':[], 'C5-non-adjacent':[]}
for i,(p,q) in enumerate(prs):
    a,b=lab[p],lab[q]
    kinds['same block' if a==b else ('C5-adjacent' if G[a][b] else 'C5-non-adjacent')].append(i)
mats=np.einsum('dk,dij->kij', exc, B)
print("\nmass distribution of the 20 excess directions over Lambda^2 x Lambda^2 blocks:")
tot=(mats**2).sum()
for nm1,I in kinds.items():
    for nm2,J in kinds.items():
        mass=(mats[:,np.ix_(I,J)[0][:,None],np.ix_(I,J)[1]]**2).sum() if False else (mats[np.ix_(range(20),I,J)]**2).sum()
        if mass/tot>1e-6: print(f"   {nm1:>17} x {nm2:<17} {mass/tot:8.4f}")
diagmass=sum(float((mats[:,a,a]**2).sum()) for a in range(N))
print(f"   diagonal entries of the 45x45 matrices carry {diagmass/tot:.6f} of the mass")
