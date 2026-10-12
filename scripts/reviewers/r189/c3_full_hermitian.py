"""C3: drop the block-diagonal restriction.  run_n5_certificate.py tests only
Hermitian forms supported on the diagonal blocks (89 real unknowns); a general
Hermitian form on the 41 covariants has 41^2 = 1681.  Test the full system."""
import sys, os, time, numpy as np
d=os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0,d); sys.path.insert(0,os.path.join(d,"..","r179"))
import core, weyl_invariants as WI
p=core.P; NV=core.NV
UNK=[]
for i in range(NV):
    UNK.append((i,i,'re'))
    for j in range(i+1,NV):
        UNK.append((i,j,'re')); UNK.append((i,j,'im'))
print(f"full Hermitian unknowns: {len(UNK)}",flush=True)
NPTS=int(sys.argv[1]) if len(sys.argv)>1 else 1750
rows=np.zeros((NPTS,len(UNK)+1),dtype=np.int64)
t0=time.time()
for s in range(NPTS):
    W=WI.random_weyl(5,p,np.random.default_rng(10000+s))
    pv=core.allP(W)
    r=[]
    for (i,j,part) in UNK:
        z=core.gmul(pv[i],core.gconj(pv[j]))
        if i==j: r.append(z[0]%p)
        elif part=='re': r.append(2*z[0]%p)
        else: r.append((-2*z[1])%p)
    r.append(core.F5(W))
    rows[s]=r
    if (s+1)%250==0: print(f"  {s+1}/{NPTS} pts  {time.time()-t0:.0f}s",flush=True)

def rank(M,ncols):
    M=M[:,:ncols].copy()%p
    nr=M.shape[0]; r=0
    for c in range(ncols):
        nz=np.nonzero(M[r:,c])[0]
        if len(nz)==0: continue
        piv=r+nz[0]
        if piv!=r: M[[r,piv]]=M[[piv,r]]
        M[r]=M[r]*pow(int(M[r,c]),p-2,p)%p
        col=M[:,c].copy(); col[r]=0
        nzr=np.nonzero(col)[0]
        if len(nzr): M[nzr]=(M[nzr]-np.outer(col[nzr],M[r]))%p
        r+=1
        if r==nr: break
    return r
n=len(UNK)
rA=rank(rows,n); print(f"coefficient rank (full Hermitian): {rA} of {n}",flush=True)
rAug=rank(rows,n+1); print(f"augmented rank: {rAug}",flush=True)
print(f"CONSISTENT: {rA==rAug}")
print(f"total {time.time()-t0:.0f}s")
