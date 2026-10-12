import sys, os
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np, itertools, core, points, walk, diagcrit
rng=np.random.default_rng(1)
ns=[6,7,8]; best=None
for trial in range(300):
    n=ns[trial%len(ns)]
    M,th,res,ier=diagcrit.find_diag_critical(n,rng)
    if ier!=1 or res>1e-10 or th<=1e-6: continue
    W=points.diagW(n,M); lam,Phi,C=walk.walk_data(n,W)
    b,m,p,z=walk.blocks(lam,C); Smmm,Smpp,c=walk.S_tensors(n,lam,Phi)
    mult=int((np.abs(lam-lam[0])<1e-9).sum())
    if mult==1 and b['mm']<1e-14 and Smmm>1 and b['pp']<1e-14 and Smpp>1 and b['dimz']==0:
        best=(n,M.copy(),th,b,Smmm,Smpp,lam); break
n,M,th,b,Smmm,Smpp,lam=best
W=points.diagW(n,M)
Q=core.Qop(n,W); th2=core.frob(W,Q)
print('n',n)
print('M ='); print(np.array2string(M,precision=12,suppress_small=False))
print('theta (full Weyl machinery) = %.12f'%th2)
print('|W|=%.12f  criticality residual in Weyl_n |Q(W)-theta W| = %.3e'%(np.linalg.norm(W),np.linalg.norm(Q-th2*W)))
print('Ric(W) %.2e  Bianchi(W) %.2e  |Q-P_Weyl Q| %.2e'%(np.abs(core.ricci(n,W)).max(),np.abs(core.bianchi_defect(n,W)).max(),np.linalg.norm(Q-core.wproj(n,Q))))
print('lam_min=%.12f  multiplicity %d   dim m=%d dim p=%d dim ker=%d'%(lam[0],int((np.abs(lam-lam[0])<1e-9).sum()),b['dimm'],b['dimp'],b['dimz']))
print('mass=%.12f  2(n-2)=%d'%(b['mass'],2*(n-2)))
sh=core.sharp(n,W); lamW,U=np.linalg.eigh(W); u0=U[:,0]
print('<v,W#v> = %.12f   lam_min(theta-lam_min) = %.12f'%(u0@sh@u0, lam[0]*(th2-lam[0])))
print('BLOCKS  mm=%.3e   mp=%.12f   pp=%.3e   sum=%.12f'%(b['mm'],b['mp'],b['pp'],b['mm']+b['mp']+b['pp']))
print('S_mmm=%.6f   S_mpp=%.6f'%(Smmm,Smpp))
neg=[(i,j) for i,j in core.pairs(n) if M[i,j]<-1e-9]
pos=[(i,j) for i,j in core.pairs(n) if M[i,j]>1e-9]
tri=[t for t in itertools.combinations(range(n),3) if all((min(a,b),max(a,b)) in set(neg) for a,b in itertools.combinations(t,2))]
e0=min(core.pairs(n),key=lambda e:M[e])
print('negative graph edges',neg)
print('negative triangles',tri)
print('lam_min edge',e0,'weight %.9f'%M[e0])
print('vertices k with both (i,k),(j,k) negative:',[k for k in range(n) if k not in e0 and (min(e0[0],k),max(e0[0],k)) in set(neg) and (min(e0[1],k),max(e0[1],k)) in set(neg)])
print('vertices k with both (i,k),(j,k) positive:',[k for k in range(n) if k not in e0 and (min(e0[0],k),max(e0[0],k)) in set(pos) and (min(e0[1],k),max(e0[1],k)) in set(pos)])
np.save('/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/cex_M.npy',M)
