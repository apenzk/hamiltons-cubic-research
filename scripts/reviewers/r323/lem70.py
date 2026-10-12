import sys; sys.path.insert(0,'scripts/reviewers/r323')
import numpy as np, core, math

def spec(ctx,W):
    lam,Phi=np.linalg.eigh(W)   # columns = eigenvectors
    return lam,Phi

def cmass(ctx,W,v,lam,Phi):
    """c_{vab} = <[v,phi_a],phi_b> in the eigenbasis; returns matrix c[a,b]"""
    A=core.ad_of(ctx,v)          # ad(v) in the standard basis
    Ae=Phi.T@A@Phi               # (Ae)_{b,a} = <ad(v)phi_a, phi_b> = c_{vab}
    return Ae.T                  # c[a,b]
def deficiency(ctx,W,v):
    lam,Phi=spec(ctx,W)
    c=cmass(ctx,W,v,lam,Phi); x=c**2
    lmin,lmax=lam[0],lam[-1]
    Dm = np.outer(lam,lam)-lmin*lmax
    D=0.5*float(np.sum(Dm*x))
    return D, float(np.sum(x)), lmin, lmax, lam, x, Dm

def report(ctx,W,name,nv=6,verbose=True):
    n=ctx.n
    th,res=core.crit_residual(ctx,W)
    W=W/np.sqrt(np.trace(W@W))
    lam,Phi=spec(ctx,W); lmin,lmax=lam[0],lam[-1]
    mult=int(np.sum(np.abs(lam-lmin)<1e-9))
    Emin=Phi[:,np.abs(lam-lmin)<1e-9]
    Emax=Phi[:,np.abs(lam-lmax)<1e-9]
    slack=lmin+(n-2)*lmax-th
    Ds=[];offs=[];tots=[]
    rng=np.random.default_rng(0)
    for k in range(nv):
        z=rng.normal(size=Emin.shape[1]); z/=np.linalg.norm(z)
        v=Emin@z
        D,tot,_,_,_,x,_=deficiency(ctx,W,v)
        # mass off Emin x Emax
        imin=np.abs(lam-lmin)<1e-9; imax=np.abs(lam-lmax)<1e-9
        on = x[np.ix_(imin,imax)].sum()+x[np.ix_(imax,imin)].sum()
        Ds.append(D); offs.append(tot-on); tots.append(tot)
    Ds=np.array(Ds)
    idcheck=max(abs(lmin+(n-2)*lmax-D/abs(lmin)-th) for D in Ds)
    if verbose:
        print(f'{name:28s} n={n} theta={th:.9f} res={res:.2e} lmin={lmin:.6f}(mult{mult}) lmax={lmax:.6f}')
        print(f'   slack={slack:.9f}  D range=[{Ds.min():.9f},{Ds.max():.9f}] spread={Ds.max()-Ds.min():.2e}'
              f'  D/|lmin|={Ds.mean()/abs(lmin):.9f}  identity residual={idcheck:.2e}')
        print(f'   total mass={tots[0]:.9f} (2(n-2)={2*(n-2)})  mass OFF EminxEmax={min(offs):.6f}..{max(offs):.6f}'
              f'  frac={np.mean(offs)/tots[0]:.9f}')
    return dict(theta=th,res=res,slack=slack,D=Ds.mean(),idres=idcheck,off=np.mean(offs),tot=tots[0],lmin=lmin,lmax=lmax,mult=mult)
