import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys; sys.path.insert(0,_os.path.join(_ROOT, 'scripts/reviewers/r102'))
import numpy as np, core, models, schurhorn
rng=np.random.default_rng(91)
n=12; N1=n*(n-1)//2; N2=n*(n+1)//2-1
P=core.pairs(n)
Qm,_=np.linalg.qr(np.concatenate([np.ones((n,1))/np.sqrt(n),np.eye(n)[:,1:]],axis=1)); V=Qm[:,1:].T
def rand_K(rng):
    A=rng.standard_normal((n,n)); A=(A+A.T)/2; np.fill_diagonal(A,0.0)
    # project to zero row sums within hollow symmetric
    for _ in range(400):
        r=A.sum(1); A=A-(np.add.outer(r,r))/(n-2)+ (r.sum()/((n-1)*(n-2)))*np.ones((n,n))
        np.fill_diagonal(A,0.0)
        if np.abs(A.sum(1)).max()<1e-12: break
    return A
def relax(K):
    dphi=np.array([K[i,j] for (i,j) in P])
    dful=np.concatenate([dphi,np.linalg.eigvalsh(-V@K@V.T)])
    a=schurhorn.cube_opt(dphi,N1,1.0,+1,rng,tries=5)
    b=schurhorn.cube_opt(dful,N2,3.0,-1,rng,tries=5)
    if a is None or b is None: return None
    return 1.5*a+0.5*(-b)
Ksp=core.vertex_K(models.sphere_product(6,6)[0])
for s in (12/182, 0.2, 0.5, 1.0, 1.5, 1.9, 2.0):
    vals=[]
    for t in range(14):
        K=rand_K(rng); K=K*np.sqrt(s)/np.linalg.norm(K)
        v=relax(K)
        if v is not None: vals.append(v)
    v0=relax(Ksp*np.sqrt(s)/np.linalg.norm(Ksp))
    print(f's={s:.4f}  worst(random K, 14 draws)={max(vals):.4f}  best={min(vals):.4f}  scaled-sphere-K={v0:.4f}',flush=True)
