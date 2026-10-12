import sys, time
sys.path.insert(0,'scripts/reviewers/r97')
import numpy as np
from weyl97 import *
for n in range(4,9):
    t0=time.time()
    B = weyl_basis(n)
    d = n*(n+1)*(n+2)*(n-3)//12
    print(f"n={n} dim(basis)={len(B)} expected={d} time={time.time()-t0:.1f}s")
    # verify a random element satisfies all symmetries
    rng=np.random.default_rng(7)
    M = np.tensordot(rng.normal(size=len(B)), B, axes=1)
    W = M_to_W(M,n)
    e1 = np.abs(W+np.transpose(W,(1,0,2,3))).max()
    e2 = np.abs(W-np.transpose(W,(2,3,0,1))).max()
    e3 = np.abs(W+np.einsum('jkil->ijkl',W)+np.einsum('kijl->ijkl',W)).max()
    e4 = np.abs(np.einsum('ikjk->ij',W)).max()
    print(f"   antisym={e1:.2e} pairsym={e2:.2e} bianchi={e3:.2e} trace={e4:.2e}")
    np.save(f'scratchpad/wb{n}.npy', B)
