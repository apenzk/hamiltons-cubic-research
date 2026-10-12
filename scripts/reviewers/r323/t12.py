import sys; sys.path.insert(0,'scripts/reviewers/r323')
import numpy as np, core, lem70, math
def pad(Wk,k,n,ctxn):
    Pk=core.pairs(k); Pn=core.pairs(n); posn={p:i for i,p in enumerate(Pn)}
    W=np.zeros((ctxn.N,ctxn.N))
    for a,pa in enumerate(Pk):
        for b,pb in enumerate(Pk):
            W[posn[pa],posn[pb]]=Wk[a,b]
    return W/np.sqrt(np.trace(W@W))
ctx={n:core.Ctx(n) for n in [6,8,10]}
Wcp3=np.load('scripts/data/review_r40_W_cpm3.npy'); Wcp3=0.5*(Wcp3+Wcp3.T)
for n in [8,10]:
    W=pad(Wcp3,6,n,ctx[n])
    print('padded CP^3 into n=%d: distWeyl=%.2e'%(n,np.linalg.norm(W-core.proj_weyl(ctx[n],W))))
    lem70.report(ctx[n],W,f'padded CP^3 -> n={n}',nv=4)
# padded balanced product
from t11 import sphere_product,diag_to_W
M=-sphere_product(6,3); W6=diag_to_W(ctx[6],M)
for n in [8,10]:
    W=pad(W6,6,n,ctx[n]); lem70.report(ctx[n],W,f'padded S3xS3 -> n={n}',nv=4)
