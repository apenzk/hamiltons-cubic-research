import sys; sys.path.insert(0,'scripts/reviewers/r98')
import numpy as np, lib98 as L, itertools
rng=np.random.default_rng(97)

def eigenframe_T(W,n):
    M=L.to_M(W,n); M/=np.linalg.norm(M)
    lam,V=np.linalg.eigh(M)
    c=L.struct_consts(n)          # c[a,g,d]: [phi_g,phi_d] = sum_a c[a,g,d] phi_a
    # check total antisymmetry in the pair-orthonormal indexing
    asym=max(np.abs(c+np.transpose(c,(1,0,2))).max(), np.abs(c+np.transpose(c,(0,2,1))).max())
    cp=np.einsum('gde,ga,db,ec->abc',c,V,V,V,optimize=True)
    T=cp**2
    return lam,T,asym,M

for n in [4,5,6]:
    W=L.rand_weyl(n,rng)
    lam,T,asym,M=eigenframe_T(W,n)
    N=len(lam)
    sharpip=float(np.sum(L.sharp(M,n)*M))
    trip=sum(T[a,b,cc]*lam[a]*lam[b]*lam[cc] for a in range(N) for b in range(a+1,N) for cc in range(b+1,N))
    e1=lam.sum(); e3=sum(lam[a]*lam[b]*lam[cc] for a in range(N) for b in range(a+1,N) for cc in range(b+1,N))
    p3=float((lam**3).sum())
    print('n=%d N=%d  c totally-antisym dev=%.1e | <M#,M>=%.6f  3*sum T lll=%.6f (d=%.1e)'%(n,N,asym,sharpip,3*trip,sharpip-3*trip))
    print('    e1=%.1e  p3=%.6f  3e3=%.6f  2trM^3=%.6f  <M#,M>/trM^3=%.6f'%(e1,p3,3*e3,2*p3,sharpip/p3))
    off=[T[a,b,cc] for a in range(N) for b in range(a+1,N) for cc in range(b+1,N)]
    print('    T on triples: min=%.6f max=%.6f std=%.6f  CONSTANT=%s'%(min(off),max(off),float(np.std(off)),np.std(off)<1e-9))
    print('    sum_{a<b<c} T lll = %.6f   kappa*e3 with kappa=2 -> %.6f  (dev %.1e)'%(trip,2*e3,trip-2*e3))
