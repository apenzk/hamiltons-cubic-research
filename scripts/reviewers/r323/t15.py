import sys; sys.path.insert(0,'scripts/reviewers/r323')
import numpy as np, core, lem70, math
from t2 import W_of, block_h
def u_m(ctx):
    """u(m) inside so(2m): elements commuting with J"""
    n=ctx.n; m=n//2
    J=np.zeros((n,n))
    for i in range(m): J[2*i,2*i+1]=1; J[2*i+1,2*i]=-1
    vs=[]
    for a in range(ctx.N):
        pass
    # build the commutant as a subspace of so(n) in coefficient form
    M=np.zeros((ctx.N,ctx.N))
    for a in range(ctx.N):
        A=ctx.B[a]; C=A@J-J@A
        M[:,a]=[0.5*np.trace(ctx.B[b].T@C) for b in range(ctx.N)]
    u,s,vt=np.linalg.svd(M)
    ns=vt[np.sum(s>1e-9):]
    return [ns[i] for i in range(ns.shape[0])]
ctx={n:core.Ctx(n) for n in [6,8,10,12]}
print('--- other members of the subalgebra family ---')
for n in [6,8,10,12]:
    vs=u_m(ctx[n]); W=W_of(ctx[n],vs)
    th,res=core.crit_residual(ctx[n],W)
    print(f'u({n//2}) in so({n}): dim={len(vs)} theta={th:.9f} criticality residual={res:.3e}')
for n,parts in [(8,[3,5]),(10,[4,6]),(10,[3,7]),(12,[5,7]),(12,[4,8]),(12,[3,3,3,3]),(12,[4,4,4]),(9,[3,3,3])]:
    if n not in ctx: ctx[n]=core.Ctx(n)
    W=W_of(ctx[n],block_h(n,parts)); th,res=core.crit_residual(ctx[n],W)
    lam=np.linalg.eigvalsh(W); slack=lam[0]+(n-2)*lam[-1]-th
    tag='CRITICAL' if res<1e-9 else 'not critical'
    print(f'so{parts} in so({n}): theta={th:.9f} res={res:.3e} [{tag}] slack={slack:.9f}')
