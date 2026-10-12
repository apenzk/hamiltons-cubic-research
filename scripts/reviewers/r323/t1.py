import sys; sys.path.insert(0,'scripts/reviewers/r323')
import numpy as np, core, math

def subalg_proj(ctx, mats):
    """orthogonal projector onto span of so(n) elements given as coefficient vectors"""
    A=np.array(mats).T
    Qm,_=np.linalg.qr(A)
    return Qm@Qm.T

def block_h(n,parts):
    """coefficient vectors for so(p1)+so(p2)+... block-diagonal subalgebra"""
    ctxP=core.pairs(n); pos={p:i for i,p in enumerate(ctxP)}
    vs=[]; off=0
    for p in parts:
        for i in range(off,off+p):
            for j in range(i+1,off+p):
                v=np.zeros(len(ctxP)); v[pos[(i,j)]]=1.0; vs.append(v)
        off+=p
    return vs

for n in [6,8,10]:
    c=core.Ctx(n); N=c.N; m=n//2
    for parts,name in [([m,m],'so(m)+so(m)'), ([2]*(n//2),'max torus')]:
        vs=block_h(n,parts); r=len(vs)
        Pi=subalg_proj(c,vs)
        W = Pi - (r/N)*np.eye(N)
        W = W/np.sqrt(np.trace(W@W))
        th,res=core.crit_residual(c,W)
        pred=(2/n)*math.sqrt(r*N/(N-r))
        dW=np.linalg.norm(W-core.proj_weyl(c,W))
        print(f'n={n} {name:12s} r={r:3d} theta={th:.9f} predL23={pred:.9f} res={res:.2e} distWeyl={dW:.2e}')
    print('   theta0 =', math.sqrt(2*(n-1)*(n-2))/n)
