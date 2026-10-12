import sys; sys.path.insert(0,'scripts/reviewers/r323')
import numpy as np, core, math, lem70

def block_h(n,parts):
    P=core.pairs(n); pos={p:i for i,p in enumerate(P)}
    vs=[];off=0
    for p in parts:
        for i in range(off,off+p):
            for j in range(i+1,off+p):
                v=np.zeros(len(P)); v[pos[(i,j)]]=1.0; vs.append(v)
        off+=p
    return vs
def subalg_proj(ctx,mats):
    A=np.array(mats).T; Qm,_=np.linalg.qr(A); return Qm@Qm.T
def W_of(ctx,vs):
    r=len(vs); Pi=subalg_proj(ctx,vs); W=Pi-(r/ctx.N)*np.eye(ctx.N)
    return W/np.sqrt(np.trace(W@W))
if __name__=='__main__':
    for n in [6,8,10,12]:
        c=core.Ctx(n); m=n//2
        lem70.report(c,W_of(c,block_h(n,[m,m])),f'so({m})+so({m})')
        lem70.report(c,W_of(c,block_h(n,[2]*(n//2))),'max torus')
        print()
