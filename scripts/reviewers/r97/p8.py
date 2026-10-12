import sys,itertools; sys.path.insert(0,'scripts/reviewers/r97')
import numpy as np
from weyl97 import *
SC='scratchpad'

def diag(n,seed):
    r=np.random.default_rng(seed)
    B=np.load(f'{SC}/wb{n}.npy'); M=np.tensordot(r.normal(size=len(B)),B,axes=1); M/=np.linalg.norm(M)
    lam,O=np.linalg.eigh(M)     # M = O diag(lam) O^T ; v_alpha = sum_a O[a,alpha] phi_a
    c=get_c(n)
    cp=np.einsum('abc,ai,bj,ck->ijk',c,O,O,O,optimize=True)
    T=cp**2
    N=len(lam)
    e1=lam.sum()
    p3=(lam**3).sum()
    e3=sum(lam[a]*lam[b]*lam[g] for a,b,g in itertools.combinations(range(N),3))
    S=sum(T[a,b,g]*lam[a]*lam[b]*lam[g] for a,b,g in itertools.combinations(range(N),3))
    th=theta(M,n)
    off=[T[a,b,g] for a,b,g in itertools.combinations(range(N),3)]
    nz=[x for x in off if abs(x)>1e-10]
    return dict(n=n,N=N,e1=e1,p3=p3,e3=e3,S=S,theta=th,check=p3+3*S-th,
                Tmin=min(off),Tmax=max(off),Tmean=np.mean(off),Tstd=np.std(off),
                nzero=len(off)-len(nz),ntot=len(off),kappa=S/e3 if abs(e3)>1e-12 else float('nan'))
for n in (4,5,6):
    for s in (11,12):
        d=diag(n,s)
        print(f"n={d['n']} N={d['N']} e1={d['e1']:.2e} theta={d['theta']:.6f} p3={d['p3']:.6f} 3p3={3*d['p3']:.6f} "
              f"p3+3S-theta={d['check']:.2e} S/e3={d['kappa']:.6f} (collapse wants 2) | T: min={d['Tmin']:.4f} max={d['Tmax']:.4f} "
              f"mean={d['Tmean']:.4f} std={d['Tstd']:.4f} zeros={d['nzero']}/{d['ntot']}")
