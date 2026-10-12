import sys; sys.path.insert(0,'scripts/reviewers/r323')
import numpy as np, core, lem70, math
def sphere_product(n,p):
    """diagonal M: within-block a_A, a_B, cross b, row sums 0, unit norm"""
    q=n-p
    # unknowns a,b,c(within A, within B, cross); rows: (p-1)a + q c =0 ; (q-1)b + p c = 0
    c_=1.0; a=-q*c_/(p-1) if p>1 else 0.0; b=-p*c_/(q-1) if q>1 else 0.0
    M=np.zeros((n,n))
    for i in range(n):
        for j in range(n):
            if i==j: continue
            if i<p and j<p: M[i,j]=a
            elif i>=p and j>=p: M[i,j]=b
            else: M[i,j]=c_
    return M
def diag_to_W(ctx,M):
    W=np.zeros((ctx.N,ctx.N)); pos={p:i for i,p in enumerate(ctx.P)}
    for (i,j),k in pos.items(): W[k,k]=M[i,j]
    return W/np.sqrt(np.trace(W@W))
ctx={n:core.Ctx(n) for n in [6,8,10,12]}
print('--- sphere products S^p x S^q (diagonal) ---')
for n in [6,8,10,12]:
    for p in range(2,n//2+1):
        M=-sphere_product(n,p); W=diag_to_W(ctx[n],M)
        lem70.report(ctx[n],W,f'S^{p} x S^{n-p}',nv=3)
