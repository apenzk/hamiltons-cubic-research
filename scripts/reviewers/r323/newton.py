import sys; sys.path.insert(0,'scripts/reviewers/r323')
import numpy as np, core

def coeffs(ctx,W): return np.einsum('kab,ab->k',ctx.W,W)
def mat(ctx,z):   return np.einsum('k,kab->ab',z,ctx.W)

def sharp_bil(ctx,X,Y):
    U=np.einsum('adc,ce->ade',ctx.ad,X); V=np.einsum('adc,ce->ade',ctx.ad,Y)
    return -0.25*(np.einsum('ade,bed->ab',U,V)+np.einsum('ade,bed->ab',V,U))

def jac(ctx,z):
    """vectorised: J[:,k] = coeffs(DQ(W)[B_k])"""
    W=mat(ctx,z); B=ctx.W                       # (d,N,N)
    lin = np.einsum('ac,kcb->kab',W,B)+np.einsum('kac,cb->kab',B,W)
    U=np.einsum('adc,ce->ade',ctx.ad,W)         # ad_a W
    V=np.einsum('adc,kce->kade',ctx.ad,B)       # ad_a B_k
    sb = -0.5*(np.einsum('ade,kbed->kab',U,V)+np.einsum('kade,bed->kab',V,U))
    DQ = lin+sb
    return np.einsum('jab,kab->jk',B,DQ)

def solve(ctx,z0,iters=60,tol=1e-14):
    z=z0/np.linalg.norm(z0); d=len(z)
    for it in range(iters):
        W=mat(ctx,z); q=coeffs(ctx,core.Qmap(ctx,W)); th=float(z@q)
        F=np.concatenate([q-th*z,[0.0]])
        if np.linalg.norm(F)<tol: break
        Jf=jac(ctx,z)
        M=Jf-th*np.eye(d)-np.outer(z, q + Jf.T@z)
        A=np.vstack([M,2*z])
        dz,*_=np.linalg.lstsq(A,-F,rcond=None)
        base=np.linalg.norm(q-th*z); s=1.0; zn=z
        for _ in range(20):
            zt=(z+s*dz); zt/=np.linalg.norm(zt)
            Wt=mat(ctx,zt); qt=coeffs(ctx,core.Qmap(ctx,Wt)); tht=float(zt@qt)
            if np.linalg.norm(qt-tht*zt)<base: zn=zt; break
            s*=0.5
        else: zn=(z+dz); zn/=np.linalg.norm(zn)
        z=zn
    W=mat(ctx,z); W/=np.sqrt(np.trace(W@W))
    th,res=core.crit_residual(ctx,W)
    return W,th,res
